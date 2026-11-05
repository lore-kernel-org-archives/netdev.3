Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793907299;
	b=YQkD4vJNdw0uHNYp2BAUa6NG8ebQMNyBOsaY1Fvuz8+6rM1/MYtx9QKjoxj30iqjE9l6
	 A/22ARySrJ7WfmViT1or6Ygq0Xr8Gdk2kylvSkzezO9PuvILzhsEFW73mcw7dUXkD32sw
	 eZfaBZ1BA2B7w9VDenglbqK5r2hR2X5HhRWKtxpTszvr84LL5SBl+RyNAivtFZIYZr2Ky
	 I8BOenCz/UNQcLzxw3HoobAoaTrK3O1vipyHP7ODK6kRTthCtEv9nJS4mQzGm0k8Z6S7K
	 KCdVMOiwNrPQFDGo1Kx8R3gGdK2vIISUK+2ULKKbwChqkCBy00Q1aj8M22WktWZlfiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793907299;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FIPamNjyg5pldJb53DytGiQm4S1qvSpofPwo92Sk8fU=;
	b=ho74pr7BMfYVnamw0ijprje5LfHiWNSES+huaNFB1haTHgv/hbv59woZHIg871JR2nHq
	 Ius+LgIsHwrcrkLmuFXgSOUNDM+tQZCOgxwWvDF6NZtDnsjMfH0N3A3OplwqUoyfLfys/
	 ymNeugXeyIsOrSFLMvF4H0aUnVBPHKJ6a+xwIl9XmF/MgUETk4kZq+HaAvn1XyNkLSFXP
	 N0wyJxuBVVs6GTlaHx4pHsw5v7aM+qcC/MIDVMbPu/2QR2Od4FeDaheCe8sAezqw9VYDD
	 UywzwcF5jxe7/y2ukj3RcvOCUHbMXX0/sdlUYDketbXSjgGJDATTQaPYEUjC4FF2PeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HddFjLZ0;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41D8606D515
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 19:34:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D41D8606D515
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HddFjLZ0
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1adbf62dd31so3054926c88.0
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 11:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793907298; x=1794512098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FIPamNjyg5pldJb53DytGiQm4S1qvSpofPwo92Sk8fU=;
        b=HddFjLZ0joAH1TGB8j7WeybL0a5slle7Di2adqqb9AGZjlK9DWcfKRaPTh971V7efr
         KZQcjWW60p6WvsC2Ntgq1Rv6ZwKnhmI4yLIpiItnP0GoasFfLqOLIgR7f3oe3EmttkyQ
         yWN3StvUNA6SGqrXedBLJXBtejcATvmfqiVThqXexkxHZYaHEuNABQpFga+V3t4d3Iml
         LTY9U21M8KdbKQXSTOqGc1faZYnRScBw9YGY43k5MbR7WNcseNSaE+rFiqfrRK1W+NZA
         QeG0nsNvsoKpoeyMCpJgecmNKHXhfYnPLwy5glyBAEvRhkPLt9i9BfE9fwx6xTk+B/5L
         inLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793907298; x=1794512098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FIPamNjyg5pldJb53DytGiQm4S1qvSpofPwo92Sk8fU=;
        b=kptkTJy3h7hzU+tbo207yFPeUmWroazaH/IA/6wlfYovdnkLKXs83KUpqygBfS/AoL
         crrX0GlgQQgAvqKJjq7jXpztF0grqCFp48loJ7fwKr2ecPLPRymKvK1zDjS1JC7mNa84
         HWaizMkuxwzgUMLzXQMeChm7TGP2Zt4zRb2AOiEqKNL3C3XcDfLfTv4bHZkl2wgC4St/
         rVAQL5g3Y/FyvUT7TtqkQ3nUl48xfoqBWtnpTtmuHKIa8mQbBy8BV9pQPBIR6mZh+xwI
         i4MaU5d6U7pWu4J4rVJxvvAF7hVkTKcFko4XTJJ5vN3Uz/qJQgMmWkRTWOdjpJFZlmxh
         F40g==
X-Gm-Message-State: APuU4Z+EoFH55ILBkoNCk48n/8LSDjqE60FeNswZPNH7QpQKq5IMZNyQ
	96bf6UwgRDj3pTxo49waelBpIsmJk04z6haBpOzLJFldDgTsdQUZ5Mz54FXCdQ==
X-Gm-Gg: AYBFou1lUe69Jdr5k1yk4/mEZH3wMoe1pq0gJMbR+L/zPR3o8ZyZ2LldZ6IZ0bVttI4
	CBtAXH1G1x8QgMbtkcLYrTnsXaXRoymoqgnI1FrBmCIt0KM1/joG5QzRiKab3hiBf7lXBb45nte
	3RlbGnUY1Acg5BLn3YJDh1dMuh6fQcbwcO4mWZ7tdI8vk0k1d1LvnMCUqeztJi/m+qEmn2dFrBz
	Iv3bV1hDrzc0MYEfE2GvhcTKgBzawTfb3DXiThcnn1+w8IAgS6O4UHwCumyo9mY5IkElnRAb8QJ
	9hv5YmQqwwvjbOGF/H7cZP73LcgQbIJH1sTOs1LgcUB3jUYKKiXD7JdxBPsLj0CeLpd4QeR7IwM
	l0I4JYT8GWUGgU9wrhQm8kBAufkqIRUvaR+lODGq4VdmOusDJ4eDfy6BDxC98GNreXy0Cqj9CoI
	lKDeEnvKAGJbCd+b5HT9b4YD/XUXIXqjEpoL8NE10eGWL3H/fk4Lf4zimXf8yughXvTv069TEYc
	v+n4iojfK1s+ejugVZr3GGPL4AAr1d0iWV5dfDST/UDhJ1RDkt0yEicfOyrzhz1WahbA0XxOM2e
	ykYj0w71x2scVNXDK83CQhXn3e31kw==
X-Received: by 2002:a05:7022:3b81:b0:1ae:59d6:91cd with SMTP id a92af1059eb24-1ae59d694e9mr27788548c88.38.1793907297913;
        Thu, 05 Nov 2026 11:34:57 -0800 (PST)
Received: from eldorado ([2600:8802:b00:1f88::287])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c1c127sm18023186c88.6.2026.11.05.11.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 11:34:53 -0800 (PST)
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list),
	macro@orcam.me.uk
Subject: [PATCH net-next 2/3] net: sb1250-mac: Advertise and honor RX checksum offload
Date: Thu,  5 Nov 2026 11:34:34 -0800
Message-ID: <20261105193435.2050321-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105193435.2050321-1-f.fainelli@gmail.com>
References: <20261105193435.2050321-1-f.fainelli@gmail.com>
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

The driver already trusts hardware RX checksum status on supported
chip revisions, but does not advertise NETIF_F_RXCSUM. Consequently,
ethtool does not report the offload or allow it to be disabled.

Advertise RX checksum offload in hw_features and enable it by default
when the existing hardware revision check reports support. Test the
active feature bit in the receive path before marking a packet as
CHECKSUM_UNNECESSARY, so disabling RX checksum offload restores software
verification. Hardware can continue computing checksums while their
results are ignored.

BCM1250 pass 1 does not support the offload and retains the existing
software checksum behavior.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/broadcom/sb1250-mac.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/sb1250-mac.c b/drivers/net/ethernet/broadcom/sb1250-mac.c
index 1843b52e96f5..546415d3134c 100644
--- a/drivers/net/ethernet/broadcom/sb1250-mac.c
+++ b/drivers/net/ethernet/broadcom/sb1250-mac.c
@@ -1142,8 +1142,8 @@ static int sbdma_rx_process(struct sbmac_softc *sc, struct sbmacdma *d,
 				 * the kernel
 				 */
 				sb->protocol = eth_type_trans(sb,d->sbdma_eth->sbm_dev);
-				/* Check hw IPv4/TCP checksum if supported */
-				if (sc->rx_hw_checksum == ENABLE) {
+				/* Honor the RX checksum offload feature setting. */
+				if (dev->features & NETIF_F_RXCSUM) {
 					if (!((dsc->dscr_a) & M_DMA_ETHRX_BADIP4CS) &&
 					    !((dsc->dscr_a) & M_DMA_ETHRX_BADTCPCS)) {
 						sb->ip_summed = CHECKSUM_UNNECESSARY;
@@ -2214,6 +2214,10 @@ static int sbmac_init(struct platform_device *pldev, long long base)
 
 	/* This is needed for PASS2 for Rx H/W checksum feature */
 	sbmac_set_iphdr_offset(sc);
+	if (sc->rx_hw_checksum == ENABLE) {
+		dev->hw_features |= NETIF_F_RXCSUM;
+		dev->features |= NETIF_F_RXCSUM;
+	}
 
 	sc->mii_bus = mdiobus_alloc();
 	if (sc->mii_bus == NULL) {
-- 
2.53.0

