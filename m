Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.146.135
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793348123;
	b=rt06gXvGdkTvhdpEnuiV8x14MKSd4W9c6ra8hZmL1h+rBVlgL9vJYzwb1pZq2lkW4hdj
	 j8k1NU66TnAKGNfpB6DRk6Hd4Q5wACiB1+LE5368SNBK7GidIODbRa3W284cx7N0J3KAA
	 0idVdQRDbvYT30DD/9XAPK7NLXPcohxG7oYUq6QTS0sCj6gqerkG22k3k2QRMIcw3TI3K
	 myAQLAPF4P4+SjbJlIbL0SPJpzP4iV2lBPpNUC6DyZuG1Vx4e2WEZYMIcgqVw0Abpb7t8
	 3yPocaYULx/guPP2KTdJLby3oQHhVZ2KRD3mTFwRaJ+jvUXrYQ59/omxlnYnkCkKfzw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793348123;
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
	bh=Or1fmHbK264ZYZ6ugepa2A88iZBHWfZvo8gWLmIwKzk=;
	b=rMkwyc7egmj4zwCahAQcOk+cxOnYFod6ShnswqgAbOu3/gTpbYQRRzaz5doK7l9DhqVt
	 3dIXt3HOvmk4BQGlWu2NC8I4boFiDj3h/IE+rsNflmGIJ4efXyGJEdReD0uaW4LmlbZ67
	 8GCN1llMr1uXYVrFPxN9xK9/xB2/qvssHwsHbQy1LTwRE5gtBOnGz3JdxVgWTaYIq6opY
	 WoJNcSiWQePmbogn9dJaWTtu5fz25YEB56CBv0JYVQxnOrlRBDuFbC+mHlrMSPTC7upcr
	 AbhSVwlrWgioryXKOHE4T35N0oZADoiJjK5yMgI9ngqXFDUGJ+lnnXM+yPTiNUdszow==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=deeproute.ai;
	spf=pass smtp.mailfrom=deeproute.ai;
	dkim=pass header.d=deeproute.ai header.i=@deeproute.ai header.a=rsa-sha256 header.s=selector1 header.b=bZ6BtsKl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.146.135
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2135.outbound.protection.partner.outlook.cn [139.219.146.135])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F17606A31D;
	Fri, 30 Oct 2026 08:15:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75F17606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=deeproute.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deeproute.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=deeproute.ai header.i=@deeproute.ai header.a=rsa-sha256 header.s=selector1 header.b=bZ6BtsKl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K3Aicig2DSA5adH/t3N6GbphOozuVq6ILnMsPgd6Nmn2gNOTdtC3+PFNTj5tmnv/yStfWj4JsIT85uFqw7IjDXdiOpac3E42IcWSw3eG2vDBFxUkINpieA6S8kQhDBYC7LbI7cZwTR0k6atfoLvWOokEnX/fuJsGi61F2KgjPfzNkKG5E1/I6ccrrF2eLImbvNO+OhaRYB1/NYKHa5ncReLB/D2ZoQpFdvX0evGPk5aPKhtA/fLD5iKxJqE0zriEU/uKG1fXSDX4e/KpgbP6wFSGriSmaFaFvsBxUhRTInfe+bEERYep2keLH1KrxIGmV2XMJcuOh8xlUf21cSJ6sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Or1fmHbK264ZYZ6ugepa2A88iZBHWfZvo8gWLmIwKzk=;
 b=TsDh0b/yDQVMad7nOIwgy0luv+2q64Df/xs2S25+D466shcsJNK/SnCT8wVU47V36I0c+DepX4nevndWCv9JNhcTr3eg1T26pbcQoEtoY+bczO5FEkTgttNoJKdJC0XIiPPEIxFYVpzZDB8SVnEvk41ICAWHTNUCMCbx9LJ3GBtquhR2HKYBzyUP3Di7oDVtTGoGKSKfGOW9y0lS4TxiF3zaBz0ChQaOOq0gRN1iZPLPLyqVeO6mAY5Gy+dZraOYX7fVJazf9VAGdJbBfbw3nmZYUJRHaGJvSK49xNmyjwaoPSBZxGnH0QJRC6aBER88PmZ/301Rx2FCFibzgmFObg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=deeproute.ai; dmarc=pass action=none header.from=deeproute.ai;
 dkim=pass header.d=deeproute.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=deeproute.ai;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Or1fmHbK264ZYZ6ugepa2A88iZBHWfZvo8gWLmIwKzk=;
 b=bZ6BtsKl/xhWux0xq8+UiD0bJB+pVNirGEuHNns6MagS7yfzqggMZYBIgP9RtwdH6Rpwc9RnsqMsCi66iLU+Cn01BKkA3h/L8PvhC8729pojMIIa5fl03dwUnSp2s+dYgzAP5oBu843WrIdfgIR1H+za/1KkL3VwcvoKd3synAU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=deeproute.ai;
Received: from ZQ0PR01MB0982.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1::5) by ZQ0PR01MB1239.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 08:15:12 +0000
Received: from ZQ0PR01MB0982.CHNPR01.prod.partner.outlook.cn
 ([fe80::197a:1934:4b5b:4520]) by
 ZQ0PR01MB0982.CHNPR01.prod.partner.outlook.cn ([fe80::197a:1934:4b5b:4520%3])
 with mapi id 15.21.0569.008; Fri, 30 Oct 2026 08:15:12 +0000
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
Subject: [RFC net v2 0/2] af_packet: retire TPACKET_V3 blocks without waiting for copiers
Date: Fri, 30 Oct 2026 08:14:38 +0000
Message-ID: <20261030081440.251635-1-jingxuanxie@deeproute.ai>
X-Mailer: git-send-email 2.43.0
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
X-MS-Office365-Filtering-Correlation-Id: e57bb457-762d-4f17-6b55-08df365deb6f
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|23010399003|366016|376014|38350700014|56012099006|261028144727099003|261022105027099003|261026140227099003|261026121527099003|261021123027099003|261022075727099003|10067099003|261021135927099003|261021121427099003|261009223027099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	JJ+t0VGvonF6iZGtvOwWjvedTac+Ib42FMlAJ6tHBk9MrINCxe/A7IfZ20PPho8Duu+VByLr8lrT6mgFtD/P4N8fKMkNXIH/OrJlPKHzzxmHu4F7FeAiBf0OxLrxYUuaFNt0CUt+tk/mz5G/31aTbdxpruR2Ca5oc02W0xaMTO45ZxmOXBGipr8o4XTkgR8mvO8IkjmMCmLKucKk8KNDdXEaX3Dn6MPV7Sf9ehR8tLRV899eCMTvYKs7afF7drtNdV/sjqFVryoc1+/KIR1N79c1JqDe4TR+t+1Za53zFjd1ByASoytfPRaXtu9ZSSLVcxSFOBxkHeTM1de57VH+BbFlmpiQqLxRoXCwj77j7rgH7aMIRFNlkEn4KQ5wk2p0D+yLKf/CNXz9JSR6XpesALxXLRaQmcIzn9w8g2R6Qb4tPVAmojMH0JmoL3KUgk4MMr0XhgnbRNh5kzJ9OGuHSgnLmveVwBmWt+Jxx6yYUcTvFzyTpUxQeGQglxFaOTOv9f//EjxpfsHU0NRSAuwZo8uE44WHzsnzlggiJblRdF50TneQActaLwKsnrCM4t7X
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB0982.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(23010399003)(366016)(376014)(38350700014)(56012099006)(261028144727099003)(261022105027099003)(261026140227099003)(261026121527099003)(261021123027099003)(261022075727099003)(10067099003)(261021135927099003)(261021121427099003)(261009223027099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k6ieGCLPefHEcIr0TkrAX+b3w7MF+U6ScmCB+CmGoTCLS41PJDWnC2iDHgFz?=
 =?us-ascii?Q?Maycc/PVcy61as+aH1AcSq5AaK9YDtDm6CHsumQ1yQKsbn6XtrIMP5Puu9lA?=
 =?us-ascii?Q?Ihgh6nL53FpVrKfGafkolgacYSqAak7uneLkslZ08HOmNg0/rZtPf7Uunldn?=
 =?us-ascii?Q?3BQx/3AsSDjG7e53RZhl+AO0QMZSrUxCaXHOOM5EEEc6MJTdI42eLkWbPSgN?=
 =?us-ascii?Q?9duTAxNmwFZn3FdErBgVU6+yDKCRPA7HpH1qq3XCzBCa4DR2HY55A/K8R+xI?=
 =?us-ascii?Q?BEHlQ+JuSYYa001XJzD03Y0Pp30X27Y8UNLR+j417koO+6Bwdv90cu6PIGuV?=
 =?us-ascii?Q?/pT6VtULe7iiN5yoZovY/WHywkXSajc3QO2dFkzt2qWVPmITUCsovxzyxcmU?=
 =?us-ascii?Q?SLAJOtgzLBjubzQKp0FWZ277TVzD9KEfjWunOZi+07DUvqA8Lcgba9jsS0X9?=
 =?us-ascii?Q?d35exAWEGKE0w2S+VkanF9+IJhnNdp4Se7O0mtQyBODLFds24ozusGM+RSlZ?=
 =?us-ascii?Q?PgY1m+0R/wzJmMHWGmQ+2Ar96TbSUwng5SqHrFhDgI6xGlthLLV4mAn/llCq?=
 =?us-ascii?Q?yZqqZxdayya+wHmCQIfS0qRqVWJngSX690ESnRnk/M/gUzOY+mDJTtkaBERX?=
 =?us-ascii?Q?ACXJIJYxjdE26k4+PxGtb2olEUMzuilr2Ip1LdxKoaiUVo9jArN8AKhZdmnE?=
 =?us-ascii?Q?xphCwo50BaSxK18NkHDdB/9R1+JUiPfsuXqCuwvBK2hbHtjGdfITeWgf087G?=
 =?us-ascii?Q?0Z+7ZXxerAU3yTKz6lXK6NVgTshUsb4Bnmhi633tB9xfs9rr7TIaqS0LaD1F?=
 =?us-ascii?Q?IePtm54kNRysqwX1iUk4IwgsX/1vK2vhZkR4kWyeK3Api905BGS7HyH+no6D?=
 =?us-ascii?Q?d41N+emy782xKJ9NWxiQMazsVp0oPfMP+i6ss2SKjKfClirJhONIOSolFDP5?=
 =?us-ascii?Q?ANtNwYH7g6zEDba3C8P4s8aA4Ws0bHcjvx77MQRcDfk6FucSUMZDeaZGt20D?=
 =?us-ascii?Q?JdLunRBFWHlqfsLmFOIcv0QSCVz/H0YTPzVEtOr3vXo7C3CXOxPyRqAD/A7v?=
 =?us-ascii?Q?VpCyyE1nvXwbnSDhJ3+7Elb9Vq5rFznypI2bSQb9RmZR3pbPlLC3Th8J/yw4?=
 =?us-ascii?Q?nvhsyZ4jIyrooOSCRxjcM9E1hoiBg2CysZUv0rfprMnNTRZEgzgUboOxARek?=
 =?us-ascii?Q?bim5MPxHe0NgJl0pKm5LjUjycQwVBseKmxNWkzv4wT7/B7wvMzQIVZD3Qdd2?=
 =?us-ascii?Q?BqsaveoO0bwOncbcMpfA+FV2HRcCSHVE45vEr30hgCSh2Y+b1qn44ZtWY+jo?=
 =?us-ascii?Q?Y5IYSRngnd+Ym/j3P1HzlHP7ReANfVNNvoM6FJb6iPcankLo2z9lKiu9Lr9+?=
 =?us-ascii?Q?UY5ZxVvkL0EAd1AyXriPhNi5o+yM+rjnhB/a1k6XXw6MvZuX8/Uv8AVSPA1s?=
 =?us-ascii?Q?Uq0ufyIi5jm6wYqib+d2xBDPbLHrw3aRgQlE/mFBttRxZ82PntPMZK9W47/G?=
 =?us-ascii?Q?u9HLkIH4/HJtB50gTDMIMgiytJfw0tHpO4gKKJ+HjiwM8+37m5XOmqtbtr1A?=
 =?us-ascii?Q?OC9o8O8iKOYg2IXRY23E1Oj9gUPZT6ikyf2veoIyB7KwaKlvCmVNhUwonfXX?=
 =?us-ascii?Q?oyELVeltqN/k2n4TTs+uXnmR9Mv+Gt1UzXy4pwfJ/5mjZaofLU05scKWkDjy?=
 =?us-ascii?Q?vlWeavo6qz8x2KYyJGrjSNLiAJGFL9aWYsK/lvwiaJ95JNy1TcVrCDIHJLnM?=
 =?us-ascii?Q?OPUmUzFXwQ=3D=3D?=
X-OriginatorOrg: deeproute.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: e57bb457-762d-4f17-6b55-08df365deb6f
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB0982.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 08:15:12.0459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: df535b4a-68e6-4339-a092-afa4f2c24fcc
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6wEPY4E/VeJmPVXsqfCvIDWA4rRItOd/ieK6iOABB7Pg6enh+/VRYqcrqn/0hi7HWcVJk6GCkY+20nCQsWE+Kbo+eq79hyEvG88mtyDaR7E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1239

This revision keeps asynchronous block retirement but removes completion-si=
de
queue locking, the four-state enum, the eight-block publication budget and
the workqueue used in v1. Private copy accounting now lives in the existing
pgv allocation. Packet allocation and the existing retirement timer publish
ready blocks in order under their existing receive queue lock.

A preempted copier in a sealed block does not prevent capture into the next
available block. Copy completion only performs a release decrement. In the
absence of further traffic, publication may wait for a later timer callback;
there is no hard bound under RT starvation. A finite ring can still exhaust.

Patch 1 independently moves virtio RX-header preparation ahead of frame
reservation. Patch 2 implements the retirement change. Neither patch changes
the mmap layout or adds a UAPI.

Changes since v1, in response to Willem de Bruijn:
- Split virtio header preparation into its own patch.
- Remove the second receive queue lock acquisition from copy completion.
- Remove the state enum, separate metadata allocation and worker lifecycle.
- Replace the fixed publication budget with a loop over existing ready bloc=
ks.
- Use release completion and acquire observation of per-block counts.
- Permit idle delivery to wait for the existing retirement timer.

Testing: ARM64 QEMU virt, four CPUs, PREEMPT_RT and lockdep. The unmodified
retirement logic blocks sender B behind a deliberately delayed copier A.
With v2, B completes capture before A is released, for full-block and timer
retirement; idle delivery, block sequence, lengths and payload are checked.
The delay is introduced by validation-only kernel instrumentation and is
not included in this series. Ordinary psock_tpacket and psock_fanout pass
on uninstrumented RT and non-RT builds. External validation tests exercise
the actual private helpers; LKMM tests check multi-copier ordering.

The ready-block loop has no fixed work budget: a large ready backlog can
lengthen the receive queue critical section. A validation case publishes
1000 blocks in one call. This tradeoff is explicitly retained for review.
Separate RT KASAN and strict KCSAN runs pass the helper checks, psock tests,
delayed-copy tests and concurrent-close test without sanitizer reports.
Patch 1 also passes an independent malformed-GSO runtime check. ARM64 W=3D1
packet-object builds pass for each patch and under allyesconfig/allmodconfi=
g.
QEMU does not establish hardware NIC or Orin integration acceptance.

v1:
https://lore.kernel.org/netdev/20261028070528.139531-1-jingxuanxie@deeprout=
e.ai/

Review:
https://lore.kernel.org/netdev/willemdebruijn.kernel.31ae9fde05c@gmail.com/

Base: fcc00b15cb21a6de76826e5012b2c758505f5e65 (net/main).

jingxuanxie (2):
  af_packet: prepare the virtio header before reserving an RX frame
  af_packet: retire TPACKET_V3 blocks without waiting for copiers

 net/packet/af_packet.c | 162 +++++++++++++++++++++----------------------
 net/packet/internal.h  |   9 ++-
 2 files changed, 88 insertions(+), 83 deletions(-)


base-commit: fcc00b15cb21a6de76826e5012b2c758505f5e65
--=20
2.25.1
