Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794590034;
	b=b9KH8YjNRjKF+kkGIsf/Y/Yo7H6sOCPZ3Mrs6N6ub0zklyOFr2ZejXbcdKc5UB17tMDG
	 Q0lsAoYKyf4mwODADTe2K1x/OFQTA439rw1h0eKJEN3iNt8DoQhoFeG1kdeXckyygRIzY
	 l/D2o7aX1SL/F1ae9QEWY6IwyoPXCNKMWkDOKHkgIwvuuKk7siAyPaqNvjbS5iNDhufBW
	 YwoMV3t8kJ6X1cT0ZFz5Xmf77o7/OIA4cS+UV7zIahkqlF43ZpKC0ZmAyQxJNM3mS1g89
	 hRNAI5YEatLBiUx+qQ6ja+rcaU2ip3y9YLQXRehQt6pPqkpflYiowkiS1TW9mPiXS5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590034;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=WndszmS84HjiqSPdoUwyV3DcA5YhceFMCYMxOP4FTNE=;
	b=UnDCntB19IljXoCGzcQgUWtPi66Z+ziFzFy5TGRJDcmmb2PlJUwSyuyD+1q6kGjQrfaz
	 Xj1823H6+TLENikcqK+T0fleUBijiXjCQqwIemUF/CtwzeWifiIW15y0PlPQC3OijilJl
	 RGGkrL8CB8UpHffl3kpAIEiWtX7Zg/XTCMtjYvbemGUPyJvn8zGhJalIDFNBQ3vYeJvUu
	 0O1uUhNJvUtVS2Oc5P0p4Mm0FRA308zyyXaR2hfyxbe4CNT6K8e5wlPxpiQgDu2NwzZMy
	 mhNxlzQ/1kedDObFk5aER97TV/M2wANNfuTyFLbQ54mC0bW0oA8Anmr8IhEahDY7r5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=owj7+2Df;
	arc=none smtp.remote-ip=209.85.160.53
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D9060A6F70
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 17:13:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71D9060A6F70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=owj7+2Df
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-4a76f63b243so2397541fac.0
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 09:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794590033; x=1795194833; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WndszmS84HjiqSPdoUwyV3DcA5YhceFMCYMxOP4FTNE=;
        b=owj7+2Dfmf835bdocKPx6HgeCYJj9vwIXyQDR/lGwQ1CLivf1zCoPclGyvaaliEXf7
         doZuUw3CqjvjoT+sjaLe/AfyUbxwilBkB3/WtREIUsNDgVvAn34NakRs14M6E60jA6dz
         Yd4U+UJ1sgCsUBP8xbopnVcKQbH1icRkxm8wSHdai+Y/Szip9jixkL+fgoNEwE+iDNnv
         /cQu86hstYhkwQAZku2h5zZ7zGmE5PGYKNMgWaiJzAuofNkMLiMZlkWYcS4sgLaX9prN
         uHF/3BAHTE7JgfRVJxami4+iPZxUVXPW1OCu853ZX4DrqSMjss/arXLzKbw82fET5Bk5
         DQaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794590033; x=1795194833;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WndszmS84HjiqSPdoUwyV3DcA5YhceFMCYMxOP4FTNE=;
        b=zIqBfYZ/svv30BRIgBBKDec1rCdYJ7M0IrmIainnnONpWGirJGYohfe85l/Q0cEiuE
         PZ3Ci/BB0ttIB9lb0hD60zKPtIKPe7UaP0US3nan2lX0u/MYvJZD5Bd4oVRoSXJz326E
         6xQuk1P2WRQiuhNfqIN1QVZInIRWEvu34d7a8DYBYQNQTB2lKwxjsDqLRa3fPjlerkYG
         HsI2ATnrEw6eryiIdhrJFblqBKpiHY/xVWQQ9+T9ax7iFLUTDsOkeiQB1OeobrCYm6Fw
         BpDxz26hxZCy320eFIwoGlOWzKSdTHCpPv82Um8cMaHc+waxGeh6LbiITotiMLNU2e7u
         ugnQ==
X-Forwarded-Encrypted: i=1; AL+hErGJKVihcIREiO87Ao5j3jOABRaaYZ8uAUR7oPVEszbuV+COiznJGUBGdWbs2qF8B5mQTWGcDtg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Z76exkSTtck6+WKHZoNX9OKjaobg9uaUTMLBWP5MYVJlhK5MX
	w7iaunBfCntkxtfJ5LQ5pWCKAxq1DCik7mOxDYWkX7gjnHLaHxlKPcZbahSqooHV
X-Gm-Gg: AYBFou1WpCNavcL02eFsCV4RxKap3yB6XtUEjzx4b9aTk8ziy9k0UrS82/5WtNa+yFs
	MIEROUY+EF90blSxdu4Su5njfLmTYluRPfFrPlG8S0/LqRAw9CpnYoLwBI5zaASTifX57mnPO53
	S5mATh+5tUvcCsmJXjXVX6AqL7D6mJA80Bv+r4r5inTqLRdkibYpPLZhTaJbYAI3XXbksk37UkH
	qh0Hou2Ze9cKGv22LZ+dPkWSe5qrJRCZs3hoJHVJRJdInIiMbmkYx2U5rDIFHO9YPBrcMyo8V8g
	eVQkPoxaYlSATY2mxB013bbVPlQqXPqJO7q5GDCu7i4gpBBd+pInCNO4iOUDF8QMw7tBoR//XLX
	XK0+uif7zlSXdThiTFVRlLgCh2NNdIMygZjbMp2CKS/j5azgUGykFG9cErqDOp1/gykhnkiAyGl
	N/uXRfnzoLowj8x8H3twsTg3G7L8EvzHJ9q5tbLXYEzATnNZYAwc5lH6mleqVmYV/BhYj2Awnu2
	EgHS9xPOfjVyzCsH0g4mbBTbs4pwq611K/b0LVtMDTCamjXRL5OcojvyomepJe84OM0RK7dBKJ9
	J1UiW3wxc4fIjjsLYmLHwbuZbNes+S0HZAX1qg0biRlm4a/oCs1U+BxHP+hE4lLDfcagtTrT0SR
	iTWorV5mKJuYjn810vOMcYMqpHya6r6KrX0ciuCMmMOwcyfoDe51HwGEo7WgKy3UijWtMIpxodb
	LpxT5vH7FSN+YYaAl9RJdYI6sDknCSKTU4nRgo3F8k8pQs4zy/pVM63Q==
X-Received: by 2002:a05:6808:c3d2:b0:550:6056:aa66 with SMTP id 5614622812f47-56cd761c123mr4042742b6e.16.1794590033339;
        Fri, 13 Nov 2026 09:13:53 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56e7044690dsm2565805b6e.9.2026.11.13.09.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 09:13:51 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 13 Nov 2026 10:12:07 -0700
Subject: [PATCH net-next v4 3/3] net: phy: dp83tg720: report inclusive RX
 packet totals
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-submit-acx00-phy-stats-v1-v4-3-986b8a4a1871@gmail.com>
References: <20261113-submit-acx00-phy-stats-v1-v4-0-986b8a4a1871@gmail.com>
In-Reply-To: <20261113-submit-acx00-phy-stats-v1-v4-0-986b8a4a1871@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>, stable+noautosel@kernel.org
X-Mailer: b4 0.15.2

The DP83TG720S-Q1 datasheet describes PKT_STAT_4 and PKT_STAT_5
(0x063c and 0x063d) as the total received packet count, including packets
with errors. The driver currently reports this count through rx_packets,
which is defined as successfully received packets.

Report the accumulated count through rx_packets_total instead. This
exposes it as RxFramesTotal rather than RxFrames in the ethtool phydev
statistics group, matching the hardware counter's semantics.

Fixes: 677d895af1cc ("net: phy: dp83tg720: add statistics support")
Link: https://www.ti.com/lit/ds/symlink/dp83tg720s-q1.pdf
Cc: <stable+noautosel@kernel.org> # Requires the new PHY receive-total statistics API
Cc: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/phy/dp83tg720.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/dp83tg720.c b/drivers/net/phy/dp83tg720.c
index 807ff5525ecd..6c0c8c6007e6 100644
--- a/drivers/net/phy/dp83tg720.c
+++ b/drivers/net/phy/dp83tg720.c
@@ -309,7 +309,7 @@ static void dp83tg720_get_phy_stats(struct phy_device *phydev,
 
 	stats->tx_packets = priv->stats.tx_pkt_cnt;
 	stats->tx_errors = priv->stats.tx_err_pkt_cnt;
-	stats->rx_packets = priv->stats.rx_pkt_cnt;
+	stats->rx_packets_total = priv->stats.rx_pkt_cnt;
 	stats->rx_errors = priv->stats.rx_err_pkt_cnt;
 }
 

-- 
2.53.0

