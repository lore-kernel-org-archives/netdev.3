Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793876110;
	b=bmYIcBnqwLXFlwgMjqefIRRFLLhHWuBtaz+d1ltYgdp77c2lOrmeggSt1K3DFrjcBjnS
	 SO/3dJS0g9ecoB2PAjBR+QsQzvb351ZTyEeDOH7IE1bI+co9XEDqnZmhnOEVWCEpRJdDS
	 lQB8TAsOveJ1Xk9yw9bqzpVkvs9ibvl3bXAELoCKPy8cjpJgClvA50JvgXv8hWySxek7b
	 Bk9jxpU6+HeJYzZNOQpOk5AJ1E+y24vgAacUTpbO8EpR7lh6dFr4CwkgjpFZQPqOEA0dy
	 HkFf6Zbt01WAQlHG85+0Y2/SiSalnQXtJ6wyvP0Spjegp91HjpSY2iL4sEM5BEDqT+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793876110;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=S3kBGMpJUDqyGZZ/3EY9QtmjH3XQ/06sMAWybkANdok=;
	b=pRCcNGtCO+UQ53auflsV/6UEcqNfvsVVtwcVAHvIrNGrZVW1WPLWbPITGnMWWrBX4fvF
	 oTP4czFG1ShIHf7Jbk3Y8rUIxpTMNa786Dgw1KyN/aUTXAiELw3pwTemagZxU5B4Z6Drv
	 3mfGH87v9XIWWjuUSYPhLRpA8MGFbcvTDEyS0IKjKz/H2k8S4akESKZmxJ7VuTOTnByDO
	 GijX6q1GiUfQgnw3eeWasCSzBIsF5fYOosvhxYWBYhCfErpJMYHuseP4CUQXtrzRkKweW
	 Nh0bvIO6U1z+Djnx+NOZHAcrAqzCX8eu4CCGTJzSeblllGH2GEk5EFYAggv9V6BPNjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u2Mckaf7;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A750606A333
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 10:55:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A750606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u2Mckaf7
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a35ac4475dso11514135e9.2
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 02:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793876109; x=1794480909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=S3kBGMpJUDqyGZZ/3EY9QtmjH3XQ/06sMAWybkANdok=;
        b=u2Mckaf72MIFO28Q8RwfK/lbM5uktuJE64/vY3ti6Vu2yRYVEk3NoKZqDkWoJ982A/
         XJRnrA2u7LoZ/G7Y21kthouyeGcNCUv9NtRa5kdATIQj662s4BW49MNSqu0IrDgQ45X8
         iCBHrHr9b4+cC/w28QMebSAET2czFcRanHMQX86qtIXWI4uh+3otxo1J8Q35iqXL+eXj
         6wYZIDDPzNOc/2rCS87HRpYjja+srroLYbmp7Q91pvHKNrkqZBXjuKGLoZ99QtncLYZ/
         L9RsOXu9+W98X31RMtoTuJz59NE7I0os5Z+iPTwYyLB8YnEiLu/hO6wGDP6Fmdvvn43a
         MmhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793876109; x=1794480909;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=S3kBGMpJUDqyGZZ/3EY9QtmjH3XQ/06sMAWybkANdok=;
        b=a0iJBKo5wtf50nItNp/y0nAxx29Z7jGxBe4SvuUly7Eu7oWD9i/SPuUhJ9oCFS+b1K
         4+1QBkFSRru/veEailijlA9ThsZVgWoNzMtW56nNq0LOsV5OG5uMKuAnvdfb1KLoyZxS
         P/DZM29xcrtg2NWLEGKuGycTXgZDXENCSMwQs5RdXBp2d7Pmlic7Rio74fDvCDpeWxJT
         m6a5IwhGmIXyNG5zVQZlRiXUAgYFNdYTQPiqnHPzkNZ1ZvfOwS7gdX8+XfOYcXtuoxCU
         qmpinPkq+vh7TA8XuBl75PZxJWYL1p3gfQrFR/mhk4jrhJ3RBCjVuFbNuBJacGke2LIz
         f+Eg==
X-Forwarded-Encrypted: i=1; AKwUvBztUQzphLlSHhxLylk34ksILuYmlKbb2O9lHcmY1zrg2nhDxTvjEpDgjZmkEcsyDSBFytjk/q8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/HZjxSUSxdrmkGqpqS2PKZ+7wlA11nlmmHLSOFv2GiAfC5AMMi
	Qp7pfbMcDeE9DcNWiOJnIbKanm3X8877g/0citcIclIsNMCMf/H6w7/b
X-Gm-Gg: AYBFou2ofjbDnAgEQyZe6IClYIe9o7bVg+n6izZiUGvC8JoLfBJdh/ERmaYgVCc+3nC
	yr8OftYH/XCWsizmIIg6uOh6uS8Q8hrbSqCctbyRWC5yHsrod805uUAjS5I1qdABSEb4XQ1uZek
	MDvd0h5WSya8PkD+MgnS7ox6JzUYH0+hT95docbCGI4X4FK5HcMxg5SAVN9EuQPhDMmhrWXDZvY
	JELq7vQllVxV0uqVlLEdZWHhrJCJy3FImCE33+2yjRZSUK34YGVIbMq7uVynQP7mLAnwDd5gUtL
	UiWwceaN3nhfsICHlGnNXvhuzOSVIok5kpiCfWbINFAv+qWifOr8FH661v5EdhfZUg6tUQhBaDP
	QCMoThTB928RgU1wcgtZcn1fggxc2nuK72L7J+kunCuBh8VfOKSLappTNdAekf/rHEDp03R8E5I
	Q4R2Dqe+kNV4TUdpmLqkDmkOK9pdPIM0jGGb6TZPRRtDiuL+xlnVYMFbrzUl1yhBXvgCtn8XD1m
	A45LK1CQ++l82VwgrCJsMgb28JYURlG7fb3/FgA5qar/wxtc3LNYjBYDcqrfXDm8ZK5eic5THCj
	phwqCPfrh5P9Eyfv4uPrIgy/R5GcX+BISyA6JDe30Q4EAmpAHgpnyaVpggNov0JE2GeVwbrm8uy
	kVj2HLjb4NPJhpdXkTipqHnQM
X-Received: by 2002:a05:600c:5397:b0:4a4:7a8d:c736 with SMTP id 5b1f17b1804b1-4ac16acfceamr398713475e9.9.1793876108729;
        Thu, 05 Nov 2026 02:55:08 -0800 (PST)
Received: from Ansuel-XPS24.lan (93-34-90-148.ip49.fastwebnet.it. [93.34.90.148])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4b57317cb8esm59576355e9.13.2026.11.05.02.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 02:55:08 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Joris Vaisvila <joey@tinyisr.com>,
	Ahmed Naseef <naseefkm@gmail.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net-next v5 0/6] net: phy: mediatek: calibration for AN7581/3
Date: Thu,  5 Nov 2026 11:54:56 +0100
Message-ID: <20261105105504.1024-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
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

Changes v5:
- Add review tag
- Add additional helper for phy package
- Use __phy_package helper instead of phydev_p0
- Better use lock and unlock for phy package
- Configure base address for the phy package

Changes v4:
- Fix typo in Kconfig
- Prevent out-of-bounds for zcal_ctrl
- Protect concurrent rext_sw_calib_done
- Validate port 0 presence for calibration
- Correctly set shared local variable
- Use phy_package_init_once for shared tables
- Better handle early exit restore
- Better handle phy_select_page

Changes v3:
- Address comments from sashiko bot
- Apply review and suggested changes from Airoha
- Rebase on top of net-next

Changes v2:
- Split header register patch from cal_cycle part
- Fix missing EXPORT_SYMBOL_GPL

Christian Marangi (6):
  net: phy: mediatek: export __mtk_tr_write
  net: phy: mediatek: move MTK GE SoC registers define to dedicated
    header
  net: phy: add additional helper for PHY package
  net: phy: mediatek: split Airoha code to dedicated source
  net: phy: mediatek: add calibration logic for AN7581
  net: phy: mediatek: add calibration logic for AN7583

 MAINTAINERS                              |    9 +
 drivers/net/phy/mediatek/Kconfig         |   18 +-
 drivers/net/phy/mediatek/Makefile        |    1 +
 drivers/net/phy/mediatek/airoha-ge-soc.c | 1917 ++++++++++++++++++++++
 drivers/net/phy/mediatek/mtk-ge-soc.c    |  521 +-----
 drivers/net/phy/mediatek/mtk-ge-soc.h    |  374 +++++
 drivers/net/phy/mediatek/mtk-phy-lib.c   |   77 +-
 drivers/net/phy/mediatek/mtk.h           |   15 +
 drivers/net/phy/phy_package.c            |   57 +
 drivers/net/phy/phylib.h                 |   73 +
 10 files changed, 2537 insertions(+), 525 deletions(-)
 create mode 100644 drivers/net/phy/mediatek/airoha-ge-soc.c
 create mode 100644 drivers/net/phy/mediatek/mtk-ge-soc.h

-- 
2.55.0

