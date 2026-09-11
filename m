Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68003314A60
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 06:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789107725; cv=none; b=q/ySt3/2WGxuL6vQzav/Vpoh1gqe2U3HPlGwepBwZrTgrsdl5C4THh3Hj5dcSNEzostJh40gz4gnvJh1Hwq8Y9hrKevF14cfTBDnwgw/qhwgTSpOnaOdoyz+2/f99QmHKvKswVMcLfBlIesBH9HBkeic9RAQlGxi9hMq3QXAO4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789107725; c=relaxed/simple;
	bh=AbNgaPMxIwnYwU8R3P3SlUdu6bfOBnjKzjfHijZrP9k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=npWbah+CeC78I2yDnv29DOEU/A+xSLkXxJ0MeRtJhllggvSftlJRdrrMIv9lpoSUMLFGrp1AsIHIfu/5rNMnWoH+wz6LGIH7+idELXt50hvOPDyIli4kDV8QxNuVz2tP2GUQbFFaqyyRnmGZVOhy2lJI9qAOGg11d4e1Oz2AuLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W/w6CecX; arc=none smtp.client-ip=209.85.160.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W/w6CecX"
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-53094ff7090so14327311cf.1
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 23:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789107723; x=1789712523; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C+pHE0n2DorAuOr5FcGLKW27gjwiTwQ8LXlNVlFLmKo=;
        b=W/w6CecXafK7wDNe9aAZg8tyQZAQIhK9DUzJg/jQj7nBG7xvM7rVbyvJpIuYEkc4M7
         aTgmPbgT2iuAxD9JqQxg3DBJRSOWBhmLKq2GvEXP8ydEgGf26acxj+OTIV4xfSzraUQq
         YTT+eyvBqYFTz4HsoGSg1oodOAzcIxa02T4rG/1ja6aqKA5G5yrH63tEynp6yl8Ne9hC
         jrW/5HB1SM5FPPO3oGgG8Nakjj50LGMlGehukyKSdPmDiPzLFZB5CbRSRxkFsFbpB07h
         i6HT0NWgu2u8ldZeWywum2IfwyP4Nd6mABXJ7t5u57Pmw1bOCU9Zs3Y6e5mlJZMPYc7Z
         4A/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789107723; x=1789712523;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C+pHE0n2DorAuOr5FcGLKW27gjwiTwQ8LXlNVlFLmKo=;
        b=EoKVjTSpS52ut8fflTywuTanXKFNCBp1GbeoD3aFTVGmwFmTKlBKw62LIK67WSAHGd
         7gjOvVNojcIZZJ4d5PwDn8ADkiA4f3EIaU7sLKU6CO86bdzOJ9/BDAys2SmCkAcFXhdX
         Pjgyg4e1rULE27xuM389HFG2Yv+a1evae5Vyli/NvmiN7/n6BEMVfouavEXJbLR6GDL+
         mNDMJVDz/P9BDJUQsEX0EaIYP5g1+RYXhDB9CdeAuIYTKUXlPQ3/JBh3JfZmC6Yh8VLE
         BpXZjwmJpVbqmJT4l0H7F59Z5nbzWc6RTbZ4tqakWtJV4nhYlgmhWZZLk34lXKZywujL
         Azkg==
X-Forwarded-Encrypted: i=1; AKwUvBwjwHUumpVYtCmcUH4AbZhiv0UHr8KbDWuZvLawDFge9d0bI/8HwZNJ67w40SpHAPdc9BIJo1Q=@vger.kernel.org
X-Gm-Message-State: AFuF++k1jvPbmON9/5N6R1xGpIWNJC0qBigUPdi4tCkYtObbExwSNby1
	FPaP7JBrrvp3a/KxdtH+213TGdBNvkOjtfz8snd23tRYiih8VgbER9Bne9ebnrNqszShZX/sVR/
	JdOKM0DsM77vxZQ==
X-Received: from qvuy10.prod.google.com ([2002:ad4:45aa:0:b0:912:2b3:82c3])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:8c1b:b0:530:d3d2:f8b0 with SMTP id d75a77b69052e-530d3d306aemr7124711cf.24.1789107723106;
 Thu, 10 Sep 2026 23:22:03 -0700 (PDT)
Date: Fri, 11 Sep 2026 06:21:55 +0000
In-Reply-To: <20260911062200.231316-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260911062200.231316-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
Message-ID: <20260911062200.231316-2-edumazet@google.com>
Subject: [PATCH v3 net-next 1/6] vxlan: vnifilter: use list_for_each_entry_rcu()
 in vxlan_vnifilter_dump_dev()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Ido Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
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
index dd94085e088656d27b62420a5c8c95c609510a4c..0a18c32902da08dc2732e2aea10d58b8753fe57f 100644
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
2.55.0.1007.g17ff1f9808-goog

