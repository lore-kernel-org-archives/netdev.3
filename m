Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944DB3A6B61;
	Mon, 29 Jun 2026 06:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782715748; cv=none; b=XyfG40udDCLhnk3tbUmhUmNcelO5Rn5Dls7W0MvWBnQIsHdswCiRgVr06lx4+Q8X3iwbTXoNQXLNM/mnwha4oc+xyJqGgB3XaV8xnfkyfxmG2i93EHj9wA3fAblQmkHx4GeZD2j17JumL8LHVv4FH9HnLC6Dokcc6B1pfy87fRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782715748; c=relaxed/simple;
	bh=l5nkpwShdfjRB7HBwsY+4t1nxYUn+pmwiQmwceB/3DU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r3xrgZFrIAXvr8JH6sjrrUq4X4Eas7SFI/rfLkhnsgau53cQv8gY528NXzF6lc1V55WRjiDYE6Nwccu8PuIsV2nN3Ljhs1DP8USrfKVtqHtl/GbTpfLl3NbbWdcjtz2bBZdwBHnUwCxiRpf6Vr7A4fPvdMI6D7OIlXfyDPTYGiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=mr6YxgPW; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="mr6YxgPW"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65T6lKHj93483096, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1782715640;
	bh=hN5gMjD+iDpeYsE5xD0KUIXtre9++kgFD3pZwu1E5HQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=mr6YxgPWGFVkYsnzb1YLfymiCo0GlEQe1vBOR+WLd9awFfjjyXK9UY9E10tND6jk9
	 4e4pQDt23chcxwuCqHzllNxTEhQZ2RVMeh7vmZBYhqTQ/9l/bl4tWOtl/GqyFkT4iS
	 Q8hkDwEyYmgoBbGeHUAwPws8o8MrhPl3DHCOM+CWZl5nh3qLB/tRHAPgh+0JWWCeZO
	 BAim1SIDGLgD+Z3bKDskjzlEngBdlBbskBnnIesveAtzCDP908JxfGb30KuJ0YJY2R
	 xnZPfGoNCK8Df36v9f/IHDBt6g2WNrFoK6GjXB1EKJT3OHs8IyoEnx3bDGwAP0NzZx
	 dFxg5GEpi3xCA==
Received: from RS-EX-MBS1.realsil.com.cn ([172.29.17.101])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 65T6lKHj93483096
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Jun 2026 14:47:20 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS1.realsil.com.cn (172.29.17.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 29 Jun 2026 14:47:20 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 29 Jun 2026 14:47:20 +0800
From: javen <javen_xu@realsil.com.cn>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <freddy_gu@realsil.com.cn>, <nb@tipi-net.de>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<daniel@makrotopia.org>, <vladimir.oltean@nxp.com>, <nic_swsd@realtek.com>,
	Javen Xu <javen_xu@realsil.com.cn>
Subject: [PATCH net-next v7 0/4] Add support for RTL8261C_CG
Date: Mon, 29 Jun 2026 14:47:14 +0800
Message-ID: <20260629064718.1349-1-javen_xu@realsil.com.cn>
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
 drivers/net/phy/realtek/realtek_main.c | 406 +++++++++++++++++++++++++
 include/linux/phy.h                    |   1 +
 include/uapi/linux/mdio.h              |   5 +
 4 files changed, 537 insertions(+)

-- 
2.43.0

