# Way of working

# Purpose

The purpose of this page is to explain how CPU conducts its work and why. This includes both technical aspects like code reviews and project management in our GitHub project, but also social aspects like how to share knowledge.

# Technical

## GitHub project

For project management we use [this](https://github.com/orgs/Dsek-LTH/projects/7/) GitHub project. Project management is important to get an overview of what needs and is currently being worked on to easily distribute work and make sure people don't accidentally work on the same thing. It's mainly Head of DWWW and Root's responsibility to keep this updated, but it's very helpful if each developer keeps their tasks updated in the project. The most important fields for a developer to keep updated are `Assignees` and `Status`. 

There are also two other fields that we currently use: `priority` and `size`. Developers don't need to touch these (but it's greatly appreciated if they do!), but since their meaning is not immediately apparent they warrant some explanation.

**Priority:** Is mostly used to give a better overview of what needs to be worked on. Urgent is stuff that needs to be fixed as fast as possible, while the rest are a bit more arbitrary where higher priority means that we need/want to work on something sooner.

**Size:** Traditionally size/time estimates are used in companies to predict how much work can be accomplished in a certain time period. But since we're not a company that's not really as relevant to us and we use it more as a way to make it easier to pick what to work on. It's not immediately obvious what size means, in our case it's the size of the scope. Examples for each size:

* Tiny: this issue is straightforward and there's only one way to do it, for example updating a link.
* Small: this issue is still pretty straightforward, but there is a bigger risk of making mistakes and the way to accomplish the task may be subjective. 
* Medium: this issue is more complex and requires acquiring some deeper knowledge of the system
* Large: this issue is complex and usually involves creating something new, it's usually a good idea to consult someone else both for knowledge sharing and getting a new perspective
* X-Large: this is something complex that needs to be created from scratch, should not be worked on alone

## Code review

Code review is important both for ensuring code quality, but more importantly sharing knowledge. Everything should be reviewed as far as possible, this might be hard when working on sysadmin stuff since you usually need to commit stuff to test it or do stuff live in a system. In that case you can still show your work to someone else (or the whole CPU if it's something you think everyone should know about!).

**Who should review my code?**\nIt might be tempting to ask Head of DWWW or root to review, but we want you to find another Developer to the largest extent possible. This is to encourage knowledge sharing, our main purpose with code review is not to ensure code quality (though we should still strive for good code quality in our reviews of course), but rather to ensure that you aren't the only one who has seen that piece of code. This ensures that knowledge lives on. 

# Practical

## Starting to work on a task

It might be tempting to just start working on a task, the drawbacks with this is:


1. It doesn't promote knowledge-sharing
2. You might miss something technical that you need to know that will just come up in the code-review instead

Instead you should find another developer, preferably someone else that's just starting a task (you can ask Head of DWWW or root for help with finding someone). Show them the task, explain what you are going to do and make sure that it sounds reasonable. If they are also starting a task they can do the same with you. Now you can start working on the task. Once it's time for review, you can ask that same person to review your changes.

## What if it's a really big task?

If you want to work on a bigger task that's more of a project, you should create an epic and corresponding sub-issues.  You are expected to identify what needs to be done and with the help of someone else gradually develop it. There are different ways to go about this, but the recommended way is to first make an mvp ([minimum viable product](https://en.wikipedia.org/wiki/Minimum_viable_product)) and either merging it under a [feature flag](./../Guides/web/Feature%20flags.md) or keeping it in a feature branch if it's not possible to use a feature flag. Then create issues and work on it iteratively with someone else, reviewing each others code.