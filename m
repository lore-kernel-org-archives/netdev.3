Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010054.outbound.protection.outlook.com [52.101.61.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1138E1DF75A
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 08:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788252546; cv=fail; b=nRmI4UaHWFMZlvJxZFEY3WuweSZNEw2huBXw7VFb87BCjjWBzWvUXX8XY18Zpp7zb1BDdsmpBzICdSl96kz/nbCJG1dUJzvw+kOqDQbS8SmX2EpiR+msEk5SLHmKJX9HZp8pQCj3yWKfWkwtfl+QYuJqaN8jA3OlJZJuvR5rNzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788252546; c=relaxed/simple;
	bh=LpZm/Ptn0+x0Ys3HAsZa4+e1JNTYPyxGjWx2WzpadNE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AqxOSTr8OAwqyG79I6IbP6zhIw2VfgMXtaBc0oIkM9fzIX0OUx1BvxWSO7jsSoE0uA91Kzyzr1S1QR5bhyL0Fg2SeANnddiceYVrSY2F3/++0BuLPY7IhEwLaf6c7LdyiN8/ptN4Vj8DzGmHJfpd2/v6c9vJsOIuGOOQaHcbpQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ixYS+qP1; arc=fail smtp.client-ip=52.101.61.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ixYS+qP1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fhmTtqXWS3c/y1sjJEaJ7rfOx1s1949xtgCSifprUu255MtX6jiXnUc5ZZgyN8Z8QJSn2ZLMr2w1OVl2FhsBWxS7M01F78GiB1DSlquQiR36hB1bth4uhGKIFrcpCM9t3me+bzuzHkqEfrOhw5YTkDuRILg3Jf2HbkPTQZH3DeWYMTHE3mU3whfTv1SgH998GnWCt/qUg2I/8mfzl4pNq1tpqu9mZW27Mfnor9QXkDQ0Y5Xsyvd261qAH48xjtT5/B9KYtEXYt0G9PYo7TeGUZ+LBWgJ3bogV3+6jxsHXFh5zlOYLy0+mW3P8REkG+1ly3I9RhmwecwRHuaZLYfDDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CquEn08pAPDi+kWh9dAz+G9z4vzehSqdgO5EP9c2yjs=;
 b=P6Lgh+BZjBd+P5eF9s9LYknGq7mzj4LFmzejdaaHp9rpSeFwBG+I3Y9Pg4ZTq7SIRkssKfes8e+ZROtMVkoZSTkn7Ym3QlO9yDdKjEg0KRFPuW+Tfvp8pP9PiQxIKBXbP7ZfGXOs5O8DEUDdn1NgbTK4NHku0nxeQkeXbgMv3x5UYdiGJ0FpL6kR1OoW24hrLUYJDhwBp6u9y5jp+0dlspNpdmtadIFrV+Xw/ZHMp38yCK0NWiG9QYinahK8pIKZT1WV1+zm1Z8tjCeHqo4AWGLduxGW2J1zABhpGlmh5z8wzChJkNA4CJgMZIW11waXL1ujd2pOSR6vV27wYIVWAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CquEn08pAPDi+kWh9dAz+G9z4vzehSqdgO5EP9c2yjs=;
 b=ixYS+qP1bt8bvefUZ3Lb1UgwCgtp5o7wyVEg9aD1I0CTHzrPqRd1T1/AFs/10H1XypEHDNKv4eV3CKV5bxv4SmqgDzz7wFFBqi061CZyB/cWftuq2fSpfN+YDF4e9d/Dv1ncwa01h4Q9vDu/HKf6PKLBzw9xs1G7cX3u3t2NBqU2SAzAlJ2gCYP0JvUndDfuTJ8OsKAE4KIB4GN7GS0jZ63LizpSpHForp/9pdMcXLCTnjQCYIU+RDWO8f1WLGlmd6rJOReXniMWFyQsl4Lrl1DOChUl6RBm1ZGUmnutfF4tSE7oMmroWxY2Nr5xBuVurgtk1tv8lEvQPxJQAq0R3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5248.namprd12.prod.outlook.com (2603:10b6:5:39c::15)
 by IA1PR12MB8263.namprd12.prod.outlook.com (2603:10b6:208:3f8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 08:49:00 +0000
Received: from DM4PR12MB5248.namprd12.prod.outlook.com
 ([fe80::92d8:797b:4db0:d385]) by DM4PR12MB5248.namprd12.prod.outlook.com
 ([fe80::92d8:797b:4db0:d385%5]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 08:48:59 +0000
Message-ID: <c43698bb-d791-4eb5-9cd0-df3d6fd38c66@nvidia.com>
Date: Tue, 1 Sep 2026 11:48:54 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: MLX driver for host-to-ARM communication
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 ttoukan.linux@gmail.com
References: <ba322fd3-9f91-4e2c-9000-12d473ecb249@nvidia.com>
 <20260813081410.5fdeceb1@kernel.org>
 <0444bbb8-39e2-40f8-b3c2-a5851e5bfa70@nvidia.com>
 <20260827081529.63513668@kernel.org>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260827081529.63513668@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0149.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::20) To DM4PR12MB5248.namprd12.prod.outlook.com
 (2603:10b6:5:39c::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5248:EE_|IA1PR12MB8263:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f68229b-919b-490c-d9e6-08df0805dd74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|56012099006|3023799007|6133799003|4143699003|11063799006|10067099003|5023799004;
X-Microsoft-Antispam-Message-Info:
	JGCw/3/puowEfEOArqUKZZXwGK42SDlRkJgpJ+2okKlTXLLUixvvBA2yvXlEqhmq5kxFmTSzH2l7RyG8d5Pyyb3a5k9f3VLGbdove0UtGEi7K24I8xmIORlHq0wF1tqdfMRM13+G+7lwtYy690QJRkb91BHV0Oo42339RVEY6zmx8DHfkPjyTw3FNIfHx1kolk0izgg2dcuRm/dIS1yUAkgwJoomRy5XcUgPZxM+snrtw3/DQU9K9PoX5o1G74ehN0UMRx0Vl7fIP+nxEgyrWJB0M6s8vdbIi8sHESbF+2xKg0yeuu9TeMQroAKX8mj9UmhtmzCPWtSmlf3l89S/19IKfIgo7cwSUByvHQMiJECYImV9Jm7jFcBuAdLFoqPovaBSgAaivokgcPJc52yxJRdvzFmErkxgI+IyLIt/QkObt4514oFQiQ23faP7FpUENYmGmYhuKq8YexEzcZv//ud+AZ4PwybGjYEQQbAOCBM1BoO29HneoPoyqtTDCMH/YpDTiyXhAKfbYyRuOYLd67mspYqMwEdhLFLEBgUpbMuFMaU9lYVnoqGsDHoGv5ybJC8mIT31EgEWW6k64U62m10bxS3Zl9DqmiRbrtTHE4XMdt+MLU283h76z5MbYS9aAtVsDpjNAH680KNQKVFLRLZuqEMcRfNENM3JrvuCCOk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5248.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(3023799007)(6133799003)(4143699003)(11063799006)(10067099003)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WEdyN1Z0S1dhWDBLd3N6NmxjT1FyQ1p2L0V1K2N0dUk2b0xGZWlzWnoySDQ3?=
 =?utf-8?B?THVzeWUxamh3cXJnMEtORjVtU3RTVlBSLzR3dC9CUktPcDBrbUtLaUt6OFJY?=
 =?utf-8?B?dDJCdkltUXl4ZFNSNC9ObUpMUzI3WGpyS0dYVnFUUDFaOGg3WnZvRzgwa2ps?=
 =?utf-8?B?WTBqd1ZsVDRJNFlnYXluSTNpL2pZNk9mQm1oeDN5SkxnSVlvdzZiYWQ3RHZC?=
 =?utf-8?B?Z1VURzVjTGZWM0NvMlV6b0FLak4xRWtTYUo2MmFscVRGSGNDeFd4M3hqMXkr?=
 =?utf-8?B?OURwVGNBRDBUaFNKWDJTdW11R3NrQXdqSkN1SXpmcXlhaGZRMzlsUkwxWHh2?=
 =?utf-8?B?TFp1bi9wWnIrenI5cUZQT2NaNHU2S0hWTk1tT0ljRW5uYXRNc1NKZ0VleGlH?=
 =?utf-8?B?c0ovRmNhbmsxRW5RUUtJemNTYU9LdFVQRUx6OXNlazkvUTdPOVFmSXVOQVlI?=
 =?utf-8?B?MDJ5d09VOCtSejBnOFduKzNublQ4YksrTHR4cDI1K3gyWGdqMW9FbnFQb2VG?=
 =?utf-8?B?TVNqTDR5dDY1d1VHMWY0SHF1MTR4b2g0dDZxV29ESjhZQ0RLT3BNQlAxd29B?=
 =?utf-8?B?dmU2VWl4RmZFRkpzd0xIRzdvTFJaL3JJN0d1WkNUYjkyRXAzYmhIbzkrcmtl?=
 =?utf-8?B?bWt5VHBiSWlMZnRHTnY4ZFRaZW1Mamh2YnJjMUZLRGsyaHI3SWhwNExXMVFv?=
 =?utf-8?B?Z05PVE5IbEJNdk5PT01WNHl2a3BtVFhPcnNGZFJ0SW1CcXlPN0k4UkNYd2VV?=
 =?utf-8?B?RnNoTHJUc0RyK1QySjF0Ulc1c0o1Yk1TK3VLUGVValZsYVcxSXEyaUdxWFhI?=
 =?utf-8?B?ZHB0MGxnQUVuZ1YyNndaaGxEUXpmWG91NWk0U05aL2tsNndMdTJJcnlwaE9n?=
 =?utf-8?B?QXpMUU5wV1lMWUloWmQvWDAvNWQvWTQrenJrQ3NzWXFkZ3NiZnN2VTFlYUZ6?=
 =?utf-8?B?Ymt2ekxmaEkydVlSbldkdG9US0N4S3BKOWR1WG5KMXB3bzc1YkJ3RGFsL2hU?=
 =?utf-8?B?QUViQ2loN3EwNkdHVUpHNGFHYU9nNmVnako4S2xwZnIrS09NQkhpVjVJSWtC?=
 =?utf-8?B?a2hLdTRYb0pZZTNwcEVYQjZkWktWbUFiUjRoSld6MkliNVhKSnBmb3BqZmk4?=
 =?utf-8?B?Sm5pUnZ4eTlkb1pPNHBMVTRQZ2QrNGljWk5HbVlaOTNtRDQ5NGtleitpM2dV?=
 =?utf-8?B?TkRkc011dDZUaWZ1NDlNNUJjRlZYZ0FGVTZ6bWR4NlpyN2RhdWFyR2tMNkox?=
 =?utf-8?B?SXJIeXhsYi9LTkpVRE9sODY2Rjh3VzA5VWljWEtuT1ZDVXR2Njh4TzNueXRD?=
 =?utf-8?B?OGI4Y0NLR2NRVERsNGlSemhaallWNkhlbGVLVlFVektoMDFFdkwxYTh6MWNx?=
 =?utf-8?B?SzZqWjl3YytDQm51R282WSsrdHdDKzVzK2hYSHliQ3NLY2ZVdjhBZ1pqTXNS?=
 =?utf-8?B?aHdOVEF4YkVyaTZHYXlyeXdIVVVsTmZNZk5WUzFFOVQxUi9Pd2ZtaXZKVTMr?=
 =?utf-8?B?Mkc3V2EySTI1V3Ezak1PTjcxR1JZc3pIR29YcU5FSXlUazhHS3BVb0Y0aWdr?=
 =?utf-8?B?dExpSDZPUXdXNWp4dVhoYjB2bEd3d3ZRYXIzeTBOWWQyS0VNbm9CdTFJbThF?=
 =?utf-8?B?bFRqMS84NE5nNFFSY3RJcytmRDhCS1FqeGF3ZlpYYUF4SDVwUjdrSkFhVk8z?=
 =?utf-8?B?bXlHbmZEa3FiK2IvMjdrbFhrWWVYeGUxa3JuUElhZkd3VDlXeStDL2ZGaUJT?=
 =?utf-8?B?QjRJakRoaWJOZyswMkp2R2p5NGlEK0puOVZXVkRKdW9TYlBBdnpzQmxFZXM3?=
 =?utf-8?B?REJqczRTSm9ycFlYcmhMaXNJUldNVHNOdGpXUTRITWFHZjdnMGkzOGxOMGJG?=
 =?utf-8?B?R1hJemFIK29SMk5LRXZoay9WK1h0R05ReitUdDJKWVJjMnZ6djRUWVo0SnBj?=
 =?utf-8?B?citBYWJKWTdnOW1GNG5LbHVSR0hOd3hGdjJQTWYzYkY5Sy9aSUVjYytRc2Fw?=
 =?utf-8?B?bkdYbVFOZzRZaGFINzFyalMrZ0JkTWkwV1gzNHhreHVkZ21Yelg4cFl6WjBB?=
 =?utf-8?B?ZDd6MDZrNDVrNmJoNUNFWUU4YnVGZlFVWmJuSUx6QTJGampvdWRkOW01ZENQ?=
 =?utf-8?B?OXJ1KzQwcXpTS3REa0diYnZ3UEZiNnVvWG15YU11QXEwY29QUndsZnFzL1dy?=
 =?utf-8?B?Rlh0TTJGN3VTS1NOYkJyTHVTNkVGSFE2WjM4Z2UzbW9IcFdKV0dKa1FpbkpN?=
 =?utf-8?B?eUNYVmVDRHVKdzZFZFdQNm1ZWFg1ZTFONTVTNUxlT2FSMUovU3poOWhBWkpP?=
 =?utf-8?Q?0zjkINvNwFImV0rDUu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f68229b-919b-490c-d9e6-08df0805dd74
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 08:48:59.5613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /G+KwhI+FsXEOrxMSgDJOXS+0UTIJUZ5+Oa0jdLsjT2V3XkFMd/CB5okOF+Qkt9+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8263

On 27/08/2026 18:15, Jakub Kicinski wrote:
> On Tue, 25 Aug 2026 11:24:08 +0300 Gal Pressman wrote:
>> On 13/08/2026 18:14, Jakub Kicinski wrote:
>>> This will be nacked. We nacked multiple such drivers over the years.
>>> Most recent one not more than a year ago.
>>>
>>> If you model the device as a network node it should be reachable via
>>> the normal networking path. If it's a control channel - explicit
>>> control channel APIs should be built, rather than doing pretend
>>> networking.
>>>
>>> Every IPU vendor gets to this sort of design sooner or later because
>>> it's an easy hack when running a user space SDK. nVidia has clearly
>>> turned from upstream work to pushing your DOCA stack on all customers.
>>> No matter how many shameful lies y'all told about fwctl not being DOCA
>>> related. This is just a next step. But please commence your bullying
>>> campaign. What do I know, right?
>>
>> There are some unrelated accusations here, I'll focus on the technical
>> side of things.
>>
>> No DRAM NIC (NODNIC) is not a new interface designed for BlueField 4 or
>> DOCA. It exists in our NIC since 2015, and implemented in other OSs
>> drivers long before DOCA existed.
>>
>> It is a lightweight NIC PF intended for simple packet transmission with
>> a small memory footprint.
>> It sends and receives ordinary Ethernet frames using SQs, RQs, CQs, and
>> EQs. There is no private encapsulation or command protocol. You can
>> connect this PF to any other NIC on the other side of the wire and it
>> will work.
>>
>> On BlueField 4, the firmware connects the host side NODNIC PF to a peer
>> PF on the DPU side using ordinary vport forwarding rules. The Ethernet
>> packets are forwarded unchanged, both sides are Linux netdevs.
>>
>> The purpose of this is to provide network connectivity between the host
>> and the DPU OS, particularly when the DPU’s OOB port is not connected.
>> Standard networking applications such as ssh and PXE use it.
>>
>> To be clear, there is no hidden FW involvement or handling of the
>> packets, these packets are forwarded as is between both sides.
>> It makes sense to use a networking driver for networking purposes, I
>> don't see how control channel APIs are better for this.
> 
> I understand. Having a full networking driver for such point to point
> communication between device FW (/OS running on the device, doesn't
> matter) complicates the system topology, config/init and mixes very
> non-networking requirements with networking. It's a lazy design which
> leads to poor, vendor-specific user experience. The NFP had a similar
> thing, it obviously never made it upstream, but I'm very familiar with
> the implications.

What is the mix of non-networking requirements?

From the networking stack's perspective, this is pretty much the same as
connecting the DPU's OOB port and communicating through that port's netdev.
Also similar to how virtio-net has been used successfully between
hypervisors and VMs for a long time.

I can't comment on other companies' experience, but this driver is
running successfully in our systems, we do not encounter the problems
you described.

What is the basis for the NACK? A technical problem with the networking
driver itself, or a policy objection against this kind of DPU use case?
