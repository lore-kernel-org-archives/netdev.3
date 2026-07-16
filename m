Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012012.outbound.protection.outlook.com [52.101.43.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5B63F1AB6
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 08:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784190945; cv=fail; b=COhO80IhiLkbthbuwVPGKOGiudAtB5URJnew8hWLTp7ttLykujMcIiB+Jzok4O2fuFVANj9+MrCrXJB6GpNykqWrj7DLYRwF2TlSOwI7aTwxnl5kgsaS7Dd6ARxCejHd6S29b/txGtcZ5mb30SwS/bj29neezwRJr8LJVvA6jyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784190945; c=relaxed/simple;
	bh=r+dpJoY8breFQgChY/Orwz87hA01Bm957PBTbjUHBzk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Tb8o0qeHaoAX0f5FUG13k1YnrBcmHS3Fre8+DDrUA9gnWraUD8Fe9wfg230HlqckvuRstLeIrM4AdT5SJ5lBxWWZGSA/LUOzzqRwfXKQmV3zx5/fqknwxx2YLAe6BuhT7rpjqfxdjD+B+gZxnqyPePmwHWu0sG8+c9gxz66kOOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E/vaje76; arc=fail smtp.client-ip=52.101.43.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E/vaje76"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sJOvi6K34JpkRxSn+1J9RpBwjTqh6dnBoG9JMAFyIel3ZK86P4K6knDy1qbXDWcRCKwniepchVQuWNDS7UsDmYKA+sALxD7Aee5mdPCiPpmYq5nBI+N5/uSV/8lRVZQjOUpfMk/MfTaATaurNUT/D9yI9IlmiY2ne8bXsjQtEnbhY2HIyD0jjoVkfBkhsWdVpaBhWXff1rgp+EhX7GDVzXv9lVhgsMIu8fJA7RWQwjb94CE0AXz6H4ncLga7/C2IJnDHtv+GapNa2IXlji/QGmi0ICx8ldyBRSx6pXAI+1fPTWnngtqjUwEJLZcNswiBPxB0cEIV35l05GEh0oc7bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8g85Wc3i+4+5pZeoKglwbjy2X49jNfqVA9AcCrV5ix0=;
 b=a1158M0ngn/SZoQSSuVfAiU6ENLuQFZFmfuUpqDqzn6PbvdrCgELW67rv5zFr3lJoPUPs70IRRvJ3o18m+179XLCCWNt3Yuq8vsKnAosrW6DbIwtukNm26I7hUIZTQHn6Cc3Q/xukHTD4wQvDE3P9NaN3W9v8EItr0Jo8wXYrDkYrnj42W1FxgXD6Lo7XwoOkh85X+9UelPsYdRbT9a9GHQnhOs9lJ7MHUkto5oDLMxvyGV/aBIIZIMUOjd/fnsUEH+tp5ZPZcv3tclhDMOizhA/dxJRsR5DhQOPpLfm6rR+i81Vl42i2Qs9B3WuexzGm6raq04UWPaHbHDgZ8BUGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8g85Wc3i+4+5pZeoKglwbjy2X49jNfqVA9AcCrV5ix0=;
 b=E/vaje76sxP3rSMw0nslwBdMYNV/RtmNUhrosvgLcRGFu5dS5Ojvcb2LVU5mD+ABtuseMarAZMC/x/4KE/PfRjgFVVqN/m7JBtliq+p2ecfDSiAIc6lDKP4E8OkX4Obus65XJ1Vv3nunk9r58m6YvJBlfB2DZKcPes5mA6Ran01ft7ZoU7flmStFimbJc8DWlwbIdIizcB/cmTC5hm+sIDyt/u94L2tRIH6UuOFFYULK6RHWuOoypLwlY0EgvTDSiRcGyTBatuc15iHGewzlxqxn6KzwAsVObx4TRPeC4NGg9X+cUg1mw3Y5kocxUforyeMMiL0kUVLcrhJn5JoscA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW6PR12MB7086.namprd12.prod.outlook.com (2603:10b6:303:238::20)
 by MW4PR12MB6852.namprd12.prod.outlook.com (2603:10b6:303:207::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 08:35:37 +0000
Received: from MW6PR12MB7086.namprd12.prod.outlook.com
 ([fe80::4eb8:7fcb:fe8d:e95e]) by MW6PR12MB7086.namprd12.prod.outlook.com
 ([fe80::4eb8:7fcb:fe8d:e95e%6]) with mapi id 15.21.0223.011; Thu, 16 Jul 2026
 08:35:37 +0000
Message-ID: <16711470-33b2-4aca-917f-8a5c2a83738e@nvidia.com>
Date: Thu, 16 Jul 2026 11:35:32 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] net/mlx5e: kTLS: reject stale RX queue mapping on RX
 offload setup
To: Rishikesh Jethwani <rjethwani@purestorage.com>, netdev@vger.kernel.org
Cc: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net,
 davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 leon@kernel.org, nils.juenemann@gmail.com
References: <20260714222915.2334949-1-rjethwani@purestorage.com>
 <20260714222915.2334949-2-rjethwani@purestorage.com>
Content-Language: en-US
From: Tariq Toukan <tariqt@nvidia.com>
In-Reply-To: <20260714222915.2334949-2-rjethwani@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0011.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::14) To MW6PR12MB7086.namprd12.prod.outlook.com
 (2603:10b6:303:238::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB7086:EE_|MW4PR12MB6852:EE_
X-MS-Office365-Filtering-Correlation-Id: c2934f83-ce05-425e-6eeb-08dee3153600
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|18002099003|22082099003|10067099003|6133799003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	CzDFaP8z/4GLgOeIxDLHYAB3T1o4gnfvWdbeqRJ0sOwoDk+t+UigfAwGU0mK7KVI7pzdTllROSa//8xBMkVUYKLn9oAgSrr/WNvh5YgB30v3Mqax2yQJ79LWEYdfmZb8sLbIufIFy0R2ZGVCkkOxa54aOLHGvpftQsbgvdUoSoJgX2u9lbYLoQrdJmZ/pAQSIEwu3DIFsZuXk58We0XxrJPW6iBry9SzyUxfNxxzhhdW7zERkctNqMa6lNTpILVXSiD9IsyoTfUJKi3BujdvwPQXFQsE5DYCbMRMCjylLFiG7PthVE2DHwBFRncbbYafrmmrjesEX2RcmfdaH17lIoZr9LAJSWASvP6yTzeGdJTYb1mapMwX83FHdFWcXuCO0XCbW0WQrsns2apsRClVWFMH+OIk/0VJuypQhj4mzr4HfdoHALGx6KRzaX7jZcXHkpTBUul4S9eOEZyj9yZhORRfXfC38ExgBiPQOl2u+P9CtUE0QY9jY+D4UxU6Oqm/jgkWdsJmdELIwuTFJ5+izd6eirO5yxJ1cB/UpmbFM0SaLWsgMeIYK5ejVe82remFpwfVxkxfA6OLIYYyr6j9Ti/GDCTqmoXf7Ys0aTkkpe1ff6V71+bm+iAOxPC9ryM1r99Y4f8WiBFia5jb+d5hNcOM3oe5aPzh2GnO5ZZRDHg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB7086.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(18002099003)(22082099003)(10067099003)(6133799003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0ZESURTOCtudi9mdUNsTjZVZjl2VFhlb2VodTRGc2t6U1lPWjZpajdtWCs1?=
 =?utf-8?B?cFg5VjJmQmpaY0oxM0VtMzEvSnJmeXFkK3Z4NWs2Z3lqM1JOZ0x1Y3ZDKzhN?=
 =?utf-8?B?aVRSdTd5eVBhMmdjejl2SHFkMmJMS1kwN0Fzci9PZEkxUDdma0JGM1BQU3py?=
 =?utf-8?B?K3Izczl6dUhLYkMxRW1MSm1Ldm5weUF6aUhrNzg5YmE0V2lkZ3oyT0g5Q0JL?=
 =?utf-8?B?K3p6ZVNMN0M0UUdiVndDcXRKWUdCZFFPeXBVNlBmNHNQM1hCQlR1UFBraTZS?=
 =?utf-8?B?RWJaQlJBbldBTW1nQlIyVVJhbEowNnNUVCtiQUpvZ1QzcVdaM09TQXdhVThs?=
 =?utf-8?B?TVAvaDA3bDRTdXFuWVpLVlF4a3dpdG5rZlBmMTROY1N0MVBndllYbnE5TnZk?=
 =?utf-8?B?Z0dxdE40MVVuTFFtYXRPZlBDczBGeEtqZEE0ZU1oNnNSZzNhWG1FTngydmVG?=
 =?utf-8?B?bmQrWHN3ZitheEh3dlI3bUpycWIxc3EzT0lXZXgxMlBlMk11S3FQWFNEWVV0?=
 =?utf-8?B?YVRpNlc1cGpESktHWkord0ZOUldnTU41MHZRZmhWVi9aSFlzK3B4MW14TlVT?=
 =?utf-8?B?NDd4WTJTUzVWV0JRb0huTWJpZ3FoT0VuazdFMXpSbThXWGw4Z2RzdzFVWmVY?=
 =?utf-8?B?ckJ3R1FTOTJHME0zMXExZmxmSDMxdE9CRVk3NFJWU2M2aE1ZbVZQcUhsbmVW?=
 =?utf-8?B?TGRYek1PZmd2Wnl5bnpIcUo5UldpY21pOEUra0R0M2lYc0NQV2tYVEZoZnRo?=
 =?utf-8?B?YjdVcHlOVDMyRCt6STlTZGtMSG56OUQ2UndnYm1WL2ZSUndzV0pOeDQ1TlM3?=
 =?utf-8?B?bzB1R0lEVlJTK1BYUVNpNmZhTUY5SjNmVXNaMkZRK3hMSjg3d044bUVNWTFa?=
 =?utf-8?B?bWxhYnRHZm1WV2hYaWVYNEZzMkpYckVHVllnaURiSkk5aFJTaWRpK2FYTE1n?=
 =?utf-8?B?ckhDOWtvTHRnZ2x1MjlLbTdndG5pc285a3luc0hPc2Q3SWtKNU1TTGo2UHQw?=
 =?utf-8?B?ajZ0WFJrK2NqamkwVUhIZDd4Mm1QSjVvMGxKM2hTc1o5T1B4L01ZWUxwd1JT?=
 =?utf-8?B?aU9SSWNtVTZvcmJUaExZWmgwVnpSWi9aNUdncExEbE1qL1RjWUNudlIwcHI3?=
 =?utf-8?B?ZDlvYS9aU25ac3Uxai9idlVudEpUN1pJWTU2Qk1nNElSUi9iT2dpQmlyV01i?=
 =?utf-8?B?dHZyY2xlVGdZa2xQVXRNMFZEVXJTUU56eDlyeVZHcUhkZnZHTE5WU0IySEsy?=
 =?utf-8?B?OFQvMzlLaG14eUlLVVlTTmV3OFZIMy92UGhMbnFrZHJ6THRmcXZubjZYWjFN?=
 =?utf-8?B?QmxaOEVoMlZWYXJXcGExRjlZemhQaDNMY0doTWNKY2g2d0VCdGtWejNPcURE?=
 =?utf-8?B?RG5LRWJFS1RXL1FieVJzTDh0ZzFWQlRJSyswSTJUcEhwNkZWUTl0KzF2ZVFT?=
 =?utf-8?B?MlZIOFBHaUdFLzhGQVE0OUh0NDh5QVZwVG5uUzllWGREYm16cnFGZm50a3l6?=
 =?utf-8?B?TlM1VGVnRWZpNjc2bjMzbmxiTnZERmRqcFA4VU91TmcwU21kY01hamtWVjNK?=
 =?utf-8?B?cm01TURVdFVWSFhWMXF2MDZHUVoxeFE5UkhZaCtpcnFlb2J5QkxrTWRUd3Uw?=
 =?utf-8?B?TXdkWWRUM01KZ09vYnVQdW12QnpyRmk0RDNQdGJrNjZGSmM4TjlUNVZmTUlL?=
 =?utf-8?B?bHpQVzMvMEVidlpQbkM1OFkwSStTRG1LVlI2MGx3QVRubE9XeUZZeDArYm84?=
 =?utf-8?B?cnVtQWphRDBDQ2pkU1NSZHkrZUN3bW9QZzUxV1Y4OFZUWklqVE9xUFMvVTIx?=
 =?utf-8?B?blBtVDBITUFRak8yRmtxcDVCc0dCdlJlRzY0WXpGVEJnWEdWRjAvYUJuYW4r?=
 =?utf-8?B?TDFPMS84VGRFUjI1eHYzTi9nQk84eGxzeG9VcGdwajVqOGhGKzB5T2xKMDZV?=
 =?utf-8?B?RXI0T1MwNWRYbEgyZ1RCM1kzeFFBNFNyb2lzdElhK2JJZ1ZYS0JYeUJjb09l?=
 =?utf-8?B?S2huV0tZYXVEZ002enBsOGxlRzRmV3IyZ0xDSEdYQTVGZHd6QkRad1lPR0Jx?=
 =?utf-8?B?MnJGUDVzTjhiVmJLcnZvOFVaQlFPL1NUdW5RSTRZSFVDcVpLOVg2cnZtZWor?=
 =?utf-8?B?QS82clhhZ1Uwc2o5bnpOb2d1NGZMbnJqV2IxeGxKTGMzZFFHLzFQVzl0TGxN?=
 =?utf-8?B?cTNCZFMzYjVOTWFqSWVhSWVvTFVPaXpEUGNUZVlCam1pMlhtRzhtRmJOUmZX?=
 =?utf-8?B?VjJPQkpvY3dqYW1XdHdOcWV5ZjRVdExxdjFCYW5md1d4bXBWN3JRNlNINHlB?=
 =?utf-8?B?elNEQkR5N24xZkFDRmtCdlNYSWdMVDNNaHVpVlk0V3ptemliV0Jmdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2934f83-ce05-425e-6eeb-08dee3153600
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB7086.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 08:35:37.4395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p4u9WBlJnUjsfeeMYL5ojdnjofCPdcmCw/fmUpZ56hRLFUJz39jUwi2dfiJYzmymTJ9b3LYAl4VtXte31HdeQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6852



On 15/07/2026 1:29, Rishikesh Jethwani wrote:
> mlx5e_ktls_sk_get_rxq() treats only the -1 sentinel from
> sk_rx_queue_get() as special and returns all other values unchanged.
> 
> After 'ethtool -L <dev> combined N' reduces the number of channels, a
> socket can retain an sk_rx_queue_mapping from the previous
> configuration that is no longer valid for the current
> priv->channels.num. If TLS RX offload is then enabled for that socket,
> mlx5e_ktls_add_rx() uses the stale queue index and can access a
> channel outside the current array.
> 
> Preserve the existing -1 -> 0 fallback for sockets that do not yet
> have a recorded RX queue, but reject queue indices that are outside
> the current channel range and fail setup with -EINVAL instead. Wire
> the failure through the existing err_create_tir unwind so resources
> allocated earlier in mlx5e_ktls_add_rx() are released cleanly.
> 
> This addresses stale queue mappings during RX offload setup. Existing
> offloaded sockets whose channel disappears after reconfiguration are
> handled separately in the resync path.
> 
> Fixes: 1182f3659357 ("net/mlx5e: kTLS, Add kTLS RX HW offload support")
> Link: https://lore.kernel.org/netdev/20260627210635.89769-1-nils.juenemann@gmail.com/
> Reported-by: Nils Juenemann <nils.juenemann@gmail.com>
> Tested-by: Nils Juenemann <nils.juenemann@gmail.com>
> Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
> ---

Thanks for your patch.

>   .../ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c  | 13 ++++++++++---
>   1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
> index bca45679e201..232e998a8f24 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
> @@ -620,12 +620,15 @@ void mlx5e_ktls_handle_ctx_completion(struct mlx5e_icosq_wqe_info *wi)
>   	queue_work(rule->priv->tls->rx_wq, &rule->work);
>   }
>   
> -static int mlx5e_ktls_sk_get_rxq(struct sock *sk)
> +static int mlx5e_ktls_sk_get_rxq(struct mlx5e_priv *priv, struct sock *sk)
>   {
>   	int rxq = sk_rx_queue_get(sk);
>   
>   	if (unlikely(rxq == -1))
> -		rxq = 0;
> +		return 0;
> +
> +	if (unlikely(rxq >= priv->channels.num))
> +		return -EINVAL;
>   
>   	return rxq;
>   }
> @@ -673,7 +676,11 @@ int mlx5e_ktls_add_rx(struct net_device *netdev, struct sock *sk,
>   	INIT_LIST_HEAD(&priv_rx->list);
>   	spin_lock_init(&priv_rx->lock);
>   
> -	rxq = mlx5e_ktls_sk_get_rxq(sk);
> +	rxq = mlx5e_ktls_sk_get_rxq(priv, sk);
> +	if (unlikely(rxq < 0)) {
> +		err = rxq;
> +		goto err_create_tir;
> +	}

This is not bullet proof.
Here you just shorten the interval and reduce the probability of the bug.

As this flow is not protected by the state_lock, it is still possible to 
have the num of channels changing after your read above.

IMO, this can't be resolved without holding the mutex here.
I'm doing further research to come up with the proper solution.

>   	priv_rx->rxq = rxq;
>   	priv_rx->sk = sk;
>   

