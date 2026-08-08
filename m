Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011045.outbound.protection.outlook.com [52.101.52.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FAF3DAABD;
	Sat,  8 Aug 2026 12:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786192125; cv=fail; b=Ah+dhZrnkSdrB3mQvNsdLE4pCN01ErverGyztW0TCMCiMx+qE16pNQG1RngjXxAdhNAMCXNQojXwAFcFQ0/8NlI8VDeJRBwbooaqb1VMwKs4iwLvi/68jOuVLDg6jNgTao34rJUiCp7ZsAfh8XbJ+BdCnZeaGmh0XNUaes7ZZcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786192125; c=relaxed/simple;
	bh=X3SSR44NltVQSQ4MtvHBPdn1bcMGd2OdZ2KL/28VeKU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B/7D2sPCPUoGJPdFuDeDhRb7ZRMVMYcItQX3VnXtM4TRnH3ZGR4+ZAafYBtkJzSA0O9dBbnjuITwWH7MFQQYSTIpzQ2r00AOvLIyz04XjKLY4BfHBYlBDooilgpt270Ov9CfdToQe9FnZwZx4jsj1vYnEpYY2PwSpQdXVOLuRns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fjbDr+r1; arc=fail smtp.client-ip=52.101.52.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fjbDr+r1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RNYZTLajmqrUHn8K6Sx52UC2dWbsC19tfcd7LenYPslwyJVBvB50T8Lv4TCs4mBliWF1HA5X/smYdGjav5Gz7mYmWEuGnPy+jb7psPobF89AP9XCZPmdHv1eiNB8nTFz+M3ZWJ3cC5K1z1qDNmYD+MhtYWPhlRp7TLXYkUH7TIcFIvCeyXaeGKQeWo59dhTg/VJJvoZ13d69xztGWy5/+88XP6UwElV5mIyuLXyN7stsj2SFohKQ3wCPrSwfh/l5q3FVOGtygKfo3ticyqbO55WN4rd6K3eDv42BUiJsI8C1H4XRRePxb5ShWEdSa8M+Kn1mddknEGld7nPNNeQXew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GIm0ZC3qNYyoun9K+PkAT8BqnfMTsE/j1nJ65zno83A=;
 b=OoMtFWGT4/3539WFE1PTNqdJMmnA49nHwdjW6DMpG6RsvvAUJchUU53v3V33oedRrIyeCPaLdn9/F0fWs1juEQXaPyFRCSm1tH7L/hIVQCdO8Td0acFDAnKiITwZWTc0KXk1n6sJz4nwWTM3xpd9XnfiDBVgHQUVrxurspjCfFce8MY66L0gFrzmGEz6PUKrv4Ti3XGA/pnbJhcuRylvGoGYIBoH6GIsIFnFKNUVR5w0DLx5RLCysUUWuOHHQQrsgBfZd41zDvY0NryO5LBEO7gOl/CCtk8O89K8X2MBdEZW4Jd7qVsTGPkJhQjROZcInHRt9HPIgUXFImyKZWP25Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GIm0ZC3qNYyoun9K+PkAT8BqnfMTsE/j1nJ65zno83A=;
 b=fjbDr+r1HNvHJj7U5c04VZLPtZ4oQCLHFaXmgGNfdVbgKyslMdC3XDuXQLLCTeyLGXwe0cqeyuI+48A1OX1Ra424TExZrG4oY6JbzivCaE4kWueuu5fmvmPRHAnkxxC1c/aSWXF1a2uEK4fsC6F67GIwziV6yqKrRJnLS41DAVM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8147.namprd12.prod.outlook.com (2603:10b6:806:32e::5)
 by DM4PR12MB5937.namprd12.prod.outlook.com (2603:10b6:8:68::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Sat, 8 Aug
 2026 12:28:32 +0000
Received: from SN7PR12MB8147.namprd12.prod.outlook.com
 ([fe80::3923:c1a4:778b:56f2]) by SN7PR12MB8147.namprd12.prod.outlook.com
 ([fe80::3923:c1a4:778b:56f2%5]) with mapi id 15.21.0292.018; Sat, 8 Aug 2026
 12:28:32 +0000
Message-ID: <cd0c41bf-d9c7-47b4-a5e7-a19994e4df94@amd.com>
Date: Sat, 8 Aug 2026 17:58:23 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/20] net: xilinx: tsn: add endpoint MAC driver skeleton
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>
Cc: Srinivas Neeli <srinivas.neeli@amd.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 Michal Simek <michal.simek@amd.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, Simon Horman <horms@kernel.org>,
 Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, git-dev@amd.com
References: <20260807104431.157230-1-nagadheeraj.rottela@amd.com>
 <20260807104431.157230-4-nagadheeraj.rottela@amd.com>
 <anZG-AucFEZrwjjO@monoceros>
Content-Language: en-US
From: "Neeli, Srinivas" <srneeli@amd.com>
In-Reply-To: <anZG-AucFEZrwjjO@monoceros>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0117.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::21) To SN7PR12MB8147.namprd12.prod.outlook.com
 (2603:10b6:806:32e::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8147:EE_|DM4PR12MB5937:EE_
X-MS-Office365-Filtering-Correlation-Id: a8e809ff-0b4d-4443-6fbf-08def5488f36
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|23010399003|18002099003|22082099003|10067099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	4h3Oaj6Fz78EjDUROVpjNJ2noqT0Cj9gtcigcx/fQwZWYSdQr5uFShxzplV6iVYwZ5092ygtcMlYewED9TJgwgdY0yDPD+hkjKt56Riws/pvzK2gJgZW15dxpw62zFBCeSbnT5afet8dmjT4/2rK0LkaLQrzrDwXG3w4N147E6PTjw0JGhH79e7u8zJYAzuJZSMhtZCt973lc6iNcd0YNEQ2hRxdHnGZIRObeXcxtQZiOdfXst/YMMoNvu8hjLUvBDJWtOJ6/aLGpi059hTIhR2n+P61bTalA/QMX1HTJJfioIO5mAvAkoSm5H+z/CZGUpqA0epv5d91gVFqr1L3wx7pcGQ/TjIGaV509gspTuocyzTt0GERIOL9B8Le+b9OrrREQanSxipZBA2jsHCZfbCwBUhbzj/RwC+ZFO5twU0CUB6kLFA5WR0atv5lG5h0qWjYQxQl03MnHTDpyxrKtKpsRBuA+Vs8FE/68Ywp9KVewKQHoJnD89NdJQmIw3LzOSSM0nDyFqwAuV1AjV609qxSfIOk2cb4lQ2ACPwRf9DDEbuwsqT8YkusLXaqUmm8DBywk9HZLZ276jv6ulcjRoU30H4dNTnvrk4nM7zDcszdQDZ2x+qr1n+e8yNXg0e8WW0zEXiHLmVhPLqL5YvdgI7yku7O9E2glOlRSAFa/nk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8147.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3p3R3pySXpINWtHRjIwOEVWeFVwL0lsOWdaWWN5MmZ0cDMvZjUvL3RoL2xy?=
 =?utf-8?B?WXpLTHVZM2UwMDNHUjBud0pSVlczWmpPd0xyNXVLcWlhT2J0RkVlM0ErWjhk?=
 =?utf-8?B?VFhtVklSVHROQmkzdFo5elJ4emMxdmgzOVYvRTBvL3l2UXhQa1VteWdsTXJh?=
 =?utf-8?B?Yjc4b3g3bEtwV0xtNU1YcFNRS09YU1ZnMGZaMHFJUHRFU201aC9HVGNpNGF4?=
 =?utf-8?B?ZFc4VUZZQ1dINlA4OXRaenk0dnBXK3AvTkVjUFg4VGZQdFNmMmc0VHJFQnVR?=
 =?utf-8?B?c2EzWjZSTWlCeWVmN0s3S2RCS2lRTXJRVkw3NytWUm9RL004biszSHRpYmhi?=
 =?utf-8?B?U29ZVTdUUXhRR2w0c3UxSTM2QmNhM0lpTEFneVcvSW5sQVlSeld5Wkt1SVNQ?=
 =?utf-8?B?ZXdHNVN0RmUxSEVPZkpaaHNHbWNDcEpYSzZoak5TWVJReFdsVmtEUTNCbC9T?=
 =?utf-8?B?WHRjTzRqUjBYb2pwM0RaVUhMWVpCS1V1R1hnNWQ5c0EwaVkyRVd4bG1CN3Vq?=
 =?utf-8?B?UVhOU2pINit5TUJFNGo4TkE1c1BpR092d280OVhjTUNvV0RpWTI5UXZSVGdO?=
 =?utf-8?B?UWNtWGJML1BJUVhwT0pnWTJ1QUpDSmN1blBmdGFOVnpKblBrREtSNVM1Yk9N?=
 =?utf-8?B?ZHN1N0lKUFVyVmhzby9xWFN1T2RrcVpOMElCUmtENDVWWk1rYWpLZGNFeE9O?=
 =?utf-8?B?bndRS2xERStuZ3d5U29TYm5lOXRGdGlKV0ZZUWp5dDh0eC9XZldTbHNQaXVm?=
 =?utf-8?B?NnJCNHVjSkgzb3pqZlRJNjgrZ0FoSGVqOEV4MVNqcjdZTFY3bnphT21YQWhV?=
 =?utf-8?B?U0pPSmdheS83b2l0V1VJQ1VZUVJoR0ZaNHFla1Z1Uk0yOTVPZEdQTEpmSFRj?=
 =?utf-8?B?OUowUVY3c2dRYnA5VHU5OElOTHpodTdXVXZaUDNaRjV3SVZFcXVuaEV3TE9i?=
 =?utf-8?B?ZWVwb091OVEreWhUd0oybDg5S201SEg2T1VBL2ZFa0swRkZvTDV4Q3pGdG53?=
 =?utf-8?B?cFFWZDdxclJJeUE2cncrT3ZMT1lGZ3doUFc5ejNCTWswRmxGUHhjSkQ1eUNU?=
 =?utf-8?B?YkZTZ051RCttWS9nWEFlVFhqYldGcXEvNFRON3lGeU9GbWwxZVZYa2JvTndv?=
 =?utf-8?B?bkJMRzhGcDkvQ2RMeU9vQ3k2QWpCa1pqNTNuNmpzWGR4Wm1xN2pHTVZXcmVr?=
 =?utf-8?B?ZmZVR1lmWDd3SEFsU3l5MXZxc0NtcVFEWlFKck9jbitsMVVtbjJuendDOCtU?=
 =?utf-8?B?K2tzdlRvK0J0bFN3WUtmT2xTcU9CL0NGczVmN0loWlByVlRRWWdUMExOcFFG?=
 =?utf-8?B?d3F0N1NTSU9kS1lyZUpuUU1hK0k2NU9QZ0N4c3JEckVrL0RSWldRc3VkdGxR?=
 =?utf-8?B?RmdiclZNZXJtVVFoWWloZmdvdnhpdkxxZDdKK3h0azhuWHE2eHVvb2wyL3Fz?=
 =?utf-8?B?dmpyT0pFVXV2MTVLRnVoZ0NuNCtoOG1WZTZrdmFyVXVFWUdheW5YTElGdERP?=
 =?utf-8?B?UGhPam9LRXJHOGQxTTRYMnRnb1M1WXNZK2oyaHloWHNPbjNJUCtpdGpDakxx?=
 =?utf-8?B?SDNxck4xNlRQQjlTZzhBS3pPZWNIUGsyUUQ0dndjNmpUSmZrNUxzcS92enVB?=
 =?utf-8?B?eU5lcTZ6Ny90Z2lYRTd2LzlxeFVDUnJ4QjJQeUZtSVVPR1ZkZWZVZ1d4eHZH?=
 =?utf-8?B?ZkRJRlg0TWdSQnpVcGtTM1N1clRhRU5KTkR0aXRmWVkybGJHbE5PVktZM0xV?=
 =?utf-8?B?cGF6aHFSR3RLbFhBaWhhOWJZVnRDbnJCWkRId1lyZWJQMWh4R0wyQ2dncWNU?=
 =?utf-8?B?Rm1BT21pc09IWVRNZm4zWE94REp3L0FxTW96bHdNVGl3OTEyaUZScXkxcmt6?=
 =?utf-8?B?YXRJVTZLYjIrVGhPMGFKM3AxbWVhTngzRCtiOTFJaWQ2ZlhaOXNIUkpCeWdP?=
 =?utf-8?B?MWl5UkNsWU1kbC9XeUFNcDhDR244NUFqZm16UWNSUjVRN1FtUmYrSnE0TFhE?=
 =?utf-8?B?Zy9PQ1E5bDRla3o1ZGlIaFlEcTJpcmRhdDBrd0IvUlV6b2RWUEJ1Y0tmNkFr?=
 =?utf-8?B?bGVRV1F0VnhLOW44aHJra21kTWZXYXNuNWNyYm4xdWdzY3dOZENWWjJYTXBW?=
 =?utf-8?B?c2NzL0hsM3F1Z3M0YmVLQlpHRmdWd0k2SjJYS3gwN2cvaldtQytWaWd3dE56?=
 =?utf-8?B?T3NBYndicE52S1BOYi9rZllMajRGdU5NSTB1UkFmekk1aXN0MHdrZER3TWdt?=
 =?utf-8?B?NGR2SzdaK0NqOTVnMzliR1g2R0VuKzA1cWQrNi9ibjRYMXp0TXdjQUdLTHFj?=
 =?utf-8?Q?npQbwPICWYW0Gml1k5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8e809ff-0b4d-4443-6fbf-08def5488f36
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8147.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2026 12:28:32.6859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9vIFx+zTpnsSMOcXNVQlt28A+Rnh0REId5pflp3u+HiS+TjXn6+pWbLK2nZ6jWtv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5937

Hi,

On 8/8/2026 2:30 AM, Uwe Kleine-König wrote:
> On Fri, Aug 07, 2026 at 04:14:14PM +0530, Nagadheeraj Rottela wrote:
>> From: Srinivas Neeli <srinivas.neeli@amd.com>
>>
>> The TSN Endpoint MAC owns the IP's host-side MCDMA data path and is the
>> netdev physically wired to the CPU. The DSA switch needs this netdev to
>> exist as its conduit.
>>
>> Add a platform driver (compatible "xlnx,tsn-ep-mac") for the endpoint.
>> Register the netdev named "ep", set its MAC address, and provide minimal
>> netdev and ethtool ops. This skeleton handles device bring-up only, with
>> no data path yet. So ndo_open just starts the queues and ndo_start_xmit
>> drops frames.
>>
>> Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
>> Co-developed-by: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>
>> Signed-off-by: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>
>> ---
>>   drivers/net/ethernet/xilinx/tsn/Makefile      |   2 +-
>>   drivers/net/ethernet/xilinx/tsn/xilinx_tsn.h  |  15 ++
>>   .../net/ethernet/xilinx/tsn/xilinx_tsn_ep.c   | 152 ++++++++++++++++++
>>   .../net/ethernet/xilinx/tsn/xilinx_tsn_main.c |   3 +
>>   4 files changed, 171 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/net/ethernet/xilinx/tsn/xilinx_tsn.h
>>   create mode 100644 drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
>>
>> diff --git a/drivers/net/ethernet/xilinx/tsn/Makefile b/drivers/net/ethernet/xilinx/tsn/Makefile
>> index 6f99226f3dc8..5886828b386f 100644
>> --- a/drivers/net/ethernet/xilinx/tsn/Makefile
>> +++ b/drivers/net/ethernet/xilinx/tsn/Makefile
>> @@ -1,2 +1,2 @@
>>   obj-$(CONFIG_XILINX_TSN) += xilinx_tsn.o
>> -xilinx_tsn-y := xilinx_tsn_main.o
>> +xilinx_tsn-y := xilinx_tsn_main.o xilinx_tsn_ep.o
>> diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn.h b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn.h
>> new file mode 100644
>> index 000000000000..b0757e22d1fd
>> --- /dev/null
>> +++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn.h
>> @@ -0,0 +1,15 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * AMD/Xilinx TSN Endpoint Ethernet MAC driver, shared definitions.
>> + *
>> + * Copyright (C) 2026 Advanced Micro Devices, Inc.
>> + */
>> +
>> +#ifndef _XILINX_TSN_H
>> +#define _XILINX_TSN_H
>> +
>> +#include <linux/platform_device.h>
>> +
>> +extern struct platform_driver xlnx_tsn_ep_driver;
>> +
>> +#endif /* _XILINX_TSN_H */
>> diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
>> new file mode 100644
>> index 000000000000..9b556edf5423
>> --- /dev/null
>> +++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
>> @@ -0,0 +1,152 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * AMD/Xilinx TSN Endpoint MAC driver.
>> + *
>> + * Copyright (C) 2026 Advanced Micro Devices, Inc.
>> + */
>> +
>> +#include <linux/etherdevice.h>
>> +#include <linux/ethtool.h>
>> +#include <linux/if_ether.h>
>> +#include <linux/kernel.h>
>> +#include <linux/mod_devicetable.h>
>> +#include <linux/module.h>
>> +#include <linux/netdevice.h>
>> +#include <linux/of.h>
>> +#include <linux/of_net.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/string.h>
>> +#include <linux/types.h>
> As for patch #2: Please drop <linux/mod_devicetable.h>.
>
> Best regards
> Uwe

Sure,  Will update in V2 series.

Thanks

Srinivas Neeli

