Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6622F4AD7C3
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 22:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792017068; cv=none; b=AlsGUh4HoGwmHqDVd590e/it5oK4vWqVIofEA2HD0yo299FA6nOpDURyGxfYjkcjOKt15mEVJg3VoGiPdWv/DAH6c5pBmPr3BpeF9zMtdX89UGligrDZzyuidNiBorxoOrc0Ukn/YqPYhjOJSJTaNUgxvF85La3XWNhtkeUh2sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792017068; c=relaxed/simple;
	bh=FjAz/hbU9CW7acYWh7pTK+WN1VFdjJzgjf8bL47ouXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i5ZM8QO4cB9Ypdo3ZOi7dd8jzYaMhru2eF9SSMcn6CEk+yHPcNnkUWi5KCzHy8+GndS249V64q23nkHkjTGkr37o+RRxcIfFHFj5d45hK4Gw4KtaCZIZZ9u2ge8M7BkqucmB0j46VcXi+zBIeFzu5kGaIrwuv6i5e3yPwb841cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=VK5OFc26; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="VK5OFc26"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-533952f3714so48852521cf.2
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 15:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1792017066; x=1792621866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FsIKARYVlihqDjmV/OKM1uQES+iC0tNE8qrLr/nLJds=;
        b=VK5OFc268OdxA1v1ne2Zniu0BR4zzekRwmNPSKsp3fKo7SmLP0KgFGuQm9XNx7nJ6u
         7bkyc83tTXyuu/GcWAfvJXXVQbtgYM85KZ5VeKmymDuICyLqePAJ7NDOHp7fMvjHJGut
         Q9tKs97Qr2JF/JqeCwN7mZmf9fkplmHzmhtdZJ+23kQjer+bsoeczhPjje8I7ObkG23R
         0CkuLV7bYT3HQx3zBtaMDQa1fSolBOdGCmbNbEjwnaE9tDWIAlHo3Dod9xJ34vY6l7q8
         +LkV5oniXrXOYa4pETvbb0eBGahFA/M1acl4YiKiMA+5K53rrP0dZAiI3YnFTH0MzgRS
         19vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792017066; x=1792621866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FsIKARYVlihqDjmV/OKM1uQES+iC0tNE8qrLr/nLJds=;
        b=ygwTl5NVfAP4kEc/amspL6OEm6EVN+5hrp9QMa1iSqhqremDsw3u89YpPlEplgH91e
         TAGc67/TnN73EHd3CaLMLRWW4Lt0gh9vrBZFUrwcTp0GIaPrxYwiNrxyuM2E6xWaJb1f
         QOpk3DBnMULRR32+SfECh8YH+T5tTao9EJ0n9gNXNedPfkz+GHnA3ZCtggOFe9U4uPDG
         0eOxSN+lVQPlMRv5A7reDN2+3YS75JCRm+1uwYl0/ZaMdhGnHy0hoHT49O3kV3CUUh8F
         nJbzHzdkcLkW3fNtYEvVcewNkefPcS47e7dqxTLxo76C0/UE/bvfUZs7S1xV6ZynwZLK
         5XTA==
X-Forwarded-Encrypted: i=1; AKwUvBy+NahoTnkaBdwwwGgbYfzNRC8NMbsqMCv/0oHkwvpy9W7tHz1WOr0hSi+sJDpgNOFi/Ar1zsE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIF+jWZP2q38WKY8GtrV8gMbvXXhtMMFLXjIRqPqns5YEkYJXb4
	IOB07PXmJaI1mo07kUH6glcimh1BBgpN9M+IVT9vj/f8MngchrQgxGsJWPf8VsosY4M=
X-Gm-Gg: AYBFou0PxtqVony1Am6lHP6x0K3dGGXPs/CUFzP3gtxvX7Hxku/FRBDGQ0VlTD4nfA+
	aSMMhZAu07cyRBEqoXqjtzrdBpk1kkuMdsOvjG6S2x1YW/z+Nl6kHCTE+15Rs9AmPr5BNz3k7fu
	xN/FdAiBzrSn6zok4UKrYuQf5bgPhGZd3tGTZ6qGJVQErHzrB2jsckXi6Lf1fpHRSz6p9KXeErq
	DlQ0kHfmwp48bKuUQ6c1qJONH1vdCwSqmC+Lvys08TWSKROSA/T3b+t/fI/uT9jGCQDcy4Q/x4/
	P/7wC5H9avGc0UaeK6CHkJXMTBBeOqNN1zJ4l3pD5KBP83rES7uNtNSNtAVgzkR8pof5KHOUeWX
	a9BE2Qm+wXZZRifE0z4JZ7xYa/UtZ/1nKe2EDIXznGDukX62w4/l22r333VYhzvvW4HYAhyAH1Z
	BjWo6S+hx5bywUtckkNSnsvl8hBG5diWqVDjJthIbaQOVVgOYNyxwSX7n+Z4iiYsq4xszI4l7ws
	JE=
X-Received: by 2002:a05:622a:5cc:b0:535:2763:16a2 with SMTP id d75a77b69052e-5359fb873d3mr281803701cf.43.1792017065570;
        Wed, 14 Oct 2026 15:31:05 -0700 (PDT)
Received: from zippy.localdomain ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b97bdfb89sm63708466d6.40.2026.10.14.15.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 15:31:05 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: Daniel Thompson <daniel@riscstar.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/2] net: pcs: xpcs: re-order xpcs_pre_config() to update after the reset
Date: Wed, 14 Oct 2026 17:30:58 -0500
Message-ID: <20261014223100.304486-2-elder@riscstar.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014223100.304486-1-elder@riscstar.com>
References: <20261014223100.304486-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Thompson <daniel@riscstar.com>

Currently, on Wangxun platforms, the XPCS is configured during the call
to xpcs_switch_interface_mode() and, if the need_reset flag is set, the
XPCS is reset and the configuration will be lost. This is harmless at
present because need_reset will never actually be set on these platforms.

Nevertheless having xpcs_switch_interface_mode() on the wrong side of
the reset is an obstacle for future changes where wiping out programmed
configuration with a reset could be harmful.

Reorder xpcs_pre_config() so the reset can happen before we switch
interface mode. To make this work we have to hoist the special case
logic for SGMII into the parent function.

Signed-off-by: Daniel Thompson <daniel@riscstar.com>
Co-developed-by: Alex Elder <elder@riscstar.com>
Signed-off-by: Alex Elder <elder@riscstar.com>
---
 drivers/net/pcs/pcs-xpcs.c | 59 ++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 28 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index b415b93d77c15..49abf5ea6f5cc 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -705,46 +705,49 @@ static void xpcs_get_interfaces(struct dw_xpcs *xpcs, unsigned long *interfaces)
 static int xpcs_switch_interface_mode(struct dw_xpcs *xpcs,
 				      phy_interface_t interface)
 {
-	int ret = 0;
+	/* Wangxun provides a full alternative implementation to handle quirks */
+	if (xpcs->info.pma == WX_TXGBE_XPCS_PMA_10G_ID)
+		return txgbe_xpcs_switch_mode(xpcs, interface);
 
-	if (xpcs->info.pma == WX_TXGBE_XPCS_PMA_10G_ID) {
-		ret = txgbe_xpcs_switch_mode(xpcs, interface);
-	} else if (xpcs->interface != interface) {
-		if (interface == PHY_INTERFACE_MODE_SGMII)
-			xpcs->need_reset = true;
-		xpcs->interface = interface;
-	}
+	xpcs->interface = interface;
 
-	return ret;
+	return 0;
 }
 
 static void xpcs_pre_config(struct phylink_pcs *pcs, phy_interface_t interface)
 {
 	struct dw_xpcs *xpcs = phylink_pcs_to_xpcs(pcs);
+	struct device *dev = &xpcs->mdiodev->dev;
 	const struct dw_xpcs_compat *compat;
+	bool force_reset;
 	int ret;
 
+	/*
+	 * According to the XPCS datasheet, a soft reset is required to initiate
+	 * Clause 37 auto-negotiation when the XPCS switches interface modes.
+	 */
+	force_reset = interface == PHY_INTERFACE_MODE_SGMII;
+
+	if (force_reset || xpcs->need_reset) {
+		compat = xpcs_find_compat(xpcs, interface);
+		if (!compat) {
+			dev_err(dev, "unsupported interface %s\n",
+				phy_modes(interface));
+			return;
+		}
+
+		ret = xpcs_soft_reset(xpcs, compat);
+		if (ret) {
+			dev_err(dev, "soft reset failed: %pe\n", ERR_PTR(ret));
+			return;
+		}
+
+		xpcs->need_reset = false;
+	}
+
 	ret = xpcs_switch_interface_mode(xpcs, interface);
 	if (ret)
-		dev_err(&xpcs->mdiodev->dev, "switch interface failed: %pe\n",
-			ERR_PTR(ret));
-
-	if (!xpcs->need_reset)
-		return;
-
-	compat = xpcs_find_compat(xpcs, interface);
-	if (!compat) {
-		dev_err(&xpcs->mdiodev->dev, "unsupported interface %s\n",
-			phy_modes(interface));
-		return;
-	}
-
-	ret = xpcs_soft_reset(xpcs, compat);
-	if (ret)
-		dev_err(&xpcs->mdiodev->dev, "soft reset failed: %pe\n",
-			ERR_PTR(ret));
-
-	xpcs->need_reset = false;
+		dev_err(dev, "switch interface failed: %pe\n", ERR_PTR(ret));
 }
 
 static int xpcs_config_aneg_c37_sgmii(struct dw_xpcs *xpcs,
-- 
2.53.0

