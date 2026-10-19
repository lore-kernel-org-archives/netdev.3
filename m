Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792437129;
	b=QHs4w+/nu/YCvvyCZomQFqe5Oi5ykI5wCXT8gcLMDTnUQpLzgMvqAaf0qxUtjZ+1cUm7
	 6nPu3bjPYT8wZAzHJliKsyqzvZVlZJldJa+V45kU9qOfNgLjm88SFboBqQgz56NGVStkT
	 PWiKQb49JpDZk9FOYiM0DMHjN1FHlfG7PSWi/cyiLdE68/TorL0sHdLx3NWIERQEJcpKB
	 7k0eStQ0S0vEBegsP/P7U9RyS6uUs7dhhltb1BZvrOraNnFZAsIc4IHBMUQ379m4aRvlx
	 hrmCP2/4bBAat0PWlxaSxuhp8fcQhPBAStOXnQ02VLAmTdQ5/KVVND8ahD8Ay52jMiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792437129;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=o1to95OGJg14CQlNiAHAtBtvI0GNBxi4w7KA/3PNH7A=;
	b=fenner/JNd9im6NuE1PTiBrvegxsJrUGn8p/rMfPjE6O3AZt9jprQGs0sUxbf0sx0Vwn
	 /Mr6g5eXJdJLQ/zxNP6Rwonha9ka8d62pEbp7olriVf+WOVg7FZ+KckVvvAMyXOdEO2zt
	 4G7SZQT2eS+ct5+sN0gDU0le71qQr4+nCK6HTSi5fIZxXJDoIBlBy0nH0UoBvF7otf6nM
	 FjVQiy49zfXGcFRvdjUoutfWdQPW6PqUBkCiidbiMi9l0QlJoDMwow874HyYpw+6/Z1X4
	 /vckYdqn96X4eZAlml6UrNzWObBCAdcqlxlVQ6TOq+OhinPmTMSXbAPg9c6pPRonIGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dBNC6SdT;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8F4606A31C
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 19:12:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD8F4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dBNC6SdT
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48c5358fc28so2078873f8f.0
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 12:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792437127; x=1793041927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o1to95OGJg14CQlNiAHAtBtvI0GNBxi4w7KA/3PNH7A=;
        b=dBNC6SdTHt9dVPdShR6zs1QRfcsnZgjk1NZTAJ2lgzyWxWI8J5ea3pSdW8Edin+0eX
         iIdB9dHO8CEdXQpAJedEznHeDr1+5XY3TVEWv0ot5PDwRbJPqcWMz/R+dfCHgIj8r2Po
         Nj+Ce/WCgv5nObzV/TEEfGuMvzDIMC+EAR4VrZ3T3betd5XVCW8FWCKvBdjNxtKgx6zy
         cqSdLq7zgGwTprzMmwtAhEb6EERLW7MU70N09wI7zPoz/DoIOgmMPk0NYVKmUrzKWhQq
         M3ZM/l84Hq+zzqOlA2Gxxs29fSujBDv6xALuO7BcCij6iCC/vl987NfWpgc8MlG7VnC3
         33NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792437127; x=1793041927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=o1to95OGJg14CQlNiAHAtBtvI0GNBxi4w7KA/3PNH7A=;
        b=ef4B5rFTi8WcG1mbPuMsgG12YiAZELVpeO9XF2wGMnJutO5ZsRpCD3xafZVDhvKFr0
         Bl58bMv8LPhImHIAe7pqqAQIQZd5a+5RHzp4PjPaOyHaneIDP0RrdtTSyvxqfsDn6Azg
         VmDr0s5Eq4l1PGTqVRKhC/nCNMzSFRiQ7xZoTcZ0pRm+ZxskmU6ULw4xKabm3gNI4WPK
         HAHzQig5R8C02hBGSPMsTtuZB46v/ec1HKRclYZU+20mapx+FIivEC8WgZdu6x4reXYu
         9wOj88HIcXYUfBWv1f3oEwOcO9BgnR19K4UPNwqFdisnzixTvOXlXHYiCE8UrTTcXYab
         BaiA==
X-Forwarded-Encrypted: i=1; AKwUvBxsEWTgN/+dO8qiEGaKThOLKcqtXtNfOXZA+3xTshefxo21oaCpULw72vc9T9Kn8uq14CsEwPY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIB/jkPWT8xT9KBUzoJFHQ+6lzX3fx6tdDlhEHFb3JGVm7/wZeI
	hHhOTBLDjbsTyhFJDXnu0HU6QU0mFo9LXmH2cRdRyoswV4JnkTBdEAYx
X-Gm-Gg: AYBFou3kkSWNrXDGuUUf0HpsNo61ArpkZPfxWEChyNv2J2CDjL1mmjKTy6BeeTx6jiD
	waY03abb8P8i2G08wDCzHPVdt2mTRUist5hOWTw+qYHR80iSaLiYmh5hchDy0bXJxsCBkvhbmQu
	SYGb9jQS97j+JSDxBcLmcBK6hnIgmmV1thdChuDpInsA/ySyZlMrH77Dgvs3zQjQmJTpimkfy+r
	bw7h2cgNaQIhnadvpxjHu9c+KtQccdyrv9K5IES6KfrwDYC+A91vu+/VyoAvpjEGdIbL84SlADG
	uDdK11inI888gss5OQKNGyBUxlq7Ze/koamsTe8VNxFlIKBCGpzRiGP5mjMT6U9hLeQXfCl3Iyx
	alxXWcKStVKEE7q+OkWM6Tq93Sphl/WPSoNS6tHtpYOuUN6CD6bgToWd/J1PsDDIQ35tkX7wl6A
	8QpDplofzv30MT8BsJJhJ/e2QiITIHlNY/gL2Q8XBBR8PeSTebPJ8HMW5cDsVqHRxHcZXv55kkS
	vshxYMgETPuyI6/yzC6
X-Received: by 2002:adf:e892:0:b0:48e:389:d2d5 with SMTP id ffacd0b85a97d-48e07fb744emr14210563f8f.51.1792437126993;
        Mon, 19 Oct 2026 12:12:06 -0700 (PDT)
Received: from VivoBook-ASUS-X712UA-M712UA.lan ([2a00:f44:cd2:abb8:fed9:8342:c367:f022])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d818c89sm804977f8f.32.2026.10.19.12.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 12:12:06 -0700 (PDT)
From: Stanislaw Pal <kuncy7@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 1/2] net: dsa: qca8k: serialize register access
Date: Mon, 19 Oct 2026 21:11:36 +0200
Message-ID: <20261019191137.307514-2-kuncy7@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019191137.307514-1-kuncy7@gmail.com>
References: <20261019191137.307514-1-kuncy7@gmail.com>
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

The regmap is created with .disable_locking, on the ground that
qca8k's read and write callbacks do their own locking. They only lock
the bus transaction, though: regmap formats the register and parses
the value in the map's shared work_buf, outside of them, so two
concurrent users can swap or corrupt each other's register and value.
Most register access runs under rtnl, but not all of it - phylink's
resolve work (mac_link_up/down) and the LED class callbacks do not -
and the next change adds a delayed work that reads the MIB. Let regmap
take its own lock; every user sleeps already, on the MDIO bus or on
the management frame round trip.

An autocast MIB read holds the MIB mutex while its register write
takes the management mutex, and qca8k_conduit_change() takes the two
the other way round. Both run under rtnl today; with a reader outside
rtnl that would be an ABBA deadlock. Take the MIB mutex first there
too.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Stanislaw Pal <kuncy7@gmail.com>
---
 drivers/net/dsa/qca/qca8k-8xxx.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index 07227ae8b..9a8b9e34a 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -579,7 +579,6 @@ static const struct regmap_config qca8k_regmap_config = {
 	.write = qca8k_bulk_write,
 	.reg_update_bits = qca8k_regmap_update_bits,
 	.rd_table = &qca8k_readable_table,
-	.disable_locking = true, /* Locking is handled by qca8k read/write */
 	.cache_type = REGCACHE_NONE, /* Explicitly disable CACHE */
 	.max_raw_read = 32, /* mgmt eth can read up to 8 registers at time */
 	/* ATU regs suffer from a bug where some data are not correctly
@@ -1782,13 +1781,16 @@ qca8k_conduit_change(struct dsa_switch *ds, const struct net_device *conduit,
 	if (dp->index != 0)
 		return;
 
-	mutex_lock(&priv->mgmt_eth_data.mutex);
+	/* Same order as an autocast, which holds the MIB mutex while its
+	 * register write takes the management one.
+	 */
 	mutex_lock(&priv->mib_eth_data.mutex);
+	mutex_lock(&priv->mgmt_eth_data.mutex);
 
 	priv->mgmt_conduit = operational ? (struct net_device *)conduit : NULL;
 
-	mutex_unlock(&priv->mib_eth_data.mutex);
 	mutex_unlock(&priv->mgmt_eth_data.mutex);
+	mutex_unlock(&priv->mib_eth_data.mutex);
 }
 
 static int qca8k_connect_tag_protocol(struct dsa_switch *ds,
-- 
2.43.0

