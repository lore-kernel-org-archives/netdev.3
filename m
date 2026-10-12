Received: from relay.smtp-ext.broadcom.com (lpdvsmtp09.broadcom.com [192.19.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0682148035F;
	Mon, 12 Oct 2026 16:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791824290; cv=none; b=oo/RgvGJayNjilQF7WJ/z8YjQmrQVMQEZnsUG0JdkniSN9LeZhWpYcDz10YiVF520HVTIWqyfHUvCALdbtmLrhzKSsaevnkrbrqfjh5hkTe/2cGnt57AXkSOPAShv61LqH9EVVKSBdLJJX4uDsGY4RcIc4chA0iGtxE3ogXOKDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791824290; c=relaxed/simple;
	bh=zll7pBkaHbkXB7vZcTbnxv4YSU0M8g94JI5PwWIyRHA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AXjYcD76rs3td42QowSw6K7YeeXzHsHzgyp50N3JFEH5CzydOQ3tM5Edc/Zyb71G0K/R3r3QBs7yHgVKAKE25lU8tIgYCqPCGtq1HS+bjffwQE5DDe3yLLYSVtEzc257eUtrWNLegW93YmfwEpe4MBtcPaMdFcgyiYq2EVyyW9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NAQIWfno; arc=none smtp.client-ip=192.19.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NAQIWfno"
Received: from mail-acc-it-01.broadcom.com (mail-acc-it-01.acc.broadcom.net [10.35.36.83])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 778EDC0000DD;
	Mon, 12 Oct 2026 09:57:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 778EDC0000DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1791824278;
	bh=zll7pBkaHbkXB7vZcTbnxv4YSU0M8g94JI5PwWIyRHA=;
	h=From:To:Cc:Subject:Date:From;
	b=NAQIWfnoVQciNO41/T1GD/PmpC1QsY5cNXyZ2LHS7VSkzJnk5X3dOD78zQYO13n6Y
	 Klb1Wll5Pi9hR5ZRs5NnGaHPZ+Gj+mfq9K0IemenAj0WaSXvIJkENvnEskr9flF5qe
	 6ea+v9iTpWqpV9c/iz+Zu8NUTHDaCqzi28bxXI54=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-acc-it-01.broadcom.com (Postfix) with ESMTPSA id 3CDA6AEA2;
	Mon, 12 Oct 2026 12:57:57 -0400 (EDT)
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
Subject: [PATCH net v3 0/6] net: bcmasp: Collection of fixes
Date: Mon, 12 Oct 2026 09:56:48 -0700
Message-Id: <20261012165654.3480668-1-florian.fainelli@broadcom.com>
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

Changes in v3:

- add Nicolai's and Justin's R-b tags where collected, except patch 6
  that did not make it to the mailing list somehow
- removed inline keyword from bcmasp_netfilt_is_companion per Nicolai's
  review

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

