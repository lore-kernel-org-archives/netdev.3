Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793709471;
	b=Q6cZb6s9bPO7BK/wrzxqg3XI3TrbiTaTfSAVWN5UmBWbznEkacCSgkDnDqmbXM/vpxFb
	 +BFYZWTCHYyKy6yLPPi6xOkjexWibj/UYgOBOP6AqMSbwlSY3EeAwF8qIVXH4FFlVKL4L
	 Go9dtD8y/QMDOBRRZVJRrfbUoNaYS55j9Fph49NFWTpjFZ+KUraQVurcfP3oB9qIdcfwJ
	 cvKuvwcCiQXBAE0+wPHg40qzbG41UUkqJg0CdNouVEM0ZKricpex8LHkF6SrYgsH3Kdcp
	 6DOA9OnohCQxz8FPPD4+N5kUsnHyNtYbreAnTCU98U5YpqY6i9yO9mttyndQ5nnwYJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793709471;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=XJyJ08sR86/xKJbZYcdm5hXrclIzfYMcFJVS99ypPws=;
	b=lshZ8BqfJ1y/V4kjd5aoihCol+/aCnwYbB+1oNOkyfqew5Z0P2e75OrwmfItVpu1Aj3O
	 2lBrGG3zKd6Ir9lyEOqS3z20HW4ffgYzOuWnvUBcdTFUvxnBsmkMUT8u40wObbqmJtxPp
	 +G40t0LwcIzSdf5LTuOEmHSy4kVah5hVUIhwRZzr/p2Mu13NTRNnVfE7zfxY5QL3ge+op
	 XbBNP34f5vRfrMMdVycqnTajewPTC9hClYlgPeb7NdFdNFE8stN4RHwBNv8wVZE/UXsa+
	 jM4eYU7aMTo5I/+oL8VVM9lYY6A4KxWjpzK0wZjvMvJ+9Hxm/VzTp35VQzD3XSqp5IA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=g+x+2rVP;
	arc=none smtp.remote-ip=209.85.215.228
Received: from mail-pg1-f228.google.com (mail-pg1-f228.google.com [209.85.215.228])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C510606EE88
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 12:37:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C510606EE88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=g+x+2rVP
Received: by mail-pg1-f228.google.com with SMTP id 41be03b00d2f7-cdb2e0062bbso744210a12.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 04:37:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793709470; x=1794314270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XJyJ08sR86/xKJbZYcdm5hXrclIzfYMcFJVS99ypPws=;
        b=f93HIvMtK1/hqzSjgXXb41iwy5+1u7HNkrSfBaNBEQtb/gW7pWNoPXmN30kO/BEGuy
         2V6MOWx152e3gs3eiz0MStN3A2IL4YrAMqJo/XsuJNKyzP1XmW1lIxAGCsx8WS3q6sis
         CzA7ASsx916894a94fqGgoDj2gDMvpTobHm62YPkU0O4IF/Yc+Xqi93V0Hy254vXfMBO
         0/Qpnad730zvnk7L+Nw5bJFA1lUVU8ZFglNecy16Fz/73ejpgmn1EnNO27JWYko1svk8
         viyrnPOAXUXdonP0a6KTeNtx13agazgMFcG447J/LWi1hO/KrUSc5pLcyfK0Ssas/duB
         OV7g==
X-Gm-Message-State: APuU4Z9mdV8rSYGCODW4Cav2bQImN2D363ingEE+9MBgiNdd68QiLx5y
	9d3mDP006uuZ+BztTT3WWg+gVIsCesm5pOShRVPLGXQgpWZHWy3Qe5O9h2dVtNtg0d/wM6hYp98
	5hRjRxST07fCMe2hYcIngsojNzJtNtJAWGg44nv6G4IaiXDUdhvCSQsEe0rU0yNc50oQVTHtMJi
	/7pFHEX42KhvSo7BDbjvUWQd/rgB93UhVCv5ZbZTeGK/TajUoykn5WXTxSp79fPUeNF/3lcpcJS
	J2qura+iA==
X-Gm-Gg: AYBFou3PKcmosVXHAFVMQ2YV9znQk76gaon9W6xpjhnNPWMVgMdLjIEYIFL9HqfRtFS
	lNOT9g+3TVnJV6tzGVShVl8SnTWGJF03Oq6UTRpPw2y8kn2DfEcNCkIQgsejPOMoc3rH+G9GHP3
	uxbDohzI33Mi0+hTYZZrzVlMw3v6jy/TlSwSGokGN11xgpsmTCxHhVpowGAPuiet9Qw/+FJSBKD
	Li0Bu8uDmyiDnTd/GOQjaYxeZgSFyXCiSMhhvQVHo0vgi3Rg/aaLJXYwpRp7cBSEneV3uVXqSg3
	uP83mfV5XlbZZqa+I3zgR1B3ZotNKwgXsaNGSc8LWyb/Vf8gJ69NnnAXsLrmOILx/Cc7pVQngrU
	kbHrT3sz9eTLT4dlOBulqU+hpcBAziCJqzR/04Zk3lRUiybYXmd0DYVbkNyj/pGlevIe9W/QHBM
	TzoI2HjQ0h/WMU/dcjucNQQgokgYzAaL7rKw==
X-Received: by 2002:a17:90b:1a85:b0:3a4:967c:6947 with SMTP id 98e67ed59e1d1-3ae89736172mr10375457a91.21.1793709470490;
        Tue, 03 Nov 2026 04:37:50 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae87fdab62sm4019281a91.2.2026.11.03.04.37.50
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Nov 2026 04:37:50 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ea71803effso43274325ad.3
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 04:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793709469; x=1794314269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XJyJ08sR86/xKJbZYcdm5hXrclIzfYMcFJVS99ypPws=;
        b=g+x+2rVPaheaddyKcmjoCO0G0Ol1zj2g/aORAbTIXt0UxO2LJl1aX0LSA+W+ruyGi0
         ZKuWPAGjMdpQBQYfx7xBMLXRYB0tPysXWTT5JmI3P+NgzmffTqphF2nseUzx7994ixbv
         m07rPadjOS9c/o84GP0to2rSQsW3krkTuQFBQ=
X-Received: by 2002:a17:90b:2e4f:b0:3ac:8897:7bab with SMTP id 98e67ed59e1d1-3ae89536bffmr9829366a91.6.1793709468870;
        Tue, 03 Nov 2026 04:37:48 -0800 (PST)
X-Received: by 2002:a17:90b:2e4f:b0:3ac:8897:7bab with SMTP id 98e67ed59e1d1-3ae89536bffmr9829339a91.6.1793709468373;
        Tue, 03 Nov 2026 04:37:48 -0800 (PST)
Received: from H5-S1 ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b08759344dsm2131567a91.13.2026.11.03.04.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 04:37:47 -0800 (PST)
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
Subject: [PATCH net-next v5 06/10] bnge: remove refcount from L2 filter
Date: Tue,  3 Nov 2026 18:06:46 +0530
Message-ID: <20261103123651.442893-7-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261103123651.442893-1-vikas.gupta@broadcom.com>
References: <20261103123651.442893-1-vikas.gupta@broadcom.com>
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
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

A reference count was previously used under the assumption that any
context holding the last reference could delete the L2 filter.

However, going forward, the filter will only be removed by the same
context that created it, making refcount unnecessary.

Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Dharmender Garg <dharmender.garg@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_filter.c  | 33 +++++++------------
 .../net/ethernet/broadcom/bnge/bnge_filter.h  |  2 --
 2 files changed, 11 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_filter.c b/drivers/net/ethernet/broadcom/bnge/bnge_filter.c
index a8bb441ebef9..6316f75ca36e 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_filter.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_filter.c
@@ -4,6 +4,7 @@
 #include <linux/kernel.h>
 #include <linux/dma-mapping.h>
 #include <linux/jhash.h>
+#include <net/netdev_lock.h>
 
 #include "bnge.h"
 #include "bnge_netdev.h"
@@ -13,8 +14,8 @@
 
 void bnge_del_l2_filter(struct bnge_net *bn, struct bnge_l2_filter *fltr)
 {
-	if (!refcount_dec_and_test(&fltr->refcnt))
-		return;
+	netdev_assert_locked_or_invisible(bn->netdev);
+
 	hlist_del_rcu(&fltr->base.hlist);
 	kfree_rcu(fltr, base.rcu);
 }
@@ -31,18 +32,19 @@ static void bnge_init_l2_filter(struct bnge_net *bn,
 
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
 
+	netdev_assert_locked_or_invisible(bn->netdev);
+
 	head = &bn->l2_fltr_hash_tbl[idx];
-	hlist_for_each_entry_rcu(fltr, head, base.hlist) {
+	hlist_for_each_entry(fltr, head, base.hlist) {
 		struct bnge_l2_key *l2_key = &fltr->l2_key;
 
 		if (ether_addr_equal(l2_key->dst_mac_addr, key->dst_mac_addr) &&
@@ -52,20 +54,6 @@ static struct bnge_l2_filter *__bnge_lookup_l2_filter(struct bnge_net *bn,
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
@@ -75,9 +63,10 @@ static struct bnge_l2_filter *bnge_alloc_l2_filter(struct bnge_net *bn,
 
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
index ea1acefd70b4..372657cba43c 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_filter.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_filter.h
@@ -6,7 +6,6 @@
 
 #include <linux/types.h>
 #include <linux/if_ether.h>
-#include <linux/refcount.h>
 #include <linux/jhash.h>
 
 struct bnge_net;
@@ -49,7 +48,6 @@ struct bnge_l2_filter {
 	/* base filter must be the first member */
 	struct bnge_filter_base	base;
 	struct bnge_l2_key	l2_key;
-	refcount_t		refcnt;
 };
 
 void bnge_del_l2_filter(struct bnge_net *bn, struct bnge_l2_filter *fltr);
-- 
2.52.0

