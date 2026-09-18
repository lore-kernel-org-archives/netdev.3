Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99909547066
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 08:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789719734; cv=none; b=XRy5vVQjnB0McRONfJ6SKgk7cmXxPvII+CogXjrJTQVo1YckxtayUcSAqORwY47VGWbngN1BJiQK54OW8frS5ljS2JftkA5Dtp92eY5QWKP8g9FCfxYCbSzClxWs5f/1osP3+90oqFve4dBtZe7EiDClTCRKot0x7mNMPz+dhJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789719734; c=relaxed/simple;
	bh=gW/QEDiE6VLwH4UxdpiwjpAZeoyFLuxraN1v1LYGMtI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=VrNuTg69cFYQ4BiH1bwR8KxmmPQAbEnHmGZP/sGY0gfCdWkpVFfQTCq28SlOz/tnnYBwU+cNe/TYRkEdB6pr2GiudMU/TDKcPRulaAy30Enbb0EaxZdv2BYEMiWkmWpZrqXPHM3h8MRgeAvGTs6HoCcVRR+HQxgIXzqGYR7BPVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rHi+XhXr; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rHi+XhXr"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-39b6416441eso944174a91.1
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 01:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789719732; x=1790324532; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hMnObLzmte9hOLGSxUEe2hy2Vwd3bHyJ4siHx7UsLMU=;
        b=rHi+XhXrii9TpxjtvRcessrt8Iqg36eiq0qC3LX2Jpe94RVkrqrJ+uQxzHezDzunx7
         RhNFTNIdSMJS929f9gr5OgLybhl1rvIQxJZsiiEXC5F3ln/NZhGVrkDAx9R5WiHaagLa
         wOe32E8ILu/p7o9xvhHzdxed6yxZU3mQOOxXpVQj2jje0LPWJFopaN1yOTd7GsUAlSme
         ckmWftdQ3itWgnSgzEb/7SLtmqlVmFilaT4OKz9JPSbKdzZmtgCS343Xk5Ma+fk5884X
         jDWnvfWAIbQ/+lqyw/DlybsvbzthoGQRx/GZ5mWpuNT2VYtuiux716uvdEZheFyn1tnu
         4OXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789719732; x=1790324532;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hMnObLzmte9hOLGSxUEe2hy2Vwd3bHyJ4siHx7UsLMU=;
        b=Yo9gLRmbpjm9rJJtgTuijfhRePmjTe2nKuJo3o/4wQurcU94gsVxU8NlRjXM+USRnv
         acQ3bOuMpoBhu2sQ3WpI7d4hD73NvARU2ikrwt5UxctZ8zFt8Ni8pA9C1WEdJTobfUBl
         WzbS/XieryIeOE5podoDGgF/Xwxbap1Fu9J6J7BAvbumH1mY4GOU+vVMUVLKyiU9Po29
         7eugvtgDZZx+AspyZlmAIpKOfWC8T0vN2KMqVr6hxBx3PTThQ7+VqC6yDeJLkTbBenl6
         Ut9pqx0McimiZR1ym93plteU+zgv2XuCkVnENk+1wcW/2QTDUN3wwuTzTkdj9gxlCw6C
         dieQ==
X-Forwarded-Encrypted: i=1; AKwUvByvEdWdkJIJzQnMoq3/I3wvKyx6H0QkVc6j5gjC9cpkVKMKgiJTps9+k1b2msD46VQNQQooHkM=@vger.kernel.org
X-Gm-Message-State: AFuF++mlNOYOrQCYGm33FbawMJBMbrry0HZzp9ok9wMV6CdhoNL3+4mk
	ZNDocZSvqQ3mLb/9XhR8X//oD06bDywxG2uBHmVJTsM4ZhXJn+dB4MOgUloOipEF7sHk9V/D/uV
	40+lC0Q==
X-Received: from pjqo22.prod.google.com ([2002:a17:90a:ac16:b0:39d:9b7b:e73b])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:574e:b0:39e:1fb6:9659
 with SMTP id 98e67ed59e1d1-39e54f0772fmr4283565a91.22.1789719731573; Fri, 18
 Sep 2026 01:22:11 -0700 (PDT)
Date: Fri, 18 Sep 2026 08:22:05 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260918082209.2853582-1-kuniyu@google.com>
Subject: [PATCH v1 net] ipv6: Prevent rt6_insert_exception() for dying fib6_info.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Marc Harvey <marcharvey@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Before the cited commit, fib6_nh_flush_exceptions() always set
from->exception_bucket_flushed = 1 under rt6_exception_lock to
prevent rt6_insert_exception() from inserting a new exception
for a dying fib6_info.

The flag was replaced with the FIB6_EXCEPTION_BUCKET_FLUSHED
bit stored in nh->rt6i_exception_bucket.

The problem is that now the bit is only set when the bucket
is not NULL and fib6_nh_flush_exceptions() is called from
fib6_nh_release() after fib6_ref has already reached zero.

If rt6_insert_exception() is called while the target fib6_info
is being removed via fib6_purge_rt(), a new exception could be
created successfully because rt6_flush_exceptions() no longer
sets the bit.

This creates a reference cycle between the fib6_info and the
exception route, leaking the fib6_info, its nexthop device,
and all per-CPU routes in fib6_nh->rt6i_pcpu, which stalls netdev
unregistration.

[   34.680602] unregister_netdevice: waiting for gre6 to become free. Usage count = 68
[   44.920675] unregister_netdevice: waiting for gre6 to become free. Usage count = 68
[   55.176582] unregister_netdevice: waiting for gre6 to become free. Usage count = 68

Let's call fib6_drop_pcpu_from() before rt6_flush_exceptions(),
to set fib6_destroying before rt6_exception_lock, and check
f6i->fib6_destroying in rt6_insert_exception().

Note that FIB6_EXCEPTION_BUCKET_FLUSHED logic is dead and
we can clean it up in net-next.

Fixes: cc5c073a693f ("ipv6: Move exception bucket to fib6_nh")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv6/ip6_fib.c | 2 +-
 net/ipv6/route.c   | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index 9ea75703b38d..9ff761962b45 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -1043,8 +1043,8 @@ static void fib6_purge_rt(struct fib6_info *rt, struct fib6_node *fn,
 	struct fib6_table *table = rt->fib6_table;
 
 	/* Flush all cached dst in exception table */
-	rt6_flush_exceptions(rt);
 	fib6_drop_pcpu_from(rt);
+	rt6_flush_exceptions(rt);
 
 	if (rt->nh) {
 		spin_lock(&rt->nh->lock);
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index b18cd0d9148c..5c898bfc4bd9 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -1729,6 +1729,11 @@ static int rt6_insert_exception(struct rt6_info *nrt,
 
 	spin_lock_bh(&rt6_exception_lock);
 
+	if (f6i->fib6_destroying) {
+		err = -ENOENT;
+		goto out;
+	}
+
 	bucket = rcu_dereference_protected(nh->rt6i_exception_bucket,
 					  lockdep_is_held(&rt6_exception_lock));
 	if (!bucket) {
-- 
2.55.0.1082.g2b9226bbc0-goog

