Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792636005;
	b=j0C4f84+Smsx10ft3xf8Kd3D1A7C4yvfbMaTkpgge31kvPAboWZO4XPw4/mYnc9bP/M+
	 rpGh77NjrzxRP6pTpCok3OaA1KKjxbkX2CRJLuzWDEmb1VTdjp1WQQWl/akquKcygqrXF
	 zUUinXozfl27ikUzayhBZ8r0BYhpTX4V7OCBn//h1MD8XU5vd9NhTabaDa1HVFgqsDTNd
	 UdLLn3cPiY1OGCvG7UL2M9JjnqrLUhuRao7pSwp2MvqOd1Qiu5GHx+SNGRpe9dJ7J45gu
	 m/awT3+Jp6f37nVkYFY1e1wYN3UrzPV4LEPvvBixNwahaNzOxm34nCfMySxpMDjQWIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792636005;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=NmZHEWlQZjYjTV2Jiiaxgc5qSyoqK4bbRrly0szFWi8=;
	b=1gap8SAlVFZJwygMBPbnc/EfMPS4taupCzTQm+BysdJcTxA3TOfAlS7YIlRKsKVTyFlB
	 6V26WkY9u6YmwxF4diVe60CQ+F+4DSRtyZ3cXzi3RzLaRPQt8s60jfAqn7BLiqPgXu/gf
	 O858jpO/HMqEf7s9AUWQGuImtVSnZEliTWK0zaVFqsv58CyI5J1gQjGdjjtLQmjYqrA+j
	 FYKY9yElLypYKpWHvM7NQUQW31ZJwxMGrsKVnsAdXHkVX4oRIAnaibbwg4ndmUq3UxRCr
	 gjlpUea06EgNwvmWY5mHcN3HXKv8mQJxLQt/zyzqjS4fuwyz9jaR+JqVSARUZ2QquJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rrxUfOgd;
	arc=none smtp.remote-ip=209.85.215.170
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC35606A319
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 02:26:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FC35606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rrxUfOgd
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cd633ef819bso535483a12.2
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 19:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792636005; x=1793240805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NmZHEWlQZjYjTV2Jiiaxgc5qSyoqK4bbRrly0szFWi8=;
        b=rrxUfOgdd/PL37RrqPELxylj88nYDj3VAUPLHKoPPzQ+MP6R6NzMt5vUV57umIhrGG
         muOt+sfD5Q7rGOxABrbR20O+sTVM5evE66YwnaQj+OUgIk97qADyNcOqo/SupoGLpZpr
         7dozEl2Jk9Sg9PDEwlFHrNou65zuYCXxM2xbqDL0GzUJqVQQcWpt71Vx0W432RcfOk4y
         2omlcbXEB2rM2fhjnNkehPRfxS97qHphcdQVHPYnIhXmVIKsogX5WL1UaZZXM1OwVd1S
         tbLPRnJD7StmnZTTOqLMlUQGvuhOIUP0s0ftOJc5MEgQX01vpw3XJlVt9zOCwHyQa/4m
         g89A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792636005; x=1793240805;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NmZHEWlQZjYjTV2Jiiaxgc5qSyoqK4bbRrly0szFWi8=;
        b=fLOHHEpv/kqWS+iV9XG5yp9ttUEiu9kuCjXLdlh6e/IN23ICggmF3VN6kF5lyQXMR2
         hZDyEOmys7kK+jzRuRbuuMeE5P4u0W1BKGIQofTQsuoyn9FSa8ZzGRG7HaeCaqiAFS0X
         Rmt8gFBNH5QDFXykHGmQiu+p64O8QXmPHteWwEXsJpcJMuUZkbKc3LBiTvpnsU18Ydaa
         RIJ91xrLP/0+g/m+X2ASYUylxzBM/9S1vMRZO50hvNn+Xoso2rkN8Y5fxMfx0OuCxEx8
         J3T6Qe8MZQ26iz+FrhavnbITgPmYk20NqeBhpu+q9t+WfbHVXrp5qA8rgsiC4avTT/HQ
         IAXQ==
X-Forwarded-Encrypted: i=1; AKwUvBzkQxrglfV1WWqKSDF23JpH3epc3JkiR2D6HFMFeC8va5Tm6XoHSOBEzIeFL+DAllBVe+QXZeM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLVl4+saQSJ2IobeLCzxniCk2ThgdXedX3FgtIrZ8fQbuUz2jHm
	5CyT85B+jAUYDVwBAW3MOglIJp5fHdyJxi4l0uWXjGpyTxF1MrYIKGM/
X-Gm-Gg: AYBFou17Wf2Ey7GF54j8XZEOlvGtlLFuZ6v6U+cPjf79G4NuieuSvVfXPZ+8OL01hgQ
	g0c1RZk97rfDl/Brpowoi3xf8A88ZDoSe3w0lgu8CB7ZI/P1nujWG2GLcqkQCiXBng27J/Swu8p
	kOFC6atCockeMCz8WwAewzT2L+LdMMDfZw+/xuRqBgzCOSVR1VAhs3nS3YU+DgvEzRh9afdbRRm
	p56iB+XRF7kJBlUzH3XR3xlePc/QUtekOh8jYtQ6Hu9tILqimkFznsGX1FuCIBk1Pe4Mvoa0LQ+
	aDgRMT9yhQyhO/vyln/P0kgwIbpQcvU6beML6CUkZIRyAg4rfvyk+XQgHHcFhpBOSp7i0pdzHts
	oFiXQHjLIxCrWE+U+JeQNZRxVXm7qN53g1sLBWq5I6vkITrhZtTW7vaJ2KY0EAbpMFEGMjIrzGU
	M1KapTFL3RQVB3mZQsKMd4hiJQ0spE6tF16A85X620WpEYzPOygDhxBYycWwRJ6U2Z4rOpCG7vv
	gPECdX3K09zF9IrNXCnHwp3/f84XHpmEcO9Z8T70GH362fGL2phL70kBkxLgGNLkxo=
X-Received: by 2002:a17:90b:1642:b0:3ac:c90a:10d2 with SMTP id 98e67ed59e1d1-3ad86c9041bmr3439757a91.30.1792636004587;
        Wed, 21 Oct 2026 19:26:44 -0700 (PDT)
Received: from TENCENT64.site ([103.7.29.106])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada4896c58sm1844518a91.8.2026.10.21.19.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 19:26:44 -0700 (PDT)
From: Fourie Zhang <littleddfu@gmail.com>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Zhiling Zou <zhilinz@nebusec.ai>,
	TencentOS Corvus AI <corvus@tencent.com>,
	netdev@vger.kernel.org,
	Fourie Zhang <fouriezhang@tencent.com>,
	stable@vger.kernel.org
Subject: [PATCH ipsec v2] xfrm4: use a full socket for local errors
Date: Thu, 22 Oct 2026 10:26:22 +0800
Message-ID: <20261022022627.4132880-1-littleddfu@gmail.com>
X-Mailer: git-send-email 2.43.7
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

From: Fourie Zhang <fouriezhang@tencent.com>

xfrm4_local_error() passes skb->sk to inet_sk() and ip_local_error()
without ensuring it points to a full socket. TCP SYN-ACK skbs can be owned
by TCP_NEW_SYN_RECV request sockets.

xfrm4_tunnel_check_size() already checks sk_fullsock() since commit
1620c88887b1 ("xfrm: Fix the usage of skb->sk"), so iptfs_is_too_big() is
the only remaining IPv4 caller passing a request socket here: the sk it
tests is the listener, while skb->sk is the request socket.

When IP-TFS rejects such an skb because it exceeds its payload MTU, the
local error path treats the request socket as a struct inet_sock. KASAN
reports a slab-out-of-bounds read in ip_local_error() beyond the
request_sock_TCP allocation.

Resolve the skb owner with skb_to_full_sk() before accessing inet_sock
state or reporting the error. This maps a request socket to its listener
and rejects sockets that cannot be used as full sockets, matching what
commit 6973a21ee73c ("ipv6: xfrm: use full sockets in local error paths")
did for xfrm6_local_error().

Fixes: 0e4fbf013fa5 ("xfrm: iptfs: add user packet (tunnel ingress) handling")
Cc: stable@vger.kernel.org
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Link: https://lore.kernel.org/netdev/20260908224856.1591189-1-kuba@kernel.org/
Reviewed-by: Eric Dumazet <edumazet@kernel.org>
Assisted-by: tencentos-corvus-ai:hy4-preview
Signed-off-by: Fourie Zhang <fouriezhang@tencent.com>
---
v2 (Eric Dumazet):
- Fixes: use the IP-TFS commit
- Note why IP-TFS is the only remaining IPv4 caller
- Reverse xmas tree; add Reviewed-by

v1: https://lore.kernel.org/netdev/20261021101839.3797779-1-fouriezhang@tencent.com/

A KASAN reproducer for this issue is available if requested.

 net/ipv4/xfrm4_output.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/xfrm4_output.c b/net/ipv4/xfrm4_output.c
index 0ae67d537499..fffa3c4f456e 100644
--- a/net/ipv4/xfrm4_output.c
+++ b/net/ipv4/xfrm4_output.c
@@ -38,9 +38,12 @@ int xfrm4_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 
 void xfrm4_local_error(struct sk_buff *skb, u32 mtu)
 {
+	struct sock *sk = skb_to_full_sk(skb);
 	struct iphdr *hdr;
 
+	if (!sk)
+		return;
+
 	hdr = skb->encapsulation ? inner_ip_hdr(skb) : ip_hdr(skb);
-	ip_local_error(skb->sk, EMSGSIZE, hdr->daddr,
-		       inet_sk(skb->sk)->inet_dport, mtu);
+	ip_local_error(sk, EMSGSIZE, hdr->daddr, inet_sk(sk)->inet_dport, mtu);
 }
-- 
2.43.7

