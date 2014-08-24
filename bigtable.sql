# githubarchive:github.timeline table brief desc
# repository_* refers to the repo itself
# actor_attributes_* refers to the person doing the event
    # possible events are forking, watching, starring etc etc
# payload_* is different for each type of event. stuff that's returned when the event executes



# example from here http://www.githubarchive.org/
# top 100 repos for Ruby by number of pushes
SELECT repository_name, count(repository_name) as pushes, repository_description, repository_url
FROM [githubarchive:github.timeline]
WHERE type="PushEvent"
    AND repository_language="Ruby"
    AND PARSE_UTC_USEC(created_at) >= PARSE_UTC_USEC('2012-04-01 00:00:00')
GROUP BY repository_name, repository_description, repository_url
ORDER BY pushes DESC
LIMIT 100



# what are the diff types of type
# bigtable doesn't support distinct()
SELECT type, count(*)
FROM [githubarchive:github.timeline]
GROUP BY type

# output
	PushEvent	112076658
	IssueCommentEvent	19968037
	WatchEvent	21165606
	CreateEvent	28674172
	ForkEvent	8187258
	DeleteEvent	2697015
	PullRequestEvent	8654275




#show timeline of watch events
SELECT LEFT(FORMAT_UTC_USEC(UTC_USEC_TO_MONTH(PARSE_UTC_USEC(created_at))),7) as month, count(*)
FROM [githubarchive:github.timeline]
WHERE type = "WatchEvent"
GROUP BY month
ORDER BY month desc

#output: data from march 2012 to aug 2014
Row	month	f0_
1	2014-08	436675
2	2014-07	1064552
3	2014-06	929249
4	2014-05	957042
5	2014-04	941720
6	2014-03	938299
7	2014-02	809214
8	2014-01	854681
9	2013-12	743934
10	2013-11	730504
#etc etc




# earliest date
SELECT MIN(FORMAT_UTC_USEC(PARSE_UTC_USEC(created_at)))
FROM [githubarchive:github.timeline]
WHERE type = "WatchEvent"

#from
2012-03-11 06:36:30.000000
#to
2014-08-01 00:00:00.000000




# in the githubarchive:github.2011 table
SELECT MIN(FORMAT_UTC_USEC(PARSE_UTC_USEC(created_at)))
FROM [githubarchive:github.2011]
where type = 'WatchEvent'

#from
2011-02-12 00:00:06.000000
#to
2011-10-28 17:13:05.000000


# RED FLAG
# missing nov 2011 to march 2012?
# fuck it, let's just do march 2012 to july 2014, that's 26 months




# query by month top trending (starred) repos greater than 500 stars
SELECT * FROM (
    SELECT LEFT(FORMAT_UTC_USEC(UTC_USEC_TO_MONTH(PARSE_UTC_USEC(created_at))),7) as month,
    repository_name,
    repository_url,
    repository_created_at,
    repository_language,
    max(repository_watchers) as t_stars,
    count(*) as new_stars
FROM [githubarchive:github.timeline]
WHERE type = "WatchEvent"
    AND PARSE_UTC_USEC(created_at) >= PARSE_UTC_USEC('2012-02-01 00:00:00')
GROUP BY month, repository_name, repository_url, repository_language, repository_created_at
)as t1,
WHERE t1.new_stars > 500
ORDER BY t1.month desc, t1.new_stars desc
