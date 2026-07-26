Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8857535E1B6
	for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 13:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785072395; cv=none; b=Wk27PmEx46dhCl1iE9ebmycTdJpxEcvt5ZH0dDLXk0JfgRcS0uClcykJL7XwUPAbE0+iZ16o+rFVAz5i/VEw6ILBYgWc48GRtxVwi1y+d+J6b8NXGLONgqQdd+7+TXQM/mkSAxVs0DecWqe9jjtzU714kMd8OLgkZsM/ESwQQnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785072395; c=relaxed/simple;
	bh=ihoDJ696kVz8JcKwc2R5wo7CXL7TVJQtt7pxl9KegHk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rW24QFz520t3KqpQZzFmC3S36Oz14rCOQsit55Nlqo1X2ks6xs/Vb1MKj9uJcoMTaET1M30FPvdy34gCcGS24dYJVYZz6TFFuOai+eTsOspGgZg9LCtfoX5Edtdt+VlWQZYugJ0xipErJE8KnMn6nCPgoDYTK9kNiX2v9eX6rhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/dpjfGO; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/dpjfGO"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ce7d2adef4so23515645ad.3
        for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 06:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785072393; x=1785677193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Pedwj7ip/TTN4l9zpA2Hv+d7tqQJ7Bsv4qn8F/T2XqY=;
        b=J/dpjfGODTfodmBgStCh/uKJK9RQASPL8G6tRyH5ZdbU2rT1rk7YVxJlCLKuiPwL8o
         VEngom8NHwGWd+GPxIvZp/EqVCk2FRqykuM+iMlYMq+vzKpMF0qa6KetXux4A4VinLuF
         wEd5hxkdUjvDjfMDJvjb1o3dZJSLgbbi+kgpq8MvuHWrZTE5eG3huK+o6DPM8bQ6KOht
         vV0+CgtBMk2gE/6YximRd1KWmpW25h60TpPOg2Pik+Wi/bHUauusKXTE2dugeChCFWgT
         s6gApxBTi8s+eqvm0ADvZWmwIqxgaUMh0RJMFwSMSHl4r5JFTTPMKwpTZMCoyeIEeCd7
         g8Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785072393; x=1785677193;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pedwj7ip/TTN4l9zpA2Hv+d7tqQJ7Bsv4qn8F/T2XqY=;
        b=dbnhWvQG9zaHjSB18MW9qaYGFEEqDmtaaXqRSli2EBrsNbp2asfb6fhpiJ0KoqYPRj
         j41DcCS/ivaMSKl6UwrD+FuQbUrAOVsqq911WHMWJONIxyYmmJpNQYhJKlhmuMLsG9Rz
         pCz+BSiG1xM5kNyKyrlgzieaVn7EkXJ5p8YzxW1gDFnG/lwmG8LlC1kWfR5TrfFSileT
         4jRVhFoJFwGQAFEcOoq/OxbVpNOgURSJVx9Ek3ezKGURYUpsJrbGcWNmsmhFaL2xiA+A
         dkivf4KP/ZuKRsHwxnEMs+kNmeGzOTpsuk/s1CsVyKr4gsFdHww1FqTNoH42zL8Jx9TY
         80Mw==
X-Gm-Message-State: AOJu0Yz2hs4ueYDLZQddmHT+KzPGIlU6bBVnlzlSXQx0OES5NlRSmtjj
	MyLBufjoI8bKsiyPNpZZR29QzTPFqD2JYYrb3DxYteTaX1gQbd4nLYkj6k6EMGn5
X-Gm-Gg: AR+sD13anQK/TyLFg9Di/NqwrQPb13DMQMx60Dam3gMjvvmRLMhR1vmlNI9yqyUt6Cv
	LhXJBzG6pKqHdwXjg9lW7YoXBYl0Cp7H6iP2ksa4flJ0rRy6NSq5/YIQlSyLHwuJPcDXgM+HBmD
	Wy+3kcfMbYlK0bxuBoo8o3vF6mqQC4eaP+lCdvItEesZ8Xs+5b1wd6cdMrVH283HUSNIGgrncrn
	djsXoztg2JDgI9jbyRYGO0YiNtZbdo8rro0Vz2w8eIzpbumY2v//pkjToHnRphCzUQC9hgd0nAV
	ESbNvpq1vy3COGtEwG1kCyUTWweYS7Pej0Ad+zoB7EKgM0fegX38rfdXZQFpQBjC0u/X7CcZ85b
	sygZ49KpHW/TBe7Z2AHzaT27aD1yzOk1wbyRfEBk1qmvO3iE2LDYVMAzaodquva/eUPtUQQ8YWW
	lL
X-Received: by 2002:a17:903:b0d:b0:2ca:4f33:e86f with SMTP id d9443c01a7336-2cfde7ae37cmr48204445ad.12.1785072392719;
        Sun, 26 Jul 2026 06:26:32 -0700 (PDT)
Received: from server227.. ([39.170.101.209])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde7bbdc2sm20677655ad.42.2026.07.26.06.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 06:26:32 -0700 (PDT)
From: Zxyan Zhu <zxyan0222@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <linux@armlinux.org.uk>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Hariprasad Kelam <hkelam@marvell.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Zxyan Zhu <zxyan0222@gmail.com>
Subject: [PATCH net-next v2 0/2] net: stmmac: Fix PHY attach when custom PCS is in use
Date: Sun, 26 Jul 2026 21:26:16 +0800
Message-Id: <20260726132618.3580612-1-zxyan0222@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes the issue where stmmac platforms using a custom PCS
via the pcs_init callback fail to probe when no phy-handle is specified
in the device tree.

Patch 1 is Russell King's phylink patch that relaxes phylink_expects_phy()
to allow PHYs to be attached in 802.3z inband mode.

Patch 2 skips the PHY attach in stmmac when a custom PCS is already
configured via priv->hw->phylink_pcs, avoiding the "no phy found" error
for platforms that manage link state entirely through the PCS.

v2:
- Include Russell's phylink patch as prerequisite (Patch 1)
- This is now a 2-patch series targeting net-next

Russell King (Oracle) (1):
  net: phylink: allow PHYs to be attached in 802.3z inband mode

Zxyan Zhu (1):
  net: stmmac: Skip PHY attach if custom PCS is in use

 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 ++++
 drivers/net/phy/phylink.c                         | 8 ++------
 2 files changed, 6 insertions(+), 6 deletions(-)

--
2.34.1
