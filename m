Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792527992;
	b=ppKhlzzPMHAni56Fl6m7Nrsw/8KmI25Le75oqpA1j2N5FzIHmtu38s9nBSBc174Nyqki
	 yuKYQklL/Lz+NJU3DyjCf7Dv/yTiX/GWCG/wM5VBCSkqvXWWTPAjaFaoj92+uiF9Gglun
	 wipIFM3RSo4xZ2wdvGjHCPiWDI5nRWAoqYZUsThmnxgXXMKDoW7rkTPGdOsk2+EUn5tZC
	 hprgyVNpW5HoqTEssqTnPMgXIlPCUu0mXtU2ML0SaFtfXXdbjlj5Z2SKKFFsqMXdJSb9S
	 b+44F4L87+s4V2x4aKMZtmfO4UxrbjH0HOx7Cr9yEFll0xUQDIwSGFh6YQVP5+4yzpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792527992;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8rjUyibfg+Fb7pOHgHKUgkDL1wyDBRIdMXVrklMIh2M=;
	b=YuLOhzghY/YClq/HqGqpsdDYhwRai6yx81IfyTg77E4U/Ce5tFsVxNM7JQseS0WED7c3
	 A4Ews4Ua+jbBkio9EX8yqPDDDFW/2oT3AMQL8svdyUBS3Z4Nt7gv4ZZu8T3RYMT/qcUbK
	 C44xqC+5lDqgGXLRzkvjjzStyTXZNvWh1b1dUhdVMhwuneKZ97opL2EXePN+dv9CA+cYg
	 5kjs9vSrYB7GN63UCj5m991KuG9nE7js4KWbUDGNZjzaIBC75S7bqNQur3CyWR8YlqGCq
	 IdFsctdVRhb9ipk0KECVh986U1yEeQFcGcwjHJ9QZF3QPFkFKcLpIDseIHEaXBbfUzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bDUhniMC;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA53606A31A
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 20:26:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5AA53606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bDUhniMC
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a021c809e3so116095e9.0
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 13:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792527990; x=1793132790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8rjUyibfg+Fb7pOHgHKUgkDL1wyDBRIdMXVrklMIh2M=;
        b=bDUhniMCk9VaZC4P1e4MZBeS6+Mf8v0Sfn6gz2lsOALe/xTYJoG+zRD7x2K1Tx3y0c
         DBi8h+nl+wyqK0cPe3qZ7MdZ/zOiAY28657CYzVbqx6qF7LD1nzMsW+f+OkXQX9OvOF3
         ZDJdyqZn85WM4iAcmESXI6neuaweZObtgil420tlRBF0GdqIAkTxWXbpVi1oWVRWv3z0
         iUPjDYf2oPi9Q+jaVczM/Fj90W2Sgt9kfyRZQ2TVFd6hoSx/wxdZ+xV+cZlnsvncliyH
         57pN6grjm1VMgQJKPYecqVj1eRSVjItnQtayxZiKxmFwhM/rZecOCkCahPUgzhMAZuFQ
         WZFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792527990; x=1793132790;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8rjUyibfg+Fb7pOHgHKUgkDL1wyDBRIdMXVrklMIh2M=;
        b=kES2w2C99k7BN5D1e7eSrQwNlvJWcmq3z5GGA0zpGC1eytssKNLvGQQ0i1HR19aS5D
         SaetukBtRpGU28joShzDkpXPuUvYJpsGoq5w7Tt7qSs9mWNOF0srZHuRiq5OGBV6noY9
         vJUONnzouC2+MzheXydhEWCifHdJMjvbobtnIW3Qwu0frlt8gMyV7qfaFdyR2Jbp7WFU
         i2h7HdBJ7EezBkvW/bq7YkoOILDPzAq0MesDRI5bpcmHMPYrKkv2idx7tMZ6QWkYXTXc
         RwVighdObw+6it/Ief1UImCNxYxjQEdhLHyExiIYPX9jNnceZbbAjQLlvwSHlZKcXQfY
         JjxA==
X-Forwarded-Encrypted: i=1; AKwUvBwmevTx/IG0UzL9Xl3cMuneTUq3czhKwPXf8pqwxMtkeK/hekUCL4GB6s8YpE06O9SmtICfvhA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJzKLfm0DceFCosVKEs0dCemAzhXvjFZTN48tJA3zFDawR6/jlV
	evK13qGawljJhRVW2pZdOu0n76JHwsP1ztRZpE3RnGOesLHb8kS7tyF5
X-Gm-Gg: AYBFou25O0yoxqljwf2zyn8bjMPGO7jvIif5UxMnI21vlBK7ydlidT6AG0YvZ1FPhWG
	19DKJKZydkxx338W1dZvyFBfOTDIcfJ2neq2WeweSxWqY/em/Cj0k4lYX1/fBoz5DMS15485pPA
	1JmtSYlJIT1a/3QJvFoSpj2yP2Ij8scR/GQL79643xQxEk/oiyxuVrLcKskrZaEJK3wPfl9CJfJ
	Xfy3I2IfBmAGpz9FYcDhgbG+08AHAAvLWrgfqHBdZ56HPHrtAj6kSHk0hT2XCFsQj2UQTWGvw15
	Z/Nbsb39JxCaov5R3dNU0iYt2N3qLc8FSmuFonVFvsDsJxijB/LG0E5ejsCcoxNIFFTpr7VARmj
	OmEIa3ebbZxI7VBIFVeZjNheziMQEGUgiWVLErRdrx6f9juD7WZRAH2Tl6jn156VORoyPWhpCVI
	JpGvUjHjT84IJiBuSrIlRZfsdTV7mCg8npEw1qStNBf9S4fpzGK9rDWU/DlQ2bWUzm8/xMYav+k
	dcxISXV2Fb9ftX51UjZ3M9DA5UqUBS4g2F4I00vlWc=
X-Received: by 2002:a05:600c:3f06:b0:4a1:7ba9:da2c with SMTP id 5b1f17b1804b1-4a1d760f7b9mr257835365e9.25.1792527989648;
        Tue, 20 Oct 2026 13:26:29 -0700 (PDT)
Received: from fedora.fritz.box ([93.93.22.191])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2d699dasm104991895e9.12.2026.10.20.13.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 13:26:29 -0700 (PDT)
From: Stefano Munari <stefanomunari.sm@gmail.com>
To: Thangaraj Samynathan <Thangaraj.S@microchip.com>
Cc: UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] net: usb: lan78xx: fix error handling in lan78xx_open()
Date: Tue, 20 Oct 2026 22:26:14 +0200
Message-ID: <20261020202614.30277-1-stefanomunari.sm@gmail.com>
X-Mailer: git-send-email 2.55.0
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

A failed interrupt URB submission leaves NAPI enabled and EVENT_DEV_OPEN
set. A subsequent open enables NAPI again, triggering BUG_ON() in
napi_enable().

Clear EVENT_DEV_OPEN and disable NAPI on the submission error path.

Reproduced using failslab on a Raspberry Pi 3 Model B+ (LAN7515).
With the fix, the injected allocation failure returns -ENOMEM and a
subsequent open succeeds. Verified connectivity with ping and SSH.

Fixes: e110bc825897 ("net: usb: lan78xx: Convert to PHYLINK for improved PHY and MAC management")
Signed-off-by: Stefano Munari <stefanomunari.sm@gmail.com>
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
---
Changes in v2:
- Move cleanup code in err_napi unwind label as suggested by Nicolai.
- Add Nicolai's Reviewed-by tag.

v1: https://lore.kernel.org/netdev/20261016000521.92868-1-stefanomunari.sm@gmail.com
---
 drivers/net/usb/lan78xx.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 5655941f1478..2fd1fd0cd565 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -3484,17 +3484,20 @@ static int lan78xx_open(struct net_device *net)
 		if (ret < 0) {
 			netif_err(dev, ifup, dev->net,
 				  "intr submit %d\n", ret);
-			goto done;
+			goto err_napi;
 		}
 	}
 
 	phylink_start(dev->phylink);
-
-done:
 	mutex_unlock(&dev->dev_mutex);
 
-	if (ret < 0)
-		usb_autopm_put_interface(dev->intf);
+	return 0;
+
+err_napi:
+	clear_bit(EVENT_DEV_OPEN, &dev->flags);
+	napi_disable(&dev->napi);
+	mutex_unlock(&dev->dev_mutex);
+	usb_autopm_put_interface(dev->intf);
 
 	return ret;
 }
-- 
2.55.0

