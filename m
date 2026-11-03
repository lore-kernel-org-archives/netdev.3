Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793708371;
	b=y2Wmq9wT+gtDWbSq6fxzEPC0yAULCGmpOOWnopJ8DecUrb6H4uAuwITveGtAGiUalAyu
	 pHJrSRBQl6WaSSLEDYlffms7ma2HvOlzV+00etC6IlhjWd1DHQrbbO80J4pgYgan7yfIc
	 PPdE1qLPwoGcqIhUQGD3w/VjUeHZboyydiL8C1XuPxeiHOusY70lhavpnurMLFi2F/QEU
	 ilAE/fIenAu8vWRl4u4YXgPL2x2Xh+soy3C+OnpESmtGevB7PCW8curv9c0bkXdS2+Dcf
	 1rYAHJoFuOHg2S9zPKXzO+tQh5MxLdHjWN6+5klBo9xdg2v8lbxcTgq7n/B9PTlGSGQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793708371;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
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
	bh=Hu9WfeOidFGNFUEKpIpnsCJPrTDDUP+wHxwVX8pPpJM=;
	b=wTDZsrQoBsgHZ6EOU7BjSdf0n93bR6+ilFgJL+t6qVHHIwCEEZsAR++a1aMeCCMR1hQN
	 sgzQge6ZrblqwAHoC1EwR5sbBiYehigt0ZXjF/XrchYO+JnBGDKyRFo/2UtSfhQngqAVj
	 GsMeoUu1dRxkuE/QOQQLkjuHY3guBeW9/mhjJqNEOk3fQ4Gq7Q5KDhpvJINy6ui0FOpOg
	 7dJ7tgsTyRsBFYTVJzeTntjw+4hWPkUG9JfF6wDqWY3fXm3QVUOur2xi31HTKeV+viwTW
	 Jcu8tXtrKqnah6mECQ5xvTPeWYTMC5OqsRdL5DZw7oyjOT/x+UJYkJ16JLCoAe01oMA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Iop9vbf2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.7
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012007.outbound.protection.outlook.com [52.101.43.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CC9606A324;
	Tue,  3 Nov 2026 12:19:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90CC9606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Iop9vbf2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tw8hRG7tI6Zm6ZqiH8L3/+axCnPMGqkWbfR9AA4TahUKd8McaIsB5Bm+6x1DX50P9C+yFEGHnANTiOshgD9oKtpJ5w7NRbWWDTHb9tAdweXhTvKqWVleAGzw3QigmjDbzsydws5SQKAEcuXZ7CEqoZ5ZMpoOJrC/lZj8hTqNUHfWygbzYyp/vK/x0EPa7bYvIZXG+Nihd0AGL5uMskV2kOCKiyrlpB+L2L/ZcPb9stpAY7jxD0TwQ0PpHpOjvKmNY7PNCHj7+GSHwy1nwpCREVknQXrwHVzv1yZ0Kcf66NnDqg1RtycDLgkSCSBNAXBtnxWtyia2sRZwfJ3/seiwwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hu9WfeOidFGNFUEKpIpnsCJPrTDDUP+wHxwVX8pPpJM=;
 b=FxWa2+MP12w0gdfSjiya43GSqc+FjmY8JDo9r6KMf6v+l9JkMiW0PQEFATLHA3G59Qnq2JMhPa0cUj8sRRySSrHbmw1ug1cSAhZQRr8PJVjKdcbWD6xY+cdBJhB+WvQ6VDo0yHLFna2Zv7wpOt8gE/v5ch7NjbXSloNTi1fkdraH5GddQAf+ocRLKRiIy4u/k031nf/SBDgdDKL2zuRNjG6vq074QmXnIPzqwKRIvKH3WwaOWKB5Rb0fG0sEDw6hE55PfCycRt8LhTShYAY6H7IFEsiooK1TvQ3bR0Ifx3J4ZTOjlzZFYuHxrqq3USNkxTgClH7U4GVEgznv+8biuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hu9WfeOidFGNFUEKpIpnsCJPrTDDUP+wHxwVX8pPpJM=;
 b=Iop9vbf2G5zrIrfgm9/KS6POMeerZQ3XyqV32xnEHM8MmvQYQdSJskivBPwLYd4FO6O/TBartXV6L/fwnUsU66ose9p8Hx76QGIma5JYVT2ubuI7oP1fPQEEXJ08fAZjcw6Qa0jx89kAsPNtI9FJS+e0/tUgxUSVHm0ZIVTzHRv34DNpBWpwq8tQ/2VbaJTMW4ckHNrqtnIdmlEeiYJOEBozhsH+O0trvdhwkC7V3PHK02++HVDojaQCAi02AzkM09FRviIRITnz0/e/kNCIkhiKJCivvdBVqoDMAjtn5s9oDRIujDv43LEjkoa7Ikf/M45/wcpyvfqxCVBEnKBwKQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by DM4PR12MB8572.namprd12.prod.outlook.com (2603:10b6:8:17d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 12:19:27 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0569.008; Tue, 3 Nov 2026
 12:19:26 +0000
Date: Tue, 3 Nov 2026 14:19:17 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Ricardo Branco <rbranco@suse.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
	horms@kernel.org, dsahern@kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next] ipv4: add ip_process_options sysctl
Message-ID: <20261103121917.GA1132241@shredder>
References: <20261102155958.60436-1-rbranco@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102155958.60436-1-rbranco@suse.de>
X-ClientProxiedBy: MR1P264CA0216.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:56::14) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
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
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|DM4PR12MB8572:EE_
X-MS-Office365-Filtering-Correlation-Id: 333b393d-b304-4fb5-ede5-08df39a4b3c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|6133799003|10067099003|18002099003|22082099003|56012099006|11063799006|261022075727099003|261102123227099003|261021121427099003|261026121527099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	N2A5OLcE1W1i0CkLOah3rPTXiUCOeJ698yMB4LSgPnrjtMLQbQbWnnUXtEkV5N2+qHTmgNYOgzLHKXx2XmaUkSoLh6Gn9rUNdm7e/pU7bLaw/r3Qp8Ub3m0PtWXkc9QFORQ0bXU+zD5QzuQJHdXQi6CxcwIKyYjT4QjotRCp6kKa2b71iT9EaVT+6jjCZ3SR/D8WXKhPpmZf6ZxTQrYKbI9HgdBnLi7jTQtDt69cnSAip8/XvzRZR73Cb0wSJPgLDoikM2uhwMTttYCbGxmf6RlIZkFWiUX95VUduK2wNsJ4ptrBrp+b55PHo8LaUZ1sBoZtM+2wZwnRWUuOxQk/GS2x6kJbD5hITgkk7IIUuhmjJFCbp7yK/cAZo9QV8NRBxOlWcai0KzYKKuK7TbA4m1g3Y8fKg+UkYLzPfSYQgi2kEXKvwmc7Yw7jiC2UQXPFYJwCG4zeZqAubM/bEZiqP0LMmFdsPlux8SFB36rQmYzKFnA5mwswGnHvo0Eb/ga86XAH6NUj1ByD0sOT8dhSc48pK9cRAZyQZZCkU7+Lcs4g1ltBaAW91pXQC+riy/I/ade2WkdseqnK15PuqvB2AEycKFLE0+sQ3dGF7GTvKQ291dV3Yxp2/vSiNx5K1LkpJte1wxqB+YQrcOiKkvSy7+TRPOfU0ZssVwEafcgWXpw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(6133799003)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006)(261022075727099003)(261102123227099003)(261021121427099003)(261026121527099003)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MHRdD3ppKgPPfGJv0W4q6kk8fVK49OqeioA4NtNwwIJrymZNTbZ0303yzyGp?=
 =?us-ascii?Q?uDBDHv4nz2//3GVazfcj3zuY6px4dgwlT6vZxDbRfKqcTv2MZgfG9GsTkOrL?=
 =?us-ascii?Q?TC0RkgZuPijfLads5AX7RLR7INekeb85zwkKYk+vTkKA7rr0T4FcuZtrjG9c?=
 =?us-ascii?Q?XfIr0X17wMWxyXTul9eAbtPxIrq21OFRcIJUoe+4vsns+COnuNj4tlFHeLau?=
 =?us-ascii?Q?zGe7F4DWHuFOnxJiIYqpJIih82WrHDp1t7Imzo0H4RPZENp68J0cwW19xy8i?=
 =?us-ascii?Q?xXKU7m7asFDBJ3Ymxjr7VgxwLR/jg3e+SKc3aCAt0wqPQ5geB+sfvUWqHp1F?=
 =?us-ascii?Q?nf+vMenrG45n97vj65dZjHd7tNgTZkgkVqrejmdWq9lROkWGc/515H9XKLDu?=
 =?us-ascii?Q?F5FOQcdlEA0PYY8dqNWbmRFZ2rPl1pXSQWUjcZCFVtYU0jZRo8U5HAcE3CoE?=
 =?us-ascii?Q?Ad0nJrt7egbfXtyD+0UARnrbPO8eGxIPLs/MDIEutxVxV5Qi/JDo88kWqlz3?=
 =?us-ascii?Q?vWaqzwWhMYU2w0UB5RICRTJmz0MGT4duoqY7xYpnw5RJX/2CY5PIgSSrxTgU?=
 =?us-ascii?Q?nLhumMN4z8vX/axbbkBpIPm2ZFXWAEBYLFMddFUIR9i+OuJ+CXbwb6wGSQVM?=
 =?us-ascii?Q?HiJGmCu7XAKwPdTW0zT4I5ne8QM4MESv1abnlmvOJNh35aS5OiFytRnL2bgA?=
 =?us-ascii?Q?PJ/0Ujl8RxPZjuacWTdsn+RZh7ahDBg1ztoNjxO0c3JsZrcrhA8YH9Jmwl7i?=
 =?us-ascii?Q?LvsBFG2LqcxJ2SyBUKpNFQwbmVSx3W6mUBL1FmjBXYU0PBoSMqvO0ekzlrJ6?=
 =?us-ascii?Q?FzAshg/cEp/sqvqRmAA3/PdKVwvVEIJOA5YlHgp7HAxFtnmhmi8wBvPWCSpO?=
 =?us-ascii?Q?jFP5B6tI1+PXLSuEQUqIaN8BXf1+pdYyT2GkH51FwgLSoY+lrHGOTqwvKIN8?=
 =?us-ascii?Q?0j7QQdrewpRrdxyiKVr9sCmGzeih18YG7iTq36oNnvc1itfgkGvg04IBU30w?=
 =?us-ascii?Q?5ivY1FBPB2/MVTZ52IRz8sfe+l3ipPGN8nmw0vL7VE/dpx9FaRav9V6ZpKDl?=
 =?us-ascii?Q?6L0ABZFl6ZMxdeBH8Fc6pBSK7lg+ak0Ms4lRVn2a+p9yA4ycIf7lapTNdYsI?=
 =?us-ascii?Q?lzspC9MIJlcVv1BOpuisNO/JHBEMTDVopAqQODwYJttW5wNL48aIPHIE2gJD?=
 =?us-ascii?Q?3/pPi33nPjj/l2xLUeClmqB7xCl/ViPyE+iAq5BVZnTBVHl0LqSwB0KZQH1L?=
 =?us-ascii?Q?XLnXSLPeH48i5hRFhTrDu87F+JxU/PPDbcKXp/CE1okPTlCa01wFDIqElB+0?=
 =?us-ascii?Q?2uIopHHJdSV2QGtUSGdkJuGf4orT9sb+kwCxY/ruh66+hv06tRcGnxv8JINU?=
 =?us-ascii?Q?wDpk6zd3dvgdu3MnkE8RZFCJCV1NUY1WJgnj3P5Kx8Lvs/pnIpvvhOyYpspx?=
 =?us-ascii?Q?pU6zp1vT1Yj1yDd5cOdreNeUn6fbpgGtcfKd6dvcMvigvIsUHafgPj8KvWfo?=
 =?us-ascii?Q?Mfp3NUgOJbxnGgCVMzLmTHXQdPgHOQ0AnVxZz3cSUGB1C2EZfjePi6JbeZ2w?=
 =?us-ascii?Q?qFqeRllit4BUO3cAEPaNhfMwXI88goTOhnMWbxth5Q0quWfuMZZ7jsXV0PnM?=
 =?us-ascii?Q?mYMFp5tIXysYoxEUjhYWNkoWp4WEKBJTtaeR8LrCNrOWjvOlzbg4agjjkUBw?=
 =?us-ascii?Q?byZA86owBC8lICFl0i2KGhOxcRDjNh6SMTajlrrWXzqw0XAB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 333b393d-b304-4fb5-ede5-08df39a4b3c3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 12:19:26.8333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u48ZxCB070EampLelbglu3b/etPwJBorA5QD0DF5o4zqS2958ZvhuaOA5ElisJSl+DgMbeye9Gp7KL6umYNWgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8572

On Mon, Nov 02, 2026 at 04:59:58PM +0100, Ricardo Branco wrote:
> Add net.ipv4.ip_process_options to control handling of IP options in
> received packets, modelled after FreeBSD's net.inet.ip.process_options:
> 
>   0 - ignore options; the packet is handled as if it had none, and
>       forwarded packets keep their options unmodified
>   1 - process options (default, current behaviour)
>   2 - drop packets carrying options and send an ICMP "packet filtered"
>       error, as FreeBSD does
> 
> Most IP options are obsolete or rarely needed, and are commonly filtered
> (RFC 7126), yet the only existing knob, accept_source_route, covers just
> the source routing options; record route, timestamp and the rest are
> always processed. Netfilter can match and drop such packets, but unlike
> TCP options it has no way to strip or neutralise IPv4 options while
> still accepting the packet. A sysctl gives a simple switch with the same
> semantics as the FreeBSD one, which also eases porting existing
> configurations.
> 
> The check is done first in ip_rcv_options(), so it takes precedence over
> accept_source_route and skips the skb_cow() and option parsing.
> Ignoring options is safe because IPCB(skb) is zeroed in ip_rcv_core().
> 
> Note that mode 2 also drops packets whose only option is Router Alert,
> e.g. IGMP, which can break multicast on routers.

Ease of porting from FreeBSD is not a good enough reason to add a new
sysctl that we will never be able to remove, especially when almost all
of the functionality is already covered by netfilter and in a better
way.

Netfilter already covers option 2 and it can match on specific options,
thereby avoiding the IGMP breakage.

Regarding option 0, assuming it's actually needed (beyond feature
parity), why not add "reset ip option <name>" similar to "reset tcp
option <name>" that was implemented in commit 7890cbea66e7 ("netfilter:
exthdr: add support for tcp option removal")?
