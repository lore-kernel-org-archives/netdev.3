Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11020135.outbound.protection.outlook.com [40.93.198.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36E641DE19
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 16:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784133359; cv=fail; b=Viba2dbNAv4u3x5qr9vqAZt7f9dyJKqQ3Pc24VZw/VifToApluH1a90xctRBwXt0M1fhRkmWenf/EUVMwCA/W7h3tdcICMh119P6Qp7TIF+vdD5dBbkN1/qs/evyT+4mfzI3oNlKJQvd39HgSB5uucVMUDhyzkCSoEwycR+/RFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784133359; c=relaxed/simple;
	bh=aPdwZeJeKfYgJNukYs0X/5O0H5L9qovvUFvZZLUNEOQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=C4UyXKKOsXTG3hWeyRx2J79i9cnbqJlPNbUFEdfLZIzv0tqVfdKI1+pRiyX74/dshXiDlU3952d3uZ1IRPNBJmDUnhlGbr7Qtvh30VRgLrZp5wPpv/Hr0UT5HJdehdPi/m7X8nibsbkmnyerXfjgr5Kp2JGBNgoAgoZzCCZue6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pa.msu.edu; spf=pass smtp.mailfrom=msu.edu; dkim=pass (2048-bit key) header.d=pa.msu.edu header.i=@pa.msu.edu header.b=Mrb3TIEF; arc=fail smtp.client-ip=40.93.198.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pa.msu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=msu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pa.msu.edu header.i=@pa.msu.edu header.b="Mrb3TIEF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oweeSF2yaUIVYsLUXb6QK6WBx6sJCCTHAdKTez+A8hx3eqLJIs0PmnFeb8VRRLSgmeG07dbbDFBnFKktcBpoTQDpFtBUO1u99obefSQMyVK6XMl9eLs/h123fxWamQbCT1KJmiQzX+lHNbaJg5PDmKTM3KNL5ztvWWi7Ob0NgN+67hxfynUe+pxLE+LRqwgLjIeGD2XyyRpdoQF0IhAUo69sBj8WKmewmqlxNS6xUmVLVDOcdDOHxXCvWHGqUdLCeWnmFLOizXD7pE5vllW7Lj7hJoiW65VqUbLnlCEb6y9Y1dLrd+gq4RpbxEwC1NYeUfbwwvGTXbaP2bwkMLJO8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3IwB11lPKGDd2qz61R/pYSXYZeTLnLZ/g7+I9np6Snw=;
 b=Vaucr5nYO/dXj+G2sC+5tmWNIwIZM0omCBIZUhxhjaF4btqD+AkSnrGAer1DPtBISj9ad9OcOl9v6N8Y0Qdl/xD5lHredFpxqYPRSTKniAKOACRs/gmJnjRND0ZNFk/mymhx1DAuSJ43uV/0ANgg/3QBK4OeUeNvpgXBwFFl2qPTy7aknctDBGlAK7Y5Iiq0aRtTuKiUM9bSIc/kZ/Z63MFfH4HtWkutjThC0F44JK+l5ucySjZKNLzDCKQmPf6Z2hTc5PyeLhRrFzR5Tp8dx73izjpmk3Z691H9VCKcdMCD0BZ8Z/9vu4g0UWQvffd87QltFYwUJvh9t8LVf4ZpLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=msu.edu; dmarc=pass action=none header.from=pa.msu.edu;
 dkim=pass header.d=pa.msu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pa.msu.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3IwB11lPKGDd2qz61R/pYSXYZeTLnLZ/g7+I9np6Snw=;
 b=Mrb3TIEFOCRV2Tv6NbRSpR+QUbKwISAjbvCRE7rb7MZPT5H5RjNwHvJItnajG+wBc3OzKXOuR2dMiBMfg3hdVqGWobm0apJ0bmRX2BSpA530CaQG95KQwDSzBQFFajGAfAWDUbHASN2M5IHzFGuTSU/Lk6xCsTtCaG/tFJ6/iMcB53kWuTs0s/cieguwyGFLejgeV/9Sqn753TWGdvbi4ydeY1nOZb/0KilDiHfPNcMuyDtvvp4G8oKbR2iz/RDjhk24AL2BU6R2rOZCZGbs69QgF0xhmveuqvMphR2Pv/lqCO2BFaVYkAdOTYHymHWIxUTfcIM/49IbclJAX8OrlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=pa.msu.edu;
Received: from DM6PR12MB4337.namprd12.prod.outlook.com (2603:10b6:5:2a9::12)
 by BL1PR12MB5876.namprd12.prod.outlook.com (2603:10b6:208:398::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Wed, 15 Jul
 2026 16:35:50 +0000
Received: from DM6PR12MB4337.namprd12.prod.outlook.com
 ([fe80::b412:1b80:dfc:18c5]) by DM6PR12MB4337.namprd12.prod.outlook.com
 ([fe80::b412:1b80:dfc:18c5%6]) with mapi id 15.21.0181.012; Wed, 15 Jul 2026
 16:35:49 +0000
Message-ID: <ab0883e3-fc15-41f7-a851-07bc4697aa42@pa.msu.edu>
Date: Wed, 15 Jul 2026 12:35:48 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: macb: add support for 1000BASE-X
 autonegotiation to PCS
To: Charles Perry <charles.perry@microchip.com>
Cc: netdev@vger.kernel.org
References: <20260714200904.70428-1-nwhitehorn@pa.msu.edu>
 <ale1VbrKF/ls5Zt4@bby-cbu-swbuild03.eng.microchip.com>
Content-Language: en-US
From: Nathan Whitehorn <nwhitehorn@pa.msu.edu>
In-Reply-To: <ale1VbrKF/ls5Zt4@bby-cbu-swbuild03.eng.microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P223CA0025.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:116::23) To DM6PR12MB4337.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4337:EE_|BL1PR12MB5876:EE_
X-MS-Office365-Filtering-Correlation-Id: 6138a222-e279-452a-8b2b-08dee28f2126
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|786006|376014|10070799003|23010399003|4143699003|11063799006|10067099003|6133799003|18002099003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	TpngzBwU6ujrdlR0GMlD4HxXBVQFPP+2RAXKy1WHv9GvknSRnJ8y/ikIKHS+mV56Rwk5E7tg3B8ZsgWx49opD85mW4UCo8wkxFQEydr0EJobhYh6gJkIbyMUMtIcBpM1gcTifrv4Ttq2WdfHfHX9XgitQILAUJU15NSDz3D+gqk3mSdyUunePJcgvUHFqzLjEqvSgAGqXGS+6Lg3chvXUYU8o1EwXMKU1MH6bdwLEsjgr2qbcTyyCXGVthxGkjB5Op0Vzorsj2uvBXM3n6DxMVrezlhHRU21eBn+9xN/lEq7fQKTAa5zRgbYAzc7dwCXZVVfU3n9D6Z6bxPiGFY4uBMcNRcSM4Brw1Vzu81NZpySO22jiYq5rp0oAobm/wUrqkFiV7h36XBV4V7wJyt7YBX/d990zLBoUrONxUf26tQzyPaOd32CuScbMunwKeLt6Wx8TxkZPDm6dcGNdGyjuDLB0UlxbF0lfx313cK68XN5E7dRiwZHzn8K8nQB4z2hIucrZzqXjq1dI4tplALAYitxhv4UnYI2sgWJlNszgDAF/UI3rwtpPsBZiuO0Ez3eNQyhcJ9MpFzP6rGO+boW5W5oGTyg1ml8GPR1d+8TYDb/NrGflAJewNFrce/KnZza4RiF4jLSetmjL4fcYp2iH37Y08TdJYfFFrUm/IrFkLk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4337.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(786006)(376014)(10070799003)(23010399003)(4143699003)(11063799006)(10067099003)(6133799003)(18002099003)(56012099006)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MWtHYXpYbkdISHdmWjJIL2x0UWtldE1rdkxnNTR4SlpOenc3Z0ZCNGNqb0Jj?=
 =?utf-8?B?N3NyME5tZDBXQzZYNWFFZ2JMRThrd1FHQktlUnMyd05vRk41a1RtQUJCY24r?=
 =?utf-8?B?a1VYY2pZTGtQWmI2TVVQRWxLbXdrV01hb2RUb0VCMC9IWXlUYnJDeGVsQ2k2?=
 =?utf-8?B?bHg0VTZLVnBWWGg2NmovOTA2aWcyWXFYU0VzQjMvV2hkandlYytERW5OSUNL?=
 =?utf-8?B?TGhYcGthS2YyVE1JK3FPa3lDWmY2MDhtTWNuYkJwN1VYRkJReEVocVBaQm1M?=
 =?utf-8?B?RnN4SFRadENtV0t5WlRpRjM4UmV1MFFjVlVtSkdtajZ0cGU3d05jakVmbm9k?=
 =?utf-8?B?SnR4SjFac01Xb2xWMEJOUW4zZStSQzhIMkpKeW4zZmd0SkxEcEVNWTBtcGFB?=
 =?utf-8?B?Q2tQVTBpUmxYR3BIVFZ0NXZWNWdDeTR6NW41cmIxQkpRb2dXRG1UUFZLaGlW?=
 =?utf-8?B?R2IyQXBmL2JyY3NxZ0d3dk1SYkhqN3h3TjZTRGVHdzMxNHZvRjMrK2xlUlh4?=
 =?utf-8?B?N2l5aVNOSDVvZm9jYUpOd3V1dUpnN3g5d3VDMGI5c3R1dkR3aWQxUWwyY08x?=
 =?utf-8?B?U2RLemJYSzJoanc2a0c3VkJKMzc1Ulp5VmVvQTNxS3U4ejRNUHdHY2FOV3ND?=
 =?utf-8?B?OGkxU3Q3c2VndnVvUjRtNGU1M0N4UHBLS2ZpSGhyMkwra1lrZGZjU2RySjBE?=
 =?utf-8?B?VFplazJtZkt4NFNWSTJKUE9oTjJoc3JUZ1A5VytmcnF5OU9ZVEE0bHFCcWov?=
 =?utf-8?B?MW5iRThSU3pCUCs1c2F0cUNsMHprb3lGOFJzOHc0VzNvbld0ZkZUSVMwSEUx?=
 =?utf-8?B?QlZLelBEandVUTZINkZHQ3lGV2h4K1N6Y2NCdVZPS2w1SkNRQUxhVm91cGcv?=
 =?utf-8?B?cTM1YldUcnhJOERXK1VaUzNKeVI3cENFV0t4dHFwUnpnZHlZZElsQnlHT05E?=
 =?utf-8?B?eFFVSG0vQ1lBb1J4UHpSODk0c2g2bUJlV1Ayd2UwR1Y3OTJVU2E3NjA4WURq?=
 =?utf-8?B?V0wyNXdNeGpEVEM4d0EraVRuMmx4SDh2ZndCaHg0dzBjOGszTU9rSXczb3Fw?=
 =?utf-8?B?bzdrWjY5cExseXIvelVSWVJhR1FrUUpqSEc5cEdmZU5EVW12YklxL3ljU3BB?=
 =?utf-8?B?TEhIZlV1S3hPeDJKdy9GZldnSE1wSHJNOCtJRDNiRCtXL3ZDWlMzc0puREF6?=
 =?utf-8?B?NDBjQzBKWS9oc1BQWk8yczZ0RitUaGZaOStQcDh3UUl6RjhRdmxhRDQxakcv?=
 =?utf-8?B?eDNUS2UvbzAzWUdxZ0NxOGJ0U0hDdVBrSzZHNkhUeVVlTVd1a2xIMjJKc202?=
 =?utf-8?B?ODNOMHhnRHUzUjBrYTN0Wk00MWxYSUR3emx1aGRnTXFnTWsrcWh3Nkh2bVl0?=
 =?utf-8?B?bmlDempKeVEwWHRST0pvUW8xc3k0OWJramtLK0N6VWhBQ0t5YUNHYUNKcnJk?=
 =?utf-8?B?Z2l2VkJyVXp6VDRBbjcwanJrVlNLRko1WkZnS1ZjRFpZS1prV2RzYTEyWG1w?=
 =?utf-8?B?T3R6V1dmWEtCamdFbUY0RWJmcEJ1VHFoaGJTL0JsNHM1MnVEVldTZytkYlJi?=
 =?utf-8?B?dFF0M1RtWGRUY1hpZnJzVm54NHV5QzdXalhaeEpCcm0rUEdTRCt4UW1zRm9Z?=
 =?utf-8?B?dDF0dlNhWTNqb2NRMkJlQ05XbkN1TzgxLzAzMkxyQVFSS0VUUzVTMlptR0RE?=
 =?utf-8?B?eS9DR2FHWmd6WU15aSsxMkNOVVZ5cVhKbWIzRndzb3A4QkFrMUIvdjRsNnp1?=
 =?utf-8?B?amhRNkdOVGtwTVNCSkd6MC9uN1Q3UVovMkNGUlRMZE1nMGlteTc5cFJnY2wv?=
 =?utf-8?B?YndmN1VoWkhPZndoUm1laG85ZkYrREl1c1liOHUyTkpBYlI3enFURHBzTGsz?=
 =?utf-8?B?WHA4QUIwemZUSmI3TkdqSzBaQ2VpblcxTm1iVkdNODBHVjJOYzR1bDlOT2hy?=
 =?utf-8?B?TGl6cStTd2dHYkZjV1Vtb2ZjMFBXRXFRcFRjRFQxbkFrUHQ2K0pLbkhoRmtX?=
 =?utf-8?B?Z2VHY3c1Um9XS1B5cW4wZ3RBWWZqNTJLeG52THFWeGdzT2VCWkcyR0xtWHV0?=
 =?utf-8?B?R0Q5L3k2MmRMUkVuYng5bVlwRGhHWnBYNXBKZVZDRkpLK1liVWdldnBDdkdC?=
 =?utf-8?B?TGtKdk5qMDliQWkwMUZ5ZWtJcFpMc1J2SlRSVmRnclJNeHd6TngvaHJhTGha?=
 =?utf-8?B?Q1JET3kxVHVlbXl5RzNNOVBiZEt2WlpGNGs2cVoyekZ6N3hOeW9lNFFweFBC?=
 =?utf-8?B?YnJ4YkVVTFpZUEJHTDdJMnRMaTJIWGNxYVByYyt5cmhOTkovbjgva1p6amUy?=
 =?utf-8?B?Mk4rcnZNd0lwS05qZ0VzbTM5ZjRWajVFa2VFZDRvSGN0ay9RVW50Zz09?=
X-OriginatorOrg: pa.msu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 6138a222-e279-452a-8b2b-08dee28f2126
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 16:35:49.8965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22177130-642f-41d9-9211-74237ad5687d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ykdGPoeC74hBmX1j59HU2u5I0lTXVh4sHEo3Bvb/HolPBLRlb3+S48PcFz9/FSL9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5876



On 7/15/26 12:29, Charles Perry wrote:
> On Tue, Jul 14, 2026 at 04:09:04PM -0400, Nathan Whitehorn wrote:
>> The current PCS code unconditionally uses SGMII autonegotiation, though
>> the hardware supports both SGMII and 1000BASE-X modes. Decouple the
>> choice of PCS enablement from use of the SGMII mode when running at
>> gigabit rates and announce to phylink that 1000BASE-X is a supported
>> operating mode. This enables direct attachment of the PCS to e.g. an
>> SFP.
>>
>> Tested and developed on Microchip Polarfire SoC hardware.
>>
>> Signed-off-by: Nathan Whitehorn <nwhitehorn@pa.msu.edu>
>> ---
>>   drivers/net/ethernet/cadence/macb_main.c | 31 ++++++++++++++++++------
>>   1 file changed, 24 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
>> index d394f1f43b68..284a3b03f8c7 100644
>> --- a/drivers/net/ethernet/cadence/macb_main.c
>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>> @@ -583,7 +583,13 @@ static void macb_pcs_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
>>   
>>   static void macb_pcs_an_restart(struct phylink_pcs *pcs)
>>   {
>> -	/* Not supported */
>> +	struct macb *bp = container_of(pcs, struct macb, phylink_sgmii_pcs);
>> +	u32 old, new;
>> +
>> +	old = gem_readl(bp, PCSCNTRL);
>> +	new = old | BMCR_ANRESTART;
>> +	if (old != new)
>> +		gem_writel(bp, PCSCNTRL, new);
> This bit is self-clearing so I don't think the old != new check is
> required.

Ah, OK, good to know.

> Also, can you comment on why AN restart is needed for this patch? Is it a
> requirement for 1000base-x of is it because we now have sgmii and
> 1000base-x?

Our equipment works well enough without this, and it is just here for 
completeness rather than an actual need. I am happy to drop it from the 
patch if you prefer.

>
>>   }
>>   
>>   static int macb_pcs_config(struct phylink_pcs *pcs,
>> @@ -750,7 +756,9 @@ static void macb_mac_config(struct phylink_config *config, unsigned int mode,
>>   		ctrl &= ~(GEM_BIT(SGMIIEN) | GEM_BIT(PCSSEL));
>>   		ncr &= ~GEM_BIT(ENABLE_HS_MAC);
>>   
>> -		if (state->interface == PHY_INTERFACE_MODE_SGMII) {
>> +		if (state->interface == PHY_INTERFACE_MODE_1000BASEX) {
>> +			ctrl |= GEM_BIT(PCSSEL);
>> +		} else if (state->interface == PHY_INTERFACE_MODE_SGMII) {
>>   			ctrl |= GEM_BIT(SGMIIEN) | GEM_BIT(PCSSEL);
>>   		} else if (state->interface == PHY_INTERFACE_MODE_10GBASER) {
>>   			ctrl |= GEM_BIT(PCSSEL);
>> @@ -957,7 +965,8 @@ static struct phylink_pcs *macb_mac_select_pcs(struct phylink_config *config,
>>   
>>   	if (interface == PHY_INTERFACE_MODE_10GBASER)
>>   		return &bp->phylink_usx_pcs;
>> -	else if (interface == PHY_INTERFACE_MODE_SGMII)
>> +	else if (interface == PHY_INTERFACE_MODE_1000BASEX ||
>> +	         interface == PHY_INTERFACE_MODE_SGMII)
>>   		return &bp->phylink_sgmii_pcs;
>>   	else
>>   		return NULL;
>> @@ -1025,13 +1034,15 @@ static int macb_mii_probe(struct net_device *dev)
>>   	struct macb *bp = netdev_priv(dev);
>>   
>>   	bp->phylink_sgmii_pcs.ops = &macb_phylink_pcs_ops;
>> +	bp->phylink_sgmii_pcs.poll = true;
> Why is this needed for 1000base-x?

Without this, the hardware does not detect link state changes after 
initialization. I am assuming that in the normal SGMII use-case with an 
external onboard PHY etc., those state changes either don't have or are 
signaled by monitoring the PHY, so that support for this wasn't needed. 
With removable modules, fiber, etc., state changes are suddenly both 
possible and otherwise unsignaled. It is possible -- likely, actually -- 
that there is some better way to do this by properly monitoring an 
interrupt somewhere, but I am working without documentation so am not 
sure how to implement that and was trying to keep the patch short. 
Polling worked well enough as an alternative.

Thank you for looking through this!
-Nathan

>
> Thanks,
> Charles

-- 
Nathan Whitehorn (he/him)
Associate Professor
Department of Physics and Astronomy
Michigan State University
Biomedical and Physical Sciences 3225
East Lansing, MI 48824
(517) 884-5563


