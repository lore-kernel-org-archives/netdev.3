Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010066.outbound.protection.outlook.com [52.101.46.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449C03C5539;
	Wed, 29 Jul 2026 11:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785323462; cv=fail; b=NZNEIHDUJwV6qI884Ha3jG7fZxh9td143J1JfgGEjju9ETPX0DOVi3dqnu3eIkKV2wV0nde00Cm1nIf95AEGoh2WbCYHOLqKoUGltTRRVwUsCy7Mg0SzZ33DwBO0aD2qWYrpXG4MdO0MJqjRJWHWzB3Uvzjz4Dgt++vxWCNYDuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785323462; c=relaxed/simple;
	bh=JQvZ0EpaPxlktvbHvLjuQZONZdfawdCx9Rv47XoeyLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UV1IVQNKK31QaQybLAqPcfIR0t0bT4C4OJSsp40e7u8ylPwcF0Deoz+AXvX93NRo0tb7du1xgPj3VC7R3D3VJXkUBJ88nDuuMc1pZ5I4hsjLqdp275a2vHd/yGiAFfJUc6KAusuAJ1D+TKQCgsuKSswCdYI0IkRnyHpmAenwhuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cSEhSSiO; arc=fail smtp.client-ip=52.101.46.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cSEhSSiO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qrVMIUYeNJ72WM7jM8FSa7nuMG5IiyJDLD2h6xnV44u6ywrKwhocvjXxQ+iIxh3laTgwqyypGanPIv/Jkt3ugc/sJK0FkJOM2ePkM0EJLs76WqYjIwIFTdsjpSZZp2wtz1wDfLP7iJCL+YyzUOHryehAIdMlklaxB0HIuw5diHGBYy8GlS5lbgF34bXdtLzj52od9iUpQp0f4DLwAlivkkCkxZBMQb/UIpoJ2DYx4AKnFGnJd+VwnPfYecxImommOXGDGPn/ydlxZ07qkXIChS/8BNgevnmBe8Wugjj+nXThRwBT7ZredNpUE9AMciExP40iGceJII9/iVXOp09I8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iC7dtNco2V/t9xLMisHnYVpRZR8cNE8aAPd8bIRINtM=;
 b=Vgco5xXYrLtKyEf/FlKoMRURo/Os/DDlGe6fE7apOBl1Mp4L8zZN7+SytpufgvlolM5I0u0j7tzj0iS+vtot97UThXX7n8Ps9ZbIIZgKyDXoHyTzTIM8UMV3BgppvF6CKmif716KpWjyilR6PA34nU8BQCfv/+ZqcvvMgGHdA1/H0NbRBOj2nH06sejgkQziMzNhzx40QYyv1iKmW6fPzXQsrBz5C2zee0Tfa2CRwYOiwx8jhMfv07NnXRv9WW3UYFmnYxWaOndHrJJrsCDJjfg0kw1PMMq4/MX9ZqOlqmKK7Uy146XYS0mSoOP79eJbJfk5JfIOozjHyhHa87McYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iC7dtNco2V/t9xLMisHnYVpRZR8cNE8aAPd8bIRINtM=;
 b=cSEhSSiOdfOlwXJJE+s/Eo3PlBeHQKgkGNQEFn2XyhOzoVqOY2aF2FXC2KCFY3lxWBrtKEOQhb6mwAq/f5WKcpG+O5rQfcR49+5L1FHeXIUCQumvNf8NynpQsLiPtsEpEvUs+EIkcbnZyZHS/lXQ0Fbf7vCbufUKHliBtZOHqoJFY0abp5U2tXSWLWEqhDcTmdqZ2/EttIug70mrBltHpeNmn9gghs8thkGbRkjtXCd4r1Z1ZRGOXnmsnc+rlZB7uOpXZa1XwelKFsvNoQSPfKHDe4UhhFmJT0lcUEArt2Zq2eLk24gIgvmN+0wZrEPUBqlIbRKa77pYYUsJUNcW/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by MN2PR12MB4360.namprd12.prod.outlook.com (2603:10b6:208:266::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.13; Wed, 29 Jul
 2026 11:10:58 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 11:10:58 +0000
Date: Wed, 29 Jul 2026 14:10:50 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Minhong He <heminhong@kylinos.cn>
Cc: David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ipv4: nexthop: handle errors in nexthop_init()
Message-ID: <20260729111050.GA1311000@shredder>
References: <20260728031055.76708-1-heminhong@kylinos.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728031055.76708-1-heminhong@kylinos.cn>
X-ClientProxiedBy: TL0P290CA0010.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::14) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|MN2PR12MB4360:EE_
X-MS-Office365-Filtering-Correlation-Id: 7de9d279-c6af-4f54-540f-08deed621101
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|18002099003|22082099003|56012099006|6133799003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	lL5p0s8AMV7TLa9SEU3IlZABItEOzIEYSloVmRW+kast7+ZbszhJsRN+khVmJFNmLYgEZn9LYsR1DuA3fRrW2lVoQ+g9bmDfD7BNQEUtcZREjfSznfYf3+AaRPAyMkqYV3CzuheNe/yLUcGdqDv9u/mhrajuKSt5Ah4YSi1/ZAk1pTCFpvgCYYZTm7SH5M8Mfhfi4p1F3VRqtH0A+UCX14s1FT481nUuYYyKF3q5WnGp74/TIGhfyLF/7Wg+3RW9AILG8lDTbRsYAiLtNmyf538rKeFhpYwytQOL6jDe4NrKYffK/z3kZIhgiOXj557X19C/yh1fCxfVT2iNRAzSKoKZOUEYuK1nhErrhIAscAO7RC4kkMQiCxWpJTtGsW5/PlJ9WaWniiU60Psz8DfLOchfrLMr0891TJylWkLRGGLQllQ7Yn/MulqfVwJKXS2VkNiHZpv5UNClS+P7dG9g/iGT6uql5zvsV6jgF+eV+LcSGshc7vgywdRIUJRcCE2h2V4gRRoDYA0Yb23W/joQ92yKl6xAubJDrp7UyLSDVs9CtAQ0L4eqfhJCtnui47u9wQSW+EuYmgBE/0xU8xsuWiQRfk8diLDxdCAXEcL97InwHh2n71ML1ikZHDN0UDreSnxPAi7vOE5ljP+kACLs7xlFEjrzIe05gpzrwirtOEA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(18002099003)(22082099003)(56012099006)(6133799003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FLMAV5RRcHUGw6gfV90FiaaqjSJqyRwZma88TZldXAcT3d5s2PJhR2arzacd?=
 =?us-ascii?Q?WJmYmEH+wXzma+yTTXFa5I+6TkS4X6bl15YOWhwkkeqjpf5+bcVxApwHdnO0?=
 =?us-ascii?Q?581GFwzBywovETYnFKVYKE264ZKSKqXohQVEfTWn3fqnmsy6bIdRCKYWTy5Z?=
 =?us-ascii?Q?BXCQ5rvnynXjfM9pibSTVh7EcbHg7LwCDRG3NPMD+pTB/MF3fQZ0PPSYlduh?=
 =?us-ascii?Q?q8GNR7ogyAvIhT/mZ64mysICYH4NA4l0Slzp6vGcj2ebONMn3hJDT9J9ZCTa?=
 =?us-ascii?Q?dmw7ydC/lRJ24mnxjhy/+ZRapM6AnJuA6wggeshlJ88RSfL8IGi66o3ytK2S?=
 =?us-ascii?Q?35cTtFb6om0PIAUMTeBNoxOLKLw6EVktM73EUjg2kBEsscZ69a5GFUUCVR7n?=
 =?us-ascii?Q?xjAssrvvko9qCCo12G2GRhAgzCj0mI4WneSGWtYcdb8r7owK95Hlm69kzArJ?=
 =?us-ascii?Q?8terau/cMc6t6HS9lPqw1sNNUjWu5t1afoUKjtyJwq4TqKCYNMF8Sg7G0PSG?=
 =?us-ascii?Q?3erSHcFH7anI3Z1b22G+gUfmf16yh6oVC6moKrCHCzjoyrrUhcE7xKsEum1Q?=
 =?us-ascii?Q?ESPO8X+Nko/YthCu3sYeK71JLT7rp9DHapGagW5sCRw5SgxEitn0BFYsjORq?=
 =?us-ascii?Q?WVZY8zHjsk55eXvKm3Jp68nOMVYAQcmxCWP3uIeiOijEuqy+2d0XmBDklY5/?=
 =?us-ascii?Q?S4BgQbDGcAnDhoqZZ/o3V0W9QrbArZX38M/7Kn9Vm7W7C8qSJLJvpzk6AnHl?=
 =?us-ascii?Q?FZv8ewcVSe+yiDeCPsieUamGxyC4rAVX8ObOj5DCx1l/CgU+a3J5PFU7Jl7f?=
 =?us-ascii?Q?JMEDC/NGZ3FIQbOr+RdHWlcSykO7rYj1eFLqnyrU8qgYCnyTfkkja86uUZA9?=
 =?us-ascii?Q?a0RuLePDZT7X26bl/xZQ3XFqzdirOCo5dMIveS/Vq3mF3iJDL4h3QJ4zvjko?=
 =?us-ascii?Q?Y3htcEpgb/IDiKSfJkVxaMwNvNTV6NydUi83un3Y/1GNUYa7uWiY475uOdQB?=
 =?us-ascii?Q?/ofrMqjIK4xYeKXttYf/5666oXjgXlQaTjxXfeIi0UAdJrOuQxsl1yslNotB?=
 =?us-ascii?Q?qXsplAhLkwRcUe3ifE5POIshQj7vZrvYbeNBa6o+wA4UmJM0O0KQhIhCmtJR?=
 =?us-ascii?Q?f4KiQjhw42P50vFWBtVbR/UHZPTFyI+76Ny51Gp+esMrbRxUYxqu523efrmW?=
 =?us-ascii?Q?pZO/cx6T8+eGQEphwe3VHLAXNf4CgjMCDg7mQp0cEy4Rh7UOUpy7qxPl0Nww?=
 =?us-ascii?Q?/Qv9JgyF4QmME7ofN8cwSn+DwihLkxMSrYvgzy1XJWeSosK/KRIoiQxZmdgI?=
 =?us-ascii?Q?OFWz8bRSS5WcSxcLk6EJZFtvQEhTuGJg40SBoEhVhhFvp8RHlfV1zWZ6nV8u?=
 =?us-ascii?Q?wAkOlhwhJ/7fSsY0R72Hi9nHU0gkOwbKZrhhkYE2zomyVhtkhcysS1qkZkJ2?=
 =?us-ascii?Q?RyJ+YCT2KLNeFt4fhIcBJPI3a3IrJg6UgsdQiSvoleGKWfSF2+hr5gDQQOG0?=
 =?us-ascii?Q?6IzN7yyUy2Ckb+NoKLFL52sbTyz0qEAEyl5hnZkQlgdafAp0OYBDeVSlBO2r?=
 =?us-ascii?Q?uGDymySwoIcqVOydTBtSOO7V5Ti4cwb+T/cJvsVHB/g2kyZqUd8fl4/KqN9p?=
 =?us-ascii?Q?0kZchmdW8QbC4XMio+0/s5mFwEe/6b8IvHgAknnkBjIrMm8maajYk1xe2zxK?=
 =?us-ascii?Q?Nr6ZLU26zPzdKNGWLexN9CzRZSn5Fy4GiNDziFoqTb+jkg+r?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7de9d279-c6af-4f54-540f-08deed621101
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 11:10:58.2329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nz4QP0tVoi1Ie2RRaO4GbpEe4u25QZe+ayiTYjxCewvuMI5GteTUARTv5WGNrIGzqwNlg+JTHWdIlu2VonaUQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4360

On Tue, Jul 28, 2026 at 11:10:55AM +0800, Minhong He wrote:
> nexthop_init() ignores errors from register_pernet_subsys(),
> register_netdevice_notifier() and rtnl_register_many(), so a partial
> initialization can appear successful.
> 
> Check each step and unwind the registrations that already succeeded.
> 
> Signed-off-by: Minhong He <heminhong@kylinos.cn>
> ---
>  net/ipv4/nexthop.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
> index 6205bd57aa85..0ad40d93e3b5 100644
> --- a/net/ipv4/nexthop.c
> +++ b/net/ipv4/nexthop.c
> @@ -4192,12 +4192,26 @@ static const struct rtnl_msg_handler nexthop_rtnl_msg_handlers[] __initconst = {
>  
>  static int __init nexthop_init(void)
>  {
> -	register_pernet_subsys(&nexthop_net_ops);
> +	int err;
> +
> +	err = register_pernet_subsys(&nexthop_net_ops);
> +	if (err)
> +		return err;

This can only fail if the allocation of devhash didn't succeed, which
seems unlikely (boot + GFP_KERNEL), but OK.

>  
> -	register_netdevice_notifier(&nh_netdev_notifier);
> +	err = register_netdevice_notifier(&nh_netdev_notifier);
> +	if (err)
> +		goto err_unregister_pernet;

Can only fail if the notifier is already registered (not possible) or if
the NETDEV_{REGISTER,UP} replay fails which is also not possible given
that nh_netdev_event() always returns NOTIFY_DONE, but let's assume that
it's fragile and we can't rely on that.

>  
> -	rtnl_register_many(nexthop_rtnl_msg_handlers);
> +	err = rtnl_register_many(nexthop_rtnl_msg_handlers);
> +	if (err)
> +		goto err_unregister_notifier;

Panics upon failure.

So, I think you should drop the error handling from rtnl_register_many()
(explain why it can't fail in the commit message) and target net-next
given the lack of fixes tag and that the issue is theoretical.

>  
>  	return 0;
> +
> +err_unregister_notifier:
> +	unregister_netdevice_notifier(&nh_netdev_notifier);
> +err_unregister_pernet:
> +	unregister_pernet_subsys(&nexthop_net_ops);
> +	return err;
>  }
>  subsys_initcall(nexthop_init);
> -- 
> 2.25.1
> 
