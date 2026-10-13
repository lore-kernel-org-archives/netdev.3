Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011008.outbound.protection.outlook.com [40.107.208.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60CD48F03F;
	Tue, 13 Oct 2026 06:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791871467; cv=fail; b=VNb0vHQFjSr2B5TRSOqZaT4fT+jvJR54E/+PL2KUrdFtGWDRgpWsyfQqPDupjEZ8btOKnyZ9Izu95D7kQZpihQ/ksj0+RKqtcXSoX6FEjOWP8rPNfQqlNedSLnJd1bydlc++3F1b0kaHXmbO27hr9nOZquWEorPj9EUC0R3ZNIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791871467; c=relaxed/simple;
	bh=Zj3Lx34SFmPJXkyQzk0Hyqubv0DaakibaUMvY16WEww=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eeJk3sn+F5AZ1tkY7AlzAAlwp455UPKkFa65QZJB3PObr6dyLg/j/m0hmzk9ef+2QnHgO9tPQUoBpCT8UWs/hZEdkplONVk5NYdELOq0SfV2S5T5fmYvhfyUgsQXmwJhBxN5SQMFh/kZbIaXsk/w8A5WWh1QSiRJNScTTFF04vc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iMkxOpu4; arc=fail smtp.client-ip=40.107.208.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iMkxOpu4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nmzc1ZhBmy+sKZ19UEGY/8Kthoh9xd3UtnDpZMZDQBHzoA8x3AajTgy26RSv1n4TmQF8nTE02xVNEZBOIKoc52oboivtglHlatuPAU7TBS0+qJT68eU7FOiuLyv//0r1iVft7BbKLNG+thh/3Lzg0o/MhqPOBKHzGVtbeKSV3KVP5f9TaxOVWazgzzo1Y4o8T8a14ybEz43bazJ4lyjXc+RY/teaw6ZL9nwpsGGmCWnLReH8ie/4d0NKmQvO1BBoG8uHQY/Hp/qaBoM9DaFX4a+m+snzqq+Sjh8ZzfH7erVuvq62KUObi9nGow4TPqpQLyMcH5zDzTnNBTpifwvT5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=89Lh5xWWd8/BsPzN3WIOfc6+rC2H0Quu6iPV35kIXT8=;
 b=AegRAE9N2UvrCKo/nvXby1zFmnh/w7vr2DX8dV0mvpNNrw6G15XaIc7YGzF1xDWtnTMk5GIkZwtAhGcb7cpNPntMsr3Kt3JGDMCYATi5IfHtydFm+XMTvA7eqcOao22EZ2GjnpeNFmqIYqNNyFm22ZwAjky7gjVZ/KgkZWjyMeg8vgGI8eLrtVqwxrmp/yykHUpVYhpEU8KoxOKV7dL7X4lw7Vs4RiUiNZbU3CQ+mnq9hWXnp1pmOLePcp1TJcHGJg5yl80T6zsiPmDhKc+mlp4KfD2gTiBd9IfJMiCF6NxrInrniVmppQY8oayWJ3/bzev/DEaROADIYbTUkVqHLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=89Lh5xWWd8/BsPzN3WIOfc6+rC2H0Quu6iPV35kIXT8=;
 b=iMkxOpu4pYkmZIuYNTPhSqRAJmTUIy2NYi4+AyHRlae/UQMKbu0P52g6rqXgGBe2patAF49knEvqHpdDU6kVD2K1YASkdiJAM48VihLIj3SZDX5sA6xWH3t24lZSugPAUwpk1ZD3Zz8DUHoW2SUZIsCQfRldGPB0DFx1clICFxI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB6798.namprd12.prod.outlook.com (2603:10b6:806:25a::22)
 by DS0PR12MB6463.namprd12.prod.outlook.com (2603:10b6:8:c5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 06:04:21 +0000
Received: from SA1PR12MB6798.namprd12.prod.outlook.com
 ([fe80::e317:e4a3:6ae9:8c54]) by SA1PR12MB6798.namprd12.prod.outlook.com
 ([fe80::e317:e4a3:6ae9:8c54%5]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 06:04:21 +0000
Message-ID: <770cd345-98f1-4068-a706-c4e7e8b10ccd@amd.com>
Date: Tue, 13 Oct 2026 11:34:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 2/6] dt-bindings: net: xlnx,xxv-ethernet: Add
 Xilinx XXV 10G/25G Ethernet
To: netdev-bot+sashiko@kernel.org
Cc: radhey.shyam.pandey@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, michal.simek@amd.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261006110550.1990213-3-suraj.gupta2@amd.com>
 <179163334293.434549.14718764476813490489@kernel.org>
Content-Language: en-US
From: "Gupta, Suraj" <suraj.gupta2@amd.com>
In-Reply-To: <179163334293.434549.14718764476813490489@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0121.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b2::8) To SA1PR12MB6798.namprd12.prod.outlook.com
 (2603:10b6:806:25a::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB6798:EE_|DS0PR12MB6463:EE_
X-MS-Office365-Filtering-Correlation-Id: e1cf08dd-a01b-4bc0-68b9-08df28efd2e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|6133799003|10067099003|18002099003|22082099003|3023799007|11063799006|5023799004|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	ngRN3gn+f294NTEoacAvCqIk1sKp75D6Sxngcid+E6xPTkGduc8imQNnsHAW9VgwR8lTmC/kekYuGvGX9wSkyWvnohVMdRpuHEjFYM0Htg/JGy8ASl93CsuvY/5xqq42BZ5q4RXGrqtOmo1cUWQxEsZ6PDTgmZVUpJSHMdS14OhmSyh/tjyIqEhCCK2cLF7FUD9EjjAjrxdwoS+jM4Spi8/2bwHFIwX7QYf2lGHnYSyTPJiKjBS+zq10VI4hutsJVnuXqgCA2S/JoHr1k5UyTPEqs+Y7LacKsBzOxslVba8fArYVbXL8rbp7l3tew5n7KiROsZtyGHR00ILOW86Rj3hXoS/ePwh2nbFnV5como32N/QmvcTHnh7lqeUavNPV1BHuh54qIkxrEeMYb6mMdqC6YUiKeAAu764+Brg2RI0/teGRiY6g1dAgu1kVha7vHauNMNEzQlLFNLdtjSUUo6Q9n+6h4EU1EJywbD/r5+O5RzRnFdC6yy4YFVegi3TdXrwWc70gcnUooCBWp1r/do9npGbn4/AJtPBPEcBTIL8OcaXRAKib2JBt2KfNtOmZxfx0O02QkdZsKPyyS1lX3VaqyDe3Zut3c3Bf/Y4FktpP+buvmIUAXVoapgRORmlvu+r0GeMX8WWBdbrMpwu7tZ45jrdktO0syFm+ueTYbxA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB6798.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(6133799003)(10067099003)(18002099003)(22082099003)(3023799007)(11063799006)(5023799004)(4143699003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Tm1JOElzQ0pGWlNnNHVxSEwzcFVHQUljVmxOa2NQWHlJaFhHbDZ5aGI0T2hr?=
 =?utf-8?B?dlc5Q1VoTUlVK1NmK2psMVNUSmtTUkZWOWVqWEhWYlRkSCtHYzcwOXUybEZG?=
 =?utf-8?B?MWVITEo2VVBrakdPMjFVNHlYMVRDbkUxRG5pN3pPbm5vTG9rVXp4RmZUTytW?=
 =?utf-8?B?NDZHb0FrLy9talFRbUM0RzI0ZFlMdDcyUGlxbHRkbGJTRFlreG41WTR3RDNN?=
 =?utf-8?B?Q01URE1nK2laMkZOd1dRb25KT0g4bTZmeDNlR1ZiSXhMZXJxMjdjN1VoYW5V?=
 =?utf-8?B?M3dENG5SZHQvU1ZOSnlGOXhHb0pacDArSFI2VE5MaW9raVljZ2Z0bEs0SCtM?=
 =?utf-8?B?T2dTcTQ5ZGNvN2FLTnhnTWwyTXN5OFFMUzlGUlNweXNQUi9oMjBJUGM2Mk5I?=
 =?utf-8?B?dXlvdGdLQ0trcWVzQUFPcFVtcGJXOWhjZHF0OXlNc0JZS1JndkN4d3ZFTTRB?=
 =?utf-8?B?UlFpZ1hjMUZKVHh3TTNJL3IwR0ZQR083VWlSbFUyTG5JT1krZkhYYURtQnFm?=
 =?utf-8?B?ME9tUjRWNjA5MEYvUjczVnMwRjA3ZUdCc0oxbXE1MlRuaVF1MUtsMFcrRGNp?=
 =?utf-8?B?cVBOWFZQT1VTc3JWOS9rN3FqbHlvQTdFdkpZbVlIbFFwSnhLdDVWVDRyaG05?=
 =?utf-8?B?VThUOTZWWGF2aDArcUsrQmR3NHpDWWhNQkNCWXVBMk91Q2QvNVhvNERXOTg3?=
 =?utf-8?B?RVlmSVRwaStHSmJVKzlMYjdyQ0xnNmg4MWJDcWx3S3UvOGJzMWllaFVtNWoz?=
 =?utf-8?B?Q3E0R2g1WFo3c1lFUkNhbE5mVmkrQ01wcTlMLzZQYXVRcCtQL0xsSEFIZUVW?=
 =?utf-8?B?VHo4b3BNeG5XTFZxWjhXZUE2YVdjWi9laXpPSlVQZTRBUTlJZyt6eDF2Nlda?=
 =?utf-8?B?WWFYbWtGNlUySWtjYk01a1VDR0RoS1lZejZaeG43ZlZYUnRHd2FxQnR0Vk02?=
 =?utf-8?B?VzVrZ0YxYXd4MXZSSi9ZQnNBMGVNbFJNUkxhN3lFWlJESEl2VWpMaWJoSmJx?=
 =?utf-8?B?WVlSSEdmdmRLb2NqdWRMR2ZoSDJvcjRSS0xjYWg0Y1pYdDJ5TUw3ZUFNR2h3?=
 =?utf-8?B?Mm1jcGlzdTNtZFFEU084bkMveDRlWFg0Q1V0d2ZyY0RPeDA5NzNoYlQ0SXpT?=
 =?utf-8?B?OTRDR09IK1JQUVdRQVBlYzhWUjVvaWlBMjJjaCtiakUvZkhTV3pwVC8wVDRj?=
 =?utf-8?B?OTRvZWs4WURIam8rMjl0bjBiaE42MjJZeEdVK2lUczdTSGxld3V2anM5Qkxy?=
 =?utf-8?B?UTJJL3FLbVRONmhIYjBoZS96NjJGRVVYQm5RZWFPVGMrekRYVWpZOXp2cUdq?=
 =?utf-8?B?eFAvY1lIcDA3VkxNUjAycUhMWEJKMlVVVWI1dWhWdy9IRnErVTBwN3FuYXRH?=
 =?utf-8?B?VnpEK05qOFJIQjBlSHZJSDBnYlZ0aFgzb0dYK0pKc1NzSXVKRFFraTFHN3Zv?=
 =?utf-8?B?L0dVYmFjMlJIemZxd0hoRC84NVROeVBuYnBoa1JJaEtKSXZBckFLbjVZVUxB?=
 =?utf-8?B?R3BNZFpVanEzYUZjTjdlVSswMWRIcEFxTDdlajZwaUNOTEdwb2YwVmJVUVk1?=
 =?utf-8?B?QUhhTXozWW9tTE83Q0tWYlZ0cW9XRVR3d0Zkeld3S2RLdkdlTzFpMldQOTlS?=
 =?utf-8?B?TGZXNDh5U0pBeWl4U3dncHpLQmNGQTdhZUpDTTUxWE0yaGQ4M0EzVnpJN0J2?=
 =?utf-8?B?OG1md1dHaisxZU83Z29VSkxTOXFKL3pPcityREg0ZndiVllHVjlFaCtNMDBx?=
 =?utf-8?B?b09GK2IxZkFZK0tlVWluV3JtaVNaVW1qMEc0RmNiaFcxWkllTWoxSHVKSHRz?=
 =?utf-8?B?NGJIaXBhaS9ERVN4WkNESk9TZmVYRmZwZVdkTkF6NnpzZE12amJMRkhCajIz?=
 =?utf-8?B?NGJYSDg3N21YV21LV1J6NkVhcGhEa3ZDWnEvbldpdlQ0T1JPSFMwelJvUUdE?=
 =?utf-8?B?RG9wamo1dG4yeWFWdkxFRXdoVnorcVlZZWdCVDg3WTlLRzdvSXBwcVZVK1Zl?=
 =?utf-8?B?L0ZTL2ZtNFZmOTM3S29QZll6RFg1SVVaK3ZwSHJqb2MrSy9oZEJlZ2dmQ1pM?=
 =?utf-8?B?RGZLQXc5eU1ZSkJsSk1DeGVka1Jsell5VVB2RE83NnZORi9VOUtoSHNqUkl6?=
 =?utf-8?B?aHZTWXhRa3M5aGdFckxtckVyMUpQV2RleUhqVmx3MXlJeFhLSEVxTEVFT1RQ?=
 =?utf-8?B?cjUwZVFDTG1oa0h2cHBpbXFna2NMaXRtQWpkVGhwVWwzTUFyTzBPK0Q4OUkv?=
 =?utf-8?B?YWVhWjkxNHQ4cmtBcFZwYVJRSFp3N2UwanY1Q2VqTlFNeVgwMXJ2MDJsdHVM?=
 =?utf-8?B?QlZ1WmJUT1hlOEFQNW1BTDVKQUNVWW5TSUtPQmR4aDVLVG9JcHRRZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1cf08dd-a01b-4bc0-68b9-08df28efd2e6
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB6798.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 06:04:21.1746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wJ0IG5tedOGdosrN5COTOEjgDMhXW3rXmcxqw9+n6fgO2aH9kiAuWsGom1zt7UlWkB1RsKj8JzTsva1CS0jVnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6463



On 10/10/2026 5:25 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 · Medium: 1 · Low: 1
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] The XXV binding never says how link management works, so a node
>    that passes the schema, including both examples in the binding, cannot…
> - [Medium] The binding has no way to describe the XXV transceiver (GT)
>    reference clock.
> - [Low] The new XXV binding's `dma-names` schema only checks a per-item
>    pattern (`^[tr]x_chan([0-9]|1[0-5])$`) and a count of 2 to 32.
> 
> --
> 
> dt-bindings: net: xlnx,xxv-ethernet: Add Xilinx XXV 10G/25G Ethernet
> 
> This adds a new DT binding schema for the Xilinx XXV 10G/25G Ethernet IP.
> The IP has an in-core PCS/PMA and uses an external AXI DMA or MCDMA. The
> binding covers the 10gbase-r/25gbase-r phy-modes, the rx_core/drp/s_axi
> clocks and the dmas/dma-names properties.
> 
>> diff --git a/Documentation/devicetree/bindings/net/xlnx,xxv-ethernet.yaml b/Documentation/devicetree/bindings/net/xlnx,xxv-ethernet.yaml
>> new file mode 100644
>> index 0000000000000..cf31ab677a4bc
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/net/xlnx,xxv-ethernet.yaml
>> @@ -0,0 +1,110 @@
> 
> [ ... ]
> 
>> +description:
>> +  The Xilinx XXV Ethernet Subsystem implements a 10G/25G Ethernet MAC with an
>> +  in-core PCS/PMA driving a high-speed serial transceiver. It supports the
>> +  10GBASE-R and 25GBASE-R line rates, with 25G operation following the 25G
>> +  Ethernet Consortium specification. Because the PCS/PMA is integrated into
>> +  the IP, the subsystem has no MDIO bus master and is not managed through an
>> +  external MDIO PHY; link state is read from the MAC's own status registers.
> 
> [Severity: High]
> The binding says there is no external MDIO PHY. It does not require or
> show managed = "in-band-status" or a fixed-link node, though. Neither
> example has phy-handle, fixed-link or managed.
> 
> The XXV support added later in this series sets only mac_capabilities and
> supported_interfaces in axienet_xxv_phylink_set_capabilities(). It does
> not set phylink_config.default_an_inband, so cfg_link_an_mode stays at
> MLO_AN_PHY.
> 
> On open this gives:
> 
> axienet_open()
>    phylink_fwnode_phy_connect(lp->phylink, dev_fwnode(lp->dev), 0)
>      fwnode_get_phy_node() fails, since there is no phy-handle
>      if (pl->cfg_link_an_mode == MLO_AN_PHY)
>          return -ENODEV;
> 
> A node that matches this binding, including either example, would then
> fail ndo_open with "phylink_of_phy_connect() failed". Is that expected?
> 
> Also, phylink_pcs_poll_start() only polls the internal PCS when
> cfg_link_an_mode == MLO_AN_INBAND.
> 
> Should the binding require managed: const: in-band-status? The other
> option is for the XXV phylink_set_caps to set default_an_inband = true.

Correct. The XXV subsystem has an integrated PCS/PMA and no external 
PHY, so link is managed in-band from the MAC status registers. The 
driver should therefore default to in-band mode.

> Either way, could the binding document the chosen mode?
> 
>> +  Any SFP module management (e.g. I2C) is handled by separate IP outside this
>> +  binding. Its payload is moved by an external AXI DMA (or multichannel DMA)
>> +  controller referenced through the "dmas" property.
> 
> [ ... ]
> 
>> +  clocks:
>> +    items:
>> +      - description: RX AXI4-Stream clock.
>> +      - description: GT DRP clock.
>> +      - description: AXI4-Lite register clock.
>> +
>> +  clock-names:
>> +    items:
>> +      - const: rx_core
>> +      - const: drp
>> +      - const: s_axi
> 
> [Severity: Medium]
> How would a DT describe the transceiver (GT) reference clock here? The
> description says the in-core PCS/PMA drives a high-speed serial
> transceiver, and that transceiver has its own reference clock input.
> 
> The clocks/clock-names list is fixed at three entries, and
> unevaluatedProperties is false. A DT that also lists the GT refclk would
> fail validation. xlnx,axi-ethernet.yaml already documents mgt_clk for its
> optional internal PCS/PMA PHY.
> 
> Later in the series, axienet_10g25g_clk_init() claims only s_axi, rx_core
> and drp. axienet_xxv_poll_link_ready() then fails open when GT reset-done
> times out:
> 
>      netdev_err(ndev, "XXV MAC GT reset not complete! Cross-check the MAC ref clock configuration\n");
> 
> On boards where a Linux-managed, gateable clock provider supplies the GT
> refclk, nothing claims that clock. Unused clock cleanup could then gate
> it. This depends on the board.
> 
> Could an optional trailing clock (minItems: 3) be added now?
> writing-bindings.rst asks for complete bindings even when the driver does
> not use every feature.
> 
Agreed. The three current clocks (rx_core -> rx_core_clk, drp -> dclk, 
s_axi -> s_axi_aclk) are correct, but per PG210 the GT has a dedicated 
differential reference clock (refclk_p0/refclk_n0 -> tx_serdes_refclk) 
that the list cannot express today.
I'll add an optional trailing clock, mirroring mgt_clk in 
xlnx,axi-ethernet.yaml

> [ ... ]
> 
>> +  dma-names:
>> +    items:
>> +      pattern: "^[tr]x_chan([0-9]|1[0-5])$"
>> +    description:
>> +      Should be "tx_chan0", "tx_chan1" ... "tx_chan15" for DMA Tx channel and
>> +      "rx_chan0", "rx_chan1" ... "rx_chan15" for DMA Rx channel.
>> +    minItems: 2
>> +    maxItems: 32
> 
> [Severity: Low]
> This checks the name pattern and the count. It does not require
> "tx_chan0" and "rx_chan0", or even one TX and one RX entry. Both of these
> pass dt_binding_check:
> 
>      dma-names = "tx_chan1", "rx_chan1";
>      dma-names = "tx_chan0", "tx_chan1";
> 
> The driver requests fixed names, though:
> 
> axienet_probe()
>      tx_chan = dma_request_chan(lp->dev, "tx_chan0");
>      if (IS_ERR(tx_chan))
>          return dev_err_probe(lp->dev, PTR_ERR(tx_chan), "No Ethernet DMA (TX) channel found\n");
> 
> axienet_init_dmaengine()
>      lp->tx_chan = dma_request_chan(lp->dev, "tx_chan0");
>      ...
>      lp->rx_chan = dma_request_chan(lp->dev, "rx_chan0");
> 
> Since dmas is required, XXV always takes this path. Could contains
> constraints for "tx_chan0" and "rx_chan0" be added? Another option is to
> fix the leading entries with items/additionalItems.
> 
> The pattern came from xlnx,axi-ethernet.yaml, but this patch creates a
> new binding with it.
> 

Agreed, the driver hard-requests "tx_chan0"/"rx_chan0". For v5 I'll add 
contains constraints so at least one tx_chan0 and one rx_chan0 are 
required, while still allowing the additional MCDMA channels.

Thanks,
Suraj

> [ ... ]
> 

