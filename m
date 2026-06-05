Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2139.outbound.protection.partner.outlook.cn [139.219.17.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233F93FE376;
	Fri,  5 Jun 2026 06:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780639368; cv=fail; b=ujP7hAn/GH6tPZJO7KHNGJmqWaWpmdygAwSbQUo/gjZhsUdBR5Yw8Ax7DeJT1BR9JsZ5L1J2KmEsDUE1F5kYyQAi8KFqDjceCEMntSBqONJdYuwzPGjWjPOYFzB2kWrNYo3XzK2DmYy+Em2qKv1dl2MnAVZvz9Pc1V9M/2PHZU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780639368; c=relaxed/simple;
	bh=OKrPHzC/quFKe1rqEV8PRaoY4aiHGSWS88LUdXqSq94=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iL1S9Fj0g2c2ezTugBgZ4Zs4Jck9oDsgeXxQjf4ps6QiiDpxxc+kC51SlKByO8tuswrAsYedUyXLSIbPfiLUXYLHOq/eMfl4GF/3DSN/RrofwqJ4u+M9bEjz7SiS1mtZfuAVMRDcPKFk9bHkpXif/Zsf7D+xGT+BGkqc83WIYrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mIn/IDDvVIuzh/SicOEiKed/LQm8UbPTDXMkJEFWuaqFkvT0k2EESL8pLg2NrkDBfVtR7BZON+s3wvF+hvAk3CCDi+UowBIj1zCAVZwOarbS/m5yAMf/sq6rIYst0nEG/BKdh44zlFYWnZl08Cv+fKfVoW6deNMdY5lbOo31rf2jzmnPqe8BFuOG3dOo/IZrQezH1Q/U5AuCGPda37k3jx6/jBA0pRv8dVpDJTz4qm6PW1KUYlLrXoVu/o5xvirW0127ovWest06HG6Vl0a7cbEXDWbNfuqaErxcfsymZ5540SIzceKDCBnvjEb78TqoZYLBJn/kS+KKjSBWAxL97g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i/pKecRm58eKlxF9YN9/9VB/ugGEeaknlZwgvGMsWiI=;
 b=SgGn0iKCj17nimbodCbRDlyYAPhVz8j3Qb18BLyYG76pzgugl/X7hGJmPqiJlBEcZggH8lkmlaYXra4jmsWQq67FfM5iRCB9gos9Ns0/SPQG+RgdgRXPyWeib3K8ysi3L20yUvOpLy15DSwXRBmDJViscBi8E9MOlsDQyynQGEBqkPEwHMsyQiOOO9Jw5onOXQ85FkY6+3gFfRrtloCeHMHDN76YgolFCnEccUE9JuvC8OeV+OkxDK8X7WiJnIOiDRpJBoMmsoWDdUZ1gM42CibHxTs8oi3TSI3BgkBIrzB6lr6fWCVg35FhWMbJbqGYw8v/0HhBKx5ER/dy/szxXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0542.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1c::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 06:02:21 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::9b99:12dc:a115:b90f]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::9b99:12dc:a115:b90f%3])
 with mapi id 15.20.9891.021; Fri, 5 Jun 2026 06:02:21 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Frank <Frank.Sae@motor-comm.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Minda Chen <minda.chen@starfivetech.com>
Subject: [net-next v6 3/3] net: phy: motorcomm: Add YT8522 100M RMII PHY support
Date: Fri,  5 Jun 2026 14:02:12 +0800
Message-Id: <20260605060212.41895-4-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260605060212.41895-1-minda.chen@starfivetech.com>
References: <20260605060212.41895-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0026.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::21) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0542:EE_
X-MS-Office365-Filtering-Correlation-Id: 2af16e56-cd19-48c5-794c-08dec2c801d6
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|52116014|38350700014|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	MPxJRce+lTBCIeZJqZuZ3VpxqOoykgDI3o7Bu2E6+w8a8LT24UxKBJYrFtUZxnHLqWDOZyiBNgyJQ6ldMlwJejtq3KZJz7yFxpHW2cKiOOVb4fvcpfiLJb6yufklD7lysViBzdvE2nJa9RJXV+2e2C69Et/24uzy+PPX4eauC4Td8IU49G6k56HWv+uzsN3z+axwyKZF6R5m/2MBaK7RsIUiSMSwvQnpxuHCvB23KuCHVubC4M/nC70N94mEZrYGmhTjn1weR4RX4Eq7o6JzWDun22Z/GJJsZMKaTgX23FeAL4fUBarUPrTIGOUxIDNeE0CHnPHxwxLj9m+uhUwFfWwrHsGGjpm/e3DHL48j8ZJB5x/CldI3yPdMNdu70llIR1zP1qN87t8nyEbB/XlmPGu/U3Cgux6lKB9maM6Pl7CW1aYabrko9lwRkjkqmg0EcBaDg0rWr254IrgsnrvjnZNMJhBe8fiQIq4zgEXhAKYSJ8kKbtMqjzGZWRA16iVpMiU4zpZZwSTk2x06OQBghG0ZRu61bcB40ZPkuBreKwV+UtZ9oq/d/PtP7k4d8fV8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(52116014)(38350700014)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G7Vevp53Mi1ZE67O0tS4WHd1Mrbtvzc5iUHKXN2a4j27rsCimL5Y+Nv+FJVd?=
 =?us-ascii?Q?X2PjMT2x1UMJ4eNeNII6uKrR9PwxFvTCCIBxgprbkIg8TdhiEnNZOTayyJlq?=
 =?us-ascii?Q?y3zZii9LNzMVHbLOyRu7ngWiNCFvgj+iTGVfqUIFUWk9Qq2QsoW2u1+cmjMO?=
 =?us-ascii?Q?NJymODt2o9SEkWLnZjpLUOreUDs2N9cqUWguv86MSZmommZcFu+C42eGtHm9?=
 =?us-ascii?Q?AF4rJGIPQyp5eHSQqxgZ79/7miU7BmFQYXC5SUhtfj59E9UCvJD2qKXBFJmm?=
 =?us-ascii?Q?EGL8de+e2X0xPkmwGS0pA+ZYG+fedzb8LEn9NJcuSNTueSB2lJtshI1ZvUm2?=
 =?us-ascii?Q?odusW9CNoioWXBOfRoB6ESHU/h3Y+rUpWOb6ontakGrc6lc69Cv4BnzJBK3V?=
 =?us-ascii?Q?DbhigMum++5sfS3Zjyixhag0z6joknsOvefnqQauiQuWfoWxzK83Rz4PSJhC?=
 =?us-ascii?Q?UVLXYJVwTv/7N/4HP5phruST8wgTaKEJzXsfuNFlj6O0C3/mCbk9TK26LwWC?=
 =?us-ascii?Q?eZ/5YzqFUHEqzfAq/ZT7l8lhXkZSOQBKww/Ny61SG2e8zoNKc0yqAVspXNWA?=
 =?us-ascii?Q?YKAYjo50S5e9yWASBLOGj3iWSBtScla2zc93qwAZooxWTxAZjxl/ZH1C5ZW+?=
 =?us-ascii?Q?JJxE3g83Eqo0tw5AnBXILFNgOoW/VMaV1fjo9PXf0OEwplZUxjp5r1VpFaqD?=
 =?us-ascii?Q?Bvi1JjjgLmSGT5lSuf4fHlAHljWrnAvoTcw2LaaNZpgubzVxo37jO6xZWjlh?=
 =?us-ascii?Q?IE7Wj6E5F0pQisIsWm8ZjKpsarn5IPLx7pMNvxVaWr/fZnbNfb9A/MJafvSj?=
 =?us-ascii?Q?fMhmEZn96nki1Uhu7tQ44KAvyxZkbchHory0Uswej9BDz0rTnJXjQ/RwKE38?=
 =?us-ascii?Q?Th0Pg5xYwRZ1PoObW6ia1RdMnHX+tYEMzdxduKHAvqH6GzWnH13IMnys3p/7?=
 =?us-ascii?Q?K4rn6eGtf7gw2BfZ+H7yjCJp6JObUn87gNZx4Z0mDdmlzqfzz7NkV+R5uvPj?=
 =?us-ascii?Q?dKDyA3kz4lYBtcjYwGwVfbeARUX7POrragbP+UD7CyTjEr9o2TUuUfRJgjnL?=
 =?us-ascii?Q?1h7oJDHklDEc16ANfBGz4EpE4cZkiNqDCoCYtinulF8hvCrnVDCIfVTdls5+?=
 =?us-ascii?Q?ANsFL2X9a0nbgJTeJJckLZfD2YhWNHXlXY1r2cuTJo15YCREtz3rajrM+po1?=
 =?us-ascii?Q?2QJttUneZ+Tdio1dfHg1olFXAKWPQj/aamCv5Ra1oQMimgDmNlXtXfG/ikGI?=
 =?us-ascii?Q?0otavuBM352JmYsz1IVd94VHXpQcf8Elh8BbSBHtu3V/FjkjRb/j4i/iZnJp?=
 =?us-ascii?Q?/QWW9aWa0RsDQwLw0+VaE7ITuE3UgaQ5qfHxhPS87hWEKpmdGBJJyc3ZrtNH?=
 =?us-ascii?Q?jTPd1CrZ+u56CIlGuDVHPPKtrmh9nwCA+dTzbQ57tGWgYNJOPR/mKjJBTyrO?=
 =?us-ascii?Q?PXFc2ghuAaXnA/DV1ox8eMuIqCQ2YSXWdvyTs+oWDpLw/MiLjn6ZUQk5fxCS?=
 =?us-ascii?Q?bEJcNCDJ+Zihq5wIMcUTCZS6vco6+PsRJQRdlUzVguMxJ02ObNdC4kuezG+Q?=
 =?us-ascii?Q?wtLsl05m3imr73YWypTARvgt9J4wHhNJK12g5I1muR/LtqHukcBShmek3NTB?=
 =?us-ascii?Q?Raa1rBg0cV6xz9cPztgB3l1T937cBt8IG+fD20mao+nE9VtVa/YgPScH0S58?=
 =?us-ascii?Q?83qO74vfDq5yyoTVX08GgDiSnzHls0mkxpeFx5Sn2/G2TkHSO16PhwcfwK9D?=
 =?us-ascii?Q?uwgm5goUnFgVj41A6kkEMcsYrbw+JAY=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2af16e56-cd19-48c5-794c-08dec2c801d6
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 06:02:21.4076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xh54mJbx1z/rXHnbRuo56iGyUaLgPv3azZpe3vn9dB5PR5CAiuYJnc/J2JzR9di3askNHTlAhcU8w3LLcue+cIbN5UwwiT8TC/PXxn/Zd9A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0542

Add YT8522 100M RMII ethernet PHY base driver support, including
PHY ID and base config init function.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/motorcomm.c | 49 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
index dcba50007451..5071605a1a11 100644
--- a/drivers/net/phy/motorcomm.c
+++ b/drivers/net/phy/motorcomm.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Motorcomm 8511/8521/8531/8531S/8821 PHY driver.
+ * Motorcomm 8511/8521/8522/8531/8531S/8821 PHY driver.
  *
  * Author: Peter Geis <pgwipeout@gmail.com>
  * Author: Frank <Frank.Sae@motor-comm.com>
@@ -14,6 +14,7 @@
 
 #define PHY_ID_YT8511		0x0000010a
 #define PHY_ID_YT8521		0x0000011a
+#define PHY_ID_YT8522		0x4f51e928
 #define PHY_ID_YT8531		0x4f51e91b
 #define PHY_ID_YT8531S		0x4f51e91a
 #define PHY_ID_YT8821		0x4f51ea19
@@ -227,6 +228,13 @@
 #define YT8521_LED_100_ON_EN			BIT(5)
 #define YT8521_LED_10_ON_EN			BIT(4)
 
+#define YT8522_EXTREG_SLEEP_CONTROL		0x2027
+#define YT8522_EN_SLEEP_SW			BIT(15)
+
+#define YT8522_EXTENDED_COMBO_CTRL		0x4000
+#define YT8522_RXDV_SEL				BIT(4)
+#define YT8522_RMII_EN				BIT(1)
+
 #define YTPHY_MISC_CONFIG_REG			0xA006
 #define YTPHY_MCR_FIBER_SPEED_MASK		BIT(0)
 #define YTPHY_MCR_FIBER_1000BX			(0x1 << 0)
@@ -1842,6 +1850,36 @@ static int yt8531_config_init(struct phy_device *phydev)
 	return 0;
 }
 
+static int yt8522_config_init(struct phy_device *phydev)
+{
+	struct device *dev = &phydev->mdio.dev;
+	int ret, val;
+
+	val = ytphy_read_ext_with_lock(phydev, YT8522_EXTENDED_COMBO_CTRL);
+	if (val < 0)
+		return val;
+
+	if (val & YT8522_RMII_EN) {
+		val |= YT8522_RXDV_SEL;
+		ret = ytphy_write_ext_with_lock(phydev,
+						YT8522_EXTENDED_COMBO_CTRL,
+						val);
+		if (ret < 0)
+			return ret;
+	}
+
+	if (device_property_read_bool(dev, "motorcomm,auto-sleep-disabled")) {
+		/* disable auto sleep */
+		ret = ytphy_modify_ext_with_lock(phydev,
+						 YT8522_EXTREG_SLEEP_CONTROL,
+						 YT8522_EN_SLEEP_SW, 0);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
 /**
  * yt8531_link_change_notify() - Adjust the tx clock direction according to
  * the current speed and dts config.
@@ -3051,6 +3089,14 @@ static struct phy_driver motorcomm_phy_drvs[] = {
 		.led_hw_control_set = yt8521_led_hw_control_set,
 		.led_hw_control_get = yt8521_led_hw_control_get,
 	},
+	{
+		PHY_ID_MATCH_EXACT(PHY_ID_YT8522),
+		.name		= "YT8522 100 Megabit Ethernet",
+		.config_aneg	= genphy_config_aneg,
+		.config_init	= yt8522_config_init,
+		.suspend	= genphy_suspend,
+		.resume		= genphy_resume,
+	},
 	{
 		PHY_ID_MATCH_EXACT(PHY_ID_YT8531),
 		.name		= "YT8531 Gigabit Ethernet",
@@ -3111,6 +3157,7 @@ MODULE_LICENSE("GPL");
 static const struct mdio_device_id __maybe_unused motorcomm_tbl[] = {
 	{ PHY_ID_MATCH_EXACT(PHY_ID_YT8511) },
 	{ PHY_ID_MATCH_EXACT(PHY_ID_YT8521) },
+	{ PHY_ID_MATCH_EXACT(PHY_ID_YT8522) },
 	{ PHY_ID_MATCH_EXACT(PHY_ID_YT8531) },
 	{ PHY_ID_MATCH_EXACT(PHY_ID_YT8531S) },
 	{ PHY_ID_MATCH_EXACT(PHY_ID_YT8821) },
-- 
2.17.1

