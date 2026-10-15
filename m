Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013007.outbound.protection.outlook.com [40.107.162.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA7751D52B;
	Thu, 15 Oct 2026 10:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792061803; cv=fail; b=eiJRkGUm2GSCNQvhqkxKpIKBT8w29QLvDnjMvGYpHuwtQOFDHGZwlrHY65/bAgumLaZzgS3O4uekhFbgui+TH6IAfKmWVV//vEOxEZN0tM4yJacJwwMgwiGzVXfzayCXJuok0e4GxsIws/gT2Y702tnJcyg8T8h2UU2j3zAy8EY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792061803; c=relaxed/simple;
	bh=3TqxZNantl7ZGp77IIVz5LTVSjFsKHLVsQ6xG9ITJgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UgiUbo1S4OxMBiqd/o6JRQAZ7NuvlTI+7ze/CGjva20NvZRxI2T+vS0si2p28LfqceSrKXB0ic31/04rEw5XDzrpC/ibrCxjlf+sl7HBmvjniRSzb7XjvHeK9O9PjL6jhvygk7cSsqIQLWY3v3pGmkMLfVG/VIyZYzmsnkbKzec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RNCRCBLi; arc=fail smtp.client-ip=40.107.162.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RNCRCBLi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YmIEAcpUZ1O7XVBg9RUdaAPg1gZi4+snd4zMh1m679fuF7SeFX+FRzqVyF28OaZl5T0EWC6UHqPCDjLf0/8DIl/gxvDA5zhWbg4BsfbMnfQlV1uK+8r3tqWI2MvzPrn2ZQG/9LLhAFJbzlvhUh+Pi7TmXbIFgVJQYRkE9g7Ht36tmQtbbfFvnMg/kahzvufTUtv5yNojMQnwaceBfqDgSIlpv8syJ+Gm+8fp+v3nsWTuWv1/dXY1QRvVexSLBp4SGhZiXO2WS3LWfKo6z31X0paAXm7lpI+mJnqZQ7Fi80eIN4Vfa3Q6H2LW85zSic61YI0IRK9Zc/+p68LVxgC/Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bm8q9kUX4RUgWZtP3iT2ApjN7dW5gYdIqFMyio9Ddvg=;
 b=Lxt1MLdHZMeySLsNYemJRGe5ZKKCWJnLozk2m9TkaeQTIISK3nTBdPT/6f4Ra9xXVIvRdUk3euGPt1KA7hV66EyaTuHYRU25pNzDZrji1yDdiQAJpDYqTmYXOrNH1DYUb3c5/xUv1IIxNJnNgLMno6JB+DYpxj2VuILAFWW11njvD9F/4Aj84Wd5QZTiKUZt0WyqZuGlfsPeI+0emiOcibjyZXcQwp8rE0UJ/wccm0DPs5IoG57zKaSmsFVqvKDyb6w7oB19sxiVr5V0yMkxUp1uoZyeC5wQ9crxkiy96fbWQn/SU5le//9q49xXBL3ZudN3QJtdfhFQ+w6YrWblQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bm8q9kUX4RUgWZtP3iT2ApjN7dW5gYdIqFMyio9Ddvg=;
 b=RNCRCBLi9ia3N4Qk7BxBTRIIThG0eNoLIDQgbPf8c415rm3mVls2oKy8oxTQDGYfqW2nADpATjNsgSL3DEAT5pRELTpm7P0Dv4t6CIIZeEGr4IMwFxmEDtEgmcusvUmMV9h/p1/ZcRgUGWpaCru9QJ2PAl7V+0BPqNMlpTW0y/pa8Arra+14hVxxZPxUA53skll/JMIzMG/ng4k/gAZTWUekd3QKsLUFwpe8/k9RbaP1pDD0FwrHP81/lSrnQoxaxgUJuzYkgnaRSUBBzgAl1jvbLXpebaA36RIGC6PdnGFzosCyzi/cgv9boLmAITkMxDyHTq35+WBb46jqU/DH0g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by AS1PR04MB9698.eurprd04.prod.outlook.com (2603:10a6:20b:481::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 10:56:14 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0522.013; Thu, 15 Oct 2026
 10:56:14 +0000
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
Subject: [PATCH v4 net 7/8] net: enetc: fix leak of pending XDP_TX frames when going down
Date: Thu, 15 Oct 2026 13:55:35 +0300
Message-ID: <20261015105536.1692348-8-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015105536.1692348-1-vladimir.oltean@nxp.com>
References: <20261015105536.1692348-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P195CA0002.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::7) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|AS1PR04MB9698:EE_
X-MS-Office365-Filtering-Correlation-Id: df5b0dd4-47f3-4278-6433-08df2aaaee8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|19092799006|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	/7Ubxs+tSwCIHwNLXNKCEE7ak1liz8KKTxY2q/eQSI/i6Oy8B0vzflgYyCO67mLB42Fa5j9kT/noXyhujdP4O5wTDhWRoyLVtW08dpmbsyoZrOCQlqcQzuggIJwZqqRXhrxpegzrBMGvwo7kKhnApIbjlCsmZawbUWNFreniURuHdYnj/Nnfp2kHiCEil2rpS1OS6MyhYf4DS/tgYG2k1wfdfJH36g461Xwp4aON2ntrMdrxr8IL7DSKC+pS2fDrQ1nIMCCmQZJ2D7d0ewhGflcAhnZUQM4wF4FgBW9joAtNOnsm6AD3L2Ed0Ysj/24zuBCKtNhYmJagrf0eeiJF2pw3LhPvbtglhQFE23fLb51NieE+lzzkJelXL7z6y9c5CA+bQzfQZEf8k5CibJqG9dagKHsIGzoEeoTgpB9+Zjiu3PnVcPHG0t62OfgrZWFJkiagXT8pJmN2nnCsMaKSlQ1ucJXdPOm5e7SUzlt3bbDk/CsQDhGNzz56MQBPyJQH+oBb5KT7tuC/zL6qY9z7vhZPb3z43qiYywFH8CkRtsbWb4/BPK13j2k1ZfLtQsXyiWlfys3H9zlghR7SEW+fULFaO4O2bMTtVC+qiYcMqMXyJQWlomRHdTetxNDOLfvdZT/z2Xe1xzuM2x5Z9Vzt88zX1RJbz30fTbYazPgKf/E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(19092799006)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3yJWM2/W0yrzqDw8WPg4DpJhcehJwm9jgcr7LdlfnX5jXt1XewaytcomhcZS?=
 =?us-ascii?Q?y4SRzSmkxJsSiXdNo5E6Ngx+1CnvJdvqCJ4nTZn2TSQylOQXWpj8etsVRzRB?=
 =?us-ascii?Q?Ha0PK/fBZsZPjz9qEV2rS6sxyY8IwRZ/wyIY79p6qCt+bs2JcI80UVd2/N/L?=
 =?us-ascii?Q?hFBjSnPeoF07c6DhpcdDzkEzoPk7cdteJzwz8XmNL7Zg71z2uOUHAdjb53B6?=
 =?us-ascii?Q?gz84ECRMjVoiZQMhKDkL4CCoGqNbseS2X8MhIjc8dlbvXnTD5PK4A79B3RKl?=
 =?us-ascii?Q?nsTfPzP4Xpw6im6rirvzN4FrlLOwUM6TcW4AOup6MZUVUTZH0Wy/fEJE+9vh?=
 =?us-ascii?Q?/Zl83Ssdi0vEv6XYMOYVXGwgdGEwzH07d5hZODWdQzoxgfpYGO4tU8lc5vvl?=
 =?us-ascii?Q?2oUMapYidwYK2VzwCxMZvYEF3b2HOL/caIMPjH2v4G/jsciWj7D/KMmHvOgu?=
 =?us-ascii?Q?k2w7oSXGVa2Gy6N7Lrm9+FzxOGmH+uF0lCKxXe2L8C372vqmb3ro3D6iyZwE?=
 =?us-ascii?Q?M3IZaLE/y6JQZDgNZlsX74a3lWPiHldSlmjQW9ywwjx5yNXNWr/a44gt09Se?=
 =?us-ascii?Q?PbizeITcOjAc9re+fO+6b2+s7qChVKz4ZzMclrLuCGPMqsN375uJTvd7YQW2?=
 =?us-ascii?Q?g5/rS0SMfDKcn3KxTk5GY75UOI5vm1r15ZwqpBBEIO4b8g2Q+gOJ5YCq0lnr?=
 =?us-ascii?Q?fvjV/IsaVda+p21EO3xf5p+YO2BLcvN2b0TGN3s1dvG3OXHev5bWL7hUFtzV?=
 =?us-ascii?Q?tPApfbWcOE8U42MaznwXk2TQFXnUWpr/xA7maDs4e3M8SU9qTNrW4iI/GqBX?=
 =?us-ascii?Q?dhsGh7kzmYLrl4ttz45w2kzKJC1asQPuOUTQlLn50zDHwU6V+fNIYmee8eA4?=
 =?us-ascii?Q?3jxVBOK9qnmzek8vrsTi3zqDWS/Z0uFFOzBXH+tkUGvkrkettVIyUy9FoTY6?=
 =?us-ascii?Q?Gdnj+/AEUSKZJkS6mnce9G73dlSMsPHko8ouWlhuyH5z4rxalX8SKUKQzI+9?=
 =?us-ascii?Q?fVqZREvF6ssC35GtyDdLFuAANkxd/YGcl1j29Y+D5xtnLJn+Oz6wDld0XgYS?=
 =?us-ascii?Q?B5DUe2JkJ9JRhE3mwa3xo5SyVkZJhV3YmDW6caQ6JVdz2mTZUnMIqUNUqo6o?=
 =?us-ascii?Q?bXyFpFKOQu7h1YQ6WE9chKuRJHsHu0u6P115q2J4SleB44LYxsehXnr64Jwy?=
 =?us-ascii?Q?v72ZNpy6idpA3wieu6EIqA+srGEtFnWj3W9k0G3QpzfXMlbw7NVcwEHIi41Y?=
 =?us-ascii?Q?NLFvRXFbH98EO/BVxDSVqzCWY3UVnaXP+avfBLnhRB2TnSZpLT+oNQNJOaGG?=
 =?us-ascii?Q?8dcDw1oXsBst0qfSVyScw8cwivdAdHNEXnZDnxnCcp1pRmd+K2qymTZUaFx1?=
 =?us-ascii?Q?TD/W1VyhVToLeibVRRAxxyHyx8agEg7TlTqOvWimxSusINMsOBYxEvlxrPXZ?=
 =?us-ascii?Q?9WcaY4uK/y4CEj0J407d6pnd75SMC0tPmcxVFQTWl/tcwZ4ZvxNTpfN8wuzN?=
 =?us-ascii?Q?kLxEtXwPUUyk1qvla+oGUY9gN/+RfvaafexsXDx/WbwfaiNGB2OwjCjJ/5Cw?=
 =?us-ascii?Q?LejlRaWFRDMaS84yN2xJQr61f23S6J2/w374iAg+w2ENBC2D8F0g4H5J++EA?=
 =?us-ascii?Q?JSjEpWgCH0uUqS2WJ4HwKBkUYEcQNLsCKxsrsshqTbCENcw7BYA/y8alJh4W?=
 =?us-ascii?Q?hI2toWOVpZOPPt6J7JBAKJmxrkH5uzjJoelzJ6JtdIHGJbfTtnDl8uXiVREf?=
 =?us-ascii?Q?PO0O70Irrg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df5b0dd4-47f3-4278-6433-08df2aaaee8e
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 10:56:14.6274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C4uMi8aUE1/LG10UBFbenou6lEhtyf8vp/lMmC+8kZtIRtXKsiPs4dCQCIr6gTdgI2yY+uAfyCv4YqYlxTIOmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9698

enetc_stop() calls enetc_disable_tx_bdrs() and this abruptly breaks the
natural flow where enetc_recycle_xdp_tx_buff() returns XDP_TX buffers to
the RX ring.

There are two problems. One is that frames remain stuck in the TX ring,
the other is that enetc_free_tx_ring() removes their DMA mapping but
otherwise loses track of them, i.e. does not do what
enetc_recycle_xdp_tx_buff() does, and leaves the RX ring waiting for
buffers that will never come.

We concentrate only on the latter here. The RX ring refuses to refill
itself because xdp_tx_in_flight is high, but after we bring up the
interface again, in reality we have no buffers. So all ingress traffic
will be dropped.

Fixes: 7ed2bc80074e ("net: enetc: add support for XDP_TX")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v3->v4: patch is new
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 15c48c938a4e..fe5db840d2cc 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -165,6 +165,14 @@ static void enetc_free_tx_frame(struct enetc_bdr *tx_ring,
 
 	if (tx_swbd->dma)
 		enetc_unmap_tx_buff(tx_ring, tx_swbd);
+	if (tx_swbd->is_xdp_tx) {
+		struct enetc_ndev_priv *priv = netdev_priv(tx_ring->ndev);
+		struct enetc_bdr *rx_ring;
+
+		rx_ring = enetc_rx_ring_from_xdp_tx_ring(priv, tx_ring);
+		rx_ring->xdp.xdp_tx_in_flight--;
+		__free_page(tx_swbd->page);
+	}
 
 	if (xdp_frame) {
 		xdp_return_frame(tx_swbd->xdp_frame);
-- 
2.43.0

