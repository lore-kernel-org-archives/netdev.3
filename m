Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3EA448391
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 20:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790022690; cv=none; b=izJSEAQmbualrHJccKybX5QBB30asR+0QZL/USUjTrkaS+gjcZDIY9jkTcdCCesqpvaGbHkNODJ7OBz2VT131sIBKOHDIXIoxfylJaLMME+HaxVyarX62trNnL/hRdyaqmbnx9UMSJcUR+KbdNA5U2VrsW/448U3MBzGnv+wJ3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790022690; c=relaxed/simple;
	bh=QAlPQDjqzmcU7tGTAfcLsdZnAHc4UxOIvqQXA9BbnBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tLNY9jkUyTVcxXTYdU6CWtv+wUBw19BkPyWuFZGqiIxAGkt2kH6qHeP+jUD3FYSSlZOwp9LYTFP+DFY+qnvLRI+Ac6ts0Qv+W5fYq8OciHlEDUbYA//ANE7feJs58sGPa8rTN7Z7kH+4vaC+uuhLp/UTP0BaeVAv08cggFPvKg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FUVVDZQN; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUVVDZQN"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39dacf053eeso2507696a91.2
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 13:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790022689; x=1790627489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ppb9oEIswlXdPW+vpBbxCBnXLp5edxa/JlS8+/nLpFY=;
        b=FUVVDZQNpeIto7XRSV6Kp2UsP3H2h1Hg+YbdUAOyEhbkcqd/4nFzLBPvoOiWdGBmr/
         SLCmlJFHAz6EvxbqpqBwPpZLa0FxPiuVsT4gXWiVMQNhMOEZII9hiPd+H49uorQi48mW
         neJx1WguIk0LYgPxAVN5j51lnsFh9NRQ3+Fpbq2j4VE7+PAdnH2DiAXuMIIJABaAF5di
         zY8tSejmMGd9F+XCgOHWJHlkEDUn3a3o9D3SxqVdZl88iXBp3Pq8PrR2lMLGThXlzVLs
         J4oDACA2IOkZr9I6i3fkvpPrkYyb5rp5qZMtz4vCxlkSYvV6nVMGKX/f1xGv79CV+ZO8
         PdHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790022689; x=1790627489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ppb9oEIswlXdPW+vpBbxCBnXLp5edxa/JlS8+/nLpFY=;
        b=kMnW+P3+cq2VE2SXOKo9xZZCHyyU3NNCaZDLwp1ruO84jy2nFXLsCTYNQbReL5L/YO
         oHTrgJp8ZrnpndnU568sHGRSeKrDcj0iS+vcQ38D5CrXlCgy2UHRUnkT7UQRvCwIpGbZ
         hklui7dUmDFHtqSvcdkaPlrkNLLI8I+gikR4Lcm04DhlrPbHhUB74qUZ8pTwv6T2Vdrc
         uSS/mNOG8XzKxYSyOCGQOnMqGUir5OyxlA1zk5Hf+wgdwh25Rge2MeYXahBI/ENAvwP0
         s7DolRTmLm95a6fc5d+caUALDfjkTQIOGlNXQuMUDKXZtlN1EVs6emN0P3iq96CsXTH6
         el9g==
X-Gm-Message-State: AFuF++n82bjOGN8G95J+YnF753uHrPYaeXhjGGoqLXKTibBb93C62qD9
	nVsrEfhOqFSkwAqrtcvOFANZXKrvH+Lbgn6y0gOoJiZy6nRfa6fonGpytPO1m3Tr
X-Gm-Gg: AYBFou0B1C4WcO5+pIC/jkZQrtID5YjBc1sK0V+bfHZsHsIvpY+vOMoEcYcqz6BIrJX
	ekRjq1f1Cv6z2RudhE1iApii/geU2ioSCQGytjwAJj/hegaspsMDaw7aelQhJfk+2qI0NaKnqLx
	46K98vosD96Zruq3F1wzRp4mvgvS+K781zCyX4hvtxPngCCXgHSX/Od9NS4ESMcSdebjEBSOu6Y
	FcXiPsHcVrr9r0HhNeTuTzYZHhdjwx0ckgwnlFktip9OVaYb/Jjse9sbf2KgkYGdbgXpoXLEf66
	1DqVhRCwuRdjJTaucUMD/lGesXNjWcJGZJaWmgu4SJs009abcLk6fTIvvhHFKNPNcpNIHqOt7qE
	kG1Y8q0Gv+9P4791pOgelMp4APiqqFvWG0e8p9eMHWvQn/O3gtANh15Zuo7sEQQw33kMlzZ6ZV9
	QZfZDVBI/X+KPvMsAmprzNMoOVRmWg3RI6jMq4408EnaHsSm4PoK0J7M57UZHtbqCOezRCDHDv0
	rimDIobwnjNJoIZXQt8WsQ7F56LCGP5LWo=
X-Received: by 2002:a17:90b:3ccf:b0:39e:4c7f:7309 with SMTP id 98e67ed59e1d1-39e550784ecmr17184273a91.32.1790022688616;
        Mon, 21 Sep 2026 13:31:28 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76c0:d30::4d0:61])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a069918587sm447247a91.4.2026.09.21.13.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 13:31:27 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 2/7] net: dsa: motorcomm: Rename MIB stuff
Date: Tue, 22 Sep 2026 04:30:19 +0800
Message-ID: <20260921203040.1203911-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260921203040.1203911-1-mmyangfl@gmail.com>
References: <20260921203040.1203911-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename them in preparation of major MIB refactor.

Signed-off-by: David Yang <mmyangfl@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/dsa/motorcomm/chip.c | 34 ++++++++++++++++----------------
 drivers/net/dsa/motorcomm/chip.h |  4 ++--
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index 38e7879a9f1a..d0b25ded2447 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -38,7 +38,7 @@ struct yt921x_mib_desc {
 #define MIB_DESC(_size, _offset, _name) \
 	{_size, _offset, _name}
 
-/* Must agree with yt921x_mib
+/* Must agree with yt921x_mib_stats
  *
  * Unstructured fields (name != NULL) will appear in get_ethtool_stats(),
  * structured go to their *_stats() methods, but we need their sizes and offsets
@@ -545,11 +545,11 @@ yt921x_mbus_ext_init(struct yt921x_priv *priv, struct device_node *mnp)
 }
 
 /* Read and handle overflow of 32bit MIBs. MIB buffer must be zeroed before. */
-static int yt921x_read_mib(struct yt921x_priv *priv, int port)
+static int yt921x_mib_read(struct yt921x_priv *priv, int port)
 {
 	struct yt921x_port *pp = &priv->ports[port];
 	struct device *dev = to_device(priv);
-	struct yt921x_mib *mib = &pp->mib;
+	struct yt921x_mib_stats *mib = &pp->mib;
 	int res = 0;
 
 	/* Reading of yt921x_port::mib is not protected by a lock and it's vain
@@ -604,7 +604,7 @@ static int yt921x_read_mib(struct yt921x_priv *priv, int port)
 	return res;
 }
 
-static void yt921x_poll_mib(struct work_struct *work)
+static void yt921x_mib_poll(struct work_struct *work)
 {
 	struct yt921x_port *pp = container_of_const(work, struct yt921x_port,
 						    mib_read.work);
@@ -614,7 +614,7 @@ static void yt921x_poll_mib(struct work_struct *work)
 	int res;
 
 	mutex_lock(&priv->reg_lock);
-	res = yt921x_read_mib(priv, port);
+	res = yt921x_mib_read(priv, port);
 	mutex_unlock(&priv->reg_lock);
 	if (res)
 		delay *= 4;
@@ -642,11 +642,11 @@ yt921x_dsa_get_ethtool_stats(struct dsa_switch *ds, int port, uint64_t *data)
 {
 	struct yt921x_priv *priv = to_yt921x_priv(ds);
 	struct yt921x_port *pp = &priv->ports[port];
-	struct yt921x_mib *mib = &pp->mib;
+	struct yt921x_mib_stats *mib = &pp->mib;
 	size_t j;
 
 	mutex_lock(&priv->reg_lock);
-	yt921x_read_mib(priv, port);
+	yt921x_mib_read(priv, port);
 	mutex_unlock(&priv->reg_lock);
 
 	j = 0;
@@ -684,10 +684,10 @@ yt921x_dsa_get_eth_mac_stats(struct dsa_switch *ds, int port,
 {
 	struct yt921x_priv *priv = to_yt921x_priv(ds);
 	struct yt921x_port *pp = &priv->ports[port];
-	struct yt921x_mib *mib = &pp->mib;
+	struct yt921x_mib_stats *mib = &pp->mib;
 
 	mutex_lock(&priv->reg_lock);
-	yt921x_read_mib(priv, port);
+	yt921x_mib_read(priv, port);
 	mutex_unlock(&priv->reg_lock);
 
 	mac_stats->FramesTransmittedOK = pp->tx_frames;
@@ -720,10 +720,10 @@ yt921x_dsa_get_eth_ctrl_stats(struct dsa_switch *ds, int port,
 {
 	struct yt921x_priv *priv = to_yt921x_priv(ds);
 	struct yt921x_port *pp = &priv->ports[port];
-	struct yt921x_mib *mib = &pp->mib;
+	struct yt921x_mib_stats *mib = &pp->mib;
 
 	mutex_lock(&priv->reg_lock);
-	yt921x_read_mib(priv, port);
+	yt921x_mib_read(priv, port);
 	mutex_unlock(&priv->reg_lock);
 
 	ctrl_stats->MACControlFramesTransmitted = mib->tx_pause;
@@ -749,10 +749,10 @@ yt921x_dsa_get_rmon_stats(struct dsa_switch *ds, int port,
 {
 	struct yt921x_priv *priv = to_yt921x_priv(ds);
 	struct yt921x_port *pp = &priv->ports[port];
-	struct yt921x_mib *mib = &pp->mib;
+	struct yt921x_mib_stats *mib = &pp->mib;
 
 	mutex_lock(&priv->reg_lock);
-	yt921x_read_mib(priv, port);
+	yt921x_mib_read(priv, port);
 	mutex_unlock(&priv->reg_lock);
 
 	*ranges = yt921x_rmon_ranges;
@@ -785,7 +785,7 @@ yt921x_dsa_get_stats64(struct dsa_switch *ds, int port,
 {
 	struct yt921x_priv *priv = to_yt921x_priv(ds);
 	struct yt921x_port *pp = &priv->ports[port];
-	struct yt921x_mib *mib = &pp->mib;
+	struct yt921x_mib_stats *mib = &pp->mib;
 
 	stats->rx_length_errors = mib->rx_undersize_errors +
 				  mib->rx_fragment_errors;
@@ -821,10 +821,10 @@ yt921x_dsa_get_pause_stats(struct dsa_switch *ds, int port,
 {
 	struct yt921x_priv *priv = to_yt921x_priv(ds);
 	struct yt921x_port *pp = &priv->ports[port];
-	struct yt921x_mib *mib = &pp->mib;
+	struct yt921x_mib_stats *mib = &pp->mib;
 
 	mutex_lock(&priv->reg_lock);
-	yt921x_read_mib(priv, port);
+	yt921x_mib_read(priv, port);
 	mutex_unlock(&priv->reg_lock);
 
 	pause_stats->tx_pause_frames = mib->tx_pause;
@@ -4748,7 +4748,7 @@ static int yt921x_mdio_probe(struct mdio_device *mdiodev)
 		struct yt921x_port *pp = &priv->ports[i];
 
 		pp->index = i;
-		INIT_DELAYED_WORK(&pp->mib_read, yt921x_poll_mib);
+		INIT_DELAYED_WORK(&pp->mib_read, yt921x_mib_poll);
 	}
 
 	ds = &priv->ds;
diff --git a/drivers/net/dsa/motorcomm/chip.h b/drivers/net/dsa/motorcomm/chip.h
index 9cd1010eb970..9205be423e39 100644
--- a/drivers/net/dsa/motorcomm/chip.h
+++ b/drivers/net/dsa/motorcomm/chip.h
@@ -861,7 +861,7 @@ enum yt921x_fdb_entry_status {
 #define yt921x_port_is_internal(port) ((port) < 8)
 #define yt921x_port_is_external(port) ((port) == 8 || (port) == 9)
 
-struct yt921x_mib {
+struct yt921x_mib_stats {
 	u64 rx_broadcast;
 	u64 rx_pause;
 	u64 rx_multicast;
@@ -940,7 +940,7 @@ struct yt921x_port {
 	bool isolated;
 
 	struct delayed_work mib_read;
-	struct yt921x_mib mib;
+	struct yt921x_mib_stats mib;
 	u64 rx_frames;
 	u64 tx_frames;
 
-- 
2.53.0

