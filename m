Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794419280;
	b=i/NH0L7vQ9yWPxI0SuGPYiRlA+iC7cAUFb7n9BX7UTx+4gt+GT2D5lLXDRmerSskLw60
	 fQFbt7zgQsrltQ0zUxnCObqbgJZyvtOIJguBDy2dgeJIY6744M/CPtBfqQ1RltwHgvyuj
	 MKv2BraJIxdil13gYiwfIakWaW9XKNC5G6fTlHpszCp4ruXK/LuldHhVv3BK+3W97VLiS
	 kh+xCBOH308WqzJOExNHJrn/Hv7cM6pgqIBoMtCQcuYxVbJicifVYOUGDcmgh7gcea1wP
	 3R+FpT+bGvxywZLVfjFN2YytG3t3k5d+zzWrDapCDo/X/mpYfGzjXjdh6h8qEivtQ6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794419280;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=wGzKPyIc6e0sQq1pu1RR+JZZd6ZgGrGLpyyYyUORI+Y=;
	b=fZEak1o6mxkJct++KJyhnJZLL467xUUArl1mvWT4/sdCVvfT50jKr5WFX7y++OsqT41Z
	 jWOPiL4wv+2axHiLjX/RWSmlNjEbQ0rvseETuxDsSQ3pwVjvnG+Sw0ILLqelx3XtUIAfJ
	 aqIqCENs3BHnVg1DXRJpk36o6RrztMVDOX8CRO4Vzc10Pg+y6HZSAbOzi6IcBFlaBd17N
	 Aaf0yEEkbPH8aVEC6tezoSqTeShvY0NE9oz81wMgKpLsSbii3WDq534nKe2LFRfcRawlg
	 mGVuqw0N582CvMjLDRia/5+q9lV9jBHrsclzkx8ZqxkpzrnY+dRUM2xX/kYlmUsODng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mzPpOiav;
	arc=none smtp.remote-ip=74.125.224.47
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FA5606A32E
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 17:48:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37FA5606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mzPpOiav
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-67be1e468a8so2732433d50.0
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 09:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794419279; x=1795024079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wGzKPyIc6e0sQq1pu1RR+JZZd6ZgGrGLpyyYyUORI+Y=;
        b=mzPpOiavZjWGC0VpKLXkiQTk7jWoAOSjROcU2NNkp2/udg76bL0g9eUJdQkMGbxkTh
         Zc1kPkeMv9ZBOMw3G0+h+HnDlcBf7fNY/o1IivdREn+um+JymdJNJjuawplssP7xEmut
         V1RdxnoNpCuXOQ0QiEMH/XtC88DYUNQEY2urQo1lZaKPhyova0/mEOOD7YPh7hip+wdC
         z26uYPMFc9Mx4FRiiz1kH6t//38s2+72XwfBgsD2OEO7PH6hb9MhdXHjumzrhWMYCetr
         gnYbnLlqcHlyfQsAdqqAmP5VUhrOTF6DwWFBnjKREsXg7+OVprhfoJxzjdQa9KepzYXt
         ZWyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794419279; x=1795024079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wGzKPyIc6e0sQq1pu1RR+JZZd6ZgGrGLpyyYyUORI+Y=;
        b=i0/yWXp7Ra0WWYqTA0QB03g1v+3pKvNimp1q137Oa/9rHfgvQVdP9iUWaM2bqu4uQU
         nChP9N5rmzdZ8JL+nElMSn4D5iZzevEK21qJw6Y/KEmO8SAiFRsB662Zjs+n/i50Yf0A
         TGm1kXw2Io2ARLXdCrsXCPxY+Qq6Nv65kWo9mZ5qnaXn9pXWr+pGfWxWTrOJ7CUIRIGq
         eUZIUuy2UW4Y+tS0b1liKucScCScmPgwH80eez6SbdJhhHQSNuKHVB/v4h9NiLsgdMXy
         7WS5UPfhXN8IOEwCFeD8pN3Ym902776DmW+xV2I7/ErMvCN1RzNXvV5x29YVlXal4hQA
         x5pw==
X-Forwarded-Encrypted: i=1; AL+hErFXSvH9UMYTHC8iqeLB+tAyPjS98VE0cdHmsfBtYih6y4/vPNwtCNr+iOtD85RbQWou5GPxjLA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+l7zTaLXxGHkdo4mxZqZWr1TsZI0BbufkFOaaE3mHvH+nesk50
	E8jRhUrNZrBWbeGqxYXg01JD6HzpbPiAMVxRqPWrmsvoo/RLlTQNpacG
X-Gm-Gg: AYBFou1578zeVu8f8SmjatQl1j65pm2YBwkuvm4AsA7LNzg1JFelpgKIXfmAfEWwwSr
	7EzVTgyhO53zhHiZfh0UnmpaqIlHq+KqeZqRGWoel/AzqI1XgqaQl87RUPQrG327sokezvpjWif
	Q6QPSjb7eQiBsm3eT1Lmhw73k++Nw/fvZlZjCSN5egcR5Jhcx0Ihv8t+y0gv/OYE7DXw6dM5o73
	egvFxRTwO4kmMFtmxN/Xrh55nOptspkMAU56caUk8VUfkdc8vgzlVAlkFrX/wLBbqQjN7BhL6RN
	A/XHRxqkK5uwX93PGLtnNSBVahraKsiKOMtvxaTNpU/zs/2lAZgxuibTzfFRCx5ljuPCVrXufVh
	dUVj4te8dhMobllRCkOGSt/dQ/jO9EJCmuuuQFmMp8ZDvCOdL5jO1WjacCWhucD7iOgZRyUvAJg
	NPUzDee3GJqh6ct2qDaOGUxV5UBbwLJ4A3kAdmGV4XpNQuEk3RwRN0pzBW/g2nBeu3PPbcdC64E
	sJ8hPbCMeFGjNyO5eAQfrcUsxTVN+RkOuM/2xPDmQQC8TCoiJcBXAFCNz5rJFN1BEPAo1TDPCVw
	AxgbIQxXqxRRxZwkvHRRuTMJN+2H1WM+kr94dUS+KD7XqqlWpA6X0Q==
X-Received: by 2002:a53:c7c2:0:b0:679:9afd:c0de with SMTP id 956f58d0204a3-67c6805a592mr1606256d50.97.1794419279142;
        Wed, 11 Nov 2026 09:47:59 -0800 (PST)
Received: from VPN-156-197.vpn.usf.edu ([2607:fe50:0:f802::4046])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67c589c6f24sm5077708d50.12.2026.11.11.09.47.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 09:47:58 -0800 (PST)
From: Juan Agustin Niccolini <juanagusnicco@gmail.com>
To: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	ncardwell@google.com,
	kuniyu@google.com,
	josef@toxicpanda.com,
	jbacik@fb.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Juan Agustin Niccolini <juanagusnicco@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2 1/2] tcp: Fix the SO_REUSEPORT bind cache admitting a conflicting socket
Date: Wed, 11 Nov 2026 12:47:03 -0500
Message-ID: <20261111174704.24312-2-juanagusnicco@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111174704.24312-1-juanagusnicco@gmail.com>
References: <20261111174704.24312-1-juanagusnicco@gmail.com>
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

When the port is in the FASTREUSEPORT_STRICT state, inet_csk_get_port()
skips the bind conflict check if sk_reuseport_match() finds the new
socket's address covered by the socket cached in tb->fast_*.

This is only safe if both sockets match on everything
inet_bind_conflict() reads. The cache misses some of it:

- It does not record sk_bound_dev_if or sk_reuse.
- It records the family and IPV6_V6ONLY but never compares them with
  the new socket, so a cached v6only [::] (or 0.0.0.0) socket covers
  a dual-stack [::] socket.

As a result, an unprivileged user can bind and listen on a port that
another user is listening on, for example a dual-stack [::] socket on
top of a 0.0.0.0 listener:

  victim:   bind(0.0.0.0:P), listen()
  attacker: SO_REUSEPORT + IPV6_V6ONLY, bind([::]:P)   /* fills cache */
  attacker: SO_REUSEPORT, bind([::]:P), listen()       /* should fail */

Only take the fast path when the new socket matches the cached one in
family, IPV6_V6ONLY, bound device and SO_REUSEADDR. Identical
SO_REUSEPORT listeners, the workload this cache was added for, still
skip the scan (binding 16384 of them: 9.80 ms before, 9.86 ms after,
5874 ms with the full check every time).

Fixes: 637bc8bbe6c0 ("inet: reset tb->fastreuseport when adding a reuseport sk")
Cc: stable@vger.kernel.org
Signed-off-by: Juan Agustin Niccolini <juanagusnicco@gmail.com>
---
 include/net/inet_hashtables.h   |  2 ++
 net/ipv4/inet_connection_sock.c | 15 ++++++++++++---
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
index 6e2fe186d0dc..44b7e39a1245 100644
--- a/include/net/inet_hashtables.h
+++ b/include/net/inet_hashtables.h
@@ -87,6 +87,8 @@ struct inet_bind_bucket {
 	__be32			fast_rcv_saddr;
 	unsigned short		fast_sk_family;
 	bool			fast_ipv6_only;
+	unsigned char		fast_sk_reuse;
+	int			fast_bound_dev_if;
 	struct hlist_node	node;
 	struct hlist_head	bhash2;
 	struct rcu_head		rcu;
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index e56beec43877..70b8662b3004 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -420,13 +420,18 @@ static inline int sk_reuseport_match(struct inet_bind_bucket *tb,
 		return 0;
 	if (!uid_eq(tb->fastuid, sk_uid(sk)))
 		return 0;
-	/* We only need to check the rcv_saddr if this tb was once marked
+	/* We only need to check the fast_* fields if this tb was once marked
 	 * without fastreuseport and then was reset, as we can only know that
-	 * the fast_*rcv_saddr doesn't have any conflicts with the socks on the
-	 * owners list.
+	 * the socket they describe doesn't have any conflicts with the socks
+	 * on the owners list.
 	 */
 	if (tb->fastreuseport == FASTREUSEPORT_ANY)
 		return 1;
+	if (tb->fast_sk_family != sk->sk_family ||
+	    tb->fast_ipv6_only != ipv6_only_sock(sk) ||
+	    tb->fast_bound_dev_if != sk->sk_bound_dev_if ||
+	    tb->fast_sk_reuse != sk->sk_reuse)
+		return 0;
 #if IS_ENABLED(CONFIG_IPV6)
 	if (tb->fast_sk_family == AF_INET6)
 		return ipv6_rcv_saddr_equal(&tb->fast_v6_rcv_saddr,
@@ -455,6 +460,8 @@ void inet_csk_update_fastreuse(const struct sock *sk,
 			tb->fast_rcv_saddr = sk->sk_rcv_saddr;
 			tb->fast_ipv6_only = ipv6_only_sock(sk);
 			tb->fast_sk_family = sk->sk_family;
+			tb->fast_sk_reuse = sk->sk_reuse;
+			tb->fast_bound_dev_if = sk->sk_bound_dev_if;
 #if IS_ENABLED(CONFIG_IPV6)
 			tb->fast_v6_rcv_saddr = sk->sk_v6_rcv_saddr;
 #endif
@@ -482,6 +489,8 @@ void inet_csk_update_fastreuse(const struct sock *sk,
 				tb->fast_rcv_saddr = sk->sk_rcv_saddr;
 				tb->fast_ipv6_only = ipv6_only_sock(sk);
 				tb->fast_sk_family = sk->sk_family;
+				tb->fast_sk_reuse = sk->sk_reuse;
+				tb->fast_bound_dev_if = sk->sk_bound_dev_if;
 #if IS_ENABLED(CONFIG_IPV6)
 				tb->fast_v6_rcv_saddr = sk->sk_v6_rcv_saddr;
 #endif
-- 
2.43.0

