Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010065.outbound.protection.outlook.com [52.101.85.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BBD3C98BF;
	Wed, 30 Sep 2026 10:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790763890; cv=fail; b=NVPaHOW/gFDQrU3TbZwBV96wzk3xuOh+XAz8SH277PcBUK9dntDS9AHREIMlI5htLyyRM5BuFdIM91Qr409gKlItwv+DkucJTZGqnxdrhRmAdtz6Go3Q8lMkIADBpkweiO8SJsMffAIrbvE6wWR/s6spNI5PqNVfRWfoRMPf9sA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790763890; c=relaxed/simple;
	bh=G50sP/aU7PdXkj3cj99juhhXNu9iU6f6WdZi7ZlocNM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V6NLL4oVijLV6jux8ZgZyT0nzDZbznWlw/sX3mzNsRXRlcUk5UH9GZnNRaFGvpxrI2sEUOhzh7561Nw3qEKb4vINmxvLCnwzvwVxAqPnxGTBm22Sq0lzmkG97CAdG6qPXcHjzxEhMB/Q9NdWNUYXXL/3sMkRkK50T6AQJRL8cio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=15mDaVxr; arc=fail smtp.client-ip=52.101.85.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="15mDaVxr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IdNN17yicpeVhSuwVW0ev3TxdYbpdgKLTlDu6umN4Luosgzp6yWWP3qfLjlaxBhC6tUNuGy3svSKuEpkPdk1VmUgxB3Efnpuay0UyNjJk8Ktr/ZeGe7vVN9BYRTXKD9j3YHwpKceztT+74Lc+NG2NAT6dghRlr+N3UCUpzZ6Q4E8py5tSb9bx/Q3kZaR4cXvwqWiGB7CPZC/jFAXU2RgWJWwRliWpIkBtb2lCaWzO7Q1sPicHqkG8u2gDU0KC+DFpjqdjs3EBOI/aKnGzgb+AUObB8AEVdh4lWzExMg6dnoH1C7FXBeyAo4/1Qw+/oBVrWaUQlHRKIpYzMR6zcRQyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2evbr3f6+2d8WmzgdYGOd0i4aEM3cre4uDFRYV+lJGs=;
 b=WSN9TeXemk7kbPtpt65yFXJo7BBAxplwtjSpBbbfoiu5DL8O9aosZ2VnmUyS/mC3J6nGCjIbDvuWfVfNEUOpFAJRBn6cmyWFW9GUHMBYs1+18GLkvmZ6eKZuClaxpw3RfJR50lXsrevhBXug6dU5d5MtixernjpK34bmoNZB99T+esXqMa4jI+EmM8KHlV3+OSErGmXufjwSA0zrKebeUCVTAI7ZpBpQCFJ/LaUtpfk8fN3Ulsf8WjDwdTu2+dbmVCr7VNnCzj6GuZhsH2/qitr0zaaMOby3stHYaeeXZH1D9TGykPS/8ZYqCy9N38n+P/g2ng+6QEX9LH4ZKXVYWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2evbr3f6+2d8WmzgdYGOd0i4aEM3cre4uDFRYV+lJGs=;
 b=15mDaVxr0YOjeU5scTCVCd4Is9qB1yPHlEWvHsOsoaHvr45rc+9ebCYTFio73l/qazM68P3tpJJDDvM55g5g736fnMZxhnnwKyHFRG1xV9osFokwGRSIUvegKPWPi56emujJGKnMXpWXJEkhXtKk0q/MIVnvMFdmQtHe4Mje2Ko=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB6798.namprd12.prod.outlook.com (2603:10b6:806:25a::22)
 by CYYPR12MB8702.namprd12.prod.outlook.com (2603:10b6:930:c8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 10:24:46 +0000
Received: from SA1PR12MB6798.namprd12.prod.outlook.com
 ([fe80::e317:e4a3:6ae9:8c54]) by SA1PR12MB6798.namprd12.prod.outlook.com
 ([fe80::e317:e4a3:6ae9:8c54%5]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 10:24:46 +0000
Message-ID: <eeb870c3-24ca-4dcd-8d33-6a64e3e04bad@amd.com>
Date: Wed, 30 Sep 2026 15:54:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/2] net: axienet: use device_property and
 fwnode APIs for probe-time config
To: Andrew Lunn <andrew@lunn.ch>, Sagi Maimon <maimon.sagi@gmail.com>
Cc: netdev@vger.kernel.org, radhey.shyam.pandey@amd.com,
 michal.simek@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux@armlinux.org.uk, vadim.fedorenko@linux.dev, richardcochran@gmail.com
References: <20260928074256.462345-1-maimon.sagi@gmail.com>
 <20260928074256.462345-2-maimon.sagi@gmail.com>
 <f89024c3-0c71-4976-893d-656e154858d8@lunn.ch>
Content-Language: en-US
From: "Gupta, Suraj" <suraj.gupta2@amd.com>
In-Reply-To: <f89024c3-0c71-4976-893d-656e154858d8@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0045.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::8) To SA1PR12MB6798.namprd12.prod.outlook.com
 (2603:10b6:806:25a::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB6798:EE_|CYYPR12MB8702:EE_
X-MS-Office365-Filtering-Correlation-Id: faa11f00-f7f1-4032-0ae3-08df1edd0cb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|6133799003|22082099003|10067099003|18002099003|4143699003|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	qOSP8WISUqex1C3KG55hOtIv19RKvm97Oo2fxBX176En+FkeL/9YXIYSAxP1aBbppGt8EWJSuBL7jDNhy17FeqzQTjYdz5p65twjBh13/SmbdXFKeINyxE2I8lPnCsDK6rSS5rqA4HMRXGk/hQjClRsy15EiVQlM+yWg4JpPLYjoEIJtdwkhSIHYmk5wx3YU/ZQTAzghaPhVcVuqYVVY0eFESP7Mv8H1a2wMo8+T/WmJwUqSY1WbJqjwGIKaLEeboftRGV7xhQuiEV0Q3IOn2qfZSY2j9tgfeaid1hfxdqQX2UEpiDwFopnQ2FDcoy5imNYrFzjoeZEF30xGmooO74NRyb1TMQzgCiTW6DKw+Big7Q6ebW3+ifC30jD8JxD6BugIxepWgMU3SAwidehvQMcY2/1w/mOfZhQ6pxwIUriLN3GfDhyeGG/YzrTVj/ekWKCxcHM/raayNYLbpF57W/9Y4WAfev94mYdkKp5FrNt7Mz9J8dm1bQkLCEqrO8ivTm/nUqaMRsVCtzqvX+TOG1vXj5h85fWgif3lrsYWIONJmQZybTLWNpBSSKm/tWbQf8T9K3oN3kC/KeG/RoX6In60BviC/3JAOe+KvVIMNJr8I+Inbnc/4kQaK0lJTcanIBxNgXvV9g4YpRXbN5PdQistlj7XotjQeUNO1ZCiljQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB6798.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(6133799003)(22082099003)(10067099003)(18002099003)(4143699003)(56012099006)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dFpvejNWalVGa0JrVGpTMkhuWCs4WFA3RjJrbjBqcFd5amxINHB2dkMraWdX?=
 =?utf-8?B?TVZLVkNqMjBMYjhWdWxyWW8zQTk4amFPeVJEWG52b2I2a0NWMXFJRElwYmMy?=
 =?utf-8?B?cG1mRFJabkRyOGF1SDlPbGxFQkNzUjZJWjNob0R0WmxnbjJKb0sxMXZyMUxK?=
 =?utf-8?B?WjV1VTZ0Q0ZBTjJINWE5WmgwR01lU2J2OHVRYjNzVFlCZW11OTNtSnhEWWg4?=
 =?utf-8?B?NktSNWFWRXZYdmp2MDZwSmxrNjlqNklMUXJUZ3IyM2lQYXgrR0g3bW9WbDNH?=
 =?utf-8?B?Mm13M0lUTjAvVW56WndjODhjdmpHWWsxNjFPbnN1aGhLaUx1eDFlOEtsQWJl?=
 =?utf-8?B?ajFOTklDTlZWVjVpN056RGtaSVBpTSt5UDJYRUZpYVpoOVBFblk0amhHQkpi?=
 =?utf-8?B?QlFJQ2gzaTRwZEYvQVdaVEV0RXEyTWludklIRWF0cGdoSEtkZXdiZ1N0NnZN?=
 =?utf-8?B?eW16dWpYQjNRSzZQUnl0MDdkTlp2c2FUenlXMk56MWNDUC9Ueks3aC96R3NZ?=
 =?utf-8?B?MXFPTW50QzlXR01KWi9heFZxUWYwQ292dGdYTWxHTVRha2FpVmttck4yZ0ox?=
 =?utf-8?B?UXJNcnpMYUdSN0l3anFwUnpSVURMRHV6SE9QaElVNUdFR0twZEFocnBXOGM5?=
 =?utf-8?B?K0pWeHVmNnpJZU9jTFkrT2FIZU9jd2ZZbzlyRlpSOEZMVEtLa0VOcytRS0hU?=
 =?utf-8?B?WDAyTW9qbHFoR2hjU2RVdWVNWTBSbTJJR0JRaEo5Rkc2eFIrdUNvZmpta1lG?=
 =?utf-8?B?T3k4c1Vndk16dWtsdmgrNDhxS2VLMERwTWxDZWttZDhneUVjMzJaZ2xLTFpK?=
 =?utf-8?B?TDk2RitWYkNVVmNoamYwRFMvbHlLOHhSNXZjNXNBVFhsL0MwaUZiZVhBaDh2?=
 =?utf-8?B?bjk4YkxrWnhGaHlneEkwVVhpQm1KSndqUFlSbGNaZU1qOVVIUVRRL2tWOTZY?=
 =?utf-8?B?ZmgybGlmblZ4UnZWNzRIaHJYWUhDS0NYN3BzV3FDWnRlUjVIaDZvRk84d09M?=
 =?utf-8?B?UjA5VEhia1pScnlaQkZLRWdkZ1RjUTcyOXVxbEk3NER1RHFyTlJOMUV5emY2?=
 =?utf-8?B?UkdDRHBTMWtqZmptQjFGNm92WWZNOVVJaU13RHBkWUpPSnhuVExzWHFRZDkw?=
 =?utf-8?B?cTFyemVlbTUxdUtXOHBsRnVzdFAwT0JaTnl0a1Bkd3oyWEg5dDYwVFo1Wnlr?=
 =?utf-8?B?SjNvT2NVSUxxUGxQeUs0dlJma3hCRWJkL1FlM1dFeERxVTdXYjBXclRaSmsx?=
 =?utf-8?B?NVFFUzZ2OTZRam4yTExaSHE0UXlJdU1iMnFucHlMcHdGQVpKeW9BZkx3dERU?=
 =?utf-8?B?UjgxYnVDVlNkTWVBNitDcCtpdWo3MkdlVElqNXZZdUZRRlZNUGpuaDFFcEd4?=
 =?utf-8?B?R2greE9aUWZDY2U0c3drMWpZNEkwcVVHZ2NjOVk5cG5kWklxeVlhbWlVelBU?=
 =?utf-8?B?OStPK1FHeFRGVi95NHRwMFZwY2ZReVUrVkU1K0F2Ty8zV2hEc3l6a2l1aG1j?=
 =?utf-8?B?ZjdFaVpabUV6VlZwQmFLOXNCZ1orNHAxbHgycUlZNWpZV245WGswck9tbjNS?=
 =?utf-8?B?TC9xQ1dTZFVvOUZCR0VTM0V5QzZYbENrK0k0UjhJWG9NVlp2L3dEZUJnczZ0?=
 =?utf-8?B?a0FmclRxbUgvbXlOQWVXTWhQbUdSQVNXSE5jQThMTmd6MG1pQUordUtoaVRC?=
 =?utf-8?B?SXBMcTFzaTEyNGVSajJLZDVpQ1F5TDlrTjhoQmJxcnF4dkZXNmwzRmxjVGlR?=
 =?utf-8?B?VFIxRWtEN0ozR1BBa1RvWVpKcXNYRE5oSHFGMUtsQm9IR2YwRmVpN1BtSDdt?=
 =?utf-8?B?NEZVQThMM2lsQzU3UTFIb2ttbldscFFsVXhKM09xcStzS1VhUVZnNkY4YVB1?=
 =?utf-8?B?ZnNhc0dKZmhFc0hUYXpJVVB4Z21veHRpcFJMRFA0eVRPNURQalRvbk9OK1F4?=
 =?utf-8?B?Z0J3Y1lSZnM2czJTaTA0dG55UGpoVVU1cnB4THpMSUVsR0lUZEkrblFFdHp6?=
 =?utf-8?B?M3pRamE1MUlFVWh4Z25uaDFDREVCUU5IenRacVYyTHVOUU5RN0ZiLzd1TFd6?=
 =?utf-8?B?S3ZNZFo4SVRSM2pBUVlGZC8wK0VPZmx2MUsyUk1JZS9Zd2FaMDZtcnptSWUr?=
 =?utf-8?B?TytCZzBYZFVMcm10K1RqTXJHdnJENFBaZnEvYXVxNE80dXdRRFFWbFNwMHZ6?=
 =?utf-8?B?eFVPZlkzOWZxRGlnd21ZUjRJcDZwbi8zQ1ZnUlNFRWo2bnNaTE5yS2didzd5?=
 =?utf-8?B?VnlOTENLaXRMR0gyaW8yWFdzaFEzeFp5a244dEI4TkRlYStNVlZIclRPOWhr?=
 =?utf-8?B?SjI3S2s2MHc4TVZNQ0JaU0orUkVheEdYbURuM3pWOGkzMG5xNFkyQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faa11f00-f7f1-4032-0ae3-08df1edd0cb6
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB6798.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 10:24:46.1114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ph28ZmC+69ggjLMHSNt+jM6dDlVDcu8/OvcUSF5nUKFEJJ1m5iOcrJ97NI+obOFqTYAYgVVhFpQZylyHGmxdrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8702



On 9/28/2026 10:49 PM, Andrew Lunn wrote:
> On Mon, Sep 28, 2026 at 10:42:55AM +0300, Sagi Maimon wrote:
>> axienet_probe() reads its configuration exclusively through the of_*
>> API, so the driver can only be instantiated from a device tree node.
>>
>> The ADVA TimeCard X2 is a PCIe timing card, driven by ptp_ocp, whose
>> FPGA contains an AXI Ethernet MAC with an AXI DMA engine.  ptp_ocp is
>> going to register the MAC as a child platform device described by a
>> software node, so that this driver runs it rather than a copy in
>> ptp_ocp.  That needs the probe-time configuration to be readable from a
>> software node.
>>
>> Convert only the lookups such a caller needs: "xlnx,rxmem", which probe
>> requires; "phy-mode"; the MAC address; and the PHY connection, which is
>> where phylink finds a "fixed-link" child.  On a device tree this is a
>> no-op: device_property_read_u32() dispatches to the of_* implementation
>> when dev->fwnode is an OF node, phylink_of_phy_connect() is a wrapper
>> around phylink_fwnode_phy_connect(), and device_get_phy_mode() and
>> device_get_mac_address() are thin fwnode wrappers around the same
>> lookups.  device_get_mac_address() also keeps the "mac-address" nvmem
>> cell fallback that of_get_mac_address() has.
>>
>> Note that device_get_phy_mode() returns the mode as a positive value
>> rather than through an out parameter, so the error test changes from
>> "if (ret)" to "if (ret < 0)".
>>
>> Everything else stays on the OF API.  "xlnx,txcsum", "xlnx,rxcsum" and
>> "xlnx,switch-x-sgmii" are optional, and "xlnx,phy-type" is deprecated in
>> favour of "phy-mode".  Without an OF node each of those lookups finds
>> nothing, exactly as for a device tree node that leaves them out: no
>> checksum offload, no runtime SGMII/1000BASE-X switching and a
>> fall-through to "phy-mode".  The "dmas" test likewise selects the
>> built-in AXI DMA engine.  The "axistream-connected", "pcs-handle" and
>> "phy-handle" phandle lookups stay too: a caller without an OF node takes
>> neither branch, getting its DMA registers from its own platform
>> resources, and it cannot use the SGMII and 1000BASE-X modes, which need
>> a PCS.
>>
>> No functional change intended.
>>
>> Tested on the X2 with a local ptp_ocp change, with CONFIG_OF disabled
>> and enabled: the interface probes with its configuration read from the
>> software node and passes traffic.  No device tree board was available,
>> so the claim that this is a no-op for device tree users rests on the
>> dispatch described above.
>>
>> Assisted-by: LLM sparse
>> Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
> 
> Lets see what the AI reviewer says about this, but it looks O.K. to me:
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> 
>      Andrew

Validated on zynqmp DT based board, probe works fine as before.

Tested-by: Suraj Gupta <suraj.gupta2@amd.com>
Reviewed-by: Suraj Gupta <suraj.gupta2@amd.com>

Thanks,
Suraj

