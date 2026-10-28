Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.17.91
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793171193;
	b=Wjwm2ts/MnmSnYjNeJZOr4cose+VUPZMeTl3rI2QAKKQ94X4d4lv9wehsM5YHNqBm1Tt
	 HkDSdXte4OTagKzLIcExetxNH0KJGdjINQXU5YCpY+vpStUeCM4mkIQ1rOVGv3eUqxr+s
	 GCkkt0gbUBewiSAPVoYh+cIq4FYdis+/Vm4IBfExZC41Jc+ICJBSYTXWZPX1o3y57OUY1
	 8IvtiVXCJ+KQaBS/3FnJQwHU091lnoRYv/Tsva8kqwCHOzJN2X9bQqkdsrbiE0ajFvcaO
	 t65jeAzlTIMzH8K9qXG8n6LHOPwIKoibo56rPHoHtGrgA489+XQBKCgkCCB+Sqp28Xw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793171193;
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
	bh=PbqoNm/CdftemidL5B7YluKkmlzfKe/EDpLGDEcar44=;
	b=NeBPbZKQxeR4YW4JCT/JQa7RqAiLPasrBX5KJ7d4UJ9XlDHBSgMVJDUl4klP671MycaA
	 RTTGTo/HiehLrgMDfhJ4hyR4pMjz7V/NyOvrA6TcdlXPCAMCBDQ0elpWJsP1pG+gSijhF
	 PBYKXKyoX4jnrYD8A5ZSMKb7huCJUl/hnLKgGAGvaay221JWauOIXLIZOl87tLeZXRqMB
	 HiURXejz+aXMeMkaSTnGE7Yjq1azQgO/ZHlqE05Exs34ebcX3lhDY2aFDZ5HLvgT8oTC6
	 dSuuOrfDtzAu/zOitIDFvr2XRUuKNgMl5aY7OqBMhZjuTytzjEIBo/nT6yZYbY6nbmA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=deeproute.ai;
	spf=pass smtp.mailfrom=deeproute.ai;
	dkim=pass header.d=deeproute.ai header.i=@deeproute.ai header.a=rsa-sha256 header.s=selector1 header.b=om6hGhcY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.17.91
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2091.outbound.protection.partner.outlook.cn [139.219.17.91])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C100606A31F
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 07:06:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C100606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=deeproute.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deeproute.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=deeproute.ai header.i=@deeproute.ai header.a=rsa-sha256 header.s=selector1 header.b=om6hGhcY
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L6DopKSZFuhsgkHS+/oA0oPwEvKi7/i+JtotSUQGjnZhZRIvlxl8NUmEHgZasT6RuRdULku2dVFQlPmHYbLBy0VNawGVO9XLPbP228p3eBC1Zsujw2diH/vjwLZcFapXMo1nLuNjdMt/Td/gLNmda0nj2ZKubZL7DaNeqvaozUK1G2pM8Ehe7qmdosSMZPknMh4U82ljxHJmJHLaQmhK4w/hMe9uI+pXcbCGOXvdhYoh46I55wSX3H/p2BeAn5yImXzAvFBFg8wqhH4cqCWMbsfWD0MXz9VvEYmHZ1oUYulAQLySY0d8IPT4Now7xCP+FbV2bS/2KSwwkYjUdTGqNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PbqoNm/CdftemidL5B7YluKkmlzfKe/EDpLGDEcar44=;
 b=U0gEuovKUOtMAfcI+QwRxnytKMh2QJj8CzuTmfmPIBAKRwEkolm0ylWjHQNkkgxmCREXOc3a/flGLwukCkB8rfHwGU76Jp2822Y0Aq44t1moG7acVIR8cc+wsSeps+TficH2usdG1z+GA6jcJpBwoX+/jIcpy5jUhqxJHv+y3+VXN/dhsdzMtEs5vPTUg2pAjL/FbVFsouHRIW8R3iaEV0b/HUkpNr6vT0QwWZkdsagHXQEvBkKgoSkxugJm+89uXz7CuvXaxNqHbNEptItciqlPAobqOHoLuuLsS3Cd9gUNvIQGTMxAO8iGcLd8FHHav43WnYtcJ+paVZdhUr8ziQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=deeproute.ai; dmarc=pass action=none header.from=deeproute.ai;
 dkim=pass header.d=deeproute.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=deeproute.ai;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PbqoNm/CdftemidL5B7YluKkmlzfKe/EDpLGDEcar44=;
 b=om6hGhcYjbkeUnr6gOZQpetT6vcG16ojHEAjCwt/2Edd62ziaY6ANg211JyOg9yrS4ZsPpTESDJLlPw3kO31WCjaDU0zEcMAuusetFPiAoLkah35OV6OVtdufmCVwLInvcrRR2pQtHkzSQt1ffF46KV+wKhh1BWVxZB9MgMaow0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=deeproute.ai;
Received: from ZQZPR01MB0980.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:a::9) by ZQZPR01MB1042.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:8::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 07:06:21 +0000
Received: from ZQZPR01MB0980.CHNPR01.prod.partner.outlook.cn
 ([fe80::2dda:e54d:5a3c:d686]) by
 ZQZPR01MB0980.CHNPR01.prod.partner.outlook.cn ([fe80::2dda:e54d:5a3c:d686%3])
 with mapi id 15.21.0569.006; Wed, 28 Oct 2026 07:06:21 +0000
From: Jingxuan Xie <jingxuanxie@deeproute.ai>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Subject: [RFC net 1/2] af_packet: retire TPACKET_V3 blocks without waiting for copiers
Date: Wed, 28 Oct 2026 07:05:27 +0000
Message-ID: <20261028070528.139531-2-jingxuanxie@deeproute.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261028070528.139531-1-jingxuanxie@deeproute.ai>
References: <20261028070528.139531-1-jingxuanxie@deeproute.ai>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: SH0PR01CA0018.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:5::30) To ZQZPR01MB0980.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:a::9)
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
X-MS-TrafficTypeDiagnostic: ZQZPR01MB0980:EE_|ZQZPR01MB1042:EE_
X-MS-Office365-Filtering-Correlation-Id: f26f83d7-08b0-4412-5f3d-08df34c1f891
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|23010399003|366016|1800799024|261026135527099003|261026140227099003|261026130827099003|38350700014|5023799004|56012099006|261026121527099003|261021123027099003|261021121427099003|261021135927099003|261022113327099003|261022075727099003|261022115727099003|261021133027099003|261009223027099003|261022105027099003|10067099003|261021130227099003|22082099003|18002099003|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info:
	ZSbG1PJ19H3hpVkBbVDJu5egueLPJznWNEu1RALkIXe7VoVr5xNDGtPSSuCZpoIOuXrYv5n13EeCHxKnyXBsJlpkBiIBkipNEqhTfMLGKSFe19zcqrGd9SJ+acIi5TsnDnDOluuvBt3ICmtqXOvUJmsaBdKxyDeF5pp7Jtf6/IRN1ULlM7Hpt0fPfy2ld4AM/KMYLH7PSHyzfXzQTm2YOEpfui7b/AItDTM45ges0QbbE6mxvjexCDJisld04/mbGqdX5zmSRs7hRRs4tCzpIi5lvwTNz4k8yLTM9KZobJgTXdRm36TXtmf384lqNKQ4qmMsV/0uIYsl9dyf+KenyyHtb7h3AxrIMVwd1sbeXdSWlB9IyZZiK10mhf/kwmuZQpN2n6JWPb4PpYmJmuscVWwQHz7XGdA/oHggQJfsHPB46tIZE0jY1JQqOzRP6NPK2wfWMw+eJgsm13f4j4D5/HnI7DOV8Ms4PNuSPw5gUfxy5+eLjGuuQqROd+0KRdwp2EBECvjNQK6dcM32Xg5a7Lt1vfbhNiTxew9YbIkF45fZ9IHzE0Wa6Ok4X/Icqyf1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQZPR01MB0980.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(23010399003)(366016)(1800799024)(261026135527099003)(261026140227099003)(261026130827099003)(38350700014)(5023799004)(56012099006)(261026121527099003)(261021123027099003)(261021121427099003)(261021135927099003)(261022113327099003)(261022075727099003)(261022115727099003)(261021133027099003)(261009223027099003)(261022105027099003)(10067099003)(261021130227099003)(22082099003)(18002099003)(3023799007)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jPU4ZhvfKaRIkrKvQ/gqOZpDK8tRUKC+Vst/e3NYbgPbDEBQUxAJYlS9pd2N?=
 =?us-ascii?Q?f7eAGAAJFUEboeJ2dcaWy+pLX7WRUH3MgcANYcOMiQjkjLdtAosy0AQTwfwE?=
 =?us-ascii?Q?peJGaon+X4criXm0tj54sRHKm9rLTejtEiNqSXbfyhd8quhuWU2W9g7djbyZ?=
 =?us-ascii?Q?L6FYV124mHEenw0sqyXsA0330wfQ7/by2e3d/4zNCpMc61GQq/ktGMmPiBTJ?=
 =?us-ascii?Q?bnHRLhgSNWFk4NuhYUHedem7mLYQHCZMZwOqBXgRsLLweb3Uf4ENQntM0BIh?=
 =?us-ascii?Q?XUuUtzSLBBOd2aW/au7sBPdxeXJ/kpvYXnE4iE0xxvM/HApcqVODqiL2K+ng?=
 =?us-ascii?Q?icHYDiCN8J9oBCeLf+jvxdmvx6GBWfGluNaJ4ekfPd1vdULXaeXX7vNItzUY?=
 =?us-ascii?Q?VJinEZDd6NwF2FR3D7XpwqrL4VKUg5389Z5stTRPFFafzF5GuEvHi1IYhZO0?=
 =?us-ascii?Q?DZso/drcwfIS8ylY3Koy/C8HpMNN89M6Ou+yxBlzFiUol4gs+eoM6XC0HlWM?=
 =?us-ascii?Q?aoSvXTx8y4GgBnvwmxOeMux0ntBpBeFES9EvnCmpY0+MjzoElF31EBg+JPsV?=
 =?us-ascii?Q?2kSzAq3JMMp39azW2dhx89uOXocpUipTidjatGAEd+Bt76cx/EHSVcmH4WE/?=
 =?us-ascii?Q?tacrq8UcgbRsWp2vXt+4hXtwSEQflzeSucRVDNFnISJwFVqISpUg/I51IFh+?=
 =?us-ascii?Q?ybdoWOH5UCQ6eP4WTo4KQLHJkTLCW9yh+1hKcHmxK8Y/U7zTS/yvIhfKhdyl?=
 =?us-ascii?Q?IXfLiMbyXCGaHDBIFu+GJEQsroaHrZRaYKVI+nQ4pfGBgqsCqkZH/U9oKyX+?=
 =?us-ascii?Q?OuBglpmPU4kp0KYyhpcYo3wL1lQLUpAODXhenbN8lvli9bo5m6JbrC+3TQ3t?=
 =?us-ascii?Q?G2RKg/j2BjhsG5+IpV2Xqd/I3mG4XFYS4W+t9RhWUJwjsMiCCpVPFVLqkfur?=
 =?us-ascii?Q?3HjNz9XFoo5oq+/cCEXDDBTBH9ftccSNUXDJBWNCRM6BOiasDOt0ZaADTj1U?=
 =?us-ascii?Q?/H6HZHrEoozsFXKJL/9d6XAH/9hyDujsPxgO0DHp7PYbjIW07zkPjb+akpQs?=
 =?us-ascii?Q?GFpPrDTowteo8Fhi5k752jJCJk/urKTwHlHbPcbjaAzhMOexdx/LDk/wSUJx?=
 =?us-ascii?Q?3AxTbz+yo8Zw4wCOMGxhkMHBUUKI3y+fA1o8TTSqgd2RxPeM0QHQG7TttxgD?=
 =?us-ascii?Q?kPdwb3FLCIirT8Ttqd35/anAmyf7QRziavm5rrvP78Dv3zX8wo6W8gBRfr6n?=
 =?us-ascii?Q?Eszqpy/1x/xSv9Sn/lPlC1ESfLc49r71pDS2fDtOB8+8a4eZJFHAXA3MinK/?=
 =?us-ascii?Q?aCmvbWSQM7b8XU2CkMcEuPixwzVzhzRXxe+c5g/86/Hk5QG8PouTJ+7F6HGz?=
 =?us-ascii?Q?z3mxlSQ+vMPQzPv3gRjySXd9xztpsunGduLWM0GMeMjC8FxnfofGhaPumja5?=
 =?us-ascii?Q?IoDqX6nEfcARjOOKtVShXkQz0hiBj6iLsupL0jF31toOPquj3EXElxI2MhCX?=
 =?us-ascii?Q?Ah0AoyPDZm3nhtENPh/ISZSlZw14NOcE7YfH0HZXHyJ1XxKEGvjrgp0p0Yei?=
 =?us-ascii?Q?nvMdozKwQvHdZkZm4UlLFZeSbYyRBAhHX2Kw9EuI1nsUHCxQaFN3Y65D0tM9?=
 =?us-ascii?Q?GzzphRwK1tychSldVpYJwX9AlnAb8r7gG2bEuMf3UAvKcmeKyyCzuQEjVCIv?=
 =?us-ascii?Q?S6T2PWud928wfVL1JHYnew5v3J32o+/c+LeSqXHjaI2ajkD2m0Ga9NYdBaT8?=
 =?us-ascii?Q?JcdYgDpcRw=3D=3D?=
X-OriginatorOrg: deeproute.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: f26f83d7-08b0-4412-5f3d-08df34c1f891
X-MS-Exchange-CrossTenant-AuthSource: ZQZPR01MB0980.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 07:06:21.5166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: df535b4a-68e6-4339-a092-afa4f2c24fcc
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CHMzszfik2JDkuTxzOVu7el7RCacP0QWhUU5eP+mEeeW9sM2oOF81zrAQ+48I92Dt9+M+zbWmsUCCgUvxiabDrUPVvhuUeWwwvElBUYA75I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQZPR01MB1042

From: jingxuanxie <jingxuanxie@deeproute.ai>

TPACKET_V3 waits for a ring-wide read lock before retiring a block,
while holding sk_receive_queue.lock. A copier keeps the read lock
after reserving a frame and dropping the queue lock. On PREEMPT_RT,
preempting that copier can therefore delay another packet path or
the retirement timer until the copier runs again.

This was investigated after an approximately 355 ms block-retirement
wait in a real PREEMPT_RT deployment. A QEMU ARM64 SMP PREEMPT_RT
reproducer uses test-only instrumentation to delay one outgoing
copier after reservation, with a second sender forcing retirement.
The unmodified retirement logic blocks the second sender. The
instrumentation is not part of this series.

Track FREE, ACTIVE, SEALED and USER state per block in private
metadata. Reserve and complete copies under the receive queue lock,
retaining the original block reference across the unlocked copy.
Seal a full or expired block and try the immediately following block
without waiting. Publish sealed blocks in reservation order once
their copies have completed. Do not reuse a sealed block merely
because its mmap status still reads TP_STATUS_KERNEL.

Limit each locked publication batch to eight blocks and continue
ready backlogs on an unbound worker. Stop the timer and worker before
freeing metadata. Check readiness using the last published block,
and validate virtio headers before reserving a frame so an invalid
header cannot strand an unfinished reservation.

Tested against that reproducer with both full-block and timer
retirement: B completes while A remains delayed, blocks are not
published early, and sequence numbers, lengths and payload match.
An uninstrumented QEMU guest also passes psock_tpacket and
psock_fanout. The accompanying KUnit suite covers the state helpers.

Keep the mmap layout and userspace status protocol unchanged. Ring
exhaustion can still drop capture copies; a stalled copier no longer
has to block retirement or copying into another available block.

The block producer index must cover the full unsigned block count,
matching the independent publication index across large rings.

Assisted-by: LLM
Fixes: 632ca50f2cbd ("af_packet: TPACKET_V3: replace busy-wait loop")
Signed-off-by: Jingxuan Xie <jingxuanxie@deeproute.ai>
---
 net/packet/af_packet.c | 319 +++++++++++++++++++++++++----------------
 net/packet/internal.h  |  27 +++-
 2 files changed, 221 insertions(+), 125 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 823e0911c910..b48982059a76 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -197,7 +197,6 @@ static void *packet_previous_frame(struct packet_sock *=
po,
                struct packet_ring_buffer *rb,
                int status);
 static void packet_increment_head(struct packet_ring_buffer *buff);
-static int prb_curr_blk_in_use(struct tpacket_block_desc *);
 static void *prb_dispatch_next_block(struct tpacket_kbdq_core *,
                        struct packet_sock *);
 static void prb_retire_current_block(struct tpacket_kbdq_core *,
@@ -205,6 +204,8 @@ static void prb_retire_current_block(struct tpacket_kbd=
q_core *,
 static int prb_queue_frozen(struct tpacket_kbdq_core *);
 static void prb_open_block(struct tpacket_kbdq_core *,
                struct tpacket_block_desc *);
+static void prb_publish_ready(struct tpacket_kbdq_core *, struct packet_so=
ck *);
+static void prb_retire_work(struct work_struct *);
 static enum hrtimer_restart prb_retire_rx_blk_timer_expired(struct hrtimer=
 *);
 static void prb_fill_rxhash(struct tpacket_kbdq_core *, struct tpacket3_hd=
r *);
 static void prb_clear_rxhash(struct tpacket_kbdq_core *,
@@ -241,6 +242,26 @@ struct packet_skb_cb {
        (((x)->kactive_blk_num < ((x)->knum_blocks-1)) ? \
        ((x)->kactive_blk_num+1) : 0)

+#define PRB_PUBLISH_BUDGET 8
+
+static unsigned int prb_next_block(const struct tpacket_kbdq_core *pkc,
+                                  unsigned int index)
+{
+       return index + 1 =3D=3D pkc->knum_blocks ? 0 : index + 1;
+}
+
+static bool prb_block_reusable(const struct tpacket_kbdq_core *pkc,
+                              unsigned int index)
+{
+       const struct prb_block_state *block =3D &pkc->blocks[index];
+       struct tpacket_block_desc *pbd =3D GET_PBLOCK_DESC(pkc, index);
+       enum prb_block_phase phase =3D READ_ONCE(block->phase);
+
+       return phase =3D=3D PRB_BLOCK_FREE ||
+              (phase =3D=3D PRB_BLOCK_USER &&
+               !(READ_ONCE(BLOCK_STATUS(pbd)) & TP_STATUS_USER));
+}
+
 static void __fanout_unlink(struct sock *sk, struct packet_sock *po);
 static void __fanout_link(struct sock *sk, struct packet_sock *po);

@@ -595,7 +616,11 @@ static void prb_shutdown_retire_blk_timer(struct packe=
t_sock *po,
        struct tpacket_kbdq_core *pkc;

        pkc =3D GET_PBDQC_FROM_RB(&po->rx_ring);
+       spin_lock_bh(&rb_queue->lock);
+       pkc->retire_shutdown =3D true;
+       spin_unlock_bh(&rb_queue->lock);
        hrtimer_cancel(&pkc->retire_blk_timer);
+       cancel_work_sync(&pkc->retire_work);
 }

 static int prb_calc_retire_blk_tmo(struct packet_sock *po,
@@ -641,15 +666,22 @@ static void prb_init_ft_ops(struct tpacket_kbdq_core =
*p1,
        p1->feature_req_word =3D req_u->req3.tp_feature_req_word;
 }

-static void init_prb_bdqc(struct packet_sock *po,
-                       struct packet_ring_buffer *rb,
-                       struct pgv *pg_vec,
-                       union tpacket_req_u *req_u)
+static int init_prb_bdqc(struct packet_sock *po,
+                        struct packet_ring_buffer *rb,
+                        struct pgv *pg_vec,
+                        union tpacket_req_u *req_u)
 {
        struct tpacket_kbdq_core *p1 =3D GET_PBDQC_FROM_RB(rb);
        struct tpacket_block_desc *pbd;
+       struct prb_block_state *blocks;
+
+       blocks =3D kvcalloc(req_u->req3.tp_block_nr, sizeof(*blocks), GFP_K=
ERNEL);
+       if (!blocks)
+               return -ENOMEM;

        memset(p1, 0x0, sizeof(*p1));
+       p1->blocks =3D blocks;
+       INIT_WORK(&p1->retire_work, prb_retire_work);

        p1->knxt_seq_num =3D 1;
        p1->pkbdq =3D pg_vec;
@@ -666,15 +698,15 @@ static void init_prb_bdqc(struct packet_sock *po,
                p1->interval_ktime =3D ms_to_ktime(prb_calc_retire_blk_tmo(=
po,
                                                 req_u->req3.tp_block_size)=
);
        p1->blk_sizeof_priv =3D req_u->req3.tp_sizeof_priv;
-       rwlock_init(&p1->blk_fill_in_prog_lock);

        p1->max_frame_len =3D p1->kblk_size - BLK_PLUS_PRIV(p1->blk_sizeof_=
priv);
        prb_init_ft_ops(p1, req_u);
        hrtimer_setup(&p1->retire_blk_timer, prb_retire_rx_blk_timer_expire=
d,
                      CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
+       prb_open_block(p1, pbd);
        hrtimer_start(&p1->retire_blk_timer, p1->interval_ktime,
                      HRTIMER_MODE_REL_SOFT);
-       prb_open_block(p1, pbd);
+       return 0;
 }

 /*
@@ -697,36 +729,24 @@ static enum hrtimer_restart prb_retire_rx_blk_timer_e=
xpired(struct hrtimer *t)
        struct tpacket_block_desc *pbd;

        spin_lock(&po->sk.sk_receive_queue.lock);
+       if (pkc->retire_shutdown) {
+               spin_unlock(&po->sk.sk_receive_queue.lock);
+               return HRTIMER_NORESTART;
+       }

        frozen =3D prb_queue_frozen(pkc);
        pbd =3D GET_CURR_PBLOCK_DESC_FROM_CORE(pkc);

-       /* We only need to plug the race when the block is partially filled=
.
-        * tpacket_rcv:
-        *              lock(); increment BLOCK_NUM_PKTS; unlock()
-        *              copy_bits() is in progress ...
-        *              timer fires on other cpu:
-        *              we can't retire the current block because copy_bits
-        *              is in progress.
-        *
-        */
-       if (BLOCK_NUM_PKTS(pbd)) {
-               /* Waiting for skb_copy_bits to finish... */
-               write_lock(&pkc->blk_fill_in_prog_lock);
-               write_unlock(&pkc->blk_fill_in_prog_lock);
-       }
-
        if (!frozen) {
-               if (BLOCK_NUM_PKTS(pbd)) {
+               if (pkc->blocks[pkc->kactive_blk_num].phase =3D=3D PRB_BLOC=
K_ACTIVE &&
+                   BLOCK_NUM_PKTS(pbd)) {
                        /* Not an empty block. Need retire the block. */
                        prb_retire_current_block(pkc, po, TP_STATUS_BLK_TMO=
);
                        prb_dispatch_next_block(pkc, po);
                }
        } else {
-               /* Case 1. Queue was frozen because user-space was
-                * lagging behind.
-                */
-               if (!prb_curr_blk_in_use(pbd)) {
+               /* A USER or SEALED block can block the write cursor. */
+               if (prb_block_reusable(pkc, pkc->kactive_blk_num)) {
                        /* Case 2. queue was frozen,user-space caught up,
                         * now the link went idle && the timer fired.
                         * We don't have a block to close.So we open this
@@ -756,7 +776,7 @@ static void prb_flush_block(struct tpacket_kbdq_core *p=
kc1,
        /* Skip the block header(we know header WILL fit in 4K) */
        start +=3D PAGE_SIZE;

-       end =3D (u8 *)PAGE_ALIGN((unsigned long)pkc1->pkblk_end);
+       end =3D (u8 *)PAGE_ALIGN((unsigned long)pbd1 + pkc1->kblk_size);
        for (; start < end; start +=3D PAGE_SIZE)
                flush_dcache_page(pgv_to_page(start));

@@ -777,15 +797,7 @@ static void prb_flush_block(struct tpacket_kbdq_core *=
pkc1,
 #endif
 }

-/*
- * Side effect:
- *
- * 1) flush the block
- * 2) Increment active_blk_num
- *
- * Note:We DONT refresh the timer on purpose.
- *     Because almost always the next block will be opened.
- */
+/* The write cursor has moved on; publish using this block's saved metadat=
a. */
 static void prb_close_block(struct tpacket_kbdq_core *pkc1,
                struct tpacket_block_desc *pbd1,
                struct packet_sock *po, unsigned int stat)
@@ -799,7 +811,7 @@ static void prb_close_block(struct tpacket_kbdq_core *p=
kc1,
        if (atomic_read(&po->tp_drops))
                status |=3D TP_STATUS_LOSING;

-       last_pkt =3D (struct tpacket3_hdr *)pkc1->prev;
+       last_pkt =3D pkc1->blocks[pkc1->publish_blk_num].last_pkt;
        last_pkt->tp_next_offset =3D 0;

        /* Get the ts of the last pkt */
@@ -824,8 +836,61 @@ static void prb_close_block(struct tpacket_kbdq_core *=
pkc1,
        prb_flush_block(pkc1, pbd1, status);

        sk->sk_data_ready(sk);
+}
+
+static bool prb_publishable(const struct tpacket_kbdq_core *pkc)
+{
+       const struct prb_block_state *block;
+
+       if (!pkc->sealed_blocks || pkc->retire_shutdown)
+               return false;
+       block =3D &pkc->blocks[pkc->publish_blk_num];
+       return block->phase =3D=3D PRB_BLOCK_SEALED && !block->in_flight;
+}

-       pkc1->kactive_blk_num =3D GET_NEXT_PRB_BLK_NUM(pkc1);
+/* Caller holds the receive-queue lock; never wait for an unfinished copy.=
 */
+static bool prb_publish_batch(struct tpacket_kbdq_core *pkc,
+                             struct packet_sock *po)
+{
+       unsigned int budget =3D PRB_PUBLISH_BUDGET;
+
+       lockdep_assert_held(&po->sk.sk_receive_queue.lock);
+       while (budget-- && prb_publishable(pkc)) {
+               unsigned int index =3D pkc->publish_blk_num;
+               struct prb_block_state *block =3D &pkc->blocks[index];
+               struct tpacket_block_desc *pbd =3D GET_PBLOCK_DESC(pkc, ind=
ex);
+
+               prb_close_block(pkc, pbd, po, block->retire_status);
+               WRITE_ONCE(block->phase, PRB_BLOCK_USER);
+               pkc->last_published =3D index;
+               pkc->has_published =3D true;
+               pkc->publish_blk_num =3D prb_next_block(pkc, index);
+               pkc->sealed_blocks--;
+       }
+       return prb_publishable(pkc);
+}
+
+static void prb_publish_ready(struct tpacket_kbdq_core *pkc,
+                             struct packet_sock *po)
+{
+       if (prb_publish_batch(pkc, po))
+               queue_work(system_dfl_wq, &pkc->retire_work);
+}
+
+static void prb_retire_work(struct work_struct *work)
+{
+       struct tpacket_kbdq_core *pkc =3D
+               container_of(work, struct tpacket_kbdq_core, retire_work);
+       struct packet_sock *po =3D
+               container_of(pkc, struct packet_sock, rx_ring.prb_bdqc);
+       bool more;
+
+       do {
+               spin_lock_bh(&po->sk.sk_receive_queue.lock);
+               more =3D prb_publish_batch(pkc, po);
+               spin_unlock_bh(&po->sk.sk_receive_queue.lock);
+               cond_resched();
+       } while (more);
 }

 static void prb_thaw_queue(struct tpacket_kbdq_core *pkc)
@@ -852,6 +917,7 @@ static void prb_open_block(struct tpacket_kbdq_core *pk=
c1,
 {
        struct timespec64 ts;
        struct tpacket_hdr_v1 *h1 =3D &pbd1->hdr.bh1;
+       struct prb_block_state *block =3D &pkc1->blocks[pkc1->kactive_blk_n=
um];

        smp_rmb();

@@ -877,6 +943,10 @@ static void prb_open_block(struct tpacket_kbdq_core *p=
kc1,
        pbd1->version =3D pkc1->version;
        pkc1->prev =3D pkc1->nxt_offset;
        pkc1->pkblk_end =3D pkc1->pkblk_start + pkc1->kblk_size;
+       block->in_flight =3D 0;
+       block->last_pkt =3D NULL;
+       block->retire_status =3D 0;
+       WRITE_ONCE(block->phase, PRB_BLOCK_ACTIVE);

        prb_thaw_queue(pkc1);

@@ -932,7 +1002,7 @@ static void *prb_dispatch_next_block(struct tpacket_kb=
dq_core *pkc,
        pbd =3D GET_CURR_PBLOCK_DESC_FROM_CORE(pkc);

        /* 2. If this block is currently in_use then freeze the queue */
-       if (TP_STATUS_USER & BLOCK_STATUS(pbd)) {
+       if (!prb_block_reusable(pkc, pkc->kactive_blk_num)) {
                prb_freeze_queue(pkc, po);
                return NULL;
        }
@@ -950,31 +1020,19 @@ static void prb_retire_current_block(struct tpacket_=
kbdq_core *pkc,
                struct packet_sock *po, unsigned int status)
 {
        struct tpacket_block_desc *pbd =3D GET_CURR_PBLOCK_DESC_FROM_CORE(p=
kc);
+       struct prb_block_state *block =3D &pkc->blocks[pkc->kactive_blk_num=
];

-       /* retire/close the current block */
-       if (likely(TP_STATUS_KERNEL =3D=3D BLOCK_STATUS(pbd))) {
-               /*
-                * Plug the case where copy_bits() is in progress on
-                * cpu-0 and tpacket_rcv() got invoked on cpu-1, didn't
-                * have space to copy the pkt in the current block and
-                * called prb_retire_current_block()
-                *
-                * We don't need to worry about the TMO case because
-                * the timer-handler already handled this case.
-                */
-               if (!(status & TP_STATUS_BLK_TMO)) {
-                       /* Waiting for skb_copy_bits to finish... */
-                       write_lock(&pkc->blk_fill_in_prog_lock);
-                       write_unlock(&pkc->blk_fill_in_prog_lock);
-               }
-               prb_close_block(pkc, pbd, po, status);
+       lockdep_assert_held(&po->sk.sk_receive_queue.lock);
+       if (block->phase !=3D PRB_BLOCK_ACTIVE || !BLOCK_NUM_PKTS(pbd))
                return;
-       }
-}
-
-static int prb_curr_blk_in_use(struct tpacket_block_desc *pbd)
-{
-       return TP_STATUS_USER & BLOCK_STATUS(pbd);
+       block->last_pkt =3D (struct tpacket3_hdr *)pkc->prev;
+       block->retire_status =3D status;
+       WRITE_ONCE(block->phase, PRB_BLOCK_SEALED);
+       if (!pkc->sealed_blocks)
+               pkc->publish_blk_num =3D pkc->kactive_blk_num;
+       pkc->sealed_blocks++;
+       pkc->kactive_blk_num =3D GET_NEXT_PRB_BLK_NUM(pkc);
+       prb_publish_ready(pkc, po);
 }

 static int prb_queue_frozen(struct tpacket_kbdq_core *pkc)
@@ -982,12 +1040,17 @@ static int prb_queue_frozen(struct tpacket_kbdq_core=
 *pkc)
        return pkc->reset_pending_on_curr_blk;
 }

-static void prb_clear_blk_fill_status(struct packet_ring_buffer *rb)
-       __releases(&pkc->blk_fill_in_prog_lock)
+static void prb_complete_copy(struct packet_sock *po,
+                             struct prb_block_state *block)
 {
-       struct tpacket_kbdq_core *pkc  =3D GET_PBDQC_FROM_RB(rb);
+       struct tpacket_kbdq_core *pkc =3D GET_PBDQC_FROM_RB(&po->rx_ring);

-       read_unlock(&pkc->blk_fill_in_prog_lock);
+       lockdep_assert_held(&po->sk.sk_receive_queue.lock);
+       if (WARN_ON_ONCE(!block->in_flight))
+               return;
+       block->in_flight--;
+       if (!block->in_flight)
+               prb_publish_ready(pkc, po);
 }

 static void prb_fill_rxhash(struct tpacket_kbdq_core *pkc,
@@ -1038,7 +1101,6 @@ static void prb_fill_curr_block(char *curr,
                                struct tpacket_kbdq_core *pkc,
                                struct tpacket_block_desc *pbd,
                                unsigned int len)
-       __acquires(&pkc->blk_fill_in_prog_lock)
 {
        struct tpacket3_hdr *ppd;

@@ -1048,7 +1110,7 @@ static void prb_fill_curr_block(char *curr,
        pkc->nxt_offset +=3D TOTAL_PKT_LEN_INCL_ALIGN(len);
        BLOCK_LEN(pbd) +=3D TOTAL_PKT_LEN_INCL_ALIGN(len);
        BLOCK_NUM_PKTS(pbd) +=3D 1;
-       read_lock(&pkc->blk_fill_in_prog_lock);
+       pkc->blocks[pkc->kactive_blk_num].in_flight++;
        prb_run_all_ft_ops(pkc, ppd);
 }

@@ -1065,13 +1127,13 @@ static void *__packet_lookup_frame_in_block(struct =
packet_sock *po,
        pkc =3D GET_PBDQC_FROM_RB(&po->rx_ring);
        pbd =3D GET_CURR_PBLOCK_DESC_FROM_CORE(pkc);

-       /* Queue is frozen when user space is lagging behind */
+       /* The next block may belong to userspace or an unfinished copier. =
*/
        if (prb_queue_frozen(pkc)) {
                /*
                 * Check if that last block which caused the queue to freez=
e,
-                * is still in_use by user-space.
+                * is still owned by userspace or has pending publication.
                 */
-               if (prb_curr_blk_in_use(pbd)) {
+               if (!prb_block_reusable(pkc, pkc->kactive_blk_num)) {
                        /* Can't record this packet */
                        return NULL;
                } else {
@@ -1091,7 +1153,7 @@ static void *__packet_lookup_frame_in_block(struct pa=
cket_sock *po,
        end =3D (char *)pbd + pkc->kblk_size;

        /* first try the current block */
-       if (curr+TOTAL_PKT_LEN_INCL_ALIGN(len) < end) {
+       if (curr + TOTAL_PKT_LEN_INCL_ALIGN(len) <=3D end) {
                prb_fill_curr_block(curr, pkc, pbd, len);
                return (void *)curr;
        }
@@ -1134,36 +1196,20 @@ static void *packet_current_rx_frame(struct packet_=
sock *po,
        }
 }

-static void *prb_lookup_block(const struct packet_sock *po,
-                             const struct packet_ring_buffer *rb,
-                             unsigned int idx,
-                             int status)
-{
-       struct tpacket_kbdq_core *pkc  =3D GET_PBDQC_FROM_RB(rb);
-       struct tpacket_block_desc *pbd =3D GET_PBLOCK_DESC(pkc, idx);
-
-       if (status !=3D BLOCK_STATUS(pbd))
-               return NULL;
-       return pbd;
-}
-
-static int prb_previous_blk_num(struct packet_ring_buffer *rb)
-{
-       unsigned int prev;
-       if (rb->prb_bdqc.kactive_blk_num)
-               prev =3D rb->prb_bdqc.kactive_blk_num-1;
-       else
-               prev =3D rb->prb_bdqc.knum_blocks-1;
-       return prev;
-}
-
 /* Assumes caller has held the rx_queue.lock */
 static void *__prb_previous_block(struct packet_sock *po,
                                         struct packet_ring_buffer *rb,
                                         int status)
 {
-       unsigned int previous =3D prb_previous_blk_num(rb);
-       return prb_lookup_block(po, rb, previous, status);
+       struct tpacket_kbdq_core *pkc =3D &rb->prb_bdqc;
+       struct tpacket_block_desc *pbd;
+
+       if (!pkc->has_published)
+               return NULL;
+       pbd =3D GET_PBLOCK_DESC(pkc, pkc->last_published);
+       if ((READ_ONCE(BLOCK_STATUS(pbd)) & TP_STATUS_USER) !=3D status)
+               return NULL;
+       return pbd;
 }

 static void *packet_previous_rx_frame(struct packet_sock *po,
@@ -1265,15 +1311,20 @@ static bool __tpacket_has_room(const struct packet_=
sock *po, int pow_off)

 static bool __tpacket_v3_has_room(const struct packet_sock *po, int pow_of=
f)
 {
+       const struct tpacket_kbdq_core *pkc =3D &po->rx_ring.prb_bdqc;
        int idx, len;

-       len =3D READ_ONCE(po->rx_ring.prb_bdqc.knum_blocks);
-       idx =3D READ_ONCE(po->rx_ring.prb_bdqc.kactive_blk_num);
+       len =3D READ_ONCE(pkc->knum_blocks);
+       idx =3D READ_ONCE(pkc->kactive_blk_num);
+       if (READ_ONCE(pkc->blocks[idx].phase) !=3D PRB_BLOCK_ACTIVE &&
+           !prb_block_reusable(pkc, idx))
+               return false;
        if (pow_off)
                idx +=3D len >> pow_off;
        if (idx >=3D len)
                idx -=3D len;
-       return prb_lookup_block(po, &po->rx_ring, idx, TP_STATUS_KERNEL);
+       return READ_ONCE(pkc->blocks[idx].phase) =3D=3D PRB_BLOCK_ACTIVE ||
+              prb_block_reusable(pkc, idx);
 }

 static int __packet_rcv_has_room(const struct packet_sock *po,
@@ -2262,6 +2313,8 @@ static int tpacket_rcv(struct sk_buff *skb, struct ne=
t_device *dev,
        struct packet_sock *po;
        struct sockaddr_ll *sll;
        union tpacket_uhdr h;
+       struct prb_block_state *copy_block =3D NULL;
+       struct virtio_net_hdr vnet_hdr;
        u8 *skb_head =3D skb->data;
        int skb_len =3D skb->len;
        unsigned int snaplen, res;
@@ -2375,11 +2428,23 @@ static int tpacket_rcv(struct sk_buff *skb, struct =
net_device *dev,
                        vnet_hdr_sz =3D 0;
                }
        }
+       if (vnet_hdr_sz &&
+           virtio_net_hdr_from_skb(skb, &vnet_hdr, vio_le(), true, 0)) {
+               atomic_inc(&po->tp_drops);
+               drop_reason =3D SKB_DROP_REASON_PACKET_SOCK_ERROR;
+               sk_skb_reason_drop(sk, copy_skb, drop_reason);
+               goto drop_n_restore;
+       }
        spin_lock(&sk->sk_receive_queue.lock);
        h.raw =3D packet_current_rx_frame(po, skb,
                                        TP_STATUS_KERNEL, (macoff+snaplen))=
;
        if (!h.raw)
                goto drop_n_account;
+       if (po->tp_version =3D=3D TPACKET_V3) {
+               struct tpacket_kbdq_core *pkc =3D &po->rx_ring.prb_bdqc;
+
+               copy_block =3D &pkc->blocks[pkc->kactive_blk_num];
+       }

        if (po->tp_version <=3D TPACKET_V2) {
                slot_id =3D po->rx_ring.head;
@@ -2388,16 +2453,9 @@ static int tpacket_rcv(struct sk_buff *skb, struct n=
et_device *dev,
                __set_bit(slot_id, po->rx_ring.rx_owner_map);
        }

-       if (vnet_hdr_sz &&
-           virtio_net_hdr_from_skb(skb, h.raw + macoff -
-                                   sizeof(struct virtio_net_hdr),
-                                   vio_le(), true, 0)) {
-               if (po->tp_version <=3D TPACKET_V2)
-                       __clear_bit(slot_id, po->rx_ring.rx_owner_map);
-               else
-                       prb_clear_blk_fill_status(&po->rx_ring);
-               goto drop_n_account;
-       }
+       if (vnet_hdr_sz)
+               memcpy(h.raw + macoff - sizeof(vnet_hdr), &vnet_hdr,
+                      sizeof(vnet_hdr));

        if (po->tp_version <=3D TPACKET_V2) {
                packet_increment_rx_head(po, &po->rx_ring);
@@ -2516,7 +2574,9 @@ static int tpacket_rcv(struct sk_buff *skb, struct ne=
t_device *dev,
                spin_unlock(&sk->sk_receive_queue.lock);
                sk->sk_data_ready(sk);
        } else if (po->tp_version =3D=3D TPACKET_V3) {
-               prb_clear_blk_fill_status(&po->rx_ring);
+               spin_lock(&sk->sk_receive_queue.lock);
+               prb_complete_copy(po, copy_block);
+               spin_unlock(&sk->sk_receive_queue.lock);
        }

 drop_n_restore:
@@ -4374,8 +4434,9 @@ static __poll_t packet_poll(struct file *file, struct=
 socket *sock,

        spin_lock_bh(&sk->sk_receive_queue.lock);
        if (po->rx_ring.pg_vec) {
-               if (!packet_previous_rx_frame(po, &po->rx_ring,
-                       TP_STATUS_KERNEL))
+               if (po->tp_version =3D=3D TPACKET_V3 ?
+                   !!packet_previous_rx_frame(po, &po->rx_ring, TP_STATUS_=
USER) :
+                   !packet_previous_rx_frame(po, &po->rx_ring, TP_STATUS_K=
ERNEL))
                        mask |=3D EPOLLIN | EPOLLRDNORM;
        }
        __packet_rcv_try_clear_pressure(po);
@@ -4564,6 +4625,8 @@ static int packet_set_ring(struct sock *sk, union tpa=
cket_req_u *req_u,
        int was_running, order =3D 0;
        struct packet_ring_buffer *rb;
        struct sk_buff_head *rb_queue;
+       struct prb_block_state *old_blocks =3D NULL;
+       bool prb_created =3D false;
        __be16 num;
        int err;
        /* Added to avoid minimal code churn */
@@ -4633,7 +4696,10 @@ static int packet_set_ring(struct sock *sk, union tp=
acket_req_u *req_u,
                case TPACKET_V3:
                        /* Block transmit is not supported yet */
                        if (!tx_ring) {
-                               init_prb_bdqc(po, rb, pg_vec, req_u);
+                               err =3D init_prb_bdqc(po, rb, pg_vec, req_u=
);
+                               if (err)
+                                       goto out_free_pg_vec;
+                               prb_created =3D true;
                        } else {
                                struct tpacket_req3 *req3 =3D &req_u->req3;

@@ -4682,16 +4748,23 @@ static int packet_set_ring(struct sock *sk, union t=
packet_req_u *req_u,
                        goto out_unlock;

                err =3D 0;
+               if (!tx_ring && po->tp_version =3D=3D TPACKET_V3 && rb->pg_=
vec) {
+                       prb_shutdown_retire_blk_timer(po, rb_queue);
+                       old_blocks =3D rb->prb_bdqc.blocks;
+               }
                spin_lock_bh(&rb_queue->lock);
                swap(rb->pg_vec, pg_vec);
+               if (old_blocks)
+                       rb->prb_bdqc.blocks =3D NULL;
                if (po->tp_version <=3D TPACKET_V2)
                        swap(rb->rx_owner_map, rx_owner_map);
                rb->frame_max =3D (req->tp_frame_nr - 1);
                rb->head =3D 0;
                rb->frame_size =3D req->tp_frame_size;
-               po->prot_hook.func =3D (po->rx_ring.pg_vec) ?
-                                               tpacket_rcv : packet_rcv;
+               if (!tx_ring)
+                       po->prot_hook.func =3D rb->pg_vec ? tpacket_rcv : p=
acket_rcv;
                spin_unlock_bh(&rb_queue->lock);
+               prb_created =3D false;

                swap(rb->pg_vec_order, order);
                swap(rb->pg_vec_len, req->tp_block_nr);
@@ -4715,13 +4788,13 @@ static int packet_set_ring(struct sock *sk, union t=
packet_req_u *req_u,
                register_prot_hook(sk);

        spin_unlock(&po->bind_lock);
-       if (pg_vec && (po->tp_version > TPACKET_V2)) {
-               /* Because we don't support block-based V3 on tx-ring */
-               if (!tx_ring)
-                       prb_shutdown_retire_blk_timer(po, rb_queue);
-       }
-
 out_free_pg_vec:
+       if (prb_created) {
+               prb_shutdown_retire_blk_timer(po, rb_queue);
+               kvfree(rb->prb_bdqc.blocks);
+               rb->prb_bdqc.blocks =3D NULL;
+       }
+       kvfree(old_blocks);
        if (pg_vec) {
                bitmap_free(rx_owner_map);
                if (tx_ring && closing)
diff --git a/net/packet/internal.h b/net/packet/internal.h
index f5c8cd0eed2c..0761cf6de6d4 100644
--- a/net/packet/internal.h
+++ b/net/packet/internal.h
@@ -3,6 +3,7 @@
 #define __PACKET_INTERNAL_H__

 #include <linux/refcount.h>
+#include <linux/workqueue.h>

 struct packet_mclist {
        struct packet_mclist    *next;
@@ -14,13 +15,28 @@ struct packet_mclist {
        struct list_head        remove_list;
 };

+enum prb_block_phase {
+       PRB_BLOCK_FREE,
+       PRB_BLOCK_ACTIVE,
+       PRB_BLOCK_SEALED,
+       PRB_BLOCK_USER,
+};
+
+/* Private metadata; never exposed through the packet mmap mapping. */
+struct prb_block_state {
+       enum prb_block_phase phase;
+       unsigned int in_flight;
+       struct tpacket3_hdr *last_pkt;
+       unsigned int retire_status;
+};
+
 /* kbdq - kernel block descriptor queue */
 struct tpacket_kbdq_core {
        struct pgv      *pkbdq;
        unsigned int    feature_req_word;
        unsigned int    hdrlen;
        unsigned char   reset_pending_on_curr_blk;
-       unsigned short  kactive_blk_num;
+       unsigned int    kactive_blk_num;
        unsigned int    blk_sizeof_priv;

        unsigned short  version;
@@ -36,7 +52,14 @@ struct tpacket_kbdq_core {

        struct sk_buff  *skb;

-       rwlock_t        blk_fill_in_prog_lock;
+       /* State changes require sk_receive_queue.lock; copy payload outsid=
e it. */
+       struct prb_block_state *blocks;
+       unsigned int    publish_blk_num;
+       unsigned int    sealed_blocks;
+       unsigned int    last_published;
+       bool            has_published;
+       bool            retire_shutdown;
+       struct work_struct retire_work;

        /* Default is set to 8ms */
 #define DEFAULT_PRB_RETIRE_TOV (8)
--
2.25.1


________________________________


=E6=9C=AC=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E5=8F=8A=E8=BD=AC=E8=BD=BD=E7=
=9A=84=E4=BB=BB=E4=BD=95=E6=96=87=E4=BB=B6=E9=83=BD=E5=B1=9E=E7=BB=9D=E5=AF=
=86=E6=96=87=E4=BB=B6=EF=BC=8C=E5=B9=B6=E4=B8=94=E4=BB=85=E4=BE=9B=E6=A0=87=
=E6=98=8E=E5=9C=B0=E5=9D=80=E7=9A=84=E4=B8=AA=E4=BA=BA=E6=88=96=E5=9B=A2=E4=
=BD=93=E4=BD=BF=E7=94=A8=E3=80=82=E5=A6=82=E6=9E=9C=E6=82=A8=E6=94=B6=E5=88=
=B0=E7=9A=84=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E5=AD=98=E5=9C=A8=E9=94=99=
=E8=AF=AF=EF=BC=8C=E8=AF=B7=E9=80=9A=E7=9F=A5=E6=9C=AC=E5=85=AC=E5=8F=B8=EF=
=BC=8C=E5=88=A0=E9=99=A4=E5=85=A8=E9=83=A8=E5=8E=9F=E5=A7=8B=E4=BF=A1=E6=81=
=AF=EF=BC=88=E5=8C=85=E6=8B=AC=E4=BB=BB=E4=BD=95=E5=8E=9F=E5=A7=8B=E4=BF=A1=
=E6=81=AF=E7=9A=84=E5=A4=87=E4=BB=BD=EF=BC=89=EF=BC=8C=E5=B9=B6=E4=B8=94=E7=
=A6=81=E6=AD=A2=E6=95=A3=E5=B8=83=E6=88=96=E5=88=86=E5=8F=91=E5=85=A8=E9=83=
=A8=E6=88=96=E9=83=A8=E5=88=86=E5=8E=9F=E5=A7=8B=E4=BF=A1=E6=81=AF=E3=80=82=
=E6=9C=AC=E5=85=AC=E5=8F=B8=E4=B8=8D=E6=8B=85=E4=BF=9D=E6=9C=AC=E7=94=B5=E5=
=AD=90=E9=82=AE=E4=BB=B6=E4=B8=AD=E4=BF=A1=E6=81=AF=E7=9A=84=E5=87=86=E7=A1=
=AE=E6=80=A7=E3=80=81=E9=80=82=E5=BD=93=E6=80=A7=E6=88=96=E5=AE=8C=E6=95=B4=
=E6=80=A7=EF=BC=8C=E5=B9=B6=E4=B8=94=E5=AF=B9=E6=AD=A4=E4=BA=A7=E7=94=9F=E7=
=9A=84=E4=BB=BB=E4=BD=95=E9=94=99=E8=AF=AF=E6=88=96=E7=96=8F=E5=BF=BD=E4=B8=
=8D=E6=89=BF=E6=8B=85=E4=BB=BB=E4=BD=95=E8=B4=A3=E4=BB=BB=E3=80=82=E5=9C=A8=
=E6=AD=A3=E5=BC=8F=E5=8D=8F=E8=AE=AE=E7=AD=BE=E8=AE=A2=E4=BB=A5=E5=89=8D=EF=
=BC=8C=E8=BF=99=E9=87=8C=E6=8F=90=E5=88=B0=E7=9A=84=E4=BB=BB=E4=BD=95=E5=8F=
=82=E8=80=83=E6=9C=AF=E8=AF=AD=E3=80=81=E4=B8=8E=E4=B8=BB=E9=A2=98=E7=9B=B8=
=E5=85=B3=E7=9A=84=E6=83=85=E5=BD=A2=E4=BB=A5=E5=8F=8A=E9=9A=8F=E5=90=8E=E7=
=9A=84=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E4=B8=AD=E7=9A=84=E8=B0=88=E5=88=
=A4=EF=BC=8C=E9=83=BD=E5=B0=86=E4=B8=A5=E6=A0=BC=E2=80=9C=E9=81=B5=E5=AE=88=
=E5=90=88=E5=90=8C=E2=80=9D=E3=80=82=E6=8E=A5=E6=94=B6=E6=96=B9=E5=BA=94=E5=
=9C=A8=E6=8E=A5=E6=94=B6=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E6=88=96=E4=BB=
=BB=E4=BD=95=E9=99=84=E4=BB=B6=E6=97=B6=E6=A3=80=E6=9F=A5=E6=9C=89=E6=97=A0=
=E7=97=85=E6=AF=92=EF=BC=8C=E6=9C=AC=E5=85=AC=E5=8F=B8=E5=AF=B9=E7=94=B1=E4=
=BA=8E=E8=BD=AC=E8=BD=BD=E6=9C=AC=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E8=80=
=8C=E5=BC=95=E5=8F=91=E7=97=85=E6=AF=92=E4=BA=A7=E7=94=9F=E7=9A=84=E4=BB=BB=
=E4=BD=95=E6=8D=9F=E5=9D=8F=E4=B8=8D=E6=89=BF=E6=8B=85=E4=BB=BB=E4=BD=95=E8=
=B4=A3=E4=BB=BB=E3=80=82


Reproduced in this e-mail and any files are considered top-secret documents=
, and only indicate the address of individuals or groups. If you receive an=
 e-mail there is an error, please notify the Company, delete all the origin=
al information (including any backup of the original information), and the =
prohibition of the dissemination or distribution of all or part of the orig=
inal information. The Company does not guarantee the accuracy of the inform=
ation in this e-mail, adequacy, or completeness, and this produces any erro=
r or omission does not bear any responsibility. The formal agreement was si=
gned prior to any reference to the term mentioned here, and the circumstanc=
es relevant to the subject and subsequent e-mail in the negotiations will b=
e strictly "comply with the contract." The receiver should be receiving an =
e-mail or any attachment, check for viruses. The company reproduced this e-=
mail because of the virus caused any damage resulting from not bear any res=
ponsibility.
