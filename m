Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010061.outbound.protection.outlook.com [52.101.85.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDC455C301;
	Thu, 17 Sep 2026 13:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789653457; cv=fail; b=uLueaoFh9BMIkJEq39Qa7N0FmmxIiI2T5ZijKRLn2Nspg1BNvLO/2JMXdFkeTDWqP/JomPMSLV0Fh5VLGcz+B2tpzQGnO+kbFOVCWHrqO3hr/9B/dKuaKx1fPZSAtH1oTOIWfxgOuzo3sC6h55Qvl+k9NQLGzP4CrKWltenprZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789653457; c=relaxed/simple;
	bh=7Fjx5tkZ+a0fIDFvGhcgvUGYSOhPbHXBo9z15BsdUAg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WvXrjZ71SwQlFdIsrpFRCbiEaZjc1enXGVStTvbxZ+5bATXozK5VMBe21+R/dqsxluEA6LM/cpjOUBiqiis8/jnfVFZN7NYSBpNDljXHq2MIW0Gc8nqrH4nXgL1X82RONi8OlHGrao9Uamx8T41LhUo/4EYxwTBjR1W0Q5tipvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SPuIAgNk; arc=fail smtp.client-ip=52.101.85.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SPuIAgNk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rm8DT0qCA5EJxP1YLuqc5P1GDAdJUWRmjijSdXjn0lLAMSsjXILXXmbvKiFsRkTbSbI9oG03pfMPGANoJoskuFT8mWf6tZjUYQlprwUzneHLncvT0WOnuRZpYLLDFV5RmZgau3J5OWLavVQgO7TBvdUjrv+AZlUx4kC7juV/js3OknsEtxO5seIRcs3VTK6eCf7gmhP7yjuBRvUHeSToR5ZboDh2eVpQ3Z8yj/PBvmr9PCnIK5Hi4r3kkokmrEVhd+zxW7SXOhTcpiLhWeez8nCiZldMK3RkxOMF7JMha0Wk/pz9SQTdocWEm0swJkJPVJsRku3OvwEHn9ChRENWcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fDInpRniPO1kXG2DSbrq/BRNg2CkwmboX4tA0vXw+70=;
 b=pJuhYo2/XLW0SIvV3LqvDmk88Jj6Gmd7vgAkf2ZD28ySL8q8Aa/kxb+3q5vrcf/sGvznEN+l6wi03LZ13CSkJdJUXR45SL2kmvNJaPtoUpU18JgwRIa5RLu46EYx4ED2OYueaV/jxYD5YhHlHt2ZRYiDBF/RXRnE5hZXNFBIDc8JFuvwEECX9UZdIGjTvCNJRErpNMFaKjyPcr9zRmtXa1r4jypXryZ4duhYcE2aanlc3+DO06SSAnIR3cDWsH89tP3hOrMiCG8ATmvdVlTxxlpJmcoBCWSktwBlKmHLgWx4XyuhILbohiTxuagEU0MlYZvyBjYmXb4Sj6jY0kAdCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fDInpRniPO1kXG2DSbrq/BRNg2CkwmboX4tA0vXw+70=;
 b=SPuIAgNk80vVUMczlqIxhgBHhYgvl9BQkYVb4QoD2B5BgfIQ5ZHY+A1JIdhLvI5VlsJB+Pk5wtwGUuITtYIa8wiGiywNJxwtyVyzBKI3iSyYIXm11vp8pYUJzbNU+nOpSJwaAh/8s4MxN0DVIanITn6GkDA/O9X3QJmUdn16oD4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8953.namprd12.prod.outlook.com (2603:10b6:a03:544::14)
 by MN7PR12MB219968.namprd12.prod.outlook.com (2603:10b6:208:632::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 13:57:31 +0000
Received: from SJ2PR12MB8953.namprd12.prod.outlook.com
 ([fe80::f3b5:fc98:8973:5c0b]) by SJ2PR12MB8953.namprd12.prod.outlook.com
 ([fe80::f3b5:fc98:8973:5c0b%2]) with mapi id 15.21.0406.007; Thu, 17 Sep 2026
 13:57:30 +0000
Message-ID: <546c2117-2d8a-4c97-879c-e03f73d3d080@amd.com>
Date: Thu, 17 Sep 2026 19:27:23 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/4] net: macb: Add MQPRIO qdisc hardware
 offload support
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Vineeth Karumanchi <vineeth.karumanchi@amd.com>, conor.dooley@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: git@amd.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260909142056.1433875-1-vineeth.karumanchi@amd.com>
 <20260909142056.1433875-4-vineeth.karumanchi@amd.com>
 <DLHHCJ7NP756.3S1PWCQHV5Q3V@bootlin.com>
Content-Language: en-US
From: "Karumanchi, Vineeth" <vineeth@amd.com>
In-Reply-To: <DLHHCJ7NP756.3S1PWCQHV5Q3V@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PNYP287CA0102.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b9::9) To SJ2PR12MB8953.namprd12.prod.outlook.com
 (2603:10b6:a03:544::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8953:EE_|MN7PR12MB219968:EE_
X-MS-Office365-Filtering-Correlation-Id: 3078dd75-26ef-4ed0-5e3b-08df14c39da8
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|10067099003|4143699003|6133799003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	1D/u53/wG8hTQodOD9arKQzULkTN8eDYL2nl4/tXSlv9WOLccDCkW66zZ8G2ZqjkElB3gSiTNV/6Q2xbuBOegdHEd6mPBvG3wCOyUfG/PIHI1yXLbOVBIGdqoprxLyDFN7W2hA1AbTim9FNfmCpoUtxoVZwb8anOupJffMw84yBedzqzgO+UHHDz+t4ggBoGBudNp9XjKT1YDnJDFuozUkVdNz7/If8ylqeA3F8UE6qtxkERKMLrLlSghezTI+2qK5cBdgqJ2Rtwov73jgW6c+pvWEIfQAB0f4jvC2kcKU9ALR5a2vhlBktLGAWaxzgYzXhEQ7T95Wf/EU4Dkq/QXwDJ7l8MtY+PANDG1w5Ay9pPMw01Gahez0E/A8Ai2EfRPpVLRiYZCqgEyESIKth2xWHPas2fOcV+SRy5odAq7F5HZXxSptEUpP6fQxwCyo10h0PirMmoWgRfsFDqk/29Vif+CV1VTAEjy15V2A0EEk48ZRr8uTqZX57BOB0g6tAcjecbo3v0LF+6A4yEyDfnVUdu9ZPKWvI2VryhbMskwYSugdPO+6TO3B9AvgyFx8yFxOxpVqq5bP+QUryoVKcU5LSOEjwicI/KK/NCwz2zkoc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10067099003)(4143699003)(6133799003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L005Mk1aQXRkcTdmb1Bvc01RL1FFUXRubjVGTzNOaGJHcndUS1NFU1BjcXZk?=
 =?utf-8?B?M3FuUEtmby9SWGhLOFdiWnJYaHlPZVd0NHlOV0JBTlhUTXBVek91WXB0ek1C?=
 =?utf-8?B?T2R4enI2bnhnbmFnK29ndGRBN1UwNzNxWkluN0k5SFAyZXlLZkhYK1pUNUMw?=
 =?utf-8?B?YnI4L3pHNjBaTFlSOXRmaHExUWFKalZNamdoZHR0ektaNzZ3bTdlaUVNNE5n?=
 =?utf-8?B?T3VLeHhyZ0J2M2pJWGtyeU5Ed0hYbThqV2FXQzdHdW9ubGxwcExDWEc4aFh6?=
 =?utf-8?B?UWR3d3dRNGZFRDdvY1NIVXdZcDJsVXFEaUZJY2VYY2ZodDZnWUtLRUdUVzZS?=
 =?utf-8?B?TVZ5WlBxc1ZHOFh0ZlI5aXhPMDZlWHhGVkpqc1p0SUhsdDNMdm1pa1B6dGlz?=
 =?utf-8?B?aWtmYlVYQXJFREM5UWhPRXgzUS9qQ0hsb1ZZNm9ZWmhwMVJWS0Z2VnB0QUVp?=
 =?utf-8?B?dXJVYW0wbVMwV3JNYVJUUGVJQmFRREVBR0R0ZUpXbW1RckFwcWFWZWhnTVFj?=
 =?utf-8?B?cUxvdkx2SGgveElhRlZDZE5wZ0d2TUZoWThRbEtmbXo0WHY5bit4NUxGLzZF?=
 =?utf-8?B?WDVXYm9FY0VNeUNSQmxaY1VSa3RKejlVVFFlL2JkT1A4ZndvNGlodk1jZjgv?=
 =?utf-8?B?azZ5dk9jT0hydFpqc3FNWDV5NkJnSXZzbVR3dzBUUExTS1dKakpPc3JJTFhZ?=
 =?utf-8?B?Q1djLzRyc3Y3M1lUU3A1QUpCcWRtRWJvMWpITGFYY2RibHVjK3pId3ZRT0Rm?=
 =?utf-8?B?MVNSVmh5b1Y1RHFVQUI5OUhROFhSQ0ZscVhmVGdwTzY5aHMwY3FJbnBRVW44?=
 =?utf-8?B?Nnk4c2dyNll5UVNqaXlHMkI0Q0VTb0Mxc2d3dlJITzcydlRvM0wwM1dGc2ZI?=
 =?utf-8?B?bmE0OHl4K0VQVVk5YVZ4MmNvWm1NcDhPTkYxRVpXaHRHQ3pFNE1ZVmxFMU9z?=
 =?utf-8?B?aGxOREhaTzJlazh6N2E5R2EzbUxKQTVadEkvd05WUEVqc1dreldkWXJ2bXg2?=
 =?utf-8?B?YVd3UVdldTBrU0lQUktDQVNKdmxPTzRoNHNIanhxL0o5OHJRWXBrKytqUGxX?=
 =?utf-8?B?eEx1R3JGUFd4NHFGM3Rhb2kzMi9BK25KcnBNeWYrTFdwbnpGS2tLYk9pZGlz?=
 =?utf-8?B?NytCLytCNGxmVkpMby8wOTVDRzB3V2tyK0JDVWN3cTQyK2hhUksyQzRHeTUr?=
 =?utf-8?B?MXNwY2h4eWRDWk9zQ2duUU1mcGt5NXVTU3lWb0tSMEJMVWNNc1IzUmRNcncx?=
 =?utf-8?B?VjBIL2tTNlA5L29YaVBmalZTMmJmcHJZeUNwdkxDUjJHdGNYMktOWjFLZG9Z?=
 =?utf-8?B?aStJdHRNRDNzTHpYazlnZWhta0EyQ1F0aTBpVWN0Ym5qUFVrL3FWeW4xcXFh?=
 =?utf-8?B?UzlINzB6VjJyTFlDUnhpN3U5Sk9SR0tVcDdBYWtLTEhRbW9sOE1Va0VXY0Uy?=
 =?utf-8?B?VnpsUmlrdVBjaWtoNHBueTNNNC9UVnVxa1F3SkJqQW1LcjRick9ORHQ1RmF0?=
 =?utf-8?B?QWx6enp3c0N2dWEvTjVqbm9wWnBTMks5MmhZTzQvWTVIMGF3eit2bEJYbTQx?=
 =?utf-8?B?OXBhRkxYaERiUU9ZN3pqT24zOWtQVGRHcDZ3VCttVkFLQjZVNFh1OVZzR0E4?=
 =?utf-8?B?SVVEQkVsaE9VdDJSYVhKbTgwN280dEtQRjZZU2tSb2ZNWWZWVHRyTHl2Wmpn?=
 =?utf-8?B?ODl0SGFWM0F2amRJZ0w5eU9UcHpIcWkrUzRnZTRVYkdkK0tzenZVS0NoWFRo?=
 =?utf-8?B?ZS8yY1g3dlk3MjJFQUE0U09kUTdQYzFTUnRnTGNsWjI4UEx3NjBpYkdJdG8v?=
 =?utf-8?B?SUpZV3Z4SVRyOGhCdWFib1JSMk9WTzU1YW5VSkRWcDNoVXcxNWZWZTlMRGNR?=
 =?utf-8?B?Q1R4aEZGY1RIT1pVVW1hd2lzWkVxVUtBMG9nRURBeDhBbktKNm8waVdlN3FU?=
 =?utf-8?B?VkJOSkU3UXJCWmdRMDRESFhBWE9wMWdtMU5jQUxIelJKcy9QSUc3S3lQaFZI?=
 =?utf-8?B?Z0o0c2VzVlVGbHhEMU9QY21TY0crUk51WFhOUFZnellXY25KaE9Hd3ltL2VS?=
 =?utf-8?B?NVRieEcvYUcxRmFudFYwY2EzbXVISFU4clRud0tBNHFjU2pTNFZ0dUlMODc4?=
 =?utf-8?B?Y01kMC9Id0hPWE5ncFlHaE5lRC94V05rRWloS1ZVT1piS09PMFBnU0lGeTQ0?=
 =?utf-8?B?R1lRY09TbmZmQTdUSW9OYU5FZlNZTGdzRlp5b0NJNUpVbnBRa3lGY29IOU82?=
 =?utf-8?B?Y1NXVjZMdThXZ01kd1VVd3c5OGFhOU1CUHNjTUF6SkNNUTBXY3lLVlhkQStJ?=
 =?utf-8?B?YjczOW5CTlNISTRNNlpUaW5wUW1iNlF1TzB0L0tGMUorOHJwNlZUUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3078dd75-26ef-4ed0-5e3b-08df14c39da8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 13:57:30.9451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gkA6DSArOluF0pCb5EtfYeSEiHCyBeiOAujko79Hvm6lsgC9BYc/RoiEMUHYxtnS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN7PR12MB219968

Hi Théo,

On 9/17/2026 2:52 PM, Théo Lebrun wrote:
> Hello Vineeth,
> 
> On Wed Sep 9, 2026 at 4:20 PM CEST, Vineeth Karumanchi wrote:
>> Add support for TC_SETUP_QDISC_MQPRIO hardware offload, allowing
>> traffic class to queue mapping via the mqprio qdisc.
>>
>> Implement macb_setup_mqprio() which configures TC-to-queue mappings
>> through netdev_set_num_tc() and netdev_set_tc_queue(), and resets
>> them when num_tc is zero. The driver advertises TC_MQPRIO_HW_OFFLOAD_TCS
>> offload level.
>>
>> Add macb_tc_query_caps() to report mqprio capabilities. Setting
>> validate_queue_counts to true delegates queue count and overlap
>> validation to the mqprio core via mqprio_validate_queue_counts(),
>> avoiding redundant checks in the driver.
>>
>> Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
>> ---
>> Changes in v2:
>> - No functional change; rebased on net-next, which renamed the
>>   struct net_device pointer to "netdev" (was "dev"/"ndev").
>>
>>  drivers/net/ethernet/cadence/macb_main.c | 59 ++++++++++++++++++++++++
>>  1 file changed, 59 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
>> index ff7e02d3fab8..67150ff03066 100644
>> --- a/drivers/net/ethernet/cadence/macb_main.c
>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>> @@ -4492,6 +4492,60 @@ static int macb_setup_taprio(struct net_device *netdev,
>>  	return err;
>>  }
>>  
>> +static int macb_setup_mqprio(struct net_device *netdev,
>> +			     struct tc_mqprio_qopt_offload *mqprio)
>> +{
>> +	struct tc_mqprio_qopt *qopt = &mqprio->qopt;
>> +	u8 num_tc = qopt->num_tc;
>> +	int err;
>> +	u8 i;
>> +
>> +	/* Handle reset case early */
>> +	if (!num_tc) {
>> +		netdev_reset_tc(netdev);
>> +		return 0;
>> +	}
>> +
>> +	/* Configure traffic classes */
>> +	qopt->hw = TC_MQPRIO_HW_OFFLOAD_TCS;
>> +
>> +	err = netdev_set_num_tc(netdev, num_tc);
>> +	if (err)
>> +		return err;
>> +
>> +	for (i = 0; i < num_tc; i++) {
>> +		err = netdev_set_tc_queue(netdev, i, qopt->count[i],
>> +					  qopt->offset[i]);
>> +		if (err)
>> +			goto err_reset_tc;
>> +
>> +		netdev_dbg(netdev, "MQPRIO: TC%d -> queue %u (count=%u)\n",
>> +			   i, qopt->offset[i], qopt->count[i]);
>> +	}
> 
> MACB queue N is always higher priority than queue M if N > M. Here we
> should refuse the setup if mqprio->qopt->offset[i] isn't sorted no?
> 

yes, thanks for pointing it out.
I will fix in next version.

Thanks,
> I asked an LLM and it found a precedent in igc:
> igc_tsn_is_tc_to_queue_priority_ordered()
> https://elixir.bootlin.com/linux/v7.2.5/source/drivers/net/ethernet/intel/igc/igc_main.c#L6797-L6801
> 
>> +
>> +	return 0;
>> +
>> +err_reset_tc:
>> +	netdev_reset_tc(netdev);
>> +	return err;
>> +}
> 
> Thanks,
> 
> --
> Théo Lebrun, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
> 

-- 
🙏 Vineeth

