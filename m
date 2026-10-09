Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4353E3F39F1
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 09:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791536759; cv=none; b=cbFdeGyW+qTO3M08SuIx6NvCajyka0eVCDIBI8rTwJ2mIB+6Rl9S5uMkfRKadwjEaMocNScQMZf2UA9x4/ebDJChWIQEvkOLiNmXdEXmr7xaGBulsNDcP/ujUQMrzuZ21KS9GxGrh35+FpaLllhnfdYwGsZLJ4Ke5xITBm7wtyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791536759; c=relaxed/simple;
	bh=itP9T0thI98u6FFw3su9ObueqkLJ2nQ13a9qgZpMSus=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KmOIy5ZFIdVkeUVSe6ilds2zLBqSKlM93ep993odK4nKf5qjaeC/tTuBK2k8ICyqzgLawkfbIinnwCSDcBQBaraCLnv629A8vYQNDGQmACT+2xt1RYdPvqLkFOKIeo4iCRm8u0nRX1upG9At7pWJQuDDvSpoe7fIEs/s/2fNfsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AOazNKH1; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOazNKH1"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-34c4a0868b6so5671378eec.0
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 02:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791536754; x=1792141554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0zqtG+seOedgCR28/ry2tjSMnhHZSq/rzBKdtct+ntA=;
        b=AOazNKH1MGRlCAwrNHQe+QUYEdiLx64Z3R5yUhbWRZRpNDBd/DePiy7TiwKF3n942/
         Uj/7g+U4U1EWtFrZ9Y12P0/ptQ5TrFAOJ6PK3K/N7QmnD3mSK0icbf1kKVz79gHpJPeF
         JK8niNj/cM3RtpVLNx1aRrwdc8sIsEzHEElX4P+tnY0BdHWAz0hBKyYNqgNcfFdB5yeC
         aLuuLDBr94SgXKK5/qfCKhJPwY2KY7gesWbexhumee5p6aQFxkPTSKXuxxA56BD/u0eY
         IE1/+peDZFZruzHtm6LJKwpAAIitC/9Yt9Obsyf+drdSNEauCvdy1xVZxKa+B+Gr8H5P
         o05g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791536754; x=1792141554;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0zqtG+seOedgCR28/ry2tjSMnhHZSq/rzBKdtct+ntA=;
        b=j5w3V+XQHxjAR/R+0htwRdz2aQxt1dd5WEvnucP3bCXRPP18W0Cj5NaheUjOZTv536
         aPjVhPjq8CpXuHvB3XxpRKBm8IE0olhv+pBLBMhToAXZz+xB74zLtWlJjvAXzNmO0dsu
         u03T4v5QhWzclfLN2n7ngqc4zFm0I9KLpxRPWzYjO4M2TzQZOLIgisIcYbopxsnDY3Mr
         AC8dmFt30HyRk68HYuEuW/NZj7xC75uRUrn6bk0rWgVtA6QewApyGoBdU4LrEYOtmWp2
         AyyFhiqgk1EmmqJqc2miNgfhXQLu0zHoAoRO5jyYVLw7rubNaIA2QahYyGHjQyp7Lqud
         y9DA==
X-Gm-Message-State: AFq9FYI1f8XFbVCPdOBAK0ujj7c/+z3rITb04E1pwYgtTCjg1UrHEnCx
	eZAzU053jukmLBzUzTT3I2LQevXTGKtgnYRPmmaD3DkLrRRnoxBxkGk4SGQfHNYm
X-Gm-Gg: AYBFou2chMV7tcrFsnkzUgw+qwquYo4w7iK7M/8Bujqsu1caGnBrGGTMsv6n0KV9mDu
	W4l1/ewMxExzYmupCuJkEPAzY8KjSK6Wz9vqTvSsO+VMj+K919t0VnkDqKo8xJAG0CfaRsZC+rl
	SWqaUejUjs9zYZMC9+kfzgCv87gxgfN8joA9SPQ5v7Xe/SRah/4HOCCNZinpImYaSaj1EVD14m8
	vmRaJr5XmNBdGGu02tgOJWP7/1NOJm3fcnZ6iRsv9/iWRkla90G+uYf1/5oYustr/btybLvMKKV
	StiutoSLuY0PHiZbfhFTh5iqh4GiaK+hm0K9SB7ePPo4coFQ/1HyfN5mVFWZnaXslk7nU8TmNtl
	6w9QwLNMKz+KcxNeWlpNZg6xW094ZzptPV6OQmDM3RsramJ+iZ/gsRemRoXEQD1V3oMVMEFZPu8
	C/zF4lUl7ewN72IfdLSnkfTbKxFQrru8nuFq3oGCw1dYN8itiYfIjZkC+XnQoWmNs+fg5Hr4YG8
	n6CKPlLD+V55W7qTaz0rSXPbmDM7DU8oA==
X-Received: by 2002:a05:7300:c8c5:b0:34c:6edc:f4d with SMTP id 5a478bee46e88-3537de061f1mr1920696eec.1.1791536753621;
        Fri, 09 Oct 2026 02:05:53 -0700 (PDT)
Received: from obadmin-Precision-3680.atlascopco.group ([167.103.3.1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb68e56sm4909580eec.29.2026.10.09.02.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 02:05:53 -0700 (PDT)
From: Sahaj Chaudhari <sahaj123.sc@gmail.com>
To: netdev@vger.kernel.org
Cc: aconole@redhat.com,
	echaudro@redhat.com,
	i.maximets@ovn.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	dev@openvswitch.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net] selftests: openvswitch: Test SET on later IPv6 fragments
Date: Fri,  9 Oct 2026 14:36:29 +0530
Message-ID: <20261009090629.1694991-1-sahaj123.sc@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add regression coverage for OVS IPv6 SET actions on later IPv6
fragments. A later fragment has no transport header, so the test sends
a crafted noninitial fragment through a source-address SET flow, checks
that the flow counter advances, and looks for a set_ipv6_addr warning.

This covers the later-fragment case handled by the upstream fix.

Signed-off-by: Sahaj Chaudhari <sahaj123.sc@gmail.com>

---
 tools/testing/selftests/net/openvswitch/Makefile   |  2 +-
 tools/testing/selftests/net/openvswitch/config     |  1 +
 .../selftests/net/openvswitch/openvswitch.sh       | 43 +++++++++++++++++++
 .../selftests/net/openvswitch/ovs-ipv6-frag.py     | 48 ++++++++++++++++++++++
 4 files changed, 93 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/openvswitch/Makefile b/tools/testing/selftests/net/openvswitch/Makefile
index 3fd1da2ec07d5..b3260cd354419 100644
--- a/tools/testing/selftests/net/openvswitch/Makefile
+++ b/tools/testing/selftests/net/openvswitch/Makefile
@@ -6,7 +6,7 @@ CFLAGS += -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/include $(KHDR_INC
 
 TEST_PROGS := openvswitch.sh
 
-TEST_FILES := ovs-dpctl.py
+TEST_FILES := ovs-dpctl.py ovs-ipv6-frag.py
 
 EXTRA_CLEAN := test_netlink_checks
 
diff --git a/tools/testing/selftests/net/openvswitch/config b/tools/testing/selftests/net/openvswitch/config
index a825e0b5c88e5..b062ebbce0f00 100644
--- a/tools/testing/selftests/net/openvswitch/config
+++ b/tools/testing/selftests/net/openvswitch/config
@@ -3,6 +3,7 @@ CONFIG_INET_DIAG=y
 CONFIG_IP_SCTP=y
 CONFIG_IPV6=y
 CONFIG_NETFILTER=y
+CONFIG_DEBUG_NET=y
 CONFIG_NET_IPGRE=m
 CONFIG_NET_IPGRE_DEMUX=m
 CONFIG_NF_CONNTRACK=m
diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
index a31f7fb6882dc..b9a4c4bf40672 100755
--- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
+++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
@@ -31,6 +31,7 @@ tests="
 	dec_ttl					ttl: dec_ttl decrements IP TTL
 	flow_set				flow-set: Flow modify
 	action_set				set: SET action rewrites fields
+	ipv6_later_frag				ipv6-frag: SET on a later IPv6 fragment
 	trunc					trunc: output truncation
 	icmpv6					icmpv6: ICMPv6 echo type match
 	sctp_connect_v4				sctp: SCTP flow key matching
@@ -66,6 +67,11 @@ ovs_wait() {
 	return 1
 }
 
+ovs_flow_has_packets() {
+	python3 "$ovs_base/ovs-dpctl.py" dump-flows "$1" |
+		grep -Eq 'packets:[1-9][0-9]*,'
+}
+
 ovs_base=`pwd`
 sbxs=
 sbx_add () {
@@ -445,6 +451,43 @@ test_action_set() {
 	return 0
 }
 
+test_ipv6_later_frag() {
+	local t="test_ipv6_later_frag"
+	local warning="WARNING:.*set_ipv6_addr"
+	local before after
+
+	if ! dmesg >/dev/null 2>&1; then
+		info "dmesg unavailable - cannot check for kernel warning"
+		return $ksft_skip
+	fi
+
+	before=$(dmesg | grep -c "$warning" || true)
+	if [ "$before" -ne 0 ]; then
+		info "set_ipv6_addr warning already present - skipping"
+		return $ksft_skip
+	fi
+
+	sbx_add "$t" || return 1
+	ovs_add_dp "$t" fragtest || return 1
+	ovs_add_netns_and_veths "$t" fragtest client c0 c1 || return 1
+
+	ovs_add_flow "$t" fragtest \
+		'in_port(1),eth(),eth_type(0x86dd),ipv6(proto=44)' \
+		'set(ipv6(src=2001:db8::99,proto=44)),drop' || return 1
+
+	ip netns exec client python3 "$ovs_base/ovs-ipv6-frag.py" c1 || \
+		return 1
+	ovs_wait ovs_flow_has_packets fragtest || return 1
+
+	after=$(dmesg | grep -c "$warning" || true)
+	if [ "$after" -ne "$before" ]; then
+		info "set_ipv6_addr warning emitted for later IPv6 fragment"
+		return 1
+	fi
+
+	return 0
+}
+
 # trunc test
 # - trunc(14): truncate to ETH_HLEN, strips IP payload, ping fails
 # - trunc(1) and trunc(13): kernel rejects below ETH_HLEN (EINVAL)
diff --git a/tools/testing/selftests/net/openvswitch/ovs-ipv6-frag.py b/tools/testing/selftests/net/openvswitch/ovs-ipv6-frag.py
new file mode 100644
index 0000000000000..869f9d6503ef4
--- /dev/null
+++ b/tools/testing/selftests/net/openvswitch/ovs-ipv6-frag.py
@@ -0,0 +1,48 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+import ipaddress
+import socket
+import struct
+import sys
+
+
+def main():
+    if len(sys.argv) != 2:
+        print(f"Usage: {sys.argv[0]} INTERFACE", file=sys.stderr)
+        return 2
+
+    interface = sys.argv[1]
+    payload = bytes(range(8))
+    # Offset 1 and M=1 make this a noninitial fragment.
+    fragment = struct.pack("!BBHI", socket.IPPROTO_TCP, 0, 0x0009, 1)
+    ipv6 = struct.pack(
+        "!IHBB16s16s",
+        6 << 28,
+        len(fragment) + len(payload),
+        socket.IPPROTO_FRAGMENT,
+        64,
+        ipaddress.IPv6Address("2001:db8::1").packed,
+        ipaddress.IPv6Address("2001:db8::2").packed,
+    )
+    ethernet = struct.pack(
+        "!6s6sH",
+        b"\xff" * 6,
+        bytes.fromhex("020000000001"),
+        0x86DD,
+    )
+    packet = ethernet + ipv6 + fragment + payload
+
+    with socket.socket(
+        socket.AF_PACKET, socket.SOCK_RAW, socket.htons(0x0003)
+    ) as sock:
+        sock.bind((interface, 0))
+        sent = sock.send(packet)
+
+    if sent != len(packet):
+        raise OSError(f"short packet send: {sent} of {len(packet)} bytes")
+    return 0
+
+
+if __name__ == "__main__":
+    sys.exit(main())
