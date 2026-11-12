Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794459249;
	b=YbmvdY3+DWx/Xx1UdJuWGkHxpnnS48zUD4D/SdyzZvrMMiQ3rhwS7NPUEqzPKzMrg6gc
	 DMpXF9J3Ab4ppLPB01i5d+w6T3m3BlIG1d8D/7SvKRH1H/A2MHUtHOjN16PUN1rTxoGT8
	 gRfcynbgQw91lAgIZQKKvw42zMKEeXXzSmIAXy9R+vHuy8MOwe/emziY948YvNKQ2gICl
	 MadS7Fwu6CfknlJ7OPcBHZXPfUQJzvLgPf2GJK75keKNTOTDGtXilMiPsOqFzeA6LuywI
	 OyVMyGKCCct84pqnKdx+t5dOtY1HKUn09S9aWHvE7gaxQSYasN2u6WftCx18Ldwpyng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794459249;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dqIx5LsR/HwfztDB85RdaApxnUG5lE8MuIP3HnTqRgI=;
	b=uLihxRhlQH8cRNJsnr2P5B8QXIHs2JlodnDwUlltJm1XQKiBjln3YfxbnpCet7eMQmaP
	 kddo7MRAeny2VbOdxK0Re73/m/jDAZ/3dBlwRAPe6fpD85zRCaOxJbEArPEssFTxV2Xsh
	 D3noWiN3Y87SO3oTA/oz/2pAtVEaRqlEEdzw3gjl5OGNuFQH3qQuRPlUn7h9ve6oYJlRn
	 kURT1867VrH/Ou2YZmVkC5VF1ql2gsylfeys0cIMJJVdKmtcP2YQCNcJvMkjBu0tShvvR
	 6augsil9rYTHk2S+jtH+3hEMeJwxrOoqY6JSKKPW5YesaBAewMbOq2JU0o1VNxKXvdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0ZUoeEYu;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B6C606A334
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 04:54:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78B6C606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0ZUoeEYu
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-36e795af1d4so421006eec.1
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 20:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794459249; x=1795064049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dqIx5LsR/HwfztDB85RdaApxnUG5lE8MuIP3HnTqRgI=;
        b=0ZUoeEYu64A5AK4Aikilw/mQmQdbSE1csS/sNAEQhiIEeLfVnhuPd6kDp440TTmIoX
         9f1NpWflM/niuQZZ+psr9+Gad4GHhL6iavkyugBfVreov3EvFvjj8Jh4kQS1C5fVoFW1
         h+q251hIdgubq2qORguRE/e088v35YX65KRqK/a3JWxfB9YAcD/PG9ecxYf94ehkqUKy
         RmIgMQSaZSI25N0mMoYbAW0YC3HLZN3KaMbHrW865GdVLx23EiLX2BhN7A7gBUtzq+mO
         FSOdsuianyvie4wKGzcjHjE14F7+7k08knn0MiG8BozmrG2ANGTRVnueM/2pu4+DdvM8
         Rw/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794459249; x=1795064049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dqIx5LsR/HwfztDB85RdaApxnUG5lE8MuIP3HnTqRgI=;
        b=gH9E/h/J19PcQUNkncn/ZIejT/owr5nZpP+VHl0WVBWUuoOdhLXxIXNp9gczssM8qY
         iBhVKnYhBmwVB/2n1zGmoWMaWqkn98eK7eRL9gfBzIC4fQ6GHOzQA7Jpdyl9c29FYT4c
         HLb/K0boM0rkK7WjHP3/DionU8NUt5JL63Z7n1JBfQ9ZjuU/zq6Won+YqWPsgaIi5jI7
         KXaIz3t3WBHbMvWEDWaBm+zJbmNTQTZ29Nk2I+rNrPYTCEa+sLN+R4TQQy8KqvRHiNE5
         Sh8Cd/snf4J1qHthEl4JeLD8juSXyLXQ0uVXiYOEixh05fkKWjsIljJz5xeEOwJB0A0E
         LSYg==
X-Gm-Message-State: APuU4Z9yA7c8vTnyVltAE1X5QMRhf6qtIbMX1E3u2ODjv8sEgwA4w7GV
	/h2EjQGkLJrvgoMlT4Yi43gZcemjIinWEX2p8kMUAYSFONyTU4Mlg0CLg0Sx2Q==
X-Gm-Gg: AYBFou2U1rzalPOjrIm16CF0jQ2lnUNa9YUvyZquEKH07JNc7nDDU4kFIi3jqVUkZzd
	01l+KqOHBq6dFhTIEWZPTRQ1bzwHeqynjJRRStrkYx49nAU3J4DIGaBxhoLp0EoSEVb0IzMvjtQ
	X62vaYnv867c2BiGTP7CwP8LGLsKG40Cb30E0q32OV9iF4bSKzW2Cc5aHRaGeKJ+5bOnDEru3UE
	q9s4fjl/b9q9NajHcqfDqAH3fk6P2MBi+Pn6PM34TuG5qflG/bIfXtNa9Ee6a0LE7SNwh8l/Pyx
	c9pzwCCYVnm32veHsx67Sty3+OXAzl2HuBRjNMdHzU1Ni1kZJU8rfG2k65U0p5Xp5PUC7kXj4MS
	eNqStiMhQwzQ1VVxODYxZqAID9WbyRM4clDdqHcPvdtYhaqh/1D04/xaRJ40G5eNAn9159IuGei
	o+Kc8LA7/uNW/v23NR6w2czhIuk3RzwjmJ29DakhQM/g1Ser02zEBpLxA1WQOFpyqQutFJE086k
	nBgjIzcLfBFZnL6V2ea7jinBn4GpJvSve3Z2dYg/dhSdZmwTv3Xra82FFA6cu+5rX4k9tf6Rk+d
	T70wykN1
X-Received: by 2002:a05:7301:1527:b0:36c:a26f:83c4 with SMTP id 5a478bee46e88-377e101681cmr1458475eec.13.1794459248610;
        Wed, 11 Nov 2026 20:54:08 -0800 (PST)
Received: from eldorado ([2600:8802:b00:1f88::287])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520cfdfc6sm23921585eec.17.2026.11.11.20.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 20:54:05 -0800 (PST)
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
Subject: [PATCH net v2 09/12] net: au1000: restore RX buffer addresses when restarting the MAC
Date: Wed, 11 Nov 2026 20:52:51 -0800
Message-ID: <20261112045301.3669532-10-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112045301.3669532-1-f.fainelli@gmail.com>
References: <20261112045301.3669532-1-f.fainelli@gmail.com>
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

The MAC DMA engine updates each receive descriptor's address as it
transfers data. Clearing the descriptor control bits during reset does
not restore the buffer's starting address.

au1000_init() only set RX_DMA_ENABLE on the address left in the
descriptor. After closing and reopening the interface, a receive could
therefore start partway through its buffer and overwrite memory beyond
the allocation.

Reload each RX descriptor from rx_db_inuse before enabling it, as the
receive completion path already does.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/amd/au1000_eth.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amd/au1000_eth.c b/drivers/net/ethernet/amd/au1000_eth.c
index 67f4899c34a6..8b7a88ceb3c5 100644
--- a/drivers/net/ethernet/amd/au1000_eth.c
+++ b/drivers/net/ethernet/amd/au1000_eth.c
@@ -722,7 +722,8 @@ static int au1000_init(struct net_device *dev)
 
 
 	for (i = 0; i < NUM_RX_DMA; i++)
-		aup->rx_dma_ring[i]->buff_stat |= RX_DMA_ENABLE;
+		writel(lower_32_bits(aup->rx_db_inuse[i]->dma_addr) |
+		       RX_DMA_ENABLE, &aup->rx_dma_ring[i]->buff_stat);
 
 	wmb(); /* drain writebuffer */
 
-- 
2.53.0

