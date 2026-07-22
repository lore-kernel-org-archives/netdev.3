Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012008.outbound.protection.outlook.com [52.101.53.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8A7388890
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 23:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784762124; cv=fail; b=ijlmh9Mpk7BekOMqaSiuGHeAZRzApzYTH2e7WO2oDM1ZJhTPPh6CO1egJUmknB2/M1W/Es5cP4JHJkTqKSUTbWSV3QlyOexw6Q+N2rmu0K1zhkjWoi6oq5ejEfNx0i2LJpxv56afGJ/oBIfmrRty7ZydfKgehkiUaMEVuCextyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784762124; c=relaxed/simple;
	bh=c6mua8JkqlefHTsM7dhNcMVyFVgtUoe6vAXPdJmWXpw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MPi0aOIaBFJ1nM8ggk32GQ2QBFp1RJfFDB19ShEQMlJvP4evl2s8IJCm2y+9CvBCMvTT0Umj3w4vSDvOCBSVJfYuQqRKyMgyzvrBh/EueVo/+SVNZI/rbmSS+u6vh/3ByQsakH2+xoH6mjYrpQWnUqVyTCZDM5/NQK19UBDsnvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Bg0bySQQ; arc=fail smtp.client-ip=52.101.53.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Bg0bySQQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ugub3zZbqLMtlPVDzqwPbshF/rT3iHAUbXyxSbs5lf5JThidpSHHdzWv3vHy+O0v7I+c7lfxlos/FeErCrd5uhrIIsbydbZScL5itIx+7s2TAWWOfSl8U2DEzJI1z8auAffM7S+X0TkE3WfHMTCsDbfgHm1dJVJHMrkAvwgem2yApu7dNaLzUSS0n2Dj5WjdUsPyHvqMYnOR59Nddnv3YvCP/BvVcEMj7+SOQ+bM2DOb3ucoKXLEJKrNJ+SjaxXkWjVnIdwMXFyMRWxn9ZfIWGuPx/BFGfhUw3C2nxpG6vi1zF2uVo8aCuKVYQecfOgrGMpVkFcPLWK/E+pdUIqcAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N+hZT7w7qkdCyRfpncTk8tXyz5YLVMmMSl0uuYcI02o=;
 b=Ta5/H3XNjpBJTmhZD268TQ56F8kL7tfyTLn5MImCjefb1pskWyGgxOfTnuZ0YlsLmoQImVbzO776VtmhWAlrGmrh7Jk05/cVaSNOwcUR93wCynbYTzK1pnJ9zvjjT80aRbay7P68dXndIIL39IuSwiP6hg/wycgPR00XXUfiBZ4/FFsRyhyx+zPOJawDXECR18EVM3lLKUx9Dlslg51YWmK3HPIKN4FyVZDTVsLj/5kNknZXl9dJ6iRaOtHkAOLeEiDLlxTbnYZAiXLNVlMqs4wqSNK5gOenWo222LUo7FpVufIFblvqpNU4a2flvBzI0B3ynY3WbXTqwhO17Xw3QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+hZT7w7qkdCyRfpncTk8tXyz5YLVMmMSl0uuYcI02o=;
 b=Bg0bySQQalYcDFMEi1rYuuS798RMZp7mp9VYVk28nQSoWCvUu2ACo3GHlwukxwnHiPCyfKsbBXpxS+Sst0SgT6AzlkjDH0MwHftBXYPsoa2F42NliTul9w8gjSdZK1SZSHn5GkB84p7GJgvNsWvt8R1cLDG5VX1Yl0kj1byJ/kw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS4PR12MB9708.namprd12.prod.outlook.com (2603:10b6:8:278::7) by
 LV8PR12MB9334.namprd12.prod.outlook.com (2603:10b6:408:20b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.10; Wed, 22 Jul 2026 23:15:19 +0000
Received: from DS4PR12MB9708.namprd12.prod.outlook.com
 ([fe80::8570:d817:2f81:c62a]) by DS4PR12MB9708.namprd12.prod.outlook.com
 ([fe80::8570:d817:2f81:c62a%6]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 23:15:19 +0000
Message-ID: <aa934801-f382-4c23-a869-d6fb16ba3cb4@amd.com>
Date: Wed, 22 Jul 2026 16:15:15 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ethtool: Embed FEC hist ranges as buffer in struct
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org
Cc: Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Simon Horman <horms@kernel.org>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Brett Creeley <brett.creeley@amd.com>, Breno Leitao <leitao@debian.org>,
 "Nikhil P. Rao" <nikhil.rao@amd.com>
References: <20260710230026.47721-1-eric.joyner@amd.com>
 <45d2be78-4e58-445e-81b2-75dbcd15402f@linux.dev>
 <303a0166-efd5-48b1-8a52-39780095b7a1@amd.com>
 <f136bfb9-1756-4668-acc3-68962cdc6069@linux.dev>
From: Eric Joyner <eric.joyner@amd.com>
Content-Language: en-US
In-Reply-To: <f136bfb9-1756-4668-acc3-68962cdc6069@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0405.namprd03.prod.outlook.com
 (2603:10b6:610:11b::15) To DS4PR12MB9708.namprd12.prod.outlook.com
 (2603:10b6:8:278::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR12MB9708:EE_|LV8PR12MB9334:EE_
X-MS-Office365-Filtering-Correlation-Id: 580e2576-2c10-48ba-6b79-08dee84718b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|7416014|376014|3023799007|4143699003|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	/xZ3928h8F6buiVnMovakrG8sxHbiJ4oKimXtjx539AAmkxVDYx2XD+GzMSqXJLpvmV4TI9eqrYCY4BNy3n2IdMFjk2hd7FqxjWocpodakeNFl9KRA9OWL4rKxPPzn7P4kCSDVaVmfWaKavAL4tj3CkISAYJykqOf8x0CqvGimQ01Y9kKixQGTZoUO1nxgfuuGM/h2dk7i1DVjvMTwq1bspum8C9pArXXkMp/ny+d84ssdRQHUdzPedzZyIluKQUbfmS0oCOt+rDpVe9s+uxrEWHDU37hrBY4h0+2K5GSMsxX/iVtWRzvJbPtNuLcP3Hr5EM73ZzB8FdmJELtwZ8MwT0xptq9FEzjYc3J1miqdVRAy0XuHg6xTHe5hzfJFjSfuBN369xa0ns5DH+nez3IiOYRLcNPaF9pqi81fee3xIMA7T1Ly41P53AM3CrpOVRQNGj52dNZ44N/tO9yb3m0azoU6y+KMx+CqX09m2YRa/GRQsYOhTjGdml/RAwADrbRbBSUOhcz9UdQcfDF8fMsrVfmVQ6f64lqjlUdg2TiuGqSzjYdgJZFXyp+/GVRv0nHTxncfo15Sy/5yPRVgI9JIyA4csWkkNqYrpbpUywOEOJUH6SxYte0bKgWmIJpDQmN07EcN7zwuB91LsBMfWnWcSOFWyxXhFqfH2z4QyL/Pc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR12MB9708.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(3023799007)(4143699003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGhkMGNUbWxNY3NWWi9peWRaTHhudjdYblRCVmZUL1hwbWJRM3NUbEZlR09S?=
 =?utf-8?B?RGR0TGljaXFmNUxON1R5czAzaThaRWR4MEV0T2VYazBKQjFhbXoyN3RXTzla?=
 =?utf-8?B?Q1J1Mys2a1FpMVpRdWY2MktWblBYMXUvOWlUUXlNcmhHNGdmZXRUdGxGM3Bn?=
 =?utf-8?B?ZHJGV1ZQSk5HZGpVT0VZemh0d0VCbGtwZmVReSt4UnRTdGlKWGhhU3luWUVS?=
 =?utf-8?B?dmkzTFJHS1VrRmppOWpIeXVjb2x4TnhaMXpXaHcyUUNWVHMwY1plME1wd05l?=
 =?utf-8?B?Q3o2aC9zZC81QlpsZkpUTXR2MW9SbVJ3M3p0RkFGZE10dytHaDkrblN4Uit5?=
 =?utf-8?B?MGVKYU9Wa0tyZ0xwZjhYRUtnam9hSTdZbW9EaUdtb3hURDRCT1d2WGxNUmli?=
 =?utf-8?B?QkdsM3FYaG9ybkRmUDlDN2JXRGZOdUNzbnY2aWFFTUdxcnVsRmF3MU5aZU9x?=
 =?utf-8?B?ZEg2czUxc2lWNjRobjQ4RVBQQkhlTno2WklVcStZdlF6NnNQMWh5N1NqclRM?=
 =?utf-8?B?Z0pCYlNrSFFabEhzcHFDNFVmMEhwUUh0NTFsT0JkSTI4WENpdHlmWXRMeWJt?=
 =?utf-8?B?MGpmVkZHcUt6eTk5aHVLSCtNK3RocDR1MnBvWTZoVHh0WXpyUGdzZVE3YjdT?=
 =?utf-8?B?bS9NV09zZ0lUdzgrb1Z3UGtyTmRxRnZ4ZS9EZ3FhMWp1WnpMb0lHdU9TQk95?=
 =?utf-8?B?YytIc0xLUTBFRUhFVk1saWFzSjFzRTVxVmdPTExIVjdOTnpKZE5yVG5tWE9Y?=
 =?utf-8?B?clJlSEQwMW5uNXJPcGtuV0dxYXhNaFZ0Ni9OUEVSZk80eXZkM3hSKzN2RmRT?=
 =?utf-8?B?ZTZrRkR4Nm9GSWRHNlFTWldqYWtzVE9PcFdrQlZka2lxRFhYa0dHdEw2WjB2?=
 =?utf-8?B?cFVuZVVuNGhwOWxJVVNqeFV4YTZ0VGcrcVp3QmhGNnE2WTVkZmFjVTZtOHRF?=
 =?utf-8?B?RlhWQ2JIMVg4YXlldk5xbFdUeWpCWlhtaXQ4MFFnV051S0FuYU0rVHFQOXVE?=
 =?utf-8?B?Y0JvSmJHTm1OWVlCZnZoUGhpUlhldDcwMFNJMHlhd2lxQlpWdHhSMFVacm9Q?=
 =?utf-8?B?dldLMHNPdGxIV2JlQWxVYUJnQlhrbCtsTmRKaURKYStHTWhsakdHeXRJSGVD?=
 =?utf-8?B?L0hWcTNoV1VWYlZCK1ZTZGxqamp6UDFsTjhrRllrYndSaXJMcEtQMGhuczkx?=
 =?utf-8?B?alFtTnA5ZDlHUmQ5WlVYTk1EcC9wQS9CODJGTjErTUJiVHBPVFJBYjQ2MERP?=
 =?utf-8?B?WXZDbDhlQTB5ZGtzd1VBSWNvTTNuMWNUVXZTN3J5bWRsMW1kektNZXJ1Rm04?=
 =?utf-8?B?Ujg2TndrMjJjaEo1YVFON2JpUytGTVovUXdTTU55c0hMYmsvTUFseE5NVnoy?=
 =?utf-8?B?RHkvNWFCRy9iRksxNFVlRWZyeUJSWnc0T3Q1T0o0R3VaV1drVm9xeXUzYllH?=
 =?utf-8?B?V3RCSDRaOHlGa0xEOGFmREhROUVwUkQzekJPbkFObjY5RWltanRzTVdxMzd3?=
 =?utf-8?B?M1Vhc002dWlVeDRwRkFTQ001NDZZZ3gzT3JVYTE0aWpLSWhUVlJrWUFiQWpF?=
 =?utf-8?B?dmw5SjE2WWVhQVVLUHdjbTArT1pYTjA5L0oyM1A4U1RSZ3dDZ2kzNmJjMk9l?=
 =?utf-8?B?S2dSeEhXbmNtKzZNZUpkdTZGSHpNUGl2N1NhdTNrTEcvYUlGMGhDVUZaYSti?=
 =?utf-8?B?NjV0TERydWlnSjZibjZxcEUxRnZvTUxGeHBNWi8xTkZmN3JpejdxbERlbXdX?=
 =?utf-8?B?NXNPZDJrWjAxVVI5ZDRJZkdBM3FvT2FueVlEaDVaVW5VMCsyVGpaYkkzVVdo?=
 =?utf-8?B?ZEhyMjBtaFpUbmUwSk5FV0E3ZFMvR1M1cnFjbXRXL2U1ZTc4SmhXUzlIOWZQ?=
 =?utf-8?B?blVwSjBrRExiNDNrRm1RNXdpNkN5em04aW5heFAwTERHTGZPdGxpYWZjRUNa?=
 =?utf-8?B?TE5KOE5JbHBEOHJTenJDZWlUR3RzendBM3ZWUGV6czRua1NZSGdnMTZKUFgx?=
 =?utf-8?B?ZlgvK0xHSW9UVmhZbDFFZXNkMTg0TWhNU1pKZUZuUWwwY0lubHk3M2ZDdGpM?=
 =?utf-8?B?aHk5RkpEVHhhbXd5UlFxaGtWM0Fyajl1Z2I1RGQ1dnhzOUYrQVZ1VHI0cGN6?=
 =?utf-8?B?bGNMVkdUWEUrS0k2cW9PZjA4UjVtK2hvSDl5UFVzWE9HMDh6UUlzWDlNSUpB?=
 =?utf-8?B?S0JSV2FkcmNXTHczZGpGbG10anJLMW45SGZOMjZJZ1o5aUt4Zi82WVR5d0dy?=
 =?utf-8?B?UHBHYkJCSUJ6T0dTYlkzcE9veGFmempVTVQxTUpCWEJpb2cyZVN5QkRKTi9I?=
 =?utf-8?Q?CEl6YRLW2vcLmEzw8T?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 580e2576-2c10-48ba-6b79-08dee84718b3
X-MS-Exchange-CrossTenant-AuthSource: DS4PR12MB9708.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 23:15:19.0195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sox2MDbd731PA/GszLSjMueqlbUGA8jg9Gvbsq58vPEAl4rlquj02fzy8NJhpVMw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9334

On 7/21/2026 11:40 AM, Vadim Fedorenko wrote:
> Caution: This message originated from an External Source. Use proper caution
> when opening attachments, clicking links, or responding.
> 
> 
> On 13.07.2026 23:37, Eric Joyner wrote:
>> On 7/11/2026 2:03 PM, Vadim Fedorenko wrote:
>>> Caution: This message originated from an External Source. Use proper caution
>>> when opening attachments, clicking links, or responding.
>>>
>>>
>>> On 11/07/2026 00:00, Eric Joyner wrote:
>>>> When a driver's .get_fec_stats() handler is called and the driver
>>>> supports FEC histogram stats, the driver supplies the histogram bin
>>>> ranges via a pointer.  This pointer is assigned while under the netdev
>>>> ops lock in fec_prepare_data(), but the actual data is only read after
>>>> the lock is released; so this allows the driver to change the ranges
>>>> (e.g. from another .get_fec_stats() call) while the current call chain
>>>> is reading them in fec_fill_reply().
>>>>
>>>> Fix this by embedding a buffer for the driver-supplied ranges in struct
>>>> ethtool_fec_hist instead of using a pointer; this ensures there's an
>>>> ethtool core-owned consistent copy that can be used after the netdev ops
>>>> lock is dropped and later in fec_fill_reply(). While some drivers like
>>>> bnxt use a constant struct for their ranges and won't be affected by
>>>> this issue, others like mlx5 (and eventually ionic) will use a
>>>> dynamically constructed range struct and could potentially run into an
>>>> issue.
>>>
>>> I didn't like the idea of dynamic range, FEC is not changing while the
>>> link is UP, I don't see a reason to dynamically reconstruct histogram
>>> bins every single call. And the histogram itself is stable per HW per
>>> FEC, can be constant pre-defined struct in a driver, like in bnxt.
>>>
>>> But if dynamic allocation is the only option, then yes, we have to
>>> change this ABI.
>>
>> We can discuss this more.
>>
>> I think overall drivers aren't going to need to dynamically allocate a range; I
>> mention ionic but at the moment I think there's only going to be two possible
>> FEC ranges; the sixteen bin one for RS(544,514) and I think what should be a
>> reduced size eight bin one for low latency RS-FEC RS(272,258) (unlike the 802.3
>> spec the Ethernet Consortium Spec for LL RS-FEC doesn't talk about a histogram,
>> but FEC math says those parameters can only correct up to 7-bit errors).
>>
>> So one option could be to have the pointer be required to point to static
>> memory; or possibly a pre-defined histogram range entry in the kernel? I don't
>> see any other drivers currently combining multiple bit-error counts into one bin
>> and I wasn't sure if that's something the mlx5 driver actually uses, too.
>>
>> OTOH, doing this dynamic range calculation should be computationally pretty
>> cheap overall, and provides flexibility without keeping or adding new
>> concurrency problems (which is an important concern!), so I don't mind the
>> current approach even if it does look wasteful.
> 
> After thinking a bit more, I don't like the idea of copying static constants
> over and over again in cases where we have pre-defined ranges. What about adding
> an array to the pointer, so drivers with dynamic range calculation can fill up
> array per query while others can simply put a static const pointer and don't do
> memcpy?

I think it's a good idea; it also makes the patch smaller and requires fewer
driver changes, too. I'll submit a v2 with this change.

- Eric

> 
>>
>>>
>>>> Since the kernel API changed here, change the in-tree drivers that
>>>> report FEC histogram stats to copy their ranges instead of just
>>>> supplying a pointer.
>>>>
>>>> Fixes: cc2f08129925 ("ethtool: add FEC bins histogram report")
>>>> Signed-off-by: Eric Joyner <eric.joyner@amd.com>
>>
> 

