Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11023129.outbound.protection.outlook.com [40.93.196.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5497456E06
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 15:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785856124; cv=fail; b=XGWSyLoofHyfm9xxtPsFeNn1Ip5vvrj3X9OSmNX6+VOH/gVLHG5dzWEmQLYA4gSVgHpXrc5YlSeYvyVL11/djgz4zX2aXbkDtr5sgwqeaZVo4ejmqHs+cdO4uKbS3fH1V1Lr9SO9qi9/PMCXSIf8ndQ0dzNctI6C/m61j4BXcfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785856124; c=relaxed/simple;
	bh=PO6p2RcCXGSEkuAU7oLUnB8Tt8RbShdBM84hnGRA5Q8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HnzrgE8W7FctDU3CA2MClpeR1cz1QluUwYAFjFZxf2YtcMXLRc29hALKR7W7DKKP74c/TTi0XQpqkAdImlACjqTwoux8ma04dI+AsU9ivz5nWfjgwHl0sjiTQdPQp7SckB0EaxHUIHJuYtBs6iax0iNUomGLNa+odjMRcgMlo2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pa.msu.edu; spf=pass smtp.mailfrom=msu.edu; dkim=pass (2048-bit key) header.d=pa.msu.edu header.i=@pa.msu.edu header.b=YoN4gUwJ; arc=fail smtp.client-ip=40.93.196.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pa.msu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=msu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pa.msu.edu header.i=@pa.msu.edu header.b="YoN4gUwJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kc9CCrGuMdyYg2hsCN9Glo3jBBdfhAE/aG5QlumRGZnVJ/9xhRbxiLxzTr3qBANaKjDqTFD+PRfVq930aoIL8O1ul5+vw4L8tbpK8PlDqjg45Hwf0O4ac84efQawM8AgLFOUpM7jZE5g2PH+3ZNZs3c5HkdLPbtXiDXGpuV3CBjm9jWCjTVcZHZh+D7f2PrsswaMQ5fNxg2PcrbXOAGkMrx93YkdwLq3ztsa4vbIgV8r6OXv5UDkea1wvONqUh7/1eCSa2ulmgJ+Vfmo+NSQaPa5I5W3l0sliwD3AD/2qktDuToFO8lFTmlAuDTsZrW3h1xvOY6M8AUmGO8vV0uNyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vsxMgCLXt5jOwQ0BZKSudUidqT6GMYorYlEhh9IzyA8=;
 b=Q7zVm1fQpm0e3uyqzbgdlDHG4o2y+SawVbLgah8v94Ws3kYasesaWO6mDYRFdiaBaMQ2SZ4WNbSBARUE7IYghi+Tn/QjIvD5sbe7C/tNYU2RrG6zm/4HCn64UAO2/6zWPqlhdRk30H/iqcptcZom7Re9RTwde7sarZDtUpPTWnXjL7FZCziLkinV21pudkaTG23upaOiGQ5UlBX/BF/LWaZDamZ7n3Uwqzq3cQNmXxzSvDcIa6kqonenUIB7vc62kMivxV5avyfsvCB8cu+J/mVUL7F2+ZMKT/vV5Hn9nO8czEkh/YZbfeBcMhf/cXHT1FZ4cbRuSATJjNHrxa0IwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=msu.edu; dmarc=pass action=none header.from=pa.msu.edu;
 dkim=pass header.d=pa.msu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pa.msu.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vsxMgCLXt5jOwQ0BZKSudUidqT6GMYorYlEhh9IzyA8=;
 b=YoN4gUwJpBcANpnuOWDPzt3A4Qmh95Y14BGfhsbmxGa92WfHpAcpeMIKZjFusFt5YtSqOJsoQ/GWby1zbZAn/TcIeqOgpnyZRPBmibVeHNUYJ8LbEPymW9DeFkiitlzNqATGttFKxK3ngFPqn5P4ZtPmkABngv2Pl77uviCKgyOtq5GZu1HHTxoJODhX+O7rmJRX2DAxCc01tXZ3+l0UJi//SCjrBFGovNYa+T+QMUM9EQnmrZ/TGyod4EmN7crlpc39bNYotaMm5NMIsd3r99VAC/X+lc1m1oqjotESjk6UvBFdYVH4vP9ElavtfDmXNnvDuvhoz/Xt7kUOuaVAfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=pa.msu.edu;
Received: from DM6PR12MB4337.namprd12.prod.outlook.com (2603:10b6:5:2a9::12)
 by CY5PR12MB6552.namprd12.prod.outlook.com (2603:10b6:930:40::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 15:08:30 +0000
Received: from DM6PR12MB4337.namprd12.prod.outlook.com
 ([fe80::b412:1b80:dfc:18c5]) by DM6PR12MB4337.namprd12.prod.outlook.com
 ([fe80::b412:1b80:dfc:18c5%6]) with mapi id 15.21.0270.016; Tue, 4 Aug 2026
 15:08:30 +0000
Message-ID: <db8e1771-8d93-4c18-b09b-5976e1f0c4c3@pa.msu.edu>
Date: Tue, 4 Aug 2026 11:08:29 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/2] net: macb: add support for 1000BASE-X
 autonegotiation to PCS
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, theo.lebrun@bootlin.com,
 conor.dooley@microchip.com, charles.perry@microchip.com, andrew@lunn.ch
References: <20260729192748.6928-3-nwhitehorn@pa.msu.edu>
 <20260804083706.54487-1-pabeni@redhat.com>
Content-Language: en-US
From: Nathan Whitehorn <nwhitehorn@pa.msu.edu>
In-Reply-To: <20260804083706.54487-1-pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR02CA0019.namprd02.prod.outlook.com
 (2603:10b6:610:4e::29) To DM6PR12MB4337.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4337:EE_|CY5PR12MB6552:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e08bfcb-068f-48bc-9d78-08def23a3e74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|23010399003|1800799024|366016|786006|6133799003|56012099006|4143699003|11063799006|5023799004|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	pcglAzJhA/aoykCLnxo60JDKqYm8njl4LtTzkZ/APOdCiCSNw2fsPZSZzGYJP7reJ1ZYzHVR6COXHm4p/zk5WF8QWr65OF8GscDdsSyLziVo1uiMjRDL2WZPRNzn8UeEW0ujBwQcl8wIiNNPlgBiMAlg0/fJwuO7E2FITaQEjMkSA77VnOc2O6/lr59bXT/T/LfwzxXcCfmxd5wVGiNoS7PGkx8Kt8cIAWk0EKeanBqZpAR1wmox+b1qHV6ZPiMhe0zU5nb93o9dSG4wE6mBVBb8H8ru46lduPZKzBny6NRTZv4VlZZ1XwyY/4bsXKGtAGwnIXdNNL4mmfVMmtKU7P2Z7k3Jnjf92fhn2NCflzhllgj9bfwbAkWmbKqq33JUmclYZTr6iPhN0bjJsoreVVmQ9lubFEZlI4cxhkfy4o2/9JmRhkCQU1uWK+GgDDZJGfsoLPxZEgQAgx9tfaU2e63mZzEeTGBI4YncV9HjVg/64O3VZifmp2/WrNbn8Qp11a5Hxgoi6eEkXjY64lpgicdQvGN5DCFA6RuSFpUqjJvBR6RJOhF5P5Qeu6PRBJbAKeFnjugMnn5pOc6gtxqTehyB9GqgEZjogXS8qw+Akik=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4337.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(23010399003)(1800799024)(366016)(786006)(6133799003)(56012099006)(4143699003)(11063799006)(5023799004)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TW1nOGpMQm45YkFTMHFNRk9wRUc3aGJuTmdwaGVoeDBmL2dYeDVRQWNIbnBX?=
 =?utf-8?B?bUYwU0dVN21XRnpwUHJEL2VPTTJqcnNEdjcxQ0VsLytxZHpNWFBVSDFBbng3?=
 =?utf-8?B?QXlmbE56b29zYlQ4ZjJLRlB4WnlYUWM4TExjd2hSNW92THJyVzA2Nm1WZ3RU?=
 =?utf-8?B?NnRlWGs2bEl1STJUVkVvU1AxR1ltZ2dpUEVzU3Faa21reFlMdmR5Zm84cEtV?=
 =?utf-8?B?M0ZHUlhmcGZsVmwxNG9TZk02Unk5R2hLTXMzQ1I0blQ1VUMya3lIaGFCQmdF?=
 =?utf-8?B?T3BwVEVKS2cxOURwZU1BMlhiMlJlWGc1eDRDakl6YUhsQmt6UFVaMHVubTN2?=
 =?utf-8?B?djFwaytuZzE1c3U3OXpmN1FOSlJzNlhjUnFxQUR6a0VNcDVWQ2ZadHNtMDlV?=
 =?utf-8?B?SHNlTWg1NGxCUzlHR0tmWlhlb2VKVi9jaEhJZWFydUlER2xEVWxLckdrTTZv?=
 =?utf-8?B?VlpmNmJPRy9xUTdoQWRheFpWWEdUc0JEaXNRWU9SODhOYWJzOWVwajBIUXp0?=
 =?utf-8?B?L1NiRzltSk1BOEQwd2RDVitXUnJPL01mbXFWbUFNNU5SaW4ycU9YNDd6OWww?=
 =?utf-8?B?cDl6UjZCNC9ZTHVyeHpnc2N3RXoxbG02dUs2clNqc0VvamNOb0RmRThxb01L?=
 =?utf-8?B?UXllTVlwdXZxRkxJRGVheWFrZkRXL3RQMUhzcng5WHo2NDVNMmQvRVo5dzJU?=
 =?utf-8?B?MzhyMG4xb0l5QVJaVjhLYndObDNiUXBwOFhNZE1YL0JleGlXZVRSRnFMajIy?=
 =?utf-8?B?L1A1b1BYSTFuVGovZHFYb1E4WWJzR01FS0NENTJzZDh3R0ZpRGN3RTF3WlZk?=
 =?utf-8?B?TlV6bkY0RFpvS2tiU1pVcFJ5bWN5RzR1bTNTYlNHVkZNTmNBQmNOZkVUZ3FR?=
 =?utf-8?B?VlFFdUJBZm8vcVZ0NDVmbGVpMnJxUUk4TDRlZ2h6UTdNYk8wY1NCTlg5ZHlp?=
 =?utf-8?B?eWpiUFJBUkZBMzFnN3RqbGdSVGZNRWxNbzVDcDR5cEZBL3oweEFpRDVYemRS?=
 =?utf-8?B?VUY4cFRBbkFqd0VzU054bXFaem5rdnA3Vm1hWFZqWDEwSWdoaW15Z0Noc3h6?=
 =?utf-8?B?Q1JTNGl1YWU1SXBZMm9abHpML1k4WWZaK1R2bUxpNEtoYmdhWWQvTWp3WXJ6?=
 =?utf-8?B?dnZ1bHp4aExtdkhxWnBxVlRPSS9VYnk2ZmxtZ3FpZ0pmdTVpZ1NIa0FYaHFX?=
 =?utf-8?B?V2psclN4NlcweTJPUzd5M0dHa3NZYmw1U09ILzluRTVYd0g5ZnNBQXQ0bDdp?=
 =?utf-8?B?VW0zME01Uk1GS1NWNmxEQklqMCt2OVRSaG1SZ3JieGgyalFXcDdwaVZCelFn?=
 =?utf-8?B?TTJIT281UVk4VlE5VFF3Q3RsV0dBOHZLSk5tSVJiTllJTGlwWlcyUk1kTmhk?=
 =?utf-8?B?WjVocXVvTVp3MGZhS3pkNlBha3Y0WlRCWDZRNXRsMFNXUmN6Z3EwWWd1TjN5?=
 =?utf-8?B?MmQxa0NiZEM5UVk0c0h5MTJ6bEFGdnZ1ZkNsQXBydUhFSkgrQ3pCMk1ZNkRP?=
 =?utf-8?B?K2NZbUp0UGxIQlVHZ0JHTWJGZC9FRTRYSXNSYkVSdFpsdzhrd2c5TlBFN21N?=
 =?utf-8?B?QWxET25hZ0t4VWJwSmhsQWs2WEF6enNoZXBRRVVJbGh1cFBjemF0YmxWOWcv?=
 =?utf-8?B?NXEyck9BMzJqdlc4Tm5zQnhyT1dLNUJ5UWhra0d0OXljWk1oMVNQT1drQ1R3?=
 =?utf-8?B?U1liN01ob2V0NVFrUTYxYXVjaG5mLzRRTkhIS24raUk4eDdGWjBxa1JYTVdw?=
 =?utf-8?B?YmloTXlIZW05WFo1UXhBZXh3K1pWb1lUWTB0TU8vVXhkc2dtOHp4V0c2YnFQ?=
 =?utf-8?B?bGhWbGNDZmdVZzVkRk15MExMS0V6bkpnTXE5NGlEOENLdlI3ZU9CQ080Y0I4?=
 =?utf-8?B?K0JNOEZTOGJiVHBjTGFlKzZoYXVteUE1R1R5NGZlSEdkTkNBaE16WDhzZ3Jy?=
 =?utf-8?B?YzVsQlorZmFRWno2TnhrNzFWTTZCcnlmNHdzVlZZYW1CYmhGN25PWkxSZEZM?=
 =?utf-8?B?d3Q2ckxPYlB1eldmTzFTNGdFOG1FWTBDbU5BKzR4SGplN3NKeXNNd1BXeG03?=
 =?utf-8?B?MWNMTHdBUFBjamtBazRJZnQvMjhvdkUvMU5iY2Z2SWtRNFVwWXBKa25hZjlG?=
 =?utf-8?B?ajh1OVBEcGJ1SmxyeTJiYzlEWi9hcjRTSzd3L0UwRmZYMnVlQkFTQ2s1eXhq?=
 =?utf-8?B?Wm9hRDgvSXhUeUhjWjlKeURCWHlzaysza0NCU0RGczJXcHVOZ3JkSkJOdGZt?=
 =?utf-8?B?aUlnSHVSRW5haEVaTnRpSmJORTVjYUdPUVhkS0FKOTBVenY2RWlHdWVhN01D?=
 =?utf-8?B?UUdJMW9IaEZHV0c2cjd1U3RoZS94UkwwL1BHeE1IUTdNcnVzekNmUT09?=
X-OriginatorOrg: pa.msu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e08bfcb-068f-48bc-9d78-08def23a3e74
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 15:08:30.4176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22177130-642f-41d9-9211-74237ad5687d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HLncCSqxZ/HU1QQumlvNauH0BaX3SEK20KhgEe2qXwihRTkuM0GDfKCQAdIaE3yC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6552



On 8/4/26 04:37, Paolo Abeni wrote:
> From: AI Reviewer <ai@example.com>
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev/
> ---
> --- Patch [2]: [PATCH net-next v3 2/2] net: macb: add support for 1000BASE-X autonegotiation to PCS ---
> commit 3a10158740d1fea523a081adf59e6bcdf1cd55d1
> Author: Nathan Whitehorn <nwhitehorn@pa.msu.edu>
>
>      net: macb: add support for 1000BASE-X autonegotiation to PCS
>      
>      The current PCS code unconditionally uses SGMII autonegotiation, though
>      the hardware supports both SGMII and 1000BASE-X modes. Decouple the
>      choice of PCS enablement from use of the SGMII mode when running at
>      gigabit rates and announce to phylink that 1000BASE-X is a supported
>      operating mode. This enables direct attachment of the PCS to e.g. an
>      SFP.
>      
>      The 1000BASE-X code in phylink also sometimes calls the autonegotiation
>      restart method, so add an implementation of autonegotiation restart.
>
>> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
>> index c15a9c7e69d37..310ad8eac21fc 100644
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
> [Severity: Medium]
> Since 1000BASE-X utilizes base page advertisements that can dynamically change,
> should the adjacent macb_pcs_config() function be updated to return 1 when
> changes are made?
>
> Looking at macb_pcs_config():
>
> static int macb_pcs_config(...)
> {
> ...
> 	if (old != new)
> 		gem_writel(bp, PCSCNTRL, new);
>
> 	return 0;
> }
>
> Returning 0 unconditionally appears to prevent phylink from restarting
> autonegotiation when the advertisement changes (like flow control or PAUSE
> settings), meaning the new configuration will not take effect until the link
> is bounced.
>
> [ ... ]

Thank you! This is a good catch of a pre-existing bug in 
macb_pcs_config() that matters a lot more with removable transceivers 
and I will fix it in an updated patch.

>
>> @@ -750,7 +755,9 @@ static void macb_mac_config(struct phylink_config *config, unsigned int mode,
>>   		ctrl &= ~(GEM_BIT(SGMIIEN) | GEM_BIT(PCSSEL));
>>   		ncr &= ~GEM_BIT(ENABLE_HS_MAC);
>>   
>> -		if (state->interface == PHY_INTERFACE_MODE_SGMII) {
>> +		if (state->interface == PHY_INTERFACE_MODE_1000BASEX) {
>> +			ctrl |= GEM_BIT(PCSSEL);
>> +		} else if (state->interface == PHY_INTERFACE_MODE_SGMII) {
>>   			ctrl |= GEM_BIT(SGMIIEN) | GEM_BIT(PCSSEL);
> [Severity: High]
> This is a pre-existing issue, but could macb_mac_config() race with
> macb_set_rx_mode() over the NCFGR register?
>
> macb_mac_config() modifies NCFGR while holding bp->lock:
>
> 	spin_lock_irqsave(&bp->lock, flags);
> 	old_ctrl = ctrl = macb_or_gem_readl(bp, NCFGR);
> 	...
> 	if (old_ctrl ^ ctrl)
> 		macb_or_gem_writel(bp, NCFGR, ctrl);
>
> However, macb_set_rx_mode() performs a lockless read-modify-write on NCFGR
> protected only by netif_addr_lock_bh:
>
> 	cfg = macb_readl(bp, NCFGR);
> 	if (dev->flags & IFF_PROMISC) {
> 	...
>
> Could this concurrent modification lead to lost configuration updates, such as
> overwriting PCSSEL/SGMIIEN bits or dropping promiscuous/multicast flags?
>
> [ ... ]

It probably could. I am a bit hesitant to fix this as part of this patch 
series for scope reasons, though, and would like to defer to the driver 
maintainers on the proper fix for this one. I don't think things are any 
worse with this patch than they were (1000BASE-X vs. SGMII 
autonegotiation modes are essentially static, except on physical SFP 
replacement, unlike promiscuous/multicast).

>
>> @@ -1061,9 +1070,12 @@ static int macb_mii_probe(struct net_device *dev)
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
> [Severity: High]
> With the addition of 1000BASE-X support here, does the init_reset_optional()
> function also need updating to prevent a regression on platforms using a SerDes?
>
> Looking at init_reset_optional() later in the file:
>
> 	if (bp->phy_interface == PHY_INTERFACE_MODE_SGMII) {
> 		/* Ensure PHY device used in SGMII mode is ready */
> 		bp->phy = devm_phy_optional_get(&pdev->dev, NULL);
>
> Since this explicitly checks only for SGMII mode, won't the hardware
> initialization for the SerDes lane fail when the MAC is configured for
> 1000BASE-X, leaving the generic PHY uninitialized and preventing the hardware
> from linking up?

This block of code is specific to an onboard PHY -- which does not 
generally (ever?) exist in 1000BASE-X mode -- and what looks like some 
kind of Xilinx Zynq-specific quirks that I don't know enough details 
about to understand whether it is relevant in this case or test. As 
such, I had decided not to touch this code in this patch, but would 
welcome any feedback from people more familiar with the Xilinx case than 
I am and am happy to make changes if appropriate.

Thanks,
Nathan

-- 
Nathan Whitehorn (he/him)
Associate Professor
Department of Physics and Astronomy
Michigan State University
Biomedical and Physical Sciences 3225
East Lansing, MI 48824
(517) 884-5563


