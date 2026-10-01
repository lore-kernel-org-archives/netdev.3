Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C96649E131
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 13:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790859737; cv=none; b=ELO5j5mXfdALmIeaCGZNxy0Ltn6OpA9Fxs3sl6h9CWh20RvEIvP1CeCmv/xrh12Br1dM3Z2oejZcdQR/PGWdWXcIrIOY3CrAKkagM3N9feD+6xvNiCANklYKd2SK+9Bl9PdSIh5vvhsdLYEp2oACIxZ2hdbnTgdkTEhNS6BRQek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790859737; c=relaxed/simple;
	bh=9rF3ZrItDykjttkz4FfPTCQcsbhicM46S3uAmSs4Vfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nNkWUKMU/qj7cp+XhshzaxKsqv//xkdNDilRPqP8olGrPPE2kuBvJ3IoQZOhjgoN0ZyfxerL9cCnjeJ3Xk0alMNerCD7WTWCyyV/5pPlZ+xgaRELD/TUH1IpljDeGsW1Ynm9CvcKwlPGDLqShrtbFtFV9/RM68JfdKR86ywERWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=kzjS0Lu/; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="kzjS0Lu/"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6350f89so3958941f8f.3
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 06:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1790859734; x=1791464534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PlB//ouJaFs8pbtEqztirI7J+BCIkiQ8y642fBX9rS8=;
        b=kzjS0Lu/3/cMsQSYwWiqfMyodIAvIiCQbyrDx2otILPloKQGoB7/6g+MVKu0DyS9Sy
         W+yaM+oAFtduha4Vz2qc0QKzQQGR1veQqlynoubYqKneJMLMtRSTh20Wy1sFG5CDMm18
         XyufSvHYYRrXIqkrrpNf8vj124mY0Zi6q6C39npQJZEzNJQPkZDPnyjB+cbnIcT6ml9p
         yeHv5B5dUDxFJoUfXKxR9KLk607SomWpYWjNBXl3OQFXFzQSjTMkQlrS7n1NG35fTXxw
         UO3eRxpBgHRTbdkNUojTiRceS+yZ3YgXz7Ux07FTEi4gy9yoD3UjS3Be7Azg6WhwHzL+
         a9Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790859734; x=1791464534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PlB//ouJaFs8pbtEqztirI7J+BCIkiQ8y642fBX9rS8=;
        b=uvETFciMagY3dKQTDKqBAsPRoqFgsnalWeTi8SCrYzlOQsuiiSejAnSh2q8b4Y7vt1
         E4LslV1xb0WOeNlKYGUxLfmvqPU4zqJfKoC0oovy+FoQ280OhxvdNwuyBaW1PNimflFw
         62rXEwK2JAvgJOZORJrndWiwL2H3dG7GX1uEiDnOt/w6L7s5nUz6luWr/1s9opfuf35y
         Zr0RL1t7gSSQNIc3sKAODiiz78x/E10GysX3/Q5wNyDSO2StIg3mF/yxIvNoipTFy2G4
         MSfc9AkJOH7x6eVqX020Ttt6UjDr1iNi/geoDlbYrlxJWWR1nzCnw7TSHO3dcATTw9g0
         /1rQ==
X-Forwarded-Encrypted: i=1; AKwUvByDojskprod5c+odeCOPvQwKn3hMQxL3sr4BaVTP/RXPzXiILLO6JNfvU4nzrWhIDY7sEx/L/M=@vger.kernel.org
X-Gm-Message-State: AFq9FYKH3iHCHGBkJgwc27W8jntb7/VznREMa/aTs4Ah7h6BSHsnZdOc
	MET0ZGqHDpMY//JbJ783Hbz6aDCs46fJDZbIl4jin9AAumlSb/Wf5VfLG8IQSgg1G/U=
X-Gm-Gg: AYBFou3kU+dzvgkBA/C7hsaNn6hYPsmM3b6YEcIYu2iaxcbYrn1qKQJCqbPV9u5xtqR
	HC8wqIi3duV329P5cH6O1jd/uLUhsehVpjnXXLjfcYIB9c0pOw0pDQyHmF6HehQgMjukIuU28Ak
	tHJPyDsh2JL1/AygLFDnkrg2HfXTVOWFloxBl73O5/i5eOATDFqz0+/ThfKCmCzY7edm5lq1tS1
	i4pD7jvG+fIAEjR1YKboK0e3RN+rurLOlSZm+CEXM1ll8zcNNGz1OxSW43HhUTUVn+LKWLFNqxE
	hRUVpZPWSU9aqhWIImjIp4hV8M2/xxtTy0Q94dGjDABDiJkb9obu+hjB/pFbxkdJXkcR6ZMGTWs
	alzhLTX2JDMe3mvGcDnKoNsOEffP2RGN/EdZ5Gk6gWxo+ibkY6cDf4yRBIqu23+uGbpQyMUQHwr
	kr59ul6mohKsxCe1N2yUqiAJR8T6EDTXYWrJ1FMeOk/iFtWTXgVw==
X-Received: by 2002:a05:6000:3c7:b0:48b:a6:61b0 with SMTP id ffacd0b85a97d-48b0254d145mr7938379f8f.47.1790859734093;
        Thu, 01 Oct 2026 06:02:14 -0700 (PDT)
Received: from remote-01 ([84.17.55.224])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b06a2cd0fsm5568155f8f.30.2026.10.01.06.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 06:02:13 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Conor Dooley <conor@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net-next v5 1/3] dt-bindings: net: ethernet-phy: add needs-host-firmware
Date: Thu,  1 Oct 2026 16:02:06 +0300
Message-ID: <20261001130208.105558-2-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261001130208.105558-1-f@lex.la>
References: <20261001130208.105558-1-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A PHY can be one that the host has to load firmware into before it can
be driven at all. A controller that connects to such a PHY at setup,
before its driver has loaded, gets the generic driver or no PHY at all,
and one that connects only once gets no working PHY on that port for the
rest of the uptime, even though the PHY works seconds later.

The flag declares that. A consumer that sees it keeps the port and
connects the PHY once its driver binds. It describes the PHY, so it
sits on the PHY node and needs no prefix naming one.

firmware-name is not used for this: it names the file to load, and the
EN8811H driver keeps its two blob names in code, so it would only be
read as a presence flag.

The need is not derived from the compatible because the knowledge that
an ID needs host firmware lives in the PHY driver, and that driver is a
module not yet loaded when the MAC connects, so it has to come from the
device tree.

Found on a Keenetic KN-1012, where the EN8811H behind lan4 has its
driver on the root filesystem and the switch sets its ports up before
that is mounted, so lan4 stayed dead for the uptime.

Assisted-by: LLM
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---
Changes in v5: none, Acked-by added.

 Documentation/devicetree/bindings/net/ethernet-phy.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
index df50c4c33d76..ab95b9a5d95a 100644
--- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
@@ -215,6 +215,12 @@ properties:
       used. The absence of this property indicates the muxers
       should be configured so that the external PHY is used.
 
+  needs-host-firmware:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      This PHY runs firmware that the host must load before it can be
+      driven, and is not usable until then.
+
   resets:
     maxItems: 1
 
-- 
2.53.0

