Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793785843;
	b=UEgA98a/t3S7TIhuO1tOXfPzsCqShg0qVb4d762P5EtPsuMMdbQl5ggHPiGBkI5QGDiv
	 IwvlqunOMK4hmHTk5RjVXiJoJL/WZjaBbcexLf5u7sRfyI/NOB3a69U+qp5v6n5po8xtR
	 RsKJ0qlyyi71tb+zrqc+yVp+IcWFwMRYjqiXX7tXpuufaAScVnFlwvZK4RRk+jJViCzxn
	 M8Z7jNB+S5+PgReqe4ywMJE9WlUuDk3K+SVUE+0mBjflTqOTdYMYOYutTwl2kCOpeEYck
	 lvt+uDqjyqADbvR3jWzB0Ea57eG6lL/iYYKWEiJLk8iQynktZdknN7sHmftO1bZm8bQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793785843;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zNfW+VUJF0t/3+CX7EtrU+2S6xxdGEBE7I0MZMIxTFs=;
	b=czWN3O/kuRTD3+fPLqttINlRZkla98ZL7J7zdr3t2GSQai9/cW3LOk3k6u/kWrnKpjYt
	 uFLZEp7xqfg8x8Xs9W2j4peCJ0bjqFQhUFjn9h/1NZn8nB67LbvpwZidrhGWZalg9DFBD
	 6e7+lm2ljqKgu2033BAUJNq0LoANDZaPx7pzTsQxpFwFZDc6xBrpulFwDnS4n52ylk8ji
	 2va5T1N6yJYU/5AlN1tOH/9r6OqXJD/kfaIcg5bHBSWcums+CjxLl37K5NPyIu0GxZsXY
	 HQpJ//VbP/jAtqZFxiArH619FiBdlY4Yjuj60KYTrf9LVmAllQ7NJb1n9rDlVc6BGcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JOYleaRz;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAB8606A328
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 09:50:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CAB8606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JOYleaRz
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a78ec32fadso1267105e9.3
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 01:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793785842; x=1794390642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zNfW+VUJF0t/3+CX7EtrU+2S6xxdGEBE7I0MZMIxTFs=;
        b=JOYleaRzRCMGCCSPpWiujWvbHrOAqCo3t07xXv5xIjkjLF1LjW5xOwDiaJc6Afoqvq
         welFpUsOJ/VCbThGCP+KBpIRWsB1mFiryLhdi5HK8BIqTFVdizDCKQNS4It381awpqlN
         VaC4WbxkMouPiCadLo2G/4EeK2pun+ZifJfn6SLfGArxIhbCYpxGBPaOSfLPPJ+LiXZS
         YoTZFwf/6YD+tgz0CPrp5wC8+ScKypn4+p32RpztwyRuBxK34a4p/gcrQHQmcVQEhZ1e
         8Dj4xJd83kydTZIQUvudfSsHmdDf2GC/pfk+o7cQv6Xxavx63SjXdkcKELsiFxDy1ni5
         9TxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793785842; x=1794390642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zNfW+VUJF0t/3+CX7EtrU+2S6xxdGEBE7I0MZMIxTFs=;
        b=K53ivTy1J2esJGRKvB2/is5zb7B7mKiHVQ31/LFy7hFd9TPdB6VPeFtM8upFGKxxlI
         09k+ClMapy/Okzoo5M5gWiV0MU+WIKy6qinKEaPgAuv3/fEC5kIDOFQaj7GjQG/FhWc7
         AKLybD1nkm4IF14nl5pB0yBzurUjdnArTNGSl3NuXBsoMCXV3v+gNP44Co0ZZ9WptnLf
         ed8fyQ+3cYhSuVyJf3hVfgs8Z2ga5qXPdrgIbM4mGac4j8ZLAm3Iw7MA3yCZTlwmFPEW
         3XcL/I9xrGPcpXOgwZu2ql9xUyZRHumT7j+7RaCGDLFEd7oxOZGSJi2/s0DqQuXqXejs
         KuBw==
X-Forwarded-Encrypted: i=1; AKwUvBygb1ntCLJ0bbpw2K6sKA4ZMtwAmtvFOvyMXnJ4snbyjL2IfZ8fruPjon3U532Fy/5woMKIKzI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+/jKjz3hiqEevvr6sxDkZkcX9+2DzhqBAOCArQU6j7GRXw2xuC
	V9aheIHn6XIVt6YW/4uEzbqSwgLq6yf6n+h86lea0jmbVZDKYvjVR8aC
X-Gm-Gg: AYBFou3MlX+K9ZQiR202Z+pGWlXmwAm4DYaI/MRAxX1ctEqrY/SnZdVvG8ZbuSxooGN
	1peIx+55l8T9ikFLEhpqa3/cxT6Rrkx/OI21XKkQnKdmwynkgOAhRvpxu3kV0u4d2QeqaF/la4/
	9NtOZQfoIBHNLueupdCU97dROB8tQ6VE+zkvZHEKldsx/ksYHTb+F7uQZNV46b3fj/vRzXVTZto
	+zM35xKbWLx7CXO0NDD6gmt4/JWHywBMmExftdM23iAiCpup9nPgZcCaQeO+CgJ1KvcxFB32HDv
	xWUl8cngjIgPjhxOQ+1U9JnpGTnskUju/N5evyKFjfq5xK3xRzgPRX1/xmiHW0xmXmWJKBHc7w8
	vCjLssCS7WKG/eUzVuiiCohxWbM1Tzjj3hcEa1FZmIZz6ITkeNsFwNFoIIVGTSRfi4RV+MowkL4
	Mi5xuFysQJGxOfgghSjKGaLbi/t36LSbeGRUxmvucAg21B3WBbKWuE315/+n+piRq6BEbLhjtbQ
	1uEOwB5bW/nJq0qZM35V3VPM6twPZF/6qlfejvVinq5oqdny7OCOzPnfETqYecqiv9w6o4bUoCQ
	xFAJNQZ+IM1P6JFQJtFmYs5dXHAmn2sKejt+MoAE9so12EmyEXRNaY46wkq5i3n92zerk4TnCmC
	EX9ixusNgLHYH9nYxFzjo94qFaWVR0oBMc4+ayuBk+A==
X-Received: by 2002:a05:600c:4897:b0:4ad:5ec2:d3b3 with SMTP id 5b1f17b1804b1-4ad5ec2d3e4mr182066725e9.1.1793785841611;
        Wed, 04 Nov 2026 01:50:41 -0800 (PST)
Received: from thomas-precision3591.paris.inria.fr (wifi-pro-83-006.paris.inria.fr. [128.93.83.6])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4b2a9faff90sm144655105e9.5.2026.11.04.01.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 01:50:41 -0800 (PST)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexandre Bounine <alexandre.bounine@idt.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] net: rionet: clear peer->res after releasing the outbound doorbell
Date: Wed,  4 Nov 2026 10:48:09 +0100
Message-ID: <20261104094811.19446-2-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.53.0
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

rionet_close() releases peer->res with rio_release_outb_dbell(), but
leaves peer->res set. rionet_remove_dev() can releases peer->res again.

Clear peer->res once it has been released.

This bug was found statically and is theoretical.

Fixes: 34ed2ebb65b0 ("rapidio/rionet: add locking into add/remove device")
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
 drivers/net/rionet.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/rionet.c b/drivers/net/rionet.c
index 64b5d0a8ae4a..f8a7a778f283 100644
--- a/drivers/net/rionet.c
+++ b/drivers/net/rionet.c
@@ -387,8 +387,10 @@ static int rionet_close(struct net_device *ndev)
 			rio_send_doorbell(peer->rdev, RIONET_DOORBELL_LEAVE);
 			nets[netid].active[peer->rdev->destid] = NULL;
 		}
-		if (peer->res)
+		if (peer->res) {
 			rio_release_outb_dbell(peer->rdev, peer->res);
+			peer->res = NULL;
+		}
 	}
 	spin_unlock_irqrestore(&nets[netid].lock, flags);
 
-- 
2.53.0

