# Git Retro:



###[Click here for the live submission! ](http://www.stefsy.com/git-time-machine)




# What is this?
* A short history of repos Githubbers used to think were cool and trendy.
* A monthly aggregate of star events across all repositories.
* Data from the <a href="http://www.githubarchive.org/"> GitHub Archive</a>



# What are some fun facts about this data? </h3>
* 231 repos have ever been on the top 10 list.
* Bootstrap is the all time platinum repo, staying on the board for 19 of the 29 months recorded.
* Popcorn-app was huge in March 2014, but kept getting moving around and mushrooming back to life under different owners.
* The mininum number of stars it takes to get on the top 10 list is 727;
* the median is 2,287.5;
* and the maximum is 10,722.


# Steps?
1. ran `analysis/bigtable.sql` on Bigtable to get `star_trends_full.csv`
2. grabbed current details of any live repos using `analysis/grab_repo_details.py`
3. some pandas work to clean and merge the data into the `billboard_created.csv` file
4. lots of d3.js, see `time-machine.html`
