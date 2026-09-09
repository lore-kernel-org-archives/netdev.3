Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013054.outbound.protection.outlook.com [40.107.162.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D770523789;
	Wed,  9 Sep 2026 10:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788950146; cv=fail; b=WrTsSRwbYmwJSlDXfxUoJV7mnpJtdq45mVlQGAc/hTM5VxwOtAWl5VIJxkSv1ND8/6susWHQacmqJfGkICK5Hcp/l1S2cqch9suUy4/I3w6Sn8mBb2yktuoh9cia4SEGcg6BsA0zZCAJ4ZRxEPbLsfgbTbEWXTyFd8bWR9lu8HE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788950146; c=relaxed/simple;
	bh=0lnAR2Hxu30uyZpOFNs3+BkVV8qbrHCcfd8tNkfXpVw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qtuNtB5ipl3kIeghBR9zFd/aq+BBls4pp75vc44NFbgB8dZaLfc6tLj+V9A726uXwbNFjx02VjufRHj8b/BAlgfJJvMNF5cwICFlEqQpafmAH81QzfeIT0kG6cpTz0Hvq3TDqgdkJ2SjGGk6MUjWJVNPkpNDk86g91bDepnDsdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=DVBGfBnm; arc=fail smtp.client-ip=40.107.162.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="DVBGfBnm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uPc+T6QyigG+lXi+sknEfK/G2grbVMud9cekdjROSJIzjKmK42ldpIVSmXvquhE8ijByHyXvHmQMO69NFSI2K1j1lCG4H4iv9VPUVtJCbWyTIVLuA9UFaXTjb4poBN4bl1UzAaTJX7eN097eFH9uXTxtWTJtB7gWDZW/pVQdJXVN47p4S2vrcCZGUGGMeS+k4ejVNSVtaeYXoiy5p/KcEoKknBeMkWzLxS0s9ALLdSq3sGJFoMzJ75WBzzod9qv1uNT/1Es0Ei4v5lNdLvA6AYs9HcNmGqL4f4BOPVFixKhR3OgDbZW3fW/8Xl+JzmVkTc7CpVN+jEmSKKQjoobxHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oeO2fTXAMthf+Koe8T0L16jzuT6ZeDedLwHoyavXr4M=;
 b=J3iObWGPMm8gZIo0GDsu0an+keKh1NNvLUgZCsXzzkfFaQ9Fr4LPDLsZl+0rfhdERDfTq1eSwHOO4k1B5cA7KpQOnv4wZae8WY1XaohQVgstAmd2URpr0nzdZaVoqiMPiXcvFke6PbFnXYEQ1RoA2K5RQSCuxHCsM1d7uhTsC/gX3/rOeeRP+I2iYcO1+dnXYMMxHQOSwl7VuKO9oKNZ8I/gkTny+l6iQYS5r0FatihfIS37o9LqzXUPrA37JGkc+XgwFrUnDCbissvCBEpE+5d797RPtC4CBWbHxQ+bE7Znh8DO4EenciU/2n8+MVQdFnD38PnHG9oqzSZ+4HbQBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oeO2fTXAMthf+Koe8T0L16jzuT6ZeDedLwHoyavXr4M=;
 b=DVBGfBnmRQiO5DJwa/HgdfvPiRTJ4h55rnejcPP6s64Vhzc9LGBd2hL1DTN3LeJ/4SnTLYnsrMxpBjlQ8GxcfcNqWvk1ZUeafU7UWCEUcpl6ysNLG20KWSjoovKVHePMriHjyGl9iRXeYvP+btL3PZIwv7WIeU95RPPDpLiJKJ/fD2CtY6SQxI6GcRNGISNBo1hxjW64nIA1P8PddOqFEmLO8l6hwlnRjqEKpAKadmglw6VNQMLXLl0uFplTgCrTUz5pMxGI2v7GrYFhFjFf7Ez1U8a/s6CsW/Hwaaj0204+lxBSqZQUexLnlG9Ood+qA98PvlgKn3znmC3UDv3w5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by DB8PR04MB7066.eurprd04.prod.outlook.com (2603:10a6:10:12e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Wed, 9 Sep 2026
 10:35:41 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 10:35:41 +0000
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
Subject: [PATCH v4 net-next 02/15] net: enetc: move msg_task and msg_int_name to struct enetc_si
Date: Wed,  9 Sep 2026 18:07:20 +0800
Message-Id: <20260909100733.1139689-3-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260909100733.1139689-1-wei.fang@oss.nxp.com>
References: <20260909100733.1139689-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:194::20) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|DB8PR04MB7066:EE_
X-MS-Office365-Filtering-Correlation-Id: b7e52c9e-b0ec-4571-5bd4-08df0e5e18dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|376014|1800799024|23010399003|366016|10067099003|11063799006|56012099006|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	FK9SU4QrYJcVE9mzbcAgRV/sq6c6t19X98vXli+6O7mSVbg/jOy9Md4EkvTKh6memsFS+QBOITMZfjR9SFm4oKWYHovrOAWX6RXdfeVYz0w44VVhJUHRWbkm1TVgNo7VB5gs7RT2HFvwGr99t4076sU2+k++p97FPUkedEivTTr6DVOZlBeh0A+YVFiDCjMAPcSpHEOIj0tuKch7Oi6ROZo1ZTx9nw0qeXL2dvzuL8YCoY42EABQxS2FIg/AzTdXGp9heuEaXC3PgX4giuGgwcF4zlWQnOA6+lmXZitKkg5pY3eJa+xZMUfUe+1eGFWGugBe/CvDWDxHinny7OaT9UE1VfceehDAmAIB+oJJXp3XnDapFV9GpQv8EiTEuJdNitgLqxuOpInJNizHBXNtb5l//SEFTGJijbco0safXHFITCPuqjcGQfhzXNqyj77IJBdg1lu12e3kXh/p/xOT/3XOFPDvga/UrcZlBcbdN8EW6qf5E9jkXfvE40fWEkG10pk84QKb2ea67+vpcqV+Fp1edVZQEmUwQBoE9F5nymNW9PTRvzMMLP85ZQPttQUI9v8anUxv8fL1XoZ5l67ikbrhjoAykgcpKBcDG9uofdldC+iJS80cSHiaGEJ49+fywUFpoB7bdSR2VwknKpngYL/WcHvHEvkckLQQv5ExGAe2CIXeWag3WROKqQ8U/OXhOFIE2CIxJv03hvIE4EGLtw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(1800799024)(23010399003)(366016)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/PSlFL79RINi9JPrx1sfGfqhd92B96H0m2yEIlR7W+a15l7sG35FO+9ziT/n?=
 =?us-ascii?Q?QGJjUEL9Hj51yz40lp84+5YsnDeVa7YXl3u5/crGlkRHWrodJupmXB1MXlRU?=
 =?us-ascii?Q?v/GEkFN80sJm7a+/0mMNYceTJZV7gcgLlFlIcCpeyIDbW0LOV1wfC4BQeA3C?=
 =?us-ascii?Q?i7cY5AA90W8GLQAx1VnoFofsfx69XXtnpK9+PXP5aOYUeFhoUA/a/2zMJq1n?=
 =?us-ascii?Q?bjgPy3VttUEKyvpdJzwTXbN5UVtkWot/U9F2QPjGus8uz5aeGu3F/No7jEq+?=
 =?us-ascii?Q?b61s8TkiCKx5BrRjDRUyHnEdZaT9H6Qvmim9/6zeabV3LwcJLktcxeC/f8tO?=
 =?us-ascii?Q?DwSy3WSlS7TgMjTncuxLH3IT6DZzC2zm3xPp4logDcF0teN5/EySgbPcvmQq?=
 =?us-ascii?Q?cABoHLdK3Fbw35+OMJw1XjHfQQhMiNDFqtjY9Pgj8+cN5RRlX3dA9gIrDDu7?=
 =?us-ascii?Q?qGS4Sr6UI9qHkVZGNyE4cYSr9JfbIYH3lznCu4WYLaHGpafmeFdHtzQIlJMM?=
 =?us-ascii?Q?HBdPwKC4WXj75YbE54B7IJrvGElS9h+miB0/5JGQS5pqD67cRi4JzrTTDgvG?=
 =?us-ascii?Q?YOwLANkiXGIesrOnHtUOo+lfRhL0rhC26yHkz+r64eMRXOL6xfaEoo65T+72?=
 =?us-ascii?Q?C3C2WDAkBQCPYLu/JNodzY2V0KDQFEx4U6wjGLcTVHXIOISXs0/jXIB7anZk?=
 =?us-ascii?Q?ZVXUzZSWZqNK6YLs1ST6sU0WAc45uyzTwmPE45jPRezA9/G8jv0EDwqFHC/m?=
 =?us-ascii?Q?tgD4v7qBB7ZCCMSqzDEvSD95QPOaVSXbTej3kXPOimJWv5hrvjGzvRGWPY7c?=
 =?us-ascii?Q?yUwuT/p+DqiivpjAQvmN8UZW4LCS2kDSD4QrkJAso4pC4QIKPaULxUI2t9P+?=
 =?us-ascii?Q?uVjzXIf2QcTYpwH+QaDEpUITwN0bL3GDjyJllv180K3R1CP7k4XVpEp5UN4L?=
 =?us-ascii?Q?OfR49DT2VOh5a513p1YHkiwcxtwIrMzXAKYbSiMHxfNaZ3q1mrGlfXWcjQww?=
 =?us-ascii?Q?VN5nQVrNRW8SmtaVt0hbWcTcV48Sa0dQXPXjbrMnxxSYmb03YPCuzSdDK0ct?=
 =?us-ascii?Q?UXnXwHIG9eRLtl1tkvRh4Pnfn4/K0yKyndoCXz57gmHxeaDfmVsN2ygF/M0R?=
 =?us-ascii?Q?uLkJkTmjInfEgGxlTxMIXV+V2qr62WH4bA3Xd8Mfov1syTqX7Bztqp4bgZaA?=
 =?us-ascii?Q?ELjjgaN2sphPGcuzds9uh7MrJG4IGz25RsJx5Hc+DrhduMV5T9a3+c+7c5fr?=
 =?us-ascii?Q?qvAwxxt7i3AB6QvlGfFPnRZ+NIoqkgSws6tc/5NDJrJDdA8Kfd/O7PZmmx71?=
 =?us-ascii?Q?qRXDYZCjL+uXivlBfeF2Qr4u6gKEvsFSyuc5lBYJeUONSMwDTrXJwKwdnFgt?=
 =?us-ascii?Q?cgp313APxwLjgSs1ijNEISjAtpj7bvTMsQi5NN64EpXoIt0zhW2OmvLoUqPe?=
 =?us-ascii?Q?VB342IWb3w0M9fz2zzCAswe3On1WFytY1sthMVuq61L/srZXMwGNHE4AqXxU?=
 =?us-ascii?Q?D137kYXWtljq0uLU0IOHzFsqknXXaIiXE3sKtEsV0rEA3jhq+c/v4jLWQdOD?=
 =?us-ascii?Q?gyo+2pGvMJFwmw9lPCCCPCGmwHFcnfLDmtZBWlLmIobsTq54wqrRss5AuPnF?=
 =?us-ascii?Q?22MF0eBEBI9Kk+DGMnIfv1Roy2ZRtL23lepdGPvWHKb58ERYOGHiiuv3bvKo?=
 =?us-ascii?Q?y0faT4YCZMT46KvrbCz5SqP0hr+4FNlmuDDoe7zT479EVe6x7BoEHf6zxCd9?=
 =?us-ascii?Q?RGfEpqDS14MaTvRkDVrm5/jFwgjJfS93CAGy6LVEcYFWQGrk6Z/N?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7e52c9e-b0ec-4571-5bd4-08df0e5e18dd
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 10:35:41.7898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PuYe5xqkURM5IWuw8S4xXpy+fCScpXkS+Aac50K/ou1k/Fh5qE6hOBD4nqD7W3RmP8zcCvbovxmBKfKidpnYA/V8PXWpJV1/foGnmQWmmvUHErm8HM2wvXTDfvo6NfII
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7066

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

