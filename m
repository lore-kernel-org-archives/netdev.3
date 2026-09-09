Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E2451E42E
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 12:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788956739; cv=none; b=DTZirVpnUvRzjnl7HXbDlHHzbI0uIZCU7DS5o3RF6EcclLD5W32dWQc9Gf0KZhfF0YHjhfoWH3gqt9GOc6Fw/ifKfLPds0A4fhJuKFbA5/oQnkxiGrONC9m+hutKtV/D3jk65dYb/2y9bLEaHM90MRnPoaZDdWQbBROVFPQQoHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788956739; c=relaxed/simple;
	bh=OO8u88ct1eUzY6gjgFbQzGRL2Zne/YtM7Y5ChNZ4mMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CVF3b8wtlmaYhmOk5/0TotVuLOPn2J2Zz9Y15BYc4j7MJJJOj+ofE7m9RLjukgnjcWkUYE4feTJLH/CCYryERnuf9iU5fAbyKRtL0Nv6Xc6xIL4HMDMbv0g/hNraVxbTJx18H/XvfrvG00j21njpf5SFm/oYESUooCpKQbmIC4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eLXegIrn; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLXegIrn"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-53024149d40so27955641cf.1
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 05:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788956735; x=1789561535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x7SoCGf8+xqv9IONclm8/e6UxRTuHFXL1XQZ0escfhE=;
        b=eLXegIrn/54b+yV7abj/03B4oufx83UkfQTHw8WImoe1AoM/prT3LD8kDWhEuXk3UZ
         OjwCb6ev+jYj0IA7T0zmnIqrcmOrq12lurAu+KIgAdXt0jMgPTRe0NyL7r3yAPGHwmIX
         NQzsQDr89uVVw2W8MS4BfRncaiEDzj7XSVvgpU1+Ajsb0tueUMMYI1Dh1uvb4QEg2NGw
         3NQ2IyXhciIgnaDhZVJKmdXPvGt0h5t+Y3Q/p3MdWzV/fUwrA+1E+G8kPYQJJY3oE9yH
         FtpCR04qc5jTzUWK8V8wE6n3X25y0HMkRXvZJbYV0Oj4pqC/m+evWWhF338/ERyClgeE
         ARgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788956735; x=1789561535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=x7SoCGf8+xqv9IONclm8/e6UxRTuHFXL1XQZ0escfhE=;
        b=TGG02VscMeGJILF8myD8L7S2/bsu1+O0H+S8yY6XgKKcl4k3fSb1s6dvrYj6lm55PM
         RYIO2awu/zuh1gMe7vB5e3z9f6QAqDTkZ8iYDqlPxg0k/tL9XuKtTJP2RwwWTSbQ0wp6
         xyXlHt9Gd5+vp6Uv+tTw/WffB+A1dJRSN1w5IOlgs2IYos5Xp4+0vMsrx0VmRv0wEEOx
         ETaVuk1uWkScBIylYK4/5ypY1ZC8jfR3exW3dZcXtUcjEtIEdEbnXELLOi1jT5OqyJFa
         e2uHPoNYdiSD8xstLQ2EUbJouSg+WvP9csotMSntbr4NcOWzh6X+ffIDz+V1HCpMSSnJ
         yuSg==
X-Gm-Message-State: AFuF++mlZzjbcY/RzrTT99Ac5ZbFBzvV9EPCHc0yU9csk8qDGxLL5UUC
	5YItLHjOnck3r7GlKFIiZ18P7GhU8LQGxeusV+b1Xit+rJ5DFv+JuIBFVg7B9Wrf
X-Gm-Gg: AYBFou0kSNDSBjxJnds9XgxjPRo+k7Wjeag5JJaHz8pJPllLt1dhtdIcCPdvkOE5wrM
	46xolHrNSFcrKJos4JJjjvnEtKnCit2UR1WpjzQne9LLki9vsdqzoH8/PTWyprsTHKC9gy8zUFm
	jX/rXIsUl8M2yY5zNifU/wja6UYY9GoWXZMQipohnCi3QuqPGxyJ6RbBq4ACPPFf+/LHIt/QZjE
	bUlSvlrjdegI+47NHxIrDdhbHkkxNSHlfdXESOFseVoMloInbym4YMpg43as+54AP9Scol8yUB7
	sDK8SGrvsQVcf337W4w65y+X4Mj9dhIMu2t2mygopO8ae3hiG75I9doS6N79vueLIWqf8Ow4QCw
	2yDAh7JR4rsNEQVNuiaFG1jHbEuw/3QrDrndAaKEFDsUnzubQzqXJnoQ1L/CkqwkJKfjuuvwckP
	TA9vg8wyC6d+hoZsk3d23j9id7aDzxApPo9KaOOmIFRJkG0HXR7sBh4wec2IKDMtn92g==
X-Received: by 2002:a05:622a:1115:b0:530:430f:b922 with SMTP id d75a77b69052e-53054a32ce5mr403798111cf.49.1788956735225;
        Wed, 09 Sep 2026 05:25:35 -0700 (PDT)
Received: from houminxi ([163.123.141.225])
        by smtp.googlemail.com with ESMTPSA id d75a77b69052e-5308d8d3eddsm61037541cf.0.2026.09.09.05.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 05:25:34 -0700 (PDT)
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
Subject: [PATCH net-next v4 1/2] selftests/net/openvswitch: add SCTP flow key test over IPv6
Date: Wed,  9 Sep 2026 08:25:20 -0400
Message-ID: <20260909122521.2687193-2-houminxi@gmail.com>
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

The merged SCTP test covers only IPv4. The SCTP branch of the IPv6
extractor (the proto=132 walk after parse_ipv6hdr) and the v6 side of
the SCTP netlink validation (match_validate() requires the sctp() key
whenever ipv6(proto=132) is matched) have no selftest coverage.

Add test_sctp_connect_v6 mirroring the v4 test: bare icmpv6() flows
forward NS/NA, and ipv6(proto=132),sctp(dst=4443)/sctp(src=4443)
flows gate the association in the same three phases (flows installed,
removed, reinstalled). A keyless ipv6(proto=132) install must be
refused with EINVAL, pinning the reject side of the match_validate()
rule; without it a regression dropping the requirement would pass
unnoticed. The refusal is asserted to be EINVAL specifically, not a
parse error of the flow string. After the association succeeds the
test also pushes a known payload across and waits for the listener
to log it, proving the datapath carries the association's traffic
end to end, not only its handshake. Skips when the sctp module is
missing, socat lacks SCTP support, or IPv6 is unavailable; an
association or payload failure with the flows installed fails the
test.

Signed-off-by: Minxi Hou <houminxi@gmail.com>
---
 .../selftests/net/openvswitch/openvswitch.sh  | 108 ++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
index a31f7fb6882d..1160f8ed7d8a 100755
--- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
+++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
@@ -34,6 +34,7 @@ tests="
 	trunc					trunc: output truncation
 	icmpv6					icmpv6: ICMPv6 echo type match
 	sctp_connect_v4				sctp: SCTP flow key matching
+	sctp_connect_v6			sctp6: SCTP flow key matching over IPv6
 	psample					psample: Sampling packets with psample"
 
 info() {
@@ -700,6 +701,113 @@ test_sctp_connect_v4() {
 	return 0
 }
 
+# sctp_connect_v6 test
+# - sctp(dst=4443) matches client-to-server INIT
+# - sctp(src=4443) matches server-to-client INIT-ACK
+# - icmpv6 NS/NA flows forward neighbour discovery
+# - remove flows and verify connection fails, reinstall and recover
+test_sctp_connect_v6() {
+	local t="test_sctp_connect_v6"
+	local v6="eth_type(0x86dd),ipv6(proto=132)"
+	local payload="SCTP6_DATA_OK"
+	local rxfile="${ovs_base}/${t}/sctp-rx.txt"
+
+	modprobe -q sctp 2>/dev/null || return "$ksft_skip"
+	socat -V 2>&1 | grep -q "define WITH_SCTP" || return "$ksft_skip"
+	[ -e /proc/sys/net/ipv6 ] || return "$ksft_skip"
+
+	sbx_add "$t" || return $?
+	ovs_add_dp "$t" sctp6 || return 1
+
+	info "create namespaces"
+	for ns in client server; do
+		ovs_add_netns_and_veths "$t" "sctp6" "$ns" \
+		    "${ns:0:1}0" "${ns:0:1}1" || return 1
+	done
+
+	ip netns exec client ip addr add fd00::1/64 dev c1 nodad
+	ip netns exec client ip link set c1 up
+	ip netns exec server ip addr add fd00::2/64 dev s1 nodad
+	ip netns exec server ip link set s1 up
+
+	# NS/NA forwarding
+	ovs_add_flow "$t" sctp6 \
+	    'in_port(1),eth(),eth_type(0x86dd),ipv6(proto=58),icmpv6()' \
+	    '2' || return 1
+	ovs_add_flow "$t" sctp6 \
+	    'in_port(2),eth(),eth_type(0x86dd),ipv6(proto=58),icmpv6()' \
+	    '1' || return 1
+
+	# SCTP port matching: dst for request, src for reply
+	ovs_add_flow "$t" sctp6 \
+	    "in_port(1),eth(),$v6,sctp(dst=4443)" \
+	    '2' || return 1
+	ovs_add_flow "$t" sctp6 \
+	    "in_port(2),eth(),$v6,sctp(src=4443)" \
+	    '1' || return 1
+
+	# A keyless ipv6(proto=132) install must be refused (EINVAL):
+	# match_validate() requires the sctp() key. Pin the reject side
+	# of that rule; the keyed installs above cover the accept side.
+	# Verify the refusal is EINVAL (missing key), not a parse error.
+	err=$(ovs_sbx "$t" python3 $ovs_base/ovs-dpctl.py add-flow sctp6 \
+	    "in_port(1),eth(),$v6" '2' 2>&1 >/dev/null) \
+	    && { info "keyless SCTP flow should be refused"
+	         return 1; }
+	echo "$err" | grep -q "(22," || {
+		info "keyless SCTP flow refused for wrong reason: $err"
+		return 1
+	}
+
+	ovs_netns_spawn_daemon "$t" "server" \
+	    socat -u -t 1 SCTP6-LISTEN:4443,fork \
+	    OPEN:"$rxfile",creat,append
+	ovs_wait sctp_eps_has server 4443 || return 1
+
+	info "verify SCTP association with port-keyed flows"
+	ovs_sbx "$t" ip netns exec client \
+	    timeout 3 socat -u STDIN "SCTP6-CONNECT:[fd00::2]:4443" </dev/null \
+	    || return 1
+
+	info "verify SCTP DATA chunk crosses the datapath"
+	ovs_sbx "$t" ip netns exec client \
+	    timeout 3 socat -u STDIN "SCTP6-CONNECT:[fd00::2]:4443" \
+	    <<< "$payload" || return 1
+	ovs_wait grep -q "$payload" "$rxfile" \
+	    || { info "server did not receive SCTP DATA payload"
+	         return 1; }
+
+	ovs_del_flows "$t" sctp6
+
+	info "verify connection fails without flows"
+	ovs_add_flow "$t" sctp6 \
+	    'in_port(1),eth(),eth_type(0x86dd),ipv6(proto=58),icmpv6()' \
+	    '2' || return 1
+	ovs_add_flow "$t" sctp6 \
+	    'in_port(2),eth(),eth_type(0x86dd),ipv6(proto=58),icmpv6()' \
+	    '1' || return 1
+
+	ovs_sbx "$t" ip netns exec client \
+	    timeout 3 socat -u STDIN "SCTP6-CONNECT:[fd00::2]:4443" </dev/null \
+	    >/dev/null 2>&1 \
+	    && { info "connection should fail without flows"
+	         return 1; }
+
+	info "reinstall flows and verify recovery"
+	ovs_add_flow "$t" sctp6 \
+	    "in_port(1),eth(),$v6,sctp(dst=4443)" \
+	    '2' || return 1
+	ovs_add_flow "$t" sctp6 \
+	    "in_port(2),eth(),$v6,sctp(src=4443)" \
+	    '1' || return 1
+
+	ovs_sbx "$t" ip netns exec client \
+	    timeout 3 socat -u STDIN "SCTP6-CONNECT:[fd00::2]:4443" </dev/null \
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

