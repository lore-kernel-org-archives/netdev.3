Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A0E360EC9
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 06:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788245948; cv=none; b=tuuQAk0m7hB1o0htCrQbVw5E4/XpykaSyt8fZva8qVpRGkhevN+YhvJ7LxKSZCkHSwSOogOV3o5TJaiarBCu96Yxk5yRwj60Z62ve3HLp+gCCJVOIRObHoxHGF7pSPlZSV4gcyEiSdqmhMqNp89AHR34fHn0SXZ3xJNX1JjTB4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788245948; c=relaxed/simple;
	bh=OmNONeQEhJ2VotaJhOxm+SK/y+YV+47pCn9SFs924Xg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FNVC8xai4T3qJnJ8ZbKeeTCiSEDkEZR13cr1EEsWVZKmbvlnATcI53Isw8DHij6bc+MyrHmE2G7T7JbWa+fnRa+TfUETQEpqwvu5Y1kNTMCB3kSbHXjjrYnNWJRBNQOVXSEJKPy1UIEiGpqoyWJ5/tDvMx6sPW4txEKtCojMLZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz17t1788245827t53a6bb27
X-QQ-Originating-IP: UryGDJvsKak0uUTv+O3XRZu3v5CO75J4aFBAXrptFF0=
Received: from w-MS-7E16.trustnetic.com ( [36.24.189.66])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 01 Sep 2026 14:57:00 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6337307342351750624
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
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v2] net: libwx: rename wx_pf_flags to wx_flags
Date: Tue,  1 Sep 2026 14:56:59 +0800
Message-ID: <9479B0506F544556+20260901065659.41273-1-jiawenwu@trustnetic.com>
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
X-QQ-XMAILINFO: M+0YV038q5N1YAtUoH8pnGG2lifh1W3LXmKOYUj/vcc7GKPEq5PsAZIB
	tqcmzH/4gd3y5HkSz9VTfbaByQTJNuCCx0YnaOj9bc5YzSTutl/PH9RK1JemvPIDdA4tho9
	MF0UyK1k/WeLoFmN/2aUZ3H06ymnMLMin9By49QTpQl87Riz5gCssgldEFab4knawRAf4xG
	vlrNSDuj7XZ0dfSoOJT4Z/CVOPGaikk8Gd91DqFz6U8mw5HQu7CeawEfxM1sfx7NfMGqozZ
	QQRKeozYNHDe7ueBA3V1LSUWgLk96m62/TKMp9IeD8OcIwP8EjJJOS/VEUWS9wvJgqjFipY
	ySddoi9DOgpZYAhlhteCn6p4cGP9VoQnJDXpYCiD8xBcgftIQH6BNOuN++UdiCxagcxOHD6
	zASyTV5+ChCRylUaRHGyuJXUo8QoNCXJhs4uOGDXmkwd+s8KUKEp8zc1QjVH3tiv17VpJjr
	WXISVLTX7fouXLIkP4yoA35IaqzoTlnZr3BrbCYtnJs+ooef+tuVb3nOJbnodC2j2H2p7yv
	gByTO7rkTD21TXFMwgbUdS/CTbY/SLjAmu/dCu4HabNprafRcCAYZ0NFL8pvc8I4L46sR5M
	3yoj4yuM+YiWM48A8cw4SteRhhY9hi72MIePzvu3xZfb144hAe9n8dAbvVUBeksoYbRhAMK
	axFKkZoj6tCTky0crVSrLqFOHNEd+TSUx8v3qOT6/wuDpbQIUeJBUmN3IoeiOnrNdAUjwXU
	+SgwMGYoiOt2Rk6Y3hjZyX4hdpOw5ijD+W4OdTZc01xP1qyiEquStOdgcRQRXTFbAjdktNO
	UBZjb3YOx9WbfRFuVWGuMm0yJ+uIpD98Indt/riK9RErCRlYjnuio/+upO2vuvk9shGuNXN
	vEX0ZnQCKDVZIDNCLizh06KI8TDAtMdHqffE7u3NkNMPyNdaB0jjX8wIXN231dfRORALONI
	A5Pgcsd0r5QkYZg7fMJUAcQm0h209iKM6x4ceMJAkUmvxJ6IWdUfQ0e06uY3sG4T2ly/MPI
	eqAYTsaCPb9PcYzgqjaHtukEVXCezQe4H9c7d/MA8YYmpbQ0EURIv2j8Yopbhn6bouQakkC
	A==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

The flags defined in `enum wx_pf_flags` and its terminator
`WX_PF_FLAGS_NBITS` were originally named with a "PF" (Physical Function)
prefix. However, these flags are not exclusive to PFs and are also
utilized by Virtual Functions (VFs).

Rename the enumeration to `enum wx_flags` and the bit count to
`WX_FLAGS_NBITS` to accurately reflect their shared usage across both PF
and VF drivers, and to prevent potential confusion.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
Reviewed-by: Breno Leitao <leitao@debian.org>
---
Changes in v2:
- Rebase on new fixes.
---
 drivers/net/ethernet/wangxun/libwx/wx_hw.c   | 2 +-
 drivers/net/ethernet/wangxun/libwx/wx_type.h | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

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
 
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index 9454e90258d8..a05a8c1f4049 100644
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

