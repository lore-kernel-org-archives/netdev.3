Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.146.116
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793348248;
	b=bCJl6QgAtZYo934Q/3UFIzhg6B5sPuFSpzjVKfq2R41y5E1aqqjATCGT+lxnn8NUsFCF
	 i/SRZGxJKFYW28ht21E2FyTMvQLbxwPikfbtsdF14KL0WegewOysPbPBPBrNY2nhV0mtf
	 M2BDciWWY6SZ+kjG4BuIPVa3V3P0vPfkYMxjz68aA6FUDvNr8xIcaqaSksw0UpAhEatTB
	 SVGF6UinPBgiWVF4KFnCDlEYOsGfwD1RNym49t5Aoj+LEvxbh4PizM6PQWbSeQwiKR6pS
	 HpMq/0WCEQyl3DZT4KpOSx3MPyX5jnOl2v4rdl4IDlMeM+azKqBiLwZL49t4/Xb/nNg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793348248;
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
	bh=Vs40igkL5P2cJQoPaXrEskF//A/4BPaH1mGjhzFQfb8=;
	b=Wsb+M9IRGeGNNY7dK+RYVXEEatxsQcMXDA3tcpPJNNBcPqPsbm1+YIxFDxrWImclOOb2
	 LSt2m1tFUznlgEQattzWenNDiu03gnZ98CMLciDUm5g3Ri1PHIaKSDG7R8uaveToV0mvX
	 sf5io69wojG2o0sLbSi00fXzwPxYQRRKBVeS2MeDJVTkZ1UjzgwprapXQKqeWpoIRZm4U
	 Ug8IcFtaS/UQgW9UeZsGtMZDDS5WV1AgjAnvCeRnxVwm0x72yfAT+Y+ao57RXu/sbQl1J
	 z/CNUDbdHJ9Jpw5uv/G2xLDrGY/B0G3oauOMYV9LUUPH69GTfTiw+k2THtiyZLn8j/g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=deeproute.ai;
	spf=pass smtp.mailfrom=deeproute.ai;
	dkim=pass header.d=deeproute.ai header.i=@deeproute.ai header.a=rsa-sha256 header.s=selector1 header.b=dxqtqKaV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.146.116
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2116.outbound.protection.partner.outlook.cn [139.219.146.116])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BB4606A325;
	Fri, 30 Oct 2026 08:17:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6BB4606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=deeproute.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deeproute.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=deeproute.ai header.i=@deeproute.ai header.a=rsa-sha256 header.s=selector1 header.b=dxqtqKaV
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mxycHYDtTo5tr/GqArpMzJ6ZLYp1l0zSxA7BuAEy742sITpHMXRacyIZ6enF3gQQp1pVzhOtGBMjm8NjNESPO9VDW+w840pkJ6vOZ5J2guLK7CgWuNlxQvHI7ndBSJenSBmV9Ljh2TMbzq26DumjnrQkrQ3hkJRrYGnEoaXI4EMLFwZ1zrHsz/Rs2unFVDFetbuxOXsGPp3XXBl9YLirlqHWLT5yR0NWVBW0SnosSpaL/hcvY/3HkLxDfT0ArRGFb3wCt54XL7qjynNkfFWP2Xd4JPhannoDf0aJVOO/IsgHTE6XhxoLAWMqqXdsQjyuMyRyjBdge/xvGa9lTaEC8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vs40igkL5P2cJQoPaXrEskF//A/4BPaH1mGjhzFQfb8=;
 b=coAb3slTce+rtCRVobwuzLGJjGNIMhSFjBByoIR+cHu5OVpIHLiV+FywR4htxix2FdZ7eMT/uidr4X4GNntBKBSA6Tb93hNPuyCYicd2wTJQhda0dLLamMlyMnNhsFQN/U2m9zIw5wBdwWLGYaKpGaFwrJKDTEFecNjetzS941vsA7cG2eUGKKuM5buFkMkHZEgYwIDgIu3kunNLwftiPU8JiQxlq1qpH4u/BIhdaIR5usDPPs4vv38yzp7z7H/1J+hiVhCPcedvhAq356xKR4W1dxPd9zQ53xsCysFQuyY+Sc4HN0JSmGpkE9Q59unndQ0uhTCIQDwXYYDHkqXNDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=deeproute.ai; dmarc=pass action=none header.from=deeproute.ai;
 dkim=pass header.d=deeproute.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=deeproute.ai;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vs40igkL5P2cJQoPaXrEskF//A/4BPaH1mGjhzFQfb8=;
 b=dxqtqKaVYgft71rwifYvnrTtSi+zLnYbmRyZog5MiDs+Ltnv2GETRAC8jw0US9YAFPqF2xEe1hJDEUVzvDnPFqruwf5Fts+qG9ngY+LKWF9i4iC+fidu8MoDJP8Di7llLWffSXKsKKPEqkrgbi71AxPQ24jgRT21Nvcfo7NrKrg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=deeproute.ai;
Received: from ZQ0PR01MB0982.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1::5) by ZQ0PR01MB1157.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 08:17:18 +0000
Received: from ZQ0PR01MB0982.CHNPR01.prod.partner.outlook.cn
 ([fe80::197a:1934:4b5b:4520]) by
 ZQ0PR01MB0982.CHNPR01.prod.partner.outlook.cn ([fe80::197a:1934:4b5b:4520%3])
 with mapi id 15.21.0569.008; Fri, 30 Oct 2026 08:17:18 +0000
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
Subject: [RFC net v2 2/2] af_packet: retire TPACKET_V3 blocks without waiting for copiers
Date: Fri, 30 Oct 2026 08:17:04 +0000
Message-ID: <20261030081704.251652-3-jingxuanxie@deeproute.ai>
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
X-MS-Office365-Filtering-Correlation-Id: a2fd6171-b403-431f-ec63-08df365e36ed
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|52116014|376014|366016|1800799024|38350700014|5023799004|56012099006|261009223027099003|261026140227099003|261026121527099003|261028144727099003|261021123027099003|261022105027099003|261022075727099003|261021121427099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	t8mt0AAPUUZE43jibxoALoUmlu1K4nUl8BqVRJpK2Nauvy8nW77fOeTJMtAw/CqegicsfM03iuFfgwRVLBHTmlfr56CpM4QNhQGSXDSBRKqPUIkvDV1jbX+qcrWzK1SPDo/GjuRz9Kzajh/trAykfOMEizh336yzY0hvwNKBEPOsubFXV6JenSjyWRjcwztLqP7eh3aERw/h65DjklzvdI947QTZPOrd1JZKBQNv0dqPD+AOWBzrZ3euVlgUlZYza/+ddkNTB6YnvNxm2n6q1H/ZgF2IL1q1X+yaIvXL+s2kvUJRQcUYKJ27JybPOo1tSgk+gr4YGykkuW82+T9aeGQC2B50k5ZK3oIk4XyxpMySmd2pEZRbtPi11w0oMpZgXi0SQGRxxqiVmTzXLQzQ4R4kR59T6ookFfZICAF/iCzmCpFdHGDyAJ3DgbTe+bTaIpNO81XlsHn3oJe0DAUIfq/6RY3F998kZiT37ngOLbIqB00pKQAKOvpDCWMO4PZUmYSznvpDArJL2j7tADLTPvb7hG69A+5dquvH2s+OQTSyc6V32zcmNJxLo+J6Kajj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB0982.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(52116014)(376014)(366016)(1800799024)(38350700014)(5023799004)(56012099006)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261021123027099003)(261022105027099003)(261022075727099003)(261021121427099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eZOD//wXa6EaiNro4hnka/DdJNuldApFvtCPFiQZBima1SOEVjfSfQnJTsYe?=
 =?us-ascii?Q?PEkrEw+mv5EYEEn8GmxOl7uSTHpEGNS6S+cRpp9W+4G+kXRujFF/CXLeGB/8?=
 =?us-ascii?Q?kGjgKV17LYmYM5uvLH0S8vzCsGy5IC/GebyN97FlLCYGzf7sO0E7rjsRZ6m3?=
 =?us-ascii?Q?a/3pABNJt1/m7BaBmj0crehDRM+ZTB+JWpVlUrHsnaIJ4uVwOS5Op8SuLV8m?=
 =?us-ascii?Q?T50csurdJfHoJNXCaNKjD96Ye1CdA+mK+vWbVjl1CMan31eiP7t+532Ya0PI?=
 =?us-ascii?Q?QuriJmkdJFqAQa3wpLscJBJxsWm98Z5EmaTbWMtEyX9ZF4Q7mrdQ7lLyyPfD?=
 =?us-ascii?Q?pitJEEH2vAkSFq5OkVQd4PGpa6O2G8GfNWD1oh7EwbVJTBDvaIS6L+jFJdrt?=
 =?us-ascii?Q?6hDEjnTgjFEctrow61wba5LhoacNbQTduXnyUiIfP+/3oeCfiDiBgO+GExvo?=
 =?us-ascii?Q?VN/zh7TH95Z5z1Ju4SO3oZrbJePBpCzbswx1+G75O2z5o8VvM/Ak/+jXXbsM?=
 =?us-ascii?Q?bpQx8wn2xGF0BBFf0QHqFAguDDe+AfjoW/snCUtljSoc9al563mAFsIlmGli?=
 =?us-ascii?Q?nx68w575wsATZIsFsbUuNGg7Z/gr3yVwcRulAvHMEyF4VVjFhBUy1YzJmyXd?=
 =?us-ascii?Q?+X10uQpoCLE7nefSDJSnWpLS4H6GWON1oUK+PlXB67ZiKOfl9tgT7VQw6Ee2?=
 =?us-ascii?Q?Xuy6O7pU7gJyIw0XYIk2B7RLJCdY0svmdUqxuLZ7KScYpyQwkHFTaplr3laX?=
 =?us-ascii?Q?jCRMsPaOzJPXqa58MWmBWT0NOf1AzD4wMidZeT3ZAaKmqf6l5Mre+0RsgydB?=
 =?us-ascii?Q?gGzbVc4Ug49GjpljrxsDg1TVt+2uDgskTTa9BCiIGrKRTfB16vqFvHuOWwN1?=
 =?us-ascii?Q?QaJtOWM0iV8bzW3WvkV/LF+iu430i0D+revE3oG26ZvrbY4YT4eCkiwLBx4w?=
 =?us-ascii?Q?Kxr/jqJ+bxDYDjYoEEeRZOWTG5G3OAvTOA0zS19HavbTW+8oijMsjYTGXJPv?=
 =?us-ascii?Q?0KVGfuMR+M4U02FD60NzxGGUV6nUF9ZXrPheHOGoLb3mlUQ30sxDv9GKEjh9?=
 =?us-ascii?Q?b6m0/coDnlasBTllNLicCWX9I++jmqtrscPbEmwOzSo6yJlkGeBJPbLsBRFW?=
 =?us-ascii?Q?A/ahdCI1e+ysugeiufpIni0sfkU+rXtiCMbhfI/t9IOdU3ArtdG6xVQJUENi?=
 =?us-ascii?Q?OsVUbAOLpSrKBwAIy0cKeRXK5pASDiajo/1GXyvxkGrxPi793CqoqxPnzzMX?=
 =?us-ascii?Q?NEH/Dwv9S+WhbbYGyZX8Sgl5WhXO7SZLlEn9Jz4/tjWbNMx389OiViF736Qu?=
 =?us-ascii?Q?UvJgoV2GZQ81/C1FJi+mZEe+lMeGmZctKcfCtUceC5Me9BtrwjwyGdA2Sx27?=
 =?us-ascii?Q?NP2GLxBcnCYvFA5FyIfEZdjWhJtTXlNaTVTpaG5pmglCtkPJpZLvhfC3WyU+?=
 =?us-ascii?Q?EvZcA435nrgYEuucZLD2ZHX6JcBuqtoM3pLI43oyzUigkuFxvg6MmIzqz3Fm?=
 =?us-ascii?Q?d3vEMiN5TdEAwuUIKw/FjQYhOskl/98QsHP9X1Kr3UEq5KdrcYTEoMNiFT8z?=
 =?us-ascii?Q?e5ClTD7uEzqDj8+1HXGg8Yp4HiIV09cruy/qqExedgdh609eB4+YRLL/G+pu?=
 =?us-ascii?Q?UKlpc8L9CPoj2GBp5lkDzSQ7J/t9+WBvEZ7XZlQWupZFR9IGD9GmWquFgv9c?=
 =?us-ascii?Q?WLGILR69Hg6UMFY3vo8ZInPRx/smTikrz0i5GSIyWr528IoCI6+0JE7MxZva?=
 =?us-ascii?Q?lefVu5xeWw=3D=3D?=
X-OriginatorOrg: deeproute.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: a2fd6171-b403-431f-ec63-08df365e36ed
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB0982.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 08:17:18.7113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: df535b4a-68e6-4339-a092-afa4f2c24fcc
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y11tNmQGGw5B+sNvgNTDZmzXKHKAWwEud/3SDPd7Gc8Ry16ypIQnLGW5LE5H/qd18zBmANpu16ytXCnbOfn7/wLuorMAQt4IF0eh4wDt46M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1157

From: jingxuanxie <jingxuanxie@deeproute.ai>

TPACKET_V3 waits for a ring-wide read lock while holding the receive
queue lock before retiring a block. On PREEMPT_RT a preempted copier
can delay another packet path or the retirement timer until it runs
again. This was investigated after an approximately 355 ms retirement
wait in a PREEMPT_RT deployment.

Keep copy accounting in each block's existing private pgv descriptor.
Seal a full or expired block and advance to the next block without
waiting. Retain the original descriptor across copying and release its
copy reference after all packet data and headers have been written.
Publish sealed blocks in order when an acquire read observes no copies.

Publication runs under the existing receive queue lock in packet
allocation and timer paths. Completion does not reacquire that lock.
No worker or publication budget is needed. When traffic stops, completed
blocks may remain unpublished until the next timer callback; this does
not promise a hard capture delivery deadline. Ring exhaustion can still
drop capture copies.

Use each retired block's saved last packet and its own cache-flush range,
and exclude sealed blocks from allocation and fanout space checks. Poll
uses the publication cursor instead of the producer cursor. Widen the
producer index to cover the same block count as the publication index.
Allow an exactly fitting record so a maximum-size first record cannot
cause an empty block to be reopened instead of advancing publication.

Reproduction uses a QEMU ARM64 SMP PREEMPT_RT kernel with validation-only
instrumentation delaying an outgoing copier after frame reservation.
The instrumentation is excluded from these patches.

Fixes: 632ca50f2cbd ("af_packet: TPACKET_V3: replace busy-wait loop")
Assisted-by: LLM
Signed-off-by: Jingxuan Xie <jingxuanxie@deeproute.ai>
---
 net/packet/af_packet.c | 140 ++++++++++++++++++++---------------------
 net/packet/internal.h  |   9 ++-
 2 files changed, 76 insertions(+), 73 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 7b3e1e27f777..5bc486326be9 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -197,7 +197,7 @@ static void *packet_previous_frame(struct packet_sock *=
po,
 		struct packet_ring_buffer *rb,
 		int status);
 static void packet_increment_head(struct packet_ring_buffer *buff);
-static int prb_curr_blk_in_use(struct tpacket_block_desc *);
+static int prb_curr_blk_in_use(struct tpacket_kbdq_core *);
 static void *prb_dispatch_next_block(struct tpacket_kbdq_core *,
 			struct packet_sock *);
 static void prb_retire_current_block(struct tpacket_kbdq_core *,
@@ -205,6 +205,7 @@ static void prb_retire_current_block(struct tpacket_kbd=
q_core *,
 static int prb_queue_frozen(struct tpacket_kbdq_core *);
 static void prb_open_block(struct tpacket_kbdq_core *,
 		struct tpacket_block_desc *);
+static void prb_publish_blocks(struct tpacket_kbdq_core *, struct packet_s=
ock *);
 static enum hrtimer_restart prb_retire_rx_blk_timer_expired(struct hrtimer=
 *);
 static void prb_fill_rxhash(struct tpacket_kbdq_core *, struct tpacket3_hd=
r *);
 static void prb_clear_rxhash(struct tpacket_kbdq_core *,
@@ -666,7 +667,6 @@ static void init_prb_bdqc(struct packet_sock *po,
 		p1->interval_ktime =3D ms_to_ktime(prb_calc_retire_blk_tmo(po,
 						 req_u->req3.tp_block_size));
 	p1->blk_sizeof_priv =3D req_u->req3.tp_sizeof_priv;
-	rwlock_init(&p1->blk_fill_in_prog_lock);
=20
 	p1->max_frame_len =3D p1->kblk_size - BLK_PLUS_PRIV(p1->blk_sizeof_priv);
 	prb_init_ft_ops(p1, req_u);
@@ -697,25 +697,11 @@ static enum hrtimer_restart prb_retire_rx_blk_timer_e=
xpired(struct hrtimer *t)
 	struct tpacket_block_desc *pbd;
=20
 	spin_lock(&po->sk.sk_receive_queue.lock);
+	prb_publish_blocks(pkc, po);
=20
 	frozen =3D prb_queue_frozen(pkc);
 	pbd =3D GET_CURR_PBLOCK_DESC_FROM_CORE(pkc);
=20
-	/* We only need to plug the race when the block is partially filled.
-	 * tpacket_rcv:
-	 *		lock(); increment BLOCK_NUM_PKTS; unlock()
-	 *		copy_bits() is in progress ...
-	 *		timer fires on other cpu:
-	 *		we can't retire the current block because copy_bits
-	 *		is in progress.
-	 *
-	 */
-	if (BLOCK_NUM_PKTS(pbd)) {
-		/* Waiting for skb_copy_bits to finish... */
-		write_lock(&pkc->blk_fill_in_prog_lock);
-		write_unlock(&pkc->blk_fill_in_prog_lock);
-	}
-
 	if (!frozen) {
 		if (BLOCK_NUM_PKTS(pbd)) {
 			/* Not an empty block. Need retire the block. */
@@ -726,7 +712,7 @@ static enum hrtimer_restart prb_retire_rx_blk_timer_exp=
ired(struct hrtimer *t)
 		/* Case 1. Queue was frozen because user-space was
 		 * lagging behind.
 		 */
-		if (!prb_curr_blk_in_use(pbd)) {
+		if (!prb_curr_blk_in_use(pkc)) {
 			/* Case 2. queue was frozen,user-space caught up,
 			 * now the link went idle && the timer fired.
 			 * We don't have a block to close.So we open this
@@ -756,7 +742,7 @@ static void prb_flush_block(struct tpacket_kbdq_core *p=
kc1,
 	/* Skip the block header(we know header WILL fit in 4K) */
 	start +=3D PAGE_SIZE;
=20
-	end =3D (u8 *)PAGE_ALIGN((unsigned long)pkc1->pkblk_end);
+	end =3D (u8 *)PAGE_ALIGN((unsigned long)pbd1 + pkc1->kblk_size);
 	for (; start < end; start +=3D PAGE_SIZE)
 		flush_dcache_page(pgv_to_page(start));
=20
@@ -777,15 +763,7 @@ static void prb_flush_block(struct tpacket_kbdq_core *=
pkc1,
 #endif
 }
=20
-/*
- * Side effect:
- *
- * 1) flush the block
- * 2) Increment active_blk_num
- *
- * Note:We DONT refresh the timer on purpose.
- *	Because almost always the next block will be opened.
- */
+/* The producer may already be filling another block. */
 static void prb_close_block(struct tpacket_kbdq_core *pkc1,
 		struct tpacket_block_desc *pbd1,
 		struct packet_sock *po, unsigned int stat)
@@ -799,7 +777,7 @@ static void prb_close_block(struct tpacket_kbdq_core *p=
kc1,
 	if (atomic_read(&po->tp_drops))
 		status |=3D TP_STATUS_LOSING;
=20
-	last_pkt =3D (struct tpacket3_hdr *)pkc1->prev;
+	last_pkt =3D pkc1->pkbdq[pkc1->publish_blk_num].last_pkt;
 	last_pkt->tp_next_offset =3D 0;
=20
 	/* Get the ts of the last pkt */
@@ -824,8 +802,27 @@ static void prb_close_block(struct tpacket_kbdq_core *=
pkc1,
 	prb_flush_block(pkc1, pbd1, status);
=20
 	sk->sk_data_ready(sk);
+}
+
+/* Caller holds the receive queue lock. Never wait for unfinished copies. =
*/
+static void prb_publish_blocks(struct tpacket_kbdq_core *pkc,
+			       struct packet_sock *po)
+{
+	unsigned int pending =3D pkc->pending_blocks;
+
+	while (pending--) {
+		struct pgv *block =3D &pkc->pkbdq[pkc->publish_blk_num];
+		struct tpacket_block_desc *pbd =3D (void *)block->buffer;
=20
-	pkc1->kactive_blk_num =3D GET_NEXT_PRB_BLK_NUM(pkc1);
+		/* Pairs with the release decrement after every completed copy. */
+		if (atomic_read_acquire(&block->in_flight))
+			break;
+		prb_close_block(pkc, pbd, po, block->retire_status);
+		WRITE_ONCE(block->last_pkt, NULL);
+		if (++pkc->publish_blk_num =3D=3D pkc->knum_blocks)
+			pkc->publish_blk_num =3D 0;
+		pkc->pending_blocks--;
+	}
 }
=20
 static void prb_thaw_queue(struct tpacket_kbdq_core *pkc)
@@ -852,6 +849,7 @@ static void prb_open_block(struct tpacket_kbdq_core *pk=
c1,
 {
 	struct timespec64 ts;
 	struct tpacket_hdr_v1 *h1 =3D &pbd1->hdr.bh1;
+	struct pgv *block =3D &pkc1->pkbdq[pkc1->kactive_blk_num];
=20
 	smp_rmb();
=20
@@ -877,6 +875,7 @@ static void prb_open_block(struct tpacket_kbdq_core *pk=
c1,
 	pbd1->version =3D pkc1->version;
 	pkc1->prev =3D pkc1->nxt_offset;
 	pkc1->pkblk_end =3D pkc1->pkblk_start + pkc1->kblk_size;
+	atomic_set(&block->in_flight, 0);
=20
 	prb_thaw_queue(pkc1);
=20
@@ -932,7 +931,7 @@ static void *prb_dispatch_next_block(struct tpacket_kbd=
q_core *pkc,
 	pbd =3D GET_CURR_PBLOCK_DESC_FROM_CORE(pkc);
=20
 	/* 2. If this block is currently in_use then freeze the queue */
-	if (TP_STATUS_USER & BLOCK_STATUS(pbd)) {
+	if (prb_curr_blk_in_use(pkc)) {
 		prb_freeze_queue(pkc, po);
 		return NULL;
 	}
@@ -950,31 +949,24 @@ static void prb_retire_current_block(struct tpacket_k=
bdq_core *pkc,
 		struct packet_sock *po, unsigned int status)
 {
 	struct tpacket_block_desc *pbd =3D GET_CURR_PBLOCK_DESC_FROM_CORE(pkc);
+	struct pgv *block =3D &pkc->pkbdq[pkc->kactive_blk_num];
=20
-	/* retire/close the current block */
-	if (likely(TP_STATUS_KERNEL =3D=3D BLOCK_STATUS(pbd))) {
-		/*
-		 * Plug the case where copy_bits() is in progress on
-		 * cpu-0 and tpacket_rcv() got invoked on cpu-1, didn't
-		 * have space to copy the pkt in the current block and
-		 * called prb_retire_current_block()
-		 *
-		 * We don't need to worry about the TMO case because
-		 * the timer-handler already handled this case.
-		 */
-		if (!(status & TP_STATUS_BLK_TMO)) {
-			/* Waiting for skb_copy_bits to finish... */
-			write_lock(&pkc->blk_fill_in_prog_lock);
-			write_unlock(&pkc->blk_fill_in_prog_lock);
-		}
-		prb_close_block(pkc, pbd, po, status);
+	if (!BLOCK_NUM_PKTS(pbd))
 		return;
-	}
+	block->retire_status =3D status;
+	WRITE_ONCE(block->last_pkt, (struct tpacket3_hdr *)pkc->prev);
+	pkc->pending_blocks++;
+	pkc->kactive_blk_num =3D GET_NEXT_PRB_BLK_NUM(pkc);
+	prb_publish_blocks(pkc, po);
 }
=20
-static int prb_curr_blk_in_use(struct tpacket_block_desc *pbd)
+static int prb_curr_blk_in_use(struct tpacket_kbdq_core *pkc)
 {
-	return TP_STATUS_USER & BLOCK_STATUS(pbd);
+	struct pgv *block =3D &pkc->pkbdq[pkc->kactive_blk_num];
+	struct tpacket_block_desc *pbd =3D (void *)block->buffer;
+
+	return READ_ONCE(block->last_pkt) ||
+	       (TP_STATUS_USER & READ_ONCE(BLOCK_STATUS(pbd)));
 }
=20
 static int prb_queue_frozen(struct tpacket_kbdq_core *pkc)
@@ -982,14 +974,6 @@ static int prb_queue_frozen(struct tpacket_kbdq_core *=
pkc)
 	return pkc->reset_pending_on_curr_blk;
 }
=20
-static void prb_clear_blk_fill_status(struct packet_ring_buffer *rb)
-	__releases(&pkc->blk_fill_in_prog_lock)
-{
-	struct tpacket_kbdq_core *pkc  =3D GET_PBDQC_FROM_RB(rb);
-
-	read_unlock(&pkc->blk_fill_in_prog_lock);
-}
-
 static void prb_fill_rxhash(struct tpacket_kbdq_core *pkc,
 			struct tpacket3_hdr *ppd)
 {
@@ -1038,7 +1022,6 @@ static void prb_fill_curr_block(char *curr,
 				struct tpacket_kbdq_core *pkc,
 				struct tpacket_block_desc *pbd,
 				unsigned int len)
-	__acquires(&pkc->blk_fill_in_prog_lock)
 {
 	struct tpacket3_hdr *ppd;
=20
@@ -1048,7 +1031,7 @@ static void prb_fill_curr_block(char *curr,
 	pkc->nxt_offset +=3D TOTAL_PKT_LEN_INCL_ALIGN(len);
 	BLOCK_LEN(pbd) +=3D TOTAL_PKT_LEN_INCL_ALIGN(len);
 	BLOCK_NUM_PKTS(pbd) +=3D 1;
-	read_lock(&pkc->blk_fill_in_prog_lock);
+	atomic_inc(&pkc->pkbdq[pkc->kactive_blk_num].in_flight);
 	prb_run_all_ft_ops(pkc, ppd);
 }
=20
@@ -1063,6 +1046,7 @@ static void *__packet_lookup_frame_in_block(struct pa=
cket_sock *po,
 	char *curr, *end;
=20
 	pkc =3D GET_PBDQC_FROM_RB(&po->rx_ring);
+	prb_publish_blocks(pkc, po);
 	pbd =3D GET_CURR_PBLOCK_DESC_FROM_CORE(pkc);
=20
 	/* Queue is frozen when user space is lagging behind */
@@ -1071,7 +1055,7 @@ static void *__packet_lookup_frame_in_block(struct pa=
cket_sock *po,
 		 * Check if that last block which caused the queue to freeze,
 		 * is still in_use by user-space.
 		 */
-		if (prb_curr_blk_in_use(pbd)) {
+		if (prb_curr_blk_in_use(pkc)) {
 			/* Can't record this packet */
 			return NULL;
 		} else {
@@ -1091,7 +1075,7 @@ static void *__packet_lookup_frame_in_block(struct pa=
cket_sock *po,
 	end =3D (char *)pbd + pkc->kblk_size;
=20
 	/* first try the current block */
-	if (curr+TOTAL_PKT_LEN_INCL_ALIGN(len) < end) {
+	if (curr + TOTAL_PKT_LEN_INCL_ALIGN(len) <=3D end) {
 		prb_fill_curr_block(curr, pkc, pbd, len);
 		return (void *)curr;
 	}
@@ -1142,7 +1126,9 @@ static void *prb_lookup_block(const struct packet_soc=
k *po,
 	struct tpacket_kbdq_core *pkc  =3D GET_PBDQC_FROM_RB(rb);
 	struct tpacket_block_desc *pbd =3D GET_PBLOCK_DESC(pkc, idx);
=20
-	if (status !=3D BLOCK_STATUS(pbd))
+	if (status =3D=3D TP_STATUS_KERNEL && READ_ONCE(pkc->pkbdq[idx].last_pkt))
+		return NULL;
+	if (status !=3D (READ_ONCE(BLOCK_STATUS(pbd)) & TP_STATUS_USER))
 		return NULL;
 	return pbd;
 }
@@ -1150,8 +1136,8 @@ static void *prb_lookup_block(const struct packet_soc=
k *po,
 static int prb_previous_blk_num(struct packet_ring_buffer *rb)
 {
 	unsigned int prev;
-	if (rb->prb_bdqc.kactive_blk_num)
-		prev =3D rb->prb_bdqc.kactive_blk_num-1;
+	if (rb->prb_bdqc.publish_blk_num)
+		prev =3D rb->prb_bdqc.publish_blk_num - 1;
 	else
 		prev =3D rb->prb_bdqc.knum_blocks-1;
 	return prev;
@@ -1269,6 +1255,8 @@ static bool __tpacket_v3_has_room(const struct packet=
_sock *po, int pow_off)
=20
 	len =3D READ_ONCE(po->rx_ring.prb_bdqc.knum_blocks);
 	idx =3D READ_ONCE(po->rx_ring.prb_bdqc.kactive_blk_num);
+	if (!prb_lookup_block(po, &po->rx_ring, idx, TP_STATUS_KERNEL))
+		return false;
 	if (pow_off)
 		idx +=3D len >> pow_off;
 	if (idx >=3D len)
@@ -2274,6 +2262,7 @@ static int tpacket_rcv(struct sk_buff *skb, struct ne=
t_device *dev,
 	unsigned int slot_id =3D 0;
 	int vnet_hdr_sz =3D 0;
 	struct virtio_net_hdr vnet_hdr;
+	struct pgv *copy_block =3D NULL;
=20
 	/* struct tpacket{2,3}_hdr is aligned to a multiple of TPACKET_ALIGNMENT.
 	 * We may add members to them until current aligned size without forcing
@@ -2306,8 +2295,10 @@ static int tpacket_rcv(struct sk_buff *skb, struct n=
et_device *dev,
 	if (!res)
 		goto drop_n_restore;
=20
-	/* If we are flooded, just give up */
-	if (__packet_rcv_has_room(po, skb) =3D=3D ROOM_NONE) {
+	/* V3 allocation must get a chance to publish completed pending blocks. */
+	if (__packet_rcv_has_room(po, skb) =3D=3D ROOM_NONE &&
+	    (po->tp_version !=3D TPACKET_V3 ||
+	     !READ_ONCE(po->rx_ring.prb_bdqc.pending_blocks))) {
 		atomic_inc(&po->tp_drops);
 		goto drop_n_restore;
 	}
@@ -2389,6 +2380,11 @@ static int tpacket_rcv(struct sk_buff *skb, struct n=
et_device *dev,
 					TP_STATUS_KERNEL, (macoff+snaplen));
 	if (!h.raw)
 		goto drop_n_account;
+	if (po->tp_version =3D=3D TPACKET_V3) {
+		struct tpacket_kbdq_core *pkc =3D &po->rx_ring.prb_bdqc;
+
+		copy_block =3D &pkc->pkbdq[pkc->kactive_blk_num];
+	}
=20
 	if (po->tp_version <=3D TPACKET_V2) {
 		slot_id =3D po->rx_ring.head;
@@ -2518,7 +2514,8 @@ static int tpacket_rcv(struct sk_buff *skb, struct ne=
t_device *dev,
 		spin_unlock(&sk->sk_receive_queue.lock);
 		sk->sk_data_ready(sk);
 	} else if (po->tp_version =3D=3D TPACKET_V3) {
-		prb_clear_blk_fill_status(&po->rx_ring);
+		/* No frame accesses may follow this release. */
+		atomic_dec_return_release(&copy_block->in_flight);
 	}
=20
 drop_n_restore:
@@ -4376,8 +4373,9 @@ static __poll_t packet_poll(struct file *file, struct=
 socket *sock,
=20
 	spin_lock_bh(&sk->sk_receive_queue.lock);
 	if (po->rx_ring.pg_vec) {
-		if (!packet_previous_rx_frame(po, &po->rx_ring,
-			TP_STATUS_KERNEL))
+		if (po->tp_version =3D=3D TPACKET_V3 ?
+		    !!packet_previous_rx_frame(po, &po->rx_ring, TP_STATUS_USER) :
+		    !packet_previous_rx_frame(po, &po->rx_ring, TP_STATUS_KERNEL))
 			mask |=3D EPOLLIN | EPOLLRDNORM;
 	}
 	__packet_rcv_try_clear_pressure(po);
diff --git a/net/packet/internal.h b/net/packet/internal.h
index f5c8cd0eed2c..bece88a9672c 100644
--- a/net/packet/internal.h
+++ b/net/packet/internal.h
@@ -20,7 +20,7 @@ struct tpacket_kbdq_core {
 	unsigned int	feature_req_word;
 	unsigned int	hdrlen;
 	unsigned char	reset_pending_on_curr_blk;
-	unsigned short	kactive_blk_num;
+	unsigned int	kactive_blk_num;
 	unsigned int	blk_sizeof_priv;
=20
 	unsigned short  version;
@@ -36,7 +36,8 @@ struct tpacket_kbdq_core {
=20
 	struct sk_buff	*skb;
=20
-	rwlock_t	blk_fill_in_prog_lock;
+	unsigned int	publish_blk_num;
+	unsigned int	pending_blocks;
=20
 	/* Default is set to 8ms */
 #define DEFAULT_PRB_RETIRE_TOV	(8)
@@ -49,6 +50,10 @@ struct tpacket_kbdq_core {
=20
 struct pgv {
 	char *buffer;
+	/* RX V3 only; last_pkt marks a sealed, unpublished block. */
+	struct tpacket3_hdr *last_pkt;
+	atomic_t in_flight;
+	unsigned int retire_status;
 };
=20
 struct packet_ring_buffer {
--=20
2.25.1
