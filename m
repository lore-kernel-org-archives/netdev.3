Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com [74.125.231.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697F84E0B84
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 16:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790009653; cv=none; b=hyAMMFSoKXIQaxEgZvbdVdVkCoKozExZgVib2gvFe6ZVFAvfgbG6oW0uLE0he5bWxfqnDMptrJKg31XJWBKtarJLUzjH0uOpyqK0dRa5BcDyqD3F2O8RXqWQE6EYP0krWb1nO7LkOF+l631lP/6wKsvzzQJd/aeCFgEJcywiM3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790009653; c=relaxed/simple;
	bh=1qgx7WO1ODz0uzZ0PV4p/UIMKqQiae0iH1KRXidMcvY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dumuyui4S8xLYuuibI4pNSE0yBeGMlnNwugz7kl47gl5wwmqxdwzYlibuxtMOok8veuGqX2wQ3NbR2c0aSd7ySlDfueh6UY+9Vm6FhlDJMvrGtSpY+sfVLm8/R1wIPy1HXRpKWqnW7ML1+xybxF8ZiuH8qsoUy8qoal0dIhk/SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TzRYSL0o; arc=none smtp.client-ip=74.125.231.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TzRYSL0o"
Received: by mail-oi2-f12.google.com with SMTP id 46e09a7af769-801a8bf8112so1215704a34.1
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 09:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790009648; x=1790614448; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tvfdmXPJ30DEketzEq5aXVKBwOS7ewPYMj6rBpY0hhM=;
        b=TzRYSL0o+MpnwNBRJpqqA0Jzs+X+BizeBR8Xs4t/NZDUnnjVj/IPAgy+bMB0mEaBjJ
         fFL1VPPamn21NLHMGuA1qas1GqibT8ksabxhUoWfniQBvynsJces+DeL157WMjxwoYiF
         yuE2QKY8/gvogRsntZabuP0YSmBQ8mge4BkYHLnTOjxfHYNz6J4jimucok2MSt48tKyI
         etnqLkaLRsdwlGUT21xHuENi3hfcLDsMWVd2tWHYA2CyJrIrWgg8JvRg6QxMlEH6Z1p3
         TsvShJsG2gze47Us3D2zh1vB53JodlwmulORilbuiZ7dfaHbWWife/0dvvVi0Tn/bmZB
         WasA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790009648; x=1790614448;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tvfdmXPJ30DEketzEq5aXVKBwOS7ewPYMj6rBpY0hhM=;
        b=ednyc6HXLBM7FwrMRvDe0YMgJaVYmkybT4ilHhVAOVTRW4onwvhd83iA22fwOY+wrv
         EOksGBBSJtNJRGME/yH8OnAuRlEFmqfOvq9uzHvUcqSMDbHmSXLaEb0jsKSEGdl00evf
         7kmML2zUrrX8AQ+krRp5wk/Ie71UCLin93/V7qLPfQKwHy7DPJpgpCb/ZukbJOO0n1uX
         Su/rfvH9Z+T3j0Zg5qVuaiJVuuIT6dZrPGYmqrbIhCEIg2lZmI3rVLZsWRTwNkjXSk+2
         py4hjRLa3NaHvkiBsJ+PzgtAXICLSjumVwg9SMNzAOerWM7qTLh6j+XQfQ/G1dREvwRG
         g0OA==
X-Forwarded-Encrypted: i=1; AKwUvByESMrWE6+sr57S2R0RD7S/e5FkSPz6PjP/rWNKFX4es6Fo/2JVlvWuoP+PZz8wdbOk1ScxUc8=@vger.kernel.org
X-Gm-Message-State: AFuF++nuJDgM4ZV7zDJf8K5olumH7udyAw8lH8wFo/AndYyBL74XeO8Y
	GwJPnsVydsyeKACDOxT0NRyF4DE4Hb2lXswH2BjG543UCKSHi4z3DxpO
X-Gm-Gg: AYBFou3WbbYS5Y9djnTzoqRAWFcZ6c2LT8hVZjM3a1SUaP2S+lGdz/DNj7vLQTLO93n
	84bmxZL589y8tTuJ1aEJWGXAEfI5VHXSxcPz75OjKpwkpHu0vivgoW1DEwv9gvJKtrg/svzELD5
	wCjH6BoTdLJdnhCmN1lqiYE1KUFtsFaTGAOh0D9DN+8GrGOJ4bDBZZ2YyGU9eMusudcUV90lHB2
	DhbIp8VIF+QtyvR2eFLkkTwjw/ul4K5aWstf3pLcmhvTYFHiQGkL2d+VRwZ1ni5flH+CSnD6ViE
	IoOUIysDGJkChYTAdNswBhhb9sZuPov7vXpecCXBAGMynK0ueVgCxkeBGN3iD0e72jlLJsECl/0
	JUIKnftPmbyDYtJYgQOEjhXtNrvMwYmiOjtFq3YQBmLRYLS6+NLp95tAHA4+AMCJtfIe1qPeS+F
	hvC+w4dBcYlavrdpVpp30bKtLRQS3rNJQaRl7euGg1KIe35ZnBXyz76kXcK+4gMpWJ1x8zukFmI
	URaFMIsgOA5sW3USLLa9NXUhSrhVQK6IgrmhygK79XRLXzTZFQVnWr2RkZT5JrP0deFe5QbAWQS
	IzIGBtbW6Ow7+GaYalHprShefOKHRTbFHuscrTNulhb1R0sJI5vPqzZOuE43sz/Iw5nWyJ8ByDC
	js47AAuxpjh4yDSTThVITHA==
X-Received: by 2002:a05:6820:f00b:b0:6bd:760a:a8ce with SMTP id 006d021491bc7-6ca9d451e13mr9761450eaf.62.1790009648212;
        Mon, 21 Sep 2026 09:54:08 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6d145bc40e6sm510481eaf.5.2026.09.21.09.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 09:54:07 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 21 Sep 2026 10:54:04 -0600
Subject: [PATCH net 3/3] net: stmmac: close the interface after failed
 hardware resume
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-submit-stmmac-reset-fixes-v1-v1-3-87a4e431ee00@gmail.com>
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

System suspend disables NAPI and suspends phylink but retains the IRQs
and DMA resources. If hardware setup fails during resume, the interface
remains administratively up with NAPI still disabled. Closing it later
calls napi_disable() a second time and can hang indefinitely.

On hardware-setup failure, stop DMA and disable the MAC, then release the
suspended data path without repeating NAPI disable. Stop phylink directly
from its suspended state rather than restarting the link on hardware
which failed to resume. Drop the driver mutex before teardown, retaining
RTNL across cleanup and network-core close.

Close the netdev to detach the PHY, release its runtime-PM reference and
clear its administrative state. Reattach the now-down netdev so a later
open can allocate new resources and retry. Preserve the original resume
error and leave successful resume unchanged.

Fixes: 6896c2449a18 ("net: stmmac: Check stmmac_hw_setup() in stmmac_resume()")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 29 ++++++++++++++++-------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 44b59d0f56b5..87cb0978ed6a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4245,7 +4245,7 @@ static int stmmac_open(struct net_device *dev)
 	return ret;
 }
 
-static void __stmmac_release(struct net_device *dev)
+static void __stmmac_release(struct net_device *dev, bool napi_disabled)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
 	u8 chan;
@@ -4258,7 +4258,9 @@ static void __stmmac_release(struct net_device *dev)
 	/* Stop and disconnect the PHY */
 	phylink_stop(priv->phylink);
 
-	stmmac_disable_all_queues(priv);
+	/* Suspend has already disabled NAPI when hardware resume fails. */
+	if (!napi_disabled)
+		stmmac_disable_all_queues(priv);
 
 	for (chan = 0; chan < priv->plat->tx_queues_to_use; chan++)
 		hrtimer_cancel(&priv->dma_conf.tx_queue[chan].txtimer);
@@ -4297,7 +4299,7 @@ static int stmmac_release(struct net_device *dev)
 	if (device_may_wakeup(priv->device))
 		phylink_speed_down(priv->phylink, false);
 
-	__stmmac_release(dev);
+	__stmmac_release(dev, false);
 
 	stmmac_legacy_serdes_power_down(priv);
 	phylink_disconnect_phy(priv->phylink);
@@ -6174,7 +6176,7 @@ static int stmmac_change_mtu(struct net_device *dev, int new_mtu)
 			return PTR_ERR(dma_conf);
 		}
 
-		__stmmac_release(dev);
+		__stmmac_release(dev, false);
 
 		ret = __stmmac_open(dev, dma_conf);
 		if (ret) {
@@ -8356,10 +8358,7 @@ int stmmac_resume(struct device *dev)
 	ret = stmmac_hw_setup(ndev);
 	if (ret < 0) {
 		netdev_err(priv->dev, "%s: Hw setup failed\n", __func__);
-		stmmac_legacy_serdes_power_down(priv);
-		mutex_unlock(&priv->lock);
-		rtnl_unlock();
-		return ret;
+		goto error_stop_dma;
 	}
 
 	stmmac_init_timestamping(priv);
@@ -8386,6 +8385,20 @@ int stmmac_resume(struct device *dev)
 	netif_device_attach(ndev);
 
 	return 0;
+
+error_stop_dma:
+	stmmac_stop_all_dma(priv);
+	stmmac_mac_set(priv, priv->ioaddr, false);
+	mutex_unlock(&priv->lock);
+	/* Release the suspended data path before ndo_stop(), which must not
+	 * disable NAPI or free these resources a second time.
+	 */
+	__stmmac_release(ndev, true);
+	netif_close(ndev);
+	netif_device_attach(ndev);
+	rtnl_unlock();
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(stmmac_resume);
 

-- 
2.53.0

