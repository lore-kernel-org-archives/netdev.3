Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792598246;
	b=CHgWOSbt1T4o+OsCJDBmcWjTkRyB8+SHE8hCpqlALKQ2Pq7uTuLRfcz97eo7XBMKje3a
	 sSPW0rFghkoSqIj6v8xbdArjvRLFZ1h3r8QqnPMe+Kdbxs2oR3NRyBerIMa8L9m1PvlaV
	 394xcIF7QjH0wLm13TKJyQ+pKDC0wuNvfXLiHXyO5w2tS8GAS6Kbm8IOE8z7NA19nRo2t
	 kYgyjkr4grEO70QA1yl68mYkUjMkeYHy2p4YYh0d/qb7bpUqcg9zGa1aMxJR1Sh1hHHVH
	 +OUpuiX1lcCb+Uv8P/uiUr00H2TwCwMmS+YdZnbsLkg6RLCPLC0CfujDxTJYjOq8Dgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792598246;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=i6W19OzQKzl7pvXr09UHlRrpe6xOQhKwIzFdS+ZLsQM=;
	b=TGU4BTcI4mFGAtr0RAMDMawRbfHRFAfSfAmd9gD/cZn6YxhI3HG/d8p62seIOyHO83Lk
	 uJoK1kC5yH0ypJpcpRojoC6Iny9WboEU+EMrhFwgNPA5ChoY1BrDhrIjtv9Oj1iWSN0MS
	 Fxn604tr9YHfZM+j3DLBdmrSco9TPo9n2qtWxsTZM4qHkO54a4Bm/mi+uu/qnm0iH/PMW
	 vraCg+9SnRc0jRv0Wn1LfRCwzHr7u3tJL/ENtgCuQVEgoen9hJtwkOuranrH98K1GpNK1
	 CLiZD/V6BVcV44wC6OrRUb1EbyL0TosoPELWYs6TJtrKlY4lBDJ6cZF23fudPwf+ciw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nEnWnsxT;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88392606A33F
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 15:57:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88392606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nEnWnsxT
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-35cd4e8bdbdso1691857eec.1
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 08:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792598246; x=1793203046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i6W19OzQKzl7pvXr09UHlRrpe6xOQhKwIzFdS+ZLsQM=;
        b=nEnWnsxT9H/zCU6Obeze1YA17xVl8EH6yglFNidl4SKonPlLdriAfXAKAbne1ks5Qn
         G+G6haD4lsLTRDAQf7N/B6+nUwH39zLky/53yQj2hXr4Dn3fjKhutVwcNl8e/zuaJ7nL
         Sbld5DukFdcEJ2b5cws7s9Y//tVBa4hnNpMhFapfVhQFl8FzwvVlZ8JGmo5BCPWRLMXP
         RugrzrvMxOL3EKw60oFzvXwAtiaEpgXZ/N64W3ekm++gmWktkcrdJliXmRHPJKUdBENP
         as84Jq8LwDUK9zcoCeyUMgpZiiRKnRYF5IlM4zDxQUgpYACR3Tav+68F2zQVynU5B18z
         rhig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792598246; x=1793203046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=i6W19OzQKzl7pvXr09UHlRrpe6xOQhKwIzFdS+ZLsQM=;
        b=fA5dFAbfrOYK0WhXdZr8I6Ii/xgxR8N6pSy0hOvhfF9fRMaL6qMmBTN13IXzR6L8/h
         h6u6D74xO8o199xDstKWgC4SjNLXKhL0bcCPqSHgdsSvVSxJNEwDdtus3xS3WnawA178
         PLu3FH441zBUxcA8XHjbxODo/ow+eBdwJ6KBfshlya3qrqiSn5P3pSMC1cdMs1tJENdE
         A2saFyEdI1MMc21BDYvdAaAhN7C19xeIgr/nTnGE2Wm7GWk/LBWwOfZQRz93GJV9Z/AR
         utcIA3uD+pqgMHrYM7iFyxRfH7j3fho8bezvata55kIlTqT17DULuWag/TsOZtQ+5BvQ
         J5QQ==
X-Forwarded-Encrypted: i=1; AKwUvBys7LdJzqGUzuIwzHPiG8rf/IzfPaNP+s5n8SkYFV9cN5CvhsH/wsoNREG++No1rvU/BdqPtdc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLr17hhWYGbDICKMPS4C6BAFt6yhJAiioE6uE80urAsmLTsCcry
	beyVVz2REHeQJ0Ilr8w/Of0BbTDCr1t16Lre1Fx363vQQoMBxYfKcht3
X-Gm-Gg: AYBFou0KF5Lvv8JNnq33jaRJ80SC4T3QB8VDT1ZCf34ZluhvOIh6pRo3ezfITXmmXsI
	k88qtkNQwneEHzyQXpHHCqIoLSECX6aQiq3nv6uSf88gmOUbTQfuuuj/+Gz2lRa2XYNZNa9CB3G
	66NlgKXOsSCu/nS5Kr/zsLxf4fNJdDWp0ieGgVcLY0WrD4ARcRAsJyJ/9BM0n9xgVI7Gw31HE+O
	sr9rD3J0NvxZRVhDKBkFidFC4qGoSk0QGcvAU1lUuBNqNmtD7uuzKwMPNgtvHXcTgD5EpuUsIv1
	ER3YZxbs/o0zeoa7i3/xSuwG6r3nvhragPBylNTe5aCd4/g/+itolRosn+CowDTxShr+r1tcVYe
	rs0t6XAmHX8f2HbNAWwOx7rilaTUslJa2nyaN47wfV+yKbCZQu9OD/Btx+X0QYyWnr/KW/ODfV/
	t3s5WZWvaMXhQjqBpWf6TeXtjC66x3k9rQ4LJz51EENyTSq/LSIDEL3Pe3+Rq77KbCqYhAxroKU
	ZIMem2F68dlm2X9DXpm4tFtmaTeHUQ48hvKMrL+NoApox1lTZjt9PSz27pjuAbUJdzsLgEARPIc
	HiPUrU87ZUlRGKxtHVYPjaW1jQQeqSyFOABDp1Kqq9uogqRSYFWG/eBA6NNUyDSfyEqG6lFSEEb
	pU3z6wBPVWv1OqAIVW3s91WXhIK0ICojlxduayaoR6zm31fyw7yrifxikDjBtm7os2hR0pYTOza
	08OAJxTteGeG8nKVT6T6opnfTh4efhP9NWEavgphwGcSmupJ9W+1/fRLfx
X-Received: by 2002:a05:7300:e9cf:10b0:365:b147:b458 with SMTP id 5a478bee46e88-3674b52acb8mr4085763eec.3.1792598245394;
        Wed, 21 Oct 2026 08:57:25 -0700 (PDT)
Received: from FT6N242TWK ([223.181.118.44])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3674198f1d8sm12350080eec.24.2026.10.21.08.57.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 08:57:24 -0700 (PDT)
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
Subject: [PATCH net-next v4 1/2] tcp: keep the route window metric when SO_RCVBUF is set before connect
Date: Wed, 21 Oct 2026 21:27:14 +0530
Message-ID: <20261021155715.30094-2-jain.sm@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261021155715.30094-1-jain.sm@gmail.com>
References: <20261021155715.30094-1-jain.sm@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit b025461303d8 ("tcp: update window_clamp when SO_RCVBUF is
set"), setsockopt(SO_RCVBUF) writes tp->window_clamp in every socket
state through tcp_set_window_clamp().

tcp_connect_init(), tcp_openreq_init_rwin() and the SYN cookie paths
(cookie_v4_check(), cookie_v6_check()) treat any non-zero window_clamp
as a clamp the user asked for and, in that case, skip the route window
metric (RTAX_WINDOW, "ip route ... window N"). A clamp left behind by an
SO_RCVBUF call therefore has two observable effects:

 (1) on a route that carries an RTAX_WINDOW metric, SO_RCVBUF set before
     connect() (or on a listener) changes the window and window scale
     advertised in the SYN / SYN-ACK, because the route metric is no
     longer applied;

 (2) a window clamp the application set with setsockopt(TCP_WINDOW_CLAMP)
     is overwritten by a later SO_RCVBUF on the still unconnected socket
     or on a listener.

Without an RTAX_WINDOW metric and without TCP_WINDOW_CLAMP nothing
changes: before and after this patch the advertised window and scale
are derived from sk_rcvbuf (tcp_full_space()).

Keying the decision off the socket state is not enough, because the
socket is already in TCP_SYN_SENT before tcp_connect_init() runs.
SO_RCVBUF applied in that gap - through TCP_FASTOPEN_CONNECT before the
first write(), or through bpf_setsockopt() in a
BPF_SOCK_OPS_TCP_CONNECT_CB program - still lands before
tcp_connect_init().

Record instead the clamp the user set with TCP_WINDOW_CLAMP, in a new
tp->window_clamp_user field (0 when there is none; TCP_WINDOW_CLAMP=0
and tcp_disconnect() reset it), and use it as follows:

 - tcp_connect_init() applies the route metric whenever there is no
   user clamp, in any socket state.

 - tcp_openreq_init_rwin(), cookie_v4_check() and cookie_v6_check() all
   pick the request's clamp with the same new helper,
   tcp_req_window_clamp(): the listener's window_clamp if the user set
   one, else the route metric. The SYN-ACK and the SYN cookie path must
   agree, or the child of a cookie would use a different receive window
   scale than the one advertised in the SYN-ACK. The listener is not
   locked on these paths, so the field is written with WRITE_ONCE() and
   read with READ_ONCE().

 - tcp_set_rcvbuf() keeps updating window_clamp from the buffer size,
   but caps it at the user's clamp. SO_RCVBUF on an established socket
   thus still grows window_clamp, which is what the commit above was
   for, also after tcp_init_buffer_space() lowered it below the user's
   clamp, but no longer above a clamp set with TCP_WINDOW_CLAMP.

A value is stored, not a flag, so that SO_RCVBUF can raise window_clamp
back up to the user's clamp. The new u32 sits in the cold part of
struct tcp_sock; on x86_64 the size of struct tcp_sock (2432 bytes, with
and without MPTCP) and the fast path cacheline groups do not change.

Example: two netns joined by a veth pair, "ip route ... window 4096" on
the routes between them, SO_RCVBUF set to 1 MiB:

  before:  SYN win 65535, wscale 5      (SO_RCVBUF before connect())
           SYN-ACK win 65535, wscale 5  (SO_RCVBUF on the listener)
  after:   SYN win 2920, wscale 0
           SYN-ACK win 2896, wscale 0

(the window scale option is still sent, with a shift of 0.)

The problem was found by code inspection, assisted by an LLM (Claude
Code, Claude Opus 5.5), while reviewing the commit above. It was
confirmed with a reproducer in a qemu guest (two netns joined by a veth
pair, "ip route ... window 4096", tcpdump of the SYN and SYN-ACK, and
TCP_INFO of both ends, including a SYN cookie case), and with the
packetdrill tests added by the next patch, which fail without this
patch and pass with it.

Fixes: b025461303d8 ("tcp: update window_clamp when SO_RCVBUF is set")
Assisted-by: LLM
Signed-off-by: Shashank Mohan Jain <jain.sm@gmail.com>
---
v4:
 - also convert cookie_v4_check() and cookie_v6_check(); the SYN-ACK and
   cookie paths now share tcp_req_window_clamp()
 - store the user's clamp (u32 window_clamp_user, READ_ONCE/WRITE_ONCE)
   instead of a bit, and let SO_RCVBUF raise window_clamp up to it
 - add the field to net_cachelines/tcp_sock.rst
 - say in the changelog how the bug was found and tested

 .../networking/net_cachelines/tcp_sock.rst         |  1 +
 include/linux/tcp.h                                |  1 +
 include/net/tcp.h                                  | 14 ++++++++++++++
 net/ipv4/syncookies.c                              |  3 +--
 net/ipv4/tcp.c                                     | 14 +++++++++++++-
 net/ipv4/tcp_minisocks.c                           |  4 +---
 net/ipv4/tcp_output.c                              |  2 +-
 net/ipv6/syncookies.c                              |  2 +-
 8 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/Documentation/networking/net_cachelines/tcp_sock.rst b/Documentation/networking/net_cachelines/tcp_sock.rst
index 103328dc409..f317c7154d2 100644
--- a/Documentation/networking/net_cachelines/tcp_sock.rst
+++ b/Documentation/networking/net_cachelines/tcp_sock.rst
@@ -152,6 +152,7 @@ u32                           urg_seq
 unsigned_int                  keepalive_time
 unsigned_int                  keepalive_intvl
 int                           linger2
+u32                           window_clamp_user
 u8                            bpf_sock_ops_cb_flags
 u8:1                          bpf_chg_cc_inprogress
 u16                           timeout_rehash
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index e4d1720f49f..4f28fa6c4f4 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -474,6 +474,7 @@ struct tcp_sock {
 	unsigned int		keepalive_intvl;  /* time interval between keep alive probes */
 
 	int			linger2;
+	u32	window_clamp_user; /* TCP_WINDOW_CLAMP set by the user, 0 if none */
 
 
 /* Sock_ops bpf program related variables */
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 0265c27a5fd..35b64fffd74 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1879,6 +1879,20 @@ extern void tcp_openreq_init_rwin(struct request_sock *req,
 				  const struct sock *sk_listener,
 				  const struct dst_entry *dst);
 
+/* Window clamp for a request socket of listener @tp: the listener's clamp
+ * if the user set one with TCP_WINDOW_CLAMP, else the route window metric.
+ * The SYN-ACK and the SYN cookie paths must make the same choice, or the
+ * child's window scale would not match the one sent in the SYN-ACK.
+ * The listener is not locked here.
+ */
+static inline u32 tcp_req_window_clamp(const struct tcp_sock *tp,
+				       const struct dst_entry *dst)
+{
+	if (READ_ONCE(tp->window_clamp_user))
+		return READ_ONCE(tp->window_clamp);
+	return dst_metric(dst, RTAX_WINDOW);
+}
+
 void tcp_enter_memory_pressure(struct sock *sk);
 void tcp_leave_memory_pressure(struct sock *sk);
 
diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index 73e12976818..6e78efbdc31 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -472,8 +472,7 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 	}
 
 	/* Try to redo what tcp_v4_send_synack did. */
-	req->rsk_window_clamp = READ_ONCE(tp->window_clamp) ? :
-				dst_metric(&rt->dst, RTAX_WINDOW);
+	req->rsk_window_clamp = tcp_req_window_clamp(tp, &rt->dst);
 	/* limit the window selection if the user enforce a smaller rx buffer */
 	full_space = tcp_full_space(sk);
 	if (sk->sk_userlocks & SOCK_RCVBUF_LOCK &&
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 99d7237a623..64465bc257d 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1859,7 +1859,15 @@ int tcp_set_rcvlowat(struct sock *sk, int val)
 
 void tcp_set_rcvbuf(struct sock *sk, int val)
 {
-	tcp_set_window_clamp(sk, tcp_win_from_space(sk, val));
+	u32 user_clamp = tcp_sk(sk)->window_clamp_user;
+	int win = tcp_win_from_space(sk, val);
+
+	/* window_clamp follows the receive buffer, but never goes above a
+	 * clamp the user set with TCP_WINDOW_CLAMP.
+	 */
+	if (user_clamp)
+		win = min_t(u32, win, user_clamp);
+	tcp_set_window_clamp(sk, win);
 }
 
 #ifdef CONFIG_MMU
@@ -3429,6 +3437,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 	tp->is_cwnd_limited = 0;
 	tp->max_packets_out = 0;
 	tp->window_clamp = 0;
+	WRITE_ONCE(tp->window_clamp_user, 0);
 	tp->delivered = 0;
 	tp->delivered_ce = 0;
 	tp->accecn_fail_mode = 0;
@@ -4058,6 +4067,9 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 
 	case TCP_WINDOW_CLAMP:
 		err = tcp_set_window_clamp(sk, val);
+		if (!err)
+			WRITE_ONCE(tp->window_clamp_user,
+				   val ? tp->window_clamp : 0);
 		break;
 
 	case TCP_QUICKACK:
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 0ddfd5af6e5..c17dc5c4648 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -435,15 +435,13 @@ void tcp_openreq_init_rwin(struct request_sock *req,
 	struct inet_request_sock *ireq = inet_rsk(req);
 	const struct tcp_sock *tp = tcp_sk(sk_listener);
 	int full_space = tcp_full_space(sk_listener);
-	u32 window_clamp;
 	__u8 rcv_wscale;
 	u32 rcv_wnd;
 	int mss;
 
 	mss = tcp_mss_clamp(tp, tcp_dst_advmss(dst));
-	window_clamp = READ_ONCE(tp->window_clamp);
 	/* Set this up on the first call only */
-	req->rsk_window_clamp = window_clamp ? : dst_metric(dst, RTAX_WINDOW);
+	req->rsk_window_clamp = tcp_req_window_clamp(tp, dst);
 
 	/* limit the window selection if the user enforce a smaller rx buffer */
 	if (sk_listener->sk_userlocks & SOCK_RCVBUF_LOCK &&
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index c8865205cdc..21b4ae303dd 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -4137,7 +4137,7 @@ static void tcp_connect_init(struct sock *sk)
 
 	tcp_ca_dst_init(sk, dst);
 
-	if (!tp->window_clamp)
+	if (!tp->window_clamp_user)
 		WRITE_ONCE(tp->window_clamp, dst_metric(dst, RTAX_WINDOW));
 	tp->advmss = tcp_mss_clamp(tp, tcp_dst_advmss(dst));
 
diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
index b581cb1ee2e..d7d61f8d25e 100644
--- a/net/ipv6/syncookies.c
+++ b/net/ipv6/syncookies.c
@@ -254,7 +254,7 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 		}
 	}
 
-	req->rsk_window_clamp = READ_ONCE(tp->window_clamp) ? :dst_metric(dst, RTAX_WINDOW);
+	req->rsk_window_clamp = tcp_req_window_clamp(tp, dst);
 	/* limit the window selection if the user enforce a smaller rx buffer */
 	full_space = tcp_full_space(sk);
 	if (sk->sk_userlocks & SOCK_RCVBUF_LOCK &&
-- 
2.43.0

