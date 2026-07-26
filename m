Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010057.outbound.protection.outlook.com [52.101.61.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5711D514E
	for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 14:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785074777; cv=fail; b=HhLYBbcoTKSVxuCb6A+jmR9Kd4j5qiDURNH2V3PvApMCBssDL8kmaVT6lXfbvo95Gvm5FvRsDEq4rzScbQbH+NZI+A96Ui2dOnj6Uxo4aOPvY5yUASknEw2ACfzxNFEc+REY8pZPhcX4CZPsvw8Yx5RrYjOkJHSjmDXwoKg1Fa4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785074777; c=relaxed/simple;
	bh=yNoUHuomTDBNxAcgLJsuL/8Wc529Oa9SiXvBrjn46gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FLt/4f7xgV5A9cmOohnYIYHYVM29kK6Yffne/jNEVimOmxQxEm/XIpmSNPgdHB+dg7SDi3aC4C1HSj6H+KtMAOQTLgKmWE70neQ/280TjHsq45QK9OEka5ndD1F1Z3lBUA4EDreCFhwG3RLuxQ5iXs+QlmGkRnmqM6O+bZKL3l4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Lv4Cy4Bc; arc=fail smtp.client-ip=52.101.61.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Lv4Cy4Bc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NX+vokkMAXd7Y4CXZCm4n47WJ5qtUmnyqDmK7TMrP3bfOPPXEwpQ9jxFYSod1qnwCWH4NVVtp/zYe4ORYSG/gfgtrrdNxbkeedhw22EECxZLzH3VgZF0/E+pnTTG24lr5d41ofNimEWGxpkjZ1NMeWeLJ2LlZLk1BOdtunbRHw1Daty/w4XkxptD+o1aT4udvEAnLG3O26IGdJYKp031uRh3SWO5Li+bEDwNWN4jSL5ZjfeJU59y0c+f7MFooAPfcYrW21VkloiDpfdas5AU20hW/lSsbE7qqoHLmvEkHQLn/3/gXRABZfPoI6RIiIjkh77YeflDA3v+NFpnyDr9Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gfi7IpAPop3zAa2IG/GrhPB8A21CUUwDFJFfD15yQfM=;
 b=VrMU2dAAQzqeE2NVcHSNFJbkhWeH0gknb6zzWdTAdpAQpZuKrf80bK7kqcVwP69Pwv5cNtEQmNldoAEMno6vYOB4Rual2YyssrxWVRF18gYcwLqokBiX/N3qgSsk7Z0vFvEBJC60NLqxk0G6CFbkZGwGwzwmsWjl4FMVLxpg6FDX1GpIcd2UmYrh0PO17J1Kw6AEK10x9LPlogn84QwINygxK+eEgwZxlFWB8PBzcWLTzEeP1Tp3Fl7SJOwOWNzNY1QnTVMX3qDTiqG/qUo6jGBmVcSKpJDHiZZKAWoXnuWwa5e2paME1cukONXmxQ3+5rc2QIKgewJJPd3VK95E1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gfi7IpAPop3zAa2IG/GrhPB8A21CUUwDFJFfD15yQfM=;
 b=Lv4Cy4BcsuB6HUHrMFmfbOsC1vuf6p0tUXyvgDFkuo+SDCzu61IOYDWnIMzEA5BQCnNKEKV/Ob3s8ktW4g5NRRHqroyb0LrGiV5DCfwC24ZoUbxbAk1jLH7suzF8U0Nw2JLGQ4npYYAYeoQ7RajXlSnc8QOpmg4D2w/0Wc4/QpVV25hJ69Q398MvKSOpRNT7AhVYUKO6Ykz1vVTM+KFO4VblujKCWInkHZA9gffrvAsrlafJuFK0r7O3DOakRxb2Bitmn94JZfNhVG+YyAZXvlmFr43tb20oSrXg92s8wp9lenaH6Hq3yq7rVQcXi3ZABB7F+jgarngFWvYYJquilQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DS0PR12MB6488.namprd12.prod.outlook.com (2603:10b6:8:c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Sun, 26 Jul
 2026 14:06:10 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0245.012; Sun, 26 Jul 2026
 14:06:10 +0000
Date: Sun, 26 Jul 2026 17:06:01 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net] net: do not send ICMP/NDISC Redirects when peer
 allocation fails
Message-ID: <20260726140601.GA388109@shredder>
References: <20260724072901.1633601-1-edumazet@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724072901.1633601-1-edumazet@google.com>
X-ClientProxiedBy: TL2P290CA0010.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::8)
 To SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DS0PR12MB6488:EE_
X-MS-Office365-Filtering-Correlation-Id: 39591d03-a17c-4209-ea5a-08deeb1f0b87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	dZrWZ14hfVeq9iNpMI6ccwguvVSPOi7kGDf1navN2wowFiMgoTNkp8xYr8Wx6ZHpYY4ExuBuGFrAXR4lxOKLZNNWLZy71mpQPgS+YKggFTSXngSo/bV0HFHU0DIyFsKZvV61NTlILi2uMc+G1t05cAIqxZjzncpDksn/0O5nFc1mCkRnXkjufPEhOdBJHl9zZrqlbg6Z17RhnFjJ4E4qMlykvcQEJxi1/2nyQ+MeyjaFbXffZmqYj9NK3DorvRPzwlWinExvW4UccSCxDk6loDsGhGGYb5UA9M0UXpe4rI6fu/zGlAySA0uBIpDefh7sCvUxHl6OU64R0x14ray4IjeM0JnuryoEeDfvamMeY+uqlk7QAG8b4oiXYvxmKznp0Fh8KNRoTujLIenO6QjAZKLK5zJuaTgrkTjvjzy3tSeV6luAbhiKYHjob1ytHj1thpJoVLr8fTSgsG53ss8ssdUS7Z1ZXNRNSV+3T8xbXYV8zY84BWqGqi/pLjHEjrKn2YulBeUjMM8aM3lQqmGw0ct1lK2TXmWZg9s75qV+GnMYfVzKO1eTPYvVYBhYsHja2Qq16ejX9sLFcHlFWh9ndjLdJETNQptghF+pJEqQ05DpmrX1QsWV8yjoN/34dvUee//j53tu/R/Oq9RWfslk4jjaLr98AasTV7/nODxQD0c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mh6L+qYyuWzSMqav3DH6YICpFfGuZnb/pi4qt/bjCs/BW/IzCCoXXiBmd2nN?=
 =?us-ascii?Q?L0ft6a9B1Bla6ktXFAdtW8nPyhhQy+57k0uoKJ+7wNJPaq+eHKZW+zPg8Gzm?=
 =?us-ascii?Q?pI4CDJwM/hkL70Q5gHXZqqHJWXJIFgJLViLBSo6+KCnH6k+tJiPc8SWxmhAo?=
 =?us-ascii?Q?3+1VOkChmu35BweHq4bbRb3JCxlI6TSST9XTDfZJ6rWfqQgeumJcNT6llcw+?=
 =?us-ascii?Q?bI689rBbSY+gryRM9QAEv+EWPy/Tf4ylBrvewfKc/fwBxjwko00PJIdX0Ixy?=
 =?us-ascii?Q?+F6tWdxF/mzSN0MYAwcJxSWoYXybYKlSqYRUYW+Oq2FrQO9tJpWvhT7SjSpo?=
 =?us-ascii?Q?/w7nCTxRIc9uuDb99UOQTq+08CoqmtgZQRCOU0cRv7WB7a6nhABWe4b/WwId?=
 =?us-ascii?Q?ELCvFwKy62W9Blm7st6aDSo0flRWGpZ4C8iqanKu4Nw3Z7OPxTtQ6Dd1DhP5?=
 =?us-ascii?Q?kDIw7KnYyAFBifkGDplvlF3s5hLhTPK0avFI0rZhhxzFWkHPS6LGSKwEyvf5?=
 =?us-ascii?Q?K+/k7Ad8dYZA/JjVImjnLPa3/wO/TTtJ55Y913tHUSjqy8h5FFncsPuSvfPO?=
 =?us-ascii?Q?/d0GpndeokCyR+rGALZpLqgRqUZnpa2qwmFlm/KRW7dMJO6EEe1oil8BXLW/?=
 =?us-ascii?Q?j6r6PcvPJqSLMwFLZQHmjH7JTvatv3jsUha2pDyHKo/lVP8gpNr3XJKCDX02?=
 =?us-ascii?Q?6/fd1+8y7SbZAYV35nHZNd80kQYwfZVpIetwfN/ViVivyQWlbkNdjy0LAewo?=
 =?us-ascii?Q?1W53rGXnVmI0FcYUUwO/qRwHw1Vtn37jDPbdBeeUuKZwM0BgZnMGEqQLo8oV?=
 =?us-ascii?Q?qXjUmzVFi/hVYzRque5mCyEI6uH1juUyPhgu0P6qiy2x6cQOrpoXbQKZX74I?=
 =?us-ascii?Q?4hbsKsnXIviVwqtlE3+uSDt8R/iws3VuQrXKd66+k8YgbCttLUm8Pk6RHG6E?=
 =?us-ascii?Q?FcWoOK8FO5DeTqIP0SiGmuKDJ1/nBy5WMrt0Hxjkyt4ZR2log4Uqg7pmSOnr?=
 =?us-ascii?Q?8oCB+ZtlolXHv3BgjrHUzFZQLnEFafajJwaUaAVn5N2jojO6aSzcWxUL4X2U?=
 =?us-ascii?Q?LWTcPZ0IUyKI14TEzFcpq4c8mDRVacmMfn/bA/KquKd6tIrPKkGyh2qotrAl?=
 =?us-ascii?Q?i/mSJJM3n6JM8PelYqw5GzOwedf6F91SgrC1n324/cItVQBQPgVf3WLG52O5?=
 =?us-ascii?Q?VMKWob2GYgfHxlnFhFhvSm7RULAzjPUMobWVmKu+3OJ8SOgZ3EV21iR5crdH?=
 =?us-ascii?Q?BWg0LnlBzOG6/cqqNQSA8HmHYlCTFx8qAoD7gzMkUZQX2H+4FDJ07/8HWPEp?=
 =?us-ascii?Q?4Ig+d5hkGpgLZbzKFOy9PCwv8w2O87LFohFo8oJg0eXpqw0UHvX1GY1Qtbl3?=
 =?us-ascii?Q?JAkwNjKcfmORgaPL5HOQJXYboRsPN8GdwV6QE5rFGqqooW0PdbvvozKPvEFm?=
 =?us-ascii?Q?F3JraFgQEMGvsRw0ouB7lyiXRlKL7ymDlbM1tBhdpqYj7WkBVoSdtGgkDlXM?=
 =?us-ascii?Q?2PcoUDgb74yhSlkcs0mpFTPQeKNzHvwlWTloN+ayDhX5tOdnktixeNusAA93?=
 =?us-ascii?Q?fAdGnBzRmZ/0hwHr2Jj5tTPrt0TnMeMnbGk7p1ofoTErWLm+opDc3wf1uxo8?=
 =?us-ascii?Q?3UmTBiDEEgfHDHzvzNX+ZA8M0mBaAHthjGJlIncyXQA29VxKxphIt21ILl8K?=
 =?us-ascii?Q?R7bX8bu+pyVbeBNyJSZfgRY9CCdyQRZ9FRrP0ZvRsufA5+Zv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39591d03-a17c-4209-ea5a-08deeb1f0b87
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2026 14:06:10.4768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T759faVcKwBu5o+/hr5prJpC1G3iuQTlNcgfJbVKsWQhWYvNyv9SWKmxEkhLG8umFuwv+9wVD2UlILpu+sk4Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6488

On Fri, Jul 24, 2026 at 07:29:01AM +0000, Eric Dumazet wrote:
> When inet_getpeer_v4() or inet_getpeer_v6() fails to allocate a peer entry
> under memory pressure or tree size caps, redirect handlers previously fell
> back to sending un-rate-limited ICMP/NDISC Redirect messages.
> 
> In IPv4, ip_rt_send_redirect() called icmp_send() directly when peer == NULL.
> In IPv6, ip6_forward() and ndisc_send_redirect() passed a NULL peer into
> inet_peer_xrlim_allow(), which returned true when peer == NULL.
> 
> Because ICMP/NDISC Redirects are not part of the default global rate limit
> mask (sysctl_icmp_ratemask), sending redirects when peer == NULL creates
> an un-rate-limited ICMP packet storm.
> 
> Fix this by failing closed in ip_rt_send_redirect(), ip6_forward(), and
> ndisc_send_redirect() when peer is NULL.
> 
> Fixes: 92d868292634 ("inetpeer: Move ICMP rate limiting state into inet_peer entries.")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
