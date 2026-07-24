Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968C44477F9
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 19:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784920106; cv=none; b=rAWIUU+E3Gv6bqwB/8j0rAiw2LK9ws2Rowp0hRFkIF1zWji9D+4GkHhIbMhAUGMVUic7TckcECHUAVsFrRSxGnjlIweo6SVGkCyYBUXmecFRHRjHrhcYhEeIESd6vNE8tJUC6wszQyQioOPghfdYwJM2BCsAd1KEGfA2jlIkrlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784920106; c=relaxed/simple;
	bh=XLUD5S0i92Dh23DT9ymcrHh7qyp8ZHUEcsRKwRJ/U3g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ojKTyEvQMF5pLomFyIxOP3JUQPOdFK5OrUuQbgj/iIKdDoZjuWBi1YudsDJZOdVvngZ9xozNtJ5vNsCFyvp9yjfgXQPvTAnpRQp9LK4Kxy2zw+TGiBcrlLr2lgWKpVEo/+UHCNXD5n19Ou7zdPgRAorBHuQLV8Fx2pxBY9oJHMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MUyJXg9m; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUyJXg9m"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49554ebb87dso7223605e9.3
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 12:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784920103; x=1785524903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=U+htnAATywGPyMXFWmN2bw/5HJemt0qcsoVWYOwwS40=;
        b=MUyJXg9miK+6M3NgF0oR2Qn/0nFsPNlxwdjvSXOF6BjVxW6vq1hP28wSCnQWZ9LM24
         9KfDx9Jh5dJ9AKBtwSFitxqVK60ovZe3sfVqKU7EjSYDUL5rT4V6cwG7rbIva5tnK7dx
         /Ukp+qwi1hf4GUYctcPw5q1tIFkTCVdM2GDyha0dHIXbPnIQBBAyzPhAD0szwjW/gOlu
         Id/oxesPV794aBb0K3d1zzmYNBXLAqF+mTkUMzirxhFzhj6RG6vscFfh25r/b84ELxj/
         TP358Ee/lq46E0AmiRSABlCR9uS4awWQSlM0J57zHxQTdlvsLSnow9D85Q7AIzahnlAD
         0VKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784920103; x=1785524903;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=U+htnAATywGPyMXFWmN2bw/5HJemt0qcsoVWYOwwS40=;
        b=F3/OT2Kq/2VVvLYuBTuS/PPbjAyncbITmwqqZF+s40hse7mTeBXEyJ2Dvr38tWfm1L
         qL99WzvY4y54eEuqd9kh8ncVNpo2TYZN4YujV+jarC0x4n7PyQfoEmMur72QpgWHe7f0
         G7UNveUG/+6gLPYgdlcQqriH3jSpi+UBsaHVemU5ArIgIHYId3af3BUcYnFyMpMk2ZSI
         IE01WtcfYOzANtxMnfyUIxd7Y382MfyqDI5Wbc6/jUoYYPYtoofNfUs2NUfOTJk47c/r
         n0/nYRtP0g+Luv2ntY2fW/zcmzb2/qkxkPAO314oHvJS6ZQd8ysXBLg/hePE3gOYegc8
         WDSA==
X-Forwarded-Encrypted: i=1; AHgh+RrsEyDVWXEHGR8bIt5fSWPy40msMtBbUIbz36vx33Qxq/y6UqELqicgrvWv0zYAuYYyDyDECvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YydksJCJAUy4tPqJzPYlTszDqUu5s4+UaCu0dVgFGa9mZhhnx7l
	gYoaHD+Rf7XUSjMq0k3FJ2xfcgbv8WxBYw+nh/aTdde1t75i89CgTHvs
X-Gm-Gg: AR+sD114RMj0DKIrOYaWHpUew+Te67NPjkjqp2LDHAGrRLchCRX2rXEuH6ruIZiwwgJ
	ecM+Tpa0/BbVCAEXkVuvnozrFYOrNu/hBHxuFiH6aZVubtGz9Z+t+D8XpkRfk5az2d42kOseNNh
	6j0lMvPlfk+W9ZZoqLTTHP6zV1YynRiRozm3CluwScAPwRGT42yDZLDrKTu5RQw3eOR/+d2J8mI
	z52KQ4RDyk9HJ4sjfwIRoGM1EIzfKP7crveFn8AnvOlRoKfBMdnAT1wh2SY6YjF1HUD8HAjoI3G
	ZCttOw140NMWhx16O8+qzDHlmaRkZ7gN6nRXPvVPe9+hr6YFWxaOWf2iKaWd06/OsEGikz8Pplt
	/OyoefiNZVOyoHIy6YjtRr1saXW73Ue3t1dp+N10PYVsvJNzF7IFewEVSwaX2EUAowPhoOW7qYh
	E09UnpQ6lVpnbWov0r0QAjCU81r2OJ0gJdnN372uphhfRmuOXA9eT9/UXZ22QVVmCM
X-Received: by 2002:a05:600c:19c8:b0:495:5b4a:53b7 with SMTP id 5b1f17b1804b1-49573cffa23mr108734915e9.19.1784920102617;
        Fri, 24 Jul 2026 12:08:22 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-87-3-249-180.retail.telecomitalia.it. [87.3.249.180])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-496b4c8d6b5sm5893755e9.2.2026.07.24.12.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 12:08:22 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net-next v2 0/6] net: phy: mediatek: calibration for AN7581/3
Date: Fri, 24 Jul 2026 21:08:03 +0200
Message-ID: <20260724190811.198339-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This small series adds calibration support for Airoha AN7581 and
AN7583 integrated PHYs.

The calibration logic is quite big so I decided to split
the driver from the mediatek one to keep things organized.

Minor change were needed and just additional symbol to use what
is common between mediatek and airoha PHYs.

I followed the naming pattern of mtk by calling the new source
airoha-ge-soc and related config.

The calibration use lots of static table and software calibration
at runtime instead of using efuse to calibrate.

There is one pecularity where some register and calibration needs
to be done on port0 first and then with the related port.

This is O.K. as port0 presence is mandatory for the functionality
of the integrated switch and it's assumed to be always present
on the MDIO bus.

MAINTAINERS is updated to reflect the changed code.

(this was tested from a long time and also verified by Airoha for
correct order of calibration)

Changes v2:
- Split header register patch from cal_cycle part
- Fix missing EXPORT_SYMBOL_GPL

Christian Marangi (6):
  net: phy: mediatek: export __mtk_tr_write
  net: phy: mediatek: move MTK GE SoC registers define to dedicated
    header
  net: phy: mediatek: generalize cal_cycle function for GE SoC
  net: phy: mediatek: split Airoha code to dedicated source
  net: phy: mediatek: add calibration logic for AN7581
  net: phy: mediatek: add calibration logic for AN7583

 MAINTAINERS                              |    9 +
 drivers/net/phy/mediatek/Kconfig         |   16 +-
 drivers/net/phy/mediatek/Makefile        |    1 +
 drivers/net/phy/mediatek/airoha-ge-soc.c | 1812 ++++++++++++++++++++++
 drivers/net/phy/mediatek/mtk-ge-soc.c    |  518 +------
 drivers/net/phy/mediatek/mtk-ge-soc.h    |  364 +++++
 drivers/net/phy/mediatek/mtk-phy-lib.c   |   77 +-
 drivers/net/phy/mediatek/mtk.h           |   15 +
 8 files changed, 2312 insertions(+), 500 deletions(-)
 create mode 100644 drivers/net/phy/mediatek/airoha-ge-soc.c
 create mode 100644 drivers/net/phy/mediatek/mtk-ge-soc.h

-- 
2.53.0

