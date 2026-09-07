Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com [74.125.227.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60673D6CA6
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 15:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788795594; cv=none; b=CSbA4cT8jFdu3CGG3VmNQevrt6nPC2VcImJRHsHvUPG+GuEZA35lhtJmxNgb76xS0bSKIDJvKNIsSQjep2XMhDebZrjNPUgnjqEPMKgB4Ud5sZchnP1u+DyFc0xQAHPSaiEsYPKf5Mt3HVV2sEl9nYby3rwTbEfSWlY1CYnQVzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788795594; c=relaxed/simple;
	bh=2iJPpKOoGy+/l4LMviPQoRKnjhDXm9qqPLLD9Cdfo1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bhKtUlLhPOZzwkU+Vyrsnv+8EH5itBmacLgVgDbWf+0hOQXZA08ICVkPkRI3PJ2zCRuUGItVfhbklTkxI/boMWN7b/G05aQsA8YDES0Ng56zL22XP9aQnjkz46KFq0AEv3Bz5FwF8cFrQ+wqqib7yOielexYIP5LmlEuwr2ofP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jpG5vmr8; arc=none smtp.client-ip=74.125.227.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jpG5vmr8"
Received: by mail-pj2-f11.google.com with SMTP id 98e67ed59e1d1-396d27bb2beso3065603a91.0
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 08:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788795592; x=1789400392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cBvlH6prRmF9is7rqvJqNTGgh3P2sJVPtfOXauJIgQo=;
        b=jpG5vmr8RyoYuxxhINnbMRJJHBsO63kyrYnOzsysJq5pf+picb46U+vDQnLeiFI5Q0
         z8cKzEtL07FuOToyRWjTluUjVnsbM85ailrYeRyXvaYY5goo6iQdJ9EVgSrkMf9imUCv
         /amgMKsl7StJiBFFYAemNAABFUYby+6BIlkOZ5QSyJ8jIlXnvteO2WiRW2T+YTYIfM2l
         nJy0pDEeZmIfiCC01SZlKa1e4yPP0alUN3NHcq/d+07g3E71Z8bTjqqqvpeNKgqkXmpx
         7lZZXKMVfilt2gaxaM4BwUd4eTyurWJyS3oy0wUFWO0d+LAflUSS4rniA1rVLsVi3XnU
         Jg8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788795592; x=1789400392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cBvlH6prRmF9is7rqvJqNTGgh3P2sJVPtfOXauJIgQo=;
        b=dA5jpD8Str00wxnMSrdisVzrx1Za6yGjoNJEDp5+jlxtVJTlM0JdGOe2gjkq8Bl21t
         FQDBxCbZmZ+N5D7v0X6We8xgM3eEoqjbDaOzkEGPd3ELox6rCdXlnpGj3UQXDsaLBbtQ
         KVzUmxzXoIVvr2KtUad9gI+AKI5HFO7T8M37U6FVmWh21hJvryPq9x0yWUStwVmWRFIT
         IG6EHxApke94sk3V2reBI2JxG4YnGwAqhyHhtvOwYwun2uNiZTiH1VY5n3GN9tkDggi0
         HgjpSm6kmxYvxj2rfbOcJPMi1C/71KQV5gRfS6rYFMf9zFTeTOO2w2LMP//BgJ1eoXFw
         a6vA==
X-Forwarded-Encrypted: i=1; AKwUvBzyuppftYbwM/z5fTqiMwfklK/UvAUTjyIZHBiwvVkPL7wr5KiWhJj+MUMCH4OP4/vFnp8+A/Q=@vger.kernel.org
X-Gm-Message-State: AFuF++mggZnmt0WblXZrfjOS3Tr7/UNVEebVWeHMv67lCEiRN2YeRuQ7
	CAVgucFEXhQDf3UwsOEKJDJWnwGH5mM3hLAFaGhKWpah+gjdBqXz40KY
X-Gm-Gg: AYBFou3siF9G/VE3u43/eEKAJsmynT0iEmWDXaTnJLKnZb8K5e5vuv8k9iOeWA4AfcJ
	AKfXnMdmr8OnuP1wZCX5gm8v0o4dSFbfqY9nlsenZbz6HX0BUBX47TnrUvMXaB/Oo/eniuNFwHG
	WqYpeFSulUdBi14SVaLzlUn/1HnLI/YqK1cfgdspGG4bk3EUtzEqq/QN15oxW7Ngpj8SNrD7ZgM
	cQVyHYeEzSwm8WiZXDwAgw/4vScySgb4o26sioP7ahGy4k0UIXjRtidAXR22AoiAL0i/32zlBL+
	VW2Az+4RZu2DPsUXSLf31H7N0V8RwDzsVPn1B/mhZnSHPK0m6Kz0zcLyapzpELpbfcgQQBdrD4R
	xUTXxE6KXxQ7AZ6+PZ8a6XuLEKhZUUVPtRnUNGSIComcaVlrTWvCKdlJLNUq17R7xdnjfrp0bpk
	FkXK/Oifol0UQMQIRWDn02EhmATI+jnLLURX5iBGS0LDf1J0A3tYzpmEBMSvNh
X-Received: by 2002:a17:90a:1c96:b0:39b:66ee:a14 with SMTP id 98e67ed59e1d1-39b66ee3442mr7209213a91.25.1788795592309;
        Mon, 07 Sep 2026 08:39:52 -0700 (PDT)
Received: from server.lan ([150.230.217.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b260fdf9asm21690121a91.9.2026.09.07.08.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 08:39:51 -0700 (PDT)
From: Coia Prant <coiaprant@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Vinod Koul <vkoul@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Coia Prant <coiaprant@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Russell King <linux@armlinux.org.uk>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	David Heidelberg <david@ixit.cz>,
	netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH net-next v4 10/10] MAINTAINERS: add entry for Rockchip XPCS driver
Date: Mon,  7 Sep 2026 23:37:13 +0800
Message-ID: <20260907153713.2572547-12-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260907153713.2572547-2-coiaprant@gmail.com>
References: <20260907153713.2572547-2-coiaprant@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a MAINTAINERS entry for the Rockchip RK3568 XPCS platform driver
and its device tree binding.

Include the relevant mailing lists (netdev and linux-rockchip) so that
future patches are properly distributed.

Signed-off-by: Coia Prant <coiaprant@gmail.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fc320b373656f..dda4d211b7db4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23738,6 +23738,15 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/sound/rockchip,rk3576-sai.yaml
 F:	sound/soc/rockchip/rockchip_sai.*
 
+ROCKCHIP XPCS DRIVER
+M:	Coia Prant <coiaprant@gmail.com>
+L:	netdev@vger.kernel.org
+L:	linux-rockchip@lists.infradead.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/pcs/rockchip-dwxpcs.yaml
+F:	drivers/net/pcs/pcs-xpcs-rk.c
+F:	include/linux/pcs/pcs-xpcs-rk.h
+
 ROCKER DRIVER
 M:	Jiri Pirko <jiri@resnulli.us>
 L:	netdev@vger.kernel.org
-- 
2.47.3

