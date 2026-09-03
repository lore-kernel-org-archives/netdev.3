Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40084A0927
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 12:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788437329; cv=none; b=iF5/+qxUKgdx8s3dbHvL8SLdbP4x0az3ZI7aNLsqgOSvJPHLpmIJ0iCR9Izl9yCk4z9YSOdu2Hj2Xbb2MOhdIXOgtUsbNSe7lh8uo3au7C3Dnwj9dAFIcdIRQhscZJy3o9u1bH6ZCzYlSCW3BFxaWjJKdhwfSdg4sAfmSNK5mWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788437329; c=relaxed/simple;
	bh=koo4Mlu5Mzhe0wzkIkvaULt+IQgWV94Ed+2INooFKnM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UlpFhc6PiTKTqLPkDvmmSkx37qo2w2n48Lb9M9GkJkIkAGE6IghY2Z1DRPb7/WmiMTDMGioWRxkJ3FAO4B8JUFAc5y7Z2cv9jZV+mTGF4wxtxsHdLMegogg5XB/PKkNBVYA44eM93vwOatsZlc1wV6PqVvS5SQhYyzf75qzbvWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Eg82w3qg; arc=none smtp.client-ip=209.85.222.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Eg82w3qg"
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-939062ecda9so337585985a.1
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 05:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788437326; x=1789042126; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2Uf7lHzouHX/ERKj/2PYKMBQp1ml2OVJwobBBldlVCo=;
        b=Eg82w3qgFQCE6BTufaBfxbOkNj1af3i2jF/8kIaPTJSNRPnnO6GCieTm7GhsT+hTrR
         dOINY4fFx95KuG/4U699WCEhb0YLPzb+XlZLa73P+XmtH9cDNKYg6RD6b33NwvGUD/WU
         3Hna+3OEoMVtg/FizYJvw6i779UbACNv6PNhInHNmPU+60jneRONHrrjuHiJH31UhFFi
         hcKuUsjcJfPKlwN+ldWlgA2D/guxeacoxO3wdb7XxiKnSaPTv9U6vo0IfonpffGkY19J
         dAd/F3KNZ8KFkwyK2xy574SFFiAluI7gmwWvfZAOzuCtKTooiyj/OcP74yiKhH/P+HJA
         I4Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788437326; x=1789042126;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2Uf7lHzouHX/ERKj/2PYKMBQp1ml2OVJwobBBldlVCo=;
        b=bcSCXfjZLXjIiZ1r/18VAn8y6u3hfqHJvDeR2PlaNDQfUot5JBk6RzW+uJY1+CG6K5
         jfVK7cB+lmXG0mmSGb+hu6I4gl/PegZ6b9UYFBW/mwTU5h7ZA3geJ2/RRFjoW62rQp2p
         EMcBZRQd8SuAkIi1Qfudac8B6d6svp1TxwY8T66OoYNKw0XoFvN6c8XjzFHqQND4JFir
         Nuzky2vvfnm9X4DFGJR3LAvTqaUqcNsQjd29mNz6bhFUEvXZH00DjCnFJWbiGkfTowCP
         6hCqkWRc7u8gremJ3pyqoHnc3i/eHQlfk6RD4p4+P7qIcbQKYXV14DC9MGjCWcx8hdpA
         i9Sg==
X-Forwarded-Encrypted: i=1; AKwUvBwWQmsir/+0i1c0LvDERl285bikzaihc6XU80AWDG32OuLsViP5lg2sbRCYGq5kWSKCl8kLlJE=@vger.kernel.org
X-Gm-Message-State: AFuF++lFIWwQD3cNh657h0/TqmZ9y5+fmkaAL677TZlC+1NQiDGO82sv
	alarHmaH33joRraOjwfhoTZsg2DnVXPUIFgc+ASIO+petemUhF50/rIFiNQdAGcUk2IpSIn8QC5
	KbqA4LknJxR/G9g==
X-Received: from qkaf18.prod.google.com ([2002:a05:620a:20d2:b0:936:dbd9:5fe5])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:270b:b0:936:8840:427f with SMTP id af79cd13be357-93960c6c8dbmr1425538485a.4.1788437326093;
 Thu, 03 Sep 2026 05:08:46 -0700 (PDT)
Date: Thu,  3 Sep 2026 12:08:34 +0000
In-Reply-To: <20260903120840.1024153-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260903120840.1024153-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.970.g62bdec98f9-goog
Message-ID: <20260903120840.1024153-4-edumazet@google.com>
Subject: [PATCH net-next 3/9] vxlan: vnifilter: use list_for_each_entry_rcu()
 in vxlan_vnifilter_dump_dev()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Ido Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

vxlan_vnifilter_dump_dev() runs under rcu_read_lock() without RTNL when
dumping VNI filter entries via RTM_GETTUNNEL.

1) Currently it traverses vg->vni_list using list_for_each_entry_safe(),
   which performs raw pointer accesses without RCU dereference barriers.
   Since concurrent RTNL writers modify vg->vni_list using list_add_rcu()
   and list_del_rcu(), use list_for_each_entry_rcu() instead.

2) If vxlan_vnifilter_dump_dev() returns early because VXLAN_F_VNIFILTER
   is not set or vg has no VNIs, cb->args[1] was not cleared. If a
   paginated dump was in progress, this leaked a non-zero cb->args[1]
   to the next device in vxlan_vnifilter_dump(), silently skipping its
   first N VNIs. Clear cb->args[1] on early returns.

Fixes: f9c4bb0b245c ("vxlan: vni filtering support on collect metadata device")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/vxlan/vxlan_vnifilter.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
index ddfa24ad16f9303d7796e4a199b16dd5cc62047c..53213542fa3ecf67d66ba6bf41f7ac51cf8fb471 100644
--- a/drivers/net/vxlan/vxlan_vnifilter.c
+++ b/drivers/net/vxlan/vxlan_vnifilter.c
@@ -333,7 +333,7 @@ static int vxlan_vnifilter_dump_dev(const struct net_device *dev,
 				    struct sk_buff *skb,
 				    struct netlink_callback *cb)
 {
-	struct vxlan_vni_node *tmp, *v, *vbegin = NULL, *vend = NULL;
+	struct vxlan_vni_node *v, *vbegin = NULL, *vend = NULL;
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 	struct tunnel_msg *new_tmsg, *tmsg;
 	int idx = 0, s_idx = cb->args[1];
@@ -342,13 +342,17 @@ static int vxlan_vnifilter_dump_dev(const struct net_device *dev,
 	bool dump_stats;
 	int err = 0;
 
-	if (!(vxlan->cfg.flags & VXLAN_F_VNIFILTER))
+	if (!(vxlan->cfg.flags & VXLAN_F_VNIFILTER)) {
+		cb->args[1] = 0;
 		return -EINVAL;
+	}
 
 	/* RCU needed because of the vni locking rules (rcu || rtnl) */
 	vg = rcu_dereference(vxlan->vnigrp);
-	if (!vg || !vg->num_vnis)
+	if (!vg || !vg->num_vnis) {
+		cb->args[1] = 0;
 		return 0;
+	}
 
 	tmsg = nlmsg_data(cb->nlh);
 	dump_stats = !!(tmsg->flags & TUNNEL_MSG_FLAG_STATS);
@@ -362,7 +366,7 @@ static int vxlan_vnifilter_dump_dev(const struct net_device *dev,
 	new_tmsg->family = PF_BRIDGE;
 	new_tmsg->ifindex = dev->ifindex;
 
-	list_for_each_entry_safe(v, tmp, &vg->vni_list, vlist) {
+	list_for_each_entry_rcu(v, &vg->vni_list, vlist) {
 		if (idx < s_idx) {
 			idx++;
 			continue;
-- 
2.55.0.970.g62bdec98f9-goog

