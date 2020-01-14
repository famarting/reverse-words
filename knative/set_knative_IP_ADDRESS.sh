# In Knative 0.2.x and prior versions, the `knative-ingressgateway` service was used instead of `istio-ingressgateway`.
INGRESSGATEWAY=knative-ingressgateway

# The use of `knative-ingressgateway` is deprecated in Knative v0.3.x.
# Use `istio-ingressgateway` instead, since `knative-ingressgateway`
# will be removed in Knative v0.4.
if kubectl get configmap config-istio -n knative-serving &> /dev/null; then
    INGRESSGATEWAY=istio-ingressgateway
fi

export IP_ADDRESS=$(oc get node  -o 'jsonpath={.items[0].status.addresses[0].address}'):$(oc get svc $INGRESSGATEWAY -n istio-system -o 'jsonpath={.spec.ports[?(@.port==80)].nodePort}')

echo $IP_ADDRESS