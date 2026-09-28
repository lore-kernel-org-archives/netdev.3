Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021124.outbound.protection.outlook.com [52.101.65.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A5D483BFA
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 10:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790592866; cv=fail; b=WqY4UzYU8OwJmhPnBzlRaC3Vh0uLGW2u4JBNhokZ5CDczbcRHbqngLiH80hcbtBhr+MngpEDSRDAyXT8BV/gu1pYNKAB7euywGEs/lVESinj96BqmDhl+2F3PDHT+21RcVfI6W1+1cYGwRCXgMWPrXLueTlLXPMZJNHwyhGTwtw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790592866; c=relaxed/simple;
	bh=V8Q4EPrZMPJ8wQTMkMPHy1c3JdEsbuln58QQ4oJoDvM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Duu1LSZqIZsmzTucXtM2jqcUCrpM6VQrj78Gq5LBQeghUalD63E56xnGFiYfRTivj/pvoyKZDPmOAZSEWsiUmzoh+DqupeLS63a2jd4fbONMsb3Pi4b4T2uzfuTZbmRGir1/LzBa6cIH7jBSsmUqse+GLZdJR+KFvOFky3XZXgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=genexis.eu header.i=@genexis.eu header.b=hqEvK6vp; arc=fail smtp.client-ip=52.101.65.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=genexis.eu header.i=@genexis.eu header.b="hqEvK6vp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W3z7tCtzyTrhTHDhc3y8rca78i69EI7LqlnEYy+Lnu4Oqm8M0gUCFE6LbDZogYHI68gK9FKQ3Sxzo4HxTr03qML+M89YZ/aATnRGJQqbvWXSAm8GmJvxOA6ULjyw6Cgvy9wwiKOX0+wO/0aGcEtGHjSbmyz8yjKEyWD3f/Hwj0cZBX/OVs9ALlSk1IQMt4R71lYTlEE0ehQ9HIDckJvScqiwyr3uOAGY5U4w5N6uKJITJaYu9uiL8tVq+dPhQK5O7eSyqYKLBIjyn7nGIAcU7RF+JQrLCcHN60IsL+HqsuhsNa90xwyVF6UZrJKAamOBPl9ggWeCFVh2hBiAoLcFkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M2gAsbs7K6tRLi19uxzoBSCpmnsK0t32dPC/j163vw0=;
 b=uEP4+kiOIGVMAtNzTXAiD0mLl7oCeDNz7/qKL5uF+RQjHC1Ms6BoiaFpogM5tz+fQyD1cxPCfIw8bJ9K81o60ChMBPgOY7oiDWL7Y9Kz0evqAXfNW4+n3vrkR35sC6FyMKm91rMEHoYxSrJCo7YDDh+JClLkjjlJ5sf9mwkSDCXq88/zwqC1GY1yWEXGS1EXI6nGEfesTUnf2pn/QJSYdb2t+oTkFSEtYe6zkfcfm7wx28SBCMw6VYsKh2vEhW+9ETcx77/Kt1Kh4KsXReUzQYyR2zPt9XQnzZMMR6h3ErYukkgVQSEXTn8A7sHOmkbwb2vuxd5FOaHyrtmvvE0TAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=genexis.eu;
 dkim=pass header.d=genexis.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=genexis.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2gAsbs7K6tRLi19uxzoBSCpmnsK0t32dPC/j163vw0=;
 b=hqEvK6vp511B/F0sSHTVBrJcuQU2TAhA08z5fuUHqRg231IS5/kXLT0YCPWt+Vu2J93RMpqCv2FA6waMJvEqkWbsxdEhl10autNfsXEJl3yt5OX948pjI/mqd+tUJHTO4PftybVn0cAIB9Chuo/k2t6eX3r57TwnV5uhmaiTvQDYjkQQ6aVbkAcvbVpxYEdaIZ3xftX6WzUQOn9p3djQYd2H2rLqdylC0rjgkQ0jxWBP7RmAlglFHlJe6pDjTUFqNRK9Bu/RYnEGTUANpY/hH91ruKhmQCiz8yP63lHh6xONxawfxFMug07+4ovwvwyGJyvPQm+NIBgBIiKblVVl6Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=genexis.eu;
Received: from DB9PR08MB6697.eurprd08.prod.outlook.com (2603:10a6:10:2ad::14)
 by AM9PR08MB6212.eurprd08.prod.outlook.com (2603:10a6:20b:285::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.21; Mon, 28 Sep
 2026 10:54:20 +0000
Received: from DB9PR08MB6697.eurprd08.prod.outlook.com
 ([fe80::bdec:3e95:6614:441f]) by DB9PR08MB6697.eurprd08.prod.outlook.com
 ([fe80::bdec:3e95:6614:441f%6]) with mapi id 15.21.0472.005; Mon, 28 Sep 2026
 10:54:19 +0000
Message-ID: <747749a2-b168-4ba4-98d1-12991e8694bc@genexis.eu>
Date: Mon, 28 Sep 2026 12:54:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] net: towards a generic PON framework
To: John Crispin <john@phrozen.org>, Andrew Lunn <andrew@lunn.ch>
Cc: Ziyou Xu <xuziyougm@gmail.com>, netdev@vger.kernel.org,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King <linux@armlinux.org.uk>, Gaoyang Wei <yhyxwgy@gmail.com>
References: <20260926174601.1675-1-yhyxwgy@gmail.com>
 <b0d1908c-a6f6-4c28-bb4f-b00644acacfc@lunn.ch>
 <92d9c8a9-ef43-45ce-a599-2c00d0a2fa61@gmail.com>
 <3d5e9f9f-09e0-41a2-aa3a-e3bcfcecbef3@lunn.ch>
 <7a469037-1266-4ca3-904b-9e8117cce5e9@gmail.com>
 <e17ad80f-f2f8-4776-9f8b-1b7d3407c438@lunn.ch>
 <86e368cd-9f5a-49cb-a798-0f26a661fc30@gmail.com>
 <372bc103-e98f-486d-8dd2-f013b1dbbdcb@lunn.ch>
 <0077ab02-2215-4015-9e74-eeb8c3de6b14@phrozen.org>
Content-Language: en-US
From: Benjamin Larsson <benjamin.larsson@genexis.eu>
In-Reply-To: <0077ab02-2215-4015-9e74-eeb8c3de6b14@phrozen.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: OS6P279CA0058.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:31::15) To DB9PR08MB6697.eurprd08.prod.outlook.com
 (2603:10a6:10:2ad::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR08MB6697:EE_|AM9PR08MB6212:EE_
X-MS-Office365-Filtering-Correlation-Id: 3365a53b-b542-46db-0dcd-08df1d4ed8f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|10070799003|3023799007|10067099003|56012099006|5023799004|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	4vF82r0ZipQMpO4oRf+yBVCqfFn/tC6tbMy2S4mROzXwfd+zNwHETkrmRk6cXuuAymlyPHhYVN5/p4PaEmeqMRdHmTFpEcjibCAAolXk5AMWALurqbTGt3ylyufz4Fc2HWoQ18UpfB6uPtCZuC8mfrAQJNBJGZ7Vsqfu3JE7w+ViHk0K5aCwOz7KojH/1xXJJ87G+E0DnFh6Y8XRaWpuxYM4MsPHFxZ5we6Z01U8BL0nvDF89fBmK3IMB9ImwNxhzVyohF1fn2euMgsoXrg9hQt2WJOmoeDB6z6ss4zXKlTn12q7HYaKof6KmIzlEdcds6wee2s/K3oBFekhrtNlHh5m1DGHJmZIN8SuVnip5edvRN6AtfwLkIfCMWR/SnPMyRrq7BRWtyF7phvOvXVumRkx3lNQ87fNJ4Hi89Ovqb2Ji4q8tY7YAnx4EtakiB0n56o+JUKbEXIUG+7y4c32AZYBQNuFAob9YQoJm1GPWMUUz+/6kwGNSSg4+VkFeQSklFhEBQB0Zca2VOlZuQ34xvAO97D/oECS35Impq3bWeq9v1mnwo0h/YlpQjTAEkqvh7khjxaaOwNpWDGHg/eKgeXPWdwprMmkj0SoStsA2ULHw9K7SzH6l1GyFlVzdrsGPCbJrnPK56hvVsYEOLpTWChqoJbYZlTs4NTM1TYUp40=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB6697.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(10070799003)(3023799007)(10067099003)(56012099006)(5023799004)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q251ajlMMFBlbFhkNE5OaG5OUXFUeExoTjZzS1ZVL3BXUW00azFvNVNoTmsz?=
 =?utf-8?B?QURia0xpWi9qNkh5b3FXTDNidVZUS0lTSE5tU2d5bWZHQVNJa09FUTlXWlAv?=
 =?utf-8?B?dnJ3RTJIS0ZrSks3R3UwdllnVWFEbDhVWTB4aWVGczRlVXRtWHBnc09zaTZ5?=
 =?utf-8?B?WExZaEdLVE1GRmpjWXE0WXN0UGsrOTBJM3NESmpBSHE2RHFiaFkrelQ3dnM0?=
 =?utf-8?B?Wm1iNjVqblpVNTZnaHhkMklWNmEyQmVyQ0ptUjc0WENjckFwaSthZ2hFNHpN?=
 =?utf-8?B?K000cDc2MUF0WkxlNGhkbDA4U1FJMGVmMDIyRWVLbFJ0LzZoTnpkRXZaYzdj?=
 =?utf-8?B?enZkWDZBUUVGeE5RNksya1U4b1NxNGg2NHJ6OExHTEdNaFJWMVFjY2ZPQUJK?=
 =?utf-8?B?dkt1L0Njcmdtd2lGczAxUnYwQy9BN1YrLzFsYWY4V3h0S3lVRzhOZlhINHpT?=
 =?utf-8?B?ekJtZFFwZDNtMDFzZ3REanQ3QXhQamZxN0dPOXN6M1l5MncxVWtpUktrYnJX?=
 =?utf-8?B?azF1clFqaW9mS1BTSEpyc2Y3ZmFnQTF5eldhdjlnY3pLN0JRelFnQnVLYTZo?=
 =?utf-8?B?NUwxOEU2Sm1uek5nRHh3Y0VmdGVycjRNek1xVVVwTGcvcUo4UHo4OXppM1Ni?=
 =?utf-8?B?cGpVS3VORlord3BWRnJlc2wrU2dXVWFxVkRJdStmZHNKalNYVkVNNGFrOFhH?=
 =?utf-8?B?dHRvNHErTUFQODg4Vnc4c2lxdlNHV24zV2NOUThuU2VSN0FQYThBT0djditC?=
 =?utf-8?B?TWdobVlidk40ZzIxRytLaC9LY2IyMEFCUDluMGZhdUhSOTJJd1lveVJPOTN4?=
 =?utf-8?B?ZjFmd3paTDRKV1ptenpWVU9mRmdrMVpGQ0dPUzBseHN5Y3dpVldDWno1RmNx?=
 =?utf-8?B?RXlSZ0orZGpSYjBkREk3WXVvTnFFZWV6dEVpMEN4Y09lOU41d0RNMi9ZSmFq?=
 =?utf-8?B?Q2pDMFluTVFyZ2FFUDRPRzdkdW5oRllCdjBDUjNBRWpSN0NaK0VKM3FXME5p?=
 =?utf-8?B?TEU5QUtDZDZORkR1dXRtbm9PSHVLNXBoS29QemZjSURDRkppdGRYMFRXNmQ1?=
 =?utf-8?B?ekVnN3ZXMHlQeWhhRndJN1NLRStncVdmWW94L0lrRFdZeHNDVDVTZUx3RXE3?=
 =?utf-8?B?U2JQNnpKVDEwUG02eUdhNnlmQ0RHcDJwWDZGc25GZW44TWtjMDVoaUpSTVd0?=
 =?utf-8?B?Y1cyaGNJSzY3UTZ5Rk42YVcxWjBXRTE3Z1U4KzlxaTBZVzkyUFlZcTREQkVo?=
 =?utf-8?B?UjVwYnh1S2pPalVFL09FWDJDWStJcGYvWG5RcFlkeHR6N3dtVXA4UzhKWWFh?=
 =?utf-8?B?cElvVWQrMWpLMm1lUEpRcGJSYXlQZVVFb0tYWGh0bThUckgzNnBtMXphaEY3?=
 =?utf-8?B?VUFWU1VZbGluWUh1VFJxU2VoTE1aMGI1dzNoeXBYOEg0WkJHRGFDN2JOUGxD?=
 =?utf-8?B?dmJ6UEtXUXMxcXRNTVhITEdTZUpjL0ViMWUxTGp0RDMraVVpVWRENFEzSjUw?=
 =?utf-8?B?Rk0yNjhYeVpEZWNlN0daQVpRNHJncmFFc0V2dWZtMnV6UFU0aXF6VENFVlpT?=
 =?utf-8?B?K1NQRXJDTG9wMEFpZFR3Q0h1RjZyRTNoRHBPUzRKQ1FaemJOeU92aEZzSU9X?=
 =?utf-8?B?c1Yyb1l6b0JkZEFkL0RzMWlzVTVoU3ZrQ2lPanR3cmJTUEpZc3VxVUkxSXR5?=
 =?utf-8?B?THlvd2l2aWR5a3B5VnF1TnBFcmdwNzJtc0VheGt6QWdEb2orTUVpeDBGb2Zt?=
 =?utf-8?B?SFF3d1R0WEoyZkFzOStJdDRzaGtBaFJLYzR0MmFyY0YyMU9LMG5kakpWSUQr?=
 =?utf-8?B?a0dvVlNCbmltZ1ZrVzV1UzJVUlVQU1BsUk5tU2JPRXZuYnR5NWNhdGkrdVkw?=
 =?utf-8?B?UDZQc2t2R012RVl1SUhZYnF1emxHdERUUlRRb0VhMlQzU0lWZDljeU53STBm?=
 =?utf-8?B?L1IzWjdGcFVjL2MwNGJiOENlMEYzVEtJcFRYZjlOMHNwZGRhVHVRbTBLUlUr?=
 =?utf-8?B?anpUa3VIcFZMVjdxTW5wVzFQcHdjMm1jT3BRUEM5b3kySXo4elRJSDEzMi9S?=
 =?utf-8?B?bVc1dTZHK0JRckl2WXhwR3JRc3dRMmtqVnNmUUdialVoS283bFhpWmhqNHVq?=
 =?utf-8?B?bHFGRDE2NGsvcnFCU0FLTXRHYngwVHI5WUs0S0w3dEpMcDZRaTZubHNQWkxm?=
 =?utf-8?B?ajFUcjg3THN5akthOXpuSzNRV1FUYng2bnFDQjVHMFo5cHI5SEpFc2FBaFFk?=
 =?utf-8?B?Mk4xNStYVzkrdmI4WThscWpudXlIbms0clJoWU9pT2lkTjZVTWxUYUI2bFRu?=
 =?utf-8?B?NkxLcWdycTlLdUUwcnNPQVZXS0dBRTgzUDNRSnV0YjE0LzQrOWtlZ0FzbFpD?=
 =?utf-8?Q?/LjbqWNatp8JQZzrYhQuDfhm5Ws65xhFQbTrEyWfAcu8P?=
X-MS-Exchange-AntiSpam-MessageData-1: pdjZXNovG78X9lluFjiSLpwS4HFhrDSh/P4=
X-OriginatorOrg: genexis.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 3365a53b-b542-46db-0dcd-08df1d4ed8f6
X-MS-Exchange-CrossTenant-AuthSource: DB9PR08MB6697.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 10:54:19.6329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5oiFzAsdUd8T8AryeqpJI/Ek7eQU6lC+PHG/y18vJEdiDQGPoCz13Rr9lusbxpumLsexNuygoCz56VElzQr6eNBT1P9+A7RyoW/P5TLb/LU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6212

Hi.

On 9/28/26 10:37, John Crispin wrote:
> 
> Hi all,
> 

[...]

> 
> Benjamin, you wrote that some parts of the MIB should be handled
> inside the kernel. Which MEs do you have in mind? The OMCC transport
> belongs to the core, so an in-kernel handler could attach to it. I
> would like to understand which MEs need it before we design for it.
> 
> If all of this sounds plausible, I can post an RFC series of the
> subsystem within a week, together with a link to a git repository
> with pon-tool. Before that I want to move the OMCI transport to
> generic netlink and validate it on a board.
> 
>          John
> 
The opinion behind this is that if the requested information is from the 
kernel then it could/should be directly handled by the kernel. And in 
the case when the OLT is just acting like a dummy bridge it would be 
convenient to have a bare minimum kernel omci stack so a user space one 
would not be needed.

If we look into actual MEs then 131 (ToD, 1588) probably needs to be 
handled in kernel. Then we have counters for a lot of different things 
where the source is often the pon mac (ME 312, 341 ect). And then we 
have ANI-G 263 (optical statistics).

In the case of ANI-G 263 I looked at hwmon a while ago and IIRC there 
was no nice way to consume hwmon information from inside the kernel, I 
am quite sure this will be the case for a lot of other MEs.

So a hybrid omci stack where you can override specific MEs if you want 
could be a solution, a somewhat complex solution.

But if we go back to what really needs to be in the kernel the answer is 
nothing as every vendor I know of has a user space omci daemon.

Anyway great that there is work happening in this area.

MvH
Benjamin Larsson
