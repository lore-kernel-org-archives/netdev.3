Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7041F1932
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 06:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786687712; cv=none; b=aXFYkxnUTYEQy2Ywls3cj4ZoZxPjhAVS5ILAzHdef0YR82FRuy0EpLhSqL6ZeiDjmkLDVkNQv6xOz1O6F2iEcg9Z5pSvEX1JpgikloHR4YxuHO8WTmD3SwJu0Csaug5qq1Fb3ZUkTDb5KKtOBbq9fdoiELKe5yASts276/xeEpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786687712; c=relaxed/simple;
	bh=OdaBAiQb6gEmCNb7tFmBVM0j0naVT2qn4/yODI81cH0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CFe83yzduSEwVsH9raoEErLoxJDLw+TSnMqYdc/k42/POY7ODic+PTZy+heT2d6doU10qui9I7iIyPUEY5ophTa+UsBxuZ5G1WgNc7HRnqtUsoOwIZ0Z7AIl0PUZK5S1VMpZJRqbe5/emvGBHTiAs/X5K8+SdEBSt2r87bKrix8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bQJ606uC; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQJ606uC"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49558ce01afso4659055e9.1
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 23:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786687709; x=1787292509; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TINErpoZs249/gc7F8k6VoM2fKTzeeCGjix6Ih+NnM0=;
        b=bQJ606uCU8XPYFBlOGD6j2sRBxZpXgup9HIH6OuLxkK+4nqSrdw7+QedqNlFf4CmQf
         wIkqQhVF5zLzzG4YOTjU/iMeS1FvoMMD0Tu+Wab32ea0gdsiQOA1zu6em+abbPpDZhFZ
         w1ZshsUkM6n1JxuveiUfB1MoZlvg7nidoOTnD1mAflvlBidzERC04LYSc1tiR8ke4fGV
         QWIHPe79DV6Bvof6knZFQ+G7lf0PCgi+JhhZKF3jG1xJJqxtmI7nmgo0pOEDHUNs9mVV
         o556nwRwW6JR3KbYMQ2jZVAvbmYT2LmmRfMojCcVGT+TDWVOYUjsXseNoTHQlQ8iZ7U5
         YRQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786687709; x=1787292509;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TINErpoZs249/gc7F8k6VoM2fKTzeeCGjix6Ih+NnM0=;
        b=Yufc548n97qo+5qQKD1zxlDML+dEvHmbo3380+zYI2PuP6H7Hg7lHIPJauEjLKNLnE
         T+K3YxJegEcj4gXh8pLwj1107JsJi401BHNrW9b0P+jv1HZEl3ei43l90HCg8xdnvWNX
         2qDC90yK1YlHSXLcX3i9cgak/8z1fmmPAhcdQDg7FU+Bm15f2AcqGLN5GSXiX66gp36V
         S4mgA48esE0YMx+x2FuDC7ohUAnGpCSvGhCEUGW5VaLPiE6gPX903ctkj3GN4nba+R4Z
         339MxgeDIZHVRhNWM/BMcXAqRcpkhfzRznQ+6lEbRYbEumVqViL5u1W9inpzt9UvB9sU
         uVTg==
X-Gm-Message-State: AOJu0YxGq2ofBa62d6uyqkcXupctlQ39BrLgpUhyarkmSOXgkgIAZk7u
	9RyrP9nG9CaQfl6p5RlgW6tyaOZbe1xFLtTO4f5iFSfaqDtqpa+LY/bw
X-Gm-Gg: AR+sD12Ji5fpReni3IQW1c24SI9gPiDvHIFy4GEMOnUSQDKuGHvKg21NWYpbtfl+scB
	XxPBZpN8e7QzlVXUhjgWEA0KHXy43jKBamGYbW2Dygmbrjkd0njuifSX3AtnZB6Lvo+0snNCgSv
	ltgxkS/oZ+cYg53dWO+imbB0WCP8zcsz205HCYc8lj/5LrmG86AMYcloT12cMOBoxcAJ3sZVz8e
	uE8QcsE/AL3EGji48hBmrfCLvw+SfORP9GHNMqnVhVvUaWjZxjbnnKtZEjZdZKjKD1pNFJpH0TJ
	naKx8cnnruSjR2B96W+XJ3fB8tmkc5DgTKmOiAr+xmzDsms3DLRLq6NH2MuBhXZdDTvT10kPsts
	7pFXguJPwBt9H5m4Cjru7EnfcSRksvsZ3R5N3XbFysDd7VRzdEB7wcjZupSCNeCP2zms0zxa91n
	nTFbN9vED6kddD/A+fomfwLkO1Xlfclc30Y+AQl3EjWte961REaGFAsNSNpCOmWMoeUoLxvDwEM
	MYtQHFrkJcQexB43AiIyPgLqYdi8jGTvB1+62XX
X-Received: by 2002:a05:600c:1d89:b0:499:726a:117c with SMTP id 5b1f17b1804b1-499879bf7d0mr46462705e9.19.1786687708806;
        Thu, 13 Aug 2026 23:08:28 -0700 (PDT)
Received: from INBSWN167928.ad.harman.com (bba-86-96-6-50.alshamil.net.ae. [86.96.6.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49989ae9618sm1475095e9.13.2026.08.13.23.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 23:08:28 -0700 (PDT)
From: Abid Ali <dev.taqnialabs@gmail.com>
Subject: [PATCH net-next v4 0/3] fix the MTL fifo and DMA race condition
Date: Fri, 14 Aug 2026 06:07:52 +0000
Message-Id: <20260814-stmmac-rx-fifo-block-v4-0-1951fd3d33b7@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALiwfmoC/33Nyw6CMBQE0F8hXXtNH5SHK//DuOjjVhuBmpYQD
 OHfRTYSE1xOJnNmIgmjx0RO2UQiDj750C0hP2TE3FV3Q/B2yYRTXtCSF5D6tlUG4gjOuwC6CeY
 B6GRVG1G5utBkmT4jOj+u7IV02EOHY0+uS3P3qQ/xtf4NbO3/0wMDBrlUmta5Lgzl51urfHM0o
 V3BgW+RcgfhH8QakcvSCmbpLyK+SMXEDiKAQikqZTSilLbeIvM8vwEG8nIsTAEAAA==
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Qingfang Deng <qingfang.deng@linux.dev>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Abid Ali <dev.taqnialabs@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786687705; l=2747;
 i=dev.taqnialabs@gmail.com; s=20260425; h=from:subject:message-id;
 bh=OdaBAiQb6gEmCNb7tFmBVM0j0naVT2qn4/yODI81cH0=;
 b=Dp4UMAGzWTSENRNb6J6gKaqOlTcxE4kwbzpspsjNxVeDZhtAGQlLgXTIGxhQDfHB/+bAMPmAY
 P9hhkFyeyD6DtwJEMI0/cor5QU5XZzAYFVALTKId94CVLFNBHFMFmUZ
X-Developer-Key: i=dev.taqnialabs@gmail.com; a=ed25519;
 pk=4Syx51HH/MOySSUpi79M2ToLOdwt1yiNb338eKZBJNk=

To: Andrew Lunn <andrew+netdev@lunn.ch>
To: David S. Miller <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>
To: Russell King <linux@armlinux.org.uk>
To: Qingfang Deng <qingfang.deng@linux.dev>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: netdev@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Abid Ali <dev.taqnialabs@gmail.com>

Changes in v4:
- Rebased on net-next.
- Link to v3: https://lore.kernel.org/r/20260813-stmmac-rx-fifo-block-v3-0-738acbee55d9@gmail.com

Changes in v3:
- v2 tried to fix the ordering in teardown path, but it still would
  not follow the ideal flow mentioned in the databook. So have
  seperated the patches to deal with the teardown and some findings
  from sashiko.

- "net: stmmac: enable MAC rx/tx after DMA start": reduced in scope,
  now only moves the MAC enable after stmmac_start_all_dma() in
  stmmac_hw_setup() and stmmac_xdp_open().
  This is to handle the overflow scenario during bootup causing hang.
  The teardown side in __stmmac_release() is no longer touched here.
  This change could go independently fix the overflow hang at bootup.

- Added "net: stmmac: xgmac: tear the datapath down in the documented
  order": for ensuring ordered sequence is followed for teardown.

- Added "net: stmmac: xgmac: decouple the MAC Rx/Tx enables from the
  DMA ops": drops the global TE/RE writes from the per-channel XGMAC
  DMA start/stop ops.

- Link to v2: https://lore.kernel.org/r/20260727-stmmac-rx-fifo-block-v2-1-4dc3457d31d0@gmail.com

Changes in v2:
- Corrected the ordering in teardown for xdp at stmmac_xdp_release().
- Link to v1: https://lore.kernel.org/r/20260726-stmmac-rx-fifo-block-v1-1-45ab094b6c02@gmail.com

---
Abid Ali (3):
      net: stmmac: enable MAC rx/tx after DMA start
      net: stmmac: xgmac: tear the datapath down in the documented order
      net: stmmac: xgmac: decouple the MAC Rx/Tx enables from the DMA ops

 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h     |  8 ++
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c | 94 +++++++++++++++++++---
 drivers/net/ethernet/stmicro/stmmac/hwif.h         | 17 ++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 85 ++++++++++++++-----
 4 files changed, 170 insertions(+), 34 deletions(-)
---
base-commit: 4f93b12cf7b25fbf8e73d222722805b049f0a6d3
change-id: 20260726-stmmac-rx-fifo-block-ef589c38f96b

Best regards,
-- 
Abid Ali <dev.taqnialabs@gmail.com>

