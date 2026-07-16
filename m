Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012031.outbound.protection.outlook.com [52.101.48.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043D327466A
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 09:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784192549; cv=fail; b=pHyYjzZJa6ug12D3oHF2PeCgWZdB+dNdWRqmO9+HiWEQp2o6Rgdx5NNpRuzmV4AjYHp+nR/xb36gKBK/iVhS7FGUlE8WGS4nQhaKfvTUti6KClmuV5uismKgDBT//dcxKh+5Agl5uQpyU9ejvyYgeC+SpzrzraUjsk0Xu6+TJ5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784192549; c=relaxed/simple;
	bh=qbbiCnwgchdxZEAEHqq7c9VBewbIn22WLTmjHHGNdfE=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ptcTwkk12bB+/S3UWxneXpsigaqk6edOlIdHfLY6BBml3j2smW+sLXuypmCyj//aZ3kUW9uSnCTLcuCkMuSs8WG0S8/33XnEBjN05R0sqqMZGVl/xehatmiVVLzye7wrLRi0gGz+2rsF1fkPjCeslKRiusaDF9CVg1OVASDCOYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WYXiqsxX; arc=fail smtp.client-ip=52.101.48.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WYXiqsxX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vqWUD7E02dqmUQx/8TJC2ryc2Un1zoFkNqxZVgGYFSMTHR8bz3hqfI3drtW8Zgb8PZAlPQLIM7RbLMgZLlb6oWtyIY6h0L+f/4ABTzWivheiokRDGXNQh/MBEs87YFan3vdxo3n8lA2Ly7LD8V0KpjyFQISvAKwUU7bE2NGkgKJklPLrAvejC8xqZJ7mSqXMjZjjKpAJY9qHfUBIxLO6TutvoS3YDo+RGzO0e54iY3fzlbi5v0+mytmsSMbEZHtr7pmXAHrPIoAmXSumjiZYPV6zlwlssz9+e0kIdPg81JwEIpB7tSWFdbubA0xg/CNNGErTjfRkf7un/hmUAm8uvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lOleMKB89Y1rO56QMyqtbqW9w6vTQW9DrhPmWYgI6B0=;
 b=WHg0R3tH+3Spaxi17bXAg4gp4sBesQ0THGZaSo2qk6k+5nkmiYXBH2FQdwWNsXzCnpaP6ncHx2q8MBUmQzIBVELFnMNs9IGMP6xBPACyotAFJeQrtbpmffU76rMIfRBxg/ASPoSunhQA2QirBkpWEK0IBRXrz5JV3a+4wfQJG04LoMHdYZQ2+V/fr0UONJGF+UvnHHB1EaTANL3wh/fF+1r9H2nPrcIgycEW/RRhPSHA+6R/iKtHU4FZuRtk/WdR4CgUQJBRObFQIAaus0lAXtZMRHtfEks/cTXP/IzhGGhmWccvfnVv/zlk7nHcul5crLJgSKfsYSaTkM2Q89XOkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lOleMKB89Y1rO56QMyqtbqW9w6vTQW9DrhPmWYgI6B0=;
 b=WYXiqsxXA7ISaEBPC8u3qPD4r9EjLH5eszKOIOXyzyHN+tWjQULlkFMig2oaZ7lmdYY/qaWTfPXYaUKaLiUgvBEsN9GBwVT+cbGUg1aoHVqfby1whe329ms4tjOrDE26toRf4ou/jjhUP7k9kyKqr9nwntIBu2M1smTDYi5kdidcBOYJuDkOVlpzjaPwDNY8lDWqCmrm7xfo8+TJKZYfFbN49Ssc21+5qHKBcEojk/JIW/6JWl6uCP5jf9P7fQdl07wXKUtzNeKz4QX6lbzns4iYwTHjUkU+58ic+jBqQcqu/Jz5PDQdQ1ingp8UsVlD3ko8lcPChKuvsBp6yfcHSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW6PR12MB7086.namprd12.prod.outlook.com (2603:10b6:303:238::20)
 by DS5PPF5E0E7945E.namprd12.prod.outlook.com (2603:10b6:f:fc00::650) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Thu, 16 Jul
 2026 09:02:19 +0000
Received: from MW6PR12MB7086.namprd12.prod.outlook.com
 ([fe80::4eb8:7fcb:fe8d:e95e]) by MW6PR12MB7086.namprd12.prod.outlook.com
 ([fe80::4eb8:7fcb:fe8d:e95e%6]) with mapi id 15.21.0223.011; Thu, 16 Jul 2026
 09:02:19 +0000
Message-ID: <aca7f2fe-26ed-4ace-a8df-0364cc774ed0@nvidia.com>
Date: Thu, 16 Jul 2026 12:02:13 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] net/mlx5e: kTLS: reject stale RX queue mapping on RX
 offload setup
From: Tariq Toukan <tariqt@nvidia.com>
To: Rishikesh Jethwani <rjethwani@purestorage.com>, netdev@vger.kernel.org
Cc: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net,
 davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 leon@kernel.org, nils.juenemann@gmail.com
References: <20260714222915.2334949-1-rjethwani@purestorage.com>
 <20260714222915.2334949-2-rjethwani@purestorage.com>
 <16711470-33b2-4aca-917f-8a5c2a83738e@nvidia.com>
Content-Language: en-US
In-Reply-To: <16711470-33b2-4aca-917f-8a5c2a83738e@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0093.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::12) To MW6PR12MB7086.namprd12.prod.outlook.com
 (2603:10b6:303:238::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB7086:EE_|DS5PPF5E0E7945E:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e523a96-18b9-4640-93e9-08dee318f0aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|22082099003|18002099003|4143699003|10067099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	yHAqq1zl9yK1KOsQnDmctKO4tvM+uYuTvE9uDSS5VZ6ppUC8TS7Xgs7bAu/eArPiczmtsbPRZA3kPu1LXJ3CfbY80Z5I6LKhIzQ6XiyZgPjURoDwJCy1/GIcpK9aLaKb9yjSpH0FSD7L8jI+Gu8n/Zk5GsFUcpC1rO757VF86HVNfW1Uktk4y9c28qidBr4jOlYynP9nHbLOokKUalnZs9AzNGXTr078TOtZCXSTqmiUfeWH3I3LVUv3nj4Q5ObHf+qUO8PxUjUnROKy2FBGFseiSwAP+esm2BPZeShihkbde31WZt7sP2Y5J4ex/OGld1V/+fDvzppbEZ4g6KfjCenw2W8rxTl35XLVDPaU/LBS0mCqAqLHwRXFdt4TcbgDr8vs4V9G8bYdgk95n11/HL7ufTZIBOIeB63k99Iymt5zptZKd/zkC/SvflEYKAWXQmSHlewzmzRYEWd+lb0mbwxyYdsKjsh/rSEzH6N/uGAGxQ9K3NgT6QzxyIq6phcNkcN5boVhxh/J/DQ94XtFA1ATjp6MgcNGcIEwNuAHQQqTXtA+T3xPKiypUUpd0KVpmRg4nu3aKa8cuXVvMxBogj7pUZkJGmqLmDGTDlpcIB4+8KD8Dn8ZhfjYA0h82za3OC7e0yHH0r2SdeKwV/0pf3Dm++I/Z08EKRLXSJalfDk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB7086.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(22082099003)(18002099003)(4143699003)(10067099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VnZlTmZ6d0dPSUIxV25xdTNXMVBPcUFyRWMyUTh2TkMrVUY3TG9IU0syWUZT?=
 =?utf-8?B?ek5paUVISUpHUkg5L09PbXhYNTdLbENoeXAzRGVPQzFKVkE2SWtZTmh2OHRH?=
 =?utf-8?B?OEZEWk5YYmZZSDNPQzdFTmdCM3ZqUExwNTJvQXppOG9nQ25qbWpRNFhXR2ty?=
 =?utf-8?B?STQvV3JzUXBOK0pMc2VGSEl6Z1d1OG05TVMyRVJuZGEvNmdzblNiS0VSWUFy?=
 =?utf-8?B?QzgrTDJ1MXYrc2R1T3h0Y25ybGkxSlZQTkhva3J4U0ZzNnlOU3NIQmN1Vmxz?=
 =?utf-8?B?RUxrN01RdnAya1dmN2ZvQWUvVXYvUEYyQmZKdWZscU9ORjI5VDV0MnpxMEdN?=
 =?utf-8?B?V2t0MUZPbUhrTzlBMFVWVmVjcUlheDlCeWxhM1JEM0gwOVpDY2N0NUtWQkdo?=
 =?utf-8?B?UVhicTc0WDgrMWMzTE9raEtrTjE2ME1mRWlrbWV5cXdhekt4L0dhS2t6cW5y?=
 =?utf-8?B?WE5WMGcvRU5KY0ZEWFUraUZwYUs2RjBZNHZ0dHhmM1JPTTJrSDYyNllxd2pC?=
 =?utf-8?B?TXBYRnNpRlFvRXBpN3hYRmJsOTB0OUNDUjBvMmFTdGFOVlNNK3FMaDNuSEla?=
 =?utf-8?B?YkxOTEhUaXNQa1pYZW5Da0lMWFpsL1U3VnpPWGI5V2IxcGpZd1grOGVCYVpw?=
 =?utf-8?B?c2MyRzNTYStnYTBNVGY5SUhDMWlBZWtSTGRtdkdyTVJpNkJuRk5QN2pMNnk5?=
 =?utf-8?B?YnRGNVROT0hOVjhRSENtOEdMaWE1UDhVMnNoVVUzUWQ5Vng1M2crYW9nWXVk?=
 =?utf-8?B?UE9DeUI4MzlQektXNjJKeXlMdVpaVFZXRjZSL0VhSkwzQm5QRnBZaGV5dWxJ?=
 =?utf-8?B?MHR3aG5GUFhKKzIrcXJ0OTJUdWFodlFMeEo1TWMzTE5oVVlNdHhaS0kvZFE0?=
 =?utf-8?B?NW1Cc0pqOVQzeWR1OWVINnlBb3N4SExwS0c3ZjZXNE9YRHJzSkZhWjB3YTZs?=
 =?utf-8?B?djk0ckhseE1LZ3Ftano2OWtDalNNSWFhM2VqZ0Mra1ZUOWt6USs2eDhBNFFo?=
 =?utf-8?B?bW8yVkZ0alYxKzB6bmIwSUZUSUxxRVh4cEVKQzlVTzNNZHFKKzVDUms0V2Fu?=
 =?utf-8?B?MHhJcXd5YkdBVW1QQ3lOdnA0Kzd3T2M2NkVaeE84TjYyOEZCelpMYWRqSDIx?=
 =?utf-8?B?VE94WTlWb2FXc3RUZGRYSUhZWWRHQzZYSW9uaHBZSTFzVWp6K2hTelVLcGpE?=
 =?utf-8?B?R291MHhyUnNkN3cwYjhvb1RsRzhUTGtHclhiNVFlYVVMVmlBZjU0R2M4bzA2?=
 =?utf-8?B?ejdWeHpaMkxoZmtwVGlMelFuZ0ZjNElBbG5RbjlNYnN3elpDL1d4MlFMUUtH?=
 =?utf-8?B?b2JDbk9McDcySUpRRmF0V3pMOXZVc2g3OUZBNWRwVjliUzh5dlJBZ1Z4OG9u?=
 =?utf-8?B?TkxYZmdVRC9HVTR0NWhJa3BFZFNGZHlibnF4TXM5OGI2U2JqS1RHZ2tnWDBk?=
 =?utf-8?B?aWFuMkxFaVE1RklLQlpIbmZhMS9GcUdSelBZRHowcHpPQWtCUzhDTzduM0g3?=
 =?utf-8?B?b1c5aWQ2c3pOMlJvUGc2cFBIcVAreDBzVDZtTG0zZkFJWDg4emp6dzNDeVEw?=
 =?utf-8?B?NGR0SGd1VVI3RGVEbC9qcjBDNHU2YzBsU2xXN0tGY0t5YStiQWpYSXd2c1Uy?=
 =?utf-8?B?dyszV1BiQzk0YzJMKzFuZFUySHhJSzdrUGVjUnZqYWQ3K2JKVy9IZE1zQm1V?=
 =?utf-8?B?aXJQWmZnbENhYUJJd1pCcHFYRmRwanZvb1FVYitvUitNL3BjdDZheEJXa1d5?=
 =?utf-8?B?eHNwcUoyOWZTeFh5aUtrcFgyNkhZOU9MQ2ZNVnZPWGp1QXM1YndjTHF4UDdW?=
 =?utf-8?B?K2E2QUFJUUc1dnBubjJ6THdGelJvZU5PUFJIbVMwdXJoOFNPaHhtbVVyMzFn?=
 =?utf-8?B?VU9CcUY0K0VqRFhwbkxoMUZTWlN1a2lYd0V6dnRrYkU0V0RRSzM2ckpQSlZP?=
 =?utf-8?B?SDZqSXZNSkdJTVoxZUF6MUpuTVhxdXc2cTVXdGo3dWZOaE9KT1dYaVNydXo4?=
 =?utf-8?B?Q0h2YUVZVXJqYUkvK0VJQ25FM0ZXR0V4MmdrUW9YcGVCSUF5djFnem1mYWZS?=
 =?utf-8?B?MG5ncWE1MDVFL0lUZWNFeG1VZ0tGYitqSWRmaDhCVDNPeDNwVlJKSjdXUWNP?=
 =?utf-8?B?b3lpSjU0djljdC94d2ZiUHgwbE9jN0Z5cVRCV3dKRkRhVzJXZHdUZTVkQ2N0?=
 =?utf-8?B?eHo1akVtOHRqVngzR2RVVjUzNUdOeHU2Ui9HZTVIUEdNNkUvVUF1TWpiZmQ0?=
 =?utf-8?B?dXFGQ1JyN0dKRjhrb2p0RGZsZDlsam1oa0gxMk9vd3lQZjl1MHhvVmE1eWh4?=
 =?utf-8?B?dUtDcjNzTkdyYlFjSUpiQjRNZnprOUVEQXhjUVNYTTEwRTFoalBTUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e523a96-18b9-4640-93e9-08dee318f0aa
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB7086.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 09:02:19.1085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fQx00lF6ZF+nWe9TJK9n6nvnA/nodFmpzmyiyWt5QXmIMw472dZvSMV4NNnLBGosTkkKBbIpDAKMCvIzCBcWog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF5E0E7945E



On 16/07/2026 11:35, Tariq Toukan wrote:
> 
> 
> On 15/07/2026 1:29, Rishikesh Jethwani wrote:
>> mlx5e_ktls_sk_get_rxq() treats only the -1 sentinel from
>> sk_rx_queue_get() as special and returns all other values unchanged.
>>
>> After 'ethtool -L <dev> combined N' reduces the number of channels, a
>> socket can retain an sk_rx_queue_mapping from the previous
>> configuration that is no longer valid for the current
>> priv->channels.num. If TLS RX offload is then enabled for that socket,
>> mlx5e_ktls_add_rx() uses the stale queue index and can access a
>> channel outside the current array.
>>
>> Preserve the existing -1 -> 0 fallback for sockets that do not yet
>> have a recorded RX queue, but reject queue indices that are outside
>> the current channel range and fail setup with -EINVAL instead. Wire
>> the failure through the existing err_create_tir unwind so resources
>> allocated earlier in mlx5e_ktls_add_rx() are released cleanly.
>>
>> This addresses stale queue mappings during RX offload setup. Existing
>> offloaded sockets whose channel disappears after reconfiguration are
>> handled separately in the resync path.
>>
>> Fixes: 1182f3659357 ("net/mlx5e: kTLS, Add kTLS RX HW offload support")
>> Link: https://lore.kernel.org/netdev/20260627210635.89769-1- 
>> nils.juenemann@gmail.com/
>> Reported-by: Nils Juenemann <nils.juenemann@gmail.com>
>> Tested-by: Nils Juenemann <nils.juenemann@gmail.com>
>> Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
>> ---
> 
> Thanks for your patch.
> 
>>   .../ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c  | 13 ++++++++++---
>>   1 file changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ 
>> ktls_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
>> index bca45679e201..232e998a8f24 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
>> @@ -620,12 +620,15 @@ void mlx5e_ktls_handle_ctx_completion(struct 
>> mlx5e_icosq_wqe_info *wi)
>>       queue_work(rule->priv->tls->rx_wq, &rule->work);
>>   }
>> -static int mlx5e_ktls_sk_get_rxq(struct sock *sk)
>> +static int mlx5e_ktls_sk_get_rxq(struct mlx5e_priv *priv, struct sock 
>> *sk)
>>   {
>>       int rxq = sk_rx_queue_get(sk);
>>       if (unlikely(rxq == -1))
>> -        rxq = 0;
>> +        return 0;
>> +
>> +    if (unlikely(rxq >= priv->channels.num))
>> +        return -EINVAL;
>>       return rxq;
>>   }
>> @@ -673,7 +676,11 @@ int mlx5e_ktls_add_rx(struct net_device *netdev, 
>> struct sock *sk,
>>       INIT_LIST_HEAD(&priv_rx->list);
>>       spin_lock_init(&priv_rx->lock);
>> -    rxq = mlx5e_ktls_sk_get_rxq(sk);
>> +    rxq = mlx5e_ktls_sk_get_rxq(priv, sk);
>> +    if (unlikely(rxq < 0)) {
>> +        err = rxq;
>> +        goto err_create_tir;
>> +    }
> 
> This is not bullet proof.
> Here you just shorten the interval and reduce the probability of the bug.
> 
> As this flow is not protected by the state_lock, it is still possible to 
> have the num of channels changing after your read above.
> 
> IMO, this can't be resolved without holding the mutex here.
> I'm doing further research to come up with the proper solution.
> 
Please note we were not CCed on this email.
Let's make sure we're not missed on future ones.
