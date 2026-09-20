Received: from mta0.migadu.com (out-148.mta0.migadu.com [91.218.175.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0063E5EC2
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 10:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789898809; cv=none; b=rZkPY4fBod09wVJPk/ndjTT377pli9MZfru4iJ97RFPgJMpAKRZ7RzZ1J3pDDURTWiD+KSjZ7UdeyMNsT/MxsUGRYp7HbEdSj2NSr2pvzrWMe2C28QToSRSu/08JpqChLqZd4BWNIvT0U87djvaBr6ytIqCFj4DNT8II/wRqghc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789898809; c=relaxed/simple;
	bh=E/ukeaoDwEV8b3NZiUlipqAPcBPJ1vvofEVc16bqH1Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lXwGE3kdRdlRy5G438ngsrTOa1wfAcCWHLRagbWvDku1RUKuHVBgRkjZWXOPSl8lfkSI2dhksHjYCKxKeOULLREAJTeJb1A/0HOhvZX9LYFdWFIYWcLhnWj1X87l2KVVprEW1HCEfCiOthnW9AEH9TCQF62y/bHU5kY3gPzT5Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iiJ2GbQd; arc=none smtp.client-ip=91.218.175.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iiJ2GbQd"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=E/ukeaoDwEV8b3NZiUlipqAPcBPJ1vvofEVc16bqH1Q=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789898805; v=1; x=1790503605;
 b=iiJ2GbQdse8b667zLT5oP+mmMSWtLR/orJlODkRlETVZAf9I0V7TF+6ALtYrsku8omCHgnhU
 Zc0HfysxCJrJtJzNo1EReuQtITOOQfA6V6t7ZC5TNw6PgLp6iYKOs4v0HDkMSOKQmj5sng94w85
 hHf7iw4PTFpKs8/q2Rpb6hfE=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 285c4bb54c534fe9;
	Sun, 20 Sep 2026 10:06:44 +0000
X-Mizu-Trace-ID: 285c4bb54c534fe9
X-Migadu-Flow: FLOW_OUT
From: Hangbin Liu <hangbin.liu@linux.dev>
Subject: [PATCH net-next v2 0/6] netlink: add lwtunnel encap sub-message
 support to rt-route
Date: Sun, 20 Sep 2026 18:06:35 +0800
Message-Id: <20260920-ynl_rt_encap-v2-0-c664a3e726f6@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/1WNQQqDMBBFryKzbspE22i76j2KSGLHOlRGSYIo4
 t0b7KrLx+O/v0EgzxTgnm3gaebAoyTITxm0vZU3KX4lhhxzgzes1CpD42ND0tpJFfqCGgtXmMp
 CmkyeOl6O3BOEohJaItTJ9Bzi6NfjZ9aH/yV1+Z+ctULVOUeGTIXXUj8+68AyhnMrUO/7/gVtP
 PtnswAAAA==
X-Change-ID: 20260908-ynl_rt_encap-3140103b368a
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>
Cc: Hangbin Liu <hangbin.liu@linux.dev>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Hangbin Liu <liuhangbin@kylinos.cn>
X-Mailer: b4 0.14.3

This series adds YNL sub-message support for lwtunnel encap data in
the rt-route netlink family, and describes the tunnel-specific
attribute sets that were previously opaque binary blobs.

The kernel currently emits encap_type after the encap payload nest,
but YNL sub-message parsing needs the selector (encap_type) first to
dispatch on the correct attribute set. Patch 1 reorders the kernel
output, and patch 2 teaches the YNL C code generator to convert enum
selectors to their string form for sub-message dispatch.

Patches 3-6 extend the rt-route YAML spec.

Tested with ynl selftest and checked with following cmds

 # modprobe ila
 # modprobe xfrm_interface
 # ip addr add 10.1.0.1/24 dev lo
 # ip route add 10.1.0.0/24 dev lo encap mpls 100 via 10.1.0.254
 # ip route add 10.2.0.0/24 dev lo encap ip id 1 dst 127.0.0.1 src 127.0.0.1
 # ip route add 2001:db8:3::/64 dev lo encap ila 1:2:3:4 csum-mode no-action ident-type luid hook-type output
 # ip route add 2001:db8:4::/64 dev lo encap ip6 id 1 dst 2001:db8::5 src 2001:db8::1 hoplimit 64
 # ip route add 2001:db8:5::/64 dev lo encap seg6 mode inline segs 2001:db8::1
 # ip route add 2001:db8:6::/65 dev lo encap seg6local action End
 # ip route add 2001:db8:7::/65 dev lo encap bpf in ob /tmp/kself/net/lib/xdp_dummy.bpf.o sec xdp
 # ip route add 2001:db8:8::/64 dev lo encap rpl segs 2001:db8::1
 # ip route add 2001:db8:9::/64 encap ioam6 trace prealloc type 0x800000 ns 0 size 4 dev lo
 # ip route add 2001:db8:10::/64 dev lo encap xfrm if_id 100
 # ip route show
 10.1.0.0/24  encap mpls  100 via 10.1.0.254 dev lo
 10.2.0.0/24  encap ip id 1 src 127.0.0.1 dst 127.0.0.1 ttl 0 tos 0 dev lo scope link
 # ip -6 route show
 2001:db8:3::/64  encap ila  1:2:3:4  csum-mode no-action  ident-type luid  hook-type output dev lo metric 1024 pref medium
 2001:db8:4::/64  encap ip6 id 1 src 2001:db8::1 dst 2001:db8::5 hoplimit 64 tc 0 dev lo metric 1024 pref medium
 2001:db8:5::/64  encap seg6 mode inline segs 2 [ 2001:db8::1 :: ] dev lo metric 1024 pref medium
 2001:db8:6::/65  encap seg6local action End dev lo metric 1024 pref medium
 2001:db8:7::/65  encap bpf in xdp_dummy.bpf.o:[xdp] dev lo metric 1024 pref medium
 2001:db8:8::/64  encap rpl segs 1 [ 2001:db8::1 ] dev lo metric 1024 pref medium
 2001:db8:9::/64  encap ioam6 freq 1/1 mode inline trace prealloc type 0x800000 ns 0 size 4 dev lo metric 1024 pref medium
 2001:db8:10::/64  encap xfrm if_id 100 dev lo metric 1024 pref medium
 # ./tools/net/ynl/pyynl/cli.py --family rt-route --dump getroute > /tmp/route_dump.json

All the result looks good.

Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
---
Changes in v2:
- Patch 1: Check ops->fill_encap before setting encap_type_attr
- Patch 2: Get string in generated sub-message parser and check it before reference
- Patch 3-4: set byte-orders and max-len
- Patch 5: include lwtunnel.h
- Link to v1: https://lore.kernel.org/r/20260917-ynl_rt_encap-v1-0-fbbe6e680571@kylinos.cn

---
Hangbin Liu (6):
      net: lwtunnel: change encap fill order
      tools: ynl: convert enum selector to string for sub-message parsing
      netlink: specs: rt-route: add lwtunnel encap sub-message support
      netlink: specs: rt-route: describe lwtunnel IP options
      netlink: specs: rt-route: describe lwt BPF program options
      netlink: specs: rt-route: describe seg6-local actions, counters and flavors

 Documentation/netlink/specs/rt-route.yaml | 413 +++++++++++++++++++++++++++++-
 net/core/lwtunnel.c                       |  35 +--
 tools/net/ynl/Makefile.deps               |   9 +-
 tools/net/ynl/pyynl/ynl_gen_c.py          |  20 +-
 4 files changed, 454 insertions(+), 23 deletions(-)
---
base-commit: 8830e65ed46de41f849eefb8ba227d4852c460f6
change-id: 20260908-ynl_rt_encap-3140103b368a

Best regards,
-- 
Hangbin Liu <liuhangbin@kylinos.cn>

