DROP DATABASE IF EXISTS bookwyrm;
CREATE DATABASE bookwyrm;
USE bookwyrm;

CREATE TABLE authors (
  author_id INT NOT NULL AUTO_INCREMENT,
  author_first VARCHAR(32),
  author_middle VARCHAR(32),
  author_last VARCHAR(32),
  author_nickname VARCHAR(32),
  author_link VARCHAR(255),
  PRIMARY KEY (author_id)
);

CREATE TABLE publisher_locations (
  location_id INT NOT NULL AUTO_INCREMENT,
  location_state VARCHAR(32),
  location_country VARCHAR(32),
  PRIMARY KEY (location_id)
);

CREATE TABLE publishers (
  publisher_id INT NOT NULL AUTO_INCREMENT,
  publisher_name VARCHAR(255),
  publisher_location INT,
  PRIMARY KEY (publisher_id),
  FOREIGN KEY (publisher_location) REFERENCES publisher_locations(location_id)
);

CREATE TABLE languages (
  language_id INT NOT NULL AUTO_INCREMENT,
  language_name VARCHAR(32),
  PRIMARY KEY (language_id)
);

CREATE TABLE formats (
  format_id INT NOT NULL AUTO_INCREMENT,
  format_name VARCHAR(32),
  PRIMARY KEY (format_id)
);

CREATE TABLE conditions (
  condition_id INT NOT NULL AUTO_INCREMENT,
  condition_name VARCHAR(32),
  PRIMARY KEY (condition_id)
);

CREATE TABLE statuses (
  status_id INT NOT NULL AUTO_INCREMENT,
  status_name VARCHAR(32),
  PRIMARY KEY (status_id)
);

CREATE TABLE actions (
  action_id INT NOT NULL AUTO_INCREMENT,
  action_name VARCHAR(32),
  PRIMARY KEY (action_id)
);

CREATE TABLE series (
  series_id INT NOT NULL AUTO_INCREMENT,
  series_name VARCHAR(64),
  series_count TINYINT,
  PRIMARY KEY (series_id)
);

CREATE TABLE readers (
  reader_id INT NOT NULL AUTO_INCREMENT,
  reader_name VARCHAR(32),
  PRIMARY KEY (reader_id)
);

CREATE TABLE titles (
  title_id INT NOT NULL AUTO_INCREMENT,
  title_text VARCHAR(255),
  title_stripped VARCHAR(255),
  title_author INT,
  title_read BOOLEAN,
  title_series INT,
  title_series_number TINYINT,
  title_link VARCHAR(255),
  PRIMARY KEY (title_id),
  FOREIGN KEY (title_author) REFERENCES authors(author_id),
  FOREIGN KEY (title_series) REFERENCES series(series_id)
);

CREATE TABLE books (
  book_id INT NOT NULL AUTO_INCREMENT,
  book_title INT,
  book_format INT,
  book_language INT,
  book_publisher INT,
  book_condition INT,
  book_status INT,
  book_action INT,
  book_notes TEXT,
  book_abridged BOOLEAN,
  book_ibsn INT,
  book_cover VARCHAR(255),
  book_owner INT,
  location_notes VARCHAR(255),
  PRIMARY KEY (book_id),
  FOREIGN KEY (book_title) REFERENCES titles(title_id),
  FOREIGN KEY (book_language) REFERENCES languages(language_id),
  FOREIGN KEY (book_publisher) REFERENCES publishers(publisher_id),
  FOREIGN KEY (book_format) REFERENCES formats(format_id),
  FOREIGN KEY (book_condition) REFERENCES conditions(condition_id),
  FOREIGN KEY (book_status) REFERENCES statuses(status_id),
  FOREIGN KEY (book_action) REFERENCES actions(action_id),
  FOREIGN KEY (book_owner) REFERENCES readers(reader_id)
);

CREATE TABLE wishlist_books (
  wishlist_id INT NOT NULL AUTO_INCREMENT,
  wishlist_title INT,
  wishlist_author INT,
  full BOOLEAN,
  abridged BOOLEAN,
  wishlist_notes TEXT,
  PRIMARY KEY (wishlist_id)
);

CREATE TABLE wishlist_to_format (
  wishlist_format_id INT NOT NULL AUTO_INCREMENT,
  wishlist_id INT,
  format_id INT,
  PRIMARY KEY (wishlist_format_id),
  FOREIGN KEY (wishlist_id) REFERENCES wishlist_books(wishlist_id),
  FOREIGN KEY (format_id) REFERENCES formats(format_id)
);

CREATE TABLE wishlist_to_condition (
  wishlist_condition_id INT NOT NULL AUTO_INCREMENT,
  wishlist_id INT,
  condition_id INT,
  PRIMARY KEY (wishlist_condition_id),
  FOREIGN KEY (wishlist_id) REFERENCES wishlist_books(wishlist_id),
  FOREIGN KEY (condition_id) REFERENCES conditions(condition_id)
);

CREATE TABLE wishlist_to_cover (
  wishlist_cover_id INT NOT NULL AUTO_INCREMENT,
  wishlist_id INT,
  cover_image VARCHAR(64),
  PRIMARY KEY (wishlist_cover_id),
  FOREIGN KEY (wishlist_id) REFERENCES wishlist_books(wishlist_id)
);

CREATE TABLE wishlist_to_language (
  wishlist_language_id INT NOT NULL AUTO_INCREMENT,
  wishlist_id INT,
  language_id INT,
  PRIMARY KEY (wishlist_language_id),
  FOREIGN KEY (wishlist_id) REFERENCES wishlist_books(wishlist_id),
  FOREIGN KEY (language_id) REFERENCES languages(language_id)
);

CREATE TABLE wishlist_to_publisher (
  wishlist_publisher_id INT NOT NULL AUTO_INCREMENT,
  wishlist_id INT,
  publisher_id INT,
  PRIMARY KEY (wishlist_publisher_id),
  FOREIGN KEY (wishlist_id) REFERENCES wishlist_books(wishlist_id),
  FOREIGN KEY (publisher_id) REFERENCES publishers(publisher_id)
);

