Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010046.outbound.protection.outlook.com [52.101.56.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4594B3C90;
	Fri, 16 Oct 2026 18:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792176501; cv=fail; b=bp1cpsGcYDkL/HQwDgBapLiemFA2gth41tFkv1ya5aikFsLfwfVkdTQalA4rj8QTlV19Kj6BYRKa0NvlBdoadNLGpI7ENpLiNLILEHwi1YCBpvTy2jVvFQcm7pu0hn0MlqdMPznsF8tnPu7FGcN9eMX2oGjwaTqI2KPLtonemYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792176501; c=relaxed/simple;
	bh=DsJqrQH4NpgEcPYgR88CaPL5E6189+icLpW0ncGRZT8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ipDKRiyGEvpZf6Bvt9DuoF78Edb1eIKgeqYPVFnbJhSizA4I+S9bpjVm1cSjwX7HjUY+sStah4puT5vCtt2z9TicxHc0E2ODesrcnYKSMUWGVCn3cP9UowATyzFrXfTSJR0dQ/JcJ3WivJoSRmU0bt+bfaiRg8EFigBrFu1O7Bo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FF8PUHqp; arc=fail smtp.client-ip=52.101.56.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FF8PUHqp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bN3NmXGAR5ExsiA3bt2euvz4LW5ygFrqK4SU2KFgu6WvC8BW30gIX/TAJNAKPrOUHvSZGe6KAw1Xo2BHUfoMZP91cHcC00j30DRzT8Zb/fA9c4mRQXkMnYJwLf+LKdjbSSjpVSwPn2TX01GZQ1sMz18eo0nQASlRy6KgV4W0alBnpk8lkXxrzOCSk402zVDNvBfiIi33eq8TQxnX4UbGdMWE2JnDliYM5nqyYvCbdx4D3uoi8PvvbJiWmqdLhfsdvK8AbAsUImExqq1kVHo9McQXr1iVwDXdZDOC4BKOQdV7//AGlvTfADhVLq1ToFfPAzTeBWYVXvuA6mN/CwzbPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SRYmd4DXh17peRDfizZxXJ8LPGd0hWtGAFftYZEH1E0=;
 b=Fza03TXGMvKYDM+0hgkSR0FrthYnQGOyEz9Eqvm2JYeq1/4u19xL0eZQAc/LqxVlFgRDsGhTrJOO0ACnmmCEcRPQO0a6cbEXny7cM1lQPdQE1Xg6UKqsB/nSLCuTmWirmyyEgXmaAsYpI+p9tGIqj7JNKV0rravqvujMznm+3fUhNKvINhmZb0b+XN7kJCe0/Zsq+Il+56q4mjmcvG9RmdU7SBNt5l2P3wiGKqq5GKC7iz+NZl9CsWZc41nsW+ZX462tzu9J7Q8CftnCg58fgTibXTdO9JNqu3kj4bohYYQza9VadB5GCf8jXSLOeps5qHZoGlmVXXOmWgB9FV8ggQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SRYmd4DXh17peRDfizZxXJ8LPGd0hWtGAFftYZEH1E0=;
 b=FF8PUHqp6DcVby4F4oKTqzgUdSMP0PIDCDJfT8Iq42Hh7A5YNFY2KybJSiQazL4YY7XVS/FGxa6DNRGzY1bBnrChrQ/T9Punv93PHKimzUeuuqAzt/1f3wUAlrFqCqqz0AH+Tc3eFafrr5tEHwdOIQY+SJSYEetz9EUh9UUDv9aLIMxtTJT5giOnnaDm28//dvD3oME8dLSz83XtsL0zNRs7TuMCo2vu7kb6yjGU9NKAjSg8sXkwkvyMfZpg6GB1LA36PUc8jNwJ624wP9v9WEkz10L0AnIdr33va7VhmHg3JIo7sxZkVYdqxM9CWJRHysLIQkGCuuQtB83i9Iq7tQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHAPR12MB999248.namprd12.prod.outlook.com
 (2603:10b6:610:2ff::22) by CH3PR12MB8546.namprd12.prod.outlook.com
 (2603:10b6:610:15f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 18:48:13 +0000
Received: from CHAPR12MB999248.namprd12.prod.outlook.com
 ([fe80::4972:8062:d74e:b205]) by CHAPR12MB999248.namprd12.prod.outlook.com
 ([fe80::4972:8062:d74e:b205%6]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 18:48:13 +0000
Message-ID: <bba453eb-769e-458b-88f7-8cc9bcafc1db@nvidia.com>
Date: Fri, 16 Oct 2026 20:48:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 0/6] net: configurable extra TX headroom for local
 egress
To: David Woodhouse <dwmw2@infradead.org>, David Keogh <dkeogh@amazon.com>,
 netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@kernel.org>
Cc: Nimrod Oren <noren@nvidia.com>, nh-open-source@amazon.com,
 linux-kernel@vger.kernel.org
References: <20261015235335.4162993-1-dkeogh@amazon.com>
 <b8914a523b4a6b80424c5001d3d8012c6a98fd04.camel@infradead.org>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <b8914a523b4a6b80424c5001d3d8012c6a98fd04.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0117.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::6) To CHAPR12MB999248.namprd12.prod.outlook.com
 (2603:10b6:610:2ff::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHAPR12MB999248:EE_|CH3PR12MB8546:EE_
X-MS-Office365-Filtering-Correlation-Id: 632917fc-7dc1-46d4-9f4e-08df2bb60846
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|56012099006|4143699003|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	1vI8ed3pwsq/48DwcNf+YJDZAN0FlQxgbZ5y0UBR4mk3shJyYGSoxVk/RjzeiZph+d6K+buas0iGHShmGp1Ks9QyYHVWPhEcqyxRge5R4fBwuhjRneis/RAqCxsVOA4bNs+u1kE/dY/Dbs13+CtNjC9uihl5mU44P+Vn4c7JIEFBCqMMxTWHBs+Nq4/KE6tlmdGkM4EAevEn1wDP2Hmio1hR3MCOur1O6y77PXzXiIjH0bjdONmjl8V8AQVaxZNnZ4XBJSqU8sPAUSPo16wyH84fGHzq/oQUyQSWGKxWR+VXcP5qsSWiqqrf4TsP9IDiiU8PFiIyIs/UqE4YU9wiv17WB8G6wbhuuGWzD3kBGDyOk8387izZ7P4Eo+VU1sdaJwfHEfcY8OUKyt/dWPbPUs1rgjo77xz3tIrQqx4RX7uH1CrVe5moFnPGQfsuZt9x36uvnKxOPAsH+ndYyuSnypSBguXMdIGkobr+9edI9AhZbuBLDQvTlVBXU5GcBCG31JZWjLzwR1mlDet1atp9vAh2Z1VjL0TTl+Lg7OirlPSYuB1HBuhlJxxKRDb7cDD+Suic8CaEJvKvk5OEezneFAgs0kivZckPZUccuseiYQX9j2aMMYGXeYbFqWJqdTWUQoXJQhiWbqAfhujjRLcmxIs/QDFBfKTZc/F/tFarw+I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHAPR12MB999248.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(56012099006)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YkVxQ0MwMEF5Nml5SlJuZ2NTanhUOVpJN01DamNTSjl2M3BmMzg2Zno1bkti?=
 =?utf-8?B?RVZrQ3lLY3VBaXUyNVpDczRZTXFJbzhSMUcrdHRBdnVLaENMZnU1bUYySjRl?=
 =?utf-8?B?SHdhSUVPUzkvSUhSZDVmcVVQbExKRUs2QlA5Z3M2blR1eFhUZXlRU0dnbGVs?=
 =?utf-8?B?OUhGTXB2NHB5QmtOdGo1Y05WVDhQdktsUFJqS2Zzc2RnakhPUkxpQU1Jb0dV?=
 =?utf-8?B?a3lMOWl6ei91ZnRsVm5PTGVnNi9oUkg3c3BhT0pWaDd5MHFvRUh1UGZWZldJ?=
 =?utf-8?B?ZnZhMUpqRTlwdDhmNktOaU9JMU1OM1F5UXNUUHhzS0p4R2hEaFQvTXV5RGRs?=
 =?utf-8?B?bmd0ZUVIWGRRaUl2eWlZaVJ1UERic0JPZjJVbkx2ako1enBaWWM1VlBDS2Ny?=
 =?utf-8?B?MHJsdGplZFIwU1k4N0ZKR205YlcwWGd6TWx1UWRZQmZlb2wxdHU2MWhaaHlM?=
 =?utf-8?B?cHNOTGFNbFRNdEExRTNWOGhCMDAvb0FsQ3VnZmNqUUQ0WDRUcTlqKytRTFRo?=
 =?utf-8?B?eFcxSW54UkIrZlhtd1V2emRPOFFRR3NLdmczYytpbjQrU0NtNWhDOU1GNHRC?=
 =?utf-8?B?aVI5U2xGRHV4clJLbnFsWXBwR2lFbS9QKzVDem5jb05UaWtzdWkzQ0NsenI4?=
 =?utf-8?B?bldrNXNkcEh3Z0wvbmxFWHJVZzY0dDFidzZBVzhrcFM5c1NBT1RETmxiL01W?=
 =?utf-8?B?VUJ3SUpUakhPUmJaZndXRnJNSkdteXdodm9Wd3U2VXErSUpNKzlVczlpd0ZD?=
 =?utf-8?B?a0dpWHVXaUQvcDRSYzQ0Nnc5NitUbWVCeE52dTRoN09BdExHY0pPRk1iU1hh?=
 =?utf-8?B?Mk1UdC9wdzQ2TmZlYkVvRTd0a1dZcVJXSWF4ZE5odzlTeEZlais5MEwwREFQ?=
 =?utf-8?B?cG83aGU1Q3psMWRHOXJVVThLNy93WFdzZU40dzlOUTd0a2p3aHFKKzRXU2VW?=
 =?utf-8?B?Vm5GRHhFSHBCczVQc3BwTVFoQWdNNHZIcFhteFZEYVhweGcva3lUZlZVR1JS?=
 =?utf-8?B?ditqU1VQT0dxdmxWREFIRFlNNEpqUW15bThXN1B3K0NVRHAxZGNGNUprcFQx?=
 =?utf-8?B?Y0V0aXJvTDA1a0Fra29zb29WcDZOR1hTVjE4RlRwR1o2OXpoUTJ0VTcrUkwv?=
 =?utf-8?B?RWxFN2hFMnZ4WHJDQnF1WVVKcHA5c2YvRTV0a01vMTRUaEZzOWVidlMvbXIy?=
 =?utf-8?B?dDdSdFBUbEwvZ3R6ZXZWREVhN1A1TUNsaDNyc05ZeHFwVTRPd1RsOHYrUDFG?=
 =?utf-8?B?cW5uV3l6cVBVTC9yR1VpKzV2Vnp4blNaNFd1OXM3TEcrSmpPbTE0UGhWL1RU?=
 =?utf-8?B?MnBaOG1tcG9udkJFMzFJb3dBYUU3UDlkN1lFOGVTV1ZOM2gxZnF2WHVCYU1n?=
 =?utf-8?B?R1FWQ2t5QUwvUmlNb2RuSjhSeEFqbmI4cUNFTVhzUmlCb2xIODYzM3YxYURN?=
 =?utf-8?B?ZUJTdDRhOVFjWjFlY093ODZ2Qm1BNmVpZld5ZmJsU005Wnh1WFFraWNYdktC?=
 =?utf-8?B?ZWwraE1uWmFjY0tFUjgwUVlmY1BGTnUwd1lyV1c3ZUVoUHBNWWdOM2kzTGcw?=
 =?utf-8?B?MldqSWJIVDRzMGdwUXVnU0Z5VmtBUkhXTksyZlZtMVZyelkyL2ZhaW01MG1v?=
 =?utf-8?B?Z21OS2ZDVFd3WUlYVi83ZXRSQTBrUU5qcXRTdUdIWmxDV2VxVndJVUJuTVh1?=
 =?utf-8?B?LzhXbDByNllMZ0dGVEFFQ1IxczVBMStURzBIVjBnSXBJUDdCVnhhWlJYMVhQ?=
 =?utf-8?B?VHUrKzFwRVJSZkxieFk3Tk1oT2wwNFNoMDdBNDdzMVVOS2h0aDhmNStVUTg4?=
 =?utf-8?B?L25IL2JValA4MlcxL1k1WnFtcG1VRWYvSEsyeHNIazBsLzBQWUc2TzQ1ZXlt?=
 =?utf-8?B?M3pnU1N3T2xuK1FYVDgxdS84S0RUY0hKTk81ZjF5TzFZZDFJWGtlUjhSVXRQ?=
 =?utf-8?B?eHAwZmFYa2FOZU8vR1JyTUlVZExUcVM0K1gwMnVrWmkvVlp0SEhjZFU4QUhq?=
 =?utf-8?B?dE9iSmlHakhCdUd5NTh0eUwvVFRZOXFrNW9Ld1J1Z0tLRUp3OU9LajJxUlIw?=
 =?utf-8?B?UXB6WW9HeVlOZnBKY3VHL2ZUSjBCZkpGVnVHSG84ZzVNQ0czVXRnQUptSXpj?=
 =?utf-8?B?OGN6RVIweEk1M1Mxb2pmK3JMUGxaR0dZVW5wSGRuZ0R5c1JQcmpIcElaMU9M?=
 =?utf-8?B?aklUczBhWDl0NlZvMEhoejQrQm5QTXlacUtNRUxlYzdhOUk3MnZ2RWtuZ0FV?=
 =?utf-8?B?UXZ2YklTU0g1bTFidFpteU1ZTUNSYVI3UFpPRmYvL1F3QWtFcVRGbW56WE9k?=
 =?utf-8?B?TEkyYzBvazlYNnNMUEZPdTF5MGVvakM1eHVOaFRpN2lLRFl2TVJ6dz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 632917fc-7dc1-46d4-9f4e-08df2bb60846
X-MS-Exchange-CrossTenant-AuthSource: CHAPR12MB999248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 18:48:13.4779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OqHZQJfX5SEmZBQ9lJCH2MmwHkpZUha42P0nwaA5PKJKiQ/iGTM5eLKhfbTiL7O46C4W4eB9L9+uPX/NI0Dwvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8546

On 16.10.26 10:02, David Woodhouse wrote:
> On Thu, 2026-10-15 at 23:53 +0000, David Keogh wrote:
>>
>> Measurements (net-next at commit 05b5019b0, veth, 500000 UDP datagrams, a
>> 20-byte ip-in-ip push attached at TC egress, only tx_extra_headroom varied):
>>
>>   tx_extra_headroom   pskb_expand_head reallocs / 500k
>>   0 (off)             500003   (~1 per packet)
>>   64                  4        (background)
>>   128                 2        (background)
> 
> I remember frowning at this years ago, in the context of PPPoE.
> 
> I have the same question I had back then: why, if *every* packet ends
> up having to call pskb_expand_head() because it didn't have enough
> headroom, does our kernel need to be *told* by userspace that it needs
> to expand the allocations?
> 
> We gained dev->needed_headroom and ip_tunnel_adj_headroom() since then,
> and the kernel doesn't actually need to be told.
> 
> You explained why you don't want to use dev->needed_headroom; I don't
> have much of an opinion on that front. But if you do want to introduce
> a new tx_extra_headroom, could we try really hard to have it auto-
> tuning?
For TC-BPF I suppose only the BPF program knows how much extra
headroom is needed.

Maybe this tx_extra_headroom could be declared as a BTF decl tag
in the program. If this is the only usecase there's no need for a
rtnetlink uAPI.

Thanks,
Dragos
