Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534995013D0
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 15:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789745401; cv=none; b=Mw6aonG8fIpL1jYMjgNkKf06bCiCUDqoKVtKrqfQGJCWO/nT/2CvndT7i3X5IjGbJmQuQqAGkEp3XliPoMRhKSduvwi1T5bvHBL9lhDnvnc4Lpr3h0LQ9/zlxFDxSP4e4R7wCGLYjIKvk6B7H5NrQ38ZMcM40VZUJrF4XujcNyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789745401; c=relaxed/simple;
	bh=rmQhi5zPbkNa+/qoorrwDelLL9t/EqR+C0YBSh380LM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P0MoR1cjd6Jn0ITxElV/MXNH8QYdIEs8txHVeULU2OYzuQCMO6X2ETGHZjBn0hS2E7JJh5iu4/93ZLbQNiSm/SenZeOXgBw46JoCBrvlQSyFbG5yZY8DbmJ5QrAjtcSTUfiV6WVQG8MuJ+I79VT4magxmU5719FaY9cCJdi/WF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=cy55wR6V; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="cy55wR6V"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b965f447cso7804195e9.3
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 08:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1789745398; x=1790350198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mi+0ABG8vMO2t6JqGnB0v+5K4lCi669MG0dctZCIzWc=;
        b=cy55wR6VV5/4xKAsWojP5IA1dIAA99J1Zvj8LB38n7MSVx0NaFT70NrY+tfqOPj0Ej
         yx01VY0t8SsuF3GCty9fN6uGgklDvEoMZRNvICp8oaBAzHOeCJZgBn6XncJ5hDkPwQpS
         3zK5R0dqAFM6Ot4eIliOVuyGmButByoKLB3dB32QhzoJ5QKoZuOkBwNQIGuTf4apROx6
         BmYCNccPEKb13dHkPa19M6r/NWEj8EITJX1s4K074mfYruWj4o6tEoz9EaIZnxWU3iLp
         Z+g3azUW6eW4dK6eY9zs0litowsp3IuB3BCq+g/JP5scXoNHnarcA9lGoZqbcQ5rDzJa
         fyXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789745398; x=1790350198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Mi+0ABG8vMO2t6JqGnB0v+5K4lCi669MG0dctZCIzWc=;
        b=RJx1GDmK0d2vZbHzGHGmXIxJoX4notTYJ0uHkUpjuBQuFAZ16+2k8gxPuUXLD5tdCU
         Ed6bQuhpcGes9Zfj7p0Q4ZpD4G5UhuzG9QlxahKCDsNAvhfSVweo4wKrQKt3S+WApwKX
         jqOFq/OIleaB+uyNbbxgQ/bdYH9dojmdpk7pqzrgpBqEB/6yIoKYmAkMjJfVOhdYaivU
         jKVprrHwDp3InFBz05+rgeIkopHlWrgYMoS6tswmHlm0u4LlWH5pd0/A/XbrCM1AreR/
         romTexrnOFRG/Iu2F8OHNJVxwHaenwfS+StUruebNX0DeLNU/2VFUB87P7U6seHr4mlp
         igSg==
X-Gm-Message-State: AFuF++ldYcub/+Bbe7Q0Yk/lh8WpSJEzfHa8HQSZYDao5ZLFLWGGr3j5
	USOTwIMTauhT2JU3HIFSqDEJVdIsPPmwLYj9uwxeRTNnfO/B5MvHOSw0qX8obddAYmtscM/aFyw
	aT0cE
X-Gm-Gg: AYBFou2dgEfUjtatGYnzqImMoml68WXqcQ81GbTzTBlsE9GYQH/MVomjChLOAYblDqj
	GdOr35p31k9Z9cJO3egVMoIcx0fbfpQubgHSxSBlHuQlhh+Of5gbU+JRB5MHkiPnrsIMCZTK3yv
	bWHmKdaI0UFmRuzAMn5kXMhuuA/N1/8sZIh+7Kik2o/b2rcEJ++tJNM3axAp3KrQjIeZUoeKfKn
	xmOg6lb84FDcULlTXZtQMBlRNM3WwW2qt/XZ+sVoioyND/cZumVlGVHtWs93JMyHGuTjhYuOKlC
	y3N8OwkqkNkkscOAzZnI4gfqs1w21j8iMv6vHdu4XzZGklpj9F+nrnXwUCjZ7g/L9NKVGPsAtcV
	51qPo6x8dUjViCLhZvZn7ula2CGsCtKrueY+M+rNtCQmzEfNkMg4sY09Wz+pvUXUErwqi7Pwgch
	nji4wrs5kHhP7hEVpL+OGzhJ0/j0Hv36BCpWNNy0DbUPzI3zx8SFs90O4BZSOmutmml0oF2W+k3
	4Ui2Gv1MwUoxDUd71mRUw==
X-Received: by 2002:a05:600c:81c8:b0:49f:bb8a:b4ce with SMTP id 5b1f17b1804b1-49fc573dae5mr34789235e9.28.1789745398529;
        Fri, 18 Sep 2026 08:29:58 -0700 (PDT)
Received: from localhost (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49fcd074336sm476995e9.8.2026.09.18.08.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 08:29:57 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bridge@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net-next 4/9] net: bridge: vlan: introduce a list of port-VLANs in the master VLAN
Date: Fri, 18 Sep 2026 18:29:45 +0300
Message-ID: <20260918152950.1938259-5-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260918152950.1938259-1-razor@blackwall.org>
References: <20260918152950.1938259-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Keep a list of all port-VLANs that have been created within their
master VLAN. The list is rcu-safe and will be used for optimizing
the flood path.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_private.h |  2 ++
 net/bridge/br_vlan.c    | 11 +++++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index bda25f851342..b2a12b6298cb 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -210,6 +210,7 @@ enum {
  * @port_mcast_ctx: if MASTER flag unset, this is the per-port/vlan multicast
  *                  context
  * @msti: if MASTER flag set, this holds the VLANs MST instance
+ * @port_vlist: if MASTER flag set, this is the port-VLAN list
  * @vlist: sorted list of VLAN entries
  * @rcu: used for entry destruction
  *
@@ -244,6 +245,7 @@ struct net_bridge_vlan {
 
 	u16				msti;
 
+	struct list_head		port_vlist;
 	struct list_head		vlist;
 
 	struct rcu_head			rcu;
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index bfedd13e3fd4..34d1df59d190 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -130,10 +130,12 @@ static void __vlan_add_list(struct net_bridge_vlan *v)
 	struct list_head *headp, *hpos;
 	struct net_bridge_vlan *vent;
 
-	if (br_vlan_is_master(v))
+	if (br_vlan_is_master(v)) {
 		vg = br_vlan_group(v->br);
-	else
+	} else {
 		vg = nbp_vlan_group(v->port);
+		list_add_rcu(&v->port_vlist, &v->brvlan->port_vlist);
+	}
 
 	headp = &vg->vlan_list;
 	list_for_each_prev(hpos, headp) {
@@ -147,6 +149,10 @@ static void __vlan_add_list(struct net_bridge_vlan *v)
 static void __vlan_del_list(struct net_bridge_vlan *v)
 {
 	list_del_rcu(&v->vlist);
+	if (br_vlan_is_master(v))
+		WARN_ON(!list_empty(&v->port_vlist));
+	else
+		list_del_rcu(&v->port_vlist);
 }
 
 static int __vlan_vid_del(struct net_device *dev, struct net_bridge *br,
@@ -335,6 +341,7 @@ static int __vlan_add(struct net_bridge_vlan *v, u16 flags,
 		}
 		br_multicast_ctx_init(br, v, &v->br_mcast_ctx);
 		v->priv_flags |= BR_VLFLAG_GLOBAL_MCAST_ENABLED;
+		INIT_LIST_HEAD(&v->port_vlist);
 	}
 
 	/* Add the dev mac and count the vlan only if it's usable */
-- 
2.47.3

