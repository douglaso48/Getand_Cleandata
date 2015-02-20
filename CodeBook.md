##CodeBook
<br/>
This work is based on the Human Activity Recognition Using Smartphones Dataset
Version 1.0 by  Reyes-Ortiz,  Anguita, Ghio and  Oneto.<br/>
The use of this dataset in publications must be acknowledged by referencing the following publication [1].<br/>
The files can be downloaded from this site:<br/>
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

==================================================================================

For the run_analysis script to run through it is assumed that the data is available in the working directory in an unzipped UCI HAR Dataset folder.

The script can be invoked, after sourcing, by the command run_analysis().  It will run through and produce the tidyset.txt file in your working directory.  If you wish to see the tables and values, simply highlight all but the first and last lines of the script and select run.  It will load the required libraries for you.

####Design Study<br/>
Experiments were carried out with a group of 30 volunteers. Each person performed six **activities** (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz were captured. 

The sensor **signals** (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated into body acceleration and gravity.  From each window, a vector of features was obtained by calculating variables from the **time and frequency domain**. 

**subject**: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

The **features** selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. 
These time domain signals were captured at a **constant rate of 50 Hz**. 
The acceleration signal from the smartphone accelerometer is **standard gravity units 'g'**

Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ). <br/>
The body acceleration signal obtained by subtracting the **gravity** from the total acceleration. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ).  The units are **radians/second**.

The magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These **signals** were used to estimate variables of the signals vector for each pattern.<br/>
The data is normalized and bounded within [-1,1].

Fuller details are available in the original README and features.txt which are included in the above download.

This raw data has been manipulated to extract only the **mean** and **standard deviation (std)** values, then to create the mean of those values.  The variable names have been altered to those as shown below. <br/>
Further details of the variables, the choices made and the rationale therefore are available in the README.

The following sets out the variables produced in the final tidy data set.

####Output Format

A data frame with 5940 observations on the following 5 variables.
  
There are no NA's
  
####Description

####tester:<br/>
a numeric vector

This identifies which tester carried out the activity.

numerical range: 1-30   

####activity:<br/>
a character vector<br>

This identifies the activity that was being carried out when the reading was taken.

laying             
sitting           
standing           
walking           
walking_downstairs<br/>
walking_upstairs  


####signal:<br/>
a character vector

This specifies the signals for which measurements were taken.

frequencybodyacc_x       
frequencybodyacc_y      
frequencybodyacc_z       
frequencybodyaccjerk_x  
frequencybodyaccjerk_y   
frequencybodyaccjerk_z  
frequencybodyaccjerkmag  
frequencybodyaccmag     
frequencybodygyro_x      
frequencybodygyro_y     
frequencybodygyro_z      
frequencybodygyrojerkmag<br/>
frequencybodygyromag     
timebodyacc_x           
timebodyacc_y            
timebodyacc_z           
timebodyaccjerk_x        
timebodyaccjerk_y       
timebodyaccjerk_z        
timebodyaccjerkmag      
timebodyaccmag           
timebodygyro_x          
timebodygyro_y           
timebodygyro_z          
timebodygyrojerk_x       
timebodygyrojerk_y      
timebodygyrojerk_z       
timebodygyrojerkmag     
timebodygyromag          
timegravityacc_x        
timegravityacc_y         
timegravityacc_z        
timegravityaccmag       

   
####mean
a numeric vector<br/>
The means of the mean values at the intersection of the first three variables.
          
          mean      Min.   :-0.99762          Max.   : 0.97451
####std
a numeric vector<br/>
The means of the standard deviation values at the intersection of the first three variables.
        
        std   Min.   :-0.9977    Max.   : 0.6871  
        
####Source

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip , dest=dataset.zip, mode=wb


####References

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

<br/>

ACKNOWLEDGEMENTS

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.

