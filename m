Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4F143BDD0;
	Tue, 22 Sep 2026 23:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790119487; cv=none; b=kgWKUqAA71CXaVC58Ha4enp41RBE4dFD2cRnnUPhZuy7gJqB6ybm6rbplnGeB94E23u39MWNiRP39pP4D8RxXc1V7qnV8BG53YiXihUjjbx+Am5K7Inv46CtB9TGrctV9VvTmXi+hNUbhA+KYChW48DOLg9w256bINpj7aMbfHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790119487; c=relaxed/simple;
	bh=HStwkcjBH4M25tJlUTm8pNBLpAzp1wnGkks8K8hYEkM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h9LJC84sYtIuzA3qO7xly+7yUCPp6SEtCDvZmL2q4caZGaW6ltknTcTEmH8yd6PGPOwXPLjYT6s/WEf82/bu1uiTOXr/UKKvdJDI3QnaplnRVWwT9TI7eYXbmxWysY1MzAtIi8ykaxQ6XqwXksvWWk8MDxX/Cv5E7XwYklPcMdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ajFAOvsE; arc=none smtp.client-ip=192.19.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ajFAOvsE"
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 46A60C0000EC;
	Tue, 22 Sep 2026 16:24:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 46A60C0000EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1790119485;
	bh=HStwkcjBH4M25tJlUTm8pNBLpAzp1wnGkks8K8hYEkM=;
	h=From:To:Cc:Subject:Date:From;
	b=ajFAOvsEHmqA+4z4498XTjEEiryOHtUINA08FfCNI55wiEC0HvKwQzI7U57oDqoVk
	 /rtB6ank4tx/9BxZ3Q0KBHvNf0x0p395cxCsNXUtWWXKu8Sarr9e7P+VLIHEcBOp4s
	 3AmOnU9ndE5hRCXWMkD8nm5W/h74tjg1HX3QWqwM=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 1DD6BACC;
	Tue, 22 Sep 2026 16:24:45 -0700 (PDT)
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
Subject: [PATCH net v2 00/10] net: systemport: Collection of fixes
Date: Tue, 22 Sep 2026 16:24:30 -0700
Message-Id: <20260922232440.598918-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v2:

- dropped patch 4 and target it at net-next
- dropped patch 11 which needs more thinking as to what is the
  appropriate DMA teardown sequence wrt. topctrl_flush
- addressed Nicolai's feedback
- added Nicolai's Reviewed-by tags where provided

Florian Fainelli (10):
  net: systemport: Fix buffer overflow in bcm_sysport_get_stats()
  net: systemport: Fix invalid dev_id argument in
    bcm_sysport_poll_controller()
  net: systemport: Fix NULL pointer dereference in
    bcm_sysport_fini_rx_ring()
  net: systemport: Fix Wake-on-LAN RXCHK filter enable loop
  net: systemport: Fix RUNT MIB counter register offset calculation
  net: systemport: Fix potential packet length underflow in
    bcm_sysport_desc_rx()
  net: systemport: Fix out-of-bounds array accesses in DSA queue mapping
  net: systemport: Fix inverted error messages in bcm_sysport_stop()
  net: systemport: Fix unbalanced Wake-on-LAN clock disable in resume
  net: systemport: Update TDMA queue mapping dynamically on changeupper

 drivers/net/ethernet/broadcom/bcmsysport.c | 73 +++++++++++++++-------
 1 file changed, 50 insertions(+), 23 deletions(-)

-- 
2.34.1

