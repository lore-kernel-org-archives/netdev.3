Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327753793DE
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 01:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788485680; cv=none; b=YQ8jI5rUOPAPzbnrudg3Vc1OlYl6Lrvfl6M2AJl5hNYaiXQLTIEAGO3COXSyw1p1ebBYyx/1NxqE3P13Si1wfuuqyvfxyOCJynUHZveG3vuq0xxjsWo7NiEeKmPagXuG9Vse2L4y+XO+D7QHYt8hBBJlAtiiRjeERmUK9IxG5ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788485680; c=relaxed/simple;
	bh=OXLSqoh1FDwPOdeniUjIOxy7ztUXSmy1LVFgVaxlxXg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RtJleqbg772NdRzoXJhQ+qJqOJLd1Amz1Aia35DdfcJhM2CEj2rzb4gjvEzR99FGnEOTIXJLrYc5znHgdqXXlIaOQzV9PEd0x5ocbzr85qxt83+MQdM/bl/O2rf8evzQIXZ4wTMs2MYyoMl2YGVnK+67nOzptYQmVemfL9qS6VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J4IgwnWi; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4IgwnWi"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-4a483a552efso225723b6e.1
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 18:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788485666; x=1789090466; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1nYD/5QHvA/tTrz7YkNk4zOJKjnO4i+yX0Rf8b9DSJo=;
        b=J4IgwnWioUpCnRdEiiO2BuZOl2rYWIGpSrHvWcJs5oMEjWI54OY84H5TVo+iVi95sx
         udYYOC+8mqcDV3cSLYyx3IFR4g3ZQYC3zghbGT+1PuwAY2kBlCVllgXY0dk0ghk+kGjX
         WHgjYIemkPYAMeuLjxVoQFQffkkqiLsuCcBJEx+71oc9dOBHTLvUNMZpaerJyVEVIXU2
         snc/HPHqbLdOmTKxjW4qJ2SnrgKBm7+oAymIf07ELmXslManVm7tmne0Tv6X+mrzmYeS
         6743tNaa2BbJ3jNdgduWdXLoP4xqpEPpNanBQn/06zsNOzV47wfIS+FYtgBEnzZKPM9S
         xtxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788485666; x=1789090466;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1nYD/5QHvA/tTrz7YkNk4zOJKjnO4i+yX0Rf8b9DSJo=;
        b=EDZIL8bvcXM0cUzd+0snW858ZmkRwgpPlZkxlGRBKj6+yABXqo1DAZRUMxedpmdd9C
         yzB0V2dK5aQ8l3qhe0O+no9e9rogZe4xGiyeznLt17ZnpBmGRbKHsOhNZrh73uQx8OCy
         tmHwObPL2HM9I5oIzoej7TZ+s2+w9jkhkJVlfq30cMLDd4llqRHZezFLU0A/1VUPu1J8
         3ykhmUBsIp0BTgqyEdeTFZWpS5wuEU8odzefImbLCjrK59KCa15GYxYoYmHKC6ZFJfDt
         nhXz8fDrx++5n0P6+gDIMXRy48cPDgfSbAJFOuA94OT2yIWF8IRCtknKU/f4TMRypUgi
         a1sg==
X-Gm-Message-State: AFuF++nO/G6/YRjHSmQ2xEi2yYSZOfxWg8whO8r7RTKcWb/ngzj8lsVa
	6ZJDOOtlGa4cenkuDY6hOi8+CuzlZMiKkXdvyu3QdFGVPYIIpbLyP+29qRMgEKxG
X-Gm-Gg: AYBFou3hq06h5oy9MkhcRAGv/1J5WlIEuVyWOWad61vLjaM5RZlYgJgvz7i6dI1xVzs
	ymdddXn6JT7XuI66EmziCHKI5wCkIBq3pc/f84NtLVqr9bgSLQlw22QV4Yunavw/ZeN6BqSYePJ
	NFVVZjwXIak2IWI7byouklTQ1tetCHOI0EiV2ggiGZV7PMVlzmU3SN9GoPcOsjRbIb4rWtAj+GH
	cpylU2aHQEprBOra5YPcfx84Z69YNTRjPruyjz8ZVTDTKTK0iRVNZJeBrMF856kSSTRwDRlxjRF
	jm/1IUQBAIyNOuvZZ31HHRUv8g/iPsS3kLSPZNXIWYA0HYZ9BUcR/Zop7earguMLnqP4PxZQvA2
	vJeEDoYZavByUuEcwEI7TqLmUtPk7huaq6vaf9t0JJsdvVgtDwm8lC5wa7qqxCYDTBLnAFmTaOp
	9/VOS4qK+nzBRSouMfw9eTmiBgDolcFPYDL0HxJti1o+ZEHDWaN1R33Ew+
X-Received: by 2002:a05:6808:50a9:b0:4ae:f5be:fe29 with SMTP id 5614622812f47-4b965050305mr2252385b6e.5.1788485665945;
        Thu, 03 Sep 2026 18:34:25 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:9::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b97124b081sm1058916b6e.9.2026.09.03.18.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 18:34:25 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Thu, 03 Sep 2026 18:34:02 -0700
Subject: [PATCH net-next 4/4] netdevsim: psp: drop tx key ops
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-psp-prep-v1-4-d47e9c4c375d@gmail.com>
References: <20260903-psp-prep-v1-0-d47e9c4c375d@gmail.com>
In-Reply-To: <20260903-psp-prep-v1-0-d47e9c4c375d@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0

netdevsim has no SADB. The usage of psp_assoc_drv_data() was always
obsolete given psp_validate_xmit(), so we can remove nsim_assoc_add()
and nsim_assoc_del(). netdevsim::assoc_cnt can also be removed. PSP core
can track the balance of tx_key_add vs tx_key_del calls in a future
change.

Delete psp_assoc_drv_data() because there are no more callers left in
the tree. mlx5 accesses pas->drv_data directly.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 drivers/net/netdevsim/netdevsim.h |  1 -
 drivers/net/netdevsim/psp.c       | 33 ---------------------------------
 include/net/psp/functions.h       |  5 -----
 3 files changed, 39 deletions(-)

diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index 55aec41237b9..181b6baaba7a 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -122,7 +122,6 @@ struct netdevsim {
 		struct dentry *rereg;
 		struct mutex rereg_lock;
 		u32 spi;
-		u32 assoc_cnt;
 	} psp;
 
 	struct nsim_bus_dev *nsim_bus_dev;
diff --git a/drivers/net/netdevsim/psp.c b/drivers/net/netdevsim/psp.c
index 6b3532b5e360..b7452c49b581 100644
--- a/drivers/net/netdevsim/psp.c
+++ b/drivers/net/netdevsim/psp.c
@@ -23,7 +23,6 @@ nsim_do_psp(struct sk_buff *skb, struct netdevsim *ns,
 	struct psp_assoc *pas;
 	struct net *net;
 	int psp_len;
-	void **ptr;
 
 	rcu_read_lock();
 	pas = psp_skb_get_assoc_rcu(skb);
@@ -37,12 +36,6 @@ nsim_do_psp(struct sk_buff *skb, struct netdevsim *ns,
 		goto out_unlock;
 	}
 
-	ptr = psp_assoc_drv_data(pas);
-	if (*ptr != ns) {
-		rc = SKB_DROP_REASON_PSP_OUTPUT;
-		goto out_unlock;
-	}
-
 	net = sock_net(skb->sk);
 	if (!psp_dev_encapsulate(net, skb, pas->tx.spi, pas->version, 0)) {
 		rc = SKB_DROP_REASON_PSP_OUTPUT;
@@ -149,19 +142,6 @@ nsim_rx_spi_alloc(struct psp_dev *psd, u32 version,
 	return 0;
 }
 
-static int nsim_assoc_add(struct psp_dev *psd, struct psp_assoc *pas,
-			  struct netlink_ext_ack *extack)
-{
-	struct netdevsim *ns = psd->drv_priv;
-	void **ptr = psp_assoc_drv_data(pas);
-
-	/* Copy drv_priv from psd to assoc */
-	*ptr = psd->drv_priv;
-	ns->psp.assoc_cnt++;
-
-	return 0;
-}
-
 static int nsim_key_rotate(struct psp_dev *psd, struct netlink_ext_ack *extack)
 {
 	struct netdevsim *ns = psd->drv_priv;
@@ -177,15 +157,6 @@ static int nsim_key_rotate(struct psp_dev *psd, struct netlink_ext_ack *extack)
 	return 0;
 }
 
-static void nsim_assoc_del(struct psp_dev *psd, struct psp_assoc *pas)
-{
-	struct netdevsim *ns = psd->drv_priv;
-	void **ptr = psp_assoc_drv_data(pas);
-
-	*ptr = NULL;
-	ns->psp.assoc_cnt--;
-}
-
 static void nsim_get_stats(struct psp_dev *psd, struct psp_dev_stats *stats)
 {
 	struct netdevsim *ns = psd->drv_priv;
@@ -204,8 +175,6 @@ static void nsim_get_stats(struct psp_dev *psd, struct psp_dev_stats *stats)
 static struct psp_dev_ops nsim_psp_ops = {
 	.set_config	= nsim_psp_set_config,
 	.rx_spi_alloc	= nsim_rx_spi_alloc,
-	.tx_key_add	= nsim_assoc_add,
-	.tx_key_del	= nsim_assoc_del,
 	.key_rotate	= nsim_key_rotate,
 	.get_stats	= nsim_get_stats,
 };
@@ -215,7 +184,6 @@ static struct psp_dev_caps nsim_psp_caps = {
 		    1 << PSP_VERSION_HDR0_AES_GMAC_128 |
 		    1 << PSP_VERSION_HDR0_AES_GCM_256 |
 		    1 << PSP_VERSION_HDR0_AES_GMAC_256,
-	.assoc_drv_spc = sizeof(void *),
 };
 
 static void __nsim_psp_uninit(struct netdevsim *ns, bool teardown)
@@ -230,7 +198,6 @@ static void __nsim_psp_uninit(struct netdevsim *ns, bool teardown)
 		synchronize_rcu();
 		psp_dev_unregister(psd);
 	}
-	WARN_ON(ns->psp.assoc_cnt);
 }
 
 void nsim_psp_uninit(struct netdevsim *ns)
diff --git a/include/net/psp/functions.h b/include/net/psp/functions.h
index c5c23a54774e..b23c30898389 100644
--- a/include/net/psp/functions.h
+++ b/include/net/psp/functions.h
@@ -24,11 +24,6 @@ int psp_dev_rcv(struct sk_buff *skb, u16 dev_id, u8 generation, bool strip_icv);
 /* Kernel-facing API */
 void psp_assoc_put(struct psp_assoc *pas);
 
-static inline void *psp_assoc_drv_data(struct psp_assoc *pas)
-{
-	return pas->drv_data;
-}
-
 #if IS_ENABLED(CONFIG_INET_PSP)
 unsigned int psp_key_size(u32 version);
 void psp_sk_assoc_free(struct sock *sk);

-- 
2.52.0

