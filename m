Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E188B3E123F
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 23:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787874918; cv=none; b=T0KP9Inug5Rg4HK2C0ZhygU3qyUv463DMe8SyqMc2lHn2RsZDNHHBY0Gq3oIJZtDsrVIOgFUDyUEmLRT/SIzl04EuWPRqnWSzbPgTuCQloKZFGjP/RDNvK1ySeBEM8tbpwhKbzSlLcp59at83cKspuTbRLEhVink5DSQyjGCBdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787874918; c=relaxed/simple;
	bh=povcfs+zEFwhtdLtyHZfkA0h8OxsjY5Ocq80rUw6ZxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lTo0TvHCK2kcc6v6291K6+ogd6g6yXp0FtyC8M/B48xFomcTXls+LXYPvfaCdq5trOOYWsrn6JCZ4+0vtHOH9q8/POu7RN0HOWMA9McM7gURXhvP1qx24E8PrhXz/LFQUu8i8i7lKwjMRzxJUZQv18tw3mZs8rHgQMwfve+z5hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iyVBhwaw; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iyVBhwaw"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-66d2529310aso497076d50.3
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 16:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787874916; x=1788479716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ibdqZhM5Iy57YHQTMa8QJ1pQX4PIL/iVkp9X2oZ/1hc=;
        b=iyVBhwawK3j7j6zJAioLy7GC6kEvCDiZAtyIqD/EbyZ8B3Y+6Si5wSw6vKsivaVHB0
         9v3OkTP/CLQtHsGp5V6NXwHa0bpekA4ofHKmPtlCiq+eehIqOizR1/LNWaIEyz+Hz25u
         koIl1h/AjpuLM+jGvB9J2zMYw7Z59NJIsdfi8hjuI/uIPHOSH1rBW6dHBg+Q8XD7/2cE
         G8Ow+Iyw9COr8y2BsPTiobbXv51AONgqcZudAlNQlo0uw/GktvAd6eDrwlBUMlxcXBvG
         9qRyvkNKrZR4RS43+erdgnpFZqPA+qiylerawQPQJeQEeAVVXJh6WpymObXTljW9vqUd
         agJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787874916; x=1788479716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ibdqZhM5Iy57YHQTMa8QJ1pQX4PIL/iVkp9X2oZ/1hc=;
        b=MWNh1ikoudkHSImYE5ZyJsiY5qt2yfppXlAf/k117kksKtl4hhJCd7NxQacjc9T1jk
         1UgTqEtNCEn6yLgt806ESfQcNGiErUnYykTVucsXMVa6+lu7BB4Wpwx8mXB9uqRMeMdq
         xnKumdOC9KAFJFv5fy2n9gxTZ4T+fy0K1+nCrYqL4RZg1/5g/46XvB5TCylo3sh6qkwv
         r87LsHCACXlyq3wRBMs9sXto+qciRZgHOqcVswl7fxD/c658/zoMNt9s1u07EY/X1/5Q
         e9obbfvOcdJvwdBwNNIQJhwnOiaYnKPsh8dT4TT0xeBI/R0J3j6XjOKhGpcgXUIgZkoE
         SAxg==
X-Forwarded-Encrypted: i=1; AHgh+RooYY8/oX1AGPUcUkr0RGHFundldzSPvAgjviEYnfzVLfa+ZwCjpADOXoEndWGJNg7lm6Mput8=@vger.kernel.org
X-Gm-Message-State: AFuF++ncVr0KAJa2HZ/WJaRaEIWGeM6OR9tNVYdgVyIE1//c+QSDLGDL
	aEc65JvdQ3rAt+l4yEzElLB5AZ3zLc9XoKKvVeQaOdJB9FwMMAutTY+t
X-Gm-Gg: AR+sD12WXRzwnfE3QtkO16ThBHgkncMrGCqfEfdaXHzpTWDPgrhkQH8/xq8nd/JWAEA
	OmqAxM0EwZCTJUYfLvZUKRLNkGbF2+KJhcMiViwWuxC5JXOEsnAp5fbScklCu2SfI+7pQwROzIE
	Q4hliIpNM/k6L/Dk+k2XYghFfb8aiM1qW3TAp8ZhgWFzqMBFO8C5qh6x/JN+NOEc6edEDpPk8aS
	zq4U6prUNIxWSJB26maKhaPQlNeunejmNg4+Ne7fEUiG4Whkqu+Q1puXuNWk4oTaMuwEWizieDz
	vFA7q1dMV5v/orvKQi7E3sVbURc1zxNHflZjX94D/wnA/ZVendwSQTs+J/7MTsgwHvzMc261nRp
	jwo2ab+G0HdxJPCZ1vFWNoAS6s+7aio1+Kj+gjuvjOpKYkRi9BfustmQo2w4CAkeK+SHaiml7BW
	UhQdP0tG7k1xxW54MBze1YmeVp9QH4+4/ljUMI+jRV/kOYP1J09J5mz57hECwRevegKbs=
X-Received: by 2002:a53:acdb:0:20b0:66c:f55f:cd9b with SMTP id 956f58d0204a3-66e4c75015cmr700353d50.46.1787874915812;
        Thu, 27 Aug 2026 16:55:15 -0700 (PDT)
Received: from mac.lan ([136.55.173.105])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66e4eb3dcdbsm55704d50.4.2026.08.27.16.55.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 27 Aug 2026 16:55:15 -0700 (PDT)
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
Subject: [PATCH net v3 2/2] tcp: fix use-after-free in do_tcp_getsockopt(TCP_CC_INFO)
Date: Thu, 27 Aug 2026 19:55:11 -0400
Message-ID: <65fd3816ed5d541d9edd4bf4fcf97104a2cf907a.1787870710.git.blbllhy@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1787870710.git.blbllhy@gmail.com>
References: <cover.1787870710.git.blbllhy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Cen Zhang (Microsoft Security FORGE Labs)" <blbllhy@gmail.com>

do_tcp_getsockopt() reads icsk->icsk_ca_ops and dereferences the
get_info function pointer without rcu_read_lock(). With BPF struct_ops
congestion control, ca_ops can point to dynamically allocated memory
that is freed concurrently, resulting in a use-after-free when the
kernel dereferences or calls through the stale pointer.

  BUG: KASAN: slab-use-after-free in do_tcp_getsockopt+0x2037/0x23e0
  Read of size 8 at addr ffff888013701258 by task exploit/149
   do_tcp_getsockopt+0x2037/0x23e0 (net/ipv4/tcp.c:4564)
   tcp_getsockopt+0x91/0xf0
   __sys_getsockopt+0xf7/0x170

Fix this by wrapping the ca_ops load and get_info call within
rcu_read_lock()/rcu_read_unlock(), and using READ_ONCE() to load
the icsk_ca_ops pointer.

Fixes: 0baf26b0fcd7 ("bpf: tcp: Support tcp_congestion_ops in bpf")
Suggested-by: Eric Dumazet <edumazet@google.com>
Cc: AutonomousCodeSecurity@microsoft.com
Cc: stable@vger.kernel.org
Assisted-by: GitHub-Copilot:claude-opus-4.6
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Cen Zhang (Microsoft Security FORGE Labs) <blbllhy@gmail.com>
---
Link: https://lore.kernel.org/all/20260821182449.79785-3-blbllhy@gmail.com/ (v1)
Link: https://lore.kernel.org/all/20260826171344.4133-3-blbllhy@gmail.com/ (v2)
Changes in v3:
- Annotate dctcp_get_info()'s icsk_ca_ops comparison with READ_ONCE().
Changes in v2:
- Add READ_ONCE() for the icsk_ca_ops load.
---
 net/ipv4/tcp.c       | 4 +++-
 net/ipv4/tcp_dctcp.c | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 55ca74f60..71d4c5e6b 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4561,9 +4561,11 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 		if (copy_from_sockptr(&len, optlen, sizeof(int)))
 			return -EFAULT;
 
-		ca_ops = icsk->icsk_ca_ops;
+		rcu_read_lock();
+		ca_ops = READ_ONCE(icsk->icsk_ca_ops);
 		if (ca_ops && ca_ops->get_info)
 			sz = ca_ops->get_info(sk, ~0U, &attr, &info);
+		rcu_read_unlock();
 
 		len = min_t(unsigned int, len, sz);
 		if (copy_to_sockptr(optlen, &len, sizeof(int)))
diff --git a/net/ipv4/tcp_dctcp.c b/net/ipv4/tcp_dctcp.c
index 99f68c299..5b457f68a 100644
--- a/net/ipv4/tcp_dctcp.c
+++ b/net/ipv4/tcp_dctcp.c
@@ -228,7 +228,7 @@ static size_t dctcp_get_info(struct sock *sk, u32 ext, int *attr,
 	if (ext & (1 << (INET_DIAG_DCTCPINFO - 1)) ||
 	    ext & (1 << (INET_DIAG_VEGASINFO - 1))) {
 		memset(&info->dctcp, 0, sizeof(info->dctcp));
-		if (inet_csk(sk)->icsk_ca_ops != &dctcp_reno) {
+		if (READ_ONCE(inet_csk(sk)->icsk_ca_ops) != &dctcp_reno) {
 			info->dctcp.dctcp_enabled = 1;
 			info->dctcp.dctcp_ce_state = (u16) ca->ce_state;
 			info->dctcp.dctcp_alpha = ca->dctcp_alpha;
-- 
2.43.0
