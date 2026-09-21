Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43653E1208
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 10:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789984912; cv=none; b=Gq6flzpbhmZMZBsvSTvjvijnKsMJrOuZk+hmeGAbpHHjI8rNNFtpRixhCas5FBmMoh+bZbocNw5PgDaiA4JOkx9/xnNz47EzIIcaWEy/BuZ/H8+2eqj27IIkb0/ogjPH7rfMPYm+xNZl2qOJt6HAR/bUMUlMBNQ4sgr33k9NlfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789984912; c=relaxed/simple;
	bh=OTVmFQBdasnkYNXZb9yzRc/tPXPXTZ+U/NHSOBvk8dU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BAoUNVbY7WX7B3RkzHssdQVm9QuPy6BRRsi4OnnL3VEQ5wtptnFMgIzQYsQQaES+7mEoMdO7G/4GhZWo9zYUWQP8v6Iw1Y3xnNRdMGn/jaDoxni3UEa34kZdA+11MbfcuLnZKsumppjoQ4QCejFOVKVLzWWfZ1EtSAjs72pTOJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hKoypoqn; arc=none smtp.client-ip=209.85.160.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hKoypoqn"
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-530e12b296bso67432011cf.3
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 03:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789984909; x=1790589709; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lhfCKfPuwOw1GTWQmaNeBMGbiiBL3fe6h5+APo/dsts=;
        b=hKoypoqnOKbPrAbLoNbbuueluFQWKaW80nETAWbkrAhPZJBMgWxZMnWfFsJj3USN4C
         RdtfQctBoKHgng4iB5NCcXZn0XsPzYltyJM6oXacOcnFvSozJBvebesMUiRsda/XlH9l
         r6wxETi+Ek/E0saVmV3m7rWG6nYRUxskzYNRUG7wJBo0B9fTNujifBzp+vU1n0I0QPGP
         mbBXPaVJRyFXLWxWGcTA0aQrCHFZqXN1X5FVQY/VzTkVZs/LCyNowMfv+l5Fp32CnoAs
         ATw4iNoblrwEScMKlVnnDSKIQPLQ3v6mxd7TAYCHBPRE+/iFWN/sItcy7C1Tr22gV6iK
         tQXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789984909; x=1790589709;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lhfCKfPuwOw1GTWQmaNeBMGbiiBL3fe6h5+APo/dsts=;
        b=pCcjqCE4n7zNP544p/CUCgw/iFB0OXzh7YOgV8cCxiK9CSUidZskZDkafGb/U1z4UK
         p1fvx0oSm0UkwSgy/IuAeN4X73gwGxGqw2t4mTjwvp4Zyv6dLo6jZQrhpNqrw0z7HNRx
         Qao2t3zzae4zrLLWWO/Lmmz/SkYypmDmKRUA+YM5YALewWyTFvjioY89854fMDBKPkfd
         4l+TKWFgagb/d25G9i/IqX+Cq/LRZ0/gkxoMO2mv77zP1H5d5L/5voE93iP/lqLx5951
         BCs0RytW2EoV39EivR3Pla2oINN1f2l/gH2tOE95ex5rjemRhKrHhpxL8YIyyOk5Fq12
         gXrw==
X-Forwarded-Encrypted: i=1; AKwUvBzclipF4L/uJFIbdUlUaBoDn59cFX9LzlILe0DGa2gU2JHM6Thk4VJ87GugpRhlUhqeiGbpYAg=@vger.kernel.org
X-Gm-Message-State: AFuF++la6skMWv/bMyufTq5OAuOvPXjsgkK0D7sl07npKC2SNxxMiUfH
	aM7X6t7p0AuEnwqRtr4vXguovFJjYkY7zh9j0BGqbGf3r5+pgQPp/x3KeFSKu9J74yhO5RrLLAo
	vFjFDNItCqE4YRg==
X-Received: from qtkp8.prod.google.com ([2002:a05:622a:13c8:b0:531:320:7db7])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:138f:b0:530:2cc6:c8ad with SMTP id d75a77b69052e-532b71fb909mr100992191cf.19.1789984909177;
 Mon, 21 Sep 2026 03:01:49 -0700 (PDT)
Date: Mon, 21 Sep 2026 10:01:36 +0000
In-Reply-To: <20260921100139.508191-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260921100139.508191-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260921100139.508191-6-edumazet@google.com>
Subject: [PATCH v5 net-next 5/8] vxlan: move VXLAN_F_MDB to struct vxlan_dev flags
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
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

mlxsw validates cfg->flags against a deny-by-default mask, so
VXLAN_F_MDB used to make mlxsw_sp_nve_vxlan_can_offload() reject a
device with MDB entries as carrying an unsupported flag. Add an
explicit VXLAN_DEV_F_MDB test there to keep that rejection, with a
message naming the actual reason.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c | 5 +++++
 drivers/net/vxlan/vxlan_core.c                           | 2 +-
 drivers/net/vxlan/vxlan_mdb.c                            | 6 +++---
 include/net/vxlan.h                                      | 6 +++++-
 4 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c
index 52c2fe3644d4b9b27f1d589d9f7f597748339782..b78aff31c98f2d8aedfdf36bbfc1cb61e1066edf 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c
@@ -92,6 +92,11 @@ static bool mlxsw_sp_nve_vxlan_can_offload(const struct mlxsw_sp_nve *nve,
 		return false;
 	}
 
+	if (test_bit(VXLAN_DEV_F_MDB, &vxlan->flags)) {
+		NL_SET_ERR_MSG_MOD(extack, "VxLAN: MDB entries are not supported");
+		return false;
+	}
+
 	switch (cfg->saddr.sa.sa_family) {
 	case AF_INET:
 		if (!mlxsw_sp_nve_vxlan_ipv4_flags_check(cfg, extack))
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index e834b58ea745ce8394ff2ae6cef05eec3a9f8d26..f98f1d802724df40d4f68ba7282dc377752b1160 100644
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
2.55.0.1082.g2b9226bbc0-goog

