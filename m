Received: from mail-pj2-f16.google.com (mail-pj2-f16.google.com [74.125.227.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C613DBD43
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 05:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789881860; cv=none; b=HYPUf2T6q5ib4t8hbtDJcRFmbkb5a+JL0n+Sb2XBEbImW5UUThq+qkYdekd2DXIPjRsJOvVsFlZ35JoibTPDabNAvGMWDZ7xIgRQM8C6iq6AOEktGnMQ1DnpQfG0gMd1DzxDPKcq5x7arMl27CRFeJCq8ITNXWlrmB6cP9elVmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789881860; c=relaxed/simple;
	bh=YHpFXm3BdmMOu5qB2YWMcWIdl0uCUDvkWPPdnCAcHYU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eth2/SeDkHSsGME8TZo4+M2eKqKQ5EpkCvkRuC9bineqniSairCW76emY8AJE1k/AvgiHnAObHQmWmRMPOUBiWfIr4bfGPpvEp3RgwFcej5dcnC07fDO62M2WO514Rk4NM4Rav9h9gO78WwBmnpdRO35NuJP1r3ZCbsZRFAPQe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=krtgKqAY; arc=none smtp.client-ip=74.125.227.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="krtgKqAY"
Received: by mail-pj2-f16.google.com with SMTP id 98e67ed59e1d1-396ccd78e6eso781710a91.0
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 22:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789881856; x=1790486656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6AZqXXBg2RS43j2WFCTsa4SejcBWzqM0LEISLUYo0Tg=;
        b=krtgKqAYs1lSv3bMc36iCNxSzyMwbOoWQ1GmF6v1/K7kjlmXXc7XcUeOs9mMmFz1KX
         7gBJiy+SOeqxAEw0pZry6H4cV4874B4O7OCj8trzW95lMWlIH8vsbrrPNwhqbqs1xdXD
         g1IYx6DliwIvNQM+Bbb7Kgl9L8XDNC6IAY3bNYk3YH9edmN7nouewso1HyuvttolSbPE
         sYnRFZ7R182CdOagxfKCKi+heSt70Uk2Fdjz4zozN+bnCkQ55DAJqgHu6ihri4/4gOB4
         U8iIHLTkzYFJ1KTlX68jNafvIsfehp96A6cgWTU9OEMwNlFl+1AGd8Ux9YGdNUwH3t0J
         ESYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789881856; x=1790486656;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6AZqXXBg2RS43j2WFCTsa4SejcBWzqM0LEISLUYo0Tg=;
        b=HXW/zzJ9eqpQG9TnRYbDoBiArmpsS+S9JO9Yw9pihY2VlF0a2LrcOYKkagKR43j6z6
         FDM3wQmVonKyC9GJ75UJ9Qbn9p9hzymacEILhpdOBu/4shGEaNUYSy39ZTikTfgebidx
         S9f3K5lcvY+7wIobnjCX1eSyJ3KFOyybem8ZpkBiLZpg3fEZpj1siJtFnyDMeqvdpYVs
         XoUpG0/10zg5aBYKFRokVmbGabmZOtwjrNR7nv18FZcH8G83NpPAd+vqLgiSHT8RF/38
         hNYPZxbvD4EEggiSuSeFKC/RUg3JUi3ASTjH5wKGiaPeD0DHVg5VuJwbIqtpDSXdq3+T
         24aw==
X-Gm-Message-State: AFuF++l4jptoPt02fcPcKWY6GuDESJfqrKEwlBuLhIOjS+usP1zedzBM
	TwcaRXE+fgbhbwNZS6HvIDlBjUEDoBFcrEScTEI6/PRUrWYaC+5PnI8poXUDKw==
X-Gm-Gg: AYBFou01MdDYxb1TnzKvVsCzPq4Lnh6j+C5++0pSfQail3EEorfKzcZEqIUKmwPmI/E
	pBaim1UoC7dFnJJsQ2bV/vnjeamK7ZIkywHVujefnkgyorvofVA/gAxBKATReQHJ54eJI8CJiuu
	IObDF88g803P5x7tHP2r7E1LfrD0DiUMrXFu/cybsrWMoS2qLwAUbtIiQ7xaLtiKg/NirSb6gLw
	ymhOnaJFDbAJjIO+7ajub/G9hCLdcFwXQFrVsiveLl8XCbea2SvxTL9VfPpK0FYhL7xcAKZppKs
	1etZdGnTBxrLkiDvwy8H5hGOSOg7YKzd0k38dRGXF8w8rfX0lY/qw5Od0B9qIT4qBzjDhHBicCR
	QzWuTaRWvjlm0OlbBGGCv5ZgYQQMojVP7HGdpkMg2TK4dEKe0HvfUWtVEEFejIBXgXO/+q5kn39
	T/5CwMrskKEpkKu+oDg5Op9qMs6T+RXspH9GpgL5JDxcxfdrecNeeOQ+moL85ww+RzksDN1QBLI
	A==
X-Received: by 2002:a17:90b:2b8e:b0:39e:4c7e:bc5 with SMTP id 98e67ed59e1d1-39e5572d5a2mr7340787a91.19.1789881856415;
        Sat, 19 Sep 2026 22:24:16 -0700 (PDT)
Received: from fedora ([2406:3003:2000:232d:8687:63a8:d931:9b81])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6bd191aesm7733472a91.0.2026.09.19.22.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 22:24:15 -0700 (PDT)
From: Wong Boon Jhee <wongboonjhee52@gmail.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	wongboonjhee52@gmail.com
Subject: [PATCH v5] net/ncsi: Fix Use-After-Free in NCSI teardown using synchronize_rcu
Date: Sun, 20 Sep 2026 13:24:02 +0800
Message-ID: <20260920052402.435974-1-wongboonjhee52@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ncsi_remove_package() and ncsi_remove_channel() remove objects from
RCU-protected lists and free them immediately using kfree(). Concurrent
readers (such as Netlink dump handlers) traversing these lists may
access freed memory, resulting in a slab-use-after-free.

Instead of converting all frees to kfree_rcu() or adding complex
reference counting, this fix uses synchronize_rcu() and rcu_barrier()
in the teardown path (ncsi_unregister_dev). By stopping asynchronous
producers and waiting for all RCU readers to finish before destroying
the device tree, we ensure safe synchronous reclamation.

This approach is compact, avoids overhead on the fast path, and
resolves the race condition reported by KASAN.

Fixes: 2d283bdd079c ("net/ncsi: Resource management")
Signed-off-by: Wong Boon Jhee <wongboonjhee52@gmail.com>
---
v4 -> v5:
- Adopted maintainer's suggestion to use synchronize_rcu()/rcu_barrier()
  in ncsi_unregister_dev() for a compact teardown fix.
- Removed complex kref/dev_hold lifecycle changes.
- Simplified the patch to focus strictly on flushing readers during
  device unregistration.

 net/ncsi/ncsi-manage.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
index 54d0df0a9efe..3cda4b28480f 100644
--- a/net/ncsi/ncsi-manage.c
+++ b/net/ncsi/ncsi-manage.c
@@ -1956,19 +1956,33 @@ void ncsi_unregister_dev(struct ncsi_dev *nd)
 {
 	struct ncsi_dev_priv *ndp = TO_NCSI_DEV_PRIV(nd);
 	struct ncsi_package *np, *tmp;
+	struct ncsi_channel *nc;
 	unsigned long flags;
-
-	dev_remove_pack(&ndp->ptype);
-
-	list_for_each_entry_safe(np, tmp, &ndp->packages, node)
-		ncsi_remove_package(np);
+	int i;
 
 	spin_lock_irqsave(&ncsi_dev_lock, flags);
 	list_del_rcu(&ndp->node);
 	spin_unlock_irqrestore(&ncsi_dev_lock, flags);
 
+	dev_remove_pack(&ndp->ptype);
 	disable_work_sync(&ndp->work);
 
+	for (i = 0; i < ARRAY_SIZE(ndp->requests); i++) {
+		if (ndp->requests[i].enabled)
+			timer_delete_sync(&ndp->requests[i].timer);
+	}
+
+	list_for_each_entry(np, &ndp->packages, node) {
+		list_for_each_entry(nc, &np->channels, node)
+			ncsi_stop_channel_monitor(nc);
+	}
+
+	synchronize_rcu();
+	rcu_barrier();
+
+	list_for_each_entry_safe(np, tmp, &ndp->packages, node)
+		ncsi_remove_package(np);
+
 	kfree(ndp);
 }
 EXPORT_SYMBOL_GPL(ncsi_unregister_dev);
-- 
2.55.0

