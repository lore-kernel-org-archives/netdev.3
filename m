Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB293E4500
	for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 22:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786921048; cv=none; b=l9A5z9tu9JFrWFNj/JOH8bQZj04xQrBti/dge0GeTOFxJFEjihpAiX+hmmSiAkEzH7OpaJoECJ+oLmAn3UBGpR/Ai0tCAB1pdysYTM2HH/yCSi4CcgTAJPwQueWE4prM+oSQErZVM9mU++JAZZSbcM2/1FQckLTlHQaNuecogZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786921048; c=relaxed/simple;
	bh=cEYU4iS4uVn6kH7ueYlRIWvXLHt1bwl0zgCO9UOFecY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JZfef8qOGcpNTe9E/lc09fPWJsqGlJQYoC2p+DRnaJZBvIcvpJSZ5621GbzpZzlKyS6LV6H73PvANNBtOi9CpCES7CTvX1mumurZBvxx1R3VUj3MAADc83UJPBoypzIG+RrbDcHhXC0TOfkfH2jAgfOxKCqppn0fCPgzrmntkuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H1EuMAwR; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1EuMAwR"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-ca5b707b78aso131642a12.0
        for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 15:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786921043; x=1787525843; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7BVnqT9cdJk1FHwC8eirIGC4FVtbY9zESyd/XT9rDyw=;
        b=H1EuMAwRF8x/1JqPFH18ihCB31guN7Pg69DEBiYVv+ts1I8EYF9XmMnrnymDYPawhm
         uWAH3xeZUeq0B3CJN4KOgWuDeVDOQEnFF469bPFqYLfkFhi18nRrdwNCQv7s6/sebuRW
         cd/vuOMdK5EFeB3SptgX1Ixfsu/2h1cSPMGada4LVzTmd8ywlJmwm4PFccwBmCPe5nX0
         3/PuRmDVJrm77Q69OGjp8m2pnCzfZVGHcdK5lmQmLSlKK1yO1Owk2xMULVV+brAe2PZm
         yJ5TMIaccIQ9fMeBWK5iwf/Q8UNGXiXciiq1HP7M3Iq1XWXV2BXW5Z0SasMWdUDPuQud
         O/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786921043; x=1787525843;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=7BVnqT9cdJk1FHwC8eirIGC4FVtbY9zESyd/XT9rDyw=;
        b=EWT37gjSdKdC5j2qbr6uvCKgGirPUlkQXqJ5uXGA/ZK9zdI27R9T6gsJcbpveOdaZL
         a5B0Vfxg/PdDLQ2OWeLS8ILfee7Br7o7YPjwPimU7w/T2l0lDbxkK2I4cfCR6tJkWA6Z
         wrGSTqPSyufz/HaM9EvpEKgRllbHI+sl1+UcS7q/MJWRVcsxJQ93/clLmMCgFw+hrM6X
         K8EKQFd69zcLyb0va+0wf/rhyFfPsDSv9fcFDWD8/Xx9UU7jV5KWHWcPTiZ6rLvocBBq
         +AxFxqFR6CIGAjT4dD+6KbcuvYFrO40L+ZsbCypCuJdMTuFtEN+54auFmGvkvTecCNFy
         0aGg==
X-Gm-Message-State: AOJu0YxqztUCH7hTtXC1wAu6D3RkHZIDEe4lPrw+H45ErG+h2YxYntvp
	7L7JCUF6UvpiHriHWeqS89pIFG92TqMJMNZ48A4eNuHlAh9FhNk4azdNmeM8gw==
X-Gm-Gg: AR+sD13TPbVsj0KiRJUdLTqJGxcS6Tr6TmAbmeXyZGMlXGXcZwp1muO58TAPij4Eyo0
	zCmzXCuP4tJu6ygJ7xWbQZEYSdnXLWfcckD7onQPfGWFhvqb4lIoJY3Vac+zsMfDYfX/hXK0e1H
	ipR/FHjGuSnaBtzYIpoCmAqRtBKmI+pLRGQB+YseEredFYmYkRgulFfiVNpIWxBPGiC0XbuLcIA
	+twCPixVOFjr/os9L31M7k4cgORGkHYDQ5VM3oLxRetbjBRColJNCjfDZp6LktrFsjyAmRZ3bfe
	uuLCDrrbviGzi3X744JQchAposlHDQHN1TlL4V/64R7Th7bHoUfa9EuF/qssxlg+zloCOzw9uJ1
	g3D1nvcAtEMtbU3blAF0OEFIPcHXtJb61YWVe+dzkc8m3CSurrXeI4YQkHq4/rg5a8sYtFkxPL/
	gdpepLXy9jSxU6guNUtpEanJaoSm8yRZa7pyII7Y1ieQyIr3nWB8ca7v4JbhiLV5VWXioGEgnwK
	Q==
X-Received: by 2002:a05:6a21:6e83:b0:3bf:a638:4384 with SMTP id adf61e73a8af0-3cc71e71511mr16191711637.2.1786921043437;
        Sun, 16 Aug 2026 15:57:23 -0700 (PDT)
Received: from [10.112.173.252] ([2409:40c2:504e:1c5e:cbdf:b953:2369:869e])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1413887ee65sm32434305c88.10.2026.08.16.15.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 15:57:22 -0700 (PDT)
From: Bhargav Joshi <j.bhargav.u@gmail.com>
Date: Mon, 17 Aug 2026 04:27:03 +0530
Subject: [PATCH] dt-bindings: net: ti,davinci-emac: Convert to DT schema
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-ti-davinci-emac-v1-1-022678d966e9@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MOwqAMBBF0a3I1A74w6hbEYswPnUKoyQigmTvB
 stT3PtSgFcEGrKXPG4NeriEMs9INutWsM7JVBVVW3Sl4Ut5trc6UcZuhQ2kNwvENjUoVafHos9
 /HKcYPz8YmcphAAAA
X-Change-ID: 20260817-ti-davinci-emac-7ec97feca43e
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, goledhruva@gmail.com, m-chawdhry@ti.com, 
 daniel.baluta@gmail.com, simona.toaca@nxp.com, j.bhargav.u@gmail.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786921031; l=4111;
 i=j.bhargav.u@gmail.com; h=from:subject:message-id;
 bh=cEYU4iS4uVn6kH7ueYlRIWvXLHt1bwl0zgCO9UOFecY=;
 b=jTzWA8nCmkndg0CfEp4E4/qYhQcCxVAc0BHYIcokwRZCrnryl6Noy19cFunlfKx3PjuUXjNfl
 YSJt1S73YYUBkiY9YY0yJZkKB/ZKDNJgPhrhhjHqMF7TbxH0pKThy5b
X-Developer-Key: i=j.bhargav.u@gmail.com; a=ed25519;
 pk=IqNDwUZKECEA+n8wXctFLBbYL9NhFstZNbOznm/nX1k=

Convert Texas Instruments DaVinci EMAC binding from text to DT schema.

Changes from the original binding:
- Add clocks, clock-names, syscon, power-domains, and ti,hwmods
  properties that are used in existing DTS files but were undocumented.
- Disallow syscon and clock-names for ti,davinci-dm6467-emac since they
  are not applicable to that SoC.
- Allow 1-2 reg entries (DM816 uses two).
- Make clocks a required property as driver probe fails without it.
- Mark ti,hwmods as deprecated.

Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
---
 .../devicetree/bindings/net/ti,davinci-emac.yaml   | 113 +++++++++++++++++++++
 1 file changed, 113 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ti,davinci-emac.yaml b/Documentation/devicetree/bindings/net/ti,davinci-emac.yaml
new file mode 100644
index 000000000000..cb1394f6f2d4
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/ti,davinci-emac.yaml
@@ -0,0 +1,113 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/ti,davinci-emac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI DaVinci EMAC Ethernet Controller
+
+maintainers:
+  - Tony Lindgren <tony@atomide.com>
+
+properties:
+  compatible:
+    enum:
+      - ti,davinci-dm6467-emac
+      - ti,am3517-emac
+      - ti,dm816-emac
+
+  reg:
+    minItems: 1
+    maxItems: 2
+
+  interrupts:
+    items:
+      - description: Receive Threshold
+      - description: Receive
+      - description: Transmit
+      - description: Miscellaneous
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: ick
+
+  ti,davinci-ctrl-reg-offset:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: offset to control register
+
+  ti,davinci-ctrl-mod-reg-offset:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: offset to control module register
+
+  ti,davinci-ctrl-ram-offset:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: offset to control module ram
+
+  ti,davinci-ctrl-ram-size:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: size of control module ram
+
+  ti,davinci-rmii-en:
+    $ref: /schemas/types.yaml#/definitions/uint8
+    description: Set to 1 to enable RMII (Reduced MII) mode.
+
+  ti,davinci-no-bd-ram:
+    type: boolean
+    description:
+      Indicates that the EMAC does not have on-chip buffer descriptor RAM.
+
+  syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to a syscon node providing access to the System Control
+      Module (SCM) registers. Used on AM3517 and DM816x to read
+      factory-programmed MAC addresses from eFuse registers.
+
+  ti,hwmods:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: TI hwmod name
+    deprecated: true
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - ti,davinci-ctrl-reg-offset
+  - ti,davinci-ctrl-mod-reg-offset
+  - ti,davinci-ctrl-ram-offset
+  - ti,davinci-ctrl-ram-size
+  - clocks
+
+allOf:
+  - $ref: ethernet-controller.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: ti,davinci-dm6467-emac
+    then:
+      properties:
+        syscon: false
+        clock-names: false
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    ethernet@220000 {
+        compatible = "ti,davinci-dm6467-emac";
+        reg = <0x220000 0x4000>;
+        ti,davinci-ctrl-reg-offset = <0x3000>;
+        ti,davinci-ctrl-mod-reg-offset = <0x2000>;
+        ti,davinci-ctrl-ram-offset = <0>;
+        ti,davinci-ctrl-ram-size = <0x2000>;
+        local-mac-address = [ 00 00 00 00 00 00 ];
+        interrupts = <33>, <34>, <35>, <36>;
+        clocks = <&psc1 5>;
+        power-domains = <&psc1 5>;
+    };

---
base-commit: fd923b32d7614047c8b2acecae3915ec94f7afab
change-id: 20260817-ti-davinci-emac-7ec97feca43e

Best regards,
-- 
Bhargav

