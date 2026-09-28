Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445C9383C86
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 21:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790629526; cv=none; b=pKy+QDo4psghtQsDDae6bI2x7G86LAJFUNBhupkiJ7kUUdG84VtA8lWbcCkP40hguOpzZAMaliuqp57JMZojop8ma/0Ihu8VPlqNxyeN0yysEsveqne8PMLLIQxUO8l+lTIKJVgMq2VZ/DHFfnccrrai8dMp8zsX1dR/fwe5oz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790629526; c=relaxed/simple;
	bh=hf/nJoQlj3jNky1lczapN9s48cS3njDHn8wFP2wBWc8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=N2RPJoe4Ja2IuY7agEED+uu9wWAHMoQ4tDUs6BVINrnw9sljyK0NuDWZGU7m9PNqKrd+BQWl4eVkR3Qr8Le3h/JGwHnIxvXnR5RiGOEOD5Z24TybW5/pVxnYd5w4tzcaHPQPaL2XVGf3KT/SNTRD1wHu1t1il+530ewN0mKJ1Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kishorg.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hq3YZJOv; arc=none smtp.client-ip=74.125.82.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kishorg.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hq3YZJOv"
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30c0d568830so7253851eec.1
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 14:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790629524; x=1791234324; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2HURpRj3glseEN+6PQaM4W+J9k2Jme4I/Jgk3uxKQ5I=;
        b=hq3YZJOvNYhICRbczzqc+dqMordLznhxF7K6m44PC75xTj5+9W7RdJKlm+ft8B1icV
         HTK4dZ275enIqV68t06H6S8XG6zSNDVqatMnuHknEz5W2KZU7DPXZWwlEzk92pBstKCt
         0DsfB7GWFj8lc1dI8lhAr3o8l4DXgKy938KIwIytsZMGzkLGG17w/HsoK5XRkGoFAEfr
         QT0ImiTv3XcatphP02WtMIb8dwD6HEUS3i3jIqVz952wcW26+go03A2IHbA24KctVWck
         HDjwT03HqO0OzOAM1la1GHXD1f8FwxWyUu1bAY0uaXmiZ21F1whkjCTnmfk7+x9E3HxA
         F1Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790629524; x=1791234324;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2HURpRj3glseEN+6PQaM4W+J9k2Jme4I/Jgk3uxKQ5I=;
        b=aRqTKEASwqMZC0gIs0U+v/knG7hC0JC0crap6Tvjq7CENboQ84t/L3yvZzhIAuSdpZ
         7cKQI/sfojmjeqDbO/j0lm70VSK4uaiutQsrhzRcaG6SGYFoPI0xbfG9zInxvls9qIWv
         JLzJ4ItvNedfsBansbyIeH26MJN0x0oKxA2eIx0M9bGpkwG59IQdH5dbwDfgH1M8c4o9
         aN1JhhLggXvhDfG7W0osaiHz5k9T7MYTXkz35WX2VncRGRPmcTO6UrcwaEGqV4hHCu59
         3FBmIR8vqrdSe/rB2//e59A1jCoUrHrTcrl3N2kukLmlk9p7eoKplcvFqalRRbxS1BGZ
         5CVQ==
X-Gm-Message-State: AFuF++lt4Vl69eKGic/vLxVcwp8W0/x9Pfpbpv8B+jp6LL/do5lLYKl4
	mpq+ciEGe4zwZ2FNi7nyKYlwXOlqKfPZ5RTcKaHW61mm9vo/ppwESM49oEDZSQWLq4QX8dP67UD
	DsSbZlMkAcQ==
X-Received: from dlk3.prod.google.com ([2002:a05:7022:103:b0:14a:f387:29b1])
 (user=kishorg job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:42cd:10b0:144:ff51:2d5f
 with SMTP id a92af1059eb24-146d077b156mr10609592c88.33.1790629523864; Mon, 28
 Sep 2026 14:05:23 -0700 (PDT)
Date: Mon, 28 Sep 2026 21:05:08 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260928210508.2645800-1-kishorg@google.com>
Subject: [PATCH] ipvlan: no longer rely on RTNL in ipvlan_nl_fillinfo()
From: Kishore Gummadidala <kishorg@google.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>
Cc: netdev@vger.kernel.org, Kishore Gummadidala <kishorg@google.com>
Content-Type: text/plain; charset="UTF-8"

ipvlan_nl_fillinfo() currently relies on RTNL being held because it
calls ipvlan_port_get_rtnl(ipvlan->phy_dev) to retrieve the ipvl_port,
forcing "ip link show" dumps to hold RTNL.

However, ipvlan->port is already initialized in ipvlan_init() with a
reference on port->count and remains valid until ipvlan_uninit(), after
the net_device has been unregistered. Both ipvlan_nl_fillinfo() and
ipvlan_nl_changelink() can therefore use ipvlan->port directly without
dereferencing phy_dev->rx_handler_data or checking for a NULL port.

In addition, port->mode and port->flags are updated under RTNL (via
ipvlan_link_new(), ipvlan_nl_changelink(), and ipvlan_set_port_mode()),
while being read locklessly from the data path and from
ipvlan_nl_fillinfo():
- ipvlan_queue_xmit(), ipvlan_handle_frame(), and ipvlan_skb_to_addr()
  read port->mode,
- ipvlan_is_private() and ipvlan_is_vepa() read port->flags.

Furthermore, ipvlan_nl_changelink() previously updated port->flags via
separate read-modify-write calls for IPVLAN_F_PRIVATE and IPVLAN_F_VEPA,
which could publish an intermediate value to concurrent readers. Since
ipvlan_nl_validate() already validates that only those two flags exist
and are mutually exclusive, replace the bit-manipulation helpers with a
single WRITE_ONCE(port->flags, ...) in ipvlan_nl_changelink() (matching
ipvlan_link_new()) and remove the unused ipvlan_{mark,clear}_{private,
vepa}() helpers.

Annotate all remaining accesses to port->mode and port->flags with
READ_ONCE() and WRITE_ONCE(), caching READ_ONCE(port->mode) in a local
variable in ipvlan_queue_xmit() and ipvlan_handle_frame() so the switch
statement and fallback WARN_ONCE() observe a consistent value.

Finally, add const qualifiers to local pointers in ipvlan_nl_fillinfo().

Signed-off-by: Kishore Gummadidala <kishorg@google.com>
---
 drivers/net/ipvlan/ipvlan.h      | 24 ++------------------
 drivers/net/ipvlan/ipvlan_core.c | 12 ++++++----
 drivers/net/ipvlan/ipvlan_l3s.c  |  2 +-
 drivers/net/ipvlan/ipvlan_main.c | 38 ++++++++------------------------
 4 files changed, 20 insertions(+), 56 deletions(-)

diff --git a/drivers/net/ipvlan/ipvlan.h b/drivers/net/ipvlan/ipvlan.h
index 8d05ad480438..48176b546a46 100644
--- a/drivers/net/ipvlan/ipvlan.h
+++ b/drivers/net/ipvlan/ipvlan.h
@@ -125,32 +125,12 @@ static inline struct ipvl_port *ipvlan_port_get_rtnl(const struct net_device *d)
 
 static inline bool ipvlan_is_private(const struct ipvl_port *port)
 {
-	return !!(port->flags & IPVLAN_F_PRIVATE);
-}
-
-static inline void ipvlan_mark_private(struct ipvl_port *port)
-{
-	port->flags |= IPVLAN_F_PRIVATE;
-}
-
-static inline void ipvlan_clear_private(struct ipvl_port *port)
-{
-	port->flags &= ~IPVLAN_F_PRIVATE;
+	return !!(READ_ONCE(port->flags) & IPVLAN_F_PRIVATE);
 }
 
 static inline bool ipvlan_is_vepa(const struct ipvl_port *port)
 {
-	return !!(port->flags & IPVLAN_F_VEPA);
-}
-
-static inline void ipvlan_mark_vepa(struct ipvl_port *port)
-{
-	port->flags |= IPVLAN_F_VEPA;
-}
-
-static inline void ipvlan_clear_vepa(struct ipvl_port *port)
-{
-	port->flags &= ~IPVLAN_F_VEPA;
+	return !!(READ_ONCE(port->flags) & IPVLAN_F_VEPA);
 }
 
 void ipvlan_init_secret(void);
diff --git a/drivers/net/ipvlan/ipvlan_core.c b/drivers/net/ipvlan/ipvlan_core.c
index 7ad12dc7845c..c08d2bf88503 100644
--- a/drivers/net/ipvlan/ipvlan_core.c
+++ b/drivers/net/ipvlan/ipvlan_core.c
@@ -676,6 +676,7 @@ int ipvlan_queue_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct ipvl_dev *ipvlan = netdev_priv(dev);
 	struct ipvl_port *port = ipvlan_port_get_rcu_bh(ipvlan->phy_dev);
+	u16 mode;
 
 	if (!port)
 		goto out;
@@ -683,7 +684,8 @@ int ipvlan_queue_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (unlikely(!pskb_may_pull(skb, sizeof(struct ethhdr))))
 		goto out;
 
-	switch(port->mode) {
+	mode = READ_ONCE(port->mode);
+	switch (mode) {
 	case IPVLAN_MODE_L2:
 		return ipvlan_xmit_mode_l2(skb, dev);
 	case IPVLAN_MODE_L3:
@@ -694,7 +696,7 @@ int ipvlan_queue_xmit(struct sk_buff *skb, struct net_device *dev)
 	}
 
 	/* Should not reach here */
-	WARN_ONCE(true, "%s called for mode = [%x]\n", __func__, port->mode);
+	WARN_ONCE(true, "%s called for mode = [%x]\n", __func__, mode);
 out:
 	kfree_skb(skb);
 	return NET_XMIT_DROP;
@@ -782,11 +784,13 @@ rx_handler_result_t ipvlan_handle_frame(struct sk_buff **pskb)
 {
 	struct sk_buff *skb = *pskb;
 	struct ipvl_port *port = ipvlan_port_get_rcu(skb->dev);
+	u16 mode;
 
 	if (!port)
 		return RX_HANDLER_PASS;
 
-	switch (port->mode) {
+	mode = READ_ONCE(port->mode);
+	switch (mode) {
 	case IPVLAN_MODE_L2:
 		return ipvlan_handle_mode_l2(pskb, port);
 	case IPVLAN_MODE_L3:
@@ -798,7 +802,7 @@ rx_handler_result_t ipvlan_handle_frame(struct sk_buff **pskb)
 	}
 
 	/* Should not reach here */
-	WARN_ONCE(true, "%s called for mode = [%x]\n", __func__, port->mode);
+	WARN_ONCE(true, "%s called for mode = [%x]\n", __func__, mode);
 	kfree_skb(skb);
 	return RX_HANDLER_CONSUMED;
 }
diff --git a/drivers/net/ipvlan/ipvlan_l3s.c b/drivers/net/ipvlan/ipvlan_l3s.c
index 7c017fe35522..3e9f5f051d86 100644
--- a/drivers/net/ipvlan/ipvlan_l3s.c
+++ b/drivers/net/ipvlan/ipvlan_l3s.c
@@ -24,7 +24,7 @@ static struct ipvl_addr *ipvlan_skb_to_addr(struct sk_buff *skb,
 		goto out;
 
 	port = ipvlan_port_get_rcu(dev);
-	if (!port || port->mode != IPVLAN_MODE_L3S)
+	if (!port || READ_ONCE(port->mode) != IPVLAN_MODE_L3S)
 		goto out;
 
 	lyr3h = ipvlan_get_L3_hdr(port, skb, &addr_type);
diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index 4939cf67b336..9c7c1a1f41c3 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -47,7 +47,7 @@ static int ipvlan_set_port_mode(struct ipvl_port *port, u16 nval,
 			/* Old mode was L3S */
 			ipvlan_l3s_unregister(port);
 		}
-		port->mode = nval;
+		WRITE_ONCE(port->mode, nval);
 
 		mutex_unlock(&port->pnodes_lock);
 	}
@@ -501,7 +501,7 @@ static int ipvlan_nl_changelink(struct net_device *dev,
 				struct netlink_ext_ack *extack)
 {
 	struct ipvl_dev *ipvlan = netdev_priv(dev);
-	struct ipvl_port *port = ipvlan_port_get_rtnl(ipvlan->phy_dev);
+	struct ipvl_port *port = ipvlan->port;
 	int err = 0;
 
 	if (!data)
@@ -516,17 +516,7 @@ static int ipvlan_nl_changelink(struct net_device *dev,
 	}
 
 	if (!err && data[IFLA_IPVLAN_FLAGS]) {
-		u16 flags = nla_get_u16(data[IFLA_IPVLAN_FLAGS]);
-
-		if (flags & IPVLAN_F_PRIVATE)
-			ipvlan_mark_private(port);
-		else
-			ipvlan_clear_private(port);
-
-		if (flags & IPVLAN_F_VEPA)
-			ipvlan_mark_vepa(port);
-		else
-			ipvlan_clear_vepa(port);
+		WRITE_ONCE(port->flags, nla_get_u16(data[IFLA_IPVLAN_FLAGS]));
 	}
 
 	return err;
@@ -570,23 +560,13 @@ static int ipvlan_nl_validate(struct nlattr *tb[], struct nlattr *data[],
 static int ipvlan_nl_fillinfo(struct sk_buff *skb,
 			      const struct net_device *dev)
 {
-	struct ipvl_dev *ipvlan = netdev_priv(dev);
-	struct ipvl_port *port = ipvlan_port_get_rtnl(ipvlan->phy_dev);
-	int ret = -EINVAL;
-
-	if (!port)
-		goto err;
-
-	ret = -EMSGSIZE;
-	if (nla_put_u16(skb, IFLA_IPVLAN_MODE, port->mode))
-		goto err;
-	if (nla_put_u16(skb, IFLA_IPVLAN_FLAGS, port->flags))
-		goto err;
+	const struct ipvl_dev *ipvlan = netdev_priv(dev);
+	const struct ipvl_port *port = ipvlan->port;
 
+	if (nla_put_u16(skb, IFLA_IPVLAN_MODE, READ_ONCE(port->mode)) ||
+	    nla_put_u16(skb, IFLA_IPVLAN_FLAGS, READ_ONCE(port->flags)))
+		return -EMSGSIZE;
 	return 0;
-
-err:
-	return ret;
 }
 
 int ipvlan_link_new(struct net_device *dev, struct rtnl_newlink_params *params,
@@ -682,7 +662,7 @@ int ipvlan_link_new(struct net_device *dev, struct rtnl_newlink_params *params,
 	 * to be consistent in setting it just like the mode attribute.
 	 */
 	if (data && data[IFLA_IPVLAN_FLAGS])
-		port->flags = nla_get_u16(data[IFLA_IPVLAN_FLAGS]);
+		WRITE_ONCE(port->flags, nla_get_u16(data[IFLA_IPVLAN_FLAGS]));
 
 	if (data && data[IFLA_IPVLAN_MODE])
 		mode = nla_get_u16(data[IFLA_IPVLAN_MODE]);
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

