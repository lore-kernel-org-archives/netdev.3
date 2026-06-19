Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4CC32B126
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 21:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781904477; cv=none; b=EiccdtEDbCG4ylYM/hFn3nCMHqD9jmqF7wn8BAWg/4hLupVPGJbSoPiMhh0Er+p7b3GSxyrGcbeXiOeytoSGFKsR4AwLohn5JD4qS8hs+fU15vBDmPaW6DnqLA9iLmdr4Rrx3JFA97vJaQbTqMn7SA51mCYZoX1GoCQ/5d0hojU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781904477; c=relaxed/simple;
	bh=Zf/DRfCPO7igODsd5U3zTkuiwgoYAXC2cqky2cDd5n0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=aum+u4qwVQFP/sBxhJQsOposFw17zJ+PrjCMTvo8CNi1vNNU/SACnx+UHxNzDgW1q01VHwYxNygOuU2pLy6GUXeyXQJvnyM+d/68dGORzju4KuwklmqTQCueup2+F1K66oGrCpz3FkJKk5N1p0mrGosmpisLaGTI7CpP94AGLJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Thc3JeaJ; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Thc3JeaJ"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c6af282daaso35954495ad.3
        for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 14:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781904475; x=1782509275; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XShJL3DbLd6WwGmbvq1ajAKLsbtMdZ08RZ20xfTeNEc=;
        b=Thc3JeaJhloG5/KGmIGKVaiUm8v5tlG6Qx5HTdEYovdQtX/c5E3v+EvMEd0U1SD7Lb
         ydVh4o28II7OlMvuQ/B79poAYln8Mh7WMArC0ypAdWZvk67a3BU/u8NnyNrxNm9UHI3z
         KlmECfHloVK6m8kr5a3lh3Adejx8qyNMLHG9oCgN8BmTd+1V6pc8ktEXJ0Hm0lufzEgF
         03hULLk8OA5delsEeMDgwMeqRQE23vGPctirWYizsWjo0HU9zW1tcSuRJ8fRNf/0bd4C
         QqqOKG+1IydGnbdYQCO2xY9kLaSsg+puOM+NSSftLBqWmf6mZkoQ7ho32NY+jQiyXhEm
         RP5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781904475; x=1782509275;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XShJL3DbLd6WwGmbvq1ajAKLsbtMdZ08RZ20xfTeNEc=;
        b=n1IltjDxfeJ8TWXpVk8mWvuoE+7JzDPQVPK6adicmJrzumPKTTINxxJlcdymSAd/H9
         zft5WybOailMJB9xoezaRoquYKRIaEsmAwFpp2LAIWRnNZwAXGHO8EhrmXgbmBh/e9SN
         XFyOHzLzFULKOkoiSEyfK4TYdUPZaMrnpblL095+zNpnk8UQbN5Vdz1MVMQE6/Zab2CS
         Ncxw8ZpPcKD+wjhw6Gh0Qcr23RBfnVbnGdqVQsqRI97XIH9dqDTTffWJxSspGXS95Ik0
         3RvdzyrRajarCH+QZvqhOR6jhHHtDR9YBvPqh8M3YXJEWSFOtGYxurP92gXt5riI799k
         H9KQ==
X-Forwarded-Encrypted: i=1; AFNElJ9TzfOHN+QwqJ09n4i29e1JEpaSzR3Q59sBDN6jFCdhKbVIEt6kjpyAWwUuyfbgxMboeRX8+DI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOvNy9IWwl94h36+xU+meNgEMM4Pq/CbSDdVSbrkQHhZ2mkRSx
	2NEQF6rRH5Y4hZZu2uJLmnfV1w3sQnv9I65aTQPoTBYwZITdEqWirqg0BqfTFNVnnEfbGLHj7RO
	dT8XTJw==
X-Received: from plrd16.prod.google.com ([2002:a17:902:aa90:b0:2c1:9d1:eeab])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2352:b0:2c6:9d3d:dfbd
 with SMTP id d9443c01a7336-2c718caa362mr58336405ad.16.1781904475012; Fri, 19
 Jun 2026 14:27:55 -0700 (PDT)
Date: Fri, 19 Jun 2026 21:27:20 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.786.g65d90a0328-goog
Message-ID: <20260619212753.3367244-1-kuniyu@google.com>
Subject: [PATCH v1 net] ipv4: fib: Don't ignore error route in local/main tables.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When CONFIG_IP_MULTIPLE_TABLES is enabled but no rule is added,
fib_lookup() performs route lookup directly on two tables.

Since the first lookup does not properly bail out, the result
of an error route in the merged local/main table could be
overwritten by another route in the default table:

  # unshare -n
  # ip link set lo up
  # ip route add 192.168.0.0/24 dev lo table 253
  # ip route add unreachable 192.168.0.0/24
  # ip route get 192.168.0.1
  192.168.0.1 dev lo table default uid 0
      cache <local>

Once a random rule is added, the error route is respected:

  # ip rule add table 0
  # ip rule del table 0
  # ip route get 192.168.0.1
  RTNETLINK answers: No route to host

Let's fix the inconsistent behaviour.

Fixes: f4530fa574df ("ipv4: Avoid overhead when no custom FIB rules are installed.")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/ip_fib.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/net/ip_fib.h b/include/net/ip_fib.h
index a71a98505650..c63a3c4967ae 100644
--- a/include/net/ip_fib.h
+++ b/include/net/ip_fib.h
@@ -374,7 +374,7 @@ static inline int fib_lookup(struct net *net, struct flowi4 *flp,
 			     struct fib_result *res, unsigned int flags)
 {
 	struct fib_table *tb;
-	int err = -ENETUNREACH;
+	int err = -EAGAIN;
 
 	flags |= FIB_LOOKUP_NOREF;
 	if (net->ipv4.fib_has_custom_rules)
@@ -388,17 +388,16 @@ static inline int fib_lookup(struct net *net, struct flowi4 *flp,
 	if (tb)
 		err = fib_table_lookup(tb, flp, res, flags);
 
-	if (!err)
+	if (err != -EAGAIN)
 		goto out;
 
 	tb = rcu_dereference_rtnl(net->ipv4.fib_default);
 	if (tb)
 		err = fib_table_lookup(tb, flp, res, flags);
 
-out:
 	if (err == -EAGAIN)
 		err = -ENETUNREACH;
-
+out:
 	rcu_read_unlock();
 
 	return err;
-- 
2.55.0.rc0.786.g65d90a0328-goog

