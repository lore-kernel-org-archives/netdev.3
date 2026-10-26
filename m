Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.133
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793017422;
	b=pDL221GJQ9MD3t9s/KPp+QPmnV4Sj95qQyIwsW5VzDebgAGiaGCWeO+2Ive/S1HEeyu3
	 OptkdVWdnBmNqQcWfTivv4Fm2a+XupaptbqvMVyfKTCYtx/YQ16QGf/PXTff2l3635kWI
	 8yqCCs+pwWyoeZZ1mrJ3Pu9V18UOkGPQAH4Eg4baSOsrAmcGcDTk4StSG9cCSRo1nt6nt
	 VQQvMLuwnVVag+XplsKXoJFy95SsQ72Gqbm8o1MvScemkUIX3KCeQFRWnoGDMrZPec7hE
	 IK5+BBLRSPjD4Io8IamJ3ebFwxWyPTJUYvJFD1ZFD/mJtK9TASYQ4M198h2WVxJuULw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793017422;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
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
	bh=fThPhDTwNObVM4Kx3JibNY8hmQ6cL1dzLIfdDeHCb5o=;
	b=LA+tGVbPpbJHYwSLpbpTYnZfbAWahLrngWLwKepy5f67esVsVTnGuTFqQjpSNIf+52gW
	 UEhZxQB8m+ZlqiV2BHgMSJV6zx1+bgto4cRM3iXigsXWSDZ4UZO4L7weGYrNpsTuJInec
	 PQ6eVfCzK1X8AhjZfwHeTBaF0afO3LPyIeTdCVL4BDsvgo9JBt/kc6h44BWG5vTjLHy/x
	 OiLI1HjyIhBg9XYS0sBwGiTmPm1iR9hAh5b9sOUkgVDrVtzuVOtyUUxuSthU+5nWvjlAk
	 eUaf8o6AGb7n18rkIgkvqTBpN8Zi2s6f1fGoTUh0rcjGqb52IlMhRGoyHvpsXYF2ocA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=virtuozzo.com;
	spf=pass smtp.mailfrom=virtuozzo.com;
	dkim=pass header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=selector2 header.b=nYMB2m2d;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.133
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023133.outbound.protection.outlook.com [40.107.159.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20FB606A31A;
	Mon, 26 Oct 2026 12:23:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F20FB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=selector2 header.b=nYMB2m2d
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UKFyRClH3cgLpG0u+vWomFppt77ceyXGxnFt777V19J3qQyddYWifJRbhdB8G9KA7sKi80Xif1fAumUiIYqj4igyDZt6hHZ6X7eWMxi9/oAjEXzrklwp8FhpPF9brw8dYicxGbz1VlJTz6c4IZv8XCF2Yk+N9HPwSNUgPq/9kgzZwPkAkgFMyfKsNSCoF4stsOoQvvHisR1Rl8CvbHHSrc6KdGaxP+Jbx4ZJlXN1e3UFg/DZVppjGagifeKaRPXszpwR3Ul2bIQJ+lMiMo8iUhUMj/udSbQX9e2FsDtc3Y24eJwpFAm8IstuPAKrH9wKY/LsR+pFVmd1pNralSOslA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fThPhDTwNObVM4Kx3JibNY8hmQ6cL1dzLIfdDeHCb5o=;
 b=slnu32c6lhSehVObkeAdJDac3DloOBhzK8Z5PCxiGOnPRFuRQEwqAK2mtO/TU7ge1R+1HtZYQpzG5DhmFo4StFu1wjME228LtO0PVNUlAom09C4iE+6vbS88oZwHod1arKVswoiGPKTYn2Uz7uPVeGqTyQwLrQbYzIFsq/nJbESdG2usF4vQ/hLsZ0z/buu3y1zo32dAtw2q6X0vvlPo8qWJ00ZZePm7n9RNaEblx0Umm13t90TZpyhLGBDb2TJz/WQaMy2npGkkEpC9I3UMO5QYIL5A09CEpP9xxjCHq4bft5xI1weTTCXWbYLvxrwBdlRutvQWQDcs9t2FSEL/aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fThPhDTwNObVM4Kx3JibNY8hmQ6cL1dzLIfdDeHCb5o=;
 b=nYMB2m2dwO1/UPqCv0fMYfDgAwLEmyHHq2Nu+byaiM8zFL/6RlN6wYud/nkcPFqbrzZyvA4RV16AyLSSxe3ZUv0Cec1qps6R2G3UG4w85IRgZ9kTcmYUPvG1HAfN4ReL+C1KrwydMfaUrbJbEWjHxktebBBWZAtOUfUH0NgjN/m1OZmTn4eonr37sCtrYgcdlRknuLAdmIstf1wtzIcy9cxjcdzB0GH3TxRJeh0JTMzlz3qXPlkf0BgnLA3+fv+Spah+Oz1qY+wVpTMMbZ8Y/9kkZHNYcDRVa9qTiLKgYvQBdFqOJkB+GxTyWuT5wqPswgNXAzBCTKyLG4luuesGIw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DBBPR08MB5929.eurprd08.prod.outlook.com (2603:10a6:10:208::8)
 by GV1PR08MB8305.eurprd08.prod.outlook.com (2603:10a6:150:a2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 12:23:36 +0000
Received: from DBBPR08MB5929.eurprd08.prod.outlook.com
 ([fe80::8c14:5279:76ab:8d35]) by DBBPR08MB5929.eurprd08.prod.outlook.com
 ([fe80::8c14:5279:76ab:8d35%3]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 12:23:32 +0000
Message-ID: <5c4918b5-9675-4031-9456-58f6f51c0a13@virtuozzo.com>
Date: Mon, 26 Oct 2026 14:23:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] udp: let rx-udp-gro-forwarding aggregate under
 encapsulation
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>,
 Alexander Lobakin <alobakin@pm.me>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20261008163817.2983484-1-eva.kurchatova@virtuozzo.com>
 <willemdebruijn.kernel.2f0d78527930f@gmail.com>
 <dc9eda55-2688-40f7-9b0a-7dfa0e5cbf3d@virtuozzo.com>
 <CAF=yD-LZSec9g_0bBgrcQvq2OO1BrxMSRHH=uU7eamCmWcTO_A@mail.gmail.com>
Content-Language: en-US
From: "Eva Kurchatova (Virtuozzo)" <eva.kurchatova@virtuozzo.com>
In-Reply-To: <CAF=yD-LZSec9g_0bBgrcQvq2OO1BrxMSRHH=uU7eamCmWcTO_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR0P278CA0157.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::22) To DBBPR08MB5929.eurprd08.prod.outlook.com
 (2603:10a6:10:208::8)
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
X-MS-TrafficTypeDiagnostic: DBBPR08MB5929:EE_|GV1PR08MB8305:EE_
X-MS-Office365-Filtering-Correlation-Id: ccbf44b4-105f-4d4c-72f5-08df335bf2df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|22082099003|18002099003|56012099006|4143699003|10067099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	E7ns8csZKWKX4BNKCaXlOYsn52MP5hO2EoNvnKEOEHIq3EGuDFW9avCI3fqpx7AmAelC6BDBkbl++rItW8//29zazz0pmaWWToxb6R3xF5s/7Bbod05Gh1wN2dUPzEttQVTqUX4O5AjfOLesT8LefXq3WNpWi1SFpb+I0+oEWe9JhkYh3XOQvpxaIoVu8Yh7o6gwQ/tSUw3MoN7qcxtOADuDeaO+85+7E5ZNoJMF1khHoQmqHnxl6GyzK/R7K9mkVDxkdAAXWf5oSSS9pmGoD0kWybiODv6pjmOicgNMuWZkPOCYY/wk+GDtKn4sF8DIBBs5HHrirJ8sIU3Sl3oHbgB0tKlCIeREfHMZwpA61MdCoaIwBh9e/8BrsbcBrsnBcYnGYuNA5E++e6H3omvvG+Qzv8WS/Adli8x1MScTrLyoIzrHvhBZ/SMdRro6xSXckYgbeGwh+KjvkfetCOIMwu4lSFGnY0j2lCIQgFCGwpXSmfZWHLIp+3/OKoFqIxmQw+SE5S3VzK3rXKB+eRYlWSnC/39OorYkPniLG6KmmxeNbVA8XGRwM3hdq/kEOn2OPLkyVZfxljGWKMtrrXWqJU/5xa7Xi7GdEDumlwSHYULtuuLEAZMn/rff0Lbcac70w2AWahJkf3fcT1qvlRMWzj+Kynm0eXRabpMkXdt09gw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB5929.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(22082099003)(18002099003)(56012099006)(4143699003)(10067099003)(261022105027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cEUrYk1wVTBncVpvd0V6eHpSRDB6SGdCaVU4N1dlV2VTbWp4aStLdHRVcFkz?=
 =?utf-8?B?c2tiYStnNm90SUwzS3VyTXAzRE5Va1dZZkdnZUt4RzN3bjh5Qy92N3hoU0Nh?=
 =?utf-8?B?M0NZTllQdW90K0l5Q2hieW14YnZhRXowNTZpNmJOUUxTbGhmRHZtUnV3SDVt?=
 =?utf-8?B?c3FEdytZZXNpMW5xVDVnbmUrdUs4dngyMjlFeGN1VnlQelJ2b3d4aG1wMGNk?=
 =?utf-8?B?MTQ4ZXl1SUlXTzhDTkZMcWpGbHFidmpPcE1rSnVhQm84SDJUMmxjTWg5MFdR?=
 =?utf-8?B?T04yaHJOZUkzSjBuQlF0eUIybVA4Z3JaUXRDSXNNeHQvbk5NWkh6MllDNmsy?=
 =?utf-8?B?QURkaGxaRmNQeWFiR3lCSUJ3MitCMVlDK2lDV1ZCSVZSbVRFbVJBb1ZnVnN0?=
 =?utf-8?B?WFh4ajNMNzdXUmtBbzM0MjMwbkRJZ1pmaWNnMTRKMUVPYTl1ZzNhcHc0MEhq?=
 =?utf-8?B?dTV1MmdDYThWbEl3UmdEV3lzYU1PL1hZUTR2dVo1OEVNTGI1OWdTNEdIYXRN?=
 =?utf-8?B?TkNsbkZJUW4xaWZnU2pXTlArTTFuTXJ5MElVSFNva2p0K2g0aTliOTJud21l?=
 =?utf-8?B?QnVlajNrN283UEZIbGU3aGZRUUpMNEdjV2JQR3R1VE50dGJsanJrcWI3dDRF?=
 =?utf-8?B?Q0tDeDR5RVNjWXY0TFFycG84OExmb1ZicVhOTDYwbDFKMHBPT2FCUlg0YUpV?=
 =?utf-8?B?ZWw2ZGJUVEdvSWM4dVFiZTRxa1dqa0VNQVdJOFhHNXZVZHRFMG9YUzBLeVNE?=
 =?utf-8?B?aEFvQUVwRjdodVV3cGNnS3VRbnp6VzVLNitmQTZjRkJJVndYZ2Z4anRFUEwr?=
 =?utf-8?B?NjRzUHNKYTdUakMzMVR0d3JyZHYwdU94UkdCNWI5cFBkMjJ3Y1A0NndSMWtB?=
 =?utf-8?B?UEVJa2JCd0QwWVpaOUJOUG84aE5ibG4zOTVQTm9mZFJWa2NITkN1SmV1QWdM?=
 =?utf-8?B?T1NBUTZjMmU4c2FROHZNRE90VHZvTmdlSmFyMXdhbTI5UkJyT2tQMHQrNmZO?=
 =?utf-8?B?Vlg2ZWdZaGhLYWZoelNCdGhiNmhxMktoTlIvVUxyRkJkYnI2bFpteVJybDdv?=
 =?utf-8?B?aG14T1BLZGlqWjlXcjlkeVl0dVpjejhmT2JSRlVSRVEwVlVIdGtoVkJ2WnYz?=
 =?utf-8?B?aVdwLzlBcUw5amdtblBnT0xyQmZUY1liTlJyWTlVUVVYVnpqK1RsMmxjQVc4?=
 =?utf-8?B?eHdTR2owV0RYWFF6RFZ0SkVMYzExQk5JVVFkcnV3ZUhhR1RmYlJOY2NBQ2Jz?=
 =?utf-8?B?Zll0blV0b29WQytRd3I1ZlArc0xjcE82bGdaNjZCMVF1WWJxVTJRSUFsQVZG?=
 =?utf-8?B?eThnckpmcTcyMm4xL24yYWVXTTlqTVdyd3NWSHNyVkFCQUZwZFB0ZUFLd0l6?=
 =?utf-8?B?QlJLVzFybW83MnFTOSt0WVRwcWtPSEtQZlJwd0t3QnFKOW0yZWZGc24vaHNN?=
 =?utf-8?B?cWRQcE5raDVLNFA1WkRMb2dsYWVOOVM3TUNMbWFibndjbkwzZUJLYVV5Z3Vx?=
 =?utf-8?B?MWdFMXNLSHlPKzJobnVOcCtWaEN1cG9CaG9hVGtFMXprWk05SzRDcHl1SWZw?=
 =?utf-8?B?dHMrelY4bnpXRUNKZmtsenVJZDRja3ZpYVFRT1lZNmJrcDY4VFdNUGF3OTgx?=
 =?utf-8?B?YXloWjZCUzBsdDlHdHF5TDRKR0FJeTJPRk9SenNydXQrUDVDZXgrUUhmK3hL?=
 =?utf-8?B?RlFWcE9xdkJlVlZFWG16NWFwaTE0R0NrdUxIaEcwdGtESFQ4bWxTSGpmSzYr?=
 =?utf-8?B?QnFoZXlUY0pza00vSzVqZ2ludnpaUXFqZ0pwYXE4Zk9HdmI0a1NOenJJRmN4?=
 =?utf-8?B?WjVwYnVUOHdKWVp5R1R4K3h6VERyV2ZvOWhtN0FwaFpVZDliMDlLSXdZL1Fp?=
 =?utf-8?B?dGl0YncrOU1yNGdtSmJ4VWZVU0RqQ2hDNkNobGtIYXltVTBtYmZCRDFST2Ja?=
 =?utf-8?B?SjRYZWJOdzFyL01NZzdNTmVBWWtXQVVWdld1WHFwdHFjUCtVeGgxdEEzTm4r?=
 =?utf-8?B?N2xZZFFMRmM3b3F4Zk5QUStMclgxMlFqWXpaclRBMUJiclFXZlVleHo2YlRG?=
 =?utf-8?B?U013TXBsN0VLTHFDNVU4d3VOWmduSytydkc5T3Q0OVZWL0I4Y3daODlkSW9G?=
 =?utf-8?B?RWJvQVFIWml5eE5yMThVV3pvOGh2UVJOd0xzTXQ4TWRaNGNsTVRhNUVYMWxU?=
 =?utf-8?B?alB0aGE5UXNpeDdpdWozand2SkhkZmpFM2l2aUV1QTJ1a0pOSWdjNUlFNWlM?=
 =?utf-8?B?ZXEzSndSZDNRak5tUnA3cHNDZ01UQWVMNFRDRHNJMTdqamhoeWwwSE1RUWU1?=
 =?utf-8?B?alc1eTBjY1RqRUs4UjlCSmdlNnZIbkxLNDNOeVBqbmljNVZBcGxScDdBMGg1?=
 =?utf-8?Q?nOBma90frJ10jnOM=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccbf44b4-105f-4d4c-72f5-08df335bf2df
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB5929.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 12:23:32.1133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6GkpWcfT/r0eqRZJKGG3/LhUbV6XYUvlUN3IMwFlkV1ynZPMOHxtmlvdxg5s8qKCfdi6y4FsP0qX4rMT1SD4iL5nJCW4rL95cNvJJJlL3Ss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8305


On 10/19/26 21:19, Willem de Bruijn wrote:
> On Sun, Oct 18, 2026 at 12:54 PM Eva Kurchatova (Virtuozzo)
> <eva.kurchatova@virtuozzo.com> wrote:
>>
>> On Wed, 15 Oct 2026 02:56, Willem de Bruijn wrote:
>>   > Uses encapsulation in the same network namespace as where the test
>>   > runs? If different namespaces, the socket lookup should fail and
>>   > thus the behavior be the same as on a host without a tunnel.
>>
>> Different one: the vxlan sat in the init namespace, the test in the
>> ns it creates. The static key is global, though, so the tunnel turns
>> the lookup on everywhere, and the lookup then runs in the test's
>> receiving namespace, where it finds the test's own receiver: a plain
>> socket bound to any address, without UDP_GRO. That is why the check
>> goes from 1 to 10 the moment a tunnel exists anywhere on the host.
> I also don't have a straightforward fix to the test. Maybe just make
> this one optionally SKIP if it fails.
>
> This is the following test in veth.sh, right?
>
> "
> chk_gro() {
>          local msg="$1"
>          local expected=$2
>
>          ip netns exec $BASE$SRC ping -qc 1 $BM_NET_V4$DST >/dev/null
>          NSTAT_HISTORY=$STATS ip netns exec $NS_DST nstat -n
>
>          printf "%-60s" "$msg"
>          ip netns exec $BASE$DST ./udpgso_bench_rx -C 1000 -R 10 &
>          local spid=$!
>          sleep 0.1
>
>          ip netns exec $NS_SRC ./udpgso_bench_tx -4 -s 13000 -S 1300 -M
> 1 -D $BM_NET_V4$DST
>          local retc=$?
>          wait $spid
>          local rets=$?
> "
>
> which gets called both to verify coalsecing and no coalescing
>
> "
> ip netns exec $NS_SRC ethtool -K veth$SRC tx-udp-segmentation off
> chk_gro "        - aggregation with TSO off" 10
>
> ...
>
> ip netns exec $NS_SRC ethtool -K veth$SRC tx-udp-segmentation off
> ip netns exec $NS_DST ethtool -K veth$DST rx-udp-gro-forwarding on
> chk_gro "        - aggregation with TSO off" 1
> "
>
> The full solution would be to add a third true routing namespace in
> between, which would not have that local socket without -G..


I agree, and withdraw the patch. The lookup behaves as designed, yet the 
test asserts it isn't running.

Will follow-up with a fix to the kselftest via the third namespace, with 
your Suggested-by.

