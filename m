Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AAF45FFA5;
	Wed, 16 Sep 2026 08:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789546562; cv=none; b=rAg/9sB8fBSzUb93tsYMyqkp/A+25BmC0iEqFTNb+0VfpDJHj9m0urQ6cqy2vB8P7CKdD7jO/jRyZMRvnidMDZpgcXZbWXrmvmocCuEprdtHlZcTS+CvyXn44GujoxbKKN3+nG8uX/y89HBvuEihIOylvZ2AW0SsmMVJvdQXgzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789546562; c=relaxed/simple;
	bh=P/BirNS2lknHF5FEZx2QbcQoAILuTC7BlMfBhq4Ifsk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HvUD8PjBQUIhOsC4TtwqKZnf0cuzAe9JrCvpgtRDE+LsSzu7sEGq5YDTa7/16yZSUkYkPAzIN50bbwQnNt7e3ZIOdSwSAf4EjQblMYHAa0lUdpaWXigH3/8lKTKlBQ83UqaGs7fZPfQ3LejVZTCKvh/HsfxdJeEPs/lW7LGZCqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=GEc8VfEC; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="GEc8VfEC"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 68G8EkRR22223080, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1789546487;
	bh=TlUJhM1HssJRTbgHpaw4bI1yhJsLb/Ka2mFtobYsUok=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=GEc8VfECyEHSh0aAy7wt/xbNybnncQpKUcAH1WUXHFJaX3icilj2A2PSf5QJfW2lU
	 E69/IYAaQNDAVGWDbanFFJy4Hwank/muXoG/yP1H3OVl2Ao8aiVydihiBDZdw8ixt4
	 zxnzJqyuuOPTWMRXDm6OaWPSMIP9rYPAMopzYKuQ4WWJCDvrWCLVXc6pZA1RPsf5rm
	 NyG7+zu8ZXqq7XIW77TKsB30wlcXEL+BJEmRcsBrUMXjWtvSGu/s4WKJKx8QGSyBt9
	 Dn4hTN/VjrsDJP8KpngeTRB2qcBAE7UHt/MxV5wy6Hf3KN+7ZUX0RaK8tgGGjxnF6o
	 Ue2s6leU1Dxfg==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 68G8EkRR22223080
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 16 Sep 2026 16:14:46 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 16 Sep 2026 16:14:46 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 16 Sep 2026 16:14:46 +0800
From: javen <javen_xu@realsil.com.cn>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <freddy_gu@realsil.com.cn>, <nb@tipi-net.de>,
	<maxime.chevallier@bootlin.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<daniel@makrotopia.org>, <vladimir.oltean@nxp.com>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v1 0/3] add support for phy chip and firmware
Date: Wed, 16 Sep 2026 16:14:41 +0800
Message-ID: <20260916081444.497-1-javen_xu@realsil.com.cn>
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

This series patch add support forRTL8261CE_CG and RTL8261D_VM, and add
firmware support for RTL8261D.

Javen Xu (3):
  net: phy: realtek: add support for RTL8261CE_CG
  net: phy: realtek: add firmware for RTL8261D
  net: phy: realtek: add support for RTL8261D_VM

 drivers/net/phy/realtek/realtek_main.c | 39 +++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

-- 
2.43.0

