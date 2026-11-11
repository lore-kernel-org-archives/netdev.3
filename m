Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794362372;
	b=MZ7Xsdj1KKdpzR6q9JU2MSNVlPS1J3g+bu8bw3ZIoCpWDtwquBlHd9lryu3LpN+PT3+y
	 umujXKpPiS+HvBg7p7QgMdXsfRm6XLvgGwr0Xuofc3kEH7GZx3i/3tAJI0YV3PmsNcHyI
	 yAuU/zXy5sEUHqesBaij7y4p08gCR5uKo4jxfVNdUbAiDdO6LDMrTz+41g4iy/ZmU7B10
	 aCx/91QRr9/YlymDtCLnWbP+HDF4xJY7/fvabLydySH/wMVnWqgxA/5bH9ekIQkLa9j0w
	 4iQqhxfw/suJSlgaPhgR3UovNXk4XS5OzN/kEyOS7O+59A8AzgITkJ5eQB2vqBH9AIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794362372;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HhUr6++cEdzdu7aXmazmu5lx8Sa5k32R+7mO7JewGbg=;
	b=ECSDjIUPdHdwnJhq033sXaQ46XqfsSofIoXJ0jyWVOIiet2xvziVzIgynvKfLyAFNZvA
	 J2zb4gQNcWrHBnjvLWl0KwzdU6o3LZ4xcjsLCA7W3LXEqNLgDRyB8E3LlBgQk7DeJj1/g
	 +hOwg/jr5B3TpredYezCTON3i9wenX7Baie+NuEn2SOBfJPkIi8V6/73NBz8ArybgW0SP
	 SYQ3EHc9gAEZrc9udQFW/z9kLWLje+SmMJG8HmZmuL++HCxR8Msw838yTQdOH0P/mzizf
	 RlmHaV/7cRnejlRsAMMHj5ngmZDOjkzB4MJGoUgI9ajfDmtwmHzJZKHv6sGMH5TmV6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=aOdGraAv;
	arc=none smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DE7606A326
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 01:59:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1DE7606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=aOdGraAv
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c505186727fso184061466b.3
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 17:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1794362370; x=1794967170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HhUr6++cEdzdu7aXmazmu5lx8Sa5k32R+7mO7JewGbg=;
        b=aOdGraAvbilQamH/nwGdpN9DOpt0IvJwwUYwfP2vG0lFw2A4pCCfPdRRBIhH888i/6
         VknDBNGoqF5+zY+BDQfEY7HjWvblNOzeCZaqjaGF71YSNZKbWC1afWOCBL/pSzObD7/A
         EK8ll88LQwHE4597BFtvLckQs1U42IrRMvrSBupC6A96xw2MCBn9X5kjVOq6odZ0EvlH
         3jx1jIOx76ktQcvZO3fccMWavFXKW6BmOe5Zo07JSo1hwbHjtqrcES7GflQvFuL9vS9g
         /AB6OTtlyO5J0Via92/g2/KBs5VFRb7D5mF60eYRt9YL1NKuCi0Nksf0F59kAOMpHNEH
         TmTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794362370; x=1794967170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HhUr6++cEdzdu7aXmazmu5lx8Sa5k32R+7mO7JewGbg=;
        b=NXwGw1apidYy43Njtty6xxHjEnNDldjCUpKd/9bmsgFKDYwavgI/5hka62X+BQrtLQ
         suPIu6Wxl5JdIgx0+RPvB4tY9wi4ygwUOcBL3pPLsjPfYOaF5TezGxlH3FHBpQnMe4Ye
         sAo4Alpe+tl4t4iFEjYITuStzCJdquaEwvskNYHQboi8VD2hFO7exBwoAWyEWaCJFZ5R
         TW5qNyxntH+B1YI9eWv32JigAVXKtUHpZznjCQtsfZy37nDmMLLPuX9+aQOyj4GcVxG0
         X15p78q8V3sCIdhb5ktRr7A0x1wIHuk4IegebDo6/MWjnQ7qTIbqCwRG5+ST3I+lWF+n
         sSow==
X-Gm-Message-State: APuU4Z81MHWj/xnugRO1Y8tN2sJyXvyujPcF/kWkt41gs7slF7KDLd4a
	cwM4SAkDFvBywZXVUHOqIYcMUGX94Lrmli/8wDrJp5idj5DQO8rrPwBx8AljbDAmo4PRYW8eNZI
	AygP1E04=
X-Gm-Gg: AYBFou30/R7Q+nDbeBoKFKJzwXplVdyN2WekjkKNKaNOWYmIkaRWSVYEaqT2GkEQ+on
	2sSfR6b0i6mzvTfWj6D9XCNgqTC4tS2tRkhQ7wf5+dfmiR1poMuIDl8KdVZlON8seamXxDsHawL
	VysH0HsPXmbfUIYNgnj+0MGprRfPNyEib7prFgkp6iGsNDvjLtLMKGpXvyBJEuUMGe2HUWB3OmK
	tOKU6oR6QZhIeISMprV40SEFnn2csne25M35fxm5H2BAlLg52NoBnafqaExb14cN8ysKes0o2VV
	YGTuuNrGK67RHiOPbByLfyQOT36NckW55dHnS4XrsFTcoFN3IM51lDOtsqrJ2ndH7K8mfsmkxAw
	ajb0EitCbJQ2DXmLfFAAZYhI4Mwk3c0d51ZqLZ8cCGxNzSMMZoWgYXP5JW5/A8OwGi+MeoCf7Js
	NCNMyO6cuuI3pUlo2JAjIC2wZCmWpZ1o3efXQOzAmcxF8pmfqOA73gssrDywQnVwdvGxoLhSnoJ
	Zku3lPzyR9Rw34ODhMQKFJeFzjO57vW5t8cnrwQEfByHC/QRmlAQqQ7huvZRZIXO+QUJvmaMYl+
	bWMLRE133cAYEg4O/2JvK1drq2ZhoLZf3pAbzaKdqSDvqAC3VdcxdiUH8Q==
X-Received: by 2002:a17:906:9c86:b0:c50:5996:5b89 with SMTP id a640c23a62f3a-c5066b3aa67mr65463266b.23.1794362370268;
        Tue, 10 Nov 2026 17:59:30 -0800 (PST)
Received: from L9JK9NPFH9 ([104.28.20.58])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7834cdc23sm147498a12.12.2026.11.10.17.59.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Nov 2026 17:59:28 -0800 (PST)
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
	Tianyi Gao <tianyi@cloudflare.com>
Subject: [PATCH net-next v2 1/3] veth: refactor NAPI enable paths
Date: Wed, 11 Nov 2026 01:59:20 +0000
Message-ID: <20261111015922.67745-2-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261111015922.67745-1-tianyi@cloudflare.com>
References: <20261111015922.67745-1-tianyi@cloudflare.com>
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
index 0539b3661793..f5097696df15 100644
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

