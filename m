Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.17.129
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793348247;
	b=WRsGULU47neF0bH9iAySig/L7CKh6btCTSuZVVyTs2eVGyvaJKM1QRS/R/9CxIuTdWh5
	 4Dn9GSlBZ5H2HIYIGmo2IQ/opHmfa0rvXc1NhWX/fv2h57FEM/c9OFh2XeUY/lL8SnBm1
	 Kn+mSVmJpVs1q6EgU3JDHt3f2Pujv0EHMMLcu3RF5onujYK/chu3WlGN2otV9D6EwuF8k
	 39sdp0AZ61+qDXtVzBFs7Twup1hSXtKFkasrXJQ7+B2decj8iowec0alCAoYdghAa5BPZ
	 afCjH8S7xB7Qr+h4pPWuXSM6DLi+3JKfJdZ7DwH+/p8tcICFvvOVJxspZRSi6t+1oTA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793348247;
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
	b=GPgrQXbPswFJYUPoMWk/wyCjQX4c1pFP1ALjJYScL0yXA3BHlgQx26qgXnBI1Q18V95S
	 tg4hBCcw705qkRBB5u3ievr0AtH09tT4zF9VqFAsPEbvTlSTG6Jh8C2mFV52gpXAro9Aa
	 TYUEVJrIx0ykE/8Nx2YqvaKtrcYK4HOwEuk1o3w/aMMgByQHQX66ZWqZOLQldrVSOlv6c
	 Vgr/9T02bNFpvdeMDgX+kkt0MMzh1JR7yUFic6SVtLd34Nyvx72CjqoQ3PwrBbW3PBo6z
	 b2jDUilmPw7VLqE2vbgox4uq6v9fGXOMl4whxjPrY3+1JDJCBvWsP4HfN2lKHKhfuzw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=deeproute.ai;
	spf=pass smtp.mailfrom=deeproute.ai;
	dkim=pass header.d=deeproute.ai header.i=@deeproute.ai header.a=rsa-sha256 header.s=selector1 header.b=sDF9z7uM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.17.129
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2129.outbound.protection.partner.outlook.cn [139.219.17.129])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79856606A31E;
	Fri, 30 Oct 2026 08:17:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79856606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=deeproute.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deeproute.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=deeproute.ai header.i=@deeproute.ai header.a=rsa-sha256 header.s=selector1 header.b=sDF9z7uM
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NNll4AyF9f/SrXqi3OgdRdFaSdBClmPFgXMmdnzXoGgSGpzmZuvGcwxhpJgpwcu4j0BzAigh3s+KcMZfrFtqb8PQ3KrdFKnGBpp6uM8sR0TsvbijgjQQ3QNWS+UUnGlPmdg913jnzE5CDoqUxaZbR8L1WZArYHmfEVdeVIxKyvHSz5cY1kCbPk3uJcF5HLUaBNPKkYVSTa3M5CconkrfGkuNHWvq8qN9NkMR/AntjE6dEI0IvGsXiteERDDJtpGYM1A2V8J1ajqf1y+u4owTD4bHYOkGuOJL1GlkVzXSuRVoDMLuHad++on/lHeT1e1x55Nzl4PSH0LOQ8LMLJYWKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Or1fmHbK264ZYZ6ugepa2A88iZBHWfZvo8gWLmIwKzk=;
 b=JFHCmq3Pjyfb1KIm2ixDedwdIZFT2sZXGP8EbQNd19iinepZbzL+u+p8u9hAaYAkHWbo1scqlexAy1tsyFxeYqZdsIbLFY1Nd8ysLHwOxFGVieD73pTXygnwjkNRvKxerKRcgKzwsD3az+NyrYLsOXGzW7Nf2/pDIqfO+QQes6vF3dqe15kpDoElE5kKRdFG8HItwtrD2yx1L14daA42hzhU3ywHo7OEagjkuqoi12TXpB+aJNTqJDaUPG8HfVdlLKS1QJo6QDeZRUzCLKbE0yWAu2IzVX5kjLztaFIDDnGJ3pcz8M83GdjOEUuIHXVKxiHu/brtxaOBSc+tz2ix8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=deeproute.ai; dmarc=pass action=none header.from=deeproute.ai;
 dkim=pass header.d=deeproute.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=deeproute.ai;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Or1fmHbK264ZYZ6ugepa2A88iZBHWfZvo8gWLmIwKzk=;
 b=sDF9z7uMOOiKoHDsmbgRr2TdnTfy31+vUXR6KHh1lzM2m44dpHtUtL+K+NMoSmOs1Qx4tPZS8NiauIkMckxwMUQn0AFrFxuL6iXkJRJs8NMEydPeqaeoaSquqkhsSgYv7R7uxIAFDB/IbZgQ9cPD48pIkrYghC/54nl+IVtUoCk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=deeproute.ai;
Received: from ZQ0PR01MB0982.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1::5) by ZQ0PR01MB1239.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 08:17:16 +0000
Received: from ZQ0PR01MB0982.CHNPR01.prod.partner.outlook.cn
 ([fe80::197a:1934:4b5b:4520]) by
 ZQ0PR01MB0982.CHNPR01.prod.partner.outlook.cn ([fe80::197a:1934:4b5b:4520%3])
 with mapi id 15.21.0569.008; Fri, 30 Oct 2026 08:17:16 +0000
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
Date: Fri, 30 Oct 2026 08:17:02 +0000
Message-ID: <20261030081704.251652-1-jingxuanxie@deeproute.ai>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB0982:EE_|ZQ0PR01MB1239:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e9a80bf-33a6-46c8-ec6e-08df365e359e
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|23010399003|366016|376014|38350700014|56012099006|261028144727099003|261022105027099003|261026140227099003|261026121527099003|261021123027099003|261022075727099003|10067099003|261021135927099003|261021121427099003|261009223027099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	M3JScAB/k7lVOmjLkoHF+ZtENET9reZpQvIhEsRFyJjullzwI4qtT65osSITSdlXnlL0zYtZ7Tjuw0EDAkmc6ahYPXayq0/24dRel6OSxbr/SweHi2lvZwBcUoQpHC6M314nIcV4f0B2H/JeVgEd4EVsHcotrGhiETMqZjU1Q4GpULxGIsawbv6QF9K2cHQhhG7PzUsruCwx+vmEEPgHrFcL+NtcnrQAnTjMz2Kji+2EHg00p986f+mTNXTqIWB4xsZWoaIYx4Mn1eXgQ38CBsfkBCuVfnPqjEuFbm8FuG4HpGzdyil440v08PeWjtIHNOu+N/Ogslt3v4bX7Ba+q3/zADRlLg3E6i8juU6LmiUMJB83at3NfmikGOhf37a6Q3DtRaYFsy2kmiMG3HeJW/xWIOo0rqp2kp2aFx0HXzyu2oQ6Hn4+9HnKT3LjHj4o769FSImT7z8OwWuTd7e4dEl8tkGTUeYK8hV1sf2F37HUIGa2i61zRRif8gH0Eah5PJAfEQS5pHiPKSYvlXNLv2TWgow0cqDZyaIL6cjgGXWYI18Q/WZUpYYC35mKBlhj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB0982.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(23010399003)(366016)(376014)(38350700014)(56012099006)(261028144727099003)(261022105027099003)(261026140227099003)(261026121527099003)(261021123027099003)(261022075727099003)(10067099003)(261021135927099003)(261021121427099003)(261009223027099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UoqGgUUUUXV3HsDurEYIqPwr4bdRadwi9dzpbNJdxtiG+Uw0LRQh6nDrBwYU?=
 =?us-ascii?Q?TIn6Ej8v7SsSI3rHkMk5CaISXH5Togls2WECwP4Is7ze257GzDYCF77tzrNK?=
 =?us-ascii?Q?U7ypW74MtT7jsIyzAxUN8YM8d+hjsHLFdRM6pzqoULmu5rJkNWgreMW+j4Ok?=
 =?us-ascii?Q?35SHd0BqEp34AUeKwPEsIDRmbQtaIDmAOm1ycBKbEp62/Vf2zYkpspwr+nA4?=
 =?us-ascii?Q?tkq1Ba4f0gS7aCixrMr9FSzMIar/lqmveyIrBZ0m+vLb2ZSWnXeJ+5T2NcM5?=
 =?us-ascii?Q?/kd9Xi/0OccqiKNitYjWJBGfOE91n68ifL2jfXOhrLBqMINDlePclonoN7qs?=
 =?us-ascii?Q?o6BzuAPkLrYMiXDYQDbRHkPXqbk3D4UAVjKX1hmeA0wYd+7SrzhItLv2Z0oC?=
 =?us-ascii?Q?hmNyvOrpWF/PDOk/JaWgk5hjs9RGFsw0uJi5/wnQ+t5Yft+vt5aud4RpGNzg?=
 =?us-ascii?Q?IvE4G5dN3N4oknmbMYAuw/H2hNrnC28l6J07Bfv+Eym1iDmc77YIDi+mVxNu?=
 =?us-ascii?Q?6ymTg7Zw7EgQRr3xZYGQjc0U3umjJ+tSh/BKcB3pbr7uOjt3d2wwK3VdNqaq?=
 =?us-ascii?Q?lSvsvcp4yzKWVCmvYVQyA2V4yBLje/i2cMKyLSxoZgs8IUCIMuXRbS6mp7l/?=
 =?us-ascii?Q?WdsrSXjKcSYLQtOEbbAWzmhAylgATUJLn23+adHKefVcCq/uv/cJZLWOYmvH?=
 =?us-ascii?Q?Asn5yysyiB1ul8ujk8640OO6UBWxcRuLviImvdjIjBxoXQKFs2M1KqcDoudb?=
 =?us-ascii?Q?USpGZMDaJvCD1EKu6hkco5s1Nx+ypa9xhRiyN7wnCErZUkze3rcU3pZgTrkO?=
 =?us-ascii?Q?iacl8o3BlwMgENG7ycvy0oiXJb7SCorcErvGMKUTqTh2KPdJcSyoLdvXMUOe?=
 =?us-ascii?Q?5erQtUiToY3dAuBrBUGTmFcs3k/E4cJWazyMHCCvenNoJJHumo85WWqYDD2J?=
 =?us-ascii?Q?Q+dkK05cwWDGAR+GOUE7e5329oU4F4x47u/IyDNnh+r7+DVnJBmbunJw+I3U?=
 =?us-ascii?Q?T4MbmURfhEP4Z5r9FXwlimgG5ZIMC5ju5/ztuv4nuik+boCAljrsCq5OhgoX?=
 =?us-ascii?Q?SYtjwSfp5XnPmxTUQt+aXDQsvrKNlJFKdsf/YVLcRFU0ldatEcI8DPRk26Zg?=
 =?us-ascii?Q?0WfWAyXC8CSUiSbgrLFs86lQ5/z2pSU5FMB+pR4bsfDzH+suK0c5kYdr+f4W?=
 =?us-ascii?Q?Kg/m1XwCI+/r9BuMOHV4f7ZscuirZ6++rirTEZw1fW8Pyjk344UvTGkHFU8R?=
 =?us-ascii?Q?t1X9iopHkS6V6y0j6ShOYQjxqOnZQGjkp/AN4m8gnYOTA6jpj2cN3smd78TK?=
 =?us-ascii?Q?um29th01N7m7MqNo6zqV46MqUPkq0MWSn14zpXGagszps6HaxvBNotagATuY?=
 =?us-ascii?Q?jHSkt3bCn9r6JN4O5xRS6cQBNYAM0h2b6BLBagC2Vk7URUGtuwCPJypfWb9y?=
 =?us-ascii?Q?7/Oi8ShWES3ITqex79SVcyu5UjX1n1V64UtOn7va7sSkIHchqULGK9vqVci4?=
 =?us-ascii?Q?JM6RKYkxmVm4JGJIGkMLFrNcRhRc/ZWN1AKNDIRC+gPM2M8u4CkFZm5ijZcB?=
 =?us-ascii?Q?gvphO89YZpxZbx0FvagkWDf5LpK9MADhSTwTAv5RYALdn6CcIWMIXchSj9IR?=
 =?us-ascii?Q?cpl68l9/EyE24LnzavA2IMtBSACgMkAb9CWkFUPx//7F5gqHCZ6nIzoKiWtd?=
 =?us-ascii?Q?DSjANX1QVE71dNl4wVoa+Q7TzWkcYf07MfruJFb6VoGtntqBXXKpsyR1anoO?=
 =?us-ascii?Q?u7MEJP1Y4A=3D=3D?=
X-OriginatorOrg: deeproute.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e9a80bf-33a6-46c8-ec6e-08df365e359e
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB0982.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 08:17:16.5128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: df535b4a-68e6-4339-a092-afa4f2c24fcc
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tQn/RdjvU19ota0zcTg3LNJunqw7nPqRQS6Zi3/UoLgY4KBb+EXLJo3xLwfBZMAhebt6+H0Oj88prG+f2i8YgYwDB7DqDOzBE+hcC+pESS8=
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
