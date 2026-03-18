Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899F03290B0
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 21:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773870909; cv=none; b=EjZEiqo6/ngZp1mK+poQqVLj/jKUD+04eEcJQlM/Iy7XPaY8TCzVFtPrUoQt2IUfMJxTMG9LlVa2WEUwwjYKlOAa9CVvKcgD+nvYdoYH5M978dxt7jEkXzk563ds7+A85MC9/HU5z43g+ZgoJyMh8VToRdS0D7nP/p2eCQGgM+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773870909; c=relaxed/simple;
	bh=i6Ts41fXLRb5swardCZUkTCJ3f2AD6uWbw7o0btGsW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H5pDscNcOLzowh7gISqM6TVx7msnV/gWBbo53Xp9I9HjD/v8YqeggfFAV/SzxjXLytPk98pZ24HcucJ1WDVJXt+SnlP1ORUd8GD0SFhJ9Rp5sYi76xL+fC4DWJHARdirpNLcLlOrZAqlIZAKOXUCvxZn3Up/AHYzfDAzWvKfmUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DEzqdAxm; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DEzqdAxm"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso2718575e9.3
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 14:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773870907; x=1774475707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=98rPC4PTu7tCmBtkzzBMDz6PWd5qa76zGSirl2GTGes=;
        b=DEzqdAxmEzLCiO+dWyub4Qerk7W0Xu5w3M5e0eIUv404OA1Kik/+5DBfkAWjqT45bl
         L6jnEj6SrK0azl0yjZaJu8DCQEJfqZsPzwOc+9tMnXoVpceWCGkzyUPKMFXjzrP/WsDK
         LN9Fk/3k15pgip2QIKv+JGLh3g1BQ5Xz4t9I7J1T9EC+wIGK3CeG8swvACh5YStJ8NkA
         imGMVVJA9sNSZJelFpSmrqEthoO9lMeOANTHTyBKJCCzG8qmZuhBGXe3gJQoCskHN/XY
         h85yIRdII5xF+aMc+efpBQwLClh01o1qx/iHQaRVBB/lurpqwSM3ume1G43yCeHpQpsQ
         V4Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773870907; x=1774475707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=98rPC4PTu7tCmBtkzzBMDz6PWd5qa76zGSirl2GTGes=;
        b=JjLFRSrTP01NvmyOdqEuUwRl1FmbSmQ3LwJ9NkiJzGpidf0u0PhAZsIxIlt5RQQD1P
         YJENQmMFPo8UMfVRLW8TFUJGPqY+ZNfbDvlorRjob5bAXxA1wtHyp6qeyTcDlZRHNwAr
         lS1t6GzAdXOGsEnR1JA9RTOfFgxBlZJFhqtF10exD9u292A3t9c1ts9qsj5fqSjdYsuO
         inXXhrhizw+LeYxYB3CNCmc6ihwRbdjznZI4koyjqrn1ler3b6bD0Mgn7+nwg41UKfC8
         m846QYNsXScDmBYjkkAvPr9ehIKc47vsknv3cCnFMi304mBgpEWhtn70BSa9TK/O3UzT
         LJdg==
X-Gm-Message-State: AOJu0YyYbB0Z+nUYiKMZ8ia9uxMwMab+LGiaISbMXa1EvnbP2ZCod67L
	066SY8OrhucAvrI0bsKE6L44jSNwu82Yx/b8P3KYLnxGrnR44tOvNL3h
X-Gm-Gg: ATEYQzxP/ECFjo4hy3zNnH8jVIMHkipPzeOwPfJQJmHHRq0FD6W53zhemsr98H+iHox
	drfFZ2ueFmX91WVovYtDztDrkvntfa06OQ5dzFZks1mm9qi9PcQ7FdNAKk9zSph7FEUrGM0yq7x
	+uWO4gGLhbslKWKG2svxMCqzfNLQ1ezFRM5oCRRFC0MzGnneKd8/ThBmIfjYYUE1BkbNCplyaxG
	yxMumQ6Qn6P6MiFxjKrMgnNhtc9sqpYsEhHszPC7zQbWInC6uAiAxe+yFvUbp1IwiiueGIW9U06
	X0UyhesoXIvVFRrd5IfFkt1A51Zig0PyE15/O+que1OiqXsDHsggMZUJUhblCIDjYXU/MtvRrt1
	bZb3WhzsWjH0elGgfyOHLc+Xy1oFibWnbjkAWKRKp4nNfKuNLXedj9dqDJ8dQHq5UMxOVK6/Nn9
	ewrmrX2sN2M86ri6veWVlC2Ymd0+uOPoffPw==
X-Received: by 2002:a05:600c:1d0b:b0:485:45fb:3472 with SMTP id 5b1f17b1804b1-486f441bacdmr85477855e9.7.1773870906587;
        Wed, 18 Mar 2026 14:55:06 -0700 (PDT)
Received: from nas.local ([2001:912:1ac0:1e10:c662:37ff:fe09:94df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f8c292e2sm19373735e9.2.2026.03.18.14.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 14:55:06 -0700 (PDT)
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
Subject: [PATCH net-next v9 1/4] dt-bindings: net: ethernet-phy: add property enet-phy-pair-order
Date: Wed, 18 Mar 2026 22:54:58 +0100
Message-ID: <20260318215502.106528-2-dam.dejean@gmail.com>
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

Add property enet-phy-pair-order to the device tree bindings to define
the pair order of the PHY. To simplify PCB design some manufacturers
allow to wire the pairs in a reverse order, and change the order in
software.

The property can be set to 0 to force the normal pair order (ABCD), or 1
to force the reverse pair order (DCBA).

Signed-off-by: Damien Dejean <dam.dejean@gmail.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/net/ethernet-phy.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
index 58634fee9fc4..4a27547f7d7a 100644
--- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
@@ -126,6 +126,12 @@ properties:
       e.g. wrong bootstrap configuration caused by issues in PCB
       layout design.
 
+  enet-phy-pair-order:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1]
+    description:
+      For normal (0) or reverse (1) order of the pairs (ABCD -> DCBA).
+
   eee-broken-100tx:
     $ref: /schemas/types.yaml#/definitions/flag
     description:
-- 
2.47.3

