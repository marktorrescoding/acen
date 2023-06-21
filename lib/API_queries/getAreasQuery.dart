String getAreasQuery(String state) {
  return """
    query MyQuery {
      areas(filter: {area_name: {match: "$state"}}) {
        children {
          areaName
          metadata {
            leaf
          }
          children {
            areaName
            metadata {
              leaf
            }
            children {
              areaName
              metadata {
                leaf
              }
              children {
                areaName
                metadata {
                  leaf
                }
                children {
                  areaName
                  metadata {
                    leaf
                  }
                }
              }
            }
          }
        }
      }
    }
  """;
}
