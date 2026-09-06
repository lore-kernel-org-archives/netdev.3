Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2CF18C02E
	for <netdev@vger.kernel.org>; Sun,  6 Sep 2026 16:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788713594; cv=none; b=QfryYqxCtLvytJmdc1Q6cHMF0xOErvz4At5NVR2orAQl40PTVhYHAyn1nQJhNo/V/ct375GE3kT6f63h0yWEgF5gzPTHgm2QkksFeq696r8qCm5SjTcBxEmCXGSdLcUcgWCYNCDW+appbDvvTJ0UfgFFeifPSQq8cbv2PUovBno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788713594; c=relaxed/simple;
	bh=KuLX5nFd6sKvpOw24HCW5pPqc7gmdWxBz/dxA8XmQXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ro+PrOKUOGlqErahj2OXmJcFr4Z4v+HBvUWsI9Qiyfd9CkO3+8maRCeAAaPYD/OMbVUeITfEt75cR+reGcFRhhzprD66Gz5WTPClxhDxvZW1p/8XgnsJALkPRJNxDnkdkYEY8MV+HaLapNzl0AAw9SBjSmT8lkPStiNbz2QUGeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NJCgHhFI; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJCgHhFI"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5303932c4f3so13869641cf.2
        for <netdev@vger.kernel.org>; Sun, 06 Sep 2026 09:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788713592; x=1789318392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZZiMeD/Io3WtmguEFZgA5/+B6qbs9KLh5cpu9F1ku0A=;
        b=NJCgHhFI67dm+OqHPvxTQWDpfDgLkY5b0CaIPL8jQQtD+hO3du/UoFnOasWuwhkZWU
         Z625q3gdGHms+U5e8pPKjRd7O8cAjFMH6NBVBju0UgPTRlhNTL4ZXNDF2ZXKecYrWbis
         Gm3UxlSGO2YrJCUAgGcqVaYonBJ7GuoAS8Oct66mKPigD4LPyAP2JKyrli0OBpwSa3r+
         T/5TaVEYj0SILYFBQdJpHSWzW05986mWRy2TXX5dFWFY2sDYaDM1QoFB54XOZ0l45XcI
         AlRVwFOqE4913VRcl0jEgUYalMva7rof6m6p0xIeu6PbP41snkesGUYO6zFhKhMJalOS
         yAug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788713592; x=1789318392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZZiMeD/Io3WtmguEFZgA5/+B6qbs9KLh5cpu9F1ku0A=;
        b=QLo7NudZnkXv2Fy28mB7RUPaaMfWPiz9W1cYTi6Ucnpb2wtsLTKbn60SNodr9/Ngx6
         hcXj/BGSG2rFRrSy5l9QRmYRrf2eDCm/IgJIblQviJ1x6u7WW4GXxR9feev7mE1nu0Q8
         tumMNZYkBbRKCwmiHG48RDnSSqgjEStpTsZXGpFg7xkPAGsgjyQxw3B6UwrM+8EFDwRa
         Wkro3JuuJ7D3hvJ7rDB39pTCZgYAy3uIolgiMa9IuwRxHZZk75NMEsPv/i5KKlSQq7Wl
         Ejx3qo0VtsUoeFY9xMKaGE82oli4Mbw0ky3ZXrVSk64U4LUNK9ZSzq9TTXlybZGH/RhQ
         7Bqw==
X-Gm-Message-State: AFuF++l9JACfFXXwvG+Dg58BxlIkCZt4sdhoXcwYDip/QWGD4Ni3cHUO
	zEhtsbt6YtszelasXe8ESX4TZS6Xp5uz517cLaGAlNcFURGBjp9HQa2/vJKBhiZR
X-Gm-Gg: AYBFou3W8utPeNjKzxF0wIiQRACQSojsNKm20nyCR9rhK8kq7M+C1fRrC1P3d0rQfAB
	Q9cI8Wbug4/qImwwwOyX++trIgqRrVJNnxSVJTWDOj+zVgjgpyRMT7WFRIUrck37qR2tYBuREoP
	JR2UT/w5KmcfgZ9RGd7st9xj1qbHozVCSatMzxjg9Ahj9vLj8mCe7k8eTPH0DLka0o6s9dBJFYG
	juRaDiwqePfeqWzjGc/sbNFlO6cr++K4XtJKxcq17SX0dnTLJaJPwgsuEoEQA+zG4XF0tr0Jz4P
	wAux269/ouj1EoDZ3ZmO9GlXvOzIIpGEzAlqCVngUTkoU3mIr7rUGlagS03ieiwXwPUHJ4YqiAa
	RlJ7DVYfOtrutwvP5SMubcGwfz5+8faI3uPgzptZ6uMxVVcCMjnKDpHQuWDtjmFwjSj+iPLtuEt
	FN4rn9s2j+D4sfg5RTNNqZao9dXMvuAHi9jlrTQzEkfWeB8pZ0xB2Qmda+EDQj7jI=
X-Received: by 2002:a05:622a:449:b0:530:23cb:cac with SMTP id d75a77b69052e-530547d5adfmr206552741cf.6.1788713591570;
        Sun, 06 Sep 2026 09:53:11 -0700 (PDT)
Received: from houminxi ([163.123.141.225])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91040595f81sm72195696d6.2.2026.09.06.09.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 09:53:11 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: aconole@redhat.com,
	echaudro@redhat.com,
	i.maximets@ovn.org,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	dev@openvswitch.org,
	Minxi Hou <houminxi@gmail.com>
Subject: [PATCH v3 2/2] selftests/net/openvswitch: add SCTP NAT test with port translation
Date: Sun,  6 Sep 2026 12:52:51 -0400
Message-ID: <20260906165251.1176875-3-houminxi@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260906165251.1176875-1-houminxi@gmail.com>
References: <20260906165251.1176875-1-houminxi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After conntrack NAT rewrites a packet, OVS refreshes the cached flow
key in ovs_nat_update_key(), which has a per-protocol branch for the
L4 ports (UDP/TCP/SCTP, conntrack.c). Address-only NAT cannot tell a
working SCTP branch from a missing one: the ports survive unchanged
either way, so a post-recirc match on the original port stays green
even with the branch deleted. The suite's NAT coverage drives TCP
over nc, and the merged SCTP test has no conntrack in the path, so
the SCTP branch goes unexercised.

Add test_sctp_nat_connect_v4: untracked client traffic to
192.168.0.20:4443 hits ct(commit,nat(dst=172.31.110.20:5555)),recirc,
and the post-recirc flows match the translated tuple,
ipv4(dst=172.31.110.20),sctp(dst=5555). Reply traffic is matched on
the restored original tuple, sctp(src=4443). With the SCTP branch
broken the translated port never reaches the key, no post-recirc
flow matches, and the association fails. The probe flow uses the
same ct+nat action as the real flows, so a kernel without
CONFIG_NF_NAT rejects it at flow-add time and the test skips instead
of failing; CONFIG_NF_CT_PROTO_SCTP=y is added to the config fragment
for the same reason (the symbol is user-visible only with
NETFILTER_ADVANCED=y). After the association succeeds the test pushes
a known payload across and waits for the listener to log it.

Signed-off-by: Minxi Hou <houminxi@gmail.com>
---
 .../testing/selftests/net/openvswitch/config  |  1 +
 .../selftests/net/openvswitch/openvswitch.sh  | 87 +++++++++++++++++++
 2 files changed, 88 insertions(+)

diff --git a/tools/testing/selftests/net/openvswitch/config b/tools/testing/selftests/net/openvswitch/config
index a825e0b5c88e..fa90475dc388 100644
--- a/tools/testing/selftests/net/openvswitch/config
+++ b/tools/testing/selftests/net/openvswitch/config
@@ -7,6 +7,7 @@ CONFIG_NET_IPGRE=m
 CONFIG_NET_IPGRE_DEMUX=m
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_OVS=y
+CONFIG_NF_CT_PROTO_SCTP=y
 CONFIG_OPENVSWITCH=m
 CONFIG_PSAMPLE=m
 CONFIG_VETH=y
diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
index 0926e304ed88..fb37b6ab2ec1 100755
--- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
+++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
@@ -35,6 +35,7 @@ tests="
 	icmpv6					icmpv6: ICMPv6 echo type match
 	sctp_connect_v4				sctp: SCTP flow key matching
 	sctp_connect_v6			sctp6: SCTP flow key matching over IPv6
+	sctp_nat_connect_v4		sctpnat4: SCTP flow key across conntrack NAT
 	psample					psample: Sampling packets with psample"
 
 info() {
@@ -1186,6 +1187,92 @@ test_nat_connect_v4 () {
 	return 0
 }
 
+# sctp_nat_connect_v4 test
+#  - SCTP association crosses a ct(commit,nat(dst=ip:port)) DNAT
+#  - post-recirc flows match the translated address and port, so the
+#    SCTP branch of the post-NAT flow key update is load-bearing
+test_sctp_nat_connect_v4 () {
+	local t="test_sctp_nat_connect_v4"
+	local payload="SCTP_NAT_DATA_OK"
+	local rxfile="${ovs_base}/${t}/sctp-rx.txt"
+
+	modprobe -q sctp 2>/dev/null || return "$ksft_skip"
+	socat -V 2>&1 | grep -q "define WITH_SCTP" || return "$ksft_skip"
+	# SCTP conntrack is compiled into nf_conntrack.ko, so check that
+	# loading it actually exposed the SCTP conntrack sysctls.
+	modprobe -q nf_conntrack 2>/dev/null || return "$ksft_skip"
+	[ -e /proc/sys/net/netfilter/nf_conntrack_sctp_timeout_established ] \
+	    || { info "no SCTP conntrack support - skipping"
+	         return "$ksft_skip"; }
+
+	sbx_add "test_sctp_nat_connect_v4" || return $?
+
+	ovs_add_dp "test_sctp_nat_connect_v4" sctpnat4 || return 1
+	info "create namespaces"
+	for ns in client server; do
+		ovs_add_netns_and_veths "test_sctp_nat_connect_v4" "sctpnat4" \
+		    "$ns" "${ns:0:1}0" "${ns:0:1}1" || return 1
+	done
+
+	ip netns exec client ip addr add 172.31.110.10/24 dev c1
+	ip netns exec client ip link set c1 up
+	ip netns exec server ip addr add 172.31.110.20/24 dev s1
+	ip netns exec server ip link set s1 up
+
+	ip netns exec client ip route add default via 172.31.110.20
+
+	# Check if the ct and nat actions can be configured.
+	ovs_add_flow "test_sctp_nat_connect_v4" sctpnat4 \
+		'in_port(1),eth(),eth_type(0x0800),ipv4()' \
+		'ct(commit,nat(dst=172.31.110.20:5555)),recirc(0x1)' &> /dev/null
+	if [ $? == 1 ]; then
+		info "no support for ct/nat actions - skipping"
+		ovs_exit_sig
+		return $ksft_skip
+	fi
+
+	ovs_del_flows "test_sctp_nat_connect_v4" sctpnat4
+
+	ovs_add_flow "test_sctp_nat_connect_v4" sctpnat4 \
+		'in_port(1),eth(),eth_type(0x0806),arp()' '2' || return 1
+	ovs_add_flow "test_sctp_nat_connect_v4" sctpnat4 \
+		'in_port(2),eth(),eth_type(0x0806),arp()' '1' || return 1
+	ovs_add_flow "test_sctp_nat_connect_v4" sctpnat4 \
+		"ct_state(-trk),in_port(1),eth(),eth_type(0x0800),ipv4(dst=192.168.0.20)" \
+		"ct(commit,nat(dst=172.31.110.20:5555)),recirc(0x1)" || return 1
+	ovs_add_flow "test_sctp_nat_connect_v4" sctpnat4 \
+		"ct_state(-trk),in_port(2),eth(),eth_type(0x0800),ipv4()" \
+		"ct(commit,nat),recirc(0x2)" || return 1
+
+	ovs_add_flow "test_sctp_nat_connect_v4" sctpnat4 \
+		"recirc_id(0x1),ct_state(+trk-inv),in_port(1),eth(),eth_type(0x0800),ipv4(dst=172.31.110.20,proto=132),sctp(dst=5555)" \
+		"2" || return 1
+	ovs_add_flow "test_sctp_nat_connect_v4" sctpnat4 \
+		"recirc_id(0x2),ct_state(+trk-inv),in_port(2),eth(),eth_type(0x0800),ipv4(src=192.168.0.20,proto=132),sctp(src=4443)" \
+		"1" || return 1
+
+	ovs_netns_spawn_daemon "test_sctp_nat_connect_v4" "server" \
+		socat -u -t 1 SCTP4-LISTEN:5555,fork \
+		OPEN:"$rxfile",creat,append
+	ovs_wait sctp_eps_has server 5555 || return 1
+
+	info "verify SCTP association across NAT"
+	ovs_sbx "test_sctp_nat_connect_v4" ip netns exec client \
+	    timeout 3 socat -u STDIN "SCTP4-CONNECT:192.168.0.20:4443" \
+	    </dev/null || return 1
+
+	info "verify SCTP DATA chunk crosses NAT"
+	ovs_sbx "test_sctp_nat_connect_v4" ip netns exec client \
+	    timeout 3 socat -u STDIN "SCTP4-CONNECT:192.168.0.20:4443" \
+	    <<< "$payload" || return 1
+	ovs_wait grep -q "$payload" "$rxfile" \
+	    || { info "server did not receive SCTP DATA payload"
+	         return 1; }
+
+	info "done..."
+	return 0
+}
+
 # nat_related_v4 test
 #  - client->server ip packets go via SNAT
 #  - client solicits ICMP destination unreachable packet from server
-- 
2.55.0

