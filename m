Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF853148C9
	for <netdev@vger.kernel.org>; Sat, 25 Jul 2026 00:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784941099; cv=none; b=nTDp/19H7V4rYLPmx2wY11QkYFHkyKE0/hJvXwiHeyupx+y6bk8ZmZR1FWNStPBMJoAGKkbXSYoPWg8gXUgODiq3oFZntybSE3F62u6eADwDlDyxPXtiS6DgzkU/g3oV+tNbttyLA/QeDq0qiGasUm19ij30jrCifj8c4TP4f3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784941099; c=relaxed/simple;
	bh=zcEDujLPvsRN+GgGPxQ6SWQmTBHbV7jX86seTQ7X3C8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LECiH9BzniFNY+k8Wi2BN1CmqR7oQSm+o96eHvZQKYD6bZVCzbmd0oDhb7ZQ8YWj0U5KewrFCuDWCLeIHUiSYwIwEDAGNqDswYqYWI/8LYXRitHHk1oTpM2HIsR2HjIHkWI78bajUDPlo8jo7c0SvXinkNYSxmS2qqMThQvilEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MWefsTVI; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWefsTVI"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cab973140bso14751235ad.3
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 17:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784941098; x=1785545898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1gUr4fQRyHAoHpwP1gqFm6NIZTzHOUhteVVgfXrJmeE=;
        b=MWefsTVIkDkGQJg6QYMP6CqWIaaPjsLOH4JhJQ7pEx6pLNJaGVvQdKL5nAxpylE7Bk
         j5a+TuxBAgtdyHdKcNkBFEqfJLrUiXMiePk5vVC8nsIPmIvJdsJM7xYOANxsV8jvmITF
         Q5kRda3+31KHyx1kKmf8//G8h8Pps0BmRz/LIRx41yCyq2bAm/Hlx1Mr12Yb1zLpD69A
         /26BTcqVtrHBWdqRHWOG0KJauVsvdrNFvk6prKWZMavaOFQSO2qodSAiciSub8pofs+X
         bVgYdi9gEl/zwJtKI7SFGqtdEUGK3s3zwXLyaf5BGJmB0XG4KB5sKjn5tqf+SUDRBTKK
         ZWeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784941098; x=1785545898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1gUr4fQRyHAoHpwP1gqFm6NIZTzHOUhteVVgfXrJmeE=;
        b=C61kGNVVeLv0dM+r6dSQHlChAB+Qqy+LbRvF7qMQ+2ls8hygoQ/YwFb3aACUxpkQ23
         d08SuN0oMF3g4N7UnFB3ENoekdse1sFoX9jfUkoidLNxBHpU2yWkyKkhj2ZKubAO2uAb
         x5+cvk46VEHNGEHXnukX+8Tbxdt2LpXTk6BtiaBeH6mNaMLrcwII5OBR1t2KbCp66n9w
         rcStysT5yBhACHE3hZLwNZV5JoWxt+8LSTVE0W8S02g1AEap5wIHYZN98ZVT7/lYy4Zl
         BvHAUM38HnYCj7VMNjYVdGx/5h7gC6MCz/1dAFW6U1O/D4bqr+Z8+t7yyn4GKH2pfM4b
         GadA==
X-Forwarded-Encrypted: i=1; AHgh+Rof0ShZUFMVU9l/FR7UZ/dBxPLZ70WnMkwhEBXFpjunxnsHm4C8m/0RckYqbMLb0B5KdI1piAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvspSVddbzR/wlcKLr4Z2EBTRqFPN0hVF+Xy5MfeHioPIVkz31
	/YI9RD816tLa7CdY3oABWOEBwLiJ6tFptPitXkS6tgRP0xs9YCbU8TG6
X-Gm-Gg: AR+sD11RhGNgnEQHVcCdi3zqM7SBsQVFE8My/Sbv4szDU4Keu39aRoaGEv5mpI+eGSm
	wyNJHNI8dQe7kZj6VNKcPtEOsKzNLAT/MQiyYLzvnbHXGwtakBLBA1ir5nks864hofFTV2QetK9
	I3VvrQPl5tbCH86Nz7/WP3MjWI5kpZCkcFqB1KVlg70mfFTEYFuYXsZMafHaK6G9S+X+eOHgHvM
	0/y1WoU+nQY1JSXHYPWvYLXmvaYPt7IjSFTtimgRCcwoV1g8Dq7VPYM3jUu4y+oTI4MszwJftR1
	+LS9e3lFwxIjckF9JJwMzxLOxWX5GzIoP3VSNJh088WRtzEcIOAFguBVYoPgX3heknt9BJNM13q
	DvNL+oRISzswzwbdwlDoaG1otTsY22orBLfLfirXHKj8vOLyW3qRffGhm0PAO6g7Y0m+fDWL8
X-Received: by 2002:a17:902:c402:b0:2cf:a2d2:84c0 with SMTP id d9443c01a7336-2cfde55bb4amr6478145ad.0.1784941098056;
        Fri, 24 Jul 2026 17:58:18 -0700 (PDT)
Received: from localhost ([2001:da8:7001:2000::1:5491])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde59bc68sm2289265ad.2.2026.07.24.17.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 17:58:17 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Yixun Lan <dlan@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Inochi Amaoto <inochiama@gmail.com>
Cc: devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH 2/2] riscv: dts: spacemit: Fix phy id check for the phy on com260 board
Date: Sat, 25 Jul 2026 08:58:03 +0800
Message-ID: <20260725005804.373698-3-inochiama@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260725005804.373698-1-inochiama@gmail.com>
References: <20260725005804.373698-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current phy framework can not reinit the phy correctly, as it will
assert the phy reset GPIO so the phy id can not be readed. Setting
the phy id of board com260 manually so the phy id dectection can
be skipped.

Fixes: cfe5c91cb73c ("riscv: dts: spacemit: k3: Initial support for CoM260-IFX board")
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 arch/riscv/boot/dts/spacemit/k3-com260.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/spacemit/k3-com260.dtsi b/arch/riscv/boot/dts/spacemit/k3-com260.dtsi
index b704b537385c..a26b18aabec1 100644
--- a/arch/riscv/boot/dts/spacemit/k3-com260.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k3-com260.dtsi
@@ -174,7 +174,8 @@ &eth1 {
 
 	mdio {
 		phy1: phy@1 {
-			compatible = "ethernet-phy-ieee802.3-c22";
+			compatible = "ethernet-phy-id001c.c916",
+				     "ethernet-phy-ieee802.3-c22";
 			reg = <1>;
 			reset-gpios = <&gpio 1 5 GPIO_ACTIVE_LOW>;
 			reset-assert-us = <10000>;
-- 
2.55.0

