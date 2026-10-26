Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793008678;
	b=Mw2mOLZG3/Ybnk508qPDaozr1/WmxXviRk8r7VhBZ/CciErLaLIxLAcPaeMLwrDQ/4hQ
	 W9C9j9KpTP/Lme/OKCRyb56y6bFKesCo2hmCRb1jlSWqXptST+CtWBlnDcozSZpxJEp7t
	 RauGDYAz7rTqmDddVq0xWFjRrn/HN8Sv55/g4gFXwlH4IJZchjzSjuEFWymODnhYjv92Y
	 v8oxZX4rCDv/lGQZRnX0Yyk6aScYooBj1LU0ADz6FAK2pHWuzt0unY2s+GCPZQ32aEquH
	 fCj9kCb0D7x+TzLE7qcJbRqeQIiRwRPKFEOVAxDmcyVi3ZC9GbHAsblmbAShYCLkqNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793008678;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=LjTeBwZfLj61tdlg9QM+luzkf0OxdymEDqLC72F5nSQ=;
	b=a3rhYxD/jyQ252Ly106kXbAUB2wlbK+k8pK3RjC2D6C8tckD6NXMWE1JPfzaHoGJY5Kc
	 7AlxNaG7I1iaJt3gWrsBfTigxvgfT8NKPqxCLTOwcK47bgORZYVs7j/XV9Wnh/nXf4Ysf
	 HdmyfUmAgVGTI1JL6L+qVBkMJEPhIroUORoAbtDyees4X5StGEbYnXpvrVJDr/4e6i1qc
	 CxfRmlkZszaVDb7n99PACID9QVG6hcoWt4a5E9kyfEziPM7ntTAB7jXvu+1c9VcBFoiLH
	 ovCyBZQL5Kh9IjT1DU2cl18KQA8vdeUFStBTbwcqL2aV4pzBIQ/kcqFzt9tAsitxd6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Pakz9oUB;
	arc=none smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437BB606C202
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 09:57:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 437BB606C202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Pakz9oUB
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8a064dcfcfdso830548b3a.2
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 02:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793008678; x=1793613478; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LjTeBwZfLj61tdlg9QM+luzkf0OxdymEDqLC72F5nSQ=;
        b=Pakz9oUBgjqnaFkIykgG43IKOzWvt7NcUyAe/SfusIsphTwLS7PGkpWiGL+khoCFcB
         asQnS2PP1VrclFzFld8xZ8iuCXBT9upKcvbEBr/J+oxJ4OIjyIhBS4myjz+xKedE/2MA
         RXUFuk15v61MCOnFyLaNNbfQLieWSGuIa/bu4PRKlmy6M37mFx4pOm8AlV+VXUnxbc+4
         dXd6GidZQs8OwA62au21dg/LeY4KN5bTMMgpZ9HvjeiyD6BMChjpMlrKBBxXvhI8RxWP
         4ONeItzqvVHYgIJkH64MN+5NXjIo4Ycob5ruX4pPTDWG2xwUBSNx+ZYS2hZ9EXHUJLif
         mB+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793008678; x=1793613478;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LjTeBwZfLj61tdlg9QM+luzkf0OxdymEDqLC72F5nSQ=;
        b=ZbJVG3qWUAokXT5m6aBz+/RKl1FT2pY6zqBSdHXJb74Y4wKHVZiOEsX283ERM1s7XW
         dPub0uAhP70/0gicQwXLWMiTO4vJJLjkvXOo8JlooyxHpq+D5LaLllHGkirqN2mGuwR7
         8lGCNIkCW7LzbJCLcYoXNaFJ+gry5nPo3tAJwMDJuyPasT5xkR4ai8vcCXul1hpRkWO4
         k/iYx/QOW20TkeMC7YL2kCKlcVHxRhVE9Tnnm9+eyntxqEFDgeWkwkzxl87jcrAdSNIC
         Xhi24+c08J+GUJcoWjU1LTuF3on4H/fcYtlHZ/3BjC8PR8bbXRQLOBvHyZM3ufYey3tk
         L6hg==
X-Gm-Message-State: AFq9FYLvhRUdjVvJikVXJk9/g6f9D92fZ3gL7aI01aze81qrYVkl7ro3
	UuH2LWD647yGATxtXAHF21Gx2LCxKZgxV/reM+pTfuxeE3KD9YCS/G1T
X-Gm-Gg: AYBFou3Np5EkPJD2DNY7vDj56ed4d+Ey0kw+x6UjxeQkiZY9OUtCTUpD2GgBmT8g7Lh
	fw2mLzr+Em+ZFVkIf4AVMPxZNGu4/sA4j1y0TbUGfeya9sveEznpEHNphy2SL4noj0GunHti+Y+
	pD0VvCwEL8fukYROnackghYXx3i2v/JF68/TUOaAwNwerbXn8uystVEboe+y0IrtBB+IiG8WHf0
	HPLuhaznZ4Na+BXbUBM1aFkqozvtW6aXIdj3gPOpN0uUjTK0+Lhfz9R0QRHI2D6Kw3pHpn6E8Eg
	6+X7hd4EP/ZO4bzSQaYQOjl7UBJKbws2HF8bO5kvVSr8LT8MRaEX9ILuq0KXfj3Yr320yTMRmHA
	2Jb/QUGL75K3/iB9JJshmSwbAtSrhfhLPdE1wtXsTsoRG7BU9jv4pSi8SoGtjZb9zSKdIELA9md
	RRtl5to/eT0ZWd9HJqyUDc4ifTpSDAqpspmsb45Rm1oMdfv5bm0ErSg4Irc9vRk4MM8HTd9o62T
	zulIWs+SrCXE5Tjz8nKScxg1L0zxCmxK1hj5iLLfUICOiPdyc8i762MnpniqCaBUj3iTgHDHuls
	Yp2UK7E+Sw==
X-Received: by 2002:a05:6a20:9c16:b0:3e2:8fdc:a6cf with SMTP id adf61e73a8af0-3e7bfab8c31mr5045545637.30.1793008677695;
        Mon, 26 Oct 2026 02:57:57 -0700 (PDT)
Received: from [127.0.1.1] (59-127-145-64.hinet-ip.hinet.net. [59.127.145.64])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a36bf0f4dcsm1095577b3a.44.2026.10.26.02.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 02:57:57 -0700 (PDT)
From: Zhi-Jun You <hujy652@gmail.com>
Date: Mon, 26 Oct 2026 17:57:28 +0800
Subject: [PATCH net v6 1/4] net: ethernet: mtk_wed: skip ring reset in
 wdma_tx_ring_setup for WED v3
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-wedfix-v6-1-a52f6b15d2fc@gmail.com>
References: <20261026-wedfix-v6-0-a52f6b15d2fc@gmail.com>
In-Reply-To: <20261026-wedfix-v6-0-a52f6b15d2fc@gmail.com>
To: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sujuan Chen <sujuan.chen@mediatek.com>, Rex Lu <rex.lu@mediatek.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Sashiko <sashiko-bot@kernel.org>, Zhi-Jun You <hujy652@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793008668; l=1333;
 i=hujy652@gmail.com; s=20261026; h=from:subject:message-id;
 bh=8HcC/sQ6Padav5RauewUundESxCJLuNyI/jOB6FPbeM=;
 b=R5SprU2ynkzohGH0ikExaLYx4+eF5xyVGdW5pS1EiVbSfrSOVQZkSRDrh4OMF2weeFfeqLWGL
 ZcrEU0rxM1SCaaLklufzqHafB/m9GBLE0QH7+amfullCkw11RjQdxO6
X-Developer-Key: i=hujy652@gmail.com; a=ed25519;
 pk=uXjqvnRsKEfHEyUr63sOg4fEJIDs4AmiW/rB1cWarXg=

Currently WED v3 tx wdma ring, ring reset happens in a separate code
block unconditionally.

Moreover, v3 has double the size of wdma_desc and has different init
values. mtk_wed_ring_reset doens't deal with that and would corrupt the
wdma_desc.

Fix this by skipping mtk_wed_ring_reset in mtk_wdma_tx_ring_setup for
WED v3.

Fixes: e2f64db13aa1 ("net: ethernet: mtk_wed: introduce WED support for MT7988")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260711112128.971-1-hujy652@gmail.com?part=1
Signed-off-by: Zhi-Jun You <hujy652@gmail.com>
---
 drivers/net/ethernet/mediatek/mtk_wed.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_wed.c b/drivers/net/ethernet/mediatek/mtk_wed.c
index 53d3b7e00e1c..d55042ccaff1 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed.c
+++ b/drivers/net/ethernet/mediatek/mtk_wed.c
@@ -1938,7 +1938,7 @@ mtk_wed_wdma_tx_ring_setup(struct mtk_wed_device *dev, int idx, int size,
 	wdma_w32(dev, MTK_WDMA_RING_TX(idx) + MTK_WED_RING_OFS_CPU_IDX, 0);
 	wdma_w32(dev, MTK_WDMA_RING_TX(idx) + MTK_WED_RING_OFS_DMA_IDX, 0);
 
-	if (reset)
+	if (!mtk_wed_is_v3_or_greater(dev->hw) && reset)
 		mtk_wed_ring_reset(wdma, MTK_WED_WDMA_RING_SIZE, true);
 
 	if (!idx)  {

-- 
2.55.0

