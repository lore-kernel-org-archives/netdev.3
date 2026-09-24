Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2FF3CF1EF
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 02:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790215355; cv=none; b=Ly6s12+AvEnSBvVFAtdq98tXOroCSR8C3FaaoyZPOC0RAk635Z3MH9c1+Op0/VX0JCJ47qx6X3iLCOrrWwNhV6OcOiqFvU1Oc1NoHoP3MZ/3eTcgD1bLOTQH3zER6sTSQXEM0wUsxkFVC9tbCAxwTMAi59vQeWvpsSmGkdIizJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790215355; c=relaxed/simple;
	bh=lJP8eCzZAOULErcwLtGjXEJnwtEi4Z3BNkclXA3CWk4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zb6On+v8UTwxfKYQPTwO97tRvgGEOsXgmg2h7kpVEepbk0YVknDl5GMBDMu2J9qFidljj0JyzKdV9krekXPkON663rG99+vakLFDkqUBXr6h+2IKFwP6NYNoRFc70YLgFj+alA54WfByhiVTeAYXAGJzN2zbpjGJXjAZ6Glmmjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz1t1790215322tb6e1a9be
X-QQ-Originating-IP: 0OwfCqHBtW2pP5Nt/d25g0EA7fM/0GrK3q1Hg+1sT4E=
Received: from lap-jiawenwu.trustnetic.com ( [115.205.193.132])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 24 Sep 2026 10:02:00 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14987324107634331314
EX-QQ-RecipientCnt: 14
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kees Cook <kees@kernel.org>,
	Chenguang Zhao <zhaochenguang@kylinos.cn>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Simon Horman <horms@kernel.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net v2 2/3] net: txgbe: keep MAC enabled for SP devices that support NCSI
Date: Thu, 24 Sep 2026 10:01:48 +0800
Message-Id: <20260924020149.30800-3-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260924020149.30800-1-jiawenwu@trustnetic.com>
References: <20260924020149.30800-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: Mtm3fLS6F+W/fkbJUXDWQJA6QC9dxZiBqdOlTvwtn2I6xSwxym5QclOD
	yYzRb4MHXTvC/COxk7keThk9Ex0HjSa1LIRZhcwNTYSQDAfgHBSKQqa4kyx2+vH1XzzcakP
	tl9mj6nESkN+X7HmZ2uNXAoQuhD+sExS0MloF1eQTR9TdJ2pu/RU4azukoC0N14MjNq7+2Y
	T0UhXkcFaoHvP/oDZowpvB/ci4btRUlSUGdf3HTy2bRKybMAakuwgkjOG3nooYiL92uBuXh
	s0NEb4JtByDLv7kVMcRoeOLKkvKURhVorR9YuGF4+FU1BEYc1j6EqSsNfu+nt96KitbIrBW
	W3Nr/LdXG3xtygSla17EKlJw9In3Phr0/lWu8kl8C78uPvsjTTdT0zbIq0bE4pYMmxb8jzn
	WcuNtkf0xj7t0T+iUOUKQBidsMV92nwdz7n+kzt5tk4cid7dHULmq+kiQdI6SIb715SP+4p
	wnG11hqUOmH2K2czdldNOwrcJSeQ/WvRFpMJqoFYpV6WR4/UAvCzX8gI67D/BVGN3K5ajUN
	RDI/DyrsHi0N30O93ipPFdOukroH8NLM+9CmQeBBI/QRyDYm5OA35hDy/+1ZdNyNmeiyofn
	LAKgQ/E+JVk27jBcBP13BRu8pFMRF/qlqwPGw1iTNgooWrrNnu4fVJvRz5/TrBOX/7ZThda
	eosrV6GCoQ4damH9R0IxmEu8P2RA7aLTL63asEZT8i7QK8af7YeRUHpS7YIfyfWAhS9Yyv5
	8/bia7bilgr7LiJtcCFNscCcCItB+zBiV8KphbW3BSAq3WlDpAdjaw+rBXsmOqv19i0bYpG
	Yijz1tH2jJ/zu3a6i/Yz7L4o3sIeRIO1CmdcIhs0DnBiJsRnKpoevdiyJyYp1mPZG5VdTWM
	PbgwHWgANMX593clI7p7u6uQ8ML/vcVA777sLOQ6razCudxzGABkELVCuYs8b4Id5En1hU6
	B61cd7iFZFvsL1hmk8KAZAIjDJT1v4kI2mQRCIJVZqvnzjYDg9aYc+giGtKBRi5pSKRI8x/
	U7yf6SFKrAkCKcyd4F/mtgkj79BiodJUZm0Z53EhxxWxuoAgjokR56VuXIni9VGrHO1D6tM
	X1zyaJyVuejlnkCmKtHLf0=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

The .mac_link_down() in phylink callback disable MAC TX unconditionally.
This is not suitable for devices using NCSI, where the MAC needs to
remain enabled after the link goes down to support the corresponding
functionality.

Skip disabling MAC TX when the subsystem device ID indicates an NCSI.
Keep the existing link-down handling for other devices.

Fixes: 08f08f9390e4 ("net: txgbe: Support phylink MAC layer")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
index dc9f243146580..d11f26dc13e92 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
@@ -182,7 +182,8 @@ static void txgbe_mac_link_down(struct phylink_config *config,
 {
 	struct wx *wx = phylink_to_wx(config);
 
-	wr32m(wx, WX_MAC_TX_CFG, WX_MAC_TX_CFG_TE, 0);
+	if (!((wx->subsystem_device_id & WX_NCSI_MASK) == WX_NCSI_SUP))
+		wr32m(wx, WX_MAC_TX_CFG, WX_MAC_TX_CFG_TE, 0);
 
 	wx->speed = SPEED_UNKNOWN;
 	if (test_bit(WX_STATE_PTP_RUNNING, wx->state))
-- 
2.51.0

