Received: from mail-oi2-f41.google.com (mail-oi2-f41.google.com [74.125.231.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1D94BF942
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 23:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790812021; cv=none; b=blWFekUAFb74b+FckVKxIHkdVmLwPCG891yxDabKNcuuoe0ulUcyrzdVwDFTfKGb7gMiuUNC1lTrEvHT7AYJYd1t9lyN0vSDtN/3CwQyVorP5wrucQgghxnuXXjARnts9wF5IlrjUMVGcdFlOC44Cqmlaz7elHZM35dgUIeU/Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790812021; c=relaxed/simple;
	bh=iblGMahgLZune0cSe5e5OmjGa+556ag6bGB4xcI13V0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EcYHtyICSGMV5NwiRAiVDN9anJEJ8RZyR77PnietStzmCSzMlTOH6kaWX9OaubFikHBQBSQzLjnRSfb+RhBzXuOM+ThZrM2ZC02JhFxa3UQGCBSbto3puzPcWmWS1sfoGsydhNwaTp273/rgReA7Y8hVttfB0do/9S0ZekJUffE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BpIhlJ5x; arc=none smtp.client-ip=74.125.231.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BpIhlJ5x"
Received: by mail-oi2-f41.google.com with SMTP id 5614622812f47-4f3eae7ed7cso2931b6e.1
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 16:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790812017; x=1791416817; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0j17oIRuAGUkTjUjCIFdQDlJWq8HxpJZyTfiOjsPwXU=;
        b=BpIhlJ5xP2y0imDxf5FITGPFXXIaKjNgIwPtITgSurTNLwuyMHaDYdiSzjzcKL6Nab
         XrH2gyxMdT9POEvMKFbvRfjxkmdAUoGAuFR01bqsjuPow3QGeRTNE6AW6vz9BtQhLhbe
         m2pvF1y+YAL9mGLNd/E6chXkO82aF8zVKOlt1653Wujf2EGro0gkBGWKr7Tjaxx6WIT2
         o5tRrDsOHY1PiuO94YE3815/WyldVf2Jd/3tO2u8lCMEREiivYRIc02aZX65EwkYJlCg
         2Q6fmne4LBEISIG7SnhYBRLi8aA5uL9TDcLSeYXDeuEJ1sUBjQeMtwIFhdjYoPyToos0
         i31A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790812017; x=1791416817;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0j17oIRuAGUkTjUjCIFdQDlJWq8HxpJZyTfiOjsPwXU=;
        b=w8APqlwmTU8b44DpsHZDE1F0PoYVaLclZzHf6Ml4WkZ1SRg/fBnst3otB+MNV82vtO
         G0wqMlq6D9runxrQRBWskeBHXFTh/I9S90Nl3AQFsEXULfBeD9seRUBo6LeCy/EZzuXU
         zNUfwoWbH1L9QVejQFVmZXv4s4fV1MCjJrduqVDagevTUIvok3XhvPvckIJtlu8+GLCA
         oRs0dB++rcn1tVnNWwdeIhq6Lu6XVo8IWDIlVsvUW2m8JyD/btleLXa3q0xofDtoaEOj
         DYrxr2rnr4OcZRFPn/lCHdUniyul+fo71Vs3Jh4BwDyiAJRPg2GtMYcxWdmJPl203xyP
         Jzew==
X-Gm-Message-State: AFuF++m5ixM+H9JbgE92TSA77/p7aUIjP2blRGWgGPFl2/zf9unjsZ+4
	Wc9BNyf5PTkP0e7C+MBcQ6CNcu5h1r1rRpOAfShDNmiK0AcpBtz1YyTb
X-Gm-Gg: AYBFou0JKuW2/AkbhTcS4OJd6wE9jjcblmKLgaKI9QmomxcazF5VuAEUVLnzHE9mq0h
	/81p6veu4uaKdltSiI61o9gczD545LvCDPV6kINvu6a/kHqWZHDN17BpyNw/Tsnv0+ec2H7mkzw
	eTYRbO7UF/SP4PVJg19gwoJTtu8Tl4C/O9TcSwMk9v39RgIK7sW0FLW5cnbjGPrG7UIaO29/GTY
	iMP08TUPQ5Lr8gY1zOY9X3nKc+9iuCOrEAZO5AliacKSTjyywyqTFumc/wmo8JOoao9iVi6vJIZ
	NOuyC7oGSRwdccWk7enGQf/kRRHhxTMNzMIupagrVLJ2uAKPUUOgqtIPQNxjtH+6ETF9ebwqe9j
	wH/NKQ7Z1bIS1rACH0wtyv4t7BYYp9snF18aHbKSqFDoWPVAMRbdAs286wR46pI5QRIF74/hipF
	eI3QRlyxvGh84Xo/hVHHHVADxN+qRS4stGLVS2QtQmsjoYp1WJHITFU+Wu0sBRaeQFxec=
X-Received: by 2002:a05:6808:1825:b0:4e5:a74e:d6c0 with SMTP id 5614622812f47-4f1ba4fa10emr3448107b6e.64.1790812016621;
        Wed, 30 Sep 2026 16:46:56 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:9::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4f34c58cb6dsm872370b6e.13.2026.09.30.16.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 16:46:55 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Wed, 30 Sep 2026 16:46:47 -0700
Subject: [PATCH net-next v2 2/4] net: psp: require an established
 connection for association setup
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-psp-defeat-v2-2-f266e7447129@gmail.com>
References: <20260930-psp-defeat-v2-0-f266e7447129@gmail.com>
In-Reply-To: <20260930-psp-defeat-v2-0-f266e7447129@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
X-Mailer: b4 0.13.0

Check sk_state under the socket lock in both the rx-assoc and tx-assoc
handlers, and only allow association setup on sockets in
TCP_ESTABLISHED. Also, fail connect() when PSP assoc state is already
present, and remove the dead PSP MSS adjustment from
tcp_v[46]_connect().

The net effect of this commit is:
1. PSP assoc state can never exist on a listen socket.
2. The upgrade to PSP must be done while the socket is in
   TCP_ESTABLISHED.

This change defeatures behavior that was previously allowed under the
PSP uapi. My justification is:

Nothing useful can be done after association setup on closed or listen
sockets today. Listen sockets could accept a PSP-encrypted TCP SYN, but
the child socket will not inherit any PSP state. On the other side,
establishing PSP state prior to connect() will result in a PSP-encrypted
TCP SYN sent to a listening peer, which in turn has the aforementioned
limitations. That implies that there cannot be any users of this
feature, so it should be safe to remove it from the PSP uapi.

In theory, the check in the tx-assoc path is more restrictive than
necessary. FIN_WAIT1/2, CLOSING, LAST_ACK and CLOSE_WAIT could be
allowed, and the peer would accept PSP-encrypted ACKs in the
post-FIN-sent states, or data in the half-close case, but it is simpler
to disallow those states because they don't fit the upgrade model.

The check in the tx-assoc path fixes a bug in commit 6b46ca260e22 ("net:
psp: add socket security association code") where an unsynchronized
write can be performed on an assoc shared with a timewait socket when
the socket is in TCP_CLOSE after shutdown. This commit is not targeted
at net because its premise of preventing listen sockets from holding
assoc state depends on net-next commit 8cc3aef0cb19 ("tcp: Do not allow
buggy transitions between ehash and lhash2.")

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
v2:
- reject connect() on sockets with PSP assoc state
- drop PSP MSS overhead handling from tcp_v{4,6}_connect()
---
 Documentation/networking/psp.rst |  8 ++++++++
 net/ipv4/tcp_ipv4.c              |  7 +++++--
 net/ipv6/tcp_ipv6.c              |  9 ++++++---
 net/psp/psp_sock.c               | 12 ++++++++++++
 4 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/Documentation/networking/psp.rst b/Documentation/networking/psp.rst
index 4ac09e64e95a..0f9b6b73f244 100644
--- a/Documentation/networking/psp.rst
+++ b/Documentation/networking/psp.rst
@@ -132,6 +132,14 @@ numbers in a way that deletes a prefix of the PSP protected part of
 the TCP stream. If userspace cares to mitigate this type of attack, a
 special "start of PSP" message should be exchanged after ``tx-assoc``.
 
+Upgrade to PSP must be done on established TCP connections.
+``rx-assoc`` and ``tx-assoc`` will return ``-ENOTCONN`` if
+``sk_state`` is not ``TCP_ESTABLISHED``.
+
+The PSP assoc state of a socket is not reset when the connection is
+torn down. ``connect()`` on a socket that has PSP assoc state will
+return ``-EINVAL``.
+
 Rotation notifications
 ----------------------
 
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index c107b7e44e5b..410d63d9e5c1 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -238,6 +238,9 @@ int tcp_v4_connect(struct sock *sk, struct sockaddr_unsized *uaddr, int addr_len
 	if (usin->sin_family != AF_INET)
 		return -EAFNOSUPPORT;
 
+	if (psp_sk_assoc(sk))
+		return -EINVAL;
+
 	nexthop = daddr = usin->sin_addr.s_addr;
 	inet_opt = rcu_dereference_protected(inet->inet_opt,
 					     lockdep_sock_is_held(sk));
@@ -291,9 +294,9 @@ int tcp_v4_connect(struct sock *sk, struct sockaddr_unsized *uaddr, int addr_len
 	inet->inet_dport = usin->sin_port;
 	sk_daddr_set(sk, daddr);
 
-	inet_csk(sk)->icsk_ext_hdr_len = psp_sk_overhead(sk);
+	inet_csk(sk)->icsk_ext_hdr_len = 0;
 	if (inet_opt)
-		inet_csk(sk)->icsk_ext_hdr_len += inet_opt->opt.optlen;
+		inet_csk(sk)->icsk_ext_hdr_len = inet_opt->opt.optlen;
 
 	tp->rx_opt.mss_clamp = TCP_MSS_DEFAULT;
 
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index afb4d8e9fa67..e006a30360ea 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -153,6 +153,9 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 	if (usin->sin6_family != AF_INET6)
 		return -EAFNOSUPPORT;
 
+	if (psp_sk_assoc(sk))
+		return -EINVAL;
+
 	fl6 = &inet_sk(sk)->cork.fl.u.ip6;
 	memset(fl6, 0, sizeof(*fl6));
 
@@ -311,10 +314,10 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 	sk->sk_gso_type = SKB_GSO_TCPV6;
 	ip6_dst_store(sk, dst, false, false);
 
-	icsk->icsk_ext_hdr_len = psp_sk_overhead(sk);
+	icsk->icsk_ext_hdr_len = 0;
 	if (opt)
-		icsk->icsk_ext_hdr_len += opt->opt_flen +
-					  opt->opt_nflen;
+		icsk->icsk_ext_hdr_len = opt->opt_flen +
+					 opt->opt_nflen;
 
 	tp->rx_opt.mss_clamp = IPV6_MIN_MTU - sizeof(struct tcphdr) - sizeof(struct ipv6hdr);
 
diff --git a/net/psp/psp_sock.c b/net/psp/psp_sock.c
index a9cfeebe4ba1..a6b1c42dd626 100644
--- a/net/psp/psp_sock.c
+++ b/net/psp/psp_sock.c
@@ -159,6 +159,12 @@ int psp_sock_assoc_set_rx(struct sock *sk, struct psp_assoc *pas,
 
 	lock_sock(sk);
 
+	if (sk->sk_state != TCP_ESTABLISHED) {
+		NL_SET_ERR_MSG(extack, "Socket must be in established state");
+		err = -ENOTCONN;
+		goto exit_unlock;
+	}
+
 	if (psp_sk_assoc(sk)) {
 		NL_SET_ERR_MSG(extack, "Socket already has PSP state");
 		err = -EBUSY;
@@ -252,6 +258,12 @@ int psp_sock_assoc_set_tx(struct sock *sk, struct psp_dev *psd,
 
 	lock_sock(sk);
 
+	if (sk->sk_state != TCP_ESTABLISHED) {
+		NL_SET_ERR_MSG(extack, "Socket must be in established state");
+		err = -ENOTCONN;
+		goto exit_unlock;
+	}
+
 	pas = psp_sk_assoc(sk);
 	if (!pas) {
 		NL_SET_ERR_MSG(extack, "Socket has no Rx key");

-- 
2.52.0

