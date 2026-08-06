Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012013.outbound.protection.outlook.com [40.107.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7731712FF69
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 12:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786019550; cv=fail; b=HdeZq2wXYks3J6N4KpI5tWc2huVqaG4KKpjqZL5vAFGeM90ypra6SImK8kTpEze1haC+0EEAUVu/BftCsD8ZsmBPAScTn7z2G6ounybh1O/hveYzJVPA5k20QZbsjFS7QdUQMnEutE5aK/lSVokHk1mfw1MPLIyNwHK56W1QCa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786019550; c=relaxed/simple;
	bh=7QR5w5icraC6vml2Jut1TG3EogFr5nRK0KyQHLoY+GE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SI/FQmAbtI/B35VWsyBpH8+tU4xMb3ShOEtnSUO4nsoe+Bsv3aeQTLBL1BWcLz3dZSiPll9aT7BpY+O1Ndud1nfIrjELjmClJNIulfKqerR9AEyJMw2KGR26dBQuEkRu+0q8R9t05vFKpycApN1s2vcB/1c5IN/h+AadLXcPKG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=d4kvXkGX; arc=fail smtp.client-ip=40.107.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="d4kvXkGX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C1Zo9++ftB24ssXmh5vyql6e6p/ChtIBfSBL+nf+dgAYLLeyoCt9qdjQUTxK0GUx39ohd1nGdVKiiIN86E0juviJ42S8e+TTOGnEr6lNU5eyvL3hMmK3aZeZ39bof/KHSR7VQ+ZjVNI5o/o1OuaOibQxfZ6vb3wmqcX4rtPPsN+jwVmeB2tFY4Psx26YsTE7m7DS1uuTlFKxSyLW/Sa88KUOQXpln2vTU0OVNGXMOrJSYTEYAIZkxryLyZ1RcXQgf5/magjC8qzcyKXstuNfWK9RI9OTJqiPAMJPbAKici3i51voy9wjGfg7obmcvuSldGwYXRrCzDiraIkm8hArcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9ZnLsJfgmF+Sxy0rW/xAeDhvnmiDnahJAUkySikSSc=;
 b=T19B1Z4O8NY3u0CA+VSQTr1fLGU8XEd6f5nCsio47iLubz+Z8MI0CxCwF/+LXS31ZdiCFKzaKesuThBqO7KerDNDrofueLrbyPiib90E7KnAmxXhd2c54nkjAX74SYNFbaWWU9wclYjmo4IubelsN7muVz63/LdZoyA4aIRmufKflHtbMU/cXq0JuZeMKAa6104Ta31R7P08RtV40DQI/s8ahFMZg2wea9qfG8NaceZtPTgMS5r3sSJ1aL4ls3eCeaSy3UJQXoKz6yWX7uAs3aSsxo71HzHa5BiyNJenSyaGDyJu8CXqj8HfXSG5cJvErx4jCunt/kxL6HYi6OJUAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9ZnLsJfgmF+Sxy0rW/xAeDhvnmiDnahJAUkySikSSc=;
 b=d4kvXkGXWdPRmQApOR5kW4EzcXuVLVDAytUrpewirG3H57UBMVoCP3K6jhCH1I6+nPDMsTMK//byflooeyRBd72XwlSutKtpZ9TVMUBAt++DKKqE4LSsSPbYj+So7tnGBe+9PiSdkCiS05SlG/YsaIbxajen73YA0PWAvVuiQsuTNr3JA11w+txkq/AltWMQK8nxNp9rPUxYumix1+MYbiwM/sd+zPtGX1wwEiT/rIfbr9pi7axG9zCEku4XZi1dV1+SbEroQvwSjpZO09iu6MiouKpM8kYElRwVo/mizjOZ3GwJIHAvttDkrfg4BeA8gjkNvAUCE7WTntdDb5vYnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DS0PR12MB8768.namprd12.prod.outlook.com (2603:10b6:8:14f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Thu, 6 Aug
 2026 12:32:22 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0292.019; Thu, 6 Aug 2026
 12:32:21 +0000
Date: Thu, 6 Aug 2026 15:32:12 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: =?utf-8?B?7JWI64+E7ZiE?= <gomsoup@gmail.com>, nicoyip.dev@gmail.com
Cc: dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, sd@queasysnail.net,
	netdev@vger.kernel.org
Subject: Re: [BUG] ipv4: slab-use-after-free in fib_nhc_update_mtu() -
 unlocked walk of kfree_rcu'd fib_nh_exception on NETDEV_CHANGEMTU
Message-ID: <20260806123212.GA1868331@shredder>
References: <CAJzEm4pwK2rC=1YpA1XG3qCR5BPQ6O6oFY5=L5dDViKJN-jqbQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJzEm4pwK2rC=1YpA1XG3qCR5BPQ6O6oFY5=L5dDViKJN-jqbQ@mail.gmail.com>
X-ClientProxiedBy: FR4P281CA0264.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::18) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DS0PR12MB8768:EE_
X-MS-Office365-Filtering-Correlation-Id: 40a3db9c-0e97-4936-922f-08def3b6c318
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|5023799004|11063799006|56012099006|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	QMChxrWzeLtNhw7iAm0M/XVmuyc0WEjcRpj8c51WeQ9wbz9Nqi1zDGlX5xAb5wKwr4nzz5+V4lIWuLICwDK/qdecxNcPrHGVQJsO4vlIvdhQG+F+nmwQIsD7+cBq6iBToG7qheuOgO4vhf6SfeznK5bP0OGfde34abKJmYV5Pm0zTLsx5R583gBFdrxFL3pufwLPYad5dq8MdjWk7FJ1VbBWRDnc7iUHNS4cOmnGmAC3w2alhw2XnUnjVJgr9YRGuVGy+gmS+7crnTG3PTa4bs1d58G/IC5H+w8o7XBGmULubZsKH2C9U9YnsGruU6C5hXP8hCFiJnjw5M3De9s4qc6B/4cTL/TQlD4m15sotjYYBlaUTlL3ICkolwDGk81FehA9u2Va2RnInh8bA8jKm0Q5ktX+pXQCX5fTNwmVJ3RgFmjaucRxtr+E8FkJuVYf/JczmWenhs8VOjI2nCSOX1fFeNzv3++Eqc33IfMXzcfFV4x8im/3v3VQsj2/4R5bhscPw/BB81ELh444SCQqkjR559PGAozNyhatNKsWL4Y1LqTqr9iL8xl9pmtQF1CerKrEFj5zmAw7Ac00I/1cVrpftII/Po534+Gqdn2BGoFVuSlInJQLegfHUI4SybJUlNUASzFuYukXnMKqO9IBnChCvk7KWjKj+Z2NWIgOjjk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(5023799004)(11063799006)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z21nRVFyUDkxbHQrcHdMZXp5Y1MwMGR1LzNUUFh2SXFnRFAyd2c4aTNGbE9Z?=
 =?utf-8?B?RzdDWUNETkVhZ24zdGNHakFLRjN4d2g3VDFib2hYMGdaUHlCSUkyaDZxM3Bk?=
 =?utf-8?B?dW9rUWsvU3hiSVMrL043a3VMRm9UZ2trUkp0eUEvSllmV3p0ekptQVEwRzlV?=
 =?utf-8?B?MXdZNkFHNzdpQ3lNcWc4RjRyS0VFTld6OFFGTEdndlIveXdGbUVVSFJEbUJo?=
 =?utf-8?B?Q2Q2eEsrWVJrR0hWQmUwT3dBamQxaHl3S09OQkRCR0xyUHpERjhVMS9VN0h2?=
 =?utf-8?B?NCtxNDd4bGxrcHFLT2owSFlNZ05pWVNpZVl3dytZWExJRjVkSkdqUXJvNnpv?=
 =?utf-8?B?cmVXcjdoak12OXRncVNuNmI2QWgwL2FSZDAzREhkWVBJVnFwNUhYVkU2YURM?=
 =?utf-8?B?SzBJNFZXck1wYlJHM3lING04UUNpeDF5bDRDbEJpcVh5R3ZNYjR6K2RUM2lq?=
 =?utf-8?B?MGxpNER3Sm1hT05uUDBraHh5WUpsRnQxRGdBeDFIRVhibVhWVGliL0NXVFBN?=
 =?utf-8?B?RkRuZHNScExLcnZ0UW16WTFDUHMxQ0tBM0RodnhhOTcrL015eTdPV2JFZyta?=
 =?utf-8?B?VGc2YUNJbjgzRjVnVkd5TzZudmtxSmJ4VDhwc3ZNTFFWL2R6WVFNWFFteEpw?=
 =?utf-8?B?ekZRbjRxRFQyTGkxV1hTejZmd3d6aGIrMWVWOTBNelhvY3cxVlpGLzRxTnV2?=
 =?utf-8?B?elZHYVY3azZobGVYckZSZGJwc25FVXpJdUdQeDVVU0I1V2E1NEU1YitkbWtP?=
 =?utf-8?B?ZnMyZ0YwZ3I5L1R3MnU4TDZQUllNWmw4U0F0RWJyZjJSZnpFeW5aMmMxUzRC?=
 =?utf-8?B?NE56YUQvUFk3dDNmeDNLR25MZGtqNGQ0am9KTkE3YUhMT2tCa3JvMlNxUlJW?=
 =?utf-8?B?NHRRbVN5KzgrYUVMcnFYa3QrQy8zTllKZWs5NWdrNzhlay8waWRtU0x1Q1hU?=
 =?utf-8?B?Qm5ZUEM2ZFJwOWFYdTBGcm5LSkFCK21vcXFXaWZheUU1QlpBL3JwMi9QQjVB?=
 =?utf-8?B?VjNGZEVJUkRFcVJQOUN3YXNMdm1mZ0tyV2QrUzhib2hOMFBtRzdkUHdscWJj?=
 =?utf-8?B?bC9HVWlOTTQ2TzRPdkFVandyWTNwZVpwbTlLekZDaG9DRG9LTkVnSXJlS21T?=
 =?utf-8?B?ZytLeTNaZnNlN1hJZHJvWEhIYTF0UU84QzBPMkZqZTNHREx3Vjl1OGZCVHRq?=
 =?utf-8?B?NkJDRTVHNVM0YnRwdVpvOUlsYi9IcU4vMDhodERrT2JHNUwzZTBpWXUyZk5Y?=
 =?utf-8?B?MitJZXhqR1NLYmRtZURrTUtuRlp3czdVYjQ1R3N0dWFPZVN6ZFJVYWNaYUJj?=
 =?utf-8?B?M1dsV1duWHVOMFZQZ2dwY2hYZkFIMm9qZTRXQmtKR21TV0xhUEx4WnZ2MmV3?=
 =?utf-8?B?R0tYZVVYMjhQNHlJSk1XRXlzdHNMWkt5SnZUNHlBUG9nNXArdW1ReSt6d1NQ?=
 =?utf-8?B?U3k4emd2bkQ1L2JlZUdqbVRNWkdpMko3c2xybk9LMXZhaFVHT25rTFVRRnJh?=
 =?utf-8?B?RGo4TGtGUDJqd21GYVVWaU9VTVJZRlFXcklNMVdLU2lJWFpzUitBTlZ5aENP?=
 =?utf-8?B?Q2U5Wlc0Uk0rTEdKb01teWlwSkNYb2VTYzgrYTN0K0cwNG1ZSkxycjZPUngr?=
 =?utf-8?B?eEVRVEdzTlAzK0pGM0t2OTNDRWlwWlF6ZGVIemM4WmNtNjQ3ZHBBM2ZaaHJD?=
 =?utf-8?B?clZZQWY2TzdTa0IwYVdMWUtXdHJTVHlsTTFGdk9lSElxWE0zQkFkTnhpdlBy?=
 =?utf-8?B?bmI0U0l0RlJ1R2Q4S042QjBuY2xhMkpEOW01NWllMzBmbThGcVRrT2F5R0xZ?=
 =?utf-8?B?Q2RHaWRKNCtGcWFnQWF6RFNNN0k5MDZmTlE2N2hsTFh1V0NxS3UwcTFiWlUx?=
 =?utf-8?B?bmVqZVdTNGs5a3hOKzRLeWpJSWI2U2ZUYUhMVWVQRWhBV2FXSUI1Z3NyS1BX?=
 =?utf-8?B?Vks4TnJUdGgrSHRyRG82VEd2WXAySW93Z3RMQlFaYmRKdWg3bXZkaFVXT0ox?=
 =?utf-8?B?MWVvWTZ3ZmFGcXNuNFEvTmQ1ZnZWUHFiamNyN091TFhjeFRvNERpWVZHRUVl?=
 =?utf-8?B?WUpiVVpVMTZ4WjVUaUJXaGRzUnlCNzMvcDZFdkFTNGpBUzRPajlRSDVDRnhX?=
 =?utf-8?B?dzQ0ZnI1eXQ2S0J5U2s4T29ZR1dGWTljZERmR3p0SDVCTFBITGZIYWJpSXlw?=
 =?utf-8?B?c01yVXdLbkIvWXhhcTBKZ284WUFVK2lzNlE3eFQzK3FucXg5bFZHM3ZjRDI5?=
 =?utf-8?B?aUpYcVIyOU92RUtYTm5VSmFHMEpSVENhcm13RDhkTGJDZFNVSHNLejR0YUhS?=
 =?utf-8?B?VWVZdWtPSDFyS2dySlozYk9BWDRJazB5Y0hITU5YY3p4VFZsZnkwUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40a3db9c-0e97-4936-922f-08def3b6c318
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 12:32:21.7621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nRaxVP+WUXvHc/XeNuFz7YzAHQGZwQL3lYHGRR3XlqLmTOqDGT4MhgGR1HgUQLaRJep0eiRfe6hszutXRWmFgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8768

Please send plain text emails. HTML emails are filtered and don't make
their way to the ML. See a comment at the end.

On Thu, Aug 06, 2026 at 03:07:27PM +0900, 안도현 wrote:
> HANDLING NOTE
> =============
> This bug was identified with the assistance of an automated (AI) code
> audit.  Per Documentation/process/security-bugs.rst, an AI-assisted
> finding must be treated as public, so this is reported in the open and
> was not submitted to the [1]security@kernel.org embargo process.
> For the same reason, I am not including the reproducer in this public
> message. I have a tested source reproducer and will provide it privately
> to maintainers on request.
>
> SUMMARY
> =======
> fib_nhc_update_mtu() traverses and writes fib_nh_exception ("fnhe")
> objects using rcu_dereference_protected(x, 1) -- asserting a lock is held
> -- but its only caller holds RTNL, not the fnhe lock, and is not in an RCU
> read-side critical section.  fnhe objects are freed with kfree_rcu() from
> softirq under fnhe_lock, so on a CONFIG_PREEMPT_RCU kernel a grace period
> can end mid-walk and free an fnhe the loop still dereferences.  This is a
> slab-use-after-free (read and write) of a kmalloc-96 object, reproduced
> under KASAN on 7.2-rc6.  Present unchanged since v4.19.
>
> AFFECTED VERSIONS
> =================
> Introduced in v4.19 by:
>   af7d6cce5369 ("net: ipv4: update fnhe_pmtu when first hop's MTU
> changes")
> which added the loop (then nh_update_mtu(); renamed and exported as
> fib_nhc_update_mtu() by 06c77c3e67b0 "ipv4: Rename and export
> nh_update_mtu").  The unlocked walk is identical from v4.19 to mainline.
>
> Reproduced on:
>   Linux 7.2-rc6, mainline commit 075b74841bd0, arm64, KASAN.
> Present in current mainline (fib_semantics.c fib_nhc_update_mtu()).
>
> THE DEFECT
> ==========
> net/ipv4/fib_semantics.c, fib_nhc_update_mtu():
>
>     bucket = rcu_dereference_protected(nhc->nhc_exceptions, 1);
>     if (!bucket)
>         return;
>     for (i = 0; i < FNHE_HASH_SIZE; i++) {
>         struct fib_nh_exception *fnhe;
>         for (fnhe = rcu_dereference_protected(bucket[i].chain, 1); fnhe;
>              fnhe = rcu_dereference_protected(fnhe->fnhe_next, 1)) {
>             if (fnhe->fnhe_mtu_locked) {
>                 if (new <= fnhe->fnhe_pmtu) {
>                     fnhe->fnhe_pmtu = new;
>                     fnhe->fnhe_mtu_locked = false;
>                 }
>             } else if (new < fnhe->fnhe_pmtu || orig == fnhe->fnhe_pmtu) {
>                 fnhe->fnhe_pmtu = new;
>             }
>         }
>     }
>
> The "1" asserts the caller holds the fnhe update-side lock.  It does not.
> The only caller is fib_sync_mtu() (same file), reached on a device MTU
> change:
>
>     NETDEV_CHANGEMTU -> fib_netdev_event() -> fib_sync_mtu()
>     -> fib_nhc_update_mtu()
>                                                                              
> and call_netdevice_notifiers_info() (net/core/dev.c) runs the chain under
> ASSERT_RTNL() only -- no rcu_read_lock(), no local_bh_disable().
>
> fnhe objects are created and freed under fnhe_lock in softirq on the
> ICMP/redirect input path:
>
>     __ip_rt_update_pmtu() / __ip_do_redirect() -> update_or_create_fnhe()
>       -> fnhe_remove_oldest() / ip_del_fnhe() -> kfree_rcu()
>
> RTNL and fnhe_lock are unrelated locks; RTNL does not exclude softirq.
> Under CONFIG_PREEMPT_RCU a process-context loop that never entered an RCU
> read-side critical section is not an RCU reader, so a grace period may end
> mid-walk and the kfree_rcu() callback frees an fnhe the loop is still
> dereferencing.
>
> fnhe_lock is static to net/ipv4/route.c and not visible in
> fib_semantics.c, which is presumably why the code used the constant
> assertion instead of taking the lock.
>
> KASAN REPORT (7.2-rc6, arm64; timestamps removed, stacks trimmed)
> =================================================================
> BUG: KASAN: slab-use-after-free in fib_nhc_update_mtu+0x78/0xd0
> Read of size 1 at addr ffff000016596794 by task payload/100
>
> CPU: 0 ... 7.2.0-rc6 #1 PREEMPT
> Call trace:
>  fib_nhc_update_mtu
>  fib_sync_mtu
>  fib_netdev_event
>  call_netdevice_notifiers_info
>  netif_set_mtu_ext
>  dev_set_mtu
>  dev_ioctl
>  sock_ioctl
>
> Allocated by task 99:
>  update_or_create_fnhe
>  __ip_rt_update_pmtu
>  icmp_unreach
>  icmp_rcv
>  ip_local_deliver
>
> Freed by task 27:
>  __rcu_free_sheaf_prepare
>  rcu_free_sheaf
>  rcu_core
>  handle_softirqs
>
> The buggy address belongs to the cache kmalloc-96 of size 96.
> The buggy address is located 20 bytes inside of freed 96-byte region.
>
> (struct fib_nh_exception is 80 bytes -> kmalloc-96; offset 20 is the bool
>  fnhe_mtu_locked read at the top of the loop body.)
>
> CONDITIONS
> ==========
> - CONFIG_PREEMPT_RCU=y (all CONFIG_PREEMPT / PREEMPT_RT kernels).
> - Concurrency between a device MTU change (the walk) and ICMP-induced fnhe
>   churn/expiry (the alloc + kfree_rcu free).
> - Reachability: SIOCSIFMTU on a device carrying routes with exceptions
>   needs CAP_NET_ADMIN in the device's netns; the fnhe population is driven
>   by ICMP "fragmentation needed".  Where unprivileged user namespaces are
>   permitted, both are reachable by an unprivileged local user via
>   unshare(CLONE_NEWUSER|CLONE_NEWNET) + /dev/net/tun; where restricted,
>   it requires CAP_NET_ADMIN in some netns.
>
> REPRODUCER
> ==========
> I have a tested C reproducer that triggers the KASAN report above on
> 7.2-rc6/arm64, typically within seconds.  Per the handling note it is not
> included here; I can provide it privately to maintainers on request.
>
> IMPACT
> ======
> The demonstrated result is a KASAN-detected read, and a write of dev->mtu,
> to an RCU-freed kmalloc-96 object (a memory-safety violation).  No
> privilege-escalation exploit has been developed or demonstrated.
>
> MITIGATION
> ==========
> Restricting unprivileged user namespaces, restricting creation of network
> namespaces, or denying unprivileged access to /dev/net/tun reduces
> exposure to unprivileged local users.  None of these protect a context
> that already holds CAP_NET_ADMIN in a network namespace.  (I have not
> verified that these fully block every path.)
>
> PROPOSED FIX
> ============
> fnhe objects are freed via kfree_rcu(), so an RCU read-side critical
> section around the traversal keeps them alive for its duration; fnhe_lock
> is not visible here, so this is also the least invasive fix.
> Best regards,
> Dohyeon An

Chengfeng Ye sent a fix last week, but looks like we need v2 which
acquires fnhe_lock for the per-entry update (while still using RCU for
the traversal).

https://lore.kernel.org/netdev/20260731162938.3388534-1-nicoyip.dev@gmail.com/
