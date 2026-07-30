Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905983F86F0
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 10:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785407101; cv=none; b=K0T5kpaYLIor3infYUg7UKZ1I9bcIjK/79vgs0QWogkT3xQRQ+9j38/QNxPKEqWXy/waZKD0WUAlrLSJCWkj04kXNrHaBjn9Ygyj6/nZpihPoF83ZylfPJNLheEoB2WKCmnivE4yNHtqFmt+YsG2huhFuirlBYXJMyM/HA+9tM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785407101; c=relaxed/simple;
	bh=Tm0ks2ZDBUMx/7SgUJfcoeK8CYDsKMgrwe2H5z2O8Gs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QtBwQUYU+2pnsaLtZxMXjZmKwnOfLLsXT0k4PwJAyh2Ocr5MIUcD3Hx+eeg7Q1mEgtZvNyZujfD5Ie8Y/U4mZBLSfWllIATgJ37kytGhijvxtVbT6jzJuu+OOHaJsk5MaBc/oUSD2CacnLYEHkIFuIIVoELtYjqQSOErH8bskQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JrvPXpni; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JrvPXpni"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49555a0e68bso9983615e9.2
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 03:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785407097; x=1786011897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gzxG+LmD3OJBziXxFrZNUzc+hlymbEKWiIuouLUjQy0=;
        b=JrvPXpni6G3ASufMQsqy/tyNQ3d38kLAMqH+FIZv6c2PNYyy7rqXFaGlkQJ5St3h2N
         zp6jp4/d8ezxi+HxQUriLgM3xo4OXzwUuOSciTeI8Wo61a8WuoVQSjDMdM7qYii+Boou
         epefVkMS7OQ1eG5gdZVPI6tnt3/QxAJghpMFzqMLDsLH34Ivo8uNsSFB46Jmzsgjxu3F
         fdBBnKBaqzxI3rxhWH0m0NTo14y2WJtOBxgGNtobFAQ3Bqh9qRVRFHpEPxb/0enfiZzx
         k21yfJjygZNwoj4KfJa+qzs3hIi/Qpu9U7veD2yD2jwRxOdFVIIx4pWP3HIl3nMfzzgi
         vmtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785407097; x=1786011897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=gzxG+LmD3OJBziXxFrZNUzc+hlymbEKWiIuouLUjQy0=;
        b=Qdr98sf1IgsMynzpHBkRoeZ49PIA8kb0eFeLLdPPKmVQbBD1QLwmwHowPoZqXbEWPs
         KaJ2GUI8iFh2f8rwqiPXmQdaRQ3G4dr5XlhBbnx6bJkWMcFbXkU8HBDe45JWD97RQm3D
         OjXMZLILmWmJY1nd+MCXSvqsj3iATS25t5Y4FMMErGYZMAPgmm6n4KaS5tsMG5Rh5RYd
         YrwtTyIT1rBbnaYK35wy/9PbJc5LOH0en7hzNSMx6xQ2K/QySsctHEPNj1lb3f/FqZL3
         W4quStvd8GkywueJ4vWtQs3/M0c+HHdueYJ3k6nk99TYb0hyLtTekTqDS/uLCO42lJBS
         l+jQ==
X-Forwarded-Encrypted: i=1; AHgh+RpROsc0RveKn84jalR9LJDwHmiP2SdLBSOcXQC0squnHR0hAh2PyfXVteST0lEdgPSdFLx5Lb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU/+m9LgpP/2DVP1VP28Jpw2yF1SaK3E/lhXBAZJr0EoFMW8rm
	YMLgxdAoBhTYk11KH9elAtRfAPNahqwh/Orq07sWTqJRylsYKr2aXAH0
X-Gm-Gg: AR+sD10mbtfsADvzpsRIPOCsGT7S/Bhen77KoamrxCqU6BwXP6MTE7xF3YXKP/CrcJz
	Ty9qJVj0z8NippLVfsLSb+rMddiOHvZoXtXnTUQ3b/5gRV8UiipkDtp2MxJL+yS6xiDwYd7w1vA
	JJJ7lR784/L4eRe7XXDWM91vOxHDcjQRicijCmLZ6P1mAVx1gq1u1WllhW8KyzKDB+iofcLckZe
	bJpLcg2WKgaavrcPCPYGkgEz3J2aqbRpLokv/w6mGggK6Ztpi2AN4kOsZucSZ7+HcnuJxDjqXz0
	GFMo74fm3GBc0ylh13gUxh8s7tbE/lEKhA15ftpBBG2MHIvsQB/N4fMddepPPRsixoEEBAmEkn0
	5jwyp6Sq+IgDrvARwNEg5PiigjeHzPCeSnnpsTFLTgOurS9jRY+OwPXLKkzOnbeS1I+OBi2pIyt
	KKgEavnLpmvSpFitTfuf554irV/mPJwTXuWifR5PqsWotjR6Ns/8C1O485UqvQp09BMI1IYU0tF
	Z4c8KhOUHukYlGQKhm6gNxHlhV9iW9jqxldWNsFf/XdF9EYFojUmWs=
X-Received: by 2002:a05:600c:6298:b0:495:64c7:804f with SMTP id 5b1f17b1804b1-49800ea1ea9mr27095295e9.23.1785407096531;
        Thu, 30 Jul 2026 03:24:56 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-87-11-254-126.retail.telecomitalia.it. [87.11.254.126])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-498011fd5fesm44720295e9.7.2026.07.30.03.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 03:24:56 -0700 (PDT)
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
Subject: [PATCH net-next v10 01/11] net: phylink: keep and use MAC supported_interfaces in phylink struct
Date: Thu, 30 Jul 2026 12:24:12 +0200
Message-ID: <20260730102444.1967900-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730102444.1967900-1-ansuelsmth@gmail.com>
References: <20260730102444.1967900-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add in phylink struct a copy of supported_interfaces from phylink_config
and make use of that instead of relying on phylink_config value.

This in preparation for support of PCS handling internally to phylink
where a PCS can be removed or added after the phylink is created and we
need both a reference of the supported_interfaces value from
phylink_config and an internal value that can be updated with the new
PCS info.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phylink.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 59dfe35afa54..3464e3ec5699 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -60,6 +60,11 @@ struct phylink {
 	/* The link configuration settings */
 	struct phylink_link_state link_config;
 
+	/* What interface are supported by the current link.
+	 * Can change on removal or addition of new PCS.
+	 */
+	DECLARE_PHY_INTERFACE_MASK(supported_interfaces);
+
 	/* The current settings */
 	phy_interface_t cur_interface;
 
@@ -628,7 +633,7 @@ static int phylink_validate_mask(struct phylink *pl, struct phy_device *phy,
 static int phylink_validate(struct phylink *pl, unsigned long *supported,
 			    struct phylink_link_state *state)
 {
-	const unsigned long *interfaces = pl->config->supported_interfaces;
+	const unsigned long *interfaces = pl->supported_interfaces;
 
 	if (state->interface == PHY_INTERFACE_MODE_NA)
 		return phylink_validate_mask(pl, NULL, supported, state,
@@ -1867,6 +1872,9 @@ struct phylink *phylink_create(struct phylink_config *config,
 	mutex_init(&pl->state_mutex);
 	INIT_WORK(&pl->resolve, phylink_resolve);
 
+	phy_interface_copy(pl->supported_interfaces,
+			   config->supported_interfaces);
+
 	pl->config = config;
 	if (config->type == PHYLINK_NETDEV) {
 		pl->netdev = to_net_dev(config->dev);
@@ -2025,7 +2033,7 @@ static int phylink_validate_phy(struct phylink *pl, struct phy_device *phy,
 		 * those which the host supports.
 		 */
 		phy_interface_and(interfaces, phy->possible_interfaces,
-				  pl->config->supported_interfaces);
+				  pl->supported_interfaces);
 
 		if (phy_interface_empty(interfaces)) {
 			phylink_err(pl, "PHY has no common interfaces\n");
@@ -2827,12 +2835,12 @@ static phy_interface_t phylink_sfp_select_interface(struct phylink *pl,
 		return interface;
 	}
 
-	if (!test_bit(interface, pl->config->supported_interfaces)) {
+	if (!test_bit(interface, pl->supported_interfaces)) {
 		phylink_err(pl,
 			    "selection of interface failed, SFP selected %s (%u) but MAC supports %*pbl\n",
 			    phy_modes(interface), interface,
 			    (int)PHY_INTERFACE_MODE_MAX,
-			    pl->config->supported_interfaces);
+			    pl->supported_interfaces);
 		return PHY_INTERFACE_MODE_NA;
 	}
 
@@ -3760,14 +3768,14 @@ static int phylink_sfp_config_optical(struct phylink *pl)
 
 	phylink_dbg(pl, "optical SFP: interfaces=[mac=%*pbl, sfp=%*pbl]\n",
 		    (int)PHY_INTERFACE_MODE_MAX,
-		    pl->config->supported_interfaces,
+		    pl->supported_interfaces,
 		    (int)PHY_INTERFACE_MODE_MAX,
 		    pl->sfp_interfaces);
 
 	/* Find the union of the supported interfaces by the PCS/MAC and
 	 * the SFP module.
 	 */
-	phy_interface_and(pl->sfp_interfaces, pl->config->supported_interfaces,
+	phy_interface_and(pl->sfp_interfaces, pl->supported_interfaces,
 			  pl->sfp_interfaces);
 	if (phy_interface_empty(pl->sfp_interfaces)) {
 		phylink_err(pl, "unsupported SFP module: no common interface modes\n");
@@ -3938,7 +3946,7 @@ static int phylink_sfp_connect_phy(void *upstream, struct phy_device *phy)
 
 	/* Set the PHY's host supported interfaces */
 	phy_interface_and(phy->host_interfaces, phylink_sfp_interfaces,
-			  pl->config->supported_interfaces);
+			  pl->supported_interfaces);
 
 	/* Do the initial configuration */
 	return phylink_sfp_config_phy(pl, phy);
-- 
2.53.0

