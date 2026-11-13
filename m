Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794585110;
	b=h49mOPvCW8e30fs6jPiRa3j4dQfL1W3rPjqZqUIwOXLmU27bjscEUiaUvouvcM6OTP26
	 FSEqqb2vqeQM0kD9YX4MJ3jDFv+L90hs+AnnRdsXRKWM+0fYR8YzG365rZVzx3kR9JnDT
	 Nv2ccSI7qgqv5WfR4YFfHQ71M8WgJZvDBfUoW4E5/7KpI0Vz9m1xXKQ57W3nCwwQJherG
	 wJHPvhuv4Xa0iZolTop5XPH5YpLZjhlzKhHGV1r/C1QJrSOcaER96SU8QtgGy3GVl8PP2
	 tQBM9kH4SbIYlUucqRdJDbdHZCSj/fi3cOr2OGM96DsOwkd9pJGtoMp8Kc+9hsdqc0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794585110;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+A4X6iMlxznr0QDPLl2qNINDPJ6bkgkUJqyMiiF/yps=;
	b=Vc1qALgKs4ct3nWizypQH5aCIsk6U5WNpdieOP9ChipeKHKAkIgkrmyvuUDOj2Vfh90k
	 1Tef2T4OrEmwTtAzXDTWcNr6eWswNybqS/VIFF5HCoiwGqhKDuwUBJiYKEw+0T7C82Y+4
	 1Qhnb6JjNX5LBJGA38c9Ue+bf8cCmc7pw3OsbTBXu8v7O/51rdYjwh4PjlZ2tcNFhBuhC
	 uxxzkHNJ9S9h0EPxvpfbD3JTGVjolhOXqPLoP1X2YeRF7b6c0e0el2HB5cIbJO0zyeNpe
	 BWm3V8vp4pEXfsmmiX3WYnQGM5hgNDVpWUSIMrqPp2FVVVrgKPMMzKwBr1DdFzEhHAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=de1J9ynI;
	arc=none smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92ED1606A32D
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 15:51:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92ED1606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=de1J9ynI
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8b271e573adso800161b3a.2
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 07:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794585109; x=1795189909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+A4X6iMlxznr0QDPLl2qNINDPJ6bkgkUJqyMiiF/yps=;
        b=de1J9ynIO999TIklQ8cdl4gk+CAKswh/3KsYMT16IZpqDFsUmpTU813DTiLj2hvKzO
         vj3WtK+IvdLkHNRMu6xRSrKYWDZYQDsQG9hOQlAJSJHPlzaHw5QTciSGKyI4m+Ej81pV
         3nRvoHuOfMDZEaIuUfPrEEyJOneWqjF1YPyOJ81pfUOBXr2aAr2b3Bd1Ip43INIArUv2
         TXoqpqKLd27ZnONDJEkGcHbgMTShs458lWl7lxtPXviGOtyqtNfk2S4HaptQ66uAeCW0
         uX4xtgvdXAzFzDBbGWahOH2GD0fwryt8EiVF3k4aPM0xiZfi98vUtir+ViYH2890H2wz
         y66g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794585109; x=1795189909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+A4X6iMlxznr0QDPLl2qNINDPJ6bkgkUJqyMiiF/yps=;
        b=eqnlHva5pEtwMfLdqSeF2lwzMzQsvjGrI2HAqWlEdauEG9lUv38nufRxGzbuLamVsI
         AZ0Z0RIPADvCxvYV8VSIl9oPC4jo70VaW/h1U3xXwjYwvducadFOYPK0xYrTaokUdHyw
         szSrREEM4egkubtajA0m7QVlRr+oT7rXVLJvuKI+SFBrcQ2vtvJJbTZ+Po1azvke4xRV
         gqCrh0JnFhcqkTTx/yIMpcubQ7wYB/KluyBsrtv9BVEQK83KVUiQOnIWLuNKj8XMClyS
         gQnLAg/02B/v29gb119Sg35iu/rOjjLFHLzJlj+GvT0bH2xf5eeIayo6VYMPDHHnMUza
         GYCg==
X-Gm-Message-State: APuU4Z+cap/8ThUJUKcWTHcO7kFQa3vs8yazQ9P9KcUwdi3v0L8oE90K
	nziWeKANWWzZSoG5KgCaDvldgpCZowUiOLZfe4OqALXXo/kN3yLs3Aq1lu/SHONmaIo=
X-Gm-Gg: AYBFou381aAIC1QPBBCQrgNNqcioMRWTPONykAVtfQHg9kqhQ/jH2lMjPFMqfVXHspy
	8HiRJALA6EqiP4wo8ZmFgpZauTgmNb1x6lTpHPJcoiFZE0ItZRRxkCHtagSbN0J2hsHdTLbwEnd
	urhEbi48Wcf23Q2KUW3HnmDFXNbN4umUFB47nT1s0WseXdhNs2PXyDPOAL6N6wlO1vsEtlrxvMK
	xcAZs0EK+dIDroUTNYPw0aEF9HnI/PR9cjSWnNNuRR8eOM0H6BUCd7fmJKsLQQ1soRT/Q5YzDmW
	wHrlMLbnsestgciMiA3wbGWS0bpWd+cGDCeJHW6NSuDYbyarvEhIKRRMlcTpm7SOeuSpK5QG+Oo
	A1SCunQJEHr42BFKI+RPpveIwZBJAkYujwcmJ5QU/VVs4BRl2Ec1uVpugWgX2+/qt4GHVtAu4lE
	IOIOB6Xfals4wgSW4PWqsW+ZdqYcMjlSLoBaNw7gK4GwcnOqs+pPhs8g5oHgsfJl9po+qvp3zLJ
	TCgdXZyGVLhbsez4pQTXJXmHA+z/rIcTLasKdPkP+RmxFloqn3LhYZlcHiIK2DC947zbMbYDVuQ
	yydVOlaqrs/E1qSZ3bhlvqIpUmFCxF2yQXFpasslV08nV7E8pcIgmVRdLB1sfjjdvkOtTgggPzp
	LP9A=
X-Received: by 2002:a05:6a20:e211:b0:3e2:b295:7678 with SMTP id adf61e73a8af0-3f7a7fc877fmr2666283637.50.1794585108699;
        Fri, 13 Nov 2026 07:51:48 -0800 (PST)
Received: from localhost.localdomain ([219.95.157.251])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cddc160a17esm1634075a12.3.2026.11.13.07.51.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Nov 2026 07:51:48 -0800 (PST)
From: Zhefu Peng <ilskdw@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kuniyu@google.com,
	mschiffer@universe-factory.net,
	nicolas.dichtel@6wind.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net v4 2/2] selftests: net: add a test for vxlan snooping moving a MAC
Date: Fri, 13 Nov 2026 23:51:33 +0800
Message-ID: <20261113155133.75090-3-ilskdw@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261113155133.75090-1-ilskdw@gmail.com>
References: <20261113155133.75090-1-ilskdw@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test for a learning VXLAN device that snoops a known MAC from
another VTEP.

The first case moves the MAC from an on-link IPv4 remote to a remote
behind a router, and checks that traffic to the MAC still flows. This
fails while the device keeps the route cached for the previous remote.

The second case moves the MAC from a global IPv6 remote to a link-local
one, and checks that the FDB entry records the new output interface.

Both cases ping from CPU 0. The route cache is per CPU, and only the
CPU that filled it hits the stale entry.

This test was written with the help of an AI coding assistant.

Signed-off-by: Zhefu Peng <ilskdw@gmail.com>
---
 tools/testing/selftests/net/Makefile          |   1 +
 .../selftests/net/test_vxlan_snoop_move.sh    | 161 ++++++++++++++++++
 2 files changed, 162 insertions(+)
 create mode 100755 tools/testing/selftests/net/test_vxlan_snoop_move.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index baea3e7f0..69d440c5b 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -118,6 +118,7 @@ TEST_PROGS := \
 	test_vxlan_mdb.sh \
 	test_vxlan_nh.sh \
 	test_vxlan_nolocalbypass.sh \
+	test_vxlan_snoop_move.sh \
 	test_vxlan_under_vrf.sh \
 	test_vxlan_vnifilter_notify.sh \
 	test_vxlan_vnifiltering.sh \
diff --git a/tools/testing/selftests/net/test_vxlan_snoop_move.sh b/tools/testing/selftests/net/test_vxlan_snoop_move.sh
new file mode 100755
index 000000000..e8c91fbcc
--- /dev/null
+++ b/tools/testing/selftests/net/test_vxlan_snoop_move.sh
@@ -0,0 +1,161 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Check that a learning VXLAN device fully updates a remote when snooping
+# moves a known MAC to another VTEP:
+#
+# - The route cached for the old remote is dropped. The old remote is
+#   on-link and the new one is behind a router, so a stale cached route
+#   blackholes traffic to the moved MAC.
+# - The output interface follows the new remote. The MAC moves from a
+#   global IPv6 address to a link-local one, which needs an interface.
+
+# shellcheck disable=SC2154,SC2329 # setup_ns sets the ns names; tests_run calls the tests
+source lib.sh
+
+ALL_TESTS="
+	test_move_behind_router
+	test_move_to_link_local
+"
+
+MAC=02:00:c0:a8:00:0a
+
+ping_from_cpu0()
+{
+	local ns=$1; shift
+
+	taskset -c 0 ip netns exec "$ns" ping -c 3 -W 1 -i 0.2 "$@" &> /dev/null
+}
+
+add_sw_port()
+{
+	local ns=$1; shift
+	local dev=$1; shift
+	local port=$1; shift
+
+	ip link add "$dev" netns "$ns" type veth peer name "$port" netns "$sw"
+	ip -n "$sw" link set "$port" master br0 up
+	ip -n "$ns" link set "$dev" up
+}
+
+test_move_behind_router()
+{
+	RET=0
+
+	setup_ns sw ex a r b
+	defer cleanup_ns "$sw" "$ex" "$a" "$r" "$b"
+
+	ip -n "$sw" link add br0 up type bridge
+	add_sw_port "$ex" e0 s-e
+	add_sw_port "$a" a0 s-a
+	add_sw_port "$r" r0 s-r
+	ip link add r1 netns "$r" type veth peer name b0 netns "$b"
+	ip -n "$r" link set r1 up
+	ip -n "$b" link set b0 up
+
+	ip -n "$ex" addr add 10.0.1.1/24 dev e0
+	ip -n "$ex" route add default via 10.0.1.254
+	ip -n "$a" addr add 10.0.1.2/24 dev a0
+	ip -n "$r" addr add 10.0.1.254/24 dev r0
+	ip -n "$r" addr add 10.0.2.254/24 dev r1
+	ip netns exec "$r" sysctl -wq net.ipv4.ip_forward=1
+	ip -n "$b" addr add 10.0.2.2/24 dev b0
+	ip -n "$b" route add default via 10.0.2.254
+
+	ip -n "$ex" link add vx0 type vxlan id 42 dstport 4789 \
+		local 10.0.1.1 learning
+	bridge -n "$ex" fdb append 00:00:00:00:00:00 dev vx0 dst 10.0.1.2
+	bridge -n "$ex" fdb append 00:00:00:00:00:00 dev vx0 dst 10.0.2.2
+	ip -n "$ex" addr add 192.168.0.1/24 dev vx0
+	ip -n "$ex" link set vx0 up
+
+	ip -n "$a" link add vx0 address "$MAC" type vxlan id 42 dstport 4789 \
+		local 10.0.1.2 remote 10.0.1.1
+	ip -n "$b" link add vx0 address "$MAC" type vxlan id 42 dstport 4789 \
+		local 10.0.2.2 remote 10.0.1.1
+	ip -n "$a" addr add 192.168.0.10/24 dev vx0
+	ip -n "$b" addr add 192.168.0.10/24 dev vx0
+	ip -n "$a" link set vx0 up
+
+	ping_from_cpu0 "$ex" 192.168.0.10
+	check_err $? "ping before the move failed"
+
+	ip -n "$a" link set vx0 down
+	ip -n "$b" link set vx0 up
+	ip netns exec "$b" ping -c 1 -W 1 192.168.0.1 &> /dev/null
+
+	bridge -n "$ex" fdb show dev vx0 | grep -q "$MAC dst 10.0.2.2 "
+	check_err $? "fdb entry did not move to the new remote"
+
+	ping_from_cpu0 "$ex" 192.168.0.10
+	check_err $? "ping after the move failed"
+
+	log_test "IPv4 move to a remote behind a router"
+}
+
+test_move_to_link_local()
+{
+	local ns
+
+	RET=0
+
+	setup_ns sw ex a b
+	defer cleanup_ns "$sw" "$ex" "$a" "$b"
+
+	for ns in "$sw" "$ex" "$a" "$b"; do
+		ip netns exec "$ns" sysctl -wq net.ipv6.conf.all.accept_dad=0
+		ip netns exec "$ns" sysctl -wq net.ipv6.conf.default.accept_dad=0
+	done
+
+	ip -n "$sw" link add br0 up type bridge
+	add_sw_port "$ex" e0 s-e
+	add_sw_port "$a" a0 s-a
+	add_sw_port "$b" b0 s-b
+
+	ip -n "$ex" addr add 2001:db8:1::1/64 dev e0 nodad
+	ip -n "$ex" addr add fe80::1/64 dev e0 nodad
+	ip -n "$a" addr add 2001:db8:1::2/64 dev a0 nodad
+	ip -n "$b" addr add fe80::b/64 dev b0 nodad
+
+	ip -n "$ex" link add vx0 type vxlan id 42 dstport 4789 \
+		local 2001:db8:1::1 learning
+	bridge -n "$ex" fdb append 00:00:00:00:00:00 dev vx0 dst 2001:db8:1::2
+	bridge -n "$ex" fdb append 00:00:00:00:00:00 dev vx0 dst fe80::b via e0
+	ip -n "$ex" addr add 192.168.0.1/24 dev vx0
+	ip -n "$ex" link set vx0 up
+
+	ip -n "$a" link add vx0 address "$MAC" type vxlan id 42 dstport 4789 \
+		local 2001:db8:1::2 remote 2001:db8:1::1
+	ip -n "$b" link add vx0 address "$MAC" type vxlan id 42 dstport 4789 \
+		local fe80::b remote fe80::1 dev b0 nolearning
+	ip -n "$a" addr add 192.168.0.10/24 dev vx0
+	ip -n "$b" addr add 192.168.0.10/24 dev vx0
+	ip -n "$a" link set vx0 up
+
+	ping_from_cpu0 "$ex" 192.168.0.10
+	check_err $? "ping before the move failed"
+
+	ip -n "$a" link set vx0 down
+	ip -n "$b" link set vx0 up
+	ip netns exec "$b" ping -c 1 -W 1 192.168.0.1 &> /dev/null
+
+	bridge -n "$ex" fdb show dev vx0 | grep -q "$MAC dst fe80::b via e0 "
+	check_err $? "fdb entry did not move to the new remote and interface"
+
+	ping_from_cpu0 "$ex" 192.168.0.10
+	check_err $? "ping after the move failed"
+
+	log_test "IPv6 move from a global to a link-local remote"
+}
+
+cleanup()
+{
+	defer_scopes_cleanup
+}
+
+require_command taskset
+
+trap cleanup EXIT
+tests_run
+
+exit "$EXIT_STATUS"
-- 
2.54.0

