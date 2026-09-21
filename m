Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF8D43C7C5
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 10:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789984906; cv=none; b=JzQ9+0c8HrkRE/ySc4VFlJSEgB0EGYrwwEXlDgD+/e+Om7h9AmsLQhbJOms851vxMEjBTJIF30PdygEHRZRvZhlV5l8kJ6mGp9oFRhlIe+ugHCHCs+FYFuklEklgt0egVBBjLgHyHCZ4C0mtxAuUOLvevGUdUaPl2FFirIGEKTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789984906; c=relaxed/simple;
	bh=XFgY08QduT+eRjO++2aFtrmlNg+hc9WpMqQwxIKR2Vg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f++GkA9F9mturuPIevpSkmxpygzMOuYKFsWlvIL8aIum52Jp3Pkan6F9tm1WiMFr1UMwNED+Ff7B1K8BuNTE8MvopEsd4IVxzbVUw36777soNvcU7DazRonPSvyibiDAFb6ihmOXvEKmrhzVI9jALzZX6AbNgJzz6FgzVpFW/e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C7mkLssf; arc=none smtp.client-ip=209.85.160.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C7mkLssf"
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-530e12b296bso67431121cf.3
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 03:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789984904; x=1790589704; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OE4CKtge+lqJuD/6xq3CWLXO2f77yhF/B95pg8cmH6k=;
        b=C7mkLssf6DxaoBbJ0jbNNBN/4Dtdd7oPysnuA1sRnq2YQZpSRUdn+0im0kWLXYrgT4
         sntcGpGscLS3lKasz5ngpnnn+NHQJMSd51oyYcV0pP014iDhaWD2jNLj2F8lTyC22IRE
         SKzqrF35AyUcMpCOr9HExmFbypEpUEyjmuVVrVa1RRKc6nED8LBG9eptmkaTNGWqBb2b
         Ijf0t+8DU8H5pMG8z4WRC+Wsse+qwINdQTQ1P1twdkNCOscU9DbzGGJGvu5DrzM5ww20
         lfyPXThZvtGIKveXegcRvH/E2ylf7A+csFSipnbHDo1nV2x35ekcNPhAp3ZV9QZywRW6
         yAcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789984904; x=1790589704;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OE4CKtge+lqJuD/6xq3CWLXO2f77yhF/B95pg8cmH6k=;
        b=yalUPp1vcJnb++3sO/2wA3/KQH/cmhp/407GaABWEcQyN3JZyWWq67VXfLjH5gRXda
         OivXWysGTQnyegc+/dLKM3N0lGwGx33I9PJKB/Sorxby8TNEitHeT/Ov3ySP2bzNeENc
         XIyirIqzL38jADp0ZI/SdHziAwzBn8uhxoHsYOk1+7qPwwuy4GObAQStwJWhD4CN496q
         UXp8D1ba42U+u1/FGsTuDKlGCeGwHyWa+nk8uP5wmvPKcvVSoE0gga7fu8YZ8cY1hskZ
         DxWLRFBtEmF9j1EpR3MYRgMs0XzO7Fi+ITfNQoGqIK+umd+JFMAGdgkCnTCQFM3PUhi4
         OcyA==
X-Forwarded-Encrypted: i=1; AKwUvBzecxYNDIwPNuspMg/NK648niA8iU2IYkRziTO+hk98b1PNadlN718wgjFdD8g9pCHRiHsiV/g=@vger.kernel.org
X-Gm-Message-State: AFuF++kmzKVbBiw48/gVj0MwUP7gtoxm55b5Oal4QnclshVAhWHVcFO8
	V1fJi7tM43EOCptI7yU0dWH8t3iaKVPtjuvru0WO78LmRzBns3BqnGfoiZ7tG0PIYpMk3MFZMzk
	FEgYIFjdT+QMHVA==
X-Received: from qtbli21-n1.prod.google.com ([2002:a05:622a:8455:10b0:532:d763:9739])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622b:54:20b0:532:8836:f3b3 with SMTP id d75a77b69052e-532b72e6f4emr64875571cf.36.1789984903842;
 Mon, 21 Sep 2026 03:01:43 -0700 (PDT)
Date: Mon, 21 Sep 2026 10:01:33 +0000
In-Reply-To: <20260921100139.508191-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260921100139.508191-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260921100139.508191-3-edumazet@google.com>
Subject: [PATCH v5 net-next 2/8] vxlan: vnifilter: use list_for_each_entry_rcu()
 in vxlan_vnifilter_dump_dev()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

RTM_GETTUNNEL dumps currently run under RTNL lock, but
vxlan_vnifilter_dump() also acquires rcu_read_lock().

1) Currently vxlan_vnifilter_dump_dev() traverses vg->vni_list using
   list_for_each_entry_safe(). Even though RTNL is held today, writers
   modify vg->vni_list with list_add_rcu() and list_del_rcu().
   Switch to list_for_each_entry_rcu() for proper RCU traversal and
   as preparation for future lockless dump support.

2) During a paginated dump, RTNL is released between dump skbs.
   If vxlan_vnifilter_dump_dev() returns early because VXLAN_F_VNIFILTER
   is not set or vg has no VNIs, cb->args[1] was not cleared. This leaked
   a non-zero VNI offset to subsequent devices, silently skipping their
   first N VNIs.
   Furthermore, if devices are added or removed between dump calls,
   ordinal device indexes can shift. Track the current device ifindex
   in cb->args[2] and reset cb->args[1] if the device changes.

Fixes: f9c4bb0b245c ("vxlan: vni filtering support on collect metadata device")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 drivers/net/vxlan/vxlan_vnifilter.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
index 12fa11a31818456232682edb1c79042478832836..fad7c76418e929866c5c48431b08d179909f5931 100644
--- a/drivers/net/vxlan/vxlan_vnifilter.c
+++ b/drivers/net/vxlan/vxlan_vnifilter.c
@@ -333,22 +333,34 @@ static int vxlan_vnifilter_dump_dev(const struct net_device *dev,
 				    struct sk_buff *skb,
 				    struct netlink_callback *cb)
 {
-	struct vxlan_vni_node *tmp, *v, *vbegin = NULL, *vend = NULL;
+	struct vxlan_vni_node *v, *vbegin = NULL, *vend = NULL;
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 	struct tunnel_msg *new_tmsg, *tmsg;
-	int idx = 0, s_idx = cb->args[1];
 	struct vxlan_vni_group *vg;
 	struct nlmsghdr *nlh;
+	int idx = 0, s_idx;
 	bool dump_stats;
 	int err = 0;
 
-	if (!(vxlan->cfg.flags & VXLAN_F_VNIFILTER))
+	if (cb->args[2] != dev->ifindex) {
+		cb->args[1] = 0;
+		cb->args[2] = dev->ifindex;
+	}
+	s_idx = cb->args[1];
+
+	if (!(vxlan->cfg.flags & VXLAN_F_VNIFILTER)) {
+		cb->args[1] = 0;
+		cb->args[2] = 0;
 		return -EINVAL;
+	}
 
 	/* RCU needed because of the vni locking rules (rcu || rtnl) */
 	vg = rcu_dereference(vxlan->vnigrp);
-	if (!vg || !vg->num_vnis)
+	if (!vg || !vg->num_vnis) {
+		cb->args[1] = 0;
+		cb->args[2] = 0;
 		return 0;
+	}
 
 	tmsg = nlmsg_data(cb->nlh);
 	dump_stats = !!(tmsg->flags & TUNNEL_MSG_FLAG_STATS);
@@ -362,7 +374,7 @@ static int vxlan_vnifilter_dump_dev(const struct net_device *dev,
 	new_tmsg->family = PF_BRIDGE;
 	new_tmsg->ifindex = dev->ifindex;
 
-	list_for_each_entry_safe(v, tmp, &vg->vni_list, vlist) {
+	list_for_each_entry_rcu(v, &vg->vni_list, vlist) {
 		if (idx < s_idx) {
 			idx++;
 			continue;
@@ -394,6 +406,7 @@ static int vxlan_vnifilter_dump_dev(const struct net_device *dev,
 	}
 
 	cb->args[1] = err ? idx : 0;
+	cb->args[2] = err ? dev->ifindex : 0;
 
 	nlmsg_end(skb, nlh);
 
-- 
2.55.0.1082.g2b9226bbc0-goog

