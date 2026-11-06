Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793952946;
	b=h+TdkKexs+1hDuOo2P7MbguebsdHXQ94gGpKD8rYSI7oq7Glv2fKFyWp3jKD1PGOXCu7
	 z5xhzmPthGHg9E1Y2jyOdQgUMWamHW63uv1EUyM4gU746gjaACoKNc0hJkm/M7CAcM6IF
	 LiBlaGpKUTMluMXwb74UAzjfnj3ht5RN8y8Gj3HQ4WboMZVxMY2FXc0b7bA4SeAEMibJt
	 4fOxSsg10Cvp907PlbnusZzzYAw7vvuFBuIArdZiWhBFv5n8NWpxgYrs9kqy8f6n4G5qF
	 8SOQm7KwSeVR+Qoe17TV4U2toDx8/zxxlPAituEvmF/g4GBNj5j6Wkiyg+zTlaYGGIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793952946;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Yjrd5/AaZ2KwuSGRJZ8wqDYRBz8IJBU1ScARgfXbQgI=;
	b=5GW0JcWZj9hDmd+YZph/B8ZeIt2xHM52xIpW6HN8OTeD2rxTYhpqLxP+TyFOd+a4oyLL
	 yStNvoxn8tyNj3UeqLhVK8iYfYrJDu0WpiVjJrO8eGMmIts0Isv8z9Iex4oRGxd6q2BnR
	 PO6b/Mn3lnuzTqQNkAa80Rwr/k7Iqi3NHx416GYA+fspJFi0oqgiUEOhMTOkDd3Ugvz6R
	 NvYkXQtqV07EP1AEbUxko+ybMFayk4NWA3opvv5/OotzzJiYNBVeiYhcJ4nY3rh/HwH5A
	 rnXb3dK8RpqvhC/JWIEmeovXrOOYHqAKs8S9IplVMw+EDWs25rhsR64CZyB/lAETyHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gLVhk4Og;
	arc=none smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8514606A32F
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 08:15:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8514606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gLVhk4Og
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cdaefe02d5dso216232a12.1
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 00:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793952945; x=1794557745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Yjrd5/AaZ2KwuSGRJZ8wqDYRBz8IJBU1ScARgfXbQgI=;
        b=gLVhk4OgUMig+8O+Cdc/qC5Ka7fWw25GTnnEGlvg9UhPMDlNSVpXBbl8rr91ELnZYa
         dkU+n4Qt28dG8AXQlKU+OChgQ0EhjvHpU6sOIra8nIeA2hxeMvVzCr+fFBoSmCcMy6zQ
         9XBAkzjy75dGIygyvhH1XR7+gs99FFuzzYjcs0GKg+XwnHfDHlDyRspOlOPIclh+dcQv
         IPuYM1k/N/iy9i5HdcThX0BYahRd4wWa8b96hpCztru8AR/DD5FYH7y/IpEkJokFKipN
         2ySqpzBhmwFQLC9fY1Y8HTPfHX9qayqNc4nkATdlIxpO14yPNAtVe6i86YM8unPH0lxB
         o8lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793952945; x=1794557745;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Yjrd5/AaZ2KwuSGRJZ8wqDYRBz8IJBU1ScARgfXbQgI=;
        b=z0/OUhxZtuXCYqzP41vMHyH5oAq4BTAvubyb96dQIRNiVJ9BM0pqhHcDrni7sx3xf4
         QvuvYcaBw09BNj2Yjd2E9w3gLdr+H2sA6qt3EHrnezWA9JJFkOEFFtqXOnzWNYi0LQzN
         3zBGj/CRT1O4HcSuDsMbEd7jU5tJ0Nb3kGIXJ2gRlY3FHwrYi7319H6p9gjoSn8KQKWA
         v4drkaD4TYdhSQoSB2cGZJI/W7ua4IF5GtZRyCGRm49Vt4PzYXQWgA0qk11ZV+7ECUCO
         T1xrXd5f62yiM322WxdQ1YVTgPlNTuX2HA/klD4GkfeDaEC1Z+OHQpU8deO7aFyLbO5W
         8ViA==
X-Forwarded-Encrypted: i=1; AL+hErH0ziP8BSaP1ohSbCyQhBNcDPy/9Ef094EHWLphZa2ScdxHQkQ2Z7X4IaMmb/9N7wzIBnGqsbU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/nVG9e1/m6KlXV79UNoP12YucdHIj6HRU/B/6Tn6BrJVjcWqm2
	ks2ZfKgUQ7o6lxbu6Q2NF0+/B68CCQMGRym8GfrLAKYJfiPLDRNrdLMm
X-Gm-Gg: AYBFou3qV+GRbDjq9blfPA2Oen4bs3vd7BARMWCK0i9UATuy6fBt3L63G6tOGq9OirR
	OR0wJXyNLDmy0S3cqRBRpi0DyConiqFxV3RBCaJV54L5VBd7yTH1+qDjVQm5mfgEW6NY90v2xXr
	lVCxx7U0VZ5w57yUUeL2gsxigzRROaEer6YmssSlG08QrVkHnkHEW8lrdanbSXnmZgBQgeRIjKw
	95aiCzLly2zuKfq7xYe6XXJmu7+6Xgzo3ibtvDbgDdRmjcEeQ5feeoSOk7yUWHxUctJMp9zE+Uv
	AWWFinR0W8aWqxxnTcsH3mH4QyRjxV9tlb4wWQKspUaQpObrZ3su42OFDlNJijyeYAjWGfse5v9
	wIhN7WxRbfbb90LKvq+D+oAvLmnx0QyvYnkZ+53WE8QoBGXKDaG0LPzc4TttjmiKOOpep5Jj5Oa
	wpGImdJdlfVCx04LeFZYhViqajz/Cjcjw4krA2jvRKDHzvOgWQVTqQu5HdHfC3A3ZM+g6zwS7Oc
	TRhNRyqSEw3FI0gddhSXyvO05NncN/0YkwTux50r+RQrEz426VStzBr4shD7pvdBLrMgkb0c4IM
	NJR+rC1qHxryWHxs+jr04cM17VCoWk4LLKT4tjRg8Hcc8v6VXWQ1/C/Fu4njaQwCzPcx0Z2s25n
	XVxmo/D/h7Z6c
X-Received: by 2002:a17:90b:3f4b:b0:3ad:eb34:4c6c with SMTP id 98e67ed59e1d1-3b0db6b196bmr2024337a91.13.1793952944965;
        Fri, 06 Nov 2026 00:15:44 -0800 (PST)
Received: from JUNVYYANG-MC1.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed47d4034asm3082275ad.41.2026.11.06.00.15.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Nov 2026 00:15:44 -0800 (PST)
From: Jun Yang <juny24602@gmail.com>
To: Jason@zx2c4.com,
	andrew+netdev@lunn.ch
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org,
	Jun Yang <junvyyang@tencent.com>,
	stable@kernel.org,
	TencentOS Corvus AI <corvus@tencent.com>
Subject: [PATCH net] wireguard: flush endpoint dst cache when a peer is removed
Date: Fri,  6 Nov 2026 16:15:17 +0800
Message-ID: <20261106081538.69465-1-juny24602@gmail.com>
X-Mailer: git-send-email 2.54.0
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

From: Jun Yang <junvyyang@tencent.com>

peer_make_dead() removes a peer from wg->peer_list, but a netlink device
dump can keep it alive through ctx->next_peer. If the WireGuard device
has moved to another network namespace, wg_netns_exit_rtnl() skips the
removed peer when flushing endpoint caches for the original namespace.
A cached IPv6 RTF_CACHE dst can then survive ip6_route_net_exit(), and
its later release from rcu_release() accesses the destroyed per-netns
dst counter.

Mark the peer dead and flush its endpoint cache under endpoint_lock.
Bypass the cache for dead peers in the send path so an in-flight sender
cannot repopulate it after the flush.

Fixes: 20ae1d6aa159 ("wireguard: device: reset peer src endpoint when netns exits")
Cc: stable@kernel.org
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Signed-off-by: Jun Yang <junvyyang@tencent.com>
---
A KASAN reproducer for this issue is available if requested.

 drivers/net/wireguard/peer.c   | 5 ++++-
 drivers/net/wireguard/socket.c | 6 ++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireguard/peer.c b/drivers/net/wireguard/peer.c
index 1cb502a932e0..c8d9396b1f13 100644
--- a/drivers/net/wireguard/peer.c
+++ b/drivers/net/wireguard/peer.c
@@ -85,8 +85,11 @@ static void peer_make_dead(struct wg_peer *peer)
 				     &peer->device->device_update_lock);
 	wg_pubkey_hashtable_remove(peer->device->peer_hashtable, peer);
 
-	/* Mark as dead, so that we don't allow jumping contexts after. */
+	/* Mark as dead and flush the cache before the peer's netns exits. */
+	write_lock_bh(&peer->endpoint_lock);
 	WRITE_ONCE(peer->is_dead, true);
+	dst_cache_reset_now(&peer->endpoint_cache);
+	write_unlock_bh(&peer->endpoint_lock);
 
 	/* The caller must now synchronize_net() for this to take effect. */
 }
diff --git a/drivers/net/wireguard/socket.c b/drivers/net/wireguard/socket.c
index 0028ef17dc71..0cd916d480b2 100644
--- a/drivers/net/wireguard/socket.c
+++ b/drivers/net/wireguard/socket.c
@@ -167,15 +167,17 @@ out:
 int wg_socket_send_skb_to_peer(struct wg_peer *peer, struct sk_buff *skb, u8 ds)
 {
 	size_t skb_len = skb->len;
+	struct dst_cache *cache;
 	int ret = -EAFNOSUPPORT;
 
 	read_lock_bh(&peer->endpoint_lock);
+	cache = READ_ONCE(peer->is_dead) ? NULL : &peer->endpoint_cache;
 	if (peer->endpoint.addr.sa_family == AF_INET)
 		ret = send4(peer->device, skb, &peer->endpoint, ds,
-			    &peer->endpoint_cache);
+			    cache);
 	else if (peer->endpoint.addr.sa_family == AF_INET6)
 		ret = send6(peer->device, skb, &peer->endpoint, ds,
-			    &peer->endpoint_cache);
+			    cache);
 	else
 		dev_kfree_skb(skb);
 	if (likely(!ret))
-- 
2.43.7

