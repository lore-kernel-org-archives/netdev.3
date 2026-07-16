Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA23030C16A
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 00:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784162658; cv=none; b=pl1mJ/qnmJcnqiglUgDuCL6ZIQLVWx98ANhumrZHuYZLvsVTMrQZWiXKAbSUYfNEs20ueCa/IZswx27OTTT3Jv1aBeVzuBsN2yizQeQ/I/u6icahEWXRJL8Eh1h3FXaKbBh+m/Ufph+ldhe08BYGIKyQNNP2uOKRBj98ZBy7Kic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784162658; c=relaxed/simple;
	bh=oATQsjjSeuM9iTtIYsSo8o1omXnNEePKGjgizoxIB3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YD/2eT3a0MlrJVdLaQRhVUpoWP5LBX+c0XDLd8HwzcnIWI5s/Z9FROmXxSeQU9B6QTu8nOg/PPti5mntupct0tEeQoFozBIvT2YtfBJT+owFqImupex/0ToFVmrhBafmAqXuW6En9GAZz8788UcoXnqMqjpaSXnn9kONsG7kSX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nxTTDM1/; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nxTTDM1/"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c96b08cdd1cso4092947a12.0
        for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 17:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784162654; x=1784767454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+34tg30fHZs04P1TYJFjNrZ6J+jY9NedABLOWWO5q2k=;
        b=nxTTDM1/2LpT1iM/RhAMgb4JjOAsqrpDj7449lB02+L+TFVyuQkri83BB8WszI0VfX
         Wy2+LDz7xlh8VnOjB2eLWiNuht87f55dB3/svf2h72kZic/9ZcEbTryGvF0bwoKz++5L
         UdkZEzbvslll0MUHYeL3pKUZyf3QM5TdeRkIzgXfsJpujJloI2Def8nQBTbqZecbyL+J
         nt1zwPmgS69Qkh1XUr4UABpOJ6JdulDIyMoj8pUYdFj0YXsJxUc/DkVRtZK9ZZXBl1SZ
         3cXbq6WpIOfYk9FgTjt9vv2/shTXQxB7KDsA4otycIP74ObEPtHO9TLkZl1DRxc3DnAq
         1apg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784162654; x=1784767454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+34tg30fHZs04P1TYJFjNrZ6J+jY9NedABLOWWO5q2k=;
        b=A61ALQ/1md0FJXB6nqsr7GsF3xSjC8btVIDAYQxTWJ6OGm6vhsizwFg5WEd9YItu8m
         Ny9jxwIsNEQSZoQat7qFKcRwHi5KYU1VGO+0O6cca/1IICjfv/JAKPdFbAz0W3KDR/j2
         AAWKoGB34psRthvoru0JqADE+r8FZGCHdYrRCw1sdCyuezCd1OdGqw08FQ8Sur0OZCmS
         BMOyNMlXS/KxWomrR5CRZKtkFV+EjoEDxFlnvPve65MUH6hLemqHVgxXaV9J4YIieo95
         WhuC07WrwBp8NikFMqCPgJgY7bpgnEglmVYlz9qW+jhIf9bU6CTYzldFZE5pajXlkyL8
         KEEg==
X-Gm-Message-State: AOJu0YxQYA6PX+3/ERKYr/AemBYt/QYPYC7/DVM0xwxU7xjPkwSBnOD0
	0huytzSk4Cbl14O7nnIVmeEai60ezev2xcDeC5ZugonG08KzrkBGQCGuPL0ToA==
X-Gm-Gg: AfdE7cmwcBL0ozHK5G1fNRXGFyx1uODAVPhaICBbaY+wHwI2qnHsZZiQgLCSHpNf6YV
	qAoOR9AFoI8BW1b81MLCUqZDTSlAo8jIUjkZ1CJBYMOcETp0n32FkSZLDdAvo7axlOZvymy8jDE
	h+Gk3Dgs37ire0zXeZGr8xl/jMPnqZqEm27dT3llQICxFShmeGjqUCmg9Nfk22D2wmqdM1XHl6w
	KlKhzuYyI5XQmK/EvpdFHv3btX6s+HhM/i3T/hgiWN6VDEh8aXnLdjKcAaSfgXMeve54jWSRz0z
	zp2SgXnEnsC1d+hP94egEutQpjrph0deozCQXCpbX8biBpCbWFgp652JoUxh2ED9rLi9ODxXcfq
	xXYoIS3S6hzkxSzScPDOXIU4nbChfBG+ieyhHfxFVGWQO7L94Nmv2NwLl2owkkWzousKCgSjwQY
	FcDbz0M1b0SXs713xZrWqfVg2fXsQ3MvegbsMl3zMHF9NMQsUbH3eGDHKL4w7nD736D2U+ntvk2
	Ldm34+U8Vg5BgQo6+uP
X-Received: by 2002:a05:6a21:6d9b:b0:3b4:71a9:cd8f with SMTP id adf61e73a8af0-3c36c365548mr5456208637.41.1784162654045;
        Wed, 15 Jul 2026 17:44:14 -0700 (PDT)
Received: from l.localdomain ([76.166.220.66])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13cd4284a92sm4107620c88.4.2026.07.15.17.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 17:44:13 -0700 (PDT)
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
Subject: [PATCH net-next v1 11/11] Documentation: networking: add flow_dissector overview and fast-path guide
Date: Wed, 15 Jul 2026 17:43:57 -0700
Message-ID: <20260716004357.3652679-12-dave.seddon.ca@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260716004357.3652679-1-dave.seddon.ca@gmail.com>
References: <20260716004357.3652679-1-dave.seddon.ca@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel has no general flow_dissector documentation: Documentation/bpf/
prog_flow_dissector.rst covers only the BPF override mechanism (and was
itself in no toctree). Add Documentation/networking/flow_dissector.rst as a
standalone overview -- what the flow dissector is, struct flow_keys and the
consumers of skb->hash (RSS/RPS/RFS, ECMP/multipath, bonding/LAG,
tc-flower,
aRFS), the generic protocol-graph parser, and the relationship to the BPF
flow dissector -- and document the opt-in fast paths added by this series:
the byte-identical per-shape gates, the
break-even model for when to enable a gate (with the observable
/proc/net/flow_dissector_stats). The per-knob
reference stays in Documentation/admin-guide/sysctl/net.rst; this doc links
to it rather than duplicating it.

Also index the previously-orphaned
Documentation/bpf/prog_flow_dissector.rst and cross-link it with the
new overview (the bpf/index.rst hunk can be split out if the BPF
maintainers prefer).

Assisted-by: Claude:claude-fable-5 sparse smatch
Signed-off-by: Dave Seddon <dave.seddon.ca@gmail.com>
---
 Documentation/bpf/index.rst                 |   1 +
 Documentation/bpf/prog_flow_dissector.rst   |   2 +
 Documentation/networking/flow_dissector.rst | 133 ++++++++++++++++++++
 Documentation/networking/index.rst          |   1 +
 4 files changed, 137 insertions(+)
 create mode 100644 Documentation/networking/flow_dissector.rst

diff --git a/Documentation/bpf/index.rst b/Documentation/bpf/index.rst
index 0d5c6f659266..6e26731fa06f 100644
--- a/Documentation/bpf/index.rst
+++ b/Documentation/bpf/index.rst
@@ -23,6 +23,7 @@ that goes into great technical depth about the BPF Architecture.
    cpumasks
    fs_kfuncs
    programs
+   prog_flow_dissector
    maps
    bpf_prog_run
    classic_vs_extended.rst
diff --git a/Documentation/bpf/prog_flow_dissector.rst b/Documentation/bpf/prog_flow_dissector.rst
index f24270b8b034..f4c4648461ca 100644
--- a/Documentation/bpf/prog_flow_dissector.rst
+++ b/Documentation/bpf/prog_flow_dissector.rst
@@ -9,6 +9,8 @@ Overview
 
 Flow dissector is a routine that parses metadata out of the packets. It's
 used in the various places in the networking subsystem (RFS, flow hash, etc).
+See :doc:`/networking/flow_dissector` for an overview of the flow dissector
+and the built-in C implementation this program type overrides.
 
 BPF flow dissector is an attempt to reimplement C-based flow dissector logic
 in BPF to gain all the benefits of BPF verifier (namely, limits on the
diff --git a/Documentation/networking/flow_dissector.rst b/Documentation/networking/flow_dissector.rst
new file mode 100644
index 000000000000..014f6d124b4f
--- /dev/null
+++ b/Documentation/networking/flow_dissector.rst
@@ -0,0 +1,133 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==============
+Flow Dissector
+==============
+
+Overview
+========
+
+The flow dissector parses a packet's headers into a ``struct flow_keys``: the
+addresses, ports, and other fields that identify the flow the packet belongs
+to. Its entry point is ``__skb_flow_dissect()`` in
+``net/core/flow_dissector.c``.
+
+The dissected keys feed ``skb->hash`` (via ``flow_hash_from_keys()``), which is
+the canonical flow identity consumed all over the stack, including:
+
+* receive-side steering: RSS, RPS, RFS and accelerated RFS (aRFS);
+* transmit-side spreading: ECMP / multipath route selection and bonding / LAG
+  ``xmit_hash_policy``;
+* classification and offload: tc-flower.
+
+A single dissection therefore feeds every one of these, so the dissector sits
+on a hot path in most networking workloads.
+
+Two standard dissectors are built in: ``flow_keys_dissector`` (the general one)
+and ``flow_keys_dissector_symmetric`` (same source and destination hashed
+symmetrically). In addition, subsystems such as tc-flower build **custom**
+dissector instances at run time that request only the keys they need. A custom
+instance carries its own ``used_keys`` bitmask and per-key offset table, so its
+field accesses are resolved dynamically at each dissect.
+
+struct flow_keys
+================
+
+``struct flow_keys`` (see ``include/net/flow_dissector.h``) collects the
+dissected metadata. Its main members are:
+
+* ``control`` -- address type and control flags (for example
+  ``FLOW_DIS_ENCAPSULATION`` when the keys came from inside a tunnel, and
+  ``FLOW_DIS_IS_FRAGMENT``);
+* ``basic`` -- L3 protocol (``n_proto``) and L4 protocol (``ip_proto``);
+* ``addrs`` -- source and destination addresses (IPv4 or IPv6);
+* ``ports`` -- source and destination ports;
+* ``vlan`` / ``cvlan`` -- 802.1Q / 802.1AD tags;
+* ``tags``, ``keyid``, ``icmp`` -- MPLS/flow-label tags, GRE/tunnel key, and
+  ICMP identifiers.
+
+The dissection path
+===================
+
+The built-in dissector is a generic protocol-graph parser: it walks the header
+chain in a loop, dispatching on the current L2/L3 ethertype and then the L4
+protocol, following encapsulation (IP-in-IP, GRE, ...) by re-entering the loop
+on the inner header. The number of headers it will descend through is bounded
+by ``MAX_FLOW_DISSECT_HDRS`` so that a crafted deeply nested packet cannot make
+it loop without limit.
+
+This generic parser is referred to below as the *slow path*: it is table- and
+loop-driven and handles every protocol the dissector knows about.
+
+The BPF flow dissector
+======================
+
+A per-network-namespace BPF program can be attached to replace the built-in
+dissector for the protocols it chooses to handle. When one is attached,
+``__skb_flow_dissect()`` runs it **first**; if the program returns a verdict
+other than ``BPF_FLOW_DISSECTOR_CONTINUE``, its result is used and the built-in
+dissector (including the fast paths below) is not run for that packet. A system
+running an attached BPF dissector therefore sees behaviour defined entirely by
+its program.
+
+See :doc:`/bpf/prog_flow_dissector` for the BPF program type, its API, and its
+reference implementation.
+
+Opt-in fast paths
+=================
+
+For the packet shapes that dominate real deployments, the built-in dissector
+also provides an opt-in, straight-line *fast path* that produces the same
+result as the slow-path graph walk with far fewer instructions. Restricting the
+fast path to the two standard dissectors turns their per-key offsets into
+compile-time constants, so the parse becomes branch-light straight-line code;
+the isolated per-dissect cost of the eligible shapes drops by roughly half,
+with the largest wins on in-order cores.
+
+Each shape has its own gate -- a ``static_branch`` exposed as a sysctl under
+``/proc/sys/net/flow_dissector/`` -- and **every gate is off by default**. When
+a gate is off, the only added cost is one not-taken branch per dissect, and the
+dissector's output is exactly what it was before. The fast path runs only
+*after* the BPF hook described above, so an attached BPF program always takes
+precedence.
+
+The fast paths are **byte-identical by contract**: for any packet, a fast path
+either writes exactly the ``flow_keys`` the slow path would have written, or it
+returns false and the slow path runs. There are only these two outcomes, and
+the equivalence is enforced in-tree by a KUnit test suite
+(``CONFIG_FLOW_DISSECTOR_KUNIT_TEST``). Enabling a byte-identical shape gate
+never changes any consumer's hash; it only makes the dissection cheaper.
+
+The eligible byte-identical shapes are plain Ethernet + IPv4/IPv6 + TCP/UDP,
+single and stacked VLAN (QinQ), PPPoE sessions, a single MPLS label, the
+IP-in-IP family, and plain GRE. The individual knobs are documented in
+:doc:`/admin-guide/sysctl/net` under ``/proc/sys/net/flow_dissector``.
+
+When to enable
+==============
+
+Turning a byte-identical shape gate on is worthwhile when enough traffic matches
+that shape to repay the small cost a non-matching packet pays while the gate is
+on. Concretely, if a matching packet saves ``S`` and a non-matching packet costs
+``C`` (both measured per shape and per micro-architecture), enabling the gate is
+net-positive once the fraction of traffic matching the shape exceeds the
+break-even ``p_be = C / (S + C)``.
+
+That fraction is observable: the read-only file
+``/proc/net/flow_dissector_stats`` reports, per shape, how many packets the slow
+path handled, how many the fast body handled, and the resulting eligible
+fraction, so ``(occurrences + fast_hits) / dissects`` is a gate-invariant
+measure of how much traffic each shape would accelerate.
+
+A separate RFC proposes an optional ``auto`` mode built on these counters: the
+kernel would sample them over a packet-count window and flip the
+byte-identical gates itself, with hysteresis and a flip-rate cap, so the
+operator does not have to tune each shape by hand. That controller is not part
+of this series.
+
+References
+==========
+
+* :doc:`/admin-guide/sysctl/net` -- the ``/proc/sys/net/flow_dissector/``
+  per-shape knob reference and the ``/proc/net/flow_dissector_stats`` file.
+* :doc:`/bpf/prog_flow_dissector` -- the BPF flow dissector program type.
diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index 44a422ad3b05..65368050ebab 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -52,6 +52,7 @@ Contents:
    eql
    fib_trie
    filter
+   flow_dissector
    generic-hdlc
    generic_netlink
    ../netlink/specs/index
-- 
2.54.0

