Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EAF1E260C
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 02:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788836148; cv=none; b=YhSLK3JkiGwO2hRg51pbDAuJs+qp59pUS5WxebLbMPyUoi420sy3qFR/qd4qAM2pyPAXbjyg+CLitZeOtI6FmSGjGdyAEW6RGvFZ2IWnwudLuFQihcafIoiqYC5YrFi0sh9mcHNvujoKtIgArP9uiNUVkbPS9xs2LRzMr4rC2tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788836148; c=relaxed/simple;
	bh=1XcjWqHt9YAEeSzO585PjDa/JpAQ1N39sd3zwpy60d4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NVZnIUSEnbx1FNDaBxQZINQS1YhuhORDAEaUQf0nCHXvNxGCKrBnPX9+7xCuBtGasxv8nYrQGRZ8FUU2eu4H/v+yG+C9AGBUBHZ79tVsbvTPifXiIhmtJsqgTYbKr0qLv98/+KlJxaRrLEegSTjw9o3mr0c9eS+O6zO72/Jb0SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpgz16t1788836063t430e3a37
X-QQ-Originating-IP: umM8ssWBfHx6NAW4u0sPgUXpClOsj60y4vuPlFo//2k=
Received: from w-MS-7E16.trustnetic.com ( [36.24.66.61])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 08 Sep 2026 10:54:18 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7113935908382398969
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
	Chenguang Zhao <zhaochenguang@kylinos.cn>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Rongguang Wei <weirongguang@kylinos.cn>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v2] net: wangxun: refactor NCSI and WOL capability checks
Date: Tue,  8 Sep 2026 10:54:16 +0800
Message-ID: <F76F75E3FFF42A39+20260908025416.42250-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: Mnff/9wu0oJYY/ZKNSijlgh1kJ2knYw8ldKgbUcIHaygRLZ+mTeMUheJ
	fswvNyOZWGAaPWf/ur6VkGnns9F1t0srgsM7oiGSXnQtPI3u6ooVGtJmqjk+6mD5cFEDEB/
	SLNbqW8xrmFO0ckpAkwG6+v47nLtkdl7mi6+WULuCxopBiRP+oawb91cMUfp6qKgkjpKAHn
	g5jWm10PGaT3hcAOXKwZLRM6MASF2vScsHAbr6qEYToj9hfFcOUmJQnsN5JANqKN2Zb7kOU
	3Xfkog2zsypWx6amrw+uEjymjod2IhXizrPYjmpndS9LuzDhH/Xfwr+MY/cw5qGFXP1UWlF
	ClD0fqUvvLZLT2L9rmsSiFpHTHeDkI02+UBDU/ibF0dkfcW0mnj1qQz6q/ao2ccIAN/N+eJ
	Die3d05IA7nWKawppndCYMvveXWwDJzCdUangbUSwqnMfzd/cAiHiVWIe8/YLhKFeXKpTZt
	jSdizJYogWFS490jl7xYuMjYXWQnMkBTqw2gVhRsxX6eKOiNhbCA97cNqoOgyqV5jbxCjC4
	N05LM+DZ44EO6WOrOFbjXa6p36JHRidvu0+yiWpNg3ebIqtaZohA5uHlLyMugf/7e24jv9w
	qNWt5vRu5Ei0eoUdg6CoXlb/g/0N9uIZW4MPseoiCBbjR9yWK9OXnTMjmf1tgDxrGZ39P1r
	EK96ZEKb7L1LP8tgLDjOI7O2TmDyM0whkM0BTI/+AjytV7aaY4Jv8pSjNAcPL6eTbU1fYma
	mPKo9TmPCoM0YWim+mc2zNEJeqycDhpuzG96YK3sA4B8Y9E4sVrChLl1JLKyqYNzFqDXSNR
	ykBwkaf/g7ewv84MAQx7VyBwXH+ia9X/YS3Oyou3z5sjD52uAz4m18rDK3WUE4ps+5CIBDA
	GMz1AcdMsZeL8lJttcIYnIkqqrohr5UzkT7a0Byj3lyg6JFf8yP9ufKVJ3HK8MpRFlrSYyk
	oKdg/9tv0uG+gkjOCjtaGWeGj+HcmSNA16MV9x0Zp1XGTcy7cnmTZ2gqJFqu2YoEGHdlse5
	Piw9mO1CpFmSIWI9qzK+S5jUNWLOj7nzG/CGG8FG9uxwMOb7HnSoHKiHk2JrB/Ar5AqqECC
	2tIhse05mMF
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0

Replace the inline subsystem device ID checks in wx_disable_rx() and
txgbe_disable_device() with the cached capability fields
wx->ncsi_enabled and wx->wol_hw_supported. Initialize these fields for
txgbe as well.

This provides a single source of truth for the capability checks and
removes the duplicated bitwise expressions.

It also handles ngbe OCP mezzanine cards consistently.
ngbe_init_type_code() sets ncsi_enabled for these cards because they
require the MAC receiver to remain operational for out-of-band
management, while the inline subsystem ID check does not cover the OCP
card type.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
v2:
- Remove single-use locals.
- Describe the behavior change on ngbe OCP cards.

v1: https://lore.kernel.org/all/95D34449BA183C54+20260901070238.78509-1-jiawenwu@trustnetic.com
---
 drivers/net/ethernet/wangxun/libwx/wx_hw.c      | 3 +--
 drivers/net/ethernet/wangxun/txgbe/txgbe_main.c | 6 ++++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index 59cdd7d71e44..6fbfbb77646c 100644
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

