Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012047.outbound.protection.outlook.com [40.93.195.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A310284B37
	for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 00:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786752050; cv=fail; b=tEumrOJ305/WCiaK47F0/NFS6r2iZ+CTwp3fN8YPZih+UyhJ4eaNplB3hd87Cf7tYJkvID5Ku5tfT2KcoA8sH8M3MBXcxKhBNhPtr/lH5bb38vMVJdaLY3XO23CSSsF83iWe3sRpFTNwoJSFRZ/z4hlHC0Q8oS70EZpd06hmHvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786752050; c=relaxed/simple;
	bh=PouPhgSOfhJKJKpF5pSyuV7rVeKc9rV2hgiBvZ3reow=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=a7+UUwncu+h0m0xKdkBxU9NXFiCD8BGOeKozUO5R7EuToC3GlVgotNV7W+txQWC0uRVrnt2GeXEUchaHSig0jjm4zVXzw2LDb9CaidELpm7mo2O4yJTMbxPo+p/L9d4YP6oGZTgdOMNq2HAOCrwCwifFc5MTuzp3eZaA5tLYwIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QIBPtyj5; arc=fail smtp.client-ip=40.93.195.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QIBPtyj5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kVurfP1EXH3ymGIAQAvnw/vhwFOxL1nBxCi4hVo4sXtN7T6aqTZRbCs07mJMXmJqvBKL+nQFTGQd7tFf7GXPEVeSdtwz4YQaN132/t9h6ZWH6kfm3jyHz9QPpfvwXTr25FGCdmczcjlYodu76j3A2uo1kLbdrEZIxXOa9jDpM2U34oywma84Ux4jSIvEvVzX3wpPQv+IUzgBvbmYMCywi11MLrrrd5AOhetLnhKNfvMHhsIBSScCF3TRH4fAw/fWPvyZmcekl5ayyojfTLQ2iVkcW7MSWbgS0NRmR495JiStjhSXGplkqUASis4jdWcsiSwCKEmysug82Y/8+oLLLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L68BGNAa01WF/uSOOYSlBznhsOUhcNhaDcGb1SrCDR0=;
 b=myLa3wyBvXypsekIoJOEkxA8B4wNfdm869hzfHwhtwF2Gm5nA3tc+jfwDo5pDketCs3QrzLkgzw/qQq2Xxp8g+dmJ/WgWMLBKV0Q8XJysOd6qTTGVgT19Cn1GSNZgxExRaViy7v6e0cUBWgaf+YfvTA9MbQ5muJ6KvgKwq0cVb8rPA9HM1gRMSjouxsiXxn4ozFr5wpN1GvTEn4I+KONJQzma6nxKkHJyaxaGABwUFjHZfNtZtfa3eJpGV+A5rVxJaAuiC5gQWKQnMj4WNlHziG6uicvgk5PjqZIRplBmaJurwsI+ZjOHbOp/OCkm+6VX8mNwu/2V6h0ixoNAhIPlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L68BGNAa01WF/uSOOYSlBznhsOUhcNhaDcGb1SrCDR0=;
 b=QIBPtyj5WaU0x6JmgGGTTKZKPyB651b2WHFxZO7W9k2tfIignVqAbe6BiewLkkqFlhuI1jOR9HJpwlFfXlRjrxO3Bv4IIGrswOs1jWOBUIvn4c1e7hE93tCLyboPxaynDyHPx38sRwDoi+hDAnY08UXDSzlFoNLwMrMwdENt4UU=
Received: from BL1PR13CA0110.namprd13.prod.outlook.com (2603:10b6:208:2b9::25)
 by MW6PR12MB9000.namprd12.prod.outlook.com (2603:10b6:303:24b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Sat, 15 Aug
 2026 00:00:45 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:208:2b9:cafe::6) by BL1PR13CA0110.outlook.office365.com
 (2603:10b6:208:2b9::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.6 via Frontend Transport; Sat, 15
 Aug 2026 00:00:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Sat, 15 Aug 2026 00:00:45 +0000
Received: from SCSEJOYNER01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 19:00:43 -0500
From: Eric Joyner <eric.joyner@amd.com>
Date: Fri, 14 Aug 2026 17:00:20 -0700
Subject: [PATCH net 1/3] ionic: check for a NULL port_info in the remaining
 ethtool ops
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260814-ionic-port-info-lifetime-v1-1-f73b1a06c5f6@amd.com>
References: <20260814-ionic-port-info-lifetime-v1-0-f73b1a06c5f6@amd.com>
In-Reply-To: <20260814-ionic-port-info-lifetime-v1-0-f73b1a06c5f6@amd.com>
To: <netdev@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "Nikhil P. Rao" <nikhil.rao@amd.com>, Eric Joyner
	<eric.joyner@amd.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|MW6PR12MB9000:EE_
X-MS-Office365-Filtering-Correlation-Id: 976ecf64-f113-4bc8-dd41-08defa60413e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	iSaz57vqTy5Y7aBMUJp/S1W0xF3kDSnnn8sYKAC3XVy6La5HU0x4/+9bFXqLuhXOYWxZsLve2iODwX12HNqkN3D9i3NO6ns3i5y0L004g7G+FksMruo9f10FP0bM7wJW1pmP1Z8huiafP1MZKmwub2wF5KNfh66aQa87vlAdELOQLGSLVFUQqoOJ43cnaU4c+E0GPM60tyIGxCJhmJTanOjlxb2+ZDtGTr5wKiYW2FBPBdVoXc8XkJ876r/xYCM1lJnD6iUZqAzcmO6TwNXC7+r9hGwAc384d6SpKED+bsWdSz7N+9Roil8jLbCYudzIPdYZG4ERV/zX2E8Rq5nHHQsWwjwlEYoNUHbBTRtLKc6Qez5ZK5dk/+4l1nj5copAJxrSDxje/dZXXwqImKZ0gdtUkNLAF5eSg5MtLu5+PJSU3styCmkv3SwxG3cA1plHTFl3eREupH8VbF3dySPM0dQgcrr4zwXERlUTyo9Ds94IHcIWd+qxTr5kaSN95yUaT0aM83EYEnJ8NuOb/dkqdAJgbI/W9PNavELE+dG0LXPzOfwki88VQ0cVp6nP1cs8PGB40d1VQyGpr53A8/ZYsQ2DoYnT514w8zLGX7AyjbZ15jueOb2CtorsS9mtOu90RCUm6m9Swbt6buoR0Qc1fevYgG+6yAjyIaaBl91Ir5A=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jSQBHU73OyKJpsghEYjb/9ihhqYvTQvZQC/MWU2uz3B1rreHYOcmWGk/It2kKatlIskhvvyqExsqHg2rzC6oaCQkCohSJ0bMgXu98vSDJ869FU+lPIfCzkggfKzm3RLZ7/fjWmnaJqAE/B0mUtzP5O3KboFIg6MW7kQPl8mEL0Mne8fRbD62fmBOMtrAKvwDPsmv2ze6lM+91YYaXzF9XpOHhzvXAdZrgKzTjGT8jLZrIJM7mee0bt9pW7ZnMgyslb05rNeKA41nNOCXfx+iDRkAO3qbqSNql9SYuMQXhouwfjmjwdaewkiCiivO/gyUZ0rOXIWd86XDkHgIDbjCKIVDCPKjTUJrwmhD8y2q4QCZKO3fXMeieEg2TUlF/Vuuo3Dya5XsQfhoYwjs+QR4p/a42z/JUNzwXk5fjpMvBdZ67KDJZaM2JQb4BE57E8iE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2026 00:00:45.1249
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 976ecf64-f113-4bc8-dd41-08defa60413e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9000

port_info is a coherent DMA buffer that the firmware keeps up to date.
ionic_port_init() frees it and sets idev->port_info to NULL when the
device command to initialize the port fails, and that failure path can
run while the netdev is still registered:

  ionic_lif_deferred_work()
   -> ionic_lif_handle_fw_up()
       -> ionic_port_init()

  ionic_reset_done()
   -> ionic_setup_one()
       -> ionic_port_init()

ionic_get_link_ext_stats() and ionic_get_link_ksettings() already test
the pointer before using it, but the rest of the ethtool ops dereference
it blindly, so an unprivileged "ethtool --show-fec eth0" can oops after
a failed firmware recovery.

Add the same check to the ops that were missing it.

Fixes: c672412f6172 ("ionic: remove lifs on fw reset")
Assisted-by: Claude:claude-opus-5
Signed-off-by: Eric Joyner <eric.joyner@amd.com>
---
 .../net/ethernet/pensando/ionic/ionic_ethtool.c    | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
index c4ab4b5caa0a..0830422fe7ba 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
@@ -347,6 +347,11 @@ static int ionic_set_link_ksettings(struct net_device *netdev,
 	if (test_bit(IONIC_LIF_F_FW_RESET, lif->state))
 		return -EBUSY;
 
+	if (!idev->port_info) {
+		netdev_err(netdev, "port_info not initialized\n");
+		return -EOPNOTSUPP;
+	}
+
 	/* set autoneg */
 	if (ks->base.autoneg != idev->port_info->config.an_enable) {
 		mutex_lock(&ionic->dev_cmd_lock);
@@ -378,6 +383,11 @@ static void ionic_get_pauseparam(struct net_device *netdev,
 
 	pause->autoneg = 0;
 
+	if (!lif->ionic->idev.port_info) {
+		netdev_err_once(netdev, "port_info not initialized\n");
+		return;
+	}
+
 	pause_type = lif->ionic->idev.port_info->config.pause_type;
 	if (pause_type) {
 		pause->rx_pause = (pause_type & IONIC_PAUSE_F_RX) ? 1 : 0;
@@ -396,6 +406,11 @@ static int ionic_set_pauseparam(struct net_device *netdev,
 	if (test_bit(IONIC_LIF_F_FW_RESET, lif->state))
 		return -EBUSY;
 
+	if (!lif->ionic->idev.port_info) {
+		netdev_err(netdev, "port_info not initialized\n");
+		return -EOPNOTSUPP;
+	}
+
 	if (pause->autoneg)
 		return -EOPNOTSUPP;
 
@@ -424,6 +439,11 @@ static int ionic_get_fecparam(struct net_device *netdev,
 {
 	struct ionic_lif *lif = netdev_priv(netdev);
 
+	if (!lif->ionic->idev.port_info) {
+		netdev_err(netdev, "port_info not initialized\n");
+		return -EOPNOTSUPP;
+	}
+
 	switch (lif->ionic->idev.port_info->config.fec_type) {
 	case IONIC_PORT_FEC_TYPE_NONE:
 		fec->active_fec = ETHTOOL_FEC_OFF;
@@ -451,6 +471,11 @@ static int ionic_set_fecparam(struct net_device *netdev,
 	if (test_bit(IONIC_LIF_F_FW_RESET, lif->state))
 		return -EBUSY;
 
+	if (!lif->ionic->idev.port_info) {
+		netdev_err(netdev, "port_info not initialized\n");
+		return -EOPNOTSUPP;
+	}
+
 	if (lif->ionic->idev.port_info->config.an_enable) {
 		netdev_err(netdev, "FEC request not allowed while autoneg is enabled\n");
 		return -EINVAL;
@@ -1004,6 +1029,11 @@ static int ionic_get_module_eeprom_by_page(struct net_device *netdev,
 		return -EINVAL;
 	}
 
+	if (!idev->port_info) {
+		NL_SET_ERR_MSG_MOD(extack, "port_info not initialized");
+		return -EOPNOTSUPP;
+	}
+
 	switch (page_data->page) {
 	case 0:
 		src = &idev->port_info->status.xcvr.sprom[page_data->offset];

-- 
2.43.0

