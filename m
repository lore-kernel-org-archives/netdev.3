Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793955992;
	b=Go8Z3ezgXlwFvPRn9+zlDWVPg9rWmkltLKFUAAj0O/k9W3lqKGParNfYHx1y4+EkOPgz
	 W4AKjYc3GlTWE+7InIO5nUEu3k8YTOYE4bkMKRdBWIO104ZVoSQ0BZSnOYX0iJ/plo193
	 jGbVEPmHxt5ptXUlPVXMacyyarhKWrl65q+ILe1LOycx16ZeMtehThemqgiGENweHc1g9
	 XRygLU7xlNvWeGJdN/NXhE2FtEtMSoHhRZH/a6hhnhiaaHrCyOjs4C3vM+z0IwBnfX6UH
	 e2AbuU386ujjStAYuqIABbTXvWG0FfbjtI7cqLNVLF0f1wVZwvhNngQk7Y6Eg5yQZIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793955992;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=bwf4WuvizE5NsoXFdTXjETdYXegFLEL7OxtAZ9dSDUQ=;
	b=Ymr1rsnEWVjpY9d84chv0cXJzgvlhkU7bDOyTKR9gu+SXQCUL0uBW8QV67559uZb+yQc
	 1QgV4NdKXskfppTaF+1eYRryu6B2gONpuRcjrtPU8GoHENZFdNGgfcdWgZOuxJalXVdbz
	 AXtEpjZQJxWJv136fPQ6g7Pnj103nw55rXpPmac8bhLcnQN2gYT4FBk6WUh42maSQCrQQ
	 vA8qJm+Q0qRbmGHwnN3INv2eprPPzwzb46eIxNXXCyiXjltpjg5JzZORJWW4flG7jl9Mc
	 Bar21ft9ZO5DOrYS3oelGkw80yAWybI9PjSIdb22AWFvcPhA5Cjj+p5Tqngne826Pyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=kyglw+F8;
	arc=none smtp.remote-ip=117.135.210.4
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA3E606A32C;
	Fri,  6 Nov 2026 09:06:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EEA3E606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=kyglw+F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=bw
	f4WuvizE5NsoXFdTXjETdYXegFLEL7OxtAZ9dSDUQ=; b=kyglw+F8c6U2dR9nR/
	TJ+SZbUbXPJ9U5a23zV6pIlJ0yjFvDn7+sjKvzxcJGDK3poiWwtzRCreEHkTRJcb
	BWiGHh3KEah03YR8nneUaZMA84LU9qSmnpuAoBnn0HaNc7cpzHYSPLsmCRUbEsXw
	r2gETqDP6tW/jz/278+iM+Q/w=
Received: from 4CV529F122.company.local (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3_7hJmO1qqwdQFQ--.15084S5;
	Fri, 06 Nov 2026 17:05:38 +0800 (CST)
From: Ding Hui <dinghui1111@163.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org (open list:STMMAC ETHERNET DRIVER),
	linux-stm32@st-md-mailman.stormreply.com (moderated list:ARM/STM32 ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/STM32 ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Cc: dinghui@lixiang.com,
	xiasanbo@lixiang.com,
	yangchen11@lixiang.com,
	liuxuanjun@lixiang.com
Subject: [PATCH net-next v6 RESEND 3/4] net: stmmac: release descriptor resources through priv->dma_conf on open failure
Date: Fri,  6 Nov 2026 17:05:05 +0800
Message-Id: <20261106090507.1020751-4-dinghui1111@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261106090507.1020751-1-dinghui1111@163.com>
References: <20261106090507.1020751-1-dinghui1111@163.com>
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
X-CM-TRANSID:_____wD3_7hJmO1qqwdQFQ--.15084S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxGry7Cr45ur1kZw1kZryUAwb_yoW5uFykpr
	Wxua98JryDArn3Jws8Ar4UXFyFyaySyF45Gw1xJ3yfAay5WrZIqrWYqryjvF1UCFWFvw1S
	qrWYyryUC3WDXF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jNnYcUUUUU=
X-CM-SenderInfo: pglqwx1xlriiqr6rljoofrz/xtbC8wJUgGrtmGJtJAAA3R

From: Ding Hui <dinghui@lixiang.com>

__stmmac_open() copies the temporary dma_conf passed by its callers
into the long-lived priv->dma_conf before setting up the hardware.
When the open fails after this copy, the descriptor resources now
belong to priv->dma_conf, but the error path returns without
releasing them and leaves stale pointers behind. The callers then
free the already-copied resources through the temporary dma_conf,
which aliases priv->dma_conf after the memcpy.

Fix this by making __stmmac_open() release the descriptor resources
through priv->dma_conf on failure. Callers of __stmmac_open() only
need to free the temporary dma_conf container in that case, while
failures before the call (PHY setup, serdes power up) still release
the resources through the temporary dma_conf via the existing
err_dma_resources path in stmmac_open().

stmmac_open() no longer jumps to the serdes label chain after
__stmmac_open() fails, as that chain would double-release the
descriptor resources and double-put the runtime PM reference, so the
cleanup is done inline instead.

The resource release is merged with the error unwinding that stops
the DMA engines and the MAC: failures after the hardware setup
first stop the DMA engines and the MAC, and then fall through to
the common init_error label that releases the descriptor resources,
while a stmmac_hw_setup() failure jumps to init_error directly as
the engines were never started.

Signed-off-by: Ding Hui <dinghui@lixiang.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c    | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index a8401b04d79f..b093119e752f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4246,7 +4246,7 @@ static int __stmmac_open(struct net_device *dev,
 	ret = stmmac_hw_setup(dev);
 	if (ret < 0) {
 		netdev_err(priv->dev, "%s: Hw setup failed\n", __func__);
-		return ret;
+		goto init_error;
 	}
 
 	ret = stmmac_setup_ptp(priv);
@@ -4282,6 +4282,8 @@ static int __stmmac_open(struct net_device *dev,
 	stmmac_stop_all_dma(priv);
 	stmmac_mac_set(priv, priv->ioaddr, false);
 
+init_error:
+	free_dma_desc_resources(priv, &priv->dma_conf);
 	return ret;
 }
 
@@ -4314,8 +4316,13 @@ static int stmmac_open(struct net_device *dev)
 	}
 
 	ret = __stmmac_open(dev, dma_conf);
-	if (ret)
-		goto err_serdes;
+	if (ret) {
+		stmmac_legacy_serdes_power_down(priv);
+		phylink_disconnect_phy(priv->phylink);
+		pm_runtime_put(priv->device);
+		kfree(dma_conf);
+		return ret;
+	}
 
 	kfree(dma_conf);
 
@@ -4324,8 +4331,6 @@ static int stmmac_open(struct net_device *dev)
 
 	return ret;
 
-err_serdes:
-	stmmac_legacy_serdes_power_down(priv);
 err_disconnect_phy:
 	phylink_disconnect_phy(priv->phylink);
 err_runtime_pm:
@@ -6343,7 +6348,6 @@ static int stmmac_change_mtu(struct net_device *dev, int new_mtu)
 
 		ret = __stmmac_open(dev, dma_conf);
 		if (ret) {
-			free_dma_desc_resources(priv, dma_conf);
 			kfree(dma_conf);
 			netdev_err(priv->dev, "failed reopening the interface after MTU change\n");
 			return ret;
-- 
2.34.1

