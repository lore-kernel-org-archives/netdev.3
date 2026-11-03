Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749922;
	b=UrZbP+7L9cRXudpTijTLZdH3Nmo9Gvz484KXy7/m702Bx7KyTSfuLryBQJP1rjSqIQJ1
	 APaTKqA9wuBKnnO/evfav3Sf8hwuWfj+x5MSm66H0Vbr/MhomsPosubMi9zcpFEpQHf4J
	 rZDVhQbgxoxrnS2aBeIS8O8JXLIksy/MQw0TT54nVaRLGlAzz/Mmu2j2O2mlaiRTCWw2V
	 esjsk/WsP+/BabHtNDFyQBE1AxICgn6jzIceH9DxiGbngJSdhToxUFfCs2Ee5XOQY2qVh
	 0Zpl2JoATaPO5tSdC+x989Yvjy9+HBJYjV3FVcjTYn9KSpuPXjg4kq7qjaSX/7gGiHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749922;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ISoGhcCNNYayXnvzELOl+oJCyXpnYMCHuTL7kvKeTX4=;
	b=mAQVEu3sv/1xy05pODtGhleo+lyBoitQnIuJ2NAaDAbL9wKlRzgHORbNRQD/YcbW2rB4
	 3S2Kzmd7CbM1LD76XVSkrGDS8yUmQj/uWIRogOWLLSiKZdxqZuJkWRaxOrMJyKWSkmuAY
	 sjQbTBqyKj3o9QzPKblKaJAuTWRCjQNkyxZG8/veeAdrHUMi0kZ48MiNHml+P4Hxf4ME/
	 o2ZWYuZLRIIR3enMd7SOUROlOXUcMHGGXr5iJbGQlOhqyiBxCVxcLgeatAJIQ1qmcG6JS
	 ZsqNZswFkll7zH3VmZc10rJAtCDWIakFn9aR5nIHv89NzHbSaQyK+FiQuQ6zTBxF8gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TDIPQIU+;
	arc=none smtp.remote-ip=74.125.229.7
Received: from mail-dy2-f7.google.com (mail-dy2-f7.google.com [74.125.229.7])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13F1606EE86
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 23:52:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D13F1606EE86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TDIPQIU+
Received: by mail-dy2-f7.google.com with SMTP id 5a478bee46e88-36c9b5c6faaso34041eec.0
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 15:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793749921; x=1794354721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ISoGhcCNNYayXnvzELOl+oJCyXpnYMCHuTL7kvKeTX4=;
        b=TDIPQIU+eEgw4o0cUbF8C3770HMTkrQOKM6qhMk5pKVPQTT+BVDahHBjq2+/twmgQV
         S0+gn/+TrWmsEL/xPSlFBScJefiABWlsaNNaX7D4IVGe9KSSvTWTChod9uWXMl93Ko8s
         x5nJQb+8/MmBnrLV8avr78N6hIi988DNFRP0e5g1mMBGsaUCbmtN7+sUdFkYR3ek8rO6
         PdvIk5zy4l/gzb2qLKlL3C6XpYOkLBD+1JL/ffRT/p5yd7/QrW17ZlaM0HO1djW1uGoE
         POxVNfVuC6HArG4Yo+AU1KAwBPlRjQ26micKU9FQK1KK5UWqojZq7BB1ZMMOtrX4MFRZ
         OX3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793749921; x=1794354721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ISoGhcCNNYayXnvzELOl+oJCyXpnYMCHuTL7kvKeTX4=;
        b=znRvzNMC3eY/wgXMajZcsHFPBx3h6IWCK0VNjKecEEr4Tjd/JYCywQEs1fA0nAQY5J
         nMtONI+wAH+4yDjxOzSIcqOSB1aY8kZS06H0veumz3/NnvEva4gaxPYtAxay2X03HL6Z
         L8aKOPia/ogCC6igD1ZKTQrYxzfg2J2ZQyRWCmS2XkgGuBdrqqyKyms7r1Q0kf4mE7bV
         5iHj13QoI4Cd2ruCFauGa+qdJKb8iFKwj4nN1ojdRh0nIkKMY6XYVOHGfIqvr1b08w9b
         dXMjIArftwiEWjILKy1J2b97ARpMZ0e85uGZGxINLRsQcUcbBzf3rdWtNhNqOlMU3fgU
         TxJg==
X-Gm-Message-State: APuU4Z8Iwx7/BAfv9nMOEY4Y2IQ+iuC+pAOVuj98mhkZBObhHs53ccjC
	wIrf6UZOJ2krqv25gSeaH/Thi2sU7nrcxBS3jlmeJd+92RPfC+PFzM2+erDutpN7
X-Gm-Gg: AYBFou1uRi9lyFg8z2F+f/vUV/PKR7l50Ggh6V/yLEm+qN+OAsoVx/CxZSZsRAOrau6
	TQAQls3GvqZFWXrnEXdbZxTcBHl6OVvvWBrYcfMdBN7/s7kVPxiTsl0fcxTHcvlFxCbJqMVOTD+
	SYh/diGPrcqKSsUJgfDGeCQuQLn2zSq70gqNBbNvX4882q4OSb/bKjLAz94Pu1Mml78ftpgzOXb
	iEj9S2PAlHsjb6u5vOGRnR9KoaffdyPvPCaiRCxOQ4itcUKo2uau20FtOJy60Wy7tx5wT466hkr
	KO8tS5uCX8RUGPwlFkHwnkWVXKVutIFKrom/8T8kDiHT2HPkuzq06D7eDVkV/t6XYFvog9zj0BN
	XZNTz+96RpZrYBVjKmGmiroKEtoe4BubID+RK4MFf65AXUa6liVToEJhsFod84ELUjZ5ZiU6hmz
	uHMc0tcqhvqvML5FxJPGzByqPZFxcYnbm14WdIl2/5mwh8+A7EduFsNp435zRA3yeKxTx3WMzlN
	LlG58ZpZuxAVQI4lbjSbo4vd7I1a3lKe7gZ7K8JwgeUbd652Va1yQ9KNQJKwR2TyH128g2lUjl9
	rs8sx8uyynnEcUop58v7YtE=
X-Received: by 2002:a05:7022:3f0b:b0:1b1:f02b:232c with SMTP id a92af1059eb24-1b1f03a6a35mr12004352c88.29.1793749920767;
        Tue, 03 Nov 2026 15:52:00 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:6b::])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c4706bsm2855464c88.15.2026.11.03.15.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 15:52:00 -0800 (PST)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	edumazet@kernel.org,
	horms@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	sdf@fomichev.me,
	almasrymina@google.com,
	bobbyeshleman@meta.com,
	asml.silence@gmail.com,
	razor@blackwall.org,
	daniel@iogearbox.net,
	leitao@debian.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v2 5/7] bnxt_en: limit netmem TX frags to 32KB
Date: Tue,  3 Nov 2026 15:51:50 -0800
Message-ID: <20261103235152.1904727-6-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261103235152.1904727-1-sdf@fomichev.me>
References: <20261103235152.1904727-1-sdf@fomichev.me>
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

The TX BD length field is 16 bits wide. Limit netmem TX frags to the
largest power of 2 which fits, which keeps 4K aligned frags 4K aligned.

With 64K pages this already applies to PAGE_SIZE net_iovs, whose 64KB
frags would otherwise wrap the BD length to 0 with BIG TCP.

Tested on a 50Gb/s NIC: devmem TX from a 2MB hugepage-backed udmabuf
runs at line rate with 2-3 frags per 64KB skb, none above 32KB.

kperf output (sender side, 1 flow):

  client: == Source <sender>
  client:   Tx 46.358 Gbps (174483046400 bytes in 30110590 usec)
  client:   Rx  0.000 Gbps (0 bytes in 30110590 usec)
  client:   TCP retrans reord rtt rttvar d_ce snd_wnd cwnd
  client:           729   153 599     48    0 13893632 3147
  client:   net CPU 71: usr: 0.03% sys: 0.06% idle:67.62% iow: 0.00% irq: 1.12% sirq:31.14%
  client:   app CPU 72: usr: 0.16% sys: 6.01% idle:90.66% iow: 0.00% irq: 0.83% sirq: 2.32%

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
Acked-by: Mina Almasry <almasrymina@google.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index e7a4190a8c78..c8a887facc20 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -17439,6 +17439,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (BNXT_SUPPORTS_QUEUE_API(bp))
 		dev->queue_mgmt_ops = &bnxt_queue_mgmt_ops;
 	dev->netmem_tx = NETMEM_TX_DMA;
+	dev->netmem_tx_max_frag_size = SZ_32K;
 
 	rc = register_netdev(dev);
 	if (rc)
-- 
2.53.0-Meta

