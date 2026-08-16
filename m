Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012009.outbound.protection.outlook.com [40.93.195.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92AA39794B
	for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 07:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786863970; cv=fail; b=rfxPz7PtKJLCryZxqkdrnifB2VDmX+60802tvJkfmVXRr7xUXfMJiK4vj3fynJNptEiV6C8eNTq2dlEw5cpd12OXUx8hUvrJ8o6s6NrWGEXX83eT0f9X75DBVDWGnHFEuF0gSKhUwm7knbzQTMnVukMEH7kdLxANx5aey91nnMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786863970; c=relaxed/simple;
	bh=0OY0w14XUZG0EjQ0b9ykvIbGrQWCcdLxx2JgQzGOGXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CaFl6mXD5tjjMe1kuXer73F5k7xN0us+KzLDmKFeBf3KGWaBw4ienY03Nzu2lmjb2xxHEnNbLFj63ZrUS+XaQrP/QTzwadhIkcQ1C74hLQNLBFLrfOEuHvO+2tK1Z3fZOFAHrAti98xDZ9l/eud475ZHdnQltWbq5fYHET8Af9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qRrOuF8X; arc=fail smtp.client-ip=40.93.195.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qRrOuF8X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RPxeYzR7x7dv+kGepXA+UhwkvetmI+dESV0FFAiUGGeWlt+cZxsoeFHXdAyAkQts85Q1pog5Tne86TYV1dSHYgkF1BVlP35BMj6gAmhzo6kNGkCSdoSI0IQhY+RdLzE4FFrEZgEju7moUdA5c4dDB/q2uPMkX1dVvX7niRpLe5UMnEPaUmoKYCKVCILbQfa0Q4d/6vVh3qSyxZ/UBA5jahfbA8w3ldRO7Et24IzizrK3HJbl+eFtevpY6+TcPgfQIGwKwS90KaEomK8QonhWEeqpUFews4utQR+V2nuwkCGaJCpRpcu/jKxWe2WkEL9Er6OBMutvHFA2Dj66JA1hEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DdjisgSbquE/eWWk6d65w+MBdlQTPsxOcmQ5HqfJOPQ=;
 b=IE1ZDdF8T2gehkb6ZypUwNgar7osaW3qJk2nVhDBd2XRKk3oni7XmZ3aMwuPEse4Tl3HCV4u3JmWj0WxCeaLpGiCfDoXzD63nIiatYuSmsSyo79feb3MMVSAAKh6NCMbgT8RlbMytdLZlnHS8JNe/ploRc0J6rpCdqYXcaLWWw3waxPnKhnvvO0ZhgyJuxPS2iqrmtTDos8n3PqlCA+YvZjhqVBYYk6SkO1oJJO6KOXi+S/DCaeMmljxHL82Wj2h3Vu9xd5IS7qO4lnHzWqB+fiEhnuakqPooRoPF1Vdov979RY+VsI+ejVFcKbrjvp6UURmz1Z0hNTfY7t5vSb0gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DdjisgSbquE/eWWk6d65w+MBdlQTPsxOcmQ5HqfJOPQ=;
 b=qRrOuF8Xboy6amgO/NWgIqTya5DSsGwoagT38+LHsBIZMgxSszP1C2iGAAWneBhyg2jCE56lBYt8hS1t7gQoU0yxkKd2/J3EeSUJDFbgkVC5WgkjsR2j1Dg3VNwPrAPhJR7D4EdtyQXmB3rIAjOOldp0xz5OLYB/sOADKDoyQvCpbt+//Tu3pVrB3NX4bRhO3V1DHCLh54mEExU45kqT7SOdD1uakXbVclEQixQBJaHmuNgBHS8rd5ktP4/Aj176+QASiivvqMJC5MvWGilk9epYoTjbTJ+F6x5E7uX2XYmqrgu7RwH7DkA+4tlbltcPOnhfAIOm8VDSCTzfOB3qzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DS0PR12MB999312.namprd12.prod.outlook.com (2603:10b6:8:42c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Sun, 16 Aug
 2026 07:06:05 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 07:06:05 +0000
Date: Sun, 16 Aug 2026 10:05:54 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Ren Wei <weir@nebusec.ai>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, vasily.averin@linux.dev, vega@nebusec.ai,
	rakukuip@gmail.com
Subject: Re: [PATCH net 1/1] ipv6: fix use-after-free in ip6_finish_output2()
Message-ID: <20260816070554.GA4104704@shredder>
References: <cover.1786516730.git.rakukuip@gmail.com>
 <4aa3f53bc44e79572c6dd2340ec7b68ef1a3d87d.1786516730.git.rakukuip@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4aa3f53bc44e79572c6dd2340ec7b68ef1a3d87d.1786516730.git.rakukuip@gmail.com>
X-ClientProxiedBy: TL2P290CA0026.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::13) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DS0PR12MB999312:EE_
X-MS-Office365-Filtering-Correlation-Id: a3efc8e4-a72f-4d61-173e-08defb64d6b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|3023799007|56012099006|10067099003|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ORyM/Dw4LYft05XmmOds626HI01fqakeq1xd/q8JJNoGzVMFWteKDYzsVByrUjlRS3ip5zXH76M6ci4yHnLUDUt56jSpxI02YzOUBE5gSe1hhvNiv82EqvAcA6a+gmS1WviQCodiJ3YjZNHfxofJlD1L3529QiO07y4JWnTl3VZt6FskL/QkA4t6MBFb3f+BXwnbuNj6Dly/OYKWgsDk8wqduukTt7F1jLxSW4cO131CeksuE3VnLDzextV4z6FauJ9Xn7qs0bvSF73FWG84yNq9vDNgkAU7Remxv8MoUi6tfmz0i36p2YjYFbv/py7RiIpajKjBzLMJyytLE+RV05JGHGtD2ZMbeCfRG81ohkv06RJmTHDkEo6sy3PvrYRTScqoGnlItODxhLh5SAXrfVTnmF+T8Tc4Pq7c6XMqNCweIIf9iVxx0FTu37cHsT6gs2GkyIB7koxkWfrGH2cWgOunOFCdURMntF985q80uRhjPKC6eydi9ZAdX3D4jMxq+E0CI5VNRWj1AxGP39/cTEqYI6UY/L+6YQ7GN6yhMlsL/7Y6UTRpW04LjuEImUZEk5P01ugtaGP52sf7Oe9LksFp09zBsEMCqqd+lUVsKYgNktJns1707GR1gYCE5CnpKZ37Dpje6409bDVv1iN0QBgB0dKII7rADERoeXDD310=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(3023799007)(56012099006)(10067099003)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8X/Xb1ru3nF2zD1ggA5PnH6RZezMUriVwkoW3rSOB07Jcbr2KlFmFc1uMzaX?=
 =?us-ascii?Q?gTC24CTJ/mKNk5/tNbafXruPyjsW+d6gZBHNxHzamwlItUFch58yKFR1pHog?=
 =?us-ascii?Q?5LOAWHrS3Q3CKPQgQYx+Mrpdrg38/RCCn8M/twQgTaqbAisV3ilULjI3dyxj?=
 =?us-ascii?Q?LQtfrKX3oayvmT8FR/XmA07lhzZ01tSrjofopRsL4pJdu0Ftp6vHapVzyeut?=
 =?us-ascii?Q?uEJYmshvI8e7aelHItK3fZcS4gt5FQ8e83tSz4O10au5wrbDxVTz3SgFJ+wU?=
 =?us-ascii?Q?sk4h3Axio6y0EDIBqo5RVOJhvsZaP9r151j1UlfkhCWpROxENvHIJEAYZbHs?=
 =?us-ascii?Q?kmwLz6AEgKbANf9zZ8as3YQZfEMVghuEy5GYgd3tVKnEsOW7Is3yXFetZGiy?=
 =?us-ascii?Q?YSziY7EH7hbbRg2NnKICgSUuGBKTka0yVxAGjqrks4qhvHOPazUTHSyQVphw?=
 =?us-ascii?Q?pndUmTK3QZdkpOAYe88dJDxxMF5CXfTAHQ73E7/IdabKRYEf+N5ypLtDah7p?=
 =?us-ascii?Q?KMe4fooCvVH9EPxC3NsuJwwN0ZE4eZuUhKbHGqJnX8VcJqTT646vWlYBDWid?=
 =?us-ascii?Q?JoRKFhyjcoyvCI9eK3sZz7onT2yslhdQMnJX46AtpSLVmlxMKTOvaLAhOuOG?=
 =?us-ascii?Q?TRKEpArtOf6VNss6Ptm8nEYebF4niejn6LNo/MKn9sMtUsfmsgpGFRm4nM/M?=
 =?us-ascii?Q?xGkFycO3XAPzqrLou3ddvSpkGFAkxjlUSGuc2aHmGKoafU1dxaY4XFVj1ZX9?=
 =?us-ascii?Q?Xi3PbzNdghsiE1UuwoPsESVO6ZBXGFiRFWFz3hv2gsqF9g3FxIcaR+F8QuYt?=
 =?us-ascii?Q?Q+ls7/mg/C9VG8qt137G+RJ4JZP6OjnOACrUaiOsuYiIkuLE2ecL2PKPwoLn?=
 =?us-ascii?Q?VFqrvbMr4vO78ZUbF2qJbvrXM8AbbdjEx3X0NtoT0ZYCY1CUDzHQp26pOGmr?=
 =?us-ascii?Q?4dmU40NhENJ0HKz6HrcGUOWHH1BFZVnrEkKnORf886Cr9QIWmDNmWC1eWYQD?=
 =?us-ascii?Q?ITQFnU7hVnSqbI/jsU3lxCWg5TjJttplbJz2u3PEgSOH/v/5wtAS9OabnwQI?=
 =?us-ascii?Q?0tC8GFH9/V588MDI9pT8oLNWyY66D273v/ORXTSHLCA3/+DKn0Inod0JcXvW?=
 =?us-ascii?Q?1grsTky88Wwz7sQr86M5+kcV9e66gJELmKWwvHIym5v6lWXcEEQErihqZAqS?=
 =?us-ascii?Q?UCcLsvrtEzWsGld4eybCobpwli9NUbU0Cud12Vg3Ve81L2tvGYwCgCmsff/6?=
 =?us-ascii?Q?uzNu772lv9l0tASScxfIWfmkGz282dWQ7t6H+ScXt8/rjSb5TzSeJ5ypiV05?=
 =?us-ascii?Q?z4T9CR+62vnXniCgmJ5W+MSDaruF1fkUkZDYKlgIgwZ1oFFv4l3bdj7d9Zyi?=
 =?us-ascii?Q?Fsc+89ZiqKEmSyFBdXlsJ753HD/k4ef+aUCnXs2lYhWvET5n2MH6GhMGlapX?=
 =?us-ascii?Q?BnlY0+4KQB3JzhnBL6yXGDo/LBeD4ekFwJv5UHE9WoAXlajtuVD+u35Xg6s4?=
 =?us-ascii?Q?zDdY5JMyfykfOoLGcXVEWgZZTWH5jbQLD8LhkwNCIbUyYopPeD+eJfQ0Rema?=
 =?us-ascii?Q?rJWGeTur7+Zq3jj3kKQxzDpZfsNNMaXK0C1Tc8gKW6YYICws/YAG9kJG4TLR?=
 =?us-ascii?Q?89dwTVmlrDsdlB84TTXYg6FlTqro9XlPsaOzBL/C03Pxe+cmEsKP76aLQN/9?=
 =?us-ascii?Q?6LmC2g5X7Sp8yHRoGF5CfjP2Q5VxraY16+nxgQIiunuajxjB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3efc8e4-a72f-4d61-173e-08defb64d6b0
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 07:06:05.1720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +tUH+/gaGYmk35MiyVQ6NrRHlqHCzdCj6KaNFFYoib3x2ErkltBTfJkvVh/zc3thjBGFORuVo3ECMClo/FbYmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999312

On Wed, Aug 12, 2026 at 08:54:38PM +0800, Ren Wei wrote:
> From: Luxiao Xu <rakukuip@gmail.com>
> 
> ip6_finish_output2() caches a pointer to the IPv6 destination
> address (daddr) before invoking lwtunnel_xmit().  The LWT-BPF
> transmit path or other encapsulation operations within
> lwtunnel_xmit() can reallocate the skb head, freeing the memory
> that daddr points to.  When lwtunnel_xmit() returns
> LWTUNNEL_XMIT_CONTINUE, the function continues to use the stale
> daddr pointer to compute the nexthop and to look up or create the
> neighbour entry.  This results in a use-after-free read, which can
> leak sensitive kernel data, pollute the neighbour table with
> arbitrary values, misdirect traffic, or crash the system.
> 
> Fix this by re-fetching the IPv6 header and the destination
> address pointer after lwtunnel_xmit() returns
> LWTUNNEL_XMIT_CONTINUE, ensuring that the subsequent nexthop
> computation and neighbour lookup operate on valid memory.
> 
> Fixes: e415ed3a4b8b ("ipv6: use skb_expand_head in ip6_finish_output2")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: Codex:gpt-5.4
> Signed-off-by: Luxiao Xu <rakukuip@gmail.com>
> Signed-off-by: Ren Wei <weir@nebusec.ai>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
