# CONTRIBUTE

## Commits

This project follows semantic versioning from [paulhatch/semantic-version](https://github.com/paulhatch/semantic-version).  
For this to work, commit patterns must be followed:  

- `Fix: (something)` will increment the patch version.
- `Feat: (something)`will increment the minor version.
- `Major: (something)` will increment the major version.

Note that the version will increment for **every** commit that contains this pattern and modifies the game folder.  

Every commit on the `main` branch will be deployed to [github pages](https://ana-mc-almeida.github.io/the-drill/).

## Pull requests

To simplify the process of commiting with the right patterns, squashing the commits in the pull request is recommended. This way, the title of the pull request can be the only commit to follow the pattern above described.

## Milestones

Every issue should be associated to a milestone. Every time a milestone closes, a new release with the milestone is created. The game will also be deployed to [itch.io](https://crashim03.itch.io/the-drill).
