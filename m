Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0561C3B42DE
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 17:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791482000; cv=none; b=sHmDJCcmnA1QO+IEvI9zw5uwihAvHOrUOHoI1bmKfEjISj8FK/UskkTxWbO+7zZJPivI7veI1MzWhrULnCQYWKcnsDkSROrUs2h7pv99SQO8A6rKqxFJ60B/dLf4lxg9HqnS2l6HQbEcM53J6Bl8QsQaaWhaxS7aU8r78nPyCUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791482000; c=relaxed/simple;
	bh=dmywluuTLhknLCsh6fks3p6crR7xS3s26oNpw013obU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P0G5xw7MHEQeE8r1ATbuDb02oeZtycP6NXrVGjWtRXoo5KhrMy9crQuk9QhzEF2TSqrNf/Q3Zz5UDEJhAqrTg+DKCwxB//mCPm/ZedfV4u21gHiE7p49i9a8GSI+Sfb2X9ycmirhZK4VesPcJXtEwzYfMi9SM+thT59qUKOEi2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TB/4umTh; arc=none smtp.client-ip=74.125.227.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TB/4umTh"
Received: by mail-pj2-f8.google.com with SMTP id 98e67ed59e1d1-3a7026b3123so929503a91.1
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 10:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791481997; x=1792086797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+dgqDqFuW3rt6C/fWbsq1Mjghdys4ztuGpDNCDTihI8=;
        b=TB/4umThxUL1sslai4KgNU0eIEplZvJlSwypcvxzMfes9ORt/dXEt4NzTovyTvIEgp
         jmKoOzNrbp93u1fb7WLCCHjsnL0iEHHpGX5i6suc5uptYgw2Igu3jXwjwkwc2rexFFkg
         0aoEM8zKj1RUCRLggoD7n0O5gFd/RUEAS6h28QnSfMUvRn1XGvCa6FhoL6Xqdqt3gZL9
         0Rj0XQkpyCcoxStEXn8KGonxKFTas6djbGFIgpHRhEYaKEJVEzy5kB2Vce+7mVXontZY
         B6kg0GdNT91u74RC11qJAl0vIm+ojmdwTo7/NkREc4KWjjAUaAXXqiOH7D0GaDi3dMMh
         hkXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791481997; x=1792086797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+dgqDqFuW3rt6C/fWbsq1Mjghdys4ztuGpDNCDTihI8=;
        b=KWIfbnedPIr4PfkZFXgYaV8W0aFmD2lePqZdbAI/U0+5wP6HyHzQdP6VHePzBxctr5
         JLqrP2IUOBJPtDVZCJQFjHz+feHPAXPAhc6hYWH/8yLQbpTMW/2TR2197wLkJBP8e+DF
         QdzrYybTfbQuQ+Ncd8avQtyqQDr2ijawjNhzIQm9U86UuMdH1r1AY/ZkpzB8k5K3Mzef
         dE73gp2ChCowsYmGEcz9DzLAdpguIu8Dp6u8I0MfD4lRhYRNUmXFQDron69/1TvbYa5D
         1F9kbQYzpexYyOGHGhRMOiIah7V0taSQrXu7zyW83ByRTcZ7dIu7BFI0ZUCP4TF1HvWQ
         dU+Q==
X-Forwarded-Encrypted: i=1; AKwUvBzP3o6B1J0aMPDWeVJ7gZcRo2IAr3kBQOxa8eOHQEFLZDIpHUFAusGLJ5IkkQiI8F5Vm6F7MNM=@vger.kernel.org
X-Gm-Message-State: AFq9FYL5On03y1NHH/E3Q9cM/Et96eltiyhahS/WTliOo3QPEukUb+vk
	32N4zhK33qWxvKdFMCYfjr65rSjzOqCczXE6fVpp47TtWZk6smMh7QFJ
X-Gm-Gg: AYBFou1nJkTrqmNKKaquYpm6gmFmvRcdCA/cGXPIp/FaNjfMijOrOgZwICF4y01Pbjp
	pMdjNgo+qKGgxUygKgn5NP5ET4xevSCGTBK3upKQ+DSWP0dOBA477v90GwHrdHAaJogYCsjHK5w
	24v2GsJ3IFzEqUJZGjVJiBul0Bz47NXXSNFNqOCLxbDIHFFsWt+UJ0YU0W0g3bKzxrF17GAjHqT
	yK5fGqKKccyV4YHR7usE9fV3Q0gWBnH24HbKeqi9PoSEFXkZrKLJI8LwifsMq0uWsS8+sB3wS7p
	AU9t6SxcfrZ4MqdV4uoC+zlbfkxSOs319jJgAlVHVDfG8vRWlQHkGHvwg+CmZxM9gKB81T4AZD7
	ekHxU2ExXAQzpWvu8nORX+R6kLrqm7w5uKUf2A51BTkUzsA+dqIFHw7NJH9nM9neUv0qNZiW8vo
	8CQ25nxDKExd7w0ihWJ1QXtKOe1ghHGzVtpxbxFYmk8Xn5cLKNWKE0Jf4r3v5XlA2dzjGb
X-Received: by 2002:a17:90a:749:b0:3a8:cb54:e132 with SMTP id 98e67ed59e1d1-3a8cb54e659mr2236926a91.49.1791481997269;
        Thu, 08 Oct 2026 10:53:17 -0700 (PDT)
Received: from server.lan ([168.138.199.194])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab3277c459sm144332a91.16.2026.10.08.10.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 10:53:16 -0700 (PDT)
From: Coia Prant <coiaprant@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	David Wu <david.wu@rock-chips.com>,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Coia Prant <coiaprant@gmail.com>
Subject: [PATCH net-next v11 4/6] dt-bindings: net: rockchip-dwmac: document pcs-handle
Date: Fri,  9 Oct 2026 01:51:58 +0800
Message-ID: <20261008175225.3375274-5-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261008175225.3375274-1-coiaprant@gmail.com>
References: <20261008175225.3375274-1-coiaprant@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Rockchip GMAC binding needs to describe the PCS reference used by
the SGMII support added later in this series. The property will be
parsed by rk_pcs_init(), and a missing phandle fails the probe. Add it
and require it when phy-mode is "sgmii" on rockchip,rk3568-gmac, the
only SoC in this binding that has SGMII support.

Signed-off-by: Coia Prant <coiaprant@gmail.com>
---
 .../bindings/net/rockchip-dwmac.yaml          | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
index 80c252845349c..c434450fd07ff 100644
--- a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
@@ -120,6 +120,12 @@ properties:
     maximum: 0x7F
     default: 0x10
 
+  pcs-handle:
+    description:
+      Specifies a reference to a node representing the PCS device
+      connected to this GMAC. Required when phy-mode is "sgmii".
+    maxItems: 1
+
   phy-supply:
     description: PHY regulator
 
@@ -159,6 +165,27 @@ allOf:
         clocks:
           minItems: 5
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3568-gmac
+    then:
+      required:
+        - phy-mode
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3568-gmac
+        phy-mode:
+          contains:
+            const: sgmii
+    then:
+      required:
+        - pcs-handle
+
 unevaluatedProperties: false
 
 examples:
-- 
2.47.3

