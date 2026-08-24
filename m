Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E4234D916
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 07:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787556111; cv=none; b=RxDKjioHqRIDiWF7Je/rjnd/dx/53/XVqBkOfg4Zv5rirDIh2rnWNdatzYDOZA55TxopEH1+0y6Z4bxzdnwj2FvChB9fzEccOO2Ra9QWpKBZZ2C5PJHZ29lIWpcYWR2mYKBkuljs9A3+Fcyc8qQxdSKisVzsTpKCNZm239krf2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787556111; c=relaxed/simple;
	bh=KZLL9l7vBSgzHCJ4Pzxm9xVyGvQf3zaSoWNYHRdZzK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NHpaKKs/6+zNEVXshtOA0Qjw1z15TphaymilIpHFBsRzOwRccVfy1bZylLh2Ls/KBQyFRJ2t8ajP1BirQYGGx50kzgtiqxL8iHe7iYJfwqs1FA08JMp64fDCvKLgtd14nKwKHfaQDh+T3O1swhmlLvjRUV87f4BWEMxt7g51DKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz11t1787556090t775b4900
X-QQ-Originating-IP: odfNvXbq3q4F+a6Ae+gUqcQnu5FVHHDO1Oztdp2ddH4=
Received: from w-MS-7E16.trustnetic.com ( [122.233.170.62])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 24 Aug 2026 15:21:23 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3996461450332086053
EX-QQ-RecipientCnt: 13
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
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Fabio Baltieri <fabio.baltieri@gmail.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net] net: wangxun: use BIT_ULL() to prevent shift overflow on 32-bit archs
Date: Mon, 24 Aug 2026 15:21:19 +0800
Message-ID: <45F5565CE6AC4329+20260824072119.48399-1-jiawenwu@trustnetic.com>
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
X-QQ-XMAILINFO: NhdiEwnVOUqESVJ3VD6pDQ2Br+to/uSEuWCAqosAQUcEft4JVXQI/I9g
	kBEEG0ZSvZoT+BcZG3eF5RynzB3jNACYOfa0d/L5bcw7lclsKokOE6IEq2xcCUV20okp+Fm
	7OfvzJFzFj965Cd4FTjB13CDRW9DEzB0IMKtdy2xOXSwLrYJowJiIhAa4mGz/+4lrGf7Ckj
	ivbguXghh+83czSy10BIgfkX5BJn5UaIbJBjhf2qxuwsLXCfWp9blQBE9ziZJij15W4x/rQ
	qpBrb/m0BozPl20JhL4GSnJWejHkJsEhU+Y+2f+oJMqJhxPMKaQnX/VOEwGV8aEU7SDV+Hq
	M6z85nDkrRUCxfHvn97/NvRkpVU1tPu+JfITkcGhzF29pepN97saAVR+3fj1IDMia3pisSH
	kT6VRwJE1xhqE3e9IzOKvSnt8VxpKx6DTMVVdGx8Jkp0Hzn46hbC172Bb6+IRDHb7Tn2Cih
	gNmm+37N7JXTOl5Xm6dnixSjdzqM8ZsgrH+jLfOHLoFfYm7YuZfHIahEwMabUkfY4sIjU31
	yjqGAfh7a0mhK7Gs7H7ggd1TnH9Px9V11dYr2yZViKqXCiHq/wqc0122/btVUoV1fTafInD
	TSPHVj4wacy6I+1bsxFPQ7RIre8sXBnTdeTtjATlZSCZvUgF4xpQIMDzNahjAxgMSPZNyN0
	DbJHR23Mf/8ReYPr4TQbbwimOCersrNqUqe4a+fb8jncczaY8E+HdxfdrtZjdEASEpyI/dD
	wSFYwqckb0udayfsiJ50jtW5j4bXYxCAEKqADLRXGlj5HIKl7o/l5jHSJT9wtl16F7GX3WF
	Mq0zzmqOJS1J/q/Xm+KTAGSTSDge8xMz5i8VICGTk7BMch1qflj7i2Ov2MPAaFXf2fTrP7Y
	eR4+60za1muEP3XxI5atNMfoRN9vr9f0iIK7lPM0Xm/HhRh+jQDc0zwR02KTQw6pwB8VaWp
	BkY+OSFH/CMdjQA1Aa3PJV8vvuawKsJBLmuDnnTYJVHhE5ucHYvGfBP3932WgkPZhX4/s6I
	N4HvmCz5tg0Lum9r1rnMY8/cZph6Tvhh/G1CSCj7mNX/yt9nEjL7jK44Q4GTv0lfsU4eYEe
	g==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

The macros TXGBE_INTR_MISC() and WX_INTR_Q() rely on the standard BIT()
macro to generate interrupt masks based on the queue vector index.

On 32-bit architectures, BIT() evaluates to a 32-bit `unsigned long`.
Since the number of queue vectors can be up to 63 on txgbe devices,
performing a left shift of 32 or more results in an integer overflow
and undefined behavior. This causes incorrect interrupt masking and
unmasking logic for both the queue and miscellaneous interrupts on
32-bit systems.

Fix this by replacing BIT() with BIT_ULL() in these macros. This
ensures that the bitwise shift is always performed safely on a 64-bit
`unsigned long long` type, regardless of the underlying architecture.

Fixes: e37546ad1f9b ("net: wangxun: revert the adjustment of the IRQ vector sequence")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_type.h    | 2 +-
 drivers/net/ethernet/wangxun/txgbe/txgbe_type.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index 65e3e55db1cf..0520288d18ab 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -1427,7 +1427,7 @@ struct wx {
 };
 
 #define WX_INTR_ALL (~0ULL)
-#define WX_INTR_Q(i) BIT((i))
+#define WX_INTR_Q(i) BIT_ULL((i))
 
 /* register operations */
 #define wr32(a, reg, value)	writel((value), ((a)->hw_addr + (reg)))
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
index 877234e3fdc2..fddcb011fa2f 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
@@ -303,7 +303,7 @@ struct txgbe_fdir_filter {
 #define TXGBE_DEFAULT_RX_WORK           128
 #endif
 
-#define TXGBE_INTR_MISC(A)    BIT((A)->num_q_vectors)
+#define TXGBE_INTR_MISC(A)    BIT_ULL((A)->num_q_vectors)
 #define TXGBE_INTR_QALL(A)    (TXGBE_INTR_MISC(A) - 1)
 
 #define TXGBE_MAX_EITR        GENMASK(11, 3)
-- 
2.51.0

