Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.70
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793796218;
	b=RVIRz2PeLIkKqCRi8QWZzc5QyuoLd7A1mHNfflixsPI+MUb2+IOJVy5boGK35mpBfs+w
	 b19vguAJwI6LYHfJnrBQa5BDjGbY355kspQg5ul2XsX69FgaBqe0VfPwkT2yfTGYMWcUA
	 lzjat+qPV+kTTofoy8FS6inkLWGZHAIErU/axtPVIdxPAkQ74KbMDcA8KM1MYZuyudeG5
	 z1Qm9jQHB+Q4VklKMTdAr2ECNbgyf7/jM/MgJ9GTZqoIFjVYGmdeo4LS2JxiETVnutRUi
	 Znr+E3C8LIiwiUwIKcG/CyteJKBuk36jw1INeE1FNyaMdGs4CQhPB1aoRthXSgfaF0Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793796218;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Vy9StAtGUW9W8nCKn6+BOkqA7LKEOM4EO3Uqo4eJBvs=;
	b=GCDi+NWuDY+c9M0rMyGMY3idkOEKTGpQGFEtZXyHyvCFmeMo+y6qQfpbh7qexdpf2aB/
	 zp9RvH00iP1iMoztPBsGoXMKRFdgTdja1lpqdz4sheSF/lXh994T0YsNcZge0OnkNudid
	 YhBsutAeFXd4zeeYBbIy68lkVwYRshT0jgg5MFVvBKovg8eZraYtHpqORiZT/1eKskB7g
	 H60/xbBJNQmRZ6BDBuKyak8z9IIzIMJW3FNkVBeUHCPVXqMVfQpFDOhUJhbRjlRDRAJpN
	 TI8TOMVNudpihWhavKReOV1FHRL43eapM6KFN6sEm/CskAVhP7mGiNCkF+TX7eHgBaw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=KG+0yFkx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.70
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010070.outbound.protection.outlook.com [40.93.198.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B242606A328
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 12:43:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B242606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=KG+0yFkx
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HPu/EbuCVbpEARaFjE/vvX0C+L+o2Sb4kLOyw4ngEbIl0H/tVXsX/ouyVguNow2im7IHF72z04VRsNDDutL+dafm09ZCMYw1CwnCXdHJvhZvHXToanGP6Pyq9eZyY4ePZWohY9dhiXDJ/xkxubeeFDFm2897L46HbFzENtMoTnxYLHuUwl/aCQLC/yl1lhruaW8pubQ612vUALW721k6Jp97Agb0VoHfE2/pnmD7kvPn3cDtH9WnndCZnkxJtBiqquG+DgO/KTllUay2N3WgZzMcCyAar+qUavGZtHxbtOJi05VduDA963OHwXT12JElp84kqnzBdlXalEty6hOnXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vy9StAtGUW9W8nCKn6+BOkqA7LKEOM4EO3Uqo4eJBvs=;
 b=MxpF9oGRh5di2LSPhhpBRe124XYXW3+0NJNHYhmuxOiImx3ePOiuZFNiUlEA5Bt+69g8fCPnyX35msuofD6rfu5cpOUSzqOrrEdr5wIrj9hIvxixYqqvFERATQL+OP+3s4oeONTPPEMdfKk/p/nMsxHa3ulx13M4lJHmhFP+K8qI100B1iiJnlwAN5tnYPok+t5k3xjkTi7xZ1FjM64BPMwxCyl9ybcjchvdJh5w/SQxHhgAMbnIQZKO5XUiePSWv46M2GkEhMxyaU82eqSwNrdHWB3vIOx83VkyTYqLO+TDLeiD8pKiYOgAgEV9Ml85A+pJdQZ2PENoCMUkUaEWhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vy9StAtGUW9W8nCKn6+BOkqA7LKEOM4EO3Uqo4eJBvs=;
 b=KG+0yFkxCTW/pdsOqPEUvgmMGlmnfPSlxmg9eGLICs5olpN/7vyLYk7oHwsDNbz/QQB/VelF15/PrFcH+z2iWNf6PljXIJCrR92+hTfIwMgT8dkrwlVV11mnDZx5Rm7NqeqB+huX+dKRjGAf68HhkQiUs8JF/BimBsplkrYEEMs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4283.namprd12.prod.outlook.com (2603:10b6:5:211::21)
 by DS0PR12MB999079.namprd12.prod.outlook.com (2603:10b6:8:302::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 12:43:36 +0000
Received: from DM6PR12MB4283.namprd12.prod.outlook.com
 ([fe80::9eab:812b:ad20:6087]) by DM6PR12MB4283.namprd12.prod.outlook.com
 ([fe80::9eab:812b:ad20:6087%6]) with mapi id 15.21.0546.016; Wed, 4 Nov 2026
 12:43:36 +0000
Message-ID: <71b57111-5f13-4499-8a21-a4203505a2c8@amd.com>
Date: Wed, 4 Nov 2026 12:43:32 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] MAINTAINERS: remove and replace myself as sfc
 maintainer
To: netdev@vger.kernel.org
References: <20261104013138.4103896-1-edward.cree@amd.com>
Content-Language: en-GB
From: "Austin, Alex (DCCG)" <alex.austin@amd.com>
In-Reply-To: <20261104013138.4103896-1-edward.cree@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0062.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::13) To DM6PR12MB4283.namprd12.prod.outlook.com
 (2603:10b6:5:211::21)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4283:EE_|DS0PR12MB999079:EE_
X-MS-Office365-Filtering-Correlation-Id: b0531277-8c2c-46c1-811a-08df3a713e2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|11063799006|56012099006|261021121427099003|261021123027099003|261102123227099003|261022105027099003|261028144727099003|261026140227099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	ND0WDjqtW8IKuB2CVjMFjTozsKrI/QlXwQZmWeh+phXLLd3VD/6NMpnZg9jDGAb8FHEL56JuvnCgOYl60mU31053bjlkZ9B4QE/0AEBFK427yadxCV35OWOXDKvDVqEHhEzXS8mvg2P4VN1c7BxIYUQtAl08zliICODRycIABeaNq61EgG+/rTveiquVv8JdzY44Ac7G/QfU6seSYpVLIwxmDqkMAFvjQeZDKkSq7eg0GONJzIOf4Bao8rB0OkAFUVI2+FMb7gK4o0GYnc7CfOJOn27L5/+GRg4iKTGVe1U0CNkhRz83WjAgjXTFFXCKg9TUw0CR6adbaXuHgOK+xhBWrEtV+uYRxJqKQ9H0qV08CSJZvlrCFIs5zhVJ2w0QIj89usJeaUfkRc+wdHdsZl0/j4PXoMrwaUyI3XjN6TkgQXty/zvhQ7KS4eRL0SAY/Dbbi6ffZnc5DoDR81nHzaDJucTus9bf0oKpRpbCWL9nna9DpSWgrmWcmD+bi1FZ5V+48SlMJniNq3SulO4/ASw9IS7ZhOPdjWL3Cvsq3MWm3CTXLGp/U6KEcbL2oRxQelTlCf0fe9RnCU54H5eQ8cWxDrxVQ/VrNKG9PVnAJwnTLqcCYk9Ow2I9oUlT3qlC0DfcYCoY4jF8JVuphJj0piyx16TB882n/zB+zlHhHfM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4283.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261102123227099003)(261022105027099003)(261028144727099003)(261026140227099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cm1pK3hBcGZWS0FhZDNZUXFJWEFYRmFNQjJwNGRuYzNPM21veGFFMy9tem10?=
 =?utf-8?B?Wk54R2lZR2U1SDJQVkhwWHQzZ2JzTjlmRjZ0YmRObTNjcXE2UExub0xJS0o2?=
 =?utf-8?B?Z2lpN3JOVGhmUGlxU3dmdTl0UE00MzlRaW1LdXBWVm9OZERtSEVlTEN3c0l5?=
 =?utf-8?B?N0J2K1VzZERnZ1NyaWcwRWRUdW9tRTZDRjVDbWtHTjdVdkoxWDJLQlh2K1M0?=
 =?utf-8?B?Y3lLRHR2TWRmanhLMVFwak5CcjdzNEtIOEsraHkwY0VKc3hmSnJFUGY2MDJt?=
 =?utf-8?B?MUU0ellpclM0NmFMQTNVVGdUWVRxSndSWVJzTVl5REtrSEh2aHhKTEd5RjZs?=
 =?utf-8?B?clpkZ0JyU0w4L056VHVBTjNYRmhzYTFPOWJRcVMrV0hUS0tzSm0zSmh2TUdF?=
 =?utf-8?B?bjI5QWcyV0NEZVMwTDNpcHJ3TUlqcWh1WlQyTThnQ2tvU2hPckpUQ2lGcDVT?=
 =?utf-8?B?aTFKUjhXSzNFOXZYME9CODVoN2creUxaMDlQMDFyL0hXcnk2cG1INVd1VDlN?=
 =?utf-8?B?d0dsVyt0MWNmaGdRbjdWdngvOUFFMm1QWG1ZamppWnlFTzBkT3B2L2RJR281?=
 =?utf-8?B?TGptYUV0YkJaVXc1L3VUNEJaU2tFNWhlTFpjK08rc3ZYTzNYcnlDQUl5UWlu?=
 =?utf-8?B?c1ZkNzFLcUl0cnJKRlFqYkVva21aTTBFSXByTjN4dlRFeUNaV1BQcW1DVmVB?=
 =?utf-8?B?aWNPRTFIZ1NzaVNveWRENEROMm9IZDYrbGFuZ0NKSW04Z1NPQys3a25DUEtv?=
 =?utf-8?B?dWJKWnVrL3AraXAzRjl5Y2hlc0tUMTFZSEMwMEZwTnY1SStTeHNMZklBTXAx?=
 =?utf-8?B?NHg2VTVzQTZSYVpaZjlkZi95UmRGUzlmQlZHSGtFZzdUOVVjL2cyTDlMNEpx?=
 =?utf-8?B?eUtsQkpaTEMrOUhOTmJxSUMwY1U4a0ErYVlzcUk1YXFZd0pTVXpjUzB3MUQw?=
 =?utf-8?B?S2pWR0JyS0xkWG9UZ21zOTBacmFMNmp1cUo2QU5yNHhPWGx0RDdZeCtIbUNM?=
 =?utf-8?B?aXZqZGJtSFRUVDZTTEhPb2NxcE9BZUdnN3JSUWkzclNNb0xqenR2bW85dmxJ?=
 =?utf-8?B?OVNkemJrb2M3TXFLT0VWN0FncjV1NVRySGFUSC9uTTBCWDRLZVBTWVVmclRF?=
 =?utf-8?B?T3VTTFhoRUUwR3NlSXo1SkI4MTVBV3MzWnVVcTJoY3ZwWkVyY084RnltNk5V?=
 =?utf-8?B?WmUvZVdCeEN0UXM0Q0R2NEZ3cFIvZk1hVE8wYnpmNjRqZHlsMXRSQTZoa05m?=
 =?utf-8?B?aHRMSS8yaXBmalJCMUtIRnFZSFZZb0RTTzM3Wm8vcGJyZDhEZnNYRFlRL04r?=
 =?utf-8?B?TTBvZm83N0hla0RuTVNRZUd1OGhEcUZFQ0tYM1dqcUJ6WXpuTlB0VGsxenBN?=
 =?utf-8?B?QlBUTVU5NUZvSGlyczBJSUlRQ0tyaWQxTFY3MW1KR1UxNW9ES3czL1RHUU1L?=
 =?utf-8?B?aGVJM0FPUk52WWo1eEgrZHloOVhLNzUwZEFwV2NZamRGNm5vaUZITGx2d0dv?=
 =?utf-8?B?bGpQNWo1RmxlR3haUXkxeUIwVlJNTzV2MEVpaEo0cjVsejJCVHVNZExPZmhU?=
 =?utf-8?B?TSt1OE1aUklrdlR0elp2cVV0WkMvWWhDazNoWTh1WmNNeDgwNy9pNWRQOUZE?=
 =?utf-8?B?bE9oRWRpUS9lbEg2OWovazNSNks0RWkycVRsU0MwdlpJOXJUS3g1QVlHVmds?=
 =?utf-8?B?cUlIZVVXMWNGU2VsY1g3MWU2Q0lRUzlpYkh4ZENFc3FmS1ppWGJsZUFXdzhW?=
 =?utf-8?B?L1VMbnFYUVZyQ1RhdjZRK2lJK0NxbUM5V0ZEcys2NnNHL2hxaGxidnIybG1w?=
 =?utf-8?B?ai8zbHBjYjVtc1pxZFhidDk0WmNlWUQ1NGpTTEU4OFJUdU9qVzZTLzdzZ25v?=
 =?utf-8?B?WHhDbi84WVpDTGN2M2dTZVNyNytXL2E2VzNyQWhEODVHZFNnOGtDS3g5VElu?=
 =?utf-8?B?RlJ1TGU4b2NqOFYxa3MrcEpEZlhtOEdRT0x6L294TVNWMmdUMFI4dU9mQkNJ?=
 =?utf-8?B?Z3ZTaU9RZXU2bHB1NDEzbisyT0RjR1pKSm9vTzFoTWJsVWZGKzJaRW1CK0VX?=
 =?utf-8?B?ZExBR0t5L3o0TzZDeEZSeEFjNGJ5dnlLV3RGd2w3d1JxbkNHL29XRXI4VnQ0?=
 =?utf-8?B?U0p0VjRpWG5UTS9CbmY2SFFhOTY3dkVMK0lmV2ZRMm9taHByUEg4QzNjRmI2?=
 =?utf-8?B?Z1FQL1JRQWt4NWpqREhRZXNBd2h5ZWdvU3ZhcHdSSkhhWXN0OHZLQ0V1d0Q1?=
 =?utf-8?B?S2thejAzamRSbk9lWm5Zb3p4UzZkK1lEc2hnbU9SYTRuWnRFOTdRNXorUnJt?=
 =?utf-8?B?NWdiVHhQZW85bWF4TWlrYU5ucEcwcHRvbnZVODFQV0RYNFhTSi84QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0531277-8c2c-46c1-811a-08df3a713e2f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4283.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 12:43:36.0812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xYxVvVYPt9/ZyHzgX2i42MFzqftB1EDPtf3Aw70jV+bDzLwNOMIWrTz2O1oA2ekfK7WkEpDyM2Zn+5mFjI63kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999079



On 04/11/2026 01:31, edward.cree@amd.com wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> From: Edward Cree <ecree.xilinx@gmail.com>
> 
> I will be retiring this month, so it is time to hand over the baton
>  after a decade maintaining the Solarflare drivers.
> Remove my M: line, and add Alex and Andy as the new maintainers.
> 
> Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
> ---
>  MAINTAINERS | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 09713dc4c6a7..4d43d3559960 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -25465,7 +25465,8 @@ F:      drivers/slimbus/
>  F:     include/linux/slimbus.h
> 
>  SFC NETWORK DRIVER
> -M:     Edward Cree <ecree.xilinx@gmail.com>
> +M:     Alex Austin <alex.austin@amd.com>
> +M:     Andy Moreton <andy.moreton@amd.com>
>  L:     netdev@vger.kernel.org
>  L:     linux-net-drivers@amd.com
>  S:     Maintained

Congratulations on your well-deserved retirement!

Reviewed-by:  Alex Austin <alex.austin@amd.com>
