Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3414A4734F5
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 13:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786108402; cv=none; b=LJ1o/GFOc49qDd1qx45Bqb7kAXr9i1yh/NZI569JP847U3s0BZp78iCSCNTPotU0JX5LHhJS+JPinpvjcOzzaBmKDN1VD/i+wAUAaUtUcfR7DTGtUWB5A3w29eg7eDhz1qTbojq7SxJYH7uQLDfmc3ysYqFVaTkzW9Pi7nN9nQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786108402; c=relaxed/simple;
	bh=NH+vbbaxZiG6Y0t+Ae1nwybjPC/wrZUjqEzfT2sfGrs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UhftSWoBlE4ngmk5Fs5fmAToLVm8hiWQRhBpGqfl0YKEjFG9ADz0WD0AYxywyHwDmQmmDwug+PAdNOLzIKW7ztiOvkUxaUZryK3xaf7oaRAnpRsSq7M6XLIqrh3Jh2NtU8+7TbOl2yt8EAjF6BUhplO9AvCmy1Hdh9X/F7aGk4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IlmkawxR; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IlmkawxR"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4953e04ef16so33882565e9.2
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 06:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786108394; x=1786713194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tBl3GBctv61bQMyEd2S/uBaFdUwcRcdsqM3BfaYguhk=;
        b=IlmkawxRsT62aobFbJ4plJeaOL3z5PJhXmki8EuAS2bL+/Q1hCJC4VJ8UKl/pH2EHZ
         hCr+sorVfmZoc09ADNHqMufsitwgkaiEhMHI18verzjY5+vJRPogmKaPNUbLrY0oyXpR
         /iQCrXyHX6DwGzTeCmZsq3WFH5GV/wcH/NsH4t/7oBY3hy+Uj/McjYtwKAwSvE9opqSA
         d3on5MehzZQ1+dw9n8EoBun3OHP7KVfbpVmH6INCGbgYkamHTtLAvmRpmBk9REN5Q1Yh
         9oj//QXRk71UbqyIMyViEvkmut1FRXN1sAgwTWSITzbMW6rnFkhdJ4epCBxbEqdTtYYC
         IgtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786108394; x=1786713194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=tBl3GBctv61bQMyEd2S/uBaFdUwcRcdsqM3BfaYguhk=;
        b=euKqDR06BbUBuvYOSHd7f0Y0sfbYc+2P1Gg4xrfTmoHYXdipn5i9Hw8k7NrZ7aJk8p
         4YhNo5wUJU7l81lISPi9PxfU8dfWIkgxjFkfw1U5lyC5DIYtITi6h9C6nUdktZ4XBH7z
         R4NMl0SGE0kYVqDirsP6qgRXJZmC4kRM9qaAMkX5R/N6x7BZiVSPr42c5RFV6eVIOfIr
         Kf61xiIJcgU2vKxaiOfsuWlAjuWceWfofuS4VTQMwwpiEjn4RcrOMVB3cAmEbttWnvG+
         R31TG1vTTq3l7E3S7wDyiP05j66NMjfO7e9p1CiUvb9hnngPzKLZuNZ4ld1Troo6zceD
         RCVw==
X-Forwarded-Encrypted: i=1; AHgh+RrZCtUlUTLLRfdOJLR7uMeQUpoKvyS1tNNnpp29awkCTTLGLliW+E5MVvk/TtgMsUPy2FRGAgI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIwGpMm1Wia9NraaHplQRimITSpfliL0vCozH/g00faSh5icAY
	MFnmWqG7DQcLE5pLAzLc9JH1G180DECnwsB1vleQZM64VKPUnFSfX+ct
X-Gm-Gg: AR+sD124Lw+MdJZbT73oOqXFhdx2LoJz5xsFhD3mo2ZHvSWVdZ1yT5JT8DSv3UUu/Ft
	DXkL5LXFiBFd7yNZibwBwOBro89wKzFW+Z4z4pORE47KDTiHdG7jkynCe14/+z0+DNXn2UoZruX
	CQB0/rJOEaUgaBMQbc2E1G0tR+tE1+YC/rh+KkHwTRF9nfp4TIe1SLukbbsgcjcZQ196BWR9ZZc
	OoBZ/ro9pXLd4RPNgqyaq+RzwNARoXrRIqtoF1XZN13tWH+B/9ZB9zpL/2OIDuONLZ3shC8m9Ap
	xboh0go6bGoqY99q4/0NfoaI+LNq9K/hcN116E6qcp4UkS5x4J8wiXVGywPRflWOwB5GYfXOP2B
	vxUetmBBxgzzW6TFY86O7QbYH5szKpoN3rL4o94Ty0kTVLtkgvwVylMZpQ5Ey0Zt9/Lap1/eZlA
	bAGw43YwqiIDOhKlB73rch8RlecmYivS5nYkyXrkggitrlrcrwCk2cXwXgtWvFOcKtyi/7yhmgj
	Ban6HdbDQLU8aJWZSGagPp7Q6En5cPSecNwrH8nklRcGiorhk3xgg==
X-Received: by 2002:a7b:cc0b:0:b0:496:cb48:5eb8 with SMTP id 5b1f17b1804b1-49959e38ecamr104184045e9.15.1786108394327;
        Fri, 07 Aug 2026 06:13:14 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-87-19-255-168.retail.telecomitalia.it. [87.19.255.168])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4995c7b2b68sm58827665e9.4.2026.08.07.06.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 06:13:13 -0700 (PDT)
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
Subject: [PATCH net-next v11 01/12] net: phylink: keep and use MAC supported_interfaces in phylink struct
Date: Fri,  7 Aug 2026 15:12:43 +0200
Message-ID: <20260807131301.192060-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260807131301.192060-1-ansuelsmth@gmail.com>
References: <20260807131301.192060-1-ansuelsmth@gmail.com>
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
index b241768edbcb..b7180ae76cc8 100644
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
@@ -1878,6 +1883,9 @@ struct phylink *phylink_create(struct phylink_config *config,
 		goto free_pl;
 	}
 
+	phy_interface_copy(pl->supported_interfaces,
+			   pl->config->supported_interfaces);
+
 	pl->mac_supports_eee_ops = phylink_mac_implements_lpi(mac_ops);
 	pl->mac_supports_eee = pl->mac_supports_eee_ops &&
 			       pl->config->lpi_capabilities &&
@@ -2024,7 +2032,7 @@ static int phylink_validate_phy(struct phylink *pl, struct phy_device *phy,
 		 * those which the host supports.
 		 */
 		phy_interface_and(interfaces, phy->possible_interfaces,
-				  pl->config->supported_interfaces);
+				  pl->supported_interfaces);
 
 		if (phy_interface_empty(interfaces)) {
 			phylink_err(pl, "PHY has no common interfaces\n");
@@ -2824,12 +2832,12 @@ static phy_interface_t phylink_sfp_select_interface(struct phylink *pl,
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
 
@@ -3757,14 +3765,14 @@ static int phylink_sfp_config_optical(struct phylink *pl)
 
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
@@ -3935,7 +3943,7 @@ static int phylink_sfp_connect_phy(void *upstream, struct phy_device *phy)
 
 	/* Set the PHY's host supported interfaces */
 	phy_interface_and(phy->host_interfaces, phylink_sfp_interfaces,
-			  pl->config->supported_interfaces);
+			  pl->supported_interfaces);
 
 	/* Do the initial configuration */
 	return phylink_sfp_config_phy(pl, phy);
-- 
2.53.0

