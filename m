Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1316638BF67
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 21:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770240346; cv=none; b=FUD2lNGTT/ECYE008Bbam68Lp0bCoHR447weqfahXkI42QBiR/rqq1GDRE8EPa71WQ7chlv61YuhRDeOldxpxEsFpONvPxzkbMguo1Eg3WduNgEGU6iPWSpYCOvyOBeO1uKLnt13JVcKaGgJoE/zWT+ikuJlPzxnDtXl2jRPoHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770240346; c=relaxed/simple;
	bh=GGx3tEEBEsP/zWuuHQWsGEcQUYRZMy5fvKKtRcj/Ppc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dp0S4sW+vllZvg9xdZnh9UuUYDpWmc+pwaihMiFo0MHdcbUqRIfTHPCusuHbuRY+SlrarIefjFVN+nDMGWi8DSwn+Zpo/SrjAvWAQ3wX871tp4EMbp9ms0qj6Xq+6ttmMhnCGvmvkdjPHsMI9tWxy3TB87A/dOXeCdjbO83nZRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GBBMXKwX; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GBBMXKwX"
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-658381b28e8so409370a12.0
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 13:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770240344; x=1770845144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+Pp2YHDz9lMmySFFkUv+WXWdk3W/He2Wu8AaWjmXkg=;
        b=GBBMXKwXcxfW3dRSNWd2akhvRNCAkeCeistqXTd1gdJaO5M/00ET7al+y3zH7Kw0tP
         bjkskAcZ3j591bDx72Ivo4oWQL38htP5XOdTlguf/JrvpepjhSppVqYlXxn/DmxuTHee
         qjJK/A9Xln0PLYKzo0g8HxiLeCEnPhNC0mDTusaV0+Ej8cavm9qrnqiGswT2naZAqtCZ
         eOY21kB+xu0OwL2J9XycYAvTSZNqFaDqMUSwkk5eaKzi41dtR3M3lLd9YLPiyJT/yOBC
         72DiWWOWXpWL/VbpIZHBXfzJFYOqppq5zM4GEnIi4drUj7FP9s0bVscOVQhxJtcbrTN3
         5XuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770240344; x=1770845144;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q+Pp2YHDz9lMmySFFkUv+WXWdk3W/He2Wu8AaWjmXkg=;
        b=T29woLDHWMP38fg/6TUCTwW9ykMVReeS26hdcTaEpWS4kZPX9YVge1asIoRdhrgQ/1
         uwwuSx+ixyJZ2hkkoiRz8MGTXsI6t/TJb9D9nbXUfKRp0vtpbwCe4PSiHb9OAlsU27As
         ZLwxQ4aFNNa77z08ujY/RkYDq4661HEOs8+QNy49VsE/y5VS8Abkpa1fr9KMU1aX5JPw
         NJkK0eLzR4geC3MnAKE5Gblh8uevQSwt39P5Vf1BoyeJ3Y7l3P4Hisn1LztCw5fq8USG
         4sKgwNBnePYW4Z9YUdQejMHxcSwQ91lcLKfQ2+RpxEAa48q9aEJZQ6TGEXcWPkTZpblv
         nGNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYakTSBQcE/rlYmQf38m8GHBOZsYW8mdtMOtsZK8+K/b1Xg3Wv3uVf/fPbBd9nZGx/acas2/g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7k80rE4yUS6oFdSeKxIsCNPOaTtUex/VE/vXFru5Ms0NpxhGo
	1XLjHVJ9GhXSvJ2FSV38YPL9d6JWrt7ilgrXyPu+7AhwpNuqHhosHvyRZDbD+pA/FMk=
X-Gm-Gg: AZuq6aLu4yJ4DzxIXR2bkeHIUv+Xp6ChJMOWLWFn3NgOe+5++Rso+bncAX7dmNUAhUx
	2di4RsgjDjd6WUNuqLXV9Wt+pj7aWpiMeY2fQo8a2TYA/mDfvaqqfvyDXwpEYr1k0lOIX3N4FrX
	tIta/tBQmJRZ/ZoEVCOtDxppFkJh9FNTWdBnKmaI+uAhp9COig0h7EXBccBY97m0g0wnPLlowN8
	2g3MtyAy03TdXjImUXjK+qOnHhW6SrwCWIE6eC10I/SwdyuaViyp9yhO/SJCxiqiuWuFNQbniT9
	UaWHFeiSHcl5/+v+0TpAiiPTTk5vXyqWTI2FV+iYk0P6cs+UX5W6tY05b1dyhD9/gXwZenTAP+q
	fE1/on/1DuOlAzJ8hx7r03T83TRFninNoyVkIQL1ea/88IvPal3VK4e2KDosGHDOeiCyyxV0ey1
	PVgIrfEQzJlRbfGMSxUwbmOsoRtJiqjecBQeyPH/a7PvxM2A==
X-Received: by 2002:a17:907:7b9a:b0:b8d:bf4d:7464 with SMTP id a640c23a62f3a-b8e9f1757b9mr332256766b.39.1770240344250;
        Wed, 04 Feb 2026 13:25:44 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:b4a3:40bc:353b:1368])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8e9fcd8f7csm156558166b.14.2026.02.04.13.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 13:25:43 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: 
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Biju Das <biju.das.au@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2] dt-bindings: net: renesas,rzv2h-gbeth: Document Renesas RZ/G3L RMII{tx,rx} clocks To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>
Date: Wed,  4 Feb 2026 21:25:38 +0000
Message-ID: <20260204212541.4870-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

As per the RZ/G3L Hardware manual, CPG_CLKON_ETH register bits{12,13} are
to control the RMII{tx, rx} clocks. Document the RMII{tx, rx} clocks for
RZ/G3L SoC.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Fixes: 3ac2aa31b489eb4e ("dt-bindings: net: renesas,rzv2h-gbeth: Document Renesas RZ/G3L SoC")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * Collected tag
 * Added Fixes tag
 * Fixed typo {tx.rx}->{tx, rx} in xommit description.
---
 .../devicetree/bindings/net/renesas,rzv2h-gbeth.yaml      | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/renesas,rzv2h-gbeth.yaml b/Documentation/devicetree/bindings/net/renesas,rzv2h-gbeth.yaml
index fb60f745a1ff..2125b5ddf73d 100644
--- a/Documentation/devicetree/bindings/net/renesas,rzv2h-gbeth.yaml
+++ b/Documentation/devicetree/bindings/net/renesas,rzv2h-gbeth.yaml
@@ -58,6 +58,8 @@ properties:
           - description: TX clock phase-shifted by 180 degrees
           - description: RX clock phase-shifted by 180 degrees
           - description: RMII clock
+          - description: RMII TX clock
+          - description: RMII RX clock
 
         minItems: 7
 
@@ -77,6 +79,8 @@ properties:
           - const: tx-180
           - const: rx-180
           - const: rmii
+          - const: rmii_tx
+          - const: rmii_rx
 
         minItems: 7
 
@@ -170,10 +174,10 @@ allOf:
     then:
       properties:
         clocks:
-          minItems: 8
+          minItems: 10
 
         clock-names:
-          minItems: 8
+          minItems: 10
 
         interrupts:
           minItems: 15
-- 
2.43.0

