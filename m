Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793816477;
	b=AI+IImybzNq5jV0vvG+EfvMqccNa7vtsKrXCxarXtuS5g12YFo8GkKZzHBRu/EzJRaxq
	 eephc/p5qrkaVbihFNEbQj322xweNN150Fybi0sH3e9qYTmrg7/xXoJ5RZEXVUXGZrpL5
	 69VxcoFyaBO4Z6yPjEB0kVb1yJqumq/VbH+KeNUzk/2vuzNpb6ZAr+CQxehm2n3XOELz5
	 8PuQqKzGbVXq18GZKY8ppOL2wH3DQ02iWcuEjaGKiEgxdF/67bos5OQX4jDUMxQ2QNM+X
	 pFn22xQgzJHoM1hNjZmPjgu6gM4iYb6FnqRMX84HjbQnulK8y09HAxSFxmfTP9h5ZmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793816477;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=3KWlsc/MZRnBDaOP5Xm04uDW6oFxIqc/gzrmAKgcexc=;
	b=Jyrj9PLtQ444SlTasjHA94yyjlszbLcGxA5krfkiWaSJlPXmFoylsy+YRGbG6tMhNdKk
	 N45QFS06vkqo0IgtS18h2/dh1dNkBo00/jSfX9Ha27uCpjGGszxyF32R17XebxgNaR0M1
	 hV2QSfVLWR9V9p+xiDeYhHbh1X24N3YRRxdwBiVG2HTxS1n22+d+bUVV3zAVRM9EgZTuP
	 3L71zoSvOGzSQcB3Nuw0fVrTB1aW154it5ZgXCujZZ6CZ0l3n5FqnpJh/Oa/9ch2f8xGF
	 0JJAeKDQS27CPT2n5LO2H9edwo5j+O4qZT/edEyTBGILNKhynSx8/dbpdrYVboJCNiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YyCqQvQu;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E212606EEBA
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 18:21:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E212606EEBA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YyCqQvQu
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a2069b9710so9427005e9.2
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 10:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793816475; x=1794421275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3KWlsc/MZRnBDaOP5Xm04uDW6oFxIqc/gzrmAKgcexc=;
        b=YyCqQvQuEYo69t3a9xwwzjVfNUuHUWilbjAWINrDWWKi1yamWhH8BiItOVbO4H/yWm
         XSZBQ2gJ0ztDtXDJ3kBFKhq95utIIsNeoXGheZdoEThPVP410gnp25KySXX0fvnEuLPw
         lI2xPEh2Cz0X3q/CE1csWfQxcKdNYonViM3NqdI8b/DSDfd0SqWXuDVXfrLiiibzQtS9
         9cljp0HmqiZKA/8GY/P9NudfMlhL86Bv9FcxR06wZwVye1DE7XPcy3vRExOBaVOyGegb
         96ROIWvAJFo1/+4z+PMFXlWBJ/ZmAgRSprxXrkqQv5kWvz+KNevuW9Koc780rFGt4KDF
         AUIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793816475; x=1794421275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3KWlsc/MZRnBDaOP5Xm04uDW6oFxIqc/gzrmAKgcexc=;
        b=aHfuizL3Et2rSh3pCGgx9H6JxSE+rXOCJDktBdiD+Uko6Ti1uAFd0FfZ/RNh1qbIWb
         A+Sp25fjZ78Cod1nK3AIy67B+fM8ryGYbuCNEKpFF3JbanHeOU4oeWzq37TBLluFUW+4
         0UjDAYLp7wouBFQ0ypym+dia5migATcLxp0It5SDs2RYfmgonUf0LhgzkXA26CRCLt36
         a63sqQtL0xiy8m46mav/uYD9aVVju7uxN8tm6ei/4ku3yt7O+X1TVOfm6eaHisJjAOxp
         VbyFuAofRiRCsT8rLzHMGzZ9dZ3mlv7mGL7Ti/CNvR5TkrUqP9vHMTjgT/JkqmYxtECz
         oAnQ==
X-Forwarded-Encrypted: i=1; AKwUvBxz2Mv+XQax3LjCkp/C1CitbKP77dLBsqrNrJ8o3dDdAcLmpNETDgzyxVPcDvFEkCapCT1tDHY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Gh1II1KT66YWFDfX/Kx7g55gFf6hl5owb3ZQMbjJmOCgX8NbH
	6Z8gvoKzW0TtS1W+ps7LElBw/zAj+1ux19/1PWALfoR7763wKRrZwRj7XwjmSLVV7K4=
X-Gm-Gg: AYBFou0ULTO9MKHv8RmCm5Vya/Dqi1IPdy6HqfAWlaMCuN3qLmAwel6en1mWCf326X1
	Ql4/m/dKK9OtVO4Uc1kcGwT6mLCUhlM/Lnkvepq5TlkqsOoYdTTe2oOQatW6QIekKBaWjRMIOwi
	PW4m0B1mB8NvKR1BAUjVi7RyjtoTGynv4MLU9fn6jhZSf8mTjK0ABz4nIVS8Rk3+w5fffSJaAyb
	H3f2U+iSryEnXXvbd6FQk5+KRuwNYfQBfw5MNwNLJrCGq3w3GwLT1fjcxwbTAZ19LRd8wsH4sSJ
	DK3HGvjEgFuWRWKPLic+PC8Vc7bmluKbNQeMvVw6OwgSgAKc/VReUFfWNwzhtY2u2354BhJ51X9
	Nxb4bTR4PWnTagFL45AgZWmWvUNLmgs9eayxsMA0K7f6Xe9YO9aHovXHjdE7j+l57vSMKLNh8Ah
	jW9HeXmR+kCghXZfKJ0NPMnpoOTwTThyaUaemUC9ctDBVPmIDnRr7M5qCDXZqAUBixhXW//TZv3
	TL2WJfSX2Vhf36kM1kgeDiqTpjGgQ5astcvwONVBVYmfswSMuhREycpGgzV1TffOdl7pYtUkX3g
	5aAR6wuLllQgHrqAMjIDh5bnFwDFSHTdZse625Yn1aoEKHwhPXLJ5NChExLkIFazx99DiMWqbbq
	zKD71qx2WqN34QzrkHwCZioEAByK1zgEHBlR37A==
X-Received: by 2002:a05:600c:628d:b0:4a1:9663:7633 with SMTP id 5b1f17b1804b1-4ac17d16b99mr372467265e9.11.1793816475506;
        Wed, 04 Nov 2026 10:21:15 -0800 (PST)
Received: from iku.lan ([2a00:23c8:254f:fd01:b079:a2f1:caf7:b446])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fed0844e2sm4073202f8f.28.2026.11.04.10.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:21:13 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@linux.dev>,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Russell King <linux@armlinux.org.uk>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH net-next v4 03/14] net: dsa: Kconfig: Expand config description to cover RZ/T2H and RZ/N2H ETHSW
Date: Wed,  4 Nov 2026 18:20:51 +0000
Message-ID: <20261104182105.1102555-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104182105.1102555-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261104182105.1102555-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Update the Kconfig entry for the RZN1 A5PSW tag driver to reflect that
the same tagging format is also used by the ETHSW blocks found in Renesas
RZ/T2H and RZ/N2H SoCs.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v3->v4:
- No change

v2->v3:
- No change

v1->v2:
- Updated description for Kconfig entry to cover RZ/T2H and RZ/N2H ETHSW
---
 net/dsa/Kconfig | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/dsa/Kconfig b/net/dsa/Kconfig
index 4f44bf3ede23..88e181ad4cc3 100644
--- a/net/dsa/Kconfig
+++ b/net/dsa/Kconfig
@@ -188,11 +188,12 @@ config NET_DSA_TAG_RTL8_4
 	  switches with 8 byte protocol 4 tags, such as the Realtek RTL8365MB-VC.
 
 config NET_DSA_TAG_RZN1_A5PSW
-	tristate "Tag driver for Renesas RZ/N1 A5PSW switch"
+	tristate "Tag driver for Renesas RZ/N1 A5PSW and RZ/T2H, RZ/N2H ETHSW"
 	help
-	  Say Y or M if you want to enable support for tagging frames for
-	  Renesas RZ/N1 embedded switch that uses an 8 byte tag located after
-	  destination MAC address.
+	  Say Y or M if you want to enable frame tagging support for embedded
+	  switches found on Renesas RZ/N1 (A5PSW) and RZ/T2H, RZ/N2H (ETHSW)
+	  SoCs. These switches use an 8-byte tag located after the destination
+	  MAC address.
 
 config NET_DSA_TAG_LAN9303
 	tristate "Tag driver for SMSC/Microchip LAN9303 family of switches"
-- 
2.56.0

