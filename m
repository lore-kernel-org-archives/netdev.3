Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380914EC66D
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 16:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791562289; cv=none; b=p2G4YSFoOV7nas3qEnFXKdSBNkaYeog2rDdeR5GMXrT4AC1ERr80memuHowIgle2oZPVKPZ6Q4pFPjD78VLx7iHY9Il7Yd+5w7nAJAsKFWSfoC6BFDi4XZeOEL1m4GNfDS5+RAfh9S1K30jRJ0YIm126mGyzmMarCChYAVflvgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791562289; c=relaxed/simple;
	bh=MVsXZuoiXp2XXStNi5GOq+gCp4+6jTB851Kpop8DdDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mjaJFEYzIkZ30GfDM4vVdd6J8C+1blo28qzkWIA2KQFyXOGiqUXWmJ8I4/hgiM/LUn+D/9r0NHtnTZ6unoYr7Dt8QrQHNOtXnMWNzJqlPhw3HKiX6QexM++/onOEntDx25VYbneT2a+bM0NC6zbxzz/rtN6caCgIQcCewNyOdd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sPheuGr9; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sPheuGr9"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a1698ea378so42935e9.2
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 09:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791562285; x=1792167085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lZx5wg1ErozEok9d3MibAXierPMpJi4B3Ch88R20ArI=;
        b=sPheuGr9nXRkX2aZRGQuF1LIayut+Sym8mxCw4BF2rK8PBpke7z6OJIxPk+jUUug31
         mlnxxt2+CPj3VNo0RX6zaAFRHK33EhMycXhQEep+N8gSxoZhK5Z99BBwbEoGIQ3ogQAp
         3mGIBz6br4eOK76BO7CW4ILpbRhMFoydwxN0s1FQRtUF8WNB0Y1gdEpZ7i4xcuHqXJjG
         kh21lFfGJvHZo9u612C6cTUZ+r11MWUOKPnIYpE6NGsl3z60NTT0LYYoaln48wKOOOGl
         WXEC0Nyb6AaLZiyjozbcS4AHFfTOd/vCZXaLWFLC88MDeVYwbanxpXdBFhW0FHDqWho2
         eIFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791562285; x=1792167085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lZx5wg1ErozEok9d3MibAXierPMpJi4B3Ch88R20ArI=;
        b=TXf1Of0uWwoigu8n1tzjuzPg5I7m1gafy412cIxbaRZI72V4k1yNPybAMPbb2vCQMi
         3Wi1wsedDiWZOxVVGijiYPmXWUUTwPisv7HlSN996TyQYijIG60XMgev6CLDsU0skALy
         VKeUnW7hEH2/KjatcgnKLBKsrIXwq9bkYfN9qCXPjtonCM2e1X30szy1/448gY1haXSV
         tZg8FqD3JrH/buqfS65PGndAOK75MLY6TGO6gcHJojMRFaxqx8eiPji/1a/+1/ICbZod
         qB40jpT5VLcKTbhWMJP8FtXPnFa/PkRet73Wb0ZQq74M5tPU3TOouU6W91zV2tijvbv+
         dT8w==
X-Forwarded-Encrypted: i=1; AKwUvBz1nrC1lI0IudCJhrb+xIPxrgWk84wzQf3v+CLyZIEyIgf9GE421fklSqwSoo3vyLIVruP832c=@vger.kernel.org
X-Gm-Message-State: AFuF++kKvbjtzO5ZAycPLE9TFGphkfSCpA6dvQ0dCkbpOUnoSwDb7C4f
	WsJCf/dyEnpBTSSMOKvUUhgFNREg/y46BubUDGJA/I9iOdLHZ3DJMcOS
X-Gm-Gg: AYBFou0SSCd1QzLsDnbq3bKoS0N6UZmZYhc0xRp8mzUf+pJnz8R6zEy8iUpoyq0zsx0
	SjkMkxkRWLrqqvMWxKh8aBqzcyd5BJBMdISrOFnCDr0klsGbqWmSKa51tvZAn/D53DS5d9Ggrw2
	riSznOvPA2aK+GMmkNjQLQs2x4UBgVaZX8fUUbEPo78ssILpe8+D4T6JKTfYIhepavLTVDMXrO4
	lTWgVKdpp0BVRJEAE77oCzTif12eu38Z9eOTuvOPIpcyWI9KNulRaHfRsjN8juLYK/3d+cn4wcz
	XzUpnXiIK/P6I/fdB7IY9IAgl3JxQfS7IA723LtdJZs9tdKW8cyUYGhGHeBWIgDwAHfBatF5BlK
	woNh4Hz2L8bmCD7W3xryhAgK9x/kaBswgS9SL6j0ibCyrZEj9Ep3oFWfFiwJoKf5SWy2CxkHOyX
	+FHNw7lqgT9RPR560wTLVlp/e7S1eyUgW7rT9Cj7on3RKd4hXrCMN5h5vW3KX0rMR6m/VASoFq0
	V8h9mykE2Xn9ND1LTEk4uD/swM8M01TK9PfdjeuZIQ33PJwCbLrSuhDwvuAvsGPa5sDow6/348i
	fmJmoUopfmkSYKT+rw==
X-Received: by 2002:a05:600c:6388:b0:4a1:6f78:8419 with SMTP id 5b1f17b1804b1-4a18e3ee8f9mr48332405e9.0.1791562285176;
        Fri, 09 Oct 2026 09:11:25 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-213-45-9-252.retail.telecomitalia.it. [213.45.9.252])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48db94e2f08sm4744701f8f.15.2026.10.09.09.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 09:11:24 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	Joris Vaisvila <joey@tinyisr.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	mfd@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH net-next v25 07/10] MAINTAINERS: add myself as maintainer for Airoha AN8855 Switch
Date: Fri,  9 Oct 2026 18:10:52 +0200
Message-ID: <20261009161102.38961-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261009161102.38961-1-ansuelsmth@gmail.com>
References: <20261009161102.38961-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add myself as maintainer for AN8855 DSA driver and all the related
subdriver (mfd, mdio, phy, nvmem)

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 MAINTAINERS | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 509b35b5a0e7..53dcff93f896 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -759,6 +759,22 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
 F:	drivers/net/ethernet/airoha/
 
+AIROHA AN8855 DSA DRIVER
+M:	Christian Marangi <ansuelsmth@gmail.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/mfd/airoha,an8855.yaml
+F:	Documentation/devicetree/bindings/net/airoha,an8855-phy.yaml
+F:	Documentation/devicetree/bindings/net/dsa/airoha,an8855-switch.yaml
+F:	Documentation/devicetree/bindings/nvmem/airoha,an8855-efuse.yaml
+F:	drivers/mfd/airoha-an8855.c
+F:	drivers/net/dsa/mediatek/an8855.c
+F:	drivers/net/dsa/mediatek/an8855.h
+F:	drivers/net/phy/air_an8855.c
+F:	drivers/nvmem/an8855-efuse.c
+
 AIROHA PCIE PHY DRIVER
 M:	Lorenzo Bianconi <lorenzo@kernel.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
2.55.0

