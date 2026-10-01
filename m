Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF68367F4A
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 04:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790829099; cv=none; b=jhq8vg6d/rMPIwDIsMIKb5uEb9VaT6SUwo96Ler+ukH7/I70PD3usCIueqstXnL2jf+293cVNLM9oa2EsiLN/23SZLy5gl59nZnUeHBFbG/twt6VIo6Mjy4/ltbyUUMNOL056GSibsqGWCgvX3VD/LxMbKNlj3y2fB/qZ5RciUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790829099; c=relaxed/simple;
	bh=+bggdvOODFl71zz1ONn5aE0m04Kzv+BjknZIOAjQHTI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=an+QE56ClCQ5bHYFMiM+0fsa/HQOA8bTU0EEskr8ALG7fReDGjFd7jkUOzUNVDvYBwZhb/is+pNDFzYbcJ59p1Q9S6IhQfzyTUpaMxwaz2+xXB77uAq7zxYcXCTVZVdKyK9S+4liUfwMDF8q3PfUiwSE4Ve8DXBpu/e4rqnX4nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DSdVn9hT; arc=none smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSdVn9hT"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4c4bf3defecso5051691b6e.3
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 21:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790829096; x=1791433896; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Q4Vf2DmeXuIICczMLsgHOQylq088gF7uO3L3in1vUSo=;
        b=DSdVn9hTZ74PjhBxFpULihkXy/rWfVyIhGvP0dLWU3dp0IqO5F0NBoBanaF+lx7u3B
         Uafo3r8kCHybs/KnrQwCfHNeU7ikvmRHyOBaRl0GA9ZoOj9rtB06eUp3ODJPUpUSM++L
         nMKqSOeUQRiUsbIQVBr/4YQNrHDDzLtyjjLyYcpoUg/F5Igc93Xav/OtvUe8yAb1qET+
         Gv5j95I5ECQFSR1iqu0Rk+Cjtm9NGXqhkyD6j77xG1W5CcfxRATWENSBbeMneQZ9ufRg
         aiR7T4fq8z1BS1DpLPvMPRx5138/5KBYQPt0KXwJp4K/6ovZDLZgq/TImON86bFOAo8h
         KH8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790829096; x=1791433896;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Q4Vf2DmeXuIICczMLsgHOQylq088gF7uO3L3in1vUSo=;
        b=Gb/atmV+3w/0YLbVG0lxbWFKdAE0Y8vdBOdZThsvJ55CMf8meRIG00/1hX0mnJTdYQ
         dc9N+pew4e7LNg8EEx8tpm3qziQCU+DZkB8MhJ0S2YpupaTDXmwOBP1PaGxKmua72+JK
         3saOOlJ4TeY7XZ6lcu5bCO9IEaHjceJylGiCD4KDWSdOGcHJ7Nyy6gjU30qfobj5ImDe
         Wma0pzCc3S9TjfLqTjF8zfOSw1Fwq5mBEAUaFgmwZzIYtDLKSGWPbI/XhFtxg70x08G1
         TFQe/dxmnp6mcv5Wdju5lBxWxx+8qBHNTUAEOy78SNFj5cVRryg7pIUzOu8azDQKkwqA
         sinA==
X-Gm-Message-State: AFuF++nWtqOQ4SljoXCMdAE3PlNU+goP3Ku7jPYkHMWrrAY5AIAj+LD0
	zka8hjNQlpk9zp98pB+KxGguZKlgxNsNEjm7bWQOJXXA1virCFAfj02ldueQ/Q==
X-Gm-Gg: AYBFou0KPk826WdXa6e6DYXkZX8sRYbQlTq9n+Ty1RU//qJ2ChpqTS+gqBzoyPCYMPy
	2pRoEuNnGyM70Yajhc12e6DtqtZIj+1rXTs3GtN7J9ngTRy7Hjc2lq+HmqX6X9qvqvvuUp6/+df
	oZ1z3ifkpPJSmcanYypm57506ChSBYeADX+6Yv+0tUolzZuqWBnl9Upfsju9Y7ipLpZnqnDdrK1
	/KykEZqUSR8jPECfikLGW/efsWg4d20oYrY5LmnJdTZcv2tAnnqxtjpGR1dIaR2TuSCzJy/RrAg
	kc8rvVxAoOq2jdvvgdGnp34m/WACVrPK+4SzvzUS9f3WJVbWlIxklSA6c2dPkfGZAQ2bcnBeTQi
	UqbFmSl6S0iRSHJ0UjhaiTQZUsCumIy9sOuuSTXhwzt/jGkTZYQ0tykHih4fq7F0UR3hjcLnS01
	WtA70SEAQrFpsOEkmZHn7g6bYY5uV12BOz8bsUWZc2BmhI6bSVOlNFtbl1B33vx+n1YfoAEUhD4
	atn8PBq5z7cgG0dFzlCY/QgqTLr2Brncchr1/Sop1KOJUSXvSiFulQGyaroFGLhwfGroOJ6zyPg
	5EsZGos5iITNHh7VUFoxUFP2QQAKDYsI7cTA7Ck7RGWcOrm9Ko/cgss5N2/tp70ZZxPXenrL5mX
	Vy4AYVXCPxRQ2tDEop84d5A==
X-Received: by 2002:a05:6808:10ce:b0:4c3:db9b:3eae with SMTP id 5614622812f47-4f1b76329a7mr4055713b6e.15.1790829095989;
        Wed, 30 Sep 2026 21:31:35 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4f349a4d20bsm1378430b6e.5.2026.09.30.21.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 21:31:35 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 30 Sep 2026 22:31:32 -0600
Subject: [PATCH net] net: stmmac: unwind the WoL IRQ after a safety IRQ
 request failure
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-stmmac-irq-unwind-v1-1-0c8a053761c7@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2MQQ7CIBBFr9LMWpIpVGh7FdMF0EFnUapA1aTp3
 SXq8v2f93bIlJgyjM0OiZ6ceY0V2lMD/mbjlQTPlUGi1DgoFLksi/WC00Ns8cVxFuio1wO2WvU
 zVO+eKPD727xApALTb0z02Gq//B9nMwm/LguXsbHGBets10tFyrf67JxE7LzpKATjcdDaSOcNT
 MfxAWAG42q0AAAA
X-Change-ID: 20260930-stmmac-irq-unwind-0be86901638d
To: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Serge Semin <fancer.lancer@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Eric Dumazet <edumazet@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

The safety IRQ is requested after the MAC and optional WoL IRQs. If its
request fails, stmmac_free_irq() frees the unregistered safety IRQ and
leaks the WoL handler. This can warn about an already-free IRQ and make
the next open fail.

Move the safety and WoL cleanup labels into reverse acquisition order.
This also fixes unwind after later per-queue IRQ request failures.

Fixes: 5c2215167d12 ("net: stmmac: Add driver support for common safety IRQ")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 3f34d491c959..4f3d452c3503 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3797,13 +3797,13 @@ static void stmmac_free_irq(struct net_device *dev,
 			free_irq(msi->sfty_ce_irq, dev);
 		fallthrough;
 	case REQ_IRQ_ERR_SFTY_CE:
-		if (priv->wol_irq > 0 && priv->wol_irq != dev->irq)
-			free_irq(priv->wol_irq, dev);
-		fallthrough;
-	case REQ_IRQ_ERR_SFTY:
 		if (priv->sfty_irq > 0 && priv->sfty_irq != dev->irq)
 			free_irq(priv->sfty_irq, dev);
 		fallthrough;
+	case REQ_IRQ_ERR_SFTY:
+		if (priv->wol_irq > 0 && priv->wol_irq != dev->irq)
+			free_irq(priv->wol_irq, dev);
+		fallthrough;
 	case REQ_IRQ_ERR_WOL:
 		free_irq(dev->irq, dev);
 		fallthrough;

---
base-commit: a7bfaba4823e3c165bb2004c74eff7c096672bc7
change-id: 20260930-stmmac-irq-unwind-0be86901638d

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

