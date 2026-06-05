Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C1947B432;
	Fri,  5 Jun 2026 07:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780645493; cv=none; b=pFn0WTsfQ/ydhbglPkddL1U9gmTjCS3hiPG3Adjh/f1KsZAgjQ7gdqT04fslEVNLzakhPNJPKM6zZqKfh0gWZ2hHcxGZGWWJmnXOBNKZ2OwnmkK670zHP4WMPhHUAOWpxGC5PaFNgyO+1dONsSAnO7cOlr6/uCuU9Ic7saT8jNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780645493; c=relaxed/simple;
	bh=4bEZbwNr96N8q8ruYinI3Xxo9B2GJ3hy71B/uj7qA0s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nv7MUwmqaGN3xNnZUDoZHhj85x/AKzIotDafnQWvHyW/ZFqAnxEdxQKkrGLAx/wpjHsLmJ3a6cNor6hgpwJGaBN6JkCXqfDsUyLHujFvSXXQ+4GkMlR1Jw/lwIRJyrb7hDXdW2vt4bmOJs77d8yyX0p8uArZllcOv8XqUBnn5uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=iN0XFG+N; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="iN0XFG+N"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6557hTeU51221753, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1780645410;
	bh=iAuAcHyW9ngdN8p/ip5z8PrWS/Tb9Pesd6bn8uLu4ps=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=iN0XFG+Nith/vgtY0pviPli6FuzQbe9Fyv/r7geUr/4KCjytA53+7QbLl+YPeAORk
	 5KggZGTHjak47v00L1Ky/q22AYymnARv0+9ckSdHqSVU1Mb5J/8Js2Cewz6IGbRK59
	 Cu2BCMEttKgfVnDff730aFmnsWNljZ3eZzAUwn/niuHpB2WFmpCu2HQX9KpMz2ThID
	 IOi0VLIE7EL1/n2rrtIc1xK7WFujqbK2M2X8rAaqxZORhZRZrX3K0/Chir4ZP+3gj3
	 8i5bpxXXAG7fb1O+0KO9bgL8lA1+8aWDicHywp1xVPv2usDCJfgW1fhLmhuKKV3DJw
	 MZGZYEiV2DP1Q==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 6557hTeU51221753
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 5 Jun 2026 15:43:30 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Jun 2026 15:43:30 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 5 Jun 2026 15:43:30 +0800
From: javen <javen_xu@realsil.com.cn>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <freddy_gu@realsil.com.cn>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<daniel@makrotopia.org>, <vladimir.oltean@nxp.com>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v3 0/4] Add support for RTL8261C_CG
Date: Fri, 5 Jun 2026 15:43:24 +0800
Message-ID: <20260605074328.1800-1-javen_xu@realsil.com.cn>
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
  net: phy: c45: add genphy_c45_config_master_slave()
  net: phy: realtek: add support for RTL8261C_CG
  net: phy: realtek: load firmware for RTL8261C_CG

 drivers/net/phy/phy-c45.c              |  64 ++++
 drivers/net/phy/realtek/realtek_main.c | 406 +++++++++++++++++++++++++
 include/linux/phy.h                    |   2 +
 include/uapi/linux/mdio.h              |   3 +
 4 files changed, 475 insertions(+)

-- 
2.43.0

