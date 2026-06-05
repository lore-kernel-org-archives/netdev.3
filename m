Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2139.outbound.protection.partner.outlook.cn [139.219.17.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC19F3F5BD7;
	Fri,  5 Jun 2026 06:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780639356; cv=fail; b=e9symZnmf1n5gvTTbWtb2e5WrLUbb+HOWISZSopx0id3AZScut/pmo61wBjXKicA4UlnrVLqBW7cW4uOBfTQ6Jp1xqXvL2QO3deJTWLPiozCT6A3Kd1SWbXE2Bi6RTgoBW+il/otZrX3lnmkcjBeQGcSZkLd/31A4yMiRVW2Kec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780639356; c=relaxed/simple;
	bh=egTCt+Hji5TE7QB0a+z5XL6YtHWn14ZAok5YCYZ2+ko=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fLYOfK4hOE1kKaPWPMrEniDDBCxCoGR9Vfm5OzJMyrhFI0NataEZzoqc3wDpna1IxnJUP464a1Pvt0kLp68gf1E9V8qKFBR2/1c3w/KOQAMum0R3ouLUv9t2UFiOFNqdL3rWEcBHomi2CG2j2D8zKDFENrOYjsUKmQGwbqUf5Qc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nzHNHHKSccXeFAbtWNjqWzPu1Nkr76OrbIKFIDnw8lpR/tJPlT1BOI0FW2ll3y5sSN+g33au3NlEfe4Si3yZqNNSPhK+n5RWYkgKFGaNSmSm36VEkJbO4iwfT/RWURHsXm/VmW5uxCyuR5+x14dfjmdhBfybU7OfEqdXH4ufF9sUvYY0oR9vndg5eO0uLij7aF9qCtixEkbyVzeMRbl7Zaow4/TPuTOz52yp/50gij9Q/35+XH7mmOfQl8xj6ZHEWVvNgHz99ZxlUg8ZGkjdgRJPDtDhv5YVWhmWVzG1htjZ0lVCn3pfGMXsHB2gpH1cr3UT3kZTnNt1wQX3Czz6nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j3gCHIxZVmRkiMyEXpJVAXIH/USVV0D6GXEP0IIwon0=;
 b=k9NobCQdUxyC9XMIQKYBNCNa+drBQG569tBElup7tCovaoMlnmbSwiFtHpUMApMDXcPSe3ZvwWl3NzemKM0SDL8CrabHfBs/yKMEmAPrBPsGqmqtzadVc8ikUvBZCyeboZZUiBxfBH1rcu+TQZI2uPVMXA4Xnm4q5JMHprdklq8Rs7biv/zT6Q/sAWouWATz13/FQepsOGw5iinGy5VSymT4SDIR/POIg4YbaQyWcBvESycfujHQPWa3ojVyN+w+Eb3v90e4RaQUNKfSUlpoZkIsDYvO1YJg+PXkTnxXrkeomzXOT4R9VPX2mmpzDEKQ7nGyLuA+bzHTSdfqPfi78A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0542.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1c::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 06:02:20 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::9b99:12dc:a115:b90f]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::9b99:12dc:a115:b90f%3])
 with mapi id 15.20.9891.021; Fri, 5 Jun 2026 06:02:20 +0000
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
Subject: [net-next v6 1/3] net: phy: motorcomm: move mdio lock out from yt8531_set_ds()
Date: Fri,  5 Jun 2026 14:02:10 +0800
Message-Id: <20260605060212.41895-2-minda.chen@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: c137138e-28dc-4ed5-ebc8-08dec2c8010b
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|52116014|38350700014|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	3TroL5D2g4FANqyBVIu+Msaud4h6cniIc/yR2pIDSmGQlOmhx7Mb27RPkbk0wLRkTSEuB4nTxsohWdhEGmyV6+dN+CT/WbxpY4Phwq19efta0HeZwHKU3XfQjyhTWEnCH5AaO1z8ieA5fc+xuM7nXYQKCd5AZNjj5jYBe/sWu9NYlGEG0nFUbbmC9KVzs+zZpMhQYX/bxpodXPZ0GnuESsmZq/YXIGK3HUvbGsQi/9fLxGvu5wtajHtjYdX1u8rWD5PDjXo8YEdplqOLE+X6TRqZBGhGAp5spaXk02Qmr8OE7bh44YPQgnC8sEMlgcczpG9GrwVnR1LXSyJ3hdO5PqDetT9c8hahpio1MUw2VVDlKhm0Ch08QdiSDuAcWyQ5wnjumqjpWVh18GWoSrBkv7HHvN7/3+u3V1bf4EyuCgpvYRh7tUFbRzit32uGTuLZMAxIYjvkGSsiWiRUM//7UmjQJi/mBM/x43/gjK4GELNuThZD+6IG5dCowtRNVfCJVSh+TsLXZIeQ3UxcUYN+H5OJWvf0DTu6T8o/A0FRLwVZZ/FCtelxK2Hmg+wczJ+l
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(52116014)(38350700014)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0mij9794wp9HHDqp1hLXpOAXu+BJQOk2HVDVAw4WgkFm/jb7RK+ZF6NCFspP?=
 =?us-ascii?Q?HqmndiWpCoqQgZlK6iaISojprfwfTfY5xAql1yRBwUcSt4Ct6hVGhfeV2nt0?=
 =?us-ascii?Q?Bo/7fIO5FNjcJRWM2GdkzPFbqDUoIIqHZ6pTCwxtSgSU/qrkfjmPtGdPJKhy?=
 =?us-ascii?Q?0wivM47Zs/0lubGGD5AFo4kkoUjHOh0cDxkbZRXqA1xEfEFq4tXv5IQYXk1X?=
 =?us-ascii?Q?2f2P0vTYZIB9ekBdGNwzTtzz0sb/EYKaqGJ5cTCYMNaysb7mr8ujv9VpZsWB?=
 =?us-ascii?Q?nQLdzdjhvxsqY7cRHWKYCXbrOJeLbSIvnFB82yRz0/Sb16CY3nC4LO40RjiF?=
 =?us-ascii?Q?M6C9VzGwso/HP8rILSQP7wFSrB5YDpxAltgd/J62MufALbY06vm9C1quUxy8?=
 =?us-ascii?Q?qD/Pl8FBZtVP50shvWlPmuxNKvQHTbZoi2wSOpWBNj5MLedPJ2PA1lVyHEuL?=
 =?us-ascii?Q?bV+Oa6mw5mh1q00tzh3xTXfFVHPgM4aQ58PaXFsi+6etUXN5SASTA95JUirl?=
 =?us-ascii?Q?ls/Z2cjzn6yCE4IMnJYDjBOlYyD5u1+Sdz+dVi/EpGDbiR6EDEZHw43aXe68?=
 =?us-ascii?Q?qvmglnS/B1iHZWv6NyniLEN74dgowcVAPH78CNpwR7lIpg06+4DQfHuLYr/n?=
 =?us-ascii?Q?U+onzaf9Qx/zQZXdSI2ujjtGkyeQCvmSPrmWNwspL7OY4wFFwaH2lz45DWrA?=
 =?us-ascii?Q?nzfwuId9/vMKIraLeNuIp8A5VN0uyRIabx8dZEk6PNsWQ/zR7gD2CUCthAIZ?=
 =?us-ascii?Q?8iQTqLHbGP0DxdH2lAfV820sun90/xqAfHsXsdT/hNHJr75n8p5tcG+u7/y2?=
 =?us-ascii?Q?DCGN9CI7nlA2Jo8KRK07R7Fjn4ZsvjSeNl05soSBPydoeSia9OCZGaIpywbR?=
 =?us-ascii?Q?CywUOCVKxBy6C4bLLUgheIUwI0vSo41l655oUsWmYRtKLyZCIcoZRh3GGzE4?=
 =?us-ascii?Q?RC75qqYKcYQuZFB4It/Km3q/Lz56Sc7v7G4zrziD725/KPfwAgrXnfr+vhLV?=
 =?us-ascii?Q?r4zlUNeof07tvxe2tQvqEVodqPjG5ggldZTG3L1EZJlxzzzTsfrldE9M1P71?=
 =?us-ascii?Q?8XPmDeszuumTsMurkUZjALr47rxG2rBpzsLtIRF0/7RRBuEh2xblIvNotnNg?=
 =?us-ascii?Q?dtHIDGyZ4ZxQmaHFaXGBW/DcVnBs1wKXhESjAO/SHVs63kgTUmQJN0T2pb29?=
 =?us-ascii?Q?YBhbm+ooClEpZAKdFi8fkThTH8r5qcIqiKu9G94aIG3BMLzGx8GtpHTjMgH+?=
 =?us-ascii?Q?e5tHzjaboV/xiZ3XJTLetx6yIH6cQldiC3+K6YGRnms8aXGZDSmLDIOTCyq9?=
 =?us-ascii?Q?jrYPsAIS68F1u3PIcSOz+a8Zj1BGCLqH/Oszn8AyzGwrYVK+BiOS7Err7Y0h?=
 =?us-ascii?Q?8SVd/YNz7i/WgIS49gncNky/f4dMJ2R+SeDQG424jEZJVH86JBe6YtZSSxlj?=
 =?us-ascii?Q?txGYQ4COVa2LjvDdZbyxXAIkDSdifR5J4iyebHL0/wmnb2mgs497hXwKDvGm?=
 =?us-ascii?Q?NPFxXt6R1/+jszTKA/8ajhYvMvZKMROhZ9sNPDmLJY5b+TkkmifG/M8zefvw?=
 =?us-ascii?Q?l9gWE48oiocuYDL1RpCYDHbjTNWbLHduB4ngtolZSbbIZVJYOGGb4pH5wFmN?=
 =?us-ascii?Q?JDuIVAxr9Be2ZFhYy9mg5EWNuBnKIj0PTKbx5rlFxs0ID9LdQprtKajz48j8?=
 =?us-ascii?Q?dy08fRrBK3g+wY5w6V0R5rFlltkm3YHjzdUsGakb7SjPMBAV82ZNYFEvCLPs?=
 =?us-ascii?Q?DJeySwvYP3/IWMopGrUImDt2xtdVvAM=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c137138e-28dc-4ed5-ebc8-08dec2c8010b
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 06:02:20.1300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zjvd4JsXGQo62oiEm3j2G0A5iTsdcrthAOGF6Mc2xsoEYdsNj+79NuDt8Vj1d7EEH7EtdRBaz0gXm2dhoLYZ+K70K0BTYpwvboGQ94oVU8I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0542

yt8531_set_ds() default set register with mdio lock and only called
with YT8531 PHY. But new type YT8531s support RGMII and has the same
pin strength setting with YT8531, YT8531s need to call yt8531_set_ds()
setting pin drive strength. But YT8531s config init function
yt8521_config_init() already get the mdio lock with phy_select_page().
If calling yt8521_config_init() with mdio lock will cause dead lock.

Need to get the lock before calling yt8531_set_ds() and move mdio
lock out from it for YT8531s.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/motorcomm.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
index 708491bc198a..688679457ef9 100644
--- a/drivers/net/phy/motorcomm.c
+++ b/drivers/net/phy/motorcomm.c
@@ -974,7 +974,8 @@ static u32 yt8531_get_ldo_vol(struct phy_device *phydev)
 {
 	u32 val;
 
-	val = ytphy_read_ext_with_lock(phydev, YT8521_CHIP_CONFIG_REG);
+	val = ytphy_read_ext(phydev, YT8521_CHIP_CONFIG_REG);
+
 	val = FIELD_GET(YT8531_RGMII_LDO_VOL_MASK, val);
 
 	return val <= YT8531_LDO_VOL_1V8 ? val : YT8531_LDO_VOL_1V8;
@@ -1010,10 +1011,11 @@ static int yt8531_set_ds(struct phy_device *phydev)
 		ds = YT8531_RGMII_RX_DS_DEFAULT;
 	}
 
-	ret = ytphy_modify_ext_with_lock(phydev,
-					 YTPHY_PAD_DRIVE_STRENGTH_REG,
-					 YT8531_RGMII_RXC_DS_MASK,
-					 FIELD_PREP(YT8531_RGMII_RXC_DS_MASK, ds));
+	ret = ytphy_modify_ext(phydev,
+			       YTPHY_PAD_DRIVE_STRENGTH_REG,
+			       YT8531_RGMII_RXC_DS_MASK,
+			       FIELD_PREP(YT8531_RGMII_RXC_DS_MASK, ds));
+
 	if (ret < 0)
 		return ret;
 
@@ -1033,10 +1035,11 @@ static int yt8531_set_ds(struct phy_device *phydev)
 	ds_field_low = FIELD_GET(GENMASK(1, 0), ds);
 	ds_field_low = FIELD_PREP(YT8531_RGMII_RXD_DS_LOW_MASK, ds_field_low);
 
-	ret = ytphy_modify_ext_with_lock(phydev,
-					 YTPHY_PAD_DRIVE_STRENGTH_REG,
-					 YT8531_RGMII_RXD_DS_LOW_MASK | YT8531_RGMII_RXD_DS_HI_MASK,
-					 ds_field_low | ds_field_hi);
+	ret = ytphy_modify_ext(phydev,
+			       YTPHY_PAD_DRIVE_STRENGTH_REG,
+			       YT8531_RGMII_RXD_DS_LOW_MASK | YT8531_RGMII_RXD_DS_HI_MASK,
+			       ds_field_low | ds_field_hi);
+
 	if (ret < 0)
 		return ret;
 
@@ -1825,7 +1828,9 @@ static int yt8531_config_init(struct phy_device *phydev)
 			return ret;
 	}
 
+	phy_lock_mdio_bus(phydev);
 	ret = yt8531_set_ds(phydev);
+	phy_unlock_mdio_bus(phydev);
 	if (ret < 0)
 		return ret;
 
-- 
2.17.1

