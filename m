Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794567954;
	b=xMEXQcZDy+fKU3LldGA18MU9dmzAIneRyWVlprppvtg5WrcgQkwNwq9uiwv87ZcuyT8g
	 5IAgEQQMfMjDh1TO6jieHPTzlh4lHqeM11aXFj4TYmA+zu8XW+gA8U91qBEf/++zFeLUg
	 vM/dulcNbzUPFuJQjUMnSUjV5Ns3lSS6KMNvTjKIFSkrDh7Jwc+C3DllNYJ+1qq2zsSzk
	 4vmd+EBVhb6xQC/LLYjPdMFHqnQpw0e2AyflUkEFoIf0gyXHNjG8mTRbhryukJ2ae9L8x
	 /QLzIINGSijSk5b2HFqQ8IqXGZka2komQyjL4mezW/nhhB9j08w9kQvVDjmMoEpaMTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794567954;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=adqH4gL4dB0+FWqAngd5GrykPAAcVtJ2pDUv7Soqjb8=;
	b=kTN8vLh0v7J7xXgXrxCnAEdFlGp3Qmz4qy6xvsbuzw+pmBrRvtwjsdKVIa7lpMfWO6KC
	 D7VzC92I/ayqWt/pHEvM2HfxwnxQcg0GzoVPJLD43MUC8ghgLPJ4GbfpsWOm7GBpqojI9
	 HPXElbjajbBycRY77MtWTxAZ6ycdaW9LoNd4EV1k5z/XdF7KIt5eaKi5MYtPC1tOGd1p9
	 ovQX9iTiT5YEDpOWc+Nh4z+Yx6LMm9ztmRnMFtTrgbzHgkcG3ypQHrzz1UZa14DUWbFCv
	 D25/dBn2UbvjktaxGwbwoTFI+ZUYIY1MD9aJNbXH7PDgougic5F+uZBYfgCsT0LyXPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BvggJcHF;
	arc=none smtp.remote-ip=209.85.167.45
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862F9606A8A1
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 11:05:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 862F9606A8A1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BvggJcHF
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5c15956ce07so1880086e87.0
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 03:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794567953; x=1795172753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=adqH4gL4dB0+FWqAngd5GrykPAAcVtJ2pDUv7Soqjb8=;
        b=BvggJcHFAroFul6B/s8V05DSEmo3NTfrJpxWfO+JxblHI8WNlizqIMLtiemMX2fH0v
         7tiNn7t3OUH8KBcRvGsku4+AQMCHOI+ZMBiovaswKSQoTqKumgQYkWHk+Inze5S+Xzd9
         Pm82LolSRrWxcFEsIkwfU2m+kpThTQr+VRWFs2OG1xn7qcQriUV+hqJC5/t3xyMMvkTr
         6kOMWDYyAozsAUZ9tnZR6dhhFK/SHb0BcO01dQGc+cgYdet0l8zoKVKEDGlTGUafIsf3
         MCfEqpkvBbO+URvD/Fca5/dzu0kJvu+4wq5M+bji1hcH/Tvvi3rfXT2jcdoFbyrwGXY6
         0dgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794567953; x=1795172753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=adqH4gL4dB0+FWqAngd5GrykPAAcVtJ2pDUv7Soqjb8=;
        b=bpz3jLqjDCFIlhIgtz1F0RBCrESgNgzPFdwp3rlmc8CYHtHRyrcKs2fmRMwFLYcSpy
         JL1bKdmkjrOjGyzSHPtcNsl+ID/NnUnw6jm8kxGGmqshhht4n1vDw+ifQgYg8PUVoD3C
         uBCDfuUexRmE1N2MNlZQH0I6J2WggoxQxRQBSyvr5zzbd9jNvz0LqzRx1sUwxu2VviTN
         iEUO7MCnqD+iMMrU5Jmj61DHDw9GNjo8V2EEdKvkQ4zmHeFWKGYq+74WT8wrdk999fcA
         A5GftRAu4ukMFYHDqXLx//RQR8PFpazAtrxoVY3EUn8nBdTaWvTyliuHN6RKQthqS3tG
         NJhg==
X-Forwarded-Encrypted: i=1; AL+hErHivkebxZiID/G/eAiQFReo2UjBr4D9xfAXCsZ2eycGXmXZaHTIXBDLZtZrEOOtom9n7Uja3gE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9j7iDVJI1hIgyXVO94c7wwTjUcIg43VysC0GCitqk5QLXxsNpQ
	V7MxqFHjJRrhuLx2NY/fBYhJXn+8yM6ztGLLy5Pz4Se9foNsOtPSBNkYd9MomQ==
X-Gm-Gg: AYBFou0C77vfvFXH8qUafCG2dR/eoZRc/mjwp1K9JAAgDztioB2f8VW6FsuLIUB4NMr
	4Cb4cwgZsycbr7fcVvxzj2dkn4RRawu7+8ZIxtLfaD2Z87BJOUzNu09BU0//7IeyflzMflm3m4C
	rLLyTjw+mGmUWcP1sKDdWX0VhRiRI9MhENJ5PjZl92uocRUMQBeqdkFYumBkFKELVy518zcMplK
	YUgoGxHn4ymbE7lD/sDomwUUi/rkDb+BXPk9XHYfu3Q5I4W+9PwGRgrMqPT14WJ4T4gEQLI+gaY
	l553YxtDcAp+ICjnaL1MipKZywfYqVWOiLDad/1Mbt3c/6OjXokLygq4VChNR7U6T6aJ9sApE01
	0veDGPjvOjUodInT2aNy6CJ0uvAGYBvHNT6q86+FHKk1Xmds4jm+kKkEGrVSo55d4eNdxD2DcIt
	G4r0muOQPo+dQwCPvRFA/uclenTP/nLrFfKY+3fvEuhBoT/JHc1lTKr+Jsv9bjgNK0nAW/UnDmn
	5oOQgs7bw9L10YRwGnnGtfSGz3qlOHxNhRI6iprmuqXCedA9Ek0m5N3GgZOGXquSbVMkJYSlZNq
	tFtxr+LorIOq8sqfDLvZ7kgTZB6Nmpm+F79aWCSrKAd55SH1LyzwZCLhqUFts4brlWcT
X-Received: by 2002:a05:6512:3c9f:b0:5c1:56f6:2e78 with SMTP id 2adb3069b0e04-5c170b36c01mr760155e87.24.1794567952545;
        Fri, 13 Nov 2026 03:05:52 -0800 (PST)
Received: from NB-6746.corp.yadro.com ([188.243.183.76])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c17133371asm610997e87.21.2026.11.13.03.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 03:05:52 -0800 (PST)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	maxime.chevallier@bootlin.com,
	pavel@ucw.cz,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-leds@vger.kernel.org
Cc: Artem Shimko <a.shimko.dev@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next 1/3] dt-bindings: net: dptel,dap8211r: add led nodes
Date: Fri, 13 Nov 2026 14:05:43 +0300
Message-ID: <20261113110546.173624-2-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261113110546.173624-1-a.shimko.dev@gmail.com>
References: <20261113110546.173624-1-a.shimko.dev@gmail.com>
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

Document the optional "leds" node supported by the dap8211r phy.

The phy exposes three configurable led outputs, each of which can be
assigned a color, a function and a default trigger.

Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
---
 .../bindings/net/dptel,dap8211r.yaml          | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dptel,dap8211r.yaml b/Documentation/devicetree/bindings/net/dptel,dap8211r.yaml
index 4cd0f9730d95..43425fc8e96e 100644
--- a/Documentation/devicetree/bindings/net/dptel,dap8211r.yaml
+++ b/Documentation/devicetree/bindings/net/dptel,dap8211r.yaml
@@ -20,6 +20,7 @@ description: |
     - IEEE 802.3az-2010 Energy Efficient Ethernet
     - IEEE 1588 SyncE support
     - Internal packet generator and checker for link diagnostics
+    - Three configurable LEDs (link, speed, duplex, TX/RX activity)
 
 allOf:
   - $ref: ethernet-phy.yaml#
@@ -28,6 +29,22 @@ properties:
   compatible:
     const: ethernet-phy-id0008.011b
 
+  leds:
+    type: object
+    description:
+      Optional node describing the three configurable LEDs of the PHY.
+      Each LED can be assigned a color, function and default trigger
+      (e.g. "netdev" for link/activity indication).
+    patternProperties:
+      '^led@[0-2]$':
+        type: object
+        properties:
+          reg:
+            maxItems: 1
+        required:
+          - reg
+        additionalProperties: true
+
   reg:
     maxItems: 1
 
@@ -49,6 +66,8 @@ unevaluatedProperties: false
 
 examples:
   - |
+    #include <dt-bindings/leds/common.h>
+
     mdio {
         #address-cells = <1>;
         #size-cells = <0>;
@@ -58,5 +77,24 @@ examples:
             reg = <1>;
             rx-internal-delay-ps = <1950>;
             tx-internal-delay-ps = <1950>;
+
+            leds {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                led@0 {
+                    reg = <0>;
+                    color = <LED_COLOR_ID_GREEN>;
+                    function = LED_FUNCTION_LAN;
+                    linux,default-trigger = "netdev";
+                };
+
+                led@1 {
+                    reg = <1>;
+                    color = <LED_COLOR_ID_AMBER>;
+                    function = LED_FUNCTION_LAN;
+                    linux,default-trigger = "netdev";
+                };
+            };
         };
     };
-- 
2.43.0

