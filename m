Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793202066;
	b=nG22ly0nrkJwv+8vT3gJlPavPJCgMfuGyZJQN7g3//hdT8b+1cLwNFDEeZTxRebLou7p
	 epWShCIv1Xe1Gs+texTuuZe0H9AUJRJuJDOPLylgSfKUYPgVXszkeCZ270/kcP44o82mp
	 LBPBq8ft7CC2VTD3pzUH83ReKG4U/WRW6in9/g5BFfOBHCIlAO87p7YZrVuYgHrYBYuNh
	 iArVCgXUoZWRAj7NaWPg+4xGkxJp6vLNt4GaKwishlZlxCKs4prGnFb3zBwHjqMMBo0hu
	 KJbAJk3XrzJ8othG1s3Y4HohO7E61xbNuFwQO6qJfcI+NMdnoo4rUWdEOWOFcaq2x8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793202066;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=qGK54/khDS71RJ+S7yEpMvJaMCtlyphXEed3NJBhAuA=;
	b=HTV2l2UvxHQ8LF0M81FIe05FilEwVTB8fMpNpm7vUzw8/ECOeiBj4Ls1TWjQ5NEWZ3rp
	 GZQJxZ+hWJI2erTNLOlE2goOofXROdjB/GlJe2RyNX4YAF1lIN3OZxeGV4xJkVROVNf/2
	 UbREmmnOIGj1OQwPC1qzgpf75vL3iBHFzePNxEh0/FSsRTfl7QoqgGB1CsBjEKO/jUasr
	 inNWc6LN6p6/+Ho34f8+HBFBnyxwf0uMsl5PMi1v8PJ/PWwYuxPy8yppr1jdb1g0j6ZpC
	 11bIxALV2f+fsU0X8kSFDXLCsE62osarhqI5Iqz+HDp7zdLNo2HSZUjmmAHSFZzLeJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dHSXFJy+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4E260A2606
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 15:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dHSXFJy+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99D621F031E0;
	Wed, 28 Oct 2026 15:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793202065;
	bh=qGK54/khDS71RJ+S7yEpMvJaMCtlyphXEed3NJBhAuA=;
	h=From:To:Cc:Subject:Date;
	b=dHSXFJy+WDUy1i4xq7CNbctNg3536YWbz7UE/Nc+KzRt+xJYBFe5EGku0v1Wlhwqu
	 SQsLl7OJt1okzBz7HNH8Zn5dnNlcl2dvPxo0shCTg0OiY3rhMfl4JeJE0YJEDEUif1
	 4ySV7BUrfSZROYl1bydMn+w10zqotX31UsJ/dDlyaNKJJswwypRpPCoADmplveRTTt
	 /TMJmoLu9JafxVsNs/2+zj2rtOoyXCjFmbudZ+6GsWrx32uuZWe2qSYtH5TkahKAaF
	 yekFLF5PBbkoGTNpIbvxnjCK7R0TqGBggRQvElw+oU/XpYQ4uOoCor6r4V1dvqYkNl
	 8ClMKTdKiIbjA==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Kyle Zeng <kylebot@openai.com>,
	Eric Dumazet <edumazet@kernel.org>
Subject: [PATCH net] tcp: initialize mapped children before route lookup
Date: Wed, 28 Oct 2026 16:41:01 +0100
Message-ID: <20261028154101.2153360-1-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
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

From: Kyle Zeng <kylebot@openai.com>

IPv4 passive opens on a dual-stack listener go through
tcp_v4_syn_recv_sock() with tcp_v6_mapped_child_init() as the optional
initializer. The callback currently runs after the output route lookup.
If that lookup fails, tcp_done() destroys a clone whose pinet6 and
ipv6_fl_list still refer to the listener's state.

With the flowlabel list head in inet_sock, fl6_free_socklist() walks
the clone's list and RCU-frees its nodes without unlinking them from the
live listener. Subsequent flowlabel operations can use or free the nodes
again. Commit 858d2a4f67ff ("tcp: fix potential race in
tcp_v6_syn_recv_sock()") moved the initializer before ehash insertion,
but did not cover this error path.

Invoke the existing initializer after the IPv4 fields it consumes have
been set, but before route lookup can fail. It needs neither the
destination nor sk_setup_caps(), and all later disposal paths remain
covered.

Fixes: 1c17f4373d4d ("ipv6: Move ipv6_fl_list from ipv6_pinfo to inet_sock.")
Signed-off-by: Kyle Zeng <kylebot@openai.com>
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
 net/ipv4/tcp_ipv4.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 3f8563a36db1e9ea853699ecb547af7ee9491b11..c08de825fa448cfcd42c9a8b407200b0dc5b7b1d 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1723,6 +1723,12 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock *sk, struct sk_buff *skb,
 	if (READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_reflect_tos))
 		newinet->tos = tcp_rsk(req)->syn_tos & ~INET_ECN_MASK;
 
+#if IS_ENABLED(CONFIG_IPV6)
+	/* Detach IPv6 state before a route lookup can fail. */
+	if (opt_child_init)
+		opt_child_init(newsk, sk);
+#endif
+
 	if (!dst) {
 		dst = inet_csk_route_child_sock(sk, newsk, req);
 		if (!dst)
@@ -1732,10 +1738,6 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock *sk, struct sk_buff *skb,
 	}
 	sk_setup_caps(newsk, dst);
 
-#if IS_ENABLED(CONFIG_IPV6)
-	if (opt_child_init)
-		opt_child_init(newsk, sk);
-#endif
 	tcp_ca_openreq_child(newsk, dst);
 
 	tcp_sync_mss(newsk, dst4_mtu(dst));
-- 
2.53.0

