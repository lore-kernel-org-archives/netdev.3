Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC11C3FBEC1
	for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 19:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789326084; cv=none; b=a3ORq/YyhhxBGBQR/0sVKRtjVw2fJIvB2ttz9E+VWb7poWwJsDcWfoN+Bk2VR74YQHjlOI6o5WtlX4rVTXMbiK8yZb8q3pMGfAlGt1qNdk7lTTvz9o8SJnNqDJxOiOb8Xa5bQCI6lN/pLoQGtypiXo2u8V3ogBGgvnOGPLbiKGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789326084; c=relaxed/simple;
	bh=nHafMZ2XTe7EQPlPZqClpxTD8fS1jL3tscvPWXqEAxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QNxpANa5LAUmUw+z1YowcPujPVvnPFJZWrzeeGEDXI2poOzepiQ8o11miXJygiXwlN0Jp0a4SL8s20sCIeXxskjTAhOa0Zmb1W4m7b02uT0PFwwVWCmAhexcLwYAqkyhDOklxxk+vEk7R31g0dVSfXhRmITXE9uC09rl3ni3yOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rPyZu+/k; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rPyZu+/k"
Received: by mail-pj2-f1.google.com with SMTP id d9443c01a7336-2dae660f31bso18548555ad.1
        for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 12:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789326080; x=1789930880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zQ2IdKH/7qjrKGR31C/pLtiJWP+p6fNr1pFwJZ+2Nhc=;
        b=rPyZu+/kk2XMIIwSsUHuuioNHncKg4sF3/zzv33gi8dnPxp8fWVYCSi2gBVXJVBgko
         /ypDWFofgTUWY/9kn2bd8zZgB71+XtJNCEaeGRV9f56V44iJ05a0Eu6Xfliac6x+oYYP
         EIY1w8vphq4EhGpJKFL7r2ibARmdGCJsx5sFe/6o35RGr737S7ryvLZ+or+6tDJ5Asxs
         5jWzfTW103Q0wsqAfVi7TkaQwn83RgW787/de450zR2IANPJgNElSuxa3/8HCSySYHXG
         dLEGmYX2MJfzXfrD2icalr7g2Kfi1bclX0AY16FGNJKwyddvYO6v/2XjkR5ceXrS+kNR
         Yn7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789326080; x=1789930880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zQ2IdKH/7qjrKGR31C/pLtiJWP+p6fNr1pFwJZ+2Nhc=;
        b=U9SfU9OIB/K9iPakRKlqGvexDk9cBGj2QJCKzME6iHrPKX4nEU0uhnpH3AExy/wU9e
         mPwkzQThX20xEEzg53P1wfpSw5b1FrxCzDw0gvtlVpl7OHeV6OCdDAELQKifghp6wtO1
         +gJ7FTmt4ECALVWA5Ap4xaajTCxJ9LBTbm9IOnVOHUVIbLInRWpLvYMc0br0A/t8P15Y
         3OIdhDAcn/POem6mRlhrtUp1laEJk/PJcSpQQFvJqk9HE4j7eoZEE9hHs8oPCkztISUn
         ptPW5WiZ+DLT9N1LG8mAE56ym6gzMV1B2SI75qzYZ/vzXJkeNY/Utm6fhv2h2zky68h+
         Q3jQ==
X-Forwarded-Encrypted: i=1; AKwUvBxJsSWlA+7U7MgY1s4NjR5qRRXNgIcQxmYGcC64NB1kKfCRaEGfWg/uM67MEpSSq3Xg7CrrZzM=@vger.kernel.org
X-Gm-Message-State: AFuF++nFKZUpbJj4U2aJvtR5On3hl8dcHhWDgc06LTgr4CU5737UFV2N
	Nd7daNJw0KVgqvBhK9PgQc/LdWetwqKLV+22Y1a+WbirlcEqqwuim+rs
X-Gm-Gg: AYBFou2+T9Z1s18xTo9zabSUvZAActL33csls52qgTKVN090wsFrSyw/yn6W+5rLK84
	+6cIhBoXezAe48hdqz/ytTXXpYH6NjL/IBPiIT/+D4RpuNnaGcGn72VY7O7Xs3I1uGjFZZsp9le
	RxKRqy6DBV7XBVQjUzcDymU4aRO0t7FgSWPOhfp3gzh+v6RyAAPPn9aUqa9xMdxJnYSOoy5IlmX
	Bes9bX9Ts/UOQ9kCEWhAhdRYY4CLFdT6Qhg4SuPj8fhEloKor3g0d/T0ysNui1c5peb+jBaXAbe
	9t6DwRUySVeNRSL9LpPO+03WH7d1ppIlllJyzUoM3ERifT0mevBaINUmcBnHKkpBdUu5UTAXlmZ
	j/QI2V4Iyp3cmTjtSlrfZ//HQfT2tzjrCY/9wo8CAF2N07zK1Z2UnSpnxBPq9GrRw8UvpsuxfZv
	DAH42rnDO23t3DgI9G1v+4siKzdpseMLP6WMeHCHNNYfsdpWUlpiHgT0siJ3ikxvMZlkbu9Q==
X-Received: by 2002:a17:903:1a2e:b0:2d8:d4cc:be63 with SMTP id d9443c01a7336-2dd2a35aa1cmr275548375ad.16.1789326080540;
        Sun, 13 Sep 2026 12:01:20 -0700 (PDT)
Received: from server.lan ([168.138.199.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2cca6b7bsm36808655ad.3.2026.09.13.12.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 12:01:19 -0700 (PDT)
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
Subject: [PATCH net-next v5 11/11] MAINTAINERS: add entry for Rockchip XPCS driver
Date: Mon, 14 Sep 2026 02:58:46 +0800
Message-ID: <20260913185849.907479-12-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260913185849.907479-1-coiaprant@gmail.com>
References: <20260913185849.907479-1-coiaprant@gmail.com>
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
index c2414447892c2..960a53afa8357 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23739,6 +23739,15 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/sound/rockchip,rk3576-sai.yaml
 F:	sound/soc/rockchip/rockchip_sai.*
 
+ROCKCHIP XPCS DRIVER
+M:	Coia Prant <coiaprant@gmail.com>
+L:	netdev@vger.kernel.org
+L:	linux-rockchip@lists.infradead.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/pcs/rockchip,rk3568-xpcs.yaml
+F:	drivers/net/pcs/pcs-xpcs-rk.c
+F:	include/linux/pcs/pcs-xpcs-rk.h
+
 ROCKER DRIVER
 M:	Jiri Pirko <jiri@resnulli.us>
 L:	netdev@vger.kernel.org
-- 
2.47.3

