Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.17.129
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794295374;
	b=ALFRIImjPMp9jZFI0iJFXv+Omwg+tzDP4wUem/VwBNkXYqkh0pJUlRwLBd3AB311Tiij
	 bjmqlRJ3fZq5FQRNsJZ138B67hPnmm09fjjNh7bB6ffru+rVB4X0mc+Ca7ezZMIXUh1Zd
	 5wZKLku4UNx6gj6iWdoyc4tC7EZlbH+LC3aCb7iddY2+bXYI5rpFU2/Othy93vb+tEVlk
	 VnrOUDWsSAHISq98+TMZ0Xeg+KqdoqtFwDHGJ9lLqdzL0Ewtsh4OyZMrOkgnssc6Cfost
	 fMof5rZHrHnAPJxkG9ChDOIWECVxuWzndhwxuUfQfT3XYN4nt8VPEZe7nmdkPN67FvA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794295374;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
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
	bh=x215kx4XbjgtP5PCHIs92fHV3fbYijDMuFyodLLxynQ=;
	b=o+D8H8NynrCyLQx5eYId2X3eaWFPrfbJnuOOS3Z1p0jKHlm8z148Xj72f1jmg7vyL5DY
	 WqT+y7mT51fysTQFpmQhTWrtZfVXohNTPOBZZE/z8zrEyjXeGYfHXJQIrYs1ehjLXUGPF
	 FyTpjDcc5xJ/b9+scB9YDFxJ4R1hkjhKDeHm6G+g6Y+MkJD/RFRDtgevtPo63DRlRg98w
	 qhubxTpopDs1s5lP8u2BLrKpfnc2K8eTvaVvStHAkEOUH8HYYZi3RXv8nCheSztfQEMC2
	 HVuKjohXvA0+BGGkocMpjs08MxmyUO0K4SFkrNaEBgMdBQSYejN5wJOQcetoqHo2wDg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=deeproute.ai;
	spf=pass smtp.mailfrom=deeproute.ai;
	dkim=pass header.d=deeproute.ai header.i=@deeproute.ai header.a=rsa-sha256 header.s=selector1 header.b=WaSPyOoy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.17.129
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2129.outbound.protection.partner.outlook.cn [139.219.17.129])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6246606A336;
	Tue, 10 Nov 2026 07:22:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6246606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=deeproute.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deeproute.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=deeproute.ai header.i=@deeproute.ai header.a=rsa-sha256 header.s=selector1 header.b=WaSPyOoy
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YSNnQsPy98XinlGNg+AuPexMI8RZVH5jVPk4alAeS2IFB5Adc68ioiulC157Hw0sy8yPkyajoz/5DCT0B0ZNaBXoiEXLNwa+5n7xfZk8vAKMqi7DCxWs4rW8ypNBO9Jpbr1mRXi4rZajLqGXGQ29HicqkNblJvcGKkVWqwxgYKunYZUlyuDB0YcouooJpBi7irRhlZV6YJENjk8kZUGs4gfWIgPkWZsz+FykMwCTaaid5SFKJ+QIjXhMHrSow7sfqJXj3AXtViSrU8Xb217I10CrpI6yXizCl5x19evsJLhnk0IVYa8zJaV11CsbqtQcX700voivYs2G5YEV18Nrqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x215kx4XbjgtP5PCHIs92fHV3fbYijDMuFyodLLxynQ=;
 b=QiW/scPBKYZMSpu+M+5LQNctcq+6IUuXgkp1oJbV1WllNh1uMfKr+4Zqnn6yXx3OKOo8xYIBs5/Xs7kwOOt2pu+RMWsak8TPCJ13KTLKIYtGsG1mrt7vq26gt/1Iu3j1xiXRIY+P2F95Jk5NqhNrq5OtkHQBmJ98l3fIWgRx6iD1AKKxesGZfyPeJ9+PzqS6n13b2FSQvga9x3bbvXE6E6+m9AJScd6fGCWSki11m8c0xCAu14x7GTzSiUDG222r6jz6p49UNnm7C6muMCwzkKW2Z76K44u+3ZWCNIcsBjJph0nDLTgDMSHn+y68OttSrEU7rJGeGcamLNYjwZqGlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=deeproute.ai; dmarc=pass action=none header.from=deeproute.ai;
 dkim=pass header.d=deeproute.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=deeproute.ai;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x215kx4XbjgtP5PCHIs92fHV3fbYijDMuFyodLLxynQ=;
 b=WaSPyOoyx/fLVgZXKg+BRCR5U5ZpPMC5or3MtHWd3apIOtGXh68e2NBjdz7+LNxZHT2tUP16Y/HJ4HE6ZnoHq7Jx/kSswsLPGiigWZU7z1apU7Kw7dNdVP2McKT1QRNeo7So39x7LxIezoAttsFiTqcmgZHL+i9LPqPcNA0xVkk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=deeproute.ai;
Received: from ZQZPR01MB0980.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:a::9) by ZQZPR01MB0961.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:9::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 07:22:38 +0000
Received: from ZQZPR01MB0980.CHNPR01.prod.partner.outlook.cn
 ([fe80::2dda:e54d:5a3c:d686]) by
 ZQZPR01MB0980.CHNPR01.prod.partner.outlook.cn ([fe80::2dda:e54d:5a3c:d686%4])
 with mapi id 15.21.0615.005; Tue, 10 Nov 2026 07:22:38 +0000
From: Jingxuan Xie <jingxuanxie@deeproute.ai>
To: netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	=?UTF-8?q?=E9=9F=A9=E5=B0=91=E9=98=B3?= <shaoyanghan@deeproute.ai>,
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
Subject: [PATCH net v4] af_packet: avoid waiting for TPACKET_V3 copies at retirement
Date: Tue, 10 Nov 2026 07:22:21 +0000
Message-ID: <20261110072221.24701-1-jingxuanxie@deeproute.ai>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SH0PR01CA0004.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:5::16) To ZQZPR01MB0980.CHNPR01.prod.partner.outlook.cn
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
X-MS-TrafficTypeDiagnostic: ZQZPR01MB0980:EE_|ZQZPR01MB0961:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c9a0c90-b7a8-44a8-a2ea-08df3efb664d
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|52116014|18002099003|10067099003|56012099006|261102123227099003|261021133027099003|261028144727099003|261022115727099003|261022105027099003|261022113327099003|261022075727099003|261021135927099003|261026140227099003|261021121427099003|261021130227099003|261026135527099003|261009223027099003|261021123027099003|261026130827099003|261026121527099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	NdoOj60hRUM39QHu+BVmDeIAACZSsxY/MjYx2S88ik44yIuy/sv881Y3Qu4iA8takpb4LB2h4AUVylEohsJDbMDi9oZojljunL6b4AtiGkVZ6piDF5u5rj4Lp1XUNBA0GHZeKBO7zBv2treg4g90Rcxr2ff/I/ZeFXaBrnI4U5WIPSOwoOl94NP8b962fwekpcpqhnZpPzzIkZUoj4azk7P+jJ3FkH+1Bhrp8BvsUJJ3xiElQ9WYI0IKzmgM1548nR3T/iDOlguXR0PMh9dNuCB7GlpnE7Zlxxi5kOUSIDb55c9MpSFgGx83rY7EtZynIkt9o6yPznXwVtCjkk1UmDbN922P+UOUJwuKvNR5N2QQsFj4DmyRKD3VUf7UuGGMcZscxHrh6iPodmVDJutv5YDJnxp7oHed8wjQ3YV+g9d1P278p0LmTINudX/CqWtyaFSyutp/ime+RjdqHQxSZZSuX28MFBmZ8ydksa/Nfurwn6r98QnVhFSMzTGwLsoQkjTgCQew+jyUcuPUd+5B5qPAPY+5L3R87d68Gk3poWPjVllk5hUoBq7QjN5chrBZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQZPR01MB0980.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(52116014)(18002099003)(10067099003)(56012099006)(261102123227099003)(261021133027099003)(261028144727099003)(261022115727099003)(261022105027099003)(261022113327099003)(261022075727099003)(261021135927099003)(261026140227099003)(261021121427099003)(261021130227099003)(261026135527099003)(261009223027099003)(261021123027099003)(261026130827099003)(261026121527099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eV0CQ8/FF1I10JelghDW+vKIGoNsq5umb+qqnWmNufPbltZAy9TUHAAgclkj?=
 =?us-ascii?Q?JN3/+LGhdIMzkdJrD+yraLe7AJhZba1DLGRoPQttwntVQKgKB5sC96TEFNy1?=
 =?us-ascii?Q?XVy9gDtMGbWbZAgVF/dZ/YXnQCUed1pL6hhvrq0XFuMq4q4lquKqs6l3ks7x?=
 =?us-ascii?Q?0eTnxMiGy85VspAPH4XDDVUBoGuRCinA5TWbWr0m2Du+6x2wOYd5teb2MM1l?=
 =?us-ascii?Q?l0UR42rDrb0i3k2RMlbVyIqwQuVoVSuc3gurdOWagAR7QcYtGUP/hdF5duUv?=
 =?us-ascii?Q?f14w8kJlNB4kJk0DpK5YXTghpFNy0VOViWOvyffhtR4z173omm6RkR06I/oF?=
 =?us-ascii?Q?VhXl5Pg1vPJxn5mW8yZ1J78z19WHo+v9tmE/pkwIvXQgQuGJCR+nC+tdrmN0?=
 =?us-ascii?Q?3qoyIdoo+1wugYJj47pWRteQUnwRoigCWLRTjKbPgBst/J98eN+vBEUy7uBM?=
 =?us-ascii?Q?S76O5Uw22IawWj1Qe/f5W3mTi9QCO4q7nQEDylBdoNDJXSU1Eko2pr0Akl8e?=
 =?us-ascii?Q?yhU/zCZj6/9Q1iphPlAFeOvGFgZcqoTzfBt583zl8BrRkTwfJjGQi/jNbThf?=
 =?us-ascii?Q?BH+XQKN8DubL9ROhquHvXcvE4xzoctjc0GgfPN+m8IzyfGXiRjVLKWtc22Sd?=
 =?us-ascii?Q?iwBSHnb4QJxuW6DxBa6zw5ITD7ZHfFumTiqmKVTEX8Qjq4NW5XJ9ujbFYr0o?=
 =?us-ascii?Q?ucpk7wQlU+Pszq7Wz/OOm6aUPStL7TGk96lBpKSq2X69vmPMW0yowUoIVSV2?=
 =?us-ascii?Q?GlRGEUD7c/wMZRStmwNKh0zKEt5nrKAcsXmKYdIzRKFxFuFa+LB0b58hkXXC?=
 =?us-ascii?Q?M0ECuNww01IT2nBIyToEnA5ABKNP7Cz4a93lAPPIrYSGTFDVEyyntUrRAP8g?=
 =?us-ascii?Q?9gkfrb1yQhvFf2CxBV5hnOv17N1juGVB4iPF+WavSJsY5cQpE7Ll5nlk6WUo?=
 =?us-ascii?Q?STs13TEpBQOenYNIXjobaFe6c6tyqQXdVThXEyuwOU39SjNusFjevrw1xw1y?=
 =?us-ascii?Q?FjIobBIVEJlXl7UMgk5SWD6zbUrDEiFDSOUlXv7yujuDw+my4DvOTdLJ4TEC?=
 =?us-ascii?Q?hmYf83ER+LFt/YD1fzpTDxRU6kh+rvMbMBRZ7Xp3VRkZT/TWcZa6LBFSD6jB?=
 =?us-ascii?Q?BAOa57XhQFWHk4al69YN6Fh3X1zZKbZKtG334d8tY8Haps4ZXALsJhLln75H?=
 =?us-ascii?Q?p1rI0jsyTQqeosknrIhR+rgDTHiavneLceldiO7f50Oc3tC61aemrQWcn5gD?=
 =?us-ascii?Q?gS8qWv5Ppoj/36aXb2paH+CRfRIVca3zw1wt8r+Jd1WTFQiZOZnI8MSB0Cj1?=
 =?us-ascii?Q?ncZiLNEskG2O1hqGScI+VGxI8Qw4fsd7MKOz/Sj7WcVGHhftHyr6cpUyokg+?=
 =?us-ascii?Q?HArJCCLUJo5mSI0V7BDWs6dnQQrNNhdozZm/n2f5fqzHMDcVI3H5fMamNpv8?=
 =?us-ascii?Q?lcA4yaUqpXYgZtPJoWmI8I+JO2nxoaWKTTHjCFcjaBKfRarU4PJgtkb9o5Cl?=
 =?us-ascii?Q?ZSyvT9LPsbtmi8ZIvSTZXI2DWxU2VtPHbaMKEylkJ/a2zSBFDDSHlVnOJMRv?=
 =?us-ascii?Q?yPxILmhT1pHhGyLwwny5j3Jtdc9A/0nWNXako5jfVcLN6F0HBkZo1FNeUg1h?=
 =?us-ascii?Q?VZpW5tFPFa0XE0nDEvsbQpYFhdRwCDbfOWhi9C07n+7QLs+KiuOrZaClcZ3P?=
 =?us-ascii?Q?afby7TjK/5Vy8cJiFPx6pynRkjf9j9ZZuW2ai24RPG+icv5+vKYdihjf2D4E?=
 =?us-ascii?Q?7bgra36wow=3D=3D?=
X-OriginatorOrg: deeproute.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c9a0c90-b7a8-44a8-a2ea-08df3efb664d
X-MS-Exchange-CrossTenant-AuthSource: ZQZPR01MB0980.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 07:22:38.4844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: df535b4a-68e6-4339-a092-afa4f2c24fcc
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lt+n+8dKer0BR60NWDcVzlE0XOmJ54gP7GMc6ZpLuCJThxf+vgjMziOe4hafR+vt7HmidoOQPw61mnPWKKfYiotCqtLM+YThXyzErqicB04=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQZPR01MB0961

TPACKET_V3 retires a full or expired block while holding
sk_receive_queue.lock. prb_retire_current_block() takes
blk_fill_in_prog_lock for write to wait for in-flight skb_copy_bits()
before publishing the block.

On PREEMPT_RT a read lock can be held by a task that has been
preempted or is running on another CPU. The packet path or the
retirement timer then blocks on the write lock while holding
sk_receive_queue.lock, and the receive path resumes only after the
copy completes. This was observed as a receive stall of hundreds of
milliseconds in a PREEMPT_RT deployment; manual inspection found the
same unconditional write_lock() in both the full-block and the timer
retirement paths.

Try to take the write lock without blocking on PREEMPT_RT. If a copy
is still in progress, leave the current block and its metadata
untouched:

- the retirement timer re-arms itself and retries after the configured
  interval;

- packet allocation returns NULL, so tpacket_rcv() drops this capture
  record and accounts it in tp_drops, while the original packet remains
  in the network stack;

- a later packet can retire the block once the copier has finished.

Do not dispatch the next block while the current block is still open.
The existing lock order and completion ordering are preserved, and no
new state or worker is introduced. The trade-off is a higher capture
drop rate while a copy is in progress; original traffic is unaffected.

Non-PREEMPT_RT kernels keep the unconditional write_lock(): there
read_lock() disables preemption, so the writer only waits for the copy
to finish, not for a scheduled-out task to run again.

The stall was reproduced on QEMU arm64 SMP PREEMPT_RT by delaying a
copier after frame reservation: without this change the next sender
blocks until the copier is released, with this change only that
capture record is dropped.

Fixes: 632ca50f2cbd ("af_packet: TPACKET_V3: replace busy-wait loop")
Signed-off-by: Jingxuan Xie <jingxuanxie@deeproute.ai>
---
Changes in v4:
- Limit the write_trylock() switch to PREEMPT_RT; non-PREEMPT_RT
  kernels keep the blocking write lock (Willem).
- Leave the existing indentation of prb_retire_current_block()
  unchanged (Willem).
- Add the discovery and reproduction information requested by
  netdev-bot.

v3: https://lore.kernel.org/r/20261103092541.273847-1-jingxuanxie@deeproute=
.ai

Testing:
- arm64 W=3D1 af_packet.o built with PREEMPT_RT=3Dy and PREEMPT_RT=3Dn.
- QEMU arm64 SMP PREEMPT_RT, 3 boots: psock_tpacket and psock_fanout
  exit 0 (the fanout queue-length warning also appears on the
  baseline); with a copier delayed in skb_copy_bits() while holding
  blk_fill_in_prog_lock, a second sender returns in 0.7-1.8 ms and only
  its capture record is dropped; the retirement timer retries and
  publishes the block after the copier is released; close/unmap during
  the delay does not hang; no lockdep or atomic-sleep splats.
- QEMU arm64 SMP PREEMPT (no RT) with the same delay: the second
  sender blocks until the copier is released (503 ms) and no capture
  record is dropped, matching the unpatched kernel.
 net/packet/af_packet.c | 40 ++++++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 494d628d10a5..4d56893c4fe5 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -198,7 +198,7 @@ static void packet_increment_head(struct packet_ring_bu=
ffer *buff);
 static int prb_curr_blk_in_use(struct tpacket_block_desc *);
 static void *prb_dispatch_next_block(struct tpacket_kbdq_core *,
 			struct packet_sock *);
-static void prb_retire_current_block(struct tpacket_kbdq_core *,
+static bool prb_retire_current_block(struct tpacket_kbdq_core *,
 		struct packet_sock *, unsigned int status);
 static int prb_queue_frozen(struct tpacket_kbdq_core *);
 static void prb_open_block(struct tpacket_kbdq_core *,
@@ -666,6 +666,24 @@ static void init_prb_bdqc(struct packet_sock *po,
 	prb_open_block(p1, pbd);
 }
=20
+/*
+ * Wait for an in-flight skb_copy_bits() before retiring the current block.
+ * On PREEMPT_RT the read lock can be held by a task that has been preempt=
ed
+ * or is running on another CPU, so do not block while holding
+ * sk_receive_queue.lock; return false and let the caller retry.
+ */
+static bool prb_wait_for_copy_bits(struct tpacket_kbdq_core *pkc)
+{
+	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		if (!write_trylock(&pkc->blk_fill_in_prog_lock))
+			return false;
+	} else {
+		write_lock(&pkc->blk_fill_in_prog_lock);
+	}
+	write_unlock(&pkc->blk_fill_in_prog_lock);
+	return true;
+}
+
 /*
  * With a 1MB block-size, on a 1Gbps line, it will take
  * i) ~8 ms to fill a block + ii) memcpy etc.
@@ -700,9 +718,9 @@ static enum hrtimer_restart prb_retire_rx_blk_timer_exp=
ired(struct hrtimer *t)
 	 *
 	 */
 	if (BLOCK_NUM_PKTS(pbd)) {
-		/* Waiting for skb_copy_bits to finish... */
-		write_lock(&pkc->blk_fill_in_prog_lock);
-		write_unlock(&pkc->blk_fill_in_prog_lock);
+		/* Retry later if a packet copy is still in progress. */
+		if (!prb_wait_for_copy_bits(pkc))
+			goto refresh_timer;
 	}
=20
 	if (!frozen) {
@@ -727,6 +745,7 @@ static enum hrtimer_restart prb_retire_rx_blk_timer_exp=
ired(struct hrtimer *t)
 		}
 	}
=20
+refresh_timer:
 	hrtimer_forward_now(&pkc->retire_blk_timer, pkc->interval_ktime);
 	spin_unlock(&po->sk.sk_receive_queue.lock);
 	return HRTIMER_RESTART;
@@ -935,7 +954,7 @@ static void *prb_dispatch_next_block(struct tpacket_kbd=
q_core *pkc,
 	return (void *)pkc->nxt_offset;
 }
=20
-static void prb_retire_current_block(struct tpacket_kbdq_core *pkc,
+static bool prb_retire_current_block(struct tpacket_kbdq_core *pkc,
 		struct packet_sock *po, unsigned int status)
 {
 	struct tpacket_block_desc *pbd =3D GET_CURR_PBLOCK_DESC_FROM_CORE(pkc);
@@ -952,13 +971,13 @@ static void prb_retire_current_block(struct tpacket_k=
bdq_core *pkc,
 		 * the timer-handler already handled this case.
 		 */
 		if (!(status & TP_STATUS_BLK_TMO)) {
-			/* Waiting for skb_copy_bits to finish... */
-			write_lock(&pkc->blk_fill_in_prog_lock);
-			write_unlock(&pkc->blk_fill_in_prog_lock);
+			/* Do not wait for copies while holding the queue lock. */
+			if (!prb_wait_for_copy_bits(pkc))
+				return false;
 		}
 		prb_close_block(pkc, pbd, po, status);
-		return;
 	}
+	return true;
 }
=20
 static int prb_curr_blk_in_use(struct tpacket_block_desc *pbd)
@@ -1086,7 +1105,8 @@ static void *__packet_lookup_frame_in_block(struct pa=
cket_sock *po,
 	}
=20
 	/* Ok, close the current block */
-	prb_retire_current_block(pkc, po, 0);
+	if (!prb_retire_current_block(pkc, po, 0))
+		return NULL;
=20
 	/* Now, try to dispatch the next block */
 	curr =3D (char *)prb_dispatch_next_block(pkc, po);
--=20
2.25.1

