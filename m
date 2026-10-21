Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792594475;
	b=Bcym6CwcpAmT5D9jS916O3wl/Uh1IZSQqEFv60REZa0vckAOE0DXUT8CE6zvnHzGtgis
	 U+68K99XWiJBwk5+DdQ3UoL7akWb//heUvwzLwgl9IdXjKuiM9twck9oSUQ9jMxJYa3Xm
	 AwsqReak6m5IVWYrUW7/NdW7A+EgzdoaQzOV5gE5DE7bGJBUH1BwSaJf0Uoqf7xRK6NHp
	 llQR5TslfyMPiztKbpy6sC+jVv8O6LVogJK7DIn/P/8bL/Oa51YFgKMntb+x/SzHfhX/N
	 qixJ8bavrlQTLr8wi5aShd17Wzev1MZPTs895QjERVgzKOYs9DtTMOxfyO7VkbwgnQg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792594475;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=TkMJ1BYCvN/N0QVaCkqbmQcaOeCqE3QLcb4vSP+uxng=;
	b=VV6Xv+t0/TtD/axNaVjIuORqB7co6RrTnd1JYwUgY5kGb8cXfhW8NzZ9kCL63oK3CVEY
	 xJEOuWfRuC6ECOPCi6/JMk/UnS4a5nCiLXGeuIn+R8lSsTDvKiszDSvfUWJOh6/QHZTOI
	 yxG64iR459lKNfoAbhG3j38fZewmtsxto2zep+O3xviCPVYPBB2TdsYMUGaV4wM1DNBEn
	 3SYurwiL8Z/A7e+AHXa0lNWrtrS8omjmWE8ISQak7bVxlV2aD1/f5QwPnEErFU2Yu9+fg
	 o67PKU3NgqqfLBUCbbKlGFwjM8fl9+Id0QRHrbZ0jQj21n9o/cHF+RhxCaI9poBf7iQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nxp.com;
	spf=pass smtp.mailfrom=nxp.com;
	dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=O61Q1WvR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.10
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011010.outbound.protection.outlook.com [40.107.130.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814D060A260D;
	Wed, 21 Oct 2026 14:54:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 814D060A260D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=O61Q1WvR
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qT/JOx0sMf2rl8ABsqZDnPhQcK54kNLr8CV368RUFjBK4qpKqeLlCauW2Z7hCE3M/ZfWlS2ldFby93GPaqrughNAJ6KZe1upliLxydVFUJFD+t6lxCWuw6DFD3+5vY11Rite7T/bl19hV7iKCbY3RAWuvB4yW9QWKIXw8jqTSLlx4+40pYUX9uk+owUfd0pSDckmv+UEX54fnPVNYJ63YEM+eNIc/e4C2ZF6qopimJWV8PLpbsbbj5lCR+21vpcRKkod78q4cvHiotMB7C4FAebmRLr+CB8cC+kyBstlbaS08Rb6z+/Zz9u1p5kc0glWNqS+emIp5bKFih/nU2nxcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TkMJ1BYCvN/N0QVaCkqbmQcaOeCqE3QLcb4vSP+uxng=;
 b=coe0pmJl/u/0yi6ka0z5UPVNPUiUbc3PULSsDLLul2lzpvfN/hsbmRSzp8xgyOl4n8ej46P8Ynqi+8eRuCLeLp75X6p7QfmMafd3x32K+wpJd+ln4jxvS4QFBWziP0ztex2/QwdRmGQ3EjnEKUeRNwX00re1eokGWziL8lCzqENL4F+ti++ujC33x0hl83r3FBRVYIg9wbYJyPRUSWIX3LX21YXa4kRdX67Tc2tY6pY41rNHk0QB5P/ViSGb/vMbqyjnbiTRTP2rBzsNUmyItqa59lRMLrzqIsi3Ci7zcnbAlGVJXpoueHT9Jkatw/l2o58uYXNCFzVru6Wf7yhQ6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TkMJ1BYCvN/N0QVaCkqbmQcaOeCqE3QLcb4vSP+uxng=;
 b=O61Q1WvRtNm15yVPew8YkAca7FC6Bwux5rY+ybvm+EqTF5d9It6X59u1sQAhOU+TpSnSZR5dEBnDuCbDwzpkuW255cUrLJnvkwIXTJHMyVjfqdPfqY/oEJnm35nHmmse1dxy/E44Af7LsA1CeV+bbMWQ+lrG2GGlcTh3Qinr2BZ1uF/7bbArjWVeil/sUskWlFm/jx/WyCrEHmK4N+FgzP790pREHKjKmBuNWfM+Gnjc65ZV2/TARIqd8gGcTOGvnZRMIfSabMHiMsm/4jPQogxjc+gYM81utxLPP+QfJ5bfM8hCs+ACqjDXiOeJ7bf5mojPZJ91ZAhUNkyENEzGqQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by DU4PR04MB10912.eurprd04.prod.outlook.com (2603:10a6:10:58a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 14:54:33 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 14:54:33 +0000
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
Subject: [PATCH v5 net 4/4] net: enetc: pad short XDP frames in software
Date: Wed, 21 Oct 2026 17:53:14 +0300
Message-ID: <20261021145314.1435049-5-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021145314.1435049-1-vladimir.oltean@nxp.com>
References: <20261021145314.1435049-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P251CA0027.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::32) To AM0PR04MB6900.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|DU4PR04MB10912:EE_
X-MS-Office365-Filtering-Correlation-Id: 758c15c9-114d-4fea-da38-08df2f833793
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|23010399003|7416014|376014|1800799024|18002099003|10067099003|22082099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	ebAnNDUU9i6O6EwKZFBK2k03AR37bVZYdBnxnRDM7j2neAj3AxvyDsLz3MxhMz56q3fH8muyQH0WzSPcmlRdHnBSW/i6gY3XCjc3pOf+F0l+CrNcKHMf9Xs6aPErJueQE/deCs5ziu+QQycdp//JR5myVji7zN9wYzhl84aUCOH/s9YJC4xR2Q0lpzqghcwZyXLpF1Gz1dkBJ+7X46DOQSeqlPo4cs5JBIiQZOIHuP7e+Un6x9lLwX2r6Djjm441bf5r6ARZhsGY2RO8eqBM+5TNBFksQcAB3D72+kX8klEL6Htqs2CVabTBQNVYDnYjXXb1svkP4vj7ntdT1nWana79Bdyq+Yu4blevlVwjCU1ETN6GCYPQWt4vuhgNAgC/C+9hTHyyBZO6UA4km9ymBChZSc4EDhAOOWRi5wUKgcR0J13RwoI/FS1oo204x3n+OG155jTvHtvcyJ7/F2B8pvr0a/7Av85ysE8X27i/HaYdk245+9zlrBqc4LEFNzfHMRIw6wuIiZqEfGkYqWGa8y/8KkV9+xGIdVyOO/yRW9/eAJr18adf+nw6LTv2cGKe5n1o0mDmvoQLwVQ+kNsZuYhSdxZdVpJDej7ZWdZGDD61MlQZYdiLrEFi61iD13OzM5ktmB3si90ZXvKWAWDfkSccnAPyPCd+CDh5YrVI3uc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(23010399003)(7416014)(376014)(1800799024)(18002099003)(10067099003)(22082099003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WUUGWusgZXi49027L2PybEecbSUHs5xUBikUhEJKQY4yRTO4OF0UJtmOXL1V?=
 =?us-ascii?Q?xK50XpR+efjvB5A/9LuzgHfwy6HbbXkdcD7EKSQFGTKtYMBIyPayg6bDil6l?=
 =?us-ascii?Q?rB32i2zRSaSxCz5DCCmVdLfmzJuadFzAWeBZ9UyfzByJZ9LB+j3E6KX1lWay?=
 =?us-ascii?Q?ZTtjtQ/eAQxZcymncPU/64izQtJzWOqKLJxMKajODzMMFJw6PX4w4QLxzS7H?=
 =?us-ascii?Q?Ka0u/f0sZ4h/wi2968fqAQDntuvyjsj9GbxeYjszqeFXhQDPAutu6HlJ2cmy?=
 =?us-ascii?Q?dJqe6lDvggevzuxeylANjFbWWn6uTlWvB7g1NMns1LE+bHORcFvK5TC6nyYm?=
 =?us-ascii?Q?t3CiGBwtl/g+uRfygqW/p1r73WnLjRt/PiZSWt4MmUw+QqTCvl15wpxH0UNt?=
 =?us-ascii?Q?sXha5H6X9tbIsNk5tm6jnkMzOV/YzlXxUnuMOG1IVbi/KRli/zCSTo3/89rd?=
 =?us-ascii?Q?wJlMrGmQwKk3KfYadqMkU7Qm9e5e5ny1+zsPjqlHrquFX0NaWXFjFyfVrixz?=
 =?us-ascii?Q?Ix9WGAlOp/HYzhM407agIXLO37GE3YzWbNdEKYbHFjRRcyBZoMh1hsSWqFN4?=
 =?us-ascii?Q?s08rqUrE7d482CHlgF/BLepGU0S2VBTZofCRJ8FeADpfaHTiTMrbhgKQ0gRU?=
 =?us-ascii?Q?6r47/r6y/ua6q1jGIbUJ/2qfTRosdjZFTGZapPYYNxnQI+xmfJrdB7D72TVu?=
 =?us-ascii?Q?0Axhjw8xaOWs4yQEULWlqSWZglDKjzPRaMFS+m8n2ACTK18nExc0Zz41ObxM?=
 =?us-ascii?Q?QhfbzwYAnDdxyY0QfykTwWrbxHw5FKAkY7y3HZ9s3ntPA1rnCxfuYvIz258V?=
 =?us-ascii?Q?nFexZJKti++6ibZlveYcUS5VgtA3McqDbtzsNPqjGuZXjB/IHyjI4zleL7c+?=
 =?us-ascii?Q?QTJgrOp1fdGsXvJn3wrr8OpHiNHK2qT+1uOg5WgdBwLG6LA533mcDE1exj7L?=
 =?us-ascii?Q?DWKs78VpTqacnHNCRmZFPv0LJrVABrAI0dtuPKvhLdd7jnjHAig8ullXFi6R?=
 =?us-ascii?Q?XMnyMQF9eZfBGuVHoZQnp58i/LOthehLBaDpSnW52ZbQM8bff/CO7Qxtcskc?=
 =?us-ascii?Q?lBPLUWGBlRzOGUVH1RIc+LFmkEXNEZZXSE8NF0QsCN32OVl8PB9sBHh2AraE?=
 =?us-ascii?Q?yO55O+Yh63TNmTPdnogtHDleY4pfNl9RxnKfVp6uodfgtS1PCPpXvFmgazdM?=
 =?us-ascii?Q?fBNVMl/YYaDiLwi6XrYFAo1COsIh+bcCCq4Z/SIIqEYNPrs4NNsf2izEiy+z?=
 =?us-ascii?Q?VAGcDSxBa+hWxnhEbIlwpGTswr6I3zylN1gg6iQqBI0j855y/3IoseyEq0QQ?=
 =?us-ascii?Q?qh6V8pAwPjc9wDA7B0EnnmOzJdRlvATbFstJLma/Xq9o0rSf19aaRP/83O1e?=
 =?us-ascii?Q?UM4Ffpfjm2GNPfv+zuWfd846VJzT4w0n9SLmJ+tZ6bzMLRQt9omGrnAcijZ8?=
 =?us-ascii?Q?idjlvSR//6TTFOm8E9BjTDoRR4vDXP+CjjJCcRok9cAvfhZw+1b95tm7nd7U?=
 =?us-ascii?Q?RT+nZZAb4HjD2dZB/me1DImoCCQjk0Rxjcj5XL65KCyk0+hncZtxFjZScJ9G?=
 =?us-ascii?Q?jU2zazA9r272HyhVHGe4lZqXwMUd72UxWczxDeRBgX1rro7arP/dPkWGK3zT?=
 =?us-ascii?Q?ogehH9t35wRkF/h796FXRRHZ/MIWXeYG+9DrP+AyZQ+cHyECU5dEhGgch5C/?=
 =?us-ascii?Q?rC6E9PWs2WpRvwoB0szGTzWnrn4vpnqQr+Yltdv91SCObYVe93jB0KOeU77o?=
 =?us-ascii?Q?Q07wejpimA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 758c15c9-114d-4fea-da38-08df2f833793
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 14:54:33.0533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9P2/WpYHI1eVsbelunYvToYzTx1Etjf9OGIx4tQjVGqsHK9D6vBqfrlr6gCMlVh67QBeIz4w/0L8uZVIxEXdDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10912

Similar to the skb path, the XDP transmit path may put frames shorter
than ETH_ZLEN in the TX ring, and may put frames whose first buffer is
shorter than 16 bytes. The former relies on mEMAC hardware padding,
which we no longer want to rely upon, and the latter is not supported
by ENETC at all.

There are two callers of enetc_xdp_tx():

- ndo_xdp_xmit(), which can transmit short frames for example when
  redirecting from a veth interface pair through a devmap.

- XDP_TX from enetc_clean_rx_ring_xdp(). With RX VLAN extraction
  enabled (the default), a minimum-sized VLAN-tagged frame is 56 bytes
  long when it is sent back, and once the driver honours
  bpf_xdp_adjust_tail() and bpf_xdp_adjust_head() for XDP_TX (to be
  addressed separately), the BPF program can make the frame arbitrarily
  short.

Handle both in enetc_xdp_tx(). When the frame is shorter than ETH_ZLEN,
append a BD pointing to the shared read-only tx_pad zero buffer, the
same as for short TSO segments, and advertise the padded frame length
in the BDs. The pad BD becomes the frame's last BD, so the F flag, the
is_eof marker and the xdp_frame pointer (for XDP_REDIRECT) move onto
it. The pad BD has no DMA mapping of its own, and it is not an XDP_TX
buffer, so TX completion neither unmaps nor recycles it. It is also not
accounted in xdp_tx_in_flight, which counts RX buffers.

The 16 byte limitation for the first buffer cannot be addressed by the
pad BD, so frames with a head buffer shorter than that are dropped.
Both callers already treat a false return code from enetc_xdp_tx() as
a drop.

Doing this in the driver rather than padding the xdp_frame in place
also covers multi-buffer frames shorter than ETH_ZLEN, and avoids
writing to the tailroom of buffers that, in the XDP_TX case, are
recycled into the RX ring.

Fixes: 7ed2bc80074e ("net: enetc: add support for XDP_TX")
Fixes: 9d2b68cc108d ("net: enetc: add support for XDP_REDIRECT")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v4->v5: none
v3->v4:
- patch is new. It replaces "net: enetc: pad short XDP frames coming
  from devmap", which padded the xdp_frame in place using a new generic
  xdp_frame_pad() helper, and only covered ndo_xdp_xmit(). The XDP_TX
  path is now covered too, using the tx_pad buffer instead.
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 36 +++++++++++++++++---
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 58a88f15fa5d..275441c2ffa3 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -1759,8 +1759,11 @@ static bool enetc_xdp_tx(struct enetc_bdr *tx_ring,
 {
 	struct enetc_tx_swbd *tmp_tx_swbd = xdp_tx_arr;
 	int i, k, frm_len = tmp_tx_swbd->len;
+	struct enetc_tx_swbd *last_swbd;
+	int pad_len;
 
-	if (unlikely(enetc_bd_unused(tx_ring) < ENETC_TXBDS_NEEDED(num_tx_swbd)))
+	/* Hardware does not support a first buffer size of less than 16 bytes */
+	if (unlikely(xdp_tx_arr[0].len < ENETC_MIN_BUFF_SIZE))
 		return false;
 
 	while (unlikely(!tmp_tx_swbd->is_eof)) {
@@ -1768,15 +1771,24 @@ static bool enetc_xdp_tx(struct enetc_bdr *tx_ring,
 		frm_len += tmp_tx_swbd->len;
 	}
 
+	/* Pad frames below ETH_ZLEN so the mEMAC does not pad them. */
+	pad_len = max_t(int, ETH_ZLEN - frm_len, 0);
+
+	if (unlikely(enetc_bd_unused(tx_ring) <
+		     ENETC_TXBDS_NEEDED(num_tx_swbd + !!pad_len)))
+		return false;
+
 	i = tx_ring->next_to_use;
 
 	for (k = 0; k < num_tx_swbd; k++) {
 		struct enetc_tx_swbd *xdp_tx_swbd = &xdp_tx_arr[k];
 
-		enetc_xdp_map_tx_buff(tx_ring, i, xdp_tx_swbd, frm_len);
+		enetc_xdp_map_tx_buff(tx_ring, i, xdp_tx_swbd,
+				      frm_len + pad_len);
+		last_swbd = &tx_ring->tx_swbd[i];
 
-		/* last BD needs 'F' bit set */
-		if (xdp_tx_swbd->is_eof) {
+		/* last BD needs 'F' bit set, unless a pad BD follows */
+		if (xdp_tx_swbd->is_eof && !pad_len) {
 			union enetc_tx_bd *txbd = ENETC_TXBD(*tx_ring, i);
 
 			txbd->flags = ENETC_TXBD_FLAGS_F;
@@ -1785,6 +1797,22 @@ static bool enetc_xdp_tx(struct enetc_bdr *tx_ring,
 		enetc_bdr_idx_inc(tx_ring, &i);
 	}
 
+	/* The pad BD becomes the last one, so it takes over the xdp_frame
+	 * (if any) from the last data BD. The pad BD has no DMA mapping of
+	 * its own, and it is not an XDP_TX buffer to be recycled.
+	 */
+	if (unlikely(pad_len)) {
+		struct enetc_tx_swbd *pad_swbd = &tx_ring->tx_swbd[i];
+
+		enetc_append_tx_pad(tx_ring, i, pad_len);
+		pad_swbd->is_xdp_redirect = last_swbd->is_xdp_redirect;
+		pad_swbd->xdp_frame = last_swbd->xdp_frame;
+		last_swbd->xdp_frame = NULL;
+		last_swbd->is_eof = false;
+
+		enetc_bdr_idx_inc(tx_ring, &i);
+	}
+
 	tx_ring->next_to_use = i;
 
 	return true;
-- 
2.43.0

