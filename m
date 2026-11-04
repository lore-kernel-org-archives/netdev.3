Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793773984;
	b=CQ+8fGC5zwYpLWI2T/rOs902YXKgLfQRU+YfGf/6A53nCTiCTt8GutZc4aVJETDtf4MQ
	 ciHjdsHXRZM2dDF6ojRiiptmjMF5LYvMTw1ulVca+BQOfoB+ISbBYodJ0RAagQjlvjxp5
	 qOxBOQA0p9FRQmCXM7RNDQ0mqfCO4L2T+pNUTVGWtGb9nCRfFt2SzAyY8x/WQvz8MeZoo
	 AcJTz3G6Nwxxi0E0OgY9/lPOZjr8hkOSJcO4lxNhTyJigpqlxVywh9jeE6y4aasES+JhU
	 cKiTFQgyAN3MoNqogIAV9C84+erRRfeO9QAH36mYVEMmqLIHUfi8fXgVAO6sPiba5sQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793773984;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=A267S55gzLsHKNdX2hHubjRBVjQyKepuiQmncpiS49s=;
	b=l2JM2WMoVxNFAzo47fiH49Km9wdwvej7gJ08DvFlLqubkYFKDCFnhPvXDURgnhde0xOJ
	 hq4s6BtXIsNWUYFJt6pm5nRFmSqkkduhhshkSwOuepx9Zbu1V5crlh+7vkV6jDlELpn6+
	 m15IUQZrVcNQmCTKyPShM1RPHMZnKVyAKtLDu1P5nEjeJKm49K4RnPKQkLhGzCPjmI7HO
	 0jHEcRsCCiFWO7fZabVYepnTPIzcGlMyhKZLd9LLBDc9kn0Ma1bMWe6e/kVSIF05pKMaG
	 2U7Ay8ToR8PCGiprUvwlFnUwQePdys2yKLgjz4MGP3/4snzCrT4pETmqT5Jg8dTy8kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="P/3fRZtB";
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCE2606A339
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 06:33:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCCE2606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P/3fRZtB
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3adac5c10e3so264327a91.0
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 22:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793773983; x=1794378783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A267S55gzLsHKNdX2hHubjRBVjQyKepuiQmncpiS49s=;
        b=P/3fRZtB4Qn317tlZqnrQOHNMnODYV5scoIBkngzWbm7EbPJDSL/xd0W/t6zO4uXRI
         BmPwbwD6oyUwUCNrkTw+zT0T7HLsOffjX9vLv5NhAr1QOddMCwsYsjeS+MEfDJDkPyfN
         0r6X808DuXj0HYmBHpB97UUeqovf8ofndKWnNZPHyW/HjFvftFE+xvD5i8IHqWM90HiD
         /bQu88706FAoYlIIOBa+jDf74VcitTwBUJ9d3y7fCQzyhbVqKhDPLNPqLdt7oHVAMhzb
         Y6VXnMAf9/jir/7leYCFvcfv5hlmDKOd1YrRZJfaacGkwVt1lQfr8g0AhbgtQ1G/0nVV
         ZzWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793773983; x=1794378783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=A267S55gzLsHKNdX2hHubjRBVjQyKepuiQmncpiS49s=;
        b=USD4Bh8ppKXbg8dgCgpdsvZDGBnNVi/OcONY8ptGEs2QXcvKZVfi7jpchH4WJJLBOv
         p8bTW65kuuRiLrQg0cwMqDmufawT0Ndw6hXbtAfNFTzI5XtEUyBpUxaKYKz2/ViarwVt
         wdXokh9CcRe368CZRIP6r6pao7DDBn0ItPhVHbyYDAIZVHhf+pcxduRyfUcKzjHxSpkk
         oNnC0spNFwBa5FGM9PCDOT/W4g2qx3v5nRrm355/Pv5zTHDY21F+2VRKuq1+PJ9iWen7
         ikU6woOnvzi8hx+dzc5SRPBi1FhVdExkNF2Ijy6voZpqFZs7bwzr3mEaWqTD5EWkPrRN
         xJGw==
X-Gm-Message-State: APuU4Z/M4sBQFdsRoLK+Sp4FrSDOzFNvs4MNcsrU6B32wJEFXbMfKSw9
	OCqDSvi40imM/Qdbcb80B9pf24qGMbjPID6gsirFkA239Mwo2mBt58+hJLCGXg==
X-Gm-Gg: AYBFou3rPVvO9b8A0/p2cKhdWQbwTDCNESZLhXV8nYCUlGVLXY9c8YyUFN87CCCWpGB
	RYQNRRsjxotO/daaVVsOPZfKd+EyD09x77MNwT7K81DNvfJf3JIhqiF02j1YJQYg18aI8d24gvH
	F8TkBwblGxtI4gqQOAQ9lt6JPAJtk3ZlGJ4ebL1DlYnpzcMn6sTvhJRwcMG8zsrKTSIabZj8hzE
	1ZEpnID43gGn39jl2zHoHQCXQs4iwbi7e/S2j+bHTEW+ezo2D4Gb1XLJ01v9xUYEUm9c8BszhPY
	/Rd8jv0NCf743a4VMrofOGEzWLNAtsWAd1go5e5UQCiUweSN9SjqOVmD2XkMtGNVR8Oqdj+/i3Z
	GipF3onQnYDKj80tqHZBBWnR+Mqt3RMfyf0VHN1kvtzREFJAOv8osdwY4V+IxMbnbvDd6hEJWNw
	rzrrir9yzINhyXq9fzy+e7MahXqQCNfo9G5bSynwImlT5YsNjsasdFtlag6nrzk5f8d+fIiksSj
	Pkaf8GjCFdy9RHlFK09KNkprxB3gi1nTi77/mLUwiLhsY2SKttXIjjLR60uxyA3DxN2Bclp1XR6
	tqfCBOuKsaWkb2hHavYy2AF7weCthz21vk6npN6+g2JN1lN7qggJDT9xVA==
X-Received: by 2002:a17:90b:1645:b0:396:41d1:cbc7 with SMTP id 98e67ed59e1d1-3ae8957cf23mr12255501a91.3.1793773983145;
        Tue, 03 Nov 2026 22:33:03 -0800 (PST)
Received: from ubuntu24.localdomain ([124.77.157.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0945104dasm2583207a91.17.2026.11.03.22.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 22:33:02 -0800 (PST)
From: BeaCox <0xbeac@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net 2/3] net: enc28j60: disable work before freeing the netdev
Date: Wed,  4 Nov 2026 14:32:44 +0800
Message-ID: <20261104063245.23402-3-0xbeac@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104063245.23402-1-0xbeac@gmail.com>
References: <20261104063245.23402-1-0xbeac@gmail.com>
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

enc28j60_remove() unregisters the interface, frees the IRQ and frees the
netdev, but tx_work, setrx_work and restart_work can still be pending or
running.  tx_work is queued from enc28j60_send_packet(), setrx_work from
enc28j60_set_multicast_list(), and restart_work from
enc28j60_tx_timeout().  The handlers access the private data, the SPI
device and the netdev, all of which are freed with the netdev.

Unregister the interface first so the xmit and set_rx_mode paths can no
longer queue work, then disable the three works synchronously before
freeing the IRQ and the netdev.  disable_work_sync() drains a queued or
running instance and rejects a later queue_work(), which a plain
cancel_work_sync() would not.

Fixes: 3ec9c11da033 ("add driver for enc28j60 ethernet chip")
Cc: stable@vger.kernel.org # 6.10+
Signed-off-by: BeaCox <0xbeac@gmail.com>
---
 drivers/net/ethernet/microchip/enc28j60.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/microchip/enc28j60.c b/drivers/net/ethernet/microchip/enc28j60.c
index d6c9491537..bb29a94a1e 100644
--- a/drivers/net/ethernet/microchip/enc28j60.c
+++ b/drivers/net/ethernet/microchip/enc28j60.c
@@ -1600,7 +1600,16 @@ static void enc28j60_remove(struct spi_device *spi)
 {
 	struct enc28j60_net *priv = spi_get_drvdata(spi);
 
+	/*
+	 * Stop the interface first so the xmit and set_rx_mode paths can no
+	 * longer queue new work.  Then drain the works that were already
+	 * queued; the IRQ handler does not queue work, so the IRQ can be
+	 * released after the drain and before free_netdev().
+	 */
 	unregister_netdev(priv->netdev);
+	disable_work_sync(&priv->tx_work);
+	disable_work_sync(&priv->setrx_work);
+	disable_work_sync(&priv->restart_work);
 	free_irq(spi->irq, priv);
 	free_netdev(priv->netdev);
 }
-- 
2.43.0

