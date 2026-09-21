Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B364C0420
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 15:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790005014; cv=none; b=RGTm114KE7q2V6XofzNbvVRjzdGS0kdchmtxUGlk2eY97BwTy+8nzGV3pA6AEysAY738Pj7wksD2v0cB7V7RunBTbS2VdvBPZ4kCAgXoA1moHM7Elr8xPHiKPiBs06qQXBZ5zNdDb7doslKXLL5MBgAN72kSNbb4gDW+3JbjMv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790005014; c=relaxed/simple;
	bh=Gbu8VWNKAjuSkfRIWlCP/D5M/aRsmzfh4vnpmiMXeSI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GqCwkR29Dkrrr7AsQ2grj5V6cdTflgUVghxVidNVScIm2WTPlhCQG1jJQquIxOA49Nqvb+7NFw26kZ7JNT2fEHe6LetZ9tN6r/sFE6E8OANGsbFD69LbVqvinhhznwKfyN23GzpbnjgoKEvlQRXeLjujjaea7bl6L0VT2GChuD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YcE8l4jL; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YcE8l4jL"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-398a147688bso3245752a91.1
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 08:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790005009; x=1790609809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nkmZr/sOgDuRQiHmNVl4p6TAmxDvforlyB7xdzWmXoU=;
        b=YcE8l4jL7XrljB2mv2treGWtXaaY5lShs/C4UUKQV9zI9R1G4PvR48E9cxraA1SB2F
         WYh/mwVXkMRUTDsuoMqXOQbMbvUkDKpdfAJYv5U3Jr02mC3jI9yYq291hhqLlJ3ux6Tu
         BqtuPkhXJjoUjUo8dWY2mnL+JxyvUlf8aGSp8NmR4UGFkjxbKkssL3rmdqHmOVcLwvnC
         euP0MKQu07lFbnPWmXhaN44yc2b4iW0F2/1s1E5MnJ956ePS1st9Q2PEwEPd1pI98VMb
         vah307/dJNEInp7o6qLrKM2hlsoWEJvdiS4CbNHkNIiEbeqqLCsQnjUphkMKHRxmKLgx
         962Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790005009; x=1790609809;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nkmZr/sOgDuRQiHmNVl4p6TAmxDvforlyB7xdzWmXoU=;
        b=qbLvTzlu3ItwA/1PbSAb07R3VxY72UDGDuHWfoRrEzjn7Qui71lqCZ0lkzDvpk1/Bm
         NTNiJ5GfSEUDkOsMHAWsqGabks+j1ighRUyCIc/s3i4Br/opR/W9jhz4rThJe2qrpGaK
         NHYQx3mIN4tdZvQRntl0DN/vzISwOej1U/fzP4peDhc5EqdsvLTQH/H0YhTxXsCqpXyb
         uIRuXIQeqSUq8zGVdjr8z8Ww607PBjvylOx70B2ZHbggw/noaRFIM++9mTZe2yYHlOYu
         N44QwOwb0EmAjdIcbg/WTrSlXCHYIfJ2uwLz8Ou1fGEpV6srtIKXzIGnWVNvVhxj5TO+
         RanQ==
X-Gm-Message-State: AFuF++lLlFpsLcWQLbF7ethxQlVR7pTVq8d1L9cA8c/oZNdjnfMx8OXR
	NPmJIr2IZtgJi9leysESWlFMpNQpyjGObK19hfqmRmA/Skk5EVY44xd0eXDBXFI9
X-Gm-Gg: AYBFou1H3BQDfhgr8Sf+hzD9PEBF/fe6lgT6I84HsS8SfUabna9tIo1smaiM8pXw1dP
	asfBz9eMx1S6jNSRbz+7/v8HlgZdWGkbPSMfvy5Bixx75paA3IF1H0t593wANklU4rHV/r4uYvp
	7L2/ZNVfWAfcSUZc65lWA0TMpnUeYQlfSevIuHvyXcS3QoTo1LsZaBwOADzJ6Q/wGumKYGDR1jg
	fTBy3D+zyaYivSwh4ZgQGJoZcbn/fbiX2qWj8nL75G9Yw6rVkv40XzFzK0WlX8MbOjl/k4UJb1P
	BwtSos2//zBBJgzEA6hZCA1UduT6T+TYWinMy4CTwynG2BRznEnmP2livDHxgGo3GnWagHgMVfS
	/KT6UZhm4w3+O/bexuFaz6RG/kbCM940X2rxuqW7p7Vt6O6xkHcknjvZPjdIIr01chiTDmKjZpe
	YMA2chDThWEmQqhHnuQThI373luiRaF5sLk9rFOo9MXQhb2oCPiEunz7XfKdyszxHV2ThXWJa6Q
	Ok=
X-Received: by 2002:a17:90b:50c6:b0:39d:e213:9dd3 with SMTP id 98e67ed59e1d1-39e54cc62d2mr18704039a91.1.1790005008521;
        Mon, 21 Sep 2026 08:36:48 -0700 (PDT)
Received: from fedora ([2406:3003:2000:232d:8687:63a8:d931:9b81])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a063f33101sm656655a91.2.2026.09.21.08.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 08:36:47 -0700 (PDT)
From: Wong Boon Jhee <wongboonjhee52@gmail.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	kuba@kernel.org,
	Wong Boon Jhee <wongboonjhee52@gmail.com>
Subject: [PATCH v6] net/ncsi: Fix Use-After-Free in NCSI teardown using synchronize_rcu
Date: Mon, 21 Sep 2026 23:36:33 +0800
Message-ID: <20260921153633.565779-1-wongboonjhee52@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ncsi_remove_package() and ncsi_remove_channel() remove objects from
RCU-protected lists and free them immediately using kfree(). Concurrent
readers (such as Netlink dump handlers) traversing these lists may
access freed memory, resulting in a slab-use-after-free.

Instead of converting all frees to kfree_rcu() or adding complex
reference counting, this fix uses synchronize_rcu()
in the teardown path (ncsi_unregister_dev). By stopping asynchronous
producers and waiting for all RCU readers to finish before destroying
the device tree, we ensure safe synchronous reclamation.

This approach is compact, avoids overhead on the fast path, and
resolves the race condition reported by KASAN.

Fixes: 2d283bdd079c ("net/ncsi: Resource management")
Signed-off-by: Wong Boon Jhee <wongboonjhee52@gmail.com>
---
v5 -> v6:
- Added RCU read-side protection to all NCSI netlink handlers and fixed
  every error-path unlock.
- Moved synchronize_rcu() before package/channel iteration during teardown.
- Stopped channel monitors before draining request timers and released all
  outstanding request command/response SKBs.
- Removed the unnecessary rcu_barrier() and drained ndp->vlan_vids.
- Documented the updated teardown ordering.
 net/ncsi/ncsi-manage.c  | 34 +++++++++++++++++----
 net/ncsi/ncsi-netlink.c | 79 ++++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 91 insertions(+), 22 deletions(-)

diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
index 54d0df0a9efe..00941c630270 100644
--- a/net/ncsi/ncsi-manage.c
+++ b/net/ncsi/ncsi-manage.c
@@ -1956,19 +1956,43 @@ void ncsi_unregister_dev(struct ncsi_dev *nd)
 {
 	struct ncsi_dev_priv *ndp = TO_NCSI_DEV_PRIV(nd);
 	struct ncsi_package *np, *tmp;
+	struct ncsi_channel *nc;
+	struct vlan_vid *vlan, *vlan_tmp;
 	unsigned long flags;
-
-	dev_remove_pack(&ndp->ptype);
-
-	list_for_each_entry_safe(np, tmp, &ndp->packages, node)
-		ncsi_remove_package(np);
+	int i;
 
 	spin_lock_irqsave(&ncsi_dev_lock, flags);
 	list_del_rcu(&ndp->node);
 	spin_unlock_irqrestore(&ncsi_dev_lock, flags);
 
+	dev_remove_pack(&ndp->ptype);
 	disable_work_sync(&ndp->work);
 
+	/* Wait for readers that found this device before it was unlinked. */
+	synchronize_rcu();
+
+	/* Stop all request producers before draining request state. */
+	list_for_each_entry(np, &ndp->packages, node) {
+		list_for_each_entry(nc, &np->channels, node)
+			ncsi_stop_channel_monitor(nc);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(ndp->requests); i++) {
+		struct ncsi_request *nr = &ndp->requests[i];
+
+		timer_delete_sync(&nr->timer);
+		if (nr->used)
+			ncsi_free_request(nr);
+	}
+
+	list_for_each_entry_safe(vlan, vlan_tmp, &ndp->vlan_vids, list) {
+		list_del(&vlan->list);
+		kfree(vlan);
+	}
+
+	list_for_each_entry_safe(np, tmp, &ndp->packages, node)
+		ncsi_remove_package(np);
+
 	kfree(ndp);
 }
 EXPORT_SYMBOL_GPL(ncsi_unregister_dev);
diff --git a/net/ncsi/ncsi-netlink.c b/net/ncsi/ncsi-netlink.c
index 8cc538358f6a..f8ea2ea73fb0 100644
--- a/net/ncsi/ncsi-netlink.c
+++ b/net/ncsi/ncsi-netlink.c
@@ -169,19 +169,24 @@ static int ncsi_pkg_info_nl(struct sk_buff *msg, struct genl_info *info)
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
 
+	rcu_read_lock();
+	ndp = ndp_from_ifindex(genl_info_net(info),
+			       nla_get_u32(info->attrs[NCSI_ATTR_IFINDEX]));
+	if (!ndp) {
+		rcu_read_unlock();
+		kfree_skb(skb);
+		return -ENODEV;
+	}
+
 	hdr = genlmsg_put(skb, info->snd_portid, info->snd_seq,
 			  &ncsi_genl_family, 0, NCSI_CMD_PKG_INFO);
 	if (!hdr) {
 		kfree_skb(skb);
+		rcu_read_unlock();
 		return -EMSGSIZE;
 	}
 
@@ -190,6 +195,7 @@ static int ncsi_pkg_info_nl(struct sk_buff *msg, struct genl_info *info)
 	attr = nla_nest_start_noflag(skb, NCSI_ATTR_PACKAGE_LIST);
 	if (!attr) {
 		kfree_skb(skb);
+		rcu_read_unlock();
 		return -EMSGSIZE;
 	}
 	rc = ncsi_write_package_info(skb, ndp, package_id);
@@ -202,10 +208,12 @@ static int ncsi_pkg_info_nl(struct sk_buff *msg, struct genl_info *info)
 	nla_nest_end(skb, attr);
 
 	genlmsg_end(skb, hdr);
+	rcu_read_unlock();
 	return genlmsg_reply(skb, info);
 
 err:
 	kfree_skb(skb);
+	rcu_read_unlock();
 	return rc;
 }
 
@@ -228,11 +236,14 @@ static int ncsi_pkg_info_all_nl(struct sk_buff *skb,
 	if (!attrs[NCSI_ATTR_IFINDEX])
 		return -EINVAL;
 
+	rcu_read_lock();
 	ndp = ndp_from_ifindex(get_net(sock_net(skb->sk)),
 			       nla_get_u32(attrs[NCSI_ATTR_IFINDEX]));
 
-	if (!ndp)
+	if (!ndp) {
+		rcu_read_unlock();
 		return -ENODEV;
+	}
 
 	package_id = cb->args[0];
 	package = NULL;
@@ -240,20 +251,23 @@ static int ncsi_pkg_info_all_nl(struct sk_buff *skb,
 		if (np->id == package_id)
 			package = np;
 
-	if (!package)
+	if (!package) {
+		rcu_read_unlock();
 		return 0; /* done */
+	}
 
 	hdr = genlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_seq,
 			  &ncsi_genl_family, NLM_F_MULTI,  NCSI_CMD_PKG_INFO);
 	if (!hdr) {
-		rc = -EMSGSIZE;
-		goto err;
+		rcu_read_unlock();
+		return -EMSGSIZE;
 	}
 
 	attr = nla_nest_start_noflag(skb, NCSI_ATTR_PACKAGE_LIST);
 	if (!attr) {
-		rc = -EMSGSIZE;
-		goto err;
+		genlmsg_cancel(skb, hdr);
+		rcu_read_unlock();
+		return -EMSGSIZE;
 	}
 	rc = ncsi_write_package_info(skb, ndp, package->id);
 	if (rc) {
@@ -266,9 +280,12 @@ static int ncsi_pkg_info_all_nl(struct sk_buff *skb,
 
 	cb->args[0] = package_id + 1;
 
-	return skb->len;
+	rc = skb->len;
+	rcu_read_unlock();
+	return rc;
 err:
 	genlmsg_cancel(skb, hdr);
+	rcu_read_unlock();
 	return rc;
 }
 
@@ -289,10 +306,13 @@ static int ncsi_set_interface_nl(struct sk_buff *msg, struct genl_info *info)
 	if (!info->attrs[NCSI_ATTR_PACKAGE_ID])
 		return -EINVAL;
 
+	rcu_read_lock();
 	ndp = ndp_from_ifindex(get_net(sock_net(msg->sk)),
 			       nla_get_u32(info->attrs[NCSI_ATTR_IFINDEX]));
-	if (!ndp)
+	if (!ndp) {
+		rcu_read_unlock();
 		return -ENODEV;
+	}
 
 	package_id = nla_get_u32(info->attrs[NCSI_ATTR_PACKAGE_ID]);
 	package = NULL;
@@ -302,6 +322,7 @@ static int ncsi_set_interface_nl(struct sk_buff *msg, struct genl_info *info)
 			package = np;
 	if (!package) {
 		/* The user has set a package that does not exist */
+		rcu_read_unlock();
 		return -ERANGE;
 	}
 
@@ -317,6 +338,7 @@ static int ncsi_set_interface_nl(struct sk_buff *msg, struct genl_info *info)
 			netdev_info(ndp->ndev.dev,
 				    "NCSI: Channel %u does not exist!\n",
 				    channel_id);
+			rcu_read_unlock();
 			return -ERANGE;
 		}
 	}
@@ -350,6 +372,7 @@ static int ncsi_set_interface_nl(struct sk_buff *msg, struct genl_info *info)
 	if (!(ndp->flags & NCSI_DEV_RESET))
 		ncsi_reset_dev(&ndp->ndev);
 
+	rcu_read_unlock();
 	return 0;
 }
 
@@ -365,10 +388,13 @@ static int ncsi_clear_interface_nl(struct sk_buff *msg, struct genl_info *info)
 	if (!info->attrs[NCSI_ATTR_IFINDEX])
 		return -EINVAL;
 
+	rcu_read_lock();
 	ndp = ndp_from_ifindex(get_net(sock_net(msg->sk)),
 			       nla_get_u32(info->attrs[NCSI_ATTR_IFINDEX]));
-	if (!ndp)
+	if (!ndp) {
+		rcu_read_unlock();
 		return -ENODEV;
+	}
 
 	/* Reset any whitelists and disable multi mode */
 	spin_lock_irqsave(&ndp->lock, flags);
@@ -389,6 +415,7 @@ static int ncsi_clear_interface_nl(struct sk_buff *msg, struct genl_info *info)
 	if (!(ndp->flags & NCSI_DEV_RESET))
 		ncsi_reset_dev(&ndp->ndev);
 
+	rcu_read_unlock();
 	return 0;
 }
 
@@ -398,6 +425,7 @@ static int ncsi_send_cmd_nl(struct sk_buff *msg, struct genl_info *info)
 	struct ncsi_pkt_hdr *hdr;
 	struct ncsi_cmd_arg nca;
 	unsigned char *data;
+	bool rcu_locked = false;
 	u32 package_id;
 	u32 channel_id;
 	int len, ret;
@@ -427,10 +455,14 @@ static int ncsi_send_cmd_nl(struct sk_buff *msg, struct genl_info *info)
 		goto out;
 	}
 
+	rcu_read_lock();
+	rcu_locked = true;
 	ndp = ndp_from_ifindex(get_net(sock_net(msg->sk)),
 			       nla_get_u32(info->attrs[NCSI_ATTR_IFINDEX]));
 	if (!ndp) {
 		ret = -ENODEV;
+		rcu_read_unlock();
+		rcu_locked = false;
 		goto out;
 	}
 
@@ -480,6 +512,8 @@ static int ncsi_send_cmd_nl(struct sk_buff *msg, struct genl_info *info)
 				      ret);
 	}
 out:
+	if (rcu_locked)
+		rcu_read_unlock();
 	return ret;
 }
 
@@ -608,10 +642,13 @@ static int ncsi_set_package_mask_nl(struct sk_buff *msg,
 	if (!info->attrs[NCSI_ATTR_PACKAGE_MASK])
 		return -EINVAL;
 
+	rcu_read_lock();
 	ndp = ndp_from_ifindex(get_net(sock_net(msg->sk)),
 			       nla_get_u32(info->attrs[NCSI_ATTR_IFINDEX]));
-	if (!ndp)
+	if (!ndp) {
+		rcu_read_unlock();
 		return -ENODEV;
+	}
 
 	spin_lock_irqsave(&ndp->lock, flags);
 	if (nla_get_flag(info->attrs[NCSI_ATTR_MULTI_FLAG])) {
@@ -639,6 +676,7 @@ static int ncsi_set_package_mask_nl(struct sk_buff *msg,
 			ncsi_reset_dev(&ndp->ndev);
 	}
 
+	rcu_read_unlock();
 	return rc;
 }
 
@@ -663,10 +701,13 @@ static int ncsi_set_channel_mask_nl(struct sk_buff *msg,
 	if (!info->attrs[NCSI_ATTR_CHANNEL_MASK])
 		return -EINVAL;
 
+	rcu_read_lock();
 	ndp = ndp_from_ifindex(get_net(sock_net(msg->sk)),
 			       nla_get_u32(info->attrs[NCSI_ATTR_IFINDEX]));
-	if (!ndp)
+	if (!ndp) {
+		rcu_read_unlock();
 		return -ENODEV;
+	}
 
 	package_id = nla_get_u32(info->attrs[NCSI_ATTR_PACKAGE_ID]);
 	package = NULL;
@@ -675,8 +716,10 @@ static int ncsi_set_channel_mask_nl(struct sk_buff *msg,
 			package = np;
 			break;
 		}
-	if (!package)
+	if (!package) {
+		rcu_read_unlock();
 		return -ERANGE;
+	}
 
 	spin_lock_irqsave(&package->lock, flags);
 
@@ -690,6 +733,7 @@ static int ncsi_set_channel_mask_nl(struct sk_buff *msg,
 			}
 		if (!channel) {
 			spin_unlock_irqrestore(&package->lock, flags);
+			rcu_read_unlock();
 			return -ERANGE;
 		}
 		netdev_dbg(ndp->ndev.dev,
@@ -721,6 +765,7 @@ static int ncsi_set_channel_mask_nl(struct sk_buff *msg,
 	if (!(ndp->flags & NCSI_DEV_RESET))
 		ncsi_reset_dev(&ndp->ndev);
 
+	rcu_read_unlock();
 	return 0;
 }
 
