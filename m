Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319BF426687
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 07:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788767943; cv=none; b=PWuvNI87pLK8LU8NXV4nxSxaWO5KFx4wDO21nl73CTQgkBQXE3O09wIY47c8Sgkfo6LvWbVBcUnfkDucKYEqiwx6PHsPNn+e2v1wggLjqcxNPkfcvDn+ex/z9EI1s00N6BlyF9pg0Qq5M5lLuSPWi9AGsx3u4ysIYC7X0R9woNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788767943; c=relaxed/simple;
	bh=Ezy7EYrBvMWt3KwQ3pRbTqQ51vHv72QcOmpPxiULaMI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uPgYnGcnMrIYDOObpET5qYPQ9hfT3kHcmrlbKWqZH1y1RDCafFOaPtzs1ZDIKvd8vfsqnV5dg6kZFO05gy2zv8c3FU4bP3LcI34kl49n8Bwy6a9PAadLw0UNA18csw4K/Vg3zYRmjdMb7vLtMIvW+4MV4Fha9GNefa+3JtrH9Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lqj63qef; arc=none smtp.client-ip=209.85.219.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lqj63qef"
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-90e7de22fddso75479426d6.3
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 00:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788767937; x=1789372737; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pAjYrcKO95VL+zK/l6WQkrkSGe9D6YFY3dYSU+ALQ6U=;
        b=lqj63qefpLFi+UuF0pvhCqLeGVg/juf6taLeHM1sjv7KPB3oncaPZ1Bw0GEMNHpFdO
         OAIHhxkEpuNlgLux4Xet6+DovVnpk2YXnbPmxcCi3INYL66HliWBcplpaPGoY9QtXXX/
         Ed6q0PKPkhzNyr0crOLmYc0iw1P+TSSEiWyR3Fwo8k94RgA0Khe7oYUtayI58BK4tRxo
         5HwWoRJjFmzHcyVckfEP6O5Oa4nRcKbtQ4YCW5BWr8C52u0CMl+zp+jpgiit9bcB4cwe
         61GQUB135wal/pxt+MRkSLuLz2hWOUdc9eJmhFbt/XODASBHF/DuCltIHBzi4zuZjLMJ
         s4rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788767937; x=1789372737;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pAjYrcKO95VL+zK/l6WQkrkSGe9D6YFY3dYSU+ALQ6U=;
        b=e54dP2azGDe8GWibcupq6OTLuNbc/7KNNnrg3IvrPmdpTZMylFijXyJvJT7lS6GhcO
         rOQnwlYBL/RBZCUYPZlWcABWHt+YLdjQZlm4yK6FgOjoPhWA8A4iSOrW9cff/xPCq+b+
         woyQuR+ilf1mL7dmHY1YJlJKCp38Uvb0DmzKhDWhpgpr6t0unp84oYTmP99Pge+DgznH
         HrHHpJNSNeURBa/U0L1yzfGl4snRUse760UcDpLso6hsFuO3Q0t5YexKzbab/0yBVGqs
         BnY6lwaclx9zOm/hLCvVT4YaBmo1Ax+V3RWCeAZ/4dn1I/3T9/x3u/NnazpL0gssSUYn
         cmEg==
X-Forwarded-Encrypted: i=1; AKwUvByfwgEQbjKy822OmCJy7lw695uPdU3p2+an6fj6atz0ljtmCgYiiJhdqMgiJeG8begyQmkwtaU=@vger.kernel.org
X-Gm-Message-State: AFuF++lJWyQEgYuhP7QZwDunFa5cfGFSpPu+5HdJZNz/62C8eskkxwQm
	mOc6TsgN7fNZwDYWojnVx5qaIGvSpc5jFA/zCLORKuez8cBtYiTakPGKf309GfbNwUnsuj2+/Fa
	D2YLJJTs3ZfKtyA==
X-Received: from qtbkl8.prod.google.com ([2002:a05:622a:2c48:b0:51c:d6a:2c19])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:261a:b0:530:7bd0:72a7 with SMTP id d75a77b69052e-5307bd074e3mr90585911cf.14.1788767936321;
 Mon, 07 Sep 2026 00:58:56 -0700 (PDT)
Date: Mon,  7 Sep 2026 07:58:43 +0000
In-Reply-To: <20260907075846.2913645-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260907075846.2913645-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260907075846.2913645-7-edumazet@google.com>
Subject: [PATCH net-next 6/9] sit: implement ipip6_get_iflink()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Ido Schimmel <idosch@nvidia.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>, Artem Lytkin <iprintercanon@gmail.com>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

SIT currently uses ip_tunnel_get_iflink() which reads tunnel->parms.link.
In order to decouple SIT parameter handling from ip_tunnel, implement
its own ndo_get_iflink callback.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/sit.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index 7cabcd3afbc4f06d9a08374e6d8df2fb1bfb9676..35c6695909014a2c335f1de7afb48f07b7c91c39 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -1444,12 +1444,19 @@ ipip6_tunnel_siocdevprivate(struct net_device *dev, struct ifreq *ifr,
 	}
 }
 
+static int ipip6_get_iflink(const struct net_device *dev)
+{
+	struct ip_tunnel *tunnel = netdev_priv(dev);
+
+	return READ_ONCE(tunnel->parms.link);
+}
+
 static const struct net_device_ops ipip6_netdev_ops = {
 	.ndo_init	= ipip6_tunnel_init,
 	.ndo_uninit	= ipip6_tunnel_uninit,
 	.ndo_start_xmit	= sit_tunnel_xmit,
 	.ndo_siocdevprivate = ipip6_tunnel_siocdevprivate,
-	.ndo_get_iflink = ip_tunnel_get_iflink,
+	.ndo_get_iflink = ipip6_get_iflink,
 	.ndo_tunnel_ctl = ipip6_tunnel_ctl,
 };
 
-- 
2.55.0.979.g7e5102b832-goog

