Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD7A3BE642
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 16:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791130003; cv=none; b=pcultYVrJQIbGQjgby9tncWb114T2+dkSqY7l4jt1e+cLZDWB4JXpVlrj+I0Mgb0zOtXDmKbXlxnBjHqUKLzExth/5gCJToK7oX3XEnzaMFqQm6uB9dBM4RUgCLc5vIgkqzhQ1Pqt/ZZSvfAaEyrwthyvdXHrW+pJ/8g1ALma9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791130003; c=relaxed/simple;
	bh=jYDJyKOx1G8mJk8zalmkndjGTqNcXB8w/FhwP8v3N+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F4O2TESQ754xDoVHG9Ka+QrWmFH61IcQzK0BOGESnT9FHD8Q79dhcciqb6LsKFh76zZQzjeuVUuZMCb3rIAM1CShtogwyU/PXF37zgG1ZdAqpPxelkRKWGAYNfKjBR4ogQ08UztNi0bvGvulktrgYHW4JJdectDuRtXn1vjdpgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WpclLdeg; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WpclLdeg"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-88e8f5a5de2so75634b3a.1
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 09:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791130001; x=1791734801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CzbT5gQiq8hxchlN2ZbUQgMQoPIOq6lj2Im4RjIzQjA=;
        b=WpclLdegGhEu26NESe9n2ePgqZ/ebwpXjwJtDlGaEx7fNxJAH83pnVWulzJb65TwkS
         TYeLIljQVaJWFCqfq/+uBYx/uxm4EbhNuLGXreohrzQalCgAkRBKjbZLwaIbA/l8Sb+j
         F/PbBTENb/eTZ2wM53jo1hgUTxVsiwCEdPCgz//DrUH4J6Y6b2cyApZKBzKuWMr2Esae
         7Iyr+XAH9YlCosVmdzi9ujFOrnsvdy4UwDEMik/Km3Xjr8KooXmM/mBj4M1W/YcI6iLa
         Bt38xZO2onAORG1S0aO885jVPLjPAG1MUAw2Usqs1D1GhfOQHFL5Elk/aOu8uIM2BHi4
         vdoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791130001; x=1791734801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CzbT5gQiq8hxchlN2ZbUQgMQoPIOq6lj2Im4RjIzQjA=;
        b=0JRcmLeFkt8I1u1KcBRim/voMej+uTh1DmS5IEd3u2IwuYN6JZuyEd7OZOwNmRzfoo
         B1NTFEpq+7aNQeLMShEZpodHENusVyQZzWx4E1ZzQtF5VbXBxPNJfaNxoPUC9TDCBsbX
         39Csuyu6O+d4w39uBu3oQzQlMeaSA45nwfbqXoROEQPtX8ZaCmRftaMdNzcTUCwFsAIJ
         gq14W2sNZ53mHlNxiwD+M3LIYTUfmmq0EWTUntjVynLcyi4vLwVdime6un4or+XzQFlW
         JinY8HkxN/SjLx+pCy5x5f0zz77lbrSETEmxjzPbrNuJZNbCthWBuyH/MFnim0KSF/Mh
         yOMw==
X-Gm-Message-State: AFq9FYJD96I5iST2YXKYpcTjVkwJzgtJ9HZ/i+yzi5CAQ2iwpwwfrkYV
	LxXVzv/fxabAiZh6xTd2Krb/2ri8KwDpxXoqiXVVz8XatDNu05GFAOo/VlZxkxsSzWo=
X-Gm-Gg: AYBFou1A+hyM8daznfFRg0M56sw3RsSr4rfvax3d6fEAH/Llq67UlZuplYyRMdT225P
	lmqg0sdzPFaECVNamsMvw9X75vwI/PJIL2bh0FsdfZs7S33yOcLLtUbUAKqx4qfyv61eXx/oDNr
	V/+uek+kl/5ZG+gISHlEQi8arkh3WFB1/C5sxfSSLtgyXD4MkznXQDxS6b5ttiDZS/DE7fvWb/v
	v/NvQxP0JvRawrnopqzBymrVxQdPxwouH5nakP2CFEGSqRWA0yXNVeJTa8SoTssNlEgIWxtdXc8
	2FaEaqOsxB8hmllQ/R8B8vAb+1nI9mDmWVH6VFxLd499MyOQJ9sh/K/4yjp0U21ifJ04FJDD4/Y
	mEli8wJkqRpvq87jLDiNV21h/XTuhi2ab+AHaHY0M294HuzLLYSh1RYhLPElIb0COa7ILi6HAao
	0MwadP+E9WqsDpJCeF1YdnEih/BVvwHYPSvPOmsXQnPp+9UdGQ28KcJFRshdR0+npKapPeNsR8Y
	gE5Kt/rkkzMxoFlbT+kSP3F7w==
X-Received: by 2002:a05:6a00:2293:b0:880:93c1:1f9e with SMTP id d2e1a72fcca58-88af76ce026mr7700507b3a.42.1791130001464;
        Sun, 04 Oct 2026 09:06:41 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661c:1246::1d2:d1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-88b0d247930sm2637789b3a.54.2026.10.04.09.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 09:06:41 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 2/6] net: dsa: motorcomm: Rename MIB stuff
Date: Mon,  5 Oct 2026 00:06:16 +0800
Message-ID: <20261004160622.948037-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004160622.948037-1-mmyangfl@gmail.com>
References: <20261004160622.948037-1-mmyangfl@gmail.com>
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
index 2c0f53cb2b8e..690ee0eb5192 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -40,7 +40,7 @@ struct yt921x_mib_desc {
 #define MIB_DESC(_size, _offset, _name) \
 	{_size, _offset, _name}
 
-/* Must agree with yt921x_mib
+/* Must agree with yt921x_mib_stats
  *
  * Unstructured fields (name != NULL) will appear in get_ethtool_stats(),
  * structured go to their *_stats() methods, but we need their sizes and offsets
@@ -266,11 +266,11 @@ static const struct yt921x_reg_ops yt921x_reg_ops_mdio = {
 /* TODO: SPI/I2C */
 
 /* Read and handle overflow of 32bit MIBs. MIB buffer must be zeroed before. */
-static int yt921x_read_mib(struct yt921x_priv *priv, int port)
+static int yt921x_mib_read(struct yt921x_priv *priv, int port)
 {
 	struct device *dev = yt921x_priv_to_device(priv);
 	struct yt921x_port *pp = &priv->ports[port];
-	struct yt921x_mib *mib = &pp->mib;
+	struct yt921x_mib_stats *mib = &pp->mib;
 	int res = 0;
 
 	/* Reading of yt921x_port::mib is not protected by a lock and it's vain
@@ -325,7 +325,7 @@ static int yt921x_read_mib(struct yt921x_priv *priv, int port)
 	return res;
 }
 
-static void yt921x_poll_mib(struct work_struct *work)
+static void yt921x_mib_poll(struct work_struct *work)
 {
 	struct yt921x_port *pp = container_of_const(work, struct yt921x_port,
 						    mib_read.work);
@@ -335,7 +335,7 @@ static void yt921x_poll_mib(struct work_struct *work)
 	int res;
 
 	mutex_lock(&priv->reg_lock);
-	res = yt921x_read_mib(priv, port);
+	res = yt921x_mib_read(priv, port);
 	mutex_unlock(&priv->reg_lock);
 	if (res)
 		delay *= 4;
@@ -363,11 +363,11 @@ yt921x_dsa_get_ethtool_stats(struct dsa_switch *ds, int port, uint64_t *data)
 {
 	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
 	struct yt921x_port *pp = &priv->ports[port];
-	struct yt921x_mib *mib = &pp->mib;
+	struct yt921x_mib_stats *mib = &pp->mib;
 	size_t j;
 
 	mutex_lock(&priv->reg_lock);
-	yt921x_read_mib(priv, port);
+	yt921x_mib_read(priv, port);
 	mutex_unlock(&priv->reg_lock);
 
 	j = 0;
@@ -405,10 +405,10 @@ yt921x_dsa_get_eth_mac_stats(struct dsa_switch *ds, int port,
 {
 	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
 	struct yt921x_port *pp = &priv->ports[port];
-	struct yt921x_mib *mib = &pp->mib;
+	struct yt921x_mib_stats *mib = &pp->mib;
 
 	mutex_lock(&priv->reg_lock);
-	yt921x_read_mib(priv, port);
+	yt921x_mib_read(priv, port);
 	mutex_unlock(&priv->reg_lock);
 
 	mac_stats->FramesTransmittedOK = pp->tx_frames;
@@ -441,10 +441,10 @@ yt921x_dsa_get_eth_ctrl_stats(struct dsa_switch *ds, int port,
 {
 	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
 	struct yt921x_port *pp = &priv->ports[port];
-	struct yt921x_mib *mib = &pp->mib;
+	struct yt921x_mib_stats *mib = &pp->mib;
 
 	mutex_lock(&priv->reg_lock);
-	yt921x_read_mib(priv, port);
+	yt921x_mib_read(priv, port);
 	mutex_unlock(&priv->reg_lock);
 
 	ctrl_stats->MACControlFramesTransmitted = mib->tx_pause;
@@ -470,10 +470,10 @@ yt921x_dsa_get_rmon_stats(struct dsa_switch *ds, int port,
 {
 	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
 	struct yt921x_port *pp = &priv->ports[port];
-	struct yt921x_mib *mib = &pp->mib;
+	struct yt921x_mib_stats *mib = &pp->mib;
 
 	mutex_lock(&priv->reg_lock);
-	yt921x_read_mib(priv, port);
+	yt921x_mib_read(priv, port);
 	mutex_unlock(&priv->reg_lock);
 
 	*ranges = yt921x_rmon_ranges;
@@ -506,7 +506,7 @@ yt921x_dsa_get_stats64(struct dsa_switch *ds, int port,
 {
 	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
 	struct yt921x_port *pp = &priv->ports[port];
-	struct yt921x_mib *mib = &pp->mib;
+	struct yt921x_mib_stats *mib = &pp->mib;
 
 	stats->rx_length_errors = mib->rx_undersize_errors +
 				  mib->rx_fragment_errors;
@@ -542,10 +542,10 @@ yt921x_dsa_get_pause_stats(struct dsa_switch *ds, int port,
 {
 	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
 	struct yt921x_port *pp = &priv->ports[port];
-	struct yt921x_mib *mib = &pp->mib;
+	struct yt921x_mib_stats *mib = &pp->mib;
 
 	mutex_lock(&priv->reg_lock);
-	yt921x_read_mib(priv, port);
+	yt921x_mib_read(priv, port);
 	mutex_unlock(&priv->reg_lock);
 
 	pause_stats->tx_pause_frames = mib->tx_pause;
@@ -4464,7 +4464,7 @@ static int yt921x_mdio_probe(struct mdio_device *mdiodev)
 		struct yt921x_port *pp = &priv->ports[i];
 
 		pp->index = i;
-		INIT_DELAYED_WORK(&pp->mib_read, yt921x_poll_mib);
+		INIT_DELAYED_WORK(&pp->mib_read, yt921x_mib_poll);
 	}
 
 	ds = &priv->ds;
diff --git a/drivers/net/dsa/motorcomm/chip.h b/drivers/net/dsa/motorcomm/chip.h
index 9c34fb704bf8..c1b24b6d1d97 100644
--- a/drivers/net/dsa/motorcomm/chip.h
+++ b/drivers/net/dsa/motorcomm/chip.h
@@ -833,7 +833,7 @@ enum yt921x_fdb_entry_status {
 
 #define YT921X_NAME	"yt921x"
 
-struct yt921x_mib {
+struct yt921x_mib_stats {
 	u64 rx_broadcast;
 	u64 rx_pause;
 	u64 rx_multicast;
@@ -918,7 +918,7 @@ struct yt921x_port {
 	bool isolated:1;
 
 	struct delayed_work mib_read;
-	struct yt921x_mib mib;
+	struct yt921x_mib_stats mib;
 	u64 rx_frames;
 	u64 tx_frames;
 
-- 
2.53.0

