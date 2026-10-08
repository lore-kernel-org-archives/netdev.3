Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012016.outbound.protection.outlook.com [52.101.48.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9694D0CDC;
	Thu,  8 Oct 2026 15:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791473645; cv=fail; b=HNi3fIhzZc1zwXMmUoLre9lBE4CEAQA44Bjo3z/2nIBeozlANSegNPF6rN7q73xSmE/AYT/In/+UbsCm1sHxCM/RG2bqsD/3CfMWGbeLOan+xy4M1MuGtsZV/qXHdVyXtWmAsAJzwB0iVwzm8Nybz0Hb5j8hk/Y+WtVV13cyII8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791473645; c=relaxed/simple;
	bh=g7dq4V1X0ejIFIQ+qyzA3MNBtRF9EkqZEkEQUBHZI6Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=alAr2reAqKSC3NkB/upTGnUIPnWoqJMTgMnMYrAR/Rg1abM1pZ3vU4NZPP8n09z0J6IxxaYSC6dlNil66CwE7AxtnmzZyplTFn0Bh7FxzRc8hEAAQkbPgO9rt6y0hvYRTwDbOl2Ux5OuAfDeOoDOQvk0Jh+s7bGBBLnnOvmsmeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MwSQx0Xx; arc=fail smtp.client-ip=52.101.48.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MwSQx0Xx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ErjR15XSQNWF1Bz8aYcLgi/Ejyt3r4jNFQ+nTecnU2U05OGsGw2ZHcnL6X0YOxP92xMDKYzbREJVgctd03vvn6fzcug7zUISDkqzCukb98K9vj8GGXmUU2YS2yVRjnt4PC2wMp8PgdXkEQ9haKK+OqKi7jGgXvMkHE7D7s5X7EZFBLyA1SCZGu7RiJmXcg/tB/hXemhjEqsye6DQG5a7pUB+bZ7VbVLbTzFSvEmLhzveITJmaknaupds4H7acGN8MJFfj5ksQG9pmrDxMM6PzHCtVWIC6+/TQUpP/8TcszvumHEpfDMFtyCXXZmisjnmtSZxsPCuTziIqknTbloOeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zo52sS4Nti2L6RM3AS7FjGFYrWgiHoj/QBj4LbXUTa8=;
 b=ntuHRm0QNn7lFVcWnZAsejRItqmilw9RiuiVsojYoeB2s0ZLyEyz7/b2slj+c/7hBwDtuv/Wgd3JgConQddDrGkxTogXZ0IzDe7Wea41/zQvdYNUgWrY6fe69433g9cGrtiPWPHxSwKdWv0MD7e3p3fCTjbQ6lZbYAXjPNQ4WNRs14iueyiRHOPmL30m8QYde+EmY0jk0ZeL5cZEcTFsMytVpaVR7fdI3JhT/uhY2ove2puDy+GgybNd882vT8RPIYWJrLc0iAIHg+wHcyxApERZMcHh6mAhBFelkjhkokJWj+8stIVKeBEaarysvZe5bOwj5ewUH8F/anqLGAk/hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zo52sS4Nti2L6RM3AS7FjGFYrWgiHoj/QBj4LbXUTa8=;
 b=MwSQx0Xxmx/+15qQbPPs5owjnV42Zuj/BOih8mEK4ulUXC5RRbpncyHICUIUFq76n1fbBQjS8MLbd4N7ssDBwD6yyCb5bcUAguJxDzwFbkJzPb0912yaBXDDTipb49y46qneC4AfM7sKYvsG2nlRts7KfRWPHbEmr4PpBBoh6rU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4283.namprd12.prod.outlook.com (2603:10b6:5:211::21)
 by SJ5PPF7B9E98CB6.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::99a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 15:33:55 +0000
Received: from DM6PR12MB4283.namprd12.prod.outlook.com
 ([fe80::9eab:812b:ad20:6087]) by DM6PR12MB4283.namprd12.prod.outlook.com
 ([fe80::9eab:812b:ad20:6087%6]) with mapi id 15.21.0496.015; Thu, 8 Oct 2026
 15:33:54 +0000
Message-ID: <e8aa32c6-2b9d-4cf0-9840-1d7b252b0792@amd.com>
Date: Thu, 8 Oct 2026 16:33:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] sfc: fix stale kernel-doc member names in
 net_driver.h
To: Arnav Kapoor <kapoorarnav43@gmail.com>,
 Edward Cree <ecree.xilinx@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-net-drivers@amd.com, linux-kernel@vger.kernel.org
References: <20261007175338.28683-1-kapoorarnav43@gmail.com>
Content-Language: en-GB
From: "Austin, Alex (DCCG)" <alex.austin@amd.com>
In-Reply-To: <20261007175338.28683-1-kapoorarnav43@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0252.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::18) To DM6PR12MB4283.namprd12.prod.outlook.com
 (2603:10b6:5:211::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4283:EE_|SJ5PPF7B9E98CB6:EE_
X-MS-Office365-Filtering-Correlation-Id: 0848f779-72c2-4723-3f74-08df25518fc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|18002099003|22082099003|10067099003|11063799006|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info:
	yAcpsm18XJR/v4KEcMoHYtuYSKIj76omjyZwdfTz3DKt8gFKM7ikGB/jfUxOvSs6bVVsV/ft1wl+dTddySuAYI2whgowSoZjHQw0y8q21YZOu+XKj+SV8X2EaCFpCCdnW5ODHgu1jP67ZgSHN4EchD99aQiGDvPsBtzVhvMouRCRu4pciC0YhOK8x7SPDuQYdqdepRG6lXQLH0rYXzLKQCVfthaCf4ROFOIbo8qSeT4qzy7FA1g5Qg6Y8Id2FYfC10oQ7X9FpOkMz1MmRr3H3xSWTmEj5zQzCIjt3xxYW/z63veyy3Rv1BYTo4FnJragB+ThG912lvd0dRjZZ4Eyy2Z6kwmcbN/3IAzERseN8FasSZf0cXbRmKiQGxRcWXVBw2O+8fRW0RE2QDhlZ9N34iU/fiDteB4zIADno8vwZzejHonL+26XpnWgxZdbbS8ZyziF4TmdryOU4/DGIimhGUee2/MnYxBqnVCQpZ9V6s9Pm+gLYTdUZ89LDAX3FhUj/0QPTlmNKQqln9FYPIQ1Ch7IZoTd7tVkovFf5x0Eh7xIZE6bKLmkMgFvgyDkYIYxdO3s4NeLg1hcAj8FPx5/6b6fdEttoMeoWCk6yLHO+eSHoY8qtFSlPFAffI45MB3YTSVbkJ3gr0AIVpYTo60rHZyD76XRssXumBQmyYwDkQ0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4283.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(18002099003)(22082099003)(10067099003)(11063799006)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cFV5ODBLSFV4T2JoRnpzZ2hjTWhvVWlIbHZxZmJPcnpRdzRkZVNmZVhqWEdl?=
 =?utf-8?B?dkNZOHJ3QjNPcWdONjM3WGlVNkI4eHRMOTluM0xwLzgvTFo1TTBtbk9lY0JR?=
 =?utf-8?B?bDBRb1pKQ0xsb3k4MnZWdWNLK3ZNcklkWGVEVHlseTdUbjRDbjN5VkJVMHlI?=
 =?utf-8?B?YUJjcGNrRkVCdExzaHBqR1pSYmVnTS9EMC9ocjNnOGxSb0RwT3doWkdZa3V4?=
 =?utf-8?B?OVc3L0NyVk1heEZqdmdDcnBxaWlwYzlpWFVSZVliakYxMGQrZXAycnpqaFFC?=
 =?utf-8?B?alpDYXRzNERIT1JQc3BMc3BDMnE0ZWx6RmdIY21oNTlLQzRGb2xXTDErOEFW?=
 =?utf-8?B?Z3Vnb0tCK3pIUWhPTGJjbzR0UlpudzNaa1V1R0dBd3BER2F6SUhkaURLMjRw?=
 =?utf-8?B?TXdTOGppcG5mVjVCUUFNWU5rdThRbnRzTUxFcUZvSlFSeUJCUDdBTXgzb2pw?=
 =?utf-8?B?eEhOTVcyUE4zcGhUdVBuTmtSZkJKMjVSRlM5SmhJcC9TcUk2WW1vQ3QycGFF?=
 =?utf-8?B?b2w5aXpXSWxSTTQ5bnZCOW1DMHYyZEQ3ZnZza1lhNE1Tb3JZMDVwa0pib01P?=
 =?utf-8?B?MGJZSloxTFVmVXlvbjlrWTg5K09yVEkxaUg5NE0xbFRrNlRRYVUvZ0d1ZmxN?=
 =?utf-8?B?bG93QUJOYm1yWHlNY3NIelU5aExRV29UQzIvVGdVVXcvRUNBSHRieFdjSC82?=
 =?utf-8?B?eVk4eHhHQ0ZNY0h1VGp5bmNRY3M4N05jZG9BdWNHYTgyY0IxOSs3clF0KzE1?=
 =?utf-8?B?bkxyZFRNRVRWdVNpRkdHaG1wSXNQRG5XZ0Zxd0RGWlpKZUVYNlI5OFR2Tmtw?=
 =?utf-8?B?aVFrUWVCcWRXbmw4TWJLWmpMNGZwOEt0Q1k1NmVkaC9VTUpPTjVMMDVYV2ZT?=
 =?utf-8?B?cHNUeExzbVNHTXF6ZTlNSGQvRXM1Q2FkcG90LzlBSmdJaFdVQlZQRmZWb1Qx?=
 =?utf-8?B?eGkrcy9jOFBWSlUxSWRHVXpqc2NzUWJKd1p2RXhKMlVqOWl2QVh0R3VqdTlu?=
 =?utf-8?B?VVlxaVcra3RGUUZzVWQzWUs5UktYUitIN2ZBcGdHM0c4MWtIYXZnVFh0ZWo0?=
 =?utf-8?B?RjhtZFh1UE1PTCsrSElYWHEzZkFFNWdkWjNLMVJmNWNlNkgzZmg2QU1ENS8y?=
 =?utf-8?B?ZVZXZTJUbVc2cnVNdkdyNWY1eUkxVm90STZBbi8zY3hkU0RBbTFPYVcxdUxs?=
 =?utf-8?B?Vnp5WnZmMVMzYUxNN3NOdWx2QllPMmEwdEZva2l0elNWZnhack9ZTUEwTG1Q?=
 =?utf-8?B?Vm5uVnc5L2dSNStiWkJOajNQei8xTmp0bHBpWExLSlFIS2RnR2VpKy9yYzMy?=
 =?utf-8?B?eXRjaTI2d1ZHY25PUWplZTdzc3Y0eGVzT1p3UURjSDhONzlLN294QUw4VEFs?=
 =?utf-8?B?dlZER0wrUkpnL0FCL1lPSGNjVzI4Umk2T1FHY0o5cGtPWFY3S1lBS2pRaGdt?=
 =?utf-8?B?VDJONWYzbG9HN20wZlNRVE15dzFVa0tPVVp6ODI1Rk1iam1hKzhHdDRKUEYr?=
 =?utf-8?B?Ymw0V29wbjdJc2o5bndodmlzRXdFMTJyM0E3L2dzd0MyREd4ZElSV1B1RXc2?=
 =?utf-8?B?WmN0L05OUFdUQkpBY0h5OGxRUkg3VWUxQld3cVJjWUZoaGlMeDl4OGpRVFBD?=
 =?utf-8?B?OEE4VU9Wa2tpM2ZjOTVqRzNwNVBYdXJhc0dWN2tnd0FZUSt5dENway85dWFI?=
 =?utf-8?B?TVV3dzdHeUNXZ09KSDVwN0x3MTRTNGNkNXc1Zk0ycWNSSWRvZnJXQ3Qwd2Fi?=
 =?utf-8?B?MktYOGJKQ0ZJQkwzK2xJSFlkRkhKMXRyYW1xdDN3TXZZWDEvejBSOGVSOGIw?=
 =?utf-8?B?NHYra2IvbmR0SkZ4OGpWNkpoeE53WkFtM0c2ZjMwblBBSnl3a2NUM3ZLWUN3?=
 =?utf-8?B?endvWXgxTzZrQmpqN3R0WXlZMTBPVzF0SzdlSUQvMEgrOVA3WUNOd3NUZlAw?=
 =?utf-8?B?eVBaZ0s2Q0c1aWllc3dxRWovSTZVSDUzc2FJUEVGTGpGVmhLZThKM01OMkx1?=
 =?utf-8?B?R3FNSVNKWWlUVXRIdXFPN1ZvUzBXZ3BUbS9aemN4NVV0Qy9PR0MzV0xHc2tz?=
 =?utf-8?B?QzM2K04yaEprZG8ydVpUY3paQWxOaGtqYjB2Mkt2WnBMaGVNY09raE00NTk2?=
 =?utf-8?B?Z09TMDZXaU9QMExNYmlOQTJPcW5nT01CM2Flb3dnaFc0LytLM1RJOWRHVFg4?=
 =?utf-8?B?WTVhbWVhUm5vQy8yUVpjYjI2UkQyY2RDK2JYQW9YVTJLeS9SMGlxZGc5R012?=
 =?utf-8?B?bVRIQTRlK3RXUWFaMk50RVlxYjl6dHVJQzRDVDF2WHhMYWVaRmNETi85dmpq?=
 =?utf-8?B?MlVZYXdFelNqQm0xMEpmT1VxaVNENkFsQWc2Uy9RcFFCaXRYc3RQQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0848f779-72c2-4723-3f74-08df25518fc7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4283.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 15:33:54.7238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X+rbbnoHvCysxDE1jtkFX85G49Vn2wqC/IpoAefWeLe1zAuVj6WbYtTO7tEkYdakcsTMaI0PDq4wDO7K4BnDOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF7B9E98CB6


On 07/10/2026 18:53, Arnav Kapoor wrote:
> Several kernel-doc comments in net_driver.h describe struct members that
> have since been renamed or removed, and the EFX_MAX_FRAME_LEN() comment
> is separated from the macro by the EFX_FRAME_PAD define. kernel-doc
> reports:
>
>   Excess struct member 'state' description in 'efx_channel'
>   Excess struct member 'state_lock' description in 'efx_channel'
>   Excess struct member 'indir_table' description in 'efx_rss_context'
>   Excess struct member 'irq_rx_mod_step_us' description in 'efx_nic'
>   Excess struct member 'tx_queue' description in 'efx_nic'
>   Excess struct member 'rx_queue' description in 'efx_nic'
>   Excess struct member 'extra_channel_types' description in 'efx_nic'
>   expecting prototype for EFX_MAX_FRAME_LEN(). Prototype was for
>   EFX_FRAME_PAD() instead
>
> along with "not described" warnings for the renamed members.
>
> Fix the member names to match the structs, drop the entries for members
> that no longer exist, and move the EFX_FRAME_PAD define above the
> EFX_MAX_FRAME_LEN() comment, documenting its @mtu parameter.
>
> kernel-doc -Wall also reports three members that are not described
> because nothing in the driver uses them any more, so remove them rather
> than document them:
>
>   - efx_channel::busy_poll_state, left behind when commit e7fe9491261e
>     ("sfc: get rid of custom busy polling code") removed its users.
>     @state and @state_lock above were its old kernel-doc entries.
>   - efx_tx_queue::flush_outstanding, only used by the Falcon/Siena
>     flush code, which commit 36ff6393292d ("sfc: Move Siena specific
>     files") moved into siena/ with its own copy of the struct.
>   - efx_rx_queue::min_overfill, whose kernel-doc entry and only
>     assignment were removed by commit ecc910f520ba ("sfc: Make the dmaq
>     size a run-time setting (rather than compile-time)").
>
> The warnings were found with scripts/kernel-doc -Wall. I don't have sfc
> hardware; this is compile-tested only.
>
> No functional change.
>
> Assisted-by: LLM
> Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
> ---
> Changes in v2:
> - Remove busy_poll_state, flush_outstanding and min_overfill, which are
>   unused, instead of leaving them undocumented (Simon)
> - Use the Assisted-by format from coding-assistants.rst
>
> net_driver.h has further members with no kernel-doc description,
> mostly in struct efx_nic and struct efx_nic_type. Those are in use, so
> I'll document them in a separate patch.
>
> W=1 build of drivers/net/ethernet/sfc/ shows no new warnings.
>
> v1: https://lore.kernel.org/all/20261003055443.144554-1-kapoorarnav43@gmail.com/
>
>  drivers/net/ethernet/sfc/net_driver.h | 21 +++++++--------------
>  1 file changed, 7 insertions(+), 14 deletions(-)
>

Reviewed-by: Alex Austin <alex.austin@amd.com>

