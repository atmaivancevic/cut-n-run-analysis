#!/bin/bash

## Script to generate a fastq quality control report
## Date: 23 Oct 2019 
##
## Example usage:
## inDir=. outDir=. sbatch --array 0-1 fastqc.q

# General settings
#SBATCH -p short
#SBATCH -N 1
#SBATCH -c 8
#SBATCH --time=1:00:00
#SBATCH --mem=4GB

# Job name and output
#SBATCH -J fastqc
#SBATCH -o /Users/%u/slurmOut/slurm-%A_%a.out
#SBATCH -e /Users/%u/slurmErr/slurm-%A_%a.err

# load modules
module load fastqc/0.11.5

# define query files
queries=($(ls $inDir/*.fastq.gz | xargs -n 1 basename))

# run the thing
pwd; hostname; date

echo "Processing file: "${queries[$SLURM_ARRAY_TASK_ID]}
echo $(date +"[%b %d %H:%M:%S] Starting fastqc...")

fastqc -o ${outDir} -f fastq -t 8 ${inDir}/${queries[$SLURM_ARRAY_TASK_ID]}

echo $(date +"[%b %d %H:%M:%S] Done!")
