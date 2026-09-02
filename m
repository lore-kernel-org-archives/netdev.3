Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85E72E7F20
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 00:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788309235; cv=none; b=i0CCWIuvFfZFvXzp3ECiwnv8MCK8NidwCSE6lHVomMGJiWessuvBly6NfWBV9ArP2CfnjhPS7AESoodAeKPOtbEi5UaPA47UfYkzCKgcbWVkWQUt/AIueVgNNkvRh6OvE9Scv6QrZm6559n4DyFYryOys6Pyma3EIVYNSNdD97g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788309235; c=relaxed/simple;
	bh=JkrarFLpVGvXrp35VDCmxtSn9h8rU4qbgun9qZVc0b0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZEvmd7XZL9hHs6rAUYy5mT8V6yZoCX8xljmARgDBrOaDMGyYXGfQFUfOTryfKxe1gG/DOxP0hQq2lU7CzfH+qVq1aAC37ywATl1s8TjwnIuMDqTCAUgXxnhQP6H7pL809/MgJE8kJGldbDf5IUBhR5uWg3Rw/HfkCqPtVAkwke0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=urvcVA+h; arc=none smtp.client-ip=209.85.222.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="urvcVA+h"
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92ec3146553so152035485a.1
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 17:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788309233; x=1788914033; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rsYwQUT2FqlB+OXWh7o893yGwjKfELCZIREwonxTyZ4=;
        b=urvcVA+humceUkW/CkTixLa6TcAHtExKpAfie1p17SFMCMV7PVN4BM/zJSUofd1S0J
         CB4na4G2CDnleHn9MZXOO+yuupqt9HIbd8FVSmeqe/eNRnghDovIObvUw2nKRRXVFlNH
         LhnYVA0/lgp/OFnAdT4iZvNXjuiZhHVbZ2HQYdEpU+tIu/359Rhgl6WNrVxZZg+AXgYc
         6HnGcPT3Rnu3EnY5DVKq8XuR34wqKl2e3UHrtpC6gtIPI8mymoafSXWx5GLCoS2Snsea
         CtL+fRXCmaDf7PBQifngMAMSOEYU4oRSwSYQiIBiM5G6aPF2qHwQZRu9UmHx16o9baPP
         1LDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788309233; x=1788914033;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rsYwQUT2FqlB+OXWh7o893yGwjKfELCZIREwonxTyZ4=;
        b=WPgLvxFLHd4sh3nBjfM7OADMx7OHtw3XOk7EBUWR6sYG8v0lEuiZzoGEw87bVaA6d/
         akew5388vSbBULwmDmNSlEphRBkvfHnI8M7MKC3g/uoTAPlYGyH7IR85YEd4RyWQ5lJ5
         H6So6dq6JpB12Z7poklyF7XBuViQxl3rvl+h8YuNaCTrJyd2XLdY2wU7zB6PzFv5Mkej
         xwWJuz/EMpspIzbRSnIC9OySfr6PpPr5tQ9gmykt+YQtzIxx1a02+cKfkcT6PZ49kLFY
         Ca5wMmD3HWONCzSnK8sEc4TkLdDy7BttVwwxkm4Gj4svheEePztvOE2I3z9mdrZ5wQhO
         XOSA==
X-Forwarded-Encrypted: i=1; AHgh+RpVGgBf9ftlB+cZ3ZxLSLtO95BkqDSSheXELqCN2U0hfh2eiHFVjGkZNbeswsDC61FQpaqawn4=@vger.kernel.org
X-Gm-Message-State: AFuF++nr9/3FcCJJzcxljAayfuM3U+1NUd2SsdpevYDRI3YPjajfiQ2b
	mcjGolfs1zw6eRADFlEUIPbxOKS5ntKqUibgjFXYvkk6hpzs9dlQs3Q4n/Zu74sgmD8QeoPfaeT
	e2BRXzhwsckzYGA==
X-Received: from qkntw12.prod.google.com ([2002:a05:620a:3ecc:b0:939:1ab:c025])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:9342:b0:936:dfbf:85b0 with SMTP id af79cd13be357-93960f890d8mr134302185a.35.1788309232427;
 Tue, 01 Sep 2026 17:33:52 -0700 (PDT)
Date: Wed,  2 Sep 2026 00:33:38 +0000
In-Reply-To: <20260902003344.1931843-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260902003344.1931843-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.966.g6673acef38-goog
Message-ID: <20260902003344.1931843-5-edumazet@google.com>
Subject: [PATCH net-next 04/10] net: mediatek: do not assume mac header is set
 in mtk_start_xmit()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

We should not assume mac header is set in output path.

Use skb_eth_hdr() instead of eth_hdr() to fix the issue.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index be3bd025c41a1c90511f2d36806bfd075856e486..6be0080e6233fad3bfd8b5c9027d3d1759f74878 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -1785,7 +1785,7 @@ static netdev_tx_t mtk_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	int tx_num;
 
 	if (skb_vlan_tag_present(skb) &&
-	    !eth_proto_is_802_3(eth_hdr(skb)->h_proto)) {
+	    !eth_proto_is_802_3(skb_eth_hdr(skb)->h_proto)) {
 		skb = __vlan_hwaccel_push_inside(skb);
 		if (!skb)
 			goto dropped;
-- 
2.55.0.966.g6673acef38-goog

