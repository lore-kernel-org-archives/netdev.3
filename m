Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6B73CB8EF
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 08:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786954861; cv=none; b=Vj821531dj3b3nLar2HmRoFBvJ9yqJ4LDSJZcZ3ErXrHDYZs2MtDRzLQGTbGWBQm6qAnnmTF8vpV1H7CMTJfA9kQEB8zAujgVRQcYkT5/nUPOe194ds2lic7M6iyDHpEBGCFVAKJYOhLh7jB3n4iubuR1ErnscI1DJ49+G+fv5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786954861; c=relaxed/simple;
	bh=QFgNYbC5iGgbyr7HDWbqxazTnqPm94Iv99RuR51kLAo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M7QHGbM/05Oskeht/G4wJE4zNDmYv58fjXgwm1rlgEy9ltxBY9h7y1jgKMcjAcYdatOA7R7r6DuIOQNbu3kwyQuayjOx8mpFkglRSqvC2g811g6w1up8c+NQCZQ1THEEQikFkNyHJqot+4GUKIhhzaG3C+D/B52ZjJL4jpbL9L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hik27C2P; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hik27C2P"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49558ce01afso23535945e9.1
        for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 01:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786954858; x=1787559658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pzi8GymOZsAzDRFxhnMcMsHjxOXoqegqJCBPzRg9+sM=;
        b=hik27C2PaFV92pmWgNH2vq2WiUXsWv1uNAUAN2a3lhttZsmyBEFXWzzCyZ3oWiVbNh
         uUfeCzPVF2818dq/eceyNqls9lCG/zM7QLGFaFWqmmMzHuTByvLTeZ/tCfYDYWo8vCyP
         J4llsfCZyVIM7JkhOTFHuZjX9MQMNlolpv0aNHrlBIGfQQZfOilHe5CabrLxCnTP7YNv
         /QWYJHI8Yxljj8ZvKblrJ+PbCMjyMtBp+Ma1uZsFeMcIXNN3evHLtXQjY/F780xUjrmV
         RoRytLtVhXHu9sp2Zqd5LAaH0/SXlxCv+E34WPytdXZMNbQEOI8cai/mLMJDWRypYsLU
         TGuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786954858; x=1787559658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=pzi8GymOZsAzDRFxhnMcMsHjxOXoqegqJCBPzRg9+sM=;
        b=bYc2pUuSz0sGIfsF0kuON5Nj2AGPT85J9TGLdilWLwDYu7yIqKm/hUI2xi8frCCD/H
         3C5bGc8HfUD2qPq1z3iHfSX9Q2oBP7IRb8EULTmqQCYwJ6iyG+vLFC7JWHyzz5ledYBC
         TVkUMdAOEjI9/dDMb/Ql9+mdaQ6oO3SC5kEx0y7HqvsnIyLgEoqANBivUlKFsndNTgPE
         ih0l+BaUEIwmspUd4t+o8+LN5DNQ8zROCG/W57v+8G8xVkldejzsug4z5J6HnYPS59+Y
         8WdAIxCToYurZQjigboD/UjvqEOFIGpjfbWyAe7KcQ46ThiCKkwJqDdSI2t4RsMomkrP
         QObQ==
X-Forwarded-Encrypted: i=1; AHgh+RqtM7EdN97rUlm6KQBbUihus3eny9DWloXba2FgXatgXto17uMqekCvBUIz3E4gOGKfesW4HSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTClDnD8RqnZs4N+k07Z3lff+kBLh/TEPDM+G6esh8yn7iFXki
	7q2aQE2DQ2isGoLA5C1GlIYYt+UzlW1H2escb3+V3XHRuhhonw5SmTjk
X-Gm-Gg: AR+sD11fCNQzzxbm0WgOQbt5MXWRKRO7MippEnxpCtdwiHeG3+2fqDkx1Z/Jg9mikPZ
	Io1yL3MmoIdrI4l1Zf0T5NaExq8JvWWshBKVJapfxx+y8nQSHKIdxw8ClM3uOtuFBXEkbJGH07A
	aDPN6rl178PpInifDCRXj7dcQ4THfQQ1tD+9n0CM1AAlJh296NqYQzFlesvAbZ6DTQoIGjDWFzI
	Re4I/bHDVO95BSMk3Fy7MJC0V/ogB3kKqc6whJ3Iv8Qne3z7nuLWFq+fR/nsy3aFhxLkFf+zQn/
	cpg4+BZCdO5FW/FJQ15531mggYn5P7Czr2soYUIAHE90xUDQp3yvkc/I920kKoetOd4QEizFMVK
	pk5YHVJAI/KFqBHukbsYPEEX9DVmiiyhecA6xXvxporXVyc4uuxRD2A7zilG9UdwUj+z+0hJzQL
	JjifS5ibDmlBx2LkCLyeXYIX1A69n1IVggZ8SVvsdFEpaJG0NnChstJbASZJAhFm4zGAtqeLasm
	Xh3LsKy9JPpUG40V2yj8UnQ9ZfNNj/lFDa2M6t5CtBcBdaeK0KO7RSH
X-Received: by 2002:a05:600c:34ca:b0:499:7f38:d77 with SMTP id 5b1f17b1804b1-49988cab011mr368103075e9.6.1786954857528;
        Mon, 17 Aug 2026 01:20:57 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-79-40-190-175.business.telecomitalia.it. [79.40.190.175])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4999d078517sm19684195e9.5.2026.08.17.01.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 01:20:57 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	mfd@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v20 07/10] MAINTAINERS: add myself as maintainer for Airoha AN8855 Switch
Date: Mon, 17 Aug 2026 10:20:29 +0200
Message-ID: <20260817082034.20326-9-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817082034.20326-1-ansuelsmth@gmail.com>
References: <20260817082034.20326-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add myself as maintainer for AN8855 DSA driver and all the related
subdriver (mfd, mdio, phy, nvmem)

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 MAINTAINERS | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e0e7fae5b92f..d9338fd2f19c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -760,6 +760,22 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
 F:	drivers/net/ethernet/airoha/
 
+AIROHA AN8855 DSA DRIVER
+M:	Christian Marangi <ansuelsmth@gmail.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/mfd/airoha,an8855.yaml
+F:	Documentation/devicetree/bindings/net/airoha,an8855-phy.yaml
+F:	Documentation/devicetree/bindings/net/dsa/airoha,an8855-switch.yaml
+F:	Documentation/devicetree/bindings/nvmem/airoha,an8855-efuse.yaml
+F:	drivers/mfd/airoha-an8855.c
+F:	drivers/net/dsa/an8855.c
+F:	drivers/net/dsa/an8855.h
+F:	drivers/net/phy/air_an8855.c
+F:	drivers/nvmem/an8855-efuse.c
+
 AIROHA PCIE PHY DRIVER
 M:	Lorenzo Bianconi <lorenzo@kernel.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
2.53.0

