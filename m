Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794459266;
	b=g3/qWNDEZpN3wvXp9RoFSNgbkaqA/B9AQYCVuD4sIKlENOEJ/yCNVZA1oJMgkuvaZ0fJ
	 CRSwQqIl86VZ35wRHGhPVbHc7CwAy90Or7/zU+qLOuhoJBJ4NBcw66S6bg5zFO5uM+1B6
	 lo5l+7FU2cNb+L1/II7GNfJ/GZSE3wIH1rcuNFHn5pYf96F0xlWM7xzrm4PtwIEl5NsdM
	 ekhBdMNkdrGhJMkGNPl/qhvugMmXikkALIbHbaEgbsk0A58HFbWMzSgcqc/Aeds+QJn/0
	 0TyqhWzZKk8UyfSvqTEsA0VDm94lCI72sEkBDM2mqbcurypJ+Ke7Dl4NzTJ4GbW3V4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794459266;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RAq9n/kNrP7BlUgARluwnVEw0T6kr6FCdHtXIgtVkeM=;
	b=y96e16gc1dWaKDRqwSufw69xMppLZYsWFMFLGABkOKpnw8dDzw3FMCwH1zoZ23EEEy4m
	 bLZNfOWbRr0YG3JNPUJE535FlKMfCvOhctr+Pq03Jpb0dlb2dXQleyCWraYCaoMqZne05
	 j9SjZJ1B9rA6qRd+m+5c6ScSybRIttVHiUaW07qLoP/O/4C0GXQ6zaH4BIV3rp5QgsOhF
	 z/pkxlitHEfPCAtiL3tyxqz1mGVBVbYhCxK2MjJT+iL8/TBM5uT0AMexWiiYgS2wuLggv
	 RwyT3wUyuigLX7mT4Nwe5mr2PboWUHsUs++qHQSmSBm2uLywad4ZrH9VI2jouBGMyxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=spDcTELD;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8872606A885
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 04:54:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8872606A885
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=spDcTELD
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso8193318eec.0
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 20:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794459265; x=1795064065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RAq9n/kNrP7BlUgARluwnVEw0T6kr6FCdHtXIgtVkeM=;
        b=spDcTELDFQlcTf19OdZXBxhtBvEGg4kq4pwPb1twI9/qO4gMpLoFm3DXDFfofVF5Xs
         Zgwx1je/2rmlyXNRFHSAu3PW34a3/XQUdfApr3W9NkndQTAU0CEesCkAmXvZEhsbgkQ1
         Vln9R5zmJc+ypxxE7usn8nE74ZSjSvGiGFfP513vGaYmkn6y9EL042KLawQyiPgg3l8R
         6eYQ8CHySmPTNVNxW9E567dW6scIE/PYDrkAy8Tv7qwdRAaFTLpWmG59yxRwAjUZe6iJ
         wdYH4xPHRqCnsV/UXAHOrj74jM/7LvaB7MnHdRccV1HNJyWrigjIy1qu2HgZ2kiWs/eg
         f1lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794459265; x=1795064065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RAq9n/kNrP7BlUgARluwnVEw0T6kr6FCdHtXIgtVkeM=;
        b=zp3Qj7kdBL3x3LG/tsTSYfkf9PHqJ9FdnI4Mta+jg98frbfeIKjWg3XND/O95E4qIq
         C0czNpB2mBL72+QRjJrl6mjx6h6KJ+AXOSolhTVMFPoXB45tdj+s0HJdgJVLBUHomMGM
         pwSoX068TTQwJxiY7Zhs7wx9o+jweTkhr5VbomrWVo9d75+futGVRn+c6Fn74oek6qgV
         zGYhuc4bjxOKj+RoBplHoAzYgtP6oaTM3u/1yXQ3x7SxYG8fY/l9yMqnUPdzfwrpz18z
         xCUibjzGP8DnepUm6zIyp+AwVQUy/zzTuYNaMiHKpnAFhzewURLm88Y5pgc/SfI9FFLO
         dIeg==
X-Gm-Message-State: APuU4Z+4mBDWrQMa2GRPI383WNC7UaFQASzTysnLEjYcdnUDHQCksA/K
	yKRbyBzJqtXgpb4LNb+uOAe3ULwLrA9jZLjzN60MGhX088ki5L1eNGiIwWEMWA==
X-Gm-Gg: AYBFou2YIdXQiHw86qQucMLI8TNWUbp8N/suSIVBszFU969U9usmtU5MQrNMxP12D0f
	D98GPQ39wItVoxlqkpr+Mhrh6MFOzg822y4lM3AZEqVNKO0OmfbtvQqocvwovQhkrl0+FUg4W//
	98Dyk6pN4kP5AHNtBNgOJQ1HS1o6D5IMp0xTnSZ8gSF8qYLqGfrs8qhteK66+sfqeSpGU+HgE08
	9NknMCb4rhX4u6hbpQQkN7L+OSQp8tJBp7bU3KH148jjoVynyGjBNig8xoT8wUBuKKPH+6pVx4+
	PpasnpjWDzaEQw4EVXHq2NWgWgKuf54LRRG866he5LeXgx23G0oevoG1b8o5zKRM2sGga5QHKoD
	R2ypvwBzkZsmDSdjRMmc7fakp9euHeoyPMU77Wd5wC0iIpv0sGhsXdJKPkLBQYviCyGTT63Klf1
	10wm3V/o4NAswbKdW+Bz0MAntPPqLEl0JJ/qnT3hGV82lZFNM5ZA86fboymDseKfLYy5BFruvfM
	6QlniB7da3MdXsniKZpaoVbOBvPLHpQue0uOd7ky6AA6dIM8p7OAYTP80gZJm4ROVIEaTP6ZW2M
	8Xgu7t4K4ffDg5NPUjVYAKRPD4BPlQ==
X-Received: by 2002:a05:693c:41c2:10b0:36e:58f3:6f0e with SMTP id 5a478bee46e88-37682f9334fmr5020480eec.5.1794459264772;
        Wed, 11 Nov 2026 20:54:24 -0800 (PST)
Received: from eldorado ([2600:8802:b00:1f88::287])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520cfdfc6sm23921585eec.17.2026.11.11.20.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 20:54:22 -0800 (PST)
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Jijie Shao <shaojijie@huawei.com>,
	Simon Horman <horms@kernel.org>,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	David Yang <mmyangfl@gmail.com>,
	Herbert Valerio Riedel <hvr@gnu.org>,
	Jeff Garzik <jeff@garzik.org>,
	Danny Kukawka <danny.kukawka@bisect.de>,
	Mugunthan V N <mugunthanvnm@ti.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	linux-kernel@vger.kernel.org (open list),
	Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH net v2 12/12] net: au1000: reject frames larger than the TX bounce buffer
Date: Wed, 11 Nov 2026 20:52:54 -0800
Message-ID: <20261112045301.3669532-13-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112045301.3669532-1-f.fainelli@gmail.com>
References: <20261112045301.3669532-1-f.fainelli@gmail.com>
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

au1000_tx() copies skb->len bytes into a MAX_BUF_SIZE coherent buffer
without checking the length. Oversized non-GSO packets can reach this
path through AF_PACKET with PACKET_VNET_HDR and PACKET_TX_RING, whose
MTU checks are skipped when a virtio header is present. The copy can
corrupt neighboring DMA buffers or run beyond the coherent allocation.

Drop oversized packets before touching the ring or copying any data,
and account them in tx_dropped. Use an IRQ-safe skb free for netpoll.

Identified by Sashiko AI review; implementation and validation assisted
by OpenAI Codex. An extracted-function harness passed ASan/UBSan checks
for 2049- and 4096-byte drops and a 2048-byte accepted frame, as well as
TX ring regression cases. MIPS driver compilation and checkpatch passed.
The complete AF_PACKET trigger and hardware operation were not tested.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/amd/au1000_eth.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/amd/au1000_eth.c b/drivers/net/ethernet/amd/au1000_eth.c
index d60430a3795e..d8855ccf87aa 100644
--- a/drivers/net/ethernet/amd/au1000_eth.c
+++ b/drivers/net/ethernet/amd/au1000_eth.c
@@ -1008,6 +1008,12 @@ static netdev_tx_t au1000_tx(struct sk_buff *skb, struct net_device *dev)
 	int i;
 	unsigned long flags;
 
+	if (unlikely(skb->len > MAX_BUF_SIZE)) {
+		dev->stats.tx_dropped++;
+		dev_kfree_skb_any(skb);
+		return NETDEV_TX_OK;
+	}
+
 	netif_dbg(aup, tx_queued, dev, "tx: aup %x len=%d, data=%p, head %d\n",
 				(unsigned)aup, skb->len,
 				skb->data, aup->tx_head);
-- 
2.53.0

