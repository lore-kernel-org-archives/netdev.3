Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793008683;
	b=GexIVU9GPNCec9/tX9qDZrDgrWQIU1iIkNK/CohDwJiK97Q6FRhPZHNP+xArLvygt9BR
	 dVcQaSCgZvZGF0TNWOxXhj5xkesMZ+GoRwXLHEauf9KZEOOx07qUZT5QKTuCOweDL5q/z
	 UYxvJyS80Nd4Dk0KGeXcBq+qOwbBU+s7TjBZNqVtaU1fp82URI9QY4xmC6XpQAYgwgcsd
	 cYjdThT8hNb52ZIYcfN2fAaaoa91rqtiK2EY2Z5AxWpg4dWwwZ4ugmcgZXN8Wqx/8cDxp
	 YyKqwxogE0AS9iIdJ66ZwDvDhre/cR4fb+8gePBMtooNguftskuiExAMM6diN8ByDRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793008683;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=ZkrjTGKpjcuZ/tYx9QE/Yhm7rGoild+k5lq+5pxzVsM=;
	b=rdKloht/pOEMQ/+/wL968eiVMuOtWb1mbEnzjZd9LIFoB242IMmWvlaWGXv9g9mpEwcI
	 c+ky2okTzVa9/dqQWLX5+PuEhlhgNDlsZg/zOjcs3PtHSzdm1+PSo+geB5fD97bHZbcz5
	 wKb1Kg3JZnwB5Fwd5YBQs/6Zg4EnvAGIAqGTXvPtkktFjmjKzwlQpec91SPM3uupebj8m
	 p6MHZLInhM5jkgtB0uyLPguyz6hN5Rhs2eCfuaVui8qkvXTTGyFwGgavf+681VZ6eEyCS
	 rpy2wh7aT+82lY1uQyfHzI7BtRIkWjYhY0fOEQnHciHSNcpMyXFq2Zb3uR1khu5n3tQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=A6kLDphG;
	arc=none smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E9C606C23D
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 09:58:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1E9C606C23D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=A6kLDphG
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8a06b44bd01so1497301b3a.0
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 02:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793008682; x=1793613482; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZkrjTGKpjcuZ/tYx9QE/Yhm7rGoild+k5lq+5pxzVsM=;
        b=A6kLDphGCGeqVBVIeolzEZd6o3SSCK1ZkOFxV27r03qo8RtyvT4ZnCpajo9MMtrsaq
         SoHCYtJYk9j4zhW4f66GSang1cUaCaUdcuc0vzqeZkGoyvWWyz3KeXWozD3or94/BWgF
         w2LTxmcmIpr5dyrE7rRw7bMnU+duIlwOXfto3FQiRLANBRa8m6DdRvOC4vKWA2fz2Bs6
         XK8Pih/q565zVV56EB5wEls165pNOkwkoEggmMpfwpXwI9J5it0lm4OiYBC93vSY1iwJ
         5Lo89sr1Zgp27+ClVP9t47y/uMOII3u5ZcwBSVUELfE9UiS3C2BN6xyTVDlGZ7/dahZ0
         wIHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793008682; x=1793613482;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZkrjTGKpjcuZ/tYx9QE/Yhm7rGoild+k5lq+5pxzVsM=;
        b=TwN85B0gpi0Iyz30oLtLTaCqvQUQHlRuqClvT6dKAKOBJYSJ6VlkkeUiQbI5VUw0ch
         Q0OdejVCvK47+A0oUbfacWNDwdfc8n7Zt7TOt6O79Bmg1+MkvhPGGR6Mym5nPN0vh63h
         ScTEIbgF/LBEUYJltTOrCv53jP9ooYlVtLo4ueBI/0DXPASeqjINBaWhlLlh7WV+ewcN
         xd9E4iErv4zhJqWETxW/NCmc/sge9z0LqRSiTicGo88HWuOHUyWwnQEcgm6OAX+/wkDY
         HXJU06DlON9eSXK+GlBqbJwCNb+BhewGeNry/CUuxQbvMt1iM7woxLhjCqyuIcXbyvmg
         v2rw==
X-Gm-Message-State: AFq9FYLhn1QIxtq4dLfLyegAS9/GU/sacb279BmNOe2CAfOmvbQxu2NS
	V6vd8foV/q4T6hFFR+I8Zu3Ox33F9nCdEMQ+0u8BLnW0JGGVaMaVn/vVMa9tw1TS
X-Gm-Gg: AYBFou0kZpLpydbOaA81kJp6wSiae3SnPMg5WTQhCKczO2FwJznT3Edb2MNBSLpm8FW
	+H34O97i+CokAEe4w7gYbHjA22jIdqTnZE0FQNip87Qoe6RHDiI409SYlP+MDeHAC+pup9Ou99a
	070jJQrnsDY4UKN3j5mZ99pX6IifKepaRDJyM+dEQdS6GY8y8F+gc21GhHRTnVEjpe6YASdmVtc
	P8pEp48lHsj/jq/kRhapUEwhJPU2qI+wcvQE5LkMHspJYA2VwJK10ZH+3m99eFridREBaDXeMu4
	YaRLkCC0yKAbGQTWVJGJCkN8BJ1JYDxYOaCM4Lmy3vMWjGSjmW5txED13fmoA2J+T8QvppVLOzf
	6NazA/Y4mr+Qnr8LDpbZ3eEcWsYXJWVpTeViKOab53Qjj2DvoAvgr9FXNOP7Ify+hmJkIu9Ih+a
	/hTLl9cD2kgcxspN7PG7gBmJCo+5l9BOn5uaygqkVnXZv0dE8mXfLnI3/QtmU0hQt6IfopTBKxr
	90l4r/XcPMOKDOnsn5pkrVYtUGQ9lqrP558N2wrzL/Mht3Qcwmu1tmoYDTjbjqRRJQnKyRy5EGc
	VCVLu/kp0w==
X-Received: by 2002:a05:6a00:9093:b0:878:3783:8a88 with SMTP id d2e1a72fcca58-8a3689a9e0amr5082831b3a.52.1793008682324;
        Mon, 26 Oct 2026 02:58:02 -0700 (PDT)
Received: from [127.0.1.1] (59-127-145-64.hinet-ip.hinet.net. [59.127.145.64])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a36bf0f4dcsm1095577b3a.44.2026.10.26.02.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 02:58:02 -0700 (PDT)
From: Zhi-Jun You <hujy652@gmail.com>
Date: Mon, 26 Oct 2026 17:57:29 +0800
Subject: [PATCH net v6 2/4] net: ethernet: mtk_wed: fix reset condition for
 rx wdma
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
Message-Id: <20261026-wedfix-v6-2-a52f6b15d2fc@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793008668; l=1247;
 i=hujy652@gmail.com; s=20261026; h=from:subject:message-id;
 bh=KHuNb2dXEaBZgB0w45LgKUexXhH4JlXqWzUxUbg3sfY=;
 b=ZGYVb454jS3iS7dka2Wxnt/z9ajD8qAN2Wb5iUIt2lWi9KINhIlEdsUJT8NTJapNe+/51Z8Oq
 /hngfvKzvT+AkkuPLM0fGdef/c2DGWGBEQtdQ/RmPTv9fVm7MLdmsdb
X-Developer-Key: i=hujy652@gmail.com; a=ed25519;
 pk=uXjqvnRsKEfHEyUr63sOg4fEJIDs4AmiW/rB1cWarXg=

In mtk_wdma_rx_reset, currently only resets the CPU index of the rings
that doesn't have a descriptor. This is wrong because no descriptor
means the ring is not configured.

Also mtk_wed_start makes sure that all rx_wdma rings are set up this
would lead to no ring getting their CPU index reset.

Fix this by inverting the reset condition so allocated rings will be
reset.

Fixes: 4c5de09eb0d0 ("net: ethernet: mtk_wed: add configure wed wo support")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260724172040.1653-1-hujy652%40gmail.com
Signed-off-by: Zhi-Jun You <hujy652@gmail.com>
---
 drivers/net/ethernet/mediatek/mtk_wed.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_wed.c b/drivers/net/ethernet/mediatek/mtk_wed.c
index d55042ccaff1..3f0be70c3f14 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed.c
+++ b/drivers/net/ethernet/mediatek/mtk_wed.c
@@ -257,7 +257,7 @@ mtk_wdma_rx_reset(struct mtk_wed_device *dev)
 	wdma_w32(dev, MTK_WDMA_RESET_IDX, 0);
 
 	for (i = 0; i < ARRAY_SIZE(dev->rx_wdma); i++) {
-		if (dev->rx_wdma[i].desc)
+		if (!dev->rx_wdma[i].desc)
 			continue;
 
 		wdma_w32(dev,

-- 
2.55.0

