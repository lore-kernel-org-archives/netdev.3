Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EADE35DA51
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 21:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773870911; cv=none; b=lTlcgfeoXCXWlsQKePtH5UFjRQyEOqgJ9Subu5czafIecCr/xGQsp0pcEeLuY3tU3p/noaz6arrqDxqD8cd43LZ9O4QAe16vol+ZK5FeF6tUl3kNMmJczHYcOGXzCB6sBIf1dq1xbHhgVun+/biR20bakx754/ozGkSA9CDOe7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773870911; c=relaxed/simple;
	bh=NcV7Y8rF5EsCyaO+fQzMv4yYadXViOfLjUAI/+Np8mI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OIqmPMQTOre0jXc3+0ShuBKPG3xWTPTRoBxo7twHywodS+8QCg892IW1t25xn1ZI+eDf1sf8SFLq6fitR2mjq7wTl1JGPsQK4EwxHOTkSzLfNa/zPbCclz99MuupGisSU6gfY8VHst8T5brp76tlvOb8IWchNHud6x2Om6G6N/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ktX/rKGC; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktX/rKGC"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48541edecf9so3448425e9.1
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 14:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773870909; x=1774475709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IkgvDwmYQtcd0bE08ner2utHU4QPqUbSnWFPd8ItaAU=;
        b=ktX/rKGC76toMUOM9F2ZXFrFUDCCCsktdn9XfvPVmFi+yZHXtD5IGsyRwKNiaZ8TLY
         Fex+Ybn+1glIIC4xk/QLYt0vPeepxCQcIw/5AWJ5Ki9w8G3ko01vQF2MQX/np/sfFxRS
         iBhj6+6+cAURxMRO8TOsRDlz0E2hz4A86qwsYAJNi3wee9me1I/NPotqCo0tOo4ihORE
         RkRjE0usoDfQhhEoS5XhWLxhmqH8wZpSIBg5W+9eLkiyGHU6PJGKYaS4KE7f9yXRRhu/
         Wgt5PlJ4v9IUuGOHBHZ1veykKmbFoKiZ21n8Q2hk+5+iKy09ceMx4N/8LyWhf5sGXEkp
         Twog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773870909; x=1774475709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IkgvDwmYQtcd0bE08ner2utHU4QPqUbSnWFPd8ItaAU=;
        b=eXumj20HZOOuTlHi0rG3/HEIOCFkwq1kbphZl+p2d6d3wPvpOSph+tUhFNp8+b9WPb
         lR/UTDVdr5GlT5J9gOw7+0GKU8g6d0iAll5jO09k/1zXrs69pYzHzAoUbHEldJdaWpNe
         RSDS4kH4LU0sqGpcizVqD8Q2f5mdxA3as8zPpggt44GCTZ57XxOWUN+29DRAi9l2G6fk
         sOlThroaazxQ6rMhr9YK1Z7ZficQiFmEIJeWWby8VJfsXyEJ0gSY1dW0o8+T/MXpwvnS
         WlWIod9L4UnMQAwNzHO+uCJobh29xB5iaZL3fewxSTW1DhkbDKy2VA2sIX3l5wD178Wf
         S/Vw==
X-Gm-Message-State: AOJu0Yy8bWFeTNHPlm2iiynPLCqMPYo2qLWW+F18p+4BbnciGIK6+zSs
	ACYPV71qKwhHepczMBpmpAQoGX8DDYbKLSrUrdrAtbV0LBvPjGdHwmHD
X-Gm-Gg: ATEYQzwZkXzManWoFu5KytZgzYbFqZi5gZMvp8Bo9F+VUIrH09W6/wB0PophULI2Dpu
	UOHQzMexrlmfR7wN5ZT6Emq3LJ7uJrRYZ3RezBRyyL5HGTaBJwh1WmL22dHdHIOBzKSko5gEpMh
	+SxkT1EAadjQOogTRFsq2oT3RNbFcmSjWwqoab0tjdJhFjBtK66vzajRIj2YA0VzcjeKrPRqfdA
	rKIA0Yb1xWctGzQt4Jj2S0bJH0ualLLeNpEqqzcw1dHAd+6dWuvMcNMJKKP7Ho+gmZyoPEc7LMT
	edwdmr7sL762eS2Si3G+/GK037Uxnzvryhud09jfIQdv0aBKvP0ApnAP+/zT9+C2KUXreKLHLtP
	W6lxLmAzvT67HZM8RH4dSG1jcMfj6/UeOedFaP7AC9+JnQ5en1Kv8yFuVIjeUVWNLxi/dVnvuT+
	WgIHpPN9/GnwbnGs2mlKde+Jm6rZiFtnwWkA==
X-Received: by 2002:a05:600c:4fc4:b0:485:3b00:f92e with SMTP id 5b1f17b1804b1-486f441bc46mr80203095e9.2.1773870908462;
        Wed, 18 Mar 2026 14:55:08 -0700 (PDT)
Received: from nas.local ([2001:912:1ac0:1e10:c662:37ff:fe09:94df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f8c292e2sm19373735e9.2.2026.03.18.14.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 14:55:08 -0700 (PDT)
From: Damien Dejean <dam.dejean@gmail.com>
To: andrew@lunn.ch,
	krzk+dt@kernel.org,
	robh@kernel.org,
	kuba@kernel.org,
	maxime.chevallier@bootlin.com,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	hkallweit1@gmail.com,
	Damien Dejean <dam.dejean@gmail.com>
Subject: [PATCH net-next v9 3/4] dt-bindings: net: ethernet-phy: add property enet-phy-pair-polarity
Date: Wed, 18 Mar 2026 22:55:00 +0100
Message-ID: <20260318215502.106528-4-dam.dejean@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260318215502.106528-1-dam.dejean@gmail.com>
References: <20260318215502.106528-1-dam.dejean@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the property enet-phy-pair-polarity to describe the polarity of the
PHY pairs. To ease PCB designs some manufacturers allow to wire the
pairs with a reverse polarity and provide a way to configure it.

The property 'enet-phy-pair-polarity' sets the polarity of each pair.
Bit 0 to 3 configure the polarity or pairs A to D, if set to 1 the
polarity is reversed for this pair.

Signed-off-by: Damien Dejean <dam.dejean@gmail.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/net/ethernet-phy.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
index 4a27547f7d7a..21a1a63506f0 100644
--- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
@@ -132,6 +132,14 @@ properties:
     description:
       For normal (0) or reverse (1) order of the pairs (ABCD -> DCBA).
 
+  enet-phy-pair-polarity:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maximum: 0xf
+    description:
+      A bitmap to describe pair polarity swap. Bit 0 to swap polarity of pair A,
+      bit 1 to swap polarity of pair B, bit 2 to swap polarity of pair C and bit
+      3 to swap polarity of pair D.
+
   eee-broken-100tx:
     $ref: /schemas/types.yaml#/definitions/flag
     description:
-- 
2.47.3

