Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907AA2F3C1F
	for <netdev@vger.kernel.org>; Sat,  8 Aug 2026 00:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786150624; cv=none; b=PrVAakkAyfW9JCsyl60nOFpOwnF0fbuLTsVgpCSdg8Ff0Om+MmxKmFSeSngC0EsJhfRSUnp7NRpNm4ORVtdnYqEg7+Fm6Cdr9EDlM8IO6/KhvyItvVZuTmPmeJ3yK2fIs6bHDXPe9M1qmwq4tHvBEuwP6Jdm/uJUpuvfyUsow/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786150624; c=relaxed/simple;
	bh=XQJawEmB4ChsklAv/eN7LUVOMlZahRxCMEiqQmik0xo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZK41rYOZN8R/vHXh9oesyO6MSPzf5Cr3WA/7hYnpef/Nj8AY4eSCsNBq5EH8HiUgXUt3u8cco/Y9u4cJqaob+64sIJ0vr/nPj+t5GzDoGFhwyw5hhn5TGwEnTRZ80pmevRpXosKPR5PtTX0gKTbwHgP5v5PxZNfm20+7tWpb9IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j6PU/HIz; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6PU/HIz"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso145207a91.2
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 17:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786150623; x=1786755423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y1uuKJgg5m2EeiKe39lLJSMZdROY6ZIIFzIHwqt463s=;
        b=j6PU/HIzDFLyEw5cXWhHi9Qt4wDjYCK4cBi1CbnYLtgy+aIEPa1T9UzqZi2Uw2V16h
         Nu+lfPQdKCL2zPPKbF6s7qq3jx54+bUzeI+QlCDBEI3aDXYKlVxZi5RDPdKsr4KWy3ZX
         DfPzsWxGt36AtmtuvY2wpq42GDtEw6vscsbhH2eL1gOE9qcjBis7jEkRVmrz12wVVBOd
         0N7Fo7n2PSx7fCZmBgRNHfFvj5r6yWgP/FC9X/clETAo2fI1ChTMxjqh08jehHrImIR2
         oCO6bR4AQlxHNmqvNhjdWCY1sEkWs+ZeiAjYDR+4lGRqqzF7lRMmJY8eogubTsrF8F6d
         Uw0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786150623; x=1786755423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y1uuKJgg5m2EeiKe39lLJSMZdROY6ZIIFzIHwqt463s=;
        b=GuOGxQOcz96ZqjZ5p4kPooZui1uDUBPEjK5jYXS1b/pcplQX6W1eXdXLPB/5G91X0b
         QUPtAhI+ffMB7HH1A79J5o/B24wkrT4um0HYLVbSf8xMmadu4K3B50PNYb43Z48yN2z/
         +b57r5ij062YG6yj9Hhwm8YgMVWxeVGaKm1uQq9hlBBcMwY3wRDJE2/8xWKF26Kz0omg
         qHj70uT/RlwdKKZC7IpmkQPV3mfaw7aKSp1tarcHid6syANl9IDOulZcAChH7YEYBBcb
         TCEXuy1hufZ15ogJhH71Iq9fNWbQw0K/28/h6L4jqh82guvudutD02Fcw4l9pTmQGPBP
         mAbA==
X-Forwarded-Encrypted: i=1; AHgh+RqxNvcxv50aultP9iQCRJ680nsxztwQeMswPfHgj3dwCvhfrVUz5/2oDGJPXrZ6j26zCRmj9io=@vger.kernel.org
X-Gm-Message-State: AOJu0YwinsMS7MbWqTKDlFOpL1oQNzNVY7C5gwyOycbfv6vhgpUEAFSa
	6c1MJxEwkDH6tF609pC5/xIo1f7catQXlm7UJ/HQuHpkLfKY3bzoLQ8f
X-Gm-Gg: AR+sD13jMezL2XquL9TaVPRLsl/QKtef+TLAvzAg1ZfMPJPklnsHyzeuOEA/pD5PwFF
	wgi0exdtIJfszgzHFIyuGJQKGb5UGgZmkpo9kOmLelCq19q9TJEmBb8dqMX4w12xI+tZnkIKe38
	svLZjEtKSxfmyky2IHRVIRBjeA9O0Gx5BFXh4FDK7zQ3xr88Cc1J++vuS1QWdFHZYCZlEBoFtt7
	9cyNLcH1QgYw+wvIm8HOMODN7RqT0RBzS188LCI4vjgoQ+qcoDSmBdXYiSy9xf3fk5wrw13rl3L
	ABK8AUQ8SeVsOX+5EeaBc6hgMshDdT4ccGJCTRDuuSGJGrlh/XX5Ws1gXTl8D/Q4WBBH8LtugVu
	C1WseYkYkqsL2f8GWtv5YoRthfbUF6mn5MPn5AT8hJc8GiZpL1HaF1nVfeBF5IeFEPRzXKCjks/
	351VKliujpCEBqGL6V2NWYuPBwrqe0hRLSMUP5JHFO9bWyAfKLZxb1vbeodYeJlXMnYYiSvAHXw
	Btpdq1HsNteiC3ZUH95dhMHCJ0ZH7/CqgnN2fb/25qJAEjINog=
X-Received: by 2002:a17:90b:2dc7:b0:380:fead:448d with SMTP id 98e67ed59e1d1-392620e6e25mr8963187a91.13.1786150622906;
        Fri, 07 Aug 2026 17:57:02 -0700 (PDT)
Received: from m-upc-A520M-HDV.flets-east.jp ([2400:2410:3f60:500:d7e9:6449:7464:1dfa])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3925fc6c13asm4205182a91.2.2026.08.07.17.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 17:57:02 -0700 (PDT)
Sender: Yuyang Huang <uyoko90@gmail.com>
From: Yuyang Huang <sigefriedhyy@gmail.com>
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Chris J Arges <carges@cloudflare.com>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	David Wei <dw@davidwei.uk>,
	Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Willem de Bruijn <willemb@google.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v6 03/10] ipv6: record the reason for kernel-initiated route deletions
Date: Sat,  8 Aug 2026 09:56:35 +0900
Message-ID: <20260808005642.26901-4-sigefriedhyy@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260808005642.26901-1-sigefriedhyy@gmail.com>
References: <20260808005642.26901-1-sigefriedhyy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Record why the kernel deletes an IPv6 route on its own:

- RT_DEL_REASON_EXPIRED for routes reaped by the FIB6 garbage
  collector after their RTF_EXPIRES lifetime ran out.
- RT_DEL_REASON_RA_WITHDRAWN for default routes, prefix routes and
  RFC 4191 route information routes withdrawn by a zero-lifetime
  Router Advertisement.

Deleting a default route because its metric changed is not a
withdrawal, so it keeps RT_DEL_REASON_UNSPEC.

Signed-off-by: Yuyang Huang <sigefriedhyy@gmail.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv6/addrconf.c | 3 ++-
 net/ipv6/ip6_fib.c  | 2 +-
 net/ipv6/ndisc.c    | 4 +++-
 net/ipv6/route.c    | 2 +-
 4 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index f6fa2715b450..9d89be7e0544 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -2874,7 +2874,8 @@ void addrconf_prefix_rcv(struct net_device *dev, u8 *opt, int len, bool sllao)
 		if (rt) {
 			/* Autoconf prefix route */
 			if (valid_lft == 0) {
-				ip6_del_rt(net, rt, false);
+				ip6_del_rt_reason(net, rt,
+						  RT_DEL_REASON_RA_WITHDRAWN);
 				rt = NULL;
 			} else {
 				table = rt->fib6_table;
diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index 1f6f6f33ded1..f8a9ec7fa616 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -2403,7 +2403,7 @@ static void fib6_gc_table(struct net *net,
 
 	hlist_for_each_entry_safe(rt, n, &tb6->tb6_gc_hlist, gc_link)
 		if (fib6_age(rt, gc_args) == -1)
-			fib6_del(rt, &info, RT_DEL_REASON_UNSPEC);
+			fib6_del(rt, &info, RT_DEL_REASON_EXPIRED);
 }
 
 static void fib6_gc_all(struct net *net, struct fib6_gc_args *gc_args)
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index fe36b3f51285..1111c4ebc61d 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1361,7 +1361,9 @@ static enum skb_drop_reason ndisc_router_discovery(struct sk_buff *skb)
 	defrtr_usr_metric = in6_dev->cnf.ra_defrtr_metric;
 	/* delete the route if lifetime is 0 or if metric needs change */
 	if (rt && (lifetime == 0 || rt->fib6_metric != defrtr_usr_metric)) {
-		ip6_del_rt(net, rt, false);
+		ip6_del_rt_reason(net, rt,
+				  lifetime == 0 ? RT_DEL_REASON_RA_WITHDRAWN :
+						  RT_DEL_REASON_UNSPEC);
 		rt = NULL;
 	}
 
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 252f1825a199..bb14d7f7bad4 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -1020,7 +1020,7 @@ int rt6_route_rcv(struct net_device *dev, u8 *opt, int len,
 					gwaddr, dev);
 
 	if (rt && !lifetime) {
-		ip6_del_rt(net, rt, false);
+		ip6_del_rt_reason(net, rt, RT_DEL_REASON_RA_WITHDRAWN);
 		rt = NULL;
 	}
 
-- 
2.43.0

