Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822DC37268A;
	Fri, 18 Sep 2026 15:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789745849; cv=none; b=JMTSZEh8HdnvspeIqRMEpQeplPUufQDZ24kXzkXafLSuVQxTRpckZqfEcJAVF40Bd4geu38O/T+I7uuYTIGr3Ad9y7QiDd6N0UZPQzdgYHd16FzGEaAOuL9DZzFCNpM6ODoD4V6Zj0WGap9nhAJ8mvSzaKw80WNPUP94JVwa4oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789745849; c=relaxed/simple;
	bh=XZDHDtWiJlTMoxLH+NUZgvGpy3/sAaZSLZ6HqTugnKk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YP7jHVvdqMc2DWXaX4Awr3JjNIh4YLP2R8XUv6+9UZhZtXj79UhK258ePkrnmMwaRhGSFSKbBH6V7Fop0YBvWBjtpy23wg8bujTpFAjp/R5hNYK8/OunTkSRgvXVXIP85eiSA5BJas9fzfdWxu26brZTj6gOKEBjHGp1gQa2huw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id CDC8C475D1;
	Fri, 18 Sep 2026 17:28:41 +0200 (CEST)
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
Subject: [PATCH net] ipv4: fib: treat an unbuildable encapsulation as a nexthop mismatch
Date: Fri, 18 Sep 2026 17:28:33 +0200
Message-ID: <20260918152836.1173368-1-g.goller@proxmox.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1789745321210

fib_encap_match() builds the requested lwtunnel state and compares it
against the nexthop of a candidate route. When lwtunnel_build_state()
failed it left result at 0, which is interpreted as "the nexthop
matches", so fib_nh_match() continues to compare only oif and gateway.

So if there comes along a RTM_DELROUTE which carries an encapsulation
the kernel rejects, it could delete a different route with a different
encapsulation.

Fixes: 571e722676fe ("ipv4: support for fib route lwtunnel encap attributes")
Signed-off-by: Gabriel Goller <g.goller@proxmox.com>
---
 net/ipv4/fib_semantics.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index 50e96f86ca59..951e48ae87da 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -911,17 +911,17 @@ static int fib_encap_match(struct net *net, u16 encap_type,
 			   struct netlink_ext_ack *extack)
 {
 	struct lwtunnel_state *lwtstate;
-	int ret, result = 0;
+	int result;
 
 	if (encap_type == LWTUNNEL_ENCAP_NONE)
 		return 0;
 
-	ret = lwtunnel_build_state(net, encap_type, encap, AF_INET,
-				   cfg, &lwtstate, extack);
-	if (!ret) {
-		result = lwtunnel_cmp_encap(lwtstate, nh->fib_nh_lws);
-		lwtstate_free(lwtstate);
-	}
+	if (lwtunnel_build_state(net, encap_type, encap, AF_INET, cfg,
+				 &lwtstate, extack))
+		return 1;
+
+	result = lwtunnel_cmp_encap(lwtstate, nh->fib_nh_lws);
+	lwtstate_free(lwtstate);
 
 	return result;
 }
-- 
2.47.3


