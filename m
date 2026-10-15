Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com [34.218.115.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E2612B94;
	Thu, 15 Oct 2026 23:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.218.115.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792108637; cv=none; b=ZunhtdhkDtsgS+ZU25XpxDQg0PDNxHP0mzJjqYobSOP26hiLSuyn2XUKzebvdyj+fn2YsaXP05F1nctNEDrN9tkDxmfja5G6RvYNreKt75FY8bZUOFFtISziUq9wXlK514RVxENiR70PMH0dyFPa/2rYfWqdpMRFoHjAqK73w0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792108637; c=relaxed/simple;
	bh=nwTvCpXRL6oY96X3vt7gbZ/aCURYMMM4rrkINQ5/d/Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mI53B9OyJIeMfOYR0jZeNhTbUEd70vQ7yWF5wVNzHPJ32AZVleJZcoDQd5lGpmTIJ4zbfdjnE9g8G8k7OlKs92czzxagjzpbax7EakVkj3vW0ZpT3a4UoK1h6atR48Ku70gbwhWpkIJFATPZc0xQXn+7mNOCFozEsPQh4pBvxBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=sozMejSb; arc=none smtp.client-ip=34.218.115.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="sozMejSb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1792108636; x=1823644636;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JuQIR6xxu+Ccn4fJ1Tmer0zdvoE1nrvZZJsOWghcExQ=;
  b=sozMejSbeIHQKi2flyHWdrVH/Jz5D6HWHr8hN02qmpNhhuOMNUZGuF3V
   JryLW1iQWh81jv/uqrpWxFRC1bvKdcRMqiEsMdSGowLsYoFNmvPn5uLbc
   Q2U3KXuxhW1MSCk/ckFyK1IRcWnM8AkmUz7XG/SCpv80Z8oTikjvRO48G
   KcsYlBX7X453IX/VVG2urO7cMkSkTMNQtIOeywSc2NF4BRpqnpgRpi9dE
   LnvOpCWwMN+O3XGQSjeLGXB0OyjBue/zbFfNwu7IYv80hrqeKO9a/Uw27
   GqPaXbL8purDrlXms3kXwZDXymHraarDh5v+yfUHUxOjWbDH018mWh9LD
   w==;
X-CSE-ConnectionGUID: SbYd7BkIQOmQzcH8/nylcQ==
X-CSE-MsgGUID: PkGGQ2HjTAW5hp2NTQlmiw==
X-IronPort-AV: E=Sophos;i="6.27,160,1787011200"; 
   d="scan'208";a="31167227"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 23:57:13 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:18153]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.12.154:2525] with esmtp (Farcaster)
 id da528a75-418a-498b-8c90-9899358c60f4; Thu, 15 Oct 2026 23:57:13 +0000 (UTC)
X-Farcaster-Flow-ID: da528a75-418a-498b-8c90-9899358c60f4
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Thu, 15 Oct 2026 23:57:13 +0000
Received: from dev-dsk-dkeogh-ai2-36d3b9a7.us-west-2.amazon.com
 (172.19.55.127) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53; Thu, 15 Oct 2026
 23:57:12 +0000
From: David Keogh <dkeogh@amazon.com>
To: <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Dumazet <edumazet@kernel.org>
CC: Dragos Tatulea <dtatulea@nvidia.com>, Nimrod Oren <noren@nvidia.com>,
	<nh-open-source@amazon.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC net-next 6/6] selftests/net: add tx_extra_headroom data-plane test
Date: Thu, 15 Oct 2026 23:53:35 +0000
Message-ID: <20261015235335.4162993-7-dkeogh@amazon.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261015235335.4162993-1-dkeogh@amazon.com>
References: <20261015235335.4162993-1-dkeogh@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC002.ant.amazon.com (10.13.139.212) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

The existing tx_extra_headroom test checks the IFLA_TX_EXTRA_HEADROOM
attribute itself. Add a test for its effect: with the knob at zero an
egress header-push reallocates the skb head on every packet, and with
the knob raised the realloc is eliminated. A second case checks that the
cliff sits at exactly the headroom the push needs.

The test loads the two BPF programs from the previous patch, attaching
count_realloc by SEC name with "bpftool prog loadall ... autoattach" and
reading realloc_cnt via bpf_map_dump(). The veth peer is kept in its own
netns so the datagram egresses the device under test, and a permanent
neighbor is primed so UDP is not dropped before egress.

Signed-off-by: David Keogh <dkeogh@amazon.com>
---
 tools/testing/selftests/net/Makefile          |   1 +
 .../net/tx_extra_headroom_dataplane.py        | 197 ++++++++++++++++++
 2 files changed, 198 insertions(+)
 create mode 100755 tools/testing/selftests/net/tx_extra_headroom_dataplane.py

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 0eb9a69e9..28b0444ba 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -121,6 +121,7 @@ TEST_PROGS := \
 	tfo_passive.sh \
 	traceroute.sh \
 	tx_extra_headroom.py \
+	tx_extra_headroom_dataplane.py \
 	txtimestamp.sh \
 	udpgro.sh \
 	udpgro_bench.sh \
diff --git a/tools/testing/selftests/net/tx_extra_headroom_dataplane.py b/tools/testing/selftests/net/tx_extra_headroom_dataplane.py
new file mode 100755
index 000000000..d32bb1ed6
--- /dev/null
+++ b/tools/testing/selftests/net/tx_extra_headroom_dataplane.py
@@ -0,0 +1,197 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+"""
+Data-plane tests for IFLA_TX_EXTRA_HEADROOM: setting the knob eliminates the
+per-packet head reallocation that an egress header-push otherwise forces.
+
+Mechanism (fully in-tree, no bpftrace, no raw kprobe, no user-space loader):
+
+  * tx_extra_headroom_tc.bpf.o    - a tc-egress program that pushes a 20-byte
+    outer header on UDP via bpf_skb_adjust_room(..., BPF_ADJ_ROOM_MAC, ...). On
+    an skb allocated with only LL_RESERVED_SPACE() of headroom that push
+    reallocates (pskb_expand_head) on every packet; with tx_extra_headroom
+    reserving enough room at allocation time it does not.
+
+  * tx_extra_headroom_probe.bpf.o - an fentry/pskb_expand_head program that
+    counts the reallocs for the device under test (filtered by cfg_ifindex) into
+    realloc_cnt. It is attached by its SEC name via
+    "bpftool prog loadall ... autoattach" and read via bpf_map_dump().
+
+Topology is two netns (peer in a separate netns) so the datagram genuinely
+egresses the device and hits the tc-egress hook; co-resident veth ends would be
+locally delivered via loopback and never reach egress. A static ARP neighbor is
+primed so UDP egresses instead of dropping at an unresolved neighbor.
+"""
+
+import socket
+import time
+
+from lib.py import ksft_run, ksft_exit, ksft_ge, ksft_lt
+from lib.py import ip, tc, bpftool, cmd
+from lib.py import bpf_map_dump, bpf_prog_map_ids
+from lib.py import NetNS, NetNSEnter
+from lib.py import RtnlFamily
+
+ATTR = "tx-extra-headroom"
+OUTER_LEN = 20
+# veth LL_RESERVED_SPACE = ((14 + 0) & ~15) + 16 = 16; the 14-byte L2 header
+# leaves 2 free, so a 20-byte push needs 20 - 2 = 18 more from the knob.
+THRESHOLD = 18
+NPKTS = 20000
+
+TC_OBJ = "tx_extra_headroom_tc.bpf.o"
+PROBE_OBJ = "tx_extra_headroom_probe.bpf.o"
+PINDIR = "/sys/fs/bpf/tx_extra_headroom"
+
+
+def ifindex(name):
+    return ip(f"link show dev {name}", json=True)[0]["ifindex"]
+
+
+def _hex_le(value, nbytes):
+    """bpftool 'key/value hex' wants space-separated little-endian bytes."""
+    return " ".join(f"{b:02x}" for b in int(value).to_bytes(nbytes, "little"))
+
+
+def _map_set_u32(map_id, key, value):
+    bpftool(f"map update id {map_id} key hex {_hex_le(key, 4)} "
+            f"value hex {_hex_le(value, 4)}")
+
+
+def _map_set_u64(map_id, key, value):
+    bpftool(f"map update id {map_id} key hex {_hex_le(key, 4)} "
+            f"value hex {_hex_le(value, 8)}")
+
+
+def set_hr(rtnl, idx, val):
+    rtnl.setlink({"ifi-index": idx, ATTR: val})
+
+
+class Observer:
+    """Loads the fentry realloc counter (autoattach) and the tc pusher, exposes
+    a reallocs(send_fn) call, and tears both down cleanly on close()."""
+
+    def __init__(self, dev, dev_ifindex, send_ns):
+        self.dev = dev
+        self.send_ns = send_ns
+        # Fresh pin dir; a leftover one would make loadall fail to pin.
+        cmd(f"rm -f {PINDIR}/*", shell=True, fail=False)
+        cmd(f"rmdir {PINDIR}", shell=True, fail=False)
+        # Single fentry program -> autoattach attaches it by SEC name and pins
+        # its maps under PINDIR. No bpftrace, no kprobe name.
+        bpftool(f"prog loadall {PROBE_OBJ} {PINDIR} autoattach")
+        # tc pusher: self-loading via object-file, attached inside the send ns.
+        tc(f"qdisc add dev {self.dev} clsact", ns=send_ns)
+        tc(f"filter add dev {self.dev} egress bpf da object-file {TC_OBJ} sec tc",
+           ns=send_ns)
+        # Resolve the two maps by name from the fentry program.
+        prog_id = self._probe_prog_id()
+        maps = bpf_prog_map_ids(prog_id)
+        self.cfg_id = maps["cfg_ifindex"]
+        self.cnt_id = maps["realloc_cnt"]
+        # Scope the counter to the device under test (by id: a stale pinned copy
+        # of the same-named map would make a by-name update ambiguous).
+        _map_set_u32(self.cfg_id, 0, dev_ifindex)
+
+    @staticmethod
+    def _probe_prog_id():
+        progs = bpftool("prog show", json=True)
+        for p in progs:
+            if p.get("name") == "count_realloc":
+                return p["id"]
+        raise RuntimeError("count_realloc fentry program not loaded")
+
+    def reallocs(self, send_fn):
+        """Reset the counter, run send_fn (traffic), return the realloc count."""
+        _map_set_u64(self.cnt_id, 0, 0)
+        send_fn()
+        time.sleep(0.2)  # let the last in-flight reallocs land
+        return bpf_map_dump(self.cnt_id)[0]
+
+    def close(self):
+        # Detach the fentry link so it does not leak to later tests.
+        links = bpftool("link show", json=True)
+        for l in links:
+            if l.get("attach_type") == "trace_fentry":
+                cmd(f"bpftool link detach id {l['id']}", fail=False)
+        cmd(f"rm -f {PINDIR}/*", shell=True, fail=False)
+        cmd(f"rmdir {PINDIR}", shell=True, fail=False)
+
+
+def _blast_udp(dst, port, n):
+    """Send n small UDP datagrams; the receiver drops them, but the TX-side
+    realloc already happened, which is what we measure."""
+    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
+    s.connect((dst, port))
+    buf = b"x" * 1024
+    for _ in range(n):
+        try:
+            s.send(buf)
+        except OSError:
+            pass
+    s.close()
+
+
+def _setup_veth(peer_ns):
+    """hrt0 in the current netns (send side, tc push attached); hrt1 in peer_ns.
+    Prime a static ARP neighbor so UDP egresses instead of dropping at an
+    unresolved neighbor (which would read 0 reallocs regardless of the knob)."""
+    ip("link add hrt0 type veth peer name hrt1")
+    ip(f"link set hrt1 netns {peer_ns}")
+    ip("addr add 10.0.0.1/24 dev hrt0")
+    ip("link set hrt0 up")
+    ip("link set lo up")
+    with NetNSEnter(str(peer_ns)):
+        ip("addr add 10.0.0.2/24 dev hrt1")
+        ip("link set hrt1 up")
+        ip("link set lo up")
+        peer_mac = ip("link show dev hrt1", json=True)[0]["address"]
+    ip(f"neigh replace 10.0.0.2 lladdr {peer_mac} dev hrt0 nud permanent")
+
+
+def test_realloc_eliminated() -> None:
+    """Knob off -> push reallocates per packet; knob set -> realloc eliminated."""
+    with NetNS() as send_ns, NetNS() as peer_ns, NetNSEnter(str(send_ns)):
+        _setup_veth(peer_ns)
+        rtnl = RtnlFamily()
+        idx = ifindex("hrt0")
+        obs = Observer("hrt0", idx, str(send_ns))
+        try:
+            off = obs.reallocs(lambda: _blast_udp("10.0.0.2", 9999, NPKTS))
+            set_hr(rtnl, idx, 128)
+            on = obs.reallocs(lambda: _blast_udp("10.0.0.2", 9999, NPKTS))
+        finally:
+            obs.close()
+
+        ksft_ge(off, NPKTS // 2, "knob off: push should realloc most packets")
+        ksft_lt(on, NPKTS // 100, "knob on: realloc should be eliminated")
+
+
+def test_realloc_threshold() -> None:
+    """The realloc cliff sits at exactly the headroom the push needs."""
+    with NetNS() as send_ns, NetNS() as peer_ns, NetNSEnter(str(send_ns)):
+        _setup_veth(peer_ns)
+        rtnl = RtnlFamily()
+        idx = ifindex("hrt0")
+        obs = Observer("hrt0", idx, str(send_ns))
+        try:
+            set_hr(rtnl, idx, THRESHOLD - 1)
+            below = obs.reallocs(lambda: _blast_udp("10.0.0.2", 9999, NPKTS))
+            set_hr(rtnl, idx, THRESHOLD)
+            at = obs.reallocs(lambda: _blast_udp("10.0.0.2", 9999, NPKTS))
+        finally:
+            obs.close()
+
+        ksft_ge(below, NPKTS // 2, f"knob={THRESHOLD-1}: still reallocates")
+        ksft_lt(at, NPKTS // 100, f"knob={THRESHOLD}: realloc eliminated at cliff")
+
+
+def main() -> None:
+    ksft_run([test_realloc_eliminated,
+              test_realloc_threshold])
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
-- 
2.50.1

