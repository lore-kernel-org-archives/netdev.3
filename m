Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983541DFFD
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 00:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792109136; cv=none; b=Pt+t+GnwOsTZck3X4bvMsgKPPOfNdfu/LXRVdIEfJne3RUmvyFUq+iNN82D4PZjiaDP1oryYKsSpb/1pEic0ttTrl9IezIo7a8xmd+JsRMs6ovLK6revqa4omTKUKuLxckFGTX9hR+S4a85tnMs4eNOQYJq9iLOlRDUiO1ugB6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792109136; c=relaxed/simple;
	bh=fPRYypa44znrNavChK57m+Ydl3AyDgbMBifU9YzFMLU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vwv9v+lGwir8Lk7C3K1iKfq2MCAbKbNFLhGzsiRtBIOdMyS/kRl9ORqWEJ6cBlEmqLuFghBlMbenlt3kI14Bv0Am+N2JVtALOU3q+6dyNQ0b0qGCCUvstSpiWD2u/Uh3wbP2kvjXmJY7sBUvGYwDU0IdF92xLcYoe+LcKVd7DC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rScwL5k5; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rScwL5k5"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a018792ab3so46552585e9.0
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 17:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792109134; x=1792713934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UnhsvI9MzVbrWhzAeYwgCkKjH6CfXVlO8VeDcgUlxMk=;
        b=rScwL5k5O6KZT1xUuakOfKTXFJWr+OAjf8bQ8GsWjMa4D8l3XuFAzK3ywr6S7ER0g4
         hw5cKkAhLWyypo3HS8444/rvHwgbanQDCjQtMRb1Sfpg47ArO6hWtTMWGEV08v94vzMc
         qwbyUJz7/GgOmqHapRdvrEDirTx2GdWy5D9PDrXYB6cE2Kq6oS/FFfYJFk1XdKfGRKF4
         pr5QELEyQ0xWdd2g/zbRhBV6v9lWfL6IhcIZsqsr5Qx+eXucI8MVITTOEWUh/2MqB6qf
         5UGc2zYHC+B8dusJZUZspdAv4HwTUCa5wYSKjpZl1QIvu9raRQTuqBgRJqy6+E32Fwe6
         NGwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792109134; x=1792713934;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UnhsvI9MzVbrWhzAeYwgCkKjH6CfXVlO8VeDcgUlxMk=;
        b=f7hZM09hTfIF6jJEbNu6exZj9xHWg//B1YmVD/iQBnH0hCt5OwLy7ZYdgn5NW0UE+Q
         B2LNp6+pQpu0WZ8vmF3sy3jiW5JyeHUTQIZZh29TDvqsY0vHTMK62LvyapfQoFBokr11
         KuvpX+OCahz3ULNzLUMp6un3U2YFfgT4Wbbrv2H1nvqtolQiT/o0WPZB2hOocmWJw3xi
         otMXR7GR9pK6uc1kHXblwtavboO3QnZhb9cJLtM9EZ6VcXkw87u75nKAmd8GOLLJZgpg
         FrX4+go9MG+yIWYYwN2uCRUQbfeKQvn/3qbE3dhhERH4/qEJU0rN0b/8VOD3WAcJJFmp
         Nytg==
X-Forwarded-Encrypted: i=1; AKwUvBzq/2peFAakV1te1dyej51bQ5ve/w3XY5/R1VsUcJgLfS2sDPf6ADfbsP8jxc46lKe9n0CnCyw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKLM0wFx7RUzYWHC4jHSjKUScOjJzkDqoZZRo/q/dYMOfPPF9nR
	1rXNFsO39tjhMIFmirz+J8fky0dgICOSZ5L6IMxbnR7bgg7UaaTFvSx1
X-Gm-Gg: AYBFou1k+71yKImP9XvolsEJAegCOs8DlN61O5jE/DAjGYG9L271ng9UhbPpfOo3gfz
	BaTFTblm6XBOc0pj+cBqmanxUjPSm19XG2iNAvaLviP7HZSC2cQp52abqRXZ+FSm0Vs+9IY37IZ
	PsuJjHK7zOD8gUTziHuhAkZ58NbefGYQoPxBU51V9jMsU6FsdmdqjZVpG9nz5x1+RWRhCExgeXW
	DJRic8wNiPDiNdxxFU+lY6nIKI/gKnbqv0xScRNkz1Zz4Tb0u63iGy/qnuk6WnMUTubM5/WBrJk
	A2oc5mnPxDKM1zkvfeb3Jl7O1TZmAwC+cxbUjgvV4xtj4XpJ18OJv179Rq+SJVPMeC5CLklqAV6
	e3OxKoyCxj+xIa2bODRX73twFaLOfwGIEDGNyMHKe69BnJ3SdNrklJKIoUEPX9NRwOLF49RV63d
	1JKo/CnjEvVJTjGlk3U2gsJH9V6Kze83cRQ1bZXJ45mudvPgyTiNN+lK2WTldGKzE5Nu5o2+zdR
	IG57F6oncyRuC/kfBiBOSJs9P3pNJFwliSX+ONfX2bJGJ++YK15ww==
X-Received: by 2002:a05:600c:4747:b0:4a1:88de:9e8b with SMTP id 5b1f17b1804b1-4a18e49d65dmr411113445e9.5.1792109133763;
        Thu, 15 Oct 2026 17:05:33 -0700 (PDT)
Received: from fedora.fritz.box ([93.93.22.191])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4f8d1esm1315821f8f.39.2026.10.15.17.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 17:05:32 -0700 (PDT)
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
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: usb: lan78xx: fix error handling in lan78xx_open()
Date: Fri, 16 Oct 2026 02:05:21 +0200
Message-ID: <20261016000521.92868-1-stefanomunari.sm@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
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
---
 drivers/net/usb/lan78xx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 5655941f1478..6a95934bb3d3 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -3484,6 +3484,8 @@ static int lan78xx_open(struct net_device *net)
 		if (ret < 0) {
 			netif_err(dev, ifup, dev->net,
 				  "intr submit %d\n", ret);
+			clear_bit(EVENT_DEV_OPEN, &dev->flags);
+			napi_disable(&dev->napi);
 			goto done;
 		}
 	}
-- 
2.55.0

