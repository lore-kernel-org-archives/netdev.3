Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB63480973
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 09:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783329324; cv=none; b=rUZH1smhOmkU6+efN+zLh4OlQ8rpKTTvObEe6im+qtehwS9cdjqzAW0CbfMqdjf/AzUE1FfJxFe1iF9AHCWCOOMFgA2LvVtztGkwKezFNy0SF7a8DaxdFkks2Uvh1m7SBgefdhlmSvBByDftMZ/3Sh2WSDH9rk+RBbPpx1anKxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783329324; c=relaxed/simple;
	bh=hEAydHqntdYMnlyAwKWZtU7FCzzrJfeB5kFdTHg3eh8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TGQgwRgff56d37jx1looUrJ0WDlU/o/7kAqvPeRlEE3qgtebb2Pe51O1M9b2GsNTo/1Sy0bFa7J4fDLwiL8eG/7yHfVfTAk7VlW7nka9gB80iTQYmISnBIWJGqg1SdwWMN0aXFxYl7ZaFQfbfNTFPLeS9AlN6vKM8XmRH1E6yJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BLEZVj02; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLEZVj02"
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-845ea8924a2so2719801b3a.1
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 02:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783329312; x=1783934112; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nE3XF9TJ3rEGOneChwFEqNNIrveo5+lTJId+Q3nPPQA=;
        b=BLEZVj02ZRCqGe/AbM1U4MauPHB5eOpzOCkqBH7zlN6GfE285mzk2Tz98TaZtBFqQI
         ppmMjTEXNUqLFogFst5HOckNAjkqhtWcJT23FKxsI+VcsyMWEg/VQFDBXmh2TzzwZQ8+
         u4NGq/jfNai9ItWWacae0DxWQ/oUSpgG+dPgX+6iBy/vFY3QcoX3afy9HmfO9x186iqr
         JyBanDjlsu4JZfdJ2gGli3XI+GwnXWVtpRhM13vZueO3dqS1kz5vF5WpnmUDzqjWRGJT
         iMIufTImeiD4VYJGeqTMGslG6IzrbkykRqL0eEMLAKqpFLucvoeBow6bwJxsMl0OZAjk
         NwfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783329312; x=1783934112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nE3XF9TJ3rEGOneChwFEqNNIrveo5+lTJId+Q3nPPQA=;
        b=dIta467Rihx+fMpj+YTjC/oHgr2qNIge9VU/cM/PxWnbm9aKNW11iqzDqwrJFlWGAi
         mmRmTD2zN4uNhhuei0JGIndKn9AIEP9t2KOEjamzzzMpPSPLHhdYjfNPrBulT1G/bd7K
         Mz230khZ5S0GkPKwIpX8Bm+oH6kftKw56YSs8SC2USjIkt0r3VlYZWoYL6gRqCKhzZZv
         6vqRGUdECPySGnW6Qc9by2cA5kQzB1OM0y5B9POYD9NXoNjyruOgPPfYeMDTZWq4eX2s
         kDiCpcqDT8JJgUzSTFwRrtMfUmDPiLw/WtxYrN9gqDV9rt38p69krfxddbqJNE9P2Nrf
         baEg==
X-Forwarded-Encrypted: i=1; AHgh+RrGNYKBLMAt4I3/NyqMmeYT0g44qK0lSADxEh4zdv3WNN+lW+Rxwp5KqVliMWhIFF3iLuxrdHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfJuLx06K0oZMLHcgD/Etsema8mKN3wNUFpOUEqG9+x+b4B1yL
	+0HCZgEczHA4o+PHFCFhlkgabhQOlKz2nLDlqllDrDq2FMKznZmMyN8V
X-Gm-Gg: AfdE7cndetcndHha8IFfWU8kYjJIHHn00vgO1p3q8/nvpEcZ1JyBN1DJGud3IdDWceu
	Gataf0MQVtic7O7Z3W5cJe37tszyalW+FLVYcYkmFjrnPEzXYRlENtFyMlJ9aAKTBygnQIiXwCh
	YQcRsViBo3CqbZgfb7X0OuDrcxSk4NmB4g9NqenMiMiivXf3kSrzKmsBuFXI56Me1KszBAj1zY7
	ZMEHVU9YnaHHUUojJ8Ik2q0HjGZMsPtp80M1G1qWyWg8pgYc+0iXUAyoPZddzfke1r3bg1tUS9T
	RtC/xrQ88UzpNvnmhiyT4IjTzzxEj8Mh0iYQuoVz4RuBMJmKb2KyVOuRIjV7MkM6C8UE+veLeOq
	XJoPAfAKMzifMXdAEEXJd47eYLrOn1b8iTGThwdICrzv3MSJOH5pzUKZblsoaeysDc4qOgRp/Sq
	+6RnA70LqK7RxEwTDIUO3Nc1PV
X-Received: by 2002:a05:6a00:744c:b0:848:19f4:3b52 with SMTP id d2e1a72fcca58-84819f45421mr1984897b3a.38.1783329312352;
        Mon, 06 Jul 2026 02:15:12 -0700 (PDT)
Received: from [192.168.1.101] ([218.194.36.79])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6db29d1sm3445963b3a.53.2026.07.06.02.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 02:15:11 -0700 (PDT)
From: Yanan He <grumpycat921013@gmail.com>
Date: Mon, 06 Jul 2026 17:14:42 +0800
Subject: [PATCH v2 2/5] dt-bindings: arm: rockchip: Add Alientek DLRV1126
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-rv1126-alientek-dlrv1126-v2-2-ff3176ca362b@gmail.com>
References: <20260706-rv1126-alientek-dlrv1126-v2-0-ff3176ca362b@gmail.com>
In-Reply-To: <20260706-rv1126-alientek-dlrv1126-v2-0-ff3176ca362b@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 David Wu <david.wu@rock-chips.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Frank <Frank.Sae@motor-comm.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 Yanan He <grumpycat921013@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783329286; l=1084;
 i=grumpycat921013@gmail.com; s=20260618; h=from:subject:message-id;
 bh=hEAydHqntdYMnlyAwKWZtU7FCzzrJfeB5kFdTHg3eh8=;
 b=oUIvb0p8xJrOQfktVGkGTJAbXV6vKYwxR7zox/cjJFvRifrU/XZQte3H1tZqxq8jemi+Qu5h5
 kI0XpBCrB7QBLc9+7DAvO63iyOniB4dnpGDfjDqMs9cydUzegylaX06
X-Developer-Key: i=grumpycat921013@gmail.com; a=ed25519;
 pk=oWrY8KwXIunZWlYBV76NG2A3V4p1bJ+aD45Mr56ErTw=

The board consists of a DLRV1126 carrier board and a CLRV1126F core
module based on the Rockchip RV1126 SoC.

Signed-off-by: Yanan He <grumpycat921013@gmail.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 1a9dde18626d..9058f2a461d5 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -162,6 +162,13 @@ properties:
           - const: coolpi,pi-4b
           - const: rockchip,rk3588s
 
+      - description: Alientek CLRV1126F SoM based boards
+        items:
+          - enum:
+              - alientek,dlrv1126
+          - const: alientek,clrv1126f
+          - const: rockchip,rv1126
+
       - description: Edgeble Neural Compute Module 2(Neu2) SoM based boards
         items:
           - const: edgeble,neural-compute-module-2-io   # Edgeble Neural Compute Module 2 IO Board

-- 
2.54.0

