# Query examples for Azure Application Insights

## Query for specific format log entries with Product, Component, Sequence, Module, Message and Parameters

```kusto
traces
    | extend product = tostring(extract("Product: ([^: .*]+) - Component", 1, message))
    | extend component = tostring(extract("Component: ([^: .*]+);", 1, message))
    | extend componentGuid = tostring(extract("Component: .*;([^: .*]+) -", 1, message))
    | extend sequenceNumber = toint(extract("Sequence: ([^: .*]+) -", 1, message))
    | extend module = tostring(extract("Module: ([^: .*]+) -", 1, message))
    | extend innerMessage = tostring(extract("Message: ([^:.*]+) - Parameters", 1, message))
    | extend parameters = tostring(extract("Parameters: ([^.*]+)", 1, message))
    | sort by timestamp desc | take 100
```

## Basic query

```kusto
traces 
    | extend component = tostring(extract("Component: ([^:\\/\\s]+);", 1, message)) 
    | where component == "ChatProxy"
    | limit 10
```

## Complex query

```kusto
traces
    | extend product = tostring(extract("Product: ([^: .*]+) - Component", 1, message))
    | extend component = tostring(extract("Component: ([^: .*]+);", 1, message))
    | extend componentGuid = tostring(extract("Component: .*;([^: .*]+) -", 1, message))
    | extend sequenceNumber = toint(extract("Sequence: ([^: .*]+) -", 1, message))
    | extend module = tostring(extract("Module: ([^: .*]+) -", 1, message))
    | extend innerMessage = tostring(extract("Message: ([^:.*]+) - Parameters", 1, message))
    | extend parameters = tostring(extract("Parameters: ([^.*]+)", 1, message))
    | where component contains "ChatProxy"
    | sort by timestamp desc | sort by sequenceNumber desc | take 100
```