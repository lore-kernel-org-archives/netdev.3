Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9CB3DD525
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 08:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789894305; cv=none; b=De5NzAxSnhsiBE8Hwg/BJ/xRpEJWdyNYxEvsYbmzr+obRAhaFEsSgLdMUa9K0imwH7Jgion6H4gbgLU+grxmbyhDWWZhugGjWZumfG/cihNfTP+hCbniPRaECEA3t4DCpMN4JucBEZjPNmJxjM1wygaFOHY3dUSYRmZLJ3mvc+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789894305; c=relaxed/simple;
	bh=tcW5pgVlUTWCHvDwcculjUHU/JIT0Awa2AuDrbHmYIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R4Y8p08ABVUGxJWkPhm8ctvlAUZ4hakpB8FznJSC2b3G7Q74wTesU5URso6cGV6AHYAgRW/jzoFgVG3TSzcXB3HgD96kkNEr2qhcTAyiyJFYzPoX63QRLWHJNiI+8hPoDxBQwCZgwf4g1IIXohXH0Jyz4INniXBZ7gCPN7pqQFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz8t1789894293td7f883d7
X-QQ-Originating-IP: un0A6k5ah7UHtdB/8xpJMT8Msxx544C4YXMGIbPoN/o=
Received: from w-MS-7E16.trustnetic.com ( [125.118.25.28])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 20 Sep 2026 16:51:31 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1290523408085773433
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
Subject: [PATCH net 2/3] net: txgbe: keep MAC enabled for NCSI and WoL for SP devices
Date: Sun, 20 Sep 2026 16:51:13 +0800
Message-ID: <F55611137A66BAC3+20260920085114.1062503-2-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260920085114.1062503-1-jiawenwu@trustnetic.com>
References: <20260920085114.1062503-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OU1KiBGGGpgtkleiWFKS8wAupnr8gxz+JVkhB/0MIQUmE3rRUxUAvGlL
	UyxzheZzfd3gYzStkUvr9HW2jC7r1hg29hWY8qSBPK+zlInLgyvE+IFPnGEBSyWAso2/0Eb
	YlUeuVB+hDX8Vp+N7doRull3N6elx64sfYx/A7rt5zBaE9WvjMQmj/B7BgwJ/ayCZat4aZn
	EH1g/98w4u5BzxO9kk2nlaqN81ycdsJ+1HFxUUPNBJz3qgEDl5P3TTLY+wj5+DmwT6wZnPz
	F79iKFqzF1JGDM7GnoYKFuzhMqzLl1GLJBrmjk2oLZpYm5V6as6UgahFvwCDB55IttHjlZw
	FolEEOjoHE0e+deioUZjzDpM0HmSYG3cpFRVneFTo8ttTD4WZmdidEY5jkgj0FfrK33/q00
	5rfObws42eInpFIarVJ83pG0QTswVv97wmc7QnOajpSmCAm4BH9AzK+i0DNCWMRsYQsoQsZ
	70PW8OOQTTW3vLj568D8B/cdqy+V2SnoAL7MxdVwM4HO/qY4yBIhGVWdO+evCLEBCFW3u7o
	1q/0X+WDuX7rT9jA64j1Hb90C1m4+kKtMOi6FNQOpoTJSpSfEP2rvvWLk+AbXGzVqXaFZYH
	WzwKl87pVd83ow8J23sWGg6aJmMy2G7W3GOVwfJx9YY1YQ0FehnwhE4LfNkrAUUq88vd0Yy
	sH+uDjF1MCJ0LCwwswvOobBBzVJQA8EvviZvssdkXqxD7DwQK/jzcGDSAVQGugXVasFgpMo
	4a1AINeh9e+qhnTaKWM7Zo0wSzmhwY3bwY9wqG5fSQJ8BIg9VnXBIDuHxf8Jf/AgZTZDeHm
	OdoGxcqF3kvz6RASTEWunLu/TtC4BNJHSrkQ6laUMGDU1DvavpPi66xpNQ1HtDdy92yFj/F
	ORm9yQdaAAMVtJH6OlltyTVj3JFRuOU+uyaCaymPoCmRH8yA6vW+t/7nqzSpVfFn7zx27R8
	PsVT3O+Ir9UbEw2hKOQp0FmISbP6HHlsta/l8k5zcvD8pXkw7zvjPgp4QMAsy3lHekGE+wW
	Lq1hkIWd41RAVbGxlKPwFkVYvK2jPEXJfd8oEcqDObDqb0h053hvyXLOBU2TF8zJjIqCmRY
	w==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

The .mac_link_down() in phylink callback disable MAC TX unconditionally.
This is not suitable for devices using NCSI or WoL, where the MAC needs
to remain enbaled after the link goes down to support the corresponding
functionality.

Skip disabling MAC TX when the subsystem device ID indicates an NCSI or
WoL device. Keep the existing link-down handling for other devices.

Fixes: 08f08f9390e4 ("net: txgbe: Support phylink MAC layer")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
index dc9f24314658..3fc01e937d6b 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
@@ -182,7 +182,9 @@ static void txgbe_mac_link_down(struct phylink_config *config,
 {
 	struct wx *wx = phylink_to_wx(config);
 
-	wr32m(wx, WX_MAC_TX_CFG, WX_MAC_TX_CFG_TE, 0);
+	if (!(((wx->subsystem_device_id & WX_NCSI_MASK) == WX_NCSI_SUP) ||
+	      ((wx->subsystem_device_id & WX_WOL_MASK) == WX_WOL_SUP)))
+		wr32m(wx, WX_MAC_TX_CFG, WX_MAC_TX_CFG_TE, 0);
 
 	wx->speed = SPEED_UNKNOWN;
 	if (test_bit(WX_STATE_PTP_RUNNING, wx->state))
-- 
2.51.0

