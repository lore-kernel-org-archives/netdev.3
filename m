Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704274;
	b=0nHmoJ/e75++UrSt5WtckXoHqnAklfGD+JeHlPqf60HgQrEkz/PTM4DKTRmobu5lpetR
	 kpSgLgTXgZJgJI8LVWX5LrbeWllefBxZm22J8SsfxsZpzOGula/lpoNxHZEKR8xMurHR8
	 tsmXD489T+tyb4G7b/pl0aduH2coSsvllHBGtm/2wb7lOeoV9P2C/TbVm11XBGDMS4FHG
	 2ZD5jk9fdgG1QZd1tfvWxYL0EA/8z3qG17PKd0Q0RQj4K95XkigmLXXD5Y9CSigFtwz7o
	 1DTdJmpFNHJh+mHLb6om17LoIy7AzMoxVUjbOGs0iu/KG5Nd96TK+bjF36c5z6DhR3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704274;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HJXvKBetJ6+D3f3qQFBtlAFYG6QMCgZ7DblhIwwwoDU=;
	b=Kvfn53BU/YuoVm2F3rAwmpE5BZ0fmtrjQbSi91QBLQm/fd5h+49VBfoRNq09LugTbvwD
	 Mf/KFpS3xM/sj1KDty/z54KrHo4B9RuJpBY+q0ZujdmMGLZ6wjX+iO4jUflJLglABn3O9
	 FB9Ej9kt33KCTt8Ksyf/H26bBG2pAaOh4yLmXPi1JggHMTboNwJ+z3Xr40OITzFwOmR86
	 mCpxyrMOEmo5xpiEv4Ctzpf+y7tXuFXPdniqKFzm0fR70cug4hPitfPiuIfpAemd359B0
	 yUgBAUeRuyB5/le96viA2ZYRPL7JuETWOXoSGn0Jzjrr/cPXVs/daTTeg90AITHOG4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=dbjquFjY;
	arc=none smtp.remote-ip=115.124.28.5
Received: from out28-5.mail.aliyun.com (out28-5.mail.aliyun.com [115.124.28.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E9860A5BD0;
	Tue,  3 Nov 2026 11:11:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06E9860A5BD0
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=dbjquFjY
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1793704263; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=HJXvKBetJ6+D3f3qQFBtlAFYG6QMCgZ7DblhIwwwoDU=;
	b=dbjquFjY+H2MRTiqvXr5HtN/YqoFMmioZXNtQ+dZziZV8HvPdRO9Q6MJvsRYpnhWROu1gDYFi7S4pW99mM0lGM/Wqxeh2kGAhFPzrjcwt1jb/Vo9w5DwhDEYIkZvLdif8y78oDzYQYCSq+HsVycwZNqZ2wIJbRILhWVjPHzI7dU=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.04992287|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0172255-0.00111262-0.981662;FP=15865239930251679264|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037071049;MF=fangxy@xiaopeng.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.jviODwI_1793704261;
Received: from localhost.localdomain(mailfrom:fangxy@xiaopeng.com fp:SMTPD_---.jviODwI_1793704261 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 03 Nov 2026 19:11:02 +0800
From: Fang Xieyan <fangxy@xiaopeng.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	Guanglei Zhu <zhugl3@xiaopeng.com>
Subject: [PATCH v2] net: wwan: iosm: drop redundant skb->data check in MUX DL decode
Date: Tue,  3 Nov 2026 19:11:01 +0800
Message-ID: <20261103111101.39235-1-fangxy@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261102081920.50288-1-fangxy@xiaopeng.com>
References: <20261102081920.50288-1-fangxy@xiaopeng.com>
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

