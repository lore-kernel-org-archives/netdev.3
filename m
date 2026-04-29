Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF533A2550;
	Wed, 29 Apr 2026 07:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777446505; cv=none; b=uwjpbfoR0ah5KLb00Fimv1OQSeE+H+IxVsMWYJgvUPB2M174t8JTn+fYaSc2L28el8yiSKy9xpOqPL0mlZVd032JeCaBVw87Wm62Va43WmtMS/ltceShMdmpa7kzT6fbUoTAeeQOYVFbrNERbMgDy3TFooju6wlnLIQ84SMnk20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777446505; c=relaxed/simple;
	bh=LHvHk9wT9cQmy7E7onyCKxFJGKzrJmyu2ITLVPN9HNs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uEMzYHHqvODUmAcawvTJrXbTwFBadTc5FT/EZiLdL6vPO2nD36aOtwlxXXPJMeBRrg3Y/AuPN+dYxJlveHH/BFtajQSAdFam1kdB3RbvuLFqFES/6wkXP1RNiTOAJTV8DGW8VFRxoeVXpVRQo9tDX4Kq8hBD/GLKAr5Lwp17x5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=CbTZKcTD; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="CbTZKcTD"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63T77qvaE1069969, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1777446473;
	bh=2SqM0TNUN/1Wx/hGComi5YDdmUSn1Iu0mpWOi8sIdfQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=CbTZKcTDCZs/FFp3AGJ62uZSXziZsXHueqvN95bLWPdLUl9zzNjQg1CPsga2YozUa
	 dQ8JxfULlJo79mo32eoDCI2AKGKdDW29+uyLlrM9QAA0/PXsOfPsHyPpjihtROdbbC
	 /Pqimy0OPPeNdkiAq3fbjKftfIMehue5+s71HxlG2ujFx5+vdJ0JtKPeXE4ka4dZZY
	 27Mq58q/brUZ+hszOwWdQGOxviFVZ/WYj91jEEjJ6RHrpoPe72NlOD8TIdcmisUzlU
	 F8OHCjQelOetIXgbrVGemkvNZNQuvnupWrfg7WNm8cEQjFAZGcphleAhBGsiPgSvfv
	 Vf7NywpOEFigA==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 63T77qvaE1069969
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 29 Apr 2026 15:07:52 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 29 Apr 2026 15:07:53 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 29 Apr 2026 15:07:53 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [RFC Patch net-next v2 0/8] r8169: add RSS (Receive Side Scaling) support for RTL8127
Date: Wed, 29 Apr 2026 15:07:42 +0800
Message-ID: <20260429070750.1477-1-javen_xu@realsil.com.cn>
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

This patch series adds RSS (Receive Side Scaling) support for the r8169
ethernet driver, specifically for RTL8127 (RTL_GIGA_MAC_VER_80).

RSS enables packet distribution across multiple receive queues, which can
significantly improve network throughput on multi-core systems by allowing
parallel processing of incoming packets.

Key features:
- Multi-queue RX support (up to 8 queues)
- MSI-X interrupt with vector mapping
- Dynamic queue configuration via ethtool (-L)
- RSS hash computation for flow classification
- NETIF_F_RXHASH feature support

Javen Xu (8):
  r8169: add some register definitions
  r8169: add support for multi irqs
  r8169: add support for multi rx queues
  r8169: add support for new interrupt mapping
  r8169: enable new interrupt mapping
  r8169: add support and enable rss
  r8169: move struct ethtool_ops
  r8169: add support for ethtool

 drivers/net/ethernet/realtek/r8169_main.c | 1217 ++++++++++++++++++---
 1 file changed, 1095 insertions(+), 122 deletions(-)

-- 
2.43.0

