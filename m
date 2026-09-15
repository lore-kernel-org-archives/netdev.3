Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF2143F096
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 17:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789494910; cv=none; b=FI6gM179M+Op6bxvbY8L9uEz/BYEFuJXw6dOVwDWAGU4pRNW++cvb4Mj/TKqOvLWiYZVEIqiL3OvC2XtSGwbeDSLd/Vy3g/R8Ujnen/SWj8fCLc+2OmbNagHEBb7HgYq/gQYxh94RXoV6sfOe323hKcQ8ImVi8uJwi63Zcn/Sb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789494910; c=relaxed/simple;
	bh=rQoTC27JpK+u54dJshynRqhISIez3pX+HHwrck6XM2Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DDxRZ1FcoIsc7UumOP2X3H1RefBuS8pIlSw5CirK6tSVxGFUjpxagxpNZQiGPENSZIU7YQOF+nIPItuITEjdmPbcUZLMLhosa9JmIuen66wCrhlGeqJdAeo2PkWK7a85k5/IgVLQB3uQuxeMCJArT+mDfeety5JPn0aorvVK2QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fvkLuVrH; arc=none smtp.client-ip=209.85.222.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fvkLuVrH"
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93a1de6d5c3so515844785a.3
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 10:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789494906; x=1790099706; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rq3j1D607yNhyAB/qvhGgeU78CppVvHGt626XURrysc=;
        b=fvkLuVrHhsCv0gTbiDY3lmWlcpUXZThFhnSiD945j2ZfG85iog8ckAKmqzY1G5FExO
         3FThMBorWc00bBO3Xj5RE0+CttJD8uP6DNP9YVtBtgZduz8UioruhkMww/KYHDlfWN7k
         4Forasay+priT7HyUY1zv5LFpkHPAao/yBg5tI+YnFnr0Fep+bmxGVY+OsYVZCHZgUZW
         fLhU8NAfogIaXhIPW9zIIbnOKcTs/8L+Mz+LeXc25Gwd/2lXTRVIjkXMdiOW/uEUlrZk
         luxIWuKla/MSNJjtMYLef2NF4WtG0jF4qS/n56m4dwL6phUgCS67Sydw3aTA6K8UzDZb
         GyNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789494906; x=1790099706;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rq3j1D607yNhyAB/qvhGgeU78CppVvHGt626XURrysc=;
        b=tIl8iyqs7HAF06BzmbCZqwuQ4IyLzled+/6+kyvnvQqgEfFghO0LW0+jw90CMKYZZt
         NoNuiLg6OsDIqxvGQuegA7F/2pqoFF8cUTZDg64jNmPikmkkLNPLed+tkoi7Pxmx9/hG
         sa676Hxn3bqZU+fHoCIvn/4OfvOaAup/idkcvWsG6K8uNtNrCRLVL/hxiuhq/Ri7vsYY
         E+cIvnhk5AmOx/rZlHsTW30A2SKz6zuOJe+c40v+mfnbqdFOa820CgwGTqF2p1R3ZUiB
         ZKbIhJCNUbDOB5iqCAuC6VJ5vHz1MY2yfk6M3efnU8VKcp6JSxvR72jZmBx93jIEZ8Tq
         56UA==
X-Forwarded-Encrypted: i=1; AKwUvByjSODnJ4fofALAMyxi6FdvRMNk//0DEcj2CiXA9P9KS6n8Ori8nTvLX0rrIPrlKlG9S/aKVAY=@vger.kernel.org
X-Gm-Message-State: AFuF++nchEt7cUEUfVipRqcUFlfoUuT9O3gO29pj0Dg07ADGsgVhpMYd
	j5sI1yNfFSn+I9Ernwqtmq9AbHB/r9NtBEuLtLlGL6UHCIUsEAOoALKNmu+q1I9mL+GxIJ2iB2F
	RBKYh1ewVSblsTw==
X-Received: from qkmu3.prod.google.com ([2002:a05:620a:223:b0:93a:3fd:8253])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:370e:b0:939:7d8b:93e0 with SMTP id af79cd13be357-93a297cc40amr1187448485a.18.1789494905723;
 Tue, 15 Sep 2026 10:55:05 -0700 (PDT)
Date: Tue, 15 Sep 2026 17:54:55 +0000
In-Reply-To: <20260915175501.391567-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260915175501.391567-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260915175501.391567-3-edumazet@google.com>
Subject: [PATCH v4 net-next 2/8] vxlan: vnifilter: use list_for_each_entry_rcu()
 in vxlan_vnifilter_dump_dev()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>
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
index e433e66f6d4d3b57807c8de3f07b5310f0ded200..4404b912a74275cd199951bb254e7180d39edf3c 100644
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
2.55.0.1032.g73a4cd73de-goog

