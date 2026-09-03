Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136D74A0F0D
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 12:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788437332; cv=none; b=ilTxRd06RF+HKAMdc/8v2YhoCyoQKyRkNwxaObC0TKNhkAiL4uYBuIrtf+ZQHsiQg6jMr95VyrcH9r/Nq5jMp06U/KY2kkeFLRtREP5GW7EXZ+fUntsQqdS08gMBIcC94AHIj6a4YVNNRKvEaNHa+Qya2+1EaETIkfUk4KbeTH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788437332; c=relaxed/simple;
	bh=Kq+rXN703MWwEaXfOwgAe/OthNXda8WaENkQNviEWpo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sds3r4ivcHIj5EiWE1VzwRfgv4MKXVWiddutxuHRHEEhqynHFt+9zhGhsmuyVhTxVxu9Hf0vNA7PFYkApEzn42EWgcAgbWg0uFkg2IEIY/v1Es2IQ6CBwlj2Etj8IrL0fRyH8rK+bk0PpB6K0YMBWZys1u0ob1vhKbvZvbmnUss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kzt6+VbD; arc=none smtp.client-ip=209.85.222.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kzt6+VbD"
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e5fc4c7e9so176177485a.3
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 05:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788437330; x=1789042130; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tRzYydNSRvEBtiq6xSLxzRwMciUzLsoVPzZOHtPakGA=;
        b=Kzt6+VbDUpd+HGAehKUYKX4SMhhOUqQmpImDg3R+e833zan1e3NC9B6mBulxC5LV6U
         q1U8YWpe5pMcFgu3ZfDrhCblgcXIocyzdrLO0D4gFZVHCwmHSSLm/kG3jQ8hIa7hK5Wi
         TJdLQ+1efCGQEZqkTdaR2EVlLShWLdY33hpC3GfMdcCWaPf+eswWD0wigx696DQ7VEuL
         X9QFLFsKCUkSSGPnh5OLNYmkkX4IQ1ViE7z2n2T8JaZ43rH/6JIkBZynaxpXel7CTsSO
         PllY5dv5zyl8k3U/Vdj2A2bct5GNUY8wmb3zyui5IjxEfj8eJxAxyjUlowd8/iXrMxGt
         vqww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788437330; x=1789042130;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tRzYydNSRvEBtiq6xSLxzRwMciUzLsoVPzZOHtPakGA=;
        b=Qv35YJKIWDzMxDIBrBCE+0VmwWJfmHqyPxtibzkUFz7FWku49plad1U5o3tidcAyjl
         gnWrFsdSMn/o6rYrKI3fH/kPstab8yRUxd7eSFrAL7HwJSfyR9uZ3EVyGztf2KP0nBX7
         I9AM9zKHaZc6w+gX5MPavlrghTiun4y9uc5Uq7ABg+wS+T16IrpaBzUhKfFS+kFvhdnI
         J654FgnVxFQoE/pGPTBzXi1sdzN55+wGo3X0DrxMCv1IawRLgF8EAjNqrqh38t27UhBf
         o4x6k3eSoipo5O1VSUONtvd2ygTtavCVcQvkqTsGTyZUcMBLRZy+bZ473oHoJxK8fKYi
         DZUQ==
X-Forwarded-Encrypted: i=1; AKwUvBztmIIY5iFLbBmeorpuvlmELRFbm403Ku5hFTAdI1CCYWAcJzbQmp+CdifofKeNR3lZ8CbtC7s=@vger.kernel.org
X-Gm-Message-State: AFuF++nY58Phhu1fZmDb+q/WJOt6UHFcJkzj5P3yApB4xap2PgDeXt7J
	jgvNLhHbrNm5ihqHxCHtveQjbPzv3uaQiyz0H00F1qqkYWBpniFsMnCSTlu3yehXDFN/FbTBCW4
	aVjNhoqrMxc7veA==
X-Received: from qkoi22.prod.google.com ([2002:a05:620a:4056:b0:938:8ae:b4d8])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:28c1:b0:939:7fc:cec3 with SMTP id af79cd13be357-93960ff9acdmr1269870785a.41.1788437329087;
 Thu, 03 Sep 2026 05:08:49 -0700 (PDT)
Date: Thu,  3 Sep 2026 12:08:36 +0000
In-Reply-To: <20260903120840.1024153-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260903120840.1024153-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.970.g62bdec98f9-goog
Message-ID: <20260903120840.1024153-6-edumazet@google.com>
Subject: [PATCH net-next 5/9] vxlan: move VXLAN_F_MDB to struct vxlan_dev flags
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Ido Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
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
---
 drivers/net/vxlan/vxlan_core.c | 2 +-
 drivers/net/vxlan/vxlan_mdb.c  | 6 +++---
 include/net/vxlan.h            | 6 +++++-
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 2627e26f3699ff39e7e907b6f5f8f684d2d1235a..0fcc7282e69d08c4b94ce89ce99feeee576fabff 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2809,7 +2809,7 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (nhid)
 		return vxlan_xmit_nhid(skb, dev, nhid, vni, saddr_family, cfg);
 
-	if (flags & VXLAN_F_MDB) {
+	if (test_bit(VXLAN_DEV_F_MDB, &vxlan->flags)) {
 		struct vxlan_mdb_entry *mdb_entry;
 
 		rcu_read_lock();
diff --git a/drivers/net/vxlan/vxlan_mdb.c b/drivers/net/vxlan/vxlan_mdb.c
index 6e38acbc8fea9e076aa6c50db1d273aeb65788e4..fe079d6abc5fcfb8bdac4d27b95dabd30aa10526 100644
--- a/drivers/net/vxlan/vxlan_mdb.c
+++ b/drivers/net/vxlan/vxlan_mdb.c
@@ -1211,7 +1211,7 @@ vxlan_mdb_entry_get(struct vxlan_dev *vxlan,
 		goto err_free_entry;
 
 	if (hlist_is_singular_node(&mdb_entry->mdb_node, &vxlan->mdb_list))
-		vxlan->cfg.flags |= VXLAN_F_MDB;
+		set_bit(VXLAN_DEV_F_MDB, &vxlan->flags);
 
 	return mdb_entry;
 
@@ -1228,7 +1228,7 @@ static void vxlan_mdb_entry_put(struct vxlan_dev *vxlan,
 		return;
 
 	if (hlist_is_singular_node(&mdb_entry->mdb_node, &vxlan->mdb_list))
-		vxlan->cfg.flags &= ~VXLAN_F_MDB;
+		clear_bit(VXLAN_DEV_F_MDB, &vxlan->flags);
 
 	rhashtable_remove_fast(&vxlan->mdb_tbl, &mdb_entry->rhnode,
 			       vxlan_mdb_rht_params);
@@ -1754,7 +1754,7 @@ void vxlan_mdb_fini(struct vxlan_dev *vxlan)
 	struct vxlan_mdb_flush_desc desc = {};
 
 	vxlan_mdb_flush(vxlan, &desc);
-	WARN_ON_ONCE(vxlan->cfg.flags & VXLAN_F_MDB);
+	WARN_ON_ONCE(test_bit(VXLAN_DEV_F_MDB, &vxlan->flags));
 	rhashtable_free_and_destroy(&vxlan->mdb_tbl, vxlan_mdb_check_empty,
 				    NULL);
 }
diff --git a/include/net/vxlan.h b/include/net/vxlan.h
index f41db72e9229d9cc8460ddbe265c6cd07890032d..f4f519a365f524e1301d769f75690d836b9e4432 100644
--- a/include/net/vxlan.h
+++ b/include/net/vxlan.h
@@ -301,6 +301,7 @@ struct vxlan_dev {
 	spinlock_t	  hash_lock;
 	unsigned int	  addrcnt;
 	struct gro_cells  gro_cells;
+	unsigned long	  flags;
 
 	struct vxlan_config	cfg;
 
@@ -314,6 +315,10 @@ struct vxlan_dev {
 	unsigned int mdb_seq;
 };
 
+enum vxlan_dev_flags {
+	VXLAN_DEV_F_MDB,
+};
+
 #define VXLAN_F_LEARN			0x01
 #define VXLAN_F_PROXY			0x02
 #define VXLAN_F_RSC			0x04
@@ -332,7 +337,6 @@ struct vxlan_dev {
 #define VXLAN_F_IPV6_LINKLOCAL		0x8000
 #define VXLAN_F_TTL_INHERIT		0x10000
 #define VXLAN_F_VNIFILTER               0x20000
-#define VXLAN_F_MDB			0x40000
 #define VXLAN_F_LOCALBYPASS		0x80000
 #define VXLAN_F_MC_ROUTE		0x100000
 
-- 
2.55.0.970.g62bdec98f9-goog

