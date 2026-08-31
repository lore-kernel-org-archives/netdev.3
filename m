Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012010.outbound.protection.outlook.com [52.101.66.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C683B19D8;
	Mon, 31 Aug 2026 03:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788146598; cv=fail; b=txi2aSkzum7iSwVhU4mJuvOvmTiLBneRPNoKMp8ArvgedR0sQjQ8YI/hm+RxTuf3wNXFE1640gMw/E3ddBRWlV/jJ/alHo7cM1wVuueLaaPFmTB4LNMAHNK0eewdKWQm6H7mTsFKxn1jRAATK3Hbm10UjNVsrIFeskn6Xm4V1uI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788146598; c=relaxed/simple;
	bh=PUv8mpcUeIYih8jFEEddfRnKBeqpCzuRIjeEPplyKUY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Bmoz5TynwcnLdxGeJ3t+qQSflAFwrzKkg1ROubNUbFs1oVu7cU2cXtBD5AFt7n/CrUKJn1KmI/KGTJiOWFGrFQQGpmRa+39OPaqvSCdLi+X5UL1B/IP7MV1/0RZkJlKdoXcfsk6dlWFjDU6ecSpe6u8H21U5vwOmJxZxgXcWToU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=trvqFbPj; arc=fail smtp.client-ip=52.101.66.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="trvqFbPj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=swtP9EXYLoRZuFGlFXFvub8Ce5AgnkzHe4+obU7/fzKwx0FBNhCHmI6bC3g8d36vHnU22mtcq+rLDCNlNFKM5XvW6b3K+djR1oEXPUsa/yT7TcNlHJGs0ojlaa79eZndw8wAQhFy9T2q8SSNekwd70IrVG4nho4sfa8aalmGSPAT8J+BpgN80LeLirokpg5UbtEpRjHRvSSpSa8CboGmZnDmsPsFcRSFDwGGqd/8HVo317Ul27e6YoYjHiFbCPexAJYmLTyplAlPchDTqTdcFMU+E0nsFQNBBe0BTFS3SVlai78pPuS2008hj7CSo/0uuph7SPq5PUP1eZq7PNkHOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XBkkLcZbTvjYg9JlktrV7KYuEhYmJgPvvQhqTVWKCNI=;
 b=Cfcn0wSFldio7FpT8q0N598fX4j6TxHN7XCEKCK4CqqMKx3NTKnPWPW/S3BZAoL7F7s+wfuO4NDvVU4DuWMJye8Gyc9rvCoJ58yYxhhyHJBKEEjETBA40A5V+o2m/0OLu1sW7JtUxvpTkwvF4CHyf1Uf8CYGehK1SLnli/A+WFev8s3fQMbkRdoG6Y9rssvmtd7AEQU5I2gZ287woa2WdSwBPJUQM9Se66KOrYT5tw7l9ot7QlqpXa34qo9383AEgqOIKxvtef5f8/HBApDhxwkKa86cIqXQFWkTIPSgWnO9FR2cs3X0G9ZcotgEw+iFugjfgsI7pAerw1RlVpMR/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBkkLcZbTvjYg9JlktrV7KYuEhYmJgPvvQhqTVWKCNI=;
 b=trvqFbPjf6birg9CAiTIV1SvTDzaJeV8h9JH6WjJbCbkw8Hy3Sx/cw4qdQ4qfEnrI25TOOJJBwfi7pBHPB/k5D0lxfe3nDAwR2pJmP8LEDDxJQcVhfHwgDTDnXwesSwJj4NXTDb39BRdFCJSGSAXvzQubFUULGbLbmrcnF3X5awzsfxPq+cc80MKcBaSegymuDgal6RwJ9zPqsVXj52BT6w3h5zniFoAro2STpTTVwu2Xwxs1fysteiiT/muffU/b/W4Bdibor2RssjG14ZuP9rzo8Ychsz9PzCUsFfOCtV+TRf9lhzMt9tKYuHHy7Ml73VuOA/c4cfaMc0PMSHYDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by DB9PR04MB9234.eurprd04.prod.outlook.com (2603:10a6:10:372::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 03:23:12 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 03:23:11 +0000
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
Subject: [PATCH v3 net-next 09/15] net: enetc: add MAC address filtering support for VFs of ENETC v4
Date: Mon, 31 Aug 2026 10:54:35 +0800
Message-Id: <20260831025441.635045-10-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260831025441.635045-1-wei.fang@oss.nxp.com>
References: <20260831025441.635045-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::20) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|DB9PR04MB9234:EE_
X-MS-Office365-Filtering-Correlation-Id: 0526c5fb-3cfb-4d43-3779-08df070f2fcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|23010399003|1800799024|7416014|376014|10067099003|6133799003|18002099003|32116099003|22082099003|18092099006|21046099003|11063799006|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	FgSsWB1ePaiGOKNitdvCY0RVvzW5qnEaH5u4PjS3k9yynIAV5/M8VIwwZhOD/K4/LW2nsBQx2Fe5SoETEjCOXQibZoD39gU30TrhY9hlHaRO+Gz6FseME1c5wm++QkXtni0guhfRdw9ibxWsH8OYL8irgYO6dFHJGWxmciRXB5SXlCqDMCFavfmr3ZCt8fg/iZ7SVQlWgQYmqzFM587VItFOu1Q84pSL35jrd6y9mqj6kPkmBO2qgDuNuC47KdN2H17K98sRsEFtQFaF84giAmKqad2xigzCo4x3LcW0Roj3jldRDrLMhL33SsPElZFwotg3uDYIxKsNQ0+z0DbfcS6Ro7ZWAmCcaofUQT1lPCxJXkAqPju96G441olAtAown5dy5sT/bcEzJEFlw8E8xrmCl+cGsxTEoGNVZxCsibgsgAH1YExLfn3hzejYyYHYbfHDMKOynpJtlwh2+AbQOh+/A14yVoXzYB3kcoeGTTINQ5boTaXsqAqCEDQ3KobGnCN3A/ZetlGmhjm3NlqZXR/Ndwaf5sDsAeZYpHbkGxau3Wz3asQxhOSEPJDqBX4iVVkrcFC/i7KKm5fP+CMPfifLAyKTtubYUlvMrVALsnC1RdD0hrzYugwwZ9o4ErglpYYCmh30aKr5ZP4w6k+NSeCj/776FH3g+io3nbPWvkRLIevqlce6nJ6v8mCukv8OKb3ckYqnqfFKBYCUg9q6Gw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(23010399003)(1800799024)(7416014)(376014)(10067099003)(6133799003)(18002099003)(32116099003)(22082099003)(18092099006)(21046099003)(11063799006)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HYue2DeFsblmnuO9z3Me0JlVWiEMwgKyBPkhdVAFCe2VMXEKJWZzD+4ExsqI?=
 =?us-ascii?Q?Krv0JGQLUOw5rGYpJWi2JzfYsiQGLWpaOxWUBb3NcJG4jErXQvEDRdHr3Bax?=
 =?us-ascii?Q?JjDyPgDn++bMyfUQx7pva0DH69L7b0GLPXMwctDm97SYDbN3GMV/hf7JNLsA?=
 =?us-ascii?Q?a9bmH0mdvH0bKf6rasnbBheg6dhaHQNsntCZa7jsSzMyChULw3tr7GwXDjVF?=
 =?us-ascii?Q?d/1DVtWj9lOmhz1EvdI22w5Ep/XTULa4a+3u3ANz0d5liI61gfe4vi2PDyqL?=
 =?us-ascii?Q?kmEPu357CF+ELC55ZB5oh0Q3Lm+ZNWb1Ny7eZUwWqemrr0pnnJVDPX2szwUp?=
 =?us-ascii?Q?P7saJWzyR9PyW+2BCIcunVFVM6yoFWHJZS08ir5wMtsrJuKvanlOCTJBNCWy?=
 =?us-ascii?Q?yTTWAAeLyvWQrEXBqLzVWfEJ1neVT3ege3nriKrZXaxLNmI90Gugs7h+MuMG?=
 =?us-ascii?Q?S9Adhmg0cqTrRYZMrysUr10fFLKlOyqd/HWi8BtMz1qkAQXv/ScD0qppJg5z?=
 =?us-ascii?Q?USQpE9PRabLS8IeKAZ4+YPb86m60MlnbRl7SH3OrPXoPjMx68puJ+9MwpsEo?=
 =?us-ascii?Q?8SBcQLJUgGcmdqQmWS6kLnSM31xJ/ULy+MeT6/fDrIgLuQr32IeuMlzGpF7J?=
 =?us-ascii?Q?/UN2wpZCxbUSQvSkJ3ybuRK0K19h4HfBsqZEEW6vfTqs+bUa4kvDgbdPyd0i?=
 =?us-ascii?Q?O1t0Eo5H28v4LUxXA6uTiRDu3Hd4bfdy6z7jawgAq0M70iEt2qLOoFRvWNXX?=
 =?us-ascii?Q?ZdhDObjhmRmkGzyCUUkpr1U0ORzUiabxJr2bKC2FfOq/twjsVlyW9GzAgz1p?=
 =?us-ascii?Q?K6G0jhXUZcFXYtGNi2S2YWCGqHaXCJBEpa7a/PM3JjP93alAIcf6LgJwMRoI?=
 =?us-ascii?Q?Inm0Ax137P/NUabIO/uIy45h7wI6qiY6kLqqe+aSe+IWoPAVuGSJD7YiTBp9?=
 =?us-ascii?Q?JRe/1J3dlQ/Y2dg84RyI0DS8TjCk9Y5dE1zL24EFl1dX1LrvqFXsdX9rcmW4?=
 =?us-ascii?Q?W3K7VgvHko0j2sGJCCe4/tp1VlAvVcNbZscxYDjK2iUBmJmQUfOTbkUjHMO+?=
 =?us-ascii?Q?zncAN10tkBUcEuketrWm8/HYAveTql3CGtnuBdTi61s7x5en0zVy6FHnSnog?=
 =?us-ascii?Q?sQ3+qVtjumBR2tQykYB8lyt6OEqkvZC+/uK+woXgfJWmxR6v0jc5lHH36UPJ?=
 =?us-ascii?Q?b/bU/1ZUpLhj4e2ZOCYraqygZ+TzZ81DLhaaFbMfxdNNbzNAqCjhe/LU4+VG?=
 =?us-ascii?Q?MG0aAD6UnfUKr3hywqdr1TDZMGSrDU4sOx3RLUUJRTlf+Se7C5mvgybgVkLb?=
 =?us-ascii?Q?7ZkgXnEECJySnLn9UDwM9/W4vZ8Ti9P6XIy/CdQ6phJdaeIs+yTTCdMx5lIO?=
 =?us-ascii?Q?KcB95lzPS8XiWBf0pl3Z9v02ioINwEmlf0IdetwQ/qaj+FoAfrsYd2hfRoDn?=
 =?us-ascii?Q?mknTOKPazxo8hVJGsno7l2fg3p08J/s2UA7AOsYUfRtrL2J/RDo6DfZXyjHY?=
 =?us-ascii?Q?j0MMV9MSiKi+TDEwV76+J5i4PPzY9OyZOEUVj/tQJrlGo4yvxShwnpAZDRtI?=
 =?us-ascii?Q?95AGs/jaqcqlcUcKV/zb/a6wKlrC8uU3SBi0pFqUq5UX9X7/1uAiCTXI33oz?=
 =?us-ascii?Q?WD2BGVhyirJR3S8eiuKOJoF+n8mjmPqvg7RRPw4Bk3bmdmw+C4iWsZCRe8gL?=
 =?us-ascii?Q?8CX3nUEnDNsSzdkxh0ffoE98GrkHxLTeG8/mYHDUvqorZTWYZW619D4IcbfN?=
 =?us-ascii?Q?TAXCh2koSMB4NApSBl2WaN0ZF9nYDkKPjENu77sUtXNzDFZK5XZJ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0526c5fb-3cfb-4d43-3779-08df070f2fcc
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 03:23:11.8930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NFpuvRFLkee0MKEL1iu4il+hQuK7M9oFtx7GRzURffVXfIJV+UoorxR1AMtkzByglxvqpYc4VrEnV3VDybltJM2XcLz8PvU5x2CnTup1oMDXCNmS8otWXH45lxGcrgPa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9234

From: Wei Fang <wei.fang@nxp.com>

The ENETC v4 VF hardware supports MAC address filtering, but the
underlying hardware resources (PSIPMMR register and per-SI hash filter
tables) are owned and managed exclusively by the PF driver. Add
VSI-to-PSI mailbox message support so that VFs can request MAC filter
configuration from the PF.

Two new command IDs are introduced under the existing MAC filter message
class (0x20):

1. ENETC_MSG_SET_MAC_HASH_TABLE (cmd_id 3): allows a trusted VF to
program its unicast and/or multicast MAC hash filter table. The PF
validates that the hardware-supported 64-bit table size is requested
before applying the configuration via the per-SI hash filter registers.

2. ENETC_MSG_SET_MAC_PROMISC_MODE (cmd_id 5): allows a VF to enable or
disable unicast/multicast promiscuous mode, and optionally flush the
associated hash filter table. Enabling promiscuous mode requires the VF
to be marked as trusted, since it widens the traffic received by the VF.
Flushing the hash table without enabling promiscuous mode does not
require elevated privilege.

The PSIPMMR register holds promiscuous mode bits for all SIs and is
modified by both enetc4_pf_set_rx_mode() and the VF message handler
workqueue (enetc_msg_task). Since both functions can run concurrently
on SMP systems and enetc_set_si_uc/mc_promisc() performs a non-atomic
read-modify-write, protect all accesses to this register with
pf->msg_lock to prevent lost updates.

When a VF loses trusted status via ndo_set_vf_trust(), its unicast hash
filter is cleared and promiscuous mode is disabled to prevent it from
receiving traffic beyond its allowed scope.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../ethernet/freescale/enetc/enetc4_debugfs.c |  51 +++--
 .../net/ethernet/freescale/enetc/enetc4_pf.c  |   7 +-
 .../ethernet/freescale/enetc/enetc_mailbox.h  |  42 ++++
 .../net/ethernet/freescale/enetc/enetc_msg.c  | 181 +++++++++++++++++-
 .../net/ethernet/freescale/enetc/enetc_pf.h   |   1 +
 .../freescale/enetc/enetc_pf_common.c         |  68 ++++++-
 .../freescale/enetc/enetc_pf_common.h         |  12 ++
 .../net/ethernet/freescale/enetc/enetc_vf.c   |   6 +-
 8 files changed, 332 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c b/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c
index 5029038bf99f..91af78ba4f74 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c
@@ -6,24 +6,48 @@
 #include <linux/seq_file.h>
 #include <linux/string_choices.h>
 
-#include "enetc_pf.h"
+#include "enetc_pf_common.h"
 #include "enetc4_debugfs.h"
 
-static void enetc_show_si_mac_hash_filter(struct seq_file *s, int i)
+static void enetc_vf_state_lock(struct enetc_pf *pf, int vf_id)
 {
-	struct enetc_si *si = s->private;
-	struct enetc_hw *hw = &si->hw;
+	struct enetc_vf_state *vf_state;
+
+	if (vf_id < 0)
+		return;
+
+	vf_state = &pf->vf_state[vf_id];
+	mutex_lock(&vf_state->lock);
+}
+
+static void enetc_vf_state_unlock(struct enetc_pf *pf, int vf_id)
+{
+	struct enetc_vf_state *vf_state;
+
+	if (vf_id < 0)
+		return;
+
+	vf_state = &pf->vf_state[vf_id];
+	mutex_unlock(&vf_state->lock);
+}
+
+static void enetc_show_si_mac_hash_filter(struct seq_file *s, int si_id)
+{
+	struct enetc_pf *pf = enetc_si_priv(s->private);
+	struct enetc_hw *hw = &pf->si->hw;
 	u32 hash_h, hash_l;
 
-	hash_l = enetc_port_rd(hw, ENETC4_PSIUMHFR0(i));
-	hash_h = enetc_port_rd(hw, ENETC4_PSIUMHFR1(i));
+	enetc_vf_state_lock(pf, si_id - 1);
+	hash_l = enetc_port_rd(hw, ENETC4_PSIUMHFR0(si_id));
+	hash_h = enetc_port_rd(hw, ENETC4_PSIUMHFR1(si_id));
 	seq_printf(s, "SI %d unicast MAC hash filter: 0x%08x%08x\n",
-		   i, hash_h, hash_l);
+		   si_id, hash_h, hash_l);
 
-	hash_l = enetc_port_rd(hw, ENETC4_PSIMMHFR0(i));
-	hash_h = enetc_port_rd(hw, ENETC4_PSIMMHFR1(i));
+	hash_l = enetc_port_rd(hw, ENETC4_PSIMMHFR0(si_id));
+	hash_h = enetc_port_rd(hw, ENETC4_PSIMMHFR1(si_id));
 	seq_printf(s, "SI %d multicast MAC hash filter: 0x%08x%08x\n",
-		   i, hash_h, hash_l);
+		   si_id, hash_h, hash_l);
+	enetc_vf_state_unlock(pf, si_id - 1);
 }
 
 static int enetc_mac_filter_show(struct seq_file *s, void *data)
@@ -37,7 +61,11 @@ static int enetc_mac_filter_show(struct seq_file *s, void *data)
 	int err = 0;
 	int i;
 
+	/* Prevent concurrent access from causing PSIPMMR to be modified */
+	enetc_pf_msg_lock(pf);
 	val = enetc_port_rd(hw, ENETC4_PSIPMMR);
+	enetc_pf_msg_unlock(pf);
+
 	for (i = 0; i < num_si; i++) {
 		seq_printf(s, "SI %d Unicast Promiscuous mode: %s\n", i,
 			   str_enabled_disabled(PSIPMMR_SI_MAC_UP(i) & val));
@@ -45,13 +73,12 @@ static int enetc_mac_filter_show(struct seq_file *s, void *data)
 			   str_enabled_disabled(PSIPMMR_SI_MAC_MP(i) & val));
 	}
 
+	rtnl_lock();
 	/* MAC hash filter table */
 	for (i = 0; i < num_si; i++)
 		enetc_show_si_mac_hash_filter(s, i);
 
 	user = &pf->si->ntmp_user;
-	rtnl_lock();
-
 	if (bitmap_empty(user->maft_eid_bitmap, user->maft_num_entries))
 		goto unlock_rtnl;
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 363ec562934e..a4ffe1100bd7 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -12,11 +12,6 @@
 
 #define ENETC_SI_MAX_RING_NUM	8
 
-#define ENETC_MAC_FILTER_TYPE_UC	BIT(0)
-#define ENETC_MAC_FILTER_TYPE_MC	BIT(1)
-#define ENETC_MAC_FILTER_TYPE_ALL	(ENETC_MAC_FILTER_TYPE_UC | \
-					 ENETC_MAC_FILTER_TYPE_MC)
-
 static void enetc4_get_port_caps(struct enetc_pf *pf)
 {
 	struct enetc_hw *hw = &pf->si->hw;
@@ -528,8 +523,10 @@ static int enetc4_pf_set_rx_mode(struct net_device *ndev,
 		type = ENETC_MAC_FILTER_TYPE_ALL;
 	}
 
+	enetc_pf_msg_lock(pf);
 	enetc_set_si_uc_promisc(si, 0, uc_promisc);
 	enetc_set_si_mc_promisc(si, 0, mc_promisc);
+	enetc_pf_msg_unlock(pf);
 
 	if (uc_promisc) {
 		enetc_set_si_uc_hash_filter(si, 0, 0);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_mailbox.h b/drivers/net/ethernet/freescale/enetc/enetc_mailbox.h
index bd669543e96c..200651e6ce85 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_mailbox.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_mailbox.h
@@ -96,6 +96,17 @@
 #define ENETC_PF_MSG_CLASS_CODE_U8		GENMASK(7, 0)
 #define ENETC_PF_MSG_CLASS_ID			GENMASK(15, 8)
 
+#define ENETC_MAC_HASH_TABLE_SIZE_64		0
+#define ENETC_MSG_MAC_HASH_SIZE			GENMASK(5, 0)
+#define ENETC_MSG_MAC_TYPE			GENMASK(7, 6)
+#define  ENETC_MAC_FILTER_TYPE_UC		BIT(0)
+#define  ENETC_MAC_FILTER_TYPE_MC		BIT(1)
+#define  ENETC_MAC_FILTER_TYPE_ALL		(ENETC_MAC_FILTER_TYPE_UC | \
+						 ENETC_MAC_FILTER_TYPE_MC)
+
+#define ENETC_MSG_MAC_FLUSH_MACS		BIT(0)
+#define ENETC_MSG_MAC_PROMISC_MODE		BIT(1)
+
 enum enetc_msg_class_id {
 	/* Class ID for PSI-to-VSI messages */
 	ENETC_MSG_CLASS_ID_CMD_SUCCESS		= 1,
@@ -119,6 +130,8 @@ enum enetc_msg_class_id {
 
 enum enetc_msg_mac_filter_cmd_id {
 	ENETC_MSG_SET_PRIMARY_MAC,
+	ENETC_MSG_SET_MAC_HASH_TABLE		= 3,
+	ENETC_MSG_SET_MAC_PROMISC_MODE		= 5,
 };
 
 enum enetc_msg_ip_revision_cmd_id {
@@ -141,6 +154,9 @@ enum enetc_msg_link_speed_cmd_id {
 /* Class-specific error return codes of MAC filter */
 enum enetc_mac_filter_class_code {
 	ENETC_MF_CLASS_CODE_INVALID_MAC,
+	ENETC_MF_CLASS_CODE_INVALID_TYPE	= 4,
+	/* Unicast Filter Is Denied */
+	ENETC_MF_CLASS_CODE_UCF_DENY		= 5,
 };
 
 /* Class-specific notifications/codes of link status */
@@ -204,6 +220,32 @@ struct enetc_msg_mac_exact_filter {
 	struct enetc_mac_addr mac[];
 };
 
+/* message format of class_id 0x20 for hash MAC filter.
+ * cmd_id 0x3: set MAC hash table
+ */
+struct enetc_msg_mac_hash_filter {
+	struct enetc_msg_header hdr;
+	/* bit 0 ~ 5: ENETC_MSG_MAC_HASH_SIZE
+	 * bit 6~7: ENETC_MSG_MAC_TYPE
+	 */
+	u8 sz_type;
+	u8 resv[3];
+	u32 hash_tbl[];
+};
+
+/* message format of class_id 0x20 for MAC promiscuous mode.
+ * cmd_id 0x5: set MAC promiscuous mode
+ */
+struct enetc_msg_mac_promisc_mode {
+	struct enetc_msg_header hdr;
+	/* bit 0: ENETC_MSG_MAC_FLUSH_MACS
+	 * bit 1: ENETC_MSG_MAC_PROMISC_MODE
+	 * bit 6~7: ENETC_MSG_MAC_TYPE
+	 */
+	u8 config;
+	u8 resv[15];
+};
+
 /* The generic message format applies to the following messages:
  * Get IP revision message, class_id 0xf0.
  * cmd_id 1: get IP minor revision
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_msg.c b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
index c3ae4c024f34..d58fbaeaf46c 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_msg.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
@@ -9,6 +9,11 @@
 					   ENETC_MSG_CLASS_ID_CMD_NOT_SUPPORT)
 #define ENETC_PF_MSG_PERM_DENY	FIELD_PREP(ENETC_PF_MSG_CLASS_ID, \
 					   ENETC_MSG_CLASS_ID_PERMISSION_DENY)
+#define ENETC_PF_MSG_INV_LEN	FIELD_PREP(ENETC_PF_MSG_CLASS_ID, \
+					   ENETC_MSG_CLASS_ID_INVALID_MSG_LEN)
+#define ENETC_PF_MSG_MF(code)	(FIELD_PREP(ENETC_PF_MSG_CLASS_ID, \
+					    ENETC_MSG_CLASS_ID_MAC_FILTER) | \
+				 FIELD_PREP(ENETC_PF_MSG_CLASS_CODE, (code)))
 
 static void enetc_msg_disable_mr_int(struct enetc_pf *pf)
 {
@@ -79,10 +84,7 @@ static u16 enetc_msg_set_vf_primary_mac_addr(struct enetc_pf *pf, int vf_id,
 	if (!is_valid_ether_addr(addr)) {
 		dev_err_ratelimited(dev, "VF%d attempted to set invalid MAC\n",
 				    vf_id);
-		pf_msg = FIELD_PREP(ENETC_PF_MSG_CLASS_ID,
-				    ENETC_MSG_CLASS_ID_MAC_FILTER) |
-			 FIELD_PREP(ENETC_PF_MSG_CLASS_CODE,
-				    ENETC_MF_CLASS_CODE_INVALID_MAC);
+		pf_msg = ENETC_PF_MSG_MF(ENETC_MF_CLASS_CODE_INVALID_MAC);
 		goto vf_state_unlock;
 	}
 
@@ -108,6 +110,132 @@ static u16 enetc_msg_set_vf_primary_mac_addr(struct enetc_pf *pf, int vf_id,
 	return pf_msg;
 }
 
+static u16 enetc_msg_set_vf_mac_hash_filter(struct enetc_pf *pf, int vf_id,
+					    void *vf_msg)
+{
+	struct enetc_vf_state *vf_state = &pf->vf_state[vf_id];
+	struct enetc_msg_mac_hash_filter *msg = vf_msg;
+	u16 pf_msg = ENETC_PF_MSG_SUCCESS;
+	struct enetc_si *si = pf->si;
+	int si_id = vf_id + 1;
+	u64 uc_hash, mc_hash;
+	bool trusted;
+	int type;
+
+	/* Currently, hardware only supports 64 bits table size */
+	if (FIELD_GET(ENETC_MSG_MAC_HASH_SIZE, msg->sz_type) !=
+	    ENETC_MAC_HASH_TABLE_SIZE_64)
+		return ENETC_PF_MSG_NOTSUPP;
+
+	mutex_lock(&vf_state->lock);
+
+	/* For an untrusted VF, unicast MAC hash filtering is not permitted.
+	 * For multicast, the MAC hash filter is strictly limited to a maximum
+	 * of 8 bits to satisfy its basic multicast communication requirements
+	 * while preventing potential network abuse.
+	 */
+	trusted = !!(vf_state->flags & ENETC_VF_FLAG_TRUSTED);
+	type = FIELD_GET(ENETC_MSG_MAC_TYPE, msg->sz_type);
+	switch (type) {
+	case ENETC_MAC_FILTER_TYPE_UC:
+		if (!trusted) {
+			pf_msg = ENETC_PF_MSG_PERM_DENY;
+			goto vf_state_unlock;
+		}
+
+		uc_hash = (u64)msg->hash_tbl[1] << 32 | msg->hash_tbl[0];
+		enetc_set_si_uc_hash_filter(si, si_id, uc_hash);
+		break;
+	case ENETC_MAC_FILTER_TYPE_MC:
+		mc_hash = (u64)msg->hash_tbl[1] << 32 | msg->hash_tbl[0];
+		if (!trusted &&
+		    hweight64(mc_hash) > ENETC_VF_MC_HASH_BITS_MAX) {
+			pf_msg = ENETC_PF_MSG_PERM_DENY;
+			goto vf_state_unlock;
+		}
+
+		enetc_set_si_mc_hash_filter(si, si_id, mc_hash);
+		break;
+	case ENETC_MAC_FILTER_TYPE_ALL:
+		if (!msg->hdr.len) {
+			pf_msg = ENETC_PF_MSG_INV_LEN;
+			goto vf_state_unlock;
+		}
+
+		uc_hash = (u64)msg->hash_tbl[1] << 32 | msg->hash_tbl[0];
+		mc_hash = (u64)msg->hash_tbl[3] << 32 | msg->hash_tbl[2];
+
+		if (!trusted &&
+		    (hweight64(mc_hash) <= ENETC_VF_MC_HASH_BITS_MAX)) {
+			enetc_set_si_mc_hash_filter(si, si_id, mc_hash);
+			pf_msg = ENETC_PF_MSG_MF(ENETC_MF_CLASS_CODE_UCF_DENY);
+			goto vf_state_unlock;
+		}
+
+		if (!trusted) {
+			pf_msg = ENETC_PF_MSG_PERM_DENY;
+			goto vf_state_unlock;
+		}
+
+		enetc_set_si_uc_hash_filter(si, si_id, uc_hash);
+		enetc_set_si_mc_hash_filter(si, si_id, mc_hash);
+		break;
+	default:
+		pf_msg = ENETC_PF_MSG_MF(ENETC_MF_CLASS_CODE_INVALID_TYPE);
+	}
+
+vf_state_unlock:
+	mutex_unlock(&vf_state->lock);
+
+	return pf_msg;
+}
+
+static u16 enetc_msg_set_vf_mac_promisc_mode(struct enetc_pf *pf, int vf_id,
+					     void *vf_msg)
+{
+	struct enetc_vf_state *vf_state = &pf->vf_state[vf_id];
+	struct enetc_msg_mac_promisc_mode *msg = vf_msg;
+	u16 pf_msg = ENETC_PF_MSG_SUCCESS;
+	struct enetc_si *si = pf->si;
+	bool promisc, flush_macs;
+	int si_id = vf_id + 1;
+	int type;
+
+	flush_macs = !!(msg->config & ENETC_MSG_MAC_FLUSH_MACS);
+	type = FIELD_GET(ENETC_MSG_MAC_TYPE, msg->config);
+	if (!type)
+		return ENETC_PF_MSG_MF(ENETC_MF_CLASS_CODE_INVALID_TYPE);
+
+	mutex_lock(&vf_state->lock);
+
+	promisc = !!(msg->config & ENETC_MSG_MAC_PROMISC_MODE);
+	if (promisc && !(vf_state->flags & ENETC_VF_FLAG_TRUSTED)) {
+		pf_msg = ENETC_PF_MSG_PERM_DENY;
+		goto vf_state_unlock;
+	}
+
+	mutex_lock(&pf->msg_lock);
+
+	if (type & ENETC_MAC_FILTER_TYPE_UC)
+		enetc_set_si_uc_promisc(si, si_id, promisc);
+
+	if (type & ENETC_MAC_FILTER_TYPE_MC)
+		enetc_set_si_mc_promisc(si, si_id, promisc);
+
+	mutex_unlock(&pf->msg_lock);
+
+	if ((type & ENETC_MAC_FILTER_TYPE_UC) && flush_macs)
+		enetc_set_si_uc_hash_filter(si, si_id, 0);
+
+	if ((type & ENETC_MAC_FILTER_TYPE_MC) && flush_macs)
+		enetc_set_si_mc_hash_filter(si, si_id, 0);
+
+vf_state_unlock:
+	mutex_unlock(&vf_state->lock);
+
+	return pf_msg;
+}
+
 static u16 enetc_msg_handle_mac_filter(struct enetc_pf *pf, int vf_id,
 				       void *vf_msg)
 {
@@ -116,6 +244,10 @@ static u16 enetc_msg_handle_mac_filter(struct enetc_pf *pf, int vf_id,
 	switch (msg_hdr->cmd_id) {
 	case ENETC_MSG_SET_PRIMARY_MAC:
 		return enetc_msg_set_vf_primary_mac_addr(pf, vf_id, vf_msg);
+	case ENETC_MSG_SET_MAC_HASH_TABLE:
+		return enetc_msg_set_vf_mac_hash_filter(pf, vf_id, vf_msg);
+	case ENETC_MSG_SET_MAC_PROMISC_MODE:
+		return enetc_msg_set_vf_mac_promisc_mode(pf, vf_id, vf_msg);
 	default:
 		return ENETC_PF_MSG_NOTSUPP;
 	}
@@ -383,8 +515,7 @@ static void enetc_msg_handle_rxmsg(struct enetc_pf *pf, int vf_id,
 	if (msg_size > ENETC_DEFAULT_MSG_SIZE) {
 		dev_err_ratelimited(dev,
 				    "Invalid message size: %u\n", msg_size);
-		*pf_msg = FIELD_PREP(ENETC_PF_MSG_CLASS_ID,
-				     ENETC_MSG_CLASS_ID_INVALID_MSG_LEN);
+		*pf_msg = ENETC_PF_MSG_INV_LEN;
 		return;
 	}
 
@@ -402,6 +533,14 @@ static void enetc_msg_handle_rxmsg(struct enetc_pf *pf, int vf_id,
 	}
 
 	memcpy(msg, msg_swbd->vaddr, msg_size);
+	msg_hdr = (struct enetc_msg_header *)msg;
+
+	/* Check message length whether is changed */
+	if (ENETC_MSG_SIZE(msg_hdr->len) != msg_size) {
+		*pf_msg = ENETC_PF_MSG_INV_LEN;
+		goto free_msg;
+	}
+
 	if (!enetc_msg_check_crc16(msg, msg_size)) {
 		dev_err_ratelimited(dev, "VSI to PSI Message CRC16 error\n");
 		*pf_msg = FIELD_PREP(ENETC_PF_MSG_CLASS_ID,
@@ -412,7 +551,6 @@ static void enetc_msg_handle_rxmsg(struct enetc_pf *pf, int vf_id,
 
 	/* Default to not supported */
 	*pf_msg = ENETC_PF_MSG_NOTSUPP;
-	msg_hdr = (struct enetc_msg_header *)msg;
 
 	/* Currently, asynchronous actions are not supported */
 	if (FIELD_GET(ENETC_VF_MSG_COOKIE, msg_hdr->cookie)) {
@@ -582,6 +720,31 @@ static int enetc_msg_psi_init(struct enetc_pf *pf)
 	return err;
 }
 
+static void enetc_msg_clear_vf_config(struct enetc_pf *pf, int vf_id)
+{
+	struct enetc_vf_state *vf_state = &pf->vf_state[vf_id];
+	struct enetc_si *si = pf->si;
+	int si_id = vf_id + 1;
+
+	/* For ENETC v1, we only support setting the VF's MAC address via
+	 * VSI-to-PSI messages, so there is no configuration to clear.
+	 */
+	if (is_enetc_rev1(si))
+		return;
+
+	mutex_lock(&vf_state->lock);
+
+	mutex_lock(&pf->msg_lock);
+	enetc_set_si_uc_promisc(si, si_id, false);
+	enetc_set_si_mc_promisc(si, si_id, false);
+	mutex_unlock(&pf->msg_lock);
+
+	enetc_set_si_uc_hash_filter(si, si_id, 0);
+	enetc_set_si_mc_hash_filter(si, si_id, 0);
+
+	mutex_unlock(&vf_state->lock);
+}
+
 static void enetc_msg_psi_free(struct enetc_pf *pf)
 {
 	struct enetc_si *si = pf->si;
@@ -598,8 +761,10 @@ static void enetc_msg_psi_free(struct enetc_pf *pf)
 	/* MR interrupts may be re-enabled by workqueue */
 	enetc_msg_disable_mr_int(pf);
 
-	for (i = 0; i < pf->num_vfs; i++)
+	for (i = 0; i < pf->num_vfs; i++) {
 		enetc_msg_free_mbx(si, i);
+		enetc_msg_clear_vf_config(pf, i);
+	}
 }
 
 int enetc_sriov_configure(struct pci_dev *pdev, int num_vfs)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
index 06dc47164dc5..12e67f611f77 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
@@ -6,6 +6,7 @@
 
 #define ENETC_PF_NUM_RINGS	8
 #define ENETC_VLAN_HT_SIZE	64
+#define ENETC_VF_MC_HASH_BITS_MAX	8 /* For untrusted VFs */
 
 enum enetc_vf_flags {
 	ENETC_VF_FLAG_PF_SET_MAC	= BIT(0),
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 7a11370d2b8e..8007dce90195 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -151,26 +151,44 @@ void enetc_set_si_uc_hash_filter(struct enetc_si *si, int si_id, u64 hash)
 }
 EXPORT_SYMBOL_GPL(enetc_set_si_uc_hash_filter);
 
-void enetc_set_si_mc_hash_filter(struct enetc_si *si, int si_id, u64 hash)
+static void enetc_get_psimmhfr_offsets(struct enetc_si *si, int si_id,
+				       int *psimmhfr0, int *psimmhfr1)
 {
-	int psimmhfr0_off, psimmhfr1_off;
-	struct enetc_hw *hw = &si->hw;
-
 	if (is_enetc_rev1(si)) {
 		bool err = si->errata & ENETC_ERR_UCMCSWP;
 
-		psimmhfr0_off = ENETC_PSIMMHFR0(si_id, err);
-		psimmhfr1_off = ENETC_PSIMMHFR1(si_id);
+		*psimmhfr0 = ENETC_PSIMMHFR0(si_id, err);
+		*psimmhfr1 = ENETC_PSIMMHFR1(si_id);
 	} else {
-		psimmhfr0_off = ENETC4_PSIMMHFR0(si_id);
-		psimmhfr1_off = ENETC4_PSIMMHFR1(si_id);
+		*psimmhfr0 = ENETC4_PSIMMHFR0(si_id);
+		*psimmhfr1 = ENETC4_PSIMMHFR1(si_id);
 	}
+}
 
+void enetc_set_si_mc_hash_filter(struct enetc_si *si, int si_id, u64 hash)
+{
+	int psimmhfr0_off, psimmhfr1_off;
+	struct enetc_hw *hw = &si->hw;
+
+	enetc_get_psimmhfr_offsets(si, si_id, &psimmhfr0_off, &psimmhfr1_off);
 	enetc_port_wr(hw, psimmhfr0_off, lower_32_bits(hash));
 	enetc_port_wr(hw, psimmhfr1_off, upper_32_bits(hash));
 }
 EXPORT_SYMBOL_GPL(enetc_set_si_mc_hash_filter);
 
+static u64 enetc_get_si_mc_hash_filter(struct enetc_si *si, int si_id)
+{
+	int psimmhfr0_off, psimmhfr1_off;
+	struct enetc_hw *hw = &si->hw;
+	u32 hash_h, hash_l;
+
+	enetc_get_psimmhfr_offsets(si, si_id, &psimmhfr0_off, &psimmhfr1_off);
+	hash_l = enetc_port_rd(hw, psimmhfr0_off);
+	hash_h = enetc_port_rd(hw, psimmhfr1_off);
+
+	return ((u64)hash_h << 32) | hash_l;
+}
+
 void enetc_set_si_vlan_promisc(struct enetc_si *si, int si_id, bool promisc)
 {
 	struct enetc_hw *hw = &si->hw;
@@ -593,6 +611,8 @@ int enetc_pf_set_vf_trust(struct net_device *ndev, int vf, bool setting)
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	struct enetc_pf *pf = enetc_si_priv(priv->si);
 	struct enetc_vf_state *vf_state;
+	struct enetc_si *si = priv->si;
+	int si_id = vf + 1;
 
 	if (vf >= pf->total_vfs)
 		return -EINVAL;
@@ -600,11 +620,39 @@ int enetc_pf_set_vf_trust(struct net_device *ndev, int vf, bool setting)
 	vf_state = &pf->vf_state[vf];
 	mutex_lock(&vf_state->lock);
 
-	if (setting)
+	if (setting) {
 		vf_state->flags |= ENETC_VF_FLAG_TRUSTED;
-	else
+	} else {
+		u64 hash;
+
 		vf_state->flags &= ~ENETC_VF_FLAG_TRUSTED;
 
+		/* For ENETC v1, we only support setting the VF's MAC address
+		 * via VSI-to-PSI messages. Unicast and multicast promiscuous
+		 * mode and hash filters are not supported, so there is no need
+		 * to clear these configurations.
+		 */
+		if (is_enetc_rev1(si))
+			goto vf_state_unlock;
+
+		/* Disable unicast and multicast promiscuous modes */
+		mutex_lock(&pf->msg_lock);
+		enetc_set_si_uc_promisc(si, si_id, false);
+		enetc_set_si_mc_promisc(si, si_id, false);
+		mutex_unlock(&pf->msg_lock);
+
+		/* Clear unicast hash filter */
+		enetc_set_si_uc_hash_filter(si, si_id, 0);
+
+		/* Clear multicast hash filter if its set bits exceed
+		 * ENETC_VF_MC_HASH_BITS_MAX.
+		 */
+		hash = enetc_get_si_mc_hash_filter(si, si_id);
+		if (hweight64(hash) > ENETC_VF_MC_HASH_BITS_MAX)
+			enetc_set_si_mc_hash_filter(si, si_id, 0);
+	}
+
+vf_state_unlock:
 	mutex_unlock(&vf_state->lock);
 
 	return 0;
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
index 1d35e906fc3a..91a9c339245a 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
@@ -30,6 +30,18 @@ static inline u16 enetc_get_ip_revision(struct enetc_hw *hw)
 	return enetc_global_rd(hw, ENETC_G_EIPBRR0) & EIPBRR0_REVISION;
 }
 
+static inline void enetc_pf_msg_lock(struct enetc_pf *pf)
+{
+	if (pf->total_vfs)
+		mutex_lock(&pf->msg_lock);
+}
+
+static inline void enetc_pf_msg_unlock(struct enetc_pf *pf)
+{
+	if (pf->total_vfs)
+		mutex_unlock(&pf->msg_lock);
+}
+
 #if IS_ENABLED(CONFIG_PCI_IOV)
 int enetc_sriov_configure(struct pci_dev *pdev, int num_vfs);
 void enetc_pf_notify_vf_link_up(struct enetc_pf *pf);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_vf.c b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
index 7dcb4a0246f5..a60af40d8546 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_vf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
@@ -107,8 +107,12 @@ static int enetc_msg_vsi_send(struct enetc_si *si, struct enetc_msg_swbd *msg)
 		case ENETC_MSG_CLASS_ID_CMD_TIMEOUT:
 			err = -ETIME;
 			break;
-		case ENETC_MSG_CLASS_ID_INVALID_MSG_LEN:
 		case ENETC_MSG_CLASS_ID_MAC_FILTER:
+			if (FIELD_GET(ENETC_PF_MSG_CLASS_CODE, pf_msg) ==
+			    ENETC_MF_CLASS_CODE_UCF_DENY)
+				return -EACCES;
+			fallthrough;
+		case ENETC_MSG_CLASS_ID_INVALID_MSG_LEN:
 			err = -EINVAL;
 			break;
 		case ENETC_MSG_CLASS_ID_CMD_NOT_PERMITTED:
-- 
2.34.1

