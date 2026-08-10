Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A99E42F700
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 16:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786380479; cv=none; b=Pe4cNWM8mKPiE4UAEgdJvwVlBBVh2vztUanKyww8RKzIfIlOiBSj6zVpKttgqCagtUx/IADzvb18dRsay1O5qCHyt5BU7LShEsvPgxAQonpED8gms3Xt31rSysUqTbnfi7z9irtcaMIBwWAGY2oRM/itDEwAL4kaTVDc/ZP/bkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786380479; c=relaxed/simple;
	bh=t/OvjGuVBrq4uGHwkR+woHevYj6ykvarkJcjPcBQJoU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EESVyxPl10mZueRvuGXc5Sbawwy3xlndXCSPZKacjqQqS5fs197qAlzUpAIssQJl/gZKgf7ldVxfgmvVcY0U53IKO8TZ2pBjBdhMNH+9YU3XXS2qS4Oxxbo6nZS+5oiACyOT4yIVE+gt/amj6m5HAMjWDnfzzDUzvJviGZy6r3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fJsw18VA; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJsw18VA"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4957799b92fso1662925e9.1
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 09:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786380476; x=1786985276; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=niH2tRwcLSsfyl44V3yKY7PLg2udy6rA81mInPPAQuA=;
        b=fJsw18VAkq5WrvPSvvJapr2ndNSsyeswp76ss/UOR1O7CRC5DDS7e67Mn/VTH0eEj6
         Esp6ZxDOcGL6up6OkUH89XjQE2PF42DlEfazVIeZ6Jmqdxa5YDL8NnUqI89xW9PZ/IrU
         rmFiq4f3LwWSOCPPY9jD8Ujridu0+2f3fSDvd+VyrF05y+G4xf+PcomzVn82TlWFZfVH
         96Dp+WOaDwpS+DGuZhQNXGIuguj0l3CBINKXGU4G+g5+WPaJ+W6lMfcoRjZ8esQfJ2G0
         OHcJSs1+SaaGMgeYVIFlklcrUQW7UdOgXvdSTOMNJEjUCnvB2xXJGsCwvR3tpoT5+ow9
         poew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786380476; x=1786985276;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=niH2tRwcLSsfyl44V3yKY7PLg2udy6rA81mInPPAQuA=;
        b=Ra6uf4+oZO6FdnDVU+MoI5gaV6+FO3/VPUTkLLl8BJKDHQJW7rGfEU+y0jsT9cxl8y
         Tju4L6q2BuBKOZCKn/fmJrLFrKyGVi50Xm0Gs6AtrN4MffIW1n3PCBMSmqKUHyBQSnba
         71Rb4qIBAbQ5JwRZ7/qlLr91YL6U0kAtkzwf6Cn1c2BNeTf4j4rY6K7wUzgKi3lKh+uQ
         W/R2MlbYenk0VwThGpE5cpONTMZ7LY1BbHDhPwGS0uEciFngHpjSvHOMrWFZY9YwCuAq
         E3Xyv8o1siumBmHJgb47a0ZWiIkuxH6BEzYkInsTTNX9cmeUoTAdDBRCA5ketyNeFtn9
         CGcw==
X-Gm-Message-State: AOJu0YxV4Pr7EIbk5dcTRObvM7DirD0HJgnGGufU16s2cMEtzE40+a/Y
	qMYauA7Pi8CioUkxTz1IvjhF1pK5kcPRTLxPZPYFle5wCMlIMb2lt2bBKRH29cKO
X-Gm-Gg: AR+sD11EKT4zknkSRoE432OcyDORSZsWF+SB49RrE7f36cL3u7l1QU/lzhs+55fk/kx
	8TFZ65rNdc6lWN15GMRh957KB7DiJJYf095k6DbN7gM2zhUYsceuM8W1Hhz8SjKP4n5MQ4FRzf8
	g7luoHuH3VIrvzYYdgJ0zu7NLoQGjincQ+zrXwC227gb+Tg4qr+/oZdhI3YhLGgh4uaHuwdUN7Y
	mEth/6GLGpjio4tEof9lNQ/WfqZh8pYaYfflbXFNSTWnLuKqEcLZ75eYl/r9M5YgXho3iFk4CM9
	eDfqDH9ludtAybAd2ZpbyB3jhPgpJ+hmPNdAv4myCOktifIM2S7HM3UBvdjlb3URuTfm0uijXQx
	KiMfujbVAoa+eLwzqEb5gvzi+qYEiKXX9BjVSoRuUzdL6EWAE+cqfcnA+pD2rmV6FK3fDnXxpB5
	Dv5YlccIbgrcu/W6DZDVo27bcKSdpg0SAcmNPXT5J+OFs=
X-Received: by 2002:a05:6000:40cb:b0:47f:946b:d3fc with SMTP id ffacd0b85a97d-47fec51b36emr34596331f8f.2.1786380475418;
        Mon, 10 Aug 2026 09:47:55 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::7:692b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021f9182sm37080453f8f.28.2026.08.10.09.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 09:47:53 -0700 (PDT)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Mon, 10 Aug 2026 17:47:30 +0100
Subject: [PATCH net-next v2 6/6] netconsole: move struct inet_addr into
 netconsole.c
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-netcons_ipv6-v2-6-3d4fc987a90f@gmail.com>
References: <20260810-netcons_ipv6-v2-0-3d4fc987a90f@gmail.com>
In-Reply-To: <20260810-netcons_ipv6-v2-0-3d4fc987a90f@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gustavo Luiz Duarte <gustavold@gmail.com>
X-Mailer: b4 0.15.2

The struct inet_addr lives in netpoll.h, but since commit a1116396476f
("netconsole: move local_ip/remote_ip/ipv6 to netconsole_target") the
only user is netconsole. Move the definition into netconsole.c

Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
Suggested-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 9 +++++++++
 include/linux/netpoll.h  | 9 ---------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 0418031b6bc9..810ded6e48f3 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -151,6 +151,15 @@ enum target_state {
 	STATE_DEACTIVATED,
 };
 
+struct inet_addr {
+	/* Address family: AF_UNSPEC when unset, else AF_INET or AF_INET6 */
+	u8			family;
+	union {
+		__be32		ip;
+		struct in6_addr	in6;
+	};
+};
+
 /**
  * struct netconsole_target - Represents a configured netconsole target.
  * @list:	Links this target into the target_list.
diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index de97f001a0f9..ec0821a5b02d 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -16,15 +16,6 @@
 #include <linux/ip.h>
 #include <linux/udp.h>
 
-struct inet_addr {
-	/* Address family: AF_UNSPEC when unset, else AF_INET or AF_INET6 */
-	u8			family;
-	union {
-		__be32		ip;
-		struct in6_addr	in6;
-	};
-};
-
 struct netpoll {
 	struct net_device *dev;
 	netdevice_tracker dev_tracker;

-- 
2.55.0

