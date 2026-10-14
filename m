Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F0A41E6A7
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 06:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791959244; cv=none; b=VbtLrWO4oNGUhTjtMRj0vP3Lfecy//XHTT59Tjx4wGBCe0SoWNAkCuQPl97SswshH6dFL9ddNQ44aGnbVUa409mk/jkPlVtKVUBE5qcvNBfyQZJvvoYNxKJsfEmivVSyjOPT1hn4JUZB58axhmv/BQMwb08lXfRI9fPD4pp5AB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791959244; c=relaxed/simple;
	bh=n2wwRH1MGpcbmaNe00q3C0ieRztlK3ueHbSjCEF1Lhg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EKKnGg1/c7FtSsqR/x9nOR+2KiflltU3JoasIGgcZ9NNRHWLC+2d+RX/F/enlC/ICKTDG7kbZP/N6NAtQzD+ZAp4KiHQzJf7ALHGsnR4pc3q3wZ1imidEctq3z7GYpNrVhwfndatysygiNghi2U4WtfP+pRq+lpXhHKH1fZ7JzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePLhKkex; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePLhKkex"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a172eb31f0so30113645e9.1
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 23:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791959241; x=1792564041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2Hzaer1RZQoriyuUgW8AMXxGnkkWZrxnciM8HyXU7+w=;
        b=ePLhKkex5mhKAoJuu3xiKelTjVj9j6WqMk18jH/tS2IGFEnDKS05aM93w4r7UNis8y
         y89ytrtv1bsL3jL/Xu2GBV/zHZ0fX3fahhgzLDhZsQomZAfGIp7D/glcd6IFUEOBIeSZ
         gyQTbXo+86BckEmRhulOZLRStga2cNgJ1UJgF54kTpWra2X/Ma3OjtZQiiaQdBZEfBvL
         4xHYs5OpU1g/iLuzjZv/f+stn4eP3d1cbsDxv40mcoIzLhqSumHXrDoixZKJRoSaaCQt
         zkY1HNtluJUOOVOQ4dkalR67hFmTcl1Hop3z69v7aC5utDlC3xeXuvdDftxadv/8kyMZ
         lpzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791959241; x=1792564041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2Hzaer1RZQoriyuUgW8AMXxGnkkWZrxnciM8HyXU7+w=;
        b=AGVPMs+YBateXE0qx8piLKlVlV82Jq9u2e6Sdz46qDqsBVHv68AjyKq6p6HLEzdQCA
         IYL+PabBQNtrVlm+XrtkmBA3CoLZKNBssa1woLfLMr7Dh90Y3vYQbcghBCAP13imCRD9
         FCRwZ8eb6/Rl2S1gSWjAQSDSLU1aW2d4aYAw1kX/odyT3Ibl8xWjXLH53/qrXtlLRqEy
         +jYl23Ofv/j0/aGejYvzO2FeiJNQTXmMRiEap/aBNFGIZaWQ9N2cCQ4WdQc9EE/G9j8S
         VcapXa/zWmcMNbr+o+7pCfcxhM2GhLH+n6mAkltJK3L0rWJbqIMGudwN3HWSmW1REVNg
         JjPg==
X-Forwarded-Encrypted: i=1; AKwUvBzBsFlUFEveyRhk6VWwiYz1O96Av6x6z3sqfJOKr/FVX9X2jxes94lZZexYMSvFaOZvpcLBFV8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKTN9ah+GJeFR9sK3gtozBy7bQ5Dukam+2eEJlyuSDv3fF3wmBV
	r81MJG9EiqVGtSprSXw+Q3REAJynW/5qaTkkkuCQuEMMCFLlCMgdUDs5
X-Gm-Gg: AYBFou1KDIuNGmxD8JJVj7hyKrXt9ieVgUT3jpJ6TyuDIa264q6N4UBAhk039jNeRE2
	qzH/D6hMs8SP3IEnLtvmfazirVc4WPdj/vGY6tZ9H+pBD8WR3s/XrOzm4kfol44t5tmPl0WX4TF
	ovK7rPEnDhiujMFLdGtz+CLKJHw+gedGd56ohE83s9d8Z/iFTsZduoRAnYDAZI6yzmiNpu8B/a2
	t9W40VQgJNwI71B3QNkIGfcN/1FCjZDOGAwZ6nH1RsBXkEqXeKjD4Z8JBWtdcxfIdw7K6gzJyv1
	zm2CnB/CuNaP2WxS72WJSc536WKG284A9TIGx1vnY/xDadMxI7Fwc8EVz0MkAoZh02i7IN7uuTK
	18uVcxr+zO+BV0S+Xb0XCx15H/Ip1dzSuqT1zFyLzNqfaLvTYcMXNLVmwodzKQj6YeYBwDMnewR
	gIkhy2Bi4GOMBYRWLfy16R5HdieDBhn9wzLT/tMBpH4ijdt6yP6S+vpBKeUFYFSvj5t/VT4s3zI
	Hh9d1Hm+uXBUUpQVyPOsvO3HKXYr6r5cp/rzL1MQUjb1LSg+5exllofG4JGn5CTnVBreByHJQL9
	6Ks/mEoL0zYR48+uC/Vd4lDv2bhPxch9s/760xfOSFWza61vyVC2u8Vm8reTuauwT8Py/4qP+eM
	X3XBe0jw8+Est
X-Received: by 2002:a05:600c:4e8a:b0:4a1:78dd:dd28 with SMTP id 5b1f17b1804b1-4a18e4d2b31mr294041485e9.27.1791959240912;
        Tue, 13 Oct 2026 23:27:20 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-aed1-da01-ddff-863b-8308-ab16.310.pool.telefonica.de. [2a02:3100:aed1:da01:ddff:863b:8308:ab16])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18be8c5e7sm528846745e9.4.2026.10.13.23.27.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 13 Oct 2026 23:27:20 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	netdev@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Joao Pinto <Joao.Pinto@synopsys.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Ong Boon Leong <boon.leong.ong@intel.com>,
	bpf@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 3/3] net: stmmac: stop DMA when IRQ registration fails
Date: Wed, 14 Oct 2026 08:27:01 +0200
Message-Id: <2b70886410b5e9207ef170a48aca1d2d7ce24a68.1791958735.git.kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <cover.1791958735.git.kmehltretter@gmail.com>
References: <cover.1791958735.git.kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both __stmmac_open() and stmmac_xdp_open() start DMA before requesting
IRQs. If IRQ registration fails, their error paths release descriptors
and packet buffers while the DMA channels remain active.

Stop all DMA channels before releasing those resources, matching the
normal close paths.

Found by inspection. On a BeagleV Ahead (TH1520), fault injection in
both normal-open and native-XDP-open paths reached IRQ unwind with DMA
active on the baseline kernel. With this change, the DMA process states
were idle before unwind and resource cleanup in both paths.

Fixes: 523f11b5d4fd ("net: stmmac: move hardware setup for stmmac_open to new function")
Fixes: ac746c8520d9 ("net: stmmac: enhance XDP ZC driver level switching performance")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 8fd7d2173..5c4df26a6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4206,6 +4206,7 @@ irq_error:
 	for (chan = 0; chan < priv->plat->tx_queues_to_use; chan++)
 		hrtimer_cancel(&priv->dma_conf.tx_queue[chan].txtimer);
 
+	stmmac_stop_all_dma(priv);
 	stmmac_release_ptp(priv);
 init_error:
 	return ret;
@@ -7259,6 +7260,7 @@ int stmmac_xdp_open(struct net_device *dev)
 irq_error:
 	for (chan = 0; chan < priv->plat->tx_queues_to_use; chan++)
 		hrtimer_cancel(&priv->dma_conf.tx_queue[chan].txtimer);
+	stmmac_stop_all_dma(priv);
 
 init_error:
 	free_dma_desc_resources(priv, &priv->dma_conf);
-- 
2.39.5 (Apple Git-154)

