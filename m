Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794354329;
	b=LyzEihi92InI0lXxa7NcZIhI3PeM//VvU4t+PeVYq+6Lbr6nCmr+Hq/Z9ZUYpdmQAW16
	 XMkswyr1eVyDt9AvIaQhb6pjZ+r9ZKdT819kv/MLQ4kF3xkYNh89Mx7EBZ9nwENysXOos
	 VEETBhK0aVaNS2N1ebrFhmdwrc1EFplg3w3DI8CGdC6x1vWKURtWJgubTXSUYUu7wJqYn
	 owOKjoT5glBnKfiuQRTKVNUGguQIx95K/P/OF2PUFzfschjMNlXs/nRFHNV36YVM3eWag
	 0DH4nbvOect7Cxa0ejAFgKj8yTgMmysX+s4y3HYD/9SnfOO6L92TTFTE1B3fyh0KNOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794354329;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=bGKhvAV64lYKBnioTN7Ad3y0fCfdTBsU5Ol09e8bJr0=;
	b=PJtl1vFZ03BA+5aIHAk1loTPB1/k6LwD8r05ysFo+UpkiZ4NM4GnJ9P6VKTl/9HdTGAZ
	 PwXKwvDmXx7QU3hUsef8TFxt7csODvJaKJCORlwcjaKTJMQGTueX4qJAnSFkeeBNjvB/o
	 Wn81eqV9P6BsFfNTllyEnyQQXCcgZ+cOqdtNQ0snxwBIgfuXPyFo00qOxRlDchkRHQ06w
	 yLqJYANn/KWGN1TRRkWBbug26TvtQdPsoaCCqjXVSiNgqIssQ7u57ckTSbd2wRkYHDKfk
	 DCub/OjbinJb0KU59VtiBAHxajqm8YEpGs3HsCXO3d73CLyu5SO/ouxmpt8aIvW6sqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=taU06AUQ;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1446E606A336
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 23:45:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1446E606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=taU06AUQ
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1a3c08d6928so4480656c88.0
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 15:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794354328; x=1794959128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bGKhvAV64lYKBnioTN7Ad3y0fCfdTBsU5Ol09e8bJr0=;
        b=taU06AUQNkNNZa8NoYSxfpCz8XAtyB5Zy50NRQIOM/w+85xfumIDnx6iTHwN6iOsni
         lOn/Phf1uYdUNZbbyjxnc8JtBhN8ckCkK1r5EAqJJuTVZRyLJXIWHBRrY2MYJNr9Z51+
         zMjDnitG5zCD4sBRtiTgaAM/d7zo38Nz9TuVVd2Ogrfx1tR8+JWGDuzTViDQImVxM8DM
         uVbb8SecuGpCGb4gKaynM2/Qk6D/DF4Aoo/l+Q6YtrgPNM4rklP/gkoCgFXcWyvmskvt
         +rPe5CTGv1sFs12Rly2hl+KksNq2LDAMB2JJeysPdsV5g1r7fg1JTh+wXxnPx5mISSc1
         XjPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794354328; x=1794959128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bGKhvAV64lYKBnioTN7Ad3y0fCfdTBsU5Ol09e8bJr0=;
        b=YOyYpQyvnaGVu6aKxHwD8uouLqlvG8rH7b30RoTlRIxFzfZ/v1EncY3p3h1s/AEGfA
         1DvnYWrbFenuugH5SZxUVl81qpf0/PdT2AMbuXvNZUZBYqmAh+RwMW8ZQbci94WlCzg3
         ppuHPKiLJHxS0F7GUhFeqjk641YomuWiLqcxo9QgIXI6g8WePsAs/uDB/ekfWwFdU5x5
         tq0E7grdwY+xLV4TrX1Sqcm3ZsDgqLpMZPDMegyWOXFTYsGKt/r382z7bvTvktyb33mV
         iUr3ck5n5p/DHmEvfQebjcF0S9UoCF4tpbgGQbYo0CIllBfTbqPX0m+8DaZmn6nN6OFp
         G41w==
X-Gm-Message-State: APuU4Z9I7roCoT+JXG1MnWZEHca6G+fMU8l1PoSl13ytmq3l46/btFj3
	q7OU6AuFNXyp36N2RSGqu92myr6EMIiMMaIV6HZA3RriRgbywxCRCtnnet5q0A==
X-Gm-Gg: AYBFou0daXBpKzVkZ4zms22BJXNUIHNWoKuZrfcm2/pPvWbaDQQXA1VXCKLPVzOesn9
	aSiix9nHMJAc+PDuHCySQyK0rMVZXGvAr27f1C554VTOrEJ7Mjw1yjrnsu6W7gLVodkZPEn5/23
	8IXtSQwmg2cISz6xmCAEImkH4YAFCAbUpIZEssm1A0Eca19XLB2v1213ZvJ32CljnF/NwwX/L+w
	vXNOOyeZZvWGDCv3jBQo9Ik7BTxybbPTuygoGrwyoPnXqHqwwIRhpb682H9e0yP0EOaiCOqIWwL
	f6G7B2kj8AZ8thS5CItMkWRNF1La4zQGaq7JPGPXHovp3FX2zRf+Zme8wjRDS1rWYCVwI+A7Db1
	DY/2U+oCrrLA5OQsaGJ+AWU23LwkTDxI8Fq8Vjobxi3QtfxbMNZrzmsZN4G1t5xf1AUQ2sn/wHV
	n0nKh7XcSgaWiNCS+URpFDL/o/hQuEfOzxc9GVtICzVsM6aB6rk9vPt9bcgYdsnNUCxaJWGRfGQ
	6+vWKuVc/P7C8BhAI984xYRI2lNwbFHP9Re2T+zBshU1mBjTtQBQyT5kx0NseK8fT0jPoV0h2cv
	EaqWLpkN
X-Received: by 2002:a05:701b:4591:10b0:1ab:6b10:461 with SMTP id a92af1059eb24-1b3c0376279mr534103c88.45.1794354327884;
        Tue, 10 Nov 2026 15:45:27 -0800 (PST)
Received: from eldorado ([2600:8802:b00:1f88::287])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b20c55sm9145881c88.8.2026.11.10.15.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 15:45:27 -0800 (PST)
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Daniel Machon <daniel.machon@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v2 1/4] net: sb1250-mac: Add ethtool link settings support
Date: Tue, 10 Nov 2026 15:02:57 -0800
Message-ID: <20261110230300.2769327-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110230300.2769327-1-f.fainelli@gmail.com>
References: <20261110230300.2769327-1-f.fainelli@gmail.com>
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

The driver connects to its PHY through phylib, but does not provide
ethtool operations. As a result, ethtool cannot report or configure the
link settings.

Use the phylib get_link_ksettings and set_link_ksettings helpers, and
provide ethtool_op_get_link for carrier reporting. The helpers return
-ENODEV when the PHY is not attached, as the driver attaches it when
the interface is opened and disconnects it when the interface is closed.

Acked-by: Maciej W. Rozycki <macro@orcam.me.uk>
Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/broadcom/sb1250-mac.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/sb1250-mac.c b/drivers/net/ethernet/broadcom/sb1250-mac.c
index c839dd9804d3..1843b52e96f5 100644
--- a/drivers/net/ethernet/broadcom/sb1250-mac.c
+++ b/drivers/net/ethernet/broadcom/sb1250-mac.c
@@ -2128,6 +2128,12 @@ static void sbmac_setmulti(struct sbmac_softc *sc)
 	}
 }
 
+static const struct ethtool_ops sbmac_ethtool_ops = {
+	.get_link		= ethtool_op_get_link,
+	.get_link_ksettings	= phy_ethtool_get_link_ksettings,
+	.set_link_ksettings	= phy_ethtool_set_link_ksettings,
+};
+
 static const struct net_device_ops sbmac_netdev_ops = {
 	.ndo_open		= sbmac_open,
 	.ndo_stop		= sbmac_close,
@@ -2197,6 +2203,7 @@ static int sbmac_init(struct platform_device *pldev, long long base)
 	spin_lock_init(&(sc->sbm_lock));
 
 	dev->netdev_ops = &sbmac_netdev_ops;
+	dev->ethtool_ops = &sbmac_ethtool_ops;
 	dev->watchdog_timeo = TX_TIMEOUT;
 	dev->min_mtu = 0;
 	dev->max_mtu = ENET_PACKET_SIZE;
-- 
2.53.0

