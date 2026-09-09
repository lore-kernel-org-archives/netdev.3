Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013033.outbound.protection.outlook.com [40.107.159.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370F64FB9B2;
	Wed,  9 Sep 2026 10:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788950197; cv=fail; b=VoSESwIYABQ7JPPNqNrVUC7fthZ1WvWZWfNdYjbwFRVpcrNIlFi/ZspLfLja21mNDHPhPIQiKV4a2B82n62PtsG4iLf/1vMEF5F2IoeLDCtb488CWqsVvT7iFuGOrdo3hB/cvOLHa38IDai2N5zxZU+iV3btkfq+XHdaxfb+wGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788950197; c=relaxed/simple;
	bh=f82MguQntsvGMFIdeEIJC7KCNWKqh61z5PG2tL2+bdg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PEK7vZAdlJdBGOAW/6XHb+4cq0nRjRSZRXOoqQWcPBIBW+M+l1FJbei2giFZ9ZcKAva4S2uqdXqCHCq+jKVb0L/S4tJgvMsT66x6TPVk+d5cJkGvZ2qHjHer5OSw7zsRwhnjCkxx44fsjWQx6+ehhNu4f/CgniM/y4h3svhcEGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=kLKidOyd; arc=fail smtp.client-ip=40.107.159.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="kLKidOyd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mOzI2Q6NtWrlwyKEGjtEb079odzBBBi2sE0yjz2LleaZVH8T0rxoOhGOiZdvgHnfM5EW1Aml9KLaG80cdapu/qIod7BmI/jmea0S51LVmUNd9ZWDSaDzXAxmduedoqF2FNwGR8vJhIZzkFA+qN2U4n6Nq2ahxfxt/uGOkgMGpsjxChuBEkkEKxgVfzuFep5DAqL0nLfTJAuI34uk0JO3Pt0w0uVcCw9PV5ka1SeAGLw4L5GfIkZjBPj+nbvZ8/mhEFKrvRDxNkq5bNVIIiDL46E1osLUjuWHTPZmX8tw7t6s4XUa+pUsDIfm5d5ge+2u8Hf9jGXEaIgPEQjoqv5AHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4RvjTU/C6+exn9HDL4DDn8vD5LIBu6Mp7W3uxAfm0WY=;
 b=vhK/O0e1VkYBCsABSX7laoxrmGuzSH9TKbka997hnI3WoCRafhOPwjgHhYMktgj+54fSeECIZGEvppZ2CnJzZt8Br4YulbuY9mNDTG8OOVXTNe2wqxdmUCtXz8OPPIsPVJdQtYJKf7IoHSIqTWVZ1jXdKoPj0o1Z0Wk3wYK2pcIVb6ukYhR0+Y5XpbjtlcqEnPsKViEfO3WVLOW5cHH4sreTO65F0lf+j+sK4H0YvLolMeRGxcTph9dJK1uWj4c87N2ZIubyCiNdgZEVv7Lp+D+n5gVAH9bjqGKo3UhKhWoX3KUrjb1VdNcKW4ui2mppTS5lXynRxZ/TiglXKNL4Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RvjTU/C6+exn9HDL4DDn8vD5LIBu6Mp7W3uxAfm0WY=;
 b=kLKidOydCs8nt6tmUshFtQGnb9LvdtkTNaBDyiFjS6dRIRRY+wqnBm79d/qgI5hqjyHky5ok5L/k7QqJN2AxChCdIrcJgJ1zp3YJtVHgUDLpEBknwwme63fvSPrb1j0MxsbG9HVT/l+QGRSO4/zaY6dGSqvvRkrAeKZgE+gGG0E6x2M9WkibwM7ITKGgVFvLmZMzF29DvHigEFUNzL+L6w0lbY7MdMGiINXwaUW3XPRFTQceLcX3KTqSKFmX+G0UUTCjj+X9cC8noloC7qSXrZ/bE0XewDKhDuCwFUHV4W9R6CpeUuZlrOdOrbhRDmbWsY1UvOE5vtV3umRvH463cQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by DB8PR04MB7066.eurprd04.prod.outlook.com (2603:10a6:10:12e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Wed, 9 Sep 2026
 10:36:32 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 10:36:32 +0000
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
Subject: [PATCH v4 net-next 09/15] net: enetc: add MAC address filtering support for VFs of ENETC v4
Date: Wed,  9 Sep 2026 18:07:27 +0800
Message-Id: <20260909100733.1139689-10-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260909100733.1139689-1-wei.fang@oss.nxp.com>
References: <20260909100733.1139689-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0262.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:21c::18) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|DB8PR04MB7066:EE_
X-MS-Office365-Filtering-Correlation-Id: 321bfca1-529f-4a01-5e91-08df0e5e36ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|376014|1800799024|23010399003|366016|10067099003|11063799006|56012099006|6133799003|21046099003|22082099003|18002099003|18092099006|921020;
X-Microsoft-Antispam-Message-Info:
	juuvIrFxQ/RC7VCxiaMZo8d6vRu/hBckXv0aYGYdsxgKJNOZNdqOC/J3k3vvwV3H92lxRSml/T8CIQXAt9a9J/l6W+3bLn2bzmOVjsrzlJBM/+7b9tHQ1bKkx0QVOkVB2bsOBnoW7E4nJVcRdAStga8D/fh3Mr9n/nFIDklo9UqniT3Maj9mYZT8SAW5zIaJ/0S1Wv1nlaFWdcG8Q+slhWnyDpHH85jVseibLAL17bo4oOhnFG2DsPxCF9wugmGks9ggoSct54BFWz30Eck/nyGCx0+1k4/YLd0n+au7SSvYj/HDTA7F4kOfKokeXDncjJjE0iqhVCFyybcr3khzb08LvXwlE5Y82Q3BiYmipjHk+XouZfCqexw2gihMTZSWKFCAAUaPtko/nhvWTtn8YFklSB65Q7hE1Pi3YP0E6p9X+Jx2VIk47/oPxoZlg82Ri7w74JEFVC8Vz6oToD2OAqJi6o5YTO4gVK62oeT/amE0X4B5xmYsV9zie1WOiMBV//Qc7CLD9f/SlOEJbTjnSA0dyJqmSiSfRxsj7qyB8N7xrJMGzJYjDISpkQxtl83pgsbuePUiMi3lCnFnRlpCEHsB+Pt+E2JsPENldfbKEXVdTFeAVvsneeDyjF1lBUCgPtTRrgPmgRW+dX4A7N9f1z6hezR8GzcuCmaGPoYTSpi5SJlTJ0EcMrR+vAyBB0oZbL+hzTtq5d2112uTrG0niQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(1800799024)(23010399003)(366016)(10067099003)(11063799006)(56012099006)(6133799003)(21046099003)(22082099003)(18002099003)(18092099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6jYNxkj8Lu2Ig2H9gQLcZLGn13PnflOreijAu4eb1QuuTX2bYrR+DPUdveQq?=
 =?us-ascii?Q?n+j4Q3RxfHQw20prU0vW199WSHkpGhkw20fBMQMc+sQ5OQ35a+r4EFXzNZld?=
 =?us-ascii?Q?rXzYHQ8fpzDetvmgAbSgh80wH/nXYbgkXFOY8exjVD8pXd0XJhl4iT2HbxmH?=
 =?us-ascii?Q?sOOZESG0ciMWA6yr8TBUYSzmPhRW+ZMZ4S7EKDoPRNG7+XxJIjNV6vs/4SVM?=
 =?us-ascii?Q?3T+iz4rIVgTa1ZD2ixM86jZusT4Os/Eg3Vx6Pga+jl7d+yr01Q5KonaWa/Lb?=
 =?us-ascii?Q?KRhXPFzBZ5LxcYD7pU+y4tlVP5CisaLvOZc65r27X6O0fHlhrZvXi8+3tona?=
 =?us-ascii?Q?FQuUdnsqazdEfu+m5OsongaVtfLlZCKH4USqGse13x4OoHqYUpJjxniSLt7A?=
 =?us-ascii?Q?6+zHEf6w6kIB21kz9Xd97u5H26IQztYj9Q3fyYdUDOuEHAEsF97Opa/0WCnq?=
 =?us-ascii?Q?aNYgL+tXDIXX7gzzh24CCI6O65SWS2S2/U79tpOrBAzUhvoi1SrIVP+JrI7U?=
 =?us-ascii?Q?+X8IJNAOudGmZvdboiGI+0GHRvrCqtfMX8TElyKIdPTNJgf3ED+RifW423Np?=
 =?us-ascii?Q?QAz02v9Lr2chejP+XGJbBRGkaVO2MLqrSxIANT+RbkmZu7PuzTDVYTQaXMIc?=
 =?us-ascii?Q?pssejABWt91wFAfmvR3pfTPGHMZbhHcpep/qiQkiweqbaTvjMD3KwkCSfO1k?=
 =?us-ascii?Q?eZ5ouJp/yCZErnXhRFr7O7lerqDJ2M6iyWAkho9MsOtDt71kUZREwXRdZHqG?=
 =?us-ascii?Q?4w5H2SPHQ7BRIt7y3W+uBGXdVpI3I+KW1TDnJaYfKU3ykz32oVXzMkDycZ0N?=
 =?us-ascii?Q?saXNKGJU4vdhfFbD6tZwqMqO1xHF63YmKGYD/ENKqJm/08wae8O4/ht7yp6U?=
 =?us-ascii?Q?zKLq74bsjlzVQiiwgFPmc/eBHK+u8e7PuIExtKsWvsfcmVVpwOw7woKGJtT8?=
 =?us-ascii?Q?4cAIRrC+tZiX1s2wEfnVeSIqqHa8LONnI2JHiBxFZJ8YxuakgWFqgt1TrY+m?=
 =?us-ascii?Q?W8C+H3dgAofnWR3UYz5H9jZaGU0ZZRTOi1qgyL/GJSAEihnYWnUBiZqTtojC?=
 =?us-ascii?Q?iuzqQwidDMbqmsU7rgEzrzE3jB+jsWBvZEFChJKvksfmPefFtcaP4/15UX0L?=
 =?us-ascii?Q?Wq17pkjgNAgBRjKNBjFSdAG5Od8AY4BgIKRHz/uJ3qSHlSd4Rv7qWpPkzq5Z?=
 =?us-ascii?Q?kTd2uHt1PFFNeQ2zGhnDJ4pcYgv0dBNu6da3pN0D5XR871txMTAyOpiixIJn?=
 =?us-ascii?Q?bZJF3SdLOuErbcu8/EtAXL0kDz3bAX7pTHV/Z7P6ASTeAbWeXCQJW/pH0SHd?=
 =?us-ascii?Q?6D34vk3Xw/wVOQjjdleA+tZKWxDdQpNqvbzxC2NpK/tnI5X/+vOtO9Kohjhw?=
 =?us-ascii?Q?qUSqQhk0kd8kKMqYhmIu92zRvKU01RsYwjd80IYThvg9dRQ0EFRDuMqHmON2?=
 =?us-ascii?Q?G5Y46lz1T3HBClKTxNHxyv0mgMiLJpCppKfzbNVRHsgeJTqL7yX0aeg1laxw?=
 =?us-ascii?Q?LOM6oPbRH7BbBZEp5b3wC1F1xWm/AhXP06TJdW63soCOR6/zMZ+ELgunikUP?=
 =?us-ascii?Q?02QTMIFkO74LmixlIbeoExSBpkJKD7qmvs2R2o0oEkz7KvyrgoAvSgQWR4fT?=
 =?us-ascii?Q?eYcjhvbuRspbzDgNPlInkK6yCTrh1gPHweH/XTyqlAIJxtuMKRLAod8CDqgG?=
 =?us-ascii?Q?0jw+WFmQ/Cn/gCEf3vjpG9If/vFwAkzSaHBmt1exIVb4zzdN6eMlUFukEWHz?=
 =?us-ascii?Q?VYRWVBE8RbvoRoSIp7+8FI8kXjrnFV0cTED++45uGeBvzccFSEMM?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 321bfca1-529f-4a01-5e91-08df0e5e36ff
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 10:36:32.3792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TvlFlS7DYG67hq5WPTw60ve3Z4Iarrnzxkgn3mlyPrIXJGl5l2W8tAhsSiaudmEmGnwcL/YVFxF5oG9H+YJHAocOQbMvocTNZaoeiR67wiz14HPPQ/tOhGMk9XSGEhqL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7066

From: Wei Fang <wei.fang@nxp.com>

ENETC v4 VF hardware supports MAC address filtering, but the underlying
resources (the PSIPMMR register and per-SI hash filter tables) are owned
by the PF. Add VSI-to-PSI mailbox messages so a VF can request MAC
filter configuration from the PF, using two new command IDs under the
existing MAC filter class (0x20):

1. ENETC_MSG_SET_MAC_HASH_TABLE (cmd_id 3): program the unicast and/or
   multicast MAC hash filter table. Unicast filtering is only allowed for
   a trusted VF, since it could be used to receive traffic destined for
   other SIs. Multicast filtering is allowed even for an untrusted VF,
   but limited to ENETC_VF_MC_HASH_BITS_MAX (8) buckets, enough for basic
   operation such as IPv6 neighbor discovery and mDNS; a trusted VF may
   use all 64 buckets.

2. ENETC_MSG_SET_MAC_PROMISC_MODE (cmd_id 5): enable or disable unicast/
   multicast promiscuous mode, and optionally flush the hash filter
   table. Enabling promiscuous mode requires a trusted VF; flushing the
   table alone does not.

The PSIPMMR register is a shared resource accessed by both
enetc4_pf_set_rx_mode() and the VF message handler via a non-atomic
read-modify-write, so protect these accesses with si->gen_lock to avoid
lost updates on SMP.

When a VF loses trusted status via ndo_set_vf_trust(), clear its unicast
hash filter and disable promiscuous mode so it cannot receive traffic
beyond its allowed scope.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../ethernet/freescale/enetc/enetc4_debugfs.c |  51 ++++--
 .../net/ethernet/freescale/enetc/enetc4_pf.c  |   7 +-
 .../ethernet/freescale/enetc/enetc_mailbox.h  |  42 +++++
 .../net/ethernet/freescale/enetc/enetc_msg.c  | 160 +++++++++++++++++-
 .../net/ethernet/freescale/enetc/enetc_pf.h   |   1 +
 .../freescale/enetc/enetc_pf_common.c         |  68 ++++++--
 .../net/ethernet/freescale/enetc/enetc_vf.c   |   6 +-
 7 files changed, 300 insertions(+), 35 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c b/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c
index 5029038bf99f..c73722e2285f 100644
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
+	spin_lock(&pf->si->gen_lock);
 	val = enetc_port_rd(hw, ENETC4_PSIPMMR);
+	spin_unlock(&pf->si->gen_lock);
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
index eedcaf2d7bc9..abe1e8dafe24 100644
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
 
+	spin_lock(&si->gen_lock);
 	enetc_set_si_uc_promisc(si, 0, uc_promisc);
 	enetc_set_si_mc_promisc(si, 0, mc_promisc);
+	spin_unlock(&si->gen_lock);
 
 	if (uc_promisc) {
 		enetc_set_si_uc_hash_filter(si, 0, 0);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_mailbox.h b/drivers/net/ethernet/freescale/enetc/enetc_mailbox.h
index 832d2f6ddcd8..6fa66c863748 100644
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
index 08a9ffdd3eb0..22f5485e968a 100644
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
 
@@ -108,6 +110,130 @@ static u16 enetc_msg_set_vf_primary_mac_addr(struct enetc_pf *pf, int vf_id,
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
+	spin_lock(&si->gen_lock);
+	if (type & ENETC_MAC_FILTER_TYPE_UC)
+		enetc_set_si_uc_promisc(si, si_id, promisc);
+
+	if (type & ENETC_MAC_FILTER_TYPE_MC)
+		enetc_set_si_mc_promisc(si, si_id, promisc);
+	spin_unlock(&si->gen_lock);
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
@@ -116,6 +242,10 @@ static u16 enetc_msg_handle_mac_filter(struct enetc_pf *pf, int vf_id,
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
@@ -333,8 +463,7 @@ static void enetc_msg_handle_rxmsg(struct enetc_pf *pf, int vf_id,
 	if (msg_size > ENETC_DEFAULT_MSG_SIZE) {
 		dev_err_ratelimited(dev,
 				    "Invalid message size: %u\n", msg_size);
-		*pf_msg = FIELD_PREP(ENETC_PF_MSG_CLASS_ID,
-				     ENETC_MSG_CLASS_ID_INVALID_MSG_LEN);
+		*pf_msg = ENETC_PF_MSG_INV_LEN;
 		return;
 	}
 
@@ -352,6 +481,14 @@ static void enetc_msg_handle_rxmsg(struct enetc_pf *pf, int vf_id,
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
@@ -362,7 +499,6 @@ static void enetc_msg_handle_rxmsg(struct enetc_pf *pf, int vf_id,
 
 	/* Default to not supported */
 	*pf_msg = ENETC_PF_MSG_NOTSUPP;
-	msg_hdr = (struct enetc_msg_header *)msg;
 
 	/* Currently, asynchronous actions are not supported */
 	if (FIELD_GET(ENETC_VF_MSG_COOKIE, msg_hdr->cookie)) {
@@ -536,6 +672,7 @@ static void enetc_msg_clear_vf_config(struct enetc_pf *pf, int vf_id)
 {
 	struct enetc_vf_state *vf_state = &pf->vf_state[vf_id];
 	struct enetc_si *si = pf->si;
+	int si_id = vf_id + 1;
 
 	/* For ENETC v1, we only support setting the VF's MAC address via
 	 * VSI-to-PSI messages, so there is no configuration to clear.
@@ -543,9 +680,18 @@ static void enetc_msg_clear_vf_config(struct enetc_pf *pf, int vf_id)
 	if (is_enetc_rev1(si))
 		return;
 
+	mutex_lock(&vf_state->lock);
+
 	spin_lock(&si->gen_lock);
 	vf_state->msg_fail_cnt = 0;
+	enetc_set_si_uc_promisc(si, si_id, false);
+	enetc_set_si_mc_promisc(si, si_id, false);
 	spin_unlock(&si->gen_lock);
+
+	enetc_set_si_uc_hash_filter(si, si_id, 0);
+	enetc_set_si_mc_hash_filter(si, si_id, 0);
+
+	mutex_unlock(&vf_state->lock);
 }
 
 static void enetc_msg_psi_free(struct enetc_pf *pf)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
index 88a558649c68..c5eda6c8eaf0 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
@@ -6,6 +6,7 @@
 
 #define ENETC_PF_NUM_RINGS	8
 #define ENETC_VLAN_HT_SIZE	64
+#define ENETC_VF_MC_HASH_BITS_MAX	8 /* For untrusted VFs */
 
 enum enetc_vf_flags {
 	ENETC_VF_FLAG_PF_SET_MAC	= BIT(0),
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 1b2ca2b31a80..9dbb0a1417ea 100644
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
@@ -591,6 +609,8 @@ int enetc_pf_set_vf_trust(struct net_device *ndev, int vf, bool setting)
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	struct enetc_pf *pf = enetc_si_priv(priv->si);
 	struct enetc_vf_state *vf_state;
+	struct enetc_si *si = priv->si;
+	int si_id = vf + 1;
 
 	if (vf >= pf->total_vfs)
 		return -EINVAL;
@@ -598,11 +618,39 @@ int enetc_pf_set_vf_trust(struct net_device *ndev, int vf, bool setting)
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
+		spin_lock(&si->gen_lock);
+		enetc_set_si_uc_promisc(si, si_id, false);
+		enetc_set_si_mc_promisc(si, si_id, false);
+		spin_unlock(&si->gen_lock);
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

