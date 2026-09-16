Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19010016.outbound.protection.outlook.com [52.103.23.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A0D3C9EE7;
	Wed, 16 Sep 2026 10:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789555329; cv=fail; b=N8hXqNw37Dyvg2T3PghP74l+RQPEZ9sdvLFLZ5CQJW4tNhv1dmbI19OllqO4+Kym5m1A/J0/SIvMoXZ+ymN6kLU3bC7L8PG8zATrMZD1I7jKh2jrrOCy2qWNNCKhvQ8E9szwZl1BSLCe7bsL3DdTP5YfsFkBRh3zSjt3LvZIsBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789555329; c=relaxed/simple;
	bh=QaQze5Ig7BiPdIggULcj2mSArh+v4uYlkbLVnT8rPbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b1BighXZ7x9g2/jQikwnDYszjuzUn1BBDQcnr0SDrrprArUKTT4ariOgwuzgsWX3qlTWeGoZYsmQ7lqF+a5/SReSNy097XylqD/DA0utI0kxkpVefCm0JZfcM9A92GAw/FIBxqaPr6fhK5mnQz6wYu+iTRT5MeKsomx0hI/60+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=nyF5L4+Z; arc=fail smtp.client-ip=52.103.23.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="nyF5L4+Z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VANnjZgKUQEt3Ggfi77NUPRDdHlQut9REszWGNq7hgROckjhB8LEYIHY2panPNJHBirFpUieWh9/ixczpTH+VZgPb44QdwrYT8FDREQxAVuMNZsbRywORK7ec6zMi6tVpI2MNz53G6+Vf2BQOYVuAu0WDnrPzSz0MDOVYIGiur24R5NzfhRxedX+8EVaRHEFS9EMXhi9K423ToicOo0kHfw81VinWc6qTj8rUNQWSOU41+m1FJ1b8Igf4mHBMuTba7veWIGE5oQqrRq5OOt7JxZ7usO8RbzdlybdukKIvz5ESq31Ze4KjNfxsKGiuM3Lw5fP4gVQ49BnZ9jS22bUtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8se4f0aqV1qe8gCR9yVVUIAn2nGe+RZDyiN/6ma2s6w=;
 b=PknZIQG6weowB0CTYh/U4k7Qt4wndftdWkw8NKNMvkNp3TScQ93k3LraHzY6RU5VyemYLfV6TvQmpKVo+XqRhvxZgc44ZKOcGC2qF4fICg31ehWqm8OLjLQRkPsgfqL8lgPYR5jSK7zy+alIoEefviXd7342iL1Q3NDVhDdabtVbFedU1a9xK/bu+YijyGq1Yu8M7V8n9XO3e/OY3K8Ev1IhoCblQa9SMQ3P8A5gVJ2MWpcOCDxXFtTSlNBmLWRfVk7Ee7/EfJj3SZXzIG9l61GJNbyv8PFb4gQ9lcAep9ce3pfz5uZLgjIKaeVv6QsebWrS964kKlwI2+EVJSRoYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8se4f0aqV1qe8gCR9yVVUIAn2nGe+RZDyiN/6ma2s6w=;
 b=nyF5L4+ZdkjW/p305vixbEGSWXrTftrkvLcZo0B7qlcKR0TkDQMQdBxMggaHA9YIhuFWHasBzsKTjXFzv8iOMCVIlSy+bHOdcuMLwvFRyN3tOxlwa/wrQeLeroWDndv2KE625lC1Zy7r/XIJ2aSgSojozkSYzR9ZMFH5S0MmZ5/oSfhlpR3d32JOQ9NDSHZoCntOwGHnx1kIgCea+EffeHLfABz9A+ekP04WM9ntzQHNNBzEdr4WtjetOH0gOMB3tTl3AqjvIsNlpGEXCZCiq6SGEcMntij2XDdJnqOfG23p+WJq8taF9/iAV/4lM1bamKSadFmfOU6uL7W015b1SA==
Received: from CH3PR11MB8413.namprd11.prod.outlook.com (2603:10b6:610:170::8)
 by SJ1PR11MB6129.namprd11.prod.outlook.com (2603:10b6:a03:488::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Wed, 16 Sep
 2026 10:41:30 +0000
Received: from CH3PR11MB8413.namprd11.prod.outlook.com
 ([fe80::5cba:cff:2a19:7d1d]) by CH3PR11MB8413.namprd11.prod.outlook.com
 ([fe80::5cba:cff:2a19:7d1d%4]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 10:41:30 +0000
From: Thomas Karpiniec <tom.karpiniec@outlook.com>
To: netdev@vger.kernel.org
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>,
	Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 2/2] net: stmmac: qcom-ethqos: advertise supported SerDes interfaces
Date: Wed, 16 Sep 2026 20:39:50 +1000
Message-ID:
 <CH3PR11MB841353E5708DDD7C5E2EA1D5E4B92@CH3PR11MB8413.namprd11.prod.outlook.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <CH3PR11MB8413FCBA598F7FABC04ADCFEE4B92@CH3PR11MB8413.namprd11.prod.outlook.com>
References: <CH3PR11MB8413FCBA598F7FABC04ADCFEE4B92@CH3PR11MB8413.namprd11.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MEWPR01CA0033.ausprd01.prod.outlook.com
 (2603:10c6:220:1e5::10) To CH3PR11MB8413.namprd11.prod.outlook.com
 (2603:10b6:610:170::8)
X-Microsoft-Original-Message-ID:
 <20260916103950.41510-3-tom.karpiniec@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8413:EE_|SJ1PR11MB6129:EE_
X-MS-Office365-Filtering-Correlation-Id: a7afb1e5-9609-4187-a297-08df13df10f5
X-MS-Exchange-SLBlob-MailProps:
	xgbIMsDSu2bc7yhuK2afLsfZGs5LbJY2Z7+PXUZvlRFKBkqqI4Degu0jBEbZGh1dCWJvXQnQ4i7fwYSelPnsT728z21pXhj6vnHwckUQt7lyls483W1jqYhvoKhJWUieKpfH5eXoRC7NaSR1NAcqHnQVCtWBl4ySUFgmCdPoW5GDKxq0pPO4qLxK4sdaBxVwMJZzja46Fb4Nstwjdarq3oRshFrmVxGoPQjWZS2OAu72Sjw1XQGn4VNHa2/xy0827OGpZPn1XbryMSdQTxciKmfbwpd/j+ZfqHa6OK+68hwN6RmlCugdxl4XGhySUV3Au2cvjIvrSbmoX6PsTvr65XIp5JYCuH/2Bz9OigJQmLa8MGMXUsnRSiycu8VY+bBmHUmX/dMWLxQZ5UZyqCq+fJ7PT3YYNEuJGFoXPB5THwXB95+ChuowtMS3OhjeDTYw/Qt74YV3Nt9bP3Lhko8Vjs76CS9MlHvtcDZkXtJLg1ys54U4pFWWG6HCWQRzFCcSgZQqTIfjS5iMYYAWfvI5IoZnyt8btCG9Gi6Hn7Zenm8UQVzUi8sP5SqnruxQkKBcvL0DqJH867swhBOqA3EW09AFkntxPekccJY+kXiIk+Dqoxmjg1qTSOVFxODcuuyiWaf0NdcP4Awit0tjSF//0P2lCCAPSSjixjeUhf5mXWcmAoODHVSU6TpJVqi0Uri9ONhc0jkECjN9LBRZZO88cp4rHsVJm+HGx0jhhUZ07HyVLMAP+g4wowt6V1f7LPskXVSHymOaEKsQI2MfjqhvP7E4fLrEJLvI
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|25010399006|41001999006|19110799012|8060799015|15080799012|51005399006|37011999003|24021099003|23021999003|440099028|3412199025|40105399003|2607281247196008;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ytQi/QZlRt5+cuedKG0ek1Y/lod+Y5JZF2H0a++5NKS3D+ZH+DrROV1fu3v3?=
 =?us-ascii?Q?coijaFm7+4f1ZUujltp0jE2sCEumzqZkeXofnBetYAzFFkbONsKgaRD8TZaY?=
 =?us-ascii?Q?4g6pVIJWV0O5jX9JFP+LC0oh17UrQmT91pdLnjP07LStb+MFKsePCHDP7uD3?=
 =?us-ascii?Q?DPGrH0ILFNSjq6L0r57X1HY2cdwilAWXHIr/DiSbX3jUyZ8sIKVPhf2coXOD?=
 =?us-ascii?Q?MxC1yyy/d0SxCRGjtqREh8IxuEYpTV7h4WcO381gW3HvaMJTwe0xijSwUQfl?=
 =?us-ascii?Q?OuYHhW2pS7xDNHYPDtuLivHWxLxR/It/6Ft3eiGgiQSllFyRuYmte2kpYl0F?=
 =?us-ascii?Q?B2S3DKS1aZR6yn4+RmcX85OLnJFoEVKBYiuJ6/xJcVECZ1IbYDDVkERc1/Ru?=
 =?us-ascii?Q?5+OboOSoTZ+U7im38VGUId7jvTC9nQPH9lKXTmSZMcm8vcSScYDr/84PmjND?=
 =?us-ascii?Q?ADyL6jL5/juJONl6Zz5dYl5Qe5MT4A/aX09lWl8MTavWC1+Jo6Ng4oXvuIrL?=
 =?us-ascii?Q?gOPddFn55rOZ5/5kTtTTieg/FL8TAK+4eju3YJ5t9AmO3vDSLOAcW38Dzpp5?=
 =?us-ascii?Q?nujxnHd6qDbKX0Ko69bi14KN6h2OLAC8oL0PBOhZRUJqS6AaL5UhVYGbxL/h?=
 =?us-ascii?Q?KZnZBWoCjV27zSYx4TR11J8hYafjNxPb55kyDgq5CcxY6A9IAtIjx2sHcREP?=
 =?us-ascii?Q?9jlvJp3+aRHNM/pMrvK6JXU9THat35qnEnyNlywD0H60RyK0E7ZjNtVytDa8?=
 =?us-ascii?Q?0F0Cz7PMh8Tn0d3Se+MDZ4KfQkNi1xWAlijfnymkxPEJAEY/nS5YYSikQbaZ?=
 =?us-ascii?Q?kN4gdVjJFxZCG7VApPH9w2295TNsj4eSmYblTy6YqXj5v8ns5Fo+UGkL5Vlv?=
 =?us-ascii?Q?/9ShljySTb6VaM2ufnCToOXLlRHM/PTvxbJeLW+KPe6GNHx1sRc14w9PjqvV?=
 =?us-ascii?Q?Wf6ifJMDsrqhFP7n3PQVmRm7/Mfj/t+9pY42keMbNLEy7RL5DXgZ5YKT4Y4k?=
 =?us-ascii?Q?YRS2?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X/Koke3u/quN15h0hIAWpcNxjqLSOTu6WR3nQkuFIxvsQXqBtVy/QNxXqqSB?=
 =?us-ascii?Q?QztRqOR2lLu65QxCMLHFrcnl8xXviHQOL4x6MsWC9a94QS9Xfq8ercQ1932G?=
 =?us-ascii?Q?VMAt4vBDiTcsm3uncC8R7kPzv7kZ818ygSSCNBg6nFWlOSKfL11U13Q5Ky7n?=
 =?us-ascii?Q?txVqDm0CF/fbPJpahbV4ybts+vD8tbVh0LIF6VK24lg2QWubZpBpVfsqqe8W?=
 =?us-ascii?Q?uj+ODTCnRsddlrx9PZb02AF8lt48bgcjto3hV5qUw2klVJGIkpmUglUlvelR?=
 =?us-ascii?Q?0EYpZoKBZHjLjuXjeNonc12UcF+hqQnzoWC8zv6tQTE4Uo5gl9wsnL0hRYVi?=
 =?us-ascii?Q?CIJFYkk8To2DQoBtp69T+KwHc7ysjixDxUTv/ISXITf/312L1ZsoxMPGbo3T?=
 =?us-ascii?Q?yQXXS6h1jxx2aXZiwvEET1QeU+8IKaB2ik4Oks0R8P2iZQ6dITCz29zCMfMu?=
 =?us-ascii?Q?d44GqWg1vDcnHJi8LJGTvW08zNx2EQtFWmrk6hQ8Or2+lA8GrADKlbYApHGD?=
 =?us-ascii?Q?XImRm+9rSp3f+Q4yltiR0UCULxqLE19FrOYlnfsSNOglu5e27Pz5Kc8Qhfk+?=
 =?us-ascii?Q?C2wSAeumA0n31mkx8x6ddscyjcJ1nKTV3SiwMT6gznqjyNg96dHIOrkJSAvY?=
 =?us-ascii?Q?47n4P77BYS/LEWsvWx8HyME9wuD9uS1fyPhNcnRNmi5o2TxlKnhw0x5JJ9uE?=
 =?us-ascii?Q?k/lXaMCpjmhJ2Z7wXP5FZ0G8jRB7IMg9Xgzn24egvCBiNlrJEcTgeV4RD8Dz?=
 =?us-ascii?Q?+D6IxSq8heerjsg3vBYnL+st3ijQF2LyHKtjyjtZhov3kZPb4BV3qc7pNBqu?=
 =?us-ascii?Q?NViUQcxZz4i3BSf9H7K1pVQP3WogBCW6EWZSJk+ovV/jYeK4+TAl5xfDBldT?=
 =?us-ascii?Q?64wWhT0KlEyWB/2F3nyGnthntuaUtCMVmaHhojsdqxYobD04SKODktI3yl9F?=
 =?us-ascii?Q?mUcNT95u8Riyvnwsj2ngSZNiOCUHrcZTSAKC6T8ts5zqgn5t634Xdy+DCyMZ?=
 =?us-ascii?Q?aIODLICKRAmxWJ2HxSjqf12yHYKRHAeenmhka/odXOsx9QdgOSkzA3uUpGM5?=
 =?us-ascii?Q?MJCDzlYiXFZvEskfWskB5D+EHfgJYgSGyoBnLJmnX8zCo5b5UPtR0U0IpRWY?=
 =?us-ascii?Q?1BjkZZkrz0hkcv0u4bS1mF2A5ZAJ5J9ENXWw+AFNhGEgPVyvkorVwnevEPCV?=
 =?us-ascii?Q?7JITEaklP1y8adHST1+uTuZXrdGR/piMEDuL4N7T0G4gHyRV+VttKEzm6SjO?=
 =?us-ascii?Q?a7Axd5T/6+gY1QQLy5Slz7ak5P8Kjswm8aA9cqm/3qAV7husBRtdc9xAPfjr?=
 =?us-ascii?Q?C8FzJczjQMJzkdJDNvdP8jPNaN7OjStEL/XpqbXcPbpRP1Vp8jd4HfKPatak?=
 =?us-ascii?Q?jJSu3GL7yyDRUuuKYWNtAvXIprZmNMrbl0OYVvtAJEo+sJTj9G80Yhz2AcYu?=
 =?us-ascii?Q?JIaKw2zUdw5JLEgE3pNUaK1XTsx+Fvhx?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7afb1e5-9609-4187-a297-08df13df10f5
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8413.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 10:41:29.9710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6129

From: Thomas Karpiniec <tom@wendy.sh>

With a QCA8081 PHY and phy-mode = "2500base-x", stmmac reports only
2500BASE-X in phylink's supported_interfaces. Phylink consequently removes
10/100/1000BASE-T modes from the PHY's advertisement, preventing a link
with a gigabit switch.

The QCA8081 uses SGMII for lower copper speeds and 2500BASE-X for 2.5Gbps.
ETHQOS already reconfigures the SerDes in ethqos_mac_finish_serdes() when
the PHY changes interface, but does not advertise this capability.

Provide a get_interfaces() callback for serial interfaces. Add SGMII and
2500BASE-X when the SerDes validates them, allowing phylink to retain the
corresponding copper link modes. Leave the existing stmmac fallback to
the firmware interface in place when no interfaces are reported. RGMII
configurations are unchanged.

Fixes: 61e9be0efbe8 ("net: stmmac: qcom-ethqos: add support for 2.5G BASEX mode")
Cc: stable@vger.kernel.org # 7.1+
Assisted-by: LLM sparse
Signed-off-by: Thomas Karpiniec <tom@wendy.sh>
---
 .../stmicro/stmmac/dwmac-qcom-ethqos.c        | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index ac7d6d3e205a..3493e090f1a8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2018-19, Linaro Limited
 
+#include <linux/bitops.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_net.h>
@@ -564,6 +565,26 @@ static void ethqos_pcs_set_inband(struct qcom_ethqos *ethqos, bool enable)
 	stmmac_pcs_ctrl_ane(priv, enable, 0);
 }
 
+static void ethqos_get_interfaces_serdes(struct stmmac_priv *priv, void *bsp_priv,
+					 unsigned long *interfaces)
+{
+	struct qcom_ethqos *ethqos = bsp_priv;
+
+	if (!ethqos->serdes_phy)
+		return;
+
+	/* PHYs such as QCA8081 switch between SGMII and 2500BASE-X with
+	 * the negotiated copper speed. mac_finish reconfigures the SerDes
+	 * accordingly; let phylink validate all modes that path supports.
+	 */
+	if (!phy_validate(ethqos->serdes_phy, PHY_MODE_ETHERNET,
+			  PHY_INTERFACE_MODE_SGMII, NULL))
+		__set_bit(PHY_INTERFACE_MODE_SGMII, interfaces);
+	if (!phy_validate(ethqos->serdes_phy, PHY_MODE_ETHERNET,
+			  PHY_INTERFACE_MODE_2500BASEX, NULL))
+		__set_bit(PHY_INTERFACE_MODE_2500BASEX, interfaces);
+}
+
 /* On interface toggle MAC registers gets reset.
  * Configure MAC block for SGMII on ethernet phy link up
  */
@@ -718,6 +739,7 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 		break;
 	case PHY_INTERFACE_MODE_2500BASEX:
 	case PHY_INTERFACE_MODE_SGMII:
+		plat_dat->get_interfaces = ethqos_get_interfaces_serdes;
 		plat_dat->fix_mac_speed = ethqos_fix_mac_speed_sgmii;
 		plat_dat->mac_finish = ethqos_mac_finish_serdes;
 		break;
-- 
2.50.1 (Apple Git-155)

