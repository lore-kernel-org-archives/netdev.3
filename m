Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011012.outbound.protection.outlook.com [40.107.208.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34490443A9E
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 19:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789501901; cv=fail; b=rR/JtsoucsJAxLraFEgR4Emx6kUaeZV7NslPSXee3NreXP+IcP/k42X/5YN+kVNC5pIel/19OMoag1t7Atb+w86M3Bg6Pj7f4FlLb1GJpn7+Qy9CMDStnJickPzACPvtq8kHX0w0GtesA0eS8bmnBA2p7zssyIHYreawRlNCQQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789501901; c=relaxed/simple;
	bh=ltIlW+NqEvj2X6KUl8sjbC4PkVVzQ70ll9yySnpsE5U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ohkH0vUmTWu1S0y3/d4bTEq4S8OUgdqAKxIsxGG5umsZgwFT+K7zjpWtH9xQn9S8NLXCxU6+0ADz5D/7Kf70Nj30F7DCEODuUBRX0ZrdISU9dZ7/cnyo+AslV86atMw0sqmoEHzA30K30q9vA7lAXf4nnzOTphSSXeZt+ovYKnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WjRHDSCe; arc=fail smtp.client-ip=40.107.208.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WjRHDSCe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NNzFqYhVjoi9WZv2v/MvkMRcYP+vqwUkdehU3nqZ7YcN0DjW9DRUevRkoTfIUR3evSjjUXnBYoa8PL32nSU5kW/j0/HCrxCF215hh6nHCo+tniHszG1N//9PGDyfKSKrZ/KKc/MT9+lFxWJdfUqoRXXGvq+v9zgPnXtMI/VgsBoOlmEPpn08hQG1nM4oYf5tE6JlMGEookw7aK/lxxsbZ1w0nMijqcrhVJhksjNn3OfjSRK3JnjCi2P0ddfOhnIpQJVGRC1VCJ74YxbrVrtDBlpJVzOhs171+53/F1liv/RUO30+W4AVYsC/PHo4ZB6FA8iVN5yEZSsAlLPePghPPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ksU309fspWZ/iBu94ILaOva8pb7VaQ2ygUFxzBBEo4Y=;
 b=R11rzEhrmq0QK42ZE2IuTSYVe26UTQJSOcmGRfYu/c+RrPeYjka5JDXzsBIRdMlh/SMEDVyhkESlpHinZyJy+6JX9u3tisAuEM2Z4l3jn8i9F/ani9JmG4mp8gLy+BOOpilh2c+T22bBjaHeVe9B5pE9V+n9/6d5gDwzYEnhq8o1oQM+XDsUCyX1f3n1X/Cue3EO63KnJ26wltzl80Qquvq8mMLuJWaTkD6hzMwUh6EaV5m6VMKwfgmD+UPia7dPg6drQah/9+WPpqpuFW1BHAEsuLGW5SUTkxdG88AgsTZXmj6HH+EyxDFuSiqIoNMm2BZ9ZoRSQh94XEZIYJDSwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ksU309fspWZ/iBu94ILaOva8pb7VaQ2ygUFxzBBEo4Y=;
 b=WjRHDSCedS/Kq/+f545kCLHHoqvZFE+RmmKdSEGRgpQlAP2ZK1llhkgaRT8MVVVgu+vrD9pJ6aBMJIAxgQYadg+g9HG17rFxTzm/3N2MnjMt/PLXJC9HBxKNPO01o/mInLA+vqbImbD50a13j3jpcVm6tSi4XuGfZ0ccKM2U4APZoz9Nh51xhSAQ8d50fi+ffTHhEthWJPABtidYUNuZ6rYyFu/S13WGO7TtbBucpOoE2YQO6e87U2J3WEGbgGwoD5UVSX1azneGEeAgXFpvJKQ/jIrmDhREu2xFuEJQatfxCAPm8wGJT11WkkU27Xnny8VjkoSOe0B8oENYp5/9JA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB3313.namprd12.prod.outlook.com (2603:10b6:408:65::18)
 by SA0PR12MB4382.namprd12.prod.outlook.com (2603:10b6:806:9a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 19:51:37 +0000
Received: from BN8PR12MB3313.namprd12.prod.outlook.com
 ([fe80::310a:77d0:b591:54a1]) by BN8PR12MB3313.namprd12.prod.outlook.com
 ([fe80::310a:77d0:b591:54a1%7]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 19:51:37 +0000
Message-ID: <d611e425-70c7-4006-a72e-101834b955cc@nvidia.com>
Date: Tue, 15 Sep 2026 22:51:34 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 3/3] net/mlx5: Bridge, don't fail unlink of
 untracked/unsupported peer ports
To: Bernardo Soares <bsoares.it@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 saeedm@nvidia.com, Vlad Buslov <vladbu@nvidia.com>,
 Bernardo Soares <bersoare@isovalent.com>
References: <dd3247a9-14d5-4866-a20e-b31d414ec1a1@nvidia.com>
 <20260914085430.18694-1-bersoare@isovalent.com>
 <20260914085430.18694-4-bersoare@isovalent.com>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <20260914085430.18694-4-bersoare@isovalent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0054.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::17) To BN8PR12MB3313.namprd12.prod.outlook.com
 (2603:10b6:408:65::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3313:EE_|SA0PR12MB4382:EE_
X-MS-Office365-Filtering-Correlation-Id: 1874287e-0ae6-4068-f879-08df1362c0b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|10067099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	xpKlVoLPAuBY/mAn7suoCSQIb42zWVAiJLkWirw0m2lnleIrHsjSkwYVEIwbV8phv+JQNDYKv07MNhKSJGtdWKSZMAmt6Rq6c3s7ea/StXGf/ZUqKKDMk5UcOR2n1i7AH+jmpDRKt/xiH3hSC0kDmon68LZKLNGx9EoijeeUINp7HvzaS/uEhpkn8Yul50x2f5LPtPNySHUPANAyO28jrwsJvZ09nYHfT367BzEo53P+dno3bCZ5IzO2I4Gd3SPQ0/nhRMdrwrzk+YqU1FYbujDQfStfudBFRiyWEaWucAx4qKDXuZ9C8n+F8YLd/UAxD2xDA1Bat7A9e0+P77UO+jgj8UwDRw/Z3eBqss6WnccjLcQkted4eERZH1Cuo7LJ5GzXrt55sGV9ttxt2nM50+Luz3dzetieJhiS+o8ZuV3RwBiGq4ldU3v2m1ivtrkeVixGKlWOX+T6j+IrWyWK7Nc54Vl+sZ0T3TJup0SkviVI02qom9PuIUdsuKy70iOROEGmWNq6CvsiaiFKSlwIHsGjv3mFaT7+03hLvdwR9RtH0LF4B8mTtTbpbJvg1L0PuRvDcI3EOUsNz3WsN1in7iMSL8ItRCSjfT0HVFv8cy2UqDOEDohX49Yh4IKXgZmaBmTRkyKPsexs+w0/GRDZ5fwey8jcg0K4f4SId7sHRjI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3313.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(10067099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TTNpeG1UVktXWUxpQnY4ei8zTkxqZGo1T3FsUDJUdUxvTEUzWk5hd2h1TW14?=
 =?utf-8?B?WGt4UGliRnpuRVdOQlAzYU9oQk1SY09JTlVTZ3VGZjJiaXhMZTJ6TjZYU0Vi?=
 =?utf-8?B?cll6d2tKK2VISTBqSk9aT2FaYzlTK2Y2ZU5KTmdZQTF2Mk1DUDNENUptTVph?=
 =?utf-8?B?ak85bzNpM01uNjlNR0FjSDJqdHB5VHJPbG96RmVYQkxEMWRkek9YQ0UzQ2dT?=
 =?utf-8?B?RERuNDBMT29sVzdLQU1WSlN1Q3dJYWloODBRYnAvbHdDQVgyZG9sZi9lV1Q3?=
 =?utf-8?B?QVdteUhSYkI2OTZ4RldiU1cydHFLY1cvVXc0cUUzZlRVbzRZZ1gwMnp6blFy?=
 =?utf-8?B?WmhRRU4zQ010MFVCZFQ2aFpBL2tJSjNuNUpnVW5uSGxnUmhBU283Rko2VHU5?=
 =?utf-8?B?V3J3MlNMTlhSdzBhNmVZT2R3R1E2SkFqcnNSdFZBNTBNRWJUaG9mWEZUMDBO?=
 =?utf-8?B?cmU4VG94QlBpUzBPd09OM1dVanR2K2FkczRxUHpCMWVQV05HMXppakFzd2F2?=
 =?utf-8?B?cWxDUUpxa21ETVNYclFyS0FQYmlRS2JRRDhoR0dEei9DRi9KcERqY0picDV1?=
 =?utf-8?B?dU5hUGVhOThIbHBaemEyWnZLYVBrbUJRMVZqSDZCSzRmenBKQWNzeStBRWlz?=
 =?utf-8?B?NVpLbjkzb3BpSldMRzFPdHN0UlowaUhVSWtvR05ydkhOTCtOK3Myd29MbjhI?=
 =?utf-8?B?c3YremFyc0FPK3phZWdNK3lWZnZ2eUNSTUZzeGtXSE0vWlpQSnU4Unl0NmZj?=
 =?utf-8?B?RW5OQ3lRWHYwMTJvYTVZbXZwdlVoYmVSczU4ZzV4YnFuNFlQSmFGVEN2anU5?=
 =?utf-8?B?Z3dCZ3YzYUVhaSt0eGVhbERIeDRrVE5TbEU2ZXlqYzAzWUU1Wm8vYkptTjMy?=
 =?utf-8?B?WFFPQkhqeXo2dTkzbFdXYkxTeFpGRG5hRHZwaVRZSUNuMDhvdm9zM3VleGhN?=
 =?utf-8?B?SWRsQmNtMjNtcExOMUx1YnYzeEdlbWt1V3prMnhVdDFaS3ZoSFAwRGRhdVFu?=
 =?utf-8?B?bU5jSTJkSy9nTWdTeHVndENoQjNZOE4zSExGZlBWdTNPY0pJVSt5RXdodEFI?=
 =?utf-8?B?RlRLSzMrYndQUWt1ckJvWkhoOHZEN0E3clMwY2U4RnYyd1NEK0V0UkZ4R2tN?=
 =?utf-8?B?WUlzc2wvWWJUMG96YVp0YkFObEJ4M2NEb2VxT3JUeW1DL1pQWnlDbVV0RzJk?=
 =?utf-8?B?WWw2Z1RTNUFGaE9UV08zVmMrVVhCMnBWMERsaEEvbTRPdWZseCtqQm5Ib2I0?=
 =?utf-8?B?dDRhdUJESFlkdFB2Y0JJaE4xdlY2QkZEbXROQ0RoVTNydkNaMnpPYUowVGF2?=
 =?utf-8?B?MkI2WXlwNlJ0bG5kWW90OTZmbkxSQlBBQ2tIcjJvNHlHWGxXeThNZTd5bXln?=
 =?utf-8?B?MTNFRjZRQkt6R2lXTDdoUkdCVUhmaHVGYVVzRWxvMDE3d3hBa2NHbi96bHBP?=
 =?utf-8?B?ZlBUdWtaSCtlTy9JbmUrZ2owMzFrNWJoUlU4RWxCNWlrbWdCaGdVZlk1OWxy?=
 =?utf-8?B?L0tuc0JZbmljaFlxcFczRDNyd2lBSFQ1a2s2N3A1aWwwTmFhNHN1a1lwUTlr?=
 =?utf-8?B?b2gzM21IeFJkc3RPWE83aTRIcHUyMFpraHQ1V0E1eVVUK2RTeEZERndvbkFh?=
 =?utf-8?B?NSthWWJJNWpNQk9DYzMvYWxOTExMZWt6R0lCZ2d5S3pka2MxUVg1SmhuWGs3?=
 =?utf-8?B?QzYrb25oU3c2anVCbWZhNWY0Q3lCWmdqMjhiSWZtbHAwY0JDTC9yekx5N01J?=
 =?utf-8?B?NnZ6UjBtaDBIL0MvRHN6cUROeFBYLzZwUkx2NTdFZlp1UU45b2FpWUx5WGRD?=
 =?utf-8?B?YWxYMkloRVVya0pHeHJVSldmNkNiR2tvdFY2Zlg4cm4xNFg1cnVzUWJjVkNM?=
 =?utf-8?B?UGkxZ01tdU85YXdKK1dKL1Q4TG5JSFErRTdhR014Rzh3dFZkdW91MWl3YUQv?=
 =?utf-8?B?WU1EQmRVdi9NUkIrTXh6NW5zN3RMQ1NscGdPK3ZJVy8zTWl1cFkydUQxeUJx?=
 =?utf-8?B?cEJBd2lRZk1NcTdqUGNsREdSYzA1bkpId2E2eUNnSEZSZzFRN1hoRXNjQURI?=
 =?utf-8?B?Q084ZytIUXRhQ1c2K2tZSDljcm9jT3BiVTJHMzVwdmNiK1BVaDBvL0V1Rm53?=
 =?utf-8?B?N1JTTlQ2dW9FUHpLOCszMVloU2ZFaWl5U2ltbDg0RkFEdmJpVU5MMDRCSm5S?=
 =?utf-8?B?bGt4QjlBMzYyUHp4UkxIY243VENGT3d2RExpUDIycHdsRHdrNWlHRkFpTWN2?=
 =?utf-8?B?UFFweEJ6cHNHMWJZOHdoQ1pTTytmVzV0QWhIYnJpSUo5OE5YU0NnNWdPUzNr?=
 =?utf-8?B?eDRsUnhUYnB2bUJwVk9pMm4zZTVaMGFYTDZjb3lHajVPYXhiUk1YQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1874287e-0ae6-4068-f879-08df1362c0b0
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3313.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 19:51:37.4234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iCYRELbM0RtLGpseELZa9162sfJNNJVju39Q9BYGnK4kDePRs3ROYYEvVWp72mR+2uMJnTdyLTrocVhC5B3ZZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4382



On 14/09/2026 11:54, Bernardo Soares wrote:
> mlx5_esw_bridge_vport_unlink() returns -EINVAL when the port isn't
> tracked by this instance's br_offloads, which is reachable in two
> legitimate cases: a replayed/duplicate NETDEV_CHANGEUPPER unlink for a
> port already cleaned up, or a peer-port unlink for a vport whose link
> was never created because peer_link() skipped it. Return 0 instead in
> both cases, and give mlx5_esw_bridge_vport_peer_unlink() the same
> merged_eswitch capability guard peer_link() already has.
> 
> This also matters beyond the -EINVAL itself:
> mlx5_esw_bridge_switchdev_port_event() runs on the per-netns
> netdev_chain, and notifier_from_errno(-EINVAL) sets NOTIFY_STOP_MASK,
> which call_netdevice_notifiers_info() checks to skip the global chain
> entirely - so the old -EINVAL silently dropped the event for every
> other listener on the system, including a sibling PF's own
> bridge-offload instance, even though none of it was visible to user
> space since __netdev_upper_dev_unlink() discards the return value.
> 
> Fixes: c358ea1741bc ("net/mlx5: Bridge, allow merged eswitch connectivity")
> Signed-off-by: Bernardo Soares <bersoare@isovalent.com>

Commit message nit: NETDEV_CHANGEUPPER is not replayed, and
only listeners later in the chain are skipped. The code looks
good.

checkpatch warns the From address is gmail while the signed-off-by
uses the Isovalent address. Please make them match.
v2 was sent as a reply to v1. Please send v3 as a new thread.


Mark

> ---
> v2: new patch, addresses review comment on v1 asking whether the peer
>     unlink path also needed changes. mlx5_esw_bridge_vport_peer_unlink()
>     now mirrors mlx5_esw_bridge_vport_peer_link()'s merged_eswitch
>     capability guard, and mlx5_esw_bridge_vport_unlink() treats an
>     already-absent/untracked port as a no-op (return 0) instead of
>     -EINVAL, which is reachable on a replayed or duplicate
>     NETDEV_CHANGEUPPER unlink and was found while auditing the same
>     code for the ownership-check gap raised on v1.
> ---
> 
>  drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c
> index ac90ccda1272..b4cf3c5ac0dd 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c
> @@ -1649,10 +1649,8 @@ int mlx5_esw_bridge_vport_unlink(struct net_device *br_netdev, u16 vport_num,
>  	int err;
>  
>  	port = mlx5_esw_bridge_port_lookup(vport_num, esw_owner_vhca_id, br_offloads);
> -	if (!port) {
> -		NL_SET_ERR_MSG_MOD(extack, "Port is not attached to any bridge");
> -		return -EINVAL;
> -	}
> +	if (!port)
> +		return 0;
>  	if (port->bridge->ifindex != br_netdev->ifindex) {
>  		NL_SET_ERR_MSG_MOD(extack, "Port is attached to another bridge");
>  		return -EINVAL;
> @@ -1682,6 +1680,9 @@ int mlx5_esw_bridge_vport_peer_unlink(struct net_device *br_netdev, u16 vport_nu
>  				      struct mlx5_esw_bridge_offloads *br_offloads,
>  				      struct netlink_ext_ack *extack)
>  {
> +	if (!MLX5_CAP_ESW(br_offloads->esw->dev, merged_eswitch))
> +		return 0;
> +
>  	return mlx5_esw_bridge_vport_unlink(br_netdev, vport_num, esw_owner_vhca_id, br_offloads,
>  					    extack);
>  }

