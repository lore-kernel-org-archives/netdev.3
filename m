Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685681E98EF
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 06:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792131001; cv=none; b=FeAuNeHmncEFMO267hk1VF2hQ6b+1vblGZlL+jUVOSLi81vd1Da84d4iBGaWh0CRwlmKiBYWqI/VKI6a9TN2EQWEzaTjv6bEfOYvSiaYsUobAVs6UskF7EPH6MAPsZrt4BEnnC7UC9QEkQpvw8tgPkIVauUe91L1r7s43V2g6Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792131001; c=relaxed/simple;
	bh=DqG2AIGPL1uGXvBJhqSHPSDtvVR7TWwuzpI0OdCQ/xE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CojyPCWKUNAkAs6R1H/SN53tKa4jCBPv3ol1wsOqJkCYmSLehAdel5CgjPPFNXhfXYQnaW0tJYpAQPc0x1oIQkNOaUe2GWs9CxuM/jJ4e5PatG/ARW+4uezbmQRknkuQPvFDnADXpyRzpUoiEKGV77eYW4Tg8Crb7LjkI1sG4Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=omF1nW6M; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="omF1nW6M"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-17bc533fda3so3017117c88.1
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 23:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792130999; x=1792735799; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gwEs0x+XqCChaDuPK/8cuCgIucGP91NXK3xMck8OY0Y=;
        b=omF1nW6Mb7kFmQb7/yrueN4kDQZIiqwvhrZNrPPLcJKDHlZHoqmNHyfnwuDuZkJoHy
         BqNen+ojI+tkPuhTis7JYR6s0+W1TPjbHxcnh15HpO8qheuwMkQrFHC6f3q9i9babTDW
         BbWCs6tghYxhovwctsfuB8JoUc70VwJr2X4X+ffC/cL0xfNbw5sr8ntZVvAhluMyJ0Mj
         ZnehJuMq67gZ0jef2h4ZBzuW4VeBIP1M/CVKQJd30t8OyI041ykmvbjH5xoQ2oyF0YRD
         4I9SHJbVpG0vrBK3PDvUroaSKzCU+HAxCRZADHPcsE/oOPxKP5cnAFIOw9Wq1qAd12iS
         W75g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792130999; x=1792735799;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gwEs0x+XqCChaDuPK/8cuCgIucGP91NXK3xMck8OY0Y=;
        b=TuTV8057se8BFR2VO14rSjmLo+Z9EVZX8CEqhvPK/eVm+P+z1/pxxiXfVXFi7JzYSS
         pFIiNysF2UaoQ6KkFwe0It5I1OPmjLHvU/vwnjmK9e4LUV7TkKVFIvhCJFfJODZ9KY1k
         GCJhr82szTbzVhv+HImmg8wGOeJoo06JlUI+9R0lAZGp8Tk07e1bCx5L+UxfRi3FBBNu
         YP0YzxuYhKn4dxoqr7qnSE38vm8iGpAnqvgBy5ETNwNq9LILEdxWF8GLNHEXNftIiDNw
         2krYGqS+Hzu4bcKj2ByiVdviyRpYx+F3X147tBbhP8I8CJiux/nHII+MRlsY9NTKijct
         twOw==
X-Forwarded-Encrypted: i=1; AKwUvBxCmAUzxOnpMlzfLQJaKLjwO6aHMDOCgKo0II1WIPMNDIG/nik58PzuZOOjOSm9KiMJFT4ACHA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLFHdwosgX36OqIMImWTqG/swmK/6KDWZ8I9KUDVgUTzfM5TtFb
	8U2MeNcfgO1wt/IPsr5nLJk2P6uycFFq4B80gwuaRjwX/hfTr12bYubT
X-Gm-Gg: AYBFou2YEccN79VaGgtJmKuADJP78oiLGG4qipYjYrLfTOPN288gseuDwjGoYJwkcR8
	irpKdygFa9dUltUP3gEaJqyis6aB4XX2XxFpxH1WpT5KCUSwJadSk7clIGKwELvrfFNrHoxiqjk
	XRLJX02SKrpu/hfkZd3mBXyRoKxIyEV0S1cfLh5SyxEse8mPRYXK9t94JlIyA55Wg48S0n21ooS
	dPXa69Qjpk7DPasqI9E9Os9HOV6Tkxs/HFCtzdPgUwv3jtQcecQcunW94idA7YkSieiMdV+Huov
	ME4FqdGeWlYcAH5tDDsoYrbHF6rKLgKzHJ2qX2/Z6iGZ1pfPHkporrwKy2cBaon8dJ4M2tX++yL
	Ykojo/RPrT5A9hyWjp48/ht1zi323Gr28nyz3lOilm2XahwNHOBkzbg07xPjiSpsVWPXpaoLc61
	95ggwhvUqgvJFAm0dkicqTaR5S8i45+1kYZygHhtBs4ikm0TWyqtMHzn6G+QtlHW8EEA==
X-Received: by 2002:a05:701b:230c:b0:143:2967:c0b1 with SMTP id a92af1059eb24-16a5fc91121mr29007550c88.25.1792130999447;
        Thu, 15 Oct 2026 23:09:59 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-183190aa411sm3309068c88.4.2026.10.15.23.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 23:09:58 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Subject: [PATCH net-next 0/3] net: make moving a device to another netns
 cheaper
Date: Fri, 16 Oct 2026 14:09:52 +0800
Message-Id: <20261016-bug-net-netns-move-rcu-barrier-v1-0-4157d798658f@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALC/0WoC/yWNQQ5AMBBFryKzNklLNOoqYkENZqFkikjE3RWLv
 3iL/94FgYQpQJVcIHRw4MVH0GkCbmr9SMh9ZMhUZrTSBrt9RE/bOx9wXg5CcTt2rUSPYG9t6Ux
 uizJXECWr0MDnF6jh/50bNPf9AOPA0V56AAAA
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
 Nikolay Aleksandrov <razor@blackwall.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Qiliang Yuan <odys.yuan@gmail.com>
X-Mailer: b4 0.13.0

Moving a device to another netns waits in rcu_barrier() with RTNL held.
Container and sandbox managers move one end of a veth pair for every
new network namespace, so this barrier limits how fast such namespaces
can be created on the whole system, to about 75 per second in a 16
vCPU guest no matter how many threads create them.

The barrier was added for NETDEV_UNREGISTER_FINAL, which is long gone,
but it still keeps cached IPv4 routes through the moved device from
being accepted in the old netns. Routes through nexthop objects are not
covered by it: their cached dst entries are released by an RCU callback
queued from another RCU callback, so a socket in the old netns can still
send through a device that now belongs to another netns whenever the
route generation numbers of the two netns happen to match.

Patches 1 and 2 make the IPv4 rt_genid and the IPv6 fib6_sernum unique
across netns, which fixes that leak for nexthop objects and leaves
nothing that relies on the barrier. Patch 3 removes it. Patches 1 and 2
fix bugs that exist today and can go to net on their own if preferred.

Creating 400 netns, each with a veth pair whose host end is moved back
to the initial netns, a tap device, addresses and routes, median of 5
runs:

                   before      after
  1 thread        67 /s      440 /s
  4 threads       75 /s      409 /s
  16 threads      76 /s      283 /s

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
Qiliang Yuan (3):
      ipv4: draw rt_genid from a sequence shared by all netns
      ipv6: take fib6_sernum from a sequence shared by all netns
      net: remove rcu_barrier() from __dev_change_net_namespace()

 include/net/net_namespace.h |  5 +----
 net/core/dev.c              |  1 -
 net/ipv4/route.c            | 16 +++++++++++++++-
 net/ipv6/af_inet6.c         |  1 -
 net/ipv6/ip6_fib.c          | 14 ++++++++++++--
 5 files changed, 28 insertions(+), 9 deletions(-)
---
base-commit: 6b3e73774815910a39d8ca75b9ad7df963f61d50
change-id: 20261016-bug-net-netns-move-rcu-barrier-d998c6395830

Best regards,
-- 
Qiliang Yuan <odys.yuan@gmail.com>

