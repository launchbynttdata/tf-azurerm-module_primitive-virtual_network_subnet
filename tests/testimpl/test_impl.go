package testimpl

import (
	"context"
	"os"
	"testing"

	"github.com/Azure/azure-sdk-for-go/sdk/azidentity"
	"github.com/Azure/azure-sdk-for-go/sdk/resourcemanager/network/armnetwork"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/launchbynttdata/lcaf-component-terratest/types"
	"github.com/stretchr/testify/assert"
)

func TestComposableComplete(t *testing.T, ctx types.TestContext) {
	subscriptionId := os.Getenv("ARM_SUBSCRIPTION_ID")
	if len(subscriptionId) == 0 {
		t.Fatal("ARM_SUBSCRIPTION_ID environment variable is not set")
	}

	cred, err := azidentity.NewDefaultAzureCredential(nil)
	if err != nil {
		t.Fatalf("Unable to get credentials: %v\n", err)
	}

	t.Run("TestAlwaysSucceeds", func(t *testing.T) {
		checkSubnetId(t, ctx, subscriptionId, cred)
	})
}

func checkSubnetId(t *testing.T, ctx types.TestContext, subscriptionId string, cred *azidentity.DefaultAzureCredential) {
	resourceGroupName := terraform.Output(t, ctx.TerratestTerraformOptions(), "resource_group_name")
	virtualNetworkName := terraform.Output(t, ctx.TerratestTerraformOptions(), "virtual_network_name")
	subnetName := terraform.Output(t, ctx.TerratestTerraformOptions(), "azurerm_subnet_name")
	subnetId := terraform.Output(t, ctx.TerratestTerraformOptions(), "azurerm_subnet_id")

	client := getSubnetsClientClient(t, subscriptionId, cred)

	subnet, err := client.Get(context.TODO(), resourceGroupName, virtualNetworkName, subnetName, nil)
    if err != nil {
        t.Fatalf("failed to get subnet: %v", err)
    }

	assert.Equal(t, *subnet.ID, subnetId, "Subnet ID does not match")
}

func getSubnetsClientClient(t *testing.T, subscriptionId string, cred *azidentity.DefaultAzureCredential) *armnetwork.SubnetsClient {
	client, err := armnetwork.NewSubnetsClient(subscriptionId, cred, nil)
	if err != nil {
		t.Fatalf("Error creating Subnets client: %v", err)
	}
	return client
}
