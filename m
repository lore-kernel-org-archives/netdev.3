Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4C830D409
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 02:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782786223; cv=none; b=XHc/mMN8vpe30ETIB285Ma2l1IrxF/Bz+zbRvTaGChkhTfJrpajg1mBaRtYoBKpN14mw02szifq2kn9AR+jGVj5aR0O36a+OffIRVLgcKEGEbqf3Cd5Ypp+X2LjN/QjJNzEEUFk7RGWD6cjNcE4si45Wy+ZtyZVaT0gFr+qoIk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782786223; c=relaxed/simple;
	bh=CDUvD/FkQ6GkAs/8Zl1eo0gWKyNp+h1YHMhgn9yYInc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PbnFCkoX8ghhRRoJTT3PswM2FlNTF3h60iF/PiUkCcrXXsukXDhri8AT8zsaOsflDTv7yHyK34p8puj10RKVESVJ7hUzWQtDNZxV0I7tUE+AX+DRO8Oh6ccLZXnIrC3ueRsRzT/xYmp9jlPfps8q8DpGtJY6IkxusyaMQYrOvls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TCFE2Lbz; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TCFE2Lbz"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8478ff5d801so994007b3a.2
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 19:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782786222; x=1783391022; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QfSHSz0tCSvgTPlOG/Uj6E3A09bL6co7exssjtThjWE=;
        b=TCFE2Lbz3PnSvljOHRUkRGw9KGEl0ihj/dz51huK0TLBy7wjeekRcOU4KYPKhK2qHF
         3tJYNwXQiUj8AMqNaw4gGL8kzJAXsE3BrytjvRiYrIGa04KsOjP8YjLOmW81qBU9XTZK
         JtsXWB6IFxL4f08sxIpdVwCcN2JhcGS9VQdv2I4HdB7sOqyh9/Te86zWxfj2qNAflWn/
         iDauN9Gap1F0ZNghYYp3yHYYNaXrhWwaT9blH6GUwx8FziP6itPFCgnaUKBTzoVPUSEj
         vKDoUxfFHnRgdBB+oGd+TzFGgHhILsOCD4KpUesGU/noS4JNSU6RGDvuxF5+TlaBPpzm
         JUqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782786222; x=1783391022;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QfSHSz0tCSvgTPlOG/Uj6E3A09bL6co7exssjtThjWE=;
        b=NBVhMwXYcLlQqdV3Px0VYURTQyZUmVfKBrs1lk3Iga/UEr9c20BTFMjy0HOL+IbAd1
         fmxJABMJPCijnGR34jpS2ZKZqseBvdS4DlwdxE9VFrSRS5+i8Gp6Nktu9Xn9BAnwpm2N
         2R4hJ3vxJG78fcP2Ivo85awqV4j1ry79BmPcOJuhqvFCY/SVuQnuJrxzusRbKVK5mgFt
         za+etTILfrIztMjGjXJlVgK4KPuppjGouhCNF0gZ/xx8lqChErtzwZCOsQ0/s3pBHGCv
         n1B8AF92K20mo0Auc4bvavw7OJK2eYO4ZMkMl666CW9wtBbQchObOA1C6VnFb2FulKJd
         JUZA==
X-Forwarded-Encrypted: i=1; AHgh+RpbKVx5WJDRwLvDSU8u6X1nkvOooTZg17PgMulZGokVORjw3/N8zDUSleBb6DZdbTuYgQqXULo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH1A4BVY9rbCQiBBZvFrWidpPu1vAWu71GQDfdoL22iQKDG3rJ
	LzxBNwwNorU9qnfh9AWSSADNjQhMjw3ou6lGl/EsLIj+RdHhGnR1ZduFa+ekEcRlaKAfKLuRcbV
	rx93LMXTWxKfRX1GhiHbeTxs2Tw==
X-Received: from pfbei40.prod.google.com ([2002:a05:6a00:80e8:b0:847:88aa:4f08])
 (user=yuyanghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:aa7:888e:0:b0:847:9367:e054 with SMTP id d2e1a72fcca58-8479f2c4781mr1264127b3a.57.1782786221403;
 Mon, 29 Jun 2026 19:23:41 -0700 (PDT)
Date: Tue, 30 Jun 2026 11:23:25 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260630022325.1556638-1-yuyanghuang@google.com>
Subject: [PATCH net-next v2] ipv4: igmp: remove multicast group from hash
 table on device destruction
From: Yuyang Huang <yuyanghuang@google.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Cong Wang <xiyou.wangcong@gmail.com>, 
	David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Ido Schimmel <idosch@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When a device is destroyed under RTNL, ip_mc_destroy_dev() iterates through
the multicast list and calls ip_ma_put() on each membership, scheduling
them for RCU reclamation. However, they are not unlinked from the device's
multicast hash table (mc_hash).

Since the device remains published in dev->ip_ptr until after
ip_mc_destroy_dev() completes, concurrent RCU readers traversing mc_hash
can still locate and access the multicast group after its refcount is
decremented. If the RCU callback runs and frees the group while a reader is
accessing it, a use-after-free occurs.

Fix this by unlinking the multicast group from mc_hash using
ip_mc_hash_remove() before scheduling it for reclamation.

Fixes: e9897071350b ("igmp: hash a hash table to speedup ip_check_mc_rcu()")
Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
---
v2:
- Add Fixes tag in the commit message.

 net/ipv4/igmp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index b6337a47c141..af38073a822d 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -1923,6 +1923,7 @@ void ip_mc_destroy_dev(struct in_device *in_dev)
 
 	while ((i = rtnl_dereference(in_dev->mc_list)) != NULL) {
 		in_dev->mc_list = i->next_rcu;
+		ip_mc_hash_remove(in_dev, i);
 		WRITE_ONCE(in_dev->mc_count, in_dev->mc_count - 1);
 		ip_mc_clear_src(i);
 		ip_ma_put(i);
-- 
2.55.0.rc0.799.gd6f94ed593-goog

