Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B672C1586;
	Mon, 19 Oct 2026 01:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792373949; cv=none; b=ja6AGk1oPwjl+u0n19k95yR7LcPgEFIs7KP7dkzpk8gMn7E8Gnd1vBA7hEoFFcp4V4psKMQLiouganK9zRusamA7Jvqp/wVLuiK0YMhbV6xCcB5qdHnh5S/fiGqLxKZRPOei3whA7ht8jGihs96xrRnBfYtL5fsV3LjtzTsGhBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792373949; c=relaxed/simple;
	bh=5rui/C8/wJsLi6T1Jt5Sswc9tCqTkSgTqc6tGhcDcjM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JTFEUvmhvqwtuW/Nr/UGLbefVbbOH8E21Zbsg/AZQHcpvtXS4joTohQ2nUmQSlVrsWPRsmk/QIsDCd+gtrXmf2ufCrG7SMnGugSqeQVaksA03aWKEhPwPphjv/meDYFzEbI8B0uDklGGCcIzkghfhu5o6r88eGpJalVBxIs157Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=i1W4sx8g; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="i1W4sx8g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=aC
	RFGGAvs4nIFnJc3XZnuc0+RIrIHT9UJji+bLTGziI=; b=i1W4sx8gKYQTDJzgoB
	wDUdgKQBS4fUDsaxfJ2K1xK00ehpMoX2Bgx/9Bl9f52z6aRXtqGRSEEiRtUF2poB
	VVQLN7nmpkCzsoD4JeNBErMY8FvA+L9HgeFqH59CCnFRcfXprCclG/ujAcNYiBe9
	N3tY2jH+tQuuzi73ikkBGh2r4=
Received: from colol4bi5.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3Hw12dNVqOC6qBA--.31638S2;
	Mon, 19 Oct 2026 09:37:59 +0800 (CST)
From: Binbin Deng <18983559317@163.com>
To: sam@mendozajonas.com,
	fercerpav@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	gwshan@linux.vnet.ibm.com,
	joel@jms.id.au
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Binbin Deng <18983559317@163.com>
Subject: [PATCH net v3] net/ncsi: fix use-after-free of ncsi_channel in ncsi_remove_channel()
Date: Mon, 19 Oct 2026 09:37:57 +0800
Message-ID: <20261019013757.450036-1-18983559317@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3Hw12dNVqOC6qBA--.31638S2
X-Coremail-Antispam: 1Uf129KBjvAXoWfJr4UJF48XF4rGFykWF17Jrb_yoW8GF1fXo
	WfXrW3Xr1kGr1UWayYq3ZaqFW7Za48Gr98Aan09w4kCFsxXrW5A343AanxWa4xZF4SkFWD
	ZFnrXw4vqay8tr4kn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4RRfOzDUUUU
X-CM-SenderInfo: jprymmytvvmjmrxbiqqrwthudrp/xtbC3xdKLmrVdHcxBQAA3k

ncsi_remove_channel() frees the channel filter arrays and the channel
itself immediately after list_del_rcu():

    kfree(nc->mac_filter.addrs);
    kfree(nc->vlan_filter.vids);
    ...
    list_del_rcu(&nc->node);
    ...
    kfree(nc);

The generic netlink package info walkers iterate np->channels with the
list_for_each_entry_rcu() based NCSI_FOR_EACH_CHANNEL() and
dereference deep into the channel: ncsi_write_channel_info() reads
nc->version.fw_name with nla_put_string() (strlen) and iterates
nc->vlan_filter.vids[].  No NCSI genl handler enters an RCU read-side
critical section -- genl doit and dumpit callbacks run under
genl_mutex and cb_mutex -- so a walk that overlaps the teardown reads
freed memory.  NCSI_CMD_PKG_INFO has no GENL_ADMIN_PERM, so an
unprivileged user can race it against rmmod of the driver:

  writer: rmmod ftgmac100
            -> ftgmac100_remove() -> ncsi_unregister_dev()
            -> ncsi_remove_package() -> ncsi_remove_channel()
  reader: sendmsg(NETLINK_GENERIC, NCSI_CMD_PKG_INFO)
            -> ncsi_pkg_info_nl() -> ncsi_write_package_info()

KASAN reports (arm multi_v7, QEMU ast2600-evb, KASAN + SLUB + PREEMPT,
four threads looping PKG_INFO doit/dump while cycling insmod/rmmod):

  BUG: KASAN: slab-use-after-free in ncsi_write_package_info+0xa5c/0xf84
  Read of size 1 at addr c69019e0 by task poc_dump/68
  The buggy address belongs to the object at c6901800
   which belongs to the cache kmalloc-1k of size 1024
  The buggy address is located 480 bytes inside of
   freed 1024-byte region [c6901800, c6901c00)

The 480-byte offset is nc->version.fw_name, read by the strlen() of
the nla_put_string() in ncsi_write_channel_info() inlined into the
walker; kmalloc-1k is the size class of struct ncsi_channel.  The
dump variant of the same reader is caught reading the freed filter
array instead:

  BUG: KASAN: slab-use-after-free in ncsi_write_package_info+0xb6c/0xf84
  Read of size 2 at addr c6b03600 by task poc_dump/72
  The buggy address belongs to the object at c6b03600
   which belongs to the cache kmalloc-64 of size 64
  The buggy address is located 0 bytes inside of
   freed 64-byte region [c6b03600, c6b03640)

which is the u16 vlan_filter.vids[] walk of the same handler.

Fix both halves of the contract for the channel:

  * The free of the channel and of the filter arrays, which are only
    reachable through the channel, moves into an RCU callback.

  * All seven genl handlers now resolve the device and walk the lists
    inside an RCU read-side critical section.  The critical sections
    are non-sleeping: the reply skb of the PKG_INFO doit is allocated
    before the lock is taken (genlmsg_new(GFP_KERNEL) must not run
    under rcu_read_lock()) and its unicast reply is sent after the
    walk; NCSI_CMD_SEND_CMD runs ncsi_xmit_cmd() under the lock (it
    only uses GFP_ATOMIC command skbs, spinlocks and
    dev_queue_xmit()) and defers its error notification, which uses
    the net_device captured inside the critical section.

  * The handlers used get_net(sock_net(skb->sk)), which takes a
    reference on init_net that is never dropped anywhere in
    net/ncsi/; plain sock_net() is enough as the socket pins the
    netns.

The channel configuration worker is not covered by the RCU callback
on purpose: it is quiesced by the companion series "net/ncsi: fix
use-after-free of ncsi_dev_priv in ncsi_unregister_dev()", which runs
disable_work_sync() before any object is released and stops every
channel monitor before the removal loop, so nothing re-arms them.
The packages and the device itself are deferred by that series and
by "net/ncsi: fix use-after-free of ncsi_package in
ncsi_remove_package()"; the race is closed by the three series
together.

Found by a Coccinelle rule matching kfree() immediately after
list_del_rcu(); the code inspection and the fix were LLM-assisted,
and the race was confirmed at runtime with KASAN as above.

Fixes: 2d283bdd079c ("net/ncsi: Resource management")
Fixes: 955dc68cb9b2 ("net/ncsi: Add generic netlink family")
Signed-off-by: Binbin Deng <18983559317@163.com>
---
 net/ncsi/internal.h     |  1 +
 net/ncsi/ncsi-manage.c  | 20 ++++++---
 net/ncsi/ncsi-netlink.c | 97 +++++++++++++++++++++++++++++++----------
 3 files changed, 90 insertions(+), 28 deletions(-)

diff --git a/net/ncsi/internal.h b/net/ncsi/internal.h
index 3630ee4..a077e90 100644
--- a/net/ncsi/internal.h
+++ b/net/ncsi/internal.h
@@ -239,6 +239,7 @@ struct ncsi_channel {
 	} monitor;
 	struct list_head            node;
 	struct list_head            link;
+	struct rcu_head             rcu;
 };
 
 struct ncsi_package {
diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
index 70cb31e..dc7f333 100644
--- a/net/ncsi/ncsi-manage.c
+++ b/net/ncsi/ncsi-manage.c
@@ -242,17 +242,21 @@ struct ncsi_channel *ncsi_add_channel(struct ncsi_package *np, unsigned char id)
 	return nc;
 }
 
+static void ncsi_channel_release(struct rcu_head *rcu)
+{
+	struct ncsi_channel *nc = container_of(rcu, struct ncsi_channel, rcu);
+
+	kfree(nc->mac_filter.addrs);
+	kfree(nc->vlan_filter.vids);
+	kfree(nc);
+}
+
 static void ncsi_remove_channel(struct ncsi_channel *nc)
 {
 	struct ncsi_package *np = nc->package;
 	unsigned long flags;
 
 	spin_lock_irqsave(&nc->lock, flags);
-
-	/* Release filters */
-	kfree(nc->mac_filter.addrs);
-	kfree(nc->vlan_filter.vids);
-
 	nc->state = NCSI_CHANNEL_INACTIVE;
 	spin_unlock_irqrestore(&nc->lock, flags);
 	ncsi_stop_channel_monitor(nc);
@@ -263,7 +267,11 @@ static void ncsi_remove_channel(struct ncsi_channel *nc)
 	np->channel_num--;
 	spin_unlock_irqrestore(&np->lock, flags);
 
-	kfree(nc);
+	/* Netlink walkers may still hold the channel or its filter
+	 * arrays; the arrays are only reachable through @nc and share
+	 * its grace period.
+	 */
+	call_rcu(&nc->rcu, ncsi_channel_release);
 }
 
 struct ncsi_package *ncsi_find_package(struct ncsi_dev_priv *ndp,
diff --git a/net/ncsi/ncsi-netlink.c b/net/ncsi/ncsi-netlink.c
index 8cc5383..7e4c77e 100644
--- a/net/ncsi/ncsi-netlink.c
+++ b/net/ncsi/ncsi-netlink.c
@@ -169,11 +169,6 @@ static int ncsi_pkg_info_nl(struct sk_buff *msg, struct genl_info *info)
 	if (!info->attrs[NCSI_ATTR_PACKAGE_ID])
 		return -EINVAL;
 
-	ndp = ndp_from_ifindex(genl_info_net(info),
-			       nla_get_u32(info->attrs[NCSI_ATTR_IFINDEX]));
-	if (!ndp)
-		return -ENODEV;
-
 	skb = genlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
 	if (!skb)
 		return -ENOMEM;
@@ -192,7 +187,24 @@ static int ncsi_pkg_info_nl(struct sk_buff *msg, struct genl_info *info)
 		kfree_skb(skb);
 		return -EMSGSIZE;
 	}
+
+	/* Resolve the device and walk its lists inside an RCU read-side
+	 * critical section.  The channel and its filter arrays are freed
+	 * from an RCU callback in this series; the packages and the
+	 * device itself get their grace periods from the companion fixes
+	 * for ncsi_remove_package() and ncsi_unregister_dev().
+	 */
+	rcu_read_lock();
+	ndp = ndp_from_ifindex(genl_info_net(info),
+			       nla_get_u32(info->attrs[NCSI_ATTR_IFINDEX]));
+	if (!ndp) {
+		rcu_read_unlock();
+		kfree_skb(skb);
+		return -ENODEV;
+	}
+
 	rc = ncsi_write_package_info(skb, ndp, package_id);
+	rcu_read_unlock();
 
 	if (rc) {
 		nla_nest_cancel(skb, attr);
@@ -228,20 +240,25 @@ static int ncsi_pkg_info_all_nl(struct sk_buff *skb,
 	if (!attrs[NCSI_ATTR_IFINDEX])
 		return -EINVAL;
 
-	ndp = ndp_from_ifindex(get_net(sock_net(skb->sk)),
-			       nla_get_u32(attrs[NCSI_ATTR_IFINDEX]));
+	package_id = cb->args[0];
 
-	if (!ndp)
+	rcu_read_lock();
+	ndp = ndp_from_ifindex(sock_net(skb->sk),
+			       nla_get_u32(attrs[NCSI_ATTR_IFINDEX]));
+	if (!ndp) {
+		rcu_read_unlock();
 		return -ENODEV;
+	}
 
-	package_id = cb->args[0];
 	package = NULL;
 	NCSI_FOR_EACH_PACKAGE(ndp, np)
 		if (np->id == package_id)
 			package = np;
 
-	if (!package)
+	if (!package) {
+		rcu_read_unlock();
 		return 0; /* done */
+	}
 
 	hdr = genlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_seq,
 			  &ncsi_genl_family, NLM_F_MULTI,  NCSI_CMD_PKG_INFO);
@@ -266,8 +283,10 @@ static int ncsi_pkg_info_all_nl(struct sk_buff *skb,
 
 	cb->args[0] = package_id + 1;
 
+	rcu_read_unlock();
 	return skb->len;
 err:
+	rcu_read_unlock();
 	genlmsg_cancel(skb, hdr);
 	return rc;
 }
@@ -289,10 +308,13 @@ static int ncsi_set_interface_nl(struct sk_buff *msg, struct genl_info *info)
 	if (!info->attrs[NCSI_ATTR_PACKAGE_ID])
 		return -EINVAL;
 
-	ndp = ndp_from_ifindex(get_net(sock_net(msg->sk)),
+	rcu_read_lock();
+	ndp = ndp_from_ifindex(sock_net(msg->sk),
 			       nla_get_u32(info->attrs[NCSI_ATTR_IFINDEX]));
-	if (!ndp)
+	if (!ndp) {
+		rcu_read_unlock();
 		return -ENODEV;
+	}
 
 	package_id = nla_get_u32(info->attrs[NCSI_ATTR_PACKAGE_ID]);
 	package = NULL;
@@ -302,6 +324,7 @@ static int ncsi_set_interface_nl(struct sk_buff *msg, struct genl_info *info)
 			package = np;
 	if (!package) {
 		/* The user has set a package that does not exist */
+		rcu_read_unlock();
 		return -ERANGE;
 	}
 
@@ -317,6 +340,7 @@ static int ncsi_set_interface_nl(struct sk_buff *msg, struct genl_info *info)
 			netdev_info(ndp->ndev.dev,
 				    "NCSI: Channel %u does not exist!\n",
 				    channel_id);
+			rcu_read_unlock();
 			return -ERANGE;
 		}
 	}
@@ -350,6 +374,7 @@ static int ncsi_set_interface_nl(struct sk_buff *msg, struct genl_info *info)
 	if (!(ndp->flags & NCSI_DEV_RESET))
 		ncsi_reset_dev(&ndp->ndev);
 
+	rcu_read_unlock();
 	return 0;
 }
 
@@ -365,10 +390,13 @@ static int ncsi_clear_interface_nl(struct sk_buff *msg, struct genl_info *info)
 	if (!info->attrs[NCSI_ATTR_IFINDEX])
 		return -EINVAL;
 
-	ndp = ndp_from_ifindex(get_net(sock_net(msg->sk)),
+	rcu_read_lock();
+	ndp = ndp_from_ifindex(sock_net(msg->sk),
 			       nla_get_u32(info->attrs[NCSI_ATTR_IFINDEX]));
-	if (!ndp)
+	if (!ndp) {
+		rcu_read_unlock();
 		return -ENODEV;
+	}
 
 	/* Reset any whitelists and disable multi mode */
 	spin_lock_irqsave(&ndp->lock, flags);
@@ -389,12 +417,14 @@ static int ncsi_clear_interface_nl(struct sk_buff *msg, struct genl_info *info)
 	if (!(ndp->flags & NCSI_DEV_RESET))
 		ncsi_reset_dev(&ndp->ndev);
 
+	rcu_read_unlock();
 	return 0;
 }
 
 static int ncsi_send_cmd_nl(struct sk_buff *msg, struct genl_info *info)
 {
 	struct ncsi_dev_priv *ndp;
+	struct net_device *dev;
 	struct ncsi_pkt_hdr *hdr;
 	struct ncsi_cmd_arg nca;
 	unsigned char *data;
@@ -427,17 +457,21 @@ static int ncsi_send_cmd_nl(struct sk_buff *msg, struct genl_info *info)
 		goto out;
 	}
 
-	ndp = ndp_from_ifindex(get_net(sock_net(msg->sk)),
+	rcu_read_lock();
+	ndp = ndp_from_ifindex(sock_net(msg->sk),
 			       nla_get_u32(info->attrs[NCSI_ATTR_IFINDEX]));
 	if (!ndp) {
+		rcu_read_unlock();
 		ret = -ENODEV;
 		goto out;
 	}
+	dev = ndp->ndev.dev;
 
 	package_id = nla_get_u32(info->attrs[NCSI_ATTR_PACKAGE_ID]);
 	channel_id = nla_get_u32(info->attrs[NCSI_ATTR_CHANNEL_ID]);
 
 	if (package_id >= NCSI_MAX_PACKAGE || channel_id >= NCSI_MAX_CHANNEL) {
+		rcu_read_unlock();
 		ret = -ERANGE;
 		goto out_netlink;
 	}
@@ -446,6 +480,7 @@ static int ncsi_send_cmd_nl(struct sk_buff *msg, struct genl_info *info)
 	if (len < sizeof(struct ncsi_pkt_hdr)) {
 		netdev_info(ndp->ndev.dev, "NCSI: no command to send %u\n",
 			    package_id);
+		rcu_read_unlock();
 		ret = -EINVAL;
 		goto out_netlink;
 	} else {
@@ -462,18 +497,25 @@ static int ncsi_send_cmd_nl(struct sk_buff *msg, struct genl_info *info)
 	nca.info = info;
 	nca.payload = ntohs(hdr->length);
 	if (nca.payload > len - sizeof(*hdr)) {
+		rcu_read_unlock();
 		ret = -EINVAL;
 		goto out_netlink;
 	}
 	nca.data = data + sizeof(*hdr);
 
+	/* ncsi_xmit_cmd() is safe to run under the RCU read-side
+	 * critical section: it only uses GFP_ATOMIC command skbs,
+	 * spinlocks and dev_queue_xmit().
+	 */
 	ret = ncsi_xmit_cmd(&nca);
+	rcu_read_unlock();
+
 out_netlink:
 	if (ret != 0) {
-		netdev_err(ndp->ndev.dev,
+		netdev_err(dev,
 			   "NCSI: Error %d sending command\n",
 			   ret);
-		ncsi_send_netlink_err(ndp->ndev.dev,
+		ncsi_send_netlink_err(dev,
 				      info->snd_seq,
 				      info->snd_portid,
 				      info->nlhdr,
@@ -608,10 +650,13 @@ static int ncsi_set_package_mask_nl(struct sk_buff *msg,
 	if (!info->attrs[NCSI_ATTR_PACKAGE_MASK])
 		return -EINVAL;
 
-	ndp = ndp_from_ifindex(get_net(sock_net(msg->sk)),
+	rcu_read_lock();
+	ndp = ndp_from_ifindex(sock_net(msg->sk),
 			       nla_get_u32(info->attrs[NCSI_ATTR_IFINDEX]));
-	if (!ndp)
+	if (!ndp) {
+		rcu_read_unlock();
 		return -ENODEV;
+	}
 
 	spin_lock_irqsave(&ndp->lock, flags);
 	if (nla_get_flag(info->attrs[NCSI_ATTR_MULTI_FLAG])) {
@@ -639,6 +684,7 @@ static int ncsi_set_package_mask_nl(struct sk_buff *msg,
 			ncsi_reset_dev(&ndp->ndev);
 	}
 
+	rcu_read_unlock();
 	return rc;
 }
 
@@ -663,10 +709,13 @@ static int ncsi_set_channel_mask_nl(struct sk_buff *msg,
 	if (!info->attrs[NCSI_ATTR_CHANNEL_MASK])
 		return -EINVAL;
 
-	ndp = ndp_from_ifindex(get_net(sock_net(msg->sk)),
+	rcu_read_lock();
+	ndp = ndp_from_ifindex(sock_net(msg->sk),
 			       nla_get_u32(info->attrs[NCSI_ATTR_IFINDEX]));
-	if (!ndp)
+	if (!ndp) {
+		rcu_read_unlock();
 		return -ENODEV;
+	}
 
 	package_id = nla_get_u32(info->attrs[NCSI_ATTR_PACKAGE_ID]);
 	package = NULL;
@@ -675,8 +724,10 @@ static int ncsi_set_channel_mask_nl(struct sk_buff *msg,
 			package = np;
 			break;
 		}
-	if (!package)
+	if (!package) {
+		rcu_read_unlock();
 		return -ERANGE;
+	}
 
 	spin_lock_irqsave(&package->lock, flags);
 
@@ -690,6 +741,7 @@ static int ncsi_set_channel_mask_nl(struct sk_buff *msg,
 			}
 		if (!channel) {
 			spin_unlock_irqrestore(&package->lock, flags);
+			rcu_read_unlock();
 			return -ERANGE;
 		}
 		netdev_dbg(ndp->ndev.dev,
@@ -721,6 +773,7 @@ static int ncsi_set_channel_mask_nl(struct sk_buff *msg,
 	if (!(ndp->flags & NCSI_DEV_RESET))
 		ncsi_reset_dev(&ndp->ndev);
 
+	rcu_read_unlock();
 	return 0;
 }
 
-- 
2.43.0

