Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794060425;
	b=KEzlGIkmaUIWN2r8kLfYkHetwXgaw4odic7bjxgTRhbRKbz8Ni6NXwFEGXTF13TrN7YB
	 IrgMY8ecUh4EqwtQXlsyfmeqyTASYNODlPYIH2CgyXWQ924gUuij+k8ZWciiWsADSXbvH
	 SN0OWhYlQitxIYkgnTMjg7IHFGmqTCdZPuoJoA/cBNdAwLTs8fu3oJg3ATDbfHMNRT+xG
	 9nGVXJoGSwi1g11bXRE5A3TUh8VQ0q0Pxt0VoHlujmaZJIIH78rY19D4X2rvVPqDh4Pbz
	 +3yDs19vLdrsGh6SKui1br+j5XO4HuCLxvzucXT5d/hICje7XF4pM0HAqffrn0qRcPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794060425;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ngyvw7W1wldCSbIp2eT/kVHJ8HXnUw9pEjSsrIxeEVQ=;
	b=o1ScIhorh42WOOXBaX1XFhCQ0Rzl0IlPUgXlZ7LuRhLMxVK+UzTTdtuGNI+A0MnP0psy
	 tLx//yIC3/l3+5lryRXIRd6v0tPKpFUdZvCE58E9R/5ctIAvCxcEKyieXvljF8NDKGzvA
	 MH5AefZBiBvVfC2mfcbEcAkUQt4r5pLHF8bt+jUu0yoZ01xw4Elq3J1yZB6ui2CrJ0l/l
	 PNF7Vy5b+ODBrFQstVq7tO5JEI49BmzSUJJCb4f6QPWyrUM5vyAFycz3qdQ11TqnA4ANe
	 NgPrhG3egVUH5C3Q3e2WMJAr0+jx2mHjeVulv7XWzHhiZbP90Q487j56jnaWgVEo68Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d+KvkcLr;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1346E606A32C
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 14:07:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1346E606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d+KvkcLr
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-15ea896ddc8so2700763c88.0
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 06:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794060424; x=1794665224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ngyvw7W1wldCSbIp2eT/kVHJ8HXnUw9pEjSsrIxeEVQ=;
        b=d+KvkcLr03VEL/Dw8mCET7X/fPun7qHPwWG088o+U2t1dmqLcJuMjlgmXhQQtIWS9x
         yo1b+vPZ9d0v8CDFXjPpnhrbSzdkxTk3wEXDHNtfCdVZXJRF6O/Z2bLJ9Aaqv07K341Z
         AbmBU/pbPrXyQfdhaHa208u/2JvsBIzXiIb+DWxYQ4ABAJibl8JCoVvDFhSX9hfO5dvO
         5tZHLVtpBLoqncTkIiXM/l6u1oIiEAuMVdRV03PAalY0QVtlscJRXuq26S2PRydiVgp8
         e26BgBsUhMnASeEaLbSZKbi9HHZDzXFP6b2kM6yI6/V2XWId0gPBN4S+k9nFy1U560Sq
         ILow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794060424; x=1794665224;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ngyvw7W1wldCSbIp2eT/kVHJ8HXnUw9pEjSsrIxeEVQ=;
        b=LCvquIhXfRTfO7lVZkf+Ug7Cw5DK6P5pe0EzPzELqmVEeu+1T9igDX3nPY45ZD8ecJ
         JbaijxMC/a4l6JVHDsyX6L4GFc2foqyvnQD35itYZHWcaiL3l9xCs9WztA7RWKa6yfwv
         GOo0j9gjFOUWtpSgXWK/HW2JaO+8GblWyl7s3Zox1rmqOprf81pn6y3JO0I5LKI7BE3Z
         SQ7kgK4ZZOO1NmU4Dx+lhtGlY6TcUBkDNdc4vJ0dbRLDI6poi0PBVVLFH71JYMZ22xut
         ojVUGPg1hfW2DVO48ZDgvmMxD6ZLkfLZj+ra3Lr9Q6EyzP9tYXyiVD3pL0wr0Hq4AU2/
         EdXg==
X-Forwarded-Encrypted: i=1; AKwUvBxfuJvt1OOyZBWe3KtDvzm06foQ0TrPJeWEh2WdAGeznz/3/yrAJtDe821UIsik3F806hQvpYY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/oPa68ZUnndILNjZnZ/qccWWiulpEzwfIYiu6Ie7BBWYCU+pXn
	Baby2Dr0ghu4UXejcezfziBXtwK+KJaVRFEI+RrcjDDMfOyu92rTY9j5
X-Gm-Gg: AYBFou2VINNInhdwrmMAQyvCb2lErdGdOybJMLxqyhK3uAmnYd1N0JZP2bttAU8HWgK
	k7E0xebqvjdKmmAzJ29A8BBwovHVTGzzgIn2YkpvTKmQhjbBoyHykQckyvZ5jj4vUUPwGWcegk1
	VwBaEgV7PvVLeED5mq0WCeLLP4yq78nK9xpcEUbZl1HZ9u1Iet6rIVQp/C4TMF7wRLIQFOmGWnC
	ka8MAVf/zPGWOk9PH38fk4anwQXGQrIt2KoiHoiMMKeLHg1aiFn68JPpU46HLpnIpuuxwHSk+Cj
	Wk0s/fr5eKgUik4KVS6YKE2o6XH9cVELcmzbjgm/Rhb8lI69of1ZVs5ozn7QHA+U68E1CHSqyLE
	FAw88mFjyvT7prA47FoobWY04oSq6mem8qi5Yd7tX+htGguKELHju1fjV6slfZUmGmSuIEZt4nb
	SolnUOjkWzcIF+WwJWOnhMSSAuwLm5Dbz8jiVn9qhCnkMrMlxMERsxegozhINwBwwMXbVEOU803
	LIPLEWG33Ajtn4NiI7B5V63qZYqI7n7Zf0A23d5vyK9KYFvmkS9+9oPDaEQQDCb2EBdeagTek2y
	nODMaAF409qA5gl8ReSaUM6R0qYUC0DBHKjcA4zmbB5mrpYy
X-Received: by 2002:a05:7022:b056:10b0:167:4198:2cb3 with SMTP id a92af1059eb24-1b25d3083a7mr7690558c88.18.1794060423886;
        Sat, 07 Nov 2026 06:07:03 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa9fd0000sm14558756eec.21.2026.11.07.06.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 06:07:03 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] net: enc28j60: cancel deferred works on remove to avoid use-after-free
Date: Sat,  7 Nov 2026 23:06:49 +0900
Message-ID: <20261107140649.3702472-1-hj351016@gmail.com>
X-Mailer: git-send-email 2.43.0
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

From: Hyunjung Ko <hj351016@gmail.com>

enc28j60 defers work to three work_structs that dereference the driver
private data via container_of(): tx_work (queued from ndo_start_xmit),
setrx_work (from ndo_set_rx_mode) and restart_work (from ndo_tx_timeout).
They run on the system workqueue and are never cancelled.

enc28j60_remove() calls unregister_netdev(), then free_irq(), then
free_netdev(). unregister_netdev() brings the interface down so no new
work is scheduled, but it does not cancel a work that was already queued
from an xmit, rx-mode change or TX timeout shortly before the device went
down. priv is netdev_priv() memory and is freed by free_netdev(), so a
still-pending work then runs enc28j60_tx_work_handler() /
enc28j60_setrx_work_handler() / enc28j60_restart_work_handler() against
freed memory (use-after-free).

Cancel the three works after unregister_netdev() (which guarantees no new
scheduling) and before free_netdev(), while priv is still valid. The
handlers do not re-queue themselves or each other, so cancelling each once
is sufficient.

Found by static analysis and code review; not tested on real hardware
(needs an ENC28J60 SPI Ethernet device).

Fixes: 3ec9c11da033 ("add driver for enc28j60 ethernet chip")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
 drivers/net/ethernet/microchip/enc28j60.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/microchip/enc28j60.c b/drivers/net/ethernet/microchip/enc28j60.c
index d6c9491..5266912 100644
--- a/drivers/net/ethernet/microchip/enc28j60.c
+++ b/drivers/net/ethernet/microchip/enc28j60.c
@@ -1602,6 +1602,9 @@ static void enc28j60_remove(struct spi_device *spi)
 
 	unregister_netdev(priv->netdev);
 	free_irq(spi->irq, priv);
+	cancel_work_sync(&priv->tx_work);
+	cancel_work_sync(&priv->setrx_work);
+	cancel_work_sync(&priv->restart_work);
 	free_netdev(priv->netdev);
 }
 
-- 
2.43.0

