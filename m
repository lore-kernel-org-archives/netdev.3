Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010052.outbound.protection.outlook.com [52.101.201.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B076C175A60;
	Mon, 27 Jul 2026 07:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785136948; cv=fail; b=G9PmL5TH83AI+xpXZfSO8AaUP10VB1Nnm9lmc1BR+D4A97J1tK7scniwX145za1SHvr39sWoawCMEZZIpwLY2NCURhAEQ17hiPRhvUUOXRtk73KZQ/QB0pAz550GMw/Bxl0vOQYepE0FEHcMBNy1XtqrD0RBHzVpL3dvCxAoOq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785136948; c=relaxed/simple;
	bh=dLcL9HTViRYbDIrXAeT7zDIxPuroS7RwTtXVk680KpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HWNYkswDRfLqL8wjs+pL++npBMCVNpO8r0xzz1zI4vm6Sw9hmsil810sc3y3VYD/UE3UotJaloLIZTmtymCweUPidVsbxYR8Mr+8d8VXRkqh9OTFxW5evgbujGJCzROgenxC9GhG07bb2yOYSUdZQUh0vLTEcowGoAmZ56M0MeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Vb27Qd/Z; arc=fail smtp.client-ip=52.101.201.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Vb27Qd/Z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hHsiGWT0KghxLVEBX8iUORAV0avqsiWFaS3/Bq4Ay8QW7W2CSRydH0ieEKK0+ebnORgcSy/mLrwTvCxz0SuNZopojDqj+xh0mNGOgn/R6Bdgqohzl+2mEES4nfV8REwHVhJlg9rLcze9lKCdFjgg4TS1Wsrc0rPUp8ioQLKzDiRJiS+CayrxU1oVMH+3ib4eh40Cevqji3aS7dWZ8PTb1iNAiGI6FkRI0n/0xrxUnuEXHvAPpVOrOoISOL/x40zboCCOzijRFBOR8BNe3dxiCgqpdKfLx3rxT988zBel3DAX+lodzp44eD8afDigr5SJWLSCN7FLjbNDyu8sebIHyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zAA/HkBeGtniNLAl+YtvJB8g0MXX+AEXUsSm19oHFTY=;
 b=eVbUdKM82NCpkMuVOFTHdVAIRkGtEQSY0w0pXFSLgN+7tpfGbDAot72Z8MqaVWWiEkSayNvTElsjisRSfs05w8ESq53zKpiSyqbS1vvjAhh/Ft47FqTrN4Lyvu2wwSX0GLpWNISTiFp4fI/2VgxvOwdvlN31gZl0e5tfiGFkQONczWC4QTOeHNTs514rxpLpwuS81eVzvplSPf+4NGhwMYUXYYss5kZyOsmjCgjeVaArWNhTD8FGBJtlOexBaBQJGKxraFFrKJWcCcdX5xSFpmPCk/JOdwY7x3aTlHU7Zd7NfbA9JaXtGxMX/UA5Xy7yiopTSkhgzlWOrMNq9imVCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zAA/HkBeGtniNLAl+YtvJB8g0MXX+AEXUsSm19oHFTY=;
 b=Vb27Qd/Z0i8YhT6pXo1MkDO+lh4xKODnF/M7Jv9hwPNJ1/EwupL8ULAeWWdZ2d03BnSAhbpv4xsOnwIEVL2gD7dHugs9s3HYtuxtmP3a0R/mOF/Fdtpzi6s+oTYBpwMWTGwGPHAku8bpm9JJV/FaX7ZmWf1UXwU1Z8AfnfeARXQQEq1Udhil5LevvJ/iSONII+yVCdGa03vFNf8j4zxFtdSYYcdXB6xgw7GtZDdgxijvIvgY0pqagAqtVimL0uXISaq5MRgbmDz8M9ANJcZQg7lBR3RAPdIfYJw2ID6TddWmyWwnLjMtc5U4pTbkmgu13psrQNDedH8EHXNhOpV95A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SJ5PPF4C62B9E70.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::991) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 07:22:24 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 07:22:24 +0000
Date: Mon, 27 Jul 2026 10:22:15 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: luoqing <l1138897701@163.com>
Cc: dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net/ipv4: fix NULL pointer deref in
 nh_valid_get_del_req()
Message-ID: <20260727072215.GA458701@shredder>
References: <20260727022619.198914-1-l1138897701@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727022619.198914-1-l1138897701@163.com>
X-ClientProxiedBy: FR2P281CA0124.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::18) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SJ5PPF4C62B9E70:EE_
X-MS-Office365-Filtering-Correlation-Id: bd6f5220-3cb0-4e5d-5735-08deebafcdf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|10067099003|11063799006|6133799003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	N1zcoPBMLv/+KKzPp/3n10ZaWOuck880kMdgzHoDewBNOqaaOhWZ2Ye/cIyEJcIEkhBG11ljP+mtT8xlYxq4MCjtgwjjT0xrtqqZwmmm2ABHj1lCvj1Lh0rdj3N/SNDLsHrg5TEfk86UE/JPrUUWB5oCD1V+mR9PstoP29F8HIf0jxN2R/lkgkuaX3Is5eAQNK5L9DQjWRi0f2CenXNjacQH7KdsF8eY0TI0KxXfUf6S03kjXWVWOVYygNCvE5u8DYlWzNLGHivyM93kbsyn6W0pnnnmsAo1HPpL56YsoSTTDwlwK6+fFZSEWhIJopBly1pHUPY45ZZ0lmJTHVc49U5BBLhtC9E5swZfFyzAlYShwHtW3mOhXzP5ccwux0U7/34ruWLbIvq+6/dzc908XkkNgQLpe8U+nIgJCamKn8C/L8nmQxyLaSIERXwJ4XIMCC9isJI7n+WOS2/XdSDZX7B0GHdXgK1hUXqUDJFLFFAaDo/lgF/N1MMPC5WRATqYBkvRJogIonaczUUAxEypgVuv2RnbLCMqyDdoSjQTMm4aI3MaOXOXXcR3poerHhLRVP4nM9hPcwgfIAI+L7DVoDJXW8WMgpxj0Z8LrUOFGhDyLG190Ytbwhid81L9uutXPcaceP6d1x4UqKvb13Y79wOV2eqmhOK5it1qEenIiB4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(11063799006)(6133799003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1gZYPrhS5EaXvTW8NzJkFa4mjglpvF2VOrSgQyUD+f4Yqf1k5u/vH3yr40Vq?=
 =?us-ascii?Q?k7YQnS9SLYjo3v4TyygXXINho1hchKU+kBy6NasXd9YH/3uvP5WG5AuyIYEh?=
 =?us-ascii?Q?R1ck1Zkqd4biNUkWSI7aIiXAV88Xk7XYRd13hEyX9OaaLSHSh6DhGFtRZRVM?=
 =?us-ascii?Q?61nNdRxkGilHrtzFnF4CO3zTKlDos3X0Y9XDY1CBMpu3Xaj3c29MNsq+KEax?=
 =?us-ascii?Q?pV7stEfYc0xaHSEtyPJ777qhLLnJ4dm+i1f06uDCHRKvJbN84cOYAHVRDXM3?=
 =?us-ascii?Q?iNCGLzmIJOHBvIx4dRfw6a0UV60by2Zq5mekgSThA/2K3YTx2o/oFBL9T/5Y?=
 =?us-ascii?Q?ecc86XTw1wzxABOT5/qCFD1rAPgEa/wjqA3hgfGWOIVTNHg6C77xGyx2juQw?=
 =?us-ascii?Q?KvQjR4l3HLcbN5HYStWvd1WhzJB0pklWhv6w54Ejxp8KvBJlZ5yLT+kMYr2u?=
 =?us-ascii?Q?z0a5CJ3x6UajSw5tfnCxISLwVOHqqb+AoOz/HnU2ClqOXQn4amN7iW9DF+9h?=
 =?us-ascii?Q?5zfkDKWTUnsoMKa+jQK5qJ3b/T6Yiy2v5atsEJeGUsSU2wSE1nJrxoWOjBjx?=
 =?us-ascii?Q?sWn2wc9VMSMd6Hr8GAKhWq51UMcifP4OteOLt/6cYp7QS6Qc5pIc31hslxWd?=
 =?us-ascii?Q?Ev/xiRluehnEG/hwTyqC6l+uTQ4OkAGSQwW1Xw9euiH4UBY8hGoraw58wP45?=
 =?us-ascii?Q?uMBSHMr9yB2AEPbOtUPHtsWc1StL+sUmy6FHdwsKQ/bsqZ/yJ3E2TPf5AR4I?=
 =?us-ascii?Q?RLo3t0fT1iYOJ/l6rkzDnWY5o6lQrD12x/dEL3rltkOPx2a5OGL7Fd2vKoh7?=
 =?us-ascii?Q?T9QeTrJ7uzLBNX4iQ8ctuJ73drH0Gz/Zr6k6iG0NulqotCz5Z68kobZzvp2J?=
 =?us-ascii?Q?YUYIiskCK9tYm3Jj31l9s0giI4O4HSW1m8bt/I6ebci6CO4prf7/+dp8TzPs?=
 =?us-ascii?Q?XKTHC1ZW15rF71xIEH6C0qt6q6kmZykr9oTerim04Y5OGwaTptUT98xtFE7T?=
 =?us-ascii?Q?BgG8WWyFKxrAYwnyIe3456pkXEf1wqn3EqKsL3S4xYvXjxNshNiswOUfQSv6?=
 =?us-ascii?Q?19e3BnF69eiGA4ReSTF8UYVULxsnRPKA/EnJwVQh7j8p4ARjTkwHFHgVwlIm?=
 =?us-ascii?Q?8XCSUPvB7O0IeiFJ8IDGEeIvtbSRmn0AXpeZorGqYzoAZ8JiOS3I05mWaj/h?=
 =?us-ascii?Q?siH9n4F3MAFpXCQykL5ctQ3gO+tfz7a/x6LYF1lye/tFDMLfDTJjnQ10DNcT?=
 =?us-ascii?Q?U2HOYweChBpKz1cywzUt15BvOosiarXmKGXlJEaQzBwm+7ccDkS9fI4mEtz6?=
 =?us-ascii?Q?qYdyAXKgMe9w8Wrg8jfRxN31okoZ0uN2RDJHY3utWCtoBbkWqeeIFvpGAGzy?=
 =?us-ascii?Q?gJTlK7SALcJlScJOTWkJ8H+NcJMhOyRkgs6y39TeMNKPPiP9eyTNdbmBIxR5?=
 =?us-ascii?Q?FURv0w+SLcG68/Vk0azqFhYmqiziYrrjxryWEld27+tAPlFo3SCvWQnSbqCP?=
 =?us-ascii?Q?BX3ZNElx9ljpq0VZbi1burjjvSPb8rj5oYbz7Kzo97PGaVvSdB1lSlee7jpC?=
 =?us-ascii?Q?rQs/CXOgi8i1WogHud/98raEtDm5mh1Zy/q3Az/RZxUWKot1LCLZM2Hxq3rY?=
 =?us-ascii?Q?AXJKzwHwQXnuKDllnSKf1k/L0YPUZxSvxViMw6ZzN642RQ5PQf3wy5xDtPwi?=
 =?us-ascii?Q?Zux2ftC3TfkPepdDH2lACzSEbnbopLCpDPAe0GfvHjl0Z5US?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd6f5220-3cb0-4e5d-5735-08deebafcdf1
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 07:22:24.1059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z2qTOWZV0OnGQit7gIeN/h+T4FbkkDEJUA9cG1jKjYEIPYwN+NXX0x6GSkLjU7GBnuIN3f47O9lSPeHRHOwTNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF4C62B9E70

On Mon, Jul 27, 2026 at 10:26:19AM +0800, luoqing wrote:
> From: Qing Luo <luoqing@kylinos.cn>
> 
> rtm_del_nexthop() and nh_valid_get_bucket_req() declare their nlattr
> tb arrays sized to ARRAY_SIZE(rtm_nh_policy_del) and
> ARRAY_SIZE(rtm_nh_policy_get_bucket) respectively.  Both policies lack
> an entry for NHA_OP_FLAGS, so the tb arrays are smaller than what
> nh_valid_get_del_req() accesses via tb[NHA_OP_FLAGS].

But nh_valid_get_del_req() only accesses tb[NHA_OP_FLAGS] when
'op_flags' is not NULL and both rtm_del_nexthop() and
nh_valid_get_bucket_req() pass NULL, so I don't see how this bug can
happen?

> 
> This causes an out-of-bounds stack read.  The garbage pointer value
> read from beyond the tb array is then dereferenced in nla_get_u32(),
> triggering a NULL pointer dereference panic.
> 
> The bug was introduced when commit 8682b7dd4f6c ("nexthop: Fix

This hash doesn't exist and it differs from the one below.

> out-of-bounds access during attribute validation") shrank the tb
> arrays from NHA_MAX+1 to ARRAY_SIZE(policy), but the policies were
> not updated to include NHA_OP_FLAGS even though nh_valid_get_del_req()
> already accessed that attribute.
> 
> Add [NHA_OP_FLAGS] entries to rtm_nh_policy_del and
> rtm_nh_policy_get_bucket so the tb arrays are large enough.
> 
> [  647.535111] BUG: kernel NULL pointer dereference, address: 000000000000000a
> [  647.542066] #PF: supervisor read access in kernel mode
> [  647.547197] #PF: error_code(0x0000) - not-present page
> [  647.559218] CPU: 0 PID: 42929 Comm: ip Not tainted 6.6.144 #1

6.6.144 doesn't even support NHA_OP_FLAGS and doesn't have
rtm_nh_policy_del. Can you reproduce the bug with net.git?

> [  647.579548] RIP: 0010:nh_valid_get_del_req+0x38/0xc0
> [  647.998839] Kernel panic - not syncing: Fatal exception
> 
> Fixes: d8a21070b6e1 ("nexthop: Fix out-of-bounds access during attribute validation")
> Signed-off-by: Qing Luo <luoqing@kylinos.cn>
