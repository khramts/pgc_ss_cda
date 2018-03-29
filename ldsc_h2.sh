#PBS -lwalltime=30:00
#PBS -lnodes=1:ppn=1
#PBS -lnodes=1:mem32gb
#PBS -S /bin/bash

## load modules
module load anaconda
module load python/2.7.9

# change to working directory
cd /home/sspgc001/LDSC_rg_project/

# for each combination of disorders, run sex-specific rg in LDSC
for x in `cat list_traits`; do

  ### females
  python /home/sspgc001/ldsc/ldsc.py \
  --h2 ${x}_females.sumstats.gz \
  --out output/F_${x}_h2 \
  --ref-ld-chr /home/sspgc001/ldsc/eur_w_ld_chr/ \
  --w-ld-chr /home/sspgc001/ldsc/eur_w_ld_chr/

  ### males
  python /home/sspgc001/ldsc/ldsc.py \
  --h2 ${x}_males.sumstats.gz \
  --out output/M_${x}_h2 \
  --ref-ld-chr /home/sspgc001/ldsc/eur_w_ld_chr/ \
  --w-ld-chr /home/sspgc001/ldsc/eur_w_ld_chr/

  # save key results
  echo ${x}_F >> output/SNP_h2_summary_results
  tail -7 output/F_${x}_h2.log | head -1 | awk '{print $5,$6}' | sed 's/(//g' | sed 's/)//g' >> output/SNP_h2_summary_results
  echo ${x}_M >> output/SNP_h2_summary_results
  tail -7 output/M_${x}_h2.log | head -1 | awk '{print $5,$6}' | sed 's/(//g' | sed 's/)//g' >> output/SNP_h2_summary_results
done

# tidy up results:
xargs -n3 < output/SNP_h2_summary_results > output/SNP_h2_summary_results2
mv output/SNP_h2_summary_results2 output/SNP_h2_summary_results
## End of script
