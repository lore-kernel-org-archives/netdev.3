Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010007.outbound.protection.outlook.com [52.101.85.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1B32ED848
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 08:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786610013; cv=fail; b=aUlzRfmFtoQEjegvqq58++N0nIjCw84WKmPNMekHyi/6oX9/sBf9ETDCNOEB0rR46EQQaQ22E5/3CgTcTebDlYKQNrFNZhxUY9m71jNVB0et2vzqzjlAhIEflkZZGqQeAf7pAu68CE/OA3Bpq6ZIAyjgowRAdsmqWAYd14YXl7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786610013; c=relaxed/simple;
	bh=ie7e4bm4A0EBP7VrpdAn5VWH/H33eTadMUcwRNtyhk8=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=kH0pmdt6n3ejTXIYkKwQ3GAYwO+ESMh38iv1/E7VDO69IkrQNN5YNDn7+V5CF3+IHdx4Dyjx+X0Yw4w/rGlYYDdF8Nz4DqH9zw5B64fQqaZlLdXwWxhw8HzJ++3bV+VjUlPc9fpANSQ4m4OtNvb5fUYktqbiAHaeVHHVxMdFbkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f7G1+Ns8; arc=fail smtp.client-ip=52.101.85.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f7G1+Ns8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eudaGU++E/YUpralHepGwQLGoEG9VUyFNsv6pdSHNZliN1Dg0HUVy0togbal9w8wlNd7Bvxt7ph1n50iLQqOu8/nn3UCFVMYSlNVivvqwW8YBuf1FrjwwjH7BUV8GyK5RdUWsRm0p5ZN9R54ZggiLUGNIqADZA3bbih8TaTDZVTUVE+Fr1yZGFFRTolvUuGmwAWB7gVc5TFKE2WFnvL3+L4ffRPbFmj/yjjGM/3KRSXpanwlkphr0/0CbkY5y8ymll8jwgh7veOwnPb53eIJJDBYDoub53T3F1n6FERRxb4NasD550Dlbwpch5vKuHOqEnCLlySVwU0fPrzKDtOfiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o7Wy23l3Dgvr9AyZiqozOKEKxEUjO7uq6PhlYmxTnoo=;
 b=hiCM9yLAlq2Wh2GLnsDrcVLNe8nmoKR6ltpjMSCeHW3nr5O27IMoS2FESnQza1Z3C4WUodvzCUTHg0Q3jFGctXwdrYDEnxrl2qcN3E7Z8s/NjY640BafyR6qFl+a+HVhitKqQvrSfE9VhuMvvmy/mG1eHof0tORppkmtABZwn9IWUIuCo6B4/5pfpgMBhfqD753fz8QDxKmzhasE94UwS912y8Mbb2lMLHqBDZhZDy2UDqBv6djCYMdHWUdgLJWoRskdEyfmOflKuE/wrSnAgUWYOplQAl916T+jQY0jMBQwxjisiU/hesW3uyK+T1WTCb37USa1eBhhJ69Ga2/x9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o7Wy23l3Dgvr9AyZiqozOKEKxEUjO7uq6PhlYmxTnoo=;
 b=f7G1+Ns8SCC4b3rwZVOk3G19R4vhvr94HCpcwiw2+OxAX4koIQOo+L5zOqgUaAg9rdF9s5kra9AgOhAjnwIyBr7a1nDR581Ip0AJqcX+k4irCrV4FRzJhDMucLXDv5ESzq+f34SV/zESoZnckn50B2juqlratIF+kan3UMRQ7/FV9zHzPWTz8UKTX2u9t5yCGzg0LVcwa81dtlLpqKIWMAZwWXys8YPkkkPpUfuC1UnN9edPJn0u56cNFVN59MgTHmT8vaRarwgHdnv0PP6r0l8mv3jK3MQmdmG5bx6I/ld83aI/AIUm6zF2xOhcEr11xTeAd3PV7V1CtqkKCX4IdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA0PR12MB7090.namprd12.prod.outlook.com (2603:10b6:806:2d5::16)
 by DS7PR12MB8201.namprd12.prod.outlook.com (2603:10b6:8:ef::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 08:33:28 +0000
Received: from SA0PR12MB7090.namprd12.prod.outlook.com
 ([fe80::de78:df30:c2e6:7adc]) by SA0PR12MB7090.namprd12.prod.outlook.com
 ([fe80::de78:df30:c2e6:7adc%6]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 08:33:28 +0000
Message-ID: <ba322fd3-9f91-4e2c-9000-12d473ecb249@nvidia.com>
Date: Thu, 13 Aug 2026 11:33:23 +0300
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, ttoukan.linux@gmail.com
From: Tariq Toukan <tariqt@nvidia.com>
Subject: MLX driver for host-to-ARM communication
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0373.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::20) To MW6PR12MB7086.namprd12.prod.outlook.com
 (2603:10b6:303:238::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7090:EE_|DS7PR12MB8201:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ec46031-70e8-47f1-3df4-08def9158bfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|6133799003|56012099006|10067099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	ZKnxAYjwdrju5Op/f3V/saC7r66Ji7Z8BauEj/aiT2R+tM8qqxfc0bI38VrTlwuPR/od/c8lAYBc3dyiEKwMvohdLkHZX5kEDtcun6BvsNvns5q6no3Wfd4IPh0epOsaeDPVZS5NEkj180nPgUopfg4kUKQSeYBtjtXuNBB+muLntpkZ73qEdXvUdd4Typ6xIepcN18d2ZIXzmX4oRfAoJin/V+yxrWT+VLSCp1CHUMr4wYPMq0mmWoLcvuToIdVtDcb6s9WITi3Mk4ZMe9uN5SM1yNkOoJ1DUk1bq2AG+Wb/vCmH8pWc76MzhTHi2zJ9No3mtTABv/iae0ckT5MLVlL4Jm0ylBWTvICpkk/41fn226dJrFPwdaVBzgZrERiL7uO1kz67umlBAdjVxQiuQQV8RFIvjErIlNnfTJ2jNaI44I5l7dkjltMiZfp/477phk/F2KJsI4SxvPSkZ38wcmj42ur3MpOB03RH6GIKSs6lWNXZCtvyDUUniZHqWU4YXKjIm8C6scg3YbLH6viTTTfN8ZBirmygL7DviAYAfM4WycTugVTQ3vq4/u+Du7Tfmm3oqwJzLu+dgGooB+0DDk07qL7jLEk23lYFx8fN+w3qCOnilMvwbIi1azxbHaiTzCgoQiy2O0+eIx284wsUxVs7QfHCyGG4WP5Fz5S9QM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB7090.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(56012099006)(10067099003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cjFQMXd4T25SNnhPSGpCWjkxSFpHWkErMFdoamNmczJBajhGNmZkNHNEK0RS?=
 =?utf-8?B?TXF0ZllTblpPL2JUMmQrZHBlYTRYMHVWU254TkpodXhkRktLamdlWFZmZ215?=
 =?utf-8?B?ZkpwUGsrcnlTK0FmeVloYW9teVFoTTBpQVJPV2hQeFZLVm0rQ29CejliY2VM?=
 =?utf-8?B?eTlNWWI5Qm9EcWdwYmZTSlRZZTk3VC9HTzFDTHN2SFJuK3c3SnVqZ2o3SWZR?=
 =?utf-8?B?QVNyTFFGY3o2VHkzY2s1cWlNcHNHdUNnUm1EeUNReUQwaVdaMlBSbU1rLzU5?=
 =?utf-8?B?aGF3TDVld2lzUGNUcmtrczYyNjR4YWs1NmdJRXhIWlI0Q0dNNnhrUDI0cG9s?=
 =?utf-8?B?a2RmM2dNWlJ0TkU5MkNMYm1FaDJ3QTNOQzcyL3VSNzFlRFlnRDhudytUeTZX?=
 =?utf-8?B?MmUwT3lSa1dSeEV5YnlMYW9RY1BMSTF6SlVJTHZ6VThCZmpMcjZ3WXRZckd3?=
 =?utf-8?B?Z3dseVh1ZUFhUGFLRHBGUnhRS3NhMzhKdVJrUkF4SFk2TG1xVGhXUitIT1Uw?=
 =?utf-8?B?TFdCdEJMVURsa2U0b09NV0pKSDJ1WVUvK0ljY1RLSEQwVUZIL0JMNnA1eDla?=
 =?utf-8?B?dTZ4SWlsZjNWVTlxMm5Ob1RnSnVtNjlYQmRVQllJTnBpQW9ESkpoWlhJYW9h?=
 =?utf-8?B?Mmg4RzlHc29xaGYrc2FRSTRWdS9Vd2l6bXFOa3FvZ0poYzZQNmlCMzZ5bkxo?=
 =?utf-8?B?OVJzWENUWlJGTzdwVFVEaFNXc3Q5RXZwemJLdFEzZUdWZkp4UnBGelBqd2RF?=
 =?utf-8?B?UDErRVdGYU9wY3VlL0JxZldZcU9lemJQNzVUZlNkd1k1M291N3pHOXptM0RF?=
 =?utf-8?B?ZDR6SDhCMW91NHFxZC9kMGhFZjhmUllaL085MnJpVVZMWDNwN3ZZeE81SlNT?=
 =?utf-8?B?b0s2cVcrK0dyUnNLMm52dXI2YlpSTFRnQWZSOEhkWktmR1pWckRUQlNUZkRm?=
 =?utf-8?B?WlRzWlkrTlVLc1BFNzhMUldMbWVnTGs4Ly9PUHFqU2NPU25LZ1BVeVRnTU1r?=
 =?utf-8?B?akFUWU41M1V2MXllMFlURS91TW9mVkVaNnRDNUs2ZFhOd0s5SUlpU2YvMkdq?=
 =?utf-8?B?ZHlUbmxTNlFucEEvOXZ4QVZKblBNeVRkQ3ExeWdMcjVuV3kxRlZaY2gza1dO?=
 =?utf-8?B?Y0xmemp5NG4xU0NWZGQ1c0JCWVhNSXgvT1VsZFlTZzBQOVlyVUNka3hpZVRG?=
 =?utf-8?B?RFMyQ1RjbFFmeUVLOGhRYjJtWkloUVhDOU9NRVNwcU1SbW1WMHFQMVlTWFdY?=
 =?utf-8?B?TjVlUXdJOEY5ZVlucXNMa1NtdDVPQjZnMEU2MW0ybk9CVWR5VldhNFVCbUY4?=
 =?utf-8?B?bG9SQzdzelgzSVVVd2g1YVBPQlZ0RTNXeWRqKzhIK1hDM2FoSDhhd0M5ZU05?=
 =?utf-8?B?Z1RKelBlMFFDTnRRVi93OHdnY2RJamN1ejduWTliWHJpUnFudFk1eVdJblE2?=
 =?utf-8?B?RWtKNCs5K2k4SDVrTUYxd1BQMC82TVJpOXBWRDUwcmdBOFY1cFF4YzJZTzBH?=
 =?utf-8?B?NGJ4c0NFd1p3VWZ3WThLZHhqd2pNUUxJWDdwS0Rka1I0eEpFTjh4MHZoREh3?=
 =?utf-8?B?ajByOHQ5a2MxdTRvNE8rVVVRQTMwaVBEWXBjbVk1djJTVmYyVTJVYUlxbUFm?=
 =?utf-8?B?WWhpY2hrV3FJTytTRlBHWlhaOFE1OGhWbUNUZThBTHdybU9XcTZodmhQMkZU?=
 =?utf-8?B?NE1BQkhNYTAxbGhnWlErVVBSOFFJSlVzR1ZVNGtCaHpXUnBaTG5xa2FKN0lM?=
 =?utf-8?B?NGpxU0kzV0E3TWlaVkpkczhUN3ZuZWJ5SkQ3Y0hCM1EyeTl2eTAvZ25ucWsx?=
 =?utf-8?B?a1JBU01GK0g3TTBsOGVKQmtlTUE3cjVNQ0d1K0JRQ2dGQTVtY3RBckFTNElL?=
 =?utf-8?B?eVd3b1g4b0MzcjlJaEEwaUZ2NFdkbEVBalQvbU5DL0twVEFGOEN4aXovVHlX?=
 =?utf-8?B?bUp0bWk1ckZtRFM3TjJJWFNqODNHOFZqS0h0QW8zNlovMy80S0NUWTFKUXM0?=
 =?utf-8?B?R3ExZ0tTdnM2eXVOMUwySUMxS2JsQWZrVlBXc0VMR0JWS0xWVCs5Z2J4YXJq?=
 =?utf-8?B?RUhkbDg5M2VvYUpLTHIyMUZJWllrRGZ5V1h6UUg3SURYT1VYeE9JZW9xZnhC?=
 =?utf-8?B?bHY3eDYyTVRicXlNRVc5T052T0ZyaVVtd0czc25MRWVBcUFNTVRFYjFRRVlO?=
 =?utf-8?B?bEM3MnFUR1E4UTVnVkE0TXRGNC81TU1ZUFBUbXlZQnBzZi9PdEhuQnl6ajZS?=
 =?utf-8?B?TlFJK3VUdUJWcFNZOFFtK3g3QS9MR1NRR0NSRTdvT0pLZFEzRW16bkMrS1E2?=
 =?utf-8?B?NEIrNEQ2ZXhFbDBJc01oQUVZYlpPaVdzTkkwK1NEV2VwNHdvRFZSUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ec46031-70e8-47f1-3df4-08def9158bfe
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB7086.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 08:33:28.4601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bgMCrs3SPCKmHBSZx7+ohPrhTBSo+YzmDqRUSZuuh/DYYxONm6CHju+JlDwVJQlYsaVMYxajTlsTign6kH6Uaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8201


Hi,

I plan to submit a patch series introducing a new minimalist MLX 
host-to-ARM communication driver.

Could you confirm whether this series can be submitted in parallel with 
our regular mlx5 feature patches without conflicting with the 15-patch 
limit?

It is to be placed in its own new directory:
drivers/net/ethernet/mellanox/mlx5/nodnic/

Find more details below [1].

Regards,
Tariq


[1]
net/mlx5: Introduce mlx5_nodnic driver for BF4 management PF

BlueField-4 no longer includes the RSHIM hardware that previous
BlueField generations relied on for host-to-ARM communication. In its
place, the firmware exposes two dedicated management PFs — one facing
the host side and one facing the ARM side — and configures steering
rules to loop traffic between them, enabling host-to-ARM communication
through standard networking interfaces.

Add mlx5_nodnic, a lightweight driver for these management PFs.
NODNIC (No DRAM NIC) is a lightweight interface intended to allow
simple packet transmission for minimalistic drivers with a low memory
footprint. The driver communicates with the firmware through PCI
Vendor Specific Capability (VSC) — reads and writes over PCI config
space, unlike mlx5_core which uses a DMA-based command interface.

Each management PF exposes a single SQ and a single RQ that share
one CQ. The interface configures two MSI-Xs: the data MSI-X fires
on CQEs, driving both TX and RX completions; the event MSI-X notifies
on port state changes, where the firmware brings the port up once both
the host and ARM sides have gone up.


