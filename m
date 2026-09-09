Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C6257ED91
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 14:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788965150; cv=none; b=jJA2J+oESoETepCGkSjvo93Dquym2ugwh3EDuKRd976/CIBmKRjPjDtDgzUm43fliOAYHum3A5jGnOVbD+cvZJQXmu8XciGcIj0vKC5weoAF7HBnqaR5p9Mdp30hPe4AOKiKVHuzqnvgt9Ibea6gVgRil4pT/RtH2E2UoJQHp8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788965150; c=relaxed/simple;
	bh=ar939v3pkHgI4JJMLM+XStXO1mHQfkHWihVNAlmeyps=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tL3+pqsqqibo1OTuvTiC23RnZyJUTcAlNoPgWVHVbj9xEfKXYK4q8wdzsQVzWgItH2wwHdI46pAGKEksheQu5yAJ5b31hDYY/8iHamaU3ylSgekgcGCNPOr/Yk7jbCZc6KjHAhxcnmsIpGzJBs961OSFrJoR4K0nT0oE331isVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xoe/OOjY; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xoe/OOjY"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2db18e5cb56so58501965ad.0
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 07:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788965149; x=1789569949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/RklGmEbqHa6YvYjJyOq7oC+x0k3l6NwuMATE295K/Y=;
        b=Xoe/OOjY4FdkjHF2GtwFoGX3uvno+QQQUx9HopqsigOt/4qpUqqrlzOtVy306AC7Al
         hatmp7k6s9TCEIcOuLvXwA7VZAdiDJLiRO2mtecIFHaYRSaMpykzigkSEsx4cerpDR9n
         NjV5LnZUrDBolL8QLOJGcADndimLHFuj2kdwV6cD0x7w/+f8Vl6Zi61UyGlLkhk8sD3c
         VJvjwGDeMri3kzD6Zd4YGgBGXAcWP18epddB3whO+JgrQLQEIE5TENE/aLf4qN6nlrjR
         WqEzK6rTgQNPNYU9UCLA8WDK+GSX5iD26eARkeXZq+6PmlC/hLOzjasNE1ylgrIdL/Ef
         G2RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788965149; x=1789569949;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/RklGmEbqHa6YvYjJyOq7oC+x0k3l6NwuMATE295K/Y=;
        b=k+6SvjXK2uNX8P9bG1JKfWCuKoXGbW7/eLEyECX3pu6lMeDsb4pOl7NNxm0WbefEyx
         Ror3Eq8f4+gWYufwyop8W2K1pT5GfZl1l+Nce2MxP0Z2+qJ7H1pfg6xkEvlHKSLCKXoF
         QtqPZwk0cW3oU/oxr62VSItwLQ5dbY2EeRHq48AUFMbbaQgc86Fg90eYESZ/+rU5AnWR
         amiWewv6l6CbQcOq1hbvDFn4P7Lj0IqMUo3nHN1B+YaJHg5Oe1dAxC66MiQhoI066ixz
         pzvV+wCtZwI6fjaO5/tI+yIWhqR2fdCWVcBjM3tzx8eqlmsPfmQhR+GSWjgVxSkfxOj/
         NRCw==
X-Forwarded-Encrypted: i=1; AKwUvBzll1RtLt5vnCtQL0dZctdxdawLZbX5J3wwhe1suwWt6Ns6FcUnbnPPDvuY/Uj0NGcwlvIwEqc=@vger.kernel.org
X-Gm-Message-State: AFuF++khBT7NwD80YEuhmW4DuUfWiWKM3cHLz+bHpQwvurRAqsWuwuvL
	gMXzptr9COO6FcuiE0V8Jvj7hRcjib1xe+49QZajUqfkfub8XMXKvjic
X-Gm-Gg: AYBFou3tCcDVQFaEarZzieeNee92sJTdHahQ3I4c7kDfxFnSSxJhil70ON4ZLKInNmz
	mAEokqT04iHGeW6SQKY/B5miwxsbXbLGYXeQMJWY/NWV6E6NOPvkXREwOmLUvtaHTyCv3JbsHFw
	WNS4apDJR4+apaxgOphl6isz6zlcn4kwa737tHjCTaBp6ZdQbHFdaieju+MomwIsYtEXmUePSrD
	pleuvMxT3QyJ3g+SrJQw5Qb7NzwczOSwGVqpiWNAeeYFV7icahE5rIz34oQajL2pydOCbLu4jJQ
	LxekeDf2md8klRVuENz9uiaich9LC/Pc/Z+CYeldWeaZfY2r/yc5YGmmd6JVQ/6537xmHw1LjUS
	J+OhxIzGQGDVrq5JBus1NEnJjQ7aJ+cC9VA7RrAid3JarBZsWbB7AtxFeDmJ7lE1cuDeDn5mpcl
	fK5w/oDKroT6oHELd5r1e02A+NGdzou+baDheOIXEe+iH3XtgeWfEQenAZg2Uu68WI6ElvJmC4i
	xg=
X-Received: by 2002:a17:90b:3912:b0:398:c724:1bb1 with SMTP id 98e67ed59e1d1-39b26101524mr47828712a91.8.1788965148448;
        Wed, 09 Sep 2026 07:45:48 -0700 (PDT)
Received: from G15-5520 ([103.206.144.104])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b608409sm51209787eec.21.2026.09.09.07.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 07:45:48 -0700 (PDT)
From: Lalit Shankar Chowdhury <lalitshankarch@gmail.com>
To: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org (open list:NETWORKING [IPv4/IPv6]),
	linux-kernel@vger.kernel.org (open list)
Cc: Lalit Shankar Chowdhury <lalitshankarch@gmail.com>
Subject: [PATCH] net: ipconfig: use ifreq field aliases
Date: Wed,  9 Sep 2026 14:44:16 +0000
Message-ID: <20260909144417.28871-1-lalitshankarch@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the ifr_addr and ifr_name macros instead of the lengthier versions.

Signed-off-by: Lalit Shankar Chowdhury <lalitshankarch@gmail.com>
---
 net/ipv4/ipconfig.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/ipconfig.c b/net/ipv4/ipconfig.c
index 155db067eaec..475393a86c91 100644
--- a/net/ipv4/ipconfig.c
+++ b/net/ipv4/ipconfig.c
@@ -367,11 +367,11 @@ set_sockaddr(struct sockaddr_in *sin, __be32 addr, __be16 port)
 static int __init ic_setup_if(void)
 {
 	struct ifreq ir;
-	struct sockaddr_in *sin = (void *) &ir.ifr_ifru.ifru_addr;
+	struct sockaddr_in *sin = (void *) &ir.ifr_addr;
 	int err;
 
 	memset(&ir, 0, sizeof(ir));
-	strcpy(ir.ifr_ifrn.ifrn_name, ic_dev->dev->name);
+	strcpy(ir.ifr_name, ic_dev->dev->name);
 	set_sockaddr(sin, ic_myaddr, 0);
 	if ((err = devinet_ioctl(&init_net, SIOCSIFADDR, &ir)) < 0) {
 		pr_err("IP-Config: Unable to set interface address (%d)\n",
-- 
2.53.0

