
create table if not exists genres
(
    id   int generated by default as identity primary key,
    name varchar(100) not null
);

create table if not exists users
(
    id       int generated by default as identity primary key,
    name     varchar(255),
    login    varchar(255) not null,
    birthday date         not null,
    email    varchar(255) not null
);

create table if not exists friendships
(
    user_id   int,
    friend_id int,
    foreign key (user_id) references users (id) on delete cascade,
    foreign key (friend_id) references users (id) on delete cascade,
    primary key (user_id, friend_id)
);

create table if not exists mpas
(
    id   int generated by default as identity primary key,
    name varchar(100) not null
);

create table if not exists films
(
    id           int generated by default as identity primary key,
    name         varchar(255) not null,
    release_date date,
    description  varchar(200),
    duration     int,
    rate         int
);

create table if not exists likes
(
    film_id int,
    user_id int,
    foreign key (film_id) references films (id) on delete cascade,
    foreign key (user_id) references users (id) on delete cascade,
    primary key (film_id, user_id)
);

create table if not exists reviews
(
    review_id int generated by default as identity primary key,
    film_id  int,
    user_id int,
    content varchar,
    is_positive boolean,
    useful int,
    foreign key (film_id) references films (id) on delete cascade,
    foreign key (user_id) references users (id) on delete cascade
);

create table if not exists review_ratings
(
    review_id     int,
    user_id   int,
    is_positive boolean not null,
    primary key (user_id, review_id),
    foreign key (user_id) references users (id) on delete cascade,
    foreign key (review_id) references reviews (review_id) on delete cascade
    );

create table if not exists film_genres
(
    film_id  int,
    genre_id int,
    foreign key (film_id) references films (id) on delete cascade,
    foreign key (genre_id) references genres (id) on delete cascade,
    primary key (film_id, genre_id)
);

create table if not exists film_mpas
(
    mpa_id  int,
    film_id int,
    foreign key (mpa_id) references mpas (id) on delete cascade,
    foreign key (film_id) references films (id) on delete cascade,
    primary key (mpa_id, film_id)
);

create table if not exists feed
(
    event_id   int auto_increment,
    user_id    int,
    timestamp  long        not null,
    event_type varchar(10) not null,
    operation  varchar(10) not null,
    entity_id  int         not null,
    foreign key (user_id) references users (id) on delete cascade,
    primary key (event_id)
);

create table if not exists reviews
(
    review_id   int,
    content     varchar(255) not null,
    is_positive boolean      not null,
    useful      int default 0,
    user_id     int,
    film_id     int,
    primary key (review_id),
    foreign key (user_id) references users (id) on delete cascade,
    foreign key (film_id) references films (id) on delete cascade
);

create table if not exists directors
(
    director_id int auto_increment,
    name        varchar(255) not null,
    primary key (director_id)
);

create table if not exists film_directors
(
    director_id int,
    film_id     int,
    primary key (director_id, film_id),
    foreign key (director_id) references directors (director_id) on delete cascade,
    foreign key (film_id) references films (id) on delete cascade
);