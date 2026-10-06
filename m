Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4873BED46;
	Tue,  6 Oct 2026 21:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791321824; cv=fail; b=W84vLMk/TjCKAnivhhYLEm5Dlfx/ezUU6iQ9oN5mNmpd1ggeIKJ849ZfOkItt9jwDr86fGXC1RP8Q/f7mxUr9SdRdu3FgfKMxBgZRBwxFyyh8r4AsBKUBNyM71MRPASkyp9ZNtq9hwtBmdscpFJgidQc9DN23isu4ZuJZLUwlzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791321824; c=relaxed/simple;
	bh=x11eRhSCMKb42YYZWTwe3S+5b11wD1eLeyqi7vjkNNc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NeWFYmJEFkupe+y4yTTuvCSrXxMuHRCGuj8iyoNLDXDZ/6o7znJiRf0TcnJpB8GdmLgeh13VyICsO6LC5g0ZtM8Ehtem53Of78xoTuoMo3XKy0zMd/wOW641fCayduum5n6vRtUuLYrF9G2DiZdfSL+mN7QnJHcaXLA4NiX8QPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U2ulokxx; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U2ulokxx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791321823; x=1822857823;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=x11eRhSCMKb42YYZWTwe3S+5b11wD1eLeyqi7vjkNNc=;
  b=U2ulokxxOGnRM5Qs6OGJ+tZY2SZX3xZ8rpdkzGxz1I6QnvfUz3xap8p2
   zbxAY9JulwRLwG1LTl3OBGLoOnch/MUwHzulQNRlGhvUu+QM1eGZQ8dx7
   81W2SmxXkCoacSd/L+1Nw6Zr+Gf1/1pHyNPRqp63aYEzAsJWdMwEjzFUh
   hxFmebOzLDO0ET2vy6BsMpOaLPm7shVqUxopnpgsAkc4bBaXdMWR6ibwS
   hbVExiEPWQUfq3k4eaXCVSl6L4V/60jmX3zz3CWzIsXImfL4OdByf1rZu
   2SkgedXyj0wELqyminT6dT5x/Y9t4QAlavLjy6VoTWlDbw/6Xh2gJK42L
   A==;
X-CSE-ConnectionGUID: CKNl3rS0TQmDYp51cugl3Q==
X-CSE-MsgGUID: o/Lzeu5RRPCWznhQjM8Veg==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="65441"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="65441"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 14:23:42 -0700
X-CSE-ConnectionGUID: BmKxdZUWRC+U/RGjkhTyPw==
X-CSE-MsgGUID: 0mTMGRFlRgiGfdGLYorJ5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="306727432"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 14:23:42 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 14:23:40 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 6 Oct 2026 14:23:40 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.28) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 14:23:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pTQESU6vZAGr+XZ1A9dqP5fiAXkRkvQw6eXo3n5sqfpl4lH2ql9r6JBiCmcWc+bIrJUxncmxIND/Lc1sgxysE+LbJdoKr9qmUzDQuMVWXJh69SVMwyViNCDZFl7SGRZjAgXo+hoX3ZFcONLPaUwf2s2wTgEHn8bhalCmNyfdc6eOLWZ9DtNxXVxfbJFO+8sy5v/GI0FIMmM+4B6oB+CC49YaRtQJYlzr0OI654NwybTWJ+uZdVc6Renu2vGRQkCYuhcnZxDm4wWWTuAIXn3eWr33SY6fGeazCbB2vTPDQ3In87sc/FAt1DlNWm2qkKZmdPATbiRvixd3LxW0LiWZhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJYoi217ugASZ1RcCXchpaiO5yb+ThdDCAW/b5AIFso=;
 b=GFdKNnYKMXd4nHfqMnUIgXffsY4BrWg5KBOQR4dY/K3Sd0U4td1GkV/mIPPv8ikqS4kugSUOf7c6DRUPTPqwakXO2yp53iWTgfEqm8kVYNsaZSe+v1eHzRyUIU3JYdy38aJwVscqEgfn9qzxJf/tUiXzDvaiTOt/cER643+81FDJqYjnmHVR1FiuyccTXHD3gtyKelR25pbLuVORt2UDexrIEIwoxtatxW6VlPFgn2+CithPy4X0q9qWViSlHG5utM8nAYPDDFoVLHCKxFd0BKtJ8i5ieCQv31VbepE5a6J7CYgBu7rQ7UlmAG8o4MLSBopSsDt/duGcPHScWMLvoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by SJ2PR11MB8472.namprd11.prod.outlook.com (2603:10b6:a03:574::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Tue, 6 Oct
 2026 21:23:36 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0451.022; Tue, 6 Oct 2026
 21:23:35 +0000
Message-ID: <d69249a8-210f-405d-9cd5-715245fecb8c@intel.com>
Date: Tue, 6 Oct 2026 14:23:33 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 0/1] brief description about the patch and its
To: <taozj888@163.com>, <theo.lebrun@bootlin.com>
CC: Conor Dooley <conor.dooley@microchip.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Haavard Skinnemoen <hskinnemoen@atmel.com>, Jeff Garzik
	<jeff@garzik.org>, "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
References: <20261004133916.559956-1-taozj888@163.com>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <20261004133916.559956-1-taozj888@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P220CA0020.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::25) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|SJ2PR11MB8472:EE_
X-MS-Office365-Filtering-Correlation-Id: 53ce2960-adf0-42ac-ae7e-08df23f01499
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|23010399003|376014|10067099003|56012099006|3023799007|6133799003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: tvs6Usu1mjRJWrX50Tu1ebnNjaT7B/Tp6dAZZ6SHMs2njwyYk37vRDEOwRoAIX37jsytAO6KmFSLdzxHrO/ElutRE2oqJRyST9FX6arlJMP+E2KYxUa1pp4DSI7IEj2JmGBq4TbcvXvon6nNuRObDAbAGr9xLphFYHBMuU7zx7TU4ts4JcX83AoeOkhEttJte6kYZ4Rqjhl1Jljk3LFqvxRktEAud4Fo9vunnZlzSCVpTytKzZi4/WHrD2fhoGjk6qefif7S6ObufjksCNWB2kYksKvf5o73Z5ieMdA19LlcBJpay0Xo+B7byOmeGE6K2/l8VxZUwArMcDiR7P61y1hwlpZOWZnSP2jf4PFT+D/toHhSBoLk7nOKheT2Nu8Tk/3gk2+h7bPnVCdoSw9EQGSXMIqT/G94DMDJayVd8ocMPxJzQ//lTAmDUIwr1jfU2rmpW5xE7w1GuW+4GLn7dw0TpKMa/bUmvLqaV8lwfXo72+p+CyGiJrVb+HnccGw5lFCGYDvL4LBhqvyB9wXp0/GDkzXaaT2x+Db30T93NGYyr0G3AbD8U1zjiqVJ78sgo46EAIc4Rvsx/JsEOwLCHB9DoT9T+Aq4z4VhJTtwwSuh7yWfgML+BGWNjc6Q/HWKkjhFttXTXZY8+CIrecL6JDUb6HCcgpYy8F0ku7Xsr1Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(23010399003)(376014)(10067099003)(56012099006)(3023799007)(6133799003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVF0bnl2bzNtN3FUZ3FFN3ordTVVZVU2Si9wWHJVblVqdDQ5S0VCYU03azlH?=
 =?utf-8?B?YWpJNnVnWE9sNUVwQ2RPbWJKazdNM2NHUDI0ZXVYZkZ1Ykpnd01qZi9BNXhQ?=
 =?utf-8?B?OEQvRGQwY3h4QkEwbXRDa2pWMHZReWlxcWZocDR0TzA1QXNSdkMvejBzU0Jt?=
 =?utf-8?B?aXc1SEFhT2RFZGVFeDNnaEc4QzQ0aGJPTDJ5cGJDNldhRmlRVTV5UEV4eGNp?=
 =?utf-8?B?Y2FpNVhhN1h5dGs5cVlKUGlsdUFMNjUrZjNGUGFwWFNqSnFlVEpBM0g3TWdT?=
 =?utf-8?B?eEtFSHk4UlBWYXdMbjd6dmxxV1BjZ3ZnaXBabnNRUGVteXd4OXA0QURwN21W?=
 =?utf-8?B?d0ZEYkk2cy8wS1BKVDNWMS94blEvT1JlaXJ5TzYrZEZHbVBDSEt6Ny9kSjNU?=
 =?utf-8?B?d2w0UlF5bVdWMEgzTWg0WHVmL2NlM3FPVHYrQzloekZ4VHU2U3drT3UycGNZ?=
 =?utf-8?B?ZzJSN3lKRHJHK1h6TFRweXhicTE4U3NmZ1FCNUVRdCs1ei9kSUgwa3RxSG11?=
 =?utf-8?B?aFRUeFdwSzE4MmRHRnZzeEhnb0pwVVhVb29XcE9XR3BJaTk5WVdPVzN0aXh4?=
 =?utf-8?B?dktIWGpIdVQwb3FIaDM0Vy9Fd0l5NUttN0pJWDIzL3hza3IwOWUzckpPZ21G?=
 =?utf-8?B?WEdpMTdZNVdHWDFOR1NXWkVqcDQrV1V1M3FtRTlmQ0gxakpqOUV3WHcyRnZW?=
 =?utf-8?B?cjBnUHVmYnVqK2NoNVgrOWhGR0FZQTRuRjljUmcvdVJEalc1QmZ4d2E0QXAr?=
 =?utf-8?B?ZWxOR25IZWgrRHcxSlJyZjV1MDUyajduNENSR3VtbnFxa1dxM2RIT082WGda?=
 =?utf-8?B?djdyYVFEN2JiK2cvVk54c2E4eFFHVlhxYWYwQzBDdUZWdTl5V0dmUVlFb2gy?=
 =?utf-8?B?K2hBWDlUTGY4UFJ6ZGZRczYyTUhFaUFxVE00blhvem9YNERJQTN5OXROUm1V?=
 =?utf-8?B?cDIxekdUWkwxMVdWcEEyQTMvVUxTakZlSlZWK1hUQ2pjSWk1MHFHN3E1SG54?=
 =?utf-8?B?Ukp1bUtlNVhPVDRhQ21EZEFDSkxDOElZNU1ISkJidnEwMzArTXdvTEU5czhJ?=
 =?utf-8?B?UlE1ZEZ1NXV0WGNjaWtPVW9RM0ZqWkE2Y2M4SHFZWW9lSkRFSmxhZjloQUxs?=
 =?utf-8?B?bit4ZVArMWgyL2VIeXl6aGNnQTBrZkhEU1paZXJpT05IM0tiSk9ybzlkSTlF?=
 =?utf-8?B?REM5MnkwaWV1ZVU4aWxXREw4KzNBVlR5S3N3MGpqZHovMm1FN24zdWFGdDhp?=
 =?utf-8?B?NklNK3RaMlROLzYrU3k1OHEwejNQZFVOMlZ5cjRKOTNoTCsrUTMrYXF1Qzdt?=
 =?utf-8?B?MXZiaTlZRFFFY1U5MlJMbVlTelRMWmo3dkpRN3lJREd6VEFtd1gxVCtRd0xQ?=
 =?utf-8?B?YTc1MHBWUWR5cDlJMHE4YWVFMmtRZzRoeXFReEljMTFpQ05HclhpUUp1WWJX?=
 =?utf-8?B?V2pWMmJ5QUZBQkRXVHlCTTFhVTA4eHlFaVpoTlp1aEpzaEZ5bHhYVHgwcWFk?=
 =?utf-8?B?SHNaTWJSc1k4QVNxbER1T2d6bDBMWjRnRE8xcWo3ZVljbGQ5bnZlTEdGMWdD?=
 =?utf-8?B?YmpkQTdoZTNFSUhDN2hKWExNZCtXN1dDSU9pTmdoT2FENTFOVTMrR1hBUDBs?=
 =?utf-8?B?eEdTM3dTbUZQRmtOcDRKdHFFTDg1Z29ZR2Noc1FzQ0p1TldGb0wxeTJyY25H?=
 =?utf-8?B?citrVStJNVVseFFFdkk4b2pDVlNJN3laaUFack1waTB5eG9yaG52MnIxMWxT?=
 =?utf-8?B?dzRiOUxSVzVRWncxeTlVKytJdDJreXd6WnRCbHcxSlF4NW9xVmlBTFpZNzhi?=
 =?utf-8?B?WVFSM0ZnZUZpSHRZV1FVcCtqczYybmNXOTlUbkErZVJKd1RRN25wSGdtdlVE?=
 =?utf-8?B?R3RuS2hWMmxySms4a3Y2cmgxcHFtZ1hjYVgwb3ZqUEVpVi9CNkJSV1B4ZzFw?=
 =?utf-8?B?SHBkUDA3UW03aGYwUTJxbnFlVjF5Yy9ROEhkWUZOMERtMEVNcmJMVERjRzl1?=
 =?utf-8?B?YUdxU09GVDJkSHNyaWFHTFhrU2ErZHE4N0t3enN4c0ZidjFLSEpYZm56dTRD?=
 =?utf-8?B?QzU3eU5lNlo2VGtUREdKSFV6SUtOUGJ6S0JyZlVPaGtxZTcveDZ3ZGc1TFVT?=
 =?utf-8?B?aFlRSlp6cmNhYnZQMlBEQjRhYktLb205TTc2citRRlZLTGlldzRFTHRYcTR4?=
 =?utf-8?B?aTlDNFlqbUdDKzQzQUhyOTBuazgwa0Fkck5iREdxR0JRVG50QlV0a0pNb1Vp?=
 =?utf-8?B?SjJTTnJFVk10QTdMMjVjS0psSmg2WWxmVm13WWYvbUFLdTkzNGg3QzgrOTEy?=
 =?utf-8?B?ZXIyT3NMV0VmSHdvMnB1aXpFcDUvb0o4dmU5YXhPS296OVdNdnVjd1V3MWZM?=
 =?utf-8?Q?NR4ZuHFn6ikEDVZw=3D?=
X-Exchange-RoutingPolicyChecked: C3LllC/YU4B3e8e4R2uELXbBR1vOAc8VdqGXH/vLE3+62Z4ZXJr/gPzftplYgMOnrSw7NbktnWp4D74KAcZPiJWjIukaB19lXUr0RjbMr2iD7cD5Uwa+7DpcJcRCnqivOxzYXZW9uF4q3Ks5hrvovg9GbDkbCMvZJeYfMxLm7Uw7o+DVrRFCcfvPikUR7ZX0R1JyGAlwC9PJ1WB3ZfXmaT3fXTPiUbFhmH+ZiY6gBbvpjrjog8XsCqBstTfM+dVYZmznk2H3NRQgEtTS8Bw6W3tlDaPvM48n9kMORtw17mXBv3BeUkRqejBwF1jyvrna4xUiTy3FyPsfAF8h7FpE9A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 53ce2960-adf0-42ac-ae7e-08df23f01499
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 21:23:35.8207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7COU9HudeBnIeTx8qV5i6C2n3e4AG/pFnxF846E3LC2/Z8QydsAr05bHd2FdkZQqi+01h7EFaT4Kn542R9UDdxoZs/oOwv7UYwvzLQ5N7RQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8472
X-OriginatorOrg: intel.com

On 10/4/2026 6:39 AM, taozj888@163.com wrote:
> From: taozijin <taozj888@163.com>
> 
> 
> This patch is titled as:
>   net: macb: rate limit netdev error info print in the data path
> 
> Changes since v1:
> 
> v3: 
> - add this change log since v2 missing it
> - drop the blank line between the assignment sentence and the commit
>   info
> 
> v2:
> 
> - update the commit message with the reason why the unlimit prints would
>   bother/delay booting process
> - update the commit message with the Fix commit id provided which is
>   suggested by Théo Lebrun<theo.lebrun@bootlin.com>
> - update the commit message with what packet type would trigger the
>   error printings more easily.
> 
> v1:
> 
> - initial commit
> 

For single patches, it is typical to send this as part of the same
message below your commit message with '---'.

To make that easier to handle, if you use git format-patch and git
send-email you can use --annotate with git send-email to insert the
contents before sending the email. If you use b4, it will automatically
generate the correct format from its cover letter and the individual patch.

If you do send a standalone cover letter, the subject would be better as
just repeating the subject for the individual patch.

I don't recall if netdev has any enforced or encoded policy here, so
this is just a comment to hopefully help ease future contributions.

Thanks,
Jake

> Best Regards,
> 
> Zijin Tao
>  drivers/net/ethernet/cadence/macb_main.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 

