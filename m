Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010051.outbound.protection.outlook.com [52.101.61.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEF336E48C;
	Tue, 11 Aug 2026 18:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786472032; cv=fail; b=az9Akg2RXjs9ix2J0ghPE/HmX27Rzdqv5Y6/tu01239sAskGYyYbQSLlzeV4E0AHIF+zpn9nW4f/UsTe0U43wjkfXU5o6zpNVSyZ6vGV6CEpUCLAfecwCuPzlBogqlspP9B3kGP90gwk7Wu1G11AKXj/NXTfxlGcqo7YB2jLVxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786472032; c=relaxed/simple;
	bh=PkeLr9xa0YkFWt1HwHpDdn9B2FJQw19fTLuXke57YS8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FgHNSACxT4EyMCzWbcQhMkeEsf5gp28sxGT6/XrqqJw3GovKmz+Ig0JvLhWyBvcRmmPqrdgHziQUxov71fQGfkx40dwkJ0t6+AkkBMwsT9CjywN9khDhYyJErkbHVMTbaxpFH4O0ue7Ye2EdN54UW+P8Gs3rVkEY78ex6otmL2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tcInX+9M; arc=fail smtp.client-ip=52.101.61.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tcInX+9M"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v/6qk3qQv8IIO32NKNWEka2PGRcy7T2Tq7aabnQhhqeJGbDtZFRNprlWXXcu+65ynttHw9zlMD4HfO8bp8AWUI2f1C29CEXutMu9ELF6uWcS7X0JnilYJs9FdUPAJePWGH/YpyCl3ZT6GaFXNRj9rsSexw7Y57HaqWjGSbxYd4Ks6g/u5u3kNJaQlHJVZuqNB7J7k0yKnfm6yEl0u9wYT+DFQkQsK43hXjsk+Ah8gIaftGh3ZGNPeq0EKuflxJkL3eFe6nkLNwjCcaH7bOgpRSFywjgE+cQLua9UjokQXezFxB/iGPf30eoPMKTnEf87PNNoNEdUtWT/O8HWHkliYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zGbaUSyF8Lg7r7J6w1Y+zABFIv8bNuvSgXbK0+U382c=;
 b=twZuOgRQtvFZ4jd9PmzUs00Di/9HkDeSSacF5zmt5lrNJAzUHqx0vkh/K8DHuNn3vzOOBT2BAgIDHAKkLjK7o5ytpsE//rAcQWacz8XAu2Y2U8D9ovGgfV8ERFsCK6W4D0ocUgzOvOsb1zToRELrMNyGivdw8MZ42asMzoCObMu6nhVFFtaYqrY+BDigQOKjX/iBoXWurPdfZFQO7rXqeoJ2GlXX9ayeKjwv0x+IMzbg/lmr1jjusqN367KMqLLExRp49LB60IX4q4GiOiAj9Ji3QzxCYMvOYmICd2Q99qGtAhQIi+0Q0hjDGadoSrtt5xWypNR9Ymdng7q/Z8ypsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zGbaUSyF8Lg7r7J6w1Y+zABFIv8bNuvSgXbK0+U382c=;
 b=tcInX+9MS7v3Jr1v7uR7nmv4InDtomWp8ctQoM2UBKTU/YAuu9ZwCCHHzF4JPVkJ5kAlIoCfSH+9HrmOHpYS7X/5vIsIx3LDzn4bK5uhjqTOE34e1yIFpzHGJUS+WMQ2StLHkayRCkTwGje3IwqtBETCOhG7vXWDD9tmqXNoguaKpPBaFUz3ZqAghdK3E+7JpO+vHik6smrM3opfFyQSDYRXfftXPwO0vBLJdrjtqdjl+/DGCIuOT2iQ5g1R0Z2VwIvoRHWr8mgDNQUPhqd+Ws3/kVHCUVThN3etGQaNQ2oGYXlyjfeFpupdTf5sXWHRePgeQImwBJfn5FiCJRBnSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 by CH3PR12MB7715.namprd12.prod.outlook.com (2603:10b6:610:151::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Tue, 11 Aug
 2026 18:13:45 +0000
Received: from CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7]) by CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7%6]) with mapi id 15.21.0315.008; Tue, 11 Aug 2026
 18:13:45 +0000
Message-ID: <c832127a-8a80-402d-8f0f-10960f10fc32@nvidia.com>
Date: Tue, 11 Aug 2026 20:13:41 +0200
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next] net: devmem: add netdev_has_dmabuf_binding()
 helper
To: Mina Almasry <almasrymina@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 tariqt@nvidia.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260810175446.3945358-2-dtatulea@nvidia.com>
 <CAHS8izNLCCcxQwH3oYL1ch+UDf0Ok_LF0KuyJtA_S+daFye1mQ@mail.gmail.com>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <CAHS8izNLCCcxQwH3oYL1ch+UDf0Ok_LF0KuyJtA_S+daFye1mQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0249.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::19) To CH3PR12MB8728.namprd12.prod.outlook.com
 (2603:10b6:610:171::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8728:EE_|CH3PR12MB7715:EE_
X-MS-Office365-Filtering-Correlation-Id: d9a59056-7ed9-4310-4d7e-08def7d44858
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|4143699003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Ky0VthwTrom7QrSN+JoZpUIOxJXd/RjRJ4TaNsN1h4VjHnFFqMBxxIYpHnZYI+++t2PhSejPcMgTzcN0DEdkGfDEY69VuAYxvlX8tKSdfUs6pUIfzlXBH/WFRV4jtZi9QXFqZLlUPJr/xWw3lGms5dgaJlMaQhkanNUT3qRL38xErCq/t6+WBL9lljSUk/oCaiVnKZkes0QmNUkv8IO4+l+uYTFVsN/yKOcRHlknrb+WHWr2ysIHiQvKTPRUPAmz4YrSU9t4nukwlnBfPvk9UHMCS9yCCN4ng14XZehPlCRtNpnS8ZEoEtOUfCFCBX1ycXrGSmz1gxWHL1EpURshn76cBJgPeFCrCbnoe5731043k135irWeQIO95qNSomBL+IMcg94qssJneaHjrhnQgpbn9i6delKAWRWyVpv0EN4ZlIfwnVcfw2iPGqUH8N+oZfkD/N8Fvr013wmFpk+NEUMyt4fNcj7buNxqiComAbMzz5U7mWMoDlTifdlGZuchjq6CGSyWYZXRVcbKlLcw58v3xE/mkUy6m6ILJykf43/dqHKoaSyvF8wezPyfj1BrPFRWXUsLvzKe4VTwnEYhJt9TfqdYi+atpepVrR//O6EWc0hWTvHOho3EpLbx45t2IdDpGzVG6CuYvVYCcjWh0ispj5zK4of9/m2Mn1E4ric=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8728.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(4143699003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VEJvSmhheVpFYS8vQXFieFhaL0tqWFA5UDEzdVNrUFZMMDZIazZpOUlZbHRk?=
 =?utf-8?B?MEFtZjRpVXNYVnFsc2NhM2FScndBSStzd0tzOERnYUJyRXFnT0o0NjlMN0lX?=
 =?utf-8?B?dktjdFgxaEpRN3ZZZk1vWlgzaUhKVk5FT0ZSOGdOM2ZJMFpaMHluckpxaUto?=
 =?utf-8?B?K3NtbTQzNEtPVUlCYkx0c3NQVzhTZ0p5SnVldy9yMWR6WXprRHYrY2xUWXdy?=
 =?utf-8?B?empHVk5Pa0dwVGtjZEt4MUR3OWVKSWhTb1F4Wk9meDY0bVBPb1JvUmtSQnNT?=
 =?utf-8?B?TVZ4QnFUbGUvUGh0RUpxaU5jYU03NzYzSlA1eWo4KzFzdnMyYnVwSEhyVWFG?=
 =?utf-8?B?MXp6UHlNRklxRFB5bEpScm83aHVQbnJhcFZRMVl5bVd3WktpWUYzRDRJa3By?=
 =?utf-8?B?ZzVTTDJyMnloOHhjSy9pTzJwWGttWEFneGF2T0pKVlZBU3VkK0VXUHpmUTdz?=
 =?utf-8?B?SmNxbnpsNFQ3OVBtNDhkQjBnSytSdmx4T3BlT2xmUHZEcWNVY0ZmdTk0Wkcw?=
 =?utf-8?B?RGNGdFNEQTdTZHVlZHd0U2pPV2ZINnpZTXYzdHZ2MWVFdjlqdXovbmRIcjFD?=
 =?utf-8?B?ZWtETHRUWW9wQ3BFcTB2cWlVT3hNa0JIaC9FOFd0RFRjRHNwTUdsbnJWd2Rv?=
 =?utf-8?B?VVlYYlFVVTNYeWRWYlIwbHFRS2JDR3gvVjhwU2JaUHFna0xuTEJUemFJczRm?=
 =?utf-8?B?bVV1aVNONUN0dXJqRVZzY3RxMElDeGdFamljZjg2N2FYL0ZxVzBTeEZuWUpl?=
 =?utf-8?B?bENNNWFkUTI1YzgvNEtLU3RzSjloNWVXUGM5dGVOeGxsZkVSV2ZVQ2VEUEs4?=
 =?utf-8?B?RlpseWd1MUljNXpNZUZab2lDdjdmc0ZKNDhHdThWSHJOVUlCeER1anRacE9w?=
 =?utf-8?B?SjJpTWNUbWNJTUFIL1R3Q1lOUTVIS1pOVSsvamVmUVJadzVsRmlBT0JPcWtk?=
 =?utf-8?B?by9KaEVYRkxlQ0JnMnNLeDhTSHkzM0FhME5zVEg2QUs5WHRDVEN1Q0dNblNw?=
 =?utf-8?B?ZitKNU1majNhTWRXZ0l1VWdaaHFzaEFVdWdibWJtRm9aU2t4UVZlbUJWVFc0?=
 =?utf-8?B?VVZNMmxZTkFkS284QkdOT2NTbG5BanRuL2hlczNpQ0Y0akMwcWJuSjFFZ0Q2?=
 =?utf-8?B?eGZiSXBkbGQ0U2U1K0MyWVZvU1ZHY2NsbFdVT1N4UWxtNDE1Q0dHL0dVUzBO?=
 =?utf-8?B?aTA0bkZGK3NJMkgyb01oZjFnM0dpTkVlNzRqbDhTNXZXRG8vMTJhVU5WcVZz?=
 =?utf-8?B?aTJHMUZpeEZIdmFwZ0pZMUg5c0QrYWJYWnJVQlhSMlRWN1JGalU1NHYwMkl1?=
 =?utf-8?B?M2JxQnVrak1ML21uSm4xWUFrZ1R2VzMzaWd3TkdONnM2S2ZkSUdJODBxdXdZ?=
 =?utf-8?B?Z09KTkI4VG00RUFlMTRQTVgzSlFhLzVDRlltdC9xc3dUSk1BaXlQRCtQckt4?=
 =?utf-8?B?TUFCdjN2MHBkdHp1V0FBRkJlUHd0NEN4NU1CejBQUXo0bnRTbmZPbmg1a2Z6?=
 =?utf-8?B?UlhQdS9SWUZ1R2R1VEhlMGV4NU1qUmZWK1poYmpZQ1h6b0RFSWZoUEh1ZzdI?=
 =?utf-8?B?WjBvekhDYlNNUVVmVkYyQ1BNSzl3Q1U4ZnRVT3R3QW9iajgvZG5jTDdwM0J0?=
 =?utf-8?B?STBSY3hlZEZFbnhLbFpGaWlsc05QYzl4Y1puYnRhakJScGRJd3VqbEJ5OTdV?=
 =?utf-8?B?K3psd3V6VThrelRMNGowWFlMYVpBWHhVYWdqYjZPSzFQUW9wQWxUbi9lbmtR?=
 =?utf-8?B?R0pRTmxXUHdCNWlpUXRjZ09NOU1jQ2g1QVMrVkNtRTgzNjhvclV0aU1DSDNO?=
 =?utf-8?B?WXRTblkzUEI0eXVlN2oxcWdkcW44THFSOUdwWTRwSTNKV1luekM2U0lDRnc3?=
 =?utf-8?B?dXdqSlV5M2JUaEJYdGFyVi96YzhxUzYrSUZ3K1ZjdWFIM2pHVTdKWW1NNEhV?=
 =?utf-8?B?ZWhFSHA2d0UwQm1zQlgvSGNvOXFmUXA2NXlMZVlkSFRGRnM4MVRnbFR3Yllm?=
 =?utf-8?B?amN5ak4vMldnUFFqTWVJSjhvV2JYQkMzcWxZSW1mSVQ3d1FEWDhtQTBPRVdG?=
 =?utf-8?B?dmhnSHRQbkU5NDhjU2hBcXJNUTMwYzJuNjE1ZmMzRFE5eUZiZGx1Z2FDN3BJ?=
 =?utf-8?B?b1FNY0dTaW9sbktFb1RsN2hhWDluTjhqWTAxWk80aHp4eW1lVVZQQ0UrWEc3?=
 =?utf-8?B?VXd1RXpYRXlLa1dZemNTS3NrRjFkbkFOdFZFeDQzSnp0bGUxc0k1Z1BKd0Fo?=
 =?utf-8?B?SnVhWHhqb2lzRnJUcE5iU3dkWjFZV3YzcC8vc0FWWWdobzNrQnA1dThkRWxu?=
 =?utf-8?B?SmZUekRoZFQyOUdOOTUvNDFvVDdXSlZXMXJpSi9oN2cyTFliSk8xdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9a59056-7ed9-4310-4d7e-08def7d44858
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8728.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 18:13:45.4510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0dQ5eOW4EZ+U9jVR9nyfUwbNJcQxTn0cUF9WEiZnmDDmqv7pvii19FIjBk+WIgOoYeZAbldNlLO7chTOYXBH0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7715



On 11.08.26 19:25, Mina Almasry wrote:
> On Mon, Aug 10, 2026 at 1:59 PM Dragos Tatulea <dtatulea@nvidia.com> wrote:
>>
>> Currently there is no way to check if there is a dmabuf bound on a TX
>> queue. RX side has netif_rxq_has_unreadable_mp() which gives a hint of
>> it.
>>
>> To help with that, this patch add a helper to check whether a devmem
>> dmabuf binding is active on a given netdev, optionally filtered by the
>> DMA device the dmabuf was mapped against.
>>
>> This API is necessary for the upcoming support of data direct in mlx5e
>> to allow blocking accidental swapping of DMA devices while devmem is active.
>>
>> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
>> ---
>>  include/net/netmem.h | 19 +++++++++++++++++++
>>  net/core/devmem.c    | 20 ++++++++++++++++++++
>>  2 files changed, 39 insertions(+)
>>
>> diff --git a/include/net/netmem.h b/include/net/netmem.h
>> index bccacd21b6c3..0e332e04ea16 100644
>> --- a/include/net/netmem.h
>> +++ b/include/net/netmem.h
>> @@ -363,16 +363,35 @@ static inline unsigned long netmem_get_dma_addr(netmem_ref netmem)
>>         return netmem_to_nmdesc(netmem)->dma_addr;
>>  }
>>
>> +struct net_device;
>> +
>>  #if defined(CONFIG_NET_DEVMEM)
>>  static inline bool net_is_devmem_iov(const struct net_iov *niov)
>>  {
>>         return niov->type == NET_IOV_DMABUF;
>>  }
>> +
>> +/**
>> + * netdev_has_dmabuf_binding - is there a dmabuf binding for a
>> + * given @dev and @dma_dev
>> + *
>> + * @dev: netdev to check bindings
>> + * @dma_dev: dma device to check, when NULL it will not be checked
>> + *
>> + * Return: true if a binding is found under @dev and possibily @dma_dev
>> + */
>> +bool netdev_has_dmabuf_binding(struct net_device *dev, struct device *dma_dev);
>>  #else
>>  static inline bool net_is_devmem_iov(const struct net_iov *niov)
>>  {
>>         return false;
>>  }
>> +
>> +static inline bool netdev_has_dmabuf_binding(struct net_device *dev,
>> +                                            struct device *dma_dev)
>> +{
>> +       return false;
>> +}
>>  #endif
>>
>>  void __get_netmem(netmem_ref netmem);
>> diff --git a/net/core/devmem.c b/net/core/devmem.c
>> index 957d6b96216b..f13a0e343684 100644
>> --- a/net/core/devmem.c
>> +++ b/net/core/devmem.c
>> @@ -364,6 +364,26 @@ struct net_devmem_dmabuf_binding *net_devmem_lookup_dmabuf(u32 id)
>>         return binding;
>>  }
>>
>> +bool netdev_has_dmabuf_binding(struct net_device *dev, struct device *dma_dev)
>> +{
>> +       struct net_devmem_dmabuf_binding *binding;
>> +       unsigned long id;
>> +       bool found = false;
>> +
>> +       rcu_read_lock();
> 
> Why do you need rcu locking? I thought xarrays handle concurrency
> inside their helpers.
> 

Not needed. Monkey see monkey do from net_devmem_lookup_dmabuf(). Will drop.

Thank,
Dragos

