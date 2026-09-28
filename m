Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7273B41E6B9
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 06:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790576050; cv=none; b=Yj4wWRzl5riM1vytbksyV10vffblyLNdMwzoDwA1DFWpm7VhmK7R2RJKW4ZJ3yTpuaY+ISqdRB9VmLV9pmnygv9sUkYlz0gGdr6VsisjFfyMBlWbsGhX1xWL312ruJ1/7mbAJtoo8LfLNmmuB6Hmf4ej4QQnlOnEk0Pm6dJhqkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790576050; c=relaxed/simple;
	bh=UYchbdXK3Jpn8CtsTYPj3Lhmu0L5+chHl0dP6/ApjiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lBxKArhSRgIs7eQVq89fB0CJkNTeYBjv+797tBnOlqVPSvulS7inWne4stZLY8CsfNWY24N6CIJxAvBvwm8BVES4pY57mNAtswKy4+bcj8SGwMRFiJH0N0f1adjx09Lo7ERnWKrMIKwobYSb+h44PErP5DJ6iWVqWjswo0CidXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=iFZN+YQx; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="iFZN+YQx"
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2db710396ffso16856415ad.1
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 23:13:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790576034; x=1791180834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y5Jyiu4cCDaLEMuXSi0yqzNnVkBmDH4wHEot6cHUGGU=;
        b=VPjXghVGLTRx/tVxs6QwtjK7bOsEDPTNmC2u1mgDfEumyZPVoR2FJZnvix0Wjy8O/8
         TF40l62upA2Mw0lAK3Ted+L5ej7r9Hctu19itCAkPqoUgkcIkjN4+JZNjl1QI0UzPd8D
         P/pSmZPY4hdf+HuSJ3ePhSsqlMZC4mqvwibvEnu49XSi09Z8EAO5bx6AVlEFp6dk6jFF
         setRfwydPHO+ComQw4yuUKxl+OuDavGSGvUlYUbqf3TJmEcC4WFI63mnDwfxJX7iWU4D
         g+ixVXpq2UVii/ORYOCfRBAmEtiEPB1kzjM66DzPMOahOXJ49iMOBPfXXh+abnP64eSk
         zaEA==
X-Gm-Message-State: AFq9FYKjIHXEDDPowlmYF3aSPw/8k9h8/17Pd4+wBCfO8LovYz5lLMce
	KozhgONB8avIYtElBqtZ4LlaqzDaEBzpYr+6POsMT78VN7i1noBWhfRyjsdgzJi4sa8DZBaRFp+
	b1HK34q0+L+xsonA2Vf5xxVUddkMacNQ1vyXLvH2fkj3uDarrnlAvzSohWTXkhjCWSZBhmgwQSG
	LtDaWtqERsSpduuYShB2E+jaPAjjokKFSGm69tXINpfguzmRcxRMk/wPDWduXLn4176yz72Toth
	wZSbO1HrQ==
X-Gm-Gg: AYBFou3Ifoxph64BwiY4brbb07MllEvlF72C1fWe0BB+LsbqSYi1x0kQLyjC4L03I6f
	WFBs0GnOX07GfvzI5XIzDwn/ZEHhkaNK/YQtCz21dIbfmft9HOywGWqM3IGm8tFRbRYDbqZnzpQ
	PnwNdD90dJyscLzyunjN7CDxNE75gcpnEP0T306A5Ljf2KJdttBeqtoS8R4E0K1kAWaxalZASVG
	p774+VeXq7i27hRLhoMP97IX+OGcACbJDqYDO2MUT9hOeeY5fKJCuCYnYnqDeNPQBkYGCWVBBdS
	JdF/4VocUw/UH0N7v1aW5W/hQ9+VSuSur7VuwcZZTTQ1l/TWctB97g9kWrQsJsL9UBGx10lura+
	CpMESQGxr4EEUJ8wTRfVu7xMRBgjDPU8Ku076aLtj5Q4vSYsuPLtgfiKYAOEMugDjOJu9OrI7+v
	tWyDzExw9PoODP7FCfDi3J7GhrYc8RqwW81bun
X-Received: by 2002:a17:902:db09:b0:2df:aae1:48fd with SMTP id d9443c01a7336-2dfaae14cb1mr26485575ad.21.1790576033873;
        Sun, 27 Sep 2026 23:13:53 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2df913fbf6esm3374605ad.44.2026.09.27.23.13.53
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Sep 2026 23:13:53 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-3425098ae4bso2048362eec.0
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 23:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790576032; x=1791180832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y5Jyiu4cCDaLEMuXSi0yqzNnVkBmDH4wHEot6cHUGGU=;
        b=iFZN+YQxPQHUp8vDI9Unk+QG4kqBtBAWnPpGrzKpHSseH3hxoC+lxlTYQuctuSd3jU
         LkEyLs4/f1mEX0s8ljDaNxDcqJw+xGlkDcOYaqQFCLC/8TpVrGHpwlGSporhAw+/uWHx
         UUMyf35u5exdwdrM/e+VqObqQvNAkppNyMUWc=
X-Received: by 2002:a05:701b:4354:b0:143:1bb1:b3c3 with SMTP id a92af1059eb24-146cfdd2a6bmr8678023c88.14.1790576031558;
        Sun, 27 Sep 2026 23:13:51 -0700 (PDT)
X-Received: by 2002:a05:701b:4354:b0:143:1bb1:b3c3 with SMTP id a92af1059eb24-146cfdd2a6bmr8677957c88.14.1790576030050;
        Sun, 27 Sep 2026 23:13:50 -0700 (PDT)
Received: from H5S1 ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-147913a776fsm17355561c88.17.2026.09.27.23.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 23:13:49 -0700 (PDT)
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
Subject: [net-next, v4 06/10] bnge: remove refcount from L2 filter
Date: Mon, 28 Sep 2026 11:43:03 +0530
Message-ID: <20260928061307.1172344-7-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260928061307.1172344-1-vikas.gupta@broadcom.com>
References: <20260928061307.1172344-1-vikas.gupta@broadcom.com>
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

Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Dharmender Garg <dharmender.garg@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_filter.c  | 28 ++++---------------
 .../net/ethernet/broadcom/bnge/bnge_filter.h  |  1 -
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 23 +++++++++++----
 3 files changed, 23 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_filter.c b/drivers/net/ethernet/broadcom/bnge/bnge_filter.c
index a8bb441ebef9..3b26939b0457 100644
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
+static struct bnge_l2_filter *bnge_lookup_l2_filter(struct bnge_net *bn,
+						    struct bnge_l2_key *key,
+						    u32 idx)
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
 
-static struct bnge_l2_filter *bnge_lookup_l2_filter(struct bnge_net *bn,
-						    struct bnge_l2_key *key,
-						    u32 idx)
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
index ea1acefd70b4..a4a386202ac3 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_filter.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_filter.h
@@ -49,7 +49,6 @@ struct bnge_l2_filter {
 	/* base filter must be the first member */
 	struct bnge_filter_base	base;
 	struct bnge_l2_key	l2_key;
-	refcount_t		refcnt;
 };
 
 void bnge_del_l2_filter(struct bnge_net *bn, struct bnge_l2_filter *fltr);
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index ac77ba813f01..29a271f50e04 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -2011,19 +2011,24 @@ static bool bnge_uc_list_updated(struct bnge_net *bn,
 				 const struct netdev_hw_addr_list *uc)
 {
 	struct bnge_vnic_info *vnic = &bn->vnic_info[BNGE_VNIC_DEFAULT];
+	struct net_device *dev = bn->netdev;
 	struct netdev_hw_addr *ha;
-	int off = 0;
-
-	if (netdev_hw_addr_list_count(uc) != (vnic->uc_filter_count - 1))
-		return true;
+	int off = 0, count = 0;
 
+	/* dev_addr is installed as L2 filter 0 and skipped when building
+	 * uc_list, so compare only the unicast entries that differ from it.
+	 */
 	netdev_hw_addr_list_for_each(ha, uc) {
+		if (ether_addr_equal(ha->addr, dev->dev_addr))
+			continue;
+		if (count >= vnic->uc_filter_count - 1)
+			return true;
 		if (!ether_addr_equal(ha->addr, vnic->uc_list + off))
 			return true;
-
 		off += ETH_ALEN;
+		count++;
 	}
-	return false;
+	return count != vnic->uc_filter_count - 1;
 }
 
 static bool bnge_promisc_ok(struct bnge_net *bn)
@@ -2058,6 +2063,12 @@ static int bnge_cfg_rx_mode(struct bnge_net *bn, struct netdev_hw_addr_list *uc,
 		vnic->rx_mask |= CFA_L2_SET_RX_MASK_REQ_MASK_PROMISCUOUS;
 	} else {
 		netdev_hw_addr_list_for_each(ha, uc) {
+			/* dev_addr is already installed as L2 filter 0; a uc
+			 * entry equal to it hashes to the same key and would be
+			 * rejected as a duplicate, so skip it here.
+			 */
+			if (ether_addr_equal(ha->addr, dev->dev_addr))
+				continue;
 			memcpy(vnic->uc_list + off, ha->addr, ETH_ALEN);
 			off += ETH_ALEN;
 			vnic->uc_filter_count++;
-- 
2.52.0

