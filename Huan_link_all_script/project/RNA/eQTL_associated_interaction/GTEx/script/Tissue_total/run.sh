perl 01_judge_exist_tissue.pl 
perl 02_Completion_snp_for_xQTL_by_1kg.pl  # 用"/share/data0/1kg_phase3_v5_hg19/EUR/1kg.phase3.v5.shapeit2.eur.hg19.all.SNPs.vcf.gz" 补全"${dir}/${tissue}${suffix}"; 得"../../output/${tissue}_cis_eQTL_1kg_Completion.txt.gz"
Rscript 03_NHP_big_par.R
perl 04_filter_hotspot_for_interval18.pl  ###../../output/${tissue}/Cis_eQTL/NHP/NHPoisson_emplambda_interval_${j}_cutoff_7.3_${tissue}.txt.gz 时得不同cutoff下的hotspot(segment),"../../output/${tissue}/Cis_eQTL/hotspot_cis_eQTL/interval_${j}/${tissue}_segment_hotspot_cutoff_${cutoff}.bed.gz"

perl 05_bedtools_tissue_mutual_absolute.pl #tissue 两两之间进行 intersect ，找全部share的hotspot,得汇总文件"../../output/Tissue_total/share/total/05_absolute_tissue_intersect.bed.gz"

perl 06_merge_global_tissue_share_hotspot.pl #intersect -f 1    对 "../../output/Tissue_total/share/total/05_all_tissue_intersect.bed.gz" 进行 tissue合并得../../output/Tissue_total/share/total/06_all_tissue_share_hotspot_total_contain.bed.gz

    # perl 07_tissue_multiinter.pl  #all tissue multiinter，得../../output/Tissue_total/share/total/07_all_tissue_multiinter.bed.gz


perl 07_tissue_bedtools_intersect_all.pl #没有比例限制的intersect ../../output/Tissue_total/share/all/05_all_tissue_intersect.bed.gz

perl 08_filter_tissue_specific.pl #"../../output/Tissue_total/specific/pure/tissue_specific.bed.gz"
# bedtools multiinter -i -header 

perl 09_count_tissue_all_and_specific_hotspot.pl  ##得"../../output/Tissue_total/number_of_tissue_all_hotspot.txt.gz"，"../../output/Tissue_total/number_of_tissue_specific_hotspot.txt.gz"

perl 10_count_jaccard_index_similarity_tissue_tissue.pl ##得100%绝对overlap文件../../output/Tissue_total/10_tissue_pair_ovelap_absolute.txt.gz，得没有在../../output/Tissue_total/10_tissue_pair_ovelap_absolute.txt.gz中的片段"../../output/Tissue_total/10_tissue_pair_out_ovelap_absolute.txt.gz"
#得用于计算类似jaccard index 数据"../../output/Tissue_total/10_tissue_pair_overlap_index_and_related_number.txt.gz"，得类似jaccard index "../../output/Tissue_total/10_tissue_pair_overlap_index.txt.gz"

perl 11_count_share_tissue_number.pl  #"../../output/Tissue_total/share/total/06_all_tissue_share_hotspot_total_contain.bed.gz"



#----------------------plot


Rscript barplot_distbution_of_hotspot_in_share_tissues.R 

Rscript tissue_specific_and_all_hotspot.R

Rscript heatmap_tissue_tissue_share.R


