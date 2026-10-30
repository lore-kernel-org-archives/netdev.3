Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.146.135
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793348126;
	b=gPxg2RmUny3WpEXEkVI+tYhawB+E20WuJ4elL9BDiCKq+To9WuxMTyPeBvpcfU7fU2aZ
	 /iUpaVyZEkUtn2JdDKJe2+ORFpVduVnVt1OsRziox6bzdvhMlxjZfzvbXYLrtuh55dC7L
	 yKMK99ljMFikJIeBlZdn+kqA1vS/zVheq3xVL/0X4HeytwX3kABWZkJWvyI5jaVnad171
	 fgdjr3cUF6f86WAPJViMTkSkkdZRcCmWi3uOQ9g1OhVKdzMcmF0NXe+9jFUKRhWKaUBns
	 D0g/fAjReUeQuiIVmv9/9GlH6+w52Of6z1yWoiwVJpilZ2vP2hzzkdfAk2gO5tW6yQw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793348126;
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
	b=gn7B8GCKrlVgjUGk71QiskCsaVFYgn/+rA/y+xIWgNCI5E6qplTaXYZFB4ALMT0HlK6l
	 FV5B6z5QtUEfSvoLUASlk+w65IiUwT886cvYmrfZty1Q9XaOy04oHTNof++dbAMbTSP2u
	 mfNRgKufCWvBQ7FaaVRC9xoIRODZfUXnWfJOeDsqpzg7wnlF8+6RbztDQZmSEHiQgciIZ
	 SqoQCH6oz600WQMzrB+LsxgBX4S/0C4qb0WnBzfvbYYoVuTRQhN+A+YgQ2DaxC5ruo6l0
	 o+SNqjCScfviyy+M1565JJrDC1rEdTLgUu1swkfmkXvnZuqFzKva2ai9822roxipw5Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=deeproute.ai;
	spf=pass smtp.mailfrom=deeproute.ai;
	dkim=pass header.d=deeproute.ai header.i=@deeproute.ai header.a=rsa-sha256 header.s=selector1 header.b=kA02gFYe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.146.135
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2135.outbound.protection.partner.outlook.cn [139.219.146.135])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4DA606A322;
	Fri, 30 Oct 2026 08:15:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE4DA606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=deeproute.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deeproute.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=deeproute.ai header.i=@deeproute.ai header.a=rsa-sha256 header.s=selector1 header.b=kA02gFYe
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BwmGZ26vBY+VgBkakPGrPVJeOC6bPSj9az/1Kdm1yifhNd1BykyUAuu0MVZyKYsDb8fhXr7kxv9/6aMOrh1Xw7cCq6S0ZYjoYi1SeusZkQ+X9VeOqDNCq+1bUq52oPIJLlUpnNch8Ng2ukwPXf5BcAUWenxefZqF/pOpcf6JjEvMt6b1OG/Ol6oE8kK7imRXRsogymdgu+VId13Q4Vlxwfzn01VJVsLix19qLaWyNfgP/3Jr72OiN2a1F5T1V20kYA+S9oh5vkngXkR1TPtkUhvrzeQahCngq+rdNr1a56YRL7ZRKlZtO0nyaPisBGq5PjEx0xnT+aA6QE2jXXaG5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vs40igkL5P2cJQoPaXrEskF//A/4BPaH1mGjhzFQfb8=;
 b=Mvfmn5YOptHsyCK6f1CHk6g5RnS1IhGP2XVU1wty41h/iE7Ax0ZcyA/uCAOt4qfki/fx/uENNxJao+gaCKG9J+npga6acsjsMmu1L9BrTFMHFQWjo+30gteZ5jQ+ZHfOzI0CQ9GXdxtuz3qn7SS9FjbbfM2KDnkCVzirl2ArHZUzF+fQQdmOSoHrXRWSJFmMT8HnT8YZgeh3K7OaVPT4JP5EubzWgq8rar7tRGEFnCZoAJkEwSlrO3uItxRPLim/LRoEPC8NGBlxYA2uvY2kYFMTca5q4MR9MBw0lR9LSPixjRWTjoB2Np1HxQABJNqOpmpov0XczjzBtsKe3Tz69g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=deeproute.ai; dmarc=pass action=none header.from=deeproute.ai;
 dkim=pass header.d=deeproute.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=deeproute.ai;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vs40igkL5P2cJQoPaXrEskF//A/4BPaH1mGjhzFQfb8=;
 b=kA02gFYeA3w6ATEF2Zi+SAXnp2B/PUMN3bpCzA9jwCQbE6ERjOt89uU9IGvetMBD/+yiwGj+UezoknfxKNbetuCLl8XzGqTmwksaGcR+jKEii0htjii8ZhdTlcA0Ai0uwbC2QzsYL93gUhPT9j8X8306BZHiVHc2KXpzkYIEpzw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=deeproute.ai;
Received: from ZQ0PR01MB0982.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1::5) by ZQ0PR01MB1239.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 08:15:14 +0000
Received: from ZQ0PR01MB0982.CHNPR01.prod.partner.outlook.cn
 ([fe80::197a:1934:4b5b:4520]) by
 ZQ0PR01MB0982.CHNPR01.prod.partner.outlook.cn ([fe80::197a:1934:4b5b:4520%3])
 with mapi id 15.21.0569.008; Fri, 30 Oct 2026 08:15:14 +0000
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
Date: Fri, 30 Oct 2026 08:14:40 +0000
Message-ID: <20261030081440.251635-3-jingxuanxie@deeproute.ai>
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
X-MS-Office365-Filtering-Correlation-Id: 72ba2701-8563-41fc-ffe6-08df365decd1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|23010399003|366016|376014|38350700014|5023799004|56012099006|261028144727099003|261022105027099003|261026140227099003|261026121527099003|261021123027099003|261022075727099003|10067099003|261021121427099003|261009223027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	9Wf+29eAGUWRVhVs3BbOflKXIViyiRGYIOc0zgdxp9vbL7h83ofcS9TLV0coUi0zo0/aq6L6Ih/B0az5sQFCqjhwnLo+J8VorxWiDysUmqGIWFqbOwFadU1nKug1QQYcw2XZFttveuOHwsvI2N62y/HrH9+OzYRAIWl2l/t2aedpdfaetbFSMcUQzd87cgY4RDpxlbocTuDlVaPBk2njdmrjRaavDk+RlNL1F1m9hBtSkMiPwPoe/JDAeNIpk/SMwRRbC4ysLpiCuSIG86YUioqM8/9kJSWM75Zaiy2bQPVJyylapMu0I0+XvA3QU21dYfA7OZh+tXMWjqcqo5rK5WswpduKPYvWNKpXEviWw3SAORxknu12nDUEfdQ0ozx9lFzY1PFSoJVmFXO/l1qy5RZH4NynTmcJ0sYEwaUosJUyrzRtml882R5HkHVfrdFOsoJ4ohO0um1iEDKdDFYkWetTSYZzsa95DLy92pA+TMaiFJAZPPIvhBYki3oIMmasnx0xQw55CSKZk1dlRvo82BE+JuHkIgwTOtmIsPQVNVnbgNmEriP8aqN71CheGTmN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB0982.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(23010399003)(366016)(376014)(38350700014)(5023799004)(56012099006)(261028144727099003)(261022105027099003)(261026140227099003)(261026121527099003)(261021123027099003)(261022075727099003)(10067099003)(261021121427099003)(261009223027099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jEt1/7uZBub7Vy1GwgVzHhyhFj4yKadZr5LDxC23DRZfCmHgpUL+ZQN1QELC?=
 =?us-ascii?Q?D2iptgT6KYxX0bUBWKFp9d7u+hG5CEbJHPm2N3VcvRHVriFAbAOFdcMp1Tfm?=
 =?us-ascii?Q?03oOsVuXBDGk1BPfVJt+2HtNgUZ2MXOu/FxijEdAvkk/FIFaoAP/YoLhqwKd?=
 =?us-ascii?Q?hxPszETYQvzbae8VvrWfEA9Vaq1Z7cjHZ4RbizNOVJ+B2DughyE44J/+sMA9?=
 =?us-ascii?Q?AnljQdzCDcFa4qg3xhwHiBCsSJLt6UX3cYkFZhnFfE/gskVGJxHYQN9DF3Y9?=
 =?us-ascii?Q?jiSmL983JhO3Vr2fU7oYYBQHe1aURQlOUXkI0TTThldTC1r1eggUbaCtiQek?=
 =?us-ascii?Q?Ot/9IdeCvNKRCPoRaIIW3N3hFK8hpyyVTrYvVGWvMEuWc0gUrszpnBFBewIs?=
 =?us-ascii?Q?2BfVpn8pMk3x7HBJxqOEXHouUA/60/jccK/9iOG6fV8i6+06QgNK3zyydC+1?=
 =?us-ascii?Q?SoUKDCS8pUAJzKqj9uHF+0GvWVfVjVh+wAj6hFqxsSgbznweYSVTushT096j?=
 =?us-ascii?Q?Pne0OHJfNBB7bq7AyEZJeLA9AuelM0PLLFgYCGnp/k/vT1CTB2s8lkwOH1l3?=
 =?us-ascii?Q?mArI+KJ8VRmMV6qyuMmiXHQHhe/L8x7coKsv6h1sHbgqdB4sRHbH/XPEo0jU?=
 =?us-ascii?Q?nFAvK4gsOxPMSdhK5acON+3XHze32tEGQk5quDlcFmZheaGpyYbU8GpU9WQS?=
 =?us-ascii?Q?hfptQyMEiFigsetI+vsmks9fxwTNZ7PD94iNq4xj+lhZpUD7tf0vRrrBBMkp?=
 =?us-ascii?Q?VWz0TA69fBEFy0Z0NXWM68moLRG9oydYBgfT5RGarYNvUkhKMDYA0rDwfgQJ?=
 =?us-ascii?Q?3siIev6I4po6BJZP+EH6wdqm/yBBiv+fFcpnUIr6EvBBFRFly0Q8wNtd9hGu?=
 =?us-ascii?Q?So+AQrtBSwxZYImgcsr7nQN3OwhuJ8ZywBt3X6dAjqH3wj7IXv1Wg6VI9AmF?=
 =?us-ascii?Q?eLoUorwow4PVNXx4WBikPVMe3fXG0qKopA40j3lXh5sp7Td8WXwaK2ku2FrO?=
 =?us-ascii?Q?MeIgTb7BQaBqZ+kB343V1AtQaVXTyBnHUowidsAq6Z0V59MpvdlH2T0DHnMj?=
 =?us-ascii?Q?HGVLFyYKaIanoICdJpucIL9ooyoULyy+x91E5cZFRoAfAqL2Q1iNyu2aHli5?=
 =?us-ascii?Q?Q9zdqPxuTZpGFySyy2HkPhYTe8+tCzGreSu/UPvbrI86nLnVGUj4s5flyswK?=
 =?us-ascii?Q?yo2IO7IuEvbbUq5GcQH1oaR8E31m1vbSFHkZYK0AxDXgQGXnkZpgy5B9saGX?=
 =?us-ascii?Q?D0uzFyt5stFoUndER4/3lzKoVXVDlRFxea4cA7FFd9vtMSuesl2qlbd9dfFk?=
 =?us-ascii?Q?gv06a+g6zXZGLXwz4Kg+LDv9246mRlc/mbkeaa2gzxc64atOM+VeKxSHUzYN?=
 =?us-ascii?Q?0kpZXzkJoah0FHNMo4vJHTPeJ8XWcXQu4vdXLzaErbs3RN12cgC/tkdU8yBo?=
 =?us-ascii?Q?86cnLDcfxo7gbx/4lB97HLXFwV35Nu46UO7Kfhp7EqUBNN6YE4swCI6ejaca?=
 =?us-ascii?Q?hjYevwQfiazpEVfA9H1pFlZVSGQgq92XgOjZ9Equ4r4DHen5SwSQQ4QUKxN5?=
 =?us-ascii?Q?GR0ysFWgXp3EkJ7PoEfPLiN5Ps0tRqA/1+rBBTHfhcH6f2Jyg0VX8CHQ9Swz?=
 =?us-ascii?Q?7T6wJdMRppfKcIrP37wYHe1M9PE/D/+zML6bxRMD+QYkMKG0oIyfIQXo0+5K?=
 =?us-ascii?Q?z+8CYTOpaHfcZgDFtClop0HHm6zXon34cir6GT2s4CnVCzY13JxjlRCONE0I?=
 =?us-ascii?Q?eiNF5IdYPQ=3D=3D?=
X-OriginatorOrg: deeproute.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: 72ba2701-8563-41fc-ffe6-08df365decd1
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB0982.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 08:15:14.3733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: df535b4a-68e6-4339-a092-afa4f2c24fcc
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P0luGyjcFPI3N5P1yhG5QO/3mVcj9wWI2vSYSjd1u5ulfjmamEgpxVaOwxDHobgo+hXN1CYl3Y7lx3BycmIBNz1WPr0qE/JQrIEzz/9BqI0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1239

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
