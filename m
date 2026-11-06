Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793957768;
	b=vL27ODHefg4Md2vPykEUfovI1rggSi7hB8hQ4BigLuIwCzwGJhba3XgzgjLdeFBdTG9v
	 0sMJXajEBdQI9XUZzCgbZLzDUZ/4TDHPYD7QwuU1mLminsAI/cNsIbthJv0KskUK8Z3A8
	 hzBuPp+2VsDkQqXWoTxIJeCQ3app5meJjwcku6KyZqZSV3tKvyPigormLpyXrmFGAUCLw
	 BeCMLTDsegiyf/3Cw+7pjrIDaiSS6UHd2SSL/YzBuBhu9PAyh5T7TcfPAkXqorEJDh6TV
	 NY/v/zVBgR3+W1w2j7xAGWVZ5/6x03XmkFX2dEzKlI1ngGjXNu2IQY8SL7PkOVHUTzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793957768;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=XJyJ08sR86/xKJbZYcdm5hXrclIzfYMcFJVS99ypPws=;
	b=mpHXOJ2ElsDO3IBHk9hBVsolRnNbICpe1v/4FErUirD+/hVa955slj473RQBgBER+HVQ
	 RNnW1jBlz7i5bY052G5xsH8tzaanViRHA9CL7A2EGwutLKG5n+N2R6FfGSi8Eu+IJjWwq
	 9zbXP2PYYM8kGSRigUqyjJApWWIDpgRVyt0o9iXsiKbub8wYVtzOX5fB3NLh1Gt47hZbe
	 /kubbu1PD2ERTsOpWfD3dYRY4DGeJ9mEnEtxwYz14oRmvgquHEq2QXKcs8kLZjfa4j4a8
	 pW6bwqVdFBdGVXNyO4H/6p67kjsyqCCNrNRMTgVVU48U+yYjB8Ahgn93F7VnVrQ4s8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=bsUCLy2q;
	arc=none smtp.remote-ip=209.85.216.98
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFBE6082BDA
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 09:36:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FFBE6082BDA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=bsUCLy2q
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-3b09c07b3d2so259198a91.3
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 01:36:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793957768; x=1794562568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XJyJ08sR86/xKJbZYcdm5hXrclIzfYMcFJVS99ypPws=;
        b=uQ/QiSfjnR7ZxFX/S+fXgvnySaAJNzVtuss/V5/hSVfKOmOzaBjUQsfUlyID47j80X
         FCJL1Y88NG9VUDWrCvO3d2Kxa79QjNVD9q92M5RzpDKd791CyROD0kNozY7QsRprW6OK
         ABNII6P0/LNmspEqg+wGp4fWZQO1WbJoBVuT8VSIQjibIw4UXeAyMbQRPNAIYTFHKaE2
         aD9GcztTLcvl3b1Tih23yMdp1VLwnEkDbr3LFAs/SqD/UzonwkCZ7E+g9UTH8mDTMdOj
         Ef+TG1joFYjTE6Wpuxhtj0UJkaHvA7t1AYQecujJpFChkATDDYEHCPMvoVUPiMPueF2w
         SDOw==
X-Gm-Message-State: APuU4Z+NHOd90iPzoJoxbwwuKxS25umPAIV0hSwvHRM5deCB3WD2K1CV
	ptFF94iFZlhRTCJsmsOEW/3EkpLvicNc4NSpNXdYFD0RntH6uj+afl4G39O1j0ZirjefUsEyvHt
	raQyi6vTw3H8W0HCcx42Op7UtXL+gg4II7yahTH25yT40t4s5bcijwgbTSPU0PvHoM+N0/q0R0M
	Ncp1JIvoxFDgiL8g6oZtSg6bW2SX0wtS/HT752ORvZQQg18YwZ7BIhSIl34EZdFE1BeH0W5urJu
	MBmE5xVdA==
X-Gm-Gg: AYBFou3MigFdI/a1ePJpRDWe3tWZogjofz8SoJ8zcnYYB6KpgvEDL6eJh6DrjIWciyT
	aIrJ/XDG5jH13TAaBKYt6IdvDyBcn9WG1kxpeVWFUM0ByGedFMkNPQeZ8/Zxyut4R56+WIqnCks
	88IkewkUS60dT5mjlxB4hfZXNmqE0RNwZPkkn9elav6eZLswTgO99pAduBNw5qmeJEfeR2Vz+Ea
	qAH2Ahz2I6jjQeulojTyFkDQ1fc65k0CRw/QowBxv374SJ2gE0NfbWs3j64GbflgChLHWoRuX5U
	BNmwu1kJKzrctvIAju3scZN5NvuNPFpNOZEFQFWHIzP1ja7jea35cH/1t6OwGRSr5E35J/MtsKc
	tMoUBjyn7qvU5sShnQ8ZVNFd7+kMo7qZMO2o/tqob6JZj1JA+wHFIWu+E0WzspN1Au15CGS9iCn
	rXhtJ+gxLgjLJRfr76/8P16Sv1ZF9fJXnhbg==
X-Received: by 2002:a17:90a:d88f:b0:3b0:9941:8d41 with SMTP id 98e67ed59e1d1-3b0db6ebadcmr1953304a91.28.1793957767648;
        Fri, 06 Nov 2026 01:36:07 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b0e290249fsm346941a91.2.2026.11.06.01.36.07
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Nov 2026 01:36:07 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-36a3451ea93so756538eec.1
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 01:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793957766; x=1794562566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XJyJ08sR86/xKJbZYcdm5hXrclIzfYMcFJVS99ypPws=;
        b=bsUCLy2qmD/k0R0cLX2xaoIbsGXQBefIwY+NP9PXtgtAvhnK+3szIWhsqZykoncrEi
         Ot7ew9dcGvzxKVvCtvf/byDkHwEiDr5XkEauR9pS4TP2VJ4NZxnh/ZU2CEjyQnSA0XO6
         IKeyr8IDyUymMRQLb0gzELls80PffirYFJl/E=
X-Received: by 2002:a05:7301:d813:b0:369:fe81:a575 with SMTP id 5a478bee46e88-36f772fa7e5mr2669859eec.35.1793957766020;
        Fri, 06 Nov 2026 01:36:06 -0800 (PST)
X-Received: by 2002:a05:7301:d813:b0:369:fe81:a575 with SMTP id 5a478bee46e88-36f772fa7e5mr2669820eec.35.1793957765360;
        Fri, 06 Nov 2026 01:36:05 -0800 (PST)
Received: from H5-S1 ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa9fc92fasm6447726eec.19.2026.11.06.01.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 01:36:05 -0800 (PST)
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
Subject: [PATCH net-next v6 06/10] bnge: remove refcount from L2 filter
Date: Fri,  6 Nov 2026 15:05:20 +0530
Message-ID: <20261106093524.838341-7-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261106093524.838341-1-vikas.gupta@broadcom.com>
References: <20261106093524.838341-1-vikas.gupta@broadcom.com>
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

