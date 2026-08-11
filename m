Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9296F392822
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 06:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786431067; cv=none; b=DdxUCyYPqdje5WIqGRvbiSz0ZUN2BmcShcTZV75Ws7q+OKtTYpVvJIgED6cU1PqRzQ5UtT0jeUvcDPqSpAAyouRlNp0Ct/gmYk+MExkPXrit31VdE1FyhI5PEmoQbkTY/WPQaT7LVfPDb5Unjh6Y8btlwHmrsFHUX1xtMkjUlKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786431067; c=relaxed/simple;
	bh=S+asxjjbFhGxaqlhTG8Lr6MLXT5bJMRSBLujzEX9zRY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qKyAhbK/omKxdydpnKeCNgKXundp9dpZOoJE//t9g+Bte5G4MVvUhTzIVFGi1xxpqcKNfb+JcuVXJ0XctsB4Kb0FrgLh0Xkgn9fiO3x39PPa3GeDUiP1BGKJtBwzJgU+Lar23VgXZM5hPosQR49JH7vPIETEBbCpcPwRpCfFH2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpsz3t1786431051t76a35e91
X-QQ-Originating-IP: vXlrfEheBpmzadNXlahbaIGnAyBgBk0hDVXKqeHGLew=
Received: from w-MS-7E16.trustnetic.com ( [115.204.248.201])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 11 Aug 2026 14:50:45 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15906742138508472362
EX-QQ-RecipientCnt: 14
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kees Cook <kees@kernel.org>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Breno Leitao <leitao@debian.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next] net: libwx: rename wx_pf_flags to wx_flags
Date: Tue, 11 Aug 2026 14:50:38 +0800
Message-ID: <D43B3418D188B057+20260811065038.58345-1-jiawenwu@trustnetic.com>
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
X-QQ-XMAILINFO: MLQK/Qc97rZTOMq/jX+0V9cN+iExnKXPD+Z3Tx+BgIAyFxYD7HyimeMK
	MB19+oQfyCteGKQKd17CDxAnrlmVkIqZIDGL7yNRJW55Hsu67AWiEFRSGBEBGISKjfdLSe/
	AP/SQJvAGF0TflT1S8I1FpA0Mm9MCH8CIzYdWw3Q85Fc1S5joH762I+sa5UFHYiDL4dlXO4
	lIC08sq2rAW1Th5D+WMedbHVtNvVcJKXlmMwjy2t0esyWcJb9b+ZO+VTEj9Rwf5Zcrxhv9p
	vP6scsR3hCKgOO/W7M6xwlUNv2acBolIE0xRCMwt2NmnG1n2tlcSJkug3ovq8kkB35jHIAM
	JoeR2lhqoUlP8SzJ7I48etlpSS3epg4E7WxiOirRvzAFCRdIx1Kb78+lWGxuOC50Wa9c3yd
	Iw5MvIMWoHrnwcVv7TDl5IbMV+8Mp/J7BC4goDAYclaSyRYrMzF9vujZcIjn2eannpTm6Sq
	M8iwAhkqvq5V4unkRaEFNORMnp2tXFWjCX+KIzr2lcVRVQk5+xI5990USDep+eIX8JucAvG
	PTGaMCZKW2AJcK5z2HDY9fTQFxGgjOUT6EP8flBCqmH03bvpvw3VVONWBTEFVyT4uCDq+27
	zpDDB3diu1ISK78ue/R2qclHrYU/hfMBXlCVOUDYdORfc/er0WKHQL/BiVak3111a0vQJvz
	zbOaYS/Zj4srLaIMWxtX/Uvw+wpozSL/uXUMsVZLACjSYj0GJPmpkEXncJacE5QuMvkdKmn
	qiRvlH5Yev75o9wpEzLDsr8oxa0lUwg/y6gtt/m2j7NfGAvqJj9w836JfvIpzErbyE+KRZ2
	njGYnYOdfMrd/KwPorCiKbXeWwiHulHIAfuENVBgdy2QfeDODb802XHoCxZS6vzyMA5cp1o
	KFMGA4iIOzvXfqdRHgPnt8b+0Ab19qtzNc+PFLnSPcA6LZ32geKeYtprtm2oxfjn4ANJidO
	hKylZMi7Azd82BKtNEItMps+zCLEDSzcxMu7dS0x3C11VFvNwZD4W5a+UB+dtqOY4rhUtVg
	gBY8ZpA1ZW/gTJnJJOtHbiyy30e8rTM9LZkHcfIIEAiQmeU618SUF/xmI1/wgmM8UO0OwyK
	A==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0

The flags defined in `enum wx_pf_flags` and its terminator
`WX_PF_FLAGS_NBITS` were originally named with a "PF" (Physical Function)
prefix. However, these flags are not exclusive to PFs and are also
utilized by Virtual Functions (VFs).

Rename the enumeration to `enum wx_flags` and the bit count to
`WX_FLAGS_NBITS` to accurately reflect their shared usage across both PF
and VF drivers, and to prevent potential confusion.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_hw.c   | 2 +-
 drivers/net/ethernet/wangxun/libwx/wx_ptp.c  | 2 +-
 drivers/net/ethernet/wangxun/libwx/wx_type.h | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index 122c4952d203..59cdd7d71e44 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -2520,7 +2520,7 @@ int wx_sw_init(struct wx *wx)
 	spin_lock_init(&wx->hw_stats_lock);
 	mutex_init(&wx->reset_lock);
 	bitmap_zero(wx->state, WX_STATE_NBITS);
-	bitmap_zero(wx->flags, WX_PF_FLAGS_NBITS);
+	bitmap_zero(wx->flags, WX_FLAGS_NBITS);
 	set_bit(WX_STATE_DOWN, wx->state);
 	wx->misc_irq_domain = false;
 
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ptp.c b/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
index 3eea647c4742..e35e854652ec 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
@@ -558,7 +558,7 @@ static int wx_ptp_set_timestamp_mode(struct wx *wx,
 {
 	u32 tsync_tx_ctl = WX_TSC_1588_CTL_ENABLED;
 	u32 tsync_rx_ctl = WX_PSR_1588_CTL_ENABLED;
-	DECLARE_BITMAP(flags, WX_PF_FLAGS_NBITS);
+	DECLARE_BITMAP(flags, WX_FLAGS_NBITS);
 	u32 tsync_rx_mtrl = PTP_EV_PORT << 16;
 	bool is_l2 = false;
 	u32 regval;
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index 2eba5ab59925..39cec52c3d2f 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -1269,7 +1269,7 @@ struct wx_rss_flow_map {
 	u8 flag;
 };
 
-enum wx_pf_flags {
+enum wx_flags {
 	WX_FLAG_MULTI_64_FUNC,
 	WX_FLAG_SWFW_RING,
 	WX_FLAG_VMDQ_ENABLED,
@@ -1291,13 +1291,13 @@ enum wx_pf_flags {
 	WX_FLAG_RX_MERGE_ENABLED,
 	WX_FLAG_TXHEAD_WB_ENABLED,
 	WX_FLAG_NEED_PCIE_RECOVERY,
-	WX_PF_FLAGS_NBITS               /* must be last */
+	WX_FLAGS_NBITS               /* must be last */
 };
 
 struct wx {
 	unsigned long active_vlans[BITS_TO_LONGS(VLAN_N_VID)];
 	DECLARE_BITMAP(state, WX_STATE_NBITS);
-	DECLARE_BITMAP(flags, WX_PF_FLAGS_NBITS);
+	DECLARE_BITMAP(flags, WX_FLAGS_NBITS);
 
 	void *priv;
 	u8 __iomem *hw_addr;
-- 
2.51.0

