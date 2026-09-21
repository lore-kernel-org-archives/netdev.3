Received: from relay.smtp-ext.broadcom.com (lpdvsmtp10.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F7A476058;
	Mon, 21 Sep 2026 23:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790032482; cv=none; b=XrbB9i1PoJkHAahfGvhrcd+uhOeHUiUmNM1PiXRET+E4gl3+ofMcoV1gSykTQ00ixGklxLkgL3QOm2JkSaNmcLkQQqGLdJxa8bAQcPoFLHQN87CZmLVJ0jFsbvQjQsmutbVf6GB063u2ze2LKK4ZFHBy+Kbrq0JDrlBvJ4U2zHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790032482; c=relaxed/simple;
	bh=5FKgRsJrAY8NcpTKCQkSDzVdr+mS9Po0Clm4HeUjZyQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qSdoZ1OoOmkqSRd/k6mivrVB1e5PznLUELeDyat0c3pawUg9yRdZJXcrajyCCLsVORUX2ia/f/iEPB4KDrh/MQgkbT224OvFmZjthVk+SzQ/q1xjRyqRDseF0tDH1E0mry19U/eXnwr2MZG79nPM9bQNDLSQ6KrdIpNyoR9z2AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LVSBtf8d; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LVSBtf8d"
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 77A0FC0000F1;
	Mon, 21 Sep 2026 16:14:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 77A0FC0000F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1790032472;
	bh=5FKgRsJrAY8NcpTKCQkSDzVdr+mS9Po0Clm4HeUjZyQ=;
	h=From:To:Cc:Subject:Date:From;
	b=LVSBtf8dXZkEcoJ4wzOhUWSMpd7IdAoUISTvmFRnzUFZ6x+q/eWpK9SUvZkwIZiuR
	 zpBNnudun/rwdJz5WGBF2np2LtnEPT4hlFpwe1UZIg3CAElEn/hqDpAVGFzfUM8os4
	 VOErNqUPCW5SuJjg85yiP9uXpkf2SZJlhGZAOjqI=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 1D933ACC;
	Mon, 21 Sep 2026 16:14:32 -0700 (PDT)
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
Subject: [PATCH net 00/12] net: systemport: Collection of fixes
Date: Mon, 21 Sep 2026 16:12:53 -0700
Message-Id: <20260921231305.394773-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series contains a collection of fixes accumulated during a
LLM session.

Florian Fainelli (12):
  net: systemport: Fix buffer overflow in bcm_sysport_get_stats()
  net: systemport: Fix invalid dev_id argument in
    bcm_sysport_poll_controller()
  net: systemport: Fix NULL pointer dereference in
    bcm_sysport_fini_rx_ring()
  net: systemport: Fix missing phy-handle parsing for non-fixed PHYs
  net: systemport: Fix Wake-on-LAN RXCHK filter enable loop
  net: systemport: Fix RUNT MIB counter register offset calculation
  net: systemport: Fix potential packet length underflow in
    bcm_sysport_desc_rx()
  net: systemport: Fix out-of-bounds array accesses in DSA queue mapping
  net: systemport: Fix inverted error messages in bcm_sysport_stop()
  net: systemport: Fix unbalanced Wake-on-LAN clock disable in resume
  net: systemport: Update TDMA queue mapping dynamically on changeupper
  net: systemport: Complete resource teardown even on DMA disable
    timeout

 drivers/net/ethernet/broadcom/bcmsysport.c | 89 ++++++++++++++--------
 1 file changed, 58 insertions(+), 31 deletions(-)

-- 
2.34.1

