Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794513067;
	b=kCxa7K5BWtnuJkCeiacZi0jeu7xB/BDFvYArO+yJNRg8hOzgVHEzvszrqp1nfobd2fB4
	 yub4oDHLHEJK1ps51byg0+7EdoOdtzWfNjG3FBPfR7ET0WMZABK9SBmSMty4HORU7hwxW
	 fitmvcJGe/zNOsH7FjC4Og6/2LRNad6fOexC49nhwNwnqIvhDfZHIcoR5Ky1kF+ZhqWr3
	 82u9QT3p1AX6sBECTTZBxKNWVtQTpJvg/QVa/IjCY3saXGIFD7qR90IlrME6/EvvbDWac
	 8BtLotWwVR60iWHsKfczKBaktbsFiVrA/xibeBz0Lp3H3NJiTZViSpXQX3AADxctU5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794513067;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YQWbLDtfU2AvvfUHn0EiRY82gY9ziJzVrcJgQsIFr8o=;
	b=JdjaWEi507lFvj72bIWSpatXfUee0t4APOGVkSDmi0twrp+LKdfbVyI6ew5Yh/zg+WHK
	 fxi+CUFoGgDkraAimollv9K50mM4Ppnr9QHQoywiavEF1GPM0gLYdXg4NgRtAmehL7Pyd
	 n9rnCfTA7RuJONQPSf6EF6tFuYMQD1BCoZrzjuOT7+lUkvCQyYAp8n8jE8kuekfdbp0Cf
	 2jVe16kKft3+UhkEZAYoQSu1irg+8YXWvMNpb2w4jbei9Q5F6qt827YjZga8227tQfTJ1
	 z1VrCHB2iXPgOLfXY76hKdZaIKaZeSoVJr1HQBcry6rKZhx8K1PIAJw66KqT7x8Ok3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="ZuX/cqWx";
	arc=none smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5929F60A2624
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 19:51:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5929F60A2624
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZuX/cqWx
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c4cdc606b47so493366b.0
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 11:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794513066; x=1795117866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YQWbLDtfU2AvvfUHn0EiRY82gY9ziJzVrcJgQsIFr8o=;
        b=ZuX/cqWxXtw4HCPZLJDGdLmhPsX7o7kQE/0vm90Cbmu3emuolknkNWbax27GMq7x+O
         qjWRQmEGwYTutLrHNPxd7eh9ZJ4lFbFc+iXtjBILqdAzoNW3xGC7a9HIucKJZphNE9H5
         27PV8NCA402uRY1J1X68T1wrLPVmp9l1FIRnqo6pTpAtA8z3Frl+40kqyQnF69yTdfsC
         J+b8KkE5M2nKBIGum/mZiAPnL21++J+UwIe3YT7Ut0EnKTT3DjIzPQ17w+KgcRlstqD1
         UnyGilMl6X7mbzJ625I3ubSNyismw/bYsbJEJYyn8MD76M/Wi6uWT0wc4VaDcny6qD1l
         /uAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794513066; x=1795117866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YQWbLDtfU2AvvfUHn0EiRY82gY9ziJzVrcJgQsIFr8o=;
        b=Fj98Xq7Q97KoDkdJkpWbkHL9SfFoCabmY1AYSZoRiNc9fNtXraHeBqjPtDoyInHJnZ
         35amG0OZINDtex7Ai5FopYaotrMGyGqcrbbH9ERcKnjeQCEge1EuulwwdshuwWe6lGXS
         Y+sc5/QJdc7gk+gcB34AMi/qLLtqKzVBwnJATq46SbyACj/xwR5IvVXSueF/Bfc86/CL
         U/wxjfstkipkP0o+iwKUkU6SldCNpNPSo5H5fnAPP2vLFi3dSE1iT01wZd37y95hBcOl
         TnN5B8uLQLfOy6zMUPm6kQPnlzKn2nFinaoYcL7MB7oDpkgzsJN1TxD0AC6kkjXdudPY
         ehfQ==
X-Gm-Message-State: APuU4Z+FXsLDDqIqYnOPbuYra7BPmnI1SOth8dfHA+jUWD5RY5+iJp0v
	WQgm7TUVYo5kc+WJn0lhctNuk9tJB3nrUBuv/18QIcgaFBADIJ0ABKmhp+Nptxuf
X-Gm-Gg: AYBFou1o5nqgsy86CnGmAOpu6fZQBme3uRSvXPxZO3HbPw90VYOqy8jy+9bQYnRoOq7
	rpX+CeIX7rW2dOWBrL4+gRz4RwoITjjahioqSCCqagX1XrVIXnVHsT/CdEVCAuoHDUOT9Pr26+g
	0UNwCdCx3lcKfNShJ2ypJovmNLDDYCifgDKhKH/pErwzobK3WIpN3GbCaMkoJYKl7oYd+Bo2K2Z
	WIcJOr2z2KuoVpf//JWZ1f6kxxfGI+t5x0cKzOFn15iUh2yVPHayb9FjVamIQFWS+pC5iGuuXcu
	8YIsyblqeEiTA0o3LaQo5QAIVVOP+qFbuLFNvKFLpocRxPqij/jtKQUkdJv0If8G/eQYyb+bdRy
	rxFOEEv002gs5U862GEsriael20ylOj6xIkrEZpFRpnk1hOnxaBzX1MJC+hsBAWNMMuHcuTrcVv
	ik5bgW9Ivobz2LkABeT5BX+vZiAU/23QyCU1FQE2b5/keEnN/SYiD8SfHKIG0kpDdWAwmEqfqwX
	z66fRNpdo24DjMv3hz0syUjWVQ5AU14ciXF3CwsB9TF5X0SHtwNWi234BcsGFsnFLBT92W15+9T
	sbXVlj7imcDnCf7+HpPZ5XKfWUvoMoFG/fJPawhh
X-Received: by 2002:a17:907:a909:b0:c46:7ec3:fde2 with SMTP id a640c23a62f3a-c50963777b8mr25764866b.11.1794513065501;
        Thu, 12 Nov 2026 11:51:05 -0800 (PST)
Received: from kordpc.lan ([2a13:e746:396c:c600::8fa])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b42782sm11727766b.38.2026.11.12.11.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 11:51:04 -0800 (PST)
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
Subject: [PATCH net v2 5/6] net: bcm4908_enet: unmap RX buffers on stop with their mapped size
Date: Thu, 12 Nov 2026 20:50:50 +0100
Message-ID: <20261112195051.597102-6-kudzo51@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261112195051.597102-1-kudzo51@gmail.com>
References: <20261112195051.597102-1-kudzo51@gmail.com>
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

Since the switch to build_skb() the RX buffers are mapped with
ENET_RX_BUF_DMA_SIZE and slot->len is no longer set for them, but
bcm4908_enet_dma_uninit() still unmaps them with slot->len. Use the
size they were mapped with.

Found by reading the code.

Fixes: 3a1cc23a75ab ("net: broadcom: bcm4908_enet: use build_skb()")
Signed-off-by: Kordian Chmielewski <kudzo51@gmail.com>
---
 drivers/net/ethernet/broadcom/bcm4908_enet.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bcm4908_enet.c b/drivers/net/ethernet/broadcom/bcm4908_enet.c
index 7f80e4e24..8ac749c44 100644
--- a/drivers/net/ethernet/broadcom/bcm4908_enet.c
+++ b/drivers/net/ethernet/broadcom/bcm4908_enet.c
@@ -333,7 +333,8 @@ static void bcm4908_enet_dma_uninit(struct bcm4908_enet *enet)
 		slot = &rx_ring->slots[i];
 		if (!slot->buf)
 			continue;
-		dma_unmap_single(dev, slot->dma_addr, slot->len, DMA_FROM_DEVICE);
+		dma_unmap_single(dev, slot->dma_addr, ENET_RX_BUF_DMA_SIZE,
+				 DMA_FROM_DEVICE);
 		skb_free_frag(slot->buf);
 		slot->buf = NULL;
 	}
-- 
2.56.0

