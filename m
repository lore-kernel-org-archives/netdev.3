Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9DF30DECB
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 17:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787764471; cv=none; b=rYmSVOY+rBgvyApy6mOgnl+9PXviqDcw6EqDCEdYlVSFVz6hUDpFTMliYd7KgQbF2ocTaxXONTQnnJKiahzNMYSGSP71KPcdI2ZhgdmJXhbldYsKG8vg7WL5jnJUt6GNsvboQd3RlYy/vjp8DFRSyeFomcNW8QtxRKOFPtpvKZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787764471; c=relaxed/simple;
	bh=GVs+ZNQs+K6IwSJgOb8nQUeglTVCjZ+pd60CynzS5K4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qMS1RAJsu3fYuUmZVP8/3XtIo+cJFuTO+81+gWyPNLfdHhyVOyQ6jdykPt8uM1LBwZH96ERPnpauXCAsaactMYWnhfqV+9OXRL4eI41/bsdHidsIo7+CNiDn+i8JG48+uYgK90N7wHROxV+q/mRNlevTb1qDMT+0xCnxOKF7H2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lJ4yYuma; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJ4yYuma"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7dbcb505578so13210277b3.3
        for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 10:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787764451; x=1788369251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ccxl4Hbr9QQtr79HZmn4JSZFJJOV4fZach2l3iVk3ec=;
        b=lJ4yYumaqUMaU/n9wCQ6/Il4+Nchy71zyeSBFxFtu5LkN3w6kBknApxxiqpk0v7nf2
         +7i6QpOo0mdCJTB22Ypdev8M6iKe4xHnXXKtcw2cmKIn6/BpUHvNTSxxrkeFMDMdKkli
         E0mLOLWQe9ANuOwZXwS6Yhdd0hDx7Zzpw58hHmVk8NMvTJXB0Sw3Dnu1qIEpphEU1u03
         636IeyQMvT9fQ5fMwsh/L1WXtOwK1T2pZOFsRSum5E+Qx7eDtl9rNnVdL46Pq7RJ2UqR
         h0dqso5jlr/lH0ctQLD9eAEy6AqcA5YI5ovQpaQ9j5K3CyGc4s+orsmm61IF7KqQwum/
         LcTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787764451; x=1788369251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ccxl4Hbr9QQtr79HZmn4JSZFJJOV4fZach2l3iVk3ec=;
        b=kRIC/dT8X7qzjkIfgsXt+KTz2rUfX9khEXPluAEeQ8+RUUXOoFeqZvET9U5Edpl1K7
         VnGRmnHmb/+JSGzfuG01XSgSOZmxshEfPFf7O0oyDTCcO+QvNwN0inzwFfcVrIgIqnTX
         8QgdH9qjEjbARRjGaUZjBe8vk6KZRacNLHe8TS3383WqMVLQ2CBJJM7IroBaJFqAtaNV
         K/LG4NzSxIUBE6z9kINbjhkEQB8/2fG4NjGhbSz3H0c7F8yGnWfJvD2/uETaWkc+HGRt
         oTr5J/0LnFHKQsnDLWFOBhnOxn4Tb3Bq2aOI3vPcIIcrh82TAV1eZvaqrW6TIdLITgys
         ptEw==
X-Forwarded-Encrypted: i=1; AHgh+RrenK3HRbRKkXmxxw7KTSuQ7zYx3Yq6tfm++fxTuSl41BCnFm0o3et4CHNrBqo39LSgHAsaE8c=@vger.kernel.org
X-Gm-Message-State: AFuF++k+XdmFJyU0h2jEYE3h3EQF7ScI/4ACikfn48WY/u/hMJNDQhzI
	wX4BdMc8VZuZX3ND1+NxOoPr8IQVFBxs0FAbsliR7nFAJLu8FovuLx6Y
X-Gm-Gg: AR+sD124Fpo4dgDm8gThgWayZONxKXmZraZ3esSQfY98XgmnFHpY+uGxqo7mNtuMQS2
	apjC+laka5nsW1F4FFd0SRVJ251i+CFmZNDRWslmVu+am35QjLRe9cAoXsSe7N5oZ5Zl6+t2nIp
	vKhORAly0rxEKXFutUUsA0PNd3BSwKe+WL118jxZcP4kHBmcZ7H78u5W4bswL7Xd2tznebwSTNy
	yDekZpSaSEtaRhHV0PbqtXwI9HbtvZE2rXqj1rJo7QydxESZcnoqFMkeUkun3f9z/Rh6R2J9axB
	wWqfyeE8nxOzocIaWvVfJkN1aFSf5xu4GNS9XiJ48jeaeAh6zgS4+khtIUTIw5vLZUJf6FXdtqB
	d/gXjA5IUmA6wsBPv4d+65QDs8SJoxwELYZKTLH9gJuTgS269rEjreuTioOhrXmR1iYQ5095e4k
	X60VCDvfqG814Z7uv9VwIBkokzpQC7f4ZkxYMGKxbRjESkqWBgvUKpK7sijSaDFiuUuho=
X-Received: by 2002:a05:690e:12c4:b0:667:97c4:7058 with SMTP id 956f58d0204a3-66d2578fba2mr2268394d50.37.1787764450695;
        Wed, 26 Aug 2026 10:14:10 -0700 (PDT)
Received: from mac.lan ([136.55.173.105])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8570d620433sm19313287b3.42.2026.08.26.10.14.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 26 Aug 2026 10:14:10 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: edumazet@google.com,
	ncardwell@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: kuniyu@google.com,
	horms@kernel.org,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	yhs@fb.com,
	kafai@fb.com,
	andriin@fb.com,
	ast@kernel.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	xmei5@asu.edu,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	blbllhy@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH net v2 1/2] tcp: fix use-after-free in do_tcp_getsockopt(TCP_CONGESTION)
Date: Wed, 26 Aug 2026 13:13:43 -0400
Message-ID: <20260826171344.4133-2-blbllhy@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826171344.4133-1-blbllhy@gmail.com>
References: <20260826171344.4133-1-blbllhy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Cen Zhang (Microsoft Security FORGE Labs)" <blbllhy@gmail.com>

do_tcp_getsockopt() reads icsk->icsk_ca_ops->name without holding
rcu_read_lock(). Since commit 0baf26b0fcd7 ("bpf: tcp: Support
tcp_congestion_ops in bpf"), icsk_ca_ops can point to dynamically
allocated BPF struct_ops memory that may be freed concurrently via
setsockopt(TCP_CONGESTION), leading to a use-after-free.

  BUG: KASAN: slab-use-after-free in _copy_to_user+0x37/0x60
  Read of size 16 at addr ffff888013505260 by task exploit/149
   _copy_to_user+0x37/0x60
   do_tcp_getsockopt+0x158a/0x2460 (net/ipv4/tcp.c:4585)
   tcp_getsockopt+0x91/0xf0
   __sys_getsockopt+0xf7/0x170

Fix this by holding rcu_read_lock() around the ca_ops->name access,
using READ_ONCE() to load icsk_ca_ops, and copying the name to a
stack buffer before releasing the lock. Also annotate every explicit
icsk_ca_ops store with WRITE_ONCE() to fix the accompanying KCSAN
data-race issue.

Fixes: 0baf26b0fcd7 ("bpf: tcp: Support tcp_congestion_ops in bpf")
Suggested-by: Eric Dumazet <edumazet@google.com>
Reported-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
Link: https://lore.kernel.org/all/20260821182449.79785-2-blbllhy@gmail.com/
Cc: AutonomousCodeSecurity@microsoft.com
Cc: stable@vger.kernel.org
Assisted-by: GitHub-Copilot:claude-opus-4.6
Signed-off-by: Cen Zhang (Microsoft Security FORGE Labs) <blbllhy@gmail.com>
---
Note: The adjacent TCP_ULP case has a similar read pattern on
icsk_ulp_ops->name, but icsk_ulp_ops always points to static
module data (no BPF struct_ops equivalent), so it is not affected.

Changes in v2:
- Add READ_ONCE() for the icsk_ca_ops load.
- Add WRITE_ONCE() for every explicit icsk_ca_ops store.
---
 net/ipv4/tcp.c           | 14 +++++++++++---
 net/ipv4/tcp_cong.c      |  4 ++--
 net/ipv4/tcp_dctcp.c     |  2 +-
 net/ipv4/tcp_minisocks.c |  2 +-
 net/ipv4/tcp_output.c    |  2 +-
 net/mptcp/protocol.c     |  2 +-
 6 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index b4237d0e994d..4918f48ba76d 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4577,16 +4577,24 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 		val = !inet_csk_in_pingpong_mode(sk);
 		break;
 
-	case TCP_CONGESTION:
+	case TCP_CONGESTION: {
+		char ca_name[TCP_CA_NAME_MAX] = {};
+
 		if (copy_from_sockptr(&len, optlen, sizeof(int)))
 			return -EFAULT;
 		len = min_t(unsigned int, len, TCP_CA_NAME_MAX);
 		if (copy_to_sockptr(optlen, &len, sizeof(int)))
 			return -EFAULT;
-		if (copy_to_sockptr(optval, icsk->icsk_ca_ops->name, len))
+
+		rcu_read_lock();
+		ca_ops = READ_ONCE(icsk->icsk_ca_ops);
+		memcpy(ca_name, ca_ops->name, sizeof(ca_name));
+		rcu_read_unlock();
+
+		if (copy_to_sockptr(optval, ca_name, len))
 			return -EFAULT;
 		return 0;
-
+	}
 	case TCP_ULP:
 		if (copy_from_sockptr(&len, optlen, sizeof(int)))
 			return -EFAULT;
diff --git a/net/ipv4/tcp_cong.c b/net/ipv4/tcp_cong.c
index e9f6c77e0631..8e83ef81fc18 100644
--- a/net/ipv4/tcp_cong.c
+++ b/net/ipv4/tcp_cong.c
@@ -223,7 +223,7 @@ void tcp_assign_congestion_control(struct sock *sk)
 	ca = rcu_dereference(net->ipv4.tcp_congestion_control);
 	if (unlikely(!bpf_try_module_get(ca, ca->owner)))
 		ca = &tcp_reno;
-	icsk->icsk_ca_ops = ca;
+	WRITE_ONCE(icsk->icsk_ca_ops, ca);
 	rcu_read_unlock();
 
 	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
@@ -253,7 +253,7 @@ static void tcp_reinit_congestion_control(struct sock *sk,
 	struct inet_connection_sock *icsk = inet_csk(sk);
 
 	tcp_cleanup_congestion_control(sk);
-	icsk->icsk_ca_ops = ca;
+	WRITE_ONCE(icsk->icsk_ca_ops, ca);
 	icsk->icsk_ca_setsockopt = 1;
 	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
 
diff --git a/net/ipv4/tcp_dctcp.c b/net/ipv4/tcp_dctcp.c
index 274e628e7cf8..99f68c2992d0 100644
--- a/net/ipv4/tcp_dctcp.c
+++ b/net/ipv4/tcp_dctcp.c
@@ -111,7 +111,7 @@ __bpf_kfunc static void dctcp_init(struct sock *sk)
 	/* No ECN support? Fall back to Reno. Also need to clear
 	 * ECT from sk since it is set during 3WHS for DCTCP.
 	 */
-	inet_csk(sk)->icsk_ca_ops = &dctcp_reno;
+	WRITE_ONCE(inet_csk(sk)->icsk_ca_ops, &dctcp_reno);
 	INET_ECN_dontxmit(sk);
 }
 
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index f3fa0b18eda0..0ddfd5af6e58 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -507,7 +507,7 @@ void tcp_ca_openreq_child(struct sock *sk, const struct dst_entry *dst)
 		ca = tcp_ca_find_key(ca_key);
 		if (likely(ca && bpf_try_module_get(ca, ca->owner))) {
 			icsk->icsk_ca_dst_locked = tcp_ca_dst_locked(dst);
-			icsk->icsk_ca_ops = ca;
+			WRITE_ONCE(icsk->icsk_ca_ops, ca);
 			ca_got_dst = true;
 		}
 		rcu_read_unlock();
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index f2709d585edb..74727b7eb446 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -4092,7 +4092,7 @@ static void tcp_ca_dst_init(struct sock *sk, const struct dst_entry *dst)
 	if (likely(ca && bpf_try_module_get(ca, ca->owner))) {
 		bpf_module_put(icsk->icsk_ca_ops, icsk->icsk_ca_ops->owner);
 		icsk->icsk_ca_dst_locked = tcp_ca_dst_locked(dst);
-		icsk->icsk_ca_ops = ca;
+		WRITE_ONCE(icsk->icsk_ca_ops, ca);
 	}
 	rcu_read_unlock();
 }
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b474d03620a7..006de39e8165 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3218,7 +3218,7 @@ static void mptcp_ca_reset(struct sock *sk)
 
 	/* no need to keep a reference to the ops, the name will suffice */
 	tcp_cleanup_congestion_control(sk);
-	icsk->icsk_ca_ops = NULL;
+	WRITE_ONCE(icsk->icsk_ca_ops, NULL);
 }
 
 static int mptcp_init_sock(struct sock *sk)
-- 
2.55.0
