Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E75220F49
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 07:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785484265; cv=none; b=EbIHHGvuRYKTLwYEu+IkU6LlpBU1hvzr6uHY22lXUpOC0fxlNdGVeVqRb9lVctYTVf7Iwv/7JmYnQKySY/Gb7J/fPQZPkLEV6ak4Y2JrUREK5e1JrpOZ5PKYY+AJLsDlNzpn6rcesZBp6Q+6Hb997+7zPZeGfoJx8z8u4/6gBt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785484265; c=relaxed/simple;
	bh=HoFcpdZv6rm9/+4wVfz3iXXkhc48DtFloEHyWl36Icc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AyfJya8FIxXoXylvyIAYQJ/7nh3dCMVP8504mzw4y2YlVbyvZ9tZJWPgxhKnMwNG9nJLeQpMDhj9bYPyb6GHe3nejSOa814c0Lqkwmblew3Epyr1BYggYzz2rn2nFuGqiPBd68a3wja7aWDhpaf4WfrI1zfTFscBTUnHvYVlqQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: zesmtpsz1t1785484209t2292538a
X-QQ-Originating-IP: kRRTVecdLRZMGFAGlJwZVBtHizQLC9UU3MCtUPrmkyQ=
Received: from localhost.localdomain ( [122.235.139.83])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 31 Jul 2026 15:50:08 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 989802922579197272
EX-QQ-RecipientCnt: 10
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com,
	linglingzhang@net-swift.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next 2/5] net: libwx: enable wx_update_stats for VF drivers
Date: Fri, 31 Jul 2026 15:49:55 +0800
Message-Id: <20260731074958.19333-3-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20260731074958.19333-1-mengyuanlou@net-swift.com>
References: <20260731074958.19333-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: N039Sv8eB+cCz/qWufDpIHa3CUcIec3roPNsm1s4RNg6aeLu8tQoB8PH
	b261M04iNrcFO+x1hxyENOxVn+kFcdMABphhD03Ir9QuED0uermluYV6+hFBFdiJPVyQx/3
	vfAtMQOqhJrf49J9VbwvPSrjNAZlbxbjS9EVvUuW/xiB8H0OV8YPqe2QEzQ3S8sVwqNmg7a
	2moEZi6qR0Ugk2M50z+mjhD3foiAwtfkXyXmP3awV3y1yFcptjTI6HWDerMHKiNaUIpWCX0
	2wi3LpRub53QDMSRn0YhC0exjEJvUZ/OyHwTAzMOm0o16JpvBV0uggKk4sI/aMuhrl9oU4I
	qKXXNxs4QCYZ5BTcFyD90kF8pPld69Hr/Ne5vITraBj/jlDjda2/Ko4i4Amg56e7d8//hvy
	WB/2+t9Xtb0ffYO9xfTdQFXM8BvPw9fL6k2l4xh712uj52KZjgFoZ5hkTcnOjLX0Vpxh0hb
	nKEiXNI4b2zCiglmqE77idnuotA66CjPNuAZ8zwCeJviOMn7OaXoMteHmKV0aM0akyWOC4L
	m1p52i0tzU9mVIdxx9OpYeI0lYo6hKpKMJdEg1jvnDklmmOCmQ2iQa+FHRmu/IWY7+R4kgD
	iKC4UzcYFERSpbyZDjgFwAkrGhIXUPT6s3v7pItdqFkpDR5PhEdztuGhyMjrenWA2UtLU4c
	C1YRkq+dBLX48GAJOh19wiy01SDmvwCpzvCaztUGCjHQxFm4PMOG0TPtos+35FZMgoYkUW/
	xQ52OePoCqB3jmLJuSiZrfC2IkXBoHg67SXiovilgshIyPrXtZNI9dx4wpQA3R81IhPrx8i
	ioF4scty8NEhiVEXyLUXCb+iEKA6WtFFURPEJ3DETxCQ/N1qhkwKCXyh7B5CkZhfnmcHYL/
	HRB9oh4v1SQvMw/kd4iBJEnr3CWi2aVBVZYnwzas2xHFBbkb6CAgne8cP+YlNVqhSzdUAQK
	3D79ijnOZ7hduC/dzmyP1rCwvNYLs0nX9zjE3QkMBMLidEbUH+py5lYqiD5AIJ7LRGHWLP4
	6LELfK8ZFuaPyjaHF71uY3kmK+dqrxT+UZ3DSfnRNfwLa1Jkd34m9dsbbwqn08GYLj2K1UK
	4dQucPub5b3bUuQ44rG67srCX0qEYJnngVG9VFWj+XUP7AXGdViSSekPFKJgI/28E/rmgek
	pjpTPr6FVsMLv7C9Tmz7m5ff1nJkctj+9fSB
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

Make wx_update_stats() safe for VF drivers. The helper
iterates over all ring pointers, but some entries may be NULL after queue
reconfiguration, so skip missing rings.

With these changes, the VF service task can safely invoke
wx_update_stats() periodically to keep the software statistics
up-to-date.

Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_hw.c        | 8 ++++++++
 drivers/net/ethernet/wangxun/libwx/wx_vf_common.c | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index 260e14d5d541..349afbe60132 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -2886,6 +2886,8 @@ void wx_update_stats(struct wx *wx)
 	for (i = 0; i < wx->num_rx_queues; i++) {
 		struct wx_ring *rx_ring = wx->rx_ring[i];
 
+		if (!rx_ring)
+			continue;
 		non_eop_descs += rx_ring->rx_stats.non_eop_descs;
 		alloc_rx_buff_failed += rx_ring->rx_stats.alloc_rx_buff_failed;
 		hw_csum_rx_good += rx_ring->rx_stats.csum_good_cnt;
@@ -2911,12 +2913,17 @@ void wx_update_stats(struct wx *wx)
 	for (i = 0; i < wx->num_tx_queues; i++) {
 		struct wx_ring *tx_ring = wx->tx_ring[i];
 
+		if (!tx_ring)
+			continue;
 		restart_queue += tx_ring->tx_stats.restart_queue;
 		tx_busy += tx_ring->tx_stats.tx_busy;
 	}
 	wx->restart_queue = restart_queue;
 	wx->tx_busy = tx_busy;
 
+	if (wx->pdev->is_virtfn)
+		goto skip_hw_stats;
+
 	wx_update_xoff_rx_lfc(wx);
 
 	hwstats->gprc += rd32(wx, WX_RDM_PKT_CNT);
@@ -2956,6 +2963,7 @@ void wx_update_stats(struct wx *wx)
 		hwstats->qmprc += rd32_wrap(wx, WX_PX_MPRC(i),
 					    &wx->last_stats.qmprc[i]);
 
+skip_hw_stats:
 	spin_unlock(&wx->hw_stats_lock);
 }
 EXPORT_SYMBOL(wx_update_stats);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
index e8448783df3e..f116677fb9df 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
@@ -5,6 +5,7 @@
 #include <linux/pci.h>
 
 #include "wx_type.h"
+#include "wx_hw.h"
 #include "wx_mbx.h"
 #include "wx_lib.h"
 #include "wx_vf.h"
@@ -426,6 +427,7 @@ static void wxvf_service_task(struct work_struct *work)
 
 	wxvf_link_config_subtask(wx);
 	wxvf_reset_subtask(wx);
+	wx_update_stats(wx);
 	wx_service_event_complete(wx);
 }
 
-- 
2.30.1

