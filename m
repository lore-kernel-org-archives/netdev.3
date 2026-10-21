Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792599543;
	b=K1H46L+wnhRkQ2CnL+58mLacNsA3za9XyziVXFEyIUgUtEsjaGvQHazlR81Q8L7fe54p
	 XvLpMQ9zK2YVmioSxW83xA6zyGK/nJDWrwFArSEuN6K/Gq9Y24rZhQ1nBwQe5miNJo9wj
	 cSZrnWNQLUu6FSRYo6hEsYNuCWyVbGYNqqgozOssrRavKRMgVkRFKieVwpFnLxriRUNG9
	 ApGvQpdZl1HIUExCiY37mUcWbO+oxNMUptv+IMmAoZznO7cwSiqVyDXIEUMu6okWMdM/h
	 NwIihgfOS9bSrXrDT08/mQiPbrMLoiOnVEm63UbG+OunxVj57x8SGzAXRRTMTQ+IQGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792599543;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=bTFRat1kaLwkzHwyX2T4Q0ifC4xWLlRMWhFMUR5V6Vo=;
	b=WnjgwulLeZ6GRLC5zZ0ZgQgywODjG6t5sqqhjTQvB4dorIlMtQU4cdJjJFCvn4nH6i0f
	 G4/nXFfONo7Ko1HM++tqBLlHEmiu4wZBtuwYvvFQ/p6bSWA3VpMvjJyONTXg7jPh/htWP
	 YHKrI/LUA2GIWbth6SC3ExsYRMXpGESLXiGl4fXQOSl6WOhiYkmYxiASxq05BWR91rvri
	 txpImaVDskAwMvTavvwzOCMiq1CKOzy7STea60PeCpnPiYOT3+FY7UYLiXDpvPaYBQBwk
	 wRprm5UIvDHsjAKfP0wlV4VOreyG7UpAq4Lv/Y2jMG9QziVXc9rDo/wtEI/wheaA9ZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A8BrN0+C;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D15A606CD48
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 16:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A8BrN0+C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37E9B1F000C1;
	Wed, 21 Oct 2026 16:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792599543;
	bh=bTFRat1kaLwkzHwyX2T4Q0ifC4xWLlRMWhFMUR5V6Vo=;
	h=From:To:Cc:Subject:Date;
	b=A8BrN0+CDRoMuGopTTf1X6xk9hveMjKm2Ea7dSzSMb/F5srby1HRL2JCQHqCoNFT9
	 knrbUu9ymOAXLxLLhK1s/cLOUxHsZcnHC8AGHZN36v39dVLgzLOlAnhETSMCrs9L8S
	 45Z0LNP4Qtx5/SsQ2+wU5sPmLyCeWdTXK5DcFhROoC9qNtJkKXcyMM5b/q8mz3h4VR
	 +nvTeFr2o9WGL9bKZOAim34eA/pEDEMV8EOMRuETRJSYu6HFRjyab7SbmHTSG2tQuI
	 Ve+J5mrq0QGj/Q63GXKjlRPLswzGV1p237BkMruYiJvmLz9GDsRksz/GS23YnQ1Fo5
	 LteTEI8XwvZow==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Eric Dumazet <edumazet@kernel.org>,
	Simon Polack <spolack+git@mailbox.org>
Subject: [PATCH net] net: fix frag_list leak in skb_segment_list() error path
Date: Wed, 21 Oct 2026 18:18:58 +0200
Message-ID: <20261021161858.761205-1-edumazet@kernel.org>
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

skb_segment_list() detaches the frag_list from the head skb and moves
its members one by one to the skb->next chain. On error, err_linearize
frees that chain with kfree_skb_list(skb->next), relying on the members
not yet processed to still be linked after the current one.

This does not hold when the current member was shared: it is replaced
by skb_clone(), and __skb_clone() clears ->next. If __skb_linearize()
then fails on that clone, the remaining members are no longer reachable
from skb->next nor from skb_shinfo(skb)->frag_list, and they leak.

The skb_shared() error branch already relinks nskb->next to list_skb
before jumping to err_linearize. Do it unconditionally right after nskb
is added to the chain, so every error exit sees the remaining members.
On the last member list_skb is NULL, which still terminates the chain.

Fixes: 53475c5dd856 ("net: fix use-after-free when UDP GRO with shared fraglist")
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
Cc: Simon Polack <spolack+git@mailbox.org>
---
Bug discovered while reviewing at Simon Polack upcoming patch in
skb_segment_list()

 net/core/skbuff.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index ab178af02a2262d65175daff7f093c85eaa09c92..beddbf6812b9f387672c7ab5f0a1c07ab9bd0806 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4734,10 +4734,13 @@ struct sk_buff *skb_segment_list(struct sk_buff *skb,
 		else
 			tail->next = nskb;
 
-		if (unlikely(err)) {
-			nskb->next = list_skb;
+		/* nskb may be a clone with a NULL ->next: keep the remaining
+		 * members linked so that err_linearize frees them.
+		 */
+		nskb->next = list_skb;
+
+		if (unlikely(err))
 			goto err_linearize;
-		}
 
 		tail = nskb;
 
-- 
2.53.0

