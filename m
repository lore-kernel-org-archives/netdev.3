Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792455974;
	b=GcpszgBKlzMyL/hB9vGItof8qXNwPRoRS+i0YSb6BJEVHlOqDp9BwHllwmtyC1560E+O
	 eUDhAdFFKNegIlUtxXmIEJo+0vk0gQnWmlKFzm83pSho9WJLdYI+DJpsjcdsIG+DAn6tw
	 /LX0vfzGnyoXheLo22GgezkW+PBlBPJv7pQC0CFVACUj6KFhgHtXvlN5CFVvwByJDyroV
	 0dYCV8+kIJ/L9FRsWXggFAr/g0h33/fCzhfATdTemdhKn5Zz0l43Rxo7D2ijeaDjkn72S
	 h2Eyyw2oeHetUcQ1WRUxE4Ob3GtaWOrFKs9bP+UF/36WGossgA8lBZ0wXQ+O20vYKtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792455974;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3rmYFfzrOVrb1XmuRQml+2DQmSzQNSetRaB8KT5fx+8=;
	b=xRYDLine+tbQC0MfY2apJPGj5fIURqu/+wd//MIHgeq15+CaImZH2A1DgaVRg7XXLvQo
	 3NCPa9B+LsL/+du76QVf4JcedtFKeNx7aFY95FWXqhCv2xupJpzFQl50/3fmEHGwf/Z3u
	 WaULwx7vBtKY4sUzEJGRjyDN9fjJgVYlk+79PH3beEvJJhI0SnEISz10Udb1rX3WGbQiS
	 kPm1jwrdvYoa46/Wu+wdXW+yx02knz+hE/bxhBgX/QAgO93VChXyMs8fnuyAzSdcOHCHo
	 fJgf6r2pxdlc/SgRt2w7QnAlrqOFLDbDrAS+JmCWrYyz2CEDz0X8TqmdsVwhYEAgHvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=blockcast.net;
	spf=pass smtp.mailfrom=blockcast.net;
	dkim=pass header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=MBy8U8KA;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88ED7606A320
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 00:26:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88ED7606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=MBy8U8KA
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-366421dc8ebso39715eec.1
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 17:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1792455966; x=1793060766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3rmYFfzrOVrb1XmuRQml+2DQmSzQNSetRaB8KT5fx+8=;
        b=MBy8U8KAgPRxMoRxNeyUyhfEsOj/LI2rJ3ekokEH6Ylq1hE1Rb/xyLlQk6/Fjh10IB
         g1thvVbd+ZcQRCSL9596NIF3wMDD4otS5w7uZNYV5vI+8qBP+95yNuCOu9JGOUnSR/HZ
         l2J9enMrlxwl6CcCxxGWgRv15LkTvZJ6TcCYZ9SGWTVXegVUXhCd1bARkvoHkiP51tjL
         d6yS36HzbFO37YB29oJE4lGa21F8dpuYy8e7E37KEqoGIFT4UetMRQT+AAKXq0hDanHf
         6LN3oeiiKJisWysVlP98JhFnO3/LxYouWoTV4E+x1Mkw8w/iOo5IDB3HvJuKWjFssGO+
         zQ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792455966; x=1793060766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3rmYFfzrOVrb1XmuRQml+2DQmSzQNSetRaB8KT5fx+8=;
        b=OWAyIXHGIXi/blQBNA5omeL6Rm2WpDhWSa/swGLMchvk4vN/RkFXjdqqDOolT9nkU/
         kJnJ1caPUYniqe9ZLK4iZ4rPPTfixmk5/XaE1E+ce4o8cAIm6zFH/nV/jEE9lB3Qpwh/
         uwFbtMQ0PZxrSEwYyt8m9JMOatkPlTnr9zlgj4+Ov/uYEGs0ZpwlLj7ONpuMoy8DJ7G8
         AVshcI/blewSCEE0oSOAUXD1Eh1DbQS5gPMoX1sznEfcyy1l9svlJN4YCAEC7lgb8KC2
         ZlFRAPymtlK55YTWLnaRhmNBnaVjdLrbXXf4+dQdmDSSCKQrRIWye5egssRdhhlSl0Y0
         VD0Q==
X-Gm-Message-State: AFq9FYLk2ftTBv6d9h2cHV+AtV8clE22CyyZtflpuwu30rz9I1N4W+F0
	6nQOnMmCg8yqUxq1B3QqeZlFX13VGj8D1nmS+XdwArYixNm1mFkkz3X9QwM4PZaqmhA=
X-Gm-Gg: AYBFou3KIRieRpCFRNNpcN+Hz9IibnJ7Uxc/KsVPqMuXEf1aOeR9i0hLBcpWNF90ck0
	raj0vgJQYXn44iXTpNtEIKSRWmqKtG9UAfvnaOJ35goxMD8YHrNV6zxGS8TJmxfWlwspIj1efPZ
	AIoxWYHWaroLkab0A6lsuqIUVf27d0vkOvkAQ71DYmeeg9KLf1+fnep88iBv4DSko5HIfiKkZUq
	WcnD35nmzX90zR9ZSGBhFixZvglooQc8qPcZhmeCUXToU82kwg9VGLVNvh5iAE6CLj4sAXs4ohM
	oLUzRvyxMkVjlel3J7p5SMgUzL0LCFkB1N3D2WEN6IFoL8xbcRDdNooJ7hFXVGORHo9idvzk4vu
	VAmKb6YSPhE8Lhxm5h1h0Sbc1Ab+tLW77OtIml2sVgDFkSVUlaCTmLY7Cmj+fhbz1C64qjbca+G
	lzHxTDRwMv/7oQrx8t/xkRM8c97kfLeUSLxtYeZk4RuZwywaCc2TP907hdL2xUic6ybDQe3WEkw
	bLProvJP4YN+YlrjkfsDgqf1GXRz8CKQRkLDG3V69FgtxLdFt/DzBLhdCZ3lEI+ZCGjqALudv4=
X-Received: by 2002:a05:693c:42d2:b0:357:ee3a:267a with SMTP id 5a478bee46e88-365f819ca19mr830113eec.2.1792455965255;
        Mon, 19 Oct 2026 17:26:05 -0700 (PDT)
Received: from devbox.ts.blockcast.net ([69.25.95.32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3608258aa66sm44748072eec.20.2026.10.19.17.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 17:26:04 -0700 (PDT)
From: Omar Ramadan <omar@blockcast.net>
To: Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net v4 4/5] amt: make pre-query report drops visible
Date: Tue, 20 Oct 2026 00:25:56 +0000
Message-ID: <20261020002557.3984927-5-omar@blockcast.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261020002557.3984927-1-omar@blockcast.net>
References: <20261020002557.3984927-1-omar@blockcast.net>
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

A gateway cannot forward an IGMP or MLD report until it has received the
relay's Membership Query for that family.  The Query supplies the
response MAC the Update echoes, so dropping an early report is required,
but doing so silently leaves operators with a dark multicast path and no
indication why the join never happened.

Emit a family-specific debug message before taking the drop path.

tx_dropped could not show these drops either: amt_dev_xmit() reaches the
same tx_dropped increment after amt_send_membership_update() has handed
the report to the tunnel, so in gateway mode every forwarded report was
also counted as a drop.  Return NETDEV_TX_OK directly once the report has
been sent, so tx_dropped counts only reports that were discarded.

The device is LLTX, so amt_dev_xmit() can run on several CPUs at once;
use DEV_STATS_INC() for its tx_dropped and tx_errors updates so
concurrent increments are not lost.

Fixes: cbc21dc1cfe9 ("amt: add data plane of amt interface")
Assisted-by: LLM
---
 drivers/net/amt.c | 42 +++++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 17 deletions(-)

Signed-off-by: Omar Ramadan <omar@blockcast.net>
diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index 960a08d..f83afba 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -704,7 +704,7 @@ static void amt_send_discovery(struct amt_dev *amt)
 				   IPPROTO_UDP, 0,
 				   amt->stream_dev->ifindex);
 	if (IS_ERR(rt)) {
-		amt->dev->stats.tx_errors++;
+		DEV_STATS_INC(amt->dev, tx_errors);
 		goto out;
 	}
 
@@ -714,7 +714,7 @@ static void amt_send_discovery(struct amt_dev *amt)
 	skb = netdev_alloc_skb_ip_align(amt->dev, len);
 	if (!skb) {
 		ip_rt_put(rt);
-		amt->dev->stats.tx_errors++;
+		DEV_STATS_INC(amt->dev, tx_errors);
 		goto out;
 	}
 
@@ -759,7 +759,7 @@ static void amt_send_discovery(struct amt_dev *amt)
 	ip_send_check(iph);
 	err = ip_local_out(amt->net, sk, skb);
 	if (unlikely(net_xmit_eval(err)))
-		amt->dev->stats.tx_errors++;
+		DEV_STATS_INC(amt->dev, tx_errors);
 
 	amt_update_gw_status(amt, AMT_STATUS_SENT_DISCOVERY, true);
 out:
@@ -795,7 +795,7 @@ static void amt_send_request(struct amt_dev *amt, bool v6)
 				   IPPROTO_UDP, 0,
 				   amt->stream_dev->ifindex);
 	if (IS_ERR(rt)) {
-		amt->dev->stats.tx_errors++;
+		DEV_STATS_INC(amt->dev, tx_errors);
 		goto out;
 	}
 
@@ -805,7 +805,7 @@ static void amt_send_request(struct amt_dev *amt, bool v6)
 	skb = netdev_alloc_skb_ip_align(amt->dev, len);
 	if (!skb) {
 		ip_rt_put(rt);
-		amt->dev->stats.tx_errors++;
+		DEV_STATS_INC(amt->dev, tx_errors);
 		goto out;
 	}
 
@@ -852,7 +852,7 @@ static void amt_send_request(struct amt_dev *amt, bool v6)
 	ip_send_check(iph);
 	err = ip_local_out(amt->net, sk, skb);
 	if (unlikely(net_xmit_eval(err)))
-		amt->dev->stats.tx_errors++;
+		DEV_STATS_INC(amt->dev, tx_errors);
 
 out:
 	rcu_read_unlock();
@@ -874,7 +874,7 @@ static void amt_send_igmp_gq(struct amt_dev *amt,
 
 	skb_pull(skb, sizeof(struct ethhdr));
 	if (amt_send_membership_query(amt, skb, tunnel, false)) {
-		amt->dev->stats.tx_dropped++;
+		DEV_STATS_INC(amt->dev, tx_dropped);
 		kfree_skb(skb);
 	}
 }
@@ -918,7 +918,7 @@ static struct sk_buff *amt_build_mld_gq(struct amt_dev *amt)
 
 	if (ipv6_dev_get_saddr(amt->net, amt->dev, &ip6h->daddr, 0,
 			       &ip6h->saddr)) {
-		amt->dev->stats.tx_errors++;
+		DEV_STATS_INC(amt->dev, tx_errors);
 		kfree_skb(skb);
 		return NULL;
 	}
@@ -962,7 +962,7 @@ static void amt_send_mld_gq(struct amt_dev *amt, struct amt_tunnel_list *tunnel)
 
 	skb_pull(skb, sizeof(struct ethhdr));
 	if (amt_send_membership_query(amt, skb, tunnel, true)) {
-		amt->dev->stats.tx_dropped++;
+		DEV_STATS_INC(amt->dev, tx_dropped);
 		kfree_skb(skb);
 	}
 }
@@ -1312,7 +1312,7 @@ static netdev_tx_t amt_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 		group.ip6 = ipv6_hdr(skb)->daddr;
 #endif
 	} else {
-		dev->stats.tx_errors++;
+		DEV_STATS_INC(dev, tx_errors);
 		goto free;
 	}
 
@@ -1325,12 +1325,21 @@ static netdev_tx_t amt_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 		/* Gateway only passes IGMP/MLD packets */
 		if (!report)
 			goto free;
+		/* A validated report can only be forwarded after the relay's
+		 * family-specific Membership Query supplies the state echoed
+		 * by the Membership Update. Log this readiness failure before
+		 * the shared drop path accounts it.
+		 */
 		if ((!v6 && !READ_ONCE(amt->ready4)) ||
-		    (v6 && !READ_ONCE(amt->ready6)))
+		    (v6 && !READ_ONCE(amt->ready6))) {
+			netdev_dbg(dev, "drop %s report: waiting for Membership Query\n",
+				   v6 ? "MLD" : "IGMP");
 			goto free;
+		}
 		if (amt_send_membership_update(amt, skb,  v6))
 			goto free;
-		goto unlock;
+		/* Sent: the tunnel consumed the skb.  Not a drop. */
+		return NETDEV_TX_OK;
 	} else if (amt->mode == AMT_MODE_RELAY) {
 		if (!data)
 			goto free;
@@ -1359,8 +1368,7 @@ found:
 	return NETDEV_TX_OK;
 free:
 	dev_kfree_skb(skb);
-unlock:
-	dev->stats.tx_dropped++;
+	DEV_STATS_INC(dev, tx_dropped);
 	return NETDEV_TX_OK;
 }
 
@@ -2720,7 +2728,7 @@ static void amt_send_advertisement(struct amt_dev *amt, __be32 nonce,
 				   IPPROTO_UDP, 0,
 				   amt->stream_dev->ifindex);
 	if (IS_ERR(rt)) {
-		amt->dev->stats.tx_errors++;
+		DEV_STATS_INC(amt->dev, tx_errors);
 		goto out;
 	}
 
@@ -2730,7 +2738,7 @@ static void amt_send_advertisement(struct amt_dev *amt, __be32 nonce,
 	skb = netdev_alloc_skb_ip_align(amt->dev, len);
 	if (!skb) {
 		ip_rt_put(rt);
-		amt->dev->stats.tx_errors++;
+		DEV_STATS_INC(amt->dev, tx_errors);
 		goto out;
 	}
 
@@ -2776,7 +2784,7 @@ static void amt_send_advertisement(struct amt_dev *amt, __be32 nonce,
 	ip_send_check(iph);
 	err = ip_local_out(amt->net, sk, skb);
 	if (unlikely(net_xmit_eval(err)))
-		amt->dev->stats.tx_errors++;
+		DEV_STATS_INC(amt->dev, tx_errors);
 
 out:
 	rcu_read_unlock();
