Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117E03955EF
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 08:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788251420; cv=none; b=FGU085raJFPpZ9irqf7FOZxh0d5HNlxTkzdscd3BmZiJ0Lb/QQWe0zkRjOm7QhEo9stKWKCq7XE0R0hzKJVyDnZGnc3Tvbjek5JFfydRDBUZ9ttIHc7z1I3Uv1pd3ctvq0hiERd600cvUa8Qj2dgSOSu+HA7WGEUTJ8S2/oaavs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788251420; c=relaxed/simple;
	bh=WmcKxR366QifZfmN82COzbRyA6rgiThjX8rzkh1EBYU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z8Mh2PqZZmXOQ6hmUhiAMvPklFi21rbsbq2n9daD3RqVbLOw5w6PzCY5GzwWAaShFub8TSzBxF2FobPtwMJ5sBHxEVHFfY5YSbJGjMTlE1P1p3boYVFLZXNjqbV74iw6e+8IFeZa1V2boz2MAsqxOwH8Y2Y6MfQfNJaq4iNLw88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QLkwE+bl; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QLkwE+bl"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4957eefd361so4714055e9.1
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 01:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788251417; x=1788856217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YyxU6GfAU2OYJBof45H0mHXE5/R7CERzacXu0RY4THE=;
        b=QLkwE+blrc11Q26Sa8ryOvlCucEUZjmO9QMXIB3DdagXIMTO6IZoRX8m8GWRN3WhGZ
         0LCJlDzbysO1k4EPjqq5aE+nleDjkTA4XTFQmEBa3Aj9uTCAP9RFRPpyu/o/gNGJ4s3s
         6to2xVM5A/Pyo43WDJJgsClVak+Ynb+oqgOG4rDAW+BMytzsZJzDLmFKI8oHnyyNku2N
         we9wrCRJ8GOODqShw16BtLE8jKazjz6HMJSl4zYSdLWu3XY8O8BdgHvochbTDPWUkRGA
         nivBX5vDi4xCC62J0r5f78N9EVpJsqZ0OosqJ6IFC/08D845YRIRJ38sUo5lX+LpNICa
         jfHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788251417; x=1788856217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=YyxU6GfAU2OYJBof45H0mHXE5/R7CERzacXu0RY4THE=;
        b=KaEp33VGW6lkTU5o2nOAdHE2QbdYbjI128VEvPP2FZ0t4U2Qc6ykHNhw5xBSN3DDAQ
         vw/GHMtwTRump4qa85igPmg8huxCm7YO1YfM3trM2WWMBYMhmD07cYUwIpiVRJwCIfM+
         +iUNbTAKQdaOXJnhS2IzW0TKh9kGZgAc9fd8CEbu6Lsy6YRhkJbwMjmbbVubxWixW/Ac
         oX8//zdPyp2X5h1dbXXXltPHAyhCD9P9OqDlFIt4kjk2JrdggevBQYEFOaqOYgM3PVh3
         0lrChjYwBDjpCC6RMX99zEXMFMVlksKiN2fl5szqyo+FFJ2OOctg2DCotB4nkepKCJhH
         jI1w==
X-Forwarded-Encrypted: i=1; AHgh+RpzCaegirC3Ig44T+xE2qDJA/Rmp+LyDQ1iISRO4RW6ENMK3aZZ7Mccfkfz9F/vzP0kFXT4ZyA=@vger.kernel.org
X-Gm-Message-State: AFuF++lXDAVjgxXLKZwLZC01J6yTnPsn0ybIoXaPIXeadFtLMpUookLV
	+RXK0Y4h6mCajwuL7QUr9ZJY9xAYtMlD7VlSed7kF9jl/bhGaFjg7Ajc
X-Gm-Gg: AR+sD13E8XNav4Bqafb63JI5xk82jjQifGGlt2qIZIE3pQYxF2r4YLicRcpInONCQL8
	Le28VdaFpPXYh7M4gJ1eM23+Gg+JVr1xXCyE2IUbXRpJu03nl/6I7ihX1+Gx1W3Z7qTj1g6bWVj
	EOgJYsA+gvxsPFNoLk3CMTBkTs3LXrDx3QmmQCV7ajpI0KhFV9OZXOTnheD13K6K6irXnHYCVr8
	fmgcaZsalZ3654Rs+rNHNg8fw+RKAqwMfkkVBrijqrTqkruN0c6HwNKEi/6dSzhjxTVJqfKw4rt
	Lqoa1fyiJ3ZDIEYYakX937rNmWTiYPizcgCIHTqDy1r/fEqWraYVqdicA23nB7Vp8SCtNeprWBj
	KgFKYeZ3ZIsrKi06GsBNe8t1AtyJdaAaNkHqUxm09ywttjOzUYTf1ZPI7JUhhfUi6PNHzj1LqUk
	0NvnXPX4vI9m8olEXg/xsBvHz6moHpHzqi1rYhm6sm2hDTRawsZ8fYVHAV9WGLztwz6+5m9Y3wt
	ewwZkqSK27D6VAghTjslAJcjLmPJbb8b/tkpWYlLGCXNQ8TWjH+
X-Received: by 2002:a05:600c:4592:b0:495:5890:8f6c with SMTP id 5b1f17b1804b1-49b91c290c1mr378787125e9.7.1788251416552;
        Tue, 01 Sep 2026 01:30:16 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-79-26-252-140.retail.telecomitalia.it. [79.26.252.140])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-49cdce08862sm51459635e9.1.2026.09.01.01.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 01:30:16 -0700 (PDT)
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
Subject: [PATCH net-next v15 01/12] net: phylink: keep and use MAC supported_interfaces in phylink struct
Date: Tue,  1 Sep 2026 10:29:16 +0200
Message-ID: <20260901083001.8044-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901083001.8044-1-ansuelsmth@gmail.com>
References: <20260901083001.8044-1-ansuelsmth@gmail.com>
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
index 3ec3bb439109..7f7a7328124f 100644
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
@@ -1904,6 +1909,9 @@ struct phylink *phylink_create(struct phylink_config *config,
 	__set_bit(PHYLINK_DISABLE_STOPPED, &pl->phylink_disable_state);
 	timer_setup(&pl->link_poll, phylink_fixed_poll, 0);
 
+	phy_interface_copy(pl->supported_interfaces,
+			   pl->config->supported_interfaces);
+
 	linkmode_fill(pl->supported);
 	linkmode_copy(pl->link_config.advertising, pl->supported);
 	phylink_validate(pl, pl->supported, &pl->link_config);
@@ -2025,7 +2033,7 @@ static int phylink_validate_phy(struct phylink *pl, struct phy_device *phy,
 		 * those which the host supports.
 		 */
 		phy_interface_and(interfaces, phy->possible_interfaces,
-				  pl->config->supported_interfaces);
+				  pl->supported_interfaces);
 
 		if (phy_interface_empty(interfaces)) {
 			phylink_err(pl, "PHY has no common interfaces\n");
@@ -2825,12 +2833,12 @@ static phy_interface_t phylink_sfp_select_interface(struct phylink *pl,
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
 
@@ -3758,14 +3766,14 @@ static int phylink_sfp_config_optical(struct phylink *pl)
 
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
@@ -3936,7 +3944,7 @@ static int phylink_sfp_connect_phy(void *upstream, struct phy_device *phy)
 
 	/* Set the PHY's host supported interfaces */
 	phy_interface_and(phy->host_interfaces, phylink_sfp_interfaces,
-			  pl->config->supported_interfaces);
+			  pl->supported_interfaces);
 
 	/* Do the initial configuration */
 	return phylink_sfp_config_phy(pl, phy);
-- 
2.53.0

