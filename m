Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A36123EAA6
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 02:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785465059; cv=none; b=mVyvbwVBAVYbIz//lBEEpQhwhKoiEITrY/vdos6/ytSFKXg/UXo0F3LX299QJUzNVCl4G5/WScDRBrO1G+rN0WmR3QqOfD+aM+MjsjV9aArOmaXvnu6dmUL89ktdWeJ7IOsqAshKDmA7a/wR5CNmHhl6//l/7dPPZo4HG9UC+uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785465059; c=relaxed/simple;
	bh=ejpyYt4546LU4xMKbv8fm7Cy4hOfgg3onTGsqmXyqBg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YE4xkEhpYgdDzsmJS8jXQZ1LIvj/O3C5U3QUlmUlDxl7rSXl6Xe2vEsqOOSrkHffpa9Y55LRRjBIe6yMb5secbVhwd8CSg5HdJHRm6i8ifv9TA1gaRSlSbd0+E16lyK/47eQn4/uJSNADJ9gnAycxyE2K9LgIHkcG/cKT8RgNiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=icHnhB+b; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icHnhB+b"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-37f9e2642deso93014a91.1
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 19:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785465057; x=1786069857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=D7ShXbAC867fAplXCwsR00hNj/xQSZRNxWu7qPWzdew=;
        b=icHnhB+bVPW3rr55D5ctysrfYeZXeQ0uzf8gdQi0JZtprRkE5g8ZGFHh3wek7MeoT9
         baeZsv2MdtDe893B/wQBNMHWWA3WAcIdl6dGieiAGyo5fXe7F/YSStaNIRwRgk7YPsAR
         pymjN//d/hlU8uxKl3AoyEzSYk38CzPpwshosPoXVloIivhRnhzMJ57RncNpVmMG90aD
         CLTP5q4+/0gDff6qtzUX+JbIVkI3gzBCEq4uicyohSy09CBaDnLj4blo2JZ2kPLto8wS
         pkVeSp+dRMGimu54wn6WzzSODc0iWZGQ1VfKksmRqKZoMsgDAUVlgSeEqPcSa1QisKvF
         NLOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785465057; x=1786069857;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D7ShXbAC867fAplXCwsR00hNj/xQSZRNxWu7qPWzdew=;
        b=BaBZ34ZSe8Kdwz6KecPYm5hSc3B0VoLUJxhW6D9GgiZvRHOct/LlDqDV0sbHqv5CvH
         h8g3hRY6gn2JpYX1bR+1pSgZ0YZZ/ZGxIVx4ASSzVXGqBw0wbj7ERaMkhW0oerTQXLAS
         CrDS63R983s/6LNLAr0PEMyf5czme0aaQwcZr9FFjoXtS0VHWFlBOUKujQVz1bQGjOyQ
         8D8703IIPlYEuF+Nu2kWiw006RM15fleMaeJDad9Yvpdarf+hUml7y4UnAuARP/lYX3t
         LIpgG5T1bQPXYm7gF1YlL6JWDYaL7hPv/HIm0f1gf1wT89gmoVOIe2C2yovbUWgR3NSW
         CVgw==
X-Forwarded-Encrypted: i=1; AHgh+RrhCb4g7wFH70Nv74aoxuxQZ0YILbiORQW8S1TQSYQKUp6Pv7Y1braCRmdumt9F93i8ttqY2Xs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywct1QHtDDsfwawFzN7YgpGTxD34zMJ3g3EyMnKXYm/lYSKDLCi
	GeoOMjaMKabb1jAbx514I8tr9BSy+UuYBkTQN45iFCUZvia9IiEmflqG
X-Gm-Gg: AR+sD12hRHG2uX9oc2HvEnfbKf2Trn9AF3c31nCgfFaVlynhm4dasbnHTHzZFsw5V7e
	K9+XFrKmRgErWZ+nA09IsYPvDUAWs9O4Ph6kDwStF2V0nK6Iw+zNpyVHJT4vZxIN05kfJRy8vSJ
	hial6/jRbnq5jGbLZ+0BCv1y9tDPVII/SVt6R80BGwlwkf8qZil7xwBLtWeAVBrSuk+JVeob3cK
	5VY65DQBuMtQfheBPFQXY0w4rwjCcKezoN12/8yCqNZFn00x/IQ38/BUMabE6cJcT0izrVyNuNR
	CQYlBsDUrXTsKuj+X/3sp275EDXGSKcwbZOzeGGQ0OjvoTtFIAMFBNP7g7jSYDPdti9ILBpJkk7
	cg0wLnH28NQqCgDizM+fXra1OT8saTf1HKUPfOHC+P6ScHg/3gmrFldu+c2w3ubxGToub5Q0ZZ0
	zGaEt16prj7pm7DVAnqqEEla6s2hKEfto96g+e7JtKTsssKB1dGQw+r++p0U8kQs41FjOl5Loa0
	oLYr9hSvjwJ9GbXUeQIriqohaw1FQ==
X-Received: by 2002:a17:903:298d:b0:2ca:ecf6:9115 with SMTP id d9443c01a7336-2d046e36580mr5158035ad.2.1785465056523;
        Thu, 30 Jul 2026 19:30:56 -0700 (PDT)
Received: from localhost.localdomain ([189.1.242.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d047abbf6csm416545ad.39.2026.07.30.19.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 19:30:56 -0700 (PDT)
From: Yiqi Sun <sunyiqixm@gmail.com>
To: jk@codeconstruct.com.au,
	matt@codeconstruct.com.au
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yiqi Sun <sunyiqixm@gmail.com>
Subject: [PATCH] net: mctp: hold route device before source address lookup
Date: Fri, 31 Jul 2026 10:29:26 +0800
Message-Id: <20260731022926.913865-1-sunyiqixm@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mctp_route_lookup() walks the route table under RCU and may find a direct
route whose route-table reference to rt->dev is being removed concurrently
by NETDEV_UNREGISTER.

Since commit 22cb45afd221 ("net: mctp: perform source address lookups
when we populate our dst"), the direct-route lookup path reads the source
address with mctp_dev_saddr(rt->dev) before mctp_dst_from_route() takes the
dst's own mctp_dev reference. If device teardown wins that race,
mctp_route_remove_dev() can delete the route and mctp_route_release() can
drop the route's mctp_dev reference to zero. mctp_dev_put() frees
mdev->addrs synchronously, while only the mctp_dev body is deferred with
kfree_rcu().

That leaves the lookup side able to read freed mdev->addrs in
mctp_dev_saddr(), or later increment a zero refcount in mctp_dev_hold().

Add a try-hold helper for mctp_dev and use it before reading the source
address from a direct route. mctp_dst_from_route() now consumes that held
reference when it populates dst. If no dst is requested, drop the temporary
reference in mctp_route_lookup(). Do the same when the route cannot be used
for a gateway path without a source address.

Fixes: 22cb45afd221 ("net: mctp: perform source address lookups when we populate our dst")
Signed-off-by: Yiqi Sun <sunyiqixm@gmail.com>
---
 include/net/mctpdevice.h |  1 +
 net/mctp/device.c        |  5 +++++
 net/mctp/route.c         | 28 ++++++++++++++++++++--------
 3 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/include/net/mctpdevice.h b/include/net/mctpdevice.h
index 957d9ef924c5..1d052f11127c 100644
--- a/include/net/mctpdevice.h
+++ b/include/net/mctpdevice.h
@@ -50,6 +50,7 @@ int mctp_register_netdev(struct net_device *dev,
 void mctp_unregister_netdev(struct net_device *dev);
 
 void mctp_dev_hold(struct mctp_dev *mdev);
+bool mctp_dev_try_hold(struct mctp_dev *mdev);
 void mctp_dev_put(struct mctp_dev *mdev);
 
 void mctp_dev_set_key(struct mctp_dev *dev, struct mctp_sk_key *key);
diff --git a/net/mctp/device.c b/net/mctp/device.c
index 2c84df674669..18b192bbfaa7 100644
--- a/net/mctp/device.c
+++ b/net/mctp/device.c
@@ -303,6 +303,11 @@ void mctp_dev_hold(struct mctp_dev *mdev)
 	refcount_inc(&mdev->refs);
 }
 
+bool mctp_dev_try_hold(struct mctp_dev *mdev)
+{
+	return mdev && refcount_inc_not_zero(&mdev->refs);
+}
+
 void mctp_dev_put(struct mctp_dev *mdev)
 {
 	if (mdev && refcount_dec_and_test(&mdev->refs)) {
diff --git a/net/mctp/route.c b/net/mctp/route.c
index 1f3dccbb7aed..3d0737030917 100644
--- a/net/mctp/route.c
+++ b/net/mctp/route.c
@@ -897,15 +897,16 @@ static mctp_eid_t mctp_dev_saddr(struct mctp_dev *dev)
 	return addr;
 }
 
-/* must only be called on a direct route, as the final output hop */
+/* must only be called on a direct route, as the final output hop, with a
+ * reference already held on route->dev.
+ */
 static void mctp_dst_from_route(struct mctp_dst *dst, mctp_eid_t eid,
 				mctp_eid_t saddr, unsigned int mtu,
-				struct mctp_route *route)
+				struct mctp_route *route, struct mctp_dev *dev)
 {
-	mctp_dev_hold(route->dev);
 	dst->nexthop = eid;
-	dst->dev = route->dev;
-	dst->mtu = READ_ONCE(dst->dev->dev->mtu);
+	dst->dev = dev;
+	dst->mtu = READ_ONCE(dev->dev->mtu);
 	if (mtu)
 		dst->mtu = min(dst->mtu, mtu);
 	dst->halen = 0;
@@ -998,14 +999,25 @@ int mctp_route_lookup(struct net *net, unsigned int dnet,
 			mtu = mtu ?: rt->mtu;
 
 		if (rt->dst_type == MCTP_ROUTE_DIRECT) {
-			mctp_eid_t saddr = mctp_dev_saddr(rt->dev);
+			struct mctp_dev *dev = rt->dev;
+			mctp_eid_t saddr;
+
+			if (!mctp_dev_try_hold(dev))
+				break;
+
+			saddr = mctp_dev_saddr(dev);
 
 			/* cannot do gateway-ed routes without a src  */
-			if (saddr == MCTP_ADDR_NULL && depth != 0)
+			if (saddr == MCTP_ADDR_NULL && depth != 0) {
+				mctp_dev_put(dev);
 				break;
+			}
 
 			if (dst)
-				mctp_dst_from_route(dst, daddr, saddr, mtu, rt);
+				mctp_dst_from_route(dst, daddr, saddr, mtu, rt,
+						    dev);
+			else
+				mctp_dev_put(dev);
 			rc = 0;
 			break;
 
-- 
2.34.1

