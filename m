Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794529952;
	b=ZYKrzZM6qqsuM4cIoAs8u0xGWrhnkMrp35Nl8TZv7gmz/JiYyA1/BRPafutzZJ36O20l
	 08NHwBr/JrqSXnCHzAPCT3Fa9v0Rbmh5QL38bJw3CTGKxSXvU+Wn1gqL9xm2n5gkVJNWD
	 Cq6TcAsE24WCxAsXyxznfmUMTZuuJ8gxg3RaUMOt+gSQPRc0SiRHHe4kekQcsXkO+AkhE
	 sOtDKO4sV8eLFmaVdZ+hi+N8+QjrrSBbU/ALweKXN3CFwa11NKbnQXUbcswG8o31VBx+s
	 5PpBhJ9UyYsz9rDxhfqYzIUzc/rXv4kOiOVY7GSKyJw0Y20vvr9HBQcnLey09/xyzdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794529952;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=GSzexzY3tNd8fGcKsjnU3nRndcIeboSpFV5OISlu3o8=;
	b=R0N+gvSMM0SRk/yxBULOvWQ38xtSjH+ihkXqA2tM++v62CsyhgVgAWYEnTaEWQr8wzj4
	 IHWWTw7G2KbiTxtqytBcdYs+eJ1RJVOdszSr8bvK9OUTAsUYGTQOz7Gd6RNWP8mm++QaF
	 CsaaDKJYs3PxD+b56JZsultQykeorxB8oPu9BGMfopDSpjJdpa2g3IhKHHowmO90tQzZA
	 1eYbJXlIDm4RMEYVxm4NpbgvcPc7Jh6SBPqXcm2yqkBCYg5uD1YG8mCs1idOzN4wocblx
	 IoYLfNnctfIYouHZssfW6Zwsx1QDqszAOfrofg9rDREN3ohnvq0HEXMXJYyD7inXC6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Gjqnet9W;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6881D606A8A9
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 00:32:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6881D606A8A9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Gjqnet9W
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-498f5fa5103so132998f8f.2
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 16:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794529951; x=1795134751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GSzexzY3tNd8fGcKsjnU3nRndcIeboSpFV5OISlu3o8=;
        b=Gjqnet9WN/sbUEJTf6Vdlds3Seb7eZti22TD54FtT9971cn/+vOENE35r436ZJ2bbX
         AzkE5RhFryOsnMyYBTQLnJTfLHWJEat8uLl0CCJWiJ5T/Hm1qd/5zapsSDAvMY3+IC+8
         06Tez2QayRutopxficRWi9AH84UgkQnYOPz7vGrKaVYq2Toe2Ctc60M6tRpw8j4bN5m/
         1cf6XKUlVcQLQ7U6f1kxNT0S/weW/nDOcb3gdEj31WqHqgNItWhCFh5wauHF5CsNOa8y
         6VTfCUEQKGABAqUd785EbScZjgj5xZo+r9uUmBe1YpXDVNgjKGbfaiRJX+H7Agw65HWd
         u9JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794529951; x=1795134751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=GSzexzY3tNd8fGcKsjnU3nRndcIeboSpFV5OISlu3o8=;
        b=OnPoa1FYc3wiqr/Jcl3yPb2Ht1oISNNo5yFBaY7IeUBSXnEcD+TjGQcdHdYnZHt2Lt
         8M5RJ7F/cg7JyDeqDR6M3JjFjIYEAOwaqf38G4OK2LnCop+bJ2+2zm9V1D44oAvchBZp
         aXP2uviornvQFcPtEnpn/xHoBDQ6KKoSdvpMj5c/5XD7okOzTjuVFwWJKxh3Pzlj6AJN
         fO0bIev++S4lSM6MWz5LgK1pxadNq8rK59fdZ9+dqMQOAZINl3bF/2d6PTanziW92c1v
         5sz+TUEqwZDkHEInr1efVG99kaMbWuA9Am0qW3x48GoVUSncc/Ud29BbHlTgr7LC6tgU
         UX4w==
X-Forwarded-Encrypted: i=1; AL+hErGSDS62oZgvV9SjbSy/qULK9pgmemNYLaC8bII4GFOPCSxtgluVYPux7PEldO6rGyqKvrePawc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8skUovfYj3mQ7fgnnZihLS1wJQ9jOH7jGLPnE1M/z5PiTHIQB4
	Dl9RxCL9kFBaxo+wVSi4Gz1rjxRiN6V1dBa5kgW6jq/upJ78muvZQE6t
X-Gm-Gg: AYBFou2ZJ0hf8FplBSkl6tZK7YxozHf0+lUlY+GSs7f+cm5VZXajdkBTEE+a+0efObY
	XlIBHSsiF6lgggZcrmRAkCU3U+PFDXUctQxWGrT6YSncieakL1qHGPBul1ldDn0xSa90KtGNQHJ
	ODWIjqgbJamfiOqdkDHdpkKkC+BQYMRybH/pR5yOWmsldk2abDaRgsjIRcdJmtMWDinDmYrrN+X
	TBFUM6THVkVOUpbg6063AnOST0ADhn/qB0AoQJWB3b++rRNXBdfwD1AHMCfzZeaWQo3+tuV8kum
	3gGoWRjY19hS64gyY4N7pLXyBv62hsPmv5hLNiM7abTzcYadb5Vf0T5ExkzMpb6iP+u5zk64b+S
	pGe15Y8epJpmIvTyVHOtWylY5Y2DMdUbZ7sLNlN8CRHZThokh5KXXdmT2TgXhG4EzyoxCfLlgiQ
	r2P65seDhNwVqtAdHxYJ5XvRcjbT3He+xEQ9LNA41w4A0AlcR8wlGUJvBmgJI/y0N3VzWO2OnSx
	/z0UqDmo82p0tCsdaVtT1pUe9+BkppOaACDwLaXbyAXZgBUXuLKYcePbAu95Hzpygc0Y/90iVJE
	zd8X9+fYL2HCC0bYLsca+k9Y98MXatrxXIVt7/+ieDTuX9zja7QkPX9091IsEnbXoXo7dOFdqhW
	KLn4w+JImSs+xt0suVIBCMXfHIXQUguNdrpfxPDyp/mGqRkt5/lZ7+Q==
X-Received: by 2002:a05:6000:402c:b0:491:4e13:fde3 with SMTP id ffacd0b85a97d-49c712ac654mr2019766f8f.13.1794529950823;
        Thu, 12 Nov 2026 16:32:30 -0800 (PST)
Received: from Ansuel-XPS24.localdomain (host-212-171-11-167.retail.telecomitalia.it. [212.171.11.167])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-49c5f7828a4sm2029768f8f.23.2026.11.12.16.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 16:32:29 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	llvm@lists.linux.dev
Subject: [PATCH net-next v19 02/15] net: phylink: make PCS phylink instance access RCU protected
Date: Fri, 13 Nov 2026 01:31:52 +0100
Message-ID: <20261113003217.197757-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261113003217.197757-1-ansuelsmth@gmail.com>
References: <20261113003217.197757-1-ansuelsmth@gmail.com>
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

In the context of phylink_pcs_change(), phylink instance is dereferenced
from the pcs pointer present in the phylink_pcs struct.

There is currently a fragility where this pcs pointer is never set NULL in
phylink_destroy() and would reference invalid memory after phylink instance
is freed.

In this scenario, if a PCS driver calls phylink_pcs_change(), invalid memory
can be dereferenced and phylink_link_changed() is called on freed memory.

To address this, make the phylink instance saved in phylink_pcs struct RCU
protected and access it under RCU lock.

Also correctly reset the phylink instance pointer on phylink_destroy() and
syncronyze RCU to catch an execution of phylink_pcs_change().

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/phylink.c | 17 ++++++++++++++---
 include/linux/phylink.h   |  2 +-
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 5d649903be9e..83620a120f18 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -17,6 +17,7 @@
 #include <linux/phy_link_topology.h>
 #include <linux/phy_port.h>
 #include <linux/phylink.h>
+#include <linux/rcupdate.h>
 #include <linux/rtnetlink.h>
 #include <linux/spinlock.h>
 #include <linux/timer.h>
@@ -1300,10 +1301,10 @@ static void phylink_major_config(struct phylink *pl, bool restart,
 		phylink_pcs_disable(pl->pcs);
 
 		if (pl->pcs)
-			pl->pcs->phylink = NULL;
+			rcu_assign_pointer(pcs->phylink, NULL);
 
 		if (pcs)
-			pcs->phylink = pl;
+			rcu_assign_pointer(pcs->phylink, pl);
 
 		pl->pcs = pcs;
 	}
@@ -2145,6 +2146,11 @@ void phylink_destroy(struct phylink *pl)
 	if (pl->link_gpio)
 		gpiod_put(pl->link_gpio);
 
+	if (pl->pcs) {
+		rcu_assign_pointer(pl->pcs->phylink, NULL);
+		synchronize_rcu();
+	}
+
 	cancel_work_sync(&pl->resolve);
 	kfree(pl);
 }
@@ -2609,10 +2615,15 @@ EXPORT_SYMBOL_GPL(phylink_mac_change);
  */
 void phylink_pcs_change(struct phylink_pcs *pcs, bool up)
 {
-	struct phylink *pl = pcs->phylink;
+	struct phylink *pl;
+
+	rcu_read_lock();
 
+	pl = rcu_dereference(pcs->phylink);
 	if (pl)
 		phylink_link_changed(pl, up, "pcs");
+
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL_GPL(phylink_pcs_change);
 
diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index 3a88a69882a6..4a0dc6fa8010 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -494,7 +494,7 @@ struct phylink_pcs_ops;
 struct phylink_pcs {
 	DECLARE_PHY_INTERFACE_MASK(supported_interfaces);
 	const struct phylink_pcs_ops *ops;
-	struct phylink *phylink;
+	struct phylink __rcu *phylink;
 	bool poll;
 	bool rxc_always_on;
 };
-- 
2.55.0

