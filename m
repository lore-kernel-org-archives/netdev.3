Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09239260565
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 02:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786933305; cv=none; b=ITuj9TedPalN27kYDTxq7is9BhXiBLpK/M1v+lqpmfapR2bYOvnAcXbMLIWik+o4DlmkDou0boG+qcbmCmed+XSCPhdevgb+aAVhtQZjS/jE0vB1UQnLXsPV8VlIsecL9MOoHzPI4/Dz8EjTU6BBtnM7XmM9cT6DGPkjGnNgQU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786933305; c=relaxed/simple;
	bh=AUQOObxO/dJ+1u8ylO+oWyaKnEhPVveEy4FPo5B3ufY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R5rsakiNHeSisPNu6jBW1oqKhAgwSjQJ94kilq1y6wFEINJjN4ThyDDKM3PKo1ZS81HJOsjF/UZv6GmW0RD1eMyHDMVG0QLCanif7amnDT8akPT95mMOuUm4JWLYMShcVA5k+NvgCx8agOhSLJFxg43/e+/+X4+7phvgIAdn4r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz21t1786933040t5c5ccc92
X-QQ-Originating-IP: SHQUqhcdXiSWRmXqcVyMeQpwC9+HKilrBNyD4DxpaZQ=
Received: from w-MS-7E16.trustnetic.com ( [36.24.185.99])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 17 Aug 2026 10:17:13 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2302367485050180584
EX-QQ-RecipientCnt: 10
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net] net: libwx: fix concurrent bitmap overwrite in PTP setup
Date: Mon, 17 Aug 2026 10:17:08 +0800
Message-ID: <F97867A3AA2696FD+20260817021708.37975-1-jiawenwu@trustnetic.com>
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
X-QQ-XMAILINFO: NjuDfT6zrIZcjgku/0F2FzD3Rn+gPe7NYzpQY+POr7rxm6qY1dVZWTI+
	APLGp8fNDpQ+swLAHIXbK1vpFclO0xt8UB/xpF7Vyc7VyPkeS+en9OTBZtfwDyJmVziuP3q
	lsWz3b0/hyUY+G4+cPKBk3pgLrim0+Wvuji6eZ2IX0AQCXwizrkv9Qg4cmiy3JK77Gbci22
	yEn/g3JmuWGzASk7SAj5QXvDD2LSsINp51TknyjwzaQpnyyoBqrXndgWKg7GxIsfWiFojho
	z00JzejyynnxGyvGNngkb60IH6rBStL6RBBZcU7Scz4Np0ZfWTY6OzvOfE5mzq0ToBVLhlw
	4oe/Vcp41cKKC0jwCCcMEGMGCg6hKEGRn/Cz831lWYTPEi5mApcBs2uMYPvdHi4iFGDRCaX
	CfZz5bV5QuSDeg6SA26vQHzbCd5tBgRA/3qowfKVepShI0DMjNojrz3GRlq92vij3aiuZ8V
	xdRvrLS8VzpGYoLgpfzhJWgqwCmNS1b0hiF6n+MaI8vfcImU37SD6wppa1yS0GDCBSSzbZp
	g6DLMSjbOc8pw6ajD6JPPTCkVJeo7iZOqU8R4rHDIPWwArMbLFQoYbv9u+bQGjgHbTTU54p
	tmiO4v0SiP4gfnvaKDCe1ZqnWwbycn7q8H+wtreCnIMduU4FFCitq4TwLjXpt5V23GOvs+9
	npUYj2eVYkQosRKYuvISwCn/BBYq21e++q3g8DC3wStrQBJtOrqVopPIxM+qMs+zcaEXUpG
	RaEavAM1Qw3fUkWpLw7HnfiEmUXNVw5KT2A/hGRx+YXtPRTNAr0gAjpRMO8ApPI3gfViATR
	DcXFVh9gCIDtCwwEe7DAwTOVF9Mi3APquGzIkBEzpfj6OKNBi7RRhgI/SDdtKTB5cjXIhmp
	d/6ycmQnvhs+5MObLlziALmYIPUG4CXaZDAcOBgU5PEhxGbVaSjN1r8nVBOraX1la16Xnwu
	fwapURSdSgcMAKnNmdjmwlmJL3sybW8VCY40HMr85b0PiRq7cj5e+jaUIUbTEBJanXnr/bM
	vR1w+FCltsR97PMOAxEbmkK5sIrx98lqRQ3v8F4Ar9yjWyu0+ethK0/w5NihnWq1PLjsZQM
	Q==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

In wx_ptp_set_timestamp_mode(), the driver copies the global `wx->flags`
bitmap to a local variable, modifies the PTP-related bits, and then writes
the entire bitmap back using memcpy().

This Read-Copy-Update pattern is unsafe and introduces a critical race
condition. Other asynchronous contexts (such as Tx timeout routines or
GPIO IRQ handlers) update individual bits in `wx->flags` concurrently
using atomic bitops like set_bit() or clear_bit(). The memcpy() write-back
can silently overwrite and drop these concurrent changes, potentially
causing the driver to miss critical module reset or PCIe recovery requests.

Fix this by removing the local bitmap copy. Instead, evaluate the intended
PTP flag states locally and apply them directly to `wx->flags` using
atomic set_bit() and clear_bit() operations only after the hardware is
successfully configured.

Fixes: 06e75161b9d4 ("net: wangxun: Add support for PTP clock")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_ptp.c | 22 ++++++++++-----------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ptp.c b/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
index 44f3e6505246..7d4bd7b258b7 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
@@ -555,13 +555,12 @@ static int wx_ptp_set_timestamp_mode(struct wx *wx,
 {
 	u32 tsync_tx_ctl = WX_TSC_1588_CTL_ENABLED;
 	u32 tsync_rx_ctl = WX_PSR_1588_CTL_ENABLED;
-	DECLARE_BITMAP(flags, WX_PF_FLAGS_NBITS);
 	u32 tsync_rx_mtrl = PTP_EV_PORT << 16;
+	bool rx_in_register = false;
+	bool rx_enabled = false;
 	bool is_l2 = false;
 	u32 regval;
 
-	memcpy(flags, wx->flags, sizeof(wx->flags));
-
 	switch (config->tx_type) {
 	case HWTSTAMP_TX_OFF:
 		tsync_tx_ctl = 0;
@@ -576,20 +575,18 @@ static int wx_ptp_set_timestamp_mode(struct wx *wx,
 	case HWTSTAMP_FILTER_NONE:
 		tsync_rx_ctl = 0;
 		tsync_rx_mtrl = 0;
-		clear_bit(WX_FLAG_RX_HWTSTAMP_ENABLED, flags);
-		clear_bit(WX_FLAG_RX_HWTSTAMP_IN_REGISTER, flags);
 		break;
 	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
 		tsync_rx_ctl |= WX_PSR_1588_CTL_TYPE_L4_V1;
 		tsync_rx_mtrl |= WX_PSR_1588_MSG_V1_SYNC;
-		set_bit(WX_FLAG_RX_HWTSTAMP_ENABLED, flags);
-		set_bit(WX_FLAG_RX_HWTSTAMP_IN_REGISTER, flags);
+		rx_enabled = true;
+		rx_in_register = true;
 		break;
 	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
 		tsync_rx_ctl |= WX_PSR_1588_CTL_TYPE_L4_V1;
 		tsync_rx_mtrl |= WX_PSR_1588_MSG_V1_DELAY_REQ;
-		set_bit(WX_FLAG_RX_HWTSTAMP_ENABLED, flags);
-		set_bit(WX_FLAG_RX_HWTSTAMP_IN_REGISTER, flags);
+		rx_enabled = true;
+		rx_in_register = true;
 		break;
 	case HWTSTAMP_FILTER_PTP_V2_EVENT:
 	case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
@@ -602,9 +599,9 @@ static int wx_ptp_set_timestamp_mode(struct wx *wx,
 	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
 		tsync_rx_ctl |= WX_PSR_1588_CTL_TYPE_EVENT_V2;
 		is_l2 = true;
+		rx_enabled = true;
+		rx_in_register = true;
 		config->rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
-		set_bit(WX_FLAG_RX_HWTSTAMP_ENABLED, flags);
-		set_bit(WX_FLAG_RX_HWTSTAMP_IN_REGISTER, flags);
 		break;
 	default:
 		/* register PSR_1588_MSG must be set in order to do V1 packets,
@@ -643,7 +640,8 @@ static int wx_ptp_set_timestamp_mode(struct wx *wx,
 	WX_WRITE_FLUSH(wx);
 
 	/* configure adapter flags only when HW is actually configured */
-	memcpy(wx->flags, flags, sizeof(wx->flags));
+	assign_bit(WX_FLAG_RX_HWTSTAMP_ENABLED, wx->flags, rx_enabled);
+	assign_bit(WX_FLAG_RX_HWTSTAMP_IN_REGISTER, wx->flags, rx_in_register);
 
 	/* clear TX/RX timestamp state, just to be sure */
 	wx_ptp_clear_tx_timestamp(wx);
-- 
2.51.0

