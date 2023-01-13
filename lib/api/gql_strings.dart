const loginUserMutation = r"""
      mutation loginUser($username: String!, $password: String!) {
        loginUser(input: {
          username: $username,
          password: $password,
        }) {
            message,
            user {
              id,
              email,
              phone_number,
              roles {
                name
              },
            },
            token,
        }
      }
    """;

const diverQuery = r"""
    query ($id: ID!) {
      driver(id: $id){
        id
        first_name,
        assignment {
          vehicle{
            id
          }
        }
      }
    }
""";

const startTripMutation = """
      mutation createMileage(
        \$opening_mileage: Float,
        \$closing_mileage: Float,
        \$opening_date: String,
        \$closing_date: String,
        \$opening_file: Upload!,
        \$closing_file: Upload,
        \$opening_geo_points: String!,
        \$closing_geo_points: String!,
        \$vehicle_id: Int, 
        \$driver_id: Int,
        ) {
        createMileage(input: {
          opening_mileage: \$opening_mileage,
          closing_mileage: \$closing_mileage,
          opening_date: \$opening_date,
          closing_date: \$closing_date,
          opening_file: \$opening_file,
          closing_file: \$closing_file,
          opening_geo_points: \$opening_geo_points,
          closing_geo_points: \$closing_geo_points,
          description: "New Mileage",
          vehicle_id: \$vehicle_id,
          driver_id: \$driver_id,
        }) {
          message,
          mileage {
            id
          }
        }
      }
""";

const endTripMutation = """
      mutation updateMileage(
          \$id: Int!,
          \$closing_mileage: Float, 
          \$closing_date: String, 
          \$closing_file: Upload, 
          \$closing_geo_points: String
        ) {
        createMileage(input: {
          id: \$id,
          closing_mileage: \$closing_mileage,
          closing_date: \$closing_date,
          closing_file: \$closing_file,
          closing_geo_points: \$closing_geo_points,
        }) {
          message
        }
      }
""";
