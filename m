Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9F0418349
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 13:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786108419; cv=none; b=umc+PRvkzYGSpkZlC2O5vczV0ZoiBIsbdrZncy6ca2+3r3Ay1TcwrsbS6QdXtQYLvC1Jci0q2m+ntTGH763qmF19PtP1l7/eTXzYUEUbP5vkDdvp/A/em2GCROqfDcIRbTYKl355fKcNP4Q1MPiGOfr1EjyzQGPYFPRizxE5EpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786108419; c=relaxed/simple;
	bh=qr1ayfYw/TaUJNlhsz7JazjlE9h+RLODo9YzpXaYNW0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LjAKr783RdOazYxOgwGAxC9tPxIF4vNWIZJrcIO8c/hX7y2IjP4GdnYb7Iy2j6ND+qU3vQj3JwHfJK36+pgfYeeOjZv6dFp527ZYiVmhEDy4I+yCZeJo7y/U3+1u8aPoYDs5IpzXuVXg5H21CiByvf2+ZaCyTi4TuIAGqn76uhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LDLFDb9O; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDLFDb9O"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4955de8797cso23432285e9.3
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 06:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786108409; x=1786713209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KvAGMH2SF3OadC27x/m+3YmCq7OMNQ6xjFpJG6wyIOs=;
        b=LDLFDb9OUtqTDULAEN+XVPo4xCfAV2NZxfUOEtf82LPZyOh7iojvqXfIh9SiDLo/ep
         z2lk4mrP/ghd9/LxHp6YuhttT9Qvy/BjWhC8r/4Y7rM5ICc6ZBuUNDcHJOzk5cBqJxdC
         Kl6XAVXPOskh3CHHLwl2KywqyoHe9r/CNr0JPFo/msrtnrN3UFMmKspwM0VU7r6VJCVH
         3x8UqMu+x4ehaElgrhxx9sHMn7Kp/PD/wBigtpK7UaLGp7yAyEbCbphalum/2CUc2gFz
         l6XxTJNLF53nUZTbocpKoz8lXz18N+jGS+uLmPz2xSWOOgQbWAHkmuqmDlO7MAkwAr2R
         n91A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786108409; x=1786713209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=KvAGMH2SF3OadC27x/m+3YmCq7OMNQ6xjFpJG6wyIOs=;
        b=EdqjfxWk2Aq3uL5XRgjJXI+tmx9aVDSHg0yK3Xq+8FuPWEFTWy47h52lD2lGOZZV+2
         1bmq0WXNBLoMNDIsJhm0eJuNfMj0MN0aeggCcssqakjXE4IB5It0C2ZCtl1Rua15L/VQ
         REewFaP9Ql+FvVlneHEz29V+EhMDm2wZVvCtpvy4s2qbDbb2DQZEShd9vF5IKymyoAuY
         iF9eJQa0nPYz8KaLl9Bu2LXO+HJMH7Q5yIsRNjpWtFLdiagTgnJZqAfX+6snvRv2hyxf
         up6SaJWQ5JxXMo8/p7UxsDET/egIoyHfjmhxLYP3RakBI8p6JRrAOL692G4iuR+p56lq
         Bs7g==
X-Forwarded-Encrypted: i=1; AHgh+Rp0ywXiHX0h5JOFHSHMXbQK6uHa79/mnQhhBK9eN/FInSu7SSnhPYevh4pCvFlmHeOvcnwpZ+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGl1AbKs3FBDhZ6zx9rTTkRepl/9zF9dwgbgCeQVY7oUfBV+7a
	1IjyHqTHdcJ487QAYQZc2zivxDHpfE7mEo4r4O7vbEysO/sQYTaQx5mt
X-Gm-Gg: AR+sD12YpLhAV9DqnCwPKCRQRQkRC+lX58nfaEdor6bPpMvmav+INqhYjaEuvIMB5xa
	AyBvrOmfX4Kxf7VXIpWbUhxJ6R9BeXGtp1aM9ZeOcnXuMV82yptSnAo+FvxCGTDREr7hx7LDGiS
	p5dljqGQyAhmDvP/wgRfDswzaBn8q/2OsjtHM8MpN39MLURnjK5NFsM3S5KhX+tN+jMU45pJh5U
	i2/R1R/FkpJnlEeVCy3YcLh6DSthvumXbCCjy8nEdi2BN5X3CkCwAcc2xqPzkPv7tS4jFH0AHbO
	d2YhEB+lxjBNFPAVaLcgsk8vnbL8zWCQQ5dPlv7QWYATKKiOqpvzj6CBX3ZS0KutGrSajZBVv9A
	u3Hc+PmRUyp6p95/lxQO0IZFFCUDQxrvbt+hf/KUxIdXjLV0oGdP42qHoeM4S9R3EZGvavykIDb
	dt1YqxNVkOzs+YT7Oo2hJdYDOfgEZQjTiFwAeoLQ9xljFwDQhEKXO6bH7xWKpKOZ+GKQMBywsQI
	WdR1g9Zbk8flYGEwwba2JYbFLLhxXsg+BvlvdzvZu2lrKQ4bBy6Qg==
X-Received: by 2002:a05:600c:46cc:b0:493:bd2a:93be with SMTP id 5b1f17b1804b1-4995e085347mr52863935e9.6.1786108408434;
        Fri, 07 Aug 2026 06:13:28 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-87-19-255-168.retail.telecomitalia.it. [87.19.255.168])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4995c7b2b68sm58827665e9.4.2026.08.07.06.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 06:13:28 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	llvm@lists.linux.dev
Subject: [PATCH net-next v11 08/12] MAINTAINERS: add myself as PCS subsystem maintainer
Date: Fri,  7 Aug 2026 15:12:50 +0200
Message-ID: <20260807131301.192060-9-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260807131301.192060-1-ansuelsmth@gmail.com>
References: <20260807131301.192060-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

List all the files of the Ethernet PCS subsystem and add myself as
maintainer.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 08e43bc09735..e3ded0e4a115 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9688,6 +9688,15 @@ F:	include/uapi/linux/if_bridge.h
 F:	include/linux/netfilter_bridge/
 F:	net/bridge/
 
+ETHERNET PCS SUBSYSTEM
+M:	Christian Marangi <ansuelsmth@gmail.com>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	Documentation/networking/pcs.rst
+F:	drivers/net/pcs/pcs.c
+F:	include/linux/pcs/pcs-provider.h
+F:	include/linux/pcs/pcs.h
+
 ETHERNET PHY LIBRARY
 M:	Andrew Lunn <andrew@lunn.ch>
 M:	Heiner Kallweit <hkallweit1@gmail.com>
-- 
2.53.0

