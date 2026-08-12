Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011005.outbound.protection.outlook.com [52.101.52.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D9B38DC47
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 19:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786564124; cv=fail; b=scC5p+LEGJ//68xediI8ZxksnNRfMEtfRoiZXY1EfFiNFB7jNObdASNQ1MbPe+r3D0VVIjJrc+8sNImUE64W19PqAP+ao8hgsjwYw3diqEnkgQUfU2aGIcLsyrKCg0n9Utzt3VDAYwpdG59dzTcfk67E/LKp9huL/4r1+xdK3uo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786564124; c=relaxed/simple;
	bh=89/ZwyyJU3+gwS/YofVjRISGM8SSwN4FnOwy5MOVL8M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c4eNgW+CTM8wI8G7p5vr7u/kN72AqHKgYVHAAG3qu4P9nFWS4mA5B121RJuMAiDkSRCvKOIVwDM9o6blhyN6WKkOsmDFJ8l7ReP2MuJ9e+h7Krg5S2R5SsdsS7MPEKY0uI6nzkjaya8f5iVYK1mUpLrIlmxsfFVYXfhjdr9y4Kw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g76XJRJx; arc=fail smtp.client-ip=52.101.52.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g76XJRJx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PZbYRdWm8QmWr5SQccKRh7zACPb6/DQ8Temz97NR6afFj0h+ErOQQL4+jvK2riMRltg+w/L8qJEuJLa1xXWaSMrxOn7nRypc02vwh5FrpVhw5+berG6KW+mGlLjmuK6fhBbRoYxM37Mh1NqFMNxuu/91nxStDaKt97T//Cs2p7j4DtdRHy5kPj4l50YbhC/8E+Yjp/i5QO4QWqpFrLbfZ7YrOkC+2J+F+Wxe4LgCye2nOcX6Rzg1TgX8eOwKYEPE6w03sF3CvfWPdseEqAepXc1evi47+itNGZfV8ZdYbiya62HSLI7JY2WLjjNXaU+EVLSEbveF/TIhxwHVBriUkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ltevxo+KniOyDmdQXuTr5VwlHQvNrWTkSM1U5ZWvu2Y=;
 b=v1ezXQSMFw0jiJ9eVlgK6T+MdIhmMJabwVHzOn8Auf5FbvFCSUfLXZfEsMr81XCRTiBvv+NktQvjpIZlaG6ddthTM73YlhBqO+soHH97SKoiZge5/fEHdlLospJ6nSIbqSyfN99MEWMvoplBI4LYhCq87sZ1QPV/MC71AHckgqHxi3PrzZkq5dWE0KwkB2seYzJu6umdOD2p3GI1s+s7jrZbQdHo5y5VNRfCXJ6Isn9QaHehTMgK5w3964PA7cA/5rABZkptIDoWLjS7/KsyCOXrgNQt4iDEO/pPx4oQirWOOL7ODOXaoOdq5aMcLfFPLxFaEaQ5j1e0iqbJklMmHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ltevxo+KniOyDmdQXuTr5VwlHQvNrWTkSM1U5ZWvu2Y=;
 b=g76XJRJxlAWyTSRRg7ziRrltwxLkdJ29gw4dUNL4jjV52p7G8zIIZwpAvWNPKpTlritQcphiatM5DFdShysIFzLDRNBrelvPNdYqCMNaFekvyp+0fdFDtOUEEOYECUQPQ+naHq6iXwyBSXL3BoSGWRUVslYOOsEjclnsn1+i3zuoV92cbTL5MUafFA5QcgZ3hXGytMt+Xb9NkZT5Nvn5PijlQpgzeoIMhwgIH5UU6acvpBOhh6EHtK6TGDceEZSl80Ld9jgNOHjq+qWJY7F6Le+8dEjM082x7dr8q6y4hCbnTIRKUy9XqIvpH7grrTEK+T8MepWyUPJHeP17/Vfq0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 by CY5PR12MB6129.namprd12.prod.outlook.com (2603:10b6:930:27::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Wed, 12 Aug
 2026 19:48:34 +0000
Received: from CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7]) by CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7%6]) with mapi id 15.21.0315.008; Wed, 12 Aug 2026
 19:48:34 +0000
Message-ID: <a0b4e051-546a-4950-8dba-03391bcded70@nvidia.com>
Date: Wed, 12 Aug 2026 21:48:31 +0200
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [TEST] CX7 timeouts on reconfig w/ page pool failure injection
To: Jakub Kicinski <kuba@kernel.org>, Nimrod Oren <noren@nvidia.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20260804094518.53b56d24@kernel.org>
 <7caf12fd-f63b-46f0-a5bd-e9887cb25f9d@nvidia.com>
 <20260811080433.26f404dd@kernel.org>
 <8aa8c49b-736c-42b3-92d3-26bdfeb90a22@nvidia.com>
 <20260811103832.28e5c8d4@kernel.org>
 <2d2aab62-a4fe-48eb-94e6-c8a0ec910ee9@nvidia.com>
 <20260812095947.3d0e6ca6@kernel.org>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <20260812095947.3d0e6ca6@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0069.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::10) To CH3PR12MB8728.namprd12.prod.outlook.com
 (2603:10b6:610:171::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8728:EE_|CY5PR12MB6129:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c030fb3-c90b-4b97-25a1-08def8aab1ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|3023799007|56012099006|5023799004|4143699003|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	yUlVL5U5N0ZS1RQ8vZRPN1K/UINyWKvZTag2itwXUVNpqZ+tImxWP2MVvQq2m7sbapVg1lVCIynsJyf2FiaBHZg7Bdcj7/wtFZ6+ocYGTTXsHdUf9gHjttM1E84jMSjbdi987hND3z8JREmHVlz1ytnckGjNnzoDu2tosKQyDvTxyWEkJvXriROcSg992enofCUcuL/MNazfv1Lr895UptEXPnFdZHDUsf2X3AaYoAYqAyLwL5Om5cWjIW0i6eOqWecuoFRZaF+ewv9Jobeuvbm9B6Z6r2ChInBc9M7oA0aKlWdRvJzVIiRzVCVdZDJuOib9486RmtFbLTvIlQeEk96ufMlVgEpcFisE05WNKmaDBXQ4yoO1GtUPbDp94/eKolKJATb5vm+vIEPrGU4CsRNo5IzRcSapia1zttPbIGyYG9Mg799c44/WCHAerj4gM1Tf2bH/kzgpN6bfn/GSs5QZFHPcnAKLMeCVeOk3RFQVXZ0aRSbPtIonnXjvwPg4Labwc3s2EyU1fNch8uMrBCKgF1q7TU9qvEf0QVcwjr1s+EImTpEURV/EyO8XOu0f287WTnvOCCoSXqCbibCY3uhb95r/jbwp3mmqgOUswuEwWWStrg8iVWqF0FgrgFK6x9h4iInEOX6yCkBy14yOKNIO1opc0Vrm7y+jbjBRuFo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8728.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(3023799007)(56012099006)(5023799004)(4143699003)(10067099003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHZqaUV4emRkNTdxYUtqd0dyTHdUeDhxdDlpaWtCZzQ1T3djTlE4YkxVaDA4?=
 =?utf-8?B?Q1hSR2xrWGJvdGY4dDlYNDhwUXpCaENUUnZkeGtqMGF3T21DS0dtRkloQTY5?=
 =?utf-8?B?enI0ZHEvSzJuYTFIRWdMOVlYdE9vQ3RIdjZMWHhlbWtDWGN0d1dBZGhvWjhk?=
 =?utf-8?B?Z2pPdWZRc0tFMzVpblRlVTlPQ2xsa05aNjdwbG5LNTZLZlNDYit6V3Vac0Ji?=
 =?utf-8?B?UGFGakgrVStSUTRLS2xmeVBkNytHbWxRejNVd1JtWE1CUlBFNW55d05pS2FC?=
 =?utf-8?B?VlNPamFIYmRSeGpuWll6L0hxN3NmRzlTaHYvbnV4Mk5IYXNUS0VKYnZsNGhN?=
 =?utf-8?B?S2RWVlBMU3FtKzRwZElqb0lCbGI5dDZJdEtZVW54TnczeTRmczJZZVFrSnZX?=
 =?utf-8?B?UXp0QVV3T3NQcnY5U3lJK2hkamlIeXRHZm9VeTBEV0JWdHk5TjRVM29pZ0E3?=
 =?utf-8?B?N0RkekRLeDZpQk9ZVWNRUWVmaGhLcUJWSm9WcERQTDNuakN0T3dQYTIwamJK?=
 =?utf-8?B?VlpkbWx4SXUrK0I4RzYxaUg0aFVwcXM5RUFtRE5QcG9JRjQ4dFVaeTBIbjFF?=
 =?utf-8?B?MFc2OVpPcHAxemxnQytRT2tka1R1clZvWVZmcitMK1VwZjJlOFJ4VVhPUkhD?=
 =?utf-8?B?bmh1Rm54ZzZ0ZldEYjVkRitzTUM1SkJhS2VzYno3WVFZM0Q5Zi9IbjU2TEdw?=
 =?utf-8?B?RzhnanZGYUZYVGRObkFteUVOZzJHUjhCZG93dG9nVVVPenNRdFA4WHRkZmx4?=
 =?utf-8?B?NnlXZnB1c2ppSjRkeTFQQWo4OVpXNkxHc3Fna253MDN1WEdoU0g5SE5YN2ZW?=
 =?utf-8?B?a0MxYXNRU1UzcURWZlNVWmw3Y2JEMmkyZWh0MHBHaWhRTHBKcC9hYkhWemtO?=
 =?utf-8?B?VTFHajJwVGtoTS9pNjN3ZWRGR2FBTFZ2MEp0TXMreHU4eEJ3dWxNdENVeEg1?=
 =?utf-8?B?UWNzakRtZm5XV2V4UEwvOWxIbkxKREo2c2JSQ0RNVDUvYkdUU05PT1poVWtC?=
 =?utf-8?B?dWYzTXBrellGTCt3OTFtaUVTMDByUWpNNGYvUk1UKytNRWxQVldDNVpKanRE?=
 =?utf-8?B?SFg3YS9rdVM1cUZvUitrM0hlbWtQWVpWNU95YlN4QkhKSlZ3cE9YYUZyRHZD?=
 =?utf-8?B?dVVRNUx6OUhlUVZ1QktUeWwvODhKeEhhaWdPeGtjY3hZL0JvamRDb0lVeWRZ?=
 =?utf-8?B?eW5ob3BEYndwUTcwWHpSMXZjeVJncGNnREYwVC81RUR4QVBRSnBhNWh2VTdo?=
 =?utf-8?B?ZUczUThCcGY4OEVlMlJTa2k4SEFObVZuaXRZdUdzMHNNQktJTnBsdnR6Rkts?=
 =?utf-8?B?SG1TSHlHV29Ob0U0a3ViU0hJdzJPR2w5QzJuR0Nuc1V0a3hHM2ZSNUNOOWdP?=
 =?utf-8?B?VThiczNkTUpmT2VraUpycCtKU1FldURXOHZMSkowSGUvRzFpTGRPdG5hS01n?=
 =?utf-8?B?ZWs3aDkybzQyQUs0Z2NKaEMzYzVuSk84RmVVUWgwUGRmbUtPOG1aeUVPcGNj?=
 =?utf-8?B?SmVuTkF6YUY2RVduNVFLS2xOa0V2SUVabDl4c3VSS01zOXFoMEgzVUlVUi9h?=
 =?utf-8?B?WWxoazNqbFFOdW1SdDhhZmxNK0wwc3BtZkExazRxbmRRSTM1WHJsNytaOWJp?=
 =?utf-8?B?MHZaVS91bVpOcGRWSnNtaE5KVnUyVjg1RGYyQklaWU5BNkM2NUxPZnNnYnln?=
 =?utf-8?B?d2loOE5VcjFsTEh2WGRnNVY2VytnbkV1bmN3ZGxmSURrV1N3RHpkdUVkdWtl?=
 =?utf-8?B?b3B1R0FlY1JrYjFkQy8vTHBVbFlJSjJiR0NaZXcrK3BNN3J2OERWZFhXcUlL?=
 =?utf-8?B?ZFRlUTFPODRKdFlhOXU3RXdFZ0RuYUJGd0ZtVUVvQzR6a1RUcXExOVd4SnF6?=
 =?utf-8?B?a1NCZ1MrVE93VjgwRkEzNXdETGhKY01uQTBCN2h6V0dFZFFTRFBUV2IyZGk2?=
 =?utf-8?B?bGRDR1dlRUxES0R3NVZJTzVZRmtsdVQ3VGZ6Uk1jL1d3NGpvZVZ1SXRhKytp?=
 =?utf-8?B?NzFSYndhaThJMi9iZFBuQUtBUFRqaE5EVnRCVklkcmRJTUhNeEQ1TFMzZ0NS?=
 =?utf-8?B?Y0g4VUQ5T2NUWmFMZ3NsczZUcjFmTlhDeHpGVmhBUHowRkdwRXJQc2gyQTVh?=
 =?utf-8?B?dEpxcHgvSi9sS1JieWo4L3Y3TjBZNDJrT3A4SENzeUpnRWQzNGtKbGNoTmp1?=
 =?utf-8?B?S1JvUUpVdW9paFFzYlVzQnZ6cEs2dEYzWE52MFRkQ0JSRmtqS1pZRlA1NzVO?=
 =?utf-8?B?RXpic0c5RU91VjBjZzl5NlM3M2ZkNkNMT29lMXJJcnYwcmRid1NQN0lYeGVY?=
 =?utf-8?B?eWtMMkFuT0NHWGhZU3pBemk4cHVQWmp6Y2NFUUtML2VGdlM5RjZKQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c030fb3-c90b-4b97-25a1-08def8aab1ac
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8728.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 19:48:34.6956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cZCk0OGaDFljkCwmLKSnemCkFApKhbKWM87oL8GISHw+a+f2ovw2qONT3+hoGyJBEV475svamoSVsvBuM+8TQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6129



On 12.08.26 18:59, Jakub Kicinski wrote:
> On Wed, 12 Aug 2026 19:31:09 +0300 Nimrod Oren wrote:
>>> 10min wasn't enough, bumping to 15min :(
>>
>> In these runs xdp-py took ~9.5 minutes. Both pp-alloc and rss-api tests
>> passed:
>>
>> https://netdev.bots.linux.dev/logs/hwksft/CX7-dbg/results/774403/test-outputs/
>> https://netdev.bots.linux.dev/logs/hwksft/CX7-dbg/results/774889/test-outputs/
>> https://netdev.bots.linux.dev/logs/hwksft/CX7-dbg/results/775361/test-outputs/
> 
> Ack, I'll send a patch to bump the timeout shortly.
> 
> That said, the page pool warnings were probabilistic to begin with.
> And they were hit in page_pool_unref_netmem(), I think _some_ bug
> must still be there?
> 
> IOW mlx5e_page_release_fragmented() is draining more references than
> the pp page use counter, that's not normal whether some command timeout
> out or not.
Yes, this shouldn't happen.

You mentioned tag net-next-hw-2026-07-03--00-00 as the first where the
crash occurred. Do you know if it ran before without crashing? I can't
find older data in nipa. And there's nothing that seems relevant around
that timeframe. I'm thinking that this issue could be older.

Thanks,
Dragos
