Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011026.outbound.protection.outlook.com [52.101.52.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFDC48F852;
	Wed,  7 Oct 2026 11:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791373240; cv=fail; b=PIKj5JL++/xEEt03fe+oiy62N5NDZak1r8v9z5D4TmQWpMpKmvuKMLM+aHsRj9EuiyLPyAN07djMVcjlwVyy4anq2vaaq3fv5znQaeLp4XdsMeERWznsHsjaylS6154ZqcuPDUkxAsiRagEtRq8SwlO4ts3xT5AoaZXz+CB2H0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791373240; c=relaxed/simple;
	bh=+GmplNChDmUvVB2t7mccxjBUtGXsQNFLQJHtIEfyR5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=q2TvNKgo5vebdm2be/9uaXsZUk7onQuAihxI4gqrqu+GjqNjhClKfG7Xo7VxujwA5HMnpXKkFt6eY7lxPqIFEeM6SeC+LRfKdzATrgFnZGitQUcnGrE7IS+ruLvK33JIhyQwRCUgEMFJj/HAx3OJ3P1rEGMbcmSc1q7yn1qGmnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FajTvg4g; arc=fail smtp.client-ip=52.101.52.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FajTvg4g"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oj4r5+F07DYu7/4jME6F/FEWLP9XWQoX7LYpnN9+0HPfjefZO5XSHDcM2rfLhDdlmPNlwpA7/awd9ZBOVx4H5ejdQM5rlSHPiCvM5RG4Y/ex1IaeTtrfWkAUMxTf58slaPzCFfBM/6DlIcmk6RAHhZ9jlUyFfHNfX8LmJ7T8mv88BekIJ+1UgI6J18ZZKZiZMT1n7A5CdqdSfjQpQ/96NDbEqBTV12uPUxNDCszOnKqH5JBWe8KH+YgSs+MLd5WFsQpu2/sK++GNfFy3yn1frgk4WNFj/01o+MXJYcd9mPxk1nAbZzcoWeuoS3ivd4kpclOv8uMPEJgUQy7EjxzP5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l5/MffRnuq8Wc2JWW3k5+5oLMC95jBbI23xn54nG/4U=;
 b=TMb2UQ7LdDcSilmspgPwd3+3jGin6qOXdj/kNGWcwMnpPuyvgQgel/hK9GuMDgbbZubdncXCpvSz4N4mv6r8s/3kJpunzZiOeC5/SeE3s+EtyuXTeqsTzKt1xSvRbYerFtIRxqQsZIc3pQXzfFgxJm0TvQW2MxdwBAsycvoLB/ML199NvQe8hHaR85dbF9Aas75GFMCkbEYml7n9X8TLppYdaeSJkltQNv8YtiI9Wjpsv7CXqJV/dRWTUtueeuqWmKfcdqWi2aBoD243EGPF+QR9H9Q1TlV8SVa02R/WxMZF4Zj7D3G4wpXw61BmRMVyWbD+gxcGcKKhmDlDdK/Acg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l5/MffRnuq8Wc2JWW3k5+5oLMC95jBbI23xn54nG/4U=;
 b=FajTvg4gd92WMQ6ltjKgmPAmccb1tPQTsL2HN0YcPxE9gVQChTcGXy5S5Z+wP7OBkZR8dfNTFx024gcv0zMr17MPfOru4pk0Uww/pSac11rvCZKdKlPhsC7/c/1ISWSipQmkgVVp1bPerwe3UT5BTuHxn29C9KzUztVr73Vpw71k72PCpB/02PHu19RQ1MizeqS6VCWySUhFVSpPO51sufGz0I1F0GvpfMeZMhHsQeZP5kojw2y4EXqPjU8nuX2sG6e8Gq94YH0jF19WmdGfieX3Bi2RuGl++ahFnntpDPV48bSsySB3aIXi0LbXdv4I1+ta97GsTb8WVYgUpdeHuw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Wed, 7 Oct
 2026 11:40:15 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0451.026; Wed, 7 Oct 2026
 11:40:15 +0000
Date: Wed, 7 Oct 2026 14:40:03 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: David Ahern <dsahern@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Amit Cohen <amcohen@nvidia.com>,
	Roopa Prabhu <roopa@nvidia.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ipv4: do not warn on route notification size race
Message-ID: <20261007114003.GA1011260@shredder>
References: <20261007045410.3806739-1-4ncienth@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261007045410.3806739-1-4ncienth@gmail.com>
X-ClientProxiedBy: FR0P281CA0266.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::11) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|MN2PR12MB4422:EE_
X-MS-Office365-Filtering-Correlation-Id: 45145f31-772f-4d6d-83c2-08df2467c108
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|56012099006|11063799006|22082099003|18002099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	RQz9qbU1+n177l75mispLA7eeXYxymYpjo3TVnHlAKpm8+CmY/gsb99FJBrwAMe09YsY2xJieSVYkZ561LI0rssORyZ1lLfWUwDRC4dAT6SllKGanHXkr2EoxWep5d1B/aSaTIhcc4J9rWg2XPbWX/jgtY7Kqo3Q76JEmqUNzr7XAmu+nGeb/q48aXy15eRFZna4+S1J5Zzp4xL6dkU39jtBTyVjWvl3td3S6Tpagr4zaUrqnBZHGI7s7uDmmLBcl9cbCdrPvl+b29egcTBgWAWHI5UzuETcQDaD58A9Exfp6x0Y6UW/lDJAJWFiDo04o0B8Tt5aDT2rbOaL0/r/lSYq25T301IaXRRobqG9/KodUiF1/ktmgerVjxjnWGANUTWsRft2KD/YTTG9xfWwlmxhNItqgrqvASzLXYj5N+UU8Kg4TSjVSsCPhsb6VjWtaA5hecpqY9TNyJU66cWRqi6NxKUjeb58Atsg5uMinsM4HnvrR6vr2XRPd3hUV1jKFPGPqDCSzWVG226eh2QKEqu33FUu5d625iLqoGBGdkzgWmD878n4+1qOR19n0UE5GHEY0u1oPFQ76ySK4rikxe8ZEwNTB1lGv3Isd69Zi8MNSSRoaeGYqJsal3OiKP8KxyobouE83r/bVef1yAVZcmSfoeWCwLxlOBv/OCNdRqc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(56012099006)(11063799006)(22082099003)(18002099003)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jqdiVxMci0LY/tzIQnYvAbEckfhwTtHipm2YCdi2sqDL+CaQIRpt+0DpmEu0?=
 =?us-ascii?Q?WWIVfQCr8HM3SoQJc19odT5/jlSMUXFAGwkC+1oLxpOBv8LKlRKJEkd/8F6v?=
 =?us-ascii?Q?jyO8ykpRj7g2X3mcQBZkBS9PFfKnUD53say4MLcHXUgIGEHwsAgCWSqvDCcU?=
 =?us-ascii?Q?xed83olrw3TLTHkdwKUJnGhcjIOQF+jWdP7kfhtC1ci77Ez6Baz4DpFWDlVk?=
 =?us-ascii?Q?G9xwSRfoyCdG/bJvStBgx3MVuXk0c4kRzMc743eQyq99KnUB2ZcW3RK+a0qM?=
 =?us-ascii?Q?BG44O5Lw6RNyY2Sv7s+WcUkqjDogsCIITrgVlLQ1LGv+jsjNOdKzQyECWnCk?=
 =?us-ascii?Q?K4cZp3ibK47ZKzrW+iMUmgYRF51Kxj37P0eR8eZG70wALD73WTSzrsAarnmj?=
 =?us-ascii?Q?tRpbmA40A41/60lawWfVWr5DD4bgLprJv+O2QaVU4ibvReGG2dgfvzBHJ3jW?=
 =?us-ascii?Q?7EQvTdxuhj/cfPiaH178WzRn5+8KTV3oFqn3ARx8GhqTpw/JV3Yz1W8VF1xw?=
 =?us-ascii?Q?ejFvrFUZCeRDPOQ068XVHWKomPF8FpXYAbo2Sj3RcJ18X0ae4snZgOaofrqb?=
 =?us-ascii?Q?LoZ3SMd/DMEoegXXDPj70Vx2d7tyL9CNPoeschDEol+SGvrSRA4cbGA9TMOf?=
 =?us-ascii?Q?bvg+H/dStOt2I5zWi+0EBGaLE3qv0u6aB7SXazgvqdo/yG0hpbaVXNuw8iIJ?=
 =?us-ascii?Q?f95tiPOG7wG+fbxZGHOe7+KcGPalZS75mxsg/sZeAA1WOx+29MnB9uS5l5oP?=
 =?us-ascii?Q?lRCHw3HUiEGlDN75o02vTmnUdEb+0X+QcxhVk9KC4raWKUCE8f+otAyjxjEh?=
 =?us-ascii?Q?iT9qJedDp0vRVwcr5WkpPfknESboiuoyjrEsTfue50tnNrTjG8jx9vggG8XC?=
 =?us-ascii?Q?Jj1LgCEruBhLct8Tr8bCEcltv/OexKHDfNYAHumaGyB30VXVu09+KJ2GRMm/?=
 =?us-ascii?Q?sToxHAdG5jpZdxlgGjyaekBlySZIJp1rp2TJklFwGqtCeul06aY9K1zsZXCA?=
 =?us-ascii?Q?88pK/o8I8Wi9R/PB/KNbafCZPL6RU5HKu9MXo7jWVWUPILRXqTbrjrkIz27/?=
 =?us-ascii?Q?x9KRr9MxPU3axFX0IB+GZqi6pDscSo4g9nE8YSL6INCo4N+AO2r/Lpz2NqAg?=
 =?us-ascii?Q?Knaum8LwjLER6ztdYvy/4tLvMfxcO0xMrCuemHw4waqJJ/ZuezmwDe7pPPxS?=
 =?us-ascii?Q?O0Bgab39KuWo5zfW9JdoPBbzBAab5DrVGPGHJbbney5S7sOPNhylXqmVxp0Q?=
 =?us-ascii?Q?ui+qklfHU5g3RbxhCk40hs8ubftvr+cLYwIRDTXbWBfYOYWnbOo+rJaGKhSQ?=
 =?us-ascii?Q?bnJhedSZzMubVNfSukEXLHnZ3/FOyu247/0i/VWv3zUgbF4z/Bf88R64HXo9?=
 =?us-ascii?Q?ONtWyfeZ31hYpMsMfoX48y2UqemDYZfSv6N6bH2uD1Bku2GvTMCQyMGk8dij?=
 =?us-ascii?Q?hI+2h+krbnttm2xrlZVOse6mjEUNlJFOfgwqfjXTmn7ahIK+CzV1xWpd3yvZ?=
 =?us-ascii?Q?ZgOtgoV9JmZvMjDUt5diW5XHturxIienuSopgfnJ7JFbV32VycfmvsN8EZUM?=
 =?us-ascii?Q?FtVz3VewhygBQk+ncfindpSMlCm/K3JlBTL5SX+6LUT4jRtImaGt+vNB1do3?=
 =?us-ascii?Q?j1if8hI+kT8ppFDP5kGOeJcBaz3HKX3vDDHGfKrGzgX0C+nQl1BiQblx0JkO?=
 =?us-ascii?Q?006noWx0IVLKtQRFzdL0MxELoncR7iqLcsz9n2UFt2O0ykJa?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45145f31-772f-4d6d-83c2-08df2467c108
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 11:40:15.1319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ozRBsS21/yO0l9KlVt26rusI9UtnWLDZKPbLpBD5b8t20ZFx18maSq3oixm84F+v+B4l+NIlinSM8wB4CAyniQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4422

On Wed, Oct 07, 2026 at 01:54:10PM +0900, Daehyeon Ko wrote:
> Commit 680aea08e78c ("net: ipv4: Emit notification when fib hardware
> flags are changed") added asynchronous route notifications for hardware
> flag changes.
> 
> fib_alias_hw_flags_set() sizes the skb with fib_nlmsg_size() and later
> fills it with fib_dump_info() while holding only RCU.  With nexthop
> compatibility mode enabled, a concurrent replacement can grow the group
> between these independent snapshots.  fib_dump_info() can then
> legitimately return -EMSGSIZE, so the warning does not prove a sizing bug.
> 
> Remove the warning.  The existing error path still frees the skb and
> reports the error to listeners.
> 
> Fixes: 680aea08e78c ("net: ipv4: Emit notification when fib hardware flags are changed")
> Reported-by: Ido Schimmel <idosch@nvidia.com>
> Link: https://lore.kernel.org/netdev/20261004082043.GB92032@shredder/
> Suggested-by: Ido Schimmel <idosch@nvidia.com>
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
> ---
> No new build or runtime test was run.  This is the exact two-line deletion
> suggested in the linked review.

The previous series was IPv4-specific and I forgot that
fib6_info_hw_flags_set() has the same problem. Please include the IPv6
fix as patch 2 of v2. Wait 24h before posting per:

https://docs.kernel.org/next/process/maintainer-netdev.html
