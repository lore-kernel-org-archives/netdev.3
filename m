Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794268637;
	b=VYMhwhIKZ/klvrkru+6TZ2GWf/X0k03QYIRvvtuwM6zCcCsTke8YigMBNsLfkg15Oaon
	 uuBaYe9WKGRtGwrVpdKy10Y/94RHBW5Ugv/x/EhadmqLnAXeJ7BgHKZjJWBzk3bjp1PuU
	 LMZEhu3FfY6qZR+HwneoNkt3BjtXAO2QDp5GtvObWUFFQPhJdg83K/Kcg4I9DAMJqdPLg
	 CJBHIAeFKirm+QTqrg3/2E9NbUSEUntZyuNOjqRdFZpxX9b23Y22o4bDX7e1xfLj2o/gd
	 BFZ+mtUrs1G3cL9zfyr4rwVSq3vPAugUOtVrQaQff1++KiJdTDC1lQg3ZMdoj/JKW6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794268637;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/ZB/vPr2FZoQD53j4mXH80SNVxv2c4eMTKKs+9xQEfc=;
	b=EohR91yAqUk5V7gOiqQVCi2bpJ3Y8Lvc2173g2PH79cvDpTVrAlWgx/xeqdxFnbWav6h
	 TLMY9nOPabFRnLQLys0grB9Md0c0Vg9kBgaMNhLSeKDTHPnMQLuifFn8sofgAfpJ0Lx7g
	 OoE69wKI9d6ENrpsJ3NTUp9at1kfsrHxjCbjpic3j/+WZoJqyXQmhZdfp1x23VwMnQhJA
	 ES2spn/s8iiDPCgYphOWC2Zxpo/5UOm7TNsy9J6ZZEMLOaa23AtMKna21lOFE7Rgmwzge
	 N6kD9t1MPK0lLgqLfGPZOvgcaOmJtRY17zoQ0I5M/wAPL2N2F6WiXkOzcKXRYyjWDjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P4xY8f9+;
	arc=none smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FAF60A3833
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 23:57:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18FAF60A3833
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P4xY8f9+
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c5049f267c9so43592066b.2
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 15:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794268634; x=1794873434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/ZB/vPr2FZoQD53j4mXH80SNVxv2c4eMTKKs+9xQEfc=;
        b=P4xY8f9+42UusvTWn3hlEAHq18vsf1pEJ4g7cBxH9lamOwOlfEwNFyya8J+PcDZJiv
         TP7hkoykehSdcnLFnEFjFln3P0LVYBMz55FVv+JWGgQpPjOht/lyNWVGtHTLhqed1dYM
         jshVInNlM+HdVFGC9F5C7Q5AuwWKU/VMSdIPExxmakQMRGo39jSY5ezho0FcwUOZds5W
         G4iOZWD339/E3VSqg1crq5jsu+hIJntvFUCNmti39NH1aqO0aAeidxR1U+zjuWwyLHwd
         P9BiYY6pCGmEgMZqrJoZrGjsWR1uJKt1GnigWQrDLSORIQJdBziOmIG1rc+C+EmK4Pm9
         sSFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794268634; x=1794873434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/ZB/vPr2FZoQD53j4mXH80SNVxv2c4eMTKKs+9xQEfc=;
        b=H8kVJ9mrLVjotejryY1xUnPqu4BJEy9FHJrBedS7oiPrzXK/eI5aYutrprwcZUtu2e
         3EdiH1ZhH4yDpVoTAOJ95FIteGU+mamNe8cpFR+CKIACNlHj8jZx8Mw7e7HcGy8JRUON
         KACFMb+xCpewH7mVSBEUic7S+lhFrmtR2476bmk2o9Tmp5eliw20HhU8Y2cBI55k/oZ0
         DfKYf/++mFMDSlOo+syJ00X4tLI7jpKRcSe5msOc1gcklgohaaRL6f/xIUm2psQ0qKGA
         9oROkwvBTaq7IvwakuALhZC9CVeFBlDRhN8yYW6SpZawPj0GHQc77IrRiIkL28fpEMJ0
         fjag==
X-Gm-Message-State: APuU4Z9vOgHa67W7a3gfT3j2sZZ9FMM9riX1b3DpYRifyvyAWE0hSqg0
	I5FWftD0Ke4k/k6SxQHKj/s9e12o7qm36S5QiaGTruCyJWyrqhfc98puB9nYnsr0
X-Gm-Gg: AYBFou3A+fIMVcOQihrPOr/2SmGh4wNkY7WOCluiOecUPo57BBPlrU7AfM6ve9wzNEs
	hsdqz3VbKtdCM5h0LKWm03rhxU7hBCfLDYvnlSLlKz5YNHuEZ9xyNcC4cbr8fKP8kBABJ+jE+Uh
	XWNiiZaQmSfDweFQZQl/kW1Xmj+TCLTamKaXQkTNQtenXM8KA5G6G1EHj/w4jEUMEXWBze9cnXi
	Orou/WiVfUs/NIQXxbCfOfrsILyoDGRdUOL/XaZI1esCKGRC9ofJjHiBk+T0b5dkcLVMj5fsvJt
	hiOzqpRkDBsxfYuqE4ZJWc6+591qzZsPCtXS1yW+Iha6ngmjxpbIWFDq8HwYd/VUPou7Yik1T06
	5/YB/NIfraux52sWBrgfcMNySsad/D4Q5PKOj0JvpMWwslC4Ak1Stf5npQw+v9TaZp38FpLSE8W
	U+PBd3GlRXWvN00RmqWiTv7B3Hpur+KkJ0zHJ2dbG6IZULQzLI8PLJOk7QajYOZTg2iKC6oBLp4
	c8di10eWrksqqXzb0a1U+zhOBD17pJlIr3ugmgSLLh3toaXtM6GHtIbvafn0aIP/UozGYG7fhe9
	33mFL2MNhCyft5jDYY8oW0A2Pomq1ONhLwrrdchMKSD3EJ3yvkjZbYI=
X-Received: by 2002:a17:906:4804:b0:c41:9228:baef with SMTP id a640c23a62f3a-c504952c10emr55099366b.8.1794268634080;
        Mon, 09 Nov 2026 15:57:14 -0800 (PST)
Received: from localhost.localdomain ([2a13:e746:396c:c600::8fa])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a56b772sm33725066b.16.2026.11.09.15.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 15:57:13 -0800 (PST)
From: "Kordian Chmielewski (mlody1212)" <kudzo51@gmail.com>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	bcm-kernel-feedback-list@broadcom.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 7/7] net: bcm4908_enet: drop RX frames longer than the buffer
Date: Tue, 10 Nov 2026 00:57:00 +0100
Message-ID: <20261109235700.2586821-8-kudzo51@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109235700.2586821-1-kudzo51@gmail.com>
References: <20261109235700.2586821-1-kudzo51@gmail.com>
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

poll_rx() takes the frame length from the DMA descriptor and passes it
to skb_put() unchecked, so a length larger than the buffer ends in
skb_over_panic() from the NAPI poll. It was seen on a BCM4908 with the
RX channel's MAX_BURST raised to 32, where the DMA reported a length of
3388 bytes, more than twice the size of the buffer; with the default
burst length it has not been seen. Drop such a frame like any other bad
one and count it as a length error.

Fixes: 4feffeadbcb2 ("net: broadcom: bcm4908enet: add BCM4908 controller driver")
Signed-off-by: Kordian Chmielewski (mlody1212) <kudzo51@gmail.com>
---
 drivers/net/ethernet/broadcom/bcm4908_enet.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bcm4908_enet.c b/drivers/net/ethernet/broadcom/bcm4908_enet.c
index ea4a9eb98..b2debdfa0 100644
--- a/drivers/net/ethernet/broadcom/bcm4908_enet.c
+++ b/drivers/net/ethernet/broadcom/bcm4908_enet.c
@@ -660,10 +660,13 @@ static int bcm4908_enet_poll_rx(struct napi_struct *napi, int weight)
 
 		len = (ctl & DMA_CTL_LEN_DESC_BUFLENGTH) >> DMA_CTL_LEN_DESC_BUFLENGTH_SHIFT;
 
-		if (len < ETH_ZLEN ||
+		/* A length past the buffer would make skb_put() panic the kernel */
+		if (len < ETH_ZLEN || len > ENET_RX_BUF_DMA_SIZE ||
 		    (ctl & (DMA_CTL_STATUS_SOP | DMA_CTL_STATUS_EOP)) != (DMA_CTL_STATUS_SOP | DMA_CTL_STATUS_EOP)) {
 			dma_unmap_single(dev, slot.dma_addr, ENET_RX_BUF_DMA_SIZE, DMA_FROM_DEVICE);
 			skb_free_frag(slot.buf);
+			if (len > ENET_RX_BUF_DMA_SIZE)
+				enet->netdev->stats.rx_length_errors++;
 			enet->netdev->stats.rx_dropped++;
 			break;
 		}
-- 
2.56.0

