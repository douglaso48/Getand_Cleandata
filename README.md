##README


####Data Source
This work is based on the Human Activity Recognition Using Smartphones Dataset
Version 1.0 by  Reyes-Ortiz,  Anguita, Ghio and  Oneto.<br/>
The files can be downloaded from this site:<br/>
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones<br/>
The use of this dataset in publications must be acknowledged by referencing the following publication (1) and this is readily acknowledged herewith.<br/>
Fuller details can be gleaned from their README and features.txt documents.  The following paragraphs show an edited summary.<br/> I have highlighted the units of measurement in bold.

<br/>
####Study
Experiments were carried out by 30 volunteers. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity at a **constant rate of 50Hz** were captured. 
The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). From each window, a vector of features was obtained by calculating variables from the **(t) time and (f) frequency domain**. 
The dataset includes the following files:

- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent.

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from **1 to 30**. 
- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in **standard gravity units 'g'**. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the **gravity** from the total acceleration. 
- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are **radians/second**. 

Features are normalized and bounded within [-1,1].<br/>
Each feature vector is a row on the text file.

<br/>
####Objectives
Create one R script called run_analysis.R that does the following: 

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

I have taken these as a list of objectives, rather than a recipe of when the various actions should be done, the overall objective being to finish with a tidy dataset configured as specified.  I have therefore carried out the various steps where I felt the logic of the script dictated.  For example, I decided to deal with the test and train sets individually before combining them, in order to preserve the integrity of the data.  
Suitable comments are shown at various points in the script.

<br/>
####Submission
In the submission you will find:

a. This README<br/>
b. A CodeBook<br/>
c. The R script<br/>
d. A txt file showing the output(named tidyset.txt)

This txt file can be read back into R with the command:<br/>

tidy<-read.table("tidyset.txt", stringsAsFactors=FALSE, header=TRUE)<br/>

this will allow interrogation of the file in the usual way.

<br/>
####Installation of run_analysis.R 
The download links are in the script but ## marked so they will not execute.  You may download and unzip them by removing the ##.

The data unzips into one folder, containing 2 sub folders, test and train.  
For the script to run through it is assumed that the data is available in the working directory in an unzipped UCI HAR Dataset folder.

The script can be invoked, after sourcing it, by the command run_analysis().  It will run through and produce the tidyset.txt file in your working directory.  If you wish to see the tables and values, simply highlight all, except the first and last lines, of the script and select run.  It will load the required libraries for you.

<br/>
####1. Merge the training & test sets
According to the README the 30 volunteers were split arbitrarily 70% training 30% test.  They each carried out 6 activities on a differing number of occasions.

Looking at the test files the correspondence is as follows:

<br/>

|File Name  |Contents      |Dimensions |Comments   |New Name  |
|----------|---------------|-----------|--------|---------|----------|
|X_test.txt|the values     |2947 x561  | No headers or row labels |test_values |
|          |               |           |        |         |                	
|----------|---------------|-----------|--------|---------|
|y_test.txt|      For each value, the activities that were carried out identified by their numerical value(1-6)	         |2947 x 1   |No header |test_activities  |
|          |               |           |        |         |			
|----------|---------------|--------|--------|---------|
|subject_test.txt  |the tester that carried out identified by their numerical value       | 2947  x  1 |No header|test_testers  |
|          |               |        |        |         |		
|----------|---------------|--------|--------|---------|
|features.txt |2 columns, 1 showing the row numbers, the other showing the signals by name       |561 x  2 |No header| test_signals |
|          |               |        |        |         |			
|----------|---------------|--------|--------|---------|
| activity_labels.txt  |2 columns, 1 showing the activities by number (that are contained in the y_test.txt, the other showing the name that is represented by the number      |6 x2 |No header | activity_labels     |
|         |               |        |        |         |		
|----------|---------------|--------|--------|---------|
(2)
<br/>

From the dimensions and the documentation it seems apparent that the X_test set formed the body, whilst the header is represented by the features.txt.  The y_test and the subject_test are row names identifying which tester carried out what test and its resulting value, in the corresponding X_test row.  
The same was true of the train set.  The activity_labels.txt allowed the numerical designation to be converted to words.  
I decided to read them in, attaching new file names (as shown in the table above)  that I felt were more descriptive of what they were and to make the process easier to track through the script.  
The new names matched the variables in the original dataset which are, the testers, the activities they carried out, the signals that were gathered and their values. 

<br/>
####2. Extracts only the measurements on the mean and standard deviation for each measurement. 
It is not immediately apparent which values are represented by this. It requires an analysis of the features.txt and the requirement definition.  The wording is not absolutely specific and it is clear from the Discussion Forum(5) that different views are acceptable and the interpretation is an open question.  

I reviewed the features.txt file and saw that there is a list of 17 signals (at line 14), some of which were in the X,Y and Z directions.   A set of variables (at line 35) were then estimated from those signals, including the mean and std.  Additional vectors (at line 55) were obtained by averaging the signals on the angle() variable.

My interpretation was linear and I took the list of the signals (measurements), which numbered 33 when the X,Y,Z directions were taken into account.  
The list of variables have mean and std at the top, lower in the list is shown, meanFreq and angle.  It is therefore reasonable to argue that it is only the top two variables that should be used.

I reviewed the original paper and this view was confirmed by reference to its text and Tables 2 & 3. (3)

I therefore took the 33 signals from the first list and from the estimated set of variables, only the mean() and the std() were used, the rest were discarded.

This therefore meant that the total cohort would be:

Testers = 30<br/>
Tests = 6<br/>
features = 33<br/>
variables= 2<br/>
A total of 11880 observations

<br/>
####3. Uses descriptive activity names to name the activities in the data set
The labels from the activity_labels.txt were applied to test_labels converting them from numerical to words.  I took the opportunity of changing them to lower case.

<br/>
####4. Appropriately labels the data set with descriptive variable names
 
There is a divergence of view as to how names should be presented.  Hadley Wickham(6) is of the view that everything should be in lower case.  Others prefer CamelCase for easier human readability(5).  When considering whether to expand the contractions within the name to make them more understandable, a balance needs to be drawn between being descriptive and becoming unwieldy.

I reviewed all the options and finally decided to follow Hadley Wickham's and Jeff Leek's (4) advice and made everything lower case, this aided the data manipulation.  
With regard to the expansion, I felt that a full expansion made some of the names unwieldy.  I therefore adopted a middle course and replaced "t" with "time, "f" with "frequency" and left "acc", "gyro" and "mag" on the basis that they were readily understandable from their contractions.
I also looked at the "std" contraction for standard deviation.  Again the contraction "std" is widely used, I felt that to use the full form was rather unwieldy, the other usual contraction is sd.  I therefore fconsidered that no purpose would be achieved by a change.


The Data Dictionary is within the CodeBook and reference should be made there for the detail of each item.

<br/>
####5. Create a second, independent tidy data set with the average of each variable for each activity and each subject.

This is created in the script by this line:

**output<- output %>% group_by(tester,activity) %>% summarise_each(funs(mean))**

This gives the wide form.  I took the view that this could be further tidied by the extraction of the mean and std variables to their own columns.  This meant melting the data into the narrow form and creating an index to allow casting.  This was achieved by copying the "signal" column to "var" and removing everything but mean or std.  The mean and std were removed from the "signal" column to allow the collapse.  The end product now refelects more closely the original specification which designates certain functions for specific signals.

This therefore produces a tidy dataset that complies with Hadley Wickham's explanation of Codd's 3rd normal form (Codd1990) (7).  In that:

a.  Each variable forms a column.<br/>
b.	Each observation forms a row.<br/>
c.	Each type of observational unit forms a table.  (the data is normalised)


The columns are arranged using the advice from cran.

'Fixed variables should come first, followed by measured variables, each ordered so that related variables are contiguous. Rows can then be ordered by the first variable, breaking ties with the second and subsequent (fixed) variables.'(8)

<br/>
#####Checking
As a check the final tidy file has dimensions of 5940 x5 which corresponds to the 11880/2 = 5940 from step 2.  
All of the subjects have carried out all of the activities and there are no NA's.  As all of the people did all of the tasks the rows should be a multiple of 180 (5940/180=33).

From the tidyset.txt:<br/>
any(is.na(tidy))
[1] FALSE

A spot check confirmed that the values seen at stage 4 were the same for stage 5.

<br/>
#####ACKNOWLEDGEMENTS
1. Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.
Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
2.      http://ozh.github.io/ascii-tables/
3.      https://www.elen.ucl.ac.be/Proceedings/esann/esannpdf/es2013-84.pdf,
4.	Coursera - Getting and Cleaning Data
5.	Coursera - Discussion Forums
6.      Hadley Wickham - Tidy Data- https://vimeo.com/33727555
7.	Hadley Wickham - Tidy Data -JSS, Volume VV, Issue II, http://www.jstatsoft.org/
8.  http://cran.r-project.org/web/packages/tidyr/vignettes/tidy-data.html