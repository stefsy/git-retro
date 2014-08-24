
#billboard top 20
data['repository_name'].value_counts()[:20]

#unique languages (colors)
data['repository_language'].nunique()
# 34

#lots of good quality repos in late 2012?

#big mistake! have to go back to sql, can't group by repo languages bc some repos
# have multiple languages! for example https://github.com/textmate/textmate
# thank god its not that bad i can manually add them together
# no i think i have to go back b/c numbers might not be accurate
# back to using star_trends_par.csv!

# import
import pandas as pd
import numpy as np
d = pd.read_csv("data/star_trends_par.csv")

# get top 10 each month, remove index
t = d.sort('new_stars',ascending=False).groupby('month').head(10)
t = t.sort(['month','new_stars'],ascending=False).reset_index(drop=True)

# over time, how many more stars do you have to get to hit the billboard?
# min median max # of new stars each month
summary_stars = t.groupby('month').agg({"new_stars": [np.min, np.median, np.max]})
summary_stars.plot()

         new_stars
              amin  median   amax
month
2012-03       2211  2529.0   6291
2012-04       2595  3309.0   7539
2012-05       1917  2814.0   6846
2012-06       2121  4024.5   6256
2012-07       1606  1717.0   4730
2012-08       2070  2690.0   8862
2012-09       1054  1235.5   2937
2012-10        727   784.5   1720
2012-11        890  1273.0   2483
2012-12        789  1030.0   2087
2013-01        832  1075.0   2111
2013-02        915  1606.0   3492
2013-03       1246  2220.5   3883
2013-04       1203  1958.5   2730
2013-05       1364  1686.0   2035
2013-06       1170  2016.5   4136
2013-07       1499  1867.5   4740
2013-08       1513  2169.5   3816
2013-09       1485  1951.5   3299
2013-10       2382  2840.0  10722
2013-11       1662  2321.5   6471
2013-12       1968  2704.5   4406
2014-01       1981  2757.0   4001
2014-02       1738  2455.0   5053
2014-03       2055  2463.5  10695
2014-04       2259  3700.5   6751
2014-05       2098  2621.5   5895
2014-06       2339  4530.5   6490
2014-07       2370  4329.5   5976
