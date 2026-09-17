Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CD03B42C0;
	Thu, 17 Sep 2026 07:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789628842; cv=none; b=iTHmOYGZkmF3Bjo0Sis3zCJXome3d+vtcNCfyofbLVgc16cq5SVo+fvlZyunq/9z5FeRIraJvS2QUnut2l4nM77mu+jKHVatEhDuhR4x+tclKC/CSfxGQEBYXVR/bOtIDSCZKTKdXXYFSHG1wK3WMm7LR/hT63t11JkN87P3ldA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789628842; c=relaxed/simple;
	bh=RDMU4mbu0LOGMrjEt5vcBCei63cRi2qDbffY6mMq374=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hZGuWJcaI1ZefMfc7HRZc32fQ0gDwASSMJ1YqLor8VINJOG24eTlfViKuscuy7ft8FaP7Uxs2be0oeLvk03VrXUxLsqxUoPqS0dCGSze4boDXCQkS9YLp4+66W+M1M9FZMmyT2l0Lg/lTVS9esepYoDC4Ax+P7i6i8iNkbmq9jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=W9dBdNhk; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="W9dBdNhk"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 68H76ec363094124, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1789628801; bh=H0c6+qp7TAZT0jYDw3Sqn73cMGZPrQHEZ6PRx22wm/I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=W9dBdNhk2DjPzg3/qoektkE9h83uisKFLbduD+d2dN0p7ixquq9yVRmpPtCjJ1KNT
	 sg/EoLyfS6YGj8+ZZVX2Lx8UBbw7DDIeohbtYZQ0iWC8QbnI7h4kge5lkzLNdABy8L
	 jhbTD5ckeQR6cQpd+vv7x2XvwN6P31U55/wVLzUkPDq3RUamqGbgxoQ8cEOgMiGp/g
	 /mq3go1JvoyALEnnNU1jrTtWVKZ9TKOSYUN+Dedw03qBynjdChmsSSKDA2Dbhv9/SV
	 RkUqYudzID74crC4Ur6N9t/BoYqpScWTHCSzCZjn4COGXnx+w6wlkrMoUr2+y0laHb
	 /f2P8SCBgbM+Q==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 68H76ec363094124
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 17 Sep 2026 15:06:40 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 17 Sep 2026 15:06:39 +0800
Received: from fc44.realtek.com.tw (172.22.241.7) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server id
 15.2.2562.49 via Frontend Transport; Thu, 17 Sep 2026 15:06:39 +0800
From: Chih Kai Hsu <hsu.chih.kai@realtek.com>
To: <davem@davemloft.net>, <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <nic_swsd@realtek.com>,
	<linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	<edumazet@google.com>, <bjorn@mork.no>, <pabeni@redhat.com>,
	<hsu.chih.kai@realtek.com>, <andrew+netdev@lunn.ch>
Subject: [PATCH net-next v4 0/8] r8152: refactor and extend RTL8157/8159 support
Date: Thu, 17 Sep 2026 15:06:29 +0800
Message-ID: <20260917070637.62827-1-nic_swsd@realtek.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

RTL8157 and RTL8159 have different init, enable, up/down, hw_phy_cfg,
and PHY access sequences from RTL8156.  This series splits the shared
callbacks into per-chip variants and adds the missing RTL8157/8159
functionality: dedicated unload and change_mtu callbacks, TGPHY register
access via phy_read/phy_write pointers in struct rtl_ops, flow control
patch support through rtl_fc_pause_pkt_en(), and UPS support via
r8157_ups_en().

v4:
- Patch #1: make wait_autoload_done() bail out immediately on
  RTL8152_INACCESSIBLE instead of waiting out the full 10 second
  timeout.
- Patch #6: propagate PHY access failures instead of ignoring them.
  ocp_reg_read()/ocp_reg_write() and every helper built on top of them
  (sram_read/write, sram2_read/write, the ocp_reg_*_bits and MDIO bit
  helpers) now return int and stop silently operating on stale data
  when a TGPHY access times out.

v3:
Rebase on top of latest net-next to resolve merge conflicts.

v2:
- For patch #1, use read_poll_timeout() to replace the manual
  for-loop polling.
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
  r8152: split r8156_init per chip and add missing init writes
  r8152: split RTL_VER_17 into QFN68 and QFN100 package variants
  r8152: split rtl8156_enable/up/down into per-chip-family functions
  r8152: split r8157_hw_phy_cfg into RTL8157 and RTL8159 variants
  r8152: add rtl8157_unload and rtl8157_change_mtu
  r8152: add TGPHY register access for RTL8157 and RTL8159
  r8152: extract rtl_fc_pause_pkt_en() and apply it to RTL8156/8157/8159
  r8152: enable UPS for RTL8157 and RTL8159 QFN68

 drivers/net/usb/r8152.c | 1655 ++++++++++++++++++++++++++++++---------
 1 file changed, 1306 insertions(+), 349 deletions(-)

-- 
2.34.1

