Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6A43A7F5F
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 05:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787635452; cv=none; b=jdv3+quCNhYMNBt7mRKRZDBos2TGwuY/wfglOj1oBEcrm0B5N8nnb7c62lZRuk2zseTs1lTXdzQjWGqMajxb8nMspChYBahJqLOfRJyTqLTurOrFccDz2Y63KSoMac80jtvEc7b/ERPDcMY87wMhtgDRyHswitI+wXnFkS6/Uq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787635452; c=relaxed/simple;
	bh=Cnm0NvLDpK5WEjqJZeD0ehir/4mK4rZsV7l3bVzQ9B8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eD9RGYGyB4qq2eInbJnRGzRxW0GWwXoDwpEAaik0D/9sx2Fv3u34w2D1nwOJb/NLGq9moMYJG4hExaEtR+EhCgkOuMV4NyBoWNnzxQXxCGSeuY4kW8BwYgYc7TajLWBLfkB3xnDoJCw9MvgdeUmJyViQCGAk+M4qcrNI433hVS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cwXLSHJ0; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cwXLSHJ0"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-855a66e5b5dso1347147b3.0
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 22:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787635449; x=1788240249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/5Oa7EYj+aGHCCFiWFn1S8ybUNVYzm4EISFL7x7oRPk=;
        b=cwXLSHJ0efW4KQF1jeDDBzznneKFGkSkptYat4lriUwoSgYG1P9KUnDHOx5s56mKLj
         LqeDLWWZiv49D1BgRuxQJKme1oHCJFU/aahOKSy5G5WW1a7u5CJM0+vLXons54zEiDIH
         5sDlMmcklty0XeB8QXLXQh9xBalQzK7Rt3suVUHpXELxMAf7YsWah8uITih+jchvmWLs
         MPSMH841VqI654xL/QFJWPOc3vUPwh7xpXkWClPrZnX/Kvf5bufZ7T2jKJ2GKxxQylsL
         U73lfix5pxMOzC4ETU3RZldM46bHbh/udoziCi7TK2mqwRN+P17ygwk2Xv6bAjzBGWHf
         2gNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787635449; x=1788240249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/5Oa7EYj+aGHCCFiWFn1S8ybUNVYzm4EISFL7x7oRPk=;
        b=d3OGM5vr0nQKxj+y63H4g4y0AcGDVUK5hrottuq2JiQd3OeYjgJcvqPpfH8vtQkNf4
         ynvnkkY0O4XCtnjkHMkB1iUV5d0Hz98wpyoncBAXSy9vHmC3tHuB7QNczDwKeElUyyDM
         9bev1o/wT9ngHsYnfkooG7uiPZ3FoCRUcatHP5eYarM7RGvlJ9FTuSaJywGlGPgCVBVV
         uTfVZkeCSG4kM8jV9XpI4Ulz+oxZfKeTAXBm7F7BwPR080vgjIK5R22H0O+leLpsNdP3
         uor/wM/jkZP+t84VvH8QxDp5zVIJ5DT71Rxr9jC8APbzvES3InMkNGI4292ndftljkNl
         w5gQ==
X-Forwarded-Encrypted: i=1; AHgh+RpzGyRI7t+bMg3ov+tTmZdl5NHwoWywq2a/EfKWquGWMfj9KfyY3N8hzA7Ugjm/mBmdTJrv2yM=@vger.kernel.org
X-Gm-Message-State: AFuF++lhDkHGK9z461Ox0sbJP+LFQriaUyyP6eVnluDE2uIFmoLCxA7C
	o/BtbtExCILKuQllPOwioqlV85k0SXwhC4bjlthv6vHfWX6TdufUdBoN
X-Gm-Gg: AR+sD13fzo0oA5H8zMbbgYmSKxJzUefcNVtQfCu5eSDMIXw4Y7SaY/1P2c6FDSqPbWp
	bv/uKbAQd3YBSwcJLPw+HhXFcQBentipG5OJi8+X+R3t6N+j+Tk3yD1DpEPFm9kjLJofpihRR9w
	biaCeYWdSdgLqWWeC5K13qMFJY6ohk5zbeKt5ZyHmfC5i+hCGx6Qd2IaTe0J/kqmZE2bJDDrcFF
	iSywAbYXE6yPbm2CO0ubL5CspBD0CIw01wRAcMu/rL7h9T+P+gRGamBtDFmxsqSNsxLKjYo6yWP
	/8eqMrerKdynpeYvZAV+X/aOFgp7e6iSFzVAAAxpFKICVZr3ttTsiqWfbXtUQQ6wn7aoevyBHXF
	+FuCY4ZnFw1l77dnrSvTySGBX56DjBNgKu2muohlG507wpzuZPh/himNquFa4iaQ1S3t8pS9U8m
	nomHP38puN9nS3SD5KOkNSR59LKWiDrd348CjqjLesGtp0lDo0GXGvlE7Cw67aO8o7nRY=
X-Received: by 2002:a05:690c:c15:b0:81d:75b4:925f with SMTP id 00721157ae682-849f4c6ffd3mr130520957b3.19.1787635449512;
        Mon, 24 Aug 2026 22:24:09 -0700 (PDT)
Received: from mac.lan ([136.55.173.105])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-851e1419e0bsm21767747b3.26.2026.08.24.22.24.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 24 Aug 2026 22:24:08 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: pablo@netfilter.org,
	laforge@gnumonks.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	anthony.l.nguyen@intel.com,
	wojciech.drewek@intel.com,
	osmocom-net-gprs@lists.osmocom.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	xmei5@asu.edu,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	blbllhy@gmail.com
Subject: [PATCH net v2 1/2] gtp: fix sk_created publication race in gtp_create_sockets()
Date: Tue, 25 Aug 2026 01:24:03 -0400
Message-ID: <20260825052404.45665-2-blbllhy@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825052404.45665-1-blbllhy@gmail.com>
References: <20260825052404.45665-1-blbllhy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In gtp_create_sockets(), gtp->sk_created is set to true before gtp->sk0
and gtp->sk1u are assigned. Without memory ordering guarantees, a
concurrent GTP Echo packet on another CPU can observe sk_created == true
while gtp->sk0 is still NULL, causing a kernel panic.

  KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
  RIP: 0010:gtp_encap_recv  (drivers/net/gtp.c:542 gtp0_handle_echo_resp)
  Call Trace:
   <IRQ>
   udp_queue_rcv_one_skb
   ip_protocol_deliver_rcu
   ip_local_deliver
  Kernel panic - not syncing: Fatal exception in interrupt

Use smp_store_release() when publishing sk_created and
smp_load_acquire() on every lockless read. This ensures that all prior
stores (sk0, sk1u assignments) are visible before any reader can observe
the flag as true, on all architectures. Annotate all remaining lockless
sk_created accesses with smp_store_release()/smp_load_acquire().

Suggested-by: Simon Horman <horms@kernel.org>
Fixes: b20dc3c68458 ("gtp: Allow to create GTP device without FDs")
Reported-by: AutonomousCodeSecurity@microsoft.com
Reported-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
Reported-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
---
v2: Use smp_store_release()/smp_load_acquire() to provide proper memory
    ordering as suggested by Simon Horman.
v1: https://lore.kernel.org/netdev/20260816035205.57966-1-blbllhy@gmail.com/
---
 drivers/net/gtp.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 298efc76a56b..ead519ee18d1 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -603,10 +603,12 @@ static int gtp0_udp_encap_recv(struct gtp_dev *gtp, struct sk_buff *skb)
 	 * there is no daemon running in userspace which would
 	 * handle echo request.
 	 */
-	if (gtp0->type == GTP_ECHO_REQ && gtp->sk_created)
+	/* Pairs with smp_store_release() in gtp_create_sockets(). */
+	if (gtp0->type == GTP_ECHO_REQ && smp_load_acquire(&gtp->sk_created))
 		return gtp0_send_echo_resp(gtp, skb);
 
-	if (gtp0->type == GTP_ECHO_RSP && gtp->sk_created)
+	/* Pairs with smp_store_release() in gtp_create_sockets(). */
+	if (gtp0->type == GTP_ECHO_RSP && smp_load_acquire(&gtp->sk_created))
 		return gtp0_handle_echo_resp(gtp, skb);
 
 	if (gtp0->type != GTP_TPDU)
@@ -811,10 +813,12 @@ static int gtp1u_udp_encap_recv(struct gtp_dev *gtp, struct sk_buff *skb)
 	 * there is no daemon running in userspace which would
 	 * handle echo request.
 	 */
-	if (gtp1->type == GTP_ECHO_REQ && gtp->sk_created)
+	/* Pairs with smp_store_release() in gtp_create_sockets(). */
+	if (gtp1->type == GTP_ECHO_REQ && smp_load_acquire(&gtp->sk_created))
 		return gtp1u_send_echo_resp(gtp, skb);
 
-	if (gtp1->type == GTP_ECHO_RSP && gtp->sk_created)
+	/* Pairs with smp_store_release() in gtp_create_sockets(). */
+	if (gtp1->type == GTP_ECHO_RSP && smp_load_acquire(&gtp->sk_created))
 		return gtp1u_handle_echo_resp(gtp, skb);
 
 	if (gtp1->type != GTP_TPDU)
@@ -894,7 +898,10 @@ static void gtp_encap_disable(struct gtp_dev *gtp)
 	if (gtp->sk_created) {
 		udp_tunnel_sock_release(gtp->sk0);
 		udp_tunnel_sock_release(gtp->sk1u);
-		gtp->sk_created = false;
+		/* Pairs with smp_load_acquire() in the RX and
+		 * genl echo paths.
+		 */
+		smp_store_release(&gtp->sk_created, false);
 		gtp->sk0 = NULL;
 		gtp->sk1u = NULL;
 	} else {
@@ -1462,10 +1469,15 @@ static int gtp_create_sockets(struct gtp_dev *gtp, const struct nlattr *nla,
 		return PTR_ERR(sk1u);
 	}
 
-	gtp->sk_created = true;
 	gtp->sk0 = sk0;
 	gtp->sk1u = sk1u;
 
+	/* Ensure sk0/sk1u are visible before sk_created is set.
+	 * Pairs with smp_load_acquire() in the RX and genl
+	 * echo paths.
+	 */
+	smp_store_release(&gtp->sk_created, true);
+
 	return 0;
 }
 
@@ -2365,7 +2377,10 @@ static int gtp_genl_send_echo_req(struct sk_buff *skb, struct genl_info *info)
 	if (!gtp)
 		return -ENODEV;
 
-	if (!gtp->sk_created)
+	/* Pairs with smp_store_release() in gtp_create_sockets()
+	 * and gtp_encap_disable().
+	 */
+	if (!smp_load_acquire(&gtp->sk_created))
 		return -EOPNOTSUPP;
 	if (!(gtp->dev->flags & IFF_UP))
 		return -ENETDOWN;
-- 
2.55.0
