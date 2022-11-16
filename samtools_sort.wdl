workflow samtools_sort {

    File input_bam


    call sort {
         input: bam=input_bam,  filename_sam="round1.filtered.sam"
    }
}
task sort {
   File bam
   String container="bryce911/smrtlink:10.0.0.108728"
   String filename_errlog="stderr.log"
   String filename_sam
   command {
    samtools view -F 1796 -q 20  ${bam} 1> ${filename_sam} 2> ${filename_errlog}
   }
    runtime {
        docker : container
        }
   output {
        File outsam=filename_sam
        File errlog=filename_errlog
   }
}

