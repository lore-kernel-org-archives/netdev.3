Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E953D9532
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 05:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789535794; cv=none; b=rX+P5dUL7HvvpJZ+tqzZfijiS1cPdHIOwVBaSp8vdijvx6G6dOGpoWtB5qFEK+yFEYV0Py4rMh4wcYMPxTNTKPFNrJxZO85hZ2aOYAEetmI0csKewHGcd94uxE0osm3SeMiYky/uAeYFnHwz8S3tvkJYE5n4UMk4CWCpykTL8CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789535794; c=relaxed/simple;
	bh=uwmZUWNFubCxa2vYuasTSUVwkwVzc+oCbHAoSLSNBaY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OnGC4GrnmB7238jQ/KBHDToTceNRbwE+EjT5k8iMZF0OVkLQrMuArFffSOP0vWQcZiUQ9g75XWnd/0pd+mln58//VGCgO+E3oTI4nt4ksuZ1qactchF1tCzItE++npLnkP9Me+dFskvA+gpQs4FerRmiJClWUwhB39dnCaO0yTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQHWVY/A; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQHWVY/A"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39b910bdf2eso317743a91.2
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 22:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789535789; x=1790140589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WVOHsi5wK8IUeKTXKaFBxVem+p3DhnYKQL8R4DBSpiI=;
        b=aQHWVY/ACJkqGvCQKrgzOSX/ich3frOvdLYx4A87x/LjEbpc2KlCkZ/qN5+u+I8mlI
         RoHDwxFu/xVIRxILPnctlFD4hpawi3Z7K0TLPk06w9oU89xNA5zOqPoQ7WFXqOUaH9VK
         /JQGH60jgVXujug0Sk/Xo5on/scCn9nlCbuOrI0spSfUNrw1SLa99OJwRrMBdQ2u+19r
         zNBy++L868jJobrNvE5R2/YVq6UNSoV5Dd9EPfA207n/Qm+n4U2NMAn278WB6HQN6ctX
         McWsvtQYRI4aBKghcvjtW7H5SBLd/1pzNaqfkq/KXOHk2tVdcHLShGzBVfiHf6kz0Z8r
         l1yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789535789; x=1790140589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WVOHsi5wK8IUeKTXKaFBxVem+p3DhnYKQL8R4DBSpiI=;
        b=jfBQrkNqtRxPifH/1iWS7wkjEFZJSkeNG5J34merEmgkQHeJdofufOSYEjRFkYdjm6
         DWCT5f2zx8zZh4xuaSFXJuXl6Vi4WL0l129PPLHCeciUjhN4VQpibT7seBtRoIr+NbUL
         W8H1B6vQFmAXyhYuP94DshYsgsE3nr317AeWVJ0qIXIOlgzFi6agrSEzACpnPdkNbP5k
         ENsQemJf3E9mikHkXsHFkhlOBq+cKZMK6b8hlsOaUDYNNPKFtAHiatC0wx0xIB35INKT
         B+tIatL+kw8NmaBQMoYAxDlltyHWjad/afP6nRP8vQeJelbCVIXZ8etTsFEoen5HhL3d
         HvIw==
X-Forwarded-Encrypted: i=1; AKwUvBwj/O/MrC9xkrce0klTxfkknFDhbiGgrTK0egOeuZ7rJG1aL0j+1a/YlpR87py0UzZuHidQDu0=@vger.kernel.org
X-Gm-Message-State: AFuF++nVKlaOwn19PzHuSTinKY+DFj6+BoycNXKfQhopgA/C88Nc5l9D
	YkPZfmGn+tPy17Us1q6UK/NniuMoqsieWHD9o/Cz8vCEOLYE7qEEFdMB
X-Gm-Gg: AYBFou3gIN8CQ2zXdrbUzw8L8lSHKHC0LfWad7XpDsXcZkeWrMgKAQd8A+ysVjYt+0K
	szGY1zActFoRZaqDIXGDCZOMnt0utCIts/mnzXiRLb3jVDX3arJdV5E9kDnM8d1AixPtvXbfT/u
	bhjGR1FXuv2JIDVcgnfJw10ix3s7ifQaqEw+rAGev16UZoEOZOllG8FmjI4SRH1f/W1OwPpy9bH
	R8Pl9CE3iwuci0N9NNVXwyef+PyCjNhgobBt8XerkhOq90jDIAAf8n0jreziEe73m3i58kiYvjm
	gE+iQMjBvKIlM1UjyYtxJZAkUn2UJucCETZPrh5l5hcfIacsz2AJ88IAsjEfp5ob6H6VQ/ohDPX
	uNAUvFMskJ+ch1H3k8IPTnCqjEJ68juf8u67YUlWKyVz3oxsXFAEu+i+e8AuJimWbdHghUR1C9p
	mHLoEULVNHHjUbHtnf4Kk94jElFCXwwZYprjPhNGpbkac7enLPI9MK4uZKPnZt/t6c+UhE
X-Received: by 2002:a17:90b:2645:b0:398:9be9:ab92 with SMTP id 98e67ed59e1d1-39e1e5777famr3113557a91.23.1789535788375;
        Tue, 15 Sep 2026 22:16:28 -0700 (PDT)
Received: from lgs.. ([101.76.249.46])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1bb22ee5sm2428218a91.5.2026.09.15.22.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 22:16:27 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] net: mediatek: fix PPE resource leak on remove
Date: Wed, 16 Sep 2026 13:16:18 +0800
Message-ID: <20260916051618.2904439-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mtk_ppe_init() initializes the l2_flows rhashtable for each PPE
instance.

The probe failure path releases these resources with
mtk_ppe_deinit(). However, after a successful probe, mtk_remove()
tears down the network devices without calling mtk_ppe_deinit(),
leaving the PPE rhashtable resources allocated.

Call mtk_ppe_deinit() during device removal before freeing the network
devices.

This issue was found by manual code inspection.

Fixes: 33fc42de3327 ("net: ethernet: mtk_eth_soc: support creating mac address based offload entries")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index be3bd025c41a..04d0a1eec4cf 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -5394,6 +5394,7 @@ static void mtk_remove(struct platform_device *pdev)
 
 	netif_napi_del(&eth->tx_napi);
 	netif_napi_del(&eth->rx_napi);
+	mtk_ppe_deinit(eth);
 	mtk_cleanup(eth);
 	free_netdev(eth->dummy_dev);
 	mtk_mdio_cleanup(eth);
-- 
2.43.0

