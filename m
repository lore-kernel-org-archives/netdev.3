Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922AD26C385
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 15:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777042816; cv=none; b=lm23BcVR6ICtBugVrwDCvi3Pg6Y5gwfrZISsmhDow+4P2T0lVq1tCFWsY1+jU2xtYSiiwJ85tbko8pLuoOtUn/+Yn94Eas45uth3sxeEt+RLgNVt1sj7qlr2dAqrDbepuDuh9qSZIKT4iQPdm4iBAdchKvpranPMkTbsFZ5vezg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777042816; c=relaxed/simple;
	bh=KnV8A7uoQR7tKKdLB+y/zBG6+2zJeX6PqGeDf3dd5so=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tunw78J6cBHpKhoTITY6RUODhYyzDC9fclos4ZaJ+Q+BRe9UlOonTYwOEb6DWzAuKv2WjvkT9qSDgUtMBFuCrBCH2s8pJFJLX3e1CbVISzPw8oZumCcOW418aPiVCVEXDbaGFZrFoa28Et+9CJERxvEG/peGnA/++ka5ak4nqus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 4213560425; Fri, 24 Apr 2026 17:00:11 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	horms@kernel.org,
	kuniyu@google.com,
	idosch@nvidia.com,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH net] neigh: let neigh_xmit take skb ownership
Date: Fri, 24 Apr 2026 16:58:38 +0200
Message-ID: <20260424145843.74055-1-fw@strlen.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

neigh_xmit always releases the skb, except when no neighbour table is
found. But even the first added user of neigh_xmit (mpls) relied on
neigh_xmit to release the skb (or queue it for tx).

sashiko reported:
 If neigh_xmit() is called with an uninitialized neighbor table (for
 example, NEIGH_ND_TABLE when IPv6 is disabled), it returns -EAFNOSUPPORT
 and bypasses its internal out_kfree_skb error path.  Because the return
 value of neigh_xmit() is ignored here, does this leak the SKB?

Assume full ownership and remove the last code path that doesn't
xmit or free skb.

Fixes: 4fd3d7d9e868 ("neigh: Add helper function neigh_xmit")
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 could followup in -next to make it "void", existing
 callers either ignore retval or do:
 if (err)
 	net_dbg_ratelimited("%s: ...

 net/core/neighbour.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index c56a4e7bf790..5a9cc7268521 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -3211,8 +3211,10 @@ int neigh_xmit(int index, struct net_device *dev,
 
 		rcu_read_lock();
 		tbl = rcu_dereference(neigh_tables[index]);
-		if (!tbl)
-			goto out_unlock;
+		if (!tbl) {
+			rcu_read_unlock();
+			goto out_kfree_skb;
+		}
 		if (index == NEIGH_ARP_TABLE) {
 			u32 key = *((u32 *)addr);
 
@@ -3228,7 +3230,6 @@ int neigh_xmit(int index, struct net_device *dev,
 			goto out_kfree_skb;
 		}
 		err = READ_ONCE(neigh->output)(neigh, skb);
-out_unlock:
 		rcu_read_unlock();
 	}
 	else if (index == NEIGH_LINK_TABLE) {
@@ -3238,11 +3239,10 @@ int neigh_xmit(int index, struct net_device *dev,
 			goto out_kfree_skb;
 		err = dev_queue_xmit(skb);
 	}
-out:
 	return err;
 out_kfree_skb:
 	kfree_skb(skb);
-	goto out;
+	return err;
 }
 EXPORT_SYMBOL(neigh_xmit);
 
-- 
2.53.0

