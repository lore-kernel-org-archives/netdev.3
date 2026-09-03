Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301E9453A54
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 12:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788437327; cv=none; b=NadV7GNehXhgs4flIkJc2ycjMrJq/wiXrsmDVap3VAMYxLlmFUrEF6tQa6YMvPkLLZPZhJNEDkri62WJNZP/zE7LXBc9Aovn5Ie8ZcQKwYrqtJxnIUas3KsP0Jdx0I6cZgFuHuVOzuF3z5RI4j9nceXlOIq/DMh+fb/Xqe34z10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788437327; c=relaxed/simple;
	bh=4S1d7ohGK54SgkYq3oMmvN/AkxzLrguuqK7LmeOmMcQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ck6D7xkBnQZdc8Fc+kMNqgy4kSI2XUe3fWigfR4IZrnQIBsmAL8wUaujD3kp4xehKcZ/XphjBrQAo3B93tBkfHZxvyJADiiPCNX8PwLjS5mHSUxmww9heFWYO5D4rZP5QdwqFxUnOXp4FaCDPgqkNYZ6gzaRSOfEiwMhB+5tIOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I5vmgLv7; arc=none smtp.client-ip=209.85.160.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I5vmgLv7"
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-53018848232so16484941cf.0
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 05:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788437325; x=1789042125; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nSKr8u5xZlNK8fpMG2HIvwpjBChMu25L0PjSFPHJGls=;
        b=I5vmgLv7dqpJgtAO4OTvLOEXQRcWtKWLIATRel8QuaPwys8KOmN30DJgHmHuP+wU+t
         Jt4kvn2A3n+6NPt4o0bGIr3bfk5si00O3hwEdcfAVSTKOe78MoAB2QYEiOpvc94V72kU
         YcD5bSwWhSBHIc2iT8D5KgNj3QsvjN4HFmNskrJqA66L9aTj8Axf5jbFPf1SpBf56qO2
         xwoTj+cKvYLipfDSAKEtql7t1Cb3nbh9QE0EcDNqq/hVQNTVHxPxdhVa5rL0A91JRE72
         k4/GLp5ulZtmtWWxYe0LxjSlEcfj5VmFGU0ZGLQSgW8WJQwWEPdI/xigYCub1T+JIsIo
         sayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788437325; x=1789042125;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nSKr8u5xZlNK8fpMG2HIvwpjBChMu25L0PjSFPHJGls=;
        b=TbJ2EyhnCCti3UqYNYmbIbOelaMhGKfbdgR/ybohvA9mC0R6TWpJkUCHt0KuP9hx/h
         FKeBmYQSN02Ea22EsukuNy6Kcf/QHauAnZp694/DoEUjOJ3KTwbKLWqXlF+E6SXaKwkL
         4TptXRt0Cp0ODYkSE5FaXeRqgXG4y8WFBV5Nx6DyJY4On+HEuhGUOoh6UoZq7DfgEm1H
         YkfNvLgAGQiJJQ6dr9Uo9qT2GeT56Ce1UK2YIDKN8CicOMzkLV0kMTs1O/nubZAmbTUK
         8VQUJ7o971mg0sPd1w6ifbmxXBS6p+E06Q6ywgygge80AcjTXSzS/xK6Y9IYA1qExw/t
         BI8A==
X-Forwarded-Encrypted: i=1; AKwUvBy33k5Vi192Vmzgr2geayu0WxJgnK1B9z1VOpySbD+L3sxJdeI/lsZb8QyNIN6HDgX4wxeTw2g=@vger.kernel.org
X-Gm-Message-State: AFuF++mdLKHnuF2c23HlmpAnCtc2lCx9nVYd+qx9Tmi5k2/MTZ0lT1JL
	vLRVHR3RQs6apRoH3j/SMITepsNRsSgwkgA9uwqbruem3SvDc390qXOquc/RNHB51+U9agOD8lk
	vACMJxsgQZmlJGA==
X-Received: from qtrb11.prod.google.com ([2002:ac8:754b:0:b0:51c:43ce:65d9])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:c14:b0:52e:f66:f17d with SMTP id d75a77b69052e-53036bf0c4amr149248371cf.12.1788437324536;
 Thu, 03 Sep 2026 05:08:44 -0700 (PDT)
Date: Thu,  3 Sep 2026 12:08:33 +0000
In-Reply-To: <20260903120840.1024153-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260903120840.1024153-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.970.g62bdec98f9-goog
Message-ID: <20260903120840.1024153-3-edumazet@google.com>
Subject: [PATCH net-next 2/9] vxlan: vnifilter: free vxlan_vni_group via RCU
 in vxlan_vnigroup_uninit()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Ido Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

vxlan->vnigrp is an RCU-protected pointer accessed locklessly under
rcu_read_lock() in vxlan_vnifilter_dump_dev().

Currently, vxlan_vnigroup_uninit() frees struct vxlan_vni_group
synchronously via kfree(vg). If a VXLAN device is deleted concurrently
with an RTM_GETTUNNEL dump, vxlan_vnifilter_dump_dev() can suffer a
use-after-free when reading vg->num_vnis or walking vg->vni_list.

Fix this by clearing vxlan->vnigrp with rcu_assign_pointer() and freeing
vg after an RCU grace period using kfree_rcu().

Fixes: f9c4bb0b245c ("vxlan: vni filtering support on collect metadata device")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/vxlan/vxlan_vnifilter.c | 3 ++-
 include/net/vxlan.h                 | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
index dd94085e088656d27b62420a5c8c95c609510a4c..ddfa24ad16f9303d7796e4a199b16dd5cc62047c 100644
--- a/drivers/net/vxlan/vxlan_vnifilter.c
+++ b/drivers/net/vxlan/vxlan_vnifilter.c
@@ -902,6 +902,7 @@ void vxlan_vnigroup_uninit(struct vxlan_dev *vxlan)
 	struct vxlan_vni_group *vg;
 
 	vg = rtnl_dereference(vxlan->vnigrp);
+	rcu_assign_pointer(vxlan->vnigrp, NULL);
 	list_for_each_entry_safe(v, tmp, &vg->vni_list, vlist) {
 		rhashtable_remove_fast(&vg->vni_hash, &v->vnode,
 				       vxlan_vni_rht_params);
@@ -914,7 +915,7 @@ void vxlan_vnigroup_uninit(struct vxlan_dev *vxlan)
 		call_rcu(&v->rcu, vxlan_vni_node_rcu_free);
 	}
 	rhashtable_destroy(&vg->vni_hash);
-	kfree(vg);
+	kfree_rcu(vg, rcu);
 }
 
 int vxlan_vnigroup_init(struct vxlan_dev *vxlan)
diff --git a/include/net/vxlan.h b/include/net/vxlan.h
index 7b82075055237058d231d636698f640c75c521af..f41db72e9229d9cc8460ddbe265c6cd07890032d 100644
--- a/include/net/vxlan.h
+++ b/include/net/vxlan.h
@@ -279,6 +279,7 @@ struct vxlan_vni_group {
 	struct rhashtable	vni_hash;
 	struct list_head	vni_list;
 	u32			num_vnis;
+	struct rcu_head		rcu;
 };
 
 /* Pseudo network device */
-- 
2.55.0.970.g62bdec98f9-goog

