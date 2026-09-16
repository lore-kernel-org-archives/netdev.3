Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C2833936A
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 13:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789564961; cv=none; b=Z9iZl2ux2Tdq0ZEH5dKtkn3pPx0wbRYjI5yGwlMdnnxHZZM2GPkAKZnygMaj0ba/sTPmFKbpnbBw1XithYwPsDSCjwKmDJGQjARMcpuXzRTIaeJ/s5RELGH0tdp6l5xf9kxQwJcx+NU7ss9gWwDM3Way0VNuw7P9mQuEnWkgeOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789564961; c=relaxed/simple;
	bh=91H0C8RtsUlFqHfcZ3lNDPTqqpRYJ2clWP1gyVXr8EA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PCmsXbj1260IY6/QRQE6NmrGExUNz8jfIpMelOnrt2mtcx9vBn6zy8FsyTdbHspU6C3xQWN9gIv0uJ8G3zTRQJczvYtcbSUNMoAnwqjKXu0zx8uEj68erXN8kY+8m6Qi6H06DNygjy7FA7HdVBRYjIbGEaO+OT8xLhHKk/UFSfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xd8Xg9zH; arc=none smtp.client-ip=209.85.160.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xd8Xg9zH"
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-53286131b0dso7319891cf.2
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 06:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789564957; x=1790169757; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tuY96yIqcwo1HVMP/GXPyzxWFqfQRdJgg2/5nlndmh4=;
        b=Xd8Xg9zH/iHMacQu501ufeYsgu2dGJvdXeiG4qhGHojO8k8wDub6ki1Rg7ruJHaG83
         OOOVo8e7NSIO1Oo7UrOFjV1XurfZqnbaS9kIFhXLa8sRyOrrP4Tcu2OOhjiGTjOTPLWR
         22ZUqnNfwsJu+FMLTgtUywpzZBe51KQJRntkp0AWPNeUT//F3zbfqK/hnfzX0A3d+AWV
         CFBpvtBZr0TdT1fBtADNigkW0MtFQcPuTxxM2LeujwxCIZjfvyC1E031QjBrrEHexgT9
         t4q6wK6neL3FhHTvMtysp+EeN9sOUGRmQmGTil+GveJtEu1x3O08YPiAeBbj5qon75YP
         Cd/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789564957; x=1790169757;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tuY96yIqcwo1HVMP/GXPyzxWFqfQRdJgg2/5nlndmh4=;
        b=cDiuXdafcrOenymw3mcbgQQkIicytJLJM6Z07fQ2DZpBkoUQ4mMh+Dn8Zi/WZZmS6x
         0ekIQDBVkpCft7VMY3p16Y9S2kMK289RTrO6DEde/SG5jBBZbkK8/bKMraQDlDd8PRw1
         2OdpQYrxjd7tq+XHMln+viF0tkP9S6CAsviWnQCdeugGmvBEUkOH01hfpF48sHdOKb+B
         1UTxjPl3Kt6UHu9zcNFy+VwSCSfEHENzuVo/UQ7U9icoFEpxrNsmhsakBFqkjm2pNaFx
         aBVdCEWsEBWC489WTfHRMQ/cP1l7R/daq/Zgvm0Y1lK8xgm7G+t5W8qSqKgMKSZqNPOb
         gU7w==
X-Forwarded-Encrypted: i=1; AKwUvBw7iCryLTcNAUQmU9s8tMy+uNcIASSLCfckgNVPFz+c/aXX0Rj8ESYcyAWr7ozcwswJay/sZNI=@vger.kernel.org
X-Gm-Message-State: AFuF++lo1pJl1xtjR5oaW0JODiabd6KQxiJxqF3/rCglRKfKYX/jnpVn
	gQEOEL7U50OP18/TAsh7TXHLZVKNrK9WFRrckIyRTb8md0A647fzlZEweODSva58g29BXl3RweK
	agRrg5/6InVc9vA==
X-Received: from qtbcd12.prod.google.com ([2002:a05:622a:418c:b0:531:2e6:f213])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5891:0:b0:530:3cde:b8b0 with SMTP id d75a77b69052e-5327eddad53mr43181531cf.13.1789564956695;
 Wed, 16 Sep 2026 06:22:36 -0700 (PDT)
Date: Wed, 16 Sep 2026 13:22:31 +0000
In-Reply-To: <20260916132231.1780091-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260916132231.1780091-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260916132231.1780091-4-edumazet@google.com>
Subject: [PATCH net-next 3/3] net: rmnet: no longer rely on RTNL in rmnet_fill_info()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, 
	Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>, 
	Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

rmnet_fill_info() used rmnet_get_port_rtnl(), and thus required
RTNL.

Now that priv->mux_id and port->data_format are properly
annotated, rmnet_fill_info() can simply fetch the port under
rcu_read_lock().

rmnet_get_port_rcu() was only used from the data path and thus
used rcu_dereference_bh(). Relax its lockdep condition so that it
can also be called from process context under a plain
rcu_read_lock(), and use it from rmnet_fill_info().

Note that rmnet_get_port_rcu() checks real_dev->rx_handler before
returning rx_handler_data: this is what makes the lockless lookup
safe against rmnet_unregister_real_device(), which clears
rx_handler, waits for a grace period in
netdev_rx_handler_unregister(), and only then frees the port.

While at it, add missing const qualifiers.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>
Cc: Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>
---
 .../ethernet/qualcomm/rmnet/rmnet_config.c    | 38 +++++++++----------
 .../ethernet/qualcomm/rmnet/rmnet_config.h    |  2 +-
 2 files changed, 18 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
index 248a9d822409b7cbf3739c085487644b7025dd37..b930f638ec448de839806852a74fc4b2f8888e43 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
@@ -371,32 +371,24 @@ static size_t rmnet_get_size(const struct net_device *dev)
 
 static int rmnet_fill_info(struct sk_buff *skb, const struct net_device *dev)
 {
-	struct rmnet_priv *priv = netdev_priv(dev);
-	struct net_device *real_dev;
+	const struct rmnet_priv *priv = netdev_priv(dev);
+	const struct rmnet_port *port;
 	struct ifla_rmnet_flags f;
-	struct rmnet_port *port;
 
-	real_dev = priv->real_dev;
+	if (nla_put_u16(skb, IFLA_RMNET_MUX_ID, READ_ONCE(priv->mux_id)))
+		return -EMSGSIZE;
 
-	if (nla_put_u16(skb, IFLA_RMNET_MUX_ID, priv->mux_id))
-		goto nla_put_failure;
-
-	if (rmnet_is_real_dev_registered(real_dev)) {
-		port = rmnet_get_port_rtnl(real_dev);
-		f.flags = port->data_format;
-	} else {
-		f.flags = 0;
-	}
+	rcu_read_lock();
+	port = rmnet_get_port_rcu(priv->real_dev);
+	f.flags = port ? READ_ONCE(port->data_format) : 0;
+	rcu_read_unlock();
 
 	f.mask  = ~0;
 
 	if (nla_put(skb, IFLA_RMNET_FLAGS, sizeof(f), &f))
-		goto nla_put_failure;
+		return -EMSGSIZE;
 
 	return 0;
-
-nla_put_failure:
-	return -EMSGSIZE;
 }
 
 struct rtnl_link_ops rmnet_link_ops __read_mostly = {
@@ -413,12 +405,16 @@ struct rtnl_link_ops rmnet_link_ops __read_mostly = {
 	.fill_info	= rmnet_fill_info,
 };
 
-struct rmnet_port *rmnet_get_port_rcu(struct net_device *real_dev)
+/* Can be called from a RCU read-side critical section, with or
+ * without BH disabled.
+ */
+struct rmnet_port *rmnet_get_port_rcu(const struct net_device *real_dev)
 {
-	if (rmnet_is_real_dev_registered(real_dev))
-		return rcu_dereference_bh(real_dev->rx_handler_data);
-	else
+	if (!rmnet_is_real_dev_registered(real_dev))
 		return NULL;
+
+	return rcu_dereference_check(real_dev->rx_handler_data,
+				     rcu_read_lock_bh_held());
 }
 
 struct rmnet_endpoint *rmnet_get_endpoint(struct rmnet_port *port, u8 mux_id)
diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.h b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.h
index f50fae1c6bdd5d4edfb18476e2ca44057921a472..5adda0323dda776d69d50d22bc75456b43442e3d 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.h
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.h
@@ -90,7 +90,7 @@ struct rmnet_priv {
 	struct rmnet_priv_stats stats;
 };
 
-struct rmnet_port *rmnet_get_port_rcu(struct net_device *real_dev);
+struct rmnet_port *rmnet_get_port_rcu(const struct net_device *real_dev);
 struct rmnet_endpoint *rmnet_get_endpoint(struct rmnet_port *port, u8 mux_id);
 int rmnet_add_bridge(struct net_device *rmnet_dev,
 		     struct net_device *slave_dev,
-- 
2.55.0.1032.g73a4cd73de-goog

