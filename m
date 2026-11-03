Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749918;
	b=DplzP900Kx+QAP2RXY4kGNt0XqhsRZ1J1UO45iMjrpIRmKtI20qNuG3etWJrihob7Wai
	 he8lSDrtq5P9CHjs0L3/58MJOfpzGUDrqFX5atBFgk1+P/ukDRpobiNfw4ZVf7JlmsML/
	 8OKdd8DZIYpFM/1eA5OprtDnpgFX6lohiZkCV3YX8Bdk4SD8VjeVaDMYo6mqdS5wXEI5Q
	 ZLGTOmXV0eeGlwmSlADKj7hIG7aqbv0O9yYLhkxExTZtppuHyJR7GKiOhBiGqoNtiDIP7
	 iN+dO8BVUe/6eGe6+rCGIHbW7N4UZCE+jcVG5WvlXC2s1izAuT/YVg76TvzhLgHU95w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749918;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=fJ7IQIOXNs//1G8hg9c5EGbjN6OnBWvPLJeIH74gcIY=;
	b=10B4wEPi4mbwIHPQ47S5b/14EyDE24Ltc576koB+Lnj8Wq4PP0RSi25XKG29oVWwUXxU
	 Wn0r6/1RSPS6tSRyGjS4A03YzRv+OdTFSxOwacpDgdZslcrW2DoDHvLR+NVhB/DPuQsqg
	 BrrN4X6z+gR9WA4vsV1vwWT1O3dxv+TbKs67cFId/MuvZuuuGphniKr3f1yCQ71X02mwH
	 2NipQWZwEOC9viIVsIe9ZpqBYOPqEFxHm5pKvyWPSJSaCqF9q4W86Q0voRmngGyRrIm9S
	 BqbgvcqYj93YW9sHQHsYvaq6njd4qeU6inAMy7RHwpD4ohY3fXwr4YVDVby6IYPZ2cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZWA6wz+g;
	arc=none smtp.remote-ip=74.125.229.8
Received: from mail-dy2-f8.google.com (mail-dy2-f8.google.com [74.125.229.8])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221F5606D81A
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 23:51:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 221F5606D81A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZWA6wz+g
Received: by mail-dy2-f8.google.com with SMTP id 5a478bee46e88-36c9919c659so93547eec.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 15:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793749917; x=1794354717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fJ7IQIOXNs//1G8hg9c5EGbjN6OnBWvPLJeIH74gcIY=;
        b=ZWA6wz+gpgHjh1WQ5eaQidrNz4Hzm3YQ8yeDFG++7giIdaEL6V0GQwJaQi1OskRj0k
         +zip9+d3WalbJESP2kwkC022l+JuQR654DJvkHmcsyNWZMTCvN0ElGkjE2tAcUQYah5/
         gSpizDmU3DsXOnWZpLiDpfqOmhZ8YQaP/9tWHA1qp5AhqlxO89TPz8gwG04DxQ8lgaan
         pOiYTu0jO990rh37d2ZAEwe0SqDrBe4tBitHRe7tiwWn0Dmk/K87zRQ2aeznObVW2CHt
         roz7IHwemorr2dqr8E+YfCKI4huU4b5tkmn1VJDT5U6JVMlV7QRteohMjbiWP3pu9S0p
         pU5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793749917; x=1794354717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fJ7IQIOXNs//1G8hg9c5EGbjN6OnBWvPLJeIH74gcIY=;
        b=KqXF2AK5ZW77gnzvujsROLB5kq1AZlY4ZW29XP+NMCSjei/fnRXYo56HsgAwOHabIa
         upBqU52CAJ92kvda05VPltmGLiPkurdxFBopj9l+v9bxQQYV+zj3L3X4PgwTGnuSjGZn
         y2pXu62Cu//qc1oJKJ7MV8bKlYG2oIbEfz5LsW38gkHL/9WTv3nonlQ7ZYentoc/YsKW
         FUXBz6ykAdh/MByX5q4iumc2s2LfDKycU2sSKWHQlQWAX2rVQsmq6QVFRXOXA2thQV9G
         DrJTqQ1PH010R39+WT0Ty8ZsJ6kN2QRkH7lXXUjBmdyZAFiCwNc3ij5/3GbXXPEeBjAK
         r21A==
X-Gm-Message-State: APuU4Z80tTcU9Vj+4gjlLAoW1xP2DAh+9Cw+h2ZPFM71SZS04bYktgI+
	xWHIRylrZRLgX2/UljHEhVwARWSyVV5vRDWR5SrQEe6jSLymeIy/5wbwL1Xhc1nC
X-Gm-Gg: AYBFou254uu9pw2PkW/XYDmdFAkEGp6FjAYRSp7zWadmEJ1eFlBH1JEuxVUVmf4Z118
	ybSKAVwoVqKdJkJO7NVtWKK7l7UPONk04VYbCNc2TLJxsnfC8SeCKEy279V/sABlvPuhVZEPiML
	1a9JB/0fwlpFvfOV8gjz0dZH0P0jPf2XZeF5RqGRGAHunTytpZ7pCXQcjMryyZOi0J23ErM84HY
	9Y/o6oHYtErMez31erI+bYfyn3ZV1XlH0nwPSh8JZ5JEzluCTWlELRuVMlkQZvf9mvXETU91dAs
	jYb1EgfcYf+118UaPI7aoSjr+5zZqO9PCDLI/v3IhRay1sUH8h2tTKR+F+nB7c216TesTxSHWx7
	RCGnaBKAm9VYOqVJKATmQh/bofveG/CzoBhwZqXLarFXa6O0R6mlhRRuMOP+SrOYHGDNarBaevQ
	NkibUhCLr3qoW5I5GUWIVQuNwlEz1f9Kaz7veaYDBVUWw1WrsNrHIKWPUK0gQflTdy1JrJ7pK4E
	/TJfpGHBGZqK115xP5L4Lir0EQQbQ/ZrecDGNHClS4DHEtaSlT765A48Y6MIJwLzqybvkOn732l
	MhEn6lZ7YAWLnSctjwRKJNo=
X-Received: by 2002:a05:693c:87d0:20b0:36a:18a:e00f with SMTP id 5a478bee46e88-36a42406487mr23417013eec.34.1793749916956;
        Tue, 03 Nov 2026 15:51:56 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:71::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca39b8eb3sm1876335eec.27.2026.11.03.15.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 15:51:56 -0800 (PST)
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
Subject: [PATCH net-next v2 2/7] net: devmem: charge the frag length to TX skb truesize
Date: Tue,  3 Nov 2026 15:51:47 -0800
Message-ID: <20261103235152.1904727-3-sdf@fomichev.me>
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

Devmem TX charges each frag the net_iov size, PAGE_SIZE today:
zerocopy_fill_skb_from_devmem() adds PAGE_SIZE to skb->truesize per
frag and __zerocopy_sg_from_iter() charges it to sk_wmem_queued. TCP
uncharges in bytes as acked data is trimmed from the skb
(tcp_trim_head()) and uncharges the rest when the skb is freed. A frag
shorter than a page leaves the difference charged until then, which is
small with PAGE_SIZE net_iovs.

TX net_iovs are about to grow up to 2MB, while frags stay bounded by
the skb and many frags share a net_iov. Charging the net_iov size would
charge up to 2MB per frag: a 64KB skb with two frags would charge 4MB
and fill the default 4MB send buffer on its own.

Charge the frag length instead, which also matches what TCP uncharges.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 net/core/datagram.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/datagram.c b/net/core/datagram.c
index ecc30a6f8302..489d92fe6dae 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -737,7 +737,7 @@ zerocopy_fill_skb_from_devmem(struct sk_buff *skb, struct iov_iter *from,
 
 		netmem_inc_ref(net_iov_to_netmem(niov));
 		skb_add_rx_frag_netmem(skb, i, net_iov_to_netmem(niov), off,
-				       size, PAGE_SIZE);
+				       size, size);
 		iov_iter_advance(from, size);
 		length -= size;
 		i++;
-- 
2.53.0-Meta

