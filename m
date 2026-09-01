Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B8D3CF1FC
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 12:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788264467; cv=none; b=ucZbByR7oAfdfZhbB4Zvi+xNWfuigAmh2UGPEImQXwOvIHpOVd0ZtyVr9Ke9rjHLAg/cG4fFqRWIh7jFb+aU4P/+685NyelUPFWlnK4Y2bKtNXeUQ/wBbIDDY0iDZAmGjp3i0qAIwh88K1an1C9tqSK9j70beJCABKaG3k7asVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788264467; c=relaxed/simple;
	bh=wXTs7/mwUOm9B82JGE5NjvfCN2BrknQqFyvqV/ssMQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hA8Wjy/6VXkJ7ofVAsOL0gILcSqLb6vrOKKHMnakWHBYjdkvluArroaUik+iqozj6xleu1kU5Ww2GYQG8YsD/US+g8lS0THTm8/fVEtlhI5K01RP9GaNgWoFkd61bKu77VjYc58XK3pyVEdzmqJJ6SFWThqkfeoebK5HjjDVUTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=FCmKBDO1; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="FCmKBDO1"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49b8be0409fso6417045e9.2
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 05:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1788264464; x=1788869264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=17pAeXAPWqC20adwChneYdX1dfRnINnx5gBEzZVTcEg=;
        b=FCmKBDO1lX9EeKLfb0GGDWorKaRyXL8ChZPVMs2OUdNSehEclJSWR4IFukBMkT+GcJ
         tcsgBnFYXubcfCNkquMae50o582KE0s/3bwfi/66Cihnr9aSq3bDp1fNaMdLub7gpo4I
         ri7ghNHijvgYrZVWUui4RofMSnMp/ieIFQ83nYEpKNJ/4knnTdUzhZ5gqNTb/kwdGei8
         +OHIG0qG9cqZPpsAHOgiKgsb2Y/5n3PE7eMwjEKIZ/MinUXqbJqK8o+2qoKCt6Mo87hU
         1uJhLiNaOEwdrBFTwS654QpLGEPHOK5VtWAXG/z9OMKyaT8EKXCVqkxjRGKFpei82j6C
         c6ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788264464; x=1788869264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=17pAeXAPWqC20adwChneYdX1dfRnINnx5gBEzZVTcEg=;
        b=SZ3FyJTqWqf6SIiVUQOgDUkTpZqUnhgUvkfs13Eu0lfO6CyWm30g66EK6VKUtdP5IW
         HM3gMIzSdJv6xloKHSv4OhWj93xz9jstWy72Ix8KUgHEGJFnvYGtHVKj+07Pma0aJlXs
         gSVc4eso1Pyqrc+tH/poKc6fX/2bD81YPyCWWsJXPJtM2FrhoBAA2HtAuCKzpFOLQ6Y7
         A+26JfExo/pZJQ5DoOvMQFe1Rv/71fJVSGbAlwi8upzJEf+q5RIGkjATDSGEIFxUwsMv
         8dE/6vxvDwgaWybQMv6mgVsZ9jiy4tA+X1RmmFU+SpGqfwpptV6tB2s1X4krjLuI0Zf4
         GE5Q==
X-Gm-Message-State: AFuF++nB7fITMtwYXaR3nRv1TpJBy1ZoPpxcPsKZITnXOHI19x90Oe5p
	oozrHCrWV07OY5OrqCXR7YIvkqqMXPB9knhXYfI7un989PUFh44v0KXXfgf0ym2ObwGmrZhAoY7
	iYzBMZBvqpg==
X-Gm-Gg: AR+sD127aHXx6877ivU0Y/gtlmFacW8yQKkwOHx/04lfIIF/qXuf2VoiymKRfPeRzyC
	a9qV+l2uIwVXeNbANiO8+SZEr7VjJBRHxYg39wfghl0HJjW5iGBRsvHz4rLA++TDRWrA4JOg69E
	yvK/igCFh+1EQ234756GMqdupIx53ljCWRIm1YRhwEYCCuXTa1n1UUvvx1875NkAbSyRD+aUNBy
	jylGvw/ocvC66MR1MLTq08b4h6n0AtVs+CYGz21kIT+yp/XQVd5POCOqVecKHkQBd9lOSa4kq8t
	B6BMXqgr/7xCgwBXp5+RhXp2NY9Y5Z428yk9Xvyd0m/B++ve4zKvFDciyNc9Kj6biGF7i3oOa/6
	LdjmJhiGEsRHd0vVoD93FXlY1uIDHNUsl0S8Q97sLLuyL5DApNRW4MxanhBuvEHdL4iGT38dmEG
	YElxK3T+PEyaxY4FkOjsMeqE9fH+S5Oy5+aVjZgB7w0TAqAwgp/PnsbB9/he8fP4eAEuNzVNvhL
	sRoCnX5FvYF
X-Received: by 2002:a05:600c:1549:b0:49c:d294:41e5 with SMTP id 5b1f17b1804b1-49cd294439fmr280766635e9.8.1788264463460;
        Tue, 01 Sep 2026 05:07:43 -0700 (PDT)
Received: from localhost (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49cdce10148sm61876185e9.5.2026.09.01.05.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 05:07:42 -0700 (PDT)
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
Subject: [PATCH net-next 5/9] net: bridge: vlan: annotate lockless use of private flags
Date: Tue,  1 Sep 2026 15:07:17 +0300
Message-ID: <20260901120721.747908-6-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260901120721.747908-1-razor@blackwall.org>
References: <20260901120721.747908-1-razor@blackwall.org>
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

