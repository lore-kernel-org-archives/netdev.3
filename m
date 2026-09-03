Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30BA4BB5C8
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 14:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445937; cv=none; b=MYAmpvS2JyyF0ncdRTmqTT6CCTr7HcnBE4ubXBPgHO5w2wNotPpxqVxJZRTihS8NteFdfa803savC5OZLtFThmtFJlxFFM/0VgHk2Z8OOCW1iGrrfHRwbb56cWT/Pt+DHJktBM6pDPj4MNBiQiC5e7SVYOWeMw9WqZ3N6oWcT34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445937; c=relaxed/simple;
	bh=tdJiRvngwBZJEFqckMVh5CbVJMAJJT/FEcsuLmpJ9ls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fp7rl+dbRj6CkuezwamvM+rSNnNnsahwxJy5D+UlxYFKtjtiCLMJqZgXRDTaOGI+mTtWNI06xEtnDWAYIjQ2DzEKtuhDig6MpyJ3bTmeoeEiV25iNfwEKh1BicDzNTIxpVjAxIjCUpcqiYtOB25L4Sna8uJTR6859PvA6DmNg7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=frlY2Qx6; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="frlY2Qx6"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49b0d78a801so20781845e9.2
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 07:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1788445925; x=1789050725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HMMQOAlRYAextL0wqVjD4N5g4g594G9DLp/sV2LJqQE=;
        b=frlY2Qx6iKxcPqamQw9kIy+dc6QdIbOIF9iXxwPHSb6zzJNJm+vZ70+W2pNBzhR+/j
         idpZHWo6QOWs8nswCPS2SHCVyAhzowmoPCjY+i0/Z2su8a02ZKkLI7GTj2hyfRp05/sw
         TQakguXwZ58waK5c0HG8kp3zo7L6mi7ulB46B5bXNMZyuM8EKp4xpNX8IHS4GltHNfOI
         teZmWWk2d8v0hbGH62X7VFC/UY7oHJHgRH3PA9h12abKMWbuyoz+YQRF8mzFgZmn/sg/
         nc9QhH4qKyif64Dq+ca/wiwO3GuD5At9Ckca67jTOA6mzn4AxvH3WqN3ZCd76tKYZwGy
         u0MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788445925; x=1789050725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HMMQOAlRYAextL0wqVjD4N5g4g594G9DLp/sV2LJqQE=;
        b=Md7k0LeHkN/OyhA/+HoNWev9GO0JnN9x/h8XasvdCz/aFqhdGVCG3SqlGbRFQYt0Cq
         oOjfd1iimcbBRKZ8w5WX81r4Ji9+FftDrGrm+BDZ9YgEfWPiy4Az5iUJbl/BiFP+OQbF
         xrAPkbsX16+SgzSkNt7GdXC3Au1IdBXcftRoiY5s8dzNgfXu7BvChV4H5HhaYTfTxeWS
         CeXx1OZWH5Jqj35ZwIeo18UexVOTfI2sbBw9Lu53lP3AHe92EBE9TdGtzGoX1+3ye9PZ
         dn5xikkUs1fF3snymz177I/TLT3z4ZvBVp6QkHoQ4G6iUwHaHTgOvKU1i1kWrOLwHUWM
         HS7A==
X-Gm-Message-State: AFuF++l2j9Wn2TZ7JlXGb9XVMU+H7shqTcL1NFOUZ9Qte6HxENY5QpmW
	rR7HlRRKBLSoDxn6HMOL3iMzgYO4veM96/5YssG+fgL0i8myfPdB4h+FBxaYjA7H6JI9HWkjrvH
	sLybTiEc=
X-Gm-Gg: AYBFou3Fn8CShK8kbQTSbcVZFlb1cbwtjHC34TNKp0VluGN9+IfII9fF2cLdzV9onpE
	Y++KgyZZor3/HHYc5VsHwScDsHq9JjmAP3zS2KfYzZ2U0jdu2d4an90sgXM4+xXPf/9umAHR4Ci
	ohw3N1Va3H0ajwWkNN8IOrj8BPu5yQhaXOt4g4XI3onPcTE/B9ahJt5PxJMljVuEUoA23mvy2As
	Q5jiPEVi09viJH0i7WlVxzRSGDGLx8+DMx67stY8TNsgz6GEZezKI3bpcN8FKNNnXNJeEB+AMyn
	48nDwyVBOebFM7Kx/t6UXpQxxcmyLqde4ca6zDKsae16vZ9L6mW3SD9lByV4NIZFXHT1VxNYuzR
	XwP3V1UGAyEcXsQCChoNMxcFyadfctI64c+cu9Qu7BegmMgfJ/vsX6DnNWuBCZObGdFIXpDqOr1
	2ed7uxal8vnEE5gULzEKvJ7aWfijtQSaoZIVD18LXYSSBmhx3U1Scgdujkzai3HQYTws/30dkEB
	lOqkpcWkqDPfrSkuf2RZA==
X-Received: by 2002:a05:600c:a0b:b0:49b:910c:7703 with SMTP id 5b1f17b1804b1-49ce5818612mr225838985e9.9.1788445924852;
        Thu, 03 Sep 2026 07:32:04 -0700 (PDT)
Received: from localhost (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49cee5f914bsm91619145e9.3.2026.09.03.07.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 07:32:04 -0700 (PDT)
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
Subject: [PATCH net-next v2 4/9] net: bridge: vlan: annotate lockless vlan flags use
Date: Thu,  3 Sep 2026 17:31:33 +0300
Message-ID: <20260903143138.1574598-5-razor@blackwall.org>
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

Annotate vlan flags data races, they can be read lockless.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_multicast.c |  2 +-
 net/bridge/br_netlink.c   |  6 +++---
 net/bridge/br_private.h   |  4 ++--
 net/bridge/br_vlan.c      | 19 +++++++++++--------
 4 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 3ef5d8bbf552..bbcaedf15ca1 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -912,7 +912,7 @@ static void __br_multicast_query_handle_vlan(struct net_bridge_mcast *brmctx,
 	else if (br_multicast_ctx_is_vlan(brmctx))
 		vlan = brmctx->vlan;
 
-	if (vlan && !(vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED)) {
+	if (vlan && !(READ_ONCE(vlan->flags) & BRIDGE_VLAN_INFO_UNTAGGED)) {
 		u16 vlan_proto;
 
 		if (br_vlan_get_proto(brmctx->br->dev, &vlan_proto) != 0)
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index b2cd4e39326d..62ce96d9ba32 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -41,7 +41,7 @@ static int __get_num_vlan_infos(struct net_bridge_vlan_group *vg,
 		if (v->vid == pvid)
 			flags |= BRIDGE_VLAN_INFO_PVID;
 
-		if (v->flags & BRIDGE_VLAN_INFO_UNTAGGED)
+		if (READ_ONCE(v->flags) & BRIDGE_VLAN_INFO_UNTAGGED)
 			flags |= BRIDGE_VLAN_INFO_UNTAGGED;
 
 		if (vid_range_start == 0) {
@@ -385,7 +385,7 @@ static int br_fill_ifvlaninfo_compressed(struct sk_buff *skb,
 		if (v->vid == pvid)
 			flags |= BRIDGE_VLAN_INFO_PVID;
 
-		if (v->flags & BRIDGE_VLAN_INFO_UNTAGGED)
+		if (READ_ONCE(v->flags) & BRIDGE_VLAN_INFO_UNTAGGED)
 			flags |= BRIDGE_VLAN_INFO_UNTAGGED;
 
 		if (vid_range_start == 0) {
@@ -437,7 +437,7 @@ static int br_fill_ifvlaninfo(struct sk_buff *skb,
 		if (v->vid == pvid)
 			vinfo.flags |= BRIDGE_VLAN_INFO_PVID;
 
-		if (v->flags & BRIDGE_VLAN_INFO_UNTAGGED)
+		if (READ_ONCE(v->flags) & BRIDGE_VLAN_INFO_UNTAGGED)
 			vinfo.flags |= BRIDGE_VLAN_INFO_UNTAGGED;
 
 		if (nla_put(skb, IFLA_BRIDGE_VLAN_INFO,
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 0efd2e79e255..96554d293d22 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -665,13 +665,13 @@ static inline int br_is_root_bridge(const struct net_bridge *br)
 /* check if a VLAN entry is global */
 static inline bool br_vlan_is_master(const struct net_bridge_vlan *v)
 {
-	return v->flags & BRIDGE_VLAN_INFO_MASTER;
+	return READ_ONCE(v->flags) & BRIDGE_VLAN_INFO_MASTER;
 }
 
 /* check if a VLAN entry is used by the bridge */
 static inline bool br_vlan_is_brentry(const struct net_bridge_vlan *v)
 {
-	return v->flags & BRIDGE_VLAN_INFO_BRENTRY;
+	return READ_ONCE(v->flags) & BRIDGE_VLAN_INFO_BRENTRY;
 }
 
 /* check if we should use the vlan entry, returns false if it's only context */
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index a53054fcc093..c8b2e3bfd42d 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -60,6 +60,7 @@ static bool __vlan_flags_update(struct net_bridge_vlan *v, u16 flags,
 				bool commit)
 {
 	struct net_bridge_vlan_group *vg;
+	u16 vlan_flags;
 	bool change;
 
 	if (br_vlan_is_master(v))
@@ -68,8 +69,9 @@ static bool __vlan_flags_update(struct net_bridge_vlan *v, u16 flags,
 		vg = nbp_vlan_group(v->port);
 
 	/* check if anything would be changed on commit */
+	vlan_flags = v->flags;
 	change = !!(flags & BRIDGE_VLAN_INFO_PVID) == !!(vg->pvid != v->vid) ||
-		 ((flags ^ v->flags) & BRIDGE_VLAN_INFO_UNTAGGED);
+		 ((flags ^ vlan_flags) & BRIDGE_VLAN_INFO_UNTAGGED);
 
 	if (!commit)
 		goto out;
@@ -80,9 +82,10 @@ static bool __vlan_flags_update(struct net_bridge_vlan *v, u16 flags,
 		__vlan_delete_pvid(vg, v->vid);
 
 	if (flags & BRIDGE_VLAN_INFO_UNTAGGED)
-		v->flags |= BRIDGE_VLAN_INFO_UNTAGGED;
+		vlan_flags |= BRIDGE_VLAN_INFO_UNTAGGED;
 	else
-		v->flags &= ~BRIDGE_VLAN_INFO_UNTAGGED;
+		vlan_flags &= ~BRIDGE_VLAN_INFO_UNTAGGED;
+	WRITE_ONCE(v->flags, vlan_flags);
 
 out:
 	return change;
@@ -413,7 +416,7 @@ static int __vlan_del(struct net_bridge_vlan *v)
 	}
 
 	if (br_vlan_should_use(v)) {
-		v->flags &= ~BRIDGE_VLAN_INFO_BRENTRY;
+		WRITE_ONCE(v->flags, v->flags & ~BRIDGE_VLAN_INFO_BRENTRY);
 		vg->num_vlans--;
 	}
 
@@ -522,7 +525,7 @@ struct sk_buff *br_handle_vlan(struct net_bridge *br,
 	 * hardware on each egress port as appropriate. So only strip the VLAN
 	 * header if forwarding offload is not being used.
 	 */
-	if (v->flags & BRIDGE_VLAN_INFO_UNTAGGED &&
+	if (READ_ONCE(v->flags) & BRIDGE_VLAN_INFO_UNTAGGED &&
 	    !br_switchdev_frame_uses_tx_fwd_offload(skb))
 		__vlan_hwaccel_clear_tag(skb);
 
@@ -753,7 +756,7 @@ static int br_vlan_add_existing(struct net_bridge *br,
 		}
 
 		refcount_inc(&vlan->refcnt);
-		vlan->flags |= BRIDGE_VLAN_INFO_BRENTRY;
+		WRITE_ONCE(vlan->flags, vlan->flags | BRIDGE_VLAN_INFO_BRENTRY);
 		vg->num_vlans++;
 		*changed = true;
 		br_multicast_toggle_one_vlan(vlan, true);
@@ -1489,7 +1492,7 @@ int br_vlan_fill_forward_path_mode(struct net_bridge *br,
 	if (!v || !br_vlan_should_use(v))
 		return -EINVAL;
 
-	if (!(v->flags & BRIDGE_VLAN_INFO_UNTAGGED))
+	if (!(READ_ONCE(v->flags) & BRIDGE_VLAN_INFO_UNTAGGED))
 		return 0;
 
 	if (path->bridge.vlan_mode == DEV_PATH_BR_VLAN_TAG)
@@ -1550,7 +1553,7 @@ int br_vlan_get_info_rcu(const struct net_device *dev, u16 vid,
 		return -ENOENT;
 
 	p_vinfo->vid = vid;
-	p_vinfo->flags = v->flags;
+	p_vinfo->flags = READ_ONCE(v->flags);
 	if (vid == br_get_pvid(vg))
 		p_vinfo->flags |= BRIDGE_VLAN_INFO_PVID;
 	return 0;
-- 
2.47.3

