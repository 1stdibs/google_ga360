# 4 Different Data Structures

Put your documentation here! Your text is rendered with [GitHub Flavored Markdown](https://help.github.com/articles/github-flavored-markdown).

When working with the nested data structure, you will always receive error messages related to the nested data structures. The reason why it happens is that when you are trying to compare a string value to "an element of a structure that is buried inside of an array", they are incompliable.

### 1. Working with Arrays
In BigQuery, an array is an ordered list consisting of zero or more values of the same data type. You can construct arrays of simple data types, such as **INT64**, and complex data types such as **STRUCT**s.

You can build an array literal in BigQuery using brackets (**[** and **]**). Each element in an array is separated by a comma.

``` SQL
SELECT [1, 2, 3] AS numbers;
```

To declare a specific data type for an array, use angle brackets (< and >). When there is no defined type, then the BigQuery default type is **ARRAY<INT64>** For example:

``` SQL
SELECT ARRAY<FLOAT64>[1, 2, 3] AS floats;
```
```
WITH sequences AS
  (SELECT [0, 1, 1, 2, 3, 5] AS some_numbers
   UNION ALL SELECT [2, 4, 8, 16, 32] AS some_numbers
   UNION ALL SELECT [5, 10] AS some_numbers)
SELECT some_numbers,
       some_numbers[OFFSET(1)] AS offset_1,
       some_numbers[ORDINAL(1)] AS ordinal_1
FROM sequences;

+--------------------+----------+-----------+
| some_numbers       | offset_1 | ordinal_1 |
+--------------------+----------+-----------+
| [0, 1, 1, 2, 3, 5] | 1        | 0         |
| [2, 4, 8, 16, 32]  | 4        | 2         |
| [5, 10]            | 10       | 5         |
+--------------------+----------+-----------+
```

#### Flattening Arrays into Repeated Fields

``` SQL
WITH races AS (
 SELECT "800M" AS race,
   [STRUCT("Rudisha" as name, [23.4, 26.3, 26.4, 26.1] as splits),
    STRUCT("Makhloufi" as name, [24.5, 25.4, 26.6, 26.1] as splits),
    STRUCT("Murphy" as name, [23.9, 26.0, 27.0, 26.0] as splits),
    STRUCT("Bosse" as name, [23.6, 26.2, 26.5, 27.1] as splits),
    STRUCT("Rotich" as name, [24.7, 25.6, 26.9, 26.4] as splits),
    STRUCT("Lewandowski" as name, [25.0, 25.7, 26.3, 27.2] as splits),
    STRUCT("Kipketer" as name, [23.2, 26.1, 27.3, 29.4] as splits),
    STRUCT("Berian" as name, [23.7, 26.1, 27.0, 29.3] as splits)]
    AS participants)
SELECT *
FROM races;

+------+---------------------------------------+
| race | participant                           |
+------+---------------------------------------+
| 800M | {{Rudisha, [23.4, 26.3, 26.4, 26.1]}, |
|      | {Makhloufi, [24.5, 25.4, 26.6, 26.1]},|
|      | {Murphy, [23.9, 26, 27, 26]},         |
|      | {Bosse, [23.6, 26.2, 26.5, 27.1]},    |
|      | {Rotich, [24.7, 25.6, 26.9, 26.4]},   |
|      | {Lewandowski, [25, 25.7, 26.3, 27.2]},|
|      | {Kipketer, [23.2, 26.1, 27.3, 29.4]}, |
|      | {Berian, [23.7, 26.1, 27, 29.3]}}     |
+------+---------------------------------------+

```

A common objective when working with arrays is to __flatten__ the arrays into multiple rows. A query that flatens an array returns a row for each element in the array. In BigQuery, you flatten arrays using a **CROSS JOIN**, in conjunction with the **UNNEST** operator to flatten an array.

``` SQL
SELECT
  race,
  participant
FROM races r,
  UNNEST(r.participants) AS participant;
```

or

``` SQL
SELECT
  race,
  participant
FROM races r
CROSS JOIN UNNEST(r.participants) as participant;
```
both give the same data output

``` SQL
+------+---------------------------------------+
| race | participant                           |
+------+---------------------------------------+
| 800M | {Rudisha, [23.4, 26.3, 26.4, 26.1]}   |
| 800M | {Makhloufi, [24.5, 25.4, 26.6, 26.1]} |
| 800M | {Murphy, [23.9, 26, 27, 26]}          |
| 800M | {Bosse, [23.6, 26.2, 26.5, 27.1]}     |
| 800M | {Rotich, [24.7, 25.6, 26.9, 26.4]}    |
| 800M | {Lewandowski, [25, 25.7, 26.3, 27.2]} |
| 800M | {Kipketer, [23.2, 26.1, 27.3, 29.4]}  |
| 800M | {Berian, [23.7, 26.1, 27, 29.3]}      |
+------+---------------------------------------+
```

If you want to unnest two or more level of **STRUC**, you should

```SQL
SELECT
  race,
  participant.name,
  split
FROM races r,
  UNNEST(r.participants) AS participant,
  UNNEST(participant.splits) AS split;

+------+--------------------+
| race |  name      | split |
+------+------------+-------+
| 800M |  Rudisha   | 23.4  |
| 800M |  Rudisha   | 26.3  |
| 800M |  Rudisha   | 26.4  |
| 800M |  Rudisha   | 26.1  |
| 800M |  Makhloufi | 24.5  |
| 800M |  Makhloufi | 26.6  |
| 800M |  Makhloufi | 25.4  |
| 800M |  Makhloufi | 26.1  |
| ...  |    ...     | ...   |
+------+------------+-------+
```

#### Filtering by the Needed Values
Instead of flatterning **STRUCT** or **ARRAY** into repeated fields, we can also select one values from them. For example,

``` SQL
SELECT
race,
(SELECT name
 FROM UNNEST(participants),
   UNNEST(splits) AS duration
 ORDER BY duration ASC LIMIT 1) AS runner_with_fastest_lap
FROM races;

+------+-------------------------+
| race | runner_with_fastest_lap |
+------+-------------------------+
| 800M | Kipketer                |
+------+-------------------------+
```

Note that flattening arrays with a **CROSS JOIN** excludes rows that have empty or NULL arrays. If you want to include these rows, use a **LEFT JOIN**.

``` SQL
SELECT
  name,
  sum(duration) AS finish_time
FROM
  races, races.participants
LEFT JOIN
  participants.splits duration
GROUP BY name;

+-------------+--------------------+
| name        | finish_time        |
+-------------+--------------------+
| Murphy      | 102.9              |
| Rudisha     | 102.19999999999999 |
| David       | NULL               |
| Rotich      | 103.6              |
| Makhloufi   | 102.6              |
| Berian      | 106.1              |
| Bosse       | 103.4              |
| Kipketer    | 106                |
| Nathan      | NULL               |
| Lewandowski | 104.2              |
+-------------+--------------------+
```


### 2. Types of Data Structures in Google Analytics Raw Data

#### Definitions
{...}:= define a single object
[...]:= define a sequence of either objects, values or lists/arrays

```
hits:= ARRAY, since number of hits are different from person to person
[
|__
  {
  |__hitNumber: ""
  |__time: ""
  |__hour: ""
  |__minute: ""
  |__isSecure: ""
  |__isInteraction: ""
  |__isEntrance: ""
  |__isExit: ""
  |__referer: ""
  |__page:{
      |__pagePath: ""
      |__hostname: ""
      |__pageTitle: ""
      |__searchKeyword: ""
      |__searchCategory: ""
      |__pagePathLevel1: ""
      |__pagePathLevel2: ""
      |__pagePathLevel3: ""
      |__pagePathLevel4: ""
      }
  |__transaction: ""
  |__item: ""
  |__contentInfo: ""
  |__appInfo:{
      |__name: ""
      |__version: ""
      |__id: ""
      |__installerId: ""
      |__appInstallerId: ""
      |__appName: ""
      |__appVersion: ""
      |__appId: ""
      |__screenName: ""
      |__landingScreenName: ""
      |__exitScreenName: ""
      |__screenDepth: ""
      }
  |__exceptionInfo:{
      |__description: ""
      |__isFatal: ""
      |__exceptions: ""
      |__fatalExceptions: ""
      }
  |__eventInfo:{
      |__eventCategory: ""
      |__eventAction: ""
      |__eventLabel: ""
      |__eventValue: ""
      }
  |__product:[
      |__{

          }
      |__{...}
      ...
      ]
  |__promotion:[
      |__{

          }
      |__{...}
      ...
      ]
  |__promotionActionInfo: ""
  |__refund: ""
  |__eCommerceAction:{
      |__action_type: ""
      |__step: ""
      |__option: ""
      }
  |__experiment:[
      |__{

          }
      |__{...}
      ...
      ]
  |__publisher: ""
  |__customVariables:[
      |__{

          }
      |__{...}
      ...
      ]
  |__customDimensions:[
      |__{
          |__index: ""
          |__value: ""
          }
      |__{...}
      ...
      ]
  |__customMetrics:[
      |__{
          |__
          }
      |__{...}
      ...
      ]
  |__type: ""
  |__social: {
      |__socialInteractionNetwork: ""
      |__socialInteractionAction: ""
      |__socialInteractions: ""
      |__socialInteractionTarget: ""
      |__socialNetwork: ""
      |__uniqueSocialInteractions: ""
      |__hasSocialSourceReferral: ""
      |__socialInteractionNetworkAction: ""
      }
  |__latencyTracking: ""
  |__sourcePropertyInfo: ""
  |__contentGroup:{
      |__contentGroup1: ""
      |__contentGroup2: ""
      |__contentGroup3: ""
      |__contentGroup4: ""
      |__contentGroup5: ""
      |__previousContentGroup1: ""
      |__previousContentGroup2: ""
      |__previousContentGroup3: ""
      |__previousContentGroup4: ""
      |__previousContentGroup5: ""
      |__contentGroupUniqueViews1: ""
      |__contentGroupUniqueViews2: ""
      |__contentGroupUniqueViews3: ""
      |__contentGroupUniqueViews4: ""
      |__contentGroupUniqueViews5: ""
      }
  |__dataSource: ""
  }
|__{...}
...
]
```
