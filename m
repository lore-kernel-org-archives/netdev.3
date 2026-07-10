Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A56C24677F
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 02:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783648816; cv=none; b=UQtsBoZ1l3ta51qcucy/KTfDqapDM4VgdEiNKCUJu2pmeeR7noJWVJA4tNBHEnZxzGFiJaQqj8TtrdiivpDe50eOioRcod7bWAW8D1fZ1X69OF8ARX2tti+ZODg1NrHQSUnqyL6VmbF0pgdu4vLckNwLOPc1GBqUQDNw8tAr5wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783648816; c=relaxed/simple;
	bh=fUSTc5xaHdwxnk4fbuxXBwQvXdAxCvyQwCRGaxDrFVQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JqRgwRJKwpRTbTE9u9QqpMXKn/2XSW+kbTCFhq8ZX0CP9regyxnSVg7sAg+VnO3/QaIE9s/2C6Z/2yPtFisMdvtiP32OZ4gbp0/BR398tEvhrmbT42RjBAKUZKQY7EJNXnZrhVkweYEHzYIVzUSCnuHEH4+RWhpCimbgD6s2bl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: esmtpgz14t1783648778t787e6e32
X-QQ-Originating-IP: 1mkDYHdtrvUYj1qebYjWV2JSIRpZHsGZ3a3oFzpjCoc=
Received: from localhost.localdomain ( [60.188.196.189])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 10 Jul 2026 09:59:37 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 2500668553094967198
EX-QQ-RecipientCnt: 7
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com,
	horms@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next v7 2/2] net: libwx: add support for set_coalesce in wx_ethtool_ops_vf
Date: Fri, 10 Jul 2026 09:59:25 +0800
Message-Id: <20260710015925.34769-3-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20260710015925.34769-1-mengyuanlou@net-swift.com>
References: <20260710015925.34769-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: MC9rDRZtSAjcWEsQXDxisAlmeU9ZseuAFD2gT1Rc/IL6h6lFwzxE/PEh
	lV4cDi3l04O22y11mxabXoh4fnWqWA2ul1hTi9I6+Ja5W9NQODz3N43ctBog53c6YRfOnyX
	3NPnd5kFsbg+6XmsUP6edydO1D2KMT1HNcXux5Iqlejs8ff90mu469NGEUNTJy2OdtMwIur
	04qDSbMKvBpGelBfGxX3u96geuB3piWhaMPF82arbF1WPpnac8tyAq3iYM9zyd4wUQIjxdW
	M2uqfKl/QpodRi+1ekRVt/me+9pLVA3KqLFWt+2Mt+T2ADkJU8STk9juAM2mSkovqQdU54W
	NQiAgovMbRQfTvFF09OWCgsrCkLe3zkDSO8UUS3fYrkn5RfHBGzkUp2j5ra+LCx0X7TO6xb
	9KGs26YKP8loGTE0zp54smJUD05hwadUcutPTLdSFRNSn97DdsNrJ2qR63VXpuG6pnMMb+8
	JIWwcokJYUAU+aZjlfgFz5dqNc4vJnI+M/1ZjxUp7phqFjELgWCPjs04ffqJ8n+t39aUtvW
	/1hn0ihrF2rrU/R6mlouq0BxbX7lBLmpwFW7wucc4V9RVr6rrAIcHzVjrNueT/z18oTaXWd
	e+eoZZqB/pJ8dbZP0V8yH6ksHltaSXCxGgW/lmEL7N2mCiPJ6o5lSYuLvY2JRa7e+vTb7gR
	bheFdf41LqwrtyxSB184OAzjslDrPNvpcA0gbj9TiwEfruQE+bw7tcXJGT+aLSWd6FBZZRE
	UnkimGIIOLZCDAOjLHSlvi1p44qUkKZRSfhNPYMGLTzTJOCsnl1HlHTyxQlHvphXB4H4hp7
	M52xaZ0RZHqmaZ5XRVmavRqxHd8tQ0jhTzcl3kWWvjDCT2GGI8JS0ykNdGkESBPYQ5Th1Dq
	+9aP34vJHSH5Wu+eWpZkIPK5ICHfP3C4R7u71E1z56TTYfn9TAVMb0ynYXXrSoYbN9M+6Mn
	6bVfd1F78cQVGnZo63eja/gyKhitDLGRqREtxUBS5Vyph5jN7snSZALcdXHuvRiSwbepGQT
	mYyKFD2XyiQN9dlHjS3sZioBoyMUqheCQbz9ISY64EmwTJugJ1NDDA5KAWLqygK9uYSwUAC
	mB4qtvf/Sd6fzhEnlMxdETDBscp8UZppxwXSMPqWwV2L7+WmxXuGLk=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

Add support for set_coalesce in wx_ethtool_ops_vf, which
is used to set interrupt coalescing parameters.

Update wx_write_eitr_vf() to use the same interrupt
moderation encoding as PF devices, since PF and VF share
the same register layout. And remove the now-unused
WX_VXITR_MASK definition.

Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_ethtool.c |  7 ++++++-
 drivers/net/ethernet/wangxun/libwx/wx_vf.h      |  1 -
 drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c  | 13 ++++++++++++-
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
index eae038df6875..22037f015ded 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -10,6 +10,7 @@
 #include "wx_hw.h"
 #include "wx_lib.h"
 #include "wx_vf_common.h"
+#include "wx_vf_lib.h"
 
 struct wx_stats {
 	char stat_string[ETH_GSTRING_LEN];
@@ -488,7 +489,10 @@ int wx_set_coalesce(struct net_device *netdev,
 		else
 			/* rx only or mixed */
 			q_vector->itr = rx_itr_param;
-		wx_write_eitr(q_vector);
+		if (wx->pdev->is_virtfn)
+			wx_write_eitr_vf(q_vector);
+		else
+			wx_write_eitr(q_vector);
 	}
 
 	wx_update_rsc(wx);
@@ -845,6 +849,7 @@ static const struct ethtool_ops wx_ethtool_ops_vf = {
 	.set_ringparam		= wx_set_ringparam_vf,
 	.get_msglevel		= wx_get_msglevel,
 	.get_coalesce		= wx_get_coalesce,
+	.set_coalesce		= wx_set_coalesce,
 	.get_ts_info		= ethtool_op_get_ts_info,
 	.get_link_ksettings	= wx_get_link_ksettings_vf,
 };
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf.h b/drivers/net/ethernet/wangxun/libwx/wx_vf.h
index eb6ca3fe4e97..b64a4de089f2 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_vf.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_vf.h
@@ -41,7 +41,6 @@
 #define WX_VF_MAX_RX_QUEUES      4
 
 #define WX_VXITR(i)              (0x200 + (4 * (i))) /* i=[0,1] */
-#define WX_VXITR_MASK            GENMASK(8, 0)
 #define WX_VXITR_CNT_WDIS        BIT(31)
 #define WX_VXIVAR_MISC           0x260
 #define WX_VXIVAR(i)             (0x240 + (4 * (i))) /* i=[0,3] */
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c
index aa8be036956c..7325b475ee10 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c
@@ -16,7 +16,18 @@ void wx_write_eitr_vf(struct wx_q_vector *q_vector)
 	int v_idx = q_vector->v_idx;
 	u32 itr_reg;
 
-	itr_reg = q_vector->itr & WX_VXITR_MASK;
+	switch (wx->mac.type) {
+	case wx_mac_sp:
+		itr_reg = q_vector->itr & WX_SP_MAX_EITR;
+		break;
+	case wx_mac_aml:
+	case wx_mac_aml40:
+		itr_reg = (q_vector->itr >> 3) & WX_AML_MAX_EITR;
+		break;
+	default:
+		itr_reg = q_vector->itr & WX_EM_MAX_EITR;
+		break;
+	}
 
 	/* set the WDIS bit to not clear the timer bits and cause an
 	 * immediate assertion of the interrupt
-- 
2.30.1

