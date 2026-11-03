Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.17.126
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793697969;
	b=L+l/IyRcWVY728qshUL6Vfx3zpsxkNTmR+kVmHRWEg4tWPIF9rXOQPuCMajUz7NvQQV6
	 Bna2fKrAbU61416JmqbYDHg9Bj4L0R8QX/3Z8qDRKKp6LVxgjM9G+pUeiEQmN0+etS5Oi
	 qgLUSZ0KPusnkVPL8+HFbZ/LZf3G0aygWBc64PMa8hp8jfDoMRVmO17qdz8/6Bsap4ISX
	 VvQAk5MVzwnYuIPIwPWuwmRs+IJCGrF+GoTydWgZkl9M6eeufQW0KP9N8SsL8N6M0juXr
	 dng3qoz8dlLiNDT0CPIccndlK/jDYv31vzmm2te4lbRv69xnBSoAHziDqNJ9o/r3IKQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793697969;
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
	bh=wea/Xmql/aZnCWfEfd0pIXurimTV1AhdL6Lsye8gs6s=;
	b=WMIN1P5Es/p4JR0sfJuvaofo1YDUGN2W5LoM2p46bUew6GiHrBw94bemkPEgFOR7RvtN
	 mfcyGqz4QyoUA592mycsMnn73VnIFQ1YzW72DmtNaoriOnwNsQDa45mOjqACI6lhy++Wc
	 Otu0t/quoJZZY21M0ZB6QyqM3GA4F1ez4FXndzuK7Tl/kL0JHtvsoBkckOGg3mZ2P58/Z
	 ojxXlYR52g3Xv4KPTVGNbgmkN3kCJ8kLbbBdEes/4h3TK+2Y2jKMg3DhLKQ/0FVZuToaP
	 qORW6hBuqQuxSpXrV6cBRjg5gelZjP2hocYEQRHY02F1K4FCrFlvG3SORza7OHmAxwg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=deeproute.ai;
	spf=pass smtp.mailfrom=deeproute.ai;
	dkim=pass header.d=deeproute.ai header.i=@deeproute.ai header.a=rsa-sha256 header.s=selector1 header.b=Z389T15h;
	arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.17.126
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2126.outbound.protection.partner.outlook.cn [139.219.17.126])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899F1606A326;
	Tue,  3 Nov 2026 09:26:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 899F1606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=deeproute.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deeproute.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=deeproute.ai header.i=@deeproute.ai header.a=rsa-sha256 header.s=selector1 header.b=Z389T15h
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vg5MGD29KscmrFszA2IjHyssiQSBCyNdL8WhosZEj9ebl/cYOKsrZjUwzxKl3Dytn74UPv8Xo5plJ+5KHFTwCUYSHFBWtpNvNoMQMU/agVl1b6mBGC4ATwNo6/fL1HJX4F//3rFAXykmCmAP/e+J/RgSncA4sZgEWrkVNTb59ovLMHwXqB+nMdM8Xv+d4ahLQ0YI5C7iUK4yOLiz3uZX4CSBdmgl56eqwIkfjp6K13L6VpCCjF9phT+Z0cpKX5JVATvwoi/8fmJOeHiXfdr+WMSU4pGh15pxb9bFSajh0F7Ykn53tq6de8XWbE/cnyA96+YLcnMYGo71iCV1mPXqTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wea/Xmql/aZnCWfEfd0pIXurimTV1AhdL6Lsye8gs6s=;
 b=nBHc1Hsq7jEy4AQazrIbHF+mfJRpsAuzJV+fj9CFJoqFjT+0s1MnlFhPOlyBtxi8sPYr+t63lE/uLclBJ1E3X5k2efEKG3II2+260gSgiDCcMgoDZdHfagHKx8//2UTd4Jf2n+sipgABCKBx1EBQeJ0ejGPDZ/Nyxy8eiQWL8t5GRTCJUx1t76OFe+4Vr69Hxa6yZ3N3OK+QMuk+fEIPcKENDvkgPCbTh8P/x/VriFdfDYpcR4pVzvYCS/96L6y162+3L/j+Ifjj3wDwUzI2SJgIrQeLAkjiK+dnIYY+xLG0MmeiCNGtoQNZ0on6qM1B7/+1RTQZPTtHTjeqb0fXSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=deeproute.ai; dmarc=pass action=none header.from=deeproute.ai;
 dkim=pass header.d=deeproute.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=deeproute.ai;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wea/Xmql/aZnCWfEfd0pIXurimTV1AhdL6Lsye8gs6s=;
 b=Z389T15h6VJMIzh3GHlskeCIAOVBMYUE/Y30lPy5Y6FOWe0tqMTVYq1J/3CoD2eOGymyktBilZZEQxLVX4avXT7QnkaWtbGIeOq5cz5HPZEUGb4wVNcGnVp/deGCRa9Y7VbLdGxsJ24NHAhpWhAVqQ2/2mroAxNMILTpoF2ZW/g=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=deeproute.ai;
Received: from ZQZPR01MB0980.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:a::9) by ZQZPR01MB1074.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 09:25:57 +0000
Received: from ZQZPR01MB0980.CHNPR01.prod.partner.outlook.cn
 ([fe80::2dda:e54d:5a3c:d686]) by
 ZQZPR01MB0980.CHNPR01.prod.partner.outlook.cn ([fe80::2dda:e54d:5a3c:d686%7])
 with mapi id 15.21.0592.007; Tue, 3 Nov 2026 09:25:57 +0000
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
Subject: [RFC PATCH net v3 0/1] af_packet: avoid waiting for TPACKET_V3 copies at retirement
Date: Tue,  3 Nov 2026 09:25:40 +0000
Message-ID: <20261103092541.273847-1-jingxuanxie@deeproute.ai>
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
X-MS-TrafficTypeDiagnostic: ZQZPR01MB0980:EE_|ZQZPR01MB1074:EE_
X-MS-Office365-Filtering-Correlation-Id: dec972a5-9ca0-42d3-ec7f-08df398c7791
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|23010399003|10067099003|261102123227099003|18002099003|3023799007|38350700014|56012099006|261026121527099003|261026140227099003|261021121427099003|261022105027099003|261028144727099003|261009223027099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	1Yg8Yq60ACQPm2Uz4YAAcwyq2lpJKlbchfzMDOMPth9r6aNMPJTafTxgb9wkVDJB9r+1xG5TPhr9P/WOFbc+u/6Fspv5HeZPL3ISRugWQsTg9Gs1Aix/2uHVYSXLQBZL8CtpvIgMvooFnymLDoe+cCRdWLE5rA98owQEVn7WEzlBR8tgsDLOomv2RhVuT/gzCH5s6QheU/JwHZj+1oNKr8DDhKubdNK40iZg8zxsyFndhHzOCGPeeDWsTjafVjUNKmkP0c3PDtU6sdfbjxEhAkIun5QWn1z4ziZBC9Eo3p5JvbFUblFuYZ3yQrNcyfrmJKdzjj26eGtBf0KIg0/BMHg/GebkGBsHxeFeE/2i8ZHAnkCHHB4mEXfUIOK6rEgo0DzIImQwCaCaUw0W21mHcmZrHo41diw8Rd/pL+uSQWsIYNrV2SR1ggDwzRpwOdrqeEA6gvsJVyRSRDB5HjI3z1L7Umj6/6KB3o1uPC0BZyN6m3fzVKAeZK+MrQtRpJSv8apb8KhBcvDNxIGbEfyXE3wqC+StiLZuFg01HNcTef3LJKYafkQihvQCr9G9FLVa
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQZPR01MB0980.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(23010399003)(10067099003)(261102123227099003)(18002099003)(3023799007)(38350700014)(56012099006)(261026121527099003)(261026140227099003)(261021121427099003)(261022105027099003)(261028144727099003)(261009223027099003)(261021123027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u3VyOFUoZkemUYl47vKnUTsYU6R51qgR5+zCATchkuOgQlqrhgchQh574r6g?=
 =?us-ascii?Q?CCY7bMOtABHzMtnpG6uyeNgO7UiHrInbMOoNXClKuAyuo21cKL6Njfildnji?=
 =?us-ascii?Q?hINQ5cnVQBXZLkYLBd/h099l8HZXm8NhkzFG2mg7qVHbme5rHQUdN56DIpDg?=
 =?us-ascii?Q?mzYSIdNsHXNvCoy56ownPZ6BT5NN5sBQ9RusTy6OFKdx0zTOLJxb8YiDcdXp?=
 =?us-ascii?Q?V6vjYYK4YLwfxI+xgMRZ4ctJ6LM5aPDq5lCv93NcQMFFhIXfbMCqv1JiI13w?=
 =?us-ascii?Q?GwQKe5vu8fnRZ4pdT/7cwZDaOD6S/PQ1wiQ6F+93yfFvegGlWV2CWqyLa7jC?=
 =?us-ascii?Q?akcL+293zIGQ5MDaWdMvKSm644+VOADDV6/kJZ3uY5rlh/A8rLjbcm3GurE8?=
 =?us-ascii?Q?jokDcRvSbQ4Gv60WJBO4Bc7S4k0xDt6rWVFIuZ1DbefqfblgBYyRE3x1o2iW?=
 =?us-ascii?Q?eDq2wRLL+qVT8jF4bBSySgY9vIrhejwioryK+NkUr9KQe/YBt5NjaQExGurj?=
 =?us-ascii?Q?VdSnWwpQ1/n0F/W5PQeYUfctlaIXAfnrKUJ+hYcGlHvW37A0rRfgTP2bjVWj?=
 =?us-ascii?Q?pqid1vW4NMw93bhk/UCiv3UA3QthUOMJLr5qm8lvP7lM0gLoQ+XZKv6DzAg/?=
 =?us-ascii?Q?4ZsHDo4rHXz4HFTk28x+rnWL3+n3mR4xpIllDTumW+kWieTG1pReic5zRgyC?=
 =?us-ascii?Q?M/AQTSaTjBuqLVqdHFATGwRKHCL6uZqIThbGsJ/vzoZzoVcl0FMv8OQZ+Ce1?=
 =?us-ascii?Q?5pjKFkkWvOLVHT7cKIxp4f3GpSkvPPl8OBFCKBKvi/2hgbGkIG7nIjWSIUOh?=
 =?us-ascii?Q?ykmPWG6eaD3KLOA8vAD//qAcUm+pV4/29sNikFcO+DaX0ZVDu3ZQrqL2wxzl?=
 =?us-ascii?Q?i7f7Ts3xFn+dDOE7ewXiK47NlcP0AkxVogWTNsm4Q2ChpYHce4XAtCY1hUlH?=
 =?us-ascii?Q?c0EjFUC/VBevSr857mGYdWwElRuccETJh1zgKaNVb4kHDuXnbmz4MU+eSDdZ?=
 =?us-ascii?Q?0T8DGVgaV2W5wuC7RpAlWEn/DmfY+CB0xpRoLmAaOqqXH/Qg7+CS/XVf6e8i?=
 =?us-ascii?Q?MnabN0WkU6/OWRK1byz78a0uQHe5/x0WKpS0El23fbQ1WCQ1gTYJiuU81uId?=
 =?us-ascii?Q?mUjz50xJqvoLvlNUdRpzkZy5GU1TJBDz1PF8ewwW+RZcQwwonPZpopwY1KQi?=
 =?us-ascii?Q?35RhLTAVAyoL4VTAqRs0WvZ70lKd2DAuAd9tFagqUSDTlUt+I3PE4zs1o5H7?=
 =?us-ascii?Q?VNgt7yYKieLAIkkdZs3KVUPTsY9H4ErTtorXUbxVA++hClZIVr0JbClJo+I/?=
 =?us-ascii?Q?MjaOhD7u7eCX3EB5m/PFHK/ehSBnDeIW5qUCu/9bCsmwTvBpLVqGEhUDeHPx?=
 =?us-ascii?Q?KP+HX/ZrLinpI6vM0RzIVwWadx0A+cAZKEO4KOO8AM0nLWl/90S2YFMh0IX9?=
 =?us-ascii?Q?eqx2nnN6Py08ZSqL+iBf1c/Hqr64o3MU1rsTJyDJSuBu/eQmYyWuZBKcsDlm?=
 =?us-ascii?Q?/jQHdKy7hanuyjWhhBQGKAjvte6ax1Scutd56x4NrUiOO2JhSBxkX4nKGnIR?=
 =?us-ascii?Q?bMlTLLwNZu7U/sL93RARqExOhvhW990amOOEG5IyPuytp3wkI59xg1oIw45V?=
 =?us-ascii?Q?6mHIOEhDKOEd0kq45eBsyCLEZ4UayFYTqJenCYl1b+4HcCX+IK7shNHLQLLE?=
 =?us-ascii?Q?bJAlPdI23Q1iAeW5N1/StG979Ml/LbhZTY+Vgd+OgKHgKLcmIJocbWbjt5k8?=
 =?us-ascii?Q?lUr0MmXkOw=3D=3D?=
X-OriginatorOrg: deeproute.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: dec972a5-9ca0-42d3-ec7f-08df398c7791
X-MS-Exchange-CrossTenant-AuthSource: ZQZPR01MB0980.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 09:25:57.5354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: df535b4a-68e6-4339-a092-afa4f2c24fcc
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VZvlHazCv8hEnYhN+IPI8ZOSHSRH4eVOVb5D/H3vyuFoPXSnpE2VNuIFGntxHcyG2wIQF5kevvfKYQBf/WSJmM3mipDDRrzeZGjGx4YEnwU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQZPR01MB1074

From: jingxuanxie <jingxuanxie@deeproute.ai>

This is v3 of the TPACKET_V3 block-retirement fix. It replaces both v2
postings; please review only this thread.

v2 tried to remove the wait by allowing capture into the next block while
copies were still in flight. That required per-block copy accounting,
ordered publication, and handling for a backlog of ready blocks. Willem
asked for a smaller fix first: make block retirement non-blocking and let
the existing timer retry.

v3 does exactly that, in one patch:

- prb_retire_current_block() uses write_trylock() instead of write_lock().
  If a copier still holds the read lock, the current block and its
  metadata are left untouched and false is returned.
- __packet_lookup_frame_in_block() stops instead of dispatching the next
  block when retirement fails; tpacket_rcv() drops this capture record
  and accounts it in tp_drops. The original packet is not affected.
- The retirement timer re-arms and retries if it cannot take the lock.
- A later packet can also retire the block once the copier has finished.

There is no spillover into the next block, no per-block state, no worker
and no publication budget. The existing lock order and rwlock completion
ordering are preserved.

The cost is a higher capture drop rate while a copier is preempted. This
is a deliberate trade-off to keep the receive path moving on PREEMPT_RT.

The v2 1/2 virtio-header prevalidation patch is not part of v3. It is an
independent bug fix; I will rework it separately with a concrete
description of the state left behind and a shared error path, as Willem
asked.

Testing so far:
- ARM64 PREEMPT_RT W=3D1 build of af_packet.o: pass
- QEMU ARM64 SMP PREEMPT_RT (4 CPUs, lockdep, debug spinlocks):
  psock_tpacket and psock_fanout pass; three consecutive candidate
  boots pass the delayed-copier tests. The TCG fanout queue-length
  warning is also present on the unpatched baseline and the program
  exits 0.
- Full-block path: with A delayed, B's sendto returned in 0.7 ms, only
  B's capture record was dropped (tp_drops=3D1), and no block was
  published. After release, A and the next packet were published, B was
  absent, and payload and length were verified.
- Timer-only path: 15 failed timer trylocks while A was delayed; the
  timer published A after release.
- Close/unmap while A was delayed: no hang or crash.
- Baseline contrast: without the patch, B blocked 505 ms until A was
  released and was captured.
- Control-flow harness covering rx-busy, timer-busy, recovery, full ring
  and shutdown: 6/6 pass. checkpatch on the diff: clean.

Not yet run: Orin hardware, KASAN/KCSAN, and capture drop-rate or
latency measurements. Timings above are QEMU TCG observations, not
hardware RT guarantees.

v2 thread (second posting):
https://lore.kernel.org/netdev/20261030081704.251652-1-jingxuanxie@deeprout=
e.ai/

v2 review:
- 1/2: https://lore.kernel.org/netdev/willemdebruijn.kernel.17d3748debf8b@g=
mail.com/
- 2/2: https://lore.kernel.org/netdev/willemdebruijn.kernel.54d115047658@gm=
ail.com/

jingxuanxie (1):
  af_packet: avoid waiting for TPACKET_V3 copies at retirement

 net/packet/af_packet.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

base-commit: 1f1f8e8c5176234fa31858cd25f2e9b88aac0a45

