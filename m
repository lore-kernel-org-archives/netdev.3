Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794614342;
	b=w74EPh7MgUqzRPZNJcodGfB3hscPwERnswvP4LSAdJ8E8WZ77n+3LbEE8pzREJXHkuQJ
	 qaL+IU0AR/tdKMPLhp64RUPJfzF/GXdYC2zEQo20bQkHdK0OxDa2j/OcF2TNgfyp4pdHf
	 +oac627fA9cDm8s8wh27BfJPfBKJyzGhQwgKPv9CIqq9GitmlJ+PjwjsgkHNzZCaFm4Hc
	 oWoLdSAJr57Oc9VyTpw8ocq7XDbpSMA0IEdP3pQ01eDdmXaZdWUJwUdUEbaXScFI4aZoY
	 1jgRqj9m8CMTopV5OeZ16ud4gP0UoHg39oirUaqPTl0xbrpx+81n4/zNY4VgjQ7rvCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794614342;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3Y34gjrCf1/M8nt0B/F1aUTr5s9mtv5S2XS9OA+DkLI=;
	b=o9c3D6NLE5oZ81/ASru4+HMUofs1HWS8US8sFLyLc5Rvh3zbZhpHyfijMKZ2b2hCyvEi
	 gvhAmzg0/YX4RCzoCnSneBY+aNleshrsMu7D7nfNCH7w0Y+WUExjHimEPM+Ld0s/KpYe8
	 qOsJN06yGMoXZDJ9WjqrRgXDe4vh6F7ORY/1McKZH2Yq1SaYeFE6+RY0cF4WRC7MQfWpT
	 BBk3zFDQMPC3LCIHuQlzCQMLoziCcFXBMpExw78pm4F9ivIdsEwfq1QiU5XUW99Z4LFfN
	 mEATssRiM8F5LcKp187yFYr6xBgdDWKi8qAPEPnthBxJDHZ7AF8QwwYvFvZKDEwgb2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j98LLVL7;
	arc=none smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA54606A332
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 23:59:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CA54606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j98LLVL7
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c50aaad19fbso85094066b.0
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 15:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794614339; x=1795219139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3Y34gjrCf1/M8nt0B/F1aUTr5s9mtv5S2XS9OA+DkLI=;
        b=j98LLVL7Bger13mwxy+RIduMv5CvRdYzEFv1VIx3U66oUFXRZWXDTshuxUo2ymJYC0
         c9mtAA1yhWm1trTEBiJcm//l7uq6Bhwjz0i/w/ZXtt5kg+MPsQU+S/3RVgNYh8MZbpED
         p7AALQrnD2xjkeHwWawtkYLo2DXJO2xm5n5Il9VMwn2ElfYSIRbg853fsVPFBSi3IcVK
         QVQW/LODLe6ZrXrYSCElLBNTAdAgpe8mOohE3gwiOJArbcTwFpM94901+CS37YPiG86X
         E8y/DApyidI2jBZLE2+TwSDUsp2eDgGLUJq/S1ur5AQbCH6VuE7rgw/8uC4bLnlxgZPP
         ALFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794614339; x=1795219139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3Y34gjrCf1/M8nt0B/F1aUTr5s9mtv5S2XS9OA+DkLI=;
        b=zwI3cjAdapuNrr26vNKKE3yySjheJb0+Bl2xxvg7UQo1arb57svZW6c9GpRENWTSs6
         1JiixPeCOkwcH7i/lbFGOTVytEub9nUZIvclWJIjmslmm5V/m2dOIGPV6u9h5I7SERWo
         IHzMW70Gw6LabRwlonqoag7x5s/38sLA/Z6qMcXHgeIojSPEpFWUCIBqXorspT7rnlY/
         yKHWc+00Sm56xiKFoDa2yzWCG6i2SSuVpCY8pRySRk6jcbtOfE59boXdJIjKCJRnuwoS
         HTlECaMS/jbPpukdPVaN3WRnyVy6F12sN/fFd7Zw20LirfiDeLpn/7+/B+tpFQgKXYSn
         b+0Q==
X-Gm-Message-State: APuU4Z/3HPCPzd6J6zDxoIJK0hoUX2/MpuL8EeP3ny9VYt4TMfQikQ1P
	4cxdOkXvPNK5tnikcr9YBCc+V5XMK3TnliM4zn9+ZAk8VMVfcPGu4HeLHWFK62FF
X-Gm-Gg: AYBFou1G1xkUlfEJzVH6N5mLSxaYgaDVf0ZQ47iDHObz99XfVnZodhpFCU/g7TMUT0k
	DcqB5M8FSxnXFq70s8T9eV0PJX4StOUk0PnAdoTMQMUGaN2bkGwcljGuSPL2qiOxEtyT3rSO0dk
	LTwUw89O6Ycugr45/PcJvMzV73BelC6tZBySpzTztHJcYBnhNIEEBundjuid0tB8jeTuHJ7Qgpj
	TsZLh84uCbrDt+L0YMDS8o+ZNtNmzfhfYpfCUECYVwjwwsWab/eA8tJ+4ClPqnbzdJTkxvdnDfz
	A9Jrw2vWu5wpBPXO96xnwK8tMPdnNVaZ8+n6LV1wOhX6TTh3wmWkcmEPwxxlZgh8H79jkARSm5o
	Vx6fX/ynd0RorBh+5yWnTeDpnRjKIgF8eG11PRtkq9l1hq7Gn/lyYD4a/EieBDkePuACCVnKVrV
	7ST7i/hif+8XX68Kv1wXAV3ggoeS76wGh58oftCI2+tOACTTlJ3APOdUeLTINc6S2cNjeaMK7RC
	lyZ71nfI91GFGRIRBGJ5rLQMGj9xsanoui69OEYkf5fk7FzHfypxsSAf4I+p22qqalOAqxE4dqI
	yDedMGOGeUxv8gaq5M0lli+GKsRpUUDVZOAq30hs
X-Received: by 2002:a17:907:a08a:b0:c4c:b545:f29d with SMTP id a640c23a62f3a-c5096545652mr356912566b.36.1794614338993;
        Fri, 13 Nov 2026 15:58:58 -0800 (PST)
Received: from kordpc.lan ([2a13:e746:396c:c600::8f9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b3dbaesm153454266b.32.2026.11.13.15.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 15:58:58 -0800 (PST)
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
Subject: [PATCH net v3 5/7] net: bcm4908_enet: unmap RX buffers on stop with their mapped size
Date: Sat, 14 Nov 2026 00:58:45 +0100
Message-ID: <20261113235847.517308-6-kudzo51@gmail.com>
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

Since the switch to build_skb() the RX buffers are mapped with
ENET_RX_BUF_DMA_SIZE and slot->len is no longer set for them, but
bcm4908_enet_dma_uninit() still unmaps them with slot->len. Use the
size they were mapped with.

Found by reading the code.

Fixes: 3a1cc23a75ab ("net: broadcom: bcm4908_enet: use build_skb()")
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Kordian Chmielewski <kudzo51@gmail.com>
---
 drivers/net/ethernet/broadcom/bcm4908_enet.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bcm4908_enet.c b/drivers/net/ethernet/broadcom/bcm4908_enet.c
index 03de65d9b..4065769da 100644
--- a/drivers/net/ethernet/broadcom/bcm4908_enet.c
+++ b/drivers/net/ethernet/broadcom/bcm4908_enet.c
@@ -334,7 +334,8 @@ static void bcm4908_enet_dma_uninit(struct bcm4908_enet *enet)
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
2.56.1

