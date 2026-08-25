Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D412D8DA8
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 17:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787678644; cv=none; b=TCFcjaBLHpZZTK9vQXYJ9dqg6b3igD1d8+ZNauwIFjt6pQGvDNgLLK3uMoxz3xvyirPNo0rrsevA0tT8ihZo4BS6Y62ncNbWcgkKpUX5KC0SfhrKytRwd4FVJO63+xALdIx6s7/6aSouN/UIk6KodV7jcD0i0pobIihYhGpb0d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787678644; c=relaxed/simple;
	bh=1dW/4R8CaYaR/dw/qJ9MuMrEiGI1y0NbrMPvpiqgqT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BcaWvLd5rnkOTgy/oWCsya5HVfzQQvmtAHL+kr6h+tYIu/QKvBmDqp9GZa/fUwDsMZBm+kAVia7z0cdasaYSddbOqLNH+Z576QSbbUIJTXDF9YiZDqVFCR1Xk2owcP41RCOZpNzn01CIHFEuxvicdZcyRGCO1+5O+Z3MeGePC4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XYGCfS6k; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYGCfS6k"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2d01548ac96so128575ad.3
        for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 10:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787678641; x=1788283441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z8i7HH59Qhp0knzyYvG4FDnmdY05CSm6obQoU01fzRQ=;
        b=XYGCfS6kD805+c7vD0Wjgk7VDC0ZT84y8hX+crnd8rJSkosfp0N0h0fS91wFOA82PT
         6xosacDMxYRnLSdnaNiUI7ZqOZdYAZbGnqamHECIgvmjuWeFS0LFYPJ6B4BwsByI6gxA
         NFgiDfsmpHNFas3ighIJWom3mEKgpbHlBvcRmO5uSY2BSxD/0cDxcrjoSjjjtqYYfMM0
         nuNO4IhBhBpdg6CLFYSoJaJ9Z+9ZXAxTl0zzih5Wqbv85GcwnIV8RUA0opEV0q0N2U6X
         Vz5SRDoQJaLv3SxXOsOjO4pHrPJQ35auD6fIpy8mmNlroLphfrL9MVrQcGT0vCvSZ1zI
         IK+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787678641; x=1788283441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=z8i7HH59Qhp0knzyYvG4FDnmdY05CSm6obQoU01fzRQ=;
        b=lhQ7V6x6WIFXLXYOq1OUXhP4H3t7DITs2f1CL5Qc2FZMTA1RUwBkWmJUEy5cStrAXY
         6nk5hrqWs9UcA/B1xPyWzqvEN/ayklfvDdD1FsBUU0Tqu/3SS/h0yFlXfNUb/oycXcSI
         CRBaLgrWeGFliJMW2X9eL0E+fu+ZV1ZTepvAefIdXLm6TqTgxxeRYtE6AcUL7cKm/9an
         ZQRehxKO+uxksEdZbFfXPR8ccdaEaNa1zokLTPCXbciWoV+P0fG/q2AfmA4mASdpwMo2
         nSearTjPEEpxqg+ldXB/ns8YSkHNGvaTItLV19rNcntuweRIUODjanBEfhGe98K3OQBC
         KboA==
X-Gm-Message-State: AFuF++nP7S9cwusR2ixlEvJW7U6eAzCcuKWk505OAk+2xWiWOTiybX/0
	A6QyLf160FjWsJikqina79pSiKdtEDY0xMc3KVKNWgyXc0hdLakiu4Z1
X-Gm-Gg: AR+sD132NdiUn1NNtpBix8FrhX5Xd1eL3zWJFmW8H8cokIYWjev7n5E6hcR/CdgpzIu
	6NZdTHbE7DYQ1VF+0XXAOUd0FmjsSG7DSqnC4qZ/YrEg5bxUISe0QQNWk/3IuiFncVlJ2DS5hhT
	WGP35230hkbKoR+VX0u6vqoctaI3HkdIxnaR9in/OfQpnMO7g85wcbSCaWq6aHMBQDrDPPTx8DA
	WI97xNFdWrLGutCt4wqbVrj7M5hhWB/egrGt16sQXTz9SvXAyC0AyzrA2GxxPRFAlT0JVydaLYo
	YEOwsV3vcYhbBa1x38VJ2pk3114DuUl7ttw+YfEvFFyd0sdlB6IiFYsnPk8EtHSQZt9mYxCShII
	ljzTZs3h5c00tkTz0HDB67ltsBfaWWZu0bFszR7v6w3FQu2NoiPP0M8mCKSvR222dgq98ISY0Ob
	y2RXmIkX3eLkuxRCSr/X8x1TfF3BaEZ7eQ9ZAoIHcbWYses3GN2um2H9LC/35rBuJ6yjag4uw4C
	iEepSvV0bdUGWl3XlFsStRCozAetddYa6ZjdbEaRmM0270lRpN3QQEb+Q==
X-Received: by 2002:a17:902:ec8c:b0:2d3:71af:782a with SMTP id d9443c01a7336-2d6e0a521a1mr69133835ad.0.1787678641136;
        Tue, 25 Aug 2026 10:24:01 -0700 (PDT)
Received: from localhost.localdomain (45.78.64.189.16clouds.com. [45.78.64.189])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3283d9e5fb1sm640096eec.25.2026.08.25.10.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 10:24:00 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2] net: pin protocol module before inet socket allocation
Date: Wed, 26 Aug 2026 01:23:49 +0800
Message-ID: <20260825172349.232794-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260823171311.3857087-1-nicoyip.dev@gmail.com>
References: <20260823171311.3857087-1-nicoyip.dev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

inet_create() and inet6_create() look up the protocol under
rcu_read_lock(), then drop RCU before using the resulting proto.
sk_alloc() uses GFP_KERNEL, so RCU cannot be held across it.

A loadable protocol can be unregistered in that window.
inet_unregister_protosw() waits with synchronize_net() only for
readers still in the RCU section. After rcu_read_unlock(), module
exit can run proto_unregister(), destroy prot->slab, and free the
module. inet_create() then uses a dangling proto pointer:

  CPU 0 inet_create                     CPU 1 l2tp_ip_exit
  rcu_read_lock()
  answer_prot = answer->prot
  rcu_read_unlock()                     inet_unregister_protosw()
                                          synchronize_net()
                                        proto_unregister()
                                          kmem_cache_destroy(slab)
  WARN_ON(!answer_prot->slab)
  sk_alloc() -> kmem_cache_alloc(stale)

This was reproduced with socket(AF_INET, SOCK_DGRAM, IPPROTO_L2TP)
racing delete_module("l2tp_ip"):

  Oops: general protection fault, probably for non-canonical address
  KASAN: maybe wild-memory-access in range
  RIP: kmem_cache_alloc_noprof+0x63/0x370
  Call Trace:
   sk_prot_alloc+0x74/0x2c0
   sk_alloc+0x2b/0x6c0
   inet_create+0x2cd/0xd40
   __sock_create+0x1c3/0x430
   __sys_socket+0x116/0x1d0

__sock_create() already converts family lookup into a module
reference before dropping RCU, but that pins inet, not the protocol
module. Pin answer_prot->owner while still under RCU, then allocate.
sk_prot_alloc() still takes the socket-lifetime reference; drop the
temporary one on every path after sk_alloc(). inet6_create() has the
same hole.

Fixes: a79af59efd20 ("[NET]: Fix module reference counts for loadable protocol modules")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
v2: Pin answer_prot->owner in inet_create()/inet6_create() under
    RCU instead of reordering try_module_get() in sk_prot_alloc().
    sk_alloc() can sleep, so the lookup must be converted into a
    module reference before rcu_read_unlock(). Suggested by
    Kuniyuki Iwashima.

 net/ipv4/af_inet.c  | 10 ++++++++--
 net/ipv6/af_inet6.c | 10 ++++++++--
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 32d006c1a8ee..88a18ac0e6e4 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -325,6 +325,10 @@ static int inet_create(struct net *net, struct socket *sock, int protocol,
 	sock->ops = answer->ops;
 	answer_prot = answer->prot;
 	answer_flags = answer->flags;
+	if (!try_module_get(answer_prot->owner)) {
+		err = -EPROTONOSUPPORT;
+		goto out_rcu_unlock;
+	}
 	rcu_read_unlock();
 
 	WARN_ON(!answer_prot->slab);
@@ -332,7 +336,7 @@ static int inet_create(struct net *net, struct socket *sock, int protocol,
 	err = -ENOMEM;
 	sk = sk_alloc(net, PF_INET, GFP_KERNEL, answer_prot, kern);
 	if (!sk)
-		goto out;
+		goto out_module_put;
 
 	err = 0;
 	if (INET_PROTOSW_REUSE & answer_flags)
@@ -398,6 +402,8 @@ static int inet_create(struct net *net, struct socket *sock, int protocol,
 		if (err)
 			goto out_sk_release;
 	}
+out_module_put:
+	module_put(answer_prot->owner);
 out:
 	return err;
 out_rcu_unlock:
@@ -406,7 +412,7 @@ static int inet_create(struct net *net, struct socket *sock, int protocol,
 out_sk_release:
 	sk_common_release(sk);
 	sock->sk = NULL;
-	goto out;
+	goto out_module_put;
 }
 
 
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 282912a11999..82b390ce3e0c 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -170,6 +170,10 @@ static int inet6_create(struct net *net, struct socket *sock, int protocol,
 	sock->ops = answer->ops;
 	answer_prot = answer->prot;
 	answer_flags = answer->flags;
+	if (!try_module_get(answer_prot->owner)) {
+		err = -EPROTONOSUPPORT;
+		goto out_rcu_unlock;
+	}
 	rcu_read_unlock();
 
 	WARN_ON(!answer_prot->slab);
@@ -177,7 +181,7 @@ static int inet6_create(struct net *net, struct socket *sock, int protocol,
 	err = -ENOBUFS;
 	sk = sk_alloc(net, PF_INET6, GFP_KERNEL, answer_prot, kern);
 	if (!sk)
-		goto out;
+		goto out_module_put;
 
 	sock_init_data(sock, sk);
 
@@ -251,6 +255,8 @@ static int inet6_create(struct net *net, struct socket *sock, int protocol,
 		if (err)
 			goto out_sk_release;
 	}
+out_module_put:
+	module_put(answer_prot->owner);
 out:
 	return err;
 out_rcu_unlock:
@@ -259,7 +265,7 @@ static int inet6_create(struct net *net, struct socket *sock, int protocol,
 out_sk_release:
 	sk_common_release(sk);
 	sock->sk = NULL;
-	goto out;
+	goto out_module_put;
 }
 
 int __inet6_bind(struct sock *sk, struct sockaddr_unsized *uaddr, int addr_len,
-- 
2.43.0

