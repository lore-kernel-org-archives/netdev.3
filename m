Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012039.outbound.protection.outlook.com [52.101.53.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BFD3BD653;
	Wed,  7 Oct 2026 05:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791352150; cv=fail; b=ZgaDXmesg0krtMMmtX+h3uu7xeZJn2yHx8afgaOHyS056DObyaqqAsEAhRY5WoU7wu5IfJ9DlesYjnIJD11Vi8ZN1bMBu7IvqgyRC9F9VGtwD4kWLgQU+KDG6C4Z2/yMS8rCEZAvr4PpLZ6KSQOExbFTbOPvSsap4b2J9me3eGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791352150; c=relaxed/simple;
	bh=9fNQlnTHuUYZ9gb3PUiIhdyfJpzdroaxQvX+njUw5SQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ay5qlaIX4SzceqI9CO6eA8Spas3Pbd+0ZGS6c9HfgFzz/AWnepTq4nnICDUZEM2ZvaeW6woSUDjrUrmSOP12K2VYMgQcylfNxBBsA0xc/F5NcMNZ5VD7EzkHt24i7zGzRvVB4JOVjVuKRL7N2bRzzQ1oAXzkFspumJtXr627L30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NS8TpbFb; arc=fail smtp.client-ip=52.101.53.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NS8TpbFb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tKRFf4Sot5Hab5BYs82mhUjRf+U1e1uFwNkQYm1HCBK/Yu8bj/+LE5WcgYXfE8fu7BM0eqJyEXAoTNm6bV8htFuPB4lBVYBWAvptGRnTyiAAXiKdOBd2rMi3ye9z5/58w36HB272XOQNJ5FrhcWuv0w1uLuJP91CVu73oIFku/iFES4J8OTyOhRAmG5JaVmsZBu1dsFrrVgsIH70hz1TJsfa5FL4Ru7GzwVZSjg/1fBGwd3dhB5Jkl8JXWosCwYj3D11gyxdEo2sJyZibwqAPXuWxKzVM3wANLl7CEogNJJDqGfZIbPUIhAS4jmjMh3U6+/bUUVgkEdQBmVH5PQm7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KKQlVwwiWI0tGfKruqdXrGvRyIZNfww1lnbEpkXN5DA=;
 b=kEaWKzpddJRELmewSeKTSwOiZ9RE29jwgk86WLupFHuM69/bgCi3RLcmDvouUZ8WUPT5GUS05qzJFdO2ojWGjNDKEiG+ywBdVjjML/Ouosmy/k/yeVk94GGyqO6PBl4P2T4cvvkgReHdlVrrPQyFTX4GGjJr/C3aIz2HPMT14xxjIBg3FVJFH96gBmdPLla+DcHiSIzSEf3my5BEi419lpAo8hjQAOKAMYPXW5JkaFt6S2b8ecGV2orsOFYbSPjW3oO2DCfuWX0TTwftCX0OJN1adEJ/mOYHaxFTScfqAjblbauze25LE1J4Laj+POXzwuVtxrQC63WwsU0lzraoTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKQlVwwiWI0tGfKruqdXrGvRyIZNfww1lnbEpkXN5DA=;
 b=NS8TpbFbAvOpKVax5MRfLYt46X0Ne2xMAk9cMmdx+1vssdwrOzdTRdESrdRYsC5sY/rv1nSX3RstmNs4RIYyb9ce4z4+9fArk8NAg+uTOIUrZ8s+wF3kpEI7TCQyF1Cyie8GCiZM1mVz2Z4Znfy2pVMzGmn0YDPKpyd6AJvXY8I=
Received: from BN9P223CA0010.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::15)
 by SJ0PR12MB6830.namprd12.prod.outlook.com (2603:10b6:a03:47c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Wed, 7 Oct
 2026 05:49:01 +0000
Received: from BN1PEPF00004685.namprd03.prod.outlook.com
 (2603:10b6:408:10b:cafe::70) by BN9P223CA0010.outlook.office365.com
 (2603:10b6:408:10b::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 7
 Oct 2026 05:49:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004685.mail.protection.outlook.com (10.167.243.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 05:48:59 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 00:48:58 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 00:48:57 -0500
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 7 Oct 2026 00:48:53 -0500
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Michal Simek
	<michal.simek@amd.com>, Harini Katakam <harini.katakam@xilinx.com>, "Florian
 Fainelli" <f.fainelli@gmail.com>, Kedareswara rao Appana <appanad@xilinx.com>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <vineeth.karumanchi@amd.com>, <git@amd.com>
Subject: [PATCH net v2 1/2] net: phy: xilinx-gmii2rgmii: Avoid overwriting PHY drvdata
Date: Wed, 7 Oct 2026 11:18:43 +0530
Message-ID: <20261007054844.529363-2-vineeth.karumanchi@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004685:EE_|SJ0PR12MB6830:EE_
X-MS-Office365-Filtering-Correlation-Id: e9656044-02e9-405d-e71a-08df2436af47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|23010399003|7416014|1800799024|36860700016|22082099003|18002099003|10067099003|921020|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	TmSAdQIBkNMy6UOR4BbFVd58P4Yvp/dQh0BAX0F+Cc6bBUfBDGOdr8q8FH3p1tcH6DPyBcEZ3YfObVATT6mey932y1ltyYdMUrwy63T1FOrDNchEwETR4gGHjwrcds/o4TFUQGyAg9tz0uK+5AuzR6n0iL2LGxxQq43ORcTRjM6xXHfz8YlDzSQCJ60p2oCl7TiKOGOipF52Y9gezu+GcsYn8q+WyYPNeTegq/uRVFJEBLZbflpiYKNrK1ClhOfcTotgLAtG6/Mt15JHpmV2+Id4nj79O+X7WlY05rh/+n9Up95So44qHQpP+HXT24OUCW7kzZtVd586WVCEG8b8CsN9cX63naqJeGkbGtr9mB7cL7guSreewwhrUuU29iFTyVGtYOdeYi0WSqzYjfshRnFRlZ1Umix30mTQVtM88FeX7exyEvPhEq+izerPPMHmEDUa/HvDpKCLzCIb3RUpYI4surIKzp6bm9Pgkv4sXYu0nYy0qo+6swwKhnMyuIvYWSAqSwu+Ne7QbutHpfjrHZ0hYBCj7Fqf+QKwZTNOj/XEyt4A2vZz3Guidf1t3BeDc10NcGVzMN42x/YulqGW3QJrCREy0dXg3k99QWJ6HeMRlY/LWvJMz4Xb1h0ZX1rZUpbzub67SFEV9Qi5MdCe2FeMaeNVO39+bJa3Q+/jhDy46ExbQLUAixIMEId6X0co5WwpLBF/Tr+OqXGezmg6T0n/B6JjlfXZTBqt0hYQDDszQZgEA+q+U55tgoOluiUF
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(23010399003)(7416014)(1800799024)(36860700016)(22082099003)(18002099003)(10067099003)(921020)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BFhRhxxS8U5RLi0nwB53xeC17p2ySyaNZZOrBSa9UnN+cCX6yGtVYrE4d5s6c/hgn0scwWmRyc36ycyYzpUeWIulElxy2Qc6BW6ocbJkbV4JNL6FfMOOqJflXYVe0USjscKvWSz3U9KiCv3+eUarGFJ4vylEQXIkIcuTkQq1y7D9IFZY99nDBZkprESCcQtIFZHtKRM2pyzX9xJ5oNdvQ7Rcls7XJemViONHwr9SaM4ye7MjrLUsHdS9Dx/91Z0fKF655gCbiPPuDmua4hHqZUYAvnQqY09r0TIcOMdJ+bVkrQCC5IYFbWpPKTs1qLeI5mZ6+qsHmF8QWGtFIMHpM9GDyze5W+cBvg4xdtcsq2KvYHA+VXo2/UZlbSBMYClMw0nSwFNMjnLo92y/4QrYOR27m58wnFswaICYSGAfR5AhDoJZArX2YJb5JbJc414T
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 05:48:59.7039
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9656044-02e9-405d-e71a-08df2436af47
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004685.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6830

The GMII-to-RGMII converter wraps the attached PHY driver by copying
its phy_driver structure and replacing the read_status and set_loopback
callbacks.

To access the converter private data from these callbacks, the driver
currently stores it in the attached PHY's MDIO driver-data field. This
field belongs to the underlying PHY driver and may already contain its
private data. Overwriting it can therefore cause the PHY driver to
retrieve an unexpected pointer and behave incorrectly.

The converter-specific phy_driver is embedded in struct gmii2rgmii and
installed as phydev->drv. Use container_of_const() to retrieve the
enclosing gmii2rgmii structure from phydev->drv instead of using the
PHY's driver-data field.

Update xgmiitorgmii_configure() to accept a const pointer accordingly.

Fixes: 168f7a161608 ("net: phy: gmii2rgmii: Dont use priv field in phy device")
Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
---
 drivers/net/phy/xilinx_gmii2rgmii.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/xilinx_gmii2rgmii.c b/drivers/net/phy/xilinx_gmii2rgmii.c
index 2024d8ef36d9..61f71e977a57 100644
--- a/drivers/net/phy/xilinx_gmii2rgmii.c
+++ b/drivers/net/phy/xilinx_gmii2rgmii.c
@@ -28,7 +28,7 @@ struct gmii2rgmii {
 	struct mdio_device *mdio;
 };
 
-static void xgmiitorgmii_configure(struct gmii2rgmii *priv, int speed)
+static void xgmiitorgmii_configure(const struct gmii2rgmii *priv, int speed)
 {
 	struct mii_bus *bus = priv->mdio->bus;
 	int addr = priv->mdio->addr;
@@ -49,7 +49,9 @@ static void xgmiitorgmii_configure(struct gmii2rgmii *priv, int speed)
 
 static int xgmiitorgmii_read_status(struct phy_device *phydev)
 {
-	struct gmii2rgmii *priv = mdiodev_get_drvdata(&phydev->mdio);
+	const struct gmii2rgmii *priv = container_of_const(phydev->drv,
+							   struct gmii2rgmii,
+							   conv_phy_drv);
 	int err;
 
 	if (priv->phy_drv->read_status)
@@ -67,7 +69,9 @@ static int xgmiitorgmii_read_status(struct phy_device *phydev)
 static int xgmiitorgmii_set_loopback(struct phy_device *phydev, bool enable,
 				     int speed)
 {
-	struct gmii2rgmii *priv = mdiodev_get_drvdata(&phydev->mdio);
+	const struct gmii2rgmii *priv = container_of_const(phydev->drv,
+							   struct gmii2rgmii,
+							   conv_phy_drv);
 	int err;
 
 	if (priv->phy_drv->set_loopback)
@@ -123,7 +127,6 @@ static int xgmiitorgmii_probe(struct mdio_device *mdiodev)
 	       sizeof(struct phy_driver));
 	priv->conv_phy_drv.read_status = xgmiitorgmii_read_status;
 	priv->conv_phy_drv.set_loopback = xgmiitorgmii_set_loopback;
-	mdiodev_set_drvdata(&priv->phy_dev->mdio, priv);
 	priv->phy_dev->drv = &priv->conv_phy_drv;
 
 	return 0;
-- 
2.43.0

