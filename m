Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794614340;
	b=N1Yc7yI4qYs+04YHU7GNQhDn6Iwq/NbUWqxilH/7pSwd8GEiZzcd4JgEF8VFtRQuEIPB
	 2O5voy8X67HtmvNXxnHmgDYPA3ieyd6mFAEmzhien3iWyVuGIhTfwc5Ty/mZ568ek8YP1
	 PLnHxzsRZT57S0CLiAZkf2xf4BxECWjJDPqva7iEIaeR4RhiNi574DWcCn8tS9v06j6JP
	 c3keDN0hH5yJUQBgY324JNR5dPoIaNq35r0j66+jhCrIxuty8vxyPmt/n3XvbwDl/mEuU
	 IJ1I8+BojZ+So+wrjkhXAlBRYAHvTCxW9/p9F0QBKJP3aiOLKzTkMD++xLxhZql8jjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794614340;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sMuQKEZDwnWs5urXuvvCzDhCsA56ApL3CGERxb7vyLk=;
	b=lpTcjo/KQfhRXGcdB44X/4k5tqaIcj8Mj5bY5YfcQrc9yTYMs4OncKvDMbyRcTIWBzDP
	 Pet8TOD8S105SyBg/GqySuw4Tdeoom9j66sSR+h6Dkz95dI22hJFoJJzxHgfgpl18NSnl
	 1AF0j+wI/iGlC4dLIIsfThds3hNJlIMtrIM7ZDdQuNXYRxYQJStlLJHeEtvxTk1ftAwL6
	 pzLOZGGn9kS+LtU37znZmC9tkwYMY/C6iqLME77GcacN+CYIUXTp40oTVPo7rS/bznVX3
	 wDspBJ8osk5sifFJfTaV9si4P+36qDtqo35cBr0GEHDKm3vgywq/v79CwyzboqGkhUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ybcl+s6v;
	arc=none smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CCC60A2600
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 23:58:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0CCC60A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ybcl+s6v
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c4d473cfff6so250721866b.0
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 15:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794614338; x=1795219138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sMuQKEZDwnWs5urXuvvCzDhCsA56ApL3CGERxb7vyLk=;
        b=Ybcl+s6vBjYYMzHdLbpW3UKmPNe3oAXgoERAutIM16jTKQ01ZjwL7lHjaV7HTmIrNG
         Us7K6BJmJ6NtDLr+5GUHffgsOHQefRsiAAtAIcm0o6BIhwA8q4nVs/0nlvfaWG7im/dp
         0tLSeBf6/SPNac6bHWYSJ++mGjbkE+q6UvN5qPHg5KHJyDtT/OrUR+5g2KJmveaCopTW
         0AJ+Kt1l+WnhnaxZexe3HFwa/lFbd+nb54W6kvh1jky3w5KKs/PutDiqR7gdqRZp4CYL
         gf8BjqUyyrTKDsqD3305NT90edpu/5t6I+Hlkklx4IY3kZy+oGQnNi/kSUvnpaH9RRkr
         vlnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794614338; x=1795219138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sMuQKEZDwnWs5urXuvvCzDhCsA56ApL3CGERxb7vyLk=;
        b=NOa6HvAnKKo6KSnvFHfIHrpbTMCWz1060We2cOxDSSmmViyrxYP2PTL+1df6pSL4xr
         PkLdg/2PKt12xmwhBgb+pe6YRS+QEaVDJWjDCYod+SyJmLZUFWn4qgzO1CKfpX6FmaXr
         iHdU10/W/pzZ8f7e0eoHfIXYdGaHxqNDxX2vvs0TswRAE5rbn9OSDUY1qJlU4I3x+YXR
         ctaFgHnluGVlGTJ29gsGApvfnn+K/khV8LNpuGaffmI+g5ArgpesWPuQw4WITufKGvsT
         /k7ohrdIlpE7gO7u2bKdFSW7lQPF/xqL1SQwfw8UyQtNCGjkf1mEujIJVKrUVHGH1cdv
         W5JQ==
X-Gm-Message-State: APuU4Z/a1e2BM65poCEqUGMrWt9MDyFOebdjvYFWVCJ+EAdeh2yeF0V5
	8F2TbI1n0LlNiVXTXPLrZtSFN1quGF5f/9w4QOlX7EYmqS649Pu6FZd4xDMr+gzz
X-Gm-Gg: AYBFou2j5Jn7TsXlyOEFdFDnM672o2PdOlTLB1EXgUSVJJJ7RHdRXMKHrPchHpV5+7/
	zVWYphmgyC3wTB3wEKhWZ9P5V7acrlxyhtGBhH9s2DaGWTIOvSBgGcqnD4cFvaoaDV8a+/YEMaY
	BCRV/uRwA1Ui7yIzTWFCmc/s2kxSEM4RHzc5x9emE31BGx5SFXG49L/1t1046p2Ijnkg79wAeB1
	onyEjy9O+7ejE7E9Em3Y270hXZjv6cW9BfnsBKx+9owy1NPZlahzeD7rbb/27PvEUMl5uLIbpmi
	w4jNXfKkrF2D1o+3SrLM14PtQIal8rxsruKlGGl4ouUDdb3FyOxY3AgCR60HGS1+O6BpE4x4hjv
	Zar/66Ll86N5B3MmIyj5uzDF8KdjXTDwnCDPl+bwA0HhMNpyebsn9IZhgM1re3UJNhBSDF80TqB
	UEXig0w2qZj0viQEAx1jbME6VtTtMyeUUj8gq684ySJlSoj34Ecibbn/L5FFw7GEbdRHkqwseu8
	Atx7NPNUmZnQXeul+0ikdxgKQ3MeNrB+CtpnnGpnhCg5hnqQR8dGDNM30t1jZk/8aIFtoZycKhS
	xby9k5VooGotRbZzC+b31N2CQSNwnUbP8zBEDgYByvk9z8i3v4c+OZ/LbSYUhJM=
X-Received: by 2002:a17:907:d40a:b0:c2b:f3d5:2090 with SMTP id a640c23a62f3a-c509637e0b2mr347738666b.27.1794614338294;
        Fri, 13 Nov 2026 15:58:58 -0800 (PST)
Received: from kordpc.lan ([2a13:e746:396c:c600::8f9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b3dbaesm153454266b.32.2026.11.13.15.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 15:58:57 -0800 (PST)
From: Kordian Chmielewski <kudzo51@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	bcm-kernel-feedback-list@broadcom.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3 4/7] net: bcm4908_enet: unmap the buffer of a dropped RX frame
Date: Sat, 14 Nov 2026 00:58:44 +0100
Message-ID: <20261113235847.517308-5-kudzo51@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261113235847.517308-1-kudzo51@gmail.com>
References: <20261113235847.517308-1-kudzo51@gmail.com>
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

When poll_rx() drops a frame (too short, or not in a single buffer),
it frees the buffer without unmapping it first, so the memory goes
back to the page allocator while still mapped for the device. Unmap it
as the path for good frames does.

Found by reading the code.

Fixes: 4dc7f09b8bec ("net: broadcom: bcm4908_enet: fix RX path possible mem leak")
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Kordian Chmielewski <kudzo51@gmail.com>
---
 drivers/net/ethernet/broadcom/bcm4908_enet.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bcm4908_enet.c b/drivers/net/ethernet/broadcom/bcm4908_enet.c
index bb42b6ecd..03de65d9b 100644
--- a/drivers/net/ethernet/broadcom/bcm4908_enet.c
+++ b/drivers/net/ethernet/broadcom/bcm4908_enet.c
@@ -661,6 +661,8 @@ static int bcm4908_enet_poll_rx(struct napi_struct *napi, int weight)
 
 		if (len < ETH_ZLEN ||
 		    (ctl & (DMA_CTL_STATUS_SOP | DMA_CTL_STATUS_EOP)) != (DMA_CTL_STATUS_SOP | DMA_CTL_STATUS_EOP)) {
+			dma_unmap_single(dev, slot.dma_addr,
+					 ENET_RX_BUF_DMA_SIZE, DMA_FROM_DEVICE);
 			skb_free_frag(slot.buf);
 			enet->netdev->stats.rx_dropped++;
 			break;
-- 
2.56.1

