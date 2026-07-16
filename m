Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6D52C21F0
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 00:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784162642; cv=none; b=MAs/AkcrC9yQUdSIIiEbeA12pUYFbGmwSplbAR4BsqEEJBCcihnYqEL0NWEVJYerbbgy428/WbNQ/lfMFdExBd+KB+O2KrF3vRa8xwj0dqmww82tOXYEbLO/3oTpQ0iqF4rWguCgzneFPsI/1zg3/MsFbNZCo6vfSz/K9COV6Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784162642; c=relaxed/simple;
	bh=0Mu50aSnQxgrOR2PyRkXXkqD/FrcuOtgn1TX+EDdL+w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kv2CrwYujBUonAW35gQ1PfE5lhCPEaEvwrNpIv/KOut46Nuxjq4JxaJyue+DSPc4mg1yE+uaEpVHYlYPNdv30B26oQ+uzWvxt15DKiTntpOIuDn1PAtI7EPizcwH4DJAw4Xhx5jn0OrlWS/L9Cks8pK+QzffQVWtcnLQVMunYdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BHAPBhjy; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHAPBhjy"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8423f236418so2261327b3a.1
        for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 17:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784162640; x=1784767440; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aRJBllZwiKuUhgjqnxWsBx3qCbCZXUWfHviVh8iSxgg=;
        b=BHAPBhjyIJxo3jOrYgHdfBkySruh46+/xAikkKh2nUVH8kSVCsIOIQwZICQjMmt+99
         XmBrXHG3SxEF4nUvRkxIQgBQ5OeGTZ94Iu4K5DA7y+ndFx+659/2zYeGwkEBU2etPUTT
         VznlSHGd9K7klH4/P8NSAVW0u3G3pVkTXIgIJvto0XaPxmxWuljUlw83QCzJWUZAsnXO
         7MhUx5vRR7J1+dFQ2JGW1og+Vdp/n3RnzFqsvYrcd7f3JqIBUoZb9iagqIVaZzZWJrZg
         bpRNmW+RzsudSDt67RdEVU71EtvKn+7sovBLLBxgMJfloT6ShROCiYaI1hYadrWoApsf
         FLkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784162640; x=1784767440;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aRJBllZwiKuUhgjqnxWsBx3qCbCZXUWfHviVh8iSxgg=;
        b=c4tC8QHm7/ag4+mSFOKvjIQgWVjVarQ9SYmUCg5IgXrz6DTGelSkwkt/iboVxhPPQs
         Crvr9ZEy+faYPB2y6DpQpgzD1T7ztbkO2URBlboJLWy+z5GMQPNfuNe/nFOStQM6EOWQ
         8bSMWhUikIzxLVAlhSwNdzoMnPevuOK4M3aOppJiRgkid9PKRYyiz/AMyWjG1dQNSQSc
         DzAUU9lshKv44in3SiNuqjOMCa32de9k0Bk6QDWRAJMsZRB/cq1kh4BBQ4lg1itb+DbI
         S7cHagOhe0Wmexl7UreJ7mHX8vQfQksdAXGwkW2JPwFTif7CkCm4KYchfZih0ZR/7v/u
         1C0A==
X-Gm-Message-State: AOJu0YzA12A93zxZVssvhJIuF8+D760D7IjQr8e+f2V6uAWberou6WS/
	0ATteS6bDL4hYnKXJQxLDpDnvRik8kB90tCl0ROrqygC0kf5JgLX5knegEp6sg==
X-Gm-Gg: AfdE7ckg9lgqMClNXitr9x1QY2GdFhwX3vqzzoGLB4v94NNM1su/d1/aJQuJCpWet8a
	CRBhKGvRViiImKUXtBdYgStVx3ay2dkl+O/Xzwqu3NuHT1N3qsnwDBinVmedQHRkQsDgcfSxNgH
	i4rgkCZB3EOe7OJ2EQrB/eA+GtkQf3QhQdGDBOpwS/sUmBYcMYIjxLXJC65/nMLtuc1UHY1I9pk
	90cbbQsEW8fsfObAAO1BCFt9n6Z7S6i3CUFKboo8VvwJojS2Hjemy3sD0cMvUDobIJzawPYgLXw
	D/kQuBiFHWPJ6HHGyWF7Hsjj+v3mM6qAQ1krx5efRyPW01k/xOBAE4jp1prN+PdvT134yqWJCj9
	CRa3OaRx950EqXf5cENcbP9670iX1wprcUcDev7kitRcuhi+wZlmuMGojKPY6mJOLgr1wFSAWEH
	WcRWw7jImPlXO557s4+fFUU0TPxfEsOrrP1WEMwqoN6Rp0qrzwtHG/YShyu7n5LWz7yyG+3jKoE
	1dGrehNAg==
X-Received: by 2002:a05:6a21:6b0f:b0:3c3:7bb9:c8d with SMTP id adf61e73a8af0-3c37bb9457bmr2918365637.49.1784162639764;
        Wed, 15 Jul 2026 17:43:59 -0700 (PDT)
Received: from l.localdomain ([76.166.220.66])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13cd4284a92sm4107620c88.4.2026.07.15.17.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 17:43:59 -0700 (PDT)
From: Dave Seddon <dave.seddon.ca@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Tom Herbert <tom@herbertland.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	linux-kernel@vger.kernel.org,
	Dave Seddon <dave.seddon.ca@gmail.com>
Subject: [PATCH net-next v1 00/11] net: flow_dissector: opt-in byte-identical fast paths for common shapes
Date: Wed, 15 Jul 2026 17:43:46 -0700
Message-ID: <20260716004357.3652679-1-dave.seddon.ca@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

G'day,

__skb_flow_dissect() parses packet headers with a generic protocol-graph
parser. The graph walk is what makes the dissector so flexible, but most
machines spend that flexibility on the same traffic all day long: plain
eth + IPv4/IPv6 + TCP/UDP, perhaps with a VLAN tag or a tunnel header in
front. The intuition behind this series is that the common shapes can be
dissected by straight-line code instead, without giving up the graph
walk for everything else.

Concretely: the series adds an opt-in, static-branch-gated fast path per
packet shape, covering the common cases and the IP-in-IP/GRE
encapsulations. Each shape has its own gate under
/proc/sys/net/flow_dissector/, every gate is disabled by default, and
when a gate is off its added cost is one not-taken branch per dissect.
The gates are manual in this series; a follow-up RFC will propose an
optional auto mode that flips them from the measured traffic mix (via
the patch-8 counters), so nobody has to hand-tune seven knobs
(eth_ip, vlan, qinq, pppoe, mpls, ipip, gre). Nothing
here depends on it -- it is where this is heading, not a prerequisite.

The series is byte-identical by contract: for any packet, the fast path
either writes exactly the flow_keys bytes the slow path would have
written, or it returns false and the slow path runs. That contract is
enforced in-tree by a KUnit equivalence suite (patch 10).

Patch 1 stands slightly apart: it is a small win for the existing path --
today every dissect takes rcu_read_lock() and does two dependent
rcu_dereference() loads to look for a netns BPF flow dissector program
even when none is attached anywhere; a static key (mirroring
bpf_sk_lookup_enabled) skips all of it in the common no-program case.

Patches 2-7 are the byte-identical common shapes (eth+IPv4/IPv6 x
TCP/UDP, VLAN/QinQ, PPPoE, single MPLS, IP-in-IP, plain GRE). Patch 8
adds per-shape counters (/proc/net/flow_dissector_stats); patch 9 bounds
the fast-path tunnel recursion at MAX_FLOW_DISSECT_HDRS.

A companion series (posted separately) builds on this one to add opt-in
inner-flow descent for the UDP tunnels (VXLAN, Geneve, GTP-U, FOU/GUE)
-- that one changes hashing when enabled, so it is a separate policy
discussion; this series is purely a transparent optimisation.

Why not just optimise the existing loop
========================================
The slow path is a generic graph walk by design: one loop, one
proto/nhoff state machine, re-entered per header, able to express every
protocol relationship the dissector knows. That generality is the cost --
per-header dispatch, state saves, and branchy key-writing that the
compiler cannot flatten because the shape is only known at runtime. A
per-shape straight-line function knows the whole shape at compile time,
so the loads, checks and key writes schedule as one block. The two
approaches are complementary: the loop stays the single source of
semantic truth for every shape, and a handful of high-volume shapes get
a verified shortcut.

Performance summary
===================
Measured across 3 ISAs and 8 microarchitectures in total, with
byte-identical verification per shape (userspace A/B harness compiling
the dissector both ways from the same source). Two instruments, each
run on 7 of the 8 microarchitectures: "allshapes" compiles every fast
path in (the realistic icache footprint) and measures each shape in
isolation, on x86 Zen1/Zen2/Skylake, ARM Cortex-A53/A72/A76 and RISC-V
X60; "isolated A/B" compiles one shape's path against the unmodified
dissector (the upper bound for that shape), on the same set with
Haswell in place of Zen 1.

Reduction in dissector CPU cost, allshapes microbench. Each row is the
range across its 7 microarchitectures, worst to best:

    shape     worst    best
    ------   ------   ------
    eth_ip    -4.7%   -31.6%
    vlan     -18.1%   -38.5%
    qinq     -16.1%   -39.8%
    pppoe     -8.6%   -28.0%
    mpls      -6.7%   -15.0%
    ipip     -36.8%   -47.0%   largest: slow path re-parses inner IP
    gre        (byte-identical descent family, tracks ipip; verified
                by the KUnit suite rather than separately benchmarked)

Isolated A/B, eth + IPv4 + TCP (same source compiled two ways),
nanoseconds per packet, lower is better:

    microarchitecture                      slow    fast   delta
    ------------------------------------  ------  ------  -----
    x86 Zen 2 (Threadripper PRO 3945WX)    12.4     6.6    -47%
    x86 Skylake (Core i9-10885H)           10.6     5.6    -47%
    x86 Haswell (Celeron 2955U)            35.9    18.0    -50%
    ARM Cortex-A53                        119.0    61.3    -48%
    ARM Cortex-A72                         42.4    19.1    -55%
    ARM Cortex-A76                         19.4     9.3    -52%
    RISC-V SpacemiT X60                    98.2    49.3    -50%

The isolated dissect costs 47-55% less per packet, consistent across
the three ISAs and the seven microarchitectures measured with that
instrument; the relative reduction is largest on in-order cores,
indicating the saving is fewer instructions rather than a
microarchitectural artifact. IPv6 uses the same gate and is
byte-identical (x86 -39%, RISC-V -25%).

flow_keys -> skb->hash via skb_get_hash() is the flow identity behind
RPS/RFS/aRFS, the fq / fq_codel / cake fairness queues, bonding/LAG
transmit hashing and more; those callers pass no restricting flags, so
each of them gets the per-dissect saving at once. Dissector callers
that pass STOP flags (ECMP multipath, xfrm policy lookup) or run their
own dissector instances (tc-flower) deliberately stay on the slow
path -- unchanged, not regressed.

Counters (patch 8) are the one part with a cost in the all-gates-off
default: one this_cpu_inc per dissect plus one per matched shape.
Measured on a CPU-bound pktgen soak that is +0.74% dissector time
(+0.44 sigma -- within run-to-run noise). The gates themselves stay
free: off means one not-taken static branch.

Relationship to the BPF flow dissector
======================================
The fast path is invoked strictly after the netns BPF flow dissector
hook in __skb_flow_dissect(): if a program is attached and returns any
verdict other than BPF_FLOW_DISSECTOR_CONTINUE, the function returns
before flow_dissect_fast() is reached. Attached BPF dissectors therefore
always take precedence, and a system running one sees bit-for-bit
unchanged behaviour from this series (patch 1 additionally makes its
program lookup cheaper for everyone else). Dissects fully handled by a
BPF program are deliberately not counted in
/proc/net/flow_dissector_stats (patch 8).

The gates are global (a static key patches code shared by every netns);
per-netns dissector policy already has a mechanism -- the netns BPF
flow dissector -- and it keeps full precedence here.

Maintenance burden: why two paths won't diverge
===============================================
The slow path remains the single source of semantic truth and the fast
path is verified against it, not vice versa. Three layers enforce that:

  1. The eligibility gate: only the two standard dissectors and a flag
     subset ever enter flow_dissect_fast(); custom tc-flower dissector
     instances are structurally unaffected.
  2. Every shape is a default-off static branch: a kernel with gates off
     executes the not-taken-branch slow path only.
  3. The KUnit equivalence suite (patch 10) dissects a corpus of
     eligible shapes, deliberate fast-path misses, truncations at every
     byte boundary, and skb-mode entry conditions through both paths
     and memcmp()s the resulting struct flow_keys (and their
     flow_hash_from_keys()). Future divergence is a failing test, not a
     silent behaviour change.

The test earns its place: during development it caught real divergences
the out-of-tree A/B harness had missed -- the MPLS fast path skipping the
slow path's out_good terminal writes, the 4in6 descent not reproducing
the outer-IPv6 residue, and -- caught by a hardware boot smoke with
counter positive-controls, then pinned by a regression test -- the
dispatcher rejecting the STOP_AT_FLOW_LABEL flag that skb_get_hash()
passes on every dissect, which had made the fast path unreachable from
RPS/RFS/fq/cake entirely. All fixed in this posting.

Robustness and safety limits
============================
The fast path descends into IP-in-IP and GRE by recursion. The slow
path bounds header descents at MAX_FLOW_DISSECT_HDRS; patch 9 gives the
fast path the same bound, so a crafted nested chain falls back to the
slow path at the same depth rather than driving one C stack frame per
~20 bytes of linear header. The KUnit suite covers the bound boundary,
the non-linear-skb fallback, a gates-off negative (the fast path must
never run when disabled, observed via the counters), and a seeded
fuzzer as a general guard.


Patch 11 adds Documentation/networking/flow_dissector.rst -- there was no
general flow_dissector overview in the tree. It explains what the dissector
is and who consumes its output, then documents this series' fast paths: the
byte-identical contract and the break-even model for when a gate is worth
enabling. The per-knob reference stays in
Documentation/admin-guide/sysctl/net.rst; the new doc links to it.

On tooling: this series was developed with substantial LLM assistance
(Claude, Anthropic) -- identifying the optimisation opportunity,
drafting the patches, and building and running the test matrix. Every
patch carries an Assisted-by: trailer in the
Documentation/process/coding-assistants.rst format. All of it was
human-reviewed and human-measured: the performance numbers come from
months of runs across the hardware above, and the byte-identical
contract is enforced mechanically by the in-tree KUnit suite rather
than by trust in either the tool or the author.

This series grew out of work on Tom Herbert's XDP2 parser project:
porting the kernel flow dissector into XDP2's userspace benchmarking
harness, to compare parsers on equal footing, is what made the
per-shape cost of the generic loop visible -- this opt-in fast path is
the kernel-side result of that analysis.

Testing: 3 ISAs / 8 uarches (x86 Zen1/Zen2/Skylake/Haswell, ARM
Cortex-A53/A72/A76, RISC-V X60), in-tree KUnit (patch 10: 55 tests,
also run under KASAN+UBSAN; per-patch W=1, sparse and smatch clean;
CONFIG_NET_FOU n/m/y config matrix for the companion series) and
out-of-tree A/B. Supporting data (flow-distribution study,
per-shape/per-arch matrix, break-even derivation) lives in the
author's XDP2 fork: https://github.com/randomizedcoder/xdp2 , under
perf-results/ .

Dave Seddon (11):
  net: flow_dissector: gate BPF program lookup behind a static key
  net: flow_dissector: opt-in fast-path for eth + IPv{4,6} + {TCP,UDP}
  net: flow_dissector: add fast-path for VLAN and QinQ + IP + TCP/UDP
  net: flow_dissector: add fast-path for PPPoE session + IPv{4,6} +
    TCP/UDP
  net: flow_dissector: add fast-path for single MPLS label + IP
  net: flow_dissector: add fast-path for IP-in-IP family (IPIP / 4in6 /
    6in4)
  net: flow_dissector: add byte-identical fast-path for plain GRE inner
  net: flow_dissector: per-shape counters +
    /proc/net/flow_dissector_stats
  net: flow_dissector: bound fast-path tunnel recursion
  net: flow_dissector: add KUnit fast/slow path equivalence tests
  Documentation: networking: add flow_dissector overview and fast-path
    guide

 Documentation/admin-guide/sysctl/net.rst    |  178 ++-
 Documentation/bpf/index.rst                 |    1 +
 Documentation/bpf/prog_flow_dissector.rst   |    2 +
 Documentation/networking/flow_dissector.rst |  133 +++
 Documentation/networking/index.rst          |    1 +
 include/linux/skbuff.h                      |    1 +
 include/net/flow_dissector.h                |   34 +
 kernel/bpf/net_namespace.c                  |   17 +-
 net/Kconfig                                 |   12 +
 net/core/Makefile                           |    1 +
 net/core/flow_dissector.c                   | 1116 ++++++++++++++++++-
 net/core/flow_dissector_test.c              | 1053 +++++++++++++++++
 12 files changed, 2500 insertions(+), 49 deletions(-)
 create mode 100644 Documentation/networking/flow_dissector.rst
 create mode 100644 net/core/flow_dissector_test.c


base-commit: f6f3b36c15ed44de1fbb44e645e4fae8c4a4453e
-- 
2.54.0

