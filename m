Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4D233F8CA
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 05:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777009118; cv=none; b=GPp/hyB+EtH8gZyVv9lbE7hD3UuF48dbrikKr1Q+Kd1aTmHnx5PA6e+uXIihhzUPtJJAFq3agheFoFIyGFWlgRwZ9nf3vTFKf02d9/qjecr7szSlObHmm72RwGhgqxhXnYoY1t0gNDsMW0g1vigSJPoESTpZIf3RPORcHnreXJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777009118; c=relaxed/simple;
	bh=TlmfMj0oSjpUNpbiocpFSZqid0mqlfXPvbNwh7NE30k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Sl1wrIJV/dZw2J4uPaU0jwKFQIEMzfJPIsdjJoLM7rWmzB9PgpRRuOfGyRr+IVKFY83rHNS08RzlFMsRXk0GP7LQJZh40kd/DzbzGoom7Xiao2IIr4rIqL0bc/hLJQ1bGee7Rm0yWSy/VJrjhFSMZd1Hz9CDrmhHvcdz1s8KyUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fJIHtcw3; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJIHtcw3"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c648bc907ebso4806249a12.3
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 22:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777009115; x=1777613915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WUXScEQ9v1TBc9CvHH+nPgE6m6kMqTjtcGXW0lXDNGM=;
        b=fJIHtcw37zv9dIHr0VcJ44WP/PkSykznNZ93V7Z1bZgz9ueSzNW5BrbyDbOMt4bIwx
         qLGA4Aa47sNgWjIISe0euyXExFu9v+JD5qs9wQ6erpycNvPzUmCXjRwPeD2FITQHDptO
         FR+mmuXCakiH+4ZtGHIqFmNsIaei+Qn3oSlqXO3pYhD9kzPtNT/Ov9CAtyrlZCjr7YRH
         jaQnydqBwTfcPQs3t8C124x7XHUC3owEkRKVqJabLvAwFZCb031Qq6is9XmSBtRC9mrG
         5GpcMAzl6Ipx1uIZbMGHfGuKHWi6cgF/9+ywN0NQBwnxQp5qBNPFbUFqjx0yPv0i2MCX
         dQgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777009115; x=1777613915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WUXScEQ9v1TBc9CvHH+nPgE6m6kMqTjtcGXW0lXDNGM=;
        b=AIY9ZvWkngDk694LB9bfweizeXx6AOIN1akjhZMbKArpg806nPIku6/iV9rGxCQPp1
         Kfeako58FIY2lmOTX5pABjzac+I5K3V9C22pJo9muMaD7NH7bS4F/Ftm65ju3shFSS53
         FNv4gLIijxCzCueVVQCy/FKCOGLmI9uG8NqVJeLFiJy2Md44TgDUDCNZhtNTan9SKf6O
         xF29DO6RW538SuGBA1ZizGZ3Po+6A2N9lLcus22D/cxCwjGv2dyi0CxU7t7XnKSIclna
         LBLn/akFTuY8RyjDH0onReUjyxz+4f+uTld4u74yLORcGrMCAj+C8YCGYa0DJ6/W/qkb
         hvng==
X-Forwarded-Encrypted: i=1; AFNElJ/KzRWzk9bcTOaIRVyHG1f9w1O6jHCqYil1NBATrqM7jnRDUICW9Dr7D5d8C1K0kl8Q2QReeFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC2hu6vNOSWe6ok9nVSvRvqUKJVP7NumJaZqju2Z8KRtGp1cGd
	aEsUu9RHtZG3rTJBm0RFlxay75Xs08A0tqn9uz4d1/qNdfYXtN1tJb/W
X-Gm-Gg: AeBDiesvS3dPuOeEU2eCroamvAtqSPAsuY6Lk0edPZhigxi+ErLYoxT5jWQG1SqtjV9
	6kbDyeMC4keANbW5HMTQxG9MOdzlURNatCd1JbBrEegYkuGqnyPDPnlu5nDdbp3x9pt2caL7rCI
	PXTAVaH3SeVw1paiLhLjI8hg0qwpgtfLeca+xkurrHB2yI1Z1JIsJgSEFI9YZW3OYlDNJgGENPR
	FMGFJz+ChQhLmK6sFWKPHIo1u/TADlDnOTBHxJNWKNgtwMwnKPElH2R0KdmxU0+rgUpfoSvRkyh
	E25/XlXfkDnYQofZ09LRT60ba4Zg6Zb52AYiAavZYO/vLrQ0TzWK2buDXVrJ2H3zeRiPkEpxQ/f
	mdZ+WlDbxQH74Hl4ANJxL/wy0JEENnUVlWvsX0R7In8CXfhAbzuPpJE7ZwR+OlAE/O38ZAL+f+J
	6PydfHvQk1lcmo5q6f0yYUh+9vU3jWF0MKxZ2PWZKAVMSH0xo9tDKeEwbfRldy7OGxCidPavRmG
	2tw8hJn/+6EgC80EnHmX+MEFqQo06QGP6opMKEsQ61Sjr2xXB0=
X-Received: by 2002:a17:903:28cb:b0:2b4:59d4:9a with SMTP id d9443c01a7336-2b5f9e77d80mr229281675ad.2.1777009115600;
        Thu, 23 Apr 2026 22:38:35 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab405f3sm209444725ad.78.2026.04.23.22.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 22:38:34 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	aleksander.lobakin@intel.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net v4 2/8] xsk: handle NULL dereference of the skb without frags issue
Date: Fri, 24 Apr 2026 13:38:10 +0800
Message-Id: <20260424053816.27965-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260424053816.27965-1-kerneljasonxing@gmail.com>
References: <20260424053816.27965-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

When a first descriptor (xs->skb == NULL) triggers -EOVERFLOW in
xsk_build_skb_zerocopy (e.g., MAX_SKB_FRAGS exceeded), the free_err
EOVERFLOW handler unconditionally dereferences xs->skb via
xsk_inc_num_desc(xs->skb) and xsk_drop_skb(xs->skb), causing a NULL
pointer dereference.

In this series, the skb is already freed by kfree_skb() inside
xsk_build_skb_zerocopy for the first-descriptor case, so we only need
to do the bookkeeping: cancel the one reserved CQ slot and account for
the single invalid descriptor.

Guard the existing xsk_inc_num_desc/xsk_drop_skb calls with an
xs->skb check (for the continuation case), and add an else branch
for the first-descriptor case that manually cancels the CQ slot and
increments invalid_descs by one.

Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx path")
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 6149f6a79897..6521604f8d42 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -893,9 +893,14 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 		kfree_skb(skb);
 
 	if (err == -EOVERFLOW) {
-		/* Drop the packet */
-		xsk_inc_num_desc(xs->skb);
-		xsk_drop_skb(xs->skb);
+		if (xs->skb) {
+			/* Drop the packet */
+			xsk_inc_num_desc(xs->skb);
+			xsk_drop_skb(xs->skb);
+		} else {
+			xsk_cq_cancel_locked(xs->pool, 1);
+			xs->tx->invalid_descs++;
+		}
 		xskq_cons_release(xs->tx);
 	} else {
 		/* Let application retry */
-- 
2.41.3

