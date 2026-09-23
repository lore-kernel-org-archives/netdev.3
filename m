Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768D423AB9D
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 02:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790129807; cv=none; b=oHOiFb4h2N2voIdh7Bq0JXvyB403zZxai1+WVsTnAyxSVSEw27Nb9eJN1jLkJgPayg3lkDvoYkif8VZHa1NiutsIeQ6o8p8ZusMJEvMFtnY8wnXuOtoVXPYRPcIkl6q5PJqMq31N6WwxO8GVxUg4yRJ6w8LOIJeS6LviQ/mNCkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790129807; c=relaxed/simple;
	bh=IJaQy4P2yd4pyDkGK7B65H8YZOqfHcYmq4JiucGMmnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HGlYZ9dYqyHJDv7SgJY8bTqwo+QgbMCbSPzBsPUIgXnmwJmbenqr4oGxs3EL/saR2jIdqztws8YbBhq4ak6zZwzAewsq4TAIl62HfCbLkeJ/zE7GZj/mi1CkLayxvgkJSjpRGN72JA2PYBdd2AmTyOZE/dffwKTOcNFz+pA1OWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BjP+RMZX; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjP+RMZX"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d6ff2f2c4dso654295ad.0
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 19:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790129806; x=1790734606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dAh2KuGuRj18JxYhJBsvAeliSXyDq2aM3hEwgBQ4fC4=;
        b=BjP+RMZXDgDC3J1mGFhUi3jljc7kGHllnx68jmL3qb5CG8OiEtg8YhVJbd+RK6vahf
         6gN241+pdRvnxwr2gtPD1f27JRR6ia17fEVwRiidoDnogFVC39tGJHbCVfR9xa88G4iD
         Xqz3Q0DwX5rf7epfJPcS7I+ShsEVD2D8LdCIgcfvQ8tDZCv/YeqlW8uH/b05p7bxWCRQ
         jn66CMoRb9VOv5fzzEnrMcmuRwrGWn6NgbmSZQKthBOncT/Oy4DRH+PcQOCjB/VqHw/P
         mDg537DPJ7k2Kh0ORW1nh6q0n2p3ATRoEaCCdAN6ak8eTyH67w8BiQL2aXyE9XXenZhc
         mRKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790129806; x=1790734606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dAh2KuGuRj18JxYhJBsvAeliSXyDq2aM3hEwgBQ4fC4=;
        b=x+ms7G93epesULBpvGrn7xlBMtyKhJqlcuQJ8qLpCR+GLEqALzKZQidfRIDz+W4Yf7
         POv6KVOfqm/LR90l1XxTffgy/y5BWesWfRGCRIqoo8e0K3mBU+drWnpPRpAU5snZPSyu
         iQfCanacCvtnuZqmcPlzXTcFl4qh5vYEQtjEy1kpA6V6boK6s3UstcdGRH2u7aCtsbHA
         KHWw/uIny3uVFeJjDWZ2ioZgx++ohlErdaWFr5PkTpqjIg4g9//QawTXyhbf5Bwt3zKJ
         IQ2KitsU2WYSA0N4h3ElA4wD7HoshOcHls4bWNlSU4jzYw5jzgO1ALgtSA8NnjVBIfD5
         3nHw==
X-Gm-Message-State: AFuF++nTChwQlXnOEnJ7hpmtOqbNJTSyUKOsiJ2U1GNmUuqkykaV53wd
	a5t3lWomNcYKel/OAVuvOMOmurwi15r2Mc3Jc9/3wAkBRRthEtLGCvazCR+x6Q==
X-Gm-Gg: AYBFou1B1yZNV18RsJVQUzgRCaPB96pTGTXCHBj5dR5Ep/APluDWCaDTquEtkXqBf37
	WIvVnkmURTZN9JptsSTL5NHTDEQYalNFPt+M1vlFyrIoZsHuJPAM9yjetVZ8toO5kKhWZuqJN19
	IVG49DjlnGz0z99bIdNJw1lVFocZJvJbPa+2meITu5FVBpJ4ouWZ0gqJcZ+tmMqU3lu51tuTZ9J
	kT0zCa7VTQd2NZaEUYuq3oXWdJwB2LAGMjd4zyaDwaFE8J2o9bf3e2vq8IRJXRb+nnVnPnp0yH5
	AAXoH8NiyBMNp8UXUAKnbKkI9AzKrYn/CT94nyuZiHhrf/fRibhd1alhjxZwHGJreCpvF5kSWi9
	OqVVEZdWjRUBwh+GCdNViU+ZrP2t6dg4X5tagGp9uhnIpwi8/WonlCwEsu2GcXg0VAiL5GEIozl
	CkWEC0py/hgxsiGJwjmlZBcQ6cAqvGBdjUksgUpWQhq7N2SX6fCDHoHhOvJuWC7L/lNthKI6AhE
	AVbQTFu9WBfJ5uSa0zO6uGBeGQXR5fiAtgTuOjf0vw07NxIdNH6eFN6By9Yog==
X-Received: by 2002:a17:90a:b82:b0:3a0:8001:7d11 with SMTP id 98e67ed59e1d1-3a080017e7amr849638a91.6.1790129805703;
        Tue, 22 Sep 2026 19:16:45 -0700 (PDT)
Received: from localhost.localdomain ([139.159.170.91])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a07dbc013fsm2249648a91.5.2026.09.22.19.16.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 22 Sep 2026 19:16:45 -0700 (PDT)
From: Qihang <q.h.hack.winter@gmail.com>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	stable@vger.kernel.org,
	kuba@kernel.org
Subject: [PATCH net v2] xfrm: validate ihl in xfrm4_transport_output()
Date: Wed, 23 Sep 2026 10:16:40 +0800
Message-ID: <20260923021640.38855-1-q.h.hack.winter@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260917072226.80788-1-q.h.hack.winter@gmail.com>
References: <20260917072226.80788-1-q.h.hack.winter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xfrm4_transport_output() reads the IPv4 header length (ihl) from the
packet and uses it for __skb_pull() and memmove() without validating it,
so a frame with ihl * 4 larger than the linear header underflows skb->len
to a huge value or trips BUG() in __skb_pull().

Packets injected into an xfrm interface (e.g. AF_PACKET on an xfrmi
device) reach xfrm output without the header validation that
ip_rcv_core() applies to received traffic.  The underflowed length then
flows into esp_output() and the crypto scatterlist setup, where every
length in the underflow window ends in a fatal fault (BUG_ON in
__skb_to_sgvec()).  This is a deterministic local denial of service
reachable by an unprivileged user through a user and network namespace.

Reject ihl < 5, matching ip_rcv_core(), so a complete IPv4 header is
present.  Then use pskb_may_pull() to make the header linear: this
rejects ihl > skb->len, linearizes a header that currently lives in
fragments, and guarantees __skb_pull()'s precondition that the pull must
not drive skb->len below skb->data_len, and it keeps the memmove() source
in bounds.  ip_hdr() is re-read afterwards because pskb_may_pull() may
reallocate the skb head.  xfrm6_transport_output() already bounds its
header length through xfrm6_hdr_offset().

Fixes: b59f45d0b2878 ("[IPSEC] xfrm: Abstract out encapsulation modes")
Cc: stable@vger.kernel.org
Signed-off-by: Qihang <q.h.hack.winter@gmail.com>
---
 net/xfrm/xfrm_output.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
index e305ba3..86943e2 100644
--- a/net/xfrm/xfrm_output.c
+++ b/net/xfrm/xfrm_output.c
@@ -66,6 +66,11 @@ static int xfrm4_transport_output(struct xfrm_state *x, struct sk_buff *skb)
 	struct iphdr *iph = ip_hdr(skb);
 	int ihl = iph->ihl * 4;
 
+	if (iph->ihl < 5 || !pskb_may_pull(skb, ihl))
+		return -EINVAL;
+
+	iph = ip_hdr(skb);
+
 	if (!skb->inner_protocol)
 		skb_set_inner_transport_header(skb,
 					       skb_transport_offset(skb));
-- 
2.46.0
