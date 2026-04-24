Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE07A221FCD
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 09:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777021257; cv=none; b=kJcxsStx8uv7w9FoP1eWdGLO9UavKTUru6Z37kx4dRcGw8hsGdc1Wpl6fY0EEyXwx/vwF0j9uEMz7BafF7AFgHBf9btyQT8Xz53/ZUqj+4uF8K4Fyu9N3ecQPFWtb2J+P+dSWJ++wSBc8fLPQpp5PQdr9EaNZhYH8hkWlhxqNv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777021257; c=relaxed/simple;
	bh=ZeT44hZbko3HmfUaBLlU+YH/qX5dhh/ai7xlsyQJ2M8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dK+dKeKV0IUK3NKC0dPpqcdbZhzl52SSDXpXmNnagSINngHEhk5uKsnxSOIOL9ibzMPu66CabG/hM2NZG0ye9bOds8aYHYDM6H8fkQ3xeQBECFwfXUA4OkFzI4ylr3YGd+nXgzk6nF5SOqDPn38U8o93WMW589VC8y27NRhvYEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BOhnEJn3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BOhnEJn3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B754C19425;
	Fri, 24 Apr 2026 09:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777021256;
	bh=ZeT44hZbko3HmfUaBLlU+YH/qX5dhh/ai7xlsyQJ2M8=;
	h=From:Date:Subject:To:Cc:From;
	b=BOhnEJn321yXt4NlYDKi7j/HRsmSFMMl195mebaqniXdXXhlOnE/JNkt7/yR0EtEK
	 aQbxw/LUMcMlq8STkoKVvkn1cgjkZMxmqc4ZDozEoELmAgWEn6Pc/bbE+9eYS8smbe
	 gWznnuSnii7GzScGx5HhuezXmv+8gPWfOQ1ufPBIxMk7cS8bajrYQBLw/puRa9ar14
	 D53WSFzsuFhA5bE/+NjlbY9BGDby3HRt3ZJSbrPAOry+m+NWaLGuda46v2g76gl0r9
	 12sxbVZ3YR/7ta/5QJ0+brIkbgVuXCLEsLX7JZ8/BNMPJ/fGMiJehCm5ffEvui6eCV
	 zGO0fMYn/GLOQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 24 Apr 2026 11:00:28 +0200
Subject: [PATCH net] net: airoha: Do not read uninitialized fragment
 address in airoha_dev_xmit()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260424-airoha-xmit-fix-read-frag-v1-1-fdc0a83c79e8@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MMQqAMAwAvyKZDdQqDn5FHGKb1gxWSUWE4t8tj
 gd3VyCzCmeYmgLKt2Q5UoWubcBtlCKj+MpgjR3NYHsk0WMjfHa5MMiDyuQxKEX0biQypnM0rFD
 7U7kK/3uGxBcs7/sBGe14GHAAAAA=
X-Change-ID: 20260423-airoha-xmit-fix-read-frag-dc6aa001ca4b
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.3

The transmit loop in airoha_dev_xmit() reads fragment address and length
during its final iteration, when the loop index equals
skb_shinfo(skb)->nr_frags, at which point the fragment data is
uninitialized. While these values are never consumed, the read itself is
unsafe and may trigger a page fault. Fix this by avoiding the fragment
read on the last iteration.
Additionally, move the skb pointer from the first to the last used packet
descriptor, so that airoha_qdma_tx_napi_poll() defers freeing the skb
until the final descriptor is processed.

Fixes: 23020f0493270 ("net: airoha: Introduce ethernet support for EN7581 SoC")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 2bb0a3ff9810..d3a841908c82 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1997,8 +1997,8 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 	struct netdev_queue *txq;
 	struct airoha_queue *q;
 	LIST_HEAD(tx_list);
+	int i = 0, qid;
 	void *data;
-	int i, qid;
 	u16 index;
 	u8 fport;
 
@@ -2057,7 +2057,7 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 			     list);
 	index = e - q->entry;
 
-	for (i = 0; i < nr_frags; i++) {
+	while (true) {
 		struct airoha_qdma_desc *desc = &q->desc[index];
 		skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
 		dma_addr_t addr;
@@ -2069,7 +2069,7 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 			goto error_unmap;
 
 		list_move_tail(&e->list, &tx_list);
-		e->skb = i ? NULL : skb;
+		e->skb = i == nr_frags - 1 ? skb : NULL;
 		e->dma_addr = addr;
 		e->dma_len = len;
 
@@ -2088,6 +2088,9 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 		WRITE_ONCE(desc->msg1, cpu_to_le32(msg1));
 		WRITE_ONCE(desc->msg2, cpu_to_le32(0xffff));
 
+		if (++i == nr_frags)
+			break;
+
 		data = skb_frag_address(frag);
 		len = skb_frag_size(frag);
 	}

---
base-commit: e728258debd553c95d2e70f9cd97c9fde27c7130
change-id: 20260423-airoha-xmit-fix-read-frag-dc6aa001ca4b

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>

