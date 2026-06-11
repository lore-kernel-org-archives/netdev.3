Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EA73AB292
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 20:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781210099; cv=none; b=k88Mm6NcisTTXK+t+iYrs/Uoz2cblDk3d82R93+7kvSRZDX+96PMM8lU8QawiTAImz5ez5wsYxrCdGhLUF5zGZKA0wMqqWXMuFEd+Qd5fY9resrG9mv1E8J7EZzG+jbdOlMV0uIr7c0IlUHT6mFPZbWry/R4HrRvDPM+yzp5H3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781210099; c=relaxed/simple;
	bh=H0PZjcPWcZXOH8XyeSpVvMaQj4HK/ooLIPlsk7daMRw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CMFt7B6FajJgqvPSwVbc72DlovZaTXjHiijtzVb7yAz9lpR6OUIpD2Wi8+bSKyv2sOcfqzC5ZI+/jeEKtjGidT10gfFIYk/G1jDVuVlFvTABqgVH7tB2L+fzUoV82Ogj7bb/X+Jg+NURxIVoPb+t3igGYkhnJZMUv+n9szesfQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pvz3Bytj; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pvz3Bytj"
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-517dadd84f8so3796811cf.0
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 13:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781210097; x=1781814897; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NSqQ/8/7BMfULxchuqV2MU9u7rm6njyT+5xhTnlk528=;
        b=Pvz3BytjkwozRG+FojZdyXFfYNpWyxNzSd2PVsI4nYu4cK+z+1jInRJCmPVwtnr+GE
         7HuqwZDnRrtIMosWBhVC7sRDgTdGUvMLPD68LVT+HpOUG7f1jo1yQ2yALfcU8G+N0RDf
         +Xn/jCdsxidP0LLgTEUACUbeT7kdeeh1l/hOsZHcU9ItIpMSMkcd6fvofWy/UfGODpQw
         BzKBRviJghcX7IZCRWtnaUpvLdaFpKnNOZPGXwcMEdKNSlkruVc6OavvQuAgKCDSniTV
         r5FgRXWD7WaFY68jtzKake1zj5eGw97SrQ1qwaekZ0TVXcTYYvE82JZGA56MjSUyh/TX
         oEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781210097; x=1781814897;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NSqQ/8/7BMfULxchuqV2MU9u7rm6njyT+5xhTnlk528=;
        b=DT9Q71h7ZekPJILGbe0KWgnfy6k3sqSSJLClPjY8uoSeuThTJ81w5Sa+NN3w2naAN3
         5Zgz2YTrfSPqmyNAOfFxh4bsB4EIdSjhx2Dr/YSGVSQNmCdCF2HkTwHbccob+XK7QYw2
         Q1Iw1/q8dMu4+rX7XwUvlOpGuLslpYOMcPEkAuTC8XmOuaX9MhRCQVvAkSaieZqSzOGp
         FHDttPk9GZkBQC9ob6s1hVRR0oP1QdN5EqjzpWYfx/g5dsskP5nxMx1Kep4MiAcIVA9G
         IpurwU998V/uHkR7HK9sS4/5nElCldO1kpm0EgcHQ9rNbu/KJbQ75NBWGPtxt5f+x8iG
         4vEw==
X-Forwarded-Encrypted: i=1; AFNElJ/Gk+mzOXkZzc1eoaGIJin94xGon15hUa6A/hJwM0TkckvY+TsJcDfaUaxlyuw/1YZ3XWfcN+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXF81K3DDc9GLTXjlMRldiUwOqIysrCAXwD3SnXT2oa6dmpMia
	yjFU7o4VEzrilN16wwOeoVq7d+YjeAQ8ZeMY8y7LISxAI6+mtnm+aSxvjSJso8dthbUJkAiLHkG
	46OKynYycy74tew==
X-Received: from qvbdr14.prod.google.com ([2002:a05:6214:8ee:b0:8ac:b7d7:44b6])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5fc5:0:b0:50d:a6e3:ae1 with SMTP id d75a77b69052e-517edd1bbd6mr69890881cf.17.1781210096433;
 Thu, 11 Jun 2026 13:34:56 -0700 (PDT)
Date: Thu, 11 Jun 2026 20:34:49 +0000
In-Reply-To: <20260611203453.3067462-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260611203453.3067462-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260611203453.3067462-2-edumazet@google.com>
Subject: [PATCH v3 net-next 1/5] bridge: use atomic ops to read/change
 p->flags in sysfs
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Change net/bridge/br_sysfs_if.c to use atomic operations
to read/change bits in p->flags.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_sysfs_if.c | 60 +++++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 28 deletions(-)

diff --git a/net/bridge/br_sysfs_if.c b/net/bridge/br_sysfs_if.c
index 1923c004f0d2b746902f5b6de1bbb72f7f824125..bde731c01e10adf523fa93018555e05d912e4ac3 100644
--- a/net/bridge/br_sysfs_if.c
+++ b/net/bridge/br_sysfs_if.c
@@ -44,40 +44,44 @@ const struct brport_attribute brport_attr_##_name = { 	        \
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
 
@@ -247,17 +251,17 @@ static int store_backup_port(struct net_bridge_port *p, char *buf)
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
@@ -273,8 +277,8 @@ static int store_multicast_router(struct net_bridge_port *p,
 static BRPORT_ATTR(multicast_router, 0644, show_multicast_router,
 		   store_multicast_router);
 
-BRPORT_ATTR_FLAG(multicast_fast_leave, BR_MULTICAST_FAST_LEAVE);
-BRPORT_ATTR_FLAG(multicast_to_unicast, BR_MULTICAST_TO_UNICAST);
+BRPORT_ATTR_FLAG(multicast_fast_leave, BR_MULTICAST_FAST_LEAVE_BIT);
+BRPORT_ATTR_FLAG(multicast_to_unicast, BR_MULTICAST_TO_UNICAST_BIT);
 #endif
 
 static const struct brport_attribute *brport_attrs[] = {
-- 
2.54.0.1136.gdb2ca164c4-goog

