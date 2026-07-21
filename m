Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94244418F5
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 22:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784673005; cv=none; b=cCdf2CinZch2nND4SHEV/uIlwxRD6KF2PVFBqSKgrEwBPjAI7sSlMaC133oLEAtcwJyjRDMo3mkSyShj4b8ApD7uEAaEuBLAPQb+MKvKkvKPe71oJbq6WeaZxbSiTkJEu31avY1VQWDW4uFsTMF2h586Vnr0x7+dcMylbOIgiuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784673005; c=relaxed/simple;
	bh=uZRZ2VN44Q5XzL/F2XgrEb/jhTB2g8aztDio6kTbBac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YnHDkLbjXmy9P/FKAQeVYleitHpU43vjtG4adLXzepmPkzcZ+8IrEtoVd2S3beeZ7fwZOdI1tqe1WYwtAK5+icCn0RitroowBk+Wx6TwlCgMILyaJS8BkExG46wmuOp1n+ksD8mZIMCvIvEewfB8K8a4Ac2qpGNnuMwQ8l+LFkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OqcWIT40; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OqcWIT40"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cce6a0c9c3so108515305ad.1
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 15:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784673003; x=1785277803; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SACM/ZkSy0Q+E/W2IAydC2E/hnHraYOT4Rhvc9t0KKg=;
        b=OqcWIT40tDSudduOZs8F03lSCMn6UZ//ZYcJrqY9XoHSTtGJb//4Up/A2FTboQfQKV
         nXmFjhfSVdKN9ToWdqiLo/qQ7piYtpdCdvCdJI/Ryc44j86vpIB/7LLwrB1QR9/vmhrF
         gJs69+4A0wiBqq6giCoobd4PeYgm/DbCwBANs/GlQA/BEfbGGonRQmD2i0bdljlE3rtq
         thDhy2N8sufPrwaAIWsGhFDCT0+d1zYJtjaMDTYytZLrWPc2XEhpJcbPillmjoRSL83+
         Ya3lsxnLa9OUXp+oiftesrAaXRJElF6TfrO7Dx7RWT1xMgPReBIY8DYjBv0lqLutOMx5
         V4vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784673003; x=1785277803;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SACM/ZkSy0Q+E/W2IAydC2E/hnHraYOT4Rhvc9t0KKg=;
        b=CMNYMAQMFvgr0rkrUuIzwTZZVmyObOpNgoEeftRtgDlniCuJRD1WP9AKsgVHZXNVas
         3DtdjMJrjT+yBW5vQS1D0YgqiiuomG0mKgP2KXtXBTbPjYv3c6RbXkFu7YQjm4ijiveg
         6AumKVJwRjxQEg5SF5zqZiAODvuALgAFuFpcCGs4RVz4UQfQLbABZisrr2y84MJMka8H
         51D/8mEluNJv/yvQMWhNhiOj6rxpK8y3aYIvgOZoqyh3lrK9HFD9lMDyQmld/8ak2yu5
         MRzXgcl5vaqdj7yP/8sHCZANT6/Jqj8v2xgNjQQJK96Qq7l5w5jXXXWsgYBeTcYcYMZK
         r+JA==
X-Gm-Message-State: AOJu0YxljM1PNk1Kv3q8gFTuTESEOGXbnplwaIEM7bYdgGe0Zk9k4dY1
	JcAGznjhyvTBwDKaNZoNXdJVTKkqr+HEbFfqKpaTWTq1yrJ+91YKVFwk
X-Gm-Gg: AR+sD11K4K8doFpRBWUnGPtQXE/xTt+ZupUlnWVEOUE4EsXHeFZbipTuVo4M5ce1rwr
	FBH5DiGAcGW+JqsAt/wXTJxWVbR0bQemoiUgknhVa3NOHnaAQYjA9Ee17a43BrzKCHTTUmI+LPl
	yuprLAu1FnUjxD9lXwOJkZGrjYQtzNbShlhBr6GdBO38aSZNoYg5WKjLG3SgbLRenZVM7gikeLS
	zttPWGb7jaCeu47QKVbkDltCIJTrTZXGiHhpvgyKrZZ91sYG38kKjMcJ8G2UH1fe5f4Fsp625Rg
	qFDcu2QrtC4PvEW7Ol6aRsSc4VtnC6N5JQaAQjuNL5FkcRQGCIJNU65ctdopub9VYhhx2II/9Ia
	rr4SsjOidhnKPMVXI1gH12Yhf/UwPN1mkzIAhUNImVX6wmj+Ue/elZ67rNUBMi+KZTKoBY2GJ2i
	fbrc5oOw0/29KXzyA=
X-Received: by 2002:a17:903:298c:b0:2ca:4b7a:4a02 with SMTP id d9443c01a7336-2cf34a7bfe4mr218688335ad.43.1784673003421;
        Tue, 21 Jul 2026 15:30:03 -0700 (PDT)
Received: from CPC-mjac-HKWGEZ.localdomain ([70.37.26.40])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8efde5cfsm3787685ad.31.2026.07.21.15.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 15:30:03 -0700 (PDT)
From: Jack Ma <jack4it@gmail.com>
Date: Tue, 21 Jul 2026 22:29:52 +0000
Subject: [PATCH net-next v3 3/3] selftests: net: add coverage for fdb
 nexthop dst port
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-b4-vxlan-fdb-port-v3-3-9aa0a543a78a@gmail.com>
References: <20260721-b4-vxlan-fdb-port-v3-0-9aa0a543a78a@gmail.com>
In-Reply-To: <20260721-b4-vxlan-fdb-port-v3-0-9aa0a543a78a@gmail.com>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Jack Ma <jack4it@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784672999; l=6796;
 i=jack4it@gmail.com; s=20260712; h=from:subject:message-id;
 bh=uZRZ2VN44Q5XzL/F2XgrEb/jhTB2g8aztDio6kTbBac=;
 b=T+jPlHObpnglpfTY7pQTXNgn13M0Do7klKkxPmWXYTvfkPm/6VhFmmazfpfpWHkmg6H/Xpfx/
 8CXZ7ADb1ziCllIrvcE3ycKiuFPJqv6nhGFMcr62tLZPIIZlMcbjVzo
X-Developer-Key: i=jack4it@gmail.com; a=ed25519;
 pk=x8xh2Md9yNDil0xBOA9WA/oqC3O4Eg4rdlIul4YUktU=

Extend the existing fdb nexthop group tests with cases for the new
per-nexthop VXLAN destination port (NHA_FDB_PORT).

In fib_nexthops.sh, ipv4_fdb_grp_fcnal() and ipv6_fdb_grp_fcnal() now
check that a port is accepted on an fdb nexthop that has a gateway and
echoed back on dump, that it is rejected without a gateway and rejected
when zero, that a group may hold legs that differ only in UDP port, and
that a portless fdb nexthop omits the attribute.  The cases SKIP when
iproute2 lacks the "port" keyword.

In test_vxlan_nh.sh, basic_tx_common() gains a second fdb nexthop group
whose nexthop carries a destination port that differs from the VXLAN
device default, plus a flower filter keyed on that port, to confirm the
per-nexthop port is used on the wire.

Signed-off-by: Jack Ma <jack4it@gmail.com>
---
 tools/testing/selftests/net/fib_nexthops.sh  | 59 ++++++++++++++++++++++++++++
 tools/testing/selftests/net/test_vxlan_nh.sh | 31 +++++++++++++++
 2 files changed, 90 insertions(+)

diff --git a/tools/testing/selftests/net/fib_nexthops.sh b/tools/testing/selftests/net/fib_nexthops.sh
index ac868a731694..1ce4f45fa651 100755
--- a/tools/testing/selftests/net/fib_nexthops.sh
+++ b/tools/testing/selftests/net/fib_nexthops.sh
@@ -432,6 +432,15 @@ check_nexthop_fdb_support()
 	fi
 }
 
+check_nexthop_fdb_port_support()
+{
+	$IP nexthop help 2>&1 | grep -q "fdb \[ port"
+	if [ $? -ne 0 ]; then
+		echo "SKIP: iproute2 too old, missing fdb nexthop port support"
+		return $ksft_skip
+	fi
+}
+
 check_nexthop_res_support()
 {
 	$IP nexthop help 2>&1 | grep -q resilient
@@ -514,6 +523,31 @@ ipv6_fdb_grp_fcnal()
 	run_cmd "$IP nexthop replace id 72 via 2001:db8:91::2 fdb"
 	log_test $? 2 "Replace non-FDB nexthop to FDB nexthop while in a group"
 
+	# NHA_FDB_PORT: optional per-nexthop VXLAN destination UDP port,
+	# letting an fdb nexthop group balance a flow across legs that share
+	# an underlay IP but listen on different UDP ports.
+	if check_nexthop_fdb_port_support; then
+		run_cmd "$IP nexthop add id 80 via 2001:db8:91::2 fdb port 4790"
+		check_nexthop "id 80" "id 80 via 2001:db8:91::2 scope link fdb port 4790"
+		log_test $? 0 "Fdb nexthop with port"
+
+		run_cmd "$IP nexthop add id 81 fdb port 4790"
+		log_test $? 2 "Fdb nexthop with port but no gateway"
+
+		run_cmd "$IP nexthop add id 81 via 2001:db8:91::2 fdb port 0"
+		log_test $? 2 "Fdb nexthop with port 0"
+
+		run_cmd "$IP nexthop add id 82 via 2001:db8:91::2 fdb port 4789"
+		run_cmd "$IP nexthop add id 83 via 2001:db8:91::3 fdb port 5789"
+		run_cmd "$IP nexthop add id 106 group 82/83 fdb"
+		check_nexthop "id 106" "id 106 group 82/83 fdb"
+		log_test $? 0 "Fdb nexthop group with legs differing in port"
+
+		run_cmd "$IP nexthop add id 84 via 2001:db8:91::2 fdb"
+		check_nexthop "id 84" "id 84 via 2001:db8:91::2 scope link fdb"
+		log_test $? 0 "Fdb nexthop without port omits port"
+	fi
+
 	run_cmd "$IP link add name vx10 type vxlan id 1010 local 2001:db8:91::9 remote 2001:db8:91::10 dstport 4789 nolearning noudpcsum tos inherit ttl 100"
 	run_cmd "$BRIDGE fdb add 02:02:00:00:00:13 dev vx10 nhid 102 self"
 	log_test $? 0 "Fdb mac add with nexthop group"
@@ -614,6 +648,31 @@ ipv4_fdb_grp_fcnal()
 	run_cmd "$IP nexthop replace id 20 via 172.16.1.2 fdb"
 	log_test $? 2 "Replace non-FDB nexthop to FDB nexthop while in a group"
 
+	# NHA_FDB_PORT: optional per-nexthop VXLAN destination UDP port,
+	# letting an fdb nexthop group balance a flow across legs that share
+	# an underlay IP but listen on different UDP ports.
+	if check_nexthop_fdb_port_support; then
+		run_cmd "$IP nexthop add id 30 via 172.16.1.2 fdb port 4790"
+		check_nexthop "id 30" "id 30 via 172.16.1.2 scope link fdb port 4790"
+		log_test $? 0 "Fdb nexthop with port"
+
+		run_cmd "$IP nexthop add id 31 fdb port 4790"
+		log_test $? 2 "Fdb nexthop with port but no gateway"
+
+		run_cmd "$IP nexthop add id 31 via 172.16.1.2 fdb port 0"
+		log_test $? 2 "Fdb nexthop with port 0"
+
+		run_cmd "$IP nexthop add id 32 via 172.16.1.2 fdb port 4789"
+		run_cmd "$IP nexthop add id 33 via 172.16.1.3 fdb port 5789"
+		run_cmd "$IP nexthop add id 105 group 32/33 fdb"
+		check_nexthop "id 105" "id 105 group 32/33 fdb"
+		log_test $? 0 "Fdb nexthop group with legs differing in port"
+
+		run_cmd "$IP nexthop add id 34 via 172.16.1.2 fdb"
+		check_nexthop "id 34" "id 34 via 172.16.1.2 scope link fdb"
+		log_test $? 0 "Fdb nexthop without port omits port"
+	fi
+
 	run_cmd "$IP link add name vx10 type vxlan id 1010 local 10.0.0.1 remote 10.0.0.2 dstport 4789 nolearning noudpcsum tos inherit ttl 100"
 	run_cmd "$BRIDGE fdb add 02:02:00:00:00:13 dev vx10 nhid 102 self"
 	log_test $? 0 "Fdb mac add with nexthop group"
diff --git a/tools/testing/selftests/net/test_vxlan_nh.sh b/tools/testing/selftests/net/test_vxlan_nh.sh
index 20f3369f776b..34a24a4f95bf 100755
--- a/tools/testing/selftests/net/test_vxlan_nh.sh
+++ b/tools/testing/selftests/net/test_vxlan_nh.sh
@@ -56,6 +56,16 @@ tc_stats_get()
 	tc_rule_handle_stats_get "dev dummy1 egress" 101 ".packets" "-n $ns1"
 }
 
+nh_stats_get_port()
+{
+	ip -n "$ns1" -s -j nexthop show id 20 | jq ".[][\"group_stats\"][][\"packets\"]"
+}
+
+tc_stats_get_port()
+{
+	tc_rule_handle_stats_get "dev dummy1 egress" 102 ".packets" "-n $ns1"
+}
+
 basic_tx_common()
 {
 	local af_str=$1; shift
@@ -90,6 +100,27 @@ basic_tx_common()
 	busywait "$BUSYWAIT_TIMEOUT" until_counter_is "== 1" tc_stats_get > /dev/null
 	check_err $? "tc filter stats did not increase"
 
+	# Add a second FDB nexthop group whose nexthop carries a per-nexthop
+	# destination port (NHA_FDB_PORT) that differs from the VXLAN device
+	# default. Matching outer traffic must egress with that port, so a
+	# separate flower filter keyed on the new port catches it.
+	if ip nexthop help 2>&1 | grep -q "fdb \[ port"; then
+		run_cmd "tc -n $ns1 filter add dev dummy1 egress proto $proto pref 1 handle 102 flower ip_proto udp dst_ip $remote_addr dst_port 4790 action pass"
+
+		run_cmd "ip -n $ns1 nexthop add id 2 via $remote_addr fdb port 4790"
+		run_cmd "ip -n $ns1 nexthop add id 20 group 2 fdb"
+
+		run_cmd "bridge -n $ns1 fdb add 00:11:22:33:44:66 dev vx0 self static nhid 20"
+
+		run_cmd "ip netns exec $ns1 mausezahn vx0 -a own -b 00:11:22:33:44:66 -c 1 -q"
+
+		busywait "$BUSYWAIT_TIMEOUT" until_counter_is "== 1" nh_stats_get_port > /dev/null
+		check_err $? "FDB nexthop group stats did not increase (with port)"
+
+		busywait "$BUSYWAIT_TIMEOUT" until_counter_is "== 1" tc_stats_get_port > /dev/null
+		check_err $? "tc filter stats did not increase (with port)"
+	fi
+
 	log_test "VXLAN FDB nexthop: $af_str basic Tx"
 }
 

-- 
2.43.0

