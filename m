Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D7A424D48
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 07:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788767933; cv=none; b=Uy2xVnBstE7seDfgDnHy8BOOVf88O3EvqPxY5PiYafgaaUqxAvxtMdXxBofh2hLWpabMAZ8FdbINtyxJfU8kurCqut+js3ZM6N0v90ul58KokDD6O0ZOu877rChBAorZXXJVRR7P9TvL1BccqbIQhO0ZqribMd/8lr8u0yM0vUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788767933; c=relaxed/simple;
	bh=H032FftfyQqxrqsZ5xng+VNTRD8DcHWwJAxnkH+XyqE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fBElcPNe+bBaCkoKlYC097frLZ5VcHghn4xvBaCXidE3tecOX2fqNWts4i0L36AxLsh2y9iyscbfPMzNHjos4muriA/NlmTi3VBr42hrcoaCsYuz/lSZxsGlbGO+diC8o45CfpIxJy8T37u+yFBu6t0tDmP/5XWesDKxjrjJsK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u2v9qep9; arc=none smtp.client-ip=209.85.222.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u2v9qep9"
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-9399b66e0e7so226289485a.1
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 00:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788767930; x=1789372730; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0O8yjq4bE4vbONsKrnt/y7VtXskqzX8m3Lw5BhIaKJs=;
        b=u2v9qep92EJ85Tq/pxbXI1ua1y2FnnHkrHkgnpMeY5jFxutrJFlEEEfFSt3GZsq39+
         5GXKQmXgjYKZGqoXqwhcq8Zjqs7A6pyW34NRBrixwBnGkofXVmfRuoxmuGb5njlMDGMx
         41BU12/fjbg2nHf5jMLR/g4EzvlRyYDkWNIBrYvzkDPm6oU38YP8w0aIHiLZL3YcnVY5
         lM1b88QyCCYUVXPwbnE1/7Wuh05opbziVSPSMryBGdVa7hhneZgUMAILSx9M+u4tFf21
         HOo4Z5i/GkpQ1Mt+XR3RsVg+Sz3ZqBmyIxYSUgJwpxdY6Mui/KlPLGWiXaQkbBOyPeaO
         GGtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788767930; x=1789372730;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0O8yjq4bE4vbONsKrnt/y7VtXskqzX8m3Lw5BhIaKJs=;
        b=gjT69T/z3PHKFkhZ3eUpGvY9zK3hkt6ApzD1CKqlCFM4FOhvqz96N9u+JdGa0I/jAz
         VNy5gpSr1NOgE/l822Gi2TZu2MTvxy0JDuQp/XU7CtPgj6DqqY07eMQRY1pcWySX9uKU
         OSSk4lQHfag4mBkyPwnQhbw0ynN06ZS9BiX/bCBWGg9Zvq1kVu/M+vFZJZHF+FS9JEzX
         X8IeRuxKZNRiGTs6+ZglmEMAkR9V6iw51A7Rkb2vB6+FSFBqEujH7pciy8+sT/kGbZ0J
         7suAyOVTNUroGPluk2weVeHFkUrF7zt+MpST8OSRB79XVYxu9/MCfLV6GpY/ufmEhF50
         QpBg==
X-Forwarded-Encrypted: i=1; AKwUvBw1yTQDNmVruW8+PoMWqOa1NkR1PuKMNswwhG3r23Ya3wlDl19kSFsccCE0xtj0GoVhJ8UVLTg=@vger.kernel.org
X-Gm-Message-State: AFuF++n60BIFWYJLyCEteK7xDMRi78xZ3O33ZuboGqWbBeM3sYGL18Yi
	rnlaaMF7EssP64+3qp3y+0bwWixNB1l1ifcjIOz6+VtUq7z6DsG8RA3npFkDWp+o6sYSZTcxerg
	WXe4S63Uu9Cocgg==
X-Received: from qknur2.prod.google.com ([2002:a05:620a:6f02:b0:92e:6aaa:d1c3])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:298f:b0:933:a17:c0c4 with SMTP id af79cd13be357-939803118a2mr2239862885a.9.1788767929601;
 Mon, 07 Sep 2026 00:58:49 -0700 (PDT)
Date: Mon,  7 Sep 2026 07:58:38 +0000
In-Reply-To: <20260907075846.2913645-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260907075846.2913645-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260907075846.2913645-2-edumazet@google.com>
Subject: [PATCH net-next 1/9] sit: fix UAF in ipip6_tunnel_del_prl()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Ido Schimmel <idosch@nvidia.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>, Artem Lytkin <iprintercanon@gmail.com>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

When flushing all potential router list (PRL) entries,
ipip6_tunnel_del_prl() called call_rcu(&x->rcu_head, prl_list_destroy_rcu)
before clearing t->prl.

A concurrent reader in isatap_chksrc() could enter an RCU read-side
critical section after call_rcu() but before t->prl is set to NULL,
allowing prl_list_destroy_rcu() to free nodes while the reader traverses
them.

Clear t->prl using RCU_INIT_POINTER() before invoking call_rcu().
Also use rcu_assign_pointer() when unlinking individual entries.

Fixes: ef9a9d1183b3 ("ipv6 sit: RCU conversion phase I")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/sit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index 19b7fa8d1a2a07991a00b250c5ae58819d104e79..4438b2472b28764f813b9162bdb9f6b6dee5a007 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -436,7 +436,7 @@ ipip6_tunnel_del_prl(struct ip_tunnel *t, struct ip_tunnel_prl *a)
 		     (x = rtnl_dereference(*p)) != NULL;
 		     p = &x->next) {
 			if (x->addr == a->addr) {
-				*p = x->next;
+				rcu_assign_pointer(*p, rtnl_dereference(x->next));
 				kfree_rcu(x, rcu_head);
 				t->prl_count--;
 				goto out;
@@ -447,8 +447,8 @@ ipip6_tunnel_del_prl(struct ip_tunnel *t, struct ip_tunnel_prl *a)
 		x = rtnl_dereference(t->prl);
 		if (x) {
 			t->prl_count = 0;
+			RCU_INIT_POINTER(t->prl, NULL);
 			call_rcu(&x->rcu_head, prl_list_destroy_rcu);
-			t->prl = NULL;
 		}
 	}
 out:
-- 
2.55.0.979.g7e5102b832-goog

