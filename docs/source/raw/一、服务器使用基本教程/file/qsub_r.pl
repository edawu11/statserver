#!/usr/bin/perl -w
#
# qsub_Wrapper.pl: this script creates a series job files and submits them to the queue
#   
# perl qsub_Wrapper_v1.pl $WorkingDir   $JobNamePrefix $QueueName $NumberOfJobs $Range $DataDir               $ExeCmd   $ExeFile 
# perl qsub_Wrapper_v1.pl $HOME/example jobname        es4         10            100    /scratch/prj00004/XXX  Rscript    XXX.r   


if(@ARGV!=8)   
{
    print STDERR "\nSyntax:\n	./$0 WorkingDir JobNamePrefix QueueName NumberOfJobs Range DataDir ExeCmd Exefile\n";
    exit 0;
}
my ($WorkingDir, $JobNamePrefix, $QueueName, $NumberOfJobs, $Range, $DataDir, $ExeCmd, $ExeFile) = @ARGV;

my $fpOut;

my $count;
my $JobName;
my $JobFileName;
for($count=1; $count<=$NumberOfJobs; $count=$count+1) {
  $Posfix=$count-1;
  $JobName=join('',$JobNamePrefix,$Posfix);	
  $JobFileName=join('',$JobName,".job");	
  open($fpOut, '>', $JobFileName) || die("Can't open output file $JobFileName: $!");
  print $fpOut '#!/bin/sh'."\n";
  print $fpOut "#PBS -N $JobName\n";
  print $fpOut "#PBS -q $QueueName\n";
  print $fpOut "#PBS -o $JobName.out\n";
  print $fpOut "#PBS -e $JobName.err\n";
  print $fpOut "\n";
  print $fpOut "cd $WorkingDir\n";
  print $fpOut "\n";
  print $fpOut join(" ", $ExeCmd, $ExeFile, $Range*($count-1)+1, $Range*($count), $DataDir)."\n";
  
  close($fpOut);
  #sleep(1);
  system("qsub $JobFileName");  
  print $count."\n";
}
$count=$count-1;
print "\nDone for $count lines.\n";



###################end of main function####################

