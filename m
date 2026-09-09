Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5782252D2C0
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 23:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788997469; cv=none; b=PpcrtuvLIrWb0bceLC09i2fgU56KHPRjaSpSOPz4XByhcwdDNlraEn8umCgg93A1KOu07OQIKCpAdsWQ0dZGI4xrk4+nM5zcE5hozuWbYBoeKrK6EPkkMSuoZ4/sb/woPF/ikeFKlAq4mp2IzUMv5o1CfGQv7x6Hhg4FlWeRInU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788997469; c=relaxed/simple;
	bh=6rZoiXV5GkYLnfVyF4OoL8LqNc3AW6ZIWJWHMrb4WZ4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NFSLUz9uSAAgW4WVQp7owlCsEyVn8hyK4pCjYBSXvzwAv3jTQM7yB03l9g6SV2DfORwaM0DMpoRZNFcV3nttUFgqIUpUgjrdy9G8LXaSauA+idJXePIgb5jU8jaOuX5SJQdoz7tt9cK8Yy5VimUo+haqZVTBzm7MsTeSbFzE6Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AAjAUHQA; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AAjAUHQA"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-399311947f6so11088674a91.0
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 16:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788997468; x=1789602268; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B7FE+ctvFxs6x9jU2YrVB39dn28KtIk7w7wKgkkAtC4=;
        b=AAjAUHQA/XF64+6juDtpqXXfKs5IYjZaare09L6bO7xkfp6t9JxFzZbVhcS6W22CvI
         a7BAdy2RTNXqyE/anApWZr8IuX20OaWHYR5haAj0dElPc8fGaOjYw1tVsZiIpSYgSQXa
         l65BpDbXgA8sYLIUbhdUPOg0opSY8l+ENVZkgnuBSNL8pJmpVtgqSPJ5o+ck0uY+QtIQ
         e1wCLCBTaSgnR1LGi24RtSr+OVpCSNT16yTdlu5dbHC7p+bkbdJwg0O0LkjBR/eVNIbL
         0cB0hMJay9TnknicMNtGZmfTes/pmt1L6tE/uZHmOnW0uFOQ+EzB0f2f4e1T8NW4yTeL
         NjYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788997468; x=1789602268;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B7FE+ctvFxs6x9jU2YrVB39dn28KtIk7w7wKgkkAtC4=;
        b=scmSOKM5zf8bvm13TMNZ+I2ASXIF+XW/P1nxbdhHxYe86hNiOauIwyLbAikaLUlPJs
         DTWoePqVPD6snuC2KSC6RJUsjMNuzCUiiRfB0SlMMWPJHNqQvrnX/5v4Pt+Btw2Ar3LV
         uRZT4I5e373z29ed0E7Lu5MnADY9W82bUy6oJQjsyTmAFYYmOF5NdevpF/c2eqKW5QtA
         MBcI+L09pMCIDVqC2zs1V6JwOOz4FxtDBiv+SlMHB7nDiC9uEZ0uIzW1Johxuuf+XGuC
         sMXv5EsTpsO+E3lo/vHav2re2a1IuQztjexHTZodiHkQTRUQCKl+oyeid4uw9mUyTfG7
         3hSg==
X-Forwarded-Encrypted: i=1; AKwUvBxQDygn86ifs3BcAAAiUat3jy3BLn0II3W/PkQi9LUKMSogGNk46cy4wCDnlXR+P0b7R0LiJak=@vger.kernel.org
X-Gm-Message-State: AFuF++k1OpCmbGK4mEUUGZM89TpXkmsyMbs4YNfN+g2+8gT+owJpawl8
	j+kuW00xtrd8rsdSB4a2ikYOQudnzEcKMrNYzWQShnXC5Bo+9c6jUTj97cxT7UfpB8lyCyXe2Hl
	C/HNnmQ==
X-Received: from pjni21.prod.google.com ([2002:a17:90a:8395:b0:398:ff5d:7e24])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:52c4:b0:36a:5d1f:7b6
 with SMTP id 98e67ed59e1d1-39b260d3375mr55959216a91.2.1788997467357; Wed, 09
 Sep 2026 16:44:27 -0700 (PDT)
Date: Wed,  9 Sep 2026 23:43:45 +0000
In-Reply-To: <20260909234422.2416506-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260909234422.2416506-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
Message-ID: <20260909234422.2416506-3-kuniyu@google.com>
Subject: [PATCH v2 net-next 2/7] ip_tunnel: Set itn->fb_tunnel_dev to NULL in ip_tunnel_delete_net().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

ip_tunnel_dellink() ignores itn->fb_tunnel_dev, so the per-netns
fallback tunnel device cannot be removed by userspace.

This also makes default_device_exit_batch() impossible to remove
the device since it calls ->dellink().

So, ip_tunnel_delete_net() has to iterate devices in the dying netns
and call unregister_netdevice_queue() directly.

But then, this duplicates ip_tunnel_del() in ip_tunnel_dellink()
and ip_tunnel_uninit().

Let's set itn->fb_tunnel_dev to NULL in ip_tunnel_delete_net() and
remove for_each_netdev_safe() in ip_tunnel_delete_net().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/ip_tunnel.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index e6bcf01411d0..d29e2ba7cdd3 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -1155,26 +1155,19 @@ void ip_tunnel_delete_net(struct net *net, unsigned int id,
 			  struct list_head *head)
 {
 	struct ip_tunnel_net *itn = net_generic(net, id);
-	struct net_device *dev, *aux;
 	int h;
 
 	ASSERT_RTNL_NET(net);
 
-	for_each_netdev_safe(net, dev, aux)
-		if (dev->rtnl_link_ops == ops)
-			unregister_netdevice_queue(dev, head);
+	WRITE_ONCE(itn->fb_tunnel_dev, NULL);
 
 	for (h = 0; h < IP_TNL_HASH_SIZE; h++) {
-		struct ip_tunnel *t;
-		struct hlist_node *n;
 		struct hlist_head *thead = &itn->tunnels[h];
+		struct hlist_node *n;
+		struct ip_tunnel *t;
 
 		hlist_for_each_entry_safe(t, n, thead, hash_node)
-			/* If dev is in the same netns, it has already
-			 * been added to the list by the previous loop.
-			 */
-			if (!net_eq(dev_net(t->dev), net))
-				unregister_netdevice_queue(t->dev, head);
+			unregister_netdevice_queue(t->dev, head);
 	}
 }
 EXPORT_SYMBOL_GPL(ip_tunnel_delete_net);
@@ -1310,8 +1303,6 @@ void ip_tunnel_uninit(struct net_device *dev)
 
 	itn = net_generic(net, tunnel->ip_tnl_net_id);
 	ip_tunnel_del(itn, netdev_priv(dev));
-	if (itn->fb_tunnel_dev == dev)
-		WRITE_ONCE(itn->fb_tunnel_dev, NULL);
 
 	dst_cache_reset(&tunnel->dst_cache);
 }
-- 
2.55.0.1003.g10538fe699-goog

