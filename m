Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012033.outbound.protection.outlook.com [40.107.209.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701FB392C4B
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 10:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788861983; cv=fail; b=QMqZgeCiQ7OnWm60XnNwi4eRIf6POpGzStk6utXlmT1RxwsACezFtsBQmnSxUMTQ6VE6MACLmeXX99OAYB0mAN4jZ3R5pBMwns8SyzNOx1kq2miuDja0qZnwDveTjXk7QHqdTH74AmX4FT2JSO8U/qXujKEwRUnjXldtQucsIlk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788861983; c=relaxed/simple;
	bh=9fJ/sfjIN0sYyxvCl48VX68mC/ilvRq44SwZf/p/Q0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JWAGOS+RtSH2upmzWQ/zP6pBtcZDXUyGpabTT7d2i3ESyON4hR5NC/eiVu45bLE0DsTwCkIO5wZIJoS0dCKqzeZ6nOeyvMIyzwihPQmKMpiIb0SvqesnQtdux3ZXgt+d40pUYve40fimw0emxJlkI4dRHffN9fjRh4tcQljBiU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ebaf2Jlb; arc=fail smtp.client-ip=40.107.209.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ebaf2Jlb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y3IKqVwLfdDnu+5Pe6L9Y4yOHqWpKbrX8wX8AKxuv9oa4dn5QzF3FQf+0ImdrImduR6PGnQFh3sqCbhla3VKCainEIkpOmoHaXrh7IAqN6XCQwtFHC4CfeEduGrw1kJRAHjLG3F1LP+45kxAEKt/wwfZwMAFmtlYg2hjY41z+WhlZGlyCvTPKx24DT0MgaDTs1JVm8p2tXUC1kX+L0YPXlszjkMU9K18uAG/RM7Bt+4j5cYZMPsMC0ALLyRbb3z4pRgtxLhNB1PBx+oiT25Zl7X21aEPmd8PStvzStGlPwuGHcgRvk1BSjbxUGrwg9P2HcCWB2qCcaGUqnBH+6Yg8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/c+z6KmegruLbyNGfyjixMZwUyWdHkq5CWh0MpLXGs=;
 b=wv10DLu34S6lrRfAgl6BJE2lTQHxxOXgKYhechbz/3OwfrF+9k4AYdwcLUiimiKEj55D9VnEjFPefJxfvK++UpCOV8//H9An6WxK2OObsuPXwFyCuin6hU/Ruf0VtSFyVbCStTR6+92kApHKN0JbBKc7RjVihVjtHMlAmP6YTbVRvQIbsBRrG9fWrfCH5kM/TOx0s3IXZuBW+qb+krAYJSaF4uC1aDEc49V/nBc+Nn8GeSO0KMBrQ9RAmw7VVaY5LjbWzofs3Uc4WgAzzLdHcR6X8wyfGRu2RxVCWbRjfg/tt93faihhSReKXSMjzibICCaevUDAb21gQ+xUx743+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/c+z6KmegruLbyNGfyjixMZwUyWdHkq5CWh0MpLXGs=;
 b=ebaf2Jlb/EaWmm2Gd+PxZDcTan0oslhx58nuTm3i2gZp0Npc7Iz2kotLtYAu5hjQK8tx8cLy2fwY6sGpBD/HyE34pePaRVnOBD82EUWNAuUfXpPg8S4MCt9S9xB44koGyde7kiyCJZAYfnSSUataHdzia8i2ff5RMIQ5Ac0YSFJcRLjaA1rJIURRk9A/Dr8JuqZEo2J4M1Ilg5oNcZWdCdaFQxXCGOSrawMDxhbNSsTOdJSgxsdb5eYlCsrB8Ah5Mh8kCtdoMb52U6YAbp6w+gZKvivq4EdyO971luy8hUWYXmYUlxBR20EvgvPM18q1EVli3acOxQzkUu1OIw5udw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by CH1PR12MB9599.namprd12.prod.outlook.com (2603:10b6:610:2ae::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.14; Tue, 8 Sep
 2026 10:06:15 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 10:06:15 +0000
Date: Tue, 8 Sep 2026 13:06:06 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
	Thomas Graf <tgraf@suug.ch>
Subject: Re: [PATCH v1 net 4/4] neighbour: Skip default parms when resumed in
 neightbl_dump_info().
Message-ID: <20260908100606.GC903218@shredder>
References: <20260907215853.3709987-1-kuniyu@google.com>
 <20260907215853.3709987-5-kuniyu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907215853.3709987-5-kuniyu@google.com>
X-ClientProxiedBy: FR3P281CA0201.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::13) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|CH1PR12MB9599:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e0d095e-f4cc-46e0-2356-08df0d90d1ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|6133799003|3023799007|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	56dB9IGRz6yHajtlFLnh/0f1lzZA+8hMNDTobGQBEu7aABbMBBLUGdSZ9rUyiuvDp50XICEALc8odLXj3tv5IOdS6bVPUkMMy9Yky0nxn62P5rvOxD59O5PAWr9aFkVdg/0ynHNVeMig5vBjf/li76QKeYiyD9x72L3pcTj8MmwBEN+NaD1f/fpZ0IarKxPwW90PqNAzxxvzrBiSUKkxUjt0JwR9TngICUfBKB9Uh5achmi54COD4JmSYOEycyL/U4cUweKQmbd1FEYvfuaK4Fs8H4AUnBH/OR+s5vWdzAD6tuHFuFwHN5nBsRpYTj2zbwSZjYao245Ejob+biD4CpsR4d3SFXremEIUMXTmcqjHWCjKc+mGL9qt2JFcPkxgT38J2Irn+wSlUBUYf5g6BNpP2kq8VgAhoHJAEEMRx9nFQpziJqKxWWT8lkAebKopfkJGKXPEzNEx2yo6dEK6AlsvyhsbliLBpcWadghKPEa2A+RpgEaL6qmyv3+cUe2ulk7aZkNx3z61keIs6zUxyFG7xrhpM2ton5X+zqlufDR0/TiTYmZDKd7+4bqW7Y1dbBi6sd48qdydyrutZ3rleMKI0afdrA8HRtFOqHi9jqRDr07Iz3v4SxUv/LiPnQr0hGsmdXkAn+HR4Jj/Z9D1hk7r6+q7H/rPVryg5EbD08Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(6133799003)(3023799007)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Yx1pe2XaDC/DT8M9tCgzVxSq+mLULC1ybTO+XEsBJ/eb7xo/+T39+KBdc01I?=
 =?us-ascii?Q?rc+d1uQFu3TTNJ9kWFdKLavFp7UDPIETGJEGfKbzq2Cua7P/5pH1EwHPwsIF?=
 =?us-ascii?Q?Kf7dlePUR11DODN/RnVzuQY4IPTTGsHj9e0qJ2FtidgZQrm46wIzqxOqjrI+?=
 =?us-ascii?Q?mWbtLkHOeUQciiX1RI9jpHxC2lgMuBw0jf+6bqd2pzbNd4RWjbNWL7PCJqXj?=
 =?us-ascii?Q?DVVUbSFJGN0VgVu6FpPNnBuHKDoCYQe6jboRS+9MNEWt65YT08tnwdKxKC1g?=
 =?us-ascii?Q?FErexeH3ZpaNPcft2566CFbwX8FiRHSVv16VjgMZkS69evmWMoFkKiOcJOWW?=
 =?us-ascii?Q?e764B41H1oHR/FjhNaVVEDNx0JDu5ZkJA587HqhWoL6Ja7LDLGkjyslxpaBs?=
 =?us-ascii?Q?co+gox58j2EHktBl194CxkrCclLxUoro0oiMHWotc8i53RzE1ZTLIQaKI+jw?=
 =?us-ascii?Q?ets6i1C2uY6+Dl5D97D2budodkyzxI7+KWjvgVZrta2O6pqrOwbG4i5Eqt2q?=
 =?us-ascii?Q?v7m5G/+1pCtPAeUHxRIOj10P5Vt9wwHz6qWCxmF+TUbLe2SB2XTh0yIeyR40?=
 =?us-ascii?Q?NJFjAcEC71cfWWeRc5UDoL+xze5Jj/cipuXje5pSIeSKRLxr0K1d3F3dEmB6?=
 =?us-ascii?Q?+jxO1+lyclAp6pWeAGqMQnvnTOAmnqe/5aQaDHQoUsDtMCiSafMkTZKwE9Wl?=
 =?us-ascii?Q?dzOnhp3GrlJQi6QpNtUPtKFRlaZVTWK2ehpI8MV9KiykJbC6G+xSx7Mizmf5?=
 =?us-ascii?Q?ggBwxfpWEP6JBF5iIEtofC4Lm1z8hlW6wsVoudWweAbIebPUQbRhj/q8FCJN?=
 =?us-ascii?Q?5OKw3cZNNDtZqdchArB8FRINto/WDoZMz4irN2DOYRqNBglzb0mpq1wWhYXz?=
 =?us-ascii?Q?VDnZvC/O3i2ZnSfsHQYoqXoV3I6bZL4TssbRWwmuk452b960bYk3l8jC7a0c?=
 =?us-ascii?Q?g5aACZxrULdDr2wk0pMVFrLuBVu1kR6swdoByz8pWqsNr29sbZE3naQ9wUdZ?=
 =?us-ascii?Q?76StcZti0ukCF1N5hZJRDQ8WTUxGOPcT2jJXDG73KAFiMwXgjD4A1aIJF803?=
 =?us-ascii?Q?5LYQN6KLoVnKbZ/7eeJqJY0ZlA82w55vWP+/nIC4L7/3sP9OdvcovNMn4DUF?=
 =?us-ascii?Q?X/VbCtmxbJykQLac/38PlxFmQ/Sh0CI805XMo8hPyr5QnVLypKPZmThf8RdS?=
 =?us-ascii?Q?Pt8UR0m8swGDEVMaeP0XyRRNK8TMCsJVc3iM2UCI/DrNWy3KHHytoMPwd/ur?=
 =?us-ascii?Q?5O6KSMwqJGT0zDlyP21IBjnipep38ZLJ7cHdesnyllvOlLBlK5o1yv5KZdrv?=
 =?us-ascii?Q?zP318kPiEy2b+TiUBJh3wSkpM/LoBVqH/aB9a4WXeVyDwylj2QiVqQm33sVT?=
 =?us-ascii?Q?fJlnN1jSeTzawCMb7YlYaTU9k6zd1frOIqyULh2UJyWkWCEDDx0wL1MvAYLs?=
 =?us-ascii?Q?+gKFUbXpwxLJbf4baF+G56Gfi/sK5oraOvSbKA2c6r6b3LpeaNDq47p4dy32?=
 =?us-ascii?Q?DeKVq2jXZsBkUir2PmR3o5bhJ4BLQwik5xgYH4EW8GSlBbwunEv7vUSshW16?=
 =?us-ascii?Q?jNZtqzoGGKERU3cCK+nkzZL7xzUZpCE33DuSGa68XFyx1nHlGLV5lQGE138f?=
 =?us-ascii?Q?i/n2STjWUytBSSzPlrF4R5sVAmheacV2Yak6AdvlVk/akjY8wS2cDqF9+YNv?=
 =?us-ascii?Q?qFWkxF1REi8Bv3DsoIDAS/sDtJtBxjPHX1BBME8xkYb1p+G3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e0d095e-f4cc-46e0-2356-08df0d90d1ad
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 10:06:15.5142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jVAMjCMAHlT6FGylaKE+70+GmjJaHFWBteuctDbGNLUlOPs4vIBBf/QINJYeugH/Ob1ZfgB9s1zUQ+XVrWwQ2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9599

On Mon, Sep 07, 2026 at 09:57:55PM +0000, Kuniyuki Iwashima wrote:
> neightbl_dump_info() calls neightbl_fill_info() in each loop
> to render the default parms.
> 
> If there are many devices and neightbl_fill_param_info() failed,
> neightbl_fill_info() is called again when the dump resumes:
> 
>   # ynl --family rt-neigh --dump getneightbl --output-json |
>     jq '.[] | {name: .name, ifindex: .parms.ifindex}'
>   ...
>   {
>     "name": "ndisc_cache",
>     "ifindex": null
>   }
>   ...
>   {
>     "name": "ndisc_cache",
>     "ifindex": 6
>   }
>   {
>     "name": "ndisc_cache",
>     "ifindex": null
>   }
>   {
>     "name": "ndisc_cache",
>     "ifindex": 5
>   }
> 
> Let's skip neightbl_fill_info() if it is already called in
> neightbl_dump_info().
> 
> Note that we cannot use !neigh_skip instead of !default_skip
> because default_skip == 1 && neigh_skip == 0 could be true
> if the first neightbl_fill_param_info() fails.
> 
> Fixes: c7fb64db001f ("[NETLINK]: Neighbour table configuration and statistics via rtnetlink")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
