Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793723840;
	b=zjMC5ikFMqxQs9mWEyySojaiu5OkN1mnhQ0yT6nc65m4M+Ng49OBFc/RbEcxht3t4RA0
	 mb2TKEXpROd2B5IL8j7ADgshlRZw2tid+LW0gnZ0TWfpIUA1x7f4sW0yBnp9n5RHEcN9+
	 i7r7zH6IGZx/5kuHboei+pJOBJw0iJsWpa9Gvbl6iY/IfRA7p7b42BhsT2+KZpAksBuDs
	 KYAjbZwB1En7ecFLJmaYoCmX3QcY/1W4Lx1FSKE3oo1IVFbnmz1IhPxNPDtVawPnUrPK7
	 TnNgPQBNzlG4SaqdO2fedbCgnh8i+YhPQ2ZJzxepKrUaeFzLRLVxagHbFZaNPOI7K8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793723840;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xaLsM5U5ulazZmmMZOUrbsqFBf8E5Hd+TLCd3a7zUQs=;
	b=Hu73sJ4iGHvdDmGK237zOrpGcSQdaEww7np44FgwfV61iMJKSwOVOHHqpwG+kSTbSHWm
	 m/7YeC0aw50S8UaFii/X1xB+/3b0zyzo+r+QlEKogGEJfTNAp2c9KZWpU35SWRDY3VUOP
	 JZeWKjCT074CqpKEacCI6RLONF3bQ5LVmYlg9aiGLxJAMwILVGGiMaKEvUcFtuAkbi9S/
	 t1BJ3iIEdhiNrzE7+QGrkQOtNuoO56hjvoGXpum4qu74bYqnXiKCIJsgZKKjfxJC5rxaV
	 RXNqJZr2nUf/nw6VMMXfRszNsa9q2DGQhJ4uZukq+h/w9UYTN4EBeC4StOgxwAKWH+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D74606A332
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 16:37:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28D74606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48e0d1da913so759903f8f.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 08:37:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793723838; x=1794328638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xaLsM5U5ulazZmmMZOUrbsqFBf8E5Hd+TLCd3a7zUQs=;
        b=lljq6mfn6Z2PI3mLfiax7iDzq93/85UZv+aJfVasxAONIIvFuc6CQ9Vt/w0ckYwwAF
         kAdF6q+QNXTShORB+okDbLzEYcq7YMo2udqytwQKrBEFyMopZmtovBWyDRSbSPPMdOOC
         Ui+jEEwPQl6F5emDRPsWnlA5HsUX8/6PPpNFeQXeJHBVkO1md5ARm6IhuWR2JoeEkHhu
         CM7ezokMz3BN98xRWUt5HcGdq4WoOxGV98GVPL+MikmaZPte1NdvkIv8l4PecmunJCed
         Nyox8cptqkDsmY4QRMSggtKXkMoI67fQR3jAY9dpfzHAkDXCZiNhEPSe7i/k4zh4u4Lh
         KPoQ==
X-Gm-Message-State: APuU4Z+uNFUlVqHNzJD4Xz5COrSxJcGDld/PBLyye4bWxjfGmPJndIr2
	z/xtRSD7Mx2UjyeZQkgpaciAL0FZyyp9p58gLTyUjUCFv5tecPCiqj8U
X-Gm-Gg: AYBFou2Bjct7XdSyI5QNfXa/ZxMhvKCl5IyrbMHjaNSLUMELQADhzMadhAaQVpTTHlZ
	kTGAq6fgf5arSF6p+NqfkKHvJgVERS68pGTZTYd0h4tWxWUS8bOYOQ7gjSEMw5dsmFMtHrs6bLx
	6kftuB2UiCpCy7HoObCRYdReSltKsM82EFWCaiIEvN+0lOjTo6ISXpusNt56ZnBU4m2nahys/X9
	P0ow4XLVU5dsNtVcjQo+xL+fBmFMR7TxJFhC6aWgk2pK6k5PIGyHmpa1VdMObbr/yXIJSRHF5pu
	cYoLMDx2/hMjO0i0LFhrDmeb+YPH3U0AMfXqF4pq/UiviXJR5bX+z3m8u8ksm53nRzl877gYwfb
	+NLKeYgfseFJVxkhYnONyNeIyB1KLzF2hGi9RM42CEq32tdvpqRVnvkHTDgjVh0k3T+iuZMHgxi
	sj0hNtoA3djmFMjWQqyq+UwnfFj9uICtmUystomfzyisv7+E8ktTNfeS2qCyelfsNWgq34cXogB
	OWGemmu0KR6k6R64mj9z34F8UzuGL1R1dvrfg+YjO7N+oq4zZJI36ANcmoGqTbzvv6UkFu+zY1Z
	MtIdUqAdK8l4WpZz9S0B9AuWQpq8m5gN0ynVivICLhpfGlhA5pv4kmOW998EUvS/HA845fSRHvB
	cflBnp9oRPR96ry55rCKHvqZ+a3WB1G0SS/Mu74ZunVGiFNw=
X-Received: by 2002:a5d:59c3:0:b0:48e:76ab:78f3 with SMTP id ffacd0b85a97d-48e76ab7f04mr25543431f8f.15.1793723838237;
        Tue, 03 Nov 2026 08:37:18 -0800 (PST)
Received: from threads.localdomain ([90.254.187.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71a4d3e9sm29044772f8f.6.2026.11.03.08.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 08:37:17 -0800 (PST)
From: Lucas Tanure <tanure@linux.com>
To: xianwei.zhao@amlogic.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v5 1/7] dt-bindings: net: amlogic,meson-dwmac: list the compatible combinations
Date: Tue,  3 Nov 2026 16:37:09 +0000
Message-ID: <20261103163715.385394-2-tanure@linux.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103163715.385394-1-tanure@linux.com>
References: <20261103163715.385394-1-tanure@linux.com>
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

The compatible property only checks that the first entry is an Amlogic
name and that "snps,dwmac" or "snps,dwmac-3.70a" appears somewhere in
the list. It cannot express which fallbacks each SoC takes, so a SoC
built on a different Synopsys core cannot be added without loosening
the check for every other one.

List the combinations the device trees use: Meson6 falls back to
"snps,dwmac" alone, the others also name the 3.70a core. The Meson8m2
reports a 3.70a core too, so it joins that list; its dtsi gets the
missing entry in a separate patch. The example used a two-entry form no
device tree has, so give it the Meson GXBB combination.

Assisted-by: LLM
Suggested-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Lucas Tanure <tanure@linux.com>
---
 .../bindings/net/amlogic,meson-dwmac.yaml     | 29 +++++++++----------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml b/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
index 9c9cc3ef384d..e769c9bb70d8 100644
--- a/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
@@ -129,20 +129,19 @@ allOf:
 
 properties:
   compatible:
-    additionalItems: true
-    maxItems: 3
-    items:
-      - enum:
-          - amlogic,meson6-dwmac
-          - amlogic,meson8b-dwmac
-          - amlogic,meson8m2-dwmac
-          - amlogic,meson-gxbb-dwmac
-          - amlogic,meson-axg-dwmac
-          - amlogic,meson-g12a-dwmac
-    contains:
-      enum:
-        - snps,dwmac-3.70a
-        - snps,dwmac
+    oneOf:
+      - items:
+          - enum:
+              - amlogic,meson8b-dwmac
+              - amlogic,meson8m2-dwmac
+              - amlogic,meson-gxbb-dwmac
+              - amlogic,meson-axg-dwmac
+              - amlogic,meson-g12a-dwmac
+          - const: snps,dwmac-3.70a
+          - const: snps,dwmac
+      - items:
+          - const: amlogic,meson6-dwmac
+          - const: snps,dwmac
 
   reg:
     items:
@@ -175,7 +174,7 @@ unevaluatedProperties: false
 examples:
   - |
     ethmac: ethernet@c9410000 {
-        compatible = "amlogic,meson-gxbb-dwmac", "snps,dwmac";
+        compatible = "amlogic,meson-gxbb-dwmac", "snps,dwmac-3.70a", "snps,dwmac";
         reg = <0xc9410000 0x10000>, <0xc8834540 0x8>;
         interrupts = <8>;
         interrupt-names = "macirq";
-- 
2.56.0

