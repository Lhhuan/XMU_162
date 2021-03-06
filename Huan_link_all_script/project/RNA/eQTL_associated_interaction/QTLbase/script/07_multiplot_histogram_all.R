library(gcookbook)
library(dplyr)
library(ggplot2)
library(readr)
library(data.table)
library(stringr)

p_theme<-theme(panel.grid =element_blank())+theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), panel.background = element_blank(), 
        axis.title.y = element_text(size = 10),axis.title.x = element_text(size = 10),axis.line = element_line(colour = "black"),
        axis.text.y = element_text(size=10),axis.text.x = element_text(size=10))

setwd("/home/huanhuan/project/RNA/eQTL_associated_interaction/QTLbase/figure/")
org<-fread("../output/NHPoisson_emplambda_interval_1000_cutoff_7.3_all_merge_all_xQTL.txt.gz",header = T,sep = "\t") %>% as.data.frame()

org_all <-filter(org,xQTL =="QTL")
org_xqtl <-filter(org,xQTL !="QTL")
org_all$xQTL <-paste("ALL ",org_all$xQTL, sep = "")
a<-rbind(org_xqtl,org_all)
a$xQTL<-factor(a$xQTL)

pdf("histogram_count_number_by_emplambda_interval_1000_cutoff_7.3_all_xQTL.pdf",height = 6,width = 7)
p1<-ggplot(a, aes(x =emplambda,fill =xQTL)) +geom_histogram(position="identity",alpha =0.45) 
p1<-p1+xlab("Emplambda") + ylab("Count")+p_theme
print(p1)
dev.off()

# org1<-filter(org,emplambda<0.75)
# pdf("histogram_count_number_by_emplambda_interval_1000_cutoff_7.3_emplambda_0.75_all_xQTL.pdf",height = 6,width = 7)
# p1<-ggplot(org1, aes(x =emplambda,fill =xQTL)) +geom_histogram(position="identity",alpha =0.45) 
# p1<-p1+xlab("Emplambda") + ylab("Count")+p_theme
# print(p1)
# dev.off()


# org1<-filter(org,emplambda<0.65)
# pdf("histogram_count_number_by_emplambda_interval_1000_cutoff_7.3_emplambda_0.65_all_xQTL.pdf",height = 6,width = 7)
# p1<-ggplot(org1, aes(x =emplambda,fill =xQTL)) +geom_histogram(position="identity",alpha =0.45) 
# p1<-p1+xlab("Emplambda") + ylab("Count")+p_theme
# print(p1)
# dev.off()

# org1<-filter(org,emplambda<0.55)
# pdf("histogram_count_number_by_emplambda_interval_1000_cutoff_7.3_emplambda_0.55_all_xQTL.pdf",height = 6,width = 7)
# p1<-ggplot(org1, aes(x =emplambda,fill =xQTL)) +geom_histogram(position="identity",alpha =0.45) 
# p1<-p1+xlab("Emplambda") + ylab("Count")+p_theme
# print(p1)
# dev.off()


org1<-filter(a,emplambda<0.4)
pdf("histogram_count_number_by_emplambda_interval_1000_cutoff_7.3_emplambda_0.4_all_xQTL.pdf",height = 6,width = 7)
p1<-ggplot(org1, aes(x =emplambda,fill =xQTL)) +geom_histogram(position="identity",alpha =0.45) 
p1<-p1+xlab("Emplambda") + ylab("Count")+p_theme
print(p1)
dev.off()


org1<-filter(a,emplambda<0.3)
pdf("histogram_count_number_by_emplambda_interval_1000_cutoff_7.3_emplambda_0.3_all_xQTL.pdf",height = 6,width = 7)
p1<-ggplot(org1, aes(x =emplambda,fill =xQTL)) +geom_histogram(position="identity",alpha =0.45) 
p1<-p1+xlab("Emplambda") + ylab("Count")+p_theme
print(p1)
dev.off()

org1<-filter(a,emplambda<0.25)
pdf("histogram_count_number_by_emplambda_interval_1000_cutoff_7.3_emplambda_0.25_all_xQTL.pdf",height = 6,width = 7)
p1<-ggplot(org1, aes(x =emplambda,fill =xQTL)) +geom_histogram(position="identity",alpha =0.45) 
p1<-p1+xlab("Emplambda") + ylab("Count")+p_theme
print(p1)
dev.off()

org1<-filter(a,emplambda<0.2)
pdf("histogram_count_number_by_emplambda_interval_1000_cutoff_7.3_emplambda_0.2_all_xQTL.pdf",height = 6,width = 7)
p1<-ggplot(org1, aes(x =emplambda,fill =xQTL)) +geom_histogram(position="identity",alpha =0.45) 
p1<-p1+xlab("Emplambda") + ylab("Count")+p_theme
print(p1)
dev.off()
# col= c("#C79440","#AB2915","#D605F7","#950CAB","#AB741D","#C7C040","#ABA41D","#AB2915","#050EF7","#0C12AB","#826323","#4E543C","#2C5417","#57BF1F")
# org1<-filter(org,emplambda<0.2)
# pdf("histogram_count_number_by_emplambda_interval_1000_cutoff_7.3_emplambda_0.2_all_xQTL.pdf",height = 6,width = 7)
# p1<-ggplot(org1, aes(x =emplambda,fill =xQTL)) +geom_histogram(position="identity",alpha =0.45) 
# p1<-p1+xlab("Emplambda") + ylab("Count")+p_theme
# print(p1)
# dev.off()


# org1<-filter(org,emplambda<0.2)
# pdf("histogram_count_number_by_emplambda_interval_1000_cutoff_7.3_emplambda_0.2_all_xQTL_col_test.pdf",height = 6,width = 7)
# p1<-ggplot(org1, aes(x =emplambda,fill =xQTL)) +geom_histogram(position="identity",alpha =0.45) 
# p1<-p1+scale_fill_manual(values =col)
# p1<-p1+xlab("Emplambda") + ylab("Count")+p_theme
# print(p1)
# dev.off()


# org1<-filter(org,emplambda<0.2)
# pdf("histogram_count_number_by_emplambda_interval_1000_cutoff_7.3_emplambda_0.2_all_xQTL_col_test.pdf",height = 6,width = 7)
# p1<-ggplot(org1, aes(x =emplambda,fill =xQTL)) +geom_histogram(position="identity",alpha =0.45) 
# # p1<-p1+scale_fill_hue()
# p1<-p1+xlab("Emplambda") + ylab("Count")+p_theme
# print(p1)
# dev.off()

# org1<-filter(org,emplambda<0.2)
# pdf("histogram_count_number_by_emplambda_interval_1000_cutoff_7.3_emplambda_0.2_all_xQTL_col_test.pdf",height = 6,width = 7)
# p1<-ggplot(org1, aes(x =emplambda,colour =xQTL)) +geom_histogram(position="identity") 
# p1<-p1+scale_fill_manual(values =col, breaks = col)
# # p1<-p1+scale_color_manual(values =col)
# p1<-p1+xlab("Emplambda") + ylab("Count")+p_theme
# print(p1)
# dev.off()




# org1<-filter(org,emplambda<0.2)
# pdf("histogram_count_number_by_emplambda_interval_1000_cutoff_7.3_emplambda_0.2_all_xQTL_col_test.pdf",height = 6,width = 7)
# p1<-ggplot(org1, aes(x =emplambda)) +geom_histogram(position="identity",alpha =0.45,colour =emplambda$xQTL) 
# p1<-p1+scale_fill_manual(values =col)
# p1<-p1+xlab("Emplambda") + ylab("Count")+p_theme
# print(p1)
# dev.off()



# setwd("/home/huanhuan/project/RNA/eQTL_associated_interaction/QTLbase/figure/")
# org<-fread("../output/count_number_by_emplambda_interval_1000_cutoff_7.3_all_merge_eQTL_caQTL_edQTL_hQTL_mQTL_pQTL_reQTL_sQTL.txt",header = T,sep = "\t") %>% as.data.frame()

# pdf("histogram_count_number_by_emplambda_interval_1000_cutoff_7.3.pdf",height = 6,width = 6)
# p1<-ggplot(org, aes(x =emplambda, y=number,fill =xQTL)) +geom_histogram(position="identity",alpha =0.4) 
# print(p1)
# dev.off()

# for(i in c(1:22)){
#     png("histogram_count_number_by_emplambda_interval_1000_cutoff_7.3.pdf",height = 1000,width = 2000)
#     p1<-ggplot(org2, aes(x =t, y=emplambda,colour =xQTL)) +geom_point(size=0.1) 

#     p2<-p1+theme(panel.grid =element_blank())+theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), panel.background = element_blank(), 
#         axis.title.y = element_text(size = 10),axis.title.x = element_text(size = 10),axis.line = element_line(colour = "black"),
#         axis.text.y = element_text(size=10),axis.text.x = element_text(size=10)) 
#     p2<-p2+xlab("Position") + ylab("Emplambda") 
#     p2<-p2+ggtitle(title_name)
#     p2<-p2+theme(legend.text =element_text(size =20),legend.title =element_text(size =20),plot.title=element_text(size =20))
#     print(p2)
#     dev.off()
#     print(i)
# }
