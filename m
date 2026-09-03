Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010013.outbound.protection.outlook.com [52.101.193.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C082B4AE128;
	Thu,  3 Sep 2026 13:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788441690; cv=fail; b=nqRTX4AZYtpEPgJ/R2IMIq1ODUYLwQRiNWFABpKDJjfenp4jhW0eyXkkrmHiz/x/7PqiwOsaBFKxjSIHj+DcbkF9D9hRPzGcTH1kKt/Ja9XZZUklL5XmNmhZjG27NqH4tDsNnLirvv8r4YC+KMM9H/M6gD+iV7b+y5+heR6Ecm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788441690; c=relaxed/simple;
	bh=8BbBEg+zHIMDbwhyRnVydO6ULOHigaIBWSaCxrz/mEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NBWDC/z9rY/bUlSDH6jrVeelxI4RjrpXtyRw4yyH45ceItpr2w4eINd8NUiCK8rEDhqwxB1WPNgZ0s4vmgcUiHZ8695nqokwBuHBF4qZXZkPfzf2FViBHpYJrwj7MuabUNssm8dci6Qpl/4kYP2mqK3iOVQlSqsmvDTcQyWLZVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fAr0jYXk; arc=fail smtp.client-ip=52.101.193.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fAr0jYXk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=abZqbHD6iQzEKD7OqlQpUv+pvOo2zXUk+p9+tMtMSddv8GPgG/YUSDreAQAvPpD8zs95gNFLCbVeMbB6PC+ccj+9S1zNC8oIDwnIno7cy1la04aoBtFKeymekVgyZtqsFna+Ce+RipGfRx1WmaQUlRZ2gNYSuJ7Cw5TL+ON58zBQvtpTgoxApTOjaJrVkjGmIKgBd2JqRlaz+CbNr27JVO4NMNXwwNhZ5UwR5y9s4Fw+cG2o8oRpghmVD4OuoHkYRbjJLOJD6aVHnYLD/sd2T6H8Xv7dtpdxJsKop9h1WSQuBqRNsPL2rkIHGKRCkulLNntwPWqrL9TegstVemmwJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HVbe5F4syy5ngPx7J3lvj9aGQ3dI5i5GGc9ewu3Im/A=;
 b=uL7O0QpxS2c33uUuZ2iKLrwGnG3H2k3GcGiWh33dFItimJxYYm7zQ8AZaZeAoVhFVY3TVNnqkkUH1Ez35BGGIoSosFceN1HeWByjRlCpVjG3P6FM+M2s/3mAvjnHWI5HV2l1wuupu5wWHBCNLbnTWSkhXrutuzAIMTtSSWrS2KtMubS8w2KYZfFtehLAUTf2zPheppjlellfTcgT6asDvhJ9MX+/iZD7GniLgINeTOBTuuB4sgWmwuz7Jh4+P4wVY5QYyUcdmqvUa8ZStb6RxQhzSLo8zMHsi/3LKf+P/suMqMmLv0OpyD4DcDPGeBF/ggvoJzHsk719ZT6V8bEJ7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HVbe5F4syy5ngPx7J3lvj9aGQ3dI5i5GGc9ewu3Im/A=;
 b=fAr0jYXkDZLBLsE0epvm4dIDAdv3AF16Pu8d5Tt1Og4k5GzzMslV/Id1vXuFBYzgBO0fLvMoQ/1BqtctgMqWJqNcjyb/sWrQg5TEiGfXkX2kY0Ru5bJ0Jb1Ekd3fpohpj2iuasIrLj6tyB4CbNEwoJ7qSLTVIiQDU/wuux2/3JHDihUVkJTt/aNfyTP38VVAgYg8jmlWzUrS9xmhw9f5l9OwfIfZGlABZ94ZprmAevGm4mqwL+ATMvGprjFOTHLJ0JgecJw9TuSxH+whI4dhRb3zKozlTXYnmHyB7CaAS0nzY2UDOby7X9vmwZqSzZ8Xz3mAVYmCYpCgfCSMdjDRWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by MN0PR12MB5811.namprd12.prod.outlook.com (2603:10b6:208:377::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 13:20:43 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 13:20:43 +0000
From: Yury Norov <ynorov@nvidia.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org (open list)
Cc: Yury Norov <ynorov@nvidia.com>
Subject: [PATCH 2/2] ice: drop pf == NULL check in ice_pf_state_is_nominal()
Date: Thu,  3 Sep 2026 09:20:36 -0400
Message-ID: <20260903132037.81346-3-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903132037.81346-1-ynorov@nvidia.com>
References: <20260903132037.81346-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0097.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::12) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|MN0PR12MB5811:EE_
X-MS-Office365-Filtering-Correlation-Id: 8330f511-03c9-4bda-3541-08df09be27f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|10067099003|11063799006|56012099006|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	ieBYIV29m6r2IXgy7PqKLYhg43vj5gWKLl7CH9A14uyo1/bW0LR6gJz1vMKOsGHfwUWijatjf0K1GgkJ7LgpRQX6BZU68X7cli2JOM1kmqKE3ohh9L9MMTaDS3gDDnj+9WjvoU/pjPREema3baW0AATLgITnfZEqwUQb9PXuq0E67IjEp4TTy1J1VO35B61VBYUiCw/VWtigsILP1YnFaL7HjLkd1Xgm/0FkMl3mxfpmAPLKEMMSpRsYcpb+S4hMLOi6oQoEt25Ur2nuZqYgQsHPZrJqJZJZPMkUiB50G9AtYf9kLqZXFKcY0JBQAjFHYPh6lyNGXtBtENbtZVCVXsmlyfnm9NjQFrJUmQosVSwV/Ec5Pg1Iu1qITpfR7c2EjXFWfum2V4j0iJjLbNxmhPscwrnZ1T9rUoIAjT7MyGc6Xdye0zuKQHz0YiUZUwzOxGiqpykV/qXr6xJ0LHytUtxtIwnB3hxck/SXX0FOZ5GZCEgAZx5gJhDbSUkJC7goOPgjasEarYGKMDKjVVf3EbnfrRt/Lyv0GsKSACHFujSZDPDKPRpElhwyO5OHNdi4K4PC+dxOpkMGxBsnxj3zHc1uk8wCjG8bV02oyO/tkLa5Q7XQe3ekRE67k+0Gji5mC2rHdTPqT1PSg9Ts7mXyZ60XLjUUXO93QUynVN02Lv+CqDFvNLKns5MgBrgAlbebLBysRIzOpQ+nT0lJFPIAjw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AB+bcWmKwrCKoi/MOKSBZB7xx1jLVlGR9vDeaU0B4LnPkz7IvFDGp+u2+ek8?=
 =?us-ascii?Q?i6IDOxP8T6SYfvWYYzYTBv3QkeR0lbOhV5vsLx7msD1wTnQ8knENGEyk3VKe?=
 =?us-ascii?Q?hSdn5gNV8yDOKH/NAnewQF06RPB+NyCCUclPQlFG5vNn5SA2gxL0pgCvHC8e?=
 =?us-ascii?Q?9HBtQmx2MxKRcwtZXtLMOe2PkRPTF4u0Tc610XIjpBw3tstMU6SSyPer5BFE?=
 =?us-ascii?Q?rpLQhUJQdQRoxoaaw64DNjjorUaSTcAOpu1pIBt5Sytk4eUiIK7X3uRT3U87?=
 =?us-ascii?Q?aJ+dI2Aw1MbxFZ9DFu8ocYTETf5B4sH8WAG9HwMu7rb2uwvbvAXXthqChAHm?=
 =?us-ascii?Q?0Z2oJzwKCND8kmmNGxrZmG9Yw5ZgsmntFtX4NtAGWziMLLn+N165qOpxxH5Z?=
 =?us-ascii?Q?9peKp5SEHTHSQJ2PW0JSdf6iXxw2sjupVT+QNxCgUyvIRuyZ3jEHYE588N4+?=
 =?us-ascii?Q?AnPUgJXiIwrB21Y0oK7T/26hiS8ksOPbO3Vir1Y83YhXvCFrNskVfjsJZKEz?=
 =?us-ascii?Q?dh/1vDPboZqFqNkDysYsoICZ4PtSNcZelJnbm/1NoCMCUmXmh6WNOEOb/RhY?=
 =?us-ascii?Q?GnC5nFf+wWcgBxbKBHz4OU970k85tZJDJZ8GUsr8/LN1DdfInkLq1p1vCcgY?=
 =?us-ascii?Q?6kzrhFp8u3YlBeeXgc5rmUCIyh5G+zRhjSwUvinRRDjxgdyZ9Qe+whkseRhm?=
 =?us-ascii?Q?1YQomlQe75VpAUU1UdUgBo+guIWih79731AZ1EKVPSf3wUqEvuk+9UYvtG0/?=
 =?us-ascii?Q?LxsjEQ1e5+8uoQTcCBb2QbjUBDFV8d+Tkqga1Cq/heYO8jGoyaHQbMtm+NJ5?=
 =?us-ascii?Q?nmkuMmnZNRQcwzoH3k67EeFcZ9vnNHhQ2DqkuI9pbdbiPsZoAHVcBx2nX/Iy?=
 =?us-ascii?Q?fojJ9gNcBwhtAjrgoE6UF8KU8Kpq0KTuzz4uLL2NS86T9Ws3iUlN3u29QfAK?=
 =?us-ascii?Q?bwhT4zA9TdEikUiX9MpOH0OWirjNZxGFmBkHhpXWni7FeIgMmTwaxxsmTPLn?=
 =?us-ascii?Q?Vbv7v+QDQOtqWeBiNv98Mw3UsNaxxcxE/OP2v8RkBPxuHd8q6tppOM+AjLUP?=
 =?us-ascii?Q?gw9xlaChSVW4UCdyhzCBpzELOxrEDhPsd6iwAsdN1vw2R5nevFF4oxjVSSl0?=
 =?us-ascii?Q?1B4+y6+4VFQm3p8B9XQuosLNbjuFRgtOYqqJTGf38w2Pjfz1zIDlxb+9Q/Ry?=
 =?us-ascii?Q?Exf4/NEn0WJ+03EnjNMYRCxXZ3cCyFkXUwCVIkbsTOeooME94k7tmvtErkF1?=
 =?us-ascii?Q?nOMGyypGg9qQhECEOZImZvcMZKgmXnZN2YAVwrng1ky+5KgoAzFqvKUWjS0x?=
 =?us-ascii?Q?buCwU/yNDutu8rZ73BZIYDqMwfphhEXEw+Q65sMV5+zqWvSvAByltwnc9Quk?=
 =?us-ascii?Q?D9OoJq6/gW+YOjymFWyDLsUuUmpwM58OlIiG0rG78Z0Q448nLtW3OXTS4T6v?=
 =?us-ascii?Q?hbj3MlK6ElH2RCgXYhAyTpmx1rTCPt2Jq3UWvaviUjUDp0fDewYzyKBC26LX?=
 =?us-ascii?Q?cGgpkXPzmRnoKJ84Gdzj60AVjRH+kTmUYpOjymajjGzXZ8lDVHJcoeznpGUV?=
 =?us-ascii?Q?YCOGr8lO40taxZ6PfbbUOh7C8MtoaxViNLTSy/JtrOD4HpHdWmjAkQqAGvmH?=
 =?us-ascii?Q?kmo3vNX2enp0y2msf8ofLmy959Be5QrgjXpMndbgiCmJxqD5fRrVAddRMdoU?=
 =?us-ascii?Q?GbbU43PmMpFDYix+XovLlJeEs3V46PBv1e8a4jnDhZIeUtwOTl/Jntz9+KEz?=
 =?us-ascii?Q?P8M+Vmfq7w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8330f511-03c9-4bda-3541-08df09be27f4
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 13:20:43.0367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 17QU/OZA40127D90o89LfdjjHd7g6U5YF1dTMTz5JPo5Q8mLM38QgWc12/P9k/4+zqO1RiIkN2cR5k5jH0Oqvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5811

The function has 3 callers, all except one explicitly require
pf != NULL. Add the corresponding check to the remaining caller,
and remove it from the ice_pf_state_is_nominal(). It makse the
fun function a one-liner.

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c  | 3 ---
 drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 73996e3022ef..6d5b8acc4764 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -1705,9 +1705,6 @@ static void ice_vsi_set_rss_flow_fld(struct ice_vsi *vsi)
  */
 bool ice_pf_state_is_nominal(struct ice_pf *pf)
 {
-	if (!pf)
-		return false;
-
 	return bitmap_empty(pf->state, ICE_STATE_NOMINAL_CHECK_BITS);
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index d88835482d3a..168d85f9477f 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5521,7 +5521,7 @@ static int ice_suspend(struct device *dev)
 
 	pf = pci_get_drvdata(pdev);
 
-	if (!ice_pf_state_is_nominal(pf)) {
+	if (!pf || !ice_pf_state_is_nominal(pf)) {
 		dev_err(dev, "Device is not ready, no need to suspend it\n");
 		return -EBUSY;
 	}
-- 
2.53.0

