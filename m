Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE09347F3C3
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 18:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790100670; cv=none; b=KcFD4skOGXLXOSYbBwRz+9Ay/D8ng+/Mci5OPtO2sYpTMXTs5kpTtazGoe9B9gKVhFchiY2rOoxh9MsO1U7zVhd9IJ7NOhG/hWA3Drk3Np0A4ue7SYaQZFBSXqmjrbSpt4i17ktjnTr6LDa06Mu+lWBcKKQUGH9dstYkmcavC2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790100670; c=relaxed/simple;
	bh=TaFb4eSuakn16y/HCqbul6dLc6ai2mslQenZjmXED9g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aA9yJcQyznK9mEH8YQOIDoMXcXDq0fgcDLmywiY3huDcQRk05qWGXmxaa7zUOQfrbUvz/daKuJNCQ+izM/dmVCv8BcrKUbCZQyuCpi+FECPCUVpNZIFgWd0L5Ky1QZKWwgYUbwy8Q+oZwCGUIo4OotOlAj6ObfOgItra1d5O0dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hjKZ8Tvo; arc=none smtp.client-ip=209.85.160.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hjKZ8Tvo"
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-53124d6a362so3641161cf.0
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 11:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790100667; x=1790705467; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=akNW2gA1xqJv9Y2CV3ju1rGNtJUn9j9S8EFGtBjOoUo=;
        b=hjKZ8TvoYFYmU8tGaUPWP3qQUOGp/6ibEtMrVfZzKGBerIr/OEa51vcHHYJGp4xuKH
         MCTW1Cjxjv97M+zlljSqXbruUQixdskBH96xqVZYxHtBWfPNwRuauUvW4eBlJuE6R3qZ
         5bqvtA3IpOvZi2qyXa9ZHvq3sYnV9vFMeCFxtl24RzGMlcei33+kKj57d4Z+5AWxxgBA
         OPQD9Ei3YwsOk0QaEYNQHsZU1q4oL/Umc+JOWYWGnpbJW5o7h0/vtyYUREwURDg6aITV
         qF7u15fuUsKtfzVr8XJsJC9BDP3nZR30EuILwmLf7Wk2OtoH2gD1jPrgH51kTo+6WGND
         sRnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790100667; x=1790705467;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=akNW2gA1xqJv9Y2CV3ju1rGNtJUn9j9S8EFGtBjOoUo=;
        b=EOSeNbw8KdOIoRJq79QGWpOM3ANmwzSNEjU17qnQViUhbbQEU9p6lLe/kpnhQ/D0D8
         5ZaYzZEVJwMbvUmkuPTQdZjTGA67HoGKsGY3QM8EhgCVqZFoK3GlgBgr+IsLO72mWMQj
         71hB/AyP2i8uRbeWZB9ZQ/iC7XKNAd/281zXTo1e2ZAT7whL+NLFwCbJGlMvO1HwqYOq
         Gv7M6nf14ZnLbHIpPb5rQRd3vVkcmKyKFXPt0T/IZ4JIL09kaLvsgBrIj8lwEiR8V6SG
         cWMSdfhJUrp200PTq54pZGh+jAfte2o5WQXDEYhmhL84zMuAv7rtfVPdOL5Opm+zgUtF
         MSTg==
X-Forwarded-Encrypted: i=1; AKwUvBwiy3IeIxtlQbEhvW/NlAhmTxjmlFjdHf6rgArOMsfy01AwbY8HYlw9vR1AlTml2U/K4BlGX9w=@vger.kernel.org
X-Gm-Message-State: AFuF++ngiImxW4eToEFy9V0aYDCMeM70MWagkKGhZC9PP1q6hx0lU43j
	a+TKQeQX1Q91yTPTVFhMbaFJvjCKkqT+vwFGAd6D5K8b3nXoYxF9xhX19jmKfN/gqrlx/MZAZAE
	chOg2EocV+sIorw==
X-Received: from qtbkf15.prod.google.com ([2002:a05:622a:2a8f:b0:532:b81b:a13])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:4117:b0:532:8ed7:534 with SMTP id d75a77b69052e-532eadcbef3mr5345101cf.37.1790100667301;
 Tue, 22 Sep 2026 11:11:07 -0700 (PDT)
Date: Tue, 22 Sep 2026 18:10:56 +0000
In-Reply-To: <20260922181102.3989489-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260922181102.3989489-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260922181102.3989489-3-edumazet@google.com>
Subject: [PATCH v6 net-next 2/8] vxlan: vnifilter: use list_for_each_entry_rcu()
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
index 336e8128be480a544caf0115bfb5b9254fe12eb3..0a04e8875f7dc4da66a01de8d0e99f82c75c1fdd 100644
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

