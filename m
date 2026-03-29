Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AE6433AD;
	Sun, 29 Mar 2026 13:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774789698; cv=none; b=VorAxvZ+m/LmukqxNwOluC6xPRFSF6fLm+zdAr+B2rvCvQbOpoVRtWb5D9JYVqhQ4al5kteH4CwbwwRwlCJKUgKVJB1g/UJYl1bYloEEIXbnIdVl+4o6g62mhluBcGkZUcg4X3LjvsLEN1el+3+7qpKBCbSVNDngelklVjgcHrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774789698; c=relaxed/simple;
	bh=hTgXXikirJFP7xdfg6chbsZ4wYHoHGkSlNNMzVO0mHw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W5YMTi89YOjC01Pmfxtm5qhXq0dYnEwpGJYbTW5LXlkaRhEI6JFqjPrBLHYethasXUefy2OJ8StX4OK8afIBE+mRgiCHCKV614f7fdbvS5n9Zea9MqN5cnBV8one8hlgJsGQxWAmLlsrOpQZYhEE88WrDiS4MnRNlVCetHw+1BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=khVKoKKM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="khVKoKKM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC384C116C6;
	Sun, 29 Mar 2026 13:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774789698;
	bh=hTgXXikirJFP7xdfg6chbsZ4wYHoHGkSlNNMzVO0mHw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=khVKoKKMJs8VRYC9o5ByOS4f8JPyun+XFfwhXCqlMaMMphjyMk6fwLOChtIRUo28g
	 c/x+aziHjsbDEoPjDEIDfngZ92dOzEQsLbIZf7pzzhW+NVWYrUhtRMMoKJ9q+I9q5L
	 Fi/DH1VLLcWplGDSsXV6SYiSIXO1X6D7EdLfLxwD6ugc8HxgCQQQFIsiyPUuHjLQYc
	 Cn7mbl/cduRc0wpDNbxhFQ5zfhmOtcXFLP2zN51nirO56wSrKZRJhwplHp40UY3qew
	 aPffdq6YHvIF3l4oxi0kKSqaocmxT/tnYm4Vm6ygw2yj3HZFCR3OKJkJG3axSfN5Ym
	 Wq+0cCH7tu8Jg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sun, 29 Mar 2026 15:07:51 +0200
Subject: [PATCH net-next 01/10] dt-bindings: net: airoha: Add EN7581
 ethernet-ports properties
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260329-airoha-eth-multi-serdes-v1-1-00f52dc360ca@kernel.org>
References: <20260329-airoha-eth-multi-serdes-v1-0-00f52dc360ca@kernel.org>
In-Reply-To: <20260329-airoha-eth-multi-serdes-v1-0-00f52dc360ca@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org
X-Mailer: b4 0.14.2

EN7581 and AN7583 SoCs support connecting multiple external SerDes to GDM3
or GDM4 ports via a hw multiplexer that manages the traffic in a TDM
manner. As a result multiple net_devices can connect to the same GDM{3,4}
port and there is a theoretical "1:n" relation between GDM ports and
net_devices.
Introduce the ethernet-port property in order to model a given net_device
that is connected via the external multiplexer to the GDM{3,4} port (that
is represented by the ethernet property. Please note GDM1 or GDM2 does not
support the connection with the external multiplexer and are represented
by ethernet property.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../devicetree/bindings/net/airoha,en7581-eth.yaml | 44 +++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml b/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
index fbe2ddcdd909cb3d853a4ab9e9fec4af1d096c52..ebbd433e9c9fbfaefd8d07c3678cabc91574d125 100644
--- a/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
+++ b/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
@@ -130,6 +130,30 @@ patternProperties:
         maximum: 4
         description: GMAC port identifier
 
+      '#address-cells':
+        const: 1
+      '#size-cells':
+        const: 0
+
+    patternProperties:
+      "^ethernet-port@[0-5]$":
+        type: object
+        unevaluatedProperties: false
+        $ref: ethernet-controller.yaml#
+        description: External ethernet port ID available on the GDM port
+
+        properties:
+          compatible:
+            const: airoha,eth-port
+
+          reg:
+            maxItems: 1
+            description: External ethernet port identifier
+
+        required:
+          - compatible
+          - reg
+
     required:
       - reg
       - compatible
@@ -191,9 +215,27 @@ examples:
         #address-cells = <1>;
         #size-cells = <0>;
 
-        mac: ethernet@1 {
+        mac1: ethernet@1 {
           compatible = "airoha,eth-mac";
           reg = <1>;
         };
+
+        mac4: ethernet@4 {
+          compatible = "airoha,eth-mac";
+          reg = <4>;
+
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          ethernet-port@0 {
+            compatible = "airoha,eth-port";
+            reg = <0>;
+          };
+
+          ethernet-port@1 {
+            compatible = "airoha,eth-port";
+            reg = <1>;
+          };
+        };
       };
     };

-- 
2.53.0

