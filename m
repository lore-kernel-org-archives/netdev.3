Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEE13FB077
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 07:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787039326; cv=none; b=tzsu97ZzOMOEsyakpqJTHe2SSBFxn4vG3qFDJui5GgD6OpJ+qyvxHQ+a1bfXYwO0bXhveTMtGTJ7OoyQk/FyBt3JCgSI3tRoi5mfMiFM3GeImo/gj/Y9g1OfFUIydIjrqOVPxKycDA+iUZUtoQIMCD4eKdgd91fhpS9GbqVJf6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787039326; c=relaxed/simple;
	bh=bUl0/+RymVH2Mb/qN8rsTG6i2sG+1XRJf2WwB9us6mM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ltWnxlrqvXYyho/kNvA0IPgM8Cyh3u4D8eH7Gw/dBkXWKLAWlb+2mZCf3NH1AnRlCGXnPWeeU6ksUDqwidQwlYLxNJY4OkO54D6ZwZSIg9zZk2MgtyP2qZRbU5BtY1sq56+1UIS1GeNHIr8XeNu1va33A6mfki5tndhJuZsLCP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpgz11t1787039249t36a17d71
X-QQ-Originating-IP: 401ahbk/OFCcd+Lr2GNKaMbM7Lcqrwt89kdRbhI2s+8=
Received: from w-MS-7E16.trustnetic.com ( [36.24.185.99])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 18 Aug 2026 15:47:23 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11655653517647161835
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
Subject: [PATCH net v2] net: libwx: fix concurrent bitmap overwrite in PTP setup
Date: Tue, 18 Aug 2026 15:47:21 +0800
Message-ID: <6C7EC12D69217315+20260818074721.45536-1-jiawenwu@trustnetic.com>
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
X-QQ-XMAILINFO: Ni59fRWiz7acQsipwc7BuhusHAkCx5rmvEfrO1sY3sUpglU2LmPCUGq7
	CcHlM/l6CqxEqZpaYqNkfh2h2f2IcsS6dPci+HzKlxOdpE1WeAr9aN54NkrrdeRZU90B1c2
	AGEo5QM0BD33h3ywnaZKReXTp5HRgXTG/pY76gHnGq0pjCHz57z+JLnxtcK2DDOE8CdyUtQ
	9HrpouV5J904k9LRXV68ZdECuljxFNVqP1xZ6NOz3n+7bgrk9gTbj1G1A8dQ9phCF3ehbyE
	eqPhqa/lQHYjVEqgidaq84RCwxOZ0YcoYGdKB93hAaYo51WgEWQXhgVjYTa7g9d9r1IjPi1
	q7WvJVmJM0cLwJOx06E+MXFuxzXDL9UFd/3yfJABHT1wewHFCq+ZRTLn+bQ3kEGG8Pd2+Ky
	sv5z6oSRpYoIbWEoUfoR7t5YZC6DH7Wqa1HGt8SI7tp1ckVD7u/4QOsr6wS/7B78HRwwtqs
	SFWwGxwEOfuQpwwz0QsWpqvPpWxUmjkUrXQRTZ2YpZ7TsdCBvEG2oCvCsHi0ewFaybxPmIt
	i557EEugVIMAHx2IaoKJHjO5X5EWBAvU42pI5m2uk0xVZpUdaGLRAFkHVBSl1JzhkXzPVHr
	eaTyl2hFmLouNcEq6UJoV1sIKIcsSj6YuoaoMrSIMIhqIUn4cW4lp0tWXD1f5ysqgag3Vve
	AALEi7HBI0RGIT/I8ovsr9HRlqq3Ztlw9TH8Bj3gjJAYW3slKebtaO5IeR2HvTtJnDfX4EU
	NgVX8Obe/1viv1okjNjO+kKtRkbmzW90HeCgZ3gC28AGSJsLOtcrbmzZEQd1rIsDYD/ZQpR
	xE6t94IGTgW+UEc3Y49hFZqJebLc8wJB9NE9Is6vdOipy6jpIecF4K/oWFVNlCThchd3fip
	rZka6DzKcQF/WxqRXzpzvKwRLCBDjP7nWzpN9Nh9gnH/m/JH2A2N74B8gOYP6QczKbjgTVU
	IDAOCTxs87FSzPLwLGmitO8O/Bl2kkeiQn5exJXo4Dp3M0mSSG87H+9K6LxFClsGGc/tMO4
	m38/KFEX1pAYow8j/BXNYRHf/Y1YaOfFSefujxgk/egDeonLRmwTCxtzcpQQcQcIHMhBe+m
	faun11DUp4LpQ7OQqie51AHEdR4llOH9A==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
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
Changes in v2:
- Combine two variables that are always equal into one.
- Link to v1: https://lore.kernel.org/all/F97867A3AA2696FD+20260817021708.37975-1-jiawenwu@trustnetic.com
---
 drivers/net/ethernet/wangxun/libwx/wx_ptp.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ptp.c b/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
index 44f3e6505246..1165518d5522 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
@@ -555,13 +555,11 @@ static int wx_ptp_set_timestamp_mode(struct wx *wx,
 {
 	u32 tsync_tx_ctl = WX_TSC_1588_CTL_ENABLED;
 	u32 tsync_rx_ctl = WX_PSR_1588_CTL_ENABLED;
-	DECLARE_BITMAP(flags, WX_PF_FLAGS_NBITS);
 	u32 tsync_rx_mtrl = PTP_EV_PORT << 16;
+	bool rx_tstamp = false;
 	bool is_l2 = false;
 	u32 regval;
 
-	memcpy(flags, wx->flags, sizeof(wx->flags));
-
 	switch (config->tx_type) {
 	case HWTSTAMP_TX_OFF:
 		tsync_tx_ctl = 0;
@@ -576,20 +574,16 @@ static int wx_ptp_set_timestamp_mode(struct wx *wx,
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
+		rx_tstamp = true;
 		break;
 	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
 		tsync_rx_ctl |= WX_PSR_1588_CTL_TYPE_L4_V1;
 		tsync_rx_mtrl |= WX_PSR_1588_MSG_V1_DELAY_REQ;
-		set_bit(WX_FLAG_RX_HWTSTAMP_ENABLED, flags);
-		set_bit(WX_FLAG_RX_HWTSTAMP_IN_REGISTER, flags);
+		rx_tstamp = true;
 		break;
 	case HWTSTAMP_FILTER_PTP_V2_EVENT:
 	case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
@@ -602,9 +596,8 @@ static int wx_ptp_set_timestamp_mode(struct wx *wx,
 	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
 		tsync_rx_ctl |= WX_PSR_1588_CTL_TYPE_EVENT_V2;
 		is_l2 = true;
+		rx_tstamp = true;
 		config->rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
-		set_bit(WX_FLAG_RX_HWTSTAMP_ENABLED, flags);
-		set_bit(WX_FLAG_RX_HWTSTAMP_IN_REGISTER, flags);
 		break;
 	default:
 		/* register PSR_1588_MSG must be set in order to do V1 packets,
@@ -643,7 +636,8 @@ static int wx_ptp_set_timestamp_mode(struct wx *wx,
 	WX_WRITE_FLUSH(wx);
 
 	/* configure adapter flags only when HW is actually configured */
-	memcpy(wx->flags, flags, sizeof(wx->flags));
+	assign_bit(WX_FLAG_RX_HWTSTAMP_ENABLED, wx->flags, rx_tstamp);
+	assign_bit(WX_FLAG_RX_HWTSTAMP_IN_REGISTER, wx->flags, rx_tstamp);
 
 	/* clear TX/RX timestamp state, just to be sure */
 	wx_ptp_clear_tx_timestamp(wx);
-- 
2.51.0

