Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB054483A5
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 14:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785249377; cv=none; b=b0I5k/vnFk8v5gMNCSMFMHNF/qOA/sBgpGvon8fheIb2nYYpdHy57IusLeN0nZ9Vpt7lrKVaheaBZKM9ehIk2qu8qeORDmy4e4e1XuIyIG1MZjRIWlnEFuO5XvHTPHG71+g/hoLcszJ78btmSK2s4WO+A16FUszp8C1OCQDVOhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785249377; c=relaxed/simple;
	bh=bnPrbIsgo0B4ui24nEEHwECPfVxDiL54JLh1BUGmpig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u/kbJMbBYVLLldljs2OgmfuAujbIJi19dM+sGAxtUSr1/uslGLjeMWzFxa5syQKYEx+m+9LKw3FBEpzvkgKoCY3Ac4fX8ZRWzH1duIHUL5h5mUv7a/p2mjSfm/URURuVSa45EHuee1wbgGUVYXTnjjIOfJv+xK2KuazuwxdwDcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fS1KGjaz; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fS1KGjaz"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-495502852d1so3694185e9.2
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 07:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785249370; x=1785854170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NdInEAZ8nn3vO1nlplnXdsK6Xwfl3pVvKWeDQ7dke3Y=;
        b=fS1KGjaz0eGsDdzhzYezsMIiHR9ZOOOga9Bh4nhcp5XS6MGZAY51r/dFKK4l/wRYjD
         8UiJ9jyW62xLLz9BzT6VMQl16knZb5d7XGxuLrnDkWCaf+I7w9NIXvZjCGJrQWa+p8ry
         f0M4c2Fq8aS6QKTWAYRlg+NuPFSfBAPZf3Ym6EpK4yomIv1dFYReGQL2SgaoEbhzmIaA
         XDaTkCVCZo/sRUfKYv/zf5qkpvMf5kaNwWWmPE7sEcuhbzA15PrcgHML5QPPj9W3K9z1
         hiHavk7jMRNeqmkHt0e5t21+2c2uSGplL5qFm6ERZ+jPzmfCtkzA9JpyZOhjiWQ0y5K3
         uR2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785249370; x=1785854170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NdInEAZ8nn3vO1nlplnXdsK6Xwfl3pVvKWeDQ7dke3Y=;
        b=bmT4H8o8OncdPdp06xihA0Ydyj0Dacp9SdkvS/XVKmW/eikZAf/cPEvCpqL5oqTxgZ
         yaS0CkmwqCMhy0Zlyr5JYclJThXx9BCmdHBXZ9rrArcC3DI7Jq1T+ZumXZfO2MZLfO8T
         J7NMv4R9BYXk1qXA2rvid7MM8lCRI1l6cEh7c6LDXJLMKv2CDvDpzu/+pvUmW7hL4MmA
         7q2DINPbGNhYQYW/te76WxYJdHMmIs7HNdygUhbJtcdykBIVrIu94lbTrE4zuCPlzLg7
         jbYgmV+qG+ZT2chbHlFC+FpUNkdDhwOwUkYx0ClspC+zOjZSi5ruv51nZYMbdHZ+LAmt
         HtIw==
X-Forwarded-Encrypted: i=1; AHgh+RoUwTULaSeGA5wYVLltQa0tQ+ZCzSUIXu6e7cZpe/aHP8iynkVRLUMSSt2G4lYgubBcqzrgW78=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBIabnc0pX5Xzkcf09MCbDAeofML/H/eGG6ni7zplPgWF1+a7N
	t+C8r6n4CR/iNPbxdygGVOPZOZKCCaxBg10zgy7rySRW3EKkFNmLccH4
X-Gm-Gg: AR+sD11qKd+9A8TuXD4bh0xwsaUc+edon1+2CHy9BYUccHgPsWtK7yeRNo7xbkqT/K+
	1kgQbS2LgxvzQwSITP9UwIVxpUrclg15P8H4oZzKmUJMXrzlw+r2qDD1vuLL9tG73QpYbLcnJxx
	VmmbSq3inx+IDl8Hd0TL4UdRV9gLHJEFazD870SlDpc6nQd8smO0hjRzxlF5KnnlzwHQahO5tpA
	b/7/0lfM6+gJPKZoijyXlHZMq5yz0TVETwR7HjzZrJ2jfLKptx2KwnLi9dd/OrVVC2fPTP2k+KK
	fSw0Dqvr8OL4BaHpOeNMHsVRWyiOiTXu3mwZ+8kPXjNv+gIznFqE81QOz3bSfzO52pye4I9ebMG
	GcHEwg2o/XGdKtsvdeVTOSaTlkXYPcxyMn45T8TJ06t8AocQ8kA8A4dMXgyi2ptvzucjV9LCBlr
	2IfbpGsua6+lh8ivHftnVRmcKFcjTFpPR53CqgJaZUACYsV/0epItLmOLaprlVH1vl2JmPncqee
	rSKHJxZKymnvWN2TZ0CXoUsj70lqff8DPImoWA=
X-Received: by 2002:a05:600c:1912:b0:490:ec79:3046 with SMTP id 5b1f17b1804b1-496c60b4949mr17676285e9.0.1785249370304;
        Tue, 28 Jul 2026 07:36:10 -0700 (PDT)
Received: from L-022584.energy.envision.com (dynamic-077-179-168-074.77.179.pool.telefonica.de. [77.179.168.74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957bfe07e1sm303390105e9.3.2026.07.28.07.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 07:36:09 -0700 (PDT)
From: Xin Xie <xiexinet@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: edumazet@google.com,
	horms@kernel.org,
	shuah@kernel.org,
	lukma@denx.de,
	m-karicheri2@ti.com,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Xin Xie <xiexinet@gmail.com>
Subject: [PATCH net 3/3] selftests: net: hsr: add shared-mutation regression test
Date: Tue, 28 Jul 2026 16:36:04 +0200
Message-ID: <20260728143604.26-4-xiexinet@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728143604.26-1-xiexinet@gmail.com>
References: <20260728143604.26-1-xiexinet@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cover both shared-skb mutation classes with one test. The PRP LAN-ID
case injects 200 pre-tagged frames on the master with one slave
egress delayed by netem and selects exactly the injected flow: on an
affected kernel all 200 frames leave slave A with slave B LAN ID
(FAIL); with the helpers privatizing clone data before the ID update
both sides stay isolated (PASS). The HSR RedBox source-MAC case
injects a tagged multicast data frame on a slave of an HSR RedBox:
on an affected kernel the local stack receives the RedBox MAC
instead of the originating node MAC (FAIL); with the interlink-bound
skb privatized before the rewrite, the master keeps the node MAC and
the interlink keeps the RedBox MAC (PASS).

Capture filters select destination, post-strip EtherType, and the
exact payload while leaving the asserted source MAC unfiltered.
Capability probes (tc, python3, sch_netem, HSR/PRP support) exit
ksft_skip and that status is propagated; real failures exit 1.

Signed-off-by: Xin Xie <xiexinet@gmail.com>
---
 tools/testing/selftests/net/hsr/Makefile      |   1 +
 .../selftests/net/hsr/hsr_shared_mutation.sh  | 213 ++++++++++++++++++
 2 files changed, 214 insertions(+)
 create mode 100755 tools/testing/selftests/net/hsr/hsr_shared_mutation.sh

diff --git a/tools/testing/selftests/net/hsr/Makefile b/tools/testing/selftests/net/hsr/Makefile
index 31fb9326cf..aeae7f3d6d 100644
--- a/tools/testing/selftests/net/hsr/Makefile
+++ b/tools/testing/selftests/net/hsr/Makefile
@@ -7,6 +7,7 @@ TEST_PROGS := \
 	hsr_redbox.sh \
 	link_faults.sh \
 	prp_ping.sh \
+	hsr_shared_mutation.sh \
 # end of TEST_PROGS
 
 TEST_FILES += hsr_common.sh
diff --git a/tools/testing/selftests/net/hsr/hsr_shared_mutation.sh b/tools/testing/selftests/net/hsr/hsr_shared_mutation.sh
new file mode 100755
index 0000000000..27103541cd
--- /dev/null
+++ b/tools/testing/selftests/net/hsr/hsr_shared_mutation.sh
@@ -0,0 +1,213 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Verify that per-egress mutations of shared skb data are private:
+#
+# F2 (path/LAN ID): on an affected kernel the second slave's LAN-ID write
+# lands in the first slave's still-queued clone; with a netem delay on
+# slave A, injected frames leave A carrying B's LAN ID.
+#
+# F1 (RedBox source MAC): on an affected kernel an HSR-tagged multicast
+# frame received on a RedBox slave is cloned for master and interlink,
+# and the interlink's RedBox-MAC rewrite lands in the master clone's
+# buffer, so the local stack receives the RedBox MAC instead of the
+# originating node's MAC.
+
+ipv6=false
+
+source ./hsr_common.sh
+
+DUR=5
+
+require()
+{
+	command -v "$1" >/dev/null 2>&1 && return 0
+	echo "SKIP: $1 not available"
+	exit $ksft_skip
+}
+
+require ip
+require tc
+require python3
+
+trap cleanup_all_ns EXIT
+
+# ------------------------------------------------------- F2: LAN-ID isolation
+# PRP DANP (proto 1), AF_PACKET pre-tagged injection, netem on slave A.
+run_f2()
+{
+	setup_ns ns 2>/dev/null || return $ksft_skip
+	nsx() { ip netns exec "$ns" "$@"; }
+
+	# Probe sch_netem inside the disposable namespace only.
+	if ! nsx tc qdisc add dev lo root netem delay 1ms 2>/dev/null; then
+		echo "SKIP: sch_netem not available"
+		return $ksft_skip
+	fi
+	nsx tc qdisc del dev lo root 2>/dev/null
+
+	# Capability probes end here; setup or runtime failure below is FAIL.
+	nsx ip link add vA type veth peer name vAp || { echo "FAIL: veth A"; return 1; }
+	nsx ip link add vB type veth peer name vBp || { echo "FAIL: veth B"; return 1; }
+	for i in vA vB vAp vBp; do
+		nsx ip link set "$i" up || { echo "FAIL: $i up"; return 1; }
+	done
+	nsx ip link add name prp0 type hsr slave1 vA slave2 vB supervision 45 proto 1 2>/dev/null
+	if [ $? -ne 0 ]; then
+		echo "SKIP: HSR/PRP not supported by this kernel"
+		return $ksft_skip
+	fi
+	nsx ip link set prp0 up || { echo "FAIL: prp0 up"; return 1; }
+	nsx tc qdisc add dev vA root netem delay 200ms || { echo "FAIL: netem"; return 1; }
+
+	nsx python3 /dev/stdin "$DUR" <<'PYF2'
+import socket, struct, select, sys, time
+
+dur = int(sys.argv[1])
+def lanid(pkt):
+    if len(pkt) < 20 or pkt[-2:] != b"\x88\xfb":
+        return None
+    return (pkt[-4] >> 4) & 0xF
+
+SRC = bytes.fromhex(open("/sys/class/net/prp0/address").read().replace(":", ""))
+DST = bytes.fromhex("02aabbccdd01")
+PAY = bytes(range(46))
+rct0 = struct.pack(">H", 0) + struct.pack(">H", 52 & 0x0FFF) + b"\x88\xfb"
+frame = DST + SRC + b"\x08\x00" + PAY + rct0
+
+tx = socket.socket(socket.AF_PACKET, socket.SOCK_RAW); tx.bind(("prp0", 0))
+sA = socket.socket(socket.AF_PACKET, socket.SOCK_RAW,
+        socket.ntohs(0x0003))
+sA.bind(("vAp", 0))
+sB = socket.socket(socket.AF_PACKET, socket.SOCK_RAW,
+        socket.ntohs(0x0003))
+sB.bind(("vBp", 0))
+sA.setblocking(False); sB.setblocking(False)
+for _ in range(200):
+    tx.send(frame); time.sleep(0.001)
+
+a, b = [], []
+end = time.time() + dur
+while time.time() < end:
+    r, _, _ = select.select([sA, sB], [], [], 0.3)
+    for s in r:
+        pkt = s.recv(65535)
+        if (pkt[:6] != DST or pkt[6:12] != SRC or pkt[12:14] != b"\x08\x00"
+                or pkt[14:14 + len(PAY)] != PAY):
+            continue
+        lid = lanid(pkt)
+        if lid is not None:
+            (a if s is sA else b).append(lid)
+
+print("A-side count=%d lan ids=%s" % (len(a), sorted(set(a))))
+print("B-side count=%d lan ids=%s" % (len(b), sorted(set(b))))
+if len(a) < 150 or len(b) < 150:
+    print("FAIL: too few injected frames captured (A=%d B=%d, sent 200)" % (len(a), len(b)))
+    sys.exit(1)
+bad_a = [x for x in a if (x & 1) != 0]
+bad_b = [x for x in b if (x & 1) != 1]
+if bad_a or bad_b:
+    print("FAIL: shared-mutation corruption - A: %d/%d wrong-lan, B: %d/%d wrong-lan"
+          % (len(bad_a), len(a), len(bad_b), len(b)))
+    sys.exit(1)
+print("PASS: per-egress LAN IDs isolated (A all bit0=0, B all bit0=1)")
+sys.exit(0)
+PYF2
+}
+
+# --------------------------------------------- F1: RedBox source-MAC privacy
+# HSR RedBox (proto 0), tagged multicast from a slave: master must keep
+# the node MAC, interlink must carry the RedBox MAC.
+run_f1()
+{
+	setup_ns ns 2>/dev/null || return $ksft_skip
+	nsx() { ip netns exec "$ns" "$@"; }
+
+	nsx ip link add vA type veth peer name vAp || { echo "FAIL: veth A"; return 1; }
+	nsx ip link add vB type veth peer name vBp || { echo "FAIL: veth B"; return 1; }
+	nsx ip link add vI type veth peer name vIp || { echo "FAIL: veth I"; return 1; }
+	for i in vA vB vI vAp vBp vIp; do
+		nsx ip link set "$i" up || { echo "FAIL: $i up"; return 1; }
+	done
+	nsx ip link add name hsr0 type hsr slave1 vA slave2 vB interlink vI \
+		supervision 45 proto 0 2>/dev/null
+	if [ $? -ne 0 ]; then
+		echo "SKIP: HSR RedBox not supported by this kernel"
+		return $ksft_skip
+	fi
+	nsx ip link set hsr0 up || { echo "FAIL: hsr0 up"; return 1; }
+
+	nsx python3 /dev/stdin <<'PYF1'
+import socket, select, sys, time
+
+NODE  = bytes.fromhex("021122334455")
+MCAST = bytes.fromhex("01005e000001")
+RB    = bytes.fromhex(open("/sys/class/net/vI/address").read().replace(":", ""))
+PAY   = bytes(range(46))
+
+def frame(seq):
+    tag = ((1 << 12) | len(PAY)).to_bytes(2, "big") + seq.to_bytes(2, "big") + b"\x08\x00"
+    return MCAST + NODE + b"\x89\x2f" + tag + PAY
+
+tx = socket.socket(socket.AF_PACKET, socket.SOCK_RAW); tx.bind(("vAp", 0))
+sm = socket.socket(socket.AF_PACKET, socket.SOCK_RAW,
+        socket.ntohs(0x0003))
+sm.bind(("hsr0", 0))
+si = socket.socket(socket.AF_PACKET, socket.SOCK_RAW,
+        socket.ntohs(0x0003))
+si.bind(("vIp", 0))
+sm.setblocking(False); si.setblocking(False)
+
+for i in range(3):
+    tx.send(frame(i + 1)); time.sleep(0.05)
+
+m_src = i_src = None
+end = time.time() + 4
+while time.time() < end and (m_src is None or i_src is None):
+    r, _, _ = select.select([sm, si], [], [], 0.3)
+    for s in r:
+        pkt = s.recv(65535)
+        # exact flow: dst, post-strip EtherType, exact payload, min length;
+        # h_source is the asserted value and must NOT be filtered on
+        if (len(pkt) < 60 or pkt[:6] != MCAST or pkt[12:14] != b"\x08\x00"
+                or pkt[14:14 + len(PAY)] != PAY):
+            continue
+        if s is sm and m_src is None:
+            m_src = pkt[6:12]
+        elif s is si and i_src is None:
+            i_src = pkt[6:12]
+
+print("master h_source    =", m_src.hex() if m_src else None)
+print("node MAC           =", NODE.hex())
+print("interlink h_source =", i_src.hex() if i_src else None)
+print("redbox MAC         =", RB.hex())
+if i_src != RB:
+    print("FAIL: interlink did not carry the RedBox MAC")
+    sys.exit(1)
+if m_src != NODE:
+    print("FAIL: master received %s instead of the node MAC "
+          "(shared-mutation corruption)" % (m_src.hex() if m_src else "nothing"))
+    sys.exit(1)
+print("PASS: master kept node MAC, interlink kept RedBox MAC")
+sys.exit(0)
+PYF1
+}
+
+rc=0
+
+run_f2
+ret=$?
+[ "$ret" -eq "$ksft_skip" ] && exit "$ksft_skip"
+[ "$ret" -eq 0 ] || rc=1
+
+run_f1
+ret=$?
+[ "$ret" -eq "$ksft_skip" ] && exit "$ksft_skip"
+[ "$ret" -eq 0 ] || rc=1
+
+if [ $rc -eq 0 ]; then
+	echo "hsr_shared_mutation: per-egress mutation isolation (F1+F2) [ OK ]"
+else
+	echo "hsr_shared_mutation: per-egress mutation isolation [ FAIL ] rc=$rc" 1>&2
+fi
+exit $rc
-- 
2.43.0

