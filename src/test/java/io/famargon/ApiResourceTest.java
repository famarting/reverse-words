package io.famargon;

import static io.restassured.RestAssured.given;
import static org.hamcrest.CoreMatchers.is;

import javax.inject.Inject;
import javax.json.bind.Jsonb;

import org.junit.jupiter.api.Test;

import io.quarkus.test.junit.QuarkusTest;

@QuarkusTest
public class ApiResourceTest {

    @Test
    public void testHelloEndpoint() {
        // given()
        //   .when().get("/api/reverse?text=clap")
        //   .then()
        //      .statusCode(200)
        //      .body(is(jsonb.toJson(ApiResult.success("palc"))));
    }

}