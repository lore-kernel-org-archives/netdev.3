Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115C443FD2B
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 21:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788818340; cv=none; b=PbLb/5xJGPQunjSxr3RwMtmBS7etxO93LZnRxcHhI+QSngfwscZUDnb1hN378aaP21msSfnsUteBqg1BzbTJkQn9dDt8e0qk8gKkccJJ2MAnwjmDFkehY9YCCb5qprN6d9LSjUlyTSrGqUCi7UfAhSByS07L00ckKdJAoVHNbao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788818340; c=relaxed/simple;
	bh=aT9SUuT/c1bdUIhAl2y7fZiuHuXiwSee4bMuqOiN6tY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=i2j2D8KPunfvGW6avZhLtVkoJdi5N/GWm2+9JdrNUXfCUjUhQ5e2d+kytHVAN1bsqQDifyJgvnKhYQ8nr/UwD4KUqXZfbzoh0ARZBH6C16ej4COlv9F0LHnzdej+BNQeHbFJZ1PZ4OJykFY3HwXh84QNkQqk0eL6pjk3fWdvq+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZgqP59qU; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZgqP59qU"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84e1da97175so4588716b3a.0
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 14:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788818338; x=1789423138; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KosO5rx7BP4uFXBKo7QoYX/asm5ZIYmyaA5jwVRQ4dg=;
        b=ZgqP59qUH7VdAvwTMhbw1iOJfLtsO9eVC/wsGAMxT3xootPl45Mtq6tN/1gYQ8BBQu
         EjXUyjrMPqoLHzjK1g1dLUCEUP8QKLjDik1Nr9WSiy9On8r0KQdQONuDz/hDRZuUjRTa
         sqPCwkXugFhXB11AmZ1RVC1Q+6n+fSkCBDIeS15+3SE7wrxyAYNXGH+szGNOpr1m30iV
         O5RTuV4KUKC/kT3mI8O/827prOjUgceU6acuis/xRV/xNgcKdAiqSMvvOQgjrUFb8BQs
         ng6p2MJ409H4w5Jc6QKanzEAiCooQyrwSzqpxIsGKxxA8jsFPagn7syYp3XxL/lIyXTz
         EJxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788818338; x=1789423138;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KosO5rx7BP4uFXBKo7QoYX/asm5ZIYmyaA5jwVRQ4dg=;
        b=oaeOUkigcvysrNCG+5TuG3EoV83LvrIYjC8WAwKv17gJVtScMQC54sYccim9KnAmux
         bKldLGO4Qy44oExyxB8bkDrSuZinuxc/POXqrlzJMeIBnDpvqKGtlk3THQfAS5qitFgG
         UyX0QEK4kTXijpCI943yA+SHUlnw6SpJbyUWcLeGTHwUNY7agiD3oSVogF0Q8wSh/av6
         o+MC/kDWxtmcBX2BBUcR9Idkg89qri5J8FNVUyla5ym2XVkLjRvxXofSpeN7h1nBnYe9
         ylr6GvFAa52CleAJD+jzvbaasCBtqB7z8WBahA8sB0dxGynLFzDyzdcOElKwW1PvmS/4
         Es5Q==
X-Forwarded-Encrypted: i=1; AKwUvBxpU8hTv1MltX8SJXarTMQV8VOQ2LtTHBbwEqFfqDarrDUkflC2uzy2D1e3WJ/N88hiYrGksKk=@vger.kernel.org
X-Gm-Message-State: AFuF++mo35l6ZqxKLyNJh0zVPQhezAqd7GINkAaQjpu5cYVfE91XcT6L
	Yktf1uIXi0XJw1T4QOrYsTD8SiA3CuKemFyI8mHwCkdrdz4BJzlI0O86MUlum+7hxbI+oR5uU84
	tzCMhxg==
X-Received: from pfbfe1.prod.google.com ([2002:a05:6a00:2f01:b0:84f:6f80:bd66])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3007:b0:846:4d4c:23f8
 with SMTP id d2e1a72fcca58-861662d4c34mr36639091b3a.1.1788818338253; Mon, 07
 Sep 2026 14:58:58 -0700 (PDT)
Date: Mon,  7 Sep 2026 21:57:54 +0000
In-Reply-To: <20260907215853.3709987-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260907215853.3709987-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
Message-ID: <20260907215853.3709987-4-kuniyu@google.com>
Subject: [PATCH v1 net 3/4] neighbour: Don't render blackhole_netdev via RTM_GETNEIGHTBL.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Xin Long <lucien.xin@gmail.com>
Content-Type: text/plain; charset="UTF-8"

The cited commits started to initialise blackhole_netdev with
neigh_parms_alloc().

This is visible in init_net as the ifindex==0 entries via
RTM_GETNEIGHTBL:

  # ynl --family rt-neigh --dump getneightbl --output-json \
    | jq '.[] | select(.parms.ifindex == 0)
              | {name: .name, ifindex: .parms.ifindex}'
  {
    "name": "arp_cache",
    "ifindex": 0
  }
  {
    "name": "ndisc_cache",
    "ifindex": 0
  }

For RTM_SETNEIGHTBL, ifindex being 0 means wildcard.

Let's skip blackhole_netdev's parms in neightbl_dump_info().

Note that lookup_neigh_parms() does not need the same change
because the default parms is always the first entry and matches
with ifindex == 0.

Fixes: e5f80fcf869a ("ipv6: give an IPv6 dev to blackhole_netdev")
Fixes: 22600596b675 ("ipv4: give an IPv4 dev to blackhole_netdev")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
Cc: Xin Long <lucien.xin@gmail.com>
---
 net/core/neighbour.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 454a8b8f3aa0..b90957b630ce 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -2625,6 +2625,9 @@ static int neightbl_dump_info(struct sk_buff *skb, struct netlink_callback *cb)
 			if (!net_eq(neigh_parms_net(p), net))
 				continue;
 
+			if (p->dev == blackhole_netdev)
+				continue;
+
 			if (nidx < neigh_skip)
 				goto next;
 
-- 
2.55.0.1003.g10538fe699-goog

