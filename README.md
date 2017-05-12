# Planting : Fastest Memorization Tool

This application is the best tool for memorization. I inspired by "So lernt man lernen", Sebastian Leitner.
The concept of this memorization skill is just memorise what only you don't know.
It is very effective way to study something. Because you can save a lot of time to study what already you know.

Informations:

* Ruby version

- 2.3.1

* Rails version

- 4.2.1

* System dependencies

- none

* Configuration

- Environment Variables Management : [dotenv](https://github.com/bkeepers/dotenv)

* How to run the test suite

- `rake`

## Import Data

```
$ rails runner "Box.first.import('db/md_voca/day3.csv')"
```
