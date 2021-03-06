###@QTLs =("eQTL")在@interval = (6,7,8,9,12,15)时的hotspot(segment),得"../../../output/ALL_${QTL}/cis_trans/hotspot/interval_${j}_cutoff_7.3_${type}_${QTL}_segment_hotspot.txt.gz"; 
#得point 热点"../../../output/ALL_${QTL}/cis_trans/hotspot/interval_${j}_cutoff_7.3_${type}_${QTL}_point_hotspot.txt.gz"
#!/usr/bin/perl
use warnings;
use strict; 
use utf8;
use List::Util qw/max min/;
use Parallel::ForkManager;
my @QTLs =("eQTL");
my $pm = Parallel::ForkManager->new(7); ## 设置最大的线程数目
foreach my $QTL(@QTLs){
    # my @interval = (18);
    # my @interval = (15);
    my @interval = (6,7,8,9,12,15,18);
    my @types=("cis_1MB","cis_10MB","trans_1MB","trans_10MB");
    my $cutoff= 0.2;
    foreach my $type(@types){
        foreach my $j(@interval){
            my $pid = $pm->start and next; #开始多线程
            print "$j\t$type\n";
            my $f1 = "../../../output/ALL_${QTL}/cis_trans/NHP/${type}/NHPoisson_emplambda_interval_${j}_cutoff_7.3_${type}_${QTL}.txt.gz";
            # open my $I1, '<', $f1 or die "$0 : failed to open input file '$f1' : $!\n"; 
            open( my $I1 ,"gzip -dc $f1|") or die ("can not open input file '$f1' \n"); #读压缩文件
            my $fo1 = "../../../output/ALL_${QTL}/cis_trans/hotspot/interval_${j}_cutoff_7.3_${type}_${QTL}_segment_hotspot.txt.gz";
            open my $O1, "| gzip >$fo1" or die $!;
            # print $O1 "chr\tstart\tend\n";
            my $fo2 = "../../../output/ALL_${QTL}/cis_trans/hotspot/interval_${j}_cutoff_7.3_${type}_${QTL}_point_hotspot.txt.gz";
            open my $O2, "| gzip >$fo2" or die $!;
            my $fo3 = "../../../output/ALL_${QTL}/cis_trans/hotspot/interval_${j}_cutoff_7.3_${type}_${QTL}_segment_hotspot.bed.gz";
            open my $O3, "| gzip >$fo3" or die $!;
            my $fo4 = "../../../output/ALL_${QTL}/cis_trans/hotspot/interval_${j}_cutoff_7.3_${type}_${QTL}_segment_hotspot_length_of_segment.bed.gz";
            open my $O4, "| gzip >$fo4" or die $!;
            print $O1 "chr\tstart\tend\tlength_of_segment\n";
            print $O2 "chr\tstart\tend\n";
            # print $O3 "chr\tstart\tend\n";
            my %hash1;
            while(<$I1>)
            {
                chomp;
                unless(/emplambda/){
                    my @f = split/\t/;
                    my $emplambda = $f[0];
                    my $pos = $f[1];
                    my $chr= $f[2];
                    my $v= "$pos\t$emplambda";
                    unless($emplambda =~/NA/){
                        # if ($chr == 1){
                        push @{$hash1{$chr}},$v;
                        # }
                    }
                }
            }
            # ---------------------------
            
            foreach my $chr (sort keys %hash1){
                my @vs = @{$hash1{$chr}};
                my $count=0;
                my @starts=();
                my @ends=();
                my @start_line =();
                my @end_line=();
                my @results=();
                foreach my $v(@vs){
                    $count++;
                    # print "$count\n";
                    my @t = split/\t/,$v;
                    my $pos = $t[0];
                    my $emplambda =$t[1];
                    if ($emplambda >= $cutoff){
                        print $O2 "$chr\t$v\n";
                        push @results,$v;
                        my $result_count=@results;
                        if ($result_count <2){ #第一个大于cutoff 的值
                            push @starts,$pos;
                            push @ends,$pos;
                            push @start_line,$count;
                            push @end_line,$count;
                        }                
                        else{ #第二个往后大于cutoff的值
                            # my $upper1 = $count-1;
                            # my $upper2 = $count-2;
                            # my $lower1 = $count+1;
                            # my $lower2 = $count+2;
                            my $before_end_count = $end_line[0];
                            my $end_diff = $count - $before_end_count;
                            if ($end_diff <2 ){ #--------------和前面end相差1,和前面的区域相连
                                @end_line =();
                                @ends =();
                                push @end_line,$count;
                                push @ends,$pos;
                                # print "$count\t2222\n";
                            }
                            else{ #--------和前面的片段不相连,输出前面的片段
                                my $length = $ends[0]-$starts[0];
                                print $O1 "$chr\t$starts[0]\t$ends[0]\t$length\n";
                                my $bed_ends = $ends[0]+1;
                                print $O3 "chr${chr}\t$starts[0]\t$bed_ends\n";
                                print $O4 "chr${chr}\t$starts[0]\t$bed_ends\t$length\n";
                                @starts =();
                                @start_line =();
                                push @starts,$pos;
                                push @start_line,$count;
                                @end_line =();
                                @ends =();
                                push @end_line,$count;
                                push @ends,$pos;
                                # print "$count\t3333333\n";
                            } 
                        }
                    }
                }
                @results=();
            }
            $pm->finish;  #多线程结束  
        }
    }
}
