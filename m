Received: from smtp.uniroma2.it (smtp-2015.uniroma2.it [160.80.4.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859151A6813;
	Fri,  9 Oct 2026 00:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791506664; cv=none; b=SbfG5tV/ik1iBipj/meXlaPnFCx2kRiWeMa0AHREc5CVaDdfMNa1I7umwe3Kb2LxR3oi69u7WRU2yRel6xY+mkebY3cwNlwjVlNZlSDqmgzcBWwb+EjEvrbyMtnSGRxhPnr9sEjC5Tk9YFF7UjZF5viyhmVEVgLnqJxJ/hIdGtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791506664; c=relaxed/simple;
	bh=ruHQ1v6y7YbeNJQ3BAD2JyXsdoS/WE1mBq/WkG5ZABE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=NXiXFPrzETpDBYHtPZEcByGAWiCxq9briix9XLq1+aahMZTZIPdStJkIK0Ebp+k3KPeJlS60rKYBQ4igpIor+zCinAUsKXgeMg6HTx1THQu9qL20XX+MrgDR59pCy7XJaL+OWlfZqcEh6E3N+KbM5paO//LCGiRaRaZJL2jQWxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=lmqSzsIl; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=rolgY+DV; arc=none smtp.client-ip=160.80.4.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="lmqSzsIl";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="rolgY+DV"
Received: from smtpauth-2019-1.uniroma2.it (smtpauth.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 6990hj3L028193;
	Fri, 9 Oct 2026 02:43:50 +0200
Received: from lubuntu-18.04 (host-95-234-228-71.retail.telecomitalia.it [95.234.228.71])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id A5E931209E1;
	Fri,  9 Oct 2026 02:43:41 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1791506621; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q6+fKhnwx/9PKbNPNVfapk1JYVlsb79bFcTKLskWK1U=;
	b=lmqSzsIlbOqCWRSBVPMzCRPQPsjriro3LDH063mmnKqykoJMdpJrlgBbQZbwaQVN+PbSoi
	GR6fwT4KyJuY1ADg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1791506621; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q6+fKhnwx/9PKbNPNVfapk1JYVlsb79bFcTKLskWK1U=;
	b=rolgY+DVAa7rHJ9DpskhfmqYuKS6oBEov2LtfU/XDOB8+K2oI3yWmz6OF51u1GjXdeaBPO
	u9bbJIe8lYA8DbDIKIfvW/R9TQJZHdl4WXV95f/rXemwt2XQjPMXZ4fS2g2VltN3NaVCBF
	ugSoOUqYjFru6Uo2uN9oie1oFysYD6ofGBBDWeA0p8fgrQbB1nciQ8Jx4P4ZosETbba3JL
	aZh0qgduhrSZbDFTusjmtb19chA5PxoZnEgjw24PrxdZTtYiABMTqzPWcsWTQ677WjHPO/
	l1EZFeQKIHWGFj/Tvs5viMNelwauu+f6pAIs3xSndhlHM4+boYL+UtAN3XdG+g==
Date: Fri, 9 Oct 2026 02:43:41 +0200
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        stefano.salsano@uniroma2.it, Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: Re: [PATCH net-next 1/2] seg6: skip the route refcount in
 seg6_lookup_any_nexthop()
Message-Id: <20261009024341.687e7226cd6abca80e779fda@uniroma2.it>
In-Reply-To: <20261005-seg6-lookup-noref-v1-1-092e84774e80@gmail.com>
References: <20261005-seg6-lookup-noref-v1-0-092e84774e80@gmail.com>
	<20261005-seg6-lookup-noref-v1-1-092e84774e80@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean

On Mon, 05 Oct 2026 14:31:53 +0900
Yuya Kusakabe <yuya.kusakabe@gmail.com> wrote:

> ip6_route_input() attaches the input route to the skb without taking a
> reference, relying on the RCU read-side section of the receive path.
> seg6_lookup_any_nexthop() is called from that same section, either
> directly from the seg6local input handler or from a netfilter okfn,
> but still takes and drops a route reference for every packet.

Hi Yuya,

Thanks for the patch and the throughput numbers. The Sashiko review asked
whether this also holds for the BPF callers in filter.c. Under
BPF_PROG_TEST_RUN the call does not come from the receive path: LWT_IN
programs reach seg6_lookup_nexthop() through bpf_push_seg6_encap(),
bpf_test_run() runs them many times on the same skb, and the RCU section
can end between runs. With the patch, on 32-bit ARM
(CONFIG_PREEMPT_VOLUNTARY, KASAN):

  BUG: KASAN: slab-use-after-free in __seg6_do_srh_encap+0x3c/0x52c
  Read of size 4 at addr c46b8100 by task bpftool/119
  CPU: 0 UID: 0 PID: 119 Comm: bpftool [snip] 7.3.0-rc5 #1 VOLUNTARY
  Tainted: [O]=OOT_MODULE
  Hardware name: Generic DT based system
  Call trace:
    [snip]
    __seg6_do_srh_encap from seg6_do_srh_encap+0x1c/0x24
    seg6_do_srh_encap from bpf_push_seg6_encap+0x184/0x194
    bpf_push_seg6_encap from bpf_lwt_in_push_encap+0x48/0x5c
    bpf_lwt_in_push_encap from ___bpf_prog_run+0x1aa0/0x4334
    ___bpf_prog_run from __bpf_prog_run32+0xd4/0x114
    __bpf_prog_run32 from bpf_test_run+0x2bc/0x57c
    bpf_test_run from bpf_prog_test_run_skb+0x948/0x1100
    bpf_prog_test_run_skb from __sys_bpf+0x10a8/0x2eac
    __sys_bpf from sys_bpf+0x50/0x64
    sys_bpf from ret_fast_syscall+0x0/0x54
    [snip]
  Allocated by task 119:
    [snip]
    dst_alloc+0x50/0xac
    ip6_dst_alloc+0x24/0x7c
    ip6_pol_route+0x468/0x780
    ip6_pol_route_input+0x48/0x50
    fib6_rule_action+0x16c/0x2e8
    fib_rules_lookup+0x2b8/0x3ec
    fib6_rule_lookup+0x228/0x308
    seg6_lookup_any_nexthop+0x3e8/0x4d0
    seg6_lookup_nexthop+0x1c/0x24
    bpf_lwt_in_push_encap+0x48/0x5c
    ___bpf_prog_run+0x1aa0/0x4334
    __bpf_prog_run32+0xd4/0x114
    bpf_test_run+0x2bc/0x57c
    bpf_prog_test_run_skb+0x948/0x1100
    __sys_bpf+0x10a8/0x2eac
    sys_bpf+0x50/0x64
    ret_fast_syscall+0x0/0x54
  Freed by task 123:
    [snip]
    kmem_cache_free+0xd8/0x3cc
    rcu_core+0x434/0x1154
    handle_softirqs+0x1d4/0x660
    __irq_exit_rcu+0xe8/0x198
    irq_exit+0x10/0x18
    call_with_stack+0x18/0x20
    __irq_svc+0x98/0xb0
    finish_task_switch+0x158/0x4f4
    __schedule+0x6c8/0x1710
    schedule+0x38/0x124
    schedule_hrtimeout_range_clock+0x170/0x1e0
    usleep_range_state+0xf4/0x178
    trigger_fn+0x1dc/0x238 [seg6_noref_trigger]
    kthread+0x1c4/0x200
    ret_from_fork+0x14/0x28
  Last potentially related work creation:
    [snip]
    __call_rcu_common.constprop.0+0x4c/0x608
    ip6_pol_route+0x348/0x780
    ip6_pol_route_output+0x48/0x50
    fib6_rule_action+0x16c/0x2e8
    fib_rules_lookup+0x2b8/0x3ec
    fib6_rule_lookup+0x228/0x308
    ip6_route_output_flags+0x100/0x220
    trigger_fn+0x20c/0x238 [seg6_noref_trigger]
    kthread+0x1c4/0x200
    ret_from_fork+0x14/0x28
  The buggy address belongs to the object at c46b8100
   which belongs to the cache ip6_dst_cache of size 156
  The buggy address is located 0 bytes inside of
   freed 156-byte region [c46b8100, c46b819c)
  [snip]

The module in the trace is a small test helper. In a loop it calls
rt_genid_bump_ipv6(), as "ip -6 rule add" or a nexthop replace does, and
then does an output lookup on a route that shares the nexthop. I used the
module to make the window easier to hit.

Before the patch seg6_lookup_nexthop() used skb_dst_set(), so the skb held
a reference on its dst between runs.

> Look the route up with RT6_LOOKUP_F_DST_NOREF, as ip6_route_input()
> does, for the input and table lookups.
> [snip]

This also changes the contract of seg6_lookup_nexthop(). It does not
always take a reference now, and when it does not, the dst on the skb is
valid only inside the RCU section of the caller. seg6_lookup_nexthop() is
shared: it is declared in include/net/seg6.h and seg6_local.h, filter.c
uses it too, and neither the call sites nor the declarations say that the
lifetime changed.

One possibility would be to split it into two functions, conceptually
similar to ip6_route_output_flags() and ip6_route_output_flags_noref(): a
noref primitive for the callers in the seg6local input path, and a
refcounted wrapper around the primitive, which bpf_push_seg6_encap() would
call. The split would put the contract in the name and fix the
use-after-free above.

Ciao,
Andrea
