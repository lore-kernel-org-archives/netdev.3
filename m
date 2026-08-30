Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA22829D270
	for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 06:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788072260; cv=none; b=etSK2Tuo2KeLAnaUIxtpX/VLdCc6GNcFA4xq647Hxhm3kDHMFadvsNsZPE95YZfibt/F5QSio7eETp+vsFsFR6OZDGkrCRfEbnh7tEesWbHmnL+Eyy5YmdVHQdX7HCJrBXyvOcN9vCsp29AsL3sghxa2XqLLFFEblRNpsswYg/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788072260; c=relaxed/simple;
	bh=dfjKbL38ZCsk+NKI2vxv+s2/LGMwOsOftivUdrkfnd8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wu05LkSEdRf8orK6tCILgkN8Vic2XAHkPIeoj2ZN7hlW+EJGUjOWHR0F8EglJfk4ZCavOVubvt7p0v9GLVH+N5DUlfHb3kuYXvA3PtXrCY7AkzYgzv0N7bUQ5CjLfb052A5w/iPz9kKQre8UIG3p8TVX0ZiL5R7uihSCawKpFwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HkoMyvlv; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HkoMyvlv"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-39647184c73so3237076a91.1
        for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 23:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788072258; x=1788677058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PdqAZIU1Z/8e/wvfkIoVfluih634B0Tcjlm4K5JbosQ=;
        b=HkoMyvlvBmzb2intv2939IFMOq3D5dhaoV3hr6nwmeheyu2LsANfmRF67mxeJI3GjR
         Vr5nB+gWcApYjwrWrigwel3SbHYP8zscAq+ng0lOUwqA7BgdB1DY+opDFgR4mryxe5uT
         4jzVEtUmjOKnMNw8rJ9sc0CCHRUr4Y3zGnq6iw1TCAXysWHw8kHHyultOUpL0LKfdmxo
         Ka9boIgFmDivEMqdIh/ESe27qJo5KxxCc9H8/uny8M6+QNVwYOpnP/vPmlZCUOYBUJ5j
         qwCVopyBQqMa5nbNoPyJ5F+vjPbUGRVCJP/WDax+kl4glfqousXl3U3i22zDTiOu2LJj
         M53w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788072258; x=1788677058;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PdqAZIU1Z/8e/wvfkIoVfluih634B0Tcjlm4K5JbosQ=;
        b=Ww/bHCfpN5TVvJggSN3em1HNHvq37jhhD2nm+uDFrJDX06vCyWqx+Vy/O/TaeBUAEF
         4ERjO9h/IVHgltHe+S9btMZ9MQSYxMxQSRX8rlrftuspuNS6U57bxFAd7vock4FhvkVu
         pCV9FbhdOTP51mP6v3720H6KAULbg/Lfqkovrv/cl7nwgxc1JX3eHHJY30YQWyBgnoCj
         kEg0WnF0uSou/C1rpHMsTP59LujlIpsPto7by/PSeypqc7IVKb7kHcvyKLhsVoCT9w3n
         Zx3pmcUCVN8QgA7OWLWuENtKaQkkXg1HTGrqWlZxBZ419wKiumuwu9/KohnxvHKC92C5
         5ByQ==
X-Gm-Message-State: AFuF++nB114MQ0pi95ipUTLjEdV3ZW3hFMk/lDrrAnEklkJqA7OiBBXX
	9z/IL3vLiAHD8j2YOy3S0p+QVppIbF9Uw9yydB32w83b1eiGXebTaUIs/jXPb6vwrI8=
X-Gm-Gg: AYBFou0DplIXIg7wh3FvvWT9U9WG7a7WGpmxV5pTyPOrTJ9/wOG6Ivb9HHGes9NExq3
	9dz7McMIy+TIlirkG8SJcSvXjVQb/QpLeZc62/hYVIrWS9QzEc8ORpsQ8cFe5WTVzk5SUcng3cV
	hNYmpNoTrRahAQJ1JFasabJKtYGqgrUi8S7f1nUVgIbt7lX8bs9acAHLohRxk00nB0N/0K0br/Y
	cTV3JwDTgy9Llumehz8aa6iOca2qcSwGJFbD49jRFcigHg/Z/2mKWTeHB30FQ7/E53XCBc1yI2I
	tcE0OtR14CqgsRDFIrru03c3rOuhB9pAuldnuSPdoHMJIgUKSlbxSp5simGAPWyWDLObREPl2uB
	j6C6gtbxhiCfxAOtrNDkk5ZJwwzgNXI7xIC7FXfJ2+VzbEU3+FDoyrTue0FLk9Q/8E5zRfJPb87
	Qw4R8Ses6CBy5LtyxafeH3wSE3/LpfpbLhGmeWJqSGpQ/cdC0l72Uc+RxZ8mwoUaDt
X-Received: by 2002:a17:90b:1d0d:b0:398:9bd3:d6d1 with SMTP id 98e67ed59e1d1-398da6f3ec3mr579415a91.11.1788072258016;
        Sat, 29 Aug 2026 23:44:18 -0700 (PDT)
Received: from fedora ([2406:3003:2000:232d:8687:63a8:d931:9b81])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396dda36a53sm10135227a91.3.2026.08.29.23.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 23:44:17 -0700 (PDT)
From: Wong Boon Jhee <wongboonjhee52@gmail.com>
To: netdev@vger.kernel.org
Cc: sam@mendozajonas.com,
	wongboonjhee52@gmail.com
Subject: [PATCH v3] net/ncsi: Fix Use-After-Free in NCSI channel and package removal
Date: Sun, 30 Aug 2026 14:43:38 +0800
Message-ID: <20260830064337.327128-2-wongboonjhee52@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In net/ncsi/ncsi-manage.c, ncsi_remove_channel() and
ncsi_remove_package() remove objects from an RCU-protected linked list
using list_del_rcu() and immediately free them using kfree().

Because there is no call to synchronize_rcu() or kfree_rcu(), concurrent
readers traversing these lists under rcu_read_lock() (such as Netlink
dump handlers) can still hold a valid pointer to the object. When kfree()
executes, the reader is left holding a dangling pointer to freed memory,
resulting in a slab-use-after-free.

This patch fixes the issue by implementing a proper kref and RCU lifetime
model for NCSI objects. It replaces kfree() with kfree_rcu() / call_rcu()
to defer memory freeing until all pre-existing RCU readers have finished
their critical sections. It also introduces a kref for ncsi_dev_priv to
prevent the device structure from being freed while netlink handlers are
still operating on it. Concurrent lockless readers are now explicitly
protected with rcu_read_lock().

RCU read-side critical sections are added around lockless package and
channel traversals that may race with object removal. The KASAN
reproducer no longer reports the slab-use-after-free.

Fixes: 2d283bdd079c ("net/ncsi: Resource management")
Signed-off-by: Wong Boon Jhee <wongboonjhee52@gmail.com>
---
 net/ncsi/internal.h     |   8 ++-
 net/ncsi/ncsi-manage.c  | 113 ++++++++++++++++++++++++++++++++--------
 net/ncsi/ncsi-netlink.c |  56 ++++++++++++++++----
 3 files changed, 144 insertions(+), 33 deletions(-)

diff --git a/net/ncsi/internal.h b/net/ncsi/internal.h
index adee6dcabdc3..fbd90f270f5e 100644
--- a/net/ncsi/internal.h
+++ b/net/ncsi/internal.h
@@ -239,6 +239,7 @@ struct ncsi_channel {
 	} monitor;
 	struct list_head            node;
 	struct list_head            link;
+	struct rcu_head             rcu; /* RCU cleanup */
 };
 
 struct ncsi_package {
@@ -253,6 +254,7 @@ struct ncsi_package {
 	bool                 multi_channel; /* Enable multiple channels  */
 	u32                  channel_whitelist; /* Channels to configure */
 	struct ncsi_channel  *preferred_channel; /* Primary channel      */
+	struct rcu_head      rcu; /* RCU cleanup */
 };
 
 struct ncsi_request {
@@ -315,6 +317,8 @@ struct vlan_vid {
 };
 
 struct ncsi_dev_priv {
+	struct rcu_head     rcu;             /* RCU cleanup */
+	struct kref         ref;
 	struct ncsi_dev     ndev;            /* Associated NCSI device     */
 	unsigned int        flags;           /* NCSI device flags          */
 #define NCSI_DEV_PROBED		1            /* Finalized NCSI topology    */
@@ -337,6 +341,7 @@ struct ncsi_dev_priv {
 	struct ncsi_channel *active_channel; /* Currently handled channel  */
 	struct list_head    channel_queue;   /* Config queue of channels   */
 	struct work_struct  work;            /* For channel management     */
+	bool                work_cancelled;  /* Work has been cancelled    */
 	struct packet_type  ptype;           /* NCSI packet Rx handler     */
 	struct list_head    node;            /* Form NCSI device list      */
 #define NCSI_MAX_VLAN_VIDS	15
@@ -406,7 +411,8 @@ int ncsi_update_tx_channel(struct ncsi_dev_priv *ndp,
 			   struct ncsi_package *np,
 			   struct ncsi_channel *disable,
 			   struct ncsi_channel *enable);
-
+struct ncsi_dev_priv *ncsi_dev_get(struct net_device *dev);
+void ncsi_dev_put(struct ncsi_dev_priv *ndp);
 /* Packet handlers */
 u32 ncsi_calculate_checksum(unsigned char *data, int len);
 int ncsi_xmit_cmd(struct ncsi_cmd_arg *nca);
diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
index 54d0df0a9efe..afc34c2b3613 100644
--- a/net/ncsi/ncsi-manage.c
+++ b/net/ncsi/ncsi-manage.c
@@ -10,6 +10,7 @@
 #include <linux/skbuff.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/rcupdate.h>
 
 #include <net/ncsi.h>
 #include <net/net_namespace.h>
@@ -35,17 +36,23 @@ bool ncsi_channel_is_last(struct ncsi_dev_priv *ndp,
 {
 	struct ncsi_package *np;
 	struct ncsi_channel *nc;
+	bool is_last = true;
 
-	NCSI_FOR_EACH_PACKAGE(ndp, np)
+	rcu_read_lock();
+	NCSI_FOR_EACH_PACKAGE(ndp, np) {
 		NCSI_FOR_EACH_CHANNEL(np, nc) {
 			if (nc == channel)
 				continue;
 			if (nc->state == NCSI_CHANNEL_ACTIVE &&
-			    ncsi_channel_has_link(nc))
-				return false;
+			    ncsi_channel_has_link(nc)) {
+				is_last = false;
+				goto out;
+			}
 		}
-
-	return true;
+	}
+ out:
+	rcu_read_unlock();
+	return is_last;
 }
 
 static void ncsi_report_link(struct ncsi_dev_priv *ndp, bool force_down)
@@ -62,6 +69,7 @@ static void ncsi_report_link(struct ncsi_dev_priv *ndp, bool force_down)
 	}
 
 	nd->link_up = 0;
+	rcu_read_lock();
 	NCSI_FOR_EACH_PACKAGE(ndp, np) {
 		NCSI_FOR_EACH_CHANNEL(np, nc) {
 			spin_lock_irqsave(&nc->lock, flags);
@@ -75,12 +83,14 @@ static void ncsi_report_link(struct ncsi_dev_priv *ndp, bool force_down)
 			if (ncsi_channel_has_link(nc)) {
 				spin_unlock_irqrestore(&nc->lock, flags);
 				nd->link_up = 1;
+				rcu_read_unlock();
 				goto report;
 			}
 
 			spin_unlock_irqrestore(&nc->lock, flags);
 		}
 	}
+	rcu_read_unlock();
 
 report:
 	nd->handler(nd);
@@ -242,28 +252,37 @@ struct ncsi_channel *ncsi_add_channel(struct ncsi_package *np, unsigned char id)
 	return nc;
 }
 
+static void ncsi_channel_rcu_free(struct rcu_head *head)
+{
+	struct ncsi_channel *nc = container_of(head, struct ncsi_channel, rcu);
+
+	kfree(nc->mac_filter.addrs);
+	kfree(nc->vlan_filter.vids);
+	kfree(nc);
+}
+
 static void ncsi_remove_channel(struct ncsi_channel *nc)
 {
 	struct ncsi_package *np = nc->package;
+	struct ncsi_dev_priv *ndp = np->ndp;
 	unsigned long flags;
 
-	spin_lock_irqsave(&nc->lock, flags);
-
-	/* Release filters */
-	kfree(nc->mac_filter.addrs);
-	kfree(nc->vlan_filter.vids);
+	ncsi_stop_channel_monitor(nc);
 
+	spin_lock_irqsave(&nc->lock, flags);
 	nc->state = NCSI_CHANNEL_INACTIVE;
 	spin_unlock_irqrestore(&nc->lock, flags);
-	ncsi_stop_channel_monitor(nc);
 
-	/* Remove and free channel */
+	spin_lock_irqsave(&ndp->lock, flags);
+	list_del_rcu(&nc->link);
+	spin_unlock_irqrestore(&ndp->lock, flags);
+
 	spin_lock_irqsave(&np->lock, flags);
 	list_del_rcu(&nc->node);
 	np->channel_num--;
 	spin_unlock_irqrestore(&np->lock, flags);
 
-	kfree(nc);
+	call_rcu(&nc->rcu, ncsi_channel_rcu_free);
 }
 
 struct ncsi_package *ncsi_find_package(struct ncsi_dev_priv *ndp,
@@ -326,7 +345,7 @@ void ncsi_remove_package(struct ncsi_package *np)
 	ndp->package_num--;
 	spin_unlock_irqrestore(&ndp->lock, flags);
 
-	kfree(np);
+	kfree_rcu(np, rcu);
 }
 
 void ncsi_find_package_and_channel(struct ncsi_dev_priv *ndp,
@@ -409,7 +428,8 @@ void ncsi_free_request(struct ncsi_request *nr)
 	spin_unlock_irqrestore(&ndp->lock, flags);
 
 	if (driven && cmd && --ndp->pending_req_num == 0)
-		schedule_work(&ndp->work);
+		if (!READ_ONCE(ndp->work_cancelled))
+			schedule_work(&ndp->work);
 
 	/* Release command and response */
 	consume_skb(cmd);
@@ -912,6 +932,7 @@ int ncsi_update_tx_channel(struct ncsi_dev_priv *ndp,
 	nca.req_flags = 0;
 
 	/* Find current channel with Tx enabled */
+	rcu_read_lock();
 	NCSI_FOR_EACH_PACKAGE(ndp, np) {
 		if (disable)
 			break;
@@ -924,8 +945,10 @@ int ncsi_update_tx_channel(struct ncsi_dev_priv *ndp,
 				break;
 			}
 	}
+	rcu_read_unlock();
 
 	/* Find a suitable channel for Tx */
+	rcu_read_lock();
 	NCSI_FOR_EACH_PACKAGE(ndp, np) {
 		if (enable)
 			break;
@@ -951,6 +974,7 @@ int ncsi_update_tx_channel(struct ncsi_dev_priv *ndp,
 			}
 		}
 	}
+	rcu_read_unlock();
 
 	if (disable == enable)
 		return -1;
@@ -1253,6 +1277,7 @@ static int ncsi_choose_active_channel(struct ncsi_dev_priv *ndp)
 	 */
 	found = NULL;
 	with_link = false;
+	rcu_read_lock();
 	NCSI_FOR_EACH_PACKAGE(ndp, np) {
 		if (!(ndp->package_whitelist & (0x1 << np->id)))
 			continue;
@@ -1304,6 +1329,7 @@ static int ncsi_choose_active_channel(struct ncsi_dev_priv *ndp)
 		if (with_link && !ndp->multi_package)
 			break;
 	}
+	rcu_read_unlock();
 
 	if (list_empty(&ndp->channel_queue) && found) {
 		netdev_info(ndp->ndev.dev,
@@ -1332,6 +1358,7 @@ static bool ncsi_check_hwa(struct ncsi_dev_priv *ndp)
 	/* The hardware arbitration is disabled if any one channel
 	 * doesn't support explicitly.
 	 */
+	rcu_read_lock();
 	NCSI_FOR_EACH_PACKAGE(ndp, np) {
 		NCSI_FOR_EACH_CHANNEL(np, nc) {
 			has_channel = true;
@@ -1345,6 +1372,7 @@ static bool ncsi_check_hwa(struct ncsi_dev_priv *ndp)
 			}
 		}
 	}
+	rcu_read_unlock();
 
 	if (has_channel) {
 		ndp->flags |= NCSI_DEV_HWA;
@@ -1782,6 +1810,7 @@ struct ncsi_dev *ncsi_register_dev(struct net_device *dev,
 	ndp->package_whitelist = UINT_MAX;
 
 	/* Initialize private NCSI device */
+	kref_init(&ndp->ref);
 	spin_lock_init(&ndp->lock);
 	INIT_LIST_HEAD(&ndp->packages);
 	ndp->request_id = NCSI_REQ_START_IDX;
@@ -1952,23 +1981,65 @@ int ncsi_reset_dev(struct ncsi_dev *nd)
 	return 0;
 }
 
+static void ncsi_dev_release(struct kref *ref)
+{
+	struct ncsi_dev_priv *ndp;
+
+	ndp = container_of(ref, struct ncsi_dev_priv, ref);
+	kfree_rcu(ndp, rcu);
+}
+
+struct ncsi_dev_priv *ncsi_dev_get(struct net_device *dev)
+{
+	struct ncsi_dev_priv *ndp = NULL;
+	struct ncsi_dev *nd;
+
+	rcu_read_lock();
+	nd = ncsi_find_dev(dev);
+	if (nd) {
+		ndp = TO_NCSI_DEV_PRIV(nd);
+		/* Safely grab a reference while under RCU lock */
+		if (!kref_get_unless_zero(&ndp->ref))
+			ndp = NULL;
+	}
+	rcu_read_unlock();
+
+	return ndp;
+}
+
+void ncsi_dev_put(struct ncsi_dev_priv *ndp)
+{
+	if (ndp)
+		kref_put(&ndp->ref, ncsi_dev_release);
+}
+
 void ncsi_unregister_dev(struct ncsi_dev *nd)
 {
 	struct ncsi_dev_priv *ndp = TO_NCSI_DEV_PRIV(nd);
 	struct ncsi_package *np, *tmp;
 	unsigned long flags;
 
-	dev_remove_pack(&ndp->ptype);
-
-	list_for_each_entry_safe(np, tmp, &ndp->packages, node)
-		ncsi_remove_package(np);
-
 	spin_lock_irqsave(&ncsi_dev_lock, flags);
 	list_del_rcu(&ndp->node);
 	spin_unlock_irqrestore(&ncsi_dev_lock, flags);
 
+	spin_lock_irqsave(&ndp->lock, flags);
+	ndp->work_cancelled = true;
+	spin_unlock_irqrestore(&ndp->lock, flags);
+
+	for (int i = 0; i < ARRAY_SIZE(ndp->requests); i++) {
+		struct ncsi_request *nr = &ndp->requests[i];
+
+		if (nr->enabled)
+			ncsi_free_request(nr);
+	}
+
+	dev_remove_pack(&ndp->ptype);
 	disable_work_sync(&ndp->work);
 
-	kfree(ndp);
+	list_for_each_entry_safe(np, tmp, &ndp->packages, node)
+		ncsi_remove_package(np);
+
+	kref_put(&ndp->ref, ncsi_dev_release);
 }
 EXPORT_SYMBOL_GPL(ncsi_unregister_dev);
diff --git a/net/ncsi/ncsi-netlink.c b/net/ncsi/ncsi-netlink.c
index 8cc538358f6a..59fd735c367a 100644
--- a/net/ncsi/ncsi-netlink.c
+++ b/net/ncsi/ncsi-netlink.c
@@ -35,8 +35,6 @@ static struct ncsi_dev_priv *ndp_from_ifindex(struct net *net, u32 ifindex)
 {
 	struct ncsi_dev_priv *ndp;
 	struct net_device *dev;
-	struct ncsi_dev *nd;
-	struct ncsi_dev;
 
 	if (!net)
 		return NULL;
@@ -47,9 +45,7 @@ static struct ncsi_dev_priv *ndp_from_ifindex(struct net *net, u32 ifindex)
 		return NULL;
 	}
 
-	nd = ncsi_find_dev(dev);
-	ndp = nd ? TO_NCSI_DEV_PRIV(nd) : NULL;
-
+	ndp = ncsi_dev_get(dev);
 	dev_put(dev);
 	return ndp;
 }
@@ -175,13 +171,16 @@ static int ncsi_pkg_info_nl(struct sk_buff *msg, struct genl_info *info)
 		return -ENODEV;
 
 	skb = genlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
-	if (!skb)
+	if (!skb) {
+		ncsi_dev_put(ndp);
 		return -ENOMEM;
+	}
 
 	hdr = genlmsg_put(skb, info->snd_portid, info->snd_seq,
 			  &ncsi_genl_family, 0, NCSI_CMD_PKG_INFO);
 	if (!hdr) {
 		kfree_skb(skb);
+		ncsi_dev_put(ndp);
 		return -EMSGSIZE;
 	}
 
@@ -190,9 +189,13 @@ static int ncsi_pkg_info_nl(struct sk_buff *msg, struct genl_info *info)
 	attr = nla_nest_start_noflag(skb, NCSI_ATTR_PACKAGE_LIST);
 	if (!attr) {
 		kfree_skb(skb);
+		ncsi_dev_put(ndp);
 		return -EMSGSIZE;
 	}
+
+	rcu_read_lock();
 	rc = ncsi_write_package_info(skb, ndp, package_id);
+	rcu_read_unlock();
 
 	if (rc) {
 		nla_nest_cancel(skb, attr);
@@ -202,10 +205,12 @@ static int ncsi_pkg_info_nl(struct sk_buff *msg, struct genl_info *info)
 	nla_nest_end(skb, attr);
 
 	genlmsg_end(skb, hdr);
+	ncsi_dev_put(ndp);
 	return genlmsg_reply(skb, info);
 
 err:
 	kfree_skb(skb);
+	ncsi_dev_put(ndp);
 	return rc;
 }
 
@@ -235,14 +240,17 @@ static int ncsi_pkg_info_all_nl(struct sk_buff *skb,
 		return -ENODEV;
 
 	package_id = cb->args[0];
+	rcu_read_lock();
 	package = NULL;
 	NCSI_FOR_EACH_PACKAGE(ndp, np)
 		if (np->id == package_id)
 			package = np;
 
-	if (!package)
+	if (!package) {
+		rcu_read_unlock();
+		ncsi_dev_put(ndp);
 		return 0; /* done */
-
+	}
 	hdr = genlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_seq,
 			  &ncsi_genl_family, NLM_F_MULTI,  NCSI_CMD_PKG_INFO);
 	if (!hdr) {
@@ -255,7 +263,9 @@ static int ncsi_pkg_info_all_nl(struct sk_buff *skb,
 		rc = -EMSGSIZE;
 		goto err;
 	}
+
 	rc = ncsi_write_package_info(skb, ndp, package->id);
+
 	if (rc) {
 		nla_nest_cancel(skb, attr);
 		goto err;
@@ -266,9 +276,13 @@ static int ncsi_pkg_info_all_nl(struct sk_buff *skb,
 
 	cb->args[0] = package_id + 1;
 
+	rcu_read_unlock();
+	ncsi_dev_put(ndp);
 	return skb->len;
 err:
+	rcu_read_unlock();
 	genlmsg_cancel(skb, hdr);
+	ncsi_dev_put(ndp);
 	return rc;
 }
 
@@ -297,11 +311,15 @@ static int ncsi_set_interface_nl(struct sk_buff *msg, struct genl_info *info)
 	package_id = nla_get_u32(info->attrs[NCSI_ATTR_PACKAGE_ID]);
 	package = NULL;
 
+	rcu_read_lock();
 	NCSI_FOR_EACH_PACKAGE(ndp, np)
 		if (np->id == package_id)
 			package = np;
+
 	if (!package) {
 		/* The user has set a package that does not exist */
+		rcu_read_unlock();
+		ncsi_dev_put(ndp);
 		return -ERANGE;
 	}
 
@@ -317,6 +335,8 @@ static int ncsi_set_interface_nl(struct sk_buff *msg, struct genl_info *info)
 			netdev_info(ndp->ndev.dev,
 				    "NCSI: Channel %u does not exist!\n",
 				    channel_id);
+			rcu_read_unlock();
+			ncsi_dev_put(ndp);
 			return -ERANGE;
 		}
 	}
@@ -337,6 +357,7 @@ static int ncsi_set_interface_nl(struct sk_buff *msg, struct genl_info *info)
 		package->preferred_channel = NULL;
 	}
 	spin_unlock_irqrestore(&package->lock, flags);
+	rcu_read_unlock();
 
 	if (channel)
 		netdev_info(ndp->ndev.dev,
@@ -350,6 +371,7 @@ static int ncsi_set_interface_nl(struct sk_buff *msg, struct genl_info *info)
 	if (!(ndp->flags & NCSI_DEV_RESET))
 		ncsi_reset_dev(&ndp->ndev);
 
+	ncsi_dev_put(ndp);
 	return 0;
 }
 
@@ -376,6 +398,7 @@ static int ncsi_clear_interface_nl(struct sk_buff *msg, struct genl_info *info)
 	ndp->multi_package = false;
 	spin_unlock_irqrestore(&ndp->lock, flags);
 
+	rcu_read_lock();
 	NCSI_FOR_EACH_PACKAGE(ndp, np) {
 		spin_lock_irqsave(&np->lock, flags);
 		np->multi_channel = false;
@@ -383,18 +406,21 @@ static int ncsi_clear_interface_nl(struct sk_buff *msg, struct genl_info *info)
 		np->preferred_channel = NULL;
 		spin_unlock_irqrestore(&np->lock, flags);
 	}
+	rcu_read_unlock();
+
 	netdev_info(ndp->ndev.dev, "NCSI: Cleared preferred package/channel\n");
 
 	/* Update channel configuration */
 	if (!(ndp->flags & NCSI_DEV_RESET))
 		ncsi_reset_dev(&ndp->ndev);
 
+	ncsi_dev_put(ndp);
 	return 0;
 }
 
 static int ncsi_send_cmd_nl(struct sk_buff *msg, struct genl_info *info)
 {
-	struct ncsi_dev_priv *ndp;
+	struct ncsi_dev_priv *ndp = NULL;
 	struct ncsi_pkt_hdr *hdr;
 	struct ncsi_cmd_arg nca;
 	unsigned char *data;
@@ -480,6 +506,7 @@ static int ncsi_send_cmd_nl(struct sk_buff *msg, struct genl_info *info)
 				      ret);
 	}
 out:
+	ncsi_dev_put(ndp);
 	return ret;
 }
 
@@ -639,6 +666,7 @@ static int ncsi_set_package_mask_nl(struct sk_buff *msg,
 			ncsi_reset_dev(&ndp->ndev);
 	}
 
+	ncsi_dev_put(ndp);
 	return rc;
 }
 
@@ -670,14 +698,17 @@ static int ncsi_set_channel_mask_nl(struct sk_buff *msg,
 
 	package_id = nla_get_u32(info->attrs[NCSI_ATTR_PACKAGE_ID]);
 	package = NULL;
+	rcu_read_lock();
 	NCSI_FOR_EACH_PACKAGE(ndp, np)
 		if (np->id == package_id) {
 			package = np;
 			break;
 		}
-	if (!package)
+	if (!package) {
+		rcu_read_unlock();
+		ncsi_dev_put(ndp);
 		return -ERANGE;
-
+	}
 	spin_lock_irqsave(&package->lock, flags);
 
 	channel = NULL;
@@ -690,6 +721,7 @@ static int ncsi_set_channel_mask_nl(struct sk_buff *msg,
 			}
 		if (!channel) {
 			spin_unlock_irqrestore(&package->lock, flags);
+			ncsi_dev_put(ndp);
 			return -ERANGE;
 		}
 		netdev_dbg(ndp->ndev.dev,
@@ -716,11 +748,13 @@ static int ncsi_set_channel_mask_nl(struct sk_buff *msg,
 	}
 
 	spin_unlock_irqrestore(&package->lock, flags);
+	rcu_read_unlock();
 
 	/* Update channel configuration */
 	if (!(ndp->flags & NCSI_DEV_RESET))
 		ncsi_reset_dev(&ndp->ndev);
 
+	ncsi_dev_put(ndp);
 	return 0;
 }
 
-- 
2.55.0

