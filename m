Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882C7288C81
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 16:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781108331; cv=none; b=mNe5s7ctrp7kLfff72n4oHrEYHbU1UXGdp0h/h1EU824uCG5Dz0yNYxK/nEU1Am9S2EYtmWBc7mlTYWDw2e45uRVLDKvxilxP4smpEdR+tLBoJd7YkqLbb9JEWxUlcJ8zhqhVWB8Nt5zMI4LEqJz3JBAGdiorxSfrHWmqFDZXWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781108331; c=relaxed/simple;
	bh=mED06VINe7dS2B7mShSqxlyZ3pIYAUNuda9BdJC67vs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dLEOTQOElTwRzQSj0I4gp8MCHyJ/GZoiO0zvMLBgGLEV0b1jLZW3PglbmWB8/OmJH22j+JACQt90jXyRTwGtDOUL1uj1Rsuy+lRhgbpPmk06QVroqfTcC+7VfSQG3hKMJbQhhZpDAm0rZg3kngJvfz26to5kWMTmZ64yX8PnaSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oNZyb9Hq; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oNZyb9Hq"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-7dd0a103a3dso142831067b3.1
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 09:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781108329; x=1781713129; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hpaqf0KR4IZXlJU0Cf016CqjeVJePELwNDy7rONLcU0=;
        b=oNZyb9Hqo/CfZKCwFBN3oF1YfcqBPglRcsuJWjyPB4QzO8TaxsVXztWq9RYcbVMleB
         WJpA2bMKPXEkHsSk3ZoTEZZcEZWlGmWtzBwVBdiBofaNmUPq49B7X+V6bnbyooTpKre/
         ch9XASJ1TigxsEXCA35tc91hsMuGXRwVIyxDv/dENr2xmnM5X+NV5x5VBHhUaU3RUO4X
         8ulQddGSho8zRSY9DqW8DaYyI3YDiCcQLy2mQlQwV7YYz4SSSh8mIsgZCWgkPSBvlPEd
         fpz8Dg+WRXYh4UVpBnvUpK1vuV+xzq9cD4VIM70lzyvN5kSG/2/yE82l9zoNXCP9DN0m
         myJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781108329; x=1781713129;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hpaqf0KR4IZXlJU0Cf016CqjeVJePELwNDy7rONLcU0=;
        b=js0oh3ykroi9d7td6JUOHit8MawDHlSBM7513Vkwefs48lZWYXp3abbyqhc3sE12x8
         jM2qOJqrMQJShu9nJ6PxtWKmpVRY2riuet7YtGGvNkxeJS3b5aRKUi9LGBsn4pjOO6Ea
         kcwy+LE8GKba+7AqDtIwje5TfrXfyjV0iFBJSZvu+PQlg2FQ6/jWiZlrgrzZ6k0BHhPX
         z6+Gi81QiYqfSin8Nr2LqDtABExq8Dr2EyRtsZG7lAZXhvvVL2pZV641ol9WenvKyCvw
         6Xc7qrQj3R/CFSWgZhmFddKNJz8WgmCzWXGq4SI0n+N92awMkkHk5/fxTACuSkFzKtQc
         rmIg==
X-Forwarded-Encrypted: i=1; AFNElJ+6P1dONs5BDo0ZuycgESfMgzsK4YPoPuaaq6eErsY2Cu4PkBSE4Kt9W86nvF/YKP3xNNsbtig=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzFRx1uQG/MbklF5HfcCGx5k/zZecmKlSsy5iSJLuEHPUJfatf
	qama0k0iVKo+MxqMtzoWC52eCu0N5KPvkk98ho4AmN2lPXo0AuQibWpE+4yEV88ciDjooo9cEwF
	tEuC16gnrNPE7Wg==
X-Received: from ywdg13.prod.google.com ([2002:a05:690c:c3cd:b0:7ef:af3b:4d18])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:d87:b0:7e4:f6e4:9f4b with SMTP id 00721157ae682-7ed0e671781mr259924037b3.42.1781108329182;
 Wed, 10 Jun 2026 09:18:49 -0700 (PDT)
Date: Wed, 10 Jun 2026 16:18:32 +0000
In-Reply-To: <20260610161836.1275531-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260610161836.1275531-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <20260610161836.1275531-2-edumazet@google.com>
Subject: [PATCH v2 net-next 1/5] bridge: use atomic ops to read/change
 p->flags in sysfs
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Change net/bridge/br_sysfs_if.c to use atomic operations
to read/change bits n p->flags.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/bridge/br_sysfs_if.c | 61 ++++++++++++++++++++++------------------
 1 file changed, 33 insertions(+), 28 deletions(-)

diff --git a/net/bridge/br_sysfs_if.c b/net/bridge/br_sysfs_if.c
index 1923c004f0d2b746902f5b6de1bbb72f7f824125..738544901563f570355554f49b2b80cf962f8e71 100644
--- a/net/bridge/br_sysfs_if.c
+++ b/net/bridge/br_sysfs_if.c
@@ -44,40 +44,45 @@ const struct brport_attribute brport_attr_##_name = { 	        \
 	.store	= _store,					\
 };
 
-#define BRPORT_ATTR_FLAG(_name, _mask)				\
+#define BRPORT_ATTR_FLAG(_name, _bitnr)				\
 static ssize_t show_##_name(struct net_bridge_port *p, char *buf) \
 {								\
-	return sysfs_emit(buf, "%d\n", !!(p->flags & _mask));	\
+	return sysfs_emit(buf, "%d\n", test_bit(_bitnr, &p->flags));	\
 }								\
 static int store_##_name(struct net_bridge_port *p, unsigned long v) \
 {								\
-	return store_flag(p, v, _mask);				\
+	return store_flag(p, v, _bitnr);				\
 }								\
 static BRPORT_ATTR(_name, 0644,					\
 		   show_##_name, store_##_name)
 
 static int store_flag(struct net_bridge_port *p, unsigned long v,
-		      unsigned long mask)
+		      unsigned long bitnr)
 {
+	unsigned long oflags, flags = READ_ONCE(p->flags);
 	struct netlink_ext_ack extack = {0};
-	unsigned long flags = p->flags;
 	int err;
 
+
+	oflags = flags;
 	if (v)
-		flags |= mask;
+		__set_bit(bitnr, &flags);
 	else
-		flags &= ~mask;
+		__clear_bit(bitnr, &flags);
 
-	if (flags != p->flags) {
-		err = br_switchdev_set_port_flag(p, flags, mask, &extack);
-		if (err) {
-			netdev_err(p->dev, "%s\n", extack._msg);
-			return err;
-		}
+	if (flags == oflags)
+		return 0;
 
-		p->flags = flags;
-		br_port_flags_change(p, mask);
+	err = br_switchdev_set_port_flag(p, flags, BIT(bitnr), &extack);
+	if (err) {
+		netdev_err(p->dev, "%s\n", extack._msg);
+		return err;
 	}
+	if (v)
+		set_bit(bitnr, &p->flags);
+	else
+		clear_bit(bitnr, &p->flags);
+	br_port_flags_change(p, BIT(bitnr));
 	return 0;
 }
 
@@ -247,17 +252,17 @@ static int store_backup_port(struct net_bridge_port *p, char *buf)
 }
 static BRPORT_ATTR_RAW(backup_port, 0644, show_backup_port, store_backup_port);
 
-BRPORT_ATTR_FLAG(hairpin_mode, BR_HAIRPIN_MODE);
-BRPORT_ATTR_FLAG(bpdu_guard, BR_BPDU_GUARD);
-BRPORT_ATTR_FLAG(root_block, BR_ROOT_BLOCK);
-BRPORT_ATTR_FLAG(learning, BR_LEARNING);
-BRPORT_ATTR_FLAG(unicast_flood, BR_FLOOD);
-BRPORT_ATTR_FLAG(proxyarp, BR_PROXYARP);
-BRPORT_ATTR_FLAG(proxyarp_wifi, BR_PROXYARP_WIFI);
-BRPORT_ATTR_FLAG(multicast_flood, BR_MCAST_FLOOD);
-BRPORT_ATTR_FLAG(broadcast_flood, BR_BCAST_FLOOD);
-BRPORT_ATTR_FLAG(neigh_suppress, BR_NEIGH_SUPPRESS);
-BRPORT_ATTR_FLAG(isolated, BR_ISOLATED);
+BRPORT_ATTR_FLAG(hairpin_mode, BR_HAIRPIN_MODE_BIT);
+BRPORT_ATTR_FLAG(bpdu_guard, BR_BPDU_GUARD_BIT);
+BRPORT_ATTR_FLAG(root_block, BR_ROOT_BLOCK_BIT);
+BRPORT_ATTR_FLAG(learning, BR_LEARNING_BIT);
+BRPORT_ATTR_FLAG(unicast_flood, BR_FLOOD_BIT);
+BRPORT_ATTR_FLAG(proxyarp, BR_PROXYARP_BIT);
+BRPORT_ATTR_FLAG(proxyarp_wifi, BR_PROXYARP_WIFI_BIT);
+BRPORT_ATTR_FLAG(multicast_flood, BR_MCAST_FLOOD_BIT);
+BRPORT_ATTR_FLAG(broadcast_flood, BR_BCAST_FLOOD_BIT);
+BRPORT_ATTR_FLAG(neigh_suppress, BR_NEIGH_SUPPRESS_BIT);
+BRPORT_ATTR_FLAG(isolated, BR_ISOLATED_BIT);
 
 #ifdef CONFIG_BRIDGE_IGMP_SNOOPING
 static ssize_t show_multicast_router(struct net_bridge_port *p, char *buf)
@@ -273,8 +278,8 @@ static int store_multicast_router(struct net_bridge_port *p,
 static BRPORT_ATTR(multicast_router, 0644, show_multicast_router,
 		   store_multicast_router);
 
-BRPORT_ATTR_FLAG(multicast_fast_leave, BR_MULTICAST_FAST_LEAVE);
-BRPORT_ATTR_FLAG(multicast_to_unicast, BR_MULTICAST_TO_UNICAST);
+BRPORT_ATTR_FLAG(multicast_fast_leave, BR_MULTICAST_FAST_LEAVE_BIT);
+BRPORT_ATTR_FLAG(multicast_to_unicast, BR_MULTICAST_TO_UNICAST_BIT);
 #endif
 
 static const struct brport_attribute *brport_attrs[] = {
-- 
2.54.0.1099.g489fc7bff1-goog

