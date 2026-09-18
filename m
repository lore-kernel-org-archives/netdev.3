Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64913B0AE6
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 14:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789742827; cv=none; b=U+xgIkMl9Du33ge2kAg47XbmpoM37/7smUTKU6qCQXnmRlWnHW3pP81RvqlFSe8s8YI95NqxXUbkFVG0qkFVGXlakxJfPT4y+pcequGAUquEq5zSjeu350wB1PDbwpuEDZZbxqxxrE1GT+4SgT82ftxcJz+wfwL2/0fuErMwtHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789742827; c=relaxed/simple;
	bh=yyzDJ6tgMHbUOtV4m2jvAzPafWSuDSzveKx2sxxDvvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uhQLhCFEAY2K6rqs6OTUthLpKbko6zzoIzDCLImQAmOzkMHv8zLvLRDfMPlZ9yOVOHaXU6BDWlkTy8WX/JcbHCDw/eKqbE4SlOzwtXXMiRak99yBzDD7FvTL7YPQcpqPAjNDuPOk8PcMZHytWWEfw7lzZuiSfWeYQuqKj6aukhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RNkujBWQ; arc=none smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RNkujBWQ"
Received: by mail-qk2-f43.google.com with SMTP id af79cd13be357-939109fafd7so69831185a.2
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 07:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789742824; x=1790347624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FP5djMtQdGEuhYjqqxbZe6NA8KjfBNsQvn2RCC42U1Y=;
        b=RNkujBWQ3lQhHYm0tS1NdTrOB1syMIhL37bCIioxVe3b1X8xbauXl7rDhzX+IY+XqY
         W6T0SATyQ6dM93h6YH1KxIeOBXbQApTJ7NdAfZ3DMuWditCaVx2HyA8ddw9eJMenBKZ/
         jC0UmM026khNQy2zWlptBFbEY5RHND5jrMuN20WoLwHCme4EKaCkI6DbBhGd2asWa+8o
         Rq3datMqpjYCtLYDldkMyqaI4inrX2MFSR7e/yTGI2PMCKGEcJToCe1HcQSovedfLTax
         Di48lZGwW7t8hNPMLB5BCSlBP2NtAUN/8HfkLAbDG0PvRZoxkQ9ONQVUaRipcLn9/Dud
         +x7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789742824; x=1790347624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FP5djMtQdGEuhYjqqxbZe6NA8KjfBNsQvn2RCC42U1Y=;
        b=IOCvJUghrauGMWgQMSM0XYB1Xb4MOHCZ8itSvnMj0Bq0GBlTZCzlXYxdGj3bu85lcP
         WIMJu4WpYgGAUFLkOgKetRGwQfpF+gRDiKvxXYRzlD/NUxatxSovYt1m/GJ+iqgmacj8
         bHxWYyT6MnizlmwBhuxWSOpCd1Hcejw3bWfxaURszd6fyyNT5VjHfSzR9c0Awc6GSfeV
         +8P6y+HSdypDo8ue8ZXP9AhMmF4X3I6lzFIAV0DZLw4Mz4ODbXl/AO7EjfrPLj4Ahv9q
         MD9GZwG2zD8eCAOqQRBc6uoavQekH6B71UJviha5caeV0lwtoz3NaNRByiAILlsyJQYp
         zmWw==
X-Gm-Message-State: AFuF++m1+KxQVf4gVIxqDBsiZrj2WTsmMh0UrsxsDoBG96bWnpGkp+ne
	3q/5goH1FuMgqWrkIPYQ4uEWl03SjY1h/c25/7fpHFdnR81OxMbJpMXzaAOnQNNc
X-Gm-Gg: AYBFou34NszFCijdDAxCxL+MkFuwg0cNmdAjM74mQXpebemkQwcrayTDHE62GDa9eQc
	Bv6x2nvj3tRMeypMBl4knKqNgaP6yGDZU04Jj8xcm0B9eogbTLrc8b1ILnoPwZzst9Q8rgy80LQ
	71zief+TUMIms0HWgMV8DHgz8c2KFFVoDiUkeN5/QV3KGmzw7jqHoabyTuG78TGeCqbURhWgzua
	WO+zuIsNqaI33JnXoOloKrlOKa7T+AbjDhgZq0zh5lksSNDn6yc1VymGv3XSm31OOnJ++GYi5/d
	XSbUFSQBQoOnyQ7a3ziuWfe7EVvD5rNNyIdgFTLi5jNORkjxkh0lAsl7vo7S7Iqs/3H0EvEV8eh
	uiNeDfEutGgAHSlhYP6/4b0qvyE4kkmicW2IFEdxlb2hfeCN95ArUcsw4+925rmQXYKsVsfbPVD
	DwqiASapZRtFkfPRRe206JQOxnKzSBdPoizC3MYc1PbqDn8eA1TFNpX63/lIrZj7RJyF8A9thty
	OXo
X-Received: by 2002:a05:620a:608d:b0:93b:d79e:18f7 with SMTP id af79cd13be357-93bdc8dfaf2mr392279885a.58.1789742824110;
        Fri, 18 Sep 2026 07:47:04 -0700 (PDT)
Received: from houminxi ([61.170.217.176])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93be0ed50b2sm160197485a.32.2026.09.18.07.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 07:47:03 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	dev@openvswitch.org,
	linux-kselftest@vger.kernel.org,
	Minxi Hou <houminxi@gmail.com>
Subject: [PATCH net-next v5 1/2] selftests/net/openvswitch: add SCTP flow key test over IPv6
Date: Fri, 18 Sep 2026 10:46:46 -0400
Message-ID: <20260918144647.2024095-2-houminxi@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918144647.2024095-1-houminxi@gmail.com>
References: <20260918144647.2024095-1-houminxi@gmail.com>
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
missing, socat lacks SCTP or IPv6 support, or IPv6 is unavailable;
an association or payload failure with the flows installed fails
the test.

Signed-off-by: Minxi Hou <houminxi@gmail.com>
---
 .../selftests/net/openvswitch/openvswitch.sh  | 109 ++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
index a31f7fb6882d..aa84fafc3201 100755
--- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
+++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
@@ -34,6 +34,7 @@ tests="
 	trunc					trunc: output truncation
 	icmpv6					icmpv6: ICMPv6 echo type match
 	sctp_connect_v4				sctp: SCTP flow key matching
+	sctp_connect_v6				sctp6: SCTP flow keys over IPv6
 	psample					psample: Sampling packets with psample"
 
 info() {
@@ -700,6 +701,114 @@ test_sctp_connect_v4() {
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
+	socat -V 2>&1 | grep -q "define WITH_IP6" || return "$ksft_skip"
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

