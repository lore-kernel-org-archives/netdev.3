Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793956168;
	b=dJnwBh8PidvHTWAw+WW9qpYzq0py4ZwwPvMM8FtE2DcspIofRgvp9Si1FCxdlpLCy4us
	 geTomc1fIqgMj6x06BlM2ifSn1HZLx64CFKYKp/05Y6LU2F1IpvqqbTy7qFpeGfs1tMwb
	 odTrSQlKdSqgqiPoZkeAGf8syuiCb1G4geJrqSdiE8SeJHO6ynQro+oCwEoODgoDLj9lT
	 LUd+/RoMwAHdkeRHeE7KkSWRdUtJskjfOr2i88Qp7pMU5CWQ+jPUWcuWoEazBfelwjCLX
	 /Yc8dK6rTwXugjPxefOoBOI2BDVn6iKrE1Dir+eiGQbLdhbyjHBdR+XVV7Iy0c0D//g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793956168;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	bh=dFFIiNmGYYyD7yqXa86boXvzgKlZN2wQUf3Bcq9EGM4=;
	b=GgNBT7dngL1zHzYdE78khZOsUS2uBzHaDnsapzeiXH+83gsZbPpopMTMHINk6yuRhQLv
	 TvuWz4jQ8GzU9UpJPDBcXF8P4T47Fnz37vev+UtOZf/aYx1wxdWC9N4s5axeVOBt/X/0s
	 Y/i9Xe8dGgU962lj9verVdT83q97nvMGHnapFNYoOaa35MxKFVpV9OXYQB611IpqNlRgj
	 sMzbSlyJnVyFpEIt85gn2RmmQRQCyRESlujIQdPm/dzfiY4NbA8/g1DdtjmGwUTomXFMu
	 N8rFzLy+N93Ul0qeiBENrOQ+Eoe+FCXXA+kuaPEcYoSw3kN7mwexiccmyeeGEYUecAg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=qmlBm3NI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.28
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013028.outbound.protection.outlook.com [40.107.201.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9329606A326;
	Fri,  6 Nov 2026 09:09:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9329606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=qmlBm3NI
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NhO03tItUKuOWdypDAEu1CAQzyQGNqcFIIST8Bfc/u5Rqwt8GJd0bhIicgtRC3MRMCtp2nbF5xXuaMc1LUk+NivqqT/1pCse9eFnWrYG/jAVxezzme39pmuBCr2QhzF2cMl2Y7Z1mVw+iYK/RX5frqGuOZztzgN0RNpA+DPDJHs0/UFAwA7dJqYcE2G9LGcL3lQkv+voHw44ncTv4lRzqOFxnUixVGgbrffGpv+1cqSJZBJM5bD0KtXy40oeXPzBnF+W/XjsEXg+Av+qYpyHtBIbWyKF+xla6aoheNhM8mUynGTmnuNmjOTpkmoBFyIRlcGc7nvdM8DCd1le+ZRakg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dFFIiNmGYYyD7yqXa86boXvzgKlZN2wQUf3Bcq9EGM4=;
 b=XQ6xJpaOIA087dcw05t9ngQfPK0aNhhElRgaMBM2Vzo3JnGHRLrrXA++DWuf0asTF3N/NSxjr7CqCEcLvFnj5IMwQSupRfyvqDFLIbPP2G/CzE/GVJQ38eua367MVjVCKGdxXcBT3GNjwewFKZBhtYvkjaMb8qnn9TxbRd5RvBe5YMgG8FdbeYs4smD4SIxxn9OAEjGwZvtTqQA9FqHMUvE8aAhas6IFovsndXJPWhWOBaz7QWvoxrr9HnveedYjIIerUv3E8jnfQt1kNPkJ4eteEHcqcRoqPOdGl7eGDd1/sNQYtHD7NNG6YcJTHvTPrStnSbs9nkkkCuLvW10idw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dFFIiNmGYYyD7yqXa86boXvzgKlZN2wQUf3Bcq9EGM4=;
 b=qmlBm3NInqjHDNcmNqv4gvpPZ8u1vI9pjsj859ftiyVc30COIxGFrf3GnptFYB+N+oqdf/CBL3VmlbaA4QTLbTd/iSfBJi0ybk/z56oNalYDTzFLvAP2qN22WS9gVMwbg/T+Wc4rKvcXORNMpfkN2G4OAwvHnJ8RoxDcreLSanE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by LV3PR12MB9409.namprd12.prod.outlook.com (2603:10b6:408:21d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 09:09:24 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0592.010; Fri, 6 Nov 2026
 09:09:24 +0000
Message-ID: <bb85271a-4600-453e-8853-f12aeaa064bc@amd.com>
Date: Fri, 6 Nov 2026 10:09:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/5] arm64: dts: xilinx: drop unused
 #phy-cells from the DP83867 nodes
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Eric Dumazet <edumazet@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20261106-v7-2-topic-dp83867-v3-0-45e1d3adf1bf@pengutronix.de>
 <20261106-v7-2-topic-dp83867-v3-1-45e1d3adf1bf@pengutronix.de>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20261106-v7-2-topic-dp83867-v3-1-45e1d3adf1bf@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::16) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
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
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|LV3PR12MB9409:EE_
X-MS-Office365-Filtering-Correlation-Id: de3c068e-d408-4829-76f1-08df3be5a6c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|23010399003|1800799024|10067099003|18002099003|22082099003|921020|56012099006|4143699003|261021123027099003|11063799006|261022105027099003|261028144727099003|261009223027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	3g02f4OZoAk4kwQj+bY9VeBFm5XE71PP+NiR4X1bhB+fV/lADh4QoxoQQ/RayQOrnUBr0GxnOsjmSlQ3WoYKeBttgfzjLG/Ot5qv4bP1zhB+rJErrbaCFAT5rC2S2xAM7Fa/dBaZ7cdsiQfNKlSHf1NZd7U8GWL+rQqKhBSLTA1H3DL24X5pNSci30O9MUqkNZ0vedzdJhjIriC/WEiqCuS/g1G4OSdwsqRyXF5meyIRizfThsOpsB7knelS0keQyf+GgzplCzIM9uNAZETDmAZAb3WnNvFpW3CptVwpsLeabJ0u2BtGgwoc37geWUPkRg78PgSExAqUUU0LW1mqyG9enq78ymwT+SwvSka8HiQQ/UkMhmLUmImoBmMdpIWAz1y1yuIeOBW4FnK0kvF0fc4r2uhQnoqY1ROX0p4bLF+7Saae9VuBJ3QfwM0K/MlCY0VnKTcZeaTifGd6O0fk+uDTPa/h4hO5ZSPqci/V1W8yt/8cGY+34qwY+z1xEzmUxFLJZ//X9GmHmNNg6ZwJN8MO1RxrRy5Ztl76TS2g2mfo9oLUj0jUaZxG4JluenLz1m5hqFqZACNlxWmWXarigOd8d9KAXgd32dTiAKco/KOpa+e9UQhaVajPg4ESftOfcWuG8CkF7B4aluGCeIb3MlhXxPHNkbWbAX8R0FQW6G/0DE6+K2OVXPXeHlVPwyIoqCWocaDmIvG0QnpmdtVqwA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV5PR12MB9779.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(10067099003)(18002099003)(22082099003)(921020)(56012099006)(4143699003)(261021123027099003)(11063799006)(261022105027099003)(261028144727099003)(261009223027099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MkNHMnNKcVcxSncxS1MrcjdpR2ZicllYUG1XMGdlTEZXeERncklQODdLSGNM?=
 =?utf-8?B?RGo4ZHpkWlBBTEcvVnZVdmtEcm1CbVNnWkw0aERzdW1JcldwTlErekJMT21W?=
 =?utf-8?B?c1doMjZRM0pKQXBYWXkvZzhBVU5JRUcxMlowaUo4WHVIWmUvMEE2NDFma2Rz?=
 =?utf-8?B?Q3FDN2o4TStyZjJOQmpNZGtlOXpHSmgydEdhOFNMRHlqM1FEbEtpMmh0SUlp?=
 =?utf-8?B?ZnhSRndtbUZUbG83bElPUnJHMjQwMGFXV2lndVFueC96dEp1MldBSW1pY3My?=
 =?utf-8?B?U3pqeXI5bEgrRUdFdUhlb09BTERiVmFsa1llUlBEL3VqQjZaSGFmaGlWa1NV?=
 =?utf-8?B?RHplL2lDdWw1QnNDMUdCOU8yeEJ3Yi9QektXMVFYdWxTaGtFN2NTMHdMRm1V?=
 =?utf-8?B?US9IZTdoYVlsTzkrUVJYOG1kZnhHdHpkK3BvRCtaTjZ5Rm9SdlZtTlo4cGc4?=
 =?utf-8?B?Yno2VDJDb2JsWWxsZUZDU0RPYVFSYkliamF1RjBueVYvNGpyQUVNL2dKeUZJ?=
 =?utf-8?B?R1NIKzJYUStqOWtPTlFlb2dkQkoxSUN6MGFpcGNpaUYxbk5wQzBxVEQ3dzBq?=
 =?utf-8?B?WFdJNUtFOFFPeEMrcjloSjFnMmJzNnBVTnZULzJSeS9KSDFrSGp2WU1wbnJs?=
 =?utf-8?B?Z1BDVnVld1dINXdtQlVJWDFJZFJISEVKZDk1S202c3U0bEkrNWE2TkgwSG05?=
 =?utf-8?B?ZjlTVzZ1eEJCOTcwK0xQTUdoRmNkSkltb24vN0wra0ZMRXpjdkZmejBMUzlR?=
 =?utf-8?B?SWtLSjgzSGhETUJYWllCdFZQdFMrSm54SXZaakd6TUszbCszRmoxZTZYYTFz?=
 =?utf-8?B?ODVQVlJyb2F1ZjNGbGoyOWpRdzNQT2J1L0lNSDFlbHdEZjVHRzFOeUtHVC92?=
 =?utf-8?B?aXRwWjdjUUJkUy9oNGhoOUxmUnJrNW9TZ1B2MWlCcHhPaE94c25ubW53NXhk?=
 =?utf-8?B?am1XUVNtWkQ3ZGNhd25rMDdCWDhFeEN5MXhZeXFYSi9jOTJCMm5Qb2NCUndr?=
 =?utf-8?B?TCtCdEZrb1pMOXhEM1NURWY4b0pvcW5rRWdIOHJ2T0lMQ3VEWG5sQWxUQURN?=
 =?utf-8?B?MnlrcUp1bTBjZk9BS0o5TXFtRHVlOTFVVER6Sm5XdkJ4dVRzR2pnbFF3emoy?=
 =?utf-8?B?Rmsxby9ZOUFCcmMyYTc1TkhkVi9nWHZteVBBckpuLzE3Z2dORmJNUEd4NjI1?=
 =?utf-8?B?S1hic1JQZ3RVMkhaRGUwVmZCUi9nTHl3RlNnUjcwM0pNaW1mdlFIUWh4LzhG?=
 =?utf-8?B?ZFVQb1dPV3FzcGpNQjFhc2lyYjROZncyNmxNZmhQaWhhUlY0Y0E5N3JXc3A0?=
 =?utf-8?B?VXF0V0RabzY5SEU3SzNPUEltT3ViZC93OXVrRmMvbW5MV3p2MGRZZjcxeDc0?=
 =?utf-8?B?aXF5WXZKcHRLWmJGVUhnaW5sTGN5cDJndW1ZNlhZa08vS2lZUmhtV0w0U2lW?=
 =?utf-8?B?RVZPZ3lkc2ljV010WnFBYXltYzFhTmxhVVNtRk5FdnVZMVFmRVd5VXg0Nlh2?=
 =?utf-8?B?a0JlUXgra0NYKy9QNHE3cDJDclhnRXlHeSt5REtwNUxwaTlmU1Ntc2FOb2Ra?=
 =?utf-8?B?QVlhenRUQ1NtYlFid1F1cWF3U1ZuMWY3MnROS2M3L2ZxWEpVQWRWMjJvNmUw?=
 =?utf-8?B?SDZETnRzNHRqck51bWtjNEYwWHNDbXMwc0lkdDhvOUEwY0QyY2VNNFRVSXJ2?=
 =?utf-8?B?aTQ4NWE0NzBwY3YyRTdJeGxtb3hUUlZhd1lCQjVFS3dTNFg2dUdaMDZ1SStX?=
 =?utf-8?B?TnZmUjJjMEN1T2pDMkFtTzI5aTRtckhCNGNQcEpyek15VTBhQ21UNjNQZXJV?=
 =?utf-8?B?NTJHcTZFakIvcHJIUUxQQ1M3aWNUS0VsZFliQWs3VEpBVHY0VHAvcTEzSzYz?=
 =?utf-8?B?bFo1ckJjeElBSjRWUmwvdWRBanBBN0hyQlZGVGNWUWFFVTFRSkdRWkdBMU5t?=
 =?utf-8?B?K1pGUWZqZ3BaT0xwRE1UZUVGL0tsOElkNFBJN2o0bXlGZWZZK3F0K2FUclZ6?=
 =?utf-8?B?Z3BFai9JcFk4NDl6Y0JHVjB3UEQ5ZUVXUnNZZHg3NWIrbkVqMVI1VzcwL3da?=
 =?utf-8?B?VFYwdlRrU3g4cTU3dEFZeUpLZ1FPOFdFc3YxbWtKSlE5ZkF1UUNBaUJQMHFv?=
 =?utf-8?B?WWNtSXdVd2l6TkcwS0lCbTg4SkF0TmRTQXpFZnByNzQza2E2RnRjbEZjMzJa?=
 =?utf-8?B?TEZPamZzVkRrNThBWWUwRlZlZzAyRWVVbHZrQVB1Q09rbHVUcnowa0ZKV0NX?=
 =?utf-8?B?OWFWQWlaY3c4Um1zWHJ0cDR1MEY0K2t5T1BOL1o2NEhreGM0aHVUejE2dVBn?=
 =?utf-8?B?OWVSVURidWlTWi9mWjgrWTltTkRwZkVSUjZlQWtsQVAzdWVKZUp1UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de3c068e-d408-4829-76f1-08df3be5a6c7
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 09:09:24.2127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JQ8W68DKZrFUpKdb7OHAPI+Q1qyaopKteg1vWyBco7P0SW5cBHV8RF2W3+eirdYb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9409



On 11/6/26 08:47, Steffen Trumtrar wrote:
> The DP83867 ethernet PHY nodes have a #phy-cells property, but no node
> refers to them with a phys property; the MACs use phy-handle, which
> takes no arguments. #phy-cells belongs to generic PHY providers.
> 
> Drop it, so the nodes validate against the ti,dp83867 binding once it
> is applied to them.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---
>   arch/arm64/boot/dts/xilinx/zynqmp-sck-kr-g-revA.dtso | 2 --
>   arch/arm64/boot/dts/xilinx/zynqmp-sck-kr-g-revB.dtso | 2 --
>   arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso | 1 -
>   arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso | 1 -
>   arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts    | 1 -
>   arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts    | 1 -
>   arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts    | 1 -
>   arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts    | 1 -
>   arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts    | 1 -
>   arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts    | 1 -
>   10 files changed, 12 deletions(-)
Reviewed-by: Michal Simek <michal.simek@amd.com>

If you want me to take it via my tree please send it separately.

Thanks,
Michal
