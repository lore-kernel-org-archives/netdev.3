Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FAB48425A
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 21:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788988059; cv=none; b=YF1cAydfng+hH7f94pVHFo+R1N1gxFwzAzCgOGx50H2Ha7IQ6nDg3XX5Gn21Is30xFKC2z/y9ixv7862ZI8hgNijQdiruM5Ylu0dw7246vH3xUrKlpOfaDPHVdE48aM1Bfbtf1cqxd6IQWLz7dSoZgcMvp8kF8E1iIwqOnWtYdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788988059; c=relaxed/simple;
	bh=HUyf1jNW5C6VMkF4GEdLDA5cUo4KPy1rxF/rBUbkDCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mgh8mkKDBYfm3WWwld+bHigtdMMRf/cnxI9GIZgUrnSyz9IxKyibTBxa2cLQ4ODAWXJ9XbFFy3SHDmOFe9VaQavOB9wmB5HrYMgeP1bwTPBcTSrRqeu4OJf2Yy+5P9RzOQhLjFqQnZFw1CX+2mTVFtMPLRsSTAIkld3S3xxSGnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sgVEZO9d; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sgVEZO9d"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2d6fe26ef1cso67006015ad.2
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 14:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788988057; x=1789592857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vbtB6JrjYpZN4dYkBaoy7eX+pbOdiI7LyNX1EdfEPGE=;
        b=sgVEZO9dWBkVe7nOo4aRfq183gwJGIDcsfoC/+ZKDJMaQbZF419O95VoG0g0C9ml7p
         UKGKunCuwMSVPWr8/TqYGPalB5uGtu1iP+r0kvIfLonc7jxoCNTrlwPQ22Gw+GOSX4+E
         RcjjvyY9PojQZbgHDrPB5ZGAuMUPxbVQ4SRwUOl1R4KL96S/k8FrUe5wFQtVFcVjdqeJ
         rbzK4z3YAvbOv42rDOHCq5t2ApbmQ2B+6mgy/JYRA1HxzXiDhQzZ7kA2gzVTmNa9BCqK
         4FrHMqavY2e3V0NpaxiodZf6d4Br7cZh5ffeWgIapZfQXPUtVcKn4Jt5SHzVOo0gULjM
         3dqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788988057; x=1789592857;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vbtB6JrjYpZN4dYkBaoy7eX+pbOdiI7LyNX1EdfEPGE=;
        b=suVMtJOIyopP0eDbix7L9fdFqoTxul1JxHj5fBYsD+hJ+BcXdhea3XG/YcrAsCU0M3
         ga5K7zYXkwSGQLVyVS6lpVNK2QyOS80KrI4F6dOAjrvBAj1xau+YPUaHfHBR+VBMrR6z
         MwTEZ+MUDjb5dUAvB8TTtsNDC5EC6Q9ePnKzWDc9GYlr/6yFKyedHHjp/FIrIrZFFgrg
         TGFFeFyrVTu+AhbCVIl+URmFbNT83pUOrPj8lt/ytd+rxB/7LL1Ucc5wDynBGJSkcDi7
         UdANRvmhnDusWIuVH/sAdpOtWhczCUy0Ymes9+iiWHrymfp1ferKSAvHdYO36Rnq3y7i
         gbZA==
X-Forwarded-Encrypted: i=1; AKwUvBy68y3E0WawIUPVWOA7TGAg/UeGiSUBvZWV4rswGr2irBmnNTDr20KIVR0ny+qpDeX4FXKt+JE=@vger.kernel.org
X-Gm-Message-State: AFuF++lHFwzkE/t/5327kycW7IAAZ52N0WJWbKPnNLksPzAi7rLOPCGt
	Cu4vaCPRyffGO36oei9J4inclUCUrG6cKCtmuLzreN6gV/5rqTclfIfZ
X-Gm-Gg: AYBFou1EIEOEhuQs6WJ1w6/MnMF4Ggfe7jfKm/Nt68SsZBbvu8fNqURZwMUA85c2a32
	JwXdMkLfteeAhVmo0OeQCWIgJDQQ7a3ktNHT0tBdd8xO7zS7XRCygcVdCtZpkMgKUja+SCz/OEg
	qKKZlcdCXbQeuZlTPlqBm6RcIlpXJ4zl3GWmOrqKExmCBoQQNRfET4bjz68nr3OJ6EppQNv+2nw
	gP7Qd3yBkT7jDellPRLEVTGOJ3K8xv+OtkXcbyiHYmsaY/Wf6pnd5sshuXDhOFSgSHEpFYWObjb
	I56vK1w7JwCDaxwEFy0WM2jh/l0Y9EBD5UlU932lQRr4ee6wi9Kdt7CSwHROIgEZCygUqHIN65r
	m0nk3TPzA9/D/Ka0s6TPIyBRAzBKPLSzEqZ1/LBEGjxSSurotB4KrstSbKVXGgRwAo+GBV1eZHy
	If/q90s6wbxRtt4A9pKJs45YLdBPI9l2/YSh32rgUNg1LPSHlcYCixNOpzKad2JcxPMpGU/IOC
X-Received: by 2002:a17:90b:5343:b0:398:e46e:ade3 with SMTP id 98e67ed59e1d1-39b2628fc1amr58979698a91.23.1788988057397;
        Wed, 09 Sep 2026 14:07:37 -0700 (PDT)
Received: from G15-5520 ([103.206.144.85])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1435c2ae6b5sm1258817c88.1.2026.09.09.14.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 14:07:37 -0700 (PDT)
From: Lalit Shankar Chowdhury <lalitshankarch@gmail.com>
To: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	netdev@vger.kernel.org (open list:NETWORKING [IPv4/IPv6]),
	linux-kernel@vger.kernel.org (open list)
Cc: Lalit Shankar Chowdhury <lalitshankarch@gmail.com>
Subject: [PATCH] ipv6: replace sprintf() with no format specifiers with strscpy()
Date: Wed,  9 Sep 2026 21:05:52 +0000
Message-ID: <20260909210552.51828-1-lalitshankarch@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Multiple instances of sprintf() have no format specifiers. Replace
them with strscpy().

Signed-off-by: Lalit Shankar Chowdhury <lalitshankarch@gmail.com>
---
 net/ipv6/ip6_tunnel.c | 2 +-
 net/ipv6/ip6_vti.c    | 2 +-
 net/ipv6/ip6mr.c      | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index d5ff50a2ac01..ef3a6d931c9e 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -294,7 +294,7 @@ static struct ip6_tnl *ip6_tnl_create(struct net *net, struct __ip6_tnl_parm *p)
 			goto failed;
 		strscpy(name, p->name, IFNAMSIZ);
 	} else {
-		sprintf(name, "ip6tnl%%d");
+		strscpy(name, "ip6tnl%d", IFNAMSIZ);
 	}
 	err = -ENOMEM;
 	dev = alloc_netdev(sizeof(*t), name, NET_NAME_UNKNOWN,
diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index ab94b3a4ba9c..182a7949d830 100644
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -210,7 +210,7 @@ static struct ip6_tnl *vti6_tnl_create(struct net *net, struct __ip6_tnl_parm *p
 			goto failed;
 		strscpy(name, p->name, IFNAMSIZ);
 	} else {
-		sprintf(name, "ip6_vti%%d");
+		strscpy(name, "ip6_vti%d", IFNAMSIZ);
 	}
 
 	dev = alloc_netdev(sizeof(*t), name, NET_NAME_UNKNOWN, vti6_dev_setup);
diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 3f2ed9b77deb..20ac8cb87468 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -692,7 +692,7 @@ static struct net_device *ip6mr_reg_vif(struct net *net, struct mr_table *mrt)
 	char name[IFNAMSIZ];
 
 	if (mrt->id == RT6_TABLE_DFLT)
-		sprintf(name, "pim6reg");
+		strscpy(name, "pim6reg", IFNAMSIZ);
 	else
 		sprintf(name, "pim6reg%u", mrt->id);
 
-- 
2.53.0

