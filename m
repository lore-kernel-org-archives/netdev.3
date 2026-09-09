Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013047.outbound.protection.outlook.com [52.101.72.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB1E5293E0;
	Wed,  9 Sep 2026 10:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788950225; cv=fail; b=BfiCkTJBiaxCYJsaJLX7EoBba6slHo/KHNw0o5eSbdIQ2F1ETWrbBl4u0V31/m5qmZNp7VJ0aRjtEnPhH0GK18jTcA0SimtFw0Kj+c5UsP/4GXOv+VlJlGhLiDUqDaFS9DU1MVBGcMBN31k117GwUUQxJLEyNKafgjQrTA9wdFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788950225; c=relaxed/simple;
	bh=ZZYdS/+ZGnVs7B8FxondtT8sKk4rx905275pKReGiTU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P6DqXkcht0i/onwZVI7XTvHQTpqkFdgyaHnrEZbTVKz0+aJ1unrMYQJsg1n4OZuilzC5mpCZEjUa1RQD1xhSVSYLTUb08zF3rFun5FLfUctNDwTSe96HAN/uGJEjEyegJTEoiVZEL8oYbqBu3E/DZt0tW5GR24k3g3SG1lkB6u0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=RWWB5x5r; arc=fail smtp.client-ip=52.101.72.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="RWWB5x5r"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vf4Eu2Sm20pQJAaG+oOdZwDs2HR82JyLayfzlrzXE2BY3LfDJ0Z6NezEENnHUsuRdGw9SYdkQHl1nXa8UYs3KXsocSXnm0jdcwapWVQKACDxzD2ddCY5te+uC9DB/QW7LavNROZgGh6bnZV5CGw093+255qJC7NDftUWYU9MCclBZ/41vp/oRsw1DtLt6sDT0ZTmx+AVlz4qtWidVEnpiZsZmMMwBgGZdtYP1lB95raCf6stC7Hvhc14EZ7pToRajAHNqd6FWw8rShwpjyJX7o0hml29OHgR09f7jGBlZM+ZjbcdEiDNcDmXWrVmXF0w+PodnN8jPQaTKtDiMpCVBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y1SLxkB9kqj9jiCGY1CtGeHTRkozQcQWHFb7CqxOvu0=;
 b=pRH0K3yVu/vDI2vkCO55cHcP7cpc7dS6CvmmV9YmVjoeH/pvTWJMKn2UjDvsFwSsj+/HiJtPgohryq8u2GLRUKYG1+rCLvK+yVAnKkFUN6ho6Ua7lAsPiu0K9jcYYIhntRwvqEx0K/V1eAemNzgFtDf6SS+lwfz9RrP/6w1BSPEJEPvuKmHgrSfPaBWAKcQE0wCqKMiqTjs6OQ256aJzVZGcS35bSzXIOf5TvCOA0bL6j6NuzAlUihSqFhjWBASkT69WC1ddvJ17czDO/mZ7WdoLxdt1bM1Pff6wzGXL/d8oxTx6LDDQYkiqkx/Z84eAFce4UxNiZHJaUuJlNm3YFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1SLxkB9kqj9jiCGY1CtGeHTRkozQcQWHFb7CqxOvu0=;
 b=RWWB5x5rQliIwnxG+bL8RjBj0TmPbc748aGdDD39SYupAiaWIlzEZ+C34hFPmhXUlljMTnUonM4/Pufm9qZtP6CDIQD0OGyGFrT5O0ZNqsMzm9RMP7QfV3PKy177I8gbAJ6j7o5eq3nI0/0kbAPbWfvvlt7hC8JyH+KNQsuz9ZBQfTNuyspDLBI55RQk4BsMoDm073mC3Mmj3GZ8WLUjBjgSW1nME3FKOVk21QDFgkCbgY//sY/2UFZUgqPrrsBhETjBl7If9RqEqG2/ZOSmcqYhfc0JoFLyvwgmTNkVakJqjRBdGwcNKFg9o5EALaX6QTsPxJTJyHC/p6BRMnfE5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by AMBPR04MB617387.eurprd04.prod.outlook.com (2603:10a6:20b:7ae::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Wed, 9 Sep 2026
 10:37:00 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 10:37:00 +0000
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
Subject: [PATCH v4 net-next 13/15] net: enetc: implement ndo_set_rx_mode_async for ENETC v4 VF
Date: Wed,  9 Sep 2026 18:07:31 +0800
Message-Id: <20260909100733.1139689-14-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260909100733.1139689-1-wei.fang@oss.nxp.com>
References: <20260909100733.1139689-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0112.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d1::17) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|AMBPR04MB617387:EE_
X-MS-Office365-Filtering-Correlation-Id: 7409a4c2-092d-414f-c821-08df0e5e47b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|7416014|376014|366016|1800799024|10067099003|6133799003|22082099003|56012099006|11063799006|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	hHgqIE3vUa6GXaxrLUoTRRwBiufvtLivjCJp2EQb4tGmyV/QYJZj9PHn0QWFvkuQkuLrF68m4EV4aLNltK82lO/kmpWIZdw5vDyFXxObjscKaFoyBDOb+Xbu8dEuKYCyhqXDFJEOax5Hexu1+6AgOAFPb5VUZeUDZCXZ88l66PuxSomxMUJ8HF7XbcpbqPf+fOqDaTJKMfKQ0neYXayrzjG42Edkv5usd448pNj86xIu86g+Eoqx/rKbnRfIbuup9BiBz9mD1J7mo/OeZ48q8yrFeRXMzy43t6UmbXkkjq9v7oKcwRykPS+fHLJLV31Hp1d2RA5p/prMtdoTrRHAEOj+WnOtanxC3+/m16G0bWFo5buo2kqWgcWcw4jnazI+yf5f1X+UO2zyt93C2b6QwrE672ys+if52DtAtsyHQXSVYHWwhR9NptuSLRksPXKY0E38Z7cQY7P/Qd+8GiTib1NAdTF7I8lBnjxWdTYd9o1Ya+9JSbABJwlJkp0jCxzKRPnBaid92GIXJziZOLN7pi86+EETCOp3OeRjWu3SSggsUmAlM7NcM2MQcFYWZTU5WTyV9xu/r9paImr1N4zyYAKT+/yrpAMqDlS0HX/R0wciitNkjEXmYzC1yLdlI5S3/7tHcqWMgpmrOmVwKoky1d9Y+gdbezw39kPe5PZPWze2BV3VoOKG7rx/1rDdi4EoRHmUoZrA5iLOT2qSVqtANA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(7416014)(376014)(366016)(1800799024)(10067099003)(6133799003)(22082099003)(56012099006)(11063799006)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tGEhgVfCPSeXTGCpt0Iwkp96Weat04zXya8xfRgXa70+dQZL+cXZIjRIIr1l?=
 =?us-ascii?Q?vGP0aaYqqVSKI9wjgqAAGSZOPy//X2+tUaVi10hJ/Ll87Sm4EBYTl8HbSjLj?=
 =?us-ascii?Q?E4/2s09Z0DvyOa6paVmHu5J3DjKucoIcimIPxmd2JQszlNCXIM2CdbWI3gFW?=
 =?us-ascii?Q?GjjMjlD69i4MZRL5FYm+78M0zYbJL3wkQ9vxVunFdyw+cplGZZKLECQ+/4Px?=
 =?us-ascii?Q?X+MRWNqvYvZ4jtIsB8xVf4UphObl9WG+8ZDsjMQDZEbVTTWR6MmskYTU0KMg?=
 =?us-ascii?Q?/AjbCQ3TWQ/JPrseV0dHpWGnZ3fsRmg5zbSv13/cQzUt4MxTJtR/mIHQIx3U?=
 =?us-ascii?Q?zB8dC78xfO333+cYK+wcDnxZqdoGRCUXxx2uGjLMLjv3ZyObSqa0gLM7AsL1?=
 =?us-ascii?Q?NSakbcJ3a5ZSMuU5/54ulavYOQXIrnuj3It0QUf4EyQCBWMU5FM13kamE20W?=
 =?us-ascii?Q?/oDdai0ngtznFQURGW+rkqJ2mQL9H071kjKfkkQS3Qyz/9f043bQzBfvYglC?=
 =?us-ascii?Q?isM2ZuLYltKl0BVjqZ3zvGVvyNwSPtcti0VFMBAx8PomMC6KBITlVABt42U0?=
 =?us-ascii?Q?cL7jSW1InXby/7vySPmY9fjodZ6XJZTqoWMwB81TANrJhEB3mSqfSt+JYcbh?=
 =?us-ascii?Q?sCP/9LBb3a8oeeKFF0x70sPgrZrTEMhUEHdLH03I0fNhmGqgq3OKRo9ZRTvr?=
 =?us-ascii?Q?JZHiHuc8d4xMbUj7OfWxcWpM+Fl0gVecyrynmJx/HM6Xr5pr2TgK/jWViCmo?=
 =?us-ascii?Q?NSrRTTo9THXsUhjUv0D1YyeNkuy4QDz6U6j1DjGk/W4U7fPSl+XA1PwjOkGF?=
 =?us-ascii?Q?xDg3f6D+D8O34uRUryhfWGpDC/3+YGsrAGYBH+FvWua5dQ4rm7Yt9Rgnnjdz?=
 =?us-ascii?Q?W5O/iAYVnLezp41sSaRofERNN3XDk0egzpf9eMtP7GWkAV4o9iidWM4ri7Ga?=
 =?us-ascii?Q?RT97He+V6e8IjQbkaPrfHSwk1tbtOlqwqP4F4h2KCgPRd2diSsYOkoCiINUW?=
 =?us-ascii?Q?e2GFLTfmI9AHBdEYt3AE0+6r6QpLTy4evrZV/3uF05ec4VEKmO4AJpRM3L8m?=
 =?us-ascii?Q?bGHpJGfDcPqJPxgu8Ill010hkvmEebQV1+0z8Y2MrKD6XUmiCLO5DYT4Em7t?=
 =?us-ascii?Q?mc5iP8mmp52VnPFlD0qEVgUs3POkMGmXc5F3TTQ69asQgrKaeoNzNrzZixdU?=
 =?us-ascii?Q?j/jbPYyBUnWEKn3sV3cv4o5Lcn9z08sCHDzC3xUcAp25fMEAi/+R/fgpojag?=
 =?us-ascii?Q?mHj5BzbDNh7gM/epHubZsce9enmm+JU+tspkDz+Atc08G1yMD1CJlZa75NRw?=
 =?us-ascii?Q?mdjuhzkTMdyqahhAnKOc5a2YtoNmGjRSRnJvc688gHglzwTqYJWvGTRyqw5H?=
 =?us-ascii?Q?tCAq4lngvu1aLcSqtqfyvZQt5Y4Axru9K1wh+NZCOBsrMJ080IRulThoyEM1?=
 =?us-ascii?Q?ijuxTSV3ZtoXwrdFZlMfwZr/nOWewt5HdgyN04LYb3aH/IBnMFPQLOyRyXto?=
 =?us-ascii?Q?LbGm0KqK5ed0q8HVO1hYc+ANYb0G2sfcVgXbqLZ7Dr8earvzlgSYLuXOPmM7?=
 =?us-ascii?Q?MzIjYLkyrhypW7q2NAKCVqB2mCEOV3PopcIuRQuBxG8nV+oMC+9sC1u+d6ct?=
 =?us-ascii?Q?2vLsKwvQZACQuYW8ifFUZ4rW4AK6LtpHj7RAL1skExomTJLcBSN1CzQRHCQf?=
 =?us-ascii?Q?p1zsuKc9X8/VwFZZY3DmeWZL4j7HH5RsfXN7tUi23HY4MHsDvRSIYC4Llifj?=
 =?us-ascii?Q?UYB8SA+KrWm2w5tO0mpBQ4++3wdTB31Y/eAb6jdJVBOH+Yxsxy9t?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7409a4c2-092d-414f-c821-08df0e5e47b9
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 10:37:00.4519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OZe2QNZxq1QEDFSg7A1p/KuHo2AYAEGKAWEpLd86NhsTTH0iKPk0AgU4UJw0xiUKrRwuAq8W/MJrEdwzo0R1vP95Nrpm/i9KmZ7fFna4Lzwsqhs8/O5HQbQz0w62p9ro
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB617387

From: Wei Fang <wei.fang@nxp.com>

An ENETC VF sends MAC filter changes to the PF over the VSI mailbox,
whose send path may sleep for up to 200ms waiting for completion. Since
the legacy ndo_set_rx_mode runs in atomic context, use
ndo_set_rx_mode_async instead, which runs from a workqueue under
rtnl_lock and receives pre-snapshotted unicast and multicast address
lists from the core.

Add two helpers built on the VSI mailbox:
 - enetc_vf_set_mac_promisc() sends a promiscuous mode message for a
   given filter type (unicast, multicast or both).
 - enetc_vf_set_mac_hash_filter() sends the 64-bit MAC hash filter table,
   built from the snapshotted address lists.

The callback picks the configuration from the current netdev flags:
 - IFF_PROMISC: enable promiscuous mode for both unicast and multicast.
 - IFF_ALLMULTI: enable multicast promiscuous mode, disable unicast
   promiscuous mode and apply a unicast hash filter.
 - otherwise: disable promiscuous mode and apply both unicast and
   multicast hash filters.

These requests are subject to the PF-side ENETC_VF_FLAG_TRUSTED check.
For an untrusted VF (the default) the PF denies promiscuous mode and
unicast hash filtering, so only the multicast hash filter is applied,
limited to ENETC_VF_MC_HASH_BITS_MAX buckets. Mark a VF trusted via
'ip link set <pf> vf N trust on' for the full behaviour.

Set IFF_UNICAST_FLT for ENETC v4 VFs so the stack does not needlessly
fall back to full promiscuous mode; whether a unicast hash filter is
actually programmed still depends on the PF trust policy.

Since a denied request always fails, map -EOPNOTSUPP, -EACCES and -EPERM
to 0 so the core does not retry an operation that can never succeed.
ENETC v1 (LS1028A) does not support VF-to-PF MAC filter messaging and
keeps using the legacy ndev ops.

On VF removal, disable promiscuous mode and clear the MAC filters, so
that stale configuration does not persist if the VF is later bound to
another driver.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc_vf.c   | 214 +++++++++++++++++-
 1 file changed, 213 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_vf.c b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
index 322705202d49..8cf38c426dae 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_vf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
@@ -213,6 +213,193 @@ static int enetc_vf_setup_tc(struct net_device *ndev, enum tc_setup_type type,
 	}
 }
 
+static int enetc_vf_set_mac_promisc(struct enetc_si *si, int type,
+				    bool promisc, bool flush_macs)
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
+	msg->config |= FIELD_PREP(ENETC_MSG_MAC_PROMISC_MODE, promisc);
+	msg->config |= FIELD_PREP(ENETC_MSG_MAC_FLUSH_MACS, flush_macs);
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
+	struct enetc_msg_swbd msg_swbd;
+	struct netdev_hw_addr *ha;
+	int mac_filter_type = 0;
+	u32 tbl_cnt = 0;
+	u32 msg_size;
+	int i = 0;
+
+	if (!uc && !mc)
+		return 0;
+
+	if (uc) {
+		tbl_cnt += 2;
+		mac_filter_type |= ENETC_MAC_FILTER_TYPE_UC;
+	}
+
+	if (mc) {
+		tbl_cnt += 2;
+		mac_filter_type |= ENETC_MAC_FILTER_TYPE_MC;
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
+	if (uc) {
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
+	if (mc) {
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
+static int enetc_vf_enable_iff_promisc(struct enetc_si *si)
+{
+	int err;
+
+	err = enetc_vf_set_mac_promisc(si, ENETC_MAC_FILTER_TYPE_ALL,
+				       true, true);
+	if (err)
+		dev_err(&si->pdev->dev,
+			"Failed to enable promiscuous mode, err: %pe\n",
+			ERR_PTR(err));
+
+	return err;
+}
+
+static int enetc_vf_disable_iff_promisc(struct enetc_si *si,
+					struct netdev_hw_addr_list *uc,
+					struct netdev_hw_addr_list *mc)
+{
+	int err;
+
+	err = enetc_vf_set_mac_hash_filter(si, uc, mc);
+	if (err) {
+		dev_err_once(&si->pdev->dev,
+			     "Failed to set MAC hash filters, err: %pe\n",
+			     ERR_PTR(err));
+		return err;
+	}
+
+	err = enetc_vf_set_mac_promisc(si, ENETC_MAC_FILTER_TYPE_ALL,
+				       false, false);
+	if (err)
+		dev_err_once(&si->pdev->dev,
+			     "Failed to disable promiscuous mode, err: %pe\n",
+			     ERR_PTR(err));
+
+	return err;
+}
+
+static int enetc_vf_enable_iff_allmulti(struct enetc_si *si,
+					struct netdev_hw_addr_list *uc)
+{
+	int err;
+
+	err = enetc_vf_set_mac_promisc(si, ENETC_MAC_FILTER_TYPE_MC,
+				       true, true);
+	if (err) {
+		dev_err(&si->pdev->dev,
+			"Failed to enable multicast promiscuous mode, err: %pe\n",
+			ERR_PTR(err));
+		return err;
+	}
+
+	err = enetc_vf_set_mac_hash_filter(si, uc, NULL);
+	if (err) {
+		dev_err(&si->pdev->dev,
+			"Failed to set unicast filter, err: %pe\n",
+		ERR_PTR(err));
+		return err;
+	}
+
+	err = enetc_vf_set_mac_promisc(si, ENETC_MAC_FILTER_TYPE_UC,
+				       false, false);
+	if (err)
+		dev_err(&si->pdev->dev,
+			"Failed to disable unicast promiscuous mode, err: %pe\n",
+		ERR_PTR(err));
+
+	return err;
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
+	if (ndev->flags & IFF_PROMISC)
+		err = enetc_vf_enable_iff_promisc(si);
+	else if (ndev->flags & IFF_ALLMULTI)
+		err = enetc_vf_enable_iff_allmulti(si, uc);
+	else
+		err = enetc_vf_disable_iff_promisc(si, uc, mc);
+
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
@@ -227,6 +414,20 @@ static const struct net_device_ops enetc_ndev_ops = {
 	.ndo_hwtstamp_set	= enetc_hwtstamp_set,
 };
 
+static const struct net_device_ops enetc4_ndev_ops = {
+	.ndo_open		= enetc_open,
+	.ndo_stop		= enetc_close,
+	.ndo_start_xmit		= enetc_xmit,
+	.ndo_get_stats		= enetc_get_stats,
+	.ndo_set_mac_address	= enetc_vf_set_mac_addr,
+	.ndo_set_features	= enetc_vf_set_features,
+	.ndo_eth_ioctl		= enetc_ioctl,
+	.ndo_setup_tc		= enetc_vf_setup_tc,
+	.ndo_hwtstamp_get	= enetc_hwtstamp_get,
+	.ndo_hwtstamp_set	= enetc_hwtstamp_set,
+	.ndo_set_rx_mode_async	= enetc_vf_set_rx_mode,
+};
+
 static void enetc_vf_get_revision(struct enetc_si *si)
 {
 	int ip_mn;
@@ -280,6 +481,9 @@ static void enetc_vf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 	ndev->vlan_features = NETIF_F_SG | NETIF_F_HW_CSUM |
 			      NETIF_F_TSO | NETIF_F_TSO6;
 
+	if (!is_enetc_rev1(si))
+		ndev->priv_flags |= IFF_UNICAST_FLT;
+
 	if (si->num_rss) {
 		ndev->hw_features |= NETIF_F_RXHASH;
 		ndev->features |= NETIF_F_RXHASH;
@@ -352,7 +556,10 @@ static int enetc_vf_probe(struct pci_dev *pdev,
 		goto err_alloc_netdev;
 	}
 
-	enetc_vf_netdev_setup(si, ndev, &enetc_ndev_ops);
+	if (is_enetc_rev1(si))
+		enetc_vf_netdev_setup(si, ndev, &enetc_ndev_ops);
+	else
+		enetc_vf_netdev_setup(si, ndev, &enetc4_ndev_ops);
 
 	priv = netdev_priv(ndev);
 
@@ -416,6 +623,11 @@ static void enetc_vf_remove(struct pci_dev *pdev)
 	priv = netdev_priv(si->ndev);
 	unregister_netdev(si->ndev);
 
+	/* Disable promiscuous mode and clear MAC filters */
+	if (!is_enetc_rev1(si))
+		enetc_vf_set_mac_promisc(si, ENETC_MAC_FILTER_TYPE_ALL,
+					 false, true);
+
 	enetc_free_msix(priv);
 
 	enetc_free_si_resources(priv);
-- 
2.34.1

