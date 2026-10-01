Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012020.outbound.protection.outlook.com [52.101.43.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FB038E8C7;
	Thu,  1 Oct 2026 07:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790840886; cv=fail; b=Yh1AB5EfcE8LpRLTe0AmG4m3zarfI/o66L+vQeezQqehfzKhF1oHNtaXIKAOMKJwmnbaUJSCTNwrU90rv4tS+q4uUhsQYTJ8No7KTgamcczC415t0UEeeHCcLB4t8V/jbqsRZ3cBgtmgdjiejmN2kFrBtPD1zE5bh3xZW1Td1lk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790840886; c=relaxed/simple;
	bh=9IbKSmPWG5cFGXUhjzex/Z3plfIs4wUdza3iw31uDxQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RJkazQ7K2fURkgomvzkpFGgYfSZOOcVtDTSO+gxQrYA3VOyqfIvoM111JrVfQm47/kesg28iVXK/ZTbiISDUPNiSr5FvBEsd2VHfnpS1/9P3ncS8NMwDhvfWlUAKOJzSWS/myAMgJbNwb3+DIDoBsspdkKqGl712l3KyVtRGh90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WAz0IUFV; arc=fail smtp.client-ip=52.101.43.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WAz0IUFV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j5M8hhd8dM3yr/oyd/0MyP5PCQlpQUaDgcEX3uj+QL9kkw16ewLjnNsGKaZpBZTBpdQynoEeM94yaNP/ERPyHxeKKEh5mAT9j8j/bSonhACpmnM0jhbgbX1xsD2fhfLenm0e+moKQVy0tTNnN5z43+5UZ22ljwX7QnBBXXZjWxhPBq4dVsbVebH3yzfJ0JOMdPiI2SSCATATXJJ+Zohx6otOmujtrqueTLdwWgxFFSFgMyeSzBJYb0JwWyW0TNriwce+MjDgR/ChYxy9USdKfPR/S3Cf1cPfSBuT2FKfVzEDIjdARD6j7GL4bL9YGLmsqbtuWRv/0i5XdH0lpMIFKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bP1XaIwz2I8YHuhxWMX1moPOT1A5fRdUk6EJQL1UhjE=;
 b=vOHMqUcIVaTTMLfs1+6neU6/JpwPTJG3NeZqxVVoyPJADDVSshwxHkA2UFRiEbNWkfKdTzLuvsBYeV1jSMurJ8hqg8IiTWgp8M2Y7922uOByAWoG6kqeOMjZxbzVcpVaJJlbKN9K/3CdJK+DkUnC4oeHKBKgKJGOFTWe1AJy8UmmLOTnZu4ULU82vqXQhc6CknTCMmVHuLW/Vu5VrCm/qB477/ugje1zYleA3s8pNGCd6DbVHNQXmoUfe1K3QbMHoQcFmOQAJdAXuwHB71GQRuEZtaFgSur0JnIrGpmlUFOZeE1mRBVgjkIp6csR5+wlPswzadj3EYHKOMP1tLX2pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bP1XaIwz2I8YHuhxWMX1moPOT1A5fRdUk6EJQL1UhjE=;
 b=WAz0IUFV+nCOvsHwooUU7VzUStwmmu25UZd439zMrbOtUy9/wKMbLO9kkwL6E/agyXSs4MfUAZ2yRLfXKUusuTAnRfbFRWl4/ifRoG1MPxjOFjDoEZb9ALFoBzgXdZU+41fUKHbBvy0v5/Z/iF9nEeh/lvRvhm8ORlVcH1VnAwA=
Received: from BN9PR03CA0602.namprd03.prod.outlook.com (2603:10b6:408:106::7)
 by DS0PR12MB8318.namprd12.prod.outlook.com (2603:10b6:8:f6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Thu, 1 Oct
 2026 07:48:01 +0000
Received: from BN2PEPF0000A994.namprd04.prod.outlook.com
 (2603:10b6:408:106:cafe::85) by BN9PR03CA0602.outlook.office365.com
 (2603:10b6:408:106::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Thu, 1
 Oct 2026 07:48:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000A994.mail.protection.outlook.com (10.167.248.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 07:47:59 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 02:47:59 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 02:47:58 -0500
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Thu, 1 Oct 2026 02:47:54 -0500
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <git@amd.com>, <netdev@vger.kernel.org>
CC: <vineeth.karumanchi@amd.com>, Andrew Lunn <andrew@lunn.ch>, "Heiner
 Kallweit" <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Michal
 Simek" <michal.simek@amd.com>, Florian Fainelli <f.fainelli@gmail.com>,
	Harini Katakam <harini.katakam@amd.com>, Kedareswara rao Appana
	<appanad@amd.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net 2/2] net: phy: xilinx-gmii2rgmii: Restore PHY driver on remove
Date: Thu, 1 Oct 2026 13:17:18 +0530
Message-ID: <20261001074718.3944521-3-vineeth.karumanchi@amd.com>
X-Mailer: git-send-email 2.44.4
In-Reply-To: <20261001074718.3944521-1-vineeth.karumanchi@amd.com>
References: <20261001074718.3944521-1-vineeth.karumanchi@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A994:EE_|DS0PR12MB8318:EE_
X-MS-Office365-Filtering-Correlation-Id: eab4e42c-86db-4482-870e-08df1f9050bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700016|23010399003|82310400026|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Vx8gunTLT+HLRwA91QXglKcM44nopTnjqGUMBcOo/dggnvaJIS+etXF6jXh8Pu/Seke4fllkRW6tUTx6As2vrCFthkO41fMRHtGqBb7f1aLGZjXgjfhKcvqmudPCSuu/PzKSNQanXHWc3LgW8VBWlRo3A3uz9pmvxblp5W3XGwKk0HiXrNpy4WgZdegHICVDlo/c8yAhRKlw26SZp4jMuDq0q77mIH1s5ovnN3ijG0C4fQ9su012VGSf19cB0s5lgx5be+WyFex/lNTtiAW4pQeIwqc6HUnUFlMP2mDi3C3S9kR6TXm/frYQm8mJQzSUQmUZUHWGdUfKGdxGEvNX4c+IzsKpttILOE/KYezZKKmeO/zlox0uW3vQw8k8TBkjSAuG45sqI/I0Ut2QUki4ZEfsg9Z3Sb8tuQWUXupYOV+auS0ZWCIGUthj6rWnZvw2+0c8YOkq1DNLlseLrBHTNeM82Agr171+wO/4ZMwH/JIcr4EHAMBP3hXJp2OjrrBmdaI7p+oydtSs+RsAU5gIN6xUfMuXnuvXYvmWRWhCT62WWReK37Bo1PcZcRWaie1Wa8CTWr6dK4xD+w7LPLPJSusAorvJOe78xj/sVUVunDmOJXKPM2oLmyR5sphXE+yD03h5LG6Vv9ZSYqLwXiFIktC9f9k+mD5YaYWj6+u+AJsElybxS2OFZrU04spZjzL+a8mwuaxiVZinIG6q2BcvyQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700016)(23010399003)(82310400026)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	uSHem3F/KLx/ncRPf0jka/r5z3Aj5SpxijV2aem1xIw+9Y6IF1XfmvXlX27tNmjH57poEzYOeLeg2DihjJnFdQaHaupKB9wYBGMsoOgyg0GnZp7X+qsCB1oV4Ox6n0pT30EU8BaiRIBex3g1+0rh70z8LtR5Jlt9z5sF02XnuhDXE5d8GbqvdB3lbDFa0YnYRWhO5u7uY1+O+NnAbJr5xOC5Egq3mg+Mb4e01y0EgtI07oQSUWXGrtt5SBUD+haUnIHkLMVgr3y1RObNBuKTIR5Obgu0dAC1lUSEORpxByuw5bIMnLkw5HtQDksQBZzoorixYnw8UuZLW/hJqxAQTcw9Yz+8PWC2xT13p+f8Ib4EOqA71OdthP+By6p1f28FiYbwKYds0c73RUpMHhU/BMhpdnY/gVnJPg59HTy0ZiKTavYZ9y78nObrGkVDJcy4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 07:47:59.9947
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eab4e42c-86db-4482-870e-08df1f9050bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A994.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8318

The GMII-to-RGMII converter replaces phydev->drv with a modified copy
of the attached PHY driver. This copied driver is embedded in the
converter's private data and is released when the converter is
removed.

Without a remove callback, phydev->drv continues to point to the freed
copy after the converter is unbound. A subsequent PHY operation can
dereference this stale pointer and result in a use-after-free.

With Generic KASAN enabled, unbinding only the converter while the
external PHY remains active produces the following report (abridged):

  BUG: KASAN: slab-use-after-free in phy_check_link_status+0x2d8/0x338
  Read of size 8 at addr ffff000006c359b0 by task kworker/2:0/27
  Workqueue: events_power_efficient phy_state_machine
  Call trace:
   phy_check_link_status+0x2d8/0x338
   _phy_state_machine+0xdc/0xa4c
   phy_state_machine+0x2c/0x70
   process_one_work+0x554/0xe44
   worker_thread+0x6d0/0x1180
   kthread+0x2e8/0x5d4
   ret_from_fork+0x10/0x20

  Allocated by task 55:
   ...
   devm_kmalloc+0xac/0x2ac
   xgmiitorgmii_probe+0xa0/0x37c
   mdio_probe+0x68/0xb4
   ...

  Freed by task 642:
   ...
   kfree+0x14c/0x38c
   release_nodes+0xb4/0x1e0
   devres_release_all+0x140/0x1f4
   device_unbind_cleanup+0x20/0x190
   device_release_driver_internal+0x344/0x460
   device_driver_detach+0x3c/0x54
   unbind_store+0xe0/0xf8
   ...

Store the converter private data in its own MDIO device and add a
remove callback. Restore the attached PHY's original driver while
holding phydev->lock so that the update cannot race with an active PHY
callback.

Also release the device reference acquired by of_phy_find_device().

Fixes: f411a6160bd4 ("net: phy: Add gmiitorgmii converter support")
Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
---
 drivers/net/phy/xilinx_gmii2rgmii.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/net/phy/xilinx_gmii2rgmii.c b/drivers/net/phy/xilinx_gmii2rgmii.c
index 61f71e977a57..b9aa5515577b 100644
--- a/drivers/net/phy/xilinx_gmii2rgmii.c
+++ b/drivers/net/phy/xilinx_gmii2rgmii.c
@@ -128,10 +128,29 @@ static int xgmiitorgmii_probe(struct mdio_device *mdiodev)
 	priv->conv_phy_drv.read_status = xgmiitorgmii_read_status;
 	priv->conv_phy_drv.set_loopback = xgmiitorgmii_set_loopback;
 	priv->phy_dev->drv = &priv->conv_phy_drv;
+	mdiodev_set_drvdata(mdiodev, priv);
 
 	return 0;
 }
 
+static void xgmiitorgmii_remove(struct mdio_device *mdiodev)
+{
+	struct gmii2rgmii *priv = mdiodev_get_drvdata(mdiodev);
+
+	/*
+	 * The attached PHY is a separate, still-bound device whose state
+	 * machine keeps running and dispatches ->read_status / ->set_loopback
+	 * under phydev->lock. Restore its original driver under that lock so
+	 * the swap cannot race an in-flight dispatch; the restored driver is
+	 * the PHY's own static phy_driver, not the devres-freed conv_phy_drv.
+	 */
+	mutex_lock(&priv->phy_dev->lock);
+	priv->phy_dev->drv = priv->phy_drv;
+	mutex_unlock(&priv->phy_dev->lock);
+
+	put_device(&priv->phy_dev->mdio.dev);
+}
+
 static const struct of_device_id xgmiitorgmii_of_match[] = {
 	{ .compatible = "xlnx,gmii-to-rgmii-1.0" },
 	{},
@@ -140,6 +159,7 @@ MODULE_DEVICE_TABLE(of, xgmiitorgmii_of_match);
 
 static struct mdio_driver xgmiitorgmii_driver = {
 	.probe	= xgmiitorgmii_probe,
+	.remove	= xgmiitorgmii_remove,
 	.mdiodrv.driver = {
 		.name = "xgmiitorgmii",
 		.of_match_table = xgmiitorgmii_of_match,
-- 
2.43.0

