Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010044.outbound.protection.outlook.com [40.93.198.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A6D3ACEE0
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 14:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792333190; cv=fail; b=NKE8aFTt4QQUGTxryMJMzaz8lWix2i9flroCUcg8uPAxpdTN2ubqW1dqrySs7Y62CJlhgquhyHPmlatWtWDbZnTLDp1GqO96wIHHJSH1hbzzq9lvuBd4EE1MTBfoeHmUUYjt3HatQQVEXhDVEnLXeuNKjW+KYsA9wzhLffLIRJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792333190; c=relaxed/simple;
	bh=VCZJMIAqBQSjx9B5jQ8aLcJp72cn2phFf5l79KEXwfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RqPumhoN2f0EZHRzdz5v8V+T3OaJxrlGtEOGCzgte19ZcW5J6ZOQiMrT77TDMlEpelzrnUxvZfDDyPhLNUgErcxhjHjbL8LcHL8BUsGEKqTFmEkkXFQX71LSeMyhWSN6Dn5Z+Ob7Rmo/0kDcrjAyaGpur+t6p0H5UR/a9AAVoeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B5bzTL38; arc=fail smtp.client-ip=40.93.198.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B5bzTL38"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q5L45l3+HYyTxuU3h8Ry12WG0QrNsPVpBkSwtlaoZOQXJODLxeo14rBPtUJZWcBhxmAYEj0AAdNXinY99qyFFHf1OLbRBPsUtteA3T3Ok05i3Pfp87WlfqwRh46hhJjZFxJjwFTKSL8c4FzjQrD4HR6xqAcHJNr8bt5H7pq/9kk3kGd4tNPCg7witFix8JLbVkkYngfyV49IvcZ2/EYMzQkRD4P5I4hR/mcMxl7R9C3sXc1LQOeKt4JpSx/ybsQWGw7S0y6xyTYTL+uQhHgbrc3mSECmtn4BzP7G8NLbFv/jGWnRZiizdPNmX88wYwttH8EtopV+NFc9e9zH/LfLzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WuK4QVdhUHtd5UrCbwgMgKIxB/5Z4jrggNCF7slROw=;
 b=SDsONFQaakcf3ZL6ggBOjoFWE92ec2aIvnJC7eKSh5dUPRAdmRVW98Zvoydj9B+yAXIpUKienl8fleHbkrvEAvVYjMJJ+7PfG0DriUB2BXOEIshX+fswvynZEttV1wK5em944+3aP2vOfeiwMy3220I/4xUaTzDMCaVZsB5IDRBbZz+375cK40JwV63TeWzGBReZ4HKuYSoXNaKS69Nmwc+93/aquQn+gFzcPd4askVQbuKIiUMulCNoKFwDtSPoEJjdGtzPRqYyHGxCMgjHck+/bsvJDwbmu/3xpSEz377QYs80c227lvN/UIatV4NEYg7MaGasvlTEFc/2IogCeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/WuK4QVdhUHtd5UrCbwgMgKIxB/5Z4jrggNCF7slROw=;
 b=B5bzTL38/LRvCUAhvc0jEmAyJqNc7W9AnFO/aBJhehhJjiV2NCfRscyYuwxr2QImU6w16dhyzXi2DF7ti4VGROxnOb86sr9xLPHRj6GwqdxnH/lR8qiltSj+FwdYTWRzHw7uX/oOYG1vVF9+ENfS3F81fHpTcaJFxsABCsu+nd+q8/d6yRZ4BCWqwuXMbIEFKoXS4c36LfmlXnfHB7m3ODYDbc+Ayg209qoxKG7Ys9V8fHH8nv7IBjCv3V/wyQr7wXeE1B4Fp3nqtbVn3ta/+kDvr32vxRPxjeXKhxI1m++Ktrpk9qoKP1aYO3y28O1We32djko0eEwfXGVDXx7aSA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by DS7PR12MB6094.namprd12.prod.outlook.com (2603:10b6:8:9d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Sun, 18 Oct
 2026 14:19:44 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0522.017; Sun, 18 Oct 2026
 14:19:38 +0000
Date: Sun, 18 Oct 2026 17:19:30 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] ip6mr: clear skb->cb[] in reg_vif_xmit()
Message-ID: <20261018141930.GA2559968@shredder>
References: <20261017104228.3418775-1-edumazet@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261017104228.3418775-1-edumazet@kernel.org>
X-ClientProxiedBy: MR1P264CA0018.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2e::23) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|DS7PR12MB6094:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bc1b281-1bfa-4dc9-7261-08df2d22d7ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|18002099003|10067099003|22082099003|5023799004|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	PfUotFA/iGEO7i+e3ed2bRy4j7boaxCS8O7tWKjOwre3jJY6ycmDuUzb2sOIUvua4z4d+Df45JueHQcBCjJ617B3al1He6FbAGxrvfCo5E+QTDRxzNhSE2RLex1dia+iLDv29WRgipms8f3YGkuePo7WU19kKPA4re8jEJKNGw08zE8ObSrIQNssWbxIKya8CATMKLgCn3b2r4ws3D9s0Jp/88MxoUf5yyLgGrwlhiOQNcDfvwG+nYw7REJhPGBH4GPRzKJnZJ+VreWZAwmkP+A0OJT8BU7xJ5zW/vH6xM0u8TIK5aVNyO3Lxgzc5NCO37eFKCRjTkgBz09+3M84uT9zDQsWb9bdvQoq82ZoLrqEaXYzHr4Rlgn0NO7LjqM0Bm98zzEvmosXPSPMQzCg/y1v71C8qwhJz4yr1ZJrDD/QF+yn2J9eqQuvWMa3D1Z+AvKJa7YcWtnFIWwdUe0zCvc7iuaB9POMlB+mEpjfCbIZk06fqL4J77YHnEkgnG/BW8ArnaXa/dsS8Z6JaGpr9ElLNRnRlOD+gBXmL6VmPO6OR1xXA0PCXf5H1C+yCKH17Yi6OM9/7PnoeUgMPGbjwvFTJ6WMj+/4nGV9oOUbBea+l2F5His6AN1iqaSBpB3T1Ff+P/k8qDT0DG2RFyXIBiKsEI5jMkDQRH0WnjVf4sM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(18002099003)(10067099003)(22082099003)(5023799004)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GbrIGQQuzjrelmlNRsM/Lo+K4XYZl/GArL3G+1L2FIgoOflcFXS5gfz0lzlM?=
 =?us-ascii?Q?OlfPYq5PW3pEfX+SMPwqR1Kp0RaoPV4CKgNXxm6shzwN1tRQjfU5QbndmZJq?=
 =?us-ascii?Q?jPnAn2RQcis/xsnJb/6Ll0S8EJ+zfUwrOQguL2uJ77uQt0LpvtLYJkHY5oF6?=
 =?us-ascii?Q?wl5n2fdR4KQvBF1kc1jgFNrrFTNZiMBa3VHke309m8BZ+yUlDD1YAwblgQh0?=
 =?us-ascii?Q?PoKy0K3ViyYKdlgkEmy9R1MPQ2pBnXfBHlxkxs2dvJLtdA59Yqp+nZlfyWoi?=
 =?us-ascii?Q?P0b7yh68d6MHkgDL1KANWXfVKoaOrClgD/q3JZzgm0J0Z/DVtMrFmRVtSyvQ?=
 =?us-ascii?Q?e250tXboHhisiQFfDqor3KFsLD2tZAzffy3lEzLCuLsTmY1g1PeC4orQDu1g?=
 =?us-ascii?Q?Vl7RN0CLrC8yejS36hExN9x4ji5gu+YZcbV2TT0oYhmPtpv+GdbrcZb/lEP0?=
 =?us-ascii?Q?gptOx+tnEtd/SquWT/zccu7d/iugzXQRdPWSdzbYvLBXH9AHi8dvvedo4n23?=
 =?us-ascii?Q?Py5dk6EdoceBtvstR0tOlrUtnpNcxLusfFr1iP0renMlcPVZT4Bc1fbzE+h8?=
 =?us-ascii?Q?eZ/8cwnHnhyKl8vEHa7xLX4FhtMDQooYQOHv96mWvGCPOSED2+3dt/r+30g6?=
 =?us-ascii?Q?KtSCUkZyDmzxmrwj+pP8uw4ufDRniSeuEI6QUW1eulO1PVO1Ed6RZ8hzE/gK?=
 =?us-ascii?Q?qyC5KMzOmCl7AYVw5giSjUeMMVGIChUb/EvDfg4PRSj1iccDf2IajsFqs07a?=
 =?us-ascii?Q?Rry02ZFEJgZBAld0N+4Ax7bh8PmE2NYyzDk+zvUWB80Cy1l2RhD1K1NXH+od?=
 =?us-ascii?Q?Ynh11P7dvG6Tb3qiWopNmEo72IWipMs1kKbXpIpIl0Kr0bPN80TuIp3iVkyQ?=
 =?us-ascii?Q?wg/ZpEPBZONZiRFROoUYmuyaTcZISECo36j1ySN653FzeecWIR+whrFYjAHx?=
 =?us-ascii?Q?w+Yd7W0gA5D8693HELFUUtGFbNhtj2c9bsKPx+8TuUYau+7if83iGe1hUavm?=
 =?us-ascii?Q?d7fLlhIEKgtL1sNJVgMgOc/uq3l0AELfDYMEkFOQdaNQLF3DkRKkCzenBIE3?=
 =?us-ascii?Q?rI2slRGalk+mKommIFxsWdqIJ3Vx4XrUStm/TdM3l3kUcTJRHO/HElnUtg2t?=
 =?us-ascii?Q?Q4rgZFf8UPTKjKeR4I0QCRy4StzW/xj9M2P75yEj4gN16+Se9AyeUTsKh1Ei?=
 =?us-ascii?Q?n32Cqwcny6JlAnpe7d4XVR1jIew5X9qoixsES7vd7skO8f/t5KSg0YAuHpco?=
 =?us-ascii?Q?vW78cdvrj+WKTlUhhB2iTkcHVw/8oYjJllQBWrWCsgJn2IF64teI0NI/2dkg?=
 =?us-ascii?Q?2laBiGYJb74hbxXcbpisKfdhBAZhAR2AQam7OinkyG/Q+zV0AZQdegaOUawl?=
 =?us-ascii?Q?WnNxDeemXQ5xyzRXR51DzPVVXFFwBQEucp6oEZ+DTYEEG+TBoTI7njPoYB+b?=
 =?us-ascii?Q?oITA7Kntitrj8SAjRLATZEtjp4x4DR9cHYzZWRHDJ/rU+nMv0mHctbQ2/8VS?=
 =?us-ascii?Q?ZPGxulqX7nGtt5ApLCWCKlW3kyns5p42winZAcbzl6TEhl/LIoLQVksO11hj?=
 =?us-ascii?Q?S+vIPLCRpgpd0ZuWoxnVA1ashN1s88NdDX4F50NnYenUNL49KIdi+vW1qNog?=
 =?us-ascii?Q?JK/Mvu0DmONCwbRlRdN28YVHVPWp2zKVweymwihaYnS4YqY+dR33dCOXq29w?=
 =?us-ascii?Q?HSnYFbY1qNnMOCPDgN8kTN7wIjAPE9dliVidqEdrmNAb7lvF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bc1b281-1bfa-4dc9-7261-08df2d22d7ce
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2026 14:19:38.3633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w/cbjtpaHL9Ue95TAwaP4opdjyD7UsQAvdZxwU7Qnf4jQCps18BfxQVSWsYaFhMmMZbFw6X3IcTntyo0gSwgnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6094

On Sat, Oct 17, 2026 at 12:42:28PM +0200, Eric Dumazet wrote:
> reg_vif_xmit() hands the skb to ip6mr_cache_report() as an
> MRT6MSG_WHOLEPKT report. skb_realloc_headroom() copies skb->cb[]
> into the report, which is queued to the mroute socket, where
> rawv6_recvmsg() reads it as IP6CB.
> 
> By the time the pim6reg device transmits the packet, skb->cb[] is
> not IP6CB anymore: qdisc_pkt_len_init() overwrites iif and ra,
> and any qdisc installed on the device (fq, fq_codel, pie, cake...)
> or a tc BPF program writing skb->cb[] fills the area holding
> dst0, srcrt, dst1, lastopt and flags.
> 
> Since commit dd433671fef3 ("ipv6: validate extension header length
> before copying to cmsg") these stale offsets can no longer cause
> out-of-bounds reads, but the mroute socket can still receive bogus
> IPV6_PKTINFO ifindex and extension header ancillary data.
> 
> Clear IP6CB before building the report. The skb is freed right
> after, so nothing else depends on its control block.
> 
> Fixes: 14fb64e1f449 ("[IPV6] MROUTE: Support PIM-SM (SSM).")
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
