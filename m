Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.92.39.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792476122;
	b=GefD9Y4UuaGgn4RlR8O6fxBMT3NrlbK37b7pxKotJgyhfNd2S35gbd73wuvZV8lqzaaN
	 tblvSAhYxHM9pRras93a/4KNkCPeuizw67NW2NIPP8x6LS20mEtcRXdn4mCD3vuoVKcKr
	 TYLrUH1Ogqy+z0p99suGqLmsRC1UEtPAI9H+yDr1EbYHZSrTYX1zx0E9oAL4QQtahzJ5C
	 0/OzlFu0yBM23xjqA+hJNVZsPLI/rjIxnB/+5fPJpKhLXwKyx02bCcP2FHYbW6enDkW4B
	 /CrIA6GAuytEA/cNC87xOVfsJBUi9eIUjE00fHExs/jfjI6DP2gNODxJ+9SR1qjAJPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792476122;
	h=DMARC-Filter:X-QQ-mid:X-QQ-Originating-IP:Received:X-QQ-SSF:
	 X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=Q5dtE+8jLnC48wJwhU7E1YwYtOOVJrKh4gPQuNs4AEk=;
	b=Z8lpjSHQqDKo+5LH/bmlVRIXcQBem5gXVfIm/RDzKs/wXRQVY1vVoEt26ghiLEs/9sSL
	 KwPCbjKwsRXjVfVlPTBpb6fb+xsbJjqcXx3j8VH2fU+wxQep++eDLDzD8FCcf7fs5Vq43
	 Z6qmkZ3EihkX/SUrBfc8sCVl8W7/oz9b/5Dap/Va5u/xfJgkTb4beFxMNC+0o0Eb9+eGW
	 1BClrDiN3JtTFk2y+A/9xTpxvnKnz/Z9VxdT0/oKzUjYHfHH8L2MEZWnsFifdlHElTmzi
	 2uje0EojdEgJiAkpexODj+kKAMHECadfiBouYcpSW2l4jXXGe5/cVkQQgHRG/d3SngQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=trustnetic.com;
	spf=pass smtp.mailfrom=trustnetic.com;
	arc=none smtp.remote-ip=54.92.39.34
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3662606A31B
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 06:02:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3662606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz6t1792476079t27f6351c
X-QQ-Originating-IP: y1XEU11jDWX7RKu1vlawSpUZlLTkdqQp+36CZvvpMrI=
Received: from lap-jiawenwu.trustnetic.com ( [115.205.193.71])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 20 Oct 2026 14:01:17 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17555718947287251273
EX-QQ-RecipientCnt: 18
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
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Simon Horman <horms@kernel.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net v3 1/3] net: wangxun: keep NGBE OCP cards MAC enabled
Date: Tue, 20 Oct 2026 14:01:05 +0800
Message-Id: <20261020060107.25636-2-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20261020060107.25636-1-jiawenwu@trustnetic.com>
References: <20261020060107.25636-1-jiawenwu@trustnetic.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OGvgEoGelOUdNAeObfRoExFJHvud68FfD/sECOpsDYWzjBEU0TOtExNk
	aOWP2ayVB9/hmQhI73BfezLLJmmDV3HgUA4A7dR+z0lnCiJyPo+HePHHigPYW6E+kyN9akS
	mP3ajNbvBlzZ2u8PJEEke3gYJ62I040G9WxJgSlw0FHT5FXZ+idYQGjaiqaOfJolzlyglig
	Qb9JjK0I6pEw8AW1uJ6pYogmVVUXe8ZL55z41etz8FnEaOD/nnGAbVlSh/UBVKDkH2kA7Xb
	PKqOBENXZZL1y+4X7yscLLrWaImuaTb76B01GlxuO9LUjTadQ82Zi5l+AunMe9XlDa0I+Gf
	Cw4vQOultwkpShk+Xk3hlPTtVuLt0TrUvEcy+LQLg+zPDNAFMY1HhcI8eR05sF1JiKCaqV4
	0FSv3WK3AM5E5DJSRclQUMMNLNGMmwW55lkLdq8lCZsQW+H39s5NkJgYk8SZBEcgty5ebDu
	7yKk3fs+XZdrkNTPZmorHAmETZCO8FE+BUDW2QN9O/2WTmyM1ynFJqoLSg99xAaLzik4dLn
	0UCFb3kTId1cTtGAaF7iLX8weM1zs2biBoskSmK1WxrD86Yx+Wp0eW5A7dvznox9+fhRvo+
	EzlQiXMJJrmeIpiDL+nXcBLqNpC2H02xZVlEz5Q1GdxqLFw+ZMu5mmmtE1UY5zWuYCm+lqa
	0py4S+t0A0wbVgFJ165h0snek2d40EuCnQIPudk2qiCPFHTOGS1nuqf1R2gnzChyelTkEPz
	/RJxjxt18hKVgh8F1WLnQhORcS4w1DDq7GSEtnCdTvF8uy3RdQeoUaFeLuaY6mH5TaDa7U0
	1r0y3/gOIEELeqKFsIQ6W+lrcmkaeBhx3AevWYBJ4n0FZk8mRWcrjmQEr0vb1qi8DXJPI3F
	DHsEiWN8Uiqt7AS+jCCsLqpQiuXxBoqcW8/eHhERBUkTmHklDJMoDwm41rMu+/gXYR/Ymhv
	eg5iewJ3H8IBhsxgZD0K+mHomJGEXrvgk4NSQntdi3UyDA1D5UlnFr+aoUy8WEQl5LxzSm3
	/U5/GPmw0IDtcF0w6LxgEckl2KwW5wm1ugv7QLxURAe9yYkLeTpE+ZeeQAwgJM6TLjwmjzP
	rDs+DSXBLAC6YRAz3IMLho=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

OCP mezzanine cards are NCSI capable by design, so the NCSI semantics do
apply to them, and they need the MAC receiver to keep running for
out-of-band management. The inline test does not cover the OCP card
type, so on such a card that does not have the NCSI bit set the receiver
was turned off on every path reaching wx_disable_rx(), and management
traffic was dropped.

'wx->ncsi_enabled' is the correct value for NGBE to determine whether
MAC RX/TX should be kept enabled. Use 'wx->ncsi_enabled' instead of
open-coding the subsystem ID check, and initialize it for txgbe as well
so that both drivers share the same condition. No functional change for
TXGBE.

Fixes: 02338c484ab6 ("net: ngbe: Initialize sw info and register netdev")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_hw.c      | 2 +-
 drivers/net/ethernet/wangxun/txgbe/txgbe_main.c | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index 113552586be70..1c0c59436890f 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -1313,7 +1313,7 @@ void wx_disable_rx(struct wx *wx)
 		rxctrl &= ~WX_RDB_PB_CTL_RXEN;
 		wr32(wx, WX_RDB_PB_CTL, rxctrl);
 
-		if (!(((wx->subsystem_device_id & WX_NCSI_MASK) == WX_NCSI_SUP) ||
+		if (!(wx->ncsi_enabled ||
 		      ((wx->subsystem_device_id & WX_WOL_MASK) == WX_WOL_SUP))) {
 			/* disable mac receiver */
 			wr32m(wx, WX_MAC_RX_CFG,
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index eb91c4f28ecd4..a60a711e8e1b4 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -267,7 +267,7 @@ static void txgbe_disable_device(struct wx *wx)
 		wx_set_all_vfs(wx);
 	}
 
-	if (!(((wx->subsystem_device_id & WX_NCSI_MASK) == WX_NCSI_SUP) ||
+	if (!(wx->ncsi_enabled ||
 	      ((wx->subsystem_device_id & WX_WOL_MASK) == WX_WOL_SUP))) {
 		/* disable mac transmiter */
 		wr32m(wx, WX_MAC_TX_CFG, WX_MAC_TX_CFG_TE, 0);
@@ -381,6 +381,8 @@ static void txgbe_init_type_code(struct wx *wx)
 		wx->media_type = wx_media_unknown;
 		break;
 	}
+
+	wx->ncsi_enabled = ((wx->subsystem_device_id & WX_NCSI_MASK) == WX_NCSI_SUP);
 }
 
 /**
-- 
2.51.0

