Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6314F3033E9;
	Tue,  9 Jun 2026 01:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780968374; cv=none; b=cFBbOePX/AFEHtKw+ETI8eqJIV7TONBzkTqL89XF8NWZUVBfg+Ps1TdyVH4mcPrY0/WKz2wlG7EfFpjb4T71Wcv0XfdDqt/4F8tosIShqCFsROb1JmzI5eVtxXqzlaX+STEjPeY7CY/icVRoxrPMZDQ/KRxmcJMm+WKNnl2rmpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780968374; c=relaxed/simple;
	bh=cGSBqXlHL71jF8vrkCzgQIxHiwwI+xgXtXSa84NKcqc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hhyr1hmooBH+7nimoW1dGtAMyXVs5Gm/H2HqvkrgJU7ONX6B0RA2y0RxTvJtf2mSGHrLD3LL2jeGjyqttWos3ksPS7mLqfTs36/7dv5hkUEGBOhwCG/MfqzV1So0HomaBu+GYAMMnEt1vQSXOWux84CxTK1AB5jjQZjFnY3GVtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wWlEF-0000000035e-3osz;
	Tue, 09 Jun 2026 01:26:08 +0000
Date: Tue, 9 Jun 2026 02:26:05 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v5 3/4] net: dsa: mxl862xx: move API macros to
 mxl862xx-host.h
Message-ID: <030af2c0e3b31934044f37951e88d2be78048c7c.1780968180.git.daniel@makrotopia.org>
References: <cover.1780968180.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1780968180.git.daniel@makrotopia.org>

Move the MXL862XX_API_WRITE, MXL862XX_API_READ and
MXL862XX_API_READ_QUIET convenience macros from mxl862xx.c to
mxl862xx-host.h next to the mxl862xx_api_wrap() prototype they wrap.
This makes them available to other compilation units that include
mxl862xx-host.h, which is needed once the SerDes PCS code in
mxl862xx-phylink.c also calls firmware commands.

No functional change.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
v5: no changes
v4: no changes
v3: no changes
v2: no changes

 drivers/net/dsa/mxl862xx/mxl862xx-host.h | 8 ++++++++
 drivers/net/dsa/mxl862xx/mxl862xx.c      | 7 -------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-host.h b/drivers/net/dsa/mxl862xx/mxl862xx-host.h
index 84512a30bc18..66d6ae198aff 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx-host.h
+++ b/drivers/net/dsa/mxl862xx/mxl862xx-host.h
@@ -9,6 +9,14 @@ void mxl862xx_host_init(struct mxl862xx_priv *priv);
 void mxl862xx_host_shutdown(struct mxl862xx_priv *priv);
 int mxl862xx_api_wrap(struct mxl862xx_priv *priv, u16 cmd, void *data, u16 size,
 		      bool read, bool quiet);
+
+#define MXL862XX_API_WRITE(dev, cmd, data) \
+	mxl862xx_api_wrap(dev, cmd, &(data), sizeof((data)), false, false)
+#define MXL862XX_API_READ(dev, cmd, data) \
+	mxl862xx_api_wrap(dev, cmd, &(data), sizeof((data)), true, false)
+#define MXL862XX_API_READ_QUIET(dev, cmd, data) \
+	mxl862xx_api_wrap(dev, cmd, &(data), sizeof((data)), true, true)
+
 int mxl862xx_reset(struct mxl862xx_priv *priv);
 
 #endif /* __MXL862XX_HOST_H */
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.c b/drivers/net/dsa/mxl862xx/mxl862xx.c
index a193f3c07d35..0b1a23364eb5 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx.c
+++ b/drivers/net/dsa/mxl862xx/mxl862xx.c
@@ -24,13 +24,6 @@
 #include "mxl862xx-host.h"
 #include "mxl862xx-phylink.h"
 
-#define MXL862XX_API_WRITE(dev, cmd, data) \
-	mxl862xx_api_wrap(dev, cmd, &(data), sizeof((data)), false, false)
-#define MXL862XX_API_READ(dev, cmd, data) \
-	mxl862xx_api_wrap(dev, cmd, &(data), sizeof((data)), true, false)
-#define MXL862XX_API_READ_QUIET(dev, cmd, data) \
-	mxl862xx_api_wrap(dev, cmd, &(data), sizeof((data)), true, true)
-
 /* Polling interval for RMON counter accumulation. At 2.5 Gbps with
  * minimum-size (64-byte) frames, a 32-bit packet counter wraps in ~880s.
  * 2s gives a comfortable margin.
-- 
2.54.0
