Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF273CF047
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 02:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790215330; cv=none; b=CWWAIpEmIRxfsKR15senNSe8uGA43bgxL3FlOd7LPumm4bHDuVf6eZ0bQTsIW0nv+S7oosHVNfAxy/Ce2nm/20s11HlFc4yR+7HRdS0qc4/BXjudEEp2WC+peVa1LaJS264pbEDEVcixXU2OzQEv3db54dfXu6HTwyT4LPalwAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790215330; c=relaxed/simple;
	bh=Y3qrReB+r9zumZYxHqoFv1uKGN/jZb0+usFT5jWcjqY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YXWQkjzgFT0P6DjxnAZmoIAP+ALjRBAhXJE1H5E5FooCV6hRLNc80fvI3yOJm0eN3YQdg5FoXm+ULtn5IKzx/XtXqdgj3KEb6bl/eYP2c5fhZL8eml4HcsP35qdGbRjQEZJ+I7H6KHXMAYuHUwEsXMBA6OTIfeuikPHffVF5E7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz1t1790215319t87c896d2
X-QQ-Originating-IP: 1tFPk83W0znGP5+TLkPciNXXMklf42D4ae3d0S5DQDY=
Received: from lap-jiawenwu.trustnetic.com ( [115.205.193.132])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 24 Sep 2026 10:01:57 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13653353041710245380
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
Subject: [PATCH net v2 1/3] net: libwx: keep NGBE OCP cards MAC enabled
Date: Thu, 24 Sep 2026 10:01:47 +0800
Message-Id: <20260924020149.30800-2-jiawenwu@trustnetic.com>
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
X-QQ-XMAILINFO: NRfl6k/eYe7AnOZknYNUUa0wMZlR/rutnUmYRdh6vF/80uJvaw4JTvjD
	F8bUTqBkTTTNs84ryxcQ674atgx30S1kKMCjjScwZbvVYdORTkG1RdCEGh2NfsYI5BNzcJ3
	Gy50Uv565s40Sk9MENFrkSELZQjCAHY6Iz84uHN/RBiDYF7eguEQUKbEK7Fqt+IGygRRq+4
	B9A+hXNGkPtjgTmYDNaT71Ahr0w2kCYUWaPY3sgtyGP31/idS35Y9+SDLjJQ8Zp5BEcPlTq
	Pqy2jM9ThCKGnTKOpz1G5nMdx9O2MCLiAeCi3qAgy2L31nLeqduZYx8+BmNFe8fVxR2ixLv
	IiF+vr7Pf9z3DG9o8Bsjhu8Dutjs/d81W8u4nadi+YOtMc59xAzfb4yra/uCcmORzVlvNpj
	sU9OhtlQmVQkoEow7qzjxu/mg93e/0lJn8NgMULnLj6tLsTTajjpmIXYBkAD+Kzp93EE5W0
	4laugOa00AfG/C9HNH43e7O2PqFYfZJ+idPjE/g6BF2V3FWRLtT7f7bQ3vapvEr2rsPyqeT
	Lbbyw8xSABZv4h7bEK5J0hrmcFEMpBoIaEuZu6wxkW89yrQ9u6ICwaIvpPJvpom0iFy/Dfl
	XTgVerr8XcMMw90SYbvapUGqH26ggVwYtWA/sKJ5ONP7wbY64H6m9hxAKN+W7WG44g0MRhC
	jnTpvki7Qu8K+LruIJucRV5/lH20wCcbkhd8jaN21y6SzWEmQQOqm62PrR7HVf7oJH/Yy6Y
	TNZ07gp3Ue/+TRlH5ebVd1CPV8qDUYqhSwTj46K+hYSs0Jo+qH142PHPi1/e4jYjzMQHc/R
	9BNOt3yj5H4nyM2BuYaZLwgvFvLk/k/tE0fEcAVL+g3iYnUIXoBYs/F9jyGk/SgN0A5N9rr
	W/MmArOZQBXHZ6X/weli7xJX22Ey3ZYSbEDDedoNSKwfmKz09/mc+4w/fYO1gMswmpnGnA9
	dDGPJ71G1GHW5wubT5jhP53+7hvIuT3qK9Fjxis8eGIJdoQLJqsKK3dWvvVVG9TLhVi/6+N
	ISrsVeNTBPFcq178EZiLNCR/4bsSemV9BA7uw//lWfgigreCrO2tEbs55HKOw=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
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
index 122c4952d203f..3a48380ace439 100644
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

