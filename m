Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F1345A285
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 02:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791857496; cv=none; b=iBbdpz3powuOjonCgoaGr3+p+GqimOw/0yv/0Ct6Bfct6U6gWq7a9lzaAyWR9SzfErN1upPJ7wzY0mHRNS5Xc/3TYwrrig1WePGu6r8M8voi3PawI2NByiOtenbVo/8JKLY1K/Iz6r7NmsxC0M9g/A9z04evA+LrHWsgdK5s4nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791857496; c=relaxed/simple;
	bh=gUlrsMubBm3X2xZKFhE4uSA9b5egju14yLs1mP2cqSM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UN62QPMvDbn7UOnNrgOzfMMMzNaUYrbE8bNgJXOSZuK7p2zZlAXPRM43F2+/wzUlSe2ueyEgIEi3EUocM29ckDxhnX3lhAbfJOwTXePpH9GsEaCc2PX0OOvQVM/PxEMjC4QPQpgbApfwgeyXX7t9J8RedB7UWVvPvL+/4IJk0EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz17t1791857196tcc855cac
X-QQ-Originating-IP: gTPmI6/a8B5u0lYK4G90NcmAYizitgODzuMx3pPDLqw=
Received: from lap-jiawenwu.trustnetic.com ( [115.198.217.6])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 13 Oct 2026 10:06:33 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9359113613443592598
EX-QQ-RecipientCnt: 17
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kees Cook <kees@kernel.org>,
	Chenguang Zhao <zhaochenguang@kylinos.cn>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Simon Horman <horms@kernel.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net v3 0/3] net: wangxun: keep MAC enabled for NCSI devices
Date: Tue, 13 Oct 2026 10:06:22 +0800
Message-Id: <20261013020626.5548-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OAK53qkEnM1W1vMfZxAZOO+wSCJJ06SlHi+pw1Rsb73ajbDGfuieG7El
	a1AhOIqVsof93XN4UG0ZqfySQreI0LZ2nWxOPWB8NHST5KCUhesDl4glpxOQU+PoMpB/Shp
	k2+BivmmQ7OLjefOOE6N+fw/vk8U/GHmtaqCQC/9t5qdIfPBF9StoinH0M4rQ4fF6c7wa+P
	hhxtISP28yaHnBGDmR6j3ibhlQJKBqCvQcfvoDQHOks4KvBGNGcdwxc4J2K1Ux2EGXU7Zxi
	EckBpUCBDY6MDWvyYPTOxHlpKX5fQh/1zElTtUe9uUf5VWHoxdoWEog2PFnzsc8FygbhR+A
	kw4myBpCYczIuTL5ZgF6iQ5qow3zA/aezGJzYykvgxDm4tOH737Ic7u+vMNORarQ8RSH+up
	iUVLIb2UpWjivoPb1QeqvCoHIQpyVEs2olmg7UpeddCvg4KnZ+VK6SBbDrPOuXXNpss1W63
	xhEljSUEBC3kdFtV4Hatvc6orWXI5+kr6ff/SU0yPsm4xBmQVhpxxONAlFlo/WhVKqb9ss/
	tTsMQwfse5v83ToLr5/kXseJDH8dpmTWFgZ3BBLUiHBGNHWh1UDw8RXgZ7+/YGd2BwpJKDG
	DHwmcg5cLCBOkx2XRBwyK713LXspAWH0tuqz9q/LhNVxXmemN/Rqc2EyUgSedsTHuyeBuvA
	21JOMWum2HfhdXk5q/qELkjoAjzh97MuYOT1KFqBEI3B2EyF/KyJbAItuDjDjjDyqLFDMab
	nBMXL4omplLb6m3wtsbIAiRkjcW3MD9xBqznns+WSzQJzHuMhGfrvAedYHEsZ96QOYkYo2k
	E9XoneDo6e7mHT3SUrnEV0mFvCCKkuFZ1PqrnxXdDcpX7khwTDNdCYU8GLjv5IS5LBhcBFK
	XgLUb3ROk/4eafMIzMQJzc9dWlD1gHJ5gWChC2bwxtnMD4/h2hL+T3zuF8p/qg5uWpCaa5K
	8pizo9oRbREbA1oH3Ov/PEguQKMVHL6v8MoFf86XhNVqd4w0Os/3s6z7rVcoju6tviouwkf
	GUjYB/tfvfPPBPLxEEs3E1Gl2+Psk2PDCfNw4oHqO8GQPNG/g1qpiLqVmEsEjpLDgnRgn+V
	V6oydTetIWMBXs80OI1AJ1Hn2HBd/E4CLgJMlljHG+zAW+2QGeyAQFwNj3i3Wqv7Q==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

Wangxun NICs that support NCSI share the port with a BMC, which needs
the MAC and the optical transmitter to keep working when the host
interface is down. Currently the drivers turn them off in several
places, so management traffic is lost whenever the host interface is
closed or the link goes down.

Patch 1 makes wx->ncsi_enabled the single condition for keeping the
MAC enabled. On NGBE it also covers OCP cards, which support NCSI but
do not set the NCSI bit in the subsystem ID. Before this change they
had the MAC receiver turned off in wx_disable_rx(). txgbe now sets
ncsi_enabled from the subsystem ID, so there is no functional change
for txgbe in this patch.

Patch 2 keeps MAC Tx enabled on SP devices in mac_link_down() and
re-enables it in mac_finish(). It also keeps the SFP TX_DISABLE line
deasserted while the interface is down. The SFP core asserts
TX_DISABLE whenever phylink_stop() stops the upstream. As a minimal fix,
the override is done in the txgbe GPIO controller and only applies while
the interface is down.

Patch 3 does the same for AML devices: MAC Tx and Rx stay enabled in
mac_link_down(), and txgbe_down() no longer disables the TX laser on
NCSI devices.

---
Changes Log:

v3:
- Use wx->ncsi_enabled instead of the open-coded OCP check.
- Re-enable MAC Tx in mac_finish() for NCSI devices.
- Keep the TX laser enabled while the interface is down.

v2: https://lore.kernel.org/all/20260924020149.30800-1-jiawenwu@trustnetic.com
- Remove WoL related changes.

v1: https://lore.kernel.org/all/7DBD5726DAA21342+20260920085114.1062503-1-jiawenwu@trustnetic.com
---

Jiawen Wu (3):
  net: wangxun: keep NGBE OCP cards MAC enabled
  net: txgbe: keep MAC enabled for SP devices that support NCSI
  net: txgbe: keep MAC enabled for AML devices that support NCSI

 drivers/net/ethernet/wangxun/libwx/wx_hw.c      |  2 +-
 drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c  |  6 ++++--
 drivers/net/ethernet/wangxun/txgbe/txgbe_main.c | 10 +++++++---
 drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c  | 12 +++++++++++-
 4 files changed, 23 insertions(+), 7 deletions(-)

-- 
2.51.0

