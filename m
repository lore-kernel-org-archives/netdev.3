Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010024.outbound.protection.outlook.com [52.101.56.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1EE42049B
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 08:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786006352; cv=fail; b=DwkhyM9XJQbJz9FEi01M9klBAvN/lycK1AoqaAziPajQd94TxRm4fwPtCANYvNdZLJoOBvb9eFQZR+CM4iu7SexlW8pKncOydNQabBPWysJVLrrVYRAMcdAnhnI1GcpgN+MgCWwIOhjZiybxreTE2mfEEyhcSwZrE8wVS7LjgIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786006352; c=relaxed/simple;
	bh=Lc0v0ZpXolawhvV8ZBsHDLkpZIDhXtt3f7E9i7quAB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UWqKF1UjuiTcqBJ6MEVLY/WSqP+q67WYh3ae0EjTyuiTrEkjRsJOv7s+ae+XLqAmRTZcCtVqYwzVxmaOXlFyrOGGX05aKEFr33XhmKie+17x136cfY4fJZO8ieTGPeZp0+KgB3giXkI0XExX3J5ARaBuiE8H8d7OPFLK69ms9ac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MfKsKVtv; arc=fail smtp.client-ip=52.101.56.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MfKsKVtv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L4ql3LCy1h2tj+oAKMejCM5s+m88Mz+vamfgk4OZn66d83/S2aHV7LbdzTYrykbsYKHrryd6P7gyWDlZsDp+f8pJ2ONwp8G7mdqpVRCc45iM1kz+RsaJUdY1SdHHeynMWzxRvIxbquv5VG6HuMdCTNH8XQeogoUm+j8zvuCRn/Bgd0YBoBKDAkC7Drk79JyD3d0g6spmK+Y4/n75HyCR1Fi6IS4mdQ0on6ctHrs56u1pFyH7VaZoR6iYZn/TQfHOEWgWe2Gn5inTCeS1ca3UtGmhrRNyrFrmhgBl+15bKApSrNxriUmThs3FDtKdBpoNCdTv+KkvWtU09SEIbcAnaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hJLyZXliePkU1iQs2f3eF4DDUB/qwJu0LNkCugFdXsw=;
 b=iFJQwFvQ68FQ6BcHbKUiwy/fbKglE9oUosvS6TRLbc0Qs6E5DZi4SiLw40o/6ZI+7Cb+CruLZvBkG6V06dRWjIBJsEQ49w56ef1HR5zAQyB10cK5c5xkvYZyzfNTdMesWDRYd3SpcU0uocl3byz977IsHtvZe3r0TLwPnTwC+iOEv3nV4E1QYiQ5j7slbFpSbTps3gwzoDj3p2MfErttDF7qIU2q7hauqG+ylVdPtZLP9wvvwFmOdMjhiXzgx3e4gXtsO0i8TU7EPao8Jh/Qm5RReuws9IBxfuM/Q8LdYO82EDlbc9s4s+adkbOQhrXZkOeqpnm5YhImBgodQXmpaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJLyZXliePkU1iQs2f3eF4DDUB/qwJu0LNkCugFdXsw=;
 b=MfKsKVtvh9e4OIz2Tt559p+Muw9PD6v8iwErTbgGRUFBFYlzcnehaub1Xa5qSj9q9se2hSqmEIfKDvebQQpbaT340tBbMWQkQp+oUD8Tb55PQbZfVkI3nf0c3dkBnR9B1+mX9fZoaa2LkNNnVNQFm30xKgv2FI48MuHTCRwXGqRwtcOlQpgk1KqkNTWz06UjxPGcKTa3JMwY8DiQ5j89SmQtMjouyetFmk5ZRQ81N9Pu5TWwttWVWMVD8HNnakGekmb4rUZmnTkki11G0Zr9EmwQubPHiLAIPvPxTSpwWvURybN4gpaYW0Ebq0s3Lcug9D3yr6mNxQnDhCJnh/2V+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by LV1PR12MB999281.namprd12.prod.outlook.com (2603:10b6:408:3bd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.20; Thu, 6 Aug
 2026 08:52:25 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0292.019; Thu, 6 Aug 2026
 08:52:24 +0000
Date: Thu, 6 Aug 2026 11:52:14 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>, zhilinz@nebusec.ai
Cc: Zhiling Zou <zhilinz@nebusec.ai>, netdev@vger.kernel.org,
	dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, horms@kernel.org, tom@herbertland.com,
	vega@nebusec.ai
Subject: Re: [PATCH net 1/1] ip6_tunnel: use skb_cow_head() in ip6_tnl_xmit()
Message-ID: <20260806085214.GA1748060@shredder>
References: <cover.1785734738.git.zhilinz@nebusec.ai>
 <7f099879785257f4d57d6caf9b6308fc76c7aaea.1785734738.git.zhilinz@nebusec.ai>
 <20260805090721.GA1364862@shredder>
 <20260805172902.27c9bde0@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805172902.27c9bde0@kernel.org>
X-ClientProxiedBy: FR3P281CA0169.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::8) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|LV1PR12MB999281:EE_
X-MS-Office365-Filtering-Correlation-Id: 519f0141-cb8e-4879-7bd7-08def3980921
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|7416014|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	R5K6YGnSTGbljyF+Mn3td+3uSXyOH2UjguUGV42e995bv18scEGamtPRK5PtCfazwLzvsStGFswujaCTzB6Qh0GVc/k1b5Rj/wc09qxgY+7SGgkvlIxyFHU4aOaiYTLkKudtnRDcN/jxM3N0g1PKwmUMO8lVOcEoMBw3naghDzhA2IY1/q17APFFomIlhJh6irD/QeotYorJQ1IA22VAPXD3yhrhJitSfSY4FC7n4DOCgTjDuIRXiTZWM8v/JgPRhxY5bMA09M/NyLu5E49gjn1+tdaO3l+yW/Wq4t1T9AWX1q6JNX3AMdBrBYqa4VD+Ebn339qgmeItNEuzDpeyb3G/3Dx5vrfAMe++FPc+Nf/Sb6nHqmWoU/uct2O67QxlDFVxFUBVXBSeWc9HEBcjBr1ZqZFDmGYOkhoJO8xTpDuWN/25Y5cAQ4P03W8hxnoXDUyWa1dPqwLV18TwgaW8KFmZMXPyggjUeMPbqjhoXbOrBduS+/7SrgJCsQNnjph8UE6kv760JL5HEiFIJUKSxYt9hl2IBYRD0QyX/bBdB+/dVKQrQEUAf0ZpShy14qt0Z0EipUFxvxyslyJHob5YFGhVc5nJhkxWU/GGdS/NRwabq7Om+Cp3tnnriMyK7niUGKXryWCZJYks5qBlsoYc5bNuB4AG1BfRKD/OjiTGa0o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(7416014)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K727VGdsSiBw3Rlkc/0D/PHm43GmYuCnMRNd7hyZQn+E5HHH0hHYj5JN1k4q?=
 =?us-ascii?Q?UmqrKGuK4xN+0yZ8y6s+62YZvw7xK4ly1AxO/OB+hvczH+HF9sQptYwIuuft?=
 =?us-ascii?Q?3fFWNR3JK7+l/MX0aYSeernZv4FTPkKFitmdT29RFkKtB8RxRacDwWU0B6a5?=
 =?us-ascii?Q?bo3kmTtKqGBFh93ZbqqmBWlXh4A5NyN6FqUDDuyN//XJmYEDiE91G3UH4Uu5?=
 =?us-ascii?Q?GdyR+sZpNytLcmIy7qMKdXJwz20bjNINbAUqmZNe6AIv4673JzKZwYeUhz5x?=
 =?us-ascii?Q?H4zD2TdBFR+RkGUHpo+aWAK6T5lENtGZoxRphMJa1VbTXyS9PwMjS8HyUJ9w?=
 =?us-ascii?Q?flY6t5hXjZNVUY0s9Egmiy5VR8fjzVVJl7Y5Vg1UWLRj8noiALlC20VQgOAd?=
 =?us-ascii?Q?bRZr+396V7b9y1qVDOTxH0heSbHZEedEOZHLaFxm5pek1WDyiVdqMWfiu8OH?=
 =?us-ascii?Q?p+wQPhK72IRg5VE+hz5iDhSM0k4RiykhDSR1HQB3ITcoxhHJGZ2+DTi+wX6D?=
 =?us-ascii?Q?aEsT1dKyMoUXksnhBhpLyt3xAWVDM/8vewwzEwOa2CmOkbnjkXD8jl+BLH8/?=
 =?us-ascii?Q?XSK66SmOpPBHuEx6JxdoeHbp0bDLG45FtFx42V8Feds7ibFE+d6SR7flyLPz?=
 =?us-ascii?Q?BVWm7RHRVx//ew4h4xprrU1R534gEeanMNW9qra8cEVFe0vPSW1PUC59+RHF?=
 =?us-ascii?Q?yV2gStdzt2cZ+I6Uh40xV9qBrVcy2OxlDAWcKjUb6sDhOv8E92Dti5ZCOVaf?=
 =?us-ascii?Q?AD6hQ/hcJ+3KW4sTIB+xskPabbIUZkXLt8HvmIa0y4zlzqFT4I8S6f5Lg9LI?=
 =?us-ascii?Q?IaVlMF4pA2AX0z/SEi7H2+ulPnAseicH9rI07jRXlLf9+Kdxb1h/PAq3pAVE?=
 =?us-ascii?Q?NWjuS4/gnzetSz7PuByNaPLRdgRJP1FdrLnSGa0wV/ltEZLAgJL2bTSHMShe?=
 =?us-ascii?Q?SnajF9rTkhOENUCO+xzehv41+nSIAdyIKKmUEMiVBw7/KORENUy3AdinGiaX?=
 =?us-ascii?Q?fPR4X6ynVkcdhTEVsrilmnrcRyCgVVBJKj8kMDbPTfQKXv+VhjqzNM+jMRJd?=
 =?us-ascii?Q?zKyFe9jOXjAsqz/rkkQreA9jaNzdXPXQYJ20TTw6ocIjc30Qvbt/9ZEwj2ST?=
 =?us-ascii?Q?/eGtGaRs97p6OOyVxdPeYmhLh26v/7Q9jbnrSwxw1dlXhr7hEWMcNPMu9kA9?=
 =?us-ascii?Q?lDsPd9H0YxExgAqXzTGyn1xVdY0oQk08cvQbCrQTbliJMK7I2ZPhnIMfT6BJ?=
 =?us-ascii?Q?il0q6+j2XPu/pFPvWTKwAN8GLThQ+HtQXGpT/3q7kRLuqTqNopfFd6RHfZS0?=
 =?us-ascii?Q?iA5ppK62wl5G8oUXX7e5Zt8z0G6MUQGGsWriIqjIdfjEMSFeNi5CUTY10hyM?=
 =?us-ascii?Q?MLd4Oap+ZDwq5twWv4WecSJQLYYHAG0Ah45l99MixuxlLEKYaxHs+owuUor4?=
 =?us-ascii?Q?bO5zNTAc/UFh6lqp6NUE7LSKjP5SWLHs8nwVREWDCXUMbdOYZeYbHSVqYP7Z?=
 =?us-ascii?Q?8CiOMCXX2mQU5TQkqTRCc9BEnGByLpacyihLX18yLBKOFO0phcSXQnjzSz6L?=
 =?us-ascii?Q?xYGpEFGU+/FGH9Bxj6wI9NXiYV/gM9OxkYWx3/ZqT/aJUup03PXU3g5wYPNp?=
 =?us-ascii?Q?ExbWxedCvMzouCGkLrMr6l0xT4ZBz1k0biHXOLkkXnpV6B/WGBq/DzXoH1OA?=
 =?us-ascii?Q?wDvpUc3FXs2RWfKAqcsq5DTeWypz7uKnVmmK+y0xZvBxucUJOuc/P25HR0iA?=
 =?us-ascii?Q?hzTDJ80U/A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 519f0141-cb8e-4879-7bd7-08def3980921
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 08:52:24.8059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QzYy6LDLS8O0xXW64tFvsiXzqvZfn2DbxOxyv36XB/WZnB+dCr+0COvCvEVMorVSqnk6isIHczmvvAN3y4Tr1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR12MB999281

On Wed, Aug 05, 2026 at 05:29:02PM -0700, Jakub Kicinski wrote:
> On Wed, 5 Aug 2026 12:07:21 +0300 Ido Schimmel wrote:
> > __gre6_xmit() and ip6erspan_tunnel_xmit() already call skb_cow_head()
> > before calling ip6_tnl_xmit().
> 
> Probably just me but can't they all be buggy?
> PKTGEN likes to send shared skbs around in funny ways.
> Can we get a good explanation in the commit msg or maybe let's
> keep the check?

ip6_tnl_xmit() is accessible via two Ethernet devices (pktgen doesn't
support other types) and they both clear IFF_TX_SKB_SHARING, so if
pktgen sends them shared skbs, I would say that it's a pktgen bug and
not a reason to block this patch. Note that pktgen is not available to
unprivileged users, so it's a less severe bug.

The patch also makes ip6_tnl_xmit() consistent with its IPv4 counterpart
(ip_tunnel_xmit()) which is already using skb_cow_head().

Zhiling, please add a note in the commit message that ip6gretap and
ip6erspan do not expect to be handed shared skbs given that they clear
IFF_TX_SKB_SHARING.
