Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011063.outbound.protection.outlook.com [52.101.62.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3792741DECA
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 11:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785409603; cv=fail; b=L0agec7ozPgu8eDDZ4HnDnlT8SxhtL9Vn01ycbwYeBNMyh/hGyZjhUwjx0/M0LoxgbemJWp63q8ZOwQQEKjibpezoRYS3ErLr5vFDtOhXDRDJJPBgY5n9+8vq7NtiFQ0WqF/YkKO1ptuCdQvpOK8Th7xQERIJ+JIeQbAwVDz52o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785409603; c=relaxed/simple;
	bh=KjaqASYOqniJeQRZ2A7aDHUuPiguEZ6aizeJMQ/dDXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z12roa/5oxrBQwu4Bjelp9BuDo+dr/Z/XbRZuAuWz50f2S6x0tYQ9WRE0ZnaKd6lfeUPDmWXYrOe+XZwpvc4kv41GAdeK+U4staVGZ129Zr7d003TjPhMBMmIPWNSVCDHYtB8JoTSjfSBpA7KLh2YCYCiaz5ZklmWJmwVnKSNf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iwxMsjpE; arc=fail smtp.client-ip=52.101.62.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iwxMsjpE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JIcGdV8Br3iyrXVILj1fDOTA3rAv1nDxSofta4zH9pfTaVKEpNrRPMmJmOrW9rWTSIoGVeBehL282reSDHdr8lWbh2e3EKlUBIs7wenZh93TU8QeZJmkMWioBLV+IIzSgVWJuqIEVbNyjgdCP1zAcwnADSqTR8qWaOVdYZxwUuVCRkHK/rNcyvjcdb6vUaZXcCEIA3eEeBNfyJ3C5RhLHJnS6kvXHUrwp/8vJRooyL1Jhah7vjAAH9i0225moKxyZE9y26+h6/nB4iqa9fJht9gfRDCeOFh47jngVmXlC3m4CyMEjdZeWQPpT4fNybOriqvkQIO45Crpb4pgqRIyTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XrFpVtdkU2lnEpEJ229+cmIP4QlViVaYPUccIbLxBms=;
 b=PBcbIFpDrWDkQCWHKW59FTuM8Zp3MrViTZLrd7yZMO9mIqDm2ebXLJImudj2xpLZZF4wCPc6sFhYSBYKDPhOCyk20d4vf5F8A4kuYtyHSz1sWlfxqFvcypP2uMG++FpjyFBDY8T8H392yDZnVHMT3OTG25bmfZ/iwrYv+LsfRSYMyIGOOYBmxHAG5trXyH4eXE5dh6x6qpuVPjiNl/vCfSOsP6NGoJUVYifk8B9kmBAzEg8uDB66vM47OBd1jen3KIhtIXVLGx0+ZBhETF3QepQ4HRrS9mXPKy+ixPLthQSEuNACMnN+lpWXxNZeTxhvtyFJfxoJnnUfpzJxiQO4TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XrFpVtdkU2lnEpEJ229+cmIP4QlViVaYPUccIbLxBms=;
 b=iwxMsjpEcav5ImatMvSUZssnh1YdxszkualHZUw72cc5V/QKcFaOsMnHtgVAV31OIAg+iB3G6ML4kLnd7QWb/EVr4VKEN+u+bkRK0RStBD3MYJzUm3iKI7hoFLSqK+0x1hzFdyDR+DCDDNlWc5qLOysBwP7+awLP9Ljs3snU2/ajYHwf+0xxflV+yBvEUQev9S1sDL2Reic1sy1/m9cmbDpKgDs9LkqDc8FvO5SXpTXu0jq4FgypXSi9MaXvagpMh7AE8BG4tYNBw/4ktMKJmukPzafRAnWJxPYYF8+i+O5+c9Vl/nkFyS8uksPjAjkJ60J0aYiAGUMuQzxg9TmhVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DM4PR12MB6109.namprd12.prod.outlook.com (2603:10b6:8:ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 11:06:34 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 11:06:33 +0000
Date: Thu, 30 Jul 2026 14:06:24 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Ren Wei <enjou1224z@gmail.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
	vega@nebusec.ai, zihanx@nebusec.ai
Subject: Re: [PATCH net 1/1] ipv4: Fix fib_nlmsg_size() for RTA_VIA nexthops
Message-ID: <20260730110624.GA1683700@shredder>
References: <cover.1785058094.git.zihanx@nebusec.ai>
 <3dac596cfe0ad1559c1bd1314dd4777dbcf22ee2.1785058094.git.zihanx@nebusec.ai>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3dac596cfe0ad1559c1bd1314dd4777dbcf22ee2.1785058094.git.zihanx@nebusec.ai>
X-ClientProxiedBy: TLZP290CA0001.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::14) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DM4PR12MB6109:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c78262c-9f3e-44bd-048a-08deee2a9dce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|6133799003|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	vZiBz8gWfoQNleq5ms6Y3pPPTUoG1ZPEr+LlqDM28pA9QpT4yMxZALjtXHpmg7mBHUe5NwhW96apDmncaz92tWkynjxwGEW/tEkcVtLhl0D1jPa08/TYBiu0UZyioP0kxdbN1VXaw+ApMOHEawc+zziNLCZOl5NOKR+R08hHZs4XWTFx2zgKbX5Lq457wLiGX/YzTq+2eOJuw0RDrXKbocDU2xT7tJozKIOt4YeGhBYioafuRb1Tq4HxD5WJCMkP0EVOPTxe6DW1rt8CPzyBMPVTszwoLEXE7/ED2pU4V/lgbdJtMVPKa+V+6DS+bbPWZsMfdZwgrVp39wWenM9dgk8XgOkvMCYLKPWFIIQDtOvAV8vYcfs6d+qBD4vEqcJEBHajl+bIbavbNcHctoRoOdFxnueUy+bXsOQylLgjENQuPhV9EqlD3jcGqicwRCFHNZxg1mXnGrhjuklSIN9OAqNGJ+zaS5COCMzC+gR1tNzdbnRGNF6//iEo+2n1lgbtgbvKw+KYEhPmLLcYGwvuAstogg7gkwPf0NUEVoo9R7gXqtNMPeJU8qJbLF1POUGPmzQlqt2q5iMNZC/WGdYKnvsFvMbtYBBiuLEEYkjDOQKt8nh0gI5DPmRPa86P1P8MNZiJo4NR/ZxHfvp/Igel8nu3LommdO26ov2s3wmbBKM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nZOc0n2OFij+MXp0X45X5MiRWC/R5WhHAw1QcYsj6XXnuwDzIv/J5rQg0EJT?=
 =?us-ascii?Q?HJ96BB3cHQN8zxR+AuWmhG2uxZyDWAa5/fOwOMQzUSvOb2lgCoiCa5ihhqvF?=
 =?us-ascii?Q?ac6FsYXhgWDSTC8l06GYqcQeiWfMi6OTKFv++WNV36MuFQmwlqmlfWnOubAz?=
 =?us-ascii?Q?+U3ugCfWcxz5kj3wmwg51sXu31n+OGRijG5HZ5sDlO/yvo0I96w9VEr+Vgcr?=
 =?us-ascii?Q?j7gS1J+ydGqB+9PdDkX1IKfDqRjTEjHWa03VvjyR5VMJMCsw0wttX9LtqS3H?=
 =?us-ascii?Q?5xF7qMbS2KPr2TD+v/sXHKMbI6xNFtHoLkdWn9Dx7QiIyWELGVYB1FPzLA+S?=
 =?us-ascii?Q?C4WKlqc7YqMKlifCwvKSn/LAy+p8MTjciToxdRqSJn3PdFxSxNz9p23pyhu6?=
 =?us-ascii?Q?tMPCXdOeVie06zfZwxeU2O38AUKxaur+AsE7x2G1+jQGxtMAq0JAg/6C0sLS?=
 =?us-ascii?Q?cxvJTiczIQXIWesGdLPIF6rzmFFCAPahjSIwLqqGs4FIlrmmGVPerOXNdoff?=
 =?us-ascii?Q?AwdVXK3YTKmtNQRGoTfIQkI5R1yY03/REKVw9d4JOlp4k6IO6/HEtyJBVz3G?=
 =?us-ascii?Q?t6vDBXDtSU/wZe5MlorXhkpyFbIw5oJOJKJRJvTdaTkyfIDO3w9OlIObaxtW?=
 =?us-ascii?Q?W0SLd1BGXdwf5TRdt9eaCWHEogg/2iDy/XJ1i6nyiNM2l4NhAyS8QI6miZKy?=
 =?us-ascii?Q?ZthJb9IjWKVoOO++OypFpA/2i0NRKgdwwWO/HmaynTeg6SB/l5E3fM5JZ6TL?=
 =?us-ascii?Q?rdxyor/CXpBowSwo9/FryNiwtPZlj4B4NYMlDG8L/V38UOseTSOkeQ1pDAbX?=
 =?us-ascii?Q?w8z+RsM9S3UgvTk4Ac9QUcG1OzJlu/fv560DlLAj439rFuJM6dl8vE++OO4W?=
 =?us-ascii?Q?3WKdOcHCYF0cOePiNNTrjD9/jUG/J/OcUHXhypvzeFgYhrF06+ywwgblcoqb?=
 =?us-ascii?Q?YutrC3Bae/8PmaOTTgB43nPcJXBgbhRyb7HIRVcFVNsAiS2X5eAqv+4ci0QC?=
 =?us-ascii?Q?MZaX6RMZarORU82V1ES5GNStSQ2Ba97Xc14WyU+2iuuCCrxqz7CY/h1qYgK4?=
 =?us-ascii?Q?/+hnoyzSpx7XwgZI1CRs1ZBZJtY/kn9WT3lk8E2H3eSuYrmm88bRaNYELJTS?=
 =?us-ascii?Q?hq46cvlg0pMe45pafML1clqYCLp3SZyh9pQav4F/5xcCx606WWIbxbZOHP42?=
 =?us-ascii?Q?A+Q6fRt2aAzknSSBOgShWYsBZ1qQEWI3At/9UNcXbPL5IczJDbEGZ4nQIWZo?=
 =?us-ascii?Q?Cy+FG25Kv2XITm1xg+KYPYoeJ1ivbiiGRF9ZjBl+CaTzC05jXh6TP7Sf0Jzc?=
 =?us-ascii?Q?lnElmd/pEgQUzDuvzlpY/63BoXPo1Iht7oCso2NhSuOnT5h1oLcmKkaxeVkv?=
 =?us-ascii?Q?1yUjmC4b6vEZzVeGLlYGVNKm4JNP1OfM1HGL1YjChDAnqFgjU02a/GIr8QSy?=
 =?us-ascii?Q?bVf9UBhwJx9zFCUWoGKqhgofW9W0l5chJK8+d7gjGMY83heNB1ifBTY/Ez+A?=
 =?us-ascii?Q?oCCOxM17vm6X9w6WX/pUORbTU5EaxGu3xyhZRljUfv/FaXcxbqlEdf5MNqby?=
 =?us-ascii?Q?ahE2jZaupPLfpCKM2nt+f8TdS7Lovu1QTUdd+VkIIsMw+vgQe47cDjUFBWd9?=
 =?us-ascii?Q?HX9BaxmAdF3+u8zMdKDBKomR+wRZIKq2galT4i2Uq3vZR4G2zuzgHSbi9ts1?=
 =?us-ascii?Q?ABFo5lbtmFDi1onQBs4xgi6U4CpVGTMZBGs3EYHZX5UvZ7JXWW8qgEQ3R5T3?=
 =?us-ascii?Q?49VBdZrV2w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c78262c-9f3e-44bd-048a-08deee2a9dce
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 11:06:33.8479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p9tLJo+13y95BKr7vZYCEa71eJxtxTaD+R2cbhpZ1wL66UIB2oTyUYlgEBe62ewP0alrv1ru8JxueWoaaSRaGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6109

On Tue, Jul 28, 2026 at 02:14:20AM +0800, Ren Wei wrote:
> From: Zihan Xi <zihanx@nebusec.ai>
> 
> fib_nlmsg_size() still estimates nexthop space as if every gateway is
> encoded as an IPv4 RTA_GATEWAY attribute.  IPv4 routes can also carry an
> IPv6 gateway, which fib_nexthop_info() dumps as RTA_VIA.  RTA_VIA needs
> more space than RTA_GATEWAY, and multipath dumps also store each
> struct rtnexthop with nla_reserve_nohdr(), not as a standalone nlattr.
> 
> As a result, a route notification can allocate an skb that is too small.
> fib_dump_info() then fails with -EMSGSIZE and rtmsg_fib() hits the
> WARN_ON() that marks such failures as a fib_nlmsg_size() bug.  With
> panic_on_warn set, this becomes a kernel panic.
> 
> Add a small helper that mirrors the per-nexthop attributes emitted by
> fib_nexthop_info(), account for RTA_VIA when the gateway family differs
> from the route family, account for the no-header rtnexthop layout used
> inside RTA_MULTIPATH, and only include RTA_FLOW when it is actually
> present.
> 
> Fixes: d15662682db2 ("ipv4: Allow ipv6 gateway with ipv4 routes")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: Codex:gpt-5.4
> Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
> Signed-off-by: Ren Wei <enjou1224z@gmail.com>
> ---
>  net/ipv4/fib_semantics.c | 71 ++++++++++++++++++++++++++++++----------
>  1 file changed, 53 insertions(+), 18 deletions(-)

Looks OK. A few nits to fix in v2 below.

> 
> diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
> index 4f3c0740dde9..3b6f6cc9ffe0 100644
> --- a/net/ipv4/fib_semantics.c
> +++ b/net/ipv4/fib_semantics.c
> @@ -490,6 +490,37 @@ int ip_fib_check_default(__be32 gw, struct net_device *dev)
>  	return -1;
>  }
>  
> +static size_t fib_nexthop_nlmsg_size(const struct fib_nh_common *nhc,
> +				     u8 rt_family, bool skip_oif)

The 'rt_family' argument is always AF_INET, so it can be dropped.

> +{
> +	size_t nhsize = 0;
> +
> +	switch (nhc->nhc_gw_family) {
> +	case AF_INET:
> +		nhsize += nla_total_size(4); /* RTA_GATEWAY */
> +		break;
> +	case AF_INET6:
> +		if (rt_family != nhc->nhc_gw_family)
> +			nhsize += nla_total_size(sizeof(struct rtvia) +
> +						 sizeof(struct in6_addr));
> +		else
> +			nhsize += nla_total_size(sizeof(struct in6_addr));

And the else branch is unreachable, so should be dropped as well.

> +		break;
> +	}
> +
> +	if (!skip_oif && nhc->nhc_dev)
> +		nhsize += nla_total_size(4); /* RTA_OIF */
> +
> +	if (nhc->nhc_lwtstate) {
> +		/* RTA_ENCAP_TYPE */

s/RTA_ENCAP_TYPE/RTA_ENCAP/

> +		nhsize += lwtunnel_get_encap_size(nhc->nhc_lwtstate);
> +		/* RTA_ENCAP */

s/RTA_ENCAP/RTA_ENCAP_TYPE/

> +		nhsize += nla_total_size(2);
> +	}
> +
> +	return nhsize;
> +}
> +
>  size_t fib_nlmsg_size(struct fib_info *fi)
>  {
>  	size_t payload = NLMSG_ALIGN(sizeof(struct rtmsg))
> @@ -507,32 +538,36 @@ size_t fib_nlmsg_size(struct fib_info *fi)
>  		payload += nla_total_size(4); /* RTA_NH_ID */
>  
>  	if (nhs) {
> -		size_t nh_encapsize = 0;
> -		/* Also handles the special case nhs == 1 */
> -
> -		/* each nexthop is packed in an attribute */
> -		size_t nhsize = nla_total_size(sizeof(struct rtnexthop));
> +		size_t mpsize = 0;
>  		unsigned int i;
>  
> -		/* may contain flow and gateway attribute */
> -		nhsize += 2 * nla_total_size(4);
> -
> -		/* grab encap info */
>  		for (i = 0; i < fib_info_num_path(fi); i++) {
>  			struct fib_nh_common *nhc = fib_info_nhc(fi, i);
> +			size_t nhsize;
> +
> +			nhsize = fib_nexthop_nlmsg_size(nhc, AF_INET,
> +							nhs != 1);
>  
> -			if (nhc->nhc_lwtstate) {
> -				/* RTA_ENCAP_TYPE */
> -				nh_encapsize += lwtunnel_get_encap_size(
> -						nhc->nhc_lwtstate);
> -				/* RTA_ENCAP */
> -				nh_encapsize +=  nla_total_size(2);
> +			if (nhs != 1)
> +				nhsize += sizeof(struct rtnexthop);

Should be NLA_ALIGN(sizeof(struct rtnexthop)) instead of
sizeof(struct rtnexthop), to match nla_reserve_nohdr() in
fib_add_nexthop().
