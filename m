Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010008.outbound.protection.outlook.com [52.101.193.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355393C2B92;
	Wed,  7 Oct 2026 05:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791352153; cv=fail; b=gvvmrRyWfLyPYmBv6yg7Wkr9U8XUjwW7tHnIHBW0TydAB1jTOCGUIw9DbtOV71eeB5qFalzXWQyCdDBMgrrbSOMurNxNirgnnDDsRnbbLnwZW+/FThzmbyeG+O8BEPVSvBPgbZk+U6bU8Idsrq2MaUfphaa2ZZ4Jeo1vrfuY8J0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791352153; c=relaxed/simple;
	bh=Fq85IhFfwXtkiyXR5JT4shoORAa1oB7aAmTZ+++SrlY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HuMKyG02yEIEmIZj1Nrp1o6o1wWn957+WWpEsLzcrrEvg1m3KtcVqQLnqxufuhuf2E15iThHIm5XYNil0fKXtq0aGvIT56HK1MjHKBbv+Qrnl4uz5pLLltW6E44xQWEZ5lBSym9pjjBs1xu0u5mBooDAwtAflcO8AD7tszuYZTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cyQZr/mB; arc=fail smtp.client-ip=52.101.193.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cyQZr/mB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wd+xRBcTSUpZT19I/np8CCeI6/ivnBHqSQaL0lWhqCgJyX+pgksBlKR8MECusXwd/o6Pg3G3mBUqVtKv9n6cQjSIwVNIByrrv5Ojnn0hURkWVobYAh2sKprqNNbQwZ7nSRb+C2k3HUKPzTARQHiP44dGarsDo4xHOg7+efpH5bPjBVyCBQ533sQzwntZYhU2HnqhAtnDQuJuVWanFELkbP+fIUL0rPimdq+Btl9TogOgYxFjYmxyDzwH2aePssAilKbuRJE8i+Mm0QuwoIyCJhNfRKfs5wb9MAJN+oPhXSYFues2NiZ8XJwkTPVm9YBta//seQcfLMck7bs0vH9FAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vSzNi4EvVutdnMmQvgPasnsayTAsAXITzEa7HikOenI=;
 b=UsYmSWs1NCa+cdxZT0YGUdYS5p0Mtv6niM1TPeeg+e2iPlWyCeafeBd2k6Y5GxjLawX2u1YvgJluLD/ZtZFsI5zSDLGtLc5g6cuLKoF0HLrQPVIHIWEkqCW//gRdfPvm8BviOzt6nwjdstM/6YzCWo272BcXoTlj/tXhXx2+lzu0EvLvtXX7ICCclugI/eDWgLY5u0tnuRDTh+GhS/j23wEck+Ma+wH1u6xVmpohotCPeB3iPic3VQKQdQcYmt3VXorGBJasl0egk7+blsJiHlKnDRNvmmHqYEk7SmDmulehToLhEXtU2dhJeLMaUdoJwb1FLhuUC0f3xND/jD+8ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vSzNi4EvVutdnMmQvgPasnsayTAsAXITzEa7HikOenI=;
 b=cyQZr/mBEZHC2s33AznneNhHcKEkCQ1mWhTmyZMC5NaFQ5tVap6+gp8ZxQz1tAtQoIVQ6AjrNHJoblbo9124Q1qHgHkYppg3rW6xtaFLtSKXn1s2U+YN7V0f/WvFu5wdEwR7c9qogYrfrTo7tMOFECRG5Me2wlFJhGjvroIrf7o=
Received: from BN9P223CA0012.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::17)
 by MN0PR12MB6248.namprd12.prod.outlook.com (2603:10b6:208:3c0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Wed, 7 Oct
 2026 05:49:04 +0000
Received: from BN1PEPF00004685.namprd03.prod.outlook.com
 (2603:10b6:408:10b:cafe::62) by BN9P223CA0012.outlook.office365.com
 (2603:10b6:408:10b::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Wed, 7
 Oct 2026 05:49:04 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004685.mail.protection.outlook.com (10.167.243.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 05:49:04 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 00:49:03 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 00:49:02 -0500
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 7 Oct 2026 00:48:58 -0500
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Michal Simek
	<michal.simek@amd.com>, Harini Katakam <harini.katakam@xilinx.com>, "Florian
 Fainelli" <f.fainelli@gmail.com>, Kedareswara rao Appana <appanad@xilinx.com>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <vineeth.karumanchi@amd.com>, <git@amd.com>
Subject: [PATCH net v2 2/2] net: phy: xilinx-gmii2rgmii: Restore PHY driver on remove
Date: Wed, 7 Oct 2026 11:18:44 +0530
Message-ID: <20261007054844.529363-3-vineeth.karumanchi@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261007054844.529363-1-vineeth.karumanchi@amd.com>
References: <20261007054844.529363-1-vineeth.karumanchi@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004685:EE_|MN0PR12MB6248:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cc702be-5a26-46c5-647c-08df2436b20f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|82310400026|36860700016|1800799024|921020|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	uSQDJEabm3A2qQzhgC4I6+moeo1r4O3fkSVcBw+ws6MI72DmGOcaeNb0VgL4fy+vG/jZpiqsc1nMukP/BUG/TuwwFo1UznEz0kfsNCuVJs3G6DM6IOsnSQtMv3L7I1qV0Vn3qCLaPYUedXzVhDHd5CxGzoCHMODxqprgQvjHlBYpBt+tmryWTXkW6OrxIPChYRBY68OjbaypycnM2tOwDf5qNW95nszXmp6KtotaeoGSETvcHOox8dQuCqNMqf4hhf2Vp563VG/qfZGoWHip90GrvQWAbygpp3eQIxNz+1i7VdJ4EQiStXNI2FZQ+Ev2kdVWARGsBbvSzVycu1VXSovBKum9i8JIxL5f38c6YSMzJ/uxJozkZG11oUvuvKURGgbq9AnSyWW1Et0/vbE/Ef8dRvZmuaIuKa8Ff7+qBKst4fy8nHFiYNsDQb3cfc4w9kyZUJwHei5ETHg2Tmvc/CgdjSUT2mZqgXwpY3heGv+R927IBFO2OTo5oZ9EiX3L1j/Hv/7oCn/paTy2jHQAzRK2z11DFtAEMfO6bXsPnmuplLUvAfHK5xzK7LZ2lkwrHOA16WNz9NRg0ZxVfZXuM6D6Dm18Vn28Wt/pKprqpU70Aez9gheRDUYstcr2/dS1FzhMI5VHC9NOUrZbWqQxVXRJ2YMkB+ktQ6fqanZ7PyQR1F2hc+93m8GpubpQDVCpTNhGZHngK4942dNSgv1AFg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(82310400026)(36860700016)(1800799024)(921020)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1BAKOIkZ/NIbHNMg7ku5X2UMyaILeA+k+PxS9HrCRhgyKVXZu0SN+Ks/jS/64dXnSCJotU9asxYWOakNDWra1tvhU1Dg6GtsDM2JodBlCySqAEdfxSQ48B7Z35h+zqsFZjOs5y2kXTKGartVqwXfHGttFm+Ly8do6GN/oMDhvFWVF+9K+QUrR3NO17sFNn9018wNTaSVA4NyY5/CGWSvBBuSrJexXjwM1pVGxAqPTSSu5paD9X/QPGvQ4IulQKR1qq02HP0P+fKgDkBO05SI5p59CSlHLwQ2DzY9jA4AyHophzGCQJZi5LHhWwoTlSalo1n0M083d8VFzK7mXgkmmXauVEztGbWqfG6u6j1nmZ+ZucmoEi13CB+KdOGrWVroMWl4n09IrbEP0kWin2ztUfj4nNMpLiH5LW1jrSI+kswbxCOhluUOGN8nu8ixzEPn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 05:49:04.3661
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cc702be-5a26-46c5-647c-08df2436b20f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004685.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6248

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
remove callback. Restore the attached PHY's original driver only if
phydev->drv still points to the converter's copy. Hold phydev->lock to
serialize the restore against PHY callbacks that take that mutex.

Also release the device reference acquired by of_phy_find_device().

Fixes: f411a6160bd4 ("net: phy: Add gmiitorgmii converter support")
Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
---
Changes in v2:
- Restore the original PHY driver only if phydev->drv still points to
  the converter's copy.
- Update the comment and commit message to describe serialization against
  PHY callbacks that hold phydev->lock.

Link to v1: https://lore.kernel.org/netdev/20261001074718.3944521-1-vineeth.karumanchi@amd.com/

 drivers/net/phy/xilinx_gmii2rgmii.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/phy/xilinx_gmii2rgmii.c b/drivers/net/phy/xilinx_gmii2rgmii.c
index 61f71e977a57..9dcdb91cd441 100644
--- a/drivers/net/phy/xilinx_gmii2rgmii.c
+++ b/drivers/net/phy/xilinx_gmii2rgmii.c
@@ -128,10 +128,27 @@ static int xgmiitorgmii_probe(struct mdio_device *mdiodev)
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
+	 * Restore the original driver only if the converter's copy is still
+	 * installed. Serialize against PHY callbacks that hold phydev->lock.
+	 */
+	mutex_lock(&priv->phy_dev->lock);
+	if (priv->phy_dev->drv == &priv->conv_phy_drv)
+		priv->phy_dev->drv = priv->phy_drv;
+	mutex_unlock(&priv->phy_dev->lock);
+
+	put_device(&priv->phy_dev->mdio.dev);
+}
+
 static const struct of_device_id xgmiitorgmii_of_match[] = {
 	{ .compatible = "xlnx,gmii-to-rgmii-1.0" },
 	{},
@@ -140,6 +157,7 @@ MODULE_DEVICE_TABLE(of, xgmiitorgmii_of_match);
 
 static struct mdio_driver xgmiitorgmii_driver = {
 	.probe	= xgmiitorgmii_probe,
+	.remove	= xgmiitorgmii_remove,
 	.mdiodrv.driver = {
 		.name = "xgmiitorgmii",
 		.of_match_table = xgmiitorgmii_of_match,
-- 
2.43.0

