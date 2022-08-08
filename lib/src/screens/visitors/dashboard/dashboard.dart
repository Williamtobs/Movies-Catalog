import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../movie_detail/movie_detail.dart';
import '../schedules/movies_schedule.dart';

class VisitorDashBoard extends StatelessWidget {
  const VisitorDashBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/movie.jpg'),
                  fit: BoxFit.fill,
                )),
                child: Column(
                  children: [
                    const SizedBox(height: 90),
                    Column(
                      children: [
                        const Text(
                          'Want to know which of your favourites movie is '
                          'currently playing?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: 150,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: const Color.fromRGBO(85, 104, 254, 1),
                          ),
                          child: TextButton(
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const MoviesSchedule();
                                }));
                              },
                              child: const Text(
                                'View Schedule',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              )),
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Popular Movies',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      'View More',
                      style: TextStyle(
                          color: Color.fromRGBO(225, 73, 132, 1),
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: ListView.builder(
                      itemCount: movies.length,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return MoviesDetails(
                                image: movies[index].movieCover,
                                title: movies[index].movieName,
                              );
                            }));
                          },
                          child: MovieCard(
                              movieCover: movies[index].movieCover,
                              movieName: movies[index].movieName),
                        );
                      }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Available Movies',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      'View More',
                      style: TextStyle(
                          color: Color.fromRGBO(225, 73, 132, 1),
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: ListView.builder(
                      itemCount: movies.length,
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return AvailableMovie(
                            movieCover: movies[index].movieCover,
                            movieName: movies[index].movieName);
                      }),
                ),
              ),
              /*const Padding(
                padding: EdgeInsets.only(left: 15.0, right: 15.0),
                child: AvailableMovie(
                    movieCover: 'assets/survive_2022.jpg',
                    movieName: 'Survive'),
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.only(left: 15.0, right: 15.0),
                child: AvailableMovie(
                    movieCover: 'assets/the_devil.jpg',
                    movieName: 'The Devil You Know'),
              )*/
            ],
          ),
        ),
      ),
    );
  }
}

List<MovieCard> movies = [
  const MovieCard(movieCover: 'assets/survive_2022.jpg', movieName: 'Survive'),
  const MovieCard(movieCover: 'assets/takedown.jpg', movieName: 'TakeDown'),
  const MovieCard(
      movieCover: 'assets/the_devil.jpg', movieName: 'The Devil You Know'),
  const MovieCard(
      movieCover: 'assets/spider_head.jpg', movieName: 'SpiderHead'),
];

List<AvailableMovie> movies2 = [
  const AvailableMovie(
      movieCover: 'assets/survive_2022.jpg', movieName: 'Survive'),
  const AvailableMovie(
      movieCover: 'assets/takedown.jpg', movieName: 'TakeDown'),
  const AvailableMovie(
      movieCover: 'assets/the_devil.jpg', movieName: 'The Devil You Know'),
  const AvailableMovie(
      movieCover: 'assets/spider_head.jpg', movieName: 'SpiderHead'),
];

class AvailableMovie extends StatelessWidget {
  final String movieCover;
  final String movieName;

  const AvailableMovie(
      {Key? key, required this.movieCover, required this.movieName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        children: [
          Container(
            width: 120,
            height: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: AssetImage(movieCover), fit: BoxFit.fill)),
          ),
          const SizedBox(width: 10),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                movieName,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 5),
              const Text(
                'When their plane crashes on a remote snow-covered mountain, '
                'Jane and Paul have to fight for their lives as the only '
                'remaining survivors. Together they embark on a harrowing '
                'journey out of the wilderness.',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              )
            ],
          ))
        ],
      ),
    );
  }
}

class MovieCard extends StatelessWidget {
  final String movieCover;
  final String movieName;

  const MovieCard({Key? key, required this.movieCover, required this.movieName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        children: [
          Container(
            width: 120,
            height: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: AssetImage(movieCover), fit: BoxFit.fill)),
          ),
          const SizedBox(height: 5),
          SizedBox(
            width: 120,
            child: Text(
              movieName,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }
}
