Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800C8513575;
	Mon, 21 Sep 2026 22:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790028036; cv=none; b=Q9aZl6QdvnaW6Isl3J/2uhgoQZ/0BXc3ImWNlcHwTqqBFK/v3E7GFgGqztCeXNaxdPqXBl6Mykb5T1I2sx8Nwit0W+AfKmPrG000SydvDDN11tVb2vCEyF7R9KO1srju8W8WLDudBIInkrMkzNTQBXlodkj+RLfC5pqLdptqqys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790028036; c=relaxed/simple;
	bh=02lEeVJbwYQD2J5YmvOrAYUCddW2IeWUAaQ9GBJHuXE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WFi3Rqs5mOFtG+7N8Ra4Grk/FJk69HVpxLtDLBSgwGZNWAlSqwh3z6lxyq4OQTqPWRRBT5ki/qGGYR9MhGxUWIjsEdupkc5iKdUzkvp1I6FCI7hDQMEBfDH14aFf3iIcKarF81ThJx8E8T6GFNAgw5JllqomX5ElrAiq6eBbQa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=K6HLmxx0; arc=none smtp.client-ip=192.19.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="K6HLmxx0"
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id B629EC0087B9;
	Mon, 21 Sep 2026 15:00:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com B629EC0087B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1790028028;
	bh=02lEeVJbwYQD2J5YmvOrAYUCddW2IeWUAaQ9GBJHuXE=;
	h=From:To:Cc:Subject:Date:From;
	b=K6HLmxx08dMGQ1oPIK6I9y/L/KsViA11EYYaKfPMJlM/JcC759AwMMT7n+6ieuCFB
	 HRWFRKksyFpzFQxy8DOyTQHMLy9/Aba3SBPH7WQM7+vDA3jgT5cJtFE+CHw4wqKhnM
	 MYF+W63lkp/L8kABOmirocnVA84kogcU49tieNIA=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 8495EAD9;
	Mon, 21 Sep 2026 15:00:28 -0700 (PDT)
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
Subject: [PATCH net v2 0/5] net: bcmgenet: Collection of bug fixes
Date: Mon, 21 Sep 2026 15:00:16 -0700
Message-Id: <20260921220021.281418-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series contains a collection of bug fixes found during a
LLM-assisted coding session.

Changes in v2:

- corrected Fixes commit for "net: bcmgenet: do not skip WoL power up on
  GENET V1"
- dropped unnecessary patches

Florian Fainelli (5):
  net: bcmgenet: fix 64-bit RTNL stats reading in ethtool on 32-bit
    systems
  net: bcmgenet: initialize u64 stats seq counter for all queues
  net: bcmgenet: do not skip WoL power up on GENET V1
  net: bcmgenet: validate Ethernet address in bcmgenet_set_mac_addr
  net: bcmgenet: mask DMA_TIMEOUT_MASK when reading DMA_RING0_TIMEOUT

 .../net/ethernet/broadcom/genet/bcmgenet.c    | 28 +++++++++++--------
 1 file changed, 17 insertions(+), 11 deletions(-)

-- 
2.34.1

