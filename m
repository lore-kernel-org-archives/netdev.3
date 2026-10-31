Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793487490;
	b=UaBOsl9yj4VNx8DXtFfy8IMFvriBPhlo8FNn5mr40s/+VDX7n6x6qd1Y9w8v4yDEy78f
	 B+Rx0nlkdUAXQl735RrHITySYI6GwkqjeTHkiU6TJKN9dr6X2dNELagWrcVLgyReQJyMg
	 4Qkp7RrVhlu3sUiCdiQQe+OyrDEf03XlpzZzgJwvuQWX6Vsi6aD3pCL7rDEpe549lw8nL
	 WIhMJx04hybT+pay5zE1eIJh0wxp1q2fZCDi15HnrO+ykc3DrrlU5u41vcA7Q/4KQvwEK
	 d/mbe7hnyx9MrSPBUaXyNX2xehCgZZyV3VdHaFJA4CfzlRYfTEt0vdvFZbZ8+YVX82Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793487490;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yua6VmYG+rPT0EJdFP1ydV4LtFe2Ecs40LvHqDhT5L4=;
	b=ETrLvorAbtRG62EEJLnu6QJ+LITE757j/PZZiBOM20GlmkAr0mTB9mTblAzKKObjxnNW
	 Ntan0kVaASsCJxyZ43k6wCagbARA0K8Nuw7FRyXHGRX7UHALAXxYFuiWSw4H46GGCm7jt
	 BglVbWQm235o/DqA1lMbSFEtmbWdAIU6r/9TKobCi/9fXX5NmWt8EHW0GdIM2zwhnR2fI
	 dK9okGG9ZS7frAbg8d+wpwfe8kY9zGUDFRj6dAwLNqAvc617LGfBtRF1WLZyR1FRn2522
	 cD3dLH+r7HB+hv9XnNy3qYvBbu9iaRpvN1hqLC4pAGBo69YxqId6K5xmTHHe2OGWxJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ah0RW83o;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05298606A31D
	for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 22:58:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05298606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ah0RW83o
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a214af2076so13638975e9.0
        for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 15:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793487488; x=1794092288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yua6VmYG+rPT0EJdFP1ydV4LtFe2Ecs40LvHqDhT5L4=;
        b=Ah0RW83o0vWcaYoOAYnX0fCqd2bAS3joFH5VcC0MFdkv1gNZTCOkcdPggdJr59OYhR
         /+jjLbJmh0D7nJQ8bpw59wnGHdMCn1cIYVkz3mSrrAJwhOQo2m/7deY6X+z9YE4GenRh
         KRadVFQsKdgUhl8lqm3DoxTjjnSDPJYesWPSkTpgWpqXE9hWa84/dNvitSjMsb+bKPzZ
         y7ZImqjXw+nxAIGCEdLZczfVCsoV6OJqLH0+FLNr2zJ7pnxeI5GlufdYtAryO+UuHGWf
         Rxf5T9NfR00DvzV+wcObSia3cWdWMksVe8+BeSqzLMDpKPub+kI6eq+sgnqR8y9+sZOl
         k1gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793487488; x=1794092288;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yua6VmYG+rPT0EJdFP1ydV4LtFe2Ecs40LvHqDhT5L4=;
        b=tv1/1oxGPUNvx7SwwDz4UVSg8rkVhoo+sv1MoCMPhk3LRT/cN6UhtJJIJHkQ+JeuIP
         sxtNicdT20P9Qz7mkmNhrRZTZ1qtjAlGva3UsumWpvd3OmBHpZCWHLsmwgKzhrVzKpb6
         lKi4KD6Hhvzmdes42Sq/o4i4jgQXIcmpxVu9i25uwGUBwWhyqvPZdf/ubyGK/mTLifko
         czQpGUb9dUFGkud6LYm6B2mtAB33/iOqC+WjRBFAZt1ZTAfaDXx+tdb/BOqFYwDJJ/IP
         TADuZcBHmUjyUGTPAPfv/IJJ1XUxkiC0Nt3sizSp6eeLxgIztTRTmUz0+nYIPZb+J0gZ
         /mhw==
X-Forwarded-Encrypted: i=1; AKwUvBxcknFhe8nfs9pyuZYoEZC230TOc+LAeFoauWMeEscC8Ek4kePQohN5SkcK8HXCP8EcL8NG7kA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIeNIRt+ZkJDMX4OYPaY5IcOMvJlLorMhksVuQltmJ7kxzt+Y+r
	spaGFrbgqCeGUVf1CY9G9E9aDm1zNlsrCCLn4CXGaM8ASn7Uk9RQ/BZ1
X-Gm-Gg: AYBFou3/Mt96fo8jrZ8QoU/16N3GwkvS9KFm6FL1UyXN+QaTyRu4Jp+YNMvHJQzC5WG
	iMASN2G1JVyNSD9cJIZM7VMkxk71k+WXOnUv/t4sQr5V13r9PX+syZfVd4NW9HfXfBGY8uydDzQ
	6PwXuThaFb79bnjnAbFwIPB0iC2UbhRwSmD1U70HUu+cJ4E+GVbcmotVump+HRqDYKeeguNkdBt
	TAMkbaVkapk0CIXTpBL0JKhtxJgqBflw0MYhF2/xKjt6NadCZ2G4ZR/OmqrcBGwTFcyxEqUZcf1
	/+jfxnx48cqB/6lo9ypWyl4T48j3dBNnVow+HK7KcftAxgyE8P7Okc+MiAWu+jxRfi7O8/8VwvD
	SCLZQ69w7ww+dX5pI8ZfqVbczad0W91ZBTmJUbK1fssIYheLo89zUhyt1G82+LD/KNexRLxokFQ
	aDzUpvXcQrfABmFmHSyHCc+94/JC+oiSDHsHDdQqlrDMzIA3PRnx5JL+csl9oGvwZ7zcLj7nT9F
	2Ll7Yu5+2PIsYFDBVnI05e3SkL2FcMdzVcYq9r0tzv4R6WbmGYBJsRzJJ6NFfFLOCQzCmotzbpI
	3lK3HkbCs/Agq21e4OAtpXX7KUkG2jF5zXxFw6UwInWpC6LPRYzehMnuOWdl7BuZmPPQvQOtIkJ
	lq/w82BOoEol2c4IUE/0D/xmUQ90DK43t+lmIuZbP0ZgyjHSCCHyeikzSPog0Jm0YMCm2dY/vIv
	ELGe7e/9Kh
X-Received: by 2002:a05:600c:6087:b0:49f:f099:6fb1 with SMTP id 5b1f17b1804b1-4ac17753befmr138514985e9.15.1793487488222;
        Sat, 31 Oct 2026 15:58:08 -0700 (PDT)
Received: from SD.cable.virginm.net (cpc117822-heme13-2-0-cust760.9-1.cable.virginm.net. [81.111.210.249])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ab69b54742sm329882745e9.15.2026.10.31.15.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 15:58:05 -0700 (PDT)
From: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: dtatulea@nvidia.com,
	Prathamesh Deshpande <prathameshdeshpande7@gmail.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Erez Shitrit <erezsh@mellanox.com>,
	Alex Vesker <valex@mellanox.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] net/mlx5e: IPOIB, Fix QPN lookup race
Date: Sat, 31 Oct 2026 22:57:13 +0000
Message-ID: <20261031225749.14214-1-prathameshdeshpande7@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The parent RX completion path can load a QPN hash entry before
mlx5i_pkey_del_qpn() unlinks and frees it, then dereference freed memory.

Use RCU hlist operations and defer freeing with kfree_rcu(). The existing
RCU read-side section in mlx5e_napi_poll() covers the lookup. Keep ht_lock
for writers and acquire it before looking up the entry to delete.

Fixes: 7e7f4780c340 ("net/mlx5e: IPoIB, Use hash-table to map between QPN to child netdev")
Signed-off-by: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
---

Changes in v2:
- Replace the RX spinlock with RCU traversal and deferred freeing.
- Narrow the description to the parent CQE lookup race.

v1: https://lore.kernel.org/all/20261030002241.8508-1-prathameshdeshpande7@gmail.com/
Review: https://lore.kernel.org/all/ade46454-e575-43e4-85aa-eeb5ad79408a@nvidia.com/

 .../ethernet/mellanox/mlx5/core/ipoib/ipoib.h |  2 +-
 .../mellanox/mlx5/core/ipoib/ipoib_vlan.c     | 26 +++++++++++--------
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.h b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.h
index d67d5a72bb41..8c0039c5425e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.h
@@ -82,7 +82,7 @@ void mlx5i_pkey_qpn_ht_cleanup(struct net_device *netdev);
 int mlx5i_pkey_add_qpn(struct net_device *netdev, u32 qpn);
 int mlx5i_pkey_del_qpn(struct net_device *netdev, u32 qpn);
 
-/* Get the net-device corresponding to the given underlay QPN */
+/* Get the net-device for a QPN. Caller must hold rcu_read_lock(). */
 struct net_device *mlx5i_pkey_get_netdev(struct net_device *netdev, u32 qpn);
 
 /* Shared ndo functions */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib_vlan.c b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib_vlan.c
index 4120afd097c3..5edc39247525 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib_vlan.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib_vlan.c
@@ -31,6 +31,7 @@
  */
 
 #include <linux/hash.h>
+#include <linux/rculist.h>
 #include "ipoib.h"
 
 #define MLX5I_MAX_LOG_PKEY_SUP 7
@@ -39,11 +40,12 @@ struct qpn_to_netdev {
 	struct net_device *netdev;
 	struct hlist_node hlist;
 	u32 underlay_qpn;
+	struct rcu_head rcu;
 };
 
 struct mlx5i_pkey_qpn_ht {
 	struct hlist_head buckets[1 << MLX5I_MAX_LOG_PKEY_SUP];
-	spinlock_t ht_lock; /* Synchronise with NAPI */
+	spinlock_t ht_lock; /* Serialize hash table updates */
 };
 
 int mlx5i_pkey_qpn_ht_init(struct net_device *netdev)
@@ -68,13 +70,14 @@ void mlx5i_pkey_qpn_ht_cleanup(struct net_device *netdev)
 	kfree(ipriv->qpn_htbl);
 }
 
-static struct qpn_to_netdev *mlx5i_find_qpn_to_netdev_node(struct hlist_head *buckets,
-							   u32 qpn)
+static struct qpn_to_netdev *
+mlx5i_find_qpn_to_netdev_node(struct mlx5i_pkey_qpn_ht *ht, u32 qpn)
 {
-	struct hlist_head *h = &buckets[hash_32(qpn, MLX5I_MAX_LOG_PKEY_SUP)];
+	struct hlist_head *h = &ht->buckets[hash_32(qpn, MLX5I_MAX_LOG_PKEY_SUP)];
 	struct qpn_to_netdev *node;
 
-	hlist_for_each_entry(node, h, hlist) {
+	hlist_for_each_entry_rcu(node, h, hlist,
+				 lockdep_is_held(&ht->ht_lock)) {
 		if (node->underlay_qpn == qpn)
 			return node;
 	}
@@ -96,7 +99,7 @@ int mlx5i_pkey_add_qpn(struct net_device *netdev, u32 qpn)
 	new_node->netdev = netdev;
 	new_node->underlay_qpn = qpn;
 	spin_lock_bh(&ht->ht_lock);
-	hlist_add_head(&new_node->hlist, &ht->buckets[key]);
+	hlist_add_head_rcu(&new_node->hlist, &ht->buckets[key]);
 	spin_unlock_bh(&ht->ht_lock);
 
 	return 0;
@@ -109,16 +112,17 @@ int mlx5i_pkey_del_qpn(struct net_device *netdev, u32 qpn)
 	struct mlx5i_pkey_qpn_ht *ht = ipriv->qpn_htbl;
 	struct qpn_to_netdev *node;
 
-	node = mlx5i_find_qpn_to_netdev_node(ht->buckets, qpn);
+	spin_lock_bh(&ht->ht_lock);
+	node = mlx5i_find_qpn_to_netdev_node(ht, qpn);
 	if (!node) {
+		spin_unlock_bh(&ht->ht_lock);
 		mlx5_core_warn(epriv->mdev, "QPN to netdev delete from HT failed\n");
 		return -EINVAL;
 	}
 
-	spin_lock_bh(&ht->ht_lock);
-	hlist_del_init(&node->hlist);
+	hlist_del_rcu(&node->hlist);
 	spin_unlock_bh(&ht->ht_lock);
-	kfree(node);
+	kfree_rcu(node, rcu);
 
 	return 0;
 }
@@ -128,7 +132,7 @@ struct net_device *mlx5i_pkey_get_netdev(struct net_device *netdev, u32 qpn)
 	struct mlx5i_priv *ipriv = netdev_priv(netdev);
 	struct qpn_to_netdev *node;
 
-	node = mlx5i_find_qpn_to_netdev_node(ipriv->qpn_htbl->buckets, qpn);
+	node = mlx5i_find_qpn_to_netdev_node(ipriv->qpn_htbl, qpn);
 	if (!node)
 		return NULL;
 
-- 
2.43.0

