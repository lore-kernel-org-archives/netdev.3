Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794390788;
	b=JTl87YAadoP5ffBHXTeycP56DTRo/3Ch6Sca7QNV/YDDP0HwFUXr7wrT77cfO8cU2YP3
	 y5Za3rp24i6FDrPcmyV9F/Ryu1CoN5KkOhan14M68sevV97Uu2mh1CU9zgccwknbJnv+i
	 2RgHuFXWCkTzMQJKZXE/pmpclQDTt4iEScDIZCgTjT64UiPfCdNn7puyz9PRXqPzASb+c
	 hFlCeDO3KYxbf3QAnsKhwYvBg1kDs5UCexh58tswFx7ZLRqjiWA9cJ/Mt633seipUMhly
	 MwaglZWPTVvn2UTWfwx5TrQlcjzd1XoL/XmLbF5r8mY418kog0U2S8WO8AlZz38+tXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794390788;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1OpQaokwsZd+EP/gZa6oq3QOJAqakPc+BtVDgkSa06E=;
	b=j0L6wlQ5bs4Vr0nIEskUR26EOoViQ92gUi1B29KLpH1MMfRVK1xqKTAzf2OgL+x88AR7
	 WQx7WFbVQV06OLxHTIwCjVht5Jv0U0NXrOx6FGdqwOLZQnuIh0lCBgBWGdaga0vbghPL2
	 MRYVe07CkOSGvqxipR1ZWQ/Wi5S5G4cNnhDp9eUxqLRf3ryjEj6QvbwvwvJstPGgb8GSy
	 bOxs3DBU9iF7oWvazcTsKRNpj/ehDDTkDB+X87v5/Hb3xz1Cd6tAe/0/4Eb0/FRYEOzGr
	 lA5lFDA4gkmUxzcz92Fx/BtOPaTwIHn/2G/7VyqvvSbwmbdLgkybKllfz+DnOIOKknQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QM3jvUhq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B457760A2634;
	Wed, 11 Nov 2026 09:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QM3jvUhq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B6611F00A06;
	Wed, 11 Nov 2026 09:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794390788;
	bh=1OpQaokwsZd+EP/gZa6oq3QOJAqakPc+BtVDgkSa06E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QM3jvUhqqJme0UNb7iifUxF+dUAX3ppWHgI+wnedSvwyCS5Ncm0+F7G3BY2TEht3y
	 O2gpheBKWOjL/8r6KLhJ8lEkMcuGfatMpKXAbKDu/t38qXDxlMWrbNWHBmbJfhHJfH
	 /hswm7fZT44kyzIkkZzU2O/103zTue9oigkrLqnm+vGyKO6M5fgltVbcrR08zedhwO
	 LIITz4aaQOUSjcgN7oRkzTQRYnvp4HAv+2m4DdJkzo+mNsHlna9KwbdeDb3O1FUsEr
	 u8vtYdZYphijRNgnVdK7G82rSJ9nO7ck4CKnEk5k/QlF+DTH5nA+XCD3FfyqAT0TMT
	 FRuONH1nuQpjQ==
From: Imre Kaloz <kaloz@kernel.org>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/2] net: sgi: ioc3-eth: fall back to the platform MAC address
Date: Wed, 11 Nov 2026 10:51:38 +0100
Message-ID: <20261111095138.1757-3-kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261111095138.1757-1-kaloz@kernel.org>
References: <20261111095138.1757-1-kaloz@kernel.org>
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

The IOC3 on Fuel's system board has no MAC PROM on its 1-wire bus, so
ioc3eth_get_mac_addr() cannot succeed there and the probe defers for
ever. Ask eth_platform_get_mac_address() before deferring, so a platform
that knows the address can supply it. Once deferred probing gives up
with neither source answering, use a random address.

Signed-off-by: Imre Kaloz <kaloz@kernel.org>
---
Previously posted as 38/53 of the IP35 series v2: https://lore.kernel.org/all/cover.1791890466.git.kaloz@kernel.org/

 drivers/net/ethernet/sgi/ioc3-eth.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/sgi/ioc3-eth.c b/drivers/net/ethernet/sgi/ioc3-eth.c
index 25139cf5ff62..5296614bf3fb 100644
--- a/drivers/net/ethernet/sgi/ioc3-eth.c
+++ b/drivers/net/ethernet/sgi/ioc3-eth.c
@@ -847,6 +847,7 @@ static int ioc3eth_probe(struct platform_device *pdev)
 {
 	u32 sw_physid1, sw_physid2, vendor, model, rev;
 	struct ioc3_private *ip;
+	bool random_mac = false;
 	struct net_device *dev;
 	struct resource *regs;
 	u8 mac_addr[6];
@@ -857,9 +858,16 @@ static int ioc3eth_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Invalid resource\n");
 		return -EINVAL;
 	}
-	/* get mac addr from one wire prom */
-	if (ioc3eth_get_mac_addr(regs, mac_addr))
-		return -EPROBE_DEFER; /* not available yet */
+	/* get mac addr from one wire prom, or from the platform */
+	if (ioc3eth_get_mac_addr(regs, mac_addr) &&
+	    eth_platform_get_mac_address(&pdev->dev, mac_addr)) {
+		err = driver_deferred_probe_check_state(&pdev->dev);
+		if (err == -EPROBE_DEFER)
+			return err; /* not available yet */
+
+		dev_warn(&pdev->dev, "no MAC address, using a random one\n");
+		random_mac = true;
+	}
 
 	dev = alloc_etherdev(sizeof(struct ioc3_private));
 	if (!dev)
@@ -938,7 +946,10 @@ static int ioc3eth_probe(struct platform_device *pdev)
 
 	ioc3_mii_start(ip);
 	ioc3_ssram_disc(ip);
-	eth_hw_addr_set(dev, mac_addr);
+	if (random_mac)
+		eth_hw_addr_random(dev);
+	else
+		eth_hw_addr_set(dev, mac_addr);
 
 	/* The IOC3-specific entries in the device structure. */
 	dev->watchdog_timeo	= 5 * HZ;
-- 
2.47.3

