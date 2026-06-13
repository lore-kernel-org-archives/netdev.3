Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317793A2572
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 20:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781381448; cv=none; b=IEjNuamdN957EJM0f19krpqg5Lm9UtFzenNl9HsGVW9EaeOw4GyX7Cag3sxZvUnVqKh+O1eAGAzv+XyzUOCMTXGrbIneq177RbJsjxfr5e60+HOQ+F1F2gj4RwVL78B54uoK5fJbxF9tkOUpJ+0haICg3UKJuh/TjJ7+5phQ6uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781381448; c=relaxed/simple;
	bh=x8LXk1Sd3z0hl2u/VwR9hVjdDj6ditCOiDC/qGh0xMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HGV0t41/5Qoe1IDC4bZMST8VP7KwYxctFrALBKEwGDM4uOmEYTh17nYh9pZ60ACyKpStNfay8alxwqgdroxsIVIZXwkI3h6v3OfnFyEJILOrcJV0mGVkvMfyyKpnJ5e0t1i53GUpqbXhqjSlPC9JrzwluLwiKdiWtxfqdAa5AX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VaRhxf46; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VaRhxf46"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89FFE1F00A3F;
	Sat, 13 Jun 2026 20:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781381447;
	bh=cCmQiRhDSYCQUJo9/sX7/16xgSXRVSkf5cnOyoNJVKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VaRhxf469man3PNwS1oepYD4ObTOVJLSipt3K8p8p++pla4Kd/AcJGVBg1xj1XoAH
	 2Q9t8Z6oBUDI6aaifRznlhuhmfZl8Gz6CTqvKk3Jub4z8nJ7npl5UCqsm3oILFf/i0
	 FCr6jFsNASSkCLZsXO4Lz8LIz8xnBD+vtUANEhjBU0UFv6pcVB61Su1pWeMs9nUri5
	 jgNYn7oXHgY5XR/NsQFnde77pL0IbMFhZ7Z8rIT8QV3erJAarC+YG3wEM2buCnHN2p
	 xWNNVRuCCRyrHlLd8HfyOHqPSmRkP8zoGlDEr+wshA5xZ+9J5Nw0BJCJjgQOz7YbSs
	 TaZAuu+J54EJg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	3chas3@gmail.com,
	mitch@sfgoth.com,
	linux-atm-general@lists.sourceforge.net,
	dwmw2@infradead.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 7/9] atm: remove the unused pre_send and send_bh device operations
Date: Sat, 13 Jun 2026 13:10:30 -0700
Message-ID: <20260613201032.77274-8-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260613201032.77274-1-kuba@kernel.org>
References: <20260613201032.77274-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

atmdev_ops::pre_send (a TX pre-processing hook) and ::send_bh (a
bottom-half capable send variant) have no implementation behind them:
no remaining ATM driver sets either, so vcc_sendmsg() always skipped
pre_send and the raw AAL0/AAL5 paths always fell back to ->send().
The drivers that used these hooks were removed with the legacy ATM
adapters.

Drop both operations and the dead branches that tested for them.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/linux/atmdev.h | 2 --
 net/atm/common.c       | 6 ------
 net/atm/raw.c          | 7 +------
 3 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/include/linux/atmdev.h b/include/linux/atmdev.h
index 218c05f2ec54..96ce36e02247 100644
--- a/include/linux/atmdev.h
+++ b/include/linux/atmdev.h
@@ -137,9 +137,7 @@ struct atmdev_ops { /* only send is required */
 	int (*compat_ioctl)(struct atm_dev *dev,unsigned int cmd,
 			    void __user *arg);
 #endif
-	int (*pre_send)(struct atm_vcc *vcc, struct sk_buff *skb);
 	int (*send)(struct atm_vcc *vcc,struct sk_buff *skb);
-	int (*send_bh)(struct atm_vcc *vcc, struct sk_buff *skb);
 	void (*phy_put)(struct atm_dev *dev,unsigned char value,
 	    unsigned long addr);
 	unsigned char (*phy_get)(struct atm_dev *dev,unsigned long addr);
diff --git a/net/atm/common.c b/net/atm/common.c
index 44a0179d4586..654cbe3c855e 100644
--- a/net/atm/common.c
+++ b/net/atm/common.c
@@ -626,12 +626,6 @@ int vcc_sendmsg(struct socket *sock, struct msghdr *m, size_t size)
 	if (eff != size)
 		memset(skb->data + size, 0, eff-size);
 
-	if (vcc->dev->ops->pre_send) {
-		error = vcc->dev->ops->pre_send(vcc, skb);
-		if (error)
-			goto free_skb;
-	}
-
 	error = vcc->dev->ops->send(vcc, skb);
 	error = error ? error : size;
 out:
diff --git a/net/atm/raw.c b/net/atm/raw.c
index 1d6ac7b0c4e5..87d136c7554b 100644
--- a/net/atm/raw.c
+++ b/net/atm/raw.c
@@ -54,8 +54,6 @@ static int atm_send_aal0(struct atm_vcc *vcc, struct sk_buff *skb)
 		kfree_skb(skb);
 		return -EADDRNOTAVAIL;
 	}
-	if (vcc->dev->ops->send_bh)
-		return vcc->dev->ops->send_bh(vcc, skb);
 	return vcc->dev->ops->send(vcc, skb);
 }
 
@@ -71,10 +69,7 @@ int atm_init_aal5(struct atm_vcc *vcc)
 {
 	vcc->push = atm_push_raw;
 	vcc->pop = atm_pop_raw;
-	if (vcc->dev->ops->send_bh)
-		vcc->send = vcc->dev->ops->send_bh;
-	else
-		vcc->send = vcc->dev->ops->send;
+	vcc->send = vcc->dev->ops->send;
 	return 0;
 }
 EXPORT_SYMBOL(atm_init_aal5);
-- 
2.54.0

