Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD824F55C6
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 18:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791570537; cv=none; b=uo1JLGOB9e2/EY5h5mkFXTrAzxtqQad8QrUGGiRzT/BcT5+EcwOBNFZmp9d6kvufvL4jwt+YK6xUnrigkCnm+fDbFzjjWbt/gBS9q+ihGL+n8mDB2O+YZPletJqRfgEvlNcHbAnFVVJN2uA3ruMnjDxmKHs6jjsQuVJLcJrzPck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791570537; c=relaxed/simple;
	bh=Qk4gUjoSQ+NjYnI3ptfu96ovUTocgK6Wl7UebfYEMJQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t9XxM+AUvH08K35EXEzeDSPRWbjV0MGzWLXYPsFCV83VNgSEAv7EEFiQR2tw0Z4MUM0Ygewx6YDS63bFBI/giw6tkYUk8BT3PvV/1Ix2ZpeSRwlU++aa/2lm+Q4at0rWgvDkVBUiG+zOR0v1evG6MbuKhK8LtYe9w0IVrdyXbtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OtxX3h0y; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OtxX3h0y"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a022fee0caso1742155e9.1
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 11:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791570532; x=1792175332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=b8iZrjI+sv0kO4V1v7dMASv2fJp8vatl+BnwAIAKYts=;
        b=OtxX3h0y//5WyOQhqkRb7T6mTIot0bbgloXn4degSw4iwf8aizikwZAh9pVgKfOJst
         pesh3xcY6WI+XUlKcTZBieYD0+i/YF7BSKn9qAP5Ulmb6opjgIqhtFYTgMhNmU3aJve5
         YG7mKTmMqYhJmfAgHw1Qjh65HLE2MEM11AkY1sH0DhB4o7RwmzAgqNm0H6jm2kOfwWkh
         VCFJ5lGPRcVteq/e3Wte1njtHV9Ux4eeEFOXQJlucKtirmQwkUGdV0vQo3gg8hNwH0bm
         oljw9upP2TFHoKrtVvRi0mb26O+ydcdmjtaM0FyOLRps0RvILvClBV1uV4HCEakzxUu7
         CorA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791570532; x=1792175332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=b8iZrjI+sv0kO4V1v7dMASv2fJp8vatl+BnwAIAKYts=;
        b=Gg0/oQFLBwUMuVic+QpQiyq7lTHgUmj0UDGqeMyvmnUSSOYfGlS/LGoPNgMsy+8ouv
         akeoXy5C6oUEJfllPGmRqAV+VicbxWMmunGAEU+J6lrQkSmUVbsLtswMc+YlQ5kntDZd
         AlZHukUedsD1O1tpkCGpPeazHWqHj94xBErBNrVuIRBIwDQ/eXuuqodA1O3GoHCFwEYC
         X4N0fVyECZM+lfheooUfsLoMCWySIJxa7YfbZFh5KSww/2Q2z0LMGG+URld/LXlBMz3z
         1DAEG+oyeadY92MtrI1HXPv1Glg5e0EDLcv1AGkXALiCbEbB9fVSNImxPxejz5msqAum
         UkWg==
X-Forwarded-Encrypted: i=1; AKwUvBzzqv3iGu+HAQBOvxgbQ/VoEEi+KnXRZ5/tCq3XpDfx5ygfG/ttXdlVTKhIBP0FUkkr6O8MWnw=@vger.kernel.org
X-Gm-Message-State: AFuF++nxGAozPaMpZEwbd4ZtBWMWaRVWBbo05vlkZN0P8yvUrN0mgoHZ
	5E+3+EUY6rLk3RE05bqvOhPZiJhewqncMt2kPqzggZiiR/ul0zn+Cl/qSjyv+g==
X-Gm-Gg: AYBFou3UEkx+XWMmyEd2IkuZwsj3N1ZstvlGO/HWIpGXNcZA1sXCS0qJCWRMNetRigo
	rbsw+sc4JGobcxkqIth4mhiXWHtIaUMCKNoU2VMrbmBW+D6QDnSn1MX4LIflHlh6j2QfyO1R7UA
	xPIVSKVCEix2Zo8sW18056WZYLh1Yg7c+7Fk+AvsfER18/qHoKksWSombOMoYFzspOfJG5I1SdG
	J2g/uRXYY/g4hyqcTDpktlUxjS3PYBE8hQ6uWuo5nbgt0rjoQqR0CHQCSXAEkhWQDLT3UHvN7fJ
	FjXUiUU3bjP2KHdLjWAPs8wF3Unf510dzmhXRESDkNrAkouHdwjF4LfCYEVfVosoITVTpm8Ds1Y
	X3i/UEqzy2FG/o0mm5cRPQKwiiMT8VCJSPYHgvwq44yziYG8e203SqVP65b8Z8jmngHPc+thOGE
	NcZOGn74c1bRjCw0v1wYaeMrnq2RTbcUoxv+W4HFQFQfVZB6Ci/hAzsiXyXt27e3LanRLrvNrHx
	oL9XMMaOD4tBrD0NV2OQHBQ7hIWyV9Gb94/KMhqD1KKQcXtyc8kvYCUf2pi3rSisN+KSxAtO6ji
	d9FOyS//6v2OrWmGqg==
X-Received: by 2002:a05:600c:8184:b0:49f:ffd0:4039 with SMTP id 5b1f17b1804b1-4a18e4f2221mr40285605e9.32.1791570531906;
        Fri, 09 Oct 2026 11:28:51 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-213-45-9-252.retail.telecomitalia.it. [213.45.9.252])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48db9adf5e6sm5037794f8f.56.2026.10.09.11.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 11:28:50 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
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
	llvm@lists.linux.dev,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH net-next v18 01/12] net: phylink: keep and use MAC supported_interfaces in phylink struct
Date: Fri,  9 Oct 2026 20:27:57 +0200
Message-ID: <20261009182836.50631-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261009182836.50631-1-ansuelsmth@gmail.com>
References: <20261009182836.50631-1-ansuelsmth@gmail.com>
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

Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/phylink.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index a7d086cdc9b2..a98e62fa4bd2 100644
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
@@ -2026,6 +2031,9 @@ struct phylink *phylink_create(struct phylink_config *config,
 	__set_bit(PHYLINK_DISABLE_STOPPED, &pl->phylink_disable_state);
 	timer_setup(&pl->link_poll, phylink_fixed_poll, 0);
 
+	phy_interface_copy(pl->supported_interfaces,
+			   pl->config->supported_interfaces);
+
 	linkmode_fill(pl->supported);
 	linkmode_copy(pl->link_config.advertising, pl->supported);
 	phylink_validate(pl, pl->supported, &pl->link_config);
@@ -2147,7 +2155,7 @@ static int phylink_validate_phy(struct phylink *pl, struct phy_device *phy,
 		 * those which the host supports.
 		 */
 		phy_interface_and(interfaces, phy->possible_interfaces,
-				  pl->config->supported_interfaces);
+				  pl->supported_interfaces);
 
 		if (phy_interface_empty(interfaces)) {
 			phylink_err(pl, "PHY has no common interfaces\n");
@@ -2961,12 +2969,12 @@ static phy_interface_t phylink_sfp_select_interface(struct phylink *pl,
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
 
@@ -3845,14 +3853,14 @@ static int phylink_sfp_config_optical(struct phylink *pl)
 
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
@@ -4023,7 +4031,7 @@ static int phylink_sfp_connect_phy(void *upstream, struct phy_device *phy)
 
 	/* Set the PHY's host supported interfaces */
 	phy_interface_and(phy->host_interfaces, phylink_sfp_interfaces,
-			  pl->config->supported_interfaces);
+			  pl->supported_interfaces);
 
 	/* Do the initial configuration */
 	return phylink_sfp_config_phy(pl, phy);
-- 
2.55.0

