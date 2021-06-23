#筛选@files = ("./Human_FACTOR/human_factor_full_QC.txt","./HISTONE_MARK_AND_VARIANT/human_hm_full_QC.txt","./Human_CHROMATIN_Accessibility/human_ca_full_QC.txt") 中在"./cell_line_info/04_unique_cell_line_without_info_sort_mannual_find_info.txt"的cell lien，并在相应文件夹提取出文件得${output_dir}/merge_pos_info_sample_narrow_peak.bed.gz，得对于文件及peak信息文件"${output_dir}/merge_pos_info_narrow_peak.bed.gz"

#!/usr/bin/perl
use warnings;
use strict; 
use utf8;
use List::Util qw/max min/;
use List::Util qw/sum/;
use Parallel::ForkManager;



# my @files = ("./Human_FACTOR/human_factor_full_QC.txt","./HISTONE_MARK_AND_VARIANT/human_hm_full_QC.txt","./Human_CHROMATIN_Accessibility/human_ca_full_QC.txt");
# my @dirs = ("./Human_FACTOR/human_factor","./HISTONE_MARK_AND_VARIANT/human_hm","./Human_CHROMATIN_Accessibility/human_ca");
# my @dir1s = ("./Human_FACTOR/human_factor","./Human_CHROMATIN_Accessibility/human_ca");
my (%hashaaa,%hash1);

my @cancers =  ("ACC","BRCA","COAD","ESCA","KICH","KIRC","KIRP","LAML","LIHC","LUAD","LUSC","OV","PAAD","PRAD","SKCM","STAD","TGCT","THCA","UCEC","UCS"); 
foreach my $cancer(@cancers){
    $hashaaa{$cancer}=1;
}
my $f1 = "./cancer.txt";
open my $I1, '<', $f1 or die "$0 : failed to open input file '$f1' : $!\n"; 

while(<$I1>)
{
    chomp;
    my @f = split/\t/;
    for (my $i=0;$i<5;$i++){ #对文件进行处理，把所有未定义的空格等都替换成NONE
        unless(defined $f[$i]){
        $f[$i] = "NONE";
        }
    }
    my $CCLE_name = $f[1];
    my $TCGA = $f[4];
    $TCGA =~ s/"//g;
    if (exists $hashaaa{$TCGA}){
        $hash1{$CCLE_name}=$TCGA;
    }
}

my %hash5;
for (my $i=1;$i<23;$i++){
    my $k = "chr${i}";
    $hash5{$k}=1;
}



my $dir = "./HISTONE_MARK_AND_VARIANT/human_hm";
my (%hash2,%hash3,%hash4);
#----------------read QC file;
my $f2 = "${dir}_full_QC.txt";
open my $I2, '<', $f2 or die "$0 : failed to open input file '$f2' : $!\n";  

while(<$I2>)
{
    chomp;
    my @f = split/\t/;
    my $DCid = $f[0];
    my $GSMID = $f[2];
    my $factor = $f[3];
    if($factor =~/^H3K|^H4K|^H3ac|^H4ac/){
        # print "$factor\n";
        $factor =~s/\s+//g;
        my @ts = split/,/,$factor;
        foreach my $t(@ts){
            my $Cell_line = $f[4];
            my $v = "$factor\t$Cell_line";
            if (exists $hash1{$Cell_line}){
                my $TCGA = $hash1{$Cell_line};
                my $v3 = "$DCid\t$Cell_line";
                my $k = "$TCGA\t$t";
                push @{$hash2{$k}},$v3;
            }
        }
    }
}
my @aa = split/\//,$dir;
my $out_dir = $aa[1];

my $fo1 = "./cancer_cell/TCGA_mark.txt";
open my $O1, '>', $fo1 or die "$0 : failed to open output file '$fo1' : $!\n";
my %hash_exist;

foreach my $k(sort keys %hash2){
    my @tt =split/\t/,$k;
    my $TCGA= $tt[0];
    my $factor = $tt[1];

    my @vs= @{$hash2{$k}};
    my $final_out_dir= "./cancer_cell/${out_dir}/${TCGA}/${factor}";
    unless(-e $final_out_dir){
        system "mkdir -p $final_out_dir";
    }

    # open my $O1, "| gzip >$fo1" or die $!;
    my $fo2 = "${final_out_dir}/merge_pos_info_narrow_peak.bed";
    # open my $O2, "| gzip >$fo2" or die $!;
    open my $O2, '>', $fo2 or die "$0 : failed to open output file '$fo2' : $!\n";
    # print $O1 "chr\tstart\tend\tfactor\tname\tfile_name\n";
    foreach my $v(@vs){
        my @t = split/\t/,$v;
        my $DCid = $t[0];
        # my $factor = $t[1];
        my $Cell_line =$t[1];
        my $file = "${DCid}_sort_peaks.narrowPeak.bed.gz";
        my $f3 = "$dir/$file";
        if(-e $f3){
            unless(exists $hash_exist{$k}){
                $hash_exist{$k}=1;
                print "$k\n";
                print $O1 "$k\n";
            }

            # open my $I3, '<', $f3 or die "$0 : failed to open input file '$f3' : $!\n"; 
            open( my $I3 ,"gzip -dc $f3|") or die ("can not open input file '$f3' \n"); #读压缩文件
            while(<$I3>)
            {
                chomp;
                my @f = split/\s+/;
                my $chr = $f[0];
                my $start =$f[1];
                my $end =$f[2];
                my $name = $f[3];
                if (exists $hash5{$chr}){
                    my $output1 = "$chr\t$start\t$end\t$factor\t$name\t$file";
                    my $output2 = "$chr\t$start\t$end";
                    # unless(exists $hash3{$output1}){
                    #     $hash3{$output1}=1;
                    #     print $O1 "$output1\n";
                    # }
                    unless(exists $hash4{$output2}){
                        $hash4{$output2}=1;
                        print $O2 "$output2\n";
                    }
                }
            }
        }
    }
    close($O2);
    #----------------
    # my $command_line = "zless $fo2 | wc -l" ;
    # my $factor_line_count = wc($command_line);
    # if($factor_line_count >0){
    unless(-z $fo2){  #判断文件是不为空
        my $out1 = "${final_out_dir}/merge_pos_info_narrow_peak_sort.bed.gz";
        my $out2 = "${final_out_dir}/merge_pos_info_narrow_peak_sort_union.bed.gz";
        my $out3 = "${final_out_dir}/merge_pos_info_narrow_peak_sort_union_sort.bed.gz";
        my $command1 = "less $fo2 |sort -k1,1 -k2,2n |gzip >$out1 ";
        my $command2 = "bedtools merge -i $out1 |gzip > $out2";
        my $command3 = "gzip $fo2";
        my $command4 = "zless $out2 |sort -k1,1 -k2,2n |gzip >$out3 ";
        system "$command1";
        system "$command2";
        system "$command3";
        system "$command4";
    }
}


#----------------count file line
sub wc{
    my $cc = $_[0]; ## 获取参数个数
    my $result = readpipe($cc);
    my @t= split/\s+/,$result;
    my $count = $t[0];
    return($count)
}
