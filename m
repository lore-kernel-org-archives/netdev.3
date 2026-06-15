Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E0E3B442B
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 19:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781552666; cv=none; b=pVfary0dMnWYN0X59FtBJMTvTVhLt6BPgdZ9Fuizx80lFlNGoHO7r8JEb6n+6c2fZCyWRRR0hsSOnidQhIMwxoAaI/OS0tMmmPd5h4H1nva4Su5X9/5s2fvli3JK5GrvBRteD0EkcxiYaRxYlHbeBoYicPgjZx0C2JQnXdDYu8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781552666; c=relaxed/simple;
	bh=x8LXk1Sd3z0hl2u/VwR9hVjdDj6ditCOiDC/qGh0xMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hy80CwHXZasGg/SHBG7oPlDayrRoSkkYtRhm0fOIxUoE8gO8NdcPolEjPZQ5bqX185NhkX66Vio+oGaE2uwViiVyCW0zlKNF1SqB1GoaRi0KJI6+TFF8dxauM834KbCrSpu6QmQHOJpPOO2n2+9ro4gr+mS6R9kiZLqmlknWijE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tf9p7AKW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tf9p7AKW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B4C11F00A3F;
	Mon, 15 Jun 2026 19:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781552664;
	bh=cCmQiRhDSYCQUJo9/sX7/16xgSXRVSkf5cnOyoNJVKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Tf9p7AKW8L5sqiKUrx0lGO0S5Llnb4OLSHpTwYTRXoXsRvEquis+ej6e9Owd1T/Gt
	 MDFRmUf2/AvyHwBF/wE39rY5eHlt0nZpMo71SesJS2GTuea6tq2yW4AU15vqkjQE4z
	 UdI1ePxgr4VCyHMEd2mGM0GXitKZzea91+L9KGD9vA8w4YxvXfulfdXMOI3B+XMcu0
	 tnE1Kz6RTTSU9ln/vya+8RywdtuiglMQoqXhUM8n64MpUDExgq/q84X/N+WXkGn7oC
	 Rguaaq93GnbxtLGLfvbs4lYGmMAFVOJ2sG+I5kpQlwV4260rsKjyHFLc8Ij0Kmw8xR
	 aydfRMU8faizw==
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
Subject: [PATCH net-next v2 7/9] atm: remove the unused pre_send and send_bh device operations
Date: Mon, 15 Jun 2026 12:44:14 -0700
Message-ID: <20260615194416.752559-8-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615194416.752559-1-kuba@kernel.org>
References: <20260615194416.752559-1-kuba@kernel.org>
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

