Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793604137;
	b=pnIBcdthgv9ZTOBvNNhK4T+QC/d7rGFdERNf8NoPYN5OqwjhegIIU48FYdaZJ1XunHc+
	 HEjSWdOhTgP1SEEVAvc4tFU8z+O6swyJEjibNwA1JBSfOlNF+6bXF4smIgGg0KuBMGJXm
	 ZyR/ha0o1P6R9VibF+pBGkDUb4QdKIl+tJDSuuOaO0dbMQ6iD7gZBAbwslVxtbiiMSKao
	 g+bOtQyJrMUSXB4b0FxmEr15HYtdCVKmD9Stb0miTaoeB9L5NQNY7v9I66G3sbdsoWii1
	 ZQ8n68cXQBO2YkmQTW0SLAgEe1ZZL3yUClh5quEzqG7r/p00JDWA+9Ksx2l9CEFEcBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793604137;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=IIVQCChPoYZLHDZpOQjjkNqmaU+lbodlGj9e9gYxfdo=;
	b=P1ArFUNALfvv6lnFVNqZcEXUySL0P0WLZNgxm27kzl9JhqvIzrNFEXPMQWdGZMkUEqnK
	 JA19POXP0zxnzV7lY8cI+rSFsu+lUskCDP8YibzroyOLurzmD9gUSW+PTfPfKFb9h5hKV
	 KcPUnSxm1OmqduNFf90ZZD/RSHS6/mlsgHAClyN9dEHsSR4WcDhAYWfbNArg0Qrbt1b3U
	 vMOfEvAOgNsFLn36hDsTR0D9Fz0V6WzXsj4pgb1C7uv7mV/m8u5BgfZbMSsGuLqdT4UWt
	 OsPNmpfbclj+o2jFPGqCkzP55qkvvQvd7X8W6DWlXOSojbqrpuv8+JIXB0bIPSlyGZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J86FxYek;
	arc=none smtp.remote-ip=209.85.215.180
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91C2606A32C
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 07:22:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A91C2606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J86FxYek
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cc1bc88a20eso1818253a12.3
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 23:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793604136; x=1794208936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IIVQCChPoYZLHDZpOQjjkNqmaU+lbodlGj9e9gYxfdo=;
        b=J86FxYekk/QPYPKi9wXndksGulQs0bA7zqT+6Zw7mqjcv/zRrIA+25U6lUuGtvtorE
         rQ44QOMwcupUrZ54O8n2DNwyCcARbetnRYIGqkyqZztqEtU/HQFVtfiGRzAob1MG9uau
         bThmbRMT1FZ7V8xk1R7QYWZdKvLfNfgg/CXII77j4L9crd0qQThzWaVZJtqlEOFeGw+r
         C3iQm3+zN2eIRjUYKoAUUFtKe1anu7LTPH5Cparjrp9cUKjVclDDx899z4L1i/QFpO3T
         S7YLdxDjTRBjjhGVtv2i3Ma+OXgaMtliMHPCIC5eyJ34XnjMnubxJnn+Z44oGjfTdup7
         v+bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793604136; x=1794208936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IIVQCChPoYZLHDZpOQjjkNqmaU+lbodlGj9e9gYxfdo=;
        b=qii5tPTEUDmdkYG2SHioYHMzR6slP5OEngllNmhqdMvmuH9Mmmg50fTRW7wiwzUqt0
         DFRqPqeEw0XU+GyaEVXaz5oO2rxHl1sqGKU2JVC6FRI6EZ5mJDQSfIU0O/38x25/NHYH
         W2lBCQgFJ88Zax9TkC2WOz8Lb118eT3A1neXnz1d9wL8oJjFRSAKsofWk68o/r2vN94V
         xOTsitdx4w7cEchEfgrmnvYBtuc+bsFJLfO4T0aLPQgMxrjb929Y7vIZh8oGcBeNL6vQ
         9cEX8g6+ZKiKhmghVBqGWyJyOdD2KnAcu84OEWQkYJrPRp4xxnEcEFrKgKrwYKjUScH0
         Ii3Q==
X-Forwarded-Encrypted: i=1; AKwUvBzuKBi1SF5gUCcLCZd2cT7R3BAfLpmWArj6S15iGTBdxILzpAeyQ4imqow3z+/1xG+MQpB7lX8=@vger.kernel.org
X-Gm-Message-State: AFq9FYI41HvyZF4pWLy576f73wzlhktc4W/Eajt4/ECrIDur0CYg8fje
	LXvkgcjiuVylJo+U91PV28dKtWP+BAMBndEkvPg5aaKaFR0zYwvIqjY3
X-Gm-Gg: AYBFou3cK8Yx+ijo9xNZYhHJp2kRij0Rnk6HL25ypqP0Rk8UdRn8XaZvK13Wfb0UTka
	vt0rxVgtJ2vZ/szKMVA/fx8rHRs7jyiEcyV8vW37rzHiPPXmySsRwxcDPOoSYmJNp7HYeg35fJ7
	gugW58q+rtVjgZsYUMt2wl57B2Q/E7URYrwce5p+mDGX/Y5q6bu+qmfnQORIS4JE7GrUjTOYmzP
	KKt6luQEOJAiiIRcvY3aFotCNAQ1KUXwX8h3WegDtyHBrTJbDmnINPDTLMHs5qO0RcgtxMFIdTB
	1Kxi0UFgi9pn4sScd8Zm1pEBvCfIXEhAt6eQiExPZCmNduRfeC1E8+vF3y4XWtYuHeIn6nn6GbW
	q7PNEOvmYyZT5N1F0MVEQM6GDwbhorXnMwCWlZmxzqX+liHPdzAXV5DNt54zv77vnB9b1AcaYmP
	X0rw+ifOX8fvJD7EqAhSUspy7YagbTT5FjXyoPvGg+RVEluKhRTLR5CansX406pXdMo6RHWsVIK
	8ATnnVXfSRhd+kWnVN+lUTMNbTrWCvOhySyE0sZuV9/ysU9E6e0A3hbYOanBIBMVhO+wKF01j3R
	h8hBJLiefLvbP8lGsm1veydQvFU091uKUUzELDLIXXWDU4HL9Oa74OZQPbEI4PvSu1euYEpX7Pm
	PT/lucg3m2lSHEDu4Hc1v7BZ8wal9Ref6wehcXeehHDElaRFnNGLCVzSUwtU4Z0EyeRBO5FfxyQ
	==
X-Received: by 2002:a05:6300:6bcf:10b0:3eb:6198:7068 with SMTP id adf61e73a8af0-3eb61987343mr628123637.17.1793604135777;
        Sun, 01 Nov 2026 23:22:15 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb096d3827sm2894741a12.12.2026.11.01.23.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 23:22:15 -0800 (PST)
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
Subject: [PATCH bpf v2 09/15] bpf, sockmap: Check the TCP state in recvmsg()
Date: Mon,  2 Nov 2026 07:21:06 +0000
Message-ID: <20261102072112.4160195-10-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>
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
index ef2e15de0fe3..3d703f1517d8 100644
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

