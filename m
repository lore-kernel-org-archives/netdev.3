Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013037.outbound.protection.outlook.com [40.107.201.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D743AAF46;
	Tue, 15 Sep 2026 12:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789474875; cv=fail; b=RmHPYkJlMVYZrtd7chozAjIdI4mWOGHWVrZz+zy9TVvEa1Bm+eNCUbGphwR11Wy8EyKYtgNTm7teg61lkTdOTHQU+Gdxejfpsp81v0YAhFJB+Sd+W9i8zfF8V8liu7FMcwqcZiJ3xKPxNMQpReZclisECbUGGm8n6W0Y6NvWwTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789474875; c=relaxed/simple;
	bh=0QVDSO7FJzu0CvpvUeLRj2p/k8a3rvEP035wi6f5cE8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=flQHn+BoEk96AcHZYkPxejN/TQqYVJcTtj2g78pG/zFWfumuOV3CvUvon9akgYjYIQASrt4IUFEdLTXmygOTeya+RIfVCKVHyvzZ09FPWa2lYnsuqtP/RjBxzsNfkURHEIZ2U09RK7xgVLh1WC8/JKc0J5qjSOCorIgOhUPUfl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bVpBCslt; arc=fail smtp.client-ip=40.107.201.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bVpBCslt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ouad9hduJ9QSBthNfu1eT9KhoLmFUnnXqgXMldilkl2ttTzAe/ZdNFg5EkrfoC9P8OAyxfQg/R+XjBY4TgFv5dwYTewTAmJfKp4LyHMSS/QObuiuQT3bRQKv7bYn3ol5dZkMVjQkPhP1gmDessrWXClaUQX0yPIkfniRuBAIbV6zAJ+zfGpW3101EKFnuuQ0/6qsz6LhGFc52bPSYE06ezdgqH4FaM67KSxMlixvard5vYwnOZdL3b4eoT84BGysd15cv0ByuKEPzvCa3mbOPkVTE73noPNN/kcVKdSilQhFLLpq9yfAVosIYWKdSBop2e7NHOO1Wj/v+IgGfx3pNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t4TtLOb35mi0gm5IzMXBW5Vaa8ft1s1oIrIvrIJtqxM=;
 b=DLl5Fvp838sQSRkHgvGKOfyeMGRUclZ2Y+s7QTXQPKgo5q6BTfCx4faAm86hv5gEzZApbXdGNPwBpIlvxqsD5gEpivQVNFq+xjb1qZ0/Wn672pswp8s+eyVmGfw8L/BSsdUZMbnF+ZrF1aQt9ndHFylx+RsIpz2tjYuYQxmcxVqL6wb+p+ZrvVhV6FSIGNL+nCtnqxoWNaVpUkkW7xw0neI91xujfWdAZBBJBasf8rWDMg2ZbsY9hrRxTOK+aI/q7e766MI9MBnmvkguSL6rbPDEj7kwo3luj2S8cHUv2vGvcJOK7AKi2YuKDbSNqyMlN1i70bkO2kGDPQMVnzdzLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t4TtLOb35mi0gm5IzMXBW5Vaa8ft1s1oIrIvrIJtqxM=;
 b=bVpBCsltoD082KHh7XLqamFyljudLJKKJMDWT+h5+G1yWkY1GnBk0ENDH7B2AZkt4utP532uDs2FcxAMy8hXAMKLinWiEOT+rz8GiVAByAR1cnpPtCxTkNbvYWgQXYTGR4jKRCUhCdIFfxuxpLhPNp1D0+D/OzBsmr0eRlf1FNJZZbh6yYfn3pEHOO9wwPpRCwkutRqsjFhOsPOZrw9N45RC0rlxrVWey8DAu85SUYjGtte1o/mJsfetLlwHY0hqMYQ/BjsejYvAtupRHPGZBrgLZvRlCLAmOvZVu+YQiqTM6qBY46LR3zZrn6uo5C+L1j4//p2b8kaxIz3IXrTBwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH1PR12MB9647.namprd12.prod.outlook.com (2603:10b6:610:2b0::10)
 by BL1PR12MB5803.namprd12.prod.outlook.com (2603:10b6:208:393::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 12:21:10 +0000
Received: from CH1PR12MB9647.namprd12.prod.outlook.com
 ([fe80::228c:766a:191d:77b2]) by CH1PR12MB9647.namprd12.prod.outlook.com
 ([fe80::228c:766a:191d:77b2%3]) with mapi id 15.21.0428.008; Tue, 15 Sep 2026
 12:21:10 +0000
Message-ID: <e4054f5a-e60c-4253-bccf-d05cc7c615b7@nvidia.com>
Date: Tue, 15 Sep 2026 14:21:06 +0200
User-Agent: Mozilla Thunderbird Beta
Subject: Re: mlx5e:zero-prefix corruption during TCP DMA-BUF RX - help
 requested
To: jiabin deng <dengjiabin2023@gmail.com>, netdev@vger.kernel.org
Cc: saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com,
 linux-kernel@vger.kernel.org
References: <CAFxp=AY2cVRQrZvB9WNnigbsobuw11NMG-cagHx0_V+ur2ToFw@mail.gmail.com>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <CAFxp=AY2cVRQrZvB9WNnigbsobuw11NMG-cagHx0_V+ur2ToFw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0101.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::7) To CH1PR12MB9647.namprd12.prod.outlook.com
 (2603:10b6:610:2b0::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PR12MB9647:EE_|BL1PR12MB5803:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f1416c0-b2b4-42b5-f867-08df1323d35b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|18002099003|10067099003|6133799003|56012099006|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info:
	o9XQNHJFjDLAgY7/kKVyAxrQBzTu2om9mIipulm8AMDNxYMKO0KNecrejOp6yxJula01EWnl14zx7hLNgcGAW3eaZwbn2kmdkTn8S9EPpgHFRY76XpSRXWLioYVUMNPvZ7/+LsPDuk3QcYEaY9xP6s4/XzvWKCAM6vykWUQ4bUlE3GKzhZNhYoGDzWpm3S4GQc1AI0EW28KpsUy7MCrdbMoHp+ISfc8nAoxj4IemMIrr/gMQVUxapukyxwxa4msurQDB8CYbxPOmk1ZQ3BZF5I9PHBBNMrqrmamQ2Zxcjg7ftW3DgTKmmrIhnIAWi8WYFdGdm0AlInRbwYYA5ccpowHykpSP/SfYnW9Asfmg4qrsahSAikcFdmfAN04EwFOzBZ5MMGYIsJmQc89+i3G+EiwFiP2nKnUaxncEbRF3ILm1U10qONYhyAqhgtFFuqen/EZcoRU1+c7Nq2DGbQ7B2dFhK7M3t/ONXlqEGbI/ShYwCC7s+Ra1d95fAxa19SkYR2CF2uOuRbS23sR1cGNpfXQW5xdQhnNFRHgOGGBuT/ddNqcRu+p2A2hjnIDpubmKMwMnqEPXmSum0KVb7Gc+bHctnEi3R3E1U1nLjEJU9T4QD2Dc16mYcDu2+8cYph+gO72utsTPTbTG6fgXS/Wh0yNqocnPm7Y1RWSsIIThP1w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH1PR12MB9647.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(18002099003)(10067099003)(6133799003)(56012099006)(11063799006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGM4cHA0K3ZHZEhnRjM3RnJ2b1NGS0hlODhxL3VMUFVDZmgrdmx4ZE1yNE5O?=
 =?utf-8?B?bXgzUWNpOGZQNXI3ZUF2SWlhUjNsVTVNT2orb09sZEYyMFZnbm5OWFNoL1dy?=
 =?utf-8?B?dUkzVFpzaEI4NEQ3c2FtdE4vM0FWTjZhZDhKYlhFMmY0Y1I2ZFpZd0tkY0Rm?=
 =?utf-8?B?VmltU2grV1NhTU1xQkxHbUpBUWZDZ1RzVkJ5VndEaENUbmJkeStLM0NuMzhp?=
 =?utf-8?B?WldVMENNeHF1eHJTRFp2dys4N2RLUHN4MFA3S3lBaTJ0RklMakc5R2thNVdV?=
 =?utf-8?B?dGRnNWlqV3VzL0xXWUw3UlIvVmJSVS9maWNUWWMzOXNLc1h6dkZZbDRpekRa?=
 =?utf-8?B?S3hjQ1pJUWplbHRoWVBITnQwZ0dXMEN2N0ZYbEl0QmRoYkFsZEFXbTcyS052?=
 =?utf-8?B?eDJnZGMyVEdxd2crYWM1Q1NZQ29XZFlDN0llbTFINXRtRUVmTUh4c3Fuc2xM?=
 =?utf-8?B?M2JGNDl0VjUrclN2czRobjFEM0I1Tzc0QTBtOXBUTUtUcVlQT2MyYloxZHRS?=
 =?utf-8?B?SElHNW1IbDhVTjZIc1NGMGhSZDhaM1Z6ZDdDSnVGdHpvdy9VWFlzUzd6RXdr?=
 =?utf-8?B?YVo1b3Raby95WnFaQlNCVWFQZ0tkNnA2MzE2bFJkVVd5dmlMT1FncGZXRzVh?=
 =?utf-8?B?NmlqNVpNMTUzZk1lUW9RUHl6MW40amxVdE9sU2krMlpIWXhOWUtZQ3BlczBu?=
 =?utf-8?B?UHczTmEwalYrUTJ6L2MyYnlVbDM4SllMRzBEOFF5L1ZsNzdEZHUwOUszYVpR?=
 =?utf-8?B?ZUE3bGVPMzVzcGNBOVJnNWxVSW85WFo3dWZaKzh6MTNNamdOR0NPTFMvZlNH?=
 =?utf-8?B?NEJoTXhGdGx2L2FNOWtORTVEZVNhTXcvd2hRdGJnWjhoNDBncEU3Y3BKS2U4?=
 =?utf-8?B?elpJNjRYVXptYTBBL3NPQThOeTJVTGRvcUVzRXdxRFZycnVNeUNNZi85Z0pC?=
 =?utf-8?B?Yk1wcWFlcll1WGZwKzhoYVBYbUpkU3lMZXJHL2NDR1U1MFRsVzdRUmRSVVAw?=
 =?utf-8?B?ampFUDFPOHZUUXZJVE5tTXE1eEZCNldpcFU2S1VTNmg4Tkc5QXEyL0ZicTNj?=
 =?utf-8?B?RHdBK3hudDdpblpJQ1hoL2FFYS9RYUR0VmFGaG16Y29SNHJKZlFCYlB2cXZO?=
 =?utf-8?B?QXpyRlVybFNFK0YvK1p4Q2I2dkhRRk9CN1lKU0pPSHNwNVRmbXZlY3liaGtJ?=
 =?utf-8?B?YnRsMDJUOGJqVUVFYXpSaEZGdG80cnRRSFBTeDFML0VaVEdIb3VvM2hMTkhn?=
 =?utf-8?B?VHg5TGcxNW84WkZjWWE5dEtzNzVyQ3NzeXlxa3VtZEkxQ2VPeURFS2xPczlm?=
 =?utf-8?B?UnpNVHBzS3ZsL1lVMjJJemhHQ1lLZUtnM2YweDVtTmlaVGVQTnhxamgrZ2h5?=
 =?utf-8?B?Yzg5dFRISTE5SGN5R3lCamt5U2pYNmRRd042ZUdjQWc0NW11TU1xOSs5U1ND?=
 =?utf-8?B?Z04rYkdlRUJXaVhKSVp6aHB1U3Yzb3ROT3g5MW04TjdDOFVCZEtNdStkdkt6?=
 =?utf-8?B?OVp1YUI5WEFjYmMxRXRnYVRPUGgzSnJjMzU0MzFvQkpDMDJUWlh2ZFlJMDZr?=
 =?utf-8?B?dTJwcVJtV1FuRG9BRmpvcjJVOFF2cnZxVWJQdzkzV0VPMXR6bDF2cVB2L2g0?=
 =?utf-8?B?WlF0RDlVc3dWNVpJOTB4cDcycll1Y21haUd1UXVkME9KcDZ3eEJpWHBlSGVJ?=
 =?utf-8?B?dXZEUThFUkhHbDZtQTN3aFY4ejk1bk1CMzUxUGZuUytxM3pxSjFOVUtWRGIw?=
 =?utf-8?B?M2JXNGxKQTFyd0lqSlRQa1NlQzJ1Tm5HTVY0T2JKenlXaEhaZVBWWmVuSU5R?=
 =?utf-8?B?ajMwc1NTRmtPTnZCZkVhZkQ4bHNoWjBZK3NHUWViQURvblNMV1BVMjVVajU3?=
 =?utf-8?B?YnVYUUoxNDVad2dNc1FVM0hTdXdsNkx0cFdVU2FhSXVJcDEvdXdYc01OU3Zp?=
 =?utf-8?B?QmE4WUpIL3NhRVBhWkx4VXF3eHZRc0FxNkl0dWNWVVFuMHdjeFo3d1dqY0Jy?=
 =?utf-8?B?cXNDM3BFOFU0VWZuQUtiSm5TdDNVMjZsejNXUytuZXJPWm0rbEhpclBEbTZw?=
 =?utf-8?B?bjlXSEhyNk9ZVnFlWWlrcnJqc0pkMEljVVFNME8yM3RtNXhpQkJURjRQcDYr?=
 =?utf-8?B?YTlPU0FiRzFqZVlyOWw4Z3duUGpoRVNtTUUzYUhENnZmTkFBYlRyRWZzdW9D?=
 =?utf-8?B?K205bXA1YnRhNktUd2JvZHBzMjF6UVN2NjBoL1hQbExuUkRrOG5BM1o1ODhp?=
 =?utf-8?B?cEErbFV6UmtnbUJzZ256SnJNV3NPSFVWOWZUNXc2RnNNZEtnSWZ0dzdIdlFk?=
 =?utf-8?B?bDdmUmUzOU12RlF4Mm9uUjN0Ym9SdHExZDlKSEdJSEdzQnk3K2lsdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f1416c0-b2b4-42b5-f867-08df1323d35b
X-MS-Exchange-CrossTenant-AuthSource: CH1PR12MB9647.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 12:21:10.2748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6YA7uYtIm9YdbD0BX/8dJhudxYAho8AjcCKrulh6WdPEscb0jb/Gxlr/1lSamCIP5lUIN7//s6aCpSPxWsBMMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5803

Hi Jiabin,

On 15.09.26 03:49, jiabin deng wrote:
> Hello mlx5e and networking maintainers,
> 
> We are investigating reproducible data corruption: with SHAMPO enabled,
> some TCP data is corrupted when received through mlx5e directly into
> CUDA-exported GPU DMA-BUF memory.
> 
> The full expected number of bytes is received, but the prefixes of some
> payloads become zero. The corrupted ranges end exactly at the next
> 64-byte boundary in GPU memory.
>> [...]
>
> Each iteration uses a new TCP connection. Test connections do not run
> concurrently.
> 
> Observed results:
> 
> We tested eight message sizes from 32 KiB to 4 MiB, with 50 iterations
> per size:
> 
> - 400 iterations completed.
> - 354 iterations contained at least one corrupted range.
> - 20,707 corrupted ranges were recorded.
> - All recorded corrupted ranges were zero-filled prefixes ending
>   at the next 64-byte boundary in GPU memory.
> - Corruption was present in both snapshots, before and after the
>   explicit GPUDirect write flush.
> 
> A specific example:
> 
> - Packet payload length: 1448 bytes.
> - Offset of the first payload byte from the start of the GPU buffer:
>   2149169912 bytes.
> - This byte offset modulo 64 bytes is 56 bytes.
> - First 8 bytes: zero.
> - Remaining 1440 bytes: correct.
> 
This sounds a bit like the ethernet padding issue that was recently
fixed [1]. Did you have this patch when testing?

>
> [...]
>

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=e2466392a0b8496000e12181cb1ee1535eb0da25

Thanks,
Dragos
