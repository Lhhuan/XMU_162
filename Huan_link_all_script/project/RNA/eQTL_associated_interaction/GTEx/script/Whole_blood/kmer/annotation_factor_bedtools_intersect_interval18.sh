# bedtools intersect   -a $input_file -b "/home/huanhuan/project/RNA/eQTL_associated_interaction/annotation/annotation_data/ROADMAP/E062/enhancer/01_normal_E062-H3K4me1_H3K27ac.narrowPeaksorted_overlap.gz" -wa -wb | gzip > $output_dir/enhancer_$input_file_base_name
# bedtools intersect -a $input_file -b "/home/huanhuan/project/RNA/eQTL_associated_interaction/annotation/annotation_data/ROADMAP/E062/promoter/01_normal_E062-H3K4me3.narrowPeaksorted.gz" -wa -wb | gzip > $output_dir/promoter_$input_file_base_name
bedtools intersect -a $input_file -b "/home/huanhuan/project/RNA/eQTL_associated_interaction/annotation/annotation_data/cistromeDB/normal_cell/Human_CHROMATIN_Accessibility/merge_pos_info_narrow_peak_sort_union.bed.gz" -wa -wb | gzip > $output_dir/CHROMATIN_Accessibility_$input_file_base_name
bedtools intersect -a $input_file -b "/home/huanhuan/project/RNA/eQTL_associated_interaction/annotation/annotation_data/cistromeDB/normal_cell/Human_FACTOR/merge_pos_info_narrow_peak_sort_union.bed.gz" -wa -wb | gzip > $output_dir/TFBS_$input_file_base_name

bedtools intersect -a $input_file -b "/home/huanhuan/project/RNA/eQTL_associated_interaction/annotation/annotation_data/CTCF/normal_cell_line/05_normal_cell_line_ctcf_sort_union.bed.gz" -wa -wb | gzip > $output_dir/CTCF_$input_file_base_name

bedtools intersect -a $input_file -b "/share/data0/GTEx/annotation/ROADMAP/sample/E062/E062-H3K27ac.narrowPeak.gz" -wa -wb | gzip > $output_dir/H3K27ac_$input_file_base_name

bedtools intersect -a $input_file -b "/share/data0/GTEx/annotation/ROADMAP/sample/E062/E062-H3K27me3.narrowPeak.gz" -wa -wb | gzip > $output_dir/H3K27me3_$input_file_base_name

bedtools intersect -a $input_file -b "/share/data0/GTEx/annotation/ROADMAP/sample/E062/E062-H3K36me3.narrowPeak.gz" -wa -wb | gzip > $output_dir/H3K36me3_$input_file_base_name

bedtools intersect -a $input_file -b "/share/data0/GTEx/annotation/ROADMAP/sample/E062/E062-H3K4me1.narrowPeak.gz" -wa -wb | gzip > $output_dir/H3K4me1_$input_file_base_name

bedtools intersect -a $input_file -b "/share/data0/GTEx/annotation/ROADMAP/sample/E062/E062-H3K4me3.narrowPeak.gz" -wa -wb | gzip > $output_dir/H3K4me3_$input_file_base_name

bedtools intersect -a $input_file -b "/share/data0/GTEx/annotation/ROADMAP/sample/E062/E062-H3K9ac.narrowPeak.gz" -wa -wb | gzip > $output_dir/H3K9ac_$input_file_base_name

bedtools intersect -a $input_file -b "/share/data0/GTEx/annotation/ROADMAP/sample/E062/E062-H3K9me3.narrowPeak.gz" -wa -wb | gzip > $output_dir/H3K9me3_$input_file_base_name