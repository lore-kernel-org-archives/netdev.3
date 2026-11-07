Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794011067;
	b=ERbFT/QPKaF4pXSc29D0rt+N3qLwiNcmlwKRsgaoBYfLa5vjdAxBGRMORbuqNCDYrv2s
	 BBcB8eOCdlWHnzJMc+8J3OH+GVCp9oI/W27JcAYHVsRjvDHYo7enJIiekYjviBsweFXg1
	 65HkZ+9HTzDeMcq77QFCjVlrY1KbaNaCiHmYmVhShDxDY96AYHWX7/Qqp5WYfYlVmBAvE
	 xoZjBubYe/oEFQz84bqkSCpn2IEKSa6QoSeRvQCD7dNVV5dQO/9uN/Rga5cwZ3So8/Azu
	 ZjkVcSkcr2GNtfMU0MyN6a94VByFPhj+/09jj7KHX/GfrBaU3pMV/p53UZL3zfAWtAg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011067;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=a+PkzlXJrBwqSzENAoooSnQQzmkWuJ2T+L7IWSexJLE=;
	b=T52jBiYlUoLiGt8Qeh4Y/zsbEG69lskp6b5vQVc6aHLtxtb5TtyvM4kjlODmY0fp8HaM
	 h4S52qn9ZXSAP5RQZptvI2whUqscwd/2UvEoIcalEWjowsFB5mjSwxPovCDfSpBj1ua/8
	 F7BKRpbUPBtU5ARJiZrB9vWOdpwxskTEUHd0ho/MhUtA/mPkzpTxACHZYTn4Ec5xanJ+q
	 nPXRoK3ZEBvylQ9NRk/ZH2b5lutjGVMTwP+uA+cX0HLe7fdeD2YRHZ6jP7YiOLpaEel0V
	 k1BDy1hrLBJyMyXQRmnEB2rMfeb3EI5xBCl5zNkv+5xEvdClhbu5GKy+a3CY3BztOaQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=BM96vJ5m;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.42
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010042.outbound.protection.outlook.com [52.101.61.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D0C606A326;
	Sat,  7 Nov 2026 00:24:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63D0C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=BM96vJ5m
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kCKTe1MffRCAjBvadScRfN4fDVRzHWA1XHgfP4j1tY8QwVr6LpLrYNK9yVmtdC5IsAy/xPnzsF3BRGcc8e4ZMkugg6CPrCqw5OEVQSqIqO2xHV3DDSXqeSb38JosrUCYaHY4ogi0uJr6GMSjFlXBCV0fKFpcrvBtMG358tUcKCisagQTx9OfZDFZENwZPlQMhSuFZ7gXLy0HFjEonQGNHfXVuB86H0fEJIakdWQ/JpBCNUFpgokOAhsT1DIGfAb3k7I0yBrbgEzmVJywTtlqpUPg+0U23LpLwi5AT/PSJrdTGjahsB5cBMkjWZULCh3zPjehEdhlzwo4yrjD8Z+Qog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a+PkzlXJrBwqSzENAoooSnQQzmkWuJ2T+L7IWSexJLE=;
 b=KtKAB/q/LBVBxRN3n0gEgFMS3eIa5ApCTRav3pBPZZ6/QDKe+EpmRavJNugWMb/Yw1cX5OrCLFewnQEc605aMiM4lmAd86qByn3B+Y0fhD1Uo+B/SzcUw1ozzW5yJdBm5MFg46Lh8OpTdNXYjx6a1sZWE6fseEgHKrY6edPTOYrr+mk/eqHhxQtW3UD43sXSCZGMBXkxsKTKHvFzCWxTRe4TXWT5zCjXuQpSIjNzR68aUnesV50i6xKoWJAvXHrUVWU5PmXq5AWCSxUu7U3T2fgNEHINwygIvoupa2uRBAWRw76+kVvmaSB6QJGJfrTfRZ4Ov9m6sb2oxb/8iwejjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a+PkzlXJrBwqSzENAoooSnQQzmkWuJ2T+L7IWSexJLE=;
 b=BM96vJ5m97T56tmsFENYfOGHM83Oiyc1v7nkEnUTTVxmQYT0kd/sddfW47mVlOHxKPWF5jjrrkODwT0MQC7zrlzkxLzuU78NoTjcRlz32lclU3W13YTyDyMO+NQWo/d4W1jtdGYf/5CEEp/PzODPUkcJvkkXd0xvG2Q3FXzPs8s=
Received: from CH5PR02CA0007.namprd02.prod.outlook.com (2603:10b6:610:1ed::29)
 by LV5PR12MB9827.namprd12.prod.outlook.com (2603:10b6:408:305::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Sat, 7 Nov 2026
 00:24:05 +0000
Received: from CH01EPF000BE944.namprd02.prod.outlook.com
 (2603:10b6:610:1ed:cafe::7b) by CH5PR02CA0007.outlook.office365.com
 (2603:10b6:610:1ed::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Sat, 7
 Nov 2026 00:24:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH01EPF000BE944.mail.protection.outlook.com (10.167.244.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Sat, 7 Nov 2026 00:24:05 +0000
Received: from [192.168.0.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 6 Nov
 2026 18:24:02 -0600
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
Date: Sat, 7 Nov 2026 00:23:44 +0000
Subject: [PATCH net 2/2] ionic: limit TSO segments to the Tx ring size
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261107-b4-ionic-tso-max-segs-v1-2-67c248a5b681@amd.com>
References: <20261107-b4-ionic-tso-max-segs-v1-0-67c248a5b681@amd.com>
In-Reply-To: <20261107-b4-ionic-tso-max-segs-v1-0-67c248a5b681@amd.com>
To: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Breno Leitao
	<leitao@debian.org>, Eric Joyner <eric.joyner@amd.com>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>, "Nikhil P. Rao" <nikhil.rao@amd.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE944:EE_|LV5PR12MB9827:EE_
X-MS-Office365-Filtering-Correlation-Id: bc279293-e7d1-4cec-83ad-08df3c656ec1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|82310400026|36860700016|261021123027099003|261022105027099003|261021135927099003|56012099006|11063799006|261028144727099003|261021121427099003|261009223027099003|261026140227099003|261022075727099003|261026121527099003|261102123227099003|10067099003|6133799003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	NzEpKbKHgti2Ap2Nq3JWe2uKgQO31lSHu8R/nA7AqGulthn/mZB5M07fEkg8dRO54A9oP96FXCni6z+mStOPJip3Gqfx30rBlwejjKB7IQfHQ77MsNeA/Y0yFCjGNHDEnYDjmT/MzIwgaWZWDwBDutT/CBwONhUo6N4unEy+LtvKLDU57gF3vZIz2Iw3YBtyjlpdEp9SuzHZlMc3NgWHTUyghg8Aw/Fh2w024GfdZXCDRDaEqF02FRemBQacdYZ4WChq20y3kczxjhhwRXepuWU/yqac2QyNUh89xrMbLBTKqrh37Nd4Z4ypBAoMcBU2S52x0JX8Natl5fKtkakFfDeY11/3i3nP+qOAh03O19ezB4tx/UOQHvGeTMX3Z0IyI2s+C6eu4JpIscrL05X1BIhL7z/fjv7oobJADyKsTFvj0xNiLYDLodwPTMw4XtGrAzE6ll4NiCM/+HdnYF5lbfx57TkOKVBo+DOFsF0+Jcz7YK5Pny3L2Qo7XGH58doZ3Y2Bbqm9H2cfRd3ExTTh1WPnsuynAptR4uWpPe5HpqSQe4B29PGQkSSZITneVeWS5hTgTs/CzUfEaNBLjEunVZnpTMBTciBbAhIcAWLuZIoxFym+aI42hDgR7FTrKIRSo9RnPOGXklkSVSF+BfdLLEJbtjinWA068vBZnuMruvV7YUxWl84MDzp475YT3nJNvl58LVf4xV7yzivTCaiwIA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(82310400026)(36860700016)(261021123027099003)(261022105027099003)(261021135927099003)(56012099006)(11063799006)(261028144727099003)(261021121427099003)(261009223027099003)(261026140227099003)(261022075727099003)(261026121527099003)(261102123227099003)(10067099003)(6133799003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/KoOc/zZLLwwSFttLCY98lWSEhZX8RgU+FBh6QXK/RcQXIU2ntwJSEneNaFq8INduW804oSDLMCQMxWQFsu8Vg6xhkLYz3Glfqlu2Pd9p50s2rZWcOWqQijC9+BjYAn84BHDRQNvoBiDXsNeh+cg1GfigDo9XCPrXKO3LVzBNXZiOj52Vsi/8PwiFPyo32l0WB3fb37WitUuKQ6OLJiu3aUquJOxqWRg2OWqf+/Gbdkm4B5If/uAjQzNc+yTbWj23A7flQVNtMQKxUyetfg3uFURZVLLFMamBTWdU+gll8WWUWjvDu7lZlV32NqQG6CG1TgCLtql/7dfj0ZzgYS9MhlqxPtgqtaekwqY66SlaDq+wCb6lHBNINwlizAmR0ypzd2AFV85dkHMoIk0BIYJRrOxSBC6LwdKQs+qOgdsOk0KWLcIGX+LyHKxz8NEuGCV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2026 00:24:05.6863
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc279293-e7d1-4cec-83ad-08df3c656ec1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH01EPF000BE944.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9827

ionic uses one Tx descriptor per TSO segment, so a GSO skb with more
segments than the ring can hold (num_descs - 1) can never be posted.
The driver never tells the stack this limit, so such skbs are built
and handed to it instead of being segmented in software.

Advertise the ring-derived limit as tso_max_segs, so locally
generated TCP stays within it and the core's gso_max_segs check
catches larger skbs.

The core only ever lowers gso_max_segs when tso_max_segs changes, so after
the ring grows gso_max_segs stays at the old limit until the admin raises
it. The driver leaves it there: it cannot tell a value the core lowered
from one the admin set, so raising it could override the admin's choice,
and the helper that sets gso_max_segs is internal to the core.

ionic_cmb_reconfig() applies the new ring size before it allocates the
queues and restores the old one if that fails, so it updates
tso_max_segs only once the allocation has succeeded, rather than
leaving gso_max_segs lowered after a rollback.

Send a features change event after an ethtool Tx ring resize, so
stacked devices (VLAN, macvlan, bond) pick up the new tso_max_segs
instead of keeping the one copied at their creation.

The firmware-recovery replay runs without RTNL, but always with the
current ring size, so it leaves tso_max_segs and gso_max_segs untouched;
rtnetlink changes them only under RTNL.

Fixes: 0f3154e6bcb3 ("ionic: Add Tx and Rx handling")
Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_ethtool.c | 12 +++++++++---
 drivers/net/ethernet/pensando/ionic/ionic_lif.c     | 10 +++++++---
 drivers/net/ethernet/pensando/ionic/ionic_lif.h     | 10 ++++++++++
 3 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
index 3518fbf5882d..556e17023320 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
@@ -689,6 +689,7 @@ static int ionic_set_ringparam(struct net_device *netdev,
 			       struct netlink_ext_ack *extack)
 {
 	struct ionic_lif *lif = netdev_priv(netdev);
+	unsigned int ntxq_descs = lif->ntxq_descs;
 	struct ionic_queue_params qparam;
 	int err;
 
@@ -747,11 +748,12 @@ static int ionic_set_ringparam(struct net_device *netdev,
 		netdev_info(netdev, "Changing Rx ring size from %d to %d\n",
 			    lif->nrxq_descs, ring->rx_pending);
 
-	/* if we're not running, just set the values and return */
+	/* if we're not running, just set the values */
 	if (!netif_running(lif->netdev)) {
-		lif->ntxq_descs = ring->tx_pending;
+		ionic_lif_set_ntxq_descs(lif, ring->tx_pending);
 		lif->nrxq_descs = ring->rx_pending;
-		return 0;
+		err = 0;
+		goto out;
 	}
 
 	mutex_lock(&lif->queue_lock);
@@ -760,6 +762,10 @@ static int ionic_set_ringparam(struct net_device *netdev,
 	if (err)
 		netdev_info(netdev, "Ring reconfiguration failed, changes canceled: %d\n", err);
 
+out:
+	if (lif->ntxq_descs != ntxq_descs)
+		netdev_features_change(netdev);
+
 	return err;
 }
 
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index 7f0da2b0defd..ce1e51f318e0 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -2884,6 +2884,10 @@ static int ionic_cmb_reconfig(struct ionic_lif *lif,
 			}
 		}
 
+		if (lif->ntxq_descs != start_qparams.ntxq_descs)
+			netif_set_tso_max_segs(lif->netdev,
+					       lif->ntxq_descs - 1);
+
 		err = ionic_start_queues_reconfig(lif);
 		if (err) {
 			dev_err(lif->ionic->dev,
@@ -3065,7 +3069,7 @@ int ionic_reconfigure_queues(struct ionic_lif *lif,
 
 	/* swap new desc_info and rings, keeping existing interrupt config */
 	if (tx_qcqs) {
-		lif->ntxq_descs = qparam->ntxq_descs;
+		ionic_lif_set_ntxq_descs(lif, qparam->ntxq_descs);
 		for (i = 0; i < qparam->nxqs; i++)
 			ionic_swap_queues(lif->txqcqs[i], tx_qcqs[i]);
 	}
@@ -3284,10 +3288,10 @@ int ionic_lif_alloc(struct ionic *ionic)
 	lif->index = 0;
 
 	if (is_kdump_kernel()) {
-		lif->ntxq_descs = IONIC_MIN_TXRX_DESC;
+		ionic_lif_set_ntxq_descs(lif, IONIC_MIN_TXRX_DESC);
 		lif->nrxq_descs = IONIC_MIN_TXRX_DESC;
 	} else {
-		lif->ntxq_descs = IONIC_DEF_TXRX_DESC;
+		ionic_lif_set_ntxq_descs(lif, IONIC_DEF_TXRX_DESC);
 		lif->nrxq_descs = IONIC_DEF_TXRX_DESC;
 	}
 
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.h b/drivers/net/ethernet/pensando/ionic/ionic_lif.h
index e790f6b9441e..14aaaeb360a2 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.h
@@ -290,6 +290,16 @@ static inline void ionic_init_queue_params(struct ionic_lif *lif,
 	qparam->cmb_rx = test_bit(IONIC_LIF_F_CMB_RX_RINGS, lif->state);
 }
 
+static inline void ionic_lif_set_ntxq_descs(struct ionic_lif *lif,
+					    unsigned int descs)
+{
+	if (descs == lif->ntxq_descs)
+		return;
+
+	lif->ntxq_descs = descs;
+	netif_set_tso_max_segs(lif->netdev, descs - 1);
+}
+
 static inline void ionic_set_queue_params(struct ionic_lif *lif,
 					  struct ionic_queue_params *qparam)
 {

-- 
2.43.0

