Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C343A7593;
	Sun,  7 Jun 2026 12:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780836873; cv=none; b=X7zUpcUzidn1uee1U4CQBrJQflcOxrllbPlHIVxPExc09ZsUhGRearZM7X0aBamV+draugtySmvi5E683D3FR4gPe2PTUT1B4kzifZ5wKpunQIAtNye2CF6zU1YmRucg/pxdLH/Hc1XlWv4AvjiOY8NmjyY816TBTTResj0jTho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780836873; c=relaxed/simple;
	bh=4wQNPUWXFpoaMyCnU3Ng2pdzGAiqrwUv9ZOVPYQeo7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ad3TazT4iSRDSuXnLTeg6UXDjLuEFqa5iN++iJjW51y5OViW9NINRn/z/ORiJBdooyC6sSKPhnAePWyCdNeh6yroKcNkxf8TmeQufO8mnd2uG3Pi67PlFNwEwfSIJ3SIcb5/gBk9Dv2PfLixdLd2UwrcECqJEJkvG+77ALULQvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=fFI+YH2v; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="fFI+YH2v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1780836864; x=1781441664;
	i=markus.stockhausen@gmx.de;
	bh=5JhzjXpRM1EjlvKu7qYvP4IYMuteQ3cwK3cK0bg6yF8=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=fFI+YH2vRFt6y67veOOfYwAb/rCvBbumTwbqorSgNrzll5hjnkNYPwZVHb9z815v
	 GRfj6Nnnz0Vo2RuG3w2n7FL8F6+mmQnAYGHzewZLKNdsKRO0UyBsBsFPW53RDsEf2
	 Rtx5TEF5O5r/mVaoNoCanzF2BW7Z2HVKJCZiiYD+VBZs1KcNvp+C4KNOcsnwhlCBS
	 PJoIUNvWKz1QIVbJA4r7vTsBj8tPJQo/9ffUTkUXpT0h9mZvftiWiANiqSplE48Jl
	 N38k3CRP3167Ug2CGwsbTFvfDscEqK6n+nW6JY9x5v2SB/x1+q3o5EFgckjvWORC+
	 4jmQeNkLAE6nmp91YQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MPokN-1wsQjr0WSB-00QZKJ; Sun, 07
 Jun 2026 14:54:24 +0200
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
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>
Subject: [PATCH net-next 1/5] dt-bindings: net: realtek,rtl9301-mdio: Add RTL931x series
Date: Sun,  7 Jun 2026 14:54:02 +0200
Message-ID: <20260607125406.2853607-2-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607125406.2853607-1-markus.stockhausen@gmx.de>
References: <20260607125406.2853607-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8AIGQ7TzqW+hkf5gWl4UbcSJGbCHjEN+w//XYsuGSg+ssvqDcCt
 zSh+GJXiK3GnUrD5eJPLRqkfFo7UkZ1AiZ9PYmi6/C7GBuNkJd1ypaMurmPlRCvS2LAOmRE
 iDKmxKlISImuk2TSc9SnGzih8nwHI1wgkc1+oTc5IrjygXlz9aRVcR9GoluODW8tTNDxZTV
 kaqQOBpqzj9Im3CWSGcvw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NmIF/+OD2TU=;VLAkhj5LbbOufunPgJ5IlsiDG9Q
 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

The 10G Realtek Otto switches are divided into two series

- Longan: RTL930x up to 28 ports
- Mango : RTL931x up to 56 ports

The Mango based devices have 3 different SoCs RTL9311, RTL9312 and RTL9313=
.
The MDIO controller of these switches works like the existing RTL930x
logic but has different characteristics and different registers. Add new
compatibles in the device tree.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 .../devicetree/bindings/net/realtek,rtl9301-mdio.yaml       | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.ya=
ml b/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml
index 02e4e33e9969..494c92601e09 100644
=2D-- a/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml
+++ b/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml
@@ -19,6 +19,12 @@ properties:
               - realtek,rtl9303-mdio
           - const: realtek,rtl9301-mdio
       - const: realtek,rtl9301-mdio
+      - items:
+          - enum:
+              - realtek,rtl9312-mdio
+              - realtek,rtl9313-mdio
+          - const: realtek,rtl9311-mdio
+      - const: realtek,rtl9311-mdio
=20
   '#address-cells':
     const: 1
=2D-=20
2.54.0

