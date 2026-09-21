Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4702F4E06CB
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 16:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790009650; cv=none; b=WeEC6FwHCB5iCCvx+hQgSgD8Jt7KLOYxLJXJt2Yhcz4cFnBhkoO/+C4YrNxrczZ7DsbsKWCVdQQASY2fnlaCBsus68H4iY8Q/wDHEUmAiP8gkCMllH0dA93Mjjfmv88IIM/rcFqJcGt/FvIz8R4JtPcxAwo9Yjm4LzYLpLZ3Ux0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790009650; c=relaxed/simple;
	bh=bWQ6pPswaesSyX3jvthXifBbTMag2VXIen957tS7Bj0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tvippH13btuYZFuvjBjKIV6vlWZ2PpOrJ+rhl4PI/tP0FwUjAIzR1d7O6Y32mea8Y1NGvtZX78sfUROYdogvqSf3IA/wfFAn8J7QhrFJ/QCOJfaRDPhPG0Vje3PBzyJUGVLKT/dKBgu/pLPNKeiwePiQ1fqnqiWtku612v+q9bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ed+q52Qg; arc=none smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ed+q52Qg"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4c66ba0b762so781249b6e.1
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 09:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790009647; x=1790614447; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PWAktAj8+a2EZgQ4kCGxOWW2beeBTXDV3b5mgoUzlt8=;
        b=ed+q52Qg5ZZSD9rMqA4+YPcezmvS0tMS07Bc3SEZTzDBy/qaM4CX44YEd1W160k1vy
         XUnGYq9B8ImZUogFErIKBaFqv2SheMp8XS8rhRTeenCVtgppEdvQFvhtCY4Hyo2dHTNm
         8yEtoXKwWk+5JhJCseLR5MJOG4yZw550Sep2FRsQtQsHsTxf7/IS1VZqUybxAFd2nj4i
         6RwUBmxmz0QH0YMC2uPA6WPbubjrr4EUBZ+kU3/mJOKrzrUZ565y63IVLx+CTG40j7LY
         jKg1va7/LN9MwGkH2oSlXbtnrZzBOre02AP81GMDuyYpbghZ4tjxR8Cw6WK4xMGcE83A
         cI9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790009647; x=1790614447;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PWAktAj8+a2EZgQ4kCGxOWW2beeBTXDV3b5mgoUzlt8=;
        b=G1x5YCMRGnuMLpyx8UzRFzAtRbdukXIWSpSZ06naKXE6QE/8OzegeSqIGsTNH8mlgU
         RK7GVq/7oIloE159YdtVrYU33vx2LHs9BhisCZxAImQ8+ly1ARHjU1E46zRvb0msishW
         j6H7aGEsH3omB6dFWOuCMDP3MA92uEJnNQmryPTt+U0+XTb62Aw3CR5ujTQbnYqOCGU6
         PKNlHbTTlSz52Ut+OIfvgEuu/+tEOfra3n0FerOqC7tMgUQsep1s8UnbJp2aa8oaRFGe
         OsknD/XggKMNKRfCPU7bA61YzsNrFt1YquGwVP/Mr8il9EUh64e4XncIqMloMG80jhXC
         r0aQ==
X-Forwarded-Encrypted: i=1; AKwUvBycpiv/p7vEmr6hpd/sGcRZqPofrtZerWxLZz4MYEeSbEY4pBq62mm+N2KHMaU9Y8LBS/eXSlM=@vger.kernel.org
X-Gm-Message-State: AFuF++kui7L1cEWfJyC2+KxI3K7a+qtPgw8+cf7nxXfOATmytvlm7R2i
	IT5awi9b68ywJPpdUkhENXiZVzMF9jVwzjM8YxRL0+ymyrUbuPoiw6dc
X-Gm-Gg: AYBFou2WAmCxVxG8LJiwUUq3UXQuMksjFHdqy4Sh8F8kBr+EnHmcayWSWJBGIcUSU91
	JtWqnxFerxHzsy3tycuXGnjhxtqkGUeDa1TZKcS7Cu3KjQBxKv0Qo3rpL6f+2dV7ABWzsRhXwxp
	7Rh7+XxXnJiHF+qTZs2nwOvbTQJERysGstF4uZOs/QC/ornWzXytkukNjAJJZNY0HQJlWzRvObD
	YsuEwLGXBPmMMrAmBYOEVScWTW4VVwmqnqjX7z/Ffs2Saj9JhJqC1VmwodkCBADxwpNVcq3y3mk
	SEutC0+PV9BGO5gY5APOe91aqiRANWXuMeB0tKJlx48eTS/njunvzVhjgQXF0tiUi/tTfwsheTs
	cYG8Dd2S0WHClu5q8x7VWukbWNEd6Cr6nv+9ZROYFqmCSBI8crqvhFDodG+bR2g5G7uNPbMCMq+
	O5lyYawytO6xI2Zqf1K/xvap27vbfKkeYhZc2J42KXK+caGtQOqdKzHsUMpsFYrZXEc4fgnAlGk
	xd/4jvktDgO/Trb5BwfvwYDLvFnt+qBXNCTBcJf7DolEmgMzBCqiQ7teu957WaIgcLa/ZD0B3VU
	/DLyt/mHtrGf/hB/rmuh9VF9mf5d/5HT9AfQa0z1pBngZKZbECIfzNcKc4D14fAph6gLlWaStzG
	w50f2PVDS+7+G59JkSXWAKw==
X-Received: by 2002:a05:6820:812:b0:6b5:ec3f:497d with SMTP id 006d021491bc7-6d15a65b6c9mr206525eaf.24.1790009646999;
        Mon, 21 Sep 2026 09:54:06 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6d145bc40e6sm510481eaf.5.2026.09.21.09.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 09:54:06 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 21 Sep 2026 10:54:03 -0600
Subject: [PATCH net 2/3] net: stmmac: close the interface after a failed
 MTU reopen
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-submit-stmmac-reset-fixes-v1-v1-2-87a4e431ee00@gmail.com>
References: <20260921-submit-stmmac-reset-fixes-v1-v1-0-87a4e431ee00@gmail.com>
In-Reply-To: <20260921-submit-stmmac-reset-fixes-v1-v1-0-87a4e431ee00@gmail.com>
To: Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Joakim Zhang <qiangqing.zhang@nxp.com>, 
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Tiezhu Yang <yangtiezhu@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>
Cc: Richard Genoud <richard.genoud@bootlin.com>, 
 Alastair D'Silva <alastair@d-silva.org>, Maxime Ripard <mripard@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org
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
index 7582fca63741..873331dbaf77 100644
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
index 1fb5f804ea23..44b59d0f56b5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4179,6 +4179,7 @@ static int __stmmac_open(struct net_device *dev,
 	stmmac_enable_all_queues(priv);
 	netif_tx_start_all_queues(priv->dev);
 	stmmac_enable_all_dma_irq(priv);
+	priv->opened = true;
 
 	return 0;
 
@@ -4249,6 +4250,11 @@ static void __stmmac_release(struct net_device *dev)
 	struct stmmac_priv *priv = netdev_priv(dev);
 	u8 chan;
 
+	/* A failed MTU reopen has already released the data path. */
+	if (!priv->opened)
+		return;
+	priv->opened = false;
+
 	/* Stop and disconnect the PHY */
 	phylink_stop(priv->phylink);
 
@@ -6174,6 +6180,10 @@ static int stmmac_change_mtu(struct net_device *dev, int new_mtu)
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

