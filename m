Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010039.outbound.protection.outlook.com [52.101.85.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB9C3FD96B;
	Mon, 27 Jul 2026 12:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785156897; cv=fail; b=R5PxwlPMt1kQwMy3HDpB4c9OM/F4UvfEaJnI2Wc82CYk+dSahR9vtZqMTzAZZbDeYm/cxjAbw8mhnD1nc6ezLOpgUbTLRviYlqTy/F20v0Wo3kXN6mV+u5qlnfmnai83nXldaLDDCQQKEj2mj0bV2jX1UHm6yBH2nekXT73dRMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785156897; c=relaxed/simple;
	bh=AKFfDbAol8xed0LWDJebsGGfGTPTtw/LcWIJvElDyAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=H6tNH+btOcZBLnOmU7pcwz1qiku6lKLTekP3XW5WO8ZwZwYMbYPcTxoEPa5SvPZIIAIoOp/NuXxONlT8wQUxvV3LYs6SnB/b7LIgWGnRwO55frk3yg9dbP8GTndpixVVIPcG4szEeoHbhW8AArv5mKDew21E1lC7KcbLqATPFQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=slWS7ytd; arc=fail smtp.client-ip=52.101.85.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="slWS7ytd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KynP7QBOfzjuCXdAxDJuEIbLNTY+BtY+yYCNA/X92ar0vGJ7exyL2+A/qbAdDHfknBVpPMXopHgzD9/Akp20/KS/MW1lhg3C8sAcMQM3BUXy3jcWl9h/9PCRQujtlL+iDp537uC634v22DvLRsF8/LQoP06myAQHSwTpXI7qVC5//Kmu5TcDOL0q/Z3ULX3WJrDZ45tpV3DgRaZhXpIMwuKOL58zfst7bAy4ZfLLC4oRq6EZJkTU5Tx2Cos4fwTz/zj3519cDmrUTm0L5xiSFfbG6sSTi3dkUek5/In7OZRNBkvqiBnIJAp/daUq86A/mqVum4g5wWFvYmBBjRhMYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OKHfnQn8QrrUvAfP0NAt3wFikIjLSwKOVgtE/zeXQKY=;
 b=J/lVgfmSJigUmGkR1HXGjYxcKOzzpO0BFnB8tRmQ0wNBn+XCrYUam0vs0c4YWNaVtQHAn89IZNWXECTopCJGkqrpnZ9TMIu1HwXLjYNmxqJMcJwYWr9Br1tFqKFsZWiHzexPEqUw/E+X3DxRfGDmwfivJyTK3sL3AAge9uThXkoPpbQ31nrfqH3h2Rbmx9FIp1BfJnGR9FRHi8w0sq11RrlDZLwPjCHWPG5ZjkyW//ki5Bvxy348ZBg42z7SNBIvk14hjWFrAwbX71VOOC6YNk1LYBla4HMZokJWva5Cmd3Mea4pxKGCDfGYUpFyo4vyqnfTiEvIr1fHj/j+fLSMBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKHfnQn8QrrUvAfP0NAt3wFikIjLSwKOVgtE/zeXQKY=;
 b=slWS7ytdEwqIVZPWuyqjiZICesI2abYcMy1tcbh6exGXUOPjBu1xu4SLUmuF7FDbplKFxHO8JtpLz/V1wTDTsJBWSvnqjnm2qBgKjKKYBTBQe5hL8F9KsONhNjdXIIr2Owb0Yux6YEdU6z17Pi2mJ2kVOD8kt5sm6sZwvzvl+XpDerGO5XaqDkUa7YzZHvlERDqiL+Qag1KXrgMrjtcR8AwgoMVTU1ZHjhthgIsmXuhyENn7K5EXpaD6d7z7hzBsTuVV7iuRZVor8UKEErY+ux+oehj+O2S0XaaSSjxDNSHVx5SFAgdyqn4Zs91+WyVYT+C+7+GXGr563EzyQtZ6xQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by IA1PR12MB6067.namprd12.prod.outlook.com (2603:10b6:208:3ed::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 12:54:51 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 12:54:51 +0000
Date: Mon, 27 Jul 2026 15:54:43 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Minhong He <heminhong@kylinos.cn>
Cc: dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	ap420073@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ipv6: mld: use ma_put() after canceling mca delayed
 work
Message-ID: <20260727125443.GA623641@shredder>
References: <20260727094107.168272-1-heminhong@kylinos.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727094107.168272-1-heminhong@kylinos.cn>
X-ClientProxiedBy: FR4P281CA0001.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::15) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|IA1PR12MB6067:EE_
X-MS-Office365-Filtering-Correlation-Id: b7d24e26-d1f2-42ef-9e19-08deebde3fa0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	aGQEdTothA/B2Cv+Us0CVZ4AaCQPx7ZBH0ugQqQc8q0LXqh+P+5WqJRBq9EPUWJFYGUM+58MYLSuRFVLHdIvBD+9GDgZgqMiWN5v4jNzgK9BAKiJ+6K9Yby8cbDl1hQgqD4J/lVGEtJye0SyxQO+bsRO/h6/73B1UfTqXV2kkNEpS/ApH2c0me1RQaNGQx9Ck651zc0QCOhEttBKYIhMij/HPxeFmTT0ZFtUEQiu28y3XhpxC2HzpQry1kUDs/8vodh0KZVXaITny583GTayXeN3Cf9SZaZqcqfkMmHD/P/AkizqWkyM7Hd6pVIo/g2Hry373Ux/8lPiw9pJB1ypo83gaDUT/8OqtpjTRj2QMs4Vv2vMG80mKArUAa+nS/MElrQVSoQ7RWXvMveN3pj9qxPfvH1hcHcg9Izkzi//5FBZcqI2eysc2bxAiCYtfuLX53v/ViAGuffJ2x4BBysSZK/ODp7s7Hz3Ss3wUktATt1+RIGZjjGyvF/9g6QWu2+h1loxcA2Qk3WOq61HnR0s3leKuZnMz5VprCaUqoEPbdsRwo+qpTlHxycmpkctnwdlGWwDRwElYJHGGP4QHqQN4l4oZ07fTvdm7AV2Rf3ZUitfng44tY4uc9Dq53AGYp0oxP2SIrw7MHjBft9qoT1D6oyfwX5rWtZcLhHex3gq8DU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I+7sx4YNFEE5qT1ha317DpxQoebaMxk64Rt59zpUFQ+1Ugxdt2d7fSIDTiw3?=
 =?us-ascii?Q?stmtP/3jhTuzoqMslYcf8vONY4gTQ+I/UDOBAYFewyYzyYnzDzSoYeaqFVo8?=
 =?us-ascii?Q?gYH/zbNCfuHWv3LBGb8v2dqb32709gDYTw1lcpyxVWw/0IAkfezrOdAUoIXX?=
 =?us-ascii?Q?je0b1a8tn86naF21muRgkya/6lxnk0XayOWiuTm+OhiEIQU2Mac07qUUDmeg?=
 =?us-ascii?Q?+OuqY+WNax9P9Q4/ID7AmSyH7hB8ADWrvI+SSZiXvn/cbgarKKHPxdrxJaiQ?=
 =?us-ascii?Q?FYk1SRw8wCC/pVgv/pgjaC3k//gOtjMTgCkbJwz84nvQxqtCCuMnmEVk4e+e?=
 =?us-ascii?Q?dQZi9krhubUdM8MfdYbDIlGdWMD++MdS065N1d087lZ3JTOdK4LWoAI+VrVO?=
 =?us-ascii?Q?dpjvco9VDL3gzvwOAY9XYvCukPR4PpDS2N0qDKzlFYFVJdaIsKXDrctw6Vpx?=
 =?us-ascii?Q?4E7nRONYtTkC5R/+Kb4CpklzhrcGoCjrd7hKrV55m+07cDsc0GmCittvqUmO?=
 =?us-ascii?Q?lZU/JbTTYxaaAXv09Kbihghm1DVIFZnmEWcqoqSbKBa8xtt126AFOwZ7ykIj?=
 =?us-ascii?Q?GNj/LtX44DHPrgYEikHvuawiv3GWYDvIaj5SlpTpHUMITaus8RLj82LnHGrx?=
 =?us-ascii?Q?3KK4ejD+HS3GKNqJd8w+Cl+TeuwhEAjWjPnhAYqJxkls+21O37MNYZ3Dm4TP?=
 =?us-ascii?Q?u7kqslEMiCJYhomJ1kM2dv9VwcsU709KlUGkh2lYhVEwf/lZZOcIutv6DVKO?=
 =?us-ascii?Q?VOfHtP9lqz5PMKpLdMsFlM6l3GUHuPVNKt46uePJAlhkdhEMY2Gxsho++yNZ?=
 =?us-ascii?Q?e1CHd55WOzlOxi5qNn75j3/DlhLFrDCZSpjaaBsa0atLKkLpTSC7foTPNdPd?=
 =?us-ascii?Q?QUhN+cPTt0Db9oav4dmQeRoA6WkP2E5jZH240n580J5ECisjbOqN4ADLHBes?=
 =?us-ascii?Q?Mae71IHHOrwApuFmrskHIIEJEqixS4J5E5ZTaWvom2vgt7to8c0vFJ8ytO9f?=
 =?us-ascii?Q?FCAUYZ94cIXEecB7azN5TDB+EzCa8CKtQaOf2k7l3o/kafBnd/mkhcfvED24?=
 =?us-ascii?Q?POMCUpu0jEwiBob6MLl3moECFxnsTiJobCT54vIutjjw3OKQ1iZ/9RZEr0nL?=
 =?us-ascii?Q?5lg3iia+UPcEdJkYJaHPJMC5eMfLDEfYVSq48UPe/Zoi5vLR4A91pe+5rbM+?=
 =?us-ascii?Q?Wdd6LvFoodYplkCD3fDRVrAOR+3S56OlysZvPX7vEe0nPl+1muU6LP9i8+0y?=
 =?us-ascii?Q?9GJL3kh8N4yZWb6jEkX77iOGZ0xwL/Ky7PVVe2dfpU6Gdo706QnyjMA10PZd?=
 =?us-ascii?Q?R2mt40ZIR5gXy6mPFIUH+eXtROLhzL+QcI9vz/uYVNRtEzo4zT7dwmmykv0V?=
 =?us-ascii?Q?wvVv46Rx3eb4LUu70LLyO7282ZZI9Kco8N1j9CdhYUosVXjWZC7x/yBuyXIw?=
 =?us-ascii?Q?4ihyo2LK6xmmQOsrt8Sggp8pDTTvtgHlpJHvZS92j2YhcOucn1Snv8Ar7P3V?=
 =?us-ascii?Q?W4sVuIKJtT3JBh9BlA4TME88hG8LbvwvyQOfW6mWh8lHQ14bEXEixxHHQdED?=
 =?us-ascii?Q?xW/fysTDCUihr7OdAX9nl6cT2ZQW1AbdkWEYKyzok3MmEaQbeuc0s7hhUcQF?=
 =?us-ascii?Q?v2AuZjWswftg5pREe/s9i0q1m1g+sboUNLPLIQNDF92LLfGzlvOWwkwNX/kr?=
 =?us-ascii?Q?nzzcDHj+18Ttcugr2z3Ocuvh9zAVL4Zl0UTzjbEskgOmx3oG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7d24e26-d1f2-42ef-9e19-08deebde3fa0
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 12:54:51.7075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TVHkJgA1v4cKVfLjevF4zD1ZjQJENlE1uyZhJkJ6aT9g4+L6rBPKfUJaI8srfoj6zKZNho3ZkTAo0QgGS1OHPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6067

On Mon, Jul 27, 2026 at 05:41:07PM +0800, Minhong He wrote:
> When cancel_delayed_work() succeeds, MLD drops the work reference with
> refcount_dec(). Unlike ma_put(), that does not free the ifmcaddr6 when
> the count reaches zero.
> 
> Use ma_put() on stop paths. On restart paths, re-arm the delayed work
> before dropping the old reference, matching the ordering used for IPv4
> IGMP timer updates.
> 
> Similar to commit 3546deaa0c30 ("ipv4: igmp: Fix potential memory leaks
> in igmp_mod_timer() and igmp_stop_timer()").

In IPv4 the readers grab the multicast group from in_dev->mc_list using
RCU so they could race with the removal of the group from the list. In
IPv6, AFAICT, the readers iterate over the list using the idev->mc_lock
mutex, so I don't see how the same race can happen there.
