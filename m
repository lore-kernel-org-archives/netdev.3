Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010058.outbound.protection.outlook.com [52.101.61.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2D04D8DB5
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 06:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790059978; cv=fail; b=lPWMfjpk5XNKmJHkMoaxZt5N0+HsfK3DLKweYcXminquiXdKxFBe0d0u5aeStp4vqTQX6DYIX/Lmj/WjXqqDnzv6s1jYw9B+93lmumw7CJ8736EDmk50kzgXFKxJIOCSj/QY1hQhi3uRjMWcu/3KJx5vOJn3qAxYaLPpJRjOXhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790059978; c=relaxed/simple;
	bh=oGB3dkJRib1B6pdtY46RKDnT9KmW6Jh91zPEmBX/fTI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DI2V0uFjU9j6nEYBYRadGwng5xSzUW1ijllC9GvhlR+yJhjuHF8lB/QRZ5mcJEd5BO05zF/YNLLTU+Ud5D/zp71rChMSHb+Bc+D04VW5T+VCt+D0FpZ1q1PefPu7qlJ0sNEDCvapn8nVhR+1kJziY709Rwa/JUaERkv+ARvdcHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bJWLGR0Q; arc=fail smtp.client-ip=52.101.61.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bJWLGR0Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k535XiUofNw3ht9EVzmdgNiXURFUv9g7z8SIhRUn8DsGJFbn9/eLypOXnYy0ldsLbuZDd4ZvrDAXquTtWMgav4jBRmxpXhP6CXCz691XqhAf6gyIrXykX02EAFabYw3B2cg1z9siZZZaHttPaUGFZnnNcKi4+t4yMWGxK92zh6Ka6VQwXRvoc2DhhSF6sZJAj/Q6l0VjcUbn0fAPfGbDct6hDdBqoeXI2pC1cY2Ao6aAff/YLoeNX/8QQSg6sQrrXi/PpZ+lUzXts7EEcSmue2JDCagrcPA+Dgsfrc88OfvYevTgB0IU9aHWSVsgIKzTptwkjPyqDeSURrCgW1daUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/JgxlAfEGsLXtkkLHw+xOYFrJYzFDQAIMO1c93H6C4=;
 b=DSLa1gh95ql536appuQKPl+lWmJtDdcgUDUVKj3Fbj8ZIKXcvjqPN/Wa1V4BOCIHYWe8wdhzph+CS4EG5hGt/+iCeEvm/yZb9IuguEdh2eF+L8ueEUdhtBYRzBfIMC4A2PsncaPEsfIzS2Xkv5lJ2ytAD34KGdsw1fgBcx4aJq948N0jUEuwjyX3iAhfIkvqhP4XAFrryLvDK3DaNGuFT8jS+ZAZnHCnrKPAVwnKvnz9Hu+C4g+fruwwyrIR/Mw98FPTAb8jZi5j6EK5Lg4Tchpss0N93VasckJQm3cPJhBxYBzxlBpDMCINDsiad2KP2cRb5pBr+cGI4IcWzcZFcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/JgxlAfEGsLXtkkLHw+xOYFrJYzFDQAIMO1c93H6C4=;
 b=bJWLGR0Q2poP2hMcf3jnuFRP9JeA5sEsJxDxTS/rPz3ZwuV1JKnGXvY5ScD1n6BFaIRuVaC9yFrLVbQz0/aJJK1/eOwj7IpABsuSLbO/lhiBNGwCIwbknsmFhF8/T2umicDD38YbxMjEDaWACPmxrHzjUwPsXB/NfnxPYQEGssvUmYBQvWxqDLj/paZcksm51xQN+FrUA6UJ/XmxKxpVb6OV5hV0eKCg38mVKn6x060qUzNjxasmHY5sO2xWUgpzwQZqMOrTJwy4XFbzmsH+syG02f3TuB+8DGgQ6yz43Ebr2kkZ5yrOmWFR/sUyk0RrIaeFwEwhCkQnS8xfoja+hg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA0PR12MB4367.namprd12.prod.outlook.com (2603:10b6:806:94::13)
 by DS4PR12MB9795.namprd12.prod.outlook.com (2603:10b6:8:29e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 06:52:45 +0000
Received: from SA0PR12MB4367.namprd12.prod.outlook.com
 ([fe80::2815:8a95:1a44:be1c]) by SA0PR12MB4367.namprd12.prod.outlook.com
 ([fe80::2815:8a95:1a44:be1c%6]) with mapi id 15.21.0428.011; Tue, 22 Sep 2026
 06:52:44 +0000
Message-ID: <887bb829-6770-4431-934c-72ce9b799280@nvidia.com>
Date: Tue, 22 Sep 2026 09:52:39 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 1/2] net/mlx5: Bridge, don't fail switchdev events
 of sibling eswitch ports
To: Bernardo Soares <bsoares.it@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 saeedm@nvidia.com, Vlad Buslov <vladbu@nvidia.com>
References: <20260918095931.29792-1-bsoares.it@gmail.com>
 <20260918095931.29792-2-bsoares.it@gmail.com>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <20260918095931.29792-2-bsoares.it@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0015.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::11) To SA0PR12MB4367.namprd12.prod.outlook.com
 (2603:10b6:806:94::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4367:EE_|DS4PR12MB9795:EE_
X-MS-Office365-Filtering-Correlation-Id: 061c4d18-f47f-4324-ab66-08df18761aec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|11063799006|6133799003|10067099003|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	jA3R2DmsbS8rfqerJydwfX1CKdjM16M2U0KyeTeZ5qtFoEGl2F2Wx3sIghXP1qKbpmcAS/6c3JabWs50aqMmSyPHO8ZZtiI6DhYirdA5mBrCxjBvp7WPLRZrwLz9RvZAJzLG9rsyNfiBQqCajaxZwIQfw5n/ZVz4wj8DVAD9Ui/IMpzC92rxc58juMLSqv+hOEUi+rpx7haoiVMChsn84KDvKNoNWksL8QG68wjBu4vNZdgDJnEtMzXVnZN+qCX/0hiVr4t3cSjoxbg0qFKCETilYekshVqziR/x0hhXuEYc0Y/AKefn0apD9cVmS3wmgfRBDz8EV/zWO8iycMXhixnZNtJHS7Kl0/hPRGKvwUdBqHXXEUNSORhDqCmf4DUNFDLgEDTaMHkzwnyU46rDto8Z5fzDgFJaCVZpoOSlRC2O3SPyCOjdALpHeMKJznQ78D0yCUJ1ODsq6eZPGwxTmFy7a0+N+GH2WQIbp3EKC3iyEJceQntqXipKtkPMfUkGHYus4cCoa+RFk+3KCNLja4i6mcuA73mMEUSw8XkBudYRBs6FrvEuFG6dTo0XqZ0D39PrjtXqEVVfoReHwa7/6ldndSexfGvYP0V5OKnRKjZ5n9DxC5akN/n9B/fIlFOanwiAIWq1/djqh0riiHw7WmwzF7TXviuCAa06O1f0wkU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4367.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(11063799006)(6133799003)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WURnTVFSY0xWUUVzWERxejdKL3lqUHY4SVVOYVRiQkh5TU5nQ29TMk5YQlQy?=
 =?utf-8?B?NjZtWmlhR1NxcDBJaUcrNEpLZEZhNW1tdlhUWXFnZDlySjk2am9lRUZBckh0?=
 =?utf-8?B?TGwyZkUyaTBmNGRMaDlNR2E4SmVMdGlFcTJZLzBieFREZzBmMnZMR3MzN1ha?=
 =?utf-8?B?RE1sLzMvM3hVME43WGd1bThJN0FRaGpRR3lxbUsxdGhlUEIzZ0hCaExqaUdJ?=
 =?utf-8?B?MWZoVUpHdlhyNFFsbzhEWWUwSmYrRUZXWUVNVkxCcFB0MVhqYk1GbWJkalhz?=
 =?utf-8?B?c1VGSkpUOE02R1NhYVJFUjhpa0FWOWRKbGprZnBGSmtqVTBsako3SGRWNzgx?=
 =?utf-8?B?ajVOcll2cU03T3I0Z3QzdU9hdnZ2V0kzZDcrNjlWaCtWVUJDUDFXOGFsT2ww?=
 =?utf-8?B?YVhlZGJ5L2M0RURRaC85MGxTZ0ZRWVJSbkFCRHY1VVJwdzZRUE9Bd1BTSEtz?=
 =?utf-8?B?UjhocjR2RkxGYzBPbWVTOUZNYnl5NGNIREo1bTFXM1k4SHBlZ0RvMnJ2M1ll?=
 =?utf-8?B?WWwvWDAycm9sYldvZTFZNERlcXA1VVU2VFhsY2t4dU1jamZJTXF3UUxCZU9H?=
 =?utf-8?B?M0Y5Q0VpM29FVkU1L2RjeEMvOVlCWUJIMXhxYUdYVExHb1kwUWloMFBzdUlB?=
 =?utf-8?B?bHNITGE1RjAwTzBSSmErQzQ3QWwxNWp6QzlXbVVPQnJyVk5xTXcxNCtEMWJt?=
 =?utf-8?B?YUtFTUJHZ0NEWjV0ZlNGdlVqaHN0bEMwSWd6L05LYklZKy91cUN6ZyttWjIw?=
 =?utf-8?B?SFZFbis1emp1MU40NzQ0R0ZzNGNNTVROLzV3T3hjVE94RTZQTjgzR1VsblBR?=
 =?utf-8?B?RysrWTdGblJTWml4YXl1Q2lVK0V4VmlLZWZBRjB0MzhVVFhXYTdrOXByV2tw?=
 =?utf-8?B?bGhCVjRqcWZEOEcvS0VoV1BOdjdVUnhCY1Nnb3FLdVpHZGJqUG41R0ZmWm5p?=
 =?utf-8?B?cnU4MjN0VW4wK0cyR0d0TzNCRjFMSCtjUHhFNjJpRUhoVS8zTnY1SWVwSnFQ?=
 =?utf-8?B?czlJN09ZZ3VoU1pFVjRYNzlWYVZ6ZkRNKzhmZUVhRTY5dzd0eUtwcVdzbjhk?=
 =?utf-8?B?akNteWIrbXFKKzJzL1B6RC92NXpBeVlreExEbk1TdU1vVStYYkdsd0t1ZXZX?=
 =?utf-8?B?cHM5SWIxOHdGNUFtNFNoMzBiempNWnppeEFPcVJ0bUFCZkR4Qk12YjdlM2ZB?=
 =?utf-8?B?eUltQS9xUlAxRnZHenJkTnBQZ0E1cTZ1SDUxOSsybUVweEpoN0czemY5Vkdr?=
 =?utf-8?B?aEpJdVhzTDQzbVc3VjZSaUx0MHBDWVJmNVhBWVE2R2NrbHB3aE1BRTN3MEd5?=
 =?utf-8?B?QVBGamJEa2Z5RHcyL2pBdDRYeXczM3I3dGplYnhnYUZ6NXdSeEMrSVlMQlc3?=
 =?utf-8?B?Z0YzcmMyL2E4UXNWWG5VcUR5dlpMM2RkU1Fxc0lJNzNtRmwxWk1TOFNoUDdl?=
 =?utf-8?B?ZnRTS0ZNYUc0SkVNei9aemlKUldsRTdhc3phdXBJU3lOUzhmYUh6c1RRK2tr?=
 =?utf-8?B?WldmRHpBZEdpNk9SZTd3UWZFSFdEM1hrUnBTOHpUazcrbzkwc08xOG85dWtP?=
 =?utf-8?B?NnJ3aUJIQXFTKy90cGpqYS9lZHlhV0JjUzdyR3hsczNZQUdhMlZrbVJCOVEv?=
 =?utf-8?B?T1lFRlJvSGxVV1JJenZDak1hUitBejlXZFpjbEE2ZHFqL1NrZU9VMUVjRnJU?=
 =?utf-8?B?aE5EQ2Z2MGVCa0t2KzMzSHZHUGZTUVhGN3o3UTF0QVZLM0cvZXE5NXZaMjgz?=
 =?utf-8?B?RzRpR1lpYXg4bUNEdVp4SG9QL0kxN01Sc1ZPMlNaYzNWRUJoL3RvUWIxd1RI?=
 =?utf-8?B?QjBDYmFMQjhoQlpmVHVHNUVhbVBDOXo4MS9USkhUbURSaHVRbzRpc3FoQVVp?=
 =?utf-8?B?Myt0M1VlL1BNNUtkcE5mVHJGelkzZDIxRmM4ZHpuL2pzS1F5ZC9qd0JBVW4w?=
 =?utf-8?B?SmpQL2RWSDhiOHNZZWdKalFDMFA3bTVVRlZXV2RLYVY2a1FxTDhycnJlQW0v?=
 =?utf-8?B?Z3JLeDE4NDMxZExIRXVPbUl4WVhFeVdmMGNjcGhiNEpnZWpYZ1FyMVNGTVov?=
 =?utf-8?B?NzFVa3dCa1ppY2NUS1I4dThPMTNrWjRJclpBRUlCcUx2RGV0UmJZVUREWWJB?=
 =?utf-8?B?RWM0OFl5K3YxdmZydHMrd3ZMUWlyMDhBcUtNNlRLWUtPd3pOV0ZDUmEzZWhI?=
 =?utf-8?B?R3dSTVh3ZVFFZHJET2VSc256SVlvQUFyakV3TUo4blg4WWl4THRGb2IyWXJW?=
 =?utf-8?B?Q3plaUlzVGJiZEptRm5mSW1NS2NCYStnUE8vTmJxb3UvczN0U1JVVlhMSTJM?=
 =?utf-8?B?LzYvcWdqWUtsbjV2Q0JLUHM2N0YwQXhlODgzYUFoQWhKbmxCUUFTUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 061c4d18-f47f-4324-ab66-08df18761aec
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4367.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 06:52:44.7912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VR6cxt4RvGgJQh8kQHkak2k7LVmDI4pneq5StX9Rx1InRb56DscvcGp7SAyYbyWVaCpBWNxNywRvEcfQE/u3cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9795



On 18/09/2026 12:59, Bernardo Soares wrote:
> mlx5 registers the bridge offload switchdev notifiers once per eswitch
> instance, but the notifier chains are global, so every instance sees
> every event and must filter out the ones that aren't its own. The
> existing filter, mlx5_esw_bridge_dev_same_hw(), only checks that the
> event netdevice sits on the same HCA - intentional for merged eswitch,
> where one bridge can span representors of several eswitches on one
> HCA - but same-HCA doesn't mean the instance actually has that port:
> peer ports are only created reactively from NETDEV_CHANGEUPPER, so an
> instance brought up after a sibling PF's port was already enslaved has
> none. The port object and attribute handlers claim the event anyway
> once same-HW passes, then fail the port lookup and return -EINVAL,
> which gets reported to user space even though the owning instance
> already handled it (e.g. "bridge vlan add ... RTNETLINK answers:
> Invalid argument"). Fix by filtering on the tracked port instead.
> 
> The same gap exists in the generic recursive lower-device walk used by
> attribute changes on a bridge with more than one representor enslaved
> directly: mlx5_esw_bridge_lower_rep_vport_num_vhca_id_get() is entered
> with the bridge master netdevice, falls through to its generic
> netdev_for_each_lower_dev() loop, and returns as soon as the recursion
> into any one lower device yields a non-NULL rep - the underlying base
> case, mlx5_esw_bridge_rep_vport_num_vhca_id_get(), only checks
> mlx5_esw_bridge_dev_same_hw(), not ownership by the calling instance's
> br_offloads. mlx5_esw_bridge_lag_rep_get(), used for the LAG-master
> case, already filters on mlx5_esw_bridge_dev_same_esw() per candidate
> and so cannot select a sibling's rep; it is not the source of this bug.
> On a merged-eswitch HCA with a bridge spanning representors of more
> than one eswitch instance directly, the walk can return a sibling's rep
> instead of continuing to the one the calling instance actually owns, so
> the attribute change fails the same way as above. Fix by checking
> mlx5_esw_bridge_port_exists() at the point each rep is picked, same as
> the previous fix did for the notifier filter.
> 
> Fixes: c358ea1741bc ("net/mlx5: Bridge, allow merged eswitch connectivity")
> Signed-off-by: Bernardo Soares <bsoares.it@gmail.com>
> Cc: Vlad Buslov <vladbu@nvidia.com>
> Cc: Saeed Mahameed <saeedm@nvidia.com>

Thanks,

Reviewed-by: Mark Bloch <mbloch@nvidia.com>

Mark

> ---
>  .../mellanox/mlx5/core/en/rep/bridge.c        | 45 +++++++++++++++----
>  .../ethernet/mellanox/mlx5/core/esw/bridge.c  |  6 +++
>  .../ethernet/mellanox/mlx5/core/esw/bridge.h  |  2 +
>  3 files changed, 44 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c
> index baac38bece14..4b7b0a0fc2b2 100644
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
> @@ -104,6 +111,28 @@ mlx5_esw_bridge_lower_rep_vport_num_vhca_id_get(struct net_device *dev, struct m
>  	return NULL;
>  }
>  
> +static bool mlx5_esw_bridge_rep_port_lookup(struct net_device *dev,
> +					    struct mlx5_esw_bridge_offloads *br_offloads,
> +					    u16 *vport_num, u16 *esw_owner_vhca_id)
> +{
> +	if (!mlx5_esw_bridge_rep_vport_num_vhca_id_get(dev, br_offloads->esw, vport_num,
> +						       esw_owner_vhca_id))
> +		return false;
> +
> +	return mlx5_esw_bridge_port_exists(*vport_num, *esw_owner_vhca_id, br_offloads);
> +}
> +
> +static bool mlx5_esw_bridge_lower_rep_port_lookup(struct net_device *dev,
> +						  struct mlx5_esw_bridge_offloads *br_offloads,
> +						  u16 *vport_num, u16 *esw_owner_vhca_id)
> +{
> +	if (!mlx5_esw_bridge_lower_rep_vport_num_vhca_id_get(dev, br_offloads->esw, vport_num,
> +							     esw_owner_vhca_id))
> +		return false;
> +
> +	return mlx5_esw_bridge_port_exists(*vport_num, *esw_owner_vhca_id, br_offloads);
> +}
> +
>  static bool mlx5_esw_bridge_is_local(struct net_device *dev, struct net_device *rep,
>  				     struct mlx5_eswitch *esw)
>  {
> @@ -218,8 +247,7 @@ mlx5_esw_bridge_port_obj_add(struct net_device *dev,
>  	u16 vport_num, esw_owner_vhca_id;
>  	int err;
>  
> -	if (!mlx5_esw_bridge_rep_vport_num_vhca_id_get(dev, br_offloads->esw, &vport_num,
> -						       &esw_owner_vhca_id))
> +	if (!mlx5_esw_bridge_rep_port_lookup(dev, br_offloads, &vport_num, &esw_owner_vhca_id))
>  		return 0;
>  
>  	port_obj_info->handled = true;
> @@ -251,8 +279,7 @@ mlx5_esw_bridge_port_obj_del(struct net_device *dev,
>  	const struct switchdev_obj_port_mdb *mdb;
>  	u16 vport_num, esw_owner_vhca_id;
>  
> -	if (!mlx5_esw_bridge_rep_vport_num_vhca_id_get(dev, br_offloads->esw, &vport_num,
> -						       &esw_owner_vhca_id))
> +	if (!mlx5_esw_bridge_rep_port_lookup(dev, br_offloads, &vport_num, &esw_owner_vhca_id))
>  		return 0;
>  
>  	port_obj_info->handled = true;
> @@ -283,8 +310,8 @@ mlx5_esw_bridge_port_obj_attr_set(struct net_device *dev,
>  	u16 vport_num, esw_owner_vhca_id;
>  	int err = 0;
>  
> -	if (!mlx5_esw_bridge_lower_rep_vport_num_vhca_id_get(dev, br_offloads->esw, &vport_num,
> -							     &esw_owner_vhca_id))
> +	if (!mlx5_esw_bridge_lower_rep_port_lookup(dev, br_offloads, &vport_num,
> +						   &esw_owner_vhca_id))
>  		return 0;
>  
>  	port_attr_info->handled = true;
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c
> index 87b5fd349594..ac90ccda1272 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c
> @@ -1686,6 +1686,12 @@ int mlx5_esw_bridge_vport_peer_unlink(struct net_device *br_netdev, u16 vport_nu
>  					    extack);
>  }
>  
> +bool mlx5_esw_bridge_port_exists(u16 vport_num, u16 esw_owner_vhca_id,
> +				 struct mlx5_esw_bridge_offloads *br_offloads)
> +{
> +	return mlx5_esw_bridge_port_lookup(vport_num, esw_owner_vhca_id, br_offloads);
> +}
> +
>  int mlx5_esw_bridge_port_vlan_add(u16 vport_num, u16 esw_owner_vhca_id, u16 vid, u16 flags,
>  				  struct mlx5_esw_bridge_offloads *br_offloads,
>  				  struct netlink_ext_ack *extack)
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.h b/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.h
> index d6f539161993..a4e59cc21089 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.h
> @@ -80,6 +80,8 @@ int mlx5_esw_bridge_vlan_proto_set(u16 vport_num, u16 esw_owner_vhca_id, u16 pro
>  				   struct mlx5_esw_bridge_offloads *br_offloads);
>  int mlx5_esw_bridge_mcast_set(u16 vport_num, u16 esw_owner_vhca_id, bool enable,
>  			      struct mlx5_esw_bridge_offloads *br_offloads);
> +bool mlx5_esw_bridge_port_exists(u16 vport_num, u16 esw_owner_vhca_id,
> +				 struct mlx5_esw_bridge_offloads *br_offloads);
>  int mlx5_esw_bridge_port_vlan_add(u16 vport_num, u16 esw_owner_vhca_id, u16 vid, u16 flags,
>  				  struct mlx5_esw_bridge_offloads *br_offloads,
>  				  struct netlink_ext_ack *extack);

