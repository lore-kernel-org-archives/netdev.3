Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793140333;
	b=mujdtToeCEtmPzYviZ0Za2tnWLnGmOFvSRg3JHHI4XFI+yfD6KIY+9hnM/9TUiDrXrgS
	 PlwU6bMegZgxhPgdc2Vi4r0wSeOVh8H4EK0Jj2wxmtDZt+w1n5l1OFO25nMX4NsTrrztg
	 4FHJSgS0kkRklLAsTNRwm4tNjrOJ87bXXCstIYNIBUlOTFTp2uv7IfJtVzho5pP3eS7FO
	 RyggbrQS6DPfaWTVd2PKcJ9pg6NEru7srTaWFWQYD6j1IiIDmd+7bj/1NvRdtC0WgQFZv
	 F90pSjNhPbuxADse34dKY3Wfs6kZHixK46K1V0Bd/YOaomyHazF1ieGz3rAQMr2OFkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793140333;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vFxoxFWBOlhshfxwALIfxaK+Lb04zfCNYo+3DVPtQOA=;
	b=Klf+WvzUf1DpQGZGFrTojDBzBbvW6xKgqt3FYucUfvZSqcS5aJQ4149p8BtYdqB16Sz2
	 l8r6erRFu/ddnNGTOQ+EpdOleL0FldmynjJ4bRX0FSJu4Zccslouti/1kuA86LIESzJwo
	 VCjQ68ytL2hlSYdvLShxalreybMquFrlF0jqhNlrfmBG33+kDtAISmuCAtWaIHTRt4lcX
	 ZOZDZsVos2MNir1lS5Gt44x6dnjN1p1NqmQY9PXFDlTu40Irloia1jFuOpfbCRlS5G/sP
	 U5JotDy4NJm2PHVXgmhIudiifjBWyAJVSTm6HvHSkEvWeuTgOOqEl0/d45wkQcpX1ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0pS5BrSH;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89696606A325
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 22:32:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89696606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0pS5BrSH
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-14394530ec6so404855c88.1
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 15:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793140333; x=1793745133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vFxoxFWBOlhshfxwALIfxaK+Lb04zfCNYo+3DVPtQOA=;
        b=0pS5BrSHWg6OtG5b8mJ3ZzcWHFBUygIBnHkcF+py+PlavFQ+NNeaJx28AS0ig0jf8s
         iLs4SAUhObBEEEVRkbPMdnJRomFqb4ds5au43SOpoMh55KMRuD8L1xtg7sFuRI20JG/m
         zgZnf2fDEhq734UOYTl5Lq+HPkXIBLUbD3kGw+AObHJ/s2evtZb91+trHl0bMPZ47oso
         4jzuLg/GQ4XT7F+8iSZdclha93GExR4b+iyCGeFLh/uRSsuoNMZPq6CRwa5FeGEAhjUv
         wr2ZbBPAlTuqEoJXtz3PxHtU2L5nCFADmkKDN1ym8uU/e8OuS4adrbneGLmEBqPrX4Dm
         8ztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793140333; x=1793745133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vFxoxFWBOlhshfxwALIfxaK+Lb04zfCNYo+3DVPtQOA=;
        b=Ts7dFpY5fBbdtuKWgTAM/ZiN28SLmfsvcA5VUJGwYvbAUAaMCQiMpxT4HKS1CvO0/B
         ZnmjhXZvQwWosLYjCmMUEThQ19FWh41zcec3IRPxnUiPLyBdwmw4m5PzIjr9//qwxpIP
         hIhMqOiFyvyo+oehoP5vg+uoqpXASQx7n0DQmLJkzxp1CD1dAuW8g0OvjSKK6TWACaNB
         iUz2m58HuwBKvqhEaqKoNtqZy5RKxS53Y8RipVmawQJqncG3Sufxa3KiijC0JR/t9eQO
         cXibErfHEYwCM1nOaitvEWVa8jt0SSYj49558pdM78PQg6Rlr2mFRrilcDvv27zLkOAv
         Ys/w==
X-Gm-Message-State: AFq9FYIFUa5z2XoOoPvO86+HodhO56vFZal3K9ZD7DRCFb/Z6e8254rT
	WTNu1yBnxkXlWWyfh4t2f+I67CTSpFBKjSne/4NLmLF66P2Dira3IoVCkxYXKLVC
X-Gm-Gg: AYBFou1E0r22OmapC2VDrTt+fXUYoq1GIyz/0MCDTg8FkytR4HV7ImHNDxOX6La6UT1
	FvWu+LxnI66CVSPCPfnlhXvdAphWdlqYUBjdjBgM3S7zV6OxMVS1VuvBbzq3d/vqY75/Jphtd9o
	uO20OsGopQXaD85+QKCL+0j8BbEXoqc+29aHfrHP3u0s8JyvtAtHJ6T5iBBkcA5dKUt+psEjyr6
	LGiYnnL+fYKGmUzyKA1/d8YkF9ebkDmQzd7ERrYdKNzycYRJvpcFvAwFvJGFOmovvDkrK5osCnw
	7hu73+07j6E8oz9B7aKoU3+1LipTJX0vYOqofA6hOV5a0LC/cPzZ2Xa38W6PmmV6xc9f/42XZeA
	QC/S/a5XazWYRmF9tS5n6C53ysjCvDYeMsv8+KlaP/KYtTdu/Vs/6083/IyfJDuXY7usox8MHsD
	TcDGfSMU4NXvwX3I4A80PpFw/bAX6s8nmTcwVO/VPAAICsZ8q+oZmSWOYBZCmCImPzpbaF9wzrw
	cKZ9Qxqj7Rdq9k8/1aOO4Lb6R0bXx1MHDqTcAJOep+kS7OuqKFMKKQAu/KV3lf3zEOB6aFD1NcI
	TU2Gog==
X-Received: by 2002:a05:701b:4212:20b0:156:6676:d0e2 with SMTP id a92af1059eb24-1a6ced913fbmr775607c88.10.1793140332370;
        Tue, 27 Oct 2026 15:32:12 -0700 (PDT)
Received: from eldorado (ip70-187-214-22.oc.oc.cox.net. [70.187.214.22])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a6d98c93d7sm1130735c88.13.2026.10.27.15.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 15:32:10 -0700 (PDT)
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
Subject: [PATCH net 09/11] net: au1000: restore RX buffer addresses when restarting the MAC
Date: Tue, 27 Oct 2026 15:31:38 -0700
Message-ID: <20261027223140.3774570-10-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027223140.3774570-1-f.fainelli@gmail.com>
References: <20261027223140.3774570-1-f.fainelli@gmail.com>
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

The MAC DMA engine updates each receive descriptor's address as it
transfers data. Clearing the descriptor control bits during reset does
not restore the buffer's starting address.

au1000_init() only set RX_DMA_ENABLE on the address left in the
descriptor. After closing and reopening the interface, a receive could
therefore start partway through its buffer and overwrite memory beyond
the allocation.

Reload each RX descriptor from rx_db_inuse before enabling it, as the
receive completion path already does.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/amd/au1000_eth.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amd/au1000_eth.c b/drivers/net/ethernet/amd/au1000_eth.c
index 6b817d18329b..8c2dbf72652e 100644
--- a/drivers/net/ethernet/amd/au1000_eth.c
+++ b/drivers/net/ethernet/amd/au1000_eth.c
@@ -722,7 +722,8 @@ static int au1000_init(struct net_device *dev)
 
 
 	for (i = 0; i < NUM_RX_DMA; i++)
-		aup->rx_dma_ring[i]->buff_stat |= RX_DMA_ENABLE;
+		writel(lower_32_bits(aup->rx_db_inuse[i]->dma_addr) |
+		       RX_DMA_ENABLE, &aup->rx_dma_ring[i]->buff_stat);
 
 	wmb(); /* drain writebuffer */
 
-- 
2.53.0

