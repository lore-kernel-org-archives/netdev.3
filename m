Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794095844;
	b=2qpIX07+Rti+usGlRgwBLDDUFQ6DCCYVCN2GGUzkRzGqs7l2AinleZFyZWN0Aic3EyP0
	 smtA9XopEeMJSiVTsXmkH7yj4wjsMTJUWp65e2QrnPeQoKIJTRvaLgP84TJPojS/MRsTC
	 3xuDJwfM9AvokoZ+CTg7aAnTbR3h8ttOXil7x6VmjgBxpK84dpMrmH8Kh33EmjiyRZKSt
	 i4i1dGDmfAAQtyg2RVmnSBAVaNwKAjLWFdcstmL3SMxL7031MaLNakEo9GPBK/ylz4OvE
	 fq0bwnWfnUXSH1Ps/U+k2Wi9FUsjDNdWpW/bVBNs0oap2BUYNZ7JGkerjsUc3sPkhaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794095844;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=7J5YSmCiP6Z+mqfEUJWJFVNdrkplV7YoqUU3wCbDYLw=;
	b=2dlQd80lMircPy/WM86SFbSlMAVmalI120LBYlmwV0U6yEXMF/vBP2e4mbMJAnkvbzgg
	 qXZVhOFZt/woAzeLPxWolrYAm1eeZMgr6BEaY4OGIQmOVfK8zC6Ph/sa4q4NOV8yQVBre
	 0kUh2n8NRtWu05f0pgim56RcsulEP5miqrkmc9lbkmU7nzDIDVSpwAJ39VQR3QBEwYHHr
	 0RtcTPUobRIsBBSSoxBAgKOevsDa/HWsa5io6eK6fb7gS5jqtwUthI3sJBEu2Yq8rQMlI
	 6iGdL/PR9n4VViA5G/nqzYtGT73L9m92StANDSLB7+Jc7lPwJufYdNHG5f77nNZ42lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=F9j57aSP;
	arc=none smtp.remote-ip=209.85.210.199
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1104D606A330
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 23:57:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1104D606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=F9j57aSP
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-89f84753b43so47403b3a.1
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 15:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794095843; x=1794700643; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7J5YSmCiP6Z+mqfEUJWJFVNdrkplV7YoqUU3wCbDYLw=;
        b=F9j57aSPehuv5upii7k9RA95wurlIW/jGPAPkXHkT2r5cm1NLXId2N0GcCxGTVTVID
         M1+wfSTmPStxYG1cPs1to3+oJpcK4Be7sOgzUkH5lEaASc+knC6jJPcS6XtCTxl301K/
         vgWvHnUCtSAHd5M4hFjlKaJT4hWrljnj/oMIL/ZJ55/k4YPnXfF/u83ZxeObCypS1VYI
         ugClFOMAKPSUUckU8PsO7i2CqlqxGWd1BdLxvxxhmaEymUQrt4Ish91YqKZ3UK/dvet/
         g2OX6ljvkzYPxg473abF65UpdREXxXOnvVfmDELMwxfu3/Dd4JJxDWkbNPpIHG7SR1S+
         K7Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794095843; x=1794700643;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7J5YSmCiP6Z+mqfEUJWJFVNdrkplV7YoqUU3wCbDYLw=;
        b=dKdItzlx7JhXU5mSrg0O0IJj7/8GQDhLCLlGRw54o3ih5KVFXcA1mTGH9+mASE9luT
         wT1eMWPFgMJmNmVPlvWYkX/EGuv8yKmidpWju547fdNwmkW0Y5zvPbNxC92bS3Ak3YgH
         NdbR85kNOXUgmXjSLNLi0mR6JJJaNpbguw536d385uBvSo3wyEmiuIGFtjoyMJ8Jh3FS
         btkwDABTH3/zxok2rSt1BDI11NstkeQPqvE18KlhOZUG0sxRDqosVFwPSUmmZRi0D4XS
         TWN0jjWLqVxSYL9YeRjZuQetwxuD7fSL2C+msWsd8YpdF42pBjbRhfvCMd2OPu+j99sL
         Tr5g==
X-Forwarded-Encrypted: i=1; AKwUvBwYi4mlee0Yhxw7M7Pf340sFDKcwUtIOsy4mSDsU3LKM7sUsETZop9dFN6cjx7isRajbHZdi2Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z83EX/AWIPcOw3SmVqPPUXOP8XW5ygrdaxFLwHqO8OHcynBdL15
	e0hkpQJeGqwDdJJcu3FuULRuIhtU8gmRFj4EhB7A822uek/IAOnMsdgFCH4Fqu0Z26maFFPYLwS
	tH7jMqA==
X-Received: from pghs10.prod.google.com ([2002:a63:e80a:0:b0:cc7:d071:a17f])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6b05:b0:3e2:e6c:7d4
 with SMTP id adf61e73a8af0-3eed3325865mr319519637.23.1794095842977; Sat, 07
 Nov 2026 15:57:22 -0800 (PST)
Date: Sat,  7 Nov 2026 23:56:08 +0000
In-Reply-To: <20261107235720.3129212-1-kuniyu@google.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261107235720.3129212-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261107235720.3129212-2-kuniyu@google.com>
Subject: [PATCH v1 net 1/3] tcp: Clear DEFER_CONNECT before tcp_connect() and
 in tcp_abort().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Yuchung Cheng <ycheng@google.com>, Wei Wang <weiwan@google.com>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When TFO is enabled, tcp_v[46]_connect() sets sk->sk_state to
TCP_SYN_SENT and puts the socket into ehash without calling
tcp_connect().

Then, tcp_fastopen_defer_connect() sets DEFER_CONNECT, and
the first write()/sendmsg() will call tcp_connect() and send
SYN with data if possible.

If tcp_abort() kills a socket before the first write()/sendmsg(),
the unhashed socket can still call it and send SYN in TCP_CLOSE.

Also, DEFER_CONNECT is cleared after __inet_stream_connect().

So, blocking write()/sendmsg() can release lock_sock() in
inet_wait_for_connect() while DEFER_CONNECT is set, and
tcp_poll() could set EPOLLOUT even after SYN is sent.

Let's clear DEFER_CONNECT in tcp_abort() and right before
tcp_connect() in tcp_sendmsg_fastopen().

Note that the last argument of __inet_stream_connect() is
changed from is_sendmsg to defer_connect as DEFER_CONNECT
is already cleared when __inet_stream_connect() is called.

This change is also needed for the next patch.

Fixes: 19f6d3f3c842 ("net/tcp-fastopen: Add new API support")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/inet_common.h |  2 +-
 net/ipv4/af_inet.c        | 10 ++++++----
 net/ipv4/tcp.c            |  9 +++++++--
 net/mptcp/protocol.c      |  5 +++--
 4 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/include/net/inet_common.h b/include/net/inet_common.h
index 3d747896be30..0f088a213c38 100644
--- a/include/net/inet_common.h
+++ b/include/net/inet_common.h
@@ -25,7 +25,7 @@ int inet_release(struct socket *sock);
 int inet_stream_connect(struct socket *sock, struct sockaddr_unsized *uaddr,
 			int addr_len, int flags);
 int __inet_stream_connect(struct socket *sock, struct sockaddr_unsized *uaddr,
-			  int addr_len, int flags, int is_sendmsg);
+			  int addr_len, int flags, bool defer_connect);
 int inet_dgram_connect(struct socket *sock, struct sockaddr_unsized *uaddr,
 		       int addr_len, int flags);
 int inet_accept(struct socket *sock, struct socket *newsock,
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 7677b0343abd..8822bae439f8 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -629,7 +629,7 @@ static long inet_wait_for_connect(struct sock *sk, long timeo, int writebias)
  *	TCP 'magic' in here.
  */
 int __inet_stream_connect(struct socket *sock, struct sockaddr_unsized *uaddr,
-			  int addr_len, int flags, int is_sendmsg)
+			  int addr_len, int flags, bool defer_connect)
 {
 	struct sock *sk = sock->sk;
 	int err;
@@ -664,8 +664,10 @@ int __inet_stream_connect(struct socket *sock, struct sockaddr_unsized *uaddr,
 		err = -EISCONN;
 		goto out;
 	case SS_CONNECTING:
-		if (inet_test_bit(DEFER_CONNECT, sk))
-			err = is_sendmsg ? -EINPROGRESS : -EISCONN;
+		if (defer_connect)
+			err = -EINPROGRESS;
+		else if (inet_test_bit(DEFER_CONNECT, sk))
+			err = -EISCONN;
 		else
 			err = -EALREADY;
 		/* Fall out of switch with err, set for this state */
@@ -752,7 +754,7 @@ int inet_stream_connect(struct socket *sock, struct sockaddr_unsized *uaddr,
 	int err;
 
 	lock_sock(sock->sk);
-	err = __inet_stream_connect(sock, uaddr, addr_len, flags, 0);
+	err = __inet_stream_connect(sock, uaddr, addr_len, flags, false);
 	release_sock(sock->sk);
 	return err;
 }
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 876f3e5f34c0..39ccbfcef136 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1057,6 +1057,7 @@ int tcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg, int *copied,
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct inet_sock *inet = inet_sk(sk);
 	struct sockaddr *uaddr = msg->msg_name;
+	bool defer_connect = false;
 	int err, flags;
 
 	if (!(READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_fastopen) &
@@ -1076,6 +1077,9 @@ int tcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg, int *copied,
 	tp->fastopen_req->uarg = uarg;
 
 	if (inet_test_bit(DEFER_CONNECT, sk)) {
+		inet_clear_bit(DEFER_CONNECT, sk);
+		defer_connect = true;
+
 		err = tcp_connect(sk);
 		/* Same failure procedure as in tcp_v4/6_connect */
 		if (err) {
@@ -1086,14 +1090,13 @@ int tcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg, int *copied,
 	}
 	flags = (msg->msg_flags & MSG_DONTWAIT) ? O_NONBLOCK : 0;
 	err = __inet_stream_connect(sk->sk_socket, (struct sockaddr_unsized *)uaddr,
-				    msg->msg_namelen, flags, 1);
+				    msg->msg_namelen, flags, defer_connect);
 	/* fastopen_req could already be freed in __inet_stream_connect
 	 * if the connection times out or gets rst
 	 */
 	if (tp->fastopen_req) {
 		*copied = tp->fastopen_req->copied;
 		tcp_free_fastopen_req(tp);
-		inet_clear_bit(DEFER_CONNECT, sk);
 	}
 	return err;
 }
@@ -5148,6 +5151,8 @@ int tcp_abort(struct sock *sk, int err)
 		/* Don't race with userspace socket closes such as tcp_close. */
 		lock_sock(sk);
 
+	inet_clear_bit(DEFER_CONNECT, sk);
+
 	/* Avoid closing the same socket twice. */
 	if (sk->sk_state == TCP_CLOSE) {
 		if (!has_current_bpf_ctx())
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7a22e9388e0e..8968db58083e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1920,10 +1920,12 @@ static int mptcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
 	msg->msg_flags = saved_flags;
 	release_sock(ssk);
 
+	inet_clear_bit(DEFER_CONNECT, sk);
+
 	/* do the blocking bits of inet_stream_connect outside the ssk socket lock */
 	if (ret == -EINPROGRESS && !(msg->msg_flags & MSG_DONTWAIT)) {
 		ret = __inet_stream_connect(sk->sk_socket, msg->msg_name,
-					    msg->msg_namelen, msg->msg_flags, 1);
+					    msg->msg_namelen, msg->msg_flags, true);
 
 		/* Keep the same behaviour of plain TCP: zero the copied bytes in
 		 * case of any error, except timeout or signal
@@ -1941,7 +1943,6 @@ static int mptcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
 			sk->sk_socket->state = SS_UNCONNECTED;
 		}
 	}
-	inet_clear_bit(DEFER_CONNECT, sk);
 
 	return ret;
 }
-- 
2.56.0.455.g6c5a503b38-goog

