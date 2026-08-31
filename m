Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011009.outbound.protection.outlook.com [52.101.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C923AF656;
	Mon, 31 Aug 2026 03:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788146556; cv=fail; b=gs8jwcy4wiUbwJmWa/OlkGqTYdZOnX8+OtFXbmcU+PpDFUjuLF67mMtY8AkYedo7Oqur7oWAiBTnfKTFnB0I7UW0/9FR7HWsM1tS4qpj7hdgHxKQvCWTf/TBhqM7ncCh8aHCCd1UJQh5GV7KkIX9AUcmsyNLw3Xf8v54fSrAt64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788146556; c=relaxed/simple;
	bh=0lnAR2Hxu30uyZpOFNs3+BkVV8qbrHCcfd8tNkfXpVw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C+SjLovYC1PISmGq+He7wJlyQ8zAP9YgmTZZkqBEeH/Ls6A2sWq/RlBqwHKoeaJ2njlmXyZ2bdWgMLsfWhjB1iJcwOkKL/YFEIBMVbkpK/cEyTnKkherN+TLkySlP4MUEwyCYiR/t/NSnaf/+2aVlmxnnu4QnA5pivmI5/zlPb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=CfpHSY5i; arc=fail smtp.client-ip=52.101.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="CfpHSY5i"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uI93aZTvKanb9RLnZSkfmy/W5w90qusA3X3wnFvo2xxe35fFulxnafSTxTwgqsABlszlszrIAMZ7RuKvLYNp8kUrBdMlCIoALf+1VZzcmeV9j3a84Xt/teMlRbPCT9GsxiD6ejskR1ssB8OtQNq7pmGb2G7cXTGgtchU8/i6yYqIGlgGtkzdrgpXXWb74M0BCkoQleoeI6VUxdrMqX3P/jz3v0miHHBnYuwrNOsqZLErLAD8GTH07CDYHjEbt/XkY2nQIZjcUlQ6U+lApe2ImSd4LX2SdcqcPdSynpw2pOzIQQBlqTMCdF374f8fAyyHerDcTzW/BNWSHD7Y+lKqQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oeO2fTXAMthf+Koe8T0L16jzuT6ZeDedLwHoyavXr4M=;
 b=erarxUAAAr++fv/pzni8qq8y0D+GR4UGpgOLRVftveGLxJyVX75sv2ffgXO7vb/CcaZnQ9nD7MToUIGjyIrSEazQZAnmC4uuynsXDvkoMvQDzb36NsMP4jC37z5Qa/JSS5bz/jAjwVuQy80V/et+fqGBKavY4gS4j/roJhfyyEpTCqsX7pjWtL7z4INgr2j5B9U7L5QBlI3tTIAaGJpcMtKgEfZo/tRed1yssjpnXG4Bqh7qSOGS54ad4zpxaE6PSbTh4ooeQXutC4PfqJ4lOLoRmSDQgVssiWIjSEUJ80DvmhsPk3KJ/L3KuG3oB7z6NfHNe2uQQFx7RQKlOfeFZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oeO2fTXAMthf+Koe8T0L16jzuT6ZeDedLwHoyavXr4M=;
 b=CfpHSY5iz1rVJR8m5msg5n5OeosgKFKGovw8EPo+x1sIvZMF0wzoaCed1J8xSST0p6oOv8zzOc/TSyIE9M8/4p4DpZIfkAj64xWqOhHT55NLMDwG5hE3pMky/p39G/PeWLl2BdrVc7zN//Z46FdIaXKmInRq7aoV4IPgQAjE9wzwDbfit2q3jjjVv0cPe6yB/Dbjds3d7Z0tdx+LygTx73YJg/PXbiIdpxRrzSp1HewOSH4zTGbz79hef9WexI88PCb4F6ia2CmzZJh04CjtGDZoBgR2BmN3d+tkiKaFP1Xmzvg/ZMC42Q+86mkLVFW/vfJYvWC6xxE8WXhSxK2qRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by DB9PR04MB9234.eurprd04.prod.outlook.com (2603:10a6:10:372::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 03:22:31 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 03:22:31 +0000
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
Subject: [PATCH v3 net-next 02/15] net: enetc: move msg_task and msg_int_name to struct enetc_si
Date: Mon, 31 Aug 2026 10:54:28 +0800
Message-Id: <20260831025441.635045-3-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260831025441.635045-1-wei.fang@oss.nxp.com>
References: <20260831025441.635045-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0051.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::6) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|DB9PR04MB9234:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ef6a705-eca3-4aa2-6b3a-08df070f17c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|23010399003|1800799024|7416014|376014|10067099003|18002099003|22082099003|11063799006|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	x7TJin6Oz0SBHrgZEJQrW+HyhL9vGB22a/AtN+VmUvzW0W3Do1t1My0YcgUhvYbFQ2+7BUsVh5ENF+y7QvCIwm7aFKgCKQ7xnVdMod/pmKfEQp72iAIhdBuRIhiLJ2G4EiJYGnymH5niRQK6ytwblXY1fpzagy02+W/PLgT57Lz//9OGB57ExGcoVt86y4YibcbyTwXlHGHCiYqQsV30O9x9P7ux1wSI6+Oiw7ZGJP9fsaGklGaClIWxRxHm5y93juU82deu3S0P39kRlIcvEqO1K4RyYxe5HbrEaTnIMBh2PDghCqeIOOkh0PRW8WuGDui4bX78OCqb/lGpKpEozvCGj+pUWBFqOyaMxZYEqgEcyMnumYfupwC41ksHAG9ydm6LGq/xeRI9hqVIXpMpNs5FPkKNsUYrcXfI6yLFRRsyNfcVykiSquctT7kEVnHmcExyU+nuimXd1a5mE/8V3tPP4R7hMDs0A6uUrSwuzuJVa6Hoz4UIBWAaftJvtkEfUtS+1WVUkOXypevjl2GFas50Rg4ehudlZ2ER+GFtgtUIAFNnC9YqdaBFEFGKBnhUxNBZdZKx3F9LaOAu1/pOubZl7b2aURFl6Iv31cdfR2V52crBrv3Nt4IsJkLJJrwn4u9QofOTUPN+5gK6/JIr3CiSTL8hetRYYseiaZKUqsYdECSqSusXSqXyj8qd2SRl747eP5bXN7uDDEpiKA8SQQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(23010399003)(1800799024)(7416014)(376014)(10067099003)(18002099003)(22082099003)(11063799006)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5BUOT3L1fxa8NF/ClKkLg+N+lk5sqr3z/k3gLm+l2ZIurDHoFV2pTWeMRMV9?=
 =?us-ascii?Q?Tr53yeXB44jqEUB/nmeqQa2gWsFtKASHSmuexO9JiC0DiYlCQwTkEz21xuAS?=
 =?us-ascii?Q?pnmgpcCkcr6cTHl0Gq61kex9gsRtmT1weN1Vjh5qeOGk4mh8bj6altM3aFdP?=
 =?us-ascii?Q?43F6HQYE9f7x21Jno75vNLFCOHAYeQlN16g9kVxMv1Uj6U4mv6v8qZYfMDl1?=
 =?us-ascii?Q?PH1steDY4nWlmzjxZ4I8vQ0R/U5S/OKaxziEnxmhCREN57zTdLLBwtaQetS0?=
 =?us-ascii?Q?DadJ7VH21BTqE4xYpBYaK9LuPm2hjGWrNGiaL2cfVwSvyE5SciDiRit1S+CN?=
 =?us-ascii?Q?I/U/OGYUBgwe2LLtdNJwgHpohFdcJY3+ATjDeZjpC//SOV/2Oa8tGBuEW7tK?=
 =?us-ascii?Q?CHKDYtpnhJ0D8UWa6VqjOVKlUF3sLb7uKJt2Q3dosc0uJO5SdpaIdinPK35S?=
 =?us-ascii?Q?4UL1xbR0HhytviCDpDLKp99oaiEFhkv0VS9B2oUuWCM9ijnRu2J6SpjupH8S?=
 =?us-ascii?Q?XvgQ5xhFaOtkeiRjU9qxTXf3Fypz28nVg2lU0mqhI+u45JgbP+1YnB2CibyU?=
 =?us-ascii?Q?+Thza1s/MLlbfKbcEMlimG5koGr/SHEhkoq4BwQgXJ/QFuu4nckZ3eTtjlEA?=
 =?us-ascii?Q?fT1VIuGD3z3xQ0Pgfyrkgm02ji2al8u1+BHwZiyQn0jA4Bi7HRE5Q82KPYBL?=
 =?us-ascii?Q?/CGg/X/nvyl/xwvYIhP/V5V/3OPLExAJsfmIh/ruFIvulH8z9oK7JsUpauBF?=
 =?us-ascii?Q?2bUvf+4LAaiGZK0Ki/IseVKmwFqAUi3XhbvZ4BF2Sv+X5M/tTYZ7dGrCD2su?=
 =?us-ascii?Q?R7USLRi42zxZXB/kuLWf4YxhVlwC1I0czRuXgUqN5i2YbigqjWjB2oFv5Fuc?=
 =?us-ascii?Q?SUocuoPH9838rcr5FyqOXTHVpzWb9J9niL/U/Qm3Ooq17dUK4e1HH7+QD388?=
 =?us-ascii?Q?EyRctCoAILcbfB9TMZ/piPqxMJ0dxFfXW7MhqYBqKXsui7uGsg1hrx/qsHCz?=
 =?us-ascii?Q?TE/yo07zzNiIqq+2Rz8d11U2vIl/9H6IbIvTCXrAEyQIM8e+SLjfx1OcHF8W?=
 =?us-ascii?Q?jg4Xi/k86/6jX9dLlIdgG5o4luqEDI2CZRaf+Q2L+vK62u+5DfeezVrhHQuB?=
 =?us-ascii?Q?ZgEivV+XaGbOTsrOZmR4bMF2aN/ycpxUCMTPlz+S7c5vntZLOVWgtwmuGSlE?=
 =?us-ascii?Q?GI/RVgKgq93pTVhgz9dAPnSjh5K9llQoO946/4SqrEgd+7o0PB4+tbkd26EI?=
 =?us-ascii?Q?7bBrut0eTK9VKFA1Dz4wcBO5Nc+4fZtCvEpVQfDI8I6obKP1zayYm93hpSVl?=
 =?us-ascii?Q?4M6DP29wmCEhtZbQH19YK/fDaLcotc4z1KjoNRjiwL5rhD4nYm9ps9Lom3/6?=
 =?us-ascii?Q?Rqn9v/0u30IcsDecvOvbSecBreBNwpNMwqNnFecT2F2a1kCv/OvFY8Ny0TuY?=
 =?us-ascii?Q?NEJiJ8GSlN5R7FOlpQawokHRlxRfo3d3z4XEEFJtQCV5gouotBg8b3LBXfKC?=
 =?us-ascii?Q?uK835zOPbOMRhLa5/h93gyropaXOk2asN6ZzogNLZaO5MZ4QwMIwP4YAFwcL?=
 =?us-ascii?Q?hkMivANxSci9BBpaIJiteq7uuJYGHOP4dU90XI8g36gX7ub1htghgtrZY26C?=
 =?us-ascii?Q?xVw4MpbxgE6xEY0W28JTsBWo20Uvb+eXPYZeGPF5YdXFB97BNF/bR1fpJjKm?=
 =?us-ascii?Q?3gFRzKtmA3U9x+6xRV2zmvmJ2pJim5ELaZ2CgZTXaKjwe+GKKY7AefvOolnb?=
 =?us-ascii?Q?toBlciD3+mlIQnk8pkQEJsn4h6jgQy28Cw3nX2JT8H5KI9mvYIpH?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ef6a705-eca3-4aa2-6b3a-08df070f17c1
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 03:22:31.5404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2rQyyhHFYlCkZ3YypQy6DhWpwBcCpksa677Ofozm/OMMtfXyOBAgOn9Ie7O8/cRpHTGyVE1FQ6rYxiqHAKlfU55eKxElsSIN+dYF0EtX/ImfL1bIcwiA3kVo4bbydxaD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9234

From: Wei Fang <wei.fang@nxp.com>

The ENETC PF currently uses msg_task and msg_int_name in struct enetc_pf
to handle VSI-to-PSI mailbox messages via a workqueue and a dedicated
interrupt.

PSI-to-VSI message support will be added to the VF driver, which will
require the same mechanism: a message interrupt and a workqueue handler.
Since struct enetc_si is the common structure shared between PF and VF,
move msg_task and msg_int_name from struct enetc_pf to struct enetc_si
to allow both drivers to use them without duplication.

Also relocate the ENETC_INT_NAME_MAX macro definition ahead of struct
enetc_si so it can be used for the msg_int_name array declaration.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.h  |  4 +++-
 .../net/ethernet/freescale/enetc/enetc_msg.c  | 19 ++++++++++---------
 .../net/ethernet/freescale/enetc/enetc_pf.h   |  3 ---
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index d1e9d9130057..bc713a7c3aa1 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -25,6 +25,7 @@
 #define ENETC_CBD_DATA_MEM_ALIGN 64
 
 #define ENETC_MADDR_HASH_TBL_SZ	64
+#define ENETC_INT_NAME_MAX	(IFNAMSIZ + 8)
 
 enum enetc_mac_addr_type {UC, MC, MADDR_TYPE};
 
@@ -333,6 +334,8 @@ struct enetc_si {
 
 	struct dentry *debugfs_root;
 	struct enetc_msg_swbd msg; /* Only valid for VSI */
+	struct work_struct msg_task;
+	char msg_int_name[ENETC_INT_NAME_MAX];
 };
 
 #define ENETC_SI_ALIGN	32
@@ -374,7 +377,6 @@ static inline bool enetc_is_pseudo_mac(struct enetc_si *si)
 }
 
 #define ENETC_MAX_NUM_TXQS	8
-#define ENETC_INT_NAME_MAX	(IFNAMSIZ + 8)
 
 struct enetc_int_vector {
 	void __iomem *rbier;
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_msg.c b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
index 78114ab3e482..a89a5a418a23 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_msg.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
@@ -37,7 +37,7 @@ static irqreturn_t enetc_msg_psi_msix(int irq, void *data)
 	struct enetc_pf *pf = enetc_si_priv(si);
 
 	enetc_msg_disable_mr_int(pf);
-	schedule_work(&pf->msg_task);
+	schedule_work(&si->msg_task);
 
 	return IRQ_HANDLED;
 }
@@ -223,12 +223,13 @@ static void enetc_msg_handle_rxmsg(struct enetc_pf *pf, int vf_id,
 
 static void enetc_msg_task(struct work_struct *work)
 {
-	struct enetc_pf *pf = container_of(work, struct enetc_pf, msg_task);
-	u32 mr_mask = ENETC_PSIMR_MASK(pf->num_vfs);
-	struct enetc_hw *hw = &pf->si->hw;
-	u32 mr_status;
+	struct enetc_si *si = container_of(work, struct enetc_si, msg_task);
+	struct enetc_pf *pf = enetc_si_priv(si);
+	struct enetc_hw *hw = &si->hw;
+	u32 mr_status, mr_mask;
 	int i;
 
+	mr_mask = ENETC_PSIMR_MASK(pf->num_vfs);
 	mr_status = (enetc_rd(hw, ENETC_PSIMSGRR) & mr_mask) |
 		    (enetc_rd(hw, ENETC_PSIIDR) & mr_mask);
 	if (!mr_status)
@@ -311,13 +312,13 @@ static int enetc_msg_psi_init(struct enetc_pf *pf)
 	}
 
 	/* initialize PSI mailbox */
-	INIT_WORK(&pf->msg_task, enetc_msg_task);
+	INIT_WORK(&si->msg_task, enetc_msg_task);
 
 	/* register message passing interrupt handler */
-	snprintf(pf->msg_int_name, sizeof(pf->msg_int_name), "%s-vfmsg",
+	snprintf(si->msg_int_name, sizeof(si->msg_int_name), "%s-vfmsg",
 		 si->ndev->name);
 	vector = pci_irq_vector(si->pdev, ENETC_SI_INT_IDX);
-	err = request_irq(vector, enetc_msg_psi_msix, 0, pf->msg_int_name, si);
+	err = request_irq(vector, enetc_msg_psi_msix, 0, si->msg_int_name, si);
 	if (err) {
 		dev_err(&si->pdev->dev,
 			"PSI messaging: request_irq() failed!\n");
@@ -350,7 +351,7 @@ static void enetc_msg_psi_free(struct enetc_pf *pf)
 	/* de-register message passing interrupt handler */
 	free_irq(pci_irq_vector(si->pdev, ENETC_SI_INT_IDX), si);
 
-	cancel_work_sync(&pf->msg_task);
+	cancel_work_sync(&si->msg_task);
 
 	/* MR interrupts may be re-enabled by workqueue */
 	enetc_msg_disable_mr_int(pf);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
index 6789f92d005e..142c911f1dfc 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
@@ -40,10 +40,7 @@ struct enetc_pf {
 	struct enetc_vf_state *vf_state;
 
 	struct enetc_mac_filter mac_filter[MADDR_TYPE];
-
 	struct enetc_msg_swbd *rxmsg;
-	struct work_struct msg_task;
-	char msg_int_name[ENETC_INT_NAME_MAX];
 
 	DECLARE_BITMAP(vlan_ht_filter, ENETC_VLAN_HT_SIZE);
 	DECLARE_BITMAP(active_vlans, VLAN_N_VID);
-- 
2.34.1

