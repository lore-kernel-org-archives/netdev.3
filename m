Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021126.outbound.protection.outlook.com [52.101.62.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08AE368D47;
	Wed, 22 Jul 2026 18:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784746729; cv=fail; b=mnuLldT69zUsKsbB8svgjdn3NFOLQ8X31puGdMLfNj02IULVJ4ZW9zhfc1vp9gvbl03iApHZz/OvninBHAU4HvKv1qkvWRzAmdJBkGmGIWcmRYNLrpht6i4jCWmQ/Eo1jU/TTY9+MVPHAt168QaEhiaqPvNtonnwCB4LooSjwxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784746729; c=relaxed/simple;
	bh=IXwR0NG6p6824bmuMwNn0GIWGGhZecsqRQwyjB+BzEo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bcjd7AP4/cR0qIunubCPM2vNfApITXz5KFgUK1XAdyR06qmDvWm6PyWJTKWh+V20quIYrf4275NEQIAcbhR1EQ5/GYCWcB7H4JMmIl92HyvuvD/0kg6hcHNcw3FZztNeio5Dbx993awdV5rttiIH1A0sYAECm7HFp2lcUst7cpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=bPs54AUx reason="key not found in DNS"; arc=fail smtp.client-ip=52.101.62.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="bPs54AUx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uwl79jCHZLvk0prE85yvwveapkrM99wP/kaG23h0PB9m8NbcCy1G6if2/k3dKp7eUx0eNhI270+GBtlrOr8vVA/lA2uxZd55aQMtPvYpLD3pUo0U9/GyjRTK02IIsdJp1jE+FR3AgrIAEem+SVvxFkyS169UmzGOGr6M9R4t+M6ujriktkVMy6c9KzpdD0VxvgQIvOKjSCJA1foSZeasSH+CjKe5LNiZKgyAKynehr14ZeH+8Fe6UAbZNcKfw0R6w5mkbtYMZW6lkVTyqWlU+/bulg/fMmpxXRbP8onApwtMrEhPNhm4m1MIGf38P7zArrTMb3pWIEIDKtcYVHV/zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JHtKRBw+E0nxLx7Rn9iq5WRvVvVR6MGyI1puvrR1PAo=;
 b=tcKTQB466maOGcDjl+NDkFndwE0YC3fH1F5T2FUTIQbLzMzMmQjFVxM4/CayCJPw9jK9DcWcSLop0dkWePcrhDXOkGjH3F7C3kaWaUqSf6zjCwOuaO5Ut77gS0eQCq2cAOOtiFpE+M0patgKXZckcyvq0QBxiUNEq129RMDgIo2rK3I3Hv8UTkiXD/XEpsoikJmDiVdMTyJBNBuOIF91vEr4vFLeAa2ZKKhH72Aqju6bbKP/mL+ToGI0yEfuhYKkUrN1uqyeeL3Kg+TLrijgxso6lUVidLydSJRxzH3Zj0yjCTn+WRWRmC+x/0rF4sh+VMfFuMD5vLlTGUE+mM62Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JHtKRBw+E0nxLx7Rn9iq5WRvVvVR6MGyI1puvrR1PAo=;
 b=bPs54AUxdx//S/iZ/+yGCorza5Eg/r3qVWIqFbEheUMdWe2ZC7Rk6NuZa7/4Odbi9wx9vMQQgtQ35KaDcE93lKLJJxddnRqxFi1UleWqOoScVc9A2ZkvZpG4OENDr/IY26DR43SiVIdnEBTZTGJd8JjOKvq8gjqhhPlv/U8xaz0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 DS0PR01MB994106.prod.exchangelabs.com (2603:10b6:8:2f2::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.10; Wed, 22 Jul 2026 18:58:42 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9%6]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 18:58:41 +0000
Message-ID: <6f6087a8-2de3-49d7-be85-82497a900556@amperemail.onmicrosoft.com>
Date: Wed, 22 Jul 2026 14:58:40 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v45 7/7] wrap pchan->chan_in_use in READ/WRITE_ONCE
To: Sudeep Holla <sudeep.holla@kernel.org>,
 Adam Young <admiyo@os.amperecomputing.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Huisong Li <lihuisong@huawei.com>
References: <20260721175258.87600-1-admiyo@os.amperecomputing.com>
 <20260721175258.87600-8-admiyo@os.amperecomputing.com>
 <20260722-kickass-porpoise-of-glee-d8cc7d@sudeepholla>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <20260722-kickass-porpoise-of-glee-d8cc7d@sudeepholla>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0PR02CA0013.namprd02.prod.outlook.com
 (2603:10b6:208:530::27) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|DS0PR01MB994106:EE_
X-MS-Office365-Filtering-Correlation-Id: ff62db20-3631-46b7-748f-08dee8233f46
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|10070799003|376014|7416014|1800799024|4143699003|56012099006|11063799006|10067099003|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	9ATFx0worokZPKrWv1iue66MiEJUMlYT81raBaLGYnoPh3s75PwPKs0wkoTLEMVxHaH0BToqzxbQodNIMeoDhOxCngaMT7Dx+LDpgfNvToEOsUHHgFvhBFxI5FQkyTgVsnyMqEngOD0sZm1VkeYanD/vdNnyyQkXdpo4M5z0qeVVy2S3893Oqw0a5tLcJ2MZse7S7TN+xRUucjjVNCzU0rdQsG37QOHSR6+4gbtcQJsFsKYFqwYVqHnFJxvNoz+PAfCHLp9PchYZn23FtsecbuXt8Zi91kEdCgWhqzxooIjDPi2Vjn9Blbyo51rTt+kCM6WRCHOQ/DsC3xah6dLl4ejQ1KxiRSeLYf+zOFKXtKYmzHZgoUZIHHsqZdMY52BrTFSK4fFCPLM03bJzyd4Klut+/GO4PPRTuhnoT4cKjAXhRPDgetPU7ZliBuJJ0Ce+6frfN7ai/uLC7kcIXtAbhFiZ5H27m7Yiowg3kF7RcZdJxgbtYCWa/p/vfpjlLHKm7QaFsbRa2Xl52DYMNftF9iQhNTy3adGZ2tUaK23t+lpiRzodnCup6M3S4fWwF0Nztten+UGSuUcLCtR0YldS2G9xho8xe7Sblb7Fp1T/uCEHaCLs1cTWLf9IemyirOTI/Fr+5DOetVBbgyMeaIuBUODVDfnfeQ4Y9/Mvkw0XjuU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(10070799003)(376014)(7416014)(1800799024)(4143699003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZE9SZ0d2aVBSZTQ1NTYzTGduSktOUklmYXQzVnN6dWorclVubXd3ZnI2bUlC?=
 =?utf-8?B?bUhENUdtandwclgrZW9sdU1BMGZ1Uk1ZNFJJcnEwVVEyS3ZjMk1IZ1d4Y1JV?=
 =?utf-8?B?dTNXeWYvd1NpTzhNaG8zU2xwZXA5bCtnZmtyVjNuc2xCdWRtcWV5dmtzV09M?=
 =?utf-8?B?VnZSUWs1QnBCMEpKQzM4YVNpRE5qbC92WWNXby8waFpMZXVHUXVuc2JhUys1?=
 =?utf-8?B?a2FRYVFhT2YwQWtiQU5ZZXRhdURwOGZQZ2dGVlhFeXowVmhVMVpMdTluSWpH?=
 =?utf-8?B?cFBEOVU5ZGV6M1VZdlRwUW8wMVg0Y2FHRWxvQzBra2lQQlNoNDdvM1B5aDI0?=
 =?utf-8?B?RWVVcThEZUY5WXZOREdUQkVvM3FtRWJGSytOL2cxaDZYVUxlcFppbEMxUkFL?=
 =?utf-8?B?akk3alk0SUtoM2FjdHdVQUlhWFJqdHZFZlhBNWZIanVMVml6YURqTkU3Nm1D?=
 =?utf-8?B?dlpxQkdzb0U0ZjNqZjR4ZlpnMnFUYVB4SHFaMlp1UVZpR25DazVNY2tiQnRH?=
 =?utf-8?B?YkNadDhDVG5xN0t1eWhjYXNRY0RycFd1YkhKUGVWSXNhcDlJdG1YajU2M2VQ?=
 =?utf-8?B?YVdKem81YmVJb0hVRHpWdUZxdUJTTGV5bnVhSE9rc1d1NUNuanNzV1gwT3BL?=
 =?utf-8?B?d253WnA3Y3pvazU3aGtiTlJmTmdZWHlUS3BsczErQ0NYYVBMZXNLTmk4R1Zl?=
 =?utf-8?B?aXQ0U1dwUzE2UTBIa2NjeVl2bnBpVWJhamNGNk5kY291cHZ6cEdPVVJlS0Yz?=
 =?utf-8?B?U2dHNXh3WjJWTy9sUzRHVjEvVXZHYnJFWTBESlI1Slg5MkZuQnZlOE14SkZh?=
 =?utf-8?B?V080YWZMcnNYZjdGRkw2eUY2MVA4MHYrS1JYanlLY3cvMkE4Vk5ZUVRMNTdv?=
 =?utf-8?B?dEhtUEREWVNoUjFhY0RFR1Qwd08rSFZBNlJaK1VFMnhDVFlmQkpjZTZhcWhh?=
 =?utf-8?B?RUd4TC9uM3FqdjJqRWJzUzdxY2xhSGxBTkRwME1OK2sxakFuSG10c0hLOU9z?=
 =?utf-8?B?U05leEFob1pSQXNYZnloZ1NTL3k0SFZCRERMdkVkblFrdStsRGtoZVpUTzlV?=
 =?utf-8?B?VXFTL1ZuR0NXczdGYjF5L3RCM21jNmNtU2M4cjJ5WUdoUzhaWWU0RldtREpF?=
 =?utf-8?B?VEpDMnhwT3llNTd4MlhPKzc3UkRoZ0tkVUt1RDFaeHZWWUtjczhXUnpFYUJY?=
 =?utf-8?B?Y09YcnFaSWJTd2dwSVFDTEZZMzdtVE1xZkdsUkVwdytudkoxUE5IT0tGN3c1?=
 =?utf-8?B?RCs5bmw5bGREcS9QRDBPUXdwaHV4QmNzRENsTGJaZXdjSkdNakFNcytKWjI2?=
 =?utf-8?B?Q0pJanJhci80N01paXZQTnUvdHZscXVmRkZzY0htTmFxeXcvU1NJbzJDakFK?=
 =?utf-8?B?d0ZUek9CMjNac2hpL3NhY2VxUHQxTUJ6aC8vcTJ4YnFieW85b2V4OExHV2Fl?=
 =?utf-8?B?SnpyZ2FYY0g5NzNEeHRDZ1U3ekthM0ZWcEZndDE1QVErRkxNNzR1QnkwR2Rq?=
 =?utf-8?B?SS8rSDdweHE3N2h4UXFlOFp1NWZlZ3dQUlByWkFNdVVsekhyOVJZUnlzSmYy?=
 =?utf-8?B?Yi81TVhEdlRxUy9MVTUzWWQ1bUdaNnE5dWR2UG1FT3dqbkVUenVRL2pYMlBH?=
 =?utf-8?B?MFlFdTYyWjMvQWhEa1VPdU1LcGV6clhKazl2MFhpeUlHKzZOZ2p1dC92dmcz?=
 =?utf-8?B?cmJXN3UzUDBkOFUvOHZYelVvU0dOT1BZNlJOZG92c3lTenFHSUd6ZkF6bzZy?=
 =?utf-8?B?bTNoU200Z1VWbVZYK0orZjJySmRWa3o0MStYVm1laXphV01mQklyZjZhbWs1?=
 =?utf-8?B?UUpnK21ER1NWb0p1aWRGaDhqQ2FWaTJqLy9vOUF0TlVGaDh4enNFb3diZmtF?=
 =?utf-8?B?WjlRMnVQbmszOHlKbnovZUtBUlgxdGZRRno1dk9WU0R2emNCOHNzbUlLcVpF?=
 =?utf-8?B?OFVLTm1JejVmWHc3WlQvMDFCSk9xSVlPa3hUUXk1b1hYRVlMM0l6WSs0a2RQ?=
 =?utf-8?B?N3RRL1JsUU1taTRDcFlVR1E2bkJmMWZlNGV3U0NOK1hiNmJpNDROcFg3TzdL?=
 =?utf-8?B?bjU5blZoS1NPZ3N0bzA4Z0lRZ0ZvcFM0VlJ6aTFPVUcyUTg0aUhYNWhCaW1I?=
 =?utf-8?B?K3ozcEpEOXV3clNNQTQyUDhtTU5adVhVOGowT2drbjhKQ2FPYThLM3h0UC9x?=
 =?utf-8?B?dGs3WDF0M0pGMG00QWU1dU02Q2toeGhvbDV6V3BNV0tUdVQwUlllYkpzcENi?=
 =?utf-8?B?RWJBeWZTY3BQb1NhbldyeXZFWkkrK1NmMENhVTcvcHJvMndzSmxadnBpMitY?=
 =?utf-8?B?NlZnMndXbTRIT3pGNDVFemxuOVFIVmRsdjFqNVdKNC80dnRINmF3YkhUOGhE?=
 =?utf-8?Q?oJl9ccMSCCkzxj0N+7n9wPTvXGmwRd+bIbJJlGEmfxxiI?=
X-MS-Exchange-AntiSpam-MessageData-1:
	89EIzz4Y99M0Dbrw4/ANRr8R0yMSZSHeufpoG5dB17+eqHcBBdaKHHna
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff62db20-3631-46b7-748f-08dee8233f46
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 18:58:41.7614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wj2T8QtD4W51P707t15w/M1MeuRvxPZmBr1jixT1258n5SfEGEYxcszk2TfV+tnUa8dcuRp3OIhtUfIK/Yutb/R9afCHZHmkY0wWn+L15NXbFaPiyeXSpJHikSv1xUtN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR01MB994106


On 7/22/26 04:50, Sudeep Holla wrote:
> On Tue, Jul 21, 2026 at 01:52:56PM -0400, Adam Young wrote:
>> read/write happening from both userspace and Hard IRQ context
>> chan_in_use is used a flag to sychronize access.  Volitile
>> semantics ensure we don't have a reordering that accidentally
>> provide dual access.
>>
> With much better description [1]
>
Excellent.  I will add a tested-by.
