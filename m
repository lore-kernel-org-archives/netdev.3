Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010039.outbound.protection.outlook.com [52.101.56.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E964446A618;
	Fri, 14 Aug 2026 13:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786712897; cv=fail; b=nbeBOkL9JLGB2vxMssvF7KH7gTyJgS/vb6kPApKcJ7s5PRiLj5bjPb55FPguDmdeDQMXCeRx2oMvOKvinSOlvNuP9JoWSH3ArKjacNQ0/skneIca45iI4HrdiwgdHyVrlUUxstxAN1poa/1UpxhFsoUKoyFGpwVTyqwPdsemJ90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786712897; c=relaxed/simple;
	bh=L7WYjVXwYxG7E6w34y5ChnYrh1b+5kQ0Ef3rNbdozQg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fI0qBZ11TKVukujaWDBWDL4FcqSzHMjme5++S8p7qPm/45Fbdh3d8Kc/y1ypiFValM651puCTkNvV9TOJICaUQnxrtrt1xKVXgCWZSaOq649pzSCyv2E46PSnLEIrptRZ3l3NzoeDIIXbaFwc3FvDYz1hWFTK1QlDE/mOVkYi7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1lnlV9eE; arc=fail smtp.client-ip=52.101.56.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1lnlV9eE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YhrkyqoHpm/QhGuXK+SkNNGlkwoKunkbWHBQkkNiXYI221lGyy5p9ntlOiCX85iaYDxSCcI5IlBg2NkwiUogMnH7N8T9slr1rwFAJ9v/S0obAZe/FxH8ZbazXXEeT8w4eWe3qY1mjVbr13/wZv45LokxmeRBw2dvBkXZ3ZG+vYCmyIN7bt+Clqw2/SJMQA5OtK33CvTvemo0wVhYEVzLWtSnHBVtfRQSS8YTBsH/wPonBSVvKt8HNUcOet1TaFSKW3syiT53mh2i44Tu6ETDLOcnU0elEsGV6B6jiCBDCfc2+gqMuynhRGlUf7TXsP8sQsfuZ50rlOT5X1sSjg6okw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kbJJpr4rkyYotMnK1F95Vk0BhiGVos9NhaAtR+rC6GU=;
 b=BdORp3teDg9pK8l7bxrTVJZBB+ohud4xJO/3m5FscPXXJTlOU5lenJcWyxdC0oBvNkJfsbt5+VXHLAJhzC1FgkXpx9TsQK9EUT/eGmmFUs3VIRQz8d+NX1IVM/61ty/rgQ8iIDuc6jUqSzRmov2ghAqkvBTTcUPwghe72Mz2q3I3lQYIBx3C7fiR0AHWMCdPkYbdKBbvl+GQGcExVibeirO+zH2YW9XK+3foHSQ7DKfsbMyf21DZOJLaUOVB+qKFQPhSY6jddId4BdZq2W3CwOg/1fPNpSXe1vTPqZg1PGUxCGAUB1EIwdws+guUREHVZiae3w/XHdP5i0ql3L96wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kbJJpr4rkyYotMnK1F95Vk0BhiGVos9NhaAtR+rC6GU=;
 b=1lnlV9eEGbr7IZa6eKp9s8dqkrWT35JH0A1q2YpgYhbCWCyAR3XUrOKguRFsHuyP8n94mHGX4y06EX7b9hpaxktVej5Md+8tPjr14ZkcXiieqPjC/AT9B1zmaYL7mFYMnwZjKcfLkSGK1yEwa/f3qA7gk04PqtYlv8JwPQormt8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB8156.namprd12.prod.outlook.com (2603:10b6:510:2b5::10)
 by SA3PR12MB8761.namprd12.prod.outlook.com (2603:10b6:806:312::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Fri, 14 Aug
 2026 13:08:07 +0000
Received: from PH7PR12MB8156.namprd12.prod.outlook.com
 ([fe80::770:345e:ed50:cb0d]) by PH7PR12MB8156.namprd12.prod.outlook.com
 ([fe80::770:345e:ed50:cb0d%6]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 13:08:05 +0000
Message-ID: <1ec0e56f-6e00-4eb8-ba40-767b74cc7856@amd.com>
Date: Fri, 14 Aug 2026 18:37:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/20] net: xilinx: tsn: add TSN endpoint wrapper driver
To: Jakub Kicinski <kuba@kernel.org>, nagadheeraj.rottela@amd.com
Cc: srinivas.neeli@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, richardcochran@gmail.com, michal.simek@amd.com,
 andrew@lunn.ch, olteanv@gmail.com, horms@kernel.org, linux@armlinux.org.uk,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 git-dev@amd.com
References: <20260807104431.157230-3-nagadheeraj.rottela@amd.com>
 <20260808194817.132469-1-kuba@kernel.org>
Content-Language: en-US
From: "Neeli, Srinivas" <srneeli@amd.com>
In-Reply-To: <20260808194817.132469-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0145.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::23) To PH7PR12MB8156.namprd12.prod.outlook.com
 (2603:10b6:510:2b5::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB8156:EE_|SA3PR12MB8761:EE_
X-MS-Office365-Filtering-Correlation-Id: 44d45baa-9f4b-442a-8e84-08defa051366
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|22082099003|18002099003|56012099006|6133799003|5023799004|11063799006|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	jN8MDAADPIQVEsM4zciceOtJ96BFlKQBigDXFOaqwSMnBRYLwyG8R9XBvpfD0KVYgdL3O0m6Ap+oebqzwML8BPQ7B/yDf66ruEvcw2iV66QmSGA/OdxpwtZnA1zS2RfkLAhsJAZeVftM8HjDrE0IwWeYGP+ljhs7QKVZD/yMiA39Bva4NoXGqYstKraZ16WWXmGyOSNBpPdsFP7oxbwXcwvqfdhx7B2/TnNkAHMvLDCLEtQjtsYeDEnThi2682FbIHHxyNH4sGrTyN1d1c1SRErBCdfUTpEOoNsYk0a8sXZOHz4k3JN8MPy2fkmApO0ShZF0er06oxa1P8vOrESAozQvLGb0JXJeQM7mfT3GIVppJZIaeHAYF48QuTpl2dW6Huw4mrPUaXHChxHJGAfCRCsGzTJNN3PYikWHZ6miH9ujXe6BsikHcSiUl65K5rYWrGtxVyqCvIvVfcH1hFes23cZqLzSAAseCLMjZN+ZgX3fiSAh2scIBQwx89MWzPP3WRRBDi0yJH2848cn81lRazgG+J3WSZ+lKjb/7xoHvXhFlLSxmGDsFF1OoHm/AoSPiwRv/uWu79Oo1zJzB4e573Nxlp74EgckQ6j9VYsqlZqSFQEciJB0r6klw6LaUUXwzrw30lswOsDSpGc1uFT/abAY6OAFUG/tX68GDVevpNk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB8156.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(22082099003)(18002099003)(56012099006)(6133799003)(5023799004)(11063799006)(10067099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGRqekwrY1FaRDR1WTJKREtURVZZUEZ6di9LWG8xVUJPamJ4WUpyU0dGdTZj?=
 =?utf-8?B?dmFnSE40Vkp3VmFxRGdudzhFS1NuRCt4eEZQQ2x2SGM5UHNGRWtDZUpNM1gz?=
 =?utf-8?B?SDdSYTJHRm9mL3V1anFyTmJ5bFhGQWxkaC9tSis5Vjk0NHh0dEhOVVh6ejZh?=
 =?utf-8?B?cWRGeFpYOFlCdU52QnBoNEZqbXZCdVkybDlWSEJzZG5HQzBnbkQwbkVYT2Jj?=
 =?utf-8?B?cUNJY0RndFRIeFhpZDQxc2dUVmJXNndYNGpaN1VvSm9iVkVseFBsalpGMWxw?=
 =?utf-8?B?RHI5cjBPa1laWnlRZC8xOGpQTjg3b3JmQ25QellmUVFlYVVYRWdxMkhnaFlr?=
 =?utf-8?B?V0JCYWRWMy9TdmRKYWpGL29ESzU4cVIyaSs2ZmdjaGJva0pDME5Ga21mQ3B6?=
 =?utf-8?B?TWZ4V25Xc3BlNUpadzNwNFNCZ0kxV01yTGtzN1NCUVZKa09aNWxLc1I2Ly9J?=
 =?utf-8?B?Z2tnbEpxa0xhWEFhVkVIOElhNVNvSHNqY1ROUG9rNDBZV2l0aEczTlRCZ0Nu?=
 =?utf-8?B?OFZRcFBpZWhkaFIzUFJZV2tDeHRreDJyb1lHTHJPYi9wS3JDS2NBTHNBZGxG?=
 =?utf-8?B?NGV3MWY3VXdpNXc4M25mNHNXa0xRMGZ3aEFsM3U5UG1veFoxTk1qZWltRVN6?=
 =?utf-8?B?MVpGQTJoanVZWWVFUmdQM0lQd2JZaktDd2lFd0lBOVZ5QjMrMmYyVWVwZlZD?=
 =?utf-8?B?ZVNvdUpBZzZaM2ZLaW9NamJZcS9HWStWN0FDZFdJNGlGRmFCVGQ3OHhWZFEy?=
 =?utf-8?B?eVlRNUdGTFVrZ05uNHV4SDNaOUNCbnk0R3A0eXhZZzFldjF5S0NycU9kUW1N?=
 =?utf-8?B?M0VsaHRIVzBNL25KVlJXUEVLTmhlYjVkK1RKcklOU2EvMWVqV2ptK0VvRm5N?=
 =?utf-8?B?QjNsa0ZyNmZOdy90TThtUGM3aC9vaXkxTTJIUlRIdWdtN0N0UEk3aGY0MTNB?=
 =?utf-8?B?Tmc2UXNEUnhGV1VHQ01oejF4ZFRUeDVwc2tLV0paWnJMTjZJZEpCNUNaRjc4?=
 =?utf-8?B?TTdvUmxkamxXL0RURTlBSkR3NGN5S0I1UzhET1dDeDlZWVhHbmQxREdacWs5?=
 =?utf-8?B?dGZ4NEpyQmlFeS8rN3ZWMTBtNFNGRkd6VnRmU21oRmo3V3JMcmJITDNtWGk0?=
 =?utf-8?B?VG5VWUl2bHVLd2dSd3YxcHVURnRBR0ZPSGhVTG1CNGFBZStqWWVRTDhNeHdE?=
 =?utf-8?B?aitEUlYvUFNkeENMOWRtR3A2cnlhNnVvQUVYekRDZUY1RERGS0R3UkRZSDhx?=
 =?utf-8?B?dkFEc2tCeEduTEZ3emQ1OWxka1NxN1NFL0NjbzA4RThQejJGMFdZOUpoeW1R?=
 =?utf-8?B?a2FMMXV1ckFzTUpwdVNsSEZ1SW52NmZDMjArblhNR2szNENJWDJPLzRRbXRl?=
 =?utf-8?B?TU5WaTdhSVpQWU05NUs1UW80dERkcGxFaWJCYmw2NXh5VHE2V3JmZlFyVWJX?=
 =?utf-8?B?bWVmUkltdktET3d5cFZqemlJVDBZaDhhNXJnN1NuaVN4Q3lUR0x4RVN0SXor?=
 =?utf-8?B?T0tXQVFVSUlHSGpCY1BDRVAyU2RwY2xKVmQ3Snk4VGFNeDduNHNZOFg3b0lG?=
 =?utf-8?B?bHZabXNyUXRXMWNJNEx6YldibkhOTzhIUjJFNFFSTHZvVDZSWjRJbnE3UlV3?=
 =?utf-8?B?UFpIMXhlSDRDdWdVOTE2Q0pGdXg0dkFwdVNSYjRuTDgxVTJUdHppczFlL0c3?=
 =?utf-8?B?TkF1dWNHVGxBbDEyNnA0bzBNZ3BSaVBVenRKLzA1enJiSno3akdWZXZlTnBz?=
 =?utf-8?B?aG9aeDkwY0lBSUJib3Z4dFJRZ2c1U25BaDZ5Q0ZuLzdQUExCaEU0WmtOUUdj?=
 =?utf-8?B?aGp1YVVGbXpON2RBVzRJNzYvTWN6WlVrS3VLdDd5Wm81TUJmYXNuNjRzN09I?=
 =?utf-8?B?RWhwVWhJbFZGYUw5dThVaFhuRDFQTGhIRE8ySnFCUlYvZEg1UDVmeE1YNzFp?=
 =?utf-8?B?VldTYzVCd0dGNXk4d1l6SWlJRGhaaXZKdkJXcUpBTEswZ3NjOUZTLzRscjUw?=
 =?utf-8?B?K2pzQkl1c21NaWl3dm1ESU52NEI0K3F0RXJyTkt5dDBsTCtsWi85TG5vOGhY?=
 =?utf-8?B?MkVEWHQ5L21rcEQ0SklyZXh6NWlMd1REdi81ZW5HZThsVTZTbHpDUzB5Um5y?=
 =?utf-8?B?bDc1NGhRMU9EMFIxa2JOalVwd2RUTkY5T1BIM0d1OUliVDRqWlREMzJQVmRD?=
 =?utf-8?B?NFdzSU5KaDJtYTJQVVZiYlNiREhlY3VVcE9oQ0FRN3ArMVkyT2tObnRSajRW?=
 =?utf-8?B?SFprcUdMeEg5TGZPQkxRWnJTdVc0cVp6dzd0SnJlejhQZ204UUMycVMzTGdx?=
 =?utf-8?B?UGplQ001cjFlS1V5ZXJIQ3lRdWVVenZoNDlZdHV2cEZDZW02aCttdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44d45baa-9f4b-442a-8e84-08defa051366
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8156.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 13:08:05.4257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EkbOe/C8F2O/IE71sdbxKCd6Geb/XQMrEWGoczBLcpwMEan3VDItcIihYgftyFwo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8761

Hi,

On 8/9/2026 1:18 AM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net: xilinx: tsn: add TSN endpoint wrapper driver
>
> Adds a thin wrapper platform driver for the Xilinx TSN Endpoint Ethernet
> MAC IP node, along with a new Kconfig symbol and Makefile under
> drivers/net/ethernet/xilinx/tsn/. The wrapper enables the six IP-wide
> clocks and then populates the sub-nodes so each can bind to its own driver.
>
> A few questions below, all fairly minor.
>
>> diff --git a/drivers/net/ethernet/xilinx/tsn/Kconfig b/drivers/net/ethernet/xilinx/tsn/Kconfig
>> new file mode 100644
>> index 000000000000..45af4d3f10e6
>> --- /dev/null
>> +++ b/drivers/net/ethernet/xilinx/tsn/Kconfig
>> @@ -0,0 +1,15 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +#
>> +# Xilinx TSN device configuration
>> +#
>> +
>> +config XILINX_TSN
>> +	tristate "Xilinx TSN Ethernet driver"
>> +	depends on OF && HAS_IOMEM
> [Severity: Low]
> Should this depend on OF_ADDRESS rather than OF && HAS_IOMEM?
>
> The only functional statement in tsn_ip_probe() is:
>
> 	return devm_of_platform_populate(dev);
>
> and in include/linux/of_platform.h the real implementation is compiled
> only under CONFIG_OF_ADDRESS; otherwise the inline stub is:
>
> 	static inline int devm_of_platform_populate(struct device *dev)
> 	{
> 		return -ENODEV;
> 	}
>
> OF && HAS_IOMEM does not imply OF_ADDRESS, per drivers/of/Kconfig:
>
> 	config OF_ADDRESS
> 		def_bool y
> 		depends on !SPARC && (HAS_IOMEM || UML)
>
> sparc selects OF and provides HAS_IOMEM, and NET_VENDOR_XILINX has no
> architecture dependency, so XILINX_TSN is selectable there with
> OF_ADDRESS=n.
>
> In that configuration tsn_ip_probe() still runs devm_kzalloc(),
> devm_clk_bulk_get() and clk_bulk_prepare_enable() for all six clocks and
> registers the disable action, and then returns -ENODEV, so the driver can
> never bind and no sub-node device is created. The clocks are unwound by
> devres, so nothing leaks, but the whole driver is dead code in that
> configuration.
>
> This also stays as is through the end of the series, where the symbol is
> still "depends on OF && HAS_IOMEM" plus "depends on XILINX_DMA", and
> XILINX_DMA only has "depends on HAS_IOMEM".
>
>> +	help
>> +	  This driver supports the AMD/Xilinx Time-Sensitive Networking
>> +	  (TSN) Endpoint Ethernet MAC IP. It provides the wrapper device
>> +	  and the endpoint MAC that connects the IP to the host CPU. The
>> +	  three-port switch is supported by NET_DSA_XILINX_TSN.
> [Severity: Low]
> The help text describes "the endpoint MAC that connects the IP to the host
> CPU" and refers the reader to NET_DSA_XILINX_TSN, but at this commit the
> symbol only builds xilinx_tsn_main.o (clock enable plus
> devm_of_platform_populate()) and no NET_DSA_XILINX_TSN symbol exists in the
> tree yet.
>
> Both do appear later in the same series: the end-of-series Makefile has
>
> 	xilinx_tsn-y := xilinx_tsn_main.o xilinx_tsn_ep.o
>
> with &xlnx_tsn_ep_driver registered from xilinx_tsn_main.c, and
> NET_DSA_XILINX_TSN is added in drivers/net/dsa/xilinx/Kconfig.
>
> Since the text only appears in prose and not in a select or depends on,
> there is no build effect; would it be worth wording the help text so it
> matches what this commit actually builds, or is the forward reference
> intentional for the series?
>
>> +
>> +	  If unsure, say N.
> [ ... ]
>
>> diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_main.c b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_main.c
>> new file mode 100644
>> index 000000000000..1ef1b0c2ee6e
>> --- /dev/null
>> +++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_main.c
>> @@ -0,0 +1,105 @@
> [ ... ]
>
>> +static int tsn_ip_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct xlnx_tsn_ip *w;
>> +	int ret;
>> +
>> +	w = devm_kzalloc(dev, sizeof(*w), GFP_KERNEL);
>> +	if (!w)
>> +		return -ENOMEM;
>> +
>> +	for (int i = 0; i < TSN_NUM_CLOCKS; i++)
>> +		w->clks[i].id = tsn_clk_names[i];
>> +
>> +	ret = devm_clk_bulk_get(dev, TSN_NUM_CLOCKS, w->clks);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "failed to get clocks\n");
>> +
>> +	ret = clk_bulk_prepare_enable(TSN_NUM_CLOCKS, w->clks);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "failed to enable clocks\n");
>> +
>> +	ret = devm_add_action_or_reset(dev, tsn_clk_bulk_disable, w);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return devm_of_platform_populate(dev);
>> +}
> [Severity: Low]
> Is there a consumer for xlnx,num-priorities anywhere?
>
> Documentation/devicetree/bindings/net/xlnx,tsn-endpoint-ethernet-mac.yaml
> lists it in the top-level required block for this same node:
>
> 	required:
> 	  - compatible
> 	  - reg
> 	  - clocks
> 	  - clock-names
> 	  - xlnx,num-priorities
> 	  - ranges
>
> tsn_ip_probe() is the only driver binding
> "xlnx,tsn-endpoint-ethernet-mac-3.0", and it only fills clks[].id and
> calls devm_clk_bulk_get(), clk_bulk_prepare_enable() and
> devm_of_platform_populate(). Grepping for num-priorities or
> num_priorities at the end of the series finds hits only inside the YAML
> itself plus unrelated fsl-mc and xe files.
>
> So device tree authors must supply the property to pass dt_binding_check
> while nothing reads it. Would it make sense to drop it from required
> until a driver actually uses it?
    yes, num-priorities has no user yet. But it's mandatory, and the driver
   should validate it against the TX channel count, which I missed. I'll add
   that in next version, read num-priorities at probe and bail out if it 
doesn't equal the
   number of TX channels.
I will address remaining  comments in next version.

Thanks
Srinivas Neeli
>
> [ ... ]

