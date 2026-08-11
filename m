Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012070.outbound.protection.outlook.com [52.101.53.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFB54772B4
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 19:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786477083; cv=fail; b=ZKsbipbqhaTN7Eoztvh18dmeBoWY9ILS1RqvTmnSAEtIVgNVhCxWVM54IDmSFORQqCj3GzPMy8VsU2lSeQuzz3b7lkV4EGPkTVUYFbHe9v/TbKThBQE16K7rSklNG7/zGwEP3irldusSk+aFrt01wRQ61JEMZVD3R+AZ33X4hR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786477083; c=relaxed/simple;
	bh=wVB32Avc41Owy3I0n7oK18ulpm9yOu6E4ogIxaNh3Ls=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XkQei8oQDy9cadkTO4GLv/zm7+U8hbw8qWf1W+d8QRRIYoPNKtdT01we4YOlplhftGN/OXXv0ZW9KonY3AnPnvt0QIsqMRI5XJtuAIqgd7dq4nMufBsrVbfB/FsJ/sQ9FKb0QaUc8ixO+W75Rna3A4tBe5cbJYKF8aSfaJ66BOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=To0Yi5W5; arc=fail smtp.client-ip=52.101.53.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="To0Yi5W5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yIJrHT6q2E7/+/i6/n2w7w0AuFSEBdudEyMiFrCMwDP9quJ/izmAiSEhCR5+HPV1mHgDzhwC3zmU0xM0RPNIwz1LCfBCxx21qSdMQ0QxjwI0htDKTDrV/6VNMynpwVOq7CK2UBsc08DIfSvUCHloVmk4/doETlW4HOQMReBDxDydl/70LLHbbfvOo33R4bDO6fZX4CzdouD0FeKcSHwhp6Pcu7yldWuv7x8F9ePbFMByXQWYMvYTikiJ443pRxBwONYSMvmxdoW9nwGwSmfIMsktMemVW60Lu//oVZgsDgSPLqFeYG7u1dYhjq76qCQtGKmYVU62DS5+JMt0+g6Wsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wWpuisYEm+E+OhDEErd1DtFx7Jp9gRYbCSl173BGcgM=;
 b=cOLRrlCUXmE0vBNpTGTgWieh6ep8hJlTMG8B+7zjUNwLaeyrY+ANXTgYL+AvLKddq/AZEBoD6UlAMCoynVJhBw8GWvtU3bvYBCOlkOa/G1qDuJmBlEo9AxIgxPehGvYQV6Fo1KuLuYDnjMms7y10YxMgTzw+9e2h/bfnvrR5ZLylAKLLS9mIhYbHbk1pIk3Ihe8Mygx4Qk8+N6FllHF4n579vhzTDGVnT2McI1qxCILVrbw6FpCb8EntbN3WPeLQC9ntBhzYL+eFDKmJmgRniQqhuB9oTMnc6UNm73wjTButxAMAbnr0SohoTi9hN7l0jVbY+797fZzJSgF2727Ikg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWpuisYEm+E+OhDEErd1DtFx7Jp9gRYbCSl173BGcgM=;
 b=To0Yi5W5XcIiG3Uzu0/VV+YD0yd/D4lWTJAJHM/VlCA4PURBxtd4lz8wCd7GTSS3U5fqwuV+kon6r6vQGgerrjE0JMinF726DdJaVpmMImN//AT/veB4LuBtRjOEPz9nR77T1FC8CRoZV3I7wclWEKq4YJFEjrqZooCiQsgKt7w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY3PR12MB9701.namprd12.prod.outlook.com (2603:10b6:930:103::18)
 by CY3PR12MB9579.namprd12.prod.outlook.com (2603:10b6:930:10a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 19:37:58 +0000
Received: from CY3PR12MB9701.namprd12.prod.outlook.com
 ([fe80::ac7a:9f2f:acfd:9ed9]) by CY3PR12MB9701.namprd12.prod.outlook.com
 ([fe80::ac7a:9f2f:acfd:9ed9%4]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 19:37:57 +0000
Message-ID: <6cf1198d-5d64-4782-affa-677453e77338@amd.com>
Date: Tue, 11 Aug 2026 12:37:56 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 0/5] ionic: Various bugfixes
To: netdev@vger.kernel.org
Cc: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
References: <20260506035706.12373-1-eric.joyner@amd.com>
From: Eric Joyner <eric.joyner@amd.com>
Content-Language: en-US
In-Reply-To: <20260506035706.12373-1-eric.joyner@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::39) To CY3PR12MB9701.namprd12.prod.outlook.com
 (2603:10b6:930:103::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY3PR12MB9701:EE_|CY3PR12MB9579:EE_
X-MS-Office365-Filtering-Correlation-Id: 83617d6d-f8bf-4374-1977-08def7e00bd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	AfQ2wvPfC9xTGMkgaULq4mkeFSQzyBLhcTrp0Z4YQEqohKiWQ0rUv/VmVdfvZ16bEUEHcQkovh5xudHppkY7JIwHBDAy51SD9s2nOcTIvID3WQXCP0YJsbKFzDw77DFBFazYJbi+X6w2BpcwpEVPan+E1R02QFbB9jVOi7ObTJyKYS6Eg4LqVJjFS+xMfr5lerl8DIed7nvKfHMY4LnE6xIPNAKgX/BjIyCI/DkVSe//xK1dJZ138xO6v2O5XdkqMhSEfguuueyucDtXiQP16FTb55QvTV2Xt41hflpssIzB4iY/p8sOFo251X0qhdvK63ejYIRVNTCk+IcbPUqsecFBjXlK6GRGpbL/DcNuBDR0WwCQlKhu9hOFnwr2efPDsthYPjnTMsBQ5t8RbaBvzuPEeAtkIw5HsictwYnfn1x56DQs2H0tB2f9gw4sVxjsYsPHdYy125nqHRvawQUOfKAYK42y4Y3jMCEiWYKtyQZeqPcOs6Op4eZzQO55onUjs7N8bVC/mTcNI1tD4yb6Tfz/6j4LGXYOX9qkOnybRt9Z1p/NmzECgbIdd/V0oVP7COWMqBX0L+t4p0VIqATWzdFFwea2tXRdsgYmCih8mkMKeuDL78tJivQfqNqtO1F5INEIKoca3wx8KNKvuGvw7sDu5f3BRrAGw5OeKdYm6qM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY3PR12MB9701.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHo5enpncFRQR09scGdkOWhoNDdrK3EreC9MUkNUR0N1Y0NISGZQWkVVdGpL?=
 =?utf-8?B?bGJhZGZQK1ppUzV3SVZWZjZRb0RjSTBZYmk2RWtBRkg0L25hY1c0R2hQRlUv?=
 =?utf-8?B?WE5TUks2YjdlK0tZME9hZXd6REYwK2Fwa0RZZEZ4K3p3VThBTGpTMm56Y01X?=
 =?utf-8?B?WkNYZ0ZFZDJNVEZhMytqQjBVcHNmZGZSdGlwWWkwZW9YeUFjRHpocWFlTUlV?=
 =?utf-8?B?Z2RSOTl5YVQwSitYRDZSQWhjSmRXM0R6YzZMWnZDQjVTczJSZkw0cmVuM1pH?=
 =?utf-8?B?Z21jNWtsdUVMSFY2cU16S0JOSFVnUmgzajg1MFBYOTdSTmJ4SFpCdVFQQWps?=
 =?utf-8?B?bGdvNldJOGozK2g2UFNrQWlpYzJSMVBLeG1hZ2V0Y0daWllYWm0xT0FSamZY?=
 =?utf-8?B?Qit3eng2aDdXd3FPRjBmV2R6dytkRW85ajVmUjZmRU5HeDAwekhDdDg4UHg0?=
 =?utf-8?B?NzUwcGdJM005WGR3c3d3N3BZUytjQ0o2ZWR4aW56ck1la0FQd0QxQWFETlEw?=
 =?utf-8?B?L2JvQkdORk0yZkZmQkh6ZW9ySjRBS3Nqb1NjQTlzRURlaXorRDIrK0FIK0lD?=
 =?utf-8?B?MnFlczgyMVJ2UjFHOGNia2plZ3NJN3dlSjZRWWYwMjZ3K1UzcDhJeVJOMlRY?=
 =?utf-8?B?MlU4MlpvUVZoclljMzY2dmhVUTN3OXZBRDRrd0VpaUVPZUd1cnExaVB5VFM5?=
 =?utf-8?B?NFRYcDVoczNieUdCYXRNTkhCaGRLZzFVL0VwUm4yYzhLWHdqYzZsamEyWnhk?=
 =?utf-8?B?b3pCZVlGa1Q2cmEzZDBSayt2OUtNR0d1T1ovMnpDZFVDS1MwZlVVYkgyVlhH?=
 =?utf-8?B?Q2YyeHpHeUhTbW1zdURCTEQzdEJLa2VIYTMxdzdsamFFcHRvSVN5cm1MRkU2?=
 =?utf-8?B?eUNnWW9ob2NuUzBRczVvbmNxS3FTcFFiUDU3eSs3ZzJsNE9UUzVBV1pVbU1B?=
 =?utf-8?B?dFNxeG5ZNFZhdHF3S3dUWHEvUDdYczJUblo0T1VJSU1YMmt1eHA1a0dZemZN?=
 =?utf-8?B?Rk5nUnlQQmx3bmdFQys4NEtPV2dLd0JvVnk3VlZJdEZ4TkdKZktvQU9iOFBP?=
 =?utf-8?B?YmoyVnZPcm9pelFRMjdQTDMrOHA5WGQ5MGZuN2FvWEJKeUVFRnFQa0RJVzNM?=
 =?utf-8?B?Rm1zU0VPNE9HU2llcG9LNFFpMzFCeHdVVzRtUmJQVjRtc1Nrd3c0QUNXYVcw?=
 =?utf-8?B?cXZvVzE0WjNxWGpqNE82Qy82YS8wOFlhQlVkZ0tXT3owRCs2aFlObDNSQ0d2?=
 =?utf-8?B?MzRxcTdwQ1NZVmZxL25IY1RKK2s1T29MRFV1VkQ0ekFyc2hKTDBlM1RCZHlY?=
 =?utf-8?B?bkZNUGlkTnlpRXVPV09MVGZNbDcwZEl5UDZTYkZvRUpGaUV5Y1lGVjhJMVpv?=
 =?utf-8?B?VzhDaUYxSDVBQStoclYyVTZNYmVsMFZtL0d3TDQ4bi95b1M0emlXWVVtcVE4?=
 =?utf-8?B?Z1F4U0R6OVQ2NDRoSDFjVTJOd2tQWHRFcnRoU3FKWkNNbk9KYXJyUVZKa2hK?=
 =?utf-8?B?eVVqc0oyYWgreFAvdUFjdFpGNVdORVZoNS9BZlNvQjd3eC9vYlVVK1o1SVRp?=
 =?utf-8?B?Nkxudm5ZNkIrM2ljR0E5MjdFVTl4OFErUGVGbzRGck5xWi9kdnl4Mjh1MXpU?=
 =?utf-8?B?WXFyQVB6WkdKSFZZbFRrNlY0bkdmdmg3ZzVsQStFdWtMSVFMdW1PZ1BvRmZa?=
 =?utf-8?B?a0JsZFpqMktaU2NQR1QzR2Vva3pzMXFDeFk3MDhja0JxZGdzb2JNb291bGw4?=
 =?utf-8?B?U3Z5UHpNUnBOMnRmQ1N4dEUyS2dMYWR0RnJJTEt0a0h6TG0zS0p0QlZZTUJr?=
 =?utf-8?B?WnRSeXZ0MlRNYm1xbEltY0VuZ0tsempsOVlJS0g1aSswRk5lMHVIaWdiaGhn?=
 =?utf-8?B?bE9IbFloWVFzREo0V25uV1JreDl5eWFLSjNLdUtFUDFhYU1sZ1Z0Z2wrYTFT?=
 =?utf-8?B?U1lBK2VmamFSMHlsd1RrYmxSbDFOZlJVMG9CVEd4elhrRDgwZWdmVTRmOHk4?=
 =?utf-8?B?T0VLR0tGRytTVTErTWdmZWhpSEhXbjFQMlhud0dtSjJyeG4wd1hFWE9pcmxS?=
 =?utf-8?B?RjdkWmVWRWRrdGtxT2dEMlI0YW9YSG9nWHJPNDdDYThUSDFSb2J0bWMyQXRw?=
 =?utf-8?B?VGdXeStrK01CRzVFaENoVFFXT0RldUtGc0FMMUlGMWMyaGN0MmRCT3Nud2p2?=
 =?utf-8?B?WWNXYlNYWEVockJHczA0ckNQMitDYlB3Q2NVZUY1NHcwdE1yaHhab25FSDQ3?=
 =?utf-8?B?dVR2YmpjM3hoY3ZmUEwzWmtzMFp1T2xvbGQ3dTBOMTNKcjUxblF4MkVJVFhU?=
 =?utf-8?Q?e0PvcrjjMjl5XDAQih?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83617d6d-f8bf-4374-1977-08def7e00bd7
X-MS-Exchange-CrossTenant-AuthSource: CY3PR12MB9701.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 19:37:57.9070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IC38wpeNCsj3Vh94ooBQy/BvplHYsIBzX7AgdAraCcfyAlS0KDT6u1hKv/G02Vtx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9579

On 5/5/2026 8:57 PM, Eric Joyner wrote:
> Brett's patches mostly fix issues around communication and configuration
> between the firmware and the driver. The one that fixes the check in
> ionic_get_link_ext_stats actually makes sure the stat is reported
> correctly and is a precursor change to have that link_down_count be
> derived from the FW and not the driver. These are all fixes to issues
> that we've observed internally.
> 
> Prabu's patch is critical for enabling PTP/HW timestamping to work
> correctly when the completion queue entries are double-sized; the offset
> into the descriptor to read the HW timestamp is incorrect when in that
> mode.
> 
> ---
> v2: Drop Admin Queue fix patches from v1 pending further
> examination, and add more context to the cover letter
> 
> Brett Creeley (4):
>   ionic: Allow the first devcmd to trigger deferred probe
>   ionic: Handle failures from ionic_reset() when relevant
>   ionic: Fix unexpected dev_cmd failures
>   ionic: Fix check in ionic_get_link_ext_stats
> 
> Prabu Thayalan (1):
>   ionic: fix completion descriptor access with 2x desc size
> 
>  .../ethernet/pensando/ionic/ionic_bus_pci.c   |  8 ++++--
>  .../ethernet/pensando/ionic/ionic_ethtool.c   |  6 +++--
>  .../net/ethernet/pensando/ionic/ionic_lif.c   |  4 ++-
>  .../net/ethernet/pensando/ionic/ionic_main.c  | 12 +++++++--
>  .../net/ethernet/pensando/ionic/ionic_txrx.c  | 27 ++++++++++---------
>  5 files changed, 37 insertions(+), 20 deletions(-)
> 
> 
> base-commit: e728258debd553c95d2e70f9cd97c9fde27c7130

Please drop this patchset; I'm going to submit a new one that drops
most of these changes but keeps the last one, along with the fixes to that one
suggested by Sashiko.

- Eric
