Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793702430;
	b=eCU+ghhfn1clJqDlmLnd1wDCj+767jlJSuOhIRVKM5ze6f6ROnU+Fkx+7viSn0/1BxzY
	 A/r9Sj1Rx8XcXmbtQ0pWTi4pj4IjBDYfy39veAsK/gq2UOgdYJNnG3Cc/J7nrCNqdEd2J
	 +UyckUDGFBfKX2jn92O0uwF5LiZTICUFsQgqOxRyszy/8UEsrgBMNXp0Y51AnURnltnBi
	 +XXhvm7eL+pjnjKX1KzSipH+vYAFWU6TeirwlqLlBzzAbcTgJ8OJbMaDQnEW8dSK8r4Ez
	 EdpJ9zcjJnqOSLX6cumJ9dW7Ry3zWGaYfU1shDl0lmeoZ5jR9P4Zt9Dl75QXIMMtZ4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793702430;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WwDr7AR3Yel0vmHw532J1yhKIdIYegdDoVEAcqR8ZcY=;
	b=EKFFNAOMMf0ijOwHL7M/ZIeK9/6toFHUz580cQjPPZDcDT+qbpBWV/d7LsKIhZf4OIs/
	 LKVrT338Y4TzwaHo417b9srk2+YO4uJvNBTildEX6jQp7SWpoWuy6JAlb9/qnGGqQhDEF
	 0zX3zOzklgbBGzL1Uk8r8DZvZrtNgTWa4wYptlF2GDZlDOnN9J7A5EmBq+DIjoUP5GJYK
	 rgVB+eKDGcS3P6vNT+Ax/z77WNh0q1ItofNqnVDTC7CiybTl5mXY2pmf/0pNsjVEnuBuC
	 f9YuqZ6XeNx8+ANDqC/oliLqIGnWtD1cZEXzruVEplMQ+3rWEZyf9KpW8p/FJEj5FjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BSwbOtXA;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1FB606A334
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 10:40:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B1FB606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BSwbOtXA
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-36a1947498bso3934851eec.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 02:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793702429; x=1794307229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WwDr7AR3Yel0vmHw532J1yhKIdIYegdDoVEAcqR8ZcY=;
        b=BSwbOtXASJL5MpWs18FHADRwIStEW0fcE4XYA8I3sUUookk9VeJrSNK/Tx1w6wCd7S
         LMgLVeEj6e4oYNbfvSZh7VlQWVJc05ofSEyrcpp/lSGIdAZbbu5s5S2kHm3vHp1qgScK
         4rjzENtjj3+d+g1sGPosnipYwCNUbo9O63OdIQ0qbnsaLnLq++mc/iOZGb7U6lXAxeWH
         SgmzWjcykl/s8m9ZbTsVniygLfJ8uGqsOkuGtY8r+Pi1xYj703wFQdyKRIIeggFGH0+w
         wBxPAucgw1vpIVTjl7UiDT1roxagLQ1EGTErr7BwHoC0vcdyHmI3PGk1tqbec2r7wm15
         o9eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793702429; x=1794307229;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WwDr7AR3Yel0vmHw532J1yhKIdIYegdDoVEAcqR8ZcY=;
        b=QqnWlQreYBR9Os8Beya8fyH9nZ0JpBqZyCZmSpASa/l1nt3iMOR2qsY2nzUQAr6QQ9
         sv9PC1H0UY525mzNwDLgWQvp79gtJ1MS+TDOoK8Y1BowFjGYV+na91RGr+vhxcg3b0Hm
         xyw+7mz3CEBmKJplmKVu98maaJkI7Dok6Q70u/TLWvszrWjM2V4dWRlo+MjDR9XFKOut
         ypyBEm+w+3ViNToWdt8Z5hHYcaaHbEEfQ99MB4UynW2wXHcHgCZkLOYCJo+5nZ1sFX7W
         iijlelIChZJOktNazmtYNzrUERSLNS3K3GCHXecdjrgdyAH0K9lKkrlQsXLCAH/B6s5r
         M4Dg==
X-Forwarded-Encrypted: i=1; AKwUvBzjqTGG1PNWJNzrhqPlfxx4lSYjrs4dKEn/vWq0gjpkZDwHx169fs6OM8PDZZHK9R7ayg66/7M=@vger.kernel.org
X-Gm-Message-State: APuU4Z+CFNLsqmoFmmjxKbSuGGxZxOSARyX9xyfr953IdQpFYzQC5wOQ
	seXQc79FyUPwjZi1vPI0+9lRJ8V9E1giS4YfIqa6kn7KcndyMuGZ1Q23
X-Gm-Gg: AYBFou3toNA9RYkTSU+zBp6EhGKDjKUxL0XnOeTmfvtnmRwSRaW4wjw4GvcnL0NLZ/Y
	TXYUhUmBj9v3LW9s8K4EXlmOqWTA41esaXV3bojwb+1i+1UB2eD9Gc5vIkUpAEgO4ltacYVq0HE
	V/Sw3jshTPbki+u3FkLgpjvo0KQ3vzliGSkSQ+hioR9qnZMVCyhlp4wtR6dUAOx+5qgk5AGgwf6
	Nz1E7diEhYVh2nJd6ICJJDPCWBrbn5NP9EM6+szbCZ4mpHJDDClAbJeAVf+yBFLyEAWobpNbLXj
	Yki67PyB6cxPlmtsSM0goqiYlW5YAP+R44dWkGPbPzAcSoA5rgPG6lPcBLZobAT4ic6kS2RLrd8
	YFAx27jbGsGDwDQ03SnkBoJv712hOGA6xXbmbPOv+o8RURLrhJRf6brkDAVNmIpXD7XuAtC3RDj
	MT18kLQbur6Vci4JOfbcYkkOU+HFP99j9LzR5J0WLsbq6jRGeH0khSdQfzxuC0U1fu70hEPAc0P
	Ga7cLOl7vsVv8Zt6z4q3SUxZ+Z4OxRZfx3iRgXDNieDVhUY5rwte3oyPiZjTJA/WDbSF/KZvTcn
	pQ0Y7WcS3BtT797zkq+6Rw==
X-Received: by 2002:a05:7301:2710:b0:351:207d:bff4 with SMTP id 5a478bee46e88-36a42203e2bmr20325803eec.4.1793702429355;
        Tue, 03 Nov 2026 02:40:29 -0800 (PST)
Received: from lion.. ([104.192.92.238])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36b13bd87b2sm6024447eec.28.2026.11.03.02.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 02:40:28 -0800 (PST)
From: Zhiyu Zhang <zhiyuzhang999@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>
Cc: Neal Cardwell <ncardwell@google.com>,
	"David S. Miller" <davem@davemloft.net>,
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
Subject: [PATCH net v3] tcp: prevent cross-family skb processing after disconnect
Date: Tue,  3 Nov 2026 05:36:33 -0500
Message-Id: <20261103103633.2707416-1-zhiyuzhang999@gmail.com>
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
icsk_af_ops, sk_backlog_rcv and af_specific to their IPv4-mapped
variants. A later connect(AF_UNSPEC) calls tcp_disconnect(), which does
not restore them.

The socket can then be reused for a native IPv6 connection while
tcp_v4_do_rcv() remains installed. IPv6 packets drained from its backlog
are consequently passed to the IPv4 receive path.

There is also a race in the opposite direction. tcp_v6_rcv() can look up
the socket and initialize TCP_SKB_CB(skb)->header.h6 before taking the
socket lock. If the socket is disconnected and reconnected to a
v4-mapped peer in that window, release_sock() can drain the queued IPv6
skb through the newly installed tcp_v4_do_rcv().

tcp_v4_send_reset() and tcp_v4_send_ack() then interpret header.h6 as
IPv4 options. __ip_options_echo() can consequently overflow its 40-byte
destination buffer.

Commit 8cc3aef0cb19 ("tcp: Do not allow buggy transitions between ehash
and lhash2.") prevents listen() after connect(AF_UNSPEC), but a native
IPv6 connect is still allowed.

Add tcp_v6_disconnect() to restore the IPv6 handlers after disconnecting
a v4-mapped socket, and use the same helper in the connect error path.
Reject non-IPv4 skbs in tcp_v4_do_rcv() before accessing IPv4
control-block data. In the reverse race, the skb belongs to the
disconnected connection, so drop it instead of redirecting it to the
IPv6 receive path.

MPTCP subflows override sk_prot, while two teardown paths call
tcp_disconnect() directly. Route them through the protocol-specific
disconnect operation so IPv6 MPTCP subflows receive the same
restoration.

Tested with TCP and MPTCP by reconnecting an AF_INET6 socket in both
directions after connect(AF_UNSPEC). A socket filter was used to widen
the native-to-mapped race window and verify that the stale IPv6 skb did
not reach tcp_v4_send_reset().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Tong Liu <lyutoon@gmail.com>
Reported-by: Qi Tang <tpluszz77@gmail.com>
Closes: https://lore.kernel.org/netdev/CALf2hKvp0NPVLwr=a3+jUHtPohxbra8gox+aYAfWathJnn-J+Q@mail.gmail.com/
Link: https://lore.kernel.org/netdev/CAL4WiiqFJpmcV4=TWRpukCq6q=-729658FwGvieNcPXe97kLvQ@mail.gmail.com/
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
Co-developed-by: Zhiyu Zhang <zhiyuzhang999@gmail.com>
Signed-off-by: Zhiyu Zhang <zhiyuzhang999@gmail.com>
---
Changes in v3:
- Reject non-IPv4 skbs in tcp_v4_do_rcv() to cover packets queued
  across a native IPv6 to v4-mapped reconnect.
- Drop Kuniyuki's Reviewed-by tag due to the code change.

v2: https://lore.kernel.org/netdev/20261101182736.430733-1-zhiyuzhang999@gmail.com/
v1: https://lore.kernel.org/netdev/20261030032314.1978575-1-zhiyuzhang999@gmail.com/

 net/ipv4/tcp_ipv4.c  |  5 +++++
 net/ipv6/tcp_ipv6.c  | 37 ++++++++++++++++++++++++++++---------
 net/mptcp/protocol.c |  4 ++--
 3 files changed, 35 insertions(+), 11 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index a7f9242f1e42..8fa6564d2b60 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1836,6 +1836,11 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
 {
 	enum skb_drop_reason reason;
 
+	if (unlikely(skb->protocol != htons(ETH_P_IP))) {
+		reason = SKB_DROP_REASON_INVALID_PROTO;
+		goto err_discard;
+	}
+
 	reason = psp_sk_rx_policy_check(sk, skb);
 	if (reason)
 		goto err_discard;
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

