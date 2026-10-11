Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C3C18FDBD
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 11:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791717380; cv=none; b=KG+lDp+JYGdTZIQyyxTR/PoJnB0Y6/v+5orQAuHyS7ZpM98MtafwrLtBD8p6RpX48QOWP4FZC0KHV0TZQ54Zdn6pY+no5bR/CxLSTXlRUk/VfIUgxtIDIbgS7AhPgIG9yh0i+yWKy/s+v+6ZzH4rCV2SmHWOQjjtPReAlFnHMD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791717380; c=relaxed/simple;
	bh=DQ/SG04pszEXSKc+kyCTR1r1NMo5Z2WRrQL8XMOvda0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AfETCTSEAtrXRiFEnzYPqm+0tVLRYaxjBpZN6knLwzD4BN7VI3JobClSvjnTupUOpHs4kfbzlM8mJ/3/ULQbfTs0kNiRVA9uo2q4wr/ir8TNdwl4G+DNe7wq98gQoDdrq4ZW4hdn4Uir8pHdwTQpZy12H/3IfdVARwbAzpOaH4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fzjMWtZw; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fzjMWtZw"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-141395927feso1858323c88.0
        for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 04:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791717378; x=1792322178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p9SpcM59IzLOV+spVed4savqACSRmY6kdSkYZetDq6o=;
        b=fzjMWtZwrz4JuIQQDxaWtNUPuBsRSU5nE7SqgQilolTh7iiuLL6YDrwMJ2XK01Bb+x
         Em9xLMPUJ+omHP1KYPSOdJeVSv3cpx6gEYVUOWv8dMA0C4V5BcSy911gAp3AR9t2SNZW
         OiBIemBwdNPtFDNH/TqvgAElOK4AiD/zo5Ds9SMmllmp5r3S2CSU+/37gYdR1v/Ko7H6
         9xWyQrE0V0tVBvuE5q9126Nh7aCZkeG2aJebm3JnKG4/7ncq016JAWLJbIEPgRgYgcAg
         33xs6OAICblikNQ9i2+fW6PnLAmkF81ZnlRhyXinifIs6ZYRVauciLo+wihIbnQNPNQ/
         pzhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791717378; x=1792322178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=p9SpcM59IzLOV+spVed4savqACSRmY6kdSkYZetDq6o=;
        b=bsYLz3pujV5MDah91KpiInZDtFBP8LNS7qrbWjuPNlVQ/MXMpDpxlfYoBrtn8GahOe
         FpXy9g+jF6si+TabVd3kWcJSTPVGNhf3kjoFKlFoYIMmDEaS6gAxQa7XVNd52lRb20DF
         ZHugfC8A25IA9XjkwFCs9+sYrvThfLEdH8zyGfYpK3SYWEVC8m6RKOMLQZV8oUG8sbs2
         qihQsJw1oWlyvH474bhsQDlzSk5lEg/1Uda6Co+CW954BukUE56Y2glleZFWvSdMWEBU
         YmWBQ4Gz/hb7FEzntCBPtJ0g29Z8bbM4fmhR8SIGhE607SDgUx/pRa3lFTR07+8nQFDg
         JVAg==
X-Forwarded-Encrypted: i=1; AKwUvBwAXLGcFQifVQppctXWJDO62wA0bMqkf6CVq5K5D5L1GrFVPErs25DpzFyTVIrANJHJPkMnvpk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKZfUzQp2fvRMSuAoM8LeZA1DocQqUtzD/QllhvMvJR5DvUe6pr
	Mw5dSegklvpMJoixRfvswyRO2Sm2YlJOhqWEdEJzUjsZt5wo8MyOqpnl
X-Gm-Gg: AYBFou3/u9/0khX2z72GJpq9QEobR9nSwNArXT8NYACej30qC70pJIMg9BC0NqXCQYO
	yiwJC8AH71abhgYSS3davIj1FfJUdtINE+hhfa0rj3lArrQTGp0bO3vQbibBw8B+cLMM6d4UVuo
	iF/80loLqSoAaaM7tUnqKKev7hlieE7/+I60GHhfvTxfDyka5jrNii/DYNEPGmUIwQf8kxM7Lau
	DXVn/XkeVvXGKtwYqwdc+GrQVofeFGmq6S8/Oqd0R0Qr+ESFZ++fpV/0cfJ/J1cGIxleswZzeQy
	PK7ylqDTkbYCDsaSVb2XmNgJ0MRc7VOzh2zV3MdAuYIb7Z6QV90xdt/NfJjwpHXkm48UdBWSkCX
	6FbhEJoUus8Oi0PVCegeztJkL0EG6ZILRftpPJFj3AD40EjstLztTvHbiBLTv1j+Svk1GEVJbQs
	R4XwVOQ8gh0rQL4GfSu7hHO85P/CqIRxUKHzbBAZlt4arAD5s7TRCi4sHopuSK2BpDiwvJSNgup
	ig+ca1e0hqb0Zz7DF2UrJdfuxvFBn5R/09l6+UEtuwWi4HzAzh2dM4NSm45I0qx656dSccrN4od
	xRtRL2jf77vhecqwxyOgoW44166GoXYVDxSMpE22DQdB4jdRLMtAC0Du4rZwZcZR23JbY6NMp3o
	w9opZcgd6kYUwM8U7PWJ0k7byB/DX25jqCsqgJCnCF0smg3IQYinnmFa03UHdSUVX7Q==
X-Received: by 2002:a05:7022:7f0b:b0:13e:5b2a:e65c with SMTP id a92af1059eb24-16a57b13034mr9904493c88.3.1791717377469;
        Sun, 11 Oct 2026 04:16:17 -0700 (PDT)
Received: from FT6N242TWK ([223.181.119.248])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a6021e49sm20851347c88.20.2026.10.11.04.16.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 11 Oct 2026 04:16:17 -0700 (PDT)
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
Subject: [PATCH net-next 1/2] tcp: don't set window_clamp from SO_RCVBUF before the socket is connected
Date: Sun, 11 Oct 2026 16:46:05 +0530
Message-ID: <20261011111606.14753-2-jain.sm@gmail.com>
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

Since commit b025461303d8 ("tcp: update window_clamp when SO_RCVBUF is
set"), setsockopt(SO_RCVBUF) stores tp->window_clamp in every socket
state, including TCP_CLOSE and TCP_LISTEN.

tcp_connect_init() and tcp_openreq_init_rwin() treat a non-zero
window_clamp as a user clamp and, in that case, skip the route window
metric (RTAX_WINDOW, "ip route ... window N"). A clamp left behind by an
SO_RCVBUF call made before connect(), or on a listener, therefore
changes the window and window scale advertised in the SYN and SYN-ACK:
the route metric is no longer applied, and even without a route metric
the advertised window and scale come from SO_RCVBUF instead of the
defaults. This affects any application that sets SO_RCVBUF before
connect() or listen(), which is more common than using the route metric.

Example: two netns joined by a veth pair, "ip route ... window 4096" on
both sides, SO_RCVBUF set to 1 MiB before connect():

  before:  SYN win 65535, wscale 5
  after:   SYN win 2920,  wscale 0

wscale 0 means the window scale option is still sent, with a shift of 0.
The "after" values match a kernel with b025461303d8 reverted; with no
route metric the SYN window and scale are the defaults in both cases.

This only concerns the handshake. Since commit a2cbb1603943 ("tcp:
Update window clamping condition") tcp_measure_rcv_mss() recomputes
window_clamp from sk_rcvbuf once the scaling ratio changes, so
TCP_WINDOW_CLAMP does not persist past the first data segments, with or
without this patch.

Only update window_clamp from SO_RCVBUF once the socket is being set up:
skip it in TCP_CLOSE and TCP_LISTEN. When the connection is established
with SOCK_RCVBUF_LOCK set, both functions already clamp window_clamp to
tcp_full_space() (the value tcp_set_rcvbuf() computes), so nothing is
lost.

Fixes: b025461303d8 ("tcp: update window_clamp when SO_RCVBUF is set")
Assisted-by: LLM
Signed-off-by: Shashank Mohan Jain <jain.sm@gmail.com>
---
 net/ipv4/tcp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index f4c9101e5..e523cb71b 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1858,6 +1858,14 @@ int tcp_set_rcvlowat(struct sock *sk, int val)
 
 void tcp_set_rcvbuf(struct sock *sk, int val)
 {
+	/* Without a connection there is no clamp to update: it is chosen
+	 * from the route's window metric and the buffer size when the
+	 * connection is set up, see tcp_connect_init() and
+	 * tcp_openreq_init_rwin().
+	 */
+	if ((1 << sk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN))
+		return;
+
 	tcp_set_window_clamp(sk, tcp_win_from_space(sk, val));
 }
 
-- 
2.43.0

