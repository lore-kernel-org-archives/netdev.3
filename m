Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633ED42FCC4
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 07:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785310987; cv=none; b=uKszExJ6FtYqX0KbhH7oloLy1/Cn+tmwAlWchXjHjngwr8y0x+o/uJDk2oNIbo8+bl5Z7B//Fvc+6eAHBTAGepcbbv1mJEmkuWyRhhtwhL+r7qhyNOO0BXiJAjYciYWHy0K3hqsm/IboL805qXdlsewiivbWW/uCcrHIFRGloqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785310987; c=relaxed/simple;
	bh=oFO0czTX5z1fNML8qIjSbHhNqU16f3qJUBRTOIpJcXg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ar9ldaX1BhQ9CYn9YlP/kTVrhyohyAWkgZtdmQF0VBRu2PXCEUqQy6/vWMCaQqbx99dvy0N8TocQKgxi8JmdR2YqazDN25e8xB09vzw3AaKEatBn6MQQVi4/WAd7xy8NjnPaxYBqZAe2CfSEO6cBeWAmloKmygJDkPvvKhxTq2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dqvGxQKR; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqvGxQKR"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ceb096e675so9443715ad.0
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 00:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785310968; x=1785915768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Np3TxTdvKcS8g72nvKid+BqIJi+sR4NF+QJPQi54MKI=;
        b=dqvGxQKRHrxNhkqk4y6A/74l9SFY1kYIW+vFeq006pKdaYU/rinV+XWBjplIpI5C4y
         lcKu63mlTQOePQWQhopfBGP9eEuL8fFBWz/NvOblWx9iqrAE3wLzCViHCmYdSXJiEPTL
         769jvcEvS8gfoum5VHTCNtlfvtaqmpRKV+O7VHL2qDshEqSEucCKMG4ZbfQnnTfhKK2z
         OU/HdKjJhAEE4+yGjH0ebgUO79uuI2TT4gsW/ZQ46wN3XH5HqZMXSjmeDca//vxrSJXg
         H9j13M35lEfTY50JDpQP7berMViquIeiWdCneuJehAKlpx/prueUNRhbb69GAw+v10zS
         lYvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785310968; x=1785915768;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Np3TxTdvKcS8g72nvKid+BqIJi+sR4NF+QJPQi54MKI=;
        b=erz2W0pEepPo142F6pJpKOf71AflLYHRqxawinVNartI8Plg/splIjx3nwkVKEv3Gu
         aLJPpeZMmYkDXxFHXL3OvsuDT3BdBheW9vZwcGK0FS9hPM7hMPeuU14FcLV9LvOYqDo4
         LHDNKsWrNO/jWDeooukItR6IVf4no66YXoHSlr32Xs7u/64zXDmmSHQ7Lh1EluOCNcZl
         5Tspbm+Zr/9s4/GsiDKmMzVphzQ2SAqNAH5Rs6V2SMtHg/H1bi162+Kz4LJPluk8AI85
         Id8id977ae9cgm1tJGBWXZYJxZtO6OKWcYjpK5wwO3lJwpd5s0+hgS8Ik/Cox6GFOuEc
         8viQ==
X-Gm-Message-State: AOJu0YzBCwgJ4Y6bEBj97G4Zx6QGCRO+8XftG7vOlGzXdtbTSCW7Y2d3
	oS/DpUqM85Zjgx8j11dKWf484UZBE5FX3sqqcF/Kfjcfn8S5uQh9pzeJJBktakvG
X-Gm-Gg: AR+sD10YpHMmga0dGmpIT0ZUBIVAduLPabmtoTUvyVBIm2u0oufSgrnElN+84OAP8iA
	XTFESZiYFKfEnWAXwXO8ZBSVKMTHpIAm9qiVLMzTQTmqY6lW65noB1b98AeFbZj8zJuAJGT3Ojo
	GK/jQhprZT2LowY2++R5o2dqEqz4VXwxx1Esubp3ImvkeAe18fyuC5OObH8DVzkAhSvPv5SMXxd
	QdrQyNHcuHWJY7xMsM0bgBB6DPAoRz3g0XaYON8Q53sGOwyvfBQ8rFJTQ3pVVQtS98BI4pegpQI
	9C+V49kRPGRUl3957OnCbELkAywVzxmqqyYmbZe6SkI8lLdlISzRzhSjyJwxOUx7u9QVLT7ffpX
	VXktvytlPxf8RuSE0jgJEt+C87tvu636jfr/UbRQ/+CfJbVKv0bkwL3WM3ETOdh8lb/2Wclj9u4
	Zc2mLc4ObJe8jShxvK7R4R9jDvFyooZhDAk8qZd9YqDwMCYzqwCi5ca7cn90dDFeOwCcq16Q==
X-Received: by 2002:a17:902:ebc2:b0:2cc:6817:d9bc with SMTP id d9443c01a7336-2d015f31b41mr63997355ad.38.1785310968545;
        Wed, 29 Jul 2026 00:42:48 -0700 (PDT)
Received: from server227.. ([39.170.101.209])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022bf888csm7154505ad.64.2026.07.29.00.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 00:42:48 -0700 (PDT)
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
Subject: [PATCH net-next v3 0/2] net: stmmac: Fix PHY attach when custom PCS is in use
Date: Wed, 29 Jul 2026 15:42:35 +0800
Message-Id: <20260729074237.2624940-1-zxyan0222@gmail.com>
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

Patch 1 skips the PHY attach in stmmac when a custom PCS is already
configured via priv->hw->phylink_pcs and phy_addr is invalid, avoiding
the "no phy found" error for platforms that manage link state entirely
through the PCS.

Patch 2 is Russell King's phylink patch that relaxes phylink_expects_phy()
to allow PHYs to be attached in 802.3z inband mode.

v3:
- Move the priv->hw->phylink_pcs check inside the "addr < 0" branch
  to avoid skipping the phy_addr fallback for boards with both a PCS
  and a PHY
- Reverse patch order: stmmac fix first, phylink change second

v2:
- Include Russell's phylink patch as prerequisite
- This is now a 2-patch series targeting net-next

Zxyan Zhu (1):
  net: stmmac: Skip PHY attach if custom PCS is in use

Russell King (Oracle) (1):
  net: phylink: allow PHYs to be attached in 802.3z inband mode

 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 ++++
 drivers/net/phy/phylink.c                         | 8 ++------
 2 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.34.1

