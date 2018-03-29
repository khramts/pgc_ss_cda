#PBS -lwalltime=30:00
#PBS -lnodes=1:ppn=1
#PBS -lnodes=1:mem32gb
#PBS -S /bin/bash

## load modules
module load anaconda
module load python/2.7.9

# change to working directory
cd /home/sspgc001/LDSC_rg_project/

# print the number of disorder combinations to a variable
nrow=`wc -l list_final | awk '{print $1}'`

# for each combination of disorders, run sex-specific rg in LDSC
for x in $(seq 1 ${nrow}); do

  # assign names of traits to variables
  t1=`awk -v var=$x 'NR==var{print $1}' list_final`
  t2=`awk -v var=$x 'NR==var{print $2}' list_final`

  ### females
  python /home/sspgc001/ldsc/ldsc.py \
  --rg ${t1}_females.sumstats.gz,${t2}_females.sumstats.gz \
  --out output/F_${t1}_${t2}_rg \
  --ref-ld-chr /home/sspgc001/ldsc/eur_w_ld_chr/ \
  --w-ld-chr /home/sspgc001/ldsc/eur_w_ld_chr/

  ### males
  python /home/sspgc001/ldsc/ldsc.py \
  --rg ${t1}_males.sumstats.gz,${t2}_males.sumstats.gz \
  --out output/M_${t1}_${t2}_rg \
  --ref-ld-chr /home/sspgc001/ldsc/eur_w_ld_chr/ \
  --w-ld-chr /home/sspgc001/ldsc/eur_w_ld_chr/

  # save key result
  tail -4 output/F_${t1}_${t2}_rg.log | head -1 >> output/summary_results
  tail -4 output/M_${t1}_${t2}_rg.log | head -1 >> output/summary_results
done

## End of script
