version 1.0

workflow bbtools {
  input {
    File reads
    File ref
  }

   call alignment {
      input: fastq=reads,
             fasta=ref
   }
   
   call samtools {
      input: sam=alignment.sam
   }
}

task alignment {
  input {
    File fastq
    File fasta
  }

  command <<<
    bbmap.sh in=~{fastq} ref=~{fasta} out=test.sam
  >>>

  output {
    File sam = "test.sam"
  }

  runtime {
    docker: "lilei0051/aligner-bbmap"
    cpu: 1
    memory: "5G"
    time: "00:20:00"
  }
}

task samtools {
  input {
   File sam
  }

   command <<<
      set -eo pipefail
      samtools view -b -F0x4 ~{sam} | samtools sort - > test.sorted.bam
   >>>

   output {
      File bam = "test.sorted.bam"
   }

   runtime {
      docker: "jfroula/lilei0051/aligner-bbmap"
      cpu: 1
      memory: "5G"
      time: "00:20:00"
   }
}
