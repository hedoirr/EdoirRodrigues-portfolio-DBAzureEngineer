@description('Location for all resources')
param location string = resourceGroup().location

@description('Environment name')
param environment string = 'dev'

@description('Azure Data Factory name')
param dataFactoryName string

@description('Databricks workspace name')
param databricksName string

@description('Storage account name')
param storageAccountName string

@description('SQL server name')
param sqlServerName string

@description('SQL admin login')
param sqlAdminLogin string

@secure()
@description('SQL admin password')
param sqlAdminPassword string

resource storage 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    minimumTlsVersion: 'TLS1_2'
    isHnsEnabled: true
    supportsHttpsTrafficOnly: true
    allowBlobPublicAccess: false
  }
}

resource adf 'Microsoft.DataFactory/factories@2018-06-01' = {
  name: dataFactoryName
  location: location
  identity: {
    type: 'SystemAssigned'
  }
}

resource dbw 'Microsoft.Databricks/workspaces@2024-05-01' = {
  name: databricksName
  location: location
  sku: {
    name: 'standard'
  }
  properties: {
    managedResourceGroupId: '${subscription().id}/resourceGroups/${resourceGroup().name}-dbw-managed'
    publicNetworkAccess: 'Enabled'
  }
}

resource sqlServer 'Microsoft.Sql/servers@2023-08-01-preview' = {
  name: sqlServerName
  location: location
  properties: {
    administratorLogin: sqlAdminLogin
    administratorLoginPassword: sqlAdminPassword
    publicNetworkAccess: 'Enabled'
    version: '12.0'
  }
}

resource sqlDb 'Microsoft.Sql/servers/databases@2023-08-01-preview' = {
  parent: sqlServer
  name: 'sqldb-${environment}'
  location: location
  sku: {
    name: 'Basic'
    tier: 'Basic'
  }
}

resource bronzeContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-05-01' = {
  parent: storage::blobServices 'default'
  name: 'bronze'
  properties: {
    publicAccess: 'None'
  }
}

resource silverContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-05-01' = {
  parent: storage::blobServices 'default'
  name: 'silver'
  properties: {
    publicAccess: 'None'
  }
}

resource goldContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-05-01' = {
  parent: storage::blobServices 'default'
  name: 'gold'
  properties: {
    publicAccess: 'None'
  }
}

output adfId string = adf.id
output databricksId string = dbw.id
output storageId string = storage.id
output sqlDbName string = sqlDb.name