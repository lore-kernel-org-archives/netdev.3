Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E3943DEA2;
	Thu,  8 Oct 2026 21:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791493655; cv=none; b=Gwy4RVHM44k41RaHcPbbtgJJFVDtR+DtRZOe3h+XUxSt6cJuGqPQIRL2NyBLdMy12xKAfxGN3+QsndpwOStuaB8K/risMBNTMH+sLfM9GZYhW3IiYPl6j05oWOkPMzSKeFO81eccSf1xllirfvNQVg7cMHGtaduFEpCntj/xHKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791493655; c=relaxed/simple;
	bh=ajqblHRmADz/9e2NqXZ5vPhJ58FtjpoUwGELtsHj9OU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NTdtEKQpnyDrO1t7LwTUgMRLuWrTue7W97PoKDbOI3hmtB2PJGy6FYSsDEqAcjXhnWB6PTZJGCzVIiS7oFiMmNedmc9JSadYolII51BN9lIMVus6BikDe2CSs96dkvnb9s2uoZXLO4iyjpQuzBRJjLfGZsY1QWUq/npP2JkD12M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UoxWDsUY; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UoxWDsUY"
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 15957C0000F6;
	Thu,  8 Oct 2026 14:07:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 15957C0000F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1791493647;
	bh=ajqblHRmADz/9e2NqXZ5vPhJ58FtjpoUwGELtsHj9OU=;
	h=From:To:Cc:Subject:Date:From;
	b=UoxWDsUYzlT87INKrGQzO48bO6LQZJ//r81NzS5yjVkzr6FCWP7dIHs56fmzL2CB/
	 OjydTAMEhZmZQCZHVbpHIcRjIT1LG2ikuLCDdYSXh/+gfm7Ux+bcw1oWDClnHkzwU1
	 mJ9cA/dwgyoIlcoH0v9ybRKgk/KNk+siTSwe+f8s=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id B0604A83;
	Thu,  8 Oct 2026 14:07:26 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Doug Berger <opendmb@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Zak Kemble <zakkemble@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Ryo Takakura <ryotkkr98@gmail.com>,
	linux-kernel@vger.kernel.org (open list),
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net v2 0/6] net: bcmasp: Collection of fixes
Date: Thu,  8 Oct 2026 14:06:15 -0700
Message-Id: <20261008210621.1374785-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series is a collection of bug fixes accumulated during a LLM
coding session. Thanks to Justin for the internal review and helping
with the last patch.

Changes in v2:

- address Sashiko's feedback and correct the commit messages and code
  accordingly
- add Nicolai's R-b tag where collected

Florian Fainelli (6):
  net: bcmasp: fix mib counters struct alignment with ethtool stats
  net: bcmasp: unmap previous DMA mappings on TX map failure
  net: bcmasp: validate minimum RX packet size in bcmasp_rx_poll()
  net: bcmasp: fix OF node reference leak for phy_dn
  net: bcmasp: account for offload header in TX short packet padding
  net: bcmasp: fix network filter lookup and wake filter pair allocation

 drivers/net/ethernet/broadcom/asp2/bcmasp.c   | 121 ++++++++++--------
 drivers/net/ethernet/broadcom/asp2/bcmasp.h   |   4 -
 .../net/ethernet/broadcom/asp2/bcmasp_intf.c  |  32 ++++-
 3 files changed, 95 insertions(+), 62 deletions(-)

-- 
2.34.1

