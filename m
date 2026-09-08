Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0B551A748
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 09:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788859915; cv=none; b=j7MlEyHaP6/ktbIaVsAb3dyWf3nek8DYt0bBWw2svyKZiWeUvTqMtYAzGYxVQz6QwY8oQsLJ4G4FSrw6EuBXwDunF/6xHfkkvGX7MfJGAHZ45NjsLW4m8xt02OzGU9BHYEl5wVmsRzIH1zycuDvdOImRvjkOlfRrh5vD0Q6hPf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788859915; c=relaxed/simple;
	bh=wZkIMCgg5oCx1eGJGJf0GAC6wBFKhPiaR+VgAEx8las=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RTyf5+SQxTM7u87Nf4UA6pneELZAQsjCcpmgC6DI0wZBrxloRPLjl4L6DCH/ND5hRE8NBlipb0BVUpHCohvrGjQ0bR6a7InY+M1HhVGEa0vY+AMbvmklkklFDo+LM99GmX0TCJkLK/KHTQhA72GZ+3ZNuaQ/n1mTaHUtToQeNuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Z+GyJ1M9; arc=none smtp.client-ip=209.85.216.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Z+GyJ1M9"
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-395cf2535acso4425813a91.1
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 02:31:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788859913; x=1789464713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c3KTfxIDgbqkFRErLg07i5B44CU7ANofzQAH4ERdvXg=;
        b=fnoBqgCj77H64ZOe21lAufN+LWUF5WMhpfBxjitcUWuqWg6gCeKqWLPa2VF1BgdZ2G
         YpGJ7cbWKZxsJRjFRxB6wKCnlBQgdYX4PwqOHUf8VWzMdgGOZPBfOjbwNx4kFvXw7N/G
         K1nHbvn28NBRIdt8qLAVuW/sj+wNyGMFfRwCaS1YkGXMaqoqEKWz0AAWTELwjeZGNwqk
         tHa7RJRCSIczSyH8RTjkXebpQXpBNizLJh7mX+CCFiq9mvEH/oKvcNQjDt+AMR6e6PGO
         oRX0LVMnNkpaXJBV+fGnuPKnRTVhPjoK/EI5Ys0Pip5m/BZVZWWOuY3vqE97ajsn7Igi
         rKZQ==
X-Gm-Message-State: AFuF++laE9xTTWyIVVluga2nfWAuAdU2QwN7bmUp44pgpgRPXo7+EUDj
	xmz6Ik1sM6GqHHlMbQXa533qXqLwJHC/D3XU3a28QO8f9yGscMoS5pB/kS2tifgOm4hMtk9DqcM
	1T13BzVlJPOYnupO99+G+SPt8/L/hALbMIPBmUXQ+xnzyiBPvRDUnCYv7QuszofRtb+PXKwfasB
	mqoNvqGs/KndMo6Ot318sQMyJSD4xCJkc3FOgsm2CUur5cNDc+T++w9hXFVoNOBnFv72osSLOti
	eiUeIP13g==
X-Gm-Gg: AYBFou1r7W/xW+NdShl2wK5L5BfzkaQEj18AETCwOmj9gVhhzJifv6VNim9EvgdoVC/
	6uWo2Ms9297IXOQGw/UJ/XYNzObTkOEybWFIumUMwAtQB0aKVJAX1fNh1R3q7xXwzLeCDPRdk/l
	SC5rSDO1Ac/50dd1r00uquMYQ6xRkIRPhRqJZibEUYSSyqIB1lnLqNweBIflXR757P0b4X0yHAe
	MxfwF20+DHj/Ei+VGW0bLQD5/ayDrm9Txf9xcg2RVm0djfgCFdzU6jb6updAjSDFJfZFDMDHCgo
	MkbVhbwKb6ODnh5lofVPE13XCYGmeAk+Iy7SA7dPMwxq79JyMeKhctzbOohVqmo3pQGOAze2/tB
	kw+4R1P67VLHx52yRMeBW/V/ph3Tvg/i2eT/s4sRALR9W18nZQOGAOsLcceLUw12/znUvku2ro0
	DqOlvJ5wgvluS+Bye2aA23oMfDl0Z/GymVP5xt
X-Received: by 2002:a17:90a:e183:b0:37f:e5b1:ec4b with SMTP id 98e67ed59e1d1-39b07f305admr36656102a91.5.1788859913315;
        Tue, 08 Sep 2026 02:31:53 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-1434bb89093sm79492c88.5.2026.09.08.02.31.52
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Sep 2026 02:31:53 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3968dfff779so6115460a91.1
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 02:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1788859911; x=1789464711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c3KTfxIDgbqkFRErLg07i5B44CU7ANofzQAH4ERdvXg=;
        b=Z+GyJ1M97v3m1VQjiqQMQpfNt9/+4mIs1ua9PF9qhJsocseIQ+unSEOXch+ABZGF5h
         0Z08B43GxTg92aPEVn5pc/+7lZf0hzEa7cuVg/TOeu5Sto2MGMegYo+gTS8CWIU9UcJ4
         MdLuvwMeOtNqbDwsNzswLpfZfpfsijS8uLix0=
X-Received: by 2002:a17:90a:e185:b0:39b:5622:d645 with SMTP id 98e67ed59e1d1-39b8b9ea393mr4577723a91.0.1788859911270;
        Tue, 08 Sep 2026 02:31:51 -0700 (PDT)
X-Received: by 2002:a17:90a:e185:b0:39b:5622:d645 with SMTP id 98e67ed59e1d1-39b8b9ea393mr4577671a91.0.1788859910752;
        Tue, 08 Sep 2026 02:31:50 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08ca63b3sm31493316a91.11.2026.09.08.02.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 02:31:50 -0700 (PDT)
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
Subject: [net-next, v2 07/11] bnge: remove refcount from L2 filter
Date: Tue,  8 Sep 2026 15:00:49 +0530
Message-ID: <20260908093053.2596020-8-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260908093053.2596020-1-vikas.gupta@broadcom.com>
References: <20260908093053.2596020-1-vikas.gupta@broadcom.com>
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
 .../net/ethernet/broadcom/bnge/bnge_filter.c  | 25 +++----------------
 .../net/ethernet/broadcom/bnge/bnge_filter.h  |  1 -
 2 files changed, 4 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_filter.c b/drivers/net/ethernet/broadcom/bnge/bnge_filter.c
index d1279a4babcd..be392d154be3 100644
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
2.47.1

