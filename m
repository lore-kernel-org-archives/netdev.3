Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3493164C7
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 08:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789894305; cv=none; b=k0oW/TPdZkOCSxzxCYx7qHs0bnaWhc7/oJBDZD0GlSX6W4bPnpWjs18rAGHCGg6XfmY5aEmYFWGXfq9M6RWSrZXmzR5A3vRVDUQ0AnUpCnOznyvnKzj/tKn+E44K+GkaBypFrFVU9M6NdoXCH1p4njIeLFlvNCAcTSnkLK86LQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789894305; c=relaxed/simple;
	bh=dPp/TZsdZFvc2cClsr2I00oEATLquhqe8ppxwvSKuKs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=klDjJ2aTADsAPiY0FmHfcqWltd6QuiOimx9Syd2J5NDYX5QBPXXOnmbHQKhUeqo2eXcaq94dBsa4XW0sZKfDO77RftXfeQSb2QsFDacO8zixVqMl/DCGSjubTdHeV4Ivf7mCj+dKmXfFt1WC6ErDDyaOsZB3kiBpkYHg4ufmuBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz8t1789894289t7c31e086
X-QQ-Originating-IP: ovZnBVOqb+pRL4ybfYAFWO8DDI7+MEgwxAk/YLWdP6c=
Received: from w-MS-7E16.trustnetic.com ( [125.118.25.28])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 20 Sep 2026 16:51:20 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17151452918768759432
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
Subject: [PATCH net 1/3] net: libwx: keep NGBE OCP cards MAC enabled
Date: Sun, 20 Sep 2026 16:51:12 +0800
Message-ID: <7DBD5726DAA21342+20260920085114.1062503-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: Nr9+mHXfAFYqxcr3LRuFJjNlwV6+Uljq6kMKuOEwNKipSGTpHPc/5mNJ
	O2MdDLXJErgrlbXXGEn5RDeQqZmWanp32fl/ygb7K0gQfkm5qZlAW8MtiiRK/MSxbshclg1
	+qkf8n4Xq4OBQWBZ2SWRIiDv+46VJAZgO2SbpgUTL7FVmtbExFeifSJoUC7NTK3HLZVSLHj
	VB/bmlFUlQMgBBVop6Sxb8dMB22zCxx/Y31EJttHmn80rCLBP1N9PSasPF76GbqZm919JkC
	OIvUaXz/m/FAlnLZ2+LlyZn5W+2pjgXzaT7Vqmw1WFlnSy0mcnlkZXnVuFAK7gYrSJeyPET
	HMqxQ/yqcYP/ZnK/N17KfksVWCEO6yinAusElvvgJMmtkOZgmGW7PorsJhgoACv1vNaO6i2
	jwKrlN2W1vc838h1lygw0vrk6qJQ+V02kodlkGoz9BMuJq2zIRPf31To3HBSyuk4DzNBy3A
	QBJyOOqtJ9cJINESU5ThTi/xOac3VlMYzgV0X6pkdO8EUfDs5aNZ/zB2LdGR3GAc19nl/K8
	KGQcPpK2rO+FFwWRnAKihLG6UO9XwfN+Dabp1YZXhIE5GDcrqB80O5c6HiZzPyZVp5rh42w
	Nm7ugQepb/NbvrwWQSdKZLTMQRhtHWEkyKSqCwhDWwmDSQzG3C9UloqUn8K4Qtk4XIFIO46
	akDTa/asD3ZY+PfEwlzvvMz/IBk/r3ZKh8UWGc5PvgGc3PROthOzWOpJ+DDKTwuSz34xrxz
	i/tTe/wmpWVNtRmHhThi0FElzeztDXnCa/lTpDqIP0NrdOx0Msmm+yU88BBBcinYPJ6wVUv
	qTMAkwJVqzr9khB8zDaBVZ9qcY0XeGEyUIfXcBggZFxmOv0xipTSfH3jhs6ybF98myJyErk
	rE3R+0jrfaaQKAfbuZ8YdAracDD1RwdnwSXjWICFXhIUJD3x+CPzox/O+Qw/aFm539+ESw+
	ftZVlBCuIhBl6sqK59rwqHWcVkBZ/MoK+hU/wqb9AUfzKCF4/DGe2OawJ/kPPewbXpJacio
	1WPxXHf/UlV02kGB1Fje4XGKU+51BH+jV1XIskh8uOtcrs61DpgTPqPax9kz8=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0

OCP mezzanine cards are NCSI capable by design, so the NCSI semantics do
apply to them, and they need the MAC receiver to keep running for
out-of-band management. The inline test does not cover the OCP card
type, so on such a card that does not have the NCSI bit set the receiver
was turned off on every path reaching wx_disable_rx(), and management
traffic was dropped.

'wx->ncsi_enabled' is the correct value for NGBE to determine whether
MAC RX/TX should be kept enabled. But it is not assigned in TXGBE, so we
use an explicit subsystem device ID mask in libwx now. We will merge
TXGBE and NGBE into unified 'wx->ncsi_enabled' as soon as possible.

Fixes: 02338c484ab6 ("net: ngbe: Initialize sw info and register netdev")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_hw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index 122c4952d203..3a48380ace43 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -1314,7 +1314,8 @@ void wx_disable_rx(struct wx *wx)
 		wr32(wx, WX_RDB_PB_CTL, rxctrl);
 
 		if (!(((wx->subsystem_device_id & WX_NCSI_MASK) == WX_NCSI_SUP) ||
-		      ((wx->subsystem_device_id & WX_WOL_MASK) == WX_WOL_SUP))) {
+		      ((wx->subsystem_device_id & WX_WOL_MASK) == WX_WOL_SUP) ||
+		      (wx->mac.type == wx_mac_em && (wx->subsystem_device_id & 0xFF) == 0x40))) {
 			/* disable mac receiver */
 			wr32m(wx, WX_MAC_RX_CFG,
 			      WX_MAC_RX_CFG_RE, 0);
-- 
2.51.0

