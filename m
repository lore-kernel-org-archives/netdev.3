Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792671373;
	b=IzRHjhCH4l7qoOlHY39L5zXCFyFsl7SB0kfOVETIXbUPxM+9Ic6nk5eubL5Ayccu95QA
	 LbyeiCrLscKhbjDv8kC/p9VVoTslgi6GK9eoyZBziALKaNNF1aifDptbrNUoJONgHaoIn
	 Mf18/fBDrG4hRHuP7Tw9qLn3J7jzeN9RxHw6xW8zQP7eJIeXTexiCGwffQ6EqKsc2bT24
	 WcgBcm1sGx79yNmDtTZQgZH13jLrom1iPhYNSX9RZzLPlvo7k9yl+R69Bp9gvfR5Oyc16
	 3ZC3VRUwQI3AclshQaTcmdSyKBQB7um5p2o5AeRyYILAWUO3ncz6sjwziq0ed/UhSpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792671373;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=S3g7FmRtYk6mLcSTf6R4WN2X64D6S402+tvmBaPh93w=;
	b=h1PA3W151ScE++XHU+GhKohA8TqAcVxWxcOq9IU5B7xt2F6/T5e9c+fqA3H4Wm/u1ae1
	 b1RHS1sVc9Skr/mtrfOF3MvJQKkxEYw/pgIKmZ6nxj5hdZ6tzGYHGlgRfThHa0j8zv88V
	 tddhKDD80DD80+uFPzK1WzXXl17I2V9nd99jQa6X6XD0DxlzeJQld9Fx9d2V9W7kpmUyO
	 9FZYWnUJJtHT91G1ZXDIj/y0HYYIKsYO3eB3qCtVvFyEkD8TZGoDo9va2IEP6aFMMSJqQ
	 IU7RPSNVO1Wq6wl7siLKdA1PKCJtsV0GQe/L5WTHKrssJUMfhhqJ1Jg/DbqW2StTLjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openvpn.net;
	spf=pass smtp.mailfrom=openvpn.com;
	dkim=pass header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=O9HXbLg1;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19096606A328
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 12:16:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19096606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=O9HXbLg1
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48dfaa3fa12so621930f8f.0
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 05:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1792671370; x=1793276170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S3g7FmRtYk6mLcSTf6R4WN2X64D6S402+tvmBaPh93w=;
        b=O9HXbLg1E9hcFIx6TdOADC4TWx6ERNgyhtwYdvs5dNY2bn9izpyRiKM6sxG3nHuk8a
         iFAr+96jO7fzNRyz7KZ4jLxKbymU3WBOLgXtJcNEXtzWSCnTZ2VTTa278AM3bB+B9aye
         hvcET0toydK8DA308i9ALsmizNaRIFiymWlOMAT7+K9q6nsD46RAHR52yUJBccHpEjm+
         H+/wC1PrPSJD5r4yCdG6W1jRFxrjRSb4UrOsaHAc0xGl3xgyqcmzdr2w9VKfBCjq+e71
         00YdYUAGdxddbHVzMQSEqoQy0pq9FasqMGAWuUgRRvnApQUdyRzrUkel7xaosug47jhB
         ynig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792671370; x=1793276170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=S3g7FmRtYk6mLcSTf6R4WN2X64D6S402+tvmBaPh93w=;
        b=MfziZiPyz7RCj0lQzW/66HS6yH/6nBe55ESOKdon47vLH7T4lakr4a5WXo98YU0C8l
         8sP/1Uv14xdbzCy6LhUFVjDTWkcFMjZmcY7B1I9MtkkUMSfMAOTVUyfsmWVIQnoxscK8
         ZtuRD7DUklEbeTBjgM+4V5GhGr/esCvDvr/qMMMsEf9F181gRpRpgxTsMo8Y3CPUKBLe
         Ed4uvyzpMHl2GjlVhKoqKqDMWrynb2e1kmazm7SX0/EweupUgJ8lCRGAS1aFJpvxKZJn
         EFwuJyqKclaOvUY0vvJ6+cZPD00Sr2AuWrvmRectwxnnpEOEWhjE6jqOD9K0xoqvWCPT
         9R0w==
X-Gm-Message-State: AFq9FYKgipGdcj1BiFH6FFZTHrU0e5E8b/3Y8grIv9CtAbmD9LvlAZIQ
	k2ygV2LoTDVw96IUnovh0CiSSOkTmP1tgOZie0aiLpnQMkpQrGjyLCHzozMPFDIXZMIE3lC431L
	nP6iqnCIhYgJqrt2wcY2saXhtOcpltYirfIiD8/1/g6ucqSc7NKaXVJVN7GOyF3HkLZ8=
X-Gm-Gg: AYBFou3n4sIKrj+ClvQZgAVzFB/8Cgmys51o0BCdDu3WZjljDKn9ubyHzvXTh0HNtZf
	FYSu2ycihq7VuE7F61A9dSa8odtPHo11Aup8e1g3KgyWa5+ZZmMDjDKk++aKMcNgb/CEHDKc1gq
	a/IGqpDL6LzLOq1nPoCvdBP7yEewcuAsi5jnPdkcLidStqxwz0y0N3pVhpAUrDJmZzDomXykVvl
	vTNPDabEmUViNWc85mj9oEkaCwVu/p9gWDI8gR6015WZC/LIVBUwK7Zf4ynRJrN8GprVs0N1dET
	HGGOG2NCQ7gbx3Bk3lPUEt0c/rWzju1/JNfDXLmSZ6M+TQOLFWF/oc0Tq5JktV2D64H1h5RMlaK
	emGFz445pLpV4gfs2EweQaO78lvbXRLAjwQvA47YVXyhhLFi4Mz1UXuuruY33PR+m1xS6igArv+
	QRShm6QrxRdFWpfy2IKDyKPQUCdbJqTCgeNPW3yRLgEIrcu6KQXupxpXx68cLSji1vDr2pMywnO
	NvRqNTQN2Pyt2jvELXfsPc3gdISOhBccPJVKeFVsKfuZz+b1bnBDMYJwroxko9qpPY=
X-Received: by 2002:a05:600c:c83:b0:49e:65f2:db64 with SMTP id 5b1f17b1804b1-4a204aace0amr44327105e9.5.1792671370312;
        Thu, 22 Oct 2026 05:16:10 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:8826:77b9:4cd:7631])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fd0f4427sm112485135e9.3.2026.10.22.05.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 05:16:09 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Ralf Lici <ralf@mandelbit.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	stable@vger.kernel.org,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net 1/7] ovpn: avoid sending UDP packets with source port 0
Date: Thu, 22 Oct 2026 14:15:44 +0200
Message-ID: <20261022121606.732029-2-antonio@openvpn.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022121606.732029-1-antonio@openvpn.net>
References: <20261022121606.732029-1-antonio@openvpn.net>
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

From: Ralf Lici <ralf@mandelbit.com>

ovpn operates on a userspace-owned UDP socket, which may be manipulated
in various ways by userspace. If the socket is never bound, connected,
or used for communication, it may not have a source port assigned.
Similarly, if the socket was connect()'ed to AF_INET or AF_INET6, it can
be disconnected by connect() with AF_UNSPEC, which resets the source
port unless the socket was explicitly bound.

Since we must not transmit packets with source port 0, gate UDP TX on
the presence of a valid source port and drop packets otherwise. To avoid
ambiguity, sample the current source port once before route lookup and
header build and enforce the check on that value.

Emit a ratelimited warning when this drop path is hit so the broken
socket state is visible. Return local UDP output errors to the common TX
completion path so locally dropped packets are not counted as successful
transport TX and do not refresh the peer keepalive timer.

Fixes: 08857b5ec5d9 ("ovpn: implement basic TX path (UDP)")
Cc: stable@vger.kernel.org
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
[antonio: rebased on top of the ovpn_route_key rework: check the
 key.sport snapshot once in ovpn_udp_send_skb()]
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/io.c  |  4 +++-
 drivers/net/ovpn/udp.c | 24 +++++++++++++++++-------
 drivers/net/ovpn/udp.h |  4 ++--
 3 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 9526f8096da6..ce1993b243e6 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -282,7 +282,9 @@ void ovpn_encrypt_post(void *data, int ret)
 
 	switch (sock->sk->sk_protocol) {
 	case IPPROTO_UDP:
-		ovpn_udp_send_skb(peer, sock->sk, skb);
+		ret = ovpn_udp_send_skb(peer, sock->sk, skb);
+		if (unlikely(ret < 0))
+			goto err_unlock;
 		break;
 	case IPPROTO_TCP:
 		ovpn_tcp_send_skb(peer, sock->sk, skb);
diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index 055cdb1bee13..30c7eb261e7b 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -407,7 +407,8 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
  * @key: route key snapshot used for cache validation and flow lookup
  *
  * rcu_read_lock should be held on entry.
- * On return, the skb is consumed.
+ * On success, the skb is passed to the transport stack and consumed. On
+ * error, ownership remains with the caller.
  *
  * Return: 0 on success or a negative error code otherwise
  */
@@ -455,15 +456,26 @@ static int ovpn_udp_output(struct ovpn_peer *peer, struct dst_cache *cache,
  * @peer: the destination peer
  * @sk: peer socket
  * @skb: the packet to send
+ *
+ * On success, the skb is passed to the transport stack and consumed. On
+ * error, ownership remains with the caller.
+ *
+ * Return: 0 on success or a negative error code otherwise
  */
-void ovpn_udp_send_skb(struct ovpn_peer *peer, struct sock *sk,
-		       struct sk_buff *skb)
+int ovpn_udp_send_skb(struct ovpn_peer *peer, struct sock *sk,
+		      struct sk_buff *skb)
 {
 	struct ovpn_route_key key = {
 		.mark = READ_ONCE(sk->sk_mark),
 		.sport = READ_ONCE(inet_sk(sk)->inet_sport),
 	};
-	int ret;
+
+	/* an uninitialized socket or connect(AF_UNSPEC) can cause this */
+	if (unlikely(!key.sport)) {
+		net_warn_ratelimited("%s: peer %u: UDP source port is 0\n",
+				     netdev_name(peer->ovpn->dev), peer->id);
+		return -EADDRNOTAVAIL;
+	}
 
 	skb->dev = peer->ovpn->dev;
 	skb->mark = key.mark;
@@ -473,9 +485,7 @@ void ovpn_udp_send_skb(struct ovpn_peer *peer, struct sock *sk,
 	ovpn_dst_cache_check_key(peer, &peer->dst_cache, &key);
 
 	/* crypto layer -> transport (UDP) */
-	ret = ovpn_udp_output(peer, &peer->dst_cache, sk, skb, &key);
-	if (unlikely(ret < 0))
-		kfree_skb(skb);
+	return ovpn_udp_output(peer, &peer->dst_cache, sk, skb, &key);
 }
 
 static void ovpn_udp_encap_destroy(struct sock *sk)
diff --git a/drivers/net/ovpn/udp.h b/drivers/net/ovpn/udp.h
index fe26fbe25c5a..5b67112162a5 100644
--- a/drivers/net/ovpn/udp.h
+++ b/drivers/net/ovpn/udp.h
@@ -19,7 +19,7 @@ int ovpn_udp_socket_attach(struct ovpn_socket *ovpn_sock, struct socket *sock,
 			   struct ovpn_priv *ovpn);
 void ovpn_udp_socket_detach(struct ovpn_socket *ovpn_sock);
 
-void ovpn_udp_send_skb(struct ovpn_peer *peer, struct sock *sk,
-		       struct sk_buff *skb);
+int ovpn_udp_send_skb(struct ovpn_peer *peer, struct sock *sk,
+		      struct sk_buff *skb);
 
 #endif /* _NET_OVPN_UDP_H_ */
