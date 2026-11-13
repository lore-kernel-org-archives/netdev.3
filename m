Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794529950;
	b=TmQ+GrJKPx2BPfE4EUOC094kpsLRJrTfmFZn4KZSsHM5D8j6/h/xERhAoia2bWXRvdMz
	 SOcJKAUNsysCykP85yl49PZrzSzuQJB+s++jwz4iRV/0dt/Uy6jso2EHw5jPI4usebdzn
	 hOWn7G8bckcQgXHt9uE7fG1gekvDA0ixms5gU+pw1otmpRQUYApC1OdzvPqK/e25Xj19v
	 WBuuJVyg7LzxQgkTNA2YBnqzUjJtHeJdJfQfNBMJW+J2PEr47Gdzp+YHtHfoEdgC2C4KL
	 u9ozT24Vb92Hn7uPHq4LeIa10P/dBZfcxB+sJRQJrMfewQcHQixquqT8bYBOrhLhTpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794529950;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=TeLAZiZGj+97MWa7ReJZxgbnws7A1jvXyF4Ap0n10zw=;
	b=QYnWgvhSLH2sc6EAsh2PCl6DqBfeHBMDxtGkZ08X79HVT8/apvEetR8KYH2b+MF/U9Uz
	 VTMPY9NfpyplbvwSyXCV6S/y1oh8+7t43noSIu0QAsHgORYHhTYblO/TuFGbfUthIsKKM
	 +iQoOHEfxs16A6gqpYnO6j39D463G2EGvxDqj86SJ64Nk3h8CW9HUxvAXIJ5xGumPpWwO
	 wsQYshGb7mHiCiBdzsagrwXgueBGG/S2lZQAm7T1YChQ7enKw891nOVfx4PXW95Y5uPyE
	 w1L+Rvvob3psmNDL6O7I9T5jc0q5Zz09L6txO6T2d8qJmqoiITyn3tcyMV6rXt9tevw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YgtYRthJ;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F2A606A32A
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 00:32:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9F2A606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YgtYRthJ
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4918c2d727fso145349f8f.3
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 16:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794529948; x=1795134748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TeLAZiZGj+97MWa7ReJZxgbnws7A1jvXyF4Ap0n10zw=;
        b=YgtYRthJ9KcY0Ug3eON2U/WiEMJk0eyukjogIRhwpFdpaRh+y/a05eu12eaa57EsIK
         nLy+YCPFBp4SkS10Q06RBlSN0GIgit+mD0F6oEDnHuBfooCRFll2j+7ZgnjBnpZK0E7Z
         GT5onKdKyeDJ5egfGwBFi4LVqIYd19nvce/qNu3pJWbHo0dflE9MIqQmPDqRaiT6rumb
         x2SoVmT7MjlC3Gm4zaRkfSXiL4nzUE9KvxEqmCB4qcX7Z80W84Rt4fnRoPioJmvVKm05
         PAYkB1KdFk+3JOF2zUe3w48GVXfiSBIV5dCd+aWrbgOUyzuoXSkoXo2sb05hmsDyTzZg
         L5Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794529948; x=1795134748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=TeLAZiZGj+97MWa7ReJZxgbnws7A1jvXyF4Ap0n10zw=;
        b=pufGmVj6J1VKlmF0UTM/3CZjkMUlhKFj0O5ZoUDhHI3nvJy74uGHk7Dr15ld2AKo8m
         LV7Cx1sE3/iUqh0kiG7pIV9b9Oy90R8VYWqd4gCtDWzgq5hA/ym3vgaUplK0gots/ukJ
         wZkP6Vc4awGYke+pWbMF3rdTQLNZN4fUw4+2emh794tY3BJSvh2ixUkGp0cpDf+65ijv
         ra3BuTQ/EjqF2uKxslhHDhHBhk6ottQanHA6zl1px7vsx7YRN1CGCHMM/mk9Apsh4/ON
         Qp72dwMgw0qzgwl1W9lQ8rGXAyjHYHDlWELAT2ykOLvU7+Lhjetu5cmDBKMA1175UGmO
         fFXw==
X-Forwarded-Encrypted: i=1; AL+hErFU5PWq6lrFqblhL4yxjOPVKPPGdgvXAb1pOIf8hNAAWvxyBNpQ2A/srxjDrHzVjYvdLfZtxGw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+PcnOk8036cY16lsOogtlPCOSLmN5mFnOo3iltGbTJMmtgZCC8
	AohKfjrPYB43B4r43+ZFERv1ZAB4tAK1WRfudD2YylU0kujubi2X9/Zo
X-Gm-Gg: AYBFou0wLgvx/PbbxbEXu+GQhhp8GQ7YtOhSSIqDizDVHbxL2jwBEc22KUsIlwwcKRd
	mJUPoY8/i7pDTnDQgQhNru/3v5D8HkMHwZmKC5NDIZ2jpfxCi+lwf6QRaN1c+JCwi/HVwgSyW7C
	jWakVz5RZYRNYRqtOf6Z2XqeFkb8/rJQjO/WDoOVbs7PSA7b99uwAhP0C1kK+Vm6FS7uCnK8rsa
	dy6z4UgScQh+p3NNx+xe+Bh4YphJFF55GLX04Uxd3AabHd3Phgt9yf0Cg4YDCeFBpsqGyqiXsXg
	EP3R0to5YFsWaz0UTc+uqXBEYHwSdmG30Ath+PJjV9Ow+B+cp7+LeDtD6zTroVIcqTxu+q7wWkE
	K7fVRbIKK++NP9qukAhXTilYdhOSM/m+tmb0W/HNjbB2BfvVQyKjjUBTBxV7HbykEB/c6UPj2CN
	fpGkzpRK/xSYbAqrYT7IbokZmRQkN07gBBSRS3wfq/3oVXAqCnTBBHoRkhGOlJbBPX/U23oueLJ
	ezHcjJTWa9+cf2xaztb4DHv+HcqKs+PODfkHcZsVMW90M4Uqzcbm0y69ntDmqDDn5lzICabUQF2
	FChJNB/P6Exi/OC9WmNaYlDgJOW6EUdzlJ9zvTMRbKM/xJDEGDeVL1165LQ28EIfosMEGpQUxEk
	0WeAIfjvJ6cA4URXeYDuWxKCxmXkEQLw5pBOPrh2dPpO3FDG91Kbz5w==
X-Received: by 2002:a05:6000:46ca:b0:493:bd29:a6e3 with SMTP id ffacd0b85a97d-49c70ed913cmr1444486f8f.15.1794529948033;
        Thu, 12 Nov 2026 16:32:28 -0800 (PST)
Received: from Ansuel-XPS24.localdomain (host-212-171-11-167.retail.telecomitalia.it. [212.171.11.167])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-49c5f7828a4sm2029768f8f.23.2026.11.12.16.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 16:32:27 -0800 (PST)
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
Subject: [PATCH net-next v19 01/15] net: phylink: keep and use MAC supported_interfaces in phylink struct
Date: Fri, 13 Nov 2026 01:31:51 +0100
Message-ID: <20261113003217.197757-2-ansuelsmth@gmail.com>
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
index e7734e45376c..5d649903be9e 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -62,6 +62,11 @@ struct phylink {
 	/* The link configuration settings */
 	struct phylink_link_state link_config;
 
+	/* What interface are supported by the current link.
+	 * Can change on removal or addition of new PCS.
+	 */
+	DECLARE_PHY_INTERFACE_MASK(supported_interfaces);
+
 	/* The current settings */
 	phy_interface_t cur_interface;
 
@@ -632,7 +637,7 @@ static int phylink_validate_mask(struct phylink *pl, struct phy_device *phy,
 static int phylink_validate(struct phylink *pl, unsigned long *supported,
 			    struct phylink_link_state *state)
 {
-	const unsigned long *interfaces = pl->config->supported_interfaces;
+	const unsigned long *interfaces = pl->supported_interfaces;
 
 	if (state->interface == PHY_INTERFACE_MODE_NA)
 		return phylink_validate_mask(pl, NULL, supported, state,
@@ -2090,6 +2095,9 @@ struct phylink *phylink_create(struct phylink_config *config,
 	__set_bit(PHYLINK_DISABLE_STOPPED, &pl->phylink_disable_state);
 	timer_setup(&pl->link_poll, phylink_fixed_poll, 0);
 
+	phy_interface_copy(pl->supported_interfaces,
+			   pl->config->supported_interfaces);
+
 	linkmode_fill(pl->supported);
 	linkmode_copy(pl->link_config.advertising, pl->supported);
 	phylink_validate(pl, pl->supported, &pl->link_config);
@@ -2212,7 +2220,7 @@ static int phylink_validate_phy(struct phylink *pl, struct phy_device *phy,
 		 * those which the host supports.
 		 */
 		phy_interface_and(interfaces, phy->possible_interfaces,
-				  pl->config->supported_interfaces);
+				  pl->supported_interfaces);
 
 		if (phy_interface_empty(interfaces)) {
 			phylink_err(pl, "PHY has no common interfaces\n");
@@ -3026,12 +3034,12 @@ static phy_interface_t phylink_sfp_select_interface(struct phylink *pl,
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
 
@@ -3910,14 +3918,14 @@ static int phylink_sfp_config_optical(struct phylink *pl)
 
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
@@ -4155,7 +4163,7 @@ static int phylink_sfp_connect_phy(void *upstream, struct phy_device *phy)
 
 	/* Set the PHY's host supported interfaces */
 	phy_interface_and(phy->host_interfaces, phylink_sfp_interfaces,
-			  pl->config->supported_interfaces);
+			  pl->supported_interfaces);
 
 	phy_set_upstream_port(phy, pl->sfp_cage_port);
 
-- 
2.55.0

