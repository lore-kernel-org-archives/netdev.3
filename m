Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793557891;
	b=jh+mMAiVa8/Jz//QS4TaHBxmRQPUOeRHU4A6r/hk1T69+QkfSq1JxpoMijbZ70sf6UmJ
	 ivWcdDE/oaZOYqHNOekHqTn+vd7zeUtnpX3OItkFpZ+BdVn9XHf3sAQ4E8wUuxI8U64pq
	 ATfc8RvXAoZRwEx2/5POsdKvU4oLgQBbUXv/1g3FFFoZFdpEw2kjkZ9Kp8eivJFbPn44V
	 j4IUAZyBxaHqrVn2Bdn+Z4sIOmAazqlEk9+o4wxqu2axby6UOHOLfK3Paoo5ookqhltcU
	 JnDFHuzzaaUQUR8PdQkJE5SpMODULk3UnLIly6VgqKG16/SlF3M4wr2wT58Ze4hfslg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793557891;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tVpS7upRTy3Zlaor6N/9+WDmU5lrwMQoo7X+ts+rJnQ=;
	b=boVlFh5qgd+pNtZXaqg34+oxLwmdREMrxvYMcxfeMkunAZ5tWyki0ks7JY4JLfFQanor
	 7k1IE2/52cOYLQUgBainf4MVgcsNzkmZ3A6R9q1Ro32+dNbOVQ96BOFUdhQhPFEq+e1B2
	 RRwBuyZVhBqOH/P3v0WFog1CQEjNo7FUCNI1rjPuBXPnvar5NzXOBNHOwFu9yBCIlxjbx
	 CbbzsbVtBcFdbv+jY9pZNKgvFCsFUP/FeGNjSdLYkQju1/cyJcHNJMfkNoB2rZ3UMI8Xc
	 HrRccFo+yzYpuSt0bJ0iWIUTLDLLTVJnvREq/153rEpiXKkHgnTkkurmFxZ3+kJOOig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h3iFtlg9;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1B4606A324
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 18:31:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC1B4606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h3iFtlg9
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-3550c917fd3so3177362eec.0
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 10:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793557890; x=1794162690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tVpS7upRTy3Zlaor6N/9+WDmU5lrwMQoo7X+ts+rJnQ=;
        b=h3iFtlg9Cnrr3CnFGFTpfSH2PhV+h/idG5/NPVBMzZmVM1aIvk3f1FVA9AaigPoNXq
         PdMsnzEKXmVtQ848MPqOhwfCE6W5nuOXuCGdOXaGmcw9cmQYT2ADdS+8P6T79dre33yx
         2nr9b5zE4UnQAJmOgnk6MqoCv6XObwM4x7EuPdsx8pvS+t0H8vB9QKG2u8VrcbooGssA
         vb8EIjW8ihuTGeWb+Bd43WD4ZKkfjlzboens3OB2o2Rp5StgO9Sl9q1DPQNMyCPsGboa
         RfTn4d3osJMfBLaUfIPBvy4+SYyLHZbG7fgVslxaxSYmBHbjz/ba95QTWzz7BqR2SjzS
         F22Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793557890; x=1794162690;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tVpS7upRTy3Zlaor6N/9+WDmU5lrwMQoo7X+ts+rJnQ=;
        b=1f81yQz4MQn80LxEsZ+cap5R0jKHsH6j4ABlF5HFlSAJd/PDDKy0OQqIhtHpkB4Vye
         It3VappAB+pnjP5s5Zx/TDWjW5j9Whw6Eykz6bykP2WOFMN/XQ8cc9IrVDy+xSDmNUpr
         YjCO+5cBDleE/cseH6j6AbL6owJySJcak6JxtwAJVU0fS77VQbgd3SGCe2ihET+68WWR
         rgq3PUE4r7UAa4H1RnuGIjpbdRPbX12pzedEIZZuKV+p/MmcncmszUP0JwS8yAiCxBLj
         D+s1nCrGbjEtg10a5MzuR0pqhuMEbZ4tzbpin2EHqs+roftPrVfnnbOa9edcLTXj1jD6
         zQFw==
X-Forwarded-Encrypted: i=1; AKwUvBxOtils+yqP0LHr08BCvp/qmxVWLZkT9U/2SSnJNSBVi4ITu7WYYpJpYxRO2mwS/CiMnGJR/oM=@vger.kernel.org
X-Gm-Message-State: APuU4Z93QRUSanMXlkYDYMBvKTA2AWWsQTDI1XEZ3PCcuCU19pdZaBKv
	eQxmX932ZIB64hsta3KgAmYqRPcolaLdmUNN0qGwqL3tU2/T3U4cQUj4
X-Gm-Gg: AYBFou0WWISPGCltm/hu4m5tkRsIDsrulKCvpKTKsECE5NpX/6gmodEedROLb1E3Xv7
	qeoFMIoCxtYaHkuuaygdbgbmzkobpp3pSaPEGXzaIfgxG7NwfjAlfpnlqkaFOty1e+w1uoQ7BF8
	8a0qrK8XYVUSZJk/PfDzQdJxIVAsycuHovKF35y54v8+/98i07Yy09YZMfUJADomD3X4SGtYQrA
	JNM7ti1H3WJXhkiEYkIXIFYazwELGmxrJgjgJtsLW40rt/sA62LdVSeO/Rmc4C6qUsfPugOi5bf
	b4ZaDTW6tPqeSiwqnUFEr9Qojg1h/DUdlqDflkqv/HRnX2z89wem0c+Fghbk3sjJOMAITMy16Th
	ZWfwL1NH+wTC4TMQj+j+nLxgr4hCHQehVVgtAXD4RaAs9AMjDo5YpXg+Bi26WHK0QTYYz7nVVKS
	2XZuXV9ac4yMGzxBSY1uSmcefNxcwqCspMkvs1omtXSZqGnPhyzSrdWa5z4ofm1lCnGEbaSw4vX
	CmlWiBxosqqWWjRwksVNRyigtgKZft00A/L95+mKIMitpJcwKdls6HRARttA9r4gPpDHfwlE2/R
	UN32mfn0IksTE39in04VF+/cMA==
X-Received: by 2002:a05:7300:6d22:b0:36a:13e1:c889 with SMTP id 5a478bee46e88-36a425e10f8mr19307844eec.36.1793557889821;
        Sun, 01 Nov 2026 10:31:29 -0800 (PST)
Received: from lion.. ([166.1.190.168])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a6f7f9sm34627741eec.25.2026.11.01.10.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 10:31:29 -0800 (PST)
From: Zhiyu Zhang <zhiyuzhang999@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>
Cc: Neal Cardwell <ncardwell@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tong Liu <lyutoon@gmail.com>,
	Qi Tang <tpluszz77@gmail.com>
Subject: [PATCH net v2] tcp: restore IPv6 af_ops on disconnect of a v4-mapped socket
Date: Sun,  1 Nov 2026 13:27:36 -0500
Message-Id: <20261101182736.430733-1-zhiyuzhang999@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Eric Dumazet <edumazet@kernel.org>

A successful connect() of an IPv6 socket to a v4-mapped address switches
icsk_af_ops, sk_backlog_rcv and af_specific to their IPv4-mapped variants.
These are only restored if the connect() fails.

After connect(AF_UNSPEC), the socket can be reused for listen() or for a
native IPv6 connect while still using the mapped handlers. IPv6 packets
processed from the socket backlog are then handled by tcp_v4_do_rcv().
tcp_v4_send_reset() and tcp_v4_send_ack() interpret
TCP_SKB_CB(skb)->header.h6 as IPv4 options, and __ip_options_echo() can
overflow its 40-byte destination buffer.

Commit 8cc3aef0cb19 ("tcp: Do not allow buggy transitions between ehash
and lhash2.") prevents listen() after connect(AF_UNSPEC), but a native IPv6
connect is still allowed.

Add tcp_v6_disconnect() to restore the IPv6 handlers when a v4-mapped
socket is disconnected, and use the same helper in the connect error path.

MPTCP subflows override sk_prot, and two teardown paths call
tcp_disconnect() directly. Route those calls through the protocol-specific
disconnect operation so IPv6 MPTCP subflows receive the same restoration.

Tested with TCP and MPTCP by reconnecting an AF_INET6 socket from a
v4-mapped peer to a native IPv6 peer after connect(AF_UNSPEC).

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Tong Liu <lyutoon@gmail.com>
Reported-by: Qi Tang <tpluszz77@gmail.com>
Closes: https://lore.kernel.org/netdev/CALf2hKvp0NPVLwr=a3+jUHtPohxbra8gox+aYAfWathJnn-J+Q@mail.gmail.com/
Link: https://lore.kernel.org/netdev/CAL4WiiqFJpmcV4=TWRpukCq6q=-729658FwGvieNcPXe97kLvQ@mail.gmail.com/
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
Co-developed-by: Zhiyu Zhang <zhiyuzhang999@gmail.com>
Signed-off-by: Zhiyu Zhang <zhiyuzhang999@gmail.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
---
Changes in v2:
- Drop redundant Reported-by tag.
- Drop the unrelated watch_queue patch link.
- Add Kuniyuki's Reviewed-by tag.
- No code changes.

v1: https://lore.kernel.org/r/20261030032314.1978575-1-zhiyuzhang999@gmail.com/

 net/ipv6/tcp_ipv6.c  | 37 ++++++++++++++++++++++++++++---------
 net/mptcp/protocol.c |  4 ++--
 2 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index e006a30360ea..a93410aab66e 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -130,6 +130,19 @@ static int tcp_v6_pre_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 	return BPF_CGROUP_RUN_PROG_INET6_CONNECT(sk, uaddr, &addr_len);
 }
 
+/* Undo the v4-mapped setup done by tcp_v6_connect(). */
+static void tcp_v6_restore_af_ops(struct sock *sk)
+{
+	/* Paired with READ_ONCE() in tcp_(get|set)sockopt() */
+	WRITE_ONCE(inet_csk(sk)->icsk_af_ops, &ipv6_specific);
+	if (sk_is_mptcp(sk))
+		mptcpv6_handle_mapped(sk, false);
+	sk->sk_backlog_rcv = tcp_v6_do_rcv;
+#if defined(CONFIG_TCP_MD5SIG) || defined(CONFIG_TCP_AO)
+	tcp_sk(sk)->af_specific = &tcp_sock_ipv6_specific;
+#endif
+}
+
 static int tcp_v6_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 			  int addr_len)
 {
@@ -243,14 +256,7 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 
 		if (err) {
 			icsk->icsk_ext_hdr_len = exthdrlen;
-			/* Paired with READ_ONCE() in tcp_(get|set)sockopt() */
-			WRITE_ONCE(icsk->icsk_af_ops, &ipv6_specific);
-			if (sk_is_mptcp(sk))
-				mptcpv6_handle_mapped(sk, false);
-			sk->sk_backlog_rcv = tcp_v6_do_rcv;
-#if defined(CONFIG_TCP_MD5SIG) || defined(CONFIG_TCP_AO)
-			tp->af_specific = &tcp_sock_ipv6_specific;
-#endif
+			tcp_v6_restore_af_ops(sk);
 			goto failure;
 		}
 		np->saddr = sk->sk_v6_rcv_saddr;
@@ -2093,6 +2099,19 @@ static int tcp_v6_init_sock(struct sock *sk)
 	return 0;
 }
 
+static int tcp_v6_disconnect(struct sock *sk, int flags)
+{
+	int ret = tcp_disconnect(sk, flags);
+
+	/* A socket used for a v4-mapped connection must not keep IPv4
+	 * handlers when it is reused for listen() or a native IPv6 connect().
+	 */
+	if (sk->sk_backlog_rcv == tcp_v4_do_rcv)
+		tcp_v6_restore_af_ops(sk);
+
+	return ret;
+}
+
 #ifdef CONFIG_PROC_FS
 /* Proc filesystem TCPv6 sock list dumping. */
 static void get_openreq6(struct seq_file *seq,
@@ -2283,7 +2302,7 @@ struct proto tcpv6_prot = {
 	.close			= tcp_close,
 	.pre_connect		= tcp_v6_pre_connect,
 	.connect		= tcp_v6_connect,
-	.disconnect		= tcp_disconnect,
+	.disconnect		= tcp_v6_disconnect,
 	.accept			= inet_csk_accept,
 	.ioctl			= tcp_ioctl,
 	.init			= tcp_v6_init_sock,
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7a22e9388e0e..fdfbc7de2ec0 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2608,7 +2608,7 @@ static void __mptcp_subflow_disconnect(struct sock *ssk,
 		/* The MPTCP code never wait on the subflow sockets, TCP-level
 		 * disconnect should never fail
 		 */
-		WARN_ON_ONCE(tcp_disconnect(ssk, 0));
+		WARN_ON_ONCE(ssk->sk_prot->disconnect(ssk, 0));
 		mptcp_subflow_ctx_reset(subflow);
 	} else {
 		tcp_shutdown(ssk, SEND_SHUTDOWN);
@@ -3287,7 +3287,7 @@ void mptcp_subflow_shutdown(struct sock *sk, struct sock *ssk, int how)
 			break;
 		fallthrough;
 	case TCP_SYN_SENT:
-		WARN_ON_ONCE(tcp_disconnect(ssk, O_NONBLOCK));
+		WARN_ON_ONCE(ssk->sk_prot->disconnect(ssk, O_NONBLOCK));
 		break;
 	default:
 		if (__mptcp_check_fallback(mptcp_sk(sk))) {

base-commit: 5838f10563d58afca6711edb5e4eda968ca181d9
-- 
2.34.1

