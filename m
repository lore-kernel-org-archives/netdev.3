Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5667407CF1;
	Wed,  2 Sep 2026 08:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788338851; cv=none; b=J38LOX87WstVZ7gZ3NkqgABQoB0+hpK61uW66Tk8hIIhKVjv3x9OlUHj4nR504EATShrC4pBcQKIU0n0slc3oKSUZaMpNLEycqd8S0Vc8MPqoqEgwyCA/WuvqjPRugUuHbTvwSIwt9XSWRUrrbUEglep6jKKh1UhX2uov6PFRCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788338851; c=relaxed/simple;
	bh=Rx/BwPZz1nFmiPxrs6ijsVuPipyTxnTQ+EDPRlg8Vc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lLncYzgpUdJWV5Op6NnTDvf3ODW/THOT/UzFdK3vLQ9x1eXZmZ98/1v+UIZPTQAESFDJqAia9dVjxuqzIARayIycsCGqQcP6uMHjEqp5n9MC3uCPyOosLs3mq5L17n54y8qGbe2kgaZoSm+ey5ALfNosp4kDgodjKWdZYUjmEPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=PWtGNvk4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pL7zDihN; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="PWtGNvk4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pL7zDihN"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D81021400161;
	Wed,  2 Sep 2026 04:47:28 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 02 Sep 2026 04:47:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788338848;
	 x=1788425248; bh=MzdyokQk2ze66BotvVLj7vZyHGPrVdjHA7SrK79mHDU=; b=
	PWtGNvk4wPvj+/++721Od4KNngv6R/iJeEyb8wsnZK7j2qIRxwgKb6sMZkJ4uMxp
	thr+wy0LlY0KA2aSBXERo40e8OH6f/aEK4CVIjcM9Ig3xfL95mvVUN2iy0bbcY2A
	Ual5rv3j9etiyiy0mV16XaMbjVXvjo6y95q416D8GSBbKq4LQhBp8rzzIR7CqDCl
	OLH/6MHoaIcZ2JZEnRNM8eM7ZShgIf58yoFF/P0RwLPP2lP7jLKm76edQtCCjDT/
	31k3JZm/IX2Uu0HiNClTnpKsUaBh/UFvEk+V1d/ILAFls5ZV9eShiE3kUgSlD1Wo
	I5vSK5xSQyR0Ufq4Cq7z/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788338848; x=
	1788425248; bh=MzdyokQk2ze66BotvVLj7vZyHGPrVdjHA7SrK79mHDU=; b=p
	L7zDihNeiawPnnZADRJkY6LyBYF8Uw0uAIEoGMOeN4QGqZFmWhYhBeAXWfzUrm8I
	gOGrgLeKzCctTAOSp8g+ho7JaEyd7jUf7kpoSPHvVKP2GmWjIfgANEPAFLNRAAvx
	TbK/LtngeX7F7Ct6V9FNzDOM0OgeMY0Q9JvMMngWuCxZPjtXHpJJO6dilaZ425dv
	golGHYaF7jFXuEjsthu4pjw67SZYISCvn4B9WJo8qpMUxsUfN5cjnyr0Gz3hFoY+
	3Y9KHw75CNa8LsGXbisBs/E8Q1fTSDt+WvFi0isE+SlaIe/diS9qMaZDzNdJQsdf
	pmGXhzO0V8AUT2+hXOysw==
X-ME-Sender: <xms:oOKXahPY3LVWlU4v7Imu9FL4fX0CPsn0-ykf6vPhzRaGnYyKLweynA>
    <xme:oOKXasut1SHvfEO4-cmcvK_H808DshTQ2Ghl-aGaeBG8yhqye7Zt2R79xK72otdh1
    SxJgzfyXvdDLUXVebEFLZVXjB-kFJYoHxjp4XKAiGnBaN9-sp02M8kqKw>
X-ME-Received: <xmr:oOKXau-A4u2MY96Hmxm25At9IGZpqCPzLrLXnIhEDbPZV-gK-pk82GeXL9h2eukCamVXpV0NQ01oQZD-lyxqZ17OkHaWLSs>
X-ME-Proxy-Cause: dmFkZTFrtePpp9RfJwyMD2rBHHISQnYzMQKn1VM8LgZ2tfmx0a+R4uJ2TcDvdH9vAbkf/+
    s1pNN/RwTVplB5cL+09+uVDy/XxuKa+jgAtSszcsN276G+vme2LwF9ah0AoiaG+O1IvPqi
    /f58ts/pb8lIOC6mYBOJz5V9Z63EPBankveXGIhc5W25NXwT4cI631+Bl+23PQZ6B1lT7Z
    s306wcJTlPy5tIJxwHbceSKEkFkjGEMUb+N6ZKETwgLaWryIZTGs0mYiC7b/57XeP4qDVr
    YcLCLRqp5CtMk1Ev7V2r0uwZ9Ps4Zs7QUZyeG7TY3LTCd+tt6u6WpW3r/Tox9ZiFc6K0mZ
    t+f9Fh5wTDShzhXcoPyf2b4Z6a1owrDbbqJK2Mo5xfzI5HequYQcnkPuGhM4t/r1nm1cIm
    on+qJPGBLxa7z3oLhP+OgVU+bl8JwX0Yb/lvTawX4c3v7jnvFcYFuYzOtNE07IqmCBkRP3
    mH1wA4sIqqsNj+rjEK/Fab5gUm5oXADtiXMUT3l5LCJnOQOuat5w8CoWsPfXrqWvYicSHY
    /f/fTlNSBGjaLtut5kgy3v/xmFNnPywjiNsbhH9cftVCb92ABcn2jHCb1B4M5qazMV49Qk
    sFEbT8PKTpdW3s9L9pq5e1Ait8MVW/mX1VLeV8bm3oFnIF/Z5Sf6jlaW+0Qg
X-ME-Proxy: <xmx:oOKXagE3tkllSmOEbpeeDf9BvwkaeK1WcSp6U7c-10rPdT4UoqfTSg>
    <xmx:oOKXatQQo0YCifCzl6PFZejdJmJ_QtxdnJXQ79ba1hFztMwCU9_vIA>
    <xmx:oOKXautY8_PqJo8cMWTt3wO2Bvc32ebKONcyRo0NFMlun25aoboK5w>
    <xmx:oOKXaqAHylj3MJVHfXfWGhpxDYuXme9bhISw3XQ4rToyUkVgeSYKRg>
    <xmx:oOKXaiFm-TPO1c5bvGH3ohlnlGeyzSqlDU94CNKecYnyUApUdGFEaGfl>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Sep 2026 04:47:27 -0400 (EDT)
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"DavidS. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Sergey Shtylyov <sergei.shtylyov@gmail.com>,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH net-next v3 05/10] net: ethernet: ravb: Propagate error from ptp_clock_register()
Date: Wed,  2 Sep 2026 10:46:58 +0200
Message-ID: <20260902084703.3228504-6-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902084703.3228504-1-niklas.soderlund+renesas@ragnatech.se>
References: <20260902084703.3228504-1-niklas.soderlund+renesas@ragnatech.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If the PTP clock registration failed the error is silently ignored.
Before reworking all callers of ravb_ptp_init() handle and propagate the
error so it can be used.

Link: https://sashiko.dev/#/patchset/20260610102432.3538432-2-niklas.soderlund+renesas@ragnatech.se?part=1
Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Sergey Shtylyov <sergei.shtylyov@gmail.com>
---
* Changes since v2
- Rework to remove the caching of phc_index added by LLM without access
  to hardware.

* Changes since v1
- New in v2.
---
 drivers/net/ethernet/renesas/ravb.h      |  3 +--
 drivers/net/ethernet/renesas/ravb_main.c |  3 +--
 drivers/net/ethernet/renesas/ravb_ptp.c  | 25 ++++++++++--------------
 3 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index aa45f5466001..0c122a815840 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -1028,7 +1028,6 @@ struct ravb_ptp_perout {
 struct ravb_ptp {
 	struct ptp_clock *clock;
 	struct ptp_clock_info info;
-	int phc_index;
 	u32 default_addend;
 	u32 current_addend;
 	int extts[N_EXT_TS];
@@ -1163,7 +1162,7 @@ void ravb_modify(struct net_device *ndev, enum ravb_reg reg, u32 clear,
 int ravb_wait(struct net_device *ndev, enum ravb_reg reg, u32 mask, u32 value);
 
 void ravb_ptp_interrupt(struct net_device *ndev);
-void ravb_ptp_init(struct net_device *ndev);
+int ravb_ptp_init(struct net_device *ndev);
 void ravb_ptp_stop(struct net_device *ndev);
 
 #endif	/* #ifndef __RAVB_H__ */
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index e44d065f77cc..7c7b3ac81e5d 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1785,7 +1785,7 @@ static int ravb_get_ts_info(struct net_device *ndev,
 			(1 << HWTSTAMP_FILTER_NONE) |
 			(1 << HWTSTAMP_FILTER_PTP_V2_L2_EVENT) |
 			(1 << HWTSTAMP_FILTER_ALL);
-		info->phc_index = READ_ONCE(priv->ptp.phc_index);
+		info->phc_index = ptp_clock_index(priv->ptp.clock);
 	}
 
 	return 0;
@@ -2934,7 +2934,6 @@ static int ravb_probe(struct platform_device *pdev)
 	priv->rstc = rstc;
 	priv->ndev = ndev;
 	priv->pdev = pdev;
-	priv->ptp.phc_index = -1;
 	priv->num_tx_ring[RAVB_BE] = BE_TX_RING_SIZE;
 	priv->num_rx_ring[RAVB_BE] = BE_RX_RING_SIZE;
 	if (info->nc_queues) {
diff --git a/drivers/net/ethernet/renesas/ravb_ptp.c b/drivers/net/ethernet/renesas/ravb_ptp.c
index f70b616ac847..19d039b9d24a 100644
--- a/drivers/net/ethernet/renesas/ravb_ptp.c
+++ b/drivers/net/ethernet/renesas/ravb_ptp.c
@@ -313,11 +313,11 @@ void ravb_ptp_interrupt(struct net_device *ndev)
 	ravb_write(ndev, ~(gis | GIS_RESERVED), GIS);
 }
 
-void ravb_ptp_init(struct net_device *ndev)
+int ravb_ptp_init(struct net_device *ndev)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
-	struct ptp_clock *clock;
 	unsigned long flags;
+	int ret = 0;
 
 	priv->ptp.info = ravb_ptp_info;
 
@@ -338,15 +338,14 @@ void ravb_ptp_init(struct net_device *ndev)
 	ravb_modify(ndev, GCCR, GCCR_TCSS, GCCR_TCSS_ADJGPTP);
 	spin_unlock_irqrestore(&priv->lock, flags);
 
-	clock = ptp_clock_register(&priv->ptp.info, &priv->pdev->dev);
-	if (IS_ERR(clock)) {
-		netdev_err(ndev, "failed to register PTP clock: %pe\n", clock);
-		clock = NULL;
+	priv->ptp.clock = ptp_clock_register(&priv->ptp.info, &priv->pdev->dev);
+	if (IS_ERR(priv->ptp.clock)) {
+		ret = PTR_ERR(priv->ptp.clock);
+		priv->ptp.clock = NULL;
+		ravb_ptp_stop(ndev);
 	}
 
-	WRITE_ONCE(priv->ptp.clock, clock);
-	if (clock)
-		WRITE_ONCE(priv->ptp.phc_index, ptp_clock_index(clock));
+	return ret;
 }
 
 static void ravb_ptp_disable(struct net_device *ndev)
@@ -369,14 +368,10 @@ static void ravb_ptp_sync_irqs(struct net_device *ndev)
 void ravb_ptp_stop(struct net_device *ndev)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
-	struct ptp_clock *clock;
-
-	WRITE_ONCE(priv->ptp.phc_index, -1);
-	clock = xchg(&priv->ptp.clock, NULL);
 
 	ravb_ptp_disable(ndev);
 	ravb_ptp_sync_irqs(ndev);
 
-	if (clock)
-		ptp_clock_unregister(clock);
+	if (priv->ptp.clock)
+		ptp_clock_unregister(priv->ptp.clock);
 }
-- 
2.55.0

