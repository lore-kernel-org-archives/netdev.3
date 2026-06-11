Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356DA3BED75;
	Thu, 11 Jun 2026 09:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781171071; cv=none; b=EPXi0ckmA4wm7tRusyqxKGQkX9ml8bNTaJQw9kHDvvCGoVPJxBwE5GfKskp9NbYwN+QceC5R45AGtaIQQbhed2yMt0KeOeg6TeKo+0hW2Y7WEFEHdYH+vEqX0tJwQTqFP1Jlmu/fWyA7+SsJIMGh06JnUl29AC67URl42E6XZpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781171071; c=relaxed/simple;
	bh=J2JK6m2KrtHwooz9apf9bBkOqzJPQSFL9vN3u8LnnnY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pB5AcJicDcZVLuUpRFg/h8YozyvesezxWXk/MbsM4Fz5p3M8FgsdRjNdIgvadCjuC9xi+/kukSOe83oDOgBDgu10Tv4XLZKUxT/hC42J/65q+pk/YNTxbL6Sz/FlhoPNC/a76m3a9EQ/Nz4ypKQx/zgSaA0X3boB4Hy6nrM5zxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=Wapfk5Qh; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="Wapfk5Qh"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65B9hkr871836008, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1781171027;
	bh=Usum0u6vuU3f0+FOLSI3jIEdEbqt4l8ooSxvrj8bNKs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=Wapfk5Qhk1BdUmx+35HJTANn0en0qJp4vsH8UwiTDDrYqTC+G11GTS8UennQZY/bo
	 BRDIHPGOVzacyKRJIBeGPSuc/fxF/CX5t2keegbuQqC5BjLgCGQdEWFurpzYyt1uOX
	 qwJab+6Iixj5mvGX9WHyhLz35wQRHW4tqdvt4Z2+FCrGBE2ckeh/9lcrxCCVPm5nl5
	 nRJYJqFtS3KwtdYulh7WDUicxKdBo4BQ40E6wpIXXNahLQFuWlT4JJCpVyJwHJ5B0e
	 zqIQIQAUuOBnopXwpI4pyJpVvEd4IJLO+6QIHR8tAqxFkwnMZP7PUGUEUmt9GLGgPF
	 Vz+/dTErgcWEg==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 65B9hkr871836008
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 11 Jun 2026 17:43:47 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 11 Jun 2026 17:43:46 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 11 Jun 2026 17:43:46 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <maxime.chevallier@bootlin.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v2 0/6] r8169: add support for phylink
Date: Thu, 11 Jun 2026 17:43:39 +0800
Message-ID: <20260611094345.880-1-javen_xu@realsil.com.cn>
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

This series patch adds support for phylink. RTL8116af is a fiber mode
card, link status and speed can not be read from standard phy reg. So
we read link status and speed from serdes reg by pcs. We have not changed
the loading process of RTL8127atf.

Hi,

This series patch mainly add support for phylink framework and RTL8116af.
I have tried to remove tp->phydev as much as possible. But for realtek PCIe
nics, they are single chips. Some internal phy shared the same PHY id, but
the required PHY parameters differ depending on the specific MAC/Chip it is
integrated with. And we can not tell them part only using PHY registers. So
firmware here can not be moved to phy driver.
To improve code readability, I merged part of the code which use phylink
independently into rtl8169_init_phy.
And as Andrew reviewed, RTL8127atf should indeed be integrated with phylink.
However, I found that this was a patch submitted independently by Heiner,
link: https://lore.kernel.org/netdev/b012587a-2c38-4597-9af9-3ba723ba6cba@gmail.com/
So to limit the influence of this patch, I want to know if I can release a separate
patch to refactor it later?

Thanks,
BRs,
Javen

v1 link: https://lore.kernel.org/netdev/20260605103906.1445-1-javen_xu@realsil.com.cn/

Javen Xu (6):
  r8169: add speed in private struct
  r8169: create a virtual interrupt for linkchg
  r8169: add support for phylink
  r8169: add support for RTL8116af
  r8169: add ltr support for RTL8116af
  r8169: fix RTL8116af can not enter s0idle and c10

 drivers/net/ethernet/realtek/Kconfig      |   1 +
 drivers/net/ethernet/realtek/r8169_main.c | 549 +++++++++++++++++-----
 2 files changed, 438 insertions(+), 112 deletions(-)

-- 
2.43.0

