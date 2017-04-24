# Twitter Client
Codepath Assignment 3

Time spent: 20+ hours spent in total

## User Stories

The following **required** functionality is completed:

- [x] User can sign in using OAuth login flow
- [x] User can view last 20 tweets from their home timeline
- [x] The current signed in user will be persisted across restarts
- [x] In the home timeline, user can view tweet with the user profile picture, username, tweet text, timestamp and mins/hours since the tweets were tweeted
- [x] User can pull to refresh
- [x] User can tap on a tweet to view it, with controls to retweet, favorite, and reply
- [x] User can reply/compose a new tweet by tapping on the reply button

The following **optional** features are implemented:

- [x] When composing, there is a countdown for the tweet limit
- [ ] After creating a new tweet, a user should be able to view it in the timeline immediately without refetching the timeline from the network.
- [x] Retweeting and favoriting increment the retweet and favorite count
- [x] User is able to unretweet and unfavorite and decrement the retweet and favorite count
- [x] Replies by default are prefixed with the user name to which the reply is being sent
- [x] User can load more tweets once they reach the bottom of the feed using infinite loading.

## Walkthrough of all user stories

Walkthrough: OAuth Process                    |  Walkthrough: Required/Optional Features       | Walkthrough: Required/Optional Features        |
:--------------------------------------------:|:----------------------------------------------:|:----------------------------------------------:|
![Video Walkthrough](twitter_animations1.gif) | ![Video Walkthrough](twitter_animations2.gif)  | ![Video Walkthrough](twitter_animations3.gif)  |

GIF created with [LiceCap](http://www.cockos.com/licecap/)

## Notes

# Project 4 - Twitter Redux

Time spent: 25+ hours spent in total

## User Stories

The following **required** functionality is completed:

- [x] Hamburger menu
   - [x] Dragging anywhere in the view should reveal the menu.
   - [x] The menu should include links to your profile, the home timeline, and the mentions view.
   - [x] The menu can look similar to the example or feel free to take liberty with the UI.
- [x] Profile page
   - [x] Contains the user header view
   - [x] Contains a section with the users basic stats: # tweets, # following, # followers
- [x] Home Timeline
   - [x] Tapping on a user image should bring up that user's profile page

The following **optional** features are implemented:

- [x] Profile Page
   - [ ] Implement the paging view for the user description.
   - [ ] As the paging view moves, increase the opacity of the background screen. See the actual Twitter app for this effect
   - [x] Pulling down the profile page should blur and resize the header image.
- [ ] Account switching
   - [ ] Long press on tab bar to bring up Account view with animation
   - [ ] Tap account to switch to
   - [ ] Include a plus button to Add an Account
   - [ ] Swipe to delete an account

## Notes
What took longest for me was debugging how views are layered. Apart from that spent time trying to get the pull down working and implementing the profileview on tap

## Walkthrough of all user stories

Walkthrough: Twitter Redux                    |
:--------------------------------------------:|
![Video Walkthrough](twitter_animations4.gif) |

GIF created with [LiceCap](http://www.cockos.com/licecap/)
