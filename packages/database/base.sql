CREATE TABLE image (
    id serial PRIMARY KEY NOT NULL,
    path varchar(200) NOT NULL,
    type varchar(50) NOT NULL,
    path_code varchar(100) NOT NULL
);

CREATE TABLE profile (
    id serial PRIMARY KEY NOT NULL,
    username varchar(20) NOT NULL UNIQUE,
    description varchar(20),
    image_id INTEGER,

    CONSTRAINT image_id_fk
	FOREIGN KEY (image_id) REFERENCES image (id)
);

CREATE TABLE feed (
    id serial PRIMARY KEY NOT NULL,
    user_id INTEGER NOT NULL,
    image_id INTEGER NOT NULL,
    creation_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    description varchar(500) NOT NULL,

    CONSTRAINT user_id_fk
	FOREIGN KEY (user_id) REFERENCES profile (id),

    CONSTRAINT image_id_fk
	FOREIGN KEY (image_id) REFERENCES image (id)
);

CREATE TABLE feed_like (
    id serial PRIMARY KEY NOT NULL,
    profile_id INTEGER NOT NULL,
    feed_id INTEGER NOT NULL,
    like_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT profile_id_fk
	FOREIGN KEY (profile_id) REFERENCES profile (id),

    CONSTRAINT feed_id_fk
	FOREIGN KEY (feed_id) REFERENCES image (id)
);