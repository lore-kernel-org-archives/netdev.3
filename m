Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CD32517A5;
	Thu,  2 Jul 2026 03:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782962468; cv=none; b=nwSv6Uv083mC6mhPMxv0brf/a+VIclrH8jBhczMG1NmZEmDXwM79SZ5kZXBe/5MNuU00t/AwXBcGv8hqRLluuSsnQzazsGD9xtmjcOm/dFZwoyskyh/Xwu4M5FqQJJPEhuIIXierL00d/y9zV0Eo5e1ST3Pp2F9329lMkBZXnJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782962468; c=relaxed/simple;
	bh=XOYXPK4eY2qHO6VnearKjECsfKVn3r1ysmh5m/Gt4y8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OSovetQt9PLYGfSNQeMeoIQDNLGyMgLgR840Y3zwLi2yYr4u/szcN71Nbjf0KwXglMNHdY3mHFTx8BiKWD1H+psa3jUNtVmUEMyUYw89ERAwZDM0mlAklzRkB3AY2rDIlliOc63+FUuwdEqiXknIRpndAjdgKojgTifLD5yENG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=jbAZsodg; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="jbAZsodg"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6623KMD001649089, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1782962423;
	bh=U559lAwdVVfHwM3Bfn91SXZYh/XETbyUSohtXYlM7zk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=jbAZsodg15gwdHD9AcwSZsmeoefitSa8jYpCZfDowppDe6n6JJRy47A7AVSK1QB0n
	 ZlKckWwGfxqomaaIoGwGCHuqiT8flBkoJurM5Q3UqasQBNybAwJqh0pWu4mJ4edsUN
	 +a1ohLgHIa3yBVxZhoDBbIfLEq6mf/Qn6iDxNOuNdxZfGuqJcFj76BAN70OJhM7tok
	 I0VI4vM+f5JRKGFymy4zrG4Yoa30FRGgUKJsRJt1G+mMlPeg96WuAPfX1pm62Dvnbv
	 JuLpb3ydJgnzvbFXUtGWluZAkq7qLJK8Sktrro5oVRplVB8z9Z5phBKFKh3CYReR3c
	 8JTDyQtNWRWYg==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6623KMD001649089
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 2 Jul 2026 11:20:23 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 2 Jul 2026 11:20:23 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 2 Jul 2026 11:20:23 +0800
From: javen <javen_xu@realsil.com.cn>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <freddy_gu@realsil.com.cn>, <nb@tipi-net.de>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<daniel@makrotopia.org>, <vladimir.oltean@nxp.com>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v8 0/4] Add support for RTL8261C_CG
Date: Thu, 2 Jul 2026 11:20:15 +0800
Message-ID: <20260702032020.589-1-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Javen Xu <javen_xu@realsil.com.cn>

Add support for RTL8261C_CG and add support for loading firmware.

Javen Xu (4):
  net: phy: c45: add genphy_c45_soft_reset()
  net: phy: c45: add setup and read master/slave helpers
  net: phy: realtek: add support for RTL8261C_CG
  net: phy: realtek: load firmware for RTL8261C_CG

 drivers/net/phy/phy-c45.c              | 125 ++++++++
 drivers/net/phy/realtek/realtek_main.c | 400 +++++++++++++++++++++++++
 include/linux/phy.h                    |   1 +
 include/uapi/linux/mdio.h              |   5 +
 4 files changed, 531 insertions(+)

-- 
2.43.0

