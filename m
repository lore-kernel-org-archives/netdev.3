Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A77358381;
	Sat, 17 Oct 2026 02:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792205480; cv=none; b=rrnK1FlBZcWR6WE101QHp+EH/mVbadWWzDyDMmEFLkx+0ELGDhVxUM3Uoz1vBCbcPqf4mU3pe2g7DKFRNKU8etXhLSk8nat61Hdo72cwBSUw91SLqz3Y5sOM7kSuqkFaeCCfHANYAob60hD36LA75B8DuoEGe+wG1+M4HepoHjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792205480; c=relaxed/simple;
	bh=U89heu2jCTY4+XdnpuE6PJe92tymGs798OufEH3OCg4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p9O8cMJpdXuH8EoNKf9KssnEmCx7RcHRwMXJeG3Kdp0hkOjo2eQWNBjYq7kX2piHBrM8i14lhGEVv4sjFtykMq8Sm+g7r8Z763xkO2aZugRenjLBSE2w3QjaXJOjjiN68xGxRZtzKUFYn2MRRqlDiful6V2ysb9/8wzf/M/5rKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=dswa8D4l; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dswa8D4l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Tv
	qRxu3wZUl3qnl5HJMUarHybVvoBInfmiM14VK2s8A=; b=dswa8D4lN2JTphz21A
	iYickNEhzb/8Zy3bxjLkgSQydylgv+0RRZGMLZ96trDYhAvAugRQYBoxNoCWtkKH
	i6K4xQ5nQr6RhmaRrL/OdWdW72Lv6Mi+cHgBckiGXn5tUDNsNBepL+WWrXXwyZhF
	qkdDu++cOTwUkvLZd4LbVcUkg=
Received: from colol4bi5.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3f4lP4tJq7yDCAg--.63664S2;
	Sat, 17 Oct 2026 10:49:52 +0800 (CST)
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
Subject: [PATCH net v2] net/ncsi: fix use-after-free of ncsi_channel in ncsi_remove_channel()
Date: Sat, 17 Oct 2026 10:49:47 +0800
Message-ID: <20261017024947.420683-1-18983559317@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3f4lP4tJq7yDCAg--.63664S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxtw48tw17tr4DKw13JF1xAFb_yoW3CrWfpF
	W3try5Jw4jyryF9r9aka15Wr13Ar4rX3yUKwnxKw4fAa45GryUuFy7Aay09F15CrZ7uw42
	yw4jgw4Y9rs5JrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziiL08UUUUU=
X-CM-SenderInfo: jprymmytvvmjmrxbiqqrwthudrp/xtbC-BAcAGrS4lDP9QAA3A

The NCSI generic netlink package information paths walk the global
ncsi_dev_list (ndp_from_ifindex() -> ncsi_find_dev()) and the
ndp->packages / np->channels lists through the list_for_each_entry_rcu()
based NCSI_FOR_EACH_* macros, but they never enter an RCU read-side
critical section.  Everything these walkers touch is only unlinked with
list_del_rcu(), so the lifetime contract of the objects is "alive for an
RCU grace period after unlink"; a walker that does not hold
rcu_read_lock() has no protection at all once it is preempted mid-walk,
no matter what the free side does.

The teardown side breaks the other half of that contract for the
channels: ncsi_remove_channel() unlinks the channel from its package's
channel list with list_del_rcu() and then frees the channel's mac/vlan
filter arrays and the channel object itself immediately.  The netlink
walkers dereference deep into the channel --
ncsi_write_channel_info() reads nc->version.fw_name with nla_put_string()
(strlen) and iterates the nc->vlan_filter.vids[] entries -- so a reader
mid-walk reads freed memory when a teardown overlaps it.

Either half alone leaves the race, so fix both sides:

  * Enter the read-side critical section in the NCSI_CMD_PKG_INFO doit
    (ncsi_pkg_info_nl()) and dump (ncsi_pkg_info_all_nl()) handlers and
    keep it held across every dereference of ndp, np and nc.  The doit
    response skb is allocated before the lock is taken so that the
    GFP_KERNEL allocation does not run under rcu_read_lock(); the dump
    handler only appends to the callback skb it is given and can hold
    the lock across its whole walk.

  * Move the frees of nc->mac_filter.addrs, nc->vlan_filter.vids and nc
    into an RCU callback.  The two arrays are only reachable through
    the channel object, so they have to share its grace period.

The race needs no real NC hardware:

  writer: rmmod ftgmac100
            -> ftgmac100_remove() -> ncsi_unregister_dev()
            -> ncsi_remove_package() -> ncsi_remove_channel() -> kfree()
  reader: sendmsg(NETLINK_GENERIC, NCSI_CMD_PKG_INFO)
            -> ncsi_pkg_info_nl() -> ncsi_write_package_info()
            -> ncsi_write_channel_info()

(freeing happens before unregister_netdev(), so the netdev, and with it
the genl entry point, stays reachable during the whole window).

Tested on an arm multi_v7 kernel (KASAN + SLUB + PREEMPT) running as a
QEMU ast2600-evb guest with a host-side NC-SI responder; the PoC hammers
NCSI_CMD_PKG_INFO from four threads while cycling insmod/rmmod
ftgmac100 (doit and dump variants in parallel).  KASAN fires at the
first teardown of every boot:

  BUG: KASAN: slab-use-after-free in ncsi_write_package_info+0xa5c/0xf84
  Read of size 1 at addr c69019e0 by task poc_dump/68
  CPU: 0 UID: 0 PID: 68 Comm: poc_dump Not tainted 7.2.6 #1 PREEMPT
  Hardware name: Generic DT based system
  Call trace:
   ...
   kasan_report from ncsi_write_package_info+0xa5c/0xf84
   ncsi_write_package_info from ncsi_pkg_info_nl+0x320/0x63c
   ncsi_pkg_info_nl from genl_family_rcv_msg_doit+0x218/0x2d8
   genl_family_rcv_msg_doit from genl_rcv_msg+0x578/0xb24
   genl_rcv_msg from netlink_rcv_skb+0x134/0x3c4
   netlink_rcv_skb from genl_rcv+0x24/0x34
   genl_rcv from netlink_unicast+0x884/0xac0
   netlink_unicast from netlink_sendmsg+0x62c/0xb98
   netlink_sendmsg from __sys_sendto+0x290/0x3e0
   __sys_sendto from sys_send+0x18/0x20
   sys_send from ret_fast_syscall+0x0/0x5c

Found during a static-analysis-assisted audit: candidate sites were
surfaced by a Coccinelle rule, and the reader/writer paths were
confirmed by LLM-assisted (GLM-5.3) code inspection.

Fixes: 2d283bdd079c ("net/ncsi: Resource management")
Fixes: 955dc68cb9b2 ("net/ncsi: Add generic netlink family")
Signed-off-by: Binbin Deng <18983559317@163.com>
---
 net/ncsi/internal.h     |  1 +
 net/ncsi/ncsi-manage.c  | 20 ++++++++++++++------
 net/ncsi/ncsi-netlink.c | 36 ++++++++++++++++++++++++++----------
 3 files changed, 41 insertions(+), 16 deletions(-)

diff --git a/net/ncsi/internal.h b/net/ncsi/internal.h
index adee6dcabdc3..530834d8caa7 100644
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
index 54d0df0a9efe..c16047dee3f8 100644
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
+	/* Readers (netlink package info walkers, channel configuration
+	 * worker) may still hold the channel or its filter arrays;
+	 * release everything after a grace period.
+	 */
+	call_rcu(&nc->rcu, ncsi_channel_release);
 }
 
 struct ncsi_package *ncsi_find_package(struct ncsi_dev_priv *ndp,
diff --git a/net/ncsi/ncsi-netlink.c b/net/ncsi/ncsi-netlink.c
index 8cc538358f6a..3de607f6982c 100644
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
@@ -192,7 +187,21 @@ static int ncsi_pkg_info_nl(struct sk_buff *msg, struct genl_info *info)
 		kfree_skb(skb);
 		return -EMSGSIZE;
 	}
+	/* The device is resolved and the lists are walked inside an RCU
+	 * read-side critical section: the teardown path only unlinks these
+	 * objects and frees them after a grace period.
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
@@ -228,20 +237,26 @@ static int ncsi_pkg_info_all_nl(struct sk_buff *skb,
 	if (!attrs[NCSI_ATTR_IFINDEX])
 		return -EINVAL;
 
+	package_id = cb->args[0];
+
+	rcu_read_lock();
 	ndp = ndp_from_ifindex(get_net(sock_net(skb->sk)),
 			       nla_get_u32(attrs[NCSI_ATTR_IFINDEX]));
 
-	if (!ndp)
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
@@ -265,9 +280,10 @@ static int ncsi_pkg_info_all_nl(struct sk_buff *skb,
 	genlmsg_end(skb, hdr);
 
 	cb->args[0] = package_id + 1;
-
+	rcu_read_unlock();
 	return skb->len;
 err:
+	rcu_read_unlock();
 	genlmsg_cancel(skb, hdr);
 	return rc;
 }
-- 
2.43.0

