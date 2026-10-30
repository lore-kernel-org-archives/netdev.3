Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793330824;
	b=mq5NgXc7X12W76t6CteDjQI7U2NGZFDBdDGX6V+DRC0JCbaa7cK74PtHP33HQ17PINP/
	 uqry5upXppQRY2+dO0SDsgKMDbosGcQwTw0+uEzdYCvJcVKFrgXRR9cNIXpEh9MSQiBg9
	 lz7A95J93DDHy4TRAZUBFz/+lQamk9uZqeelnXIWD5cVcKftzSUsfhbt331cK4FK7ySSu
	 p/Wa1DLsSc/yadySjskeKYZRe6OLOahq0H4QDPaKl601nyLo/z95iUsIKTZG/YnSapvHG
	 0HsJq/9sZMQIoMHLgSe1RE9Nvs/dIDn7JriZC0wiE++whGCUNXF34c3GwwnLeUiH8tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793330824;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=A6Ni+wahzTnZu0bMH4b4Ekm2v/4N8fmdTpJc/aI6SvU=;
	b=r3rzr5lKV27a1f8aMs5wRv66T2hh0N6cqITaCPa3O207HPhMKUG4HoUzcbE71ZoxV6Bs
	 RelYrX3Qh1MWV2toxW0OgQwsXzZUfNgFMXoiTmg67Y3zpaw2iEZqYMjpAipTyiMxx+BRN
	 9yqSV4etEzo1vFqvgIO68jQJc84LCno6e+oICMoHixP6B+7dcaKjxQ2ZuVkFtZroboTK+
	 dqqfnm/2og+Or4Kq4pJuKYgD+ktfqrPC3VDCtuWXTpfXXCt09Hn0Iij/bwhAIq0fZpY4u
	 TttvpVu/uTw1mgbQoGaofiLaPjDIOFyrl7xm2pE5kF4PPT37wETCz+zDLOB4E3AY44A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KvGEw43f;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58FA606A31C
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 03:27:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A58FA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KvGEw43f
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1931ff67a29so787387c88.1
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 20:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793330823; x=1793935623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=A6Ni+wahzTnZu0bMH4b4Ekm2v/4N8fmdTpJc/aI6SvU=;
        b=KvGEw43fMTm9qtoDGb0rrL7QTKd/Rn1IQMQRBRsblrC41UyMgYzsmvrhakA4Q35YBi
         4eIPhIFgB4BhCbi6KeHE06dK3Ib4gMb8NQkcS5fKpIUxkHs6FJRRCizzbMfqX/me/MM4
         r27Up1guQjtGeyvxc/gO510tkT1TgDgtf2lgVlqZ/cUWcx9oGbrUMWvYTkg0ZIh6oZMP
         wqN8oRt+UyfdUPMaaxMAzlJX3RXgYPGmtereWKQhugP5xgDw0eDTnNuatMOFLvIVc1pk
         Xg7OHMAjGKyyLxKbSNcqBs0v5YPXEn+VosW+7weQshEhBZgZqEO8/7qKJ+Vm/bQy8FX0
         lc/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793330823; x=1793935623;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A6Ni+wahzTnZu0bMH4b4Ekm2v/4N8fmdTpJc/aI6SvU=;
        b=t/b5cBDnY3Mj6st5y+iRenQHbkyEm3gqzx5WXzik+yvAN9K33OfGY4wruTAbd/6rG0
         4yDvs0c5vDgdYGHpDFEQpYxE+zQ6yxrH5PxKcAar06WC0pK0XyPP158EpwzKWANt7fTP
         Uf6PxxtxdMlvzcU18JDP/wbikiPDYW8uxW9cWI8TmiRjogm7gaAwhgYLNQtLSlGtvFQX
         3MnXuRTGcHwRYytHSrAxtLfo+GlcbBi0dwVkj1sfbmj+s8JUxN9RgbnDUvvYcC363fvE
         jB8ILsnJfOJaQUcV0cpF9BiAQtWpvD0RHoiQdnhzcnPbv4jvUfAOUksEMT2ABdkWDLkd
         PnhQ==
X-Forwarded-Encrypted: i=1; AKwUvBxPAczZc3XxV+bQynRf46dHcaRKNrZynm/sVgJet12lvsVra/h3TIVRvO+GUYyZCmOhzquVcmQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYIR7SMh4V2PvEPoY34tus45GqiLiqnasTQyzd0duXjMRYtdJwZ4
	kHhPA7LSexIxCdyO1ZLr28gEubPY7nUYyU8xq02+SjRn0ei61Ez1uIGW
X-Gm-Gg: AYBFou3iALPJF74qEMSstFm5WD3zI/k8fVAbTTV7HAhbb8+bcVZ9WocBlgIC41lOSmw
	aVHtsTAmSb/JETDD50aP2FsPMj48rp/TWJfTnvb0RQwoWjxaiT+n+03HT1CLSJHglgM+K48n0+V
	CWWlMsNcWG3C1d/lshwZjuUrtkCij9CUQ+XM0zXeMMhVCRS829eSpWEChuVaCtwKFbUIka0LQLK
	WfxL3nJiMSKduHXYFXKjf6o921Gd/K5E9VQueleOqs1MhRkSVggJl0SQHgJ65QX885O26o5WrpT
	94uAp2NgSEM/wc6qwJ3O2lc2ZT5CdKmr0/cnmWo1pFoJ69r80OF+4W2GdCWvDtn9c4DXxP5GjQa
	6xifR80TGep8yPiPyXftf1+aolgkW+glmW47yOkEtjJH+ai8lHj0ut7t8GaCuLtMqtKc0yXT0RL
	d9OdXGC+ZNd1ULEQIXLTUbzA+J1BH0jr0Ini7on2uv9WUtD7MJea9bss5qCG9RyJCzeUenwtLm+
	3E52quds7vSs9GhDB6ENMUzEds4COysMBYPax3tG44i59sJ4vm4p9dhITITqz0+EcxZkKxbZguB
	xa9gPBeQFV72Fbg/7SbYVTz/3w==
X-Received: by 2002:a05:7022:3b87:b0:196:d6e1:108b with SMTP id a92af1059eb24-1ac59fbfd13mr1403659c88.10.1793330822482;
        Thu, 29 Oct 2026 20:27:02 -0700 (PDT)
Received: from lion.. ([166.1.190.168])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1a13652csm3067356c88.17.2026.10.29.20.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 20:27:02 -0700 (PDT)
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
Subject: [PATCH net] tcp: restore IPv6 af_ops on disconnect of a v4-mapped socket
Date: Thu, 29 Oct 2026 23:23:14 -0400
Message-Id: <20261030032314.1978575-1-zhiyuzhang999@gmail.com>
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
Reported-by: Zhiyu Zhang <zhiyuzhang999@gmail.com>
Closes: https://lore.kernel.org/netdev/CALf2hKvp0NPVLwr=a3+jUHtPohxbra8gox+aYAfWathJnn-J+Q@mail.gmail.com/
Link: https://lore.kernel.org/netdev/CAL4WiiqFJpmcV4=TWRpukCq6q=-729658FwGvieNcPXe97kLvQ@mail.gmail.com/
Link: https://lore.kernel.org/lkml/20261029054136.1174216-1-zhiyuzhang999@gmail.com/
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
Co-developed-by: Zhiyu Zhang <zhiyuzhang999@gmail.com>
Signed-off-by: Zhiyu Zhang <zhiyuzhang999@gmail.com>
---
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

