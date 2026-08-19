Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazolkn19011037.outbound.protection.outlook.com [52.103.43.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04E92F1FFC;
	Wed, 19 Aug 2026 13:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787144860; cv=fail; b=QMFRxeS8HN2DJGjiXdx1ev0n76n2ZGEQBIfANeF0ZlaocmbmCiU9IWjzwtVmWueSZRPoJFv8Us9NIGhdNQ5SFbkUdUwJLy/gCFxZi/JMj1uXxbIX51aShvXhRDdGb4twEo/sqPKteM+43QPf2QpXW7EFCerG/FU0GsqZRbIHaDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787144860; c=relaxed/simple;
	bh=UmEdyFKT7F0ysB9iQ7WkA9sCrUpN12EdREGRv+t50qw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=MbSVmmZCDZx7TaLwa/ok7lpydKSY4/+jaoirgX5dZD999/Ku5GW1t2ZU+ICFFaaBs32EXRuzA9OyZ4L70TuIzHxMCJW5HWLhZyOHNeyTHrm1rM7V/2m9uB7y5i+wY5IogoxFEDKEHv1UGe65/K0V8ijlHeDnMW1YnkhWAdpyh9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=TvuYglUa; arc=fail smtp.client-ip=52.103.43.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="TvuYglUa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dk2xVhQ8nbQN3WLqfqnxjS5ocOdJNIJAKolBo4pzn7oLU299p/1/Y0pkGyYCkeGUvoJOdNk2GqU2L6nWO6THVGelecvcYnzUToOJvXN8SH/tOvKXKXT6ZjJIn3JJ2VCiggyRDjC/AtF8V9FtaZi8s43oQfJMpL4R9UDf+iCxI7mdHW1FRsbakWst0ibMfGifCBDue1YvUTAknQOgvosM8uvXdRL8z6m7ipifVAZlAsUAFT3AL0/FBkK7FmTVKDXBKwfAbWGd6ajxKRJPajxUm4TvUBMP3zE1vJxSirZDNP6aQhnVGb5vB9cLV9Zw8zdKqahorszyZwwvAnjNHjCelg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7IC+rm5B4Z35mmDobDih63+36XzG2WyaObbskCPThrI=;
 b=G11RX1OfP1kwFZZZS+Kz5oyBz0BKfBMmnJa/WZ0XzATIU4cF/RS4ccXgDc0m7nZxHmyM4Gh2G7oO22DodmSNZxXef/V4RZkIS1+puwduD4sskBPP2gJmk2X09CJpQiu0Al8vLJfT75iTQBGjcQKLC1tylUIu65wY4E7qRxlc1njw+VORioboRHxRrprriHVwtYlTh53DJuDNFPasm4oG0fQIYhmaqAGUGGKK2QVEQdvS49Voa2/ErHl3+jHtDjhxzKR3zslrzl/iTYbfkx0RjoXesFO9YSS4PIh462+TgbfZbC7hNkZKQh9UZbGm2vKf2OD190Aap0rZPn7WiwW8dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7IC+rm5B4Z35mmDobDih63+36XzG2WyaObbskCPThrI=;
 b=TvuYglUadnxc9lnWrTMplLUx9u0tP6Y+9zA2K9MPqysnfFXXfM1NQzYvF0eTbGrzVZUETz/mR1wcnO/pyq4IXoO/TWKCNVPwL4yB+TK+mOb8bBSpHwKrz89ygr3oXOk5iDOTqw8OVc7svftXb4CAZSTliPFvfbdl8MSTBl47c+gJ9A8CZ+0AClnhlcBVQVJDeq1QvBkafVUp9xG7i8RolAgbR0T7apLNRH7QePJ0p6f/l4qe547LXLZefvB8qi2Ovp8hfXfeUSe1Kg1qJh5Q3HJQYjdocaAQQZMWB095/P6SuG26afw2ti2pOZvnZ9AMZuqnGQQxrEWa1O7/cymcfA==
Received: from OSZPR01MB7795.jpnprd01.prod.outlook.com (2603:1096:604:1b4::8)
 by TY4PR01MB15904.jpnprd01.prod.outlook.com (2603:1096:405:2c7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 13:07:30 +0000
Received: from OSZPR01MB7795.jpnprd01.prod.outlook.com
 ([fe80::7a31:a23c:129f:8288]) by OSZPR01MB7795.jpnprd01.prod.outlook.com
 ([fe80::7a31:a23c:129f:8288%4]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 13:07:30 +0000
From: Shiji Yang <yangshiji66@outlook.com>
To: netdev@vger.kernel.org
Cc: Rex Lu <rex.lu@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH] net: ethernet: mtk_wed: increase WED v2 WDMA RESV_BUFF to 0x80
Date: Wed, 19 Aug 2026 21:07:07 +0800
Message-ID:
 <OSZPR01MB779537889255E2F606E47EABBCA52@OSZPR01MB7795.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0004.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::22) To OSZPR01MB7795.jpnprd01.prod.outlook.com
 (2603:1096:604:1b4::8)
X-Microsoft-Original-Message-ID:
 <20260819130707.15144-1-yangshiji66@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZPR01MB7795:EE_|TY4PR01MB15904:EE_
X-MS-Office365-Filtering-Correlation-Id: b7f6b1a1-2f16-43da-37dd-08defdf2d318
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|19110799012|22091999003|24121999003|5062599005|15080799012|24021099003|25010399006|5072599009|23021999003|4140399003|40105399003|53005399003|1602099012|10035399007|2607281247196008|440099028|3412199025|4302099013|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TeCwjrgJx3aBAvekqOJEbckA8GbG3ny+JxQ4oBFUTbvpGer5R3x7+qWeQY9y?=
 =?us-ascii?Q?gdXElzW13Be+00Wmcs2GrDD40TlqLHa3lt5+4yTu0BZv199WBQFnRBm0InjA?=
 =?us-ascii?Q?ZB0aCwh2KlA6kpFRa5WBL2hhm8YDjVGAxRws02Y+3YFqNKIcO9gLKGx0XFXc?=
 =?us-ascii?Q?lFqJfddY/4JajvwVGvUflboJSEaI/+6GX47/mZuVJ2bEpIvWDJ7/WvEl+abO?=
 =?us-ascii?Q?k4GEFj3073Gpw8LgCPnYiah+aN9P6v2rZiCL02iukUCjbVpCloR2WdxvPLBg?=
 =?us-ascii?Q?1jkGGfhc6J8UVblLzwKAUMj6B/KDgdyl1DsMcqOji1zhi10qIHFJjNEZQoPi?=
 =?us-ascii?Q?HhxhiucGk6hb7mLp/Qlx4VGfPIPnuZJhSkSL97sttc2c2HhiDXb9m3U0My4r?=
 =?us-ascii?Q?EddRTO+c7ePikr6pEDCtsnTu4Ttt/0WTh7+m0hYXBcLrfB+d7Ve+MjrPMUws?=
 =?us-ascii?Q?QnDkzquDF+gDl5w+svSPoZXg2bNkKLlM1vRz1g1EXQK3Wh/2F3ACNrm6WuvH?=
 =?us-ascii?Q?huXo7RzDLncpdVWg6rOPYt6kcndipCYAHZMLrbCO4c/7zfRr+8Zd4NXMQ41b?=
 =?us-ascii?Q?Ws57qhUGLBfruFWaqijsvU/9n2j6x2v1aljqlcsUEBYDeqYUfB6w+jnik4jB?=
 =?us-ascii?Q?gOzwFk9cvKI2G+5aZdVgoZH4b4AfDfLybsYCjbkshMJQrEZbRbgGgSmMHeir?=
 =?us-ascii?Q?dQ8YsG1mJkRUa/T0Cldl6cDkehMdEz+mTDXsvrKJCCdynPF0hzdyKLoIAZvk?=
 =?us-ascii?Q?LJPp3Sol/U1g15ZsdF1QAJxe30CyUAHy2adg9+lR6WnpzXcEBT88ePTg+WR9?=
 =?us-ascii?Q?5u2LJOTYSralUwEXENVhildIfr6juDneFuJTqRxoWv7IlkbiBbxxKWb3LHvA?=
 =?us-ascii?Q?/9bTeRUciJtRXrsh7+nxIvVOFR6/e1fC/Sa6gPC7X8kRf2JUClV/l11rQJZ2?=
 =?us-ascii?Q?Fy3aXCidTHoe4bxJwDt7zZdJfPuLT2U6O4UkVwZHdN4wCKL9jOBqdnGbnRB9?=
 =?us-ascii?Q?RswlGi+V+UstplpjK2QuRqukdWDJv2tFN/rBKCWSi+BFPHjz6pHU+jeKKFQy?=
 =?us-ascii?Q?+xqBR9ajMCp7diR2jU15PA6rC7tfYysAqjvHRqBNGndr0/ehbtU=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wcSRY6/1RXB5oGMjCW5sWDBXejxGgJdW4SL1yi7tClfcPv5smGemaqq3/wSx?=
 =?us-ascii?Q?pckabGMLgPq0rl/fchFwVn5UPpWRoR0AtAsZDJ9574kTCkdr2CFrdN5HtOcF?=
 =?us-ascii?Q?JFn775mwTIudw85kvSh4eT97aMPIikhI/ytuaEHj+w1BJhwbJwj/XNIxbSTH?=
 =?us-ascii?Q?4SyE3jlu/vQJ13lVd7ascpqxpLZXYv98NwlOCWNc0mppjw6ewLhD/Sf/QwAy?=
 =?us-ascii?Q?he5AV31DWhYBX6CpmH6AOOIH+z8PLTj/hAElFsOD+iLJgXwnCxSmX6vhwEkM?=
 =?us-ascii?Q?9X9KAxBGhjqbzoybWERN0gGGARDPG/w3ST0yGBeRNCJg1XfYQ7bIywdYkXSS?=
 =?us-ascii?Q?4LtqyBkzBIZFl2Q84YUB09D+39dS+keh5kDlFLV6jxje10VrFILFeBGvluBt?=
 =?us-ascii?Q?3F5dEe7wiXZduBZtias5+ahkaF4ed+6pTIXNAtp0di/e+pT58n4+U5gekx5F?=
 =?us-ascii?Q?Kr+LIHvlXP6wjOLnfHIEhkxbT1Arv7s8K3kd22EHZyW1rFwalZBPmdTwRSW1?=
 =?us-ascii?Q?N5IH4P96B4FF79NEHMoGAPekn66QkA+UScajkkOkXMBq5hnWbQRbfpXpFLUX?=
 =?us-ascii?Q?GlUHFmGerdC98CCl58Xr4fHUHJTyqOOgPlskEo05kShMD+2GMm23PqK25IFo?=
 =?us-ascii?Q?FAgY6g/yXqcgZK5coSrOgjCmJhC1RGePcF4O622pBcv8B05V++u2OY7XM8JR?=
 =?us-ascii?Q?IEa4tyvBoHzfb1re6uEHw91mf8qKMQpU96OXH2Tqt9tw2U4SKvobAlUw3lTw?=
 =?us-ascii?Q?NILkqP0KNeT5nriL4T3fRx7JIbbSP6x6KXUeQ3AOfErLTRzdhTuax/SFe5Q/?=
 =?us-ascii?Q?HqUIBAZa1xakhKz9hi4eg1dKIF0yIXDgwLjvxI1YdRDTkZIQC+W1xu+d4uDm?=
 =?us-ascii?Q?uvkKcD+yGw9wmz6Kp4mTrROXwWArRAWOm1chbMabOSoWvii/kaIAlpbzvnwF?=
 =?us-ascii?Q?KzC0274Th8fR5/NFeSkPPp5RWRJs5+X+zphNBJoxZn+2/jqbLohIBCjnllVB?=
 =?us-ascii?Q?6vziZ1QiKftqN6QMCbTUHOkeBr3VJ6bsokkVnK2yP3IT47pf2/V6xm0QZYz3?=
 =?us-ascii?Q?P3+2hDx864YriI4b08pirVvCFS7iMCXeteVMNyTWDs9EsPcpR8K618y73zBZ?=
 =?us-ascii?Q?FNuTOPJ6i3FVsBLebh7IemqtuZXPs44bRiF/51LVCYIUkBIA+KFqTqmhrJTq?=
 =?us-ascii?Q?nh+oosq6EIS95HYRr8TayIpQFy1PhhyoDy8ryhLChD7zN8JXCnwWQfDrHGQg?=
 =?us-ascii?Q?s2koE6pFTwU2LMuwQdjcINGoYatyXcPqXkxihXDKdA61QXZmXVldG53gK6GK?=
 =?us-ascii?Q?ifHJXjJkbKtFIoWRxmZY/OS5MzapXF5jXmFXI3BH7/KhlDmC7iZoBLIOmTGD?=
 =?us-ascii?Q?xubQBpD9OpZxKl8C1N3XGjhkjKouCTIGnYhBXIlgabq1x+3BRg=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7f6b1a1-2f16-43da-37dd-08defdf2d318
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7795.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 13:07:30.1211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB15904

Change WDMA RESV_BUFF from 0x40 to 0x80 to avoid CDM TX FIFO overflow.
Without this patch mt7986 and mt7981 may have WDMA TX hang issue. This
patch was pulled from mtk-openwrt-feeds GPL open source project.

Link: https://github.com/mediatek/mtk-openwrt-feeds/commit/07c87502e854b68b48544d101b6fe17ec059b97b
Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
---
 drivers/net/ethernet/mediatek/mtk_wed.c      | 5 +++++
 drivers/net/ethernet/mediatek/mtk_wed_regs.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/mediatek/mtk_wed.c b/drivers/net/ethernet/mediatek/mtk_wed.c
index 10d9beaae..53d3b7e00 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed.c
+++ b/drivers/net/ethernet/mediatek/mtk_wed.c
@@ -2071,6 +2071,11 @@ mtk_wed_dma_enable(struct mtk_wed_device *dev)
 		wdma_set(dev, MTK_WDMA_GLO_CFG, MTK_WDMA_GLO_CFG_TX_DMA_EN);
 	}
 
+	if (mtk_wed_is_v2(dev->hw))
+		wdma_m32(dev, MTK_WDMA_GLO_CFG,
+			 MTK_WDMA_GLO_CFG_RESV_BUFF,
+			 FIELD_PREP(MTK_WDMA_GLO_CFG_RESV_BUFF, 0x80));
+
 	wed_set(dev, MTK_WED_GLO_CFG,
 		MTK_WED_GLO_CFG_TX_DMA_EN |
 		MTK_WED_GLO_CFG_RX_DMA_EN);
diff --git a/drivers/net/ethernet/mediatek/mtk_wed_regs.h b/drivers/net/ethernet/mediatek/mtk_wed_regs.h
index c71190924..e5f83100d 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed_regs.h
+++ b/drivers/net/ethernet/mediatek/mtk_wed_regs.h
@@ -433,6 +433,7 @@ struct mtk_wdma_desc {
 #define MTK_WDMA_GLO_CFG_TX_DMA_BUSY			BIT(1)
 #define MTK_WDMA_GLO_CFG_RX_DMA_EN			BIT(2)
 #define MTK_WDMA_GLO_CFG_RX_DMA_BUSY			BIT(3)
+#define MTK_WDMA_GLO_CFG_RESV_BUFF			GENMASK(23, 16)
 #define MTK_WDMA_GLO_CFG_RX_INFO3_PRERES		BIT(26)
 #define MTK_WDMA_GLO_CFG_RX_INFO2_PRERES		BIT(27)
 #define MTK_WDMA_GLO_CFG_RX_INFO1_PRERES		BIT(28)
-- 
2.53.0

