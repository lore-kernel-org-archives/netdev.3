Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011047.outbound.protection.outlook.com [52.101.62.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059EF489FA9
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 12:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789044494; cv=fail; b=Ub4BO+UJGhhoh2BtkLravlX13FK/wcW4Bukt+/F1YB/85UQTRIfX+MmEpYJz0e2ZZf1TcQbTSgX4UwMrg6TU9HfKAj4dZMJgqFKGbmhZhuOYcLUpYGfQ024WgPFaNhx6ZKh/4mE5mr7ht8fudj2mgCR3bO+7ufnj9r6sLsfSFDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789044494; c=relaxed/simple;
	bh=NweeDyZpC33D0swCN+Dkxys+nYf3zQ5IlHDouRV4qk0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tHLXNb+lqvGrriVVpExHDczX1TxkKTdOY5pEGAbAc7ErFxfI2QMsEF3rX9cUlJSMbCTozVxjRHYt8xNgpPPvJtIu2Glg8LH78rRZtYs4Ji49k3JvKCfnSUZ+awcu8O3LfMm/KQxeP5BvXkSQ5ozo2QkgbBm1vrBXB0T1trLudc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OX6FMpHI; arc=fail smtp.client-ip=52.101.62.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OX6FMpHI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AEHBlgk0BxjgLOVqeob3iqfcB/v8+kVzZEyRL6m9aKdKQZFjH+E7XahqgjEHnaF2yT0+0iVsMWbv/ZdbgAR4U5xIJSTb4Dro+PENfXCdBRVL+49HMrofujTOrPa4SP3GcZa1L0NwDhLGr3Tcis5hVyG1s7FrG4Gd8LUh0f61DcLASgsNHLS0O4d1Mb9JJEbmfcUOlDUeyhScax7G++vARDOWqYXEPqE20J3uAIJ+7WrpKDFfINSsL7aKRu7fRvMaa1P+Tx6QrxzW8SJbdHGgbme3WIf7x7bD7J39TThF4Dq5EHHeSdzfQdsfjeOL/VNK7cAGyNv4iOyyUvd+jd+jsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5/yai+SCti6eOVeI9740JtIISe0pSr+JzIyeMD5OLgE=;
 b=Ou5mXrWbZrKrkj7Af0Gz+gqPajBObz1xCbEIYZMTY0/Z58SwR22Bo6Ug/iZydTcMFbi4t8s2aGuQhl25i2Tv63hbvUbQTnmvD2Nczx7UAcYp9e1lFd8EZFD1WMER9nV3+9+ytyB+dwBmvibd7+zXGeB6FlXz1QeUuc9/F/S/VO04Djh/92f8we5KBE+8kuadwtwLwgy0gnXQMcp8Y/CaTEdHlyL/4n5Psi8Uw7t2SswZrf5ZHDGfSqrQHpT9x/i5IrmA6sJEqyxjPeB+Y/lL0Y6n+hO/zt7wqzqhdhaJIR3WxDxofH6zcFeeT5C1hpYrYw1WlqQzRsVbhhur8UxsMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/yai+SCti6eOVeI9740JtIISe0pSr+JzIyeMD5OLgE=;
 b=OX6FMpHIkvsCkJyIPGME8S+KqNV2pazXtliYzOoCMHAflXabuf68QEd8m2iTsiaKSUveJ1Ylmbmz+Lc6nc4NoE2uM1c4+xebjf+v9eh7YeWDMVWlDGUhlBubOv4nfX/5WQJp79kPAyfAm076PswHh5ywIASHCSI8zUPsuZXzniqkNOPdSVQ+OOJXfjJAHe59QxlwLR0D+RcowR1XpdhIWO+yB5+ogUjxJSgty0HZLaeNhMGGVPPv7bPTxkWYl03vEx5p47+W+d3wBtEzWijeMVArGkIJfq6R5CmskUram2xmVoFLw9cWR9HOvtRqmTSAndlvRl2IYmDldFGXVg3jqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by BL1PR12MB5972.namprd12.prod.outlook.com (2603:10b6:208:39b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 12:48:06 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 12:48:06 +0000
Message-ID: <dd3247a9-14d5-4866-a20e-b31d414ec1a1@nvidia.com>
Date: Thu, 10 Sep 2026 15:47:56 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/mlx5: Bridge, don't fail switchdev events of
 sibling eswitch ports
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: saeedm@nvidia.com, Bernardo Soares <bersoare@isovalent.com>,
 Vlad Buslov <vladbu@nvidia.com>
References: <f26aa63abf085a087f7ed1df9080f9f0982bb311.1788884253.git.daniel@iogearbox.net>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <f26aa63abf085a087f7ed1df9080f9f0982bb311.1788884253.git.daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0169.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::24) To CH3PR12MB7548.namprd12.prod.outlook.com
 (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|BL1PR12MB5972:EE_
X-MS-Office365-Filtering-Correlation-Id: 64ef85ef-f045-4c4e-be81-08df0f39c223
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|10067099003|3023799007|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	4pjQ2niZS1yd0eyfDnTrRUnVhAPHMj4cKmtogheegBpI7SMiJwLlFiMX3yADEvryaHj++xhRzaWTnTchnaxi5xd1rYO+/tv58dW5n9Jf6GVyTdoFLYa/NH20z8b3HlCzCAer778mijIkie5JDVfvYIS1SlDyKqYpA4TjfqDs9vegBdlb/vL2Kyal2ODPwxaHpBDaVT1TFTFpQeDMRthMqwFT5F+Kgvy+OfaYZSe1+8W3F+2pOyHD02eKpKQlAlfVLQkkOE3NLYG7oZQEVpTAISqpenZjOwbhV617D0Cswy/ZS3G6FIibWJ68ULSd/nkMFmP9DNvmWcQYUkshEP4ZiVxqr/kV6Oc2M9CdXFJJdN0fWOk4SVyKa8cgNlUPRbI5oUrpbcEhJMWxRzAjBAm2Za8Zz84jvUPzMgTSnGdYqRHxc20mqt6hDsWp2bo8p52/gI2E+yzDyvpE7Y/dgfa6FI7rtvlp7LPsnMfUql4eIMOePzxiRs31mlkAo8gEf8GhgM64gxgDP6uQQkJhija8xpIRESJDnO6RRnaqanHIGJflHw5+j65KbzG0zqPYlTHltqjD7xOfqC45Avhf+PH/eRrBgDFIUcmqfqPLrHdLSMglmp6UGweCjr3eni+TAZH99wcKvbJ1Fojo0v1yFMi0qTsnO/82Xag0suG89W4hipE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(10067099003)(3023799007)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d1JmMHVFQjduNmhDWEZLdHhCb1RzdjQ3Q3ZiZ1pNdTA5WkdCdGkrRE5OSmE0?=
 =?utf-8?B?d01sRzFxNnVMaHFaYk9rYVA4cmhCbEN1WWpBYWwvL2pKK3c3VmhWQVdUbnA3?=
 =?utf-8?B?VmZCL01UeXdXMHdLM0l2SlhEMW1Yb0d4MTk3NElnZE1LcTBTNDNzejF3MXNo?=
 =?utf-8?B?dFMrQmhxd2hNWHVKNTRJTTRVUkJIaUNoc3FjU0xVbFpJUm95UVdtL2ZaUzBS?=
 =?utf-8?B?ZTZZbVlOdkdhVjJmdGxZQUU4OW1qUWVxbmFNOVJsUVB3T3BjangySksrSW8z?=
 =?utf-8?B?VldVeDg0YUc5dlU5Ui9yQ0U3YkhqN3hSbG1HZHcvaDFCa0IyS2RvcXBHdzVC?=
 =?utf-8?B?b0lDMm9iTmhsRUxRV3ZmaldMd01mUUNtTkZaUjhhU3VXU2hZMjJYRmYwWW02?=
 =?utf-8?B?aGNzMzZOQkZmaTQ0ZjBqM3hUOUJEc2FUZ1BaWThWRHV2TXdoR0d3Mk9kd3Zo?=
 =?utf-8?B?aFE5ME5vL2V3UkxiTlpHcWVPRVhjQlh4ejR6Mm1BdVhyT3hmKzZER1NNTEdW?=
 =?utf-8?B?UDlyMzkvUkgxakFsSGtvUUNudlMvemV4VEFVdm0zZ09RN0YrTEN0OGhmNDRq?=
 =?utf-8?B?ZFgveXVQK1Y0TUxZNG0yUzU5RGkzbGcwalV5akpWRmErMFA2MXRMd1JRY1hr?=
 =?utf-8?B?cWwzMFhGdEVjb1FRc3QzL1Q5U0gxKzd2UnZTQ1MrRFJIZWdBZG55UW0wM3lO?=
 =?utf-8?B?Z3N6a3FYdXMzUDMrS1QvZk9XWStDb3djeHI3MitjK3hScXViU2dlRldWNkcy?=
 =?utf-8?B?MFVvS055UmJWRG5SRDdBWE9jcHdUOWRuek1KMlZGRW9vUTZtYmpHeVZld2E5?=
 =?utf-8?B?cDNFUEtEVEh4Zml0S2hvYkJrcUJVSU9aY2dxVVlGM3BuTFBCRXJhUGozVFg2?=
 =?utf-8?B?WVNZQ0w0eE52RTRsVlJwbGJEWkdMWm5wVDJYMUlPUHF4UDNQeDRBYlRVZVh6?=
 =?utf-8?B?YzQweHMwSFlnRjlCSjdPN0hUa0MrZXV0aEljQWJ4L0UreFFMQ2FwdWVtWkR0?=
 =?utf-8?B?MDhRRnJRKzVnek9WYkRhVm44NFNNYmhRQ0V3RWJhRlIxaE13MHFJSlN6TEly?=
 =?utf-8?B?ZDFQeGdpTHAyWExCRUVENWN3UEFHakh1Wk1lTmhCYU1yaVErblUyaUVBOGlj?=
 =?utf-8?B?QnR6aE1TbFVEMy9jMWgybU5JcGIwNTlwdzBneGxjUHZkb1U1K0QzTGoxbmZj?=
 =?utf-8?B?T0NKM1k3cHhlaFpxRmhuVW5NdDJvQVRRVmtmdHNEVmJGTTRQYy83MXpyQWhD?=
 =?utf-8?B?ajJuZThhY08vWFRXTGNqWXg4NlRFT0tYWjMybnU4UVhUbFlvZXR4K0ZxSmlr?=
 =?utf-8?B?bWtCWTZkYTBlTExtMTN6anFjNUpmL3UwamY2eHhXWXNIUGhiQ2J1LytITUth?=
 =?utf-8?B?TVB2WlpGUnVLUFlrMHV5ZFJodUc3dzNvYUFRQzI1MzJIc0xzN2F3eDNqYmtF?=
 =?utf-8?B?eE1IVjU2ZlNpc0RlZUtydjZEQzlHUEFwT2FXa3dNUURWOHovQWNCSFpXYmN4?=
 =?utf-8?B?L2wzZUxxZzJvaWRtNkZCNjJVY05pM1dGYXMydEwrVnhiNHdydXlxTzdKTk5o?=
 =?utf-8?B?eUNRK1F1WHIyazhYRmkwblR3R0lNWUtPRHJoakxheXlPMmhqbU9tN2dhcnlv?=
 =?utf-8?B?Rm53RWhWMUlNaHNrOFdzd3g2VzZ1N1BxNEI0bHB4OWVadkNmVWx5NGpnMWI0?=
 =?utf-8?B?Y2VKWmFNZ1FFMDd3Z3N4UEVHMVFZaWh0azJzM0N5NzY2bEduZ0M3RnY4V3kr?=
 =?utf-8?B?bksrZTRBc1lCRkROQm5TVU1Wb21XK1ZhMjlEQUh1ZSt6TzJxRExGZ216QjlN?=
 =?utf-8?B?SzlwRHlFOG1SMXc3ZldDTEpWS3NISnJ2VnpFZjczQlRPNkwvOTZiUXV5QlY5?=
 =?utf-8?B?R3dHUU54NTgyak1nNzhGKzZ1eG85VkhiVzNoT0ZkY0VJZmR2YmkrdmFvdFc2?=
 =?utf-8?B?K2VmcjNIczhVZ3lmVFBXREwwWkVxczAyNUFETEcyTzlWdURPTWt4d0Q2R2Fu?=
 =?utf-8?B?RmNhTXBVbEpJYXJjdXdzL3Q4YXcxckNBb3gyZ0lOTTAzZi82NXFlUUJzN1hm?=
 =?utf-8?B?dnZLQkh6Y0VyZEd4NlF2L2Nxcm9adHdnMXV3a2N0T0VTcHZsSSttbk9BMXFr?=
 =?utf-8?B?Y2Q3MHh6TWpuaWxKY01FT2dzWUpVWXFnc1dHMDhEdytlTzEvUmNLeWQ1alVk?=
 =?utf-8?B?cElraHptRmp1aFROb2pKRE1meENDQzh2alY3VExWNTYra2p1N1lWbnJIaHFz?=
 =?utf-8?B?QnBzUGNaVWJMbGs3blNSMXRKekhHczlHZi8zVUpyakErV0xBY2NLcnR5d25X?=
 =?utf-8?B?cHRVL3ZmUktPUjA5bTFRd1Z6eXBWQ3VTcVFISW9XNGx0K2s3WTN2Zz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64ef85ef-f045-4c4e-be81-08df0f39c223
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 12:48:05.8506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UDgFTZuO3wLjPFl1WtwuroXOMVBJ1QPNNGiEjcZmX6O8VvvEUCB9F+yPyov3x/hJLjf8Q2HCkNBFVlraCnJncQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5972



On 08/09/2026 19:19, Daniel Borkmann wrote:
> From: Bernardo Soares <bersoare@isovalent.com>
> 
> mlx5 registers the bridge offload switchdev notifiers once per eswitch
> instance, i.e. once per PF, but the switchdev notifier chains are global.
> Every registered instance is called for every switchdev event and has to
> filter out the events that are not its own.
> 
> Since commit c358ea1741bc ("net/mlx5: Bridge, allow merged eswitch
> connectivity") that filter is mlx5_esw_bridge_dev_same_hw(), which only
> tells that the event netdevice and the eswitch of the instance sit on the
> same HCA. This is intentional: with merged eswitch a bridge can span the
> representors of several eswitches of one HCA, and each instance keeps the
> ports of its sibling eswitches as peer ports in order to offload FDB
> entries pointing at them.
> 
> However, the instance may not have the port at all. Peer ports are only
> created from NETDEV_CHANGEUPPER events observed while the instance is
> already registered, and only when merged_eswitch is supported. So when
> more than one PF of the same HCA runs bridge offload and the PF that is
> put in switchdev mode last has the uplink of an earlier configured PF
> already enslaved to a bridge, that instance has no port for it.
> 
> The switchdev port object and attribute handlers do not check for this.
> They claim the event via port_obj_info->handled and pass the
> vport_num/esw_owner_vhca_id pair down, where the port lookup fails and
> -EINVAL is returned. call_switchdev_blocking_notifiers() stops the chain
> on the error and it is reported to user space, even though the instance
> owning the port has already offloaded the request:
> 
>   # bridge vlan add dev ens1f2np2 vid 999 master
>   RTNETLINK answers: Invalid argument
> 
> The same applies to bridge vlan del, mdb add/del and to the bridge
> attributes (ageing time, vlan filtering, vlan protocol, mcast). Thus
> fix by filter on the port instead. We tested that this fixes the issue
> on ConnectX-7.
> 
> Fixes: c358ea1741bc ("net/mlx5: Bridge, allow merged eswitch connectivity")
> Signed-off-by: Bernardo Soares <bersoare@isovalent.com>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Vlad Buslov <vladbu@nvidia.com>
> Cc: Saeed Mahameed <saeedm@nvidia.com>
> ---
>  .../mellanox/mlx5/core/en/rep/bridge.c        | 32 +++++++++++++++----
>  .../ethernet/mellanox/mlx5/core/esw/bridge.c  |  6 ++++
>  .../ethernet/mellanox/mlx5/core/esw/bridge.h  |  2 ++
>  3 files changed, 34 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c
> index baac38bece14..56592e2e6b9b 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c
> @@ -104,6 +104,28 @@ mlx5_esw_bridge_lower_rep_vport_num_vhca_id_get(struct net_device *dev, struct m
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

mlx5_esw_bridge_lower_rep_vport_num_vhca_id_get() returns on the first rep it finds, shouldn't
you verify it's tracked by br_offloads?


> +
> +	return mlx5_esw_bridge_port_exists(*vport_num, *esw_owner_vhca_id, br_offloads);
> +}
> +
>  static bool mlx5_esw_bridge_is_local(struct net_device *dev, struct net_device *rep,
>  				     struct mlx5_eswitch *esw)
>  {
> @@ -218,8 +240,7 @@ mlx5_esw_bridge_port_obj_add(struct net_device *dev,
>  	u16 vport_num, esw_owner_vhca_id;
>  	int err;
>  
> -	if (!mlx5_esw_bridge_rep_vport_num_vhca_id_get(dev, br_offloads->esw, &vport_num,
> -						       &esw_owner_vhca_id))
> +	if (!mlx5_esw_bridge_rep_port_lookup(dev, br_offloads, &vport_num, &esw_owner_vhca_id))
>  		return 0;
>  
>  	port_obj_info->handled = true;
> @@ -251,8 +272,7 @@ mlx5_esw_bridge_port_obj_del(struct net_device *dev,
>  	const struct switchdev_obj_port_mdb *mdb;
>  	u16 vport_num, esw_owner_vhca_id;
>  
> -	if (!mlx5_esw_bridge_rep_vport_num_vhca_id_get(dev, br_offloads->esw, &vport_num,
> -						       &esw_owner_vhca_id))
> +	if (!mlx5_esw_bridge_rep_port_lookup(dev, br_offloads, &vport_num, &esw_owner_vhca_id))
>  		return 0;
>  
>  	port_obj_info->handled = true;
> @@ -283,8 +303,8 @@ mlx5_esw_bridge_port_obj_attr_set(struct net_device *dev,
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

I wonder if changes are required to the peer unlink function as well.

Mark

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

