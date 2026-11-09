Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.4
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794228501;
	b=Ity0SoxPl1cSZvLIijnf8TLBy8QXNLNT3A7aqxmL5chN4petyZHlboYwB2gbm8BbuKcd
	 0BUI6VOVYNypdakDSg2wEiis6u9b4idRgATf/HUaBAI3YurZzWsL0O/0fRit3kRTY4Oi0
	 UFFvX7cwMywVIZK1ZKKUDDMLVeXRhP6Qhmdxv9lZKaATHoSPpPOcYVtK4GohCw7Ce2Jup
	 dZXjVyolELU4vhipHNJtTSr1VtrHOwz2cZ5o+D2vaK0fES4FBmavhNXzg2hEZK5PVt7ye
	 OyPngFGvl7GSj5OegNTn+hgFne8+xh0HEaer0fWtN16/LPE7IlEH5XLyexfHzqsn5TA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794228501;
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
	bh=xFOG5roxbO+xfwbLfzEheoBfGv+COL1fKyyCWPFPTEw=;
	b=mRwkDNnI4qrU3pzMDRzaUZXptjR8RH2uwi57ljbPd+OR1obAVEANl+2NM6Xba3oAZT1z
	 eQKr9wOwxItPi8O3OlNuE0bfNPWiXD0r4CsOR8KCzjnqnzBelE7BanqK37/zrvxfjSCwo
	 cdLgwywPWx1VWuXTeHBMhHeMRHmQFR77LsE6CUaAcc8Gsxo1GQsvIjqZKCUb1XEBj7VTg
	 OuMxT5T1i0Ho11CJ3IKSuYYxAKhZmOqFGeAthdrHJPLa1gkYZtVI+DtiZOCx9kXnAvgHQ
	 wcpIutcrWb9P6C50t4JFGBA4hsqOheCSHpiWSPDYvXKHeKNcAgpsShAX2ZwwEGmOJMg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=AdgJtomO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.4
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010004.outbound.protection.outlook.com [52.101.56.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3F9606EE8B;
	Mon,  9 Nov 2026 12:48:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F3F9606EE8B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=AdgJtomO
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F365zA1u3SlDc5qjvWBGrnbR5EBocakuzRm/e17qrAwfsHPpY+ERyLMr2TCgeCu9WuJAOm8eJN9Mpxd/2dZPqkUJa3HYetjEiOaWMB0f2qbC4/qmkkd5ndNI5trfKFJpPvJiCl8/az2fXdRhfo4LgYSphqMkrnvRG8oY4zN1AXyl7DnGVEsK68gxPeb5B44yZDfTQ2Dn21lplDndGv92qH+cA3KPVlaH3LjdlCYj1+/qlXek9r1unBdYSD+ggPo5wMXdfQ6rF7dpJpvYOLyYnMm6R0j+REfFFykDPbX+WwBcEetXrbDSN7ds3ZY+EKO0NSwmUaDo629QW08DP+wqWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xFOG5roxbO+xfwbLfzEheoBfGv+COL1fKyyCWPFPTEw=;
 b=P4y2zHiEM0p4T4TzuAKSkYwdZWzah7xv4/Myr7E4tqkVNqxLXNaHKLUcUaSyEKtpKjqzNflE6tsn2CSmKNbrkNDIfhE+nymb0W2Vq/1iUxcicCjZVBFTYRtdfphLkWUOpiPeMPAbPFb7mn9sinOiNQPNTlD6iHqOSTmcN4ydAGKLBJvE8/pspGN/zwPf4qC6APzPnVk9Zqkt2DPo3vk+RdFbyuDfAPDKj3rLRBZg6V/O5lM6zWRHF0zbKf22g9dbykb0bhwxeHpNn6uOeL1cE7ure+Ic4IDr8n732aQDruOZeuLQTe7X3tPp1PQPAaFnO8b9v/uilrVqK8D9+r/30w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xFOG5roxbO+xfwbLfzEheoBfGv+COL1fKyyCWPFPTEw=;
 b=AdgJtomOSGaa8gs1PaRV8Q0Vk90VmJMMwk0Hm3E85CV2akFi3jXjmJrwW9tbzL/Q1e37Yg3v582WsBYPO4F8/Rx2zx4xZskBUvN255G2gNJ2T11il06BpFL/DK5zZ3IM2iAoc6j7fAZUafv36+sUT6Xrkdf5/jIq+v8DKLF3rA+agUE2T5O+U0tWuU7Yg8Se/iDfBJNjwj35uYUwQh4jBJsnXM6rkuOqCydJzF0rbn9ftsJfpTLLAq1wmgDmZ0H3Iprho1cHPgdsDT2Is44efS0bb3BY+K24O12y6tNCg1DbOOI0eXueBy4dpv0ICiPtF1/prka9azvFa8D3Ko3qGQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by MN0PR12MB6173.namprd12.prod.outlook.com (2603:10b6:208:3c6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 12:48:18 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 12:48:18 +0000
Date: Mon, 9 Nov 2026 14:48:08 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Chase Hiltz <me@chasehil.tz>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, davem@davemloft.net,
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, weiwan@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] ipv4: route: don't blackhole in-use routes when
 retiring fnhe routes
Message-ID: <20261109124808.GA1658897@shredder>
References: <20261105182640.2999521-1-me@chasehil.tz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105182640.2999521-1-me@chasehil.tz>
X-ClientProxiedBy: TL2P290CA0013.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::7)
 To PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
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
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|MN0PR12MB6173:EE_
X-MS-Office365-Filtering-Correlation-Id: 440cec77-3eba-4bf1-5136-08df3e5fba6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|22082099003|18002099003|10067099003|3023799007|11063799006|56012099006|261028144727099003|261026121527099003|261102123227099003|261022075727099003|261022105027099003|261021123027099003|261021121427099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	HNQIkh/4DOCgddQ26jlnmp++AmddA6bhVbV5H1RocNkFQe03W84m/z66n9FcjR/Fz/vLMKnhPCjnAY44qdDEYgIMmTFkrf57BjimVfjT0V6k4nGZymTCwRyO1cUXtvsGtVFm4v6YKB5l29lcyPx0kvhMBuKjqPS4K7Nj/IhAq+j67lLRxvpzfhSiLI+Wl9o7e8VpcQ1QrC0rm+Kawok6++ix6nAI2U/C2EluJpuo4YQ37GYt5gsAPINr4hQ328yHUJLHVJSQdTw1+Xk5p5x3PBPut8dXTvczhEW/HvtnkhKMk1oQaV9+4t7J4T7NO6phevtd6dnaOYjhuQpHfNjCQfXOx5BwPFQTPX+BFQ1hNz9jWBSGIc10+mffaC7byRIsBvw+Gtz1b9nVtUZtkqIJvhhkFs6diMhuSJypEHouc14hQNqzu0wXSgjNEAkwow0V4+Oc2Xccisi9/eFditColtOTgKNKZh+A/37sg6socG0uoWOfQeNCwjzt0swIvmJIBmJbkZ2Gn5CqsIX6R2vb2V8UDQTmE+iqOu5RQ3s09lhs2FKP+a9pIls8LTxvvLKcTyc4caeT/vkMtDyk8a0f048MlIPtjLntBmJDv93eq3mvqI6QC8rff3rJbEU6CbRQrXJc0VEtGQxR5lEdHYJM4Xd02TBRiy2CpyIjogGBli0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(22082099003)(18002099003)(10067099003)(3023799007)(11063799006)(56012099006)(261028144727099003)(261026121527099003)(261102123227099003)(261022075727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?duodhJm9TRcUl6SeDw1GzQ1aqW0Agt7Qt9/F0AHsHTkWcJ7f8LMYMembGowM?=
 =?us-ascii?Q?5IFNDPvQL8A/n4VShnmpkyQgItCcKTv22qvYSxutWDzvCZguOjublwX4H2xe?=
 =?us-ascii?Q?yRZWPUMcZHLiuS4BogXrwx1H80fv89lFKqVXAd2gGYAoPTXVBDecQM247jeg?=
 =?us-ascii?Q?yAw9mJreCyaoemz+Tm5fyPQ9vXINGMVEZpwuGqTOMqofFeEE6cTRdFb7zOuY?=
 =?us-ascii?Q?A10AcgXgkGFohHZORx1ElppqyeRLhagWIgdF9kXpjeap0muuijuHVcAI6AYN?=
 =?us-ascii?Q?2UMvy2yI6ACsJ1GQHU4dGnPihTzBqw8KAhShBciA6y9BOMddsl3hySnPUb3u?=
 =?us-ascii?Q?xJcQs2ui6wSmTpwKAc+/LToPzK7WeoH27vEb+RHQyYnQZFqo03wjnwuBM7qQ?=
 =?us-ascii?Q?mbyh2S+5JRT5jHxL9SDgHbqd9xt1WGo+jgP/xctBJHQJXZIyte98tqQKU3Fz?=
 =?us-ascii?Q?SA14yiNjX48RNIXhFJ5e7hC88zNfrGethTxAF+rvyaRYl3XLPSKE76dTrGCc?=
 =?us-ascii?Q?kFXupbs2U9Faf4uCaDA2xRmn/hJV2Nc8KD+lLUZ4ZvTh2hDyrnmVq1eXnmSm?=
 =?us-ascii?Q?m8kvClBPwZAO88tC37iLrX6L0QIAjY/Ds5RdzCIro5pMXUYh1+nTJPIaewoA?=
 =?us-ascii?Q?Ooe+/Rx6yt7bRhubGhL+OUtefUydD5hYz4Ge1y/OmJbM/T6ITQTTnvgO5QJS?=
 =?us-ascii?Q?X4cfG36faNlBr+/IRB4xtSxy4YlMRISW/f9K8pIo8c7/DXI0DP41z+D8pVyS?=
 =?us-ascii?Q?VRje4qHZU7nQUtRX0fPJpXjjKDSeT1UX9b2qtIfyTWwMpBxG77h7wUDSo5vb?=
 =?us-ascii?Q?x29fbMGqK+h23QcJ5/i1smsLpuz+QgMVYuI6i176iMmN2F3qxGAv9FXpoY25?=
 =?us-ascii?Q?9R0ueCyej1LnHMgwd2P6cYaWE3/3sMv44tx4t4SuOsI04dDORnBIOQfPiqIC?=
 =?us-ascii?Q?Z1M9KNG5LhpUYw+RHbxiB71dcmtdv+PYGRAg/su1geYc8Atx2J1L9Hxt77YA?=
 =?us-ascii?Q?Fv/SvbOOtFiwLO6r5bz0LGGZ9oWTm2rUIo8rxGZTpLAQk2WfyOoXqlIKYahh?=
 =?us-ascii?Q?JVmwXUJo8cDpRUNZPdarnsbN9pnLJnshRfF2PPBEVe4Xi3xu61LqoI68bhLh?=
 =?us-ascii?Q?DVSskxJMIGTiFK1tS12okjpZESm1SYjj6pFBiAj52subnAnRLaf2hcdILhv/?=
 =?us-ascii?Q?MybBt5o2ZUJuv3H1q10Tlnegt93VS5ZmLUoQ0zVuucV9mbAFD73y6K167tKR?=
 =?us-ascii?Q?jFvt0LaKgpkifGSmKYOLrOH+f8Gz4RBIsmcfOmzvnLwvTTTHAy9bwjCv/dGK?=
 =?us-ascii?Q?ilLkG3bVgTdzWQDtk6Qwylr5/GssxT7CnNsBX5nXnLbaAeTvCVs+EHgnzg/s?=
 =?us-ascii?Q?I0XpQHCfIgE6PpaRA4UOR6l/ihVBF97HXHhKKxnzFeW+S5d8o15Jw6n2kLVl?=
 =?us-ascii?Q?g65LD15evhkX1jkopnStJW0lxehFWETNUXml4w7E+/6ObTkOMi8LNf75MZqW?=
 =?us-ascii?Q?sAPedL7kmhnMGG3YWzG8kyDXIzRbIAagPQ8d0Gjwzn8TUmBiOrh9qPnpLJfR?=
 =?us-ascii?Q?5ZzqLwfU71rnJEC54ecEQ54NaUqy6cDU6r2V0mRqT1Zwk3mXWDuqE6Dzuwdf?=
 =?us-ascii?Q?YKuG7XK51CiWkpWdQNRumZKUHzkW7pdjH8RGxQEBa6hvL/8uiwma23fQVY8F?=
 =?us-ascii?Q?FZ4a0llIRPIaRicT20+FcJTc6aTM0oQAMcf7nC9VuguBGvLX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 440cec77-3eba-4bf1-5136-08df3e5fba6a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 12:48:18.2901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2qRYv9ctkcl4t+UpCIyxSPHafQXXRau8vKjLiif86JZOXvt1b12w82MpBOsb/TP0R3kftqku4Bj5+y2MXZJr6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6173

On Thu, Nov 05, 2026 at 02:26:40PM -0400, Chase Hiltz wrote:
> When a route cached in a nexthop exception (fnhe) is replaced or
> flushed, rt_bind_exception() and fnhe_flush_routes() call
> dst_dev_put() on it. That sets dst->dev to blackhole_netdev and
> dst->input/output to dst_discard*(), but other CPUs can still be
> using the route, e.g. as a noref dst taken from the fnhe under RCU.
> Packets that reach dst_input() or dst_output() after that are dropped.
> 
> If dst_dev_put() runs after a forwarded packet has entered ip_output(),
> ip_skb_dst_mtu() in __ip_finish_output() can return the MTU of
> blackhole_netdev (68), and ip_fragment() can then drop a DF packet and
> send ICMP_FRAG_NEEDED with mtu 68 to its source.
> 
> Commit 5018c59607a5 ("ipv4: fix race condition between route lookup and
> invalidation") fixed the same race in rt_cache_route() by putting the
> old route on the uncached list instead of calling dst_dev_put(). Do the
> same for routes retired from an fnhe. rt_flush_dev() still moves them
> to blackhole_netdev when their device is unregistered.
> 
> fnhe routes are also retired on fnhe expiry (ip_del_fnhe()) and
> eviction (fnhe_remove_oldest()). Those paths don't bump rt_genid, so
> without the obsolete marking ipv4_dst_check() could still accept the
> route. Keep marking retired routes DST_OBSOLETE_DEAD, as dst_dev_put()
> did, so that users that cached them, such as sockets, look up again.
> 
> In a netns reproducer that forwards IPv4 traffic over an ip6tnl device,
> with an fnhe for the destination, while the FIB keeps changing, this
> patch stops the mtu 68 ICMPs and the drops.
> 
> Fixes: 95c47f9cf5e0 ("ipv4: call dst_dev_put() properly")
> Reviewed-by: Eric Dumazet <edumazet@kernel.org>
> Assisted-by: Claude Opus 5.5 <noreply@anthropic.com>

The tag is deprecated since commit 1e035297ffda ("docs: remove
Assisted-by references"). Jakub / Paolo will probably strip it when
applying, so no need for v3 just for that.

> Signed-off-by: Chase Hiltz <me@chasehil.tz>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
