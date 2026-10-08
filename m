Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010035.outbound.protection.outlook.com [52.101.201.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AA6446053;
	Thu,  8 Oct 2026 15:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791473293; cv=fail; b=di0gTJCof3gjBPyHeOx3xKDbaHjZBTunVnvV79BYF8XoKaRqjbuUo1pLNklmo/YX2f8YMmMXGICyDUn15oT9okFnRZUUHi6kFpy6dx9zXvGjErN3gZr+i18fm3dH9Y1j8xusfPYFxcxlCmFg+whpfcyZBG7Psy65uqf8xQNmHgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791473293; c=relaxed/simple;
	bh=677v3WPphECQoaLKHwutxuqOuZG2GLBC7dDVNBtNu2w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h1OdeYZdgs29Xw2QqEuCHLHVY7YDrRSWWrNbwOGzavAMlaiKmlvw8/hd37/ZiDPhyI0l/3wB6eazfaFGi18jGDl5+Ne9plwCmf6hvAKj/Iso79Gd2GW1hjaV2LytTQp9wwBSi5PNl8KXbXGuDn1pQi+HQ8oBorDCXhV/L/tfhhk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LVohQJW3; arc=fail smtp.client-ip=52.101.201.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LVohQJW3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GhGIIirRIGQB3CxDiAINDjliFwDXdD0KKG6DEBfwlRdDIO5IGTam8s4c1gI6tZJs8Qny/cOV1D1FVp9bsuYLH9x5xEJtidtfLlu8OVAevn862H+yIL86BmvWllz88vnLTOP0dbkNWcWeWgoAXfZdWTMPRuNPg+rJksG0rwKep11w9fkYK4bGzxxRARJMfyTZNhi7EEe08GlhBRhex5JqrfXkNlQeLvJFrT+yp6KjaiNSSk4CfEOmc8g30ESnOT5JsAksNrufa3MoHZeyzTpQoBVUIGgugVAUVp6uZjx8ERjGzGCd4ZIOSM6BWBs9edk/4AEpZEege8ukC0j2mGIskw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ESIzxFUYVK/XJrygZ2qEpxQzV3lkBsa7z3hDMdwysVY=;
 b=O3i9gCfj2KNWXnYjXAXTdE9VZKFz8vUmHtlEvlgxaEHl3XjcB0aboy6Td5qYLMOnLErtsDHnDdH4dzrjaMCaoujGjIxVIeScxXoVC9roiWvuoePAYkyGogUgf40jivWiooN9JghFIUuyrNZyyTXJkQNJvWcnglMJ+vTJ1LVk/Jh2u5cLl2fqfac0jLB/HzprKSq61DRlXmd0yub8+0TCiI7wgKGF9pWjwRqiilvoB3OnWT9LFfDk9qoUUyxaFazEdt1f3lrzh+bg1XKrLzm9m072bIlWb6T3kEsLK/bwgH9QW655F+iHS03DsFWGF9WEedNpfMLcYquOt/KX81FxQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ESIzxFUYVK/XJrygZ2qEpxQzV3lkBsa7z3hDMdwysVY=;
 b=LVohQJW3AlqZSa0Y47O4M0WtsBEI1zPDEPK7yW2mRBMLwDmJ0sFK0/l/Lvw6d13SDfiISyVZATegymzDXVCiEs/4pSSyess3X4zCkHkG2qA/OpopkIl3p7KyV2uZRda6CxeUvr0TB2azhrzv+q0sTZi93z40OtdYQ3qhhU40lI0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8953.namprd12.prod.outlook.com (2603:10b6:a03:544::14)
 by LY0PR12MB390394.namprd12.prod.outlook.com (2603:10b6:408:3b9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 15:28:03 +0000
Received: from SJ2PR12MB8953.namprd12.prod.outlook.com
 ([fe80::f3b5:fc98:8973:5c0b]) by SJ2PR12MB8953.namprd12.prod.outlook.com
 ([fe80::f3b5:fc98:8973:5c0b%7]) with mapi id 15.21.0496.015; Thu, 8 Oct 2026
 15:28:02 +0000
Message-ID: <a04aa4d5-335b-47c1-b969-e89b18c9b142@amd.com>
Date: Thu, 8 Oct 2026 20:57:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 4/4] net: macb: Add TSN CBS TC offload support
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Vineeth Karumanchi <vineeth.karumanchi@amd.com>, conor.dooley@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: git@amd.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260909142056.1433875-1-vineeth.karumanchi@amd.com>
 <20260909142056.1433875-5-vineeth.karumanchi@amd.com>
 <DLHHKM7ZOTWD.1W25GJL8Z0G7Q@bootlin.com>
Content-Language: en-US
From: "Karumanchi, Vineeth" <vineeth@amd.com>
In-Reply-To: <DLHHKM7ZOTWD.1W25GJL8Z0G7Q@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0213.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::7) To SJ2PR12MB8953.namprd12.prod.outlook.com
 (2603:10b6:a03:544::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8953:EE_|LY0PR12MB390394:EE_
X-MS-Office365-Filtering-Correlation-Id: b083b371-e925-482f-7610-08df2550bdd8
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|6133799003|18002099003|22082099003|10067099003|3023799007|4143699003|11063799006|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info:
	56KCqr3mXUuvh1eEymBBuqn9VNu8GnwuWPDqq1SsalEuBWZb+X32/moWkR9Uf1bd12WHJaCQVZFbgbMnLtCYyQmUh+Edu5YSuxCv5lPoOBsAjfwb0To/v6Gk4nhO34qP4Y25rg43bGGZdbwlZ5dP9fyF35vAEHX5Qgjj3dNXXbWBOhb0PIcFb6rsyvx9Az8ZFlIf/uVXmfkDmvCfNvTEIQrdlUA687JnPCMzcBg1qNaXquVx5B50j3i6qoPNjUtX0vmFt1K6u4dhUkz1WBUKqv7ww1cRRsAWGdwUD9LrqNO8scVz2uY0FA23onfHM5IlmUs4ngLjXL5k5zH5H7bbnSmHc8DLibSD9uq/1KvVLlom7uEt1KxEbLQ8lfeuFcgsKwr79iGxk+7VbRloAKJxK1MA1FjAUTZJATc6QhgRwWVtm50KIWTPwaJCNj8pOVASuLVEQBbXY3KYCRf68grE7qfoJ+dQRa9byh+8W1TjiwIgL39UobJm19va9PgskKZc7R0QbufyHTkbfkI7uiqV56xEm1rGMrQSFYXr3PgRn8FCNhLoYF5ksgCvUQRp+yaXHH8XcnTh3VmkM1IPVjuQb8GSoVtzbABlf/DxhffIlgY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(6133799003)(18002099003)(22082099003)(10067099003)(3023799007)(4143699003)(11063799006)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WSthcGVlRnFjU1pCWnZlZ3lnNUFTT256VGpYY0ZMaDRuM0NKTGNMTUVnU2pp?=
 =?utf-8?B?TlJrNVUzTUYraWxpTjI2OWVaaWpTbVQvcXpKaTlDdlEvaHAzS2ppVkMzaWF6?=
 =?utf-8?B?QlRKbjFYTEFXendTOGZHQmZ0TmI4cTR3QzFUTGdjZjNPK1RYTkE3SFBDREZa?=
 =?utf-8?B?SmVXeGpMbzFlTzlWU0ZPMDNibzlMTzh4ZUJpVURpcDVQeGhEWE5KRUY3R25l?=
 =?utf-8?B?VW8rTW1ZUkJ1MDZkVTFicWN2S0dWRGhZRVdJYlhuL0oxd3pGaCtmWkVBNWtR?=
 =?utf-8?B?MS9XRks0SzJIUHE1akpKMFcvK3VpaFgwbmtOMi9DS0oreDlYczlUaWZDRHh1?=
 =?utf-8?B?eGNFK2tsVXg1Mk9uR3N3NGZjaFJIZGJhRm02SnZHNFFLclBFT3BVR3U1akl4?=
 =?utf-8?B?ZW9sRTZ1R3FTekZlejZKWWFPSjQ0aEZVOFRrUll2aEtPSjNoU1pCbGFsV0NF?=
 =?utf-8?B?Wk1hSjBoZGJMTVNkVHdLM05kNy9mVGVWZkQvZHQrUVBRQlNZVkppM1R1a29X?=
 =?utf-8?B?VWt0VTlTaU8yQzFuRFlRNmxQK0txTTNPdTc2b2hQajAzM0FGUnZZbW5MTnQ3?=
 =?utf-8?B?M28vQXIrTmt0OGNLLzg0MUZBYkJWNXgwbFJnYmJlQzVGaGJkdEMzZVRBVXlU?=
 =?utf-8?B?S1lMeUFvMlBIOWRYV2tZUUk4TlNpUTM3T1B4OE8vbnBzTDhrV2VqOGZhTXdS?=
 =?utf-8?B?b3k2cmdLdGpPMkQ4L1lJY3l3UUVqYWl6eWVoTmVPUmtCL2g2aFRlUDdsQXNt?=
 =?utf-8?B?dHlpeXJYNmxTU3lvSDVNTkpYQVdseXBiTmE1RUhXR1JmL0htQjA1QURmdGNF?=
 =?utf-8?B?cWtkc2JhV2Z5MEd3VTIvRWVPbStXV1J0Wjd0KzRiSVA2bEtiZnI3VDdWSzNG?=
 =?utf-8?B?c1lWWmxobmNKd0puWG42U2pEL3U3NlZvNFhxK0dndk9JV3BIekpkalp6N1hD?=
 =?utf-8?B?UVZOeTRpaVhzUmM0dUxYZ09rWGxDUFdNaG96eWczUkRYYWppaXJqL0dNRFNU?=
 =?utf-8?B?dHNjcHlvVFRWdVpTanVFNUNiVXNtelYwUGZEeVIzbkpOYWl6enQwbTNyLzJj?=
 =?utf-8?B?cVhnSTBOMWdvRHowUHY5cDRZSS9EY09XOGNUbm5SZWFHc2J6U0lHaFB6NFhF?=
 =?utf-8?B?eUozdWZtR1dLTmc5Z3ZHL09SVmpDSmtFeFZWeTlDVWhJTy9WZTdOdDNOcDR1?=
 =?utf-8?B?ZU1qMDdMT01LUXl0SWcvNWMvZ1ZBaFN2RytITGJvQ0hYWWk3Q1k0MkpxMzJ4?=
 =?utf-8?B?ay92bFd3dU9aSkFxS3pmaXBUTkdIRUNNa2JEdkxROWFoUTRoakpaV0NVMWRO?=
 =?utf-8?B?YVo1V05lMmZONEZVdy9NWm1QRThJNWdkZmhHRGZNczZqL0VjVnhZbFRBNEk5?=
 =?utf-8?B?VndUTWVqQXM3TVhETzFpdHhPUEpNcThNSUF1OGJwZndaMC9LcjVwQnFCdm84?=
 =?utf-8?B?MnJDeFFvTnpZVTNseU9CdFA0dlRLY2lPbENVYk9JdFNZN0FycWZYZ3Fsb29J?=
 =?utf-8?B?RHVWSnU2eU1NM2VxTEs3Sm9SSUFneGgwbktxbmtqd00rZ0dtVEdrNHBwelNQ?=
 =?utf-8?B?Y0tKWWZvdTc5bEZ4MTFxeGREZUhzS0NYRys3YUt5REQwYkNMSlgzdGE3Z09S?=
 =?utf-8?B?QjJIQVFHOCs2OXBiTEl3WWFvZnZDbU9yckYxSnl6Nm5tM0Y0WW9GaVZJL2Vn?=
 =?utf-8?B?bXQwRk1iMUZxOE1ueHkyVkhvYXNnWXJIaURic1dta3VacWJLUTl2VHpkN29a?=
 =?utf-8?B?Z1NzZmU1VkRkamtZVHRKWTlXWmtPaWszSXNMY25iUHhDOUJ6bmQzcXppNmRM?=
 =?utf-8?B?T1lPN2FYSS84T1dWdlI0Ty94allkcndzbXdqY1Nkdms1Qkg4bXdEOTA5ZHhm?=
 =?utf-8?B?am0xUFF4QzVUS1NmdXVNcWRyNkZWRDdPSGYrUk1XUjgyN1FiRU5Va3pTVUdz?=
 =?utf-8?B?OW1pRzdhWlNUaWlKcS9KaFlOZlVCRTRlaENjUXJvU1BET0xKMjJ4cUsrRnJI?=
 =?utf-8?B?cFZqWW8yNHM1bDZVVDJTdTRkNENWdFJuYlVrV3N6bFppVTNvL1NxV1BzS2FZ?=
 =?utf-8?B?dUFvaE5vZVMza2J2dktjVFQ1emJRRURVL2pSa3BuQ0Q2Qjhnb0wwM0tTT0Q2?=
 =?utf-8?B?cWdJZDgrNUxtZEJsd3ZBVDRLMDlZK0hTOTJrcUVpMnE4UHJPOS91VXZOdlFw?=
 =?utf-8?B?SVorTEszalVQTG1RMXJjL1hkWFBXVnBPUjYwbjRBaUxSRW1RU0FMK1dub0RY?=
 =?utf-8?B?K2s4MHhFcHQ4c3JjSHViUTdtVVhYM0tQdHlqMDRJeGozeno2WU9BOXdJNEVI?=
 =?utf-8?B?WmNJcXJYbTFzVnVTZmdjTnRSdnUrK2dZMzlRTC9Tcm1yWmpSTktsQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b083b371-e925-482f-7610-08df2550bdd8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 15:28:02.6483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t4RTR4Y5DnQz7xX0YAjTt8XX69Wm9VDzf4paSVUaocfRS9varLr9z27hE6yNPStf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LY0PR12MB390394

Hi Théo,

On 9/17/2026 3:02 PM, Théo Lebrun wrote:
> Hello Vineeth,
> 
> On Wed Sep 9, 2026 at 4:20 PM CEST, Vineeth Karumanchi wrote:
>> Add Credit-Based Shaper (CBS/IEEE 802.1Qav) TC offload support for
>> time-sensitive networking on GEM hardware. CBS is restricted to the
>> two highest-priority queues: Queue A (num_queues - 1) and Queue B
>> (num_queues - 2), matching hardware capability.
>>
>> Validate that idleslope is positive and does not exceed the link
>> speed, preventing negative values from bypassing the bounds check
>> due to signed-to-unsigned promotion.
>>
>> The idle slope register value is computed differently based on hardware
>> variant:
>>
>>   High-speed GEM: scale idleslope linearly to the full 32-bit register
>>   range relative to link speed.
>>
>>   Standard MACB: convert the kbps idleslope into the register's native
>>   unit, which depends on the interface width:
>>     - 1G (8-bit GMII):    bytes/sec,   scale kbps by 1000/8 (125)
>>     - 10/100M (4-bit MII): nibbles/sec, scale kbps by 1000/4 (250)
>>
>> Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
>> ---
>> Changes in v2:
>> - macb_cbs_get_queue_params() now returns the idleslope register offset
>>   (u32 *idleslope_reg) instead of a bool flag, and the idleslope is
>>   programmed via bp->macb_reg_writel(), dropping the per-queue if/else
>>   that open-coded gem_writel(CBS_IDLESLOPE_Q_A/Q_B).
>> - Expanded the idleslope kbps-to-hardware-unit conversion comment.
>> - Zero-initialize kset in macb_cbs_add() so an unpopulated link speed
>>   reads as 0 and is rejected; reorder locals to keep the declarations
>>   in reverse-christmas-tree order.
>> - Rebased on net-next, which renamed the struct net_device pointer to
>>   "netdev" (was "dev"/"ndev").
>>
>>  drivers/net/ethernet/cadence/macb.h      |   9 ++
>>  drivers/net/ethernet/cadence/macb_main.c | 116 +++++++++++++++++++++++
>>  2 files changed, 125 insertions(+)
>>
> [...]
>> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
>> index 67150ff03066..00c1c619dea8 100644
>> --- a/drivers/net/ethernet/cadence/macb_main.c
>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>> +static int macb_cbs_add(struct net_device *netdev,
>> +			struct tc_cbs_qopt_offload *qopt)
>> +{
> [...]
>> +	scoped_guard(spinlock_irqsave, &bp->lock) {
>> +		/* Disable CBS for the queue before updating idleslope */
>> +		ctrl = gem_readl(bp, CBS_CONTROL) & ~enable_bit;
>> +		gem_writel(bp, CBS_CONTROL, ctrl);
>> +		/* Update idleslope for the queue */
>> +		bp->macb_reg_writel(bp, idleslope_reg, idleslope);
>> +		/* Re-enable CBS for the queue with new idleslope */
>> +		gem_writel(bp, CBS_CONTROL, ctrl | enable_bit);
>> +	}
>> +
>> +	netdev_dbg(netdev, "CBS: Configured queue %d with idleslope 0x%x\n",
>> +		   qopt->queue, idleslope);
>> +
>> +	return 0;
>> +}
>> +
>> +static void macb_cbs_destroy(struct net_device *netdev, u8 queue_num)
>> +{
>> +	struct macb *bp = netdev_priv(netdev);
>> +	u32 enable_bit, idleslope_reg;
>> +
>> +	if (macb_cbs_get_queue_params(bp, queue_num, &enable_bit, &idleslope_reg))
>> +		return;
>> +
>> +	scoped_guard(spinlock_irqsave, &bp->lock) {
>> +		gem_writel(bp, CBS_CONTROL, gem_readl(bp, CBS_CONTROL) & ~enable_bit);
>> +		bp->macb_reg_writel(bp, idleslope_reg, 0);
>> +	}
>> +
>> +	netdev_dbg(netdev, "CBS: Disabled queue %d\n", queue_num);
>> +}
> 
> So we write cbs_control/0x04BC only on ndo_setup_tc(TC_SETUP_QDISC_CBS)
> callback. As Sashiko pointed how I think that causes an issue with HW
> resets & suspend:
>  - what if configured then link down then link up?
>  - what if configured before link up?
> 
> Also when not using CBS we hope tx_sched_ctrl/0x0580 is at its reset
> value (0b00, fixed priority) for all queues. I would expect an
> unconditional writel tx_sched_ctrl/0x0580 in macb_init_hw(). This
> solves the down/up issue, the speed change and also ensures we don't
> inherit CBS or DWRR from the boot stages (super unlikely though).
> 
> Also, it might be simpler to always use tx_sched_ctrl/0x0580 rather than
> sometimes tx_sched_ctrl/0x0580 and sometimes cbs_control/0x04BC, which
> are aliases.
> 
> What do you think?
> 

Sorry for the delayed response.

I tested the current implementation in the following four scenarios:

1. Configuring CBS while the link is down: CBS cannot be programmed
because the link speed is unknown.
2. Link down followed by link up: The hardware retains the CBS register
values, and CBS is effective again after the link comes up at the same
speed.

3. Suspend/resume: The CBS register contents are lost after resume.
However, the CBS child qdisc remains installed in the kernel and is
still shown by tc as offloaded, leaving the software configuration
inconsistent with the hardware state.

4. Link-speed change: The CBS register values are retained and shaping
remains enabled. However, those values were calculated for the previous
speed, so the resulting shaping bandwidth is incorrect.

I see two possible approaches:

- Retain the requested CBS parameters in the driver and restore the
hardware configuration, following the saved-state approach used by IGB.
For MACB, we would also recalculate the hardware idleslope on link-up
using the negotiated speed.
If the saved request cannot be supported at the new speed, retain the
request, leave CBS disabled for that queue, and warn the user that the
configuration is invalid for the new link speed.

- Explicitly reset the scheduling configuration in macb_init_hw() and
require users to remove and recreate the CBS qdisc. This establishes a
known hardware state, but leaves the installed qdisc inconsistent until
users reconfigure it. It would also need handling for speed changes that
do not invoke macb_init_hw().

Please let me know your thoughts on these approaches.

Thanks,

> [...]
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

