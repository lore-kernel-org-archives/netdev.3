Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF5E388E40
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 14:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785940346; cv=none; b=LcxsGAu0nY8AIeQEOkbNxNOG4FWR8rVW5IxYN+KVgZbqnjjuJIaBpFNidh8Z909p9mbEkIAS/Y9XP05eaCIgGKaU5rOugTHq1eaPHgEtw9SFdALI7MMxgBrJit3Z4pXDDLQ3e2PizvZCWPfSrYZ9k/PaAzEyO4nSqGtUuki3kT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785940346; c=relaxed/simple;
	bh=LlxQdgB1DorAKgrQFvt14w/vQjThDqUktPWrA2TwKSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tl5T0naWuLKbm0WKYqz23VcjeJkMHI4RbKv5ysfxA8Xc7pSvaCQUiRtHOYuWIb/0aefdX6868VAXjMOa/f5Wkhw5ccswnuKpGZ2zJSrduUZ2THT3fLdxAKhQSqjTcUj2eAevF2Le9gfytWT8mz2MBz6+XRn1Ch0iRLOjCiea390=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=oYGVc2c9; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="oYGVc2c9"
Received: from kero.packetmixer.de (p200300c5970b56d88Eebac4310d100Aa.dip0.t-ipconnect.de [IPv6:2003:c5:970b:56d8:8eeb:ac43:10d1:aa])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 3738EFA26D;
	Wed, 05 Aug 2026 16:32:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1785940331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IiVJdhIDEIkLfeAXrkfwyUM/mZiaFSdBYWa9q++T2OU=;
	b=oYGVc2c9UfF2k9mMuPpD0enC45RJI9ukra8sOPSNGxCw8XfbhhNeNW6smg9EFNklxpvK0p
	tBIPz6LxBxrby2jKL+Tgifk6wgvutGIyZ5XnaqThSNcAcyStGzDhTiYqAXKykZkks3tWfx
	G5jULUH2b4njeQNlGsQwWGd5dA1MytfmDqSktbit/kbQJdGDvBzeUG8mocpHQ5TC1OrGzq
	pWEFuqkiXt+N0HqYlwpP29tnjybIEd/ytOjZf5paWmf6Hk6vDwKNlATn9E/EPivUVNonLb
	I/kk7FFZ1K2I/lA5Mh6g9bcr9mCJe3YMj+9K2T8NuilEtkPaNEUZVXAtuKRYVQ==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 09/10] batman-adv: correct NET_RX_* NET_XMIT_* confusion
Date: Wed,  5 Aug 2026 16:27:23 +0200
Message-ID: <20260805143200.722098-10-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260805143200.722098-1-sw@simonwunderlich.de>
References: <20260805143200.722098-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sven Eckelmann <sven@narfation.org>

batadv_recv_icmp_ttl_exceeded() is a receive function. It must therefore
return NET_RX_* and not NET_XMIT_*. And batadv_send_skb_to_orig() is an
xmit function and is returning NET_XMIT_*.

This doesn't change the behavior because both NET_RX_SUCCESS and
NET_RX_SUCCESS are using the same underlying value (0).

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/routing.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index af0543a4d346c..6442f5d0cc937 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -341,7 +341,7 @@ static int batadv_recv_my_icmp_packet(struct batadv_priv *bat_priv,
  * For traceroute-style ICMP echo requests, send a TTL exceeded reply back to
  * the source. Other ICMP types are simply dropped.
  *
- * Return: NET_XMIT_SUCCESS if the reply was queued, NET_RX_DROP otherwise
+ * Return: NET_RX_SUCCESS if the reply was queued, NET_RX_DROP otherwise
  */
 static int batadv_recv_icmp_ttl_exceeded(struct batadv_priv *bat_priv,
 					 struct sk_buff *skb)
@@ -382,8 +382,8 @@ static int batadv_recv_icmp_ttl_exceeded(struct batadv_priv *bat_priv,
 	icmp_packet->ttl = BATADV_TTL;
 
 	res = batadv_send_skb_to_orig(skb, orig_node, NULL);
-	if (res == NET_RX_SUCCESS)
-		ret = NET_XMIT_SUCCESS;
+	if (res == NET_XMIT_SUCCESS)
+		ret = NET_RX_SUCCESS;
 
 	/* skb was consumed */
 	skb = NULL;
-- 
2.47.3

