Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAFE318EE2
	for <netdev@vger.kernel.org>; Sat, 25 Jul 2026 00:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784941097; cv=none; b=M1kUoElOxZSeP/nzagIXJanmHE4K26Aymk07u2Vt9KPUFl3rsm4veN241oFKRElYqjBCreAN8HLRy/vfd5EsCn4Ztl4knmVgDQim1wHdGVUfd9VFkcLKJTg9gYmFlanAIzq6MMVgBII3VsZ0VItozpvcAcHQOlRzghhlrRS/P6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784941097; c=relaxed/simple;
	bh=qvt1xeKZaGMzjY4GmRnBlOy13neWiePcPbv4luremNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KVInq6vNtivQekr6JkpfB5AeqQg53R9Am+jMHZHEq7fWxhd00dzbY1hYlw5zPK+ecWB0yEUxyERKFYveHmmTwSOg8RSMOgNda/kmMzHhYXNgKXDEQv0K4iMtfx+eNKQkVuQteqq9ePTEXb3HY+Ut8b47zHyT9OgDxED8+JVVx0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=evbwxWue; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evbwxWue"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c9e0b89e228so755848a12.1
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 17:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784941094; x=1785545894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tJzCpl1A9lMuSv16O58Xsv9A30hSmOZtX21l624BoiU=;
        b=evbwxWueggAWYfOBVgUastnpkYx3b10tob6zyes6TGPyS1+2HWRkFou37/D92BmxzD
         4q8THs7UVigJ5pTUrwCQDMXHQ/war04EbqpHjjqUJCALHGpxfneeBPtT5fKhengzSF5h
         u/ywhw9HBLGTLmUR4/4at6s/lng3naJfC3xSbW7mAgr/OmuGhRwDDRlk7DcAQA9cV93S
         FkYgAOpas/IMhc1MvPa45lb7FzC1riOfX+eiN3U5iYy+ffgQc8jAiiQXDti8MxZZJ5sx
         +vc4szEQZuSuZS5reyEUOhLTW4BNTrbqZmHAomfbfMfH26DGafs7qdq3u/cvMtKmhyqa
         mw9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784941094; x=1785545894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tJzCpl1A9lMuSv16O58Xsv9A30hSmOZtX21l624BoiU=;
        b=BiTlOXDXE95FZRvDaXcQc270Z4T7OTNl5xGqsfYaQ94RrSQBmfIySYrlZ0JfsSprM1
         bDlIG1dJx3NluSnJQUWkx6BhYShCHrRnPywszQJZFmmWBSA3/Nnwibvx1+/zdBbyZgDh
         Zaz4kA64fnYFeeERS+A+dXOMZ5/a9HPKbTwJ3JR30uu6aOkO1vO8pRcI84mc9/T6Mity
         frqjugdQUKh4P+kUDvEIA2qsJOQrvbR5UZnnvZ+oAJ20mJ5Kx2rgG5O9u5lBKMT/yNTu
         NRPRzzhVehw4mDN0F2Ahdr1DgSb9I/bj56/QG815uztO13hxAW/+iPvbjMzle/Pbbtvm
         X0jA==
X-Forwarded-Encrypted: i=1; AHgh+RrFrfJNY8Gjd/G0dWpIeqob0Hp9a0iVR2pHftEbxn2jxONlg0voY7oOG9B6Wl0MQ5J+jmHS/Pk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlYix3G37diPfYhr0pSdo/HpMCbI5/Djz4flnYReVS0UDQxTa4
	XsvlZsmQD0/LzDLfpEoyWaTf2CfChhs6k5vgmvSXAr7BNqTxZ6F9smYY
X-Gm-Gg: AR+sD10lgtcOZruiiCntWxRh8lBfBPYe7rNmrP7peUIllzXNzZJ+2afsfrKiYpOcHYo
	C7Qt+sQ5KUj+wo27o+9zBjZr6kiyEpO3otL8kwrpEltIZdY6WWcf7EV+hXJnmoVheArAHb+f/yg
	/pZhtFW9OOdPy4PtSnmoxIBnH6aThqdktXMy0Nvsd7mlU4J47jgVP5J64TBo6eJM2+i6yDyrJkt
	WVOyBxV6ySybdN0G2PU1tnXi56EMrSOU6lsVXAD466YZfjmCWWR6WwnCIlAjh/Fb297IEv/sBj7
	0Qgtwq52/VyB0uHXwDo6KY86rXDhFCV4HvPirdyQ27+Oyg2lQRu12U+Bbjq/JF5sQn0f6frroCa
	rv2h24inzTNEfCThmHQN1XR3j0ByePEH6lV8DoIL5oE8uPu3wo+o3qDXiq7SJug==
X-Received: by 2002:a05:6a21:6196:b0:3c1:d78:6457 with SMTP id adf61e73a8af0-3c67daecd72mr595029637.32.1784941094334;
        Fri, 24 Jul 2026 17:58:14 -0700 (PDT)
Received: from localhost ([2001:da8:7001:2000::1:5491])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbbb66dc15asm654002a12.30.2026.07.24.17.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 17:58:14 -0700 (PDT)
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
	Longbin Li <looong.bin@gmail.com>,
	E Shattow <e@freeshell.de>
Subject: [PATCH 1/2] riscv: dts: spacemit: Fix phy id check for the phy on pico-itx board
Date: Sat, 25 Jul 2026 08:58:02 +0800
Message-ID: <20260725005804.373698-2-inochiama@gmail.com>
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
the phy id of board pico-itx manually so the phy id dectection can
be skipped.

Fixes: 74657a376960 ("riscv: dts: spacemit: Add ethernet device for K3")
Reported-by: E Shattow <e@freeshell.de>
Reported-by: Inochi Amaoto <inochiama@gmail.com>
Closes: https://lore.kernel.org/netdev/20260712045233.800748-1-inochiama@gmail.com
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Tested-by: E Shattow <e@freeshell.de>
---
 arch/riscv/boot/dts/spacemit/k3-pico-itx.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts b/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts
index b2a7d2d0d3a8..b9d2de878f38 100644
--- a/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts
+++ b/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts
@@ -196,7 +196,8 @@ &eth0 {
 
 	mdio {
 		phy0: phy@1 {
-			compatible = "ethernet-phy-ieee802.3-c22";
+			compatible = "ethernet-phy-id001c.c916",
+				     "ethernet-phy-ieee802.3-c22";
 			reg = <1>;
 			reset-gpios = <&gpio 0 15 GPIO_ACTIVE_LOW>;
 			reset-assert-us = <10000>;
-- 
2.55.0

