# Koomenade

Koomenade is a static website host that focuses on being insanely cheap and easy to get going.

### Why?

There are so many services that exist for hosting static services, but for me they all had barriers: 

- Cost
- Time to get deployed
- Difficult user interfaces

Some of the best services range from landing page generators to drag and drop web site editors. Most cost anywhere from $10/month to $25/month depending on what features you want. It doesn't sound like much, but when you're just wanting to test out a stupid idea to see if it has legs, $120/year can add up quick. 

As you get cheaper, services require more technical knowledge. Even if you have the knowledge, like I do, it's a hassle to go into my server and change some config files every time I want to set up a new domain on my site. 

**TL;DR: The goal of Koomenade is to be the [Microsoft Paint](https://www.youtube.com/watch?v=v2g5qbvb7F4) of static website hosting; Stupid easy to get going but still allows for more complex ideas to be fleshed out**

## KQL Markup Notation

KQL (Koomenade Query Language) is a basic markup for pull things out of the built in Koomenade Data Store.

### Basics

```
[kql::people.each.{ person:last_name }.{ person:first_name }]
```

Every query will be surrounded by square brackets and begin with `kql::table_name`. Though it is reccomended, your table name does not need to be plural. However, when calling an each loop, like in the example, your method to call each row must be singular.

Also, notice every statement is separated by a period.

**Method chaining is not yet supported**

#### Supported methods

* `each`
* `limit`
* `offset`
* `length`

**`each`**
```
[kql::people.each.{ person:last_name }]
```

**`Limit`**

```
[kql::people.limit.{10}]
```

**`Offset`**

```
[kql::people.offset.{5}]
```

**`Length`**

```
[kql::people.length]
```

## Creating forms

```
<form [kqlform::people first_name:string last_name:string]>
  <input type="text" [kqlfield::people:first_name]>
  <input type="text" [kqlfield::people:last_name]>
  <input type="submit">
</form>
```

Because of this declaration, Koomenade will validate each form submission so people can't just willy nilly edit the generated HTML and screw up your data structure. More validations are coming as well as authentication.

## Progress

(Trello Board)[https://trello.com/b/A5FWe4WK]
