Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D02426EB8
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 16:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786380468; cv=none; b=t9FeOmzZxI53RNQ9QT63dntKQzdOc6McKleWqKeYiiXT5PV30oCFMqLZBQz8NNj5+BzRyN3cNyWM4UVr0FYvGuE7Cg+MfiJ1mzziaf4pv2xGCVdP0QF12Db52WSHVx8WZSREYnbQEu6396vrwgCcTuqhgyMkqZrkhFX8wcLFGbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786380468; c=relaxed/simple;
	bh=Oo8YmQRgiTmOCrg5RSPtjsxDBofKu2mN03t7WY6Z2+4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s7FH3WPo7WMsYVJ2DxTvFoCFDTSImMR4hnr1oydcJ3tRXxhkLcB8rjiUPzMXQN+heyex2HvI8hT/nxwZkY8T3uP5a2t2Sd3xyPqCuS1PdpUPrQEBiiW/7/x9Uz/iS0iafcs1nA9PNp6z6cijELVsjxWdVLYuEMX6995ujp9vQcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gMcNi4Wz; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMcNi4Wz"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49967f24eedso2935325e9.0
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 09:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786380464; x=1786985264; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QUij+bPWme5H0Y1xcQFrN7EqbdY3sRjm1DhYj2MYjvM=;
        b=gMcNi4Wz7fBtCNSs/+e9evIxHqSu0G/E/Q1Lvukza1FV6WQj9PGg3nD/V/CU20bp2Z
         R8IyJwA9sjnlmaplVI3nKTMCf3x8xT/iguxeuU5ZpVcccIFHUUpV7nWiZZhobiRsjF2m
         n6Z+nFUkRZNMsUYJRu4U5XO69bLlOb3K1M9HP7ACvXJJ03hQOxamA1qHp59rjzzvR8KP
         c9rwUmv/b3Tua/yvs312FDI+We5OfGEsR6U+OnuIfa60oGkvnWSYXnFr9exbD9Btd9Jv
         gBzxNY3oFPOVXnH0u7t9vN6Psg5b6+6eA42U+xam35L0imfUGhC9+7alBJ2xdXcjYWQo
         sIDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786380464; x=1786985264;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QUij+bPWme5H0Y1xcQFrN7EqbdY3sRjm1DhYj2MYjvM=;
        b=NiwMRf1i+AqrQD+poX1RI/mF/HJnfbKnTSYw3RgZSEIlKMmS5m4zq4ur+zeUoq1rzb
         oezFoISG6OpVg3Ww3L8PlI3tdd+EnLBhtddVGmZE+5uAT/M2hidkvdzAAcbyPr4wVVNT
         ZXbf6DHH+FZvzAuGXU+4ZJ9mDtUdW20rGzDP7QxEbmB6HGkuJ6DbaVYfMPpIcfPeZeAZ
         pDjlPjyqWM5yE2MwUybDEVbtRkpFE7PPXIxGBziUSndp0daV0Hbs6mHbAKBqlrZjg3IP
         OqjFbeS+FFLHxRy3nvNUBLFg8pWYQLAgh0Cvc826CXlQPk6fFu+mUt6t3s2qZyiwqLdK
         1ujg==
X-Gm-Message-State: AOJu0Yxlzp3xvc4hIuhTMuzVf3rozlfKvCBW1hd6Jlg1VNd6CSESUv15
	yAXAQl159gwKSe83Ooj6c40O9yT2XiVnLRLAkLj2PRxQ48HA9jcsFT9R
X-Gm-Gg: AR+sD101oLrFEd21EYDeJ5+nScLrvfkUEToZS+X07moGam06yntiwMB38Sm55euIH+V
	WL8s486OTK0DNranAbbPAOi5EI7uaLjzA9Km+AedHiPh2G/m6HZxRaFuTUMjDp7Q04Io0nAauKZ
	3kQleb0PhJEvbOizajG3PyhqRoVTlrYc+nm4hVQe/hQhkD0rCdsbqZt/wGhRBNOi7gkSGCpA140
	igdHB8kPbk7lmolNqc/E7zf2VF81Saret7cacuLo+oyPZA32gdYmXXvTP3RqyR5EauuLFqhjPAm
	fTiX/2V6pOI25JLP7bKRtqhy/UgpS8fkUfz/grlu+FzmltLp7HuP5PCaHWydQpNn2k0+CXLcWqc
	WduAeHqbOk1LhBsBqjhy3gCtS0xY8MRy9OPd+lpHwNpWim3SEvfIqJF7mqV1AS3Ps+fInrmub6f
	mbMqPm6gSp13sVuwj8Kptq1etXZWV/hIurckgxL3zpBfM=
X-Received: by 2002:a05:600c:3b14:b0:499:5b0f:72b with SMTP id 5b1f17b1804b1-4995b0f077amr185982305e9.1.1786380464356;
        Mon, 10 Aug 2026 09:47:44 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::7:692b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499740c46efsm5426185e9.4.2026.08.10.09.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 09:47:43 -0700 (PDT)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Mon, 10 Aug 2026 17:47:25 +0100
Subject: [PATCH net-next v2 1/6] netconsole: add an address family to
 struct inet_addr
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-netcons_ipv6-v2-1-3d4fc987a90f@gmail.com>
References: <20260810-netcons_ipv6-v2-0-3d4fc987a90f@gmail.com>
In-Reply-To: <20260810-netcons_ipv6-v2-0-3d4fc987a90f@gmail.com>
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
 drivers/net/netconsole.c | 24 +++++++++++++++---------
 include/linux/netpoll.h  | 10 +++++++---
 2 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 03913302328c..94a662c7369a 100644
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
@@ -728,10 +730,10 @@ static void netconsole_print_banner(struct netconsole_target *nt)
 	np_info(np, "remote ethernet address %pM\n", nt->remote_mac);
 }
 
-/* Parse the string and populate the `inet_addr` union. Return 0 if IPv4 is
+/* Parse the string and populate the `inet_addr` struct. Return 0 if IPv4 is
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

