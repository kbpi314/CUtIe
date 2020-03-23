#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
Created on Fri Jan 27 16:59:38 2017

@author: Nan
"""
import numpy as np
import os 
import pandas as pd
import matplotlib.pyplot as plt
import collections
import click
import seaborn as sns

"""this script takes in sparcc psedopval results, sparcc cor results and biom 
otu table to generate a cytoscape network input file.
node mapping file will include mean abundance, log mean abundance and relative abundance.
"""

CONTEXT_SETTINGS = dict(help_option_names=['-h', '--help'])

@click.command(context_settings=CONTEXT_SETTINGS)
@click.version_option(version='0.6')

@click.option('-c', '--cor_fp', type=click.Path(exists=True),\
               help='Filepath to sparcc correlation table',\
               required=True)
@click.option('-p', '--pval_fp', type=click.Path(exists=True),\
               help='Filepath to sparcc pseudo-pvalue table',\
               required=True)
@click.option('-b','--biom_fp',type=click.Path(exists=True),\
                help='Filepath to txt otu table',\
                required=True)
@click.option('-o','--out_fp',type=click.Path(),\
                help='filepath of output transformed and pval-filtered correlation table')
@click.option('-t', '--pval_trs', type=float, default=1.1,\
               help='pval threshold, default =1')
@click.option('-e', '--coef_trs', type=float, default=0,\
               help='coefficient threshold, default =0')

#cor_fp='/Users/Nan/tmp/allergy/yogurt/outputs/6/jobs.2/t1-4.cor_sparcc.out'
#pval_fp='/Users/Nan/tmp/allergy/yogurt/outputs/6/jobs.5/t1-4.pvals_two_sided.txt'
#biom_fp='/Users/Nan/tmp/allergy/yogurt/outputs/6/jobs.1/1-4.otu_table.hdf5.tax__Probiotics_group_1.nosingle.biom'
#out_fp='/Users/Nan/tmp/allergy/yogurt/outputs/6/jobs.5/t1-4.cytoscape.txt'
#pval_trs=0.0000001
#
def main(cor_fp,pval_fp,biom_fp,out_fp,pval_trs,coef_trs):
    def matrixtransf(mtx_fp):
        """read in matrix table"""
        os.chdir(os.path.dirname(mtx_fp))
        table=pd.read_csv(os.path.basename(mtx_fp),sep='\t',dtype=None,index_col=0)
        colfrom=table.columns.values
        colto=table.index
        n=len(colfrom)
        """transform"""    
        mtx=np.asarray(table,dtype=float)
        newmtx=[]
        newfrom=[]
        newto=[]
        for i in range(n):
            mtx0=mtx[i,:(i+1)]
            newmtx=np.hstack([newmtx,mtx0])
            from0=colfrom[:(i+1)]
            newfrom=np.hstack([newfrom,from0])
            to0=np.repeat(colto[i],(i+1))
            newto=np.hstack([newto,to0])
        

        """add column names"""
        mtx={'from':newfrom,'to':newto,'eweight':newmtx}
        mtx=pd.DataFrame(data=mtx,index=range(len(newto)))
        """remove repeats"""    
        mtx=mtx[mtx['from']!=mtx['to']]
        return(mtx)
#
    def shortnames(names, otu):
        newnames=collections.defaultdict(list)   
        if otu:
            names = [(';').join(i) for i in names]
        else:
            names = list(names)
            
        for i in names:
            if i.split('_')[-1] !='':
                name0=i.split('_')[-1]
            elif (i.split(';')[-2]).split('__')[1] != '':
                name0='(u.c.)'+(i.split(';')[-2]).split('__')[1]
            elif (i.split(';')[-3]).split('__')[1] != '':
                name0='(u.c.)'+(i.split(';')[-3]).split('__')[1]
            elif (i.split(';')[-4]).split('__')[1] != '':
                name0='(u.c.)'+(i.split(';')[-4]).split('__')[1] 
            else:
                name0='(u.c.)'+(i.split(';')[-5]).split('__')[1]
            """name0 is a list like ['Spirosoma'], and won't be accepted by Counter"""
            newnames[i]= name0

        """if there is no OTU ID to add before taxa name, to differ identical short
        names, use higher taxa level"""
        val_occurrence=collections.Counter(newnames.values())
        rep = {}
        for key, value in newnames.items():
            if val_occurrence[value] > 1:
                rep[key] = value
        # rep={key:value for key,value in newnames.items() if val_occurrence[value]>1}
        if len(rep)>0:
            for k,v in rep.items():
                """join last two levels"""
                rep[k]=';'.join([k.split(';')[1].split('__')[1],\
                                 k.split(';')[-2].split('__')[1],\
                                 k.split(';')[-1].split('__')[1]])
           
            val_occurrence=collections.Counter(rep.values())
            #reptest={key:value for key,value in rep.items()
            #                         if val_occurrence[value]>1}
            reptest = {}
            for key, value in rep.items():
                if val_occurrence[value] > 1:
                    reptest[key] = valuee
            
            if len(reptest)>0:
                """join last 3 levels"""
                rep[k]=';'.join([k.split(';')[1].split('__')[1],\
                                 k.split(';')[-3].split('__')[1],\
                                 k.split(';')[-2].split('__')[1],\
                                 k.split(';')[-1].split('__')[1]])
                for k,v in rep.items():
                   newnames[k]=rep[k]
        """keep newnames in the same order of names"""
        newnames=collections.OrderedDict(sorted(newnames.items(),\
                                           key=lambda i:names.index(i[0]))) 
        return(newnames)

    """filter correlation list based on pval threshold and coefficient threshold"""   
    def pcfilter(cor,pval,pval_trs,coef_trs,out_fp):
        cor=cor[pval['eweight']<pval_trs]
        cor=cor[abs(cor['eweight'])>coef_trs]
        cor['plusone_eweight']=[i+1 for i in cor['eweight']]
        cor['absolute_eweight'] = abs(cor['eweight'])
        cor['sign'] = ['+' if x > 0 else '-' for x in cor['eweight']]
        if not os.path.isdir(os.path.dirname(out_fp)):
            os.mkdir(os.path.dirname(out_fp))
        os.chdir(os.path.dirname(out_fp))
        cor.to_csv('pval'+str(pval_trs)+'-coef'+str(coef_trs)+'--'+os.path.basename(out_fp),index=False,sep='\t',header=True)


    """get taxanomic info and make a number_id map to full taxonomy names"""
    def taxaid(biom_fp):  
        biom = pd.read_csv(biom_fp, delimiter='\t', index_col=0)
        otu_id = biom.index
        try:
            if not otu_id[0].startswith("k__"):
                otu = True
            else:
                otu = False
        except:
            otu = False
            taxa_id = biom['taxonomy']
            
            # biom = biom.set_index('taxonomy')
            # print(biom.columns.values)
            biom = biom.drop(['taxonomy'],axis=1)

        # try:
        if otu:
            short_taxa = shortnames(otu_id, otu)
            # full_taxa = [';'.join(i) for i in biom['taxonomy']]
            full_taxa = [';'.join(i) for i in biom['observation']]
            taxa_id = [short_taxa[k] for k in full_taxa]
            taxa_id=['-'.join([o,t]) for o,t in zip(otu_id, taxa_id)]
        else:
            try:
                short_taxa = shortnames(otu_id, otu)
                taxa_id = [short_taxa[k] for k in otu_id]
            except:
                short_taxa = shortnames(taxa_id, otu)
                taxa_id = [short_taxa[k] for k in taxa_id]
        # except:
        #    print('no taxa reformatting because otu ids are integers')
        #    taxa_id = otu_id
        abun = biom.mean(axis=1)   
        rel_abun = biom.apply(lambda x:x / x.sum())
        rel_abun = rel_abun.mean(axis=1)
        netmap={'OTU_id':otu_id,'taxa_id':taxa_id,'abundance':abun, \
                'lg_abundance':np.log(1+abun), 'rel_abudnance':rel_abun}
        netmap = pd.DataFrame(data = netmap)
        netmap = netmap.sort_values(['taxa_id'], ascending=[True])
        netmap['num_id'] = range(0,len(netmap))
        netmap = netmap.set_index('OTU_id')
        os.chdir(os.path.dirname(out_fp))
        netmap.to_csv('numid.pval'+str(pval_trs)+'-coef'+str(coef_trs)+'--'+os.path.basename(out_fp), \
                      index=True, sep='\t', header=True)
        return(netmap, otu)

    netmap,otu = taxaid(biom_fp)    
    cor = matrixtransf(cor_fp)
    pval = matrixtransf(pval_fp)
    """histogram of sparccc pvals"""
    # sns.set();sns.set_context({"figure.figsize": (20,20)});sns.set_context('talk')
    # sns.set_style('white',{'font.family':'sans-serif', 'font.sans-serif':['Helvetica']})
    # sns.distplot(pval['eweight'], kde=False)
    """mark 2.5 percentile of pval distribution"""   
    # plt.axvline(np.percentile(pval['eweight'], 2.5), color='red', linestyle='--')
    # plt.savefig(os.path.basename(pval_fp)+'.pval_histo.png')
    
    pcfilter(cor,pval,pval_trs,coef_trs,out_fp)

if __name__ == "__main__":
     main()    


  
       
