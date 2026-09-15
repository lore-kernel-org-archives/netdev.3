Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6F64BE439
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 17:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789494916; cv=none; b=lwG/RMvxHSMzGJe6NPGvlyhErHU7TUvZcuPFI+h+UyhvozxAiSrjlnCBFOb/VKzo98ZICTCl8wTjBGinyj6HteMM/OKVJDKfJa+MvhWZFITHVmpZgqTrzyP0Wbvn8f7QC62vHWx21PLGLbONMPkIMaTj94G1U4b5PcIbH2hXHqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789494916; c=relaxed/simple;
	bh=xSwfs2cA11sTJRYITfe9OL14pAtIEYjh+ITy4G4Dzdo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qEwW6k+X9KQVOHX2YtKKFcayc0mAzRd4t/gyxaWp2BTMDqqUh6bvSNbnNwAnE4I83hwh2ndCFIx3zeYQciwyXHePCRnJwlcKVoK/GquUl6HFhuyA9X3Q8iZaEt225RtS9xEfTu7V503a6z/PmZTcnHOwkPjGBDGtrTFF6SMDP3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L7KNT4wX; arc=none smtp.client-ip=209.85.160.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L7KNT4wX"
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-530e12b296bso81327011cf.3
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 10:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789494910; x=1790099710; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IKpdp9pjFGIsFSK5Jhsp5fzAVqRaHpY4KNDM6mvK9FY=;
        b=L7KNT4wXT4wvXpkA2HBeL4gNj5U3lOtktQJmJdvsptUW98HzhMBGORz2GzYWREd8qb
         9APR8HZdix3LZPP3YyNmpv9rUMO54nLkUG+6tHy/Df5n3P6MKT/d9PjlpaIxbQm7f3ko
         10cTCTaG4gFyEE/mxoJsGWn6+FPbD4ufCkWl25JhLUFrv8o4dAV2EGXOkYpjOPGoDBob
         zFnCDLOHL4VS80X3dVqPoNF4uUWLASrx5gTK25UzDOt7IseHNzWs+s2OZgLdnRgsyWC6
         eMSlmo+8JQmjr4uAhzJbg0QU2eEKXDw+Teaa3J97LF8ZTesUD7wr7VkNsTgoyjrlqZBg
         YoyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789494910; x=1790099710;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IKpdp9pjFGIsFSK5Jhsp5fzAVqRaHpY4KNDM6mvK9FY=;
        b=UDrVCZZmPnyzpWSwlM/aWnIfo4x6Byc0EVue0RL6ovGd3PHPMJVQIvP2dn6bwl6glQ
         CItjhlc1OGz79Hi0z6QUqLRzGOIDq93A9Qar0vSTWl0YmrMUEOGmgrubXSwxybBeeQIt
         rsXKV/ZZZ7c8E2kctVEMrj/LQ2Wf7RpMcY9P2MXh9Lnx9lMhHTjTaZBsmpASsdB/XSU8
         20BBSzP/fd5++IiImQEpkPkvuQZ9QvAu6ZsZsQ9y/o7f6J2W4IfI8+gNYm3D2Lz/jSG0
         2pnWkCAmSfKxBJ9+RtXwH8zKvAriVTg5tLhHCwnFpIAYV1t75pDvAZJm0anNavsIjQRj
         f9NQ==
X-Forwarded-Encrypted: i=1; AKwUvBwbmrlJaUDeiSFNKW5sw8g79BRlQVzu/pU/K+Wk9+9z/plriZ6j2i4o8NsIruA7+drATkAHRjo=@vger.kernel.org
X-Gm-Message-State: AFuF++m4J8uPXAp2nIen44TNdxsJ4T5egOyojvad2295/D3yXNGV50Ta
	Z18bqxu321mxET3KQfEiNi9VTuRZ8rlSQEmnHwGbOm6LZpuhXiktLrjUo5xG0vviqNKXQXz0bTk
	lnRlBf2XTYMe7Dg==
X-Received: from qtbf7-n2.prod.google.com ([2002:a05:622a:e187:20b0:51c:a03a:a57b])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:2285:b0:530:ea70:39f8 with SMTP id d75a77b69052e-5312636ac05mr31766951cf.40.1789494910005;
 Tue, 15 Sep 2026 10:55:10 -0700 (PDT)
Date: Tue, 15 Sep 2026 17:54:58 +0000
In-Reply-To: <20260915175501.391567-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260915175501.391567-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260915175501.391567-6-edumazet@google.com>
Subject: [PATCH v4 net-next 5/8] vxlan: move VXLAN_F_MDB to struct vxlan_dev flags
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>
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
index a0c2a480701188506ca2f7f00d1890edf8662ced..411768cd97d3d4f5c71d7c6ff1933aecbfa46d80 100644
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
2.55.0.1032.g73a4cd73de-goog

