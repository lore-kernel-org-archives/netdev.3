Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011045.outbound.protection.outlook.com [52.101.70.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948733AFD05;
	Mon, 31 Aug 2026 03:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788146608; cv=fail; b=Ks2xEo2A6vTYW5jOi1zihE9TsgDBFb0yCKRezCNO/v/NUv9GFxd2OdaQOmxUO5u97SJnCaDuvw2FYvxnc+JaYftGfPqt9FN9AKvg9/BLfHlnNZiDHZPSIaHlIov7KS8RKKRAS9P8R4GbnaVyCXePRGddPtaD10ekDEY+/sSpbdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788146608; c=relaxed/simple;
	bh=qKJuBFqg8moHfqo5/pQDyOXihvtkmawEyBCIHb+tpRQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ts0YKGy1dE+RNsTDvf2mwqtYS6X4ZomMYy0FnufS8vCLJV91ORvoYsGVZTeD9haBU3lv8kJWuk4ejt37NdlI1AY0vkUHAMH7bfJxQgta2u1b/2mOAfnLROUyUVFcOj0aXMq3on2mvAEl+NRhvCk+fDTqk/06iZLTV9MkI/Yf03I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=C1fNRass; arc=fail smtp.client-ip=52.101.70.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="C1fNRass"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QNw2LxO/MQyquGChx1n9WRkDSRtpKIEi4oKg7sjaEBE21ItwroQ7SlO/88sqc57yQGkbUZDYdoECUA4dFNAS5yg1RVVbWB+RbMGagonQa7blqzxZ287PxtqjEszvirmTcqDuPH9hFkm4bQTCxCoVo1ypSJVRxKRWNrnb7eqwKBhrfKbjj1L4V/MoggtNY3xq22JDnb2jAZ7IAe/HASm88MHIK8P1g1ollGjseOpwxwGUD1Eaqa6Bs8r1el3s32rYmmZq+t2GhwxgeMGaeYtqJBrW01wh/Pq7gj03jP90oZ/4WbOME+iTGH5eT9wXyopM/62bDvm94SyeRrQypLVZug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RFyUBXnk/75ZUyaroKObh7yfrAUM8ZGjzRPKmclTA38=;
 b=eRxhHefDXoM9Lu0u4HE2IDKPoyVDbCQ1Ixu22ii1JzCDxgPRkLMw2QLmCepzTqTLP2sE+1Jk0fl6aFtNz+Y5wf0w2O2l1zeKi6kuhHMp3ysue/OhoYSWewUYzbDAMg8tjRQ2TjQ/hixR5AHrqwQAyXyJKfJ1O6hSMJIQDgsD+3nMqYudjcVAJUFRWRsbethUaoqN5sV/riPGGv7MZL3dfCrmJs2HtSr6ofYG8PYjJnP7ZT+KHGb1eEQFX2PZgxWib6TkiD4SIwoDw5DuzN6NOzManQ/BddN03xviwiRE/kUQ1CcqGGnu0JWJ2PMW/9sK9h2QgzRwIBZZsh2K0F8N8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFyUBXnk/75ZUyaroKObh7yfrAUM8ZGjzRPKmclTA38=;
 b=C1fNRassk/Wj+oJ16o83PGK/rUQvtbYAdUC8p5Ph+A+1/PUrbfQYNA8MT4LyY32sySAxDvNGcnxkl2EprZquYsplNcpmo9eKuRGnStrVQ5sWZ9qQ6GsfrcQv/sxf1QzhEW/Fkzr8BRJyVOcYC8WvtnCip9gxpPHjOEKN5TMJBIQ0Pau0Lria6ck4mXBFlz+5Wn9rwJQ6XjN+w6ELehRyDHrwr6LaIb0Sm6GRghzx51pdNSXe4/FUwqHZdP00BHylKxUfCZb2z2JWv+2Vy2FAY4AESHdaLTDKzwGJRKPimI2277Oe5VXSiaXy8Z2eP6tHeqi5CHW3MdVObi8EVbi+hg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by PAXPR04MB8474.eurprd04.prod.outlook.com (2603:10a6:102:1dd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 03:23:23 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 03:23:23 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 net-next 11/15] net: enetc: restore VF MAC promiscuous mode after FLR for ENETC v4
Date: Mon, 31 Aug 2026 10:54:37 +0800
Message-Id: <20260831025441.635045-12-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260831025441.635045-1-wei.fang@oss.nxp.com>
References: <20260831025441.635045-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0011.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::6) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|PAXPR04MB8474:EE_
X-MS-Office365-Filtering-Correlation-Id: c87ff9ed-1429-4bd3-aa84-08df070f36bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|1800799024|366016|23010399003|7416014|56012099006|10067099003|5023799004|11063799006|18002099003|22082099003|921020|6133799003;
X-Microsoft-Antispam-Message-Info:
	n5YlGbQqkiwBkVKpXH24xw6jcVeGAk11SMq3ghqoVFMsPCqvinPkuOsTTOKG0gqyhxyv27lqRgNsBBTzvycIdpnPdeOMEvkcp7FOKE627Mb0pn7CZvM+I8DvfuHcabd5HiIMV5TxfFg1A7eYxAA+xn4eozNoOWRJyKkgfO9NR//jaqqzjFFJh/qeDgzsv8JEzFxsmrvs94jS8v8raOIO81B9IIV+buxKHbjhzP8uKReMKEfmORwtmZxPiCTVbZG0LHzF0DSMmM0W5xZzI/PKxTKsfZ1UZNUHuCShUMYo83sKR8yXFUKuDLP8Kwkj2cwCneX3Mddpp32acGwTXWQUnUX4ERoKaW/3O18yJM19G0wOtjuEfpTvjKMf2l0T0XPonJgIZ5id3MS0enacvzwMDuM6kxE7QLnBeupMAKXMwHrLhcXvO3uHIt62QeZTSXcHQ+uMh9pCQydRkxxSyLQgjyNNZLLpaHpJRp6yV0wnXzncNBfReQVZ3oNEwZLL33TDmH2Jkcz+vmfmspHGTHXKX1ipTxfu0FHsHjOsa2oKfmom93KgG1LIwvCF/KhLQ/3d0Ekde+sJxnEdImZHeI9Akae9WzyIEa2OFbd/oBkoF5rRd0S1hgVAX8m5N8nFA3im96rf51lQPWrbELK0ejojAnhyJ5u2UwRtO8B5FSRJwuJ1gCLKWfLzPJgNyhhEiK1NewQtMtFPC64saw6J0F76PA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(1800799024)(366016)(23010399003)(7416014)(56012099006)(10067099003)(5023799004)(11063799006)(18002099003)(22082099003)(921020)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iIlEFfZEHKkVZe74esiiU53oHDz6D0X4geY1wyIYRZ6LD8/dxNr5bDACIehQ?=
 =?us-ascii?Q?eQLat2PVWiKAG/adA38uruHT0WGatUN0kVRGZclGZmmkYeP4FcWG0TtFk/0l?=
 =?us-ascii?Q?WF3knSQK4Wvd6ITkDKvPi9tEMKZ9LbGS3HWdYtX1LKJgj70YjohE4diIVP0X?=
 =?us-ascii?Q?rBQsO71dySy8ecVgtm1F1zDt3JcVQ3WTXPkyI3uyi5PYHwhFFgy7vkciTxGO?=
 =?us-ascii?Q?9eIWwvUUldywgWP/Ldki7/cFLYQnfGnzKrsJ4Y8kTzR9PojEg23wm6ikNaiK?=
 =?us-ascii?Q?/oT8RxLmjfsjg7dlrAorzuEUBR9Edfb1yJFFFMW1xYWav3JzUqVDvGEai/r8?=
 =?us-ascii?Q?zba/5CxJ8TspQ4GXj0cJOlVCD4uwfwSSr5oc3yjZhQaGAgQPsPRN34/Aa5qu?=
 =?us-ascii?Q?cRGfymvKh5ed0iXRBwNZwjNfmC9aNr+AcN4+FG5pZPYKy65B3BD7br/BAoxS?=
 =?us-ascii?Q?Z/cKj627WS7//IFV3VTVav9H5ZUuxOdwdoN7Z7SS4PuHpAE9olzSm5JZ7Hp4?=
 =?us-ascii?Q?5cJ8SnNmlvOInvach7UQ6nti6uq7W0tRyPawLzlUHCE98ABgIlzkXOpWL3d9?=
 =?us-ascii?Q?UKeBJWLSJJYeXUHIOmTpOaj9Z5zyXZGok2CrsfrN/+1D8paVtdTCDAut1IIr?=
 =?us-ascii?Q?oUbGHsUbWVnwWHbrz1SeuYfO7BXzdbkrh7YMPBXiOMGUUlXrOvVxGEn//mjf?=
 =?us-ascii?Q?/b9q95IXLJeG24rxtzLdLLJw/+zRI9pA7rWzFgECVORspGvlUS8+8Uym45tg?=
 =?us-ascii?Q?jJsxY5iizNxD86Xi7607hempEOZwVewVrajQTUQ8+Yek/I3kym3gcjhAQSAD?=
 =?us-ascii?Q?M0XW6AWqdLvgVcK74uOGbmmL+ePhT+23vAkLm4g8UQJOS769jK1SMU3SWDnh?=
 =?us-ascii?Q?XZyUt7T+sXgHRSr91HASErfbWZKHDhUUYLyzYcRt8eV0UYa87aqSPFem6/p2?=
 =?us-ascii?Q?Pv7E1qfIoK1vcp2kUw4xKeslVD/Rd40hDZbshPLzKE/8zHp8fE6sh5caIoJ4?=
 =?us-ascii?Q?WVCWzVd4u3CK6VINXsuzkfJrZb4t0PTMKEHEVlXwVD9e1hq7bptLru5T8Lx8?=
 =?us-ascii?Q?WGv5nTN5WC2mq0k4fFvMf9QpPVYcB0dRKWafK+fTDYib9fvs86Pb35Ej0wbI?=
 =?us-ascii?Q?mV10aZIko5gaX4pnwiCgRaEZckjQ63s77BHf/rAvFrWpkDCWf8gdu3awoJWV?=
 =?us-ascii?Q?y60MvyidOOFNfqr7PBpxn91Lm6Ldg8q/CuErjT9wJMSChgFCrDVxqfAA1Lua?=
 =?us-ascii?Q?JjIFjVs5ZoP8HUlgGre/D6ART21d0rVrfscPK7LHqXJSTaiqjDVlLys69VOq?=
 =?us-ascii?Q?+D0HJNJ8Vr555iZ/in2hyDA3X3lxOagQ8WOvTgGwIg+xya82XSD/AZt2L4gG?=
 =?us-ascii?Q?xpOVu1kuzeBifzmuseJ3eeInPhGwuGedtxPUdCRybiyYMheZUhVR0FCBCRoo?=
 =?us-ascii?Q?tbLQoO1ydQ755jV2EYLW5yoPS1YDVdYkvXXTJ2xRrbi//aQU+GLIC6HE8HU4?=
 =?us-ascii?Q?DxFPCRY8IV/8pHqIxgPYM+OReDX9Bjv65zZsrXf415nmWxtoU6lXwneHypvS?=
 =?us-ascii?Q?TMimLG70O7+CwRYmHg6Hbp+Gqq/19cvJBY/Gxu5GMsZDlQNPa9ODOqWBJq76?=
 =?us-ascii?Q?e/ZFapvgAkq9rt/+uC0Vub3FUL8D0q3cMO89IFXejT1duzA0R5JY79oRxpJa?=
 =?us-ascii?Q?rM6MwRMhdFkBukZxqlU+CklXd7YbSld0hJd/uqjcFbaWb2/VgO6OAdifwQ2z?=
 =?us-ascii?Q?TXt9+CeZZx4eRW8EbOzsb/Az1DLxvy3yfpAB8L95W4hNRX6rM0tH?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c87ff9ed-1429-4bd3-aa84-08df070f36bc
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 03:23:23.6779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wqFck+VGliCwf/oLCT+ORE4fOk6agsN9/jwJvRoziRRiuWBIsv0bg0AK08PJZAVJxwLATampAZMD5IwwXiJBPLED+NP6j8DPfQTtu7PbTm+2N4R2G03xW9uVWz8vtitn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8474

From: Wei Fang <wei.fang@nxp.com>

On ENETC v4, when VF performs a PCI FLR, it resets PSIPMMR[SIn_MAC_UP]
and PSIPMMR[SIn_MAC_MP] bits, which control the unicast and multicast
promiscuous mode for the corresponding SI. The reset (default) value of
these bits enables promiscuous mode, meaning that after a VF FLR, the
SI is left in promiscuous mode regardless of the configuration set by
the PF driver prior to the reset.

This is a potential security vulnerability: a malicious VM could
deliberately trigger a VF FLR to force promiscuous mode on its SI,
allowing it to capture network traffic not destined for that VF.

To mitigate this, make the following changes:

- Add ENETC_VF_FLAG_UC_PROMISC and ENETC_VF_FLAG_MC_PROMISC to
  enetc_vf_flags to track the PF-managed promiscuous mode state for each
  VF.

- Update enetc_msg_set_vf_mac_promisc_mode() to keep these flags in sync
  whenever a VF requests a promiscuous mode change via messaging.

- Update enetc_pf_set_vf_trust() to clear both promisc flags when a VF
  is untrusted, so that a subsequent FLR cannot restore promiscuous mode
  that the PF has already revoked.

- Add a vf_flr_handler callback to enetc_pf_ops. The ENETC v4
  implementation re-applies the tracked UC/MC promiscuous mode settings
  to the hardware after each FLR, ensuring the hardware state matches
  the PF-managed policy rather than the insecure reset default.

- Add enetc_vf_flr_handler() in enetc_msg.c to detect FLR events via the
  PSIIDR register and dispatch to the vf_flr_handler callback. Invoke it
  at the start of enetc_msg_task() before processing VF messages.

- Enable FLR interrupts in PSIIER only when a vf_flr_handler callback is
  registered, keeping ENETC v1 behavior unchanged.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 20 ++++++++
 .../net/ethernet/freescale/enetc/enetc_hw.h   | 12 +++++
 .../net/ethernet/freescale/enetc/enetc_msg.c  | 50 +++++++++++++++++++
 .../net/ethernet/freescale/enetc/enetc_pf.h   |  3 ++
 .../freescale/enetc/enetc_pf_common.c         |  4 +-
 5 files changed, 88 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index a4ffe1100bd7..c421c0e7355b 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -212,9 +212,29 @@ static void enetc4_pf_set_mac_filter(struct enetc_pf *pf, int type,
 		enetc4_pf_set_mc_hash_filter(pf, mc);
 }
 
+static void enetc4_pf_vf_flr_handler(struct enetc_pf *pf, int vf_id)
+{
+	struct enetc_vf_state *vf_state;
+	bool uc_promisc, mc_promisc;
+
+	vf_state = &pf->vf_state[vf_id];
+	mutex_lock(&vf_state->lock);
+
+	uc_promisc = !!(vf_state->flags & ENETC_VF_FLAG_UC_PROMISC);
+	mc_promisc = !!(vf_state->flags & ENETC_VF_FLAG_MC_PROMISC);
+
+	mutex_lock(&pf->msg_lock);
+	enetc_set_si_uc_promisc(pf->si, vf_id + 1, uc_promisc);
+	enetc_set_si_mc_promisc(pf->si, vf_id + 1, mc_promisc);
+	mutex_unlock(&pf->msg_lock);
+
+	mutex_unlock(&vf_state->lock);
+}
+
 static const struct enetc_pf_ops enetc4_pf_ops = {
 	.set_si_primary_mac = enetc4_pf_set_si_primary_mac,
 	.get_si_primary_mac = enetc4_pf_get_si_primary_mac,
+	.vf_flr_handler = enetc4_pf_vf_flr_handler,
 };
 
 static int enetc4_pf_struct_init(struct enetc_si *si)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index f97602714118..c18ad8b9b071 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -110,6 +110,18 @@ static inline u32 enetc_vsi_set_msize(u32 size)
 
 #define ENETC_PSIIER	0xa00
 #define ENETC_PSIIDR	0xa08
+
+/* VF FLR interrupt mask, n is the active number of VFs.
+ * It is available for ENETC_PSIIER and ENETC_PSIIDR registers.
+ */
+#define ENETC_VFFLR_MASK(n)	\
+	({ typeof(n) _n = (n); (_n) ? GENMASK(16 + (_n), 17) : 0; })
+
+/* VF FLR interrupt bit, n is VF index. It is available
+ * for ENETC_PSIIER and ENETC_PSIIDR registers.
+ */
+#define ENETC_VFFLR_BIT(n)	BIT(17 + (n))
+
 #define ENETC_SITXIDR	0xa18
 #define ENETC_SIRXIDR	0xa28
 #define ENETC_SIMSIVR	0xa30
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_msg.c b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
index 4aabeb23a386..55c23d4a73a8 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_msg.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
@@ -27,6 +27,9 @@ static void enetc_enable_psiier_interrupts(struct enetc_pf *pf)
 	u32 psiier = ENETC_PSIMR_MASK(pf->num_vfs);
 	struct enetc_hw *hw = &pf->si->hw;
 
+	if (pf->ops->vf_flr_handler)
+		psiier |= ENETC_VFFLR_MASK(pf->num_vfs);
+
 	enetc_wr(hw, ENETC_PSIIER, psiier);
 }
 
@@ -208,6 +211,20 @@ static u16 enetc_msg_set_vf_mac_promisc_mode(struct enetc_pf *pf, int vf_id,
 		goto vf_state_unlock;
 	}
 
+	if (type & ENETC_MAC_FILTER_TYPE_UC) {
+		if (promisc)
+			vf_state->flags |= ENETC_VF_FLAG_UC_PROMISC;
+		else
+			vf_state->flags &= ~ENETC_VF_FLAG_UC_PROMISC;
+	}
+
+	if (type & ENETC_MAC_FILTER_TYPE_MC) {
+		if (promisc)
+			vf_state->flags |= ENETC_VF_FLAG_MC_PROMISC;
+		else
+			vf_state->flags &= ~ENETC_VF_FLAG_MC_PROMISC;
+	}
+
 	mutex_lock(&pf->msg_lock);
 
 	if (type & ENETC_MAC_FILTER_TYPE_UC)
@@ -594,6 +611,29 @@ static void enetc_msg_handle_rxmsg(struct enetc_pf *pf, int vf_id,
 	kfree(msg);
 }
 
+static void enetc_vf_flr_handler(struct enetc_pf *pf)
+{
+	u32 flr_mask = ENETC_VFFLR_MASK(pf->num_vfs);
+	struct enetc_hw *hw = &pf->si->hw;
+	u32 flr_status;
+
+	if (!pf->ops->vf_flr_handler)
+		return;
+
+	flr_status = enetc_rd(hw, ENETC_PSIIDR) & flr_mask;
+	if (!flr_status)
+		return;
+
+	for (int i = 0; i < pf->num_vfs; i++) {
+		if (!(ENETC_VFFLR_BIT(i) & flr_status))
+			continue;
+
+		/* Clear FLR interrupt status, W1C */
+		enetc_wr(hw, ENETC_PSIIDR, ENETC_VFFLR_BIT(i));
+		pf->ops->vf_flr_handler(pf, i);
+	}
+}
+
 static void enetc_msg_task(struct work_struct *work)
 {
 	struct enetc_si *si = container_of(work, struct enetc_si, msg_task);
@@ -602,6 +642,8 @@ static void enetc_msg_task(struct work_struct *work)
 	u32 mr_status, mr_mask;
 	int i;
 
+	enetc_vf_flr_handler(pf);
+
 	mr_mask = ENETC_PSIMR_MASK(pf->num_vfs);
 	mr_status = (enetc_rd(hw, ENETC_PSIMSGRR) & mr_mask) |
 		    (enetc_rd(hw, ENETC_PSIIDR) & mr_mask);
@@ -728,6 +770,14 @@ static void enetc_msg_clear_vf_config(struct enetc_pf *pf, int vf_id)
 
 	mutex_lock(&vf_state->lock);
 
+	/* VF may set these flags by mailbox messages, so need to clear these
+	 * flags when enetc_msg_psi_free() is called. PF-set flags (TRUSTED,
+	 * PF_SET_MAC) are not cleared, because these flags are unrelated to
+	 * whether SR-IOV is enabled or disabled.
+	 */
+	vf_state->flags &= ~(ENETC_VF_FLAG_UC_PROMISC |
+			     ENETC_VF_FLAG_MC_PROMISC);
+
 	mutex_lock(&pf->msg_lock);
 	enetc_set_si_uc_promisc(si, si_id, false);
 	enetc_set_si_mc_promisc(si, si_id, false);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
index 12e67f611f77..6bf4105ee0e3 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
@@ -11,6 +11,8 @@
 enum enetc_vf_flags {
 	ENETC_VF_FLAG_PF_SET_MAC	= BIT(0),
 	ENETC_VF_FLAG_TRUSTED		= BIT(1),
+	ENETC_VF_FLAG_UC_PROMISC	= BIT(2),
+	ENETC_VF_FLAG_MC_PROMISC	= BIT(3),
 };
 
 struct enetc_vf_state {
@@ -32,6 +34,7 @@ struct enetc_pf_ops {
 	struct phylink_pcs *(*create_pcs)(struct enetc_pf *pf, struct mii_bus *bus);
 	void (*destroy_pcs)(struct phylink_pcs *pcs);
 	int (*enable_psfp)(struct enetc_ndev_priv *priv);
+	void (*vf_flr_handler)(struct enetc_pf *pf, int vf_id);
 };
 
 struct enetc_pf {
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 8007dce90195..10134d7a1f70 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -625,7 +625,9 @@ int enetc_pf_set_vf_trust(struct net_device *ndev, int vf, bool setting)
 	} else {
 		u64 hash;
 
-		vf_state->flags &= ~ENETC_VF_FLAG_TRUSTED;
+		vf_state->flags &= ~(ENETC_VF_FLAG_TRUSTED |
+				     ENETC_VF_FLAG_UC_PROMISC |
+				     ENETC_VF_FLAG_MC_PROMISC);
 
 		/* For ENETC v1, we only support setting the VF's MAC address
 		 * via VSI-to-PSI messages. Unicast and multicast promiscuous
-- 
2.34.1

