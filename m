Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E465519A7
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 12:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788956745; cv=none; b=cvnG3zqgApnjA4aeFaw3cPQ3l2SHR6Utzemo5OjNde06t8dubEGoMiUPET1AJTophk80LRpyDAElrMR2my7XipfGwvJWF/V7gYEOFmP1eNgXXcTG4jDhRmIZJld8BMt5uuIqlNUgGqO2A5VHhSPV4z6V3bR6HS4Ff0MLS3hFnpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788956745; c=relaxed/simple;
	bh=2Tey0G/KGpl9yCUWS2vVMwES7uVtnUQnbP/ouz5QQuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AsnmmTTBUPFmmDlFLnM44U0/tXFuKYfbIdcCigEmISyceKWDEknWldpnH9KZcKWDFyGbX5Hhf/cB8Y0iwWL1+EC0RB0EGIINWdyvL26DL+DnJhvgeSFZAFbgWWWq4sCdCNzCtmnPRoit4n5yqretyxL7ThdrREVja463cA6lZ4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gxbhQonc; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxbhQonc"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-52ff0eea420so55277781cf.0
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 05:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788956742; x=1789561542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0UqCHw9TY9AuxZhGAQ+szvpmZHkBnGVTRGnDrb1YHFw=;
        b=gxbhQoncdJBs8YC9aM1XXieSWYqMBBJwO6enE6jp4JI9uzsRj+05cTS+8eC5E6HOTY
         BoRWhnsILdT8+oTg9gv4hHOCJS5EzdMyvRTQVZUZJ78pNB1DsDo/FMS/+kicz4m9yGoW
         fQgDEr37eEg0iiqcZOtwERfSrgEwvlimx5jujqhcT2/mvhI36SOXPRRX0rIfZKCYZAhU
         QZVlbgII+/+IaXB2dPgMBmRXe1gGECjWT7K3Zr3C4P1QpatLbOST5sUF1DFShSIgEDVp
         ZOdv8fu8LyeuFncCRTHpAPHpARVTUrmyHj6a2zs7ps2PhAV9+dlRdVJ+zq1MeIDzO6yl
         ZFLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788956742; x=1789561542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0UqCHw9TY9AuxZhGAQ+szvpmZHkBnGVTRGnDrb1YHFw=;
        b=OTszNmxEY2IYXPsrBgExI5LpRU5HnZETRZ12XfWdRW6sg0S4EZSIS3KnpAvSI4/gYi
         bZNsXxYK6l7LjQGDv/8ro2OqC00/3EzOwv67ufD5b20De2ndKghwJmKcfTdNu8MKplEs
         16HdlRj0vhJADcjNTmSs4UMoqVNj3R2G/CpjLOUApRFdvKmANp6i2/gauDJoA1wMPlFD
         r32jGXzvd8/FDAwiYurp9dPmB8naw9hb7JoxnvzdCIiKjbt4mWSAiRzDmvafPnMHZpBE
         BQayfJE3I0jAGibD0Xk+gG1j3BaMB3JRfp8PIc25a1uq2llOWjfipc57eJSAhAL5qT2I
         jTVg==
X-Gm-Message-State: AFuF++kwVCPPEX1rCIjLhRQ5Bdzl0aN0KgHrOXO5+Tvhwe1CmkgQBGdi
	dS3+mnR34pGdaH4wqnul+6sKxdser8ykntry5Vuu8RUTgh/mGUi8MNzArGGD85Rq
X-Gm-Gg: AYBFou1iyr+uTBXk93EIyvLsWz21fZ/30vhVKFSA/jw4PSI360AaC55bbQbD/mjGgz0
	7E8uENUQmTSUiJ0fd+pGmhKQFzCWu3THCQnJQEb15G0Mpq02ntr+oEj1kQODQUGKW5aIzXysq+L
	m5RevYtWnDLhls4dlh6BLNLRKpiK3APS6imZhy2hxAdQfpq4HJwnWd6hosjFtZtcBvrjBcHaO2n
	t5E6GsiMDeYd8DWLf+mDmcKXzSi4MffZ0bnMz4pwXtNz8iKy5YJ0guUJTe8D/nEcM8Sl57F4aqs
	IsDwFIBQRXjmVedGoZUu/Q5UC0g3Xcqznw1CUCyDxYdDo0GZ/UQSIWNpYo7TPDsngUQmofhV5tl
	+/fz7SUqiuvJWUDgEcMq+3TLkxOUjQRX5jR6RqlLx5/ij5tAlpQOjul2ZIgL9Wpzrl3th5Jpjf3
	8EO4iHOK25dIHYunnyxSy9oz6eLrAKC44Tix1aK6wJUTnfrbeLEbdjt4cghC9ISht8UQ==
X-Received: by 2002:ac8:7c45:0:b0:530:2315:4986 with SMTP id d75a77b69052e-53043227267mr362144101cf.16.1788956741709;
        Wed, 09 Sep 2026 05:25:41 -0700 (PDT)
Received: from houminxi ([163.123.141.225])
        by smtp.googlemail.com with ESMTPSA id d75a77b69052e-5308d8d3eddsm61037541cf.0.2026.09.09.05.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 05:25:41 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: aconole@redhat.com,
	echaudro@redhat.com,
	i.maximets@ovn.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	dev@openvswitch.org,
	linux-kselftest@vger.kernel.org,
	Minxi Hou <houminxi@gmail.com>
Subject: [PATCH net-next v4 2/2] selftests/net/openvswitch: add SCTP NAT test with port translation
Date: Wed,  9 Sep 2026 08:25:21 -0400
Message-ID: <20260909122521.2687193-3-houminxi@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909122521.2687193-1-houminxi@gmail.com>
References: <20260909122521.2687193-1-houminxi@gmail.com>
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
 .../selftests/net/openvswitch/openvswitch.sh  | 93 +++++++++++++++++++
 2 files changed, 94 insertions(+)

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
index 1160f8ed7d8a..138a705fc359 100755
--- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
+++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
@@ -35,6 +35,7 @@ tests="
 	icmpv6					icmpv6: ICMPv6 echo type match
 	sctp_connect_v4				sctp: SCTP flow key matching
 	sctp_connect_v6			sctp6: SCTP flow key matching over IPv6
+	sctp_nat_connect_v4		sctpnat4: SCTP NAT with port translation
 	psample					psample: Sampling packets with psample"
 
 info() {
@@ -1199,6 +1200,98 @@ test_nat_connect_v4 () {
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
+		'ct(commit,nat(dst=172.31.110.20:5555)),recirc(0x1)' \
+		&> /dev/null
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
+		"ct_state(-trk),in_port(1),eth(),eth_type(0x0800),"\
+"ipv4(dst=192.168.0.20)" \
+		"ct(commit,nat(dst=172.31.110.20:5555)),recirc(0x1)" || return 1
+	ovs_add_flow "test_sctp_nat_connect_v4" sctpnat4 \
+		"ct_state(-trk),in_port(2),eth(),eth_type(0x0800),ipv4()" \
+		"ct(commit,nat),recirc(0x2)" || return 1
+
+	ovs_add_flow "test_sctp_nat_connect_v4" sctpnat4 \
+		"recirc_id(0x1),ct_state(+trk-inv),in_port(1),eth(),"\
+"eth_type(0x0800),ipv4(dst=172.31.110.20,proto=132),"\
+"sctp(dst=5555)" \
+		"2" || return 1
+	ovs_add_flow "test_sctp_nat_connect_v4" sctpnat4 \
+		"recirc_id(0x2),ct_state(+trk-inv),in_port(2),eth(),"\
+"eth_type(0x0800),ipv4(src=192.168.0.20,proto=132),"\
+"sctp(src=4443)" \
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

