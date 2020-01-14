package io.famargon;

import static org.eclipse.microprofile.metrics.MetricUnits.NONE;

import javax.inject.Inject;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;

import org.eclipse.microprofile.metrics.annotation.Gauge;

@Path("/api")
public class ApiResource {

    @Path("/reverse")
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public ApiResult reverseWords(@QueryParam("text") String text) {
        return ApiResult.success(new StringBuilder(text).reverse().toString());
    }

    @Inject
    ConfigService configService;

    @Gauge(unit = NONE)
    @Path("/env")
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public ApiResult deploymentEnvironment() {
        return ApiResult.success(configService.getDeploymentEnvironment());
    }
}