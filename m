Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011000.outbound.protection.outlook.com [52.101.65.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9336A282F31;
	Mon, 20 Jul 2026 02:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784513556; cv=fail; b=N0UyufQF6eOzz2zSW41g6tN49K5lfvSfiOd/e6ZYYKG6MOSZbZfP4meduWb9A4W5nxdAIhiSq4MbWURFeFu43RxIHyRjmPKMOP+P4TE9TUIT+zk6Q3sMbLopzsuIKlFeLrQgvZJaGxohj7gLETSS9eVxS3Y5dNEKwUKvTN4ujAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784513556; c=relaxed/simple;
	bh=x7QV3iIUNRnxRXCk/oldPF4u41FSOumCXvO19VM7Xo0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YhtchmTnIuZNOXXOnwcsxOIkIgOZ7dwIqGECNZ6F2zpty5vNt2nAY6pBuCL82SfRhRYlYTRXpKlV+kxk9Js8RbJ3Ai5PZX+8NE1omCsiErgfV5DAp3pNrt/Q+w9wfihEhu+3yPA7iR4uVTpGqtdb1Kb3MKB8nNDeEzH7+vql40c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=P2A5JcGJ; arc=fail smtp.client-ip=52.101.65.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="P2A5JcGJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YQffViAZcM1eN9kTjFowgfl0ZAltSmoo32neQ+1F6zYCfwcnsPzPQ0uLzUjoei5VITf441AIparXbLr8bVCY6nFTvQLGjlyCDqHj83EM22keKiCcD/C9qPWkfvTl/EwPYoUyWEJdMKwUmJ/4kFj1eDcuNL/aJ8HAjrd+D/kxlvJ0IEy2B5FZC/6RYDbWgKsZoQU+Ow7RbqHMEoNKbXKqOCsWBVUUfPV88jASD+Hh5Mocioe623rIt5PuP53dzRVi5YBXOKgcDaxdOQbWmiC4AuKrbKnZjD+FNjUTai8oyH3AypN03QT+D8SMGPnjCnj3y3aC14lPMoqMviTVHOhEAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zpnnp1ejX5Oa/Yy6yvmaD7X3n2NEc28KsJx7aRM5cgQ=;
 b=DnMvFVySwi2lLi/kZvTtjmK8Iz9n24sGqvaFRximlQvjhBfpWZf0Ew0AvIYs2kfQKiq2EywDG0iBRysuRqFE9NZastQR8TiLHj/8zYcno7qpOqbUo2da9cZontKx+Il1tYN2cMp8eqV/dg5hJb5U2Yw5IfXj0SZ7pvvD50DOQNvdO4F987hDGX//UoBPm5v0JnyBXEfjdAuaI0q7Tt3eTbBx6UxyI/Xeknhpd8pFM+7TcF523pES2ew6izM7kRFoQTNkwPYqmKuov6RxCiR+s6uwciQZs3zMDMLKKrJTRElu+PwGBaMeO5E/gNBSx0A9oUNPa2zYEzejOwPWi//W1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zpnnp1ejX5Oa/Yy6yvmaD7X3n2NEc28KsJx7aRM5cgQ=;
 b=P2A5JcGJp7Ox213XwidftyftX7ABuBiYvijQqusfZ183FDY+IGziQEZDe+YplWGohQ4pl9E8ZAbiFyWVaucDb/UzYG0cTlg7XpfPK4Adm4uYrzEWqXqUqeb84Ajdp3r1INUZtE7lkeRv8I7hTcwdRifgUHeFVnc3QMsW/UEmR9PlkUTWsZAMRzRzYKx9BbxbaXVLnSVSXOGgJHbcJMsCfGS16AiZGvW82JbJWeQMTjXQCoMD78HycVZKpc1hQ2/k0bbwZk/66Lw7aUUNhEI4W7Hb2uCJznsXaFCamIC/veQXCQvvWk/4+Tbsbq0IVlc/rUuid/eaS0NEVhYI9+Cfww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by GV1PR04MB10872.eurprd04.prod.outlook.com (2603:10a6:150:20e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Mon, 20 Jul
 2026 02:12:31 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0223.015; Mon, 20 Jul 2026
 02:12:31 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	wei.fang@nxp.com,
	chleroy@kernel.org,
	maxime.chevallier@bootlin.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH RESEND v4 net-next 06/14] net: enetc: simplify enetc4_set_port_speed()
Date: Mon, 20 Jul 2026 09:43:08 +0800
Message-Id: <20260720014317.1059359-7-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260720014317.1059359-1-wei.fang@oss.nxp.com>
References: <20260720014317.1059359-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0021.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:179::10) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|GV1PR04MB10872:EE_
X-MS-Office365-Filtering-Correlation-Id: 60764723-d4ee-4205-6c20-08dee6045acd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|19092799006|921020|18002099003|22082099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	CalHs/C1SW/uOFFDNXqGmqmJDgWsneNT8YQLCsVRfIayp345GF7mnXun7YKHhEUzzdSMDhPdY0IBn7PcHQjacJNmjr7IVTfvDZ6jNMBgO3gCqm9Xl5ij+5U7m2sgK9MRDVH1RxKAE6GstAVy7+15ETQsIT1EIpX9Dn8jg6tIPpZS48a6BcZxMCdmlR9OV5p3q1Wcc3lIbeac36zR3p2AkBGvF+AwqtZ2ugNv5xWyBcoDvIvWHgpOC5FbepPyw3RMzERiPsnXJkLg9XcVphLXGAmHcd8ytKJe8dvZgP4PwakshRfnfztj7k1ZL51o6WhRIBRJIXnsHi1VNU589FoX4bvjt+QcC7PXqQjea/A1uWGcrd5tkSuPYmBIYn+dA67BRL1aXxYE6rPYnBhFH0kAtf1Vcf8ikoK1gF8rLkHBZDpRn4DbifI8mxGqK1WMCnO9KHXBQZyfSf2/aV7ViAhlSFlF7pcnhXyZDPv/LmlpiEu7pboew8GPd/iuL0p9tsvDnfcJXK90hOVHBHTCLhnOJy+uqmpUC3rvs3M9DMLt7csKD/UPYhKgmlCPf9w57daoQOlhpUXJLxaqy9mQXH4BFjWfHorLQ4mSlNDRT1T0rMSHZ/MDEikTlpUKy6YtrH3AfGrtvXEb70afF9JvrHTl5/68iQOpYtZJg+d6ebecylacN597XUzs9tjJ/fM/spiDSk/fZNl7f3D9SCrtRvx62w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(19092799006)(921020)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KgcKQgXO1Tw0+NuQTeuSH9WuOHWATiZuYvCtEl+3+BKSH3ZQgzhoftDSlRFs?=
 =?us-ascii?Q?YrXqEMkUyMI8E9w5C4Tg/+ol97aLVPPiDHbGwrYQ2S/3b/bNda83yw6cH16p?=
 =?us-ascii?Q?XXwsutgbDlaycphsEebTQQogrKn0zztv9Jbv/GHGd+F1mZyUcxryXED7eI9i?=
 =?us-ascii?Q?pj4+So+cDboRfasPEoFoNszb012GLND/2lMbkqCb3fubtf4s4FNA1qOd5zRR?=
 =?us-ascii?Q?72LuQ/6h7kf5tT8emDcHyu63dMLKS5H+AY/Fjrgx0j2NpnwHpAZfi47Z5G8y?=
 =?us-ascii?Q?8J/sxZzhN9l6rLXQdgITMqn8rNcjRaKieKq0ya4ls+dqzfIp24AtJgAao39q?=
 =?us-ascii?Q?QCW7hLCVjmAwndjqzY4VKIxawgTHjVlzTUmtshqZd2RpUh7FZKI7HQGDjrTs?=
 =?us-ascii?Q?elK4PNA2X+ewisaj74QY+RQVvzVZJLBKHzLQBQsdOq40VQrLf3oJbJI8CMGi?=
 =?us-ascii?Q?jKCx1/866DVieoOY+nnVHgKCyhUsSD7Y//+XP3VOS7tI95ZPXh5JOBK+kwDA?=
 =?us-ascii?Q?6v8R1nlx8JD/+T1y5oD8ZF6d+6vRrzo54J37zKHKicMCoZfHHZWPVSzuo3BL?=
 =?us-ascii?Q?DhdXkObqyc3FXQyNwJBYNSfwO2O0f1KJPmTRvgQNA0YQHZKdGtHAWInOYYx5?=
 =?us-ascii?Q?F71ni3HxCDMTOibylAYQQsuOXJM9WyAPkDTLdocxpQ7l0xmTGCiAwr62UXBa?=
 =?us-ascii?Q?0xq48Tu7Chvla0B8rl9MVIe1RXt3w32NOXBDUsw6KY30hyNpcG172vEBhImP?=
 =?us-ascii?Q?UKbiVQdy4lxlz3W+V7O+Bo/mamgjX6wdbozf/wdW3SwyGHPYYRXTsIUgNeyk?=
 =?us-ascii?Q?Nx1/sb9F6HnP0Nmdka2M0uX06By6lPYpwmOHP/Ig5SUdCN1uKI4r/HIPCf8A?=
 =?us-ascii?Q?xUzysBBTzaRDlOE3r6DsZd9UdiMwjZLTcekr+/twkj7jI2rlljDg12ioKd9U?=
 =?us-ascii?Q?DNXv+xxdpvt0Q9dCLmYmHxQwzR8+pVButdIcAYvwXyUdjZsKvmGW9chAN9y4?=
 =?us-ascii?Q?35T7zy6IH/7rvDDyGNnlfNtF6kC99RX8LtiFCMhKgwFf5wpXIpgektPFDbdx?=
 =?us-ascii?Q?dQoc69GPe861/bzL3otA4mjE56kaYP0IttZy0sObmJngun+r6V6tpKeOvb9T?=
 =?us-ascii?Q?dIIKZiVdxO7Oe1ne59GzCp0q6BpbiC1xU0Jouz48WlueN3ZwFKfJ6K5IjAuv?=
 =?us-ascii?Q?l5jSzz5EWpHzwhFnXoqcjHLLaNUueXAOTxccR8W4pKnL2LNsRGjPFfnaDw//?=
 =?us-ascii?Q?bdyCM4pcaVZBo6/rBx/Dhd9ZpYJT3PhyWdAlLua5lKupNM3kD6Mh/dqRi2BC?=
 =?us-ascii?Q?KLrE7Yb/XexZEkTZsZ3ne3bOw6PyCnqrFvY4yGhk7m6aEzZ6detbADRIy0t0?=
 =?us-ascii?Q?3hnoH0G58ZIVX9eFIXKR7P68noDEzZbcfTW8PoXogEoMVCES5eZGDud+N8J1?=
 =?us-ascii?Q?7nKB4CQ3gwh5kwGSFEVFkz2mnIYDI/ShMK6yJxv7TdWuLTrOYZa5HDrXZVKm?=
 =?us-ascii?Q?i0mqycwMFjszO/W/3rkS3oWW1IZ1hRQ1HlJCwZFETJ9wCcW4i1zluBUdMmfm?=
 =?us-ascii?Q?fdkdfrU3aubDfg+ix8t3zvjffrnT6oxq5fI19svJry0BesJsiK/B0nLDrRcA?=
 =?us-ascii?Q?KeYjj1QAN5EqleFxqFIX7LDWCMjMSth40ThfaLO8+3E7ZR84pkzVf1wRPQGF?=
 =?us-ascii?Q?mJJrALwm4VZXmY9MxjGzm2vm5CRa7l4+DsW48gyt+jb99k/GkrMTreFk7OyY?=
 =?us-ascii?Q?hXzICb1BOK+yGmGcvyV3Q+0yJnMOcU8sZPYvne+WMJPN6DR3GCQn?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60764723-d4ee-4205-6c20-08dee6045acd
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 02:12:31.2138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CUoUmc2D6QtX8cqct6PhD0qKtsVsX1SuUv94tVi3uB6LufIQpiDWiG/3nK6hqtiGc8pjo/lx+3BEvy0jcjNQ35wJXo3tCj3ASV4ILR+o/zOxhfB0A7p0FOXCbTrURNSY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10872

From: Wei Fang <wei.fang@nxp.com>

Since phylink may pass SPEED_UNKNOWN to mac_link_up, handle it
explicitly by defaulting to SPEED_10, then replace the switch statement
with a direct call to PCR_PSPEED_VAL(). Also update PCR_PSPEED_VAL() to
use FIELD_PREP() for proper field masking instead of an open-coded shift.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |  2 +-
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 25 +++++++------------
 2 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
index 6a8f2ed56017..dea1fd0b8175 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
@@ -148,7 +148,7 @@
 #define  PCR_L2DOSE			BIT(4)
 #define  PCR_TIMER_CS			BIT(8)
 #define  PCR_PSPEED			GENMASK(29, 16)
-#define  PCR_PSPEED_VAL(speed)		(((speed) / 10 - 1) << 16)
+#define  PCR_PSPEED_VAL(s)		FIELD_PREP(PCR_PSPEED, ((s) / 10 - 1))
 
 /* Port MAC address register 0/1 */
 #define ENETC4_PMAR0			0x4020
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index b966637572a7..f24269a48c26 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -628,26 +628,19 @@ static void enetc4_set_port_speed(struct enetc_ndev_priv *priv, int speed)
 	u32 old_speed = priv->speed;
 	u32 val;
 
+	/* If the speed is unknown, use the minimum value */
+	if (speed == SPEED_UNKNOWN) {
+		speed = SPEED_10;
+		dev_warn(priv->dev, "Speed unknown, default is 10Mbps\n");
+	}
+
 	if (speed == old_speed)
 		return;
 
-	val = enetc_port_rd(&priv->si->hw, ENETC4_PCR);
-	val &= ~PCR_PSPEED;
-
-	switch (speed) {
-	case SPEED_100:
-	case SPEED_1000:
-	case SPEED_2500:
-	case SPEED_10000:
-		val |= (PCR_PSPEED & PCR_PSPEED_VAL(speed));
-		break;
-	case SPEED_10:
-	default:
-		val |= (PCR_PSPEED & PCR_PSPEED_VAL(SPEED_10));
-	}
-
-	priv->speed = speed;
+	val = enetc_port_rd(&priv->si->hw, ENETC4_PCR) & (~PCR_PSPEED);
+	val |= PCR_PSPEED_VAL(speed);
 	enetc_port_wr(&priv->si->hw, ENETC4_PCR, val);
+	priv->speed = speed;
 }
 
 static void enetc4_set_rgmii_mac(struct enetc_pf *pf, int speed, int duplex)
-- 
2.34.1

