Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794439921;
	b=FBl4KAjHg9JJayxxGBt6USgVRN7GY/5vpH+HB3GM8qrs0BUk5AwHCeskYpExt2Gq1Vn5
	 Smke7nPk7R/4MSgrcxK0s9ImQMzJ/It+L50xpLIcR7YsazR29u+fNNSmeeJeapAp7hASj
	 Zr/MxBopb6dFSdGUpF478mI4PCMQ/SkPTL60v5aTweeAKKzRbEwNmApO0GpcB9r8cg9I7
	 Mo4hbnj8ercWx+IZIFMchDZ8AXYw2jGlZMCuE6rl5sFEXIOHbSaVW5WtG+D7iBt4CPPWY
	 XeAhCKkbk79WMOnXA0v84KmdiZKAoNlP33FUDDcYD3pGCs6LewANWLK1eWTgtp6cM8w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794439921;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=KqteKu7Mwf53a4LWTTixX4J6YaQXuj3XTLgtofzo6Sg=;
	b=YWmX0ByWAo6EM8J9YsqzElKt6cRRawyLGdnxwDcVTTMMIs81UwSJ4n1+RrjefJ8j27ni
	 tdJRtcrWR3grX0qFUYufLWehDWqiMmTt6qul5erwUaJ1j+a4HE8aRkXwtDpu092VOMrlD
	 r4XCR8GTqSMVHtgZrVN75S+r4yrtvVOSrd4d+AjiOkOsfCIbpZrn8bdT3XmJAPxAczgUA
	 j8IyRgQHBnErM6mVstzS70FHAbD8Vn3FvLVEu0PmU/paFOHTq3sKbZKJOtM+yGzrf2or7
	 b3hKD6/8Til9qEd1xMIPGxnyaR+kT0tvDe0M/QjTyjpu0aVcsokaFf2fOG+Qtp5HdhQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nxp.com;
	spf=pass smtp.mailfrom=nxp.com;
	dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=danghL0m;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.28
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010028.outbound.protection.outlook.com [52.101.84.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D84606A33E;
	Wed, 11 Nov 2026 23:32:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2D84606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=danghL0m
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MvwKUuVKFnVbOMHZQugMZA2C2p+Ntg0dDhL6QSVEdciG832WBpbSPsEzjiEMqDl9ztFts4uvghvSF4ZFfx6wf8Nh2K9rsH2moeETRb0wWR99GxR8YgwQk0nM6J6JdkgYaqZb8AVMmhmACvZxMP9eJRdikl+B6Tm/7zVTpnW5R1jYVRBQi1Y0XdV1QY8P4Knb+Qk9clR+HeB7UprOxFdaRrWW2WyLNEmdOLNQPF745Q21dR6+woFmtdw8sHhG8FP8QLYT/6MbDIAkE3iEDEw2f4iXDGb1Wgqp+898fvL8O57ZAj7HgM9PqxnhjHGysqjmDuf6r2recFnOA0JzAKaU6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KqteKu7Mwf53a4LWTTixX4J6YaQXuj3XTLgtofzo6Sg=;
 b=oy62ckWt0PFNmE5eM+BlVVVZugU6z2VqQ7K/onjrcLWNN7ZnRASis1nSpZrKs85p4QljiOtw1r4tXa4r9UZto66btu5bUmRYWnEADJoFtR8uAH1GF5CX5YMvRtzW0zrwTvosqC1FQjSxpq4OdGTk6d6IpZntZLCMTLgChfzbRNhA2K8pl9zsnnAojqB2GoQ5DBZ9mA/v8KngPjYzuAcSbNlquP4SKCjy12sl8bBs1aamuYGC+9WO85fRBFqcjaV56ZM4xMo5kxLf8CPSuAD1XJgN0HYtwXDu2QHt+VEKMax6DgUYp6fjzucaO1CpHxbpBxYumsJQSQ9cra9rYO/bZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KqteKu7Mwf53a4LWTTixX4J6YaQXuj3XTLgtofzo6Sg=;
 b=danghL0mQul0WTD1AX4/yRBE6EH+acLsoKiTdWC54V1RgyFGSljPVVg19EfObIaPKII1ggDTQjEdWVxypdGr0IMpKbzx5erjbjdyHrOhnGDk8AdiRW7rxSVtu7D5/KJyaw9y/zekfSEbbOshxxjb3YodsQ97FRnn6u8EfNMcPZgHscf3q8ap/92n3g7cGk/hZLqZc1ZeQ/015PS4AET/BYKtJGZGxjbVTlF7lxpDVenv2vDQsMRSCmm+jFn/rovhTrxS/iXGRQjWBXD1IPVQTIYJGX4b/BAp1EXsrpqv9JeREWJThSP1Qoxe8A1dzZk8k9GfgHCWxwmRN2nO1Y1t/Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by DU0PR04MB9249.eurprd04.prod.outlook.com (2603:10a6:10:350::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 23:31:58 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 23:31:58 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 2/3] net: enetc: reserve VLAN extension BDs for software TSO
Date: Thu, 12 Nov 2026 01:31:48 +0200
Message-ID: <20261111233149.479596-3-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111233149.479596-1-vladimir.oltean@nxp.com>
References: <20261111233149.479596-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0291.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::17) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|DU0PR04MB9249:EE_
X-MS-Office365-Filtering-Correlation-Id: e5a4f829-272f-473d-a90a-08df404bfae7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|10070799003|366016|1800799024|19092799006|11063799006|10067099003|56012099006|261021123027099003|261021121427099003|261102123227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	rk6+NeYVUINOxqz/cSDQ5WqHDd/ByH0673o2ztyoZYhhI2zzxtjXmadOZEZV1U3ibWcpkMhLktwJ1l1OuKU2sUBBCmOETbT4bVY1XvxGDm2gwZoOD6KZQrvWpI+UM6SMUFeU+EQx2FFEZhzbQakKE6h9FlVaR87bsm9GmhNkOCEbtoHjc6/WiGlzUp9ternw33GlSSCaEX6vaLIeN+gPbLEFCnhvjsrP2cqJCBDlvgGm1k2sQ4AFdVSmua0ijCXuemk9q3GDMx4XM4mrq9nbtQ2v5hV9VIO2Ef4fqufu0Bfr0+xCc74FAqFSKiB2Kf4qCD4wn2jYoTanxKYn5TLl9D2boa9Inj1KvEN5MPppIl+nQBTfAQd4KwOQXllGkhRE2M9YPNUPygG8S5/R4lgZSrQsnHADDF3SRRKM19PKD2dPSZ1I4c9JFYJKUsrxT19NDnbjV2gg6WlSqT9bOXZqH89l7HtdIUN79IKyDABo3kt4FoFBFS935IgYL8y8p1E/M0t/blqaCOQ/stqlLObjCqurn68fmMDcil3KeYDu1Euopi/C+wYgC4s3m+K9jqv8wW4Bu5LYbUbLR+Y51xVSKKlz31kCfeBJL4XSfIYQKAvKeTxGsnlrQ4oEg+NZGWnb
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(10070799003)(366016)(1800799024)(19092799006)(11063799006)(10067099003)(56012099006)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ShYKD9u8i5ubOsDmODWsGT4ofS6K5Plug+WYaqiMwHJp7t4IeiQ3Fm4PJn0X?=
 =?us-ascii?Q?n/pKCA2Vd04TzIoC02v6Fb+PkQr6O5sEAHS6RvzyRCe4Al7UFriZSif1THQl?=
 =?us-ascii?Q?h4E1KaXK5HFDATlCgIZMwCBNj2YUnfw4ZRC1RW85nHfn9KQOy8eJpQs2/jc6?=
 =?us-ascii?Q?JNkoAWiQMKizIxTgvWojjyH8ldMbdWQNAuAfXwLw69Ij1YzcUVxzGnJ1FEa+?=
 =?us-ascii?Q?rPziJmgf+gYLrgzX5jOJfUk+MQl9FHl5eI0br8J1ifKMqmsVUtqny8uKhj87?=
 =?us-ascii?Q?IgjlWyKanjA2QmtFd74pUJBJf1cDI5p82kd70usZUOciU7+PrB5oDb6VLdVL?=
 =?us-ascii?Q?oSrtNtW7myCMZuT+L+Uo/+U8DuU9PHOWSlsJ4tz5xgl46tBF+vJ6/aegEOoi?=
 =?us-ascii?Q?WPzmWUyexwrkmVWqFC85dCsXlwKooFRMcYV+XFf2DbEYPhd9Mq/1UdBtdtUz?=
 =?us-ascii?Q?9T/ogQvoOeIjgp5sdZDJLXguCEznQzN7L07xnADalDoFMgFXuv0COI4xSt1b?=
 =?us-ascii?Q?zaf0/nusTTogbZipK0s8MSeZ5IPiMcz30qST6V2yS3xsGVK5dJubyv/rKjiV?=
 =?us-ascii?Q?cmrc/QG6jXHWjqrC0rzK2/+yrEzQWoj6iRKuXXukUChxBzyv04HiULkaep7Z?=
 =?us-ascii?Q?ekxFopU+7BliLq10EK9wPsNNVxkxiyESY1eAQBzVEc/hQuSRVLI6CTYrZMYB?=
 =?us-ascii?Q?U3Cr4W8GVSHmmygRVfXXGD9gKtsHpOIqu6kSvCfTPc8NIYGpfrQS/OQhheWB?=
 =?us-ascii?Q?RN8E2odWdvSQKpfQzN2icFCSiCJ6PIahQ93WvmGR/HvM0465i2Pe/9zHJL8X?=
 =?us-ascii?Q?zqOSFtcU6Mjc8/SibaeV53G1zh2NYXklxDLrQtRklHv+6ig261gIwKqmHp+C?=
 =?us-ascii?Q?Y4c5c9RQwP69JSqRTmUgQpxvoKcdT944jOiRlXLJURgi2UaYnsXlSA/HLCKw?=
 =?us-ascii?Q?eO/VyPT2u/hegc+v1QlrcsPygaaBpqDcg8PoVl9tPKOj5luI8h7PLpNpedfs?=
 =?us-ascii?Q?vaEsUOUGbuvinu6iYMOM1ImImkVmAVugohuXpFq45pd/rbQrYjgWrjbEXO9d?=
 =?us-ascii?Q?hKHplDDUpdhlRx4jNQK0XuFFd3lUd9StkOW4WUcHFeDhk/3IBPiYmMZrBhaP?=
 =?us-ascii?Q?NEBkSWJFJqPgO+Ug3f/dU3u1cWR5I5I/I3pJn+UFEzVUDQwse+gyJ5+8Bjj/?=
 =?us-ascii?Q?mdg8vx6gbFsHaBsynccZnurlI0RExjdRtOpQO2t5ci5laXYPNmJL2sEA3PWF?=
 =?us-ascii?Q?EfIh8CC10mNai7byZZghLRK8nnk7Kczp1vJ84h1+YU639+u8wkByp8vh/P+L?=
 =?us-ascii?Q?SVB8u/7F/XEZ4uvXQab3ahTj3ZpCtVozWV3v+jsT5H60CFEwlCswflqWXLZs?=
 =?us-ascii?Q?X7sYM+Ms9AfW8bWFeRMkl7H3BZfy2cJ+yInqgcy01amFJ9qY12jOLwSno6HN?=
 =?us-ascii?Q?J6fp/OK8dx/jjTAjZlrUGCPozS1DKDB3b+E1ea7K1uzXNVxKrp1ELuV0NSfb?=
 =?us-ascii?Q?eUqRYsMCz3+ymz+YhPNdFuBUpji2iAYSQsy33vqvGeSnRGczjMUCc7fAdVnB?=
 =?us-ascii?Q?tcqX4CnXS6Qpko8rWDUy8YGE7xKVPuuMzsrF0rJhXa+zz8ZlKJck6DRpqLBn?=
 =?us-ascii?Q?op2fd+OIrTuEbixeplMkAQLkjh0U395ZC47dRm0Fov9RWngmM64AnAX7g837?=
 =?us-ascii?Q?fUIY2xbi4+Nom13n5UKVHtoQrV+HbK8d09izFadYGwiBM7a3TdOx+FV4cb8o?=
 =?us-ascii?Q?Xa2ZAegjQ1hKE9SWgS9gTmUSMbL/FFkEexc6GYhXMiz6i4j82+g3A9GHphpX?=
X-MS-Exchange-AntiSpam-MessageData-1: pEHbP9O6lgMjlw==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5a4f829-272f-473d-a90a-08df404bfae7
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 23:31:58.7109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R1GCn6NG/XA91OwMpz4v9m7ggSi+z1Z8qHXxbnJRQ6B1g1o6d/YSIFEmBzPY6PEOgJITBQQxyPqb6b4FV6LIRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9249

enetc_start_xmit() uses tso_count_descs() to check whether the TX ring
has enough free BDs for a software TSO frame. That estimates one header
BD and one data BD per segment, plus one BD per frag. However, when the
skb carries a VLAN tag, enetc_map_tx_tso_hdr() also adds an extension
BD to every segment, which is not accounted for.

With a highly segmented VLAN TSO skb and a nearly full ring, the driver
can then write past next_to_clean and overwrite BDs still owned by the
hardware.

Add enetc_tso_count_descs() which accounts for the extension BD of each
segment when VLAN insertion is needed.

Fixes: fb8629e2cbfc ("net: enetc: add support for software TSO")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
This comes from the previous patch set:
https://lore.kernel.org/netdev/20261021145314.1435049-2-vladimir.oltean@nxp.com/

v5->v1: also patch enetc_features_check()
v4->v5: patch is new
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 1606ac57016f..7f089a84d9a6 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -674,6 +674,17 @@ static void enetc_tso_complete_csum(struct enetc_bdr *tx_ring, struct tso_t *tso
 	}
 }
 
+static int enetc_tso_count_descs(const struct sk_buff *skb)
+{
+	int count = tso_count_descs(skb);
+
+	/* Each segment also needs an extension BD for VLAN insertion */
+	if (skb_vlan_tag_present(skb))
+		count += skb_shinfo(skb)->gso_segs;
+
+	return count;
+}
+
 static int enetc_lso_count_descs(const struct sk_buff *skb)
 {
 	/* 4 BDs: 1 BD for LSO header + 1 BD for extended BD + 1 BD
@@ -1034,7 +1045,7 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
 
 			count = enetc_lso_hw_offload(tx_ring, skb);
 		} else {
-			if (enetc_bd_unused(tx_ring) < tso_count_descs(skb)) {
+			if (enetc_bd_unused(tx_ring) < enetc_tso_count_descs(skb)) {
 				netif_stop_subqueue(ndev, tx_ring->index);
 				return NETDEV_TX_BUSY;
 			}
@@ -1114,7 +1125,7 @@ netdev_features_t enetc_features_check(struct sk_buff *skb,
 	if (!skb_is_gso(skb) || enetc_skb_uses_lso(priv, skb))
 		return features;
 
-	if (tso_count_descs(skb) >= priv->tx_bd_count)
+	if (enetc_tso_count_descs(skb) >= priv->tx_bd_count)
 		features &= ~NETIF_F_GSO_MASK;
 
 	return features;
-- 
2.53.0

