Received: from mail-wr2-f41.google.com (mail-wr2-f41.google.com [74.125.225.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3108746E005
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 10:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789986145; cv=none; b=DZYcEv/fEAB4Zp9otIlr39JIP6M1feE2xuP69ZqLMTk2psUitsoEOcDQ2f6qi0UI95mj+BzboXCl9HvZWganu4RQBtbLg/KPPQ5Ry5uxcXF1XFDc9v3MV99fMwlR8VLoUGkxliOMF6aOqConhwXvxN7bz6BtgkUFspY6Ad8uhRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789986145; c=relaxed/simple;
	bh=G+LWrhdvJ4VBekvLkkGLrCqqybT/UgS7x8xeHtxvesE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rThSw+yqUw3I7wCHpEi6mrepCezvNDtLpJSdn9UXxPMwoua9y3Vud8JAwitr4d55YLnOzsiEVs6/Pnz4AqfvFKKzfNLtmlzbgMPzugXzz0zNUFM685pb8YFu1leKs7XWKcA7BjUzDy7QleQzGD330dLf7rMRz2HJXyw5e4iE79E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=OzqgCheW; arc=none smtp.client-ip=74.125.225.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="OzqgCheW"
Received: by mail-wr2-f41.google.com with SMTP id ffacd0b85a97d-4834977ae75so1519129f8f.3
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 03:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1789986142; x=1790590942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nXS6EKk/wUlf3T6J3WN0te310D5H9/qIePxJFSm5tRU=;
        b=OzqgCheWpcBN+3fqBmVDISp66r4+P6LNuetX+Z5/zcwCH+rsXBqyqZKKP3n9hrMUwP
         kkWDHb9kH9EkJ+GwVqgPEph9O7MfDa+vIph2tCMPAaO6U05R0bQ7/AM54jz0Stg6wGqs
         a9dX5FUyWU58PUz82rDwkZ0MwsKhHJYya6Yr9SUCXdyZpGzZz3QMwWpqIuCw9UxmmtZT
         k3ZVNU82FymJweowqO7cvSooKtzldNAOAdcX8RhgupWp2R30xFy03KmIV77UWeHUzd8I
         jxk5/RRfgFXpoXAiNDO2NWM7GOFHLdpzYGoB4IWYj3UO8wWszrYWG3EoGkART6STFpDz
         r5Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789986142; x=1790590942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nXS6EKk/wUlf3T6J3WN0te310D5H9/qIePxJFSm5tRU=;
        b=nir2C8JKU8g3tJH3iR+8GKnS4yffwkzSuriklVJv2c2jvnXTL0XScf+lRIdJ4JzA8g
         pv0mud0kzfZ3zZl8MnFNYEDnSXdYnLqxQ5jwLZzIDnkEAdjRbIwFGBD8805u3DX9ozrt
         I9Nv96tfcKL8EiMfxuLlOkJobpoIQtfhpiC4brS0yzfr0wBApmPT3GM52liscjY5pXc3
         6Chj1SzLR8LZUMqwzk2JFeAC6UvVkF3AUzAbfmmqqmpSI1FVzbXbGDFKEJi714VaJeXq
         XFj/vAKbr4PgLAVcQRgT9UFuuuAhCjEgrB0/eGduWGP9NOSO9Fuajk1Zx3U7RhMDvprp
         GgIw==
X-Gm-Message-State: AFuF++njMyb+zUJtX5hMGOS3QhH9x33YSIbLQECLR7B5hbMIp9jnKiPl
	dMhFl/z2X3jdfP5dUJg2LGPsV89k62csi1vshqCYy475ptkknMDfsv9PGdiCn3uwb2mpcf1A6nR
	byQtOq7hLSiBsef3dQzZ9dFK6eG6YlW17dTyEMQ3o4z/LPOeXbu6i0Rjm97EE10wWFBc=
X-Gm-Gg: AYBFou2hvSNXmWTqvZVHtDxZLSDU0z5RG5tgf9mwQ39pytOTgupYO5EIl0VdqxEoaAm
	JFTK1eIf78sij8BrM+Jz9yIsxQ23BYYHxU67zT43sqntps8kyvybIgFCOUvahosbIb2RswSsJG6
	HseI81aS+JS69PqcolG3ysxBdLXzf+HF+ZF4blz3hluJE7mitqouIfEv7hiV4XzImv1UMImbo/M
	32lfJwml7ZIKSLn13DNXaIwwzIE9YEBK18SJ5BkVgjAVDg9I8BiPqtTD20XWpOnBL+tzHuPnCUd
	Vy+flOES5ZMo3M2qj07OfzA9hDH9/Jiqugpc//Oa8D3cee/jU8coe/7ZsO7reek/2Co3K98PDOn
	7U7dgoCS5nGqeAgReYPeKFa0zouLWFWqZwZZ5Ho3UBvHN5ykc22+aVKV6EGYrLPhJ/gH9GkGKfn
	Ph3g/JU6bhV8X3ffJEkyCLiIvVKszALpxX4RlVdC1ILh3AU2x8dAwpzi+PrqCbi8yHL4ze97xvO
	6EhxPq6BNU=
X-Received: by 2002:a05:6000:2511:b0:487:27f6:a4dd with SMTP id ffacd0b85a97d-48727f6a651mr7293508f8f.45.1789986142356;
        Mon, 21 Sep 2026 03:22:22 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:b03b:2cfc:7208:2ecf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48724583fffsm20925476f8f.23.2026.09.21.03.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 03:22:21 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Ralf Lici <ralf@mandelbit.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net 04/11] ovpn: validate peer state before caching UDP dst
Date: Mon, 21 Sep 2026 12:22:05 +0200
Message-ID: <20260921102215.3599702-5-antonio@openvpn.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921102215.3599702-1-antonio@openvpn.net>
References: <20260921102215.3599702-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ralf Lici <ralf@mandelbit.com>

UDP route lookup runs without peer->lock while the bind is protected by
RCU. The route key is snapshotted separately. Either can change while
the lookup is in progress.

The TX path currently checks only the route key before publishing the
looked-up dst. If the bind changes but the route key does not, a dst
resolved from the old endpoint can be installed in the cache after the
bind replacement.

Compare both the bind pointer and the route key under peer->lock before
updating the cache. The RCU read-side critical section keeps the old
bind alive throughout the lookup, so pointer identity is sufficient to
detect a replacement.

Fixes: f0281c1d3732 ("ovpn: add support for updating local or remote UDP endpoint")
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/udp.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index c6d591cb7ff4..eeef4a7229f5 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -173,6 +173,35 @@ static void ovpn_dst_cache_check_key(struct ovpn_peer *peer,
 	spin_unlock_bh(&peer->lock);
 }
 
+/**
+ * ovpn_dst_cache_current - check whether a route lookup matches peer state
+ * @peer: the peer owning the bind and dst cache
+ * @bind: the RCU bind used for the route lookup
+ * @key: the route key used for the route lookup
+ *
+ * Check that @bind is still the current peer bind and that @key still matches
+ * the peer route key. The caller must hold @peer->lock. The TX path keeps
+ * @bind inside an RCU read-side critical section, so pointer identity is enough
+ * to detect whether the bind was replaced while the route lookup was running.
+ *
+ * Return: true if the lookup result still matches the current peer state and
+ * may update the dst cache.
+ */
+static bool ovpn_dst_cache_current(const struct ovpn_peer *peer,
+				   const struct ovpn_bind *bind,
+				   const struct ovpn_route_key *key)
+{
+	const struct ovpn_bind *curr_bind;
+
+	lockdep_assert_held(&peer->lock);
+
+	curr_bind = rcu_dereference_protected(peer->bind,
+					      lockdep_is_held(&peer->lock));
+
+	return curr_bind == bind &&
+	       ovpn_route_key_equal(key, &peer->route_key);
+}
+
 /**
  * ovpn_udp4_output - send IPv4 packet over udp socket
  * @peer: the destination peer
@@ -240,7 +269,7 @@ static int ovpn_udp4_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 
 	/* avoid storing a stale cache */
 	spin_lock_bh(&peer->lock);
-	if (likely(ovpn_route_key_equal(key, &peer->route_key)))
+	if (likely(ovpn_dst_cache_current(peer, bind, key)))
 		dst_cache_set_ip4(cache, &rt->dst, fl.saddr);
 	spin_unlock_bh(&peer->lock);
 
@@ -313,7 +342,7 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 
 	/* avoid storing a stale cache */
 	spin_lock_bh(&peer->lock);
-	if (likely(ovpn_route_key_equal(key, &peer->route_key)))
+	if (likely(ovpn_dst_cache_current(peer, bind, key)))
 		dst_cache_set_ip6(cache, dst, &fl.saddr);
 	spin_unlock_bh(&peer->lock);
 
-- 
2.55.0

