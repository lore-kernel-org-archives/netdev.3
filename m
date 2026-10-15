Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013007.outbound.protection.outlook.com [40.107.162.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7324F51DDE4;
	Thu, 15 Oct 2026 10:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792061787; cv=fail; b=OL1643423f28tgUh686Qux3XEUCm35CRtN4nvtgbkAhxrwiRoxqZZ9tgfCIx6K1HH6JzHBMkI3SSDg+uEx8wyL6FRnWiKtNG/qX2eBroD+qtpm9QoxkW9zDfdkZ9zO/6OE1/HuqyOMEOnL8n1mbz9nowdSaJXqna82kKl1JaK+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792061787; c=relaxed/simple;
	bh=r1f9QAJhSn3nMEy4S3ge0KhP4gDxvi5+L3BYymWe7nc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z00nl6gdfuX+G1T4FfnZeDVPrPI/e2r0IBZtbk+kw+vW97wFa4SknRAFlkQuwqL1DBc9XDwzoKmEZbvbGHIaXOAyrN8NKREPAZfcRuOMzCAuUmKiaG6uWsbosUuw22dDDVMjnHlFV1BuHkRgSKv6woSuapWxBuTsEqG4xiJD34w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TrUsnxan; arc=fail smtp.client-ip=40.107.162.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TrUsnxan"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sj4wn9j14AtIpsfBa0r0d/WZPNAzF8pMnQQc8smSkJ4t3bXAyOuCIX7GY+S8VJN0nuKUCuzYFOx4kDyPf1Po+c3Mlu4/9Ve8s6d5DSTxf8lFtJn7AOmA26eJh2nCI3jXBr0SbYL28FvxxIEoJplfUBgdNeNqnTpzdd19bj6a3xbJXU+Yp/5PFdf04D/4OVHUoLpKM+Scs3EGismYQ+d21N8v5PqBJzze0WDNCnqsMyqPpuux9oDhIgL3kKdHmNIVmWsJUajTyKBrdDwwBIg5x51akvfGvs+qJZTOzOoFWVGttOstFMl//dKVEOza5nZvL0CE+wvxcIHEU78nP8ewAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hWdIkKmTQzGy7My8ew7lNiUxUIqlpeAnmJsdDLuxwE0=;
 b=GawswproBs/3L8hM4r+Ja/0S6UqH3+PPS+u9BD79oR4GWEbbn36K5Hp8cJjnVaGpzAsAEO72WypCQF0Iejs8pLc64OpVYwc6q7jn8qWuP6aPCdmqMARZXAz93y4XAFGx91nC/WuArl2vyTytyC8kKXBAE1hoGM3d2bY4X9TBms0MiD+06VR1b4Lgf51WMUg/ktvrVXMWkNuJ8xkPZb28RrubwfZAUzE3nNaLYZsnead0hQZGuZaRt+h9EwEijUu0vS04ovFpCaEtB9IGBbjo7qXgBA/z9HUERsr5S9gU3vcaBq1Pbxq0U2HvlQ1qErTZqCxK9CgQBeDyrU6p3dFCdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hWdIkKmTQzGy7My8ew7lNiUxUIqlpeAnmJsdDLuxwE0=;
 b=TrUsnxanEBzbUEqAsy582sZDSUA3T64mHkEpTjKgBNMkDOHMlf+nysAbvRKjsOapP4nqUryVpMP0AGa1jqqECGoLqliGxBlmfb1GWA1jXW3YtogqDebT9OS1/E1NckFSQyjhww1cijyGfpI3vTd5wwb9VQYXpAfGza3+k897DDsAjnHl0np7ptP0tJzDDhkRaN5LWrOH1fzS7gPMf9gjjVHPbl6XU7zAhBZM9vb4cagLDxAI+Z+wA4yWPFfbeTgP8O3kgmNz6GePVDKFIJJ3Q46Z5Woc78+3Jl08AZEZrtT/oZUEAf6DM+7G41cn/DW4PQRhvhYUE1ALI09r38/YHQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by AS1PR04MB9698.eurprd04.prod.outlook.com (2603:10a6:20b:481::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 10:56:11 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0522.013; Thu, 15 Oct 2026
 10:56:11 +0000
From: vladimir.oltean@nxp.com
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>,
	Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Zefir Kurtisi <zefir.kurtisi@westermo.com>,
	Zefir Kurtisi <zefir.kurtisi@gmail.com>,
	David Laight <david.laight.linux@gmail.com>,
	netdev@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 net 5/8] net: enetc: ensure head buffer has at least 16 octets
Date: Thu, 15 Oct 2026 13:55:33 +0300
Message-ID: <20261015105536.1692348-6-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015105536.1692348-1-vladimir.oltean@nxp.com>
References: <20261015105536.1692348-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P195CA0023.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::28) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|AS1PR04MB9698:EE_
X-MS-Office365-Filtering-Correlation-Id: 55be1123-a22a-4ec5-59df-08df2aaaec5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|19092799006|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	T6639RfA4tF6Tk/R8hBlH24H/Evk5oCRF+dlq5B6oX7mkhcVIBMi57NjxAnh31DR9Bbu/zj7HX2bMq/hAy9H6HYFiusK5ekaJydBibM/h3d+w3n4sWNyAULJKyC2pTBrpFvp7+pOvdU+72SDnDMI18SVPS2Set7Kg514H1OwGuamgVfCfmgevAOyZEVO3akuY3y/KTbfK0xW+9OCHj23hlO8i1zngScOuZPLvNS5RyEV4gSqgvIDR75KXkV9xlI7XQQw6daBS7cF1hFjP1M8RX8Xonsdd274pliUizuMZBwYtZr8QbiHwB4mpAr8InQtJoNzdKH7uY4FHMD/aE70cDmVUI00SchifmztdGftLE0w1k28FlYkviEpd69wKSr/ZZ9A+Drz4QKujJND/g1anFu6DZTO4bIAcTxsLeTaXiwBk/dvrMmdhgV1ivT1adVrzf5ThueFbdjdLS5OXD6n/J19HMRn775L9tIKF7XpTAzg2id1NVfC0IXlfYAwVXP1z39wnWx0aFHL/hAeBdN7akOfJN5SOK2bMpfwBPmTR2MpKj9S6tZHQEQLn0aMmUmofvC1JTv5oj5M3lT6GR3nDviJcI1tSXeg1kOA+XHoo64Fm9T8CUO8IEdtkPh1EGgF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(19092799006)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eVuU+ehRZRh0aXza2m4X2DaU3wyQpW9eiLE/ciHEmPT+mWxNJ/dpq1gVp1Oa?=
 =?us-ascii?Q?Mzh2uwQB4n35BeICN89VHpAluCvZ+u/ZcCJ5/8HDJkFl9iVzH3w2DAgVzKuG?=
 =?us-ascii?Q?nH+iMuy5LOnjl15QdTR4egYinm72brwTU6Fm6iFvU5f8JwIqDIMrarayQlcL?=
 =?us-ascii?Q?obR756HvI83BqpNBVhiIPQBJFXuiqx18suknLjllbNJmfOkKpqeTO5UC9ROA?=
 =?us-ascii?Q?ibau45Y4CpyeeMJqdP8aFYj6qpvFwhvCpOvCAjWpQ4cPJ2mXeIberpjKGCRy?=
 =?us-ascii?Q?r+KxpjwYdjD7XdnLcwgos00OMqVZD88GAvEGAmbhsuOzLOaeThLn6LNtydSY?=
 =?us-ascii?Q?EF3HoH8AlAvX2ItoL5Jw4avsqOI2u/50Of+beznoHyURLzSeUGUUMNoCSXAs?=
 =?us-ascii?Q?IE7AnvnK055jHjD8/qTmSOfhhGFnaTyEq/ngmD1KOOr9NY4v/5hndz9+6s0y?=
 =?us-ascii?Q?bX3SduOZi61kdPXbOoRfZ47Y8ntEpHGzhHDdHfK58VuEZhwVUduh75UEjYAq?=
 =?us-ascii?Q?pUZfXmABDZ05o8WaADXhiVg3AC5X11sNQ/5e4bf+hzFXOcWfdQrlQc9VCLJD?=
 =?us-ascii?Q?6WX+OBbTVU/ffeGp+CoCrJRXwC7qp8dqzkVvc3EwpQnnsztxt5XL8M3a4ABj?=
 =?us-ascii?Q?nyqwbHOx8rQBBbp4GKKEu/4xVe44L/XyZeQtp/iNGHtLr74nGDSxlVw9kAAV?=
 =?us-ascii?Q?sYwHoj2tRhDzmAU2Ck8ja5bs7xm+ZgRw0FON69OZQ616JdAw4knUwrecHUs+?=
 =?us-ascii?Q?Jop4ul7Ef1QFK4zIJGNyq7m2/VLTBu76StodirJEdfGq8vjpw8QiUw09HXQl?=
 =?us-ascii?Q?sfYNbFjh20ZENpdyqwvZJahtnljGfSu45yO925YE8fJCaIx8eKFSBPpANzRM?=
 =?us-ascii?Q?ba3/Q2//s4TTOsFEa1XJZ32dLqpmlAIWaMbhOy2sCZyj/gUHLneJ6GJwwVm7?=
 =?us-ascii?Q?6x94L+Q4CARSWm/57cGLspP4ZK0ZnQiPJCUUxwzcbEKST8s70RPlzMroZvM/?=
 =?us-ascii?Q?lLAJrMM+NOHMf2qdCS28U76lRvhyMKroOgvhq/ALpTTIQ4e7vUoiFmot2Mqx?=
 =?us-ascii?Q?yKR4jbOhMVf3DLiy1T9nfnGaTr9C2QNbbPEfJ8jegMYZOfHgdMrqSzbP6bkA?=
 =?us-ascii?Q?2h5CMPOhcNIJm1Sp++9cgJ0g/BSE9ZNnGwEo0gOu7spE9cgGfgj5AUrwnGEY?=
 =?us-ascii?Q?Xk3ocIuh6felDwgOEmWixBU5v1PJNpdEOtjPcrFyN1tEUQBydw8tB1FI1d4y?=
 =?us-ascii?Q?MulgUGdU0acTVFqmli+wzjbX61r+YCiuzcVKDeNiF3nNi4nod4v6XADSUpEl?=
 =?us-ascii?Q?jN+AQ4Mn7fAP+W9HMtYksep+k4pTJ25v5ZQKufj0mKqqRipif0Owbc1pgX47?=
 =?us-ascii?Q?GAJ701LynTV+hgW0eyXvRtaO/ZbBgw4YY60/Wb1fv8RMLRAFcinOY0moWWuI?=
 =?us-ascii?Q?PlUCeAvUS1ePtOR61zbY3MEoUwCbqJx2qHzyKIv2gvStcyTQi1AXvVd5G8pd?=
 =?us-ascii?Q?0CHGT+8LiXEf/aEJ2xGXccHhqwEUOVQiuYpkuhEMX5/gvqVSDmqtxkyj6y0O?=
 =?us-ascii?Q?Z/5I4JYnUDNIA4GcSsgC9doaPFroNHqB8yAtTzt2LtskMqO7bOGvzVd0LoRZ?=
 =?us-ascii?Q?ri1LFMJ6myz9vMF0c5u4OIg0npILDEUJRHbD/5fUbqGctTbnTeR44e92qfM+?=
 =?us-ascii?Q?M2dt2s3C4lo5xAL12TRiMhvozCpCcR5MVwHM9hvDnkPEMsvTPSk55BdwGp4G?=
 =?us-ascii?Q?5cZLnvfiGg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55be1123-a22a-4ec5-59df-08df2aaaec5d
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 10:56:10.9276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lk6pM6eJS0cYzOkYyTQuyUNplmqRQ6HEPRZaAsyMiHEWsm0fT45XmQeTQmrwLFeW9RnJGBD349kSenAYyDgBmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9698

The ENETC does not support BUF_LEN or FRM_LEN in TX buffer descriptors
less than 16. This is written in the reference manual of all SoCs
supported by the driver: LS1028A, i.MX943, i.MX95 etc.

  Frames must not have a FRM_LEN that is less than 16 bytes. Frames of
  0-15 bytes are not supported.
  (...)
  The first descriptor in a chain must not have a BUFF_LEN that is less
  than 16 bytes.

I don't think proper attention was paid to this during development, we
found the text at the end of a bug investigation. Therefore, the driver
does not enforce this.

But the frame length and geometry is out of the driver's control, and
the network stack can actually send packets that ENETC doesn't like.

Zefir Kurtisi found a case where transmitting L2 WNM keep-alive frames
through ENETC would soft-lockup the host through an IRQ storm. He later
distilled this into a small enetc-killer.c user space program which
sends a packet with MAC DA, MAC SA and EtherType IPv4 (14 octets in
length) through an AF_PACKET raw socket. Note that this particular case
was already closed by the previous commit, but an identical situation
still happens when the first buffer of a multi-buffer frame is < 16
bytes.

The IRQ storm is actually a curious effect of a chain of events.

The hardware behaviour, when an invalid BD is put in its TX ring, is
that it would transmit the packet as normal, update counters, raise
completion interrupt as normal, but it would just not advance the
consumer index of the ring (TBaCIR) to signify that the BD has been
consumed and is available for software to free. The ring will also get
its TBaSR[BUSY] bit persistently set to 1 afterwards.

It deserves an explanation why the behaviour above would lead to an
IRQ storm, since ENETC interrupts are message-based (MSI-X), and an
unhandled interrupt would typically just be lost rather than retrigger
itself as a wired interrupt would.

NAPI processing in ENETC has 3 steps:

I. the enetc_msix() hardirq handler disables RBaIER, TBaIER and sets
   softirq processing to the 'pending' state.

II. the enetc_poll() softirq handler for the IRQ vector walks through
    the TX rings affine to that vector, checks which ones have a TBCIR
    updated since last time - enetc_bd_ready_count() - processes those
    completed frames, and clears pending interrupts in these updated TX
    rings by writing to TBaIDR. (I've excluded RX processing due to it
    being irrelevant).

III. After the softirq handler does its round of checking all RX and TX
     rings for updates, it re-enables all interrupts in RBaIER and
     TBaIER that were previously disabled by the hardirq handler, and
     exits.

Because the TX ring with the short frame is skipped at step II (TBCIR
wasn't updated as part of HW malfunction), its pending IRQ is not
cleared in TBaIDR by enetc_clean_tx_ring().

But because enetc_msix() disables TBaIER at step I and re-enables it at
step III, another MSI will be fired upon re-enabling it. This is what
completes the cycle and the driver goes back to step I.

So the driver misinterprets the mixed signals it's getting from the
hardware, and ends up causing a software-amplified IRQ storm.

Because the driver now pads linear skbs to ETH_ZLEN for other reasons
too, we just need to ensure the head buffer has at least 16 bytes.
This can be done using pskb_may_pull(), which moves that number of bytes
from the paged area into the head. This is case 5 below.

  skb_headlen (H) | skb->len (L) | linear? | handled by
  ----------------+--------------+---------+---------------------------------------
   H == L         | L < 60       |  yes    | eth_skb_pad() (pads head to 60)
   H == L         | L >= 60      |  yes    | already valid, no-op
   H < 16         | L < 60       |  no     | eth_skb_pad() (linearizes + pads to 60)
   H < 16         | L >= 60      |  no     | pskb_may_pull() (pulls frags into head)
   H >= 16        | L >= 60      |  no     | already valid, no-op

Fixes: d4fd0404c1c9 ("enetc: Introduce basic PF and VF ENETC ethernet drivers")
Reported-by: Zefir Kurtisi <zefir.kurtisi@westermo.com>
Closes: https://lore.kernel.org/netdev/b3d9136c-2803-4203-b1ea-1f9e62de80a1@gmail.com/
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v3->v4:
- rename from "net: enetc: pad short frames in software". The padding
  to ETH_ZLEN is now done by "net: enetc: do not rely on mEMAC hardware
  frame padding", so this patch only deals with the 16 octet minimum
  head buffer length
- move the check from enetc_xmit() to enetc_start_xmit(), after
  eth_skb_pad()
- use pskb_may_pull() instead of skb_linearize()
- drop the code comment above the head buffer length check, it is
  redundant with the commit message
- rework the commit message, add a table of the handled cases
- drop Reviewed-by from Wei Fang and Tested-by from Zefir Kurtisi due to
  the change of approach
v1->v3: part of "pad short frames in software"
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 6 ++++++
 drivers/net/ethernet/freescale/enetc/enetc.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 9ab90145dcfa..08870df613b8 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -1076,6 +1076,12 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
 		if (eth_skb_pad(skb))
 			return NETDEV_TX_OK;
 
+		if (unlikely(skb_headlen(skb) < ENETC_MIN_BUFF_SIZE &&
+			     !pskb_may_pull(skb, ENETC_MIN_BUFF_SIZE))) {
+			dev_kfree_skb_any(skb);
+			return NETDEV_TX_OK;
+		}
+
 		if (unlikely(skb_shinfo(skb)->nr_frags > priv->max_frags))
 			if (unlikely(skb_linearize(skb)))
 				goto drop_packet_err;
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index 08613e6a1d28..b5f38ad17280 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -22,6 +22,8 @@
 #define ENETC_MAX_MTU		(ENETC_MAC_MAXFRM_SIZE - \
 				(ETH_FCS_LEN + ETH_HLEN + VLAN_HLEN))
 
+#define ENETC_MIN_BUFF_SIZE	16
+
 #define ENETC_CBD_DATA_MEM_ALIGN 64
 
 #define ENETC_MADDR_HASH_TBL_SZ	64
-- 
2.43.0

