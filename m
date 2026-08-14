Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2183AFAEA
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 19:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786735768; cv=none; b=ThH5iGByY24GYGxXreOY/oOGZN21hKb3rZ1vxdvwT/Fi8qrG6IgoDeO3DhHijbGDSij/1+G9+HbGVMsCOLbvttr1amsz6exVgjhf7KyiqcxfEjAQhGq7vdbgVmOGtl64wqH76Hm/GKvOHAxywR7Lx1kCC8H4Iyy/xCFse+xMqMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786735768; c=relaxed/simple;
	bh=rtw1I6+ZQwIhsJ1KAJ7coYMuQ5TqGSxTCkqUoPJfohw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WBIEIOTibV7d62yW/N1UkgWWhv+8EJ3ZtqGwTVE0SQHCH2zIkQ0rlGLObyKfU3WWzgIbfkzO0/RLYiX6AFsK8Y7Ax+s5F8BEsZVE068tR+1fXJIoFh/H4IT5YLwHanPprx/bYGmare7LXZjENyFQ+7Ciia9Qmy8gbHHT/eqXYg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h7xeKATe; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7xeKATe"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4954b3c5cbeso897135e9.1
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 12:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786735762; x=1787340562; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pPlwGzMzreFTOH2oIaycDj0Xnl8STIJ81ul4wFBoks0=;
        b=h7xeKATeduxjxa8W2gweEPuq3pMFlG9BxUDMfX0sUlvjmDtNFCN18BsIoA72bX8kKw
         pM8wDLMk7wwCtXYWEL9BU5Z9YQ0Ka2oP64jUSGaggt/7AxZClS/KdD5R3NyPR9h6Y9LQ
         My0KQWuP9RGHXiqQGlkqsBF0uZdCgmIJm7ahHFgXsVDmrG5LxXBAunl4DFbRkcWWSBXp
         AKcssnYaEYpXNkVtDOdpmdyLqV8ta8q4lpMo5RMW5c+UjXMeE0KTZY6mmdpJX7ucYbcE
         q4Nwde21YOkGHzFBrGGchSTgK/0Xj/wvkE8ORUUbADmyV2CNRHdWPCvK/QQYpzAlopv0
         WV/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786735762; x=1787340562;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pPlwGzMzreFTOH2oIaycDj0Xnl8STIJ81ul4wFBoks0=;
        b=qfROIkqZHOvS7rYAn/GL3WkDyXEz6ihYA5aO9al7M0UmEj5NH7q9GUJNVOUaZzCMY7
         RcofBryC/5NkLFpkC8Bes+8rT8XDoYT1WHrhzd6P1slCuT1Qs0l4eniuKAF1SBncSyUb
         0XX6BtGTVfQhI7frbEvHJDhpIf9Yo+sx6BiCd2Ww02Wh+U/3+Bo1bpuc9LdeKmhiv0Hc
         0BHmMOZ2ZZUCi3DTamkN0MBfLj0Lg1UwW31ZtDTYc5jbd1EFyfzshjWVYv0Wf7nreYst
         Fz0NnRCcqvf8rHugNmBEkrU0L9SMbtV8Jj1ppQLM97y634OShNWFy6gETXkNGMCknxYB
         yRfQ==
X-Forwarded-Encrypted: i=1; AHgh+RqIcCGGscpJ3j91aGjyrVdLOT9gcCjv9am2MW49QhdRyrIv7Q0nXP19v4VH/wZ4etwIxJnz8vE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAN5VqwYA2jF8Tyv3mQ8jxTVw2qB1VAkgNJTfXfdYwkvxeepqz
	7G+rccfuAicIATK5UOI58AJOVXjets3XznAskgbQUwYZdpikG0f/MxnN
X-Gm-Gg: AR+sD12S5rVMnLDrVBznqbecqomM6s9qcJ3zzrJ+8yHrHbY+vzdVOCXQefYzFzpPCUC
	u6sl+3HOurZ61xPX789SndBS9a4Iok1rJp/MPyo+CVI2SWRP3dHAZm6UvFrbjcsr8XsccUoyM8x
	6Ks8Lsb407F0ibWm3bCiPB2WFz6Os33Fu5viyBGj3S9jcj40dOdXJKKxVQkcirFXG7Vj2/15zNC
	OhS35Js3ynYcwEYmOhkwo+M3RvKD0nRlk7ZphZpyMDLDzwvwxXpaB+yef7lx3r1xD9HGiUdr7bd
	PWg/eWggvNwrPbvKzlrYVoYvH4MpH0cvJanhNHbvyxSprGl35w1k7Iq/QfBWeC28SSplRdI9ZMb
	boP4SNDJnbwM77wwTbP1ZBUTMv2vDzI/llknr+NENyHxlVSQTj9uLsEeki3BcYco0r9OAxTjGIS
	Aft0oqJfTfTZ51FlzbsUbW00M2Rs1mZ+gpo8IqHqGf4fAx13gLVaT0BQ==
X-Received: by 2002:a05:600c:1395:b0:499:77de:78ba with SMTP id 5b1f17b1804b1-499879826b2mr57167795e9.2.1786735761874;
        Fri, 14 Aug 2026 12:29:21 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::4:391e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49988b2a87dsm67293475e9.15.2026.08.14.12.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 12:29:21 -0700 (PDT)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Fri, 14 Aug 2026 20:28:52 +0100
Subject: [PATCH net-next v3 1/7] netconsole: add an address family to
 struct inet_addr
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-netcons_ipv6-v3-1-bc0915e8c75f@gmail.com>
References: <20260814-netcons_ipv6-v3-0-bc0915e8c75f@gmail.com>
In-Reply-To: <20260814-netcons_ipv6-v3-0-bc0915e8c75f@gmail.com>
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

