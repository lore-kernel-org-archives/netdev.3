Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.17.91
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793171194;
	b=urRkAbii7RD0yI9sNPe762Peb8NZH33G/aGF4OT7/gUOj5ea1JJfX8sxcpgf/yB+okDh
	 bpLzqmIMyEh02FS2fybcTCi7IOEQwFGt0DqoBaRP9Gi+VItzXNZ28afaowcJdiWQxGBNx
	 m7GlpiQ2nzgNaalpLlRmDhTpC5h+J5QhjQ4ChNfEZchMR+Zp1wgcklmZgrGmj62YsOM+e
	 cYsGMdxKW5mM30B9NN0mZjQh7iSKFmVuyk1HqELQMAKQmiMQRekb99G3kt0kyrjQHtt+s
	 ecF2YfvxmGlG4nfrcmnjYqaWtTH9AjUMUThY5KxEgGu7p1VkbCmrj8U13YT3t011UMA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793171194;
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
	bh=VCBN3EbwLuwAZlRMOsUGZ9k68UbbwHp7W/Oe6Es+zLQ=;
	b=fwnG5tz8JsvXqdllHNM0Jt3Fl0UXY+os4KA7Bs3SuGwPNKZ3/OBYqoYuSpm5LUXQs93u
	 MjX23HHEGw65n7az6aYC/4ilPCKW9MGezjuR7QBpxAKyPN5xVTAG37sY8rSHJoXKerYZw
	 EmxqlhDKRHE7mpmkQv5uAcHafrfYSOetxpmGswxKRnSl9dK5jb9CFwzU1wVJYoI/4QNY4
	 M83b9aMgahUq4tgyR0wNvh+VYe5QExxTaFzSdCBpRlgOA+n6OjgQe57jVp4L5pgJM4V+l
	 bWvFte1U6bpwK8d4f7BhMKKO0wZOk2VrV7WLEopM1hw/TbI8bzbWA8CwrAEJOEZM+Gg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=deeproute.ai;
	spf=pass smtp.mailfrom=deeproute.ai;
	dkim=pass header.d=deeproute.ai header.i=@deeproute.ai header.a=rsa-sha256 header.s=selector1 header.b=ja3b1bKN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.17.91
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2091.outbound.protection.partner.outlook.cn [139.219.17.91])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2F1606A31E
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 07:06:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A2F1606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=deeproute.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deeproute.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=deeproute.ai header.i=@deeproute.ai header.a=rsa-sha256 header.s=selector1 header.b=ja3b1bKN
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C5ru9ZCe92DTWu9YsUyb8dT43+Sy2Q4lZf6hII9Ed9okzIGIybMfBNiCQfPAja8x5NUOMIEXUpWmcCwtKctkMH9bv9YNHXCHf0RzsEq8QW4LTv1KyBt6rRs7slhuv5o57siqOMGq096CZ5KBaoP1Bq5M1tfboQOezw7oswXWxzTQQLJw5+SUnA2Xh2hHtcqX2kUz/B/txo2oGhI8w9QK49OAwttbT2KU8/fb6Qw2I3jG4mzmmJecmxBuq2Za/ZI+wW0utuHXxmcIDpHnZAwF3YCUeTrd8bBNbrSMNe5z6rkH46ziwayTydqEAdoJeInG2UY+37jFz4vCtixJ4qsB1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VCBN3EbwLuwAZlRMOsUGZ9k68UbbwHp7W/Oe6Es+zLQ=;
 b=PKayLgTPsIeKt3LrYIl8mIpIwV4zM8MTNZYEZ0FgdFxj7W48jdZhrTZNRcZ5Cw5MBmVeORvOLHgtxfScZra578GUshQZeHVf5/sYIVGwNTSLy0Bz4G8PHVOa196YcgHr/26BhFWwZu9cU4YgTkIJkQfJZ+ZXhwyEj1NXm9cpARDcva0m3eE1R+S6BBVtz7w2u4ypLmZCI+gc6BIuHFNNb4Zb9ViWpH3rkxPFMe+YlSjwGBASIkYvjRL/YsblbsoNBQYxD7XaWjdby/yMgRQ9nvwtASBKZXLJPKz+Jn7vvzNfOBufoPf/t6XujGppOI9dlGHtug58Ft6q3lpiHSohtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=deeproute.ai; dmarc=pass action=none header.from=deeproute.ai;
 dkim=pass header.d=deeproute.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=deeproute.ai;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VCBN3EbwLuwAZlRMOsUGZ9k68UbbwHp7W/Oe6Es+zLQ=;
 b=ja3b1bKN4n6/VIOlj/tHfGjWp/7+5MfRdy5+/SJwDqoKGKKbab0BawMtt7KoVGChm4sy/vNSw+LNsNciVlPIfjI381w/l2LUWRKiB4o+IALRAleCp1VIHdWBB5Q77PCtrNgrTwGPNN3aTjVx/h22dJZzdK52QfIUosLi612c4Fw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=deeproute.ai;
Received: from ZQZPR01MB0980.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:a::9) by ZQZPR01MB1042.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:8::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 07:06:25 +0000
Received: from ZQZPR01MB0980.CHNPR01.prod.partner.outlook.cn
 ([fe80::2dda:e54d:5a3c:d686]) by
 ZQZPR01MB0980.CHNPR01.prod.partner.outlook.cn ([fe80::2dda:e54d:5a3c:d686%3])
 with mapi id 15.21.0569.006; Wed, 28 Oct 2026 07:06:25 +0000
From: Jingxuan Xie <jingxuanxie@deeproute.ai>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Subject: [RFC net 2/2] af_packet: add KUnit coverage for asynchronous V3 retirement
Date: Wed, 28 Oct 2026 07:05:28 +0000
Message-ID: <20261028070528.139531-3-jingxuanxie@deeproute.ai>
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
X-MS-Office365-Filtering-Correlation-Id: ef2eb59e-5e42-4206-8c6e-08df34c1fb2a
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|23010399003|366016|1800799024|261026140227099003|38350700014|56012099006|261026121527099003|261021123027099003|261021121427099003|261022075727099003|261022115727099003|261009223027099003|261022105027099003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	fVathF7Mv81xkMNG5+9LeiEuf+DOn10soWR8O9HLVWfh4dQoKL9QLALo8oy6pFkMwpufpFy2Y/nyoBCgNnyGtIfJTCoM7qdWxUpwKLNQM0ZC/BqfqO+Hg2GuS4+IKFnlnCC9HQuJVssTt5JugDdUvegOaAjM/Id0VjM/Xor92Nl3rEGg7QwmHYuX2YMUh3frSiZ/LBzV7jckCxbBgPBVeAXO5OW4yNRNcmbgklgThLRB/vJMBzBo/+eGRVQ8FFekWaGc7fE2MRhVNCK8S1YZkpehiJcJEj80H6aIRZjMa5ltWlgeqa2KaWWi7d+uEpfRbXB81GM8hs0S+4n/UsUAVIFE1x73CV9q/uVkJGcgMynx0luoQJff/RFB9lXJvmbbboYF4V0cpRsAGTWeu/Ec4JMfDGZrCn8fPTVUynekQuDvIluU0poZQiaFhYDVJ5xKb9COk4rmGFpM0tnbLYkgoseXtxmU0ppahkNNpuFQ40FDJf54AtzL7zhBwwW350gH2gbitj3oxqWiNi18DjCaHwcnlVxcqxmZHbayAs21cu8DzKWIDxlQEd46pCfz4DGB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQZPR01MB0980.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(23010399003)(366016)(1800799024)(261026140227099003)(38350700014)(56012099006)(261026121527099003)(261021123027099003)(261021121427099003)(261022075727099003)(261022115727099003)(261009223027099003)(261022105027099003)(10067099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ofgrp8TgMAHPd/PR5PjIEBezTdttD4HmaahnlAA+jA/e8P60Tvzxrs9aOIsd?=
 =?us-ascii?Q?CtkD45lJNOwg5fRgeDg+gJJfAgtfFoq1nV8iXcoUQEQs3BXsshmEFLjZiF3Z?=
 =?us-ascii?Q?ybHHGP9d2ZB4SqLgxQCj0lRFlG7xGtYTBsF69vnNmjJVa/mEByYHwm0f3yfL?=
 =?us-ascii?Q?7bxXHpJlYgpfUTrH/skcJZx3eky2uJ0jNNMlwzwze1F8EGfWHYKCSZF2es7K?=
 =?us-ascii?Q?qtSX5rmR5h5THX5JR1XMVWGVdSeyX5CPC8PdEQT8URQmnZHRh8y+cTa5qDZY?=
 =?us-ascii?Q?fY/2NyrrOsZa6K7yZ5N7L/X7XisOuOhSMdxjgTGVe4f4Tdh8hU4jYRFcNqzE?=
 =?us-ascii?Q?Kwvfy5fXjlKCMBGPmUyvAjOKGnGzn0t0FmkL6jJF7Hk8TNripi9rmsv/0r5E?=
 =?us-ascii?Q?eDQCl06L5XvFpJIIHwjSFnzqvTEA29Zn8KbuQhawHgkLzeae0NChxPYCfR5G?=
 =?us-ascii?Q?lqJHa/Sefm5uzackPvqsYqFa/nnDaOV5k1FqWZmLcVHkbVLQj5ZaEJi98jVr?=
 =?us-ascii?Q?3my5iAW//MOSj8FBOzAvypjqWrgPV0c+0fRZtC6Il1o3u0l5TH3qVjdO9ori?=
 =?us-ascii?Q?abq+u/wPwRikqqghhstf8WFYXygqS5hEUUdXHqmjCxKj7Wz8rHbRz2S21ISk?=
 =?us-ascii?Q?GESX6HH576pSG8gFleR5HZ+YCh1b98/5oOmKBrodYAEI98NjwrBQcbJD80aP?=
 =?us-ascii?Q?HbxlMgdYfupMpScwMK3zVnntqnWdX6CioFPOIIU6tZyydVgpHAuIsDA68tdG?=
 =?us-ascii?Q?d8/r8KtboUgGJGlt3lObDl8ighS17AoMvmFJtXSKaKSE8mJYkQDsaDFyks98?=
 =?us-ascii?Q?U0GaDrBpgId1JIqeZfLXa9QvTH22Eo7fsJaw2jPATT8+J44RCauVWFpdpXy0?=
 =?us-ascii?Q?qsps8Vl6C3ra/+OSLZX83mizDq/c7IovBk9opC2CeJ64tM9VbKYf6yf3ogOR?=
 =?us-ascii?Q?v+Kgxw9rFzWZvlihOPwG1bxes+dkCozqXhwSw6eh4pnKeLPWOymTp89o6CaI?=
 =?us-ascii?Q?CvayAdS0Bb5hhDs/MYgKWFuc6PhUuSEWVcwc0LIscZ+oO6VelQfbDCknqV7N?=
 =?us-ascii?Q?eW8SBF3d2S6DP1eyZel9WL4n6gdP6gbNeeN3Gpvgdhr1Jp1uzpqnxuOCkY/A?=
 =?us-ascii?Q?YxPTMckr3OnZH2AkQNLZP6vJRO3Lf0QiEGWd4gGtXwjEw/tMMCSHzEpcjzjf?=
 =?us-ascii?Q?BC4kj6Pi0KNYp7lduwpW6gHjJfDecJIQFVAyEptPXekmUD80s9GtX1Edsmri?=
 =?us-ascii?Q?LwMMJGiP7G26+ZBu9HygKymLrhKVnl4MEIszItDk6+j6YQhFuzkEXXWd81bM?=
 =?us-ascii?Q?k4+/SLtMsewNgFOuSsUAEioYGRz53wUGFGDmskbLnPCzLlF5fiMyDT5ZAnTD?=
 =?us-ascii?Q?qAfv1BjzEeva6YfXZO4FPZDUX7HO3PHQnVWnpmSmJdimaJOj2waAMDGJI5zU?=
 =?us-ascii?Q?wDkoYzZFkxg4uh4/X+6KJ9bg3GtE4gSQjShkico0oypkRNJFE1TQtVtD9peg?=
 =?us-ascii?Q?O7bFvNHdvpxMPXli+mFpBEk2ww3aYCw+EnwikltQY9I1L7seTs+cHbvlqaCS?=
 =?us-ascii?Q?r2vK30wLbgjq6S00hnzlsj54FwAuhDOpIXVQ0tBBfUjoXZ4JjNe9cito3HM/?=
 =?us-ascii?Q?p++kXtvzERpi+ugUx7+jDPh0iRedX8m51MpX2s+rl6/ceyjLetVmzqRJ68bi?=
 =?us-ascii?Q?oYIBZ5Z92ByVsbf7SbT5mhXB+AmMY0whj5FyJrRsEQiCNKXsg2KR56J09Ljp?=
 =?us-ascii?Q?VzOm/FM32w=3D=3D?=
X-OriginatorOrg: deeproute.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: ef2eb59e-5e42-4206-8c6e-08df34c1fb2a
X-MS-Exchange-CrossTenant-AuthSource: ZQZPR01MB0980.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 07:06:25.7994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: df535b4a-68e6-4339-a092-afa4f2c24fcc
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pt3sTnsxO/r7XL3Xh6S4PXk8o2mQFcrefnpNpXQv92siV0CxhATh6LF7f7IntE8Hg2Br5vLlTiQJICB5VztRGTHdpD0ixF1WyGXVLLhLrQ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQZPR01MB1042

From: jingxuanxie <jingxuanxie@deeproute.ai>

Exercise the actual private reservation, completion, retirement,
timer, poll and ring lifecycle helpers from af_packet.c. Tests are
built only with PACKET_KUNIT_TEST and do not export production test
interfaces or require external packet traffic.

Cover unfinished A with writable B, ordered publication after B
finishes first, completion without subsequent traffic, both seal/copy
orderings, multiple copiers, empty timeouts, single/two-block rings,
exact fits, frozen USER/SEALED blocks, reuse after userspace returns
a block, bounded publication and worker shutdown. Also cover invalid
and valid virtio headers, V2 fallback skb cleanup, concurrent polling
during ring creation/teardown and 65536/65537-block cursor wraparound.

The packet-prb suite passes all 17 cases on QEMU ARM64 with four CPUs,
PREEMPT_RT and lockdep. The same guest passes psock_tpacket and
psock_fanout.

Assisted-by: LLM
Signed-off-by: Jingxuan Xie <jingxuanxie@deeproute.ai>
---
 net/packet/.kunitconfig     |  10 +
 net/packet/Kconfig          |   9 +
 net/packet/af_packet.c      |   4 +
 net/packet/af_packet_test.c | 649 ++++++++++++++++++++++++++++++++++++
 4 files changed, 672 insertions(+)
 create mode 100644 net/packet/.kunitconfig
 create mode 100644 net/packet/af_packet_test.c

diff --git a/net/packet/.kunitconfig b/net/packet/.kunitconfig
new file mode 100644
index 000000000000..baed7c14b1d7
--- /dev/null
+++ b/net/packet/.kunitconfig
@@ -0,0 +1,10 @@
+CONFIG_KUNIT=3Dy
+CONFIG_KUNIT_AUTORUN_ENABLED=3Dy
+CONFIG_NET=3Dy
+CONFIG_INET=3Dy
+CONFIG_PACKET=3Dy
+CONFIG_PACKET_KUNIT_TEST=3Dy
+CONFIG_DEBUG_KERNEL=3Dy
+CONFIG_DEBUG_SPINLOCK=3Dy
+CONFIG_DEBUG_LOCK_ALLOC=3Dy
+CONFIG_PROVE_LOCKING=3Dy
diff --git a/net/packet/Kconfig b/net/packet/Kconfig
index 2997382d597c..9f7190ff31df 100644
--- a/net/packet/Kconfig
+++ b/net/packet/Kconfig
@@ -23,3 +23,12 @@ config PACKET_DIAG
        help
          Support for PF_PACKET sockets monitoring interface used by the ss=
 tool.
          If unsure, say Y.
+
+config PACKET_KUNIT_TEST
+       bool "KUnit tests for TPACKET_V3 block retirement" if !KUNIT_ALL_TE=
STS
+       depends on KUNIT=3Dy && PACKET=3Dy
+       default KUNIT_ALL_TESTS
+       help
+         Test packet ring reservation, block retirement and ordered public=
ation.
+         These tests do not register a network device or require external =
traffic.
+         If unsure, say N.
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index b48982059a76..b8cb477eb754 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -5037,6 +5037,10 @@ static int __init packet_init(void)

 module_init(packet_init);
 module_exit(packet_exit);
+
+#if IS_ENABLED(CONFIG_PACKET_KUNIT_TEST)
+#include "af_packet_test.c"
+#endif
 MODULE_DESCRIPTION("Packet socket support (AF_PACKET)");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_NETPROTO(PF_PACKET);
diff --git a/net/packet/af_packet_test.c b/net/packet/af_packet_test.c
new file mode 100644
index 000000000000..ecb758e11ff6
--- /dev/null
+++ b/net/packet/af_packet_test.c
@@ -0,0 +1,649 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Included by af_packet.c so tests exercise the actual private helpers. *=
/
+#include <kunit/test.h>
+#include <linux/etherdevice.h>
+#include <linux/kthread.h>
+
+struct prb_test_context {
+       struct packet_sock *po;
+       struct socket socket;
+       struct net_device *dev;
+       struct pgv *blocks;
+       unsigned int notifications;
+};
+
+static void prb_test_data_ready(struct sock *sk)
+{
+       struct prb_test_context *ctx =3D sk->sk_user_data;
+
+       ctx->notifications++;
+}
+
+static int prb_test_init(struct kunit *test)
+{
+       struct prb_test_context *ctx;
+       union tpacket_req_u req =3D {};
+       unsigned int i;
+       int err;
+
+       ctx =3D kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+       if (!ctx)
+               return -ENOMEM;
+       test->priv =3D ctx;
+       ctx->po =3D kunit_kzalloc(test, sizeof(*ctx->po), GFP_KERNEL);
+       ctx->blocks =3D kunit_kcalloc(test, 16, sizeof(*ctx->blocks), GFP_K=
ERNEL);
+       if (!ctx->po || !ctx->blocks)
+               return -ENOMEM;
+       for (i =3D 0; i < 16; i++) {
+               ctx->blocks[i].buffer =3D kunit_kzalloc(test, PAGE_SIZE, GF=
P_KERNEL);
+               if (!ctx->blocks[i].buffer)
+                       return -ENOMEM;
+       }
+       ctx->dev =3D alloc_netdev(0, "prb%d", NET_NAME_UNKNOWN, ether_setup=
);
+       if (!ctx->dev)
+               return -ENOMEM;
+       dev_net_set(ctx->dev, &init_net);
+       sock_net_set(&ctx->po->sk, &init_net);
+       ctx->socket.type =3D SOCK_RAW;
+       init_waitqueue_head(&ctx->socket.wq.wait);
+       sock_init_data_uid(&ctx->socket, &ctx->po->sk, GLOBAL_ROOT_UID);
+       ctx->po->sk.sk_type =3D SOCK_RAW;
+       ctx->po->sk.sk_user_data =3D ctx;
+       ctx->po->sk.sk_data_ready =3D prb_test_data_ready;
+       ctx->po->prot_hook.func =3D tpacket_rcv;
+       ctx->po->prot_hook.af_packet_priv =3D &ctx->po->sk;
+       ctx->po->tp_version =3D TPACKET_V3;
+       ctx->po->tp_hdrlen =3D TPACKET3_HDRLEN;
+       ctx->po->rx_ring.pg_vec =3D ctx->blocks;
+       req.req3.tp_block_size =3D PAGE_SIZE;
+       req.req3.tp_block_nr =3D 16;
+       req.req3.tp_retire_blk_tov =3D 60000;
+       err =3D init_prb_bdqc(ctx->po, &ctx->po->rx_ring, ctx->blocks, &req=
);
+       if (err) {
+               free_netdev(ctx->dev);
+               return err;
+       }
+       hrtimer_cancel(&ctx->po->rx_ring.prb_bdqc.retire_blk_timer);
+       return 0;
+}
+
+static void prb_test_exit(struct kunit *test)
+{
+       struct prb_test_context *ctx =3D test->priv;
+
+       prb_shutdown_retire_blk_timer(ctx->po, &ctx->po->sk.sk_receive_queu=
e);
+       kvfree(ctx->po->rx_ring.prb_bdqc.blocks);
+       free_netdev(ctx->dev);
+}
+
+static void prb_test_invalid_vnet_does_not_reserve(struct kunit *test)
+{
+       struct prb_test_context *ctx =3D test->priv;
+       struct tpacket_block_desc *pbd =3D (void *)ctx->blocks[0].buffer;
+       struct sk_buff *skb =3D alloc_skb(128, GFP_KERNEL);
+
+       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, skb);
+       skb_put_zero(skb, 64);
+       skb_reset_mac_header(skb);
+       skb_reset_network_header(skb);
+       skb->dev =3D ctx->dev;
+       skb->protocol =3D htons(ETH_P_IP);
+       skb_shinfo(skb)->gso_size =3D 32;
+       skb_shinfo(skb)->gso_type =3D SKB_GSO_DODGY;
+       ctx->po->vnet_hdr_sz =3D sizeof(struct virtio_net_hdr);
+       tpacket_rcv(skb, ctx->dev, &ctx->po->prot_hook, ctx->dev);
+       KUNIT_EXPECT_EQ(test, BLOCK_NUM_PKTS(pbd), 0U);
+       KUNIT_EXPECT_EQ(test, BLOCK_LEN(pbd), (u32)BLK_PLUS_PRIV(0));
+       KUNIT_EXPECT_EQ(test, atomic_read(&ctx->po->tp_drops), 1);
+}
+
+struct prb_test_copy {
+       struct prb_block_state *block;
+       struct tpacket3_hdr *hdr;
+};
+
+static struct prb_test_copy prb_test_reserve(struct prb_test_context *ctx,
+                                            unsigned int length)
+{
+       struct tpacket_kbdq_core *pkc =3D &ctx->po->rx_ring.prb_bdqc;
+       struct prb_test_copy copy =3D {};
+       struct sk_buff skb =3D {};
+
+       spin_lock_bh(&ctx->po->sk.sk_receive_queue.lock);
+       copy.hdr =3D __packet_lookup_frame_in_block(ctx->po, &skb, length);
+       if (copy.hdr)
+               copy.block =3D &pkc->blocks[pkc->kactive_blk_num];
+       spin_unlock_bh(&ctx->po->sk.sk_receive_queue.lock);
+       return copy;
+}
+
+static void prb_test_complete(struct prb_test_context *ctx,
+                             struct prb_test_copy copy, unsigned int stamp=
)
+{
+       copy.hdr->tp_len =3D 64;
+       copy.hdr->tp_snaplen =3D 64;
+       copy.hdr->tp_sec =3D stamp;
+       copy.hdr->tp_nsec =3D stamp;
+       spin_lock_bh(&ctx->po->sk.sk_receive_queue.lock);
+       prb_complete_copy(ctx->po, copy.block);
+       spin_unlock_bh(&ctx->po->sk.sk_receive_queue.lock);
+}
+
+static void prb_test_seal(struct prb_test_context *ctx, unsigned int statu=
s)
+{
+       struct tpacket_kbdq_core *pkc =3D &ctx->po->rx_ring.prb_bdqc;
+
+       spin_lock_bh(&ctx->po->sk.sk_receive_queue.lock);
+       prb_retire_current_block(pkc, ctx->po, status);
+       prb_dispatch_next_block(pkc, ctx->po);
+       spin_unlock_bh(&ctx->po->sk.sk_receive_queue.lock);
+}
+
+static struct tpacket_block_desc *prb_test_block(struct prb_test_context *=
ctx,
+                                                unsigned int index)
+{
+       return (void *)ctx->blocks[index].buffer;
+}
+
+static void prb_test_busy_a_allows_b(struct kunit *test)
+{
+       struct prb_test_context *ctx =3D test->priv;
+       struct tpacket_kbdq_core *pkc =3D &ctx->po->rx_ring.prb_bdqc;
+       unsigned int length =3D pkc->max_frame_len - V3_ALIGNMENT;
+       struct prb_test_copy a =3D prb_test_reserve(ctx, length);
+       struct prb_test_copy b;
+
+       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, a.hdr);
+       b =3D prb_test_reserve(ctx, length);
+       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, b.hdr);
+       KUNIT_EXPECT_EQ(test, pkc->kactive_blk_num, 1U);
+       KUNIT_EXPECT_EQ(test, a.block->phase, PRB_BLOCK_SEALED);
+       KUNIT_EXPECT_EQ(test, b.block->phase, PRB_BLOCK_ACTIVE);
+       KUNIT_EXPECT_EQ(test, a.block->in_flight, 1U);
+       KUNIT_EXPECT_EQ(test, BLOCK_STATUS(prb_test_block(ctx, 0)), 0U);
+       KUNIT_EXPECT_FALSE(test, !!(packet_poll(NULL, &ctx->socket, NULL) &=
 EPOLLIN));
+       prb_test_complete(ctx, b, 22);
+       prb_test_seal(ctx, 0);
+       KUNIT_EXPECT_EQ(test, ctx->notifications, 0U);
+       KUNIT_EXPECT_EQ(test, BLOCK_STATUS(prb_test_block(ctx, 1)), 0U);
+       prb_test_complete(ctx, a, 11);
+       KUNIT_EXPECT_EQ(test, ctx->notifications, 2U);
+       KUNIT_EXPECT_EQ(test, pkc->sealed_blocks, 0U);
+       KUNIT_EXPECT_EQ(test, BLOCK_STATUS(prb_test_block(ctx, 0)), TP_STAT=
US_USER);
+       KUNIT_EXPECT_EQ(test, BLOCK_STATUS(prb_test_block(ctx, 1)), TP_STAT=
US_USER);
+       KUNIT_EXPECT_EQ(test, prb_test_block(ctx, 0)->hdr.bh1.ts_last_pkt.t=
s_sec, 11U);
+       KUNIT_EXPECT_EQ(test, prb_test_block(ctx, 1)->hdr.bh1.ts_last_pkt.t=
s_sec, 22U);
+       KUNIT_EXPECT_EQ(test, BLOCK_SNUM(prb_test_block(ctx, 0)), 1ULL);
+       KUNIT_EXPECT_EQ(test, BLOCK_SNUM(prb_test_block(ctx, 1)), 2ULL);
+       KUNIT_EXPECT_EQ(test, a.hdr->tp_next_offset, 0U);
+       KUNIT_EXPECT_EQ(test, b.hdr->tp_next_offset, 0U);
+       KUNIT_EXPECT_TRUE(test, !!(packet_poll(NULL, &ctx->socket, NULL) & =
EPOLLIN));
+}
+
+static void prb_test_complete_before_seal(struct kunit *test)
+{
+       struct prb_test_context *ctx =3D test->priv;
+       struct prb_test_copy copy =3D prb_test_reserve(ctx, 128);
+
+       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, copy.hdr);
+       prb_test_complete(ctx, copy, 7);
+       KUNIT_EXPECT_EQ(test, ctx->notifications, 0U);
+       prb_test_seal(ctx, 0);
+       KUNIT_EXPECT_EQ(test, ctx->notifications, 1U);
+       KUNIT_EXPECT_EQ(test, BLOCK_STATUS(prb_test_block(ctx, 0)), TP_STAT=
US_USER);
+}
+
+static void prb_test_multiple_copiers(struct kunit *test)
+{
+       struct prb_test_context *ctx =3D test->priv;
+       struct prb_test_copy first =3D prb_test_reserve(ctx, 128);
+       struct prb_test_copy last =3D prb_test_reserve(ctx, 128);
+
+       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, first.hdr);
+       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, last.hdr);
+       KUNIT_EXPECT_PTR_EQ(test, first.block, last.block);
+       prb_test_seal(ctx, 0);
+       prb_test_complete(ctx, last, 20);
+       KUNIT_EXPECT_EQ(test, ctx->notifications, 0U);
+       prb_test_complete(ctx, first, 10);
+       KUNIT_EXPECT_EQ(test, ctx->notifications, 1U);
+       KUNIT_EXPECT_EQ(test, prb_test_block(ctx, 0)->hdr.bh1.ts_last_pkt.t=
s_sec, 20U);
+}
+
+static void prb_test_timeout_busy_and_empty(struct kunit *test)
+{
+       struct prb_test_context *ctx =3D test->priv;
+       struct tpacket_kbdq_core *pkc =3D &ctx->po->rx_ring.prb_bdqc;
+       struct prb_test_copy copy;
+
+       prb_retire_rx_blk_timer_expired(&pkc->retire_blk_timer);
+       KUNIT_EXPECT_EQ(test, pkc->kactive_blk_num, 0U);
+       KUNIT_EXPECT_EQ(test, ctx->notifications, 0U);
+       copy =3D prb_test_reserve(ctx, 128);
+       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, copy.hdr);
+       prb_retire_rx_blk_timer_expired(&pkc->retire_blk_timer);
+       KUNIT_EXPECT_EQ(test, pkc->kactive_blk_num, 1U);
+       KUNIT_EXPECT_EQ(test, ctx->notifications, 0U);
+       prb_test_complete(ctx, copy, 9);
+       KUNIT_EXPECT_EQ(test, BLOCK_STATUS(prb_test_block(ctx, 0)),
+                       (u32)(TP_STATUS_USER | TP_STATUS_BLK_TMO));
+       KUNIT_EXPECT_TRUE(test, !!(packet_poll(NULL, &ctx->socket, NULL) & =
EPOLLIN));
+}
+
+static void prb_test_single_block_wrap(struct kunit *test)
+{
+       struct prb_test_context *ctx =3D test->priv;
+       struct tpacket_kbdq_core *pkc =3D &ctx->po->rx_ring.prb_bdqc;
+       struct prb_test_copy copy, next;
+
+       pkc->knum_blocks =3D 1;
+       copy =3D prb_test_reserve(ctx, pkc->max_frame_len - V3_ALIGNMENT);
+       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, copy.hdr);
+       next =3D prb_test_reserve(ctx, 128);
+       KUNIT_EXPECT_PTR_EQ(test, next.hdr, NULL);
+       KUNIT_EXPECT_EQ(test, pkc->sealed_blocks, 1U);
+       KUNIT_EXPECT_EQ(test, __packet_rcv_has_room(ctx->po, NULL), ROOM_NO=
NE);
+       prb_test_complete(ctx, copy, 3);
+       next =3D prb_test_reserve(ctx, 128);
+       KUNIT_EXPECT_PTR_EQ(test, next.hdr, NULL);
+       WRITE_ONCE(BLOCK_STATUS(prb_test_block(ctx, 0)), TP_STATUS_KERNEL);
+       next =3D prb_test_reserve(ctx, 128);
+       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, next.hdr);
+       KUNIT_EXPECT_EQ(test, BLOCK_SNUM(prb_test_block(ctx, 0)), 2ULL);
+       KUNIT_EXPECT_EQ(test, next.block->in_flight, 1U);
+       prb_test_complete(ctx, next, 4);
+       prb_test_seal(ctx, 0);
+       KUNIT_EXPECT_EQ(test, ctx->notifications, 2U);
+}
+
+static void prb_test_exact_fit(struct kunit *test)
+{
+       struct prb_test_context *ctx =3D test->priv;
+       struct tpacket_kbdq_core *pkc =3D &ctx->po->rx_ring.prb_bdqc;
+       struct prb_test_copy copy =3D prb_test_reserve(ctx, pkc->max_frame_=
len);
+       struct prb_test_copy next;
+
+       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, copy.hdr);
+       KUNIT_EXPECT_EQ(test, BLOCK_LEN(prb_test_block(ctx, 0)), pkc->kblk_=
size);
+       next =3D prb_test_reserve(ctx, 128);
+       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, next.hdr);
+       KUNIT_EXPECT_PTR_EQ(test, next.block, &pkc->blocks[1]);
+       prb_test_complete(ctx, next, 2);
+       prb_test_seal(ctx, 0);
+       prb_test_complete(ctx, copy, 1);
+       KUNIT_EXPECT_EQ(test, ctx->notifications, 2U);
+}
+
+static void prb_test_no_scan_past_user(struct kunit *test)
+{
+       struct prb_test_context *ctx =3D test->priv;
+       struct tpacket_kbdq_core *pkc =3D &ctx->po->rx_ring.prb_bdqc;
+       struct prb_test_copy copy =3D prb_test_reserve(ctx, 128);
+       struct prb_test_copy next;
+
+       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, copy.hdr);
+       pkc->blocks[1].phase =3D PRB_BLOCK_USER;
+       BLOCK_STATUS(prb_test_block(ctx, 1)) =3D TP_STATUS_USER;
+       prb_test_seal(ctx, 0);
+       next =3D prb_test_reserve(ctx, 128);
+       KUNIT_EXPECT_PTR_EQ(test, next.hdr, NULL);
+       KUNIT_EXPECT_EQ(test, pkc->blocks[2].phase, PRB_BLOCK_FREE);
+       prb_test_complete(ctx, copy, 1);
+       WRITE_ONCE(BLOCK_STATUS(prb_test_block(ctx, 1)), TP_STATUS_KERNEL);
+       next =3D prb_test_reserve(ctx, 128);
+       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, next.hdr);
+       KUNIT_EXPECT_PTR_EQ(test, next.block, &pkc->blocks[1]);
+       prb_test_complete(ctx, next, 2);
+}
+
+static void prb_test_no_reuse_of_sealed(struct kunit *test)
+{
+       struct prb_test_context *ctx =3D test->priv;
+       struct tpacket_kbdq_core *pkc =3D &ctx->po->rx_ring.prb_bdqc;
+       struct prb_test_copy a, b, next;
+       unsigned int length =3D pkc->max_frame_len - V3_ALIGNMENT;
+
+       pkc->knum_blocks =3D 2;
+       a =3D prb_test_reserve(ctx, length);
+       b =3D prb_test_reserve(ctx, length);
+       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, a.hdr);
+       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, b.hdr);
+       next =3D prb_test_reserve(ctx, 128);
+       KUNIT_EXPECT_PTR_EQ(test, next.hdr, NULL);
+       KUNIT_EXPECT_EQ(test, pkc->sealed_blocks, 2U);
+       KUNIT_EXPECT_EQ(test, a.block->in_flight, 1U);
+       KUNIT_EXPECT_EQ(test, __packet_rcv_has_room(ctx->po, NULL), ROOM_NO=
NE);
+       prb_test_complete(ctx, b, 2);
+       KUNIT_EXPECT_EQ(test, ctx->notifications, 0U);
+       prb_test_complete(ctx, a, 1);
+       KUNIT_EXPECT_EQ(test, ctx->notifications, 2U);
+       WRITE_ONCE(BLOCK_STATUS(prb_test_block(ctx, 0)), TP_STATUS_KERNEL);
+       next =3D prb_test_reserve(ctx, 128);
+       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, next.hdr);
+       prb_test_complete(ctx, next, 3);
+}
+
+static void prb_test_large_ring_wrap(struct kunit *test, unsigned int coun=
t)
+{
+       struct prb_test_context *ctx =3D test->priv;
+       struct tpacket_kbdq_core *pkc =3D &ctx->po->rx_ring.prb_bdqc;
+       struct prb_block_state *states;
+       struct prb_test_copy copies[4];
+       struct pgv *pages;
+       unsigned int start =3D 65534, i;
+
+       pages =3D kunit_kcalloc(test, count, sizeof(*pages), GFP_KERNEL);
+       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pages);
+       states =3D kvcalloc(count, sizeof(*states), GFP_KERNEL);
+       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, states);
+       /* Only blocks around the wrap point need backing storage. */
+       for (i =3D 0; i <=3D ARRAY_SIZE(copies); i++)
+               pages[(start + i) % count].buffer =3D ctx->blocks[i].buffer=
;
+       kvfree(pkc->blocks);
+       ctx->blocks =3D pages;
+       ctx->po->rx_ring.pg_vec =3D pages;
+       pkc->pkbdq =3D pages;
+       pkc->blocks =3D states;
+       pkc->knum_blocks =3D count;
+       pkc->kactive_blk_num =3D start;
+       prb_open_block(pkc, prb_test_block(ctx, start));
+       for (i =3D 0; i < ARRAY_SIZE(copies); i++) {
+               copies[i] =3D prb_test_reserve(ctx, pkc->max_frame_len);
+               KUNIT_ASSERT_NOT_ERR_OR_NULL(test, copies[i].hdr);
+               KUNIT_EXPECT_EQ(test, pkc->kactive_blk_num, (start + i) % c=
ount);
+       }
+       prb_test_seal(ctx, 0);
+       for (i =3D 1; i < ARRAY_SIZE(copies); i++)
+               prb_test_complete(ctx, copies[i], i + 1);
+       KUNIT_EXPECT_EQ(test, ctx->notifications, 0U);
+       prb_test_complete(ctx, copies[0], 1);
+       KUNIT_EXPECT_EQ(test, ctx->notifications, 4U);
+       KUNIT_EXPECT_EQ(test, pkc->sealed_blocks, 0U);
+       KUNIT_EXPECT_EQ(test, pkc->publish_blk_num, (start + 4) % count);
+       for (i =3D 0; i < ARRAY_SIZE(copies); i++) {
+               struct tpacket_block_desc *pbd =3D prb_test_block(ctx, (sta=
rt + i) % count);
+
+               KUNIT_EXPECT_EQ(test, BLOCK_STATUS(pbd), TP_STATUS_USER);
+               KUNIT_EXPECT_EQ(test, BLOCK_SNUM(pbd), (u64)i + 2);
+       }
+}
+
+static void prb_test_65536_blocks(struct kunit *test)
+{
+       prb_test_large_ring_wrap(test, 65536);
+}
+
+static void prb_test_65537_blocks(struct kunit *test)
+{
+       prb_test_large_ring_wrap(test, 65537);
+}
+
+static void prb_test_bounded_publish_and_worker(struct kunit *test)
+{
+       struct prb_test_context *ctx =3D test->priv;
+       struct tpacket_kbdq_core *pkc =3D &ctx->po->rx_ring.prb_bdqc;
+       struct prb_test_copy copies[12];
+       unsigned int i, notifications, pending;
+
+       for (i =3D 0; i < ARRAY_SIZE(copies); i++) {
+               copies[i] =3D prb_test_reserve(ctx, pkc->max_frame_len - V3=
_ALIGNMENT);
+               KUNIT_ASSERT_NOT_ERR_OR_NULL(test, copies[i].hdr);
+       }
+       prb_test_seal(ctx, 0);
+       for (i =3D 1; i < ARRAY_SIZE(copies); i++)
+               prb_test_complete(ctx, copies[i], i + 1);
+       copies[0].hdr->tp_sec =3D 1;
+       spin_lock_bh(&ctx->po->sk.sk_receive_queue.lock);
+       prb_complete_copy(ctx->po, copies[0].block);
+       notifications =3D ctx->notifications;
+       pending =3D pkc->sealed_blocks;
+       spin_unlock_bh(&ctx->po->sk.sk_receive_queue.lock);
+       KUNIT_EXPECT_EQ(test, notifications, (unsigned int)PRB_PUBLISH_BUDG=
ET);
+       KUNIT_EXPECT_EQ(test, pending, 4U);
+       flush_work(&pkc->retire_work);
+       KUNIT_EXPECT_EQ(test, ctx->notifications, 12U);
+       KUNIT_EXPECT_EQ(test, pkc->sealed_blocks, 0U);
+       for (i =3D 0; i < ARRAY_SIZE(copies); i++) {
+               KUNIT_EXPECT_EQ(test, BLOCK_STATUS(prb_test_block(ctx, i)),=
 TP_STATUS_USER);
+               KUNIT_EXPECT_EQ(test, BLOCK_SNUM(prb_test_block(ctx, i)), (=
u64)i + 1);
+       }
+}
+
+static void prb_test_shutdown_stops_publication(struct kunit *test)
+{
+       struct prb_test_context *ctx =3D test->priv;
+       struct tpacket_kbdq_core *pkc =3D &ctx->po->rx_ring.prb_bdqc;
+       struct prb_test_copy copy =3D prb_test_reserve(ctx, 128);
+
+       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, copy.hdr);
+       prb_test_seal(ctx, 0);
+       spin_lock_bh(&ctx->po->sk.sk_receive_queue.lock);
+       queue_work(system_dfl_wq, &pkc->retire_work);
+       pkc->retire_shutdown =3D true;
+       spin_unlock_bh(&ctx->po->sk.sk_receive_queue.lock);
+       prb_shutdown_retire_blk_timer(ctx->po, &ctx->po->sk.sk_receive_queu=
e);
+       prb_test_complete(ctx, copy, 1);
+       KUNIT_EXPECT_EQ(test, ctx->notifications, 0U);
+       KUNIT_EXPECT_FALSE(test, work_pending(&pkc->retire_work));
+       KUNIT_EXPECT_FALSE(test, hrtimer_active(&pkc->retire_blk_timer));
+}
+
+static void prb_test_payload_and_full_ring_drop(struct kunit *test)
+{
+       struct prb_test_context *ctx =3D test->priv;
+       struct tpacket_kbdq_core *pkc =3D &ctx->po->rx_ring.prb_bdqc;
+       struct tpacket_block_desc *pbd =3D prb_test_block(ctx, 0);
+       struct tpacket3_hdr *hdr;
+       struct sk_buff *skb;
+       unsigned int i;
+
+       pkc->knum_blocks =3D 1;
+       for (i =3D 0; i < 2; i++) {
+               skb =3D alloc_skb(128, GFP_KERNEL);
+               KUNIT_ASSERT_NOT_ERR_OR_NULL(test, skb);
+               memset(skb_put(skb, 64), 0x5a + i, 64);
+               skb_reset_mac_header(skb);
+               skb_reset_network_header(skb);
+               skb->dev =3D ctx->dev;
+               skb->protocol =3D htons(ETH_P_IP);
+               local_bh_disable();
+               tpacket_rcv(skb, ctx->dev, &ctx->po->prot_hook, ctx->dev);
+               local_bh_enable();
+               if (!i)
+                       prb_test_seal(ctx, 0);
+       }
+       KUNIT_EXPECT_EQ(test, atomic_read(&ctx->po->tp_drops), 1);
+       KUNIT_EXPECT_EQ(test, pkc->blocks[0].in_flight, 0U);
+       KUNIT_EXPECT_EQ(test, BLOCK_NUM_PKTS(pbd), 1U);
+       hdr =3D (void *)((char *)pbd + pbd->hdr.bh1.offset_to_first_pkt);
+       KUNIT_EXPECT_EQ(test, hdr->tp_len, 64U);
+       KUNIT_EXPECT_EQ(test, hdr->tp_snaplen, 64U);
+       KUNIT_EXPECT_EQ(test, hdr->tp_next_offset, 0U);
+       for (i =3D 0; i < 64; i++)
+               KUNIT_EXPECT_EQ(test, *((u8 *)hdr + hdr->tp_mac + i), (u8)0=
x5a);
+}
+
+static void prb_test_valid_vnet_header(struct kunit *test)
+{
+       struct prb_test_context *ctx =3D test->priv;
+       struct tpacket_block_desc *pbd =3D prb_test_block(ctx, 0);
+       struct tpacket3_hdr *hdr;
+       struct virtio_net_hdr *vnet;
+       struct sk_buff *skb =3D alloc_skb(128, GFP_KERNEL);
+       unsigned int i;
+
+       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, skb);
+       memset(skb_put(skb, 64), 0x5a, 64);
+       skb_reset_mac_header(skb);
+       skb_reset_network_header(skb);
+       skb->dev =3D ctx->dev;
+       skb->protocol =3D htons(ETH_P_IP);
+       skb_shinfo(skb)->gso_size =3D 32;
+       skb_shinfo(skb)->gso_type =3D SKB_GSO_TCPV4 | SKB_GSO_TCP_ECN;
+       skb->ip_summed =3D CHECKSUM_PARTIAL;
+       skb->csum_start =3D skb_headroom(skb) + 20;
+       skb->csum_offset =3D 16;
+       ctx->po->vnet_hdr_sz =3D sizeof(struct virtio_net_hdr);
+       local_bh_disable();
+       tpacket_rcv(skb, ctx->dev, &ctx->po->prot_hook, ctx->dev);
+       local_bh_enable();
+       prb_test_seal(ctx, 0);
+       KUNIT_EXPECT_EQ(test, atomic_read(&ctx->po->tp_drops), 0);
+       KUNIT_EXPECT_EQ(test, BLOCK_NUM_PKTS(pbd), 1U);
+       hdr =3D (void *)((char *)pbd + pbd->hdr.bh1.offset_to_first_pkt);
+       vnet =3D (void *)((char *)hdr + hdr->tp_mac - sizeof(*vnet));
+       KUNIT_EXPECT_EQ(test, vnet->gso_type,
+                       (u8)(VIRTIO_NET_HDR_GSO_TCPV4 | VIRTIO_NET_HDR_GSO_=
ECN));
+       KUNIT_EXPECT_EQ(test, vnet->flags, (u8)VIRTIO_NET_HDR_F_NEEDS_CSUM)=
;
+       KUNIT_EXPECT_EQ(test, __virtio16_to_cpu(vio_le(), vnet->hdr_len), (=
u16)64);
+       KUNIT_EXPECT_EQ(test, __virtio16_to_cpu(vio_le(), vnet->gso_size), =
(u16)32);
+       KUNIT_EXPECT_EQ(test, __virtio16_to_cpu(vio_le(), vnet->csum_start)=
, (u16)20);
+       KUNIT_EXPECT_EQ(test, __virtio16_to_cpu(vio_le(), vnet->csum_offset=
), (u16)16);
+       KUNIT_EXPECT_EQ(test, hdr->tp_snaplen, 64U);
+       for (i =3D 0; i < 64; i++)
+               KUNIT_EXPECT_EQ(test, *((u8 *)hdr + hdr->tp_mac + i), (u8)0=
x5a);
+}
+
+static void prb_test_invalid_vnet_releases_copy(struct kunit *test)
+{
+       struct prb_test_context *ctx =3D test->priv;
+       struct sk_buff *skb =3D alloc_skb(512, GFP_KERNEL);
+       struct packet_sock *po =3D ctx->po;
+
+       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, skb);
+       skb_put_zero(skb, 256);
+       skb_reset_mac_header(skb);
+       skb_reset_network_header(skb);
+       skb->dev =3D ctx->dev;
+       skb->protocol =3D htons(ETH_P_IP);
+       skb_shinfo(skb)->gso_size =3D 32;
+       skb_shinfo(skb)->gso_type =3D SKB_GSO_DODGY;
+       po->tp_version =3D TPACKET_V2;
+       po->sk.sk_prot =3D &packet_proto;
+       po->tp_hdrlen =3D TPACKET2_HDRLEN;
+       po->rx_ring.frame_size =3D 128;
+       po->rx_ring.frames_per_block =3D PAGE_SIZE / 128;
+       WRITE_ONCE(((struct tpacket2_hdr *)ctx->blocks[0].buffer)->tp_statu=
s,
+                  TP_STATUS_KERNEL);
+       po->vnet_hdr_sz =3D sizeof(struct virtio_net_hdr);
+       po->copy_thresh =3D 1;
+       local_bh_disable();
+       tpacket_rcv(skb, ctx->dev, &po->prot_hook, ctx->dev);
+       local_bh_enable();
+       KUNIT_EXPECT_EQ(test, atomic_read(&po->sk.sk_rmem_alloc), 0);
+       KUNIT_EXPECT_EQ(test, atomic_read(&po->tp_drops), 1);
+       KUNIT_EXPECT_TRUE(test, skb_queue_empty(&po->sk.sk_receive_queue));
+}
+
+struct prb_test_poller {
+       struct socket socket;
+       atomic_t polls;
+       struct completion started;
+};
+
+static int prb_test_poll_thread(void *data)
+{
+       struct prb_test_poller *poller =3D data;
+       struct packet_sock *po =3D pkt_sk(poller->socket.sk);
+
+       while (!kthread_should_stop()) {
+               packet_sock_flag_set(po, PACKET_SOCK_PRESSURE, true);
+               packet_poll(NULL, &poller->socket, NULL);
+               if (atomic_inc_return(&poller->polls) =3D=3D 1)
+                       complete(&poller->started);
+               cond_resched();
+       }
+       return 0;
+}
+
+static void prb_test_ring_lifecycle(struct kunit *test)
+{
+       struct packet_sock *po;
+       struct prb_test_poller *poller;
+       struct task_struct *task;
+       union tpacket_req_u req =3D {}, empty =3D {};
+       unsigned int i;
+       int result;
+
+       po =3D kunit_kzalloc(test, sizeof(*po), GFP_KERNEL);
+       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, po);
+       poller =3D kunit_kzalloc(test, sizeof(*poller), GFP_KERNEL);
+       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, poller);
+       sock_net_set(&po->sk, &init_net);
+       init_waitqueue_head(&poller->socket.wq.wait);
+       sock_init_data_uid(&poller->socket, &po->sk, GLOBAL_ROOT_UID);
+       mutex_init(&po->pg_vec_lock);
+       spin_lock_init(&po->bind_lock);
+       po->tp_version =3D TPACKET_V3;
+       po->sk.sk_type =3D SOCK_RAW;
+       po->prot_hook.func =3D packet_rcv;
+       init_completion(&poller->started);
+       task =3D kthread_run(prb_test_poll_thread, poller, "prb-poll-test")=
;
+       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, task);
+       KUNIT_EXPECT_NE(test, wait_for_completion_timeout(&poller->started,=
 HZ), 0UL);
+       for (i =3D 0; i < 16; i++) {
+               memset(&req, 0, sizeof(req));
+               memset(&empty, 0, sizeof(empty));
+               req.req3.tp_block_size =3D PAGE_SIZE;
+               req.req3.tp_block_nr =3D 2;
+               req.req3.tp_frame_size =3D 256;
+               req.req3.tp_frame_nr =3D 2 * PAGE_SIZE / 256;
+               req.req3.tp_retire_blk_tov =3D 1000;
+               result =3D packet_set_ring(&po->sk, &req, 0, 0);
+               KUNIT_EXPECT_EQ(test, result, 0);
+               if (result)
+                       break;
+               KUNIT_EXPECT_NOT_ERR_OR_NULL(test, po->rx_ring.pg_vec);
+               KUNIT_EXPECT_NOT_ERR_OR_NULL(test, po->rx_ring.prb_bdqc.blo=
cks);
+               queue_work(system_dfl_wq, &po->rx_ring.prb_bdqc.retire_work=
);
+               atomic_long_set(&po->mapped, 1);
+               KUNIT_EXPECT_EQ(test, packet_set_ring(&po->sk, &empty, 0, 0=
), -EBUSY);
+               KUNIT_EXPECT_NOT_ERR_OR_NULL(test, po->rx_ring.pg_vec);
+               atomic_long_set(&po->mapped, 0);
+               result =3D packet_set_ring(&po->sk, &empty, 1, 0);
+               KUNIT_EXPECT_EQ(test, result, 0);
+               if (result)
+                       break;
+               KUNIT_EXPECT_PTR_EQ(test, po->rx_ring.pg_vec, NULL);
+               KUNIT_EXPECT_PTR_EQ(test, po->rx_ring.prb_bdqc.blocks, NULL=
);
+               KUNIT_EXPECT_FALSE(test, hrtimer_active(&po->rx_ring.prb_bd=
qc.retire_blk_timer));
+               KUNIT_EXPECT_FALSE(test, work_pending(&po->rx_ring.prb_bdqc=
.retire_work));
+               schedule_timeout_uninterruptible(1);
+       }
+       kthread_stop(task);
+       KUNIT_EXPECT_GT(test, atomic_read(&poller->polls), 0);
+       if (po->rx_ring.pg_vec) {
+               memset(&empty, 0, sizeof(empty));
+               packet_set_ring(&po->sk, &empty, 1, 0);
+       }
+}
+
+static struct kunit_case prb_test_cases[] =3D {
+       KUNIT_CASE(prb_test_invalid_vnet_does_not_reserve),
+       KUNIT_CASE(prb_test_busy_a_allows_b),
+       KUNIT_CASE(prb_test_complete_before_seal),
+       KUNIT_CASE(prb_test_multiple_copiers),
+       KUNIT_CASE(prb_test_timeout_busy_and_empty),
+       KUNIT_CASE(prb_test_single_block_wrap),
+       KUNIT_CASE(prb_test_exact_fit),
+       KUNIT_CASE(prb_test_no_scan_past_user),
+       KUNIT_CASE(prb_test_no_reuse_of_sealed),
+       KUNIT_CASE(prb_test_65536_blocks),
+       KUNIT_CASE(prb_test_65537_blocks),
+       KUNIT_CASE(prb_test_bounded_publish_and_worker),
+       KUNIT_CASE(prb_test_shutdown_stops_publication),
+       KUNIT_CASE(prb_test_payload_and_full_ring_drop),
+       KUNIT_CASE(prb_test_valid_vnet_header),
+       KUNIT_CASE(prb_test_invalid_vnet_releases_copy),
+       KUNIT_CASE(prb_test_ring_lifecycle),
+       {}
+};
+
+static struct kunit_suite prb_test_suite =3D {
+       .name =3D "packet-prb",
+       .init =3D prb_test_init,
+       .exit =3D prb_test_exit,
+       .test_cases =3D prb_test_cases,
+};
+
+kunit_test_suite(prb_test_suite);
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
