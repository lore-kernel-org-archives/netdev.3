Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011067.outbound.protection.outlook.com [40.107.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF28413230
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 12:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791377456; cv=fail; b=foGk7a112sn36wcc8fZVAZuiYGflxPw8Z4OpZ7Lja4f94ceof57fKgvHYXU7tmBdJLvJr2yBbRJjqIzJcBNalekOkIvjJq7W93TacZAVOQWQVZUd2qnHoxHiSqs3BLIRQf2NuDy8FsCKoAMoz1JnQeVnrGnqk93T62xY+kH3au4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791377456; c=relaxed/simple;
	bh=B38qgRF6ygLTOx3duYMW20LhPTwa36ZaaUTA7l4Gzgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=udPCTKGwPULefU/aJFSZXin8QxFaPVEeTZzcoAfLliKKXcX23CymSML5s0sCnNqy+vVu7lfrEj+4I17/ZHaRaZrtqOAOVQYay9382DQv6VMyfIMAvnwa9omfzew9esXzXcR7b47OzrUj/b453+9Xb2xNSF0OAABne0MNTKoPfpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a3SijVWD; arc=fail smtp.client-ip=40.107.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a3SijVWD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gHrr9GNURVDxq7UK/5bJnswmUFcA2GS4VtHMK9CdXAU6/j646qWj8zt7K6qcMmohGGTVY1t+VAEKOQWxmWBd5WEmpk1MB1ngzTha2E+LVBsAzC/Y/J5StTpEO/Ig1xE3nfXRjHqE0KMKwHPhpxUnHUH2UcKPAh0L6zz96YcSJf5nJK7EimneMAjFxNycZM5Z1gSqUW7U2AjETu5a6XVgOKKvulECtdFigYFg+wynXtXaZq3Gac4LubIh3ZQqiiXnnPwZTV+Km8emW9bTub7bRiYWSJ8N9m+p4cSyTQQrXFa+oO3hKuGyYv1ooMAul1F7xlDiNP1pjVb56as3fNuXtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B38qgRF6ygLTOx3duYMW20LhPTwa36ZaaUTA7l4Gzgk=;
 b=bGhQOJK0a/5Cubj0t5xTv4JaVPLHJxMGnmK1oaLDF5Z9lG0UeWh2/FWPUQuRlAYUrUbHnHXP/RK+NzLvxY2BPG1eKc7kKi/q1urP5lNKtzsF0jmb2EAsUbV3xxd7uXQUHs/SoBNCaEgyQaqPRmhs+5h0lA35Z0oFfNeGtgThZbCYxpPp7qgxUHBE+IGsAClXANdSZNylR1EppFBmhHSB3BUn8KTgD6qG+nl+GPA5CEr8BqOK/qQ/r/ZZ4sOKq9PbN9LfNWpcCG+g1Sbg2j7f3DT1DGJNj7Bgfb6W3mbxdzRQNBxcvK/Yss6vYn2lRNNIQywdidar6wRcnDRhLYZNWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B38qgRF6ygLTOx3duYMW20LhPTwa36ZaaUTA7l4Gzgk=;
 b=a3SijVWDBg0Mc8tBKDcwyeZiwr5nuvgndpOUVFF8RxKv8Eq2AwmkdCOqVlCYiL7ppka4RtXthj9u04xBFeKzB/rkgj/jIj+8V08Xc1iZFErcly+xZmvrLdzMQw8O3PSfzCkJWkYXI5l2uNDLg1L7bTK97/MEiJ84/QkLZPbmttOAWacJWdmgq1XnhcbfCv7IMusiZA7HWabjc6Pw6jwQpqvQVAd4WIqdcTSNHHRXSFyjNvYLH7Wrcm3G5qo07o56yQ7yHhPWBsIFbHInQw6NGnwd8wS9Pn0a9VbcveeSxGEsMhhEjq/MZZhmhJutbSxjQoR3lCzV0FNfi666MnyIpw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by SA1PR12MB8945.namprd12.prod.outlook.com (2603:10b6:806:375::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 12:50:44 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0451.026; Wed, 7 Oct 2026
 12:50:44 +0000
Date: Wed, 7 Oct 2026 15:50:35 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Ferenc Fejes <ferenc@fejes.dev>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@kernel.org, dsahern@kernel.org,
	horms@kernel.org, petrm@nvidia.com, rostedt@goodmis.org,
	daniel@iogearbox.net
Subject: Re: [PATCH net-next 0/3] Report netns cookie in FIB lookup
 tracepoints
Message-ID: <20261007125035.GA1047569@shredder>
References: <20261006155454.853588-1-idosch@nvidia.com>
 <364f670e60754319fab25302b2b49e3269ec49da.camel@fejes.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <364f670e60754319fab25302b2b49e3269ec49da.camel@fejes.dev>
X-ClientProxiedBy: FR4P281CA0076.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::20) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|SA1PR12MB8945:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ea4dd93-3b35-4be4-bcfc-08df24719a00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|22082099003|18002099003|10067099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	xLjUjOYdO6DGIereF4BEl7lKeDb7Q5N+XONZfg3olTA+wT1nLr6/RVmSAAUCBA3gGdFyua/+zkz4bmwk7wBPu0Gc7ILy3RPc5/uJjf4GcRTrfwGGJ598ZDDq263u6wDnN87F5BF2ObLpZ4e5cS9VGlmaa5ysRklYSewSkMWmA7wZOzjhuRAdCof6lAm0g7NKQXrDGrHFlfP0+VlMrr+a4i10WMyKsS7pN/0liztslOYHEch8ZRmqvDR4ZrXq8sPddpftpMsp3K7m4+BRIJT/xPQ4T6D4QZnJEBhPVLu8uAhHGUNrN27yjIS8iJZrs7Pji+3AD1p2PYwjxtCZHq00d99k5/Ep8qx6FI1e8hRbVAIifRgfDQAhnU+qB8qJmySCYYGufIDf4RRlSFFZwkQCqqeRFCBUowigkyWBHy1tYw2JN+JFa10TfCsDBx/NZmGG7s1ES21wsRuIlpJHwQhNWknhkMiefyQto7/uFJaA6sdxwjHN0i/4xwCnwpcQ+igAW7lYcJK0ktRlGnZYmRFQTg2wqHJ8H7bz7eeC8qX8HYp+UyRE0p8Ld49z7UIAR6egoOVDOvQZYmupQkyMMeT2fCBXIKor8ZJR5sgw2O1RC961td0adHfhAx0P3ie7xULSpCQXabBTJ0lh/EMmCmmXva70p6NS+kJ3iXXeG5mEiTA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(22082099003)(18002099003)(10067099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tuHvdKQWTRZfwQcih1DZLoVuJrLgQNttFpnWRvwfRwfCWqJ1v6PXDzHnk4yu?=
 =?us-ascii?Q?cEub3fVjwt5l9jh8mrBZ79y9E9QCg3/IQjLh7mpIgAdk1iZcejSYVMKL+CZf?=
 =?us-ascii?Q?L6er2nsICAQxOpOica0r1OZ8atfpcGzPOh2l1TNSX5d2MhHyKLfrM8QH1wHd?=
 =?us-ascii?Q?VSukiDpGBXchBcFuFiuj7NTAUcwpkPVKsxDEXgK68ksofLl1L/3lr6gkGHHm?=
 =?us-ascii?Q?ofuwXKChsl73vSpwxg3YvClot7/fassEMOU6FUwZPLganetlVOA0k2ck+2Vn?=
 =?us-ascii?Q?XYPG3gvMjPFfS8n+eA38iEeY4PvvccVfQ9i8P97BEyheapyR5ftoJ2I1XRBf?=
 =?us-ascii?Q?erJ3l9YZNHJB4mvJZuet1lW0thj4FtElgG/9BkxoO8DpAQgjTmdl0ETHbNoi?=
 =?us-ascii?Q?2p31ppUUn6V1F5VKV5pez2NuDFwwrKjHHlu0IzAUkrkUJSZScX6h1bindS4c?=
 =?us-ascii?Q?JjbKDZEyO7eZeaAKT/KZwUCChOZdFHH2VwcAOiyPB5Xf1x4zWa9CrB2Btiqz?=
 =?us-ascii?Q?heBTkv8Bas9kvNpCw10kwfqe+u5vKipRWksNH23mfCJE8kQP8rfMZir8ofMO?=
 =?us-ascii?Q?BzdU8FKRiXHCjfIcrGCxjd5COU+GChTv9yp+pbN6bknXZ9pLgQeu6AuwzlhK?=
 =?us-ascii?Q?1T4Q5/Zwv98Ei+/bxsz+VD7s3rk/Rmff2nAegJQcWmr4rLPAjpjnrk4fopkM?=
 =?us-ascii?Q?utgMp7cpKfKJBvYFc/pUrskrPol42KePjC8b+ux/toNVmYezpdPiQbeOLTzT?=
 =?us-ascii?Q?KLEFvKwpBvJKkgM6F57ySdNnNABIR7t5MBcuOpq2MVVQoCfOllwXeZBEK6BG?=
 =?us-ascii?Q?fGDu148WcTt8gBGwsDiNsQ1LvnlISJ5F2bBtNrPgK6Bd3JZCHBF5xtAAq8XW?=
 =?us-ascii?Q?VcRS92sVGRaUVMqQcn73KqxvRyPQIjAnL1emVPKLk9dTH5/S1Ga6f9/0JelF?=
 =?us-ascii?Q?CH23k4isrdB/aJlQ3ZcAkA1iN7ppsePlDwWei8Rrx2h07uRs3IawwXwaAe6h?=
 =?us-ascii?Q?O2KMGoULgPl3ZXCrB1xzdjbMq131HTtr5OU6vUcEUmURf8Dx5OwATv3bS8FU?=
 =?us-ascii?Q?pkw9pSpzRUoCBvwzcAIwQs4pGfx7ucLEDCeq/GfWlev2MqHkUGRw3wmDha/t?=
 =?us-ascii?Q?v5jWr6vVKcf0VeFtQTmaDSX7oIR/seRXoD8n4X5U6c58styYf+DSXNhBbwR0?=
 =?us-ascii?Q?+cVQrYyBrNzpHGJ96hNhH4qrxiPncF3nQfWqiB+WYttHBjRwieP9jnnNovqr?=
 =?us-ascii?Q?91Kn3RDOsQBFNtLf+Itq54jjyVgSZb0tMRDvR/sGy/5tMekLnz/vVFRBVm0r?=
 =?us-ascii?Q?7D2JNEzLRviyj+JZJFgk3fbjsfPaD2+R2H5d2SJX9ydRK+hQFPz39hr/cWEP?=
 =?us-ascii?Q?STJIzL83g2YAzGxbSvco2cn1KFBvEtZKH5JHzTmPxkvfzsqeuHz1nz0PjY8v?=
 =?us-ascii?Q?Nsr1qeeDd249lP0s1A28HeSC5pB1Syq+rPY9KKjwS0iBkAkkuLxjv1YaIzg7?=
 =?us-ascii?Q?P8lwEcxT/ZdMJhWi4cDzE3BuCM70Pa0ZTvzrs0xbhTYAZVXbNyTX4ouolPes?=
 =?us-ascii?Q?Y5dibEXqDy2UmgYMIdajDf3ZYNcb84LALdObj9+IOY1VIT1LweS5bgKla48o?=
 =?us-ascii?Q?5nUngByn8hZxh8+AyuU9TTW8Qndsx9hoAwwIa2tV7Z6XqfXIwZIs7Ps6Ab61?=
 =?us-ascii?Q?ujkqh4nkIS2+RiwnChJVhSpeAWQyq3HksDCnitRmvEjHKqY3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ea4dd93-3b35-4be4-bcfc-08df24719a00
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 12:50:44.5372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cBfLF8dI081so+m0eHrUJtH4W5B9GJ0KYbiV8bE5JSr8aRsb23w2FhuWzWcnkOJUc2/tNHRzPMYVanKWaZ1X1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8945

On Wed, Oct 07, 2026 at 02:34:51PM +0200, Ferenc Fejes wrote:
> I wonder if the parameter passing itself, e.g. the line
> +int fib_table_lookup(struct net *net, struct fib_table *tb, ...
> can be a standalone change. It would introduce no functional or user-
> facing changes and could therefore target the "net" tree, with the
> potential to be backported. Pure kfunc/kprobe-based eBPF tracers could
> benefit from that, with the downside of introducing an unused variable.
> I assume this would be a hard sell, to say the least :-)

Linus is asking maintainers to limit the rc pull requests to regression
/ security fixes, so it's unlikely that such a change would be routed
via the "net" tree.

> For the whole set:
> Reviewed-by: Ferenc Fejes <ferenc@fejes.dev>

Thanks!
