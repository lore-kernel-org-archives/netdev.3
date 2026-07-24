Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981DB197A7D
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 07:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784878146; cv=none; b=N2fV8psGwBGvZe6yqIJMQ8nLRYcSbAWT+ZLOgSWNLMVlZVc32k/QNgCPxjPCDBD3BZtsCa/N+pF4/QF/KIxCj+uXDmRpAg2206p/c8fshgD6tU4eEhrRquZDfF2R+7n0rrt18fEh8xzC3w90VpY45i1OIzrZCsPdheD/RHzPCl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784878146; c=relaxed/simple;
	bh=PVmqEV8OoLJRE3torQb3j7ZZiw9tfu4My95xIXEc/6w=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ABDADabvmE/sMDPCvtvxFSbk7L7W96cvVlocOCzJVOqHxfbImUjPYkNLzZ9Wmance73Z/RTGun/4dGpDs9/GKKieZGWjVXkZDZbsXAIU/17rP6rEHGNK3Mh11nlWsZMEFufl4gUk+z+IndDbs8mw2vRXe+ujNbRC9x7r+XGGhGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aRXWsZvj; arc=none smtp.client-ip=209.85.219.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aRXWsZvj"
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-907c59bd65aso1709466d6.0
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 00:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784878143; x=1785482943; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7iJXdq+DSuXbUdJyWoUr65+HbSNotKNdPkajkEQh/N8=;
        b=aRXWsZvjlT6QBQGHbV3YcKvPjSpo7CunWYbqJnADixBKr7CxirZ6a5rHVCJJqeSyMb
         Sa8Bdy+CQzKgJdVxsCfi16hCg1d3ATZOBB5+LC2ZBqO1zYE7fFNsyjgt/ha19YI8Xmlz
         zVBgo6wl1YFp1aoRIyr5iEI4m5VGBLWQa8vMCrKu3S2RdsmAburEsS2gS1Nbd8wOC5ld
         70xgq76k41yUgkCb9OhD+9zHri7LSvZNEqP278v9RZ9sH+AC500y4xrTSCQyBsN3YFno
         IR2NB/MTH0edpGPHiO9wVBS+dYzw5RxPjk8yITDwwzh2xrUO+jMrXBe0hcogKWuQSguk
         sa2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784878143; x=1785482943;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7iJXdq+DSuXbUdJyWoUr65+HbSNotKNdPkajkEQh/N8=;
        b=p1ioSFxg+988IBlEyPAzEDAGVxAp6Mo3ANYU9B+D3kO9ucwcuK6FWs4Y2yc5V0VHLV
         KUCtkQrqEOomPIMw6h36qSWJhhEOLPr2k6d8I11Y9BN8mcVR/k6Hd4RvyCbB5o4dgXh+
         uwJIbsExP3u8tmmpXR9k+DgGOj2ZrPsm+15oOT0hs+p3fYRRZIePhffTpaQTbA7O+AY7
         1Hm+Vv1CI7s1Tc/st3wVs1rm+YrisVF+h8HJ2rRTVt3YTve+5tiMVn8IxkD+8+UgcFji
         KRawh011iddA5lcx6NiwTJJD36sD6uqh0dQIAQLSOczthT72OIIome84aIsa14wMFozL
         Mjcg==
X-Forwarded-Encrypted: i=1; AHgh+RoUeUWDoQmO6FzWWAXy2hZBWu19VzFn3Jg51JifRJ1UavoIYZzOES9O83MWp0gOU00CuG/5Dpg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj6itwmctEaTgvpNX3uMRmxRKNDBndQkdT9s6xFu8ZOeBkwGSI
	WABAsCnXX0Yc5Bi9VguDQoAT0CiD/wBuV/iwB2Xjli/KMjCqyQbxkZelQN7QL5VqI2j7bkWQE4I
	63zBbuhb8TBArEA==
X-Received: from qvbkl23.prod.google.com ([2002:a05:6214:5197:b0:8dd:56be:3c59])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:2f8c:b0:8ef:a9ed:5e9b with SMTP id 6a1803df08f44-907ca6686e7mr65046336d6.55.1784878143145;
 Fri, 24 Jul 2026 00:29:03 -0700 (PDT)
Date: Fri, 24 Jul 2026 07:29:01 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260724072901.1633601-1-edumazet@google.com>
Subject: [PATCH net] net: do not send ICMP/NDISC Redirects when peer
 allocation fails
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

When inet_getpeer_v4() or inet_getpeer_v6() fails to allocate a peer entry
under memory pressure or tree size caps, redirect handlers previously fell
back to sending un-rate-limited ICMP/NDISC Redirect messages.

In IPv4, ip_rt_send_redirect() called icmp_send() directly when peer == NULL.
In IPv6, ip6_forward() and ndisc_send_redirect() passed a NULL peer into
inet_peer_xrlim_allow(), which returned true when peer == NULL.

Because ICMP/NDISC Redirects are not part of the default global rate limit
mask (sysctl_icmp_ratemask), sending redirects when peer == NULL creates
an un-rate-limited ICMP packet storm.

Fix this by failing closed in ip_rt_send_redirect(), ip6_forward(), and
ndisc_send_redirect() when peer is NULL.

Fixes: 92d868292634 ("inetpeer: Move ICMP rate limiting state into inet_peer entries.")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/route.c      | 2 --
 net/ipv6/ip6_output.c | 2 +-
 net/ipv6/ndisc.c      | 2 ++
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 3f3de5164d6e5854cae3ebe6fcecbac10fb63418..152d8cb28f65aacee378521e16885c9cf1a4870e 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -892,8 +892,6 @@ void ip_rt_send_redirect(struct sk_buff *skb)
 	peer = inet_getpeer_v4(net->ipv4.peers, ip_hdr(skb)->saddr, vif);
 	if (!peer) {
 		rcu_read_unlock();
-		icmp_send(skb, ICMP_REDIRECT, ICMP_REDIR_HOST,
-			  rt_nexthop(rt, ip_hdr(skb)->daddr));
 		return;
 	}
 
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 368e4fa3b43ca2a96f53fa4f3bc14fd6832c346f..2c44e5ed617167ce060c265052cd40449fdab69f 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -641,7 +641,7 @@ int ip6_forward(struct sk_buff *skb)
 		/* Limit redirects both by destination (here)
 		   and by source (inside ndisc_send_redirect)
 		 */
-		if (inet_peer_xrlim_allow(peer, 1*HZ))
+		if (peer && inet_peer_xrlim_allow(peer, 1*HZ))
 			ndisc_send_redirect(skb, target);
 		rcu_read_unlock();
 	} else {
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index f867ec8d3d90510c1ed92012c3b34ab8b49c9ac7..fe36b3f512850369e138b6a99ae7a9391494c2f1 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1707,6 +1707,8 @@ void ndisc_send_redirect(struct sk_buff *skb, const struct in6_addr *target)
 	}
 
 	peer = inet_getpeer_v6(net->ipv6.peers, &ipv6_hdr(skb)->saddr);
+	if (!peer)
+		goto release;
 	ret = inet_peer_xrlim_allow(peer, 1*HZ);
 
 	if (!ret)
-- 
2.55.0.229.g6434b31f56-goog

