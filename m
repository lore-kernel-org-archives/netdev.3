Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020106.outbound.protection.outlook.com [52.101.85.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0832FFF8B
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 02:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786503498; cv=fail; b=iiZCbUPrw4PaG7j//MHWkbxEhanKVIn0mWy6rnKkGdH50XRqmzw5n6w4KT+n4xDamuxbWKL1Gqy3saMCkGK7aECDJuHqSLjLwNdl7OzUQdTY7zO3FQdsrdo0rxlxKWpPeVFfIuEsDQcfHvr2gSwDMsAeXqiKbN02IlDcAMzV8Q8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786503498; c=relaxed/simple;
	bh=5GSpoNVsF1YHYiczFGAYuTDqxgQjirYkZOr+nHFuXmE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SKmT9EWa/oBbcfK5gIv3JWYHURNViRFJ7Zt16xXavA7r4YMz6H/c+Oi9CLP+BZ21MECIWUTGHqJ5WYbIsOq0bZ8RlvvKQqCXw3t3r/RBeV7lkAYAfpxS0xPieoaAV9h2+75BohxfxSAaHqPTMU4FJwHBL7AN9nqMgq7O4PsqzV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pa.msu.edu; spf=pass smtp.mailfrom=msu.edu; dkim=pass (2048-bit key) header.d=pa.msu.edu header.i=@pa.msu.edu header.b=YuNi946V; arc=fail smtp.client-ip=52.101.85.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pa.msu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=msu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pa.msu.edu header.i=@pa.msu.edu header.b="YuNi946V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aGsfCVfeCKx3r6OJ1lkFQeMQFFGcCF0vXFC23QuxZ4t8aeLDIXqlkhTJ2lD3G8/K5uJ4DMk9BtS/Xa9wYeDJ5cD32ieoGSRD+5cn4NVHzINqUtCdgJT0nR+f66RoioQ5b5htGO0YacNuAuge8anQ8nKcJXw95LU8RSo0DhWjvZPy1a1LBvMvy7qPwTVHDaqatqvR8xnoxQr+KBNw+Qej+ntfJgh9VFSH3kMHUMzX0w5N5ZH3FmLE05UahTueFYVq+9VyA2QGcYmR0dDoSnI0wlRTUzFY9L2y57V5Xgd5Mh85NMUPuJqOV3shBUi4EHAgPfHKIYPwrhwbzy8m2oWDGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fyeAV7rwGSREdhDENm/8ejx1G1g9kdHBLZ4neeDymwI=;
 b=SprIW2RTPUqNb/fFjknb8HH78hYnuhyqMI5o3l63TSwk3nvrzpRgFVdyyjc9SAs1GIudBqFnLAU8tHKpVdRf/YvuTozrGeonjNYbLb3Ondl3bNxoSWF+i5tWJvsQrB2JAXyB5ltsn8B+RoUCI5gLbLBgpeHd6FK+Q8+cekv1WNw5jlIChxLb7H982mBB1ea/PgaCfzoOhghK7Me0K8ugNJD+HXUghYHGG+K5cZZ1K4P7bGGa1g8GtHYW+YScXjet05JsdpM6kejZIcGVQbTOJ4DqAJIDkSfZEbY8m4v/McURqHteO2/ajuxp+jdqiqDPgZXCk1snRoRhhhe++CeunA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=msu.edu; dmarc=pass action=none header.from=pa.msu.edu;
 dkim=pass header.d=pa.msu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pa.msu.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fyeAV7rwGSREdhDENm/8ejx1G1g9kdHBLZ4neeDymwI=;
 b=YuNi946VyKJ7Hzm3sNS9+odiIjW8pv3iWNJlFGnBwPWOjr2ypP/qRIz4FHCXn62CkjEUQo2wZPKQRQEshfSqSvqyYokXvZJL40j/4zJGOSyeH1IuUF2HUHeqtH8XXMZBxjt0/+zhoI4yVMGTNTd/jzygTg5xwa3ObpYmG7mdtdvizUKOCBm3qzk0ffE1UD+KIVKMqcCq+g/vz0I9dhXBllvcDhX0rgHCPjQk3aWLIfqAyzIjOiXvgbetfp/4CGgISbAOI4GTF5WYhOoxTLQuYWxJPf/CXbPNeIqe/P7t+ve+t/7Cd9ZIkZF/0iTtt24h214PFZvyD9nOmvLjgyO6BA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=pa.msu.edu;
Received: from SA0PR12MB4352.namprd12.prod.outlook.com (2603:10b6:806:9c::9)
 by SN7PR12MB6863.namprd12.prod.outlook.com (2603:10b6:806:264::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Wed, 12 Aug
 2026 02:58:12 +0000
Received: from SA0PR12MB4352.namprd12.prod.outlook.com
 ([fe80::3b33:a490:b19e:defe]) by SA0PR12MB4352.namprd12.prod.outlook.com
 ([fe80::3b33:a490:b19e:defe%6]) with mapi id 15.21.0292.024; Wed, 12 Aug 2026
 02:58:12 +0000
Message-ID: <e1b3d844-6d73-4ccd-b604-dc11dcbced4d@pa.msu.edu>
Date: Tue, 11 Aug 2026 22:58:10 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 2/2] net: macb: add support for 1000BASE-X
 autonegotiation to PCS
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, theo.lebrun@bootlin.com,
 conor.dooley@microchip.com, charles.perry@microchip.com, andrew@lunn.ch
References: <20260807201741.3275-3-nwhitehorn@pa.msu.edu>
 <20260812015434.1687294-1-kuba@kernel.org>
Content-Language: en-US
From: Nathan Whitehorn <nwhitehorn@pa.msu.edu>
Autocrypt: addr=nwhitehorn@pa.msu.edu; keydata=
 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
In-Reply-To: <20260812015434.1687294-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0360.namprd03.prod.outlook.com
 (2603:10b6:610:11a::11) To SA0PR12MB4352.namprd12.prod.outlook.com
 (2603:10b6:806:9c::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4352:EE_|SN7PR12MB6863:EE_
X-MS-Office365-Filtering-Correlation-Id: 77f2d238-c01e-4129-37e1-08def81d8bde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|786006|10070799003|23010399003|366016|1800799024|6133799003|4143699003|10067099003|5023799004|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	rVS6dDoGgWFuuWCQiKaDG8CQcLmdBewcgl3hiPOpfXd72TqPD5yl/7nttwZ7TMliKV7KIM5BVgE1rwa+tynHgfxXs9USvOj71UydpINaqJmLFEOcvCWq0/cr3ROuJbSe307LtJaQ+i3xZ767VUDQdpFOtlN1meFYbMhX6dtacaqq6M+Xt2D5s5Kv66MuCw2Ahj67zkJs6j5DTZUv8jpJ03WJJvFLTbICM2LZU56fngMjg+0cmFx56KkW5wXDFEPVcKDRK+kqO1I1mcX/TvaEG6FkPGpacm6elX+jsX7z5UJdBfTJiQbZhE1hePoyH6S2AWM6SsAyoxjPYC1hNZKHMRSgAuOLwA7su+AQ7O2eHrVRbN5axcEoW48GSf67C4pQzll8k1CMLnaG05lim4h1wcUJCFyLvDVczsb3BTYZywRtP7sY2C9jlJUiYfEpSrF5He1CsC3vGSFIp3fDaa6IlUJ2WVLJxubkh+X6IUAL9gFURTic6pnoNun8m2qN3yaYBLpdltZbSimxuVCal+n5M8J3d86VLHKblMaNqbPhPy4wbSMUM2sMGPsWCzefy1Et010sdiQ+471T9HLRgY5Og3NvSpqTMc2t2iSQS3r1YYyBFoAr2eG7VBejp7p6JwHQFNVWa+aWwD3YCdoz0S3sbSm8InhVc1xvX+GPiZNaEe0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4352.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(786006)(10070799003)(23010399003)(366016)(1800799024)(6133799003)(4143699003)(10067099003)(5023799004)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dCtac3dZT2I2anlaTG9uWUdsR3RsVmVjN2JwOVh2MS9COVhqVVFuSE9uY1ZC?=
 =?utf-8?B?UzU3dGtTcWZvN1R3T3d1aGJwQ0JnSFVXVmQrc1pCY3FLVnJtVWlMU05DK1Ji?=
 =?utf-8?B?ZHNLb1REMDNXMkpjTkk1SVNzTjA0OEtWbWdRSk9yYldVandxYnpvZURQbGw1?=
 =?utf-8?B?UzR0SDNhUFRGdjJtZnBwRFJ3Yi9hZzZ0Z0ZrY21iNUxXazdWZ2Z2blRzMlZS?=
 =?utf-8?B?Y2xXQWFKUmFtSkQzcmdVMUJmd0Vxb2tjVkZHenpsNHBFaDZ2SVIzaVRCS2t1?=
 =?utf-8?B?RTAvVDlkdXlFb21jR3pFYnFRSUlhU0pnUjVyNEZTd3o5YlRlOWNHQVY4ZlZN?=
 =?utf-8?B?Mm1ibk5GazN1UWZxQUpIandVTWIxTng0MkNWN1EzT01Qa1VYUDJ4V054Wkpu?=
 =?utf-8?B?ZkovRWNiZXE3RFVHS012V2t4eis4cElib3FWT0dROFg2bGtFOS9mV2Z3eUdL?=
 =?utf-8?B?cUllUWNDNnY5YTQwQ2lFa1JLRkZhVlExODFKaFpVeGV3NlpFNUVwUDY4VGVw?=
 =?utf-8?B?YWlDTWdZMWtVamVxTnh4a3ZvNmpTZy96N3gzbUtuTkRYb3hkVHdPcXk1TUdG?=
 =?utf-8?B?ei95YXR6ZG5Nd0dld3g1QUh1VzZKYTFKcmpJSk1RaWJLQUthRTB6Ync2YWk3?=
 =?utf-8?B?N2RYanpzRURZUnZyZDlFMDZwVlFwWGIzU01OaXI2YjRiaGRNajdEQVdFT0da?=
 =?utf-8?B?blBHb01wdHFrQ0JJWVJJSkRQeTJaRUVlMGRTUGE3MTI1RkNiWDJKc3oxQVZB?=
 =?utf-8?B?cGtmNFNBSnplRXkySTZ1c0E2UXN0ai9Sd0RVY3A2NHFaNkpyNGtqL1dTRW1K?=
 =?utf-8?B?c3Z1ajQwM2hVVGowZzN5MlhDbHF6SHI5aGEzS3JrNVBBSUlGZTBLdmdtRXJo?=
 =?utf-8?B?Q0EwNUR0bGNMTHVFYWVISys3TXBYb3NPOFpaN2JhVi9KOG5FYmFDZVkwREIv?=
 =?utf-8?B?NWVhL2hJUDVUUk1FWXNSb0J5R0sreXpoWXIwQysydjlIUXdDRXg4Q05NNXlH?=
 =?utf-8?B?NlZYa284OWlrMTVHMlBpd3VKZlhJV0VUU1p3VFNOQTRRdE1RaEw4cFhYaFR6?=
 =?utf-8?B?Q3AxaXFyNWhqNEo1OWI2K3FtNTNPNjFLVWtUOW52dzZwZzVzZGFnU1Q4K2tH?=
 =?utf-8?B?SmJDSHBBb3Q5a1pOeVZId2VFeTRaUGp5R0FBNjZCbXdPTDF4TE16dkcyVEFj?=
 =?utf-8?B?RFlFL1owSUtZd3Nqb3BFb0k2cEJJd2pNT0x2ZnlDMmNDSklzVVBRamY5a0ZZ?=
 =?utf-8?B?cDJqNDlXNE9xZi95eUE2bHBDSURLNzVnZDhxdTgwdHhobndISkV3ZHdMQ2VI?=
 =?utf-8?B?STJueENITkw3c08zMm9qdlJDQXVlQmYxRHg4OVpwdmVDL1pCME1MVFJINzNx?=
 =?utf-8?B?MGhhWEQrSjJmYjNQRDlwbWRtSjVBclRqRktHYVE0U3g4cU0xaXlKcm82ZWR6?=
 =?utf-8?B?SnVFV1ZHWkhPWGRLVDdOMDUvN2w1VFoyaVE3Y1Ztd0hMR3hRVUJkK05yREJr?=
 =?utf-8?B?dkZDbUFRaXFZc1VWMzRhaWRmUGlWeGJPMEVsMDEzREh0bldZZWxIS25hckdP?=
 =?utf-8?B?dHV1V1E2aFV5NXI3TVlqVVdQUTRQU2hQNksyaFFCSVhrbWZoQ293ZC9tWVQz?=
 =?utf-8?B?ZnZzSFIvZ0x3azVOQS91K0VyeGFNU3hUS0h0Y3FuRjhIZVFBQ0d0UGRPL3Rn?=
 =?utf-8?B?VUt3SERWUDZ6b0lPbVVFU202UXhUZitzVExMZFBuRmpHRWpqSFZWVnUzeUtE?=
 =?utf-8?B?MkRrN0dOOVlMbjBPcXZORFRCOGNBZjM1OFR6YnFjV25VMS9rZWNhWkpqV0U3?=
 =?utf-8?B?VTNLRGM3VjlPQzZpRDQ1UlJuNDlsWGhFVWhDSEFNcTJlVFNrdmordFlpSHVY?=
 =?utf-8?B?VzRJa1VHWUVOd285djhUZlVHRjZUTEc2c2Z3TUtJKzN3di9rdzVzU1RSc0VZ?=
 =?utf-8?B?N0ZqR0dLUHp6U1crUkZlT25zQXRVMUE3WU9Ia2dzTEFkbnNoR3FaMnlnY3dY?=
 =?utf-8?B?TDBLeGlLS1VuemRnNzVHTW04RXlDOTRzQWkxNXprbk9RT0NlR3RqYmV0RVVl?=
 =?utf-8?B?WTBRbFVnNHMvT1RTTXg0RmYrdWdBaHRRbXplSmU5cUphUDhUbmJ6dG95ckpE?=
 =?utf-8?B?eWw0a0xrMHNZY0N2MWljM21abDVZMEtHNWlBNXRpQ1JWbUx2SFFzQWUxam1p?=
 =?utf-8?B?dmFKcjUrczN6VmJWRHlkMGVFVDc4L05xUWZjWmh0blRHcy9udWwwbTdqSWN0?=
 =?utf-8?B?aThVdFNzYnhVcEN0T2Z4eFpFWUllZXg0eGZLYUFGdDFTSGpqWjhwWVBGZWpa?=
 =?utf-8?B?cVVlMDVJNk1wTjhsQ0J1M1VlWk51SUZZb1NUNDdiNFNhNko1MEM3b013RVNu?=
 =?utf-8?Q?hnXGwYdtxtrWaMhd0R4DjKY+Kmx6Slwmyhvh/?=
X-OriginatorOrg: pa.msu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 77f2d238-c01e-4129-37e1-08def81d8bde
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4352.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 02:58:12.5394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22177130-642f-41d9-9211-74237ad5687d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rwI11Wj1pfMnNZ61rpizA4rykUSkAl1J51WhIHFX3t/BSX2fbwFK4FhR577IEKAJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6863



On 8/11/26 21:54, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net: macb: add support for 1000BASE-X autonegotiation to PCS
>
> This decouples PCS enablement from SGMII mode selection so the macb PCS
> can also be used in 1000BASE-X mode, advertises 1000BASE-X to phylink,
> and adds an autonegotiation restart implementation for the PCS.
>
> A few questions on the changes below.
>
>> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
>> index c15a9c7e69d3..2252e6a55072 100644
>> --- a/drivers/net/ethernet/cadence/macb_main.c
>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>> @@ -583,7 +583,12 @@ static void macb_pcs_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
>>   
>>   static void macb_pcs_an_restart(struct phylink_pcs *pcs)
>>   {
>> -	/* Not supported */
>> +	struct macb *bp = container_of(pcs, struct macb, phylink_sgmii_pcs);
>> +	u32 old, new;
>> +
>> +	old = gem_readl(bp, PCSCNTRL);
>> +	new = old | BMCR_ANRESTART;
>> +	gem_writel(bp, PCSCNTRL, new);
>>   }
>>   
>>   static int macb_pcs_config(struct phylink_pcs *pcs,
>> @@ -609,8 +614,10 @@ static int macb_pcs_config(struct phylink_pcs *pcs,
>>   		new = old | BMCR_ANENABLE;
>>   	else
>>   		new = old & ~BMCR_ANENABLE;
>> -	if (old != new)
>> +	if (old != new) {
>>   		gem_writel(bp, PCSCNTRL, new);
>> +		return 1;
>> +	}
>>   
>>   	return 0;
>>   }
> [Severity: Medium]
> Is the positive return here attached to the right register write?  The
> kernel-doc for .pcs_config() in include/linux/phylink.h says:
>
>    * When an autonegotiation restart is required for 802.3z modes, .pcs_config()
>    * should return a positive non-zero integer (e.g. 1) to indicate to phylink
>    * to call the pcs_an_restart() method.
>
> and phylink_mii_c22_pcs_config() derives that value from the advertisement
> write, not from the BMCR autonegotiation-enable write:
>
> 	ret = mdiobus_modify_changed(pcs->bus, pcs->addr,
> 				     MII_ADVERTISE, 0xffff, adv);
> 	if (ret < 0)
> 		return ret;
> 	changed = ret;
>
> In macb_pcs_config() the earlier PCSANADV (clause 37 base page) write result
> is discarded:
>
> 	old = gem_readl(bp, PCSANADV);
> 	new = phylink_mii_c22_pcs_encode_advertisement(interface, advertising);
> 	if (new != -EINVAL && old != new)
> 		gem_writel(bp, PCSANADV, new);
>
> and 1 is returned only when the BMCR_ANENABLE bit in PCSCNTRL toggles.
>
> Does that mean an advertisement-only change never restarts autonegotiation?
> On an established in-band 1000BASE-X link, ethtool -A or ethtool -s ...
> advertise ... reaches phylink_change_inband_advert(), whose only trigger for
> the restart is the positive return:
>
> 	ret = phylink_pcs_config(pl->pcs, pl->pcs_neg_mode, &pl->link_config,
> 				 !!(pl->link_config.pause & MLO_PAUSE_AN));
> 	if (ret < 0)
> 		return ret;
>
> 	if (ret > 0)
> 		phylink_pcs_an_restart(pl);
>
> Since PCSAUTONEG is on out of reset and phylink keeps it on for in-band mode
> (default_an_inband is set in macb_mii_probe()), PCSCNTRL is unchanged, 0 is
> returned, and the freshly written base page is never put on the wire until a
> link bounce or a larger reconfiguration.  The newly added
> macb_pcs_an_restart() would then not be reached for the advertisement case
> the ops contract describes, while the case that does return 1 (the
> autonegotiation enable/disable toggle) is not the case a restart is asked
> for.
>
> Would recording a changed flag in the PCSANADV branch and returning that,
> as phylink_mii_c22_pcs_config() does, be more in line with the contract?
>
> Also, could the commit message mention the change of pcs_config() return
> semantics?
>
> [ ... ]

This is a good catch and the patch is indeed wrong; apologies. I will 
resend a corrected one, and also make the suggested change to the commit 
message.

>> @@ -957,7 +966,8 @@ static struct phylink_pcs *macb_mac_select_pcs(struct phylink_config *config,
>>   
>>   	if (interface == PHY_INTERFACE_MODE_10GBASER)
>>   		return &bp->phylink_usx_pcs;
>> -	else if (interface == PHY_INTERFACE_MODE_SGMII)
>> +	else if (interface == PHY_INTERFACE_MODE_1000BASEX ||
>> +	         interface == PHY_INTERFACE_MODE_SGMII)
>                   ^^^^^^^^^
>
> [Severity: Low]
> This isn't a bug, but the continuation line in macb_mac_select_pcs() is
> indented with a tab followed by spaces, which checkpatch.pl flags as "code
> indent should use tabs where possible".

Ah, OK, this can be fixed.

>
>>   		return &bp->phylink_sgmii_pcs;
>>   	else
>>   		return NULL;
> [ ... ]
>
>> @@ -1061,9 +1072,12 @@ static int macb_mii_probe(struct net_device *dev)
>>   			  bp->phylink_config.supported_interfaces);
>>   		phy_interface_set_rgmii(bp->phylink_config.supported_interfaces);
>>   
>> -		if (bp->caps & MACB_CAPS_PCS)
>> +		if (bp->caps & MACB_CAPS_PCS) {
>> +			__set_bit(PHY_INTERFACE_MODE_1000BASEX,
>> +				  bp->phylink_config.supported_interfaces);
>>   			__set_bit(PHY_INTERFACE_MODE_SGMII,
>>   				  bp->phylink_config.supported_interfaces);
>> +		}
>>   
>>   		if (bp->caps & MACB_CAPS_HIGH_SPEED) {
>>   			__set_bit(PHY_INTERFACE_MODE_10GBASER,
>> @@ -4932,7 +4946,9 @@ static int macb_init_dflt(struct platform_device *pdev)
>>   	/* Set MII management clock divider */
>>   	val = macb_mdc_clk_div(bp);
>>   	val |= macb_dbw(bp);
>> -	if (bp->phy_interface == PHY_INTERFACE_MODE_SGMII)
>> +	if (bp->phy_interface == PHY_INTERFACE_MODE_1000BASEX)
>> +		val |= GEM_BIT(PCSSEL);
>> +	else if (bp->phy_interface == PHY_INTERFACE_MODE_SGMII)
>>   		val |= GEM_BIT(SGMIIEN) | GEM_BIT(PCSSEL);
>>   	macb_writel(bp, NCFGR, val);
> [Severity: Medium]
> Does the serdes get brought up when phy-mode is "1000base-x"?
> init_reset_optional() still gates the serdes and ZynqMP GEM power-management
> setup on SGMII only:
>
> 	if (bp->phy_interface == PHY_INTERFACE_MODE_SGMII) {
> 		/* Ensure PHY device used in SGMII mode is ready */
> 		bp->phy = devm_phy_optional_get(&pdev->dev, NULL);
> 		...
> 			ret = zynqmp_pm_set_gem_config(pm_info[1], GEM_CONFIG_SGMII_MODE, 1);
>
> With phy-mode = "1000base-x" on a part with MACB_CAPS_PCS that uses
> init_reset_optional(), bp->phy stays NULL, so the later
> phy_set_mode_ext(bp->phy, ...) and phy_power_on(bp->phy) calls in
> macb_open() are no-ops, while macb_init_dflt() and macb_mac_config() still
> set GEM_BIT(PCSSEL) and macb_mii_probe() advertises 1000BASE-X.  Would that
> leave the interface up with an unconfigured, unpowered serdes and no
> diagnostic?

The equipment we are using this for (custom electronics for a particle 
physics experiment) operates with a phy-mode of "1000base-x" in its 
default device tree, so I can confirm this works fully correctly in that 
mode.

>
> I could not determine from the tree whether the GT serdes and the
> GEM_CONFIG_SGMII_MODE firmware call are strictly required for 1000BASE-X on
> those parts, so this may be fine on the affected hardware.  Should
> init_reset_optional() cover PHY_INTERFACE_MODE_1000BASEX as well, for
> consistency with the four sites updated here?

This particular block, per an earlier discussion 
(https://lore.kernel.org/netdev/DKH9Z0IMH95B.3JWB4PXQC9SN5@bootlin.com/), 
is ZynqMP-specific and onboard-SGMII-PHY specific, so does not apply to 
1000BASE-X mode and I had left it alone here. It certainly could be 
updated for consistency, but that doesn't seem to be needed, either. 
Happy to go either way on this.
-Nathan


-- 
Nathan Whitehorn (he/him)
Associate Professor
Department of Physics and Astronomy
Michigan State University
Biomedical and Physical Sciences 3225
East Lansing, MI 48824
(517) 884-5563


