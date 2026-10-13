Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF37043FD29
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 02:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791857241; cv=none; b=NxGI7sxATYVj1jYlzDuWfYoBe9YBIYS/W6jJublzH3qeIibnrwO7WmP5tPYaw7+XwdcIt4V2k6vWNiaaQP8PtfFXX6Yu3p0+TcAwc8TCOLQhyeUX7kYxxnS+TgSmIcvuTKRJm1g1Mv7jHg0aEmKj6RoTQcTMvwok2O3LKbmYmj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791857241; c=relaxed/simple;
	bh=ELzU1dKoV8pnmA7CXW+9KlhHGSfmM0SYXT4AflV5nYg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lShNsmqbcbRKyzyh/vEcNTS+X06UPV6YRETF63lpRa7jOClGT1bmPvJC5P91aEg8ttZhDFs3HAvO+pK6+YhENGkKZiU9xgKUuz2hZMVDzdChjVT4gDydw2h17BxZphkUsHJsTyiBy0tqo8rseakD/bGZ1c10XkUH35r7O5/UlXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz17t1791857200t80fe583a
X-QQ-Originating-IP: MvYt+vnpAkWP3dIuU1gT5LsMcisq26eVP3NFg/+GAec=
Received: from lap-jiawenwu.trustnetic.com ( [115.198.217.6])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 13 Oct 2026 10:06:38 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5912921899777786184
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
Subject: [PATCH v3 1/3] net: libwx: keep NGBE OCP cards MAC enabled
Date: Tue, 13 Oct 2026 10:06:23 +0800
Message-Id: <20261013020626.5548-2-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20261013020626.5548-1-jiawenwu@trustnetic.com>
References: <20261013020626.5548-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: M33qaJCbPnlFbq8959XiWqNZVVq9KfmVyGfhT/zQ4z1W3Oewe+7hBBG5
	PUsbPCUTAj5bN4Zxq4pS4jJYZX2VqEoSnFQhjeJxFaVOcS3eh6QG6/ucHDMshsh2Iew3qzv
	L/qg6HDf84clVPWO1s0V2NEg662at+4XXaNCzYGKr0KM0AOu1xVvk1ogEDiu17nO5l8aaej
	+0ZkBIkacJtrbT8uwWlv36gJK3EmB9YhBIUfdaDidf+t5La1lSoqFD4E0QtXyz1QhXTo+p1
	RWy4gUQdqesbrLZdN192yObMfWDZeeZQtPEczKJZxXB5shUN+DV3dhLWpAOKRXm9kEiMoKr
	taeIDuBCHJfqr3YiIuHCj/0/CgC2RqPWGDksFaCwpQH0rFXlKYSCCfhEpHoMLVmVz0QIZeL
	X1v6CpXlaXGHyXWpj6xvGDzHqgW5wCHrm4Brj4vsIjvqdi36VQnt+f0QBh+/2XgnUL37bRP
	6k6wGFflGbp6eGpOPqvoOD28XTHlW/zM6lMTo1kyF0zV+CzRuVg+skDXFJsHgg6WXdkpdsK
	jaazQCMPKsZAAlB2CO+yh29vVVCoWG+6yLLGw1Fze48rryj5E2USUzMYY2xWNpnsddKE29B
	e7gEs+lGdCeBJSkQjN9j1IXriduGl27olTiR68LeOK/zGRCEFgxtgEEcZk5avezhWj+c1Lw
	XYDiU651TgTNrvHLD9PGsyagDPxpu65/tLuOCTfzRdPfiaGJw2X+2iASGwZgw7wc/2jioWp
	bn55O9qIMxoALFYNr7Er0Fm2p90IL06DqgBXmXMotwf/3e8doPGBQXq2N1c5Um1XvbXx2Qd
	56g4GOO7A6F9RBpoF5brNtDd2App7m9tEUP7v04Kv3oF1BcStMIPpn/88oVtZszmngSJQ44
	EkP7TcMznGZLqUI2mDmcqwVa5NKiJ/O/NZFayHg1Xkw9vOHKaL+P9M46d69BfaWY8KBBiFp
	gP1EllP06moWNHOm8O4VMTx1lhE0h14IqerGZqFW01JvaxbNPwqT4sphd4puR//i9DepWcU
	Lgv/t1K+/xKtTg6/ZBgpUfS4DQbSqWR36aoOCd2wElut6Cbr8zndj/CofXCG/52Tgs0P+fe
	A==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
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
index 113552586be7..76813b651fd8 100644
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

