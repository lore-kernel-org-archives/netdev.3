Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0693430E83D
	for <netdev@vger.kernel.org>; Sat,  7 Feb 2026 09:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770456345; cv=none; b=W1cE96kNA1CJyzyfnTIWodu0SX2JiTG8JWicocO8jvy+9xhLo7ULPywk2mqLqJ2hgccGEPrcXJqL3AUgWMNjXD/vHAQwiQ7sqrYzghgPS/GxmhXCi9BWXu0BNKcEQBbrl67rmMkDrfrRdoBsqrOubtp7Jm2F2sK9R8vmzxUqOpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770456345; c=relaxed/simple;
	bh=hJ1l789RsEeMkktHF58F2aSO9tx6XIcoj+qB0zmuang=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oKkz//laXKRZXFuDs0KdS+v63wCIeQNATlYlCL6kuGcDfQ52nylnJlc4QDfw8w+PjKyLeIzfFTOFBv9dneuoVfv/FVyUhHXD+SILa9DaUHZAWHWTtxbIh4ch4HPYNelCDIdNTgJBXMmAIdjT6Hd8Z3Spghysvl0o6TpZ+IPW1so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=We6OdlAy; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="We6OdlAy"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4806b43beb6so14058195e9.3
        for <netdev@vger.kernel.org>; Sat, 07 Feb 2026 01:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770456343; x=1771061143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PEIQmFNiAqTJVNLjePK2g3dQ+ZwYNFMoN7rZHrRTv5k=;
        b=We6OdlAyP34nwm5DLG0Q2OS6tRWMw8vrT5IT8gmFnAfFY8tg8EJvdMj4ne6kfRBIAx
         +Tal/EqmwAbBkwBnxI6JdU+Wr16gDFKiZyxS3t1FjlGLuxbqq9ulN72fc+aCXGvYkUR+
         4ToVwUMvBtFaehmpEOmlNOWQddPfaXxYsOTpkxIRAsRsbQUUHAsAoU7UDd7TcCIho4or
         PEjzgj/ImAlKQloZOkR8tNavp1iq7b808MRTxtXmDqtlHKSCk1hyPoTyJHDkkaD6LE2g
         nOY0lUIuMaggRjICIJzVRN3zMPo94EWsdpeD5K0ehU51aB15ADJkNcUA9JXdECS0UAQl
         84Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770456343; x=1771061143;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PEIQmFNiAqTJVNLjePK2g3dQ+ZwYNFMoN7rZHrRTv5k=;
        b=keL8dHRsn+4FNh8rH6uY4/RnGsP/4hJHZ4/q/78SWU9vYcXPJrqNgORdoLGiOQLvAr
         gjc6zqOxzOCkGsZXokGCwYy9WYXnRtyUkvTjjAY0WVAE3fXCvqX5EUhBTLHav5P6n5IZ
         rYuH8i17jS5sMQ1eq+mNqwNKYTDJuWmAm7IB4ULOkpqWn58HtuF2qLbygci+Q59esYnZ
         4LGjwDX4eFPP21s7cIWF/bVEmGh5TI3Me5ZgU52chXcHbkbhoolo9R3HTLdmB6W0MEWi
         PPiIFzamVSqWSY3XElbmMtn39ZDkHQ7lhtCGhyxvdzmIrNlh4sTCmEK61KBciYku05ay
         3NQA==
X-Gm-Message-State: AOJu0YyIQeUc1REP57TtPp4SmvmvG2D2rnzor8tp0ZwQV1UABHqA9Sid
	SuYUDdVsCHxof5zsenpwRVWWCXQdpKKm++0EFyY8TVUYJLn63Xt7ryfq
X-Gm-Gg: AZuq6aL34nXi0Dxys0ZD/hfRjdo0jDtuawLICfvpfa3986zw90gporClZvpTmQyd0ND
	tFtzSgJDfx3bKiVUAIvAlQ3qKEY4RTS1Zx2r2PoSQB6+CoVPaHYhpLiO5auwIcprynT5chHHmbk
	d/9u90dulzdp6UEiDA3NguNEa3BJoZZK3KzhczOS7iYbav5uvLhu4shQ4LQbldM8GClNVeIaVme
	BhhnDNUXSxMAMd2X5cakVV5n3fM9i0rbcVq8PNkls8zxsbpr5TOpknq/mMB3H/CqfjRlzVdowGI
	9A0ULngQ91a6oNNoX9UzvbMg4IbFk4tdbkP+lZJOcvZ7V+Ezx/PFrmQZBg3NxhXOQiKRcaAQQHL
	AmSjaZQPuImBFH5IXpYckO/aBMvFyKOGUyPTRmhDwhNvUaMo2MNnRFoApeUR4by6fbUPYlY34Gs
	UBJ5LSpbSEGtQ=
X-Received: by 2002:a05:600c:3589:b0:480:4a4f:c363 with SMTP id 5b1f17b1804b1-483201e4022mr81467635e9.9.1770456343103;
        Sat, 07 Feb 2026 01:25:43 -0800 (PST)
Received: from nas.local ([2001:912:1ac0:1e00:c662:37ff:fe09:93df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48320736953sm101034545e9.15.2026.02.07.01.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 01:25:42 -0800 (PST)
From: Damien Dejean <dam.dejean@gmail.com>
To: andrew@lunn.ch,
	krzk+dt@kernel.org,
	robh@kernel.org,
	kuba@kernel.org,
	maxime.chevallier@bootlin.com
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	pabeni@redhat.com,
	hkallweit1@gmail.com,
	Damien Dejean <dam.dejean@gmail.com>
Subject: [PATCH v6 1/4] dt-bindings: net: ethernet-phy: add property enet-phy-pair-order
Date: Sat,  7 Feb 2026 10:25:36 +0100
Message-ID: <20260207092539.647768-1-dam.dejean@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add property enet-phy-pair-order to the device tree bindings to define
the pair order of the PHY. To simplify PCB design some manufacturers
allow to wire the pairs in a reverse order, and change the order in
software.

The property can be set to 0 to force the normal pair order (ABCD), or 1
to force the reverse pair order (DCBA).

Signed-off-by: Damien Dejean <dam.dejean@gmail.com>
---
 Documentation/devicetree/bindings/net/ethernet-phy.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
index 58634fee9fc4..4a27547f7d7a 100644
--- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
@@ -126,6 +126,12 @@ properties:
       e.g. wrong bootstrap configuration caused by issues in PCB
       layout design.
 
+  enet-phy-pair-order:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1]
+    description:
+      For normal (0) or reverse (1) order of the pairs (ABCD -> DCBA).
+
   eee-broken-100tx:
     $ref: /schemas/types.yaml#/definitions/flag
     description:
-- 
2.47.3

