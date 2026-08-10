Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012028.outbound.protection.outlook.com [40.93.195.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E3237F725;
	Mon, 10 Aug 2026 06:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786344848; cv=fail; b=JG7fxHgcqNstmi6Aes+oSzmExB4SHZJC+DlQD1Ivw1BQawE+kUtau7tw+Fe5Rc1XYjzFsRyDemIfpvWwZGtSaNng8/wOtDgINc0sLTa43xz9laq4lxbwQbcYEPFsSUOkYauCOjKjxaAZ5FtVdi1oVIf04TpcOfwKBcfoIuCDIn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786344848; c=relaxed/simple;
	bh=3Nxob+JX4vcxP9l6PzvYbLPoqaQYbNmOHcz63hqM/AM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eM9+oH8fIfVC4+PMoGHw8POHf6IbbKrrPGZr0679vsD2MHcZkFccQY9XCO3XpoJuC92mrtogaVfextCqUD3xCD9129R4ANod3mJX70O3XhQ+q+VTuHzI78lAk3Q/ZE3dNC6XW9lTHzjwRYdzp4bUoVfTuiY+KO/njJG+WUqCQHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i8LmhKsi; arc=fail smtp.client-ip=40.93.195.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i8LmhKsi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W6eNfv9L406aEMpPs7OArMF1L28C/A9s4Bb4cFI5JaqJw6oOC8Xdw+iBDQ8cj7AX6MmMKQMvBdPNomyB/T9RJJIYaA6AWsMS6n8IOCT6B+fgnFYzlJN6q/yDk2oC76MRIow5ojr7ywDoxIwUVe1y+9YGpcUWe6SNtwxyYlxqwelbWwjO/sXhn8N/1obrzD6BOYhMchblfQhJMJSvgYUBPwrRLvfTaiqysaviuNe203VsDVxSeSwjHaV51F1v4zyY+njvvHXDx3fAyG3mJeJqTZ1kFVWBQYRs3wNl4ymSXLG70SisxQRATuENvVsc1aHYeFaPhiW2mgxTKioQiJCAuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TVmDL0Hr2hCh1D0FgkhcNgAzoHeQ5f7G4SkCFqoIIro=;
 b=QGXZ4z+CawSzRHg/Kfk4QYMWmu0jnx61Rcs6FJ6X0QGmP+iwPrWnTEFeHNzev/ypo4E1joXthRVvF+oiPHiro6P2TlvBh3kNgwe6aA+bpjQxgWlX0aKMkB6VlP/Zg+zp271D2gdyfczvH80/MUsOxUiTD1PzjoZOs/1xp+MlM7uNY/T2i44H4nbK04oYDm3YQgOOeh6MIZF906Cu4C+qRvC2RhbaC5Y0nbzBYPH97p/XW9ZgK2JlK4/MPskALbdR7kJOfTjXdWGXBCHbbhc7nInL3bq5n1x/tZMRDqQhM2o4udmXutQB6WGQ+QRH62W9wOgpgxLfugqjDZvPrpL9dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVmDL0Hr2hCh1D0FgkhcNgAzoHeQ5f7G4SkCFqoIIro=;
 b=i8LmhKsiXrmeCbymWH7SAIwNcZGrHFbBQHZSCMPYpL+3ZPdjNA+uT8X95nuUjMt5GVTip0O5jJ752JLinluHLWWoeCcsqr5oUGZO9JNMxvHOiSOEJ4YuJSXRjVyv5QPrNfRefNOd3N5FgxsArM7HoqA2KEYs7VUSIS/CVJGl7SSu9h2IFfooptP0tPebZgkPNftzVOkSiNpFuyNYBizXRqRTUEt+Ub39/GuhV5A/qffIsDHS7DjndLyMTCBrpsCeAJHkdmFkgrlR5AdC2gqm2KyBwnf8i81nJa+OQqyL31jpu2fKFOjoVspa/DOHyGkzGFTPN1rodk1PFkZrlW4SqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SA0PR12MB7461.namprd12.prod.outlook.com (2603:10b6:806:24b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 06:54:03 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 06:54:03 +0000
Date: Mon, 10 Aug 2026 12:51:36 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Pimyn Girgis <pimyn@google.com>
Cc: dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+ded267b328e950a7c0c4@syzkaller.appspotmail.com
Subject: Re: [PATCH] ipv6: addrconf: drop "BUG: " prefix from pr_warn()
Message-ID: <20260810095136.GA2582170@shredder>
References: <20260807131300.2677228-1-pimyn@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807131300.2677228-1-pimyn@google.com>
X-ClientProxiedBy: TL2P290CA0023.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::12) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SA0PR12MB7461:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c4779f9-8097-4618-48ac-08def6ac29e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|6133799003|3023799007|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	mxYK47iR7iMvBtuRjpI/LD9O0n/9Z1FRUximWTZenjhqX/VWGCkJMr/J0/rk0aEH5e/WSMtWZnp2R2DKbfArnTBQIZAHJKQu7D+74kQiTpYb5FPOSfBZZ+rdLeNLeX/qblkhHgT8SmK/AhKP+rA/fn3MXhTPFtvbbTwPmtZt5lgafShFJQqjfAcY4xQ5J8+hKEYz2+AcOU9CUVoxRDHlxGXM13xn0M8TGVo+C5zJ506yapY6sLzfoVuNdfqMPIyFf61o3atavdizYGgpFl4bvNqrPrBA4lxWXlMNHenhfypVFUjDxTqfhdXtnfrdjbEP/NktU1bCxH/jMLwyO3u+8yMTlU+qBaDQI3jYEzKmgNimgJiF8eLr4W6BLGtaolu+ucTSSN8Wq1crIHE+Ws7rA6vTpcequlUM6CQV5G1F39MZnmwEgmLWnjmfUk27VGtlzlNq3K95Fg1lnpuzPRWYF1+3tROZDesOgnOKn5JkQ6yAfLxOb6Uuro4xPWCkFnjYeqZdKFrVT6iedjo4liVL2kTvlwxRayRDhGYt8FftgrwOlng0FoBkBrDculKgG2dBULY8sVmO0JigRpvM7hkdKGT6UNl1BxFi958chEV0WipT5fyTtfFRBHY38TyQxdxkTI5Tfq2VGbN2sBPfCj/h/9nXbBpz1sJyoKMZ2xtbSm8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(6133799003)(3023799007)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ay36fkYvr0IdPqOfDWQ0cbS8dkz19Yi6F3XNxYKpQV5ty0+SGJmNj0TBbqaj?=
 =?us-ascii?Q?1NLnBJ5RXJLi+43C28DUtePVrzmuRQAexEAvicotXaj4ZcFFAkHY8N8QJtZE?=
 =?us-ascii?Q?WpKlZAlkESdCVYfAO+LmlJqajmJ6XkvgBEpAcVD3ESPSvGaxVa9TC+sej51z?=
 =?us-ascii?Q?BR1ptAZ37GgmCa0fXnTd2sjYQnbdmx3LQ9evZy00TleHW3pqzOrXj5C7fH7u?=
 =?us-ascii?Q?X3KFcdMQOtfn2WiWHfJgiyK/cLHr5CIFmjTWqCcxycSz+vsjvR6A1tlDubAk?=
 =?us-ascii?Q?AOlFMsRe4RNMoZLUqDExYT9YQmEPz7BJ95VqjX0kccVEk69vGQ+EYoq0n+Oa?=
 =?us-ascii?Q?45WrpdWDe7h5ZkKq++1KV//2xYHgSdbPSRk6YYRQu5RWQshQT+O+B/ahAWXc?=
 =?us-ascii?Q?acCafwtPl3FvsUggaW+55/ccGwo/8Y7lysaTCzdiioa87T69zbHGxvWNUHtP?=
 =?us-ascii?Q?y4vTkNk8e7bHJW/Xo6/5/hsRANF/kLSUmiK47kZ5M7mSwdY9RHzwKwvHqa/g?=
 =?us-ascii?Q?NwpQoXK6fRNlg+Zq1v1jgF4APgqjZGN3WDpRFhjtxgEAtmh3yFiSJcHszPVf?=
 =?us-ascii?Q?quB8+M3BccOjaAJ1kMR+WGS0MyREiyzNCslL7tqwGTpPVEU0VKKNuYs0E4nl?=
 =?us-ascii?Q?BFQ2X9ZVWeaO8WPLkYtWYEQd1pXV2nX9eJAj9P5hbEzLveTRKxn644CMh73V?=
 =?us-ascii?Q?/e7ZDOw1HUtz4onE5mRvfFMmB09Q15Vd9GSX6NOSgi7X9aV6CNFq/ydMiaNF?=
 =?us-ascii?Q?mX75ZH6E1TSit36+mbModJj6E64h/Ajp96ee+OK5FVZpujKBD7DHmPuMFE++?=
 =?us-ascii?Q?SjADkZp4Y2uiKq5g8PDJnf4b1OoudBtAbJvE16pPCQOz0ZjpFq5qiTf3ZyCD?=
 =?us-ascii?Q?tVGjmqKPDKQ3uvHVjUsD98ZqpdVuI+4ahrG86QqEpuD15iP6Vujh7CSyLs34?=
 =?us-ascii?Q?F4aO2+BFPhjNexpyVMogy6b4NMx3AZC45A01/IgFujlLoLHrkRPCeHBU+oWu?=
 =?us-ascii?Q?jl4wG2KiVD2U9k53VzsplI/9Cg59JMC+q9CddZcrm52x9+o5jOSTfonb3l9Q?=
 =?us-ascii?Q?1BN52fSnZcKgpT/Qgo2SqQ7thc1BrK5KEbc8frqTQ46dEQcOE6tze/FnMFGh?=
 =?us-ascii?Q?hQk5OWVmqxh9eRz3NoPtDHEVJOMD7UkQxSeg7OtmFwmo1XDnW/QT7ObgJSSp?=
 =?us-ascii?Q?+rVqD/yKEd91na/IEJKDog3Qi9V1VJMl8mOBNOSXtxXU6sci2EM3yx4ERypL?=
 =?us-ascii?Q?ezcgmAbBgWGz2/eJ7dNIY6zzM54B5okS6FtBOB21c4QXBtKL6czbhRaeLlMw?=
 =?us-ascii?Q?7Dq2iIzXxJJyMA1FkRNFemhcJpMJpuYAx7z7X1QmA8VhgSI+i4MXSwfcNH1S?=
 =?us-ascii?Q?tagLlEzkPVyVWt+80KscNq6WS/ciGjBW+EzufSIvQBi/2Jj7p3NzRdL8JrlZ?=
 =?us-ascii?Q?OVgTWH/nSAHRg23OHhpR6GKOIQRaiuKDANYpdVE7IK3EF1F6zXtSHd9BFsEn?=
 =?us-ascii?Q?4ZOFN32Uqa5HYieN28PcZnfTd7XZfEv6nWYS1j1FW8Er6mYGVtZIu2ahfMAn?=
 =?us-ascii?Q?Jxo8gnHZJRGUA/uu5hirpdN+p+vGTTe4u543a6F0kA5ny7rkbCUGU7b4Wfd/?=
 =?us-ascii?Q?jw8TOklPW9GQa8BIyd1h13qK8zzz4wRFTvdcQGvg9n5FqxWvbYj/d+TLcOEG?=
 =?us-ascii?Q?nB5UQx8zCpS1LJsLxXf2LfFeoOsuUdCsyIfJcgks5eXpj0ew?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c4779f9-8097-4618-48ac-08def6ac29e6
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 06:54:03.3166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uRK2WSppjsL2+v59TY1/K/0I9jvQ3uSIUbG8BjT761CWJmmGGWpldQ9FgeeYWrdCYhKkJ0oitIqp+NK+mOIZdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7461

On Fri, Aug 07, 2026 at 03:13:00PM +0200, Pimyn Girgis wrote:
> Kernel warning messages emitted via pr_warn() already have the
> appropriate log level (KERN_WARNING) and should not include manual
> prefixes such as "BUG: " or "WARNING: ".
> 
> Explicit "BUG: " prefixes in log strings can mislead testing tools
> like syzkaller, which scan kernel console output for "BUG: " to
> identify kernel oopses, panics, and fatal conditions.
> 
> Remove the manual "BUG: " prefix from the pr_warn() call in
> __ipv6_ifa_notify().
> 
> Fixes: 2d819d250a1393 ("ipv6: Handle missing host route in __ipv6_ifa_notify")
> Reported-by: syzbot+ded267b328e950a7c0c4@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=ded267b328e950a7c0c4
> Signed-off-by: Pimyn Girgis <pimyn@google.com>

I am able to reproduce this (there is no reproducer from syzbot, so I'm
not sure if it's the same one) and will investigate if we can avoid
getting into this state. If so, there wouldn't be any need to touch this
message.

Currently busy with more pressing issues, so this will take a while.
