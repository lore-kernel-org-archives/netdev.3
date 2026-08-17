Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA053B42F0
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 07:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786950037; cv=none; b=VgS3ee581Hjxps5KBldqIvKtXkHG1Y47wGCFwdyiAX9neO80A0j79S2OGcDtOyghNcL12aJv31PUlZ4DptH7sCCRVV9/HqwfsvFmmAfVvS7c7fKAPimFpVxMTQszYnleMI6bR6An3vUbYND4RQmVD8s/SaDCsC6iT5AKsH8GNOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786950037; c=relaxed/simple;
	bh=rIuaj59cyCLoiE94hFa4RphrFWpr5KCIRztMQzAgadQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n1bfD96Oiog7hgyRqdgCcizKfHTudqmWrpyf6rWauruGSMGg0FUJ6+RKsS9jRR8d4I7aBrLxBRqrHm4F74PIpIPmwjgFxex4ZiNWZaerfk+cckyERGl/u4YCsKyToWvg5X8/dDDboWEsReYvh+y/5wGH4hNu1fdQ7HJcIf95HCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpsz9t1786949953t9fda6ecb
X-QQ-Originating-IP: GcdfqqHouoPOjwmUfEp6nfj2fpi9RSHdF1v/n0su/9k=
Received: from w-MS-7E16.trustnetic.com ( [36.24.185.99])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 17 Aug 2026 14:59:05 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10523402446872668790
EX-QQ-RecipientCnt: 12
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
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next] net: wangxun: refactor NCSI and WOL capability checks
Date: Mon, 17 Aug 2026 14:59:02 +0800
Message-ID: <DA17DB365C525F7A+20260817065903.7428-1-jiawenwu@trustnetic.com>
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
X-QQ-XMAILINFO: NIWx4IxYNqK7+H0pRqMhSVT2RTJDaBUPYhcpFUf7tRfQ3mEEPgGxbCaw
	J4iyGwNJbj5K6vgZK3d7kZcAKpQmTjbvNG+QVSBSWFRZSlVvj6IKtkbXDhj69vqSo8MkxAE
	dk4q/wa4UXXXKCyqw5XBQk5aoMMy4iKGyKhaabbugCReSaZtcLAJaIh3YJ6neNkyO0O67vF
	Uw/3XVleApWsuglfWJN1fUXOSDO0j9xFDkJYzQ5Kof8JCKzXK+/xGBuRUTsrRyapCy545lD
	E7cTJS7vEByY797lHdAIGijQpUs6rHByPkRigbrZBpsuSlBPqbatSHLScWVnXqsZFYObOdS
	I42Wy3us6tlYyx4iUGpn5gx00+DnmXbcOJUcj9jq52uGcAL9QWaeALKhDFoBPo7c5WcamyS
	hYmKfGjABZNqqGKctJpdQG+YJhMYDnXgAuGTDw+MhaCSRCXV6z7xRRTmmSuc7e7daI1cYXW
	45T5VmFuFy9rPMnSvAVY9cqeFGeKvNdyh4fLtiDGkIvSfzp//mdfKqPimapWCY3SJ5m0aCB
	S3nRF1/COtre8So1jvWM01yXLlQ+ffau/UOr6BOZ7W8d6ShS7mjeD6KL33LEC6OihUT+hwi
	jWwFBn7rrbgPlrDArvbgTjNz2US/v/W3k66zyOUTIETCwqOcn23tSU76tLhqskfyDYB6DBc
	Hb4oE3r7Qw0vR0TYhk5iWkvB1c4t/LydpJvAxuQwRUWPopfuutaqeoQPZB46l74DVnbliAu
	lSyZbLti2GLF+ZuuuAjJ6xWmuxHtq71hkuEOr2Ha9AtnOB+r1R4X9OAAdiL9UvIsjBeCelq
	Rg5WegUX2BXCZ1R+PPZddxZDs9IwSNW1Yqi7q5QBg/p0gmUnL0HRgG3pymP81VxjYQkFlmR
	SixIS762TB0DPN74LE/fnHvG6LR1FvZjf/b3xSLXyoT5aXK2LDH0mq6WAvtOPqPP50eX5M+
	llTRcN3iMEE8Dvw3jwqqUzxnGGcHCdWTmBWY63xigYEr7xLk0ft5w/vrLC1WBcxWGsNe2gS
	By0Ng5kzxL5BHloFfM1eNLZGy0gD1cpTA7JOSwm39I5wbmXJJ8sij9NCotvnPi9IJGWXYxM
	uweFKWjjlsG
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
index 122c4952d203..f0046dcb5496 100644
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

