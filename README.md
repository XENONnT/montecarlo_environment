# montecarlo_environment

Container environment for our monte carlo workflows

To bind singularity env on midway: 

module load singularity
singularity shell --bind /project2 --bind /dali /project2/lgrandi/xenonnt/sin
gularity-images/xenonnt-montecarlo-development.simg

(see more instructions on https://xe1t-wiki.lngs.infn.it/doku.php?id=xenon%3Axenonnt%3Acomputing%3Abaseenvironment)
