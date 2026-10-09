Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082EC457E56
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 07:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791531854; cv=none; b=jt5hNYatXoS9WzfJcpbERPXASnjot+PAIOmK9EOvS3F253raCtBWomsXQ225JuLLZ/4DhNl1vNHbQH4FJPHgZlsNIC0PPkGHXDYR4vbK3vKyPOQYN6h5XegL0BXd/HrrPSxthbY8B4YjdoErRQv6ScHbVhnywn0jKrr1nCUaSNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791531854; c=relaxed/simple;
	bh=m1WmAY5g1ebSDH4cjX37xA1Lx8rITb4V2u+6EUWh+AE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GAoN5Ix6uADd5ipXqA/nvDr3/A3x0HjDXGii9sLDm60mZwbdJW4uZoDFNIhmu2+p4OWk251L5iZUENWpPPAUE8dd0Cz+CkeCHAgiT9mPblYv0FepwJETi4Kb/O1gaec951/O3s0ZbzUL22eNfvl4VFB0iVI8RWL7aW2FwmAbBBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R44qMcgl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R44qMcgl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDAC11F000FF;
	Fri,  9 Oct 2026 07:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791531852;
	bh=7kfQmmz2VEfOe+stV4PsQ8pwfY4vcNZihIKqHxDLvkc=;
	h=From:To:Cc:Subject:Date;
	b=R44qMcglzHELOSIy23JWOybaYdrwIb30QyGGKplMGX7ih6WJreCMjmqH66ANF8+9v
	 rj8c6j256i1bk+EusM9xkoZB8c+vHeDz5QakcAniaC0nZPB0rKRlnv8jrJs7Tr7+h7
	 EsDPqwFfu8Qtjt5dcIVvo0zBGb4EqEUNf8KYwL4SeFtkwQ0XWBFZjbIO5/JJfzCL5L
	 O7acGfZSygVpdoVhWeZO2npznOzuEZzIV16kRg296xZsQHF9vKd83extvCJ8uOnO38
	 Zjg9NTQ+UncBrtn/LVN9k1kqhEJrSwGdgD0cIt7VEErFFg23PxcqbOS+IBa34mM0xO
	 3Q484rtZv8kUw==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	netdev@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Baul Lee <baul.lee@xbow.com>,
	Cen Zhang <zzzccc427@gmail.com>
Subject: [PATCH net] ipv4: use RCU protection in inet_netconf_get_devconf()
Date: Fri,  9 Oct 2026 09:44:05 +0200
Message-ID: <20261009074405.727999-1-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

inet_netconf_get_devconf() runs without RTNL. It uses dev_get_by_index()
and in_dev_get() to pin the device and its in_device while the reply is
allocated and filled.

in_dev_get() is not safe for a lockless caller. Since commit 9d40c84cf5bc
("net: devinet: Reduce refcount before grace period"), inetdev_destroy()
drops the final reference before the RCU grace period. A reader can load
dev->ip_ptr, then call refcount_inc() on a zero refcount after
in_dev_free_rcu() has been queued, and keep using the in_device once it
has been freed.

None of these references are needed. An in_device is freed after an RCU
grace period, ipv4_devconf is embedded in it, and
inet_netconf_fill_devconf() does not sleep.

Allocate the skb first, then perform the lookup and the fill under
rcu_read_lock(), using dev_get_by_index_rcu() and __in_dev_get_rcu(),
like inet_netconf_dump_devconf() already does.

Fixes: bbcf91053bb6 ("inet: do not use RTNL in inet_netconf_get_devconf()")
Reported-by: Baul Lee <baul.lee@xbow.com>
Closes: https://lore.kernel.org/netdev/20260815172032.79740-1-baul.lee@xbow.com/
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Cen Zhang <zzzccc427@gmail.com>
---
 net/ipv4/devinet.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 5b6b11c943e453742b4893f1c9bd9e70d3d37a6f..f9a361621f74b420276006b13de94926e13af18e 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -2379,8 +2379,8 @@ static int inet_netconf_get_devconf(struct sk_buff *in_skb,
 	struct net *net = sock_net(in_skb->sk);
 	struct nlattr *tb[NETCONFA_MAX + 1];
 	const struct ipv4_devconf *devconf;
-	struct in_device *in_dev = NULL;
-	struct net_device *dev = NULL;
+	struct in_device *in_dev;
+	struct net_device *dev;
 	struct sk_buff *skb;
 	int ifindex;
 	int err;
@@ -2392,7 +2392,13 @@ static int inet_netconf_get_devconf(struct sk_buff *in_skb,
 	if (!tb[NETCONFA_IFINDEX])
 		return -EINVAL;
 
+	skb = nlmsg_new(inet_netconf_msgsize_devconf(NETCONFA_ALL), GFP_KERNEL);
+	if (!skb)
+		return -ENOBUFS;
+
 	ifindex = nla_get_s32(tb[NETCONFA_IFINDEX]);
+
+	rcu_read_lock();
 	switch (ifindex) {
 	case NETCONFA_IFINDEX_ALL:
 		devconf = net->ipv4.devconf_all;
@@ -2402,36 +2408,29 @@ static int inet_netconf_get_devconf(struct sk_buff *in_skb,
 		break;
 	default:
 		err = -ENODEV;
-		dev = dev_get_by_index(net, ifindex);
-		if (dev)
-			in_dev = in_dev_get(dev);
+		dev = dev_get_by_index_rcu(net, ifindex);
+		if (!dev)
+			goto out_unlock;
+		in_dev = __in_dev_get_rcu(dev);
 		if (!in_dev)
-			goto errout;
+			goto out_unlock;
 		devconf = &in_dev->cnf;
 		break;
 	}
 
-	err = -ENOBUFS;
-	skb = nlmsg_new(inet_netconf_msgsize_devconf(NETCONFA_ALL), GFP_KERNEL);
-	if (!skb)
-		goto errout;
-
 	err = inet_netconf_fill_devconf(skb, ifindex, devconf,
 					NETLINK_CB(in_skb).portid,
 					nlh->nlmsg_seq, RTM_NEWNETCONF, 0,
 					NETCONFA_ALL);
+out_unlock:
+	rcu_read_unlock();
 	if (err < 0) {
 		/* -EMSGSIZE implies BUG in inet_netconf_msgsize_devconf() */
 		WARN_ON(err == -EMSGSIZE);
 		kfree_skb(skb);
-		goto errout;
+		return err;
 	}
-	err = rtnl_unicast(skb, net, NETLINK_CB(in_skb).portid);
-errout:
-	if (in_dev)
-		in_dev_put(in_dev);
-	dev_put(dev);
-	return err;
+	return rtnl_unicast(skb, net, NETLINK_CB(in_skb).portid);
 }
 
 static int inet_netconf_dump_devconf(struct sk_buff *skb,
-- 
2.53.0

