Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8D445D1BA
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 23:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790290949; cv=none; b=EyDTxfpSl7BQUrxN0ZHiF5jwf1waoXOdwoUcemCeLMnG/Ds5xKVA7w369dSKkOAWhb4lDCJ5NfSKeFZXUyyUIiTwclkT5c751Jsi3wenJ1nphSvUPCHTqkrftp1v+GGKr0zSKK0RXJjtkvyS/N2C1JYHmXmlYkd9Q12EZKkcLi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790290949; c=relaxed/simple;
	bh=Qk4gUjoSQ+NjYnI3ptfu96ovUTocgK6Wl7UebfYEMJQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N90jKCrd2+4PEUlwVw0q0WXZvJtTV+KMssh3C8WJWEdQ3QLSFKNxbjHzKKBY0tFzHLWg+729Pm6bNuvCYQo6+IPUijic3NSuuQnUPF8ewMQ3M2TULR8j0N6lZ1muGXfp5IlDAqy4TCDWDapAkzoJCJY7n0mjkGUlFem7tf4ILLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eq3Kuj0m; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eq3Kuj0m"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49ccff31419so2921405e9.3
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 16:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790290945; x=1790895745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=b8iZrjI+sv0kO4V1v7dMASv2fJp8vatl+BnwAIAKYts=;
        b=Eq3Kuj0m75qyQFyHkJte29mepOsimcYN3fWlle8coH84pToHtnYwgV+ImEnUApt6UH
         unKBmwWslu7EVBa96vtUI46EmwRbZZRcCzbCTMiMcP1x4eZ2Tbg4SQcIZnH6n816pLle
         jySRzDpLipbpOsbW1nhPDpiPdxBbBSbvW+RPovkTbWqPRYq0hAIA/VqGj/eClkBIdXX1
         B8b14DoWiANwV4mxiRgBdT2qooGSVXa2kelmiTlZnBmWaAj4jC2wKXrJgtRN00KwuuIY
         KTW+BgvxciRM9rfxehVKersB9MzwS7Yynas/pEG4C7tqTyRJhwCrQLtmCvMU2nc7pkKq
         iUFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790290945; x=1790895745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=b8iZrjI+sv0kO4V1v7dMASv2fJp8vatl+BnwAIAKYts=;
        b=Ayghue4ytd3FZBOg+dDqMgK5JaEELRI9NyZfwyAgaz4SmFbPJ92xeLA8rOqHdwccfX
         P+HztYvmQIRkwC+KgFc5iuQTrRNCWWrU0arFtFUqMI8zmP/ZsNknIuMGK04P2K8KoFqD
         T4arHf9kgQ013rl8hnnQ52T39LigVrqBXoYc9aIHEejIvjfyy0OzpbT+Q8RPftqM/kvy
         Oe7CPDrVKkiOCLYrIMfYP1vZT4iQ+qyMY9wyeOLn7hGsUMgSRvTgWrQtn30sl2ynvhhV
         XzCvNRj6rYatNeHOrN1BCJbcyvUo0p0ZhyrTTY8ttZybQd5di+fe/nukHjqtGVFzmGWw
         IkSQ==
X-Forwarded-Encrypted: i=1; AKwUvByxex4GxMRvl6oAysxaDlYRDej2iXZ3z3JGMDeQhrjzQx5zg/ouPGVZraVavelbwwD36IP83Uo=@vger.kernel.org
X-Gm-Message-State: AFuF++mviu1IQo63C9LbwJyd45SRHshtigqZG6kkg4Clzs/b/4GvWTDM
	8dO0pXr8YiNtM6vESj6Cl8hyx8rvzN8ruFlmpzw8XunIEIrfqVcY8yjb
X-Gm-Gg: AYBFou1u1nuvt9tnOohDn4317WzD5ofFPadWtoK/QPhxbGVZRMOPl2+zoK29mSUrvEU
	WrTIqHYkjUbdboNWvAZQFISAGk+5w7rzAvMcj3tSJ5eixp7RhOraKjWxrWxjOJ6jFlR3rsVvJvN
	YAEm3jZIkmqvgIHPeMzxgx4flxNuBhmyxiIiYVjdF+8qvZe3sgsAe//iNNTR1tL8Gb38XFWZn59
	yz6S4ek1udGALHINhE98rtCJjAWNAnxsOE+mtrTQDq3UxeSI8JHmAReDo8x0PmgRVd9zZBj+I8N
	DftENBqZsZFgQ3PN0dgFEe342cl03uMLO+d7X8MqX9IZ2jJqFPrdpuHN8Qu4s2wax30wQuFiZ5s
	Bh6nbnvz396hAnWkFWYdr0EvW3TqV+IRW4hI/WMTfFImdxdNBQXdnEoPtkY+vMpWdDsVDvPjX4c
	IbDMZDWK2fLSN7s2qma4UeBeBoFjVMsNxLGOROCbkn0ZJ/kkOGGleE3iK5J5vFuqNVFxkBDn/wQ
	/OchWOqn4N9ejpr2bjXvB/hQk3PPfY8WrmjpR8lpWs9csBjB200cEAHLOrB6VIJ
X-Received: by 2002:a05:600c:530e:b0:49f:bc28:e8bc with SMTP id 5b1f17b1804b1-49fe7bab945mr63722815e9.17.1790290945335;
        Thu, 24 Sep 2026 16:02:25 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-79-29-83-136.business.telecomitalia.it. [79.29.83.136])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-49ff06cbe57sm12288175e9.13.2026.09.24.16.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 16:02:24 -0700 (PDT)
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
Subject: [PATCH net-next v17 01/12] net: phylink: keep and use MAC supported_interfaces in phylink struct
Date: Fri, 25 Sep 2026 01:01:42 +0200
Message-ID: <20260924230211.11519-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924230211.11519-1-ansuelsmth@gmail.com>
References: <20260924230211.11519-1-ansuelsmth@gmail.com>
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

