Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777B23E4C95
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 23:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792365396; cv=none; b=ffQDU4BjiCQEu5ZdYzno/lAYACGj64WDVgthla7yhIl2OkVviJJjkWm1GELl+V1Xj/JH0NkOSlnmbwh1pAaIehQk1iVK3eDsWmkgat8I80Hm0by95BNOVdZUy8f4g0Zv5JVTW/uNzqQL46GBZkUT8VkABq/0NLX7k1GCWZeXU+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792365396; c=relaxed/simple;
	bh=qfsHfNYeopaC2KHOpQEeAGY94hrcVDHpDGsEIwd3lxU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ufPTj0W3MxNAeV3+s6hGwETUVABLruI4eCUoX0ujc5OSc9REKudV4GvPzEV0M0vo8A069i7DkipkRwfpP080he4NNPlSl6o6uym3s1gvxz/j6C2c11Sz0cAyeJ0OhE/71UvruFSb2SjBCkydN+ZYFwrjFByZoLDvWP5XWvkYSrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sPqTaiyG; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sPqTaiyG"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2e608cd460eso7748925ad.3
        for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 16:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792365393; x=1792970193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TX/6wyeHiY/2nSsVrn/GvE8vWNq9lTA3Z8+LlkuKRzg=;
        b=sPqTaiyGQUZngPgG8v3cTGSDnu0EEZ5PeGyZ/d6IgT8vTnH5hZI1M5bW7O72UwC5Qe
         x/PdV2lBlKYBlD/vGZ9UMdI3GiFPvkSrKtgnWmu0aVZo8q4wGuBdaDpc2tfxKIfFa911
         95ov16v+mWgbCMaT9wcaAAKSzr+OcEGP4lW6bvMW37s5y58eofmqSoK5tPPHfKGneYro
         brrPv8piXBwH7mhYQvceD5IS7EmihL1nYyhwBPvFaaIv+AcRfi/6aAnEkLbRFGul+NYt
         /fFUemqj1JPMBb5fEhit7Is+r4uhoVMfWZYTnOV+TchBOU23iBBqoDCekqU4pVBwTnms
         5CEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792365393; x=1792970193;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TX/6wyeHiY/2nSsVrn/GvE8vWNq9lTA3Z8+LlkuKRzg=;
        b=VHHwcldBBumkMfjvh8noJ59PF1lIfzOymDgdcX8I4467mx1u7ARmN8VWbambDGGNNP
         R7yXRvnXzE6RQp0++uqWE3n4DjyqDKrdowekqwMGUiz1O+mpJkXXwBdhkDzzQ9lTjyCR
         NbYPqQV3B6bgrozfcb8unv1WrAlyRJSweGLPo4Q3EQUVJhfR7A/uu7nYTCI9B/XwWccv
         Az0n2ridiXgdGtrzX1+J8+pJhIqyIgRy+ZtLRRNrNl3eHb9tqMiZB3mvGmTi/TSkGv4p
         xZwabKXJDm7XK0w8oUlFkWrNPjjwUy0WejMTSTjxK599QWNNtFtzKlIJe2G0sBITZHB5
         j5uQ==
X-Gm-Message-State: AFq9FYKp3JTLMYwybTVWPLRCT2uB0gfM6LFbY464XscjwP8vE0mCJWFJ
	aJfjmVE/aWUZFl0SblGOPaMCLjcR7wkwgJ/0cDr97BASaq6W8lGf5CBebcUnW6lE
X-Gm-Gg: AYBFou06ADUjqrRHwwVJnS2zxGoQ9qsgOGWW1J2NzPq/X/qiUIw38muNZDO5E7vEZas
	w84LlFATdk80VNiPCnU5TrHui2yT9NUlN545qjZq2pwIkCgI8S+Xh4MPN/lROZE2X3uilFeildu
	p0x1w7peq4RD44oxaB2R11+pdCsuFJcGC/OSDitHCOf4pEqKdYPwZrOBtQNcFsRmoqEN9aM4lz9
	L/lwVjCKhHQmK2AYnBesOBR3otMvHIt50uIrh57RcqLQTvoBcoGHHPRbN0LU34bUY5YVKo1qkTa
	qCtg9TD5cz4Zps3R643zt79stlWmcRrPTr13iyzdNKmCQ/nQ8RCUvIxbfL2c7aZ+uQ/S71FYjyj
	R55+rMlwltqEr0hkXG+ae2owS7yLkmXSAeDTBEAUG1DKKb+NCoxjrTGNt5nUHeUzy3SdLstnqu3
	oL+0fST3+q46Z35C68adiyyl/WWbqgc0aJsgpD5uOKpZtgXtzCV3XU2Y0BsS/NdEhYFBuNFK9sT
	Y4hY9bssrmv1lvnvGp1gxlHha0QcQIYGsVoTBVgtBiKT9OCcvs1zCNOByVhklh6QI1yPKQ47g6D
	RnCMZgdCfZujBaqZ5+VBmEVklB7XnVh7OTH+JeAwbE4xxp/F
X-Received: by 2002:a17:903:1450:b0:2dd:ad73:5b6d with SMTP id d9443c01a7336-2e9a6d2f037mr43829215ad.29.1792365393591;
        Sun, 18 Oct 2026 16:16:33 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e804e80sm32607215ad.23.2026.10.18.16.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 16:16:32 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Felix Fietkau <nbd@openwrt.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] net: bgmac: rate limit RX error messages
Date: Sun, 18 Oct 2026 16:16:29 -0700
Message-ID: <20261018231629.39734-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the RX ring is full the RX FIFO overflows. With RX overflow
continue enabled, the DMA engine then writes one frame with a bogus
length (always 0x45c2 on a BCM4716), which the driver drops with
"Found oversized packet at slot %d, DMA issue!".

Under sustained overload this happens on every NAPI poll. On an Asus
RT-N16 a 950 Mbit/s UDP stream to the router printed about 1450 such
lines in 20 seconds. The messages are printed from NAPI context, so
with a serial console the router spends most of its time printing.

The frames are already accounted in rx_length_errors and rx_errors.
Rate limit both RX error messages. With this change the same flood
printed 60 lines while rx_length_errors counted 14297 dropped frames.

Fixes: 6a6c708469c9 ("bgmac: add check for oversized packets")
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/broadcom/bgmac.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bgmac.c b/drivers/net/ethernet/broadcom/bgmac.c
index 1835266fdd09..b3a92ae95de3 100644
--- a/drivers/net/ethernet/broadcom/bgmac.c
+++ b/drivers/net/ethernet/broadcom/bgmac.c
@@ -447,16 +447,18 @@ static int bgmac_dma_rx_read(struct bgmac *bgmac, struct bgmac_dma_ring *ring,
 
 			/* Check for poison and drop or pass the packet */
 			if (len == 0xdead && flags == 0xbeef) {
-				netdev_err(bgmac->net_dev, "Found poisoned packet at slot %d, DMA issue!\n",
-					   ring->start);
+				if (net_ratelimit())
+					netdev_err(bgmac->net_dev, "Found poisoned packet at slot %d, DMA issue!\n",
+						   ring->start);
 				put_page(virt_to_head_page(buf));
 				bgmac->net_dev->stats.rx_errors++;
 				break;
 			}
 
 			if (len > BGMAC_RX_ALLOC_SIZE) {
-				netdev_err(bgmac->net_dev, "Found oversized packet at slot %d, DMA issue!\n",
-					   ring->start);
+				if (net_ratelimit())
+					netdev_err(bgmac->net_dev, "Found oversized packet at slot %d, DMA issue!\n",
+						   ring->start);
 				put_page(virt_to_head_page(buf));
 				bgmac->net_dev->stats.rx_length_errors++;
 				bgmac->net_dev->stats.rx_errors++;
-- 
2.56.0

