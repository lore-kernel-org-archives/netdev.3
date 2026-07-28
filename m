Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B662F40DB3F
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 09:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785231493; cv=none; b=I6rGItjN9swYmW7wejbwPDVSxc3khYHSN98TTY+DcKTNXOGpO2jVXLAp/l52stQQIq8MX460HoF85eTTSuq+E3Mf4L7RMC4La2loJuQFngKXorrSU+2Q8DqwNuzFheuljm7Sk9+tUKDVwV8F7U5Qs0gcUUONFdrAYnx7hLdsUfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785231493; c=relaxed/simple;
	bh=wWeHzKKlcyqHsBQDmpQI55HbPi/5VKeuz23bZIyjDlI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PFtLUwEpHGV+mzKGV1OxlFxXwzNWxGCJWEbSBscx2i9ygnTcm/ESxwEU34yqVhFNWCp4fJIBJTtM2u5izUF09EMoWP+aBKjIzH4I5fLdnRXEGQcCdMPqyBMdGaO6hSxB58ualoF+3/a7IkZyU75cow1pGinezpCsp16vyuKm7SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpgz12t1785231367t52962926
X-QQ-Originating-IP: FTI4qMpk1j4jC3P3o+jULX32NIGJYUsXg2bltQyVaTw=
Received: from w-MS-7E16.trustnetic.com ( [115.200.224.93])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 28 Jul 2026 17:35:59 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 274960674478608699
EX-QQ-RecipientCnt: 14
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Rongguang Wei <weirongguang@kylinos.cn>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Joe Damato <joe@dama.to>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net] net: ngbe: fix NULL pointer dereference in non-MSI-X interrupt enabling
Date: Tue, 28 Jul 2026 17:35:54 +0800
Message-ID: <21947C51A754F86C+20260728093554.9324-1-jiawenwu@trustnetic.com>
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
X-QQ-XMAILINFO: OU1KiBGGGpgt8F3XFCpSBj/G6wYNbN327+JXFEJqhEyOP0omfXwN/JG8
	ZxQHDzdExvkoaxCTZ3okG1nKafHtdhR2KrA3clMjX0niZM6Az6cpXSE6GLWxRBOckFoMD1a
	l0mjyxCbR1++9ueiHXKYc29YMhSRBm3OF+hIwYkIF7yiS+/NnNwCiHmTraDiiPDxdLIj3N5
	ZylGOombYMUdsttAhy3v4rmuW2A8OY5drG0I8vOJ235noBWEOriMe9zB8GE2r53XyyjQnqB
	WYfqTsCC0urey6hjE2SiagBEVHmi7jrM2q/yIuVJhGp0i5FT3MZolGfB+jeSFmmQSu48sjS
	HZcfGs86BoT3AOghBgGLBRO7K0pAaRDERngCzkPsric4hzKwiQZwqMFhGH4isd6ytUPHb2F
	vsg5cArNvR9rSxcXj+BGPDsz17Ov5ypPK6RJpMmmGiJS+LJ/pmjlmqmxVmuXas3QDr3ctN8
	PiLNHbHM7nH5dSsMe8zwqOOvGvzMmbNgBNt1knC6TsDW9L6j2O54WLKLFqeFNUDWqZChhft
	Gjsr/vPzuH4+14qRot40CTvSXXwfqN2NP+aeVxPHI/VvAD4EYdQJ2CW5FKLwdCgYpwERfND
	sxk/TmkXJQU1AstO0njfwMPELWw0RJ8+c0BhU8PjYt3qoF0Au+5Ak4c48Q4NccekVo0G/4Q
	S0UWUmRxU5frufwSHV2jLXzIoZh66H0RTR6ZRCU8Q3eO7mf1CA7YUVZCAFSzggijUDfPCi7
	hLJZ0I1nS1knVts66eHZHnBvlaMAnFZvRdGSMJ1vNSwz0Yf95GBJhc6GtP8zEdzd7Ds0IPo
	6Bv67ImuQX5QV8jtKU+YV51Ca6QeZa4vynygYmu9vz9bIO7v2iiiuZr+EWm7FCrlHE7ucHY
	HgG90/A5LtAfIYfpoPuNkTTR2Hx9ASU88waMTsNUoIKp14Bn6CoIYbTzHfoMcnjpWyA+Dd9
	PtrKQc2PMYCmy9EXuijprnOUzdtkI05CdYQ1wx7ziEg6NE6aJERkAso5tmGDHMjk31IMfZl
	w0m4hmzhRSHgPAOHviuA2baQhJB3erPr9azYEM8Lclu/AmOkxXfv1kGRDyhdk=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

In non-MSI-X mode (such as legacy INTx or single MSI), wx->msix_entry is
not allocated or initialized. Calling NGBE_INTR_MISC(wx) dereferences
wx->msix_entry->entry, leading to a NULL pointer dereference crash.

This issue was introduced by fixing the IRQ vector when the number of
VFs is 7. Since macro NGBE_INTR_MISC is used in only one place and
relies on MSI-X allocation, remove it.

Fix the issue by explicitly checking WX_FLAG_IRQ_VECTOR_SHARED to
determine the correct vector index and using BIT() to convert it into
the interrupt mask required by wx_intr_enable().

Fixes: 4174c0c331a2 ("net: ngbe: specify IRQ vector when the number of VFs is 7")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c | 4 +++-
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h | 1 -
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index a16221995909..5d89fc84e8bc 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -180,8 +180,10 @@ static void ngbe_irq_enable(struct wx *wx, bool queues)
 	/* mask interrupt */
 	if (queues)
 		wx_intr_enable(wx, NGBE_INTR_ALL);
+	else if (test_bit(WX_FLAG_IRQ_VECTOR_SHARED, wx->flags))
+		wx_intr_enable(wx, BIT(0));
 	else
-		wx_intr_enable(wx, NGBE_INTR_MISC(wx));
+		wx_intr_enable(wx, BIT(wx->num_q_vectors));
 }
 
 /**
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
index 7077a0da4c98..a990a622f7b7 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
@@ -82,7 +82,6 @@
 #define NGBE_PX_MISC_IC_TIMESYNC		BIT(11) /* time sync */
 
 #define NGBE_INTR_ALL				0x1FF
-#define NGBE_INTR_MISC(A)			BIT((A)->msix_entry->entry)
 
 #define NGBE_PHY_CONFIG(reg_offset)		(0x14000 + ((reg_offset) * 4))
 #define NGBE_CFG_LAN_SPEED			0x14440
-- 
2.51.0

