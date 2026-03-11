Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0591329B764
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 05:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773207000; cv=none; b=AKLFgCQEyLuVzeQGzilSoTtUSjVgYuUE7bdlq92gzx9zPq7RxgXHAgP15avaRm0Hd5NNpYOK59UBVNtVAysFl3f/oDKUfx62NIW7w/Y0WpVfvi48pnm+nhiOCR2XlErARZSjGQYTrpqsspwm1YX627KUOekYixRbsgvap27TrKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773207000; c=relaxed/simple;
	bh=Ordf7P/Sjom3ptozveXomUwpCr8x6aATyjBasWGkrUE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nsgZfW5i0BzMi0OhnK/AaaQrsthZuW5rSUUtCZ5BdG4yIugGNOs0GVavbttwyyoGc/1GIIa7mILQHAgwdVk/bhsPWXzkem0Q8FLAeshz/BzjWWA3aM5UcsQnK+2hMOahQYY5fzPBy5An0XzIKXKD4YEE5JUTSXBWVzCKWpl5EfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xFqBMc7Y; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xFqBMc7Y"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b6097ca315bso60464987a12.3
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 22:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773206998; x=1773811798; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wxFZeZESE8WAkXsZFCOxbXUnQ1XrG2dDzjwSD18ti74=;
        b=xFqBMc7Y7OmzWmQmYoevmFKZqbeT/DrhS/KilgtEpv03xwYsTaiZy5CXpQ5AGtwvAe
         ADUChxm+nKPdlAYehTDTjnZuYKZOfg3XFnYHv9AIubIYB0KNMZd7cacE31gH0rmSh+5G
         +KIpbSS0lq6usn/Vo2HKlFNsulAryCjnMQx84/tA7T7OzI0TTsexzxGtVD6L5+3bbtOT
         Vwew+CbmX98M5mUAd1foPz4hQ4v4ShdA7K3CMjluUfuGRCWirEonh2tVJ4WwFH6txw1R
         G7bPlBiPH87CLjC50LNebil8bFaFvzNO/gjj5H2We6XrVvDnvCp0vOqBUTlb85fW836t
         s1dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773206998; x=1773811798;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wxFZeZESE8WAkXsZFCOxbXUnQ1XrG2dDzjwSD18ti74=;
        b=dQCiPxTCoiL0dmuUgYUmobnIJdjiMS1BVhEHsF+LLJvIYZ8ml08WnLdZuwEcqm1wHY
         AHSIVH3/Bza8WB7WOoh0swKLraIFFlRI17OdMOBIaFauf1uOhbaZEyyuDsHtZwXIxuH4
         Rr5jbIkEXawaF9pBmZIhH8S1bd5j/r0lHNWViK7ZORQyY7YHySV5KsOi1FUKPOaLiBMu
         XcHO0YsKBJNUS6rM+8iQCEKigEV9oa9XnZ7na6sdeSuWxsezv51gC8t+SzGUrDQ8jGgi
         UVaHOBhlLON8Mn2kZ8XXXeTC6ITANZEPg3Y4/ej49vBhNm3wS/aTdhwifO1HlZw6I7da
         TtDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnv1/yHCldcBygV5iPreW4UEhGeU50JrLq44LUZKZXMvxS/rg7Ziw7uqO4V+k58czq8p2mTvI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8ncat10L8rc3Af/XWBD/vpfLrTLhrEWVQ4fhJaBZQQGq5v0M/
	xcRfQRhjdZzJirGVy42L4Pv6KmqAYf1o2h8GAfjWMM6ZhwW3iDhy9qfYGHJoqN9vxqKWs9is912
	iFyAEag==
X-Received: from pgbcs13.prod.google.com ([2002:a05:6a02:418d:b0:c5e:38a3:151a])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6e92:b0:398:b8eb:670d
 with SMTP id adf61e73a8af0-398c617ee5fmr1110486637.68.1773206998235; Tue, 10
 Mar 2026 22:29:58 -0700 (PDT)
Date: Wed, 11 Mar 2026 05:29:42 +0000
In-Reply-To: <20260311052954.1224278-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260311052954.1224278-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260311052954.1224278-2-kuniyu@google.com>
Subject: [PATCH v4 net 1/2] ipv6: Remove permanent routes from tb6_gc_hlist
 when all exceptions expire.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: David Ahern <dsahern@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Kui-Feng Lee <thinker.li@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Commit 5eb902b8e719 ("net/ipv6: Remove expired routes with a
separated list of routes.") introduced a per-table GC list and
changed GC to iterate over that list instead of traversing
the entire route table.

However, it forgot to add permanent routes to tb6_gc_hlist
when exception routes are added.

Commit cfe82469a00f ("ipv6: add exception routes to GC list
in rt6_insert_exception") fixed that issue but introduced
another one.

Even after all exception routes expire, the permanent routes
remain in tb6_gc_hlist, potentially negating the performance
benefits intended by the initial change.

Let's count gc_args->more before and after rt6_age_exceptions()
and remove the permanent route when the delta is 0.

Note that the next patch will reuse fib6_age_exceptions().

Fixes: cfe82469a00f ("ipv6: add exception routes to GC list in rt6_insert_exception")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Xin Long <lucien.xin@gmail.com>
---
 net/ipv6/ip6_fib.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index 9058e71241dc..fadfca49d6b1 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -2348,6 +2348,17 @@ static void fib6_flush_trees(struct net *net)
 /*
  *	Garbage collection
  */
+static void fib6_age_exceptions(struct fib6_info *rt, struct fib6_gc_args *gc_args,
+				unsigned long now)
+{
+	bool may_expire = rt->fib6_flags & RTF_EXPIRES && rt->expires;
+	int old_more = gc_args->more;
+
+	rt6_age_exceptions(rt, gc_args, now);
+
+	if (!may_expire && old_more == gc_args->more)
+		fib6_remove_gc_list(rt);
+}
 
 static int fib6_age(struct fib6_info *rt, struct fib6_gc_args *gc_args)
 {
@@ -2370,7 +2381,7 @@ static int fib6_age(struct fib6_info *rt, struct fib6_gc_args *gc_args)
 	 *	Note, that clones are aged out
 	 *	only if they are not in use now.
 	 */
-	rt6_age_exceptions(rt, gc_args, now);
+	fib6_age_exceptions(rt, gc_args, now);
 
 	return 0;
 }
-- 
2.53.0.473.g4a7958ca14-goog

