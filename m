Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.62
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792430499;
	b=UIWmrF3T6uvAXxIlUswHP8o8fkEUELN3uaMCt9Q4SNEzx/KVuzc39gsRFEoCFIiAFSI6
	 r8KN4hCkzfkNLsW8X1qRzopBrC4tT8yxWuFqANaNWpAzt6kK/JT7e4P4OcEuu5nQHiCvX
	 jdJUjwr22FHjgBnsBLSuDtIuayh+mri5xaIwIrQx9pAaCdeTVMGyaDHuXPU97JXYs6xJk
	 cTxceTbdbqAl7AQhN2V5a6+VyJndOi9BfC09qkSnoETwOT2HYhm6cwAXfbSjDwYyxDZ2p
	 wygRSJcOcRHoCi7JlvoOhfD6weU7wOu39bghkS429e/GdBh3FvuxjvEkFkaiKz6OPsg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792430499;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=XuUb8J5LVKigwqZiNxBsQvDkdJW9yLGEs+F/xEoaR9k=;
	b=I7rYdHQgboyJnW895/H2MTYpaf0/O8RD9Ezy95PEOb2gGacNY3GQUX8+6DZZEmI36aBy
	 qC973atQuU8HTEDUQR6rDzWB7cNIPm35TnTMMMhzpDsdXMQWiCURQE/O5NGI1LvxpZPb3
	 EkiMCpIueiNweoTBE0z60HcwQfqamTIDcJx566WWs6AWvkwFRMl9DCyGk9Ay0PHgQFxJ9
	 JHjS+OBtCvhQsDje58waWAztISmM1Nf1LS7r8NoV3yCUTSnL/xrwMAK7gk3AmxY6jQvsC
	 RvlR5STD46/HUfUrJqlK8io4YQPTq5NcaqJLZ66hf2p2Qr+BlUtVtLKDovJfC88Vv+w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=jHwmN9js;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.62
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011062.outbound.protection.outlook.com [52.101.57.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95121606A31A;
	Mon, 19 Oct 2026 17:21:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95121606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=jHwmN9js
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e66NC0gH7aTS4/V4CxrMKs3IT4qpClgbIvorY+eh9o6zy/mpGveSRr67epxIPUgH/+VyZsaWzD3PiPYNfuJ+S108hYKMfuJiaaRHmWTAahTHkfgqSP5/i0ljeoKoJCnON5K98tp3KFZYKgznZiF3/bzcvfM2l8J571R4/nDvQkr2/Emm6T9pfyq+kuYvIQyGOPdSHfAzg8+4xL74M8298K0+g2m/f6/IMZQn0jwxuCk94jdv55h0vDCOhD0Lvpz6DV8a9xZbOgWERT+qDL5AloPlnhw2LDMXKSVLgfFp5xoonWTpI6voC6iQ2UD2540RMPOj2AbF1zNkoZ0M5ldWNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XuUb8J5LVKigwqZiNxBsQvDkdJW9yLGEs+F/xEoaR9k=;
 b=dSs97m2XbggJts14gOA/uumB71f/tV5rWa+aUGuvAp9kQAmcFVv8L6UFS5k4LOFqa21ZTr8fmUOf7tCSfvu9YF53aAKsIygnchg5GynH1fXteKakb5epGqET0noQJrjVNnbZodXL+V6d0uno3jyr8xhc8/5m+y1VdnbUl8VENhc+kVFm9ybCtHThJKQv0OTLC71KoiAPnwUIAJ1/vaVWRIYWThVOW42bXfJONYpnpwNtnTskvcqCT65UPUuyVRe/gbItmUZ4ca5HjFgzDLiE+LdQthHgax3COx9Q1Zkx51D9hNzTQ20eAxcaW54n0N33tAY/tDWDNsJAQDiVraMO0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XuUb8J5LVKigwqZiNxBsQvDkdJW9yLGEs+F/xEoaR9k=;
 b=jHwmN9jsXWkFl7A/rKPaXd7kU8ylRxCc2rroq5ks8E/TG0vNxnS96TJBKnoDu7J5NdrvuyIwk9KCDOt6AmhFXTfeauSs3vP9Bpxl1h1/P4e+FKUOOfp1UWBAjFkC8sWxi3NHYkXvPr1V6j7ISjvtU3M6gSaAnJefetu068uEwmM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4283.namprd12.prod.outlook.com (2603:10b6:5:211::21)
 by SN7PR12MB6887.namprd12.prod.outlook.com (2603:10b6:806:261::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.17; Mon, 19 Oct
 2026 17:21:35 +0000
Received: from DM6PR12MB4283.namprd12.prod.outlook.com
 ([fe80::9eab:812b:ad20:6087]) by DM6PR12MB4283.namprd12.prod.outlook.com
 ([fe80::9eab:812b:ad20:6087%6]) with mapi id 15.21.0522.013; Mon, 19 Oct 2026
 17:21:35 +0000
Message-ID: <64c6b4be-4467-4ac9-a7aa-528a9f00b8ee@amd.com>
Date: Mon, 19 Oct 2026 18:21:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/2] sfc: ptp: serialize host and MC
 synchronization transactions
To: netdev-bot+sashiko@kernel.org
Cc: ecree.xilinx@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, alucerop@amd.com,
 pieter.jansen-van-vuuren@amd.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261015114104.2531624-2-alex.austin@amd.com>
 <179241111900.3135.15377803717583250573@kernel.org>
Content-Language: en-GB
From: "Austin, Alex (DCCG)" <alex.austin@amd.com>
In-Reply-To: <179241111900.3135.15377803717583250573@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0039.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::18) To DM6PR12MB4283.namprd12.prod.outlook.com
 (2603:10b6:5:211::21)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4283:EE_|SN7PR12MB6887:EE_
X-MS-Office365-Filtering-Correlation-Id: 85d1a074-3017-47d8-ba57-08df2e056ce1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|56012099006|11063799006|4143699003|10067099003|261009223027099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	+kwV6+kM05NC7eyxhoonURWiuNimLTZwKIRalsMrl0w9ihvJMIBztbcgbNTo+I7ho3bZ2bLcQlQYbnwk34ol/ZaVNsCIjS5yfvCAqfVWc+xRBPCvh4lntVpqYAvY0pzgi4Rjc6fzSPvbt9gZ+7NpGr7l67gphDX1NiT+j6xqMio06ihPs/ZT4sEYxLOl78IDYQq4BPD70fXWpqmqMyU3/pxzgdpU2yp3lyopU9tTK68YX5kifLTJyWHtE8dyEXjNDcqMlkduHhwa9LLfvEBhRVK86euVw8/SpQ+slo0Dchkt9QmZTqefuifg9CabqIhSnJuxkfuWCj2N71u3zYej5Y3FnVYmBfhLWn0QI2Yu3YMLofPxZuH5MI83q9Ixan26tc2NuB3Gg1ifbXJbcl4YKWLIvoWmlw10n6SWoUxxvRnLFuz5MLeIiBvxxuEppZVuaSeTJ7wpZUF6y7UKfGYf0OGTCdPV4fT6A8+Tqd9SE1kn00/p7smCpUPZsSnfKHAY0mzpekV1EeKP5VYOqQfTnDy5K5tA3Iw1rK9jQP5EMX9cjHQGpoThfL6/vOfC1LVPv+vIj/LMmVEucoCGWfx7eZstKN888kD0r2zOepFyndY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4283.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(56012099006)(11063799006)(4143699003)(10067099003)(261009223027099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K3RDejkwZXJEQURhMytlNUdPdEd6Mnh6YU9FQWVIVUhGa2o5Y3dxUmZZWHYy?=
 =?utf-8?B?VllOK2ZPWkxMMEpvYXZGYUZOMVhHTC9oSWZYV0o0RlRVQlVtcmVVUHQ4YmVQ?=
 =?utf-8?B?cnZCbmM0V0hNd2NHUGpreURNc3YzaDNzOHJuNUZnQ1Y1MGhUdG90eUU3QmN5?=
 =?utf-8?B?VEkza25VWTh1UEhhVWUyWEwrY0p4NGFMY1JNckZwUjRwcW5JSkFrMW5uamQ2?=
 =?utf-8?B?NTBheWN1Vi83KzNiTmM1YUFlV0lpZHFEY1BjbnZRaENpN0oxU0hiU2l0K04v?=
 =?utf-8?B?QzZ2MnFlQVhoNWNvVkt3V2p6QlFoazR5N0R4RE5Qa2ZvRlNCeGJocFlzSC9L?=
 =?utf-8?B?WllmeDA1TnA4WjlIOWx2ZDJhQjlUaDZQRnU2U3dRa1VjNjZwbEhEUys0cUZz?=
 =?utf-8?B?ZjB5QzAyZ2puL013bThXNkp1UWNTb0ZRUUswYlBjamNHODVrYWw3cmNzc2NN?=
 =?utf-8?B?VURMWndTVWVFaTB1S0htdTNIRHk5cXVLc3E5TmI3aHBteDdvQzZqcUpQRHVY?=
 =?utf-8?B?VFZKS3FrSlRZUjYwdjRhSTFSL1liOU9makx3RjNjaHBscnU4eVhWWG90N2Yw?=
 =?utf-8?B?Znl4blVqcTNKUkphSDdIMVRkZTEvTnk4cDhpSzVVTFFpL1czYy9SbVF2aGVh?=
 =?utf-8?B?SUJEZlM5dHhhTzVQVDRSNkIxS2p5eXVLaXFuN1RPazNkTXdrbUdRUWpvazh2?=
 =?utf-8?B?cUovMHZ4cm5WWTB0a2dwRnRqd2I3and2YWtBQ0NuS2tuYWJKTUFIMGhKSHZr?=
 =?utf-8?B?anIzc3h5ZXN0aDVtdWdrbERVcUliRUkzSDhGOTRFS29EOWNtOEw4UXVScHdw?=
 =?utf-8?B?RnRxWTY0VFVXeDZFeTZ1a205NkpMbC91RVJ1aFM2Si9lVXlPZGpqaEtTU3ph?=
 =?utf-8?B?aFBYMXBPYjFtam9xN0ZMMEJwclNzbG8zSnpRQ1R5eGNYZFBkNXNqUXlOKzdu?=
 =?utf-8?B?QnZaQjVpaWxKVHIwQS8vek1uT0YvS1RhQmVCRlZzdWdlcHBRNXYxU09ZbE0w?=
 =?utf-8?B?VUs4SEU4eHFodGhUeUtsUFcwc3RrVVh1MWdoL0FsWHRWOVUrWXEyYWRLbUty?=
 =?utf-8?B?L0dnS2FsbHFDR1V4ZDh4bFhMemFBL0dodTRrdmxvbzhYUGhyR0ZpOEg3eGc2?=
 =?utf-8?B?eTNBcnI4UXJ2dlArMys0MWxHL1FFQ1I1WnJKS1ZaUjF0ODQ2UGFsV3VGWmhw?=
 =?utf-8?B?T1RLVDllSForekc5ZmNRVjliTnJ0R1VTSmZ1RTdnM1VvVDRkV3RrQm5YU1NY?=
 =?utf-8?B?Sks5N3lYNC9kb0UyODdPbUFqUFFmc0RXS1F2VkR0WTNGdUFteVcyK3B4QjV2?=
 =?utf-8?B?QWhEUFlkMG1CVnZhdmNBQWZYVXRaNHRGcUdWZ3FEd2ZFdm9FQytrSkZRZjNl?=
 =?utf-8?B?aEpYMkFkWEw3dnNQYXZsMSt0RDdqbjJzRml5Y2E3K25oa3ptUDkwd21ML3Q0?=
 =?utf-8?B?RXVBZ1pWanVjY0VmemV5ZXFlZmVWUUo5Z2ZOV3dQQmJQU2c2NjFiOFRsYmRv?=
 =?utf-8?B?SDFBUW1Fbk9IeHlreVh5SzNMNkN2NTBqdHpTS0hPRjVENlJlQktJWDBBcUx4?=
 =?utf-8?B?SzJEMUt4d3dJM0VwUFMxbWxaZlM4a2hZWDlEczRmZ2tITTZYNklYRG1mVmxm?=
 =?utf-8?B?ZGNoeXRiWHlxbkkvcU1YbzNtbXBzY3FMTXVGaWZFUnRQM0dTQytyNjhkMHQ2?=
 =?utf-8?B?YkY4a2JSTUxnQmY0M3dGTnNLblgwbkNQdEdQNldPd3piTmROYTZFV2JiVnFz?=
 =?utf-8?B?N0xmWncycnBRM0pTSmpmYXN3U3dkZ283NjUvYitKSGZJWHlJTkIxVXBRNTZS?=
 =?utf-8?B?RldOTEN5M1Jnekk0MWk1QWxoNW04V0tpTGtENjd1YjYzL3ZJK3ZITFVLMlZa?=
 =?utf-8?B?akIwZEpwdjk1Z3REV1hIaG11WlV1N1dwaFJkNkhEb1FkQktJZWgyV1A4Z0VD?=
 =?utf-8?B?YUo3WGFHYlRTMHQ1RVlFTHBSRkhPZXExeE9yYitLNHBjWlczVnAzWGd0ZXY1?=
 =?utf-8?B?TWVxQVZoN2Q2RExjQUtVVGtUNUg5UG9hWENobkdrSW1HcVhScy9nb2hKMDZi?=
 =?utf-8?B?WFQ1YlA2RC9xZW1sdGgvTEpxOUNETFdaZDFDT3crc3NocnU0VnR5ZDBwTjU1?=
 =?utf-8?B?YW5NUlA0UWVlWjFvNEN2MmJoWTVxQk5IdVZLUWlBMnE5bnZMeDhwcjNYR0VM?=
 =?utf-8?B?SXdJdDlTc2NhNk8wdjAwNmNuOEUzY3pWbTBVVTBodlVCU3pBUmhaZGVnWFox?=
 =?utf-8?B?cWw4YXZ5SGZRMk1wRmFsbUNYaFhOMlk0ek13YzRNQWFYMjZ6VlM2U3NoRWNa?=
 =?utf-8?Q?WadSlu452uwXKRRmLJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85d1a074-3017-47d8-ba57-08df2e056ce1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4283.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 17:21:35.2417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: luUo0TtBYBmbSr5a7Ojb8ctFOKKok/JlaEqDKmj6xDviqjRnsC56kbdxHmuBR8iXq4hSXcuppzl7I3ApFPemTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6887


On 19/10/2026 12:58, netdev-bot+sashiko@kernel.org wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> Thank you for your contribution! Sashiko AI review found 4 potential
> issue(s) to consider.
>
> Critical: 0 · High: 0 · Medium: 2 · Low: 2
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>
> - [Medium] Incomplete fix: the Siena sibling driver is left with the same
>   bugs.
> - [Medium] efx_ptp_start() sends MC_CMD_PTP_OP_ENABLE through
>   efx_ptp_enable() (line 1460) with no lock held.
> - [Low] Resolved later in the series (baseline decision: false).
> - [Low] The new kernel-doc for @phc_lock in struct efx_ptp_data (lines
>   276-277) says the lock 'Serializes PHC commands and synchronization,…
>
> --
>
> sfc: ptp: serialize host and MC synchronization transactions
>
> This patch adds a phc_lock mutex to struct efx_ptp_data. The lock is held
> across efx_ptp_synchronize(), the PHC adjfine/adjtime/settime callbacks,
> and the current_adjfreq reset in efx_ptp_start(). efx_ptp_synchronize()
> also now bails out when efx_mcdi_rpc_start() fails, instead of finishing
> an RPC that was never acquired.


[...]

>
>> @@ -1027,11 +1038,14 @@ static int efx_ptp_synchronize(struct efx_nic *efx, unsigned int num_readings)
>>       MCDI_SET_QWORD(synch_buf, PTP_IN_SYNCHRONIZE_START_ADDR,
>>                      ptp->start.dma_addr);
>>
>> +     mutex_lock(&ptp->phc_lock);
>> +
>>       /* Clear flag that signals MC ready */
>>       WRITE_ONCE(*start, 0);
>>       rc = efx_mcdi_rpc_start(efx, MC_CMD_PTP, synch_buf,
>>                               MC_CMD_PTP_IN_SYNCHRONIZE_LEN);
>> -     EFX_WARN_ON_ONCE_PARANOID(rc);
>> +     if (rc)
>> +             goto out;
> [Severity: Medium]
> Does drivers/net/ethernet/sfc/siena/ptp.c need the same fix? It has the
> same code, and every problem fixed here is still present there.
>
> In siena, efx_ptp_synchronize() clears the start flag without a lock. If
> the start fails, it still goes on to efx_siena_mcdi_rpc_finish():
>
> drivers/net/ethernet/sfc/siena/ptp.c:efx_ptp_synchronize() {
>     ...
>         /* Clear flag that signals MC ready */
>         WRITE_ONCE(*start, 0);
>         rc = efx_siena_mcdi_rpc_start(efx, MC_CMD_PTP, synch_buf,
>                                       MC_CMD_PTP_IN_SYNCHRONIZE_LEN);
>         EFX_WARN_ON_ONCE_PARANOID(rc);
>     ...
> }
>
> efx_siena_mcdi_rpc_start() can return before efx_mcdi_acquire_sync()
> through efx_mcdi_check_supported(), mc_bist_for_other_fn or
> MCDI_MODE_FAIL.
>
> The siena driver also has the same two concurrent callers,
> efx_ptp_pps_worker() and efx_ptp_change_mode(). Its efx_phc_adjfine() and
> efx_ptp_start() write current_adjfreq without a lock. Its
> efx_phc_settime() still does gettime and adjtime as two separate steps.
>
> The Fixes: tag points at 7c236c43b838 ("sfc: Add support for IEEE-1588
> PTP"), the original code that siena/ptp.c was forked from. The commit
> message does not mention Siena. Should there be a companion patch for
> sfc-siena, or a note on why Siena is not affected?


 From inspection, it looks like this issue or similar locking issues do
exist on Siena. I think we should take care of Siena issues in a
separate patchset. Additionally, I don't have a Siena NIC handy to test on. 

[...]

>> @@ -1446,7 +1462,9 @@ static int efx_ptp_start(struct efx_nic *efx)
>>               goto fail;
>>
>>       ptp->evt_frag_idx = 0;
>> +     mutex_lock(&ptp->phc_lock);
>>       ptp->current_adjfreq = 0;
>> +     mutex_unlock(&ptp->phc_lock);
> [Severity: Medium]
> Can a frequency adjustment still be lost here?
>
> Just above this, efx_ptp_start() sends MC_CMD_PTP_OP_ENABLE without
> holding any lock:
>
>         rc = efx_ptp_enable(efx);
>         if (rc != 0)
>                 goto fail;
>
> The firmware enable and the cache reset are therefore not one critical
> section, and efx_phc_adjfine() can run completely between them:
>
> CPU0 (efx_ptp_start)            CPU1 (clock_adjtime ADJ_FREQUENCY)
> efx_ptp_enable() completes
>                                 efx_phc_adjfine()
>                                   mutex_lock(&ptp_data->phc_lock)
>                                   MCDI ADJUST with FREQ=X
>                                   current_adjfreq = X
>                                   mutex_unlock(&ptp_data->phc_lock)
> mutex_lock(&ptp->phc_lock)
> current_adjfreq = 0
> mutex_unlock(&ptp->phc_lock)
>
> The next adjtime or settime goes through _efx_phc_adjtime(), which
> programs the frequency from the cached value:
>
>         MCDI_SET_QWORD(inbuf, PTP_IN_ADJUST_FREQ, ptp_data->current_adjfreq);
>
> That would put the MC back at frequency 0 and drop a correction that
> adjfine already reported as applied.
>
> The commit message says current_adjfreq "cannot be torn by the reset in
> efx_ptp_start()". The patch prevents tearing, but the cached value can
> still get out of sync with the hardware. Would phc_lock need to be held
> across both efx_ptp_enable() and the reset?
>
> Also, efx_ptp_enable() treats -EALREADY as success. In that case the
> firmware probably did not reset its frequency, but the driver still sets
> current_adjfreq to 0. Is that intended?


This looks like a real issue. I don't think we need to reset
current_adjfreq at all - will respin.

>
> --
> Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015114104.2531624-1-alex.austin%40amd.com


pw-bot: cr

