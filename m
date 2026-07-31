Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B7535F185
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 06:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785479232; cv=none; b=Sjemkk7KCmfswjssTBBKXt70j5ExV4A6/GQgQh4F/8oreOJx1HBd7oe05T0vTQqKUHLJWyQuabZ1JiTSdfe1omKi8i78me7BUMq3uy/CSdyn01a/CU2WWj62J2npZSiGq/nsdOrw4U/3xaJXs65FToYpF7CKcd55E/gwMqtwPDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785479232; c=relaxed/simple;
	bh=qlP1Ss2+iQRQZGMU3GyCe6quBisBEuRYCxF7tBPIKKU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ouTV/vsidBTIgZD+hC0QZXIf7MnApw5lt03lBxtAYcgAebSx5jQ2ajoEJfxR4ZubZUNMjbQLFkgQxOktugaBtRfhW3LHpyP2bQEBIW/vbQnDYKm0qbpASuu7wPqOkwG7gzIxpCJdoYHAYaXoBlOnJFT8LHcn0naS2XcHD8OrSMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dYLRqDS1; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYLRqDS1"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5bfaf91daa2so186444e0c.0
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 23:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785479230; x=1786084030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Fm1589V0FXrNea29MR1Diml5jD8aBSSRQXiX/5Cuv98=;
        b=dYLRqDS1qoVxwydd4nxsHzof09+q/r0Hr8np22ayfn9XbS6HVaB3Uc3LuNO/j2UBDi
         mkjvSHNp4IrESl5Z0U6buhTqWNPDyYxX+djrUHS6HqDMFz5ZvQWiWcOroPzpZe8BhY3M
         EDkhvDQbIx0dNhPUTbGcn5mc0xo3eC3dcAjA1zwlzROVICWd/5ajmg41i7ao+givv/c5
         eHKGYCjpmgPjqqzH9JBUA+B2crfirvJFtUTYmyOOIhS5aUIpH3feaFfIf58GuY6g4Tqb
         xuvEPBiXBRTrdU8/1cqgZNEb1ji5So8nn5p65HbDzituLqJJS7WGd28G5GuJx699VVUN
         X7vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785479230; x=1786084030;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fm1589V0FXrNea29MR1Diml5jD8aBSSRQXiX/5Cuv98=;
        b=DuEQu985xC9IJSlQbc3S5+ueQMxFva8SNPbVzj1g6/vKLNJPd4YOdymg0xN49n8Xc0
         Eh6sQfrlYg5BMkF5QZKq0aAX/BGEY2mTqLmxo0Recmo0o9PaMyWm+qb9ZRkv4lwCblj0
         8Ctyxet99QuZWkIWy32ZWdylLly51uD/bC/HsCyliTTL87XnlUYkfN61pAt4ctkW2V2w
         3YkXuT2ZCF0DmT0clsp0j3vZhK2MQKVX1l9wNYSyBRkCXWeeDi1Pa3Voex5AdS9EonD5
         U9qQJz9c/hQ4jKfey83nRiR90kVG3C0Khmh4k0KoXi5iuEMB+tcD2emuV9vzNUqPlE6Q
         rgbA==
X-Gm-Message-State: AOJu0YyfyKW7Y/j7CoYSeM08K6/tEVn2Jx+dvqGaSDz8ISoao3Hu8wG5
	uaZS0+Z1L6PP2jTxQFwHTqMAsPu8BEEzNqGn6nLXIPg3lGgjVx7nrq+fMww0Idjszsw=
X-Gm-Gg: AR+sD12qitRI5c7CWZ8gdWY8C+31zCPOWX1hRBERbGyAjTab+pJxqjmwI0M2uENX2e4
	tKxXMYzzocNZMLczDGhxyEIBNsDZvNGu8e37JCWUMItY2pyAXHBkz0ofeFXgSqjxr4AxfbaPw0P
	jlb31OAM+FMnYI594r6qTC9xrOpiXh96x/eVCjrtbbSEUFhDTpOSI3BSoNSFomj9gWk1AiXISPv
	affCQR5C1irQahV8AQNbHzO6vyAza4ugig2p6g0APILQigz+AsUcheLaObuziT4hZj40lAK7oZC
	cHj0+OXVLX1B0BmOQik6SwBz4Z1EvXhM7aN3gEr95G8bn/khCB8ipzcvl+MKOC+BoKTx4FRWbfu
	AIYJPDuS+DY43EbGK4skYTLFAD8MyGQaqoC3FGqp3qflPtnFTnoRSVTLMDDogszmJj3vhY6YtFO
	qPPe6RTymMiLiiuyF1Gg+ncbMl4n31k+d3LIURhzFBy7H+zZjYC2Wb9Zk=
X-Received: by 2002:a05:6122:6586:b0:5c1:332f:b40a with SMTP id 71dfb90a1353d-5c37e353177mr177673e0c.9.1785479229512;
        Thu, 30 Jul 2026 23:27:09 -0700 (PDT)
Received: from houminxi ([104.167.197.198])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c37eac0b38sm420304e0c.2.2026.07.30.23.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 23:27:09 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	aconole@redhat.com,
	echaudro@redhat.com,
	i.maximets@ovn.org,
	dev@openvswitch.org,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	Minxi Hou <houminxi@gmail.com>
Subject: [PATCH net-next v8] selftests/net/openvswitch: add SCTP flow key support and test
Date: Fri, 31 Jul 2026 02:26:55 -0400
Message-ID: <20260731062655.4088575-1-houminxi@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ovskey flow-string parser has no OVS_KEY_ATTR_SCTP entry, so a
flow string containing sctp(src=.../dst=...) parses without error but
silently drops the L4 key. The resulting flow carries only
ipv4(proto=132), and the kernel rejects it: match_validate() in
flow_netlink.c requires OVS_KEY_ATTR_SCTP when the IP protocol is
IPPROTO_SCTP and returns -EINVAL for the missing key.

Register OVS_KEY_ATTR_SCTP in the parse table and add a matching
selftest that verifies SCTP flow key matching (sctp src/dst port).

Also enable CONFIG_IP_SCTP in the selftest kernel config.

Signed-off-by: Minxi Hou <houminxi@gmail.com>
---
Changes from v7:
  - Drop all unit tests per Ilya's feedback (tests for test code
    feels excessive); merge patches back into one.
  - Enable CONFIG_IP_SCTP in the selftest kernel config.
  - Rebase onto latest net-next; add base-commit header.
v7: https://lore.kernel.org/netdev/20260729064549.3647518-1-houminxi@gmail.com/
v6: https://lore.kernel.org/netdev/20260724150624.3457427-1-houminxi@gmail.com/
v5: https://lore.kernel.org/netdev/20260723215630.2502169-1-houminxi@gmail.com/
v4: https://lore.kernel.org/netdev/20260723162503.1790998-1-houminxi@gmail.com/
v3: https://lore.kernel.org/netdev/20260722214915.4128292-1-houminxi@gmail.com/
v2: https://lore.kernel.org/netdev/20260721190648.2713156-1-houminxi@gmail.com/
v1: https://lore.kernel.org/netdev/20260718215437.3257200-1-houminxi@gmail.com/

 .../testing/selftests/net/openvswitch/config  |   1 +
 .../selftests/net/openvswitch/openvswitch.sh  | 121 ++++++++++++++++++
 .../selftests/net/openvswitch/ovs-dpctl.py    |   5 +
 3 files changed, 127 insertions(+)

diff --git a/tools/testing/selftests/net/openvswitch/config b/tools/testing/selftests/net/openvswitch/config
index c659749cd086..754297b1644e 100644
--- a/tools/testing/selftests/net/openvswitch/config
+++ b/tools/testing/selftests/net/openvswitch/config
@@ -1,6 +1,7 @@
 CONFIG_GENEVE=m
 CONFIG_INET_DIAG=y
 CONFIG_IPV6=y
+CONFIG_IP_SCTP=y
 CONFIG_NETFILTER=y
 CONFIG_NET_IPGRE=m
 CONFIG_NET_IPGRE_DEMUX=m
diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
index 853dbc1b00d7..b448324527d8 100755
--- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
+++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
@@ -34,6 +34,7 @@ tests="
 	action_set				set: SET action rewrites fields
 	trunc					trunc: output truncation
 	icmpv6					icmpv6: ICMPv6 echo type match
+	sctp_connect_v4				sctp: SCTP flow key matching
 	psample					psample: Sampling packets with psample"
 
 info() {
@@ -611,6 +612,126 @@ test_icmpv6() {
 	return 0
 }
 
+# Check for an SCTP endpoint via /proc, which works without sctp_diag.
+sctp_eps_has() {
+	ip netns exec "$1" awk -v p="$2" '$6==p' /proc/net/sctp/eps | grep -q .
+}
+
+# sctp_connect_v4 test
+# - sctp(dst=4443) matches client-to-server INIT
+# - sctp(src=4443) matches server-to-client INIT-ACK
+# - remove flows and verify connection fails, reinstall and recover
+test_sctp_connect_v4() {
+	local t="test_sctp_connect_v4"
+	local srv_ip=172.31.110.20
+
+	modprobe -q sctp 2>/dev/null || return "$ksft_skip"
+	socat -V 2>&1 | grep -q "define WITH_SCTP" || return "$ksft_skip"
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
+	ip netns exec server ip addr add "${srv_ip}/24" dev s1
+	ip netns exec server ip link set s1 up
+
+	# Probe: check if kernel supports sctp flow key.
+	ovs_add_flow "$t" sctp4 \
+	    'in_port(1),eth(),eth_type(0x0800),ipv4(proto=132),sctp(dst=4443)' \
+	    '2' &>/dev/null
+	if [ $? -ne 0 ]; then
+		info "no support for sctp key - skipping"
+		ovs_exit_sig
+		return $ksft_skip
+	fi
+	ovs_del_flows "$t" sctp4
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
+	ovs_wait sctp_eps_has server 4443 || return 1
+
+	info "verify SCTP association with port-keyed flows"
+	ovs_sbx "$t" ip netns exec client \
+	    timeout 3 socat -u STDIN "SCTP4-CONNECT:${srv_ip}:4443" </dev/null \
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
+	local i=0
+	while kill -0 "$server_pid" 2>/dev/null && [ "$i" -lt 5 ]; do
+	    sleep 0.2
+	    i=$((i + 1))
+	done
+	ovs_netns_spawn_daemon "$t" "server" \
+	    socat -u SCTP4-LISTEN:4443 STDOUT
+	server_pid="$pid"
+	ovs_wait sctp_eps_has server 4443 || return 1
+
+	ovs_sbx "$t" ip netns exec client \
+	    timeout 3 socat -u STDIN "SCTP4-CONNECT:${srv_ip}:4443" </dev/null \
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
+	i=0
+	while kill -0 "$server_pid" 2>/dev/null && [ "$i" -lt 5 ]; do
+	    sleep 0.2
+	    i=$((i + 1))
+	done
+	ovs_netns_spawn_daemon "$t" "server" \
+	    socat -u SCTP4-LISTEN:4443 STDOUT
+	server_pid="$pid"
+	ovs_wait sctp_eps_has server 4443 || return 1
+
+	ovs_sbx "$t" ip netns exec client \
+	    timeout 3 socat -u STDIN "SCTP4-CONNECT:${srv_ip}:4443" </dev/null \
+	    || return 1
+
+	return 0
+}
+
 # psample test
 # - use psample to observe packets
 test_psample() {
diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
index f3edd198223f..ce790d936832 100644
--- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
+++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
@@ -1984,6 +1984,11 @@ class ovskey(nla):
                 "udp",
                 ovskey.ovs_key_udp,
             ),
+            (
+                "OVS_KEY_ATTR_SCTP",
+                "sctp",
+                ovskey.ovs_key_sctp,
+            ),
             (
                 "OVS_KEY_ATTR_ICMP",
                 "icmp",

base-commit: 2fbade66245059c78daeaccfce13ecf499fffb51
-- 
2.55.0

