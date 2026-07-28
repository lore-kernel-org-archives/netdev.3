Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011045.outbound.protection.outlook.com [52.101.62.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BC8448399;
	Tue, 28 Jul 2026 13:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785246840; cv=fail; b=aDrvrZaTpbeLlUlUXTDNkq1OtJWsV/mhORPCz/LoncCctljuSZgaQss5BbPa0jZyDmtvkAxQKY4Ki/BlaxnFJhX8sYANHqT3Po1Z4/ZIKGmm9ibU/0zkFNLUtVAGshNOHXEQY9cpIzvVDrS57iGlBem0csJ7Hu5wJbJbF+/0dMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785246840; c=relaxed/simple;
	bh=t9dFHIhYQTJMSfCVeU4elkL92aIbWKQ6mscjSzSDGp4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WjloUDWo7ZBewc8j2fhnvZ/UefbtYlyGowJDLNHmHhDj8irfLrwN4ViC+SYDVNxHnIu7Jb5b4psI6rjDW67laD8mNXv/UJduW6KvjPjZSFVQGEkMQGdfzjnhJAtn8vGbMWRNQwOudD9tctmauGXuhG/Hz3mA8NnC7oiYK5UxmrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=N2aKO1b0; arc=fail smtp.client-ip=52.101.62.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="N2aKO1b0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZJibe4VBp+6VfXGHbv8A9ATKs/1ivK3KqUAHQVnVkcOc4sL/rQ5c3j2IT6jEBp2hTLVv4Lz/IsDa2lVVbg8JE+WbSqEGzNJ0wJIh+e8POUYqK/l4Ni3I3m0zTnA5iR7d2l1kfaYpO//niEtGLqIudQWQ+8f5J6bdrOwUKcqZvl91Tw6Ncn4LIPqlQMmYVI9l5XlAWn7GL4SncBNuWQ5OcV77my/BxXF+NoP54W8aymuquhxh/8cmz13uIrFqRpBir1i385qyM+mGup9dH3Qbcgo8cGS77MMWP6FZRrttFs2cmq8kPjOq27Q8nNXME/fRptdA0se4aKtDEjCSUraUDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3AQ5LtdEMkKPuZQKsWFWR+6p/4kPp3lotLx2UFUiU4A=;
 b=YyhpBijRRJOCYOIsLLFYL6k9voGbxRvyniGTJcK0doMUTkN3fJUfmQZL+D3IiyB+CVuAwG9TwlIG1wQn5Uq7AIphanJqnhpC2RbOAkDUYWcEN49znphayf40oZ4EGDJPAXUEMCbz2fKqge8TfsDbv01qvK1eQB3pxpZo9YNwfI/fWdLnrxoeGEso5/XJW8UxS1eXnXdquB+7+CMMIqk3HnI6RhGD3ek8dDubPY8jJPgP+Ss4FZ5JW1LtVgJxjNNnkWW/2dbR+fkb6oZ6KZh4m0iVbyxLE3z4fghGgD6XjiepdM4cozbir7Ccoj/g6g5A1/SmC7QWcrrUDlYfgEOaCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3AQ5LtdEMkKPuZQKsWFWR+6p/4kPp3lotLx2UFUiU4A=;
 b=N2aKO1b0+7zmC5cRXmuXWhGBH84iJ+e3PSWNN3Jn3Z7/4MLmUK5W9xuHwubteeywGJXAmbsikTahk/dJLFLCUYUI+ArdnBWIAqTkKTcaLZRzorJeo9/Ptm6y8aTbSRjFBkAXLmfZGjLe0fToJwNsUCsAMpwXFinOVewB3xSQ8Xc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8953.namprd12.prod.outlook.com (2603:10b6:a03:544::14)
 by DS2PR12MB9638.namprd12.prod.outlook.com (2603:10b6:8:27b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 13:53:47 +0000
Received: from SJ2PR12MB8953.namprd12.prod.outlook.com
 ([fe80::f3b5:fc98:8973:5c0b]) by SJ2PR12MB8953.namprd12.prod.outlook.com
 ([fe80::f3b5:fc98:8973:5c0b%4]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 13:53:47 +0000
Message-ID: <698326ba-b99d-4f76-b5ee-b18368567004@amd.com>
Date: Tue, 28 Jul 2026 19:23:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: macb: configure ENST registers for all
 queues
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Vineeth Karumanchi <vineeth.karumanchi@amd.com>, conor.dooley@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: git@amd.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260724043257.2221030-1-vineeth.karumanchi@amd.com>
 <20260724043257.2221030-3-vineeth.karumanchi@amd.com>
 <DK701YU8OWST.2CDXDR5SUJYJQ@bootlin.com>
 <3924babc-9755-46ce-97b2-bd6dfce6f6c6@amd.com>
 <DK9C9GO25PN0.2LNMTZAHHUNF8@bootlin.com>
Content-Language: en-US
From: "Karumanchi, Vineeth" <vineeth@amd.com>
In-Reply-To: <DK9C9GO25PN0.2LNMTZAHHUNF8@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0244.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::13) To SJ2PR12MB8953.namprd12.prod.outlook.com
 (2603:10b6:a03:544::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8953:EE_|DS2PR12MB9638:EE_
X-MS-Office365-Filtering-Correlation-Id: 7604132c-f0a0-4623-4adf-08deecafa565
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|4143699003|10067099003|6133799003|11063799006|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	xOqEDc1nHlqUZQmI2kq1rCyWRQlLo1gY7tBinWy0FatbeGiKVzgW81nPL64HhgquFG0ktXL5w1/TFdsEVTE4fAlnsGMGFmgJUk1wThGn4WnRcthCw0xBn9DY1yAdG8YRr477yj/DKCNQ8Mwp/DuxgevWup1BbSlE03U4ezZso9EXhP85Mavaqi/aJjKON80QIsJ8UV42baq/4BK/xLD5Uhc/+1Qz9IjAY2RK7C4GJYZFOgNFHi0PXz/BoFKifQkdp8eNV77H6qhFcthSnnCNO/Jl2XBiXV4pmrOfvRohh8O5UeQ/r4q+a0wMeQKC6KHgBjDGgzuIYX7ZZq8zCc8+nuOOw+Pyyz43LCOc7ABNAxSAZZwAqEHkNBvFiJeQ4/aJCJypHuhdOodk8fK0xSBEK8BCo8neHcJxeWNjxVl0rSXlJKqvUTS99HG7yMbCGYXFLiPhyCOXeVyzMbzMK5i/oZBdBPGZSZXRxkfeS6SeoDCwdtzpOs4f0PthD7xGMbPt31TGYwM5nMyPx/rTJlHlfbFBLMlwPk7mK05IavoQhYsds78pKYhdfjxGFB1t6QwjhZ45zp/aWsUvExt+h96rmGmaCBf9nfXaEkjuYW04H58=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(4143699003)(10067099003)(6133799003)(11063799006)(56012099006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Sk9wVWQ0ZlF0STFkZVNoTVp6bzBDQXViMXJHOEU1NVlsaDNuMDgyaTdMcU9L?=
 =?utf-8?B?Q3N4V3hnQ1ZRUVJlMW1FWEdrVVkvOGlnL0phSW9zZ29qTkdTamJ3NS92Zm4r?=
 =?utf-8?B?ckluaGFrbHFCMnkwMTN4S09KeUhoMVh6bE5rRzNIK0pXczJ3My9sQ3RWcFZm?=
 =?utf-8?B?TmIyQ1hmbm1GUktWTTI4QW9kSHBuUUFYbDUycERCd3RRSjdhZUhQU3BXUTdw?=
 =?utf-8?B?TXBadFZPQlF1dEY5a3UrTHJsZkM4Z1oyelhHZkZFVGI4R0JxV0NSaERVRjJ0?=
 =?utf-8?B?RlF5RmdPSXd4cm1XSzBRM1lEb3JFbEFuV2pLRDRMaDZEZnZtbitUeWhaay9l?=
 =?utf-8?B?aVVURkNabjk5Q1FMTFNpVHV4bSszUmNINWdrQXI5eUNwMWlJUHFpU0RLbzJr?=
 =?utf-8?B?RXZLTzhzL1VRZDEweTQ0U0JoOE00eEVPVE9FOGtyUHdnVHBoZHpqamRRdnVa?=
 =?utf-8?B?Z3hqVjcxdmpRTW9RQS9OS3BVY1Bwa2RFc0tieWNpVXZqMFdBRXcyOTBNSi9Z?=
 =?utf-8?B?dlBXVHBoaDNqUUdBMHVmR3hERVZuSEd6RmVLMktndlpnQVZ4S0JXWFQrNXEz?=
 =?utf-8?B?SkFtc09vdFo2bi9BRWQ3MlJ2eFpRSDV2cktkUExZakY4Q1FidE04SjJlRGpF?=
 =?utf-8?B?cUNEZUl6NC9Jdys1REtsVHV0MitoeDdLSDZSTTJWc212U3BXWUsxcFdKYnlG?=
 =?utf-8?B?VWJpZHBTV1UwNHl3MzJWUEhJMDhWTnFXOFVWN2kwRWJyUlVrSWtCZEVNRGRQ?=
 =?utf-8?B?bHF3TlJSYkNBZUxwdFVuVzhZcTFQT2Q0Q1FXb3hpMWpna3hGYVdjTEpRUjZr?=
 =?utf-8?B?aVhwN1l1TnkrNUVpL25RS2gvUHY3ZzBRR3dNZ2swZTJaNnNVYUdQOXVnNVdz?=
 =?utf-8?B?RjRTM0NtWW00N203TVFadlFiNXhwZFBueXgwaUU3ZTVmRVhGYkdsMy85Q1Mr?=
 =?utf-8?B?d1F0S0tscHF3YWdnLzZSYm1Mb01XQ0hjMHZtdWowRlFqUFF0L2U2MWhMZ2Zt?=
 =?utf-8?B?ZDloWkU2b3UvZ01xdnNPcENweWMzRW1sQUlWZkJraHVYNFJJQlpXU3FDR2xP?=
 =?utf-8?B?MEJqY1lmczJRblVyVldJNnJvcWVHNzlOdHRReVUyZmtaSlY3a2dmYkxNanZx?=
 =?utf-8?B?Zkp2am83VFJFVlFQalpSZzVGL0R0TWtuZ0x3RzNTN2hCTlA0OTFLd0UxbEhz?=
 =?utf-8?B?NVFlK0RvQTR5TklpRE9IZGV5VTVYdDlRSVVZVUVsK3B3Y0wxa3NPamZ4Q2xV?=
 =?utf-8?B?UER5eFBlUFN0dFJEcTRkL1BJLzlmUGtBOVhzWlc4ZDdTMDUxcXhzUG82Zk1J?=
 =?utf-8?B?dy9KZ1RLaGduNXFGR1prRVF5aHRTb3lkUHdjYnUvT1locU9BRzJ6UWpEb2p6?=
 =?utf-8?B?Vk1TcTFzRkxheUFwZURodE5RMUJLWlV6cVBPODkwdXUwQ1VRRndua0M2RW5X?=
 =?utf-8?B?YVZ6eCtrcnZjN1IyMjJiTytCTW5KUG16enBGcXh5Mnh0Y09CSWtCR1RxYWx4?=
 =?utf-8?B?Z3ZIOS9jdlZJYWtNYTdzU2VoMUhBOGR3VXZZaWJrNmgrQlNoZG9iZ2lyaWZR?=
 =?utf-8?B?RDFqSWFla095b1h1N0tGbG9pdmN2d0pCdzRieHdLd1hqOFRCbW56YXpHT1Fh?=
 =?utf-8?B?YW1ZT3ZPbkorNmZLeklyT3JwVnBUVWdKTnRkNmRaYi9mcXFDMzMvRVh1bll6?=
 =?utf-8?B?NWJ3OFc5YVkyMGg0VWJVMkpmR1NHZkRrNSs1am1qL0dUb3NwdThUSlJSdnZT?=
 =?utf-8?B?SVFTZXRBOWQrYVUrcWhGL1BRUjRyMUtXU2gyNW1meklYc1lRSlZ2UnNkSHQ1?=
 =?utf-8?B?VFd2T25kQ2dCUlFCc25qcmpSQ0dxcFBtNFp4dEExcklmeCtQODhscGRvSnFI?=
 =?utf-8?B?WEFYTHN3c3hnUTZRTlhqWjZwTnlHTkVLRnI5K0JaTW12R1c2Qng1QTV0Tktq?=
 =?utf-8?B?RlB1bEZ3NW1PSko5TjhXL05iTlU0cHVqUy9pSmliaGZ2ZlMyYjJGQVBnM3Jr?=
 =?utf-8?B?NWFpZExscUtQVEplb0d3aktPWmxtWmp2amR2SWhnOWFkaHFScGhldWJ2S0pk?=
 =?utf-8?B?Mk1uL1dlc1FLd1F6aCsyd3dWalhTcU9PRDlSOUJlQkw2ZWJHdEhDbDJCR0NY?=
 =?utf-8?B?dVcxdmhSYVkyVUNZaFNaenhSV1gwQXo1YWRyUjhBVmdEYnE1Szd6MG5jcDVY?=
 =?utf-8?B?dk1VUHFjVmJlK2xiMk52c21zWWpkQ24rdUEzVkJqcCtmVVpvMm1rYlZzbjFF?=
 =?utf-8?B?VjYrdjdBUnJrNTY3OXJsTy9PNUozZXFKMEtWc044djFsVkQxR1c4OElqYWxx?=
 =?utf-8?B?UUVESnlIdkJjSklXSWgxZVhYV3V0NVFIU2h5bmRhNzZyU2ZHZ2VYZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7604132c-f0a0-4623-4adf-08deecafa565
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 13:53:47.6020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xkSEOzMaKDbqNRMfPTVMYk7P8SVWPJc5WOLsjgsYj9wJ7xYKtLfaKMwnrsnjbruW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9638

Hi,

On 7/27/2026 5:35 PM, Théo Lebrun wrote:
> On Mon Jul 27, 2026 at 7:32 AM CEST, Karumanchi, Vineeth wrote:
>> On 7/24/2026 11:36 PM, Théo Lebrun wrote:
>>> On Fri Jul 24, 2026 at 6:32 AM CEST, Vineeth Karumanchi wrote:
>>>> The initial "tc" command was not overwriting the reset value of ENST
>>>> registers if only a subset of queues were configured, leading to an
>>>> invalid setup. To fix this, configure all queues unconditionally.
>>>> Unconfigured queues are zero-initialized via kcalloc(), ensuring a
>>>> complete and consistent configuration.
>>> But if a subset of queues are configured, the remaining queues don't
>>> have their ENST support enabled thanks to ENST_CONTROL and their ENST
>>> per-queue register values aren't read? Or HW is broken and reads ENST
>>> registers anyway? Or something else I misunderstood?
>>>
>>> What reset value of ENST regs you observed that caused you trouble?
>>> That info could make it into the commit message.
>> //
>> Yes, this is a confirmed hardware issue. We raised it with Cadence, and 
>> they have
>> acknowledged the problem. The reset value of the |enst_on_time_qX| 
>> registers is *0x0001FFFF*.
> 
> ACK. 0x1FFFF translates to the max value of on_time. Important also to
> note that off_time reset value is 0x0 according to the manual. This
> combination probably explains why queues feel free to emit whenever
> they want.
> 
>> During ENST initialization, packet interleaving was observed when only a
>> subset of the available queues was configured, while the remaining 
>> queues—whose
>> corresponding |enst_on_time_qX| registers still contained non-zero 
>> values—were left disabled in |ENST_CONTROL|.
>>
>> For example, in a configuration where only two of the four queues are 
>> enabled,
>> some packets from *Q0* getting transmitted during the *Q1* time slot, 
>> and vice versa.
> 
> This description isn't enough to fully show there is a bug.
>  - You say "only two of the four queues are enabled" but did you mean
>    "queue enabled" or "EnST is enabled on that queue"?
>  - EnST enabled doesn't mean the timeslots don't overlap, this is one
>    allowed config.
> 
> Maybe it's not a bug? What behavior would you expect when EnST is
> enabled on some queues only? When should queues without EnST active
> transmit their frames?

We observed the following ENST behavior on a GEM instance with four
hardware queues, where all queues are enabled.

Initial configuration:

- All four queues are enabled.
- enst_on_time_qX registers are left at their reset value (0x0001FFFF).
- Configure only q0 and q1 with valid ENST schedules (Non
overlapping)(T0 and T1, respectively). ( enst_on_time_q0,1 and
enst_off_time_q0,1)
- Bind traffic streams p0 and p1 to q0 and q1.
- Enable ENST only on q0 and q1.

Observed behavior:

- During T0 on-time, both p0 and p1 packets are transmitted.
- During T1 on-time, both p0 and p1 packets are transmitted.

Configuration with fix:
Additional to the above configuration, we explicitly programmed the
unused queues (q2 and q3) with:

- enst_on_time_q2 = 0x0
- enst_on_time_q3 = 0x0

With this change:

- During T0 on-time, only p0 packets are transmitted.
- During T1 on-time, only p1 packets are transmitted.

It appears that leaving the ENST on-time registers of unused queues at
their reset value (0x0001FFFF) affects the scheduling behavior of the
configured queues, whereas explicitly programming the unused queues with
0x0 results in the expected ENST operation.

> 
> Please be exhaustive in your future commit message; thanks!
> 
>> Furthermore, once the hardware enters this state, it does not recover 
>> even after a
>> complete ENST queue reconfiguration is performed.
> 
> ---
> 
> As you contribute to EnST support, you might be interested in a bug I
> just noticed in the enst_ns_to_hw_units() implementation. It doesn't do
> rounding properly.
> 
> Eg ns=100 speed_mbps=100 => 2 units of time but that is 2*80ns=160ns,
> whereas one unit of time (80ns) would have been a better choice. This
> example is the worst case scenario (the closer we are to 1 unit of
> time, the worst the bug is).
> 
> ---
> 
> PS: please note your email formatting is off because of hard wrapping.
> It's well visible on lore. Email is still readable but less than optimal.
> 

OK.

Thanks,

> https://lore.kernel.org/netdev/3924babc-9755-46ce-97b2-bd6dfce6f6c6@amd.com/
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

