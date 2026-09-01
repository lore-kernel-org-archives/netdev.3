Received: from mail-pz2-f9.google.com (mail-pz2-f9.google.com [74.125.228.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A16841D20D
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 15:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788274982; cv=none; b=cUhhmjpVx6fb0DuTb1JGfXMsCoKbvOIWryfyobxRu5U02OLcWzirjmPqrzxZSJjKc+z5/xRp2zi6emsa36FyQQnEYFc4G4Af751qVc63TkgDbd/2db4elQFUJnxbsvPmgf/xWtK7gOvSwrkLDEQXxFdOObtxI6tIxflwVKTZHoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788274982; c=relaxed/simple;
	bh=iCQafZpFqsdcijM7wQ/VBsqWEiby6qk8Gp6Xz65rtD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W3aP0OEnelLEwbKmyJL0IhPpMRLP5viq1Zp4psD+VUgLJFmZc1CebJqmQJJtdGjPXoLIU+WBWv0M44Ab+uZYm9fp4pvDT+5/+zxK+ofLJQzfM0NwSA4VjMS5jsAAYZK+oNlsYMSsL2247WNizNZ+u8rKUw0nxnpvZPZMTm7H+/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rkktWk4S; arc=none smtp.client-ip=74.125.228.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rkktWk4S"
Received: by mail-pz2-f9.google.com with SMTP id 41be03b00d2f7-cc150711112so775488a12.0
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 08:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788274980; x=1788879780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7inwahIcNU1aV9djAHi258zSUQz0eW0dslHEgzobBAI=;
        b=rkktWk4SfofP6WnpAL5ws1bWPxRUKhfc1yDrgKLcjuibn4VjzSdmuTsdpUVs5Vkrl9
         aFZohe9LfrVWYyNiW7yWYapLl9W/3KhGA6I5ubzudlBMgUeyTRhhcB+jjH/6b5nTTgFz
         wmUcz2W7UJQRpnoGI2xAGfnJ0pmuHlkrGcP11+Axk4ofyvpB5fTJGcnT+XaqgLooCl3q
         Qr81TNjne90RGvlUN5NeP3RmbgKi6DhQHeRwwCfS4E8rgRDBX6i6VsYsxg8ya8JAReVU
         A7TsaK4tjgk66McWdiM1i7p/JPHrOo4THDXLt2rHiuIQqDwUhOXN/Y+usZAxx38ZzZvQ
         gihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788274980; x=1788879780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7inwahIcNU1aV9djAHi258zSUQz0eW0dslHEgzobBAI=;
        b=tVnVR9rqDJv/BQuIRlKlbQClBwx4eqIObusZ3Zxeri9FBCiFGI85ddSsVeJ7/PVGIF
         kvldN6OTncZk0QL1Ta6F4uEcwv5vnE9/M5hNULxjO9wSp6NNDLV6leh5SiU/kCG3+bgo
         mk6Q0KaO9ZktOJgbTafqreIFTZ+E00dgNBJPICi4UeSMnz66HnLAWD0KWvFPFy8ZlkNB
         mOPkXHgk8BorOl0xbEkSQEvU1yq5T9aOvsdQi0m81i/nYODkIzWyk5sAylGZyLoTbs9n
         129eFXeYH1iyoeb1EXBjmGFE3TvrvtKyfhcD/DREOl6/+aqZzqCh7oqHluOca1tt8IAL
         4DnQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp/0ZP6JgbopXA0ryJ5pMUHKSfjfHfkjDVMm0w0FcP4zfKCzpA82DHa0+RYTOCGRATK6RQUdBw=@vger.kernel.org
X-Gm-Message-State: AFuF++ktHGdYK1QAyukHN5eCUA9F8EHytoRfj0049rMYKSTFkuEcglea
	ztf6AQorAMGewp5ZaICVHO8GOXrgHt8Kow/ry3s5wo911kF22dZpQo+IuDOY2dJnXG6g+g==
X-Gm-Gg: AR+sD102SUGJAZ7RFLo+tV4Q/cB0zQsMvpWPU1JYIhwn/RV8d4djQvswjTaNI/gUbHC
	32lv/wuqAFXBHURIFAOJC9oqj1uX3Td6JYkAIpzgPK/ZJbuOnA/vfXAYJ9qw3h++1CiQXqL2uyk
	GH5Q1tKIdLETDcA1LJCd9lullyGWE8UXYgW7oSr6q1gB4e3czU18PGqi8N6g/CD69CPZX+6fsr2
	i5y/8l6Dx28dklYbBQQeZNanMzMguygGMTbiibAhR4f6C1MZVIKsqIhGoR5pWk08etKY0K043am
	1iECSBrxBEZVn7V7wLuEOp7C4F6aROzHMNcpx2GAoVaeW/xoXy/1XgNPDwzHqrLog7U+RgjbA+N
	UnmJCk22WAdz+JyQRjUcXKnAdlz4pShshyy28BjLOhtrq8GAaWvshKtRvx8sx+L9bb0k0t1cxEE
	X7LSPQQTwcReIIlXWExkP7Rlh9TNEPmI3RqFpAY5wq3z8zVZJoytHFC7wE7Pw=
X-Received: by 2002:a05:6a00:3d0a:b0:848:417a:d1a6 with SMTP id d2e1a72fcca58-85b5b321d25mr11818840b3a.15.1788274979663;
        Tue, 01 Sep 2026 08:02:59 -0700 (PDT)
Received: from server.lan ([150.230.217.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85dc0716846sm27914b3a.45.2026.09.01.08.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 08:02:58 -0700 (PDT)
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
	linux-renesas-soc@vger.kernel.org,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v3 06/10] net: pcs: xpcs: add ANRESTART support for SGMII link recovery
Date: Tue,  1 Sep 2026 23:01:06 +0800
Message-ID: <20260901150111.141037-7-coiaprant@gmail.com>
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

On some hardware using the DesignWare XPCS IP (e.g., RK3568 MAC side
SGMII), the PCS does not automatically restart auto-negotiation when the
link goes down and comes back up. Without an explicit ANRESTART, the link
stays down forever.

Add BMCR_ANRESTART in two places:
1. In xpcs_config_aneg_c37_sgmii(), when starting AN, set ANRESTART
   alongside ANENABLE to initiate a fresh negotiation.
2. In xpcs_get_state_c37_sgmii(), when link is down and AN completion is
   detected, clear the interrupt and trigger ANRESTART to restart the
   negotiation process.

Tested-by: Jiawen Wu <jiawenwu@trustnetic.com>
Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: Coia Prant <coiaprant@gmail.com>
---
 drivers/net/pcs/pcs-xpcs.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 0337e2bcc0125..50b9cdf94fdaa 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -816,9 +816,14 @@ static int xpcs_config_aneg_c37_sgmii(struct dw_xpcs *xpcs,
 	if (ret < 0)
 		return ret;
 
+	/* Clear CL37 AN complete status */
+	ret = xpcs_write(xpcs, MDIO_MMD_VEND2, DW_VR_MII_AN_INTR_STS, 0);
+	if (ret < 0)
+		return ret;
+
 	if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED)
 		ret = xpcs_write(xpcs, MDIO_MMD_VEND2, MII_BMCR,
-				 mdio_ctrl | BMCR_ANENABLE);
+				 mdio_ctrl | BMCR_ANENABLE | BMCR_ANRESTART);
 
 	return ret;
 }
@@ -1093,10 +1098,15 @@ static int xpcs_get_state_c37_sgmii(struct dw_xpcs *xpcs,
 		return 0;
 	}
 
-	/* Clear AN complete status or interrupt */
-	if (state->an_complete)
+	if (state->an_complete) {
+		/* Clear AN complete status or interrupt */
 		xpcs_write(xpcs, MDIO_MMD_VEND2, DW_VR_MII_AN_INTR_STS, 0);
 
+		/* Initiate the next round of AN */
+		xpcs_modify(xpcs, MDIO_MMD_VEND2, MII_BMCR, BMCR_ANRESTART,
+			    BMCR_ANRESTART);
+	}
+
 	return 0;
 }
 
-- 
2.47.3

