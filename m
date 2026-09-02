Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB8940B0FA;
	Wed,  2 Sep 2026 09:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788340040; cv=none; b=cH8idCq1QoY+VhWytqpRVvKBJlciSzxPN27s/kyyQKd/Ys/HkCT6lOlnQQGOh87QNIDGMbjFrKc8w+yypAw/mU8+EEP7X9oDnZL2GsFJyhf4BfLsjfoTc+fO7UcOpjTFLm8FjJ61UlFqO38cmG2yKLCf+z8Y2bKzhgMSwlYBW3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788340040; c=relaxed/simple;
	bh=gsdeDRUybUisWv6Ll+6w8bay49Xe/bjDxzAGDMkf2vI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Mh42KklL/iK6nHtqIURKusq04a1QtO8FdUIVT+SI+6rD7M0plAHxy3R4C2tBx1Q5qWZekmQoV/rT7Gxz4U11OIVLu4NmQifGhtbO4G4zUbJeaRRuXPQKnMZqSloPCgnVsgGIcEyKj2IqukMNjuDva0HqgJZkxW7zp1c+bYgi1OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=APkJZ5Uu; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="APkJZ5Uu"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 68296Zr842526839, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1788339995; bh=Tym3NAGAstrYAPiDlaHsqMFDDSYFEK8Y40C5ERwfeNE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=APkJZ5UuhUbtWRkubL1229hvvSgHyIRcXZZS4h7d3u8Y62TWTVtsQjbamV81ipGIk
	 IMhfcwcrOwXYysj1rDr4lzW6GlPtcZ4O7qjSPDLlzT9NyLuiJA0xUbofh65udnStwx
	 J/8xKDNOl6cK8wfcidmr4Ra62Qyuu/tuFTz1NCc6p4MYoe+tJKCK1rtsdYuBS7sCe2
	 tJIPuQFo3g70mS2QPmWCBcnHiSnV4z9HnT3VpXgkUHyq4d+8OJ3FOd4PgcLpBgWvD5
	 kl2jTC57vxibwb4h1Te2mh8Zu/QNMK3iD71lUhpdecG1/1zuamaBN974JSuKnJAIY1
	 hC6rtIN6Ed/YA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 68296Zr842526839
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 2 Sep 2026 17:06:35 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 2 Sep 2026 17:06:35 +0800
Received: from fc44.realtek.com.tw (172.22.241.7) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server id
 15.2.2562.43 via Frontend Transport; Wed, 2 Sep 2026 17:06:35 +0800
From: Chih Kai Hsu <hsu.chih.kai@realtek.com>
To: <davem@davemloft.net>, <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <nic_swsd@realtek.com>,
	<linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	<edumazet@google.com>, <bjorn@mork.no>, <pabeni@redhat.com>,
	<hsu.chih.kai@realtek.com>, <andrew+netdev@lunn.ch>
Subject: [PATCH net-next 0/8] r8152: refactor and extend RTL8157/8159 support
Date: Wed, 2 Sep 2026 17:06:24 +0800
Message-ID: <20260902090632.41844-1-nic_swsd@realtek.com>
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

Chih Kai Hsu (8):
  r8152: refactor r8156_init
  r8152: support RTL8159 for different packages
  r8152: refactor rtl8156_enable, rtl8156_up, and rtl8156_down
  r8152: refactor r8157_hw_phy_cfg
  r8152: support rtl8157_unload and rtl8157_change_mtu
  r8152: add TGPHY access support
  r8152: support rtl_fc_pause_pkt_en()
  r8152: support UPS for RTL8157 and RTL8159

 drivers/net/usb/r8152.c | 1258 +++++++++++++++++++++++++++++++++------
 1 file changed, 1063 insertions(+), 195 deletions(-)

-- 
2.34.1

