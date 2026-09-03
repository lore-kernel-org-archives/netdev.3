Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF1E4EC64D
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 16:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788452800; cv=none; b=Mgv3GzMwntuNaBjbRT7vTFNsBfr/pfSk6qSIS7hMEKgK11D0lW1SPQ822QxZ4n9PPqrom3A98GWUssirj4BpilvvKzsMFvxt7p35irLhOK0a6Wy9hU0JAWcowOvrRRuQBpzB3diR0UxDaJaCFCQDQ3y/GkA3CaLQnsRYxRJNDSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788452800; c=relaxed/simple;
	bh=rtw1I6+ZQwIhsJ1KAJ7coYMuQ5TqGSxTCkqUoPJfohw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QDa9T+i+0wBFv1zAz/MZZmMjUNVbEML6mi2SLW6sVk/JCQ0qMyl2YVhaDqup/SJ3/xdY0ZgHkFBOK7igpr7ZCxIhZ/6MjSGq41mp1qaS58iK1Kb0WrGhCtBhZgHNoJMN3HNzgxcJGf73T6rr+fyBGWF76HN9WVLQUPa7f5sv3J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D+Ep61cm; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+Ep61cm"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4839fa1517cso8024f8f.1
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 09:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788452796; x=1789057596; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pPlwGzMzreFTOH2oIaycDj0Xnl8STIJ81ul4wFBoks0=;
        b=D+Ep61cmzJUumCFXw7Lcih6t/1RBe1Aa5mWBdc+m6MuOr4WcUgRF38Lnaa1dPqreKM
         bmrHFUeJXS+uAgU1GkeB/MsUwbd5xHPZ6st0XN6jsiw5bxAJqjS2Mmu6rORhodQlu4e2
         q6RQQYL5wsBGM4fML3gE8Jzq3ahowJlT98cmJv/IwuJvxVYecPvJDxX+19ImxHWcMeEz
         tla9NkJgxlW6q1zqKwwi6XIuAI4myEzTde13e7Uui4cRNd+f6tdoIS79cLxIOboDuqgk
         ONvcgJzvpX8JVkDwmSBhLWY3TXYcuPlkhEUOWOkzoqT9egrRb1NXnhsYXRMAb5egi0jU
         YtOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788452796; x=1789057596;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pPlwGzMzreFTOH2oIaycDj0Xnl8STIJ81ul4wFBoks0=;
        b=m91HWIALxa5qYUZT4NizHYjSiLkUmNVLtXtpXF8HveP5YK5DbgjTrfldb++S7DJx/L
         2Ext2mFbPfY7BX90wxREw47812h7nR0ZkSmF7eIaeqojGvgEnb1WyVkP5pMuFRUvB0B8
         bgxHqO3DV+OlkvAj25am5gsFWX5JCf4a4YbLalM6F8OttJA+PDf0xnOY8YexMqluOjbw
         3FE1t4+SmcXspKknIVNdQFHz6c6HKvSJWBZzNsERdAln0/dELQa3r0hS5zqxAy72UeX8
         169GbqPEMzoOS+oU66WzRcHAKuMf/j6Eb23VMwIOy28GQKD3C8RZ/NlI5LZRPgYe2Sy/
         CgTw==
X-Forwarded-Encrypted: i=1; AKwUvBzqjKEw641OQImX0lTDxBapaTDOJ1j9pyhVYULrn7aKHIKx6McFJ3bNPa7CEB87y1fVPDWruX8=@vger.kernel.org
X-Gm-Message-State: AFuF++nTY8kwOhO7kt+4A3Zor4cDtg3lQq+L8UMmmfeFoq/hkpOvWYzk
	3IGlaXQ70qmz6mw7FabZbYtQ33XAoZK8wTeGGa9Tj50SfvGZNqJKwIIDa4qX5HFlGAV9Kw==
X-Gm-Gg: AYBFou39CPzK8L/iF04KHNjbhFmDC2OnMtmjpV37PTZJloNyOeOuqh/GJkFqPjGFGHk
	TYnzAtIkUStfGb3exrDB4PnFgP8HQlUw0iNjKCTr2Ofe7OqOdt4BM3hHqDotP9YbMmV49MESlB6
	CUs15fuy34ypdXi7P3xSpqjUeRIxP14hXpdBK+bCXxHrzeqnXPfESJQ7szKPDChYDdrb9wMbnh/
	z0wrePkBewlTbvTmaV0xcRt6O0FQG64vL8lX6wCGTHJvtPnOFX7m/rLWq8BsdbG9scqzjyt7JE3
	k4PNMLHKjSd7DlpOVR6rzUCvcHHuajBmacPwpCQfVtW145V5gotc0v51ULR2etbIZf5sMcODzhf
	wg3XD464MGU4CxyIWuC1MfP1KETnwR+nkj48BX4TcwBwvHXY8aJd4GvDlR5UeIoq7miuiGWWm2e
	JPKb15HSktzy/cdS5sJQVmJBi0uqC3KPhIyp99TNdNTyA=
X-Received: by 2002:a05:6000:4a11:b0:484:3310:f393 with SMTP id ffacd0b85a97d-485872e4232mr88305f8f.5.1788452795980;
        Thu, 03 Sep 2026 09:26:35 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::6:124b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448e72c28sm16058322f8f.6.2026.09.03.09.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 09:26:34 -0700 (PDT)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Thu, 03 Sep 2026 17:26:00 +0100
Subject: [PATCH net-next v4 1/7] netconsole: add an address family to
 struct inet_addr
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-netcons_ipv6-v4-1-bdd183c844d3@gmail.com>
References: <20260903-netcons_ipv6-v4-0-bdd183c844d3@gmail.com>
In-Reply-To: <20260903-netcons_ipv6-v4-0-bdd183c844d3@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>
Cc: Gustavo Luiz Duarte <gustavold@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
X-Mailer: b4 0.15.2

netconsole_target stores a single 'bool ipv6' to denote the target's
address family. This makes it hard to detect conditions like "no address
set" or ipv4/ipv6 mixup between local_ip and remote_ip.

Add a 'family' field to inet_addr so each address stores its own address
family: AF_UNSPEC while unset, else AF_INET or AF_INET6.

Nothing reads the new field yet. The next patch switches the users over
and removes the bool. No functional change.

Reviewed-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
---
 drivers/net/netconsole.c | 24 +++++++++++++++---------
 include/linux/netpoll.h  | 10 +++++++---
 2 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index b358e5c36735..432b66cf111a 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -225,7 +225,7 @@ struct netconsole_target {
 	bool			extended;
 	bool			release;
 	struct netpoll		np;
-	union inet_addr		local_ip, remote_ip;
+	struct inet_addr	local_ip, remote_ip;
 	bool			ipv6;
 	u16			local_port, remote_port;
 	u8			remote_mac[ETH_ALEN];
@@ -428,6 +428,7 @@ static int netcons_take_ipv6(struct netconsole_target *nt,
 				continue;
 			/* Got the IP, let's return */
 			nt->local_ip.in6 = ifp->addr;
+			nt->local_ip.family = AF_INET6;
 			err = 0;
 			break;
 		}
@@ -469,6 +470,7 @@ static int netcons_take_ipv4(struct netconsole_target *nt,
 	}
 
 	nt->local_ip.ip = ifa->ifa_local;
+	nt->local_ip.family = AF_INET;
 	np_info(np, "local IP %pI4\n", &nt->local_ip.ip);
 
 	return 0;
@@ -741,10 +743,10 @@ static void netconsole_print_banner(struct netconsole_target *nt)
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
@@ -756,14 +758,18 @@ static int netpoll_parse_ip_addr(const char *str, union inet_addr *addr)
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
@@ -871,7 +877,7 @@ static ssize_t local_ip_show(struct config_item *item, char *buf)
 	if (nt->ipv6)
 		return sysfs_emit(buf, "%pI6c\n", &nt->local_ip.in6);
 	else
-		return sysfs_emit(buf, "%pI4\n", &nt->local_ip);
+		return sysfs_emit(buf, "%pI4\n", &nt->local_ip.ip);
 }
 
 static ssize_t remote_ip_show(struct config_item *item, char *buf)
@@ -881,7 +887,7 @@ static ssize_t remote_ip_show(struct config_item *item, char *buf)
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

