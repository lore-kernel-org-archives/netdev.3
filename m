Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794227980;
	b=IclwcdU5n2VS+Jr+FuRHppMphjQJ7ModV+J6QaqjJCJLyAo4IYj0WEaSAHnNKcAEeJgK
	 DW7anL0utmkziKCSKciYCkRchBoRNEFGC8/ZOyhR66UKV7czijlhjLT286wJHUcwejLZk
	 SEXMdAzMTs5j1is92AzgxSfuvMS8IqoauDvfjzw9mdiK3ltzfxmd4Rjqn1IbxQnxXJPx+
	 8CZUq7z3+Vt/Cb4/+s8P79WaBHQAtL6WMlNndp6XKLUT3KOusuVvtg9BwYtqr9pj5q25f
	 jG6iQvDPNkhWGiiLlg63UvQhXeC0iXxKS2zMGGIyVxbaeNWo4jii+2pjYrZsfx/8JfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794227980;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=rY06M7QdvAhj3ZBgODwg8oeaDC5k0Gsd3RRF/QH50xA=;
	b=ImUuRfDRezVNcUQq9TvxT5XomEWAuEbLqnbJGHtQROfv1YNtFa8+D5WgnnQQxVjhdHOC
	 sGaZ1UVsGacUP73P11WOIkLhG3DRBgQs0isok00/6/c7OXdwRc3wE997dIFl8fpoc5jmU
	 CC0WZiZt7seZtIurdhjB/w4HSWPEZxwBq4rTydpwumahUNUpx8aH+oVsFRRl4w4aoCnAK
	 4D6ZV6guO7M2rFws9u2vcm7yv3mJNc7gxudctWWf7c9mfTMeMX0g7sqssWEGcaSmbmGh2
	 iLhXU+hhCapsps+I0J+1FOgwdFUdvHiil5RWmxgSRs7YxsgnaxYVkgZdHvj3amPX87A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0ejDsQ+g;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1328A606A337
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 12:39:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1328A606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0ejDsQ+g
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a9a8d6cea8so9518255e9.1
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 04:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794227978; x=1794832778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rY06M7QdvAhj3ZBgODwg8oeaDC5k0Gsd3RRF/QH50xA=;
        b=0ejDsQ+gaPGFUx9ZNPcnqgTcw8fJ2ie70ixNzVDnm9z725Xl8qU+A5iUp+CwHen58J
         dZ6/vKZRNnKabYgOdhGi41BrZI5ASIs2hmWZt/aulwar3MXjQ2snsZ9duIpgVqX7rYY/
         PDlN498niuG61QeFQ0/hRxmkxNc4MaOVyBaw/ckULs+9FDjRjowarRJKdS0VjvDLbJN1
         Z763WS3fyHrw7ko50BkhDv4m4ccx+0Y3y4Xpq0dMx+O6Ptsx96IUH2G3i2hvpxmB5qol
         rzUfOF8Uc25hLdlm721rOGbgFEKRu7LptrG06g5isHs/opoimxHqicuepNYVyrjxpEGA
         fpxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794227978; x=1794832778;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rY06M7QdvAhj3ZBgODwg8oeaDC5k0Gsd3RRF/QH50xA=;
        b=Xmxck2lXOq95H4+ijUuirgdy4pGIEQ3tp8DjkWo7S/vO4igeg7hp2D4n6Xxf0d8KHm
         fMZoH+6CBqMxtR5qvzto9mqbOWz1J+FWYj7+pOO50ZwTpgUhGFR98E2/iTTZY6ddmVnO
         GXfbfX3YWC6+saY95SYxcgYXAh1U/vNfeQewvkrbSbhQlE9dX94dApddHbtfDwOHrLuR
         6Xh4EB/WxWrjPVDkrNRbZHk2yqjqouSwCoI1cA6STJ/dx4AKR05SxyNOpGY13kYpSS+H
         LBpQZctTSH1zu9o8bJBfpS0gwXK6KhPyxar5p+uhiY6ERtNoWY8Fr8NicbOO31l4WmrE
         M1JQ==
X-Gm-Message-State: APuU4Z9La+b6qQmwfPKyzvA0h1q9Hy5mYzEzkE2h49kC2qvDiRec+kJ5
	WuNjvlT2AharlOqcOC1Lk2hEVr9ecNTyaf3FHLoPONOGzblQ2y6KKXot
X-Gm-Gg: AYBFou1RcG2jVA+8bkVFqDK2+Q/i8WbTg0+jCrgqdzIcUdc9hhrniePBU46EudSnNK5
	kbuN2KQvnHG5C31SLpT6daHOemNI/UFDp6HSo66Lz6IrzFrXEmMof8NKmqsVAjbTpmGYjhjdwer
	OZ17+rKBmnBKE+K6XyQlnT1PrueG7oR/46qAmL9B+heIxx+yHt4aIpRS9y1Dz9xudv7cL6fkLo9
	cTbnpzVsQ4xHWv+FKNLs3tnWVUpIbcJoGRz9PfGvHqPUZ0h8413rvV8kvrbML4DPRLihwKBQBog
	t3Jw5AHjHj5ruE8+3+TtiNrceMYbimWCJP0EiOdNn34qzXCSEwhm+q+Y2x2wmzT1QhsTCokr8tG
	d4nPO6VCMgWyjE8hm4X5jfRLRtv8D44Caa8J89VwewuX56wQrU7hcUlMGhItZwzJt9bpkJbwWIn
	gNyXEUxMiTHy08H69D/Obn9pmi4HWGFL8LnDUuFLd2YXs9ZNcG42uQjbUEkuntP3hEyinFkurvf
	hikC7MMoGpt9ZAzEKC2tEP4rZ7TwWG/TieG7HicoJkG8SEa/kF2kaE08X2XPeKvuac1OvnUe2eM
	+nfsqUe+u46STc5vVpCB4hlontSwuxmSpRZs
X-Received: by 2002:a05:600c:468d:b0:4a2:18c4:61a5 with SMTP id 5b1f17b1804b1-4b960d9c5d6mr78385825e9.6.1794227978040;
        Mon, 09 Nov 2026 04:39:38 -0800 (PST)
Received: from LAPTOP-AVI.lan ([2a06:c701:474b:1700:cbcb:5571:c75d:7e32])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b90f10c681sm126728795e9.10.2026.11.09.04.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 04:39:37 -0800 (PST)
From: Avi Weiss <thnkslprpt@gmail.com>
To: Arthur Kiyanovski <akiyano@amazon.com>,
	David Arinzon <darinzon@amazon.com>
Cc: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net] net: ena: avoid double-counting TX DMA mappings on failure
Date: Mon,  9 Nov 2026 14:39:34 +0200
Message-ID: <20261109123934.824610-2-thnkslprpt@gmail.com>
X-Mailer: git-send-email 2.43.0
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

ena_tx_map_skb() increments tx_info->num_of_bufs after each successful
DMA mapping. If a later fragment mapping fails, the error path adds the
fragment index to this count before calling ena_unmap_tx_buff(). This
can cause DMA unmapping of buffers that were never mapped and
out-of-bounds access to the buffer array.

Remove the extra increment so that cleanup uses only the number of
successfully mapped buffers.

Discovered by comparing the in-tree ENA driver with Amazon's standalone
ENA driver.

Compiled with W=1 under x86_64 defconfig and allmodconfig configurations.
Fixes: 38005ca816a7 ("net: ena: add functions for handling Low Latency Queues in ena_netdev")
Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
---
Already fixed in Amazon's standalone ENA driver:
https://github.com/amzn/amzn-drivers/commit/1d6a78cebd2d7c38b4dbdee572ab3d3755086248

drivers/net/ethernet/amazon/ena/ena_netdev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 7eb6456ed0d5..e0df628e1df6 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -2608,7 +2608,6 @@ static int ena_tx_map_skb(struct ena_ring *tx_ring,
 
 	tx_info->skb = NULL;
 
-	tx_info->num_of_bufs += i;
 	ena_unmap_tx_buff(tx_ring, tx_info);
 
 	return -EINVAL;

base-commit: 30c71476d842b094651bd7712f6c8ee8716147d0
-- 
2.43.0

