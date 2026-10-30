Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.146.135
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793348124;
	b=KaKBgkRzKVJ6SnpaLbQKinHuJehIviQ4hlazvTj6RBAOgd9WA5RJWxYdhX3YtA3WCqnu
	 fnTjL7+Nb2Ris60bwVWmfehNItxr7pBZsqRTrSSzhsVtubsO+UYxrJ3WndzlXLL6rQeK2
	 KjVJacNKqn2jUPr3qY+ozXZT006CqAJRq5FgOs8vZ+62CT9VIGiDfweINhDGd3kWqH9xV
	 CKxZ7IJoX3/1S9d3kTt8Hpz38niFk2gFGtdYSqWDTKwrQFFLLo0KxwP2mIchy5+2C2M/h
	 pLz799lCUgAjH71hiGg3TeuauuZUI7JyMXRE4P/YRQiEBCeizlS3Hg5g24vwttWhY4g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793348124;
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
	b=CZUTRWFedhng/Et9MrY16m6ZP3XD3Xobb48zvhUBIKGflZ560/RLegsOJGeXSGT6nlra
	 aUpIgLXiagxhqQdOko88QA3lfVvkYt+CO53wxRH48wfbtI74oWZH21gByAShJLfBIaY2C
	 qB82wR71QqcTQLIyVW6d4HwIxVJumo8JX145jJIaR1Numf9/utoIlJ22A8i77KD37Xqps
	 AhLd6PItnAr19UGL0YCjnWSYpVi6W7LaGZPFQ7d9h17TIcCxuqRN3b9nP/12NVk7lIPL/
	 4xuJSy0tyIrxsgGWKGMtBs2z+zRL80fEZ6L4CFwqdFpz6rZfAgBtFgNXW48azB5iXgw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=deeproute.ai;
	spf=pass smtp.mailfrom=deeproute.ai;
	dkim=pass header.d=deeproute.ai header.i=@deeproute.ai header.a=rsa-sha256 header.s=selector1 header.b=GN07pEkG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.146.135
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2135.outbound.protection.partner.outlook.cn [139.219.146.135])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBF9606A31E;
	Fri, 30 Oct 2026 08:15:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BBF9606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=deeproute.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deeproute.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=deeproute.ai header.i=@deeproute.ai header.a=rsa-sha256 header.s=selector1 header.b=GN07pEkG
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NzWFjlQUANJMg6q6zh7w0Rqp7+79E/7VToIBrRwlzRVPMBhrfqD939Q56C5ijKIsj9Gwjjx7lugdnjqGA4r9CXSWzDSHXwdYRhM903uiMSrP8YYgm6oBQiAyin4BxTNQf4CPqeSw//Zi39ppeo/cKWL7kB7CoKJx0mMa/UaX6VJ7eFfv9w+F6+Frl+nyYcJlXqzqQAvHUYyWhQNMZRtDiGld8Y9z5UyOz9CBA3g2dnLvW/B0rZLoIDHK9oF/r+82WwwVzy7tS1WbV63Xkma5/dQ69dHQH8XNtBhr695XHdYa2w7N2pr1D0hTQQLLzyHS5I096v10hzxPtPQXh2MX4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ure8BORdfSzZS8B1AD+zOHJsl/LI0bgNUu4AJZpvVKo=;
 b=izIJ1ol74TBmg5R5tDTNbSvIcxZUJd24funIWWPOWcSf7gtp5TFVrwBBJfJ+805I/k4HRuZ51M1R9clNs9H8ShSKzOn277Gjzwj0idJI5/Fyr/WVIvpCWB7PTHTTV/YnWBg43SQJM+SzoasECEislanox/pidHNbxfWjGs6FOP3gNaOvJGjIsyzc2GV9EHwf06NHSYWkJZle5Y4nHXzxc/9KdHnWqVqKossd/L6reOZFbsNwoQcfP2S96ycfQV7E11fivDJ8FdxzTpIRfDSlyDUt/KNrmKeByKRp3BGFekX4GI7tsn1CiDIsY4nG/mBLA1RWAVK3+ISJyvqilBhNbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=deeproute.ai; dmarc=pass action=none header.from=deeproute.ai;
 dkim=pass header.d=deeproute.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=deeproute.ai;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ure8BORdfSzZS8B1AD+zOHJsl/LI0bgNUu4AJZpvVKo=;
 b=GN07pEkGP6qmQ/qUFPj2o5DMKcjB8x1ohFHNjeRyqFdEIW2bDbrhy64ZlQRgN9Pcr1k/H951qv7X1H0JG11IcEV8XNJGj3px1++VKu0mGFW3pVFfkmhGPu0pNmIso+bugZsaeriGjhxMcBf/Wj0hSsXeyRRD+xt9L8cP2iKzSM0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=deeproute.ai;
Received: from ZQ0PR01MB0982.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1::5) by ZQ0PR01MB1239.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 08:15:13 +0000
Received: from ZQ0PR01MB0982.CHNPR01.prod.partner.outlook.cn
 ([fe80::197a:1934:4b5b:4520]) by
 ZQ0PR01MB0982.CHNPR01.prod.partner.outlook.cn ([fe80::197a:1934:4b5b:4520%3])
 with mapi id 15.21.0569.008; Fri, 30 Oct 2026 08:15:13 +0000
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
Date: Fri, 30 Oct 2026 08:14:39 +0000
Message-ID: <20261030081440.251635-2-jingxuanxie@deeproute.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261030081440.251635-1-jingxuanxie@deeproute.ai>
References: <20261030081440.251635-1-jingxuanxie@deeproute.ai>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SH0PR01CA0014.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:5::26) To ZQ0PR01MB0982.CHNPR01.prod.partner.outlook.cn
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
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB0982:EE_|ZQ0PR01MB1239:EE_
X-MS-Office365-Filtering-Correlation-Id: 67ffddcd-cf9a-44b9-46f6-08df365dec1e
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|23010399003|366016|376014|38350700014|56012099006|261028144727099003|261022105027099003|261026135527099003|261026140227099003|261026130827099003|261026121527099003|261021133027099003|261021123027099003|261022075727099003|10067099003|261021135927099003|261021121427099003|261009223027099003|261022113327099003|261021130227099003|261022115727099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	D0xQ12YIsTpss/gTznm4lfPlXlJxt+zRnU+u6QG3x6AoWvrKzwuccAYumd+gREuYQwuj6nLEu3HUl4IX4DDT/BhsN/7xDvAk4bc3y5+Jnlek3zE/7NCdqeQcJAHxc/igttAJ1DJzpcyecAgWrFMHWzLZeZMxS9SOHbAn4rW6ru4FgKozZACIY5xd8XZMKw/tXxJp9W/V4rMBg0/Ggmz/jFD6bS2nawHn8bXT2L2agDLBDLwbYcWnuU+j67M9leNBTz4SgYnkrTxYufpQjYr+tyrS8H0WVm6Qs4WoyXBpwfl7KG3i4HMPxe7cXXmti7wyn7VGiZAUOO0QJEcjCkCCfAZGEEwXHsGaA87djH5lr/CyG7TEb70F8ZdVkIBPh7F/Ik1Rglmww3iC1GbcG5elQx6ftAQJEf/qFjVdcAwTNqfBtFhB+qd1o02i4JVmrMMT6likAp0+ac8O89/l1XznsTwp2vE8vBlauHZbdg29yw9dRMboC8q61IQl/A+qAAS+fhPelmHAvcnHkBJg8ORs41JpsU2pEzdfiV++jruSCaoh/5Uv8leFvSudjzvbLTYP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB0982.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(23010399003)(366016)(376014)(38350700014)(56012099006)(261028144727099003)(261022105027099003)(261026135527099003)(261026140227099003)(261026130827099003)(261026121527099003)(261021133027099003)(261021123027099003)(261022075727099003)(10067099003)(261021135927099003)(261021121427099003)(261009223027099003)(261022113327099003)(261021130227099003)(261022115727099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EOnokMzkaGyw1G0tci+K8xmqI9cV4sy9e3YNzvLvUfS0I3Jik6DD0dNq/IAB?=
 =?us-ascii?Q?bBHbo4XoeedsyClTv4WNO2BiQzSUMJlHCE7b7I459gwf9p451nMQNNBzJPGh?=
 =?us-ascii?Q?PrPKeMwKVqLb6UWTF/lONl2X6yakXjn6BV7aCcS6hUDzS7CgbDL68+nrChcv?=
 =?us-ascii?Q?QJfN635Tj0DiFUJeuN8bjkS3belsHt7wHkv5zoCGQ5eOnImrZk7rfyJNOb9W?=
 =?us-ascii?Q?udJLHwAUc0Dnx9WfqCzfeYNSmDg+a691+kDhqRJYlNwcxduJvu+1qQGiT1m3?=
 =?us-ascii?Q?+YWS0fLMCNxXBC9TxTVkauCk7aOOS4Hyw8VXK42f7/gf6nsRpwwS97+WXfXZ?=
 =?us-ascii?Q?mtl7PDME/TKyJmJYA9l+UOQ9fD+RTp87KHTU+1a39/2rqlNSzlG55tt8Cy5U?=
 =?us-ascii?Q?ljwJvrflQvJabIwUYuCRtQFrVCL28LrBsgp52oaHKqjzFyLCnaqBI8cE8n0O?=
 =?us-ascii?Q?CwvzEQ/tvqxvfLDjM10iT6u6coIsZ2RID6Hp++ukHQXhQSdxvEW8zxGZ9un6?=
 =?us-ascii?Q?wPS9WRBxc3pwYcfwIF9EOv81qbA1tYz8Y/FjF7srP4nXlJU8eaOz7BaXtM5F?=
 =?us-ascii?Q?32diHpolrvGNOTJEIx/y61HW+uR5PkvTQWXUKBUJ1+HeJvIHvzqR7sxdsRzE?=
 =?us-ascii?Q?GmWwlxR0Fkf/AHzs1jySNJs5RJ0xjiypBWhzUZo33VHYyPhNln/iHuQQf60L?=
 =?us-ascii?Q?u0I3AokJj5CiZWfaCzXEvDXKHJUeDUkZC/nwKg4jw/wE2/3S1FwHMpuA1wrU?=
 =?us-ascii?Q?H6e6ume+QBoRW0Fq8nXPLc5SRt89I8TDn/saYv2YXiEl+ea/lvGbSq3txOlK?=
 =?us-ascii?Q?fUTlM7jepFPzdIg+C6GYg9uHX7Sae+z42YbvmnxS7xRRuQLHcbHzN6j7P0XR?=
 =?us-ascii?Q?dybWLhA8wByRUXd0mx6Vy2IgNxdQtjy3F6DzblpS6G0OO7Ei0zpsoPEijQhS?=
 =?us-ascii?Q?x+WsayR2KCh0Syt5v5SnSa+suf2Pdop3k6VfU5k1xKYxET+Pz0/L0DyVm+lE?=
 =?us-ascii?Q?BB2C0DDaBziRrOlcqOmIB917IKU6oRMG7CiAjepKaZUKI0kMqz8/TYP1DEzK?=
 =?us-ascii?Q?enhF//g7+crnkkIFyMDZoakE3evxA9/EhvUuh1KB8MnPUwn9NOyvXYoBz9e2?=
 =?us-ascii?Q?IvRXbD/5RX7rYktBQw3kqfnfCB9xXT/s+sVHG/d+ITKMNc0fSC6DzsrumJDP?=
 =?us-ascii?Q?AwgQKemAD2T1+gADXb+G73jSVOcWAWrCBupVB/IBUeFciwHUkXAbH1wNTebi?=
 =?us-ascii?Q?KtK6OjfHRnH0JWJC2/9Gx87FzSv8aY60b6++mYgAX3m2KctIuN3fbLouIwib?=
 =?us-ascii?Q?8dQc9ji3XcG0g/nYrHMFdDYIsKL3UulaCncT9u6bxhsgxfEn4Xj5wDNBGYw3?=
 =?us-ascii?Q?9155L8rbJqTc1Nh6eb7kw1lNx8FxriWYZhY9ZOCgisIpFVmuYxX58BQtMvTf?=
 =?us-ascii?Q?wS0NERNnSZEPb1Eh08paABxdRziRkzC/ONlE19RE/PEHNnbKDES+agJ1Mfav?=
 =?us-ascii?Q?q+P7ZKm4msLnhX6jS95nOaYc+ArC5ywkuVguw7ArJaW7jEk7oKG9FicAzt4q?=
 =?us-ascii?Q?9jmd/cSVJJqvocsAZib984mxmsJwCB6Ft1ZMcEmlIVqZCS0EPSNHnK/CimwC?=
 =?us-ascii?Q?AFIwOdN7CG8g+7jwBm6efSHrlrO6+QEuUKLYbEkaSUY7/1Z+Cbc51v0Uqe6m?=
 =?us-ascii?Q?q1coU0bsWzJwyy/Y1BPI9X8F0JfOlPCTMmbwMSuz3r+6rsBRPrZsoVh+aFVs?=
 =?us-ascii?Q?TLkyf20+eA=3D=3D?=
X-OriginatorOrg: deeproute.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: 67ffddcd-cf9a-44b9-46f6-08df365dec1e
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB0982.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 08:15:13.2099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: df535b4a-68e6-4339-a092-afa4f2c24fcc
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LxHeuOJ9g8GxVgsipZrvwqyD9WEUFuiV8I12DluyjSJOo4BEKZypD1O34wZjcj5tu7/i9+BoA+hMFQ7u6HGPwHqxKPfjbO8xyC8t/6iOaR4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1239

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
