Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEF53603E8
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 13:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791811594; cv=none; b=hXp7jr/0tmvOi3xup0x2R3z0hOs72CLjeSBroYUdQ454QQPuwm27zdoaEZ+HImi7MUcIVpB57ROA8N3srjPo8nZXr8xlvKe55HCWMlDjejgq/BozWTgaS8b9xvbsTdBa2xP/hoTAEjqVGaiAHhG9tUtvWQa4MRWqZ5Zu7QjvfgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791811594; c=relaxed/simple;
	bh=i/GDUsxmHSizIfmBFVOVpm3wHYUjZCMNoXcEaQNQfag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bja6KCr+uXS/3JoOmCAp9oJ/hEsGfDIFwt2PqvgsFm2LV615alY4xLbAm9WV4bwQ5AqinpK0/1ER/gjHA986ZPxui6HZifcldpYJvRu1HCNHfJOit4RMEYay7BhohABn9sq15jL1wjf3emxN2s0iQrOwwqE8ySVPib/JEDfqOiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aF2msapz; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aF2msapz"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-35829219da8so1722534eec.0
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 06:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791811592; x=1792416392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4ybFQCLqWdvfa4L31u7XgkYJLc5DdT2g6eV0lE+udE4=;
        b=aF2msapzUHo29jmbbGG6ENxxdfjm2IBWU4C6Cp7CFnXgdsenEcn2V/5ANeaIfnGlga
         MC1paCltvBzwo4XUyr8IJ1T2cnL4vnIFz3QvAVBHhfJ88Ng9G6RPzO2YumLeyoakrO51
         YRZzTVEO+RkjqcoG10Njg3iE0hxKa86nVk1iPspTx0EO1eQdCnudF8i5ogAkKQmQH05P
         Tdpm9MEEM9cg/9pC0tOyq/V5BBw28ZGeWYspcUnfXitgXflqgz1KHv8+/v0FGBNkO9Li
         4FQ+HtgFzGD4P4dQdJ09MsPnSK+Gqq1MoTxWZpuqJu5dMWeL6aZhrIGf5/idWLbY/JKL
         TkBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791811592; x=1792416392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4ybFQCLqWdvfa4L31u7XgkYJLc5DdT2g6eV0lE+udE4=;
        b=F2I+zMuw4EYK9wwtLV2zFy3WvuF6wgeefpURcZFMj2GsuNxfDNcgnENt50etr4utvV
         SWPwQ5h8yW7VkI1Zep7LEgkDF6E8QrPxjpZkMrMcgCp4kTN+aJeaH5Wxe/J3DIH93XbG
         i2juJZ30aRJ1mw5PL1DE1DHaRRFjNeHe/kuRBeRU8uKigG+lDDfZLIXrpi8dQj/i5cwh
         LSxb/3wLccjSLWt245MI9UX6+A1I5M1jjkKip2tWMS7aXS/vti1S2m9NZKdO9aR/lWDJ
         5U5BLMOVMeo1P/sxsezuySKMD+JMqr5QkX+BxPastyxiS/BVS6O2qrxfUE2LFzt+Dijr
         Y+3g==
X-Forwarded-Encrypted: i=1; AKwUvByk/lrOfX5SqtkjC1oJDFLVfVrFlMCW3J62H74wmDMxE37KBknbfxqptwWGHniqLMkGE/dqeJE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKr4pS8Qt77LGfkVPPSsTAJYZaQsI3xsC2/uXYZ5z6FQRVJJjFQ
	2cygDq4LR8T1CtB8lclNx+2PJr1T0RZydM2TFhBCkywLVX9Kg9tCxa0/
X-Gm-Gg: AYBFou2icgx7tN8CJoYzcCQYi85cDCv8OvGL/s++AmdCqiydrE1J83WnlAZ9ZpLc46x
	/OtZA5T1PxSuSVwK7VhXP4Dy1SxL+Ekt7PaQM8WUSBXFo3qYi7ZfCtmmXaEvLx0/WK5+CDpswzb
	72CyBr9oPRruHpHJjpB9gNaLmcs3PMOGlpmPE1KFC1dZjXMHieSKYukd7JJy2VtAqPdDxo+mROF
	NoaYQ3a6QKYbnxlUaNYOAJFtBB9UsYObf+XpNueqsiKwj5cErGeJn9IKdZpS2bw9WBsWgAqHcg5
	fMW/c0Kl3trkbWstslZDTygdFBKWe/fsCYy74Dx06LzcEUiR6rGv9svIu7SuJ2lRnNYdeNm/j2z
	RJk5ZSBUJEBj90Ovfcnd59wEXaMtz6PKa3FxqEl/lHRahBDEQ542k2VdbVEWI6WZu0FGn5oJoL4
	hwT3IWW7p1rxvKuUcw2fMF7v4+zwU2q705hxgQRWpZfjB9VtNEnAdYlkkAHl+tT4oNYtcAB1eJ5
	gr/4U9EjtwFNwUiHkozEgMXTtSLIYCKU8ZiACOewpeyBwnv6JDfABuZsXxN1LFex4KfCYE5QrQy
	q6JvcSntKpRULEAN6bsPZi3yTtTl+C4o5UdCJRjLp2Tjs2q9OzXwtt3ZIJjBK3Ex3zapDBOMAIL
	iX0kWSbC4pfMkLgUT76LYqP6j7rK6/gpcLH3pi/+Reu5KhJQR/czCT7e5yiztcbHY
X-Received: by 2002:a05:7301:d198:b0:354:53af:7f2 with SMTP id 5a478bee46e88-35453af114bmr13178963eec.11.1791811591848;
        Mon, 12 Oct 2026 06:26:31 -0700 (PDT)
Received: from FT6N242TWK ([223.181.117.66])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca1b53dsm31467174eec.6.2026.10.12.06.26.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 12 Oct 2026 06:26:31 -0700 (PDT)
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
Subject: [PATCH net-next v3 1/2] tcp: keep the route window metric when SO_RCVBUF is set before connect
Date: Mon, 12 Oct 2026 18:56:21 +0530
Message-ID: <20261012132622.48550-2-jain.sm@gmail.com>
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

Since commit b025461303d8 ("tcp: update window_clamp when SO_RCVBUF is
set"), setsockopt(SO_RCVBUF) writes tp->window_clamp in every socket
state through tcp_set_window_clamp().

tcp_connect_init() and tcp_openreq_init_rwin() treat any non-zero
window_clamp as a clamp the user asked for and, in that case, skip the
route window metric (RTAX_WINDOW, "ip route ... window N"). A clamp left
behind by an SO_RCVBUF call therefore has two observable effects:

 (1) on a route that carries an RTAX_WINDOW metric, SO_RCVBUF set before
     connect() (or on a listener) changes the window and window scale
     advertised in the SYN / SYN-ACK, because the route metric is no
     longer applied;

 (2) a window clamp the application set with setsockopt(TCP_WINDOW_CLAMP)
     is overwritten by a later SO_RCVBUF on the still unconnected socket
     or on a listener.

Without an RTAX_WINDOW metric there is no change: both before and after
this patch the advertised window and scale are derived from sk_rcvbuf
(tcp_full_space()), so only (1) and (2) are affected.

Keying the decision off the socket state is not enough, because the
socket is already in TCP_SYN_SENT before tcp_connect_init() runs.
SO_RCVBUF applied in that gap - through TCP_FASTOPEN_CONNECT before the
first write(), or through bpf_setsockopt() in a
BPF_SOCK_OPS_TCP_CONNECT_CB program (as samples/bpf/tcp_clamp_kern.c and
friends do) - still lands before tcp_connect_init() and still overrides
the metric.

Record instead whether window_clamp was set explicitly by the user via
setsockopt(TCP_WINDOW_CLAMP), in a new tp->window_clamp_user bit, and key
tcp_connect_init() and tcp_openreq_init_rwin() off that bit rather than
off a non-zero window_clamp. The route metric is then applied on all
pre-connection paths, regardless of socket state, whenever the clamp was
not set by the user; a passive socket inherits the decision from its
listener. SO_RCVBUF no longer overwrites a genuine TCP_WINDOW_CLAMP
either. When SOCK_RCVBUF_LOCK is set both functions still clamp
window_clamp to tcp_full_space(), and without a user clamp SO_RCVBUF
keeps updating window_clamp, so SO_RCVBUF on an established socket still
grows the advertised window as b025461303d8 intended.

Example: two netns joined by a veth pair, "ip route ... window 4096" on
the route to the peer, SO_RCVBUF set to 1 MiB before connect():

  before:  SYN win 65535, wscale 5
  after:   SYN win 2920,  wscale 0

(the window scale option is still sent, with a shift of 0.)

Fixes: b025461303d8 ("tcp: update window_clamp when SO_RCVBUF is set")
Assisted-by: LLM
Signed-off-by: Shashank Mohan Jain <jain.sm@gmail.com>
---
 include/linux/tcp.h      |  3 ++-
 net/ipv4/tcp.c           | 12 ++++++++++++
 net/ipv4/tcp_minisocks.c |  7 +++++--
 net/ipv4/tcp_output.c    |  2 +-
 4 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index e4d1720f4..2324841e5 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -301,7 +301,8 @@ struct tcp_sock {
  *	0x5?10 << 16 + snd_wnd in net byte order
  */
 	u8	nonagle     : 4,/* Disable Nagle algorithm?             */
-		rate_app_limited:1;  /* rate_{delivered,interval_us} limited? */
+		rate_app_limited:1,  /* rate_{delivered,interval_us} limited? */
+		window_clamp_user:1; /* TCP_WINDOW_CLAMP set by the user */
 	u8	received_ce_pending:4, /* Not yet transmit cnt of received_ce */
 		accecn_opt_sent_w_dsack:1,/* Sent ACCECN opt in previous ACK w/ D-SACK */
 		unused2:3;
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index f4c9101e5..5f364928b 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1858,6 +1858,15 @@ int tcp_set_rcvlowat(struct sock *sk, int val)
 
 void tcp_set_rcvbuf(struct sock *sk, int val)
 {
+	/* A window clamp set explicitly via setsockopt(TCP_WINDOW_CLAMP)
+	 * takes precedence: SO_RCVBUF must not overwrite it.  Without such
+	 * a user clamp, keep updating window_clamp from the buffer size so
+	 * that SO_RCVBUF on an established socket still grows the advertised
+	 * window (commit b025461303d8).
+	 */
+	if (tcp_sk(sk)->window_clamp_user)
+		return;
+
 	tcp_set_window_clamp(sk, tcp_win_from_space(sk, val));
 }
 
@@ -3427,6 +3436,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 	tp->is_cwnd_limited = 0;
 	tp->max_packets_out = 0;
 	tp->window_clamp = 0;
+	tp->window_clamp_user = 0;
 	tp->delivered = 0;
 	tp->delivered_ce = 0;
 	tp->accecn_fail_mode = 0;
@@ -4056,6 +4066,8 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 
 	case TCP_WINDOW_CLAMP:
 		err = tcp_set_window_clamp(sk, val);
+		if (!err)
+			tp->window_clamp_user = !!val;
 		break;
 
 	case TCP_QUICKACK:
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 0ddfd5af6..c24dc975a 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -442,8 +442,11 @@ void tcp_openreq_init_rwin(struct request_sock *req,
 
 	mss = tcp_mss_clamp(tp, tcp_dst_advmss(dst));
 	window_clamp = READ_ONCE(tp->window_clamp);
-	/* Set this up on the first call only */
-	req->rsk_window_clamp = window_clamp ? : dst_metric(dst, RTAX_WINDOW);
+	/* Set this up on the first call only.  Honour a window clamp the
+	 * listener set via TCP_WINDOW_CLAMP; otherwise use the route metric.
+	 */
+	req->rsk_window_clamp = tp->window_clamp_user ? window_clamp :
+				dst_metric(dst, RTAX_WINDOW);
 
 	/* limit the window selection if the user enforce a smaller rx buffer */
 	if (sk_listener->sk_userlocks & SOCK_RCVBUF_LOCK &&
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index c8865205c..21b4ae303 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -4137,7 +4137,7 @@ static void tcp_connect_init(struct sock *sk)
 
 	tcp_ca_dst_init(sk, dst);
 
-	if (!tp->window_clamp)
+	if (!tp->window_clamp_user)
 		WRITE_ONCE(tp->window_clamp, dst_metric(dst, RTAX_WINDOW));
 	tp->advmss = tcp_mss_clamp(tp, tcp_dst_advmss(dst));
 
-- 
2.43.0

