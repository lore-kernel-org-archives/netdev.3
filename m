Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793140316;
	b=aNlWUBvGrikahnQGZCvdFmGwzGvEBISzTEY1G8vRfB0T0HrIkyuMCESbuqAQm+2AtgE+
	 w1e7foDVQP/8XCdCBRfc60j18lRFGYSH48IiQK7tumJPIpzN+oo6tiAFYeD2zY1PIYHLK
	 oOITWPsnI6KZpBU5JBbpz/YO3LceL8A7P1x1fBKYaZerz1bUmsIYpwaUM8i4G+HzcL18s
	 pqb64JQqzwwj35TUgXtLx6WtmL4g7DbfX/7i+qSa/urceDUB4Xtydgl8Mi3UjffNiorMS
	 MMXr/DmxabWMZwFqjGRT1xxAMPSVUq7AL1wzKHPHDhiGUnpEK44SG1HnBMdklSxgv2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793140316;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Fq7eVjoo8xJhvVi6unc9XNet04qh3ukyVn0blU6xcQE=;
	b=xzwshasslYGfDes1LTQ+uaGiYDfZlwXigle0d13SbzLF9tpnP3d+7diDI9IC8YII21nO
	 ABLfGYvX97c6aX7oBeYeb+JwlhpgnBWvOTvi9HJt8jD5CJGPhpeEKnoQJ63XFfjJ20mAu
	 29m+dex07tQnceEan/CA8OgmDZ1vujVTRMY7ZlAIqO3uRGyzw86gCVIMUiaUWNe9yg7Cz
	 2TsIUf+3LzEzx/hCDH7lEclIBU71Iza1ikKF7WfZHzUGf6jbTDc4WMHJWwGE6Sz/5cl0D
	 c6TON0imbIycJTc5y0Vwvs83US2DxAtKHvAg9q6/3QYsQ+hty52zv+MnemBzsjxqe5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Mc7y6MPo;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EB1606A32E
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 22:31:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1EB1606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Mc7y6MPo
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-18cdcfc05ffso481777c88.1
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 15:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793140315; x=1793745115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fq7eVjoo8xJhvVi6unc9XNet04qh3ukyVn0blU6xcQE=;
        b=Mc7y6MPoCxLoMSH8hXPBCGQTPGIfVuD+bp9hGWdY/UwSmcCT0ZfwTo8AQVVE7FhLpD
         jKG/DJgiy8dhkv6kuzfCxOylDqFCVh2d7nQyCb5oAnA2F4FeD7ejbkZZx3OmJBfQX+F1
         xHR5vX3Gcu4xTEcSsd2icgJNPYM7tEoQ2yVarMebfopTULOqvE1zmO6YfU7tbCQ8M0vq
         BL9u/vhFWDkkSRCSt0Y06YSjox3C0EwZVU77iFu665GMGV3juyJauwV8Evf3MLgna/AP
         ugpek/HVNkTvLpCJBaEI1zOrvEHBnv0aSySDWXt86fmy2iUjd5VBPbXGl4kpsTt4YGpl
         Y6Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793140315; x=1793745115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Fq7eVjoo8xJhvVi6unc9XNet04qh3ukyVn0blU6xcQE=;
        b=p/8zN3iOik01Ll0k+/aQ6xb0HwvFIn4/VbiRcqq6pNdLGUfwT3TNsJB/5bGfZaUHSd
         RLBJ4sIYkxCHj1q4RCX7tl5oVIziAtRdhuj3uT3AQjlsHpBxekubEEiOaHND/DY/dx5J
         kEl1iWrdpEQg6iKwJmaU0dmkNGnhFYW5H0Xm9q7eUe7wAi74csHrJTvmQGHNu6b44Y8W
         flu9Gbr2wsAyYn50NsqS5pNRWOYvW1F7trCBypMJlS40vfw+e63oxn5q0zQ/WRY5PMAU
         CaCoEitkP3H1+0LcXlXiXCLpbCL55yZfqufhULqD2se/iQmAqSOsBM5J/qq3XJM3Rfk0
         7eQw==
X-Gm-Message-State: AFq9FYLd9Us3oy2jPi89742AxFgY0lSYNluEaNLdmNWJO61ZQs78OxEg
	DWGiF+wiL0wbOjCQiqE5TyJ/9R5iH8vJ376kDw+MYXnbNhgeedxWVus+zLc+tilI
X-Gm-Gg: AYBFou0ZK9L5Tn7z6yJaGYv3gD7yNDfmBg4uJV5YHkSrJV+E1LDP/0Q98N+bfzSmDL/
	cn7D+clkIobwWF5ZibKLjk0alC6/QJSUrQoW0k7Lt/xI8VvqfVvrUYLGAEhD3cZiX4Cn7D2R/0x
	ktNWYg+37XJ3d6MNZHZRCWO8XHnnPEuHMeZDu9AOVGkYHtr2fMn7Spn8FlyNlDt6unwCDzOdZNF
	GAUdO0b94LSwW07GlFjzVl0E+gdqS3FatyM7r80jDLmG33v/pGorRJhdq7uyC3WB6NMiX+NNRPt
	93ZGriuZK/Hu+cFMtXtdwugTKraqmpo1Jhb1y3H0S6oEd8iEnjdsHwM/BxWdlR17fHdzutbgxzD
	cUT3XM2J/+TkAYJIcomXZxTRcq4Ul8dQqDHW52cIiDQfh+bb4OmuLsDHEBJz+wtf/XmhovA9D3O
	vjhsOazR4Ofg0EDsOAbtq9pWo3ibYD/aAA777fxOWBJdeJ91AxRv1/vTvMMvshN6+1qCoVkRZFT
	MHihEE9NyWoIWby4y4+FKjTVgodYrExTYkbGZiHC3PW9r9HCPzWVeOrs9JNhIt73h7A2xMyBs1E
	XTOOyA==
X-Received: by 2002:a05:7022:f90a:b0:15a:4155:3d9d with SMTP id a92af1059eb24-1a6cd77adc3mr688552c88.31.1793140314586;
        Tue, 27 Oct 2026 15:31:54 -0700 (PDT)
Received: from eldorado (ip70-187-214-22.oc.oc.cox.net. [70.187.214.22])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a6d98c93d7sm1130735c88.13.2026.10.27.15.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 15:31:53 -0700 (PDT)
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
Subject: [PATCH net 01/11] net: au1000: recycle RX descriptors on allocation failure
Date: Tue, 27 Oct 2026 15:31:30 -0700
Message-ID: <20261027223140.3774570-2-f.fainelli@gmail.com>
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

