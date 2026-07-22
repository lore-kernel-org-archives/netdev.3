Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519D2355F47;
	Wed, 22 Jul 2026 06:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784701455; cv=none; b=uUP/T0EcX5ZDNa4iC73H/XooJdUR8rH2s+ks9nh0FXcLx9lY5Z7Vob1C3b/YeNeyPL0pofBYCIOpSnmaQnVINY996B+m67f7hzD3N4fyg7fUnojFDLhjnI3iDsMehPldfwhcFcCNPQDYn3nTTRRUoqm0XGKvPodGDGPfMjlRaKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784701455; c=relaxed/simple;
	bh=oS1deGpWbv0aRs9fqI1dhb2fbyeKqYOGyeaFnlu1XEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DM1XhXY4MMzlfs9dmuXNdIx2UARIsZeExGYOjhygjs8gtWsIPPSSgnBUKdTg9kS+VV/Ls+msY6oRqbZwmSe4twKYNsG+I7ANcU4/lPEa0P0JQU7mWnqRlkv90qYAX/XRs3BARNVFLK07owshd+0q5zpoSHz1JbdqFctXU29gxO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=Zsi96jiF; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="Zsi96jiF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1784701447; x=1785306247;
	i=markus.stockhausen@gmx.de;
	bh=3xL44Jm9Fv+EhjWNody2SXJwPnucxL2M+ILdbbvUKV4=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Zsi96jiFGGQFxdab0epvJI/NaVEExLxCfV7kLnYA+jkVoeoeNCLMcUB0gFqpC7ra
	 dGpA9Vpnqk0l6OVKX8QnTUaBRqRzzMdnVyIE04lvdr3GNWXVc+aVZH+wpyhGpFYHs
	 FnabtrnqxuLeMXRcGzK8C4lU6kBOiFZab5t/QlhM2vWBfF1eXSipJZomNWgVEhHXO
	 UQe5LmJQp7xDi/vabMfRgRoZjkdHmpc0yKoHIDRFMKoPP0HXfzpvf2cHbfO87Ymwg
	 KHtnpaZcArpIpcPYRnemhb5gxYrzsPoO0XCVQJwdvLNltuwKsFzepa8MyieykF3Lb
	 h7vreeaWw++pqRVnbA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MFbRm-1wlrtB1l2E-00DmWO; Wed, 22
 Jul 2026 08:24:07 +0200
From: Markus Stockhausen <markus.stockhausen@gmx.de>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH net-next v5 1/8] dt-bindings: net: realtek,rtl9301-mdio: Add RTL83xx series
Date: Wed, 22 Jul 2026 08:23:49 +0200
Message-ID: <20260722062356.12291-2-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260722062356.12291-1-markus.stockhausen@gmx.de>
References: <20260722062356.12291-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LHQMtwLAViGdL8/79S0MukB4LZ2l272nFgUU2hxmjL7cErHomKO
 7nvUr70vWNoqH46k9O7p4o7AuYpjrCMKtsWNwAhATnKhoBpbOE/hwmkp2VCkgjkqaxd/TgN
 /Lu9PHlnBonSp0GF+ePf2yzr4qNUx2EIHOq3iJT3H/eud9G0EI0doh0ZSrnFGVklTxTN2RK
 4npjZ/7tOKueU4Sjj8EQQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fZnqtj2gOfc=;Pt+EtX98yXRDa7AYeugdtFljBvm
 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

The lower end Realtek Otto switches provide 1G only and are divided into
two series:

- Maple  : RTL838x up to 28 ports
- Cypress: RTL839x up to 56 ports

The Maple based devices have 3 different SoCs: RTL8380, RTL8381 and
RTL8382. The Cypress series consists of the RTL8391, RTL8392 and
RTL8393 SoCs. The MDIO controller of these switches works like the
existing RTL93xx logic but has different characteristics and different
registers. Add new compatibles in the device tree.

With the extended compatibility list change the title to better reflect
the scope of. Especially add the "Ethernet" tag as these devices have
multiple MDIO controllers.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
=2D--
 .../bindings/net/realtek,rtl9301-mdio.yaml         | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.ya=
ml b/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml
index 271e05bae9c5..67e0b23a8470 100644
=2D-- a/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml
+++ b/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/net/realtek,rtl9301-mdio.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
=20
-title: Realtek RTL9300 MDIO Controller
+title: Realtek Otto Switches Ethernet MDIO Controller
=20
 maintainers:
   - Chris Packham <chris.packham@alliedtelesis.co.nz>
@@ -12,6 +12,16 @@ maintainers:
 properties:
   compatible:
     oneOf:
+      - items:
+          - enum:
+              - realtek,rtl8381-mdio
+              - realtek,rtl8382-mdio
+          - const: realtek,rtl8380-mdio
+      - items:
+          - enum:
+              - realtek,rtl8392-mdio
+              - realtek,rtl8393-mdio
+          - const: realtek,rtl8391-mdio
       - items:
           - enum:
               - realtek,rtl9302b-mdio
@@ -24,6 +34,8 @@ properties:
               - realtek,rtl9313-mdio
           - const: realtek,rtl9311-mdio
       - enum:
+          - realtek,rtl8380-mdio
+          - realtek,rtl8391-mdio
           - realtek,rtl9301-mdio
           - realtek,rtl9311-mdio
=20
=2D-=20
2.55.0

