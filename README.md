# Bowling Scorer


This is an assigned mini project from Jobsity to Leandro Guardia

### Installation
Make sure you have Ruby and Bundler installed.
After unziping the compressed package.
```sh
$ cd bowling-scorer
$ bundle install
```
This project was developed with:
- Ruby 2.6.0
- Bundler 1.17.2
- Rubygems 3.0.1
- RSpec 3.8 (tests)
- Simplecov (coverage)

### Usage

Once you are inside the `bowling-scorer` folder;
passing a path of an input file is required, use the `-i` flag.

```sh
$ ruby generate_board.rb -i input.txt
```
Increase your terminal width to ensure readability.
### Input Files
Games are loaded from `.txt` files, following the next format:
```
player_1 3
player_1 7
player_2 10
player_1 F
player_1 4
player_2 0
player_2 7
...
```
This input file has one or more players that complete 10 frames in total.

The project folder has sample files inside the `games` folder:
 - sample.txt
 - perfect_worse.txt

### Run tests
All tests:
  ```
  $ rspec
  ```
Specific file:
  ```
  $ rspec spec/single_scorer_spec.rb
  ```
Add the line of code for a specific test:
  ```
  $ rspec spec/single_scorer_spec.rb:9
  ```
  Add the flag `-f d ` or `--format documentation` for a descriptive output.
  
### Code coverage
  After running all tests, a `coverage` folder will be created in the root of the project, open `index.html` in your browser to see coverage results.

**Enjoy**
