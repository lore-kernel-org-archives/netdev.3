Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013002.outbound.protection.outlook.com [40.107.201.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B002B3BCD1A
	for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 15:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788104707; cv=fail; b=R53mEY939iG97fIcDAbUcs6xrDDlKl3JAf/LTHsfvNP10+PHa1UhmUv1EyqxCLlTnMYUeUSnRc9TBljJYsgWxi1wLp9e1ABCbuM5K5pWeqZoI3RUOYnhGU63lOGW5maDcJdIUo95FkrobiT847xXG57Kqfwp88KENnhYijXdwwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788104707; c=relaxed/simple;
	bh=I32I22y2bzeYxj/LsQ3Qy52vO+zepKMWxgk6P5d1jRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CO35FMV2VD2m/FD1cgPKj52U8bI3Bznha8bZfmsD9J/dUh5rIOIWMJxyzZH5+mFi3If+S999Tm2J3ovOZ/RSbV5pmXwKP3GyZfNHswrsk6JrlIunAqvVpJfKhzZKz/3oyJ9SsN0bFBBKuij6OP0IAkjDsAB2xK25JpaRyffZilY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QOVklIdm; arc=fail smtp.client-ip=40.107.201.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QOVklIdm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fPTbv1PZROHvypet67VinCLqjTDBczj55vtHXrd5YROlOmfTjZGeEEPH+Pz223BMx1Udvmwr2U1dlqWc//ADt28DN4cRWMvVqT/IdpJsxiRexneTcJwAovGvbVlYjGEsY/Iok0MFzD0PDhLNvfoehDVmQHJPcbppKJmY/ZVw79vnmv/J+I2XGM1eCx6lsgzy4tfrjXc1VwsXlv555zop84JiIMJUnDzr9T5DvrAe7y7kDgBgTBuB/gzGTunL0D16rEc2l09DJgOB4veIefymccDntXYBWeDeYmUekJ9s6aKbfm4tSFnngJze/0a5cstzqsH2MPqFCqsTlS+bVZi5mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s9wBtfhnvb7QAZpMOEaEYzttefjXGqdSOmbpYTobqs0=;
 b=bbVGiChoPzF6m8QPf5HLtfPPNkxHq5XouY5S1UI6MHPiu/D1DE5b1n4GJALuLqb28TfHgXSEzRihVjWNBjW1wAGar2VDm0IYQJd1242Pzo5Ca7VlRDOPY7yk0aX/S/rBO/MsvBu6mODcB7A4Y1tX3xMTN1xGMyKd8LYlQe33zMKaTCHVOVLkDt0mPvfBwEpNDqFLhFLJnOaxoNKTPfchlyMCe7fCoTFkzGgSVnm8ouXQ9onsY/p+wC6FrmS4kcTckt5jy5hRb42QWsTH9qhL7LG/BI4y5A6rMG0Ph8pD/s9P9zMzyuWYOHEGfkCFnhIdqPUSz6kPOZ5gtvL57jEgOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9wBtfhnvb7QAZpMOEaEYzttefjXGqdSOmbpYTobqs0=;
 b=QOVklIdmJNL1Ko4eoQwnz3cXvISsvPktVyD6AIYe0o6iMEbMIkh8MbpRKbeZuBUqF4BDE2FBhqaEpj8cOwxMGzpOWN6LIEeVvI+625YQ7uEXcdVAIMK3ohMs82jPeBKsid1y2vgGzPG2Gi7unk//K7Sb7oeuRfCcluuuA8gjKyrA+jx3h/NqCovg/JSA5AuoNf93aJtJpP3/RamHgob/6Wyi3ptzJoLaCboiSRDSqPXhALY2iYC6QatQclk+smKkoUzSxVj7tBXsMK6zLEOz3YIFXL3fcAzK8MBqxChCECsP5/T/Z6VcddOO9LpelqxwzhMXQTH1eJcT5kCXevKnSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by IA1PR12MB8223.namprd12.prod.outlook.com (2603:10b6:208:3f3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Sun, 30 Aug
 2026 15:45:02 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0360.008; Sun, 30 Aug 2026
 15:45:02 +0000
Date: Sun, 30 Aug 2026 18:44:53 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	Taehee Yoo <ap420073@gmail.com>
Subject: Re: [PATCH v2 net 3/5] ipv6: mcast: fix delay calculation in
 igmp6_join_group()
Message-ID: <20260830154453.GC2974032@shredder>
References: <20260828084531.1826790-1-edumazet@google.com>
 <20260828084531.1826790-4-edumazet@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828084531.1826790-4-edumazet@google.com>
X-ClientProxiedBy: FR3P281CA0053.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::6) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|IA1PR12MB8223:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dc17838-0acb-4e46-ec21-08df06ada7d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|56012099006|10067099003|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	+ft9SLU4dKpoaw01cPu1G3nz+R3N2sIYWPdRiAFivf+QD5694TbchjI8L5db4wgfj0D1fdUUJCcEMZyena0m0Mmkzj8QgHfpI0rf4nkV++WHOi5JNnZ6s7GvJJxUTg1jlY998s/W4FKxf4iYYrilKBNgom2LXO59yiOBigxKH8Pv1yHPDiskN0C9kFmh/EXfJfAju3c1RwSMxVwQBJiGg5dbaO6tC4w0a4lBOPeTccxurP8LHdzmjVkzZK0AVPR+Jx0BOAmHEtznzMj0xteZqDt3MxF9FVm6iSOoXATB3dXOPFWByeaW0VhC+YHm57D42SbOfLriRX0vjEcH7SGGw3j2WbX2CNKxoiJAkycGS4hetaBtIYF+TosTynWl1+I/E5QpRY7bQJwdMCe5BVxEZMoakj//YExnnuRaGq7zh2yG2Gbwx7DADYhPSaw5kf8ch+zCG8yiNXczTS4Dbk69QjdUC91u6375tOo/q/rFcvKffsZn3u6oylkfzH8H1i4G3iGRB25YaOkVHTyjEG5YXA3/NOWTVYiwEEDHyNZ89e6KWnspeimYhvm8XbfdZgMQDPR+UpEjaDkRvf06uFBAkyW41r2sQsTidNgnnP/EFfyPe0MYseqJAjE+nYnLRRb9YTKxZubmWF0/9xiknuRU2i5GzWDXtS+IWNDQdZlfLtA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(56012099006)(10067099003)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CMSfBkrQMUvf/TlW57WgEhR8fmjLrffebBPmXCtm2lMCo08KaoentUBp3BIE?=
 =?us-ascii?Q?2MetjzVOoUriWdDfP5GLq36DWGk+N4LkYGMmW2Mi0zTnVkP3DdFe1zQGibWu?=
 =?us-ascii?Q?somuEfC7OqxcHtJebeiit/NCo0Ds2mzt5kcJkVxVfx6ZstrFPwUYFQDRi3NB?=
 =?us-ascii?Q?yn4MrSw9aYiwZ+3Iwc9YjDxDTUPDsqBVOFOdW5CxXUn45r7k5VHTcQxng/OD?=
 =?us-ascii?Q?ttk7F9HJizW12u//wS2mcQVqE0NsF9DC+uPJ5ypKsFBeKIhCFxth/E4auyCa?=
 =?us-ascii?Q?PgaKakKNUGGTOcTrdWnsquF6nIw9GDlGk4I3A6FGFh+XTw/iS2PJue3JLC3k?=
 =?us-ascii?Q?ScesmOaL6K1wY9GCM+V7RO6UeBhZy6atji6JlnJ+nfIJ+ceQfDIM+Xnm6aOF?=
 =?us-ascii?Q?OOakUYRpDn33tfAouar/WT4d5bkc6w/2KAVAknE/ritxb/fvrXiGCbcY7QDn?=
 =?us-ascii?Q?WybXqSYbjCFGwQ46OGUhOXyXw/pmjupPtHgs5vpKi++iCq00R38kavIwOdyR?=
 =?us-ascii?Q?c++bdmPS2iLt3bxGmSzMNXDaHxmQbb78aIYawIKBtkqa85fIc3GL0qJjPXPE?=
 =?us-ascii?Q?FQVc/99pADkOeZif1jm2dZKOJyjezjjOHAeviFrzVt7rbJN12LFvn7Buyj89?=
 =?us-ascii?Q?HzY/4kHfNPxU+3WElUTtAAjKPZetcEnWO5adb5xVNCZmjPR0HS2hK21bcBcN?=
 =?us-ascii?Q?b7ANPLt2cYwDUlWNqocV3ksDRPOwpUF4Alqw2ubOW2pBpZBz0xY0JPbgnTWU?=
 =?us-ascii?Q?OlvBWIzu1ZanrNeJR5YsHMlbdkA5yF1NOHnJ4oivRtc0dDgkRTTL0LfGOHWF?=
 =?us-ascii?Q?1hOy1ohAFz/Dlp09mE7GFjzHGtiltz41vuD7dkAAHj5rNdAhlkD3WDh8tXG2?=
 =?us-ascii?Q?Z2mPZ0sMyq4ggH+NVqmf8pMnotUHJ+0pmhY0E0aEqFlqFxmlizU7l8iSkmGH?=
 =?us-ascii?Q?HUO5pfb58yQwBapjJeK6EM3dRadG/NUveHOj58XfpEoUPpxYdYgl56LjXyZE?=
 =?us-ascii?Q?smwNvL4+OA81aCDXtBTx+rjR+X9z1fY54v1QqRPwvk9Tik1xeNCSm8EnWY2G?=
 =?us-ascii?Q?HjWmnsDT1yYSXeWGnZaDC9xHe2gyNefs+ROtBhbF9tPxCXMRbEbLOtdzLbPD?=
 =?us-ascii?Q?WWbP543jklxqQSWI3Y1EjhCmOtEejOIDchflNqW9nW0RP9AFmq4mzuIe3uct?=
 =?us-ascii?Q?6BNeEmO9gRVgnSMIM1Oy1qsQ0OBYwoNZ/GViwscmH7pIhc5FfwBlXULJ5doc?=
 =?us-ascii?Q?CpErjVCQvXK1pPeIr2Iahg9GKlQ3QzvFTA6B75MmgY8lk+ACGwChGubaNQ3a?=
 =?us-ascii?Q?xm5JDc4Hx/rrOMnC2ym/CfD6WwpI45284sIgjGo48WT2FsMwdtE9wmBB2MPy?=
 =?us-ascii?Q?MWfHr7P8LZKqJKL0TUz892yTm+vrHNQoObcBu5Q+RdYALePE9d5U62zq1Lky?=
 =?us-ascii?Q?8kiqC1rhg8SsENdVCjQxe7Cun/v5BPjE1q1GoJw3Pqux5zRCQA3rhwqTmlGF?=
 =?us-ascii?Q?gOfso6lXTSzJw8iTp4bnLLTeuoxy8EMHHHvFV/elEjlSSLoPlsSei1UT5TfY?=
 =?us-ascii?Q?fA5dy0r8wKRkkI144/GgAMH2DEDaw1zAm4U+MfjHhfag8eqhPg2w6Jfgwg2V?=
 =?us-ascii?Q?NOS+B7MY5dcEv5/u9KoAwh6v6YQB9EwCP9mDBF3OgC4fjBNzl7SMZjgomL+j?=
 =?us-ascii?Q?Xb2v9CL4OGdDojAN7gPGxFGdRS3EDMjKSfc1LDbGFDIiUSKo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dc17838-0acb-4e46-ec21-08df06ada7d4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2026 15:45:02.7093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EaOSwwxL36UJNkqGINZnV3DDf949A9hZA6YpOmk0b97tYi+65naC4lAYUH97RTK/8jCDdQj9vxqiyg0LtUQEuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8223

On Fri, Aug 28, 2026 at 08:45:29AM +0000, Eric Dumazet wrote:
> When joining a multicast group, if a report work is already pending
> (e.g. scheduled by a query or a previous join), igmp6_join_group()
> cancels the delayed work and recalculates the delay:
> 
> 	if (cancel_delayed_work(&ma->mca_work)) {
> 		refcount_dec(&ma->mca_refcnt);
> 		delay = ma->mca_work.timer.expires - jiffies;
> 	}
> 
> Unlike igmp6_group_queried(), igmp6_join_group() did not check
> if delay >= interval. This leads to two issues:
> 
> 1. If the timer has already expired (timer.expires <= jiffies), the
>    stale expiry is reused by mod_delayed_work(), causing the second
>    unsolicited report to fire on the very next tick without a
>    randomized delay.
> 2. If the timer was originally armed by a query with a large
>    maximum response delay, delay could exceed
>    unsolicited_report_interval(ma->idev).
> 
> Fix this by initializing delay to unsolicited_report_interval(ma->idev)
> and re-randomizing it with get_random_u32_below(interval) when
> delay >= interval, mirroring the logic in igmp6_group_queried().
> 
> Fixes: 2d9a93b4902b ("mld: convert from timer to delayed work")

Looks like it was broken from the start:

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Taehee Yoo <ap420073@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
