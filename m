Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56FB38F935
	for <netdev@vger.kernel.org>; Sun,  6 Sep 2026 18:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788717679; cv=none; b=srUzVJ3MRbkRA1W/+49KmBaWmTZ/urtdJMTLZG+waQ44+5x0eOyIBC+eW8enYYqndijgijicHe+UaZqMZc8a4HAXgFYwIttXC6VfTAk8AU04GjdWSrUivKpgwH4hnyQGKATvl6vPmBonMykysOpoP7rBCWvYVxVZ/s5r6jA/Pjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788717679; c=relaxed/simple;
	bh=faOxRvV9OaxQVB8l60ZcLkOpYP/X1KOPRnkncieclcU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ez2RfPNiH4k0jmaMSiksNshKQwiek9BU3XjxHfgkwdyMwFVLbTuByXmQq+einQbDP7AyCtBSzeB1facrHNdTQFVziiRF+EEw7HTmIRN51i2zXz01WQc+sB5a8/nhBSSo7Eq/8WppgfPQEKo3NDVPu4AKFTTawalYsReCwtFkiyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bv27LWij; arc=none smtp.client-ip=209.85.222.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bv27LWij"
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92ec3146553so701167885a.1
        for <netdev@vger.kernel.org>; Sun, 06 Sep 2026 11:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788717676; x=1789322476; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SX8mHebXWbm++uh5Egd20hcMLB9J5pcgWt2mrVMeZfg=;
        b=Bv27LWijjy1CmzHFGrMZCGfmP+5N955dhfTF9vVTXNwo3TCheXZgoX3vB339CPdH3g
         pC0adxym4gRTWQXpfGnUEStx9TiRBE20NJSo/MowE0B2Iw5sBxfK22nnP1p7FOHm9Mg4
         8qMzTzSAGQ08SAn7WlBcXoLdC7SeqPBuUas2IKyAzT73lIh23uzoNx6dDsnVhDYUqmrr
         zsH29v7cB+x14k/ciGSEDxhBTyeM/aNmvc8PhiGXOTS+igL1SRdrFz8UM11xD8h5PvbT
         cso469nEiwDi/vhI6MidKdfREKHeoc0U8GA6EcDyVMznEmOiPV8sNLeFSelj+YPmiBvI
         tzRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788717676; x=1789322476;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SX8mHebXWbm++uh5Egd20hcMLB9J5pcgWt2mrVMeZfg=;
        b=jAYj1gsA/6XjfbnO6kZVy4EWP58GpNXS8Dnn1zypYhCKUffhnxFXIWJG/38q7OcZIi
         HdLUF+g5hDfQX3Ngyihd2ZPivJQwgjRWIlaf/HC/zJBuhtWrvWut2v32pps4KAnpf7WQ
         pUzr8kWK+Nd5+tW40yMlzWeLyApagvs2dAH40yys+ctS1ZPnl5FHVyfs0HiQgypX0lj7
         nCChcf6hJo/x/e1c/LJu/n+1vPtm+iE2uG3af9myzOBxLrRLqJIAEsxcDmV/uNwu/beG
         LrTWi5bzEsDFvvATeAqoJDT0PVY/x5KO/qEnTrE9qYuWbtdnCmjY7HW3xlD2bSoS0y6g
         wARA==
X-Forwarded-Encrypted: i=1; AKwUvBwldZMaiv4OX46nQssew1aj3IFoSSuMTPW4AADycogqH7E2wKVVm9zIBi0D0ZMqpf8nwxaYOf0=@vger.kernel.org
X-Gm-Message-State: AFuF++kUfrDvFL5Qt1z8JmYVW8Vo1xzC9PJwVDq4LvDr6NQ9/TMC8CpZ
	N/Cka9/6LpgE2C6r8R9/yef1f7h/UaBSLTXg3vKxT/CgzexrzeifAi6ANqoPUXlAO5uhFY+tHAY
	FWAKm6r+NKD15jQ==
X-Received: from qknrg2.prod.google.com ([2002:a05:620a:8ec2:b0:939:6e7:a8bd])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:1d01:b0:936:dfbf:85b0 with SMTP id af79cd13be357-9398070ffccmr1849451585a.35.1788717676105;
 Sun, 06 Sep 2026 11:01:16 -0700 (PDT)
Date: Sun,  6 Sep 2026 18:01:05 +0000
In-Reply-To: <20260906180111.1973188-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260906180111.1973188-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260906180111.1973188-3-edumazet@google.com>
Subject: [PATCH v2 net-next 2/8] vxlan: vnifilter: use list_for_each_entry_rcu()
 in vxlan_vnifilter_dump_dev()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Ido Schimmel <idosch@nvidia.com>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
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
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 drivers/net/vxlan/vxlan_vnifilter.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
index dd94085e088656d27b62420a5c8c95c609510a4c..fdf25d01bc1fb14171f58af905cd0b01d620dba4 100644
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
2.55.0.979.g7e5102b832-goog

