Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9ADA4AB1A9
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 14:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790951307; cv=none; b=G+DgG4jROTbWjCSi3IIBEEGSHmTWyg5Vjs4W6ZQwsgJbYFlTXYBM0zdnzcKRlBVawFo4G9p1gxSFg8DcAok7saG4NxUh41etLD1yxLzxpzRJ8CL7qQM6gl+hnA/KiCh5yX51LQGYUHzUCGkENsB6xxzJmKfpsqHP69YSC1MPTLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790951307; c=relaxed/simple;
	bh=6ssKqR9ZJKtfTXkpLxF7ahG6r/p+chfohxVxdj5s9ZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UXkZh1KcOzjV4HK97VJfsjoHxzms4K6MlGwBCqXM0pqza+bTkhirxWOMrgK6rZ/axmcbAIoTYLG9PUooBLdv5h5nhulKS4+5P5hUJcxHU7N8a3Mx5NR6g1IqsvEjpRM5kQmYqRIf4R/j2shctCLs4BDoTxlte1VcOMOfVWpilrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=m7O7EwCo; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="m7O7EwCo"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 48F5C1A10B6;
	Fri,  2 Oct 2026 14:28:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 16CD6603DC;
	Fri,  2 Oct 2026 14:28:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6CB75103281DD;
	Fri,  2 Oct 2026 16:28:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790951302; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=SffXu3hph+l7rHbqur1+meEQTVzoWoS2OeulBiCttcI=;
	b=m7O7EwCoQtyD1DZTcCa6C8w7d07YNMLuYBlaq84m1Q3naatoa2FNvzDDPHDxuPAw/7lNRS
	H6tiRTPIK2g7KElchBqd2a3uDVbrsfYFIHplXuobWWmEj00VYe6IXF1A/JJyAbVpzptDoZ
	bc4l5ihzAc5KNdNUDDt/S7cprjQikSAlpPsUP6GygHoH+jy8I1/F0F9uXUMwv8XAzLi5ZS
	a6RvJTVQLkX1KXoMZyLAnIq0M4UXcd65NI0svJ6GVqrHvkc02GlD/t/t6FYZL5a9Axb8H7
	0E1aNveIG8MLxLHWby3Ml1uy/bdFQEFvf2FyQEijvmSQezVK39zWnP3hiZXFfA==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <linux@armlinux.org.uk>,
	Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	thomas.petazzoni@bootlin.com,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Peter Robinson <pbrobinson@gmail.com>,
	Joe Damato <joe@dama.to>
Subject: [PATCH net-next v3 1/3] net: rss: Require indir table size or hash key size to support RSS
Date: Fri,  2 Oct 2026 16:28:01 +0200
Message-ID: <20261002142806.1299041-2-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002142806.1299041-1-maxime.chevallier@bootlin.com>
References: <20261002142806.1299041-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

A point can be made that devices that report a 0-size indirection table
and 0-length key size don't really support RSS. Let's return -EOPNOTSUPP
in that case, and skip these devices during DUMP requests.

This however also reports -ENOTSUPP for devices that only supports flow
hash fields ops now.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 net/ethtool/ioctl.c | 6 ++++++
 net/ethtool/rss.c   | 7 +++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 27b0e2e275dc..d32b403c8d3a 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1444,6 +1444,9 @@ static noinline_for_stack int ethtool_get_rxfh(struct net_device *dev,
 	if (ops->get_rxfh_key_size)
 		rxfh_dev.key_size = ops->get_rxfh_key_size(dev);
 
+	if (!rxfh_dev.indir_size && !rxfh_dev.key_size)
+		return -EOPNOTSUPP;
+
 	if (copy_from_user(&rxfh, useraddr, sizeof(rxfh)))
 		return -EFAULT;
 	user_indir_size = rxfh.indir_size;
@@ -1554,6 +1557,9 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 	if (ops->get_rxfh_key_size)
 		dev_key_size = ops->get_rxfh_key_size(dev);
 
+	if (!dev_indir_size && !dev_key_size)
+		return -EOPNOTSUPP;
+
 	if (copy_from_user(&rxfh, useraddr, sizeof(rxfh)))
 		return -EFAULT;
 
diff --git a/net/ethtool/rss.c b/net/ethtool/rss.c
index d4a1a4724b67..cb9bead0cedd 100644
--- a/net/ethtool/rss.c
+++ b/net/ethtool/rss.c
@@ -129,6 +129,9 @@ rss_get_data_alloc(struct net_device *dev, struct rss_reply_data *data)
 	if (ops->get_rxfh_key_size)
 		data->hkey_size = ops->get_rxfh_key_size(dev);
 
+	if (!data->indir_size && !data->hkey_size)
+		return -EOPNOTSUPP;
+
 	indir_bytes = data->indir_size * sizeof(u32);
 	total_size = indir_bytes + data->hkey_size;
 	rss_config = kzalloc(total_size, GFP_KERNEL);
@@ -449,7 +452,7 @@ rss_dump_one_dev(struct sk_buff *skb, struct netlink_callback *cb,
 
 	if (!ctx->ctx_idx) {
 		ret = rss_dump_one_ctx(skb, cb, dev, 0);
-		if (ret)
+		if (ret && ret != -EOPNOTSUPP)
 			return ret;
 		ctx->ctx_idx++;
 	}
@@ -457,7 +460,7 @@ rss_dump_one_dev(struct sk_buff *skb, struct netlink_callback *cb,
 	for (; xa_find(&dev->ethtool->rss_ctx, &ctx->ctx_idx,
 		       ULONG_MAX, XA_PRESENT); ctx->ctx_idx++) {
 		ret = rss_dump_one_ctx(skb, cb, dev, ctx->ctx_idx);
-		if (ret)
+		if (ret && ret != -EOPNOTSUPP)
 			return ret;
 	}
 	ctx->ctx_idx = ctx->start_ctx;
-- 
2.55.0

