Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.17.127
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794537513;
	b=DSsLmMTnemYBZ0nC1iiiwvPX9BbO/CrYjS0FN+COe+lQ+FdgYPbgfQ4rGzVfKjHq81Hq
	 TX5sL1znrBR/HxtswCEBWlrzUXYfPNDc0gLtSpTfcf1SvVk3koObDCNp+/68UkoD+uBGp
	 jPsLnW8YYBl2V2wIwNO1pbazx5d0JghlSpCltTbkPA5h9/+D5tbzeKaumkX1dbjTZlLpL
	 SkUNSySknlxyRxoyECJN8yffHCt1S6+bEdzZzE6chJUBkYZlbpUwQjSCCOTkbT/vz3V7k
	 zsU0TUnkL1hofasEKUzwc15CVRA5ecEwwC9qN3GHEu8zXr1nc8/9AcbCUSFzt7SfXWA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794537513;
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
	bh=oTdzZ5kjQHApvFz7tjWKL2ru1giaDqeUZHcJ7zqewJI=;
	b=wjsHjqc7GIYkICBXksPP5KzUQmyEXn+0NtBCwqjam+yb26C+Iq0Zo5a7gAgK9CZy2RRe
	 2MgZteyeavZNo+lH6URl2rr7RFsHic4/FXC7+zMicdSFBkoLICrUkJsJKUtVKvh10BcG0
	 Z0+u3LiSXB0/kOxGv7oU6HOqvrdMZLHjLzFopZ+QmNVy+uJq36bT7bxIgA0HIWTIUft0g
	 HxWrgkmLVJ7+OK6FAl2orKBe4Mb4iQLTuTqfBIHu/P9pRhtE8/5erS6DG2RbqRgV08QRs
	 cDT5JXYILgPN/U50jVL+x7L780+TLvwpV6eRYKRqzlf6cJoHPycKq5QouuuFR/hAw1Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=deeproute.ai;
	spf=pass smtp.mailfrom=deeproute.ai;
	dkim=pass header.d=deeproute.ai header.i=@deeproute.ai header.a=rsa-sha256 header.s=selector1 header.b=AkSwZn0W;
	arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.17.127
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2127.outbound.protection.partner.outlook.cn [139.219.17.127])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF150606A31C;
	Fri, 13 Nov 2026 02:38:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF150606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=deeproute.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deeproute.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=deeproute.ai header.i=@deeproute.ai header.a=rsa-sha256 header.s=selector1 header.b=AkSwZn0W
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EXM41XvdwMRFjbSGff5PIRPvtQv5rsTuhxMl69VN846JRuFJ7PG6tGFt6r8GkNtflOjWBS2ZqUF3BsPJoX8PAsKAwNYoF8m8m/ZQeTSR3LCb3k+W9MXpnRaxAHTTelo+e8ElO4jdN7dPL10cyM51JmFSkXrUA/uGmtI3mcoMwT8K7I+dxOrMqgFtwJNDawa8AaFxbvo9BuiZykeoY/vQWdOvemcNvuCBoqOJp26tIbgn0ieonSkYAS8vVKRr8W13E7NSnbdBfJtdysRAbDCcrm1UQazMq6uaVGXX7Mgfy7PSbBbr/U7yiFZmLe49pMixbSiK9cvYkKRltf1GJYsoAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oTdzZ5kjQHApvFz7tjWKL2ru1giaDqeUZHcJ7zqewJI=;
 b=ZHJof4EWV6vhjMPpx6cdVmKCra2U0UTOm1VZfcUn2pb83V6fJesrPLd4GAuc1W6GqICStJidG5nOrta2voFyqEAtBR064YRRkpt5wMTNK7VG/DvKANCuTP1UUknlJy7l7h4Rqxk7YBFHwJ2K/jbq0UGK0x+La5f8LuJiVxUbiLuBnxU5dY/Sj0zDTPGoE0YR6+BkPwxTdTTq/3Tr3Tr2RYFlAfBwx+ul57QgpQfiRibrmUBtpb64vyZ39xITYZDwmG42Ss/KMHCM2pmDS7fTnPXaYVWlFtyq7GyJwlqOILDNsclKIFFiZeom9q6Fc5fjDwZwMKWwt6OG9V7Fm2MqYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=deeproute.ai; dmarc=pass action=none header.from=deeproute.ai;
 dkim=pass header.d=deeproute.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=deeproute.ai;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTdzZ5kjQHApvFz7tjWKL2ru1giaDqeUZHcJ7zqewJI=;
 b=AkSwZn0WnQ3/C4FM7GiL1Yl+UTV3jFYGfXVxrFB9cDG61Z3yPCRG33dTG3rkYNoIu6GbYgQz1nwqGW23KmQ5frZA9PGDo5tToHwboJbqJRvcwP+keEZvhJb4NJx4leixa2c/ziwWW2b/1b1c4IsFj7rZDlRcIQD0h2/noTFMBmA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=deeproute.ai;
Received: from ZQZPR01MB0980.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:a::9) by ZQZPR01MB1041.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:9::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Fri, 13 Nov
 2026 02:38:21 +0000
Received: from ZQZPR01MB0980.CHNPR01.prod.partner.outlook.cn
 ([fe80::2dda:e54d:5a3c:d686]) by
 ZQZPR01MB0980.CHNPR01.prod.partner.outlook.cn ([fe80::2dda:e54d:5a3c:d686%5])
 with mapi id 15.21.0615.008; Fri, 13 Nov 2026 02:38:21 +0000
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
Subject: [PATCH net v5] af_packet: avoid waiting for TPACKET_V3 copies at retirement
Date: Fri, 13 Nov 2026 02:38:09 +0000
Message-ID: <20261113023809.24730-1-jingxuanxie@deeproute.ai>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SH0PR01CA0020.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:5::32) To ZQZPR01MB0980.CHNPR01.prod.partner.outlook.cn
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
X-MS-TrafficTypeDiagnostic: ZQZPR01MB0980:EE_|ZQZPR01MB1041:EE_
X-MS-Office365-Filtering-Correlation-Id: b405b92c-96c1-4e9e-9d9f-08df412f2e92
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|52116014|261028144727099003|261022115727099003|261026135527099003|261026121527099003|261102123227099003|261026140227099003|261021135927099003|261026130827099003|261022075727099003|261021121427099003|56012099006|38350700014|261022113327099003|261021133027099003|261021123027099003|261022105027099003|261021130227099003|10067099003|261009223027099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ZbavXr5DKcAU9bS6O6jUDjzDzwDG1fXL5SFENEey8bqpDqDtvljDG7gCay1Vj5YzrJwdbmBaW6ojpYb3ZeTZ0IobJ9VfuacczxlDfzwO2MBOJxJ7Zp35I+H/1zqY7lq4IG2lV/RycCc5I47F0MCuh/Wk07mKbFO3bv7nOoLt0HlGm3eReCdk7SrUPyrmh7dqYL9vb1ALmN7YuV0xZDtxPRhfOfljmA5+5daYTQzLEO+0GmhAqzSPXH/QVZx6Kaf3s9SQ42jfAZVsantlcWOYZCcBGSVmb4940rmByzu5wClqijS4Iv+c8oU6c/sxRFfpUzSsOFMshQaKomL5/6ACHr3msxbO4UQFensxcKTPL1PpEpIj0ASqjyWBzCs8tLjs1tIS3SBh+CGUMB0qlxu/iOD1+88NaUrE7xmHsYDZx7XkIOwlpKLn5hNG5IzbctdkxoL2oIlaWFBDP8iY1ofthkgDRwwg8XHkHkn3oKMqaY3qrBAMSbXuJA9egpXIU8jXUESmDSBcsly6N+OqXevI2UsES5oNnLnd5Q6JzvKEJ91H/K91oa1NFZ6mBi814WCY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQZPR01MB0980.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(52116014)(261028144727099003)(261022115727099003)(261026135527099003)(261026121527099003)(261102123227099003)(261026140227099003)(261021135927099003)(261026130827099003)(261022075727099003)(261021121427099003)(56012099006)(38350700014)(261022113327099003)(261021133027099003)(261021123027099003)(261022105027099003)(261021130227099003)(10067099003)(261009223027099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bam+tcs6hcPo2lOLTGyogR4Bxotvd+D/d5Z2Ws5ZWK4I5F505apMPS3ggjqy?=
 =?us-ascii?Q?sp4XlK1cg3OCvyKjOn/X1HtDMBUQo0SPyGXm+X7gSO1sxV9Y5Yl9hC3vRl/q?=
 =?us-ascii?Q?0lA1ekEgxbPrRY3azakdmMylt1npwWT4n19GcoUPRemubY3UE2UxzCxw3Lc+?=
 =?us-ascii?Q?5+tOWoG2N6sYPF58HjmHJha/27mPSytMlGyl5or5n2UKq966YVCAV3H/POtF?=
 =?us-ascii?Q?aUvmuVp2rx2+XLAVbj7fvMoEbP++F2F6d96Ek1i1aMb0TEoZJ06IQcB8j109?=
 =?us-ascii?Q?UwL4W874vI5Q/+yITH0ZQz2DLoJx9xOqHG0ryGNLC6J72Kx6/BAe/24GbH4v?=
 =?us-ascii?Q?UcUpE3bm374EtUz17QPVYibApEH+bIHfEviZjBUMwwjIoVDn4TnkXcpgyNKz?=
 =?us-ascii?Q?MjaRFRIgK4QTGg9cxCjBWpwMUkZsgD9RLur0FGKPGt2A190sPQOuuT7j3hOW?=
 =?us-ascii?Q?o9OGMng+Rv2k2IiKrGhkGofsTE243+RP2doAJmohsDp+IxBvfpsTW/oW1sNM?=
 =?us-ascii?Q?6UgWcuVLJh9nDX74TK0/cpGZWwH24bamKnBb2y1AyjtIh2d2H0kfqA3WFq8n?=
 =?us-ascii?Q?MFHtTfPJNNp+T8yhcpbW71Xq8Z3CnQT/EXopqqjdLgdtl2S92GYmI42W8phe?=
 =?us-ascii?Q?XeKG87Mnx852KTbpHoqUkHE952XDfUhm6xFAnoD5oIOHho+So/CqTRW0V/VY?=
 =?us-ascii?Q?PkYecAEZZv9KTBLJ8BcA4CXNY95JpcWb6BNSWQUM6RzFsN+9cUz0s+nR2ng3?=
 =?us-ascii?Q?K0Wh6Dr0G3pvA5BgWMZUDzNhlJ3aiTi0bUg7Rp35FZ25hV+cevecZCj1GnXF?=
 =?us-ascii?Q?2+ASYMCBwERGytboh0oeU/ryhZ3fIf8fw42ZoL/s8gHs1AQynKw268XcQee2?=
 =?us-ascii?Q?SdzgRjqg2fnWsBxMk5aN3HD2GrTO4GVBcK4ig4SdBBG7pcAlMNJpUfwrC39o?=
 =?us-ascii?Q?LPfFD7G1Yva7MpWGETjH2wrwzmfaH9IHENOr9QI4XWcSCSSo0Pn4F5muUgmP?=
 =?us-ascii?Q?/6bOfziqs1KLoRae6MwqyGrHkcxaIsldCmcGFQN4Vi6b8do2+7VFx6rq6qFQ?=
 =?us-ascii?Q?bOXFcdN7FoCj+apKIj8tNdB5eIvB+Ce5HOALealw3Q9s3FD0IgwrCT7YqP52?=
 =?us-ascii?Q?CCPj/Wy1ujrKPc/juWccpd9AWtXFkMG1goSCzj9ITAknlIu7eEKOnamyGO7b?=
 =?us-ascii?Q?qoGhvcM/wzBNLLx4ZjDPSg//WL/pktYjPQs5roleOlEWQsjio7BQ99Pafrhy?=
 =?us-ascii?Q?g5xaqfwNStwhySToRqlTXIII089Rg6Gzl5MuTCF+bLVJ5eIsL7NAzWit4OFg?=
 =?us-ascii?Q?etcNp2Iza30QZg0jX4AG48D4DAZUiRBy5u1SzJh+i6n//wWWIrhyWgoI0QaA?=
 =?us-ascii?Q?f7llhFItlbwi6Xp2zyABi4KD2u73lyWD89lnWVxvEcLt/A7a0SuMs9cYswJS?=
 =?us-ascii?Q?2QHo1HK+7ABSl0gfDH4416aD1YWIoUF49yUDr+Q2W9mbUowosHyXvKAK3Yxx?=
 =?us-ascii?Q?ejbogmn5Axk5trUT/Z2rOj/2GP8661/4azUlR/vMlILwTnuVVXbYX1aamaQk?=
 =?us-ascii?Q?uiOuEySpGRjVKiJRV3Vju1RB3F5XdkQbKi+3S8LTqP1Mpc7trsPmiIEJ78D3?=
 =?us-ascii?Q?XtdlqiWwxFXSQQmyy/qq9kc+WZq6hoyDD98kZH4BKmpneWjxk7R7xmz4xeMs?=
 =?us-ascii?Q?+ubuMT5LPi3P7W7tnqWGta09ViWO2uBRktSC4Sh9hF02DXwdvt0/gZTPoq/Y?=
 =?us-ascii?Q?O6pEwCkh5g=3D=3D?=
X-OriginatorOrg: deeproute.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: b405b92c-96c1-4e9e-9d9f-08df412f2e92
X-MS-Exchange-CrossTenant-AuthSource: ZQZPR01MB0980.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 02:38:21.1990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: df535b4a-68e6-4339-a092-afa4f2c24fcc
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WuQYDQUTsuR1o6waSNcomB69M1s93uUs7kcyQ/bRBzODXRlB8KM3e8XpsfxS7pVHuXjTKqDLfAPwO5cMah9GfjQddBYUrr5HxZFaQ1+gKck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQZPR01MB1041

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
Changes in v5:
- Rebase onto net/main; no functional change, so the v4 Reviewed-by
  still applies.

Changes in v4:
- Limit the write_trylock() switch to PREEMPT_RT; non-PREEMPT_RT
  kernels keep the blocking write lock (Willem).
- Leave the existing indentation of prb_retire_current_block()
  unchanged (Willem).
- Add the discovery and reproduction information requested by
  netdev-bot.

v3: https://lore.kernel.org/r/20261103092541.273847-1-jingxuanxie@deeproute=
.ai
v4: https://lore.kernel.org/r/20261110072221.24701-1-jingxuanxie@deeproute.=
ai

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
index 7322256..e0ebd06 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -200,7 +200,7 @@ static void packet_increment_head(struct packet_ring_bu=
ffer *buff);
 static int prb_curr_blk_in_use(struct tpacket_block_desc *);
 static void *prb_dispatch_next_block(struct tpacket_kbdq_core *,
 			struct packet_sock *);
-static void prb_retire_current_block(struct tpacket_kbdq_core *,
+static bool prb_retire_current_block(struct tpacket_kbdq_core *,
 		struct packet_sock *, unsigned int status);
 static int prb_queue_frozen(struct tpacket_kbdq_core *);
 static void prb_open_block(struct tpacket_kbdq_core *,
@@ -677,6 +677,24 @@ static void init_prb_bdqc(struct packet_sock *po,
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
@@ -711,9 +729,9 @@ static enum hrtimer_restart prb_retire_rx_blk_timer_exp=
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
@@ -738,6 +756,7 @@ static enum hrtimer_restart prb_retire_rx_blk_timer_exp=
ired(struct hrtimer *t)
 		}
 	}
=20
+refresh_timer:
 	hrtimer_forward_now(&pkc->retire_blk_timer, pkc->interval_ktime);
 	spin_unlock(&po->sk.sk_receive_queue.lock);
 	return HRTIMER_RESTART;
@@ -946,7 +965,7 @@ static void *prb_dispatch_next_block(struct tpacket_kbd=
q_core *pkc,
 	return (void *)pkc->nxt_offset;
 }
=20
-static void prb_retire_current_block(struct tpacket_kbdq_core *pkc,
+static bool prb_retire_current_block(struct tpacket_kbdq_core *pkc,
 		struct packet_sock *po, unsigned int status)
 {
 	struct tpacket_block_desc *pbd =3D GET_CURR_PBLOCK_DESC_FROM_CORE(pkc);
@@ -963,13 +982,13 @@ static void prb_retire_current_block(struct tpacket_k=
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
@@ -1097,7 +1116,8 @@ static void *__packet_lookup_frame_in_block(struct pa=
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

