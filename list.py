movies = [line.rstrip('\n').replace(":","") for line in open('combined_data_1.txt') if ":" in line]
## Getting the number of movies that had score
for i in range(1,len(movies)+1):
    if str(i) not in movies:
        print(i)
## Saving only movies which has score
with open('movie_titles.csv','r') as f:
    end = len(movies)
    lines  = f.readlines()[:end]
    with open('new_movies.csv','w+') as w:
        for line in lines:
            w.write(line)
## Parsing combined_data_1 file
with open('combined_data_1.txt','r') as f:
    with open('combined_data_1_modified.txt','w+') as w:
        id_movie = 0
        for line in f.readlines():
            if ":" in line:
                id_movie = line.rstrip('\n').replace(":",'')
            else:
                w.write("{},{}".format(id_movie,line))
