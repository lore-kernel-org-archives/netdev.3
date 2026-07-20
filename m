Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6A2431E46
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 14:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784558516; cv=none; b=uZsuL0ReyyKYlG9KozFDkqtxYisqVbRqwrhe4n3ZIvHFF/lSEP36IpLiUYqigTEl035fizdThmZkBkgkEmUjBaTBuSPXsx0XyOXQ+vo0Ps82UZ6mVkBozw/0oU9kTdUqrO6VrJLkn/jCejueaNAyPbPEqypB3MvISRc9UuW6nxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784558516; c=relaxed/simple;
	bh=QFNxn9kPvO3TcTW6kJAa8TofDYUnbld8q6Mr6J7e+08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PmUWl0TIY6eO3o3g1idXYGMwPUJ7QQQq3KHihudLQSmSMLrh9RIw5WTiOMit6NOuGa989VdEm/bwYXXqBRkRlYNWlL+SCQBMpM8EhHF+xEUBMoIsD+mFWgUHWh69wIMoRv/IJXSuZ0UzQX1D9rvjqj063+TvKa3FHQQ2fQMLua0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=TwVFFvTq; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="TwVFFvTq"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4758bd3731bso3142882f8f.0
        for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 07:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1784558509; x=1785163309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dzUCFg9ikhOiVOnGRsSS8Jafc+aIMsvar88yn2q6BQQ=;
        b=TwVFFvTqVdA/gy5kTtHWZGNW8oz0u6zAhgco8SXWTYjfsza/RLCOy3OCtbLxaVLM86
         32vtCcAy+IvKvgye34KafO7P3Zg7xsrhK3cfWyXMTuepZjZFC/W2WRCcqiGbtwS+/J1X
         JsGmFT3TcExzup6bw9ZImM4NS4fQx5SQ/JuLlnH/a60aEwmwOE4uA0O2yFKub4o9H2HQ
         JYjucIlJ9woKyrFSOTgXnolrDCxOnQ7h+12N3oNTvvA3VPMmHLmJCJmzRtaR2cvqNQlB
         jmlyeYEaSN4JywdUwZnf4KX1MY9pMw2CoNRQm+yNkUFfExAKloWTycWKe8Q+ElozuViL
         fYsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784558509; x=1785163309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dzUCFg9ikhOiVOnGRsSS8Jafc+aIMsvar88yn2q6BQQ=;
        b=DBFH8+sXIgUo61HF/fmMU/a1AUJvXUVjLKwcoYGrdgIXYM6qNLDzan57urMVmWgnHg
         xQUvU1rjf2xyAcUoupcDBkFQpXtXAjx+d9edbEkWeoGuCOn9ZA4QBfYHyOLk8QscmdEi
         5r70n2ZUULc/zEnak45/tASfX0AKpdYk7z1V6dLexA/CiRncUa8fsS7OD/Ph2UW4/j3f
         iz0+cxz6mpNV3Ko4ECkqLrjukdQcsKMqs5d+46BkMW19eHcfSTqE6xXjopHEeXEvrynr
         ex9r/FmHQ0sA6zWieUCS9LbFIl76sRc2SnBT1rk3vlctU2FEx6q/Cp2lpNIs5F3nJiR9
         xdBA==
X-Gm-Message-State: AOJu0Yytlq40/PHvfTZ87jEk0UGQTfvzLkxWHUbFQlz7m7lDDqLZjA34
	/pc8NOG2vAZVgSINETkhHfqtL+LWHAz67McJNfRLuDCeotEp6FAIEfZiOi/tchEuyt8uT150z41
	/55GJbXOGXLdgnZHG3IZb2JQYgWtoIdSl/3x3wSdzSXCAcSbJE14fht7jvfYth/fk
X-Gm-Gg: AR+sD13OeYF8A8jOm8VPFaRebJH6FTHvHc68p8xGb44SKl9LEji2wH6Qr+4OuCR997A
	LiNN6DINvz5W6cH3eLHmFnnpbvOMjCALNESGrYPldzaKZcTiDszRhwz/WUlG4Lm8dL5JELg4f0i
	43dilODH34zSKjncZx2nhGKZCQzgA8ZN7dqr5v+VZNdCUFZyJAquOBoVWzawar0KoOqOCNGAKgX
	Mc62JyjxnK4R6w2fbs5eJKaViult63MzVgplgTFa+fsKMYGgc4kpjGksdoZdhHavtISZRJbKMZe
	IsO6lw/0IGcTGeT3Qz2YJpkWP3N9ODHB7WIL/2MZzM2rHchLasw1hBKCahxpD/GxxHCjeDhF1ke
	QKRzZzWFxx08UHScoqApcpbBUiOXYcdcZrW4e76VM79671Q6+RVt5cXv96LcNiH+82eB4pScHbI
	OUsZs0YocCxLgttQtpXGn9id7qow==
X-Received: by 2002:a05:6000:2005:b0:45a:5392:3a19 with SMTP id ffacd0b85a97d-47f5a54880dmr23186190f8f.16.1784558508784;
        Mon, 20 Jul 2026 07:41:48 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:32cf:3416:35c6:c361])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e51c33sm26387406f8f.12.2026.07.20.07.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 07:41:47 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Ralf Lici <ralf@mandelbit.com>,
	Marco Baffo <marco@mandelbit.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net 6/6] ovpn: use monotonic clock for peer keepalive timeouts
Date: Mon, 20 Jul 2026 16:41:31 +0200
Message-ID: <20260720144131.3657121-7-antonio@openvpn.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260720144131.3657121-1-antonio@openvpn.net>
References: <20260720144131.3657121-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marco Baffo <marco@mandelbit.com>

Replace ktime_get_real_seconds() with the monotonic
ktime_get_boottime_seconds() to ensure the keepalive mechanism is robust
against system clock modifications.

Right now, the driver uses ktime_get_real_seconds() to track peer
timeouts, relying on the system wall-clock.

An administrative time adjustment or an NTP sync that steps the clock
forward can cause `now' to instantly exceed `last_recv + timeout'.

When this occurs, the driver artificially expires healthy peers.
Depending on the OpenVPN user-space configuration, this triggers a
premature tunnel restart (if --keepalive or --ping-restart is used) or
a complete disconnection of the client (if --ping-exit is used).

Fixes: 3ecfd9349f40 ("ovpn: implement keepalive mechanism")
Signed-off-by: Marco Baffo <marco@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/io.c   | 4 ++--
 drivers/net/ovpn/peer.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index a6b777a9c2d9..9a66d693039a 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -142,7 +142,7 @@ void ovpn_decrypt_post(void *data, int ret)
 	}
 
 	/* keep track of last received authenticated packet for keepalive */
-	WRITE_ONCE(peer->last_recv, ktime_get_real_seconds());
+	WRITE_ONCE(peer->last_recv, ktime_get_boottime_seconds());
 
 	rcu_read_lock();
 	sock = rcu_dereference(peer->sock);
@@ -294,7 +294,7 @@ void ovpn_encrypt_post(void *data, int ret)
 
 	ovpn_peer_stats_increment_tx(&peer->link_stats, orig_len);
 	/* keep track of last sent packet for keepalive */
-	WRITE_ONCE(peer->last_sent, ktime_get_real_seconds());
+	WRITE_ONCE(peer->last_sent, ktime_get_boottime_seconds());
 	/* skb passed down the stack - don't free it */
 	skb = NULL;
 err_unlock:
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 8fdbb5050690..a21d02ac715e 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -45,7 +45,7 @@ static void unlock_ovpn(struct ovpn_priv *ovpn,
  */
 void ovpn_peer_keepalive_set(struct ovpn_peer *peer, u32 interval, u32 timeout)
 {
-	time64_t now = ktime_get_real_seconds();
+	time64_t now = ktime_get_boottime_seconds();
 
 	netdev_dbg(peer->ovpn->dev,
 		   "scheduling keepalive for peer %u: interval=%u timeout=%u\n",
@@ -1359,7 +1359,7 @@ void ovpn_peer_keepalive_work(struct work_struct *work)
 {
 	struct ovpn_priv *ovpn = container_of(work, struct ovpn_priv,
 					      keepalive_work.work);
-	time64_t next_run = 0, now = ktime_get_real_seconds();
+	time64_t next_run = 0, now = ktime_get_boottime_seconds();
 	LLIST_HEAD(release_list);
 
 	spin_lock_bh(&ovpn->lock);
-- 
2.54.0

