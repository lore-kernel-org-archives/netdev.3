Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835173CEBBB
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 21:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785965638; cv=none; b=CDAcFr+1Y2FjHOkMZxQRwSA5ahrjkVsDbRJC+nsum4QlwX6p1bNkRKBs2liosk6Eqlizo15Zmu0W+I1DKkkkfLKkhqsFjZyjh5Ag01y2nU+sMJdxiY9K990o/Yfa5Wbsc4CQ5r9Wq9O3KusKFO3ASoATgST0RnsGw+Jrti7Ksag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785965638; c=relaxed/simple;
	bh=rEQB9j55XQ8igGPwemfS3N0gbAPOlhN3CcMoZha5xDg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o52XD2/0yd5f/GMbhY3iz1U0QDmIXUFEEvloHQo59zl5XRns6b9JcvEpyjc0BKAHjZ3om4cUIx151fn9X4Y1Vi42VH9TDqn6SdHQy/2WUQn7MF7f2VD6GhPikgPq3SyzDIZiqJ0j0R08KYl0ERXVlqbSoVh8lu9EMOnLS8X2bFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CP5DoTvD; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CP5DoTvD"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4957799b92fso978825e9.1
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 14:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785965635; x=1786570435; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/sTTgLUY5GPNw6xzYiSteMCin6Bg9dthb3pni8zICBQ=;
        b=CP5DoTvDtUDS9t+rLHwHFXVMSzm6e7i6meibzfVrtZcJFit3uglaYOT8ge0uWNtFYO
         X1u4VJi0AxV/ZG7mm23K3oJKB1q4/X6auSzxaWNgxRtxHfScfzXGnl0nzjD+F/7i1iS0
         T8vZ5CFBII4CmoinhVLuQlqX8qwyo5yNzLejnQB3HpfLx0JYSRwErU7MAA+HvCkTwrdF
         0mxIb1y4WTlev5Xg4BO024EtKQYHchlFUePgnGEb+Jyj+JQBzQPyR2yoeKmjkOCAIhDa
         N1RyOfvn5f9/cWIxs7mAFZXpc2wMoCJw+0dOe6+TWrgB3h5Qp3GQZUa/ZW6wM76DO32u
         wvjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785965635; x=1786570435;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/sTTgLUY5GPNw6xzYiSteMCin6Bg9dthb3pni8zICBQ=;
        b=hC38Yaicumgf/y9p+PFM7jgc4REbDOCoIfWnGRTLgtm5gCoy/LZfSIppgu560OZv3k
         vkisYhnbeW2U7E5qYOysk1gtekmSLYxbkG4FVcjLtHRAWw5LR2wWnUU+u5wCsjNeNyhM
         XwRPz1qUErjsau8aZJ1mzBpsJCn56I2bKFRTQkpu6uxIPDfEBw6vx5+qyxqHaI4WC32D
         abrHIY8iWeEM9PX4idQ7TMGVi0zsRKNcuNL/cUQ4eOSWpKibvKJs0GfOFJlAcztAV7U7
         HQLxb9KPXg1qpi0OuqWvZZEDkMCnJDtbO4I4SPTk7wrsbb1tnUr7wr+yRUyqqSIWIIrZ
         ZwIg==
X-Gm-Message-State: AOJu0YwQflS8nm5he7AxUfI/Bgmnoc1C/5TowFu/lV7nm7b6lyO/ta9s
	GZkeFD6aWWJmx4EP9t4RBZobDsCXzoq9JXgqpVZT9dvp1lnNBHm9Lho8L5U+uvSIb0c=
X-Gm-Gg: AR+sD115Vz0CIDhAM1xvbYWAAOwBTNtMJKYA2X4S0ruLcZT831LQ1snwg/FkEeLiBA1
	2paCVvG3qiIWIEp1r8lkTtS+qjkbO2cG30cji5HEInTuHrAUZAYYnycV9ATgjRmsfUqfdCPadG9
	X/F0BmtAktWrFGDA0aEuoD3eja4MuT9f5DoXjDr2Xg9pwcr+5ljPeQ4IcYtQgDUBT7Gzd1Qf3FN
	vbBY9GUWAwG6ddRhIP88B7Eeb5Jy30I7IXWVhzqhDTTa7jFvBk25Y/qE05hBJcbo3/A+wd8J/g9
	7nJmRRm55ceTBsFd2RsQlGYVBc50SkAZKFx8NKZAGrspzCBZPL3ISSFIZG8dxVku3hBe66ReWc1
	DNO1Gx6JtCVEnkKOuSYaGvF3cvK4nRQhaiPUMDdoY9nZZ4cnJDJ+Az9Oe30Ee1vOHM0+MqaFeFb
	UY+ykDJN2G6u4INRZsKIRnln5X4LVjsC1yFxeUF/Nwfv0=
X-Received: by 2002:a05:600c:b85:b0:495:4505:dad0 with SMTP id 5b1f17b1804b1-4994e7ba5efmr68556855e9.2.1785965634615;
        Wed, 05 Aug 2026 14:33:54 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::7:f900])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47ff7b18374sm409733f8f.23.2026.08.05.14.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 14:33:54 -0700 (PDT)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Wed, 05 Aug 2026 22:33:01 +0100
Subject: [PATCH net-next 1/4] netconsole: add an address family to struct
 inet_addr
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-netcons_ipv6-v1-1-170a35b92da1@gmail.com>
References: <20260805-netcons_ipv6-v1-0-170a35b92da1@gmail.com>
In-Reply-To: <20260805-netcons_ipv6-v1-0-170a35b92da1@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gustavo Luiz Duarte <gustavold@gmail.com>
X-Mailer: b4 0.15.2

netconsole_target stores a single 'bool ipv6' to denote the target's
address family. This makes it hard to detect conditions like "no address
set" or ipv4/ipv6 mixup between local_ip and remote_ip.

Add a 'family' field to inet_addr so each address stores its own address
family: AF_UNSPEC while unset, else AF_INET or AF_INET6.

Nothing reads the new field yet. The next patch switches the users over
and removes the bool. No functional change.

Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
---
 drivers/net/netconsole.c | 22 ++++++++++++++--------
 include/linux/netpoll.h  | 10 +++++++---
 2 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 03913302328c..d615a9256787 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -212,7 +212,7 @@ struct netconsole_target {
 	bool			extended;
 	bool			release;
 	struct netpoll		np;
-	union inet_addr		local_ip, remote_ip;
+	struct inet_addr	local_ip, remote_ip;
 	bool			ipv6;
 	u16			local_port, remote_port;
 	u8			remote_mac[ETH_ALEN];
@@ -415,6 +415,7 @@ static int netcons_take_ipv6(struct netconsole_target *nt,
 				continue;
 			/* Got the IP, let's return */
 			nt->local_ip.in6 = ifp->addr;
+			nt->local_ip.family = AF_INET6;
 			err = 0;
 			break;
 		}
@@ -456,6 +457,7 @@ static int netcons_take_ipv4(struct netconsole_target *nt,
 	}
 
 	nt->local_ip.ip = ifa->ifa_local;
+	nt->local_ip.family = AF_INET;
 	np_info(np, "local IP %pI4\n", &nt->local_ip.ip);
 
 	return 0;
@@ -731,7 +733,7 @@ static void netconsole_print_banner(struct netconsole_target *nt)
 /* Parse the string and populate the `inet_addr` union. Return 0 if IPv4 is
  * populated, 1 if IPv6 is populated, and -1 upon failure.
  */
-static int netpoll_parse_ip_addr(const char *str, union inet_addr *addr)
+static int netpoll_parse_ip_addr(const char *str, struct inet_addr *addr)
 {
 	const char *end = NULL;
 	int len;
@@ -743,14 +745,18 @@ static int netpoll_parse_ip_addr(const char *str, union inet_addr *addr)
 	if (str[len - 1] == '\n')
 		len -= 1;
 
-	if (in4_pton(str, len, (void *)addr, -1, &end) > 0 &&
-	    (!end || *end == 0 || *end == '\n'))
+	if (in4_pton(str, len, (void *)&addr->ip, -1, &end) > 0 &&
+	    (!end || *end == 0 || *end == '\n')) {
+		addr->family = AF_INET;
 		return 0;
+	}
 
 	if (IS_ENABLED(CONFIG_IPV6) &&
-	    in6_pton(str, len, (void *)addr, -1, &end) > 0 &&
-	    (!end || *end == 0 || *end == '\n'))
+	    in6_pton(str, len, (void *)&addr->in6, -1, &end) > 0 &&
+	    (!end || *end == 0 || *end == '\n')) {
+		addr->family = AF_INET6;
 		return 1;
+	}
 
 	return -1;
 }
@@ -858,7 +864,7 @@ static ssize_t local_ip_show(struct config_item *item, char *buf)
 	if (nt->ipv6)
 		return sysfs_emit(buf, "%pI6c\n", &nt->local_ip.in6);
 	else
-		return sysfs_emit(buf, "%pI4\n", &nt->local_ip);
+		return sysfs_emit(buf, "%pI4\n", &nt->local_ip.ip);
 }
 
 static ssize_t remote_ip_show(struct config_item *item, char *buf)
@@ -868,7 +874,7 @@ static ssize_t remote_ip_show(struct config_item *item, char *buf)
 	if (nt->ipv6)
 		return sysfs_emit(buf, "%pI6c\n", &nt->remote_ip.in6);
 	else
-		return sysfs_emit(buf, "%pI4\n", &nt->remote_ip);
+		return sysfs_emit(buf, "%pI4\n", &nt->remote_ip.ip);
 }
 
 static ssize_t local_mac_show(struct config_item *item, char *buf)
diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index 1c6b1eec5efd..de97f001a0f9 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -16,9 +16,13 @@
 #include <linux/ip.h>
 #include <linux/udp.h>
 
-union inet_addr {
-	__be32		ip;
-	struct in6_addr	in6;
+struct inet_addr {
+	/* Address family: AF_UNSPEC when unset, else AF_INET or AF_INET6 */
+	u8			family;
+	union {
+		__be32		ip;
+		struct in6_addr	in6;
+	};
 };
 
 struct netpoll {

-- 
2.55.0

