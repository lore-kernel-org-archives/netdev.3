Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793012738;
	b=l/2wvLpXW0EteAweGB1YeSkEUxIgdRooye+LT2Els0a/Z3nQZIDJ2JCkYgSxjebDG2l1
	 ZgioDN+vJAKXXp+DJdYrhcpuw+AOgx88twYJGf+vseM5Vsju7y5UP6uE7baNqdAg1ZzKH
	 swc8qK5O2RQ9b7N/PwY61oipyKHrqv4StAmVPIVLDwUURCgJiW8IePR7fRL6m7jnNAUsl
	 Tr/ek+v5XQRvJiIRuWQtWycfYWhYgZ0yjvYR2DhRBhNUsjA6KhvV72V8Vj4yFra0iLw74
	 TE2tEVchP3SABdG3bSGgxus2sWlNLgze7Cly4ObmQwGiGFDrZ3cKUJZM7Av6esgXH0w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793012738;
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
	bh=uiPGx4zCDvD/3YFOkRVsdRDA/Q26VWDAi/Oc4lZvodA=;
	b=AkS7vIMfGvPUfQIvY6hdsYv55ko47eJaujkIJtaLIh5tQH4HhgYeK5uM8GnEKmuXZnwW
	 9s0i3T8OS9Is6BGuNsmW8dm7vVPfRAO5eDnPiYx5ZBpya2OIEt3wWFVbrzy7BMzAmO9OH
	 MwV/dZgLoGdOW/R0ahivoAU4REiQUnoDU5g8Vn6uLfwAgS2mRhSdb3IG29gv5VnFui1tl
	 5x6INAKsgzQUdxDHhtSwzfdEMwFYPA5WtFqJx0NrCQ9HlCHjk3DBNZIo7LSaFCmAct5P4
	 ueC3+F2NSAcjQ5SiCCIzVOQrZ5WGURYmv6E07RNUHvTBCaI2glN1p8oV3kt+33/tqbQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=YfOTqm8Z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.15
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013015.outbound.protection.outlook.com [40.93.201.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649B5606A326;
	Mon, 26 Oct 2026 11:05:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 649B5606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=YfOTqm8Z
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rSdFfJm+6whxa9hkalbH21Rk5DUWPOUaQovu3gd9XYZbno+aeVhnCHVKrEAifr2G6dSMjomDT0x1HXPzSWHdCeGlCZkYzkhgZtEp6zfj6dk3jT5IKAGkgrva0WcmYIhS02E69f2b8czuYfWcH3+xeu+c/u/aCy8cbFOZhCynR8B0E2KshWIiSjLnlkZw1rl4L3r+WlCjxHQFHKaNqojR9Bs7tFZS2YrCFSI7mSypFg4RYmSYnTDgOBjZALF40kF2c3Occ90QFzXrr1V0JOgguWXmcY8GUhYx6DR1Z2HcObQ0fvnJ01KiqVXj2+vU+vYPheXgUiANQtmO++TSKo0OEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uiPGx4zCDvD/3YFOkRVsdRDA/Q26VWDAi/Oc4lZvodA=;
 b=u5gKahIpLkMCXsexMxQyK3lrSEkSEj5lU5OYLSUKTl8sdRd7ezKTfsf9FfuA8enPgJiDIFCCiFNDi0eVmihFtwnCOCr9v8y+HEebth8i6J8UOEG+ccUanJiQof/ZG0LULJBxox1iNjSgZA0TVyDGg6Zlt+JGEL7PIxP1kPTfzfu2iHb5K62LJL2yE7X3L41tqAj+I7lKluV3p+zDT7nYQjmVldNinwQK1N+zC8kh5tsepizXzu8h7Nq4nCtWCk0pcfWfZ8hES69hOf1xw26KnRIt7kA4y/Fei95E0cRMjD3UYYFMyTROPQsijaUTiCpWFuhY/t4HaDybsS9oFOsvtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uiPGx4zCDvD/3YFOkRVsdRDA/Q26VWDAi/Oc4lZvodA=;
 b=YfOTqm8ZR7u1yZFC5eWXfJKA5aoeyJuKL5ppH4FIAM9SyfU3Gsodk7n9AE+6hA2TgQhn1D3beXY1USi3OhExz/bynlLyWTp/HopjbrxA6E01RgGDowqAxn1FDrugtBknefK/BSVkXqtB0rw+RyG39WiCt0ztb0R/ynC2YmF7MiI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4283.namprd12.prod.outlook.com (2603:10b6:5:211::21)
 by SN7PR12MB7226.namprd12.prod.outlook.com (2603:10b6:806:2a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 11:05:34 +0000
Received: from DM6PR12MB4283.namprd12.prod.outlook.com
 ([fe80::9eab:812b:ad20:6087]) by DM6PR12MB4283.namprd12.prod.outlook.com
 ([fe80::9eab:812b:ad20:6087%6]) with mapi id 15.21.0546.016; Mon, 26 Oct 2026
 11:05:34 +0000
Message-ID: <387f0510-d3ed-4e12-9e70-8b6242a8e565@amd.com>
Date: Mon, 26 Oct 2026 11:05:30 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 1/3] sfc: ptp: drop the stale frequency reset in
 efx_ptp_start()
To: netdev-bot+sashiko@kernel.org
Cc: ecree.xilinx@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, netdev@vger.kernel.org, linux-net-drivers@amd.com,
 linux-kernel@vger.kernel.org, alucerop@amd.com,
 pieter.jansen-van-vuuren@amd.com
References: <20261021091534.3164258-2-alex.austin@amd.com>
 <179292676968.3134.7576333163086767429@kernel.org>
Content-Language: en-GB
From: "Austin, Alex (DCCG)" <alex.austin@amd.com>
In-Reply-To: <179292676968.3134.7576333163086767429@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO3P123CA0030.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::13) To DM6PR12MB4283.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DM6PR12MB4283:EE_|SN7PR12MB7226:EE_
X-MS-Office365-Filtering-Correlation-Id: 81a16b0d-e461-435c-45e3-08df33510ec6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|10067099003|22082099003|18002099003|11063799006|56012099006|4143699003|261009223027099003|261022105027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	IqkG7K6iDHuPgKIqd8uiQlm9NuMWZSog5GX8rFObBNizZr7V9q0OHUjX3QpFyNMTsnYoOUPAOd/U51vyf/iOD57/pp24Z/K1ETCoc7nEuWsEo4CHDXQki1Px6W6kN/vjhUV7+vfEcxjWkncWWbDogGjuHH8SiYKJVN0qA3Pb6zgdqYM4OTCeE4wQNhstw+6kABvFcEdypi/LHlc5aTQycbUYo17MHp8BJ30ZG4ufdSxGNK1kUdIBen8vRH07QNpg2iOfCOu11tcxLcce7OPGSSKYs8IvPL73GvNoThMFpF+QRoP4hG7KB/Z2fyq4RiDWPi/iZrtJIVhyfHXpsacZUpFYdTFXIvyi4lMy/R3EcWXEFnI5PGCBX3EAOyndhJ/NXTX1dumqwducQMkrop0+agHzfnD9hehtdzU58795bowAjK+7onOuEUFd11PUzA7DdlnTh5x026c+UxKz3ormBMk+LvKaJGCe0pngjfyiXeDrTr5ylnTheBh3cpZV3IS5IK4pu/u+7epN0aaLHByZyhPvGcN/hB/s8kjkUcihw/cEtGwvjvB0ZNZmBUrAKBm9LZ7OylGIceTg893a4h7rmmzy+90VidrSZipG7ah8np4msSM7D5dlU9/JbZSXUjzmKh439FRkRWS7cSo9vIgnsRsMRtyU5QJShsAjN27G7iM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4283.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(10067099003)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003)(261009223027099003)(261022105027099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MkY4U1MrNDNxRXRsakhDaEJZdCt4L2VOdDJPa2FJaklwY1A1akcxMlF1N1ZG?=
 =?utf-8?B?YVdLcjZRd3U4MGF3ZVVZQlUwbnFtSExuaEFVQUlCU3JWTTlITi8wVHY1TmpY?=
 =?utf-8?B?NTBJaWFsRUdoaFFZeDZQSTFUbFB2ZXhmVWtJNXBwTVkwUEV2ano0YWtHSEY3?=
 =?utf-8?B?cE1Cdmh2Z0JYU0EvOG55VFNYSEhrUFFPdzQ3S1VMYkxoeTUzMjdydE1kNzM0?=
 =?utf-8?B?cDFiQ1U5a1N3YS8vQllzVmEza2lPeE9iSVBmelNvQUJSZGJ2cXhUY1FXTDBm?=
 =?utf-8?B?c1hxWUttQy9kc1dpYUNMVWs3dmExeEM5bENqTXN4OTBWTWdCTGZCSW5mQ2tL?=
 =?utf-8?B?c2NIcFZGRlE3UFpnMllWQWNKeXcrWllGVXI4V2NybEsrTHJkSnZ3N2Z0bTdI?=
 =?utf-8?B?UmtCcmMyVzBPVkUyMEpvOHc2UVhKZEFFaUd2YVVmWFY3TUh5QnpvS3Yrc0E1?=
 =?utf-8?B?RThqWDNnMlJuRW1KYzRpbmh0UzY0bTBOcndIcUlOZWlMOGYvaUQ2cHA0ZkJn?=
 =?utf-8?B?MnZxYm5MZDZzSUFpWjVmYUpBT1Z1d2dmSEc1TDlVRW94K2xPM1B3TCtUenpC?=
 =?utf-8?B?R0ZyUXI5T1Y2OU9BMWJTcUROOEE2ZHE2T1Zuc2R5SDkrbWZsZXB5N2kxMnhl?=
 =?utf-8?B?SklxUG5HVmxlUHhoMEpTdkt0ZmVHcnhRWlVveGFUT2hnSWpuT3MzVWowM1Jw?=
 =?utf-8?B?SHFWbm00OCtMWFBsa3pZMEZ2bWxQTzRla0dNRVdzQ0lFQzVyT2ljYWVpWDlM?=
 =?utf-8?B?NVVHdUhwbDhNT040WG9EMmdCWnlwZXpWZTdlTXlKQTlQZlRqZ1UrMEVkdlg2?=
 =?utf-8?B?RWpqbXpzVjE5c0FSVVZTVC9ZSkhyZTVkV29OYm5pZDJJRW9ucFJCbkVMQWJD?=
 =?utf-8?B?dkNMZ3NSdnZ6YVVnd2Fna2ZkOFQwVlRLK3JKMGhLWjM2NE41OUo4azA5THdw?=
 =?utf-8?B?T0laMnk2ZXpTUW41RzgxcjdJT2NpQTZGMG52Qm1PQmZsNm83Rys2N0JJUGFF?=
 =?utf-8?B?WFdveG02STRmMkxOVkwrQ0l2MjlaM3F3Z1F4Q05BRDB2a0R0dTZjWm01dmRt?=
 =?utf-8?B?ek9KRUNTM1dIeVlKT1NVV2Y1cnNVaVJRRnNidjM5aG1vaFR4OWozSE1iYitB?=
 =?utf-8?B?R2YwWnJ6Q2xFMnU3MGQ3Y1BxVDUwS0s2TTlsZk5STUJxMGxUSTh3SXZpUW5i?=
 =?utf-8?B?eUNKRFhVZXByZVpObFN4Ykt5WCtmUTJRaHp1enB4MDR5Qjd1d0pCdldSTFBK?=
 =?utf-8?B?NlcwNzhsTDVabXdGTDllb2FPeWtMNG1LV2ZlaTdKZit2cWlaS1hZcGhzZG5z?=
 =?utf-8?B?MVN1dDlzSWJuajM1ekw5dFhoZm5CQjJSVktZSk5MdUFtTU9taUVXK1k4NSt4?=
 =?utf-8?B?b3E4eDVqbVJrSGExVWQvMmQ1bmVSUTMydWozMHZzcTk1UkhCa2xWSEtUUmhi?=
 =?utf-8?B?TmtUVDRmazcwd1lsa2JCZ2VWWitxVXBBdlhBaWVJajJDdnBLNERMRzk4L3JY?=
 =?utf-8?B?UVJNejFEZ3JoMjVZb1RCTlRicy8zdlU0YzhwR3pBelgwdHJCb0lhMVJxVVVW?=
 =?utf-8?B?bUVOUEwwNkE4MXovYzZZTllhaktNbWUrUmpLcjVCdnU0SVowR095amFiaU9M?=
 =?utf-8?B?QmowVnpkRjBKamNHcHRnM3JQSXJidUZBNHNxMG5ZcEluNWlobW9vRnJ1bUs5?=
 =?utf-8?B?enR2bHdIeC84ZVFEWFV4aDJJbkZ1c3BLNmpUWlg1WEJ3cUEyVFRRbzAxdEdH?=
 =?utf-8?B?N2YvOVBub0NoRm95U2thazloOFBkOUJXaVZ0RE53YkdEQ0wzZUxNUzQ5RmlM?=
 =?utf-8?B?bXRrMUk4Wm14czBKbEYvY25tajlNNnBhWjZFc1N4RVNpcWp5OTMySGhoNmJ3?=
 =?utf-8?B?RW0xTG9rL2FHdk9rQUlHd2hyN2dBbFZjRktGSitoNFdidnczaXE3dGR1dlVI?=
 =?utf-8?B?dS9YaGRYa3o4aXcrUXJoS2daMHl6cS9yaTg5ZkVTYlFtUU1xZElsYUpNcm9C?=
 =?utf-8?B?c2YvbEl2L3ZGRzFFdWp5NWs1SmNEQlVHMC91Q2FnclIreEdHOTE5WHY3MHdh?=
 =?utf-8?B?VU50NmEvbzhXVzdjK1E2cVhRKzdBQzNudzhUbTVIUUNRSTYvQVR5T24wd1Np?=
 =?utf-8?B?amdyNGdIb0QyV09vUC9FNTcvbXNHR05HZk0zTGVkMm9VMEMzZlNPVXZMTktU?=
 =?utf-8?B?bkFFMVQ3V1hQUzJoR3Fhc3BEZTdFekE1L2ozVTdFR0MwN014dEh5UG9aT2Fp?=
 =?utf-8?B?UHRoSHRSV0ZMRU80OFJOcTJQWG9PQ2JoNFdic3p5ZUlUL2lpNFZMM1lyRTBO?=
 =?utf-8?Q?lkestsKhOZs8nb14jC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81a16b0d-e461-435c-45e3-08df33510ec6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4283.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 11:05:34.4440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kBITfaIfdXjvW4cng1OLbxKWNA7yhBM4UwVItqCvI7KaaGDcXIMn+I9KArW6ZcxMqPaAcmjXTQmzSqo4pUbG3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7226


On 25/10/2026 11:12, netdev-bot+sashiko@kernel.org wrote:
> [Some people who received this message don't often get email from netdev-bot+sashiko@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 · High: 0 · Medium: 2 · Low: 0 (1)
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>
> - [Medium] The fix leaves the forked Siena driver unfixed.
> - [Medium] The commit message understates the bug it fixes and has an
>   invalid Fixes: tag.
>
> Pre-existing issues:
> - [Low] This problem wasn't introduced by this patch, but the kernel-doc
>   for struct efx_ptp_data describes `@current_adjfreq: Current ppb…
>
> --
>

[...]

>
>> Fixes: ffe9554c17bf ("sfc: Add support for IEEE-1588 PTP")
> Is this hash right? ffe9554c17bf does not resolve to any commit. The commit
> with this subject appears to be 7c236c43b838, which the other patches in
> this series also use:
>
> Fixes: 7c236c43b838 ("sfc: Add support for IEEE-1588 PTP")


This is wrong. Will correct and respin.

pw-bot: cr


