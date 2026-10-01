Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013003.outbound.protection.outlook.com [40.107.201.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE963FC5BD;
	Thu,  1 Oct 2026 07:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790840879; cv=fail; b=Hjkve77egXlSCGc2cgo1/EeeP8Es9EG61ZRcvvk0WKfPBJdG7e9tiPX8gaCE//Zfqitoqq7IhMy8fhWZFcu4xWvNrKZhj0FyVbps7ScKbQD95ht4LZ6djIlkEvcOMyYrHHqkhL881AHJrfkcSCyOvB+enbxXB2Yflpur6huDzB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790840879; c=relaxed/simple;
	bh=9fNQlnTHuUYZ9gb3PUiIhdyfJpzdroaxQvX+njUw5SQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rXnrI6vgu80Dq3RnN1ULB1fovMYLdHxdIKyviErRCuFDBhoXIW5Hr85jkEppzvf7Su0+CKMVNj+mehrXbDUEowHJtw1qBrMMOjfd7/NFkv/RE7ucL67qJUM4dlmbRkwziATGlMke8KUWPUJVXLutyr5geR7ZcE/UvMmsTkIEInI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Qp7zOHgM; arc=fail smtp.client-ip=40.107.201.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Qp7zOHgM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=prQqI9VvyHSzSlsVEfvAK+96ekIgzvS63kju0PlvfwX4RcSNWJ5gwacacr6Efq0A8rNoCO7g9Mvztj8HnL+TAbfhkPhqJ8RA/fwVgBWQ3EMLBCI1gwlyvUIC5s0qpNGZM7baPYF4Cq7D/QPIWefIP7G5TJSsawNDpgmKKvlHJUaw/q1mC49gVFY5MlXti5trPhh8uW3TZ+cM7ZVRhj4vnc6vmdTBXZTRGK4QelxwaWv2+PZSz48iJ4wyPPwQrMJxwkZPI78ASI3sbuja6qnHyJ9hUC26tYHdjYoYOESDA0WM2wG2kBCCovIg3/i/hZfboKOW9C/zvQ9Y6C6xxpqStA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KKQlVwwiWI0tGfKruqdXrGvRyIZNfww1lnbEpkXN5DA=;
 b=HoOTwrNCdJpspEJisOxOpnDqYeyR5VnnTn4hc+HY/d/9gjw12xFUTdN2gPz2fxDKN1lAxl7B8bUsBZWH/csWTXaiZvnTVTSy8uQ9/wyVXSvWjuh4IUChH6EjN7f6Pmo1WGyfZU8IkoUYDSSWrXsAcWgK6/+dzfO6R84CIKQYChdh/TH7U+c58yXdr8ZuTrDI3d/UBDjsreE7AsnVuoxvlgVPaNaCNd3Btj5zMN2jOE2ilAqKlydWfVNzCHjS2sfdV2ww5Mo0bXECLQJ+HkcTrPFjXucHBUVOhjicvIJoU5AYH/VvXKvy9MJJ9xbp6uvDfbvbzK83egs04gSw1jxbSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKQlVwwiWI0tGfKruqdXrGvRyIZNfww1lnbEpkXN5DA=;
 b=Qp7zOHgMkd7lmX1pTU7X26Rm14nIy7nFFuCTbSedZN7vEtghGuMn/alAOTNy24CppeZseHt0yZpaWR1oDwO8Wa4r4NunxPzUYwkWTqlBdn6GvXaKZxwEGEix1Eo+fBbM5QGOe4ls2sPTexfXavT8GvhZOE1HnmAh/RfhPT1m1jc=
Received: from BN1PR12CA0021.namprd12.prod.outlook.com (2603:10b6:408:e1::26)
 by CH3PR12MB9148.namprd12.prod.outlook.com (2603:10b6:610:19d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Thu, 1 Oct
 2026 07:47:53 +0000
Received: from BN2PEPF0000A992.namprd04.prod.outlook.com
 (2603:10b6:408:e1:cafe::2f) by BN1PR12CA0021.outlook.office365.com
 (2603:10b6:408:e1::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Thu, 1
 Oct 2026 07:47:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000A992.mail.protection.outlook.com (10.167.248.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 07:47:53 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 02:47:52 -0500
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Thu, 1 Oct 2026 02:47:47 -0500
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <git@amd.com>, <netdev@vger.kernel.org>
CC: <vineeth.karumanchi@amd.com>, Andrew Lunn <andrew@lunn.ch>, "Heiner
 Kallweit" <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
	"Jakub Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Michal
 Simek <michal.simek@amd.com>, Florian Fainelli <f.fainelli@gmail.com>,
	"Harini Katakam" <harini.katakam@amd.com>, Kedareswara rao Appana
	<appanad@amd.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net 1/2] net: phy: xilinx-gmii2rgmii: Avoid overwriting PHY drvdata
Date: Thu, 1 Oct 2026 13:17:17 +0530
Message-ID: <20261001074718.3944521-2-vineeth.karumanchi@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A992:EE_|CH3PR12MB9148:EE_
X-MS-Office365-Filtering-Correlation-Id: 551a56b1-b8e0-4f08-4b3e-08df1f904cb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|23010399003|36860700016|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	rPvG8at/0La1q6WkihINtUcwMFDEVWDQvhvtarq0gpCz9aLMw0ztkBy8tHeT1I6L/r3gw5uuSXT1lHCBWurgfZ813OLJoQsXShZKZClPyciJNmdvYZ1PH+vI1A0xcXL9WPQUKYhPsBi089P3slit2zMfH+HGtC1EUOpYUqfUyp2oIHUW5D/yeinRVth7LBOc0RX6VJqDLHkVEXVkUhcnyIJf1dVa9+Bih/LB86I7ZsRnfIAepEzyF+2oaKEZOQ89CTqJenHbdCKjV+/2t1pI7L/NxV3fQ31vhSmMSHd/nuLqynL1uqvYPU8HqExMCzrEn9a0V70wHnaqcROzM+JtQW9J3q1tQ8sKI8688vtiaMXZ4Sx9jbY9Ms/BorY1rWwMsGG0+j6yNmRjRkJZy7lfzasH2TiusxHUqQo3Q7XYkUUe+7A6daLJ4d92bImD8pmfHuu3DbBzPuqIshK7CCELZCoMyh91VVKkrADoWxPnD3hnGHmKuPlbdOP9gNMN3TdouGwecMs93O7enilMUCDCasTnlV+xaFiBYL6ULVqVzY/sZUYFfFOy02dbaXBnX5R0h0NFP598bUGdl9CuOessPZ8i0ekq/q3Demdwst6P9x0K3v4Eny3j+2Jkep3kPFvJu8OvhVjbMxck49zAWG6QWnvqMIuiaYAyXrDnAOmi+WBme623SuWlEFrJB44xJ9QR2maoWUzLjJRBgAGw55QB6w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(23010399003)(36860700016)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TRzebEBr7BIpdm18t01upBKh5SyOCAlEss7/YA1Smh7I98zBBD9/PQR1Jyd48twMJLdB6wogSM2sNk08GsCl4KmI6EYOz0E6c6W5oxzvJF6Nu0Py6zsgm/XjFON0JYgLZRGRQ7FF0FPyNXXWzQ0uHs00OQIfHHV47BtbmECjfIh0FWJ2CQNFB7bWaM7Gh93AfGZ1s44GIf8AUzlQAUJjJCZhf7/fbq+6Dw/WZKySkRX9DNfa8nwjRL8YY+fnlDPeihJ1w7/LXemn5o9xSABP8h7KZPtVzIFV5KpQveyKxr6EaDNB5aUbYzOlZWfStjLwUzw3wE6aM+Tnxw0fXUVFZjMhSbE0g9L2ZXFDYdz0OXVm0DGOPSNSSsH6/myjD2eW9j8/HRkmlBcedntSslpTRezm0otPOOqtf4Ls5wQXpNaeE1M3DL92YfTjiRiucQNo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 07:47:53.2099
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 551a56b1-b8e0-4f08-4b3e-08df1f904cb3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A992.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9148

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

