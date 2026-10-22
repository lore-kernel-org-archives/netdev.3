Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792697383;
	b=SQZpO1pBlfzTZN/BsAF5KvDKE8w6FCS0k81GN/xVN52q7hrGmAKtu762bxyAqZLdrN12
	 tWpFxdxqVypmtt+Bq6EIPWXY++75sHH2Q0hsLvuM15eE1090skmAPDlQdjKFG5Uit529+
	 BzpvS4XyiSET2rPehT0z4oyrsQkrZkYSVNTZ6zk+wTWVvr1JQG0pcXEjmkdPG/pZdEbqd
	 fT6Elj4ip3e1rNVvUDD5cbF12pzFpXxsDey+Vli15KP95GA0IPIjU4H2uyKwpVOFI74XM
	 r9BGcIz7uhhwU31ufn6Z72dpNTx+d8ENCP2NuBrXGaqfcUdBjc5tcUa83g1dYgsC9Mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792697383;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=yJalOy9yUzY4qhSQnHegmtkd0eJp2sotrwsvSsGL/CM=;
	b=Ax7JNFUemGb8JucC0QEePEQ8kf8QBK3QxHHNRiXAWAnCB/CFqtagUA9O5Ou1FG35HbpS
	 si6S0EuaSjZ6XUJRpOtyZlINzLuwsAe9VBVkIwNx2UQXG14qQGGxTjn3FS4VEbJaPShLz
	 zpUqqmOTkMmnbXEolYSTFU5VvBVkjvDp7yrwsMXVGg5NalIpvWJM3tqd13lryi3Z8tcJb
	 zkGvlFf1fNZ9sijkX5EbUAHkQeeSafnvp7/rV/j9FNaYDCM8rNR4bik3ZExEGL39atVPH
	 gvXhmxB0xdIkTtdwHeuCFjELvOQtY/fxIYheHAGMDQwDaqXp5f/fPqWZCf8vwguBTNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pkNp+w2F;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A79606A33E
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 19:29:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7A79606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pkNp+w2F
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a20bde60a0so1485925e9.3
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 12:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792697381; x=1793302181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yJalOy9yUzY4qhSQnHegmtkd0eJp2sotrwsvSsGL/CM=;
        b=pkNp+w2Fce6/2tom5At3Ad3LzR3DynTZVDUmvORpG+V/zUGdhaeJlnji+1XU7I259S
         ldG8j7FGXXGVppobMnXiAeE6dYrE/bLu/FdW8s6fJ6hqSA0mGGsba9BD0dRAHkldGAwY
         B5yFesDmZWbffqb6TrCyM/WqD9BnanOcU4rMlPh1DyF6bdNioD83eMYx8vegrLq7iBVG
         /ggpTNFB8edVKKm24o8gAaTpaqx50c01BkJShnpDW57rMtWhRa2NgcByGYD94usCeO2t
         X7zH192fp1eOiikjGHq14CCY+98kEek0955NYbFafzO0qmPrkGCcCFeeOuU58b3OvviD
         7g0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792697381; x=1793302181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yJalOy9yUzY4qhSQnHegmtkd0eJp2sotrwsvSsGL/CM=;
        b=u+jd0AG9RC+LlCWfTa+/RBGLw287scaSrAdw1T2eM/wMJZnAPkyHD42pP28sREk/l3
         X/2SPVSjTUpoAssHX1mBwXwRE7rWSbVcvEY782ECDiuTC13ZLKbT61yQcEVgjOUIfBK8
         JRdCNjntJmM4WfMa3Kp/mS9hn8hZieDcmO+gxPs7MmPSZCW4GwZ49yRfThCfy0t17i/d
         jXFNiX6pIRETQu85/HKFjV4YB7nKbNuZCoMILkxYwnqDA3TZR/yGIuewJlVNh9oOhLQ8
         Dc8X636rXQDyZe746Na1Ek3jMqZVbuTU4P95MjLhdXmQU5zZforNMd1pSJLbTtWShHnN
         7zqw==
X-Forwarded-Encrypted: i=1; AKwUvBwZ5d6SD/SXw2011/9e3ir0oTUu1NAXM5VmRrOYR2QgT4o/wFBC4MhTpoOv7kK7Kz1UvelDYFI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLv1AElVzoZp/NgxiJ0OYmhoDQQtBmbPiYUHBdHeoTpKn5D/bKF
	VpdeYNthe2MQFVpQ26UWtkpxLvprl0mDZVmqoxKjZte3PampHxvNuHa7
X-Gm-Gg: AYBFou2sFKJuM+AaSewVrXvUvmZkl9cze8IEo43ozB/Hn1O8G9r57I6ENmTW9t9cvPV
	RfkWxO038XP/yrqpy+yHqanGI1hgQjNYzZip11YHBkWBc8pGaUJwVWyo9hDpI/94HB8CJGrAGoG
	iC6rx6DIYq5xoevfqgBYYngtK94DXhoGyCpJyGtQoxDcSxwdFurSIVPLTnL83eDjH8SX4RVfgtd
	HQi1WA2gmxnBYqdT8NTjHHHYfaM9kA0B8uKhfbhEvi/Lt/CceWUPOyE0CybGtd2LJJkxbAJT43I
	8YQqTpabbwp0wX66CZ5lzPbEb4z/w93m58KuKsN3S0Gwi4PuSl5NgV/2poQOMttOdD1tsr1+um2
	6//xpzI/LRMGIxt7mgGtARUH/ayn2rJSFGffgq1dx8R4cy7pQ4EPcCXSLQZBjPPuLl8AWWzmdrq
	uaWDTinbSqW0ZcT0tpDYhFYOakxAM7NIUB9OsuC1jliHCwOUZAyyXzp2wJ8QF+JC3uykpIY5XDA
	K4ILe08UV9GjsOnEEdSfqPDf8wIWbwgj5lDHM6EtzxpCybwhDqXDnHpksNIs/mHN8RmYrKE1H/e
	tg==
X-Received: by 2002:a05:600c:a00c:b0:4a2:390:712d with SMTP id 5b1f17b1804b1-4a211eff334mr659725e9.33.1792697380960;
        Thu, 22 Oct 2026 12:29:40 -0700 (PDT)
Received: from VivoBook-ASUS-X712UA-M712UA.lan ([2a00:f44:c12:cf67:2010:42d8:74da:e279])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a2101cedcesm20269405e9.0.2026.10.22.12.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 12:29:40 -0700 (PDT)
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
Subject: [PATCH net 2/3] net: dsa: qca8k: drop MIB autocast frames once the request is over
Date: Thu, 22 Oct 2026 21:29:32 +0200
Message-ID: <20261022192933.384898-3-kuncy7@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022192933.384898-1-kuncy7@gmail.com>
References: <20261022192933.384898-1-kuncy7@gmail.com>
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

qca8k_get_ethtool_stats_eth() points mib_eth_data at the caller's
ethtool buffer, asks the switch for an autocast and waits 5 ms for the
frames. On a timeout it returns with the request still published, and
the caller falls back to register reads; ethtool_get_stats() then frees
the buffer. The autocast handler runs from the conduit's receive path
without the request's mutex, so a frame that arrives late still writes
the requested port's counters through mib_eth_data->data into freed
memory, and frames beyond the seven expected ones underflow port_parsed.
ETHTOOL_GSTATS does not need CAP_NET_ADMIN.

Protect the request with a spinlock that the handler takes, retire it
on the way out, and let the handler retire it when the last frame
completes it, so that frames arriving after that are dropped without
touching data or port_parsed.

Fixes: 5c957c7ca78c ("net: dsa: qca8k: add support for mib autocast in Ethernet packet")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Stanislaw Pal <kuncy7@gmail.com>
---
 drivers/net/dsa/qca/qca8k-8xxx.c | 22 +++++++++++++++++++++-
 drivers/net/dsa/qca/qca8k.h      |  3 ++-
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index 49be53b7f..56796df14 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -1663,6 +1663,12 @@ static void qca8k_mib_autocast_handler(struct dsa_switch *ds, struct sk_buff *sk
 	mib_ethhdr = (struct mib_ethhdr *)skb_mac_header(skb);
 	mib_eth_data = &priv->mib_eth_data;
 
+	spin_lock(&mib_eth_data->lock);
+
+	/* A late frame of a request that has already returned */
+	if (!mib_eth_data->data)
+		goto unlock;
+
 	/* The switch autocast every port. Ignore other packet and
 	 * parse only the requested one.
 	 */
@@ -1692,8 +1698,12 @@ static void qca8k_mib_autocast_handler(struct dsa_switch *ds, struct sk_buff *sk
 
 exit:
 	/* Complete on receiving all the mib packet */
-	if (refcount_dec_and_test(&mib_eth_data->port_parsed))
+	if (refcount_dec_and_test(&mib_eth_data->port_parsed)) {
+		mib_eth_data->data = NULL;
 		complete(&mib_eth_data->rw_done);
+	}
+unlock:
+	spin_unlock(&mib_eth_data->lock);
 }
 
 static int
@@ -1710,9 +1720,11 @@ qca8k_get_ethtool_stats_eth(struct dsa_switch *ds, int port, u64 *data)
 
 	reinit_completion(&mib_eth_data->rw_done);
 
+	spin_lock_bh(&mib_eth_data->lock);
 	mib_eth_data->req_port = dp->index;
 	mib_eth_data->data = data;
 	refcount_set(&mib_eth_data->port_parsed, QCA8K_NUM_PORTS);
+	spin_unlock_bh(&mib_eth_data->lock);
 
 	mutex_lock(&priv->reg_mutex);
 
@@ -1730,6 +1742,13 @@ qca8k_get_ethtool_stats_eth(struct dsa_switch *ds, int port, u64 *data)
 	ret = wait_for_completion_timeout(&mib_eth_data->rw_done, QCA8K_ETHERNET_TIMEOUT);
 
 exit:
+	/* On a timeout the frames can still arrive after the caller has
+	 * freed data: retire the request so that the handler drops them.
+	 */
+	spin_lock_bh(&mib_eth_data->lock);
+	mib_eth_data->data = NULL;
+	spin_unlock_bh(&mib_eth_data->lock);
+
 	mutex_unlock(&mib_eth_data->mutex);
 
 	return ret;
@@ -2107,6 +2126,7 @@ qca8k_sw_probe(struct mdio_device *mdiodev)
 	init_completion(&priv->mgmt_eth_data.rw_done);
 
 	mutex_init(&priv->mib_eth_data.mutex);
+	spin_lock_init(&priv->mib_eth_data.lock);
 	init_completion(&priv->mib_eth_data.rw_done);
 
 	priv->ds->dev = &mdiodev->dev;
diff --git a/drivers/net/dsa/qca/qca8k.h b/drivers/net/dsa/qca/qca8k.h
index 956338893..a550f331c 100644
--- a/drivers/net/dsa/qca/qca8k.h
+++ b/drivers/net/dsa/qca/qca8k.h
@@ -402,9 +402,10 @@ struct qca8k_mgmt_eth_data {
 struct qca8k_mib_eth_data {
 	struct completion rw_done;
 	struct mutex mutex; /* Process one command at time */
+	spinlock_t lock; /* Protects the request against the rx handler */
 	refcount_t port_parsed; /* Counter to track parsed port */
 	u8 req_port;
-	u64 *data; /* pointer to ethtool data */
+	u64 *data; /* pointer to ethtool data, NULL with no request pending */
 };
 
 struct qca8k_ports_config {
-- 
2.43.0

