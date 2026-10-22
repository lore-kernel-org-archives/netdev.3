Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.1
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792655748;
	b=SaYAAHI01V2nqwYlasGHnWSgNYA78PTlyNt7h2rlXqlHJ5STgqA3ME9/rpKhcg8Yltma
	 NmCqmR3egpH1C691hm91hcXbWMQH6E7HYEwtL2NMp8GmwKr1tME6dAQbU8dCDk3cg6vFF
	 6yf0gMc3hZe+VDX7Niv5OFD9x/uAjrOiZfXX/s+02skNmrhXXwxmn7ab1og7lBES/xN6z
	 XJzbzPL7iQKirytjdJ6QXvrJLjlZ+nQ+JFUBR1PsTYxCJjUBS9GMUftu5A1xiqU4gfsfX
	 UGFVLkPTrJ6nLqp7fUDN+mU1tSujwBrrb+taigAom1wYn0W9eb2Tj1QIF3iWtXJkiSw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792655748;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=vqMULX7SqRV0pUyBXNOOwXp/JV4DmDR2yHodOIyLFdA=;
	b=1qhpIJ9NQSqnCJ4p0yc83HU+O+B3O4GYwd/IfBrMKzIhYgBhUheHn0+ypUNu9j038Lsp
	 2gglZoLtYSwYo21R2V0AiNgA2A82+xVpzp8YVh6FDsWjI8/NpLk0sOn2NQBVOiUcNucKI
	 fnfzvnwAJlKYhv6jxgmD7vXDyeC+AMfbFxWJk1DRvCCHPdlsVI+Qv3CjnCGNXSBvzt5hr
	 usZ7tPsHiLcbX7M6gaJCWTL4PBDQvcmujAlXh7eGheq3E/GWzcQNA+0iK9bcv6NyDjCPC
	 ZfJ8NdwRKSpy2yTVGaRD0UhW7x8/adnhH92C2lLDAfAO4PBPgtUE+LThgOylSB2w6PQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=PMq0Gu6G;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.1
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010001.outbound.protection.outlook.com [52.101.193.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F9C606A31D
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 07:55:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86F9C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=PMq0Gu6G
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bnb2uNzU25UNkwd0Pv6Gbcc1MosqV+SQSvkvVGKabe3JXBDR25dCWHWMFVIkOAY7FkWJU9SJoraeJ9HYwOmE9fNAOPTNQxkeLcch2U3fWjzkjNScyGKeOCb2VLfXZWP6hPKZ4mgCq07e7QyS5Z8wEaY/UWV6vPeG/4UNF2pV1G9M37VVVO3jt+v9sUkCNDlG9qLolY4pmtVWIWzf1j8vZJif7qc5aqCHqM6klNTwAbxjQDUf3lhL5Y0u/vBkpKG70wZM8tS+CBhtwNGM0RnK30Cu7YC/IviqtfhI9mavNTSdz662tbwHPzAMp2b9VvmxCTHd3srFq8NJqled3N9+Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vqMULX7SqRV0pUyBXNOOwXp/JV4DmDR2yHodOIyLFdA=;
 b=jIvaHTIUXGAfy/vYCYDerin1TeTV19b+6AUAAv8G6dD0n8r4vXHzOervgzhKx+CBsOzaZ150Lh6OpNcURo+M2HUVWXahdg2JHasjKjrgxlFHccasPUbLSmnmQqS76Ka2F27MjkiSejr1eaRFxBRB/T3+jDuNiytHgxPyEJyC2FrohOWYa/WWpINStN9wKg8I7PdxI4JMVg/b1r0+E8PokoP7gJseHKWrMX8V6PtZyh/bL+40s6qLAvSGFQ0n0qYJY6mhCWR0tTkzpDodlxLk65AO0r5bNv0xYjtEPFJ8zlqb4I7od6flW3F2z76eVtihUDq0UkUPRH33q2fIx3BPAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vqMULX7SqRV0pUyBXNOOwXp/JV4DmDR2yHodOIyLFdA=;
 b=PMq0Gu6G9CvfZzDTLyR2HYFJqF7p2eAB75E22LgLsrxO6xvTKrWtiAxyI6FzxiU7xlJMLkZSP0bZr4rHrsriErEvr9Y0TG43kFfh1WqMTyUInwVzNXKN1A6WkNBoB+BdSmrjcH3rBAWUKZp5AcBfl3nZMOVsxN150Ervg5zabx67TlZ0C3CBOxe7zNHfMffRbI5qg11jXZkTeHkEKMvRL/Z3uNI2A3lca0oNhcHmI1xvrsNSd24JYjDf0fTIWoN6nBvWbqbw0h8baHe2F/TdtPa90hQwD/7WFb0dG0sJ1GX9vXzVImKOLaJ08R6SvNj3rosFvMptzEyCpxLAmiDNTA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by PH0PR12MB5629.namprd12.prod.outlook.com (2603:10b6:510:141::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Thu, 22 Oct
 2026 07:55:37 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 07:55:37 +0000
Date: Thu, 22 Oct 2026 10:55:27 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Zhiling Zou <zhilinz@nebusec.ai>
Cc: namangulati@google.com, netdev@vger.kernel.org, dsahern@kernel.org,
	davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com,
	horms@kernel.org, vega@nebusec.ai
Subject: Re: [PATCH net v3 1/1] ipmr: drop packets with unknown ingress VIF
Message-ID: <20261022075527.GA3591482@shredder>
References: <cover.1792608753.git.zhilinz@nebusec.ai>
 <5271fcb94a4d9e697ed64a348e92ea9e74faab1c.1792608753.git.zhilinz@nebusec.ai>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5271fcb94a4d9e697ed64a348e92ea9e74faab1c.1792608753.git.zhilinz@nebusec.ai>
X-ClientProxiedBy: TL0P290CA0013.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::20) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|PH0PR12MB5629:EE_
X-MS-Office365-Filtering-Correlation-Id: 179b7d84-414b-4259-418d-08df3011dbca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|260925022911599003|56012099006|4143699003|260925021311599003|11063799006|260925021911599003|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ELfZYYW3TsMF6LLNvURBNMqWWTy2xXGgKt2TI3lsqSi6rH93wqrrT5SUpUm+k+X1wSjK97UESEWHIwNKFZe94gYqgORxZQO49cDL0yKwW6B+SEigGNN9flm/uu1AkOc4Q2eJ3looNKZoEpdZIkBacNNs0Ogz+0QVqjbfRDeC0jzdT3goj+a18Br/OiGQisjZM+S11EW91FurdQpNOO3ZQzcl9WtjdgyEs5YcjbzZTDlbEDsZK+Z5q1KwBCa1i+zok7H/7pFnxVS8Bi0xqRgculKPz3m64kCUVLCpKrT/Mx6N6FBoqKXf4rr83woqcu+c6klfzcCshPudzjNYCGONyqU014G0Cad9+dalJQuxHNo1vThRLS4VS/ZTbk0h19YEsvHyoGlZ25a2+t5XIo2mRTNTsPELX11K+I3xM8Ikyf9BcJbGpnWAN+vYhcLwqLComfkfjhZWnjpCgeXVBMXqyXBSwLGtfonr7rbePqNzHSX619OOFE0CuwF/L2K4V1PLPrkGGBgK32oFPkRnrtfzYM+2W1D+mSElHqBlQkWdbmnhv8QerfiAoL4fUBf/v5pvJ0l0V8EVzFbreKMYkCFik/bP2wRVP3wwwrq25Vkgu2tAg+QPSCrr2h8uMHg2UcK8KYqUQHa+B5u3P0y2owD1NGKt45VmCyV78MvHcy5c/oA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(260925022911599003)(56012099006)(4143699003)(260925021311599003)(11063799006)(260925021911599003)(261009223027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o8CtS/M+1VU5VyS11DIp1TWFbIwsboCs0TYHJmV3cQEBnUTFqbV5yVkhcUal?=
 =?us-ascii?Q?l0eWanwvzFTvOFLasChJMG7OxoD88yQ/nAHPdVhRclXPnRYgUwD0WLcBFscj?=
 =?us-ascii?Q?AyjR94SePodlyP/zsnjUvMDa6JBij5JNJm9UmwDY0/vvs9Ji9vhUmV90WHBM?=
 =?us-ascii?Q?lsJKq7GZusUdkgVvLD5TOqY2duBTjmWiGyx7ESFJpXnMLttmGp0EkldQc8aQ?=
 =?us-ascii?Q?jeFTWL7mI2VdiMuaJM1PSqAajl88rhDTtVFzqgqepof2p9+xvh5UeNbdMPNY?=
 =?us-ascii?Q?CRqC3VD4sU5hYUAb+4C/zoglK51rXTURvdaloSFvmQuBkn5PAMEvWpirPQXR?=
 =?us-ascii?Q?xgPZ2w3ZQotxMxn4XOVkIZUsTf/sCddAUuJf8VFCd7+eNAz0d1VHgNC1q8TR?=
 =?us-ascii?Q?copHHYd01k5SexkrYHQGDdMK67myjjnPZ3QXnzRx2dvyb9AHwDeTe8wHuRXs?=
 =?us-ascii?Q?IxnZj8FWB0wTLN/WC1SxVbRWMrFCEmnwGkKFxDJyNnOiXuOfil53Onir9B3e?=
 =?us-ascii?Q?pJVqbQwOtHtcAQuIfLeaiM9dqlqNl563a1RQEPvrUSuB2dXTpshvzf8xA7hg?=
 =?us-ascii?Q?aZ2N3HtuKfCeNLwol/19mUBybrLaIlRymtDk4eVJDOWWKPbzbRqkvypg7RKK?=
 =?us-ascii?Q?FDeD9NPaOCAO9gYXyf4c7xWCnSCgcXYBBt9IZeXR79RS80ycYlPQVBMFaJvb?=
 =?us-ascii?Q?2nmj+Rx0Z40Rp3QsBZaGmTpmABuYdFzjOsegXwyUtggd0jpNaiMzjmlxj1yp?=
 =?us-ascii?Q?hFM1ki6nUnShU9Xf5nfVd6EPJ9jTHN4dQPoiVfgJWyJcOK/9Jr6Skn7L+WK6?=
 =?us-ascii?Q?1uvUge8fGrudSBTVS4QQJrfypCoZfxnHwDOowyRfpC2ciWtp9B1LcGo4eNy+?=
 =?us-ascii?Q?381A+opSkaULYr8JR/vqHoPFBuKV288PNJWSz6NwD/b7hiQ9yQa6WJUlPjEr?=
 =?us-ascii?Q?C7+wmgK0k6bL+/0mM9hH/7VJ5wRk/bM/hHeQxBjAW/pCVcPwwn1h5gUmPqJ+?=
 =?us-ascii?Q?4LvXUDrXxbYh14janaX26T4cH1Ii7/lCPl2numHuPQTHkGZf3aUzYGx+1Lpk?=
 =?us-ascii?Q?gBUSF1uIWnnld0H1TFIbhOJybgr/GtQ6fc2ZkIiCpYbYayIWtBhMPMTviyhq?=
 =?us-ascii?Q?KoadmnW5l5qmdsxx37mXXyYQV65W8lBdVa31qK38W5VH8pmpPK3x0VhpilYG?=
 =?us-ascii?Q?ZXX7U6WZ1RSYPQAz5tDaDWqrSHzSkHMqibonqPCy+n6SdqPZ58ssok6XGRWw?=
 =?us-ascii?Q?4IRinXybsT3GCjkepLxA0kvf242r+n2J2fByswtd9HKYh8ACA4leGnT9m53G?=
 =?us-ascii?Q?lr2E/CDt2bCwK4z2MubU650Rdr8Ij+Ff6nMafAfF2vqH9PnvPT6BEllBRQNE?=
 =?us-ascii?Q?DuxcRYEcRH1UABZQ448MuJW8JzwSQZz8sJuxfkLa1rIQLmzIOaAOaJ+jD1BM?=
 =?us-ascii?Q?8NF8q/hW3QKQZ5ThW8chCvqIjOlbj48STfwMkfQZCmwGRUrlzW/34Ik/8hcS?=
 =?us-ascii?Q?N77a2mmGhhoruln3M7H8E5GtLucesdRDph5VI8w7Af68uE88hZDnZ5ruK/xO?=
 =?us-ascii?Q?RfWMOApUC71dQ2dEUZKZRdhJOOV1ls+UevKdvX5RRggT6JwgvW28zsnmqy6p?=
 =?us-ascii?Q?ZjxfaN7eHQU2TaA4PuLnN8s/k0g+PHOGNiDGwvXoZXs5Jf/8/Qit7Sxs+YLO?=
 =?us-ascii?Q?3rgYGqvBcgVZiWbDSIODVfyaMMYAMSekccAeF4KhU05RyklJe/gSejhtAOA4?=
 =?us-ascii?Q?p3BRnA1qNA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 179b7d84-414b-4259-418d-08df3011dbca
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 07:55:37.4691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tBjU0gK92ElnsqbPFhy/ZaGG5lib6/f3nImMacoDrK5aXof3iS5l3GY9IlCwbtUMLPNwJ89nHg+p6IwfkWlOWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5629

On Thu, Oct 22, 2026 at 03:01:16AM +0800, Zhiling Zou wrote:
> A packet can race with VIF publication and make ipmr_find_vif() return
> -1 even though the VIF device pointer is already visible. The parent VIF
> device check can then pass with an invalid ingress VIF. For (*,G)
> entries, this can also let the packet be forwarded back out its ingress
> VIF.
> 
> Drop packets whose ingress VIF lookup fails in both IPv4 and IPv6
> forwarding, before checking the MFC parent device. This prevents
> forwarding with an unknown ingress VIF and avoids the (*,G) hairpin.
> 
> Without the early check, the negative index can reach the IPv4 offload
> lookup only for an skb marked for L3 forwarding offload, currently done
> by mlxsw. The race is rare; the supplied PoC reports only the UBSAN
> negative-index diagnostic.
> 
> Fixes: 4eadb88244d1 ("ipmr: do not acquire mrt_lock while calling ip_mr_forward()")
> Fixes: 9b1c21d898fd ("ip6mr: do not acquire mrt_lock while calling ip6_mr_forward()")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Link: https://lore.kernel.org/netdev/b966eb102e98f299e45be59ada033a8766e4c6df.1791899747.git.zhilinz@nebusec.ai/
> Suggested-by: Ido Schimmel <idosch@nvidia.com>
> Suggested-by: Naman Gulati <namangulati@google.com>
> Assisted-by: LLM
> Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
