New-ADSyncRule  `
-Name 'In from AD - User Join' `
-Identifier '633c9cc8-9a74-4912-92d0-f93fae31d89a' `
-Description '' `
-Direction 'Inbound' `
-Precedence 100 `
-PrecedenceAfter '00000000-0000-0000-0000-000000000000' `
-PrecedenceBefore '00000000-0000-0000-0000-000000000000' `
-SourceObjectType 'user' `
-TargetObjectType 'person' `
-Connector '093c3526-55a5-4de9-9005-186fd0a6a849' `
-LinkType 'Provision' `
-SoftDeleteExpiryInterval 0 `
-ImmutableTag 'Microsoft.InfromADUserJoin.004' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('mailNickname','sAMAccountName') `
-Destination 'cloudFiltered' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'IIF(IsPresent([isCriticalSystemObject]) || IsPresent([sAMAccountName]) = False || [sAMAccountName] = "SUPPORT_388945a0" || Left([mailNickname], 14) = "SystemMailbox{" || Left([sAMAccountName], 4) = "AAD_" || (Left([mailNickname], 4) = "CAS_" && (InStr([mailNickname], "}") > 0)) || (Left([sAMAccountName], 4) = "CAS_" && (InStr([sAMAccountName], "}") > 0)) || Left([sAMAccountName], 5) = "MSOL_" || CBool(IIF(IsPresent([msExchRecipientTypeDetails]),BitAnd([msExchRecipientTypeDetails],&H21C07000) > 0,NULL)) || CBool(InStr(DNComponent(CRef([dn]),1),"\\0ACNF:")>0), True, NULL)' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('objectGUID','mS-DS-ConsistencyGuid') `
-Destination 'sourceAnchorBinary' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'IIF(IsPresent([mS-DS-ConsistencyGuid]),[mS-DS-ConsistencyGuid],[objectGUID])' `
-OutVariable syncRule


New-Object  `
-TypeName 'Microsoft.IdentityManagement.PowerShell.ObjectModel.ScopeCondition' `
-ArgumentList 'isCriticalSystemObject','TRUE','NOTEQUAL' `
-OutVariable condition0


New-Object  `
-TypeName 'Microsoft.IdentityManagement.PowerShell.ObjectModel.ScopeCondition' `
-ArgumentList 'adminDescription','User_','NOTSTARTSWITH' `
-OutVariable condition1


Add-ADSyncScopeConditionGroup  `
-SynchronizationRule $syncRule[0] `
-ScopeConditions @($condition0[0],$condition1[0]) `
-OutVariable syncRule


New-Object  `
-TypeName 'Microsoft.IdentityManagement.PowerShell.ObjectModel.JoinCondition' `
-ArgumentList 'mS-DS-ConsistencyGuid','sourceAnchorBinary',$false `
-OutVariable condition0


Add-ADSyncJoinConditionGroup  `
-SynchronizationRule $syncRule[0] `
-JoinConditions @($condition0[0]) `
-OutVariable syncRule


New-Object  `
-TypeName 'Microsoft.IdentityManagement.PowerShell.ObjectModel.JoinCondition' `
-ArgumentList 'objectGUID','sourceAnchorBinary',$false `
-OutVariable condition0


Add-ADSyncJoinConditionGroup  `
-SynchronizationRule $syncRule[0] `
-JoinConditions @($condition0[0]) `
-OutVariable syncRule


Add-ADSyncRule  `
-SynchronizationRule $syncRule[0]


Get-ADSyncRule  `
-Identifier '633c9cc8-9a74-4912-92d0-f93fae31d89a'


New-ADSyncRule  `
-Name 'In from AD - InetOrgPerson Join' `
-Identifier 'ac082860-ff00-44c7-9c92-0eb32b4b01e5' `
-Description '' `
-Direction 'Inbound' `
-Precedence 101 `
-PrecedenceAfter '00000000-0000-0000-0000-000000000000' `
-PrecedenceBefore '00000000-0000-0000-0000-000000000000' `
-SourceObjectType 'inetOrgPerson' `
-TargetObjectType 'person' `
-Connector '093c3526-55a5-4de9-9005-186fd0a6a849' `
-LinkType 'Provision' `
-SoftDeleteExpiryInterval 0 `
-ImmutableTag 'Microsoft.InfromADInetOrgPersonJoin.004' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('mailNickname','sAMAccountName') `
-Destination 'cloudFiltered' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'IIF(IsPresent([isCriticalSystemObject]) || IsPresent([sAMAccountName]) = False || [sAMAccountName] = "SUPPORT_388945a0" || Left([mailNickname], 14) = "SystemMailbox{" || Left([sAMAccountName], 4) = "AAD_" || (Left([mailNickname], 4) = "CAS_" && (InStr([mailNickname], "}") > 0)) || (Left([sAMAccountName], 4) = "CAS_" && (InStr([sAMAccountName], "}") > 0)) || Left([sAMAccountName], 5) = "MSOL_" || CBool(IIF(IsPresent([msExchRecipientTypeDetails]),BitAnd([msExchRecipientTypeDetails],&H21C07000) > 0,NULL)) || CBool(InStr(DNComponent(CRef([dn]),1),"\\0ACNF:")>0), True, NULL)' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('objectGUID','mS-DS-ConsistencyGuid') `
-Destination 'sourceAnchorBinary' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'IIF(IsPresent([mS-DS-ConsistencyGuid]),[mS-DS-ConsistencyGuid],[objectGUID])' `
-OutVariable syncRule


New-Object  `
-TypeName 'Microsoft.IdentityManagement.PowerShell.ObjectModel.ScopeCondition' `
-ArgumentList 'isCriticalSystemObject','TRUE','NOTEQUAL' `
-OutVariable condition0


Add-ADSyncScopeConditionGroup  `
-SynchronizationRule $syncRule[0] `
-ScopeConditions @($condition0[0]) `
-OutVariable syncRule


New-Object  `
-TypeName 'Microsoft.IdentityManagement.PowerShell.ObjectModel.JoinCondition' `
-ArgumentList 'mS-DS-ConsistencyGuid','sourceAnchorBinary',$false `
-OutVariable condition0


Add-ADSyncJoinConditionGroup  `
-SynchronizationRule $syncRule[0] `
-JoinConditions @($condition0[0]) `
-OutVariable syncRule


New-Object  `
-TypeName 'Microsoft.IdentityManagement.PowerShell.ObjectModel.JoinCondition' `
-ArgumentList 'objectGUID','sourceAnchorBinary',$false `
-OutVariable condition0


Add-ADSyncJoinConditionGroup  `
-SynchronizationRule $syncRule[0] `
-JoinConditions @($condition0[0]) `
-OutVariable syncRule


Add-ADSyncRule  `
-SynchronizationRule $syncRule[0]


Get-ADSyncRule  `
-Identifier 'ac082860-ff00-44c7-9c92-0eb32b4b01e5'


New-ADSyncRule  `
-Name 'In from AD - User AccountEnabled' `
-Identifier '3cc98420-8d2c-4f99-9d00-188097882e2b' `
-Description '' `
-Direction 'Inbound' `
-Precedence 102 `
-PrecedenceAfter '00000000-0000-0000-0000-000000000000' `
-PrecedenceBefore '00000000-0000-0000-0000-000000000000' `
-SourceObjectType 'user' `
-TargetObjectType 'person' `
-Connector '093c3526-55a5-4de9-9005-186fd0a6a849' `
-LinkType 'Join' `
-SoftDeleteExpiryInterval 0 `
-ImmutableTag 'Microsoft.InfromADUserAccountEnabled.007' `
-EnablePasswordSync  `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('True') `
-Destination 'accountEnabled' `
-FlowType 'Constant' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('cn') `
-Destination 'cn' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Destination 'contributingConnectorUser' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression '%Connector.ID%' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Destination 'domainFQDN' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression '%Domain.FQDN%' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Destination 'domainNetBios' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression '%Domain.Netbios%' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Destination 'forestFQDN' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression '%Forest.FQDN%' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Destination 'forestNetBios' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression '%Forest.Netbios%' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('objectSid') `
-Destination 'objectSid' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('objectSid') `
-Destination 'objectSidString' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'StringFromSid([objectSid])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('pwdLastSet') `
-Destination 'pwdLastSet' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'IIF(IsPresent([pwdLastSet]),CStr(FormatDateTime(DateFromNum([pwdLastSet]),"yyyyMMddHHmmss.0Z")),NULL)' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('mS-DS-ConsistencyGuid') `
-Destination 'sourceAnchorBinary' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression '
      IIF(IsPresent([msExchRecipientTypeDetails]),
          IIF([msExchRecipientTypeDetails]=2,NULL,
              IIF("mS-DS-ConsistencyGuid"="mS-DS-ConsistencyGuid",
                  IIF(IsPresent([mS-DS-ConsistencyGuid]),[mS-DS-ConsistencyGuid],[objectGUID]),
                  NULL)),
          IIF("mS-DS-ConsistencyGuid"="mS-DS-ConsistencyGuid",
              IIF(IsPresent([mS-DS-ConsistencyGuid]),[mS-DS-ConsistencyGuid],[objectGUID]),
              NULL))
      ' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('mS-DS-ConsistencyGuid') `
-Destination 'sourceAnchor' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'IIF(IsPresent([msExchRecipientTypeDetails]),IIF([msExchRecipientTypeDetails]=2,NULL,IIF("mS-DS-ConsistencyGuid"="mS-DS-ConsistencyGuid",IIF(IsPresent([mS-DS-ConsistencyGuid]),IIF(IsString([mS-DS-ConsistencyGuid]),CStr([mS-DS-ConsistencyGuid]),ConvertToBase64([mS-DS-ConsistencyGuid])),IIF(IsString([objectGUID]),CStr([objectGUID]),ConvertToBase64([objectGUID]))),IIF(IsString([mS-DS-ConsistencyGuid]),CStr([mS-DS-ConsistencyGuid]),ConvertToBase64([mS-DS-ConsistencyGuid])))),IIF("mS-DS-ConsistencyGuid"="mS-DS-ConsistencyGuid",IIF(IsPresent([mS-DS-ConsistencyGuid]),IIF(IsString([mS-DS-ConsistencyGuid]),CStr([mS-DS-ConsistencyGuid]),ConvertToBase64([mS-DS-ConsistencyGuid])),IIF(IsString([objectGUID]),CStr([objectGUID]),ConvertToBase64([objectGUID]))),IIF(IsString([mS-DS-ConsistencyGuid]),CStr([mS-DS-ConsistencyGuid]),ConvertToBase64([mS-DS-ConsistencyGuid]))))' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('sAMAccountName','userPrincipalName') `
-Destination 'userPrincipalName' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'IIF(IsPresent([userPrincipalName]),[userPrincipalName], IIF(IsPresent([sAMAccountName]),([sAMAccountName]&"@"&%Domain.FQDN%),Error("AccountName is not present")))' `
-OutVariable syncRule


New-Object  `
-TypeName 'Microsoft.IdentityManagement.PowerShell.ObjectModel.ScopeCondition' `
-ArgumentList 'userAccountControl','2','ISBITNOTSET' `
-OutVariable condition0


Add-ADSyncScopeConditionGroup  `
-SynchronizationRule $syncRule[0] `
-ScopeConditions @($condition0[0]) `
-OutVariable syncRule


Add-ADSyncRule  `
-SynchronizationRule $syncRule[0]


Get-ADSyncRule  `
-Identifier '3cc98420-8d2c-4f99-9d00-188097882e2b'


New-ADSyncRule  `
-Name 'In from AD - InetOrgPerson AccountEnabled' `
-Identifier 'bb7968f7-291f-408a-b524-8df51b2b81b0' `
-Description '' `
-Direction 'Inbound' `
-Precedence 103 `
-PrecedenceAfter '00000000-0000-0000-0000-000000000000' `
-PrecedenceBefore '00000000-0000-0000-0000-000000000000' `
-SourceObjectType 'inetOrgPerson' `
-TargetObjectType 'person' `
-Connector '093c3526-55a5-4de9-9005-186fd0a6a849' `
-LinkType 'Join' `
-SoftDeleteExpiryInterval 0 `
-ImmutableTag 'Microsoft.InfromADInetOrgPersonAccountEnabled.006' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('True') `
-Destination 'accountEnabled' `
-FlowType 'Constant' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('cn') `
-Destination 'cn' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Destination 'contributingConnectorUser' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression '%Connector.ID%' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Destination 'domainFQDN' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression '%Domain.FQDN%' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Destination 'domainNetBios' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression '%Domain.Netbios%' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Destination 'forestFQDN' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression '%Forest.FQDN%' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Destination 'forestNetBios' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression '%Forest.Netbios%' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('objectSid') `
-Destination 'objectSid' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('objectSid') `
-Destination 'objectSidString' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'StringFromSid([objectSid])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('pwdLastSet') `
-Destination 'pwdLastSet' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'IIF(IsPresent([pwdLastSet]),CStr(FormatDateTime(DateFromNum([pwdLastSet]),"yyyyMMddHHmmss.0Z")),NULL)' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('mS-DS-ConsistencyGuid') `
-Destination 'sourceAnchorBinary' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression '
      IIF(IsPresent([msExchRecipientTypeDetails]),
          IIF([msExchRecipientTypeDetails]=2,NULL,
              IIF("mS-DS-ConsistencyGuid"="mS-DS-ConsistencyGuid",
                  IIF(IsPresent([mS-DS-ConsistencyGuid]),[mS-DS-ConsistencyGuid],[objectGUID]),
                  NULL)),
          IIF("mS-DS-ConsistencyGuid"="mS-DS-ConsistencyGuid",
              IIF(IsPresent([mS-DS-ConsistencyGuid]),[mS-DS-ConsistencyGuid],[objectGUID]),
              NULL))
      ' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('mS-DS-ConsistencyGuid') `
-Destination 'sourceAnchor' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'IIF(IsPresent([msExchRecipientTypeDetails]),IIF([msExchRecipientTypeDetails]=2,NULL,IIF("mS-DS-ConsistencyGuid"="mS-DS-ConsistencyGuid",IIF(IsPresent([mS-DS-ConsistencyGuid]),IIF(IsString([mS-DS-ConsistencyGuid]),CStr([mS-DS-ConsistencyGuid]),ConvertToBase64([mS-DS-ConsistencyGuid])),IIF(IsString([objectGUID]),CStr([objectGUID]),ConvertToBase64([objectGUID]))),IIF(IsString([mS-DS-ConsistencyGuid]),CStr([mS-DS-ConsistencyGuid]),ConvertToBase64([mS-DS-ConsistencyGuid])))),IIF("mS-DS-ConsistencyGuid"="mS-DS-ConsistencyGuid",IIF(IsPresent([mS-DS-ConsistencyGuid]),IIF(IsString([mS-DS-ConsistencyGuid]),CStr([mS-DS-ConsistencyGuid]),ConvertToBase64([mS-DS-ConsistencyGuid])),IIF(IsString([objectGUID]),CStr([objectGUID]),ConvertToBase64([objectGUID]))),IIF(IsString([mS-DS-ConsistencyGuid]),CStr([mS-DS-ConsistencyGuid]),ConvertToBase64([mS-DS-ConsistencyGuid]))))' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('sAMAccountName','userPrincipalName') `
-Destination 'userPrincipalName' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'IIF(IsPresent([userPrincipalName]),[userPrincipalName], IIF(IsPresent([sAMAccountName]),([sAMAccountName]&"@"&%Domain.FQDN%),Error("AccountName is not present")))' `
-OutVariable syncRule


New-Object  `
-TypeName 'Microsoft.IdentityManagement.PowerShell.ObjectModel.ScopeCondition' `
-ArgumentList 'userAccountControl','2','ISBITNOTSET' `
-OutVariable condition0


Add-ADSyncScopeConditionGroup  `
-SynchronizationRule $syncRule[0] `
-ScopeConditions @($condition0[0]) `
-OutVariable syncRule


Add-ADSyncRule  `
-SynchronizationRule $syncRule[0]


Get-ADSyncRule  `
-Identifier 'bb7968f7-291f-408a-b524-8df51b2b81b0'


New-ADSyncRule  `
-Name 'In from AD - User Common from Exchange' `
-Identifier 'ec49c421-fea6-4258-899c-6d8eedf5c680' `
-Description 'Attributes from the forest where the user has an Exchange mailbox.' `
-Direction 'Inbound' `
-Precedence 104 `
-PrecedenceAfter '00000000-0000-0000-0000-000000000000' `
-PrecedenceBefore '00000000-0000-0000-0000-000000000000' `
-SourceObjectType 'user' `
-TargetObjectType 'person' `
-Connector '093c3526-55a5-4de9-9005-186fd0a6a849' `
-LinkType 'Join' `
-SoftDeleteExpiryInterval 0 `
-ImmutableTag 'Microsoft.InfromADUserCommonfromExchange.006' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('userAccountControl') `
-Destination 'accountEnabled' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'IIF(BitAnd([userAccountControl],2)=0,True,False)' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('sAMAccountName') `
-Destination 'accountName' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('assistant') `
-Destination 'assistant' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('c') `
-Destination 'c' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([c])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('cn') `
-Destination 'cn' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('co') `
-Destination 'co' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([co])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('company') `
-Destination 'company' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([company])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('countryCode') `
-Destination 'countryCode' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('department') `
-Destination 'department' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([department])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('description') `
-Destination 'description' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'IIF(IsNullOrEmpty([description]),NULL,Left(Trim(Item([description],1)),448))' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('displayName','cn') `
-Destination 'displayName' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'IIF(IsNullOrEmpty([displayName]),[cn],[displayName])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('employeeID') `
-Destination 'employeeID' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute1') `
-Destination 'extensionAttribute1' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute1])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute2') `
-Destination 'extensionAttribute2' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute2])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute3') `
-Destination 'extensionAttribute3' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute3])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute4') `
-Destination 'extensionAttribute4' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute4])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute5') `
-Destination 'extensionAttribute5' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute5])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute6') `
-Destination 'extensionAttribute6' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute6])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute7') `
-Destination 'extensionAttribute7' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute7])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute8') `
-Destination 'extensionAttribute8' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute8])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute9') `
-Destination 'extensionAttribute9' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute9])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute10') `
-Destination 'extensionAttribute10' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute10])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute11') `
-Destination 'extensionAttribute11' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute11])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute12') `
-Destination 'extensionAttribute12' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute12])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute13') `
-Destination 'extensionAttribute13' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute13])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute14') `
-Destination 'extensionAttribute14' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute14])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute15') `
-Destination 'extensionAttribute15' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute15])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('facsimileTelephoneNumber') `
-Destination 'facsimileTelephoneNumber' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([facsimileTelephoneNumber])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('givenName') `
-Destination 'givenName' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([givenName])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('homePhone') `
-Destination 'homePhone' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([homePhone])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('info') `
-Destination 'info' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Left(Trim([info]),448)' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('initials') `
-Destination 'initials' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([initials])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('ipPhone') `
-Destination 'ipPhone' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([ipPhone])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('l') `
-Destination 'l' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([l])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('mail') `
-Destination 'mail' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([mail])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('manager') `
-Destination 'manager' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('middleName') `
-Destination 'middleName' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([middleName])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('mobile') `
-Destination 'mobile' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([mobile])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('otherFacsimileTelephoneNumber') `
-Destination 'otherFacsimileTelephoneNumber' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([otherFacsimileTelephoneNumber])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('otherHomePhone') `
-Destination 'otherHomePhone' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([otherHomePhone])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('otherMobile') `
-Destination 'otherMobile' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([otherMobile])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('otherIpPhone') `
-Destination 'otherIpPhone' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([otherIpPhone])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('otherPager') `
-Destination 'otherPager' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([otherPager])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('otherTelephone') `
-Destination 'otherTelephone' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([otherTelephone])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('pager') `
-Destination 'pager' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([pager])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('physicalDeliveryOfficeName') `
-Destination 'physicalDeliveryOfficeName' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([physicalDeliveryOfficeName])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('postalCode') `
-Destination 'postalCode' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([postalCode])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('postOfficeBox') `
-Destination 'postOfficeBox' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'IIF(IsNullOrEmpty([postOfficeBox]),NULL,Left(Trim(Item([postOfficeBox],1)),448))' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('preferredLanguage') `
-Destination 'preferredLanguage' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([preferredLanguage])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('proxyAddresses') `
-Destination 'proxyAddresses' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'RemoveDuplicates(Trim(ImportedValue("proxyAddresses")))' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('sn') `
-Destination 'sn' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([sn])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchRecipientTypeDetails') `
-Destination 'sourceObjectType' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'IIF(IsPresent([msExchRecipientTypeDetails]), IIF([msExchRecipientTypeDetails]=2, NULL, "User"), "User")' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('st') `
-Destination 'st' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([st])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('streetAddress') `
-Destination 'streetAddress' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([streetAddress])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('telephoneNumber') `
-Destination 'telephoneNumber' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([telephoneNumber])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('thumbnailPhoto') `
-Destination 'thumbnailPhoto' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('title') `
-Destination 'title' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([title])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('url') `
-Destination 'url' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'IIF(IsNullOrEmpty([url]),NULL,Left(Trim(Item([url],1)),448))' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('wWWHomePage') `
-Destination 'wWWHomePage' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([wWWHomePage])' `
-OutVariable syncRule


New-Object  `
-TypeName 'Microsoft.IdentityManagement.PowerShell.ObjectModel.ScopeCondition' `
-ArgumentList 'mailNickname','','ISNOTNULL' `
-OutVariable condition0


New-Object  `
-TypeName 'Microsoft.IdentityManagement.PowerShell.ObjectModel.ScopeCondition' `
-ArgumentList 'adminDescription','User_','NOTSTARTSWITH' `
-OutVariable condition1


Add-ADSyncScopeConditionGroup  `
-SynchronizationRule $syncRule[0] `
-ScopeConditions @($condition0[0],$condition1[0]) `
-OutVariable syncRule


Add-ADSyncRule  `
-SynchronizationRule $syncRule[0]


Get-ADSyncRule  `
-Identifier 'ec49c421-fea6-4258-899c-6d8eedf5c680'


New-ADSyncRule  `
-Name 'In from AD - InetOrgPerson Common from Exchange' `
-Identifier 'aca52009-5dde-411f-9beb-f632d5bad7dd' `
-Description 'Attributes from the forest where the InetOrgPerson has an Exchange mailbox.' `
-Direction 'Inbound' `
-Precedence 105 `
-PrecedenceAfter '00000000-0000-0000-0000-000000000000' `
-PrecedenceBefore '00000000-0000-0000-0000-000000000000' `
-SourceObjectType 'inetOrgPerson' `
-TargetObjectType 'person' `
-Connector '093c3526-55a5-4de9-9005-186fd0a6a849' `
-LinkType 'Join' `
-SoftDeleteExpiryInterval 0 `
-ImmutableTag 'Microsoft.InfromADInetOrgPersonCommonfromExchange.006' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('userAccountControl') `
-Destination 'accountEnabled' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'IIF(BitAnd([userAccountControl],2)=0,True,False)' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('sAMAccountName') `
-Destination 'accountName' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('assistant') `
-Destination 'assistant' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('c') `
-Destination 'c' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([c])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('cn') `
-Destination 'cn' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('co') `
-Destination 'co' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([co])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('company') `
-Destination 'company' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([company])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('countryCode') `
-Destination 'countryCode' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('department') `
-Destination 'department' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([department])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('description') `
-Destination 'description' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'IIF(IsNullOrEmpty([description]),NULL,Left(Trim(Item([description],1)),448))' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('displayName','cn') `
-Destination 'displayName' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'IIF(IsNullOrEmpty([displayName]),[cn],[displayName])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute1') `
-Destination 'extensionAttribute1' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute1])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute2') `
-Destination 'extensionAttribute2' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute2])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute3') `
-Destination 'extensionAttribute3' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute3])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute4') `
-Destination 'extensionAttribute4' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute4])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute5') `
-Destination 'extensionAttribute5' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute5])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute6') `
-Destination 'extensionAttribute6' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute6])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute7') `
-Destination 'extensionAttribute7' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute7])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute8') `
-Destination 'extensionAttribute8' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute8])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute9') `
-Destination 'extensionAttribute9' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute9])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute10') `
-Destination 'extensionAttribute10' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute10])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute11') `
-Destination 'extensionAttribute11' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute11])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute12') `
-Destination 'extensionAttribute12' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute12])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute13') `
-Destination 'extensionAttribute13' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute13])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute14') `
-Destination 'extensionAttribute14' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute14])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute15') `
-Destination 'extensionAttribute15' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute15])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('facsimileTelephoneNumber') `
-Destination 'facsimileTelephoneNumber' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([facsimileTelephoneNumber])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('givenName') `
-Destination 'givenName' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([givenName])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('homePhone') `
-Destination 'homePhone' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([homePhone])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('info') `
-Destination 'info' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Left(Trim([info]),448)' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('initials') `
-Destination 'initials' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([initials])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('ipPhone') `
-Destination 'ipPhone' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([ipPhone])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('l') `
-Destination 'l' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([l])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('mail') `
-Destination 'mail' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([mail])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('manager') `
-Destination 'manager' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('middleName') `
-Destination 'middleName' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([middleName])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('mobile') `
-Destination 'mobile' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([mobile])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('otherFacsimileTelephoneNumber') `
-Destination 'otherFacsimileTelephoneNumber' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([otherFacsimileTelephoneNumber])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('otherHomePhone') `
-Destination 'otherHomePhone' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([otherHomePhone])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('otherMobile') `
-Destination 'otherMobile' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([otherMobile])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('otherIpPhone') `
-Destination 'otherIpPhone' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([otherIpPhone])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('otherPager') `
-Destination 'otherPager' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([otherPager])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('otherTelephone') `
-Destination 'otherTelephone' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([otherTelephone])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('pager') `
-Destination 'pager' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([pager])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('physicalDeliveryOfficeName') `
-Destination 'physicalDeliveryOfficeName' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([physicalDeliveryOfficeName])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('postalCode') `
-Destination 'postalCode' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([postalCode])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('postOfficeBox') `
-Destination 'postOfficeBox' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'IIF(IsNullOrEmpty([postOfficeBox]),NULL,Left(Trim(Item([postOfficeBox],1)),448))' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('preferredLanguage') `
-Destination 'preferredLanguage' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([preferredLanguage])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('proxyAddresses') `
-Destination 'proxyAddresses' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'RemoveDuplicates(Trim(ImportedValue("proxyAddresses")))' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('sn') `
-Destination 'sn' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([sn])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchRecipientTypeDetails') `
-Destination 'sourceObjectType' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'IIF(IsPresent([msExchRecipientTypeDetails]), IIF([msExchRecipientTypeDetails]=2, NULL, "User"), "User")' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('st') `
-Destination 'st' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([st])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('streetAddress') `
-Destination 'streetAddress' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([streetAddress])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('telephoneNumber') `
-Destination 'telephoneNumber' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([telephoneNumber])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('thumbnailPhoto') `
-Destination 'thumbnailPhoto' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('title') `
-Destination 'title' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([title])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('url') `
-Destination 'url' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'IIF(IsNullOrEmpty([url]),NULL,Left(Trim(Item([url],1)),448))' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('wWWHomePage') `
-Destination 'wWWHomePage' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([wWWHomePage])' `
-OutVariable syncRule


New-Object  `
-TypeName 'Microsoft.IdentityManagement.PowerShell.ObjectModel.ScopeCondition' `
-ArgumentList 'mailNickname','','ISNOTNULL' `
-OutVariable condition0


Add-ADSyncScopeConditionGroup  `
-SynchronizationRule $syncRule[0] `
-ScopeConditions @($condition0[0]) `
-OutVariable syncRule


Add-ADSyncRule  `
-SynchronizationRule $syncRule[0]


Get-ADSyncRule  `
-Identifier 'aca52009-5dde-411f-9beb-f632d5bad7dd'


New-ADSyncRule  `
-Name 'In from AD - User Common' `
-Identifier '3f73ac6e-997b-4d50-91f0-b5035705f94c' `
-Description '' `
-Direction 'Inbound' `
-Precedence 106 `
-PrecedenceAfter '00000000-0000-0000-0000-000000000000' `
-PrecedenceBefore '00000000-0000-0000-0000-000000000000' `
-SourceObjectType 'user' `
-TargetObjectType 'person' `
-Connector '093c3526-55a5-4de9-9005-186fd0a6a849' `
-LinkType 'Join' `
-SoftDeleteExpiryInterval 0 `
-ImmutableTag 'Microsoft.InfromADUserCommon.008' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('userAccountControl') `
-Destination 'accountEnabled' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'IIF(BitAnd([userAccountControl],2)=0,True,False)' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('sAMAccountName') `
-Destination 'accountName' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('assistant') `
-Destination 'assistant' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('c') `
-Destination 'c' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([c])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('cn') `
-Destination 'cn' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('co') `
-Destination 'co' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([co])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('company') `
-Destination 'company' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([company])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('countryCode') `
-Destination 'countryCode' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('department') `
-Destination 'department' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([department])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('description') `
-Destination 'description' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'IIF(IsNullOrEmpty([description]),NULL,Left(Trim(Item([description],1)),448))' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('displayName','cn') `
-Destination 'displayName' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'IIF(IsNullOrEmpty([displayName]),[cn],[displayName])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Destination 'domainFQDN' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression '%Domain.FQDN%' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Destination 'domainNetBios' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression '%Domain.Netbios%' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('employeeID') `
-Destination 'employeeID' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute1') `
-Destination 'extensionAttribute1' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute1])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute2') `
-Destination 'extensionAttribute2' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute2])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute3') `
-Destination 'extensionAttribute3' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute3])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute4') `
-Destination 'extensionAttribute4' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute4])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute5') `
-Destination 'extensionAttribute5' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute5])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute6') `
-Destination 'extensionAttribute6' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute6])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute7') `
-Destination 'extensionAttribute7' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute7])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute8') `
-Destination 'extensionAttribute8' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute8])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute9') `
-Destination 'extensionAttribute9' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute9])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute10') `
-Destination 'extensionAttribute10' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute10])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute11') `
-Destination 'extensionAttribute11' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute11])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute12') `
-Destination 'extensionAttribute12' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute12])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute13') `
-Destination 'extensionAttribute13' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute13])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute14') `
-Destination 'extensionAttribute14' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute14])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute15') `
-Destination 'extensionAttribute15' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute15])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('facsimileTelephoneNumber') `
-Destination 'facsimileTelephoneNumber' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([facsimileTelephoneNumber])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Destination 'forestFQDN' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression '%Forest.FQDN%' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Destination 'forestNetBios' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression '%Forest.Netbios%' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('givenName') `
-Destination 'givenName' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([givenName])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('homePhone') `
-Destination 'homePhone' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([homePhone])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('info') `
-Destination 'info' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Left(Trim([info]),448)' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('initials') `
-Destination 'initials' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([initials])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('ipPhone') `
-Destination 'ipPhone' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([ipPhone])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('l') `
-Destination 'l' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([l])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('mail') `
-Destination 'mail' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([mail])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('manager') `
-Destination 'manager' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('middleName') `
-Destination 'middleName' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([middleName])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('mobile') `
-Destination 'mobile' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([mobile])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('objectSid') `
-Destination 'objectSid' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('objectSid') `
-Destination 'objectSidString' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'StringFromSid([objectSid])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('otherFacsimileTelephoneNumber') `
-Destination 'otherFacsimileTelephoneNumber' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([otherFacsimileTelephoneNumber])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('otherHomePhone') `
-Destination 'otherHomePhone' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([otherHomePhone])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('otherMobile') `
-Destination 'otherMobile' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([otherMobile])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('otherIpPhone') `
-Destination 'otherIpPhone' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([otherIpPhone])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('otherPager') `
-Destination 'otherPager' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([otherPager])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('otherTelephone') `
-Destination 'otherTelephone' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([otherTelephone])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('pager') `
-Destination 'pager' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([pager])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('physicalDeliveryOfficeName') `
-Destination 'physicalDeliveryOfficeName' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([physicalDeliveryOfficeName])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('postalCode') `
-Destination 'postalCode' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([postalCode])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('postOfficeBox') `
-Destination 'postOfficeBox' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'IIF(IsNullOrEmpty([postOfficeBox]),NULL,Left(Trim(Item([postOfficeBox],1)),448))' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('preferredLanguage') `
-Destination 'preferredLanguage' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([preferredLanguage])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('proxyAddresses') `
-Destination 'proxyAddresses' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'RemoveDuplicates(Trim(ImportedValue("proxyAddresses")))' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('pwdLastSet') `
-Destination 'pwdLastSet' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'IIF(IsPresent([pwdLastSet]),CStr(FormatDateTime(DateFromNum([pwdLastSet]),"yyyyMMddHHmmss.0Z")),NULL)' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('sn') `
-Destination 'sn' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([sn])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('mS-DS-ConsistencyGuid') `
-Destination 'sourceAnchorBinary' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression '
      IIF(IsPresent([msExchRecipientTypeDetails]),
          IIF([msExchRecipientTypeDetails]=2,NULL,
              IIF("mS-DS-ConsistencyGuid"="mS-DS-ConsistencyGuid",
                  IIF(IsPresent([mS-DS-ConsistencyGuid]),[mS-DS-ConsistencyGuid],[objectGUID]),
                  NULL)),
          IIF("mS-DS-ConsistencyGuid"="mS-DS-ConsistencyGuid",
              IIF(IsPresent([mS-DS-ConsistencyGuid]),[mS-DS-ConsistencyGuid],[objectGUID]),
              NULL))
      ' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('mS-DS-ConsistencyGuid') `
-Destination 'sourceAnchor' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'IIF(IsPresent([msExchRecipientTypeDetails]),IIF([msExchRecipientTypeDetails]=2,NULL,IIF("mS-DS-ConsistencyGuid"="mS-DS-ConsistencyGuid",IIF(IsPresent([mS-DS-ConsistencyGuid]),IIF(IsString([mS-DS-ConsistencyGuid]),CStr([mS-DS-ConsistencyGuid]),ConvertToBase64([mS-DS-ConsistencyGuid])),IIF(IsString([objectGUID]),CStr([objectGUID]),ConvertToBase64([objectGUID]))),IIF(IsString([mS-DS-ConsistencyGuid]),CStr([mS-DS-ConsistencyGuid]),ConvertToBase64([mS-DS-ConsistencyGuid])))),IIF("mS-DS-ConsistencyGuid"="mS-DS-ConsistencyGuid",IIF(IsPresent([mS-DS-ConsistencyGuid]),IIF(IsString([mS-DS-ConsistencyGuid]),CStr([mS-DS-ConsistencyGuid]),ConvertToBase64([mS-DS-ConsistencyGuid])),IIF(IsString([objectGUID]),CStr([objectGUID]),ConvertToBase64([objectGUID]))),IIF(IsString([mS-DS-ConsistencyGuid]),CStr([mS-DS-ConsistencyGuid]),ConvertToBase64([mS-DS-ConsistencyGuid]))))' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchRecipientTypeDetails') `
-Destination 'sourceObjectType' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'IIF(IsPresent([msExchRecipientTypeDetails]), IIF([msExchRecipientTypeDetails]=2, NULL, "User"), "User")' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('st') `
-Destination 'st' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([st])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('streetAddress') `
-Destination 'streetAddress' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([streetAddress])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('telephoneNumber') `
-Destination 'telephoneNumber' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([telephoneNumber])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('thumbnailPhoto') `
-Destination 'thumbnailPhoto' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('title') `
-Destination 'title' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([title])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('sAMAccountName','userPrincipalName') `
-Destination 'userPrincipalName' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'IIF(IsPresent([userPrincipalName]),[userPrincipalName], IIF(IsPresent([sAMAccountName]),([sAMAccountName]&"@"&%Domain.FQDN%),Error("AccountName is not present")))' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('url') `
-Destination 'url' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'IIF(IsNullOrEmpty([url]),NULL,Left(Trim(Item([url],1)),448))' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('wWWHomePage') `
-Destination 'wWWHomePage' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([wWWHomePage])' `
-OutVariable syncRule


New-Object  `
-TypeName 'Microsoft.IdentityManagement.PowerShell.ObjectModel.ScopeCondition' `
-ArgumentList 'adminDescription','User_','NOTSTARTSWITH' `
-OutVariable condition0


Add-ADSyncScopeConditionGroup  `
-SynchronizationRule $syncRule[0] `
-ScopeConditions @($condition0[0]) `
-OutVariable syncRule


Add-ADSyncRule  `
-SynchronizationRule $syncRule[0]


Get-ADSyncRule  `
-Identifier '3f73ac6e-997b-4d50-91f0-b5035705f94c'


New-ADSyncRule  `
-Name 'In from AD - InetOrgPerson Common' `
-Identifier 'c5f8f29a-44c2-45bd-8a7a-0c4cce6951d7' `
-Description '' `
-Direction 'Inbound' `
-Precedence 107 `
-PrecedenceAfter '00000000-0000-0000-0000-000000000000' `
-PrecedenceBefore '00000000-0000-0000-0000-000000000000' `
-SourceObjectType 'inetOrgPerson' `
-TargetObjectType 'person' `
-Connector '093c3526-55a5-4de9-9005-186fd0a6a849' `
-LinkType 'Join' `
-SoftDeleteExpiryInterval 0 `
-ImmutableTag 'Microsoft.InfromADInetOrgPersonCommon.007' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('userAccountControl') `
-Destination 'accountEnabled' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'IIF(BitAnd([userAccountControl],2)=0,True,False)' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('sAMAccountName') `
-Destination 'accountName' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('assistant') `
-Destination 'assistant' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('c') `
-Destination 'c' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([c])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('cn') `
-Destination 'cn' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('co') `
-Destination 'co' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([co])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('company') `
-Destination 'company' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([company])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('countryCode') `
-Destination 'countryCode' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('department') `
-Destination 'department' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([department])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('description') `
-Destination 'description' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'IIF(IsNullOrEmpty([description]),NULL,Left(Trim(Item([description],1)),448))' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('displayName','cn') `
-Destination 'displayName' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'IIF(IsNullOrEmpty([displayName]),[cn],[displayName])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Destination 'domainFQDN' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression '%Domain.FQDN%' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Destination 'domainNetBios' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression '%Domain.Netbios%' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute1') `
-Destination 'extensionAttribute1' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute1])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute2') `
-Destination 'extensionAttribute2' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute2])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute3') `
-Destination 'extensionAttribute3' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute3])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute4') `
-Destination 'extensionAttribute4' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute4])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute5') `
-Destination 'extensionAttribute5' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute5])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute6') `
-Destination 'extensionAttribute6' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute6])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute7') `
-Destination 'extensionAttribute7' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute7])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute8') `
-Destination 'extensionAttribute8' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute8])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute9') `
-Destination 'extensionAttribute9' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute9])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute10') `
-Destination 'extensionAttribute10' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute10])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute11') `
-Destination 'extensionAttribute11' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute11])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute12') `
-Destination 'extensionAttribute12' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute12])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute13') `
-Destination 'extensionAttribute13' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute13])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute14') `
-Destination 'extensionAttribute14' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute14])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute15') `
-Destination 'extensionAttribute15' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute15])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('facsimileTelephoneNumber') `
-Destination 'facsimileTelephoneNumber' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([facsimileTelephoneNumber])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Destination 'forestFQDN' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression '%Forest.FQDN%' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Destination 'forestNetBios' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression '%Forest.Netbios%' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('givenName') `
-Destination 'givenName' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([givenName])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('homePhone') `
-Destination 'homePhone' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([homePhone])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('info') `
-Destination 'info' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Left(Trim([info]),448)' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('initials') `
-Destination 'initials' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([initials])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('ipPhone') `
-Destination 'ipPhone' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([ipPhone])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('l') `
-Destination 'l' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([l])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('mail') `
-Destination 'mail' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([mail])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('manager') `
-Destination 'manager' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('middleName') `
-Destination 'middleName' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([middleName])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('mobile') `
-Destination 'mobile' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([mobile])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('objectSid') `
-Destination 'objectSid' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('objectSid') `
-Destination 'objectSidString' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'StringFromSid([objectSid])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('otherFacsimileTelephoneNumber') `
-Destination 'otherFacsimileTelephoneNumber' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([otherFacsimileTelephoneNumber])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('otherHomePhone') `
-Destination 'otherHomePhone' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([otherHomePhone])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('otherMobile') `
-Destination 'otherMobile' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([otherMobile])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('otherIpPhone') `
-Destination 'otherIpPhone' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([otherIpPhone])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('otherPager') `
-Destination 'otherPager' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([otherPager])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('otherTelephone') `
-Destination 'otherTelephone' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([otherTelephone])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('pager') `
-Destination 'pager' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([pager])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('physicalDeliveryOfficeName') `
-Destination 'physicalDeliveryOfficeName' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([physicalDeliveryOfficeName])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('postalCode') `
-Destination 'postalCode' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([postalCode])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('postOfficeBox') `
-Destination 'postOfficeBox' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'IIF(IsNullOrEmpty([postOfficeBox]),NULL,Left(Trim(Item([postOfficeBox],1)),448))' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('preferredLanguage') `
-Destination 'preferredLanguage' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([preferredLanguage])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('pwdLastSet') `
-Destination 'pwdLastSet' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'IIF(IsPresent([pwdLastSet]),CStr(FormatDateTime(DateFromNum([pwdLastSet]),"yyyyMMddHHmmss.0Z")),NULL)' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('sn') `
-Destination 'sn' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([sn])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('mS-DS-ConsistencyGuid') `
-Destination 'sourceAnchorBinary' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression '
      IIF(IsPresent([msExchRecipientTypeDetails]),
          IIF([msExchRecipientTypeDetails]=2,NULL,
              IIF("mS-DS-ConsistencyGuid"="mS-DS-ConsistencyGuid",
                  IIF(IsPresent([mS-DS-ConsistencyGuid]),[mS-DS-ConsistencyGuid],[objectGUID]),
                  NULL)),
          IIF("mS-DS-ConsistencyGuid"="mS-DS-ConsistencyGuid",
              IIF(IsPresent([mS-DS-ConsistencyGuid]),[mS-DS-ConsistencyGuid],[objectGUID]),
              NULL))
      ' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('mS-DS-ConsistencyGuid') `
-Destination 'sourceAnchor' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'IIF(IsPresent([msExchRecipientTypeDetails]),IIF([msExchRecipientTypeDetails]=2,NULL,IIF("mS-DS-ConsistencyGuid"="mS-DS-ConsistencyGuid",IIF(IsPresent([mS-DS-ConsistencyGuid]),IIF(IsString([mS-DS-ConsistencyGuid]),CStr([mS-DS-ConsistencyGuid]),ConvertToBase64([mS-DS-ConsistencyGuid])),IIF(IsString([objectGUID]),CStr([objectGUID]),ConvertToBase64([objectGUID]))),IIF(IsString([mS-DS-ConsistencyGuid]),CStr([mS-DS-ConsistencyGuid]),ConvertToBase64([mS-DS-ConsistencyGuid])))),IIF("mS-DS-ConsistencyGuid"="mS-DS-ConsistencyGuid",IIF(IsPresent([mS-DS-ConsistencyGuid]),IIF(IsString([mS-DS-ConsistencyGuid]),CStr([mS-DS-ConsistencyGuid]),ConvertToBase64([mS-DS-ConsistencyGuid])),IIF(IsString([objectGUID]),CStr([objectGUID]),ConvertToBase64([objectGUID]))),IIF(IsString([mS-DS-ConsistencyGuid]),CStr([mS-DS-ConsistencyGuid]),ConvertToBase64([mS-DS-ConsistencyGuid]))))' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchRecipientTypeDetails') `
-Destination 'sourceObjectType' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'IIF(IsPresent([msExchRecipientTypeDetails]), IIF([msExchRecipientTypeDetails]=2, NULL, "User"), "User")' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('st') `
-Destination 'st' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([st])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('streetAddress') `
-Destination 'streetAddress' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([streetAddress])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('telephoneNumber') `
-Destination 'telephoneNumber' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([telephoneNumber])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('thumbnailPhoto') `
-Destination 'thumbnailPhoto' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('title') `
-Destination 'title' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([title])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('sAMAccountName','userPrincipalName') `
-Destination 'userPrincipalName' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'IIF(IsPresent([userPrincipalName]),[userPrincipalName], IIF(IsPresent([sAMAccountName]),([sAMAccountName]&"@"&%Domain.FQDN%),Error("AccountName is not present")))' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('url') `
-Destination 'url' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'IIF(IsNullOrEmpty([url]),NULL,Left(Trim(Item([url],1)),448))' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('wWWHomePage') `
-Destination 'wWWHomePage' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([wWWHomePage])' `
-OutVariable syncRule


Add-ADSyncRule  `
-SynchronizationRule $syncRule[0]


Get-ADSyncRule  `
-Identifier 'c5f8f29a-44c2-45bd-8a7a-0c4cce6951d7'


New-ADSyncRule  `
-Name 'In from AD - User Exchange' `
-Identifier 'cd66859f-df8b-4d9d-aa38-7b50f674d8c4' `
-Description 'User object with Exchange schema in Active Directory.' `
-Direction 'Inbound' `
-Precedence 108 `
-PrecedenceAfter '00000000-0000-0000-0000-000000000000' `
-PrecedenceBefore '00000000-0000-0000-0000-000000000000' `
-SourceObjectType 'user' `
-TargetObjectType 'person' `
-Connector '093c3526-55a5-4de9-9005-186fd0a6a849' `
-LinkType 'Join' `
-SoftDeleteExpiryInterval 0 `
-ImmutableTag 'Microsoft.InfromADUserExchange.004' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('altRecipient') `
-Destination 'altRecipient' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('authOrig') `
-Destination 'authOrig' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Destination 'contributingConnectorExchange' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression '%Connector.ID%' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('dLMemRejectPerms') `
-Destination 'dLMemRejectPerms' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('dLMemSubmitPerms') `
-Destination 'dLMemSubmitPerms' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute1') `
-Destination 'extensionAttribute1' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute1])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute2') `
-Destination 'extensionAttribute2' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute2])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute3') `
-Destination 'extensionAttribute3' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute3])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute4') `
-Destination 'extensionAttribute4' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute4])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute5') `
-Destination 'extensionAttribute5' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute5])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute6') `
-Destination 'extensionAttribute6' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute6])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute7') `
-Destination 'extensionAttribute7' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute7])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute8') `
-Destination 'extensionAttribute8' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute8])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute9') `
-Destination 'extensionAttribute9' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute9])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute10') `
-Destination 'extensionAttribute10' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute10])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute11') `
-Destination 'extensionAttribute11' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute11])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute12') `
-Destination 'extensionAttribute12' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute12])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute13') `
-Destination 'extensionAttribute13' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute13])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute14') `
-Destination 'extensionAttribute14' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute14])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute15') `
-Destination 'extensionAttribute15' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute15])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('legacyExchangeDN') `
-Destination 'legacyExchangeDN' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('mailNickname') `
-Destination 'mailNickname' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msDS-HABSeniorityIndex') `
-Destination 'msDS-HABSeniorityIndex' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msDS-PhoneticDisplayName') `
-Destination 'msDS-PhoneticDisplayName' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchArchiveGUID') `
-Destination 'msExchArchiveGUID' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchArchiveName') `
-Destination 'msExchArchiveName' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchAssistantName') `
-Destination 'msExchAssistantName' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchAuditAdmin') `
-Destination 'msExchAuditAdmin' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchAuditDelegate') `
-Destination 'msExchAuditDelegate' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchAuditDelegateAdmin') `
-Destination 'msExchAuditDelegateAdmin' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchAuditOwner') `
-Destination 'msExchAuditOwner' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchBlockedSendersHash') `
-Destination 'msExchBlockedSendersHash' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchBypassAudit') `
-Destination 'msExchBypassAudit' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchBypassModerationFromDLMembersBL') `
-Destination 'msExchBypassModerationFromDLMembersLink' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchBypassModerationLink') `
-Destination 'msExchBypassModerationLink' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchDelegateListLink') `
-Destination 'msExchDelegateListLink' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchELCExpirySuspensionEnd') `
-Destination 'msExchELCExpirySuspensionEnd' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchELCExpirySuspensionStart') `
-Destination 'msExchELCExpirySuspensionStart' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchELCMailboxFlags') `
-Destination 'msExchELCMailboxFlags' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchEnableModeration') `
-Destination 'msExchEnableModeration' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchExtensionCustomAttribute1') `
-Destination 'msExchExtensionCustomAttribute1' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchExtensionCustomAttribute2') `
-Destination 'msExchExtensionCustomAttribute2' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchExtensionCustomAttribute3') `
-Destination 'msExchExtensionCustomAttribute3' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchExtensionCustomAttribute4') `
-Destination 'msExchExtensionCustomAttribute4' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchExtensionCustomAttribute5') `
-Destination 'msExchExtensionCustomAttribute5' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchHideFromAddressLists') `
-Destination 'msExchHideFromAddressLists' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchImmutableId') `
-Destination 'msExchImmutableId' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchLitigationHoldDate') `
-Destination 'msExchLitigationHoldDate' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchLitigationHoldOwner') `
-Destination 'msExchLitigationHoldOwner' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchMailboxAuditEnable') `
-Destination 'msExchMailboxAuditEnable' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchMailboxAuditLogAgeLimit') `
-Destination 'msExchMailboxAuditLogAgeLimit' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchMailboxGuid') `
-Destination 'msExchMailboxGuid' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchMasterAccountSid') `
-Destination 'msExchMasterAccountSid' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchModeratedByLink') `
-Destination 'msExchModeratedByLink' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchModerationFlags') `
-Destination 'msExchModerationFlags' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchRecipientDisplayType') `
-Destination 'msExchRecipientDisplayType' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchRecipientTypeDetails') `
-Destination 'msExchRecipientTypeDetails' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchRemoteRecipientType') `
-Destination 'msExchRemoteRecipientType' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchRequireAuthToSendTo') `
-Destination 'msExchRequireAuthToSendTo' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchResourceCapacity') `
-Destination 'msExchResourceCapacity' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchResourceDisplay') `
-Destination 'msExchResourceDisplay' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchResourceMetaData') `
-Destination 'msExchResourceMetaData' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchResourceSearchProperties') `
-Destination 'msExchResourceSearchProperties' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchRetentionComment') `
-Destination 'msExchRetentionComment' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchRetentionURL') `
-Destination 'msExchRetentionURL' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchSafeRecipientsHash') `
-Destination 'msExchSafeRecipientsHash' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchSafeSendersHash') `
-Destination 'msExchSafeSendersHash' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchSenderHintTranslations') `
-Destination 'msExchSenderHintTranslations' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchTeamMailboxExpiration') `
-Destination 'msExchTeamMailboxExpiration' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchTeamMailboxOwners') `
-Destination 'msExchTeamMailboxOwners' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchTeamMailboxSharePointLinkedBy') `
-Destination 'msExchTeamMailboxSharePointLinkedBy' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchTeamMailboxSharePointUrl') `
-Destination 'msExchTeamMailboxSharePointUrl' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchUserHoldPolicies') `
-Destination 'msExchUserHoldPolicies' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('publicDelegates') `
-Destination 'publicDelegates' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('targetAddress') `
-Destination 'targetAddress' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('telephoneAssistant') `
-Destination 'telephoneAssistant' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([telephoneAssistant])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchUsageLocation') `
-Destination 'usageLocation' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('userCertificate') `
-Destination 'userCertificate' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('userSMIMECertificate') `
-Destination 'userSMIMECertificate' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('unauthOrig') `
-Destination 'unauthOrig' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


New-Object  `
-TypeName 'Microsoft.IdentityManagement.PowerShell.ObjectModel.ScopeCondition' `
-ArgumentList 'mailNickname','','ISNOTNULL' `
-OutVariable condition0


Add-ADSyncScopeConditionGroup  `
-SynchronizationRule $syncRule[0] `
-ScopeConditions @($condition0[0]) `
-OutVariable syncRule


Add-ADSyncRule  `
-SynchronizationRule $syncRule[0]


Get-ADSyncRule  `
-Identifier 'cd66859f-df8b-4d9d-aa38-7b50f674d8c4'


New-ADSyncRule  `
-Name 'In from AD - InetOrgPerson Exchange' `
-Identifier '259c3317-96a8-4645-af73-dee64b0228c0' `
-Description 'InetOrgPerson object with Exchange schema in Active Directory.' `
-Direction 'Inbound' `
-Precedence 109 `
-PrecedenceAfter '00000000-0000-0000-0000-000000000000' `
-PrecedenceBefore '00000000-0000-0000-0000-000000000000' `
-SourceObjectType 'inetOrgPerson' `
-TargetObjectType 'person' `
-Connector '093c3526-55a5-4de9-9005-186fd0a6a849' `
-LinkType 'Join' `
-SoftDeleteExpiryInterval 0 `
-ImmutableTag 'Microsoft.InfromADInetOrgPersonExchange.003' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('authOrig') `
-Destination 'authOrig' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Destination 'contributingConnectorExchange' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression '%Connector.ID%' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('dLMemRejectPerms') `
-Destination 'dLMemRejectPerms' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('dLMemSubmitPerms') `
-Destination 'dLMemSubmitPerms' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute1') `
-Destination 'extensionAttribute1' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute1])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute2') `
-Destination 'extensionAttribute2' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute2])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute3') `
-Destination 'extensionAttribute3' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute3])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute4') `
-Destination 'extensionAttribute4' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute4])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute5') `
-Destination 'extensionAttribute5' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute5])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute6') `
-Destination 'extensionAttribute6' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute6])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute7') `
-Destination 'extensionAttribute7' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute7])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute8') `
-Destination 'extensionAttribute8' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute8])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute9') `
-Destination 'extensionAttribute9' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute9])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute10') `
-Destination 'extensionAttribute10' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute10])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute11') `
-Destination 'extensionAttribute11' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute11])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute12') `
-Destination 'extensionAttribute12' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute12])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute13') `
-Destination 'extensionAttribute13' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute13])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute14') `
-Destination 'extensionAttribute14' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute14])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute15') `
-Destination 'extensionAttribute15' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute15])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('legacyExchangeDN') `
-Destination 'legacyExchangeDN' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('mailNickname') `
-Destination 'mailNickname' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msDS-HABSeniorityIndex') `
-Destination 'msDS-HABSeniorityIndex' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msDS-PhoneticDisplayName') `
-Destination 'msDS-PhoneticDisplayName' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchArchiveGUID') `
-Destination 'msExchArchiveGUID' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchArchiveName') `
-Destination 'msExchArchiveName' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchAssistantName') `
-Destination 'msExchAssistantName' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchAuditAdmin') `
-Destination 'msExchAuditAdmin' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchAuditDelegate') `
-Destination 'msExchAuditDelegate' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchAuditDelegateAdmin') `
-Destination 'msExchAuditDelegateAdmin' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchAuditOwner') `
-Destination 'msExchAuditOwner' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchBlockedSendersHash') `
-Destination 'msExchBlockedSendersHash' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchBypassAudit') `
-Destination 'msExchBypassAudit' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchBypassModerationFromDLMembersBL') `
-Destination 'msExchBypassModerationFromDLMembersLink' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchBypassModerationLink') `
-Destination 'msExchBypassModerationLink' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchDelegateListLink') `
-Destination 'msExchDelegateListLink' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchELCExpirySuspensionEnd') `
-Destination 'msExchELCExpirySuspensionEnd' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchELCExpirySuspensionStart') `
-Destination 'msExchELCExpirySuspensionStart' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchELCMailboxFlags') `
-Destination 'msExchELCMailboxFlags' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchEnableModeration') `
-Destination 'msExchEnableModeration' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchExtensionCustomAttribute1') `
-Destination 'msExchExtensionCustomAttribute1' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchExtensionCustomAttribute2') `
-Destination 'msExchExtensionCustomAttribute2' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchExtensionCustomAttribute3') `
-Destination 'msExchExtensionCustomAttribute3' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchExtensionCustomAttribute4') `
-Destination 'msExchExtensionCustomAttribute4' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchExtensionCustomAttribute5') `
-Destination 'msExchExtensionCustomAttribute5' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchHideFromAddressLists') `
-Destination 'msExchHideFromAddressLists' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchImmutableId') `
-Destination 'msExchImmutableId' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchLitigationHoldDate') `
-Destination 'msExchLitigationHoldDate' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchLitigationHoldOwner') `
-Destination 'msExchLitigationHoldOwner' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchMailboxAuditEnable') `
-Destination 'msExchMailboxAuditEnable' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchMailboxAuditLogAgeLimit') `
-Destination 'msExchMailboxAuditLogAgeLimit' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchMailboxGuid') `
-Destination 'msExchMailboxGuid' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchMasterAccountSid') `
-Destination 'msExchMasterAccountSid' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchModeratedByLink') `
-Destination 'msExchModeratedByLink' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchModerationFlags') `
-Destination 'msExchModerationFlags' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchRecipientDisplayType') `
-Destination 'msExchRecipientDisplayType' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchRecipientTypeDetails') `
-Destination 'msExchRecipientTypeDetails' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchRemoteRecipientType') `
-Destination 'msExchRemoteRecipientType' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchRequireAuthToSendTo') `
-Destination 'msExchRequireAuthToSendTo' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchResourceCapacity') `
-Destination 'msExchResourceCapacity' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchResourceDisplay') `
-Destination 'msExchResourceDisplay' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchResourceMetaData') `
-Destination 'msExchResourceMetaData' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchResourceSearchProperties') `
-Destination 'msExchResourceSearchProperties' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchRetentionComment') `
-Destination 'msExchRetentionComment' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchRetentionURL') `
-Destination 'msExchRetentionURL' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchSafeRecipientsHash') `
-Destination 'msExchSafeRecipientsHash' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchSafeSendersHash') `
-Destination 'msExchSafeSendersHash' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchSenderHintTranslations') `
-Destination 'msExchSenderHintTranslations' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchTeamMailboxExpiration') `
-Destination 'msExchTeamMailboxExpiration' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchTeamMailboxOwners') `
-Destination 'msExchTeamMailboxOwners' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchTeamMailboxSharePointLinkedBy') `
-Destination 'msExchTeamMailboxSharePointLinkedBy' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchTeamMailboxSharePointUrl') `
-Destination 'msExchTeamMailboxSharePointUrl' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchUserHoldPolicies') `
-Destination 'msExchUserHoldPolicies' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('publicDelegates') `
-Destination 'publicDelegates' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('targetAddress') `
-Destination 'targetAddress' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('telephoneAssistant') `
-Destination 'telephoneAssistant' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([telephoneAssistant])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchUsageLocation') `
-Destination 'usageLocation' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('userCertificate') `
-Destination 'userCertificate' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('userSMIMECertificate') `
-Destination 'userSMIMECertificate' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('unauthOrig') `
-Destination 'unauthOrig' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


New-Object  `
-TypeName 'Microsoft.IdentityManagement.PowerShell.ObjectModel.ScopeCondition' `
-ArgumentList 'mailNickname','','ISNOTNULL' `
-OutVariable condition0


Add-ADSyncScopeConditionGroup  `
-SynchronizationRule $syncRule[0] `
-ScopeConditions @($condition0[0]) `
-OutVariable syncRule


Add-ADSyncRule  `
-SynchronizationRule $syncRule[0]


Get-ADSyncRule  `
-Identifier '259c3317-96a8-4645-af73-dee64b0228c0'


New-ADSyncRule  `
-Name 'In from AD - User Lync' `
-Identifier '9678300a-b384-42af-beba-8a03fa4d6789' `
-Description 'Lync attribute for a User object.' `
-Direction 'Inbound' `
-Precedence 110 `
-PrecedenceAfter '00000000-0000-0000-0000-000000000000' `
-PrecedenceBefore '00000000-0000-0000-0000-000000000000' `
-SourceObjectType 'user' `
-TargetObjectType 'person' `
-Connector '093c3526-55a5-4de9-9005-186fd0a6a849' `
-LinkType 'Join' `
-SoftDeleteExpiryInterval 0 `
-ImmutableTag 'Microsoft.InfromADUserLync.004' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msRTCSIP-OriginatorSid') `
-Destination 'msRTCSIP-OriginatorSid' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msRTCSIP-PrimaryUserAddress') `
-Destination 'msRTCSIP-PrimaryUserAddress' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msRTCSIP-UserEnabled') `
-Destination 'msRTCSIP-UserEnabled' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncRule  `
-SynchronizationRule $syncRule[0]


Get-ADSyncRule  `
-Identifier '9678300a-b384-42af-beba-8a03fa4d6789'


New-ADSyncRule  `
-Name 'In from AD - InetOrgPerson Lync' `
-Identifier '6cd5f2e2-e9f8-4997-a7a8-fe801c31ab59' `
-Description 'Lync attribute for a InetOrgPerson object.' `
-Direction 'Inbound' `
-Precedence 111 `
-PrecedenceAfter '00000000-0000-0000-0000-000000000000' `
-PrecedenceBefore '00000000-0000-0000-0000-000000000000' `
-SourceObjectType 'inetOrgPerson' `
-TargetObjectType 'person' `
-Connector '093c3526-55a5-4de9-9005-186fd0a6a849' `
-LinkType 'Join' `
-SoftDeleteExpiryInterval 0 `
-ImmutableTag 'Microsoft.InfromADInetOrgPersonLync.003' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msRTCSIP-PrimaryUserAddress') `
-Destination 'msRTCSIP-PrimaryUserAddress' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msRTCSIP-UserEnabled') `
-Destination 'msRTCSIP-UserEnabled' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncRule  `
-SynchronizationRule $syncRule[0]


Get-ADSyncRule  `
-Identifier '6cd5f2e2-e9f8-4997-a7a8-fe801c31ab59'


New-ADSyncRule  `
-Name 'In from AD - Group Join' `
-Identifier '95bf6ca3-ecd6-464e-81af-f9458943d40e' `
-Description '' `
-Direction 'Inbound' `
-Precedence 112 `
-PrecedenceAfter '00000000-0000-0000-0000-000000000000' `
-PrecedenceBefore '00000000-0000-0000-0000-000000000000' `
-SourceObjectType 'group' `
-TargetObjectType 'group' `
-Connector '093c3526-55a5-4de9-9005-186fd0a6a849' `
-LinkType 'Provision' `
-SoftDeleteExpiryInterval 0 `
-ImmutableTag 'Microsoft.InfromADGroupJoin.004' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('isCriticalSystemObject') `
-Destination 'cloudFiltered' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'IIF(IsPresent([isCriticalSystemObject]) || [sAMAccountName] = "MSOL_AD_Sync_RichCoexistence" || CBool(IIF(IsPresent([msExchRecipientTypeDetails]),BitAnd([msExchRecipientTypeDetails],&H40000000) > 0,NULL))  || CBool(InStr(DNComponent(CRef([dn]),1),"\\0ACNF:")>0), True, NULL)' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('proxyAddresses','mail') `
-Destination 'mailEnabled' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'IIF(( (IsPresent([proxyAddresses]) = True) && (Contains([proxyAddresses], "SMTP:") > 0) && (InStr(Item([proxyAddresses], Contains([proxyAddresses], "SMTP:")), "@") > 0)) ||  (IsPresent([mail]) = True && (InStr([mail], "@") > 0)), True, False)' `
-OutVariable syncRule


New-Object  `
-TypeName 'Microsoft.IdentityManagement.PowerShell.ObjectModel.ScopeCondition' `
-ArgumentList 'isCriticalSystemObject','True','NOTEQUAL' `
-OutVariable condition0


New-Object  `
-TypeName 'Microsoft.IdentityManagement.PowerShell.ObjectModel.ScopeCondition' `
-ArgumentList 'adminDescription','Group_','NOTSTARTSWITH' `
-OutVariable condition1


Add-ADSyncScopeConditionGroup  `
-SynchronizationRule $syncRule[0] `
-ScopeConditions @($condition0[0],$condition1[0]) `
-OutVariable syncRule


New-Object  `
-TypeName 'Microsoft.IdentityManagement.PowerShell.ObjectModel.JoinCondition' `
-ArgumentList 'objectGUID','sourceAnchorBinary',$false `
-OutVariable condition0


Add-ADSyncJoinConditionGroup  `
-SynchronizationRule $syncRule[0] `
-JoinConditions @($condition0[0]) `
-OutVariable syncRule


Add-ADSyncRule  `
-SynchronizationRule $syncRule[0]


Get-ADSyncRule  `
-Identifier '95bf6ca3-ecd6-464e-81af-f9458943d40e'


New-ADSyncRule  `
-Name 'In from AD - Group Exchange' `
-Identifier '2a6f3fcc-7a56-4ed2-84d0-fd4193795768' `
-Description '' `
-Direction 'Inbound' `
-Precedence 113 `
-PrecedenceAfter '00000000-0000-0000-0000-000000000000' `
-PrecedenceBefore '00000000-0000-0000-0000-000000000000' `
-SourceObjectType 'group' `
-TargetObjectType 'group' `
-Connector '093c3526-55a5-4de9-9005-186fd0a6a849' `
-LinkType 'Join' `
-SoftDeleteExpiryInterval 0 `
-ImmutableTag 'Microsoft.InfromADGroupExchange.004' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('authOrig') `
-Destination 'authOrig' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('dLMemRejectPerms') `
-Destination 'dLMemRejectPerms' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('dLMemSubmitPerms') `
-Destination 'dLMemSubmitPerms' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute1') `
-Destination 'extensionAttribute1' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute1])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute2') `
-Destination 'extensionAttribute2' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute2])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute3') `
-Destination 'extensionAttribute3' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute3])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute4') `
-Destination 'extensionAttribute4' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute4])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute5') `
-Destination 'extensionAttribute5' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute5])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute6') `
-Destination 'extensionAttribute6' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute6])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute7') `
-Destination 'extensionAttribute7' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute7])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute8') `
-Destination 'extensionAttribute8' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute8])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute9') `
-Destination 'extensionAttribute9' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute9])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute10') `
-Destination 'extensionAttribute10' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute10])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute11') `
-Destination 'extensionAttribute11' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute11])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute12') `
-Destination 'extensionAttribute12' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute12])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute13') `
-Destination 'extensionAttribute13' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute13])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute14') `
-Destination 'extensionAttribute14' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute14])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute15') `
-Destination 'extensionAttribute15' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute15])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('hideDLMembership') `
-Destination 'hideDLMembership' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('legacyExchangeDN') `
-Destination 'legacyExchangeDN' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('mailNickname') `
-Destination 'mailNickname' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msDS-PhoneticDisplayName') `
-Destination 'msDS-PhoneticDisplayName' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchBypassModerationFromDLMembersLink') `
-Destination 'msExchBypassModerationFromDLMembersLink' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchBypassModerationLink') `
-Destination 'msExchBypassModerationLink' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchCoManagedByLink') `
-Destination 'msExchCoManagedByLink' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchEnableModeration') `
-Destination 'msExchEnableModeration' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchExtensionCustomAttribute1') `
-Destination 'msExchExtensionCustomAttribute1' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchExtensionCustomAttribute2') `
-Destination 'msExchExtensionCustomAttribute2' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchExtensionCustomAttribute3') `
-Destination 'msExchExtensionCustomAttribute3' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchExtensionCustomAttribute4') `
-Destination 'msExchExtensionCustomAttribute4' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchExtensionCustomAttribute5') `
-Destination 'msExchExtensionCustomAttribute5' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchGroupDepartRestriction') `
-Destination 'msExchGroupDepartRestriction' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchGroupJoinRestriction') `
-Destination 'msExchGroupJoinRestriction' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchHideFromAddressLists') `
-Destination 'msExchHideFromAddressLists' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchLitigationHoldDate') `
-Destination 'msExchLitigationHoldDate' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchLitigationHoldOwner') `
-Destination 'msExchLitigationHoldOwner' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchModeratedByLink') `
-Destination 'msExchModeratedByLink' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchModerationFlags') `
-Destination 'msExchModerationFlags' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchRecipientDisplayType') `
-Destination 'msExchRecipientDisplayType' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchRecipientTypeDetails') `
-Destination 'msExchRecipientTypeDetails' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchRequireAuthToSendTo') `
-Destination 'msExchRequireAuthToSendTo' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchRetentionComment') `
-Destination 'msExchRetentionComment' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchRetentionURL') `
-Destination 'msExchRetentionURL' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchSenderHintTranslations') `
-Destination 'msExchSenderHintTranslations' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msOrg-IsOrganizational') `
-Destination 'msOrg-IsOrganizational' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('oOFReplyToOriginator') `
-Destination 'oOFReplyToOriginator' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('publicDelegates') `
-Destination 'publicDelegates' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('reportToOriginator') `
-Destination 'reportToOriginator' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('reportToOwner') `
-Destination 'reportToOwner' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('unauthOrig') `
-Destination 'unauthOrig' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


New-Object  `
-TypeName 'Microsoft.IdentityManagement.PowerShell.ObjectModel.ScopeCondition' `
-ArgumentList 'isCriticalSystemObject','True','NOTEQUAL' `
-OutVariable condition0


New-Object  `
-TypeName 'Microsoft.IdentityManagement.PowerShell.ObjectModel.ScopeCondition' `
-ArgumentList 'adminDescription','Group_','NOTSTARTSWITH' `
-OutVariable condition1


Add-ADSyncScopeConditionGroup  `
-SynchronizationRule $syncRule[0] `
-ScopeConditions @($condition0[0],$condition1[0]) `
-OutVariable syncRule


Add-ADSyncRule  `
-SynchronizationRule $syncRule[0]


Get-ADSyncRule  `
-Identifier '2a6f3fcc-7a56-4ed2-84d0-fd4193795768'


New-ADSyncRule  `
-Name 'In from AD - Group Common' `
-Identifier '1a8a3f53-911a-4d3e-8be9-bc26a7317400' `
-Description '' `
-Direction 'Inbound' `
-Precedence 114 `
-PrecedenceAfter '00000000-0000-0000-0000-000000000000' `
-PrecedenceBefore '00000000-0000-0000-0000-000000000000' `
-SourceObjectType 'group' `
-TargetObjectType 'group' `
-Connector '093c3526-55a5-4de9-9005-186fd0a6a849' `
-LinkType 'Join' `
-SoftDeleteExpiryInterval 0 `
-ImmutableTag 'Microsoft.InfromADGroupCommon.004' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('cn') `
-Destination 'cn' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('description') `
-Destination 'description' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'IIF(IsNullOrEmpty([description]),NULL,Left(Trim(Item([description],1)),448))' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('displayName','cn') `
-Destination 'displayName' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'IIF(IsNullOrEmpty([displayName]),[cn],[displayName])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('info') `
-Destination 'info' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Left(Trim([info]),448)' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('mail') `
-Destination 'mail' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([mail])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('managedBy') `
-Destination 'managedBy' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('member') `
-Destination 'member' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('member') `
-Destination 'memberCount' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'ValueCount("member")' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msDS-HABSeniorityIndex') `
-Destination 'msDS-HABSeniorityIndex' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('objectSid') `
-Destination 'objectSid' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('objectSid') `
-Destination 'objectSidString' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'StringFromSid([objectSid])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('proxyAddresses') `
-Destination 'proxyAddresses' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'RemoveDuplicates(Trim(ImportedValue("proxyAddresses")))' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('groupType') `
-Destination 'securityEnabled' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'CBool(BitAnd([groupType],-2147483648))' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('objectGUID') `
-Destination 'sourceAnchor' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'ConvertToBase64([objectGUID])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('objectGUID') `
-Destination 'sourceAnchorBinary' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


New-Object  `
-TypeName 'Microsoft.IdentityManagement.PowerShell.ObjectModel.ScopeCondition' `
-ArgumentList 'isCriticalSystemObject','True','NOTEQUAL' `
-OutVariable condition0


New-Object  `
-TypeName 'Microsoft.IdentityManagement.PowerShell.ObjectModel.ScopeCondition' `
-ArgumentList 'adminDescription','Group_','NOTSTARTSWITH' `
-OutVariable condition1


Add-ADSyncScopeConditionGroup  `
-SynchronizationRule $syncRule[0] `
-ScopeConditions @($condition0[0],$condition1[0]) `
-OutVariable syncRule


Add-ADSyncRule  `
-SynchronizationRule $syncRule[0]


Get-ADSyncRule  `
-Identifier '1a8a3f53-911a-4d3e-8be9-bc26a7317400'


New-ADSyncRule  `
-Name 'In from AD - Contact Join' `
-Identifier 'e45d57c5-c986-4264-9891-65c9079ea154' `
-Description 'Contact object with default Active Directory schema.' `
-Direction 'Inbound' `
-Precedence 115 `
-PrecedenceAfter '00000000-0000-0000-0000-000000000000' `
-PrecedenceBefore '00000000-0000-0000-0000-000000000000' `
-SourceObjectType 'contact' `
-TargetObjectType 'person' `
-Connector '093c3526-55a5-4de9-9005-186fd0a6a849' `
-LinkType 'Provision' `
-SoftDeleteExpiryInterval 0 `
-ImmutableTag 'Microsoft.InfromADContactJoin.004' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('isCriticalSystemObject') `
-Destination 'cloudFiltered' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'IIF(IsPresent([isCriticalSystemObject]) || ( (InStr([displayName], "(MSOL)") > 0) && (CBool([msExchHideFromAddressLists]))) || (Left([mailNickname], 4) = "CAS_" && (InStr([mailNickname], "}") > 0)) || CBool(InStr(DNComponent(CRef([dn]),1),"\\0ACNF:")>0), True, NULL)' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('proxyAddresses','mail') `
-Destination 'mailEnabled' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'IIF(( (IsPresent([proxyAddresses]) = True) && (Contains([proxyAddresses], "SMTP:") > 0) && (InStr(Item([proxyAddresses], Contains([proxyAddresses], "SMTP:")), "@") > 0)) ||  (IsPresent([mail]) = True && (InStr([mail], "@") > 0)), True, False)' `
-OutVariable syncRule


New-Object  `
-TypeName 'Microsoft.IdentityManagement.PowerShell.ObjectModel.JoinCondition' `
-ArgumentList 'mail','mail',$false `
-OutVariable condition0


Add-ADSyncJoinConditionGroup  `
-SynchronizationRule $syncRule[0] `
-JoinConditions @($condition0[0]) `
-OutVariable syncRule


Add-ADSyncRule  `
-SynchronizationRule $syncRule[0]


Get-ADSyncRule  `
-Identifier 'e45d57c5-c986-4264-9891-65c9079ea154'


New-ADSyncRule  `
-Name 'In from AD - Contact Common' `
-Identifier '7f836c48-2ca7-4542-ab70-7a34d4c7b744' `
-Description 'Contact object with Exchange schema in Active Directory.' `
-Direction 'Inbound' `
-Precedence 116 `
-PrecedenceAfter '00000000-0000-0000-0000-000000000000' `
-PrecedenceBefore '00000000-0000-0000-0000-000000000000' `
-SourceObjectType 'contact' `
-TargetObjectType 'person' `
-Connector '093c3526-55a5-4de9-9005-186fd0a6a849' `
-LinkType 'Join' `
-SoftDeleteExpiryInterval 0 `
-ImmutableTag 'Microsoft.InfromADContactCommon.005' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('assistant') `
-Destination 'assistant' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('authOrig') `
-Destination 'authOrig' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('c') `
-Destination 'c' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([c])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('cn') `
-Destination 'cn' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('co') `
-Destination 'co' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([co])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('company') `
-Destination 'company' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([company])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('countryCode') `
-Destination 'countryCode' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('department') `
-Destination 'department' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([department])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('description') `
-Destination 'description' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'IIF(IsNullOrEmpty([description]),NULL,Left(Trim(Item([description],1)),448))' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('displayName','cn') `
-Destination 'displayName' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'IIF(IsNullOrEmpty([displayName]),[cn],[displayName])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('dLMemSubmitPerms') `
-Destination 'dLMemSubmitPerms' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('dLMemRejectPerms') `
-Destination 'dLMemRejectPerms' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute1') `
-Destination 'extensionAttribute1' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute1])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute2') `
-Destination 'extensionAttribute2' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute2])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute3') `
-Destination 'extensionAttribute3' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute3])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute4') `
-Destination 'extensionAttribute4' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute4])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute5') `
-Destination 'extensionAttribute5' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute5])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute6') `
-Destination 'extensionAttribute6' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute6])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute7') `
-Destination 'extensionAttribute7' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute7])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute8') `
-Destination 'extensionAttribute8' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute8])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute9') `
-Destination 'extensionAttribute9' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute9])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute10') `
-Destination 'extensionAttribute10' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute10])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute11') `
-Destination 'extensionAttribute11' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute11])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute12') `
-Destination 'extensionAttribute12' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute12])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute13') `
-Destination 'extensionAttribute13' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute13])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute14') `
-Destination 'extensionAttribute14' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute14])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('extensionAttribute15') `
-Destination 'extensionAttribute15' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([extensionAttribute15])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('facsimileTelephoneNumber') `
-Destination 'facsimileTelephoneNumber' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([facsimileTelephoneNumber])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('givenName') `
-Destination 'givenName' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([givenName])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('homePhone') `
-Destination 'homePhone' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([homePhone])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('info') `
-Destination 'info' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Left(Trim([info]),448)' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('initials') `
-Destination 'initials' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([initials])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('ipPhone') `
-Destination 'ipPhone' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([ipPhone])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('l') `
-Destination 'l' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([l])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('legacyExchangeDN') `
-Destination 'legacyExchangeDN' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'IIF(IsPresent([legacyExchangeDN]), [legacyExchangeDN], NULL)' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('mail') `
-Destination 'mail' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([mail])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('mailNickname') `
-Destination 'mailNickname' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'IIF(IsPresent([mailNickname]), [mailNickname], [cn])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('manager') `
-Destination 'manager' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('middleName') `
-Destination 'middleName' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([middleName])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('mobile') `
-Destination 'mobile' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([mobile])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msDS-HABSeniorityIndex') `
-Destination 'msDS-HABSeniorityIndex' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msDS-PhoneticDisplayName') `
-Destination 'msDS-PhoneticDisplayName' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchAssistantName') `
-Destination 'msExchAssistantName' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchBlockedSendersHash') `
-Destination 'msExchBlockedSendersHash' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchBypassModerationFromDLMembersLink') `
-Destination 'msExchBypassModerationFromDLMembersLink' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchBypassModerationLink') `
-Destination 'msExchBypassModerationLink' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchExtensionCustomAttribute1') `
-Destination 'msExchExtensionCustomAttribute1' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchExtensionCustomAttribute2') `
-Destination 'msExchExtensionCustomAttribute2' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchExtensionCustomAttribute3') `
-Destination 'msExchExtensionCustomAttribute3' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchExtensionCustomAttribute4') `
-Destination 'msExchExtensionCustomAttribute4' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchExtensionCustomAttribute5') `
-Destination 'msExchExtensionCustomAttribute5' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchHideFromAddressLists') `
-Destination 'msExchHideFromAddressLists' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchLitigationHoldDate') `
-Destination 'msExchLitigationHoldDate' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchLitigationHoldOwner') `
-Destination 'msExchLitigationHoldOwner' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchModeratedByLink') `
-Destination 'msExchModeratedByLink' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchModerationFlags') `
-Destination 'msExchModerationFlags' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchRecipientDisplayType') `
-Destination 'msExchRecipientDisplayType' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchRecipientTypeDetails') `
-Destination 'msExchRecipientTypeDetails' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchRequireAuthToSendTo') `
-Destination 'msExchRequireAuthToSendTo' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchRetentionComment') `
-Destination 'msExchRetentionComment' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchRetentionURL') `
-Destination 'msExchRetentionURL' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchSafeRecipientsHash') `
-Destination 'msExchSafeRecipientsHash' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchSafeSendersHash') `
-Destination 'msExchSafeSendersHash' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msExchSenderHintTranslations') `
-Destination 'msExchSenderHintTranslations' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('otherFacsimileTelephoneNumber') `
-Destination 'otherFacsimileTelephoneNumber' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([otherFacsimileTelephoneNumber])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('otherHomePhone') `
-Destination 'otherHomePhone' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([otherHomePhone])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('otherIpPhone') `
-Destination 'otherIpPhone' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([otherIpPhone])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('otherMobile') `
-Destination 'otherMobile' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([otherMobile])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('otherPager') `
-Destination 'otherPager' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([otherPager])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('otherTelephone') `
-Destination 'otherTelephone' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([otherTelephone])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('pager') `
-Destination 'pager' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([pager])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('physicalDeliveryOfficeName') `
-Destination 'physicalDeliveryOfficeName' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([physicalDeliveryOfficeName])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('postalCode') `
-Destination 'postalCode' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([postalCode])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('postOfficeBox') `
-Destination 'postOfficeBox' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'IIF(IsNullOrEmpty([postOfficeBox]),NULL,Left(Trim(Item([postOfficeBox],1)),448))' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('proxyAddresses') `
-Destination 'proxyAddresses' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'RemoveDuplicates(Trim(ImportedValue("proxyAddresses")))' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('publicDelegates') `
-Destination 'publicDelegates' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('sn') `
-Destination 'sn' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([sn])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('objectGUID') `
-Destination 'sourceAnchor' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'ConvertToBase64([objectGUID])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('objectGUID') `
-Destination 'sourceAnchorBinary' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('Contact') `
-Destination 'sourceObjectType' `
-FlowType 'Constant' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('st') `
-Destination 'st' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([st])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('streetAddress') `
-Destination 'streetAddress' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([streetAddress])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('targetAddress') `
-Destination 'targetAddress' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('telephoneAssistant') `
-Destination 'telephoneAssistant' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([telephoneAssistant])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('telephoneNumber') `
-Destination 'telephoneNumber' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([telephoneNumber])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('thumbnailPhoto') `
-Destination 'thumbnailPhoto' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('title') `
-Destination 'title' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([title])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('unauthOrig') `
-Destination 'unauthOrig' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('url') `
-Destination 'url' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'IIF(IsNullOrEmpty([url]),NULL,Left(Trim(Item([url],1)),448))' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('userCertificate') `
-Destination 'userCertificate' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('userSMIMECertificate') `
-Destination 'userSMIMECertificate' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('wWWHomePage') `
-Destination 'wWWHomePage' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'Trim([wWWHomePage])' `
-OutVariable syncRule


Add-ADSyncRule  `
-SynchronizationRule $syncRule[0]


Get-ADSyncRule  `
-Identifier '7f836c48-2ca7-4542-ab70-7a34d4c7b744'


New-ADSyncRule  `
-Name 'In from AD - Contact Lync' `
-Identifier '4cb72c33-26ac-4912-9924-a813e606febb' `
-Description 'Lync attributes for a Contact object.' `
-Direction 'Inbound' `
-Precedence 117 `
-PrecedenceAfter '00000000-0000-0000-0000-000000000000' `
-PrecedenceBefore '00000000-0000-0000-0000-000000000000' `
-SourceObjectType 'contact' `
-TargetObjectType 'person' `
-Connector '093c3526-55a5-4de9-9005-186fd0a6a849' `
-LinkType 'Join' `
-SoftDeleteExpiryInterval 0 `
-ImmutableTag 'Microsoft.InfromADContactLync.003' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msRTCSIP-PrimaryUserAddress') `
-Destination 'msRTCSIP-PrimaryUserAddress' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('msRTCSIP-UserEnabled') `
-Destination 'msRTCSIP-UserEnabled' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncRule  `
-SynchronizationRule $syncRule[0]


Get-ADSyncRule  `
-Identifier '4cb72c33-26ac-4912-9924-a813e606febb'


New-ADSyncRule  `
-Name 'In from AD - ForeignSecurityPrincipal Join User' `
-Identifier '4cf350ce-cbc9-4075-a23d-5440d00cd9ca' `
-Description '' `
-Direction 'Inbound' `
-Precedence 118 `
-PrecedenceAfter '00000000-0000-0000-0000-000000000000' `
-PrecedenceBefore '00000000-0000-0000-0000-000000000000' `
-SourceObjectType 'foreignSecurityPrincipal' `
-TargetObjectType '*' `
-Connector '093c3526-55a5-4de9-9005-186fd0a6a849' `
-LinkType 'Join' `
-SoftDeleteExpiryInterval 0 `
-ImmutableTag 'Microsoft.InfromADForeignSecurityPrincipalJoinUser.001' `
-OutVariable syncRule


New-Object  `
-TypeName 'Microsoft.IdentityManagement.PowerShell.ObjectModel.JoinCondition' `
-ArgumentList 'cn','objectSidString',$false `
-OutVariable condition0


Add-ADSyncJoinConditionGroup  `
-SynchronizationRule $syncRule[0] `
-JoinConditions @($condition0[0]) `
-OutVariable syncRule


Add-ADSyncRule  `
-SynchronizationRule $syncRule[0]


Get-ADSyncRule  `
-Identifier '4cf350ce-cbc9-4075-a23d-5440d00cd9ca'


New-ADSyncRule  `
-Name 'In from AAD - User Join' `
-Identifier 'dfbdc173-b441-4f5c-b076-41e42913bc12' `
-Description '' `
-Direction 'Inbound' `
-Precedence 119 `
-PrecedenceAfter '00000000-0000-0000-0000-000000000000' `
-PrecedenceBefore '00000000-0000-0000-0000-000000000000' `
-SourceObjectType 'user' `
-TargetObjectType 'person' `
-Connector 'b891884f-051e-4a83-95af-2544101c9083' `
-LinkType 'Join' `
-SoftDeleteExpiryInterval 0 `
-ImmutableTag 'Microsoft.InfromAADUserJoin.005' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('accountEnabled') `
-Destination 'accountEnabled' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('cloudAnchor') `
-Destination 'cloudAnchor' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('sourceAnchor') `
-Destination 'cloudSourceAnchor' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'ImportedValue("sourceAnchor")' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('countryCode') `
-Destination 'countryCode' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('usageLocation') `
-Destination 'usageLocation' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('userCertificate') `
-Destination 'cloudUserCertificate' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'ImportedValue("userCertificate")' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('userSMIMECertificate') `
-Destination 'cloudUserSMIMECertificate' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'ImportedValue("userSMIMECertificate")' `
-OutVariable syncRule


New-Object  `
-TypeName 'Microsoft.IdentityManagement.PowerShell.ObjectModel.ScopeCondition' `
-ArgumentList 'cloudMastered','False','EQUAL' `
-OutVariable condition0


Add-ADSyncScopeConditionGroup  `
-SynchronizationRule $syncRule[0] `
-ScopeConditions @($condition0[0]) `
-OutVariable syncRule


New-Object  `
-TypeName 'Microsoft.IdentityManagement.PowerShell.ObjectModel.JoinCondition' `
-ArgumentList 'sourceAnchor','sourceAnchor',$true `
-OutVariable condition0


Add-ADSyncJoinConditionGroup  `
-SynchronizationRule $syncRule[0] `
-JoinConditions @($condition0[0]) `
-OutVariable syncRule


Add-ADSyncRule  `
-SynchronizationRule $syncRule[0]


Get-ADSyncRule  `
-Identifier 'dfbdc173-b441-4f5c-b076-41e42913bc12'


New-ADSyncRule  `
-Name 'In from AAD - Contact Join' `
-Identifier '0058cf9d-a487-4950-942a-7b95e7d86bb5' `
-Description '' `
-Direction 'Inbound' `
-Precedence 120 `
-PrecedenceAfter '00000000-0000-0000-0000-000000000000' `
-PrecedenceBefore '00000000-0000-0000-0000-000000000000' `
-SourceObjectType 'contact' `
-TargetObjectType 'person' `
-Connector 'b891884f-051e-4a83-95af-2544101c9083' `
-LinkType 'Join' `
-SoftDeleteExpiryInterval 0 `
-ImmutableTag 'Microsoft.InfromAADContactJoin.004' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('cloudAnchor') `
-Destination 'cloudAnchor' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('sourceAnchor') `
-Destination 'cloudSourceAnchor' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'ImportedValue("sourceAnchor")' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('userCertificate') `
-Destination 'cloudUserCertificate' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'ImportedValue("userCertificate")' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('userSMIMECertificate') `
-Destination 'cloudUserSMIMECertificate' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'ImportedValue("userSMIMECertificate")' `
-OutVariable syncRule


New-Object  `
-TypeName 'Microsoft.IdentityManagement.PowerShell.ObjectModel.JoinCondition' `
-ArgumentList 'sourceAnchor','sourceAnchor',$true `
-OutVariable condition0


Add-ADSyncJoinConditionGroup  `
-SynchronizationRule $syncRule[0] `
-JoinConditions @($condition0[0]) `
-OutVariable syncRule


Add-ADSyncRule  `
-SynchronizationRule $syncRule[0]


Get-ADSyncRule  `
-Identifier '0058cf9d-a487-4950-942a-7b95e7d86bb5'


New-ADSyncRule  `
-Name 'In from AAD - Group Join' `
-Identifier '7d87d7ea-76dd-46b4-8d23-80c5602bc1b2' `
-Description '' `
-Direction 'Inbound' `
-Precedence 121 `
-PrecedenceAfter '00000000-0000-0000-0000-000000000000' `
-PrecedenceBefore '00000000-0000-0000-0000-000000000000' `
-SourceObjectType 'group' `
-TargetObjectType 'group' `
-Connector 'b891884f-051e-4a83-95af-2544101c9083' `
-LinkType 'Join' `
-SoftDeleteExpiryInterval 0 `
-ImmutableTag 'Microsoft.InfromAADGroupJoin.004' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('cloudAnchor') `
-Destination 'cloudAnchor' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('sourceAnchor') `
-Destination 'cloudSourceAnchor' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'ImportedValue("sourceAnchor")' `
-OutVariable syncRule


New-Object  `
-TypeName 'Microsoft.IdentityManagement.PowerShell.ObjectModel.ScopeCondition' `
-ArgumentList 'cloudMastered','True','NOTEQUAL' `
-OutVariable condition0


Add-ADSyncScopeConditionGroup  `
-SynchronizationRule $syncRule[0] `
-ScopeConditions @($condition0[0]) `
-OutVariable syncRule


New-Object  `
-TypeName 'Microsoft.IdentityManagement.PowerShell.ObjectModel.JoinCondition' `
-ArgumentList 'sourceAnchor','sourceAnchor',$true `
-OutVariable condition0


Add-ADSyncJoinConditionGroup  `
-SynchronizationRule $syncRule[0] `
-JoinConditions @($condition0[0]) `
-OutVariable syncRule


Add-ADSyncRule  `
-SynchronizationRule $syncRule[0]


Get-ADSyncRule  `
-Identifier '7d87d7ea-76dd-46b4-8d23-80c5602bc1b2'


New-ADSyncRule  `
-Name 'In from AAD - User NGCKey' `
-Identifier 'a43671a4-4fe6-4ad8-9697-c248b31910f3' `
-Description '' `
-Direction 'Inbound' `
-Precedence 122 `
-PrecedenceAfter '00000000-0000-0000-0000-000000000000' `
-PrecedenceBefore '00000000-0000-0000-0000-000000000000' `
-SourceObjectType 'user' `
-TargetObjectType 'person' `
-Connector 'b891884f-051e-4a83-95af-2544101c9083' `
-LinkType 'Join' `
-SoftDeleteExpiryInterval 0 `
-ImmutableTag 'Microsoft.InfromAADUserNGCKey.001' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('searchableDeviceKey') `
-Destination 'deviceKey' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'IIF(IsNull([searchableDeviceKey]), NULL, IIF(CNum(Mid([searchableDeviceKey],1,1))=0, Mid([searchableDeviceKey],1,7+CNum(Mid([searchableDeviceKey],5,2))) & CBin(Len(Thumbprint(Mid([searchableDeviceKey],8+CNum(Mid([searchableDeviceKey],5,2)),Len([searchableDeviceKey])))),2) & CBin(2,1) & Thumbprint(Mid([searchableDeviceKey],8+CNum(Mid([searchableDeviceKey],5,2)),Len([searchableDeviceKey]))) & Mid([searchableDeviceKey],8+CNum(Mid([searchableDeviceKey],5,2)),Len([searchableDeviceKey])), NULL))' `
-OutVariable syncRule


Add-ADSyncRule  `
-SynchronizationRule $syncRule[0]


Get-ADSyncRule  `
-Identifier 'a43671a4-4fe6-4ad8-9697-c248b31910f3'


New-ADSyncRule  `
-Name 'In from AAD - Contact Exchange Hybrid' `
-Identifier '803efb9f-bdfc-4e77-b608-55ad5221f85a' `
-Description '' `
-Direction 'Inbound' `
-Precedence 148 `
-PrecedenceAfter '00000000-0000-0000-0000-000000000000' `
-PrecedenceBefore '00000000-0000-0000-0000-000000000000' `
-SourceObjectType 'contact' `
-TargetObjectType 'person' `
-Connector 'b891884f-051e-4a83-95af-2544101c9083' `
-LinkType 'Join' `
-SoftDeleteExpiryInterval 0 `
-ImmutableTag 'Microsoft.InfromAADContactExchangeHybrid.003' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('cloudLegacyExchangeDN') `
-Destination 'cloudLegacyExchangeDN' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('cloudPublicDelegates') `
-Destination 'cloudPublicDelegates' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncRule  `
-SynchronizationRule $syncRule[0]


Get-ADSyncRule  `
-Identifier '803efb9f-bdfc-4e77-b608-55ad5221f85a'


New-ADSyncRule  `
-Name 'In from AAD - Group Exchange Hybrid' `
-Identifier '72ba1f03-2b67-46d7-a689-144b8a714c50' `
-Description '' `
-Direction 'Inbound' `
-Precedence 149 `
-PrecedenceAfter '00000000-0000-0000-0000-000000000000' `
-PrecedenceBefore '00000000-0000-0000-0000-000000000000' `
-SourceObjectType 'group' `
-TargetObjectType 'group' `
-Connector 'b891884f-051e-4a83-95af-2544101c9083' `
-LinkType 'Join' `
-SoftDeleteExpiryInterval 0 `
-ImmutableTag 'Microsoft.InfromAADGroupExchangeHybrid.003' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('cloudLegacyExchangeDN') `
-Destination 'cloudLegacyExchangeDN' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('cloudPublicDelegates') `
-Destination 'cloudPublicDelegates' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncRule  `
-SynchronizationRule $syncRule[0]


Get-ADSyncRule  `
-Identifier '72ba1f03-2b67-46d7-a689-144b8a714c50'


New-ADSyncRule  `
-Name 'In from AAD - User Exchange Hybrid' `
-Identifier 'c81ed1b5-4753-4e95-b336-62e6322e7c34' `
-Description '' `
-Direction 'Inbound' `
-Precedence 150 `
-PrecedenceAfter '00000000-0000-0000-0000-000000000000' `
-PrecedenceBefore '00000000-0000-0000-0000-000000000000' `
-SourceObjectType 'user' `
-TargetObjectType 'person' `
-Connector 'b891884f-051e-4a83-95af-2544101c9083' `
-LinkType 'Join' `
-SoftDeleteExpiryInterval 0 `
-ImmutableTag 'Microsoft.InfromAADUserExchangeHybrid.004' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('cloudMSExchRecipientDisplayType') `
-Destination 'cloudSOAExchMailbox' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression '
      CBool(
        IIF(IsPresent([cloudMSExchRecipientDisplayType]),(
            IIF([cloudMSExchRecipientDisplayType]=0,True,(
                IIF([cloudMSExchRecipientDisplayType]=2,True,(
                    IIF([cloudMSExchRecipientDisplayType]=7,True,(
                        IIF([cloudMSExchRecipientDisplayType]=8,True,(
                            IIF([cloudMSExchRecipientDisplayType]=10,True,(
                                IIF([cloudMSExchRecipientDisplayType]=16,True,(
                                    IIF([cloudMSExchRecipientDisplayType]=17,True,(
                                        IIF([cloudMSExchRecipientDisplayType]=18,True,(
                                            IIF([cloudMSExchRecipientDisplayType]=1073741824,True,(
                                                IIF([cloudMSExchRecipientDisplayType]=1073741840,True,False)))))))))))))))))))),False))
      ' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('cloudLegacyExchangeDN') `
-Destination 'cloudLegacyExchangeDN' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('cloudMSExchArchiveStatus') `
-Destination 'cloudMSExchArchiveStatus' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('cloudMSExchBlockedSendersHash') `
-Destination 'cloudMSExchBlockedSendersHash' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('cloudMSExchDelegateListLink') `
-Destination 'cloudMSExchDelegateListLink' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('cloudMSExchRecipientDisplayType') `
-Destination 'cloudMSExchRecipientDisplayType' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('cloudMSExchSafeRecipientsHash') `
-Destination 'cloudMSExchSafeRecipientsHash' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('cloudMSExchSafeSendersHash') `
-Destination 'cloudMSExchSafeSendersHash' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('cloudMSExchTeamMailboxExpiration') `
-Destination 'cloudMSExchTeamMailboxExpiration' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('cloudMSExchTeamMailboxOwners') `
-Destination 'cloudMSExchTeamMailboxOwners' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('cloudMSExchTeamMailboxSharePointUrl') `
-Destination 'cloudMSExchTeamMailboxSharePointUrl' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('cloudMSExchUCVoiceMailSettings') `
-Destination 'cloudMSExchUCVoiceMailSettings' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('cloudMSExchUserHoldPolicies') `
-Destination 'cloudMSExchUserHoldPolicies' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('cloudPublicDelegates') `
-Destination 'cloudPublicDelegates' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncRule  `
-SynchronizationRule $syncRule[0]


Get-ADSyncRule  `
-Identifier 'c81ed1b5-4753-4e95-b336-62e6322e7c34'


New-ADSyncRule  `
-Name 'In from AAD - Device Common' `
-Identifier 'e4d8b23b-9908-46b1-84e9-f36d0b12c5ce' `
-Description '' `
-Direction 'Inbound' `
-Precedence 160 `
-PrecedenceAfter '00000000-0000-0000-0000-000000000000' `
-PrecedenceBefore '00000000-0000-0000-0000-000000000000' `
-SourceObjectType 'device' `
-TargetObjectType 'device' `
-Connector 'b891884f-051e-4a83-95af-2544101c9083' `
-LinkType 'Join' `
-SoftDeleteExpiryInterval 0 `
-ImmutableTag 'Microsoft.InfromAADDeviceCommon.002' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('cloudAnchor') `
-Destination 'cloudAnchor' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('alternativeSecurityId') `
-Destination 'alternativeSecurityId' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('stkDeviceKey') `
-Destination 'deviceKey' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'IIF(IsNull([stkDeviceKey]), NULL, IIF(CNum(Mid([stkDeviceKey],1,1))=0, Mid([stkDeviceKey],1,7+CNum(Mid([stkDeviceKey],5,2))) & CBin(Len(Thumbprint(Mid([stkDeviceKey],8+CNum(Mid([stkDeviceKey],5,2)),Len([stkDeviceKey])))),2) & CBin(2,1) & Thumbprint(Mid([stkDeviceKey],8+CNum(Mid([stkDeviceKey],5,2)),Len([stkDeviceKey]))) & Mid([stkDeviceKey],8+CNum(Mid([stkDeviceKey],5,2)),Len([stkDeviceKey])), NULL))' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('isCompliant') `
-Destination 'isCompliant' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('isManaged') `
-Destination 'isManaged' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('registeredOwnerReference') `
-Destination 'registeredOwnerReference' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('registeredUsersReference') `
-Destination 'registeredUsersReference' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('cloudCreated') `
-Destination 'cloudCreated' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('dirSyncOverrides') `
-Destination 'dirSyncOverrides' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('userCertificate') `
-Destination 'cloudUserCertificate' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'ImportedValue("userCertificate")' `
-OutVariable syncRule


New-Object  `
-TypeName 'Microsoft.IdentityManagement.PowerShell.ObjectModel.JoinCondition' `
-ArgumentList 'deviceId','deviceId',$false `
-OutVariable condition0


Add-ADSyncJoinConditionGroup  `
-SynchronizationRule $syncRule[0] `
-JoinConditions @($condition0[0]) `
-OutVariable syncRule


Add-ADSyncRule  `
-SynchronizationRule $syncRule[0]


Get-ADSyncRule  `
-Identifier 'e4d8b23b-9908-46b1-84e9-f36d0b12c5ce'


New-ADSyncRule  `
-Name 'In from AD - Computer Join' `
-Identifier '91d348b4-7c33-4700-af60-7157d85e76d2' `
-Description '' `
-Direction 'Inbound' `
-Precedence 161 `
-PrecedenceAfter '00000000-0000-0000-0000-000000000000' `
-PrecedenceBefore '00000000-0000-0000-0000-000000000000' `
-SourceObjectType 'computer' `
-TargetObjectType 'device' `
-Connector '093c3526-55a5-4de9-9005-186fd0a6a849' `
-LinkType 'Provision' `
-SoftDeleteExpiryInterval 0 `
-ImmutableTag 'Microsoft.InfromADComputerJoin.003' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('userAccountControl') `
-Destination 'accountEnabled' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'IIF(BitAnd([userAccountControl],2)=0,True,False)' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('objectGUID') `
-Destination 'deviceId' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('objectGUID') `
-Destination 'sourceAnchor' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'ConvertToBase64([objectGUID])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('displayName','cn') `
-Destination 'displayName' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'IIF(IsNullOrEmpty([displayName]),[cn],[displayName])' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('objectSid') `
-Destination 'objectSid' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('Computer') `
-Destination 'sourceObjectType' `
-FlowType 'Constant' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('operatingSystemVersion') `
-Destination 'deviceOSVersion' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('operatingSystem') `
-Destination 'deviceOSType' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('ServerAd') `
-Destination 'deviceTrustType' `
-FlowType 'Constant' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('False') `
-Destination 'cloudCreated' `
-FlowType 'Constant' `
-ValueMergeType 'Update' `
-ExecuteOnce  `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('userCertificate') `
-Destination 'userCertificate' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('mS-DS-CreatorSID') `
-Destination 'registeredOwnerReference' `
-FlowType 'Direct' `
-ValueMergeType 'Update' `
-ExecuteOnce  `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('userCertificate') `
-Destination 'cloudFiltered' `
-FlowType 'Expression' `
-ValueMergeType 'Update' `
-Expression 'IIF(IsNullOrEmpty([userCertificate]),True,NULL)' `
-OutVariable syncRule


New-Object  `
-TypeName 'Microsoft.IdentityManagement.PowerShell.ObjectModel.JoinCondition' `
-ArgumentList 'objectGUID','deviceId',$false `
-OutVariable condition0


Add-ADSyncJoinConditionGroup  `
-SynchronizationRule $syncRule[0] `
-JoinConditions @($condition0[0]) `
-OutVariable syncRule


Add-ADSyncRule  `
-SynchronizationRule $syncRule[0]


Get-ADSyncRule  `
-Identifier '91d348b4-7c33-4700-af60-7157d85e76d2'


New-ADSyncRule  `
-Name 'In from AD - Device Common' `
-Identifier 'bfd9e972-476f-4a06-a27b-dde9d61d6d1e' `
-Description '' `
-Direction 'Inbound' `
-Precedence 163 `
-PrecedenceAfter '00000000-0000-0000-0000-000000000000' `
-PrecedenceBefore '00000000-0000-0000-0000-000000000000' `
-SourceObjectType 'msDS-Device' `
-TargetObjectType 'device' `
-Connector '093c3526-55a5-4de9-9005-186fd0a6a849' `
-LinkType 'Join' `
-SoftDeleteExpiryInterval 0 `
-ImmutableTag 'Microsoft.InfromADDeviceCommon.001' `
-OutVariable syncRule


Add-ADSyncAttributeFlowMapping  `
-SynchronizationRule $syncRule[0] `
-Source @('True') `
-Destination 'isProvisionedInAD' `
-FlowType 'Constant' `
-ValueMergeType 'Update' `
-OutVariable syncRule


New-Object  `
-TypeName 'Microsoft.IdentityManagement.PowerShell.ObjectModel.ScopeCondition' `
-ArgumentList 'objectGUID','','ISNOTNULL' `
-OutVariable condition0


New-Object  `
-TypeName 'Microsoft.IdentityManagement.PowerShell.ObjectModel.ScopeCondition' `
-ArgumentList 'msDS-CloudAnchor','','ISNOTNULL' `
-OutVariable condition1


Add-ADSyncScopeConditionGroup  `
-SynchronizationRule $syncRule[0] `
-ScopeConditions @($condition0[0],$condition1[0]) `
-OutVariable syncRule


New-Object  `
-TypeName 'Microsoft.IdentityManagement.PowerShell.ObjectModel.JoinCondition' `
-ArgumentList 'msDS-DeviceID','deviceId',$false `
-OutVariable condition0


Add-ADSyncJoinConditionGroup  `
-SynchronizationRule $syncRule[0] `
-JoinConditions @($condition0[0]) `
-OutVariable syncRule


Add-ADSyncRule  `
-SynchronizationRule $syncRule[0]


Get-ADSyncRule  `
-Identifier 'bfd9e972-476f-4a06-a27b-dde9d61d6d1e'


