Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD4E23394A;
	Tue,  8 Sep 2026 07:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788854242; cv=none; b=Q7QwFgvrgg2B845Eid+2FFo9BIAKKefnx7DbbLE5trDJ8VqJin0J6/x8ZowqgZrc6lKOYEJnwMjRmZRsLofkeJwaUiou0dJx2cnssU6KY6aO0lfXFl6WD/NMbpx/SbTMxQWLAnoet5dTUhWP/7E9c1EaGzGUhtiZAWfR6mYx1RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788854242; c=relaxed/simple;
	bh=QwEVYQq5cumVejWm4FUkPiED6ffweUd14oaEFzIycZ4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TJU0Q1WKtIrHUD/6RIe9gr0zpnt/GFXr8bOAUs8pwFZ/y1RZcHOPJQSIKLP/TfBmyadTHU2ztcNG+JxOOUEaFVdSjZ5BvG0sde4axDyqIcJ0ykuTUR4fB/qqKmzbBouErz8LtLDMALBuaNVMcQD9Efgt1WpqP6mYK/BheBGSH68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=B8HbniLd; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="B8HbniLd"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6887ucTE33640598, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1788854199; bh=e8YOM91foRSIUsLMni1Az7kXwBYhPd0eiDngIKq59CA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=B8HbniLd8sbEFwKYxHuaIspCwzckIh80K6CIhvsDIbJirPFzCqJsRYgnO4xCXuTSC
	 0aG2ODS06i+pveYpPzDzjrCNo/BxhKnCS0gQvRN+Bz9zyaPewnMqABA7tnvQAQkxgJ
	 kY1+1bPVlIfS2M9A+X68yGrp6xpo+G5gWKu9LKXP2U82nNX4EGPCTHPwf2cn9tu4bs
	 m3DNamtamQp/PU1ubkAVTLYuuSFkhwAvmCmW0EJn+umG9qgweQFdpAIc6GmgtLkUI/
	 G73Z9VPk0Yw5X+ACp8bR3s3uW0uI+Ysq2t0aQiJ/KXPzn8TeWZlfcCpS55q/PNUzLq
	 ZdcOxEgGGRVWA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6887ucTE33640598
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 8 Sep 2026 15:56:39 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 8 Sep 2026 15:56:37 +0800
Received: from fc44.realtek.com.tw (172.22.241.7) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server id
 15.2.2562.43 via Frontend Transport; Tue, 8 Sep 2026 15:56:37 +0800
From: Chih Kai Hsu <hsu.chih.kai@realtek.com>
To: <davem@davemloft.net>, <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <nic_swsd@realtek.com>,
	<linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	<edumazet@google.com>, <bjorn@mork.no>, <pabeni@redhat.com>,
	<hsu.chih.kai@realtek.com>, <andrew+netdev@lunn.ch>
Subject: [PATCH net-next v3 0/8] r8152: refactor and extend RTL8157/8159 support
Date: Tue, 8 Sep 2026 15:56:26 +0800
Message-ID: <20260908075634.23740-1-nic_swsd@realtek.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

v3:
Rebase on top of latest net-next to resolve merge conflicts.

v2:
- For patch #1, use read_poll_timeout() to replace the manual for-loop polling.
- For patch #2 and #3, rewrite the commit message.

v1:
RTL8157 and RTL8159 have different init, enable, up/down, hw_phy_cfg,
and PHY access sequences from RTL8156.  This series splits the shared
callbacks into per-chip variants and adds the missing RTL8157/8159
functionality: dedicated unload and change_mtu callbacks, TGPHY register
access via phy_read/phy_write pointers in struct rtl_ops, flow control
patch support through rtl_fc_pause_pkt_en(), and UPS support via
r8157_ups_en().

Chih Kai Hsu (8):
  r8152: refactor r8156_init
  r8152: support RTL8159 for different packages
  r8152: refactor rtl8156_enable, rtl8156_up, and rtl8156_down
  r8152: refactor r8157_hw_phy_cfg
  r8152: support rtl8157_unload and rtl8157_change_mtu
  r8152: add TGPHY access support
  r8152: support rtl_fc_pause_pkt_en()
  r8152: support UPS for RTL8157 and RTL8159

 drivers/net/usb/r8152.c | 1297 +++++++++++++++++++++++++++++++--------
 1 file changed, 1054 insertions(+), 243 deletions(-)

-- 
2.34.1

