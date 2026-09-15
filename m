Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35C438B149
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 01:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789436397; cv=none; b=qPTaV86tkXCyZuTR3f1kXr1C9LG+tAs2vLQrnpKDKxUoNzzCd4VGJOQ55W1+fKp2zB9aL8o/G5XTMWOKQ+YcgWzCAgBa8p6oT0qwLiKXGn746ZLbnx4O5nat4Y5EzUoYEX/pQ0xa3SyX1nB7PZF+OwSeNdR6MT8TuU23ZMICbiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789436397; c=relaxed/simple;
	bh=vGrgc1V20xnDibYfrrIi8qa8Tu+oEf6Obx12JO0LlVU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W0qk1F8anBX/f7vKwGtXp+yfhW9d9ejI0cW6SQ1wsSLAGp506hBVemm6+NsMsrPSpTLSFi2DKlcvx03NRLpXXlmYlyVSx5q/swIVAU3M9xTmJAyJKzRVANeilm2L4QxmB9SvYNT/0zacO7KynbhZtZx7DzQRjV/UuVVktjqvWHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GyXVWEfx; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GyXVWEfx"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfc6db0aso34692706d6.1
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 18:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789436394; x=1790041194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jA+Gm6Df8SoCPT+Ci3PSWeT1OW/hMiB/+pCm2kOG6rI=;
        b=GyXVWEfxGeMIjpnW8qmJqUBFDClvDvAfFzU3K8/20Slisk6gxgQvKs9pz1kBaTbgOB
         h0+lrzEEsnj+0f9iDPbWpzg01bXM6lEWri/BniCw4HJ3vLxkZWaGWeiiQcXYzhwMfgpt
         d+LscJgiYGI96GfonpJqaoIWqonV11lF5hbNli2R6/s58IFdWKbtEadCChXCZtvgBOEr
         UzaBeBMUkmnqImMeAtrvH7eyj4F7nfm0Y4cpyeUhLbHAVnGV9gz8qD3/3ilVXg6OWBSC
         7ChOPBKXG5AXNpfcpHiIwY7+Y4Qwll8Ospp2zzj5fM6hfxdehSejhaNLtBIVdEvvwnBM
         XzRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789436394; x=1790041194;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jA+Gm6Df8SoCPT+Ci3PSWeT1OW/hMiB/+pCm2kOG6rI=;
        b=uqhucQEwGNRFYI8KFFBLCJgA37/KhntQx1iyGjIqDlb3SNKUQ212NOLhY8gb9TBHl7
         O/dJ5EMXTYfEKxiIUlEdDOLxarjJHeF9xgDqZfHrFWZAOjaQXepc+cMGl87JoWWDyLpV
         EKEPafhB1pEXMGCn8OkKIJQhxAkyH1Npn+Ar0apDCorTTnJ1oVLNtHMqrqyz+zoFvmQB
         +5gEolqjGQHtBjRxDw8ZZwZ8ynH6A1vE//kiNYzX7G/JfKS7rU7StP3YfrnueLSv6KEA
         Bo6hkWAQIGoaPAC5Ev5rIPIWKogu2f6mY0oq3psGp7T+FDfJckN16u33KDB0wyFfZ2mK
         bPPg==
X-Forwarded-Encrypted: i=1; AKwUvByHErojD3khRoLFDuO/pogHw4A1ERAI/20Um96lv6OIwKnLCQDFxgvZ6FxjPL47YxabVgkOlhM=@vger.kernel.org
X-Gm-Message-State: AFuF++lwF/Ihk3slSoLj2DMQ2YwUkYkHq3n2CvYAEVC481qD0rogM+Aw
	I76OVMJWT+Ez3w/j3ZZTpQGmY/RbTw9N5XxNaBoeU6nTVjPMinj0t7iWIHZBVuk46w==
X-Gm-Gg: AYBFou1CbKapeHUJEFr9ew1DrhFbKm5BcpihKGC36BhFo9Lk2/B1658Ew8CGkwuHEu5
	RmTFIbKKAGCB78Q5B4FCsi87/pHIkM7L9JMJ0G2hdKJpkbL0cyWjmbZj2hsDkA4xhQrt/0BgqE2
	pF2xt/tMbQLtqY8gmZCCYy42jM3yXXbWAVH5EDH0d5nul9xSum5Jh19F3ykeq5uiOSEZWMVWQEw
	z3EkAz0kHjpYSydgnM+eoj865LT5EETEbk7Uf4XVKxFDKSZTfv5FdV0sLbymu/F1HAlM9wzWv3y
	MNm+oHLOZS8NpeBwBh2yWA3+zHNgo0LGoG2W5FjsXL0TA/nBEwQKbXUkyMY+qODYOoedJ+Pxzuj
	TfUTxG47N8fHv/lAzx8sZct5cbL+DF4OyO64KwWr8q8B+qFYH6z9rTz7IFXcfgi/OkgCKKNP+MJ
	/XbB6DoDT9pLfGr6esiNuyDFVnj0pa8Lrw4ZOX1hTBx6HYKJ3vUm6Rnc9cg9HISV+zufwoM7tVp
	vOk5Dfs/bpHFetXf1dqBM0ESkCz1Gz2Yx9AcmWpoPA+e6uuKSzoRNqSkcdPXen1Ow2k1M0TLWx2
	nbNlk1LJvvmFRh9bTGKS/IiEnldnTLO+kw7GRNyPaLXtIf17M/K27pmiz23T5RNE+UBLow==
X-Received: by 2002:a05:6214:5f05:b0:910:6339:1888 with SMTP id 6a1803df08f44-9122e4d4ab3mr103911166d6.2.1789436394569;
        Mon, 14 Sep 2026 18:39:54 -0700 (PDT)
Received: from 6e-wmo5420-02.ad.psu.edu.net (6e-wmo5420-02.ad.psu.edu. [104.39.213.233])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f4787eesm108637906d6.21.2026.09.14.18.39.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Sep 2026 18:39:53 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Michael Grzeschik <mgr@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net 1/2] net: arcnet: com20020-pci: clean up failed channels
Date: Mon, 14 Sep 2026 21:39:45 -0400
Message-ID: <20260915013946.73963-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After com20020_found() registers a netdev and requests its IRQ, seven
allocation or LED-registration failure paths free the netdev without
unregistering it or freeing the IRQ. The unfinished channel is not yet
on list_dev, so the common remove path cannot clean it up.

Route those failures through unregister_netdev() and free_irq() before
free_arcdev(). Keep failures before successful com20020_found() on the
existing free-only path.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: 6b17a597fc2f ("arcnet: restoring support for multiple Sohard Arcnet cards")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/net/arcnet/com20020-pci.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/net/arcnet/com20020-pci.c b/drivers/net/arcnet/com20020-pci.c
--- a/drivers/net/arcnet/com20020-pci.c
+++ b/drivers/net/arcnet/com20020-pci.c
@@ -243,7 +243,7 @@ static int com20020pci_probe(struct pci_dev *pdev,
 				    GFP_KERNEL);
 		if (!card) {
 			ret = -ENOMEM;
-			goto err_free_arcdev;
+			goto err_unregister_netdev;
 		}
 
 		card->index = i;
@@ -256,14 +256,14 @@ static int com20020pci_probe(struct pci_dev *pdev,
 							dev->dev_id, i);
 			if (!card->tx_led.default_trigger) {
 				ret = -ENOMEM;
-				goto err_free_arcdev;
+				goto err_unregister_netdev;
 			}
 			card->tx_led.name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
 							"pci:green:tx:%d-%d",
 							dev->dev_id, i);
 			if (!card->tx_led.name) {
 				ret = -ENOMEM;
-				goto err_free_arcdev;
+				goto err_unregister_netdev;
 			}
 			card->tx_led.dev = &dev->dev;
 			card->recon_led.brightness_set = led_recon_set;
@@ -272,24 +272,24 @@ static int com20020pci_probe(struct pci_dev *pdev,
 							dev->dev_id, i);
 			if (!card->recon_led.default_trigger) {
 				ret = -ENOMEM;
-				goto err_free_arcdev;
+				goto err_unregister_netdev;
 			}
 			card->recon_led.name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
 							"pci:red:recon:%d-%d",
 							dev->dev_id, i);
 			if (!card->recon_led.name) {
 				ret = -ENOMEM;
-				goto err_free_arcdev;
+				goto err_unregister_netdev;
 			}
 			card->recon_led.dev = &dev->dev;
 
 			ret = devm_led_classdev_register(&pdev->dev, &card->tx_led);
 			if (ret)
-				goto err_free_arcdev;
+				goto err_unregister_netdev;
 
 			ret = devm_led_classdev_register(&pdev->dev, &card->recon_led);
 			if (ret)
-				goto err_free_arcdev;
+				goto err_unregister_netdev;
 
 			dev_set_drvdata(&dev->dev, card);
 			devm_arcnet_led_init(dev, dev->dev_id, i);
@@ -299,6 +299,9 @@ static int com20020pci_probe(struct pci_dev *pdev,
 		list_add(&card->list, &priv->list_dev);
 		continue;
 
+err_unregister_netdev:
+		unregister_netdev(dev);
+		free_irq(dev->irq, dev);
 err_free_arcdev:
 		free_arcdev(dev);
 		break;
