Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010056.outbound.protection.outlook.com [40.93.198.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F873B47F7;
	Sun, 30 Aug 2026 14:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788098752; cv=fail; b=Huy5s0cV69zltMYdjES/kf9tCbHyQUYx49lpeiqKkZ/GlJii9Bu2yQgVt8x6icm84p+r86r0T25/ixx8mlrxln6CBEvD7nm0Hjbulofl4g6M1RKm7Fydvj/54RpsAwj5eQcc65HgNTMvuuXEJOGZ6cBugDZ+RnB1gzFPB4kFiTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788098752; c=relaxed/simple;
	bh=gLK+45w5QeEZKCA3wwlIHvHfZbBYmCWzGN+ZbFWvG48=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J2SBP3tn8XwScUPOAEhubeUunanhPrpgSAc8qKUhJMi8PuA6i1wWGRavPVzSaQUATubrOFI5M3OStTu2qoGOekSyO7JJbP1S4tolgMv9Bu5IU8L7YQcu+gSbHzCCuygE8seYH5MZU+uUPNH2INbfMHz8p1T/o2U3n1phPHMXVEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JNvjw3KZ; arc=fail smtp.client-ip=40.93.198.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JNvjw3KZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iIQgVv0ZmdlymVfKz5C4Q++XGou48HaKqMDh6EUX/pFwawhi9wcNwc1OScbq2ZtNVRcGxmyd5EzYE1PyREtujdRvVaYtlNh9E46nYKM9Yp0RN/NE0VrbDmx7O6VENBZLn7khMaTbSnCltczXgpI3AFgEbmegGv4jvZVpVh2C5diWlxF0adQcw6HyvqzHlOCqJdrqxZpBh0U1LRx9DGpmHN/haGouTgAK2DGm1QkaYcUJXtcNhuPSS6F677k+6pQaaGusomFtgp6E5Y9Tm/FJsTIgruNahKLQdhrmrVWlsOgZMl2AofeN524bDhJRgDqhB/0HcelPo2LR3iiAMuBUUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xUs7ATqLzNxK4aV+L/UtecZgbZ7vaYx0UBRRvLI2y3I=;
 b=EdXNKuGLF51aty1Rc3Of/xiCzQ62F6FLa9KqwigivkiFEbYoTeQosOjAjgxgy24wauhDpToGm3sqKRKiN3p5BC6Ef/VjFZpM3CdSXD+rPpE21z9vPDu7Q3nZzLEFueinGahJ0nKpAaifB6RvjHGhg5HHuKSnYZhr0i38zGiaEIaQWzA2zskOpD8UdsYDLayv6CLK+JAwfkiZdIcmvlsGT9zl0AjcP3UbU+vWYCjkRb1eUto41x21V4jkJUqYE2+7KEMPWPTrOhIUzHa4tZE2FfKFYfj1TZkRdlcke6vI6zW70x1E82bwT+weRTYODxlFTNnGM5Lqqa/sT0OexdJP9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUs7ATqLzNxK4aV+L/UtecZgbZ7vaYx0UBRRvLI2y3I=;
 b=JNvjw3KZeyR5RbWy0cjEyBTpnJH4n8UcWhpTCJweejHPEsdsQK6aWtzXHsLprBaHp7wLzRh0cd2qK59hc2YpX7okx3UB+3RRMmZQ0x4gyuLfBCT5FQcnYTwDYu0UpA7XdOyBpkMi5RS/pvrfKhqHlt6mSQa3kwpCJtFnIefpXz8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB6798.namprd12.prod.outlook.com (2603:10b6:806:25a::22)
 by CYYPR12MB8854.namprd12.prod.outlook.com (2603:10b6:930:b8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Sun, 30 Aug
 2026 14:05:46 +0000
Received: from SA1PR12MB6798.namprd12.prod.outlook.com
 ([fe80::e317:e4a3:6ae9:8c54]) by SA1PR12MB6798.namprd12.prod.outlook.com
 ([fe80::e317:e4a3:6ae9:8c54%2]) with mapi id 15.21.0315.011; Sun, 30 Aug 2026
 14:05:46 +0000
Message-ID: <12744a63-ac8e-4808-a559-f78fede30a40@amd.com>
Date: Sun, 30 Aug 2026 19:35:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] ptp: ocp: exposing the TimeCard X2 AXI Ethernet port -
 which approach?
To: Sagi Maimon <maimon.sagi@gmail.com>, Netdev <netdev@vger.kernel.org>
Cc: Jonathan Lemon <jonathan.lemon@gmail.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 linux-kernel@vger.kernel.org
References: <CAMuE1bHr84n5LKcj02HmMR5XefPtvQ-UEJAx7+UKfYvRgS0eDg@mail.gmail.com>
Content-Language: en-US
From: "Gupta, Suraj" <suraj.gupta2@amd.com>
In-Reply-To: <CAMuE1bHr84n5LKcj02HmMR5XefPtvQ-UEJAx7+UKfYvRgS0eDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PNYP287CA0106.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2bb::8) To SA1PR12MB6798.namprd12.prod.outlook.com
 (2603:10b6:806:25a::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB6798:EE_|CYYPR12MB8854:EE_
X-MS-Office365-Filtering-Correlation-Id: 9aee5e60-6b72-4314-7a6e-08df069fc96c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|10067099003|6133799003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	dsL8/eMYZhdzSQTfu+2Wq8yWm2djlTAbFiLfyQ5EoZGuXedb9K2KFBkN2000TgauVhog1ATCjtrSBvAd8GD0Ncqd2Jadxdj/OpopNO51mrF35xHtE5nqFkmx3FqsweoOyEdKromtCrpqLVRJ+wNrklNBFx56gKlMVruKtvF5QnEGVIHrDfimulRcFC6nIuuzHnq4DlBbDIGVICQxE3NrSHJ8Qegv18EZlQSGUVLL+Ku70XqRlCXqG6IviHUNlKsjLjfE28Nry2U9sfNaekRHzpIH08yIzaNLMMSk9nRQIq1UeMFTOKbv+Mdel7nygi1LSrkiFpS4Bty6ie++Pro4y9YHCCfrnsJHTfccrJUQV267ZRskORd/oSVT3iRVy/NUu7T6gNXe9VLoq3RLRhVthXelr0GEGt1ZfRSjw/oSY0smpq2AjvnangLCdNnd3wG0Rw0slsix7V+EuvZs/TqXUUo4wo4CzOjd3HOYWpmGvebD8asyvx0whTEpb2wb/J9x1ix1uMFJQ4aZtTqgXfGSNYu5ijNHc6kmGQ1Yv0bucJdCZpU3ydNVzlb9wpfwD71VaP6YwgMBA5QPBx/Lwb2tAHk2DohRCykD8igPzX36d3Alzt84PkSc76U22OLi3SdeVXbhb27h80JjgUSJk3FVrD/vTGIDRVumb4/jZ936g3g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB6798.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10067099003)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmwyeGRlRHRVWFU1Ykw5djhycGJ0U2RIYXpFRytaNjNHRWQ4enlVWHV5MUo3?=
 =?utf-8?B?eDY5SXNFaEd2YlNCeE1vcmNlTEZBU0JrdXh2Z0syWFZGS3NkbE1QQmczUXhk?=
 =?utf-8?B?cU5mUmdNclM2bVNKVGk0dXFCaUJMdjkxZi9GRTlWUHRJK09oNUxwS3g1T3Fz?=
 =?utf-8?B?b1hyWWJVd0RuNEJCNnFVRmgvbEJBZkQxNlpHREVpVnlzZ2lKeGQ2MDJ6cFB6?=
 =?utf-8?B?M0I5Q1lQdmZIQ3NCSGtFMlFNckw1MTFwdHV6T1ZsS21YdjJ1dm5TQkZqdmxw?=
 =?utf-8?B?VC9iN1A5WE9HY0lOcWxLNjR6citOUGxDV05KSml0WDR6b2ZZSjkrcDZ6M3Rw?=
 =?utf-8?B?a0Q1OEtjOEcxdEpjZ3o2SlVyUUsyWnM5QldHVGE2ZGRURlh1N2pER251SmJJ?=
 =?utf-8?B?aW5IY240Nk9aUzExbW9iWkl0VXFvenU2bC9CdkF6WVhYbHF4anZES2xTZkdS?=
 =?utf-8?B?NUYxUWNoK3NmcjVhcDQzZTlEMUdPRWRVeVZmRTdKTzArV3V0RXFnMWY5NkVF?=
 =?utf-8?B?cmw0YmY4dUtGRlZjVG50WTI1bzN5MURUOCtNVGdPc1Zyc2FicEdGT1NxWXEy?=
 =?utf-8?B?LzNoSGhnaW9ic3h2ajdFNEpXMldMN0puM1pOcGxLc0UrdUNSV2FLM25uQU1N?=
 =?utf-8?B?SEZZb0NNOGd1TmV4dEVEYWQ5MWp1aGpIamE5dmlmRGdhZHdNaXhHNXQ4Qm5i?=
 =?utf-8?B?NnBBVEpoajVEZmtHbEY1Qjd1RWQzMll1cDcvaXVmQUYzODZ0SlpPZ2ltWTJB?=
 =?utf-8?B?cERJQ3duWjV5T0xVQ1Y1NjJVM0VFcXFWTlh6YmwraXArK2hjUnZtZmhTakV6?=
 =?utf-8?B?N2FOb3BlZkk1cGp3b09SS0pSbEUvL3J2TDVlYTdjUDRYUVMvOWd2a1FnemhW?=
 =?utf-8?B?eWFla3FzQzVjYVFpdnlib0ZLc0xLUVZWcVFhdG5JY2pTa3BxUjlCSTViRjI0?=
 =?utf-8?B?Yno5SExTaUVLZUtVS1VGd0JjbVBwRmpvSHRCS0JyYy8wYTZ4RmJ6QzAxZWRt?=
 =?utf-8?B?c0JHZnY2MmlScDBvSmZTckNMdFFUKy85ajcwVVpYN0VJM2lNazg0TUE2MHVP?=
 =?utf-8?B?c1E1QmgxamtMc2JOekJ4c3YrS1NjcWZIZU42S2J3UzJJREhyUDUzdkhEc3pX?=
 =?utf-8?B?aXNSUjRGeVBOSUpRbHh2cE90NzdtWUkvY3k4Q3c2blhIVi9JRjNFTkJSU3Jr?=
 =?utf-8?B?SWg5ZGh3K0VnbFZYS3FqUXZMLzhIR2pObjBERUU2T3RyZ3U2NThVb0NnK2x3?=
 =?utf-8?B?Z1Y2WTYwTWUxNUxWbUhIUnArME9sOVZ3SmN1enJoQWNMV0R3dDZYYTFyNnQx?=
 =?utf-8?B?ZzNrbjNIZyt1blZXTDJlengwZDQ1ZGFTK1VtVGJIeTNybER1TER4NjFHb2R5?=
 =?utf-8?B?YkU2eXBVV3BzNnRqR1BIS2FLMTFWTWFNNUFpNEs1NEsyWVVkcGhSYjM3YnRt?=
 =?utf-8?B?ZXRHbUhGMVRLYkt5eVcyc1MrN0JrSVZuS1hvT01wM2RmTVhRd0k1Y2JKUURG?=
 =?utf-8?B?TXBGcnFTK2o4Q29MQnpVeStHRFhjMVoyTDcvL0t5WVNySHF3dG5WSm5yR05B?=
 =?utf-8?B?d2s2VnlVc2hqQ2hlTDJEZ05hUDBFaGFWemxaRDdsenNwK2t3OU04TFZyK01C?=
 =?utf-8?B?RlFXakRJYXhZcHNQNmQzbWxNSVkxWVBzQ0lhdmx3MVBxcEFmQnFMakgvemNE?=
 =?utf-8?B?RlVsSktuTUVXNnE5MUZqU1B4b1h0OVNLUjlXQ0pmaHhmZVA4eFlmUmhiZDdJ?=
 =?utf-8?B?d3FLMmxwMHo0RWpxWGQvN0p5dWhKbEVqRkNkdjhuMkk1eDNDQ1FVOC9KQzNB?=
 =?utf-8?B?UnViTFhPd3NjWHRkbUlvdW1KUHZ0TEQ3Mjgrd3hVZUZQYU9OaDhOeWNEaklj?=
 =?utf-8?B?K1JlZGYzV1JLQXV5SzRpcXMrY1NHSE1WWUU5VFhEV0lzQ256QVp2dUtiWlZo?=
 =?utf-8?B?bFlNTlJoaFl3ajFmbENZY2pwRnlSRmZoWENrWHJ3NlgxTlJVVVBZa1o4c3Zz?=
 =?utf-8?B?K1Q4WlkzLzlHc0g0N2UveUV3b2RER0tUbVVwNEZ5UU9YbzdzdFVxYUtGK29H?=
 =?utf-8?B?ZHdJbFdhN3RNVWVEeHFwZDVtczYwejI4UkNlaXYvMTNEQlVmcXlPc0owd2Z4?=
 =?utf-8?B?M0VlZW9ISzR0am9McFB0NlBSUWc5aUhJS1hZUTAwMVlvQTBzVXNJRGlHQkR2?=
 =?utf-8?B?OE44OHVmL096bXZ5MVNtNmkxM2pISnZMeTEyUDg5ZnE5VEx0dVF4Wkt1Wjdk?=
 =?utf-8?B?VXlaV0dPT1ltcHJKMG9rM00xcG5SRlRNMFBuTGhPbjdETFlkdHVkaE1mZVp3?=
 =?utf-8?B?amZ4TlE2RXQycitna0ozOURZWDF4cVpHOCtsOGkwRDdnSVJSSitSQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aee5e60-6b72-4314-7a6e-08df069fc96c
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB6798.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2026 14:05:45.9805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 98+M6uzEA5XsrwY6DzAhIjSZvvGkSmxjzWlHEHk72jzvTO9yu4V0PvEcVr9vp6phv8/lYn7UWn0D1NewXAgFxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8854

Hi Maimon,

On 8/20/2026 8:31 PM, Sagi Maimon wrote:
> Hi,
> 
> Before posting patches I would like to check which of two approaches you would
> prefer, since they differ a lot in how much code lands and where.
> 
> The ADVA TimeCard X2 is a PCIe card whose FPGA image contains a Xilinx AXI
> Ethernet MAC and an AXI DMA engine alongside the timing blocks ptp_ocp already
> supports. We want to expose that Ethernet port as a netdevice.
> 

Is AXI Ethernet being used for 1588 timestamping here?

Could you please share the role of axienet in the TimeCard architecture, 
including:

- Which timestamping device/IP is used
- How timestamps are generated and handled
- How the driver interacts with the timestamping mechanism

Regards,
Suraj

> Approach A - let xilinx_axienet drive it.
> 
> ptp_ocp creates a platform device describing the two register windows and the
> three MSI-X vectors, and xilinx_axienet binds to it. This is what ptp_ocp
> already does for the Xilinx SPI and I2C cores on the same card, see
> ptp_ocp_i2c_bus() and ptp_ocp_register_spi().
> 
> There is no device tree, so a software node stands in for one: "phy-mode"
> replaces a phy-handle, since the MAC is wired to the fabric internally with no
> MDIO and no PHY, and a "fixed-link" child node pins the link at 1 Gbit/s full
> duplex.
> 
> This needs two things from xilinx_axienet:
> 
>    1. Read its configuration through the generic device property API instead of
>       the OF-specific one, so it can be described by a software node. On a
>       device-tree system dev_fwnode() resolves to the OF fwnode and the reads
>       land in the same OF code as today, so this is a no-op for existing users.
>       It is also in line with the wider move from of_* to
>       device_property_*/fwnode_*.
> 
>    2. A dma_dev in struct axienet_local. Descriptors and buffers must be mapped
>       against the device that masters the bus, which for a platform device
>       created by a PCIe parent is that parent - a platform device does not
>       inherit its parent's DMA ops or IOMMU domain. For every existing user
>       dma_dev would equal dev, so no behavioural change.
> 
> That comes to about 50 changed lines in xilinx_axienet and about 180 new lines
> in ptp_ocp.
> 
> Approach B - a separate driver under drivers/ptp.
> 
> Reimplement the descriptor rings, NAPI and ethtool support against the same IP,
> roughly 2500 lines, and share xilinx_axienet's register definitions out of
> drivers/net/ethernet/xilinx/.
> 
> We have both working. Approach A is tested on 7.0.0-rc1 with the card:
> 
>    xilinx_axienet xilinx_axienet.512 eth0: configuring for
> fixed/internal link mode
>    xilinx_axienet xilinx_axienet.512 eth0: Link is Up - 1Gbps/Full -
> flow control off
> 
> ping at 0% loss, a 90 s bulk TCP transfer moving ~9000 packets each way with
> zero errors and no TX timeouts, ethtool -S/-g/-c/-a all working, and clean
> module unload and reload.
> 
> We would much rather do A than maintain a duplicate of an existing driver, so
> the questions are:
> 
>    1. Is instantiating xilinx_axienet from a PCIe parent as a platform device
>       acceptable, or would you prefer the driver split so the device can be
>       created on the auxiliary bus? The platform device route keeps the change
>       to xilinx_axienet small and matches what ptp_ocp already does for the SPI
>       and I2C cores, but auxiliary bus is the more usual choice for sub-devices
>       of a PCIe function and would make the DMA parent explicit.
> 
>    2. For the dma_dev, we currently infer it by testing whether the parent is a
>       PCI device. That is concise but implicit; we are happy to pass it in
>       explicitly if you would prefer it were not inferred.
> 
> I can post the series straight away if you would rather look at the code.
> 
> Thanks,
> Sagi Maimon

