Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013043.outbound.protection.outlook.com [40.107.159.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5335352379A;
	Wed,  9 Sep 2026 10:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788950153; cv=fail; b=X3UpexpfkDejj0jVf0BBwQe3OYKZrSFA3izShBmvPaeyLT5cX65EGuKEGMEWHKIpfNSgOntL6zeW/eYR4GDg8n/x+3aqomde3b+cYFMp2W6eLbW4+k+notTYdRn8mk7SpMxwQebsvyl0LE3jx5dXTFFDFhWqY8wC/LoXLUepuI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788950153; c=relaxed/simple;
	bh=+fEOmrNUPkrrSBqiJ9IGX6fes7Uz1Z3fC4S7qmpJ3MQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jo6RJ8lnlhXvNlee/V5ao18zwgdWDuZUI0860h8ErU/wW+cl5XksRmECarQP5E1XGHiYoWicpyVwiCR9X7EdJdqMK3e6yN/yh04tsS8HALVb/hQnwFj+aiq/sDpHwE7ZnHbofntVmHT/e+1dAfuXUs5Uo4Pfjm5Jhw0CzMyLhLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=pK7vG7km; arc=fail smtp.client-ip=40.107.159.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="pK7vG7km"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jFEtW8pwOPnZ2fp7LMwPxnzyQY6LydydMQtQ2id1T4dNXh5OXkWi3HphKW6Eq8XEDBwooTCBXhMPUX0GJueCdDa+NicNB52rI4m263+xXE0GsPZUpBwP3CPyx3CmJ28esFQovx65q1uhvvQYx02tVfv0qCB5Z/ZIBbmNkGr5K+v2szg5SdDk8YAqTF70HaRhtM5W2hdlt64zHRqDJ+UPr9HIHzhoFJ+IZ6hvLRDYiol0yIrJHh0RCt814Fr/cGgPfl9X9v71JB7E/l2esd1OuNxizwWnIFWK//lRlP5O+m83z2xH0QehELuFeBdlnTSb+u8VrVpy39V4Y+ESo8kYpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UUMxo/s0k4JdiYglX1+fI+gjsj3+xRdnH8M4temcRxs=;
 b=rKLIllmwGqeam01eQiyjLPL13AxL/+ZHCiI4cakkFtMPDONk1AKZoIxuqgahosPhG0nV59uLqULIPdNEbP0jzFJ+vXjGX2aGRdyRIaecXGtDXU7E5pnMmE+AH1nTN3OVRPF9nXV/iGJ2naBMBbV2O7txvUDPWkwrCzcGsrYp1OiWKJb5/KK6mREISgCHMmyzM+68JiE4ZreI0oYTgBYKCiF+1HRL/dt7JUch12+RYJzxPucW+Z+6Yzbn0fz1nqPdtGSHDTjWcjw1bwJ/IMcyi/nJXOSQ9sbbbTRom6ICE2gUIFTMZ5IhpDqIpcdSrr720Qmhwo0kqZ1NiriSOLUnSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UUMxo/s0k4JdiYglX1+fI+gjsj3+xRdnH8M4temcRxs=;
 b=pK7vG7km9foJ0qAKmC1JM8Ox6xQOVe9kFMYy/LdlSOdRbTSP6QpNgnUuJP0SAUINQac+yNbqQS5qWMALyPCaN5nJeP0Bd8yY2GzdhZXmTCcb8oOnRphXHykn7pfStjuaIElFRIdyqUt0deEcx411tMeP47+2xQQkjo3gbYZ+7Ylyp5tRPvGLzCz9I8lBetiHcR6ATKNvWhO/H5BewfUR6TjwVELRxC3A1E+3pgSq1eI0a8SQ0tL0dRwwEm/A3POp5Rq5oA6Q1jiVmxPTSv2jPeQ2DGvO88CSGdbK1ozvsScnbYOieWcx5N1or8Bl4Nwvj3zIsDrWam2wFA5UmDxoPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by DB8PR04MB7066.eurprd04.prod.outlook.com (2603:10a6:10:12e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Wed, 9 Sep 2026
 10:35:47 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 10:35:47 +0000
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
Subject: [PATCH v4 net-next 03/15] net: enetc: add link status message support to PF driver
Date: Wed,  9 Sep 2026 18:07:21 +0800
Message-Id: <20260909100733.1139689-4-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260909100733.1139689-1-wei.fang@oss.nxp.com>
References: <20260909100733.1139689-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:196::15) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|DB8PR04MB7066:EE_
X-MS-Office365-Filtering-Correlation-Id: 941bbb94-a51e-4990-eddb-08df0e5e1c1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|376014|1800799024|23010399003|366016|10067099003|11063799006|56012099006|6133799003|21046099003|3023799007|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	cNfp4g1ljQ47bleteLsHWtl495ZpDbFUA14G6QzBqaGY6cEWZcDHpNCQe3MW+JY7U/euFP3w5Xsi95pfdbgY68c2I4cJiC5GSw5uAbBdhTmzAm6VQimMmMORRGWqxtTbenpJonGphPO33TievIofCjIMNGVnTiyc0dhrdvrvJas3ef5nKL6bl6B/lz9+TaAV4x4JGlgwkGomklBfTrmznnqiTBXeeMtgAEwA78Of3jJZEQ4fnE/XFpaybmijcIrpBc8wSWkbqprJpbQsE2Rd6QGe4057AK2Bz7rOh/2R5kXaEgTc033Tg6WhKGSCzYS0vs/YrptEIdd6NWoLDtskU/HOSJjJBcyqRMpkyR73zqGxbxSaBtEUMKdFKMZ8B7sWMCF2Q2lSOTS2Tir86XiVQRhIE5TH1qUuGOlKAmlpX2XMGIL2deX8H9qh+8xoIVZ3olFgHrPNMnkX9MQByoyB+yK1zNpvvd6AC0+/mK/K3DO2FmSZFOqI5mi2L3a2GFIfnSGtXYST3I4RgVBpigA9W6AqzsyJQMqiKuqlzbmEXliQYggRi82s7yuVRQSGbv3dmRiERjgGrK7DEPm0D0pX6oJfMOqoOS9u8cR0ylhojJGx5kDUvFaRlJ0+0+AnhF8MOXcA3kC70MLgD0L2gMngxJVh1poLkJUInRYivPMCg77DyXflGv120RyMBv8ginq0Ux0TDMXZx818bhqFh6Zm/g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(1800799024)(23010399003)(366016)(10067099003)(11063799006)(56012099006)(6133799003)(21046099003)(3023799007)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VnLfHSrT4nCTYPX2cX5+sKbE0tnJwv87DZvVgXgW5CwiaMjK/fUqFp/UlXm+?=
 =?us-ascii?Q?37QCqb/XMK04OGJmNdbK5/lsQzGnah9ZwzeoD8FX5E64Mwoa7mG3EIPkzG6E?=
 =?us-ascii?Q?24ndtYcLd0JDNZQw8Rae4a2hdCRZsGD/woNALGw+tEKk5L0xbzbjraR9Cpzo?=
 =?us-ascii?Q?vqQjke50cRGzInndAsfg7SrA3Hkuln9oFpWA1S2IO2RhihpoKBIjn1FIoWnk?=
 =?us-ascii?Q?gOb7bjdI5YdsQUds9Z8djMxcREJJ0oGrDMShk6nA7GDXF7VJvI3DgUgDtbkG?=
 =?us-ascii?Q?d+KRylRgzn6Z12gCW9VosMsNJgzcEIIiYFx4DCWXCyrv1yxTPmshXRZEGGL7?=
 =?us-ascii?Q?yejuuuDTalZ8FlUYrpBoxGSqnALR69oR9+Urt9FhFpKBF+/CTCOsaLnAhZKC?=
 =?us-ascii?Q?hPWvS2aytstRNacz6wRkHXfuSO3z607q2p+h+00iJsRr8WGyIsBEd8n9JaxE?=
 =?us-ascii?Q?NKw+O7ykf/JqcsYymQOxLz3FyzAbBewpvJ9RDuNum6zd0WNML7v7ju+InxfQ?=
 =?us-ascii?Q?iJ/EOYPAHpzrPesWscgpJKuC8bnZmDYLT+uEHwD5VsHONCqNUcoBU9/Axn41?=
 =?us-ascii?Q?sW3PeaqMsHw1CukMET2vq+EE8NBWBAhiirWnesTrE7tiVCLOfiZlLKofSMCO?=
 =?us-ascii?Q?RfKLnoPETZkdhSRRVkOE7yyRb97MGElTJI+ERKj3BTyd1g4lGy+y5Q8VkZ1g?=
 =?us-ascii?Q?kT7/OHG7uYC1A64CfyANy/z7UooCVNAf/9sGyy9+YwXaPATUv1g92QD1CQR5?=
 =?us-ascii?Q?198nbUV9SBqXCa64we7J+pJN3nXvZstbMyCC4Db552BLZOjeBG8/DhpW0S5+?=
 =?us-ascii?Q?Z7aiOLRrL9r7XoayvkF75rEoml1ApH8Rpj/D92AjqnErXLcCbhArZxEBGv2a?=
 =?us-ascii?Q?Jwqk3BKAkAOw/Dg4Rc7cTSVBJLiyiiX7+PWSfT5safovXLyJn/N0XxBIWhD4?=
 =?us-ascii?Q?iyrHsnu6T8Y1yqkehJw4pdmoVFBt1rNc9yAot/cyzhd3praAJQdlNTPHLd4d?=
 =?us-ascii?Q?uPIbewX+OkaYNaHzozJFG4hnzVbB6SIFopB/ZJapPrXYPGVLx6tIztUZxOZI?=
 =?us-ascii?Q?Pq+DrDimWYItVZ+tzqpNJs2ovt2rw09ZAAdUWxhDJrOwnKMohEDA2UXd8/kJ?=
 =?us-ascii?Q?caCN9xNaEwXbpZ7bm5IE2DL16Sf9AoGavgauKgzcVW0oz9IurV863i2VylBd?=
 =?us-ascii?Q?HyS4bPguOA1UQKkDqn7+xgiMkKh5E5UlnaHvlY42ZS1as+7lRFCYrErHWuv0?=
 =?us-ascii?Q?USQd5Zm7abeXFBh0m7m599pETPJnJqqIKIWYZSvG0hhsXgCrmZyAdUBP3fjO?=
 =?us-ascii?Q?oRTzC4wIU/3NQM5rQYM0XKK93URj31LH0GWnxnk1geHomzbu5csoL+ohHGOf?=
 =?us-ascii?Q?ut7G1CgtdDCQNVv0Kub9OZes8tBQ+sPVhJPAaKhPH5Kj9uG0PfwY+xMnURmb?=
 =?us-ascii?Q?6Xqi4Z9yj1huWd5y90AXDqWyp9L8uO8yQdAo2vjXhq4OGizfr47BN/JdpOYD?=
 =?us-ascii?Q?i3r/WbJ5b2AOZsIJk27MbnPEiIdJjujRg78R2NIXmEfxUxIc8wUZQoXzWLFS?=
 =?us-ascii?Q?gONEK++BSaLi3IgwIYLE+Rsk4UxGY0Ob70KpJK/5mGvhU9rSEF30h1jItIwl?=
 =?us-ascii?Q?nd4zXT4Iz+CTts+6EyOVgzJvbWDcxoZezfDWVAGTXa9mEFEcKDuASwzFMJtE?=
 =?us-ascii?Q?OXaxnTaaE17W7ixzuu/p22qb4Ji5afjnlMaeP11KeYbNS0zfrCvnw/Px/S2e?=
 =?us-ascii?Q?FicQk2tBr7T92Ye9wwqE6ooVM6djJNsZGXNuaTj1Z7nI4o/L96IX?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 941bbb94-a51e-4990-eddb-08df0e5e1c1a
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 10:35:47.3800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ij3GKKEZ/EHe+SuQUKiMQC43NRN7WO6YUIjS1WK36qcMpHvdFw+C5uc2vNM6fg7iFMbwghQUZxVKS5lR52AdpOqqQzwd7jzV2+b6TV7fBlb44Na2qUfXW9S4tw7HBHP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7066

From: Wei Fang <wei.fang@nxp.com>

Add a mechanism for VFs to learn the PF link state, using message class
0x80 (ENETC_MSG_CLASS_ID_LINK_STATUS) with three VSI-to-PSI commands:

1. ENETC_MSG_GET_CURRENT_LINK_STATUS: the VF queries the current PF link
   status synchronously. This is intended for DPDK-owned VFs and is not
   used by the Linux VF driver.
2. ENETC_MSG_REGISTER_LINK_CHANGE_NOTIFIER: the VF registers for link
   change notification. The PF then reports the current link status and
   notifies the VF on every later link change.
3. ENETC_MSG_UNREGISTER_LINK_CHANGE_NOTIFIER: the VF unregisters.

The PSI-to-VSI notification is 16 bits wide: the upper 8 bits carry the
class ID and the lower 8 bits the class code. Bit 0 of the class code
indicates the link state (1 = down, 0 = up) and bit 1 indicates whether
TX PAUSE is enabled on the PF. The TX PAUSE state is included so a VF
can decide whether to enable congestion mode on its RX BD rings, which
only works when the PF can actually send PAUSE frames.

Notifications are sent through the ENETC_PSIMSGSR register. Since sending
a notification may take a long time, as it polls the per-VF message
status bits, the actual transmission is deferred to an ordered workqueue
rather than running in the phylink link_up/link_down callbacks. The
link_status_ms_mask tracks the VFs registered for notification and is
cleared when SR-IOV is disabled.

Export enetc_pf_notify_vf_link_up() and enetc_pf_notify_vf_link_down()
for the PF phylink callbacks. Through this, VFs can perceive the link
status and report it to upper layers such as the kernel network stack,
containers and virtual machines.

Currently only the ENETC v4 driver supports this feature; v1 does not.
And the SR-IOV feature of ENETC v4 will be added by subsequent patches.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.h  |   1 +
 .../net/ethernet/freescale/enetc/enetc4_pf.c  |  39 +++
 .../net/ethernet/freescale/enetc/enetc_hw.h   |   5 +
 .../ethernet/freescale/enetc/enetc_mailbox.h  |  26 +-
 .../net/ethernet/freescale/enetc/enetc_msg.c  | 264 +++++++++++++++++-
 .../net/ethernet/freescale/enetc/enetc_pf.h   |   7 +
 .../freescale/enetc/enetc_pf_common.h         |  15 +
 7 files changed, 347 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index bc713a7c3aa1..0eff25b0c81b 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -334,6 +334,7 @@ struct enetc_si {
 
 	struct dentry *debugfs_root;
 	struct enetc_msg_swbd msg; /* Only valid for VSI */
+	struct workqueue_struct *workqueue;
 	struct work_struct msg_task;
 	char msg_int_name[ENETC_INT_NAME_MAX];
 };
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 935a6a03b14f..e20989b6f8b4 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -899,6 +899,7 @@ static void enetc4_pl_mac_link_up(struct phylink_config *config,
 	enetc4_set_rx_pause(pf, rx_pause);
 	enetc4_mac_tx_enable(pf);
 	enetc4_mac_rx_enable(pf);
+	enetc_pf_notify_vf_link_up(pf);
 }
 
 static void enetc4_pl_mac_link_down(struct phylink_config *config,
@@ -907,6 +908,7 @@ static void enetc4_pl_mac_link_down(struct phylink_config *config,
 {
 	struct enetc_pf *pf = phylink_to_enetc_pf(config);
 
+	enetc_pf_notify_vf_link_down(pf);
 	enetc4_mac_rx_graceful_stop(pf);
 	enetc4_mac_tx_graceful_stop(pf);
 }
@@ -966,6 +968,36 @@ static void enetc4_link_deinit(struct enetc_ndev_priv *priv)
 	enetc_mdiobus_destroy(pf);
 }
 
+static void enetc4_pf_link_status_task(struct work_struct *work)
+{
+	struct enetc_pf *pf = container_of(work, struct enetc_pf,
+					   link_status_task);
+
+	enetc_pf_send_link_status_msg(pf);
+}
+
+static int enetc4_pf_wq_task_init(struct enetc_si *si)
+{
+	struct enetc_pf *pf = enetc_si_priv(si);
+
+	si->workqueue = alloc_ordered_workqueue("enetc-%s-wq", 0,
+						pci_name(si->pdev));
+	if (!si->workqueue)
+		return -ENOMEM;
+
+	INIT_WORK(&pf->link_status_task, enetc4_pf_link_status_task);
+
+	return 0;
+}
+
+static void enetc4_pf_wq_task_destroy(struct enetc_si *si)
+{
+	struct enetc_pf *pf = enetc_si_priv(si);
+
+	disable_work_sync(&pf->link_status_task);
+	destroy_workqueue(si->workqueue);
+}
+
 static int enetc4_pf_netdev_create(struct enetc_si *si)
 {
 	struct device *dev = &si->pdev->dev;
@@ -1006,6 +1038,10 @@ static int enetc4_pf_netdev_create(struct enetc_si *si)
 	if (err)
 		goto err_link_init;
 
+	err = enetc4_pf_wq_task_init(si);
+	if (err)
+		goto err_wq_init;
+
 	err = register_netdev(ndev);
 	if (err) {
 		dev_err(dev, "Failed to register netdev\n");
@@ -1015,6 +1051,8 @@ static int enetc4_pf_netdev_create(struct enetc_si *si)
 	return 0;
 
 err_reg_netdev:
+	enetc4_pf_wq_task_destroy(si);
+err_wq_init:
 	enetc4_link_deinit(priv);
 err_link_init:
 	enetc_free_msix(priv);
@@ -1032,6 +1070,7 @@ static void enetc4_pf_netdev_destroy(struct enetc_si *si)
 	struct net_device *ndev = si->ndev;
 
 	unregister_netdev(ndev);
+	enetc4_pf_wq_task_destroy(si);
 	enetc4_link_deinit(priv);
 	enetc_free_msix(priv);
 	free_netdev(ndev);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index 16da732dc5de..f97602714118 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -80,6 +80,11 @@ static inline u32 enetc_vsi_set_msize(u32 size)
 #define ENETC_SIMSGSR_SET_MC(val) ((val) << 16)
 #define ENETC_SIMSGSR_GET_MC(val) ((val) >> 16)
 
+#define ENETC_PSIMSGSR		0x208
+/* n is VF index, which is less than 15 */
+#define  PSIMSGSR_MS(n)		BIT((n) + 1)
+#define  PSIMSGSR_MC		GENMASK(31, 16)
+
 /* SI statistics */
 #define ENETC_SIROCT	0x300
 #define ENETC_SIRFRM	0x308
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_mailbox.h b/drivers/net/ethernet/freescale/enetc/enetc_mailbox.h
index d9677da38989..846998f07989 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_mailbox.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_mailbox.h
@@ -66,8 +66,8 @@
  * 2) PSI_TX_control: PSIMSGSR[MC] - for PSI to VSI notification messages
  * (async mode)
  *
- * Note that for some GET messages, there is no COOKIE field, and the CLASS
- * CODE field is expanded to 8 bits.
+ * Note that for some PSI-to-VSI messages, there is no COOKIE field, and the
+ * CLASS CODE field is expanded to 8 bits.
  */
 
 #ifndef __ENETC_MAILBOX_H
@@ -87,7 +87,11 @@
 /* The fileds of PSI-to-VSI message, the message is only 16-bit */
 #define ENETC_PF_MSG_COOKIE			GENMASK(3, 0)
 #define ENETC_PF_MSG_CLASS_CODE			GENMASK(7, 4)
-/* Extend the class code to 8-bit for GET messages without COOKIE */
+/* Extend the class code to 8-bit for PSI-to-VSI messages without COOKIE
+ * The class code for the following messages is 8-bit.
+ * 1. Get IP revision messages
+ * 2. Link status messages
+ */
 #define ENETC_PF_MSG_CLASS_CODE_U8		GENMASK(7, 0)
 #define ENETC_PF_MSG_CLASS_ID			GENMASK(15, 8)
 
@@ -107,6 +111,7 @@ enum enetc_msg_class_id {
 
 	/* Common Class ID for PSI-to-VSI and VSI-to-PSI messages */
 	ENETC_MSG_CLASS_ID_MAC_FILTER		= 0x20,
+	ENETC_MSG_CLASS_ID_LINK_STATUS		= 0x80,
 	ENETC_MSG_CLASS_ID_IP_REVISION		= 0xf0,
 };
 
@@ -118,11 +123,21 @@ enum enetc_msg_ip_revision_cmd_id {
 	ENETC_MSG_GET_IP_MN			= 1,
 };
 
+enum enetc_msg_link_status_cmd_id {
+	ENETC_MSG_GET_CURRENT_LINK_STATUS,
+	ENETC_MSG_REGISTER_LINK_CHANGE_NOTIFIER,
+	ENETC_MSG_UNREGISTER_LINK_CHANGE_NOTIFIER,
+};
+
 /* Class-specific error return codes of MAC filter */
 enum enetc_mac_filter_class_code {
 	ENETC_MF_CLASS_CODE_INVALID_MAC,
 };
 
+/* Class-specific notifications/codes of link status */
+#define ENETC_CLASS_CODE_LINK_DOWN		BIT(0)
+#define ENETC_CLASS_CODE_TX_PAUSE_EN		BIT(1)
+
 struct enetc_msg_swbd {
 	void *vaddr;
 	dma_addr_t dma;
@@ -161,6 +176,11 @@ struct enetc_msg_mac_exact_filter {
 /* The generic message format applies to the following messages:
  * Get IP revision message, class_id 0xf0.
  * cmd_id 1: get IP minor revision
+ *
+ * Link status message, class id 0x80.
+ * cmd_id 0x0: get the current link status
+ * cmd_id 0x1: register link status change notification
+ * cmd_id 0x2: unregister link status change notification
  */
 struct enetc_msg_generic {
 	struct enetc_msg_header hdr;
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_msg.c b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
index a89a5a418a23..79dbaf72fcff 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_msg.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
@@ -136,6 +136,104 @@ static u16 enetc_msg_handle_ip_revision(struct enetc_pf *pf, void *vf_msg)
 	}
 }
 
+static void enetc_pf_reply_msg(struct enetc_hw *hw, int vf_id, u16 pf_msg)
+{
+	/* w1c to clear the corresponding VF MR bit */
+	enetc_wr(hw, ENETC_PSIIDR, ENETC_PSIMR_BIT(vf_id));
+	enetc_wr(hw, ENETC_PSIMSGRR, ENETC_SIMSGSR_SET_MC(pf_msg) |
+		 ENETC_PSIMR_BIT(vf_id));
+}
+
+static u16 enetc_build_link_status_msg(struct enetc_ndev_priv *priv,
+				       bool link_up)
+{
+	u8 status = 0;
+
+	if (link_up) {
+		if (test_bit(ENETC_RXBDR_CM, &priv->flags))
+			status |= ENETC_CLASS_CODE_TX_PAUSE_EN;
+	} else {
+		status |= ENETC_CLASS_CODE_LINK_DOWN;
+	}
+
+	return FIELD_PREP(ENETC_PF_MSG_CLASS_ID,
+			  ENETC_MSG_CLASS_ID_LINK_STATUS) |
+	       FIELD_PREP(ENETC_PF_MSG_CLASS_CODE_U8, status);
+}
+
+static void enetc_msg_get_link_status(struct enetc_pf *pf, int vf_id)
+{
+	struct enetc_ndev_priv *priv = netdev_priv(pf->si->ndev);
+	struct enetc_si *si = pf->si;
+	u16 pf_msg;
+
+	spin_lock(&si->gen_lock);
+	pf_msg = enetc_build_link_status_msg(priv, pf->link_up);
+	enetc_pf_reply_msg(&si->hw, vf_id, pf_msg);
+	spin_unlock(&si->gen_lock);
+}
+
+static void enetc_msg_register_link_status_notifier(struct enetc_pf *pf,
+						    int vf_id)
+{
+	struct enetc_si *si = pf->si;
+
+	spin_lock(&si->gen_lock);
+	enetc_pf_reply_msg(&si->hw, vf_id, ENETC_PF_MSG_SUCCESS);
+
+	/* SR-IOV is being disabled if pf->sriov_enabled is false, so no
+	 * need to set link_status_ms_mask and notify the link status.
+	 */
+	if (!pf->sriov_enabled) {
+		spin_unlock(&si->gen_lock);
+		return;
+	}
+
+	pf->link_status_ms_mask |= PSIMSGSR_MS(vf_id);
+	spin_unlock(&si->gen_lock);
+
+	/* Notify VF the current link status */
+	queue_work(si->workqueue, &pf->link_status_task);
+}
+
+static void enetc_msg_unregister_link_status_notifier(struct enetc_pf *pf,
+						      int vf_id)
+{
+	spin_lock(&pf->si->gen_lock);
+	pf->link_status_ms_mask &= ~PSIMSGSR_MS(vf_id);
+	enetc_pf_reply_msg(&pf->si->hw, vf_id, ENETC_PF_MSG_SUCCESS);
+	spin_unlock(&pf->si->gen_lock);
+}
+
+static u16 enetc_msg_handle_link_status(struct enetc_pf *pf, int vf_id,
+					void *vf_msg)
+{
+	struct enetc_msg_header *msg_hdr = vf_msg;
+
+	switch (msg_hdr->cmd_id) {
+	case ENETC_MSG_GET_CURRENT_LINK_STATUS:
+		/* Currently, this message is intended only for
+		 * DPDK-owned VFs.
+		 */
+		enetc_msg_get_link_status(pf, vf_id);
+		break;
+	case ENETC_MSG_REGISTER_LINK_CHANGE_NOTIFIER:
+		enetc_msg_register_link_status_notifier(pf, vf_id);
+		break;
+	case ENETC_MSG_UNREGISTER_LINK_CHANGE_NOTIFIER:
+		enetc_msg_unregister_link_status_notifier(pf, vf_id);
+		break;
+	default:
+		return ENETC_PF_MSG_NOTSUPP;
+	}
+
+	return 0;
+}
+
+/* If *pf_msg is set to 0, it means that PF has responded to VF in
+ * enetc_msg_handle_rxmsg() through enetc_pf_reply_msg(), which also
+ * clears the corresponding VF MR bit in PSIIDR.
+ */
 static void enetc_msg_handle_rxmsg(struct enetc_pf *pf, int vf_id,
 				   u16 *pf_msg)
 {
@@ -211,6 +309,9 @@ static void enetc_msg_handle_rxmsg(struct enetc_pf *pf, int vf_id,
 	case ENETC_MSG_CLASS_ID_IP_REVISION:
 		*pf_msg = enetc_msg_handle_ip_revision(pf, msg);
 		break;
+	case ENETC_MSG_CLASS_ID_LINK_STATUS:
+		*pf_msg = enetc_msg_handle_link_status(pf, vf_id, msg);
+		break;
 	default:
 		dev_err_ratelimited(dev,
 				    "Unsupported message class ID: 0x%x\n",
@@ -236,7 +337,6 @@ static void enetc_msg_task(struct work_struct *work)
 		goto out;
 
 	for (i = 0; i < pf->num_vfs; i++) {
-		u32 psimsgrr;
 		u16 msg_code;
 
 		if (!(ENETC_PSIMR_BIT(i) & mr_status))
@@ -244,12 +344,14 @@ static void enetc_msg_task(struct work_struct *work)
 
 		enetc_msg_handle_rxmsg(pf, i, &msg_code);
 
-		/* w1c to clear the corresponding VF MR bit */
-		enetc_wr(hw, ENETC_PSIIDR, ENETC_PSIMR_BIT(i));
+		/* If msg_code is 0, it means that PF has responded to VF
+		 * in enetc_msg_handle_rxmsg() through enetc_pf_reply_msg(),
+		 * which also clears the corresponding VF MR bit in PSIIDR.
+		 */
+		if (!msg_code)
+			continue;
 
-		psimsgrr = ENETC_SIMSGSR_SET_MC(msg_code);
-		psimsgrr |= ENETC_PSIMR_BIT(i); /* w1c */
-		enetc_wr(hw, ENETC_PSIMSGRR, psimsgrr);
+		enetc_pf_reply_msg(hw, i, msg_code);
 	}
 
 out:
@@ -340,6 +442,22 @@ static int enetc_msg_psi_init(struct enetc_pf *pf)
 	return err;
 }
 
+static void enetc_msg_clear_vf_config(struct enetc_pf *pf, int vf_id)
+{
+	struct enetc_vf_state *vf_state = &pf->vf_state[vf_id];
+	struct enetc_si *si = pf->si;
+
+	/* For ENETC v1, we only support setting the VF's MAC address via
+	 * VSI-to-PSI messages, so there is no configuration to clear.
+	 */
+	if (is_enetc_rev1(si))
+		return;
+
+	spin_lock(&si->gen_lock);
+	vf_state->msg_fail_cnt = 0;
+	spin_unlock(&si->gen_lock);
+}
+
 static void enetc_msg_psi_free(struct enetc_pf *pf)
 {
 	struct enetc_si *si = pf->si;
@@ -356,8 +474,10 @@ static void enetc_msg_psi_free(struct enetc_pf *pf)
 	/* MR interrupts may be re-enabled by workqueue */
 	enetc_msg_disable_mr_int(pf);
 
-	for (i = 0; i < pf->num_vfs; i++)
+	for (i = 0; i < pf->num_vfs; i++) {
 		enetc_msg_free_mbx(si, i);
+		enetc_msg_clear_vf_config(pf, i);
+	}
 }
 
 int enetc_sriov_configure(struct pci_dev *pdev, int num_vfs)
@@ -367,6 +487,11 @@ int enetc_sriov_configure(struct pci_dev *pdev, int num_vfs)
 	int err;
 
 	if (!num_vfs) {
+		spin_lock(&si->gen_lock);
+		pf->sriov_enabled = false;
+		pf->link_status_ms_mask = 0;
+		spin_unlock(&si->gen_lock);
+
 		pci_disable_sriov(pdev);
 		enetc_msg_psi_free(pf);
 		pf->num_vfs = 0;
@@ -379,6 +504,11 @@ int enetc_sriov_configure(struct pci_dev *pdev, int num_vfs)
 			goto err_msg_psi;
 		}
 
+		/* As PCI SR-IOV is not enabled at the moment, there is no
+		 * concurrent access to sriov_enabled. So no need to use
+		 * gen_lock to protect sriov_enabled.
+		 */
+		pf->sriov_enabled = true;
 		err = pci_enable_sriov(pdev, num_vfs);
 		if (err) {
 			dev_err(&pdev->dev, "pci_enable_sriov err %d\n", err);
@@ -389,6 +519,15 @@ int enetc_sriov_configure(struct pci_dev *pdev, int num_vfs)
 	return num_vfs;
 
 err_en_sriov:
+	/* If pci_enable_sriov() fails after partially creating VFs, a VF
+	 * driver that successfully bound to one of the created VFs could
+	 * have sent a registration message, setting its bit in
+	 * link_status_ms_mask.
+	 */
+	spin_lock(&si->gen_lock);
+	pf->sriov_enabled = false;
+	pf->link_status_ms_mask = 0;
+	spin_unlock(&si->gen_lock);
 	enetc_msg_psi_free(pf);
 err_msg_psi:
 	pf->num_vfs = 0;
@@ -396,3 +535,114 @@ int enetc_sriov_configure(struct pci_dev *pdev, int num_vfs)
 	return err;
 }
 EXPORT_SYMBOL_GPL(enetc_sriov_configure);
+
+void enetc_pf_send_link_status_msg(struct enetc_pf *pf)
+{
+	struct enetc_ndev_priv *priv = netdev_priv(pf->si->ndev);
+	u16 pf_msg, ms_mask, new_ms_msk, ms_status;
+	struct enetc_si *si = pf->si;
+	int retry_num = 0;
+
+retry:
+	spin_lock(&si->gen_lock);
+	ms_mask = pf->link_status_ms_mask;
+	/* VFs have unregistered link status notification, return directly  */
+	if (!ms_mask)
+		goto unlock;
+
+	/* The MS bit is set, indicating that the corresponding VF has not
+	 * read the last message, PF cannot send new message to the VF. To
+	 * avoid sending messages to such a VF, the bit corresponding to VF
+	 * is cleared from ms_mask. Because the MS bit can only be written
+	 * as 1, writing a 0 has no effect. Writing a 1 when the bit is
+	 * already set is undefined.
+	 */
+	ms_status = enetc_rd(&si->hw, ENETC_PSIMSGSR) & 0xfffe;
+	if ((ms_mask & ms_status) && retry_num++ < 200) {
+		spin_unlock(&si->gen_lock);
+		/* Wait VFs to handle the last message */
+		usleep_range(1000, 1020);
+		goto retry;
+	}
+
+	/* None of the relevant VFs have processed the previous message, and
+	 * the PF has tried 200 times. This situation indicates that VF has
+	 * malfunctioned.
+	 */
+	new_ms_msk = ms_mask & (~ms_status);
+	if (!new_ms_msk) {
+		dev_err_ratelimited(&si->pdev->dev,
+				    "All registered VFs (MS: 0x%x) are busy\n",
+				    ms_mask);
+		goto ms_status_check;
+	}
+
+	if (new_ms_msk != ms_mask)
+		dev_warn_ratelimited(&si->pdev->dev,
+				     "Failed to notify link status to VFs (MS: 0x%x)\n",
+				     ms_mask ^ new_ms_msk);
+
+	pf_msg = enetc_build_link_status_msg(priv, pf->link_up);
+	enetc_wr(&si->hw, ENETC_PSIMSGSR,
+		 FIELD_PREP(PSIMSGSR_MC, pf_msg) | new_ms_msk);
+
+ms_status_check:
+	/* If the PF fails to send messages to the corresponding VF for 10
+	 * consecutive times, clear that VF's bit in link_status_ms_mask.
+	 */
+	for (int i = 0; i < pf->num_vfs; i++) {
+		struct enetc_vf_state *vf_state = &pf->vf_state[i];
+
+		if (!(PSIMSGSR_MS(i) & ms_mask))
+			continue;
+
+		if (!(PSIMSGSR_MS(i) & ms_status)) {
+			vf_state->msg_fail_cnt = 0;
+			continue;
+		}
+
+		if (vf_state->msg_fail_cnt++ < 10)
+			continue;
+
+		vf_state->msg_fail_cnt = 0;
+		pf->link_status_ms_mask &= ~PSIMSGSR_MS(i);
+		dev_warn_ratelimited(&si->pdev->dev,
+				     "Clear VF%d's link status MS bit\n", i);
+	}
+
+unlock:
+	spin_unlock(&si->gen_lock);
+}
+EXPORT_SYMBOL_GPL(enetc_pf_send_link_status_msg);
+
+static void enetc_pf_notify_vf_link_status(struct enetc_pf *pf,
+					   bool link_up)
+{
+	struct enetc_si *si = pf->si;
+
+	/* Currently we do not add link status message support for ENETC v1 */
+	if (!pf->total_vfs || is_enetc_rev1(si))
+		return;
+
+	spin_lock(&si->gen_lock);
+	pf->link_up = link_up;
+	if (!pf->link_status_ms_mask) {
+		spin_unlock(&si->gen_lock);
+		return;
+	}
+	spin_unlock(&si->gen_lock);
+
+	queue_work(si->workqueue, &pf->link_status_task);
+}
+
+void enetc_pf_notify_vf_link_up(struct enetc_pf *pf)
+{
+	enetc_pf_notify_vf_link_status(pf, true);
+}
+EXPORT_SYMBOL_GPL(enetc_pf_notify_vf_link_up);
+
+void enetc_pf_notify_vf_link_down(struct enetc_pf *pf)
+{
+	enetc_pf_notify_vf_link_status(pf, false);
+}
+EXPORT_SYMBOL_GPL(enetc_pf_notify_vf_link_down);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
index 142c911f1dfc..b3ad498f91a0 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
@@ -15,6 +15,8 @@ enum enetc_vf_flags {
 struct enetc_vf_state {
 	struct mutex lock; /* Prevent concurrent access */
 	enum enetc_vf_flags flags;
+	/* Number of consecutive failures to send PF-to-VF messages */
+	int msg_fail_cnt;
 };
 
 struct enetc_port_caps {
@@ -54,6 +56,11 @@ struct enetc_pf {
 
 	struct enetc_port_caps caps;
 	const struct enetc_pf_ops *ops;
+
+	struct work_struct link_status_task;
+	bool sriov_enabled;
+	bool link_up;
+	u16 link_status_ms_mask;
 };
 
 #define phylink_to_enetc_pf(config) \
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
index 96a4dc63da57..bcf113efc2ef 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
@@ -31,9 +31,24 @@ static inline u16 enetc_get_ip_revision(struct enetc_hw *hw)
 
 #if IS_ENABLED(CONFIG_PCI_IOV)
 int enetc_sriov_configure(struct pci_dev *pdev, int num_vfs);
+void enetc_pf_send_link_status_msg(struct enetc_pf *pf);
+void enetc_pf_notify_vf_link_up(struct enetc_pf *pf);
+void enetc_pf_notify_vf_link_down(struct enetc_pf *pf);
 #else
 static inline int enetc_sriov_configure(struct pci_dev *pdev, int num_vfs)
 {
 	return 0;
 }
+
+static inline void enetc_pf_send_link_status_msg(struct enetc_pf *pf)
+{
+}
+
+static inline void enetc_pf_notify_vf_link_up(struct enetc_pf *pf)
+{
+}
+
+static inline void enetc_pf_notify_vf_link_down(struct enetc_pf *pf)
+{
+}
 #endif
-- 
2.34.1

