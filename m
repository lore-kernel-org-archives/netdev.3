Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E3F4BB5D2
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 14:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445943; cv=none; b=jfKza0BQ74+HgYd3utKrYaIlEsWcw9E11W4r2nHFLDsQ5IZu2VrMBoO9cpYjE/fPUfzRw2t5kI+g6GGlJytXJ8+lKi7xiHDPf4jXjLISVMTZDVE7EUzlTZgBooB5MXUmqfWOH/eKB1oZq+grEdaKOsOkRzk8qux0Ug34wwt6Q3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445943; c=relaxed/simple;
	bh=wXTs7/mwUOm9B82JGE5NjvfCN2BrknQqFyvqV/ssMQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tjs9uAYXMCp+wSnB1OXobUJxrhUhGTNFTzbHUA1izwR2A2aTmJezY/YTkJpblEeEhg/RdbiTYvLnuWIlM8n3NKVa2xuFJeskpCSocKfVgHo7rjQYx7MTRSqeW6i2cyLxtNqSVMai0QybOmlwW5U3MVMYkfrgjPvhg5WsE/AjN00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=QXTCB33o; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="QXTCB33o"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47f96c5b722so1778736f8f.0
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 07:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1788445927; x=1789050727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=17pAeXAPWqC20adwChneYdX1dfRnINnx5gBEzZVTcEg=;
        b=QXTCB33ocWsZJLD2AdPXRkDcXSCWylCTyBD4etj0Vsfm9U+N+6zyNl7UetshNe2KGE
         YvNq4w9fNu+qSp2teVV80vrsNwpAp+pGERBA32fLtq3N3+mLAqDI8ISauALEczxrvkIT
         U/pT97SiCGDl0Y9I5lboUGWZc1hVyeYvpBpsjDLIgeKXA4U7L1GC2tQscsy57BOShrXm
         skkBSYDq1OAVFagU92pP3hJCgZwH1/ORN3bIyOk2WLYlB16kDJZFW1YE+tZmDTAagGtN
         dNh/R1XGXIMMw7Im7JWGjUpVBAQkJtCn/zUOliNCsfKZorDQOm3VEPlAg/btnyDbYro0
         IVgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788445927; x=1789050727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=17pAeXAPWqC20adwChneYdX1dfRnINnx5gBEzZVTcEg=;
        b=qMbnOn61VbxtNFFUxr9cpednJ2Ra7rX+BrQSMaTxPC9InZZrsby842X4nOncrEuoaj
         7SYcSH1FRARuPiJNVdFqIb2GL3VmF1n+GbgzZEXYrAw6RE1wyPaK7Xhn7Icljx9AWA5E
         z45dzvWIhm4aHtWhU0rp9Wxc2/9YaWog6NHZYoz/q/JqzhdVdsltKPQuawTICLsgUjK9
         2WEUr6NyXpePGTsQFz4Xvr5JV2gSYzCKp0pNCmAkulqFs3qbUhrZVnVByw4fvZBxvka4
         4tRQ1qqMJ1dXSj3hPvfQ53sBcuNHlNTVyZBDyo796Ht2UBNlFlQlLjxrODsJSHVlXFjs
         6+Qw==
X-Gm-Message-State: AFuF++nwksFU/J4BxCJsy9C/VzNHwbaZtiF/sJv8JY5Z3F62YsXFA/lz
	Ke6275V48Vp9zoLxClvMEs3TLYHsYpjwD3/jm5645Fq/vsOc3uTNIo3otPhheva3tj432BkdbK6
	2sELKhsg=
X-Gm-Gg: AYBFou2ZnDC+HYL7OpaqNezUmKXkesDogc7PKYTF6icbvF1HFjteHJR1lYvNNAGxDWU
	ouPOR+98DOVUm6TWvd3/W2qdkzVcEi8GCbOw1mjg73Lk5KDldesbjLrUmDa/QwiidBAnEHq29wE
	H9dAIMDe0sckFl8mjj3xcRZgv9IujQZ9O18auUR9Uau057V1nRvn34B83NSVBL6d9JZ+Ukkya6C
	M6UbBcARCc+z3imaJQ9PYqSyul9e306m1ybbE/HYsFAFjjfdYanhkXAM3ig+mkvvkYQIn0/h99R
	ntWInDuN/mv2MW6XQqnsERT10jAxyV/GC5wKrRkgAD+T12bZKbPV0cstbvF7pb2SFtvD/wE73gL
	4Ar+tM8pjMgP593hi5ZTyCK5RZPN5yuZ1gm6hmECgpqkS5J/df377I6SCIInCqcEHeBKM4YwemA
	wh+IA1koEJb8bWqBDh0RoDijEAsENDEwpaF8AvtcMQmw9wUnI2sWjctqZcMyQzNhYS/UP/gEK1d
	vWhqRWCsTC93106GVXIsnaY
X-Received: by 2002:a05:6000:2282:b0:482:e62e:a528 with SMTP id ffacd0b85a97d-48488f0e579mr26719951f8f.12.1788445926902;
        Thu, 03 Sep 2026 07:32:06 -0700 (PDT)
Received: from localhost (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-48448ed37c4sm12406333f8f.21.2026.09.03.07.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 07:32:06 -0700 (PDT)
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
Subject: [PATCH net-next v2 5/9] net: bridge: vlan: annotate lockless use of private flags
Date: Thu,  3 Sep 2026 17:31:34 +0300
Message-ID: <20260903143138.1574598-6-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260903143138.1574598-1-razor@blackwall.org>
References: <20260903143138.1574598-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Annotate vlan private flags data races, they can be read lockless.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_arp_nd_proxy.c |  6 ++++--
 net/bridge/br_multicast.c    | 16 ++++++++++------
 net/bridge/br_private.h      |  9 ++++++---
 net/bridge/br_vlan.c         |  2 +-
 net/bridge/br_vlan_options.c |  6 ++++--
 5 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/net/bridge/br_arp_nd_proxy.c b/net/bridge/br_arp_nd_proxy.c
index 87a40e2f1c50..b82fa6589ab9 100644
--- a/net/bridge/br_arp_nd_proxy.c
+++ b/net/bridge/br_arp_nd_proxy.c
@@ -521,7 +521,8 @@ bool br_is_neigh_suppress_enabled(const struct net_bridge_port *p, u16 vid)
 		v = br_vlan_find(vg, vid);
 		if (!v)
 			return false;
-		return !!(v->priv_flags & BR_VLFLAG_NEIGH_SUPPRESS_ENABLED);
+		return !!(READ_ONCE(v->priv_flags) &
+			  BR_VLFLAG_NEIGH_SUPPRESS_ENABLED);
 	}
 	return test_bit(BR_NEIGH_SUPPRESS_BIT, &p->flags);
 }
@@ -535,7 +536,8 @@ bool br_is_neigh_forward_grat_enabled(const struct net_bridge_port *p, u16 vid)
 		v = br_vlan_find(vg, vid);
 		if (!v)
 			return false;
-		return !!(v->priv_flags & BR_VLFLAG_NEIGH_FORWARD_GRAT_ENABLED);
+		return !!(READ_ONCE(v->priv_flags) &
+			  BR_VLFLAG_NEIGH_FORWARD_GRAT_ENABLED);
 	}
 	return test_bit(BR_NEIGH_FORWARD_GRAT_BIT, &p->flags);
 }
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index bbcaedf15ca1..cd984173320f 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -2172,7 +2172,7 @@ static void br_multicast_enable_port_ctx(struct net_bridge_mcast_port *pmctx)
 
 	spin_lock_bh(&br->multicast_lock);
 	if (br_multicast_port_ctx_is_vlan(pmctx) &&
-	    !(pmctx->vlan->priv_flags & BR_VLFLAG_MCAST_ENABLED)) {
+	    !(READ_ONCE(pmctx->vlan->priv_flags) & BR_VLFLAG_MCAST_ENABLED)) {
 		spin_unlock_bh(&br->multicast_lock);
 		return;
 	}
@@ -2209,7 +2209,7 @@ static void br_multicast_disable_port_ctx(struct net_bridge_mcast_port *pmctx)
 
 	spin_lock_bh(&br->multicast_lock);
 	if (br_multicast_port_ctx_is_vlan(pmctx) &&
-	    !(pmctx->vlan->priv_flags & BR_VLFLAG_MCAST_ENABLED)) {
+	    !(READ_ONCE(pmctx->vlan->priv_flags) & BR_VLFLAG_MCAST_ENABLED)) {
 		spin_unlock_bh(&br->multicast_lock);
 		return;
 	}
@@ -4083,7 +4083,8 @@ int br_multicast_rcv(struct net_bridge_mcast **brmctx,
 			*pmctx = &vlan->port_mcast_ctx;
 		}
 
-		if (!(masterv->priv_flags & BR_VLFLAG_GLOBAL_MCAST_ENABLED))
+		if (!(READ_ONCE(masterv->priv_flags) &
+		      BR_VLFLAG_GLOBAL_MCAST_ENABLED))
 			return 0;
 	}
 
@@ -4383,7 +4384,8 @@ void br_multicast_toggle_one_vlan(struct net_bridge_vlan *vlan, bool on)
 			return;
 
 		spin_lock_bh(&br->multicast_lock);
-		vlan->priv_flags ^= BR_VLFLAG_MCAST_ENABLED;
+		WRITE_ONCE(vlan->priv_flags, vlan->priv_flags ^
+					    BR_VLFLAG_MCAST_ENABLED);
 		spin_unlock_bh(&br->multicast_lock);
 
 		if (on)
@@ -4399,7 +4401,8 @@ void br_multicast_toggle_one_vlan(struct net_bridge_vlan *vlan, bool on)
 
 		br = vlan->port->br;
 		spin_lock_bh(&br->multicast_lock);
-		vlan->priv_flags ^= BR_VLFLAG_MCAST_ENABLED;
+		WRITE_ONCE(vlan->priv_flags, vlan->priv_flags ^
+					    BR_VLFLAG_MCAST_ENABLED);
 		if (on)
 			__br_multicast_enable_port_ctx(&vlan->port_mcast_ctx);
 		else
@@ -4477,7 +4480,8 @@ bool br_multicast_toggle_global_vlan(struct net_bridge_vlan *vlan, bool on)
 	if (on == !!(vlan->priv_flags & BR_VLFLAG_GLOBAL_MCAST_ENABLED))
 		return false;
 
-	vlan->priv_flags ^= BR_VLFLAG_GLOBAL_MCAST_ENABLED;
+	WRITE_ONCE(vlan->priv_flags, vlan->priv_flags ^
+				    BR_VLFLAG_GLOBAL_MCAST_ENABLED);
 	br_multicast_toggle_vlan(vlan, on);
 
 	return true;
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 96554d293d22..c7b64b5da012 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1273,21 +1273,24 @@ br_multicast_ctx_vlan_global_disabled(const struct net_bridge_mcast *brmctx)
 {
 	return br_multicast_ctx_is_vlan(brmctx) &&
 	       (!br_opt_get(brmctx->br, BROPT_MCAST_VLAN_SNOOPING_ENABLED) ||
-		!(brmctx->vlan->priv_flags & BR_VLFLAG_GLOBAL_MCAST_ENABLED));
+		!(READ_ONCE(brmctx->vlan->priv_flags) &
+		  BR_VLFLAG_GLOBAL_MCAST_ENABLED));
 }
 
 static inline bool
 br_multicast_ctx_vlan_disabled(const struct net_bridge_mcast *brmctx)
 {
 	return br_multicast_ctx_is_vlan(brmctx) &&
-	       !(brmctx->vlan->priv_flags & BR_VLFLAG_MCAST_ENABLED);
+	       !(READ_ONCE(brmctx->vlan->priv_flags) &
+		 BR_VLFLAG_MCAST_ENABLED);
 }
 
 static inline bool
 br_multicast_port_ctx_vlan_disabled(const struct net_bridge_mcast_port *pmctx)
 {
 	return br_multicast_port_ctx_is_vlan(pmctx) &&
-	       !(pmctx->vlan->priv_flags & BR_VLFLAG_MCAST_ENABLED);
+	       !(READ_ONCE(pmctx->vlan->priv_flags) &
+		 BR_VLFLAG_MCAST_ENABLED);
 }
 
 static inline bool
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index c8b2e3bfd42d..102792f20a5e 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -1497,7 +1497,7 @@ int br_vlan_fill_forward_path_mode(struct net_bridge *br,
 
 	if (path->bridge.vlan_mode == DEV_PATH_BR_VLAN_TAG)
 		path->bridge.vlan_mode = DEV_PATH_BR_VLAN_KEEP;
-	else if (v->priv_flags & BR_VLFLAG_TAGGING_BY_SWITCHDEV)
+	else if (READ_ONCE(v->priv_flags) & BR_VLFLAG_TAGGING_BY_SWITCHDEV)
 		path->bridge.vlan_mode = DEV_PATH_BR_VLAN_UNTAG_HW;
 	else
 		path->bridge.vlan_mode = DEV_PATH_BR_VLAN_UNTAG;
diff --git a/net/bridge/br_vlan_options.c b/net/bridge/br_vlan_options.c
index cb0f556ff40d..bd049d268fe7 100644
--- a/net/bridge/br_vlan_options.c
+++ b/net/bridge/br_vlan_options.c
@@ -276,7 +276,8 @@ static int br_vlan_process_one_opts(const struct net_bridge *br,
 		}
 
 		if (val != enabled) {
-			v->priv_flags ^= BR_VLFLAG_NEIGH_SUPPRESS_ENABLED;
+			WRITE_ONCE(v->priv_flags, v->priv_flags ^
+				   BR_VLFLAG_NEIGH_SUPPRESS_ENABLED);
 			*changed = true;
 		}
 	}
@@ -292,7 +293,8 @@ static int br_vlan_process_one_opts(const struct net_bridge *br,
 		}
 
 		if (val != enabled) {
-			v->priv_flags ^= BR_VLFLAG_NEIGH_FORWARD_GRAT_ENABLED;
+			WRITE_ONCE(v->priv_flags, v->priv_flags ^
+				   BR_VLFLAG_NEIGH_FORWARD_GRAT_ENABLED);
 			*changed = true;
 		}
 	}
-- 
2.47.3

