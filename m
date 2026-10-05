Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCBB32B116;
	Mon,  5 Oct 2026 07:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791186590; cv=none; b=unMR23acMU4GbnVF/IueqHtJBmrGJYluEo2udA6USqyRbana8azd9/dNlrJ+oYFky7DbhvZhsUftJvpMYmnepD21Lq3Yi2fkajbyLelx9vpT4Foru0YSo3pji4rkMGpFJzMUkC3Z2Iby4DtIQul5Vqdu0v6GIc7+gDTvqBHc3Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791186590; c=relaxed/simple;
	bh=P+F2ehqRbn9Qpv96yBEzzs26jdup7/DUpQyTie41OCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q/4NCNG2dUyGZdSSYSt6PHh4zdHqnLn13c4OaFSpZToiNNCz8VZH3JaC+OfdrkKETxi8PFpz/1A5vduuMiXtowwPkelueM2J0M+cMwCLWIVfmHmdHyUBiYMlpF+eEn55RbwoSrklN1rKjVECCQfk/PFAK6Yhqab6AsTaqEYCPog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=Gh1NCDFN; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="Gh1NCDFN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1791186564; x=1791791364;
	i=markus.stockhausen@gmx.de;
	bh=PS7Y6ZDcQL9R6KdTkLqZfUGrepUDv4deVC+qJsVgn0E=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Gh1NCDFN54WcxqFIP1FMjOXlYnnlkX4d8/OuhYfCe7a9Etx1p54q8PC0FI/HVtYB
	 tTx0q0XorQ86h/RqsI3MMzzU4V2rMyw91inYvKxwBXUEms2MlQZDcrfPenioMaKU1
	 t1SBze7aj7i3JJwwBZG3y9KiYpqqcEvgy15rryeK2BslTJq4t2LP+0O6AJFbGhEzt
	 ZSAgj4f//4Q3Ww0zg8yI1qmOdsRk6TEOumJRzT2BFe7uvjwBqn41BElnt52hRgvTx
	 Yzkh9LYqPPFMJK7RNXC3qmENbypiiz//za2yq/H8jhrP4AX8QmHVWi0L4+64Bb2fc
	 7PlZTuEr6fdKhWBH5w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mzyya-1wRpis0WM2-00zD2T; Mon, 05
 Oct 2026 09:49:24 +0200
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
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>
Subject: [PATCH net-next v5 1/5] dt-bindings: net: realtek,rtl9301-mdio: restrict MDIO buses by family
Date: Mon,  5 Oct 2026 09:49:04 +0200
Message-ID: <20261005074908.1273383-2-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261005074908.1273383-1-markus.stockhausen@gmx.de>
References: <20261005074908.1273383-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8K6Zfj/por4fcEWvkvpe9+c0U5g0U3RS9RC9OHFkHVY04oJYqeD
 lcI1MebtVLMIFwRon1JRwLoN2qg5jXM/mpfi8v4cyozb061pOyQMehzyjkWDvXQIMFCY+O9
 e/kkesLce/Q50nf2NuC5S0Ms0lb3uqrBNrCm2QvRnDVfF2M2ovN26FMNTP6fEIfp4sItGcC
 jghW0cKa7GiuVnr4y7sEA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XuAKvjfj+no=;7VKmFP++x1FDesxDp170Q5GR+W5
 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
 br4yzCbHj0Z2DigHPmOPJAQ9MdmjE=

The Realtek Otto switch family provides different numbers of MDIO
buses. RTL838x has one bus, RTL839x has two buses, and RTL930x/RTL931x
have four buses.

The binding currently accepts mdio-bus@0 through mdio-bus@3 for every
supported compatible, allowing non-existent buses to be described for
RTL838x and RTL839x devices.

Select the permitted bus node names based on the controller compatible.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 .../bindings/net/realtek,rtl9301-mdio.yaml    | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.ya=
ml b/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml
index 67e0b23a8470..7f5b4897487b 100644
=2D-- a/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml
+++ b/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml
@@ -67,6 +67,30 @@ patternProperties:
=20
     unevaluatedProperties: false
=20
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - realtek,rtl8380-mdio
+              - realtek,rtl8381-mdio
+              - realtek,rtl8382-mdio
+    then:
+      patternProperties:
+        '^mdio-bus@[1-3]$': false
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - realtek,rtl8391-mdio
+              - realtek,rtl8392-mdio
+              - realtek,rtl8393-mdio
+    then:
+      patternProperties:
+        '^mdio-bus@[2-3]$': false
+
 required:
   - compatible
   - reg
=2D-=20
2.55.0

