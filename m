Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793889243;
	b=xj/HqaFRhyDXjFlAON75AxZ/6Yy3CjUrJI7OueicaO41jyW1XYktsDvgcfUoTSmpivHX
	 GG+L7DlpeVSzVYZLZCSK35KtcyOgVomgmY21v6G8r9fGOUv/qpZg2bbGcmbnwPL2IfsAB
	 3xN8BrFdV55S9quFhEVebhwJD95mRPc4JyzqCqvk40YN/nBy/UhlaExHIKDhifOqfVG4x
	 NSmqyrP/lRhRCmwSeXLXSZKwtHWlky0GOcxXD5Py+69viC92dHk+RxhQbPWuALmzUH3l+
	 kGgJ1pHY1JBnlVwqlpUigA2+15TQ+OqR1XNhGRNivqa4rpl6laZt4LjaQ6cXYylJFLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793889243;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=wz/ix5Uo89HO73J7bY7HZ3fOfadWMH/9uupcr6IydS8=;
	b=GcCfg8icxZv41c7pyt07oP4v+QjiuyCQHiHOx57cZiTdAFsYgrQFFdhe5quaoGN+1Oxm
	 rWbEJ8s1RZO2WESUzrZeq9raoKiaHstlXJjDDGfAjwkaZFdyJcLWdx4D40B0yUcvAh5WW
	 Rzi4rhYfbCOfKgELCbn3jscBiE3XeIphaJGU0kXD6aaRV7IQdBuWpARo3+nNfmnF63pqz
	 RRDUt3lRURFyaYNLi64Mg6/cq78ixq/pr7OSUAUNi4PstDL3Bjfm3p8RbAjJEZsrwK0pj
	 dTr9zkhP16PACi9KuvxQeu5CJHwdzv81aBelwUYv1cllsXLqemJs1d7Ul3lMJf34szg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=VXGLCUVz;
	arc=none smtp.remote-ip=209.85.218.41
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E9B606A334
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 14:34:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4E9B606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=VXGLCUVz
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c423b145922so281741466b.3
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 06:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1793889241; x=1794494041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wz/ix5Uo89HO73J7bY7HZ3fOfadWMH/9uupcr6IydS8=;
        b=VXGLCUVztGjNQNZD3dHhjtoymGsahDN8W+I3zABl21E8xfdttWMFQZIabkTnfAKmgp
         q+xPoLMrDfyouxts3DNeJyXdC0DClGNQp3t+8BD/ShuoRPxVupFzJ24SNT23U3zx4PJZ
         erWhPI9VF5f+i07c2MMEImwRo/TAeAJ2gmZry4oT/S9aM4BEhXHzhHFmEYzhnLXCof4N
         dbRfw+W8Wsno7Scar8il00nUmlrS7g6AYW1eBHUCgjaKqUhBlF/zzxz0IizvWxtWU9EN
         H+/IusFona6FRgKMCmEfuGzfPXos0dwopXk9qZry6WY1egPspcUEil/3uL3BsqN8kSFx
         ZG9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793889241; x=1794494041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wz/ix5Uo89HO73J7bY7HZ3fOfadWMH/9uupcr6IydS8=;
        b=r8JA+pj/w9fSU4tZdCJ8aCjIL4LD8u4hndSYCYOapES8ZWaapfiyq5xdOXOVmT7jST
         7h1qq8uboxTFwkKDpkUEZmMNQ2I9Q6ltzcHzeNpEqYUzvXGBVpxx6XJHYzm0SjvJR+b8
         VXHpjWLQbFCEsMVMAGzvIL5UZ8eOdOCpgFLyrVCJ4tNRPQDHGtTtJ+XdnmvpRXk/kAB7
         WlBhTrkIZNhnvL051oramfA4n794swYuuHshNfB9I0u3j9lGiGbTJPPrNjQUWy7sfrfe
         DoDVU+uDEqeo9F0U7SuqBVXbCIWRLsjxTMn/+Ivv4xAg/3Z2/lymul4t45ZZtxpfwyIU
         BW/g==
X-Gm-Message-State: APuU4Z+R/9R63jZjgxnFSLTOy1HXpji8Y3vGt9JYRndVdE7NzWJj3Byq
	ww5ccJKhNmw8Yr0zH67qOEMuUueXTf4q+Mxr3Z314XRYbcaKOMqtT7RLT9HW2kuxnLKkeLdGVAe
	oK+NQqmwl8g==
X-Gm-Gg: AYBFou012OOqdruzQQOvROt1KraFXqYIaJhvxdU7U3a2+SXshRL+ohOyKzvslpXmUwO
	l8LLk6/w+ue95OcNuWEt2Py8V6fNnE4JRrvA0qZrwP2QIp2I4eGql0aVn2iJqnYB7bL+ncyGhir
	84VGu6IHk0CcT6KAKpqfc7tThMmw7MaW3ZG2VQ0MgtBPLKo9nLbqqMB/V2vtMJYI6x6dhVz3dkX
	JHrIT01w/iWalyMxMx1SS3ssk3xgvHiCKncboDqFRcs9bFjBlnIBuha2uzstvDp5hWjLE0zTUxg
	pCy0UR+A4cNSj8od8IsbpNc4FAUQCJpRC0hWe/mhj57AopStPkzc/0fATjqU11KC1YZH/9d0oQg
	ZLRSPMxHElJibfOEkJadqEcEzEODC7VmZNvnw4lM1ssEw7x3hyt02jd7DxSS6NzPxfeSlY56IkS
	azSYwOrdP3bZEPUqUdKzDjsVRYZzjQa4Ccd/fJegooIdrqXzuPZPgnG05vG838lMiCb6W/UPs6J
	d/JK3e9ckqAVxXek6l11Y3u0bO6fkjNea32hWtpKGfhs7x8z/zhqcqdkt4bmJUBGR2t3MACGOSa
	02MrRvyiC5bIlB9XcToBsqqM35gszC9O+xv1Cg9DaKXh9KE=
X-Received: by 2002:a17:907:1c9e:b0:c48:a838:c16d with SMTP id a640c23a62f3a-c4cebc73337mr856063866b.30.1793889241197;
        Thu, 05 Nov 2026 06:34:01 -0800 (PST)
Received: from L9JK9NPFH9 ([2a09:bac6:37ad:1e5a::306:b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d0e466be0sm178671066b.54.2026.11.05.06.34.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 05 Nov 2026 06:34:00 -0800 (PST)
From: Tianyi Gao <tianyi@cloudflare.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	toke@redhat.com,
	lorenzo@kernel.org,
	horms@kernel.org,
	bpf@vger.kernel.org,
	shuah@kernel.org,
	hawk@kernel.org,
	kernel-team@cloudflare.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	linux-kselftest@vger.kernel.org,
	jiayuan.chen@linux.dev,
	Tianyi Gao <tianyi@cloudflare.com>
Subject: [PATCH net-next 1/3] veth: refactor NAPI enable paths
Date: Thu,  5 Nov 2026 14:33:54 +0000
Message-ID: <20261105143356.17062-2-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105143356.17062-1-tianyi@cloudflare.com>
References: <20261105143356.17062-1-tianyi@cloudflare.com>
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

veth_enable_xdp_range() adds the NAPI instances itself, only to pass
rq->xdp_napi.napi_id as the napi_id argument of xdp_rxq_info_reg(). That
argument is unused in __xdp_rxq_info_reg() since commit 5ef44b3cb43b
("xsk: Bring back busy polling support"). Pass 0 instead, as ena, bnxt
and fec already do.

veth_enable_xdp_range() then no longer needs the NAPI instances. Move
netif_napi_add() from it and from veth_napi_enable_range() into
__veth_napi_enable_range(). Add each instance in the loop that enables
it, after the allocations that can fail. Drop the napi_already_on and
delete_napi arguments.

veth_napi_enable_range() and veth_napi_enable() are then trivial
wrappers. Remove them, and rename __veth_napi_enable_range() and
__veth_napi_enable() to veth_napi_enable_range() and veth_napi_enable().

Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
---
 drivers/net/veth.c | 80 +++++++++++-----------------------------------
 1 file changed, 18 insertions(+), 62 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 3eca92d3dc60..a3570547ee99 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1037,7 +1037,7 @@ static int veth_create_page_pool(struct veth_rq *rq)
 	return 0;
 }
 
-static int __veth_napi_enable_range(struct net_device *dev, int start, int end)
+static int veth_napi_enable_range(struct net_device *dev, int start, int end)
 {
 	struct veth_priv *priv = netdev_priv(dev);
 	int err, i;
@@ -1059,6 +1059,7 @@ static int __veth_napi_enable_range(struct net_device *dev, int start, int end)
 	for (i = start; i < end; i++) {
 		struct veth_rq *rq = &priv->rq[i];
 
+		netif_napi_add(dev, &rq->xdp_napi, veth_poll);
 		rcu_assign_pointer(rq->xdp_prog, priv->_xdp_prog);
 		napi_enable(&rq->xdp_napi);
 		rcu_assign_pointer(priv->rq[i].napi, &priv->rq[i].xdp_napi);
@@ -1079,9 +1080,9 @@ static int __veth_napi_enable_range(struct net_device *dev, int start, int end)
 	return err;
 }
 
-static int __veth_napi_enable(struct net_device *dev)
+static int veth_napi_enable(struct net_device *dev)
 {
-	return __veth_napi_enable_range(dev, 0, dev->real_num_rx_queues);
+	return veth_napi_enable_range(dev, 0, dev->real_num_rx_queues);
 }
 
 static void veth_napi_del_range(struct net_device *dev, int start, int end)
@@ -1122,8 +1123,7 @@ static bool veth_gro_requested(const struct net_device *dev)
 	return !!(dev->wanted_features & NETIF_F_GRO);
 }
 
-static int veth_enable_xdp_range(struct net_device *dev, int start, int end,
-				 bool napi_already_on)
+static int veth_enable_xdp_range(struct net_device *dev, int start, int end)
 {
 	struct veth_priv *priv = netdev_priv(dev);
 	int err, i;
@@ -1131,9 +1131,7 @@ static int veth_enable_xdp_range(struct net_device *dev, int start, int end,
 	for (i = start; i < end; i++) {
 		struct veth_rq *rq = &priv->rq[i];
 
-		if (!napi_already_on)
-			netif_napi_add(dev, &rq->xdp_napi, veth_poll);
-		err = xdp_rxq_info_reg(&rq->xdp_rxq, dev, i, rq->xdp_napi.napi_id);
+		err = xdp_rxq_info_reg(&rq->xdp_rxq, dev, i, 0);
 		if (err < 0)
 			goto err_rxq_reg;
 
@@ -1151,21 +1149,13 @@ static int veth_enable_xdp_range(struct net_device *dev, int start, int end,
 err_reg_mem:
 	xdp_rxq_info_unreg(&priv->rq[i].xdp_rxq);
 err_rxq_reg:
-	if (!napi_already_on)
-		netif_napi_del(&priv->rq[i].xdp_napi);
-	for (i--; i >= start; i--) {
-		struct veth_rq *rq = &priv->rq[i];
-
-		xdp_rxq_info_unreg(&rq->xdp_rxq);
-		if (!napi_already_on)
-			netif_napi_del(&rq->xdp_napi);
-	}
+	for (i--; i >= start; i--)
+		xdp_rxq_info_unreg(&priv->rq[i].xdp_rxq);
 
 	return err;
 }
 
-static void veth_disable_xdp_range(struct net_device *dev, int start, int end,
-				   bool delete_napi)
+static void veth_disable_xdp_range(struct net_device *dev, int start, int end)
 {
 	struct veth_priv *priv = netdev_priv(dev);
 	int i;
@@ -1175,9 +1165,6 @@ static void veth_disable_xdp_range(struct net_device *dev, int start, int end,
 
 		rq->xdp_rxq.mem = rq->xdp_mem;
 		xdp_rxq_info_unreg(&rq->xdp_rxq);
-
-		if (delete_napi)
-			netif_napi_del(&rq->xdp_napi);
 	}
 }
 
@@ -1188,14 +1175,15 @@ static int veth_enable_xdp(struct net_device *dev)
 	int err, i;
 
 	if (!xdp_rxq_info_is_reg(&priv->rq[0].xdp_rxq)) {
-		err = veth_enable_xdp_range(dev, 0, dev->real_num_rx_queues, napi_already_on);
+		err = veth_enable_xdp_range(dev, 0, dev->real_num_rx_queues);
 		if (err)
 			return err;
 
 		if (!napi_already_on) {
-			err = __veth_napi_enable(dev);
+			err = veth_napi_enable(dev);
 			if (err) {
-				veth_disable_xdp_range(dev, 0, dev->real_num_rx_queues, true);
+				veth_disable_xdp_range(dev, 0,
+						       dev->real_num_rx_queues);
 				return err;
 			}
 		}
@@ -1220,35 +1208,7 @@ static void veth_disable_xdp(struct net_device *dev)
 	if (!netif_running(dev) || !veth_gro_requested(dev))
 		veth_napi_del(dev);
 
-	veth_disable_xdp_range(dev, 0, dev->real_num_rx_queues, false);
-}
-
-static int veth_napi_enable_range(struct net_device *dev, int start, int end)
-{
-	struct veth_priv *priv = netdev_priv(dev);
-	int err, i;
-
-	for (i = start; i < end; i++) {
-		struct veth_rq *rq = &priv->rq[i];
-
-		netif_napi_add(dev, &rq->xdp_napi, veth_poll);
-	}
-
-	err = __veth_napi_enable_range(dev, start, end);
-	if (err) {
-		for (i = start; i < end; i++) {
-			struct veth_rq *rq = &priv->rq[i];
-
-			netif_napi_del(&rq->xdp_napi);
-		}
-		return err;
-	}
-	return err;
-}
-
-static int veth_napi_enable(struct net_device *dev)
-{
-	return veth_napi_enable_range(dev, 0, dev->real_num_rx_queues);
+	veth_disable_xdp_range(dev, 0, dev->real_num_rx_queues);
 }
 
 static void veth_disable_range_safe(struct net_device *dev, int start, int end)
@@ -1260,7 +1220,7 @@ static void veth_disable_range_safe(struct net_device *dev, int start, int end)
 
 	if (priv->_xdp_prog) {
 		veth_napi_del_range(dev, start, end);
-		veth_disable_xdp_range(dev, start, end, false);
+		veth_disable_xdp_range(dev, start, end);
 	} else if (veth_gro_requested(dev)) {
 		veth_napi_del_range(dev, start, end);
 	}
@@ -1275,17 +1235,13 @@ static int veth_enable_range_safe(struct net_device *dev, int start, int end)
 		return 0;
 
 	if (priv->_xdp_prog) {
-		/* these channels are freshly initialized, napi is not on there even
-		 * when GRO is requeste
-		 */
-		err = veth_enable_xdp_range(dev, start, end, false);
+		err = veth_enable_xdp_range(dev, start, end);
 		if (err)
 			return err;
 
-		err = __veth_napi_enable_range(dev, start, end);
+		err = veth_napi_enable_range(dev, start, end);
 		if (err) {
-			/* on error always delete the newly added napis */
-			veth_disable_xdp_range(dev, start, end, true);
+			veth_disable_xdp_range(dev, start, end);
 			return err;
 		}
 	} else if (veth_gro_requested(dev)) {
-- 
2.56.0

