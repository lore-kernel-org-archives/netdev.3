Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293773C3F67
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 06:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789107728; cv=none; b=Z6PuDSWkGTMPDwIKwp7MQ/HZ2i6DRzNEUT8PFlnHzXxcIBZV9dszRYKNJDSoKlvuknCT2s/9MmIUamIuQXnzn8cb91kt9rjC0Atql8HCQkLy9pQ+wt/9GzAoEj6ziad4hvBT7zofUgja6gL3LNs38LcAB0XhNQoAyaYGs3E/HIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789107728; c=relaxed/simple;
	bh=qiQ4yhveQ5igV11CpOo/NU6s0n4Lwgcvzs5IAOSx7g0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GjKV7GAZgcckCAkZWNR3BW2HFF64kMDyfTnSZhOSzagig5UE4yHIOjVlhvWDyt8v2Aild3BjKvmf4UDkHHv5Txm5qKtLmBG8jpsEm3k++K36C0aUERnsVH9symiR8i+bctE+rTFsil5cMbS26ommmuRX84H5XePYwD4THDrAKUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hd75D2uo; arc=none smtp.client-ip=209.85.222.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hd75D2uo"
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-939665a1ae6so123142185a.0
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 23:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789107726; x=1789712526; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D+H8WYInBTx4hd8xeDz/LKrKZUDvnivKGo2zcioBJMo=;
        b=hd75D2uoF8FhZNKoqamVpGO6UMYZfHfbgInMk1YmNxgeYQ5VrD6cyH3Lyronyq3g6s
         cJcUqmNYQIqKdiRivc4neEp2UZAxO1ArkQ7sMrWgvS1oL48nQ9hjlIgc9N+XxAj7vauh
         CsCAzvr7nzAHuI+RD19rmDNsbJAB8bWYUozGkzj8b5NxMGvm79Dm8adJAhZONZbKvjtI
         MI+tpmCsO4G9CV++r6g7+AJo+qRbgPF/52Xy+JHaGg7WpS/5dqKp6xv6RLPPVAlr2yZ2
         VfLW8Pyk5pIx98E7tZKVjb0TZEanxHZFpHE23My/ZOS38FM06P5Bbl7LQkFKFCeRS1AJ
         11Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789107726; x=1789712526;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D+H8WYInBTx4hd8xeDz/LKrKZUDvnivKGo2zcioBJMo=;
        b=QqO119PScezQK19UEhW9yHD+zadu2MGWM0qqD51b+wWplN1D7lttVe3byLL4PSFuAa
         PoRA7J+9gsdvfephZZKLrs93DDZLWY5Qli78X5Rs0/wUkD96VhtfuJNMLEjcoFGewcOz
         qg8eqdttQ5saWwcbsz5v7usnyO/yRvlIIu4ScTlm/S30VK//1h/7Ts5Cdl0mfxY/SAdT
         PgP4tx23XC1A5uGup7MvG++OQiMptITIQeZ80xtGU7vyFZWh0dypLoa717ujTZzm6f8I
         BES19FxJCLlfOeFZaU0J51CQSAdLgutmv+m5GmTULvQnpw88vZcyXQ+sz9KpD/Zh+meh
         KiuQ==
X-Forwarded-Encrypted: i=1; AKwUvBz198ygi0+Vg4bre1pTt87CJXUiyjEgVXYrp2SNd1yGErojRBalmvO8ZkjxwYiW6UDJNpdmUlo=@vger.kernel.org
X-Gm-Message-State: AFuF++lIOzQEeHd2go9jwQ27DdbYC4TNo7dCFUWpCypLCeCNnlTHmv/8
	pPF8WTSwxFpovVRnZZDpnsPSueHR9Cvg55BWJULJ3LO43Ty8fKwB32TnrTNHEvrTrrotBnHPDiX
	3760a4TRj5TLiRg==
X-Received: from qvbfb5.prod.google.com ([2002:ad4:4f05:0:b0:910:4d30:252e])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:461e:b0:938:61d7:badc with SMTP id af79cd13be357-939ea18b65cmr336034385a.36.1789107725521;
 Thu, 10 Sep 2026 23:22:05 -0700 (PDT)
Date: Fri, 11 Sep 2026 06:21:57 +0000
In-Reply-To: <20260911062200.231316-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260911062200.231316-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
Message-ID: <20260911062200.231316-4-edumazet@google.com>
Subject: [PATCH v3 net-next 3/6] vxlan: move VXLAN_F_MDB to struct vxlan_dev flags
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
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 drivers/net/vxlan/vxlan_core.c | 2 +-
 drivers/net/vxlan/vxlan_mdb.c  | 6 +++---
 include/net/vxlan.h            | 6 +++++-
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 3115b056a68ddae35720bf6e25558b77f51beba0..4bb6e05379ca7835f355017c6cccd221c89c1f2c 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2824,7 +2824,7 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (nhid)
 		return vxlan_xmit_nhid(skb, dev, nhid, vni, cfg);
 
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
2.55.0.1007.g17ff1f9808-goog

