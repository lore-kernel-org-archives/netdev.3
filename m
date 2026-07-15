Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62A22737E0
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 08:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784103759; cv=none; b=jNI5yAtp3ruz77mqgIQXL4lzdsdvA3MmfdhxB4HJSkPMaUNzCzYdseeGRucCqrxaQVSX60KjXuPnIFKnxuMCbq8qaXNN13nRGXoMo5qXbeaDaER1JGlumpL3i2FqLdYraMrEJAau/ujqI22LAz+tcxmCCc/34RLwZhSNAnIm/dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784103759; c=relaxed/simple;
	bh=DU/+EaKPgZZ1Z255c6TxZisIkoQ+eDDYWmhfaqIQR1o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kNYehZItIhsDWQ4Ce2g9Rp1c0F9I0BujUsYwFtXS5zLrM5RF8LLB3LJhm6EsSYjmyl9AO4EyBtfA1GsC/E9Xpf05wzZv/1Zip1DMiz+T3Afgss5MfYtjibj+4dSYdLgETNwjQZLJlsBSEtSGLo9WSMX5BzF70hINIYaZrw6AwRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KKT3l9iz; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KKT3l9iz"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id B9235C2B9C5;
	Wed, 15 Jul 2026 08:22:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DF5876035C;
	Wed, 15 Jul 2026 08:22:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C166911BD3B64;
	Wed, 15 Jul 2026 10:22:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784103754; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=kTPBD2LU65EJF00nmjeTyfG7jzO1GtK/GiPZNunpEb4=;
	b=KKT3l9izvPzpvWVbj3Hqt2ci5KqLPErkxtEGvf/xksgS2FT+6eLJysJ6tkWe6gat/eyYQ/
	jA4kfE4DTcjlQEdIyIkH7At8zr/OG0pqzSLOZYxlOQep4VaiUPjQUcgfksLaRWsZpgIpDB
	xLsqLe6ODvO0LElVXUsRuV3VPaSi4G2X9dUSdbY4caETaNvz4z8LGTGBd2cASRtXtYXUhc
	H++u6xJ3GQsLEu5NnkNYjPa0eDY03o3R77DBdy4XWBatBiFuq/kDVMU6zLF+k9DY5J61Fy
	nwNfy8Bslf1bnoUxPII0Qj6gZ6sTpyHKrXEFtQGwTqlsQxHv0vwSCbGEy/+sUg==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com
Subject: [PATCH net-next v2 0/2] net: mdio: Rearrange Kconfig menus
Date: Wed, 15 Jul 2026 10:22:23 +0200
Message-ID: <20260715082226.51481-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

In menuconfig, all MDIO controllers and muxes are listed directly under the
Device drivers -> Network device support menu.

Let's group these in their own subenu :

Device drivers ->
  Network device support ->
    MDIO controller drivers ->
      Mdio driver A
      Mdio driver B
      ...
      MDIO Multiplexers ->
        MDIO Mux driver A
	MDIO Mux driver B
	...

There are no functional or KConfig dependency changes in this series,
just menu reorganisation.

V2:
 - Add mux submenu

V1: https://lore.kernel.org/r/20260712201739.260742-1-maxime.chevallier@bootlin.com

Maxime Chevallier (2):
  net: mdio: Kconfig: Group mdio controller drivers in a submenu
  net: mdio: Kconfig: Group mdio multiplexers in a submenu

 drivers/net/mdio/Kconfig | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

-- 
2.55.0

