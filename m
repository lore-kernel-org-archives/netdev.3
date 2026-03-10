Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3066314D08
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 17:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773164341; cv=none; b=i5G1LNhzrUelXrAuPgYnx4qJy2arHfGQDoMqxqYckJ1/C2bneEI1lheG/xJMTj3pARLMNlZ1M8pTJxFgex7wb8J1j3D0iUbLVnPOjxwQx73MJCWdUV/jZPe2keAOkzOp732vIfNXng5in9vB+lpVh4beDUhBCTQIuH/hL6zO0dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773164341; c=relaxed/simple;
	bh=i6Ts41fXLRb5swardCZUkTCJ3f2AD6uWbw7o0btGsW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U1cQqtnc6sQ823eNFyV+FWJCNRRl2z1gOSh2PbQEW5VYUVNCT8mid2qsX4DDI6bdIquyMpkQeqGSq506h62Mzyc+lHRuh+lIjnV0OWuSl1LSfP3OjvsdC9Ldrtz3tnRfekzVWmKKDPHnt8VkRas3lxMZL1C61XHbpAnbf1jsLwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=REPaTk+6; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="REPaTk+6"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48540355459so18401905e9.3
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 10:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773164334; x=1773769134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=98rPC4PTu7tCmBtkzzBMDz6PWd5qa76zGSirl2GTGes=;
        b=REPaTk+6KZ3HNkdiYzZUhFgPaX+ALaMPnt+fdvHYLY/ZInCXAOoMFXxZNTEj0t6O+1
         WlBRWVvpLwYxwy7+UCqkDHp394iZOK1GPA0UVNVF1Vqi5SlJJIQXg+wHzihgNZwlb36Q
         kEa6s0Uu5r/HPJGPK2GOecmys3CS/tlUNtQuBMTmDVLkR+3P+P+TkKGCCkfJhjiXa0PR
         Ft7Iy7X+P6AWy9U2c2BySHhc7Ny1melQ/+hLfk3WMtgfhVSUApwTBjM7gE90ORZ38mGA
         RZaB6DCt5PWBdAXM8TRjPGCLx/pH1mWDhmdHAwhBIjd1VI5cTX9G+slqoKtd9O2z5gDM
         8TPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773164334; x=1773769134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=98rPC4PTu7tCmBtkzzBMDz6PWd5qa76zGSirl2GTGes=;
        b=kKmW1G8NUmG37gNhBJOAJDYrQUcdw8mGAC/G6R1ui9qq0cTQFBXI/XTgLiT7ge+bJx
         OyzyAgEHYs3VY6MD3UkeZijAcilaRCGPHaMraDEsolk+YiNTUTweAx9MCCCPQQqRHzHJ
         S88XW0GtcU5aLN8c2WTYr5pC/dmLJsJm+6vbuOAD7yH+l3UrP+v1ZbsRDC2UVi8BLdak
         mNNn1hwOn0BIBEi7t6F7n/oqCo/hqKdUgiy+yD0/a3MAwxHcAeg1ICAnkCLsDI3iaeBM
         To5tgHOWBipIZx1zahcgv2xuqSuvCEyAt6kV0gfBoUEZ6Hv9uC4YAFT8MGPM3WhItLU9
         hoEw==
X-Gm-Message-State: AOJu0YyvjntDH0pJYVVnNtWkuOFPtgKMn6k7NLCdszoSfZe0IIcrGxS4
	UZlfn2+Wy4cfWzHehCfs1OnEVHAcBgn+z14wa4/z9s7PMJqhj7B+eMBW
X-Gm-Gg: ATEYQzyC2PAC6aNoIVxjAN9/QxUCRF8Sdu/BFpo6XSyakuagm+STiqIUfD5NiCdDo2h
	8rooUrA7kbV4WsQwPdKw01xZzmVd+xHZcu+Pi1tdmHX0Q3wxfZ1BjdP4cZKFXnmNJwEDo/VtkUZ
	lAtFRaHZNzk0a6jjy+LkGAMN5O3sgjs+YqwJD4nKf7cH2LfdA6nnv3N+tR3E4IoeCiLvMqhZ5MA
	xYPDyld5onFEhqT3eR1ftWRIE1j87XuQu8Nw9o8aLssXm5psm2RGVVFF75oKlvx8VSX86GV5FIA
	kvWG3s+9YBpMhsrH343XS73lMPEl9Em5v2e1unssrrEES/GfaKtEaweit4SAXP3Z4sv2kwRG8Jg
	CFdhA1WrKBe7Ws1Y4DsOoxKspPFI0WMwY0ABPGIqp65uqzBMwyWgB7zEuxqQ8ggwwgwxWnl29fA
	N2udsKZKx8P3PSgKSbG2W6ewI=
X-Received: by 2002:a05:600c:c173:b0:485:3812:36dc with SMTP id 5b1f17b1804b1-485381238b3mr164800125e9.9.1773164333895;
        Tue, 10 Mar 2026 10:38:53 -0700 (PDT)
Received: from nas.local ([2001:912:1ac0:1e00:c662:37ff:fe09:93df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541a900easm103239295e9.9.2026.03.10.10.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 10:38:53 -0700 (PDT)
From: Damien Dejean <dam.dejean@gmail.com>
To: andrew@lunn.ch,
	krzk+dt@kernel.org,
	robh@kernel.org,
	kuba@kernel.org,
	maxime.chevallier@bootlin.com,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	hkallweit1@gmail.com,
	Damien Dejean <dam.dejean@gmail.com>
Subject: [PATCH net-next v7 1/4] dt-bindings: net: ethernet-phy: add property enet-phy-pair-order
Date: Tue, 10 Mar 2026 18:38:43 +0100
Message-ID: <20260310173846.230923-2-dam.dejean@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260310173846.230923-1-dam.dejean@gmail.com>
References: <20260310173846.230923-1-dam.dejean@gmail.com>
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
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
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

