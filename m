Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011058.outbound.protection.outlook.com [52.101.62.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDE84E73CA;
	Mon, 28 Sep 2026 16:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790613352; cv=fail; b=M1VG6Q+IIO5bFO3hlyWY48TjyXAYbq33jt8NAuMbZV4aEq4ePOzG7bz1nZw5qTcm90K8eiNxJQNh3sf8fZMislqMJ3DO4VHO9sawbZpG/uRNB5SqxPZ4i5p4JGz/HIz8tk6kb76M02RE1B3CszR+8EDuncYF1FjbDkgAGZF0szI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790613352; c=relaxed/simple;
	bh=ioWNoseqr5/QAoNSIA5B3+Ge3qSJQrmQR4EtZ71fpfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZkLqAWW1AevfK6zk+faWX3m54a3EQ8AfFegT1TAO0jCKxfUgJ6gynyNLDgBdhByp1UxP1VTioOuOhekUZDcsOCu+4UmH2Oq0HGEC3gDasRAqFur0mqfp0jTAupUHGJcLhr8B2s/XE3uBv95XOsGPwrTBzWEFlz57iMOtc8xPC3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lIjj+WmJ; arc=fail smtp.client-ip=52.101.62.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lIjj+WmJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KjgCi7MTvgIq8UCN8eHnpttGMdNFh8/wU18u0nUHVQbqn4TblVOnMiNrf1vEExEuh9Xh39iEuMV3dzYjzTRtNV0judrhAFzwIX8J9IQoMvV4N2xs407jA7pAMpZSvcRczhZ6Og4B2FgG1p6hNFIuhnjPP90HRQHD05yhB/E5dzg7L+p6kL+jTBpw/fX1Od9D9aGVXfIZyUpTUKL92IFF3OE4lDJPmizsKGa0QqDy9J9iUZYgtmkNM7ONzS7i5Uiit8MRiP8nZy9chxOhJqomAmJLbsW9yjNYuIzvjDdV1R9pkr02KKbLJU6h+E3bHeCPTf2ZbGKrWNx5VxYGXIZ1KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hzOYSMeoq4P+PkN3FQnMr1QB/jlLlyh3NZUAJTPiYGw=;
 b=oSP1XlAFeqMhKBEK5FC/i9BD+HSO9w3uPHszL9HfeO72X8Vmsn0chMhdCeYkat8aqLdgfZnnriACGGW3fptI1Icr/l9GlQ97/xtgGfM+XKeirD6q7NCQho6uQCo94U0iHeAyll49flZ3NvGlKfww0l9p7phqdeOOAci7aAHgVX2fuoDKKjQj/RnNKakjZaJTzB1Teu5DPkAPY4s0DGjbGakoq6ZGtIp0lniixhf00pxfmaXf6Mbbej0loTgE2BxDRIdx7OczYR/sTT726fBWC9BgXlF1HwMDVgerr1qqQvdCCe5ZBqZveWxvavl05OLaYfM7XRikOuQhxthzrsZ8Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hzOYSMeoq4P+PkN3FQnMr1QB/jlLlyh3NZUAJTPiYGw=;
 b=lIjj+WmJ4iRyjYvQum9wYmIJaN1IKI+pNS2Z0YDoIb/VpTtrXQ7PYhfPRYpaftfQblMJ/2Nk8R0BG1sn/qdyCzfdSLvzmF24QNylXePZwMaubfp/91z397rmY/7iPTa7QZrGekB/+ppmQPRdTGqHg3ozUERIHNH9SL/2HNp2Di0M4bwF3py0qw9rXauY6G47Fa7ljBfBY6Ypd5GpZOuuf2Vgr+U5owpEXKe0DRCOGE3Ej3ueafyxwx6BqHNX0yXQGdkVG+4V+vnpAcyodq2T4cr+bjesF0cBBfnJ4bxocNduMO1dCYGKZ2y5cjjtfxNJWaX7RLKI3Ds1wI53Ro9J8w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 16:35:37 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 16:35:37 +0000
Date: Mon, 28 Sep 2026 19:35:28 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: AnishMulay <anishm7030@gmail.com>
Cc: pimyn@google.com, dsahern@kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+ded267b328e950a7c0c4@syzkaller.appspotmail.com
Subject: Re: [PATCH] ipv6: addrconf: drop "BUG: " prefix from pr_warn()
Message-ID: <20260928163528.GA568589@shredder>
References: <20260807131300.2677228-1-pimyn@google.com>
 <20260810095136.GA2582170@shredder>
 <CAJWNTGyLJubRHn2KbqQMeV_jqexSgaLbzTe+xJnGzUw=RUtntA@mail.gmail.com>
 <20260810103517.GA2626301@shredder>
 <20260908043143.120335-1-anishm7030@gmail.com>
 <20260909115655.GA1344764@shredder>
 <20260927175134.1909-1-anishm7030@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260927175134.1909-1-anishm7030@gmail.com>
X-ClientProxiedBy: FR0P281CA0081.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::7) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|SJ2PR12MB8690:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d33f14e-a268-4783-e3c4-08df1d7e86f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|10067099003|11063799006|6133799003|22082099003|18002099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	WTsCecVx9GXY4d5RzI0esHSFIhnnmLmuXA3tzYQbhbxo3Ew8H6MZ34GnhfnZ+JfO19McyEqpOV36+Fn57/9LI7W7yiwb8GzVOJiiaIOiNsmKWpjYrjqsL1hBUAJzXaiGDqFJ96EpkQpGaNgw7Di15b13JBFYES3S3vne46ydCu+JVtFGAcCzBmvgRA5XxdSyy4284hEqxjQHAmG+EpKWJOxDDxTLt6/LjKAFm5owos7wvx7yy+ewQ2yDqB0hf7x++6vAbsLfKE5EnNEp6MdlsykFeeleYH9D0FaE0ixDNtiTcKjaBAJwC1yqK9t9tJZBD1C7kaFhB7mPQUaOfMjZnLyRhraZSqtll+nvcvtRmLshdw9JW30z1VvXNm/IKkrcIqZnJ5ESA0NYHYpUoszIqQprJF5I9LRfXb8WImocuRqw/OaE0pnTi/dVJdFn2AVArL7GkFPmTQtE03pts5qwS6WFSWp2M2CsOz5//ojBOojPyV77vmwGYATLhIEhChX9r8BeQ58d5biQG4cDOzrIKEWiFT6ZTmMPoe0wEDqghoUd+wxcp29BmllJ0ZggGxtTyPFsS8ywNDIJl9SARggszi2DJ2hUVN5bKCMufkz3Gxo11gvsgTkZib9dkLfvp7FgExsFqKdHc+5+QApH3fl7jUfxOjLUrsFle2fivQGEX3g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(10067099003)(11063799006)(6133799003)(22082099003)(18002099003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?akl1YTlNMmVHRUQ5QU5iN0dYNHNJclQ3N3Rtb0FuSVhCeVY5Nlo0RkE4TXZ2?=
 =?utf-8?B?OUExelFDMVNDWGJsNktublcwY0pOajRQdVhjWVNrZk1QelpQdzNWcS8ySmhE?=
 =?utf-8?B?alN3S3ZvdGk2c0FzRFhObC9aRURXWUhDaWJqQTRWOFZteU4yVFdkWnZJd2dn?=
 =?utf-8?B?MXk5UGY5QmQ2NUwxSW5yOEtiZ3Y3c3R2RVJIRGJmM1NtRXdFZ2piczFEdXNq?=
 =?utf-8?B?RXVFd0ZuNXozM3g1TnovUWE3dmwyKzd1eUlNUkFjK25CcnYrd1ZLWEUxTmhE?=
 =?utf-8?B?SW5xSXRVUC9vaGVsQm93bkNHNWZaRnlhaWxXZFUyRklwQ1QwRlpzdjlFR2c0?=
 =?utf-8?B?cHRxaE8vTHJVOWJoRGlFMXZmNTFSL0dwejFjQ1VDR2o2alFsQTJqZUJjQkh4?=
 =?utf-8?B?VDR2ZFJobU01bFNTY0dqQlB2Zmc3RG1CL0h2TktCNlBSZXVDVG5HTDhDbUto?=
 =?utf-8?B?ZTFVY0pWb2NOS3JkUjBQZkxmS2Y1Q2RERDdoQ3k0aTAzOWNNbnhWMXd0TFhH?=
 =?utf-8?B?VDdyUUsvSEJubDErRXQvK2R2YytQY2VzVlRjcG1XeFAvU1VOTExJVnI2QmFo?=
 =?utf-8?B?dmcvekdERStwcnVaQjVkc2ltVHhkdHkzZS9BK2lqS3laclZhblA2U0owM1FU?=
 =?utf-8?B?aG44YTRsM1NUSzJ6dWYwQUwwRjMyNnFsVDRxSkVveU40ejQweDNQRW9MdStV?=
 =?utf-8?B?UUtDYTlpa0JqN21BZGNQTGxoSWZCanhlYW41RGdYbjQ5TTZkYnIxQWdac0wv?=
 =?utf-8?B?VitadlRXWWxTNnNWTTA3cVN0a2I3T3JPclZuRjdlRGRUdDlEQ1F0ZTFZVk5T?=
 =?utf-8?B?VmhwM2s5dzJKWWpMcEJjSDZZSTh5T21DUm9XVkZrcUFSSW04VU4wdXpSQ2FY?=
 =?utf-8?B?M1RPMVM1U2QwOXgxU0tOdDB1ZkJmY3l5eFlDYUt4Y1dVaVFyYXNoWWZrdFBn?=
 =?utf-8?B?TDJkbHIzYUViNkx1WmQ1d0kybzA0ZDVDQkNqZlR4WS83WmJYWHBzbzZUeStr?=
 =?utf-8?B?NEpGdmdCRld6UUJtTjkweCs4MXRtR05jc1pWb0kxajVSTzdzaGdXZzFzWFNW?=
 =?utf-8?B?ajNrWEgyNjJnclFiUmsyQnJuenBDM1BEWWN1cEVmRTRraENkb0hSL0pJQmFV?=
 =?utf-8?B?NEJIUzAvOWwzNDd6eit1eGFJRDZpOW9DbkFvNXJrUEZWMGtxVlNHVTkvRXhu?=
 =?utf-8?B?L1FpTGFFUG9mWCtZcEt3OWhRQXMwTHp4YUV6UUxxaTZvMG9jVDlPWXNpME1L?=
 =?utf-8?B?dm9tdHVia09qeC9XS3NHVk5VNkpvOWh2UU0wMHVXa3JrVWNWUjVSeFFZaVNV?=
 =?utf-8?B?ek9XMkJicEw5cks5bXE4bUNDaEZ0eXViS3phcTUvR2U2NnpCZi9CRUJTQ1RT?=
 =?utf-8?B?M2h2ZVJLaWpPOXZXK3NIZ2UrMzEvcTlBNnJ5TVB1bWRjS1JiZGJTdEpZS2tD?=
 =?utf-8?B?SE9aVGZOTmhWZ01tTmhPeDBsZDdJUWlHTm1YZGgrM3lnQjBBZWI5cGd0OG1L?=
 =?utf-8?B?NzZDdUcxOUtkdEJvTUYxeExYTXNGQmtwWTREcWJqNTBDNUhtRVJXbmhLTVRC?=
 =?utf-8?B?ZDdtYXpTbXVwQmpheHNPVTdwaWhaQm80WjhQaGdwbHE2Tmczb0VtS0Ixcm1z?=
 =?utf-8?B?M3Y4SjdueWtqcFFqQkZPbmVHeVRONStzQllFeWZjUFFHZG1Wbk1jV2Z2c1VX?=
 =?utf-8?B?RjZRWU0xNjVjaVBtaW10ekJjWjQvL3c1WUY1NkVpdXZJa1hSY01HeVVxaVhu?=
 =?utf-8?B?Z1dtR2hYOUdYQ3NlREd6RGVKWGQvL1ZmOWUrT1l6cEdWQ2ZtbXR4VWdnalJp?=
 =?utf-8?B?Z3M1RXRtYVNGTEVhMWo2ZkdmazNRSThXcDA0dE5TUi8zd1RLQjV5Uno3OTJM?=
 =?utf-8?B?eG91VXpSMUdhS1RXOFZYTE5WTW10c0hoYi9qU2N6YUxvVFhkVHh6bUs2cElo?=
 =?utf-8?B?Y0VVMWdwS1lQNFVuZWhTZ2lnNkEyczBZYnFmVlJiVnU0WjNJMERSbmpCMWhk?=
 =?utf-8?B?ZnF1bGd5VEpPaWxNckNPblFHb2Y5SzZETFNKQjFZWi90amd3dGQ3U2YyWTVi?=
 =?utf-8?B?Wjl6V1lZOEJRZ3JQYWtnOERwaUszc01WYUlUYUovVlkzNkpRYzE4cUVzbElq?=
 =?utf-8?B?S201RGZGWkt6VGlLbEpuZkNBeTVVNXpSR2tVU0FlTUlHR1I4RjBHZ3lIOU5Y?=
 =?utf-8?B?MmdlUEhoZi9nYXBaeEdFUUVzVDE3dnJjRzNxOFBEUVdZU2Q5Uk5RMG1vUERU?=
 =?utf-8?B?UXdNb0hRTjJ1VUpZNk9ZZEZXbVNUOGwwV3d2Y3k0RURHQVBNQWd6aFRIYVA1?=
 =?utf-8?Q?hJ9nwimIjB5/FKsHPx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d33f14e-a268-4783-e3c4-08df1d7e86f4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 16:35:37.8333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MBYlI7YF5gJuQkdHfBuvGBWzimNKb5BaTsKV8lv6LWAykabv/eXt305jwuONp17nm5RFfReyBa7g5iMK3BWlsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8690

On Sun, Sep 27, 2026 at 01:51:34PM -0400, AnishMulay wrote:
> On Wed, Sep 09, 2026 at 02:56:55PM +0300, Ido Schimmel wrote:
> > Does your reproducer rely on both keep_addr_on_down being set on the
> > loopback device and its MTU going below 1280?
> >
> > The loopback device retains global addresses when this happens, unlike
> > any other device [...]
> >
> > So, given that this state is quite broken and unlikely to be used by
> > anyone other than fuzzers, I would like to simply align the loopback
> > behavior with other devices and avoid keeping its addresses when the MTU
> > goes below the minimum:
> >
> > [...]
> > -	if (!unregister && !idev->cnf.disable_ipv6) {
> > +	if (!unregister && !idev->cnf.disable_ipv6 &&
> > +	    dev->mtu >= IPV6_MIN_MTU) {
> >
> > Regenerating the route in this case is more complexity for a case that
> > nobody is hitting other than fuzzers.
> 
> No, mine does not touch MTU at all. dev->mtu stays above 1280 the whole
> time. My trigger is a second addrconf_ifdown() racing the pending
> addrconf_dad_work from an earlier up, both inside a single "ip link set
> lo up" call (that fires both NETDEV_UP and NETDEV_CHANGE through
> addrconf_notify()). The route gets deleted, the notifier gets skipped,
> and the async work later runs with ifp->rt NULL.

Please share your reproducer. Earlier in the thread you said you're
working on [1]. I asked Claude to translate the syz reproducer to bash
and it came up with [2]. It does set an MTU below the minimum on the
loopback device. I verified that the issue is reproduced without my
patch and doesn't reproduce with my patch.

syzbot was not able to test my patch because of some issue on its end.

[1] https://syzkaller.appspot.com/bug?extid=57f410c9a4f8d7a441d6

[2]
#!/bin/bash
# syzbot 57f410c9a4f8d7a441d6 as iproute2. Run in a fresh netns so the
# group-wide MTU change only reaches lo.

ip netns add syz
ns="ip netns exec syz"

$ns ip link set dev lo up

# 1st sendmsg: RTM_NEWLINK, no ifindex, IFLA_GROUP=0, IFLA_MTU=68
#   Walks group 0 in registration order; lo is first, so it is already
#   at 68 when a later fallback tunnel (sit0, min_mtu 1280) makes the
#   whole request return -EINVAL. syzkaller ignores that, so do we.
#   -> rtnl_group_changelink() -> do_setlink() on every group-0 device
$ns ip link set group 0 mtu 68 2>/dev/null
$ns ip -d link show dev lo | grep -ow "mtu [0-9]*"

# write(.../conf/all/keep_addr_on_down, "1")
$ns sysctl -wq net.ipv6.conf.all.keep_addr_on_down=1

# "repeat":true — the whole program loops; the warning is a race between
# the DAD work queued by fixup_permanent_addr() and the tail
# addrconf_ifdown() in the same NETDEV_UP, so it needs a few iterations.
for i in $(seq 1 20); do
	# 2nd sendmsg: RTM_NEWADDR 2001::fb/64 dev lo, no NLM_F_EXCL
	$ns ip -6 address replace 2001::fb/64 dev lo
	# SIOCSIFFLAGS lo 0x1, then SIOCSIFFLAGS lo 0x0
	$ns ip link set dev lo up
	$ns ip link set dev lo down
done

echo "warnings: $(dmesg | grep -c 'missing its host route')"
$ns ip -6 address show dev lo
$ns ip -6 route show table local

ip netns del syz
