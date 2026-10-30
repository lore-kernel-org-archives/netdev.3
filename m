Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.146.116
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793348247;
	b=qwK4O8XjCCyOwFiwCqcLzK90kofdavOfT8pxubdxRgY5p17UwK1p1yBz0+/W4KDLrqlW
	 xIvlVX9DYv/Bgvmz4h/w/sOvjyz72AsP6szrNlq5QD6CgfGOj/VO6bcuCiopbr3h8sROp
	 tyeHI4FEalOz744HzOz9Aq9b5mz0WRFIzDpU5tvoGuQd+Rb6bQSdXuNnB1FQ4NR1oVvvo
	 xNKIo1ilFY1PHDd5kDva6QqpHdgVQGTPf3twrtWWdZrtcvc49t8XDFEXN3W45BX+htxSi
	 5ArHsCayjk56dozOMNh3CJ6JKhnpIk7QZ8oOdd3ovLks/vWCRSDqP0lGec75QyhfLvg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793348247;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=ure8BORdfSzZS8B1AD+zOHJsl/LI0bgNUu4AJZpvVKo=;
	b=3sPuLqxaKNskK+GEbJuZUGlYjsAM30s+xGyk4vm34ztez6WlrRgxay+Z6xKS+cqhXxYa
	 oXKQ9zaxdufwo4gd1cHACk+3Sz4lIXRho2thQVzW1jcmQ0qKt6BsUc54zsCYHHTib9bU3
	 e8RNIs+OAJS47HxW41IsLu0MqEs0KJzLKovPPI/hsbx3zQ2mTeeVJDncAuIeZxmkffuRo
	 pMgqAfacLQUtJfgKuV6EUpAT8X/PTBO/IPdaM6dT4pVRUgb6xwxR41aPJqfM5eeXPiAd8
	 ORFMDOveiZz5qX180uDalZbStOJPzZhEQW8uOfz7pNdmOg1ug/FmrXqZeQD5ASgqLZA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=deeproute.ai;
	spf=pass smtp.mailfrom=deeproute.ai;
	dkim=pass header.d=deeproute.ai header.i=@deeproute.ai header.a=rsa-sha256 header.s=selector1 header.b=Psnd4VCw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.146.116
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2116.outbound.protection.partner.outlook.cn [139.219.146.116])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619CC606A31D;
	Fri, 30 Oct 2026 08:17:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 619CC606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=deeproute.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deeproute.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=deeproute.ai header.i=@deeproute.ai header.a=rsa-sha256 header.s=selector1 header.b=Psnd4VCw
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZEt5Od/lsEVfcNaFyClkenx4d+YSKnx+tmozGzS3YpaWZqlC/Roi9hR9JUtZXrO53TLgBmc+6PJ9JcD3sVs4OgGVHIpMXvi5qMgh70AyhiBEBwsFml/Deg5txOnDTAK8DC4hMk+c3CAYbbPm8eL0kBrTTZjyZ1mbUewOzsnjUtq2RjygJL4QuJs2oo6c3q2s1/N1MFIrUR6Y+2Bh6lPgHvXquqtaeD5FHHEAILQMYkx4oQ+1aNI3GqXjjd5w7jsnGT2jt6fnpz85HrPCiZSr6b8hoeTUykN359Um2Q83ho4LzFj3uzfhCEVqs3L/yc9FnJ2t4fItdPj7aPxSOUZ3Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ure8BORdfSzZS8B1AD+zOHJsl/LI0bgNUu4AJZpvVKo=;
 b=GDcTLy7oC5cbf5r5p+9O3oD1eRlkhz7KBYQbJDW21I/pk9n/1pex8cFzDm7CbUNkdktH6+VRRfR8ZEusSKxrrjIN9X69SFi5vpT4FNCJQ2Dm3YSIXRTrnNgB1/4MopZfCWspjMjXq2G1zLJxEPR2Ase+T+kVHjoeoOCKW4zsvo5yAqibaywsQdJ2DNq/tj3+BKd6WD60h0Xh518ATnMDg3dxdj962u42Uq/iMMp4Y+yeDrFZ/R9I1Dii1gd0FAStade+DjTlZEqAYATcrIcV4rSV8fNMRN/9k3DbU40h6YctY5DfAWmONjzBk0yrhblcM9VAOLim+comlRcKm72lVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=deeproute.ai; dmarc=pass action=none header.from=deeproute.ai;
 dkim=pass header.d=deeproute.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=deeproute.ai;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ure8BORdfSzZS8B1AD+zOHJsl/LI0bgNUu4AJZpvVKo=;
 b=Psnd4VCwXVhUn2pei9pe6/Kv/a//d524zAZ8L/t+dugkw2y22vCG16MREAflkHh0ZD4dOC5BGQ1YdRFlzqPkopC3/sjXZR4ZgRQg4AyPuB9O/YovK/WcgYpMPATa9bzwlYMO/Dt1rDx/T+mQmY/EgjBEA6rDDrYeMGi5sskC/M0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=deeproute.ai;
Received: from ZQ0PR01MB0982.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1::5) by ZQ0PR01MB1157.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 08:17:17 +0000
Received: from ZQ0PR01MB0982.CHNPR01.prod.partner.outlook.cn
 ([fe80::197a:1934:4b5b:4520]) by
 ZQ0PR01MB0982.CHNPR01.prod.partner.outlook.cn ([fe80::197a:1934:4b5b:4520%3])
 with mapi id 15.21.0569.008; Fri, 30 Oct 2026 08:17:17 +0000
From: Jingxuan Xie <jingxuanxie@deeproute.ai>
To: netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [RFC net v2 1/2] af_packet: prepare the virtio header before reserving an RX frame
Date: Fri, 30 Oct 2026 08:17:03 +0000
Message-ID: <20261030081704.251652-2-jingxuanxie@deeproute.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261030081704.251652-1-jingxuanxie@deeproute.ai>
References: <20261030081704.251652-1-jingxuanxie@deeproute.ai>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SH0PR01CA0008.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:5::20) To ZQ0PR01MB0982.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1::5)
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
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB0982:EE_|ZQ0PR01MB1157:EE_
X-MS-Office365-Filtering-Correlation-Id: 59b291e0-0e0f-4ac4-eb16-08df365e3643
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|52116014|376014|366016|1800799024|38350700014|56012099006|261009223027099003|261026130827099003|261026140227099003|261026135527099003|261026121527099003|261028144727099003|261021133027099003|261021135927099003|261021130227099003|261021123027099003|261022113327099003|261022105027099003|261022075727099003|261021121427099003|261022115727099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	5BXq/crFKU+rMf4YI/MbE012eVCHUqzKLNjI2gaWL4U0wlZFAG9oPaqA+I6Ss34j6o7NFjX5iFeauj1R4kPN8vfsnoPSBwYWEgQnhi0xdu2iZ5D/mcqFcKy/ghSIr/8THV2c6Ac+ya9JzplO4EUjgxU3UwhpIWRDf9rchKpzZXP11mpuQKR2nIByEkB8oohFrX0lhaR8wDIPFKUYQUsg2yp/emF7kAv+svcRYNpEdjjKj9xocpoY8t2YCXsbC+rsfrgs6xjRWWCHKS7Y/2/HG/mUb1WTCRTRnElyWXOCJFcVMl0jFSLrpMR0HOQ5AO7I+5EiZKJ3BjPsZ7RaFZbEcUyAs2wQT35rxWogfdoL2/TEnaF5NOKnxhs+JUxlaWmzs2L5zebzL5ht2j5iG6wfe4tial6cFPk+iL1tVdtKNmcSNvvN2d2Hz5IrndCH5EUfZVGRPDvvRbFyG0jNFgGrFQV6yqUrBJ1eU2zW0KACp2qQMhfLZ4hT3YZy0Syg6GxuSHP33T0bOgYwB4RzhsK59wWd4mrxSzd/dvpQhvOM1OcFebk8xwIYE/bzV+Mw3CVU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB0982.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(52116014)(376014)(366016)(1800799024)(38350700014)(56012099006)(261009223027099003)(261026130827099003)(261026140227099003)(261026135527099003)(261026121527099003)(261028144727099003)(261021133027099003)(261021135927099003)(261021130227099003)(261021123027099003)(261022113327099003)(261022105027099003)(261022075727099003)(261021121427099003)(261022115727099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cVo76Tx0AFr9I9RyBe9flte1W6MMo9Nu6yq9zURXoDm/q9EPVS5VIj1hsjlk?=
 =?us-ascii?Q?jtMcv14o6YnXpJoWJYd5dqgoMH18EftF6yiwnsNYp5bRNKYZJXTKfVgqG79w?=
 =?us-ascii?Q?57/VcchIBK6e10uD0q4bvr0AcW35gVYVSzfdUrg/303hHK9VBFaqykxe+MO2?=
 =?us-ascii?Q?hGWt+VNMzPjVsfdESmM593MEwvo1J+xGJV/UzEfNZox08J8iULmwBqANn+CS?=
 =?us-ascii?Q?ieJqb8PRVKYcyhgGfM7sQxbKP6jPjw1Uk0ELJkr3N6v/Fgyl9sCtuXglzMVm?=
 =?us-ascii?Q?RafVi+FnQgz9uAREl5KBf1Lipz9CAxzXyAGdkWEuos2CzmPcAsvnv7WiHzC/?=
 =?us-ascii?Q?heiJ39SOmvYouS8FXzO1skbYeifThIK7uz0t8BmgxdQPw0ewSLk5hmwtuk6r?=
 =?us-ascii?Q?rSRcybkF/8NGPhB2XePQ/8HYuqJeUFgyLrSmwzNNQ92Eb/sKSJdDiSVBkps+?=
 =?us-ascii?Q?LBO9x5TvMNp/YBqqLMYy/CRmddvqMHUFA8VBFLWygUw2CLSIDdu/x3ttBPQy?=
 =?us-ascii?Q?1ATFQ8UQvfToqaTIcB5dan52zGLvwTP2QWl7cPgnv3uR8U8SeSSP7ln2q51+?=
 =?us-ascii?Q?ijqadaVXOw7rF4E83AgEDjEWoekXLBOzvsenZits6MBryi/uefL4RupCNNgZ?=
 =?us-ascii?Q?jptYo1TTgLDG5qc3zlolyUCWcSBxJrgPHXW5GUa1eAM9YRd3dJC0ue5jLvky?=
 =?us-ascii?Q?qyVdvcZDdELAqhe7DALF5qJmKQJO6/UmO17haQb2Plzp64WedkZYbI+tzMnM?=
 =?us-ascii?Q?LjTIjZHuB2NBkbVUOCH2Z4YB1B291oay3T4AsMzqIi7YxR7yvEQgtXHDia1q?=
 =?us-ascii?Q?lqMEf7Hf8iEcLpbB5ObWC7SiWNrMPOrMzK3mkCg7gDYXRA4st/k1HltJijju?=
 =?us-ascii?Q?fyu4DcatoGAHnnZBh9YxpNP7e9/X43RVCdLQOpLCbenhu3mWqxrjMkQr1Oka?=
 =?us-ascii?Q?3Mb9lMyI9kK4Zx7DOQoF+NUgkc6N+0C4rzQrwyURLHyjpojYaiRlJK0xm76p?=
 =?us-ascii?Q?XYn7gNzkjgFpOpoC2LbSjbGiLUiXtrBCOasZSZd9YAg4vIB4iLuNZ8f128kM?=
 =?us-ascii?Q?OO2UKRegq2XbCMEQrxv9VlqVV/t5P8Sd7UgvZum56lJ1xSA7OLV9YU1jmbtF?=
 =?us-ascii?Q?f9kcwdjzSPZ3mMWEsblmEhLpWBFWbg0uC7L6X4SJwClDFbT6LvMdeTVzUc8J?=
 =?us-ascii?Q?wmxUBk84PIqdXfFcntjmFzK4LOR056uaFLhWz9lndGKySC/CZ9QroiToVlhr?=
 =?us-ascii?Q?0vW4VRDTkgcjlzcn6gSgahjiQQbA653pngTpVKDh1kdAP4rqzuuOjXNt+4pC?=
 =?us-ascii?Q?MX/Nxa2EACeizuQHE+BtZ8N+9s0WG2taLrbK8r14WstuUGB83ImR7IydYT3C?=
 =?us-ascii?Q?NOo6K07kFaMCf8dr1DDM088H0RZFh/uBqYg8Zvyt7WPjBblMo1gxlGbeT3Zx?=
 =?us-ascii?Q?XlzMWRz0B8mkM15WZqyj8ugAR3qLm5iMIYNUXsO5OTJLoSgVCzGqdX7q1hrd?=
 =?us-ascii?Q?XcK8Ee3yUri53738u73xlXh3Xxdp1JvRkFJ9e8GhDc/WctfKMguBJOlbzQQn?=
 =?us-ascii?Q?zEogJREn+vP73vCJeHLNW3kvwpCVjFA3MRQDkG6rrz9CSnA9ho3TomMCoG17?=
 =?us-ascii?Q?soP3xqmraEYa6WVKIFIzShdtx0cGcQxZReMLYIX5jUgjq8MaJwVU6PbucBd/?=
 =?us-ascii?Q?S0eiPSu2MzP8CuD5PICRqY3roCBQJVEkBqUxsn3bMJ7a5cuQQz5COTBjLJ5a?=
 =?us-ascii?Q?BfjeTYpTGQ=3D=3D?=
X-OriginatorOrg: deeproute.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: 59b291e0-0e0f-4ac4-eb16-08df365e3643
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB0982.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 08:17:17.5871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: df535b4a-68e6-4339-a092-afa4f2c24fcc
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uxToovAo+8OnFNA9WqPZl6k/bBbN39SxlcYKY7d6HwyOE7QgMmZssgzmGxAhUy+22pt3rHyJYG3xjIoP2DrFQlaMMlsJ7N6ncbBqBSyzzXM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1157

From: jingxuanxie <jingxuanxie@deeproute.ai>

An RX virtio-header conversion can fail after packet_current_rx_frame()
has reserved space in a TPACKET_V3 block and increased its packet count.
Releasing the copy lock on that error path does not remove the incomplete
record from the block.

Prepare the header in a local variable before reserving a frame, and copy
it to the reserved frame only after conversion succeeds. Keep drop
accounting, notification and copy_skb cleanup on conversion failure.
This also keeps conversion out of the receive queue critical section.

Assisted-by: LLM
Signed-off-by: Jingxuan Xie <jingxuanxie@deeproute.ai>
---
 net/packet/af_packet.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 823e0911c910..7b3e1e27f777 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2273,6 +2273,7 @@ static int tpacket_rcv(struct sk_buff *skb, struct ne=
t_device *dev,
 	__u32 ts_status;
 	unsigned int slot_id =3D 0;
 	int vnet_hdr_sz =3D 0;
+	struct virtio_net_hdr vnet_hdr;
=20
 	/* struct tpacket{2,3}_hdr is aligned to a multiple of TPACKET_ALIGNMENT.
 	 * We may add members to them until current aligned size without forcing
@@ -2375,6 +2376,14 @@ static int tpacket_rcv(struct sk_buff *skb, struct n=
et_device *dev,
 			vnet_hdr_sz =3D 0;
 		}
 	}
+	if (vnet_hdr_sz &&
+	    virtio_net_hdr_from_skb(skb, &vnet_hdr, vio_le(), true, 0)) {
+		drop_reason =3D SKB_DROP_REASON_PACKET_SOCK_ERROR;
+		atomic_inc(&po->tp_drops);
+		sk->sk_data_ready(sk);
+		sk_skb_reason_drop(sk, copy_skb, drop_reason);
+		goto drop_n_restore;
+	}
 	spin_lock(&sk->sk_receive_queue.lock);
 	h.raw =3D packet_current_rx_frame(po, skb,
 					TP_STATUS_KERNEL, (macoff+snaplen));
@@ -2388,16 +2397,9 @@ static int tpacket_rcv(struct sk_buff *skb, struct n=
et_device *dev,
 		__set_bit(slot_id, po->rx_ring.rx_owner_map);
 	}
=20
-	if (vnet_hdr_sz &&
-	    virtio_net_hdr_from_skb(skb, h.raw + macoff -
-				    sizeof(struct virtio_net_hdr),
-				    vio_le(), true, 0)) {
-		if (po->tp_version <=3D TPACKET_V2)
-			__clear_bit(slot_id, po->rx_ring.rx_owner_map);
-		else
-			prb_clear_blk_fill_status(&po->rx_ring);
-		goto drop_n_account;
-	}
+	if (vnet_hdr_sz)
+		memcpy(h.raw + macoff - sizeof(vnet_hdr), &vnet_hdr,
+		       sizeof(vnet_hdr));
=20
 	if (po->tp_version <=3D TPACKET_V2) {
 		packet_increment_rx_head(po, &po->rx_ring);
--=20
2.25.1
