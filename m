Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849D53290A6
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 11:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791717386; cv=none; b=htN5BLAfUCMJBqx5TlWSyT74qrz+YEEdwh2O4oJB6sSpqmSyxEDCx0yxY3ex6xr++gTxp7m1G0aXLV/vyNL2Nzd/+6L4qm08JhB40+GjbOScNLLTyardCWt90J0nkStg1z1RJTkKik3uAEaDSzclgTCV0Lo+SeoIpZjYvqCpjsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791717386; c=relaxed/simple;
	bh=g9ET9/Wbeb9U9AgyJHKHgPcnysCUntixLAXYJ/HlT4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V7RNWE51VPlkBE8N/fVMVmPghY7WXZ5vBR8vl9XgYPp8a6nkbWtMyHXIyPaq+U1qJzQARQ7rQFrp1tC3gZ65XW+Tkg2OYCOOP0fS1xy4VsdHsSYbIvXz2XRPfbzbAPkpU5y5xc8krCW4jHcCXTQgQ4/m0DhqxaFfumOEQp7J8HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FcjNixYm; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FcjNixYm"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-356b1e20700so1376247eec.1
        for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 04:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791717382; x=1792322182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OmatCOb7GYfr2BJ3VdKdlsW8GJA/oiSGbFjGfYuhsqI=;
        b=FcjNixYmVQe5sVPyUZ21b1b0VHEL9/8ZCzGPcz5iTlz9J5btgyf0SfKHt6vcZaszSR
         GOK/35PvGlyT7mfo4qOnyhh0oltXmUFdUVtt283LircNEHLmqVa2gmrDYnqzSbf09Ruf
         gjued0EHaQ2qDwfj0C++z0IhWvd1LO2Is+Tya0H4pLsvloZL6aZPVuEfUCIcySzMLu3+
         cklVC4jvvxOjlhVwax8zuQ32/CRCo3U0uT/SPS6UVQUR+KoMB4gjq5Hz6p07s8dPQwC6
         wgYXwtTo78EqyGUV42aNoF55pW88/noip/ww3fArmQGZ/jCLkch5GIZkvqyYoBAINZ0s
         6p2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791717382; x=1792322182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OmatCOb7GYfr2BJ3VdKdlsW8GJA/oiSGbFjGfYuhsqI=;
        b=JF9VaMDf/BgIg2PZgpgFGEk41cDdLCq8QmYz8tYZiKREAtQd8omqVtaUfyZC+fGH6n
         p+Su55ofhFBl7O6959iZtLX8ZN+l/dlmViX0RKHxvGDig6zQ0g4uhL3iw6y2C00CJJBX
         vKlWsVKQswwtskj/KELrkz2Svh10KwXFpvaO2fuMGA+TjDuag9NIVLJSQX2bZarPamyt
         ac5Qbp9XUta79f0ipwfyk1gTYBFaFCyvAaPL52QXjjrcYSE1jZQ3HaqgWvtTYFpiAUxO
         SQATbB8Oe3Lk6YhLn3fmoIBGPXMmUfihDNXINlkVJYJF/eYXdcfge1OBUCGjRPP4+7Xk
         5z8w==
X-Forwarded-Encrypted: i=1; AKwUvBy0C1g7ual4l6yM3+vtnG72VO7kP3O+A+5f4v5qF0YeSLrBauAu5bT9QuliWZmWUlHbkBQlZU8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKDfGN4WnGer8xoUcrxNPkiFuXHwiu6wbmvFqbGML520s0CceDz
	dnl6wqlXdhHGpvjXWIsekWO6zDmmOh8XuYSr+zgwYvf1YxX3Y9cAagrx
X-Gm-Gg: AYBFou1EtJquN3liczxES1spV3vXmU/D5TcBleQSfseasYdiHcebglo7Gr7ywLFJtxb
	GZKpW95HZgPYPHqPdR//HNG6zKqSHmsgGFlFeoiPJc/OOP5WuvRr5irRJOb+ev27nr6zS/2xOeO
	Ud+nHGWJtCZFDm2l07M3kzcxgocya7evj/H7LgAJMhKl6RUEfLk0JnXRmhXU0TNXcHJDTwp5wyZ
	m60nWNv+rwptnCh8Cc3pn48DMfSxcDLkedbnPo/H701wKg5jrZrt+t06wlBvNU/VMsZgbzEGJLw
	xlVp2dksovmRL2R0CbCI9bTCePvuP1RKOqa5oQgWwePiDX0iGaawjxYgKft0TaclIOFwsy1k1yr
	4JRwMoXrzh9zv0tb3emeVKfhzzR++dAHhuX5j9rL6B5c7ytdwcBrhEQrwcVLXaFR4ajG2tdzRCd
	5VotVswXGHLrCO3najhYNXX6sc1Pl2Bu2p8UnuIAQBSVNwn2mWyv7nfUOh2zVn0amI6nCqTA/3Z
	Z+1TRctPkcHBsWNqaR8pWni0R1S5smrvoBWLMwkouTVtFxwAirhpjiCrr3lRjp3rizdLI+W/nfa
	+pGSo7RN60LRrBKVAHc64fmvvcxwmxaBJhsOd+hRL9v4g4qGBMIgA9SWY7GSvMMY71IiT4mAXIu
	Gh9Vl5oHJPbUWp1wpNmMATunQVKS4vQ6DINrAwpYwUVtZQyM21Rxj7meGlbqzfWfZPw==
X-Received: by 2002:a05:701b:205b:20b0:148:ece:8cc3 with SMTP id a92af1059eb24-16a1555cfb3mr8844066c88.24.1791717382312;
        Sun, 11 Oct 2026 04:16:22 -0700 (PDT)
Received: from FT6N242TWK ([223.181.119.248])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a6021e49sm20851347c88.20.2026.10.11.04.16.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 11 Oct 2026 04:16:21 -0700 (PDT)
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
Subject: [PATCH net-next 2/2] selftests/net/packetdrill: test SO_RCVBUF before connect keeps route window
Date: Sun, 11 Oct 2026 16:46:06 +0530
Message-ID: <20261011111606.14753-3-jain.sm@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261011111606.14753-1-jain.sm@gmail.com>
References: <20261011111606.14753-1-jain.sm@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a packetdrill test for the SYN window and window scale when
SO_RCVBUF is set before connect() and the route to the peer carries a
"window" metric (RTAX_WINDOW).

The test puts "window 4096" on the route to the peer, sets SO_RCVBUF,
connects, and checks that the SYN advertises the route-clamped window
and a window scale of 0. Without the first patch of this series the SYN
carried win 65535, wscale 5, because setsockopt(SO_RCVBUF) had written
tp->window_clamp while the socket was still in TCP_CLOSE and
tcp_connect_init() then skipped the route metric.

The test is picked up automatically by the packetdrill selftest Makefile
(TEST_PROGS := $(wildcard *.pkt)).

Assisted-by: LLM
Signed-off-by: Shashank Mohan Jain <jain.sm@gmail.com>
---
 .../tcp_rcvbuf_before_connect_window.pkt      | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_rcvbuf_before_connect_window.pkt

diff --git a/tools/testing/selftests/net/packetdrill/tcp_rcvbuf_before_connect_window.pkt b/tools/testing/selftests/net/packetdrill/tcp_rcvbuf_before_connect_window.pkt
new file mode 100644
index 000000000..a3557ce80
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
+ip route change 192.0.2.1 via 192.168.0.1 dev tun0 window 4096`
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
-- 
2.43.0

