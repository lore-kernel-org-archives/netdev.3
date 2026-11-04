Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826488;
	b=ai5c3pT2IJTR7HGVpwplhrLYXrn48RIP2lfwo7nMBMJg5jN4g89jK0v9f+otcqpb4XCF
	 M2gmaj4cqTvZSYDay9xyhu0/g9j8g5j4vi3YEjhOKg0kKyfSGYA/wzeZ9Rp80V4lZn2tl
	 LoTrnMrbnU/bQxazp9SdWnKTGkbrgZ9+4Mvz3Krjsvzh4Pe7eiUzjZZgnrp2jKCXbMcN0
	 XBJWVReLy0H0kSg2vpulkhARq1Zw6OJ0kqhfURh+wCAgYnPRbwXerplvFITzYYuw3d45P
	 GVffhMj8muLPhjcl5abNYx5R61ZtgggkSAcWbvAsKzbfNdrSu8hS8F4SssYV78TFmvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826488;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=PRYQYYxJqBJDQkD/p0wMCQ+7wKYDnSfY9YG56X9s19w=;
	b=wb7hFc/geqNSSr//7sQLZrtnc7NR7V+6X1z4OxKvKJnZTDpqVTnjXBBdfdH0lR4L3fV4
	 Vt57LzQp6Xy7y7anMwdUhMLcEumX7n6Yuj7PuXK/JI28LAnizbxHm5qWsmfdYuiRmROzN
	 UTfbf5bhJDzJBYMeCNIJ6G1IqFKMw1K91HsExBw/Uc0/qRbXKPZ54ZpLLU2zuseyIRurr
	 jd4vfRpYFPnWAGeyceajOnAfHYSbEfjQNoQT1dVJKcsm1rDIePN61jBXK4hLF/BsLGuC8
	 FWveoTCSpGlggy1+EU4g2C/ypMzQ1gtSVTEZpVD1nu0zqrEAyleacZIWmBr0Q39QWYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NLcbLMpO;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0117B6070E6F
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 21:08:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0117B6070E6F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NLcbLMpO
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a214af2076so8525225e9.0
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 13:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793826486; x=1794431286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PRYQYYxJqBJDQkD/p0wMCQ+7wKYDnSfY9YG56X9s19w=;
        b=NLcbLMpOPiSo7v1MCLy+A9J/zc9dAo3lfBpVpoxi76qwAq0ZZbbbkoWRD3QFXDTBPq
         DEcoxZIjSf8moXt0HEB6u5O9HEGTGHGxosokzsahgRMEVUkW7frXOR1VfIjugtDtFil/
         nQwk3g7QWHTDx9UGkhrwIQDOyFHsuI5Z15rNdMlwlyDMiEDch3q3kmsU1nFZ+caapLjx
         W4XaTbIYYuIGQARfR5hzJ/wlA2TXK2NSoF8pFs9+3CBGlJ4HWXP6dTHAT7Hu209CP0ka
         8Zf1CdNeHYVaTJ4IQ33GMW4TKsNNxsYO090R5ZzvOe09r/8USBQ9Kbjz8lnmpM9Hb9kj
         dRIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793826486; x=1794431286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PRYQYYxJqBJDQkD/p0wMCQ+7wKYDnSfY9YG56X9s19w=;
        b=jkDPdgyijpe8bax88oHYVUFh9S6531KsIjQV8LmHFdEuMaw9nxmy/Rx0eL5rPVcTs3
         kf/pRTbJSr/oZGGf09D804lqsFs0rpC+94WTSGdnNPDISWc1I/V9JGE8XQLcmj0aWKHR
         g7hwGyrgiGSeSCPAoxeRFxqCp62HprEMvup0wEyv0ubh0TrXf9yaU/tJEQzWhJJrLg7p
         20IpZIjt5m2zNvW+iWjWMSXvHGRX16OIwCE9QGxIs/BTeuCXqtAqijpHgaw9Gel0CiHd
         8mWmmTDU9cu8QdoOLI4Raqc8qlguqcqLKBRNOXBmz3IWI+RIUk3dVFgYCQxVMDkBQAdN
         owDg==
X-Forwarded-Encrypted: i=1; AKwUvByw/sX5LL4uaSRhYkLVhZHQDFUsoOJepW5y2hphOm6OGvvMsLIopUOZAkz11isO7/vSMAdieN0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Bb93i2QIKnRnn6VSyV5VznJB/rRkiI5jBZ2SCnLIrtdXWEU0k
	pipQJjRrzXwOKa5RZZVe2SbkPdeqLmuHS0qJtew6R0+6JkegDg9sDBP5
X-Gm-Gg: AYBFou1WwawGFh7wvmidu8FfaWJUt0sDUTIPWV0aPm5dImdDdRkCeV+/SRDuHNomiS7
	4uusmyTE6NhdPJH1yRsg1BkE6HXVGlsVm3B/kFbyXpuSp6iEx+Fr5NEUAsaGZlwMWEN4tooIoWY
	Vzhya7YjaBxJVN5wqyqcF2H6y5LJKagWoTsyE0nVyF1pdBfv7zsq9dQ4avPBIMq9ZlGzRHmJUDL
	SkLocl9a60c4+8oiBwQ2T7EIb3aVVNupmuYdw94V9iI+2AVKgfp2PSPNztTZJ83rDgWplXvDpdU
	Hbn5GPg663iFaXL9fz/tp/Sp6HF1DJAFgReXLTKsqzvNAxkDlvgWvPQDOFiILM6LqezKG00ygYy
	e5kkgrN5cdOidWGMJHduTEzVN2vQB17zjIUtXt6GQz15CG9q/4JIy+kjb2CR3CTqfzXEpXIpfcK
	id0cmz9mJQgwlcFPnb+Jck8Ehsi5SSUpD7bkpeHRzAnikz81HTlK+k4kJvh3NiF6oRY/Yv4gG6G
	ForQPuDScvjEWOPPNQqvQZZjl0ASFHrBVUwmFeIN2/BtoWU1nEWFHjSLOLPIJ2J/Df37/ESJSi7
	kQ/ydEbxQwYbDVj74HvaENDTIqoTrmrMfE/6lhbq/8jOYGAkPf4=
X-Received: by 2002:a05:600c:1f94:b0:4a8:f2ad:a9e5 with SMTP id 5b1f17b1804b1-4ac1548f591mr382755455e9.3.1793826486243;
        Wed, 04 Nov 2026 13:08:06 -0800 (PST)
Received: from VivoBook-ASUS-X712UA-M712UA.lan ([2a00:f44:c23:788d:6769:d03c:c916:2aca])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b56e2ae73csm11998855e9.1.2026.11.04.13.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 13:08:05 -0800 (PST)
From: Stanislaw Pal <kuncy7@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Yongzhao Chen <yongzhao.derek@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 2/4] net: dsa: qca8k: drop MIB autocast frames once the request is over
Date: Wed,  4 Nov 2026 22:07:55 +0100
Message-ID: <20261104210757.467964-3-kuncy7@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104210757.467964-1-kuncy7@gmail.com>
References: <20261104210757.467964-1-kuncy7@gmail.com>
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
touching data.

An autocast frame carries no identity of the request it answers. Once a
request has timed out and the next one is published, the switch may
still be sending the earlier autocast, and its frames count for the
new request. Wait for MIB_BUSY to clear before asking for the next
autocast, as qca8k_mib_init() does after a flush, so that at most the
frames already on their way to the host can be taken for the new
request, and track the ports seen as a bitmap instead of a countdown,
so that a second frame of a port cannot complete the request before
the other ports have reported. The requested port's counters then come
from the newest frame of that port, which is at most one autocast
behind - the same as a register read racing the hardware.

An LLM assistant (Claude, claude-fable-5-1) helped analyse the race
and write the change and this description; I reviewed both. Built with
W=1 on arm64; tested on a QCA8337 behind an IPQ5018
(GL.iNet GL-B3000) with tag_qca, with the request timeout forced to 0
to exercise the late frame path.

Fixes: 5c957c7ca78c ("net: dsa: qca8k: add support for mib autocast in Ethernet packet")
Signed-off-by: Stanislaw Pal <kuncy7@gmail.com>
---
 drivers/net/dsa/qca/qca8k-8xxx.c   | 47 ++++++++++++++++++++++++++----
 drivers/net/dsa/qca/qca8k-common.c |  2 +-
 drivers/net/dsa/qca/qca8k.h        |  6 ++--
 3 files changed, 47 insertions(+), 8 deletions(-)

diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index 1242ee3469..86b20bbc43 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -1676,10 +1676,18 @@ static void qca8k_mib_autocast_handler(struct dsa_switch *ds, struct sk_buff *sk
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
 	port = FIELD_GET(QCA_HDR_RECV_SOURCE_PORT, ntohs(mib_ethhdr->hdr));
+	if (port >= QCA8K_NUM_PORTS)
+		goto unlock;
 	if (port != mib_eth_data->req_port)
 		goto exit;
 
@@ -1704,9 +1712,17 @@ static void qca8k_mib_autocast_handler(struct dsa_switch *ds, struct sk_buff *sk
 	}
 
 exit:
-	/* Complete on receiving all the mib packet */
-	if (refcount_dec_and_test(&mib_eth_data->port_parsed))
+	/* Complete once a frame of every port has arrived. A second frame
+	 * of a port, left over from an earlier autocast, cannot end the
+	 * request early.
+	 */
+	mib_eth_data->ports_seen |= BIT(port);
+	if (mib_eth_data->ports_seen == GENMASK(QCA8K_NUM_PORTS - 1, 0)) {
+		mib_eth_data->data = NULL;
 		complete(&mib_eth_data->rw_done);
+	}
+unlock:
+	spin_unlock(&mib_eth_data->lock);
 }
 
 static int
@@ -1721,13 +1737,25 @@ qca8k_get_ethtool_stats_eth(struct dsa_switch *ds, int port, u64 *data)
 
 	mutex_lock(&mib_eth_data->mutex);
 
+	mutex_lock(&priv->reg_mutex);
+
+	/* A request that timed out may have left the switch still sending
+	 * its autocast. Let it finish before asking for another one, so
+	 * that as few of its frames as possible are taken for ours.
+	 */
+	ret = qca8k_busy_wait(priv, QCA8K_REG_MIB, QCA8K_MIB_BUSY);
+	if (ret) {
+		mutex_unlock(&priv->reg_mutex);
+		goto out;
+	}
+
 	reinit_completion(&mib_eth_data->rw_done);
 
+	spin_lock_bh(&mib_eth_data->lock);
 	mib_eth_data->req_port = dp->index;
 	mib_eth_data->data = data;
-	refcount_set(&mib_eth_data->port_parsed, QCA8K_NUM_PORTS);
-
-	mutex_lock(&priv->reg_mutex);
+	mib_eth_data->ports_seen = 0;
+	spin_unlock_bh(&mib_eth_data->lock);
 
 	/* Send mib autocast request */
 	ret = regmap_update_bits(priv->regmap, QCA8K_REG_MIB,
@@ -1743,6 +1771,14 @@ qca8k_get_ethtool_stats_eth(struct dsa_switch *ds, int port, u64 *data)
 	ret = wait_for_completion_timeout(&mib_eth_data->rw_done, QCA8K_ETHERNET_TIMEOUT);
 
 exit:
+	/* On a timeout the frames can still arrive after the caller has
+	 * freed data: retire the request so that the handler drops them.
+	 */
+	spin_lock_bh(&mib_eth_data->lock);
+	mib_eth_data->data = NULL;
+	spin_unlock_bh(&mib_eth_data->lock);
+
+out:
 	mutex_unlock(&mib_eth_data->mutex);
 
 	return ret;
@@ -2120,6 +2156,7 @@ qca8k_sw_probe(struct mdio_device *mdiodev)
 	init_completion(&priv->mgmt_eth_data.rw_done);
 
 	mutex_init(&priv->mib_eth_data.mutex);
+	spin_lock_init(&priv->mib_eth_data.lock);
 	init_completion(&priv->mib_eth_data.rw_done);
 
 	priv->ds->dev = &mdiodev->dev;
diff --git a/drivers/net/dsa/qca/qca8k-common.c b/drivers/net/dsa/qca/qca8k-common.c
index ab978cc836..f1e7e86f47 100644
--- a/drivers/net/dsa/qca/qca8k-common.c
+++ b/drivers/net/dsa/qca/qca8k-common.c
@@ -101,7 +101,7 @@ const struct regmap_access_table qca8k_readable_table = {
 	.n_yes_ranges = ARRAY_SIZE(qca8k_readable_ranges),
 };
 
-static int qca8k_busy_wait(struct qca8k_priv *priv, u32 reg, u32 mask)
+int qca8k_busy_wait(struct qca8k_priv *priv, u32 reg, u32 mask)
 {
 	u32 val;
 
diff --git a/drivers/net/dsa/qca/qca8k.h b/drivers/net/dsa/qca/qca8k.h
index 9563388930..79754755f1 100644
--- a/drivers/net/dsa/qca/qca8k.h
+++ b/drivers/net/dsa/qca/qca8k.h
@@ -402,9 +402,10 @@ struct qca8k_mgmt_eth_data {
 struct qca8k_mib_eth_data {
 	struct completion rw_done;
 	struct mutex mutex; /* Process one command at time */
-	refcount_t port_parsed; /* Counter to track parsed port */
+	spinlock_t lock; /* Protects the request against the rx handler */
+	unsigned long ports_seen; /* Ports whose frame arrived, under lock */
 	u8 req_port;
-	u64 *data; /* pointer to ethtool data */
+	u64 *data; /* pointer to ethtool data, NULL with no request pending */
 };
 
 struct qca8k_ports_config {
@@ -501,6 +502,7 @@ static inline u32 qca8k_port_to_phy(int port)
 /* Common setup function */
 extern const struct qca8k_mib_desc ar8327_mib[];
 extern const struct regmap_access_table qca8k_readable_table;
+int qca8k_busy_wait(struct qca8k_priv *priv, u32 reg, u32 mask);
 int qca8k_mib_init(struct qca8k_priv *priv);
 void qca8k_port_set_status(struct qca8k_priv *priv, int port, int enable);
 int qca8k_read_switch_id(struct qca8k_priv *priv);
-- 
2.43.0

