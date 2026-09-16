Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5EB19BC8
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 06:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789540494; cv=none; b=j28PBE3mb74bApjT0tOBP+ToXYJu9PmSMMNcSSrubEiImL8gq8VvgjpZPV3SpkC8I+/s0H+6FmiuSig99x71jVUibggaa3UzC7j2X5SHUgPfae/QxLH/LUPxoS3DM5fAgMo14RjL3SX26MZ8yA3pbYRV1fkWp/gvxDEqRQm07Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789540494; c=relaxed/simple;
	bh=aSA6NZRSqCtr07VE4S0pTX5CUiXj0XFDNMoK65Mm9Ug=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W3ypOVSFO7TkwKa6Xl+H76A2Xa4xCghlX7RUqep8K6pBsKp9pn0NfOMiZF+VrkfyNiY7op9VABIgOX541KwFDNfj49SL+n+tFFqGDyFghotKsSpBJKRoLokricS0BtZdbXgTZxA5flXsHDcajt8diPhHVpXqR1QB3e7M3XYcHJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz20t1789540404tffbcb8cc
X-QQ-Originating-IP: ygmYash9cphqOed+MSMZmeHhk+Pujrhbwupm36lzRN8=
Received: from w-MS-7E16.trustnetic.com ( [122.233.172.177])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 16 Sep 2026 14:33:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9852207754865000035
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
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Rongguang Wei <weirongguang@kylinos.cn>,
	Chenguang Zhao <zhaochenguang@kylinos.cn>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v3] net: wangxun: use cached NCSI and WOL capability flags
Date: Wed, 16 Sep 2026 14:33:12 +0800
Message-ID: <E5215E3514E295BA+20260916063312.203457-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OASHEhBpbRXHirO9kvqiFX2DUZvZXx136rPAg0ixHSXhBOWyLwlcWO00
	/wnrZQqWlIjeKXLeiP8mlJBawTnI5jNL8grt1OF2W9YsSx4nTKVcE1zAI64plUjkk1qMabV
	RAMrlOp3J2sJHvC6eA9a2kZWms3aFKsRcBM/RNnOCKbuEDFCM0XfjMykjylahu4hBYIJNYW
	PY0GR6roF4Sdk+l9gE37roTBPU0yjsxTlYSdp7Hrt+9tbemLH4aYHjKzi9H1OlhtrjszsYe
	lblH4cNOyOsRdcri+D7BJH//p/1REBCvtFfsB8Dtyye/DxF7th5jbRCgPx8Z+cHYVsfr6f6
	XM9A3Jd+lubtQx1jE9u82wMZzEfE/Mxj7WgKjX3GOXIBeWGvLirnS7RGdgEt5zMYmx0omGv
	21mrcRbnwzISL+3cRBtZRsA3vuUeuqRG1L6Cuz92euTyGWlzd7GKACjkOHixNVyHokHjv1F
	apkIMBCvJzXcjh5r+w8RKxzhGgRSQXZFikbRR12SxqLP16ok5LDSfBHBdKIla1RoFU0UYhQ
	S/52PC0DD1I1rRuGpDzyGyMdW1TfvxbUeufpZDMaPsU1Jj2MMxuSQJ9Tj9WInZazyMqS93/
	kyZevg9zDxutHC7vPv9xk5PrcWz4OwCippnOksvnTFMNKw/0sQrp774tdog9PJpFe/xBWhe
	4JXnMIind3JItZt3TJgKiNqcwLbW0jhmSqnU74f5Xc0uOauWDvzYCUuWvB72uEjCDkJl5Yr
	o3DY6BDd7p5As0XpXgjZYCjf4Dfhg0IRunwUTb90F9p63v4qX3HexltzNqNfRaAJPh5Yi0G
	KGxlPFIbhvswt2DgCcIEG9JnT4NYl/zMLrL/G+XQEjzxUBRXTrvG7yejhLwv7u9+q8+JZWi
	IduLdTBLuWyGJzQ+Zn/Mk2T5NcPeKkAAkwCJw0H97QHcOMEu1D0YlDdc4HgrTLgWMEByzVq
	oAlQHgbqCkfmRxq8VYom523Wp6r0Nkt7DPc9zHOqJdDC0P95fZ3b/ohZkU6YyJO38whBoh3
	zbC285TUoN6CdFTEMLVYrSFoqNlwgADPSJotqJ0a6lCZVPXEk/nXpXRhfsNhcReBonUfD8S
	4PnxJhp0MQt2G7IRCZqzm/V+qBome6ICA==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

wx_disable_rx() and txgbe_disable_device() open-code the same subsystem
device ID tests to decide whether the MAC receiver and transmitter have
to stay enabled for out-of-band management:

	(subsystem_device_id & WX_NCSI_MASK) == WX_NCSI_SUP ||
	(subsystem_device_id & WX_WOL_MASK) == WX_WOL_SUP

ngbe_init_type_code() already decodes the subsystem device ID into
wx->ncsi_enabled and wx->wol_hw_supported. Do the same in
txgbe_init_type_code() and let both call sites test the cached flags, so
that each driver decides the capability once while probing instead of
having shared code re-derive it from raw IDs.

This is not equivalent for ngbe, and that is intentional.
wx->ncsi_enabled has never been read since it was added by commit
02338c484ab6 ("net: ngbe: Initialize sw info and register netdev"), and
it is wider than the inline test:

	wx->ncsi_enabled = (ncsi_mask == WX_NCSI_SUP ||
			   type_mask == NGBE_SUBID_OCP_CARD) ? 1 : 0;

OCP mezzanine cards are NCSI capable by design, so the NCSI semantics do
apply to them, and they need the MAC receiver to keep running for
out-of-band management. The inline test does not cover the OCP card
type, so on such a card that does not have the NCSI bit set the receiver
was turned off on every path reaching wx_disable_rx(), i.e.
ngbe_disable_device() on ifdown, wx_stop_adapter() from ngbe_reset_hw()
and wx_configure_rx(), and management traffic was dropped. Reading
ncsi_enabled keeps the receiver enabled on these cards.

No Fixes: tag is added on purpose. The broken behaviour goes back to the
initial ngbe support in v6.2, and wx_disable_rx() has since been moved
into libwx and reworked several times, so this does not cherry-pick into
stable kernels in any useful form.

For txgbe both flags are newly initialized, but wol_hw_supported is only
consumed by txgbe_disable_device() there - txgbe does not implement the
WoL ethtool ops - so txgbe behaviour is unchanged.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
v3:
- Rewritting commit message.

v2: https://lore.kernel.org/all/F76F75E3FFF42A39+20260908025416.42250-1-jiawenwu@trustnetic.com
- Remove single-use locals.
- Describe the behavior change on ngbe OCP cards.

v1: https://lore.kernel.org/all/95D34449BA183C54+20260901070238.78509-1-jiawenwu@trustnetic.com
---
 drivers/net/ethernet/wangxun/libwx/wx_hw.c      | 3 +--
 drivers/net/ethernet/wangxun/txgbe/txgbe_main.c | 6 ++++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index 111aadf79208..2490c4dd548f 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -1313,8 +1313,7 @@ void wx_disable_rx(struct wx *wx)
 		rxctrl &= ~WX_RDB_PB_CTL_RXEN;
 		wr32(wx, WX_RDB_PB_CTL, rxctrl);
 
-		if (!(((wx->subsystem_device_id & WX_NCSI_MASK) == WX_NCSI_SUP) ||
-		      ((wx->subsystem_device_id & WX_WOL_MASK) == WX_WOL_SUP))) {
+		if (!(wx->ncsi_enabled || wx->wol_hw_supported)) {
 			/* disable mac receiver */
 			wr32m(wx, WX_MAC_RX_CFG,
 			      WX_MAC_RX_CFG_RE, 0);
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index eb91c4f28ecd..0ecbd1c0e553 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -267,8 +267,7 @@ static void txgbe_disable_device(struct wx *wx)
 		wx_set_all_vfs(wx);
 	}
 
-	if (!(((wx->subsystem_device_id & WX_NCSI_MASK) == WX_NCSI_SUP) ||
-	      ((wx->subsystem_device_id & WX_WOL_MASK) == WX_WOL_SUP))) {
+	if (!(wx->ncsi_enabled || wx->wol_hw_supported)) {
 		/* disable mac transmiter */
 		wr32m(wx, WX_MAC_TX_CFG, WX_MAC_TX_CFG_TE, 0);
 	}
@@ -381,6 +380,9 @@ static void txgbe_init_type_code(struct wx *wx)
 		wx->media_type = wx_media_unknown;
 		break;
 	}
+
+	wx->wol_hw_supported = ((wx->subsystem_device_id & WX_WOL_MASK) == WX_WOL_SUP);
+	wx->ncsi_enabled = ((wx->subsystem_device_id & WX_NCSI_MASK) == WX_NCSI_SUP);
 }
 
 /**
-- 
2.51.0

