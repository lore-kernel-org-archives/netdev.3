Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794529962;
	b=G9uQWL/PdwBtcle4Vx3fTIZcX8I1+uogqdgJePhUQyDZl+4nS1IYHX1jHTp5eC3/gt/6
	 tP9+s9YAdzuxYGf888pqwVW1G2GB8dyTfZe349dLOBYM9L54Mmq67imCY+63+GNg2c2/h
	 J4Zn0Y+6ErYb2F08xcOfmlhyffJdFaKN4EkpILEp+jG/ZDpwTRneAN/omsmyASM2f+z4p
	 ub6DZ5MfobLVCH4BClPqq3oEMMXKJwgjRLkoUA3DWO/kpkdYMHj56QP/4EVJZjH6GmyOW
	 0naU1AI3WYdrGmqVtwavJNQiJS8pjQ+h2BUm8qYn6tn4/w/zHC6bHT1rsfLQ47SNhIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794529962;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=di0YXOvt1TX8fBMVPqb7dX4e39H6bFtaLw/ptG6JcXE=;
	b=kYW9zO7VKbYlAk5x4PvQ8nuBAM4+RG4/gVqAwYEDTCoXPDKAKNHT77TcJZcFvoOcriK6
	 IyCjNtRSZqUddrp8R4ra3xfjIcin5YQNvd6YnksSDahL/Str0hr+GA7+2lKC7CkeGDT58
	 al0uQ4i3cQv4aGNb3CgT0u0/TMDpwPM43Hzn08yW5+MkEHF1oiXh9ceE6BPbaq76Q7T6e
	 Ojtv1vIg/vD2tJpZlRIJ5bMatN+hPWwDOxFJRcIHYeD/Fb1lQpkkXMvC7xmCmCJmVcRya
	 tQKFitUJSlDCD4dYzjkIOIAi76PQ/9C5F6tlnCRN2/eluRPF1fpmh/3qU/E31zywtvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hTp29Dl3;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3949660A3808
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 00:32:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3949660A3808
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hTp29Dl3
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a215e64962so5832645e9.1
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 16:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794529961; x=1795134761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=di0YXOvt1TX8fBMVPqb7dX4e39H6bFtaLw/ptG6JcXE=;
        b=hTp29Dl3/fXwSC7T1y4v/ZOkf3y2Vs9AD5XVW6sK8tx/9Rd2znf2jvXkFcEnCV99c7
         43Wrvh+i/LIwGppmZT3IoAC7o+9UwWqw/Qwo9UEd25nwMjgAKmCNk9zwwAczTUqSf2E8
         mMuLPFzFlnwRwVLeg0pUCeUg/LFKVRFpzFm6q1LiBhOZVH1oZgqL9IhG9OlGzi9KBB2m
         jNd/628/BaUWjS3x8zw118tRw/p42CEXa2awQrPMrJva/pWpVphkYA7bdM7foEvCF0pW
         XUU6Q425Gq3BR5i4Yc5XzgRXocEsdDgdaDdJDE6/3oY1a6Ymehx9ePjVM/MDM7ZBOCYt
         Wd3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794529961; x=1795134761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=di0YXOvt1TX8fBMVPqb7dX4e39H6bFtaLw/ptG6JcXE=;
        b=ALOg3SbSKnhTIVjsxuI6vgQ8qJ5seh1qcyIBJZS6WI4DmV9c9M1RbkuP3j9FPnvWho
         O+jUNZ8tduSch0b4dzGfQouE/IVc6LmavgsGnjFbRG1q/mNtg+Q8epa+W4xmqaKEE/AF
         tKNjqx+ZsG70h2ROAgjlr0sq5Aq/K3nl3Zh293cGuFmPN5vKyAUxEOv/I79jrGaZ8JVr
         udFApN36tkXgwhaIMevy7ACYDa+DR2rn1KFQW6vztzuxDVIFMqqGedXwbXdsuzuTOYok
         uGAKv004sl1HegUAv7lsw3cNE4r5W72kd0DoGWAteA21HG1S0rTPp29xD7ZAsnxEZjRj
         n+TA==
X-Forwarded-Encrypted: i=1; AL+hErHQmlsJcHEyAZ/m6LsH/smpXYoXkr943JT/nkScDjXIBmqyQJj1+s/brX4bFkW2NTRoLZj1UkE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+oAJGn802VaJwwwMMNVAkFba+n+eQFiTPnFRgxY1+ZRhGithI4
	JWaGyhy+U3iGFpmWIstkWhLwzWxl5dCpS5NkR8qoUspzEvZZWTUOmvnA
X-Gm-Gg: AYBFou3VhgikQv+kkwS4/vFy0Yp2Ikdl3a6UU73xj6a0kE0kIKYD3CG3MEbi4CHqHME
	z8yJ8GYamod2PrYIlSmC6b1AelrJJYbLP1jZE6PrhAAIemugwcbaFUDpGIMWsPaT1VHsMdYdEa+
	PY7Fh6pNBoSpWdJe+gKT2vDDvMSypUdaU/6SZWwpoCcS27WArAm+F48g2zLk3YtcIMRZSxHl3fV
	CYM3G8kzvqxIIDBEUvL8t8y05Dz87XgbtpJ4pypI3lMXtzEYjwcumHOQ1Ax4WDr+3e5iVHSvvc8
	q/GHiCtkJetbbd/NLDBllWvG1XYjCOZ46kQZ3V2KKqLoFR200dVEiPlHGgXrJre294Je26v1iiU
	oL5N5hYWHSBZd3qn8GUo1F1TRumQ5lhzTMuUy8HcfSXeOy2Ckj3EgoP5FDEJ0J7pCK4yrQvlvdI
	kIQSDRnMX9FVdwfctM14SRXqh9oRmrTLCd/dz8IMZVO23ZJHriHSpD9QBtoV2eBM8wE0lSPiI2y
	daq2YNgunJE6feP66i0mu1g/EsgmM7LbSQMkTg4MTxI0EJ2IlqvwJBhAxSG7rSDRc3ppvXiwvGU
	/wy3L3btPyAOAOiPMXdp9BjQD05fZMMVwW7r9g2jeVJnS7tBxE+AevX2dzaX9WriCWi3G0mZaIj
	U56sOC3swZoiy7MIJPhWHOl2mvg3ZxvdLCW7SCdsnZzVqCz0Dl0SWBE0=
X-Received: by 2002:a05:600c:c167:b0:4a1:fe55:88ef with SMTP id 5b1f17b1804b1-4bb55a92fa1mr18062495e9.20.1794529960557;
        Thu, 12 Nov 2026 16:32:40 -0800 (PST)
Received: from Ansuel-XPS24.localdomain (host-212-171-11-167.retail.telecomitalia.it. [212.171.11.167])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-49c5f7828a4sm2029768f8f.23.2026.11.12.16.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 16:32:39 -0800 (PST)
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
Subject: [PATCH net-next v19 05/15] net: phylink: save phylink instance fwnode on phylink_create
Date: Fri, 13 Nov 2026 01:31:55 +0100
Message-ID: <20261113003217.197757-6-ansuelsmth@gmail.com>
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

The firmware node associated with the phylink instance might differ from
the device firmware node passed in phylink_config as such device can
reference the parent switch or other platform peripherals.

Some function might need to reference this firmware node after
phylink_create so add a dedicated fwnode entry in phylink internal struct
and save it on phylink_create().

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/phylink.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 64b00d324988..e2e0b313fd61 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -47,6 +47,7 @@ struct phylink {
 	const struct phylink_mac_ops *mac_ops;
 	struct phylink_config *config;
 	struct phylink_pcs *pcs;
+	struct fwnode_handle *fwnode;
 	struct device *dev;
 	unsigned int old_link_state:1;
 
@@ -2185,6 +2186,7 @@ struct phylink *phylink_create(struct phylink_config *config,
 	INIT_LIST_HEAD(&pl->pcs_list);
 
 	pl->config = config;
+	pl->fwnode = fwnode_handle_get((struct fwnode_handle *)fwnode);
 	if (config->type == PHYLINK_NETDEV) {
 		pl->netdev = to_net_dev(config->dev);
 		netif_carrier_off(pl->netdev);
@@ -2272,6 +2274,7 @@ struct phylink *phylink_create(struct phylink_config *config,
 	list_for_each_entry_safe(pcs, tmp, &pl->pcs_list, list)
 		list_del(&pcs->list);
 free_pl:
+	fwnode_handle_put(pl->fwnode);
 	kfree(pl);
 	return ERR_PTR(ret);
 }
@@ -2311,6 +2314,8 @@ void phylink_destroy(struct phylink *pl)
 	list_for_each_entry_safe(pcs, tmp, &pl->pcs_list, list)
 		list_del(&pcs->list);
 
+	fwnode_handle_put(pl->fwnode);
+
 	kfree(pl);
 }
 EXPORT_SYMBOL_GPL(phylink_destroy);
-- 
2.55.0

