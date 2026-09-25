Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011056.outbound.protection.outlook.com [52.101.57.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511734A5EBD;
	Fri, 25 Sep 2026 13:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790343849; cv=fail; b=B/EkikjhiC5BkgQ0IvhHIHz+SCiniQ/jUpDC6+tAzuNA6T5s2n7+JB33kyT1pQ8TBdievTf4GK7/a3TQGKUjqFNyoJPtCpl6NNeN78ctMddAKExGXqpPoWstgQM/3htCe6rcpx0Pv23/Br+cc3sB1EJRzMJziV+dY/OLnKTIi/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790343849; c=relaxed/simple;
	bh=weYTmn0oOdE9E8EP0F59cWKbWF2lxpL5pik3cngPH+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EemOTeI0lVUSWfyIeWYehE85Yb6MnD7A9geWT8Xzjww9v792tuVVDiMtjPON27sHy0sV9+bmvz+ymOy20MDAhLBmLCzqr8GYg3oZFFSC0e2zrmUNmDRMGcTwvcHOXEOt7P3c68S9fsIu0MwOlQIVAAeY+rE61NKkARAw5IjwDuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dE4wmkzb; arc=fail smtp.client-ip=52.101.57.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dE4wmkzb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bKwjDuOcLqbf4u4pK+Y/zRkUeHAhGiiOikSF4MceFkN6lNIHuHtmTEuhJ9yLeUtnTylHt7PI6dcogLJqdu0XTAJX08AtsWrixEv8xkAGYOIGG5IOiqVrLCXsQV27PFbP8rufoWBrdBHPIJI3d1HsNkExz4CqCgjVDq7I3l9Bq2Vu1DR1aAE8+hA1emJK4cwxdebS+ofyHtHAGd0lgbBfJ/id0rt/v5ozOCexAaO9RnhjpMO2Lc6YFpgTlcHlq9w/ePhNbhKWbR1FvTWlRTiaaJu5gasNdOhOlL/WGFPrUkm2IEb3lxq+yOgwePIUM+DpIgAOUKwjIn7lfJqc6ro0wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zAEK+hkXrXsS/nSKgHz6w3WJXZ8rnTMRFBBOlEHsjQg=;
 b=mc23O25n0x+YIaW1G1XX8GGM0IS1S37SBJXtYK/P81/MHem/JBzPOEONX7xxU5ZcDL8zbmK25lvDNs0s0m2lCeOVjyOX5oeHTNdNhveiaQrK22hh9iKRfYE9i4sRiQ2XLeptrqgDkwLAIs4XL3/UwYTvAhnhHp4iqoCf95lkbeJHFAmUyPPCTQzAr3gHe+0Vvg0ki+OYa96XzCjWl/4j1bPBiShbWNGgY9lrOkoGDY9Qnva70SZiUGI2KLlfkX8uWC3HE/m4DBuReuLbKgJM138eGFTQ7aPaYlaw/bGelJIl3TiwUgqC+aSsKoSaK65vSHjmQYjq46zpgDnM3ka8jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zAEK+hkXrXsS/nSKgHz6w3WJXZ8rnTMRFBBOlEHsjQg=;
 b=dE4wmkzbQdsyM3uFdW2Azv2l6en58x28LO12NMi7KhLZBffeAjbMKAJMwHXL54wapoZRLGypPN1hpk29Ea1gQkRRCcOyTZ+lANr35uFamBOEHJpUgx4ipbWQi/TJc80+eYNvR00RLeQKTd5L3V8ty2MWLnj8HM8nbDHJ/U7rAgNdyIHAGe6gx87hOAVDWwv+VLSuRtFjQSYT73tiv0GCaI2oVtCoiHvaApA3SH3bJ/qApMGW5ePZRAv//spAZTbGz8u0m21/NR6UrZrPE37S4bIk9nrYVF+gOxdoZ+Y/jgJJvUrwE9KNpPOe+pJGIVUZWEMIrgF0mfIm/+smUqJuRA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by SJ2PR12MB7943.namprd12.prod.outlook.com (2603:10b6:a03:4c8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 13:44:04 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 13:44:03 +0000
Date: Fri, 25 Sep 2026 16:43:52 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Qishuai Liu <lqs@lqs.me>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ipv6: fix prefix route expiry in
 modify_prefix_route()
Message-ID: <20260925134352.GA153660@shredder>
References: <20260923132048.3272878-1-lqs@lqs.me>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923132048.3272878-1-lqs@lqs.me>
X-ClientProxiedBy: FR3P281CA0017.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::20) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|SJ2PR12MB7943:EE_
X-MS-Office365-Filtering-Correlation-Id: 68c4923f-d0d6-46b9-a5d6-08df1b0b0fd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|10067099003|56012099006|22082099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	zM3a5eycTzcopm+ZkvzC8TKskSosqjJ2Nipgz0BXv65Q17yqPKFuZGK/IUGdt0q7IvUCAqAF4avttVZQ8HL0Sxace+fI9WKrQIPr2AfhbZMH3lZYdoKMucfhXbxsB+fdTar13P8mhqXm+1DBjfrqYMcn0oK39DlZx3wGHd9FAZ1WJexQgvitoadRe4jxER7aRn2RpBzsCDg4HQT2jqMIWksQpQUuBuW7Odlrh7IKtDKNgEtjA+qtGcR8SqcILW1e6BJaqqH0rIsRfN9THW5Ha/XJtoGEGQ/zpqJU4xpJ1UjpKz59Jvau8/wpeyEykAA5fyeTw+NRoJ4FzHIjS3JwdTFGZNLE3NbomRcNAP0TyJJaSda54U3SHxKI/q8J27al4MHoHoxSpgA7di+P0rWZr8jqT2QPRzBXome/38ccq0YtN38uL98RiJlbua0RCfYZouLcntX6PcQqhLFjqGLGQojYyGOrweRjMCTVYNdvzkFcjJgX7yYnoTLklkU9rt3IdHVSECd96VvetcbOKHvvGQ99xOXQ2aVGcOiSp4krtONHcSRYuTtNSL4wx0ZbKdfClyAwdDejKRlSpvwDjs8NxoZFkOiFCG+giDDudQgYm30PGR1Bgat3wNmKq9fBJBiW7H4K0Me5yq9YnJ2sZlkahJxE+vLZVU2j0puX32z4stg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10067099003)(56012099006)(22082099003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PL3TouRWAZ33HbHXIqu0Axgd4MT3XPNzAocgGamh1D/fl++akoCDaeCCKWRn?=
 =?us-ascii?Q?TR6dVBh6BGgADX1z0/MxeOyGn0fvfPO2pgE7r6PlvBOOhm6uo5KycucAJVI6?=
 =?us-ascii?Q?rUz7fV+PvfsL3j/y1Js01FW8Oy9kLO3wz2+7OtdxP5qxTln28oNshhbS0e3+?=
 =?us-ascii?Q?9Zub/WW8GlMAPtoRlyoZik2JfoQqwKCbwYWBpzzh5fTMp/XUCSjtqporFzaP?=
 =?us-ascii?Q?42s8X7518WY0LWDHiv2/aGOCMB4xHymfTzcWKa19nbR2RXlE6VRkN6u1Wpv0?=
 =?us-ascii?Q?5z8SQjgwSMo9/n6d5yiKv/adeirP44gO6IbaPitd71F4iP1Z65HqJ2zNUIcs?=
 =?us-ascii?Q?B+Q5q/P4d344L6R8dSx+R4dLhFfE63D2SZ+vARk6jP8VUdsNAHwbk+EJOf33?=
 =?us-ascii?Q?5IgLMuRD7ciwG+K1624LVC90pzBAIyvUD47zwUiMMDWzXnivFWLbqNNQxAnV?=
 =?us-ascii?Q?8V9XFtBfZ0+eMyZDx7Yja957+AwnvxKMHtWuYuhDLsXBNwxL4aHigYyKpVHv?=
 =?us-ascii?Q?x1vG3lN5xUqlA8KHIU5T0LCN5FqHzK737BaArVFM6+b21oZwQUZyPkILBK7z?=
 =?us-ascii?Q?b7c8rSCkv5RAy9ANMgd482Rfx5D81PVZbD5wOtD0rB3Smp0fq6IOs+k1SEqz?=
 =?us-ascii?Q?rnbiT5J+bhyapk4cuwX2fIsvAr1S0vXnrtJCgd5q9GFgMdmB6JJg2w34rbOA?=
 =?us-ascii?Q?ZVDM7zqKFHdX5ojohHvILaO0vDEEJUbDhZznwCOHJuAWOufmNWMiB42JofZQ?=
 =?us-ascii?Q?v5imY9hW8QovwRB4tfSIygHJWLp23ZOW4POjaWraOe2Poj8ZEPUVrtKMOFYW?=
 =?us-ascii?Q?GAAb0iaOMAHcSb+lGLhvHhWJKoRTmuaf/jJJnDmNCTvgqfi1DKxB/jhWsdAk?=
 =?us-ascii?Q?C8eNCNc+vA1kHRn1D2xEaBNpj3lZU7ER2mcBJfsyv03XBKYFpUUzczhH8fGy?=
 =?us-ascii?Q?fyyIg8wHWAX4BPILyF4YJHAIVtARVrmKz7iw8ztTIqm8oJsps3t4nxdCofqV?=
 =?us-ascii?Q?eqsbrgsfufExKJavrmF1dWy3SOb1BK2XIv8Xk1xyFNHQb+CnXjiUNJIr/uLG?=
 =?us-ascii?Q?iJQA9aK1PiCzLDSnFR4Z6OFs2kIjKHrU50gJPJwq0yaVq4k4Abjcz9gRXGJ0?=
 =?us-ascii?Q?025JzfPazULk56u/Ada3tGOqwAitz9AVCyflQt1dZJsLDWT8Az/uNv1Xuakh?=
 =?us-ascii?Q?7LQQHCBTSFkiv1xKN9Sx1ehfLCn53eMrojmVBvbP9z+NffwUFGO8J7g6jIKV?=
 =?us-ascii?Q?Gn5JV3qIktGB/fAaa6BkqRit3T1ycqxHb+Z7BVun8Rf7uw8uPtNMP9TKTw1u?=
 =?us-ascii?Q?uUYYaJF4uEaIVCPcD5I2U4syFri2Sihl1GibOUz+NQdOTyRu3LybKg+p+VY7?=
 =?us-ascii?Q?HyAEzcvUW4cYI8YstMIBkS+VU0Jh+aSa+vftTlvYmnghVk9jJwRBxXw7Acg6?=
 =?us-ascii?Q?JJWaBRsseM1FljHNRqGN1xuyQpDl8Cdd4DW92RYMbmxEXeHh9jDYVnfJFOQv?=
 =?us-ascii?Q?hT4B58uVkUqOgj2lYdZxYkT1w075zubPo6wN2nHPIpfX2Y15PBbKaZQj+V7K?=
 =?us-ascii?Q?J07gNeBZxOkjnHq4mDCLiCo3Mz5P4gCY5al9MFF01apSa+JpgFIUXwyN4sJo?=
 =?us-ascii?Q?IPK/GrWg5uu0OXHbZ/KmGS1zwIw36Y7frAVKeghrUgv1xFnHDUvjb5fkvqYY?=
 =?us-ascii?Q?wzy/dW8JKS0Qnw2vYzEW+zXKw2Am5yCrmtCg423Viy7qgf6dxFoq/TNZ+Fzz?=
 =?us-ascii?Q?CWE46y2b6w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68c4923f-d0d6-46b9-a5d6-08df1b0b0fd5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 13:44:03.7268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2trAVKXGtfB6PxbVU4r3JkwzRWOLbfToFgZyeudnz2tATsidqCHHMtHCQfpBgUTJhWjVozDEMSbYy2hyMoIDkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7943

On Wed, Sep 23, 2026 at 01:20:48PM +0000, Qishuai Liu wrote:
> modify_prefix_route() is given the lifetime in clock_t relative to now,
> but fib6_set_expires() wants an absolute jiffies value. So when a
> permanent address is changed to a finite valid_lft, the prefix route
> ends up already expired and GC removes it.
> 
> Steps to reproduce:
> 
>   ip link add dummy9 type dummy
>   ip link set dummy9 up
>   ip -6 addr add 2001:db8:9::1/64 dev dummy9
>   ip -6 addr change 2001:db8:9::1/64 dev dummy9 valid_lft 3600 preferred_lft 3600
>   ip -6 route show dev dummy9    # expires is negative
> 
> Fixes: 8308f3ff1753 ("net/ipv6: Add support for specifying metric of connected routes")
> Signed-off-by: Qishuai Liu <lqs@lqs.me>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
