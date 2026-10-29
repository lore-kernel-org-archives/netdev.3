Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.134
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793269677;
	b=dBJYA+muzngFHNSCC+w23ZgY4ntCYEnlBCm1kDaRahd/JRUD/s3c+vq1jyGTWgEU/SUH
	 O3pjwLlH3g0dEHSCQU7P9OwqBem4BnHSvYjAJYoyro5C2z2hNRFinyS/tsaw1kUBQP4dK
	 7HdSO7MAZAp5fhUlw08LMGz2ZsNJ0sD2UVv6kqNh6Z8Ht58DsL584J4PjFKu20zwdqheY
	 KmBrjpwCciZR57idC31+HLE2auau5WxdFVlLRoi1MJ4RlqeXLmITN2apnq6SQyl3/y6K4
	 IEyCG1+OSSDsgbYDjQEtTm8hy6+QJQeC81C6lQYmxdm9oCgB2fEyFFE4TPhYqINmz+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793269677;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DnYYldOHNT4jayxYyWDlCgPG99APkcSyvyyLERzh7ms=;
	b=sib7mfax5MYL/okz1lbq7XA3P7nEijBNgecnjRn5mQoidFO+ctAgITFNzgY9U6w26jfy
	 VJmXxWbriSLfWDjIeI4d3HkHVnNytVJLGdVLSzXcmiRcPhlRG3vH+z5PowNfAFzNOgihe
	 SzZuxlXfn2Xv1noLuGmSjeWds+NduE3HxUfo3xKuj4RmrSM2yZny7P/Y+WJAzQdcmoiK3
	 uThWpEyhyuUYLpTP4RiJpAs/Y32RH2Q9LQTZa0OS22vBcav5eF8kKD+dT6UjDWO3+dUCa
	 XTp/rC2O54QirZDNzA4ppDNgFLHdP0OnUIxoKnSAp1D5GtG2VoIvP5Y0CYm13VHHShg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e+H1XOcs;
	arc=none smtp.remote-ip=74.125.229.134
Received: from mail-dl2-f6.google.com (mail-dl2-f6.google.com [74.125.229.134])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955CC606A31D
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 10:27:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 955CC606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e+H1XOcs
Received: by mail-dl2-f6.google.com with SMTP id a92af1059eb24-1aa624b5738so153953c88.0
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 03:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793269677; x=1793874477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DnYYldOHNT4jayxYyWDlCgPG99APkcSyvyyLERzh7ms=;
        b=e+H1XOcsX3N60FQlJe7XEu5zWBKsVn5kyFGhZXtSjC4P/bh5lTxGcVZZiDtBWsNQAB
         kV5A75WpG9S62gIsMjjxzfQty5TPaZ1+oBzKQyIanIwTOZOUpW+lpadjN03SvkuEh9ap
         B8g29S+fF5kX5yx8FPNKXYd8/7ltNPnFjqHyiGXESspGr2zBiPfyFdZ2bJ9vb7MgUYLS
         rch7ZXUDHWqooUt/TnLphGfj1p8pES9l20+I92c2lOREX7PQk/Iy5izyDzqlpqO75pcD
         ck+C1nFkc2gJweYxx9rm9v1XeIeP+3OSlvTgRKfFR/JAdFfQ5e6j6Uchx8OXnAmQrHuq
         YAXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793269677; x=1793874477;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DnYYldOHNT4jayxYyWDlCgPG99APkcSyvyyLERzh7ms=;
        b=USJJ83h7FGdbqg0GzL28OJHarxiBBdMsGemRyA94QOLEw1kPXlFnPYRG3qnYv6yc3j
         64iASx8V+p1GrlK93N1ZyeVVX4OGsrpi9QekQgrqSsdfFrEdrKQGJAi+OTBfaDBVAHxP
         qoLIMcmARLwfNNHvqniShScqgoBjjH3lkzB9/YTKMYkNLtfY33AnptPKzxZ3WfVeF/b5
         7IHQ9OINB8AD7bzsDGIheJYhNRhm5PdO6O6vi/PDlW4eGGVXnVIkmzJT3mSa4J/Zg3LS
         AmEdtPHqeOsJr21/LO2M1xLAExaLomWVb7UxwFj7Znv5vwMf2/Ctp3C9dB0KOYazvMoi
         aRyQ==
X-Forwarded-Encrypted: i=1; AKwUvBxRSZYyCTkb5kTZobEfdYC+ibU0aK4oWaf4fevzv8YHS+jPyT82e3+uPdwRm0QaXm7X3yjU9yg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJvkT0RuU5aokqvr/LzisvsaVWxZny5tvlQz66h3jKQgttvFg7j
	JM8eRLAqPrkUXQsh9WEVx7pY6r+XO0Ud/reY6hNxHResbGd2amhIyYfk
X-Gm-Gg: AYBFou3oql/E/ZB/4rPaBdeKKgyfuwC9Q61PlehuHmQYQmx1cHYHI1dabeDn0yT79Fg
	iE6x5wuG84ZDEnirDEFKjDaQkoAs+mLOvrUBKo+40iUbUK759+lz9m5q7kh7HEwvkMOQQ7Ufb/4
	vdrkJGBsNemyXKVbMiDHDleo0g42RjpcKOLaZz1+/6VTacyCWmJ1+f7smzkL8E6v1p6i+6w8VYj
	UmFWk4pX3NUma/krpxckrtRzOLPINJMtNfMB4c0Ra8Ew/+mLiBWRMA/P41Eeh95o/sKCzPgmLkm
	oMtxYEfr/sFKmHm2hvzZhM6LVfQFIKP2td4r86Tyef3UomAHLoNmi+RyyEpfBmS3KK1ogY2Flaq
	5EkDcqmcYSkRXuZiRINz+U5GsK6sJvWUvE6BolHSqgpo7SlP0HO+PiZ4wHwuPNRvm/HpT//rvPd
	+P4QFAfkcaEcerxba5iEtpEaRYNDQEEAv3MHTpaimDTsAg5rSm6wWGNJvw+j+eY+kxJr+5ZioNI
	qBBPhZRF1H60NpvRODgf/hJ5x+205YeIjONj91aQ/vm/n2o9GTIj8vmcRUVYr5ppy5q/FEIVp4T
	J8zBJSXTv6rOhkI7fxOJ2LE9hpPJ7GJ1m6atdlN5XlZM8O7W
X-Received: by 2002:a05:701b:4503:20b0:144:fb42:52 with SMTP id a92af1059eb24-1a6ceba5bf9mr6386744c88.28.1793269676390;
        Thu, 29 Oct 2026 03:27:56 -0700 (PDT)
Received: from server.lan ([168.138.199.194])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a75d85f23dsm11958719c88.11.2026.10.29.03.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 03:27:55 -0700 (PDT)
From: Coia Prant <coiaprant@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Coia Prant <coiaprant@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] net: pcs: xpcs: make supported_interfaces authoritative
Date: Thu, 29 Oct 2026 18:27:29 +0800
Message-ID: <20261029102728.3189359-2-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
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

pcs.supported_interfaces is the mask of interfaces a given xpcs
instance actually supports. The compat table describes what the
Synopsys IP can do in general, but a specific integration may support
a different subset: the RK3568 XPCS supports 1000BASE-X, SGMII and
QSGMII in hardware, but does not implement the C73 10G or 2500BASE-X
modes that the Synopsys compat table advertises.

The Rockchip glue currently advertises only SGMII, since that is what
the RK3568 MAC side supports today. 1000BASE-X and QSGMII can be added
later when the MAC side gains support.

Without narrowing the mask, stmmac_phylink_setup() merges the PCS
supported_interfaces into the MAC mask with phy_interface_or(), so the
XPCS would contribute 1000BASE-X, 2500BASE-X, USXGMII and the 10G/25G
modes to the combined set. The MAC side forces the phy modes and
phylink start passes the mode explicitly, so this does not currently
make phylink switch to an unsupported mode, but the combined mask still
advertises interfaces the SoC cannot use.

However, xpcs_find_compat() only walks desc->compat[] and does not look
at pcs.supported_interfaces. If a caller ever passes an interface
outside the mask, the core would still find and configure a compat
entry for it, contradicting the mask the glue already set. This was a
known gap: the mask was written but never consulted by the core.

Fix both sides:

- In xpcs_find_compat(), return NULL when the interface is not in
  pcs.supported_interfaces, so the mask is authoritative for what the
  core will configure.
- In the Rockchip glue, clear the mask inherited from the compat table
  and advertise only SGMII, matching what the RK3568 integration
  exposes today.

This is a logical inconsistency rather than a user-visible bug in a
released kernel: the affected Rockchip platform is not present in any
released version, and the MAC side forces the phy mode, so phylink does
not normally pass an interface outside the mask. The patch makes the
mask the single source of truth for both the core and the glue.

1000BASE-X and QSGMII can be enabled later when the MAC side supports
them. The C73 10G and 2500BASE-X modes are not implemented on RK3568
and are cleared by the mask.

Signed-off-by: Coia Prant <coiaprant@gmail.com>
---
 drivers/net/pcs/pcs-xpcs-rk.c | 6 ++++++
 drivers/net/pcs/pcs-xpcs.c    | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/drivers/net/pcs/pcs-xpcs-rk.c b/drivers/net/pcs/pcs-xpcs-rk.c
index 6f0a110e32d2..cc11a70d624f 100644
--- a/drivers/net/pcs/pcs-xpcs-rk.c
+++ b/drivers/net/pcs/pcs-xpcs-rk.c
@@ -536,6 +536,12 @@ struct dw_xpcs *xpcs_rk_create(struct device *dev, struct device_node *pcs, int
 		return xpcs;
 	}
 
+	/*
+	 * The RK3568 XPCS supports 1000BASE-X, SGMII and QSGMII.
+	 */
+	phy_interface_zero(xpcs->pcs.supported_interfaces);
+	__set_bit(PHY_INTERFACE_MODE_SGMII, xpcs->pcs.supported_interfaces);
+
 	xpcs_config_eee_mult_fact(xpcs, pxpcs->eee_mult_fact);
 	put_device(&pdev->dev);
 	return xpcs;
diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 6466e0ff2a98..46878a66064e 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -169,6 +169,9 @@ xpcs_find_compat(struct dw_xpcs *xpcs, phy_interface_t interface)
 {
 	const struct dw_xpcs_compat *compat;
 
+	if (!test_bit(interface, xpcs->pcs.supported_interfaces))
+		return NULL;
+
 	for (compat = xpcs->desc->compat; compat->supported; compat++)
 		if (compat->interface == interface)
 			return compat;
-- 
2.47.3

