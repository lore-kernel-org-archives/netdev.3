Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010045.outbound.protection.outlook.com [52.101.201.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81313E558A;
	Sun, 20 Sep 2026 10:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789900040; cv=fail; b=DgYwk0Bw6Joz+0r1I3zeFy11RZ9lAy37sWCeULkN14HzUpjL//B4LCsE8FzdGWxq3mO0lFpNmlehYaE+Bw976/BeTKcdAQd31i1m81X/9L76RhwYpE8jTbCIxpjUEjx4NIrASSCMbwGjpnVVYPGM8VTtaIsojCtGzKcbQSAQSsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789900040; c=relaxed/simple;
	bh=VxNyVdk8QTqbLjnrZO6AJsYFKq8EoHM+Axzbe8Ip/yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HYPbSDTTDMiyHq96t/YlbzHRWeGHuk1K8+Zk3LSpxov0EAjkFcnC0Ir9MIfPdfq3OqsnAEQggAyNzL0slo/IlcQw/ipK5mPWZR1CkUGw4xUx9M3pxNMvSGbyP16YI99Fiao1QBJQwmOQj0rJHPAs31fP4xwyIGg0JSxodY3+Rlc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O/yZN2Ou; arc=fail smtp.client-ip=52.101.201.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O/yZN2Ou"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fr11Xb+ERVgw75Qcu7L8HA2nTbvTYlq/RDIk1CdE5jkn+0YZQiJynU1s4kfMHRR61eexGwJhavuudl2QXZtgc9/UzvKAipvmeRL0jHMIpZZjC1Md1JEKr6NHWY51C5sf0cvirw+HTeunAq9BKZiU5elzfbWoS08RO8qssZI4s5QAebkTU6yXMRCpMXZF0fQjQWTmxgX0As24M3deTubV05RimmCIa4/Td9rHj6EUznH5y2+tZ/CuFUAQrWZ5cYtgyL4b10mtfabsguoB2f0NfNXmCz9odsOhXpk6gHSgQMJNL/fDDBwGYjrS+gOvDN/EoNlrv8QRnZa9d6EZxrMXAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l3oWYgZ9Zat7Z5w/veLmPuIYGfyRF012urYtkkw8aLw=;
 b=bl4S9Ss/gdAwW0k3wbtzXrg1Yb2GHR+RRqMtAs3rTvWpjH9eJbfKy3NfQdiwmpNPw7L2j9oJhhBwZmVsEq7gXFvt/I7MB2onmo95sRk2CnWzM73kHxB/StsaGW6w4zuFWDe5DCZfBRTdyrGwGa5sJNzHdGRD+omfgTo+xiUYmy9iTa1YxXrUOy43+2a+cZikBnPugDev6GTxxZqKCvfJLTXeVpdlWzcrTDLDUjSM5nvtUc6xSZ1OxPuo6ntK7vFwm1ton7WHJFqoqHVIQb0k0EMeX61nKWt60vujmSVjAhpulGXs8DhobVhI+VDo2KprMljQJmnln3mIrFv96sNL/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3oWYgZ9Zat7Z5w/veLmPuIYGfyRF012urYtkkw8aLw=;
 b=O/yZN2Ou6GYO1Gac6+/+3SglnfRaN5jm1FGhqq0PapTu9JAZdK40XeeMe6IEwDSjgMz0yXsczRWPRtwE7kRf/zCgE/KTAO3ubScSnRU4AsMxOkGTGayBNAUHWnEA9Qt1pRAvEUsS6QBGMWPjYjaB+s5JtNHUK2x/HvFOCX4sLGNdWLR8L46FwtI+EV0R8FiLsl3aHa9HWZFODZRBCVxg9a5VLD9wk3aaO024rIeEfNVezP3KjpQ4YTmwQtfKsxzVLUFNHjGAhtycCjhMn/mkNKoMYlr/iGidqmJRrxyVWqbAJZfgsyMOeHFSP1EeuSxxWJ4/RkqS8ZJpJ2yhN/WfWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by MN0PR12MB5713.namprd12.prod.outlook.com (2603:10b6:208:370::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.14; Sun, 20 Sep
 2026 10:27:11 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0406.007; Sun, 20 Sep 2026
 10:27:10 +0000
Date: Sun, 20 Sep 2026 13:26:59 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Xuanqiang Luo <xuanqiang.luo@linux.dev>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, tgraf@suug.ch, pshelar@nicira.com,
	linux-kernel@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: Re: [PATCH net v1] ip_gre: Reject enabling collect metadata through
 changelink
Message-ID: <20260920102659.GA1897785@shredder>
References: <20260917095016.71937-1-xuanqiang.luo@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917095016.71937-1-xuanqiang.luo@linux.dev>
X-ClientProxiedBy: FR0P281CA0012.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::17) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|MN0PR12MB5713:EE_
X-MS-Office365-Filtering-Correlation-Id: cc6dba3a-72e8-4e15-897f-08df1701bab3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|10067099003|11063799006|6133799003|5023799004|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	LSOfct1/1odarlStL4vBNb7FH309ayAM4QAKeKS/KVrUGeH4Baj7990Kn7gcocKL8APJ8S6Y6Wv9u6lfkFXkbWIz5pyUL9Y72LPX0nLINT32q6FeOWPxd5h6dqOb/dz6rnJReBUsRUzJq5Pv4PqKTLy/pSSYsk8hFjgJn/kbdb7ZrF8Tm3JI/qvsBx7njmL9d8b8zVS8VnGKcrsI+2gnDh4kUwYz2KcO6aWh6h5/OSXZYGIWkBLuarykhfRxWQZi3OOKrcI0B2rsJ2RsZCrvI5qDoKtOSwN/+93TUJvFgMWLqYVhJuuPem3i3JfirdqLo9+aSw0AQog34SabkJAN2PP4NfSuUbzXv8nicDOsVO79fjTo2qn9tcqPNEokilw/kQ+sRIIzKSIzjZdTJaUcqapTU9ionhQ2BYeRYNW60yQmZLE1E/Bv7wDNR3VwbFo0QS+ZG2JbEXAovUzcXs93tgyLfxeCERt1FGAfBPAs+o7cxEQio5bpBv39An86r+caaAf/yR4WLkLK1Ex3yGMY0dOY12zzU52+jsikfg1iDa11l/JbVHyuqw4rjK0/Yw86JSV8smiAyXR3yJ/FRqDhjPL0ZpRtMJdH71K/mw3hBWZGg8vjh45rxd26asoUVRqZj84B6i2JPd9s9q70836ljCG5MOHz98gKrY9wyBRl8ZM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(10067099003)(11063799006)(6133799003)(5023799004)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rQCbmv8wFinxF3S0m5ozu3RUjF+YwKBqFw6bIJVJVryQspbK82qD91zzdfju?=
 =?us-ascii?Q?tPolSy4HoyN6W+v7qV25mfs7blaX2f4Kmi3hFqIuh6Hj0kzHN/iK12EMvATs?=
 =?us-ascii?Q?QtLRTYEW9hIyh+WN4tkPyWWjRHFg1cerQ6pDQtMj+l30CAQlhbsr9+Cu9RH6?=
 =?us-ascii?Q?B8QWB4bK/yJn/kXvNVC+TVecYiAdqN9/a9hx+mTW7w3GblxXJ9au1jBSfl7U?=
 =?us-ascii?Q?18LEbLQFbdATH7QBPZFR6UyOHJBujBObelRJ1pOnwrunvsxwRv7EZbkcRkhV?=
 =?us-ascii?Q?vikuTY3p4jLqZvEb5Ox5RJQGwYi4be18F0p6xOca1jjkPlF3+cqqdnRz1Aah?=
 =?us-ascii?Q?5XqLuVrWKszhzoYfrFngl6PRjab6AWhI5q9YQCYKUaFkJaVR73xVLjyJm6GM?=
 =?us-ascii?Q?BWyTuP56ik00UWw0N9GrITm5gxyeZ2U8EzDi+O+FTAJ1+KpORqD7qvWAq6Er?=
 =?us-ascii?Q?bG6lkbrEJSnaPgQX2hVE1AiUcQ2hyj1gwjL9cDc/r/AYB14h/doNJpwcjebQ?=
 =?us-ascii?Q?tQsLjqmFM3VuDz/gxvMPvYQPWmlSy1IcMcz3davyX2bnafaO53CfOthgfUiw?=
 =?us-ascii?Q?WT1pK30h50SXOD0L6Y9ZQxhLQ+vWSrditn2QhUms59Skogu5yjIu0Wpz4rdW?=
 =?us-ascii?Q?u3ql+cYHoJRlVFVonhQe6kvV3M7Byex0ZPcwuiXj1siSftc+abojz9TOcwLG?=
 =?us-ascii?Q?px3kWKtJEzwASnu02ySRnjOVQbx0X/70E3inCZCxZmsHSgyCujbxknn01xiX?=
 =?us-ascii?Q?OF28gdMHmqKH8aSSSpd0sPVDxiCFCt/B3biUStCeds5i+4AFKmLzy/ukKYdE?=
 =?us-ascii?Q?7QG/2ty9U4pD84k+CwCI9TU5WsBlGYpu7gP5Xqoq4usdxbVefVaaVMyg1fBO?=
 =?us-ascii?Q?QBr4gA7W5g5+POeLkptZ2h7d+u8g8DvY9LiEuNu//6e9cedIa0XrGtfrjjSS?=
 =?us-ascii?Q?2fGkb1+td+l3u5qB8iQnicIVJdYN0mE+SDUMR3oYzmRiGEVvCgp30RUENBGO?=
 =?us-ascii?Q?rCKuvP6nvu55yKpxeKglMDvHm7nQJLiFH+9bl8oqj6AmmB6pcnOuJJ4jPK6U?=
 =?us-ascii?Q?7YqxA7M5S1045Bb7tX44u9o+S9+77fDpt9mtkTABXO817uhmfVmnWTroLsYn?=
 =?us-ascii?Q?H4ltffus16l5xn8TN3QnR5rfsBsRd79NA/uF+OobrGkonO4epNFTLC7htrg9?=
 =?us-ascii?Q?fm9Mrz5y+JshoM4FIrz3ODh/6isvILeEDaD8iMAcZBt16KTHUqHEN5DzuCSr?=
 =?us-ascii?Q?d8FFENf6KWTlXDUSNiJIAsN7zQTyQgM46g4q72aob/8MPzPpXrUMsynm4mRa?=
 =?us-ascii?Q?3kAWWMYRLD77ztxfzaFZywvKi0W2zw+1ueDCT3lJzUYzB14FkKyFeP060ybj?=
 =?us-ascii?Q?yJnsJp0VtYYHKtT20rm/LF+U9rvBY9jHq1QBeFKI1aCgzpR9ivMkyc/FuEU5?=
 =?us-ascii?Q?v1tGBETYeO8BZpthpaiy3NZMJoydFgew/kyNFMHXHu8fy1gerlFnEWkp840l?=
 =?us-ascii?Q?n9Un6F3jP7kLzRx1gx6Mo7c6tbLmV6+k35bX5JdJvgLCuyAiooPdROEU0qpw?=
 =?us-ascii?Q?CJEKU4nPopRHTZSdgACOZ1x+KfbP1558+gZ3RZ+axeo3Ce9y8IbtTw8USvLv?=
 =?us-ascii?Q?19LRxcoMDttR0on0uwOGiaf/F+jPcJXz0dP2ILRsgnfJMvd8FmZQn9VgDJhp?=
 =?us-ascii?Q?g+WMFE6Ik8u1TtCNkau4yfNGqro3xVnsoV4TPbvYapUyA1XOb1usgpq5Mnay?=
 =?us-ascii?Q?sHdpIa6Kkg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc6dba3a-72e8-4e15-897f-08df1701bab3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2026 10:27:10.8257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rzFpltQok4egT6yDIPQyGzdvjgAmxy7/cqClyvGGGBC1oZlGecDQxY4nUWr2EpsX8AlAPDbm3WyJkHwpqf8r4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5713

On Thu, Sep 17, 2026 at 05:50:16PM +0800, Xuanqiang Luo wrote:
> diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
> index 82309efd417e0..7b1b0f17f60b9 100644
> --- a/net/ipv4/ip_gre.c
> +++ b/net/ipv4/ip_gre.c
> @@ -1464,6 +1464,9 @@ static int ipgre_changelink(struct net_device *dev, struct nlattr *tb[],
>  	if (!rtnl_dev_link_net_capable(dev, t->net))
>  		return -EPERM;
>  
> +	if (data && data[IFLA_GRE_COLLECT_METADATA] && !t->collect_md)
> +		return -EOPNOTSUPP;
> +
>  	err = ipgre_newlink_encap_setup(dev, data);
>  	if (err)
>  		return err;
> @@ -1496,6 +1499,9 @@ static int erspan_changelink(struct net_device *dev, struct nlattr *tb[],
>  	if (!rtnl_dev_link_net_capable(dev, t->net))
>  		return -EPERM;
>  
> +	if (data && data[IFLA_GRE_COLLECT_METADATA] && !t->collect_md)
> +		return -EOPNOTSUPP;

Both functions have extack, so please add a rejection message to make it
clear to user space. Something like:

"Enabling collect_md on an existing device is not supported"

Also, I assume you audited other tunnels and confirmed that they don't
suffer from this problem?

> +
>  	err = ipgre_newlink_encap_setup(dev, data);
>  	if (err)
>  		return err;
> 
> base-commit: c9151088f1674fd29ff26a20f5fc687acf53a2f0
> -- 
> 2.43.0
