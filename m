Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C77F44470F
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 16:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784909594; cv=none; b=ig9FUBGwqKAM8IY9o9jCe75tsNAqQ9UnipHg3Kd5XQTVffJ9B1GaFK5m3eo6iUxEQO0t5W+elNW3tSgXMVqMJdBWRz1KIg13eg2+wZIObyGSxgo+WOhf7rDgiOvmRSe7FKR5eew4D/MxNy+hzf8c3tcWcDkb9Lsf6lj2p2BKdFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784909594; c=relaxed/simple;
	bh=YhffjiTwHNnsDaIV0MpIXslfWw13P8PP5NtdMFnhPJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d1wpkdZwvmOOZ6hOZxF1Vrey2DFCAKHaeGmBAoyJo+pyM2fALk8tDnVfEnFksDyKcMKvlIwawnBVit8hgrbExaClmlqTLRTyYvU6MnWq69VI0VgjSuqeasZlU0Xzt/FpwsLvfsXlied2777on+RBwt6u3ttXmPwMWhiys5w0LQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5ykbDd7; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5ykbDd7"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4957799b92fso784695e9.1
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 09:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784909581; x=1785514381; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yqLAYmpkh+P1dlY0H6sXFdrX0pxDVL4N33QHbpBIrEk=;
        b=h5ykbDd70yNH17FxKEDzGFbT50Q1nytqv3TVH5hSnW/m/qW5PH7qZGm0lPhmh3aho1
         /3w1xgWamCswuS16W4oZWNtkiVtpYvZSNUDiWM0w4+HZsyBrINi3eUTinKVMd9WVliEB
         10ptenxzK9Kf9oJcli1EvSD/jjwSrTB0gbLU1LYJckWdPSmn1PMH2xQ81w1n1rrGHrL2
         f3ymQFf9OWbos17naO/+sU725a3whGN/XFrDuy00jk35pmx/ARlaOk3SQ43SbmzuYuXY
         zTazqKeua4mIvJY3iOanbM+Xy1tiMa9YrjtIRJU/VD2dh5F8bGQzVyyPx7yHIVVyJmoq
         GSWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784909581; x=1785514381;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yqLAYmpkh+P1dlY0H6sXFdrX0pxDVL4N33QHbpBIrEk=;
        b=omA8ekXgN1C2BvXFevzTJmj8yces0VNq5j3lmg7SOpXU7VJofiHWLp7J0GHjkPwFFY
         LZWBIG+/SvbjdgRw4Qj8zWwmrS5RePEbiLmshMMmtG0UZfn6C6jskXNchCcaln/lZGbC
         xUED5fuDGjeZlFbdqlCX4JNH6fdXZ/kk71mey7i0EIfJuwJ5dlvZssU9UnnYzVQSvfBD
         rhoVCnBcQBbD/GrxqT86NwgX2aqBfXMjszP6lQW5eCJU+JkvjEs9I7qVB3ule/uj6AS1
         h8AK8USHj55UJNSxq0h3lLEnH0a7JfYrTLhDyBsRB1pEKWeavNqxzS3GGjMDcOOBUheO
         XvCQ==
X-Gm-Message-State: AOJu0YyMfTXa7IEo09eFHt1J4tYoudl56kqfmugkreYc7kj+WfotBB/n
	1RPsQa1jaDDjfBS7T22xfrEuWqeitZwidLJIZcUZ3cIylTLgnX266rBnwD24q0adagE=
X-Gm-Gg: AR+sD10yRIOmXGRLaHefIXDehGMR1H1vZy7MfJJmFhYKWOHcFXfZW5jHYmg3viBaSIo
	63iYDbOTxvtgZinA5Q+MRWGhwnbWkvB1kE9Kk9hX8S0ZHI5nrzyCKd4hxnY6x0jF1RrHmrJQh48
	uo4Z0cPbgcdF4mdjtBbUvWF4YGRJJk40ZfVS0nefPsSJVIEpj/Y3Cy3vO4jKqNra1sIYBIGF10J
	E9SMaN/7jlsIO+IfJoC2ZFf4UVDwQ4P3CUCOSmOz0mKADLT324PpN/dAw+6Is2OYPCC4fXZORr6
	iuKas62x30xt5t+b2ta6njU1Bm/4pBjRy4ygQw29o6RAs9kj2KWW79fo/bzCOiMYgdGJGRG9GRA
	RJP/iCV45yZnGjTG4byzlVQU+CRfLYPhuyS+Xrv77RvV7bYHUNKXiq7YKS+XCWXC1cFjK6jRqwt
	cm/qOsBr+86ALzGb9lHZPGQSeXCDUyD10BFmYdlXWeVSygkK33hW0kKfys/gKhTFc0pNNsfbBS5
	0hU4w+EUyGAYEdxhYc9AXSdn11lwtehXY/k66U=
X-Received: by 2002:a05:600c:2e56:b0:495:6274:56bd with SMTP id 5b1f17b1804b1-4957ac0ed8amr19094855e9.4.1784909580824;
        Fri, 24 Jul 2026 09:13:00 -0700 (PDT)
Received: from L-022584.energy.envision.com (dynamic-077-181-161-038.77.181.pool.telefonica.de. [77.181.161.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957f9928fdsm40969655e9.1.2026.07.24.09.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 09:13:00 -0700 (PDT)
From: Xin Xie <xiexinet@gmail.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	shuah@kernel.org,
	kees@kernel.org,
	petr.wozniak@gmail.com,
	qingfang.deng@linux.dev,
	fmaurer@redhat.com,
	luka.gejak@linux.dev,
	bigeasy@linutronix.de,
	xiaoliang.yang_1@nxp.com,
	skhawaja@google.com,
	Xin Xie <xiexinet@gmail.com>
Subject: [PATCH net v2 4/4] selftests: net: hsr: add GRO super-packet forwarding test
Date: Fri, 24 Jul 2026 18:12:53 +0200
Message-ID: <20260724161253.79-5-xiexinet@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260724161253.79-1-xiexinet@gmail.com>
References: <20260724161253.79-1-xiexinet@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a test exercising the HSR forward path with GSO super-packets:
a TSO-enabled SAN behind the interlink streams TCP through an HSR
DUT to a peer node. The test verifies that:

* enslaved devices have GRO and HW-GRO disabled automatically,
* the HSR master does not advertise GSO/TSO features (including
  tx-tcp6/udp/gso-list, to catch future hw_features leaks),
* super-packets really leave the SAN (TX average frame size above a
  fixed threshold) while bulk output on the DUT's LAN legs stays at
  per-frame size — aggregate counter evidence that GSO enters the
  forward path and is unfolded at the forward entry. Zero TCP
  retransmits is reported as a secondary health signal.

The one-shot iperf3 server lives in a private mktemp -d workdir
(mode 0700): its exact PID is retained only after numeric, alive,
comm==iperf3 and netns-membership checks, its real exit status is
propagated through an rc file, and cleanup kills by exact PID with a
bounded wrapper reap plus a namespace-scoped iperf3 sweep. Server
startup failure, client failure and a never-published PID are all
bounded exits with no process or directory leaks. Environments whose
iproute2 lacks the HSR interlink syntax are skipped with ksft_skip.

Without this series the feature checks fail, and on drivers that hand
GRO super-packets to the HSR receive path the stream degrades or
stalls.

Signed-off-by: Xin Xie <xiexinet@gmail.com>
---
 tools/testing/selftests/net/hsr/Makefile      |   1 +
 .../selftests/net/hsr/hsr_gro_superpacket.sh  | 437 ++++++++++++++++++
 2 files changed, 438 insertions(+)
 create mode 100755 tools/testing/selftests/net/hsr/hsr_gro_superpacket.sh

diff --git a/tools/testing/selftests/net/hsr/Makefile b/tools/testing/selftests/net/hsr/Makefile
index 31fb9326cf5..0d105476e7c 100644
--- a/tools/testing/selftests/net/hsr/Makefile
+++ b/tools/testing/selftests/net/hsr/Makefile
@@ -3,6 +3,7 @@
 top_srcdir = ../../../../..
 
 TEST_PROGS := \
+	hsr_gro_superpacket.sh \
 	hsr_ping.sh \
 	hsr_redbox.sh \
 	link_faults.sh \
diff --git a/tools/testing/selftests/net/hsr/hsr_gro_superpacket.sh b/tools/testing/selftests/net/hsr/hsr_gro_superpacket.sh
new file mode 100755
index 00000000000..4ca2a7f395e
--- /dev/null
+++ b/tools/testing/selftests/net/hsr/hsr_gro_superpacket.sh
@@ -0,0 +1,437 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Test HSR handling of GRO/GSO super-packets:
+#
+#  1. Enslaving a device to an HSR master disables GRO on it
+#     (dev_disable_gro()).
+#  2. The HSR master does not advertise GSO/TSO features.
+#  3. A TCP stream from a TSO-enabled SAN (which therefore emits GSO
+#     super-packets) is unfolded at the HSR forward entry. Evidence:
+#     interface-counter deltas show super-packet-sized frames leaving
+#     the SAN and per-frame-sized traffic leaving the DUT's LAN ports.
+#
+# Topology (100.64.0.0/24):
+#
+#   ns_san                    ns_dut                      ns_peer
+#  +-----------+  interlink  +---------------+  LAN A/B  +-----------+
+#  | s0 [0.1]  |-------------| d_il   hsr0   |-----------| hsr1 [0.3]|
+#  +-----------+             | d_a / d_b     |           | p_a / p_b |
+#                            +---------------+           +-----------+
+#
+# SAN traffic reaches ns_peer only through hsr0's forward path
+# (interlink RX -> LAN A/B TX), so every SAN frame is tagged and
+# forwarded by the DUT.
+
+source ./hsr_common.sh
+
+ns_dut="hsr-gro-dut"
+ns_san="hsr-gro-san"
+ns_peer="hsr-gro-peer"
+san_ip="100.64.0.1"
+peer_ip="100.64.0.3"
+
+# Aggregate counter thresholds for the stream test (bytes/packets):
+# SAN_AVG_MIN proves GSO super-packets left the SAN; LAN_AVG_MAX is a
+# guard with margin, not the protocol maximum (see do_tso_stream_test).
+SAN_AVG_MIN=2048
+LAN_AVG_MAX=1514
+
+iperf_pid=""
+server_wrapper=""
+workdir=""
+pidfile=""
+rcfile=""
+
+cleanup()
+{
+	# exact-PID kill only after RE-validating identity (guards against
+	# PID reuse between publication and cleanup)
+	if [ -n "${iperf_pid}" ] && valid_server_pid "${iperf_pid}"; then
+		kill "${iperf_pid}" 2>/dev/null
+	fi
+	iperf_pid=""
+	if [ -n "${server_wrapper}" ]; then
+		# the wrapper waits on the server; reap it with a 5s bound so a
+		# live-but-unpublished server can never hang cleanup
+		for _ in $(seq 1 50); do
+			kill -0 "${server_wrapper}" 2>/dev/null || break
+			sleep 0.1
+		done
+		kill "${server_wrapper}" 2>/dev/null
+		wait "${server_wrapper}" 2>/dev/null
+		server_wrapper=""
+	fi
+	# last resort, namespace-scoped only: TERM the iperf3 processes that
+	# actually live in the peer netns, poll for bounded exit, then
+	# SIGKILL any survivor before touching the namespace name. A blind
+	# pkill would scan the host PID space and hit unrelated tests.
+	local _p _still
+	for _p in $(ip netns pids "$ns_peer" 2>/dev/null); do
+		if [ "$(cat /proc/"$_p"/comm 2>/dev/null)" = "iperf3" ]; then
+			kill "$_p" 2>/dev/null
+		fi
+	done
+	for _ in $(seq 1 50); do
+		_still=0
+		for _p in $(ip netns pids "$ns_peer" 2>/dev/null); do
+			if [ "$(cat /proc/"$_p"/comm 2>/dev/null)" = "iperf3" ]; then
+				_still=1
+				break
+			fi
+		done
+		[ "$_still" -eq 0 ] && break
+		sleep 0.1
+	done
+	for _p in $(ip netns pids "$ns_peer" 2>/dev/null); do
+		if [ "$(cat /proc/"$_p"/comm 2>/dev/null)" = "iperf3" ]; then
+			kill -9 "$_p" 2>/dev/null
+		fi
+	done
+	# remove only the known non-empty private directory
+	if [ -n "${workdir}" ] && [ -d "${workdir}" ]; then
+		rm -rf "${workdir}"
+	fi
+	workdir=""
+	pidfile=""
+	rcfile=""
+	ip netns del "$ns_dut" 2>/dev/null
+	ip netns del "$ns_san" 2>/dev/null
+	ip netns del "$ns_peer" 2>/dev/null
+}
+
+trap cleanup EXIT
+
+check_tool()
+{
+	if ! command -v "$1" > /dev/null 2>&1; then
+		echo "SKIP: Could not run test without $1"
+		exit $ksft_skip
+	fi
+}
+
+nsx()
+{
+	ip netns exec "$1" bash -c "$2"
+}
+
+setup_topo()
+{
+	local ns
+
+	cleanup
+	for ns in "$ns_dut" "$ns_san" "$ns_peer"; do
+		ip netns add "$ns"
+	done
+
+	ip link add d_a netns "$ns_dut" type veth peer name p_a netns "$ns_peer"
+	ip link add d_b netns "$ns_dut" type veth peer name p_b netns "$ns_peer"
+	ip link add d_il netns "$ns_dut" type veth peer name s0 netns "$ns_san"
+
+	# HSR tags add 6 bytes per frame; give the LAN legs headroom.
+	for iface in d_a d_b; do
+		nsx "$ns_dut" "ip link set $iface mtu 1600; ip link set $iface up"
+	done
+	for iface in p_a p_b; do
+		nsx "$ns_peer" "ip link set $iface mtu 1600; ip link set $iface up"
+	done
+
+	nsx "$ns_dut" "ip link set d_il up"
+	nsx "$ns_san" "ip link set s0 up; ip addr add $san_ip/24 dev s0"
+
+	nsx "$ns_dut" "ip link add hsr0 type hsr \
+		slave1 d_a slave2 d_b interlink d_il proto 0; \
+		ip link set hsr0 up"
+	nsx "$ns_peer" "ip link add hsr1 type hsr \
+		slave1 p_a slave2 p_b proto 0; \
+		ip link set hsr1 up; ip addr add $peer_ip/24 dev hsr1"
+
+	# Let the nodes see each other's supervision frames.
+	sleep 2
+}
+
+check_feature()
+{
+	local ns="$1"
+	local iface="$2"
+	local feature="$3"
+	local want="$4"
+
+	if nsx "$ns" "ethtool -k $iface" | grep -q "^$feature: $want"; then
+		echo "INFO: $ns/$iface $feature is $want [ OK ]"
+	else
+		echo "FAIL: $ns/$iface $feature is not $want" 1>&2
+		ret=1
+	fi
+}
+
+# Off-or-absent variant: fails only when the feature is present AND on,
+# so devices that simply do not list the feature do not fail it.
+check_feature_not_on()
+{
+	local ns="$1"
+	local iface="$2"
+	local feature="$3"
+
+	if nsx "$ns" "ethtool -k $iface" | grep -q "^$feature: on"; then
+		echo "FAIL: $ns/$iface $feature is on" 1>&2
+		ret=1
+	else
+		echo "INFO: $ns/$iface $feature not on [ OK ]"
+	fi
+}
+
+do_gro_feature_checks()
+{
+	echo "INFO: Checking that enslavement disabled GRO."
+	check_feature "$ns_dut" d_a generic-receive-offload off
+	check_feature "$ns_dut" d_b generic-receive-offload off
+	check_feature "$ns_dut" d_il generic-receive-offload off
+	stop_if_error "GRO not disabled on enslaved devices."
+
+	echo "INFO: Checking that enslavement disabled HW-GRO."
+	check_feature "$ns_dut" d_a rx-gro-hw off
+	check_feature "$ns_dut" d_b rx-gro-hw off
+	check_feature "$ns_dut" d_il rx-gro-hw off
+	stop_if_error "HW-GRO not disabled on enslaved devices."
+
+	echo "INFO: Checking that the HSR master does not advertise GSO/TSO."
+	check_feature "$ns_dut" hsr0 generic-segmentation-offload off
+	check_feature "$ns_dut" hsr0 tcp-segmentation-offload off
+	check_feature_not_on "$ns_dut" hsr0 tx-tcp6-segmentation
+	check_feature_not_on "$ns_dut" hsr0 tx-udp-segmentation
+	check_feature_not_on "$ns_dut" hsr0 tx-gso-list
+	stop_if_error "HSR master still advertises GSO-family features."
+}
+
+alloc_workdir()
+{
+	# Allocated only here, long after the initial topology cleanup, so
+	# cleanup() at setup_topo() time can never remove it. mktemp failure
+	# is a hard test failure.
+	workdir=$(mktemp -d /tmp/hsr_gro_test.XXXXXX) || {
+		echo "FAIL: mktemp -d failed" 1>&2
+		exit 1
+	}
+	chmod 700 "${workdir}"
+	pidfile="${workdir}/iperf.pid"
+	rcfile="${workdir}/iperf.rc"
+}
+
+# Numeric, alive, comm == iperf3, and really owned by the peer netns.
+valid_server_pid()
+{
+	local p="$1"
+
+	[[ "$p" =~ ^[0-9]+$ ]] || return 1
+	kill -0 "$p" 2>/dev/null || return 1
+	[ "$(cat /proc/"$p"/comm 2>/dev/null)" = "iperf3" ] || return 1
+	ip netns pids "$ns_peer" 2>/dev/null | grep -qx "$p"
+}
+
+start_iperf_server()
+{
+	local candidate_pid
+
+	# One-shot server, no -D: the wrapper records its exact PID and its
+	# real exit status (netns shares the PID namespace and the host fs).
+	alloc_workdir
+	( nsx "$ns_peer" "iperf3 -s -1 > /dev/null 2>&1 & \
+		echo \$! > ${pidfile}; \
+		wait \$!; \
+		echo \$? > ${rcfile}" ) &
+	server_wrapper=$!
+	# the wrapper writes the pidfile asynchronously; wait for it to
+	# appear instead of racing the read
+	for _ in $(seq 1 50); do
+		[ -s "${pidfile}" ] && break
+		sleep 0.1
+	done
+	if [ ! -s "${pidfile}" ]; then
+		echo "FAIL: iperf3 server did not publish a pid (no pidfile)" 1>&2
+		ret=1
+		return 1
+	fi
+	candidate_pid=$(<"${pidfile}")
+	if ! valid_server_pid "${candidate_pid}"; then
+		echo "FAIL: iperf3 server pid '${candidate_pid}' failed validation" 1>&2
+		ret=1
+		return 1
+	fi
+	# publish only after full validation
+	iperf_pid="${candidate_pid}"
+	sleep 1
+	return 0
+}
+
+# Print "<bytes> <packets>" for exactly one TX record of ns/dev; anything
+# else (missing, duplicated, non-numeric) is a hard FAIL.
+read_tx_counters()
+{
+	local ns="$1" dev="$2"
+	local out cnt
+
+	out=$(nsx "$ns" "ip -s link show $dev" | \
+		awk '/^ +TX:/{getline; print $1, $2}')
+	cnt=$(echo "$out" | grep -c '^[0-9]* [0-9]*$')
+	if [ "$cnt" -ne 1 ]; then
+		echo "FAIL: cannot parse TX counters of $ns/$dev (records=$cnt)" 1>&2
+		ret=1
+		return 1
+	fi
+	echo "$out"
+	return 0
+}
+
+eval_counter_delta()
+{
+	local name="$1" b0="$2" p0="$3" b1="$4" p1="$5" op="$6" limit="$7"
+	local bd pd
+
+	if ! [[ "$b0" =~ ^[0-9]+$ && "$b1" =~ ^[0-9]+$ && \
+		"$p0" =~ ^[0-9]+$ && "$p1" =~ ^[0-9]+$ ]]; then
+		echo "FAIL: non-numeric counter input for $name" 1>&2
+		ret=1
+		return 1
+	fi
+	bd=$((b1 - b0))
+	pd=$((p1 - p0))
+	if [ "$bd" -lt 0 ] || [ "$pd" -le 0 ]; then
+		echo "FAIL: counter delta invalid for $name (bytes=$bd pkts=$pd)" 1>&2
+		ret=1
+		return 1
+	fi
+	if [ "$op" = "gt" ]; then
+		if [ "$bd" -le $((pd * limit)) ]; then
+			echo "FAIL: $name bytes/packets $bd/$pd <= $limit" 1>&2
+			ret=1
+			return 1
+		fi
+	else
+		if [ "$bd" -gt $((pd * limit)) ]; then
+			echo "FAIL: $name bytes/packets $bd/$pd > $limit" 1>&2
+			ret=1
+			return 1
+		fi
+	fi
+	echo "INFO: $name counter delta bytes=$bd packets=$pd" \
+		"(op $op limit $limit) [ OK ]"
+	return 0
+}
+
+do_tso_stream_test()
+{
+	local out sender_retr server_rc
+	local san_b0 san_p0 san_b1 san_p1
+	local a_b0 a_p0 a_b1 a_p1 b_b0 b_p0 b_b1 b_p1
+
+	echo "INFO: Enabling TSO/GSO on the SAN interface."
+	nsx "$ns_san" "ethtool -K s0 tso on gso on"
+	check_feature "$ns_san" s0 tcp-segmentation-offload on
+	stop_if_error "Could not enable TSO on the SAN interface."
+
+	echo "INFO: Running 10s TCP stream SAN -> peer through the HSR DUT."
+	start_iperf_server || return
+
+	# Counter snapshots around the stream window. The SAN-side average
+	# must exceed SAN_AVG_MIN (aggregate proof that GSO super-packets
+	# really left the SAN); each DUT LAN leg must stay under LAN_AVG_MAX
+	# (aggregate proof that bulk output was segmented per-frame). These
+	# are aggregate discriminators, not a per-frame maximum proof.
+	san_b0=0; san_p0=0; a_b0=0; a_p0=0; b_b0=0; b_p0=0
+	read -r san_b0 san_p0 <<EOF
+$(read_tx_counters "$ns_san" s0)
+EOF
+	read -r a_b0 a_p0 <<EOF
+$(read_tx_counters "$ns_dut" d_a)
+EOF
+	read -r b_b0 b_p0 <<EOF
+$(read_tx_counters "$ns_dut" d_b)
+EOF
+	[ "${ret:-0}" -eq 0 ] || return
+
+	# rate-capped: the PRIMARY discriminator is the counter inequality
+	# above, not max throughput; retransmits are informational only.
+	# Uncapped runs flap at VM/CI edge rates without indicating a
+	# functional problem.
+	if ! out=$(nsx "$ns_san" "timeout 60 iperf3 -c $peer_ip -M 1446 \
+		-b 2G -t 10" 2>&1); then
+		echo "FAIL: iperf3 client failed:" 1>&2
+		echo "$out" 1>&2
+		ret=1
+		return
+	fi
+
+	read -r san_b1 san_p1 <<EOF
+$(read_tx_counters "$ns_san" s0)
+EOF
+	read -r a_b1 a_p1 <<EOF
+$(read_tx_counters "$ns_dut" d_a)
+EOF
+	read -r b_b1 b_p1 <<EOF
+$(read_tx_counters "$ns_dut" d_b)
+EOF
+
+	eval_counter_delta "SAN s0 TX" "$san_b0" "$san_p0" "$san_b1" "$san_p1" \
+		gt "$SAN_AVG_MIN"
+	eval_counter_delta "DUT d_a TX" "$a_b0" "$a_p0" "$a_b1" "$a_p1" \
+		le "$LAN_AVG_MAX"
+	eval_counter_delta "DUT d_b TX" "$b_b0" "$b_p0" "$b_b1" "$b_p1" \
+		le "$LAN_AVG_MAX"
+	[ "${ret:-0}" -eq 0 ] || return
+
+	# success path: the one-shot server exits by itself; reap the
+	# wrapper, then REQUIRE the rcfile with the server's real status
+	wait "${server_wrapper}"
+	server_wrapper=""
+	if [ ! -s "${rcfile}" ]; then
+		echo "FAIL: iperf3 server status file missing (${rcfile})" 1>&2
+		ret=1
+		return
+	fi
+	server_rc=$(cat "${rcfile}")
+	if ! [[ "$server_rc" =~ ^[0-9]+$ ]] || [ "$server_rc" -ne 0 ]; then
+		echo "FAIL: iperf3 server exited with rc='${server_rc}'" 1>&2
+		ret=1
+		return
+	fi
+	iperf_pid=""
+
+	# secondary health signal only: anchored, single-match, numeric —
+	# any parse anomaly is a loud FAIL, but the value itself no longer
+	# gates (the counter inequalities above are the primary evidence).
+	sender_retr=$(echo "$out" | awk '/sec .* sender$/ {print $(NF-1)}')
+	if [ "$(echo "$sender_retr" | grep -Ec '^[0-9]+$')" -ne 1 ]; then
+		echo "FAIL: cannot parse sender retransmits reliably" 1>&2
+		echo "$out" 1>&2
+		ret=1
+		return
+	fi
+	echo "INFO: TCP stream done;" \
+		"sender retransmits=$sender_retr (secondary signal)"
+	echo "$out" | grep -E "sender|receiver"
+}
+
+check_prerequisites
+check_tool ethtool
+check_tool iperf3
+check_tool timeout
+
+# iproute2 must know the HSR interlink syntax.
+if ! ip link help hsr 2>&1 | grep -qi interlink; then
+	echo "SKIP: iproute2 has no HSR interlink support"
+	exit $ksft_skip
+fi
+
+setup_topo
+
+echo "INFO: Initial validation ping (SAN -> peer through the DUT)."
+do_ping "$ns_san" "$peer_ip"
+stop_if_error "Initial validation failed."
+
+do_gro_feature_checks
+do_tso_stream_test
+stop_if_error "GSO super-packet stream test failed."
+
+echo "INFO: All good."
+exit $ret
-- 
2.43.0

