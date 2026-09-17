Received: from mail-vk1-f228.google.com (mail-vk1-f228.google.com [209.85.221.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10DB43F0A7
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 06:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789627603; cv=none; b=LJtUqZd+rmatfmUpb7vIxO6/o5cGITykkkKMxFZJbH/2c0q84HUyF5CKFm71+laYuGM8YOchS5+0SDcfaYlNaH3SP/ptc+ucYq5mr/+9klvlKujq3I1s0DCbAPoFhsI2cri3LmhQgahvtKwWhG1G/hCxbgq8BARAzUjBbr2Z/pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789627603; c=relaxed/simple;
	bh=FJzSCfR4ZaCg30MFvONEMoFWjabSAHjeo4uJ9KGpewI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PQfYNjc2LPk/pjwbaNSUPowqxL73JgJnKii5LgFBX6739+U+3oxZJXjbbufqm0abGTnXG4Z77fB7jCz9vWL69E0KVsoG56tL5rrDC1cGz9Ui03yfpVZ1sd0Ut6nIQhnBQGHwIo1c7hDrUmCNHAot7rBJ1JMFK2NUfoIBgJmuq8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=b7Yt6167; arc=none smtp.client-ip=209.85.221.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="b7Yt6167"
Received: by mail-vk1-f228.google.com with SMTP id 71dfb90a1353d-5c82e6a6a2aso129545e0c.3
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 23:46:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789627600; x=1790232400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K1uINDFjo2ML6R3SHyow6jDUjhiv3et72Nqn9GZ5YjY=;
        b=Bl93zPWND7MJT0IzVXFM9orNx8sMPUuoeCS5bwmtqEEm5DQjA9cJObKilus/BxlJiX
         pumgRnUfGV2NCtjKGYR1U+FS6DRVGzYfW9mOi4p+wGUVZfmyVERqim0iHk+pI4iLxpht
         wjin1k/+zgn4QVc/zJDkuQBrfwFeGd319LfUYpxxYd1m6EWTU6aBzJnZWb35pOlJsqXh
         5xMdPEz0JndBzLVjrYipM6wFpNSgmxZg1MYMjA35ZczNIfdf62Hf4CAxXZzsvdb7j0ai
         C5PTMKBZbicLtmfqz9Eje+9CV4ZcBT5peLYlwGcsMwdJ/j6zOR8a+KME4+YHuIA4g3AW
         746A==
X-Gm-Message-State: AFuF++kjfqiRvv/PXB/BNKlK+BUZG69vGHMCIqfxU3BEaypgjcv29tSD
	7ZN8yVoSOwBBa+DOv50JIdzoGqqt2Z4pi+kIy7yljNivuJjGdNma0P+cdWYGhs5rzOUSK+qgtwQ
	Mwbb5N4ytc6FL+0RXMNXzYOwmCMSEMMPoLLHIiXvJMEu2WhHEcetZhr6WV95jrvu95IIzildULZ
	agH8s+4VUSnGqCfVFHRKIwtkmaKlXjMKdm2wMavmIrRaT3d6z4v7AZBjufTBqUD+4XB2FNRPNPB
	z87KwvAxA==
X-Gm-Gg: AYBFou30jm8Ij1mzaXqNcJ74m4gboz9nIw1tHAZsdBkCRpee1qjjGhYVZTFC5GHEj0U
	Zxe1gL/VUsD3jh4NmT4PpBJeWdG5De9HYt9AFKsLKIkH5r3ukLoKeDHHZSGeEpl0fyllBjDY3cX
	st4fPO76NsJMkhPinEZ0x2ZmJwxtwq+u8Zoi2HlP1jmqjShrADa8mOFILQ4+jJECzCnRDS3N8wV
	YESp/HyA7oCZSycBhUSaB+ulc9a1zHxov7bWEu4y+2B4IusP2PT0i9m0AOLzgJy9/vRlOeaB28h
	M35qyVSZpByu9CIU9P1vf7qFscyyHPy1YTD/Fnsj/iAYRC9fx9bvU3Br3AKzg3yIFCj93janJFn
	PW1Sy833Bf1SFzpvaqIoyUjkEZ2bj4mkW5qYpLLS7p4pkMsRHKnNJu/e0tMad91WUMhSohZHJz2
	31FyHIH1qEh7ItpLhJxVlrHcBBIvBz7ze8aA==
X-Received: by 2002:a05:6122:1d08:b0:5c9:a617:580d with SMTP id 71dfb90a1353d-5c9a73ea7b5mr747908e0c.10.1789627600285;
        Wed, 16 Sep 2026 23:46:40 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-5c9a4ec5a3fsm804698e0c.0.2026.09.16.23.46.40
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Sep 2026 23:46:40 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc51591102fso735377a12.1
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 23:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1789627599; x=1790232399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K1uINDFjo2ML6R3SHyow6jDUjhiv3et72Nqn9GZ5YjY=;
        b=b7Yt6167rAOEENqILy5prH6WZedz7a0rcn3T2NXc8VLASv6syKF7FsXymxt73c77OU
         EREuevfAu7ZOGZykau2RZkhRvJRnXlhL8jwsu8EelE2j3VRfmwkuvr39PugKU+wz4wC5
         AYftQ/WYrsaebAsIGzLHcEvTu4pECtoHDsOi8=
X-Received: by 2002:a05:6a20:9150:b0:3cd:9bb1:c6f5 with SMTP id adf61e73a8af0-3dd5f451226mr13814455637.10.1789627599192;
        Wed, 16 Sep 2026 23:46:39 -0700 (PDT)
X-Received: by 2002:a05:6a20:9150:b0:3cd:9bb1:c6f5 with SMTP id adf61e73a8af0-3dd5f451226mr13814398637.10.1789627598733;
        Wed, 16 Sep 2026 23:46:38 -0700 (PDT)
Received: from H5S1 ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc50ab960edsm2754293a12.20.2026.09.16.23.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 23:46:38 -0700 (PDT)
From: Vikas Gupta <vikas.gupta@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bhargava.marreddy@broadcom.com,
	rahul-rg.gupta@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	rajashekar.hudumula@broadcom.com,
	dharmender.garg@broadcom.com,
	ajit.khaparde@broadcom.com,
	Vikas Gupta <vikas.gupta@broadcom.com>
Subject: [net-next, v3 07/11] bnge: remove refcount from L2 filter
Date: Thu, 17 Sep 2026 12:15:44 +0530
Message-ID: <20260917064548.773334-8-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260917064548.773334-1-vikas.gupta@broadcom.com>
References: <20260917064548.773334-1-vikas.gupta@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

A reference count was previously used under the assumption that any
context holding the last reference could delete the L2 filter.

However, going forward, the filter will only be removed by the same
context that created it, making refcount unnecessary.

The primary and secondary MAC addresses passed by the kernel are
guaranteed to be distinct, so each results in a filter being created
exactly once.

Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Dharmender Garg <dharmender.garg@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_filter.c  | 28 ++++---------------
 .../net/ethernet/broadcom/bnge/bnge_filter.h  |  1 -
 2 files changed, 6 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_filter.c b/drivers/net/ethernet/broadcom/bnge/bnge_filter.c
index d1279a4babcd..e10a774c3033 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_filter.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_filter.c
@@ -13,8 +13,6 @@
 
 void bnge_del_l2_filter(struct bnge_net *bn, struct bnge_l2_filter *fltr)
 {
-	if (!refcount_dec_and_test(&fltr->refcnt))
-		return;
 	hlist_del_rcu(&fltr->base.hlist);
 	kfree_rcu(fltr, base.rcu);
 }
@@ -31,18 +29,17 @@ static void bnge_init_l2_filter(struct bnge_net *bn,
 
 	head = &bn->l2_fltr_hash_tbl[idx];
 	hlist_add_head_rcu(&fltr->base.hlist, head);
-	refcount_set(&fltr->refcnt, 1);
 }
 
-static struct bnge_l2_filter *__bnge_lookup_l2_filter(struct bnge_net *bn,
-						      struct bnge_l2_key *key,
-						      u32 idx)
+struct bnge_l2_filter *bnge_lookup_l2_filter(struct bnge_net *bn,
+					     struct bnge_l2_key *key,
+					     u32 idx)
 {
 	struct bnge_l2_filter *fltr;
 	struct hlist_head *head;
 
 	head = &bn->l2_fltr_hash_tbl[idx];
-	hlist_for_each_entry_rcu(fltr, head, base.hlist) {
+	hlist_for_each_entry(fltr, head, base.hlist) {
 		struct bnge_l2_key *l2_key = &fltr->l2_key;
 
 		if (ether_addr_equal(l2_key->dst_mac_addr, key->dst_mac_addr) &&
@@ -52,20 +49,6 @@ static struct bnge_l2_filter *__bnge_lookup_l2_filter(struct bnge_net *bn,
 	return NULL;
 }
 
-struct bnge_l2_filter *bnge_lookup_l2_filter(struct bnge_net *bn,
-					     struct bnge_l2_key *key,
-					     u32 idx)
-{
-	struct bnge_l2_filter *fltr;
-
-	rcu_read_lock();
-	fltr = __bnge_lookup_l2_filter(bn, key, idx);
-	if (fltr)
-		refcount_inc(&fltr->refcnt);
-	rcu_read_unlock();
-	return fltr;
-}
-
 static struct bnge_l2_filter *bnge_alloc_l2_filter(struct bnge_net *bn,
 						   struct bnge_l2_key *key,
 						   gfp_t gfp)
@@ -75,9 +58,10 @@ static struct bnge_l2_filter *bnge_alloc_l2_filter(struct bnge_net *bn,
 
 	idx = jhash2(&key->filter_key, BNGE_L2_KEY_SIZE, bn->hash_seed) &
 	      BNGE_L2_FLTR_HASH_MASK;
+
 	fltr = bnge_lookup_l2_filter(bn, key, idx);
 	if (fltr)
-		return fltr;
+		return ERR_PTR(-EEXIST);
 
 	fltr = kzalloc_obj(*fltr, gfp);
 	if (!fltr)
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_filter.h b/drivers/net/ethernet/broadcom/bnge/bnge_filter.h
index 44ee1357a0ff..16a5d91517c9 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_filter.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_filter.h
@@ -42,7 +42,6 @@ struct bnge_l2_filter {
 	/* base filter must be the first member */
 	struct bnge_filter_base	base;
 	struct bnge_l2_key	l2_key;
-	refcount_t		refcnt;
 };
 
 void bnge_del_l2_filter(struct bnge_net *bn, struct bnge_l2_filter *fltr);
-- 
2.52.0

