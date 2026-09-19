Received: from mail-pz2-f7.google.com (mail-pz2-f7.google.com [74.125.228.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFE53E4C88
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 12:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789822396; cv=none; b=iiH7Hno5TAcTTMQgjbtf1ZzCq/0el7WYQNCAxuwQWu7ptgU0V/Q8K+GMYnfDEIN4YMknH7k4VUcDbMRHNhX3XuZrD5Ktj8qJQEq7ZDOY5hzPxjAHiZPAiwMWhWVLqMi6W1Bh9sYgo/9e7IBBi1N3KwbOP/hVy7KCXAx2TyHf4Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789822396; c=relaxed/simple;
	bh=tCrgHNTqayWFj1XRarWJorXnl2XIBvQrDCQv89fV94M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b61eZ8TWBPJW9HtgS0uuGrYyMc+UevqXqDDuC8KtrhHTdF2jDqKd3dMlxECm+j3tql26hEQJZP4cr6Mdfe7SFcc/WougEYZDFN0PeEFXtwD9Y4hnRtsqVBJaLxHCV0iAb884vwNPWsh5PTtXkimd1mKFwt6YP6QsdHX9dgkmKgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MYRJkC55; arc=none smtp.client-ip=74.125.228.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYRJkC55"
Received: by mail-pz2-f7.google.com with SMTP id 41be03b00d2f7-cc1ddb3ba3eso836676a12.1
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 05:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789822393; x=1790427193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rQei+xFrWR/8tHZU0Qo/Qb7KMibEAMjL/DUhroeeXK4=;
        b=MYRJkC55yHwhHoONtGB5ttuGAyN5MCrfpYjCb1B2hzqkTPZ51muAILPGY/Nu/IwOb8
         dVCo8fyIH9bxEfRit6buo/MBTw+cA1lWDGVrzRz8eGIdzUgE9lq78U1RUcwmC4k5sMqy
         2QKZg/mn0r62aonntu/exwVXyEXYxfAY2MEM02f90Xa898AdqMZpJRe7gq5WhnqOCgik
         J94NQPk8o5SsbldFG6Igv27/a+vqb2g+Fm7xlMw2Lt2xYp8VysBP1zlFTsGfk575zrNa
         veF7VeSMu4iqddGsywnxxDcZmrtQH33m3RCivWj6FGuy31MuS4xtUvj12b8hwohb7BLc
         e/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789822393; x=1790427193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rQei+xFrWR/8tHZU0Qo/Qb7KMibEAMjL/DUhroeeXK4=;
        b=r9k9idUmNJvoU5kEFPs6JCO7bidG0V7SjZzE96WZML0ERIQa5Ei/tMJyeBK98l0n8+
         6aD+rt9BcoQVl38NFa3YlkTfo0CszrB57UG1G02UKJGLungIYiKXSxrMw5WjpA3EJ6MS
         5YZhxGomywG5FIFsVzBMdX1xe1GS2j00kP1NMlJgyq1mjNBVEGCxjJlEuGd42m3wDJe8
         dThQFerKUb7Hla5mIkhioSXxz1iHLq4+q00uXby0lSLlkZ4pQJ+VnMDhVl+zv/AAGlwL
         hxzuUGCYKHCXRig0L3qpx6jEE26fDT18u1PX52LneU5gK3SQAfzsVq+qqivMf9z5h3+P
         4WFg==
X-Forwarded-Encrypted: i=1; AKwUvBwho63a59NVDsnHpSYKld5ety9pLYbxWQdoN9pQUGE7raXAT72RLWKdktH9udmK2K2KGv+nfgg=@vger.kernel.org
X-Gm-Message-State: AFuF++kCUztZ7TTV1AwOCwYrdxHpvzTDIFvEPdj2V7X7UP8Bm5YCKYDj
	YHWn82FYyLoo8cJh2GgxbgUT6W5y+v9l7k6Eb551PdqSQG/yg9x3+9f4
X-Gm-Gg: AYBFou1ygAGU24tToh1yT4GB0YhsnxoK6oDU+anBshMUb49v/jDZTVyDddmQvsWGXoN
	/5UAFGe63MpqqfBJLIvR78mIr1nhfyBNyWRI63a55XTikRKYr9zVhbNLaoAXZfB0FqzhIiLe5k2
	gNeYz1Isz1mm0B1EvEPAEfsngRq+ZL0e3eFds4tOKowruvSFXc3Lw171ukpmIQOtVFXdFIdvjN8
	b63oxQzApr8SPeahpyNW9XdHbSVRTgzYWdHximkqtLV2eYGZ2wyXmLvRbtYkMQ0vvNoDNBs5tUD
	Ji+orX2kIoFQJGovOrAcibneyOUTIZknXumW0QpfY85P5d+sy+FG4NF+viLvXGf6KnDYb5rqoJZ
	nWvPvZKkbuLIW87cwGhvlX4rAnqrYTVVPYEv/eQQ/5Bf1jr+/S+Bo3UDqU/I8O/azuWl6PfBHZP
	KfS3IBKty+jFAJIY0N6eKTHczAh8gj4DOe1oX8hywbPXCThD6U7XByHNlSnfoYP37P3QYGfA==
X-Received: by 2002:a05:6a00:1796:b0:874:706d:8573 with SMTP id d2e1a72fcca58-874ddef6806mr9062175b3a.27.1789822392717;
        Sat, 19 Sep 2026 05:53:12 -0700 (PDT)
Received: from server.lan ([168.138.199.194])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-877aa0026b2sm991805b3a.44.2026.09.19.05.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 05:53:11 -0700 (PDT)
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
Subject: [PATCH net-next v8 11/11] MAINTAINERS: add entry for Rockchip XPCS driver
Date: Sat, 19 Sep 2026 20:51:18 +0800
Message-ID: <20260919125119.2107089-12-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260919125119.2107089-1-coiaprant@gmail.com>
References: <20260919125119.2107089-1-coiaprant@gmail.com>
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
index 3b2eb2a7a89a8..f53a519da6298 100644
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

