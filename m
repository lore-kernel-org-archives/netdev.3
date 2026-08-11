Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011063.outbound.protection.outlook.com [40.107.208.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09C843711B;
	Tue, 11 Aug 2026 10:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786445058; cv=fail; b=lYQFBa8mqktadDflVMkS+jbiLjNBFXKlBtRlrdpemclEEaXrgQ7ytmwf+ffkUlLrO07Wpo4mPMD/4oOS1+aOzPffCIVyv/wkxFEDmB42U9YOR4TDVWPgcSwH5BwHVZs3ViD24KVn5HenxRaPjmkfFaOZhZti1geelyCwE8JVp60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786445058; c=relaxed/simple;
	bh=p491aixTb0lU9c1ZIbkFTl2LK/AsPOGmUEJdW+9hEog=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kufHCWgIZV/M97Wt2Lml7Jl2jBldoNkgz6WKU95yDo3bPUP+1UbG+wbVcVhcm3jfI8kQG6JMYEmNtuXE4uKOJMxcKi1OsLegimzI15rgkNL5paqvsSPSkQjyo0zsBFPcLUNRDKlVJRXBaNh1qD6f9B8goynSSYIXsdAfRXfw9wg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P9R2yRGR; arc=fail smtp.client-ip=40.107.208.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P9R2yRGR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lReg5MEtEcShD5LhCBuD8V0PZmakgKPzsQ5Ep68pEd0Y38NXk98gKsPD7lNf1uU7fZ2Sh9LijtHRoLNGjgfefDs1dslsWqUatjBhKeO/Vvd0ogsDjWVDMGZCoSQKqLImAr6ZLZFhS+6uSzq77/k4zrePyu4TaxRD9JwV+rp7sSVkqTJp3DwxQcFJ17MA4Pyz3tN0AYQaS0Jd2D8c0MCIlF/Wb6PyulGK70tUqjVG3HS2HdYcdbnArdgJytL24tamf/o4kC18CRSdgM4BId89LRauuj4r+ybUykn+IAzu5mcx8zcniuRZ4yRWIcT2z7DnNE01HoD4ecwMAjQ4jn9rEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=svvMORgjsVimkQVkgfuj5IAMoOxPDnQw6HHY1inviGY=;
 b=GzYYVCB7bnVGVnBnsJOQVUT24b4lPB5+Z/vrS7xRFpxJKD4OChupGGSWCzdAa1SaktGDlhp39tuFwCx1VOORze4SIlrOGyt9np0I5oWLsgmP93lrveJD1gHLmBqFugj2TnIKWK+xn5iX+MILsGGcr2jYamX0M0YG6k3AFqaAuN1Gsx9rb3qMo6mPnZSuym1Hu+9ve9zx8YH6Ass3Tyjs7HQm7voZww56Bfy+ZonH43juMZbjl5klbL/LopaeDnZ6blf8QvDzoIbUh9G8yXJRzYlM3VTIuTEdGk3dH+mi6YWDLyK24Uf7S8Zq+HqPFZm6ZyiT4ArZuiw+2eq084lPEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=svvMORgjsVimkQVkgfuj5IAMoOxPDnQw6HHY1inviGY=;
 b=P9R2yRGRSvsdJ/IXFJd3XSHiFSz4+RScHK5g2zhtY7Z9ZsCYfbXT2rMg+xIDqLRqNfmDg+L3G+CNXyppH2nS9yRjijzF87Vs+c2ad/1xLqicY2RMYLrugRlbF1OT1feVRS8S8IMUcwKeFTlisVaFo4LiQQMP/dTYeoY25Y7TKKiZ0zy9FVNI8CltdksNOVjIoBwdC8z3mlxn+oU/m0RcqwB+vNfqRDeSRG1imT4zY/2Z9v9znVAPvll2uk/KNLgMSuKZJMg0mdITsE6zHGZjnho4NW4pmN9DxTCChOH6sN5t0+iy8xNCXzBhgqibEbobAmjaFoDqZgr0aAKjU5v0Jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 by CH2PR12MB4294.namprd12.prod.outlook.com (2603:10b6:610:a9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Tue, 11 Aug
 2026 10:44:12 +0000
Received: from CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7]) by CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7%6]) with mapi id 15.21.0315.008; Tue, 11 Aug 2026
 10:44:12 +0000
Message-ID: <aeafaafd-29bf-4e17-bfb0-e61e6690477b@nvidia.com>
Date: Tue, 11 Aug 2026 12:44:07 +0200
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next] net: devmem: add netdev_has_dmabuf_binding()
 helper
From: Dragos Tatulea <dtatulea@nvidia.com>
To: bobbyeshleman <bobbyeshleman@devvm29614.prn0.facebook.com>,
 Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 tariqt@nvidia.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260810175446.3945358-2-dtatulea@nvidia.com>
 <anpN3vJUig93aSB8@devvm29614.prn0.facebook.com>
 <dab8a7cc-f202-4975-93a7-7e80a386e214@nvidia.com>
Content-Language: en-US
In-Reply-To: <dab8a7cc-f202-4975-93a7-7e80a386e214@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0150.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::16) To CH3PR12MB8728.namprd12.prod.outlook.com
 (2603:10b6:610:171::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8728:EE_|CH2PR12MB4294:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e06f12b-5bf7-4354-0a34-08def7957ae5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|11063799006|10067099003|56012099006|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	cdADUOAzXuGFwjwqLSlgKrdm1ajsj6BRLcBRXEiBuh7+XK6YCSnBdub9RZg2w/GtHLKpOmZBlaW9bIS1VKB55QfAicLYXzl8sMKGVmQv0756opB0yDluZV6s3yePqgV7bwmTpabk45b6KhyXKZsuLN/uO7uFpp9AT7sCKTQecVLHMEk3yZjXtSd+xh+NEf7oCYLLoIwZulFcWXbmhvo4QU8Mp8oB7zNgzJwHmfaHkppXyq2bg7ehXRwIROp9LdgBr4G50WctZhKq/lfsD1ZsaVfbks8FE4ZDdAxs/Q5Svz4PUZaK4qH1zFSuTSy7D0fzbnX58TauSkMNDY46CRrpYAvgds/q0+Uy7Lrge5/7kFl8tqi3BFGi5J2iNreu5LPp4lAeqV1eYMKflgqrWB7t9QBa+WbCaBVkWsKV8N6mlHh7DGG3c3bveudEur9wfJldpN53ntYmx2Vr8cHCh1aigmn5J3tWxZJtQ7+vvwUHrQ6gtsAeNwaycJ3BC69puDsDxOaHUd077Nvq7QrltiFTjd4F6q3qEAsYaAo+XaUoVV7mEp69Ty5bAS9iE4LYLlbwVqSbUHya02RLnZN2tQKAQMc9p7ELZOb8eu/ofDba86JOPPUgnwgi+HlOevmjYfB5yEj7Cf/beyNeW5No6kGZZX5lZGUdSAheuLjYPfCKcGc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8728.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TnNiTk0ycElGdEhQRmRxazZ5RHUrTHliNEFFZWUzNUZqZVlrTXZoTWlGaDY3?=
 =?utf-8?B?T3hJeW0rYVpXTmZyektud0ZSYUZneHQvbGpxYU5XVGh1eGNsdElGWWZDd1F6?=
 =?utf-8?B?bXZZb1h2R0pGbHBtaDhxN0xPYTRLMmhKdUJWd25xa0k5cXg0TTZHQVBKcE16?=
 =?utf-8?B?azFtVkk2YXZ1cmVTVmU5ZnNHZm5vU2hqQ0JONjUwVjBVRER5ZFkvMktUdEV4?=
 =?utf-8?B?VkxwOTFWeTFGbHpoc3FmRzFjeUZnQlZlU0c3QTdOT2pQSmNZL3lvTyt0b1lI?=
 =?utf-8?B?ak4zUXFhMzA2TmZFUUwzY2hrazZDeXA1NWxMRG85Qkwydm55czFPY242dnU5?=
 =?utf-8?B?U3RZdUpHd3hpUEJZK1pqS2hBSnl2OG5aZTdXVjlKTFl0VUt5NlI4SHNTSG8w?=
 =?utf-8?B?QmNVMHdYbXptdzB2ZzVjRHBQRlIwOUFWVlg5aWRVRi96UlFkRXpOK0pxVVZ6?=
 =?utf-8?B?N0Y0dWU3VVdGdHpjQlluS0VJL3FDdXJoYllYS3p1SFF0U1ZjSk8xNnZiUVlw?=
 =?utf-8?B?K3RDeUMxQzU2cThYbWZhZ2RqbkJoWGhoWUZRb0VXNGJ6NGN4dHFLbVhSL0RE?=
 =?utf-8?B?MVV5SXRxM280ajZnVk4zRU94UVlMNFZVNXRsTDBjOHBTU1M1SnZ1OFFLcG8x?=
 =?utf-8?B?MW1rZVdWTldCTmcrQjVZU3QzZE5IcEplQzFqUjJadC9Cc3ZuK3Z5eDQ3U3BJ?=
 =?utf-8?B?cFdCOEdBRmxZdlREZ3hTb1VmNC9XWW92b3ZQTld1anU2TzZ0MUtUd0FLLzFq?=
 =?utf-8?B?c0FEeUhWWm5udEJXK05SbytuSlZKRTBYSmRDcDBodzRXNFkvaE91UjVUMkhn?=
 =?utf-8?B?S2ZLWWlZT1R4TWFDaFlhTWJNUW56TjN2QjgrSTRmVnptd3pxb1dXSmg1N1Fv?=
 =?utf-8?B?aEwvdlJKbWVNWm02T01sdlA1WEdxZnJDWXQ1bXE4MS9xVVBlN1JXblNta01m?=
 =?utf-8?B?WFQ4dWZER3JoU01HNk9YODhGZVZxRmROY00wOWRrTURmUzZ5Wkd2czZLbXhG?=
 =?utf-8?B?U0pNYjZxK3IxSlBaZzA3OFlGVURLcjhkSkJqNVZESFJIRGlIVmsyQi9OZm45?=
 =?utf-8?B?c245dXlyUEVEMS96WkZublg5WFpVL3JucXcrbFk3OFdLaTlBdEM2dGkxRk1O?=
 =?utf-8?B?cC92Q2RnWnFaQVVIOUliUnV2d0xSa2FmaTd1THdBeFBDLzQwVjJhdjhmYjFi?=
 =?utf-8?B?QkFZeEEyMGRiRHhlaDhYNGE1RTN5Y1gyVmNBZWRqeXF2WG41TERpbXRNMWFE?=
 =?utf-8?B?ODJVUC9iMHhjUUZTWDRldXFSUzJlakN5QWNVZWMxOTNpZ0xGMzFjSUNsMldv?=
 =?utf-8?B?RHlWS1laYVRScHh3andyRUM4UGJqdjRubVRRN08zUFp3K3RJU3pZSkp3NkZK?=
 =?utf-8?B?ZHZid0tmT0VhRWdJZ0gvOGJEQ0hCRERScXFMM3FvVThTYU8yZElVa0xMZ09S?=
 =?utf-8?B?L1hDSm96MTd0a2lOa2pQb1hFMzVlUU1XOHk1QWxLa2hZc3UzZURJWmRPZXox?=
 =?utf-8?B?M2lKNG93WjJpR2VRRjd4eWlEUERqTHVxTm01Tm1rR1F6RzIxVC81S0p5MlNa?=
 =?utf-8?B?MUxOZVNFUS9BeUIrOWhQSFFxaVBDLzRCN3YyeWtmd0dyTXFQS3MvSnljNHpn?=
 =?utf-8?B?dHQvVTJOWC9PbjNoR0ZlRjdQeHc5QXlMc2tWMGFjaHhPcS9BSnpTKzRqMzQ2?=
 =?utf-8?B?UGRzY3dwSlVSV2RoNEhMUy9Zd1JqaWttU2I2Y3ZZMzk3ZlZ1b3kwM0dtbW12?=
 =?utf-8?B?c1N2QmN4eVFucmROb1lielpSdktDT1hucmQrSnRDMzdKd0NjemlXZ3FjT2Q5?=
 =?utf-8?B?b0NXcmdCNUlheTRCMy9RakhVYk9Ka2VTNFBLa0xJUHpEeWU5eE56SVFEcUJ5?=
 =?utf-8?B?ek0vZXZ5YUc2bGhRZDRZeVBkdEIvSWhmNDBtWXcya3l4QnNtZkY0RUVRZGY5?=
 =?utf-8?B?WjBGU3g2aTlXenZWaEdsOHozUzExdHFiaUVBVWNHUy94RGM4UVQwd3U3dWdo?=
 =?utf-8?B?bzdUMFp1U0ZETlZqYmprbmorcW1kb0xaRUVqa0NqWXRMZjE0QTNPQTVhd2VL?=
 =?utf-8?B?b0o0K2xLemR3VVNxTkF0V2JhWVNFQXhGRzZCSVV3a0J0eGsrRThxWEQrdEht?=
 =?utf-8?B?Yzh6Slp4QWxLZUVERjFoaVAwY0xtNlVPSENDRHN6NmtQSmp6WWFNMEhacHNv?=
 =?utf-8?B?cXE3aVdpSldNaHVVZWNMYjdQcWlVYWZZdTZlTlpXV1pCMWl4WkMzQXVlVG1q?=
 =?utf-8?B?SDNjTjlENUdsdldxQTRwbFdYVEdIWTE4c3pLdzMzYS9iVHFoQzhsWVJNczFV?=
 =?utf-8?B?V1lvalZuTkJJdDM3ZVdIT2l4NHdqbDZGUm5lelllSkhjeklhakVtZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e06f12b-5bf7-4354-0a34-08def7957ae5
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8728.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 10:44:11.9953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ctn7HvbpYpUZ01aEZlhXl9VJwRNT//QdZR2FqOH71+fsqXNMpPDfaSDFMrmg+KPE6oSYwesHnMxhcf5p8mYgLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4294


On 11.08.26 09:24, Dragos Tatulea wrote:
> 
> 
> On 11.08.26 00:17, bobbyeshleman wrote:
>> On Mon, Aug 10, 2026 at 08:54:45PM +0300, Dragos Tatulea wrote:> [...]
>>> +bool netdev_has_dmabuf_binding(struct net_device *dev, struct device *dma_dev)
>>> +{
>>> +	struct net_devmem_dmabuf_binding *binding;
>>> +	unsigned long id;
>>> +	bool found = false;
>>> +
>>> +	rcu_read_lock();
>>> +	xa_for_each(&net_devmem_dmabuf_bindings, id, binding) {
>>> +		if (READ_ONCE(binding->dev) == dev &&
>>> +		    (!dma_dev || binding->attachment->dev == dma_dev)) {
>>> +			found = true;
>>> +			break;
>>> +		}
>>> +	}
>>> +	rcu_read_unlock();
>>> +
>>> +	return found;
>>> +}
>>> +EXPORT_SYMBOL_GPL(netdev_has_dmabuf_binding);
>>> +
>>>  void net_devmem_get_net_iov(struct net_iov *niov)
>>>  {
>>>  	net_devmem_dmabuf_binding_get(net_devmem_iov_binding(niov));
>>> -- 
>>> 2.54.0
>>>
>>
>> I think netdev_has_dmabuf_binding() can return false even when there
>> exists one or more in-flight skbs (e.g., in sk_write_queue) backed by
>> the txq binding (won't technically be inactive until the final reference
>> is dropped and the binding is freed)? If so, can this still detect when
>> it is safe to swap the underlying dma dev?
>>
> Oh, good point! I didn't realize that the binding is refcounted and can
> outlive its xarray slot.
>
I can only think of adding another list that tracks bindings for their
lifetime or between xarray erasure and deletion. Not too happy about it
though.

There's also the possibility of iterating over dmabufs and their attachment.
But this requires a function in dmabuf to scan the dmabufs and attachments
under the internal lock similar to dma_buf_debug_show(). But I don't think
that will be accepted. So this is even worse.

Thanks,
Dragos
