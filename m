Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010033.outbound.protection.outlook.com [52.101.201.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9387E443A9E
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 19:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789501936; cv=fail; b=UKHi9yiVPtD/N5fjsYVR6io9I0bw68B1Mb9IyM+g9c142t9eyarDDaBI8/Z2eOfxCCiXtbLBYVvtShPAYqfYQcNuUEU7QC6/nrC8zzdlaJzHtjwZegrHH24ml48qXrLNqqxlIu4JHYoAvPkfJwFYddkgVIhysK6yVtXgpSUA48Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789501936; c=relaxed/simple;
	bh=lT8kQ0XFKqyYHJYhopwf4S+qqtl3Km++qHljOykpCus=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FHOCqj+upkY3KkZWm294fMfJhzTmQ9KYgPc+Wk8TewXVLfuAN5tv1LtN5B6DjtRntCmJZxGJTbKaTL3LO7DkodXnR4+Dl3bdRqA+Y5Lz1PycTsrpuCs7tfW0kLcwegDv/W5j9TufN9jlAa5bx0COtunHSho4kFCnZan7hE4uDsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ffquwl7o; arc=fail smtp.client-ip=52.101.201.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ffquwl7o"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H4WJZt0ObBpQ7IP7T4GaW7fDD/w9FdrIUhIjqEl1OEcw3uDybbEIyqzZP3IegNTsvxkMvfpDPqJTNYE5DNGQZtdAOD3rIlsLm6XzTXEf4h+9PhO/7F/kVyEqGNjb/+9+7hNa5WJVifuOLi8/Fs9qG3Yhf7tG5VFNwQdKKsUsfqLlysEUcU2PIpKiY7UPebOsCns/J373RmRbfkNNOCJLNALPgU8RSTjaqsnawrcMv0y7i3tt6MDKU3myu3OqU2RgZbWXwAv3nXNpFpM2XgaoH0TzB0oRplYtplTfrkeQFtJmtwB4oB92IabYNvzuDKdr3+sg4MCtfTs81xENkq2kfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pL2Y+bF5D9rYxISBAoNlXETCop88WDQemd3OIJyYAX8=;
 b=LarTZ0K8zMgzr0wYgwxTEKvSGeohl+vp7/f9rWZb/z5OdoAXWOPRb9Ai0ZNXPK3XfWGmKabqjnJ3+u9hmadKmWP2OrV/VZlq+UXJmfTRXcWXlVlGAavIOE4kZS8h8gWJjK8H5RBE3TudXsNheeiTGoVo10QKUlvaTVlpwvjS7L8qubBNGja2AN9XDJgtvDy4al3AstSvsMW4BfKbNvkSi0qxD7OUOBOGLuMzatBWpBKvy5LlN07c4bTN4Ez3l1PrxtKFLSA0T2iNFdUvZ4xS30prZaTxYRIwEhYz3xu3R9ZvPxTO+HWzsm+rcdJhsA3U0CuhRqJv1jKnNxza+waOvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pL2Y+bF5D9rYxISBAoNlXETCop88WDQemd3OIJyYAX8=;
 b=Ffquwl7odI+IyXtrigb/7tjjM8g9ULDHt1mMrUDZgCZQHvgQAyhfmyync+w8z5HMtris95yxFmGMCCoZNSlpzTdMDFzIrVimQBo0/jCfAMBlwSzmXNR3klKzGgvDHeQrCr2VLOTnL8b7OMNnGx/Y3Mlrjo30XfrtQVDlmi42pUU41guEUSzqE+5nR9QLWLUvqJlzOhUVK0Ae7xEhJA2Aluc/4PfERJ3nWbPa4kwiSuSO2z5eXqWYjgtIbMOnyNJaPdDN3yw0JbZ3bPg3Yd3AMmANunv754wWhF/IBYZf2nRvfC8IVXKWOoz16awLYe+3xLHWGYJfqwipySnODGbyrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB3313.namprd12.prod.outlook.com (2603:10b6:408:65::18)
 by SA0PR12MB4382.namprd12.prod.outlook.com (2603:10b6:806:9a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 19:52:11 +0000
Received: from BN8PR12MB3313.namprd12.prod.outlook.com
 ([fe80::310a:77d0:b591:54a1]) by BN8PR12MB3313.namprd12.prod.outlook.com
 ([fe80::310a:77d0:b591:54a1%7]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 19:52:11 +0000
Message-ID: <d6f74c00-f486-42d1-960a-2a9908434aa0@nvidia.com>
Date: Tue, 15 Sep 2026 22:52:08 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/3] net/mlx5: LAG, check if vport exists on
 br_offloads
To: Bernardo Soares <bsoares.it@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 saeedm@nvidia.com, Vlad Buslov <vladbu@nvidia.com>,
 Bernardo Soares <bersoare@isovalent.com>
References: <dd3247a9-14d5-4866-a20e-b31d414ec1a1@nvidia.com>
 <20260914085430.18694-1-bersoare@isovalent.com>
 <20260914085430.18694-3-bersoare@isovalent.com>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <20260914085430.18694-3-bersoare@isovalent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0047.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::14) To BN8PR12MB3313.namprd12.prod.outlook.com
 (2603:10b6:408:65::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3313:EE_|SA0PR12MB4382:EE_
X-MS-Office365-Filtering-Correlation-Id: dae24a4a-13b9-462f-67e8-08df1362d50e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|10067099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	phG2BayUmErG9LwYk4URfCSjYLGa+3Ms5dgna4fYZqCHkjcBgrHsPZ41TTcc4MLv8cZFC0wlvRb6fEhnyuTQOtY1FjShnaXBb3OIvmH+TiRb/5Csm091ExKLIqUPuHQTwAigmESLBoSSsZ6XGwC063llbLfpQHGN0c+3/MtshTYGMnFgP1SlSlU2PB2WxSorTT/zEH9llQZv4Z72wdSW+8WNDrCm51FyO/aSAgv9QBBO2Q5OyKqK04OUOHM32zIHW7Ub5zVkW0pnRSn43mfH6fWzdtdiqTQ8Rm9BaPakYPGsWsIs4EJgqTwqH97ccAymNd7tOQm7i2lxT6YbPfED/4u1dpRqh0j90+YCLIQPmoUqOiLKGxO+UoHPIZ/zccdWTJ0/XNtIqakeJHc9Xf8Lty+b2I26Zhyd7ORMiaGmB9EXhFh7G5y0lTAoHnb5UPgSpQvi0EB1heOkim6d08Dq0PPmp3HCee7sj1zchj7fbtKt/WC41U/QESpI4hKFCas7h9w9wPsYPiaDjFjmw4wMjEdtxqPCoBy1UvH5cRf5m/F/GtlH8v7o0hQ+6+eXK86Y0mFJ3EVlDd2tQ7QJa/QX9fplPhw408fhJbvT6nbAFtEfFId6TMhybHjjozdfPfac2SYBS7Lug7dnpve5cfS4NVMg0A/0HF5PO+iaeXpP7/8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3313.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(10067099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWNiSE5GK1k3ZWhuSUZ4cmxKTldLYXkyNnhaTTRyS05GNE03UnE5bkVGTVVH?=
 =?utf-8?B?S1U5WW02bWZHQTIzdHppejFSM2gzb01iVnp5c2Qzejk2RWlmVDZRNlh1WVZq?=
 =?utf-8?B?c3VVcHpkbjZoVmRNMnZQQ3ZPLys4Y0cvZFhVNlhFZC8wQ1ZDZzJtV1Q2Mzg0?=
 =?utf-8?B?MzBVbU1OOXMyMjVKa015WExjdjFMMStsdjRuTHIrZ0xFRUpjdGRDTVVERFVU?=
 =?utf-8?B?VENMNndvaHFUeFBFWWNXY2Y3ZlVNOXNVY3Fvb2lyc01WT0RsbGd6L2RocXEr?=
 =?utf-8?B?dzN2NVVROWZQQlVjeDFYbU5IUll1OGN1SFR3eU11ZW9TREJhaW9zYlFwVVBl?=
 =?utf-8?B?MFVscFNobmtOSXlYbGtoVnFBTVNzTFppbk5xRG9CN2UxcGMvT21UUUhiVlJF?=
 =?utf-8?B?a242ZWZ6bGZKbWtmTHgxRnJyT21abDZndkNPS2Q5S0M5OWNFQVU5V3JkQnYr?=
 =?utf-8?B?bWQxb3pxREJHMklSVVlWdnY0YXU0VHJCSjFmTWFBaTZCQlFML2dTRFY2VHcz?=
 =?utf-8?B?YjMySnZWQUQwSXBFZFllZTdOQzB5cnRBVHliZm5TQkRMMGVGTDJSU1I3UWo1?=
 =?utf-8?B?ZjN5YUt3NWFBWHpZWVJWNC9GcG1jT29XWHBUNExZLzBiWEJSRWhha0JiYkpa?=
 =?utf-8?B?RU1XL1BGTWNuWmFKSzBvNHJqdGNIdkdYTHJEb0tuZ0RSellpakhJQWhrWXFP?=
 =?utf-8?B?OU5oaTBpR3NxT1N4UWlUbE1PMU04S2laL3FRTkFRZXoyOFU5UDNvRkZkczRQ?=
 =?utf-8?B?NEdNbDZOWmZiTVRqaS9aSGFNcXNEMy81bnVlSTI1U21WUitDQjJ5WXE5RGth?=
 =?utf-8?B?cmRmd09wTGlyVWloUGs0T25YZUJjQW5udXZRcHp3NEVzNXFWY0tXNEtoTFhN?=
 =?utf-8?B?b2g2U2VseEQxYUk1WmNRalp5Z3Q4bVdFWmUvcVcxNDV3aXJIWXkvNTF6Y3M0?=
 =?utf-8?B?aSsvd0JJd1J2SjVxZjRCZlhtbXFBdmVoZ1BlQ3YvMXgyMnA5STkxRUY3Zk1t?=
 =?utf-8?B?UVFVMlB6WHp4Z3o1YmkrOURid0hVcSszc2pqK2NHRkRiTm5TRC9Lcjl5NkF3?=
 =?utf-8?B?bHY4cUU3bXMyQVZ5TDVPWEtwOFk0UmlBckdDWWQvNkRPYy9KNEVMamRxZlNl?=
 =?utf-8?B?QnVRMEE1bndyaWRUamZkZEtDYlVHNWlXcDkzazZ0aGpHTmlSa3pNanEycVJX?=
 =?utf-8?B?bzViWmlDR2xjNW1hNzExZ3pZZkpUS3ZCRVZ1Y0dVVGUvaGRTLzVnNzg1UFlR?=
 =?utf-8?B?OW94QU5oZUg2YXBGT0FsWXpQenpWUkFlek9KWmMwdXVaTk9GS1FLbkl2cTNV?=
 =?utf-8?B?M2pJU0swSm5KRnI0U1RkdS9NWVJZY3ViejhPZnNzYVdaK1hUUjI1Y1crWC9X?=
 =?utf-8?B?RHd4a3pBMG54dkxHUkZFWGRzRHVZbFhyNE1EZjJhNmxQajR1Yjg4Rytna1o0?=
 =?utf-8?B?QklGeWJ0SGw2enkxcDVJZHd0N0hnOE8xYmVHaDFFTDVUSXp5UzhGZGQ3TS9P?=
 =?utf-8?B?OE5nVTJEQU92RFJEVVVpOW50MDl3RVZiUEk1aXh4L1ZlMEhzSEE4N0Y2bFhz?=
 =?utf-8?B?Nk1hMkJXYmRSMkxhd2F6aUVhVTNYNnU1YkhuUGlJMVVpSFdFeVNsYXRIMGRR?=
 =?utf-8?B?N29oVXRqWGFTaFVMK2U1Vlc5bW10NmVTN2VmTm9HNml2MWdKUGFRd1UzWmNT?=
 =?utf-8?B?ZVpYNDVSRFJDK21vZVc1bVBSdWQ5aVpFSTBES3dVWkcrQTUrbUxYUS9NUGRw?=
 =?utf-8?B?WkNiS1NReFl2QkVtMjBGdzV6cThLK2dZbjI3SHd5eGZpMHJJaVZHenRVWXh2?=
 =?utf-8?B?TnhpaEZZZCtJd2NNUmd4dEZHK3RmL0xiY0tKT1I5blFIWUdoUDI2aUx0USt6?=
 =?utf-8?B?SXRHQU1WaEVqaDhsNjZiQkRZaStVeTQ4QWMwbEtVT3U4Y2ViS2lpclBNREN1?=
 =?utf-8?B?ckVMd3ZIdzB1RUNKQ0E0NWsvVjg1cGwza3VHclhpUHBrdVkzSFZ1VnNmTDRN?=
 =?utf-8?B?SjRXcXZuVVVCV3l1UjRPemdqWUlINWMrVWtCY1ZtSjZOZG44dTk3RXZxZnZY?=
 =?utf-8?B?bXltNHFZZjkxMjdSVFBVckdxQWdiMW5oeFJVQi9PZjc2YWJXY3V2K1R4cFE3?=
 =?utf-8?B?ckZPVHRYSHFTazljQW41V091dUZuN0V2TVNVVU4zWFY2cll4L1I5RC83T3dW?=
 =?utf-8?B?QXgxM1BRcUc0dWo5eGM4NG1zN1RBbU1yUU5BZ3VBZUMxYXhoMjBoQnBEdVlw?=
 =?utf-8?B?dDgwM2wwVmRUZStCdjlmWGFDOXpYTlBkT25wdDdBbUJDOUdoQXd6dFlwWTQx?=
 =?utf-8?B?TkJaWjJZdFFVMDhvM2RzVzBmTXJwQW4rc3FCQ0l5RnNsODFDZEtrZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dae24a4a-13b9-462f-67e8-08df1362d50e
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3313.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 19:52:11.4614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dh6B932e07LUbN9qG3e16qzuv0chTCm2oBH+M2YJF73r0jgsCfIn1P7KWBrH43CC85kLhPXSAfVfiAJEoyLRwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4382



On 14/09/2026 11:54, Bernardo Soares wrote:
> mlx5_esw_bridge_lower_rep_vport_num_vhca_id_get() walks a LAG bond's
> lower devices and returns the first rep that's structurally eligible
> (same HCA, is a rep), without checking it's tracked by the calling
> instance's br_offloads. On a merged-eswitch HCA where a bond spans
> reps of more than one eswitch instance, this can return a sibling's
> rep instead of continuing to the one this instance actually owns -
> reached via mlx5_esw_bridge_port_obj_attr_set(), so a bridge attribute
> change on a bonded uplink can silently no-op on the right instance.
> Fix by checking mlx5_esw_bridge_port_exists() at the point each rep is
> picked, same as the previous commit did for the single-rep case.
> 
> Signed-off-by: Bernardo Soares <bersoare@isovalent.com>

Please squash this into patch 1.

Mark> ---
> v2: new patch, addresses review comment on v1 asking whether
>     mlx5_esw_bridge_lower_rep_vport_num_vhca_id_get() should verify
>     the rep it picks while walking a LAG bond's lower devices is
>     actually tracked by the calling instance's br_offloads, since it
>     otherwise returns on the first structurally-eligible rep found,
>     which is not necessarily the one owned by this eswitch instance.
> ---
> 
>  .../net/ethernet/mellanox/mlx5/core/en/rep/bridge.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c
> index 56592e2e6b9b..4b7b0a0fc2b2 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c
> @@ -85,9 +85,16 @@ mlx5_esw_bridge_lower_rep_vport_num_vhca_id_get(struct net_device *dev, struct m
>  	struct net_device *lower_dev;
>  	struct list_head *iter;
>  
> -	if (netif_is_lag_master(dev) || mlx5e_eswitch_rep(dev))
> -		return mlx5_esw_bridge_rep_vport_num_vhca_id_get(dev, esw, vport_num,
> -								 esw_owner_vhca_id);
> +	if (netif_is_lag_master(dev) || mlx5e_eswitch_rep(dev)) {
> +		struct net_device *rep;
> +
> +		rep = mlx5_esw_bridge_rep_vport_num_vhca_id_get(dev, esw, vport_num,
> +								esw_owner_vhca_id);
> +		if (rep && !mlx5_esw_bridge_port_exists(*vport_num, *esw_owner_vhca_id,
> +							esw->br_offloads))
> +			return NULL;
> +		return rep;
> +	}
>  
>  	netdev_for_each_lower_dev(dev, lower_dev, iter) {
>  		struct net_device *rep;

