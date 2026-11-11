Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794408273;
	b=t8lFHvnCmAHe6WeEeKTkhVmsIVIcdZHpFrAS1P/KAFiKfMqMiJB3tJvZsDaQRs/hSuBw
	 /gOofL3IfNtgEiMGPCicWmnk28/ZPAxXnWXxca2NZrie/GvWni5SYAssi0o2TxWGfCXvM
	 2r5NQyWtgXBTiGLVbiU4MZaQuSmaHxzUG/FL7bfkQQXz/8JxxZXuNzTjJhGmxoj7Eom0U
	 bBAqXbs8Ub7XfuRXgKxdZIz8j48F4qusHRYR0ijhhMtGAafxwlL4cutKGRGcJuG9jwJKD
	 qBZ6xrwToYMMBjZG0DDAvl+v6BkaaNk0Aqgdy4ZFL1vmw92VnF/tuwlX8fqoAKkZc6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794408273;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=PxiG0vYjBvAPwvPa+T1dR5DMoDYMoXM5SR2pagqHWyA=;
	b=qNoEuFQiaxiLt2XpzwgMEQuU8ND0kqJfvO5lgNti7nxFc++mOV9YiegeeRl2z891u2rf
	 BN7jEa1Jq3Fml306KO8zfWgAs6IXf5ysyWAL/i/HLpEPiWKV60b1jVoV/Rk6mlvPIgbd0
	 W77nYlArLxX00eV2Nt8e9xhill5dTFtXeyTmMbvQWv4zPf0lV7A6vNg0PsxNQFyNJ1S7i
	 cIJQOr+k5ZcpXRlpW2EABNnI5us/djJmkML1a9oQ5vVNFvdupX+giiF8LIyd5kwcaCl+K
	 aT7dSm4MJYAlbl2O2f3/WJN8EEonuekV7mNb5tA2VU0bWEQC1zv4boFiM+kxSPyI0fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B1yyVtKW;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1E6606A88A
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 14:44:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB1E6606A88A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B1yyVtKW
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so34227135e9.2
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 06:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794408271; x=1795013071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PxiG0vYjBvAPwvPa+T1dR5DMoDYMoXM5SR2pagqHWyA=;
        b=B1yyVtKWJ5NV0CiF7ka9DSnfzre11MMuYuCtwZYQBcDWhpEP6f6UJ5spZq4Uy7MbM/
         oNtKHy0AyOdn9Ls8Oiu0sAIPTNYdKg5PRn5ldTW8M7Pn2bVwSvJ7uZgA5CeMerwaG08B
         gIJPqaXCCHRQ4Ld4niiB3+hypf2g6fzwMo4zbaJ2i/BGvbq/kxG98hQKQFoHv/+jwyxK
         kVslqCzOunlj5KMoI/v2QP4pkzWnGAmdgCO1yCtkITGNyNXn+gd/m+kfI3ddpBTid+JH
         JJ6+tI7PG3+CbNT+tqrv0Bk0m018299UuszXB99OJhoaTCSk6FHRS9Kd1F7jycJEafcA
         nJyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794408271; x=1795013071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PxiG0vYjBvAPwvPa+T1dR5DMoDYMoXM5SR2pagqHWyA=;
        b=JFooUGPMkm86BgNq5Lfgm397/gW576Ag1MabAaZBAhu/JdSkB6PLZwFJs0ynYDBlY1
         aLwVCHgf5LNBtnLVeuQ0thqCnKq/m/Si7mc2aDa9zdliw8fWJVdmgiAZq74WLUyWlJo3
         8oj9msUaoIZcdXdvsm7urXmSzxXZm7U6YnO/6uHjV8H53K9XhGUPlGNTY/1aE5YSrN77
         Mha2DbcbGB5auxPVUtwHYQ5USAatvfkXGUsjYUNZWC7la+lWe/fjGN4QchYmfCx6RbST
         2Dph2AP+e4UEjch5bter+D+dNcVUK+q/3vWyxgr6evVuBL3dDZF7F0IEi5HYKoLGuphL
         PN8w==
X-Forwarded-Encrypted: i=1; AL+hErFKnSANgQWewNFqa5nZumZifRrVUwmlAC1yY22eRu5dCyD5ebzwvI4zHB0/tIKPNLDkf2nkQec=@vger.kernel.org
X-Gm-Message-State: APuU4Z9hI2MKPIjLLn7HpykJBLxD7CA3XIJZtRTPgn1uksdXpgXESywP
	3G3npn7JxQlYCk0qeajnFFQVVj8Q77wv7+w/OxkgzvnA7EGRHMNxdHUO
X-Gm-Gg: AYBFou2+KqYNfOo3n72kZqqDcx0uVCdmky442u0p5L4Ud4kLIDNnJ+CG3Q/CzPDN9Mi
	FtSvZKGM5Y3eBh4XSNyRoFMpel8m1HfxfGDAqaMWnUPpi/uoWew+a2XIa1QDxQlIt1xn+c7Zwp5
	MOSqguViDpy+f26+POoLnGckARnUztEcOOxGjiuQ8aANVE2jkuKw+b1XYwH2bDry9IIz4rBMQsi
	EbZ/G8UGgAsl4KYMpbuxKZLJc9X+1opufAiANt3xhriMXWjBFsG3EzwwBIiaTPTOEPdn35rk+EX
	isPtZ8SioXdBgi8Xab/LGRUmMwtmeE9Z72JFRLzY2E797/T1OlbeFUWp78dI0TfciBVVLB86ydd
	OZJo/wYZB09xiH+OU8ObljzKWC03251O3Dbw85IpnMBy++pscBbPGmcbpMY0jyuh2D2Ll5eJfT6
	OqJkEg4BdILdC5J42veWHx4S4/1JXosVTW0Y1FZRq20kaEnxZ9R17Wm54PzzBUtBK/4Rr94TXHZ
	teHDpCvVcsmA4+awurk2LZWmTkzFN+4P+H4yr5E/Gy38igYirpfh0jiRc0trWSedGBDN1DZMBU7
	ADRqmLEa+hx/9OGAkmbsIG26n2j8AZGY2nQ5VqZjtz8XmeJ9IUIw2fVk
X-Received: by 2002:a05:600c:4e0e:b0:4a6:eca1:7d5c with SMTP id 5b1f17b1804b1-4ba093ac8f6mr46752285e9.32.1794408271122;
        Wed, 11 Nov 2026 06:44:31 -0800 (PST)
Received: from dev.Default ([86.127.229.203])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba08de826asm46656495e9.0.2026.11.11.06.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 06:44:30 -0800 (PST)
From: Agustin Santiago Isasmendi <isasmendi.agus@gmail.com>
To: Navid Ghahremani <ghahramani.navid@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Junyang Han <han.junyang@zte.com.cn>,
	=?UTF-8?q?Stefan=20D=C3=B6singer?= <stefandoesinger@gmail.com>,
	Felix Fietkau <nbd@nbd.name>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next 1/5] dt-bindings: net: zte,zx279128s-gmac: add the WLAN DMA interrupt
Date: Wed, 11 Nov 2026 15:44:22 +0100
Message-Id: <20261111144426.1321237-2-isasmendi.agus@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20261111144426.1321237-1-isasmendi.agus@gmail.com>
References: <20261111144426.1321237-1-isasmendi.agus@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Besides the traffic manager's interrupt the switch has a second DMA
engine with its own interrupt line, the ring pair the vendor firmware
uses to exchange frames of offloaded flows with the WLAN drivers.
Describe it as an optional second interrupt, named "wlan".

Assisted-by: LLM
Signed-off-by: Agustin Santiago Isasmendi <isasmendi.agus@gmail.com>
---
 .../bindings/net/zte,zx279128s-gmac.yaml      | 20 +++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/zte,zx279128s-gmac.yaml b/Documentation/devicetree/bindings/net/zte,zx279128s-gmac.yaml
index fcbdbafa766d..b9a419e5d44a 100644
--- a/Documentation/devicetree/bindings/net/zte,zx279128s-gmac.yaml
+++ b/Documentation/devicetree/bindings/net/zte,zx279128s-gmac.yaml
@@ -23,9 +23,19 @@ properties:
     maxItems: 1
 
   interrupts:
-    maxItems: 1
-    description: The traffic manager's interrupt, which signals frames
-      received for the CPU.
+    minItems: 1
+    items:
+      - description: The traffic manager's interrupt, which signals frames
+          received for the CPU.
+      - description: The WLAN DMA ring's interrupt, through which the
+          switch exchanges frames of offloaded flows with the WLAN
+          interfaces.
+
+  interrupt-names:
+    minItems: 1
+    items:
+      - const: tm
+      - const: wlan
 
   ethernet-ports:
     type: object
@@ -98,7 +108,9 @@ examples:
     ethernet@92000000 {
         compatible = "zte,zx279128s-gmac";
         reg = <0x92000000 0x400000>;
-        interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
+        interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "tm", "wlan";
 
         ethernet-ports {
             #address-cells = <1>;
-- 
2.30.2

