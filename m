Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B96C480954
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 18:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790100676; cv=none; b=Cx+ytKMb/XQ5UKpPmX7B05HgC7FXBePf0P6frdb0mpD85//B5u+C8P/Ecy/zdbd2pOygZjYckfXwpfinf3iA85Utf/emvTNmT1P9CPf9CSF7RdjqGFlDq+1guArhv1ff4LUdDtdVpPjCOLgkfqnJ+3H/Hpc8jZzngm2VAXgnAB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790100676; c=relaxed/simple;
	bh=taHyx99W+CebNGCgbHp72SdgXg8Ya4Z7TjWOFbV49lA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sUxlE7tlQgSUBsIfTe6ew8KwHjjxrpiThVVSwde1cvYLCORuk7UAonFvydq7fcgPqiW4/YbMtixAQlzlrx1j8IFQNjPivfKktVFI+A1HPzzXd19UbwwK1T5cHc421lwiWOIxGc+zF+g5gmDogawluPaCwcEvZ9C+9tyXB5ywZ/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lzoHXuQb; arc=none smtp.client-ip=209.85.222.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lzoHXuQb"
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-97caca2faacso45681241.2
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 11:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790100672; x=1790705472; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PF55N9WzF9D8y4wGY7F0ZT4H2edAOhYVPWCWIYigTg4=;
        b=lzoHXuQb0Eq8ndSzzxR2OUV9taO2a+7yWXWAUOUL9BNaPcHOGPFmCSu84TlR5uNIBS
         SHUwmyg/bQZ652brBySvCHt1XeMkwL4ZqHX8vpCxN1Copssdo9XdNkpYYIGj0BA/FRPa
         kzoExi9nngHDHOlrfE953ekBrspdk/qDlkpLFsiQ7efRLqokZwSwTXGiEBBn0Mr90HBI
         /5hjXRFS+aWwk5qRZOedSo+s4jQGidbWm4aY2pEk6zGRBIVlOkJqwhkjLOHOEA8M7S6C
         k0sR953u//pQUw81QTDGqeohQVqJnUPp1t9V/0NPrgAWpIW7IjCM5R29y/gwXfuJloh/
         fJIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790100672; x=1790705472;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PF55N9WzF9D8y4wGY7F0ZT4H2edAOhYVPWCWIYigTg4=;
        b=NgZhOTmx679lmtfNp59Ot7CHM4VMhhDSqWU7G2P6AjhhOqHcO4oliYIP2HfxK35i2S
         la/O44uIltQPkv5F4Upe6txPhEIN64DNz2z3bgP7PlLQxETHVxRwOh6hi0QbL8/EP31u
         AJEg5K3F4iHK5yAQfw+RSBN1HXFyEVKEZ08xiwCLIAQ+Tw3jcAs3PYZJfg+YRTzdWWey
         PUYeI+avyRNc+NOzJuGQ67FY7p5Lj6LsfnoCcSLsHRsukpllsXIOlyVteEyhyVnsZbYy
         6M3fCk2bFzdwaPTCxgoPe/GQm57rcq8lJCWx2/6MJev2LUB/nxQZS+iNti1rqwEnNJRh
         ecQA==
X-Forwarded-Encrypted: i=1; AKwUvBwf+5lw6PR4o48VB3phz0HJt1kUHsnO34Hye+9bEg55hr/1vIKclLUKhTyA9RXH0NDSvtWtC50=@vger.kernel.org
X-Gm-Message-State: AFuF++nlpKUFxi5q2UwQSLgA+jOgpB0cY8l36OlELIoQkgIeYXI1YgOz
	JUuutKty4wabjtmlLycuneLcjtvLWID1IiJgQaEw3diDF4SfUvXdMfJ5YDa6E1fHUCkylZLPuVk
	R+ZthEjTwGFVqVQ==
X-Received: from qkjb10.prod.google.com ([2002:a05:620a:cca:b0:939:f0eb:e1c5])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6122:32d0:b0:5c9:a60b:e5bf with SMTP id 71dfb90a1353d-5c9f165e93bmr538071e0c.15.1790100671875;
 Tue, 22 Sep 2026 11:11:11 -0700 (PDT)
Date: Tue, 22 Sep 2026 18:10:59 +0000
In-Reply-To: <20260922181102.3989489-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260922181102.3989489-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260922181102.3989489-6-edumazet@google.com>
Subject: [PATCH v6 net-next 5/8] vxlan: move VXLAN_F_MDB to struct vxlan_dev flags
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
index 948addb7f63d5ad757f0f7c2cbf0f75ed7303331..c87ec83c533b7c8ebe2da09654a984e2b07b8f29 100644
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

