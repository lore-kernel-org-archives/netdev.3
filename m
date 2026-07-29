Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F71D419FBC
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 07:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785311000; cv=none; b=X3soPrtBuseF6+MrlKMFAS9mXUcQ965I1elVw82DLbtEskGr4wwiG8ovqodrJlRFKdrZMqmCb2tGYOqjVNdjmS/7N0joUE7gC1B0qYbupEIHXRivTvrs+Yolfz4uPLls96Gx/bx+pN71iY6FxD0647hrTehALlcCAZju+CYqxmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785311000; c=relaxed/simple;
	bh=f0pUjgm12YiKOE5OLRjG68BkleLUl5Q4EzBqr6bq87c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bJCPhejMP3916yxeSBLaJoZnuZgpaOwzEUsrt5E2QeYtBbCZxyIVLp8jw/icNwAubs2WTeyMAsNu498dF95bgJ1POmyIZHJmJD+saEbHBWtAaqL6udEZCiLTZdTWJKf7FMeeX9HYsUF0LsNCDmYahF/Km3hGvR3bdGIFPBLgDu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bqeMxr4Y; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bqeMxr4Y"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2caced6038eso7875075ad.0
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 00:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785310982; x=1785915782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DewgyYDAktvZQQjsN7FV0AudowESd3lzCpxYXEo/03A=;
        b=bqeMxr4YLtU4UZbKVCToKcpKL6jMxI6MXTSASje5jNKtgOihI6GdhX6F8EFdpDzkHM
         KWr6kQUMOduAGv7oXsEdGnY+L+wpL0kNF1VHgTOZm5D5TsmlPMrZ5J0ZUkR/6xgA99Nt
         CCU1DKLMwOjOuCNFMM5MpV/lbNte7jNjbXcTpyLOZF+kUbdH6v0o8wb9DoIWull9MqPW
         7BogAHkjuOHPZYvZV+EYn2kCpYxz/XSdlSjjpojN/aNqsNXLWXMM6yQKQdsyNz5yaS3l
         aGrDCNf6iC8cRPuPCeLHHEuv51WJO7llwEcwaJ20q0iYE0e5TUoB64jjRKUxziYojEt1
         izAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785310982; x=1785915782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DewgyYDAktvZQQjsN7FV0AudowESd3lzCpxYXEo/03A=;
        b=ZlwcmmmxfkrBo1BfJMkx/iZxuiuutMHkA0I8mp/TcPAvc7g/6LmaT7fMd2uBaidu3l
         tWQ8N+n0YQraFB3CBCJBWBLm4x7zGlr1jNfIaoQsCj48tA8qHvZHHAHaGjEOUhdFoQNZ
         tzJTVp5UZ9vCORH6J0gkiLaKWUoa6S2HhH0VCXRRCYr/KInNBbLQYbP7sagL43X3hK9h
         +Mi2qNQR4lFMhehLo8oG2COLYAJkwrCZrejEagfp8UN9sEoXaDKibPxyD4TjNhl/Y+Sn
         593exxRHAJ1yeP3RkmuR4Z+4DZPlidE+kwZ+MJEHqf46r5trELeeWK34YnT7KvqRAtiE
         Ou3g==
X-Gm-Message-State: AOJu0Yz84JaxwMqtdY5+L/LMsqSd7BFwaR8J0HWuUmQPLKQIitvi4S+g
	oRejFIBsqPtH667COwemp+wjC9tmjo1WhyfDGIw4AxzQSE6S6t6XT/jK2MNLQjHB
X-Gm-Gg: AR+sD12lZbEuHSC0UWmGaBViPxSEH14fOFr62G2ovewdhrAHZUkqG8FiArSbxWx/FRd
	VKiz2EAASi0I3n68sIFJXkDU14el3vYh0Xbg+1hRocmOBGCZGBsOrBGRAGc7PQUMIj+tGXkNdo2
	38cmMVah/u4nCPD91kUexsptlkvNJoOFTofIw7/e/7k9OAq8s3uNnMniCgRZ5ls7Tm4qySga5Nv
	rG9YHydCC8qDdp45CH+dN/L6BxNmtW0D7v12GPSPEaSxpVpQBTf5rbQdNHvigkMtI7mJzUb0RIV
	1iiWA/K+PqPB0lsXOeJ3qG7WbxA5fDGix3i5XKLaflKq0ERUd43gsHIEvHJxed9ySyzVv6V2/WF
	aOlRRnV7fLK9aSvPiGfdagS4X6o8DwZRz7h/6rnMkuSX2QgcL7OCVTnrhKNC3za0BZ5F5hRVOLl
	q9FFDNzS47FBp1Y6DCV+IS0GYt1wjfdj+lYjA4oaMBH9fK7GE8QKHse2D7FYk=
X-Received: by 2002:a17:903:2282:b0:2ca:53f7:3c69 with SMTP id d9443c01a7336-2d0266945f4mr13611065ad.9.1785310981897;
        Wed, 29 Jul 2026 00:43:01 -0700 (PDT)
Received: from server227.. ([39.170.101.209])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022bf888csm7154505ad.64.2026.07.29.00.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 00:43:01 -0700 (PDT)
From: Zxyan Zhu <zxyan0222@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <linux@armlinux.org.uk>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Hariprasad Kelam <hkelam@marvell.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Zxyan Zhu <zxyan0222@gmail.com>
Subject: [PATCH net-next v3 2/2] net: phylink: allow PHYs to be attached in 802.3z inband mode
Date: Wed, 29 Jul 2026 15:42:37 +0800
Message-Id: <20260729074237.2624940-3-zxyan0222@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260729074237.2624940-1-zxyan0222@gmail.com>
References: <20260729074237.2624940-1-zxyan0222@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>

Now that we have proper decision making for inband mode support which
makes it a "best efforts" feature based on the capabilities of the PHY
and PCS, we can relax whether we expect and permit a PHY to be
attached. This is especially true for the 2500BASE-X case which some
PHYs use without inband on their host side interface for 2.5G speeds,
but use inband for slower speeds switching to SGMII on their host side
interface.

We already have such a case for some qcom-ethqos setups, although
qcom-ethqos overrides phylink's inband settings by accessing the PCS
directly at the moment. This should allow qcom-ethqos to transition to
defaulting to inband when 2500BASE-X or SGMII is specified in its DTS.

Allow PHYs to be attached when inband mode has been specified, which
will be necessary to allow inband mode to be used on qcom-ethqos.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Zxyan Zhu <zxyan0222@gmail.com>
---
 drivers/net/phy/phylink.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 59dfe35afa54..fd4e80eeeda7 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1964,9 +1964,7 @@ EXPORT_SYMBOL_GPL(phylink_destroy);
  */
 bool phylink_expects_phy(struct phylink *pl)
 {
-	if (pl->cfg_link_an_mode == MLO_AN_FIXED ||
-	    (pl->cfg_link_an_mode == MLO_AN_INBAND &&
-	     phy_interface_mode_is_8023z(pl->link_interface)))
+	if (pl->cfg_link_an_mode == MLO_AN_FIXED)
 		return false;
 	return true;
 }
@@ -2205,9 +2203,7 @@ static int phylink_attach_phy(struct phylink *pl, struct phy_device *phy,
 {
 	u32 flags = 0;
 
-	if (WARN_ON(pl->cfg_link_an_mode == MLO_AN_FIXED ||
-		    (pl->cfg_link_an_mode == MLO_AN_INBAND &&
-		     phy_interface_mode_is_8023z(interface) && !pl->sfp_bus)))
+	if (WARN_ON(pl->cfg_link_an_mode == MLO_AN_FIXED))
 		return -EINVAL;
 
 	if (pl->phydev)
-- 
2.34.1

