Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012056.outbound.protection.outlook.com [52.101.53.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106A64964F
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 07:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791961266; cv=fail; b=mzHTeywB24BziqGn/5gRnbvEj3Yj5+GjagbPdnrqzTl4FPiCVWI6gm3TvhjWR0cojrDAW+LgzZDFjmGcPaV9CGqfcM2Sk6DwTvVqBurE+jfp58w6ADIxEzwuO3B5yqfUhOAJA85NC/MfHaWOV8GA3kn8ligYYzZUKJRnk6FTMgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791961266; c=relaxed/simple;
	bh=ZWPTlzZIupP6OEaDXqJmTH3PZVTiT87E3SH6brf/AHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hnvwUK6WJ/qdWUrLhOLea4gWMr5QqXh+z6jOTgxK+qaVJwZU7+nPKNvKJRiCa3Sj8ag6Hf7VeIkj6nKK3vueCL3NM9REckagHiCXsTZQ4e9aAwUmiiA4D9jexTM8HbgVJKPozMTW/aC7PiozyCXVT1+eCuDdoDCzPjtsF1U21Ew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UVFDuzJG; arc=fail smtp.client-ip=52.101.53.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UVFDuzJG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LfwGF+/4w19z2RyZJr5Bcim/oAvBCQ1gqMuvLXGqtb6f9SuFjZo1Nc/ukRtDRmzai7XEJnG8/wkQy6IqFmmFLhtjomB8bJ8URzKSWE0abM7ZReaO0vagP2Kxnt92vy/xxFEva+hDCTSwlkms32vKe6u+SmjDLS1lxYtpkun9iUKqUTnJw2TOcCkpz4ujgE0BC1kcdPf0V/P8D1NhzNdxWSxVEpLNGL83UdbrIrkUKAr7YrN0kz/yW7K517QHji1599+uyBWgRyGucVlhxPHFggEYiY+7ANfYpmTn9E2BFmEVD9QzSK6HXmiXMYa7TqpbFv80sDyT35GpQCMqo5oB4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u03EOp/MfNUUm8GQ6uEKUnNxiFZVF+hMaYht+bXdXiU=;
 b=FvmAJj3w/cBf/Emf25da1AM5XhOGDPeh7tGA4hlnwDYMop7oKqJT2FTicX4JNn7oZIa6OlaREPuOJYVW8SQpD5RiyPFAfcfj4FJCKkBxYwfpkxgKFc6BcKxWvy5Jme9lqfnUNK0zXAvmGeP1eG+WUTJKuel/S9UgkA2Q0da9nkRm5lFCLIJINPjN+zRvdhWg5uFkQGkF5NBM2n+OhHJarnN2RLzXcyZUWt1xO080N10K3cSWeCwHzj5yjyh7ofYxnTL/tCVibMSE4B5BzdSXbAWW3HPKEOgTiXR8QbOKrPKFhSXg+noCo3NOOZXu/RtZ2w+BbnVloaR7VMs3FqQC2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u03EOp/MfNUUm8GQ6uEKUnNxiFZVF+hMaYht+bXdXiU=;
 b=UVFDuzJGdwqMI2uRbiAOPcIKuWze7bRAVQNVbrK4RT95IVwWX8DY8tfdQm6g325Mr+6D6NQnKadldozpM9HPMeFSMH/0wN0GrJyrJz6GWat/LC1wILmtN34yxZicQMjn1Cv72cBYlq5v1dtno9A9YreyGthIQnunPeHvSey/xlvGffI2MAwNEI5EzyEBOo3xNgvowGJkH/y8MYw2UJuUenrRmkYijilJhuhv7/Q4W7WpqZkUnkdE4xDOYSWn6hmD8oDELF1uoX0szp4jIVFeQwDutD3/0az180oSh0izSj77Tf3kd+36qUtk9CQG1MFsidYLkimYYEgrFg5KvhQNvw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by PH8PR12MB7424.namprd12.prod.outlook.com (2603:10b6:510:228::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Wed, 14 Oct
 2026 07:01:00 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 07:01:00 +0000
Date: Wed, 14 Oct 2026 10:00:50 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net-next 3/5] neighbour: Schedule neigh_managed_work
 only when needed.
Message-ID: <20261014070050.GA1220477@shredder>
References: <20261013205816.1642597-1-kuniyu@google.com>
 <20261013205816.1642597-4-kuniyu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013205816.1642597-4-kuniyu@google.com>
X-ClientProxiedBy: FR4P281CA0077.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::17) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|PH8PR12MB7424:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e215b10-c340-47be-06cc-08df29c0e729
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|10067099003|261009223027099003|4143699003|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	ok8FWlmvEbagL9DyTvCTijWXXgRBa7l9twJ4+yX6wq1PiCGfiCjsa4JzPwtqdgAXTwFGtvWTru2DKFPRKNJvsYc0KS+ObJ7dG70GpmMYJ+2I9keQAu0zt+z+ngjnCkqnZd6/r3RyNzxeJV+xu4HN66hqJxLqWJvaJzJOnvkUcOY2ZqmeeVhb8f8jHSfzxLSSDa7RON/6acmhk7jRKIYJU5D0m89LrifAsDVU2WrSxwL8e9c/6dBNaZHHTUHZnaqPaA5oPGWeao1usk2DMs1qwXXxWOzqjZp25pchrG2JaJgHT5QBUThibYESetSbOgN/PvQUk53JWdHkh/P/fLPJwenVnbkCNHftNCVjuXWqUaOa8BiiS9caD8S53f73ijDuJmrCrYYu0OEI+FKqjFMf8MdZRk3BcLE24JwBg5xq5uNCykHU482s574b1jhs4YQmhDz8Odi+2Xtv0zXEuKYQser09YTx6PvKoYKneZB53xdqBmeHQeSR2kobzZBzEelJbyECUL+A275E3X2dnw/eJzPWxZbDb1yRFPQKtw8EI2wINphKRtMLTBo5D6mxT1zKe5Jm2uR7aDvEqIPDXamuvJ25Mdj3U+yREBrYgwUv6KsQu0PZl4d1ZkenVCd/cuHIcbiNpxCUooerwghUbPBTZnIJice5qYZR/B9xCIuiFWk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(261009223027099003)(4143699003)(11063799006)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fhCRx7rwixkJmPI6tUK+5viOOeQVImQZL016atlBDaqvaH/0ErPdXLjQ+9Fq?=
 =?us-ascii?Q?PhiuJGorYaJVDOBk73dDbR1gnRI39y2DOwTb7cbHkcc62CuUYnEKyto0STJZ?=
 =?us-ascii?Q?5IHwOKDFrD8UUsoE97MkAeiK7Oi7Y1hsujut9Ty+TiWyWEaxrpW4j+4WKE3A?=
 =?us-ascii?Q?Girr2gzJUdxu9xUWTSHiuCX9ltMJ0RFPV6WZM8mkTuLaOIDK0WOj89vweKaR?=
 =?us-ascii?Q?a2ZaheGprgJXY4qnHozKh9dGPO4JldFpfQxwznYWJ0sMRyKo29xStl+fhA5H?=
 =?us-ascii?Q?EbMptpCkzN7ij/hSkm8pNzjHNCt1FYCgucBZ3nZYTlVSXZ42xttuwpWn5bal?=
 =?us-ascii?Q?9LyLOc7f52n+5Lcjwq31b+DLTllFtnIJEH80xnged8aQpfYLGwgMijIzgEYt?=
 =?us-ascii?Q?6DIC3NIoOk1rc8+Bhz3WVe3AjSRpknrnS4F6svJiew0xTUszqbsbFHaH2npY?=
 =?us-ascii?Q?SyQqX/w7S3V13Gon6P1gfXD+uzTcOJK16HsL/l1cShjf59PyzhqAi7xXDi8Z?=
 =?us-ascii?Q?2B3GABiLMhcF0sVN4HiLPbJV9/bg80YTSWo3c+JaKK0Ibs0LaGIAzEB4HfdR?=
 =?us-ascii?Q?x9Ms2VBC/3p8W4rBra5fdXZZoo1fPuIYjbegHL6uRtYg2v+MhaxKu85C0umu?=
 =?us-ascii?Q?vVkfliSrc1jAoLH400Ehk5a+gVys+CBHgqJBYvkpcuc45w+h2F07XHOldhPQ?=
 =?us-ascii?Q?LK+JicnVTGSAlIJtAQoKqfDSA0kk7VjEu4RKCihPPUEuM45hQRC9n39GIDF0?=
 =?us-ascii?Q?AkM4Vk/RsSMRpsWcDedYkrNhPRo2A4wST4gO9BROFOQdjRxXH9HJ5tdqYuyL?=
 =?us-ascii?Q?15sh74/LXnRLzTUyksZt/UMmUEJHozW+3iZ61pFZYDRVItXgJS87pC0lxYxG?=
 =?us-ascii?Q?nZymQiFUpbd9lsWc9DUn5IiSMaL7uLevvry3db/h0E40epWxa85kbAKyVZEc?=
 =?us-ascii?Q?RKc6jeUKh589M0z0ghHFUgw92z5iA64tw10WUJYol8eLgDiUbqCXD85LrOoc?=
 =?us-ascii?Q?bDiYH20FjyR6TQtvX7MVt9mSaClnBXfmAg81WUqWYvwCFr+kL2YZpKmx1tJR?=
 =?us-ascii?Q?jepnob0ZTMrrCmOpC68XQo8guOjKB6U0NnIeksGpfRYyTein0C6nw+5UBWYh?=
 =?us-ascii?Q?wTioSpNlFpBQAvSeQNulR7x92t20PLrHkIEY+QXrULBcKSiVY9c4Wm37M6Kz?=
 =?us-ascii?Q?6Iz2LeQRdjJgsbJxIM1svLvjgKlYppHGMypBhrlvZ24MDiHnFW1t2T1W9FPx?=
 =?us-ascii?Q?SXCN52UOIdtt9R9NyMPz7hOv/oWm/fQ75Uw7j5X93IFvEsa2+0hVD9YNUd4s?=
 =?us-ascii?Q?lLh3TFHcgUBUVMm4Z49jHN6JqZMpqZzC9bbfJPWQ2ulEOaAiO3/D+NyqzM6A?=
 =?us-ascii?Q?jihvEkZOgIr5xxIonjBjBkd3Ppxdlh153xyUm2WWzjvnlQxpxHNg8QlpueP7?=
 =?us-ascii?Q?JYJ8irZv6e3SVFM89Dnj+ixDahy3M24Zx/2Q54WDWApkVWECuP5JjMkhdf64?=
 =?us-ascii?Q?IKoLS5zEDXu24ccH+n+oRa1yTW8aVXyukoUjPLkSRhhyTnFOWtK90PxxtEAZ?=
 =?us-ascii?Q?ZC4J+0lkgP3F0RvMgyV+dp8kQ5IOF8MmrItbI1glhCVrlXUF/AoPiykNfff0?=
 =?us-ascii?Q?m7iZsS/l7PeshhjSRGocqQU+AdB+FlKSfdtEM9X/a2kkWdAdtCyWNZBgMfo8?=
 =?us-ascii?Q?4CEXraYhg4wWRnxnDp3zj/5BMPCpa7Ov69imFHNN0zjKaws5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e215b10-c340-47be-06cc-08df29c0e729
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 07:00:59.9615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jcJV1KEfPI3vKabg24hc51XepIHjShH2VC0VOe0hLRvKsWzvAiQUs/ERZ/Rf+ZGEw8qdMca/Q2tFQiahqtW2qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7424

On Tue, Oct 13, 2026 at 08:57:30PM +0000, Kuniyuki Iwashima wrote:
> neigh_table is now per-netns.
> 
> tbl->managed_work is scheduled when netns is created and runs
> periodically even though the netns does not have any NTF_MANAGED
> entries.
> 
> Let's delay scheduling the work for the first NTF_MANAGED entry
> and stop rescheduling if tbl->managed_list is empty.
> 
> Suggested-by: Ido Schimmel <idosch@nvidia.com>
> Link: https://lore.kernel.org/netdev/20260902143023.GA3966681@shredder/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
