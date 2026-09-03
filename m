Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497DA445ACD;
	Thu,  3 Sep 2026 12:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788438105; cv=none; b=SGsJBQ+y90glG0s0capJxJXPUoC5nF+IcM8i6tpmihaj/UqCpd1KUdud4QisijJL9opfYK+oN6mLg0jj2AsfbNG3gltZN5mSm9gAhwJhgWUOMKo9dzPVFbYRY73DwjOASP3rckp9CptI+CNEL7A3BGTh32yoM7eNT1QmaPnt9Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788438105; c=relaxed/simple;
	bh=o/RTUCvQtTl7sbNqhRG8RwPocXT0ppEQ7iWdZiYFRF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UUqzkWM4Pw99vs/8qUodNlE4I9vA8tuHQJkHfsKPzAqaEEYyuHhoS+EYXZCKnpzE3Iwe46SL/vyL6Yl848UMXfBmZDK9WQZu9Rc5dSDVFUCvhfAOoCXoS4GGXkwknN/lY/PFlzB2oi7Rw4yiMVxpwEkJfE5Y/PjijGDI8NAMwso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=YRY8AUyR; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="YRY8AUyR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1788438094; x=1789042894;
	i=markus.stockhausen@gmx.de;
	bh=ad026QSM3X9cLDKE3jMLKh+rIwLV5cvMrKPTerO1RPQ=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=YRY8AUyRiV9VYNZd1syTtdm2blCks9V/09EnbnclQ1/jCtljlAJlP9zkgS374uUF
	 LG8j6SDFPn8NukeQW/HuBNZy7VP+V7AXPauaufM7vrGM8fVlIUlhlv41b+qIZjT12
	 K7p/gGVk5mfK2nvqZo7eep19mqfzBConHPn7u4/Oqni/w2zwRlrZXMFBqtrVeX+jj
	 gneuwMxKtPTyAvcbsH5CbBRGcCRML4RdJPJUq3j1giX/5PfMq9WYZY0jb5gbAvPot
	 xNSu0Y6vJutYQsVL4OjJ56jtHOvtdBuAxyltKH9Qw7DHv2vA9kUepPncx0rn3Ocm+
	 RTmHJPh3DgNtKM4KWg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MacOW-1wROqa1laU-00dSl1; Thu, 03
 Sep 2026 14:21:34 +0200
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
Subject: [PATCH net-next 1/3] dt-bindings: net: realtek,rtl9301-mdio: Add clock-frequency
Date: Thu,  3 Sep 2026 14:21:17 +0200
Message-ID: <20260903122119.2638354-2-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903122119.2638354-1-markus.stockhausen@gmx.de>
References: <20260903122119.2638354-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GYSf195NhoryiJ72D5305UiOYuYlAnSsLLX2vVUKGMjLAht/aft
 xeAFotuq95Z6ziRVinLfQEIXIFUfssnzez26dENwS7c++S4g3XNYH42cWEQQ0pLLQyxbkRZ
 BkeUlc19B47DzfOZ1bdXzq6C6TJtA3d/ftat6/M6ZIzkL/Cjx2ZlWOH5B8rv3qTNr58bB/+
 WZxskfpdWn1UhFhxuiqkQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BKx+uyF1BwE=;l5FEYYStezD0kqxlaSOGfEhsjzu
 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
 G17DxI8YWUvbRw9gXBVP4fHjEMc2SVE9

The Realtek Otto Switch ethernet MDIO controller supports different MDC
speeds ranging from 1.25MHz to 10MHz. Document the clock-frequency
attribute for the device tree.

There is neither an offical documentation nor any obvious registers that
indicate a dependency to one of the hardware clocks. The usable setup bits
are more like hardcoded values than dividers. Without further details do
not add a clock reference.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 .../devicetree/bindings/net/realtek,rtl9301-mdio.yaml          | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.ya=
ml b/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml
index 67e0b23a8470..6db3315ce96b 100644
=2D-- a/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml
+++ b/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml
@@ -56,6 +56,9 @@ patternProperties:
       reg:
         maxItems: 1
=20
+      clock-frequency:
+        default: 2500000
+
     required:
       - reg
=20
=2D-=20
2.55.0

