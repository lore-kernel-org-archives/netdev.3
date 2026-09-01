Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA2D3AFD15
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 07:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788246182; cv=none; b=palHRiWOeXoUKSbp2IIcvr+AZa6CjM6IVbb5OB4Y/Av+d6rFQ2chpqFAKIfc4qP6rkcbmLB1TT6SCkBlmjzn/ioNogjsyycNWR2gf352t+1AbBx4KF2j/ytsflShbNzTkGpSG+aSl3I6mmehZRJDzCr8IUnazdd8I6HVd9zNjL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788246182; c=relaxed/simple;
	bh=tbu5fbPvKqtzbmt9pGF42Elp/whkGqcAC/I4AO5pjvA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=enNpB8s+n9Ydv8gjee0UqJ8OcpSKjuMIZV12ZkbZENA3KUVdN0bt+h7HKcvWMDjB8/Ezs7MthUnuUZF5mGPtP8utVsQudw5LEDp9OAiumvBWcqEWYuTay6hPnzNt0H2jfZ6PbE4iyZdJsRkb9DBUDWuI7OXs6IoqITsN74FsJ68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpsz6t1788246168t991c5e5a
X-QQ-Originating-IP: 39bi5HeOdh0dC84g27O5xHJU4DN0cXrL0Mc1xhG/OVc=
Received: from w-MS-7E16.trustnetic.com ( [36.24.189.66])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 01 Sep 2026 15:02:40 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4101687497243644948
EX-QQ-RecipientCnt: 15
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Simon Horman <horms@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Rongguang Wei <weirongguang@kylinos.cn>,
	Chenguang Zhao <zhaochenguang@kylinos.cn>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [RESEND PATCH net-next] net: wangxun: refactor NCSI and WOL capability checks
Date: Tue,  1 Sep 2026 15:02:38 +0800
Message-ID: <95D34449BA183C54+20260901070238.78509-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: M12MFmiBLnnlZsnUhyDKoGf97yxc42cHRGdP587NiChSPAasj1gui62A
	t8Y7GIlqjNqk2XHe9rc2EXTyxREMv0dryvM7RgIqMwfZW0FOX6UyvnrElcD8ozNgd29aTwf
	wMmJ0ASi+ULpOL2uJANcZbALuP8k2gmXjssf8fKYQnix0Ws0cfUEp23uieixkm0AB6mvodV
	J1eLnM4qdwLW+KNIVBOSKlFcZKk+qvpj1dtgxeTucPfBx59b+R3Sr6LoVd+0yozCELr86OB
	Dd3FanFK+1EoJ+iIe9zGP0g21Bmh0hyBKO5xwlif1ITG8KQn775Lecn48emV1H41EHDVsi7
	6tgCj6rQCGQzTt9BxWb/sw68lx8HZ6GJr22MDRdXFUf9FeXczHInfziQaid1k8gcTMuXlSN
	XYhipRnm+aBAMDODoTXBc2RLWXfaS03zsIDrmZL/LQSKq0H77UkPowdPCZGSqnr/BP9mCye
	pr3bpLuYMdSRwzyI8f/7l2JZxpkSEKKam6aUzS3CF22foR2i9dyOuXOtkAc7mB51t1Pvxeo
	97ct9Ke+NBVMSJWiBbaTgOJM41VRNAOGkYFRPFtMr5H2FMXaav3Dp/LlDoLim73SQfVObi0
	rK4/5XS0ps2W6BoGGc1JSqJlKIRtUWWzvFkBRzgvk6i9zuhY0IgJ8BydRJQNyeeB2b1vj8P
	VAMC5GuGcg9joo62V9wMYBBIjB3E/EbsmPmHDS6nXTOFeo0GJ57cTh49wd3APz+/2JOE0OW
	Ub8ZieG0NzhkvgkLOjptkz2cKbagp1tKYmzG5cUhZWdVCOYyEkGff/zEaWGnfmjSnk1OU0F
	+NGwuHGk6ThStdnT5MNap8u7BdyeM57vC1ff7zG1iuqk/OXjZpuI3FiJj3FVeQLiZE07hYY
	cfug6Fu7/VND5UWyqdPTXXxVRBVyef8Wo50Y9Z2vEwcAkGNkjHrJT5/59rzv3bSaEKMjCXK
	7S2dfY2eoxcAt0YyquW5unkVi47XMLfwvmkHgcjvdgjFsYGULl7ZEcMaO5Fvd/xIzyJj1DX
	GrVcKzhRtDw8oY/gRqGduxgEROQi3xRS48u8uJOVtpv/toNWqAaysrdeBQIehjHv4nQz5/Q
	QckMs2IgFuqFrsNzOj+zbk=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

There is a clean refactoring that replaces inline bitwise checks with
precomputed boolean fields. The hardware capability of NCSI and WOL is
obtained from the sub-system ID and do not change.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_hw.c      | 3 +--
 drivers/net/ethernet/wangxun/txgbe/txgbe_main.c | 8 ++++++--
 2 files changed, 7 insertions(+), 4 deletions(-)

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
index eb91c4f28ecd..8c508aa3ce62 100644
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
@@ -336,6 +335,8 @@ static void txgbe_down_suspend(struct wx *wx)
  **/
 static void txgbe_init_type_code(struct wx *wx)
 {
+	u16 ncsi_mask = wx->subsystem_device_id & WX_NCSI_MASK;
+	u16 wol_mask = wx->subsystem_device_id & WX_WOL_MASK;
 	u8 device_type = wx->subsystem_device_id & 0xF0;
 
 	switch (wx->device_id) {
@@ -381,6 +382,9 @@ static void txgbe_init_type_code(struct wx *wx)
 		wx->media_type = wx_media_unknown;
 		break;
 	}
+
+	wx->wol_hw_supported = ((wol_mask) == WX_WOL_SUP);
+	wx->ncsi_enabled = ((ncsi_mask) == WX_NCSI_SUP);
 }
 
 /**
-- 
2.51.0

