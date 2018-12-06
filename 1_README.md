### Google Analytics Premium Data Structure

* Google Analytics Premium (GA360) data is exported (in this case, through [Transfer Services](https://cloud.google.com/bigquery/transfer/)) in the format of a single flat table with a new entry for each session. Rather than creating new tables for each entity attribute, Google places aggregate or attribute information in nested fields in the single tabel. For more information on Nested Fields, and why Google chooses to use them, please refer to this overview on [Why Nesting is so Cool](https://discourse.looker.com/t/why-nesting-is-so-cool/4182).

* There are two types of nested fields: repeated fields and non-repeated fields. In Standard SQL, both are stored as ``ARRAY``'s, which can contain both [simple and complex data types](https://cloud.google.com/bigquery/docs/reference/standard-sql/arrays). Non-repeated fields can be unnested, and joined using a ``one_to_one`` relationship. Repeated fields are unnested, and joined on through a ``one_to_many`` join (see lines 30-34 of the ``ga_block`` view for an example). Please take note that brackets are used for non-repeated fields, and not used for repeated fields, in the join syntax. This is a critical element to working with nested fields in BigQuery.

* Google's documentation on the data included in the export can be [found here](https://support.google.com/analytics/answer/3437719?hl=en).


### Datasets Structure

* ``google_analytics_sessions`` contains all join logic and all individual view files, dimensions, and measures. Multiple views are contained within, to more easily handle nested and unnested records


### Connecting to Other Data Sources

* **Doubleclick Campaign (Bid) Manager**: Requires admin permissions for the Google users. [Follow the documentation here](https://support.google.com/analytics/answer/6318719?hl=en).


* **DoubleClick for Publishers**: This integration includes both [AdSense](https://www.google.com/adsense/start/#/?modal_active=none) and [Ad Exchange](https://www.doubleclickbygoogle.com/solutions/digital-marketing/ad-exchange/), and requires work on the side of the Google Admin, as well as the creation of a tagging system using either self-built or Google service-provided tag managers. After tagging is enabled, the following steps can be found in [Google's Documentation](https://support.google.com/analytics/answer/6371469?hl=en). Once you've done this, be sure to include the AdWord data by adding the ``extends: [hits_publisher_base]`` beneath ``view: hits_publisher`` (on line 90 in ``ga_customize`` out-of-the-box)

* **Adwords**: Connecting AdWords is fairly straightforward. Follow the instructions provided in Google's documentation. Once you've done this, be sure to include the AdWord data by adding the ``extends: [adwordsClickInfo_base]`` beneath ``view: adwordsClickInfo`` (on line 86 in ``ga_customize`` out-of-the-box)

* **CRMs or Other Sources** Google does not capture any PII, which means that ``user_id`` and/or ``client_id`` is unique to only Google Analytics Premium. This key is not shared, by default, across any of your CRM data, or any other data sources you're pulling from. To join this data, a common key must be created. There are several methods to accomplishing this, one of which Google has provided some [documentation](https://github.com/GoogleCloudPlatform/google-analytics-premium-bigquery-statistics) around.
