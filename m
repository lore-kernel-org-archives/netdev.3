Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.17.91
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793171190;
	b=K8j9iG3MRZsjxCZP52FbQSttmCDp6O0mRmFNoi1l6wzVFHl+cUm6W1b7zYQH0zQ6LQSr
	 ZYvlBlWLYAk7WqnAXDTyTs9XlTBp+N4ntPwspSwjsHtVqS7WMj6ilO3qRe2CsehsHS5T+
	 6O8qbmRWzdSGcjKaNW6FjwNVa3lrBLw7cFj+mRdXE5IZnqqa8nmfWZUNrst0E1bvCiI6z
	 eXr1ad/5jg13T1FpWEoHDVGpu4M8UxsSxhaMB68iig8hCkc0Br5+SigtAu6p0NIGk2uBb
	 JxiWIE5ecMUWxp6N5fl6/rWPUg21wZoLVVcVzm5zZrKzzqMQx5iZ+FSQH6QI3U7ZfRQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793171190;
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
	bh=89uNG4Vq5aIXGVsMVtmmkv1fe5YNg9vaY0h64MHA0ug=;
	b=fRvytCunh2i7DCpQiaRp6amnezOHIdLnXmsITRSU7LjeCN3kLNjvWOed+syAuXkPBZ5H
	 RNcM0J7hmMR+Frbm/HUu7jqjiTcpMm2tUAbX48WM0IBzFXWUXMGJ8wZ6e4EjuofHG+x38
	 OcfuNlrOAom3LRAOXQlpt60DldwMveIJDL5FoXLzbAB3ra3tNexTWnm4Ge2Vuoi7aiK0v
	 nog5JvxeU6aQjXiYjmDt5AYx73RNz14GVqoM7DXkkiDfUa3CwwT56mdmk+xpvJLF9Q7Pe
	 IAMtmEvRlAdBtMgzDrV/qpudNAVUIe7ji2pZ7yHtWawYuOKq5Pme9scoHJF8UX9Eong==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=deeproute.ai;
	spf=pass smtp.mailfrom=deeproute.ai;
	dkim=pass header.d=deeproute.ai header.i=@deeproute.ai header.a=rsa-sha256 header.s=selector1 header.b=HLvZQwPh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.17.91
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2091.outbound.protection.partner.outlook.cn [139.219.17.91])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4AC606A31A
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 07:06:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE4AC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=deeproute.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deeproute.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=deeproute.ai header.i=@deeproute.ai header.a=rsa-sha256 header.s=selector1 header.b=HLvZQwPh
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q0bUZDIsG7NhaFTjiA5ulKs6kNI8WGbMAoly6Jv7EcXqAAJhTQ8gbscQDksR7D2tDQiC7YI/Cu0ApSkdX8gQ6AaJS9eyhAhJRXja094os0e51Rg4EeLAp3WENqgLRPXsa0o8FxNY9OfrQHgA0RSjYa5r9NJeqfriTT2q7Vt4dXCnKSnVh3ISIcwEXunhWx4xhk6pEp7ZkCvqOtJrx+5e3vPt/ctrgaxf7345q6rADpOzx+QZECmou6ow65oYwz4bWz6F+l+ZqlLeuUiH9Hjrb9MJaReJNRUNu0mkwpKkzu+Z2ksKdkntSfiu2XpokYPSdLRY+PxuvTV1DnLvr0D8Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=89uNG4Vq5aIXGVsMVtmmkv1fe5YNg9vaY0h64MHA0ug=;
 b=EL7MS28rODMsS6pDtwoeOQ2li4Vtplnbop9XC9JWlBADNHqv6q3qb3Ix77PmkZMUjg8aH1fXlZ1tJ/vchd0BoJ/s/ghc/kD0y5CMjJ4x03nvho2ueI5w9D4gyEdURGdn/OVkYaTl7ImGba1jPlOUHjahbBS9tWnGHqtB4NRQLrg/lFRHajTCbRzZVMI4y66dDp0jyn9IQq5954U4HoMbnR/RLKtroX7L4scySb93zlHtNtoKm0oHfO3Apyt/T2SZcKe5QwNnvcqdpqTnHOveg66f1my+zL6+VMnRjE4rNR5OegQoA9fyFRI48ovjxN/J4sevMrr5z8uKIJHeKg5YyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=deeproute.ai; dmarc=pass action=none header.from=deeproute.ai;
 dkim=pass header.d=deeproute.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=deeproute.ai;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=89uNG4Vq5aIXGVsMVtmmkv1fe5YNg9vaY0h64MHA0ug=;
 b=HLvZQwPhYouwng4UgtaRBS4EZfMzx0xuzx0iqVSkG0KqTDN1ebs+QIR04LWrNbHPYT40g1wnj5B2Unf217z+ogvS9cTzrXBhm/pSkYNq2WRfA6y7icCkip/ZZiF6riOh/BCaXMIPzxrVSBYzqB97X+hEa1uZqel/toLCDkBhyLU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=deeproute.ai;
Received: from ZQZPR01MB0980.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:a::9) by ZQZPR01MB1042.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:8::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 07:06:16 +0000
Received: from ZQZPR01MB0980.CHNPR01.prod.partner.outlook.cn
 ([fe80::2dda:e54d:5a3c:d686]) by
 ZQZPR01MB0980.CHNPR01.prod.partner.outlook.cn ([fe80::2dda:e54d:5a3c:d686%3])
 with mapi id 15.21.0569.006; Wed, 28 Oct 2026 07:06:16 +0000
From: Jingxuan Xie <jingxuanxie@deeproute.ai>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Subject: [RFC net 0/2] af_packet: asynchronous TPACKET_V3 block retirement
Date: Wed, 28 Oct 2026 07:05:26 +0000
Message-ID: <20261028070528.139531-1-jingxuanxie@deeproute.ai>
X-Mailer: git-send-email 2.43.0
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
X-MS-Office365-Filtering-Correlation-Id: bf260733-50a6-42f8-d0bc-08df34c1f563
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|23010399003|366016|1800799024|261026140227099003|38350700014|56012099006|261026121527099003|261021123027099003|261021121427099003|261021135927099003|261022075727099003|261022115727099003|261009223027099003|261022105027099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	XZKkCw+Xz2RjNWteeE3ljXQ9oplvrcSEN2PPajRhhLIjRIomEZcCAgbhCH8hdJMGZH8bJt6vZScXiUtbbzLcaYIuNyN3/7q6uHaZHMLfDM62fUlCfcx5o3SZjq+2jDGO+DtvQTG0Ss9NJPufFG/C3J6Df8WQvQaQFWStRnTexRODdzJhBixSYKcDN8YfnXDePX3v3NulRCma9a7CsbQCsQHicwTWRNJfquEGd4EFKA+TYI5eoP80v8Fa2sefVWnw5NTpG6THTKdoIi3I9qv5PvhgRdnvYHFUiCnSA3ELhzaOaxBSwrb+tvtCeOxsUrWMSGKq1K7/7hsKX9B+geDkO7kkJmLoBMXRgYmQHgDeSNSgeAuQqzpGG7VLJbeqCzuNNUL+bPTuIT/mp5N0I5RbKPjCSKEx4Rlp8odqnHa+BKy6BzMFpnRX/fbKBU7QiqvlGg3EsYZpKi1qOl9/lw6b8KnYgO31TODfFf+rBp6k+G74eKoyRM1zds0OQF2fAFTEy6ZmcVsLcFlDJAQa7suZh+Vl9hns6s2kDm1nStrb8gLtz0cxYpDNVMjaNXu2FsAL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQZPR01MB0980.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(23010399003)(366016)(1800799024)(261026140227099003)(38350700014)(56012099006)(261026121527099003)(261021123027099003)(261021121427099003)(261021135927099003)(261022075727099003)(261022115727099003)(261009223027099003)(261022105027099003)(10067099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n8mjxtesL+RuE+KsvlfRwsfwXG6MxbU0HIPhNzLj32/1K/VbncdaWFXl9YAr?=
 =?us-ascii?Q?BUEcrPg3XOgYOCQnB3OythR/XBMl7QEIHyrkl32rqzWRx/8erTuOW6wqM35+?=
 =?us-ascii?Q?83cbFtBEbpUeBpzeFNr13uuW60ueITu5uXCd4TlJ4cWlvzUcL/7k8hk7T/vR?=
 =?us-ascii?Q?IfLs3VWFFmRloj+jp10/NOvNQ4ZdiSBIuuZUlNUVfovxb8ySrRdghtca0jim?=
 =?us-ascii?Q?qivukHdgijlYdrcptZYERYg9yInNxXF0BYNswS/bLfeusivqD5KxqYdw6vCj?=
 =?us-ascii?Q?CeDA4JyV2STF7wmnz2Q27Uexl5+7HC+muaQo/oHXgW9W2T4B01OFdU1KNCsB?=
 =?us-ascii?Q?+AXu098/nOJTqsZI/wRUyOfSSUOhCi94eJ51CvTa3sKpqz9zm8Vf24UXd+QZ?=
 =?us-ascii?Q?PP85w69vLNN30sIRR7Zrk2JgB7VXf+Q6XoTQIsWoKtGByZ2fVqaa5P7uG23g?=
 =?us-ascii?Q?o51ypDTGo9Zgdb5dzXEn0tpmikY0QIKnFpfcvWaboWICX4DU3PLksVgoXHHH?=
 =?us-ascii?Q?ldpElodIM3Dhsct3eFfgOOL7il31ai4+hdNjPi4MN4VxRWfkzgn7yEkOEdJ4?=
 =?us-ascii?Q?T+VnIOi4xLMjzUdKN5Ud17o9uCYuh0MXs37MNYVOw4FuCeLg3XEBtWxqUoHK?=
 =?us-ascii?Q?iopsiZPha3JfSYDfJKDtD4CWosik90XhiWtdSo98P6TwlMyUXgSptdbO9NHN?=
 =?us-ascii?Q?HBGMqCIBxQyAMqRori63Rg925rKtpwmfEzmetMki7qr4bMe74By1DFOYKJxj?=
 =?us-ascii?Q?jOqrqLSHrrkPmruvicJTB4sMTm07r8CgYqdp78CttmxoFuvxoK4O9eN59r0f?=
 =?us-ascii?Q?2uQm/zQbd5ZoPNcu7Ic5/G2AP2Wa3HPOd7+rdoYDnGk9GNVwAPGQhBAdFgsD?=
 =?us-ascii?Q?hc0ntHuExdJyvj+2SzHzXW0M5I+DyHf+oL07/x6U/O54TZEejdaCEvd9lUXc?=
 =?us-ascii?Q?MuW9b9aM3NEPIxzKpQecWRAzS0eUdsag/zFI0hnZCf5ypAoB0QuLgvdXks4b?=
 =?us-ascii?Q?6CfplP1HSVOYwUxHtbTO9t2MfMlawH+11AtPLRwfD2xv34TEBHiofwpT4PhA?=
 =?us-ascii?Q?R9j0vfUZbH8Es+zq1nzFB8EmBbqv2H4LGPrh0P2GuePQnczuGREOjI1w67Da?=
 =?us-ascii?Q?cDaZ+x7A+SwNgu3XAi85LJTJKlU3yZtOoU6nJPtBh3qi83mbq9KN57M7c6kf?=
 =?us-ascii?Q?ypQpIGWvSwmL/1wW93WpNQ9PJCF7q9Buo9mLJp4qUeub5KdDFMALr8MXnF27?=
 =?us-ascii?Q?8UDJMUWZ37Hlv/+qf/O35rnAvfkHpTfBQZBRp7NxD0fWqMxKmfzdVa1DtXHQ?=
 =?us-ascii?Q?vBtj1CooJefbHxVWt4kNMG/Hd3+8wtN1Tylev+3Gtec5/mHQqVsTySL3qL7K?=
 =?us-ascii?Q?dx0oXNJe6YMWVpopsmI7cVhVJtUs3xD3cvdz0AlNx6uZAxi8RtuzCBBmBLOL?=
 =?us-ascii?Q?aa+N64rgwgw8BuuicNGg28xefiQxXFdpOmFj1PgYiWCwFdhWE7tvpEXCM+R5?=
 =?us-ascii?Q?L4RMVj+Qyck64pjFCf+u+4m0KvubUq9BKs37ht/HdvRk8Wb88SJlSnY8L3vi?=
 =?us-ascii?Q?X8ekLzMQTd/T8ICQnBzf/TULsKXH4RmWIyJ8BvCyKiKKHiamZhr+F345mN+5?=
 =?us-ascii?Q?MQ80uyWdcKVXkuUSP/v3j38k5Vk94SR7rl/0DrQ2g2qC1apvkiz4Dy6wW2yf?=
 =?us-ascii?Q?kWYmzN9lVIfB5nY5JF9KYLgN+3LRYginMGXZ05hl2dqeAkRKidRaTcW3BXPu?=
 =?us-ascii?Q?Uhvsw33Sog=3D=3D?=
X-OriginatorOrg: deeproute.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: bf260733-50a6-42f8-d0bc-08df34c1f563
X-MS-Exchange-CrossTenant-AuthSource: ZQZPR01MB0980.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 07:06:16.3045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: df535b4a-68e6-4339-a092-afa4f2c24fcc
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WUrwegnlqfB0NPByXFBKDWCkx5muTvJfBBCN2EBin9MjfNnwCzf5r2aAqPw6uw6TRme4Ww5F237Tjjau2rQW1A904LHvKU2IT6HrYVTuz9g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQZPR01MB1042

TPACKET_V3 currently serializes block retirement against payload copies
using a ring-wide read/write lock. The retiring path also holds the
receive queue lock. An unfinished copier can therefore delay unrelated
packet work and the timer, particularly on PREEMPT_RT.

This RFC separates sealing from publishing. At most one block is ACTIVE;
several may be SEALED while their copiers finish. Copy completion retains
its original block, and publication advances strictly in ring order. A
producer only tries the next block and drops capture copies when that
block cannot be reused. The mmap ABI remains unchanged.

The first patch implements this state machine. The second adds KUnit
tests of the actual private helpers. Test-only delay instrumentation is
excluded from both patches.

This is offered for design review, especially:

* Whether maintaining ordered publication of sealed blocks is acceptable.
* Whether eight-block batches plus system_dfl_wq are appropriate for
  a completed backlog. Each batch releases the receive queue lock.
* Whether the private metadata cost (24 bytes/block on ARM64) and the
  extra completion lock acquisition are acceptable.

Discovery and validation:

* Investigation started with an approximately 355 ms retirement wait in
  a real PREEMPT_RT deployment. The trace alone does not establish the
  identity or full duration of a task preempting the copier.
* A test-only hook in QEMU delays copier A after its frame reservation.
  A second CPU sends B, and another RT task adds load on A's CPU. The
  baseline blocks B until A is released. With this series, B returns
  while A remains delayed, for both full-block and timer retirement.
  Checks of ordered sequence numbers, packet lengths and payload pass;
  neither A nor B is published before A completes.
* An uninstrumented QEMU ARM64 virt guest with four CPUs, PREEMPT_RT,
  lockdep and virtio-net passes all 17 packet-prb KUnit cases, plus
  psock_tpacket and psock_fanout. The injected comparison uses loopback
  with an outgoing-only capture filter to avoid a shared NIC TX lock
  confounding packet-socket synchronization.
* W=3D1 af_packet.o builds pass with ARM64 allyesconfig and allmodconfig.
  Complete builds fail in unchanged ARM64 syscall-table initialization;
  allyesconfig also fails in lockdep formatting with GCC 13 and
  CONFIG_WERROR. The errors also
  reproduce on the same net baseline; full builds are not claimed as
  passing.

Hardware integration, performance overhead, KASAN and KCSAN validation
are outstanding. QEMU results describe generic packet-socket/RT tests,
not hardware validation. Finite capture capacity remains a limitation:
this design avoids waiting for a stalled copier, not capture loss.

An LLM assisted with analysis, implementation, tests and writing. The
technical request was to replace synchronous retirement with per-block
copy accounting, preserve the UAPI and publish completed blocks in order.

Base: f75062536e2d45ee182828f0e47e0124be2fdc8d (net)


jingxuanxie (2):
  af_packet: retire TPACKET_V3 blocks without waiting for copiers
  af_packet: add KUnit coverage for asynchronous V3 retirement

 net/packet/.kunitconfig     |  10 +
 net/packet/Kconfig          |   9 +
 net/packet/af_packet.c      | 323 +++++++++++-------
 net/packet/af_packet_test.c | 649 ++++++++++++++++++++++++++++++++++++
 net/packet/internal.h       |  27 +-
 5 files changed, 893 insertions(+), 125 deletions(-)
 create mode 100644 net/packet/.kunitconfig
 create mode 100644 net/packet/af_packet_test.c


base-commit: f75062536e2d45ee182828f0e47e0124be2fdc8d
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
