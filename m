Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7986E3CB572
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 06:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788416601; cv=none; b=apFPTquC1voOG2KH4t7SqwxThw3yPtUe3uLoM8v8oa3HMNCqueXQCvJnefuLIJ/dwJjnyvbVLkWy+QkircMCwSou2QzYNPFqCiGnjQBnvQk//ahr7Yax/VWoKsBqrPoOOWu5HW2keBm6neVbKb/U3GVtDN+nZgh7HkZ/z0JQ+DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788416601; c=relaxed/simple;
	bh=TuGxkHJXiyeQ98BYnDOI/eYK4d+LDwKVganzRP6FtLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O+dBgbzQdwBAS2ZOjId22mWphBjLCDPXx+XjiYgL2fOnhMuq9kkERBsHnp4YGXS5SXZXTlDSHUEgyyzN/MSdICrHM4tkSnQMKNq8tTRu2I8u+5HL6drsZJy/foU6VkZQmbNDfyXdAvNWT/cdkEhDnif+r4KofwsjRxao6+W9AoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=p3llzWE6; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="p3llzWE6"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-855d2bfae95so761997b3a.1
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 23:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788416600; x=1789021400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aa6xtUnRf3OfVklhSmZ+0EAIJvXGvirPNAHJXrVwJVg=;
        b=p3llzWE645hb+Z6bm/G1jhBSAoq+N/LA+PMsc29uLx9Hubzu7vtinlt8/V4MbxvTap
         aULgNps+PI9WLw5IX8TXGkEN8LeQtlEXRJbiOJi+Sin1h+p29LXV5T0wI3Geup02aPal
         9sAJ2LrK1qgH1tK6sBJHAZMuuysTeKR2zqTlR5aurwGfuxnzAuCaWS5pGD/JogtzSA3z
         Y5SJ0p2F21UjX3/ATvnhxgv/AwriMMbidw/6z5jbT2dEOfvB8EIbFawVLkKPXvmHqks1
         0baqdFaC4/VE+9RYqtHbnwwqy8enRoDnRVQwTJ6t2GjhC/7kyMANMY389JAszFQgBiwv
         8Zww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788416600; x=1789021400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aa6xtUnRf3OfVklhSmZ+0EAIJvXGvirPNAHJXrVwJVg=;
        b=F57EFWCGVM+ugsitmEUB28482qVv5O4b40bpEGPMwRt0ihUmaZVH8Cby+0WGyGjW8r
         m+Z1Z2DlPJ1EnshC6blN+U36JBlDQzyLuioKnxRvI+zF2eNu8We/KNsbGfSNALTa1og9
         zIgBZoguQj9LRwlVovixpKurYGP6vKMX0wFd/WXD2jRL/AnLCIBH6ZI0BlPQKoR9HvNd
         T128wuVg4z4lTc4QxXyZ1o67T7ryLZY2EreBdoq1MZVAUQT+d0JlDM8bkstA691/quC8
         TNnJPvOflHnjWVubJU3O7SV6bSH29IdL429GsEnnz1EMjutAqwp+1i+EmizUqfAzD5WO
         SaNg==
X-Forwarded-Encrypted: i=1; AKwUvBz0cL7jTRX2AX8xuE+erYhzUyac2lvqCwkl7hDfJMCx9WzF+CCnsiy+jnw3FfQwpi6UYutrU3U=@vger.kernel.org
X-Gm-Message-State: AFuF++n63/NM25DzC3+ddeIaQ5ILGvvdUH2Toa3q+p9y7vkiXwVi6Rf0
	q9+cydDY71ejmKOXyO/1t1if6HR+fP4b0UhI35T1Z55GIKkJERX6YnYksKzeZCoHmpSI
X-Gm-Gg: AYBFou3Si4/Z1Ie/4QtQUUmyukjEbm85ZmlIahO4Irtw7R4qUdEUzTWkVseMERgV/RZ
	MuJLjgpyh8C82vtzZSdtuSyn2yjITgCyKr6cmaDRL5qJmgPortcuHfUvwzjw1TJQXZb1PaUpOn9
	ZbIVMFcIZvst7og8+5823yFNrFpQF9dSl6lbHqQL7NtLpf7houjqb4OyVPbcL23taDoWyODBUr+
	4ppZD6in8IejENfbrY7WRmS25lY1j3y5QSm39Jz/DY3qcMOk65WHuEkcuR8A0TU4zVgxh7MNWvi
	+m9bSMTNfPK/8IwtqhWGhmF5UflWqE2153DS1uVaV8GRblxlPtAsZyf4y9ee73Kor1K1JD8G+Qx
	WBtY+9fLCuxcO7KKsE1I9M0i82dty+8bCfIVAYfrdx+QXwlG8K7fmX4D53/y4yHGVPH/bAXj4xJ
	/095KtV3RDUTkG/MFHiW8WD5Q8iQv/w1XWM6x9N8SH2DUnwKpltQVOXHnMWgFDe2/6554a/GfT1
	WoJ
X-Received: by 2002:a05:6a21:139a:b0:3c3:750f:3cf9 with SMTP id adf61e73a8af0-3da2142cfdcmr3852165637.11.1788416599634;
        Wed, 02 Sep 2026 23:23:19 -0700 (PDT)
Received: from Roxy.localdomain ([203.175.14.32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc43d240f21sm480533a12.3.2026.09.02.23.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 23:23:19 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: idosch@nvidia.com,
	netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH net v4 1/1] ipv6: flowlabel: cap duplicate leases per socket
Date: Thu,  3 Sep 2026 14:23:03 +0800
Message-ID: <83f8535972ff6e3741548476a1d50dec24c758be.1788415194.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1788415194.git.zhilinz@nebusec.ai>
References: <cover.1788415194.git.zhilinz@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ipv6_flowlabel_get() allocates an ipv6_fl_socklist entry for every
successful GET. The recheck path for a compatible existing flowlabel
links another lease without applying any lease admission check. Repeated
GET requests for one shareable label can therefore grow a socket's lease
list without bound.

Reject a new unprivileged lease once the socket already holds
FL_MAX_PER_SOCK leases. Check this on the shared recheck path so reuse
of a globally interned label, including the fl_intern() collision path,
is covered as well. New-label admission remains under the existing
mem_check() policy.

Use capable(CAP_NET_ADMIN) rather than ns_capable(), matching
mem_check(). An unprivileged user must not bypass the cap by creating a
user namespace and a netns where they have CAP_NET_ADMIN, which would
still consume host memory.

Check the capability only when the socket reaches the limit, so
successful unprivileged GET requests below the cap do not generate a
capability audit. Do the admission check before updating linger and
expires so a rejected GET does not refresh the shared label, matching
the existing socket-list allocation failure path.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Suggested-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
---
changes in v4:
- Count leases with a dedicated helper on the shared recheck path so
  the fl_intern() reuse path is covered as well.
- Restore the original socket-list lookup loop.
- Explain why the check uses capable() rather than ns_capable().
- v3 Link: https://lore.kernel.org/all/69d00f6ba09b1d1afd9281370cf7ae5e2ce806b6.1787387550.git.zhilinz@nebusec.ai/

changes in v3:
- Count the socket's full lease list instead of only matching leases.
- Defer the CAP_NET_ADMIN check until the lease count reaches the limit.
- v2 Link: https://lore.kernel.org/all/528bc30d301bcf32aca37cda1933b617d2d295f4.1786447968.git.zhilinz@nebusec.ai/

changes in v2:
- Count only leases of the flowlabel being reused.
- Fold the count into the existing socket-list lookup.
- Keep new-label admission under the existing mem_check() policy.
- Stop after the first matching lease for CAP_NET_ADMIN callers.
- Explain why a rejected GET does not refresh linger or expires.
- Correct the reuse-path explanation and trim the Fixes hash.
- v1 Link: https://lore.kernel.org/all/cf4fdc79ae4dc46bd4eb7eeb57e5de2091c13cd3.1785746178.git.zhilinz@nebusec.ai/

 net/ipv6/ip6_flowlabel.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/net/ipv6/ip6_flowlabel.c b/net/ipv6/ip6_flowlabel.c
index 1ab5ad0dcf24f..006585dc8b5c6 100644
--- a/net/ipv6/ip6_flowlabel.c
+++ b/net/ipv6/ip6_flowlabel.c
@@ -461,6 +461,21 @@ fl_create(struct net *net, struct sock *sk, struct in6_flowlabel_req *freq,
 	return NULL;
 }
 
+static bool fl_sock_at_lease_limit(const struct sock *sk)
+{
+	const struct ipv6_fl_socklist *sfl;
+	int count = 0;
+
+	rcu_read_lock();
+	for_each_sk_fl_rcu(sk, sfl) {
+		if (++count >= FL_MAX_PER_SOCK)
+			break;
+	}
+	rcu_read_unlock();
+
+	return count >= FL_MAX_PER_SOCK;
+}
+
 static int mem_check(struct sock *sk)
 {
 	const int unpriv_total_limit = FL_MAX_SIZE - (FL_MAX_SIZE / 4);
@@ -679,6 +694,10 @@ static int ipv6_flowlabel_get(struct sock *sk, struct in6_flowlabel_req *freq,
 			err = -ENOMEM;
 			if (!sfl1)
 				goto release;
+			err = -ENOBUFS;
+			if (fl_sock_at_lease_limit(sk) &&
+			    !capable(CAP_NET_ADMIN))
+				goto release;
 			if (fl->linger > fl1->linger)
 				fl1->linger = fl->linger;
 			if ((long)(fl->expires - fl1->expires) > 0)
-- 
2.43.0

