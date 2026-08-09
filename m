Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C3938C43A
	for <netdev@vger.kernel.org>; Sun,  9 Aug 2026 20:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786307493; cv=none; b=kbXV1vLX1jIPtV7v/o4A0D3Bi5kMdkFNLUMLvZaTAt1XlEetdcVukATiPu26KMu0lWCf5riW/k3fsjOghOM4TqLjGLHeQVCwCfo/0m6iXAATyp9vx69w/91788aDkM5dKoXxzkmvcT69LXtXnzQLpGV6jP6jTMLM5joDdIVz+5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786307493; c=relaxed/simple;
	bh=NH+vbbaxZiG6Y0t+Ae1nwybjPC/wrZUjqEzfT2sfGrs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NiYA+sG4KRSAQp22pc4lkG6ZZwTCfaJaDXAjuwvoa+Wd5IQ6yq1s3jp//FiokmEtSMs3p9hl3r4iunIhOLD68iHFPyITI6prAL2fbTj8YOJo1qInQI8SFEQaiGyDXFhkuvmk8iBUkXJdt52b/vvO39NhJSkXNLPnLYVeOqO0ofs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oo8y8Izt; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oo8y8Izt"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49557167508so9526375e9.1
        for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 13:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786307488; x=1786912288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tBl3GBctv61bQMyEd2S/uBaFdUwcRcdsqM3BfaYguhk=;
        b=oo8y8IztUWaG8tUTvu/wDsYiXXoInR35quWchXPlHGh0k+dJGaJtma/hXrTU9x+MlI
         r2aQ+zToLRDCj8brSCicR/Y67FOj2Ayn+e1SoGbMBKVXCOlKefjmtXK2AI5eQ6Z/g470
         mrHK3j865O9tfR4f7zGfd0DkiBEuumieKfKT4WhSVCeflSVZZ+Lw+81073H6j68rVOzL
         l65CXDKvJZM0HeuOeM7CpNFRThOFDBjSLvrszFHCkYUUlkJzd2Jm2FFnwcN7KaDKcQGj
         p0GvjOFg5Hi25G2AtQ1Noy5evHtoABD/vf2qR6qhC5ZT3UJ9xtrB2nEx0GB34wzctlpB
         7VLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786307488; x=1786912288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=tBl3GBctv61bQMyEd2S/uBaFdUwcRcdsqM3BfaYguhk=;
        b=ooH+1ixSs8aY8woqA3n+6TpIHROiOBG6Vnc9j++5rRr3SEva0Cg9zgG4KGM0pigpmE
         aaAU6+V+N5JgADyOkbOGYIrpTZNioIMNDAQEe4AZ7Q4Lr6drpdJah926HAeP3bmND02r
         IGXbTqqiM7BpgkSIMfLq/9PmFBwayv+nLchhKPML/7rlpe7qajKXVWdl4dnJBInCDly3
         yN81J0isNtDEZCtHDps08GFpgNXEZOpVAte8DvL0yk1gtCt0PxUmx5v3NV6IG04prGEH
         qKX3G0B1Z7LSzqkOQ1Jirp4LRTjyGOSg8ZrQcCmaB2/F6oaKUYZuGll0dGyk6WkcwUsb
         D2VA==
X-Forwarded-Encrypted: i=1; AHgh+Rp0NtenTxOfqLajdbqKQ0DJRF81C3aXcYpZD4rOG3gaacahaKofJ46QrMsz2kZU990t0tGM9Co=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKPNs4qYtlRTNKwU+YrBcWt1vYxnP8iBvA4eUxiNnBrH0cTwqh
	nvDvO4prEY6Bi3v4/OizuLWogtGIdhm7LRiZyeT0VWhHOGRlKHwXSIlZ
X-Gm-Gg: AR+sD12tEyoA5dcOdqo2as1Pq67djqj3VncI9gOD7j0K9od/uViHYLxz2DQxM8XAPsv
	wAb+Z5X3IqKiB1X2VQpOMrOpm6sPdABiiopmBNcGE7zXLDKKIVUAuy3wILpCoRkHUQZN234+tkv
	DRv1O3HOeHeVdK/jzwreCzLfQCEdkGtYmdJu90Lzh/0Ck3inIRxeStqmWQBwNNHZTH20hlAnRmZ
	YvkaEXTrA3lKt8kljSNLa3+zAvMMXaD3eyzLhcfOxiwv4zpv3BZo2IUlKnNjgcbkGK/QJ9LfmMT
	JmIuYVyasHDpVnBNCDwHe1Ev0vgh7ui2RqW6J+64ouR3Khjqsof4fB0bs3ASFy24lw1ugmuMQE5
	l9q6c4J1gBttF5LMM1ePvs5XaTnd28GGcNhFJwwUG4nFs7u7pMomVfeHWat9SO1S+SHKKHlyBbV
	PwpHw84xfdVgsSt62ho187UjUJgqLMx8L6HzWHzMhWyycaGN3BCT3oXkaYtDXLzITqbCeNkyaex
	RH6r+sgKWUG82FcqiXgR6CHFH34gjqoo18hA3npqfh+2qgz
X-Received: by 2002:a05:600c:1d23:b0:499:51b8:d649 with SMTP id 5b1f17b1804b1-49951b8d652mr428256435e9.3.1786307488474;
        Sun, 09 Aug 2026 13:31:28 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-87-20-3-207.retail.telecomitalia.it. [87.20.3.207])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4995e9ea92csm229357065e9.4.2026.08.09.13.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 13:31:28 -0700 (PDT)
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
Subject: [PATCH net-next v12 01/12] net: phylink: keep and use MAC supported_interfaces in phylink struct
Date: Sun,  9 Aug 2026 22:30:58 +0200
Message-ID: <20260809203116.640271-2-ansuelsmth@gmail.com>
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

