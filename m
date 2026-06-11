Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729D729BDBF
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 16:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781195149; cv=none; b=Px9oj6KibB2aXUc/dbYr1G4X5jbbFZuJLYHf1QmGKF90SVauyMaOZVML3WiLrDmz0e0jIlJ/zGkpVXfTGsbMz24CwseeT3rp0SUi5sJ/PkIyZ9La4QPgftrxUuBOzl63lodusUblHfj8KVBq+WZ2LXJR6RidKHDi5MXrlnMHiHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781195149; c=relaxed/simple;
	bh=r4gBunOLXIzFtVXn/AR+uFVL6An1nu2a3WGcFyXAMhs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cYN+LXO60gzaso/iOVbNToPE3Z1f1SpnptWxdevVw0HR1iiy1oNncVCk4wINOTyKoSTr7Ste6Ub7B67SHhZK0aTLyjmkF6ddVlkY3AmKoW8ZiuoCoxbh449Yb+FuE1N5bmjw11g/P2vPv0aK+gPqYyjSaVwYda4mVp2j5tzmVj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lVuQt45k; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVuQt45k"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-9158fbaa4bbso6494285a.1
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 09:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781195147; x=1781799947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qg6NySY8h7A00xegM352BvnzcFE1OpOjjzeGdz7V4Mk=;
        b=lVuQt45kJ5hlbWuNKeQE+hPfZ1fBg6gcP7dx7b9GZX01nRJ4vbGxicrPk1wbaxzLu/
         nojZ4lYaL4KBDyhT1dDJOnINEi41Zdlo4zQ0DE/h4BlpPLmdy5Rt1XVOnfcpZyH7Digr
         eucSHzAJOs/+pIwL8MDOenkkhx4oMNwarrxekWIy6fOQzXA3E5kl5xb7pL9zaaEXiOGw
         zF58PT1F/lVYAt+dgNybIqKouL704qTMFYbNvJXdm8/4d2fGHLi7GWc3LLx9nVTkkPdE
         zh4WfcTu0FYN3hZ42JGuti0uAQl/MDXjmmNKVKtY27CM93BTyC+cjsNTZCirbYsWCn6Q
         GcbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781195147; x=1781799947;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qg6NySY8h7A00xegM352BvnzcFE1OpOjjzeGdz7V4Mk=;
        b=ibSoq1o+X29hjrNzrd6qcugK+8Iry/PxxoXwmEGpmE+zWdkg1QOiIMe/GquzpaVson
         4NDY7v1NhJ2dnB7JS8cYySz/AxhVoUhbl54s+63yjSjhmb6LsLE7URC58WcCuHmeZjke
         S7WMC0JRzx5+OE1Af05iR5/+GDJjK7L4Q3ALOyS85QuoWmC7JgbPBsen69yTdw9AWrxJ
         TgCz9uyYTAvPKcasXq31/mTFCrMmABAnTqrFABCE9yI1I1fg318SkJksPwY5aI4ANIJT
         8oV1RxhoFRn22SMcDaaB4M1gPAQJ8AhpniS5h75YnyFAWIU30JHvlvNAyp977a3tOSR6
         /5iA==
X-Gm-Message-State: AOJu0Yz0b2qotS1nkz8+eHYkxHqjB3xC5XRghZAYnHn4fNe/yAc0jiGt
	CfvMRKPbWZkFaYpQ1/hDunuRsvrgHTac89kkgDRWzDVJr4fP0AF1q9UdUgiLuMXFFrQ=
X-Gm-Gg: Acq92OGx/vsXQjt3Oh2Mn4CcvaKh9gXYsG5Gn3k8IU4+j6m8HOyLk2Ylzj6ksRwxIo1
	j8I25lbs4SQjpOePg8TxqNMr0eBjIQS4+crZ0E484BAQ0crzLyJcCGVBJVMNNs24voUb6xUNtpG
	OSIyJPG0zX3kNNNf35CAA7r7CSSNeyGwwKQKWfhO5lgkpQddrOygkPqVIlukGRnqRnPmbWZ5z+j
	qGCIcZHNbJA7Nk57jmWc2VuB1HuI6TJkhzQIzotTHYkp2059BGVaTWcXdbcZzzuvuFuJ3pZQU8x
	ytYPZpZLASvHbHSzUUYlpywvwlQOb2CAfrmiKLFDXtgvWKk9boMV2QEED8TUb7nIdnhZIuSbM5c
	6Vi7rGbQZNk8MPStmlrjj07UmwbmG5G8tu0kCKlreVTjLPbsnxrN2YOTO3NwyA5sR97kzOhmId7
	QU7Fsno/jolaobYJyAgw==
X-Received: by 2002:a05:620a:3944:b0:915:9273:9241 with SMTP id af79cd13be357-9160ac7d21dmr548401685a.2.1781195147185;
        Thu, 11 Jun 2026 09:25:47 -0700 (PDT)
Received: from houminxi ([163.123.141.225])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9160adf4383sm223254385a.23.2026.06.11.09.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 09:25:46 -0700 (PDT)
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
Subject: [PATCH net-next] selftests/net/openvswitch: add output truncation test
Date: Fri, 12 Jun 2026 00:25:37 +0800
Message-ID: <20260611162537.3082686-1-houminxi@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add test_trunc exercising the OVS_ACTION_ATTR_TRUNC action. The test
verifies truncation in three steps: first confirm normal forwarding
works, then apply trunc(14) which truncates packets to the Ethernet
header and verify ping fails, then restore normal forwarding and
verify connectivity recovers.

The trunc action sets OVS_CB(skb)->cutlen, causing pskb_trim at
output time. With trunc(14) the IP payload is stripped, so the
receiver drops the frame and ICMP echo reply is never generated.

Signed-off-by: Minxi Hou <houminxi@gmail.com>
---
 .../selftests/net/openvswitch/openvswitch.sh  | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
index 82f066a0ceed..181eeb332de9 100755
--- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
+++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
@@ -30,6 +30,7 @@ tests="
 	drop_reason				drop: test drop reasons are emitted
 	pop_vlan				vlan: POP_VLAN action strips tag
 	dec_ttl					ttl: dec_ttl decrements IP TTL
+	trunc					trunc: output truncation
 	psample					psample: Sampling packets with psample"
 
 info() {
@@ -300,6 +301,71 @@ test_dec_ttl() {
 	return 0
 }
 
+test_trunc() {
+	sbx_add "test_trunc" || return $?
+	ovs_add_dp "test_trunc" trunctest || return 1
+
+	info "create namespaces"
+	for ns in client server; do
+		ovs_add_netns_and_veths "test_trunc" "trunctest" "$ns" \
+			"${ns:0:1}0" "${ns:0:1}1" || return 1
+	done
+
+	ip netns exec client ip addr add 10.0.0.1/24 dev c1
+	ip netns exec client ip link set c1 up
+	ip netns exec server ip addr add 10.0.0.2/24 dev s1
+	ip netns exec server ip link set s1 up
+
+	ovs_add_flow "test_trunc" trunctest \
+		'in_port(1),eth(),eth_type(0x0806),arp()' '2' || return 1
+	ovs_add_flow "test_trunc" trunctest \
+		'in_port(2),eth(),eth_type(0x0806),arp()' '1' || return 1
+
+	ovs_add_flow "test_trunc" trunctest \
+		'in_port(1),eth(),eth_type(0x0800),ipv4()' '2' || return 1
+	ovs_add_flow "test_trunc" trunctest \
+		'in_port(2),eth(),eth_type(0x0800),ipv4()' '1' || return 1
+
+	info "verify connectivity without truncation"
+	ovs_sbx "test_trunc" ip netns exec client ping -c 1 -W 2 \
+		10.0.0.2 || return 1
+
+	ovs_del_flows "test_trunc" trunctest
+	ovs_add_flow "test_trunc" trunctest \
+		'in_port(1),eth(),eth_type(0x0806),arp()' '2' || return 1
+	ovs_add_flow "test_trunc" trunctest \
+		'in_port(2),eth(),eth_type(0x0806),arp()' '1' || return 1
+
+	info "add truncated forwarding flow"
+	ovs_add_flow "test_trunc" trunctest \
+		'in_port(1),eth(),eth_type(0x0800),ipv4()' \
+		'trunc(14),2' || return 1
+	ovs_add_flow "test_trunc" trunctest \
+		'in_port(2),eth(),eth_type(0x0800),ipv4()' '1' || return 1
+
+	info "verify ping fails with truncation"
+	ovs_sbx "test_trunc" ip netns exec client ping -c 1 -W 2 \
+		10.0.0.2 >/dev/null 2>&1 \
+		&& { info "FAIL: ping should fail with trunc(14)"
+		     return 1; }
+
+	ovs_del_flows "test_trunc" trunctest
+	ovs_add_flow "test_trunc" trunctest \
+		'in_port(1),eth(),eth_type(0x0806),arp()' '2' || return 1
+	ovs_add_flow "test_trunc" trunctest \
+		'in_port(2),eth(),eth_type(0x0806),arp()' '1' || return 1
+	ovs_add_flow "test_trunc" trunctest \
+		'in_port(1),eth(),eth_type(0x0800),ipv4()' '2' || return 1
+	ovs_add_flow "test_trunc" trunctest \
+		'in_port(2),eth(),eth_type(0x0800),ipv4()' '1' || return 1
+
+	info "verify connectivity restored without truncation"
+	ovs_sbx "test_trunc" ip netns exec client ping -c 1 -W 2 \
+		10.0.0.2 || return 1
+
+	return 0
+}
+
 # psample test
 # - use psample to observe packets
 test_psample() {
-- 
2.54.0

