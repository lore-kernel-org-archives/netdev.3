Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793646886;
	b=sBRq59TYMvlvaMZyg1fyOsad7KsukYg+Mw8uxCWUReAMA1xSfghOWKchiIPw6a2wS5GM
	 GpxtlTmIBUxE4XJqCvVROzQRQEr2dtaDIoICNVckM9jdZIZH7xFmy7AIMYiEZb5TpJlau
	 Is4ncoO48fVv3FV45/uGRt2tbl2C7tBOa/2yj93ae7WIC/zRlL1MJTfODnGyZJhl2bLlM
	 Dw/XHEwjHcXXupjOXE570nFz+wykJBUOplCOcNhlCvVjxhatfDpg0ntzCsLPxuicTEWWD
	 h3l2d+S138dxFmDG/LNfYeIQOHvm/d5NU2iAsgJ53mb8o2FxEYPhYm689FlitYNzQrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793646886;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=0fkWwqUr24UUjvWom7HkAX5hPBH7703K8eWke+dsLR0=;
	b=jGG8aiaftbjbQBJUTYDfLJfGgejeOzxFwzrynO0vjAJajxSEVbKmUBUsJeqysJJU1ZQG
	 bQb/D7CrUAiWaLlm0XumV8tewKG0NDMJCFFMtwQmvqmehXSYYYOAcRSV0heEA4+wgnh1F
	 7Ca+Z/KHiYWWc1CzOLNhcz8NmAc9bu7/Fi834RuyJ4IEhdKBaKtoWWcnJV1cLXPL/yI1a
	 koNW/wH2S+fqSEOH55hjeyFKpwNSb3KjjDue5RZzIntt3ebod7753No6ALY82QcEELbXu
	 /E67BzoHwUXK1QSGdYwB0WYlNLzCyTDitSzhNZ03I6ziv14t4SqcpNxmdVQuvAGlzMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dJiTy+hC;
	arc=none smtp.remote-ip=74.125.229.5
Received: from mail-dy2-f5.google.com (mail-dy2-f5.google.com [74.125.229.5])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51E1606EE83
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 19:14:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B51E1606EE83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dJiTy+hC
Received: by mail-dy2-f5.google.com with SMTP id 5a478bee46e88-3535a54c09bso387804eec.0
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 11:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793646885; x=1794251685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0fkWwqUr24UUjvWom7HkAX5hPBH7703K8eWke+dsLR0=;
        b=dJiTy+hC3H4kxCI3qHT9mx61g9/FmwOVPDgGu39Cm4eH7Ev2O92eDCqDrjXnnZbJi/
         oujjVOK5sfXJe7NCV+utNUtQZsvpLoLRlAVWvoYT31nth3GhXBZS3K0QEA7oIV137aXq
         hP2k5rcV2T5SHMxqH/fM7zp9bqiaAsMShtqOf998cSW4FtQfH9P6O+ji2LngoVodiqol
         wQ0mWoBgcsEp3CPOF/oXJyw2jKx5DmyqIIGzzSnKz/85KXSup4xnII6+MqwyFxZw/MXd
         S+PQvDKBuKQuPypOEOgka8V2i//wBD4gA6AuMj1diGXpDTtez1u9pqnXuA/6dJ2tUR5J
         VjfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793646885; x=1794251685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0fkWwqUr24UUjvWom7HkAX5hPBH7703K8eWke+dsLR0=;
        b=rq/WSv16kMrq9GDTgJMdQJmuD0NLnczTLhnkc5uiEW2pqefG/97lbimKKkR47mlYMf
         iG4TkgYiPqzC3uKFGC8Oz8euRcmB4qDCjdDSq0hNq/I0PKHI4yWuBaJWnd9LTfwpMzGL
         2vB3wjYi5ayj05GNXXDd6TGX7JwpSk1AxuBvDAbGAe1jfLHuPJuYx819w5BUYac9hnV6
         y6rAK/PRFILXN9jtOkKpSoZxND4ZIbYLfiDaIO/ka1X379oheL3WKVVYUlhiNvHkJM/H
         gbuSxT+ry0GH5kP7ea68Vr0ToX8TQnSox6112ndMnf4I+3NxmdhLlNOj0GY7lRD/0lXo
         jCXA==
X-Gm-Message-State: APuU4Z/QJYbBURD8LhM28rhTlQcuD6GttTuhygvU6vNRGhxt3ZsP5qXq
	G0tbybjZLUdwJoHyqr4e9lZQQ/E0esmicYfwp5Yd6Rm93KO3QvSAxTnha1KBwI5o
X-Gm-Gg: AYBFou3KbCu8fTgDXg+JiqsJWDP0l/27kfDj1ttPmkmtUHzbM9q+qBvlAuStOspZTsW
	aKezjuHcO6gRn6ZNA7S9YX2JXNh6PTsKhzfggujLTu4ieDplmttqAN05z0RwEH19Wi41bNMWSW7
	O2xslNK25BSyO4BOBd7TmeAXhKC6L/QFajU7v192x8iH3ELC02wUuQPplPAnJWEvmBHPqDl4He9
	CA4HqEUcu6I7BwkYBPbRmkVrmA4CMr6MeIClqU/WTZLWmWJdRFrix9CMLKI8o6ArXZPuVI8NNl4
	r896GsS8sqNemoDjIBw0qltyHpYbXdRCtK5ucchu8uH8vf5cksEAZ9Fp3xrXvPJAoIAWAZXAQqR
	4LSIFHrxCtO1efBapVj+AdBZ1uR2CHZkXxdxtgj34jW2FX7DsEuUhSF8t5uxOkdxBa+OJRGM+wK
	IEFlOBl53NbicedCJco8mpskC80pJMk+aZB6BWIioCu74cJELhpMiEjwTAhxtgbgFYfisT8BbKV
	kQn2m2qkwzHfG0/NhKP2WMYc9Fg/JGNWXfhjAaR+1i+urnsXdRprnFe5PvT80o/oG9UPt57TbZN
	Tzanwg6zAAy0sQd74QpSFys=
X-Received: by 2002:a05:693c:69cf:b0:369:daea:812a with SMTP id 5a478bee46e88-36a423fae73mr15064264eec.30.1793646884909;
        Mon, 02 Nov 2026 11:14:44 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:6f::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a6eabbsm40129419eec.24.2026.11.02.11.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:14:44 -0800 (PST)
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
	daniel@iogearbox.net,
	razor@blackwall.org,
	leitao@debian.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next 5/7] bnxt_en: limit netmem TX frags to 32KB
Date: Mon,  2 Nov 2026 11:14:36 -0800
Message-ID: <20261102191438.1059771-6-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261102191438.1059771-1-sdf@fomichev.me>
References: <20261102191438.1059771-1-sdf@fomichev.me>
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

