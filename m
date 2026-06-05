Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6733E3542D4
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 03:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780629011; cv=none; b=JVj0qmmH2cbfWjoqEPMZCHbJGAOW26LIOM9tfuWqGkJyA2XBuBBTak3SSkPfzlyOeKkKyws3rCBh7FzfTRcV17z7fJcCUMg6gLl+WXWLjRVDv7LdcL4O2BoHS8WcI5R8snlowN0c6PSWjdDNl7e5VwqwakulQw/NfERK44bK6qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780629011; c=relaxed/simple;
	bh=7ZbhsAmErXfoZtkQrmTQ+rdUChNpfAHnnK8k380kei4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nHCFofd3rKWnQTc+ksthjG/5Y4VxI4QzonJzIzSYomuviUKSf0QHWOX9Vs/brb8k2fTV3ix3dIuOCJYoFkBDBR8qMqVBGF1XQc0BmtC5UQfzV09joQySUNs6JVZbimVvWcAVIARuAcye9Jy+pU/shoDn0a2vsj+D528tpV4JMOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpsz4t1780628944t0d4a5bd6
X-QQ-Originating-IP: xFRs0rvGwHUgaQvxNqejK7ExMg43sN5UhL7K/f0n+aM=
Received: from lap-jiawenwu.trustnetic.com ( [36.24.207.111])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 05 Jun 2026 11:09:02 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7724180085447198529
EX-QQ-RecipientCnt: 9
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net v2 1/3] net: txgbe: initialize module info buffer
Date: Fri,  5 Jun 2026 11:08:48 +0800
Message-Id: <20260605030850.17796-2-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260605030850.17796-1-jiawenwu@trustnetic.com>
References: <20260605030850.17796-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MAhyWAJRphZxbrbdoPpGVx5Rwpbzdn4kbX0VGc6w9ofvsYiCKc1r0zKV
	L13KK+MOOD3blh0TPOCgnnrS1Tc9d8kFOwdqHj+B8z8Jz3OJkDagsw2x3onEmcFa7DvCJJq
	pA6M+9nG8+SDlKIrmuO0joqCrZ59T7VBcXJ2hOscdaCqzluosvSjAH/ZBRrZCZykWDnb7Ly
	uRk8IWRCDcthlI//QqG4UB8YUP5fAIX5MwPCckWJEnSdYYCZunaH5DcjD/em2ewJcuEieIg
	d9J0fc8+CCRpAtqX7LqxOd6CHySvUud3kcMb0nl+sdYzZJzJUyH9N7SrvkJBkkd/kxpDWDe
	o2Ulb6xg3AnvwXQbqzxB8Vp6e6DjSVX6Hdaf7nE2MdnCVwNHhrOOvfjwJbz2ShqcRqd980K
	TCS/GeLlEhIfN/rx0YZAp/WPoEhwTovpztyYggklrkxlewYH41o1zNX5Nrr6LBCRsV/MZkg
	UcdgAUuz7iSiFLlQjf0G00Y4rDQ57dbpebisobKlgyUivqzxYwt2AP2VX/6uZupX5cZjPJs
	ZayneGL5prSHiv2sWwk6tM+l+jNU1ij4aGrS582JrIR5gNfcKBurmkGuUoCVfXQ9pIhpuHt
	au2imrhztkuGbUfY0zQQiEpmV6RSf9C3tgSq0xexBfV/QWhq2tuZD+/O1XMNy1c5UOftPZz
	0oG3PDQ+xRXXFRUWQpPE8kapzR4CrROd8rXLDbhuAasagmWSae5NRXrQ+5e19z15pvOPaQI
	iuhdH/z0SAU5n08ypR7bjRrhGAOgK52sLM6zFQrOdy3EPn8QCY1hdMfkGLjZbW+aSUeypoQ
	6G92bQjBAlSQTELGU2mfqsEOXeMNBbwOo4Agoht0FFJQ1ExyGcZyX5Nea9pAmTayuGvHJMR
	72rXM449Eu5+g1TCG4gEJe4aS5OWWs/N2ASq2wnlH/7wqPhoz2TQPJOQWJQbd3Wdm3bXvfY
	uhiW6RsVbImUJIk7sECPokIBEpC6okyOMvfe+XnnkWodWkje7xSI3lUBGKoy88GNYHt5otx
	C7O5/jewlXFmZ3p9Kh+ifwl9aD3u+TuTWEPRAj4ksDdScvyDVo13Q4l/x9vKQ3Qsdct6CNH
	QXqpACNAwysO8KyT/u3OPg=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

The module info buffer should be initialized to 0 before the firmware
returns information. Otherwise, there is a risk that the buffer field
not filled by the firmware is random value.

Fixes: 343929799ace ("net: txgbe: Support to handle GPIO IRQs for AML devices")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
index f0514251d4f3..a7e81f9e1be1 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
@@ -335,7 +335,7 @@ static int txgbe_qsfp_to_linkmodes(struct wx *wx, struct txgbe_sff_id *id)
 
 int txgbe_identify_module(struct wx *wx)
 {
-	struct txgbe_hic_get_module_info buffer;
+	struct txgbe_hic_get_module_info buffer = { 0 };
 	struct txgbe_sff_id *id;
 	int err = 0;
 	u32 mod_abs;
-- 
2.51.0

