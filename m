Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDD1EED8
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 02:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773887179; cv=none; b=tTlUZO/AbmfMEULkmcM3rmiHTYEP47hAoR/nofCbSPqa7leYN+miP4raBYub/peCk8bPaOkC7O5fufMQV4XgGgGgSd8bcRPOyAs/5kS3xYgU/HqXEWk1MBcOiogaUTpA7nIPOjfyuYEX6e9x+8mvefQISdjsrXauWgTb0InRy7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773887179; c=relaxed/simple;
	bh=O3gUjVY0zXNWkfevYHmngjVR2gpGM7yW2onuOOt+JEs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iqL/whePATurhabmSyT/ZGKxkbtW9FbLCkO/PnenIY5tpnfqaOyssX1xIb+Gc5xXIdfmVc1l6SRgH8ue3SBj8R6ANfo/wpI8mgjBiSukC8PAk18e2X7HM1cUtFJ2SFeVliTjFBPJ92DYzPJvfSfulNT/Oh0P9xZ8g9ZBoPCBFG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AiPrNuUh; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AiPrNuUh"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6611d20c026so755215a12.1
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 19:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773887177; x=1774491977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PLrWY93KLXjnMjbgd/SU8nHKn9Fei7qaT2S2SKHl6Cs=;
        b=AiPrNuUh/3RRhS3MusYCVHaghObvsE9kKThd0mwJw7bC3uEi/nw6tw0njXmnBkLewF
         6sktHsVCdqQVuECziazgJ2kCIGSv8cmrTJay4y7IlUPcw4iojeXv2u1EPTJUUzyM+M00
         IwW82SXtAReRvP/y/1V/qYpJ0j/Ne2ZQL25opFSoeNyEylZRB1KyGLv5XWArt3tN+OTD
         Db/ZLYc6QibG35Ct4ACSS9z+xwNqepDpMZYVaTSYOzOipC4qTmSSksA5aHxvLEvwJIxg
         mymjrERr2v/iJTPtRKflBwBvu3U2rHMRm4b7i4DaI2nA6ENREzX5TGZvxzIdQXw5y5Qz
         ApIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773887177; x=1774491977;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PLrWY93KLXjnMjbgd/SU8nHKn9Fei7qaT2S2SKHl6Cs=;
        b=BLqW+10bI2mXXio6wtRpYEEeMiv7VJHbB2GdRxq8lOIsD4rIA/NW2agfpXaIuzez4A
         8blxAJ/pzYuQiDllJdfEaYaZ+HRvAtSU7wnU6gXkVNGGVcy42yFOTP8RBpqdef0vPFf7
         bllsG1pqy16YO3V3KrkyvL1rva1i6rp5iYiV+s1MtM80CuQuDCOUcB/7K95hhzXMvpyj
         P0IXJqtG7h1YLTwsZF9j1Vvd+k1fweUy/SuCeDSbJCVcFEzoniNIl3U3ZoADpqdbGWq+
         HA4jxl8oX5gZQ6OqagqtPhq390i94R7MpKU+chvJGRWdtSW2pwZQz+13L4PuafbmcGkA
         3ubA==
X-Forwarded-Encrypted: i=1; AJvYcCVA3UWZCu4bEjEyFV8GBTee89wl+1d19XYUFv8ueW7QIEiOKHnz1EQ11g/h5dfcon664tZt3rM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqRmW9Lrrq+117JdB6zg0LuG9QIdmgFu5OUwjPrkchx3v8LCoE
	yVfYRibR/TgQ27DcwMl4ywD3uwWF9d0dmWescBxofoZdw4pTCZEKA2EV
X-Gm-Gg: ATEYQzwZXqnWxq7HsicUe1DLnHGQQchvobHA7E0YHOCzwfIJamPnZy4zkCMmviU9KI6
	p5Slc+Sz+f18rurPZJVBX62HxagHxAB2Z0/kpPw7/9gJve7+srTvWDgAorHZZ2ILnlSpteu9R5h
	Adz47H28gX1HAmfj7WpPmameVQTe+EnKL+v4S7e/cZXK2xD+vP/CfGVxLR3ZX7zsqwP/Jz3mKfB
	A7zlQolt+rsXWhaIo0qoLH/3xpQRW6BgdkREJi0PxYr8Opx902NrS2+TfMaq1tYUHaVcv5NvQHR
	zVosOP36VTF7znz3jsHtHOAHzjNE1dC4OOjB7j9rgUDrZJZQpu3+QrAFZeg4irze0GjLyCOHAV5
	k3O/96Zm6Z8OZ8tWeK1JefzoU1DY2uJgVdUamre0kQJdpntYHJs77rUxXLMiXC4TjysvD1WTfL+
	ySU8/rsl32/7EAlQ==
X-Received: by 2002:a17:907:9346:b0:b97:93be:3c6a with SMTP id a640c23a62f3a-b97f4a3dc76mr349115666b.36.1773887176479;
        Wed, 18 Mar 2026 19:26:16 -0700 (PDT)
Received: from gmail.com ([2a09:bac5:4e24:2e3c::49b:49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b97f1681603sm354890066b.41.2026.03.18.19.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 19:26:16 -0700 (PDT)
From: Qingfang Deng <dqfext@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Breno Leitao <leitao@debian.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Kees Cook <kees@kernel.org>
Subject: [PATCH net-next] net: add netdev_from_priv() helper
Date: Thu, 19 Mar 2026 10:26:08 +0800
Message-ID: <20260319022608.323969-1-dqfext@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a helper to get netdev from private data pointer, so drivers won't
have to store redundant netdev in priv.

Signed-off-by: Qingfang Deng <dqfext@gmail.com>
---
 include/linux/netdevice.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index ae269a2e7f4d..dba96736202a 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2764,6 +2764,17 @@ static inline void *netdev_priv(const struct net_device *dev)
 	return (void *)dev->priv;
 }
 
+/**
+ *	netdev_from_priv - get network device from priv
+ *	@priv: network device private data
+ *
+ * Get network device from private data pointer
+ */
+static inline struct net_device *netdev_from_priv(const void *priv)
+{
+	return container_of(priv, struct net_device, priv);
+}
+
 /* Set the sysfs physical device reference for the network logical device
  * if set prior to registration will cause a symlink during initialization.
  */
-- 
2.43.0

