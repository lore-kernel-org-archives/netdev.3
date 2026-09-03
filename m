Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB993FA5FA;
	Thu,  3 Sep 2026 07:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788420573; cv=none; b=JaTGkAtkrC4rOyO1A+aHpZmaNpOkwkMA44Mg6SwcD5LzEyPirU8KZksqwuaSKBDVABf+PCBvdkO1gnqPs8YGXZWbl6gc3bEUEcp998H6DHmEzCvUdC+Tpx9+DHWdHllU5eCql4HXw+kccAiYZsbwv/ovw8YpJbzwjDnkKCAFlT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788420573; c=relaxed/simple;
	bh=SP5leQ7EOjT+t3/lX8bAfxtvWio0fRo6/uwqQ+Zphvk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cQs0Ncc6eLJATyxqUtXfubppvpsgO1ceCq/emsq3RAFp5bj4nWSizzmUTHo+rkIONGu+LaTT8f2Ae840X+i7LCHtZbvNjAXf9aSV4elsix1C7fcphzI3evu7V9HX4qCzDDRrltmZpQB8P5+7COPNII+qCstoQn1tlIRKK10zGXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=V7/Ln8w9; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="V7/Ln8w9"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6837Sst763295535, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1788420534; bh=qXW4ejm288IPRbpZ3IOPHC/49Ey6/Gm9+hs4kMyoh20=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=V7/Ln8w9yVBcu92mk2WxxygXLO7lvmA6oEWDIwWwwPNUUf4b2zmx0f1Lk6ZwLbNpA
	 35AYTFAlft56jRdrMkH5jY0UVnozhBESBknV4ggmtOxhXlhUFK9kFagbE15r/L+n02
	 qWKCudBtpibCHqIzJhJu8fKVnVMkW47vktpXHY7Qvdeihlnr6fnN/F2T40ZHDId9u+
	 dOiY9ec6ROO2VF74WYndvmF7o3/4hW5zxAeBlj/at977WK7eu4EGlq6WD5zWTEXpSR
	 7xnFrz/8iH6CzuGYQUyZkaaMqt98BoGl1BvfR4Df3he2ijk1z/wYAW1hDyTy7KRgWY
	 dHp+Rnaecza9w==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6837Sst763295535
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 3 Sep 2026 15:28:54 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 3 Sep 2026 15:28:53 +0800
Received: from fc44.realtek.com.tw (172.22.241.7) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server id
 15.2.2562.43 via Frontend Transport; Thu, 3 Sep 2026 15:28:53 +0800
From: Chih Kai Hsu <hsu.chih.kai@realtek.com>
To: <davem@davemloft.net>, <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <nic_swsd@realtek.com>,
	<linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	<edumazet@google.com>, <bjorn@mork.no>, <pabeni@redhat.com>,
	<hsu.chih.kai@realtek.com>, <andrew+netdev@lunn.ch>
Subject: [PATCH net-next v2 0/8] r8152: refactor and extend RTL8157/8159 support
Date: Thu, 3 Sep 2026 15:28:44 +0800
Message-ID: <20260903072852.58695-1-nic_swsd@realtek.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

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

