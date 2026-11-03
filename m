Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.219
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793717980;
	b=mCOvTwW4fzRmFQ8drYDUbUkuVUlwTLMXaILSWjLuR5ArI10KQj5z0dxf7bMy0DAnlyMz
	 gxDKHBb8BxDLI45ZFWBsmB3AKHCFeP0KSLrjVF0h8k6JMLyKu4HiIu/pKOc4OL2nQJdic
	 oUGxjuqHp++lxqBoib6xrfHk6woKQjDAFTsK3dFjgkGRJdRnUzH5iQEG6RFkmUC8ZkCve
	 tjnpDcJJQRp3Zzzs4YuUkWRsS7gd3VnjzDjobus/rqN791NvlWQMecVmAA2GlNcn8TZXu
	 Csr+FmmmWCdPJUaaXBeqRXWeJnRmkcuLUp4s7QyhQsTx9VWAs7P5VMyzgYZr/pvRENA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793717980;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HJXvKBetJ6+D3f3qQFBtlAFYG6QMCgZ7DblhIwwwoDU=;
	b=f969A2ECE2/ghIcwzqxXKQxhkLiPdF3veRjS4fdabVxoWyNEwyL0zge9G3ovEiXEd50B
	 2bV7eQaaLTsGti6kcDQovgcK/KksK8eug6obaFVzYJMF6vmTVM5kTEunZxW44MVUfjdRj
	 Tzv88tafBW7W7zTyakRcRa8k5H7g7Kyc4VGUSv9Q2H2oTXOBLaudrjuN3bpC7xphqvMC2
	 uDYScPTIob/2fFWeR8LJ7WVVUrkpxaA4OIrlAqoyzLvBj3Ckup3pTqgnl+dvGZyrQ0VGa
	 HCzieNFmkJnKixiYYUroNUqnYPxsD45bsZkkywN0C6B3rnV5CIG+bjRD5Oc74K9/v1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=DWIf5lj5;
	arc=none smtp.remote-ip=115.124.28.219
Received: from out28-219.mail.aliyun.com (out28-219.mail.aliyun.com [115.124.28.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1096071A27;
	Tue,  3 Nov 2026 14:59:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB1096071A27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=DWIf5lj5
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1793717967; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=HJXvKBetJ6+D3f3qQFBtlAFYG6QMCgZ7DblhIwwwoDU=;
	b=DWIf5lj5pQxsvZO5kq8EZuv0PPTfLF/ICrpc3b7YoViaVPRCdwTMDABnvxJvBbbEJsdD8bjw3ejP02HUix0zEFLaiigF1h6l43wePHKH6LFfji4STGXjZ+BQxzq3cgQZlSIKIIkS4a0mq3IfmJT5758rsPSPhiv6yIbDmn4/VVw=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.04992287|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0172255-0.00111262-0.981662;FP=15865239930251679264|13|2|16|0|-1|-1|-1;HT=maildocker-contentspam033037034138;MF=fangxy@xiaopeng.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.jw3q3hF_1793717965;
Received: from localhost.localdomain(mailfrom:fangxy@xiaopeng.com fp:SMTPD_---.jw3q3hF_1793717965 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 03 Nov 2026 22:59:27 +0800
From: Fang Xieyan <fangxy@xiaopeng.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	Guanglei Zhu <zhugl3@xiaopeng.com>
Subject: [PATCH v2] net: wwan: iosm: drop redundant skb->data check in MUX DL decode
Date: Tue,  3 Nov 2026 22:59:25 +0800
Message-ID: <20261103145925.69981-1-fangxy@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The skb passed to ipc_mux_dl_decode() through the current RX path
always has a valid data pointer.

The only caller, ipc_imem_dl_skb_process(), checks for a NULL skb
before calling ipc_mux_dl_decode(). The skb is allocated through
ipc_pcie_alloc_skb() -> ipc_pcie_alloc_local_skb() ->
__netdev_alloc_skb(), which provides a valid data buffer on
successful allocation. Allocation or DMA mapping failures return
a NULL skb instead.

Remove the redundant skb->data check.

Suggested-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Reviewed-by: Guanglei Zhu <zhugl3@xiaopeng.com>
Signed-off-by: Fang Xieyan <fangxy@xiaopeng.com>
---
Changes in v2:
- Drop the "fix potential skb leak" approach. The skb->data NULL
  condition is unreachable through the current RX path, so remove
  the redundant check instead of adding an ipc_pcie_kfree_skb() call.
- Drop the Fixes: tag because this patch does not fix a reachable bug.

 drivers/net/wwan/iosm/iosm_ipc_mux_codec.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c b/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
index 0bbd41263cc2..2b8a22980c87 100644
--- a/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
+++ b/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
@@ -693,9 +693,6 @@ void ipc_mux_dl_decode(struct iosm_mux *ipc_mux, struct sk_buff *skb)
 {
 	u32 signature;
 
-	if (!skb->data)
-		return;
-
 	/* Decode the MUX header type. */
 	signature = le32_to_cpup((__le32 *)skb->data);
 
-- 
2.50.1

