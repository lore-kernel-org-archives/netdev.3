Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD49F47F3AC;
	Sat, 12 Sep 2026 13:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789218323; cv=none; b=nTnNAsv2L1w39kaSqMxIZafxQJ20HeezjnB4s/+acPCNT0FOtROLyWtKa4to5kS9qnmFEdeJkNhQF6zB3OeJMrof5DwSQlWGDsVgYjFXmWa9lKDVJm075dKrSJ81N6Zyfg/3MLXFbk1236NstOdM3Hh/1KMQd7/L5EovCULtXZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789218323; c=relaxed/simple;
	bh=P+F2ehqRbn9Qpv96yBEzzs26jdup7/DUpQyTie41OCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qI5hi3hKzRhMGAgbpsEvN1a9NlXa9tfaMBx7v77nMKpVgo/tM4Qq5SMx/9apJV7M1AVnMEfe+Q6zsl67mp13zMRTOCiTyvRX9f2LdR9eCdNBiyk8aGRIUw6KvrduXHUQ9yOJzeRHyz6WG+NVwCqAXQ7cVRhTUmahchGFqiF7FUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=l4GaRQhh; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="l4GaRQhh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1789218308; x=1789823108;
	i=markus.stockhausen@gmx.de;
	bh=PS7Y6ZDcQL9R6KdTkLqZfUGrepUDv4deVC+qJsVgn0E=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=l4GaRQhhvWYXXAlbWyusyv7RBPquLo8qS8NKWvLxSiYsBpSjPiLlU6Hbr8EyVfVc
	 vMpJUq95uPmBVlgBJbP+D9cA7TY2u/6uU3/luJTsjIHuZYWcAVScO9Q93MaIDeVoU
	 bdrY+tAG+ajl5/A+5h8l0iw+qMjOPmsWz6XUxZT+XFgdhtGrIeTtR8zJ+R/g9d+Bq
	 vPtdgI2vpxBxmyFrYRW0NqwR11m+9qIhMd4r8VFvMe7cO8RUls13PXlrCgDqtfEB/
	 ciSOGAYzNuZeyv84qrLnUByEpTxZTl4pqDhl4ac5ZLO/tPvqu4oNcsD3O5BCoyc9U
	 CU5DBZNKHInuxDa4DA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mqs4Z-1wRh9p2eCv-00nh14; Sat, 12
 Sep 2026 15:05:08 +0200
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
Subject: [PATCH net-next v4 1/5] dt-bindings: net: realtek,rtl9301-mdio: restrict MDIO buses by family
Date: Sat, 12 Sep 2026 15:04:47 +0200
Message-ID: <20260912130451.3757276-2-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260912130451.3757276-1-markus.stockhausen@gmx.de>
References: <20260912130451.3757276-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bHo3E9DMkatRmfmoUd8HbyG3n1SN7uNR3V0an/zFBd3T5DuTfmC
 iBvndgyV5CIA5drtvu0BQO5A7964edng3Y7Wpqz8eFXp7IGqHImVPa2JxfkOFH9ZMKXI2nA
 DxFiFWqUnBya/bEqud3IPtzvsU3ZxWJOPidjOn6msKqtLPQX/l8P0B16d92a9QSf6siRSdx
 UkqicIlx80lMaa8JZN+zA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:G3IIqtJEDag=;auEnuRGAPFn31p5FLFg8zqUmDnD
 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

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

