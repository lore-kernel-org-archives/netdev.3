Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.39
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793296723;
	b=UnH4tBvzRRegO77HQkyo1zQklMjYMxRVTGN9u1Ws6+kbLe06M2MwDrP1YgWwaAF0qzVJ
	 K5c1QLgRUyPtjRgySa3RnRaaVM9tHzia96VDe2ZNfozqGMve0AQWxFEbCUZBogqxv61KO
	 CozbCc+CBmoCUahOOh09wqrk0a6QJqYkMEz5r/4+GiYxX8PCay1uHIQ1N75Xt7f8k9JFz
	 0X332O/nqsIECPsV2+jfA00L7a9MgvsivOXjkYr+nxu/K59Unf4Q8GJW9hKmmvbx6fd/D
	 5zwls+g11nvbs2XuEVo6uUceaPbCinfAFPF4Wdt1Q9GmZyJv7wgJ38vJTr7uQa7kICg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793296723;
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
	bh=wuTjnffAK95byuq01VNYJx9Z5oknlYBKZlX7NWH7svE=;
	b=W10CVA9icX5J5wYgZBPJXFIx+sQ/LZR+rLlOAKMNX9nd0AEdHcNhCN0Miuy0b/rWeJcf
	 fNkP8rdeAcn5+ZSHAKIE2IVgyQhOL4FyF7Sr5cO5qw6fayRzO1N8h6sRK5hZXn7QiYTac
	 JWWOHReJXMqQIGbOlPozvs8qCoolCyt0faGHXbdhhmngzlY1PH9ball02f2jKJsibSfJT
	 KDVL5CAqBWz5nSyIKSZf9/Vz9QCpaz6V5E5XZUmB9dRpZDom/VRvVYIRFXdr8T1Idf8a/
	 KxdMDLHzUQd0AsSSkLn27L/tALBo4/jxhnWjU/B+cxS/vIbOTZrUT88p7SJ2JN4Hvow==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=t38AY86+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.39
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012039.outbound.protection.outlook.com [40.107.209.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF881606A31A;
	Thu, 29 Oct 2026 17:58:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF881606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=t38AY86+
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JfZ5zEvZEo9nS6nj48KusHfmBVmPKowa5HhnRezGAPjAJYh4qXLtyyTDllrYY2gaTZDzBwKRkZRNVCEqjAyUFY0i3/SiGghA3KjeOM+2qBQKUANu/WO2vwnJRipwQ1XMxzeMAmPqjC2IB8/P8t0ctqIEXu0+935deNyoUyzS3B6R+VHKCSsAIr9H9hrwE2tiHIz7U3rDh9P/KZ//yuWpbeC/QQSTu+R01HbzEU+DyIqzGHeAXn4496tUj/MOUTgzVVEYIPQHTaDI7c8sLzZDQNIkZrpn6ZYukWB5aYOrbJ1VTHZHjsBhjoRR2OfstN5i1W3q4/MXfc8N3AMGVH3Nkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wuTjnffAK95byuq01VNYJx9Z5oknlYBKZlX7NWH7svE=;
 b=uq0IfI1ASSiYoTjewhMI7lw3rwrMKNK4ma6ybrquxrLheBtZ6RmQB+rKNDAk1rmtIlPoD430m2BK50UBbUKL+p6GGmNlfh8cTQ7DuA7ZpWjmAQHk5VIP+jwFyqZRIVnh8CbyL+BaC8q/k5usUXLhUpLE59Mw117n3yF13D9iurqzPsuJKNnhAS/y/I9VX7NCJG5Hayd7sFZRe1XIRRKqLE4SbgS+KHl+UvX2/R5eD10Xz+Fp96twyLTahI4n8eAVidWzCxxkT8hy/pHkfckWh5M+0OvploxT6cniwzT3Rn6HYXoeN1RNncGaWbedwC7u8DktW0xQKkCugrm5opsVOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wuTjnffAK95byuq01VNYJx9Z5oknlYBKZlX7NWH7svE=;
 b=t38AY86+IPTxQ3UnrphdSzo98q8tB5p4+wz9O0RKqcsIUeGtGTPZdAg8uL4rKDSp2W1Tsp+IEpNm00kalkmhlOwaoEWJIrJc/hOLtKZC9sBFlyiQXkVtI5ZMgyC4oIXglgfTmtb4OEjpKMcS2HWhee8xUYkSUJx81N2Vz2ppC2cfQ9jGOUTq5cOTi5bn1yvlhDSpzsO9tnB7XA/ld033LthG8G9zKnll5q+JEs4sL1U75Sp2MNRZSaLStMyRAxgZK80aCYKd7Mt1nMhBGUzaxPsFagDjpXoeDbDknKhbMURsoICgdrU5vEIDOOdVpJ/gzaijVM8EbkM8XiiCWmtv5Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by DM4PR12MB9072.namprd12.prod.outlook.com (2603:10b6:8:be::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.22; Thu, 29 Oct 2026 17:58:37 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0569.008; Thu, 29 Oct 2026
 17:58:37 +0000
Date: Thu, 29 Oct 2026 19:58:27 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Yingjie Wang <1075151112@qq.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	dsahern@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
	rdunlap@infradead.org, linux-doc@vger.kernel.org,
	alexhenrie24@gmail.com
Subject: Re: [PATCH net v2] ipv6: bound temporary address regeneration advance
Message-ID: <20261029175827.GA1411453@shredder>
References: <tencent_F6E8C7CAC6D390C8E912EEE4FD9FE4333505@qq.com>
 <tencent_C2E4FE9B7C0A05615861782611715EAA9C0A@qq.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_C2E4FE9B7C0A05615861782611715EAA9C0A@qq.com>
X-ClientProxiedBy: FR4P281CA0172.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::19) To PH0PR12MB7957.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|DM4PR12MB9072:EE_
X-MS-Office365-Filtering-Correlation-Id: 6284c4c0-a5c1-44ca-9722-08df35e641dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|23010399003|376014|1800799024|6133799003|22082099003|18002099003|261026140227099003|261028144727099003|10067099003|4143699003|261022105027099003|261022075727099003|11063799006|261009223027099003|261021123027099003|56012099006|261021121427099003|261026121527099003|260925021311599003|260925022911599003|260925021911599003;
X-Microsoft-Antispam-Message-Info:
	cYUg2KJRqTMDmCCxHy784v7f44iW7K8zAfVSDo50wEJNzVb6M05ZqAedx/X+Q23lpSE4BZ0MHez9nodVnInEBrutme6siWsjG/0x3iWDOVdW7Vxn5mpxV2UtCL1fFTqHAtbkDlDhdEGOxwFVYymPKvTyHnLKwIX1t2/KGQHQIH5fFqyMOMLAurpJk6S4ZC1s/s1lRjLZWgg84+IBGnfVkd4UGWMJv1oN+iYFsoVVrCvakhD/gU3inKqhRLOGSn+PyHSqcyP15kdtHluUdg1F4qLfxYZz0WeFVpqZFaw3cYCZh52afl7NqABsMDvR84ToHweO9nhDJ08HpORA/kqGYenlJMjse3qZZe9DV2BqY8/oyssmn+lz0Yk2gWn09erX9b2tLsiTyhEMFBviNtJYj9lvVKEHDYacKMqCzfgZiXyzNeryskd38CjqRknaas7sLPdp2/4knLew+pvGAGjV/dL6DFczVsvN/sVESCfG+zBvx8WHf57fW8s4xqJkzoqrM6z1JIhItWGucqKGej5CMjSD6afZrbK2cNwUzHcKZn00KLjfvTU7fck7lD7PCwQGembP+FA2e5idZ+fet3LgbTLRAdh1L7er5utssRintBzIBUoUov7U7nh0SSe24RhYseJEYTOAViaS/w1uwRoq9XzI6KCpX5LfqIHiUElY4cY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(23010399003)(376014)(1800799024)(6133799003)(22082099003)(18002099003)(261026140227099003)(261028144727099003)(10067099003)(4143699003)(261022105027099003)(261022075727099003)(11063799006)(261009223027099003)(261021123027099003)(56012099006)(261021121427099003)(261026121527099003)(260925021311599003)(260925022911599003)(260925021911599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q8VqOxcO3vePJ41Vxs5HCz0BfiPQpmtEmBpUAgHy4ipf2+EKTFZY6J+IJaeZ?=
 =?us-ascii?Q?U639LyalutEss1FscarAaajtVOj6rfe1RuqMkw2EB8ur9pfDQWIPyGgCVa2o?=
 =?us-ascii?Q?V2o5y31lrQ7k9+pslAKtQyLy21HbQw6JxE96DwFDlDfeHPNjxgyO15Pq6lsu?=
 =?us-ascii?Q?bjwntQhG7kvj4e1p2XHNBqYHtYGZlf09q0uSnUh1/Rji5aOdwTQE8zwcZwrL?=
 =?us-ascii?Q?tAEcbzhkemkCYF84gB3vgOikxYUmYyMzOx1BtJkj24qNZR5Bby3B6veo0vO9?=
 =?us-ascii?Q?HHTaE3Vo+jXtfXSojdqb3Vfw16e1j4CbZkgQ5ZBpfDQSdqR3ig7Gxjcsq3EG?=
 =?us-ascii?Q?OleJThuP9tdgqq9e56FZmHYy0IPR3oII/wS5C8HDovCIt7B5r9lCPhBPG1SL?=
 =?us-ascii?Q?HtIpVI8vwkOJpFef+8hOdYVbuQJ7PB01+r1ghqd8YbiCopUiQ+C3s5jYFGK1?=
 =?us-ascii?Q?M+krILgkQe+GdNDhjDs7yP//f5+u7rECCuktwaHBa+PUqL1mIPuxmMeqGfYI?=
 =?us-ascii?Q?iDuZQ2ig6gd4MTrtbcdTcjc3IiByJ6Lo7yqaELZBpiTj5Gdoaoh4eS5fX++n?=
 =?us-ascii?Q?RGWvbe17p7C8bNbp0jxlfGfrMUceMBFohZxY1pwpIeKppLgLPzilMpscnCpF?=
 =?us-ascii?Q?GtbNIfNMQxWO6J+img9/1WLhhekN50O0GkAVdM/FncO0ALu0QnAf5JTEpdNl?=
 =?us-ascii?Q?BeEQWg6edGHyQ+ihVPTLWeh22QdNfeOUT4LTCf57lJ6RDoWYk+XOWlKc/A89?=
 =?us-ascii?Q?z8ZPzb8QhkhmhHGgqJSWYmm+yp9dmCZBkbn5oeb+Su4Nq+aZDKXF+vz8UMfZ?=
 =?us-ascii?Q?4jc+kGYhAzfVqqXCff0Rqy1b/2ooaRMhFLVwlCQYdSgITBPed0ym909SWpk/?=
 =?us-ascii?Q?Osxs0vgsTXtYA+/8pTW0KpWKWDF1s3QhhKPfhUN4qlDAO7LO4XHU5YF0x7dw?=
 =?us-ascii?Q?gA0yjVIiLoVbRyt8ZJbFxyholHoLhVCTXOlpxks/ECVwZgzgAaircglXX/jV?=
 =?us-ascii?Q?PUpLR9kv8kxvU2BuAweQoFX5W29pm6idovYiqD6BU+Qf2Lp98htFNzI+OPGa?=
 =?us-ascii?Q?IonIitNLvmykEkkK6bKXtIwd1wPzS1FJzI+iWO7yh3E07R9v180Ye1/MGy1s?=
 =?us-ascii?Q?Z9palqhjkoJku4GTkgMIvdpCzEtraoKXKYwlLiUeWV2GK4BCaddjVmC9kCr1?=
 =?us-ascii?Q?mATSrwOZiUUvYh5GRGZnzsbEjDKDfc59lROhnEvEyLKjQxrPf++rrOhlv/Ed?=
 =?us-ascii?Q?fE9lUIsBItlk1783+B8QJBOiuWmRzH3dWQjKtvnTwPGCgwON2Ko6M+2iKBJN?=
 =?us-ascii?Q?7Tdjxmwzgc1FfO1VbL0Jka2cSUGcKZpXaiepe9Db064MQvWp39/zzX4Fw1Ln?=
 =?us-ascii?Q?UK+IJhpO7fNX5JJVF1qbcoED+IiyR7d1SWDsdk8GibpB/2dxk/LO+FZaVSkQ?=
 =?us-ascii?Q?C/HoRd2JbKRnNZ0+QnKe+/UbpS8o5ZmJURXV8L5jioi+Gz8tIor9rgHd7hVH?=
 =?us-ascii?Q?l7c5a5qO+ZUQcXoeMMmqkKJ6OLnz9HQ0K+makqCGrAumfH2kyOOE3pg2MM9s?=
 =?us-ascii?Q?svDCObz9kGGqXQfbBq5II0ROZGeaufCBFTu+/tn8eKxIO+DK28ZxohI+kBcm?=
 =?us-ascii?Q?9DGIQaGlGkuf+RVN8VSnEUCNXJMsGB+/BVCIL7+/hYaTADZcFL6sY49VVtB4?=
 =?us-ascii?Q?wEtbY4gWhShjxGQi/Uayt/fqYoI++0xKxapC/Yj+VozH9fFp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6284c4c0-a5c1-44ca-9722-08df35e641dd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 17:58:37.4804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GnADlDOCIFCnh7/+SsyiAXs0hyxT82eEKvG7NHGnaugkn9QJzyMU7WHIUo2ZbVf1+ut/ycvncwhv7BuH0TIjrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9072

On Thu, Oct 29, 2026 at 11:26:27PM +0800, Yingjie Wang wrote:
> ipv6_get_regen_advance() combines regen_min_advance, regen_max_retry,
> dad_transmits and the neighbor retransmission time. The first three are
> signed sysctls, and the product is evaluated as int. Negative values or
> signed overflow can make the unsigned long result much larger than
> intended.
> 
> The retransmission time can also be supplied by an on-link Router
> Advertisement. On an x86-64 HZ=1000 host with regen_min_advance=2,
> regen_max_retry=3 and dad_transmits=1, an RA Retrans Timer of
> 1431654765 ms makes the old int product wrap to -3001. Division by HZ
> and addition of regen_min_advance then produce -1, which is returned as
> ULONG_MAX. This gives an on-link trigger on hosts that accept RAs and
> use temporary addresses without requiring a sysctl write.
> 
> When ipv6_create_tempaddr() clamps the preferred lifetime, it adds age
> and one to this advance and stores it in a u32. The sum can wrap or be
> truncated to a short preferred lifetime. addrconf_verify_rtnl() then
> finds the new address due for regeneration and restarts its scan after
> creating another one. The temporary-address path has had no
> max_addresses check since commit 4b08a8f1bd8c ("ipv6: remove
> max_addresses check from ipv6_create_tempaddr"). In a baseline namespace
> test, setting dad_transmits=-1 and adding a temporary-address template
> with mngtmpaddr produced 2859 loopback addresses in two seconds.
> 
> Reject negative values for all three sysctls with -EINVAL. Writes that
> used to succeed now fail validation; negative values have no useful
> meaning (negative regen_max_retry already disables temporary addresses
> on the first attempt). Keep zero valid. Use checked u64 arithmetic and
> div_u64() to calculate the advance, including values supplied by an RA,
> and cap it at U32_MAX. Compare the required preferred lifetime in u64
> before narrowing it to u32. Calculate the desync margin without an
> unsigned subtraction wrap on 32-bit builds. Clamp the effective maximum
> to that non-negative margin so a negative max_desync_factor cannot make
> the u32 comparison architecture-dependent.
> 
> Tested on x86-64 KASAN:
> - negative writes to the three sysctls were rejected without changing
>   their values, and zero remained valid;
> - normal temporary-address setup and a case with writable
>   max_desync_factor=-1 each produced three IPv6 addresses;
> - with HZ=1000 and a one-second retransmission time,
>   regen_min_advance=0, regen_max_retry=2147483647 and dad_transmits=1
>   caused the baseline kernel to reach 2847 loopback addresses after
>   two seconds; the fixed kernel left two.
> 
> Kernel selftests were not run.
> 
> An i386 defconfig with CONFIG_IPV6=y and HZ=1000 built addrconf.o with
> W=1; nm -u showed no __udivdi3 reference.
> 
> Fixes: f4bcbf360ac8 ("net: ipv6/addrconf: clamp preferred_lft to the minimum required")
> Signed-off-by: Yingjie Wang <1075151112@qq.com>
> ---
> Changes in v2:
> - Reorder the declarations for the netdev reverse-Christmas-tree convention.
> - Use an intermediate variable to make the max_desync_factor calculation
>   easier to read, as requested by Paolo Abeni.
> - Clamp the effective max_desync_factor to a non-negative range so the u32
>   comparison has the same result on 32-bit and 64-bit builds.
> - Document the RA-supplied Retrans Timer trigger raised in review.
> 
> Link: https://patchwork.kernel.org/project/netdevbpf/patch/tencent_F6E8C7CAC6D390C8E912EEE4FD9FE4333505@qq.com/
> 
>  Documentation/networking/ip-sysctl.rst |  3 ++
>  net/ipv6/addrconf.c                    | 53 ++++++++++++++++++--------
>  2 files changed, 41 insertions(+), 15 deletions(-)

This patch is very hard to understand.

My understanding is that ipv6_create_tempaddr() makes sure that it's not
creating a temporary address that requires immediate regeneration. It's
doing that by setting the preferred lifetime of such an address to
'regen_advance + age + 1', so that at least one second will pass before
a new temporary address needs to be generated.

The problem is that this expression can overflow to 0 or be truncated when
assigned to 'preferred_lft' if it's larger than U32_MAX, resulting in a
preferred lifetime that requires immediate regeneration.

Can't we solve it with the following diff?

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index c8c0dd04982d..d9d13e78bf13 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -1487,7 +1487,8 @@ static int ipv6_create_tempaddr(struct inet6_ifaddr *ifp, bool block)
 	age = (now - tmp_tstamp + ADDRCONF_TIMER_FUZZ_MINUS) / HZ;
 	if (cfg.preferred_lft <= regen_advance + age) {
 		cfg.preferred_lft = regen_advance + age + 1;
-		if (cfg.preferred_lft > cfg.valid_lft ||
+		if (cfg.preferred_lft <= regen_advance + age ||
+		    cfg.preferred_lft > cfg.valid_lft ||
 		    cfg.preferred_lft > if_public_preferred_lft) {
 			in6_ifa_put(ifp);
 			in6_dev_put(idev);

