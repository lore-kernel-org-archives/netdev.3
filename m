Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484AC2E5429
	for <netdev@vger.kernel.org>; Sun, 19 Jul 2026 16:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784478424; cv=none; b=BvjAvhg1LLsWKW+Sabn/curwl29ODtpCbOJ70xEFbDVsD5p2kqFQBV7DazpsqFFH6fhlnirz6yLvEk7OOzoLIjJRFOom8CI4yFfp2WV5WHPzvi5Dkus+Vu5sG/CwifvRpzYTNUvp/KovXRSZGhnUkfzaPsM9SVOGDfxKmZHr0kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784478424; c=relaxed/simple;
	bh=a77LLjiRvnVm2mVRdvgjahBa6yW440xc+pyqWUTMPmM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M5VSxdhsVaY+egYNQttdsUg/bohPiz1gwffbuUR22qXmXmD4xtb5NyG1jlh6FJ2W5Gv7lWVetHJ/0sk5UpFVrgNSxNslDSHQCX4Yr/hIcGQRwmP0B9xftpKrIbtbVSn2N+oEgAp2F7VmFHedtxKdLNQQ9Wz3MdtQuApoP5nsNCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AGFzI9ee; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AGFzI9ee"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38dd55ad76cso2247363a91.1
        for <netdev@vger.kernel.org>; Sun, 19 Jul 2026 09:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784478422; x=1785083222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2+Op0IlLULILDvA0Oq6UAeSLMZtXmzREGUJ4t6ZmAA0=;
        b=AGFzI9eebqJCyv5F1WSrUIzuqFrlRuk/xJC0ex61MQeJCZ0MDjxrx1jevP5h3SZ0o3
         Dl9TZCaV9bnCDcoqpOYPkh0DuA0RMrXUvh1kjyiLVzQrQ7hXITwT348qMjp8jPvKhx7Y
         Fi5+qWvwBnnsJbyyYufOgsieom7RnPayOOHp8DQSuq1XEvRyAK2SfJhKwEMsRhknWcfY
         trVLZv44ptwvzZA8TrUrsxPPZgZgj62EVmyyc0h7WWbW+u3q+Z3ZB4Kn2AxhlNz7n+Wc
         K60+RBKtEdLovD/4O5fquMSoYKkvmmbl/1htHHUi24U859kIBnzBGX6adgthknFHV48f
         tjqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784478422; x=1785083222;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2+Op0IlLULILDvA0Oq6UAeSLMZtXmzREGUJ4t6ZmAA0=;
        b=sYV5qg3r/lspo952zF+LpFX5Fqg1Saf0RAf/dnACJg2r5IVeQH/v7C2ma6no8AZXF2
         nkZJAQNpsiEgrZYthUBC+OSRlSy+reWtjNQhpDrzEXg4aYNbEQ7XLiY50sqCcfjLdYzv
         FklBb0xeHx+bwjUcrMgWt+q7VGsdXWIYVkiHhVvXWpM4OhDczakxWSWdrl9PKYfm31qe
         NR7XDM6FAXb8SXGp1Rmaiy0XFNL2/R8E98K+CYSYnvX/GPklP7kyaQMQvrH8Tg1MjeEh
         GM6dJXTNc7IqxZjYFKhSLDOKjTY+Zq9a5l1a04m1ykshHmgpMI+qD4U2TBFLL/P5Lhrs
         0d0A==
X-Gm-Message-State: AOJu0Yy6KFz+q3ZNx/jPyBMxlXIs1OlCZDGGIvMmG3JYkk6uyCocRKDL
	5MKUXtkq9Oq2dsCFfbjWYP6gzTh4D1QIihO50UgGybgJfrMfZmh3RdW6qnxDOcjFUJ+oEw==
X-Gm-Gg: AfdE7cnTmE48lor6wF1Huyc04or3nDUoQfQkZiFfQPTWgSXnF51r9frWyzlnFSIIBv4
	vzIdOhD5Ek2mwgBfivdH2lDttTX7w3q8CIMFBa+al/DuQMa1vhcRj6rPch/VXWKyrOtbBxvHUvb
	u8gGnGNQYp2bcS/26j5ZcgrXd4/W09VN8oxFbHkzHTGnGB8rZqIFRmAlL2d7fQzY9RaU7udEn/i
	LZh5Qjy82lmxs9/XbXIjz0hqTGWeGK1BTopDM8QIDdZclSy+2DqkjTa0kaAw+d+e+prEXRQ+tP9
	AW3bFF9LIyA+hljaiPmDgL9wMa3RqUhe3lipOoEh79fJInAaBOZqk1lTAXipB+3ojdycuB0oNHh
	QQgsAQVrnlohRxLeXCYMC4gc4pWE95zV3onkGiZOyF6YgUAIlNkdgMdvEjU7eXG7bdqLGHyD3sb
	AFh7w4
X-Received: by 2002:a17:90b:2891:b0:37f:9e21:91d8 with SMTP id 98e67ed59e1d1-38e4b68268bmr10132503a91.15.1784478422158;
        Sun, 19 Jul 2026 09:27:02 -0700 (PDT)
Received: from houminxi ([166.0.188.190])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a1bbda9sm27457185eec.19.2026.07.19.09.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 09:27:01 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	aconole@redhat.com,
	Minxi Hou <houminxi@gmail.com>
Subject: [PATCH net-next v4] selftests/net/openvswitch: add SCTP flow key test
Date: Sun, 19 Jul 2026 12:26:57 -0400
Message-ID: <20260719162657.3263089-1-houminxi@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add test_sctp_connect_v4() to verify OVS can match on SCTP flow keys
(sctp src/dst port).

The test sets up client and server namespaces connected through an
OVS bridge, installs port-keyed flows, and verifies:
  - sctp(dst=4443) matches client-to-server INIT
  - sctp(src=4443) matches server-to-client INIT-ACK
  - removing flows drops the connection
  - reinstalling flows restores connectivity

Signed-off-by: Minxi Hou <houminxi@gmail.com>
---
 .../selftests/net/openvswitch/openvswitch.sh  | 105 ++++++++++++++++++
 .../selftests/net/openvswitch/ovs-dpctl.py    |   5 +
 2 files changed, 110 insertions(+)

v3 -> v4: rebase onto latest net-next (2026-07-19), resolve test list
  conflict from merged trunc test

diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
index f75ee723415a..af9cf0888316 100755
--- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
+++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
@@ -33,6 +33,7 @@ tests="
 	flow_set				flow-set: Flow modify
 	action_set				set: SET action rewrites fields
 	trunc					trunc: output truncation
+	sctp_connect_v4				sctp: SCTP flow key matching
 	psample					psample: Sampling packets with psample"
 
 info() {
@@ -530,6 +531,110 @@ test_trunc() {
 	return 0
 }
 
+# sctp_connect_v4 test
+# - sctp(dst=4443) matches client-to-server INIT
+# - sctp(src=4443) matches server-to-client INIT-ACK
+# - remove flows and verify connection fails, reinstall and recover
+test_sctp_connect_v4() {
+	local t="test_sctp_connect_v4"
+
+	which nc >/dev/null 2>&1 || return $ksft_skip
+	nc --sctp -z 127.0.0.1 1 </dev/null 2>/dev/null || return $ksft_skip
+	modprobe -q sctp 2>/dev/null || return $ksft_skip
+
+	sbx_add "$t" || return $?
+	ovs_add_dp "$t" sctp4 || return 1
+
+	info "create namespaces"
+	for ns in client server; do
+		ovs_add_netns_and_veths "$t" "sctp4" "$ns" \
+		    "${ns:0:1}0" "${ns:0:1}1" || return 1
+	done
+
+	ip netns exec client ip addr add 172.31.110.10/24 dev c1
+	ip netns exec client ip link set c1 up
+	ip netns exec server ip addr add 172.31.110.20/24 dev s1
+	ip netns exec server ip link set s1 up
+
+	# ARP forwarding
+	ovs_add_flow "$t" sctp4 \
+	    'in_port(1),eth(),eth_type(0x0806),arp()' \
+	    '2' || return 1
+	ovs_add_flow "$t" sctp4 \
+	    'in_port(2),eth(),eth_type(0x0806),arp()' \
+	    '1' || return 1
+
+	# SCTP port matching: dst for request, src for reply
+	ovs_add_flow "$t" sctp4 \
+	    'in_port(1),eth(),eth_type(0x0800),ipv4(proto=132),sctp(dst=4443)' \
+	    '2' || return 1
+	ovs_add_flow "$t" sctp4 \
+	    'in_port(2),eth(),eth_type(0x0800),ipv4(proto=132),sctp(src=4443)' \
+	    '1' || return 1
+
+	echo "server" | \
+		ovs_netns_spawn_daemon "$t" "server" \
+				nc --sctp -l 172.31.110.20 -vn 4443
+	local server_pid=$pid
+	ovs_wait ip netns exec server \
+	    ss -lnH sport = :4443 \| grep -q . \
+	    || return 1
+
+	info "verify SCTP association with port-keyed flows"
+	ovs_sbx "$t" ip netns exec client \
+	    nc --sctp -i 1 -zv 172.31.110.20 4443 \
+	    || return 1
+
+	ovs_del_flows "$t" sctp4
+
+	info "verify connection fails without flows"
+	ovs_add_flow "$t" sctp4 \
+	    'in_port(1),eth(),eth_type(0x0806),arp()' \
+	    '2' || return 1
+	ovs_add_flow "$t" sctp4 \
+	    'in_port(2),eth(),eth_type(0x0806),arp()' \
+	    '1' || return 1
+
+	kill -TERM $server_pid 2>/dev/null
+	wait $server_pid 2>/dev/null
+	echo "server2" | \
+		ovs_netns_spawn_daemon "$t" "server" \
+				nc --sctp -l 172.31.110.20 -vn 4443
+	server_pid=$pid
+	ovs_wait ip netns exec server \
+	    ss -lnH sport = :4443 \| grep -q . \
+	    || return 1
+
+	ovs_sbx "$t" ip netns exec client \
+	    nc --sctp -w 2 -zv 172.31.110.20 4443 \
+	    >/dev/null 2>&1 \
+	    && { info "FAIL: connection should fail without flows"
+	         return 1; }
+
+	info "reinstall flows and verify recovery"
+	ovs_add_flow "$t" sctp4 \
+	    'in_port(1),eth(),eth_type(0x0800),ipv4(proto=132),sctp(dst=4443)' \
+	    '2' || return 1
+	ovs_add_flow "$t" sctp4 \
+	    'in_port(2),eth(),eth_type(0x0800),ipv4(proto=132),sctp(src=4443)' \
+	    '1' || return 1
+
+	kill -TERM $server_pid 2>/dev/null
+	wait $server_pid 2>/dev/null
+	echo "server3" | \
+		ovs_netns_spawn_daemon "$t" "server" \
+				nc --sctp -l 172.31.110.20 -vn 4443
+	ovs_wait ip netns exec server \
+	    ss -lnH sport = :4443 \| grep -q . \
+	    || return 1
+
+	ovs_sbx "$t" ip netns exec client \
+	    nc --sctp -i 1 -zv 172.31.110.20 4443 \
+	    || return 1
+
+	return 0
+}
+
 # psample test
 # - use psample to observe packets
 test_psample() {
diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
index e1ecfad2c03e..7cfc29ec7e59 100644
--- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
+++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
@@ -1982,6 +1982,11 @@ class ovskey(nla):
                 "icmp",
                 ovskey.ovs_key_icmp,
             ),
+            (
+                "OVS_KEY_ATTR_SCTP",
+                "sctp",
+                ovskey.ovs_key_sctp,
+            ),
             (
                 "OVS_KEY_ATTR_TCP_FLAGS",
                 "tcp_flags",
-- 
2.55.0

