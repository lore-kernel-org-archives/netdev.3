Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88E0381E86
	for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 02:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787451002; cv=none; b=CVLhybEn6dcThrBrjdU4azKltx9cC+dMYppxkGctkdqW/BMLk8IOIdnXEEhNDAZ0zHP3OpiHaD3iAlpqd+Hi6IlC4YF/OojEYuDnU2bkAuruuvXy4iQBpfTkfdVvnCvH/Wj3uJBOuUau2UYhN4udQf+lYlmmGKzL9ILzyncbpfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787451002; c=relaxed/simple;
	bh=2Ty2mpcEhGgNSz5GN77057gLiDTsvFjbxF+GBfR/yuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YyoTRH5Xu3aW2vCHpqvP2kXtMOk3jNexKU3OXOUJ56DwIWGxzWzxD39qrIC6ODMb7ttHuB900ikRGf5ayNzC9jkJiwzxzirVCQpjTwZPMe/wQWyW7v1l6g63Ya54p1uj45TQuzWgC6iJJPZIQI/6DDjtyiTqKGKc5SN4OGk1TY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M7YvbYXb; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M7YvbYXb"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cbee846deecso2682593a12.1
        for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 19:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787450998; x=1788055798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ka7AUYqkvnad6cVVx0OUSmQE7kC7pkR2H7Mh+6aLu4I=;
        b=M7YvbYXb01wsN0k4MON0ACZPg+L7J+GxWH43aEXWQo9++o683dSQAStvXF2sSsTawV
         k/IuPJW1VHcjmZLmIdOPiZ7LDi+YaFv6QhlCCgzLm2IDQDE4bDALHinXzTQgz99ZWFwj
         OvF2nRVU8cAIHka4ADj4LSWsnwI2Slyb/TUTg2yGzSBueZa0tqhXtcCKGMTricN1Hak3
         VXDAKAda6A45z6A0T8qdUC8eXIWIxF1vWDp8iRDNHdA/jVtkPJ62SQQav11/TCQXrVFe
         5oRj1oQvu+vgVzuV/+Ion95pCOnOnYaNX0kC6qFWBswH3MfyVTktEFVSDTk8LqVnuDOQ
         TedQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787450998; x=1788055798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ka7AUYqkvnad6cVVx0OUSmQE7kC7pkR2H7Mh+6aLu4I=;
        b=bmZK4zAHYTxIAgjRMHFl6JRbyDAf7Z9BsDBDO82VQkfrdd0dcGzFasBLsMcm8CUMXi
         wSiuDJFZ5ssRGDHDfjHAZlAJPtoX3aKIER9QeILdH8h+qvrL/qI8KHrm5Cijogd/+nK9
         Ur6mA3lbytKIdb0Stb0sOLT/4xYQmWRkSmGegIL78PrNISWWNycY1h53k4Hrvd4b0jrs
         c9Q04CY6ivx4r629fCjV8zctGBq7YwO9naYuBhaYSfuuAJERvP8JLbQvVAUtLYLCpiN8
         FLkPquCS75FcYMzzr74/6B5yuyHIlWE2tbLYW0m/rgZuAy5UpXJfv7t1+1EGJsw73iBq
         Qk1A==
X-Gm-Message-State: AFuF++kUUe6Ldv4S73VdJL16gsFrmNcpbMJxHnp/sHQBw5hUTf/lku7r
	hA/iOxWB9Xn8AoT5iCYM4WiYL2eG/w8dGl0Wd/kZGX8aYgk19MhFKI7m5/PExfKg7+E6Tg==
X-Gm-Gg: AR+sD11jhjTP+FDmOmNXQ1BAKINZrghF3YClqAjEm4K+PJMy9fzMGZgLddghzib5bSy
	NhJDcV+Q8AEIuOrBalUWhqGxyZ6fkFoRfah8M7ZaDGNiDTReAngWZR0gwxD8cafPu/rhgRhfYNm
	HU7pkoCmLhUbFeDOFeGlFjrY6VjcZvgQwb8Dszkg8TnGJdhu9kdxZCG8FFcx48kYS+D4OD5ysSp
	+rDpm1Xx92qS6l/9vOBkcjpQCvWERFC33wtgdXi8AMjNHixsMqxK1Utrzm+7HVhFLttFygYHDeF
	2Qi9OGDd+tlq99TcAqMptrrRd5WTqzMUL27kwDbyYXnXcNSOpEphkfm/8ib0FnyN96UUUp+NA+e
	Z77lrx5ArQ1ffoWhXdm06NsnaKlWrvxoisa0eeeMbcB4r/99RnJeSzlU3Z4DmZPkO45XzJV56dW
	94IvmgIIdGnEVQQXvqKOkE8PjTcDkX+tFPWU3vBhHmbpIM1/U5g7dd
X-Received: by 2002:a17:90b:1d49:b0:38e:70d5:b12d with SMTP id 98e67ed59e1d1-395c3566ba6mr33799117a91.6.1787450998171;
        Sat, 22 Aug 2026 19:09:58 -0700 (PDT)
Received: from houminxi ([61.170.217.176])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141861732f8sm11371949c88.10.2026.08.22.19.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 19:09:57 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: aconole@redhat.com,
	davem@davemloft.net,
	dev@openvswitch.org,
	echaudro@redhat.com,
	edumazet@google.com,
	i.maximets@ovn.org,
	i.maximets@redhat.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	horms@kernel.org,
	Minxi Hou <houminxi@gmail.com>
Subject: [PATCH net-next 1/2] selftests/net/openvswitch: add SCTP flow key test over IPv6
Date: Sat, 22 Aug 2026 22:09:41 -0400
Message-ID: <20260823020942.3101898-2-houminxi@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260823020942.3101898-1-houminxi@gmail.com>
References: <20260823020942.3101898-1-houminxi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The merged SCTP test covers only IPv4. The IPv6 extraction path
(parse_ipv6hdr walking extension headers, then the proto=132 branch in
key_extract) and the v6 side of the SCTP netlink validation have no
selftest coverage at all, so a regression there would ship silently.

Add test_sctp_connect_v6 mirroring the v4 test: NS/NA forwarding flows
stand in for ARP, and ipv6(proto=132),sctp(dst=4443)/sctp(src=4443)
flows gate the association in the same three phases (flows installed,
flows removed, flows reinstalled). After the association succeeds the
test also pushes a known payload across and verifies the listener
received it, so a flow-key bug that matches handshake packets but
breaks DATA chunks is caught too. Skips when the sctp module is
missing, socat lacks SCTP support, or IPv6 is unavailable; an
association or DATA failure with the flows installed fails the test.

Signed-off-by: Minxi Hou <houminxi@gmail.com>
---
 .../selftests/net/openvswitch/openvswitch.sh  | 97 ++++++++++++++++++-
 1 file changed, 96 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
index a31f7fb6882d..06bd98d80a08 100755
--- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
+++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
@@ -33,7 +33,8 @@ tests="
 	action_set				set: SET action rewrites fields
 	trunc					trunc: output truncation
 	icmpv6					icmpv6: ICMPv6 echo type match
-	sctp_connect_v4				sctp: SCTP flow key matching
+	sctp_connect_v4			sctp: SCTP flow key matching
+	sctp_connect_v6			sctp6: SCTP flow key matching over IPv6
 	psample					psample: Sampling packets with psample"
 
 info() {
@@ -700,6 +701,100 @@ test_sctp_connect_v4() {
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
+	grep -q "$payload" "$rxfile" 2>/dev/null \
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

base-commit: 91ec2035134982b98fab0609a9fd8480e8217dc1
-- 
2.55.0

