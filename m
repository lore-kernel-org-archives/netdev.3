Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013018.outbound.protection.outlook.com [40.107.201.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B33233952;
	Wed,  9 Sep 2026 09:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788945425; cv=fail; b=GsofJBzn6VstqX8sMKzWg6z2j09jYROgP8kJPWH4vZPos3E8KvnCf4edrdXzc/k6iImyC0UV2wO1bvWLx7BoRCf5Z5jyrRapQMLx6z5pSb05nChHYAK90FWnlsgFDuf8n7Bd7B6sXNKlMccYf7cCites3Z5988+fsnow7jlsEyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788945425; c=relaxed/simple;
	bh=UtGFHIJVTx/ma/cMpJYerNB3NoD1IMdQpnFm+xk6MDI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IN9wdCuaQIqsV3OxihVLvlzpc88ZbTJWUdtfqVgSzVYaoHifGu1JbWHhLkzD+InMtWJwl/ik7Njo7tUqgYqFXuoNfvc5mUuxWTMll3gwn9rioZrcXX7aRoNZ06UPNoCSRAiwb654u3j3CxByJrg54hGcxdM2Z3STQKRs3geoaRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=emO4cK86; arc=fail smtp.client-ip=40.107.201.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="emO4cK86"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A7d+46w5t4ABfBBC4A/i+khLJwp8ogwab+7THo5YLOqt7FYaN7swPe4izxu4fmNmKl0wmxwDQW6NysMrXw/qN/WGu3lZfw8zGd+2jehWh9BjejdyWr8SnE9DFnNOaw61nL18XIQe/EIUpl5mcXQ9Dasrt0sywh91Layc+VA24vdS8N5yhnygscug4bwzzl98+JHNKjBbL6j4H/FaoU1ohqiO484VjVZ9JSnjpsK7gaoBSJs2SASk0xCYxRWxYyBG/WVR6UYcmR+0YZ9XMySKFbBSHML4hCegD/6lc6yNU6QL7aKSyx7t5+uLYcWU/UGm84WeAVCxHazVkmJbW+wkUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yOBwRrJ6c9OaRMZH6qfEezPUaUqAV72cJejfqbIFk94=;
 b=ljHn+xRTSHlx+s3GwnH+haFk41NulVLLbUgFFo21vcRl1YCIp4g6V//GAhboBqBQt5ntmjchCOFnNCgD0TWn1objxIilPLdMu+171UguSrJu1bHF5KMIfqF8O7Eu6TG/nLEEte5bWRBJD0sJB1neQpYHMh/0HiUw1cEmoxZLavJ71gI7c2PINfsRXqGlkfINTbEalS/n9HlwQMBrxd7rqzkAp+Zafm7wp4zhA6XPijDNH8XPs7agpoLc8OKwsVpTy4R5oUDxIlWOgow/86iIlooKG9p2VT81PxTyztGaAd307opCXFMoTF5iUqLs0U3OE9yGvADDGYSOIXJYbWxnZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yOBwRrJ6c9OaRMZH6qfEezPUaUqAV72cJejfqbIFk94=;
 b=emO4cK86RJ5BgCbBwewhhSkCHxKM4GXe5JCc47blbDxO7D0cmHLTW0/ATliRSpoPxA6Z1DyCq9o4G1gB3sy8ivCcq+bDCtXDYtVMnLMWQjjgUInDY7UbA4SWcdbuv/1ARc/uqdZI9miHMMp2gh8K5PT9b0l0seMXz+cMhJyNlWxI/WZfCyC71nhyjF3vrN/fkYYeNxJ9mSEHnuT2e3Cp5lwaPUEaNuiMUzJ7SuTm+WmikhLm5VwR4ebqaKlaHZLBB6f7OJAKFmY2KFnEfCH7Eup41HKSuQ9ymhk2Oke8WWwt16AbVg2iH64bwnN0kVYosjnciyhztR54GXaC24DMTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 by MW6PR12MB8758.namprd12.prod.outlook.com (2603:10b6:303:23d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Wed, 9 Sep
 2026 09:17:00 +0000
Received: from CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7]) by CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7%6]) with mapi id 15.21.0406.007; Wed, 9 Sep 2026
 09:17:00 +0000
Message-ID: <1454a86d-5a8d-4ae7-b6a4-24f256729649@nvidia.com>
Date: Wed, 9 Sep 2026 11:16:55 +0200
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [BUG] net: devmem: TX dma-buf binding UAF on netdev-genl socket
 close
To: Mina Almasry <almasrymina@google.com>,
 Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: Hengbin Zhang <uqbarz@gmail.com>, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Taehee Yoo <ap420073@gmail.com>, Bobby Eshleman <bobbyeshleman@meta.com>,
 linux-kernel@vger.kernel.org
References: <20260908043115.216613-1-uqbarz@gmail.com>
 <aqBFxdzPnFmW36_J@devvm7509.cco0.facebook.com>
 <CAHS8izPN6P4=CKFZkowo+t2tx=nu5Q8JjVdZ=_c3eMrMG=9LxA@mail.gmail.com>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <CAHS8izPN6P4=CKFZkowo+t2tx=nu5Q8JjVdZ=_c3eMrMG=9LxA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0048.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::15) To CH3PR12MB8728.namprd12.prod.outlook.com
 (2603:10b6:610:171::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8728:EE_|MW6PR12MB8758:EE_
X-MS-Office365-Filtering-Correlation-Id: 3685464a-067f-4410-e82f-08df0e531a5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|23010399003|1800799024|376014|22082099003|56012099006|10067099003|18002099003|11063799006|6133799003|4143699003|5023799004;
X-Microsoft-Antispam-Message-Info:
	EIkHcxSL0Dn1gyB5OlYtoW1QSgkNVzmUCZfNO9diLaBCJzg1jHbSDN1isXLuqOMYF8b0ux2+ENSqR+voCjhBcGXVwEiMU9nW2NW2ww5WteI8XTaugppow1cgXZjaVz2DJdmdjcDImEMf4RN10DI94O9oDZKeiBvFg/jnc8EN4Itm97sSQXZkwlIWWgHmVJiXdDqZgkCQX9WUBHitox+Hx4ecuO2HRU3H3vGVt2pTRk56JJRIK3HDqSxZ72gBEe4WdU0zi0pd4KtKQZL/LSeykLfR++W1dhy05YxqZeiQNWkBpSRrIvzVdfagZfPL/m6W3A7uX38/5dKVUyBUVOIEKSdimeUDa3z8QoG8pAltOQjGxsT4x2YL8+0Jhfl4/cRfuPFSNlmMtcgGnBnq4hGAcYO00B1sa9tkFq3DG5WdpDphay1TIDS5E5iZKW3brPMgZPydXAGZLE4WqnUXVhTLhKnwoGBYHCxauHp9Q+tQBp7oOdssEhe/tCd8T9/TypsQClBdToUGHabikgGpe58VtchaX4DxtHr3tmJF5644pMN3ayZriGL3wHwkBFN0ZZS+lHKCazdL92iAXobUD6xKkFvGOe8QXBnkjnYJnanA2zDWdFJEkDooOLde7CrnaVHw7GkYmKaecs3seWwx2YsznsQasAsFhuFJGBru/yi7Lvk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8728.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(23010399003)(1800799024)(376014)(22082099003)(56012099006)(10067099003)(18002099003)(11063799006)(6133799003)(4143699003)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TlFOMEgrY0p5ajlrUU1pNUxOelRnYmdzRFd2SDJZc1RRaThidlR3NXY5VkRY?=
 =?utf-8?B?MVlFbzhjdUdwL3VWbDBZNWgvSXdkamt3RDF5aTJJVVYxbmNLUFBMbnNDd0c3?=
 =?utf-8?B?TFhNZFBwQTJ0VndNV2NMbnVOWkdXVlE5Sk5pYnhMVjNSWHlxa3NtWlJGcVNE?=
 =?utf-8?B?b29zK0lndDZNOFdBK0JIYmdKQlJnZ081N2loc3IyMlJWZTlNU0xTRHpuWnB6?=
 =?utf-8?B?eVhsVXNwTGZpYWNPTGk5Z01OT2RZS1h1TjdoU1J6WllYVU9RMkt6K2hVUDF3?=
 =?utf-8?B?NG1GWWxnVXFHSEcyQ0N3dzFIaDYyR0RYZTU5YW80UmRQaXpaOW9admlzMlZP?=
 =?utf-8?B?OCtyLzNtMzFySHprREJrZ1NrQVFwRU5sTGpaRVJEN2RzMzhOVEtRNVh0VDJr?=
 =?utf-8?B?S25OQXBpOWNmYllHeGppZGVzQXA0V0lqQlJ2L3RObmVLdlRTd2lBRUVCckda?=
 =?utf-8?B?aHVyS3ZkRUtzbUpBaSttN1o4OS9TV3NXUUVDS00rMkliWkw3VStTcGhvQW8v?=
 =?utf-8?B?QjIrQjE3QWhVY05XMkl5SEZIdVlCS3l6SWs3SjFCZnNDNHRjaVVlanBBWS84?=
 =?utf-8?B?bUd2Y0V2MG1MNkpUaGNycTRFRGtmcWZ2Z2hRUEw5eXlPcmtsMnowTk9TdXF2?=
 =?utf-8?B?cHlTT3A4SDc1dHQ1aEtBckxxNHFSTkFPSzlhN0pOcTc4ZVRuT0d2R205NkNl?=
 =?utf-8?B?cHBlZlppdE4yZHBHSUtsbzlpUjdMSkQrV0FSUzZCWGkrRnQyR2RGQ2dGNUxm?=
 =?utf-8?B?SGR0WldjL3AxNHpUR3hZdVE0Q3dHTld1KzQwdXhqdjRqWWhIeWFhOHA3c3dG?=
 =?utf-8?B?eXhjU3ZJYWtZaEpxbEtRNHNLazA1QlJSUUZlN2FRZm1KTlltT09haFpOc1o1?=
 =?utf-8?B?NVZISzZBSHlqSXYweGJhNC9VcnA3ZjJWQlRYbTgxeVJKRkEzWEF2bStPZDAw?=
 =?utf-8?B?NlNweVJzWHdEUHJkTzF6NzROb0xTL2ZOWTJLTU5DS3R0M25YMExOZnJUeEVL?=
 =?utf-8?B?eEE3VGt5R0ZpS2JFNWp4ZXAzTTlmV1krWkNERVhVdVZWZTI2RldIT213ak1j?=
 =?utf-8?B?VmFqSmRzNjdZNlJhdFpGd25hSW5TSFJyUUIxRExucDlKRjRKR1l2ZENwbWJv?=
 =?utf-8?B?cUI0K2QvZlB0cFlOWEtadjJmMlk2VTVWWllycmFIR0hPcGV6a3hrM3hVRGIy?=
 =?utf-8?B?Q0tocmdoeEZSSG5maEVCdzNVS2J5ZHNtNStLcnIyNjZzOHFNUEgweGRScU9i?=
 =?utf-8?B?cHcveG5MbGI4TGlMbWE4aUdlMTBNZ2RENUJHY1pLOUhxcENObURhdG1HQldW?=
 =?utf-8?B?Z3l4WnM2N05xWWhBL2JyUVowMkF5eXF6eDJ2RWhmeng5Rngwb3Eyd2V4Y3Bj?=
 =?utf-8?B?N3E3NFl4RVlwcEFsWllJZlVacElJNEVBM0FuM0dQREZvaEVjOEdhc2Q1Z0Ew?=
 =?utf-8?B?cTAxQWVURXVIZk5pTkUwcUtwME4wY3R1NGo1T0I3L2JNWE1aRmd4clA5SHh1?=
 =?utf-8?B?ODQva1NpMlhHcDVtSGdtZWVqVUl6b1N0VWd6N25OY2N1czZCT1hsV1VuQ0Rl?=
 =?utf-8?B?OWorZ2hmbU02TFZZYkMveWRQeHF2Mm9makFxdjM0MmcxVU5peGJJbTZjN0N5?=
 =?utf-8?B?ZUQwQlZETGpweHJKR2JZSlU5bU5yaGUxZyt4RVVONDlxMW9maXE3ZkErRGtw?=
 =?utf-8?B?a3FCQzBPTEs4d0FuVzVBWTM0STFyTGNYRzNYNlgraUhlOVJDUUUyWTZnVWdT?=
 =?utf-8?B?Y3YySC9WWU5jcHhoMHRDaXp1V2MvdnNCMWEySG5mVkVwazlHOG4zbUhKVWNu?=
 =?utf-8?B?b08yZzZsR2htL2lSWGF6OGJ4KzB4OVFtOENXMG41Y3F6WXEyZnZmTkx1bDNK?=
 =?utf-8?B?OXpTMkJkSVRHWU1wTWNNdStOMyt5RXRsM01oN3A2WnBaQzJ2VU96eUZlc1FP?=
 =?utf-8?B?UWthR003RHBlaFcvdWNvR05Na0NPSDZRbUFyOEN3bXQrREtwNnk5aHdqNjk3?=
 =?utf-8?B?QmdRSXc4VnFxUHF0YVQxRlRRSmFvUjVjMjFOb1ZjbW5OdlcxU3UvUVlaU0la?=
 =?utf-8?B?bDZKT0FHdjIweGE0aE4yb3RtZUVkRWFPRUlyTE5qMWNHcVBKbWE5R3psd2hM?=
 =?utf-8?B?UXJOMU5qSTRBNkpQZlk3V2RNUWZ2MkcxRlg1b0hFdUVJVFd6SEFyN0huZjBG?=
 =?utf-8?B?T1NwSkxraFJ2SkpqS0h4V2c2dDVhdlh0RjZZY3kxK1NURnFIZkxFL0RLdnJB?=
 =?utf-8?B?UXRqN01CZmJaRWlXZFVzOHR6dG0zNURYV2QwVk9lSzl2amplYm9KendOS2NN?=
 =?utf-8?B?cy9UMkNLU05yZTQzZ281SFAwUUJWOGhQQnpFTlppOU1DWWZtY0lkdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3685464a-067f-4410-e82f-08df0e531a5f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8728.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 09:16:59.9780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N14ZNsaNsjb+xYmaWhpz7m4jHM8ovBk+caOVr2czDb5ouNE79ua+i0vHje+uxzsLU8npgRc0Xp6FnDn9R6KqEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8758



On 08.09.26 20:25, Mina Almasry wrote:
> On Tue, Sep 8, 2026 at 10:35 AM Stanislav Fomichev <sdf.kernel@gmail.com> wrote:
>>
>> On 09/08, Hengbin Zhang wrote:
>>> Hi all,
>>>
>>> Up front: I'm not a kernel developer, just someone who reads net code on
>>> the side, so please bear with me if I get some terminology or conventions
>>> wrong.  I found this issue while looking at the netmem/devmem code, and
>>> with some help from AI tooling I managed to reproduce it in QEMU and
>>> manually confirm the crash — I do believe it's a real bug.  Still, treat
>>> the analysis below as my best guess rather than a certainty.  Thanks a lot
>>> for taking the time to review this!
>>>
>>> One-line summary
>>> ================
>>>
>>> A TX (DMA_TO_DEVICE) dma-buf binding created with NETDEV_CMD_BIND_TX stores
>>> binding->dev without taking a netdev reference and never registers itself
>>> with any RX queue of the device.  When the bound device is unregistered and
>>> freed while the owning netlink socket is still open, closing the socket
>>> makes netdev_nl_sock_priv_destroy() call netdev_hold()/netdev_lock() on the
>>> already freed net_device -> use-after-free.  Confirmed with KASAN and by a
>>> real page fault / kernel panic on the same code path (log below).
>>>
>>> Environment
>>> ===========
>>>
>>> - Kernel: v7.3.0-rc1-00515-g9f0346dcbea3 (commit 9f0346dcbea3), x86_64,
>>>   with KASAN enabled; relevant config knobs are in the reproducer README
>>>   (link below).
>>> - Test setup: QEMU (TCG) guest, initramfs only.  The kernel image has one
>>>   local, test-only addition: a small stub PCI driver (source in the
>>>   reproducer link below).  No core net code was modified.
>>>
>>> Steps to reproduce
>>> ==================
>>>
>>> I reproduced this in a QEMU guest.  QEMU cannot emulate any of the in-tree
>>> NETMEM_TX_DMA devices (bnxt/mlx5/gve/fbnic are real NICs), so I wrote a
>>> tiny test-only stub PCI driver (source in the reproducer link below) that
>>> provides the same device-side properties: a net_device with
>>> netmem_tx = NETMEM_TX_DMA and a DMA-capable parent.  The bug lives in core
>>> net code, not in the driver, so this scenario should equally apply to real
>>> hardware — e.g. binding TX on a real netmem-TX NIC, then removing/unbinding
>>> that NIC while the netlink socket stays open.
>>>
>>> 1. Build the stub driver from the gist into the kernel (CONFIG_STUBNET=y)
>>>    or as a module, boot the guest with "-device edu".
>>> 2. Boot with the static "init" program from the gist (repro.c, run as
>>>    PID 1 in an initramfs).  It performs, in order:
>>>    a. DMA_HEAP_IOCTL_ALLOC on /dev/dma_heap/system -> dmabuf fd;
>>>    b. NETDEV_CMD_BIND_TX on the stub device (ifindex + dmabuf fd) and keeps
>>>       the netlink socket open; BIND_TX succeeds and returns a dmabuf id;
>>>    c. writes "1" to /sys/bus/pci/devices/<bdf>/remove, i.e. unregisters and
>>>       FREES the stub net_device (refcount drops to 1 in netdev_run_todo);
>>>    d. closes the netlink socket.
>>> 3. Expected: closing the socket cleanly tears the binding down.
>>>    Actual: use-after-free, see log below.  On a kernel without KASAN the
>>>    same path takes a page fault and panics (second log excerpt below), so
>>>    this is not a KASAN-only artifact.
>>>
>>> KASAN log
>>> =========
>>>
>>>   stub0 ifindex = 2
>>>   dmabuf fd = 4
>>>   netdev family id=20 version=1
>>>   nl got: type=20 ... genl cmd=15 plen=8      <- BIND_TX ok (dmabuf id)
>>>   writing 1 to /sys/bus/pci/devices/0000:00:04.0/remove
>>>   stub0 gone (unregistered); net_device should now be freed
>>>   === CLOSING NETLINK SOCKET (expect UAF in netdev_hold) ===
>>>   [   43.895794] BUG: KASAN: slab-use-after-free in
>>>              netdev_nl_sock_priv_destroy+0x196/0x1c0
>>>   [   43.896434] Read of size 8 at addr ffff888002f06580 by task init/1
>>>   Call Trace:
>>>    netdev_nl_sock_priv_destroy+0x196/0x1c0
>>>    genl_release+0xee/0x190
>>>    netlink_release+0x715/0x13a0
>>>    __sock_release+0xa1/0x260
>>>    sock_close+0x10/0x20
>>>    __x64_sys_close+0x78/0xd0
>>>   Allocated by task 1:
>>>    __kvmalloc_node_noprof+0x202/0x5b0
>>>    alloc_netdev_mqs+0x7e/0x1270
>>>    stubnet_probe+0x120/0x3c0
>>>   Freed by task 1:
>>>    kfree+0x127/0x3b0
>>>    device_release+0xc8/0x240
>>>    kobject_put+0x101/0x1e0
>>>    netdev_run_todo+0x5a5/0xd70
>>>    unregister_netdev+0x104/0x180
>>>    stubnet_remove+0x3f/0x60
>>>    pci_device_remove+0xa6/0x180
>>>    remove_store+0xcc/0xe0
>>>   The buggy address belongs to the object ... which belongs to the cache
>>>   kmalloc-4k of size 4096; freed 4096-byte region [ffff888002f06000,
>>>   ffff888002f07000).
>>>
>>> The kernel then continued in the same function and faulted for real:
>>>
>>>   [   43.905270] BUG: unable to handle page fault for address: ffff8880b0ef9000
>>>   [   43.927189] RIP: 0010:netdev_nl_sock_priv_destroy+0xad/0x1c0
>>>   ...
>>>   [   43.938987] Kernel panic - not syncing: Fatal exception
>>>
>>> Analysis
>>> ========
>>>
>>> The flaw is a four-step chain: BIND_TX stores a raw net_device pointer
>>> without taking a reference; TX bindings never populate bound_rxqs; the
>>> unregister cleanup that clears binding->dev only matches RX queues; so when
>>> the socket is closed after the device was unregistered and freed,
>>> netdev_nl_sock_priv_destroy() runs netdev_hold()/netdev_lock() on the freed
>>> net_device.
>>>
>>> 1) Binding creation - raw pointer, no reference (net/core/devmem.c,
>>>    net_devmem_bind_dmabuf(), DMA_TO_DEVICE = TX path):
>>>
>>>     binding->dev = dev;              // raw store, NO netdev_hold()
>>>     xa_init_flags(&binding->bound_rxqs, XA_FLAGS_ALLOC);
>>>     // TX path never calls net_devmem_bind_dmabuf_to_queue()
>>>     // -> bound_rxqs stays EMPTY; the unregister cleanup (which matches
>>>     //    queues) cannot see this binding
>>>
>>> 2) Device unregister - the only binding->dev clearing point is RX-only:
>>>
>>>     // net/core/dev.c:12395 dev_memory_provider_uninstall()
>>>     for (i = 0; i < dev->real_num_rx_queues; i++)
>>>             __netif_mp_uninstall_rxq(&dev->_rx[i], &dev->_rx[i].mp_params);
>>>             // scans the device's OWN RX queues only -> TX binding invisible
>>>
>>>     // net/core/devmem.c:537 mp_dmabuf_devmem_uninstall() - the ONLY place
>>>     // that clears binding->dev:
>>>     WRITE_ONCE(binding->dev, NULL);  // reached only when a bound queue is
>>>                                      // uninstalled (RX-only); never fires
>>>                                      // for TX bindings
>>>
>>> 3) Free - the binding contributes zero references (net/core/dev.c):
>>>
>>>     // netdev_wait_allrefs_any()/netdev_run_todo()
>>>     if (netdev_refcnt_read(dev) == 1)    // no holder left; the binding holds
>>>                                          // no reference either
>>>             free_netdev(dev);            // net_device freed while the socket
>>>                                          // and its binding are still alive
>>>
>>> 4) Socket close - teardown on freed memory (net/core/netdev-genl.c:1445,
>>>    netdev_nl_sock_priv_destroy()):
>>>
>>>     dev = binding->dev;              // RX: NULL (cleared in step 2);
>>>                                      // TX: dangling
>>>     if (!dev) { unbind; continue; }  // safe branch - never taken for TX
>>>     netdev_hold(dev, ...);           // UAF #1: refcount/tracker increment on
>>>                                      // the freed net_device
>>>     netdev_lock(dev);                // UAF #2: mutex on freed memory
>>>
>>> Full reproducer materials (stub driver source, trigger program, build/run
>>> README and the complete serial log):
>>> https://gist.github.com/hharryz/119f067937448ac6e30eb31e7f08dc5a
>>>
>>> I'd be happy to keep testing, digging deeper into the analysis, and trying
>>> to put together a possible fix if that helps.  Thanks a lot for your time!
>>
>> Hmm, this looks legit, I don't think we have a proper test for this
>> condition :-/ I can try to take a stab unless someone else volunteers.
> 
> Yes I'll volunteer to clean up my mess :P
> 
> My pet LLM suggested this not-yet-tested change:
> https://termbin.com/e4d2. It's trying to detect if there is a tx
> binding attached to the netdev at unregister time and clears it.
>
Hi Mina, 
There is a similar dev binding check patch for another reason (upcoming
data-direct support) here:
https://lore.kernel.org/all/20260810175446.3945358-2-dtatulea@nvidia.com/

If you get to send it before the v2 gets sent a part of data-direct support,
could you wrap the checking part as a helper please?

Thanks,
Dragos
