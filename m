Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB67367B8E
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 13:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791811598; cv=none; b=LA2gUc3HZeR5LYxPMz0X05GuBDQWoSY8/HkMXsN/3J28eYAkarFPU3PTd1C0eRFKuCYmprz5vhdfCu5euaSpajbA19IQwh8HkUrYDkkq23iD//eWw7PiOFQJbUm8aFeBQUZlWdoYfiYs+6HzsYMNGNcMWt5UQOnTETOgbj6pG6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791811598; c=relaxed/simple;
	bh=tEhgdvR5dXlZ2sBWgNodEMf5jbc63XxHqDMT5EOAe0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d3QGkNURlavLAVB/erkQcvBJQosPl/GmRNsKieCb8E1PNu1vy5QcXd0CE5WSt8N0Hgvsyfr2Rhv4G5kZg5aVDA87e+P/z86905CsLGwDSPPSD5kOA6TdwgLzp8wh1eFswqlJVJ5yfHkqg2c63rYSxi0yxsDlHsYpl3RcaoRWfUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UX4zaLK4; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UX4zaLK4"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-35a31bb9fb6so2928040eec.1
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 06:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791811596; x=1792416396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LlpHzIuYQd2oZxIU0NKyhphISYrEiSsYul67utJZnW0=;
        b=UX4zaLK4L5HSbe3GFKB458RNoIuwZrn1Qlf+28Gb+HYNHhVnDiRTqwhHGYdU7qnmoT
         PcL26k05Bh4Joh+cB7RgaWU7EtprABjHjUhZgFkRRoxJxDEttfRErWc4vjORckCA4kAy
         bpd+4WgjEZc1s1wQDKW4vmrjO9OV4a8W+Uf7AYcknZIH6lYZVSL3I3iaIyJwFHwNqKKX
         dqAQFA1zNadP0PUKUd4wnsePKqJeKkbyLtgfwmzYj4epwEBq8zaZgv6NZF9ycF9u2vWo
         3PnZoHvB3ID1f5Cwm4oO41AYviQ5OFVaau2JgW/R4GeYky749DdDWlMB/HUBJtehNarJ
         IYKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791811596; x=1792416396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LlpHzIuYQd2oZxIU0NKyhphISYrEiSsYul67utJZnW0=;
        b=bsgfqnF9zhl2/dCWy6SN2VQiP6qQxg4EBHy1fQ1bWxVmI73hxv9x17GrRGxipPo/8M
         fsEt8hpS+YIsRk0tWUmhGZcV3b1KOfVoJ7yAskJiLxFpM9prdbJlsFEmETKlbnTZZwtp
         f3hblPlEOdj2Its3c30ZeUROk1wrSqcBjeb3vLbnv0JuEXSLdKepJTyfGylOcQiRNIsW
         Zt38eaAv818cX470nUhkX76xQDGusTTjeV9hwzvobOvZAR+gyUH4p1lP9hveTbTC130R
         CIfV0LARL5KS6k3DtLU2ktUY2II0W0PHqEPBPVmSypkVD7JEV4bBl884sM3Nz3W+3mlh
         V5Hw==
X-Forwarded-Encrypted: i=1; AKwUvBwB1nQCNr8sOD239hfVm01aK1afFnkzxlbYeS6cYXZv4D2f2NOoktZOVIfuF2rkULHaLLWq8wE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJWpjyEF5PW66LR88r7TM77tdfbj0hFHU6wrVQWe7ryymcuNfCN
	F33cZKfwpX8zV0G13EGZQM/mKIMMPdm7ZfV8MnA67OY1YzzNnIg2rrzu
X-Gm-Gg: AYBFou39+JaA9VXNqUSQNj0ckJptDk6X2MwTrhlQLMxOJMhw38Ebh9vMLW8NwPc1wRE
	awede542NvjwyHNEEzdNhBYyF965GBI4m9y1tUsShVb55dAU7pjst0iIyMTyKkfM5Zcla7jm+bb
	dioe1uS2sCS4StD5dgx98CKgDekYjimmUDKW78iGiOCbf0+b/bqM+UiUizQrDRE1U/a2Ic7AupC
	rQ8xV9/dkvyqDHRiQNyWWbCmP2geYpKFteW5lEB/wojG+w0F5T6wUCChDvPBKDgNifFe357XEgw
	nBAnSkZr+hgLz3SIId/FKR6Vf+XQECuQUS+WvVFt3Ec9bPxQLi6z21MjENLwqQFwBjLaAFKsMU9
	p/VJGIB0qmwSZZMOJEiAqcY3/yM0jXtgFYNPKqVln++hE5Oox/E3oiCeHSO/+49qRFASZEuFdHO
	Vy1R/9OuWYKXA+OPcw4doq0m0h6ztfvemmqfzYwi6cZootonz65IwzzBiq2Q0sflU6xLzrRema6
	luQJCWHw1cyhYvkvw8lUQLrGpexjxEfEShpXmpg5yvbslUOsN5pdAcgpPqu9WT/TtkvR4JRuVk0
	0j0cd2ax6OBu1Rd+naF2ij13fA1ZhN+VbKoIh8VIQhIRaSQxt3GYj2KWV5TVsmebFf9xXCmDQks
	z9B0c+qpvuSYNoT12RRS9QrxvZ5Kdb/bFmmPfKzIf1epSDulL1qEvF6hYsvEsxBwW
X-Received: by 2002:a05:7300:fa15:b0:35b:9851:a896 with SMTP id 5a478bee46e88-35b9851ab64mr1197254eec.10.1791811595645;
        Mon, 12 Oct 2026 06:26:35 -0700 (PDT)
Received: from FT6N242TWK ([223.181.117.66])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca1b53dsm31467174eec.6.2026.10.12.06.26.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 12 Oct 2026 06:26:35 -0700 (PDT)
From: Shashank Mohan Jain <jain.sm@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 2/2] selftests/net/packetdrill: cover SO_RCVBUF vs the route window clamp
Date: Mon, 12 Oct 2026 18:56:22 +0530
Message-ID: <20261012132622.48550-3-jain.sm@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261012132622.48550-1-jain.sm@gmail.com>
References: <20261012132622.48550-1-jain.sm@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add packetdrill tests for the interaction between SO_RCVBUF, a user
TCP_WINDOW_CLAMP and the route "window" metric (RTAX_WINDOW) on the SYN:

 - tcp_rcvbuf_before_connect_window.pkt: SO_RCVBUF set before connect()
   must not defeat the route metric; the SYN must advertise the
   route-clamped window and window scale 0.

 - tcp_window_clamp_vs_rcvbuf.pkt: a clamp set with TCP_WINDOW_CLAMP must
   be honoured on the SYN and not be overwritten by a later SO_RCVBUF on
   the still unconnected socket.

 - tcp_fastopen_connect_rcvbuf_window.pkt: with TCP_FASTOPEN_CONNECT the
   SYN is deferred to the first write() while the socket sits in
   TCP_SYN_SENT; SO_RCVBUF applied in that gap must not defeat the route
   metric on the deferred SYN either.

Without the first patch of this series the SYN carried win 65535,
wscale 5 in the first and third cases (the route metric was skipped) and
the SO_RCVBUF-derived window in the second (the user clamp was lost).

The tests are picked up automatically by the packetdrill selftest
Makefile (TEST_PROGS := $(wildcard *.pkt)).

Assisted-by: LLM
Signed-off-by: Shashank Mohan Jain <jain.sm@gmail.com>
---
 .../tcp_fastopen_connect_rcvbuf_window.pkt    | 22 +++++++++++++++
 .../tcp_rcvbuf_before_connect_window.pkt      | 27 +++++++++++++++++++
 .../tcp_window_clamp_vs_rcvbuf.pkt            | 24 +++++++++++++++++
 3 files changed, 73 insertions(+)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_connect_rcvbuf_window.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_rcvbuf_before_connect_window.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_window_clamp_vs_rcvbuf.pkt

diff --git a/tools/testing/selftests/net/packetdrill/tcp_fastopen_connect_rcvbuf_window.pkt b/tools/testing/selftests/net/packetdrill/tcp_fastopen_connect_rcvbuf_window.pkt
new file mode 100644
index 000000000..7892ac566
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_fastopen_connect_rcvbuf_window.pkt
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+// TCP_FASTOPEN_CONNECT defers the SYN until the first write(); between
+// connect() and that write the socket is in TCP_SYN_SENT. SO_RCVBUF applied
+// in that gap must not defeat the route "window" metric on the deferred SYN.
+// optname 30 = TCP_FASTOPEN_CONNECT, 34 = TCP_FASTOPEN_NO_COOKIE on SOL_TCP.
+--ip_version=ipv4
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_fastopen=5
+ip route replace 192.0.2.1 via 192.168.0.1 dev tun0 window 4096`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_TCP, 30, [1], 4) = 0
+   +0 setsockopt(3, SOL_TCP, 34, [1], 4) = 0
+   +0 connect(3, ..., ...) = 0
+   +0 setsockopt(3, SOL_SOCKET, SO_RCVBUF, [1048576], 4) = 0
+   +0 fcntl(3, F_SETFL, O_RDWR|O_NONBLOCK) = 0
+   +0 write(3, ..., 1) = 1
+
+// The deferred SYN (carrying 1 byte of data) must advertise the route
+// clamped window and window scale 0 (not win 65535, wscale 5).
+   +0 > S 0:1(1) win 2920 <mss 1460,sackOK,TS val 0 ecr 0,nop,wscale 0>
diff --git a/tools/testing/selftests/net/packetdrill/tcp_rcvbuf_before_connect_window.pkt b/tools/testing/selftests/net/packetdrill/tcp_rcvbuf_before_connect_window.pkt
new file mode 100644
index 000000000..7ec7f14d8
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_rcvbuf_before_connect_window.pkt
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0
+// Setting SO_RCVBUF before connect() must not defeat the route "window"
+// metric on the SYN.
+//
+// The route to the peer carries "window 4096" (RTAX_WINDOW). With SO_RCVBUF
+// also set before connect(), the SYN the kernel sends must still advertise
+// the small, route-clamped receive window and a window scale of 0 (the
+// window scale option is sent, with a shift of 0).
+//
+// Since commit b025461303d8 ("tcp: update window_clamp when SO_RCVBUF is
+// set"), setsockopt(SO_RCVBUF) wrote tp->window_clamp while the socket was
+// still in TCP_CLOSE. tcp_connect_init() then treated that as a user clamp
+// and skipped RTAX_WINDOW, so the SYN carried win 65535, wscale 5 instead.
+--ip_version=ipv4
+
+`./defaults.sh
+ip route replace 192.0.2.1 via 192.168.0.1 dev tun0 window 4096`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_RCVBUF, [1048576], 4) = 0
+   +0 fcntl(3, F_SETFL, O_RDWR|O_NONBLOCK) = 0
+   +0 connect(3, ..., ...) = -1 EINPROGRESS (Operation now in progress)
+
+// The SYN must advertise the route-clamped window and window scale 0.
+   +0 > S 0:0(0) win 2920 <mss 1460,sackOK,TS val 0 ecr 0,nop,wscale 0>
+  +.1 < S. 0:0(0) ack 1 win 65535 <mss 1460,nop,wscale 7>
+   +0 > . 1:1(0) ack 1
diff --git a/tools/testing/selftests/net/packetdrill/tcp_window_clamp_vs_rcvbuf.pkt b/tools/testing/selftests/net/packetdrill/tcp_window_clamp_vs_rcvbuf.pkt
new file mode 100644
index 000000000..3d73178df
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_window_clamp_vs_rcvbuf.pkt
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+// A window clamp the user set with setsockopt(TCP_WINDOW_CLAMP) must be
+// honoured on the SYN even when SO_RCVBUF is set afterwards on the still
+// unconnected socket: SO_RCVBUF must not overwrite the user's clamp, and
+// the route "window" metric must not replace it either.
+//
+// TCP_WINDOW_CLAMP is optname 10 on SOL_TCP (this packetdrill build has no
+// symbol for it).
+--ip_version=ipv4
+
+`./defaults.sh
+ip route replace 192.0.2.1 via 192.168.0.1 dev tun0 window 4096`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_TCP, 10, [16384], 4) = 0
+   +0 setsockopt(3, SOL_SOCKET, SO_RCVBUF, [1048576], 4) = 0
+   +0 fcntl(3, F_SETFL, O_RDWR|O_NONBLOCK) = 0
+   +0 connect(3, ..., ...) = -1 EINPROGRESS (Operation now in progress)
+
+// The SYN advertises the user's clamp (win 16060), not the route window
+// (2920) and not the SO_RCVBUF-derived full window.
+   +0 > S 0:0(0) win 16060 <mss 1460,sackOK,TS val 0 ecr 0,nop,wscale 0>
+  +.1 < S. 0:0(0) ack 1 win 65535 <mss 1460,nop,wscale 7>
+   +0 > . 1:1(0) ack 1
-- 
2.43.0

