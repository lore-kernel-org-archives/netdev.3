Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011056.outbound.protection.outlook.com [52.101.57.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE654F85D2
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 06:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790059984; cv=fail; b=dmfNI0dSrR/1UaEMsslOV9ZXo2tLnw02QeH5CFC52GSdnPi4Rs6P+xFhQIgE3koGfaa3qASN3KUSgpVkZ9SnB9La2Ypkl3udaCxXoFd1xwpyDcGqZO8UD1f9d1ZYb70obWhHpPodLIkzIGJrwPkFcELTrbZ1Ju5Z1fgHewNDwyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790059984; c=relaxed/simple;
	bh=HV/XmrL2ZeulQGqGMcISzHKTHduvzA4usS5f5Y+H6LQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FReDXPYb3t6xxZDFY3BePh83bOcAuY6Va5oyYPGL7yXLh7UaUsCPhOgi+N+exkTLg/EHGuiLhfp3J9wdpnWMc/jJ2t+Fx/4YMlIm+0AjtTydXDgTWlhZ45cwdZIhwC+VRL73II5dlmOx4fou7BgKUlOWeZfOXGN6pKkN+8eHaCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t/8AHS+M; arc=fail smtp.client-ip=52.101.57.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t/8AHS+M"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DAjKQs/SgIiAsgcPCkNtkDjhQOnvP7hSAJ7HHhvZavIdhwuH79HiFuTfcPzz7qaCqGnh+EdGFoMojeF5WFqUj4SDN5OsT+8vElLm1ux2/IllDJ7SsIz/xNykcLtadc+d6jtAoOlDym3B6yGlEauhUqr3afx54n72bxoFe+DEqvGRCHoXkJbquG35GWvZKwEGyEznP65gzBz0AXHn+l5cc4hV0paHXj3mRF9Ml8HOIweGu7/Fk7qoc2dlXDEWX5jF+GTsFWFtiPDHDqkqXRYUlGlktaW2q7/QxIkR52lZMpBiFsBPpmxDrPblfi7FDjthsz9MRm+XiyKuVjoNxDiF1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/3C+7dWXZuudrB/AsfcDucnbeNGTIpCgINy89fS4hk=;
 b=k1ZamJpjBi+/z4mn8Cywr/l4b66973eIcIHBmh6ZaLfnfhwNJEqDq6QOac/D+k3i9qO6r3eDrID++DF19yAUeLuJK0NQ5fL5kSsBvG7DJEqekwDZRCuhre4JczSem7DakUBkB433Y0x32tQU+RJS1oKb+EIemRapWBE1MGOszljpmH4rtHrKXTp7iHuE/ItvRxhwWTxKbZWIC03wSIg+jgxKzRXP1pHIakayh8dH9R0kNeCaL014PSt7Gy1HFghjE7x+Zy7/BMi0047MVDoUxMRjUu9au/99p8IUf30OOgWH3c9/xFVQaCwDGtXNZ+O55wGCh+6Aacoh+X6JGxToDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/3C+7dWXZuudrB/AsfcDucnbeNGTIpCgINy89fS4hk=;
 b=t/8AHS+MnoEivHpFFunXLuI24FRtb9ECpCNtrveYeTU4Bi02itT9i/H8kP+9BZKsHC4G05phvQKf1ISIo8o6JIHpO8MKgt+9o1Ud838K0vo5DhN826maW6bWSzXF4DLVzsq3AOPEjJLWi9Jyxvsm6dAb0AtN5amIXfMw7qxBLy5OOFh5X7VF4/UPL72fRcCTok9EaA3Q2aCC3h/y6ZbxAzt0iVx5byir203i9TyPZv9RRnqKD0Jp/Qa1XLJmqysJ9t+uOBihcdtU/M4k8ej3ziXZ+ptaadfR0qggzgcdnAc+4rAz/TjLbSHqm0Y48hNtpCKkJiRXbDnNkR7yXcq0cA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA0PR12MB4367.namprd12.prod.outlook.com (2603:10b6:806:94::13)
 by DS4PR12MB9795.namprd12.prod.outlook.com (2603:10b6:8:29e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 06:52:59 +0000
Received: from SA0PR12MB4367.namprd12.prod.outlook.com
 ([fe80::2815:8a95:1a44:be1c]) by SA0PR12MB4367.namprd12.prod.outlook.com
 ([fe80::2815:8a95:1a44:be1c%6]) with mapi id 15.21.0428.011; Tue, 22 Sep 2026
 06:52:59 +0000
Message-ID: <b9038692-e31b-4daf-8775-0bac3e99ceac@nvidia.com>
Date: Tue, 22 Sep 2026 09:52:55 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 2/2] net/mlx5: Bridge, don't fail unlink of
 untracked/unsupported peer ports
To: Bernardo Soares <bsoares.it@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 saeedm@nvidia.com, Vlad Buslov <vladbu@nvidia.com>
References: <20260918095931.29792-1-bsoares.it@gmail.com>
 <20260918095931.29792-3-bsoares.it@gmail.com>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <20260918095931.29792-3-bsoares.it@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::12) To SA0PR12MB4367.namprd12.prod.outlook.com
 (2603:10b6:806:94::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4367:EE_|DS4PR12MB9795:EE_
X-MS-Office365-Filtering-Correlation-Id: 095e34ff-c03b-4747-f62b-08df187623ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|11063799006|10067099003|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	qLBnI5w+8egK3wqEN7bTwyM3kfV3BQOyynL4I8kl209ZFPeu42l1lXO1R18YeZIwFi253FnfXItmuw/vqtf4Ddr8JfHii5qDh3OUQ+TkgG7k9OH8Y4eaaVvphAkANlbQvMo3A3G7XLmmM7gZsKmrWVoqBDE6EUKQnSU0X3BkXE5fvZJw+39fh3onrL8XjAVCsLtB6TK2a5arLgyI5fQLwPfUuWwDZcNeibtgD7eucYjW3hkb4zc0MxmAUvClLocGTzjI2+wu0v1u+47iQIGypj3/VxvuMHQqV3kAUSlaaJxmUio5/mXeU/XVmlP6BT+tUf1wC12anW0V9lsG5Ev8qz4YBFcxHBdX1oBjj4OsIesUqP53xKaTlFN9mnhqqbwNVQAd5VC3eI8wUoqxApY1SUdrNMfWkQmwG9HlfeTcTk/LFkATBdB8korZba8EVwrk4oCBZpkqVGsnzW3je0zAytP8RrIUKNRmDVSg8zpnWEM8MHqZvwuqyTKtn31enLltW8rpQaBZzDLYZInWhyMOB3+KxhMiBprCowKy2llP/d1S0bQrrla6CEU0o3ecm9UE5TgcG8qpPoWcBM0mussARLIIfMppFQUzm/7/Tw23SL3HN2e7CVyyp6YJjtpWLAn9dJjgUUvtfF5hQmXOFYClCrcXwsQ4jpXyHsPhiNbpcdQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4367.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(11063799006)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ODdOR3U2cXRPenFPc1MxZDFLaFFYSWpkMXhIZXNsNkdTWmMrdy96UlZidTZx?=
 =?utf-8?B?K1EwQTZMZkNBbjZFajM3SXBQdmorUWpDdG55THRPREhwUWd0MHdLZmp6Tjl5?=
 =?utf-8?B?allGVXB0c2FUS1p4MStiKzNnTG5zVHI0a2wrcjBYb0cxeDYvM0NydkJtNTlZ?=
 =?utf-8?B?bFR2SjhiNHI3YzR5WlE2VThNYVM5U24zVFlaUGVMZW9jaGNuRjNnRFZyOHhl?=
 =?utf-8?B?dFluS0RRMTNNcUNCSkNjUmp6aU1rNFN2Z3V0ZmNLd1BWN0pJSDkvTThjcldx?=
 =?utf-8?B?Mld2T1BNQW9QTHNUUTFLWTNWUFVpMVQzbkl5R0hJeTk0d0dVdllLS2VadEZt?=
 =?utf-8?B?OUlFQ05nd3I1dTVzSWFRMnFzSjd3Z1laaHRxQzN4ZHpDbUliQ1BHZU9GbzQ3?=
 =?utf-8?B?cC80QkVRTTMyZkNjUWdQVk5tckFlT2pmTDdCTG5yWHR1WmpSMWpESDVacVpw?=
 =?utf-8?B?T29GZy83UDlFVnh6VG1TcWhkV1VVdFlHTExsa3MydE9QSk15Y1YwWnJPOThK?=
 =?utf-8?B?dHlNY1l6cC9MSVFiTHJnWTZRU250UTZKU29jc09iWGJrSUlxWThhM1hiNi8r?=
 =?utf-8?B?R0swaHdMMnh1dENJdmpQYnNSczZCejR3TG1CTnFkNit0VGZZRnlJZGFKb3c1?=
 =?utf-8?B?TSsyNHozaU1NaHNJMWhBVmlDdElaU003SlU1THZpMzFkYnBkbmZScVUyZkxs?=
 =?utf-8?B?Vko1Q0hFZm0xUlArVks0a2x2dmdLYnBVbjZ1YVpBVGFoR1crMysrTkNWcU5E?=
 =?utf-8?B?TCtaUmdCWW4xbEpvZVV2Vi9xVlI5K0VIUnVad01mTExNSVhOZCtvaTdyUkNw?=
 =?utf-8?B?ckg5QzliNU1yWVNoSW41eVZUM3lpeFZJZ2lFNDhrUDVUTHBib1Z5WjhyTDM0?=
 =?utf-8?B?TmtXTTZENmR3d0RXUmtaVHdLNTZ2M0l2cEloQ0JZMk5qQk94SEJpNWlCTXlj?=
 =?utf-8?B?a3RHaXpaNGZ5QnBXYzhXRnF0MXhMSit2L3ZhbmVYRlV5UWlobHE0bzJDVWVt?=
 =?utf-8?B?VjYzN1F5YjJwNE81cTNFcXZDSTFwVXg2M3hDZVpCZXNvblhjckhPaWlaMFBo?=
 =?utf-8?B?aENOOHRhOU5KTDd6WUV5M3RFZEpSVWpNMUl1dDF5OTUyVFBlZS93MUc4SXNi?=
 =?utf-8?B?MHN2eHpHRldaWGR1Z2NUN3IxbDZVcjl4S1gwSW9TMnBMNFNCSFN1NnRCdk9F?=
 =?utf-8?B?a0x1VjBXdU5vMDFTcmFqMHVRWWlPTFlvYjNETThRVmp3cVRIK1hRa0xXUzdC?=
 =?utf-8?B?d2dvVGZvRVlMaEJyYVRGR1ZVL2FWbzNvNm1LMnBwaks3L29vNzl5T1pkeTR1?=
 =?utf-8?B?MUJFVE0rcFM0dkd2b1VVYXNiWlFhdVBlcnlnRzArZWdNdHVINCtoU2pNWS9O?=
 =?utf-8?B?RGlhSWUrYjBkUzBKS0M3THd2REkxbXk0RkN5ek1ja0QwUFFWdHlFV2hRR0Fk?=
 =?utf-8?B?ek5jQWpGQXEySElZUk0xc3pxcTZrYTAreVF0QkIvUkhUWlJwblY5Z2NzajQ3?=
 =?utf-8?B?VGhmL0dYN29DaitqTzVqdWl0ZnVqS3UwYWw5UFlJYzZzcFJ4VGY3NWRNck5j?=
 =?utf-8?B?OWZiYnl6U2FkS3o1UjJEcEhHeFhST2JLaUJyZUlNSWc5Z2QzVHpOWkhjWjRo?=
 =?utf-8?B?UUpza2M0RTlzTytOSGphSExGWUc1dDIzS1dQNVk1SGJWTDhSV1NTUmVTb1pU?=
 =?utf-8?B?VlZhd0VuanROWmtYTnBFcFBURW04K0Q5WFpHOFI3VldkZmVWdFRKcHdDOUFZ?=
 =?utf-8?B?ODRxS2h1cW0xUnVzdCtuMzBTdmZsREVIaTlzVGhPRE1MZ203Y011TkwzRk0v?=
 =?utf-8?B?L0ZiY3ZpM3M4cDd6MWt2ZzNNeDZodlIyaGloeHR1cWcvTTBCbUxqb0M5UGE2?=
 =?utf-8?B?NVFmaHAxbjkwbUZneG1ReUs2d1AzU2FFOHFhK2xQQ3pFVkZibGt2Wi9aUHdN?=
 =?utf-8?B?amVrRGZMbTdyWXlmTFFqMm4vVE9WN0hyNEtTeUhyRU9TUWxiNFJyeUtkVTZX?=
 =?utf-8?B?YU9RcXZqM0dDcitkMW45cVdkQmoySFRYbjBhOUJKWHZvRGQwQ0Rhb1dMOGs2?=
 =?utf-8?B?cVNLdThULzYzeVI5ZGpkNUd0WXNuUFJmNlNlVWYzOUp6VFI3elNKdUk0bDFn?=
 =?utf-8?B?dktFenFpcWtpaVRIQmRiaFdyYnBRSnhmWHhzNUZMQ2llOXEwTEMzdmhnWVpV?=
 =?utf-8?B?UVY2Ung4KzQ1cU1Hai9DK1ZjeUhlc2kwb2xLa3NkM3lmUFYwOGRPa3NmY0VW?=
 =?utf-8?B?SHBOcUFCMEwrNU04dUR1ZWptbzcxbUtZVTlSODdpUmVlZ3M4Uzh1WU9YdUEv?=
 =?utf-8?B?eFk4OEFVTmUrU1dsUWdyaUFZakY3ai83QWdwczZpVnRtdVJmWTdPdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 095e34ff-c03b-4747-f62b-08df187623ad
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4367.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 06:52:59.6118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q6YXG1oa24GHHgtFfTkEY2Zfh1GUbzABnEKh8D2yq/mjAJ//w1gxu+pQt/IsewJ54eRwBpiClwP+TS6FtxbD0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9795



On 18/09/2026 12:59, Bernardo Soares wrote:
> mlx5_esw_bridge_vport_unlink() returns -EINVAL when the port isn't
> tracked by this instance's br_offloads. This is reachable on a sibling
> instance that registered its notifier after the port was already
> enslaved: it never saw the NETDEV_CHANGEUPPER link event, so
> peer_link() never created a peer port for it, but it does see the
> later unlink event and fails. Return 0 instead, and give
> mlx5_esw_bridge_vport_peer_unlink() the same merged_eswitch capability
> guard peer_link() already has, since without it peer_link() likewise
> never creates a port to unlink.
> 
> This also matters beyond the -EINVAL itself:
> mlx5_esw_bridge_switchdev_port_event() runs on the per-netns
> netdev_chain, and notifier_from_errno(-EINVAL) sets NOTIFY_STOP_MASK,
> which call_netdevice_notifiers_info() checks to stop calling further
> listeners on that chain - so the old -EINVAL silently dropped the
> event for any listener registered later on the same chain, even
> though none of it was visible to user space since
> __netdev_upper_dev_unlink() discards the return value.
> 
> Fixes: c358ea1741bc ("net/mlx5: Bridge, allow merged eswitch connectivity")
> Signed-off-by: Bernardo Soares <bsoares.it@gmail.com>

Thanks,

Reviewed-by: Mark Bloch <mbloch@nvidia.com>

Mark

> ---
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

