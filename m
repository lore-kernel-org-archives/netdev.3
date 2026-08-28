Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B63F3EC830
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 08:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787906745; cv=none; b=kwJZcoIl+MFvDtIWuV4ETOZix64VLkYU/SvOufdX8wWhMVNdOD6ECTRFLVGD9+kmF0Vo+5uAk326pMhAjAcqaiDlOP9POz6oH7MoShX6olO4qWlcK/zsR9dp9jb6FbNESzof4z2zNVWoaHovYVyI0YiUMJYXRSCh1N/hz9ov30A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787906745; c=relaxed/simple;
	bh=wHZm5T6MXfIHf1aB3xeVf+l7MfOlOZRP+jCO3ynpwmM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VK7nPoe2V4/p724l6XKv6AmUfNfAxVXUqKQeTWqcIhi+FdFfytEKIHUlw1bmQR4kWazb8W7D7a/g+pU00zUdldTquK1ZXOoMXjp/duqX9UMb91+oZpEjwEA5oKov8ZC7AB8sSxQPHiBoo9GyTjRf9JWJ9v+bn9xF+ha9fj590s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fp/V6vYO; arc=none smtp.client-ip=209.85.222.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fp/V6vYO"
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-9390ca1a9abso106412985a.2
        for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 01:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787906742; x=1788511542; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gmGTmfvPMul0lpOk9GNEl2916otB+JSQDPLwkYrikSc=;
        b=Fp/V6vYOLJeayAJhUkT/kMP5lRY8wnAZS9F4heK9wsUdYb1tv2T3MmDmZEukmLlaLJ
         J6La8xQy+0xMQ3rRb/x1zkR9+KDHMj8FuChlpmajAHZ8Nym0wznt9HVwIU6aDB9u9AzS
         6Uc15lUpk154OBOO5pCYglrdvZBfg83txPwjyMjTjqdPl+S2fhmjt5qr77Lr3r99kcmx
         HIdYUr8Vya04UqQfxtL524rfzuDe5YoqWM2rwaLmlw20waGo8SjnNHXO2iprAknksQvz
         bDnD7VFvBIy5px08lCwiCYi4U+KJl1AVls3es/1oDkKAvijP/YdFFx+U6iGD/V4Jltpg
         Ps2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787906742; x=1788511542;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gmGTmfvPMul0lpOk9GNEl2916otB+JSQDPLwkYrikSc=;
        b=PlDW3hru0TL+JERIkdhdxgkMsHmmWeYmlu1/pn8QKpU5jk8oh7xPD37Cbkpd/sM2qT
         fuJ7wj057DP+Er1pneyC/VEX4iuU6wSzISKSxpft26gpMNWYlqc5+Xurki5i6WTVSZxq
         vX0Vj7qj67eU26xAcobdk7bVOkK6I0XhLuMzX5Lx+j5Wf5JS45LupNtMh0uySQNGeLqj
         bQOQ3776Tq1aIYI3E82rt/7kR+o5KxiGTAfGoX9fdf9o7qYakLZkU/Z3T/Yi/9AT+FD6
         BFwjSdgUUb/NYDBBQU0yC/otmzonO63INVp/ZfOiWPvPVeAO8A3QJWvUvC3k8FDiAyuz
         79ww==
X-Forwarded-Encrypted: i=1; AHgh+RpjY8669/6RFcT9XrzomFMMzH9mtgGLrqZtQfTQQ8q9tBDw80Ja0+V2G5LFcMS4Qg1r2FX/kRI=@vger.kernel.org
X-Gm-Message-State: AFuF++k/XVpeeldcHiYt/UvH/OJMT+e1XWAhm34scHbMdLx+9r+GQE8j
	5YerVKQvpzhnyOC2FHBtt/z2ZAE4Ynr+FYrrSH+t90D5/Pc1CvzFkFFGa3E1jU0joVjprOuNWUQ
	nPQCltrUVgMbrUw==
X-Received: from qknqz23.prod.google.com ([2002:a05:620a:8c17:b0:934:b322:8e9f])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:a0cc:10b0:930:a26a:fb2a with SMTP id af79cd13be357-939137af782mr418758685a.2.1787906741894;
 Fri, 28 Aug 2026 01:45:41 -0700 (PDT)
Date: Fri, 28 Aug 2026 08:45:28 +0000
In-Reply-To: <20260828084531.1826790-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260828084531.1826790-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
Message-ID: <20260828084531.1826790-3-edumazet@google.com>
Subject: [PATCH v2 net 2/5] ipv6: mcast: use copy-on-write RCU updates in ip6_mc_source()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Taehee Yoo <ap420073@gmail.com>
Content-Type: text/plain; charset="UTF-8"

pmc->sflist is read locklessly under rcu_read_lock() by
inet6_mc_check() during packet reception in the UDP and RAW
multicast receive paths.

ip6_mc_source() mutated psl->sl_addr and psl->sl_count in-place
when adding or removing a source filter. Additionally, when expanding
the filter buffer, newpsl was published via rcu_assign_pointer()
before writing the new source into the array.

Because 16-byte struct in6_addr writes are not atomic and array
shifting is not synchronized with RCU readers, concurrent readers in
inet6_mc_check() could read torn IPv6 addresses or observe
duplicated/missed source entries.

Fix this by switching ip6_mc_source() to copy-on-write RCU updates:
allocate and fully populate newpsl before publishing it via
rcu_assign_pointer(), and reclaim the old filter via kfree_rcu(),
matching ip6_mc_msfilter().

Also remove the now unused IP6_SFBLOCK macro.

Fixes: 882ba1f73c06 ("mld: convert ipv6_mc_socklist->sflist to RCU")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Taehee Yoo <ap420073@gmail.com>
---
v2: See https://lore.kernel.org/netdev/CANn89i++X6UUpACK+Bq9d+qbiu1NQ=Ynz75OQgbWjUHNyu-S8Q@mail.gmail.com/

 include/net/if_inet6.h |  2 -
 net/ipv6/mcast.c       | 98 ++++++++++++++++++++++++------------------
 2 files changed, 56 insertions(+), 44 deletions(-)

diff --git a/include/net/if_inet6.h b/include/net/if_inet6.h
index 238ad3349456a3afeab6c02172a9e2d681d2ec9c..795fb41b45f5d10d903de220df3cd0c3798561a0 100644
--- a/include/net/if_inet6.h
+++ b/include/net/if_inet6.h
@@ -88,8 +88,6 @@ struct ip6_sf_socklist {
 	struct in6_addr		sl_addr[] __counted_by(sl_max);
 };
 
-#define IP6_SFBLOCK	10	/* allocate this many at once */
-
 struct ipv6_mc_socklist {
 	struct in6_addr		addr;
 	int			ifindex;
diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index ec7fac511c8d50da7125ff1c4cd23af46875791d..66f5858e5fea68e27da1f857b5596808632618a3 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -355,12 +355,12 @@ int ip6_mc_source(int add, int omode, struct sock *sk,
 {
 	struct ipv6_pinfo *inet6 = inet6_sk(sk);
 	struct in6_addr *source, *group;
+	struct ip6_sf_socklist *newpsl, *psl;
 	struct net *net = sock_net(sk);
 	struct ipv6_mc_socklist *pmc;
-	struct ip6_sf_socklist *psl;
 	struct inet6_dev *idev;
 	int leavegroup = 0;
-	int i, j, rv;
+	int i, j;
 	int err;
 
 	source = &((struct sockaddr_in6 *)&pgsr->gsr_source)->sin6_addr;
@@ -409,13 +409,11 @@ int ip6_mc_source(int add, int omode, struct sock *sk,
 	if (!add) {
 		if (!psl)
 			goto done;	/* err = -EADDRNOTAVAIL */
-		rv = !0;
 		for (i = 0; i < psl->sl_count; i++) {
-			rv = !ipv6_addr_equal(&psl->sl_addr[i], source);
-			if (rv == 0)
+			if (ipv6_addr_equal(&psl->sl_addr[i], source))
 				break;
 		}
-		if (rv)		/* source not found */
+		if (i == psl->sl_count)		/* source not found */
 			goto done;	/* err = -EADDRNOTAVAIL */
 
 		/* special case - (INCLUDE, empty) == LEAVE_GROUP */
@@ -424,58 +422,74 @@ int ip6_mc_source(int add, int omode, struct sock *sk,
 			goto done;
 		}
 
+		atomic_sub(struct_size(psl, sl_addr, psl->sl_max),
+			   &sk->sk_omem_alloc);
+
+		if (psl->sl_count == 1) {
+			newpsl = NULL;
+		} else {
+			newpsl = sock_kmalloc(sk, struct_size(newpsl, sl_addr,
+							      psl->sl_count - 1),
+					      GFP_KERNEL);
+			if (!newpsl) {
+				atomic_add(struct_size(psl, sl_addr, psl->sl_max),
+					   &sk->sk_omem_alloc);
+				err = -ENOBUFS;
+				goto done;
+			}
+			newpsl->sl_max = psl->sl_count - 1;
+			newpsl->sl_count = psl->sl_count - 1;
+			for (j = 0; j < i; j++)
+				newpsl->sl_addr[j] = psl->sl_addr[j];
+			for (j = i + 1; j < psl->sl_count; j++)
+				newpsl->sl_addr[j - 1] = psl->sl_addr[j];
+		}
+
 		/* update the interface filter */
 		ip6_mc_del_src(idev, group, omode, 1, source, 1);
 
-		for (j = i+1; j < psl->sl_count; j++)
-			psl->sl_addr[j-1] = psl->sl_addr[j];
-		psl->sl_count--;
+		rcu_assign_pointer(pmc->sflist, newpsl);
+		kfree_rcu(psl, rcu);
 		err = 0;
 		goto done;
 	}
 	/* else, add a new source to the filter */
 
-	if (psl && psl->sl_count >= sysctl_mld_max_msf) {
+	if (psl && psl->sl_count >= READ_ONCE(sysctl_mld_max_msf)) {
 		err = -ENOBUFS;
 		goto done;
 	}
-	if (!psl || psl->sl_count == psl->sl_max) {
-		struct ip6_sf_socklist *newpsl;
-		int count = IP6_SFBLOCK;
-
-		if (psl)
-			count += psl->sl_max;
-		newpsl = sock_kmalloc(sk, struct_size(newpsl, sl_addr, count),
-				      GFP_KERNEL);
-		if (!newpsl) {
-			err = -ENOBUFS;
-			goto done;
-		}
-		newpsl->sl_max = count;
-		newpsl->sl_count = count - IP6_SFBLOCK;
-		if (psl) {
-			for (i = 0; i < psl->sl_count; i++)
-				newpsl->sl_addr[i] = psl->sl_addr[i];
-			atomic_sub(struct_size(psl, sl_addr, psl->sl_max),
-				   &sk->sk_omem_alloc);
+	if (psl) {
+		for (i = 0; i < psl->sl_count; i++) {
+			if (ipv6_addr_equal(&psl->sl_addr[i], source))
+				goto done; /* err = -EADDRNOTAVAIL */
 		}
-		rcu_assign_pointer(pmc->sflist, newpsl);
-		kfree_rcu(psl, rcu);
-		psl = newpsl;
 	}
-	rv = 1;	/* > 0 for insert logic below if sl_count is 0 */
-	for (i = 0; i < psl->sl_count; i++) {
-		rv = !ipv6_addr_equal(&psl->sl_addr[i], source);
-		if (rv == 0) /* There is an error in the address. */
-			goto done;
+
+	i = psl ? psl->sl_count + 1 : 1;
+	newpsl = sock_kmalloc(sk, struct_size(newpsl, sl_addr, i),
+			      GFP_KERNEL);
+	if (!newpsl) {
+		err = -ENOBUFS;
+		goto done;
 	}
-	for (j = psl->sl_count-1; j >= i; j--)
-		psl->sl_addr[j+1] = psl->sl_addr[j];
-	psl->sl_addr[i] = *source;
-	psl->sl_count++;
-	err = 0;
+	newpsl->sl_max = i;
+	newpsl->sl_count = i;
+	if (psl) {
+		for (j = 0; j < psl->sl_count; j++)
+			newpsl->sl_addr[j] = psl->sl_addr[j];
+	}
+	newpsl->sl_addr[i - 1] = *source;
+
 	/* update the interface list */
 	ip6_mc_add_src(idev, group, omode, 1, source, 1);
+
+	if (psl)
+		atomic_sub(struct_size(psl, sl_addr, psl->sl_max),
+			   &sk->sk_omem_alloc);
+	rcu_assign_pointer(pmc->sflist, newpsl);
+	kfree_rcu(psl, rcu);
+	err = 0;
 done:
 	mutex_unlock(&idev->mc_lock);
 	in6_dev_put(idev);
-- 
2.55.0.897.gb25b4bd76c-goog

