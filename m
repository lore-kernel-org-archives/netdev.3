Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A319343882
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 10:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787740638; cv=none; b=jgYVO2VQrgBz7RaAYrEi7XJERJwa6nMAfhd3dDPllQ3lHSOJDMXjkDPU0yxXA7/ie16J/HYTOJTB8NoPvocHRI9cf49R8g7Yq6o9PxA1KjddnQH/y/5i208iAe9CrWcSxla6sOMw7o/QEFLwtxeh0/nKYpB19GFJt6wYj3GSFV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787740638; c=relaxed/simple;
	bh=7ujFsqhktDe21+sjWwQV+vZwCRYgIii2O6ykTGqRrcI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cFlSh8/7FcHtw68kRbuXGP0ycIccviZwjjYpaj/CbtwFJOseMlH+1kNq3EnCX+SbHRmuT47z0DCsIoMbgYKSoJimfWwkspSFRQOKan9KDtDH/02TNTfdh+pHhCwlafOmz+zwGcDXFojbf/+hh2ND5jH4XX3Bz9RbmJJQmJWLF0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LL/iJdJO; arc=none smtp.client-ip=209.85.222.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LL/iJdJO"
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-9382f9430deso14278385a.1
        for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 03:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787740636; x=1788345436; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ppoABoAdyw4Ji0PK1A0QkWOSkv7ewXtU/gBx/wPS37I=;
        b=LL/iJdJOrHksGAOvCBqaN7XDCa4M33JjUGNLhAqca8Agt+lskSaODJIZjKCzORA0Lt
         wcwqsmZZm5T2wBJgKUazraOlnfyyPAXDUfLXXAS55LenE2s1tMb6eabkgotb/WSVlFiK
         P0VMvGosX/9l5/er7wQNnJXwiOE/kRe3rLTQWbwdiGcbnf/17jMwbRZaqzE85ngeip8W
         MFLMnkAlO2fgt7UpsLclOysumox38rXnOMDiTLREcezl/QYGFO5TDfazJzdzA1TZ1Syi
         D8IdcasC4pTqZe3OAZijUQ6HMIHTY6OqK4cKT7YWq78DinSDILPLvjRXYmdcfJftFxUT
         lZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787740636; x=1788345436;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ppoABoAdyw4Ji0PK1A0QkWOSkv7ewXtU/gBx/wPS37I=;
        b=m38k/lDyyjxVPz52buVCXdJQkNkPMCwUsFFCXjIx8+JEG2URbx+vAy3VriF/Oa3XoJ
         MJkaBZD4nO10KvtR4hn/o7WX9CPVnBloP+Q0XcYquPI6Jy0+D3k364qGsOAIyqJ5qlrm
         9zFWxNmtwPsLpPaH+7y6N0S9brOzIOsxVPZCBZnxi1Qj/7rmSPzaEZE/LGuNcrHZih7A
         Nv8ICWv2/QsXbfEhnfChqWYrzMFHD9o2/NzXCJYraAFGxXynvC56Cth4FDiWR8Pvr5iq
         w0bTlNMwUPxhNp2F+C9u60NLscGSpZ8drt3DscFyaOd83t3jAmJ/qZBlBgy+WoVqWzVW
         d6ag==
X-Forwarded-Encrypted: i=1; AHgh+Ro6jyPzAPUXY1WXeKRhSX3jc8E4HxzH9mX5mSbENQrH4rzYsYGXKsjbvvZSYVPT1t3m3504ugE=@vger.kernel.org
X-Gm-Message-State: AFuF++mFmlv3uiaslYVCTeKP0LHK+2T8ELLFdNj//2C/iiMql2ZfSaR0
	zAQ1CHAhH+SHamD03fJDuY2wuquwBr3w+oTKF/YSQ12jJ3I1g98GQsy9UUHv7KPIxgLlTUF3WVW
	pVxiu73Usyh2eew==
X-Received: from qkkh27.prod.google.com ([2002:a05:620a:10bb:b0:936:fee4:4da9])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:6e4f:10b0:937:37d4:5dbb with SMTP id af79cd13be357-937803cddb6mr367053585a.27.1787740635619;
 Wed, 26 Aug 2026 03:37:15 -0700 (PDT)
Date: Wed, 26 Aug 2026 10:37:08 +0000
In-Reply-To: <20260826103711.3302915-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826103711.3302915-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.860.g4b6b3295ed-goog
Message-ID: <20260826103711.3302915-3-edumazet@google.com>
Subject: [PATCH net 2/5] ipv6: mcast: use copy-on-write RCU updates in ip6_mc_source()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
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
 include/net/if_inet6.h |   2 -
 net/ipv6/mcast.c       | 101 +++++++++++++++++++++++------------------
 2 files changed, 58 insertions(+), 45 deletions(-)

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
index ec7fac511c8d50da7125ff1c4cd23af46875791d..40e996f36c37325adee9165ce9842559da039c04 100644
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
@@ -424,58 +422,75 @@ int ip6_mc_source(int add, int omode, struct sock *sk,
 			goto done;
 		}
 
+		if (psl->sl_count == 1) {
+			newpsl = NULL;
+		} else {
+			newpsl = sock_kmalloc(sk, struct_size(newpsl, sl_addr,
+							      psl->sl_count - 1),
+					      GFP_KERNEL);
+			if (!newpsl) {
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
+		atomic_sub(struct_size(psl, sl_addr, psl->sl_max),
+			   &sk->sk_omem_alloc);
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
+	}
+	newpsl->sl_max = i;
+	newpsl->sl_count = i;
+	if (psl) {
+		for (j = 0; j < psl->sl_count; j++)
+			newpsl->sl_addr[j] = psl->sl_addr[j];
 	}
-	for (j = psl->sl_count-1; j >= i; j--)
-		psl->sl_addr[j+1] = psl->sl_addr[j];
-	psl->sl_addr[i] = *source;
-	psl->sl_count++;
+	newpsl->sl_addr[i - 1] = *source;
+
+	err = ip6_mc_add_src(idev, group, omode, 1, source, 1);
+	if (err) {
+		sock_kfree_s(sk, newpsl, struct_size(newpsl, sl_addr,
+						     newpsl->sl_max));
+		goto done;
+	}
+
+	if (psl)
+		atomic_sub(struct_size(psl, sl_addr, psl->sl_max),
+			   &sk->sk_omem_alloc);
+	rcu_assign_pointer(pmc->sflist, newpsl);
+	kfree_rcu(psl, rcu);
 	err = 0;
-	/* update the interface list */
-	ip6_mc_add_src(idev, group, omode, 1, source, 1);
 done:
 	mutex_unlock(&idev->mc_lock);
 	in6_dev_put(idev);
-- 
2.55.0.860.g4b6b3295ed-goog

