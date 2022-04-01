# Rails Engine
<div id="top"></div>

<!-- ABOUT THE PROJECT -->
## About The Project

This repo was written as part of the Turing School of Software Design's solo project requirements for Mod 3. I was tasked with building an API from data dumped from a previous project, Little Esty Shop. Using service-oriented architecture, I built a ready to consume API capable of executing several actions from the original project. The project was intended to develop and evaluate my skill in:

* Exposing an API.
* Using serializers to format JSON responses.
* Testing API exposure.
* Using SQL and AR to gather data.

<p align="right">(<a href="#top">back to top</a>)</p>

## Requirements

- must use Rails 5.2.x
- must use PostgreSQL
- must be tested using both PostMan and RSpec, including sad paths and edge cases
- must adhere to git workflow norms
- must submit 10-12 minute presentation of the project
- must include a thorough README to describe the project

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- GETTING STARTED -->
## Getting Started

This project requires Ruby 2.7.4.

* Fork this repository
* Clone your fork
* From the command line, install gems and set up your DB:
    * `bundle`
    * `rails db:{drop,create,migrate,seed}`
    * `rails db:schema:dump`
* Run the test suite with `bundle exec rspec`.
* Run your development server with `rails s` to see the app in action.

<!-- USAGE EXAMPLES -->
## Database Schema

![image](https://user-images.githubusercontent.com/92219945/157352010-663790ce-2566-43ec-b38a-a1f289d0ab53.png)

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- ROADMAP -->
## Evaluation Criteria

<a href="https://backend.turing.edu/module3/projects/rails_engine_lite/evaluation" title="Criteria">Criteria</a>

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- ROADMAP -->
## Self Evaluation

This project was a useful way to become acquainted with service-oriented architecture. I was able to successfully complete all project requirements before the deadline, then expand my learning by code sharing with my peers. While I saw opportunities to improve the project with more robust testing and some unaddressed edge cases not noted by the project (I.E. when searching by a range of prices, a max should not be able to be less than a min) I decided that I could get more immediate value out of my time doing some other practice rather than expand into these areas. Regardless, I believe this project was a strong pass overall, and I can speak to areas of improvement that I will add to my next project.

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- CONTACT -->
## Contact

<li> Austin Moore - https://www.linkedin.com/in/austin-c-moore/ - AustinChristianMoore@gmail.com </li>

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/othneildrew/Best-README-Template.svg?style=for-the-badge
[contributors-url]: https://github.com/othneildrew/Best-README-Template/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/othneildrew/Best-README-Template.svg?style=for-the-badge
[forks-url]: https://github.com/othneildrew/Best-README-Template/network/members
[stars-shield]: https://img.shields.io/github/stars/othneildrew/Best-README-Template.svg?style=for-the-badge
[stars-url]: https://github.com/othneildrew/Best-README-Template/stargazers
[issues-shield]: https://img.shields.io/github/issues/othneildrew/Best-README-Template.svg?style=for-the-badge
[issues-url]: https://github.com/othneildrew/Best-README-Template/issues
[license-shield]: https://img.shields.io/github/license/othneildrew/Best-README-Template.svg?style=for-the-badge
[license-url]: https://github.com/othneildrew/Best-README-Template/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/othneildrew
[product-screenshot]: images/screenshot.png
