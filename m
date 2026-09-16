Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0555A509EFD
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 23:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789602737; cv=none; b=Z59DOD6wHZtokkExJPjeeUDaUoVSBVCgjMMxmKXJ6ObM7zucfInwwmBhKL9Hwzfnq4hLediLOk6v8Ygky4hsTad/qaI0HJzj3l5INKOXfruSaNX4N2DA1jpNj46ImWEF6zR/KCk7YOak/ULzyWHvUSKDM2mkL2Zk2KsI1bWj3jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789602737; c=relaxed/simple;
	bh=Hx9TIRdPyOWp2JCcph+UWaHhkA7sNcruB3L94/kOINc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a/axaslSMbI8+2kUDHbZ2B6rWj1OLycLhAN2vS413RdDHg7jMPGy0Ql1QrhWsphzewlJb/tsxOCubEhG53MYLlCbcKlATNeUpE7IsbaRQtqoU0XwU0RSTAtnGoaAlLEbFASEHyDKiePSCJ7Qpdj/xgJeOGJAGd+RQcI50vjnkPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JEb999X0; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JEb999X0"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843cedd129so169811f8f.0
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 16:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789602734; x=1790207534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4CVtSRo73kcxXzyXjS3Uh97Hci0HJhAxnJFberGLSLg=;
        b=JEb999X0KytLGOkY0x6IW1uK8xXIaKJuZWj5o7ofoiJ8ltzOTJSEJv2jlZJI+fbabx
         PBveXUfeKOSA8qSlr/FgXBRhXWRnLh1rKfdNcwzaNfM+ATnXbHUr17b5ZDs9NEkPlnq1
         YFuBbQPG2jZpHPvzCmvYrl7sCzRwiyLt6VRe9z/ezkx2pI/hURe92C6EM8ZyxMmSU0Cq
         cWms72kh5jJKa3hdNtyN4l8tAMdPe+hT71CvKr0k0sQ4hqpGuIzZwVRW9uZbltQCLjfQ
         8iWTQ/sgL3FFOhWd2bXa6uvoOtzsr6gIZz8FZeD0/nYCEDSHVbHzSinXWVZHqhm1R6cD
         CWKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789602734; x=1790207534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=4CVtSRo73kcxXzyXjS3Uh97Hci0HJhAxnJFberGLSLg=;
        b=BmIVNegLx5WTUHHBecTb8cbbOZNRMn3vbDuYn3dvcx4zwCUPRELWk2zGrWwkv4Dbv2
         SMcwJ0dRBZEtHCXxINvU40uImffVL1frPwr7Q8vXCcVcAaTeZsm3KjqWjThOhd5QM27x
         oG66GxA6lgv6xeXKdjWpVYBdmzCDTFvwwxxxNcjl1ZrC/cTV3zVwThc6VtsRqlLlJMWX
         4xRnCP2tFSemA0RubhXXNxJgEuwG+yC8en+wsTz93BX+Qa/r2+DbfflYfJk9pI68iXIW
         hSsTN9sG+I/vEqoRJ3AdLWMGM15g+7a3BWcOqIKlPIne9cb27FGkHX5UhTvFMlSAZG3s
         0uHg==
X-Forwarded-Encrypted: i=1; AKwUvBwvNCz0TC6Kr62CmlqyhYt54SYuLU3n9B7FCJcOdlSjZuuhoVQcCK+TRVy4KryphfHJsxXd2DM=@vger.kernel.org
X-Gm-Message-State: AFuF++l6fezDSu98uAWaE3o1dVOt6clOLPqJNLOapXZ1TEk1UcvcNZFp
	MwxM+DadF/Ht2mL7BHPJl8HqsU05S8F6uCs9TxgDeIcvI+4UJpL85pr9
X-Gm-Gg: AYBFou3Ibd5NjWe0KGXLfpQKxlkm+oVfUHupeKHvlEQF5haIZOZ0u5XdIOOgjl+qEwJ
	rt0aZQaQMM7Ey2oO+4uXIbuleaj9Nvml2Zsh8yXwi63dqPIKCB7lB0LiJ2uQnTjQcO2LUsOAv9O
	hcm8P/Mj4S9Cy6II/CZvabRpXU/2TYngxuh+Jv8KxMH/P+OGGfXO04mpC2v60+BffSdS3Ya6g1c
	gPfJBN1UvQ1gGxhrbW4TQRlEDNy7dIJ+epzcLiYISWDqzISiQQ8al9DYNPRiDhzOq96si3PuaSB
	vHi5u0itJMUcwFlKyMuMZZWkcoELW/liIxVFmY50esvRqmMlO4MiP39bocybMfTJSbjUFWb8ZRT
	raiC2VQROg3IGocUoCWrMn1Ea3XYVrb33+yz3JLg3XVEcb6NsN3NTD9Q9f1Kh1dOFUFWN4FQXxH
	iiFAq01YXX2H3M2ymGI6ujM6zVstEkWKqNR1gOUmF6FDuyinsosPnN8m27AhPIRfK5GIIj60S7j
	8Xk7+tgf5k3NGBLIdhOS30ft2E/vEofAMDzF6McGw6Ulpbf4CJJqBLvaSw+irM=
X-Received: by 2002:a05:6000:1868:b0:487:980:b42c with SMTP id ffacd0b85a97d-4870cef14b3mr9005287f8f.11.1789602734011;
        Wed, 16 Sep 2026 16:52:14 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-79-26-252-140.retail.telecomitalia.it. [79.26.252.140])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4870bef7687sm11861104f8f.1.2026.09.16.16.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 16:52:13 -0700 (PDT)
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
Subject: [PATCH net-next v16 01/12] net: phylink: keep and use MAC supported_interfaces in phylink struct
Date: Thu, 17 Sep 2026 01:51:27 +0200
Message-ID: <20260916235200.20712-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916235200.20712-1-ansuelsmth@gmail.com>
References: <20260916235200.20712-1-ansuelsmth@gmail.com>
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
index 390d3eb3e6f7..d67a5184c524 100644
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
@@ -2947,12 +2955,12 @@ static phy_interface_t phylink_sfp_select_interface(struct phylink *pl,
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
 
@@ -3831,14 +3839,14 @@ static int phylink_sfp_config_optical(struct phylink *pl)
 
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
@@ -4009,7 +4017,7 @@ static int phylink_sfp_connect_phy(void *upstream, struct phy_device *phy)
 
 	/* Set the PHY's host supported interfaces */
 	phy_interface_and(phy->host_interfaces, phylink_sfp_interfaces,
-			  pl->config->supported_interfaces);
+			  pl->supported_interfaces);
 
 	/* Do the initial configuration */
 	return phylink_sfp_config_phy(pl, phy);
-- 
2.55.0

