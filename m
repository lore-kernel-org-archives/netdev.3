Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012065.outbound.protection.outlook.com [52.101.48.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649214E534F;
	Mon, 12 Oct 2026 20:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791836532; cv=fail; b=U9tEaU+pJAKfeIxCNHCVChRmpjwvU6j5vQJBs8TRr+PN1nG/OQJ9FmpgKpNTYGmuheJauzASTyE6X0ggnyUbmOVSCZuYAlavc4GKXkqX2zzsj4OvtXFvjXD4VpkzwREpiK/7x3juMp2jiAN/lMaTBuel21kXWw00aeJ1ej7GNwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791836532; c=relaxed/simple;
	bh=+MxAUE+9o1Ozy2TKCuMMHJCgMKIUpED3bqnCogzp/L0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KyW5iglKXpKFb5M/iwKBaysuD6F+5Phc3hIIb+ZBwUwjm103CCzXYD9bI4wc1UMiWcUWbasOuB+9Onjvsj6mpNZh/9/Bu8RGFpwIEWYerjmHq/6B50qBNBzcAkM3UWIqbW6sh5Zjufjrbe8B6oQniDIKmmkH9Uc8sEOqfJbWKGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jN1YtT6g; arc=fail smtp.client-ip=52.101.48.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jN1YtT6g"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DDuCFxGM7u1Fiwv8zYCi/cHZCvMOowS8+1kMW3QgHZaqxHpwlvKtKs1qnfEcGhLbqy9pyUhy6N7CyhCq70/o/xgSm8fXDsimFE4u8NBKpMC6x+4U2mNQ3jwcJbyjO73KTuY5+FNGHSfvuTFNqB3FJhcuR5qFpGKbEMrDiYOTAmcpnB42AifBA66TMLftFxUsEjXFJbgZ2A4s9eM+LnP9FFttE4HWtN5PRyukuyfQbQAeGBpWi7SVdG54eOkOvKmIG94eq0vAhShC6ljZY5nlLS7jx7ur3YsKbSiBGiGvuqdmhmf1W7izA5yRCbTy5i0G8NVRqZc0TainPOaB1kvqVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q+736lgsPhd9PJNJ7V0OnO+BACAbOFd/jLQIPYPeZx0=;
 b=GeYXrC46QYPUsDBLeUjifPvetAV+ArU7h/LyLuPzxKApmCnyvsnvf+TCjH4JkRTNH/JpKG6iZ3aFxwCYtUTKOMfToINFCRz6zv63IFKp6u/AkOPeZbmreo4q502IywNjFQ6/FhNC9mtprJbOH5d8kJFiTEWnmHM3BKhDiuPup9/Hh2QVI9qAliXq+JmS1camnHt/ldDpLrdf2eCrDjUAsUYi6rhjEQZyIXQzQUHLX2IemtTt6fgEoXsIep2Yon+rHQdYjrIjp2iG+KjFCDoXtwf9vDISRbF6w7a0OJ79FF3ADj6TKYHW1kxnPmFNLoBrx4auFSn1DoPrINXyzXME1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+736lgsPhd9PJNJ7V0OnO+BACAbOFd/jLQIPYPeZx0=;
 b=jN1YtT6gawrgxR8Df+4cl6TU4VEERjEcuK/s9VW7NQxuiHZ7k9ysmvov8F3C1RxjIbgvb2DUx+j//1aUDIHR6ADooQoWRwrgNjVDQNOgEiWPaKiND8ERJlk/f0m5tIX249LlyXQmb74wsOEyRaUsVSYq6bB7NRBu/HC/vNk49Wo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB6798.namprd12.prod.outlook.com (2603:10b6:806:25a::22)
 by BL1PR12MB5851.namprd12.prod.outlook.com (2603:10b6:208:396::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Mon, 12 Oct
 2026 20:22:06 +0000
Received: from SA1PR12MB6798.namprd12.prod.outlook.com
 ([fe80::e317:e4a3:6ae9:8c54]) by SA1PR12MB6798.namprd12.prod.outlook.com
 ([fe80::e317:e4a3:6ae9:8c54%5]) with mapi id 15.21.0496.021; Mon, 12 Oct 2026
 20:22:05 +0000
Message-ID: <5c53d8f6-6d3f-4a1b-b3dd-a973edeb6d06@amd.com>
Date: Tue, 13 Oct 2026 01:51:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 1/6] net: xilinx: axienet: Introduce
 axienet_config for MAC-specific ops
To: netdev-bot+sashiko@kernel.org
Cc: radhey.shyam.pandey@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, michal.simek@amd.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261006110550.1990213-2-suraj.gupta2@amd.com>
 <179163334130.434549.15131171299292504182@kernel.org>
Content-Language: en-US
From: "Gupta, Suraj" <suraj.gupta2@amd.com>
In-Reply-To: <179163334130.434549.15131171299292504182@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0052.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::27) To SA1PR12MB6798.namprd12.prod.outlook.com
 (2603:10b6:806:25a::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB6798:EE_|BL1PR12MB5851:EE_
X-MS-Office365-Filtering-Correlation-Id: d9a96f1a-d49f-4de6-53ec-08df289e7afd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|10067099003|261009220027099003|261009221727099003|261009223027099003|261009223327099003|261009221227099003|11063799006|5023799004|4143699003|6133799003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	KX9038k0rlLwaLcxUCXHJalhrhuDLxp/4VmdtNrn4EmFGSdJR66wngb+kjfuZIaF/mTT/wfg+o7ElS4khJAVHX9MV2bHwhSnJ29tXFZJ6VsOaA5p/aCybqeCqxIn+yjPgdhHiRh8DfXING6RNAaIYC1nZZjUckdvcFVV82UN5MeQ+xLjR4+jI8x80kplCkk33NavMysWN7TjfjC8eOZrVpIr+0bPNH3ElmsoVJIkWvkdJLUvhQoHk1W1sQmx2aIVcVSqVehbvcgH1czbr9d41qx9nNuBGjif2WaOoWnO3L+Xi6wExkyRBRbzX0JNfFRJEdpzzAeEHamkCQ2zn6zHAxBV5cfyjagUE+Tv3Tumtw1ZXLIu/SHrhdI6SKmShnO+1XrowVlOd2JaJxGLNaoZFfpLSz0DnSBV1vfD9OuVhNleW1IGaPm8F1VmmYmXYWw7AG+kIiKsH8YfVHfMDl3NYiW6Gpjb9lzYaGjn71nkrMcJDRAHytbzaeEf3ZgWgEAzfaexp9rSKX5fFOmfxDMAnwuYzsro8dU3SsPLFlYd+1FNXdiluMwgur/Mh351+MA1yhN5knn7h8aVE3/jdup75QSto9Xy+PQhUVWIH88CgLzp+84pvYdV+Htvnwsgd3vAW3yf5halEbz9cGxi0afO8ZebSdFA0SEUGFPjU2pVTHY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB6798.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(10067099003)(261009220027099003)(261009221727099003)(261009223027099003)(261009223327099003)(261009221227099003)(11063799006)(5023799004)(4143699003)(6133799003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aitpYnFaaG16cGFIYnFnbnVwRmJhUXllZnFRUElXOGFiVGxmSGNldXNhYVFt?=
 =?utf-8?B?NFdJaUF3bGhjcFRWM2t3cFhPOGxTa1pTejZWOVZab3EzdExKWFJiN0lNbTNM?=
 =?utf-8?B?LzdiM0NINk1hOTlDTlFLWG5zb1BzOEFMYi93MTE4SUx3Qzg4NnFGZHA3SUdh?=
 =?utf-8?B?c2lTZlhQL0k3VWRHTHNqN2wvSFlHOVVRL0d6QlVSUWM5Q0J4TTFIcG9kSFNT?=
 =?utf-8?B?eC83Nzh6MWg1TWQwYzhvaW5yZU9DcWFIamp0aWUzRWJQZU5ISjdwVit2UG5u?=
 =?utf-8?B?YUtEK1NMTnFSRGc4RTNSbXZLZCttaHlKdXFRdVJmSWErbUFXcWtaR2xxcld2?=
 =?utf-8?B?ZTVYM0lXeEI2d05ISXJqVXlCbGd4QmZIdnIwakoreHF6V2Q1aXZ0R2txQURz?=
 =?utf-8?B?OXp2ZThJZGJvRldpYkxZemsxOVlTQnNha1I5RnJZSUZYQjRGZyt0T3U5TG5W?=
 =?utf-8?B?anQ1R2hOZSsvUE80N1l4SmY2aDNPQ1BVMHNxMm1rMUJOSmpWeXNOWVB5c3Zz?=
 =?utf-8?B?bm0rL2FsWDRVVkQ2M1ROb1BHK0drOExYYkdRUmlTUVpXUWRQRFFOWGNtSzlS?=
 =?utf-8?B?QjVpV0tKSVJYOTh5WGxicWNLcVlCbUxyQWJiMklBZENDNStxK2E4NHBid2ZX?=
 =?utf-8?B?VFdmbmZqMDdaNU5TUjhZUVNodWtSMCtPdHVsYlZacXhIU1ZDWU1pRXIrdWRq?=
 =?utf-8?B?Zm5rOWxKaDlsc2pSc1dTRHNpbEhkeUdSaldNV1M4SXlRK09yV0x5RlMrVWdi?=
 =?utf-8?B?U0VtcVdGeFNXVlVYMkxDdTNnWW1OUnp0WlVXcldSclkvUEp2RGRVSThFRGtM?=
 =?utf-8?B?RzZDQmd5Q2ZRWFJ3akRLQkNoMWJabEZ6OVY5N1JZa2lLRGh4Ymt4QzFjdFIr?=
 =?utf-8?B?MStTL0VPNmdjZVE5OXA2dUZXK2lsZjhDYTdkcUFrSFdZUk1QRVFlSlVKbUNi?=
 =?utf-8?B?cHVKcmFCTDQ4QklpY1RndG1oc0pRNVBsOE43VDlLVHQwaWVuWnh0V2lkbDJi?=
 =?utf-8?B?MW5Md2Z4Z2p3RTdPS2ZyZExBVVNhLytxdW9uNXBBUWRzelh2OVdDNmFtdXR2?=
 =?utf-8?B?aUErUUJxeHVNNi96RlUxU1plbFBRVE5EeGdEbGVZanIvUThlTlZzcUIrNDdP?=
 =?utf-8?B?V1NETE5VRVdZWkhhMWFMZ3dUb2ZNK2tieER3d3J3cE9EQkdtam4xcDNNazN6?=
 =?utf-8?B?SWpFcjhQL1JwVGRILzhqUENkODhYMTFCTTcrMWh5SHZwdFl5T3dhVUVsODVp?=
 =?utf-8?B?NVQ3UXQvNldDU1pUTWFrUGhSb3EvaTBBVFBsK1EvNDBZWEx4cU5JckR0dERO?=
 =?utf-8?B?aHJMSHBtR1ZlSFNsVmt6OUFiTTZORTg1eVJTTjJ4OGYyNGdLaTJrZ2NzRUpq?=
 =?utf-8?B?SkRqYXI1Z3NKcW1XdVZBNGtEbmtVYmhMVncrWUtZc3ROV0dvc05qbFdBNXVz?=
 =?utf-8?B?UU1oMlFJNVNXS1RTNUlVMGRaUnd1QVI5dEl2YWNoVlNHOWM4TmF5R2lVTEdq?=
 =?utf-8?B?M1plSmJUZWM2WHRSOW1XOHVzeTlUZXZuS0tzUi91bFVSclVYbUxhRUhQRjJ0?=
 =?utf-8?B?Q3J2TDdBaWFWQk85TkUrbTlQcEtMUEtQOW1BbkJrNHBESEZhL2VjZVNFZFY5?=
 =?utf-8?B?ZlJ0UGtXTkRueWkwV2ZEVjhsVUp6MCtHL25IM2UrNG1wbFpEeitBc3ZGSGVI?=
 =?utf-8?B?RVJ4bDBReXN3NU5uZWY1UVV2RXdSamxNeDJTRktHS09GZVg3RUJkdjJqcXU3?=
 =?utf-8?B?YjRTSDM5SzE0cXRNS3NoWFdDNHV5QWtXbEwvSnA5bDVYakhWdnQxakkydFJn?=
 =?utf-8?B?MDhkbnZZa3E0YXFHck9VSFBCbmh1cmJJaEROb0tlWkJncjYvTTRZWDJQTWds?=
 =?utf-8?B?VS9PaTNDMlNzenk2TDhla2Q3SGQ1YzhQY2VSejdGejdCTTRSK2lTcEw0QnlP?=
 =?utf-8?B?eUdOdmZyZVRpdWFzV2pPdHptYmF6RnZ3VUZvSkhMa2xkZ09hR0xrTTlJeWlL?=
 =?utf-8?B?d0V4Q0xITHJCUm9BUWx1bmdWYXdqY1FJNmNDN0gxNXk4dXM2MFpDbUo0N3RW?=
 =?utf-8?B?K3NEYWlyZnNOcUJMZDZ5ZUoyMVhnYnZESE9sSVNobGVjRkc5VUN0ejF4SXJv?=
 =?utf-8?B?TW5vUzQwT1lWRlU0NjRBMkJlT21rMW5OcXExbG1mc3NtRUFJVmhPeEdCM1Fk?=
 =?utf-8?B?bXRqVkdTSnBTM01DYnNsdWd1MGU0c1MvVittWWtFVkg1N3paY0hDOEI2akdi?=
 =?utf-8?B?bGdKYU5wRWdSbEozUGVxRVRFRjlwNFY0YmpEaGhKcGd1UjRFQTBTZWtCT09P?=
 =?utf-8?B?YkxxelhUTXErUkQ3L0ZQSU5SM2YxamR5Yk43UmZpaUtBbEdSZU5rUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9a96f1a-d49f-4de6-53ec-08df289e7afd
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB6798.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 20:22:04.7791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W3lW/by/jG01WYABoMQusJkPKLvE98d6f4WjyQN8ptL+TvSk7fGt6DW1QiOWNB4WlKTAQSksijZjakXtiiRHxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5851



On 10/10/2026 5:25 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 6 potential
> issue(s) to consider.
> 
> Critical: 0 (1) · High: 0 · Medium: 1 (3) · Low: 5
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] The commit message says "No functional change intended for the
>    existing 1G path", but the patch changes 1G behaviour in…
> - [Low] axienet_dma_err_handler() ignores the return value of the new
>    int-returning mac_init callback, then re-enables TX/RX through…
> - [Low] The new axienet_config::jumbo flag is documented as "MAC supports
>    jumbo frames", but only axienet_device_reset() reads it, and only to…
> - [Low] Mismatches between the kernel-doc and the code for the optional
>    members of struct axienet_config.
> - [Low] The sw_padding and tx_csum capability flags are honoured in
>    axienet_start_xmit_dmaengine() but not in the legacy…
> - [Low] On the non-dmaengine path, axienet_device_reset() returns early
>    when mac_init() fails, after axienet_dma_bd_init() has already…
> 
> Pre-existing issues:
> - [Critical] This problem wasn't introduced by this patch, but
>    axienet_start_xmit_dmaengine() increments lp->tx_ring_head before…
> - [Medium] xlnx,axi-ethernet.yaml lists the interrupt order as Ethernet
>    core, Tx DMA, Rx DMA.
> - [Medium] axienet_open() discards the return value of
>    axienet_device_reset() by overwriting ret with…
> - [Medium] On the legacy-DMA path, the BD rings and mapped RX skbs
>    allocated by axienet_device_reset() are leaked when axienet_open()…
> 
> --
> 
> net: xilinx: axienet: Introduce axienet_config for MAC-specific ops
> 
> This commit adds struct axienet_config, which holds capability flags and
> per-MAC callbacks and is filled in from the OF match table. The shared
> axienet paths now use it instead of open-coded 1G behaviour, to prepare
> for more MAC types. The commit says no functional change is intended for
> the existing 1G path.
> 
>> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
>> index ae8ed4495ea0e..5af48d5cbed3b 100644
>> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
>> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> 
> [ ... ]
> 
>> @@ -711,19 +744,23 @@ static void axienet_dma_stop(struct axienet_local *lp)
>>    */
>>   static int axienet_device_reset(struct net_device *ndev)
>>   {
> 
> [ ... ]
> 
>>   	if (ndev->mtu > XAE_MTU && ndev->mtu <= XAE_JUMBO_MTU) {
>>   		lp->max_frm_size = ndev->mtu + VLAN_ETH_HLEN +
>>   					XAE_TRL_SIZE;
>>   
>> -		if (lp->max_frm_size <= lp->rxmem)
>> +		if (lp->max_frm_size <= lp->rxmem && lp->axienet_config->jumbo)
>>   			lp->options |= XAE_OPTION_JUMBO;
>>   	}
> 
> [Severity: Low]
> Should the new jumbo flag also limit the MTU range? The kernel-doc says
> @jumbo means "MAC supports jumbo frames", but this is the only place the
> flag is read. The MTU limits do not check it:
> 
> axienet_probe() {
>      ...
> 	ndev->max_mtu = XAE_JUMBO_MTU;
>      ...
> }
> 
> axienet_change_mtu() {
>      ...
> 	if ((new_mtu + VLAN_ETH_HLEN +
> 		XAE_TRL_SIZE) > lp->rxmem)
> 		return -EINVAL;
>      ...
> }
> 
> So a MAC with .jumbo = false would still accept an MTU of up to 9000,
> limited only by xlnx,rxmem. axienet_device_reset() would then raise
> max_frm_size to mtu + VLAN_ETH_HLEN + XAE_TRL_SIZE without setting
> XAE_OPTION_JUMBO.
> 
> Later in the series, axienet_10g25g_config leaves .jumbo unset but still
> gets a max_mtu of 9000.
> 
> Is the @jumbo description wrong for XXV, or should max_mtu and
> axienet_change_mtu() check .jumbo?

The functional path is fine: max_frm_size (the RX buffer size) is set 
from the MTU regardless of the flag, and XAE_OPTION_JUMBO is a 1G-TEMAC 
option with no entry in xxvenet_options, so for XXV it is a no-op. The 
problem is the flag value: axienet_10g25g_config sets .jumbo = false, 
which is wrong -- per PG210 XXV supports jumbo, and 
ctl_rx_max_packet_len already defaults to 9600, so no register 
programming is needed. In v5 I'll set .jumbo = true for XXV and make 
ndev->max_mtu honour .jumbo, so the flag, the accepted MTU range and the 
hardware agree. (XAE_OPTION_JUMBO itself stays a 1G-only option.)


> 
> [ ... ]
> 
>> @@ -740,26 +777,18 @@ static int axienet_device_reset(struct net_device *ndev)
>>   		}
>>   	}
>>   
> 
> [ ... ]
> 
>> +	ret = lp->axienet_config->mac_init(ndev);
>> +	if (ret)
>> +		return ret;
> 
> [Severity: Low]
> On the non-dmaengine path, axienet_dma_bd_init() has already allocated
> the BD rings, mapped the RX skbs and started the DMA by the time this
> early return runs. If mac_init() fails, does this leak the BD rings and
> the mapped RX skbs?
> 
> None of the configs in this series can hit this. Only axienet_1g_config
> allows non-dmaengine mode, and axienet_1g_mac_init() always returns 0. A
> future MAC with both non_dmaengine set and a mac_init() that can fail
> would hit it.
> 
Confirmed. On that path axienet_device_reset() runs 
__axienet_device_reset() -> axienet_dma_bd_init() (which allocates the 
BD rings, maps the RX skbs and starts the DMA) and only then calls 
mac_init(), so a mac_init() failure returns without releasing them. It 
is unreachable today (only 1G uses non_dmaengine and 
axienet_1g_mac_init() always returns 0), but I'll restructure so a 
mac_init() failure on that path unwinds axienet_dma_bd_init() 
(axienet_dma_stop() + axienet_dma_bd_release()) before returning.



> [Severity: Medium]
> This is a pre-existing issue, but at this point in the series callers of
> axienet_open() never see the new mac_init() error:
> 
> axienet_open() {
>      ...
> 	ret = axienet_device_reset(ndev);
> 	axienet_unlock_mii(lp);
> 
> 	ret = phylink_fwnode_phy_connect(lp->phylink, dev_fwnode(lp->dev), 0);
>      ...
> }
> 
> The result of axienet_device_reset() is overwritten before anything
> checks it. axienet_1g_mac_init() always returns 0, so this patch adds no
> new failure.
> 
> The later patch "net: xilinx: axienet: Add 10G/25G (XXV) ethernet
> support" in this series adds the missing check.
> 

Yes, as mentioned later patch fixes this.> [Severity: Medium]
> This isn't a bug introduced by this patch, but on the legacy DMA path,
> does axienet_open() leak the BD rings and mapped RX skbs that
> axienet_device_reset() allocated if a later step fails?
> 
> A phylink_fwnode_phy_connect() failure returns straight away:
> 
> 	ret = phylink_fwnode_phy_connect(lp->phylink, dev_fwnode(lp->dev), 0);
> 	if (ret) {
> 		dev_err(lp->dev, "phylink_of_phy_connect() failed: %d\n", ret);
> 		return ret;
> 	}
> 
> The err_phy unwind, used for the request_irq() failures in
> axienet_init_legacy_dma(), also calls neither axienet_dma_stop() nor
> axienet_dma_bd_release():
> 
> err_phy:
> 	cancel_work_sync(&lp->rx_dim.work);
> 	cancel_delayed_work_sync(&lp->stats_work);
> 	phylink_stop(lp->phylink);
> 	phylink_disconnect_phy(lp->phylink);
> 	return ret;
> 
> ndo_stop is not called after ndo_open fails, and the next open
> overwrites tx_bd_v and rx_bd_v.
> 

This is a pre-existing issue and can be addressed in separate series.

> [ ... ]
> 
>> @@ -941,19 +977,21 @@ axienet_start_xmit_dmaengine(struct sk_buff *skb, struct net_device *ndev)
>>   		goto xmit_error_drop_skb;
>>   
>>   	/* Fill up app fields for checksum */
> 
> [ ... ]
> 
> [Severity: Critical]
> This is a pre-existing issue and was not introduced by this patch. Can
> the error paths in axienet_start_xmit_dmaengine() knock the TX ring out
> of sync? The producer index moves forward before the steps that can
> fail:
> 
> 	lp->tx_ring_head++;
> 	sg_init_table(skbuf_dma->sgl, sg_len);
> 	ret = skb_to_sgvec(skb, skbuf_dma->sgl, 0, skb->len);
> 	if (ret < 0)
> 		goto xmit_error_drop_skb;
> 
> Neither xmit_error_unmap_sg nor xmit_error_drop_skb rolls it back. The
> skipped slot has no DMA transaction behind it. Its skb and sg_len still
> hold the previous lap's values, or NULL on the first lap.
> 
> axienet_dma_tx_cb() consumes slots strictly in order:
> 
> 	skbuf_dma = axienet_get_tx_desc(lp, lp->tx_ring_tail++);
> 	len = skbuf_dma->skb->len;
> 	...
> 	dev_consume_skb_any(skbuf_dma->skb);
> 
> So the next completion would process the skipped slot. On the first lap
> that is a NULL pointer dereference. On later laps it calls dma_unmap_sg()
> on an sgl that is already unmapped, reports a stale length to BQL, and
> frees an skb that has already been freed. The off-by-one then stays for
> the rest of the ring's lifetime.
> 
> Normal load seems enough to trigger this. xilinx_dma_prep_slave_sg()
> returns NULL when xilinx_axidma_alloc_tx_segment() runs out of its
> XILINX_DMA_NUM_DESCS (512) segments, while the axienet ring allows up to
> TX_BD_NUM_MAX (4096) entries in flight. dma_map_sg() can also fail when
> swiotlb or IOMMU space runs out.
> 
> The problem is still there at the end of the series.

This is a pre-existing issue and can be addressed in separate series.

> 
> [ ... ]
> 
>> @@ -2759,29 +2819,114 @@ static void axienet_dma_err_handler(struct work_struct *work)
>>   
>>   	axienet_dma_start(lp);
>>   
> 
> [ ... ]
> 
>> +	lp->axienet_config->mac_init(ndev);
> 
> [Severity: Low]
> Should the return value of mac_init() be checked here, as it is in
> axienet_device_reset()? The handler re-enables TX and RX through
> setoptions(ndev, lp->options) either way.
> 
> This handler only runs on the non-dmaengine path, which only the 1G
> config can use, and axienet_1g_mac_init() always returns 0. The later XXV
> patch in this series adds a comment at this call site saying so. It may
> be clearer to add that comment here, where mac_init() first gets an int
> return type.
> 

Agreed. The unchecked call is introduced here (patch 1) but the comment 
explaining it only lands in the XXV patch. I'll move that comment into 
this patch.> [ ... ]
> 
>> @@ -2943,7 +3075,17 @@ static int axienet_probe(struct platform_device *pdev)
>>   		return -EINVAL;
>>   	}
>>   
>> +	if (lp->axienet_config->probe_init)
>> +		lp->axienet_config->probe_init(lp);
>> +
>>   	if (!of_property_present(pdev->dev.of_node, "dmas")) {
>> +		/* Non-dmaengine mode is only supported by some MACs */
>> +		if (!lp->axienet_config->non_dmaengine) {
>> +			dev_err(&pdev->dev,
>> +				"Non-dmaengine mode not supported by this MAC, use dmaengine\n");
>> +			return -EINVAL;
>> +		}
>> +
> 
> [Severity: Low]
> This isn't a bug, but some of the new capability flags only take effect
> on the dmaengine paths:
> 
> - sw_padding and tx_csum are checked in axienet_start_xmit_dmaengine()
>    but not in axienet_start_xmit().
> - mac_irq is checked in the dmaengine probe branch but not in this
>    non-dmaengine branch.
> 
> Because of this gate, only axienet_1g_config reaches those paths today,
> and its flags match what the legacy code does unconditionally. A future
> config with non_dmaengine set and different flags would quietly get the
> 1G behaviour.
> 
>>   		/* Find the DMA node, map the DMA registers, and decode the DMA IRQs */
>>   		np = of_parse_phandle(pdev->dev.of_node, "axistream-connected", 0);
>>   
> 

As mentioned in cover-letter, XXV supports dmaengine flow only.

> [Severity: Medium]
> This is a pre-existing issue and not introduced by this patch. The
> interrupt order in Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml
> doesn't seem to match what this branch reads when the DMA resources are
> on the Ethernet node.
> 
> The binding lists Ethernet core, Tx DMA, Rx DMA. The driver does:
> 
> 			lp->rx_irq = platform_get_irq(pdev, 1);
> 			lp->tx_irq = platform_get_irq(pdev, 0);
> 			lp->eth_irq = platform_get_irq_optional(pdev, 2);
> 
> Would a device tree written to match the binding text end up with its
> IRQs misrouted?

This is a pre-existing issue and can be addressed in separate series.
> 
> [ ... ]
> 
>> @@ -3109,23 +3256,21 @@ static int axienet_probe(struct platform_device *pdev)
>>   			goto cleanup_mdio;
>>   		}
>>   		of_node_put(np);
>> -		lp->pcs.ops = &axienet_pcs_ops;
>> +		lp->pcs.ops = lp->axienet_config->pcs_ops;
>> +		lp->pcs.poll = true;
>> +	}
>> +
>> +	if (lp->axienet_config->internal_pcs) {
>> +		lp->pcs.ops = lp->axienet_config->pcs_ops;
>>   		lp->pcs.poll = true;
>>   	}
> 
> [Severity: Low]
> This isn't a bug, but a few kernel-doc entries for struct axienet_config
> don't quite match how the members are used:
> 
> - @pcs_ops is documented as "or NULL if unused", but it is assigned to
>    lp->pcs.ops here without a NULL check. Every config in the series sets
>    it, so nothing breaks today.
> - @stats_update is NULL-checked in axienet_refresh_stats() but isn't
>    documented as optional.
> - @internal_pcs says "MAC always drives an internal PCS", but
>    axienet_mac_select_pcs() picks the PCS by interface mode only. By the
>    end of the series it also handles 10GBASER and 25GBASER, which covers
>    XXV.
> 

Will fix the kernel-doc to match usage in v5
> [ ... ]
> 
>> @@ -3168,7 +3313,8 @@ static void axienet_remove(struct platform_device *pdev)
>>   	if (lp->pcs_phy)
>>   		put_device(&lp->pcs_phy->dev);
>>   
>> -	axienet_mdio_teardown(lp);
>> +	if (lp->mii_bus)
>> +		axienet_mdio_teardown(lp);
>>   }
> 
> [Severity: Medium]
> The commit message says:
> 
>    No functional change intended for the existing 1G path.
> 
> This hunk does change 1G remove behaviour, though. Before the patch, a
> failed axienet_mdio_setup() left lp->mii_bus NULL:
> 
> drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c:axienet_mdio_setup() {
>      ...
> unregister:
> 	of_node_put(mdio_node);
> 	mdiobus_free(bus);
> 	lp->mii_bus = NULL;
> 	return ret;
> }
> 
> axienet_probe() only warns and carries on. A 1G device using a
> fixed-link, or a PHY on another bus, could therefore probe without an
> MDIO bus. Unbinding it then went through:
> 
> axienet_remove()->axienet_mdio_teardown()->mdiobus_unregister(NULL)
> 
> and mdiobus_unregister() dereferences bus->state.
> 
> So the new check fixes a NULL pointer dereference. Could it be split out
> as a separate fix for net with a Fixes: tag, so it can reach stable, and
> the commit message here updated?
> 

Agreed, this is not a no-op. I'll pull this hunk out into a standalone 
[PATCH net] with a Fixes: tag so stable can pick it up, and keep this 
patch a genuine no-functional-change refactor.

Thanks for the thorough review.
pw-bot: cr
Suraj



