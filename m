Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627383955D8
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 08:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786610155; cv=none; b=n1M+p3nE2F5Cv2w5UWzKY5Kbp71hFXwWRG3YBV7tlxbjZRDys4GUXOSDtBcsEFzLI3xz+RPd+7AcM9RdOmkWLVPOyQNDS9wz8WiBG/psnpAs9NtApuuwFH8KZRlwetHq/jH7T0N1ibyKM5SlXBaxQvVthBybQKK8DwFjHnCDRBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786610155; c=relaxed/simple;
	bh=tsB4HQi0KPrvRj5bS3vbG2Y9sYy8smbdIfgZoiMs6v4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lhB9LrbbEyts6wLU8BwYboMmTZFgZ30+bJdL9E8EILMmxkqRQMbXcB5F8LnBWVflimBInWMvwm40Y4naRqQCBToeDtCSZMn15i8/pIcuxPUr755KVHEtQn/EF8a0C74tV7GKDoegwpiDBqpwCDfetfGMBZPrZBIlbCouOyO8M2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k4o/3EXw; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4o/3EXw"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4994c49f588so6644035e9.0
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 01:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786610150; x=1787214950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kmNJwBBHheDDW2AFt9/9ZIdRf9AaEJM70d9DBjkc5RA=;
        b=k4o/3EXwddWafcxXWoOtAfkeKMz45YjAzYqgqcEWYQH+O4Je9gnihv0DlTyRQV9Zar
         6tdhfkYN3fe3nqSeHK8sj7qfoK1owuL8b1tD/CWEfMkWuhOJxE3nta6oKn5a7COSLen5
         fdU/kW1NfNZr0V2whRWe6kp4OZ2bjjKnskh9IQ6iSru8nzm2daWN/OC78JAXj3LgfLuz
         wezbeORw0LIb79dKJyJrIFMNvrUV8MaSGuH8CfJwJkqWL0iqDsS9hDLuNz+csY8Pm2ki
         TBPztj7FDHRQmVCcfSVQ68t8MGBgLOl/povlv0sQXeM7vJ7rry1UDta7G7JF1guaBC5n
         a0lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786610150; x=1787214950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=kmNJwBBHheDDW2AFt9/9ZIdRf9AaEJM70d9DBjkc5RA=;
        b=HHz+98mp3h8y/z+La+NKfNz5hzXJfIXGuA769D1gXHSgZRQ7Y/4COQUkjVAOAL8wrE
         dyvBvFsrSXPJXppbtFWIaP4CEr/d3CA7N0QysA5FDZG2E+ZeSI1WB/iQCyxN+ge+fk6N
         eRIVDW/J9Go4IBh04+3ulkC4yXatWcO+ROjIrkstFmQlvDcsYm0tBi4HyF9Gfna4Kqsg
         Z3z+32FyYEW1FnwLgywamSJ4FQ2aqns05ur1kewtHjUW3IS+d5Km+kU8QJoO30sOAR1Q
         VZsi8PZDSiVekoeWceTWlMSAhQMfzPRiFPM+WAwDcG31m8bNI35tRNDlPyfsJ3cHALJs
         BWaQ==
X-Forwarded-Encrypted: i=1; AHgh+RoVPqwrBqQMnU0VT/MhXbGoJ9cx6Z3AVG6u/xOjD0q0oqHXjToM0kpwM9qZTo4wmQ4KMgENIrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEpzQ8SWPhNEvACg2843KGz4qDRkJ2IGOXw0cDNMfNictknrrO
	G8n/APUA8LQkF+uzq3lRp/XReunbRL6A25bmHVAbqCpQnVnxYlAA20Pp
X-Gm-Gg: AR+sD10gf8NqkK34js3JZT3GnBK6PMP9i6B4dC6BXXgv0RksAL2dnicOffAgk/JNGiE
	RF3BcBWtpyASZozFm7AoSkE/bXuUAicJMgGkPb6Y8qSwMAhdUKkkzPKwUsIBW+Renyg9/VBMw6S
	YSf8R1+PKuh7UvMZ+qygiGer+PUM7Gx4YZttUPtTKPzd4c+bpm1QTVoUAY2YTRGmPH0uWZyvUmf
	aAhFhxTsOCYyH7pwds3IvZcvBLrBCRmMpRfWwUOqEE86b3qHLq07J2xfAdyxhw81+ZC/mrpItHL
	XdqazbItTRz17qTA8MiEdd5obldqcxiYigWEEQGMnPm5rNpFEc77JYQSNZXflYTb0Zw1iKydhDT
	Ce9OreILXaO4GZ1/sWiuvd+sBbZXTAIFCt7YcRKSQnLQCQlwOsuHsAj7pQqnwFLsvcwsxn5payX
	F2hjTL6Ql5fmv78saOa9U4W0RvF4dTIpciHKkU0ZhhqBzcK9TlmFzsmQFIFARQpqbW+WcowNH/F
	ZnAnK3K5YqT33RsT6VQRsCxRWIT4WwLGV3i7f4S/4/vbGSy
X-Received: by 2002:a05:600c:1546:b0:499:5f80:83ac with SMTP id 5b1f17b1804b1-4998220bc5fmr32213365e9.7.1786610150509;
        Thu, 13 Aug 2026 01:35:50 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-87-20-3-207.retail.telecomitalia.it. [87.20.3.207])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4998216d082sm45804425e9.13.2026.08.13.01.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 01:35:50 -0700 (PDT)
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
Subject: [PATCH v14 01/12] net: phylink: keep and use MAC supported_interfaces in phylink struct
Date: Thu, 13 Aug 2026 10:35:06 +0200
Message-ID: <20260813083536.970196-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813083536.970196-1-ansuelsmth@gmail.com>
References: <20260813083536.970196-1-ansuelsmth@gmail.com>
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
index b241768edbcb..e1e9f07f51bc 100644
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
@@ -1903,6 +1908,9 @@ struct phylink *phylink_create(struct phylink_config *config,
 	__set_bit(PHYLINK_DISABLE_STOPPED, &pl->phylink_disable_state);
 	timer_setup(&pl->link_poll, phylink_fixed_poll, 0);
 
+	phy_interface_copy(pl->supported_interfaces,
+			   pl->config->supported_interfaces);
+
 	linkmode_fill(pl->supported);
 	linkmode_copy(pl->link_config.advertising, pl->supported);
 	phylink_validate(pl, pl->supported, &pl->link_config);
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

