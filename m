Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013005.outbound.protection.outlook.com [40.107.159.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017773B0AF5;
	Mon, 31 Aug 2026 03:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788146620; cv=fail; b=e9ka/oE0/rCGg4yYQeM6jGp+dO+xqgSGLwJJAhoStRhBbKJZuuMEA/UZ/qAer9xUjeD3D3/mdwxgC19iO1c6L4IXUrgPa77pWo4eblCEv8sHevi74u41+0HCvpk+stcK1eoxBKYJHe+mhsfqVBWbUDYpr4dwn0s+yEMJD6IGUEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788146620; c=relaxed/simple;
	bh=+q6ldnECRd7jpAb7/wblDZ3vyDiDPyJlkbEB4RZlvC8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P98JtIBJi2WHYNSMgvR0Ww6+62Y/5CDH7htC9kEt+GYO/alo2CkBld4JFu7lZpYi+bcyAr6ra6Gzj9n+EGk2sPpQct/6FEerfZO/KEM1Wa/nLupdWkm2JqpFK4rAngCGlgfp0VU5MWMG9NbA3CH5RI5BW+VgFSZGRoq0oGb5H8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=fcT91s98; arc=fail smtp.client-ip=40.107.159.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="fcT91s98"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kVmyqzVRx6ZB1odD0bKupeFcRLap5dEAfRMb+fLtVJUE/cdCBXxRxL3VvlhmJZ7VCZ774HZsgklQEq+zGL9r9A6Lqn0VJHmhSmb24RwOPUvhHm4SME6sMrPX9+1W7lupQkdvj9zDA9h0iaryfL1hLs/xh+VRm5vuJ2qh+84Yr4NR5dQVHT32072qCKG4IfFyMcBRcghl6rjT/NchNPiu0t45rLRVo5bGw8CX0WXPfvTmN/vr1w0y/Cg0jWueXucKBkpvKpjEqwmEp583UbDtUfSzQTOJsaWwSsItQlNTy9avg2rZnrZNErJBctXlTIr4OB23U4lmSuX+nLEU6Mz0nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yc1L78ve5rRJyJcVN53jhR2OZizGjMk4iQTCkxS5320=;
 b=YWRXLEVy77jXJiARaymCqFUcFmc5xWVrFAN51HUqByTayIMjzMT8fB8UDgwpHUMbUlBNg1zZDbxHdv+0KuBvLLPyUumAXeM7BUHTm1BFYOwEZff4AAbjbT7eKc+SfP1OWhecL6Us704daloSNQAsCad/AgsBq0tQNNzrBfY1Fwd42oGBTXIcXPceNEHAbZngqk08vKLUvfKvE9fvqvstI9ok3A9r26S+GE2dNL6+xzahPEG+xf78ajhdJ0y2MeuJavPOprgx8DzlvhEbkShg8CO4jObgdTlMTtYo7BqtSCnVN5oJpsMy5ptcGrGfSnEQuiQylNXNZ9AzNfZsVrqwRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yc1L78ve5rRJyJcVN53jhR2OZizGjMk4iQTCkxS5320=;
 b=fcT91s98yoQjq4fZd45KLr0bebvrlGTPjCjDiXwsE5ZsKhjIzshN8EYx+zzOIp+uXSM0C+b1evcXCZwFLHnXquJ/CBoP1NNXFNJOOmpXTDLvSMopArZvKcyO+UF8vTpTcVmuv/sO1d5F09Ibi8zWqdLsJJoDCwcxKPHtF91TPUtD3oQSYAnWju5MMz28EO8u4+j8yEQmRQqxZx4qXeJ68V3938CQbymcdnfgl3eewG48HGftXUgCsWMI1mW6Xrl9H5o5UGRd88jSxeLvysgM9RbfTElRCH+zM2Kh2wTR5me5Tj1uJS3urUQEZlJDMrhE8PfR7Jb2apLGAWyCLPst8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by PAXPR04MB8474.eurprd04.prod.outlook.com (2603:10a6:102:1dd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 03:23:35 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 03:23:35 +0000
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
Subject: [PATCH v3 net-next 13/15] net: enetc: implement ndo_set_rx_mode_async for ENETC v4 VF
Date: Mon, 31 Aug 2026 10:54:39 +0800
Message-Id: <20260831025441.635045-14-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260831025441.635045-1-wei.fang@oss.nxp.com>
References: <20260831025441.635045-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:195::7) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|PAXPR04MB8474:EE_
X-MS-Office365-Filtering-Correlation-Id: f3c9c65e-d53a-4484-746c-08df070f3e09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|1800799024|366016|23010399003|7416014|56012099006|10067099003|5023799004|11063799006|18002099003|22082099003|921020|6133799003;
X-Microsoft-Antispam-Message-Info:
	m9wsHL+j2LOPpf4uhLX+5GM+FaEphaGKkLVXwn7RRhhFnyejcm3Z8DzR5ZY1ORX3tjwsUbXZ49Yyc0LUULpNNOtO7pTw+FptkHSA3ffHXr4jYs6KhNj3IkuKFoNP3ym8BS8nhw3Z3WY1n8aoBDQ0cGFOQm7c+eqzAcp5MdNB2KjlerKsfAw2mvqvtgX7wXUG9OH74Lva3QJVkyc1BcWeJBAY4mWoe6i+a/I7hRxPe9j1uXAIsQU9UJbdDevD228qg4OdfWHHzIcClD/I1mpT2J5nNVyQZEj5cm40ixr/wHyBo2QWfWzDtQKVHh9vQg4AjONwyJq73ZAZmoDtooyAIH9oH5xNsRJbhuG/S2r5ZuJv8AiH5Ll+zF1J1b0/YPb7qKmvmn191dNPTAv9S93Xjm08MrpOny3yo8bjuv90CXa/W0z6D02Ej4OQA+Re6rglhVj8YFd0dRVeW76dq74iXW5QJRwISoaEBloLJD07TwWM3RkIsMBoaYLG3ZRitMyMC86MZHlHrSHUZ5OTZ49TxDTGj025idifjWsWhu1dn0OOnZ6mATVth3GVkbkaAgf/ZLuczrFQ+kVcIWjS3EZ/m0aNYkJj3XN0gnG7OqoAmzWdwwe71bdlhQ2OLQjifzIgg1AtbEU0cycL9sPqZZmM5L61BRNPw0iu2m9sCO9aEAAj3EiEa505gI32kuVKCfhtwaM+sM2wZEURB9Kz0JpOtQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(1800799024)(366016)(23010399003)(7416014)(56012099006)(10067099003)(5023799004)(11063799006)(18002099003)(22082099003)(921020)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CxzRzi3Z+ibHbusTqA+uMqbQ/pDuf/AYfJ4Tkpmq8YdFnC/Qc4FRc8zKSyQQ?=
 =?us-ascii?Q?YytDH4jTLvbcQGvfQXteKvoUFarh3Q0IOpEPOOot+X03QcPJRWuLaJnBpQYM?=
 =?us-ascii?Q?CSO50jkmeGAY8NUHoXxr8COAfWnXwlfA59EQnM7sGXBBW2arOzuuL6NHUjyG?=
 =?us-ascii?Q?1DcY5NzF2cbJ/2zGHVcY6yLOS3srHu5M/rGWAcoFFvqlVnGO7YA1ZN2Vwcbu?=
 =?us-ascii?Q?MFFlwVh8hkGgY+8CMxx0O9b1213+/aKhmWNhPc0VlEbGWT7dt6uTxaDPnN8f?=
 =?us-ascii?Q?LqGDguMdiojRt7TPV+Wx6re78TLyxfPiNwZPeWG8i7JqPgX2GVnyIFzGy9Ga?=
 =?us-ascii?Q?cgJlpQubVg2SdLMeNmrRBs0L2FXzQdfuvQoA8iDAa00YfvA5VOr0NZN1UCtu?=
 =?us-ascii?Q?73c/l0QOedg6Xzo19L3iuhSYoDB8AGMwP+F+gfIhVunbkEG7mDQDcNGBgCUg?=
 =?us-ascii?Q?HFiqfS80XwN8rf/Ga23UgRexBDUG3slB0DjX4sjZcO0FUzHpXpXBU2+jcm1/?=
 =?us-ascii?Q?Y4BkNM0mH+JmMfsochp8/cykm6o6Uqxn6wHEGnRWVoCL1hc02ao4we8MpIbh?=
 =?us-ascii?Q?kHZBnLAZsRa1Sk98KDYrhjhgPsaIkUDVTrU34eEJKEmlg014gzSHYbP+Kt25?=
 =?us-ascii?Q?oCEMVVz2ma8vQS5njqTmI2z3zsGFSr0idczldCf3Ep9sMhQ4VjK596jYzMhs?=
 =?us-ascii?Q?TvePIkk4xOC0ks2VK3THQqzt+kNOetnzuE1LSNJNb9Tgmaoha5GfKyljje+9?=
 =?us-ascii?Q?VMQu7aZs++he7kpBYGGiKM3f7hjSK0YPjeF3BTaPLxo2m0xRII2lvaQ+wWTS?=
 =?us-ascii?Q?Hht2E6dDBhKO3l6sbVvE+KrwdZcrConTqGVw00HzGXmkmuqmUWKY79Ytnh/j?=
 =?us-ascii?Q?JWNLuTEFrQJkwmepHCYGHUWp1a5LyCYyZvf/Carv+0IWJH+kW82LFV3vdVRv?=
 =?us-ascii?Q?xZ6ZCPVxAH8dEK4KZ3ojk1o0aNhIt2+c68rn0f+moRS7pl3fKlE53ktNNm7O?=
 =?us-ascii?Q?p696kwemunG0fGqcLmAKQXeVMa8tAKzXRlMLax8lG3xW+68xqdApYLoHBy6e?=
 =?us-ascii?Q?toysF6VMWx+xJPIjS+h3PqMjHLoxDXd7rSYC1lS4Y1Do2cj+zhq75kMo0KYL?=
 =?us-ascii?Q?vxc8RfGYy9ltwfZ66obdfHX2fSSvfbBKB4npZPLQjh/gcS8P182gR4iOfw6r?=
 =?us-ascii?Q?P2QMUmGe5J9Zqm1pjFjri8MDJhkz/BLP97t7aNg32mBqBNtwnxQDZWwWd8XH?=
 =?us-ascii?Q?2SECpwbHR0KoHGw10AWgOzJjakeGuG4psa1CVsttHNnGXmcNGcp8gjjfauKl?=
 =?us-ascii?Q?sZ+p3JpUYp7dx6kE2UDUCFjbrEF9mlGix3PO1X2JvEjq/B898i2s2zBsWLah?=
 =?us-ascii?Q?/GQOhyaWdJP3r6ItF9FZUCp+lwlzze+4/uXrqdSRMTs1WylHZy9PiZg3Cc/9?=
 =?us-ascii?Q?ZscSssL4VXvvbK2sx3Q5tX60eVPoQ79BniCsw+6jslaVGKnRYDEt8K1PEOVY?=
 =?us-ascii?Q?XVprsYaqJn3p64zLHNtSES4bW/jj7r4/umnPdyJKNGtaN61o6pBqTTlJuhUW?=
 =?us-ascii?Q?TLBe9mBDWqErZ3XGdBvsaC7QoINLE3boCMs5nd+1epwEuxjzFhSaJJuVGq6e?=
 =?us-ascii?Q?2rcCYQ9yRpMJLQSN9uX/xQnwemT6c1OFIQD9Ipti+WARfCEterfX3wyZ28Mg?=
 =?us-ascii?Q?A27GBcUtlv4KxOpR/vf4ztNhKmYeEq4Qaq/YVhIg/YmJ6c+TaOos7Pstf1dm?=
 =?us-ascii?Q?Pdgt4QE6e6pu1CUesfEW3PNjcbnGpu0C3O3HKnSHeNyyQDrpqvUq?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3c9c65e-d53a-4484-746c-08df070f3e09
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 03:23:35.7744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uzizKY+UfdyjZ/Fu9IGarWYtUpm/aQbpNUrbsOGGsYYdWyT5TwcoNQJw+VZkcBxg5wdWTC19GO6gkdsmYCnohCE7rXJiDHv6V4VAFAr+PjtArJcCPiI6eDDNpO34Y3zs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8474

From: Wei Fang <wei.fang@nxp.com>

The ENETC VF communicates MAC filter changes to the PF driver via a VSI
mailbox interface. The message send path in enetc_msg_vsi_send() polls
for completion with a timeout up to 200ms, which requires a sleepable
context.

The legacy ndo_set_rx_mode callback is invoked with netif_addr_lock_bh
held and BH disabled, making it incompatible with the VSI messaging path.
Implement ndo_set_rx_mode_async instead, which runs from a workqueue with
rtnl_lock held in a fully sleepable context, and receives pre-snapshotted
unicast and multicast address lists from the networking core.

Add enetc_vf_set_mac_promisc() to send a MAC promiscuous mode message to
the PF. The message specifies the filter type (unicast, multicast, or
both) and whether to enable promiscuous mode and clear existing MAC hash
filter.

Add enetc_vf_set_mac_hash_filter() to send a 64-bit Bloom filter hash
table to the PF. Each filter type (UC or MC) contributes two u32 entries
representing the low and high halves of its 64-bit hash bitmap. The
function accepts pre-snapshotted address lists from the framework and
iterates them with netdev_hw_addr_list_for_each(). When IFF_PROMISC is
active, hash filter programming is skipped since promiscuous mode already
accepts all frames.

The ndo_set_rx_mode_async callback selects the appropriate filter
configuration based on the current netdev flags:

 - IFF_PROMISC: enable full promiscuous mode for both unicast and
   multicast
 - IFF_ALLMULTI: enable multicast promiscuous mode, disable unicast
   promiscuous mode, and apply a unicast hash filter
 - otherwise: disable all promiscuous modes and apply both
              unicast and multicast hash filters

Set IFF_UNICAST_FLT in priv_flags for ENETC v4 VFs so the network stack
does not fall back to full promiscuous mode unnecessarily when unicast
address filtering is supported by the hardware.

This feature applies to ENETC v4 hardware only. ENETC v1 (LS1028A) does
not support VF-PF MAC filter messaging and the callback returns early
for such devices.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc_vf.c   | 140 ++++++++++++++++++
 1 file changed, 140 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_vf.c b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
index 322705202d49..4e717afba7f7 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_vf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
@@ -213,6 +213,142 @@ static int enetc_vf_setup_tc(struct net_device *ndev, enum tc_setup_type type,
 	}
 }
 
+static int enetc_vf_set_mac_promisc(struct enetc_si *si, int type, bool en)
+{
+	struct enetc_msg_mac_promisc_mode *msg;
+	struct device *dev = &si->pdev->dev;
+	struct enetc_msg_swbd msg_swbd;
+
+	if (!(type & ENETC_MAC_FILTER_TYPE_ALL))
+		return -EINVAL;
+
+	msg_swbd.size = ALIGN(sizeof(*msg), ENETC_MSG_ALIGN);
+	msg_swbd.vaddr = dma_alloc_coherent(dev, msg_swbd.size,
+					    &msg_swbd.dma, GFP_KERNEL);
+	if (!msg_swbd.vaddr)
+		return -ENOMEM;
+
+	msg = (struct enetc_msg_mac_promisc_mode *)msg_swbd.vaddr;
+	msg->config = FIELD_PREP(ENETC_MSG_MAC_TYPE,
+				 type & ENETC_MAC_FILTER_TYPE_ALL);
+	msg->config |= FIELD_PREP(ENETC_MSG_MAC_PROMISC_MODE, en);
+	msg->config |= FIELD_PREP(ENETC_MSG_MAC_FLUSH_MACS, en);
+	enetc_msg_fill_common_hdr(&msg_swbd, ENETC_MSG_CLASS_ID_MAC_FILTER,
+				  ENETC_MSG_SET_MAC_PROMISC_MODE, 0, 0);
+
+	return enetc_msg_vsi_send(si, &msg_swbd);
+}
+
+static int enetc_vf_set_mac_hash_filter(struct enetc_si *si,
+					struct netdev_hw_addr_list *uc,
+					struct netdev_hw_addr_list *mc)
+{
+	struct enetc_msg_mac_hash_filter *msg;
+	struct enetc_mac_filter *mac_filter;
+	struct device *dev = &si->pdev->dev;
+	struct net_device *ndev = si->ndev;
+	struct enetc_msg_swbd msg_swbd;
+	struct netdev_hw_addr *ha;
+	u32 msg_size, tbl_cnt;
+	int mac_filter_type;
+	int i = 0;
+
+	if (ndev->flags & IFF_PROMISC)
+		return 0;
+
+	if (ndev->flags & IFF_ALLMULTI) {
+		tbl_cnt = 2;
+		mac_filter_type = ENETC_MAC_FILTER_TYPE_UC;
+	} else {
+		tbl_cnt = 4;
+		mac_filter_type = ENETC_MAC_FILTER_TYPE_ALL;
+	}
+
+	msg_size = struct_size(msg, hash_tbl, tbl_cnt);
+	msg_swbd.size = ALIGN(msg_size, ENETC_MSG_ALIGN);
+	msg_swbd.vaddr = dma_alloc_coherent(dev, msg_swbd.size,
+					    &msg_swbd.dma, GFP_KERNEL);
+	if (!msg_swbd.vaddr)
+		return -ENOMEM;
+
+	msg = (struct enetc_msg_mac_hash_filter *)msg_swbd.vaddr;
+	msg->sz_type = FIELD_PREP(ENETC_MSG_MAC_TYPE, mac_filter_type);
+	msg->sz_type |= FIELD_PREP(ENETC_MSG_MAC_HASH_SIZE,
+				   ENETC_MAC_HASH_TABLE_SIZE_64);
+
+	if (mac_filter_type & ENETC_MAC_FILTER_TYPE_UC) {
+		mac_filter = &si->mac_filter[UC];
+		enetc_reset_mac_addr_filter(mac_filter);
+		netdev_hw_addr_list_for_each(ha, uc)
+			enetc_add_mac_addr_ht_filter(mac_filter, ha->addr);
+
+		bitmap_to_arr32(&msg->hash_tbl[i], mac_filter->mac_hash_table,
+				ENETC_MADDR_HASH_TBL_SZ);
+		i += 2;
+	}
+
+	if (mac_filter_type & ENETC_MAC_FILTER_TYPE_MC) {
+		mac_filter = &si->mac_filter[MC];
+		enetc_reset_mac_addr_filter(mac_filter);
+		netdev_hw_addr_list_for_each(ha, mc)
+			enetc_add_mac_addr_ht_filter(mac_filter, ha->addr);
+
+		bitmap_to_arr32(&msg->hash_tbl[i], mac_filter->mac_hash_table,
+				ENETC_MADDR_HASH_TBL_SZ);
+	}
+
+	enetc_msg_fill_common_hdr(&msg_swbd, ENETC_MSG_CLASS_ID_MAC_FILTER,
+				  ENETC_MSG_SET_MAC_HASH_TABLE, 0, 0);
+
+	return enetc_msg_vsi_send(si, &msg_swbd);
+}
+
+static int enetc_vf_set_rx_mode(struct net_device *ndev,
+				struct netdev_hw_addr_list *uc,
+				struct netdev_hw_addr_list *mc)
+{
+	struct enetc_ndev_priv *priv = netdev_priv(ndev);
+	struct enetc_si *si = priv->si;
+	int err;
+
+	/* For ENETC v1, we cannot return -EOPNOTSUPP or any other error,
+	 * otherwise ndev->rx_mode_retry_timer will try to set rx_mode
+	 * multiple times, which is pointless.
+	 */
+	if (is_enetc_rev1(si))
+		return 0;
+
+	if (ndev->flags & IFF_PROMISC) {
+		err = enetc_vf_set_mac_promisc(si, ENETC_MAC_FILTER_TYPE_ALL,
+					       true);
+	} else if (ndev->flags & IFF_ALLMULTI) {
+		err = enetc_vf_set_mac_promisc(si, ENETC_MAC_FILTER_TYPE_UC,
+					       false);
+		if (err)
+			goto out;
+
+		err = enetc_vf_set_mac_promisc(si, ENETC_MAC_FILTER_TYPE_MC,
+					       true);
+	} else {
+		err = enetc_vf_set_mac_promisc(si, ENETC_MAC_FILTER_TYPE_ALL,
+					       false);
+	}
+
+	if (err)
+		goto out;
+
+	err = enetc_vf_set_mac_hash_filter(si, uc, mc);
+
+out:
+	/* If the error code is -EOPNOTSUPP or -EACCES or -EPERM, return 0
+	 * directly to avoid meaningless retries.
+	 */
+	if (err == -EOPNOTSUPP || err == -EACCES || err == -EPERM)
+		return 0;
+
+	return err;
+}
+
 /* Probing/ Init */
 static const struct net_device_ops enetc_ndev_ops = {
 	.ndo_open		= enetc_open,
@@ -225,6 +361,7 @@ static const struct net_device_ops enetc_ndev_ops = {
 	.ndo_setup_tc		= enetc_vf_setup_tc,
 	.ndo_hwtstamp_get	= enetc_hwtstamp_get,
 	.ndo_hwtstamp_set	= enetc_hwtstamp_set,
+	.ndo_set_rx_mode_async	= enetc_vf_set_rx_mode,
 };
 
 static void enetc_vf_get_revision(struct enetc_si *si)
@@ -280,6 +417,9 @@ static void enetc_vf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 	ndev->vlan_features = NETIF_F_SG | NETIF_F_HW_CSUM |
 			      NETIF_F_TSO | NETIF_F_TSO6;
 
+	if (!is_enetc_rev1(si))
+		ndev->priv_flags |= IFF_UNICAST_FLT;
+
 	if (si->num_rss) {
 		ndev->hw_features |= NETIF_F_RXHASH;
 		ndev->features |= NETIF_F_RXHASH;
-- 
2.34.1

