Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07B437BE9E
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 14:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792075136; cv=none; b=cnW48F6ycD0c8qNCev5vmBwivQZmE9ru6MVa6wM0byeyvr3I0XKKEeCDxbmKNnofPjNod2ylPTpdZ4ba2p1PdzBN40d4gUxSsGdDVmtt/WQwRBWgofPfjI6hZ6tczo7LpZ8+U9LnU9ekeFUwNZv1DtAD9jyGzfxJYwiXzAW3Hw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792075136; c=relaxed/simple;
	bh=0MHY/DXLJSGlvlK4hfQH5ps+wyuy3lgdtPpSeRBwJZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rv60Kn3ZlQp/0hcp/clu2DP0cpDg9vfyMNhHbLoyUcqpEeCEYVNp9fcbGfNd7Lw9MJuMqRZIBQd/DEpMlO6b0rCmy6JgpaZ2rj7AGECWujHVGm+gM1aHLV269iKJ/jtQsRVYF/FXRb0iw9gvyP8TJ2CwsiIcQVLGM139me3N9SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=aw0nctY2; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="aw0nctY2"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-93e56c287b3so123775285a.0
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 07:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1792075134; x=1792679934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FyxQZm/TWmVMDcMFzjg+LflT1D2OtrWSrFPMXdJ9T9Q=;
        b=aw0nctY2uWrNLLvxCvpBKlDeenQ/Dlbpc9B/OmDRgyQ2QaRF1AdrPKgn/i3vXsWxYx
         zmzyGTIvQrKrSY6AWc/MfQ7mj88tyN2L5N2tJoxGlH7zxMEmrQJfPvdB5f7G3BZ/VZWM
         cvtpeNYqsLpGFcy0uEI8prkkl1GS+Q0GsdeiS6N4KVcC2uD/58pRHMDgbzfbtLAuM2Z0
         nv0+xxgcrMKhJVRO7/IwOzugu+rdg2IVjkzs81kClKpp+tvERx3aAIRxYmBjGXkTA0Yc
         tmRFDNJLrIuwi9bhNWbr6urex9Xl1m35bvQoVeoOCiOdW7DMFyNcbTIotHqunYAfUDLx
         zl4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792075134; x=1792679934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FyxQZm/TWmVMDcMFzjg+LflT1D2OtrWSrFPMXdJ9T9Q=;
        b=00Sfe1CKMYGTCY/+so7GyF3tvMk4ndIwCAWg3AmS94Ey+uaw/lUGfg0telj2a+qdpG
         Uq920+S/8/raGppfjmH2o87oMadWQ6ItAYVyn8xqU/Yt6v6nOKNrXO8deX1Ka2Y1iD3X
         8BgeFEb7Q/3vXrKXeDJJFeD+excaC4vaj7Qj8joyXa+24KGhdxUR5+Wf7D6QaGeKcegG
         6RilwiagHyAMu557zkNMZKuRbFmuvDU8B61y4iCd6T67nsHUXoogJpv8T1w/96F6EPnY
         NzBhXYySxmWKve+qrvEZwfhCTsmqIEXiBUH3TGHTSyXtGotSbK2dhT4BeQalQfZFZlqf
         rUZw==
X-Forwarded-Encrypted: i=1; AKwUvBy6U8NFaLx9cMgrdrCHk0/UVHbZ47u3k383hcpm8UVkLlXD5zVb3MiyUOdFsXQHZJxvGYYZ+ho=@vger.kernel.org
X-Gm-Message-State: AFq9FYLiBVRLOXkqt8DFc/x3vcH/mjC10hvziWqdsAi7+wYWYDgNhldr
	QEibzo+2kN13XU9u6GIS+k7cmb8+Aj4vWfKe5t3CwJSe5sfkvZ6TfvwYJiO5PoyJdcM=
X-Gm-Gg: AYBFou0hfwfjy9zEgm4v6xVstry1cth8V8521/W3C2SVyfJn2aPHEwuXmdPYgZJwZuA
	V54z2hFXE+pnMpXZ8pCitoddiIk3XmtYcsXE8cAmOPl3PDq4KiAMbK+/m7DOLedFKRMvSX0xK9N
	QJVzHV4cJewz0R4cWD1JemEr7hVlSayGi84WwJuNqbahT3TiKCi1fuC0yGyQ5n2JHedOffvujOz
	uc6MzSc/BYfcMGQqWxNPmcrr5piBG+fmT6YRn5Ch4v4GuI7KhBmmbjACMBmH/UwMF5Gm0BvAhN8
	gOj/vfkEqqJtTwEikmznKZh5e3GfyzzQEgisi79O8bp6BU4kGiiMxdnOPl86oBlD2tgN+qTO+JT
	a2Z8HV7vbmkx7pIffVwifOCk1/kivt7aCYYKI1S3loe+7eB7jyt95+psM3HMQpP+J8JftgFtvtU
	ewAlAGeVOS+WqNyB+cD903YABuGbTP5xI7ACNOOBFTs7gFuufrSHqnXAeIRqIB8Zt8CGZIB5OaB
	Fg+VXLj5Z2pwQ==
X-Received: by 2002:a05:620a:3956:b0:93e:9792:fd47 with SMTP id af79cd13be357-93ebd0c2423mr2968505685a.4.1792075133775;
        Thu, 15 Oct 2026 07:38:53 -0700 (PDT)
Received: from zippy.localdomain ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b97bc6d42sm82581486d6.34.2026.10.15.07.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 07:38:53 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk
Cc: Daniel Thompson <daniel@riscstar.com>,
	ansuelsmth@gmail.com,
	donggeunyoo.kernel@gmail.com,
	mohd.anwar@oss.qualcomm.com,
	lorenzo.bianconi@oss.qualcomm.com,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 1/2] dt-bindings: net: qca,qca808x: Add regulator properties
Date: Thu, 15 Oct 2026 09:38:46 -0500
Message-ID: <20261015143849.483339-2-elder@riscstar.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015143849.483339-1-elder@riscstar.com>
References: <20261015143849.483339-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Thompson <daniel@riscstar.com>

QCA808x has four different power rails (although in many board designs
the different rails share a regulator). Add each of these to the
corresponding DT binding as optional supplies.

Signed-off-by: Daniel Thompson <daniel@riscstar.com>
Co-developed-by: Alex Elder <elder@riscstar.com>
Signed-off-by: Alex Elder <elder@riscstar.com>
---
 .../devicetree/bindings/net/qca,qca808x.yaml     | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/qca,qca808x.yaml b/Documentation/devicetree/bindings/net/qca,qca808x.yaml
index e2552655902a3..03daef1c7a4e6 100644
--- a/Documentation/devicetree/bindings/net/qca,qca808x.yaml
+++ b/Documentation/devicetree/bindings/net/qca,qca808x.yaml
@@ -17,6 +17,8 @@ description:
 
   By default this special PIN is set to LED function.
 
+  Additionally, up to four power supplies may be separately specified.
+
 allOf:
   - $ref: ethernet-phy.yaml#
 
@@ -25,6 +27,18 @@ properties:
     enum:
       - ethernet-phy-id004d.d101
 
+  avdd18-supply:
+    description: 1.8v analog power supply.
+
+  vdd-supply:
+    description: 1.05v power supply.
+
+  vdd18-supply:
+    description: 1.8v power supply.
+
+  vdd125-supply:
+    description: (1.25v to 1.98v) LDO regulator power supply.
+
 unevaluatedProperties: false
 
 examples:
@@ -39,6 +53,8 @@ examples:
             compatible = "ethernet-phy-id004d.d101";
             reg = <0>;
 
+            vdd18-supply = <&phy_vreg_1v8>;
+
             leds {
                 #address-cells = <1>;
                 #size-cells = <0>;
-- 
2.53.0

