Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010066.outbound.protection.outlook.com [52.101.85.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33B83C0A15
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 08:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786955298; cv=fail; b=dywGkWmTaYroXlMV5AHGNoKpjfW8AwoU7yYdUiS48dDDhFVhfxdiUOmZHlbs9egCqgCxC0+wBVmVFYvubo2KV/fB7N2HpE8IFeOYivv4ZnM+vZQ6o1K1Tt/yn7cbl/cQAxWng6K7fQZyScR0ckGAbb3MaT+RRh1iEmNHeQvuT74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786955298; c=relaxed/simple;
	bh=+fGmYeAwsjkcYcE7/ML01qxQ6kqDreuHC2Opuv5g6sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qhXbMUTmXtYxgKMYFeIdfxI+s8S/O/v2ZCNhRi+G4k1z9x2BJckwQE/4xVufzX2Ayjjpn4V6eZRw8JaCAUqdW9ExiZED0lSgRsxYzHZDS8HBd7HUaDqUaQsz63uKbZ4rxgJESid63bbDlLamFcVA90aHxRyesC/SvxK03SpJGJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Yga1hQJX; arc=fail smtp.client-ip=52.101.85.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Yga1hQJX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YkTHNzyPEkewaPv4xKBQHloWOcZx/ftWfaNIs0z1OVx048bSHzFfmGWCxk+u5Chfkf8YA3mAoQ6K6d9SabHrZw6b/J0LsbY7/vsImpNZNQ7ArrodOjozT+G0eNLmA0pDK6YKUn6dwgGkcnDpkaSj0SQvxSDUxfsy/RPKirSOhXcVbWmzPRJxqYrg6hcGRvDjGErEeG2QJ4s73kDL+RliLX4MqxJr2iCVca0J8yG5gLb32J20CPqcWb+S49Gd3uLN+U+f5n4/9uWW+YwA3U4Jj02vOPf5V1O/5ONH2rKtKHrNQSTYax617fRwLsKRRoj/G64x1FLRGohxeNExUQPhmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QF1PGIaLYtsRNmgaWi/A0/VSS9tRA1KHtKHZe9mOalE=;
 b=OngBiP9rnL6oI8oY9xtlC/M7ir6/DuZnUIT0k9DaY1vXFjW5rQQBkovXHyrGMxB1PU8thDtH7NWQSKtvZM4j/1GUVSZL5MgE8NKI+8PkgvQY/9mM95eyY937PC3dVMdl92hDyxaFoaBC8p5BZCJKw85QjqaBeTz8UUXhVkQ8nv9GTJSHCy57lMqH6gFcZtLWrIFszu98oZzBXqf/QXj+P+nF/j9lpIpcpco/GD9wf4mPCevmnU9WcYfqYzy77WQhQ8rU5nbMC/zA5TTqDdCqcOHiLluLj4PPs2T0ptPMEGgZmuatpbjtgAW5cAX8VFOtXTjJCwyWpsn6NMl6hBhzBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QF1PGIaLYtsRNmgaWi/A0/VSS9tRA1KHtKHZe9mOalE=;
 b=Yga1hQJXBoQ/lZwtxLNXft8o2QPzC4KoIfl4CGYePOcnfjlviY8+RzL/444HNG6mOe+OLSz2ZcAvayFM//cqiKH0MmMjTc8F/TnGTqrc6WuB5rV8xhSTZlf2KaOcVOdoChtGd/vwwmO+dEQJu2Ae7z79qIx8e2ZAXc8MfoQCnh34OhhBpH22rdga5tHMDaT3Ul/9H8fmqRdXgCrEhmuqVKrJ4iirUM8jSh7Ac6aieadGH0s3+NYRg15U0ktHRIgzvUYUhv1JIZWkhcFrhclx/u4ksIwVUqS3iYho++GzUMCISGIKVCKpA5y13ejOR+ByRGtn0d9dNYc+lpWA0mvcgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by IA1PR12MB7520.namprd12.prod.outlook.com (2603:10b6:208:42f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 08:28:12 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 08:28:12 +0000
Date: Mon, 17 Aug 2026 11:28:03 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Ren Wei <weir@nebusec.ai>, edumazet@google.com, ncardwell@google.com
Cc: netdev@vger.kernel.org, dsahern@kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, vega@nebusec.ai, edragain@163.com
Subject: Re: [PATCH net RESEND 1/1] ipv4: reject RTAX_ADVMSS values below
 TCP_MIN_MSS
Message-ID: <20260817082803.GA242453@shredder>
References: <cover.1786610865.git.edragain@163.com>
 <2c3901162c65a1d85cc1756a83a458db834d70c1.1786610865.git.edragain@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c3901162c65a1d85cc1756a83a458db834d70c1.1786610865.git.edragain@163.com>
X-ClientProxiedBy: FR0P281CA0048.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::10) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|IA1PR12MB7520:EE_
X-MS-Office365-Filtering-Correlation-Id: b9403fa8-a229-4233-c9bd-08defc3979e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|10067099003|11063799006|56012099006|6133799003|4143699003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	KCEeR3sByGDSqkBNbPEozI/uWF7T8OPFI8x7JTbaMFF/64mzNzUZj3iIIjNZ8ROORd6Do0k9ati7sxMt0oH26v0LPtIbiT7ZanaOW8OQwKMxr6/Z0/h1fUhXboDuqxr3Q8tIFi05xcvcHQvVsOZ5q8A6BHunezGEsss9019tv5aqLPuoHj0erGuwUz/KvMvxtnPTRx1x5chbzrdz1YcnAx1lXiarrxOiL+F/dDOIVvoJfjBJQnWTZkI76fvEYiHkEQs1ZYcli3hZbjpx7ZbLjXpZN+6nZifs/TIMuBFtEFwn0p2say1BERqAHSpJsWadgZABq4CVR2yGCVFOY0C78n8RMVuJV8drd/UD6kGalFStvOeLZJQyVKQ3sV2TEDWKSunxcfTpRF5xGrULNscGdoXUj5/iGmJnQT9ppcevKbMzYl4hT99+xqT5X6mREmPxcZ1ALThc1EjYSMAl8JWmnAR0Y/UMrRVA0LnUx+C0qdRqWymNEYdYjVF5FWkKKPPjyRgiYBVfTwR2bWuBTja1GX76b6FG2v/G+zghR8vk73F8PUjkrvyYGpAzWnHlbmXlKNevhUznhUyhd1GhqoFo5CT+yAY68s4kYu0icWMsy1ATAOt+m0oCd62r1hNgssTI3wHppRDuXcRRvEdKO1PSdqnmrpMSb36qez1qA8HbD5A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(10067099003)(11063799006)(56012099006)(6133799003)(4143699003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cXchmagywNZ5wWQI/pYCs3oYev/e90hds1nQcJcmiTisLerRF+o/M2jbuoX8?=
 =?us-ascii?Q?PcJCFWu74M01HgweoIkH7FTMEEXa4AxEPd4nCGL++YLZ3n545irm8YhS1n0m?=
 =?us-ascii?Q?mNXJqlWjpB8fuSMrMTA1XvBbhbyrzDd88TKr8QweD5XuSPREW0Idtx/qeFc7?=
 =?us-ascii?Q?Ak0TMA2nsydJpFX8fYiSIJALybcgyXHytqbGQwuZX+alIEnCJu4WVuTZaEJY?=
 =?us-ascii?Q?cudokwwKQ4EeQqjT5p1H9lhUhdAzArzEcdm8G+T3Z2plyiqtfsLWcrzk5C7b?=
 =?us-ascii?Q?FShJhaEX+U+X+RsMVpaVz1th8FstQq3Xuney0B5oY1+KiRXs5jx2TdyeK1Nv?=
 =?us-ascii?Q?36p5OsO5fez3zqQ5BKxXiYhfx2A5YR9aMzLSncKGJKMT4xCPDlaVOS7nroKE?=
 =?us-ascii?Q?T3qW/ruoPT5F7/bfBciBbj75PTW0FlCkstzAIap9O61M8WvLlCm1SYWEcQj7?=
 =?us-ascii?Q?ZwoHH5z/OMWXK1Hit4kTTkldKuXgPrrG4qVmQgJotfRnBmqDY0xwEA8hiiqC?=
 =?us-ascii?Q?G9kEo1+OdNQ5qXK6X8rblkhhdjrCJdhAN2+0HvIlKeYa1EdYSjCWem+WlrUo?=
 =?us-ascii?Q?BfrXTjdhju2QALvMiRRz2jB0UfQMVpjCuZ1xmZSTUantqApC6nQXbLCFBbUN?=
 =?us-ascii?Q?Fq/5beqtSn4R0a4s83LakJXw0HCBlBtLprADOImjSfYypkDQeEBtRkVRVRoS?=
 =?us-ascii?Q?otxi3MXF1Cd5o6Xk3kcG7hsrpXhhxka1TJjU/vpsHW2CkVy/bv8ahTXEbHJa?=
 =?us-ascii?Q?v2RgF3pheK8VnUx5kjqHl2KQl+TKSHCOmgGOmwZXhZRozceAF/J/+VQFqsmm?=
 =?us-ascii?Q?ADWxoxzx/QTVEYDOt00j7ah4r18EupQCQeHiYUDdAQeW49qHxUsJS411Aga5?=
 =?us-ascii?Q?5u+WKmW3C/hk2N5VKoF7bn30qTeQRPqcWq9KvmsB105k6yFNU/gQ4vQq1TC0?=
 =?us-ascii?Q?1pikZlKi+UdgbL1rNXb6KBMQhNmsAyVJqSa6U3J2LMIQ1UHP1ZmL0t6MD8dM?=
 =?us-ascii?Q?D2ZT9E5Na5o6VPz12Bhu9M4cTEoaYVDRU7YjCec5bqcJhajcLrUyAR32tJ/J?=
 =?us-ascii?Q?+puA19VozKOouH3bo1c9h1zRLvAK839rsXaysG9fZm94IRca9VVXAlQkysvA?=
 =?us-ascii?Q?V+Vwd5ci1Afi3Alp2P5KV/pyYBwYII8qVJULcRGgjNubnG52JlMPCjSz6xLu?=
 =?us-ascii?Q?QTmBV3DXiSoz5krjTksZJZqFnBeYEomrqPBN3Mztnm1aw1MPPlMAySGd+TuP?=
 =?us-ascii?Q?3ofNQkC2QtlZzG+MCr897dkKTcMT8fUdcL5GmsSaZDcajTNYR+k+Wh9n6g5p?=
 =?us-ascii?Q?nNVynOXnl+HQm/DY9i4/Dxyk9sCTIy/6hleW59eSttg8f64JhlyFgsokcleV?=
 =?us-ascii?Q?/d5xfiXCH+AHmMEadBdP1RMxxBzgY8RKCVcYR8nmFoQYK3VgnhSQS0Z3/ss0?=
 =?us-ascii?Q?0MDNzA3RsVm+nD8xWaafaFzPWTueQfyNmTkLNFoyeHmb84SweV5bDPrtdn5z?=
 =?us-ascii?Q?gzhZWPLSTkV4TC4WCQVQC+2JD9UZiTZLRxmHDau4IQMuQtyTqlGbb4kQIafT?=
 =?us-ascii?Q?PrxJug3hkroxV66ypS/yAWybf+ydWb2b2PQ5mLx4mISjGQlxlZqcBUrNGViY?=
 =?us-ascii?Q?2BVXnTaOhqQfhMz17zCl5RGOn+Ga+oUEQwY/89L87WFi0QvuwNUoiSmthLfG?=
 =?us-ascii?Q?XmThEIIsnfpbmouNFIdpRSUc+gu+sMIS4jDPsugcoCmP8a8K?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9403fa8-a229-4233-c9bd-08defc3979e4
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 08:28:12.2677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R3SJh8ctmc0nJXghw1hs68hxYK0UTHkb0hgL29PeU+bU5e0ml0mmtrbd7BVr85qYq8plSdpqNNnP7ijys+M5nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7520

On Fri, Aug 14, 2026 at 01:05:34AM +0800, Ren Wei wrote:
> From: Yong Wang <edragain@163.com>
> 
> ip_metrics_convert() only caps RTAX_ADVMSS at the upper bound and
> still accepts undersized non-zero values from userspace.
> 
> A route installed with "advmss 12" can later reach the passive TCP
> open path. When SYN timestamps are enabled, tcp_openreq_init_rwin()
> subtracts TCPOLEN_TSTAMP_ALIGNED from the route advmss before calling
> tcp_select_initial_window(). This can reduce the effective MSS to
> zero and trigger a divide-by-zero in the rounddown(space, mss) path.
> 
> Reject non-zero RTAX_ADVMSS values smaller than TCP_MIN_MSS while
> keeping the existing "0 means use default advmss" behavior intact.
> 
> This matches the existing TCP_MIN_MSS based validation used for
> TCP_MAXSEG and fixes the bug at the route metric input point rather
> than adding a redundant guard deeper in the TCP stack.

Eric / Neal,

Both sashiko instances [1][2] claim that this patch doesn't completely
fix the divide-by-zero issue: it is still reachable by lowering
net.ipv4.route.min_adv_mss to 0 and configuring a route with an MTU
metric of 52.

Given the above and the "We assume here that mss >= 1. This MUST be
enforced by all callers" comment above tcp_select_initial_window(), do
you prefer to fix this in TCP by enforcing a minimum MSS value?
Something like [3].

Thanks

[1] https://sashiko.dev/#/patchset/2c3901162c65a1d85cc1756a83a458db834d70c1.1786610865.git.edragain%40163.com
[2] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/2c3901162c65a1d85cc1756a83a458db834d70c1.1786610865.git.edragain%40163.com
[3]
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 2c5b889530b5..670c20876f26 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1782,6 +1782,11 @@ static inline int tcp_full_space(const struct sock *sk)
 	return tcp_win_from_space(sk, READ_ONCE(sk->sk_rcvbuf));
 }
 
+static inline u32 tcp_dst_advmss(const struct dst_entry *dst)
+{
+	return max_t(u32, dst_metric_advmss(dst), TCP_MIN_MSS);
+}
+
 static inline void __tcp_adjust_rcv_ssthresh(struct sock *sk, u32 new_ssthresh)
 {
 	int unused_mem = sk_unused_reserved_mem(sk);
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 7f413f509d7d..497b1a0370cd 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1736,7 +1736,7 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock *sk, struct sk_buff *skb,
 	tcp_ca_openreq_child(newsk, dst);
 
 	tcp_sync_mss(newsk, dst4_mtu(dst));
-	newtp->advmss = tcp_mss_clamp(tcp_sk(sk), dst_metric_advmss(dst));
+	newtp->advmss = tcp_mss_clamp(tcp_sk(sk), tcp_dst_advmss(dst));
 
 	tcp_initialize_rcv_mss(newsk);
 
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 6ab3e3a0b431..fb901b368ecc 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -440,7 +440,7 @@ void tcp_openreq_init_rwin(struct request_sock *req,
 	u32 rcv_wnd;
 	int mss;
 
-	mss = tcp_mss_clamp(tp, dst_metric_advmss(dst));
+	mss = tcp_mss_clamp(tp, tcp_dst_advmss(dst));
 	window_clamp = READ_ONCE(tp->window_clamp);
 	/* Set this up on the first call only */
 	req->rsk_window_clamp = window_clamp ? : dst_metric(dst, RTAX_WINDOW);
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index d7c1444b5e30..7b761edf86ee 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -143,7 +143,7 @@ static __u16 tcp_advertise_mss(struct sock *sk)
 	int mss = tp->advmss;
 
 	if (dst) {
-		unsigned int metric = dst_metric_advmss(dst);
+		unsigned int metric = tcp_dst_advmss(dst);
 
 		if (metric < mss) {
 			mss = metric;
@@ -3972,7 +3972,7 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 	}
 	skb_dst_set(skb, dst);
 
-	mss = tcp_mss_clamp(tp, dst_metric_advmss(dst));
+	mss = tcp_mss_clamp(tp, tcp_dst_advmss(dst));
 
 	memset(&opts, 0, sizeof(opts));
 	now = tcp_clock_ns();
@@ -4127,7 +4127,7 @@ static void tcp_connect_init(struct sock *sk)
 
 	if (!tp->window_clamp)
 		WRITE_ONCE(tp->window_clamp, dst_metric(dst, RTAX_WINDOW));
-	tp->advmss = tcp_mss_clamp(tp, dst_metric_advmss(dst));
+	tp->advmss = tcp_mss_clamp(tp, tcp_dst_advmss(dst));
 
 	tcp_initialize_rcv_mss(sk);
 
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 9e9155b1b3aa..df9c29eb5c1f 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1487,7 +1487,7 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
 	tcp_ca_openreq_child(newsk, dst);
 
 	tcp_sync_mss(newsk, dst6_mtu(dst));
-	newtp->advmss = tcp_mss_clamp(tcp_sk(sk), dst_metric_advmss(dst));
+	newtp->advmss = tcp_mss_clamp(tcp_sk(sk), tcp_dst_advmss(dst));
 
 	tcp_initialize_rcv_mss(newsk);
