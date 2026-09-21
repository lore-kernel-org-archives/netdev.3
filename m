Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010019.outbound.protection.outlook.com [52.101.46.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CE143785D
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 10:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789985428; cv=fail; b=AlarIfBRtgIwhfmSUEZ5q07mCYywToZ3RSodh+/BxZVggP0rxFObwnsJHyLUVfel8oVSIDm43tu6JXEQNfWyE3Hen8k6ZRsmjbVjMbKkw/Gq8KG67C7j0YY6v5tJlQY5Eo7XJ/EmeX3B9v1WA2fN0UygC7js8Q1R+Q2NM6KiuxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789985428; c=relaxed/simple;
	bh=fxlM/EYi+PRPF7ALdgHsma+NJD5wJ8F1FDR/n8EcrTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fekPpox3FbrjLqOst/5GHmx+gtsZwecvPl8VF5fGsyKqClB+6Nm70qlc9PilWuBkP5qqJc0fVAdAfC+nT0zHKkWN8zBhS9laVAbNLBviDOup6YYuhP91lQKcCyFJD3bAXeHjKMko6cStNSGT/rP/PaTCx3Hd/nu5zwBf9IwKP24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IzrqMymv; arc=fail smtp.client-ip=52.101.46.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IzrqMymv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c6sJDwSeVa+df8+tzEwW7ceiI6DRjIE2rqcprhEpDCYbiZIDyi6/LHopY/a9uUeAiuKpQso2oyO8849rETuilKvHdW27kKM1VozKXLdXjDy5x7AWFEjeihqf9eljB48Hxnj6CyU97gXAK4XCuD+GCgV/EG50cjLzf50q7JkiJ/HUM6x/YSD3i5EdlvoLB6j8k7O4w0dA+18C9RppqrAT55/0HQzO7+c+XzlQSAT2D6FUekaixiRIj3ED6s42QVSA938iwX25ENXJwwW1elzWRYnx3N/NBpOXsQjXGOHHX58h3ENLado+mI5xDBgZFZWmh2418oDXW/KEOo3CJkTJcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kYyuRqwTCxtB+GiY9ekJGeSa6QCIHkIW9Uhhofb8vkE=;
 b=ysHEil1245mIpIH1Cy7z+hoF8rSf6iRbucamSqoOJ5UGPXyVMc20fL+VacPNWwIvMk9CwBM0yiUMtDAF23IHdEgNUQGaHd5W07HHJMUUHMwaWwwBmRcW6GckJ8IrZ54jQ4Q2ZEzABQMbK49+Mz+YzXuDuek59qJISzES8sv5buW39aFQEQEfIC3xlPvhclFr3Fkp0oU5TnblqkGFcX1F9OY7CXxarWDa4QcDh4CtvgaftnKhRo1+97TKerLQccq0aTuFg5Q+JnRwLWH3WJ/+k9NtQTUi6y2Jrv0D0tujyj+HcQzlQzxrFfce105SWCLG2LVBoIBuyPxU9rgx5ZMhfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYyuRqwTCxtB+GiY9ekJGeSa6QCIHkIW9Uhhofb8vkE=;
 b=IzrqMymvlAPl0TIarLna1gLoqM0qxo3T0LDu5KJekVDP1HW9K0OBVkz2kLKj1joviT//loH9iM+pgc/af7wHh/95M8h6jkucchvaLELRvD3OWNpnrWHfF0siS6v0w4PiOBatySyr5tm+k31ps4Ekp4Lspr+jj/sydPbQdZO/zB8vhHkRKgdfO62SiQfaJXDqr996wvRCTL96FWYF0kwtRJlH4bJCL3jXcR16wz3fLl8Pm459aE6b7PugxCLE0VjEdEN4vR6ctyhTKBzNUX4uvqu32Kkv22qMQW9ZzVbj8jkXwpnJs8oneeAB04QX3FaAOIms0giaasLSxb9tn5Ii0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by LV1PR12MB999329.namprd12.prod.outlook.com (2603:10b6:408:3f8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 10:10:24 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 10:10:24 +0000
Date: Mon, 21 Sep 2026 13:09:56 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: netdev-bot+sashiko@kernel.org
Cc: kuniyu@google.com, dsahern@kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, marcharvey@google.com, kuni1840@gmail.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH v1 net] ipv6: Prevent rt6_insert_exception() for dying
 fib6_info.
Message-ID: <20260921100956.GA2108776@shredder>
References: <20260918082209.2853582-1-kuniyu@google.com>
 <178997904775.2160803.15157410527748919821@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <178997904775.2160803.15157410527748919821@kernel.org>
X-ClientProxiedBy: FR3P281CA0071.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::7) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|LV1PR12MB999329:EE_
X-MS-Office365-Filtering-Correlation-Id: d5c9f8fa-17d7-4235-b132-08df17c88d58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|11063799006|56012099006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	2mW2Z01IqmMf7cfHdtjKrizE5pxxMzrDhR6SEmth/oAo03sGWTQZvIAk7Yd/0rhRPkxAfBlIUNyQXr/roLLTJy+165mnrt/79WOV6Bf3f73AwCrIwrlgtLe285x/2eq+Xn2DbWpauJ0KigQ0sda7wU2EInnRjH+yfG8CD1zxQ5Wwo6xxqUYFzhH1G7QkPjQVqFQNTzNNdcD6XBn+XFKApMdXHdPhL55CpSQnbnDgujYb3Q6YBCgojYiRJIkvYmOu0xsZKcNKNIkqNZETQe9gzCLGpp5Yi6cSB9bOXzT28xYRCfFwR2OI6ckzcN/fUhTLx+U+3dML7SN9r4SU5PbXM2BYu/U0rxJuEItQLMIgM60Da3VlWpBx+UPO3Zvfu+eliQUrsI9+HJ5vZnVpZ94IXclFqZwX4cQs/A1fpubxx5gJIvM2cHZheDzkDIFyqxpy48xOAn9lmRutSV86wzoNIurKgjZ1GLXSKuDBUAnKDtpB9VXaOf74CwaG9F4I2deR05VhdFD+ots3hFQz92zYUu9Rq7rxQnBFTJLCyKT+3Vnrld0MSuz5BNl2HXDJq9p4vNbZLZG1p6b9yC1tBcFIUKTSv0LedvrjQbLh1/lD+OV/wBnkCcO9TqAmQxQEft0ami6AxmwUsY82UdoFRWzI8AgLu589mpAuUe0OJMBPy5M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(11063799006)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZEdiWUR4TUJhL1ZTYWlURUVHencwNDRDdVB1ZDQzelgzNVBCU0t3SDdZemI5?=
 =?utf-8?B?NTJFSnNkTG1BTWk1bWd3c2VLSTJMRTZrcS90cG9vL0FOelFnbVVLM09BWDZZ?=
 =?utf-8?B?WDdTRGU2N1Q1UmlNT0ZjWVRmTUxSQnRONlQrMzNzU1c3SEt3ei9nMTdYSVB6?=
 =?utf-8?B?VS94b29BKy9TMG5oUUh1bGRUWE5qcjBHdS9XeXBqdGtjR2lydEQ2MFVCdUlG?=
 =?utf-8?B?S20wZEI2MmdVc21lOUx6RC8wYW1LLzE0SjF3d1dPWk9zb2w2aGlWakd1NGo2?=
 =?utf-8?B?MEJpeHIwS0ZmN0lNa0JtYmdLeDhVZ1M1L1BlUFNCb2lCNGppSFV1dWhpcUNS?=
 =?utf-8?B?Myt4bExzWnh6NmJrTXgwbWx2bHVVM0tHbFhwaFFpcC84d29HQUVtcWt4Wnhk?=
 =?utf-8?B?NmxHR051blRQQ281bVhJL3NKeXBSdDF1Tmpsb0drakhwb1IxbDIvR2crZUtT?=
 =?utf-8?B?TkVYMU5LNDk0dms1MjYxREliZnE4RlU5U2hPSVk0eGdSWnZBZDl6Wi9WKzY4?=
 =?utf-8?B?Vk5ZRS9HeGF3QXJHa3RXb3RTcTA0K2ZlN1FVcDFrSmw5RDJEYzFiVUlSNExq?=
 =?utf-8?B?NEorMmUvT2xWTFgxOUFFYStzaE1nWjlIKzNEOGJROHp0KytPak5iTjVzQVQv?=
 =?utf-8?B?SUlEb3lVUUdBamR2QnpGZXNDd0V3K0Q0ekNibnFaSFI4ZlY0Yk90d0Vvbmdj?=
 =?utf-8?B?VVI1aFNVa1pHZGFCdHVhQzNoYWMydXZ4dGVtcC9mZ2NDYVpwMWhIYzJXMVZ2?=
 =?utf-8?B?VTVhUEg5c3NYMG54b2tYUWpHUFhna0pvcHZKZVJSWU82U1lva25HVlRuczhp?=
 =?utf-8?B?NmpRNStReHQvNkY1R25GYVM0dWRjckJ6Qy80S1pIM2dIRlExWXJIYU9uakdj?=
 =?utf-8?B?Wk50RHpETkJiTThLeGZ2ek1GR2poZDBxTWlmemZPQStNR1lncHRKU3lOS001?=
 =?utf-8?B?cTRMUHZMWEhBM2hkUDMwN3BKbWpSV2oycEUwWENJS1hHNkZGRDYwZzB6RThh?=
 =?utf-8?B?MFNZemtOc2QwQlJTbXdKckZWbGl3ODZZaWNnd2djU2k0dk9PWWtkekhGZmxj?=
 =?utf-8?B?MmN2ZjgyUk5EbFJlcFFuOTNJckR4MGhsRGlkMENyMk5ZTWI2ZTlOYnVaTnRC?=
 =?utf-8?B?K3lxb3NXR2VQcit4am8wVzExZEswdjlBTjNOdzh0dk0xV2lKdCtzUllpdXBo?=
 =?utf-8?B?b0dVTWt6WE1WYTl2UGFZUTV5cGNLUlk1a2NPbDlKNHB1SWk1RkcvM0xIVVlP?=
 =?utf-8?B?N2RRM0JtQnZHVW05bUlJZzd4T1lJT2dnbXBPRHRRU2ZZMWd4REpZWi9mRDRO?=
 =?utf-8?B?WHUvRDkrUnpRRVVYaXczNXRaZGRicjJXdUZUU2VCYjEzWko4Zy9uamQweVZu?=
 =?utf-8?B?V2syeGZSTUVrdERXZnZ6WHE4UlRySXQwK2pBMllEdVR1b1dKc3FiRFBINDI1?=
 =?utf-8?B?ZURORGp0d1B5MnR3RFJ0S3NxUEhwU2FrQWRlRUNXdmRPdGp2YWFlRzVqT09I?=
 =?utf-8?B?VjIxb3ZSemRTSlJydHlOcU1SbDlRU0tVVUFwU3grYnlqYnJ4VHVsdEJxQnZs?=
 =?utf-8?B?Qkx0WnZOU3BNdnlobjRIZUpnNTFob01UWFlueWU0QTFFNWxzU2J0c1Z0dnEx?=
 =?utf-8?B?RGRrUEJJRTdXYTV6amVUL2t3WUpRZlc4eVNiNVh2OFY2RWM0ZHNWM2JQWW9Q?=
 =?utf-8?B?SS9wSXc5U1ZTUzNSaGZzejA2aVRSVW1wVCtmODlCTVFaL2g2TCt2UFpqd3dE?=
 =?utf-8?B?NmUwM2E5VXJLU1d6OFVuUjFEbzdtV2FMRktseXRUYUhJNUxrUXBaWXJnNGxo?=
 =?utf-8?B?WW54RndQbis4UDBZNWhEWkZvd2lQSWZWbm10akIrUkVQWnk4U3RUNGxtTTA3?=
 =?utf-8?B?Y3BsOElTNExPak9ybG9FcDRUMHYrWmtRL3JBS05kMmxCSmhLNGtFT21aalJy?=
 =?utf-8?B?Q1NaZzhoTThOa0JZUDNGNVMxSHJXb1ZlSU9xTlY1UTlLN21aMERCZnQ5QlQ5?=
 =?utf-8?B?QW5ubFdxNHlubmlXbDlqeVB6Yll4cE03MG42RVpJbURDU1JLY2hCUXdCc0VX?=
 =?utf-8?B?Q2lCWmhieEdHK2JMRHhqSzNmY3lUVVBydXRwL1hMQ2JTT1RRTjVvL0RyYVho?=
 =?utf-8?B?blNuWFY1Sk4rUDMyQnJYSnVEdjBUTmsxSDNmRktmQnVFVm1qZ2NpZ0lDTEtF?=
 =?utf-8?B?OVAxelBPWUVHWWJFZSsycmgwOWd0TzVnSEZRSy9saStTcVFrNitNNTh1ZURi?=
 =?utf-8?B?TStUUGRiV3lINXBNb2ZWbSszVmJqODNCbFArRkdvaHRHeVp0RVhVTGZVcFR3?=
 =?utf-8?B?S3k2cTZ1ZHhtUHA2TXlFRlVvWE85WEtXOHlpWEhiQXNkQXJGemt0UT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5c9f8fa-17d7-4235-b132-08df17c88d58
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 10:10:24.3868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qDL2j/bHifEixKkw2i5UvLqo9eC5k5ZD1b0yy+u1pXb0CwIp3E8KjhHKH8Y8YoKmA1AUFv5XbQNco5Tbv8N9EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR12MB999329

On Mon, Sep 21, 2026 at 08:24:07AM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] The new guard in rt6_insert_exception()
>   (net/ipv6/route.c:1732) trusts f6i->fib6_destroying, but that bit is…
> 
> --
> 
> ipv6: Prevent rt6_insert_exception() for dying fib6_info.
> 
> This reorders fib6_purge_rt() so that fib6_drop_pcpu_from() runs before
> rt6_flush_exceptions(), and adds a f6i->fib6_destroying check in
> rt6_insert_exception() so a dying fib6_info can no longer gain a new
> exception route.  The goal is to stop the fib6_info<->exception reference
> cycle that stalls netdev unregistration.
> 
> > diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
> > index 9ea75703b38d..9ff761962b45 100644
> > --- a/net/ipv6/ip6_fib.c
> > +++ b/net/ipv6/ip6_fib.c
> > @@ -1043,8 +1043,8 @@ static void fib6_purge_rt(struct fib6_info *rt, struct fib6_node *fn,
> >  	struct fib6_table *table = rt->fib6_table;
> >  
> >  	/* Flush all cached dst in exception table */
> > -	rt6_flush_exceptions(rt);
> >  	fib6_drop_pcpu_from(rt);
> > +	rt6_flush_exceptions(rt);
> >  
> >  	if (rt->nh) {
> >  		spin_lock(&rt->nh->lock);
> > diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> > index 08bd68f1b5bb..884d9ab0d50d 100644
> > --- a/net/ipv6/route.c
> > +++ b/net/ipv6/route.c
> > @@ -1729,6 +1729,11 @@ static int rt6_insert_exception(struct rt6_info *nrt,
> >  
> >  	spin_lock_bh(&rt6_exception_lock);
> >  
> > +	if (f6i->fib6_destroying) {
> > +		err = -ENOENT;
> > +		goto out;
> > +	}
> > +
> 
> [Severity: Medium]
> Can this check observe fib6_destroying == 0 after fib6_purge_rt() has
> already set it?
> 
> fib6_destroying shares one u8 storage unit with three other bits in
> struct fib6_info:
> 
> include/net/ip6_fib.h:
> 	u8				should_flush:1,
> 					dst_nocount:1,
> 					dst_nopolicy:1,
> 					fib6_destroying:1,
> 					unused:4;
> 
> Adjacent bitfields are a single memory location, so every assignment to
> any of them is a non-atomic read-modify-write of the whole byte.
> 
> The setter in fib6_drop_pcpu_from() runs with only the table's tb6_lock
> held:
> 
> net/ipv6/ip6_fib.c:fib6_drop_pcpu_from() {
> 	f6i->fib6_destroying = 1;
> 	mb(); /* paired with the cmpxchg() in rt6_make_pcpu_route() */
> 	...
> }
> 
> One peer writer of the same byte is addrconf_disable_policy_idev(), which
> holds only rtnl_net_lock plus idev->lock and ifa->lock:
> 
> net/ipv6/addrconf.c:addrconf_disable_policy_idev() {
> 	...
> 			rcu_read_lock();
> 			ifa->rt->dst_nopolicy = val ? true : false;
> 	...
> }
> 
> Is there any lock common to both paths?  inet6_rtm_delroute() is
> registered with RTNL_FLAG_DOIT_UNLOCKED, and
> ip6_route_del()->__ip6_del_rt()->fib6_del()->fib6_purge_rt() takes only
> rcu_read_lock() and tb6_lock, so a write to
> net.ipv6.conf.<dev>.disable_policy on a host route (ifa->rt) does not
> appear to be serialized against the deletion path.
> 
> If the disable_policy writer loaded the byte before fib6_destroying was
> set and stores its copy back afterwards, the bit is cleared again.  A
> third thread in ip6_rt_update_pmtu() or rt6_do_redirect() that still
> holds the pre-removal fib6_info would then read fib6_destroying == 0 here
> and insert an exception after the final rt6_flush_exceptions(), which
> recreates the fib6_info<->exception cycle and the
> 
> 	unregister_netdevice: waiting for gre6 to become free
> 
> stall described in the commit message.  The same lost update also lets
> rt6_make_pcpu_route() re-add per-CPU routes after
> __fib6_drop_pcpu_from() has run.

It's a pre-existing issue and not a problem introduced by this patch.
The likelihood of this happening is close to zero.

The current patch needs to be backported up to v5.3 and the issue being
flagged here is only visible since v6.16 (bd11ff421d36), so either
handle the issue in a follow-up or in patch 2/2 of v2.

> 
> Note the load here is a plain bitfield read with no READ_ONCE(), and the
> store side is a plain RMW, so this is also visible to KCSAN as a data
> race.  rt6_multipath_flush() writes should_flush under tb6_lock, so
> dst_nopolicy looks like the one unsynchronized peer.
> 
> Would it make sense to give this flag its own storage accessed with
> WRITE_ONCE()/READ_ONCE() (or to serialize all writers of the containing
> byte), and to document which lock protects it?
> 
> The comment above the store in fib6_drop_pcpu_from() still mentions only
> rt6_make_pcpu_route() and the cmpxchg() as the counterpart; could it also
> mention the new rt6_exception_lock reader added here?

I already mentioned this and it's minor.
