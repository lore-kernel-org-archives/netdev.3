Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013002.outbound.protection.outlook.com [40.93.201.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23C93CF1F2;
	Fri,  7 Aug 2026 09:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786096237; cv=fail; b=ZE0GhIr85aAGnJI72Gc/UKMRd7oZs6nURkqmxyv0CxaXnR7anCsNCgetbTnee1WvNdMqoljptPKO0K0Sqdh0y4NcIwbSa+UpO88xjdiQLcXMUYfu1Fs6t6WYS/gmRkcVtthyQmMORvrpCDYlc6uMiVe0AjS6bJNJfHuc4bLIw08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786096237; c=relaxed/simple;
	bh=hSDUaNnA6t1J1l9ruMzpSdiYmnccDx9mBokbR0dJ2kA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pKlFl2z35yrEx6yqlVTrT+ij6qrYqzoQ8k+zTarGj1dLcbaGLzCHRmTwLpi6zNj1Qp7OOPvP4ytTc4GSe+zLkN6KRfkFE8AcggZ0LsRFHCqX6qEHu1kYIpCO8xzj+nv5Cc3vtWGWfkqkKDo5JeD5IdiqfCRmMsfPh3PP1YF3mlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NKaQG5xt; arc=fail smtp.client-ip=40.93.201.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NKaQG5xt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wIw/OC0uXS1Hos0JlrJ07jXcO5E838OuIu4K4JFgrYk+gENmXGupEzViSsqmTjpO4pubqZ0OKWcTpoYmqxKa0+ogJjfnlU02bQh3w473f+RDCFxM37cHTQSHM5V8pSMrgE8+xxlWsn1s36fH+pkhJ27OEeXPKixm7gMvqhQL28X5GnynKl0hMbJDxHqWsfk2WTExR9y5PN/EtzdRMcNAMsqHXVC0fTg7/5zoe+ZHY1C1K8Knn+yrobFpwtMxQtzTc2dOSLcrSgwy2In6zRQxKfTxRH6yr2irQ/3ovkOQ3rXJuayTJqO1jFueBMvLL49hwn17zPpaJph0tEigC/tTew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xwZ7kvkovkJ/1+8RUsGdVvqIjA1ijGgP/y0x2A19h9o=;
 b=W3JfrcVjS1pZR3zhvOIEhP7N5hpLndn+abcR861WQVY53WNCKjHUv3SwazFq+DSZemYkd2oHix7WVkM+22b9U1w0NM7vrDvlTk+yo1JBAihbp8liurpP/CDjbJ2X1thxXkMPGybjzi5+KqWz0QpEYp7DrXhd9Z0iXD4Sfwd1IESd6OwUAq5sO0qAZlmf0FkLdJPs6ZmVaYAJT87ukskXvBDRfTDvQ0Ui/gTg/KWyAcx58LX46rq5xbE7vySQ6dQeBD17wANHNzKKPQ8JkrfzhaXbjCFIYE6boXe1eZk9HGnf7pp1BcwCy0AtZvMY5PqtcC33R93rzURNEyqzc0E91Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xwZ7kvkovkJ/1+8RUsGdVvqIjA1ijGgP/y0x2A19h9o=;
 b=NKaQG5xtMdmalW98ojacGWsySD0sC343uUotL5QJK43uCtxVHCo0zDQLJQZc3dsUNsszUi7miOXuJk2+HaElqjbbDIG7cDfLT4ML8qdM2+kZDfRi0StI1YkgzNgF0wvDW+/q/V/dTrIuUEDb1x5JNB9yTuMYY2dRaIwyB6qJyaU=
Received: from MN0P220CA0025.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::33)
 by CH2PR12MB4167.namprd12.prod.outlook.com (2603:10b6:610:7a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.20; Fri, 7 Aug
 2026 09:50:30 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:208:52e:cafe::a0) by MN0P220CA0025.outlook.office365.com
 (2603:10b6:208:52e::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.23 via Frontend Transport; Fri, 7
 Aug 2026 09:50:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Fri, 7 Aug 2026 09:50:29 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 7 Aug
 2026 04:50:20 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 7 Aug
 2026 04:50:19 -0500
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 7 Aug 2026 04:50:16 -0500
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <theo.lebrun@bootlin.com>, <conor.dooley@microchip.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <vineeth.karumanchi@amd.com>, <git@amd.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 1/4] net: macb: Rename MACB_CAPS_QBV to MACB_CAPS_TC
Date: Fri, 7 Aug 2026 15:20:09 +0530
Message-ID: <20260807095012.640223-2-vineeth.karumanchi@amd.com>
X-Mailer: git-send-email 2.44.4
In-Reply-To: <20260807095012.640223-1-vineeth.karumanchi@amd.com>
References: <20260807095012.640223-1-vineeth.karumanchi@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|CH2PR12MB4167:EE_
X-MS-Office365-Filtering-Correlation-Id: d09e89ee-f422-4a6f-636b-08def46950c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|36860700016|376014|56012099006|11063799006|5023799004|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	VXj3R9R/VXpFQVvr3Mg7AESoi2hTwDEO/3P6KI/MDSFtkHkUyvs5xnheW7zpl6npC23fmTTvyYC+UYbNVo+kaQpQIgu6yDbtNb/l9S9/FiJpol62L+ePsRJjgZYRShd1oPdhiPljjidMKLMbvZvki67BFHNmRiOFuNCn2av/HIGZul+RmUm4Ue08Rh1wDENEULygPrpPdUF5OZWooyvwqtiWl8cHQWeWf4OrXN7rYKpENDqaLbwFu84B3Ao8hhd6XQAMUtxmZblx6G4d7qeAeUin3rCBkhOe9U/3uKo6KdOg6hZhGol/DAQYzfi4FvBDJdsdg2Rh9QBMB4YpczCHg9qOXuIsn/lMF8ECI5zVUMP3Ji2ZpJYnTJN+eNMeG4iiRDAvxgvCgzNcKr2Dtt/M8Ozorrm2UZ/fKnBm9nvpjRykZ5jfO59X+JeCpG2kr8sVHdPT46j13xwN/bdEduTa9meSNC6D1qgahuOyZAQxWmUjtEn/dGastxcm7DVP9rcKDPgTRRGNSs/vK4ULkb73Zf8kNrSWynUjvniks1PF0IFyzAd/F5C3/9Q4SIltAD3W3+ObrfFnN/pONkaqAAVJkFEVQ1pZTHtwEuZlrojgjTHV+wAnxT4YJwMQQR/D/wEoOUXN03ybcDM6t2t81CjIG+KUREM+vcx67GL1/OpViqq5WcbsPv9YOICcsz5ChgFgnVQQo9PYunzmInvlGyBRwA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(376014)(56012099006)(11063799006)(5023799004)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Lf9ppvenqXB5cHfmTAlg7COAtO3AtKrosz7ZFZnYKeKjU0Ap1OpbLCRVZxQem6HF64+ZnNS0oRTKYUHxDAl12Ydrzl2fvRgO5U17rU7DxAAZv6uDH/LV2dL9Skpzov+i6/Abqn4EEfE6sROpqWUGoNZCCULDM6olFdt/R74a9bmCfZFIMdywZKpd/5uLsZXg4cuq2XpVjolLDdgH3GIF7ULAWF6RkR25pUcdXJ4ckDBkveaBtme+S64m7gh3GF/sPi6aGPqO7wkVLzLZ8rFPJLCdEn/6G9u2pdTf9bdyJxbBCCcT1IxJ89XFduTwtokYdK7rsZX0GxVLFbfKDEJy/cJCSy0bQCzDP9MsUEd3cIKdORoh2cIwn8TtEx8Tj84vJpUD/qxAvp/QJBrkrRkI9jPOSCnjgtsUKWVrSv6dscf68kGdQ0O85/ITmHRvoT3l
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 09:50:29.6284
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d09e89ee-f422-4a6f-636b-08def46950c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4167

The MACB_CAPS_QBV capability flag was originally introduced to
gate TAPRIO/QBV support. However, GEM IP versions that support
QBV also implement multiple TSN clauses.

Replace this with a generic capability flag that can be reused
by other TSN features. Rename MACB_CAPS_QBV to MACB_CAPS_TC to
better reflect its role as a general traffic-class offload capability.

The supported TSN clauses are handled through macb_setup_tc().

Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
---
 drivers/net/ethernet/cadence/macb.h      | 2 +-
 drivers/net/ethernet/cadence/macb_main.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index a11052565436..f24df25923d7 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -768,7 +768,7 @@
 #define MACB_CAPS_MIIONRGMII			BIT(9)
 #define MACB_CAPS_NEED_TSUCLK			BIT(10)
 #define MACB_CAPS_QUEUE_DISABLE			BIT(11)
-#define MACB_CAPS_QBV				BIT(12)
+#define MACB_CAPS_TC				BIT(12)
 #define MACB_CAPS_PCS				BIT(13)
 #define MACB_CAPS_HIGH_SPEED			BIT(14)
 #define MACB_CAPS_CLK_HW_CHG			BIT(15)
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index d394f1f43b68..29c93df1444c 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4846,8 +4846,8 @@ static int macb_init_dflt(struct platform_device *pdev)
 		dev->hw_features |= NETIF_F_HW_CSUM | NETIF_F_RXCSUM;
 	if (bp->caps & MACB_CAPS_SG_DISABLED)
 		dev->hw_features &= ~NETIF_F_SG;
-	/* Enable HW_TC if hardware supports QBV */
-	if (bp->caps & MACB_CAPS_QBV)
+	/* Enable TC offload for TSN-capable hardware */
+	if (bp->caps & MACB_CAPS_TC)
 		dev->hw_features |= NETIF_F_HW_TC;
 
 	dev->features = dev->hw_features;
@@ -5678,7 +5678,7 @@ static const struct macb_config versal_config = {
 	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE | MACB_CAPS_JUMBO |
 		MACB_CAPS_GEM_HAS_PTP | MACB_CAPS_BD_RD_PREFETCH |
 		MACB_CAPS_NEED_TSUCLK | MACB_CAPS_QUEUE_DISABLE |
-		MACB_CAPS_QBV |
+		MACB_CAPS_TC |
 		MACB_CAPS_USRIO_HAS_MII,
 	.dma_burst_length = 16,
 	.init = init_reset_optional,
-- 
2.44.4

