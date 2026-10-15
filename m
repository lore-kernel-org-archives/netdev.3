Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.26.1.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CD23C345D;
	Thu, 15 Oct 2026 23:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.26.1.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792108451; cv=none; b=Pu19TqEpECH/pEJGAY7t25KPtRBVD7Ugfcr4do72W3v7Ofy0YhUMFU+gWof5UdVwTbMRLpZHsnmtLgu7EPKXSszEDTw5Z1exPTed9BRHvRdrAeGC5XS8wRYl7vZY0ZL2oHgJs9H6W6MUJBOY1/ieBcrvZ7VNHzBPf8cmZHpgLL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792108451; c=relaxed/simple;
	bh=+ydjaBn7cFJDCDp7lY1d0eRi8Vj2c83HSwB6VzAKZe4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B4iqUt8DpAJkkHHHGpI6EU04GRbEm0c4oiq/fnJZWvvW+3EMkX6T/5tE6mIr34p8QPoQJxhE/cVo4amW3eT9oUIWXv4/iwFTstgf4dGZRInkc0df+nGETt7BygBEW1O2PKoQ5WmUVj9rTDfG05rnAh7Rm8UamyfpZ0Ao7HOTBe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=WQfJSuyV; arc=none smtp.client-ip=52.26.1.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="WQfJSuyV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1792108450; x=1823644450;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ONwXOFUNi4JafA345btqSwkPykBXRozHUwFFQH5wDI0=;
  b=WQfJSuyVefkF8gihPMhfpqjTXa+6ZqV7ZeOtp08MD5dG0g5WfhIymXv+
   X4PjxWdLrcw+zvhzk+CV+0km5808vQ4epJJt7BYH9KdEJ3yzHhh50j0qm
   9yid0K1ruEOnRVXjhV82gsXL7mFP4McbNwPOGHdNcZyxMKV7oFTHWXLI3
   38qpXPq5rGH0UkBOB/xGNXgJz24ZScf+mkB/CVNV0mIoWXP5phT0vi/zR
   3ECPjnmX1LfS8qwS3x5/zIQfrssIQkIuNwNOWPhMCxUhkp2EjobiLZzrc
   OXE/jnj4cjkL6I30Izm3/Z40jpdNo6qhZ5o60fpqnYr1T98sxx3CrZ6gK
   A==;
X-CSE-ConnectionGUID: 0KjOglFPR1KxYyA5djj/pQ==
X-CSE-MsgGUID: VjHQYivMT1OmC2Ij7YZL5w==
X-IronPort-AV: E=Sophos;i="6.27,160,1787011200"; 
   d="scan'208";a="31427674"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 23:54:08 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:1051]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.19.38:2525] with esmtp (Farcaster)
 id ee66dbbc-f1a1-4b13-99d0-c7d3d94c3b48; Thu, 15 Oct 2026 23:54:07 +0000 (UTC)
X-Farcaster-Flow-ID: ee66dbbc-f1a1-4b13-99d0-c7d3d94c3b48
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Thu, 15 Oct 2026 23:54:07 +0000
Received: from dev-dsk-dkeogh-ai2-36d3b9a7.us-west-2.amazon.com
 (172.19.55.127) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53; Thu, 15 Oct 2026
 23:54:07 +0000
From: David Keogh <dkeogh@amazon.com>
To: <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Dumazet <edumazet@kernel.org>
CC: Dragos Tatulea <dtatulea@nvidia.com>, Nimrod Oren <noren@nvidia.com>,
	<nh-open-source@amazon.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC net-next 0/6] net: configurable extra TX headroom for local egress
Date: Thu, 15 Oct 2026 23:53:29 +0000
Message-ID: <20261015235335.4162993-1-dkeogh@amazon.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA001.ant.amazon.com (10.13.139.88) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

A program attached at TC egress commonly pushes additional headers onto a
packet, for example to encapsulate it. Locally generated UDP, raw and
AF_PACKET traffic is allocated with exactly LL_RESERVED_SPACE() of headroom,
which covers the link-layer header plus the driver's needed_headroom and
alignment, leaving no slack for anything an egress program pushes, so that
push reallocates the skb head on every packet. There is currently no in-tree
way for an administrator to ask for more headroom at allocation time.

Add a per-device tx_extra_headroom, configured through a new
IFLA_TX_EXTRA_HEADROOM rtnetlink attribute. It is a separate value from
needed_headroom: it is added on top of LL_RESERVED_SPACE() at the allocation
sites only (LL_ALLOC_SPACE()), it can be set and cleared freely without
recreating the device, it is reported through its own attribute so it is never
confused with the driver's requirement, and it is not inherited by stacked
devices. needed_headroom keeps its current meaning and remains the threshold
for deciding whether an existing packet must be expanded, so the extra
reservation never forces a reallocation on its own.

The value is bounded to NETDEV_TX_EXTRA_HEADROOM_MAX (512 bytes) by the
netlink policy, enough for several stacked encapsulations (for example
VXLAN, GRE or IPIP) while keeping the growth of per-packet allocations
modest; a request above it is rejected. The attribute is purely additive, so
an older iproute2 that does not know it simply never sends it; configuring the
value requires both kernel and iproute2 support, and old userspace that
ignores unknown dump attributes is unaffected.

Why a new value rather than letting userspace raise needed_headroom: that was
the first approach and it was dropped. needed_headroom is a floor the device
and stacked devices depend on and is consulted on the expand-on-demand path
(ip_finish_output2()), so raising it reallocates every packet that lacks the
full reservation, including TCP segments, and it cannot be lowered without
recreating the device. tx_extra_headroom sidesteps both problems by only
affecting fresh allocations and by being freely clearable.

The reservation applies to the device the packet is allocated against (the one
the route selects) at skb-allocation time. A GSO super-skb is therefore
allocated once with the headroom in place; software segmentation copies that
headroom into each segment, so the push lands in reserved space for every
segment without a per-segment realloc. net/xdp/xsk.c is included among the
converted paths: AF_XDP copy mode open-codes the same needed_headroom
calculation, so it uses netdev_tx_alloc_headroom() to pick up the extra
reservation consistently with the socket paths.

Because the reservation is applied only at the allocation sites, TCP is left
alone: TCP segments are built with MAX_TCP_HEADER already reserved and are
checked against LL_RESERVED_SPACE(), not LL_ALLOC_SPACE(), so raising the knob
does not reallocate them. Covering the TCP allocation path is deliberately not
part of this series.

Measurements (net-next at commit 05b5019b0, veth, 500000 UDP datagrams, a
20-byte ip-in-ip push attached at TC egress, only tx_extra_headroom varied):

  tx_extra_headroom   pskb_expand_head reallocs / 500k
  0 (off)             500003   (~1 per packet)
  64                  4        (background)
  128                 2        (background)

Idle case, same rig with the knob set but no TC program attached: 500000 UDP
datagrams produce 0 reallocs on the device. With nothing pushing headers there
is nothing to expand, so a set-but-unused value costs only the reserved bytes
per allocation, with no added reallocation or copy.

The small background counts at 64 and 128 are control traffic on the device
(ARP/ND and pre-neighbour-resolution skbs), not the UDP push path; the idle
case reads 0 because that run primes a permanent neighbour first.

The data-plane selftest also sweeps the knob across the exact headroom the
push needs and shows the realloc count flip at the predicted byte boundary
(veth LL_RESERVED_SPACE is 16; a 14-byte L2 header leaves 2 free, so a 20-byte
push needs 18 more: reallocs persist at 17 and vanish at 18). A UDP-only encap
leaves a concurrent TCP stream delivering cleanly with the realloc count flat
as the knob is raised, confirming the TCP path is untouched.

Patch 1 adds the field and the LL_ALLOC_SPACE() macros. Patch 2 switches the
local-egress allocation sites to them (UDP, raw, AF_PACKET and AF_XDP). Patch 3
exposes the attribute through rtnetlink with documentation and the rt-link spec
entry. Patch 4 tests the attribute itself through YNL. Patches 5 and 6 add the
data-plane test: two BPF programs and the YNL test that drives them. The BPF
programs live under selftests/bpf/progs because that tree supplies the
clang -target bpf toolchain and generated vmlinux.h the CO-RE fentry counter
needs, while the test driver lives in selftests/net; this is noted here
because it has a bearing on how the series is applied.

As an RFC question: the data-plane test spans two selftest trees because the
fentry realloc counter is a CO-RE program that needs the vmlinux.h generated
under tools/testing/selftests/bpf, while the driver lives in
tools/testing/selftests/net. I would appreciate guidance on the preferred
structure: consolidate the whole data-plane test under selftests/bpf, or keep
it in selftests/net without CO-RE so it builds self-contained. The core change
(patches 1-3) is independent of this and targets net-next regardless.

David Keogh (6):
  net: add tx_extra_headroom and LL_ALLOC_SPACE()
  net: reserve extra TX headroom for local egress
  rtnetlink: add IFLA_TX_EXTRA_HEADROOM
  selftests: net: add tx_extra_headroom test
  selftests/bpf: add tx_extra_headroom data-plane programs
  selftests/net: add tx_extra_headroom data-plane test

 Documentation/netlink/specs/rt-link.yaml      |  12 ++
 .../networking/net_cachelines/net_device.rst  |   1 +
 Documentation/networking/netdevices.rst       |  34 +++
 include/linux/netdevice.h                     |  33 +++
 include/uapi/linux/if_link.h                  |   1 +
 net/core/dev.c                                |   2 +
 net/core/rtnetlink.c                          |  19 +-
 net/ipv4/ip_output.c                          |   2 +-
 net/ipv4/raw.c                                |   2 +-
 net/ipv6/ip6_output.c                         |   2 +-
 net/ipv6/raw.c                                |   2 +-
 net/packet/af_packet.c                        |   6 +-
 net/xdp/xsk.c                                 |   6 +-
 .../bpf/progs/tx_extra_headroom_probe.c       |  68 ++++++
 .../bpf/progs/tx_extra_headroom_tc.bpf.c      |  69 ++++++
 tools/testing/selftests/net/Makefile          |   2 +
 .../selftests/net/tx_extra_headroom.py        | 137 ++++++++++++
 .../net/tx_extra_headroom_dataplane.py        | 197 ++++++++++++++++++
 18 files changed, 585 insertions(+), 10 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/tx_extra_headroom_probe.c
 create mode 100644 tools/testing/selftests/bpf/progs/tx_extra_headroom_tc.bpf.c
 create mode 100755 tools/testing/selftests/net/tx_extra_headroom.py
 create mode 100755 tools/testing/selftests/net/tx_extra_headroom_dataplane.py

-- 
2.50.1

