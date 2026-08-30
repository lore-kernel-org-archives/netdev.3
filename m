Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011029.outbound.protection.outlook.com [52.101.62.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E2727AC4D
	for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 15:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788104728; cv=fail; b=JkH97qczC3UyRqqRMsjPAek81MYMfwyA/Byp1d9//5wtrQxXAGQGcgxHH18TmrRdaNCE2pHf4siOksrQGXkW3TLdnRb/+lHedZpojB/X1I3uwdr27DpH38dEh8RZfoYouaITKvCfFNh9h/zTkewQqCEuCSUeSBIkH8s//JqAQPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788104728; c=relaxed/simple;
	bh=m7bWcgzE/ABk6uEYfqOK3jT1MM11EbTogAkCWbxKfhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=V729U9zzWvSKO8bm39+HXBOZ6K2/QhvOb0x2kUKidvWWiqu8qS45BeRsn8wb6vh1JHbs3vj34vCAc7/OZTEZE0bdP/C9/5YvMakEB6Y6Auhbm4nh2ojcL2WMSt2r86uVGC+dUYBX9zq/YLJChqotScWa8AUbcPOhdwZJ1qOSRhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=poYweQ32; arc=fail smtp.client-ip=52.101.62.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="poYweQ32"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mY+Eiv8mn1rgH4w4W/C46yHnbq4a7F8PiNlDNrvsW4Ll9VBtKBRdI/6EJcLDPXK0LAmgDGO0rjNrWjDqQsmqm/iQJaDHAR7mtrqve+HgQles3ipA7kHtnmsnQoYEP7IOq9oUcRwxez1UBY8uVin2rLgTzc4luTsvM/No3ANAjz/s1C8hBpBFI/lx/laoIj7h3LV24N92nKa6qjLzRvysD8ovdb850jG5wLwXfR9mUElZdsw41nXmfNCuM7y1SklsVlQ3jUtGBZwP+re+C6McUwVwLE39JKO1exS6uJzvE/iqOPabaT+DaQ8HIJhETh5WXgXnotJgCHR/SPoS/I8eWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0o72K5q3Ia+ZrxyLxkFkRgEOKQxNwh72fukt3nsEpVE=;
 b=BZtWhetHx2ILioFcxbeKlbSqsF5TDz7Qsgb3bxQ7DC1gA7AKlicVWPx255scxY9bdR5JV6NzHG+Ijj7ObsXEX9fZC2CN14cEbgdlnfQGT9qRoIK9p4u4xBp0B1cH9t1Bs2OqcsYYGUaQyaCjx928xWHT5clduKokCaEuiPpv4c/Cvr/bG1BLySVahb40oFJC+7vkSNc38Yzm/sS+k4aM//mYKAy4mnT5166B/KD7sJK2NtBvmB6PoPhWfVL4ewMrfdcWPe/yQMfdoMGV0m1poivV6daASYsGiUvh2Aw2CfAB+BEgg/b5OiN9pB1rQ1h2Cfavp4suYyT6dHpEsNUkuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0o72K5q3Ia+ZrxyLxkFkRgEOKQxNwh72fukt3nsEpVE=;
 b=poYweQ32NJQMqemtbcNgb3sRt1Ztt6T6ljcgl+qUimlLe1Oqx1fYwKn7ug2rXu29Yi6pjesraSQNx3PmWTYOnwHZ3cg/w/5t1BOih7rdCOVsbTAW75e9NesfpkURI4z7jTnwStHIh94MXVyj66FDmwjFKKKh0nlR/S9P9w6UdsfamccOw5v2cy6DdoT/JLAwEupZWpoO3ahaxjKo0mj4OCvfCbPSha+3pnCSnpUEYinbElDw3bZqen6ZTUE2QO4W7r+iosFcgV71jOEec0p5IHis9J6oRgHJw8XjhQjngcGlp3DYZHUqPCJyTJe5Powobbpf9V836vDtAUo1U0i7QQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by IA1PR12MB8223.namprd12.prod.outlook.com (2603:10b6:208:3f3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Sun, 30 Aug
 2026 15:45:23 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0360.008; Sun, 30 Aug 2026
 15:45:23 +0000
Date: Sun, 30 Aug 2026 18:45:14 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	Taehee Yoo <ap420073@gmail.com>
Subject: Re: [PATCH v2 net 4/5] ipv6: mcast: use rcu_assign_pointer() for
 __rcu list updates
Message-ID: <20260830154514.GD2974032@shredder>
References: <20260828084531.1826790-1-edumazet@google.com>
 <20260828084531.1826790-5-edumazet@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828084531.1826790-5-edumazet@google.com>
X-ClientProxiedBy: FR4P281CA0206.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::10) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|IA1PR12MB8223:EE_
X-MS-Office365-Filtering-Correlation-Id: e6377e52-d298-49ef-f37b-08df06adb476
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|56012099006|10067099003|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	JHASPHfEV7YVTd8jlMNol2nrFlqCrFr8onkBxkXq9udmZs7zwUqJBhEYri3fuagZsCOrmkGwdCvvyIchk4F1uDyAX+v9/f3wazZ9eCxf6mdgMLzLKJg0KTdZ+RUq1/2CP8tjFo5A0PIahIO9SIaX9UBZEGJyji8lYNdKaYXWqNNYLSSIoNazV1Th+jBYqkPMUanWNTTPjVKhH6hEeY+CS2P+rIgbmaKq5hBu+W6G748CaACFaI8YcT9/SDYIq3hP7EBRQXKKxZ+QpCbpq0bVY0Yi9TQSeIPy0en3JbHSnt/ptc0n2OizyI1j5NBzISfLLpYNixw2fFpXUsLKtgGGrZm0kjHO7sNOAquHMX4RLBiylH/3x/2qJ3Ke9I3G6e/FTIEyUzrAt5ijfvTCfFpiZ46yd9Lid6bb9XUSMA40OOowuKKCCoSDXu4UryO8gqhzQ0WDpxyKQjxuEYF55A6j+/EjuhG3uIdjYyZrvFFvnGLSll9rZCGbDKE8VOVPRFsuoVj4yVIz4Mt7neFCcvCiXOFwgFGFFCO7amJIn0pu79GmzwKo9Uz9AvGGlGJ5uhzIY6Ib+olAmFyoANMLLjHtNjuOsZCjxPOjwUgkS1BuuCgcha+/N4b+AzpSl/3dG+bq0AKoFGPyg+UuWoXaZyjZvzbTIXWGb2N1REPwyvbylV4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(56012099006)(10067099003)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a9lAvuPI5H2mZjgL0W2lao4C4mhukp1dNFM8jobO4F85aQHk9QK53M/iY9k/?=
 =?us-ascii?Q?/baPAtfMGewMoB5Sv0rAmWGETH0DePM/V2RIxaKpvGwIcziniWChF06nFals?=
 =?us-ascii?Q?+5hyNs4Xq61EIGrSIRYjqWoUr15hPyolDiFXRGCorpHcYbCiRvtF/qp1mIZY?=
 =?us-ascii?Q?gF9QcLO6DThVVtdmLDYysd7oRinxARkxd7cvTCvv8Zpia3Gn+Qx5QnNHoou4?=
 =?us-ascii?Q?ReREXSOA4eBeLukBR8JoplKQWml4pdz0Z5wgCoQzFPiGyJYStpkqeG0UQcNf?=
 =?us-ascii?Q?zSv04GcP+BBlk5ktQ75tOmpgJW5zKMhLA7QR4bNUbMinucQsEjzEceh1zj8e?=
 =?us-ascii?Q?1zc4DPEp+mNzHKZtg2ROFtA3tjItcV5AbVsQpk5WE1MI6+e/bsynyllnmEdQ?=
 =?us-ascii?Q?G2nnKQrLJ2hE+Lf4J42mU6e/POg4djG8Gk/TG6mPZHQAIQ7xTOl74trr6/FT?=
 =?us-ascii?Q?iCrnmLyQc/IKyR7+BUk3tXyfqItDuCuJD4yrDSp34zI2eMcn62WowZunTdqV?=
 =?us-ascii?Q?WkaU7W6GPUFY28Ky2dG9JRsiX5ZFZDQ3MgAYeMgUzHftHBKJHdajIh5Gj2/9?=
 =?us-ascii?Q?czcOmQFqy7hnaYlwB+LyVdqjT78Yhep8LOeyFZyZnSZFDuuKinDr/V9HOJWR?=
 =?us-ascii?Q?6zmSexCP5T8GWoVJuZvUxW3H7mj5squJgxarU23oJic2d31wK4qDvw3oNFR7?=
 =?us-ascii?Q?nKab/TAEKns2lQACIjYRciXgPAWhVCIjiLcwNOnAJB2C/a2Tig6PejAC6AOc?=
 =?us-ascii?Q?FPvhDkyskgmSohxk7BXY6uNK2TwNXSNHlNCHz7udfthYIYUDzlSQHrB4SDHd?=
 =?us-ascii?Q?B+V6Qjpwr1nDdT002Rn+1FSZzJt8qb4UXRiYtyN27fRsMUCWUE8ZWfgh0K56?=
 =?us-ascii?Q?aDxv69T7XhRLfF8mtdDr4ndAdCc6n+AL7A15ZfZ+6sX3r9rLi/U1qKyV8dbv?=
 =?us-ascii?Q?cyWREvGigb+RfaDzvLIvRQ2VMkIgtl0aCwEFXmeAKZysTZhHFwbK8PYy8MsI?=
 =?us-ascii?Q?E+yDP55hS/wMbGbHKHfrEKz9S+YT8AHJyAqtExDZLK740JhXvjLAw4LV2igc?=
 =?us-ascii?Q?PajqBLkQW5VwXBBWWfA4ptVosvdUTTnWptpzYWAlZhsQS9hyZcfSZotcaq3+?=
 =?us-ascii?Q?Xu42Okzw7Jo1O0/OcL4ry0YGPKk2drneBNEM7Wd3J6+MWNEuElbI7vOdRGbX?=
 =?us-ascii?Q?lleMoGNYNYF1dB9TK6j1WFsetYvt1JS3q5m+5bzviZZN01mSBLTw/XiSzDud?=
 =?us-ascii?Q?GxG0yFABdVDXdGS61r5b2vvIwH521Y2P7eXwVhAUTOf7Ox8RFX7RsGwnGgul?=
 =?us-ascii?Q?sl1kRV1ReDunTrgvdepYWBjfHnybjJlxXJDZZQU6feNCf/fkmgGVTxSwCwrk?=
 =?us-ascii?Q?RtLFVSL4UjtHkCFtCzXdXDtnA+OZuJH614f1mg6fstFKAG0+5vQm14rkdsKT?=
 =?us-ascii?Q?4IEuXtKTt3pvXG0Jhtdj+tj2hXWg5V+8Oejfgzxs5wXa/66CUukesQQ0RnxP?=
 =?us-ascii?Q?MBSOw3D52EpSGzjxg315ARZNWOVYcsQ4M6lP2x2LhAF91y0yacZA04yPLLc7?=
 =?us-ascii?Q?w4XC2NaHeoX1MUUQ5nPWD2z7+g9U3cRu+QUrXBUajBHKN9JTirVQ+icb1Hac?=
 =?us-ascii?Q?Va8lflsqd2OfmnqEE1HF2KiiCHnNNWMhHHqJn9YnqSaQHxg7mZnlBlNMGrrt?=
 =?us-ascii?Q?bQ9j9Kv87oqigYNDk6f7mBfPXX+UCZXZyrXgiWhe/Y+G90qH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6377e52-d298-49ef-f37b-08df06adb476
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2026 15:45:23.8646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lwobLDSrSBi0I82RRS/e4MCctg/XH/tz7yg3xj2OxnUQOD/VOBTaJfgL39Kwk53Rm6qpXE+Jx7oH2QU6tEu6Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8223

On Fri, Aug 28, 2026 at 08:45:30AM +0000, Eric Dumazet wrote:
> Several places in net/ipv6/mcast.c update RCU-protected lists
> (np->ipv6_mc_list, idev->mc_list, idev->mc_tomb) using direct pointer
> assignments instead of rcu_assign_pointer():
> 
> 1. In __ipv6_dev_mc_dec(), unlinking a group from idev->mc_list did:
>        *map = ma->next;
>    without rcu_assign_pointer() while concurrent readers traverse
>    idev->mc_list locklessly under rcu_read_lock().
> 2. In ipv6_sock_mc_drop() and __ipv6_sock_mc_close(), unlinking a group
>    from np->ipv6_mc_list directly assigned *lnk = mc_lst->next and
>    np->ipv6_mc_list = mc_lst->next without rcu_assign_pointer(), racing
>    with lockless readers in inet6_mc_check().
> 3. In __ipv6_sock_mc_join(), mc_lst->next was initialized to
>    np->ipv6_mc_list via raw assignment before publishing mc_lst.
> 4. In mld_del_delrec() and __ipv6_dev_mc_inc(), __rcu source pointers
>    passed into rcu_assign_pointer() lacked explicit dereference helpers.
> 
> Fix these by consistently using rcu_assign_pointer() along with
> mc_dereference() / sock_dereference().
> 
> Fixes: 456b61bca8ee ("ipv6: mcast: RCU conversion")
> Fixes: 88e2ca308094 ("mld: convert ifmcaddr6 to RCU")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Taehee Yoo <ap420073@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

[...]

> @@ -980,7 +985,7 @@ static int __ipv6_dev_mc_inc(struct net_device *dev,
>  		return -ENOMEM;
>  	}
>  
> -	rcu_assign_pointer(mc->next, idev->mc_list);
> +	rcu_assign_pointer(mc->next, mc_dereference(idev->mc_list, idev));
>  	rcu_assign_pointer(idev->mc_list, mc);
>  
>  	mld_del_delrec(idev, mc);

In case you need another version:

diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index aaba4c2aae23..bb1b8957967f 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -763,7 +763,7 @@ static void mld_add_delrec(struct inet6_dev *idev, struct ifmcaddr6 *im)
 			psf->sf_crcount = pmc->mca_crcount;
 	}
 
-	rcu_assign_pointer(pmc->next, idev->mc_tomb);
+	rcu_assign_pointer(pmc->next, mc_dereference(idev->mc_tomb, idev));
 	rcu_assign_pointer(idev->mc_tomb, pmc);
 }

