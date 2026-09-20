Received: from mail-oi2-f43.google.com (mail-oi2-f43.google.com [74.125.231.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BF6489862
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 19:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789933545; cv=none; b=pz+u/fVO+wO9c0Vo2hmKLwDkR6Z3hHsXLTFstkOwgo1zL3CWjpm1oLb6+o+XEWU1y62kif5x1BNxxTqylNxEFocfxy0cQA/+hpx7uo1+2u7cCRb6nEUdDWOa2Z+YGeruaw9pSL2DzCUU/zljZClpEO0wuyAUJdeWVjv9GFtfYQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789933545; c=relaxed/simple;
	bh=k5FoGW0DAM2X+E/ozmN4JjC/wwwbNR5mhWy/pmNOyns=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g2JHikqI5JYVr6tw/8FttxRwCa5e4n9DpQBJD9KBBeDDqqafTb59Mfg6xIsVX24tAHf55re89NX3+qvYzirvMOLA3Z5ofoGrSKI8f7+aetFB1oYKpS/46rBYRK5QbGAEEzuMBiMQBZsoBsvwMvvQP7fhiu1e2vp40xLYecAgwuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KChtIWAD; arc=none smtp.client-ip=74.125.231.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KChtIWAD"
Received: by mail-oi2-f43.google.com with SMTP id 46e09a7af769-7fcb425fc2bso1369858a34.3
        for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 12:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789933542; x=1790538342; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z7+d1aoXBtF7Wx/9KwAupq2tjY1ApF1IdNz1vfPutVo=;
        b=KChtIWADyQPy1o8x3Vf6QSEP9nxAhcpg4xaQ7MrHkeo1s8eq2DqjsoIqHdpqhVqkeG
         EIlXoeKUxJ9V9NbBOqOv4lYJe22qe6HVSlmzLr/+c9bAMFDDwYSL8vaALmTxiQyooQ2b
         XRXL7mulZZUPuXgwJAjsmAXQguVwvquRlZLTO+0mDJ7XfTLKGe9061QEyhHGGoc8shw2
         EsvKkq/4AeXYgaW8ljOzuhmdM/KaZMER7iI3YL52kAH5GhJprD1v2aSrt18JGRUC25pU
         8ye4/SOw5kqy7volQjHvm5lWXTHjF04zDWthI3COTHk/OqlGmj2AxdU4YIMqSDh0hF3w
         vjwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789933542; x=1790538342;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z7+d1aoXBtF7Wx/9KwAupq2tjY1ApF1IdNz1vfPutVo=;
        b=WTiyGNxTnh62Zwe4qvvfbsOzLmt821n6Ral+uYMmGi3qEQ7KVDtAvqJLdKKd8uzrV0
         LmVWGZtzJPrWT3zQfSafBcpyiK98XU+cqjVkxN9ZQi9A/ymtXQdRfbc8HSavdVUB+u3q
         hhRga3Vfl2jPnmuMBZPdjeOGDuTn6+dBqn8hFUt0XW7xenm5frkcmxt2wsUmtPRkpACF
         uPKgRSjLyQYDmzHL0gt5XFBUCRKI9nIfaaxEydDZ+qB4pEoC65wADK3GsnBNFKC3DZgK
         OyAqBufnV21pLRjwqQVt7cM5AUbx0exwD8JALCFxR7s11rP0IeROtlRrK0NSDFTa/heb
         wgZQ==
X-Forwarded-Encrypted: i=1; AKwUvBwUz+lEdsRD8hl2+KZvHtsCvvif8Y9bkJ2bZW9PNQHR/+hG4ThacifecdYjv1qehtEll7VJNkc=@vger.kernel.org
X-Gm-Message-State: AFuF++mnkbelJw5w5IXhh8T6icmtRT3EjWg2Sfs9Wg8ZPsZkvl+LU4un
	3oxm4EbcNj7uG3KvAtseX2w7nMaHitvRSjlLl4i8UlpDg4PiDHN11N0L
X-Gm-Gg: AYBFou1So1tRJVB2ITg/4RHIAp78XIwskJSLco7yaPIiqMJwVLOtT7M5iA4yNOb0G+z
	D1YqaykR8WbFcyhgFV3WqLcZumS8wc3pHwfrY0+B4qHmCp6zVSFLt1hY0rcvPDg5BIG/ICYBElr
	LLKoPjf6eHfhUJefAMhk4uNvcgWIKn/eb9dioABE7NlIZvnect2/wH41MVGVbjIhAcsrLcAZpEI
	XtSgqdSSxhMgtpd/Tl4+kNj55RWlIOSmg883Lez6ctyl7hdKYOkgsNlh6D1GtxOm+mSYs0yrMKD
	xnXOxr4ezzLYdWzsmfvWpVlHdvwe6Nnhpo4QS1a9Rw52RftaGjDl217p/17OzuPoeQCYiKPQUmo
	fiQ19JMpJhcgNfQ/fnKoAETYPOtT1Y/1gd6nCw5btF50en6VzaUseF8eCuPkRxpO8CopXg3AfE2
	eCIYBf4ev555vk/Mo4yCDV2zsv1RmyIhGBsGgOAyMnOZoBslLwwOE7Luy1mDg0NrjUDbkM+y/OY
	aEQ3NFMrwNPy7dSEpmqVXMaI5JGvpUN2Huv58rncKvEms6akSd9cB2U6NVtO+YRJwBX2si5aZBX
	st8jubf8f5Y7vuJTsi6tqyxGcxS8H7Whh/Ub943rIeMMMqG0eagJllWxrjSxjGP2ZKhobJvAeAs
	u5+I5UfPyiqeSoSd5cRYu
X-Received: by 2002:a05:6820:1c8f:b0:6cd:3ffc:acf6 with SMTP id 006d021491bc7-6cd3ffcb603mr4885791eaf.70.1789933542612;
        Sun, 20 Sep 2026 12:45:42 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4881f4d7861sm6103834fac.1.2026.09.20.12.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 12:45:42 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 20 Sep 2026 13:45:28 -0600
Subject: [PATCH net-next v4 2/6] net: stmmac: close the interface after a
 failed MTU reopen
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260920-submit-h616-emac1-v1-v4-2-8347dfe2eb7d@gmail.com>
References: <20260920-submit-h616-emac1-v1-v4-0-8347dfe2eb7d@gmail.com>
In-Reply-To: <20260920-submit-h616-emac1-v1-v4-0-8347dfe2eb7d@gmail.com>
To: Richard Genoud <richard.genoud@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
 Jose Abreu <joabreu@synopsys.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Christian Marangi <ansuelsmth@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Tiezhu Yang <yangtiezhu@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>
Cc: Maxime Ripard <mripard@kernel.org>, 
 Alastair D'Silva <alastair@d-silva.org>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

An MTU change stops the data path and then reopens it using a newly
allocated DMA configuration. If reopening fails, the new allocation is
freed while the netdev remains up and priv->dma_conf retains copies of
the freed pointers. A subsequent close repeats NAPI disable and IRQ and
DMA-resource teardown. It can hang in napi_disable() or access resources
which have already been freed.

Track successful opens of the data path separately from the netdev's
administrative state. Clear that state when releasing the data path and
skip a second release after a failed reopen. Close the netdev through the
network core on the MTU error path, so the PHY attachment and runtime-PM
reference are released and the interface is marked down. A subsequent
open can then allocate fresh resources and retry normally.

Keep successful MTU changes on the existing path, retaining the PHY
attachment and runtime-PM reference. Allocation failures before stopping
the original data path still leave the running interface unchanged.

Fixes: 3470079687448 ("net: ethernet: stmicro: stmmac: permit MTU change with interface up")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |  2 ++
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 4fc96b317d79..363872ff00d6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -281,6 +281,8 @@ struct stmmac_priv {
 	struct mutex lock;
 
 	struct stmmac_dma_conf dma_conf;
+	/* Paired __stmmac_open()/__stmmac_release(), serialized by RTNL. */
+	bool opened;
 
 	/* Generic channel for NAPI */
 	struct stmmac_channel channel[STMMAC_CH_MAX];
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index bf9e7e4cb1c3..89b773370894 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4212,6 +4212,7 @@ static int __stmmac_open(struct net_device *dev,
 	stmmac_enable_all_queues(priv);
 	netif_tx_start_all_queues(priv->dev);
 	stmmac_enable_all_dma_irq(priv);
+	priv->opened = true;
 
 	return 0;
 
@@ -4287,6 +4288,11 @@ static void __stmmac_release(struct net_device *dev)
 	struct stmmac_priv *priv = netdev_priv(dev);
 	u8 chan;
 
+	/* A failed MTU reopen has already released the data path. */
+	if (!priv->opened)
+		return;
+	priv->opened = false;
+
 	/* Stop and disconnect the PHY */
 	phylink_stop(priv->phylink);
 
@@ -6212,6 +6218,10 @@ static int stmmac_change_mtu(struct net_device *dev, int new_mtu)
 		if (ret) {
 			free_dma_desc_resources(priv, dma_conf);
 			kfree(dma_conf);
+			/* Finish closing the PHY and PM state, but do not repeat
+			 * the data-path teardown after the failed reopen.
+			 */
+			netif_close(dev);
 			netdev_err(priv->dev, "failed reopening the interface after MTU change\n");
 			return ret;
 		}

-- 
2.53.0

