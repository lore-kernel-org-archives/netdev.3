Received: from mail-pj2-f38.google.com (mail-pj2-f38.google.com [74.125.227.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B149228030E
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 07:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790754830; cv=none; b=q3AhPgJezwBSLZUkANe7HqZtaIkPBRnFESm/THzdd1QGdBuSb/LscyzxOLhMt0EyCoIqUU2Gcqv4qU6HbAeet3XlSogRMc2RxAqYYRFSu/AYZPQZHFbELfuJZ2Ca7mdw+kZBgU71ta6ArtiGcDjLH9Ezl5DWEnHZoeyuiwezKlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790754830; c=relaxed/simple;
	bh=hZ6EIw11xdTVgEdmGqQqYocVGyhW/vrmNhyxQ7jmjYs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IYwAZtDRposhU7hYTRGpUI260HuDaeClhgzNfRprUyem1w5Kh5HtMvZ9pLvHpIAf1p8aaLlvPEb8ra968+XgyK8Xo4gtnrwngbIn4i8YrD72cnvoU1nTJyXVPUEq56GaR9pX8lPATtnoHk4TZENzVLrZdHar/E5uI6QdGXfHX1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H1yiXM1x; arc=none smtp.client-ip=74.125.227.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1yiXM1x"
Received: by mail-pj2-f38.google.com with SMTP id 98e67ed59e1d1-3a4bb1ed012so650992a91.3
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 00:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790754828; x=1791359628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zfRoB0z9C62Zxfiw8Wn8D6Gbz3xcK/CP85S70GJlIsQ=;
        b=H1yiXM1xntsX8sc+JkxqWsMV1txAJ+Yw8Qvqgd5WFze3FXMNiH4ml5ajqmz/TvPjVq
         2XiQMIPNdsr3FDISXPFebtWQ052hN4X3CL9zVeiw0i5L/ZPlp7Q81NN81uqDA7/ypYPC
         RcCNfh1q579sEVNCmiJ5ndwK3bT+lWyhdhV+xcGDtnZC4UMH3bEuhF09UX6kVAmsc9TC
         shAgYhqKdGOvbZwCBVUxaXWeWW7XPyPJ3K8JFBK2RDWVe/bljIyjusXsdXHCJLGPHoGL
         dTlFMXB9QUE4f2LzGMJaK3W+Y9jw9pj2eruFHbOggWIqEXzG2YtEotaa63wi46HhBvdR
         j15A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790754828; x=1791359628;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zfRoB0z9C62Zxfiw8Wn8D6Gbz3xcK/CP85S70GJlIsQ=;
        b=YNjRUg5G/JsZ2OS/T3t7H/Opy8MIXPwzU9whs3X0AQDUPvSpDQ/MTmJDST/O0ZlZgd
         xP/zwbhL9g0thwKqWyOLrgmQ8VbcqQ8WyVfg0WMvav+NnE7MdJPtXhJLOUr8mS7nj6BM
         bRY/79K2H1toZILNuK7+vwxGxTaMo0oAtAnkMKq6cxmn/u0p07+6te1EXNpiUCL2xdiZ
         pSJbV++ZQOs1BLwa6UYVFmYqQPyMv5k+MUMe2q5mugzFZngpA/RFmOM+tl1GT9u6Efzx
         apntNbyiJsDjAnAcwgENunVdhhaInEeZ/pt6VxKgwoMIAJMe8ldzYQHfJJCzY+a1MmcW
         Tkjw==
X-Forwarded-Encrypted: i=1; AKwUvBxYVWF+00DmcsravOJcYYwMOdHfWqjwBYkNg3CEnSzTDkQHdCkWUJJ1nvGNE2Zq+U9/TqmGy+Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYLYMrIoqRdtij3K4aYOYl1opFRtOFlu2hgwCAObcgrhyw4s3p1h
	kbabZsIN/oZNI3TNvvyv21oKYOx1KFvcZpaxK03ulDqZGGlOpAl54ec4
X-Gm-Gg: AYBFou39DRZCUDZlmEGAsCOs+tvEuKC4ZA2IAhihI1BEzBT8KkQvtMCEnICW/bNwg8p
	dkJsgZFxAPYomA7dd+1jcdBUZotQjan7Jp1BEZ8OmH0Z34ZknV56w9kXVKFDKvCu/WYqimppW+y
	zK/Ic6LI2yzx9vMyNR8F3o+ICL2qVgjR2TfOZrUEdWIafm14sExHHOjygOHQ2atlEsgC/CgysGn
	xbIVfKZljY8CZebrgtv1dXpKQeLg1yln7aM6sSM7e7zuiXU7Iyi8R4OyB1jVi/5iV6SCVDLBj9i
	IZfLTrE2ncF52M2v3IG3geYQHqiipV6Zb/A9bVSt1JsX8SDEGG0yh2Ib9FEUQqu1vICjenH6UCN
	D5Uv146dPNehBz+lI8connwtFQv/ZDj72o1Vf5pXa+Re78BznRBvDdS3c0KoRrQkpGUih+6Xxzq
	Y4hrA8bxSUki6lss4vh07W8Oy7/xbZBkyOfVJakCiwPvqGh2/hCRt++XeKr0IxGrSaRmIMVHsGk
	SOKQQrzf9VY
X-Received: by 2002:a17:90b:588e:b0:39e:6c69:9b90 with SMTP id 98e67ed59e1d1-3a4d19109demr619978a91.53.1790754827923;
        Wed, 30 Sep 2026 00:53:47 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4ce419342sm1882128a91.16.2026.09.30.00.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 00:53:47 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	William Tu <u9012063@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daehyeon Ko <4ncienth@gmail.com>
Subject: [PATCH net] ip6_gre: validate ERSPAN skb dst before PMTU update
Date: Wed, 30 Sep 2026 16:53:20 +0900
Message-ID: <20260930075320.760328-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A tc tunnel_key action can attach a METADATA_IP_TUNNEL dst to an skb,
and mirred preserves it when redirecting the skb to a native ip6erspan
device. ip6erspan_tunnel_xmit() treats any non-NULL dst as a route for
PMTU updates. A metadata dst has no output device, so
dst_dev(dst)->mtu dereferences NULL.

On v7.2 with KASAN, an initial UID/GID 65534 process with CapEff 0
created user and network namespaces, used namespace-local CAP_NET_ADMIN,
and triggered:

  KASAN: null-ptr-deref
  RIP: 0010:ip6erspan_tunnel_xmit+0x10fc/0x2cc0
  Kernel panic - not syncing: Fatal exception in interrupt

The collect-metadata path already skips this block because its metadata
describes the outer tunnel. Native mode must still propagate PMTU updates
for real route destinations. Use skb_valid_dst(), matching IPv4 tunnel
PMTU handling, to exclude DST_METADATA without suppressing valid routes.

With this change, the same trigger processed three packets without a
sanitizer report, oops, or panic.

Fixes: 5a963eb61b7c ("ip6_gre: Add ERSPAN native tunnel support")
Cc: stable@vger.kernel.org
Assisted-by: Codex:GPT-5
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
Affected since v4.16-rc1; present in v7.2 and all four pinned
2026-09-30 upstream snapshots.

Tested with CONFIG_USER_NS=y, CONFIG_NET_NS=y, CONFIG_IPV6_GRE=y,
CONFIG_NET_CLS_ACT=y, CONFIG_NET_ACT_TUNNEL_KEY=y, and
CONFIG_NET_ACT_MIRRED=y. Config SHA-256:
f992c9fdb881ca95c467896791c52554719f6204cf06268cd92ac37c14c14f83

The reproducer is available privately on request and is omitted from this
public AI-assisted report.
---
 net/ipv6/ip6_gre.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index e61cb10b50dc..3ee7fad6089a 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -1059,7 +1059,7 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
 			 htonl(atomic_fetch_inc(&t->o_seqno)));
 
 	/* TooBig packet may have updated dst->dev's mtu */
-	if (!t->parms.collect_md && dst) {
+	if (!t->parms.collect_md && skb_valid_dst(skb)) {
 		mtu = READ_ONCE(dst_dev(dst)->mtu);
 		if (dst_mtu(dst) > mtu)
 			dst->ops->update_pmtu(dst, NULL, skb, mtu, false);

base-commit: 54518e0e827f4ca9229ae657022c60bf60f5c1bf
-- 
2.55.0

