Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320DA1A5B9E
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 00:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780619378; cv=none; b=F6f8UesrqFNlHqulBPa9gqLyyrAKmypPTttZkBiWFqxBfJOSCOnwP9dBOOq6gAvhwHGkFMMk5t9zzM0U4hhUUBZcORicnvcrSOSzqe4O2MvmuwdVjhMtjHpVnVhnA9wOZqzOeIfswu+rDRSu5+MF//rm84xgUqAoKio6P7i5XXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780619378; c=relaxed/simple;
	bh=VN5j6pJze99t1zl6mAAh/sfqPC5SGfnybAMU2xa81bw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sh89JlbNKk9s13j/zmfaxNZ4kVuxGJXQOeCR/9qzZmZ4KquWodLtF5xrE1XJzM9lZ9gNmVSQrVxR9vOrCZd/Zg3E06aoABziygW3mMfptTm6Bgr2LPhWdnl6H9KeQvSWbRD+KUxb/B7YjwuOy48Pk0nE7ktJjLipB3Rpjsga8Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zr+tbT8Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zr+tbT8Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A0261F00899;
	Fri,  5 Jun 2026 00:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780619376;
	bh=MBHrNglWZ8P1gUdeddewEb9//fJdw6WeHGvAQmFXEIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Zr+tbT8Q5kg7xvrWD0wrOQ1x5RRND/kO/I7Ct6uRc03RIuRqdxQ7tv9odq142BRk7
	 hpnDwpq42LUItUr95JxIv82XvlFrnU9fVADLJMuNKa91sDFqEdZ5aevuLxzz0RuocZ
	 T+uTzmdPD7o/vDcE9j1OMoQX5tgWjjubOIu2ySV+eDQABsfGRyytYY+s6hxs4WtxTe
	 z9BEDf0QvX7n8jHKNktxxYbTCLolNGsJrcjooi9C2N4a41IPPXY7SoSGUnZpwPmFei
	 8oSImck7zspfPYliLuNMiNBxC7rGTT8n+ZWMcnvz2DC5L/BNGeg+h6Wy4takQ3iwep
	 aXLCEo/2TTqig==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	michael.chan@broadcom.com,
	hkallweit1@gmail.com,
	maxime.chevallier@bootlin.com,
	joshwash@google.com,
	tariqt@nvidia.com,
	alexanderduyck@fb.com,
	willemb@google.com,
	jacob.e.keller@intel.com,
	kory.maincent@bootlin.com,
	sdf.kernel@gmail.com,
	jakub@cloudflare.com,
	nb@tipi-net.de,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 01/12] net: ethtool: serialize broadcast notification sequence allocation
Date: Thu,  4 Jun 2026 17:29:01 -0700
Message-ID: <20260605002912.3456868-2-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605002912.3456868-1-kuba@kernel.org>
References: <20260605002912.3456868-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ethnl_bcast_seq is a global counter stamped into the nlmsg_seq field
of every multicast notification, allowing userspace to detect dropped
messages. Today the ordering is achieved by using rtnl_lock().

Moving forward we will want ethtool ops to run under just the netdev
instance lock so to establish ordering we need a separate lock
for notifications. With the netdev instance locks operations on
different devices may bypass each other but the expectation is
that it should not matter. What we need to prevent is:
 - notification IDs getting out of order
 - operations on one device getting out of order

For simplicity defer allocating the ID of the notification right
before the notification is delivered. This removes the need for
special handling in ethnl_rss_create_send_ntf().

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/ethtool/netlink.h |  1 -
 net/ethtool/netlink.c | 28 +++++++++++++++++-----------
 net/ethtool/rss.c     |  1 -
 3 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
index 674c9c19529b..f94aaa66379c 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -10,7 +10,6 @@
 
 struct ethnl_req_info;
 
-u32 ethnl_bcast_seq_next(void);
 int ethnl_parse_header_dev_get(struct ethnl_req_info *req_info,
 			       const struct nlattr *nest, struct net *net,
 			       struct netlink_ext_ack *extack,
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 25e22c48060a..c4054a9795ff 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -13,6 +13,12 @@
 static struct genl_family ethtool_genl_family;
 
 static bool ethnl_ok __read_mostly;
+
+/* Serializes broadcast notification sequence allocation with the multicast
+ * send, so that userspace observes nlmsg_seq monotonic in receive order
+ * regardless of which lock the caller holds (rtnl or instance lock).
+ */
+static DEFINE_MUTEX(ethnl_bcast_lock);
 static u32 ethnl_bcast_seq;
 
 #define ETHTOOL_FLAGS_BASIC (ETHTOOL_FLAG_COMPACT_BITSETS |	\
@@ -82,12 +88,6 @@ static void ethnl_sock_priv_destroy(void *priv)
 	}
 }
 
-u32 ethnl_bcast_seq_next(void)
-{
-	ASSERT_RTNL();
-	return ++ethnl_bcast_seq;
-}
-
 int ethnl_ops_begin(struct net_device *dev)
 {
 	int ret;
@@ -329,8 +329,7 @@ void *ethnl_dump_put(struct sk_buff *skb, struct netlink_callback *cb, u8 cmd)
 
 void *ethnl_bcastmsg_put(struct sk_buff *skb, u8 cmd)
 {
-	return genlmsg_put(skb, 0, ++ethnl_bcast_seq, &ethtool_genl_family, 0,
-			   cmd);
+	return genlmsg_put(skb, 0, 0, &ethtool_genl_family, 0, cmd);
 }
 
 void *ethnl_unicast_put(struct sk_buff *skb, u32 portid, u32 seq, u8 cmd)
@@ -340,8 +339,15 @@ void *ethnl_unicast_put(struct sk_buff *skb, u32 portid, u32 seq, u8 cmd)
 
 int ethnl_multicast(struct sk_buff *skb, struct net_device *dev)
 {
-	return genlmsg_multicast_netns(&ethtool_genl_family, dev_net(dev), skb,
-				       0, ETHNL_MCGRP_MONITOR, GFP_KERNEL);
+	struct nlmsghdr *nlh = nlmsg_hdr(skb);
+	int ret;
+
+	mutex_lock(&ethnl_bcast_lock);
+	nlh->nlmsg_seq = ++ethnl_bcast_seq;
+	ret = genlmsg_multicast_netns(&ethtool_genl_family, dev_net(dev), skb,
+				      0, ETHNL_MCGRP_MONITOR, GFP_KERNEL);
+	mutex_unlock(&ethnl_bcast_lock);
+	return ret;
 }
 
 /* GET request helpers */
@@ -1081,7 +1087,7 @@ void ethnl_notify(struct net_device *dev, unsigned int cmd,
 {
 	if (unlikely(!ethnl_ok))
 		return;
-	ASSERT_RTNL();
+	netdev_assert_locked_ops_compat(dev);
 
 	if (likely(cmd < ARRAY_SIZE(ethnl_notify_handlers) &&
 		   ethnl_notify_handlers[cmd]))
diff --git a/net/ethtool/rss.c b/net/ethtool/rss.c
index 53792f53f922..65bad23d5c59 100644
--- a/net/ethtool/rss.c
+++ b/net/ethtool/rss.c
@@ -995,7 +995,6 @@ ethnl_rss_create_send_ntf(const struct sk_buff *rsp, struct net_device *dev)
 	nlh = nlmsg_hdr(ntf);
 	/* Convert the reply into a notification */
 	nlh->nlmsg_pid = 0;
-	nlh->nlmsg_seq = ethnl_bcast_seq_next();
 
 	genl_hdr = nlmsg_data(nlh);
 	genl_hdr->cmd =	ETHTOOL_MSG_RSS_CREATE_NTF;
-- 
2.54.0

