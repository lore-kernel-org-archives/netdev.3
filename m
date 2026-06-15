Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CB528C869;
	Mon, 15 Jun 2026 09:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781514589; cv=none; b=C4/wSEkROsGiQppbsT0UnUoYMTdoX3YHPRh3yGWCBPzuU4PV8rovirx+1Xt5AVvA0pXOel5YuiFYCvSJIuA5oPwZFyBnqP1mVttgPcWiiBNjZe7zJTaE6y799j/bvgI7RkLucGQIuO3ZoEhFUQ4DB/ZSexy9gdoTak3JZ+aLowE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781514589; c=relaxed/simple;
	bh=m3E+kZWhK0DH2tpUR769lJwSC7SOSCRvthtrfuEYFfM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iu2YSCvgwHaf7oct+tAaXuu7/ex8+VN0Q+x4+Wxz2xqLhQTWfivxtpLV9fRsDPDr6/xiIxG87fXXw9exv0/6Ev2IOSN70HwWLRnU/1ekoOtFHJZ3e/AjDIWSNhLtUvUJwGe3G1Q6ei4bZEHdKA7xCysvytnxl4BrMd1uMx9rCJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=kd/QOmBE; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="kd/QOmBE"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65F98JxG4611677, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1781514500;
	bh=+URlNXDAvvY+rnXpegkxzKYYnGACBDuUYmQRB5T+uf4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=kd/QOmBEfOFFChEpTnXL7jGnEjKjiH0sKQzAr3czQrg8JV1iD3a74F2wcQgjJfWXd
	 XQ31T7AswWIgsII7F3c8g3LNKd0s/+ue0edtiCR4Ngx2s6JmoYEbENAsg0zDJl14Hz
	 IID1lE8TqDNGb1lrEKbH85qKkO3wPj6pX3UEXVqmwSJujO7kv+DQtVJGUmAtAp8ONo
	 e5UWVoEmbi/ep4nSkm9dsW21OVUBX48+wNfhGiudqzikMy/7HZ6n+jwXcFl7PK60al
	 /Hc8OSXqOLOiYuo6GXvf5ABSfDMns7Op6xyFqNtNgbgPhPf9he/mMnxHvUuDhzdOTz
	 +e8BnwK7APT1w==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 65F98JxG4611677
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 15 Jun 2026 17:08:19 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 15 Jun 2026 17:08:19 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 15 Jun 2026 17:08:19 +0800
From: javen <javen_xu@realsil.com.cn>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <freddy_gu@realsil.com.cn>, <nb@tipi-net.de>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<daniel@makrotopia.org>, <vladimir.oltean@nxp.com>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v5 0/4] Add support for RTL8261C_CG
Date: Mon, 15 Jun 2026 17:08:12 +0800
Message-ID: <20260615090817.429-1-javen_xu@realsil.com.cn>
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

 drivers/net/phy/phy-c45.c              | 118 +++++++
 drivers/net/phy/realtek/realtek_main.c | 407 +++++++++++++++++++++++++
 include/linux/phy.h                    |   1 +
 include/uapi/linux/mdio.h              |   5 +
 4 files changed, 531 insertions(+)

-- 
2.43.0

