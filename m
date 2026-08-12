Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021106.outbound.protection.outlook.com [52.101.70.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3833749EE;
	Wed, 12 Aug 2026 04:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786507735; cv=fail; b=jWAKu3fDZ/myBImYXRoQdiUwJK0G6IYO6dj0lNSKDSUvEAsw006lOwJU4t1VexmiBp7rkPxkDyVkj8h+91vBMo2j7DLEpMr5EvYZjzFZnvuXuWmJ5ELprvi8z6Nb7hETrI9yFrRA4swPOrvOtL5LxDgLTYWLxZUxjS34bdj9rPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786507735; c=relaxed/simple;
	bh=8HgTWQi6JDh3alJKZ8CQ5lW22fF1Z7aRUnXiFnEsQPM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tHfUGDW31ixmGBY1RCf2SPm89Ik4VllvEGnWz/YIKHP9VrEhbj12QylDZcsLb4jc7WrQvUcN66hwmeThR8UJGEbOM+/xOSCHMpJM0L1eqmmjp9GOGqJ0HLAHvdBRBtGpRCHNQGMx/OpFdxuAcN5a6WVdnAt9uW5xZTzyncMVwOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=yzGH+5/t; arc=fail smtp.client-ip=52.101.70.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="yzGH+5/t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EtHOP1yy1Ob8MipDPq8og0baW7iox+LZe/kOIbtDQTxSgSg9wGdcybxIfKFtfzUXueSnGx8wCNM4jZTTs7RNTbf4tZ0nnBOVs42n+qMcqSIrTS3XCqwbed9XL9AhRx4atgjIDeSGeZpX+GF109oAk+BotqGCgvyU/jJn35XpZ67PykhT2PYqtz4Zls6I1ZB0Jd4xlsn6t7mu8/FqsbBzEliCh90S7Us58S/V5riz5s645g1l4u5iqYQ6QYmSxsHQmzBZU3lxIWixi9sNLWo/7OXFMI+aV4ZxwuwaWMVZC3QtRiX+S07pY4XlKjbCcSkcB+Z+yqnKwrfeJrAowf+BBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jsn65kw4fpInou1BGtAVzzyI9bOhsONdO9jhWTLJjVM=;
 b=evoEHyzFoKuis3RvUMPECK798uGTxMoAapTVFA0v7Sn9+L9OjPGxDLio1f56Q/CU67ceE07tMyn1hvGaRWYVjq27yTGmbMF6sQ6gKSvp3Cry/Q/TvGszPaUgSgah0+OC5hsGCS7F4i1cklQlmTU3poHg7jOfCVMBAHLRYuQuZ30PNoK5StjPNP9f6htQe0rUA4yWfmuRDcq5ArXZhNzGdjsWL1Ejzw44cFpfHGsjMNQKNPTdQu++yENpZT/pgKkRsKVFy9U+xDzH0kMvH+CTPyn2HfhD0GdgKX27hU3dOpoWzDUqL29nlJYDmjP5bGmoVnPMhhl9s/PiNYN94Zlf9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jsn65kw4fpInou1BGtAVzzyI9bOhsONdO9jhWTLJjVM=;
 b=yzGH+5/tWRxVG9tcw708HhMELevM23M0hF42/sFnE8dKxXIztQJUVTLIjNV3GBrYSyP0I4d9761P78Yvoqp76l78+qhytIc9/VARrl/8XO+6OsP+1NfDhAKBo6qgrqY3c3Ut/PbjQZetBiRDaRypc0Rh/vIshUPip8eFdCth4Qi/0AcGwxkz9d6UEiZPr+aAMcVPYQTNH+r+EfFQGItIncHab5kAeaF9hseI+55hY3xT5pR1PbVjC9joBeIttPxjf39PwbXr2VvR98Lglj0gKOsT+3K2LEk7Umgf8Bvwj0Ti45mW2jAw1Cjnl+Lo5qQfhuj2dkB2siLYBQ5gQhEDkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AS5PR06MB9040.eurprd06.prod.outlook.com (2603:10a6:20b:676::22)
 by PAXPR06MB7758.eurprd06.prod.outlook.com (2603:10a6:102:12f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 04:08:44 +0000
Received: from AS5PR06MB9040.eurprd06.prod.outlook.com
 ([fe80::923e:d30b:98c0:c69]) by AS5PR06MB9040.eurprd06.prod.outlook.com
 ([fe80::923e:d30b:98c0:c69%7]) with mapi id 15.21.0315.008; Wed, 12 Aug 2026
 04:08:44 +0000
Message-ID: <fb661149-92ad-4f76-ba2d-18a5d546e517@vaisala.com>
Date: Wed, 12 Aug 2026 07:08:42 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: dsa: microchip: enable SGMII port for
 KSZ9897
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260811-ksz9897-sgmii-port-v2-1-04ae287a0b27@vaisala.com>
 <462378b275d60c704bd0d97d6383c528@tipi-net.de>
Content-Language: en-US
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
In-Reply-To: <462378b275d60c704bd0d97d6383c528@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV2PEPF00023988.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::375) To AS5PR06MB9040.eurprd06.prod.outlook.com
 (2603:10a6:20b:676::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR06MB9040:EE_|PAXPR06MB7758:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b3e5fa1-9c91-4950-2fc6-08def827669d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|366016|376014|11063799006|5023799004|56012099006|4143699003|10067099003|4133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Mt9DFP0hJmkbSSZbLhcM9gAPiBAzvgWTrIO227m9DnpqfafNMA8sJEQ9VQ2QFmk3FW8Wb/ZYUchyI//GHz8r6mOSnHzprLajVpmGJX+3f6aRKpUdLJkKDWmWQNQbdKmmYPQJjnseSLU8Ghv+SXE8aBI7ppWuJrlrOY7QogBi1gNVzzcV/8W7CCKu5T8ahf32xP7OmXwuRmTFb2RC9hgnOqqCYAffNQOhSL/UOzdKQkgUI0I+eAm/g3sYxAgg5Hk0h4M5Gxu5dUFBQ2+K/0on5TxnZEgL3YSjEYPbz/MJ5YVmjpgPWbZYTiCDL8pc1SjdCpZdrK3qrRXRZaptbK7OtPtubD/9Lp8TdwZfcV8lFhBa3xpTOSpsdg1F68J4ekLrJILtkKQXnCC3iMKe3vcT7dQlqOsK91Fzo5oGyJVlXBhjqrIYzG5IU4f7uIuEO8hsiBumbwtrWqIZSv3A80tYAqATT3FzSbOyu05hNAKdenQkEG9pz5B8+ljKngystLveCtDgWTEOqvyrnfUvq5sJm7JVufNlJZA/o8lVizp7Z/EbfTH/0iODas/iRho2SCgUqgho75+kSVXLZUydefQr+jo+NU0JGZwaagtWWvjgWEQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR06MB9040.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(366016)(376014)(11063799006)(5023799004)(56012099006)(4143699003)(10067099003)(4133799003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bHJwT2ZRU3o5Q3M4ckJhczdkeVBYR1M5MkRsNE9UWkNTTkowU3haZkluZllK?=
 =?utf-8?B?aUFIbUErUzJocWYzb0Y5cjJFaDNvN2NTUlNBeWxXazJ6KzdRRUJyVE5yejhx?=
 =?utf-8?B?NVBzc0prTm85M2V6SXBjeEV3WUVMbGs5SmdSZ3A3emJaRURqVU1uZnZla2FG?=
 =?utf-8?B?SGlUbVF6VTMvVkRGd09MWFFOeFpjRjRKeG9PMml6MmlDS2duODBwNHozM0N5?=
 =?utf-8?B?RUVjOHZxcE40Vnc2NHZVcUFXWWV0cVp4TjlTendmUE5LeUNrOVRESUVnYy9N?=
 =?utf-8?B?V3lwbEpydmdhL09tRzNyL1I4VGNKTnBuNmRXRGFzTWZLOHQxVGVjb21hSVZy?=
 =?utf-8?B?NHBBbmErWHpzbS9Vc3lrMWpMRkR5Qnc3dXlxYWJ3OUJOVTc3cFZ2M0RmOFBB?=
 =?utf-8?B?eTlrUGk2ZnIraWVyeVovd2NIWXZIaENRUGI4bllqVS9qdkJlQnpWSWxyeHNp?=
 =?utf-8?B?QUI3TGVvMDZVN2laS1BWb1NwWHZIbU5WMUh6YXp3VDd2dTlEeEFmRlo1RmJj?=
 =?utf-8?B?ZUxNTmRTRHVBb0tBSHNXUm5WY3RoemgyWWN1T0x1VkVJUlFGZStkdm1DbGlR?=
 =?utf-8?B?Tlo2NldPYXBmQjBYanhKQ1lvczJqWk04RzZvZXUxVHIyYS9lMjlPejJSUS9x?=
 =?utf-8?B?Q3lUcDkyRHd1ZUtDV0l3UnI0cWpWTzRFWXpyV0gyZFRuVkhUR3VDNEI2b1Mr?=
 =?utf-8?B?ME1NK1BLQmREQkJadXFTLzhLM3c0UVMvL2g5b3hUR0tWVlAyMFJySjJrdUpT?=
 =?utf-8?B?NE9UWmFwRVRPTUNRMjQyTEM0SVc0YmxSTlFKODRETmd4ZHpsbDI2S3JHSSt4?=
 =?utf-8?B?TlRBZHFnTy9kcHBRUEJrR3BSUzRMTGlwZnRCblJWbGE5RjZYUUZOS1dvYk5w?=
 =?utf-8?B?cW52ZXBPck93U3MveGJvc2NPRUdabkRaUzRZTnczblZJMDBKTlljZ0NYSjBl?=
 =?utf-8?B?V0VDOWk0QjZ2WnR1bjJRV0hSM0hGZnlCTnhjT3hqcnlCckltNXNQNFBsS0Qy?=
 =?utf-8?B?UVdEUTZrZkFqZTJWU3dac2QzMmt1bEZhd20wMmU1V0k3c1VTRHJSREFTVUQ2?=
 =?utf-8?B?WnJKNWlJeEVxSW5veEFDWndNTFFxZTE1Z0tQcHFWcUNxcmZYd044TUF6UExD?=
 =?utf-8?B?eUVBWFNJWEhmOTdQS3Vud1BGcHdqamtYdkdPVVFVSXhWOEJPNmxEZjhtd05i?=
 =?utf-8?B?MHU5cTZEU01melZOekhQSytmWkxob3NUemxFZmEyTmRvTmZCY2ZhR2JpUVFZ?=
 =?utf-8?B?L29HeE5GQ0FYMVoyQmpyV2dzaDJwSzh4b1N5ZVY1cngybzZleVhlQUhUbW1G?=
 =?utf-8?B?elpnck5TUzR0b1RaYkhrQ3R6SC80ckZVK1pBSjV3blFMWExkSVVhRzh1TWVS?=
 =?utf-8?B?MWtTdkoxT2c2cXhwd2dzZHNqQzJzaDdTTGgyTncxUEVDSzhzSU4zUm9VbXFE?=
 =?utf-8?B?YjdpSWFIMGpJdkhWc2xsUXVWU1FqdlJZeE1naysvaGVwUnQ4NkFCRVBxbUpL?=
 =?utf-8?B?YlVtYkYvYXltR1N0UjR3M2JMZzFncWlRN1ZRZDZDaWdyWlBVb1Jla2kvVmI0?=
 =?utf-8?B?Y1ZwdlB0V21MNTFYYS93K0QyMXN2TkVEM0cyY3NoR2pOaWpmdXR4eEpIdE1V?=
 =?utf-8?B?ZVplSjRBSjZnM1lBQ1RmeU1GY3NqUXJYQkFDb3JFZWJCWVFQaFdkblgwOFo2?=
 =?utf-8?B?SFdvK3g0OGloMmc0eW5NemFOK1NuNlBYbHlrYTRtdlM4R1dVdHg2QVdMOUxS?=
 =?utf-8?B?S3VFS1l4SWx6NXRQeWc0b3k4c1YzUWhjL2Q5VGo0a0hmYVdIb1pFbVFiaTlo?=
 =?utf-8?B?QXU4UERFU1pmd3VLb2Fld1QwaGFGZkluTTcrcFFSUEJhUlVnV1h2UkFhUW9D?=
 =?utf-8?B?UzlueGJobm11TVBIOVJScllXaFExUVVQUVo3dmkyRk9oRUwzOHVrUlZlU1pQ?=
 =?utf-8?B?WG42TlFUaDBYakJXYitpT3lkdmJZZUtRcnMyNUhNbGV0L3cxUVNhdGcxNTln?=
 =?utf-8?B?VGljTFhCNkpUVk43WUNxem1tME1aTjlaSW5LNXVoS2pMT2dLdUJlNDZQeHp6?=
 =?utf-8?B?a1BZY0xuZmZuQU1rZkFobXVHVG5CVU41MVU5MjNuN29KcUxFaUVEbkYrZ2ZB?=
 =?utf-8?B?aFc2UjcxY0FsckRFbGgwZEN2a3haUTQycnAyZmNVaUtCdVJ6VXhDb3BaRUhp?=
 =?utf-8?B?WUZhd1VaTmVHWDZiZWlmSGdiTDJZNHg0VUU5UnF5bXpDa0UzMWpnTlRtWFZ2?=
 =?utf-8?B?cWJUcnVPdFJsSFdKRkxWTGc3VERQS05XRzJGVnZZZzFxZ1BGUDJmWlJLZlNz?=
 =?utf-8?B?eTF0ZUxjTGtaSlZES0lLU0IzVUZLSDY5S09OK2ZxSm9WcEJRaVpXS0plUmFy?=
 =?utf-8?Q?vR1I7N8Q3c+iT0qM=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b3e5fa1-9c91-4950-2fc6-08def827669d
X-MS-Exchange-CrossTenant-AuthSource: AS5PR06MB9040.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 04:08:44.3320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: APbozMsq8z27Vk4WlW9LPXGzGDeUQwZUpi+sM7cUIFQbriUWW7KjGt+9sy18Wq7+KeFAvYXb9SQpIi2Uag8blEsX0vkf/vuhuv3jYQiD3Bk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR06MB7758

Hi Nicolai,

On 8/11/26 15:51, Nicolai Buchwitz wrote:
> Hi Tapio
> 
> On 11.8.2026 12:20, Tapio Reijonen wrote:
>> The KSZ9897 has an SGMII/1000BASE-X capable port 7, but its chip_info
>> entry never set .sgmii_port.
> 
> AFAIK only the KSZ9897S variant.  AN5513 says the S "contains the same
> SGMII
> port as the KSZ9477 however, the KSZ9897R has a second RGMII port", and
> the R data sheet never mentions SGMII at all.
> 
> Unfortunately the chip id for both seems to be identical (0x00989700),
> so
> this would apply to the R variant too. With this the R variant should
> return -ENODEV in ksz9477_pcs_create() during probe.
> 
> Have a look how KSZ9563 is split off the KSZ9893 chip id, so maybe it
> can
> be solved in a similar manner.  PORT_SGMII_SEL could also be worth a
> look.
> 
Thanks, you are right and I missed the R/S split.

It is worse than port 7 alone: ksz9477_setup() calls ksz9477_pcs_create()
under ksz_has_sgmii_port() and returns its error, so on a KSZ9897R the
XPCS probe would fail and the whole switch would fail to probe. Please
drop v2.

The part I tested is a KSZ9897STXI, so I only have the S variant here.

For v3 the driver has to tell the two variants apart before it enables
the PCS. I will look into how to do that, either detected at runtime or
selected from DT, whichever the hardware allows. If you know of a
register that distinguishes R from S, a pointer would be welcome.
>> As a result ksz_has_sgmii_port() is false,
>> ksz9477_pcs_create() is never called, and
>> ksz9477_phylink_mac_select_pcs()
>> returns NULL for port 7, so no PCS is ever instantiated and a
>> phy-mode = "sgmii" or "1000base-x" link on that port cannot come up.
>>
>> The KSZ9897 shares the KSZ9477 register layout and operations
>> (ksz9477_dev_ops, ksz9477_regs) and reaches its port-7 PCS through the
>> same SPI-indirect XPCS register window. The register-identical LAN9646
>> already enables this via .sgmii_port = 7. Set the same for the KSZ9897
>> so the XPCS instance is created and 1000BASE-X / SGMII links on port 7
>> negotiate correctly.
>>
>> Tested on a KSZ9897 with a 1000BASE-X fibre SFP wired directly to
>> port 7: the link negotiates at 1Gbps/full duplex and passes traffic.
>>
>> Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
>> ---
>> Changes in v2:
>> - Resend only, no functional change: v1 was dropped when the netdev
>>   patch queue overflowed.
>> - Rebased onto current net-next.
>> - Link to v1:
>> https://eur03.safelinks.protection.outlook.com/? 
>> url=https%3A%2F%2Flore.kernel.org%2Fr%2F20260703-ksz9897-sgmii-port- 
>> v1-1-387e7632dd0b%40vaisala.com&data=05%7C02%7Ctapio.reijonen%40vaisala.com%7Cf9bed626171545a2def808def7a74e64%7C6d7393e041f54c2e9b124c2be5da5c57%7C0%7C0%7C639220495162934870%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=lKJyNr6ZRxDKC9BpnbIU1vVn8O4QfP7oz2WWlsrlAs4%3D&reserved=0
>> ---
>>  drivers/net/dsa/microchip/ksz_common.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/net/dsa/microchip/ksz_common.c
>> b/drivers/net/dsa/microchip/ksz_common.c
>> index
>> 1a9d6f83a0232830ac4996ae5f53b8bde0b3747d..a80fde0a8c7e93ea2db4baeb2f941a260e23b687
>> 100644
>> --- a/drivers/net/dsa/microchip/ksz_common.c
>> +++ b/drivers/net/dsa/microchip/ksz_common.c
>> @@ -1484,6 +1484,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
>>               .internal_phy   = {true, true, true, true,
>>                                  true, false, false},
>>               .gbit_capable   = {true, true, true, true, true, true, 
>> true},
>> +             .sgmii_port = 7,
>>       },
>>
>>       [KSZ9893] = {
>>
>> ---
>> base-commit: b54074ffb813aa4b97585d97ae1ead69d96432b5
>> change-id: 20260703-ksz9897-sgmii-port-48ddb100e015
>>
>> Best regards,
> 
> Thanks,
> Nicolai

Thanks for catching this.

Tapio
