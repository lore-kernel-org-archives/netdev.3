Received: from mta1.migadu.com (out-247.mta1.migadu.com [95.215.58.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5362D594F
	for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 07:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786778154; cv=none; b=ZLFB7vEA3w+Bgov507Kf5eYIQHwO1UeAXUs5B+Xa3IzyF5mpkwqkEuhXmV2+WzhlcfJG9HB7xlW5Xp6bmAfdMiKAUvuHOvwpiU6GM+FOx/Ph1n1Cbaxas7Sj6O+EIr4K5swWfJ9j9ELZxaxuExdjPRP2wxQtpH0eydZkB98tLKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786778154; c=relaxed/simple;
	bh=9CzrLhRoKq+qS18iCs8Ie0gpwrvllBmTQsF5jWCnFzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CceFLtZVN1sugmOEl2+LUspB0Ag0HGEMU4qe0ZI5EHDXveABBhT+SjADhiblQHsCpIhBS/TqGkPCIA49LXcfB6wN/ner8DtvG+efOeDpE3rhaaoBOjKM96x4gOIeB45ArEb9+9K1FohB11qYiudCMdjDcE/eLhBIxIcUYZf/caI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OI0gzZ8S; arc=none smtp.client-ip=95.215.58.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OI0gzZ8S"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=9CzrLhRoKq+qS18iCs8Ie0gpwrvllBmTQsF5jWCnFzk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786778148; v=1; x=1787382948;
 b=OI0gzZ8SlY3bM7KxV+0DZO0nRQy4WFs4kAMqTWzAF0i9Gr+/Gaz7iMnuzbH4oWLO5fwgTv0d
 8ux/qGGoygEh3An/kSNcY6pQaYidK3A2pAAtplx3T+Qx/wjIWqmcd7v4IKN+tLIVPIlgPPQ2PNH
 Tf4fFcj31qchrk4wkIRwe1d8=
X-Envelope-To: netdev@vger.kernel.org
Received: from localhost.localdomain (147.136.157.3)
	by smtp.migadu.com with ESMTPS id b4549a7fe812b398;
	Sat, 15 Aug 2026 07:15:48 +0000
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net v2 2/2] selftests: net: packetdrill: add tests for advertised MSS with PMTU exceptions
Date: Sat, 15 Aug 2026 15:15:08 +0800
Message-ID: <20260815071532.301908-1-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260815070413.294559-1-jiayuan.chen@linux.dev>
References: <20260815070413.294559-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

Add packetdrill tests for IPv4 and IPv6 to verify that the advertised
MSS in SYN-ACK is derived from the configured interface/route MTU,
and is not shrunk by learned Path MTU exceptions from previous
outbound connections.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 .../net/packetdrill/tcp_advmss_pmtu_ipv4.pkt  | 67 +++++++++++++++++++
 .../net/packetdrill/tcp_advmss_pmtu_ipv6.pkt  | 67 +++++++++++++++++++
 2 files changed, 134 insertions(+)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_advmss_pmtu_ipv4.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_advmss_pmtu_ipv6.pkt

diff --git a/tools/testing/selftests/net/packetdrill/tcp_advmss_pmtu_ipv4.pkt b/tools/testing/selftests/net/packetdrill/tcp_advmss_pmtu_ipv4.pkt
new file mode 100644
index 000000000000..f2ef931b77a1
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_advmss_pmtu_ipv4.pkt
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Test that IPv4 advertised MSS in SYN-ACK is derived from the configured
+// interface MTU (1500 -> MSS 1460), not the ICMP-learned Path MTU.
+
+--ip_version=ipv4
+
+`./defaults.sh
+ethtool -K tun0 tso off
+`
+
+//
+// Connection 1: Learn PMTU exception (MTU 1200 -> MSS 1160)
+//
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < S 0:0(0) win 65535 <mss 1460,sackOK,nop,nop,nop,wscale 8>
+   +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+  +.1 < . 1:1(0) ack 1 win 257
+   +0 accept(3, ..., ...) = 4
+
+// Send a full 1460-byte segment
+   +0 write(4, ..., 1460) = 1460
+   +0 > P. 1:1461(1460) ack 1
+
+// ICMP Fragmentation Needed arrives indicating next-hop MTU 1200
+   +0 < icmp unreachable frag_needed mtu 1200 [1:1461(1460)]
+
+// Local host retransmits using the learned MTU 1200 (MSS = 1200 - 40 = 1160)
+   +0 > . 1:1161(1160) ack 1
+   +0 > P. 1161:1461(300) ack 1
+   +0 < R 1:1(0) ack 1461 win 0
+
+// Close connection 1 and listener
+   +0 close(4) = 0
+   +0 close(3) = 0
+
+//
+// Connection 2: New connection from the same peer
+//
+   +0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < S 0:0(0) win 65535 <mss 1460,sackOK,nop,nop,nop,wscale 8>
+
+// Verify: SYN-ACK MUST advertise configured MSS 1460, NOT the learned PMTU MSS 1160
+   +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+   +0 < . 1:1(0) ack 1 win 257
+   +0 accept(3, ..., ...) = 4
+
+// Verify: Outgoing transmit MSS is still constrained by the learned PMTU 1200
+   +0 write(4, ..., 1460) = 1460
+   +0 > . 1:1161(1160) ack 1
+   +0 > P. 1161:1461(300) ack 1
+   +0 < . 1:1(0) ack 1461 win 257
+
+// Clean up
+   +0 close(4) = 0
+   +0 > F. 1461:1461(0) ack 1
+   +0 < F. 1:1(0) ack 1462 win 257
+   +0 > . 1462:1462(0) ack 2
+   +0 close(3) = 0
diff --git a/tools/testing/selftests/net/packetdrill/tcp_advmss_pmtu_ipv6.pkt b/tools/testing/selftests/net/packetdrill/tcp_advmss_pmtu_ipv6.pkt
new file mode 100644
index 000000000000..c7638b11a815
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_advmss_pmtu_ipv6.pkt
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Test that IPv6 advertised MSS in SYN-ACK is derived from the configured
+// interface MTU (1520 -> MSS 1460), not the ICMPv6-learned Path MTU.
+
+--ip_version=ipv6
+
+`./defaults.sh
+ethtool -K tun0 tso off
+`
+
+//
+// Connection 1: Learn PMTU exception (MTU 1280 -> MSS 1220)
+//
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < S 0:0(0) win 65535 <mss 1460,sackOK,nop,nop,nop,wscale 8>
+   +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+  +.1 < . 1:1(0) ack 1 win 257
+   +0 accept(3, ..., ...) = 4
+
+// Send a full 1460-byte segment
+   +0 write(4, ..., 1460) = 1460
+   +0 > P. 1:1461(1460) ack 1
+
+// ICMPv6 Packet Too Big arrives indicating next-hop MTU 1280
+   +0 < icmp packet_too_big mtu 1280 [1:1461(1460)]
+
+// Local host retransmits using the learned MTU 1280 (MSS = 1280 - 40 - 20 = 1220)
+   +0 > . 1:1221(1220) ack 1
+   +0 > P. 1221:1461(240) ack 1
+   +0 < R 1:1(0) ack 1461 win 0
+
+// Close connection 1 and listener
+   +0 close(4) = 0
+   +0 close(3) = 0
+
+//
+// Connection 2: New connection from the same peer
+//
+   +0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < S 0:0(0) win 65535 <mss 1460,sackOK,nop,nop,nop,wscale 8>
+
+// Verify: SYN-ACK MUST advertise configured MSS 1460, NOT the learned PMTU MSS 1220
+   +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+   +0 < . 1:1(0) ack 1 win 257
+   +0 accept(3, ..., ...) = 4
+
+// Verify: Outgoing transmit MSS is still constrained by the learned PMTU 1280
+   +0 write(4, ..., 1460) = 1460
+   +0 > . 1:1221(1220) ack 1
+   +0 > P. 1221:1461(240) ack 1
+   +0 < . 1:1(0) ack 1461 win 257
+
+// Clean up
+   +0 close(4) = 0
+   +0 > F. 1461:1461(0) ack 1
+   +0 < F. 1:1(0) ack 1462 win 257
+   +0 > . 1462:1462(0) ack 2
+   +0 close(3) = 0
-- 
2.43.0

