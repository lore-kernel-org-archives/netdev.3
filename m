Received: from relay.smtp-ext.broadcom.com (lpdvsmtp12.broadcom.com [192.19.144.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B4155C327;
	Tue, 22 Sep 2026 22:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790115445; cv=none; b=BqZhscXcmbmfgCre6yLDL30EArERhnEwuBLjzYYZA8EiabJ9ItvJjDFBGUTmNNMG6PMAvvNuGTQOjGTJzpJzVFsn7Ch/i615RSemHoNnFC52gcH0cuEwJsiDLcZdFl4vqb/A2+4CbGRexIu74+b2RDkkilCMP7d2Wj9L6/KdXiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790115445; c=relaxed/simple;
	bh=uRGyrbOUMzQfhjV2mwrwwfwtQsdGgUoEcMf3Lx6KI+4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=edlwoaEiKtEDehEgCW3UvTG4P77rt04usvt7NaVWn5Q2ETFRMu8Zh7X+J2HN4Tou30ydMLKSCPAcq8Vb/Wo8w+TdaKcdWwHyCSqGL6qCo4T71zz/WdFAfmvwBTURC+w0s/3EeC4KLypkB7XKX83pQKndcpW9ArCrKPyrSa5on4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aHr9ZYrb; arc=none smtp.client-ip=192.19.144.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aHr9ZYrb"
Received: from mail-acc-it-01.broadcom.com (mail-acc-it-01.acc.broadcom.net [10.35.36.83])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 6D569C0000FB;
	Tue, 22 Sep 2026 15:17:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 6D569C0000FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1790115426;
	bh=uRGyrbOUMzQfhjV2mwrwwfwtQsdGgUoEcMf3Lx6KI+4=;
	h=From:To:Cc:Subject:Date:From;
	b=aHr9ZYrbMzrSRbYwF7wmlushgOyJMZtuJItjGL9PZMumU5Z74YJqJXFlhsgVzQbnO
	 MWcR7BwrIhVKR85tzx5wkQYlG9wVLD8srdvP8RTTToUzcccR8wGpJWrxof21dDX3iR
	 Hqau4anW3avq8+sCIwgNYEuCBuHFj6Oibtr9sg0g=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-acc-it-01.broadcom.com (Postfix) with ESMTPSA id 5160AAEA2;
	Tue, 22 Sep 2026 18:17:05 -0400 (EDT)
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
Subject: [PATCH net 0/6] net: bcmasp: Collection of fixes
Date: Tue, 22 Sep 2026 15:16:24 -0700
Message-Id: <20260922221630.3864427-1-florian.fainelli@broadcom.com>
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

Florian Fainelli (6):
  net: bcmasp: fix mib counters struct alignment with ethtool stats
  net: bcmasp: unmap previous DMA mappings on TX map failure
  net: bcmasp: validate minimum RX packet size in bcmasp_rx_poll()
  net: bcmasp: fix OF node reference leak for phy_dn
  net: bcmasp: account for offload header in TX short packet padding
  net: bcmasp: fix network filter lookup and wake filter pair allocation

 drivers/net/ethernet/broadcom/asp2/bcmasp.c   | 127 +++++++++++-------
 drivers/net/ethernet/broadcom/asp2/bcmasp.h   |   4 -
 .../net/ethernet/broadcom/asp2/bcmasp_intf.c  |  25 +++-
 3 files changed, 99 insertions(+), 57 deletions(-)

-- 
2.34.1

