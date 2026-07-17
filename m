Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19010017.outbound.protection.outlook.com [52.103.23.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E3A37AA98;
	Fri, 17 Jul 2026 03:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784259844; cv=fail; b=SlPicNMm4e1+sYyKX7KstmvSmEfdW9XtEmTWNO1idY3V+eu2IQ+v8VUg3JG89zioDs1tkR8plZSLSeRHxQA1BhHLXK/PyLU1EW0K/4igVxVlq0bA5JAxQJvovFmAmsNuTEM6eAEghMjnk5+cjQSmjeGKatOEBkBaJ7bimkEJgKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784259844; c=relaxed/simple;
	bh=XLvmpt+z8fMk4/sMRQfta2BeBL5R1nnANk50M+QYUy4=;
	h=From:Date:Message-ID:In-Reply-To:References:To:Cc:Subject:
	 Content-Type:MIME-Version; b=GC8olIiPtfNF4NqKGKqhFcMupPe5LZtyAX2L3MS+V6ydwMgMB67USbIU+WBbjzBUrJU2/FZvZqk4ZwdZEfMBlR4qNHK1DejdTEmDfm1DjOAKjdB6HKFCqVRe9AE4Nr0Swth2HMv+EwV7uiFggZd7HB3TUUv5xwZl+YlN1jNAEh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=QlRKRJvR; arc=fail smtp.client-ip=52.103.23.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="QlRKRJvR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xO9Z7vwzjPnlmNMwvIuzUbqnNvvzajvasg+8HmOF7fOoJCya0mfvr+XrQBoP0ekNK979vPeoI8RApQfP2tc2pkZXuw2abidXksZ/h72UuoKnOpjrv9FatJVlE2PQ1RsOdV9tLQndYcRAVqzwyp1IM65JQJVWFjYNqqoIxUyHTL53FerVwQq47ljjSoZNgr11vlL0G1waNCr+XI9zCZ305JTOmmD379/fA5zvtn4QPxYQjppJGZD5MnHdFd9YX1xHp/bTYVTOErhyniSr4LTGFdPd9y9RuRsgsFLouMBFTmG7p+PkbaZEOLYKJblrzdGUKJhP2OXpRR9qYjHbocOpiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AedscYHBzLkBiT9cd/FDBy1cI5LT4FZ+m2BUeXrzWAI=;
 b=hVSnwhjTgP5fci3jpBmsZ28ngbxVZ1mZFU9Yt6jVyWn1mgT+A/JFz1X2htyCbiMpBzji88NYhANsir6exA6lA9nFEkLhwXQQbCHFmlyprpabbJiz6fzVfBZieINaxSD1fpJHr3XHV2Q9g9+JfUIQg9GC9gyaYFeHWnum/hyWvi6MQRIU1Mc9N7S7oORrlPqhz76i2aeYl1JI9YV33+b5sBf7cAC5BRuTNwwX1lA+ULy/27ELgNQNDa/Jbasrr2xOUI9S7Pd0zI0p+D6XuK1th4dzy/z9dNb7fBISArTnW9gH3jkQYnnA1DH8qck5PGxMUWJSZ1G37pdpPxvlyrvu/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AedscYHBzLkBiT9cd/FDBy1cI5LT4FZ+m2BUeXrzWAI=;
 b=QlRKRJvRhzl1R0wS8MY0Dn2qam5eOpOETRdQ/OpeoBnEnONU4ozMQFGjGsUa25/zBO9LF7Fom/duuplmcUOdSERNWxe03Lir3v5G3T9VdKhoaNVIXctA+Z1FUk/8HZk99j+TAUnsTR7DKzcjV9PYUyqLapDBb9B5yiAkUAcg6PTALn8jj3ERxaC9CAJFHEEeTHcgxe4r2jV7oHy8JgBQmDq4ISQg+wX+U2CuaXJEmF0JR5AOtfcCTmVePvhWwHJc6POZFPsn61C2DHU2vJCAH8VGmHRV6NM9cSYdcWrWJ/4IDPxEC5a0g6SWvddM3hPkCJWDMrX4qRIkyNtsOrHWhQ==
Received: from MN0PR19MB6091.namprd19.prod.outlook.com (2603:10b6:208:382::21)
 by DSWPR19MB796710.namprd19.prod.outlook.com (2603:10b6:8:3b8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 03:44:01 +0000
Received: from MN0PR19MB6091.namprd19.prod.outlook.com
 ([fe80::af9a:4cc3:facf:9374]) by MN0PR19MB6091.namprd19.prod.outlook.com
 ([fe80::af9a:4cc3:facf:9374%5]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 03:44:01 +0000
From: Liu Changjie <liucj1228@outlook.com>
Date: Fri, 17 Jul 2026 11:44:03 +0800
Message-ID:
 <MN0PR19MB609153A4A590C66241B8A3CDACC62@MN0PR19MB6091.namprd19.prod.outlook.com>
In-Reply-To: <MN0PR19MB609154F210DF84DCB29D3696ACC62@MN0PR19MB6091.namprd19.prod.outlook.com>
References: <MN0PR19MB609154F210DF84DCB29D3696ACC62@MN0PR19MB6091.namprd19.prod.outlook.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Luo Jie <jie.luo@oss.qualcomm.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 2/2] net: phy: Add support for the Maxio MAE0621A
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0027.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:5::14) To MN0PR19MB6091.namprd19.prod.outlook.com
 (2603:10b6:208:382::21)
X-Microsoft-Original-Message-ID:
 <515b8e4afa7b419e93e749c880e1f868.1784259843215293.tspi3m-maxio-v2-2@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR19MB6091:EE_|DSWPR19MB796710:EE_
X-MS-Office365-Filtering-Correlation-Id: 62a108df-1427-4b98-8968-08dee3b5a3ea
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|25010399006|23021999003|5072599009|37011999003|51005399006|8060799015|15080799012|41001999006|19110799012|24021099003|26104999009|440099028|3412199025|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FV34PMWTP2ZXe8jfRrBgx2dzfMydw8PWK+OKBVlfOeKHgEIHVQrFE/KNh1OP?=
 =?us-ascii?Q?cEdjn8XVb9e5mGpXtvTySVWq77rM20eNuVd3lG1gMvWW948YDNwlw0mJXoGU?=
 =?us-ascii?Q?UeRTduuAWE09vsQsqSCuhj/NanRmDvpe3krcfsd/tToCRtviJI+WXkPO+nTV?=
 =?us-ascii?Q?UW34nZc+WJEnpyHE9JwsldHk4w+NVIMzAWXU3CtKWnmTz2fki2JyteFe0MJO?=
 =?us-ascii?Q?8/SGokCzt3XhngauwIj/CrQ1Z3cawd4YouwTnrmlZBGTXxNbwRGADZGGl43l?=
 =?us-ascii?Q?ZUhfjBsWARlpg0UAOXioYQezAjhH3hw3p8RGVl+hIFsxqb15o2E2JSYy7j9K?=
 =?us-ascii?Q?qjZwchJ7UegL2UzM2gy92lcFFgeQy0Hywh8bECzbjg2t172qjS37Ofyttg8/?=
 =?us-ascii?Q?W4CRSWMUMEO/o1zuUkh7bh0avKXfX515uEx/xLTk9X8YinGK0NusNIx1AMa9?=
 =?us-ascii?Q?VdCZ7KQxU8Fr5k41HGoCpj0nXz7MkQjZRfqmnOP76gEDVIkkZgX2abYh1D0k?=
 =?us-ascii?Q?P6mhWYPRuQr3zxkWFQcDQElg6F7PYf7etVBlA7uggJU57ofNYFXpxwIsmw0N?=
 =?us-ascii?Q?KPse0eosxP4eSO/RtquK6aYjaELysVIMQ3/hoivaPAc58M20mFYWHFYU5PMI?=
 =?us-ascii?Q?tIkz2bovblDaGxgXZzjAXyG7r5hLcoyYVnDsWxM3lVwhPFTId4mMRCysLCUK?=
 =?us-ascii?Q?SHeaCScLJgGl3rUECEhrQVDMkrwgH0fsHxi0xEyHoTyQRbKDxn6V7maVmBeD?=
 =?us-ascii?Q?TRcbY+OWt5ptzgnVXVjTOVm2EdqdKa0X/pUCkza3vn9iU3uCNt5yDyIt3Mbz?=
 =?us-ascii?Q?FZ0UguXwXqOJ4qGlPdGSSsr4xZK/PbsJo6igakGlGQJmL6tJrZHqVuRS4Kk/?=
 =?us-ascii?Q?dV1AB7prY5hu/XL3HzvQJfFIiGAQTnFFfEp7n8Ow2CidU0tpJTueozOmjWfB?=
 =?us-ascii?Q?yoyKL3vfS/BY0APt882M7XN9UIs+9f7BsWq/tdCkGHBqUdUe0d3TNC75Q4c1?=
 =?us-ascii?Q?NbEE?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sgDSVtpw/NliJ06KcX5PW8xufOZRFRAd3obCSTUc3hu/8hxmM6iNR/EwffNE?=
 =?us-ascii?Q?lQyoVNaH4Lc/81V72LE6BoHYXVNcB9uVhPixk2nQnfautRA9teOVDrllehhV?=
 =?us-ascii?Q?6umTh/ydc4zhn1HzK7Q93JDYTBoeOiW943S2gxAzdAW9JP6E59Rq/6AZPwgu?=
 =?us-ascii?Q?fM1fxARp2DnZfTVSyaq1tDEHxoorHzHETaIuBBklKJiWODIsDHv7VxmlAxIS?=
 =?us-ascii?Q?omv8dr1wRw+Bd80bqQTXv7AptDOow4/y8c/UB2DVQeun9imR/ihkOu81syOe?=
 =?us-ascii?Q?NW6Ejv9296xN9zmdAwOL2I4Xr7aLwSv7Vyw5vuo/9aOEcsoDy5fqhKlxqB1i?=
 =?us-ascii?Q?CugVqgBiBOHFU4AHbdsWtDsomVuszYQDyuAkOWFoyPPYxxM6TAUqNkcZGcyp?=
 =?us-ascii?Q?sIIkXaZMTu2wc26BSFa8nIJ42xg+Zn1XCg+pbwb0/FcCymqAaoG6o5jVGJdE?=
 =?us-ascii?Q?kZdwjyxga6FI60iZX8LX/ffKa2iTnyZj1lufTQWgFGh71IuNaOk1S1FRv8Ag?=
 =?us-ascii?Q?KyV6+c+wDe8VIFcy3f1SASbTI0e9kWdgmUymvX1lQCIYgH9DdiDO+PrNcR7+?=
 =?us-ascii?Q?xIg5LqV0hALfhpMye6q8bqYu7t2j32VijKNMr2YV33DU33DR1S5Li2qF4xYm?=
 =?us-ascii?Q?GjUm6dPwU7bDzvl8TcUhi3SUlpAoqO9t+bFS2oM0ZNfeoSbeoPlm+ZRwqO3P?=
 =?us-ascii?Q?l7J4c1cnxAmB+Qj1mcfk7wg0KZPUN9EBQP7UiPhwSvYq7Al+jR4Z3aFd8xNf?=
 =?us-ascii?Q?3clLcrz3eOOuL9BGhTwogFwCqSFsg9KE9YwRkaQsvPJIaGOM5sKC8fJWyhvz?=
 =?us-ascii?Q?6bEYvMScAfAJsAzB3cW+SFT2Tb22Cs0mO0Qcsh13I2/kIdgtBAMzaKrF2EMP?=
 =?us-ascii?Q?RiFMf7FyFazGfSUci6n+bHSKcbm6vDe25k4yTbO4w8qDSXtL6TTssHuu3YaQ?=
 =?us-ascii?Q?G9y3rgrskU9UA3VqmgTEKgpRaJBOpjuFriiMjmI3YhTfCohHT2ipRtHNkpUY?=
 =?us-ascii?Q?uOLk2hij41vVufidddAPm+ipsvW1ysOlL9Kb7V6uYG01YHOihI0ST+0zE7Ij?=
 =?us-ascii?Q?7sNix34kLjV/8GccIfpP61dVxHzQWvFcLF6MijXXQPbcbqIs3a/UNHhRXMiI?=
 =?us-ascii?Q?Eqte5RloGGZ2WxBvjDMuds8L1bxQDsb87lwNSb29xVqNsWKvHVcbAMP4ME76?=
 =?us-ascii?Q?CY2oI7WQPrbqqJePd+xUIJRQhxJE9staqwdO7/BujHQ4u6m91RP8CfdGS8YZ?=
 =?us-ascii?Q?c6KdWsDCqZx/qezr+owYSh4r6bn4FG9Cm1Ws5NThNGUXCPc4mpMNpFrvVR+9?=
 =?us-ascii?Q?QAkyu1YnP7o4b1U19iTJaRbr1AXbZteDjLUND0WU1PmPSQx0TVmbT0prshBA?=
 =?us-ascii?Q?50s2gmBna+8cqvBj+aRnbbMivJmOTjDfzqy6CoA3YcHvZH6lxQ=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62a108df-1427-4b98-8968-08dee3b5a3ea
X-MS-Exchange-CrossTenant-AuthSource: MN0PR19MB6091.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 03:44:01.4115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR19MB796710

Add exact PHY ID matching and optional 125 MHz CLKOUT configuration
for the Maxio MAE0621A Gigabit Ethernet PHY. Preserve the existing
hardware configuration when the firmware property is absent.

Signed-off-by: Liu Changjie <liucj1228@outlook.com>
---
 drivers/net/phy/Kconfig  |   8 +++
 drivers/net/phy/Makefile |   1 +
 drivers/net/phy/maxio.c  | 103 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 112 insertions(+)
 create mode 100644 drivers/net/phy/maxio.c

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 099f25dce..32e1a035b 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -283,6 +283,14 @@ config MARVELL_88X2222_PHY
 	  Support for the Marvell 88X2222 Dual-port Multi-speed Ethernet
 	  Transceiver.
 
+config MAXIO_PHY
+	tristate "Maxio Ethernet PHYs"
+	help
+	  Support for Maxio Ethernet PHYs. Currently this driver supports the
+	  MAE0621A Gigabit Ethernet PHY. The driver optionally selects a 125 MHz
+	  clock on the CLKOUT pin while preserving the hardware configuration on
+	  boards which do not request it.
+
 config MAXLINEAR_GPHY
 	tristate "Maxlinear Ethernet PHYs"
 	select POLYNOMIAL if HWMON
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index de660ae94..7fb3626f0 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -70,6 +70,7 @@ obj-$(CONFIG_MARVELL_10G_PHY)	+= marvell10g.o
 obj-$(CONFIG_MARVELL_PHY)	+= marvell.o
 obj-$(CONFIG_MARVELL_88Q2XXX_PHY)	+= marvell-88q2xxx.o
 obj-$(CONFIG_MARVELL_88X2222_PHY)	+= marvell-88x2222.o
+obj-$(CONFIG_MAXIO_PHY)		+= maxio.o
 obj-$(CONFIG_MAXLINEAR_GPHY)	+= mxl-gpy.o
 obj-$(CONFIG_MAXLINEAR_86110_PHY)	+= mxl-86110.o
 obj-y				+= mediatek/
diff --git a/drivers/net/phy/maxio.c b/drivers/net/phy/maxio.c
new file mode 100644
index 000000000..d2cb23895
--- /dev/null
+++ b/drivers/net/phy/maxio.c
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Driver for Maxio Ethernet PHYs. */
+
+#include <linux/bitops.h>
+#include <linux/module.h>
+#include <linux/phy.h>
+#include <linux/property.h>
+
+#define MAXIO_MAE0621A_PHY_ID		0x7b744412
+
+#define MAXIO_PAGE_SELECT		0x1f
+#define MAXIO_MAE0621A_PHYCR2_PAGE	0xa43
+#define MAXIO_MAE0621A_PHYCR2		0x19
+#define MAXIO_MAE0621A_CLKOUT_125M	BIT(11)
+#define MAXIO_MAE0621A_CLKOUT_ENABLE	BIT(0)
+
+struct maxio_priv {
+	bool clk_out_125m;
+};
+
+static int maxio_read_page(struct phy_device *phydev)
+{
+	return __phy_read(phydev, MAXIO_PAGE_SELECT);
+}
+
+static int maxio_write_page(struct phy_device *phydev, int page)
+{
+	return __phy_write(phydev, MAXIO_PAGE_SELECT, page);
+}
+
+static int maxio_mae0621a_probe(struct phy_device *phydev)
+{
+	struct device *dev = &phydev->mdio.dev;
+	struct maxio_priv *priv;
+	u32 frequency;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	phydev->priv = priv;
+
+	ret = device_property_read_u32(dev, "maxio,clk-out-frequency-hz",
+				       &frequency);
+	if (ret == -EINVAL)
+		return 0;
+	if (ret)
+		return ret;
+
+	if (frequency != 125000000) {
+		phydev_err(phydev, "invalid CLKOUT frequency %u\n", frequency);
+		return -EINVAL;
+	}
+
+	priv->clk_out_125m = true;
+
+	return 0;
+}
+
+static int maxio_mae0621a_config_init(struct phy_device *phydev)
+{
+	struct maxio_priv *priv = phydev->priv;
+	int ret;
+
+	if (!priv->clk_out_125m)
+		return 0;
+
+	ret = phy_modify_paged_changed(phydev, MAXIO_MAE0621A_PHYCR2_PAGE,
+				       MAXIO_MAE0621A_PHYCR2,
+				       MAXIO_MAE0621A_CLKOUT_ENABLE |
+				       MAXIO_MAE0621A_CLKOUT_125M,
+				       MAXIO_MAE0621A_CLKOUT_ENABLE |
+				       MAXIO_MAE0621A_CLKOUT_125M);
+	if (ret <= 0)
+		return ret;
+
+	return genphy_soft_reset(phydev);
+}
+
+static struct phy_driver maxio_drivers[] = {
+	{
+		PHY_ID_MATCH_EXACT(MAXIO_MAE0621A_PHY_ID),
+		.name		= "Maxio MAE0621A",
+		.probe		= maxio_mae0621a_probe,
+		.config_init	= maxio_mae0621a_config_init,
+		.suspend	= genphy_suspend,
+		.resume		= genphy_resume,
+		.read_page	= maxio_read_page,
+		.write_page	= maxio_write_page,
+	},
+};
+module_phy_driver(maxio_drivers);
+
+static const struct mdio_device_id __maybe_unused maxio_tbl[] = {
+	{ PHY_ID_MATCH_EXACT(MAXIO_MAE0621A_PHY_ID) },
+	{ }
+};
+MODULE_DEVICE_TABLE(mdio, maxio_tbl);
+
+MODULE_AUTHOR("Liu Changjie <liucj1228@outlook.com>");
+MODULE_DESCRIPTION("Maxio Ethernet PHY driver");
+MODULE_LICENSE("GPL");
-- 
2.55.0

