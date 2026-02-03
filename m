Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8242F6928
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 07:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770105577; cv=none; b=FSAxbh3deh0SMJ/D2z2NsvslWxNAN3C+YmDd6l4nlKRQbu8VmNo33XSq23t7ZMdkt2PSXLDNo1NpOQH5pgqvnZqqFiqYhzJgK4XV79W0k9Ruqcnkd8RCkDss98CaQix+eWMaSRLObYxVUdVMiwU+KsmnSmuj0Ov2Kdx/pIH+Vv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770105577; c=relaxed/simple;
	bh=7tY65D2hRJTEZwdIFKCVAygjB4i8sZW+z6K8GQPtGiY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r2hSUqT2bwhOOf3Cd9qocoqTtSyrMCsE9GXYcWYzOw5GgRGR1LvW8XM/5dGcKIx5pAjEeIviibx+j+xx3E6BwOt+Jabu6+Acg9/KlF7omkFZZBG71SxvthCTTrIRyb4yCwyepI9NSJnki9uAIR8alG0VsDzq51fUBo5LVs14hTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz7t1770105497tfca62438
X-QQ-Originating-IP: QAtK9cekhtfzk0D/37llOmat0pCehS0AwmM/LooQvfU=
Received: from lap-jiawenwu.trustnetic.com ( [36.20.47.234])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 03 Feb 2026 15:58:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1280410290080532181
EX-QQ-RecipientCnt: 9
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v1 0/7] Wangxun improvement and new support
Date: Tue,  3 Feb 2026 15:57:52 +0800
Message-Id: <20260203075759.5852-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OTaQrRjuGKLtTXqXXY8AW57dm+WrQPHAfHNp5J2Q1L9Ak2dN4j6Zx2mn
	FU3LOGcsQFC9k/wKmioyHMDWln4N1kP4oTTXRlFVgsh9JvhxeZCbK5Dz2vcyeuUOrDpVzib
	150747PFd4stvQK18XCH+DzOtSaJ0qC90m0YHOi0qnxk6xqVEGz1T4kdPlWualkqO/L6SWA
	RncEr7uJcMBTp/heIdNADuF0CaTrZ6VzKt5zhlv2k7Y3SfMZbARZAquWluJoirGPwUAYvvd
	49LClq3k4Odtx14lbG5qfYHwVyMdPmdZgb9PEZGqVeWZBc/pcI++fmEtHbeWjaPsofetQc8
	Fla/0ju98dKs8PTkndXRmyNsb1rkCUFaornC8cRkL+zfUNadi6rzILZ1cq64+Gu3+AA37hm
	Ih913llGGKzRxhxq8LNO3zXrpZrUJ6YPAJm+Y1yYdv6YNML/Iy2NBgHpaH6Qqksht1Ht3jK
	TA2RmooXe0TKGo6Ju3LnOetHb0ADklzUhFNdYQA1sssyguvfbWnrv1DkHnSSkpKiB9DR3p+
	fhUmrsQO6OLPq0Y1q2ZP7TrWsES8fb3pWZO/Vw9JKRHvEC6NN9Z3bVEV7/c86/R2JLZfRiD
	ZZhPUrGPa2F2kdjNx1rXu9ApSeyHt1rKJIvYdLSxFtrPArvuNNkKGoGpli6Sk2pJYMWOM2g
	ctagdsmMGqfe49NAdr9CGJNTBhnLpDGRhcJFRf5O2VYtbmmHN3tpzKWXWhKJFVij3hsFbdy
	0iPldctrFKZ9QPFD+Iz76scTwVtxcO83o5JODffBm1sBxLbw8CTF5Qt67ySqZdvwDEWpiQh
	ZElMPZwV5C0ZnVA4DNM0HKPa5+1PppUjwRwsLzqi1v/NwuFfFFy8JbHiGzqX5u1Dbekr0MM
	1XwestmzpUgQ3sXJ0jTy1/T79ge6maH7C/AU3DB/wLtp3xq9neVV/jRFaeqRU9cEBg8TZ8X
	NN9u4ByVbHY6nHHD0Z5C3nrQFw3RO0ZCt+ZvO2f951P9fRpQWZ+yIA4EaQVLLlRP1OBY7lD
	VlvHxRvA2Thzs2jAmla4tRs3fGqy2KoAtgWbuoucyYR5qs6OTQibuSMPGXxm8vQwzMSRHyM
	Q==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

Implement power management function for txgbe. Clean up the same code in
the two drivers, to make more use of lib functions.

Add Tx timeout process and PCIe error handling flow, to recover the
devices.

Jiawen Wu (7):
  net: ngbe: move the WOL functions to libwx
  net: ngbe: improve the reset flow
  net: wangxun: move reusable PCI driver ops functions into libwx
  net: txgbe: add power management support
  net: wangxun: move ethtool_ops.set_channels into libwx
  net: wangxun: add Tx timeout process
  net: wangxun: add pcie error handler

 drivers/net/ethernet/wangxun/libwx/Makefile   |   2 +-
 drivers/net/ethernet/wangxun/libwx/wx_err.c   | 359 ++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_err.h   |  17 +
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   |  38 +-
 .../net/ethernet/wangxun/libwx/wx_ethtool.h   |   4 +
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  60 ++-
 drivers/net/ethernet/wangxun/libwx/wx_hw.h    |   2 +
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   | 139 ++++++-
 drivers/net/ethernet/wangxun/libwx/wx_lib.h   |   4 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  26 +-
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |  52 +--
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c | 207 +++++-----
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h |  21 +-
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    |  17 +-
 .../net/ethernet/wangxun/txgbe/txgbe_irq.c    |   7 +
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  82 ++--
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |   8 +-
 17 files changed, 810 insertions(+), 235 deletions(-)
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_err.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_err.h

-- 
2.48.1


