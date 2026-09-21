Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA4A48F82F;
	Mon, 21 Sep 2026 13:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789996068; cv=none; b=FrKJ/NceFlHkzGwrbORxovAp2TiJc8sMrh3jIArTc2VsmEl2eWblS0aem0sEpfnC+ES2uDn2yMwgH/nfrO4Sr9ZwfF4fbAB/CiNVlPYEURfyHLaykH9ZSUpmFauAgnO+K4hAYJhc7uH1cp9fabIVhowXxrT58Q9d1YXAZS+wL5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789996068; c=relaxed/simple;
	bh=l6GJEM5nV4C1CujJgX7nkAWlxQBwLRdR8Onb+3XI2bY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ka18WwKbERhK+33XW9gpIlD0xLkj0ld5Hw0k6Y6iGcoZjV6BhJeqDSyaoouBjQwo4J/H0C0YQom9lVoXMDQv70QJhOMUYiPeB1AH8XAEbhw9XI1mb/C5n9sFLNZKxAuK0IaMPvWDsXnUunjOFAN4Gue8ebkjZtF7ugLLnO8W9cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 3C7EC40BC7;
	Mon, 21 Sep 2026 15:07:42 +0200 (CEST)
From: Gabriel Goller <g.goller@proxmox.com>
To: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Roopa Prabhu <roopa@cumulusnetworks.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] ipv4: fib: treat an unbuildable encapsulation as a nexthop mismatch
Date: Mon, 21 Sep 2026 15:07:30 +0200
Message-ID: <20260921130736.210845-1-g.goller@proxmox.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1789996061375

fib_encap_match() builds the requested lwtunnel state and compares it
against the nexthop of a candidate route. When lwtunnel_build_state()
failed it left result at 0, which is interpreted as "the nexthop
matches", so fib_nh_match() continues to compare only oif and gateway.

So if there comes along a RTM_DELROUTE which carries an encapsulation
the kernel rejects, it could delete a different route with a different
encapsulation.

Report a mismatch instead. This also covers LWTUNNEL_ENCAP_NONE, which
lwtunnel_build_state() rejects with -EINVAL, so the separate check for
it can go away. It used to claim a match for an encapsulation type the
kernel refuses to build.

Fixes: 571e722676fe ("ipv4: support for fib route lwtunnel encap attributes")
Signed-off-by: Gabriel Goller <g.goller@proxmox.com>
---

v1 (https://lore.kernel.org/netdev/20260918152836.1173368-1-g.goller@proxmox.com/):
 * removed the LWTUNNEL_ENCAP_NONE check as it is in lwtunnel_build_state
   already (thanks @Ido)


 net/ipv4/fib_semantics.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index 50e96f86ca59..001da9fc86cc 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -911,17 +911,14 @@ static int fib_encap_match(struct net *net, u16 encap_type,
 			   struct netlink_ext_ack *extack)
 {
 	struct lwtunnel_state *lwtstate;
-	int ret, result = 0;
+	int result;
 
-	if (encap_type == LWTUNNEL_ENCAP_NONE)
-		return 0;
+	if (lwtunnel_build_state(net, encap_type, encap, AF_INET, cfg,
+				 &lwtstate, extack))
+		return 1;
 
-	ret = lwtunnel_build_state(net, encap_type, encap, AF_INET,
-				   cfg, &lwtstate, extack);
-	if (!ret) {
-		result = lwtunnel_cmp_encap(lwtstate, nh->fib_nh_lws);
-		lwtstate_free(lwtstate);
-	}
+	result = lwtunnel_cmp_encap(lwtstate, nh->fib_nh_lws);
+	lwtstate_free(lwtstate);
 
 	return result;
 }
-- 
2.47.3


