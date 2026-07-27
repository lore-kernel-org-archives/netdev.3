Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012065.outbound.protection.outlook.com [52.101.48.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BC424BBF4;
	Mon, 27 Jul 2026 10:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785146501; cv=fail; b=hdYZ7fDOZJ9SI7WMbTYO9ye3lTUR3eYmLhvIVfyKskzIFSbdnkb+vvh9ZFsfURGExFXbTGYFQDH1Hf24eSUWOIZiQVpgtjlDYG7MdO2TBXnChvPCvPIOc179z7Nf0hpwl9YE4HNPGO6gDqRraH/s1HbvO7vj9zfAWoMHxUTyeCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785146501; c=relaxed/simple;
	bh=OhCqhW4vmoRxBqtu0yxtJ8EXo7pxPgbazfrsnAdzfuQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YM1df0WvXgBdbtynjAuKxYZ62kSMViRisn7VCVMstdv1nsVIp4HJheKnpsP4PK0ClVQgBioufkDbV7S5sh73hxSVBT1E7rapCiI7K41RVMt+UAB+Lnd26/wmGKj54Btthhf3LHSjh3qnA7RJbf2tQqRL3Mfe29YpStHqxExhH4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MFB6K+Zl; arc=fail smtp.client-ip=52.101.48.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MFB6K+Zl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HeY7YSQFHhrYpCDQ1ocbUyxtrckOqjbVEIuC0Zbpc7LNbXPvzT/nZzqfEVSirGtvxMy6juofNYIuAYtCNt4AbcWM93yGc3Hh7ulOmFfxocCu3q9ntmuFeZ/JjtMyzeGJ/TkhHDg1SUYDH2YlRk1S4YbpmfW3tQeOHavph7+QxlKkLFPM/kYmUL0nkeMmoz+ndjGBF+QpLB39ULtkDoU7Vb3yl9/C9nS9I3YB4FVf/BOF//JLba1Q8epDA0b5n7/jgADtt6qflfkpdEHLSszV7pie1nSlUaennFVbbY3h8tIwgOu4tMHW3ozhH8b+MbVwA8g2XjZVBxpvO3sRx9zyng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vz/hmCb0WDnCrxFkbTLTvjeJ9+2fSjgxfo23Edih8ns=;
 b=QQSFes8PJ3qTgxBcn1v732U1TU7z+jne+jIwNmbgRqIvX3qTcHk3cuZ70R1hcbbb8oD+CeZDjuzRxpyOpoESxhtPgSDaDLcZOGejjPdEXELuz1TSKmEG0Ybkf0N6Hd5Lk3ZzkDEgEAuphUtKBGXCz1NXM956Bj6gP7rdViLPap4WnQpLtBnGaGV3KMkVvB7Iaacxc31/gA4dJsdABpzdV7bIJQ+kN38pUyG044SYpQjxCGA5cFaqXaZuO+gxP/+qKlX1wtUE4UK3pnTt32PqE1hoD5wYyltxFBy3WjXzYvC/LQk68hd8tq3H9nQKTvccS5Q2B7ZPjDCQ1SxlAjdTFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vz/hmCb0WDnCrxFkbTLTvjeJ9+2fSjgxfo23Edih8ns=;
 b=MFB6K+ZlDqFyrdZw2hC5ciRAJZgk/8zUIGb1I0Nc7oE1zRQZwh6X6fjeYVMiSztkR8eGvn8IXUiWmDJYtphsO8VskOZP97EQcSRhhw0+LWfyGoBbry1nM8Js/5mHeqbpuhSiBY/KtIdsK7JF6bOOgVxe5kdftYKzTHXRVrb2Enc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8953.namprd12.prod.outlook.com (2603:10b6:a03:544::14)
 by CH2PR12MB4054.namprd12.prod.outlook.com (2603:10b6:610:a6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 10:01:36 +0000
Received: from SJ2PR12MB8953.namprd12.prod.outlook.com
 ([fe80::f3b5:fc98:8973:5c0b]) by SJ2PR12MB8953.namprd12.prod.outlook.com
 ([fe80::f3b5:fc98:8973:5c0b%4]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 10:01:35 +0000
Message-ID: <46f74c84-f07a-4f23-b72b-7af12838743e@amd.com>
Date: Mon, 27 Jul 2026 15:31:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: macb: configure ENST registers for all
 queues
To: Nicolai Buchwitz <nb@tipi-net.de>,
 Vineeth Karumanchi <vineeth.karumanchi@amd.com>
Cc: theo.lebrun@bootlin.com, conor.dooley@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, git@amd.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260724043257.2221030-1-vineeth.karumanchi@amd.com>
 <20260724043257.2221030-3-vineeth.karumanchi@amd.com>
 <49ccdd6682366239fef37bcfd99a908c@tipi-net.de>
Content-Language: en-US
From: "Karumanchi, Vineeth" <vineeth@amd.com>
In-Reply-To: <49ccdd6682366239fef37bcfd99a908c@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0061.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::18) To SJ2PR12MB8953.namprd12.prod.outlook.com
 (2603:10b6:a03:544::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8953:EE_|CH2PR12MB4054:EE_
X-MS-Office365-Filtering-Correlation-Id: a73c474c-768d-44b6-e192-08deebc60b18
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|366016|1800799024|4143699003|22082099003|10067099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	D3DZ3FtXivhHN0z9einxL8USR5QwErFV8frVzpb2Na4dMCUb5M9DYWVb3LnG4fZQHU/G3nbbujoAMIqMj4P6In7rNx9SmIIGtIkPwU3TyMSRCWjK/PGF306uxLhJkAdY1O07Pk0fM+h7PwZguv0nXSIrveCvhpprLlY4AwTadVftWDSvKB2z0YBwZVKVL4Qk6fFzKwqU5l+86cxCgbTC55w90AwjrxxDqv9p99HJeuhFRNG9O82/WMOrP9U9UGdBwhM9jh+VL9bP07al71GPn5aVaOmw4wwdi3Pcb2GALs/nlHTBZ80kaKSIgDiiq1o1NkUl+55rNoM61/uooce7PfLB5jDKwJH6iohfmdiG+07FxejqFYU2ZSvOEvWyiIUWyDRPbLKvsRIKmJCfXFkolJPSmPZy7/CwuOClROWpxG7xd9fWDYbsT5oQWA/gbenD9VJXuT5zeJWxEGKhTFMqm8DydEWRfpsNwaW5GS04TZRf9MZhuID5gl6zsl+yzdTklTl+KSGuNphzOn+qcJWZdwoRgt2wY8iQ6oeqByPSpYx+Ae4XtzRX/OkkBqjyn22SbTi3ip6e1jhJSz7kES8QWrvhGZqHibE5hZtosNFrve4cdx8CUAwW05z0YS9YxdBN16/CPFLRLsoJJNHRwovq43hvr/UhYY1cOwg9OioaP/0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(366016)(1800799024)(4143699003)(22082099003)(10067099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RVBHUHUyLytnaGIybFZPTUJwblVCYUxuVWlMaW5qeEVuN1c1NS9paUY3RlBV?=
 =?utf-8?B?Tjg5aGorY0REZnFPSmhNd210MFd3bGdDYnJBOXVwSCtoMnJlYXlJM3VLaHg1?=
 =?utf-8?B?N0h5aTVHTDBReFFEOVAwSVRLUHVNN0UzUzhTVzJtQjNhZXVDWjBsNzNydDBt?=
 =?utf-8?B?eFNxcjM3MmRLZWRQYytpQmJLbll6UWUyQkVJREZFWFJzQzBpcmN3bWRNR0xO?=
 =?utf-8?B?WmVzSEJRenNWSGdXTlRQdzRDUXFjcHVnM0c0M29Xa3JTK21FVW0vbEZCa1Uw?=
 =?utf-8?B?THJsTE5kTUtGSndTM29kQktJTkUwUTh1T2RGaEdQV2lMb0Jod3hPOXBBc0Jj?=
 =?utf-8?B?R25jMEdYUnJWSlp5dzVEajZ3MVNJemZxSGVWdW1USXViTURRcVljTlVaMkNI?=
 =?utf-8?B?aGRBeDNNTHRhVU53c1VKWG5CcUlGNUpSMjgzTzJNaFpKcTlQTEtWanNhVDR5?=
 =?utf-8?B?M0h0b1RPL1FWaVdTTUlrZFhiTlFHVFdxdXFTMmlucER5ZW1DcWkvOHE1Y2Z0?=
 =?utf-8?B?eXJ4djRUSE8wV0ExbEFsK25sc2RTb3ZPaTRQd1pFN1NxUHJEbzY5U3F3Rk1I?=
 =?utf-8?B?bGhhUUV1OTBNS0Y2bEljbmx3b2xOazRGV0dxaWtjNkhqUEF2L2ZnVDBCSjdN?=
 =?utf-8?B?cUd2VGFLcmNMd1NPTjRpbVloZ05GTC9OVFNyKzRwelQwMHgrRHBTTkhIbERt?=
 =?utf-8?B?SjFCaHVmOTNKQ1pqampHOTVsTXN0OHJuWUVCc0NkaGhmMUp2SEtxNHJRRkd3?=
 =?utf-8?B?UHdneE51YiszOVZobDNvSkJ6NE8rZGg5cHg5a0w1VVB5dUZoZzlEa25HWjMr?=
 =?utf-8?B?VVhrdURoZHJzaENjUmRtcTU1TGRrQnFrTmpnWms2a3E1Y1dMZjNIeGRSQ091?=
 =?utf-8?B?WXlaNis1YlJ6S0d0MmZoMXRxQVV1cWdUR01SWFJLMkI5OUgrZDlDNkc1VUFC?=
 =?utf-8?B?MEJMU3dTWVd6dVk1OWRKMWpKa1dPUUNxSmFHQnlVaEpBaVVFRjhDS0pSeEFv?=
 =?utf-8?B?WUVRdkt3aE5SUnNTWll6bUJCUVFKNDhlQ1prZFl1NWliOWV5blpxVW1adGFV?=
 =?utf-8?B?U2NSSE4rdzZ5V0ZDY0FVVHhjMVVrSXp2MGFOYUZPTk5ZdTJXL2w0alpxc296?=
 =?utf-8?B?S0cvMGRGVGlZVVhhZTNoQmMyOXBCZS9yTllqQ2RZSjdXV3VKZUZId3diYkNm?=
 =?utf-8?B?clFSSzA2bTFEYUx0MHVDc1lXMnhaRG5TaTNGRjIxbURjUGhrQjR6eDVGSWdZ?=
 =?utf-8?B?VEF2b3ZkSFlYelVVdVRjWVRMNFhHOTVTd0VDQ2RXYUU3VDVPaUxlQkZzWkxD?=
 =?utf-8?B?S256Y3Zkb0xxSWZLdVZ3SGlub3JjcFA5ZkVwd092aVVwTDdzS0pmVGdSNFEr?=
 =?utf-8?B?WUFjR3V2SlJKUUtheVRTWDU0Y3gvUjhraXNTdEt5RGx0T3VlbU1mblVBeW43?=
 =?utf-8?B?K1ZNUjdlSUhVazl5NS9WWVp1am13VnZWYmtZS20vTFBkVUtXZEVTV2VITnpP?=
 =?utf-8?B?NmJURXJVL09NRTJZNWpSbE9KdjN2ZmN1VHVGQkFCNkNKdGE3UWV5dFlqaFhv?=
 =?utf-8?B?bWk3NkdnYXJOb1ZRcDRVYjVtVm53VDZ2OTlweE51ODlVTU5WQkFNTC9xa0R2?=
 =?utf-8?B?YkRBYU50eVp0ZzVFV2lTNzd2YWhFWUEycnMwOU1CVUF1REF4THpXbDBTanZF?=
 =?utf-8?B?QVI0V1pscDlJLzdSWWRMVlBSRzQ5cC9VOGJBODdwamltSzBXK0RBbSszYTdT?=
 =?utf-8?B?d0hURjM5TXVEMW9GK2JqRnJuKzAzZi9ZNWpOYXd4WVpFVHVzWCs1ckpQaWlW?=
 =?utf-8?B?N0FrdkJoNi8yWU15RTN6b0Q3aDhXVVJpbHN5Y1drRDNJM3NrR2x0U0ZwYURv?=
 =?utf-8?B?T0YzWkZkMTNNZ29BZnJZWGtjNXpDR2pMTzZKWWVWUi9tSGFqNDBkVklPOVRy?=
 =?utf-8?B?VDRTS0x5V1l2L2RlQ2hORXEvZVRYcW9KaFkwWU4xVVRIeTFqdk5TdURYNUc3?=
 =?utf-8?B?TXF2MnlXSkhEc3NLUzFKeGJOZEJPbllHZCtsb0hoZm1TTXR2VGJOM0JHY1VG?=
 =?utf-8?B?ckpqeDF1N1pleVlCUnpOVWdKVDE4KzVrd3Y2N3hSZlY3V0lFaTJENkc1UWI1?=
 =?utf-8?B?cU11dzRrZ3loV3RVV3RITTlZZjA0dGJ0aEhhRDYxRmlSbEhqUXFtRHNDK0cr?=
 =?utf-8?B?Um5wWGtCTVBRT2dUV1p3aUhpZ0IyejB1S29TL0wvSEJmMUFmOFNZNlIzRlBI?=
 =?utf-8?B?MTRBVVY2TDhrV0RpNU4wbG0vSjcyalRCUWl0VHhsNktnakJobTNaVjZxZ1Rt?=
 =?utf-8?Q?kyXIwLPyA1YYJZVLkp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a73c474c-768d-44b6-e192-08deebc60b18
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 10:01:35.8939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3PBkNZbwvfC2RM3zeBB8CJdcW/SVOLzTqrirLahhIL0IM4hC+ZSD6ZVj/FAvD8hK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4054

Hi Nicolai,

On 7/25/2026 1:27 AM, Nicolai Buchwitz wrote:

<..>
>> Key changes:
>> - Drop queue_id from struct macb_queue_enst_config
>> - Allocate enst_queue[] based on bp->num_queues instead of
>>   conf->num_entries
>> - Index enst_queue[] directly with the queue number
>> - Program ENST registers for all queues
>>
>> Fixes: 89934dbf169e ("net: macb: Add TAPRIO traffic scheduling support")
>
> In addition to what Théo already mentioned:
>
> The series targets net-next, but if this is a real bug fix it should
> probably be routed via net. The offending commit is in stable since v6.18.

Sure, I will split the patch series accordingly and submit the updated 
versions to *net-next* and *net*.

Thanks
-- 
🙏 Vineeth

