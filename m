Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8822A411A1E;
	Wed, 29 Jul 2026 16:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785340981; cv=none; b=qrrhLuCLAug9Wo9nE9k1I5u/xbBGi4vrNgjAXKvUnAUnXUINFNZt8UWVo1I0WybTvBJZs78InkfGeyAwcihUtgaIh+XPuFzf800jSRr/0RC9+7xIS1VkTAsDgqq6vN2lbGxth7tv7wnLGhtZkNof4mJweN/jrtv+K8BrZ2LFVEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785340981; c=relaxed/simple;
	bh=7XF7MAFcn6wmhhyC+2PeG3mULjc+Z8/NfTpPK7cRYMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KhA6q/HnNnUMa3COYXCDrz4BHMQzbz8rec1B8qFv2n/aMiPbiNzPCQeBVFiSWSZ8eNtiJcUbrWqRcxkrUo+VOOvZLVPlBmpnLDXKdDSuwHsqboj+q6K857zVg8D+405ZAeoNnaRgP+7MaCneUBpYzrB6i0tqLJJuU4oR6S1ZUtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=k9QBUDvc; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="k9QBUDvc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785340965; x=1785945765;
	i=markus.stockhausen@gmx.de;
	bh=/v477jxGFogne2VF+I/GTTEyVDOS7HCOFPYfuuxedmk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=k9QBUDvcsYY/y+nKNl7zaMpfk1Gl0I7lDyw97/76pKEvXCLiCuB1li9H1WNIea2c
	 FMfybFMV6IMLt+oiIqzqmMVDRegG6Y2OgAEdCKm7Z98KKVOb45sEOmHcisOkjAhcI
	 G/tUJ2YRAV8Swi1Yxjd8HPtMzr1Tc4zkEmL2BD1Ib//9xejEsRJHOGG7jy26LgKXU
	 49b6Rko3abpPPTotQL61crdu6CgwbDs/yTUcXKZXzp6nch5UgmYzh+nHMpJMqFkm9
	 YMpCtmaMSUR9KErjdGr2LcDdgY9QiqYogHL3U/dzGNnxxZsGWKsvGIUguwmJpAGhI
	 5gznf1Xs85Lqs5shDg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFsUv-1wjK713opr-006aWC; Wed, 29
 Jul 2026 18:02:45 +0200
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
Subject: [PATCH net-next v8 1/9] dt-bindings: net: realtek,rtl9301-mdio: Add RTL83xx series
Date: Wed, 29 Jul 2026 18:02:19 +0200
Message-ID: <20260729160227.155613-2-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729160227.155613-1-markus.stockhausen@gmx.de>
References: <20260729160227.155613-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lSn8pM3zGjvBsHjspF+ovYXTcTii+nMysyjtEnPDXSOwMygYLhj
 tQpmFHvRGeCbwcSL/1UCAgf82AJMPXeJMs8wJ9741GWi2wmrxNw+j2zoVoYTHzSTPfF5/HR
 1wnuTNsUGfmV+vdtTOFBQdrENxcq9cwjJfikm158kI7ZxGlAg9RLH1qpY+N2WNr2EYwcD00
 XW0Xn/WtKn12sP+lDVPQA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:iFl1MZ21RS0=;pXG+YI+ik0E4F0R4WE5w9+uZGfU
 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
 cv0

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
its scope. Especially add the "Ethernet" tag as these devices have
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

