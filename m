Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8E438F247
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 17:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782237020; cv=none; b=Uk1526zg/pM70dA09iCWqpKbLFJ1GTdLP1e8hV9EDQImwjIk+hJWzKppDahXrWgXLEaPhqO0ZAjpg9UySrWmCBuhTLBxDm14F9749Q8832z8+WO6cstX5ooYBzBQkh96suRZYjaMjKfCplZLrMZ4C0FAtEuAQwzSsdf2LKvHdEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782237020; c=relaxed/simple;
	bh=NS8NmvJKDR6fhEIy3XDtzMsccV9jQ2GDP8Q4TtPmThg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sd1TvCojQi+VnYsZnbCew7/QJHy/1XtxWOXMv0lBSAqU2Dv1hsHC7TWqgn43+3OcDIxWdjn5C/HigFmiUkZUtp3jVsqJvWuLY05i3xG8uiaMZiqDdLoWyrXHGaCOKkRdfqYfrD76Lghttn737VwWxBWuNRutg8xiEie3SxHfeAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SykFWxvU; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SykFWxvU"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7e94b0aeaa1so99458a34.0
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 10:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782237017; x=1782841817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=14a2esPJrabA3+M9oOvC0YPPzabk9ph48HPu6HtWoEU=;
        b=SykFWxvUbMs3Xw9DRjbXJZrJSLVFAa6mx9LwCvtxqUHUjusoQwwq8ixOu9vJLMyHs3
         UK46vmyZ37soEANIV5RFwhixF2VZOHYwuU5s39HXml/FhFoOzriyru8xXdyR3feV9JZD
         748b4OqVtwvnq5i281yZODYCELFBzD9zV/KbZO0a9Z5eTuYIJ5EJy8g/PIAbJWeIL8Qd
         9uSSY+3K7MfGEAeJsuQE4P0jbkfcvh4N7Z4n1C4VgfbChrjNhGGsjL/tXSDiOVA67Wv7
         ukYDShzvq8jOB168/iY84JgYBH2C52Fn5nqfnUV3Qym8YDraWtzkQqk/Iodhx07F6hGc
         UiBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782237017; x=1782841817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=14a2esPJrabA3+M9oOvC0YPPzabk9ph48HPu6HtWoEU=;
        b=sv2MH1rdHL5WRn8Zers7jzrPQLP8MyU32xW5AILUked27PJ8/nyTplTpt0mf2gD6QP
         dncy34mXhx3XB6DX5rvauW7v3dNRvHWzrgVkIidhU5d6iZy5JtZ2/mkI2/f+4DM5yaVz
         PkAJ11aQQ+bMavNENoHa04mRYK97vvfrDSPdX4fiv0LeV0h9vp58uMO/QHhlC7YGKo6Z
         D1A98AS4ZS2IlI7O8vnXW1ukxUjlCuIeU9eY8XJdtl54++WaBqIEL6AAqfuU1RPtWDmh
         jE44iup/Ylenta5scOEk3WOuYV9imgUk1KrPzXGYWijcgjyd7Y2z/bRK4H2c1y+7qhIl
         hedQ==
X-Gm-Message-State: AOJu0YwiyQrEqmTsAsCKZQG2+zflXEMQKsCi3Dfct7DSgJl5TzaqS1qN
	07Y8bFATpQ62DuXUC5ZBaGaIeIGdrgO23usgekjj2VtLaUBCpAj1esY/
X-Gm-Gg: AfdE7clLHMO1g5vEApSTEGtCL4rw4f6kTgNYSvNuFmvWIUY/kaKoxIl+x+rB1gB58he
	WY9fRAgWnTPozZ1InqGYWzNlOzKwt5YDWw5zjWM8R8Jtsye7SD1vR05jveFuIYVoTqI0fIwUT2j
	ivdhJXPRPzGPZYZ3iRw5UJJk1iN6Rhod0f2BOfYmFzNfl+Z1Uoe1Q6sbG6qOPk9TjYhc5wYoxWy
	lGg6Kjb8fJYzjZ4NCLoTzaQIY6BlCnY8dE+U3PYCJJ0LXxQ2VSvidAj+wmA4RX8s0vnPx34ICSC
	fq/VVuqh0eQYzDB39eipvT0xanofwNi8/gAnWc+qJ7dgnhKGQ+083z1NILwf7u/npzLyxwhD2Rw
	Mj1GtzeqhnDxO2iWTb3MaEMTVi05NA92AqCyL8b0Drn4syFsaRA4l26roocJ90u7tzmJhalJOyP
	zGYPg=
X-Received: by 2002:a05:6808:81c1:b0:48a:dd0e:e5ea with SMTP id 5614622812f47-48f6261bbadmr1926853b6e.30.1782237017050;
        Tue, 23 Jun 2026 10:50:17 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:40::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-48aedf23ce4sm7244472b6e.9.2026.06.23.10.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 10:50:16 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	shakeel.butt@linux.dev,
	roman.gushchin@linux.dev,
	kuniyu@google.com,
	kerneljasonxing@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 06/15] bpf: Add prog_list_init_item(), prog_list_replace_item(), and prog_list_id()
Date: Tue, 23 Jun 2026 10:49:54 -0700
Message-ID: <20260623175006.3136053-7-ameryhung@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260623175006.3136053-1-ameryhung@gmail.com>
References: <20260623175006.3136053-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Martin KaFai Lau <martin.lau@kernel.org>

Add three helpers to abstract operations on a bpf_prog_list entry.

Right now, bpf_prog_array_item is initialized from prog_list_prog(pl),
which returns either pl->prog or pl->link->link.prog. This will not work
when struct_ops is attached to a cgroup because the attachment is backed
by a struct_ops map instead of a BPF prog.

The same applies to __cgroup_bpf_query(). Instead of always copying a
prog id to userspace, struct_ops cgroup attachment will need to copy the
struct_ops map id.

Refactor bpf_prog_array_item initialization into prog_list_init_item()
and prog_list_replace_item(), and refactor id lookup into prog_list_id().
These helpers will be extended to support pl->link->map in a later patch.

This is a no-op change.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/cgroup.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index b100c04cb9c8..b43f0bff184c 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -399,6 +399,22 @@ static struct bpf_prog *prog_list_prog(struct bpf_prog_list *pl)
 	return NULL;
 }
 
+static void prog_list_init_item(struct bpf_prog_list *pl, struct bpf_prog_array_item *item)
+{
+	item->prog = prog_list_prog(pl);
+	bpf_cgroup_storages_assign(item->cgroup_storage, pl->storage);
+}
+
+static void prog_list_replace_item(struct bpf_prog_list *pl, struct bpf_prog_array_item *item)
+{
+	WRITE_ONCE(item->prog, pl->link->link.prog);
+}
+
+static u32 prog_list_id(struct bpf_prog_list *pl)
+{
+	return prog_list_prog(pl)->aux->id;
+}
+
 /* count number of elements in the list.
  * it's slow but the list cannot be long
  */
@@ -492,9 +508,7 @@ static int compute_effective_progs(struct cgroup *cgrp,
 				item = &progs->items[fstart];
 				fstart++;
 			}
-			item->prog = prog_list_prog(pl);
-			bpf_cgroup_storages_assign(item->cgroup_storage,
-						   pl->storage);
+			prog_list_init_item(pl, item);
 			cnt++;
 		}
 
@@ -1015,7 +1029,7 @@ static void replace_effective_prog(struct cgroup *cgrp,
 				desc->bpf.effective[atype],
 				lockdep_is_held(&cgroup_mutex));
 		item = &progs->items[pos];
-		WRITE_ONCE(item->prog, pl->link->link.prog);
+		prog_list_replace_item(pl, item);
 	}
 }
 
@@ -1318,15 +1332,13 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
 		} else {
 			struct hlist_head *progs;
 			struct bpf_prog_list *pl;
-			struct bpf_prog *prog;
 			u32 id;
 
 			progs = &cgrp->bpf.progs[atype];
 			cnt = min_t(int, prog_list_length(progs, NULL), total_cnt);
 			i = 0;
 			hlist_for_each_entry(pl, progs, node) {
-				prog = prog_list_prog(pl);
-				id = prog->aux->id;
+				id = prog_list_id(pl);
 				if (copy_to_user(prog_ids + i, &id, sizeof(id)))
 					return -EFAULT;
 				if (++i == cnt)
-- 
2.53.0-Meta

