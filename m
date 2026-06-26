Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F973E0088
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 09:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782466021; cv=none; b=OxYiN1p01gSEvEUdiSQ7AkJirNzbWN7tHDdjj2xmjr9IBdGKIxNPIfWKuqZBzfLT1AWduD4T3j9ORGNvdFd5ku6asA2u1ksiom8T9GgjtK+SioYwBIifb4MmA7tgzFUtSvnNK+lw3z1niZ6hYgc7/ydJyoQvZQGlrDjEKSpr3uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782466021; c=relaxed/simple;
	bh=uQobXsQSNAX3k2ODEqtgDd9YvIiqsBwbs1LBdTQRjGY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IPdompKtHMvC479IfeCJqQ+QbqaQHHjhbeDALgmb1SXDbbRMRRvIxA7fkvDgpR9D5xVVt7ortOB4zFAJgSN67Pi4ieN3DtMTKvMcwkovjlRUvhoys+pTvKPIbzXEvG9FCEmgXF+ZDN09aUip6S4zUxwNwzJr5QLCyJiQBkTCA3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpgz14t1782465945ta89462e6
X-QQ-Originating-IP: 2FF64DXsg90CZzZDiofj2Otd3SmpGS6DM9GeTnyUniY=
Received: from w-MS-7E16.trustnetic.com ( [183.157.4.88])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 26 Jun 2026 17:25:39 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6671071256694873249
EX-QQ-RecipientCnt: 12
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kees Cook <kees@kernel.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>
Subject: [PATCH net v2] net: libwx: fix VMDQ mask for 1-queue mode
Date: Fri, 26 Jun 2026 17:25:30 +0800
Message-ID: <161F704D2C983E2C+20260626092530.551028-1-jiawenwu@trustnetic.com>
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
X-QQ-XMAILINFO: NpuL9oZpxXj09J1j04zkHvJqrSd8VDswtzrKK6o6w0idSfQiJh24O1yf
	juV9JoU3HdPGYcK/JL4aW1ebgq/Am/4ArNOFbxrbxSmU9Tn1w+WEucW0Wl0HkzbrFLrn0FI
	PN13uvZBR1qN4SQU+6rSVWxoqor0fvYGGQYfBvWhIzeYBfiM5Ho2ZKhcw0rQ0OtulXSMuOA
	JViEExEtOTcNZG3H5YJbT5SoJPI2zHJcXjbLGTuc646c/Fu5/Qi4Rzsp1YquhFBVcR2N78B
	ROtRH1u/EJzP7Sf8Qsa10bArupVFTsiQPBhJxS+VvHcFF95b4SkRgn69Uj+/FeEazifu/tQ
	oM0J4wBfL1fe+9zbeAxyvHhsPGXroMHPprOOLp85ckqZwPMrYBeZNMTfAMQW3jDY4zxUa6/
	4Mv5oQYc0XXOz3JGB0JZG2gtZDTACX7Z3jFZm7/5Rapb6bNQwHINUlsLCPzeM5MXInp1IOi
	qccN4ZnVNjakClrVdaEY/92MF/ykAc7vRl4qk+Eft65EF9WTxKPjtO/Sl+NI+3AOOWWC6jB
	QazQ9x51PujLVTZGRFUt3PYSTRth19khSCVXenHcgwIbs6/yPUK/IKuHt8QHUuJGMsIiIC6
	Dz3eXOTg2Q2+Vd4nbhnrJ47GX37x06jW/quVS6UtrBuqaRaBV7EcaRx6UJ6TrJlm5lam+i2
	bJNVkxGGJUtMmBludyuxffAWyXiYf4ZbBltf6FmP4SJD6aU5DU+4sRnKQxP6clAmgwdelHx
	yKSSuU4EVy7h93uqdwrjX40YOJusmxxNf7h1z5BaAn4BoEehoK6+ilaMSnVeU0CWOnBU1XE
	p/94C5nK95dIsHAhJ4spTAy0xANF93eFUa1FT8/H4ABcWdjJmqvVtAgMj8FLuzSzRu+tnIv
	pdThmDC82tWM2jKXhc4aYEJs10y7i9oJW8wxn3vPqJIbvPONCGqvMi5wMcbLfGpS/9dnZ+G
	dbGVrEB4dxK84KTlKnfeobpf57xeUK/D3z4YuLLIOMzKBisut7t2Wmwmb90biS6fg1LK11X
	MI2TfFnExpqYyGXjPsWLwsr3stmr060FZQbu2B3/b0p3UOHWUFLMtTBP4XL/OzXZgSevitr
	3zXUKlWkAxYwyyeupMkGpTtujNS+XNp5Rv7hAMWUYPd9QfjCWInhT0=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

In wx_set_vmdq_queues(), the VMDQ mask was not set for the devices not
supporting WX_FLAG_MULTI_64_FUNC, i.e., NGBE devices. A mask of 0 causes
__ALIGN_MASK(1, ~vmdq->mask) to return 0, which incorrectly sets
q_per_pool to 0 in wx_write_qde().

Fix the VMDQ 1-queue mask to 0x7F then ensures that __ALIGN_MASK(1,
~0x7F) correctly evaluates to 1.

Fixes: c52d4b898901 ("net: libwx: Redesign flow when sriov is enabled")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
v2: Fix the commit message.
---
 drivers/net/ethernet/wangxun/libwx/wx_lib.c  | 1 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index d042567b8128..814d88d2aee4 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -1802,6 +1802,7 @@ static bool wx_set_vmdq_queues(struct wx *wx)
 			rss_i = 4;
 		}
 	} else {
+		vmdq_m = WX_VMDQ_1Q_MASK;
 		/* double check we are limited to maximum pools */
 		vmdq_i = min_t(u16, 8, vmdq_i);
 
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index c7befe4cdfe9..65e3e55db1cf 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -486,6 +486,7 @@ enum WX_MSCA_CMD_value {
 
 #define WX_VMDQ_4Q_MASK              0x7C
 #define WX_VMDQ_2Q_MASK              0x7E
+#define WX_VMDQ_1Q_MASK              0x7F
 
 /****************** Manageablility Host Interface defines ********************/
 #define WX_HI_MAX_BLOCK_BYTE_LENGTH  256 /* Num of bytes in range */
-- 
2.51.0

