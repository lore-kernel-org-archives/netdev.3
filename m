Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27022F39AB;
	Fri,  3 Apr 2026 08:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775204583; cv=none; b=uB82dJcjf01iV6nNK2wU63sR0iC5yEPyAbrBG3KuWtlueP1PjPdfflOkOLG1qEbnBZFgzndsT39tCBkOyP1YFnN03pw9vi48AgYU++ISZhEnULlgVwuCWM18gbFNdvEPkBkd4leSFF6Rlm3yJ+yB9E0+RdHeKx/cOnKIcUG+bCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775204583; c=relaxed/simple;
	bh=Tk+A4V1TWkNjekt5UolmQUfYw2O8cZMUCmRpUxy7nXc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rE3ZrOzTfhkAZF7lVxenldnFmLP7pn9h+Yw6LNgum0GQO6WYf9YxRnO0ltBiUp3uw8VybXvoP0r7+/bAOttUODRPp4K+B7Q1abUm73E5OlaagtW8X4BZ3kuMgXBtnI5oIwjEz0Ns9ySJ+a3bljL1eVNvzMEcaZZyw5coCs33QdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=2n0xMBxy; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="2n0xMBxy"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=GbFmhlMxJlefpTa/PAOsM3LbW8nUPepjmM/3znV8aaY=;
	b=2n0xMBxydyhAEEVgCqUqHlHW2Br2BYxe51MQT+t6LX8f5APx8Zh2NMQGjY+J1K9VE0R9an0Gd
	u7rG4p0ol6jSMM7mOQXSnmkmzLhoav6vbZ6lJVbsyr5BHVY+MqTVnevzKIkpaLwT1vAhvx1tkiV
	uBW8BrTAM24+hLOC87x7BcM=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fnBQP5kT9zKm5l;
	Fri,  3 Apr 2026 16:16:45 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id A7CF04056E;
	Fri,  3 Apr 2026 16:22:58 +0800 (CST)
Received: from huawei.com (10.50.85.128) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 3 Apr
 2026 16:22:57 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yuehaibing@huawei.com>
Subject: [PATCH net-next] ip6_tunnel: use generic for_each_ip_tunnel_rcu macro
Date: Fri, 3 Apr 2026 16:46:19 +0800
Message-ID: <20260403084619.4107978-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500002.china.huawei.com (7.185.36.57)

Remove the locally defined for_each_ip6_tunnel_rcu macro and use
the generic for_each_ip_tunnel_rcu from linux/if_tunnel.h instead.

This eliminates code duplication and ensures consistency across
the kernel tunnel implementations.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 net/ipv6/ip6_tunnel.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 4c29aa94e86e..ace0bb91542f 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -96,9 +96,6 @@ static inline int ip6_tnl_mpls_supported(void)
 	return IS_ENABLED(CONFIG_MPLS);
 }
 
-#define for_each_ip6_tunnel_rcu(start) \
-	for (t = rcu_dereference(start); t; t = rcu_dereference(t->next))
-
 /**
  * ip6_tnl_lookup - fetch tunnel matching the end-point addresses
  *   @net: network namespace
@@ -121,7 +118,7 @@ ip6_tnl_lookup(struct net *net, int link,
 	struct ip6_tnl_net *ip6n = net_generic(net, ip6_tnl_net_id);
 	struct in6_addr any;
 
-	for_each_ip6_tunnel_rcu(ip6n->tnls_r_l[hash]) {
+	for_each_ip_tunnel_rcu(t, ip6n->tnls_r_l[hash]) {
 		if (!ipv6_addr_equal(local, &t->parms.laddr) ||
 		    !ipv6_addr_equal(remote, &t->parms.raddr) ||
 		    !(t->dev->flags & IFF_UP))
@@ -135,7 +132,7 @@ ip6_tnl_lookup(struct net *net, int link,
 
 	memset(&any, 0, sizeof(any));
 	hash = HASH(&any, local);
-	for_each_ip6_tunnel_rcu(ip6n->tnls_r_l[hash]) {
+	for_each_ip_tunnel_rcu(t, ip6n->tnls_r_l[hash]) {
 		if (!ipv6_addr_equal(local, &t->parms.laddr) ||
 		    !ipv6_addr_any(&t->parms.raddr) ||
 		    !(t->dev->flags & IFF_UP))
@@ -148,7 +145,7 @@ ip6_tnl_lookup(struct net *net, int link,
 	}
 
 	hash = HASH(remote, &any);
-	for_each_ip6_tunnel_rcu(ip6n->tnls_r_l[hash]) {
+	for_each_ip_tunnel_rcu(t, ip6n->tnls_r_l[hash]) {
 		if (!ipv6_addr_equal(remote, &t->parms.raddr) ||
 		    !ipv6_addr_any(&t->parms.laddr) ||
 		    !(t->dev->flags & IFF_UP))
-- 
2.34.1

