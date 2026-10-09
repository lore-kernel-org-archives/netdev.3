Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D425D5695
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 08:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791535539; cv=none; b=JNZzQF10XHggVglbBSLIDHlZz4EJDTXiUhcEt33pjlKjuXp+KrYijLspQ93fiJQ9UtvKlGOl3Vi1CYX+6PqOLEMBrrtox239wC8sAi41lsMp4wXnkna2q8H5t+csVBJYBitJPGtgKdYh+15XJhr7X1X3XHlgX/NP67yEyIUq4HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791535539; c=relaxed/simple;
	bh=9rCWB24X9RjJxeGhXkbqH1YQfj14CxymKkWCxBfvCR0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jCd5PA5atzjrVURwl87akJmHiPbVgodLEOfuIXdzbGAJxox/4FeDBqSHoudEwHV0kNJl9N+AY7jClnE9TbUj8dM731TvW4YaRswcj2nnLR26OkDv+WEoi6p1b8cB7fOWW8UibcrZghefII+37sEYmDw5zXE4xCQgvmaWbmNQy/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZc/ndzA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZc/ndzA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2FEF1F000FF;
	Fri,  9 Oct 2026 08:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791535538;
	bh=3XognZQRKqic/5FKlw+TNFSjkIgpQ6hEfswuBM8M7NQ=;
	h=From:To:Cc:Subject:Date;
	b=ZZc/ndzAELwXdxosm7lAqHxu7/gC8e4N0/h+jou8dqrSOcnhC4RY4FX2oJ8QR/mQb
	 wtiT9LqYfhijA7EYJ2ZxpbOUB/OwgNqGLsZ0Mat311PUxy0svbcoH79eSx9lW7QSaL
	 +jBp1F0xeICjFdf/e2JBZodynTy6g0eL/vADwRNzeyWgMFNWMoA92XEwrFfUApIUE0
	 mwC5Av1zO5XW5POEGQhFoe/UhSfTPePwGJ1RWFldzsNvIfCjAvJJtXazo1DVGFPjO/
	 kNIMSIyNvWMbvrZy4fXKlTOefDg6JPHZ8zumAWYfLLf+JicJBEZY8C1xXg9v0qai/J
	 8tJM9YNzVj+sw==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Eric Dumazet <edumazet@kernel.org>
Subject: [PATCH net-next] hinic3: use skb_put_padto()
Date: Fri,  9 Oct 2026 10:45:33 +0200
Message-ID: <20261009084533.735996-1-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hinic3_send_one_skb() pads short frames with skb_pad(), then
sets skb->len directly, leaving skb->tail stale.

Use skb_put_padto(), which updates both.

Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
Medium term goal : remove skb_pad() in favor of more robust alternatives.

 drivers/net/ethernet/huawei/hinic3/hinic3_tx.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
index d19cfbe3ed3b372136e64d767dea366bc4f46637..f92568f0f00b74e28c789b7ef444db9d4fab4d0c 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
@@ -541,12 +541,8 @@ static netdev_tx_t hinic3_send_one_skb(struct sk_buff *skb,
 	u32 offload;
 	int err;
 
-	if (unlikely(skb->len < MIN_SKB_LEN)) {
-		if (skb_pad(skb, MIN_SKB_LEN - skb->len))
-			goto err_out;
-
-		skb->len = MIN_SKB_LEN;
-	}
+	if (skb_put_padto(skb, MIN_SKB_LEN))
+		goto err_out;
 
 	offload = hinic3_tx_offload(skb, &task, &queue_info, txq);
 	num_sge = skb_shinfo(skb)->nr_frags + 1;
-- 
2.53.0

