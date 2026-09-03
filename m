Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC884B7154
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 14:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445949; cv=none; b=d+wUiTelKm4yTRkQo+GuQq/uLA2W+7TS33C3zvXro507YfqtrugR7kYihTPauS5gdZaWnDfOhyYwxdHBimSwmX09RyI8bDqYU1wZjq6VUyt3SfmtQMfPryTd4xtdLE3DnnWLGGemx/0QTP+KWeLH/b2v4l9zxOUqdSRTYqcj5uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445949; c=relaxed/simple;
	bh=InjVNAvLxGWDYxEK1AeR3eh5gYArP4jBsLz0CYulbSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Erh3NSLRtlhYKG/cRV4fbukSjKp2oGB7urVLBu3MyGUYGvBvd8cV18ag9AYWTc5faGRTmnX94Qy0j8Ol9EW8LexBeuzanNA+e18IX6Srvnr1nT8rQuCnCWnItZfy6HQaN1KQ/sofjcw07SjxVjWaofAbYZ61JMTcqqpR7TtDb/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=ag4Hk7SU; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="ag4Hk7SU"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49cdc81f40eso17729045e9.2
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 07:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1788445937; x=1789050737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N/K6O5S2pm84VRJixVdZrdWBEd51ncYWpRSnUeYge4o=;
        b=ag4Hk7SUXuKYT2G2oWk9mXD+rcmMEoCUYbj8n6O0V8HbSIHyTYfDkapteW1OmWP9nL
         TLbD6mFKiapJeRPWwWBvTBPFt7tM8tapBO8e+9BtzsODnSBgDMX78Nvrg6hrWp6qDG2N
         s03pqfWdmhYMUqTZXyrG6awsCGDyrzUG4KIEWJAD4SXMBPi2EJDWDf1r90MfPr2FeboL
         q95LFco6Ay4TO7imzS5H8tUpM9Y0+csacXlV03sRhMnoB6mWYvQsLd8lYh3P0ye3Nwfs
         nEO3HiHLQeHtR2r9hMDwJygYKYV70Rd/3Mt+BKpoai+zQidOn1JA1rw922gvIb0EP1WA
         7voQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788445937; x=1789050737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=N/K6O5S2pm84VRJixVdZrdWBEd51ncYWpRSnUeYge4o=;
        b=c9aR6xC9EtD2CVN4+IcBoTXa/WDvJhmBdWJiwXghN4zmBcGjl0X0t5WMo6w5ChOAo0
         IQiQy4bbJ1qV0VNyRKTHJUyy5o2L8f7WHy8Go3YBGpQmQBCUoUSAipIiBQvHnhATafhV
         4ShHW8U4C9howhJNCuTYJER+jQOKj0+Jju+XO3PClzKD1GInT2Mnl8GGyP055dvgj1EX
         M3Lx5DIrdk3Y5Kgfq+eYGozJqWz1k4kWMQ2IeNNO2ZTuq4EQHAtmmFrb3Arxgz+UokgZ
         d7VVCetFng9f7rfoqKXyh28k0fpDSxVaTyWtiJhfb6HKsKVVpQUWquyJlHp++oVMUQRD
         K3bQ==
X-Gm-Message-State: AFuF++mageMbVTyh0GUrWYOUwPa96o3kPSn14hGm4fA1jTsDnSt8Jz/l
	ugCaXVSK+MyNOSh83CBf2hv1Or73Oo7VpplKnV+X61y7R+cbSwRmjQVDxQKzmwrjQe2eAsd/KYB
	7kdzkDDI=
X-Gm-Gg: AYBFou0ZjVQSpO4XXIwTBxAaKWORSgZjdk6N4xqkdHkXDUg5/ZCQzgPMGlTl1w08hLv
	0duM3v23ijeA5VMLi6nXfgqGV8rdj/k5QkQGibpnnLNTYKbs3k9XU2MPT60mhx/ii7xkotpvbu9
	FIXw0a6NgedvJalsxHwyRDWwe19WvVAJt9X8CHMLiwRzDsv5kBSGIlR25tRGrCV9h82Zde43Yr4
	tzA3uFb9zUBJ8I6hq3KguUctcVLqF33xzekNNaI5bZUIhza/0H6saF1dTYQxon37+3mOzFsNPr/
	sDxNJGJqZZawEn8IV/VlEQfBvVc069teqqITn5mSe0JSgS3ChU0mqZ1/7U01e9tk2aThFPmYjOv
	pYAUHlrR5JbSqAEyro8uP+dgLZjDqpYOeWGNkwZLWF2Nu53POdu9DU96pbo8Zwzwr+fT/YpF/L+
	BTk3ZXfdsBLmjd2t7bpEql7AH8T1NXlN52niH7pGyGr9LwTPkzx2Am9iUcczjABs/SkeBpKPVxL
	GHreN5KGx4=
X-Received: by 2002:a05:600c:3e0a:b0:499:a277:e8b5 with SMTP id 5b1f17b1804b1-49ce5810b5dmr289604115e9.3.1788445937075;
        Thu, 03 Sep 2026 07:32:17 -0700 (PDT)
Received: from localhost (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49cee5d5d12sm74337245e9.5.2026.09.03.07.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 07:32:16 -0700 (PDT)
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
Subject: [PATCH net-next v2 9/9] net: bridge: use br_vlan_get_state to get vlan state
Date: Thu,  3 Sep 2026 17:31:38 +0300
Message-ID: <20260903143138.1574598-10-razor@blackwall.org>
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

The vlan state can change under RTNL or RCU (mst), so use the helper
to get the state properly throughout the bridge driver.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
v2: use br_vlan_get_state consistently where needed (Ido)

 net/bridge/br_mst.c          |  7 ++++---
 net/bridge/br_private.h      | 21 +++++++++++----------
 net/bridge/br_vlan.c         |  2 +-
 net/bridge/br_vlan_options.c |  2 +-
 4 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/net/bridge/br_mst.c b/net/bridge/br_mst.c
index 76a5bf287578..ecd8bba7430e 100644
--- a/net/bridge/br_mst.c
+++ b/net/bridge/br_mst.c
@@ -70,7 +70,7 @@ int br_mst_get_state(const struct net_device *dev, u16 msti, u8 *state)
 
 	list_for_each_entry(v, &vg->vlan_list, vlist) {
 		if (v->brvlan->msti == msti) {
-			*state = v->state;
+			*state = br_vlan_get_state(v);
 			return 0;
 		}
 	}
@@ -145,7 +145,7 @@ static void br_mst_vlan_sync_state(struct net_bridge_vlan *pv, u16 msti)
 		 * it.
 		 */
 		if (v != pv && v->brvlan->msti == msti) {
-			br_mst_vlan_set_state(vg, pv, v->state);
+			br_mst_vlan_set_state(vg, pv, br_vlan_get_state(v));
 			return;
 		}
 	}
@@ -282,7 +282,8 @@ int br_mst_fill_info(struct sk_buff *skb,
 		nest = nla_nest_start_noflag(skb, IFLA_BRIDGE_MST_ENTRY);
 		if (!nest ||
 		    nla_put_u16(skb, IFLA_BRIDGE_MST_ENTRY_MSTI, v->brvlan->msti) ||
-		    nla_put_u8(skb, IFLA_BRIDGE_MST_ENTRY_STATE, v->state)) {
+		    nla_put_u8(skb, IFLA_BRIDGE_MST_ENTRY_STATE,
+			       br_vlan_get_state(v))) {
 			err = -EMSGSIZE;
 			break;
 		}
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index c7b64b5da012..df1500391f1d 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -687,6 +687,15 @@ static inline bool br_vlan_should_use(const struct net_bridge_vlan *v)
 	return true;
 }
 
+/* The vlan state can be changed with only rcu held by the mst code so
+ * annotate the lock-free read. br_vlan_set_state() is kept further down
+ * because it needs br_multicast_update_vlan_mcast_ctx().
+ */
+static inline u8 br_vlan_get_state(const struct net_bridge_vlan *v)
+{
+	return READ_ONCE(v->state);
+}
+
 static inline bool nbp_state_should_learn(const struct net_bridge_port *p)
 {
 	return p->state == BR_STATE_LEARNING || p->state == BR_STATE_FORWARDING;
@@ -1299,7 +1308,7 @@ br_multicast_port_ctx_state_disabled(const struct net_bridge_mcast_port *pmctx)
 	return pmctx->port->state == BR_STATE_DISABLED ||
 	       (br_multicast_port_ctx_is_vlan(pmctx) &&
 		(br_multicast_port_ctx_vlan_disabled(pmctx) ||
-		 pmctx->vlan->state == BR_STATE_DISABLED));
+		 br_vlan_get_state(pmctx->vlan) == BR_STATE_DISABLED));
 }
 
 static inline bool
@@ -1308,7 +1317,7 @@ br_multicast_port_ctx_state_stopped(const struct net_bridge_mcast_port *pmctx)
 	return br_multicast_port_ctx_state_disabled(pmctx) ||
 	       pmctx->port->state == BR_STATE_BLOCKING ||
 	       (br_multicast_port_ctx_is_vlan(pmctx) &&
-		pmctx->vlan->state == BR_STATE_BLOCKING);
+		br_vlan_get_state(pmctx->vlan) == BR_STATE_BLOCKING);
 }
 
 static inline bool
@@ -1916,14 +1925,6 @@ bool br_vlan_global_opts_can_enter_range(const struct net_bridge_vlan *v_curr,
 bool br_vlan_global_opts_fill(struct sk_buff *skb, u16 vid, u16 vid_range,
 			      const struct net_bridge_vlan *v_opts);
 
-/* vlan state manipulation helpers using *_ONCE to annotate lock-free access,
- * while br_vlan_set_state() may access data protected by multicast_lock.
- */
-static inline u8 br_vlan_get_state(const struct net_bridge_vlan *v)
-{
-	return READ_ONCE(v->state);
-}
-
 static inline void br_vlan_set_state(struct net_bridge_vlan *v, u8 state)
 {
 	WRITE_ONCE(v->state, state);
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 95187a607ec2..72b75757ac85 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -40,7 +40,7 @@ static void __vlan_add_pvid(struct net_bridge_vlan_group *vg,
 	if (vg->pvid == v->vid)
 		return;
 
-	br_vlan_set_pvid_state(vg, v->state);
+	br_vlan_set_pvid_state(vg, br_vlan_get_state(v));
 	WRITE_ONCE(vg->pvid, v->vid);
 }
 
diff --git a/net/bridge/br_vlan_options.c b/net/bridge/br_vlan_options.c
index bd049d268fe7..506668fc31d9 100644
--- a/net/bridge/br_vlan_options.c
+++ b/net/bridge/br_vlan_options.c
@@ -43,7 +43,7 @@ bool br_vlan_opts_eq_range(const struct net_bridge_vlan *v_curr,
 	u8 range_mc_rtr = br_vlan_multicast_router(range_end);
 	u8 curr_mc_rtr = br_vlan_multicast_router(v_curr);
 
-	if (v_curr->state != range_end->state)
+	if (br_vlan_get_state(v_curr) != br_vlan_get_state(range_end))
 		return false;
 
 	if (!__vlan_tun_can_enter_range(v_curr, range_end))
-- 
2.47.3

