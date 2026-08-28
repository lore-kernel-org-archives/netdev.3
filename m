Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2219B39CCF5
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 10:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787913455; cv=none; b=E5cIAbPex5p2NUJpJL8a1Ce2Jwf6r+qOX1mRJjUp9GANCLA2/7wDUYcol8Xa0kfyGb4DbjWVQnuUmpJyAcKoueBQkWK0UOlyq9WGuaf1Ni0a3xqz8xg7eGYwY/7ag6JyLsLW79fM3fizXBnUTp9OEemNVyOQf9CRKLU4MDB9uP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787913455; c=relaxed/simple;
	bh=kUW3fvyaGANUkRLTWk1wYXfguf0IF6wpJyXGPQLT8jo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=n2vsoASWTEfVJFed4Y4tCPWMwjrpdcfkX6L5hFzCEuOOXMD9X+UA+O9U6MAaxT9A7QFGbx512VRF81aPSEPTfAfO7AklQcjRgQw/kfXjYOPiXO0zSmhRcmNq8UEOseR7/jYal/b4je/eSpukmpBdDA3nU9GMw7Z8SeDQ/TLZl8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qeCsgCOH; arc=none smtp.client-ip=209.85.160.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qeCsgCOH"
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5283df62d68so10097531cf.0
        for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 03:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787913453; x=1788518253; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=R5N9ljdI5LaI4IAeXfkXVk6QC6oBvuKEbeYj/j3Ju5g=;
        b=qeCsgCOHfWUL702RjFDPcZbHgLmqG4WLljpETEYKTHN40uFIJytqT3EgygH7f94TpU
         giZJvfkGOeA0bMoRstVQoHBgefpPWSoHHZIuNHCBuew6w5K49ESq/6eODznM3ac8pMR5
         s/jE2PuQ3/x9M5OXUgwE6ZdvIUmo53VyTJ/ubWz4j3VsIHV8BFpcM7dlEBBGciqrzihY
         dROmBPVblWlZEFHR2P2SU00g8B8dPuSWy8MOcA5ja2dhgtIn5OzD1OJErSEcY5Tld0oo
         rv5RYSEn4lHxI4EvVxWDxEqBPEPkpb0B2bBYoj3uEsbQktHZxXjQAOuQvbk10pm6hyYX
         +skQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787913453; x=1788518253;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R5N9ljdI5LaI4IAeXfkXVk6QC6oBvuKEbeYj/j3Ju5g=;
        b=Sxmwigk17EbukA4TL9/NFHj5d4XmmgOD39px/aKkyowgSwwfu+aRMmDV5rCamW5GKD
         e2Dh/Wv35fN8EvAmXRVOg66Mo/8BvsNdeHt2sgBC4qiqHLs3alr/OldEVyF1y5D6yEZ+
         glCD4w5a7xCHk1WVCNm32XrhQxjbs2A7eyLpw1F3EQVWwkMljD9GD8F3IlVvE6zZ7nLl
         gVhqU+xhyCy21nkBXqKvvEMOzgR8ZE6iMatCsGQ6EQ/33BAyyqxaGgHlNT/nTfxC5xg5
         AoCZZSHmv51fAIeuIjUM32dHyeB3WtF0PiA3mO+VyekhdYdgPetfyQuHFb5FZrN4ViLD
         l2pg==
X-Forwarded-Encrypted: i=1; AHgh+RqToBkhm+GuGLUBapariirOEsmBdxrNDbEvRrrbwT6iV5W5vkz6ZtjmxEIpmCJJvOAsydJzneA=@vger.kernel.org
X-Gm-Message-State: AFuF++kDAVr3K42OStAuVPc+dnfb9aZdkf1V7EXaZNNrrVsWnceuvfjc
	ZnQj9wH68TuDSsSYzCVlJ61p5Ya5hDh1bEuz4EYUbQZIos1y0TXSJqX5ZSSo+cm9qq3lAhGWR+x
	nb8V50+0H7bJFiA==
X-Received: from qtg25.prod.google.com ([2002:a05:622a:d19:b0:52e:e495:cfa6])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:1905:b0:527:631:8d6 with SMTP id d75a77b69052e-52fb95e8d28mr66110761cf.25.1787913452705;
 Fri, 28 Aug 2026 03:37:32 -0700 (PDT)
Date: Fri, 28 Aug 2026 10:37:31 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
Message-ID: <20260828103731.1951815-1-edumazet@google.com>
Subject: [PATCH net] ip6_gre: check tunnel info before xmit in ip6gre_tunnel_xmit
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Shuangpeng Bai <shuangpeng.kernel@gmail.com>, 
	Davide Caratti <dcaratti@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Shuangpeng Bai reported a KASAN slab-use-after-free in
ip6gre_tunnel_xmit().

The precise KASAN bug was caused by ip6_tnl_xmit() consuming the
skb during headroom expansion and returning an error, while
ip6gre_tunnel_xmit() still held the stale pointer and called
skb_tunnel_info_txcheck(skb) at tx_err. That specific bug was fixed by
commit 87f21b59ddc6 ("ip6_tunnel: use skb_cow_head() in ip6_tnl_xmit()").

However, calling skb_tunnel_info_txcheck(skb) at the tx_err label
after the transmission attempt remains problematic:

Downstream helpers like ip6_tnl_xmit() call skb_scrub_packet(),
which drops the skb's metadata_dst before transmission. If an error
occurs later during transmit, inspecting skb at tx_err sees a scrubbed
dst and misclassifies tx_errors vs tx_dropped.

Commit e5f7e211b6aa ("ip6gre: avoid tx_error when sending MLD/DAD on
external tunnels") already handled this correctly in
ip6erspan_tunnel_xmit() by checking and caching tun_info before
transmit.

Align ip6gre_tunnel_xmit() with ip6erspan_tunnel_xmit() by caching
tun_info before xmit and checking it at tx_err.

Fixes: e5f7e211b6aa ("ip6gre: avoid tx_error when sending MLD/DAD on external tunnels")
Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Closes: https://lore.kernel.org/netdev/20260819062224.3197349-1-shuangpeng.kernel@gmail.com/
Cc: Davide Caratti <dcaratti@redhat.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/ip6_gre.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 69c51f1a5bf08b912a4efd1969d3b0ac5df5aa02..8ebda0b6a78b2236b439f5499d84f34f652fcbe2 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -878,6 +878,7 @@ static int ip6gre_xmit_other(struct sk_buff *skb, struct net_device *dev)
 static netdev_tx_t ip6gre_tunnel_xmit(struct sk_buff *skb,
 	struct net_device *dev)
 {
+	struct ip_tunnel_info *tun_info = NULL;
 	struct ip6_tnl *t = netdev_priv(dev);
 	__be16 payload_protocol;
 	int ret;
@@ -888,6 +889,9 @@ static netdev_tx_t ip6gre_tunnel_xmit(struct sk_buff *skb,
 	if (!ip6_tnl_xmit_ctl(t, &t->parms.laddr, &t->parms.raddr))
 		goto tx_err;
 
+	if (t->parms.collect_md)
+		tun_info = skb_tunnel_info_txcheck(skb);
+
 	payload_protocol = skb_protocol(skb, true);
 	switch (payload_protocol) {
 	case htons(ETH_P_IP):
@@ -907,7 +911,7 @@ static netdev_tx_t ip6gre_tunnel_xmit(struct sk_buff *skb,
 	return NETDEV_TX_OK;
 
 tx_err:
-	if (!t->parms.collect_md || !IS_ERR(skb_tunnel_info_txcheck(skb)))
+	if (!IS_ERR(tun_info))
 		DEV_STATS_INC(dev, tx_errors);
 	DEV_STATS_INC(dev, tx_dropped);
 	kfree_skb(skb);
-- 
2.55.0.897.gb25b4bd76c-goog

