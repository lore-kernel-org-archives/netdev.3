Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.66
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793714735;
	b=jNHVpYKEYLvrzuBiSBUXJ/7esg3esdHI/xg3XaR0A7d7CXyGrC0upy9MgYfL2TG4/YLh
	 kOCpqJqJF5wu9OHge2eOiaL9u620DmgtvKaWLx7UDxs3I9XN11WaSc1SCnlmjyKBABop8
	 a2RPqj6+40ATdVw7jWtBZ1rMRWxurkKIK7I850NU+h5EX5mkMGlh8tdEp5+PuSSH9ngMc
	 1HikpiFeVRYW2wA+wXlaQk6/hmlShWRUN9rJ30kw+tvJhr26jCdWllEFfNasqv4oMVfCI
	 qgscdLd4rtav+ZOLdtgSTzKc2JH/x/TaHou3pWh8Z1j39LWYavzxtdwbvOFvP/ofdhA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793714735;
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
	bh=hXmY5iy7ZojuOzIyFWeSKZDe8fU8MTf7emc25/RZX0E=;
	b=IGGUlabZMX1DXKgeNJVCwr19AB4RWmUlVaMTkPWUk0jxlGeaznwE5NSNd6LlLSydWwwf
	 0u09e+XjC/YGHG80umC9bvDMT25nQPvTcVcy7a1DFWchuemg9yiHUSSoiO+bSQ7MiMkY9
	 h//HaqZHo9xwfNpFE33xgTBoCFa6Z2ujewwkNP95LqKbNqbmOrfZZMTIMywkxL5SJYh8a
	 cIFzA/HhzWwuWSWJeiN84do+efFsLbs/64o4LTeK6Bk1nIPdnhjaHfJ4zW7PhSoo9j5nv
	 Ky5O5TMLwAWv3jzOFOOYTOKauzAmbSGcg3VBpK37aZc1B0jxt+0XmI1vQbIg7g7J6hg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=TCD5uHTV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.66
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010066.outbound.protection.outlook.com [52.101.46.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFF4606D816
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 14:05:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AFF4606D816
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=TCD5uHTV
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EWBcMG3I4Pymf1zYKtl+sm/Q2fwMNdYD+l1DHJAq3hvuUVydRVdWK6r49kR4wJWGNIhgR+C03flBsrGPIPLh3imEAAcbXv/cFUFq9932mpxMhS/jNKtTSjTzl9+l0pQaI0ROjbvD6VWdlawzYzYpJdHBcp99kwm03taSzu1olsxClS+WdfWPlS+OrxXOf0rHPNhq+WogIVzsrlJVTyICrAtJE10z0ZyUbSwzND10hGK7sft07DQIv2fmRIqjbaar4xxvGqSm7GL8rCltmCUdd4bpDQYwj8VJ+AsmguE9WCHIiOs22gXNPYB8xXmJHJHdlWRFrNq5/n0p4BaYx8u8MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hXmY5iy7ZojuOzIyFWeSKZDe8fU8MTf7emc25/RZX0E=;
 b=Fd4+Zzw/BMcAENuTsaScwAD2eXed/zwzZhe82/2jiTfglaHunuXg1umnmBkUYlRxw69spL9SdiyHhn7aaEGlaeDpPbXyOtVR4bMrlxRzCBIZvW0TIg7pde7KCXLbQdk3TKIzinH3fjS5Tb9uzgXcTEBpdf9QVO9CFX/1MHOSBNDPKywgNJcMukE8TxubGbTApNnNQsLT0GLCdFPCP8xCxYE4bgIXOCAWgVjD7GVlUqoZBi22imcUwN6GyCle0xozBROhwKyS6Zxm58p9XIzlWPvvQKwWH35E0wWTHVPMkDre7LGDQlw3spN3sAjRIAdgcfeEByU8CowY2IY0mJnXEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXmY5iy7ZojuOzIyFWeSKZDe8fU8MTf7emc25/RZX0E=;
 b=TCD5uHTV5NSQ9muvKY/9mZnLu0pE/NYy0nJCNGzYNjFv+u0p5jRjjXYd8/N48p219e5OHQ2FCkKVg5brbP9srE8Q5Zt6DbZXMOLtd+D/6OsX0lysP9jZ+QqvT/83yw/yxhpDCKs/DDFNu6xDltWbfjmzMay8uOHsIHSIdC0Ei14xLwRDVKNp34d/LXCNybsYYl65MrP5gqJrIQe6Y+0oI+A0SyhVlpwFeidPpMo9neP/DNuGQeGQbAa9st6Rv22p+VBSQM8VQ1g9JhvojgVruDiv804SIPTV2Bqw+iqryr4mR03EJrBlU/vTM41lyimNFvRiSR9egVxBFU404TLQog==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by CH1PR12MB9718.namprd12.prod.outlook.com (2603:10b6:610:2b2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 14:05:31 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0569.008; Tue, 3 Nov 2026
 14:05:30 +0000
Date: Tue, 3 Nov 2026 16:05:20 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: David Ahern <dsahern@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jason Zhang <jdz@google.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v1 net 0/3] ip: Fix route leak and unregister_netdevice()
 stuck.
Message-ID: <20261103140520.GA1201112@shredder>
References: <20261101064418.2055158-1-kuniyu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261101064418.2055158-1-kuniyu@google.com>
X-ClientProxiedBy: TLZP290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::12) To PH0PR12MB7957.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|CH1PR12MB9718:EE_
X-MS-Office365-Filtering-Correlation-Id: 32b62275-3fd9-4afe-29ca-08df39b384d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|10067099003|18002099003|22082099003|261102123227099003|11063799006|261026140227099003|261026121527099003|261009223027099003|261028144727099003|261022105027099003|261021121427099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	2A/dw+jbl9NzneBqu8I0Z2aAf04lwjeatxawoN7VdAVpewfBXnW5G6YMKX4dQ2eoXPxrSkiE374YNNot8vJHeTV2V2Kt6t0YRQvFU+qyE4BpYlD/eOJrUBJZeKP9VDxFXrF6M+JCM0wXvZs2nxU2wOFblCCaU11KhvgTzRWlGSVA7BK0Un9rEOcoEYZl7MMXdTUHeKm+SqKf35x5kq4n/G7JqqhZhlCRKma747W151PjOSSB3SwT4YbHnOFvR0c98P5G6QHMYdF+ciXnhWKG73c3U7XZ2Rymmx20ck521GfqjZdMPymsETQIWANhF6f+15EZb6vjCPX31FfLC3QpzHzbmcgOy7CsoWr5WD0dT7AVCFSB0gxCtquPn681T7CA5ImbAqBT+zY73TH2n4vw9pwXoimfC8zwyncsI7dvb7R4SJpGr8HzRHLmuwM7YSpK1zQ50RK5h8sCpW52/MbPmXh46Qlq6ysRMZPYVz2f+q6B41z6chCpp3wXWHMxJdqz6SGaC9F5If5tPCtnNrvkw3+BO9NrVwt4QjUfG2rYnRgXlh1MsrO3wW7geoplgMEyUrOVei5WrFfOEWK+XE3ZArdQ0grNKokLpgpHiFV3bAvlcoVSTv+OigU50LX16ufxVPu0aGmR85AQd4phhT7/Qffb8ngCWLl9vBBQMoAKtHo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(10067099003)(18002099003)(22082099003)(261102123227099003)(11063799006)(261026140227099003)(261026121527099003)(261009223027099003)(261028144727099003)(261022105027099003)(261021121427099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8a9RZjgvrXGJIIf1awx+OmgYP4OYwL+n3EJNWZjqZNX35JuLOoi1FMW1aJPH?=
 =?us-ascii?Q?JRoZQvT8A2M3lf56g4l2n8j+5b4Ss/rIersCdHBLHWFDDWHH3XR0f7B8NH9/?=
 =?us-ascii?Q?HD2RYK+iFOrdS+cGiOOwgK56a4BN0XzFUcL2e+eQubGdVVbYElOI7fGuPNGl?=
 =?us-ascii?Q?QF9UB5vIFFO02iFUoUW1mHmFL7bgkVqFXa6isgC+3/QevQvtsKBTg/wpPUh4?=
 =?us-ascii?Q?93Z/H5P+tiIUMeUw41g+Zylb3mkvL0jAt54OSrL5AN3OjLG8AI8yoE5D2IVC?=
 =?us-ascii?Q?n11IYqtbFRwpfn0APksl1dlwJrNTgmvp+qvYIPL3qVSmI9ihSKf0/ZJRRZL9?=
 =?us-ascii?Q?Kr4tHJ0z4JlBHpDVVgMoY42Dw72fgq7C51b9mQtvVYmXHRlWQno/Xs/NGEuY?=
 =?us-ascii?Q?Bcmr72RPFwu8SvKiW2AewEFhk0PachEaIyqmp4wKutXO38yeSyeX9kizOqbk?=
 =?us-ascii?Q?giGNrCzScqV0mAQsXQy9TClc7XLWJddl52qjlnBgbtXJrIjl0A48cumAfCLF?=
 =?us-ascii?Q?H98mb7W8BapTOl+14tUTMS92s52rJIv3gUjau0p89iUF5HQ3cUHRx9DQvXGJ?=
 =?us-ascii?Q?AHgLe7RUmxYISIU3USPGwgzZTUjTOrG9MJfZ94UsCSGJhx0qS+DzMirqr4B6?=
 =?us-ascii?Q?uazls5EDnVhdoxC2qZu16G1Wi5wluWBQe8Gw0UDY05psEqMVzXP3XDfelvIJ?=
 =?us-ascii?Q?LJ+nUM/T5f3smWo8vkrkUj4FyD64gjp2ar3mGHJEp4unQmjStvTknT5+EArJ?=
 =?us-ascii?Q?bvFOe8NnMFp6sHfNIWfRWKprMjuv1WIgcaPM5gL93pYULwIMx8dDKUdJFZVZ?=
 =?us-ascii?Q?BlBfvbuOTSBGDhCDNisZLrIZ7k6I7lDRPXIJNqynxYctvwUQD1T09rzRnPev?=
 =?us-ascii?Q?vTLr4yc02iwYetDeRELXzKFvNXwXCqWYB7/c0fbAZfOrVscFC6vd9mhSDIAj?=
 =?us-ascii?Q?MGilXqWA2S5K5ajflUtnPZye2U5ikya0p8Bv4mnAmBrbiGGkh0P56Ue0lCbY?=
 =?us-ascii?Q?aFrsQAJTzYP9woWVOXL8l7M57pixnI47EI/CkKNgPJfIjzyKJ66pKayGNXN1?=
 =?us-ascii?Q?hES3YJ+MWEnpv/6CHiW7S3N8wqfbFhSrukJyA0JAynq6GxFRjljQHze3q3UK?=
 =?us-ascii?Q?EYRSLsBlS9wowKZb3x+Ds5gVD8+97tM8243h/PNsFAQqCPPMKkTBSvQsolNW?=
 =?us-ascii?Q?M+b2djbl2Bv5RarxtAFqXQIVaIfoocNQuYBs0eiEVzMPp1qOxIhJrQednaZj?=
 =?us-ascii?Q?3+e7+5YtQaeieNQcwOnrW0byg3jKseL2pgSiXWvfawPH+IElBTVqND2gdU3P?=
 =?us-ascii?Q?dMALGRs/zpMml/ZrTnmAjWL7hZ3JigWm1KCIJJLNCPm69QTg0RBBodV6NLaa?=
 =?us-ascii?Q?vTOrY6rw4VTYixQ5R+y7nUNegvol5sledjs88Cg8bkmBpelwkE/PD+bBBtZ9?=
 =?us-ascii?Q?ZO+gDPi3RnfEfdSle0eHMy+8Tx6PkEqumwAhewEYW9c69HUWrqo6Tfzh6k3W?=
 =?us-ascii?Q?EKq2c3DqXMruqEWMg/3F7vM9Wwjz0o4EpKIM/ECQCm8ecV/6pZeKHmHi89ZH?=
 =?us-ascii?Q?LAZ+1Z3HTDJEgNOaFUP5IkwXjnJ7iwRbZEiV4fDrHW5RWZZvEgnffyzS5kti?=
 =?us-ascii?Q?V61soDwsieJCqCXmhcpNu+iUQkCTbHTKOM5FiKAhJec7Bjg5d2xYwFtxJb3m?=
 =?us-ascii?Q?He5NYP99Ml8XxW1n3hkbuVuPYqSV14IBTBxEQzigJ8d4dKRe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32b62275-3fd9-4afe-29ca-08df39b384d8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 14:05:30.1540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +gVh6uBZwcYBsLUXOmvZjQcvistcWQMe0UzHWwBNLtxRg3txn8sGVyRMQqDPG12/If6KGLR/JmmoTA+qBAAsQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9718

On Sun, Nov 01, 2026 at 06:35:21AM +0000, Kuniyuki Iwashima wrote:
> Jason Zhang fed commit 0346ec2f080b ("ipv6: Prevent
> rt6_insert_exception() for dying fib6_info.") to LLM to
> find tricks to cause the same symptom:
> 
>   unregister_netdevice: waiting for gre6 to become free. Usage count = 4
>   ref_tracker: netdev@000000009652f190 has 1/3 users at
>        dst_alloc+0x14b/0x490
>        ip6_rt_cache_alloc+0x27b/0x670
>        __ip6_rt_update_pmtu+0x572/0x850
> 
> This series treats them.
> 
> 
> Kuniyuki Iwashima (3):
>   ipv6: Flush exception route while replacing nexthop.
>   ipv6: Flush rt->from in rt6_uncached_list_flush_dev().
>   ipv4: Call rt_add_uncached_list() if !do_cache in
>     ip_route_input_slow().

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
