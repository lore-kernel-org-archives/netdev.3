Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011053.outbound.protection.outlook.com [52.101.70.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0B43EFD00;
	Wed, 10 Jun 2026 15:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781104190; cv=fail; b=JnQ6vUg5yF3bPdH8HUpB2ADWorWcyGIk++zSDju/Bryu/AIwAcRJ64+WLOhg4/q4QoR5JXLyE45GqLcb3iTMOf0dIjaMFtvyPwJWQ2g8jXAiRHyfpin182veHnJ+C5nx0Vfkik9awFAKZm+aUZzUWBwomSvSl5CrMEFtg3jjdks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781104190; c=relaxed/simple;
	bh=Wr/9uR5oq0uAE8yNxsqhR6ifslOgrUkDehPMu3wGX9s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lJyHGEYDeOqLqw0FsZlgPD+dD8bjn+yRLrffvvTXur9iM5A9gjrjJoHqGiKvs/htYQrMSNL75FKCYHN08Me6jncjItUUrZ0FVFTXt6f301aHDNLM2GNa7KHnwHCqV9gyjAL2zHe+GfbFiajscQlRnRfRr5SEz6iIblbVeeInfVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Qhzt1J3B; arc=fail smtp.client-ip=52.101.70.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Qhzt1J3B"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RONSW96xxsWjdZr7n8wmbd6CAaEjonNY6HWpajKOAICei36wY2lWyzZ5pumeBxzllh+1yNbuU66Z+h3Qi2ZOTJ1s3wcUVDlZsOJ3AoL8DUoljWHErUG+0MTfOVEHEDI0eBqkVgJQMgngoM4eSfaeRpgrDAbRUyhuNOmmiZuogjhf2f1ow24jpF2YPyjfTJJE7s6eGzXUS6b6rp9hmEl+zGqPtFdAkRpfeLN7FzwPhZWVgLWpTjyGihJ+0k2DWU3MI2hO7HfTm8iVreCDfzAVOjIoVgBGoyIH8l7zNTUiF/Q2AQyYDwr4hFnA9YqBKoS1vONLRyEZeRF3YM/U10PANQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HdCqcaQcMVjaW0l9TSNSHAhgPGIyvSa1kheVXqqMpyI=;
 b=sdC4p7rGxi3QxkKVLWJWCF6gSZuCGHcmBNObMxJ85Qg7ApZKTz867H5i5slInzSwJ7VXK4y8EjeZjQZnPS/fpXfGlm69EKN9uuF/q02Fs9k7l6yi0ZLQ3W1vGb4FxaMfvxj3Vs44kiaUMPdfQRpoG8JUPpUFToD9v+7cBj3Oz4FM6EA9XrnyqPh2GFbKzDNAUvDkMxNIXgzRVenuo5eN8B7jU7h5Adu3kzRA8lNpYhjSrt2M7D1YzlASnTgwDFrZol+aBOxRAheyqfk3e65obOWw6WjwaC04hjwhqUg4IITDsmEYgP0tdkLf4M4ocGwzhQZZPhbg+BdVWhOlm8MP0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HdCqcaQcMVjaW0l9TSNSHAhgPGIyvSa1kheVXqqMpyI=;
 b=Qhzt1J3Bz6ScgiebQrPE0NbAhbGT8A2dlPssZjzsSqK69ZPwj6SsVsxNEpKwijGXIoUbWX/b0hdbM3U8aGkNgDlzN2AP41gWE9ZhpFqJ+NNQOMkOXN0EOTbjmtnKAuRsnJLWhTZQjk6657BydkxT6dKcxFY0ETivCRH0fBZrOa2XsFM+iSzdc0dcDm6ya99PJLFltyiIiCdT/EexlH5oDQ3lvO41fDWk6m/1XdB/JmSVe/lab99D7nwudHruXrOVX3bJMz8d9ss8WfLY1yvhNfwlUcmN/ECjOqjqIQQ4Rv3PCgmuspGA2z0JNkem54CWY+JuijGoVBS3HWrw6aZqTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13) by PAWPR04MB9815.eurprd04.prod.outlook.com
 (2603:10a6:102:381::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Wed, 10 Jun
 2026 15:09:42 +0000
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd]) by GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd%6]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 15:09:42 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net-next 4/5] dpaa2-switch: move FDB selection for leave path into a helper
Date: Wed, 10 Jun 2026 18:09:11 +0300
Message-Id: <20260610150912.1788482-5-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260610150912.1788482-1-ioana.ciornei@nxp.com>
References: <20260610150912.1788482-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FRYP281CA0003.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::13)
 To GVXPR04MB12290.eurprd04.prod.outlook.com (2603:10a6:150:319::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12290:EE_|PAWPR04MB9815:EE_
X-MS-Office365-Filtering-Correlation-Id: 8121d0b2-fdc3-4ca9-7781-08dec7024ccb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|19092799006|23010399003|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	Gj/DIDfBgzcgfF5IE2vH2srJjnqU2KieAU80jD35bMxyyJgwZQaU5T7kElzXweQQ+YzgeX3aCvBXC5+35viOOQIGBNlVNM2xSp5dZFZwbHEAqOCdRYHpxxJ5PYg9TCFdxBQ0J3UszOG0+Dr+j1EpOPNEQSyLgzTw9aP56/HWkvikDjrF3nXn1mSGQuYMrhDtykVLB3FuwPoqeEhs4yOvItkI0jtx/vzZzvXWUyd4Wo4/hlnCw3d4dHJvl9WyI9UnXZRK3FdsiL+l8cJHb6lHlARjNO7EPDv6epbGNITnGVHTnsm6q8Qq7wji/uSBjXlTXNGSUct8R1lkB4vYdOIOZgfK4ftZQG4RjDnNIET6vUlDzTb5Odi1xd4+skz4tAiARuXQoqNjBmqXg9rr/BoLUlDBhQqzadLVJihd15CYWC3HgcCRV1jVdfQe9g5/gf39Hxoravm+Mq2XyYw+dOQm3+/wj3dsccgbmJWEqJSrsQarfkxonIlyHek5O1Ki0y15GuxDf4W50jTdoxyoabUHfSW4MKHGlgiVrGwIfSx17Tw/2QonBwnXCFCUuSdFx/KuuAkFp7Jf0kEK0uyKHkwxuGxoIOF3liG+gNWro+pt7dJDftwxrT+e9u239EN5v0jqTkmhtXndQeQmYeWN9uTyWMpCgezbTfFPJBsHjdUbU9qFbhdgMb10wC+AVcM260TS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12290.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(19092799006)(23010399003)(11063799006)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+dd8T4A3cOEITfNOrbyBsO5elQZMadpw73Sp8g7gU5IgaVLQfYoZ+MHOdd0/?=
 =?us-ascii?Q?EXE1mmXFmZNxTdTEXKOBGCCHf6a1T1AQI5OOdqnCS0HtRlItKQ/pMo2NPszX?=
 =?us-ascii?Q?TRZOED2s0dJ3LdP9tnUxEGxy/HPBqUXxRGk2HbU0BmSXVPEp3Gy6LxQwsx1s?=
 =?us-ascii?Q?vSg1nN1OTsBIDJWXvAiZYMIdDM28vepZnej3egti3aR/SXtJR3NPaMQ8MTvB?=
 =?us-ascii?Q?QQpNgM151sSTE+Na20+0AA61smBKzYEeYgTruB1eA/HFgpUdynZSGjnkEk6Y?=
 =?us-ascii?Q?DAxJsCCcizuEYgnRZgEkgwhk/r+6B4LEWyB8jO58P5XJewmxMtRhjkP2vdJ6?=
 =?us-ascii?Q?Ek5JfTH1TkEbeUC/NTRn5GixvtgEJMDahE5v34lgnVDYuGU3/j0TPdchLx+p?=
 =?us-ascii?Q?CX33s2p2lYdwOzkpY2Tf9VkTZT50wh2HR/tQ9K8c32FmZjohSdF5wT04yyYA?=
 =?us-ascii?Q?dbHgkQNYhcxiKyQN0UaghpayOvKKZfGRv93zc3oRpZx+S5XAD4qqVSsJA2yO?=
 =?us-ascii?Q?8kC2Jk1oVQufIW5juV4jpL8bzcchSQeUnEMXGpunV2sR0lNMhmybnLIPlBw4?=
 =?us-ascii?Q?5PN5p4BN4X1ROyKZl59gCkbPgK8n2R70dExmtyXwPjrc9oTRRlsmByIA770s?=
 =?us-ascii?Q?dZkN/JM0WtluHL93oKz3BY1G33gI4MT5ShT2QYjoeT9QNL/FiqIQCzRBDH+Z?=
 =?us-ascii?Q?kVnPwGY7W/ty2oLUOgaacJR7q0tgSnTSQwbvzyHjsyynIURwx9tJZDsrR9bN?=
 =?us-ascii?Q?scFYJ2Y9X6GpSyNgQoK4XkTD6Ov4OF9DTqXrWirDDrOu2Ls1KPpShoks5YJB?=
 =?us-ascii?Q?aPIicta0v19ZIRV2pOLk458My9EWs0P856kEvkpijCPWL6igjm5ncC2oJ6T+?=
 =?us-ascii?Q?wu36ZCndBb5ZP6ifruqn+K6sRTddxzYrtjW0M9EuaaWtvbSZF9k+W1t+FsTK?=
 =?us-ascii?Q?RVmKZHNG1E3EC4ncU/6O2SK3sl9jQqfXttwkomrm5dgBmQlpa9Nenrf8ZasB?=
 =?us-ascii?Q?HGr/kEu4MOdZouGKcjTdaK0xegpulx8emcCMObwRon/HF8PvMB14hSTDtvbr?=
 =?us-ascii?Q?9N/RyUekHVfv/hzWYNs7JOmDEIHsi7OPY8uytKSjtsh/+cqLeAneCE0QH4Ca?=
 =?us-ascii?Q?7xurJqjjb2hC1sJLe2zUBkmHMa0fHLFKGcSQcG3J1e9nzM4rN9EMERST/22N?=
 =?us-ascii?Q?LTADoZB9oh1r5LtKmJOzvti1+PPArqwI5Z8H4MTBOm28ApY0T44JARW/pUtX?=
 =?us-ascii?Q?F7/F06wTqatk/MvpS048Zo0xjeSU7uzijdNV2kBuKgzqsuMAVB2ssGhzruUE?=
 =?us-ascii?Q?6dHRuVpm4N90U8FVnjPBM93iQjQcuDpo4JO3OrwuJi/A1yBwL3QrrY9Sh2EJ?=
 =?us-ascii?Q?ZmRg18NOqHnO8bg+wHboI3LiPhf1eF9jqH+bpvl8zOZ+bFiqHTs+FAqThA2i?=
 =?us-ascii?Q?56dhp+5TUBNOUcJLyyF9IiYmQVngB+YL9MnalmrkscgLUgc2kRCaZ2Loam8+?=
 =?us-ascii?Q?/fhB0AHJrAgkxIwV0kS/FInmUmBle7xezZxtvBwK/Kjy6P8AkkSJFs8hqZFI?=
 =?us-ascii?Q?G+88+AVB/q5BNDywPSecQrDKFcNmh1dwfR+eob7MyNDHempMaWPHCZ8YBHnQ?=
 =?us-ascii?Q?AOzuUq2SGgzMaZACOBf4MMsPOZRmEBxQlh7OUBzhuTn2LYGDcVmNcMZKMRxz?=
 =?us-ascii?Q?biO2QFN3OdwoGVp+oCIhWNlCVtJT9lF+9ca9TTuDQN+ZKEq6WstpXSM5hwgd?=
 =?us-ascii?Q?u0QAgg6lEA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8121d0b2-fdc3-4ca9-7781-08dec7024ccb
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12290.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 15:09:42.7044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BoVCO4VOqK/fF0BHNVIL3bxv32mjeear/7mG7nhwokKAuFcDMxyibBM/i2E6TUBdGEA1EaVRrqUfV0VpHzWfag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9815

Move the FDB selection for when a port leaves bridge into a new helper -
dpaa2_switch_fdb_for_leave(). This will hopefully make the
dpaa2_switch_port_set_fdb() function easier to read and follow. The new
helper only determines the FDB to be used, any updates into the private
port structure still gets done in the set_fdb() function.

No changes in the actual behavior are intended.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 .../ethernet/freescale/dpaa2/dpaa2-switch.c   | 48 ++++++++++++-------
 1 file changed, 30 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index 158d0f510eae..09604c84a614 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -98,35 +98,47 @@ dpaa2_switch_fdb_for_join(struct ethsw_port_priv *port_priv,
 	return port_priv->fdb;
 }
 
+static struct dpaa2_switch_fdb *
+dpaa2_switch_fdb_for_leave(struct ethsw_port_priv *port_priv)
+{
+	struct ethsw_core *ethsw = port_priv->ethsw_data;
+
+	/* If this is the last user of the FDB, just keep using it. */
+	if (!dpaa2_switch_fdb_in_use_by_others(ethsw, port_priv->fdb,
+					       port_priv)) {
+		return port_priv->fdb;
+	}
+
+	/* Since we are not the last port which leaves a bridge,
+	 * acquire a new FDB and use it.
+	 */
+	return dpaa2_switch_fdb_get_unused(ethsw);
+}
+
 static void dpaa2_switch_port_set_fdb(struct ethsw_port_priv *port_priv,
 				      struct net_device *upper_dev,
 				      bool linking)
 {
-	struct ethsw_core *ethsw = port_priv->ethsw_data;
-	struct dpaa2_switch_fdb *new_fdb, *fdb;
+	struct dpaa2_switch_fdb *new_fdb;
 
 	/* If we leave a bridge, find an unused FDB and use that. */
 	if (!linking) {
-		/* If this is the last user of the FDB, just keep using it. */
-		if (!dpaa2_switch_fdb_in_use_by_others(ethsw, port_priv->fdb,
-						       port_priv)) {
-			port_priv->fdb->bridge_dev = NULL;
-			return;
-		}
-
-		/* Since we are not the last port which leaves a bridge,
-		 * acquire a new FDB and use it. The number of FDBs is sized to
-		 * accommodate all switch ports as standalone, each with its
-		 * private FDB, which means that dpaa2_switch_fdb_get_unused()
-		 * must succeed here. WARN if not.
+		/* The number of FDBs is sized to accommodate all switch ports
+		 * as standalone, each with its private FDB, which means that
+		 * dpaa2_switch_fdb_get_unused() must succeed here. WARN if
+		 * not.
 		 */
-		fdb = dpaa2_switch_fdb_get_unused(port_priv->ethsw_data);
-		if (WARN_ON(!fdb))
+		new_fdb = dpaa2_switch_fdb_for_leave(port_priv);
+		if (WARN_ON(!new_fdb))
 			return;
 
-		port_priv->fdb = fdb;
-		port_priv->fdb->in_use = true;
+		if (port_priv->fdb != new_fdb) {
+			port_priv->fdb = new_fdb;
+			port_priv->fdb->in_use = true;
+		}
+
 		port_priv->fdb->bridge_dev = NULL;
+
 		return;
 	}
 
-- 
2.25.1

