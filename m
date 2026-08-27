Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11021097.outbound.protection.outlook.com [40.93.194.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8123CAA49
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 21:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787865047; cv=fail; b=UolVGvFC8zYa6WjWBeXm3asENCTAmqonMMF7zhleeyiDhF48lzRXxHvobjC6biE4p6Fd+KhjKnkdxgkGwwtjhYUKJ9YSCvJaZbx3zaLQ4f+/0k8muLqSJumuSwbPdKb/zrRojc4iKEv51K+VOrfvEnHlyWG/X97SqYU3tPAUGkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787865047; c=relaxed/simple;
	bh=Pm/9ZVF7BAfchTcrXjkg1HwIk4deHqf/5ZvxQmzZQa4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rqMsKfwsRNVZeM9FiswoRWjZWyCZiAUtwjDJVIQzqkQPc1lYWSyeiS2rivbh4iRkr7Xt561bA8lEPijOyf36J9GIA+Cj6oRv+rK12fcofUEj4si5BVxatexIVcdU/pT2EuoN3pawgX18vLPR93iMro5z5W0LTanhNLaV7EqJugc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pa.msu.edu; spf=pass smtp.mailfrom=msu.edu; dkim=pass (2048-bit key) header.d=pa.msu.edu header.i=@pa.msu.edu header.b=hgJSyBkM; arc=fail smtp.client-ip=40.93.194.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pa.msu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=msu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pa.msu.edu header.i=@pa.msu.edu header.b="hgJSyBkM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hVe1UX4SeEmYncMzz980Wf8FsSWhL8rLU6+bJkJtEPzIi2Cspo5pHUpiHhnADl+VK9hyV9SczMTyYySWOFt6pU9AtbJ8BqGFC5It7k2nSx9V+lHf/2o8c+sst1j9E8aJ+5cAh5fXA9XAuJWwfibmqOk/YhR19tTgABgrqhNfUMq8YZXOu1bWn1nVxZxVCY00ETiBvOf65gxzTx2vXe5zf7KFEwOWVBqT5B49sPw5bzdKh7GbGFTbnbfwfpY0KvbZiXa7+repjaffvGha0wIyh7jGUC5mTFkQe7KRbq/4zOirZpxySCgy/+hOV40E1+07LjvQlyo0FCzeTBehRa6R0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KeMArLL0HP9j1Upy91bt8TAepaUry3AbwDkA3mXdqBY=;
 b=J3qVbZ4XO3ZAW2ejsjyYZSfShBJP8Ip59z/visihDypPULe8uipvEh5Gix14c9laPjvv59XCv3osZv06QKDqIxWwukb5B7HHpEwyAuUPqGUJYSRMgZWZ7eMP6Rw4gzrd+Vc1XM06kJLwMj49I/SmYCatvqq1NYm//p5nvphiqph5lCiHRAddcqj7WcB+2SqTaeUHdte3kcY2/c24bhif1aYBmt7bzVCVmXhPe4Ffv6iwcv688X8o0Ga/SyL5mDvUnGV6DgS6L+ykqmM6a4+te9sEw+PeVEj1kHuoZxWMVf35X+yX0eeb0JQkdkXxIgjgZm/Qlhl+jEMLWEsMJN3PcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=msu.edu; dmarc=pass action=none header.from=pa.msu.edu;
 dkim=pass header.d=pa.msu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pa.msu.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KeMArLL0HP9j1Upy91bt8TAepaUry3AbwDkA3mXdqBY=;
 b=hgJSyBkMSvrX/bJt5H+MrEMQRlSQ/5c0hEqbnVRIk8FAMkzHvKrBC6DLx90gZaDqjC5afMvGl4F9wYpnIj1h4PGizxk9QXIbP9MTUG92k+xNgfY+VGUPLd3Azx+eM6HTisnHpi2FQ3vT2QAeSILmuN8qLBNHXqN8/6hdIXjBe4ZOTc177thLjZUqNjsCei0aHKVseLbKj4uG0D4hpMig2K7Oag/ROtzJfhSRlQNTffQHGHdG82+fpyp5IOcYPGIG90EuMkqO5ZdXTrec01M2qQTRtmyFuCTnL10eDcuZqXxc/Qtt5LhHfxiNIGiul5MRzTJ2UL0FV+5fWsIa+x3acg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=pa.msu.edu;
Received: from DM6PR12MB4337.namprd12.prod.outlook.com (2603:10b6:5:2a9::12)
 by IA0PPF44635DB8D.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bcc) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 21:10:43 +0000
Received: from DM6PR12MB4337.namprd12.prod.outlook.com
 ([fe80::b412:1b80:dfc:18c5]) by DM6PR12MB4337.namprd12.prod.outlook.com
 ([fe80::b412:1b80:dfc:18c5%6]) with mapi id 15.21.0339.012; Thu, 27 Aug 2026
 21:10:43 +0000
Message-ID: <1746a953-8f62-40f9-aa09-5cf87ed3a196@pa.msu.edu>
Date: Thu, 27 Aug 2026 17:10:42 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 2/2] net: macb: add support for 1000BASE-X
 autonegotiation to PCS
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, theo.lebrun@bootlin.com,
 conor.dooley@microchip.com, charles.perry@microchip.com, andrew@lunn.ch,
 kuba@kernel.org
References: <20260813153705.23407-3-nwhitehorn@pa.msu.edu>
 <20260818131426.191990-1-pabeni@redhat.com>
Content-Language: en-US
From: Nathan Whitehorn <nwhitehorn@pa.msu.edu>
In-Reply-To: <20260818131426.191990-1-pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR07CA0056.namprd07.prod.outlook.com
 (2603:10b6:610:5b::30) To DM6PR12MB4337.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4337:EE_|IA0PPF44635DB8D:EE_
X-MS-Office365-Filtering-Correlation-Id: a5bbf272-591d-47a6-2701-08df047fa7e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|23010399003|366016|786006|376014|10067099003|11063799006|5023799004|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	++RqTqojbaWRGbrypFR1C8zenfW9T4ga4TUMr1nyO0SXzcsdERTzlmdcfypH9VaqPc6NGpuO/aPa4no+CaKzV4MbpDXzEqbh22ACNcbEd/IuXzB46407EvB7UOGH0sUrPE+Huv0fI6vRwmhbptB53TMcZwNfAcvDtk6dCpvSvY3YddkBRCl140Wrw+oYJixoivChnFMvy815j5JjDPQh0w0HQg15LhRxtNJPplwqmp452tHIYsy5RSVOKm/olmvtpaKdcClDUpzWEmYTD0aIZEhgyInVTiBVz+QfpgGWYEyNpgl+p21grH4Ysgj0v/DIEQ2gZp8Wu1hIbCSLr00+KLFxzqct2mRhoHRl7cjFiNwokvgeHYeSHc9OTPASK6bsrSD46UTe6j77qnV4YlzERXudGoNnFTGWSLH8ikODj7LpxccbrqZu8dVbMwqLdbxoJ6pln7rRaMx4slO5m/D/g/41GZEStMtAEXkRRm2gU1yTmUwuLSBTofJ30wjEWFELjgfmeub9SjviRqAxQIJAF1uveZ9TfgKiNReLHkfNJQWeh5DUwKA4t3f6B9Lp6X6w7SMWTOeaiXLS9H7EmmGKKyZQjQX/YfDq2EHeZGahVygrZGz35ydBpZiLjsEPOox1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4337.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(23010399003)(366016)(786006)(376014)(10067099003)(11063799006)(5023799004)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bjlIV1VXUC9pZjJGS2pDaHZxSWxKeGpLSzdMakpvQ0JYWTJvV3FFZ0pVRTB4?=
 =?utf-8?B?S2prQTlTbHJLN2wxWUdNK01uSHd1NkVsNFFHNldYOTZMNjhyK0tNUExndHly?=
 =?utf-8?B?NVhjaC9PamtaN3FyRlAvdXJ0SEdsY1pQUVl1a0xxUU1TRk56amsxSE55ajFN?=
 =?utf-8?B?b0VSYnZRcVhzcmtYZklYYTdVc2FmdTBERmdjbDUzdmplSTFidUlzcWwremZo?=
 =?utf-8?B?bjBJRUQ1OXQ4MGwzTkcvUE9ZeUFhSWNJZU82cmp6blV1RWU0NHozcE0zQkNq?=
 =?utf-8?B?K3hiaU1Meis4UnZoQmxKUmJ6VWRqZkRCTUprSXlPQ0RqL3JmMzFYSWNDSk9G?=
 =?utf-8?B?UkRiMjRHelBoQjM2ZDNLZnpjeWlGcldkZ01BTnJDZmVSYXE5TEhad0prK3A0?=
 =?utf-8?B?d2hwZ0w4cDFqcWJwVGlJVEpIZ1lxQWVQM1RQVVFFK2JBU3NkSFZsM1l1NzZI?=
 =?utf-8?B?NnBVUmdPOWdHbVZ3NWl1OXN5U2xtYnluMkpvNnFxL0RScUJjaFBDWmZ6eDdM?=
 =?utf-8?B?RFV6S1l0ZjB3Y2FBQnZJU29UN1dBOXQxOHNnZitrWDJDdCs3RlpXZ0c2NU1w?=
 =?utf-8?B?OEtsVzZnZ2pmYktST0NGK0Q1R1hHS0lwWU5KM1VYU1NLN1lFY2tGRVZKejl4?=
 =?utf-8?B?bXhYZGU0RFNRR0c5SWhNUjQvYTh0RHE4bVdRRjVzWUVXaHNMczJEeEFDcCth?=
 =?utf-8?B?VHhzUDZIMkl3ZHRlYW9XMXZBY1BtYkJLSE9MWERZU1hORUJ3MDNBcUhWNnY5?=
 =?utf-8?B?aTFOV25XZXdDYkhEREovMEovZDVuSTgrTFpjL3d3QnMzaGtlZzVRa2RJSEdN?=
 =?utf-8?B?Y21mU2ptQVYwMDdkSEpNZ05pS0ZLM2szeHF5ejRYaTJWVHFicWlUeDNERWhu?=
 =?utf-8?B?cTNSZTVaVmhNbk1xZXlDRmZMR1BpanJIYVpJNGNGd01KT091Q3dseHpiTFRr?=
 =?utf-8?B?ZjZtU1gzRVkwT0Z1cnBOcXFTaHVldGQzOUZST2pUc2NXMk9pcFlsV3h1RnlU?=
 =?utf-8?B?TldkWW1FRnd4YUc1NnV5WGpvQjdYdXpmbTl2Nk5JejlPRmJyY2NScm9DRkpo?=
 =?utf-8?B?U2lLL1BIdlRkNW0ra0t4MDM5Y0ZqN3B0SzZwZk5HN1FxVW9qeFBubDR6ZEto?=
 =?utf-8?B?ckg2Y1dTTTZqK0N4dXBTcjdMLzdNalU2bEJvc3gxZ2xqWHJTQlFyY3RmYmY5?=
 =?utf-8?B?THh1Q2VSMk9JRnBQZm4wYVIrNEhScDVRNFZNd0hRTWs3dXJ4TFgzZkxnandj?=
 =?utf-8?B?akVDT0NUL3hlNGxtYkNvMG4wZHpKUjhFL2FaV044TnN4RDZDcEFRci9FWEpE?=
 =?utf-8?B?OWFyeWRtb09wdm5heEYyVDgwWlhOSWhQUEIwdW1ocVErZ0RwQzF3Qk5sN0hE?=
 =?utf-8?B?TXhyeUdTZEh5NXMrZlBsQVozMmNldUU0SFBZdDV4b0xBSWx5QXhOQy9sVGt4?=
 =?utf-8?B?bXdyUTIyc3Fub1FwQWJEcVBuNEdid2JpYWpSM0M3d0RkTnU2cVc1dDFYNVNU?=
 =?utf-8?B?YnlPbm9RekpLVmp6eXJ4VnFVWTJoYUxiNjhFTWtQeUxqWkVCWW1wOWhmOXc2?=
 =?utf-8?B?dEQrUy9sMFpOUE9MVS9aMHV4ZE51UUVVcU5qRmczS2d2VWtRenpmSEZSRm1n?=
 =?utf-8?B?NzJEK3d4QnRPNm1QOC82bmhPQjRXT21TZG5Ua01BVTcrWGVDbDFMcTRQVkZy?=
 =?utf-8?B?TWM2OTRHZHliZUJIV3hyeG05V29Oc2VtRENkVjUraFlaeUQzakMrK3pkRnlw?=
 =?utf-8?B?VEYyT2RTRUR3ZGx1ZnkwMnpDOGhVc08wc0lKT05JNmtMbWc3a0x3UXVha0RQ?=
 =?utf-8?B?dW81bHJHRWlTcUJSQVp1YlJlaWNjMXdJL25wdTN4NUpUWVErckFLWVRlRkdH?=
 =?utf-8?B?NnZZQW1nOWYxUU02Ym80ODJocTFEUm1TenBydTRPdU5ubHRPY1RIMVB2TGs0?=
 =?utf-8?B?ZjhyMVBjUmIrSDRjZ2gzR2VNTXNzVWt3MExvNWlGUWhJZGpkcXU2VnloOG8w?=
 =?utf-8?B?NHU4bHBGb0Q4QSttZWVxYmVWMDBGcHNSN1ZiSTAxZldOT2ZhNXljSFoyL0U3?=
 =?utf-8?B?blhIUTA3bVNYQlZoUUkxaEI2OTlDT09jYXNHbkVab3hUVktrTDFoREtUL3lI?=
 =?utf-8?B?aFJTMmh0OVp6aEF1ZDFzREw0V1hoQnpweitncTUyOGY4NW1RVVlzS3RzTVhp?=
 =?utf-8?B?bTJxamR3M2R4Rzkxa2x5RWNoUS9EWk5nYkxUMkltTnE1N0tqUDN2d1FEcTJu?=
 =?utf-8?B?UTJ1TmxLRGhpZlE4cEt6Rk5tb2Y4czRLNDM1U0hla0lhZm5MendQN2N1WGJo?=
 =?utf-8?B?S1NUMHMwRk42eW93bE9uTzFKL1dacmtPemdhMVVWSjVYYTZBL3oxUT09?=
X-OriginatorOrg: pa.msu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: a5bbf272-591d-47a6-2701-08df047fa7e0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 21:10:43.5137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22177130-642f-41d9-9211-74237ad5687d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V4lY2ZaYsz3rrRny2/K2s8WImiK4n+dng2dXb2N/Al+nrIAver32eBpztGJDMEQW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF44635DB8D



On 8/18/26 09:14, Paolo Abeni wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://netdev-ai.bots.linux.dev/sashiko/
> ---
> net: macb: add support for 1000BASE-X autonegotiation to PCS
>
> This decouples PCS enablement from the SGMII mode selection, advertises
> PHY_INTERFACE_MODE_1000BASEX to phylink when the controller has a PCS, and
> adds an autonegotiation restart implementation plus a return of 1 from
> pcs_config() when the advertisement changed.
>
>> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
>> index c15a9c7e69d37..9097ccb14c13b 100644
>> --- a/drivers/net/ethernet/cadence/macb_main.c
>> +++ b/drivers/net/ethernet/cadence/macb_main.c
> [ ... ]
>
>> @@ -1061,9 +1075,12 @@ static int macb_mii_probe(struct net_device *dev)
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
> [Severity: Medium]
>
> Advertising PHY_INTERFACE_MODE_1000BASEX here makes a device tree with
> phy-mode = "1000base-x" acceptable on every PCS-capable GEM, including the
> zynqmp, versal, mpfs and pic64hpsc configs whose .init hook is
> init_reset_optional().  Should that hook also learn about 1000BASE-X?
>
> It still gates the whole SerDes and firmware bring-up on SGMII only:
>
> drivers/net/ethernet/cadence/macb_main.c:init_reset_optional() {
> 	if (bp->phy_interface == PHY_INTERFACE_MODE_SGMII) {
> 		/* Ensure PHY device used in SGMII mode is ready */
> 		bp->phy = devm_phy_optional_get(&pdev->dev, NULL);
> 		...
> 		ret = phy_init(bp->phy);
> 		...
> 			ret = zynqmp_pm_set_gem_config(pm_info[1], GEM_CONFIG_FIXED, 0);
> 			...
> 			ret = zynqmp_pm_set_gem_config(pm_info[1], GEM_CONFIG_SGMII_MODE, 1);
> 	}
>
> With phy-mode = "1000base-x" that branch is skipped, so bp->phy stays NULL,
> phy_init() is never called on the PS-GTR lane, and GEM_SGMII_MODE is never
> set in the ZynqMP GEM_CLK_CTRL register, which is what routes the MAC onto
> the serial/PCS clock path.
>
> Is the failure also silent?  macb_open() calls
> phy_set_mode_ext(bp->phy, PHY_MODE_ETHERNET, bp->phy_interface) and
> phy_power_on(bp->phy), and both return 0 immediately for a NULL phy in
> drivers/phy/phy-core.c, so probe and open succeed with no diagnostic while
> the link can never come up.

Per an earlier discussion on this list 
(https://lore.kernel.org/netdev/DKH9Z0IMH95B.3JWB4PXQC9SN5@bootlin.com/), 
this seems like the right thing to do in this case. This particular code 
is apparently ZynqMP-specific and only relevant in SGMII mode; the 
particular PHY control behavior here is for particular onboard devices 
that need to be reset only when operating in SGMII mode. I don't have 
any of this hardware, however, so have to rely on the comments from Théo 
Lebrun here.
>
>> @@ -4932,7 +4949,9 @@ static int macb_init_dflt(struct platform_device *pdev)
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
>
> macb_init_dflt() is reached from init_reset_optional() a few statements after
> the SGMII-only branch above, and macb_mac_config() sets PCSSEL for
> 1000BASE-X too.  Does that leave NCFGR.PCSSEL enabled while the SerDes lane
> and the firmware GEM clock mux were never programmed on those platforms?

I think this is the same concern related to the particular ZynqMP PHYs, 
unless I am misunderstanding what is written here.

>
> Also, the binding in Documentation/devicetree/bindings/net/cdns,macb.yaml
> documents phys with maxItems: 1 for the controller without tying it to
> phy-mode = "sgmii", so can a 1000BASE-X board legitimately expect the driver
> to initialize that SerDes?
>
> One related asymmetry: for a board declaring phy-mode = "sgmii" with an SFP
> attached, phylink may select 1000BASE-X for the PCS while macb_open() still
> programs the SerDes submode from the device tree value in bp->phy_interface.
> Should the submode follow the interface phylink actually selected?
>
> Note this does not regress a previously working setup, since 1000BASE-X was
> not in supported_interfaces before this patch.

This is an interesting question. The behavior after this patch is that 
the listed phy-mode is basically a default setting: the MAC driver 
declares all the interfaces it supports (GMII, 1000BASE-X, SGMII, etc.) 
unconditionally and uses whatever is in the device tree if no 
higher-level interface calls to select one of the options otherwise. 
Aside from the SFP layer, I'm not sure there was anything in the kernel 
that would switch at runtime from e.g. GMII to SGMII and enable the PCS, 
so this probably didn't come up much. On devices supporting 10G links, 
which I don't have, setting phy-mode to "sgmii" would not previously 
have inhibited the phylink layer from switching to 10G-BASE-R in the 
same way: the device would have come up in SGMII mode, then later been 
reprogrammed to a higher speed. This patch is equivalent and doesn't 
change that process: it would come up in whichever mode is in the device 
tree and then be switched over once the kernel has a better idea of what 
to do.

I think treating the device-tree value as a default but allowing phylink 
to do something else listed as supported, as both the existing and 
modified code do, is the desired behavior, or at least I can't think of 
a good alternative: if you want to use an SFP, and the SFP has a 
preferred interface, I don't see a downside to allowing phylink to 
change which interface is used. And if nothing explicitly chooses one of 
the interfaces the driver declares as supported, it will use whatever is 
in the device tree as a default.
-Nathan

-- 
Nathan Whitehorn (he/him)
Associate Professor
Department of Physics and Astronomy
Michigan State University
Biomedical and Physical Sciences 3225
East Lansing, MI 48824
(517) 884-5563


