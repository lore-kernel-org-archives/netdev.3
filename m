Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794310407;
	b=pl8Dn7PunOX9QhoL9V+u1Ryxwvn3n7/8iJRuGxswwAGpp/yDIwi8ROoWpf83GAfIKAGy
	 3v6tbdVKUoGUdyXznaf6YQihm4QphJ0+5tm/32MGttSArCAdg5qZafffXO9DAd1hLxnFv
	 E1CKJoy1OjtPGkDAF4co+iUx3nZtzXrZxIRoBHB84aSk5GloSGrk3McBecypM5NC5wKte
	 zKlECWSaSUj0pg1uEqn5/anE601oJmlhZ9Ds8EK/gPk+0ODEEzQEFurwwJoVYMxKwM7Gw
	 ZUb52ykoBldDyHnbbcUZTdHpmrTvYUNeNMSHjmT0I/V/E+/jdDs/ffG8LLoU1vkwnMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794310407;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Rspamd-Queue-Id;
	bh=tNmq2vRttyKooYgihDJ2ATp/LmdbvaiNpm6sGSWTtg0=;
	b=DXDlua9mm2go+KOxP8ks7TDNKtmMud65HPDsy1CWZi2HYwuRpmT3sUnHp6EgGydzhpOZ
	 Ejvpik6YMvMFx5F4f1QzpQizKTCiMfXkiIl7beZUV4UxdQeatYmkdsWloX2WP9hTOW5L6
	 8w4cbKSzdFS0IS3wi3rhrWaeARpsmm2EsSiMLB7qqKTS5Em6k22rYZqSF+yB6Av8vaM0A
	 3DNf/f9pC1RAg6WIPo19vDk33yEphM51FIyuoC1GnB3W51Ud7Gk2xhrVoRVhOApgBFYXP
	 ZdEM/R/XoF8C63njigPQg1CvQZT5k89+GIxaJWAXbyOphVRWBrdHmBgg3edk65DJjmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=C1AZ8kIp;
	arc=none smtp.remote-ip=195.10.208.47
Received: from mout-b-107.mailbox.org (mout-b-107.mailbox.org [195.10.208.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B75B606A31C;
	Tue, 10 Nov 2026 11:33:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B75B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=C1AZ8kIp
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-107.mailbox.org (Postfix) with ESMTPS id 4jP4K76nLsz3xdh;
	Tue, 10 Nov 2026 12:33:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1794310395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tNmq2vRttyKooYgihDJ2ATp/LmdbvaiNpm6sGSWTtg0=;
	b=C1AZ8kIpI70a8YMF5+DpY53jBkuLnXFrok/M9o4EirCbwX7Fef7AoaQgEbJLipFD8AumYC
	qEzYk5AN/5r/K6Y3OaPHfAxkr6q6BbUzpIcvo/Y7IdBNuXZp5iJTIBj8YokhWSzRnrvjMr
	VhsJeq0qjL9RK3Ycvwl7ux2MnOTKb/TYS4UDMev34coUEfJCnARRFYUDPbr+hYoPL2G/dK
	gseH9F8jrvAnyhg2oGLL9AjbQLVx7J7IvZixltXF5YNtZxIRfAaCau2Yq7zoy4RrqVCij3
	BlykvrZxKBMgahb6DcEL5PKl0UvQoIEz2j6n7Pw6ezuwjoKOjgJ+hriNh3IUJg==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of antonio@mandelbit.com designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=antonio@mandelbit.com
From: Antonio Quartulli <antonio@mandelbit.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Alice Mikityanska <alice.kernel@fastmail.im>,
	linux-kernel@vger.kernel.org,
	Antonio Quartulli <antonio@mandelbit.com>
Subject: [PATCH net] udp_tunnel: don't treat IPv4 sockets bound to an address as wildcard
Date: Tue, 10 Nov 2026 12:33:06 +0100
Message-ID: <20261110113306.3698438-1-antonio@mandelbit.com>
X-Mailer: git-send-email 2.56.0
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
X-Rspamd-Queue-Id: 4jP4K76nLsz3xdh

With IPv6 enabled, sk_saddr_any() checks sk_v6_rcv_saddr also for
AF_INET sockets, where it is always zero. An IPv4 tunnel socket bound to
a specific address (e.g. fou or geneve with "local") ends up in the GRO
lookup fast path, although another socket may bind the same port on a
different address: GRO then hands that socket's packets to the tunnel's
gro_receive.

Check the IPv6 address only for AF_INET6 sockets.

Fixes: a36283e2b683 ("udp_tunnel: create a fastpath GRO lookup.")
Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
---
 net/ipv4/udp_tunnel_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
index a128fe85620d..29581c94fdcf 100644
--- a/net/ipv4/udp_tunnel_core.c
+++ b/net/ipv4/udp_tunnel_core.c
@@ -62,10 +62,10 @@ EXPORT_SYMBOL(udp_sock_create4);
 static bool sk_saddr_any(struct sock *sk)
 {
 #if IS_ENABLED(CONFIG_IPV6)
-	return ipv6_addr_any(&sk->sk_v6_rcv_saddr);
-#else
-	return !sk->sk_rcv_saddr;
+	if (sk->sk_family == AF_INET6)
+		return ipv6_addr_any(&sk->sk_v6_rcv_saddr);
 #endif
+	return !sk->sk_rcv_saddr;
 }
 
 void setup_udp_tunnel_sock(struct net *net, struct sock *sk,
-- 
2.56.0

