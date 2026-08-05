Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E6C3A9D8A
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 02:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785896917; cv=none; b=AxQLfPsNWMtBt0kR6LAQcROaS6xS1V4GJyMj1kaAf44X/krJ5YDmRACnTpaU4cggcyMGQgz3z9GUPd/i/y14zb3cjbeh+viwT5+OuBKijSZgtRkFm6Ii+8p5XdJPqrwp4mEkjSilRDpjoaQS8wCq9IL39IaXxllX+RM00Dk44Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785896917; c=relaxed/simple;
	bh=88UypGhQr4MP1727IeMqM86/bOK2bO2zPytpS8FWMYY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ivcSeEgylADWUz5pTtDC+7wNc0H9mnmXSdf9xso8Mih9fCRJhfAU/i12uapOgN/NUlFgxvLzGwryCDZAoN8YEVljMnKfBVyKrDUtGUw1B4ZaleWJeQPRaYNw8YaArBys58zvZt8Q9VpmwhSi8MZkWt/UccEqkOgrmRHZs4kbYKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r4f1QsG6; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r4f1QsG6"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6acc2a10023so208480eaf.0
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 19:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785896914; x=1786501714; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YY4CB5Vy00/NtteUzUzKZor/e0ptbflg+HuPiVWnSpQ=;
        b=r4f1QsG61DHiA+l5ZPYamZNXgXi1HUM6gCM2J4CQvjgtWUoRQyiD7NcYwPzWozWQZH
         GMc8VjhBHy4jj08+Ic7Zdl72JQkaauTdbx5Fa8NOd8+BeegsJaC53MSdXvPE2CJ+lmp3
         YGKoFJ18P52RSI+/lUvtSZt/lsGybQUE/FybFXOBt8/kvu/mDmM5TQF6qO+/VZ4z2S9E
         dDJ5+q2p4yC4Hi+TLqoWajThDf4keXrEpEm5m8/VESu7Xh0lnHCzi+FcDMqaKpS9L+KU
         c/oSvhkHHjvfgLNzIMLpQ+zWE7qWmdHdRl4NPqCHlrh2E7LXAjNWtUr1LByhdCcg8ldz
         4NiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785896914; x=1786501714;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YY4CB5Vy00/NtteUzUzKZor/e0ptbflg+HuPiVWnSpQ=;
        b=WTxUYajmwWM9pPQAB3V/cn2QY6jNAo3Li3MjAXBsI52qheL0wl9kNHSGsPR0kb/NP/
         sVlX6luMGWtBobNIcVKPCxA7IMtQ9MBWHZYM2YjFLXxobQuqBoRaWU4ZurGaEEYvZ1yP
         VfC5K/DLxoMHOHaagdHwy4zF7aF+3wzdWxIK0gTrpuuAGTonCJE5WBE2jPsUwMPS51sb
         iKrdkp+QwKoJSBeUuxkUxxLgiHNTfHd7OSn1FAK63FfcS+5FaRt0LI9g1zxyiqJBwEsj
         UZvYgX2VgIoYI9efH1mwAQPKySNxc1eOvmMygIqBKv+XExkXkQFFCBxJGenGrzgsfw7z
         zS/Q==
X-Gm-Message-State: AOJu0Yy8NNnNR8Tmi3E1B3jCjtOrHhBWTzwKFFttFLcYhYyVsktrZqqw
	IHgcC6p6riSMP5f5wevQosW4T4djqczZnmR/b7Z9o/ZOnT8eKdtrfpvT
X-Gm-Gg: AR+sD12+CHy5izipmc4TOjKUEYP874OuJB3LeSs7pkgE3b32ZOP0bYya95wqX+boARR
	xP1/nlZcHsv1DLZMXvPNUOp/gJtH5Oi8Jb1CH4AhDd0k/7Dnc8pH9hty6QaOrD4Q0Sij+kOOnr7
	zva7Lb17Nr1JdtXORgrs5FRMpZY3d6gNcHxcoNED1pE6l+Y0546jzdT9fg+vsXyIrYils8m4iWv
	3hdYJ0ZygndCpUeGzN+E2eYfIVCBSVzHtMx5JTez5azkRo566ldFthKm56ATleDBjLugGQHJ1ba
	kBTqnW+eiNv75Lx1AtI085DTZDB9XWZ48rsvCTt9Nx4QdRh3rDHhkgBRmln/TlYmFIS7SZoNBSG
	/TcbsjNG/jcU1ugDap+GhurHSWAN4+cw1ceh8mTz6ruxC+0SoPpaB+R39PpTXKTwlGQ9zy+Imla
	qPhTMObuu7ZvNgAlZ9DRoBbvU6FucJg2XiMH/cHPoMcaCIIDYcsYcnotYRBUOkyNUEmG/yQyPSa
	9xgDFU1oY1HF097aQr1k9UBYOPRCd/JGIIR9yW/hk15AbqhmOqGkoCYouAl8D4BaHJFLPN/OS84
	D2fEYSCVYKi/ZfFNajULtoEA7zkNcHBi71kp3paTvAFfQd99bnZ0u7mir3SQpjphqK1UEWpCp7p
	oIldiS/NnVmQbeMYS
X-Received: by 2002:a4a:ee12:0:b0:6a0:a791:6885 with SMTP id 006d021491bc7-6ae96ed36f7mr2063730eaf.23.1785896910119;
        Tue, 04 Aug 2026 19:28:30 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f1df565d37sm2078153a34.16.2026.08.04.19.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 19:28:29 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 04 Aug 2026 20:27:00 -0600
Subject: [PATCH net-next v2 2/8] dt-bindings: mfd: x-powers: add AC200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-submit-acx00-of-dynamic-v1-v2-2-3eef49ff1d8c@gmail.com>
References: <20260804-submit-acx00-of-dynamic-v1-v2-0-3eef49ff1d8c@gmail.com>
In-Reply-To: <20260804-submit-acx00-of-dynamic-v1-v2-0-3eef49ff1d8c@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Heiko Stuebner <heiko@sntech.de>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, mfd@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

The AC200 is an I2C-controlled mixed-signal companion IC containing
audio, video, RTC and Fast Ethernet PHY functions.

Describe the parent device, its input clock, the four package supplies
and its optional Ethernet PHY control child. The input clock must run at
24 or 27 MHz when the Ethernet PHY is used, matching the rates encoded by
the documented EPHY clock selector.

Interrupt-controller and TV-encoder calibration properties can be added
with the child functions which consume them; the initial binding covers
only the common core and Ethernet control child implemented here.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 .../devicetree/bindings/mfd/x-powers,ac200.yaml    | 77 ++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/x-powers,ac200.yaml b/Documentation/devicetree/bindings/mfd/x-powers,ac200.yaml
new file mode 100644
index 000000000000..4ea56e99c370
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/x-powers,ac200.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/x-powers,ac200.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: X-Powers AC200 mixed-signal IC
+
+maintainers:
+  - James Hilliard <james.hilliard1@gmail.com>
+
+description:
+  The AC200 is a mixed-signal companion IC containing audio, video, RTC and
+  Fast Ethernet PHY functions. Its control registers are accessed over I2C.
+
+properties:
+  compatible:
+    const: x-powers,ac200
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+    description:
+      AC200 input clock. When using the Ethernet PHY, its configured rate must
+      be 24 or 27 MHz, matching the rates encoded by the documented EPHY clock
+      selector.
+
+  ac-ldoin-supply:
+    description: 3.3 V supply for the audio-codec LDO input
+
+  ephy-vcc-supply:
+    description: 3.3 V supply for the Ethernet PHY analog front end
+
+  rtc-vcc-supply:
+    description: 3.3 V supply for the RTC
+
+  tv-vcc-supply:
+    description: 3.3 V supply for the TV encoder DAC
+
+  ethernet-phy-control:
+    $ref: /schemas/net/x-powers,ac200-ephy-ctl.yaml#
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - ac-ldoin-supply
+  - ephy-vcc-supply
+  - rtc-vcc-supply
+  - tv-vcc-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        mixed-signal@10 {
+            compatible = "x-powers,ac200";
+            reg = <0x10>;
+            clocks = <&pwm 5>;
+            ac-ldoin-supply = <&reg_3v3>;
+            ephy-vcc-supply = <&reg_3v3>;
+            rtc-vcc-supply = <&reg_3v3>;
+            tv-vcc-supply = <&reg_3v3>;
+            ethernet-phy-control {
+                compatible = "x-powers,ac200-ephy-ctl";
+                nvmem-cells = <&ephy_calibration>;
+                nvmem-cell-names = "calibration";
+            };
+        };
+    };
+...

-- 
2.53.0

