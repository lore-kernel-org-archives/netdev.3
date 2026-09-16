Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97AD4EE85A
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 11:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789557621; cv=none; b=udWdqlsTZo7wO4lnJXa0ILen9GYKX69tqfVYCTTnQzBb0CRLOY0BfIXFaBZFdNPmzUreGSRLAjY73/b37hWT4rDThB6HAs9Fy53Nv/bKX8WrUSUueNcev6IMKGLg6nFJnl7lMOIKsHyx3hnx47Xe5rb6SrnmrnYI1GNw4eECyG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789557621; c=relaxed/simple;
	bh=pD1Qjfy3YK5HT8O7+5FJVkc5BQauYgWN7lb05n6HNyA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QOz0WkJeDmNFsXnQAUnmaGQcJ3GjPlrkIules3HHzMXVo8gn6TG6Qgui4BTOenpOuGJYKRzrs3/HzGD4Aq7xMF+MbCmhxSuaKuv8/48CKrv0wgLJUgnlHhS+wSAVA1enU7q/U9Kc+boVW8JD5v0vEeyKJgGY3FQse8fIDV1YZUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XXrFjHpp; arc=none smtp.client-ip=209.85.160.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XXrFjHpp"
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51bf321d786so51395581cf.1
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 04:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789557595; x=1790162395; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ht2l1sqPcHDVC/hiYH33iQJTJjceFolRyzCr9EciCtI=;
        b=XXrFjHppqqJpdTxTlb5C5Hd1wAeTSFs4yv7Vd3gB5QB41icOEfX4TMCy8Nf1zKjrD1
         RGJpOFvblXnaD0nrktlLO6JrmvkuarOBRYu2ZJEDUMh/pyakipHYINfLL74x0B2yC+Xt
         9GMZCfOGBli6QnMnCGgXt98f17T5JHzxpkIOVV5hv7E9NVyklQ7YffKx4B5+n0RelWfS
         fG/qNYPtLGF8jyVFp376I8+1VILXFoJWhMM4HK7R09ZQCpP5w774VWTNgIRwH6WB4UrS
         diPCEfutiz8x1YgtZlg0EjId8uW1C62STwGjJ3TcoBu8EF7PkB13jahukRrl2N/lr6f2
         DOFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789557595; x=1790162395;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ht2l1sqPcHDVC/hiYH33iQJTJjceFolRyzCr9EciCtI=;
        b=x1hljFUsEVZv0gx5VDeTjaNCJAZ8LSiMjlcEyOlNcFFC7ZNTZXc7MraglfDR7Ft0JE
         D3mWx/j0ztbgVa2iQuAZSpIgYJ9ZTmgUkdbmpm46lbefZd/Z7+4XxixnCwJVeMlv8zUT
         H3g7GdMQd6/6gImcUDj40g4Z04PDCL+EZBTHaLBzagpvluJLQDFcDXowfoDtvOe4qORv
         PxG7f3OoDYrvP8IHZugjXhfhjoFxZNFeTe2cL5EsY5j/1aipDG7gpIwOvcTwxHWFhEhJ
         v5psqFRIO1xr0NN6A3x3TG8BX8KkIgwHJdwPB9bP1mpZc8I01g8k3iB6FBcpcSFp5oG7
         t5oA==
X-Forwarded-Encrypted: i=1; AKwUvBw9ll3Pthfpyywe2NaeZqn7JkN2MzAzNDcNpIZZ2WmQs2QF42GIWqh1j6vKjRB3KJYer0HwBwM=@vger.kernel.org
X-Gm-Message-State: AFuF++n+XgV6lgh4qE7/hu9RlTSeyorjrutDD5rfGmcSK3w+ohyR+NaH
	4EO2pcKII8wi2jl8lcTUB7vp3OQ98mi1+mTQeaR9yZWeNba6hki2fvnaASPFLFmrK6tGh3LVTuG
	TMAOa2HfFew6P6g==
X-Received: from qtbnu11.prod.google.com ([2002:a05:622a:7b8b:b0:530:e97d:1ea])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:6f11:0:b0:531:cbe:d53c with SMTP id d75a77b69052e-5327eeb8437mr34205831cf.35.1789557595004;
 Wed, 16 Sep 2026 04:19:55 -0700 (PDT)
Date: Wed, 16 Sep 2026 11:19:53 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260916111953.1611574-1-edumazet@google.com>
Subject: [PATCH net-next] netkit: no longer rely on RTNL in netkit_fill_info()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Nikolay Aleksandrov <razor@blackwall.org>
Content-Type: text/plain; charset="UTF-8"

netkit_fill_info() used rtnl_dereference() to fetch nk->peer,
and thus required RTNL.

nk->peer is already an RCU protected pointer, updated with
rcu_assign_pointer() and read from the fast path with
rcu_dereference(). Simply use rcu_dereference() under
rcu_read_lock() instead.

While at it, use READ_ONCE() when reading nk->policy, because
netkit_change_link() can change it at any time (it already uses
WRITE_ONCE()).

Other fields (primary, mode, pair, scrub) are only set from
netkit_new_link(), before the device is visible to dumps.

Also add missing const qualifiers.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Nikolay Aleksandrov <razor@blackwall.org>
---
 drivers/net/netkit.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index a3931cd821321c3e4888edf86efc414199127bcf..82e608e733d9ee70f71c374570211c73da76ae2c 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -1209,12 +1209,12 @@ static size_t netkit_get_size(const struct net_device *dev)
 
 static int netkit_fill_info(struct sk_buff *skb, const struct net_device *dev)
 {
-	struct netkit *nk = netkit_priv(dev);
-	struct net_device *peer = rtnl_dereference(nk->peer);
+	const struct netkit *nk = netkit_priv(dev);
+	const struct net_device *peer;
 
 	if (nla_put_u8(skb, IFLA_NETKIT_PRIMARY, nk->primary))
 		return -EMSGSIZE;
-	if (nla_put_u32(skb, IFLA_NETKIT_POLICY, nk->policy))
+	if (nla_put_u32(skb, IFLA_NETKIT_POLICY, READ_ONCE(nk->policy)))
 		return -EMSGSIZE;
 	if (nla_put_u32(skb, IFLA_NETKIT_MODE, nk->mode))
 		return -EMSGSIZE;
@@ -1228,13 +1228,18 @@ static int netkit_fill_info(struct sk_buff *skb, const struct net_device *dev)
 	if (nla_put_u32(skb, IFLA_NETKIT_PAIRING, nk->pair))
 		return -EMSGSIZE;
 
+	rcu_read_lock();
+	peer = rcu_dereference(nk->peer);
 	if (peer) {
 		nk = netkit_priv(peer);
-		if (nla_put_u32(skb, IFLA_NETKIT_PEER_POLICY, nk->policy))
-			return -EMSGSIZE;
-		if (nla_put_u32(skb, IFLA_NETKIT_PEER_SCRUB, nk->scrub))
+		if (nla_put_u32(skb, IFLA_NETKIT_PEER_POLICY,
+				READ_ONCE(nk->policy)) ||
+		    nla_put_u32(skb, IFLA_NETKIT_PEER_SCRUB, nk->scrub)) {
+			rcu_read_unlock();
 			return -EMSGSIZE;
+		}
 	}
+	rcu_read_unlock();
 
 	return 0;
 }
-- 
2.55.0.1032.g73a4cd73de-goog

