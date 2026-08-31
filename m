Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013042.outbound.protection.outlook.com [52.101.83.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401573ED5B6;
	Mon, 31 Aug 2026 08:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788164412; cv=fail; b=T8JyYAdaH4r0p4I27EamBAtBk8vZm9O0iNZnC7/2v1mOL5LjAZ8StO5feL12LXJJ3l9Zt6ACkhJZL5aSeP40fHG2YWRkci6dIYPc/w1ralZu15xpJAt5VY03wwuCVxT9wuyGcxdqNOKbURuQsCbuecE21FZ9wcNXHucPwnghisI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788164412; c=relaxed/simple;
	bh=m+QGyu2W98aZR+N4BSibOAIRpuMUoAe4pVHhdUnWNkg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U7bJ3xw0zMn0jK1dj7h+L76HAmi62D7qEY8pc42bUHc3D4RNTkxgTIgXE9yUdNaDPFdFGTMImcGGgJsKy4kMyAxeFQeb2ohXAjZ+DY3gF0D7NHy98yD4FPK0N8h2vtnOx+1i/gcuOjnxRdxbELE8k4jZaccvJXukaIlhw61qT0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=uOhUF5Sl; arc=fail smtp.client-ip=52.101.83.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="uOhUF5Sl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UFedeQ2pItPVOPnzLU83xXh4sFKuooVPg+a+OTRt4sQip57PBdZzzex26vSf/Dy30dZNbJceb8Izf+9vQuZ7rBzpdsqHGBKPq148UtoBb+HCk7o/J3e+xEOHCJFsSJpC5j+mp7yL5KkczpdUcCBdAKLsekJD4WEIpec/qYptBtECoVm49kuy18/zJBRPp2WEt/z/tjXtpmnQ+Xu2j0XXgYWeb9K4i8LgmHrUjtzD+e8+hPzAQbl0lAKfBM4bFgE410dRKnqw2k6u8jSjHqR4xHRaPAt5DIvYUpcm2TAaxP0GsdV7cubYFeK9w155Vs9uYHEUiOHn6+Pp6pjcUAs2Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WVLJiULqCkuRsfE6wOkpHWA/zJB7qu7mD7QDtDKEs8A=;
 b=NmHt73ijTJopmwWaV3SETjs7VGK+HaivScgi2PYg983Fg6dv6FO46c/duTvelLmCb7Mn8wp4tsF0s1d0iEpxqP5BX4lGoO1l9xFeXe1zTKWBJfSL98lfitvRrbiU9caT5fmbxQ7hdKIiqueogMfQiz1qGj0hlik3wxuxW4DFFhAE4RDyb9yDV/1gwSKR8lWH1kQkQt9/fDkf3Nwekz9rwTXwyBSmevWXMNJSNWf905OL+R86BbVvhqimOHX8Szmhi/WIW8CzDssbNONNt10UVcjFe99ABb2MGnsC3Mx1hwxL4bLC7VG/i+ouMiWNCOXLsiPG+uWXIkRyuepNsNrL4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WVLJiULqCkuRsfE6wOkpHWA/zJB7qu7mD7QDtDKEs8A=;
 b=uOhUF5SliUBvptTAhrNDqGNJXcebDLiblmwF8nbjbnVwPm8Bsa11i68lpbUK/Biw4hHP52j3yxAvc6MLVfPvgn5xpxPkVrCykH5pAAy1WUeyAnfIhNijnVbJMnMJK8WdP+AImWlo36OzpcJwVsLCkkaN7tliJBlURRXVLeH9O43a1dp3RcupPpl/QWtwbv6qMo6mYIgSPExZ3rq5x0aNMwfMeBZzwCKzY47uybqdQ4Ud9ExtU33O6X5nSiJ0PBbbb3WTPZZROPVh3CuwSNfV/AxNJx6WiJRMZzdNN6eE7cZhGp9E3ZEhuSko+u2vy5yaRotZ3hxkkmPcm5FMoqFxxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by ZR6PR04MB349300.eurprd04.prod.outlook.com (2603:10a6:910:da::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 08:20:07 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 08:20:07 +0000
From: wei.fang@oss.nxp.com
To: xiaoning.wang@nxp.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	richardcochran@gmail.com
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 net-next 6/8] net: dsa: netc: enable ingress port filtering lookup by default
Date: Mon, 31 Aug 2026 16:23:33 +0800
Message-Id: <20260831082335.1184605-7-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260831082335.1184605-1-wei.fang@oss.nxp.com>
References: <20260831082335.1184605-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0041.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d6::17) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|ZR6PR04MB349300:EE_
X-MS-Office365-Filtering-Correlation-Id: 33934f7a-29ca-4d6a-e2b7-08df0738aada
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|19092799006|23010399003|3023799007|10067099003|11063799006|56012099006|921020|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	6r1ViEjpjXdlrDG+hidBNWWYzfoTI7jFdB0ZDZh5C1mgkExTq/CCuS/tQ8kD33RZFbJaQDYbdnOnrvg7VHYF05ue2UUmYiZ/PSbd6KQRdvxgj8u3gAs1mDWv26Ly6eiiXceZ3eInq4XGHA8hHlU+wr1ZOxNLd8cSFax9eLHCePxD3allFETQi1VOMQdhJBL5gGwMF42dEPeJyuic4d77b+TMC17lRJPMcwEfGU6wihWHU9lLJlJFzT4uwn/vSLzR+bpXhXFaWhcZRZgJn5OEJ2O5yCMUdBrH0LlZAFFS4FLeUVPdI3U0EvrFXS1Jn9YcM4P41uOdDWCHki0i/zWgKAeCLpy7Xa9itrQNEyayEh6IuHCBPD++7fUeZ+k0ojFJ1gdzcR0NhJlfcUe8k1E49Dvo++2JiWGubjpP/rmeoucAMUkprdpRV7iUX1sFxMEuGbnUZq9LQaZqaJF9YPRd3DVA60GVO2BqtMqtw4DRcLF4o2IDF92Exgsg6KZ6k2sljt8T/u2Y+Pbf13gVCzVOY6zbQ1ZFgTwXH5MF5huDAIpg7O6DBoAxyILMQ5eKCxBYq3nShyHNam9ok95Mq0/1gFvRQqsXOY4n0v73yocofARurMTmgwI8jXxjE/8XiYfojzFT0tlR9MKhHkKhoBf7dAYDWOoyCbdMdpoEg3hlGpjIZiEoXeEYUghlMOaEM+KD4qCUirZ+amWiVBYSqdKVmQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(19092799006)(23010399003)(3023799007)(10067099003)(11063799006)(56012099006)(921020)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wcBIq4rGLrSgS6cZn79FZti/mEKZWqDOYQ/2V/pQqeHpGIcEXaJnIpsdDD6s?=
 =?us-ascii?Q?H5m+cqpSWIpIcbG6vbQUOdiwP1lkfz7NVqLcesmsavlxUodDfu74Qua7E3pu?=
 =?us-ascii?Q?HXMbUZJ0blE6x2j2mGTSCmwDuENXEyne6DG/R8S2hmVgx4K0l6QuOZiXoPfc?=
 =?us-ascii?Q?KD3MxzQD3kMe+TH80OCmHWGNvjkFoarNnpAtSzHkswjJ1hQ4qYYOBiuVa87b?=
 =?us-ascii?Q?zlM/Tjrbx16maHRrjwdfVajBGgPXU8VT30MZUk6jG06bn28tQkRCigoIpb4U?=
 =?us-ascii?Q?Rs0VgSNK5GBp23dbIbMZxp5Df3uDu9BdHnqFpMeUSssq+7/gLxFvnZvI8UBf?=
 =?us-ascii?Q?q2IHarq+Dij58yMU3LS2y+XBtHibQq85csr7hBDLcrkgDxaEwmtTQ6itUe95?=
 =?us-ascii?Q?y1SHedNg54P+zMwhJVqpzOAL0MD1mzm4ejJQ8AHSAd6jgrk9U0vFbENQXAHp?=
 =?us-ascii?Q?99Ob5nZb9oTp8WrkAwpI8FXLqD1gxLLgLRCw/gaief0kLNKcvXVaKHQVUcXl?=
 =?us-ascii?Q?oq6qPDPO5Rd8/VvS2err1WJRflpjOI6kILzy6kmoOAz0RCwd+i8g7yYoCoOn?=
 =?us-ascii?Q?GHWIpXMCuVD8WL7890O2phNPLUE0NI7raJpivbnYpjMkFQ5F3kVaw7Pioxoi?=
 =?us-ascii?Q?GRAe+2aOo9ob6AIKeAGE8zo9tlqNTkC8Ks6EaGfRNl1BIm2lpMGHYmPRq8Y8?=
 =?us-ascii?Q?U3r5D+bCTEoWglfar4F20jiZpjLI0MHSu70O//ot6bkQfkn0MBk2gGRb/+BN?=
 =?us-ascii?Q?2p2Ln94ZKxSxTadfM2M0C1fyXctWwKm7CJrkbB4ODFhHWI8tLDifv5A+aJ79?=
 =?us-ascii?Q?LA4T0nLxExA3eEIikA0hehgQMGZB7L5/NvWSLMiSeEyhTUHXLv0plzQjFWa2?=
 =?us-ascii?Q?KbBc7FKGlU6mMj1706lsQQT3bY8mFa99KGxNIOUduAaPUHttlhsEWoOp+19a?=
 =?us-ascii?Q?XVneF04hxLv1qLedIx0RwtGtfaeNsb0ROCH+BqyMTHT54WQnipDmWFnEzLMd?=
 =?us-ascii?Q?zgR1XxD/kt1jIqtcJmMxi9klV5y+Ot44Hl/dX8tBhYELIReb1gmP1Bxc/ADO?=
 =?us-ascii?Q?GuFxBJP7KPJXEoh+MqoCzPhVoGqpf6Jxb4/STQ2pg6z16xJJQq+hD63VS/u9?=
 =?us-ascii?Q?CB77D4GhVBwWNNwgklNoWnm6teqTcU6zGSWh02wAwb6xcH4ZqZ5gUQircfnW?=
 =?us-ascii?Q?S22vj+Xgdyg0iZdEI7QdtxBtNdqtaHRMzsisufgPlwL9eO6jNA/SdtXp2ek4?=
 =?us-ascii?Q?1myYNKY5H+qh4tPO+HAh7OOj5FuxaDpfQqG4WX3D2SqlnN1Jc9jpcjmjw+XK?=
 =?us-ascii?Q?3KzXpEe/11KvKMf7AElWUo0A21sK4nIrv2VIzzTFvWD4UqH2GqVmGHZgITaP?=
 =?us-ascii?Q?/zigJFNNxbTU4ouyFJlEsn46Gcgr6/dV7qeGRsUxX1WbrzgqnI+oKhUPjKGK?=
 =?us-ascii?Q?LrxMiYSs0zzeQCmDTP8cmB9tuuaIy3ZOImbFIQbYM2oRaRavr55H0p+bh6F6?=
 =?us-ascii?Q?kWNJwmC736VNkdHDPR7wHcBTtOi+zbwzHl+rOOmVI0tQxHw9GTV9aWeZ58pT?=
 =?us-ascii?Q?w5KKyjjS4egbLqdb0UrxYVDYAPgnJClWaXeVYG8rTxDalGnCXrDx+I4s3YZ0?=
 =?us-ascii?Q?W14UgkvjbVDKc3ZNfG1RNZiZvOLYf+Cxc+EffqJsr6GnwOcN/TYi6xflOLYN?=
 =?us-ascii?Q?oj8YH9LXr/gYCaVdgxtibg2IgacBgCF0IOBuZmx0OfLPXsB0bPHe9ivgHNWH?=
 =?us-ascii?Q?3XQ+dL1gUPHrJTrjuqmZFOFp/TrIZU1Epz4WdQa/d4zVHGxhFlye?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33934f7a-29ca-4d6a-e2b7-08df0738aada
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 08:20:07.7712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PyVNywJwFKKSlzVNTKe9LkzCchy0RdEFwVMw8xJSPeT8pAARwNsUR0jPTtqKJWk2KA+9F/v9dBxzSwSW41DagtjTqnjw9ha0anlnXlW6nu71hBmCjvwGBypr9CRElQtj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR6PR04MB349300

From: Wei Fang <wei.fang@nxp.com>

The ingress port filtering lookup function involves performing a lookup
against the ingress port filter table (IPFT). If the frame matches an
entry, subsequent frame processing functions will perform corresponding
operations based on the parameters specified in that entry. If no entry
matches the frame, the frame is allowed in, and passed to the next frame
processing function.

In the future, the IPFT will be used to filter PTP frames and support tc
flower. Tracking in software whether any IPFT entry exists for a port in
order to decide whether to enable the ingress port filtering lookup would
increase code complexity unnecessarily. Since enabling the lookup when
the IPFT is empty has no effect on RX frames, enable the ingress port
filtering lookup unconditionally during driver initialization to simplify
code logic.

The only concern is that when deleting an IPFT entry fails, the hardware
will continue filtering RX frames based on that entry. However, we have
no choice. We cannot disable ingress port filter lookup because this
would deactivate other IPFT entries, which is obviously not what we want.
Moreover, deletion failures are almost impossible under normal
circumstances, and we don't need to be bothered by this minor issue.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/dsa/netc/netc_main.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
index 2171c83f3640..ae3dc487f5f8 100644
--- a/drivers/net/dsa/netc/netc_main.c
+++ b/drivers/net/dsa/netc/netc_main.c
@@ -555,6 +555,12 @@ static void netc_port_fixed_config(struct netc_port *np)
 	netc_port_rmw(np, NETC_PCR, PCR_L2DOSE | PCR_L3DOSE,
 		      PCR_L2DOSE | PCR_L3DOSE);
 
+	/* Enable ingress port filter table lookup, if no match is found,
+	 * the frame is allowed and passed to the next frame processing
+	 * function.
+	 */
+	netc_port_wr(np, NETC_PIPFCR, PIPFCR_EN);
+
 	/* Set the quanta value of TX PAUSE frame */
 	netc_mac_port_wr(np, NETC_PM_PAUSE_QUANTA(0), NETC_PAUSE_QUANTA);
 
@@ -1761,8 +1767,6 @@ static int netc_port_add_host_flood_rule(struct netc_port *np,
 	np->uc = uc;
 	np->mc = mc;
 	np->ipft_hf_eid = host_flood->entry_id;
-	/* Enable ingress port filter table lookup */
-	netc_port_wr(np, NETC_PIPFCR, PIPFCR_EN);
 
 free_host_flood:
 	kfree(host_flood);
@@ -1786,7 +1790,6 @@ static int netc_port_remove_host_flood(struct netc_port *np)
 	np->ipft_hf_eid = NTMP_NULL_ENTRY_ID;
 	np->uc = false;
 	np->mc = false;
-	netc_port_wr(np, NETC_PIPFCR, 0);
 
 	return 0;
 }
-- 
2.34.1

