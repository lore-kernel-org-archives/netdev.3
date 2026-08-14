Received: from mail-pf1-f225.google.com (mail-pf1-f225.google.com [209.85.210.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A51311977
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 01:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786670123; cv=none; b=DXNzEe2JNYMT1yyT06hJaDsM3R9c+SZIqHoec//b/0Muc3sfm0/9hX7f27SFURFqaRRAzM0i5kUnSiiVmwN6UhCQJ9bYHAX6PIhRTWThOGMKLKndO1E5QAuhy0Wm4rwnZvRRR81SObTCnwSHKkcSzigddOWA2eQg2IxHyDMuqio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786670123; c=relaxed/simple;
	bh=+JHdt3JmG2owDpqNuYfz4r8yuUstsxsqLFft1/pNYqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t1RXqRVXDS+WYUdQLJHmqXHgk3+Gm5y0gYKlfj5lnUSHUJqpFGOXhTyU1zTOLKigBH53HB+g8JOOIKpensYTLlzzViA1bOQKAMLMUBoJz2Ts1tnY5p1k2CrC/ej85mPQHbfcLECDsSSwYdXjfFOszuOV0TEbQqfvkjXme/5D0O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=iJc/usnJ; arc=none smtp.client-ip=209.85.210.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="iJc/usnJ"
Received: by mail-pf1-f225.google.com with SMTP id d2e1a72fcca58-84fa3b14ee1so312856b3a.0
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 18:15:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786670121; x=1787274921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fh4eD78DYvCQuANjl+/oFgvf7Q84OxklnUgvpJokBqM=;
        b=mtRzjIA1sBqEL8D2MJFaPWumQknDTSPEVCf6Nz1qTn8G2E38QhNtBhiNSkkA7zhvW7
         ygEgb5mNPeHX2lNWDMZt5QZrZBna6ODlicExbMfsPkUaIyT5QBI3Z9RdBMuIUvBSq0IT
         GKkSqT8OIvAoRzbtnoY1ddTc+w/FspunMSJunShVqsdEbfZBn0R6EU16nijfiPDJC9XA
         ow18ka2h4L1a2uI4Efg1zcbm4l/J7Dr20o9aO4yvH1yNFaLcspng3Q/6pUnfGKEV8w5w
         Vc7A2Uh0HVkp5Y5dFjIwvWdtyaudqk7ep6oiRGCrXQ5Cpu8cB3MXYbqPpRA0bLoMoCk6
         uKug==
X-Gm-Message-State: AOJu0Yxuf12rAjkiUNAnPWF2Nrw6kwRepvYYRAhCvZKlWMmi1DSeAonx
	OT9SR7RtoF8HK7kQjpwp9hVyRcPd/UXUlbaKTkaHCMy0ngCXwrTF0sXCiBUV+lDnvXetTzxMLnU
	oyqD06kZ1LYq4zhkR7vXJpfc5MTPoRYUJdMWJuSz/FCWiR6vzdny5nTdheZCWTpmnZx1ToPGofI
	K9Hof89OKYHniRujgztS6j2nV55AZeQO1G2WWvyMu2Iwmz18PvjIk6NlB1129hWVo7cPN5oLRcY
	ZpbvIsWOQ==
X-Gm-Gg: AR+sD13fyzxKtWGB4Aui2hcP0XXvY1auRKHVeu4W3NcsGNAd4/bEA525300GUGaU99O
	bgPHSngD4zihqYgmJrV2FgyTA/FesSSvJmf2JkJ/bB0LXe5rdoDzP5FB/dI6GEIIlguDRpd6Cvk
	77f0C6z+EpuUXNdWeURDqbs+kC74FyFEU/ILUQhFzB1x7wb2+DLj2OdLVu/6RYsSvt7tflVwkj+
	EcdGJcWDdXy/JDrgzpAvXYSRYXXBe2AxsZ7zgxwrhMkI4/b34c6MJtMQF000OpyvpQMCPgaCi/T
	SzViKYpcn6vqHKsRRwj5oDypuJJXhL0W8e0ID6RClVwYHUbbuMdWwfX1CyUgxqIo+dXueanxZnh
	lplG9v+5yu5mffb/WOd47cpyDCObEFkFRDhUcXB/erye0wyGu2+bUJNslq5TrUcrP+hMllAJZkk
	cJ9JcJ573DfZIOpYlhPxGVx/nX/mim6lNrew==
X-Received: by 2002:a05:6a00:1f0b:b0:847:968d:b101 with SMTP id d2e1a72fcca58-84fde2c7565mr2374280b3a.21.1786670121126;
        Thu, 13 Aug 2026 18:15:21 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-84fd350f950sm698340b3a.8.2026.08.13.18.15.20
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Aug 2026 18:15:21 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38dde0df80bso641897a91.3
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 18:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1786670119; x=1787274919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fh4eD78DYvCQuANjl+/oFgvf7Q84OxklnUgvpJokBqM=;
        b=iJc/usnJ+XIGbzZjG4UohF8zPCRVeY7zsS1bfIWmkVhknr/bro9G/rscoX83nDIVlr
         9sIGpA7umLyzuG7NdoaOJWZXDg/trewdgpveA+gCjP4/M7qnTDbqMPXkgJdPYtM6Om5P
         Ms0ZPPOCuwkA4/IJjpjCC548QZxkcwfy8Dbi4=
X-Received: by 2002:a05:6a21:6b16:b0:3c8:e0b4:cd9b with SMTP id adf61e73a8af0-3cc71eb5e50mr2099598637.38.1786670119227;
        Thu, 13 Aug 2026 18:15:19 -0700 (PDT)
X-Received: by 2002:a05:6a21:6b16:b0:3c8:e0b4:cd9b with SMTP id adf61e73a8af0-3cc71eb5e50mr2099551637.38.1786670118775;
        Thu, 13 Aug 2026 18:15:18 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31ebcb69fbbsm12174177eec.11.2026.08.13.18.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 18:15:18 -0700 (PDT)
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
Subject: [PATCH net-next 07/11] bnge: remove refcount from L2 filter
Date: Fri, 14 Aug 2026 06:44:31 +0530
Message-ID: <20260814011435.194631-8-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260814011435.194631-1-vikas.gupta@broadcom.com>
References: <20260814011435.194631-1-vikas.gupta@broadcom.com>
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
 .../net/ethernet/broadcom/bnge/bnge_filter.c  | 23 +++----------------
 .../net/ethernet/broadcom/bnge/bnge_filter.h  |  1 -
 2 files changed, 3 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_filter.c b/drivers/net/ethernet/broadcom/bnge/bnge_filter.c
index d1279a4babcd..33b75d8fcdeb 100644
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
@@ -31,12 +29,11 @@ static void bnge_init_l2_filter(struct bnge_net *bn,
 
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

