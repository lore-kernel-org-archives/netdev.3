Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.73
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793607573;
	b=156ojIlJBw7iL/SKsCTZ09SMnjQe1evqbbpSGSQ6sw/GDhHa+LINPJA++ja8A/8L737l
	 hGcSsgoWnAboGtHtKt9kTHtCSYF9zl2dGGVgW5SQuaS4zYml520GVONUqBoPeQmAj8cOy
	 j5spsrkAoxuiZTrkdhmcOM2Ne2iVov1aT4T5VxWG2ApmJ1zUKgO6OjeFG2e1cuMUpfhbf
	 DWqhw3TzK/9Oq7pK/1PNhdWuFlBGI/SI4WMW6exi1Crfqmf0oRa1rnkb8KXHvY2vOpcZF
	 Ek3+QXSjgqXW55n4TiAouezN4P47fPu76FtHBel8dfgJ+bDB0BI4QXtoG8+49yDZhKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793607573;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AFkBQiMpQlhW84bwcrPZ9udkYJ4gGU/LT5A6u2zeaHA=;
	b=C43z2l2eiJuxg9HRayFFOMu4Rztz4DMl7BDvM+i5EwOHpJBBG9peUqfDfwSJZLN1vHmT
	 1gZA/EqafV7+IQs8UlQ8YNMZ4S9A1CMMBA6jWR1SQ8hloBVVFCLIdwE44nZnRbDObZ7b2
	 DzRlq3pApjy9jq0HtEZlBm8UpBX5fw0h2hqvVbk13P/c6eqek8XDQ9NGgOLTU6Z4mL2O8
	 dWtI6zCXBBzrPkNKqFE6WbjdnH0DRhiJWT/yus9iGT9WsY9iTET7WmGdHGFhFoyc7qC49
	 42E8/ATvPEZTSemCJQ0r9nWcywqREEOiZw2YZ1DQCEZ28Yb2pCbJouw+SlvkTYqWI2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=nCYulSUK;
	arc=none smtp.remote-ip=115.124.28.73
Received: from out28-73.mail.aliyun.com (out28-73.mail.aliyun.com [115.124.28.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B4C606A334;
	Mon,  2 Nov 2026 08:19:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89B4C606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=nCYulSUK
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1793607563; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=AFkBQiMpQlhW84bwcrPZ9udkYJ4gGU/LT5A6u2zeaHA=;
	b=nCYulSUK1NSP2oXlOT3cfAcHIsXMFkaMtSoY1euNDfCAbGdPE0ZM2ewjKg+8IxvWcQlWWHmW/5EmxtjCc/n5OlbpBPrnqQGyTSAilQ8/7ld6g3Ri6iQYeJk/5SvzaeFOkljdTRI4wMPsZIp5ErUxxOh5nyaNux6adBWQ+zIDq64=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.114431|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0497418-0.000651247-0.949607;FP=5497953585913824900|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037026024;MF=fangxy@xiaopeng.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.juoIh3N_1793607560;
Received: from localhost.localdomain(mailfrom:fangxy@xiaopeng.com fp:SMTPD_---.juoIh3N_1793607560 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 02 Nov 2026 16:19:22 +0800
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
	M Chetan Kumar <m.chetan.kumar@intel.com>,
	Guanglei Zhu <zhugl3@xiaopeng.com>
Subject: [PATCH] net: wwan: iosm: fix potential skb leak in MUX DL decode
Date: Mon,  2 Nov 2026 16:19:20 +0800
Message-ID: <20261102081920.50288-1-fangxy@xiaopeng.com>
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

ipc_mux_dl_decode() owns the received skb and frees it after
decoding. However, the early return when skb->data is NULL
bypasses the skb cleanup.

Free the skb through ipc_pcie_kfree_skb() before returning
to ensure that both the DMA mapping and skb are released.

Fixes: 3670970dd8c6 ("net: iosm: shared memory IPC interface")
Reviewed-by: Guanglei Zhu <zhugl3@xiaopeng.com>
Signed-off-by: Fang Xieyan <fangxy@xiaopeng.com>
---
 drivers/net/wwan/iosm/iosm_ipc_mux_codec.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c b/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
index 0bbd41263cc2..61700688eac9 100644
--- a/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
+++ b/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
@@ -693,8 +693,10 @@ void ipc_mux_dl_decode(struct iosm_mux *ipc_mux, struct sk_buff *skb)
 {
 	u32 signature;
 
-	if (!skb->data)
+	if (!skb->data) {
+		ipc_pcie_kfree_skb(ipc_mux->pcie, skb);
 		return;
+	}
 
 	/* Decode the MUX header type. */
 	signature = le32_to_cpup((__le32 *)skb->data);
-- 
2.50.1

