Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C34D4D9552
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 18:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790360714; cv=none; b=LH5XQ7EqKTKSEyzsJS3JkRIFDI7R07+nuUMjBuVhQWsyXb9rMtpIUVSf1CppU1++xxDBWk/8wGikYMFkXOzZoh9JL4GP3HaTIfcEj8nbT6Ew4p+TltaVsyV+8FDy8MgQJShs+DV1mPcV8O95RGHgKNXXw2j38TOHm6RKUABeoEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790360714; c=relaxed/simple;
	bh=GkosBV7eR2cJr014Lh9fIn7r1IkJ3NflQjoKUGN78wY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=txNyY5ziDcD7B5yIw+OTGrcqM4S3RWieBm80pm5BkpD0Rrtb+Gf0bIpKla2bOs1uxRYAOYjfYKn8Ev1NDXr7DkJKRjcC10yzuaEaaJa+DllCQQBng8UHAf/Un8/qWNW2K9E3RT/q+LI8C8qkiYCd50VLQ9z2dOYrn5fvscYyBKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L9PAPQLe; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9PAPQLe"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ff23af865so8376585e9.2
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 11:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790360709; x=1790965509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iwRhMt+5vac5hO6j1jom6ApG+G2j4KoZScdlfZjmEqs=;
        b=L9PAPQLevW9kDC1OlkRnwPTKb8Zkz2t4Pk0Cx0wZLLp9xLZ5gzBVZXychj49PdZZ6p
         KueeK4LN/LQqRy99Zz8427MkYPw5u+n4pdedIxbf9SYDY8tfaTxK/p6GTlyBpti5gAqG
         zC73qnYnaxh/y1sO4FEcZy8KON5JbJYeCGyYpErxOu6p4l4QdVRstoscsKCIsxUu+k6g
         SEe/BdbNv3QC8zkcEIjipRZduyUJlEuaTem8JMe2Cyzm8Se73lY57xBbVqO9nIH2b+3b
         dLZ0MHZYPzFeUG2cCNbIrJSvPr7vVqSFjmAQHMf6uzqIr1lBxc49uOcobRjVYXQIao9D
         TFOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790360709; x=1790965509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=iwRhMt+5vac5hO6j1jom6ApG+G2j4KoZScdlfZjmEqs=;
        b=enk54w/M20eTIiAi4KBGEYMid5PQuaX/krt0FKfYYeXvnSRN3AB3nt+MfJxrvLxqhv
         cS9MoB5NR9UbsWTCBikQly9A0LK1Fp3OPQxWcEWkT94As5EmRcY6dVXzp3ILavsXg0Q6
         y+1ghs3DB03Que2x8RcTahSuyUL3+4AF3/5NXcIk/JhhJatRXBoEE9IfpMhQVOXLRFU2
         d6nM0QIw9rV4ge658WL3kwAcphnbsEM8+ug+0MueI9Z4lHpbIYtDwPmUFjbXoGLIZyX0
         8b5R0qg7J0Lezt8Yj6NBnREmdDL5vIUDUYHLVvOLCsnPs0eOKu5CzYs/QcvAtN+1VF+M
         81Mg==
X-Forwarded-Encrypted: i=1; AKwUvBxNtyDL8d5qy7ccCL5pqFKiruUcDrQ+55RLQC/kDVHh47gxbwNYtXO/P98whxwrDHu4X7HXGLs=@vger.kernel.org
X-Gm-Message-State: AFuF++mWAkN5uT2iGUUYUf0PvlLP+UdRjMWz7XGRcYYbMmbAmjlZSZ8h
	8pg/444eHy+x3eoUC4+Hm5ArGLNg3gNwu9pcJTwGQe1XrqLCu33O37IS
X-Gm-Gg: AYBFou1+MZTbSj1YnhSvQo4EGSh22GDPz2SqHev2dsZH+OA6/AAy/7/QUmCGW5cgw8x
	1Bj7+sfROmqip7AlL3gd95dnt9LWbp8QsxYkTkr+17sWIFXcSM/FDxYaMKMUrm66qK2lTlUVo++
	Ti84yB+yOdc8CA/weSU02ox6ZdWoMNxS6juDP9PlJZaGwPCQlEHXqeKHW5vbrCwSzuxuSSFnjPW
	4xBj+sREw+MHbVEC4vtUyD1ugnIe98iFwLkAwnmFZL6rm+9ouuwmeUUIilzhh1Te+DxDVQnGFbu
	YWrnI9TepqLBKg2DDCSuQG8luTXm9kY5wPYLvBjpGn5IUHRHy07lP65BmofK31mZHx7wOsgkmdw
	KItaca94BMWNQNzah8ePBLbn3sZJwSeO6CbiwLi8pm/37l0nPlqUl578sqa6flCY/GThyFNcTLE
	tWBq1dqJWirjrBVraArGOSOywLxDbPme42XT1PBuK3evazXRDdusqqHlieyyhtqMt4tmenHP/ql
	iPZLINxi7TDo0YHIxrZDIQjVtondKqfvhfCTTfwp6Hhxf83J8oTO5fBcqCTezop
X-Received: by 2002:a05:600c:4704:b0:49c:fc6e:a3d8 with SMTP id 5b1f17b1804b1-49fe66ee908mr111606035e9.23.1790360709128;
        Fri, 25 Sep 2026 11:25:09 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-79-29-83-136.business.telecomitalia.it. [79.29.83.136])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-49fe5dfa6a7sm266231245e9.12.2026.09.25.11.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 11:25:08 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
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
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	mfd@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v23 7/9] MAINTAINERS: add myself as maintainer for Airoha AN8855 Switch
Date: Fri, 25 Sep 2026 20:24:29 +0200
Message-ID: <20260925182435.21207-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260925182435.21207-1-ansuelsmth@gmail.com>
References: <20260925182435.21207-1-ansuelsmth@gmail.com>
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
---
 MAINTAINERS | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6de1ff058db6..f6749933aa0b 100644
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
+F:	drivers/net/dsa/an8855.c
+F:	drivers/net/dsa/an8855.h
+F:	drivers/net/phy/air_an8855.c
+F:	drivers/nvmem/an8855-efuse.c
+
 AIROHA PCIE PHY DRIVER
 M:	Lorenzo Bianconi <lorenzo@kernel.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
2.55.0

