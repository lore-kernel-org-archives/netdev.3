Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110D434676F
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 02:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785118261; cv=none; b=ezzMWcG6+3SgdW0G9Z1oP09aAO5KebvYH+TU5vpfY14y+wXUC66srUFNFZALdi+ep3/BKo2Fq9ZGSN55f3EynwcdlXmRFYkvMH4CQag3cBDP3e4LKY7x6a7nuhBzvGgIP+KgYi0EgqnxJFm4KfAgvZs70i4yZ0p9IoFGwy8i+dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785118261; c=relaxed/simple;
	bh=HHbbIv2CzMT4Xs41/oIKw1y9fr2SjFQAVeRApZiFdmU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gt3Gw76xVKlRBF3nqXpV5EkspL8+DLlqtYWfzhcVCqTKkqYdlbT8bu3m+ruhvlRcK2UEHCl4DpPCKhMLQAAR7O8sU8sjwahO4KzEc6wz7PMILCmFTtRJjqJ9H2oaKoBAnH89yMql+FU2EmBOrBds5c5uU98UP5lZH0ThPwIXQWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hdoUAG1q; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hdoUAG1q"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-384930ca5e2so2007139a91.3
        for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 19:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785118259; x=1785723059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1WNF/t9pK2HwnPJWbDOD3dXmKgsh35CNG6w7c87mKE0=;
        b=hdoUAG1qTUPlkfxhMFL63bCrXUNCgJJ4eXiX8ftyyX+h5l7IfK3ad1NDI2UUPmHDx6
         C0UpdnmFYLJmdikBi2O6KyHL/IB0JFV5PV7xmJDpqDSb1snfPIqZFUrjzOVEmPM+pFEA
         fg640MdAttBKaXc8yQvJS4pti3pA+GgaoqTX2bKdms8tfR/fGKHrESDLEaOy9ROLUCXT
         0MzcbHOp7kYyXClCCi6HYHuV+AUU3Xu2jPqcBZBO1Yk1iTQ2btsfvhXmQrgIzgbUwAam
         Gq3/Hnqddv0QninfYqMTci/QMcP5dqJZlJXBqMnOLJrWwKapMHlbotJc1SMj7el7YOlE
         RoTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785118259; x=1785723059;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1WNF/t9pK2HwnPJWbDOD3dXmKgsh35CNG6w7c87mKE0=;
        b=QI2PQuabKPiA3qvZH54ooNwNogHlCTmstcXaFNt9rDxe6igIftvVCP3sh6M4eVKERh
         aCc9yg4T9UqB31vYbodVTmei+2tX0ZxnWeMXr5+BfZgcwiRo+fyHkjPhFqMId6tKlIy8
         Y//haiPwyo7GqLtwsMpA4xePk0WEHxL1e4HWgZhi8kp/OAnZdV8Y4sRFfhj4Bzuts5th
         WGrjhm40V51LcF9p3K9pdsr29SQndt251Ze6li8IOGpsCMGfGVrEX92DKODc6L0dwhDI
         s1cs2YuN6EZNo3oJEIQAc+qc2GD2ACMQ/spGOpPoC4kgHYgBmNUup9V2EuBifFCE2jW5
         AnWw==
X-Forwarded-Encrypted: i=1; AHgh+RrUHymcy5ktOyHE+DhBUuu95/R005hcfwV8I1raVJbyM8W6lJHLsZ8CXGS4LS1WirxQoprP11c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDucqgsEYeE2ftWvJ814wx3YRP99fgmhV4+Gbn47EHIOnoH8o6
	Bwu6KQR5mz7L8aDEyv8aZ1CMpHb25KiLzbf0mblGAUjuhjvRJgiZ9RMzn0zIteX2aE0=
X-Gm-Gg: AR+sD13OGmRnUbPKjNX8wtJOGBW8xGGzGJm5hzLFaMDFzawPtYNQwviwdrKBRw4z1ei
	9RahD4H6Pwc0pEHeAB+FTByurMYXBq5WmB0ey03grnm81aXJ/IXxoBkSrWcqEpqmD77Q2Xda0am
	9w/uFL6AR+xt5MDUNyXBSzRrK4+wjrhx6uRHRRtb6OHhsffz4KQ/5MHDYb77zqA22jpUfstdqHY
	m33u8HIoLa/hujsnRo276OZZCvhxdSTosm+n3sQAyxkGEyg0bJWOm6ioVPTK7e+DBT35ZLpl2pK
	c8/VJb7k3cun5yTAE+CiD/+c6E8Y5V6T8E2PhrMZC/iGj3TDZsSTC+2wULtM0K0sUEKjrOlfh4O
	wxzml7T1tzwVhZRk0i8h0iHPFrjsnUyP3ucbdVhnyHfVbb6l1PQpO+GWcR9M2zWbjVPx7cSBGlV
	V6yjyvjMq/Dvh3+DIxiwId4RE=
X-Received: by 2002:a17:90b:2791:b0:38e:67e1:15b with SMTP id 98e67ed59e1d1-38f293cc2eemr6150209a91.6.1785118259380;
        Sun, 26 Jul 2026 19:10:59 -0700 (PDT)
Received: from attina.synaptics-inc.local ([199.33.119.15])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13e53094d65sm19162200c88.13.2026.07.26.19.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 19:10:58 -0700 (PDT)
From: Gavin Gao <attinagaoxu@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	heiko@sntech.de
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	richardcochran@gmail.com,
	nicolas.frattaroli@collabora.com,
	sebastian.reichel@collabora.com,
	sashal@kernel.org,
	alchark@gmail.com,
	chaoyi.chen@rock-chips.com,
	attinagaoxu@gmail.com,
	amadeus@jmu.edu.cn,
	rmk+kernel@armlinux.org.uk,
	horms@kernel.org,
	alok.a.tiwari@oracle.com,
	david.wu@rock-chips.com,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH net-next 0/3] net: stmmac: dwmac-rk: add RK3576 GMAC 25M refout support
Date: Mon, 27 Jul 2026 10:10:44 +0800
Message-ID: <20260727021048.3375444-1-attinagaoxu@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Some Rockchip GMAC instances can provide a 25 MHz reference clock output
for an external RGMII PHY. Boards already describe the MAC clock direction
with clock_in_out = "output", but the dwmac-rk driver does not currently
request or enable the corresponding 25 MHz reference output clock.

On RK3576, this means the REFCLKO25M_GMACx_OUT clock may be disabled by
the common clock framework as unused, even though the board expects the
GMAC block to provide the PHY reference clock.

This series adds an optional "clk_mac_25m_refout" clock name to the
Rockchip DWMAC binding, wires it up for RK3576 GMAC0/GMAC1, and enables
it from the dwmac-rk driver when the MAC is configured for RGMII output
clock mode.

The clock remains optional, so existing device trees and SoCs are not
affected.

Tested on a PicoCOM RK3576 ACP board with a Motorcomm YT8521 PHY.
The GMAC 25 MHz reference clock output remains active and Ethernet works.

Gavin Gao (3):
  dt-bindings: net: rockchip-dwmac: Add 25M refout clock
  arm64: dts: rockchip: Add RK3576 GMAC 25M refout clocks
  net: stmmac: dwmac-rk: Enable RGMII 25M refout clock

 .../bindings/net/rockchip-dwmac.yaml          |  1 +
 arch/arm64/boot/dts/rockchip/rk3576.dtsi      |  8 ++---
 .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 33 ++++++++++++++++++-
 3 files changed, 37 insertions(+), 5 deletions(-)

-- 
2.55.0
