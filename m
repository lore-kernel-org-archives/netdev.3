Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740D440B6FC
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 08:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784796131; cv=none; b=KBaGN3ELT4SEGba3p7vcw3T7Soea7GiB+gYxK5MP5ZTFT0+qnh9e48013MXMUmQqaszXe4zVpfqWTa2+Y+cFlZaOdqjPZf0Eij8ARn5mNDlfY2+Prfk47+pTYuXR853jPrxThBIIU9tG3yh14jq5NF/Sa28lGNz/dffi+VsjgxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784796131; c=relaxed/simple;
	bh=CJWmuhxQpR0eGDdnJMwCAlCqE39i7gbr0TiMceq/7RQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HZOA2xIP4zTuUVAkh+iiQuYMB83uhZ3bEyOuCsFAVphg6IBU12UFIu3SPVAl+c/zEVf5KtMlBMvsSDK7NP+A8BVCxJokEftKZdVAxIwqSTvxoan4UsBd4YLaYolZP9D1SmzDd25nLqODoUkuwhw0UjWTh08WWHMERob0TT33KPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lzUzi8zR; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzUzi8zR"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cb5a6aa8760so248154a12.1
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 01:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784796129; x=1785400929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=G2hldM2eThsLtSaTJ936Ui80Lk1ZzmTpr89wVHuw4Ac=;
        b=lzUzi8zRjEQO6mkccOgCMdUemSHjFXFep1wBdZp4zlPJokIblOPq4hg825833mu5RK
         4P/A8evVU4EBp9qYlm6RO97bzmCPwdWiXe4qYdvXaq1Mi6PBwKjDlr942jbip9Wd6Loa
         RdrMxfW+q8EkQqkKfztiJRQIGlrN2l8gwtmDlhbiO1uNk6tuNwQYkQ16IjNgJ48n/5lN
         3iAhtBhASDDT/DwXzMlAeg+D9Smd9OFyd7Ul+24hICAWc639w3j84baEtQ0yDZht+W5S
         gpu/Cn4l6i1PctzxHQFLsXQkfsbPjKdWxHJ54gW3QmUOSbgedXorkqOL01EQO0tZHTKl
         u35A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784796129; x=1785400929;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G2hldM2eThsLtSaTJ936Ui80Lk1ZzmTpr89wVHuw4Ac=;
        b=qcQZ3pbxKp5NMkLhlXrjsXcsezXfTX9N+9fWAtU2/tZj7dOk2aoKjC6m9us+lc/HU/
         CGSz3f21k1TTjfMw9pW+t5R4D+0d6bMU7kPzzYsvBIgIW044z4ZmAzMXjB/FzddEHhRp
         AxTk7WGOOReCVQ7AuQTTZuxGV21x8dg6oD8amZiCxVgj++dspLdHzVDV300oJmNzDLxP
         hbZ2pgjN2CVi+Mw4uzT63/cfaIMDL7J90iSqmHqIaVceghIu13Gnu9x9tZNvh0a5Gk5v
         aF7m9p6X0LiIMYx0oU7uM9KdzFGNdh8n4zZz6fyOmhkXTQWwmc72s5/29C+2UfSLMi7d
         gbPA==
X-Gm-Message-State: AOJu0YwvRoMa+/wNA+7/nvY0RdKp5n80zUZIxT09a+CIANlpHiZeNSQa
	7afbpVV+uWjXWhgkW8WLLrPG8poimadus9KIdIm7r5k7Ywa2Uk9z0Kj9cuQxBFP317Kk/Q==
X-Gm-Gg: AR+sD11xFO/4/32laUpjJ15kOgdVHjqdsS+YKgLL+jFpXeEgZDkgqVW18i5gjYVWdAR
	oyzVmN7vARszKfBfLAoN3qVlOUxi3e2X7PZsw8j/3lKKNHTJdxM4smnyciarNGUeCfwfBArUkqB
	O2HfOWDS+86q2P4/9vZ4Cn3Mn/F1cJwRkjGjflJoN0gvpSPikEBk+G5SqCJhy3xvR0f7hp0ClTl
	EVj9t9sHkMRor4LNOBg78Su32l41sTzM64GGCt563Ws7x+x6SNTKfQ7jfc3O4GA+ADicqlw8f9f
	lwCmYep82ZnOBurf/vEloVSUzwUEeflZE/q6Os6wdh+8SPzd3gbuZ+co3vxi7b8fKS7/8wI5f4L
	LePsv+jhXo4R0i6LFPZG51ovYcPNzgDn1Sq/tUjhDMsFJp26v/6NzsHrFRZ/6Qwncu041
X-Received: by 2002:a05:6300:2290:b0:3bf:a11c:176e with SMTP id adf61e73a8af0-3c44b246bc8mr2347332637.57.1784796128626;
        Thu, 23 Jul 2026 01:42:08 -0700 (PDT)
Received: from houminxi ([38.34.12.160])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d130a8421sm12742471c88.10.2026.07.23.01.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 01:42:08 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	aconole@redhat.com,
	echaudro@redhat.com,
	i.maximets@ovn.org,
	Minxi Hou <houminxi@gmail.com>
Subject: [PATCH net-next v5] selftests/net/openvswitch: add SCTP flow key test
Date: Thu, 23 Jul 2026 04:42:03 -0400
Message-ID: <20260723084203.3483560-1-houminxi@gmail.com>
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
 .../selftests/net/openvswitch/openvswitch.sh  | 101 ++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
index 853dbc1b00d7..176361f9e60f 100755
--- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
+++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
@@ -34,6 +34,7 @@ tests="
 	action_set				set: SET action rewrites fields
 	trunc					trunc: output truncation
 	icmpv6					icmpv6: ICMPv6 echo type match
+	sctp_connect_v4				sctp: SCTP flow key matching
 	psample					psample: Sampling packets with psample"
 
 info() {
@@ -611,6 +612,106 @@ test_icmpv6() {
 	return 0
 }
 
+# sctp_connect_v4 test
+# - sctp(dst=4443) matches client-to-server INIT
+# - sctp(src=4443) matches server-to-client INIT-ACK
+# - remove flows and verify connection fails, reinstall and recover
+test_sctp_connect_v4() {
+	local t="test_sctp_connect_v4"
+
+	modprobe -q sctp 2>/dev/null || return "$ksft_skip"
+	socat -V 2>&1 | grep -q SCTP || return "$ksft_skip"
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
+	ovs_netns_spawn_daemon "$t" "server" \
+	    socat -u SCTP4-LISTEN:4443 STDOUT
+	local server_pid="$pid"
+	ovs_wait bash -c \
+	    "ip netns exec server ss -lnH sport = :4443 | grep -q ." \
+	    || return 1
+
+	info "verify SCTP association with port-keyed flows"
+	ovs_sbx "$t" ip netns exec client \
+	    socat -u STDIN SCTP4-CONNECT:172.31.110.20:4443 </dev/null \
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
+	kill -TERM "$server_pid" 2>/dev/null
+	wait "$server_pid" 2>/dev/null
+	ovs_netns_spawn_daemon "$t" "server" \
+	    socat -u SCTP4-LISTEN:4443 STDOUT
+	server_pid="$pid"
+	ovs_wait bash -c \
+	    "ip netns exec server ss -lnH sport = :4443 | grep -q ." \
+	    || return 1
+
+	ovs_sbx "$t" ip netns exec client \
+	    socat -u STDIN SCTP4-CONNECT:172.31.110.20:4443 </dev/null \
+	    >/dev/null 2>&1 \
+	    && { info "connection should fail without flows"
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
+	kill -TERM "$server_pid" 2>/dev/null
+	wait "$server_pid" 2>/dev/null
+	ovs_netns_spawn_daemon "$t" "server" \
+	    socat -u SCTP4-LISTEN:4443 STDOUT
+	ovs_wait bash -c \
+	    "ip netns exec server ss -lnH sport = :4443 | grep -q ." \
+	    || return 1
+
+	ovs_sbx "$t" ip netns exec client \
+	    socat -u STDIN SCTP4-CONNECT:172.31.110.20:4443 </dev/null \
+	    || return 1
+
+	return 0
+}
+
 # psample test
 # - use psample to observe packets
 test_psample() {
-- 
2.55.0

