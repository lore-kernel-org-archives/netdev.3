Received: from mail-pz2-f7.google.com (mail-pz2-f7.google.com [74.125.228.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F80418A54
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 15:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788275050; cv=none; b=KfjPIqBruV6WL+M556Zn6dCB1nSXpCOhsKHW91Tl/YGxU91cXRRTb9Z7RaTFP1lLxjnGDLEeJzUwPS184DHpKAjcbksFPGoLT5DAdUCQ1mFDidF4gIpr6+k/jf1qEBeEec4i9NveOxCi1sMlEHChYCPxeYvTkCY0nmBRFE+lg9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788275050; c=relaxed/simple;
	bh=VMBfELsDgdw4LHnXCPqjLHfbD46aI9SXxvEcWut9ryc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ulF2o2OAxKeNk4lgyz7MHuayqOHTZuLnpFoyef9GcGOIB2IeNSDaDQtuGgCHrsj2VgBOe9k/f+AXhpBRlY49lWEzr4Xq/vfRL82IzFVPcCDZM2ROzU4Z4TE6hTCJmV6ayhfGq5X7cjPNHNW3PerijIs7yFzaUoj/RjmwI6Lq6po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=brmu9yGT; arc=none smtp.client-ip=74.125.228.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brmu9yGT"
Received: by mail-pz2-f7.google.com with SMTP id 41be03b00d2f7-cc1ddb3ba3eso3187662a12.1
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 08:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788275048; x=1788879848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jFOAryefyj3E8LprwQb6zM23kP14ZZpWJUCwFcY71vI=;
        b=brmu9yGTEA2F4WzPCq6ADcgF7oOZy++TTvE+0A4rE30xUoEOT6hWOz5XtZPRBGh7NI
         VdA7uNEsUkaBJIjyaNdrV/WEW218oPPbEwXuLXTYwpTbeAU5fPhJFRMuQN27pKY0JQgr
         9p5yXkCKY/anvFDdiOPEs0dbGhGAjhtSTbUXZVWjdsobeRL0nXh27qXK74EPuhhyZj/j
         4p+4gERbxqoZFE+vq5LvdyDZHAiyBqfEWeC/0YQbeIhFVoDq39Yg/l80Tlx8mpnsSSnP
         iInc1Fs/c//Zlt7ga4B3V+AMNVG2n7IdHs3tOWXqqMo+r9VH1l+RsJvnbePrEGWOC+mG
         460g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788275048; x=1788879848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jFOAryefyj3E8LprwQb6zM23kP14ZZpWJUCwFcY71vI=;
        b=W53VL0ZZF9YxKCuwk8aWCLYfptRGtrlSjj1BkmIRNrpEMIPYu5bOA+hsFrCNOoAM1d
         zPcjNkByXt/Q+X9/z9W/WRAPMaDREXJGck6WRHTDgH69POEqqVRYyNSeSZtHKkEipPOv
         Ltk7Wp8V1CUoGkHGddfr0yq3FYqylgnSfdwFrWG3MNov+XzDfSOuQ7VjhBMAh3yp6rVH
         +3VvhHVk8+m6GmLryOLbEigCEsNMyJkEFV/9BrPZgkTVvA91f9KsAl81e4cJ25h8XrkK
         XCRlh8cUdND2pp/I+eCBI9Cw/uQ8/hc1aFp3NveCoT0UFJ2X4OmJlVr+15syJ1nXJ/lv
         0k2g==
X-Forwarded-Encrypted: i=1; AHgh+Rqtd3jDqf8/PIphDO9A5Gbd0wuxrRn3t2uTOcUyp+00tBwn89ENKBYXdP7Uc+NKSefbKZY+hL4=@vger.kernel.org
X-Gm-Message-State: AFuF++m90wh9Lmh3lmdDjLPqj2BZcKs5cOipnHDmM4auo80adjSc2wUp
	lb4YhzzW6PbO7scQccfnNJqjQzu7rytHpQRSgKUNwRwPh+2UTV/rGyjE
X-Gm-Gg: AR+sD11sLiIT4i0/DM0BeD2IRk4CCMjDvETuWNwl97qHwCiyljTA8svmgWEjT8BRO1R
	hMoyTaVtOOWf/szcRySn+I8J4JXfG2w++6fsO+U1Z2AEfEG9cyMoxtzzlXwbbnqkM8gZg/sL9WK
	qw1vlx5v5UJnVd+c8gmAp+ZBUcFN6QHR/iwY+OxcT46pDpE+ZrDGW3cxkd8AC0eB+MavIVWIPaV
	fmNWIJF29TwPY+/RjPpI7gw1gnyY1R7gyGluaitRreuh3MDkjTi1fvRUYW5LeotBT6fqtpFQnMP
	7YgPf2bycvxiTH6/V8HgT/FNP7zNKJSj5mKWdP4Cpycs+1u4DSsvOUwIj6titIbZcKtcMyvdjY/
	LTZL+MsnWJmehvcwUVcNQqVikiuaXBOQEAx/XA0y2CaOqsHIjPtKx+lHmsk/rvpzYnnkPm3wkT4
	xSaFehaaIUTGNLiRViWpWvlgw/E5pGH3uyB2YFq7AThO2xxqepDDMSmOYfBt0=
X-Received: by 2002:a05:6a00:4501:b0:857:72f8:dc91 with SMTP id d2e1a72fcca58-85772f8de55mr39669660b3a.18.1788275020723;
        Tue, 01 Sep 2026 08:03:40 -0700 (PDT)
Received: from server.lan ([150.230.217.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85dc0716846sm27914b3a.45.2026.09.01.08.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 08:03:39 -0700 (PDT)
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
Subject: [PATCH net-next v3 10/10] MAINTAINERS: add entry for Rockchip XPCS driver
Date: Tue,  1 Sep 2026 23:01:10 +0800
Message-ID: <20260901150111.141037-11-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260901150111.141037-1-coiaprant@gmail.com>
References: <20260901150111.141037-1-coiaprant@gmail.com>
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
index 3a19da74d00c9..c3b17752cc817 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23744,6 +23744,15 @@ S:	Maintained
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

