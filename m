Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF8A3DC4B7
	for <netdev@vger.kernel.org>; Sun,  9 Aug 2026 20:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786307514; cv=none; b=Id7/B9hcBSQUb6wYnVdLiR79fcXRrJ54ewbwKx+d4K2dDv2yAkafHjADUv9aysUFFOc/KYpGe5bwsvszon4c056vTZqDDgeqKLT5pkO5aDJg/hWxFtZVOaZd1XHSnjzw5YlDa5NYmI92HRP8jFx33s+UC+zVGYzMUidAMD/dkg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786307514; c=relaxed/simple;
	bh=9V3LdjIg6Clu0G9LOgw3jzWAJvl8mlhBZ/E0F+0renY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dFKIP11tnwGeiTZqrby1GdfO1A+uM6pMGSI8spKhZvXeL+sT/XRUD2U0DR6iNSm99/6xtB4ESHXfsa+rh10fw8ktq0mJFpISG9mw2UV0hd+ZLjfe7X21X+XFCcZA4AgF4wlD6EQUci76z9RK2XPdNGCoiIT8RT3Rnafh/lwfV3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DDTcL6sH; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDTcL6sH"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4957eefd361so8218095e9.1
        for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 13:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786307509; x=1786912309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VB96Ldc2jz3Kca5DqAJVE1SCjhA8uLTE3bNlY0xHhzc=;
        b=DDTcL6sH5xD7wNKbvS17V3VNW/kSE7wICBwEbLEhfHj6yZ2COlqQne2TUjX3pFQia0
         WcDYqz1o62Dld7YsuFfiWV2nL0UBOkI4ad6TzRmpDqWasuMko90Kee6Jguml/+gnfa3L
         dkNeAhngaJYlSW/6ep/zToI/mTn3cq9cAunctKMfXL6wsjBkCS6AqhJerULF7x/s8nKE
         fRZOb+35gkBBDUoBrJsN6/W5POWymLolnFv6rlDXeII8ROxM50oCVUmn+usJ1/qIYVd8
         +2I6Fe9pMzeaQfCx3bw23niUcvpJfv/PrTPQIkf47KW7wknAekbOnKn53PwTsoAGT9A0
         mduw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786307509; x=1786912309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=VB96Ldc2jz3Kca5DqAJVE1SCjhA8uLTE3bNlY0xHhzc=;
        b=THjz4EHAE5vE3MlIdNRr5L9BiC39+AAh7kxxz+ydmj3SzibnkvVuCO8PMNYcenPs4q
         n0KaMCMALlakzrqmLqe0iwAO/gYT9ovSdc3+OMcf+wxIL/NV/2pkAhPlAxLmy+x5AdaJ
         yqXxXXSKIdApzO2oqNbHh234+miE5K4QL+eyJxZ+PJx63pDb4crnSV50oWzTdyTe5OXt
         R84NZsLRLhdTfhuz6Vv9ko8XVXw3Vy/YgHsODznfDCqBbvJ1o/DR1ZYprldqsaldt1bd
         jxZi4OVAnkw29BSqSA4CfWe7nu7Oz8IdNUzniR3LbF8j8SNsdbIfwUX6KDkHmnoBWtRi
         OlDQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpcwi9pa9d0gNkdmjPL6X1LbDLYICBgKPPo4uxT1mjcz14ChBRGxVZc8i9n01b6SAuShLDBXSI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn/RusfEIu/EbcV+ZoqD+mg+IS8ME9B38r+stTUWK5x+CL/zCy
	joxRHpOWM749+eI4mnuxqv3aCGtuL7J3dFLUgt67YI6EfF628mKsX5SW
X-Gm-Gg: AR+sD12YOwdzu9/BWZBgHXSH7oold4v2mOE+LSN2h6ejZ1gNEu+uIP+7XUJnuB8rbvg
	pf8+z1JbNd3sB0Z9bD637cPNVfBdOhzSqNdITbsKNKn/zTfOoN/d4ysKFMLECXBvMAfNrYbaJR3
	d2YqynTpaXhHN3ARguAHRkA6C1nHv32ZHllN5+EL8Fg65wDtZ2sdAVhpMnOV00uC+73Id8VvKJP
	DHKOVh3Njjcg0ahUty+8QMr+OikDRvw0bwmcUY4ioNxMcUjlqtZfmV9Hbb2Kn49WW88Og8WdZqw
	VzG1G5b3dHrTJBm0MR43JFkoAHTojIgAuHXCKiFJSAjkiPBJGvzECyzkTm24hwauZx1EAbUjIrb
	MobAePZEe42olWnJ0qBaf2aXiW0nVe7eQ25AcFwRXKZ0zvizvhgjfg9NAFn/VPmC5mp1qxCPCPZ
	I1Ir3mU0oUqqVfcGWVdlfJBSEOsDQBw+fAWS7Ix0FEWOjM1jTN8CNcLdHPbXz2s6ZKDB2aOhUC9
	1MyLdW07tYZG44YVqMzLMONzAWxUx7QcdQi6p/MiM/bCmCd
X-Received: by 2002:a05:600c:470a:b0:493:f318:3bc6 with SMTP id 5b1f17b1804b1-4995e0df176mr198258835e9.13.1786307509452;
        Sun, 09 Aug 2026 13:31:49 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-87-20-3-207.retail.telecomitalia.it. [87.20.3.207])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4995e9ea92csm229357065e9.4.2026.08.09.13.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 13:31:48 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
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
Subject: [PATCH net-next v12 09/12] net: phylink: add .pcs_link_down PCS OP
Date: Sun,  9 Aug 2026 22:31:06 +0200
Message-ID: <20260809203116.640271-10-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260809203116.640271-1-ansuelsmth@gmail.com>
References: <20260809203116.640271-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Permit for PCS driver to define specific operation to tear down the link
between the MAC and the PCS.

This might be needed for some PCS that reset counter or require special
reset to correctly work if the link needs to be restored later.

On phylink_link_down() call, the additional phylink_pcs_link_down() will
be called after .mac_link_down to tear down the link.

PCS driver will need to define .pcs_link_down to make use of this.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phylink.c |  9 +++++++++
 include/linux/phylink.h   | 12 ++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 191c902d4008..d64fde37eb2d 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -982,6 +982,12 @@ static void phylink_pcs_link_up(struct phylink_pcs *pcs, unsigned int neg_mode,
 		pcs->ops->pcs_link_up(pcs, neg_mode, interface, speed, duplex);
 }
 
+static void phylink_pcs_link_down(struct phylink_pcs *pcs)
+{
+	if (pcs && pcs->ops->pcs_link_down)
+		pcs->ops->pcs_link_down(pcs);
+}
+
 static void phylink_pcs_disable_eee(struct phylink_pcs *pcs)
 {
 	if (pcs && pcs->ops->pcs_disable_eee)
@@ -1687,6 +1693,9 @@ static void phylink_link_down(struct phylink *pl)
 
 	pl->mac_ops->mac_link_down(pl->config, pl->act_link_an_mode,
 				   pl->cur_interface);
+
+	phylink_pcs_link_down(pl->pcs);
+
 	phylink_info(pl, "Link is Down\n");
 }
 
diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index ca9dfc142388..ea554c0d41f8 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -528,6 +528,7 @@ struct phylink_pcs {
  * @pcs_an_restart: restart 802.3z BaseX autonegotiation.
  * @pcs_link_up: program the PCS for the resolved link configuration
  *               (where necessary).
+ * @pcs_link_down: tear down link between MAC and PCS.
  * @pcs_disable_eee: optional notification to PCS that EEE has been disabled
  *		     at the MAC.
  * @pcs_enable_eee: optional notification to PCS that EEE will be enabled at
@@ -555,6 +556,7 @@ struct phylink_pcs_ops {
 	void (*pcs_an_restart)(struct phylink_pcs *pcs);
 	void (*pcs_link_up)(struct phylink_pcs *pcs, unsigned int neg_mode,
 			    phy_interface_t interface, int speed, int duplex);
+	void (*pcs_link_down)(struct phylink_pcs *pcs);
 	void (*pcs_disable_eee)(struct phylink_pcs *pcs);
 	void (*pcs_enable_eee)(struct phylink_pcs *pcs);
 	int (*pcs_pre_init)(struct phylink_pcs *pcs);
@@ -690,6 +692,16 @@ void pcs_an_restart(struct phylink_pcs *pcs);
 void pcs_link_up(struct phylink_pcs *pcs, unsigned int neg_mode,
 		 phy_interface_t interface, int speed, int duplex);
 
+/**
+ * pcs_link_down() - tear down link between MAC and PCS
+ * @pcs: a pointer to a &struct phylink_pcs.
+ *
+ * This call will be made just after mac_link_down() to inform the PCS the
+ * link has gone down. PCS should be configured to stop processing packets
+ * for transmission and reception.
+ */
+void pcs_link_down(struct phylink_pcs *pcs);
+
 /**
  * pcs_disable_eee() - Disable EEE at the PCS
  * @pcs: a pointer to a &struct phylink_pcs
-- 
2.53.0

