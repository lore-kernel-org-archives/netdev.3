Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793295086;
	b=K3E4p2P3+hkCqMjR0BoVjrzEbhqHiPj1o8czKivWXc3Qj5lbir+O5SEURDpz7HaqwUkN
	 H8aqsfvz/7PGe+QDi84EszAPkegxfrqguePjnw2lPWnR0U/BbL1JZIh8G50u9yS+WO38F
	 p/3j4M+ODG9nK29ua7jtq0i/6FyXopVE+/X0EDuChSQIys1skVA93bx8FANh0qY6dquPR
	 a4P7zDVvuYr3WYILHnaa8t9tW+rAsOLDOH0iKewF5THX7U+EdRf62y2m8lO1MWosWKYWn
	 xsZ3ETzBLncrKWGgNoq0B//IfZHEv/C7l2jzWPhJt2aDX86EP7jQRpelGcPWMgsFaFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793295086;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=hSIslHYAdaXfJ/6/15cY4EI+1/izn+/DHEzPa9wprnI=;
	b=rFKZ4GdoAdBx2sryDIPuldEerZLnC2ZA9h1SIPBNEtuJpt8nTJB/WwCDcBIXNybsqa0z
	 l1S+XFVddyzqAMBLp3bnv2lIjEtlBXHlADl1DU4C1u60DCWW3nNt9FZyAIyMKoMfwydJC
	 inf3w8kIkD5vQl5Owvbf7GZE/sdASdJhzVtd9fRqxXdE/ZUY6yTqdJqadpPzKO4HjHphU
	 MsW7j2ulDsxEf1Qu4HB6sZu1reOxMf59D6gb2X4MWSSeOnG/kOjxKD1pmIvokDO5ZjM7p
	 4U+KgsaOIxpHQWhZnh4uJ0vH4Swe9wGdrg/UG/dg2gvlZ4xxTbEm33aUYDTDlOS60+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JY8XJOEJ;
	arc=none smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2012D606A320
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 17:31:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2012D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JY8XJOEJ
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8a06b436dffso1185635b3a.3
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 10:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793295085; x=1793899885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hSIslHYAdaXfJ/6/15cY4EI+1/izn+/DHEzPa9wprnI=;
        b=JY8XJOEJuBC9fU+YlQNtGGQzPiI9s6gIriGR0T0B4hin0I8UONoZaXa56WnmqfAMex
         hmZ0TD1lJiySUIahM1XZEXp5CayPU1NRxOTxb0YDx6wc5FD7BbSGvRpsR/ktDd8PqwkL
         a+n3VtSUlWOhrOPNgMIlz2ESzcFOmrkD594nd5nJmAqvjy8sKBTCM3VIrjmTg7LOiUKZ
         HRGYc7sVDjcpR7hnlrj6n6RpFuI0FtuvkHAnw9mz2BzW7sm7N8hLbyMG5cptezEEcQbx
         dSLGVn6LJROEVC7DcytCgpW673b81ntFsbKzgALbA1oS3AedMgeq1Ehn82aKRZ3/eDFs
         DnAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793295085; x=1793899885;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hSIslHYAdaXfJ/6/15cY4EI+1/izn+/DHEzPa9wprnI=;
        b=Yseei5hVNO9/A31awXDgq6S3YzX9joA8MeIGs6n8Hvk823VPH6Qt+36dGzltlLD6PF
         tj/a6pCHNCdqL/5sEU+KI0pQYZuGASHhwlfxu3DzOElBfbX/Teb0Poxe+4uyTHSHr/9k
         mc7MCz5XJrCtBccmlT9QwXZhw6LRFAcC1zXlFJoJH9i1bbd/cYdYTeJZrrgeoJ264AYW
         WP7LVjkFQRewwZ7fOubRgMST7oJsuA7xszsg3r+kJBz76Uo58V9+M18AC7KthO1JwXWD
         LovDJrLB7FWwoK/MWZbMZOV1ZTNb+VWlsz2FXSkOHy+fzvXf4pueHZxXx9xlsh0Apkp6
         3PQA==
X-Gm-Message-State: AFq9FYJ/zgLXhY7q4xGLA1ENHHM/WcB/+tszzovJ5dzSecge5qTcIOLY
	hj+17EQaOO6CaJ2Ibc9zTq6h4mkt+G8y0PiW/rYdNwaFfAMlaMhDJx3+YuMSSw==
X-Gm-Gg: AYBFou38rt/ptDQz78dQjBuqCKzvHs8SJQpIhrnYgGZriMWwytQxFC+YtnklxkptpW8
	xSofu7T9TkJv3QEfQE2AGBAe+RbdnJ6nybWR7IQAzJng2hKHevd4BOMnNpkEs8ZTJAIpvH9kMPn
	GdFSWrs75KeEIeP+/GMR4NrLKfNOyUOGadtgPvFRm7zJJyAIYSQ4wV25R7j8rmosN0pLVpwlZto
	kW0hTy5b+s6hYekH5RjT5IQPqXYgKrIi1r9uUUfI0hNb7VpDJY/gyOL3anF2xavKOg6RodKTNhK
	Zv/Wd8o/AuvGA5Fy+lc0NsjUeLBickzBA2xlHEGZ5NGY3JAD5nekWw/mQET3rmPFR5XJm4RyXIl
	6MdPK3YZ+dBpJAWHvsU3cRWSf3jOvMtVhs3RpsivbnRg0kdPkO3HcQ/2Zp5a67FED1tWUOR8JBd
	i1flMhKdE41TY2rm4BxhkvFZ1/w2MUYUvZUxuhzTNo5u9iOzEGjp/ex5FWS4W+1TZ7gMqBpp93b
	gR+cUE6hu7VeI7Xrgamc4Bz4L8R9uVzfa9mAyfjSSlT1//iRnhcFAOzfq7IJ/E1GeGfsF39sh9o
	MHOAvo1HE7TFYVLiNNPQkWRYY6k1O1wisZQOX48tE1vM/Okc45I05aoirvCVHiHNNgHbnkpUueZ
	ozaDlLBSBCjm5p+ZVsHBOfnLVVrp43BmKYfEly36/Sw24cWhqUZj1Hmf1wiLRlMF1DDoACqbRhS
	hKNg==
X-Received: by 2002:a05:6a20:431b:b0:3e2:7c10:d482 with SMTP id adf61e73a8af0-3e9022f304amr5613114637.16.1793295085422;
        Thu, 29 Oct 2026 10:31:25 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:37f::e34])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb0548fa57sm94180a12.13.2026.10.29.10.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 10:31:23 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Felix Fietkau <nbd@openwrt.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v3] net: bgmac: fix RX frame length check
Date: Thu, 29 Oct 2026 10:31:22 -0700
Message-ID: <20261029173122.29636-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.56.0
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

While reviewing commit 77dac783f113
("net: bgmac: rate limit RX error messages"), Florian spotted that the RX
length sanity check compares the length reported in the RX header against
BGMAC_RX_ALLOC_SIZE. That is the size of the whole fragment, including the
space reserved for struct skb_shared_info. The data area handed to the
hardware is only BGMAC_RX_BUF_SIZE bytes, and the frame starts
BGMAC_RX_FRAME_OFFSET bytes into it, so at most BGMAC_RX_MAX_FRAME_SIZE
bytes of a frame fit in one RX buffer.

A corrupted length between those two limits passes the check, and the
following skb_put() runs past the skb tailroom and calls
skb_over_panic() instead of dropping the frame.

The check has no lower bound either. A length below ETH_FCS_LEN wraps
when the FCS is subtracted, so skb_put() asks for almost 64 KiB and hits
the same skb_over_panic(). A length that leaves less than an Ethernet
header makes eth_type_trans() parse bytes the hardware never wrote.

Reject lengths below ETH_HLEN + ETH_FCS_LEN or above
BGMAC_RX_MAX_FRAME_SIZE, and print the bad length.

Only compile tested. Not tested on hardware.

Fixes: 6a6c708469c9 ("bgmac: add check for oversized packets")
Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 v3: add a lower bound
 v2: replace Suggested-by with description.
 drivers/net/ethernet/broadcom/bgmac.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bgmac.c b/drivers/net/ethernet/broadcom/bgmac.c
index 669eb7ce7d40..b5e1d3c0003d 100644
--- a/drivers/net/ethernet/broadcom/bgmac.c
+++ b/drivers/net/ethernet/broadcom/bgmac.c
@@ -460,10 +460,11 @@ static int bgmac_dma_rx_read(struct bgmac *bgmac, struct bgmac_dma_ring *ring,
 				break;
 			}
 
-			if (len > BGMAC_RX_ALLOC_SIZE) {
+			if (len < ETH_HLEN + ETH_FCS_LEN ||
+			    len > BGMAC_RX_MAX_FRAME_SIZE) {
 				if (net_ratelimit())
-					netdev_err(bgmac->net_dev, "Found oversized packet at slot %d, DMA issue!\n",
-						   ring->start);
+					netdev_err(bgmac->net_dev, "Found packet with invalid length %u at slot %d, DMA issue!\n",
+						   len, ring->start);
 				put_page(virt_to_head_page(buf));
 				bgmac->net_dev->stats.rx_length_errors++;
 				bgmac->net_dev->stats.rx_errors++;
-- 
2.56.0

