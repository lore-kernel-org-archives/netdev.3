Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9028411FA1
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 16:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784909583; cv=none; b=stMbsZfTururApN9ODzo/j6aEckvE9z4S/0u5Lkw9fwt5xWogarQnq3l8uNezDsrAKnn+gO0lf1CzwGGWJ6913iDGtww+XzMBLZoLGuxJWFg+0ywuv+Iv8WU24Xhma4Z3J8+wrYd1RZYdf8tfYklr7WdBmz+QYIMY5fNte8ih3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784909583; c=relaxed/simple;
	bh=nyj9bbk/Y8HZGOwBdtKJTjbTMhQAwllmFMLiUs1SKbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N0cNFzwwOUHQWtTeGO31cxrsRHiZZs0csXAB07TLOMZBRUNjFSZodjoi5+Mkck8T67nBfPRVo3bLqL9asdo/L4ejae7kgnTE06Zf+unIhRlaP7Vfk4Aw35VVW3Uggn4l0ntV0uwSoOmjxqTdPNPclkbkyE1I1VVITUGpfH+BHFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P7Vrxf2n; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7Vrxf2n"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4954b3c5cbeso818155e9.1
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 09:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784909576; x=1785514376; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A93bRsx2sTolX2/f4RcXplIGQCm0NiYejXyjOOZU3aw=;
        b=P7Vrxf2nF1rMmvCG+yVz1AF1TQDccQLAJp4rgnGm+nQSNr7w1TWayANuH/2cR/KIGn
         FErQmyecKWOIzcYKHFCU7B+h0gcbw+reknuMKa9eN47/Sb5fI1YqYDhWRg4QhArVOS6G
         mO4i04qHBo4fJ4aFFrn3Ll8xp8WdLkM/JZiIeYlQZum6mlpXgBGwu0tbsok57Rtys9e9
         MhDXEDzzGMe47I4wH+y0XmiAsysmgbobt3sBI4+E7g9R/Y1FHPHDfc12ZyzEu1l1ht81
         Qz76XYf3rP1e0U5SG6clo7/Cs+zt9NYR1oUOAL/tkkLJnoBpNDgRq2DCwjTPzsQq4Xn3
         0qjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784909576; x=1785514376;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=A93bRsx2sTolX2/f4RcXplIGQCm0NiYejXyjOOZU3aw=;
        b=JY/H1e7wqNk7zXx3e9kfQL8LDNmAdIswOeOwgQRYBuwLSBqJHrHrtL2Z/uUwWPPwKd
         MpvysKYQrhLaLTHhhQWxw5WLntI1rLlhhR9iOYdkoWnC2OuJRR8dJLWvkAduHs/COeJX
         8sTkg07cVQ7naBO4V1M7hpKryjfGGWAWk1zG7BYpMhdcLdnwh+aUhfxX3KNXbVBUSLU2
         g8wdQlaRGSwikOSyR3pNiYHs1Ea2aC6CBIm7crB/0qktZ+Hgoov2MbhHmTnvZc0hgQU1
         ZZxul4T168kzSQxDYdxtyUCWhycCQoMRSlbtukPFFiqJmFo4Nqs5evv0KsouNx6CUASX
         D/JA==
X-Gm-Message-State: AOJu0YxxFKtKjBs0ggWiRyq4+Lr8pYr7GHFEcYhYZGl5o0bfsO0PkMCE
	yykhkhe9M5oQEWghAxZV7aHaeyW2GL82NYIvCfLz8k3Dm/we5yUG+eBR1FyrIplcs8I=
X-Gm-Gg: AR+sD13AFsUaeSeipd4ayb0/OXG+DQTmrKzNVkx+RPaa9maYsqmHXirWCYTeTQUfMRj
	9EBDzUlzm9Jc6vhbMD3V03kXQ5ma5zfIQSqVY4vA37uOuEpqocO6KO7Rdnqyqa3QTxx8RdIGsij
	JLbqc0WKCIRgafEQwoRfpxaMcJiLIKyxJdpfoy/y+gkvXqRdYXl8hTlSpCv3CJOy5slyvBRQkji
	7R0yBu+YqG2Mg/k/uuiG2jSUyOtkuMvxQG0W8CIoo4b1HscgzjAQ7+Nq0soj1JJo7RhwRq4Z3MO
	gapqSKnAaz72NKnTzOksTD2vNBb+M1OifmT8WPQUp/xjata8jbGzHnk0axiKTCP4CUyEBgkC6hg
	upZQU0+z3me0VMcPsiizLTNTllP31SEzrMKzsiY8HPCOLqaahrRFtR+9Ifco4Fg48c8kGWrGrcu
	m6VcuoowqXBVq4A3EI6bDlDODoHZFATWPK5G4coYngaxjvnDAU+IxEj6/XSsQpz65rLZK0SuC8A
	J+++Is44JNaTxeZUDbsisVQYyV3HmwmKnXq/5Q=
X-Received: by 2002:a05:600c:2906:b0:495:6f6a:f48b with SMTP id 5b1f17b1804b1-4957ac220b9mr23788425e9.5.1784909575544;
        Fri, 24 Jul 2026 09:12:55 -0700 (PDT)
Received: from L-022584.energy.envision.com (dynamic-077-181-161-038.77.181.pool.telefonica.de. [77.181.161.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957f9928fdsm40969655e9.1.2026.07.24.09.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 09:12:54 -0700 (PDT)
From: Xin Xie <xiexinet@gmail.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	shuah@kernel.org,
	kees@kernel.org,
	petr.wozniak@gmail.com,
	qingfang.deng@linux.dev,
	fmaurer@redhat.com,
	luka.gejak@linux.dev,
	bigeasy@linutronix.de,
	xiaoliang.yang_1@nxp.com,
	skhawaja@google.com,
	Xin Xie <xiexinet@gmail.com>
Subject: [PATCH net v2 0/4] net: hsr: fix GRO/GSO super-packet handling
Date: Fri, 24 Jul 2026 18:12:49 +0200
Message-ID: <20260724161253.79-1-xiexinet@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

HSR/PRP forward frames one by one: each wire frame gets its own tag
or RCT and sequence number, and duplicate discard is per frame. Two
aggregation mechanisms break that per-frame assumption:

* On RX, a lower device that aggregates frames into a GRO
  super-packet feeds the HSR receive and forward paths something
  they cannot handle: frames are dropped, and on memory-constrained
  devices processing super-skbs in softirq context also pressures
  atomic allocation.

* At the forward entry, a GSO super-packet (locally generated on
  the master, or delivered intact by software NICs such as veth)
  would be tagged and forwarded as a single frame, violating
  per-frame wire semantics.

Patch 1 adds netif_disable_gro() and dev_disable_gro() alongside
the existing LRO helpers.  HSR calls the public wrapper at
enslavement time, while the networking core handles the generic
feature update and recursive lower-device traversal. Enslavement to
an HSR/PRP master therefore strips NETIF_F_GRO and NETIF_F_GRO_HW
on the lower device.

Patch 2 is a preparatory locking change with forwarding semantics
unchanged: it shrinks hsr->seqnr_lock from whole hsr_forward_skb()
calls to the individual sequence counter updates, so that the
segmentation work of patch 3 (per-segment allocation, checksums and
forwarding) never runs with BH disabled under the global sequence
lock. Patch 3 depends on patch 2; please keep them together for
stable.

Patch 3 unfolds the remaining GSO super-packets at the forward
entry with the top-level GSO dispatch (__skb_gso_segment()), so
each wire frame still gets its own tag and sequence number.
Segmentation is offered only for ingress roles whose frames are
known to be plain Ethernet: the master (locally generated) and the
interlink (SAN side, untagged). A super-packet from a LAN slave may
carry per-frame HSR tags or PRP RCT trailers that software
segmentation cannot recover, and an already-tagged HSR/PRP
super-packet violates per-frame wire semantics; both are rejected
by ingress-port policy. The HSR master also stops advertising
NETIF_F_GSO_MASK so locally generated traffic is segmented as
early as possible.

Patch 4 adds a kselftest covering the above: GRO disabled on
enslaved devices, no GSO/TSO advertised by the HSR master, and a
TCP stream from a TSO-enabled SAN through an HSR DUT. The stream
evidence is direct: the SAN's TX frame-size average must exceed a
fixed super-packet threshold while the DUT LAN legs' averages stay
below a fixed per-frame guard, which is aggregate evidence that
super-packets entered the forward path and bulk output was
segmented (not a per-frame maximum proof); zero retransmits is
reported as a secondary health signal. The one-shot iperf3 server
is confined to a private mktemp workdir with its real exit status
propagated, so on every path exercised by the test itself (normal
completion, server startup failure, client failure, never-published
PID) no process or directory can leak.

Validation:
* build: W=1 allmodconfig and allyesconfig, base vs patched - no
  new warnings (evidence reused from the bound v1 run: kernel diffs
  are patch-id identical and every compiled input is byte-identical
  to the W=1-bound tree, so no build input changed; not a new
  execution).
* selftests: the final v2 hsr_gro_superpacket passes on QEMU
  x86_64 (the four paths under lifecycle above); hsr_ping,
  prp_ping and hsr_redbox results are reused from the v1 run on
  QEMU x86_64 and physical igb lower devices (kernel diffs are
  byte-identical to that validated set).
* functional: SAN TSO streams unfold per-frame (IPv4, IPv6, VLAN);
  LAN-side aggregates and already-tagged super-packets are dropped
  by ingress-port policy; master/interlink concurrency under
  PROVE_LOCKING is clean; the new counter assertions show
  super-packets entering the forward path and per-frame output on
  both LAN legs (the IPv4/IPv6/VLAN and concurrency results are
  reused v1 evidence; the counter assertions are new v2 evidence).
* lifecycle: normal completion, server startup failure, client
  failure and a never-published server PID all exit bounded with no
  leftover iperf3 or workdir.
* physical igb lower devices (reused v1 evidence, kernel diffs
  byte-identical): GRO stripped at enslavement; force-enabled
  generic GRO super-packets unfold at line rate with a clean dmesg.

Changes in v2:
- Harden the selftest's temporary-file and iperf3 process handling.
- Propagate the iperf3 server status and tighten output parsing.
- Add counter-based evidence that GSO packets enter the HSR forward
  path and are segmented before transmission on the LAN ports.
- Extend the GSO feature checks and fix shellcheck/style findings.
- Regenerate the complete mail set from real kernel commits
  (statistics now machine-generated).
- Kernel diffs in patches 1-3 are unchanged.

Previous posting (the linked RESEND is the complete v1 series):
  https://lore.kernel.org/netdev/20260722171836.196-1-xiexinet@gmail.com/


Xin Xie (4):
  net: hsr: fix packet drops caused by GRO superpackets
  net: hsr: shrink seqnr_lock to sequence counter updates
  net: hsr: unfold GSO super-packets at the forward entry
  selftests: net: hsr: add GRO super-packet forwarding test

 include/linux/netdevice.h                     |   2 +
 net/core/dev.c                                |  18 +
 net/core/dev_api.c                            |  16 +
 net/hsr/hsr_device.c                          |  17 +-
 net/hsr/hsr_forward.c                         |  53 ++-
 net/hsr/hsr_slave.c                           |  12 +-
 tools/testing/selftests/net/hsr/Makefile      |   1 +
 .../selftests/net/hsr/hsr_gro_superpacket.sh  | 437 ++++++++++++++++++
 8 files changed, 532 insertions(+), 24 deletions(-)
 create mode 100755 tools/testing/selftests/net/hsr/hsr_gro_superpacket.sh


base-commit: ba712ecfd942b68b21a4b0a5daaf72f6616cc66d
-- 
2.43.0

