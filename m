Received: from mail-oo2-f39.google.com (mail-oo2-f39.google.com [74.125.231.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E7A47A0DA
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 19:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789933544; cv=none; b=JMc9VxttIxezAZ/pvlGUyWVAr58bz+Z7b9ydpVPuZzDK8y9Mc2OkFbpsO55eIyZQA6K/3k/p54YZdI+yGH9dmwFgJh0uMNvNNpS9bl732xBjq7bc4uumfAn/zTJIh59jmptF01eEUF8KlnZ9xE0TYdtdaHUWCCf4uxpAYnZsUrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789933544; c=relaxed/simple;
	bh=gUKFbHeEcxx83+tKppsK/7X6MwKFaPl4J3HQSaFfj00=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B38RgE2sfk+HE8TqNYNY+5PdIkzs9IOFHxsmZFX7Ogkg0x3RK24pUUeVYyTBTCo5yYZ4M95D+K/HeDZ8kyqVzF1KewRDjAroRYwhcPeHIo4yS8R9yJGUX+b3/IL2vkomAXBFBpmBsLb9XfzyVcDhgIdPDOCTqNudeGz0sdlKy1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S0GJ19fe; arc=none smtp.client-ip=74.125.231.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0GJ19fe"
Received: by mail-oo2-f39.google.com with SMTP id 006d021491bc7-6c197ff1f53so1125516eaf.1
        for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 12:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789933541; x=1790538341; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Cfe0VVZFX+0RXygGXnYE+LZWMLMgO2pSV2be59Az8jU=;
        b=S0GJ19fehWmE2bIYKw6bwP709AZwP/zdcJbzu/AlaCBTULivjYXog6jkuFY+eY2jnt
         8JON4Us1rW0AQMwv/rMbh0JgQUwIWwXvX4msb+2ajkm4kYSoE7c4awGwDPStZP04Bwcl
         u0yGPF0SYw3v3PeRhI67So0rvM2cjq/eYt+pZ/iIpgnnWmezj+n/+1bF46UfeFPjj8kz
         PKp1W8NVHy/Ziz99kD1Qc4+PBI9rUrLFcUyI58xdmgTD8BkZtAmr9+pupKtfz3amCKhE
         8aWTtNxx66qUwfIQLxjkLL3tC5baZ1ciJpxMyBOnJQyCRVmWNHlaESFn+ePYIgRoMe4b
         c3gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789933541; x=1790538341;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cfe0VVZFX+0RXygGXnYE+LZWMLMgO2pSV2be59Az8jU=;
        b=1lhULtC6bTMJ2/UZAdOROhmYXp/BiBEmxerWgft30wYc9DKyHOFygs6zIDPGmKqVw0
         1mCBu6UYNXSgNI9EEo8qJdrm7icpabasaOzrZlis1+3kiDr7Hc4cwNCSJC9DTW3fJ6Mh
         GkD5OawofxRbFZgR+sTOSG/2jFpVUshBMKVjEmipKurrPDJbn8ZPewHOL7VMt5UtsksM
         IuJYZ9ZHWTMHlS5tkK6BYD1D5k2vVqWxmhitVD82lJV26OzRGbZeUHoelbMK5dhVtQB0
         LWG/jOoN2js/+2oFtQRlpuwvffSntR1jFjqAruTouPCczyhL7h2SoI796LKqBC+yvUsM
         9PeQ==
X-Forwarded-Encrypted: i=1; AKwUvBw8ckrO6h4aX/y7SrCqfHY1nu1NYKn0w1dQNkAOmPMPimWdc1hKWllvZnGx5gbr2rjdeimagX4=@vger.kernel.org
X-Gm-Message-State: AFuF++mJOX9hL7zUPDzWvRwj9tWv6Q8lk9cPdvYRM2NR51mZDSDMGcN2
	Mxe7okrSym8M9hNw4pW5FRBOpOwVpPwuDQJ8Lmb+Pu/b0sAa5h3V57Iz
X-Gm-Gg: AYBFou37hmT43pkha7zSBWF5QY5UwlwSznuzKC5lnNWGr9tozjh/A1CtqoQpLqYISIF
	ULUoLuvP2a/FXEFwNSygc9iVHWMfm+QljVrBiHzkhOl1eQO93HfeK4MQlwxW2Aj1E2ZZP0Noejr
	fuyzTuPPkw7CvqFSrN4hzae7wfnYcOadaC2QutEOQM9NoutGzinD4klL/46Hooel/7f8+3hFquM
	psEk48LtDziz3j/tnoppEJLcM05n7O0bRD9UnPkLi6CoqEZss8Lcs4JqskFiJIzQMTWA2L6RHHB
	Gu2xCCBNnIGTnHEOFvAQZMJsvd/0GDxShK3Zw2FtibG3ekYqwA5QwUJ3XLGl54oVPzX37XAWMuS
	jqngxgWOcL/G4U3KIVLAOrPLaDmMB8cA3QuTKESkgukuk/aQG1XbrD/dxVI+KjQiPe1qVU0qMNa
	5qs+YQ9thxupJIiE8os+SltMeY35gjTzyap7sPB3yBpA1eAop/xEIuazrb/vYosUUWTek936YbP
	233nWSpP8/+FZt52/QutLmTd7bCg+KSifLmijD5WtZMy6SZH3JA94XNpFmhHxji17vga7lT3gg9
	A64MmUVFkHkKdbopqGnN3Irbp1PUJ8W1D7s9moBaxxKGNEIagtKh9IudcEmLVrBynkTqKzU2O6Q
	UT30v/CWKzgd3rla9Ivdk
X-Received: by 2002:a05:6820:4b86:b0:6c3:2a60:63c with SMTP id 006d021491bc7-6ca9aa41ef5mr8971692eaf.22.1789933540913;
        Sun, 20 Sep 2026 12:45:40 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4881f4d7861sm6103834fac.1.2026.09.20.12.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 12:45:40 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 20 Sep 2026 13:45:27 -0600
Subject: [PATCH net-next v4 1/6] net: phylink: allow stopping a suspended
 instance
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260920-submit-h616-emac1-v1-v4-1-8347dfe2eb7d@gmail.com>
References: <20260920-submit-h616-emac1-v1-v4-0-8347dfe2eb7d@gmail.com>
In-Reply-To: <20260920-submit-h616-emac1-v1-v4-0-8347dfe2eb7d@gmail.com>
To: Richard Genoud <richard.genoud@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
 Jose Abreu <joabreu@synopsys.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Christian Marangi <ansuelsmth@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Tiezhu Yang <yangtiezhu@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>
Cc: Maxime Ripard <mripard@kernel.org>, 
 Alastair D'Silva <alastair@d-silva.org>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

A MAC which cannot restore its hardware after system sleep may need to
close the network device instead of calling phylink_resume(). Without MAC
Wake-on-LAN, phylink_suspend() has already stopped the PHY and PCS, so
another phylink_stop() repeats their shutdown. With MAC Wake-on-LAN, the
saved link-up state still needs a matching mac_link_down(), and leaving
PHYLINK_DISABLE_MAC_WOL set prevents a subsequent start from resolving
the link.

Allow phylink_stop() to finish shutdown directly from either suspended
state. Leave an already stopped instance alone. For MAC Wake-on-LAN,
stop resolution, drain pending resolve work, complete the deferred
link-down and clear the WoL disable bit while retaining the stopped bit.
This does not restart the PHY, reconfigure the MAC or bring its link up.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/phy/phylink.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 390d3eb3e6f7..8ecf2dec3a7d 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -2615,11 +2615,17 @@ EXPORT_SYMBOL_GPL(phylink_start);
  *
  * This will synchronously bring down the link if the link is not already
  * down (in other words, it will trigger a mac_link_down() method call.)
+ * It may also be called after phylink_suspend() if the MAC cannot resume
+ * and the network device must be closed instead.
  */
 void phylink_stop(struct phylink *pl)
 {
 	ASSERT_RTNL();
 
+	/* phylink_suspend() already stops the link without MAC WoL. */
+	if (test_bit(PHYLINK_DISABLE_STOPPED, &pl->phylink_disable_state))
+		return;
+
 	if (pl->sfp_bus)
 		sfp_upstream_stop(pl->sfp_bus);
 	if (pl->phydev)
@@ -2632,6 +2638,16 @@ void phylink_stop(struct phylink *pl)
 
 	phylink_run_resolve_and_disable(pl, PHYLINK_DISABLE_STOPPED);
 
+	if (test_bit(PHYLINK_DISABLE_MAC_WOL, &pl->phylink_disable_state)) {
+		/* Finish the link-down deferred by MAC WoL, without restarting. */
+		flush_work(&pl->resolve);
+		mutex_lock(&pl->state_mutex);
+		if (pl->suspend_link_up)
+			phylink_link_down(pl);
+		__clear_bit(PHYLINK_DISABLE_MAC_WOL, &pl->phylink_disable_state);
+		mutex_unlock(&pl->state_mutex);
+	}
+
 	pl->pcs_state = PCS_STATE_DOWN;
 
 	phylink_pcs_disable(pl->pcs);

-- 
2.53.0

