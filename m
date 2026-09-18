Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.166.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21CE305695;
	Fri, 18 Sep 2026 00:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789690578; cv=none; b=M0Jpq3OBfDyDrOJrVXTExSUgSNLybK3gamtan2PlKCZsNRPasSmoglIz7huR1A5RISuqzDuZZxmyvrxyV7iQvRmnosv7dfAW/FItavEIDjeK8U5/hQeWOXKVBoxPpu1iHq7uMf0VUFKCpP8mrGa5hchDde5WLkBODDqVtMKym2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789690578; c=relaxed/simple;
	bh=OiOwcBkbkjoZUpTK/Ebox4tz9Ue4SuyYxAXOMgufJxQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A1x/izM6lkJNTe0WPdidlB0cGSSPMvyB7m07K55KpWZG/rv/BLE43T5lC/5aEjX0EWJXh5PccIeuIzcaE7genKdZhT13hz4IORAWQnJ1uYtWevTB11cyYsiXxsaLNFqIx4WYmX8N0lK4+JJTIYNZBleOCKqbCAkJ7eRpgZ4bhbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=v8JaXz/L; arc=none smtp.client-ip=192.19.166.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="v8JaXz/L"
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 78D45C038151;
	Thu, 17 Sep 2026 17:07:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 78D45C038151
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1789690060;
	bh=OiOwcBkbkjoZUpTK/Ebox4tz9Ue4SuyYxAXOMgufJxQ=;
	h=From:To:Cc:Subject:Date:From;
	b=v8JaXz/Lq95KQ4Wt1u2fwudKwfUmYpBz6nIb4EhalVRYZeLqFSfOW2bkSCC6XfJF+
	 pqEEcHnFPwhrO1OjftghNY0Qy7GLX9d0Gyyntop78nDdn4Z3xhU+u9KO15hP8DLArT
	 z1olRuE5vQpUca8VjCgARYuewQi32SJv6kM0cZs4=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 4E9C1ACC;
	Thu, 17 Sep 2026 17:07:40 -0700 (PDT)
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
Subject: [PATCH net 0/8] net: bcmgenet: Collection of bug fixes
Date: Thu, 17 Sep 2026 17:07:24 -0700
Message-Id: <20260918000732.276506-1-florian.fainelli@broadcom.com>
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

Florian Fainelli (8):
  net: bcmgenet: fix 64-bit RTNL stats reading in ethtool on 32-bit
    systems
  net: bcmgenet: initialize u64 stats seq counter for all queues
  net: bcmgenet: do not skip WoL power up on GENET V1
  net: bcmgenet: clean up RX NAPI on bcmgenet_init_rx_queues failure
  net: bcmgenet: acquire ring lock with BH disabled in
    bcmgenet_dump_tx_queue
  net: bcmgenet: validate Ethernet address in bcmgenet_set_mac_addr
  net: bcmgenet: zero-initialize Transmit Status Block in
    bcmgenet_add_tsb
  net: bcmgenet: mask DMA_TIMEOUT_MASK when reading DMA_RING0_TIMEOUT

 .../net/ethernet/broadcom/genet/bcmgenet.c    | 34 ++++++++++++-------
 1 file changed, 21 insertions(+), 13 deletions(-)

-- 
2.34.1

