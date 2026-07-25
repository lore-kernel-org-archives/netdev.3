Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931242D12F3
	for <netdev@vger.kernel.org>; Sat, 25 Jul 2026 15:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784992268; cv=none; b=R502W0ApDFzmlxpPDOxX0ZaM62PwCoZxUiY3Dl8Lnj24E0pGo9+ETrdN0b1VuznKtiNM0m3H217EbXAgtS/0sGT5qbbPPNwD2/2573Lk+DFkiCTOkGAlkVyo1UdtWtmZ4TiZFFPwu9DBDEYae/jQ+X5WwkUY2oRVrIebttq5jW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784992268; c=relaxed/simple;
	bh=1ypKcIZETNEITGeMh/DBgTjLBGiZ2y/Q0iD9vHffUSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Cvc/TPTJR19BH6oxZDHRk9FaQf2kyyZicD9+sT7vcjPawswFLmpjI1/jJdlt4G13FuMnVKojor73tYaqzic4wjKsrU8RcX/zebYcgQDxdykRet3Up3j/kLcdTlj0SIpGWSjL0Jt852/nMHUtiGTSeazhCMSu1CVfvgroSVm9phU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oURwklN9; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oURwklN9"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-385ea3ce80dso1422681a91.2
        for <netdev@vger.kernel.org>; Sat, 25 Jul 2026 08:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784992267; x=1785597067; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SL7hBFcGY09oOgMOCy23V3evuH2qRKq0H2TcKBdPEAk=;
        b=oURwklN90/3jZlgPlnvtFMTkH5+ATLcTdF/P5yPFgvbAq/lWOEP6ICnA9SNdORUWnk
         /UJ4uBJ/zcSpmb4a8KdRcI/i48AUDTpzYkmaXhM2AsHyg/vXly1dvY5XTy8iX47oFy4a
         OxkNkYAQxhcBtj4qHUwk2OqF7vZp3zZImLEo2gHZ6tFGUee1vH8k0a2z7K6T54PPWm7x
         5KfXcQ+z8jBfU3A6CnwYPLWuH1TNxzbZYasGrhk5rStfzk6kRvxcrR2ATA8MW45A3hUv
         ONnnNViXMkBtRwSEGSQjMZbqZGrIp7er6Wn2E2iQRfdAsHpo4xskFmWeR8kAWgPzKFmU
         UIag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784992267; x=1785597067;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SL7hBFcGY09oOgMOCy23V3evuH2qRKq0H2TcKBdPEAk=;
        b=is/Qld3Fc9i4Jc3OyveQTw0vHIduhcH0Bnhx2t2gqr+88Wi5krQ8El8AlMAR9RJDc0
         6FH8Vnp96U7PakZeXHsllO2qhUbo2qB600MNMbiSCIbBmM7dwcL3SM68TFfXAaR6PMLR
         +oxu3uA31BdV68fm1gA5qbqxRvXONrrngv1fvjB1qRQsYktdChBiVP+i6K+PzAvLnl5M
         HJOPoo2NUPxia5TH6tNCJ3AndarYWSHYONlsS+znRsOVLyfmh/MRRE6Dq2scfORL0e0x
         gBSs7uvZgvtzdzh1/2m2T6CkuZWimEUlX/ZRE9YHaBssAXaJLOUjkOtD0rJvW95qd/Hv
         Gr/Q==
X-Forwarded-Encrypted: i=1; AHgh+Rqso4Doyg1KpYQeqYEZi4f8Id8Y2t5DI6ZFRuivv1t+LiugqO2wyJn9xMZxl+iWVqbsvBRoMdg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz8GfpuB//pfv1LTOKX5r7RZklWy2DtZbw3DZANqNpu2GRHOiK
	ntWAbj0BUG6ht3UEQjCNAQNWLPgVgn1TLzfhigHSYONvWHynYltbbXHD
X-Gm-Gg: AR+sD10POdanicCl28Iozfj4xyLDwtVAQ1gJm+zdeYib5HeKJ75pDgQLPBhQ929QgyY
	Ez5gbptzNb1OA13rsTJP3HKITN9q2q/XA/25AFuTvLX+JIHWTi3QcgD4x0KWNYZZRer9fXoswF6
	J70nDQxxzXxOK7xFL7Dhr7JQyvhAa8fYhKAZBSxs4s08Hyy8rSRXOlF5tn15mE1XjL6DLtCmQws
	LtrGuAKT+nhMQLFUd+mjBTuybr6nrFHrgRHGvbQehy+HuyNRWR+quSX+JTX8Yr0iIBHfn2dOwAr
	dRP8EJVFd9XriJzFONSTkTXHofH+c/jBfMZ6/Z66KRNUBj9xcq1LkMDhfunMdxWy3KKiEamFAUP
	Ynfkx10dffyGcKAXXMpEamAYWI6Kb2y1IizKsM0jM+2vPGCJdEQotUtgt0KomAl7HgrqMutsB
X-Received: by 2002:a17:90b:580c:b0:38e:7f1b:f01 with SMTP id 98e67ed59e1d1-38f2977c3b9mr2576061a91.36.1784992266734;
        Sat, 25 Jul 2026 08:11:06 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f031d1d6csm2907665a91.0.2026.07.25.08.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 08:11:05 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: kuba@kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Arthur Kiyanovski <akiyano@amazon.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	David Arinzon <darinzon@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Ivan Vecera <ivecera@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Manish Chopra <manishc@marvell.com>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Rahul Verma <rahulv@marvell.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Shahed Shaikh <shshaikh@marvell.com>,
	Sukhdeep Singh <sukhdeeps@marvell.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: GR-Linux-NIC-Dev@marvell.com,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	netdev@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	UNGLinuxDriver@microchip.com
Subject: [PATCH net-next v2 0/4] net: remove conditional returns with no effect
Date: Sun, 26 Jul 2026 00:08:48 +0900
Message-ID: <20260725150852.859188-1-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

This series removes conditional returns where both branches return
the same value, so the check has no effect. As suggested by Jakub, the
netdev patches of the treewide v1 series [1] are posted separately.

All patches are generated by the Coccinelle script, which you can
find in v1.

The patch grouping is unchanged from v1. If you would rather split,
merge or drop any of the patches, just let me know and I will address
it in the next version.

---
Changes from v1 [1]
- Collect Reviewed-by tags
- Change base to net-next/main
- Filter only netdev patches

[1] https://lore.kernel.org/all/20260723184538.3888637-1-ekffu200098@gmail.com/
---

Sang-Heon Jeon (4):
  dpll: zl3073x: remove conditional return with no effect
  net: ethernet: remove conditional return with no effect
  net: remove conditional return with no effect
  net: intel: remove conditional return with no effect

 drivers/dpll/zl3073x/dpll.c                           | 6 +-----
 drivers/dpll/zl3073x/out.c                            | 8 ++------
 drivers/net/ethernet/amazon/ena/ena_netdev.c          | 6 +-----
 drivers/net/ethernet/aquantia/atlantic/aq_macsec.c    | 6 +-----
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c   | 6 +-----
 drivers/net/ethernet/freescale/gianfar.c              | 6 +-----
 drivers/net/ethernet/intel/i40e/i40e_main.c           | 8 +-------
 drivers/net/ethernet/intel/igb/e1000_i210.c           | 6 +-----
 drivers/net/ethernet/intel/igc/igc_phy.c              | 6 +-----
 drivers/net/ethernet/qlogic/netxen/netxen_nic_hw.c    | 7 +------
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c | 6 +-----
 drivers/net/ethernet/renesas/rtsn.c                   | 7 +------
 drivers/net/phy/microchip_t1.c                        | 6 +-----
 drivers/net/pse-pd/tps23881.c                         | 6 +-----
 14 files changed, 15 insertions(+), 75 deletions(-)

-- 
2.43.0

