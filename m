Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794459204;
	b=TD5DU40RBc9td3EWBE2btZBIrplg8kCo6mlXJWCxZLuTGXq5kauONgB46uP2o/ZREu8Z
	 BsLA0SO/9nmu8/c34N3N2T91FwfrjzmOfdzHf+yoYMFOUOLklkw8ISZ6M/xMbUaygFOtS
	 eL9agUfCGWsoDtgAsa3qdD/CK+vT2ImMLWFoyVB5rXyraOcUH5SfVXiML4RZ+Ex3jsODu
	 DHgAPJi2h0+fN2lqsiI6T8ij2HDE89CLVGsb9kp7cixNVKBxUl0hz5slxJmX1GPuKpPx5
	 nzGz0XE4qbsqZvBG0VwFkM+5+RsDWmzeTjMqNoiPQlUU7222MhkEl1VGp44oObkP5BQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794459204;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Fq7eVjoo8xJhvVi6unc9XNet04qh3ukyVn0blU6xcQE=;
	b=5WpOrJg8j5vW+DRmEVgmUQ7YGLecPRn0s2LzzZX0+bzFTs3SlS7BFCw47qBKewnhHZ6f
	 HKwQyX+m5yzYTWPBrlVleHxWa2k3Vk3dydv8IwwF3fvlIxs6xR00LBqufHiqxhfLRUTHS
	 WeJ4x132wQwf678zrrriLGkHV0ug9COXUcab/Rurr2s+dZe6hslAxeUFTSfWNVH0Gair5
	 JVYaj6Zt2GdY3x7Bh0hMPGzutCRDRXvWYYp13j/1Dg8u4emJFlPs6HdpCIlZn5m6CWU1u
	 c87yEh9JBBfSFl/w4BO4Vyf7DIiHcbYXMe/NtCZGCCMos2q922elCCJKRoXmb0SKmhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iA+HoZy4;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FAF606A323
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 04:53:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74FAF606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iA+HoZy4
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-36eb1cb7aabso5851928eec.0
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 20:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794459204; x=1795064004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fq7eVjoo8xJhvVi6unc9XNet04qh3ukyVn0blU6xcQE=;
        b=iA+HoZy44jRRP+FrtcYQ+dzOjnHFESP0hqTtmIbHTcoAQIGHvpOXovN6NII6YUYUDr
         yU41ZxiDZA3rZbxrr8DM1Gq0MdfXLanv3G1khEWjTQLnvHzYiKeX5yqvm0vQ7IE7jFqo
         d+BOnbJc9TD3fCIojejExHFGjYv2sfzir4cc9tzPyAWUSQgtdVRll7YiHb9jhdSVbWhL
         kiVAjXCFvMtWrNwpIpmQ1k7BPnnq6hP+Ycaxx6SJ3P0ioFyX79m2zpafaAWWDQ8MW9em
         FMxBvtFiIZUxqFdhFxj4kJjyQZhNr42Fr2HftNPqJwXnApTEMv8CaS+TRSuQfkNAewdR
         ju4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794459204; x=1795064004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Fq7eVjoo8xJhvVi6unc9XNet04qh3ukyVn0blU6xcQE=;
        b=bMJzAXQEY7S+VGiv9LEOHYatfaup/xoWOpjhiRjrGdMIuDOH6kifgf4M+iJbtQ7jSd
         Rn03EHVvOV1eRfDVDkX9rvKygKrnkJfgg9PoiequsfsIKAAcVMI2xOODx2dCY0x9FYbh
         GwXiCQAc7j70nVe7QhzQJKFUlsesCUAblGPBH6+ecVVu76h0l46UZ/dl9sOA0VAkVJKY
         OM0IEcZzKzasQ8LfymroNmIrbWaw4rsIonmnKHRD9pDe97pU6kA83HiKrwUuSbdB79LE
         tNfb8l9begivriA8D51r+po+m1seRREstzBzysOMhAwfHObxkqxYNn6YXf9UO6ZLVy8W
         8BMg==
X-Gm-Message-State: APuU4Z/1B7jTR1Ni9aMIv8AYEniawlMSuOkPelU7e6Rhc0CIvEN0mdRF
	186BA/YHoGWM0Pw8rW1Nz4gD+3rMWGH/NZk7SX/bqGy2Hxlm5cBUYVlP94Praw==
X-Gm-Gg: AYBFou067mpJ1Y9Dkn+sseIYhG1C3a2eUOd/xDlIMjdnI32ivkoWlyzSMRyaEYbtx30
	n92hVf/0ezc3sBVukLSGiYJgKaYbE6EskhY9jo/7yKAIkFmmXQeMyPRZ3lllJvb4xyvLFLmuTNr
	xDR5m7k6cthaOUHoLoQ5dypRAP5pcIiNgnXrdRt2ZoXLxPLL8mYMctyJIH5h2HBde+aDKpZR3xF
	tw8C5w9ProKxguRZRxffAwiHjkQU9MP/HvqzMKYi2qPryKPlYrofnbsrzFMpTqAXz4jfOufBr0j
	b2DO4+RBXGxXjnryPoVRfYm2/Ob8FUm/hGf1jnKnJlNAsjRKO9vwMDiCfMyTV6f3cqzLsUk8s9+
	vxbZHsRZkfiDF+e2gov115iJY8khETy/1mt9T+RDesrExjJsHwb2WakEOdY1J/UGxSVpvNAUl2k
	0x+Wg9i7ibA+P/Bb4laPbJ2UJrqPWjKPHKLleusThHD60pQILeVwbCO6Nb80N9VmdkqdIb+q4IE
	ctm3xcSTPRQXoSGcaLzE/Q2IofKhq/0Y5dzzzzFyxVBkNtHs9xaJOaI7CDcO5tT4yOOSgPDbEya
	O6CU5yR5bXulwFTpg64D9S6iqhq8awo=
X-Received: by 2002:a05:7300:5410:b0:351:1bdb:e3b7 with SMTP id 5a478bee46e88-37686072206mr6620613eec.15.1794459203572;
        Wed, 11 Nov 2026 20:53:23 -0800 (PST)
Received: from eldorado ([2600:8802:b00:1f88::287])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520cfdfc6sm23921585eec.17.2026.11.11.20.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 20:53:16 -0800 (PST)
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
Subject: [PATCH net v2 01/12] net: au1000: recycle RX descriptors on allocation failure
Date: Wed, 11 Nov 2026 20:52:43 -0800
Message-ID: <20261112045301.3669532-2-f.fainelli@gmail.com>
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

An skb allocation failure retries the same completed descriptor forever
in hard IRQ context. Return the buffer to DMA and advance the ring even
when the packet must be dropped.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/amd/au1000_eth.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amd/au1000_eth.c b/drivers/net/ethernet/amd/au1000_eth.c
index 8682323d693f..cd25248f4e3a 100644
--- a/drivers/net/ethernet/amd/au1000_eth.c
+++ b/drivers/net/ethernet/amd/au1000_eth.c
@@ -788,7 +788,7 @@ static int au1000_rx(struct net_device *dev)
 			skb = netdev_alloc_skb(dev, frmlen + 2);
 			if (!skb) {
 				dev->stats.rx_dropped++;
-				continue;
+				goto next;
 			}
 			skb_reserve(skb, 2);	/* 16 byte IP header align */
 			skb_copy_to_linear_data(skb,
@@ -820,6 +820,7 @@ static int au1000_rx(struct net_device *dev)
 				pr_cont("\n");
 			}
 		}
+next:
 		prxd->buff_stat = lower_32_bits(pDB->dma_addr) | RX_DMA_ENABLE;
 		aup->rx_head = (aup->rx_head + 1) & (NUM_RX_DMA - 1);
 		wmb(); /* drain writebuffer */
-- 
2.53.0

