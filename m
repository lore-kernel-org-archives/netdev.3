Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4291B3C342F
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 03:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788492973; cv=none; b=gk6u+GIKj+hRoS7ul9mZ0DiG2rhaC/AZjrUJqaXx9b76EaBlrqOXMA0wANTKwQ4lillzBshOwb4XBeLGRNApQGKnwoxUVhjTNWnLGmVHGHrr7tlVp0/rtn55lhT6KZOTPXGUrADNZX0A1JqVXQWAW5mqmLn02qiewSBal5iegSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788492973; c=relaxed/simple;
	bh=ZiAhASUJ7ZSEd1sho011ZRsPo5CA4ZHwT68IwTpqJqE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tMeGhru506bd1L5ConN0zo+tNDrqcuNOAzMz5rT/Nxtsup+T5SNBjGSMxMIzbPZWIZNf2SXIb199gMjNwwJkRQPpFgkpw0q2vatrDrQFXClIpK4uU1rQX/wjCSeXa/tVKg8YLWe5BU5sKK7Sb91+zbwMKao6eAOE3oekbqIJd90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SYLdfGEm; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SYLdfGEm"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-398d292eac1so1185394a91.1
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 20:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788492967; x=1789097767; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3cUwzw9H/eiRulAH46QyjBp4ZJ6hOp3rZh5lsWYljBI=;
        b=SYLdfGEm0+n/PvU/Mlc1xfaB9tIN+HS2V72k5SuZztdCj3ZtLZ1j2le3CR+0Y/CWfm
         YmWVupBIwPLogHmev0AjNGJs8yV4izLYAcv2SEtGidZQC1207f6MZiI1iFy7lBLVaY2D
         DzrcKVJgb1xRtBWE/E0zO7wL8NWspNqMAhCHgz5ewIPBXZECqE7m5wWxNwg1s+vRHMER
         TsX6P0Vo/GX8xqHEXovHQAoFywJZMam8lBRaHuVqt3IEOPi2+pxtlnTdjgZAOR6jJ6tz
         OVeQlLGcvh9KTk5BDVfis9OLG+YXiAtSNQSV//IbglJ0vy7RXWaP9eQ9S5Z5P3Il6G4i
         v6TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788492967; x=1789097767;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3cUwzw9H/eiRulAH46QyjBp4ZJ6hOp3rZh5lsWYljBI=;
        b=dcf4/VxnFMTwtlBoCmG7pnapdDbRzKNhXtLVca2P6DfRvotE1/D/ohua8cDpzvuPYP
         GtlLZq4nU4eHf2O8SPFvVscSF6ly2lyc2ALdHxdGVqZbS+2Goit/nFfdq5yC5rN2BaX1
         wBk+mPMT4Yly9glROvfKTQywFq/KXtOSWh+2yt7zBcKZGENa+FFvBs8c4aSUNTLk/XEt
         1CfcE6H3t7rdAkuELjh5gM092wigrdUY4twaaXs6jKML587WGSyATvz/B6T7pfmkMjkD
         PVgoNI5RBMDaC9NFujGxp/MK8CV0Sm9waDwFq1xjADTFYfYBbwjFyPrZJlb+8F/PxkHr
         dA6g==
X-Forwarded-Encrypted: i=1; AKwUvBxuB4aPQJKY+ZJgm9BfcN92NjMVKYq0Z1XuYLOk5xoe/rqpysy735ThoYLdWaKc06pHmc2QX9E=@vger.kernel.org
X-Gm-Message-State: AFuF++mTFtcoRst1RpvS0Yc41utNiCPTaLBSJCp15o5n9Slrfhi7v5KE
	cXUw2njlWwoJabHyDX7j3+WGiazo95JahHtajkDPlb+M4oyqUmtcvZoku78Cuo0C2DVRTRcyqPP
	mVWGcYQ==
X-Received: from pjbgn19.prod.google.com ([2002:a17:90a:c793:b0:38f:f04:c1e8])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:55cf:b0:396:b918:c2a
 with SMTP id 98e67ed59e1d1-39b261b1a52mr5158252a91.12.1788492967145; Thu, 03
 Sep 2026 20:36:07 -0700 (PDT)
Date: Fri,  4 Sep 2026 03:35:29 +0000
In-Reply-To: <20260904033543.2635540-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260904033543.2635540-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
Message-ID: <20260904033543.2635540-3-kuniyu@google.com>
Subject: [PATCH v1 net-next 2/2] ipv6: Remove IPV6_ADDRFORM.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Daehyeon Ko <4ncienth@gmail.com>, Hyunwoo Kim <imv4bel@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Recently, IPV6_ADDRFORM has received many AI-driven bug reports.
Fixing them properly would needlessly churn the fast paths in TCP
and UDP.

IPV6_ADDRFORM was initially introduced in RFC 2133 in 1997,
but only two years later, it was removed from RFC 2553 in 1999.

In 2026, modern applications natively support dual-stack sockets;
notably, systemd's socket activation does not use IPV6_ADDRFORM.

Also, getsockopt(IPV6_ADDRFORM) can be replaced with SO_DOMAIN.

Let's remove IPV6_ADDRFORM.

Later, we can remove sk->sk_prot_creator and revert commit
c26c192c3d48 ("udp: properly deal with xfrm encap and ADDRFORM").

Reported-by: Daehyeon Ko <4ncienth@gmail.com>
Closes: https://lore.kernel.org/netdev/20260902010408.1057857-1-4ncienth@gmail.com/
Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
Closes: https://lore.kernel.org/netdev/20260824033331.1084971-1-imv4bel@gmail.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/linux/net.h      |  2 +-
 net/core/sock.c          |  4 +-
 net/ipv4/af_inet.c       |  3 --
 net/ipv6/af_inet6.c      |  4 --
 net/ipv6/ipv6_sockglue.c | 87 ----------------------------------------
 5 files changed, 2 insertions(+), 98 deletions(-)

diff --git a/include/linux/net.h b/include/linux/net.h
index 3d82966e2243..470100ae7107 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -166,7 +166,7 @@ struct socket {
 
 	struct file		*file;
 	struct sock		*sk;
-	const struct proto_ops	*ops; /* Might change with IPV6_ADDRFORM or MPTCP. */
+	const struct proto_ops	*ops; /* Might change with MPTCP. */
 
 	struct socket_wq	wq;
 };
diff --git a/net/core/sock.c b/net/core/sock.c
index fa60b7494c58..1d5927cd49a1 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -770,7 +770,7 @@ bool sk_mc_loop(const struct sock *sk)
 		return false;
 	if (!sk)
 		return true;
-	/* IPV6_ADDRFORM can change sk->sk_family under us. */
+
 	switch (READ_ONCE(sk->sk_family)) {
 	case AF_INET:
 		return inet_test_bit(MC_LOOP, sk);
@@ -4010,7 +4010,6 @@ int sock_common_getsockopt(struct socket *sock, int level, int optname,
 {
 	struct sock *sk = sock->sk;
 
-	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
 	return READ_ONCE(sk->sk_prot)->getsockopt(sk, level, optname, optval, optlen);
 }
 EXPORT_SYMBOL(sock_common_getsockopt);
@@ -4032,7 +4031,6 @@ int sock_common_setsockopt(struct socket *sock, int level, int optname,
 {
 	struct sock *sk = sock->sk;
 
-	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
 	return READ_ONCE(sk->sk_prot)->setsockopt(sk, level, optname, optval, optlen);
 }
 EXPORT_SYMBOL(sock_common_setsockopt);
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 32d006c1a8ee..d9421ac38d78 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -582,7 +582,6 @@ int inet_dgram_connect(struct socket *sock, struct sockaddr_unsized *uaddr,
 	if (addr_len < sizeof(uaddr->sa_family))
 		return -EINVAL;
 
-	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
 	prot = READ_ONCE(sk->sk_prot);
 
 	if (uaddr->sa_family == AF_UNSPEC)
@@ -789,7 +788,6 @@ int inet_accept(struct socket *sock, struct socket *newsock,
 {
 	struct sock *sk1 = sock->sk, *sk2;
 
-	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
 	arg->err = -EINVAL;
 	sk2 = READ_ONCE(sk1->sk_prot)->accept(sk1, arg);
 	if (!sk2)
@@ -875,7 +873,6 @@ void inet_splice_eof(struct socket *sock)
 	if (unlikely(inet_send_prepare(sk)))
 		return;
 
-	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
 	prot = READ_ONCE(sk->sk_prot);
 	if (prot->splice_eof)
 		prot->splice_eof(sock);
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 282912a11999..f0efdc13baf4 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -429,7 +429,6 @@ int inet6_bind_sk(struct sock *sk, struct sockaddr_unsized *uaddr, int addr_len)
 	const struct proto *prot;
 	int err = 0;
 
-	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
 	prot = READ_ONCE(sk->sk_prot);
 	/* If the socket has its own bind function then use it. */
 	if (prot->bind)
@@ -567,7 +566,6 @@ int inet6_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 	case SIOCSIFDSTADDR:
 		return addrconf_set_dstaddr(net, argp);
 	default:
-		/* IPV6_ADDRFORM can change sk->sk_prot under us. */
 		prot = READ_ONCE(sk->sk_prot);
 		if (!prot->ioctl)
 			return -ENOIOCTLCMD;
@@ -636,7 +634,6 @@ int inet6_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	if (unlikely(inet_send_prepare(sk)))
 		return -EAGAIN;
 
-	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
 	prot = READ_ONCE(sk->sk_prot);
 	return INDIRECT_CALL_2(prot->sendmsg, tcp_sendmsg, udpv6_sendmsg,
 			       sk, msg, size);
@@ -651,7 +648,6 @@ int inet6_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
 	if (likely(!(flags & MSG_ERRQUEUE)))
 		sock_rps_record_flow(sk);
 
-	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
 	prot = READ_ONCE(sk->sk_prot);
 	return INDIRECT_CALL_2(prot->recvmsg, tcp_recvmsg, udpv6_recvmsg,
 			       sk, msg, size, flags);
diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index b4c977434c2e..1f68fb64a43e 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -547,86 +547,7 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 
 	sockopt_lock_sock(sk);
 
-	/* Another thread has converted the socket into IPv4 with
-	 * IPV6_ADDRFORM concurrently.
-	 */
-	if (unlikely(sk->sk_family != AF_INET6))
-		goto unlock;
-
 	switch (optname) {
-
-	case IPV6_ADDRFORM:
-		if (optlen < sizeof(int))
-			goto e_inval;
-		if (val == PF_INET) {
-			if (sk->sk_type == SOCK_RAW)
-				break;
-
-			if (sk->sk_protocol == IPPROTO_UDP) {
-				if (udp_sk(sk)->pending == AF_INET6) {
-					retv = -EBUSY;
-					break;
-				}
-			} else if (sk->sk_protocol == IPPROTO_TCP) {
-				if (sk->sk_prot != &tcpv6_prot) {
-					retv = -EBUSY;
-					break;
-				}
-			} else {
-				break;
-			}
-
-			if (sk->sk_state != TCP_ESTABLISHED) {
-				retv = -ENOTCONN;
-				break;
-			}
-
-			if (ipv6_only_sock(sk) ||
-			    !ipv6_addr_v4mapped(&sk->sk_v6_daddr)) {
-				retv = -EADDRNOTAVAIL;
-				break;
-			}
-
-			__ipv6_sock_mc_close(sk);
-			__ipv6_sock_ac_close(sk);
-
-			if (sk->sk_protocol == IPPROTO_TCP) {
-				struct inet_connection_sock *icsk = inet_csk(sk);
-
-				sock_prot_inuse_add(net, sk->sk_prot, -1);
-				sock_prot_inuse_add(net, &tcp_prot, 1);
-
-				/* Paired with READ_ONCE(sk->sk_prot) in inet6_stream_ops */
-				WRITE_ONCE(sk->sk_prot, &tcp_prot);
-				/* Paired with READ_ONCE() in tcp_(get|set)sockopt() */
-				WRITE_ONCE(icsk->icsk_af_ops, &ipv4_specific);
-				WRITE_ONCE(sk->sk_socket->ops, &inet_stream_ops);
-				WRITE_ONCE(sk->sk_family, PF_INET);
-				tcp_sync_mss(sk, icsk->icsk_pmtu_cookie);
-			} else {
-				sock_prot_inuse_add(net, sk->sk_prot, -1);
-				sock_prot_inuse_add(net, &udp_prot, 1);
-
-				/* Paired with READ_ONCE(sk->sk_prot) in inet6_dgram_ops */
-				WRITE_ONCE(sk->sk_prot, &udp_prot);
-				WRITE_ONCE(sk->sk_socket->ops, &inet_dgram_ops);
-				WRITE_ONCE(sk->sk_family, PF_INET);
-			}
-
-			/* Disable all options not to allocate memory anymore,
-			 * but there is still a race.  See the lockless path
-			 * in udpv6_sendmsg() and ipv6_local_rxpmtu().
-			 */
-			np->rxopt.all = 0;
-
-			inet6_cleanup_sock(sk);
-
-			module_put(THIS_MODULE);
-			retv = 0;
-			break;
-		}
-		goto e_inval;
-
 	case IPV6_V6ONLY:
 		if (optlen < sizeof(int) ||
 		    inet_sk(sk)->inet_num)
@@ -1088,14 +1009,6 @@ int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
 	if (copy_from_sockptr(&len, optlen, sizeof(int)))
 		return -EFAULT;
 	switch (optname) {
-	case IPV6_ADDRFORM:
-		if (sk->sk_protocol != IPPROTO_UDP &&
-		    sk->sk_protocol != IPPROTO_TCP)
-			return -ENOPROTOOPT;
-		if (sk->sk_state != TCP_ESTABLISHED)
-			return -ENOTCONN;
-		val = sk->sk_family;
-		break;
 	case MCAST_MSFILTER:
 		if (in_compat_syscall())
 			return compat_ipv6_get_msfilter(sk, optval, optlen, len);
-- 
2.55.0.1003.g10538fe699-goog

