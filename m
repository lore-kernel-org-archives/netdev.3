Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013017.outbound.protection.outlook.com [40.93.196.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F05282F2A;
	Wed, 12 Aug 2026 10:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786530911; cv=fail; b=hV2gpvBHa+HTfKZvbDHIcSImuiU8Fvl0UP0TI9Psjo3fHdl6R8RgplAC9c40cR5Miz3Pp7AS32g/npqCxXuNEt8GaC4pbrLr5OQqLUJRkkvBgP+CIv/xW7F9RtrsqfxMEmk/HNDCkKCTvZ0EwWRARaZpxDj+1z6qRNZqJORblPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786530911; c=relaxed/simple;
	bh=Unq4AmeFfCZy7od+NPy26hRaPy+KlI5EUDALPjxhhVg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RC10B55+wgvfHuUN/pJaSzuJrE2/R/4b3JKmA1IIjbMFpqhwp7rEl4xDsAd1P4MrvjP3M9ZWL6nlpLQf5WI3twzc/7RQKOL5yPG5OK1/8OM4oLXM3fXYkLUpYakkUPUQmFh9Acax84ouK0JPb/z32U3Q+L+pEgEqdgQKZ1vWfn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S/zO1Mg2; arc=fail smtp.client-ip=40.93.196.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S/zO1Mg2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oCsXv1SOTFjzkyGsJBKjfvRpO0XCw6tMhX05kRydhpog6cLto4bLK0uU6OeJXzJmXka0imVcLQ9met3nYzuWjEdhDr9KCd9hwg7Iz/6x4uy4DdpMUB93VoLbWgcxCmJB8DPSbVxjomjhzuZc2BBLDUpo5Aa6dTpa1vku9IwvaPfqN5JL3PU2bTeac+tsk2LuwKarjSfNHsOsLm/C1RiYuJ5rf6jbJIfdOI+Oe5OV9i5wNhhPsYqJjTZNj9QAw/IHNRFHmukClGDWRmMkwjfifNiRVrizZzJYAe/4tKnEBxUeCeek7NM1Vr7cyP8p7ACYWihDRKX3+EL/tqpmCwTvvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AqRe1SkRYD3UXXdxwDh+yhnSEwb6woieGlTVPTAV1EI=;
 b=XKj5EiXzRSPTcdGNBUt8iNM5H3DpEzW94ENsjXZpCowRiu1++bNKi0UTFdHQXBRNeeWvivQHdEz5jjONLg7CKF8Rt32vHChAZuPPEmuKq5Ef5obcWsXkcIf/RgiYSi99zCGP/ZytJRUKLrRYeaFKfESY2aKQCYDZfd1YAsWzHcjDFr7LZivrrPdz4tDtlPj/RgFC4q0GBWPNN71eekkv9I4cgVjqVm4neC6bLgoCmYGDqocye240BSgepY8n2I4AgX708BWi8sk7jNsW6NT00bwFWJCdpKJ2TIERuxkrhlalyWPm4GpGC0R+2haMwjD1Yw1tWj0nFI6RXeeCXTKIOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AqRe1SkRYD3UXXdxwDh+yhnSEwb6woieGlTVPTAV1EI=;
 b=S/zO1Mg2AOqvaWrqAIQcdPL+Kiq6ciDHyaGdd8m4lnsw4cEBbQt+xFXjZI5jcewKb8q5TRTDEVevODpNJI/VLfAwgZf/l/vUivgoRp5mQH1Fah69EuewPSolsEGYO6PvOJW2VOIDtt4o4Xud5HAj3izjxwWQYooRsXMaF3hp122dNjoXLmrIFbi44bMtz1Qs5naYYSkoQPhnma2YFjvX1ipK1sEJJhlYG4fQi2B2lo3tX4WmdqVuC7jFiTUHkci+BCxt/rApShADyLfUu9e7H9K6DF+7CSCPFKzsbSXS2vb7MBq87n1sdxvmZP27oD7fG0F2xHhuLEWIPyT17omdKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 by CY8PR12MB7147.namprd12.prod.outlook.com (2603:10b6:930:5d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Wed, 12 Aug
 2026 10:35:06 +0000
Received: from CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7]) by CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7%6]) with mapi id 15.21.0315.008; Wed, 12 Aug 2026
 10:35:05 +0000
Message-ID: <46c9fa9f-bb33-45ae-a4f3-99f9ada87fc3@nvidia.com>
Date: Wed, 12 Aug 2026 12:35:01 +0200
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [LTP] [linus:master] [net] 8e63c9e617: ltp.uevent02.fail
To: Cyril Hrubis <chrubis@suse.cz>, kernel test robot <yi1.lai@intel.com>
Cc: Shahar Shitrit <shshitrit@nvidia.com>, lkp@intel.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 oe-lkp@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>, ltp@lists.linux.it
References: <202608120846.30e0fb5b-lkp@intel.com> <anxDKg9rIbSzRS2e@yuki.lan>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <anxDKg9rIbSzRS2e@yuki.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0138.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::7) To CH3PR12MB8728.namprd12.prod.outlook.com
 (2603:10b6:610:171::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8728:EE_|CY8PR12MB7147:EE_
X-MS-Office365-Filtering-Correlation-Id: ead827d9-9d8b-48b7-df7e-08def85d5fd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|11063799006|10067099003|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	lJlrsi1aQbXHxcmJE/XAp8MiiRP4pHawZyYKk9uavWFeZHYytGV4Swdhyf8S1Sz8lCUh2lWd/i56gieN8Wja0sAVM0JpCBOYwYQv0pfxGG9WHZIy/rJMBe6/KCEnbRCxXkUMZTVWHnl47SdH9BPnQ33JFjIy6lRHpkYF5QaCQ8+Q79LrEESELrZhMpGoe0OvksxFCqLruxLKPa4tmqOI8aKOj/GZiY8296BwVw6tsxL4D0JyvYzGvgqSAPm1T644DvnhUBm/L75/J0ggr0OvePVSD4A7FhxqtWq/E8TpuAamVGFkRaD4kdNZsDwqKyIVCF9srWcrDNncfyfBgJa82KasyUmN2QL+Pjxu/VDmOXqpPH70lOYpwV28l+GuTMHXNDgIkeSsEAeyJP/5ttffsBhy/fSAWRW+r65pQpiFC1nCCTQ/jMFmVTsjkT0b4C/UkWT+vMuhrxGZt6Hd318D9E86J41wAMARWeATOBVqDNAqIcFDCeGgq5dbqkXkTzom0aAYQ6+BUsYOnKwlJ9dPlTyUKYvalgMPfjvR2jD+oWMoMu/egfe1XHKh4cf+fNzLKaCnOOLP3eQ94N/MFtdzwFrqkzZTuPvvcaTN47c4gjj9JKoukfFNvIvvJsdHWJX4obBWQU7FlBMqCHw9OONGkuNpmULw10X28waqtptQxsQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8728.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(11063799006)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SDNheldKOWp0ditZWFFlZ2RoMkQ0V29TTFU3RTlGUFR0WGgwM1ZYYndCdDdk?=
 =?utf-8?B?b00ydU5XYlRwU214NjJRTEtMdHBoZ28xVzlaZVEyWXpFeGVJWU5ZYlhzTHhE?=
 =?utf-8?B?dlFRN2FWVUJXRjAxbUNqUWdqMzEvcHJaQ3ErVDJ6RmN1dzJ1NkxuYVdDbmZX?=
 =?utf-8?B?RTlKRkFJRmxnUFVvSkk4L0YyQ1grRTNseWIyTjJtUWloNVptTGlJcExXRzdT?=
 =?utf-8?B?QWdKdE1PUGRUY3JRZEdXbmZSdmZlU1hDZURCUHZ3Y0tDci96QytvV1BxRVJB?=
 =?utf-8?B?Vm9McTdEd2ZhbXNSc3VVUWkvWm14MGtxdEJLUCtwc2hienk3MVN1UzVOazNG?=
 =?utf-8?B?V2x2U1lNMDlvU1k0TnVobFBTdm9MRXl6Q3BEYVFZUFRaVUZlOEE5VmdmSVpw?=
 =?utf-8?B?d0xhK3NFSTJDRHVlR09pZ1pDZEZwNXp1VEdiNG5SN3RLSWEvMzRRaG5TL3Y1?=
 =?utf-8?B?VTNKRnJia0hMaUxMcWlVZGxZOENRaGttd215Nk5MU2VmSE9teElzaTRxakVu?=
 =?utf-8?B?VUNhTUY5eTlJVmxOTnJmbDA2cEhtZjYrWjA2Y3g1WXRMK1p5THlSbWpXcGVn?=
 =?utf-8?B?T3JyMGVZSXlFeU9Mb1hoVmtXMEhtWWx4Qk1HZmFPSnlSbmtuYUtYNEdsMmVt?=
 =?utf-8?B?QVgyTUpsMzFXTUVRRWpIb21SSk40bnd3dnlzZGtCWlhRVGp1djVzS3RyM3VC?=
 =?utf-8?B?T29NM3RQMkk0Ym4zOTdnVFJSdFNWMGdDM0ZmU1ZhcVNRVGlpdDZ4L0lTcG9C?=
 =?utf-8?B?N0wzME5OQWZQWFlSN2VuYW5KczhoR1Q4RXVFTUNodVdoMUk5T2ppMmR4eUkz?=
 =?utf-8?B?WVlGMW1ibHVyTFFSN1Y2NzZucktUcExlK2c1dEV6NmxvM2laOUtBQXhvRjlB?=
 =?utf-8?B?N0p0MGJ2eDh6R09pUEFiTjJKcnVTUFd4Z3JQeSt4NXJibmZWbzJiVU1LTTRC?=
 =?utf-8?B?cUtVVk1rUmNmNmVaOEFYUlRwUjZuQytKcVhodU5VRVRCUVJhZHMyeWN2bFlK?=
 =?utf-8?B?RzgvSjVoRU9VTTlwTlduSTIxZ3ZIRFlTTVJWRWg4WnE1ZnNMWDFCdG5wZXlo?=
 =?utf-8?B?ZFpuVWJEbHdIWXU2TkorL3h3czFIbXBhTEh3VjNPbk1wSHhseHNFYjUrb2I0?=
 =?utf-8?B?Q1RwSVY3UHJSR2pYZkNyUUYvQ3RxQmt3K0xoMUg1OWR5ZHBEYUhwTDgvemVY?=
 =?utf-8?B?WVYxMG8vbmh3NXhFOTdRZVRUT0NaaFo4ek9KUzVlUnA1MjdlVkRMNWRNcXh2?=
 =?utf-8?B?UnE0UUo4cXRFQXJ3R3haMGJkUWVrNHg3b0ZzQ0hEc25ZMEplWXVtUTcxdzhn?=
 =?utf-8?B?cTFzME90L1ZORks1dVZUc21iVzNnU0JXNnNwZ3p0UHVxZ1o0MmRFRDNYU3Ru?=
 =?utf-8?B?dHJ4YnE3OUtaTmJma002OEhTc0tFZWxoRTJOZ2xHSHFkUFc3MjMyMVN2M0J0?=
 =?utf-8?B?RTY5bkpZbVpJcGpOZVNLSWdqUGZOWEJEczc1K3dBOUlmaXEvUTl4KzZZR0pB?=
 =?utf-8?B?SGJKTmhPUEJ4N0VrZnVmV2NZb2Mvckdya0Q0c3pNUElNTUxqTVBJVDBJck9O?=
 =?utf-8?B?ZVZaUFBOUGlLbmNsTXd5SkE1R0VMclBwMzQzSWlVTXg5UzgrZ1h0a0xrVzY2?=
 =?utf-8?B?QUlPdlBOK2J6YnV2QWdEenhyZ0dJQWlHd0drd0c2R25WcCsxeld0QUpxdHZ2?=
 =?utf-8?B?b1RqYzhJeVFQTFlXOU1Vd1ZTd2NoVU9pV3RJZHl4NyszWGZwV0J3alJ2UFFC?=
 =?utf-8?B?cXZJaE5MU0tNVmkvMDh0a2R0am01TEQ4Qi9JdlQxTkRMdDUzZEc2MDlHYjVP?=
 =?utf-8?B?K2pnNGc4TU83Zlg1REM3MHQyVys1bXBmUnVtcVJJUE5zc0czbTRIMGtDYmFD?=
 =?utf-8?B?UkhDQWFFeGE2RTJSVjd6LzZMem5sZk9kOENieC84ZGxRZ1pYMUp6YjFqN0hT?=
 =?utf-8?B?Rm0vemhGN2toQTliRERNSkpOeTZzOHpSRnJIRVZqOHBUVE9vbGRaMlN1RWFG?=
 =?utf-8?B?bjJtV0U5UDhqR3YyOFJJSkg4TmJRclUzelN2dTdseHlwZXhSN29qRGxTY05m?=
 =?utf-8?B?YkdwTjRIMEN1MXoxZE5ONUxRb3Rra0RlcklCbytTa0dJRjJFaW8rN1NlMml3?=
 =?utf-8?B?SytNaU5nNGVTcXA2VVNOWU1TL0Q0VGtmdHNpVWtZdTdWeisweEh2MUNmblUy?=
 =?utf-8?B?MGxRUTB3WjJIUjRrdkNyTXpRYmFTSjBsckJxcFRZNnUrdUhYMTlNcFFRMTJi?=
 =?utf-8?B?U0hJeGFHUFdhendQbFNUOC9mTUNjZUZzMllLVHF2RkdxT0VFVEEzWXNtQi9Z?=
 =?utf-8?B?R0xoQlkyWW85MWVRRUJTWWMxT3ZDNzBzemxhTUxNUFA2YmVQYmM5QT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ead827d9-9d8b-48b7-df7e-08def85d5fd2
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8728.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 10:35:05.8998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gVytqAemVujCjRLCoTtIYi502HhJ7vk0Txc76QpenG2BXHWkEydKWx/Ycr9agYo/MP7eCx4TLZXzWrImEQ8ExQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7147

Hi Cyril,

On 12.08.26 11:55, Cyril Hrubis wrote:
> Hi!
> The test was asserting, among other things, the exact order of the
> events and it expects:
> 
> Add ...net/ltp-tun
> Add ...ltp-tun/queues/rx-0
> Add ...ltp-tun/queues/tx-0
> 
> But after this patch the order changed to:
> 
> Add ...ltp-tun/queues/rx-0
> Add ...ltp-tun/queues/tx-0
> Add ...net/ltp-tun
> 
> Is the order of these messages guaranteed or do we need to adjust the
> test?
> 
I don't know if there's any guarantee about that. But the mentioned
patch postpones the net availability creation for a good reason.

Maybe Jakub can chime in here.

Thanks,
Dragos

