String getAreasQuery(String state) {
  return """
    query MyQuery {
      areas(filter: {area_name: {match: "$state"}}) {
        children {
          areaName
          uuid
          metadata {
            leaf
          }
          children {
            areaName
            uuid
            metadata {
              leaf
            }
            children {
              areaName
              uuid
              metadata {
                leaf
              }
              children {
                areaName
                uuid
                metadata {
                  leaf
                }
                children {
                  areaName
                  uuid
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
