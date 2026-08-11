Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012033.outbound.protection.outlook.com [40.93.195.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E46D43B6E4;
	Tue, 11 Aug 2026 10:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786443464; cv=fail; b=guRuS64E8I/+/Zmd5NoGVn8iH67JrjnZN+mFZfd1O2+tEr6ieKabFYx5Y9DvKk7bKoKdRiPkch5RMma7n2q7AmMMblaylOhC8Lm/2ciB1iTgg8s4/byVXsKQO0wYlPMkaIJnCA9NptHulVhI1DO0ltpsrIVfIV7bqPOQoFSj+Lo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786443464; c=relaxed/simple;
	bh=tMI6P2HHUvGyRvikRLpiyoXVMHrisl1d/UNYpel4sQ8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=egE0/scC4M0zIw0GlDVjcWjPeNKya5kJ5ZycafBSmwMkaCVR7D4Ok8k6kAcEoDRassDy1QXuJJw0jAQecudKwTnwp1lCgo2959JsqD0KOpnCBJOyZt/gCh5d3UvONmtvOAHydvojJ19FSnIIN0hnQ2xLfyQ4oM5Fgze9xO6Vy0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DG6xRfF0; arc=fail smtp.client-ip=40.93.195.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DG6xRfF0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Js+F+dF6nQP8cg97cvP5psjkRhkOO8W2gvyQkGQ1cKjBWSegitUT2F5Z09xDVX2vu5jqIytWUxEs/E1aqyAHSbHzUtAh4iDcx6Mt+nvk25wlnq4uuJ5SRoVcRIxU+AX/WFyA3CSQt2ZfT84dchVUuKxtIM2UZvqqZJslK32FugQoBOhBOlZmeveejgavbiFZ9k7DuLZgHxwbKlf/vv77MQT4wFIUwgpdnRrS5nIU5oQ52W0bI085B1j/hBraQ+hrFuVH/I5YGz2W1xqn/vD30wDtLtrRFW6GAPTlAhQ//nic0KJj38/xgxALFcoKtHaSP1pMh8zpzyLWpzRGkvTGBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bta6qV3nzUFBrdz6ev0SHZIhWwVe/vJUojxwrrYoi+s=;
 b=D4pwzaKtmxGWGas+q9n++zJBHvSOkQXxH58SbpwYhXIFuw9zJQd7KcELLjGGDwBB8JGvfeZxJnWZBPTsfnnvHWUMb4Fle7hoqTZit53fKb5GBxRY9Zm9WRN6aMazY0/hsEGdn1Lse1jPeQy2xJ1NZLCzljJGNXbxK2aWMAZ7nwB3hLSgT7+lJIFxxnOLBfwzwRULUkERliTBo9ySufY5IVNpFTpoFpCseCekYhIlURxVjZm7khiU93PPg4UfaPBPvMim4oUi5xk1f0/YI92VLyWEx/g9MLBJCnNKqfc/zNRc7a/2iBJsD+YObbabTa1xlCUAcD85B54NxedKoe6ihA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bta6qV3nzUFBrdz6ev0SHZIhWwVe/vJUojxwrrYoi+s=;
 b=DG6xRfF0USzwu9hr8XIdYn/P1aUq8SOZr593CXsg/lUP70LLiXFCyUGChZfflEXylla1K4qhhGNxJOFpe5FlCpD+ASokLHeC8ayyOfaXg6Vygudl+juZi53z89nTBk5VWbbmy/yJM2Ap4eu5ogK8srx+pvxLkGX93yDX1mJ2Tv4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8953.namprd12.prod.outlook.com (2603:10b6:a03:544::14)
 by SJ5PPF6785369A4.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::997) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 10:17:32 +0000
Received: from SJ2PR12MB8953.namprd12.prod.outlook.com
 ([fe80::f3b5:fc98:8973:5c0b]) by SJ2PR12MB8953.namprd12.prod.outlook.com
 ([fe80::f3b5:fc98:8973:5c0b%4]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 10:17:30 +0000
Message-ID: <4c719349-132b-4dcd-b332-a84d3a92b7df@amd.com>
Date: Tue, 11 Aug 2026 15:47:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: macb: configure ENST registers for all queues
To: Jakub Kicinski <kuba@kernel.org>, vineeth.karumanchi@amd.com
Cc: theo.lebrun@bootlin.com, conor.dooley@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, git@amd.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260805044204.272989-1-vineeth.karumanchi@amd.com>
 <20260806162557.2762166-1-kuba@kernel.org>
 <20260810181813.0d1fe0f6@kernel.org>
Content-Language: en-US
From: "Karumanchi, Vineeth" <vineeth@amd.com>
In-Reply-To: <20260810181813.0d1fe0f6@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0026.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:17a::9) To SJ2PR12MB8953.namprd12.prod.outlook.com
 (2603:10b6:a03:544::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8953:EE_|SJ5PPF6785369A4:EE_
X-MS-Office365-Filtering-Correlation-Id: 19cc2ce8-f9f5-4bdc-246d-08def791c053
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|4143699003|5023799004|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	IV/GesYs17OEpDoqLIgdOAkM0gVV9PkYA6KK3Oj3Z83E1/qX7cbr8meYnDirgha7+m9UZhYDSJIDuEtpgcx6ZmP4QsjNwRj46fpAtQI2W3xVhcN0HyPnFkmW9NMPyUQW5TiVLLn1hVj2mBRykigPWN3SM+5HKU9XkQjm9DDdJJW4ouPQ4aoed9aSpHAw0pLCfOmAtA/2MZzSlNHUug0pnfNjWXsza3Uj3vArXuf8HgG0u+fRhalflWYVwYgHP/6aSpFdBchw2iZdNpScFpy/iBrOR1BuOCbeQjF2bxd0u12/T8Mbccmh8DLNRXAi8XelypfRDCLNAkKgodwFAXeqZW+ZFR0Ro6nb25OR3P25fgSbnzDSVTqxDX3SWsskVKuUwZFQifJB7yLfWwVRoOjjKaX9rp++b+agAozDQi5Rdb+wnGFk4aw02KX+5YYOwcalC5G4KQwJ9p9AVjwQhxh8ac8wEwpO+2OMcjs7KLfAUpoF7LngHjDdu2m2Quoatvh62nVHz4Ce5J+PBg1jpH7lB9iBlhXyZ/psf6oCCaoLJFQ8OAa1Jb2aZD18rosUmm4R/OHkpd+vEnLjsF6V1/ggJPT61XUWN8F1Q/gTkeyqOyJ59dbGm4H/m38Y2Tb9VCO2AAiyoDZFSH0+8WApNZFILOIGKXuHZvVLBRWQvE1/44g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(4143699003)(5023799004)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MytlYm5Kd2FwMkRtTGw1U2wzdDZteHJCSy95UHpGWmxUMjNkYmFLemlSc2ty?=
 =?utf-8?B?UERKZG9kTWxreEhMdWFmNlFmbDdNaFE3MUZKa3hzb3FyTDAwZTFYQTlQU0Vj?=
 =?utf-8?B?aW1wTTdQakF4OGRzd24zSFdTN25DTEVuZVVuMkpaVXNTZHdDR0VuSEtDVksz?=
 =?utf-8?B?VWlBQStvaERGWGsxZFJXNW1BQ3RNVGdWRGJrUWR4L0RnS1Y3bVBmNHhBallI?=
 =?utf-8?B?SG5GRVhPWnJQZXd3N21hSkgyc25tUDJRVXVKbjAzQktFelBkdWt2eUlqMU5S?=
 =?utf-8?B?S2lxQXlLakxFRitDb1ovZURIcThvRklQYm9jbURZTlVjenkrZ0dhQTNHQ05U?=
 =?utf-8?B?QkdWWXFCNkx2b0Zxa2Q4OFZ3UURvV3F1YW0xR3h3WG14czh6YzBuSU5tWCtB?=
 =?utf-8?B?dXVRajl4NC8vcVVHSGVYbXFFTko1dy9yZE9QWWJCMXZIWk1nOWpTMU56c0R4?=
 =?utf-8?B?WVdSTGJ0OENYNjVYZzNRdGpZNG45dXVZQXBFLy8rc3pEOHVlZlVFRkpjOUVT?=
 =?utf-8?B?YkdjWUhSMHNRZVVzMm1jQ2dUaDc0Y0o5VGpBU0RXTlRJY3RkVllMSWxVL3I5?=
 =?utf-8?B?VXJlSVV0bC9tcWl6KzJaN29GMjdoZ2dnOFptVlVXNGJ1MjhSb2UrT2dKbVdx?=
 =?utf-8?B?dkR5U3VXdFZuc09NY0VRUWdzaWJWdTRPWjVBSk50MXNCZnRvOWg3Wm1ja0xq?=
 =?utf-8?B?QlZIb1N3RWVrZG44YWJhdkFaZTk2NXhMY04rRjJhS0VFS0xhQ0EwMlJaaGU4?=
 =?utf-8?B?SnpxVzNIemVibjB0VVp1SkpGbnVHa0toY3lkM3JONHJFNzByTXNRNWtucFpE?=
 =?utf-8?B?WnA3dUtVamQvV25MN0NodDZJSnd4cVNrRmZUWHJKWkJVc1RsSWhRSFMvY0hp?=
 =?utf-8?B?OHhOa2JjcHFURGRvM0xlZGR6NlNmZGFPN2U4aEdXNnh6S28rN24wR1VWeWRX?=
 =?utf-8?B?VWtKRmJyM1c1djNhZUxyM0YwTEphVExqMXpReThRQ3F6cm5iZFl3L0RVZGU5?=
 =?utf-8?B?a3M5a25rdWg3V2ozRTNDMFpqN1Z4enF0OEJWcjdPamMyeTVaakhHdUNCK3Vo?=
 =?utf-8?B?WFEyL1ZVZi80MUp0OWlKa2E0bDBXd0pVeHE1NUkxUXU0Yk1FSXozUFBWL09o?=
 =?utf-8?B?ZEcreWRhMFd0VEZDZTJ4SDArZkt0U1pOQjdDQjlsekhRRTJQTEZJQ0xGNnNm?=
 =?utf-8?B?OFFJTzZmNUVSbjJRS0JGZXc4d3o1VmlWRXBNVDF3TU9PVnZwMnNQTnNmeVRI?=
 =?utf-8?B?aGJUNzlobExJMEtCYytoUmhJYzE4OXJaZkJQOGVNS0k0andKZG9tMVBSZkt1?=
 =?utf-8?B?RW8xS0FwU1BFTEdIZk1seUI5VDY4cnlsWW0xYjN6bmR0NGlnUFJQY2RLWklP?=
 =?utf-8?B?VUdxMXFsTTFsenJpUXBkR2NSNlR6YmthVjVpR0podFhwaEpDdDJ2UWFRY1Vv?=
 =?utf-8?B?R25rSXZJbzRueW5vV2loSHk2ay9OeXVnRDR1clpPVEJoQXdoSHh2WW1BOFl3?=
 =?utf-8?B?djVFdWtvWW1hZWUxVkVPVkRmWURxNGFlVlNvNGQ5QzJoVXBhaFNhejAzUURt?=
 =?utf-8?B?TW9vOG5HclRQMDFwdHg2RGhCK1VTaEdQSHhPZVJUaTFHc1RQdjM3UkxoMFI0?=
 =?utf-8?B?Umd2VE1ncXNRdEt1NDlTR0dSa1YyeXYyV1RMRzFVTXp6NWFJZHNneUZybmgx?=
 =?utf-8?B?UUwvRlRBZnFHQjFMOUhOV0VreHVOcUY3QVA5WXFwMTVxN2gvaDNKYkVpSk94?=
 =?utf-8?B?a1IyaGkwUy9oNTZRWnR1Y2NCUzYvVFpKY0xjQzdoV05wdHJsSURxUmpLTVZw?=
 =?utf-8?B?c1l3VHdEaXhGK29pVURNMnNyeWFkdGJiNmp1bzU2ZG8zaERsaUora1VqS0pT?=
 =?utf-8?B?d203RmZweUdyQXpqUzFGbUlBQ2dSZ2M2T3lpdGl2QTNQUk5WdzZMb1gyQkZO?=
 =?utf-8?B?UVcyRjJORUo2aW8rMDAvY3IzU1d3OFFRSE83QWhCN1Z0NXQvMlc5ZEZMN2po?=
 =?utf-8?B?Z3NOQkx5RmNmSUpsWFJRaTEzVWx1alRQZ2NDcmhxM2R3TWN1V1Z2d1U1Tzh0?=
 =?utf-8?B?RlF5WDVKRGk5ZE1mVVg1YmZhZGd4NUpvbmJEbGUxL0xVSVd5WXFSVk8ySGlt?=
 =?utf-8?B?RUNWMnBhRkRyWEdQeUFwd2tCelJ4S3dWallBcWttL0J1N0NQa3JZTk1scHBx?=
 =?utf-8?B?WWx0eEFnTGpzcms3NkFIcDN1aUZtMnJHdGhIenF1REZCVDYxclFxZU1UeVBE?=
 =?utf-8?B?OWpNOXFqbUp3N1VUN0JWQmlxb3d1WGJLVXhqZjQyRCtvQjBoWDJNcE53Uk9u?=
 =?utf-8?B?RVdaVDRLY2E1SkhrQjZOdGlZbE5xc0djQzAxd1hjTnJBdWloNXZZQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19cc2ce8-f9f5-4bdc-246d-08def791c053
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 10:17:30.4033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qWkGxsknbK0jLHaexbTaGDmxTRryBeMOnZD7XnpCIjkaqHLe7EHwIY9gbL7EGfWK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF6785369A4

Hi Jakub,

On 8/11/2026 6:48 AM, Jakub Kicinski wrote:
> On Thu,  6 Aug 2026 09:25:57 -0700 Jakub Kicinski wrote:
>> This is an AI-generated review of your patch. The human sending this
>> email says "What's the expectation for the other queues?"
>               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> Highlighting this (human) question in case it was missed in the wall 
> of (AI) text.

Sorry, I missed your comment.

I verified the behavior both with and without this patch. In both cases,
the other queues remain disabled, and all traffic is transmitted only
through the ENST enabled queues. which is the expected behavior.

Thanks,
-- 
🙏 Vineeth

