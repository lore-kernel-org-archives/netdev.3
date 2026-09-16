Received: from mail-wr2-f39.google.com (mail-wr2-f39.google.com [74.125.225.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88825513551
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 23:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789602761; cv=none; b=R4NwDmVLAhCwU1qKfhAIZfgKwSoi2Ym7PWz+xs7/Lhwga7AK509JzMLBqsP6a0DGbdketEfhc0j+Xfrfr5tN4QiBTu2jhmBfN7YBYa8hsj7dIf6x7UBUouyCUjldd+WLcQqTq0ziVUyOueYtEBmcsgrdaqJNTNx2ME9CQ3todh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789602761; c=relaxed/simple;
	bh=cXFXLP+NjYWZtJpQfz+KEsHtZfam6Old8yzjXsddKto=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T8bONWEmezUhrnTuFgs6quehIjqE/r99aJVFBs9amQoix1JqwJdSuMkPCja3xZyThxBSDaKjtN33BLnLtMFaHIgkglioZd5OKQwdcpHm/J7HoQn2nFuy7RPO1/8VNuB7ALZi5ndFMeTLjVuXWIJec7n+x7U2CXpu5JJGeUkPilU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z7VeK/o0; arc=none smtp.client-ip=74.125.225.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7VeK/o0"
Received: by mail-wr2-f39.google.com with SMTP id ffacd0b85a97d-482f633ece3so170224f8f.3
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 16:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789602755; x=1790207555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tmAu67PdIVI7V1UutpEDvX/bujznCInbK+OAzRMwn/o=;
        b=Z7VeK/o0Hki/LXVrrrkPm/toPwU7WsGonTfv71e2ZZEVViHfelDod8elIyMqGb1i6U
         Jc1ohu8eXp7kqtxUVnfBQCk+ezruz2pUNSnmlxEJOFb4nHjeBmRb4c4Qp22H1Lg2Io2M
         nSePr300R9xCT2UkvCKEf9QXidhYYMrQmgCMB9wUg4Qm3OAL6Y5W1krCb0g0A+3djSvw
         IXD3/tOpxrVx6MZWt0pknH1vFRiCzpNK5KQIosnFuph1i8YUJQAMPx1BKVJLXEW4Y9gT
         vWxnWflnLlZE/bShebjbC91EyVYUHSfccBkPUCl80FfvzoeuJL5UCtb7Yx5fjYyo7kjS
         Sk4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789602755; x=1790207555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=tmAu67PdIVI7V1UutpEDvX/bujznCInbK+OAzRMwn/o=;
        b=1+1j/b6Tqw8eruMHGW0EIieNDiH7hK3G5EXVjEnCiQ0b/tHVTJoTB7ZPJSnHi3Nuo+
         zdH8lprKhciccWn8CadXtnxZd6jXO4kBoLREkU4nmvj+ymT6GTpsz4AWW9jdE93Cuur5
         ssgR+AcSEFJ+hjUa8MH1YU12SVjNOXdXs4XlZTJmz66xthsNtkDdFzvYUZ25BuWOK5Kz
         Ihm21t1O5xl4dq6snBQHF26Om8NPGytiLqA7KZdiPPc+GXHzN7rh3Uu8pzb/ZQrJPtrQ
         c0kwUUy208cZp5mxfYgZPppU083yKNliYg2La7innfdoEqcK1s22vQdeziyf/12pp3UX
         6MJw==
X-Forwarded-Encrypted: i=1; AKwUvBxK6YhUWQ0/4YpHphspU90BXDXGoHKfSHrjj0zuy48xigbeEhUwbfNm445rUK75emolKUvMw/k=@vger.kernel.org
X-Gm-Message-State: AFuF++mYkAZEwLVXnLXg0XlKC1ZVqv3mvzlWHso45/pcGLlw5qsnwR8u
	zGV4PgmNQo/vtGAxC5zds9xla/+RKHHGk/2JSxW8XNTEuUolDRTww5kY
X-Gm-Gg: AYBFou0x//4bMhQrNvyTSstp45YPXPEW4aIIg1p8di4qCDDc1VkX602Z5D/n1SrFBR3
	I99L5zKu5KRqr/meTNTB5xettTDIq2ioyHNzX2OM/IIaS1NiZ1eFBvGic+oK+FU9jzuW7QpJGfh
	TGHOVhdSziqUagsCbP48apAGPf7WinlTWPWttsL0OSCcZJDwbyLfIaE9CHlMY6ynqyeHkvlU1i+
	iIinjwGQ2uZU4/FQVJuBBjAXt/KfUd0DfekxXX3slxRkt46JT9hWLRF4udFgJHn8e12H65svCLu
	rAhY/GyE7pZdGMBvxanSDhLqV049amIT7NJ1bwgBN4QIJv4D+Kij5pB/CopbJKt+MytfaPVX8d1
	WP/M0bhUgWHNRaTj2/SpmE6BIYHwTAo+uT00YaXEoUuOufHsmNHT3EGsNce8FTI25nEUTre3Fne
	hEIrtXzyuHz9TLIw/lC6XYD2YZ9zN56znwhQOm5e6AKVEN4tuHsPFr0wbw81KU5Q8jK2G9Mv0G0
	/MC1Pg1SAXFd2ma5WPsz+cDl53l1g+Exwq2EF0zESi6iFIYHddCrAQK8k9ZGOw=
X-Received: by 2002:a05:6000:2304:b0:487:b32:9d6f with SMTP id ffacd0b85a97d-4870cf25729mr5407208f8f.22.1789602754931;
        Wed, 16 Sep 2026 16:52:34 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-79-26-252-140.retail.telecomitalia.it. [79.26.252.140])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4870bef7687sm11861104f8f.1.2026.09.16.16.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 16:52:33 -0700 (PDT)
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
	Randy Dunlap <rdunlap@infradead.org>,
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
Subject: [PATCH net-next v16 08/12] MAINTAINERS: add myself as PCS subsystem maintainer
Date: Thu, 17 Sep 2026 01:51:34 +0200
Message-ID: <20260916235200.20712-9-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916235200.20712-1-ansuelsmth@gmail.com>
References: <20260916235200.20712-1-ansuelsmth@gmail.com>
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
index 0e04d92d1b09..35e20ddd018b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9755,6 +9755,15 @@ F:	include/uapi/linux/if_bridge.h
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
2.55.0

