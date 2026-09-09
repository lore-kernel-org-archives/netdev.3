Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013037.outbound.protection.outlook.com [40.107.162.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2035251E442;
	Wed,  9 Sep 2026 10:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788950139; cv=fail; b=kVRhSU37ukvpuD0q1tDwrGueBwzO/PFAye0kgoaNdiqRn925gmtMUQyGMFAQdpBHNLpTJIupr8WvQdnyBBsZA2BGRSQR1tAKm1A7AqOkDmvXf74HZIMavGuwPbJ/VcwmSgzRGAOyhT6xFaKXKOYSQAy4teqJeT5JwSuSF2h6cPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788950139; c=relaxed/simple;
	bh=N5BgDMKRw2YuQ1fnxq05TPfljIp4PBAU+zMxHNT7cyQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mcw0Q+gmaY/kqxQnsi8HsRCj+wDEnY8RDBdAcuWcR2wRuyeANW2z4WpWvGkgGej8XJSXOEKHd9IbmywyKta0XNvUJXBx4dkZmdze1VodupmyYI9xNpoVrSMhP2Fn3y5i4kutUNn0E1DwkDfjjljIumi6llwg5C7y3ciJTY2zgIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=odmhyYBq; arc=fail smtp.client-ip=40.107.162.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="odmhyYBq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HmJivgnsStmhv7NVyDmA2VFNKGUkZcdkF10hSZfrFHJOeArQc8NphqtaD9Tt+A/Xj1kNRgU32zhfbDsmfpolM3xVkHgvxH6weeYGuMo6h/gXaxBD1rLAJmspCWamBErOSRMAQV3EFl1rEwYkYSDY9BmE26/N+BSjc6EOwPHeQprTZjf8kgMzE4pHmfreZ5KQFt4N2KYtjrufD/zcGWWb+R+OFDrpb/vTSmJsYRnaxwN/3C4nEfx0DOhARsP/tNrvhhZ0VaEdiS7vMwAvvHO5q9b0J2BFI4upf1hRp3i4+UILs0ZGV6ZPrrKYY5cn5JH2Hr4GeCCMaNJiVBkoPqet4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IznaU1RAU+YJOR/Hl4OABd+lUwJXAJBxmJqpQcPv6do=;
 b=uUYfGchjMKYUrRnhIMYMGhkURXVQJ+7r0QmK27qQnBLA7ky/TGrP/yKjcXUjbbg/Qwn4llO+2fnMgLyQINQeAMRMD4uIDbZebyu+QPyhxrRKrfE8KYuE483A9TPk1+P5Jb6osrnuNMwMLFnExB/EFFxdC5mtSY26RXNf90ctWxXPC39VuOomkEIsuSrNNGNAmhydpbcdnJ6nFOFBB7eelMLiSoKlVYuCcGb8KAgnMhWaM41kLbRw4tGqtwaZr0EofILNYHzLKHqWqZSn4/UCxpfih8410B/FLPRb1jlRlg5r0nfmKAsWeBk8dQ5pT3nVjrLXBO0u53DzMSSR3OHJBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IznaU1RAU+YJOR/Hl4OABd+lUwJXAJBxmJqpQcPv6do=;
 b=odmhyYBqYKQKIWZoNWuyfH18C2T8zKVkokodpPixkBLIMi/c9N7/98wdixuT22ZQQSKUFgSSKfSvVBGdMVqrJ+g5iFrIgpRWZFT/DQxTI7TX/d/FCg5l9ra2c0+beqicUGkX7NVbtZffRacIXcvLdtZd8dHD4mZl3Ka97f2c4prmI19fjcbbCH38N0KrMLR1+98qtmD+DKMwgsEfCKWPnmbuovzZH0Ok3wZJGKZ2Z2qHyzB/3717FaysG0jfeEG9L2oCouB1ZoVxpGEZ2ukJtqbVbnm30EhzJ+qfwxlE9cmcq4eBJ7B4/J0IoIWt8THUsHtm4p4rGti8rzxyy6KtOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by DB8PR04MB7066.eurprd04.prod.outlook.com (2603:10a6:10:12e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Wed, 9 Sep 2026
 10:35:35 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 10:35:35 +0000
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
Subject: [PATCH v4 net-next 01/15] net: enetc: add trusted VF support
Date: Wed,  9 Sep 2026 18:07:19 +0800
Message-Id: <20260909100733.1139689-2-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260909100733.1139689-1-wei.fang@oss.nxp.com>
References: <20260909100733.1139689-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0022.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::8)
 To VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|DB8PR04MB7066:EE_
X-MS-Office365-Filtering-Correlation-Id: f4c2aee4-efaa-41b2-a81a-08df0e5e153b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|376014|1800799024|23010399003|366016|10067099003|11063799006|56012099006|6133799003|3023799007|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	GccjzN2csExM4b9zngf65vM9URbT/KxVsCfm1/IowLUvLB6PMQjvEKtnOQGyZe7g66hoZ4F2e0se+UTqvKXHW38WKFs7eYxl+QEWSQk/XAreTL4ggmvbefEv3b7mBrr9GLRXFoZ74d5GIpCM/lHWTVyNiEt0qXuHOlzy+sRX/2rNQ/MDda8ILPMYyGc4Vcf++JBJt8mk16m/+DLiebdRjOJeh6wOAc91xTNUnc6ObMh//fIbIBA+WmcEsmN6IH6F1lIV2OF6O/m+XhfFB+zNRQcowyyaq1SGGCwQzy+FEPMuMTDizLOwbPQIdyiCplYIJXimS1q+EHx0IUOu4SyescK2YhPjXHSQ6gDo5P3Of0QMec+fpZ9bdCTwNeT47n/DcjyB9cQBPatNijhSWtA/hM7/Grcdz7LqP/IcDGpFazS8Jk4kz27lPN3l31Uoq9weYuo4MAuBYwfj6DylPWAvkBjQwHg82euE3XpZjJ6RLxYCt5I8REfc4iUJxSd7+QJ4RInLJPikD2JwyRYFhvuC2NK+WVbfsKjjsQ34DmkyuG718oTRyGfElp6KynuNrhPXu7cp5hm6by/kWKpxIaFrHzSVaxZ4+fW3pRwy+kjHVfroQGU09ilXj/SgFfaMu2s2PMeaOve0cuwz2oHAOr/jV4xv65EVzoZ+Blb26tNiKLQcGfDuCIr9qyc8wl/IXLQnydDIO27VrBFFhxMuQEUFxw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(1800799024)(23010399003)(366016)(10067099003)(11063799006)(56012099006)(6133799003)(3023799007)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A4s7Z6TmL7kq1AaiszjCouIHzixfyvIbemBY8Qh3UWm5+bgMG+zCHLn4vpRS?=
 =?us-ascii?Q?d6N09awd+Q2Uy6/ipnc6jDP32sM/wiJvqJQkB9dQzlsb/Uvaesz50xa0mlHf?=
 =?us-ascii?Q?7Q7Go1EW+/COsJrSiaSFUqUjt77ds58KIO70+W5gOOO3dVGQObYqOaLDqsQM?=
 =?us-ascii?Q?DONxK5SOYs8JGfuCEFQcoFCkGlqHBSR+VPd9dshy3Rrjz5vDXLSYHEwUmVrn?=
 =?us-ascii?Q?1gAwNa+sYSLoDOlLz1n/D66wfG/5/FvT3DnM2Wr7p/txRbg5vpH0e4KF8yfU?=
 =?us-ascii?Q?LIKGNlfc0jFTjJ/66tLijGB0cCHBK5hU/vhNLsohLfRISc2VRcA0Zkq+q2c/?=
 =?us-ascii?Q?Aj/K6wamMIdHawHwlQ3+xe5UcK/eHcVrVSM3k+KEvQaM03F3whi3nz8zW/3x?=
 =?us-ascii?Q?/OLUgUCZy9KMYe+H0kpD0XRHbMYeA1wxkLSGZwohCiP++Da7dTR4dJfU7jex?=
 =?us-ascii?Q?NlEpN0GMc9zLFGqN1x/6PgWMAqzIgYArnBSCGa9hLqlHj98KnRq4mIoEEz39?=
 =?us-ascii?Q?2Xchwrq/HKUL7U6J+/8/GvYk9bHEFQTGqITfUsIbO3cODkHLlivh0oEJUrLu?=
 =?us-ascii?Q?7OvCzkwHGPJU+ijWPQAWQuUEbAiS3N38Iy4NCRSbKxHdKw0oVdGHNdrHryMC?=
 =?us-ascii?Q?gWYe4+mMdV5H2IIKIa6lp0Os52SwdrUSSh5xMk1JMb+10CR/PtUTI7SoRW4d?=
 =?us-ascii?Q?h3uw7EzHYFfgyLdqpvJd7RH5CgaInlPeYC6t974rV4I2CuBXhZrcSFP5ZUQy?=
 =?us-ascii?Q?7Co5TtlnLzELGLrIsAju9sbhuf0hwM5HhKCTP9AhU0Z71purGWLuA8wmioHS?=
 =?us-ascii?Q?UugHJLt/tqFp8WGoFKNwFFPp1LhPZ4WKVtiq+B2JoaIABl85lsmNrU4oGxJy?=
 =?us-ascii?Q?5Y3nSp6jnDvlrr6GHtFTnMk6yAP2irnPFCMqpODOUqoSeXinw+qRGBU27YdE?=
 =?us-ascii?Q?404IWbzE1B2LMyX6UMCSe2vyUPjxRZq4X/KVh+qjfAFZg/qL/S0JrZ1/StyG?=
 =?us-ascii?Q?yPuSlLeQ94riEm+bVtxeHfsYhoBghHNE/x0kdYbvGNlN4i0YF4gVLcjSQDn1?=
 =?us-ascii?Q?zCFUwSaJLw6NM/sXKa0d44RLWhJOGqjxpZctJ8uulKlAYyZ3l0GoUwEviCj+?=
 =?us-ascii?Q?9oeUZwMgmcY9s2+SZ8VSar9E22HS0MRvQGTdrzgcmkyOdYdLIn7M4u0v0yfJ?=
 =?us-ascii?Q?LX3q3Fg/uvogdgGEC6AvS2ZLilSZ030l4F1uin8JQCceSaupanSfl4/pl8UR?=
 =?us-ascii?Q?vV90UgfXL3w0r4+5F8rmaUMmwaXrJI2oSJEaEhB9g3+1NH2YuP7vssbIrbmO?=
 =?us-ascii?Q?EG3WlwIZ1hSJkDsgcMm7H1GfWeKgW7i16zpVZSFVY0A2mWbLmTJarCWBmDSn?=
 =?us-ascii?Q?YrYmmKLSg2MG5RWp4amqI1A9wCGPmBh7kTcb8sXh56M5Ikm+AQpDwkHIf/B9?=
 =?us-ascii?Q?wRVki4S773CTqYT9fP13DJtu0U8a2K7nRbQiiIubHC1Gnd6BQhGRBDKsB+FH?=
 =?us-ascii?Q?zrG6kM717MAs24uVIWR5aSw+U/lySL7EOz0rsWCssffs1tHtIE31mVBOB8V4?=
 =?us-ascii?Q?bRe/0Cxz+AfRq/D75deLDbfWtTbEXSjqzzz1/wVO5J4P1X6n7LPOUK0wf+pJ?=
 =?us-ascii?Q?SoF4tzNWTRGByIvcrgTiC3LFvpRiaKGx7yD0yTlLnfyD/1a2gBmIwr966h/x?=
 =?us-ascii?Q?iPichq7SuJF3EPgDvcR7QU+KBNKCsUwM8q2LhR5u11egkOoNT7vxhheZ6GT/?=
 =?us-ascii?Q?9zMJ4mFgOQLouO0MHLFMBHKpf5ZK/IqUo6S+zTQO607VPonlSL94?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4c2aee4-efaa-41b2-a81a-08df0e5e153b
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 10:35:35.7022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SYSFJzHZ8uX4lKKpNlbJF05m7kbkB5pCG5a5/h5T4Ke8NRXAbYUaVrlHVlHJKdgqC0DSIy8Fu43twxIAWCi1Kj6JwnzLSy3uC5GWubiK0NMiAilAYAboxkWBDcagMp65
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7066

From: Claudiu Manoil <claudiu.manoil@nxp.com>

Some mailbox messages require a higher privilege level to be executed
on behalf of the requesting VF. Introduce a trusted VF flag
(ENETC_VF_FLAG_TRUSTED) and wire up the ndo_set_vf_trust callback via
enetc_pf_set_vf_trust(), which is shared between the enetc and enetc4
PF drivers.

Trust is a PF/host-side policy bound to the VF index, decoupled from
whether SR-IOV is enabled. It may be set on a slot before SR-IOV is
enabled so a trusted VF can apply configuration right at init time,
and it is intentionally preserved across an SR-IOV disable/enable
cycle. The bounds check uses pf->total_vfs, the hardware maximum and
the size of pf->vf_state[], so pre-configuring an uninstantiated slot
is in-bounds. If a slot may be reassigned to another guest, the admin
clears trust with "ip link set <dev> vf <N> trust off".

The first message gated on trust is the VF primary MAC address change.
An untrusted VF that attempts to set its own MAC address will receive a
ENETC_MSG_CLASS_ID_PERMISSION_DENY response and the hardware will not be
programmed. This prevents a malicious VM from setting the VF address to
the MAC address of other VFs or the PF and eavesdropping on the traffic
of other SIs, and it stops a malicious VM from arbitrarily changing the
VF MAC address to achieve MAC address spoofing and bypass security
policies. This does not regress VF bring-up. The PF programs a valid
primary MAC into every VF slot at probe, and the VF loads it from its
own SIPMAR0/1 registers.

Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc4_pf.c  |  7 +++-
 .../net/ethernet/freescale/enetc/enetc_msg.c  | 38 ++++++++++++++-----
 .../net/ethernet/freescale/enetc/enetc_pf.c   |  1 +
 .../net/ethernet/freescale/enetc/enetc_pf.h   |  1 +
 .../freescale/enetc/enetc_pf_common.c         | 23 +++++++++++
 .../freescale/enetc/enetc_pf_common.h         |  1 +
 6 files changed, 61 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 9bb1004548ab..935a6a03b14f 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -225,11 +225,15 @@ static const struct enetc_pf_ops enetc4_pf_ops = {
 static int enetc4_pf_struct_init(struct enetc_si *si)
 {
 	struct enetc_pf *pf = enetc_si_priv(si);
+	int err;
 
 	pf->si = si;
-	pf->total_vfs = pci_sriov_get_totalvfs(si->pdev);
 	pf->ops = &enetc4_pf_ops;
 
+	err = enetc_init_sriov_resources(pf);
+	if (err)
+		return err;
+
 	enetc4_get_port_caps(pf);
 	enetc4_get_psi_hw_features(si);
 
@@ -574,6 +578,7 @@ static const struct net_device_ops enetc4_ndev_ops = {
 	.ndo_eth_ioctl		= enetc_ioctl,
 	.ndo_hwtstamp_get	= enetc_hwtstamp_get,
 	.ndo_hwtstamp_set	= enetc_hwtstamp_set,
+	.ndo_set_vf_trust	= enetc_pf_set_vf_trust,
 };
 
 static struct phylink_pcs *
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_msg.c b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
index edc1277bb586..78114ab3e482 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_msg.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
@@ -7,6 +7,8 @@
 					   ENETC_MSG_CLASS_ID_CMD_SUCCESS)
 #define ENETC_PF_MSG_NOTSUPP	FIELD_PREP(ENETC_PF_MSG_CLASS_ID, \
 					   ENETC_MSG_CLASS_ID_CMD_NOT_SUPPORT)
+#define ENETC_PF_MSG_PERM_DENY	FIELD_PREP(ENETC_PF_MSG_CLASS_ID, \
+					   ENETC_MSG_CLASS_ID_PERMISSION_DENY)
 
 static void enetc_msg_disable_mr_int(struct enetc_pf *pf)
 {
@@ -61,31 +63,49 @@ static u16 enetc_msg_set_vf_primary_mac_addr(struct enetc_pf *pf, int vf_id,
 	struct enetc_vf_state *vf_state = &pf->vf_state[vf_id];
 	struct enetc_msg_mac_exact_filter *msg = vf_msg;
 	struct device *dev = &pf->si->pdev->dev;
+	u16 pf_msg = ENETC_PF_MSG_SUCCESS;
 	char *addr = msg->mac[0].addr;
 
+	mutex_lock(&vf_state->lock);
+
+	/* Untrusted VFs cannot set their MAC addresses by the mailbox
+	 * messages.
+	 */
+	if (!(vf_state->flags & ENETC_VF_FLAG_TRUSTED)) {
+		pf_msg = ENETC_PF_MSG_PERM_DENY;
+		goto vf_state_unlock;
+	}
+
 	if (!is_valid_ether_addr(addr)) {
 		dev_err_ratelimited(dev, "VF%d attempted to set invalid MAC\n",
 				    vf_id);
-		return (FIELD_PREP(ENETC_PF_MSG_CLASS_ID,
-				   ENETC_MSG_CLASS_ID_MAC_FILTER) |
-			FIELD_PREP(ENETC_PF_MSG_CLASS_CODE,
-				   ENETC_MF_CLASS_CODE_INVALID_MAC));
+		pf_msg = FIELD_PREP(ENETC_PF_MSG_CLASS_ID,
+				    ENETC_MSG_CLASS_ID_MAC_FILTER) |
+			 FIELD_PREP(ENETC_PF_MSG_CLASS_CODE,
+				    ENETC_MF_CLASS_CODE_INVALID_MAC);
+		goto vf_state_unlock;
 	}
 
-	mutex_lock(&vf_state->lock);
+	/* PF has higher privileges. If PF has already modified the MAC
+	 * address for VF through .ndo_set_vf_mac() interface, VF is not
+	 * allowed to set its MAC address via mailbox messages, even if
+	 * it is trusted.
+	 */
 	if (vf_state->flags & ENETC_VF_FLAG_PF_SET_MAC) {
-		mutex_unlock(&vf_state->lock);
 		dev_err_ratelimited(dev,
 				    "VF%d attempted to override PF set MAC\n",
 				    vf_id);
-		return FIELD_PREP(ENETC_PF_MSG_CLASS_ID,
-				  ENETC_MSG_CLASS_ID_CMD_NOT_PERMITTED);
+		pf_msg = FIELD_PREP(ENETC_PF_MSG_CLASS_ID,
+				    ENETC_MSG_CLASS_ID_CMD_NOT_PERMITTED);
+		goto vf_state_unlock;
 	}
 
 	enetc_set_si_hw_addr(pf, vf_id + 1, addr);
+
+vf_state_unlock:
 	mutex_unlock(&vf_state->lock);
 
-	return ENETC_PF_MSG_SUCCESS;
+	return pf_msg;
 }
 
 static u16 enetc_msg_handle_mac_filter(struct enetc_pf *pf, int vf_id,
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index 55c07c528f22..a7bf4bfc25b7 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -488,6 +488,7 @@ static const struct net_device_ops enetc_ndev_ops = {
 	.ndo_set_rx_mode	= enetc_pf_set_rx_mode,
 	.ndo_vlan_rx_add_vid	= enetc_vlan_rx_add_vid,
 	.ndo_vlan_rx_kill_vid	= enetc_vlan_rx_del_vid,
+	.ndo_set_vf_trust	= enetc_pf_set_vf_trust,
 	.ndo_set_vf_mac		= enetc_pf_set_vf_mac,
 	.ndo_set_vf_vlan	= enetc_pf_set_vf_vlan,
 	.ndo_set_vf_spoofchk	= enetc_pf_set_vf_spoofchk,
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
index 56d23a8a11a0..6789f92d005e 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
@@ -9,6 +9,7 @@
 
 enum enetc_vf_flags {
 	ENETC_VF_FLAG_PF_SET_MAC	= BIT(0),
+	ENETC_VF_FLAG_TRUSTED		= BIT(1),
 };
 
 struct enetc_vf_state {
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index d32a195a04c9..519fc90d2647 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -586,5 +586,28 @@ int enetc_init_sriov_resources(struct enetc_pf *pf)
 }
 EXPORT_SYMBOL_GPL(enetc_init_sriov_resources);
 
+int enetc_pf_set_vf_trust(struct net_device *ndev, int vf, bool setting)
+{
+	struct enetc_ndev_priv *priv = netdev_priv(ndev);
+	struct enetc_pf *pf = enetc_si_priv(priv->si);
+	struct enetc_vf_state *vf_state;
+
+	if (vf >= pf->total_vfs)
+		return -EINVAL;
+
+	vf_state = &pf->vf_state[vf];
+	mutex_lock(&vf_state->lock);
+
+	if (setting)
+		vf_state->flags |= ENETC_VF_FLAG_TRUSTED;
+	else
+		vf_state->flags &= ~ENETC_VF_FLAG_TRUSTED;
+
+	mutex_unlock(&vf_state->lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(enetc_pf_set_vf_trust);
+
 MODULE_DESCRIPTION("NXP ENETC PF common functionality driver");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
index 8243ce0de57f..96a4dc63da57 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
@@ -22,6 +22,7 @@ void enetc_set_si_mc_promisc(struct enetc_si *si, int si_id, bool promisc);
 void enetc_set_si_uc_hash_filter(struct enetc_si *si, int si_id, u64 hash);
 void enetc_set_si_mc_hash_filter(struct enetc_si *si, int si_id, u64 hash);
 void enetc_set_si_vlan_promisc(struct enetc_si *si, int si_id, bool promisc);
+int enetc_pf_set_vf_trust(struct net_device *ndev, int vf, bool setting);
 
 static inline u16 enetc_get_ip_revision(struct enetc_hw *hw)
 {
-- 
2.34.1

