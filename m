Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012017.outbound.protection.outlook.com [52.101.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E1A64
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 15:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784733559; cv=fail; b=hzyGkMCEQOCJtuAujPk5mDX9sXyJDzLgXAgkLt3yS9ci114RxC1i3FsCfXiiG0tPE56o7JckfGo8R5qFKQQIzDZlN6EilwTkST5+RDZaYlOcib4tNgwcHz8kanQ5NW842H8BrNtJk2nIin5ywVUeN2hx5BY3rGkkFHiBQSX/KsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784733559; c=relaxed/simple;
	bh=8wPHQp74OifCMEYJ/ZZCQRfUADFmqOGjm3rO4cLWl/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dfGQqHX8LO+FDD+XdvQCz9hq2a7FqKXjjkuoqIxzqemnR4dodtbVzEsDXYXPJNIWoyAOL3x2w3GGSa16x7T+yD0XznIc6iaiEjkPrjGGz72yQHZiFUq/WJ3lNxgdqjIlWsz9dxHnKZuMprSvzbKp7VQe4x2EAaSHm3hrplbY+1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hufrVRqR; arc=fail smtp.client-ip=52.101.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hufrVRqR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I5wd3QcsgEF9SbWXG1j0jEhheRrUmCBy3Xzpje9asJKKmdozC7h7mF59uvw2A3qfni3FklTN6g+D90nS/+pH5UxcL3g28B9pvFsWmswtQugqMJZF3eNHDNeJ8z0mFm+oPTCZkPjrxTKS6leRJRLI4cNii8i21oB73oubm9xR/6g/3SkztJR7Di9mVNz3m8rN8Ue/j6vDvSer/SqjnbrvhFmZNezpiq+qjPcDH7ygys6KmtiRIh+q5fkaq4YgBg1WlY9+wHZAGAKo8G36EiyO5K9XE6fnANjx8RKu9MT3HGa56KWXnRkxMyklgaY8wFuT4fJXsUSjv38oretQLOVacQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0JQz4i/1hKPPuoOuSmaMLEHJ9L6A3u7tO57uSCgDfxA=;
 b=sKEHaUuNA/U/GKcLtzn5hVrtzD73vTNZZ6bDUYEfyvg0XAhso8UC527Rp9P8lsktYUHdJeFJEcvxrq6MyU1a2h4mskOXKi1Jx4B/mGBEQ6JGeJ+ejch1ePEp/Czurz4XZL5hC4HIKBRdDUOr3acEe6m5e9Irrx+2nUv5wpF27IfGaxVEEvFLDVLa9o3MWw9aqAjbsJ+ABU3/huZGP50qrAyc+lj2PZTg9bxBgzxjmBQomxOcPWFDyVpqVeWC4lITBsgNLUAUUettDic7b2Kyqj4QC2J3GUTklShBix4pLY3zyOZa5xmUnM6E6/WBWG1OfApC808Hpmis5XF/m5zwnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0JQz4i/1hKPPuoOuSmaMLEHJ9L6A3u7tO57uSCgDfxA=;
 b=hufrVRqRFCG4BtzZ8vKwE8ATfRTD9RLYKURw6r4rgHzNni4jNIBHXNRK3VBe3GNkttYcheEtxXJUaCpzmQmDTWulpeDPErZHXxQF+iujUTd9DyGwGUUY9w7h4dlKLIMCBAvcinuF+4xVjpreUZHHkEdrS5njR+dudTRmkY2W+8sTUkIlWfR0w0LaV7PuGs/zf5kiREUU4hP4IuQJyBvpPi7QA82XmgLmzwCXx5+wEnrj2jKqLTB0SZKkJSvJcXuSBxoEuH//IU0FQoNrG7B07Uf1YbsDrosUd8RRyfkLfWdlE2noJBZjDiuHwaB1+RWss26PO1vPhZtMtzys6uCZkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by PH0PR12MB7861.namprd12.prod.outlook.com (2603:10b6:510:26e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 15:19:13 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 15:19:13 +0000
Date: Wed, 22 Jul 2026 18:19:04 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Jack Ma <jack4it@gmail.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH iproute2-next] ip nexthop: support fdb destination port
Message-ID: <20260722151904.GA3022830@shredder>
References: <20260722-b4-vxlan-fdb-port-iproute2-v1-1-45199b1ee240@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722-b4-vxlan-fdb-port-iproute2-v1-1-45199b1ee240@gmail.com>
X-ClientProxiedBy: FR4P281CA0058.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::8) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|PH0PR12MB7861:EE_
X-MS-Office365-Filtering-Correlation-Id: 4293f642-4d5b-44ed-fff0-08dee804965d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|11063799006|56012099006|6133799003|10067099003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	6SrmiR13QlfVV9smN7W4FYgYAtnI9NbXLfO43w4sm1ScY8vBkE3siihPI7oO18Wbv/7nlLvrZivzhxQtnSywEGXax+wcx0tf4YajiEnS9Dq+1udjfor23llOfHPs3tOyKCEpRRsSuUauQ20j++5B9ulv98vag1VOwuN3QSH+hY4CTg6IiUsg+jbSKwKdh0EKyx9UTpw+5ExrmBQ7k6K1zA/uJABnzBbk+BZWejKmFX2pmlUQ6O9BoeD22MJltlyj9mKzkSTJPGc+SsUGf7miRNu4TRNp66THUtV/iOqX4rV363ZCqcO4s3/9E/nn3jltbOSBEBB8Jcgr6U5vxJr7MKJcuQfSvz3+9ZGqd1kJh7lqR0QThrojDuzaFbBhvId6QD6exoSP7fXyw2Dq77GF8OZBlweh8mpGr/lXewDq9KtP4DZqtN+fJhm41U6qlce3Iy923sSfKqYt8eOqhYfEIPwSed68i496LTFByQ6IYQ1F7EhDdwHKXAyXT6p1FiOlmvgFhyejf/wejAmEEYnNyyfcKUaPOm2oscjEcG1eTFskatdKbSDPBQtQxIIIogRRdIpetsmZG9W3ApNUeNvMKw/4ei/sLURzkJO0WFeJJkdXzXfFLt79f2jHa+LQWrK9IAlWu/nv3IFuJyErJbcnjBv2xABgdbZjFFFApZJyEe0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(11063799006)(56012099006)(6133799003)(10067099003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yhcf1Ehrpxv/SUB5WvVx2mEhzNWDxoPEb80n9dd1NBS7t+eHGHJzwINILfqv?=
 =?us-ascii?Q?ObMs0sCVU0cQGjlufMeZJ9jOoOS6G4OSRHqh20wfaEXzQXFa3fo8/JKafwyw?=
 =?us-ascii?Q?bQb0TVzTsGEkl6vEvLDZEN7bBPj1b+0G8LmL/cutaegVaSnSSx9EOe6aU0m6?=
 =?us-ascii?Q?ohHyW/SUJMMDFzw6kmbS7PLSs0l868Afm9A//372ijRlc/Uios/vbNivBA5J?=
 =?us-ascii?Q?uqqWZPnOWQQexLVW5AbcyS8odWQg/JvhN03dRp7fD57xHNy3W5CNGeKR5Qua?=
 =?us-ascii?Q?M+VKI8j9dnRBADTeVRjwIjheI6u+NffnuBuyEksfD+ZgvuhtdC0Z3rua83Xw?=
 =?us-ascii?Q?HvxUtmcq6dp4OjbrOk3Ya254I/sK106y0bz2x8uG0PEdNXafWkhL8OeuzApn?=
 =?us-ascii?Q?FA+3miHxSRYJy21C5/8FAOHr24srNoBGQ3fAJ/+E+7zDAxviyIUZprI/USYU?=
 =?us-ascii?Q?84AJzGKDsno8S9Tt94emJwHonGKmGMsf0U+HD0+g1DuLrmx7CHf0r9z8QcIg?=
 =?us-ascii?Q?uK+d+RZs1HkHr9yJ69zPoHk5rpADi+1Rif6NQmjmqkpl5a66DnfGT6YtWQ+B?=
 =?us-ascii?Q?pjrDPJdUrqZmd8qiKgEFy+OHZt6N2/OXT8Zyf5JXx8Yt0jGENthpRZTuR5wl?=
 =?us-ascii?Q?uETA/FmJClxWY0neaoadvZwMMoQm7mwN8Zezco+SfdCMnJ/YSUFDlbiDVql3?=
 =?us-ascii?Q?Yvt52pF7X5xIABS58HjX5ipTadUCGv4rfqv0ukCUvyIOPw1fmaRRwgwhlgfS?=
 =?us-ascii?Q?spylGnoXSlVipU2B+SKHvj3eLJvQwHgwG/3dHkcKtcvU2i2NvVM2Qg5vCAI2?=
 =?us-ascii?Q?A+wMb1rb9x8vrXBgtC/BzIs+20AOUCdNiezwowtyEhXFDMs/sfQRl9tyGgG2?=
 =?us-ascii?Q?BAob5ZL5GPLHxrwBKCgsV70V8wq2D7XBs56qSwpc1sphb5JwV9jAEBi2kinF?=
 =?us-ascii?Q?Fe5bns1x5b9zFeLQeNINEB5+v236slVS2bUSDSEbDa0PIE30nM+/FKyunYsu?=
 =?us-ascii?Q?PTgxY1C2ZqEnANLhKNkx+WSK3VVt5Tt81zXz3+Aol93D59IH5wmdyQD5NNN9?=
 =?us-ascii?Q?j1SxaQlERIHRtGquN2Ly54xFzkbQkzjcjRdLQWrBQ6ApBwuBfH4pf8hTup3Y?=
 =?us-ascii?Q?KiO9IyeDmqM8Z2zkQN9qJI85TofszZMGvRRkbOXXkufqJ/kzmyHcKjEZc8aV?=
 =?us-ascii?Q?hiV9gTTgeG0999N5ReUhCyAUtTXvj/Z0gGN22iWtEiFh95erBNGVdqVXtduL?=
 =?us-ascii?Q?2o3eD6ZCr0UUN+abw8qn4p+vWqmgucC4qRuQYNFtUqj/DliUAmJDHRJZfGxL?=
 =?us-ascii?Q?xCYkROcuNZfixPZHTUgf68cyEAsiT8YnowZKLM7/4DOLI++0STouMJiZqVcU?=
 =?us-ascii?Q?7OmoP3IRuA+Aqq0AcdOWCccgaP6taOdy+nBOhCp2zzzJcAYhZUSDTmYHOOBT?=
 =?us-ascii?Q?muJsEN2kADZV97zO+u1pLzWlRV67cP7OJa08ySVuARp86tZGbufJIO/LZcor?=
 =?us-ascii?Q?q8vCPAyIe74mgqfzOtSZLk4zihl2xzhU0ctVPT5QN/XbRk0ZXbAwd4ReRdUG?=
 =?us-ascii?Q?nd4my8RlEykoqjlu41QHJUBv5rxe6s2ZozQFmqx+hwCLqlju2Ff5jdNFzBPC?=
 =?us-ascii?Q?w21Y8690QM4WDmYV4Zr0AwWg9Sg/CpnZUTNcfxLP6OPVNJn666iNmQnNUP9/?=
 =?us-ascii?Q?qznAwCJ6rj5RBZes6HXFJuzcgxwFLEZRlXq1NQeE/Ge7KksA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4293f642-4d5b-44ed-fff0-08dee804965d
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 15:19:13.5941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nseWy6lMG/dnTiHDcXkd0yNp0QWSzBMk2Uw3S8c/J4qh/3ZsGVcrbA43EupPOa5WSYS9s4lITL9kYDRLf4WFOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7861

On Wed, Jul 22, 2026 at 03:21:33AM +0000, Jack Ma wrote:
> The kernel gained NHA_FDB_PORT, an optional per-nexthop UDP destination
> port for fdb nexthops.  VXLAN uses it to reach several receivers that
> share an underlay IP but listen on different ports, load-balancing a
> flow across (IP, port) legs of one nexthop group.
> 
> Add the matching uapi value and wire it into `ip nexthop`:
> 
>   ip nexthop add id 1 via 192.0.2.1 fdb port 4790
> 
> The port is parsed on add (sent as NHA_FDB_PORT, __be16, network order)
> and printed back on dump/get.

FWIW, I don't post iproute2 changes before the kernel changes are
accepted. I put a link in the kernel cover letter to the repo where I
have the iproute2 patches.

> 
> Signed-off-by: Jack Ma <jack4it@gmail.com>
> ---
> Kernel side (net-next), which adds NHA_FDB_PORT and is the reason for
> this change:
> 
>   [PATCH net-next v3 0/3] net: nexthop: per-nexthop UDP dst port for fdb
>   (VXLAN) nexthops
>   https://lore.kernel.org/netdev/20260721-b4-vxlan-fdb-port-v3-0-9aa0a543a78a@gmail.com/
> ---
>  include/uapi/linux/nexthop.h |  2 ++

You need to perform this change in a separate patch. Example:

https://lore.kernel.org/netdev/20260320140847.1730633-2-justin.iurman@6wind.com/

>  ip/ipnexthop.c               | 16 +++++++++++++++-
>  ip/nh_common.h               |  1 +
>  3 files changed, 18 insertions(+), 1 deletion(-)

Missing update to the man page

> 
> diff --git a/include/uapi/linux/nexthop.h b/include/uapi/linux/nexthop.h
> index afbd064..e1e1a66 100644
> --- a/include/uapi/linux/nexthop.h
> +++ b/include/uapi/linux/nexthop.h
> @@ -83,6 +83,8 @@ enum {
>  	/* u32; read-only; whether any driver collects HW stats */
>  	NHA_HW_STATS_USED,
>  
> +	NHA_FDB_PORT,	/* be16; UDP dst port for an fdb nexthop (VXLAN) */
> +
>  	__NHA_MAX,
>  };
>  
> diff --git a/ip/ipnexthop.c b/ip/ipnexthop.c
> index 14b525a..4c33361 100644
> --- a/ip/ipnexthop.c
> +++ b/ip/ipnexthop.c
> @@ -52,7 +52,7 @@ static void usage(void)
>  		"SELECTOR := [ id ID ] [ dev DEV ] [ vrf NAME ] [ master DEV ]\n"
>  		"            [ groups ] [ fdb ]\n"
>  		"BUCKET_SELECTOR := SELECTOR | [ nhid ID ]\n"
> -		"NH := { blackhole | [ via ADDRESS ] [ dev DEV ] [ onlink ]\n"
> +		"NH := { blackhole | [ via ADDRESS ] [ dev DEV ] [ onlink ] [ fdb [ port PORT ] ]\n"

Assuming we go with "dst_port", you can drop "fdb". Only the kernel will
validate that "dst_port" is provided together with "fdb".

>  		"        [ encap ENCAPTYPE ENCAPHDR ] |\n"
>  		"        group GROUP [ fdb ] [ type TYPE [ TYPE_ARGS ] ] }\n"
>  		"GROUP := [ <id[,weight]>/<id[,weight]>/... ]\n"
> @@ -531,6 +531,8 @@ static int ipnh_parse_nhmsg(FILE *fp, const struct nhmsg *nhm, int len,
>  
>  	nhe->nh_blackhole = !!tb[NHA_BLACKHOLE];
>  	nhe->nh_fdb = !!tb[NHA_FDB];
> +	if (tb[NHA_FDB_PORT])
> +		nhe->nh_fdb_port = rta_getattr_be16(tb[NHA_FDB_PORT]);
>  
>  	nhe->nh_family = nhm->nh_family;
>  	nhe->nh_protocol = nhm->nh_protocol;
> @@ -595,6 +597,10 @@ static void __print_nexthop_entry(FILE *fp, const char *jsobj,
>  	if (nhe->nh_fdb)
>  		print_null(PRINT_ANY, "fdb", "fdb", NULL);
>  
> +	if (nhe->nh_fdb_port)
> +		print_uint(PRINT_ANY, "port", " port %u",

The convention here is "port %u ", not " port %u". I think you added it
like that because there's a missing space in "fdb" above. Fix it while
you are at it.

> +			   nhe->nh_fdb_port);
> +
>  	if ((show_details > 0 || show_stats) && nhe->nh_hw_stats_supported) {
>  		open_json_object("hw_stats");
>  		print_on_off(PRINT_ANY, "enabled", "hw_stats %s ",
