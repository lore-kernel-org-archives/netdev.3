Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DAF475351
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 10:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792146636; cv=none; b=k4FmLhvUzLH3Eekz+aaBRtiqFhnghz//SemKtx3oUKubzkOH1u2r6ecOAvX5w8dJmmjdeAaDPYZ1x/hJ/SNkYZrLwizrR5qpgzi31W5oQ0TG2cj8lXjnIoOyh5pErBJYYDX5MrLSq/xyhANd8wVUM9cDESaVKQXXwbGrQeN9jyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792146636; c=relaxed/simple;
	bh=gxIq6ifytR/JAI05/Wxbb2mz24KshSEfWdEtAzkQt6Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WFN/WeFUE1Y8pJMHUU5QMEUJXi+ZYJGQ8RJdnTo9fN+qwO9BIz2Th2ouMqzrvYn3b44/Mkt396CFR71ABwT3LW4UGQAi6pwtOSshlNXyNfVicJwd+NAXLnZJSUzs2YLMRYrln5IiA+U58wh2MziHdV+fWXfCAPY33cViTmQzxhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CryHwVKP; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CryHwVKP"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c20ce3c118aso169933866b.0
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 03:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792146633; x=1792751433; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2bKjwQPxfej5CEalIEgEN/iRfsSwjtHzCvEmFIdw6Pg=;
        b=CryHwVKPuixPPFVkoEqDZ+a+8ONpHPSF9HPFLkoOncTHTdnsOqyTkoxjIma/0YvlBW
         YRdfMu+UPCAl9RxbksjtfJGMWH78iPhI2f4YW/0MCbTwBlFsLSd2rwlIuKTHRX/vLdSE
         tycOUIVuSjYmk0Yyj/DbSteZmeznfGRFf8WhRbvgDidOQ4Le1YmqV4GCAILmCNa/bK4Q
         GM1YSxtDXaALEJo4rYwdTyXBYulGfTKm3gWc8DUKCTAtoS2HyMnzgTVzEBPYm6sjRlyi
         J3fWj6OWRT5PjUOHStrDNowyvnDq9L7XciDKTDu/BVXJfmDthAyiwflKTdwNJqcZ39bI
         +qWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792146633; x=1792751433;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2bKjwQPxfej5CEalIEgEN/iRfsSwjtHzCvEmFIdw6Pg=;
        b=ah+LyRTqkfW7AopZTEJy8Lj030+9WuqPTU0Sw2RCgQNiT4sIFQRlJRFiPkFZjYWYAf
         vrwQlOm40LlAAXbaiQdmdM5lqjpM81zyjORXEiB8ExDUJfIg8uQ4hXPzl+zYoXI44euh
         ThWRYADJg3bHMg1D601fFvXnhDdFxgU3pdIp2gTURG8QqwrISysD43QLKWerQF/9/BWV
         JsdFwQwV8vLxJgZ3ir91CgPG7Na8tjdE9XXzIAuUzGOoIV121iCfEdmPgEoErcZY/x5U
         nkgJmNzTCOx0emtBJuuI6MfQxIKPzMvDy20Cb3BERJPPkUTgOlThwWtvmt73pTzeshG6
         uOuw==
X-Gm-Message-State: AFq9FYIzyucR07+jzSJkBcS4W85LLwOwBTANJoQRIoMOPiJ0c03RF/Wz
	H5Orbq9Ki6XQfmtDtdr8FdUhmbQH6RzzE5rLuooXk7Qbh19VfvV86K1X
X-Gm-Gg: AYBFou1JUiOKW0GlaKLAl0oewtj1c8xr1UF9IURYay2SLu2nv896OHoOGvRjHrAdyJ6
	betPeiewWH7mDOzbHzrH5eautk7hXmhsj3K9yQ4lbZBRYNSm2F1Jk2mjBAOvt6RDX8tegAzx8f0
	LGdC3vFC28+t6eAwCTzFBojcJLGsKO+9k5A/K5NmK6ddwPFOPQpNLgORCnv64q2lOa/hGme44U7
	CbSeI571Q7/JkaW1qzcttzgqknVgn2ELpX0d/JN4sJnowOohet6epTtIRwmt0PCr8gqK38CH2P/
	rnd30LWWHeBjYbGZXV7BFp8hMCxOYaVgzQQlWQOmcmcArXJYKchqD4ipQRaYgDlOyurc9WS9hm1
	9Mqsuu21ufSyp0D/H20snuUCJ2ObcN0UYqvtaBfoouFt23mWFurMeuNgIrVMfEFPF0xRKY3VLen
	Oc7JtPEPLW+L2eqB+3YbQiUlfXXb8oT2ubeev4WnDdx+Ao7PAh6uuc9Po9Y2U/G6OpZUggOtovK
	8q6+9DrQs1L
X-Received: by 2002:a17:907:86a3:b0:c31:6fda:52b7 with SMTP id a640c23a62f3a-c4020eedba8mr234447766b.21.1792146632831;
        Fri, 16 Oct 2026 03:30:32 -0700 (PDT)
Received: from localhost.localdomain ([193.107.16.241])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c40912ce133sm60613866b.31.2026.10.16.03.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 03:30:32 -0700 (PDT)
From: Dmitry Yashin <dmt.yashin@gmail.com>
Date: Fri, 16 Oct 2026 15:29:33 +0500
Subject: [PATCH v2 1/5] dt-bindings: net: rfkill-gpio: document reset-gpios
 property
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-ok3568-c-v2-1-068d68430e6d@gmail.com>
References: <20261016-ok3568-c-v2-0-068d68430e6d@gmail.com>
In-Reply-To: <20261016-ok3568-c-v2-0-068d68430e6d@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Heiko Stuebner <heiko@sntech.de>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, Dmitry Yashin <dmt.yashin@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792146625; l=1639;
 i=dmt.yashin@gmail.com; s=20260930; h=from:subject:message-id;
 bh=gxIq6ifytR/JAI05/Wxbb2mz24KshSEfWdEtAzkQt6Y=;
 b=VbqmIKE9xA/W/LJMZES0LcVcRSUOVVY2CefAm9neUM3UYLCdrjlwuk7AeZQMIAGrmt7q54X5W
 UzhAtJ28ZoIBby0Ort5ufWzrkitHUI6oxTUyh4O2Fn91/s2EoQEi5Y9
X-Developer-Key: i=dmt.yashin@gmail.com; a=ed25519;
 pk=vBe9jaaOEH5bQEvfzb1tWOlz3AMIcXCu/GL/CdlwJco=

rfkill-gpio driver requiers at-least one of the gpios to be defined:
shutdown-gpios or reset-gpios. Document missing reset-gpios property.
Also add example for wwan with both gpios.

Signed-off-by: Dmitry Yashin <dmt.yashin@gmail.com>
---
 .../devicetree/bindings/net/rfkill-gpio.yaml       | 23 +++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/rfkill-gpio.yaml b/Documentation/devicetree/bindings/net/rfkill-gpio.yaml
index 4a706a41ab38..66f6ad2872ff 100644
--- a/Documentation/devicetree/bindings/net/rfkill-gpio.yaml
+++ b/Documentation/devicetree/bindings/net/rfkill-gpio.yaml
@@ -29,7 +29,12 @@ properties:
       - wlan
       - wwan
 
+  reset-gpios:
+    description: GPIO connected to device's reset pin (RESET#)
+    maxItems: 1
+
   shutdown-gpios:
+    description: GPIO connected to device's shutdown pin (W_DISABLE1#, etc.)
     maxItems: 1
 
   default-blocked:
@@ -39,7 +44,12 @@ properties:
 required:
   - compatible
   - radio-type
-  - shutdown-gpios
+
+anyOf:
+  - required:
+      - reset-gpios
+  - required:
+      - shutdown-gpios
 
 additionalProperties: false
 
@@ -54,3 +64,14 @@ examples:
         shutdown-gpios = <&gpio2 25 GPIO_ACTIVE_HIGH>;
         default-blocked;
     };
+
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    rfkill-wwan {
+        compatible = "rfkill-gpio";
+        label = "m2 usb wwan";
+        radio-type = "wwan";
+        reset-gpios = <&gpio2 23 GPIO_ACTIVE_HIGH>;
+        shutdown-gpios = <&gpio2 25 GPIO_ACTIVE_HIGH>;
+    };

-- 
2.56.0

