Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011021.outbound.protection.outlook.com [40.107.208.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A094B48094F
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 11:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784634026; cv=fail; b=qXoeYrit2yTAJmZex0Ya3+EfR++RlYCvrErystZDv9X5cvPN3U2WelKt0eO8/feBano7n0XEt0xc/obzON46G2U+R2vXI7paPh0CWQIXLvMwJ/uLSg356ArWNnhb99e8qt9yF/rDEw5FEzGVjvSYOfA55Kw+gwZCFWjY36qlME8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784634026; c=relaxed/simple;
	bh=U4cNJGaFbntyCtIGTQaUuVFzaZI+dUz1UM0yo+XulOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=USxi05+wb0UghO2d+gqr8DE1fzGChcquyFP6C/baRgSBK89k4sZMJTMUgrTlPkVhJsgaPDlcFKObYlHPyV7JavhZ+9Hk4UMZgDTPwY6C0cJ8J1FvZufDdgS/yueaVwiu0r2L6FJglGQf9G/klX5gTEVO/dSvY4kT173vgJdARCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SBP7mDxn; arc=fail smtp.client-ip=40.107.208.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SBP7mDxn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OiGBhkkMYpwitp1fnOshg6aGgY4yRM+ej3aOVH6bRneb1DefflelrKvrLoCSdKxuJ2an7n9Y8z0EdqdX6cWwgrkW8HOiTEpQgZsI4kRGfutawWV2uvz1bkqwDzPATK7U/22SjkHageXQWNoDLdBGS69s/ysZB+45jId/ZwX10CLLe6daBdA0tSnA21yuDfMFQ+RQxl0rl+qST0MvNKnQe2+Yv/RnC/DyB0akZ+uDTWr1k2XQL6hqiY6E8weQvdFLFeyCOnOPKevcDYRv86wed3ckrOiG5M7qpsjAszFKOeT0IyaKIlS7i4acPr9YGb10cigOUVLHNsF4N5pHsWETvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LGWIdNol6bII48CTn2LANJ4JAHZI1k+E3YWoAXzTEkw=;
 b=TrqjxxougRfLJ1ZFUkeAN1u/WRE6eolNe7LulOSHvGkOS1UJbrsrKeTDw5vQZuIEDKi7W4c0GR64gbjAp5JFtZfpykXrPLDJ/NVpGAnIH4i0RScAaLIYz+Vn+LIJDttmoiTNS3eFaDGhxOk+SBBD7Tf+rwETaLY7deFW4Coeodj3Yf9GhX5CmBfedAvX9qPmAibmQWRDzrjJVN26ypXBMDs1q4s3VE5WLZlXXFoliCFI/NHobRqaCZyVlyain9H6oSyqW08QCD6OVl3K/kMsfPTTNPwS7+u1cUKP96T4IX5pNgRhErUKJ6wCcVSiIrTAZt+CFbBizaHSFnG+hChOMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LGWIdNol6bII48CTn2LANJ4JAHZI1k+E3YWoAXzTEkw=;
 b=SBP7mDxnmLa1DtZe7saWey+/rSpheRFxaskAXzKW/zRY19Tm23Pb1s/FLU4YH3gptaVPBh0S/lKvGSurfiqAV/Eqm3S4+P3QkDT+i9USYutcikVQWgXTI7jMN6q6enprM288ilr8u5XL/wSeYGfKAG8bDQxT02oKMxxxmgTnwKPJIdOm2uIxaehVkKu1TDc/7rWtFPiibww2HtwHZDHjjZ2Fgwcp+Z3ckDSMJarBVXKat3KAAI/C4xv+6NevT2jv6cO7NR3WpJRg+jSGIrA4Av90Axnx67pXwVfmEcfrFPPln0qXR++PuZCvgtJsjzhlh+6NZipaEB8FcgXnNJBIiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by BL1PR12MB5756.namprd12.prod.outlook.com (2603:10b6:208:393::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Tue, 21 Jul
 2026 11:40:19 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 11:40:19 +0000
Date: Tue, 21 Jul 2026 14:40:07 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
	dsahern@kernel.org
Subject: Re: [PATCH 2/3 net-next] ipv6: remove unnecessary reset of position
 pointer
Message-ID: <20260721114007.GB2592863@shredder>
References: <20260716203713.17392-1-fmancera@suse.de>
 <20260716203713.17392-3-fmancera@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716203713.17392-3-fmancera@suse.de>
X-ClientProxiedBy: FR3P281CA0024.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::15) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|BL1PR12MB5756:EE_
X-MS-Office365-Filtering-Correlation-Id: 54f1c835-8efe-4824-2ba4-08dee71cd748
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|6133799003|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	AZAlT1ZvKuU5fLu/PHXD/vxVZke+ruDr2HyC1aHLd/RciP/I80RxVsbAKynTaDe20UJC2J420ZpEC08ojG8ppDA1+McTyKaTnG9xULFtWA6RapufuDkdQIDFTu6i/j4KABJ02LUj9ajtjLruCj8XtuBdXY/ebTLtqELb6PG6giurmm6MDQ1dmsCCR820/8RjJ61ifIeUCp7lWJBSe7AwlcdOGyeMFMmkDr6XXpxvuHcZuyVGVftm6Hph2kiJwn3wr9habXf93JDONXiBEoiVMJVzAAwP6YfAhXwFkunGD0TAGV127bqBSs+iLvZQ3VVdlwF7ZnYMOAkdpZ6HZudnl2vphH0FQn59ef/QBOxCBz/3KveBOAhmiTBCEETCO1hvwGLIYQM8cHMNaIOY01PMnQEgGN8pvN9Y4v1jQ0U6ONsuz6H9nE5ZHneOQwOV8ZA3MHPUXQ8ElWgMxMvST4ya/BkaQHLHacsQa1CkUrs05EjiM2btS+sdZgRt3fOLeSKnTMYhnoiximElV7O0FGhjmf48yUHsWr5hldh4Ow7mI/ZOdiRXdFt4YMVrBXvYXZWYkl7crNLyNcUU+MKhcXvopwGnd3GhkpiKFR9bLZ6vcvuZ3pxJlxEBG0c7Btjk1kN9bCadpSn1K8ko6Ud3717PLATRTpylMqmPDGd/suQ6e2I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(6133799003)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rTUoNUWv7K/dmxQomwbat3BPY7quHK2lTMDJhT1DbXGJ6IwNcg3hK+ktri7P?=
 =?us-ascii?Q?eOyINk15EHmfg9hCn7/v4ooGtdP1Yvnd6R1p/Pe2OG2PFUkJgaHH/COhdmtK?=
 =?us-ascii?Q?WpFhpZPzX/Gc8ehPT9LVrTENYZGkkce/doJBjZ1ZG27OKDLpf9Lcb4B9LVAi?=
 =?us-ascii?Q?lVGeydkFQ09VsNeL6KphjqGnaTdEARIDU55iNB7LFFT/YdHs6z4TRa/Io1m+?=
 =?us-ascii?Q?ANmpqsNGCg4hkqfnLuhQvkzI1UfJQ+K+0bwkbcKQwtJiw7IqFiThP4CLXsve?=
 =?us-ascii?Q?+seVNbR12c8gbzd594DY1mo73MljA7h0W3SKdkbAW4sL2tCyEO9/CAnc0GjK?=
 =?us-ascii?Q?Is1uqguqS9TsmphWA+O6YzxM7sun/0q1kLXbDyzLRvxbOGolwO9AlW6BY06w?=
 =?us-ascii?Q?ByawHUB5sd2f/Xp54E92ngKuJ90Otewe/62pg53gN44FKq8lvQm8j+CCjpVY?=
 =?us-ascii?Q?7hIbZCLe1T9phpmTsT3KfIkGfwK+JiycqTFBd6EzDiSYaCuVdP2NVI7rcZN9?=
 =?us-ascii?Q?U8gS8EfWQ2MbfORZxSBKwVgUvK/loNuKRKhXMOlZx8nnpsGG77r71yBSDzOI?=
 =?us-ascii?Q?u1fdecQnSrjItHYhmrcqNK/vHvQQvR3iKcG2b8OOAJsnwPngBU7zrz1cVLZO?=
 =?us-ascii?Q?vV5vEzACV1aP3V52pEJpAThMvS06TQ8+ZKME6+eagtRxS7iQ6kpN/vExoaOw?=
 =?us-ascii?Q?tEwiWnARuGEWb90m+SsAdaF+jTIudvidcdObOOVqBaSaQJpK2tfzWZYPzbHh?=
 =?us-ascii?Q?r/JDpoQAObUUjk+APWPg/B6cTig3Azat5UUDQmcgvHH2uX4kwsnd6yWBd6a0?=
 =?us-ascii?Q?ihFkOrjmnfsfOyRpMsb4bVfd62oFU0Luzc/hLIW1MFWfIIPGeSewIsGKZpyU?=
 =?us-ascii?Q?QU4yz1wDpvK/HQk1n3ziAxK69M0FJow0W8MatRgi6e6rwVvarq5Jte5dfzoy?=
 =?us-ascii?Q?x7lZAFANrrQFSHJ1lk0/9amb0KC8vGlIzKVDoy3uPspzVW5TrM7Dlmuarq0Y?=
 =?us-ascii?Q?VaKMVudioDhrn+zj6wOYCv1AnjO5EMIeLK1X3I1eSkoQz568QL1wiv9J77v3?=
 =?us-ascii?Q?6/3G98ttNlfCaeMKYM1Bj5eocNvKeQHcZiV/DyDbnBi2bop4GSY767Mi413c?=
 =?us-ascii?Q?3UZULTGjQTDNL9e+vPK4bLutKgM4prhEcdEFNnFzusErRPmTZFfUtcJJJWUK?=
 =?us-ascii?Q?cMg9PDS09aXQSIUGsFtBYJt7N4+gC2PgRxI62AmeqYz2R1wpBKgSX/ibknci?=
 =?us-ascii?Q?76jVFEUDyt/f5EyLAaFf/XaniJtdqvKpY6KJSkwLQQOA/CsyqwZAAtyc41uN?=
 =?us-ascii?Q?7fFNHZF3RIRaPHdd0lP4m1kn8jZ8P9MwK2SCWFnMY2/B/ImSM/vECXmPOEU5?=
 =?us-ascii?Q?qfcx5voOBHFR84XdDnr6tl2l6Se+VPN/9mWZmYu++ixJgcj6sozAvYYEGUV/?=
 =?us-ascii?Q?ssVlZDPEz1jfjF+M+9zBwhyZ03SYwr83KbXzseRgBwGOgs0ggLwAWDK9pYHZ?=
 =?us-ascii?Q?vZs1RQKtryNOp7pGNCGPjAqwFC7o9EyLtkfMUlKOV1mkSjNi0dtvwzGcDQur?=
 =?us-ascii?Q?MlgBDMObWRCUaAGUgyhZqTZR0v/y8O9pR5P4eJx9EKaNHZe93P0Y1+dAYemj?=
 =?us-ascii?Q?OPi4n2rU3DU2y5Z2tAqkGoCoXxxEbNT7ISSy1/V98zoIq+vD+XNOZ1U3yzUd?=
 =?us-ascii?Q?rQ88L/wY7pkFl97bb6CVrnyGGVDO2uYIBLkUksvYmOT+gfii+NQxngygFtvK?=
 =?us-ascii?Q?JW3TSKR2bw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54f1c835-8efe-4824-2ba4-08dee71cd748
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 11:40:19.1479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cqnr3jf4uTSe8CZvJ9CUvqd7/xzMRhI+Oj5dU/2l18Q+t8Ewyo7ddpClcB+OGKKvkl4w4LhPkDgUltIFiuleSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5756

On Thu, Jul 16, 2026 at 10:37:12PM +0200, Fernando Fernandez Mancera wrote:
> The position pointer is only advanced if the return value of the proc
> handler is positive at new_sync_write(). Therefore no need to manually
> reset it when doing error handling.
> 
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
