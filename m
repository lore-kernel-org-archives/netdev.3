Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F7C3DDDDB
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 07:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785138814; cv=none; b=MB+P+A46HQLXT5XEjHXgj8Lhv1AHyNsLsidFMs3UW5uE+IX4hei2ptsTpOR/wqtYTRiQjtxVj8hn/ZwGfESaeMW4YqLUWQiaC/PeIzGEnYZnZWcbt6sHBMtvX7WyDmC9XuakB1gE2WDyjHlRZkAOQXPYbJWCBwaeLZc/j7h1vVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785138814; c=relaxed/simple;
	bh=y6JIwdIepDyzjraq6zfjHmg6aYC4x/fsAGSfNHPByC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fUSd5mOkoR6kG21Ev25a8Fdg9LarHsRcY8RPgSt3GbuZNQFxRtzNPM+gCtaSLQVheJjsyiWB8mCbywAqpBvOQqhmj5lQp8nBbHwW0Exbh7UeryeC/t6F1zk0OxzS72PrutHRALfxI8KKbajeokO6rCXfyF1Z3coovHgJXERhKVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eicpSk3P; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eicpSk3P"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-69ffb48d599so860496a12.2
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 00:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785138811; x=1785743611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6zZdAClxmTevqCUKw0Xa1m5MszX553esz6ujE1k4zSU=;
        b=eicpSk3P+KwpwAWmQS9C+Afw585JV6Fl2V8UX6Frctthclvg1eYoRCM+EgmO6nNPmo
         FzK43kOXcOGf7sKXQ7jyRAbwJux53drFrRIJTkYXhlMHFXuIOKnkEYgnWaGeWVVlkMeD
         HE2ycNkr+VeGNVpN9AGaQxgHloh50acoV7jGoPvX1LneZrnSZ5Qh9XR5dcNZbgRqD2BM
         /Hz3sRrOC5LysVq0Gde1KVt1l5SKETxdywr0klcR2LdliGySOh+ZGgddv7FmcuT6Ny3g
         NZE3gWOCbB9x/eO3+fGjnqgv74R3Ll4MIfBNgvYSrfzGC8CEJKq/6erdaWVWaxTa92a8
         9+WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785138811; x=1785743611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6zZdAClxmTevqCUKw0Xa1m5MszX553esz6ujE1k4zSU=;
        b=gObs2qA1iEyWot5MYa6TE7+0bM6SQwlR5AWyvqEz1Nka3xNzwnWnOfl1pKBPaABMyU
         /9sqUJ9azGgBRteCUVAwrWPudrhEAwo9kBdSR1KIZGf73JkZ+PTvzXJ9wjDclqe6uAtX
         Riv1jvVvnPwGkhzfrq0CGzLwg37bb398gPnuyBYlaj2olQX8QXlIMkBptxTS/iKWuGZ+
         GUHI9hP37AJBm0lYgYcWa1tle+QVkNIdevIa1T9LLcBkuaDtg2top3MQa2x+SP4sS/PX
         aPohLf+piSUPR0OYK7GTxFQNqk47BGxMLSuvgUwQU7h9uUcL8Mw3aK104TjsyalHgSt6
         cfPg==
X-Gm-Message-State: AOJu0YwWrU4Lu6UH0Nic9PLxNdux0ya+4WQ7zRS/fd7V0uLuuo1VjofT
	4LNret1P8BfDJdSt4F88fwm0LTTqEynSDGpVP3yXMXi39M4Anop55KyJsRK1og==
X-Gm-Gg: AR+sD13olIurdYgnoEDYdZePLs9aQMgUmrzhGp23epfDjmN/3aJUc0rYtteZ+x0cU6r
	rr7K/9x4FTUFs9I0A9Nr1PWGpHO0pUXn+i3vd2y1ziAfi9a+/270u9qo0rn1RtE6yRdubwtLbpY
	Yq4X1j0OEWbVcc7K6t6kP0GFLvsYGowe+tNdYCvyT+Y+lDx5YMMQSTo1bJqoEBSlFhJylkJ0bLv
	P7W7gvTBMCsyzdr7QnODLR/UxFBeH4uxy4i8DCXCn/tN3gNVMSO2I6uiCFWTSd1QAu24cNmC5pt
	qxDLdDDKKzTx/zR9/2RJ4qT1jqlUFjG3L/PGIplFGUGhYHI1Y6dPczmDFWNMK2Krvf9t7v/c7qV
	m9oJyiPNRgCZmmAZyimKVSdEvqtifEJw7unerSWTNQC06Af+y4wdluyVhB5mZ2hr07vUshfW0Ep
	qu10k=
X-Received: by 2002:a17:907:608a:b0:c17:40e5:3d75 with SMTP id a640c23a62f3a-c1f1edaa13emr304274666b.16.1785138810959;
        Mon, 27 Jul 2026 00:53:30 -0700 (PDT)
Received: from NB-6746.. ([188.243.183.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1c32ac0fa4sm596226866b.20.2026.07.27.00.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 00:53:30 -0700 (PDT)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Artem Shimko <a.shimko.dev@gmail.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH net-next v4 1/2] dt-bindings: net: add DAPU Telecom DAP8211R(I) PHY binding
Date: Mon, 27 Jul 2026 10:53:23 +0300
Message-ID: <20260727075324.3555446-2-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260727075324.3555446-1-a.shimko.dev@gmail.com>
References: <20260727075324.3555446-1-a.shimko.dev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device tree binding documentation for the DAPU Telecom DAP8211R(I)
Gigabit Ethernet PHY.

The PHY supports TX and RX clock delays in 150 ps steps from 0 to 2250 ps,
with a default of 1950 ps if not specified.

Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
---
 .../bindings/net/dapu,dap8211r.yaml           | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/dapu,dap8211r.yaml

diff --git a/Documentation/devicetree/bindings/net/dapu,dap8211r.yaml b/Documentation/devicetree/bindings/net/dapu,dap8211r.yaml
new file mode 100644
index 000000000000..ba9b301ea1f5
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/dapu,dap8211r.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/dapu,dap8211r.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: DAPU Telecom DAP8211R(I) Gigabit Ethernet PHY
+
+maintainers:
+  - Artem Shimko <a.shimko.dev@gmail.com>
+
+description: |
+  The DAP8211R(I) is a Gigabit Ethernet PHY with RGMII interface,
+  supporting IEEE 802.3az Energy Efficient Ethernet, IEEE 1588 SyncE,
+  and an internal packet generator for diagnostics.
+
+  Specifications:
+    - 10BASE-Te, 100BASE-TX, 1000BASE-T
+    - RGMII with configurable TX/RX clock delays (150 ps steps, 0-2250 ps)
+    - IEEE 802.3az-2010 Energy Efficient Ethernet
+    - IEEE 1588 SyncE support
+    - Internal packet generator and checker for link diagnostics
+
+allOf:
+  - $ref: ethernet-phy.yaml#
+
+properties:
+  compatible:
+    const: ethernet-phy-id0008.011b
+
+  reg:
+    maxItems: 1
+
+  rx-internal-delay-ps:
+    description:
+      RGMII RX clock delay in picoseconds (0 to maximum).
+    multipleOf: 150
+    maximum: 2250
+    default: 1950
+
+  tx-internal-delay-ps:
+    description:
+      RGMII TX clock delay in picoseconds (0 to maximum).
+    multipleOf: 150
+    maximum: 2250
+    default: 1950
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ethernet-phy@1 {
+            compatible = "ethernet-phy-id0008.011b";
+            reg = <1>;
+            rx-internal-delay-ps = <2100>;
+            tx-internal-delay-ps = <2100>;
+        };
+    };
+
-- 
2.43.0

