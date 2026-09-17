Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazolkn19011001.outbound.protection.outlook.com [52.103.1.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5A230C159;
	Thu, 17 Sep 2026 04:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.1.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789617707; cv=fail; b=WSd+tQH1Q9TWP7ItLbd0efwcyrUbEb7aiaXhXUIF2RHFdOQI/ggdQtUpPzUVSiPsghjVfqplwuB/AeLUwace7BfKsQYuYUVgN3eK5TvimT9Wt9fmAMYmCoSo+5+JD+AVBWzBdIU4S6sXYRgVR6K7gGEWk5DJKZ+2esNsD4X0usI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789617707; c=relaxed/simple;
	bh=Cz9pFm35xACTXaaLmLF9ZGcY8bCoioQ3C0MbYHWIgQk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YzQDpglNniqjygyRPEoVDudQ+7vN+ae0hSO4TdAgO5bKuibWVi0K3XvCIMJS9hysic5xcATLCFCmRuQi/6IHgpoMMFG0FOLoEa/5Dy+te297tDeqcnlGQ/aoeY9DAeRfyf/ShGnobDzvD18Cywo2jXmiJanHR90d6kdK+M4SZxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=R8z43rTu; arc=fail smtp.client-ip=52.103.1.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="R8z43rTu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uymf4sDGvw64GTs2KkJSFveV9aCkcU3+i9y5NVS3I1HpNwq03uU1+MHNZlKIAiBdQO+Ja2TEfjwqCEBqIWCm0myHWyiuZFzoY3kX3Pn5G+8mZpxKjORz67R89/oqA/x3mrI//0aUyueJpM6UKivt/lAgkFeOSsZya7t+qBeokLCLJuGzlkLYWG/11OZO/TjXWGORsOEjpNRc1Fh6zym490jry+wwSwlaIz4JDi7nrVQlKVurBBJGybNuqXFHQpN6eI/BfAiC+JDYBtWrKIjpH8pR9oIOQUZt1U/cunOoNo19ULvhQqIRKou7dMmLueisWzeNh/nMeMYTNwmHvLh5wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L4IBLuokOlkdo0E63FcTzxC3mFFEgR3FKlO+cIfu29w=;
 b=bapRuf7hc4HIt9ctsPPzXW7yxTBWZyfiDKz/X75AkllGPKCTcYdiyF3/VmxaV05ZrZmXOgMuDsP136cpxbgCFHdHQHAFRY+zoc+8t3hd1XLC5ytZTXSePR0HfSYBSSYQdueEctzPS5xg7UKjmt6tTQZa53ISkUWA4eNvFcGpl93cR3hGof5inowMcxJKfxO41xPldryrt/T0cZ78E8FIs/5PZuOrdAUhAaQIOE++NzFdc5WMYT0bTfc4/60AYhig2bnEFkxvTxJcCDCULOv9qznuzrbf2Lv7lyWVM/5S5sOu5uhGuKxso3X44IL7ZLgNHnzTT7Qy+MEdfmAXIx+piQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L4IBLuokOlkdo0E63FcTzxC3mFFEgR3FKlO+cIfu29w=;
 b=R8z43rTuAk3anVpBEE1MoaGVx8TywgltbO5ZJY1w6puVPolKoltLh/Srml8IVoXy6eVCyoY69AWLTZWGG8dzss11/ZJQ2uXI0hTqKiCSAOlD9oKTg1A4zKupUmtk9rLSMJrgya+Uk2UGyfq3PkP0bCYxJmO2a3bl/fLzmcuPkw4MrBuY94XTJJKPlR+U9yVXCoUK0OBbJ6gdTYbMoA5Lh9SQl6oLJUp34OsgJnJ46D8nQZqK+nkwz59z6MN2w7F42ikJiek6CIPzqYKFQnNKSqm6bPB4YWbUzNoT5+0TuLctxbPdipZtuHpbntUfX7OD6HWd6QXFunUZSShQ0t+JUw==
Received: from SJ2PR11MB8401.namprd11.prod.outlook.com (2603:10b6:a03:539::19)
 by DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.11; Thu, 17 Sep
 2026 04:01:33 +0000
Received: from SJ2PR11MB8401.namprd11.prod.outlook.com
 ([fe80::ccc8:68f:2e82:ab65]) by SJ2PR11MB8401.namprd11.prod.outlook.com
 ([fe80::ccc8:68f:2e82:ab65%5]) with mapi id 15.21.0406.013; Thu, 17 Sep 2026
 04:01:33 +0000
Message-ID:
 <CH3PR11MB84130D13D3C044A598597DD8E4B82@CH3PR11MB8413.namprd11.prod.outlook.com>
Date: Thu, 17 Sep 2026 14:01:22 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] net: stmmac: propagate platform mac_finish errors
To: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
Cc: netdev@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Russell King <linux@armlinux.org.uk>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Choong Yong Liang <yong.liang.choong@linux.intel.com>,
 Bartosz Golaszewski <brgl@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <CH3PR11MB8413FCBA598F7FABC04ADCFEE4B92@CH3PR11MB8413.namprd11.prod.outlook.com>
 <CH3PR11MB8413069BD77B03793D1A9B42E4B92@CH3PR11MB8413.namprd11.prod.outlook.com>
 <aqqFnJ2EF828xFFb@oss.qualcomm.com>
Content-Language: en-US
From: Thomas Karpiniec <tom.karpiniec@outlook.com>
In-Reply-To: <aqqFnJ2EF828xFFb@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MEWP282CA0072.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:1dd::8) To CH3PR11MB8413.namprd11.prod.outlook.com
 (2603:10b6:610:170::8)
X-Microsoft-Original-Message-ID:
 <03f70d38-03df-4cd3-b8dd-40bc32a52b27@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8401:EE_|DS4PPF0BAC23327:EE_
X-MS-Office365-Filtering-Correlation-Id: cc0962fa-691f-4da4-6501-08df14705a64
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|8060799015|23021999003|19110799012|15080799012|6090799003|51005399006|24021099003|25010399006|41001999006|440099028|3412199025|40105399003|2607281247196008;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bmQvMm5tZVBXdE1VTnFSK1o2TVBQOWdMTlFVRWhxTTMyRFRuOFIxbzJ3VXZO?=
 =?utf-8?B?bzhaa1Q1RVFNcngvd0JJOGNHUmdhbThWRWwwU1JhVEpsK0VvZzVmTVduUXNl?=
 =?utf-8?B?SEhzWU5qUmFrQSt5c3IxT0V5dzZhdUNOTFNSbVlxRU1QN2s5L2tvem15aXY1?=
 =?utf-8?B?cGJOWkJRd2tZNXN6VHQzdTBaVmJvUjBSSC9LMis0dHlsaEtoNFpLY1VJWkc2?=
 =?utf-8?B?WnV3b2N0K2EvWkhreFd1cGJRTDVUOVp2aldjY0NFem9LdlZSY0FjMzBuNFpp?=
 =?utf-8?B?ZEwrQ2hkTnBTOFVyVThGL0ZvT281L24zdEZVNWl2bTVsRHlmcmdLS05CUnB6?=
 =?utf-8?B?SE9wZCtjT2UzMkp3SlpESXNyNWtzT2V0SDdPQzFhTHd4WVgzN3ovYyt3dUxX?=
 =?utf-8?B?MlR5YXJYTS8xRUNKVWJxdjFpdzVxT0xUUzJjVVJSZkw4WUx3dlVRdExXb1JS?=
 =?utf-8?B?MGlUV2hWTmJXQjBjVmdzc040V0YvTFRIeWQvbXVaQjNmQUdQTzduQldEQkUr?=
 =?utf-8?B?VkIvUTl6NnRzTHc5RzBBZWttYnpNM2VpbjJ6TkNtMGFMZWdZemFacFdNc3Uw?=
 =?utf-8?B?L3BSVW9SSE44NjJ4Njgzd1BpYnE1M3lqTXoyYzRaZ2NwMlVXeDlTZFZtK3d2?=
 =?utf-8?B?OE5xcHM5WjJoOWNPL0NtT2pFUFBDM3o1cGJFVzBiajcrTGx3N0VuUUQ3a0k1?=
 =?utf-8?B?RXpBYjM0YzkzWFhkcWJKY0FDOGNXeDNqdktXN1NpVDRGTm9teUpwSUhjOXlh?=
 =?utf-8?B?RHpOd1RpVHZKWmp1UzVETE1JM0hrYVRyblVBS2dkd2xFcFFEZkVlcHBIVkdQ?=
 =?utf-8?B?b1VmT2pKOHlCRERES2RTekl3SUhvSGNVRnhCUHN4b1p3aVBJM2xwU2VQMWJu?=
 =?utf-8?B?TjYvbzBXY0ZMNzJiZG44d2V4OGlTMGdvcUVyQmZkZVV6VXdOSDhZcVdXVmts?=
 =?utf-8?B?MFF0dk5oTllxaFdzanhISWJ4ZFA3L3BlVndDNUZ3ZWIwNllocVdNTTZINkR6?=
 =?utf-8?B?OWpvaWNLVGczbDBCOE4xNU1jNEIvcWwxNDNjNmRlL1RFZGxWdWNSRDF0UG9q?=
 =?utf-8?B?NW1uUURtaHRTQitJNTZHdWh0b0pwNzZIMURhNjVKK2p4clE3NHRzd0FuNXZ0?=
 =?utf-8?B?K3hzUER5b0VobHhEeWZZcmdCQTRKWnJMbyszVzJ0NlFqNkQ3cWRHVEFkUWUy?=
 =?utf-8?B?R3Z4ZXdrNG80dVRQNXduRExobXp0a3ZhdEVqL0ROYXl1M05PdmluM0xQVVQ5?=
 =?utf-8?B?VE5xM3lmdnZOSEZIOGhxN2FTYllUbWJUL1dKQWJ0dGNDbkwrNi8raHpINVQ2?=
 =?utf-8?Q?nvyOnHUOy63wiTO5pU35u0kxjzQGi0MD7V?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WVZzSWFUV2dhN0FwVVowRGJKSURkYXN0TEt2U3FHN0VIdVRIa3NWbm5QcTg1?=
 =?utf-8?B?Q25LVHNadUJJWTMvVzlPaGIvVXRTUGw3SFROTG40Yjc1Y3RYWGhxVzVFOVpR?=
 =?utf-8?B?NHVGd3ZsMU9WYlM3RkJxWk5OQWJNZFkwcjBqMnNrT2tlYWk3QkYwa3FFVjJZ?=
 =?utf-8?B?SjlJNWZoRzdoWW9nNEJJdG81US9TdW9zazM3NXlKdHJQV25zMmNKWGo4L1ps?=
 =?utf-8?B?d1MwUW14dEJqUGNMUjd2OUNPZUtZbHJyR3VUMzNaRHM5cmZ6NkllM3ZSVmxP?=
 =?utf-8?B?TEw3VHFXcVBqdWJyRFYvV1k1RUpPRWE3Z0FNM3RPMC9TM0QrQ3RaOXhRRkcv?=
 =?utf-8?B?c25jVmZkZGt5R3d0THNqaHRFYXpmUHpwQTlSYUttNVZGL3dUN2cxdkxJbDI1?=
 =?utf-8?B?UEtHUDdHcXZuVFhPbEZ5OCtPNGloZG5VVUUrekNLbGtwNzNoZncxUUUxaC9D?=
 =?utf-8?B?WlRMRitpWmZScThiQTh0aFo3VFhSTTVZdERvWVdJcWhQUnJCQ1hxRzZzdWdS?=
 =?utf-8?B?bHhTMDBtUWd3eUpHeG0vY1VVWUNhTnhJWWdBbURjSjZDelh6Vy93TStadWNj?=
 =?utf-8?B?Y1lmQUNsb291NGtsQUJRZVFUYmNKR003cGpjMFVsL1hHRmthNXVOb2srNkFk?=
 =?utf-8?B?TXVHaW82RkUzb3lMY1BoclVacFF1dWcybVV1d1NCUnY0ZFhqcmxWbDY4SHZW?=
 =?utf-8?B?V3FERDlmRHZuNVo5akRjS1ptTE1WWnU2QS9jdVh2L3o4S0VMSjJLai9jS0hT?=
 =?utf-8?B?UnVsMVpHcThmSXY4Uk1zN2lOeUZaQXhoL1liblJNeGhVZVdNMGRkOHVnVTEy?=
 =?utf-8?B?N1F3UWxSLzBMcHpVWExyeVU1cWxldE43bVZva2MwU09xS2hvZk1TQVNIY3Nr?=
 =?utf-8?B?dm84YTJ1RXdXaXNVVEdnMytqc3FCUlVXdmFQTUpONVo1VmFha2g5cERhWllw?=
 =?utf-8?B?OFdWVUR2ZUgrY2QrWjg2azIvRGpuWm5PRmN0TmljaWpmaE9jUHZRQldKYUtk?=
 =?utf-8?B?VTVrVmluRE4ra0pBVS9lKzlrQlRwcVMxVVJEV1p5cXNldExSMTZlcm5qdU52?=
 =?utf-8?B?U0M5Nk5ZaGhSN2ppWnpMN1NEOVNZeVlYSVZibWM3VmZuYzVocGxiSlBUdmFW?=
 =?utf-8?B?R3F6VXAyTW5MVHB5am9seDVJVHdqMlJxUGJDSXlUWnN5WUkvcDNkTGZNNzJr?=
 =?utf-8?B?R1lzZDJNWEU5SXJLNy9SMnh2SGF0SjdMMEpuVGplZmNSRzFzeUxHSnhtTnBh?=
 =?utf-8?B?eUc4VkFwN05taVJpVDQxTnBqR2t2MGpIS1Y1VXlpQllyUE54K1UyVGRHYjV6?=
 =?utf-8?B?SEJhVGRVWGs4ZVo2MTR1a1JqWTFhR004ZUdFREY0UFRnSTM3MGZ4RDRzSGN3?=
 =?utf-8?B?MEdGdXZ3UlZrKy9ibENzdEpLR0RUcVBzWjczam93ZENpWkFjT2wxRU1wNHpT?=
 =?utf-8?B?OWpXL0xjbkN1dTVIVis5b2ZsRlBSWFJzdnp3UmRwL0h2ZDdUQnc5djQvZlE1?=
 =?utf-8?B?NVNRS3ExSDZyMDdLa1BOMnlVV0J1bFJxK3RwVmFpNHZuVGE3TUVLSTVxeUZh?=
 =?utf-8?B?aEpvb2JESjdob09EQmo5VzIwMjNsWml3bWh6UEJ3MmUrc0ZUS3ZnRGlnOXcy?=
 =?utf-8?B?eXZFVGE4SDNQWFE3TnBNZ1E0ZGJIQ1ZLR0VIUSs4QndDT3A3anliNFhKcFc4?=
 =?utf-8?B?KzlINllPdjRXZHdhTDJaaW1LSUZOUElLazZMOGwxbU9VUmJSank5Rng5SVll?=
 =?utf-8?B?ZDlYWkorUEYxSEFHVkQzVnBLd0hDZXZRUkR1aFU1MGc5STJVRWIzZGM5dmpl?=
 =?utf-8?B?bUtPaUlCYXBzbzV4dThuSEVXYTlzQ3BXbVpGWUlUcUw3U0NsY1dOWVEyTFRS?=
 =?utf-8?B?cm9rdHBZTVR5RFdpMENaK2ZwcGpTRzdHd2NJdDhBZk9UemdVdlhWSnJPbjNv?=
 =?utf-8?Q?se+g7Pv3Dwa/Q0x7nDQK7lwzBo0EIP3n?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc0962fa-691f-4da4-6501-08df14705a64
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8413.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 04:01:33.1079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF0BAC23327

On 16/09/2026 10:03 pm, Mohd Ayaan Anwar wrote:
> On Wed, Sep 16, 2026 at 08:39:49PM +1000, Thomas Karpiniec wrote:
>> From: Thomas Karpiniec <tom@wendy.sh>
>>
>> stmmac_mac_finish() discards the platform callback's return value and
>> always reports success to phylink. For example, the Qualcomm ETHQOS
>> callback can return an error from phy_set_mode_ext() if SerDes
>> configuration fails. Phylink then treats the interface as successfully
>> configured and can report carrier even though the SerDes is not ready.
>>
>> Return the platform callback's result so that phylink can report the
>> failure and keep the link down until a subsequent configuration succeeds.
>> Keep returning zero when no platform callback is installed.
>>
>> Fixes: e654cfc718d4 ("net: stmmac: configure SerDes on mac_finish")
>> Cc: stable@vger.kernel.org
>> Assisted-by: LLM sparse
>> Signed-off-by: Thomas Karpiniec <tom@wendy.sh>
>> ---
>>   drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> index 1fb5f804ea23..1350e92943ac 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> @@ -1048,8 +1048,8 @@ static int stmmac_mac_finish(struct phylink_config *config, unsigned int mode,
>>   	struct stmmac_priv *priv = netdev_priv(ndev);
>>   
>>   	if (priv->plat->mac_finish)
>> -		priv->plat->mac_finish(ndev, priv->plat->bsp_priv, mode,
>> -				       interface);
>> +		return priv->plat->mac_finish(ndev, priv->plat->bsp_priv, mode,
>> +					     interface);
>>   
>>   	return 0;
>>   }
> 
> Just curious, are you trying to resolve the issue where an interface
> gets created depite:
>    qcom-dwmac-sgmii-phy 8909000.phy: QSERDES_COM_C_READY_STATUS timed-out
>    qcom-ethqos 23040000.ethernet eth0: __stmmac_open: Serdes powerup failed
> in dmesg?
No, I haven't seen that error or any specific SerDes faults. The error 
message you mention appears to be a failure in the serdes_powerup 
callback whereas this is propagating errors from mac_finish.

I just happened to notice the discarded return value while working in 
the area so I don't think it's related.

Tom

