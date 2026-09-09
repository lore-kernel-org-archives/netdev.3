Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013032.outbound.protection.outlook.com [40.107.162.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F394E524AF2;
	Wed,  9 Sep 2026 10:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788950189; cv=fail; b=EtKTRWaulSzZ6FyJ6+b2ilIbQz81ul2cSAASWDztT3p0EJEKIweM7GCPxNsT3Bc9qZFVUxdwBmQ8YYuEzvLFA9Gi2nRRKmXnCY5fmnms2nSsD1vhiFCeFdur4g9qmWBLMZ1edqigiK+2coqB5IVxPaeIfQlA4iMOSsJbWyiCKwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788950189; c=relaxed/simple;
	bh=FbIbOAtirg+wMY/GmoCkvpteBWDBfC5QoARf95S2IZI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z79SNXBY6FGyZHBEzEN3QSfveNKmG+Z9tkJD2iOm+OczSv4+FFnM6Mtm3IFc6eWbsMaebadYFCSAILI6VYofaSYa8stl2Fqcb4b2fGtJM7owrckksxQrkWy+QPEoGMPcUnHbR5Uu5m7IqVCThsW9iVDcBKrhrPdvlL+rVqgaQNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=d1Colr5W; arc=fail smtp.client-ip=40.107.162.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="d1Colr5W"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OHyYoLh9qIzsr0klqs+6x4sZkLMjfnLz9NR2I/oWX5nYVUHZy2uwrzQhIFdZCDv4vd/eP0oWAymoMeZUoUzRsrFbCn1sua8WcqQWzxNnca46it93jdECk8ctqtubVAUy9C7opRzOSFDzDADPnE2CYZfnwbdsPZfBgRmOttsOCLr5vIuQbBsQXcaqQegNKL2mD+wcsVIAHVIMs3bRbGil/fseWPZYH9KAsQhg1XMvkgIafMT7FWAydVzubalzummUiv8lw08XoA0UIzA74rA6vxVkGGGhfPQ+aSqX7tJowovOE2ItwP2/8/ARAl/VQ2pFQfE5ljIInK9baALf+SgZLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UYqm8awxh2dBasrt0qml5HIFvwd3+LvhtR/CvDYfWFM=;
 b=pVCzh1pYFIKQsh8NhN1nwkjiov+hdw6z0pbSZKaX6K1kBBGm5PCaUeSZiI3heVQotkTo1++BUE7fNLjN5XELakhTGBePauPdDLoVF4mOo5D+S87xhKtifAHjXrIxdLkOOrxp4S8Qdd3jaOQI9SJzmJ/uGhzxURZYlShXtmquuX5YV55wOv84bVXFYQa/OzU01RwTxEf2/5VyylWdnSPWlngAbd+iwHCeyGQV2d/OivQ6JuDMklEemd5IoVPsxTxkTGHvh8XATgP6PnQw6bZDDUjTQyLOHVFagBqPQdhUxQZasNzAxYbYpbYsjaSVuqgM/yQDETURqOKesZJqhfuadg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UYqm8awxh2dBasrt0qml5HIFvwd3+LvhtR/CvDYfWFM=;
 b=d1Colr5WhGNcKSJMs219OTRSakFh7XKNsVtoaMU+msFFHUjzNbOHKpaKKGXqQqP9RfRfT6r/jOwxoWMMbN1/5jx366ibsHPqiXoPojoZtCqXXiAruDzHvwPmHvEBjwRTfoAFYI4v8cE+7OVqVkTMFBx1A5l/ZdZ+w7rL3SL1ttzMsnAEL0NZnX6DRDAXPMXXZhu6Vwrg03Nu73fOUuTLFaMbKP5lMtRpmz7/AVvNOIaG94YLjqg/pX9iqBHeN13rkPwyMtFjbM2/lQN89MCe9JRgoLpkPTMoOTKESnDSyi+dxn+W5VK+fy18+WNQW4HNZmWKECSlTEO0lTJ4H1bM+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by DB8PR04MB7066.eurprd04.prod.outlook.com (2603:10a6:10:12e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Wed, 9 Sep 2026
 10:36:25 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 10:36:25 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 net-next 08/15] net: enetc: move mac_filter from struct enetc_pf to struct enetc_si
Date: Wed,  9 Sep 2026 18:07:26 +0800
Message-Id: <20260909100733.1139689-9-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260909100733.1139689-1-wei.fang@oss.nxp.com>
References: <20260909100733.1139689-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ME3P282CA0155.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:1c3::17) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|DB8PR04MB7066:EE_
X-MS-Office365-Filtering-Correlation-Id: dbfefaad-d923-4cb1-9287-08df0e5e3293
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|376014|1800799024|23010399003|366016|10067099003|11063799006|56012099006|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	JJI0Faeaw2pWIdGDNURtXaNHbUVZn9huxkTkcZetwZ0lErykMksg2lzHTkBDeuKuG1u03v6V08pivgCOLRbdibtvHrECooudko77kRst7tMZUCQKHxAhHf2l7X4SinvrV0wwQhhOhHv6LrYz5R5jhd13XiVi+dby1vpNOwFgsxzv0NeV6kBb2ZK53AMe9kUnMH0OkjDXPRnKw4Z14u0ENkrIH0dq3k/jWMSruC4oDL8ieXqFDD7pSJagT96WYNBAoNKAw0vv1ng4AqXKd9bTFlktXlueUHFclHUHMN62jj45bMm28i2Ef6ddtYGDN8QKdJWjv0ygMholJcY9QdJbCJ7ctxYVW+IemcZZSbOCS1PRL22B2DP1oLqxfEBzWX4/VmFjm24EGz1ZSQaq8wm+TffE6o5geyId2LejK8T00dSqYHd8t0aWLKwFMXkSuJ/HoyRLUF6/zlqvWDC5Q5qXe1fWwm8oEU8lbYPINVTwzWgc6nTX8JSTVilugKGMJXWQdIgC9HlZuEtaHaxQVGGTqh3xiocwjzb3CZtohhwTcIAH9IWOf5rD8bHODyW27EPoRYBM9C+1OU1ewWRkfR5T8NMrUfvbbN62lAMrk2Uljmzpv2EvvZjJEbHe7hC+CK92fk/rlBLJSzfCvtWLczt5q4VQ38pkM9bUg/QajOzLhmaqnyssAdBA4FY+ixis6u9tvvsM48q6GF9XA9JnJuW3SA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(1800799024)(23010399003)(366016)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O0g0wGGw5H0Em3Zk2XsDpCiHPbTsjslT6UPYJqFIxV3F/8icin13p5n+J4RZ?=
 =?us-ascii?Q?1Q9MZuA+/m6yk4n7IsJwagwwsn7OuFnolPtOzaqFwFbrZhbO+TM7G9VHwVau?=
 =?us-ascii?Q?5i8dA258ClQ4yILESeqizDDjih0q479qXsxTpXOB7xDXB/0rTG59Qm5+AXSP?=
 =?us-ascii?Q?BTd4/5zxTvogkZMq9iZIpvkHTtWm2haZC9YzEqZskGQetxrUFEiLDoeYnRnj?=
 =?us-ascii?Q?4mvSPkqzlrAIZJ/TZXlRewUY0p4l/RTcEawKa3KefjnSiEpeIp9PQfsFce3u?=
 =?us-ascii?Q?bN5KIxgN9Knukj6rp319h9z96XliknxMpurfHlpNhTdvWrrENZb5o+B43lQj?=
 =?us-ascii?Q?FV1GKk9CyhwySx+jIDOAcCJp6yPTJj0I10ghFTINg9iYvmp4QJjZBO9wQKLk?=
 =?us-ascii?Q?sb8qBtx/rWpKAm7+aJhTHDD6UPUuKtaMXx2J0glEScfB6lcSS28vCSX+SAqj?=
 =?us-ascii?Q?vAW4KUFe9Dw10bkbn9QJZX/OagT6kyEBOA902Esmp5LAJTRujyvIBJT3tXAo?=
 =?us-ascii?Q?Av63V/7lfUCqxsXYuoyGVmPjMYCIa2yftyqC9XgfKO24JbF+ZaaHSX795uw6?=
 =?us-ascii?Q?ZgmOq/hYXRU5YXTg4jQ4KdM0fMcC0dHaPF/b8rZkirT807IijmxW0eRGJAhQ?=
 =?us-ascii?Q?GYykknCgwr43ntMQBQ5hq25CY8uMWk2ujO/CPPtHDrVD+ox0oxw7/cfyRxdI?=
 =?us-ascii?Q?P2twbl0oh3Dd/Uirj3GGoPfEye2H6dk63oXL2FHcvRxtrs0vw7/hquHI81jI?=
 =?us-ascii?Q?lzk9teem1tWK0CSMWcPnlL7g3QkuERegSPoVa3Eb6eADu+lgAbJooLZdOlg7?=
 =?us-ascii?Q?BErfHfPSpE6BguACu20zdBPWq/xXph7e9LkMwCmsgy7ly8jQ9h9XUTEzo4YP?=
 =?us-ascii?Q?jSz5qyeV6CJguBooGS0yz2WP8bQTHIGbSImehVz9hgId8o7W5tycqJLnimSH?=
 =?us-ascii?Q?qz+vCPxb91MwGRaJUecORdjK9hUnn3dK893+HRiPcwbly9ezVdfQYHAk+HJA?=
 =?us-ascii?Q?Tj4S/WX6EgNLdpHd/4IKsIGxUNGIsOBhMeK8KvpLAwhaHa1oc7RizM3/lAom?=
 =?us-ascii?Q?guEvitaPIR4fZfMZnQ/HoJGZcjnUywEEQb8ZqV0BZH1R08yWuLdrJSV2oIIv?=
 =?us-ascii?Q?cjfLb5bbuul0IsnPk/YHgRA04HRAj0TRvtnbFDCUghevi0e9wNzRJAEHbNOZ?=
 =?us-ascii?Q?uU0QB+h4bxy4aMxv8h8fsWzB3uo2MmBAeEaih58NEmhQRBiMXGsO+jeJsqjb?=
 =?us-ascii?Q?0SlkOTH7q8MbbAWIAKP1Q0LlEC/I81ASGNWjd3g+MhHB6/rz2jAI7lQmse6e?=
 =?us-ascii?Q?PUcb6lkJHm8jvdG9f/JqRj1MMSJfr940Buf3HAmhHfKuvsEnQPtGF0D4I6pV?=
 =?us-ascii?Q?Ga4i5JiDwdjmsUKhuTNe1oHdtJEWtbKw2wT2WNEWKiORJBLvDlFgjSWjoea+?=
 =?us-ascii?Q?a9KZOlbPjSAAGWFZf6SYbfs0NznOgjwm3mjeQFUa24NZy4is9RqeXbjTD9N3?=
 =?us-ascii?Q?asd/b/jFtdud9nhtRmRLaznYN4cRNH+SnzqIsehyzGIdU74lkioyUm6Lu1BK?=
 =?us-ascii?Q?RzNZVBbt66lrBWqC2GoW7uEeKgNvngh02DUleQI9rxBvKPKkJ2I9WB53qJx2?=
 =?us-ascii?Q?6O/43AZjogqdc/dFM6EK4ktC8JsFh4VV37v7ixlYZBCO2fyzJAU1v0KsPj8v?=
 =?us-ascii?Q?cmt045eySAk82CoOR6YMdjq7hplsm/YkHHD5sZomFmoQtuyos3vvv9hdJxAY?=
 =?us-ascii?Q?RPzj6GjSOM/aVBiklFS7mLBWfOYcc2wCQhtn5+Tr9EsJ48PmDefd?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbfefaad-d923-4cb1-9287-08df0e5e3293
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 10:36:25.1277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gfcg9cwG8+z58wXfJFxVqYDjiWk3cbFmhuSooDw/8ZQiCgzgOtKFqHJgPJb4MMi1oSs7pDBjoeAfJ3aNZJe9EG9/AwNnWQJHIuDZWr29z9gvmOs8hjIaFep8JHwtwq6Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7066

From: Wei Fang <wei.fang@nxp.com>

The mac_filter array currently resides in struct enetc_pf and is used to
track unicast and multicast MAC address filters for the PF. Since struct
enetc_si is the common structure shared between the PF and VF drivers,
move mac_filter into struct enetc_si to prepare for MAC filter support
in the VF driver.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.h    |  2 ++
 .../net/ethernet/freescale/enetc/enetc4_pf.c    |  6 +++---
 drivers/net/ethernet/freescale/enetc/enetc_pf.c | 17 ++++++++---------
 drivers/net/ethernet/freescale/enetc/enetc_pf.h |  2 --
 4 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index 0eff25b0c81b..0501cc2fc304 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -337,6 +337,8 @@ struct enetc_si {
 	struct workqueue_struct *workqueue;
 	struct work_struct msg_task;
 	char msg_int_name[ENETC_INT_NAME_MAX];
+
+	struct enetc_mac_filter mac_filter[MADDR_TYPE];
 };
 
 #define ENETC_SI_ALIGN	32
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index a44d50b7fd2a..eedcaf2d7bc9 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -137,7 +137,7 @@ static int enetc4_pf_add_maft_entries(struct enetc_pf *pf,
 static void enetc4_pf_set_uc_hash_filter(struct enetc_pf *pf,
 					 struct netdev_hw_addr_list *uc)
 {
-	struct enetc_mac_filter *mac_filter = &pf->mac_filter[UC];
+	struct enetc_mac_filter *mac_filter = &pf->si->mac_filter[UC];
 	struct netdev_hw_addr *ha;
 	u64 hash;
 
@@ -172,7 +172,7 @@ static int enetc4_pf_set_uc_exact_filter(struct enetc_pf *pf,
 
 	err = enetc4_pf_add_maft_entries(pf, uc);
 	if (!err) {
-		enetc_reset_mac_addr_filter(&pf->mac_filter[UC]);
+		enetc_reset_mac_addr_filter(&si->mac_filter[UC]);
 		enetc_set_si_uc_hash_filter(si, 0, 0);
 	}
 
@@ -182,7 +182,7 @@ static int enetc4_pf_set_uc_exact_filter(struct enetc_pf *pf,
 static void enetc4_pf_set_mc_hash_filter(struct enetc_pf *pf,
 					 struct netdev_hw_addr_list *mc)
 {
-	struct enetc_mac_filter *mac_filter = &pf->mac_filter[MC];
+	struct enetc_mac_filter *mac_filter = &pf->si->mac_filter[MC];
 	struct netdev_hw_addr *ha;
 	u64 hash;
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index c467dc05510e..523c71324780 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -60,10 +60,9 @@ static void enetc_add_mac_addr_em_filter(struct enetc_mac_filter *filter,
 	filter->mac_addr_cnt++;
 }
 
-static void enetc_sync_mac_filters(struct enetc_pf *pf)
+static void enetc_sync_mac_filters(struct enetc_si *si)
 {
-	struct enetc_mac_filter *f = pf->mac_filter;
-	struct enetc_si *si = pf->si;
+	struct enetc_mac_filter *f = si->mac_filter;
 	int i, pos;
 
 	pos = EMETC_MAC_ADDR_FILT_RES;
@@ -115,9 +114,9 @@ static void enetc_sync_mac_filters(struct enetc_pf *pf)
 static void enetc_pf_set_rx_mode(struct net_device *ndev)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
-	struct enetc_pf *pf = enetc_si_priv(priv->si);
 	bool uprom = false, mprom = false;
 	struct enetc_mac_filter *filter;
+	struct enetc_si *si = priv->si;
 	struct netdev_hw_addr *ha;
 	bool em;
 
@@ -133,7 +132,7 @@ static void enetc_pf_set_rx_mode(struct net_device *ndev)
 	/* first 2 filter entries belong to PF */
 	if (!uprom) {
 		/* Update unicast filters */
-		filter = &pf->mac_filter[UC];
+		filter = &si->mac_filter[UC];
 		enetc_reset_mac_addr_filter(filter);
 
 		em = (netdev_uc_count(ndev) == 1);
@@ -149,7 +148,7 @@ static void enetc_pf_set_rx_mode(struct net_device *ndev)
 
 	if (!mprom) {
 		/* Update multicast filters */
-		filter = &pf->mac_filter[MC];
+		filter = &si->mac_filter[MC];
 		enetc_reset_mac_addr_filter(filter);
 
 		netdev_for_each_mc_addr(ha, ndev) {
@@ -162,10 +161,10 @@ static void enetc_pf_set_rx_mode(struct net_device *ndev)
 
 	if (!uprom || !mprom)
 		/* update PF entries */
-		enetc_sync_mac_filters(pf);
+		enetc_sync_mac_filters(si);
 
-	enetc_set_si_uc_promisc(priv->si, 0, uprom);
-	enetc_set_si_mc_promisc(priv->si, 0, mprom);
+	enetc_set_si_uc_promisc(si, 0, uprom);
+	enetc_set_si_mc_promisc(si, 0, mprom);
 }
 
 static void enetc_set_loopback(struct net_device *ndev, bool en)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
index b3ad498f91a0..88a558649c68 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
@@ -40,8 +40,6 @@ struct enetc_pf {
 	int num_vfs; /* number of active VFs, after sriov_init */
 	int total_vfs; /* max number of VFs, set for PF at probe */
 	struct enetc_vf_state *vf_state;
-
-	struct enetc_mac_filter mac_filter[MADDR_TYPE];
 	struct enetc_msg_swbd *rxmsg;
 
 	DECLARE_BITMAP(vlan_ht_filter, ENETC_VLAN_HT_SIZE);
-- 
2.34.1

