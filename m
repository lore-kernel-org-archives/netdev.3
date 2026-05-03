Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171413B19CC;
	Sun,  3 May 2026 12:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777811002; cv=none; b=mCwqLRaUY5AL7VdPN2hSJTjPJYfAoyW7JZmYjuefMDlH24xfh/5wHiigUvWUev9k+LmjC/vt5CeJANQ0F/+D1tZuldYkJ6HM8FXRLsg9HUtVIxkJYkfQC0ynjie2NZ3bmI4zrPtwwlVenJZmfxu6dwQTElwL6sLwoXM5Ph6mLdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777811002; c=relaxed/simple;
	bh=hj/nqN5j0xZ710VI2jMwCjeM18garF0jjKOPz1zQWLQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rU2mV2mG0hwWjSoAue1NOYhuFK8gtLYp4pEgM/doRIsWlQJ2vBzJdZHrZDbhkPjT0M0s9S8A12TUxzS0xG6EQF8DLPObHNLPhRkSu/z6niNvHqWMGkLOjrZ9Dac+Ts07bM81FGPKj/dTVb8ZsZh3TJNtoyJKJQBElarlhf1EV84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=ztr/6Xkz; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="ztr/6Xkz"
Received: by dvalin.narfation.org (Postfix) id 2785A20D39;
	Sun, 03 May 2026 12:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1777810997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=samGb3z6dCDDaDRS0M76gCcHmbiT9j+PlgK7fTp49Lc=;
	b=ztr/6XkzVLBVj5yBpWQQWjYaRI64iCxnXJoVRbjTkBnBkbotlbxp99tDmugyDY/u1dXqyK
	slCNrT7Q9ER1fAFxGwNij3gFxwDEZ4NEjXURUS5LYoEKZgQ0M6bWVAHh3DytYRgNhTQKZs
	0bwqOHJREWdW5P8LVUFzcCWvZ5Em/14=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 03 May 2026 14:22:35 +0200
Subject: [PATCH batadv 2/8] batman-adv: bla: prevent use-after-free when
 deleting claims
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260503-fixes-followup-v1-2-4313278918d3@narfation.org>
References: <20260503-fixes-followup-v1-0-4313278918d3@narfation.org>
In-Reply-To: <20260503-fixes-followup-v1-0-4313278918d3@narfation.org>
To: Marek Lindner <marek.lindner@mailbox.org>, 
 Simon Wunderlich <sw@simonwunderlich.de>, 
 Antonio Quartulli <antonio@mandelbit.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ao Zhou <n05ec@lzu.edu.cn>, 
 Haoze Xie <royenheart@gmail.com>, Jiexun Wang <wangjiexun2025@gmail.com>, 
 Juefei Pu <tomapufckgml@gmail.com>, Luxing Yin <tr0jan@lzu.edu.cn>, 
 Ren Wei <n05ec@lzu.edu.cn>, Ruide Cao <caoruide123@gmail.com>, 
 Xin Liu <bird@lzu.edu.cn>, Yifan Wu <yifanwucs@gmail.com>, 
 Yuan Tan <yuantan098@gmail.com>, Sven Eckelmann <sven@narfation.org>, 
 stable@kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1274; i=sven@narfation.org;
 h=from:subject:message-id; bh=hj/nqN5j0xZ710VI2jMwCjeM18garF0jjKOPz1zQWLQ=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDJnf7WSLPHq/Tat9eD2/W3aaM+/0N6WuLBKFlwo64p4/v
 bzkUua1jlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBELIUZ/tm9sOr5sXmq1r7b
 hpclrEtOTliwdHaMQu/7gif810qWOKszMqw2TPuzWb7woVrR4o1X11yU9D35MadDyWyf+J1OT02
 tV/wA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF

When batadv_bla_del_backbone_claims() removes all claims for a backbone, it
does this by dropping the link entry in the hash list. This list entry
itself was one of the references which need to be dropped at the same time
via batadv_claim_put().

But the batadv_claim_put() must not be done before the last access to the
claim object in this function. Otherwise the claim might be freed already
by the batadv_claim_release() function before the list entry was dropped.

Cc: stable@kernel.org
Fixes: 23721387c409 ("batman-adv: add basic bridge loop avoidance code")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bridge_loop_avoidance.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 51fe028b9088..8b77dd2ecfa4 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -318,8 +318,8 @@ batadv_bla_del_backbone_claims(struct batadv_bla_backbone_gw *backbone_gw)
 			if (claim->backbone_gw != backbone_gw)
 				continue;
 
-			batadv_claim_put(claim);
 			hlist_del_rcu(&claim->hash_entry);
+			batadv_claim_put(claim);
 		}
 		spin_unlock_bh(list_lock);
 	}

-- 
2.47.3

