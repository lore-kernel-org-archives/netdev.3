Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30683DB314
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 11:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779278090; cv=none; b=gmXbk1y34YPbKhSng37tsBJlPet/Okfpg9Gb0JuLdr8wJW76ovbEx3Zz4XDwMMzSv7T3OVfQ7Tc4zT3aOk4ywkTCMj5WkyrrwMDN8BS8SC3VJ7kIMuu0azAI/I6zsveTR54mrqDX3Q8MX9uhnAqNxphv+UI4tmJZZSQ2V4L1Yk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779278090; c=relaxed/simple;
	bh=8c1LhLX1fqUfD7Bf15l1VmtqYiK+Ufd4dx0sZEpkvh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mP6XJkvy0SyLz4ID4fUBYFh5vLccOoN2pRP5qkCfI2kxi/SjX4feQ1SbtM2/qK/bRUcyAS5dG7m36SYqXkTHrOQ5c1xPRz9LXXQgC4sy/97KXiqXqjcgDkYHvIH+ldalCEMBPMpjOXpGT9u4lFtP0IBCjcIplYo9O+jd+Dn1wKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=TkV5rQXk; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="TkV5rQXk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1779278083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KoLdXuK8L7KjFwX63mbZu2/GYyTKYsP6WvpL4UCAN5g=;
	b=TkV5rQXk/0hSzBCRMCuYL+entTXOxHaoTfg/wbTKEASbBzbEVwFWBtgu7s2lLBvDZ76hoI
	qq0v4KrzL2aLZX/oLrTOcfRaBX20+Au9sFNScOnqK8ILAi87qwhQ/WSPQemsA9YkUNGhqi
	dxZE1SOu7SGKIKh+Hx0QcpB1ppTSF4b5jySCwo8NEWEkkXc6MIgo87vpbb9dfSDSmgnx7d
	IFtgv8+B1gedLtuWkEWs5mCsz8CAQ+WAjJ+Ms5+MYgS8w/6SpduqM5SI6AuIeOTE8YHzX9
	QRkg8I/n1FANNpdAPhMAQx6aMBEV0Ya0dPZaliycVf7C2KmHqNhE3hqhcCWhnw==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	stable@kernel.org,
	=?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 07/11] batman-adv: mcast: fix use-after-free in orig_node RCU release
Date: Wed, 20 May 2026 13:54:18 +0200
Message-ID: <20260520115422.53552-8-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260520115422.53552-1-sw@simonwunderlich.de>
References: <20260520115422.53552-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Sven Eckelmann <sven@narfation.org>

batadv_mcast_purge_orig() removes entries from RCU-protected hlists but
does not wait for an RCU grace period before returning. Concurrent RCU
readers may still accesses references to those entries at the point of
removal. RCU-protected readers trying to operate on entries like
orig->mcast_want_all_ipv6_node will then access already freed memory.

Fix this by moving batadv_mcast_purge_orig() to batadv_orig_node_release(),
just before the call_rcu() invocation. This ensures RCU readers that were
active at purge time have drained before the orig_node memory is reclaimed.

Cc: stable@kernel.org
Fixes: ab49886e3da7 ("batman-adv: Add IPv4 link-local/IPv6-ll-all-nodes multicast support")
Acked-by: Linus Lüssing <linus.luessing@c0d3.blue>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/originator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index b3468ccab5354..ad4921b659d9d 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -835,8 +835,6 @@ static void batadv_orig_node_free_rcu(struct rcu_head *rcu)
 
 	orig_node = container_of(rcu, struct batadv_orig_node, rcu);
 
-	batadv_mcast_purge_orig(orig_node);
-
 	batadv_frag_purge_orig(orig_node, NULL);
 
 	kfree(orig_node->tt_buff);
@@ -887,6 +885,8 @@ void batadv_orig_node_release(struct kref *ref)
 	}
 	spin_unlock_bh(&orig_node->vlan_list_lock);
 
+	batadv_mcast_purge_orig(orig_node);
+
 	call_rcu(&orig_node->rcu, batadv_orig_node_free_rcu);
 }
 
-- 
2.47.3

