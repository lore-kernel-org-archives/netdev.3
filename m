Received: from mail-oa2-f35.google.com (mail-oa2-f35.google.com [74.125.231.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBF1489FBA
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 19:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789933548; cv=none; b=tWybGBNx3BO3JhkvJPLdSSSwpzUCJ4MKYab9X1d8jKhlbkm8nc/PW+nurK8ulI/0NJnhhh4h4KI0e/U4YVawGYs15hBbBQVd0lYDxum7ne+rS6VNxtiBipP6ESG1xSCU0bLMiIsQ1Y3g3w2M/f3j3aJWKaX8WGc/NaWOjw+u46A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789933548; c=relaxed/simple;
	bh=L/gVslUU4Nj87gMlJ1iN5b89DCxQ3qLLsz8MQD+nnKM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jARC++Ji3SWCJSmab8/i4egi1QlonvjTcow50bDVmilsn24cCuYQWdhAtB4X70YKY9zwttGoYd15HyTgmTrrubnAOTAGm7CsniH3J2dt7m4Mu8cNq9c1cqu3UX6ZGVYZ2jxSCALAjxbLP2ENXz4PU4cot0+ULBgqnjUutxlkuuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b6IxJVgm; arc=none smtp.client-ip=74.125.231.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6IxJVgm"
Received: by mail-oa2-f35.google.com with SMTP id 586e51a60fabf-470417e5b52so1709336fac.3
        for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 12:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789933544; x=1790538344; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3aFq2H0KJohvHytlOdYBRSeWux+yzT03AinuuVRvEmM=;
        b=b6IxJVgmucYmvO5f9YkZ/mpQlEpApK7Y+SyeTPT2cj6xbyT9maXXXMh9YSut7YGkxv
         8JyzdzOVXIIyxs7j8UBo2RucuIMQ5DPjvFRJ3DUeZEvq8AL7lsh8JCwqppk7Oo9aXft/
         P3GlVian8EHjzHZ3ME5mU3zMzPAk9gso/IUfbGWTZk8f9/g5idBOAM+gBzE2S6FxzUeh
         zfY9z8KQKMI22qch/4ZJG9SO0VWaJ99HBOgBGWepUaXi7pJ28U0NmyqO+pmgQ0kuLu2S
         kh8DqOe4wYec6c3nZRFwUSfpkcA9MQ7yrki6PJy5MZVB+XeN1rDPKjOY4d3Cy6A94DVV
         q6cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789933544; x=1790538344;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3aFq2H0KJohvHytlOdYBRSeWux+yzT03AinuuVRvEmM=;
        b=YRHos8vJQcbotNlTu4AfEQnMO9xmfdECPUmuBlUuID8LFCBRGz9T8BY13/T0/TwQy6
         emIaSLRqkM/yyQpDjFGwBlClt1HVd+48JAoNoiDBWTR7KhW7iPZ01EHYpOF+Gb0cY0SC
         dIm53vq7omBPIrQv5BXYbEqfwiy5GSDzgQ2AYh7pUpcQuBFy1odDT6QobfBQ6jxDQKzu
         82Wl2gBdJ2OecuWk2RW2bfKVtMOXZCR3KsXws2xAjuwexpZ/llHTg/YHy5/UU8lINyvE
         DHZQq/MYIp5mJPjbbtakfjkQWyx1XKgnKuyAnBrpY6a5bCV4vn4be3+kkVXwgq9HoQsh
         K92w==
X-Forwarded-Encrypted: i=1; AKwUvBw8k1HagJEmx2P1eRQIAgyNXIPz2allSuHIJlx65USYUDNiVAg9AMx87aoTd5PH9UuJVXb0cq8=@vger.kernel.org
X-Gm-Message-State: AFuF++kVyK4faSd0m2WQatsa3pHPOBRrwDR7RcojC77xwawZVJouZIp0
	7yrY/ZZQUHO16cTMySCjfhdVz7oINYLYxv04B92OP+EhzokohAH6CfA2
X-Gm-Gg: AYBFou3ZasgChVVaulrTixrjocD4AaNR/NGUgAaJ5Clk8gquXA1VWSmFJAUJhThne7z
	Gq6cxOz8biPGyC/cU3UeA4cMNcZXAtu5k7COuNUjCLCO96KZxiTYxp4SLVYQ4NW+GzqNhhtxQUp
	oGfzEwQSvmiZYTBxHZUqTYjjJrXIsVqe3rVQyATWCECeb1rpzCzIkr1CV2pfapxLqxhixLSj3i8
	8wd6/AyoSax+KdlnmEnjNpzI020+kUxUpaDB6Pg6eHT/yOmWN+eTMjeyMy0WaxSuN4VzM5Qspuq
	dE3V0F08n+q+tZxAocUk1eZ5AFsvGzqQmA++UdnJLYKh4iDEoxJutkClJqkgPNWIDsYrLpdn+or
	X2RgQwp1BUq8cfwITZw6vg/Gkn3TUTObNou0ZawLZX3d/npLwX7Fnm6pcKF3NZjnQ9HJfGDtoap
	/kSzj8TqGwWGM/KW9u6KIz0AoLt7QA97q3EPpmwkxoUt9wxRaRVH2fO+8tToFi3tUcGE3SYd1LJ
	WDQA/J6HtWjkDB8F+iGxXeBMj++9SJEX7Kt6XXrdSVwJzbezdn0Z7boUuptXM9UD1Te5swgGCop
	9/FFCqbVBzCGcwSrWF0XR8TxTPVKNVN4gQ6bhFTNObKGUL1KkDfhdkT+11B70D+h02AzAsECUb2
	wTY3XqdyunvsVXjRjjGX9
X-Received: by 2002:a05:6870:c205:b0:42c:49c7:a499 with SMTP id 586e51a60fabf-486e4ceaa22mr8316127fac.3.1789933544510;
        Sun, 20 Sep 2026 12:45:44 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4881f4d7861sm6103834fac.1.2026.09.20.12.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 12:45:43 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 20 Sep 2026 13:45:29 -0600
Subject: [PATCH net-next v4 3/6] net: stmmac: close the interface after
 failed hardware resume
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260920-submit-h616-emac1-v1-v4-3-8347dfe2eb7d@gmail.com>
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

System suspend disables NAPI and suspends phylink but retains the IRQs
and DMA resources. If hardware setup fails during resume, the interface
remains administratively up with NAPI still disabled. Closing it later
calls napi_disable() a second time and can hang indefinitely.

On hardware-setup or timestamping failure, stop DMA and disable the MAC,
then release the suspended data path without repeating NAPI disable.
Stop phylink directly from its suspended state rather than restarting
the link on hardware which failed to resume. Drop the driver mutex
before teardown, retaining RTNL across cleanup and network-core close.

Close the netdev to detach the PHY, release its runtime-PM reference and
clear its administrative state. Reattach the now-down netdev so a later
open can allocate new resources and retry. Preserve the original resume
error and leave successful resume unchanged.

Fixes: 6896c2449a18 ("net: stmmac: Check stmmac_hw_setup() in stmmac_resume()")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 89b773370894..18630ae62316 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4283,7 +4283,7 @@ static int stmmac_open(struct net_device *dev)
 	return ret;
 }
 
-static void __stmmac_release(struct net_device *dev)
+static void __stmmac_release(struct net_device *dev, bool napi_disabled)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
 	u8 chan;
@@ -4296,7 +4296,9 @@ static void __stmmac_release(struct net_device *dev)
 	/* Stop and disconnect the PHY */
 	phylink_stop(priv->phylink);
 
-	stmmac_disable_all_queues(priv);
+	/* Suspend has already disabled NAPI when hardware resume fails. */
+	if (!napi_disabled)
+		stmmac_disable_all_queues(priv);
 
 	for (chan = 0; chan < priv->plat->tx_queues_to_use; chan++)
 		hrtimer_cancel(&priv->dma_conf.tx_queue[chan].txtimer);
@@ -4335,7 +4337,7 @@ static int stmmac_release(struct net_device *dev)
 	if (device_may_wakeup(priv->device))
 		phylink_speed_down(priv->phylink, false);
 
-	__stmmac_release(dev);
+	__stmmac_release(dev, false);
 
 	stmmac_legacy_serdes_power_down(priv);
 	phylink_disconnect_phy(priv->phylink);
@@ -6212,7 +6214,7 @@ static int stmmac_change_mtu(struct net_device *dev, int new_mtu)
 			return PTR_ERR(dma_conf);
 		}
 
-		__stmmac_release(dev);
+		__stmmac_release(dev, false);
 
 		ret = __stmmac_open(dev, dma_conf);
 		if (ret) {
@@ -8415,7 +8417,7 @@ int stmmac_resume(struct device *dev)
 	ret = stmmac_hw_setup(ndev);
 	if (ret < 0) {
 		netdev_err(priv->dev, "%s: Hw setup failed\n", __func__);
-		goto error_unlock;
+		goto error_stop_dma;
 	}
 
 	if (priv->ptp_enabled) {
@@ -8454,9 +8456,13 @@ int stmmac_resume(struct device *dev)
 error_stop_dma:
 	stmmac_stop_all_dma(priv);
 	stmmac_mac_set(priv, priv->ioaddr, false);
-error_unlock:
-	stmmac_legacy_serdes_power_down(priv);
 	mutex_unlock(&priv->lock);
+	/* Release the suspended data path before ndo_stop(), which must not
+	 * disable NAPI or free these resources a second time.
+	 */
+	__stmmac_release(ndev, true);
+	netif_close(ndev);
+	netif_device_attach(ndev);
 	rtnl_unlock();
 
 	return ret;

-- 
2.53.0

