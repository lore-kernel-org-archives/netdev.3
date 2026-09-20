Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011053.outbound.protection.outlook.com [52.101.57.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780E11C8604;
	Sun, 20 Sep 2026 09:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789895320; cv=fail; b=M1vw4Mu6qVPeKU/9qzKdk1YSidoWy3OpAnMQ0H1eZ8BgRghO0Xk9DcMv9FEj/FS4TIoXzX/PBlsaRRM+ysRYnX/ohVHnPOyc8lxyFrI7N8BMM8V+3JDyZfZwM01Q+wAnGSjGwlhdeAKM4Vg2Sq7X5DBqf0BT20oV9Ryoyzk4p3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789895320; c=relaxed/simple;
	bh=unR8VnPsSbIkz18nlKWZ3FDWWppDPMx/n4OFTkH4nTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tITag/Kk+xZ50I6A4XSrWuzT3SlAySTRl2TXQFXvaZnzsMwP9FsSl+omMe81T+xWFt3zDV8YV/mwP1bEvxjNyzMNrplixll7lm/QST3c83hTnxnvQ9WzI+YEW0zj1Qt4XVBVBWhclQlZXcQlW9ZNquUWhvGKLonaeMbmGu34zvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r5F2a4OW; arc=fail smtp.client-ip=52.101.57.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r5F2a4OW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vQG9ZuaosmRnfaVzIzbb3KA9dSqixprZ5l/cc51uUGNJ0aE+z2pr1zDsr+24gHchiu6Td55t/V0kX6cD3jY9WJwDCnxaaedZYMkNCi39RbNbqDc3Nvzp4QymUWMtT2m2rV3Jvk95TVfoCKw9Xe8b9ZIfycW2Kmxt3LMlKhusK5hIPzz7aEzVe5teQlrI7qss+SItfPnnasqxeb2Xz5d2Z5OerbRC0j1AlPV0HtPNHMcRU+awFcljZ0HjrIwdKUenLFhSP3hh805sS1k7WnwPta/NcFba8miVUYGsRMfG7IbOcXjEAQhs03OHRO4BXurLlI9KZ3uSjfnbytjHDkjGEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cb3p4Do+elfXAORN18kYBJ15o0Jk7c0e4Qf6t31Mou4=;
 b=RaVZo2M3f7/K65fFqBJ/O3L5OX80CVFovwqfTsYxI41MSQC++IphPrld5FS5/OByIfpyxSLubZfndH/gJC5zXYoF1+vYVgkZXK0/tSlEK+lUGlMGnREiCwt12MSvUhICD2jbICI+l+ZZ+68p54v4pSWLD97Zn3UnN+E8EznKQBa1Nss9xxvzHihqbnXNb76eMyVtfh2k1pkMfB4OXI+ws7nhNmYasYew8em6w1WbZNxY/n+P/FGx0rIbuE6INWuMmC6Nqw6tfZO95FgplzHinhg93JrXOcKDJ/cLUawzTc6oAGaWl60nf8j9YMs857lY0l3AX5x6tLD5pg5S+ZQ41g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cb3p4Do+elfXAORN18kYBJ15o0Jk7c0e4Qf6t31Mou4=;
 b=r5F2a4OWfPFpwTdOMpwydGRoIowBa9khY1XWh4SQ56wtyw9u5x+7UHvETIyaZD32sIBtjFkecCHkwj4ccKqTqabk5nuLAFaxC3pSQuiSHxvTAEDrjhhSQwQZRbNlHccorWcQAFsL+gMaX99mDmyxCXAyn0I18fRN/0S9S9kcx6OCeicfBIvjMHX8cFrLTe66iwefePeF9SfYnBysDpwnWWEwpTQnD3Y4AiUp2ikZgRBWcONGWV4K5jAkG4EbsHBqv3QSqTjujdjXWwe5P/RjjxcYuBnWH/Wusby20ZtJpj8SO58/SsvhWgjyGRuiXoJfUBZIsHI2MAS+UlfqR3p9eQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by PH0PR12MB5645.namprd12.prod.outlook.com (2603:10b6:510:140::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.15; Sun, 20 Sep
 2026 09:08:33 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0406.007; Sun, 20 Sep 2026
 09:08:28 +0000
Date: Sun, 20 Sep 2026 12:08:18 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Gabriel Goller <g.goller@proxmox.com>
Cc: David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Roopa Prabhu <roopa@cumulusnetworks.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ipv4: fib: treat an unbuildable encapsulation as a
 nexthop mismatch
Message-ID: <20260920090818.GA1846216@shredder>
References: <20260918152836.1173368-1-g.goller@proxmox.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918152836.1173368-1-g.goller@proxmox.com>
X-ClientProxiedBy: FR2P281CA0014.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::24) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|PH0PR12MB5645:EE_
X-MS-Office365-Filtering-Correlation-Id: dca4991e-ebfe-42d3-2719-08df16f6bbe5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|18002099003|22082099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	HHwXpKU5iYUnGgIBJjbmlitCEe8x8rEPfomKyLUwMY+pLZmvsEunOOEINW0G0w403mMlWGWCr+6V9vdHWtWg/WUZaT6+RAfAkzKDnQny/QxZzEc6HKHuBssS8ArbAuwG0+CaCAQLwJ2+TrNgFmt1tbXtdL4EKn4E33yc8CPI6foF8Sb3TbsTt6Zb+AVRin+rrzWRuGa5sWUddYFv1YaU8JPSSf0OadEj8G402ddkKNgNGC73YhKPp+gcV1JtPl3NHrSXbYL8w58SrVy86M2PPddhHXrvF1qAIg89RiSHFy7BpO+t0Mq+tAKeNgo7QgDvf7TnoGvWThpz24K2EZTBam87IaHSMFz80mFBw+4JRhQl4JRM7wruNJt9ZVs4bTXH02uuWepZibK2yu6rnv333PleIEvYvfcO2CajPO3Izqh9IuisiHLdbWPfKSjt078F7RLCgtnVzeiULD4SD2C8/cAIav4UvlwOLbMACUfYgehDnHuN98JPcrYrm599nvzhHlaWi7r/OdwsQ1RWUuTQc6IChQxeHXfsZmXxqsKgaYrThqX8ph5RsmBgGFOMwOsPx1G2ekLWLOAtmS9m++wgdi6mjeNtwwVSYIza7BKylK+WDUm+URZ14eW5Syj2nKFhjpkuZHAILTn/V/8xZK0O+HlSF/xxiACPPKiAB55tPYw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l0rx0F18LewOtHW4RztEZkfyugZ/4i6htiNryQjITWbbvzODled9Cqnx4VKN?=
 =?us-ascii?Q?/eIo1ngj3bCd6TNM01tkqGsK8Nn9cioXhlKGsQz1PVH+mnpKD7UD3rWxY0W9?=
 =?us-ascii?Q?lsMW0ZVSmUw3YK96MhWhMPggFrYE4NXMavYzPVS/SWm9uL/RMqTwtCQ/ahJw?=
 =?us-ascii?Q?LxZ0giMPznT6lqg/hOdzNg8GTvFUqAZmN5C3IfNo4ipHBbxq5H055TwsaMSe?=
 =?us-ascii?Q?hGLcQKnzfK5VMb0Mscg364Gv1wub1vb1Et65Z55IJ14Ie9PK8yF5Pqp0pO79?=
 =?us-ascii?Q?PNY9tZhVSaj82dShH9HZGD8zoOZrDZ1huMnpaas5BnOtBweP/jddAwRJSJf4?=
 =?us-ascii?Q?UkV/F+uKecNrA3Gmxb6a638ULhNpSkCHFlHIr/AfpFAWCHPFF7pBSft1IDIR?=
 =?us-ascii?Q?J/sGjxyLxoWObJWq5prgrv00urKk8g3ZUqAfM6FBwiMEdoLu1UCohJ/Mvd2q?=
 =?us-ascii?Q?UmueNxe3TNe4KdKtGSQn4eZe7x8RxInG/XqdXWxea9c8yfp3UCcBgSUjlGyy?=
 =?us-ascii?Q?t6IDp6qIpjrtsm1dUMAoGncDyzPzv5QnfpsRRXdhlCUIkghwcg+b53Fx7f5t?=
 =?us-ascii?Q?NuCvhF6ZyFAcZA+Q/1jUTJig9UyrQekvOdMYieFhIl0dDLRphlJ8KjUWV5Nj?=
 =?us-ascii?Q?QOV28Evx8OVqA7V+IEGxhLgXtztWW0b13RM95AGHOynbNUgjbgVaGTbictcx?=
 =?us-ascii?Q?Q4zNogemGbMXxLcYIl4Q0cvfE2nItsUQ0of790iAd7swHbZcY0Izk5LwybvF?=
 =?us-ascii?Q?3Y0AHAtNlQBMRBzkehc/4y7ML/hF60XHfORcPwwlIA0gVxTF6+TYYBJOOb9x?=
 =?us-ascii?Q?0EnM4qHcIqF3obBs5xPak7YjTOTU5kneOAE2xjur28WeCdEfLpYM23YNvSYQ?=
 =?us-ascii?Q?ct5AKMK153h5Bd5DGmA6Tqj/LIIeeutzP3K5yFuWHFhO92az4dnPVEhdo6lp?=
 =?us-ascii?Q?6evn0hRYljIbWGCa6lsBtKT41ESK8FYw2xa7ps0SJ5mSkcLWzgPYxQcvN964?=
 =?us-ascii?Q?2CLFfkJ41eNE/mUI3latpUhyr69wPF4YhTe5btsFJU33SCtTbNN4JeosRLsz?=
 =?us-ascii?Q?l2fTA3KztK3kAR2HY92AYnac0ceNp7pPRVl6QSXenownpZth6nc1FRqoSi9h?=
 =?us-ascii?Q?HIptvBKWvM10lsZQglVcCAtIz8MjPosX648vd3vfaxhbbOG8y2+FIc81TNMv?=
 =?us-ascii?Q?3a0PAWk0AdA9uu/6kWzaVfo+XieypplZmC60SC0N3FD/IVRvkjfV1VJp3cBO?=
 =?us-ascii?Q?6LGaU/qf8p6kYYlVWeV7otar0stLKvgkSw5CvEIgjC3MB82oY4uPDH9DtAhy?=
 =?us-ascii?Q?Fu4s+KK87jZg/SRmD8VkfxdogeAUIsgdgnNuAb9juacmFEHvI7QujjxnhqQr?=
 =?us-ascii?Q?x740UR97Ac8weIGJGmnsvljdsrf/zJ9hE+kFogpiToi0c9pH/3hNPgKkkRNJ?=
 =?us-ascii?Q?Xg+QO0sL3spPA6/dFe9qWZGQTAl+NukaYC735NRPL/DAUZb2hBU5vxMXq6dC?=
 =?us-ascii?Q?+7a3el0wzkb8AlZvfu7JCfdAXd0JDefoDDKSWdzR7VYwpjllWffT6FHcfXep?=
 =?us-ascii?Q?a1GKbPbgEH74iee6E4PCpkQN0YzyI5nCNyeoo4u+/AZOX+noX84QJ+jkckwN?=
 =?us-ascii?Q?O6dDdpoGTv1IvzcMjPW8dHl0x0E0FXESG1sMMbeY7menB+J0OjrVUw4DiZKg?=
 =?us-ascii?Q?0GOF+VWZ6q5VLWezEGlHIhqc22JvvWuXvHhUBZlGfEcYXQGf0uo+SH1rZyoe?=
 =?us-ascii?Q?lJr+ZZ0+2A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dca4991e-ebfe-42d3-2719-08df16f6bbe5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2026 09:08:28.1513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fE70X+OqiGp0TfrxGriXM9S1qrPs6pqWpNL0cE6AkGM3hPakdpCY8H1EvfY58aQG/vTiECTqQKtVMgLhJ4Ks5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5645

On Fri, Sep 18, 2026 at 05:28:33PM +0200, Gabriel Goller wrote:
> fib_encap_match() builds the requested lwtunnel state and compares it
> against the nexthop of a candidate route. When lwtunnel_build_state()
> failed it left result at 0, which is interpreted as "the nexthop
> matches", so fib_nh_match() continues to compare only oif and gateway.
> 
> So if there comes along a RTM_DELROUTE which carries an encapsulation
> the kernel rejects, it could delete a different route with a different
> encapsulation.

Did you hit this in practice? Can you share details?

Note that the modern alternative is to install nexthop objects with
encapsulation and then associate these objects with routes.

> 
> Fixes: 571e722676fe ("ipv4: support for fib route lwtunnel encap attributes")
> Signed-off-by: Gabriel Goller <g.goller@proxmox.com>
> ---
>  net/ipv4/fib_semantics.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
> index 50e96f86ca59..951e48ae87da 100644
> --- a/net/ipv4/fib_semantics.c
> +++ b/net/ipv4/fib_semantics.c
> @@ -911,17 +911,17 @@ static int fib_encap_match(struct net *net, u16 encap_type,
>  			   struct netlink_ext_ack *extack)
>  {
>  	struct lwtunnel_state *lwtstate;
> -	int ret, result = 0;
> +	int result;
>  
>  	if (encap_type == LWTUNNEL_ENCAP_NONE)
>  		return 0;

This is also "unbuildable", but will match.

lwtunnel_build_state() returns an error in this case, so you can just
remove this check.

>  
> -	ret = lwtunnel_build_state(net, encap_type, encap, AF_INET,
> -				   cfg, &lwtstate, extack);
> -	if (!ret) {
> -		result = lwtunnel_cmp_encap(lwtstate, nh->fib_nh_lws);
> -		lwtstate_free(lwtstate);
> -	}
> +	if (lwtunnel_build_state(net, encap_type, encap, AF_INET, cfg,
> +				 &lwtstate, extack))
> +		return 1;
> +
> +	result = lwtunnel_cmp_encap(lwtstate, nh->fib_nh_lws);
> +	lwtstate_free(lwtstate);
>  
>  	return result;
>  }
> -- 
> 2.47.3
> 
> 
