Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012070.outbound.protection.outlook.com [40.107.209.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F69388386
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 06:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788936153; cv=fail; b=VOYGxtPRtum2gM8iiZzWAnCfnsTARxoFLk7amtduixLAAj1juZnr58kwOOlrDI2pYoCICvafwWJaMSb1LEqNYM9Uu2I5+t5s7eDpDpTmSifxfXMESO5ONmgCUAeU9O00COgBZf2ac60rUFmaZ0S9Yxn73mAX2q6A8F0wzsR+8bM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788936153; c=relaxed/simple;
	bh=TYcSZRZkMexv5Jc7p57jl2w7IkYTBHCJknGP5lyGTOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=h60yG2WWSEjTsnywrRu0hO3zv7a1HxXiiJKSYIzHa4eonrraGDsfIxY/+74h2Z+4aNMhoc8DwtsPo4Up839cH8Vli6rArqov+Oef0gw1+3qS1UK45bGEjh5wV4eIyuBNrkX186ExbA5SHibGPcO5ZwbhZXcdnC7BCBAzjNUvQXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DhylhFMN; arc=fail smtp.client-ip=40.107.209.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DhylhFMN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YR4ytwuW7nlmDpyxMoxPYznNGvVxEFXGc+HV1I00ac/BONxldh6a65fcukQ/6RYjkg2fyAqLFwd62lCtcWhe1AZrWPvFTfQzJevmAbQ4oElG15bdvRPCAC3c5LUZdC7qTtez9UXCT1s8qA4pfHe2j59GtTKMu8q768QYIgJV82sbwW4bDQmdQn40DcPVHq/eqiz977qkRiB+BE/5IULo6gOMdowDiUPM9Vhv4cmQgEvgS4nTCYXrC+U/zMzpt88U33skpIRLFGcUK161hG7F3wYAtzs8IKtN72y37C5k1s8thIbI33mkPU8hbVoBBTSXkX6POe68Z3w90mfFSH0wmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=khbTbqSBf0X3wfclXgsHHMuIx6Ymfh21H7Gtww4SXQQ=;
 b=I4ayYBUYDxtp8JIURBrLfAIf6SpcHhJR78vXNXQ37cgjfNlumfNd77xFXenzdeX+9OiEbvbOpL9Dqgu1k0uWrWbl+20cfSx8G36oHOO2AsBnYKRMelEh2Bep2oEGQvyBJ45CtNjXKS11iw6EubjEhWjnIByIM+zKEUcMr3DD1Kj5+dKRo11zHETALZu/gdEQtW8ffWCVqEBoVAIitEIPmTVOo9151YeTSOj6P0xtT958ibkEfOFlcOqsxCl0UQ8HwDjeC3BdMPtx1mPF5fQhfe+dNQPSPcUG18qyn+/YCdurABCGEudtVqltkrmWuU6biZxiuZt6KOvA5inE1VSXGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=khbTbqSBf0X3wfclXgsHHMuIx6Ymfh21H7Gtww4SXQQ=;
 b=DhylhFMNjfqWNA5y28QsiobHVmC4L+avDZ1VdBxMevqmOaEuHXAcdFEo9Q38nObCFDgjtfrNP8n1B16vu6P11IUwo/6DzOcggxyZ/Oo8anOgJ7jY6jVXMjqfYB1W6VVr3T7ceLTCMBGqp0Vj4AZn/UTeYFh30Q0yrgijzlTxKa9dxBdDebvV6mBP39yVdXvERiUm9wzBb1hEDN97ZvWC1OaVGmH0vvJtwqxrV918Ztd2PpOYOLcthZZ0dRaDOycOrax6gErCseYNbQEsXyv1k+rAVbRtxyDbKx7ax1dmGtyrDp+I4s4Zcz/yjPS+BVCMDn+3bmt9hlyf1NBssLQoaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by CH2PR12MB4167.namprd12.prod.outlook.com (2603:10b6:610:7a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 06:42:25 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 06:42:25 +0000
Date: Wed, 9 Sep 2026 09:42:15 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net 1/4] neighbour: Add missing RCU annotation for
 neightbl_dump_info().
Message-ID: <20260909064215.GA1183641@shredder>
References: <20260908211419.882954-1-kuniyu@google.com>
 <20260908211419.882954-2-kuniyu@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908211419.882954-2-kuniyu@google.com>
X-ClientProxiedBy: FR4P281CA0229.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::7) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|CH2PR12MB4167:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ac6acb0-31c8-4ed6-ea61-08df0e3d8234
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|4143699003|56012099006|11063799006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	OcSVAh9tWhB0nFS8xJqEFVjjZ9KkF4eZKK9vbxvkYPQoCfh99opHNs1WxKuNamfOMzIeQ3+p0zSKW4n3B35mK5Ggo+dsE7hyKP29hJQfvxl4Ea+sc5YPF9mwohjw6Bg8pmuWsaRmtg6jG95N6dwHb8qHWFVbltYpYg9plfM5Qp/1vcr92QGs6+kylE8uKdRZPyoALSrdOmxP530xqeER/4+RpT+SIHzyPI1me+L1aD/LNypOU273HhGEBX7u7NCmEzN6yMEdALwXPz7t9i8astp544W3Avcg5L10L5wAMuKVqavuIqupkoto2MX30BZbesBYIarexPtNtJPHWEwLdU4t3NuCXrhMCHzHrDOd/Vr7nPdqKvZ4cEciQj11SDStWqszPAOCZCrjVQQXasveRUqszqMy9BUYYQkLzfLl2H5i27SOXs5OIdE0plsPJjaYofLcD0SC2DuHyIPKJC3Q4mnmUR1faWQIww2b0UPDjbigf+Vdiami6ImbH2s8UiEOgXFFRqI/vqdktm98+qbIpVrqzHkAsh/j3WbO1eXRyXkjPlEPjPqOOAqfyq9vB2aAIScFFvjp4ydkhypOYg4gK2aR2guxmkSEH6ctHFfa/4UzJEhV38dWkIumLldLWOOjXoY3lUnGU6Z8XqrW6NF21A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(4143699003)(56012099006)(11063799006)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uu61qA79xm05LcaECfn6R4b/4DYejjp2Z7KwEfjeE4v7Bo7FBlySzjW2xspS?=
 =?us-ascii?Q?JGbcgVyv6Ozqrd7ykq1WLS6QdjSJ//x0iHPziQ0c149OS2JuPYP0vySS361G?=
 =?us-ascii?Q?LpLkt8lAxIxKTDM3iAs6sJLKjuRxoTZ4A1W9ypoFMiWGuHpGY2zTawiyBJ+R?=
 =?us-ascii?Q?p/OP/YVuG377nu/SZowsCyWAc4POr4N6Ivw9L2EvFPNGAdXfeMCagVkdfVIu?=
 =?us-ascii?Q?ywus5q+R64y9t2+byCSttYyWWtU3wZoLgS2Vl9HOoTRi+uGeE0wqRKJ+eqYo?=
 =?us-ascii?Q?4YfzlQJky1Btg0oF+Odz+QPdlr7fI3BwsX04xdbZFb8IatnaivNRNx+gBhjE?=
 =?us-ascii?Q?pbaohKgFzenbvtj7PRBTOy+1EdOv6JypCiv0X/+4kb344u85yUjUFg7vzeIV?=
 =?us-ascii?Q?CKS9ky7+IJr5jfVsSNd6EfwYRgQVQ6bElBePwCoB2y+bdZ/gxjaIjEnQABpK?=
 =?us-ascii?Q?Ced8/9mDZjVroG4ckfart2m+gYrTzUlkwWZQnD3F3PYSYmbJN6u1r0HF+sn/?=
 =?us-ascii?Q?cmVVcA7nNtlYDMd3zrqPpG5mEJXsP4tYviK06rnn85ultkvda6is6mA65ILJ?=
 =?us-ascii?Q?noKACEd1VYUtipNh3vVqyqU6F6J/DI4XI6xL2znp1vK34RbYb+kswq0zjcvc?=
 =?us-ascii?Q?2KI5iiurzODoKszAw4/VmufxH7KXgnGlyw8CkfizZEtaIEaSwQucY5AzHAeN?=
 =?us-ascii?Q?2WKqXDLsUXd1DPf03xDBcNlts8jGzWJRM8ozqF5FP6HDHJT92WJHcEuYxf/x?=
 =?us-ascii?Q?g3WFsJon814ghZGCxntxxetsyHYmaLRKzkzujX4HB6N4lSyM6tpmd2n9n9O2?=
 =?us-ascii?Q?2t5ltFSyWcFrZoyBGGAwN0BDXsplOkaXsLbNbS7MxL969C6Zi7Nf31e17VmB?=
 =?us-ascii?Q?V4lL5uhQwOnAx3fB/FRr9zVGfS/IFtv5u/XUx5GMsNK2CkyJ0LrzBbzlQPB2?=
 =?us-ascii?Q?CVrGFM/fVdtnQQMLJ4WhClH1Axa0yonNFvHWHq1LcsuUyXYyWM1k+42a9LJA?=
 =?us-ascii?Q?jI/3NvFFScynBaUZNpFa7D3vPxMbdYDTgElNDbedkwIc6CNZ/IY1IzULI3Xc?=
 =?us-ascii?Q?zABcQbKewU1u/Vty/8n/Vj4Df5xr455i8fSaMF6HadN5De5ydTnNtoN+7wiU?=
 =?us-ascii?Q?DcSPuIlHG8endYnLwH3nwWjGAB0c4y9XN6qYm898TGCD97pQJooth/Gw36hG?=
 =?us-ascii?Q?emDQD7X0rB/1S/soXSe2Bu0gI0JL1aaCa1GeQ3EdFqv9VgABQzjtTA+OyNjt?=
 =?us-ascii?Q?mCaP46rqOW5fknjYQU39c6h1GBnoQh1PxFweeNrUvMErIgbYqV64Ja0KZL38?=
 =?us-ascii?Q?Z5gyLJjJQbXHuuj6FUFmICuC+TZdvhDk9R1D3evIN2DioRBnyeEPCrLW3Oj/?=
 =?us-ascii?Q?BPgjUvDYis44XjP0jmnhrkCRBRWXoKB6Mgqw9AzugEhqS6FSVS8oRd2ilSGt?=
 =?us-ascii?Q?21daLCtvpEcYCHsw/MHiIsS0JoTek/3Roo+NDEkyvA8B+yDAWqdkY+3Q+GIk?=
 =?us-ascii?Q?UUPrXy5NVX4fY8w7/YpRtmwDiArGOjmlwU/97pFst0fkguPdQVO+m3ll/xxT?=
 =?us-ascii?Q?L0LNi620TbNDxUP5JcG0H5qrTKbOPgaJjkJE7R0SV+BgQOquh3s1n1fdgBiU?=
 =?us-ascii?Q?7pADhYk/OujCD+wBxqabMKYpoB88jquJF19biANU5v8bFdTe3hPbPleqfv7X?=
 =?us-ascii?Q?7+661ErcnANs3pcDzZVt+fKEw/f3toZKVwNpuflHz3ktvcIY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ac6acb0-31c8-4ed6-ea61-08df0e3d8234
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 06:42:25.1297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mCigfDN8G++ysycVYbJ0/VYFG3FyH7ejLSTBcP3OdEnrvrLE0jWe0uREmDBNmmnQZQnNwrYXi2Yxo1KW+uQ5Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4167

On Tue, Sep 08, 2026 at 09:12:45PM +0000, Kuniyuki Iwashima wrote:
> neightbl_dump_info() fetches the first non-default neigh_parms
> with list_next_entry(&tbl->parms, ...) and iterates through the
> list with list_for_each_entry_from_rcu().
> 
> However, list_next_entry() does not use RCU helper.
> 
> Let's use list_for_each_entry_rcu() and skip the default parms.
> 
> Fixes: 4ae34be50064 ("neighbour: Convert RTM_GETNEIGHTBL to RCU.")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
