Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062B5351C2F
	for <netdev@vger.kernel.org>; Sun,  6 Sep 2026 18:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788717683; cv=none; b=dhuXuQ61cNTpM6Z0ENlLUjhkACotXSW1eIYPZjtYx2V3U++jaD94lsGp47zd0NYOvNqmIVvQT9zbQavYGWfXEeniIdC8Dkw2yn0s7MstJvogXU4Hfy7bF2bY+pg0gP6alKP+1tP41oczLHHhvKSxc7oI2R3SqDDtnSHu2abTFJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788717683; c=relaxed/simple;
	bh=7umJeEaU1+7WhfO3EydyMvXz70VqPM+Hn45dS8V8GPA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qs7KTJsj69ugP/odY2cT8h8IOkQXXAPzSSELP3h11nmCEv9dgwPuIO8pdSdIiAeaPIIDieNuUpXtQ00N399vKI0ZOe10Q4Ecpr5PwcaAJBPm5eSqPuclHkgrZMFks8oWYuXOW1kaF7gSpqSOxnieJJqSaGNBXdxTDWF8xyIFG58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AhWltPqG; arc=none smtp.client-ip=209.85.219.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AhWltPqG"
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-91037946caeso23977286d6.2
        for <netdev@vger.kernel.org>; Sun, 06 Sep 2026 11:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788717681; x=1789322481; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x3XSFOky4tAhXMQoYLouibb+bBC+Oc51uMQbeb6pOYk=;
        b=AhWltPqG0iUpwQlUn6hX0V4PsaYYyd7J32flHC9DiS9FCJ0JPGuLUy+rw719PTBVpc
         nqKA5dRrQ0a4rykZsSg0SN0KHtt8W5TO4A9b67zlcI/XvlWQXbCDqxqCFI4qGRq1SrvL
         KJqe4g0j2AX6JqZgaBH+rCupPU4WAUyRFmOwAHw1mG/gIHod0UcMWgQmcXt88vm0qWmi
         vQgtqqYcp3Nelp24r3e1isKPrOanLX82dbq4NvLr5/zenw2jRrhmR9ha/jLOH1Cs/9hx
         R9jBZ4/xlSX5vl3u95DJWUK7Rf2Dn88fe2u0fyOeKtzWAFM2OfYpt183C3WTQs/hfpG5
         lpVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788717681; x=1789322481;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x3XSFOky4tAhXMQoYLouibb+bBC+Oc51uMQbeb6pOYk=;
        b=QhbOW7h1YycwdvgDgwTQROcFXUFBR8Ch/kwJ4qCovCOPuwtofyea9AKt8QP1KalAx5
         jFVcuc1rH7fXFns6QCpVO2p4h2nAI/xxozssOzkWHISUg9ICK6/2jnSLbM/yOPukr5+Z
         boj7/sFy8GIJJdkfO/hvjqgTRxKyDf9C3uk6i9F05AzNG2oS0AHg7RoTXtlOb9xKoLFM
         GjaMwaAld0bYIMyjUpT6gZ73AQYBnA/XYTfeCSUC8Xt6GpdeNYVjsIi6OgE8VSGrr1bb
         XhcUL+rVhgbnnjkYaXxAWsm4I7ClY579ucqy+Y14HG37x5syXCa/bBV8fCU/SsdxuVNV
         IFxw==
X-Forwarded-Encrypted: i=1; AKwUvBwESAps9FTEFMnnDKBxpsWGieqCSqj6Nt3rtN8HrviP9w3EdeDNC/FhtD4cQJoYkoZ1hlLg8do=@vger.kernel.org
X-Gm-Message-State: AFuF++mrTalnZRfQJLR90REuJf5TsuBf/tDCvkfTfqefNAKmyYtIgO86
	U3sNhar+S3FhhumM6B0pPodP5GM6pvJxympcJHwrIC25sb6NCeIWr/CeqwB7VQBdSrz+CIzXrYU
	BdDMiBAJqDnaSjg==
X-Received: from qvcj5.prod.google.com ([2002:a05:6214:19c5:b0:910:530b:10e8])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:860e:b0:90e:996d:b6c3 with SMTP id 6a1803df08f44-9103ef27454mr213721596d6.11.1788717679131;
 Sun, 06 Sep 2026 11:01:19 -0700 (PDT)
Date: Sun,  6 Sep 2026 18:01:07 +0000
In-Reply-To: <20260906180111.1973188-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260906180111.1973188-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260906180111.1973188-5-edumazet@google.com>
Subject: [PATCH v2 net-next 4/8] vxlan: move VXLAN_F_MDB to struct vxlan_dev flags
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Ido Schimmel <idosch@nvidia.com>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

VXLAN_F_MDB is an internal runtime state flag indicating whether any
MDB entries are configured on the device, rather than a netlink
configuration attribute.

In preparation for converting vxlan->cfg to an RCU-protected pointer,
move VXLAN_F_MDB from struct vxlan_config to a dedicated 'flags' field
in struct vxlan_dev as VXLAN_DEV_F_MDB, using atomic bitops (set_bit(),
clear_bit(), test_bit()) to avoid KCSAN data races between the TX path
and RTNL operations.

This avoids having to dynamically reallocate and publish a new
vxlan_config structure via RCU whenever the first MDB entry is added
or the last one is removed, and prevents potential memory allocation
failures during MDB teardown under memory pressure.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 drivers/net/vxlan/vxlan_core.c | 2 +-
 drivers/net/vxlan/vxlan_mdb.c  | 6 +++---
 include/net/vxlan.h            | 6 +++++-
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 885f84f272bace69fc5a282659132956a87f24a8..9856ec710fa1dcff1bd926d81aa9a9b7afe61eef 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2815,7 +2815,7 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (nhid)
 		return vxlan_xmit_nhid(skb, dev, nhid, vni, saddr_family, cfg);
 
-	if (flags & VXLAN_F_MDB) {
+	if (test_bit(VXLAN_DEV_F_MDB, &vxlan->flags)) {
 		struct vxlan_mdb_entry *mdb_entry;
 
 		rcu_read_lock();
diff --git a/drivers/net/vxlan/vxlan_mdb.c b/drivers/net/vxlan/vxlan_mdb.c
index 56ca9283283307d8b1231c3b26724474e6c838d6..cf606256d0929c4dd356ec8aa343150c10edfb82 100644
--- a/drivers/net/vxlan/vxlan_mdb.c
+++ b/drivers/net/vxlan/vxlan_mdb.c
@@ -1219,7 +1219,7 @@ vxlan_mdb_entry_get(struct vxlan_dev *vxlan,
 		goto err_free_entry;
 
 	if (hlist_is_singular_node(&mdb_entry->mdb_node, &vxlan->mdb_list))
-		vxlan->cfg.flags |= VXLAN_F_MDB;
+		set_bit(VXLAN_DEV_F_MDB, &vxlan->flags);
 
 	return mdb_entry;
 
@@ -1236,7 +1236,7 @@ static void vxlan_mdb_entry_put(struct vxlan_dev *vxlan,
 		return;
 
 	if (hlist_is_singular_node(&mdb_entry->mdb_node, &vxlan->mdb_list))
-		vxlan->cfg.flags &= ~VXLAN_F_MDB;
+		clear_bit(VXLAN_DEV_F_MDB, &vxlan->flags);
 
 	rhashtable_remove_fast(&vxlan->mdb_tbl, &mdb_entry->rhnode,
 			       vxlan_mdb_rht_params);
@@ -1762,7 +1762,7 @@ void vxlan_mdb_fini(struct vxlan_dev *vxlan)
 	struct vxlan_mdb_flush_desc desc = {};
 
 	vxlan_mdb_flush(vxlan, &desc);
-	WARN_ON_ONCE(vxlan->cfg.flags & VXLAN_F_MDB);
+	WARN_ON_ONCE(test_bit(VXLAN_DEV_F_MDB, &vxlan->flags));
 	rhashtable_free_and_destroy(&vxlan->mdb_tbl, vxlan_mdb_check_empty,
 				    NULL);
 }
diff --git a/include/net/vxlan.h b/include/net/vxlan.h
index 7b82075055237058d231d636698f640c75c521af..d323f91af2364822e148310297c978fec7664010 100644
--- a/include/net/vxlan.h
+++ b/include/net/vxlan.h
@@ -300,6 +300,7 @@ struct vxlan_dev {
 	spinlock_t	  hash_lock;
 	unsigned int	  addrcnt;
 	struct gro_cells  gro_cells;
+	unsigned long	  flags;
 
 	struct vxlan_config	cfg;
 
@@ -313,6 +314,10 @@ struct vxlan_dev {
 	unsigned int mdb_seq;
 };
 
+enum vxlan_dev_flags {
+	VXLAN_DEV_F_MDB,
+};
+
 #define VXLAN_F_LEARN			0x01
 #define VXLAN_F_PROXY			0x02
 #define VXLAN_F_RSC			0x04
@@ -331,7 +336,6 @@ struct vxlan_dev {
 #define VXLAN_F_IPV6_LINKLOCAL		0x8000
 #define VXLAN_F_TTL_INHERIT		0x10000
 #define VXLAN_F_VNIFILTER               0x20000
-#define VXLAN_F_MDB			0x40000
 #define VXLAN_F_LOCALBYPASS		0x80000
 #define VXLAN_F_MC_ROUTE		0x100000
 
-- 
2.55.0.979.g7e5102b832-goog

