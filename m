Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010039.outbound.protection.outlook.com [52.101.56.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE7F417355;
	Tue, 11 Aug 2026 10:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786445262; cv=fail; b=VT7NnseKzyWclf5btadLvAZKl8SbQz+1wp044drI4abhOHUGTNrBUpLD1gNHIzWgr+pij7pJH0Ituxvy3sv+cx6sPfmqO3HYtf7bi+9QEqnVINBqN6uIIJpfF1kYOAMwICF/0P6pQ5sLCmNjrNs4sP95JnhdAcHduywJHZDuNbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786445262; c=relaxed/simple;
	bh=2y8udM+peajEBrA3QKRk0SLTstMs88S8FyXaaYPhWwM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aTVvbH5J4FEDPlhABLIoNQhXoNIDCMtiBZ8kvngXS4bTqNkT1mopuCSrZg4z0wLkfGm/6ke8A6MljrZYN/IxmrUUPcoZlAem1PzcMwE4UnkXeiDqOSs2+iu7/Mmggo8fPqS6gBQgnF6vfAASalyT0focuD6/Wd2mzoQeXHHvkqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nvncKZYY; arc=fail smtp.client-ip=52.101.56.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nvncKZYY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GeaYAHA/A+lSAbvvCH7ZpidlIOz6NtvqsSAzKMVNZRsgksB7QWrkP2DP79iuRxunpPMBpCN0N6ra1ORTTIxd87kFxJNkN4QzWx84hj8GzxfQjJzf/ldFaYLHG3cejX6ZMrGxaAiN+cKISwCeKJERrWM6gMFSgR3NafG5Zl4TwybT3M1+gKfjZgoY/8YG78gvfX44RGEceWldURyS1X5zQWk+9L12qxpnSGK1nJuAH3/d9Sa+LeCYSpXxj81XcIKFTqG9wkMNM61FCUb5HwG0wrBSHiawNJCMLs/5wbweJvvrGOwERgIoOgQ8sawE5WoMqGm+dMn3z1dl305E1sjI5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2lVYWyl0FnPhWq5mNMVfrRkRW5CQ905IGU7cxAqlZVA=;
 b=AbLouq35oAd3OO1LIpYccWlGs/WgXjaaaUUNZHCfL51fKr5mVr2cZ7OnIEIEmBsOJv64qqDRgMj4/gOZR/7Sd8eKW1SXSp/ESEQURqoHsVHThibkqlRUR29iG8cfmmfa8KgvZRG5gfNMqiU3CyjozEDqWu3ug2k/bsTjVmMw55XChfhb96CoQDSILh5ihLm+UbHMKMCK+Zl4sqZ/YK0scB2fKseIC0sMreX/xMNjx85ICjYgctGLCe3hTnG1ddvecB0VdHmFk3V7zNzHCUv2OFbbR12yOF9eyERsEInlNBIG4N9OdKtwFV4SLeTFmJhqEwgpO3QTicbkEbKER4uzBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lVYWyl0FnPhWq5mNMVfrRkRW5CQ905IGU7cxAqlZVA=;
 b=nvncKZYYu2QwiPs4F5Dmv5qIT8CAQhNXxoeT67ha0Z/HN0P4Za4llALRPvbQVfAKxXPq5WF+HV+oj/FLcIY1m/oimG+ROpBMcy+9sHZhDDCMULgJEqUZmiNw7t/NJwhQGTtJ+XhsUazoGM4bZP3f9cnGXeflzdlYdQHFu84aGqoGxpS9fqEMmr1obwQQVzEPP77f1KbIHiBN7xbDrzldtyamtLebDKM838l1uo00sj3WoBLySu4LkUrw6hBLPrnXiaH2yxe4MuMREfjxtpLVRN2TwFxqOs5GzX8MZJFnemEuTF01ZHPtojZwVTCYyGsYDsA3nIe4NSncobU0k7PEjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 by CH2PR12MB4294.namprd12.prod.outlook.com (2603:10b6:610:a9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Tue, 11 Aug
 2026 10:47:37 +0000
Received: from CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7]) by CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7%6]) with mapi id 15.21.0315.008; Tue, 11 Aug 2026
 10:47:37 +0000
Message-ID: <3c8c62a2-7311-46ab-a50d-84818cf7f08a@nvidia.com>
Date: Tue, 11 Aug 2026 12:47:33 +0200
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next] net: devmem: add netdev_has_dmabuf_binding()
 helper
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 tariqt@nvidia.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260810175446.3945358-2-dtatulea@nvidia.com>
 <anpr5knZj33e8d3S@devvm7509.cco0.facebook.com>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <anpr5knZj33e8d3S@devvm7509.cco0.facebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0146.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::10) To CH3PR12MB8728.namprd12.prod.outlook.com
 (2603:10b6:610:171::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8728:EE_|CH2PR12MB4294:EE_
X-MS-Office365-Filtering-Correlation-Id: b13a1f13-8d7e-44a3-daab-08def795f54e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|11063799006|10067099003|56012099006|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	wEwxmV3yUhKUerEuM8bYpsoPjdrHLh2EqdPiREzXUW0hGLs8X3YRxa6cpVMxPPWOFSzZDeZO3J96qbUQFQ6kdei4Wu7AHhzbvRRTmzyJ+oI7p5iTpYdBOWTEVF64gnajK9kFFr/w0NN4CkaLSbofO4QrzojEDTuZBRJ0aaw7+u5EyaNoxTaM54LNe90mOi/GN+Iw0IzEBhM+BTwJwmjPBBxKiBf9P+S5PucJ3IthseR2PB+dXuiXhDVrHB3zLGtkzl1dPudSgQADhMbNF5yNovab9hm3zrs+ApW5G+w7ERQqAi7B7oMYSJN/K+jb1vxcvycqqhxf3L6ABqBAAe4yznSxFx8VBxlomB4FZvQZntmeQXZkVjYWFQ35vhWVRmjDAfW0N3UL5Zqg3hqHaBXvmbM24Sktp8PG2Om1YtyRqNLf5M8kpGz21qQSlJ8NmSnDBiwtXEd03PIyRqxC16aOessK2tEmPnfewGTV2B59Z4/qCvUXBmcAGsmMVzDOat/bJQ1G+F4rqUp7hfs90VN/nZjxnJ5vEIA7IIpYqZM6CDucX44yIOtOvCYWIE+EjZMDlQYnG79dncnO5Q6YrS8Pp7pbCEQpqhk7aw34q/Hg/BDkSoXgp0QJSMMercxvY/d3vaqn7aW1UQKx9VAje5yyNNOb2dQlCLb9NqDkUl92sO4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8728.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2xUd0o3MkdERW9rR1VxU3crUllBY29LTFNRdlE1R0E5Q3FkZHVCNlo5UWxB?=
 =?utf-8?B?eG1CZEJIRWRFcy9VeDh0Qk44Ny93RVQ5V2pYamllazJ2dGl4Wlp0MXdQenQr?=
 =?utf-8?B?cnJBTldmekJvdERtME9mWU1ERVV3OGs5VGFtZkZPTjB2QXNHUUZxMlJsRzFJ?=
 =?utf-8?B?WTg3TXh4bmg4Z1ROZnRkNTFNclhEdytmelI5STlCQlJSK0YyQlRvdzZ6ekUz?=
 =?utf-8?B?N3dUT2xzUHZ3ai81RmFweXV4WnJ6OThYaFJweU5lWnlrTXB4NzJvU2ZUM3BU?=
 =?utf-8?B?WGhkUXg2dW1XclIvVHhwK1RkYjYzTFpscnUrWjR4Q1JXRU5xV2kya2VESDFK?=
 =?utf-8?B?cHo3aHJPTHkzZUhSb0tBSWk1S3BKVVRtbFNsRE93clhyUnZvM0szekdJTG9u?=
 =?utf-8?B?dVpra01sRDdIaWFLQ0ErSEpGZXRZT1FuVnZNSlRuN1h6Y0ZLVE5YM2h6OTJT?=
 =?utf-8?B?eFVjdGlEMHl1MVZrZ3dRYmtSOEEwZkFLUDJvRFdMNVlOKzhnM3IrSjlrbTZr?=
 =?utf-8?B?RWxvOFlGMzRkeUpQK2tTK1VEVUJtcER5VVZlQ200L2ZHdmpRK3kxUEJoVnVH?=
 =?utf-8?B?b3BOT2RRaENDL29oTGxzdXVaRno2VEZRN2p5L3ZxRWpWRFB4eXdsd1BDdjRn?=
 =?utf-8?B?ckErazhreFJYVzh4K3ZLR21sZjh5aTEvdnRjd3ViWkNuZ2dwT3ZUSWY3QU5V?=
 =?utf-8?B?VUlYOHhUQzRFQ01Ydm5PdmN5bDdzbkRiY2ZpbGY5bjE1KzhpOUFrdjBvd2FB?=
 =?utf-8?B?OElzcVNVU2owTlpmdnpJZC85YXhjd3FnN1YxSjVVQ25jZXA2Q2M5aFVZSENH?=
 =?utf-8?B?Z05kTXlUazFsN0pCZ0NyWVlnR21JWVE5dmxmdmhlWVVsUGxQZFVVcmhHMjhZ?=
 =?utf-8?B?d3Z0ellTTGlKRUJraDlta1B0bFp0MEN1WEp6a2g3U2swbHI4V0txSjhsb0d4?=
 =?utf-8?B?RG45bnF6UjBSOVdCMHdlQnRjVjgzak54NEpJV0Q2b2lpQUkvaTc3YVgxaW5L?=
 =?utf-8?B?YnlQUTkxWTZCYXZOZ20veE56VVRUeTh5dGhCRk1uZXlEMVBlK3JPQUVSNmZn?=
 =?utf-8?B?RTUyK1Y4dHZmSlY1NmxYZ0JXeXYyNmNLL2ZrR0ljMjFZM3JJQTJuNTZNdW5B?=
 =?utf-8?B?clFhNlhlWm5vdy9pM3RBUkF2TkRFd1lKYUNNQzg5bHZsV1ZCa0xtd1prT2dU?=
 =?utf-8?B?R3VCeUVYRkhjUWFKNDlXUVllM3BsTlArL3NZdXBWWGJmZC81Ym9XQTBzTjky?=
 =?utf-8?B?WFZETXd4ZUZEbDdKZ08yMWZzTWVOZVNneVFkSFI2cWl2bTM0NnYwK3NWQ3dm?=
 =?utf-8?B?aWpnUi93SHVQa1E0dUl3ZStua2FEdWpFdTNHYTc0QkNBVGl1NEIwM1l0RjJD?=
 =?utf-8?B?cUtXb3lLWTAxQWYrUFplY3VsNjlBblJ1MDZNUnNXV1NVZmVtYktNelJzZHc1?=
 =?utf-8?B?NjNLTTR2RjVjM0h0cXVJam8wY2lnTllreUMrcWpYclZNekplWHIwRFQyZUhp?=
 =?utf-8?B?UldoVERQRFVxL3VFdmZOdC9YUUVveXZaZm9PRVVscWlwb3VqeFpiRTNqMkNO?=
 =?utf-8?B?OFN0T05EMEJ6VFludm1hNGFSYzVkdWdjQ1lIcWJFUlNyVkJnb2Yva3MzT2Q4?=
 =?utf-8?B?Mjd3VDNVSGU4b2xuVGxPVGYrb0R0ZlQ0NVd2WGNmekJDMHViaG96dS9zTzRZ?=
 =?utf-8?B?YUNoTXpqTjU0aG9od0VFc2gzd3VYN3JtYjJSMmJRc1lwbXVLanYrN3F2NzNv?=
 =?utf-8?B?dlhGd0V3dVBxcVloM0hNNFdRMlg4cGpuY3l3ZmJoT1Y1UFpoVktLYzNZb3Jo?=
 =?utf-8?B?em5rMFgzTERaektkU0xnbVVwV0tmc1paU082WHZQZ2w1MmNTeDVDS08vMEpD?=
 =?utf-8?B?TU5YM3pwYTJkMVB3bENaODZzdDhsVUtSTVVuYUoxWEZwdXpnaGNuWFQyN3JL?=
 =?utf-8?B?NUV3bjBlWUp6SkNsZGYxZGNxbTc4dUpmeDQ0bERnY05LcUZMOXlhYWJTYmY2?=
 =?utf-8?B?TGVpaTFXN21WTGdqaXRNY3BoaWhyM2RCNFhUMytIazNKTDcwRDl4UmdkZEpZ?=
 =?utf-8?B?N2xnMlNsMFRCQmdLbkZvUFZiNW1KUGNwcFlvdGpEQmpHb2xtOGhNbDhEUHRE?=
 =?utf-8?B?WVNGR0ljUVJtTkJxVkt6ZXdPYUJKRXBqMDVzVy9nMGZnZ0tXTU5PeXFSODhz?=
 =?utf-8?B?NjAraFlTcFNobW9pRGU3QUtxaHcyMlNzVml2SzdXdXd5b1h1WFNIWGRWQzJO?=
 =?utf-8?B?THVPRzJhbmI4Q3VSMCtEVnF1eEVHeGdjeGwrR2h0MXNTS2Z3VHc5TWYrRlQw?=
 =?utf-8?B?NU5GTVI1cUVnQ090V1hLdElzSjFkRDk4VTNrUEk5dVpyS2ZTTGl3QT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b13a1f13-8d7e-44a3-daab-08def795f54e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8728.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 10:47:37.3017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YMNfmvtADQ9SOVTWd9JaE0QLoLnmD6XBkuuMar8btRth8ZmeXWbT4sUb9jWYh0D122lBvf7VxPtJC3PPfu+v9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4294



On 11.08.26 02:25, Stanislav Fomichev wrote:
> On 08/10, Dragos Tatulea wrote:
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
>>  	return netmem_to_nmdesc(netmem)->dma_addr;
>>  }
>>  
>> +struct net_device;
>> +
>>  #if defined(CONFIG_NET_DEVMEM)
>>  static inline bool net_is_devmem_iov(const struct net_iov *niov)
>>  {
>>  	return niov->type == NET_IOV_DMABUF;
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
>>  	return false;
>>  }
>> +
>> +static inline bool netdev_has_dmabuf_binding(struct net_device *dev,
>> +					     struct device *dma_dev)
>> +{
>> +	return false;
>> +}
>>  #endif
>>  
>>  void __get_netmem(netmem_ref netmem);
>> diff --git a/net/core/devmem.c b/net/core/devmem.c
>> index 957d6b96216b..f13a0e343684 100644
>> --- a/net/core/devmem.c
>> +++ b/net/core/devmem.c
>> @@ -364,6 +364,26 @@ struct net_devmem_dmabuf_binding *net_devmem_lookup_dmabuf(u32 id)
>>  	return binding;
>>  }
>>  
>> +bool netdev_has_dmabuf_binding(struct net_device *dev, struct device *dma_dev)
>> +{
>> +	struct net_devmem_dmabuf_binding *binding;
>> +	unsigned long id;
>> +	bool found = false;
> 
> xmas tree. Other than that LGTM.
Seems like Bobby found a valid corner case that needs to be handled.

> Presumably it's better to ship via your upcoming series to show the actual usage?
I will do that eventually, but would like to get some ACKs about this bit
so that Tariq doesn't have to re-send the whole series every time.

Thanks,
Dragos
