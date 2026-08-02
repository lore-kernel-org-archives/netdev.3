Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB6B78C9C
	for <netdev@vger.kernel.org>; Sun,  2 Aug 2026 21:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785707043; cv=none; b=kB0qwMo5LEYuOR9WJ/CIyA1fIeh2SFVOPE6Ja9AIvhLYN9mwa7xrMO9WJ+xojb7/YsQrj4kc1SRHB/WeGV5oIAbTB/Xq8EuB1il4Tgk3bFhfKd8rDw7jNjfY9IOR85QB0AWcfqqYSinUcKo+MKd+TsenEPhtN/uf9BBSnt1x9Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785707043; c=relaxed/simple;
	bh=q6W64z07uljSQGhS1KJCq4J0L83uuBcQTyVi+/MZhSY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qHlrko24YIfXphVGxMyDpgItBQCmgzKG8BK6x4wE/gM/IiossqCEs635DKNFKbJbYNWCoGfn88thOjjdPyPEDf4CBt86kbx1ROjR9rgi4A1AIffDHHxRO78lpCJJYWMrYiNGcfkn8lqvwQ/v+Ubr9Z6ksimkZtnYhQnjLMsmtEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k2bag1F2; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2bag1F2"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8efec2c28f8so18200706d6.2
        for <netdev@vger.kernel.org>; Sun, 02 Aug 2026 14:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785707039; x=1786311839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fuXEqimyffgC3r6i7frZWabp2CjAJ6czkCeh1u+cNBo=;
        b=k2bag1F23+AshYtLixVaVpVS+nTnNkoKpZHqbblAk+TkukeopDhBBY+mIx91wInowW
         5Y2pIEDVjcg44OsTVe2/fKY1RG4QiOUAj54q49Kl7f5ActkM7GuhPltXrruonr2PjslV
         0DYOKz70vp2f2EwxkpoD6Z01vMNWi1MzsmKI6f868teWk4Czo1skdnPRSkNsIPLYo7vc
         gZ6vXn918STloLSWfKPfpKsWINOklgQjRkuaNv6Uo4NVscm5aKO3NmZg30UGgjNe7QhG
         TCLbWS1IwpMp8H60GRyToXbC6UlPQs64ljE3MczhAWuisM9sp8HwweSUbuIVsD6SsuoT
         P4yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785707039; x=1786311839;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fuXEqimyffgC3r6i7frZWabp2CjAJ6czkCeh1u+cNBo=;
        b=cgGz5Ng1JhAyifjAFLDJnjYhmYQlBILboJ0UcjPl0TcYboKDCBvK226IwEGmTVSpeK
         oIHTAikre25ZKEjxvVnz4t6dFARrXJHL1rPbcvHXUdhCYxTsEevWItGogb6HO6WWuE0C
         sgTedwSnj46mEpIU9hs8rU+qsbZ/WBsUxvegsunU4vofPfXFNHWxmuz7pjPH95MIWMsP
         6uZdTwkpX4PxGeewKBXAeRmf66RCNFlRSEoXwXm+kGePIL/R9aGpXvznih/oRng5cFsc
         zPK4ID8xKCdwJoWtQvXzpUMhEtYOVqSnUeTdiOTZWlL99uaxrjtjBt462K9kuYMjpIKi
         Rj1g==
X-Forwarded-Encrypted: i=1; AHgh+RoOLU0H3QTr3GDdQ+cRnANwdFdJOz3ItCiTTRCpBunUarrWIKa9W7yyccn6GaXKYW481UWvCCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLXCAxL/0vVWAWdJHVQ/o4XfEBrCOaGvBbFIwZDn7KYL6IIcsU
	7DbAuiadWbXve2vyiC0nND3oIZGZi66jEhD8+ayZSddUs7LU7s2e70to
X-Gm-Gg: AR+sD12bwZNcEpl7mdEAMH4qS0gufq4eYg+y3kvd0AaUdx8Jv+br5MLVnH+8c9xmNJ0
	aP7Sde+25kdGXDBgiQFW0ln03zYPLrgoDs/oFxulWlQYsqmt4fYvm6NhjHuDUGMwD7/BpV82pHg
	/rqe7WH6JzFI4SqHz7KSEJzUFo9W1bw9RNJD0gflq8T1Hhy75Yblr1PybtPKFfzTjzWauyuc1wS
	4Gs1JzDZbTV6+/AMbCy9eJdftcrblIOi2YZwHWRnqHtjwLjifg/gOMaPNiht8Ic6Ei7k2kBYK5s
	BzeZD78dFHQDeLE4LHHpR1pptXntfht+KKgJvHUiwMQAFYigB/zGSLSxKxy060rIx4InMQR/3td
	6KE7Icqfiz0d0EoTr7jEAmaeSorcwjhjStZR/FQfxHPdn2nitVofAisJcfzTBqMVhgL+wvkngfq
	8hdSRBvaVnjtXQFuKWg6GYtLm+0iPh54i8xWCYtj8+cyfvywskWbhHmNvSZy4AXKTMkCTjV2ey3
	h8tgnzUkpraVfONoUfGqNkEDbBJMSE5oFUhIt7WZqTESYomjbdLjSzCHZg+DWJyzdJGe/bLlSwM
	ZT9wHU3VMNmsc7YCuxoB376chamNC16tJw8gKsizfJskzt93
X-Received: by 2002:a05:6214:5403:b0:8b3:f911:c1df with SMTP id 6a1803df08f44-9084966585bmr185128876d6.21.1785707039288;
        Sun, 02 Aug 2026 14:43:59 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908435b6778sm60683266d6.30.2026.08.02.14.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 14:43:58 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: devicetree@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Mailing List <devicetree-spec@vger.kernel.org>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support:Keyword:mediatek),
	linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support:Keyword:mediatek)
Subject: [PATCH] dt-bindings: net: add nvmem-consumer reference to network-class
Date: Sun,  2 Aug 2026 14:43:54 -0700
Message-ID: <20260802214354.490074-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The nvmem-cells and nvmem-cell-names properties are used to supply MAC
addresses to both wired and wireless network controllers. The wired
hierarchy already allows them through ethernet-controller.yaml, but the
wireless hierarchy (wireless-controller.yaml -> network-class.yaml)
does not. As a result, brcm,bcm4329-fmac nodes using nvmem (e.g.
bcm4709-linksys-ea9200.dts) failed dtbs_check with:

    Unevaluated properties are not allowed ('nvmem-cell-names',
    'nvmem-cells' were unexpected)

Each wireless driver otherwise has to add the nvmem-consumer reference
individually (qca,ath9k and mediatek,mt76 already declare their own
nvmem-cells/nvmem-cell-names).

Add the nvmem-consumer reference to network-class.yaml so all network
nodes inherit the properties at once. Wired controllers keep the tighter
single-cell, mac-address-only constraints via ethernet-controller.yaml,
which still apply alongside the relaxed class-level properties.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 Documentation/devicetree/bindings/net/network-class.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/network-class.yaml b/Documentation/devicetree/bindings/net/network-class.yaml
index 06461fb92eb8..f7c8e24016f7 100644
--- a/Documentation/devicetree/bindings/net/network-class.yaml
+++ b/Documentation/devicetree/bindings/net/network-class.yaml
@@ -43,4 +43,7 @@ properties:
       maximum frame size (there\'s contradiction in the Devicetree
       Specification).
 
+allOf:
+  - $ref: /schemas/nvmem/nvmem-consumer.yaml#
+
 additionalProperties: true
-- 
2.55.0

