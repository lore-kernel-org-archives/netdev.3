Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793560916;
	b=e1Pb5Gjl5gsGPn7DTZGubJYEmPeQOcP6LdwtnfOa901bzAoQ1dGyFjDdw0mFcWsbEI6I
	 1daOp7U2udeK4NBapvQ/UP90SZy/baFTyf4iIgPnP4HWP0D3wR9EnFm5fa28tRVPXt5aw
	 2ely9zgW7WIzEqY9JSAtvb7lQaTg1Y7rcJzhQ+nCmaKE4nI3yIErHpP+574izkRB4AfUP
	 xWIns6r+faZf/ZyU6KFLIOEHRsw9EbVXYyHuWCBF45hRMLROoqwGgMeEAPonb5VJVtJI8
	 Svf4EJCssrhaU9VwYK0v7bOcZSqFRKr1wSPoEH0gku5mSi1ym1fNCuICOF2w7f4jsjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560916;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=iEAaFxE93Z66HvVgBeBCzXXUprLmZg1keqaBn6ibVEs=;
	b=HVZFsxtkWr4hl4VBRjVaGTmct++gYQjRRNuUI9KQNZv1TFAOo+MlVhVP6Z0QLMYRG1nE
	 rxulc55Go78CpNA60hlw2El78+yTKeeVSWj+N1MwQ7LC/EVwiNcrzL+wwCj5Mtjnhrv5g
	 jTrR5Myg5idN8FPTwnWYbHVE+/AE3Bbr6uqptqncK1FmyRv2ItXEFB+HifGoLQGo+tTIh
	 KKyF6I+Tu1h/usq5+Ajh0K5t++yi5rWs5yDfavX8leMX+qEXCjM5PX8yqGNjE9ATBSTCK
	 JF13jGfJJJVf1C7W3QPjTG/m6SoJQZr5YLng3ItPpy5h0wLWZfjSFk22kdm38ttfY1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KGkdRIyO;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECD4606A327
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 19:21:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7ECD4606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KGkdRIyO
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3acb11973c3so1799542a91.3
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 11:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793560916; x=1794165716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iEAaFxE93Z66HvVgBeBCzXXUprLmZg1keqaBn6ibVEs=;
        b=KGkdRIyOVTNIFEqxmnOgCEMdttl/Ya277iv4MbVxowwHC/nKur/m7RLM5g5l9a19AL
         3Et6EXzjS+h9hCj4WS8yDaaIaY7uzqjGgY2h0GdMxnH0MZ5Vz/vvloux4gGrFamqX4/X
         S//qLiiJjVvd6g5IXZ5CKMbJN3YqUMsU1DFUd7uzh5V0EZJNKnFTO3TJEcIpRNWx4Du/
         pRmTAxrQSJQ9Fuynbd31oFgZJLIFpnJ/JhoQJO2rl4tcAwFK2EXYBpd9+pVGEuFP3V6l
         GUHczH5p8hhCLYqAnZC9xWQVPWtZ2Iuu+x3fwKUmBTy4ouhVBT6g9LEEf7YxAm5WHVkK
         hgDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793560916; x=1794165716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iEAaFxE93Z66HvVgBeBCzXXUprLmZg1keqaBn6ibVEs=;
        b=vt7Vo0NpYrMx39QjEVH42ZPpfp+6I/tQFom2o18HQJfWp1wMm2x0AXof/pBgj9iZtT
         P7Nhb8Q7faawYGcz20gICiFkkdjJ6zLeYqXsP7ifJ0AKbIWPAoalY6dAWz+2c9/qxA2q
         wvuzcyZR8+7Ce50EUXir0B+DIFGjFLlNK9kd6nOqhJzv59LvWB//x6YS3VZ53QzFE767
         Ixf90D2qOs94Zx5QoiRzyADWeJfrJtulpHSJBn89TO5sthpzQ+8AehgNeD9V8/UhJ5MP
         Nc23iWzP28CqNQiMKsJACrn9f2AHVPOX15+wLeZlzPaHz2ZhSkQadKgsQy8L3HMhTqnL
         b5BQ==
X-Forwarded-Encrypted: i=1; AKwUvByIc+svVA1Fmteo5OBB8H5tgHIPkLFhImjc7pb9Qln7JJg45Cfl/uKFkc4wA7n1fyOGU6T7cUU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Kvrddhx2E/bdcP0ljtADGYAnU+fuSZfgfzd353Mq+bDpn4pY4
	mAxyM4HXkylSo8sDuPQweZRL4JXVW/c1RZXEjm22td3floyLvQ1YwFnp
X-Gm-Gg: AYBFou2NEqlDefIZ+LgAgkC7lJrG0f6smxS8hlnuH9UQ7Ry7HLvcViks85HjG+ck5PQ
	Zt7HNUcjL64bdipsxBXJw2SgDpAYI5J1X8vTgUj6DSsmK+TTi79sX6nwjKNGgJbzlMuRjXNaMHv
	hr67gcIwDDWy6gw+mx736Fsv625rdfcQLwz1OipZerDfvQAAi4DYIkgeGV8SWoWeiaDaDm55uWJ
	Gy2wbKBjhsxnp+9rc+zzB2iw12KQHwEnd1yUSFC5PvVpqk+rDCLRkqOdzstUilu/Qom57bgceUW
	hWiQ6GbEtzKgWf8p1BcxUF7fqWLpB27A5S8t7jHyJMWv606Eo8tTDHk2bgtSzYlr+Nzw79yhXYo
	ZEmcDk0G+S/b52lVBNLAZDpcgrhu9l9CMhf/15CZsFNov5lkUJRoEb+jjKI7a2XEZFew823auFr
	ct+7emUrM6ow77xcba7tCQR7XtmJneRSgLbCZuuZrfd8xWD3PPzzRjIhP4jbHFZMcMw1U0RW5OY
	v/nWzko9/TUutUtPJ31OXiU8eHAdqI1r20u4fDUh6UIBFixm1lotm0MKvA8k2/xf9d3VB+o9LUA
	Yvg7AGaR2TcNb2FQiA3OxvQ98NH65G100NhKuOmSbK88UIT3eALvApUSjbg3u2/klaDe1+HZxSk
	tCRjgPonLtd0fDF/2zWxoOCtIxFrlIaUwqfomqoOH/IEjyHWkozKUYZCaT77OSd1mchVLhJG1zg
	==
X-Received: by 2002:a17:90b:2641:b0:3ac:8446:c1b5 with SMTP id 98e67ed59e1d1-3ae8974b804mr6354294a91.31.1793560915674;
        Sun, 01 Nov 2026 11:21:55 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae87fc548fsm6851876a91.4.2026.11.01.11.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:21:55 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	jiayuan.chen@linux.dev,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kuniyu@google.com,
	willemb@google.com,
	matttbe@kernel.org,
	mptcp@lists.linux.dev,
	mason@kernel.org,
	josef@toxicpanda.com
Subject: [PATCH bpf 09/15] bpf, sockmap: Check the TCP state in recvmsg()
Date: Sun,  1 Nov 2026 19:20:51 +0000
Message-ID: <20261101192057.2296489-10-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261101192057.2296489-1-alexei.starovoitov@gmail.com>
References: <20261101192057.2296489-1-alexei.starovoitov@gmail.com>
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

From: Chris Mason <mason@kernel.org>

With an sk_skb verdict prog, tcp_bpf_recvmsg_parser() copies data from the
psock. Then it calls __tcp_cleanup_rbuf() to calculate the receive window
and to send an ACK. The window and the ACK need a connection on the socket.
But tcp_disconnect() keeps the socket in the sockmap and the data on the
psock. For a TCP socket sock_map_redirect_allowed() rejects only
TCP_LISTEN. Thus the psock can also get data after tcp_disconnect().

__tcp_select_window() divides by icsk_ack.rcv_mss, which can be 0 in
TCP_CLOSE. In TCP_SYN_SENT the new peer can get an ACK with the sequence
numbers of the old connection.

Call __tcp_cleanup_rbuf() only when tcp_can_send_ack() returns true.
recvmsg() returns the data as before. Move tcp_can_send_ack() from MPTCP to
tcp.h. It also returns false for a fastopen child in TCP_SYN_RECV. From its
peer the child has only the SYN data, and the SYN-ACK acknowledges it.

Fixes: e5c6de5fa025 ("bpf, sockmap: Incorrectly handling copied_seq")
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/net/tcp.h    | 6 ++++++
 net/ipv4/tcp_bpf.c   | 3 ++-
 net/mptcp/protocol.c | 6 ------
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 3560adddf821..23a22d70718e 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1845,6 +1845,12 @@ static inline void tcp_adjust_rcv_ssthresh(struct sock *sk)
 void tcp_cleanup_rbuf(struct sock *sk, int copied);
 void __tcp_cleanup_rbuf(struct sock *sk, int copied);
 
+/* Is the socket in a state in which TCP may send an ACK? */
+static inline bool tcp_can_send_ack(const struct sock *sk)
+{
+	return !((1 << inet_sk_state_load(sk)) &
+	       (TCPF_SYN_SENT | TCPF_SYN_RECV | TCPF_TIME_WAIT | TCPF_CLOSE | TCPF_LISTEN));
+}
 
 /* We provision sk_rcvbuf around 200% of sk_rcvlowat.
  * If 87.5 % (7/8) of the space has been consumed, we want to override
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index b635d3ebf4fb..9848c8e5a2cd 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -343,7 +343,8 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
 	if (!peek)
 		WRITE_ONCE(tcp->copied_seq, seq);
 	tcp_rcv_space_adjust(sk);
-	if (copied > 0)
+	/* Data on the psock outlives the connection that it came in on */
+	if (copied > 0 && tcp_can_send_ack(sk))
 		__tcp_cleanup_rbuf(sk, copied);
 
 unlock:
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7a22e9388e0e..d62cfbf2d490 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -619,12 +619,6 @@ static void mptcp_set_timeout(struct sock *sk)
 	__mptcp_set_timeout(sk, tout);
 }
 
-static inline bool tcp_can_send_ack(const struct sock *ssk)
-{
-	return !((1 << inet_sk_state_load(ssk)) &
-	       (TCPF_SYN_SENT | TCPF_SYN_RECV | TCPF_TIME_WAIT | TCPF_CLOSE | TCPF_LISTEN));
-}
-
 void __mptcp_subflow_send_ack(struct sock *ssk)
 {
 	if (tcp_can_send_ack(ssk))
-- 
2.55.0

