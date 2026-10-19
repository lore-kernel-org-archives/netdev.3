Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A316A35966
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 03:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792380681; cv=none; b=jscZ2iU9+Ecsvzg8yRalP2AnGIJfF3cvBoasZNulcngo3YjFCbvtOQWFGAds0AsjUJ/vb8UJrGj4Ndqil+n+6Nvds8pj6XR57Goyki6gLkKaf4dPMCgL/DHOgas+vuh89sLHAw5neTBGy4plRXqLHn7nYWcX3sMKqfOgRVu8WAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792380681; c=relaxed/simple;
	bh=WFXDw7md9ui1Ib9gfrWTU3ajOZNeKpSi6VkFxyR9T94=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jPUnMCfA2ai9SADheNYlnEnuEqb+jp13o0CtYNmF+dGPHzbiqhVKCfzQORGMLXNzuC+NtJiF0cPXG7Xg4fMJeQzXfLm4PnmAE20xqtV4wDqQtkRcpfsE6NQWAnmCpXTmMHKvFw1uuHHfWPuUylZ4z7kwAUG5fCo1w4m8EP3Yj4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=crL4GUM0; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crL4GUM0"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-35aa0cf7c40so3367398eec.1
        for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 20:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792380680; x=1792985480; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nrG60oAIFb6S52FKE/772lcTbr1UCldAoRmJ7HVPI6Q=;
        b=crL4GUM0Z5td/KYqaE2A1Tm+fJ/+dolB6IJbO7h82YnNHRe0HQ0ek6awmO20HZUH0I
         KPO+B1LIoIH2i0i0/UPG1QjC2nRAFMLIckIHKVwz28iL63LCbJ41OboybGdbT1cg78vv
         HKsz5TbqzjmqHzGYhwjxSq00PPH/3+En0bzgHntFW/CW4XWPHnxYxMT/tfmt5V1AuClk
         1Q+4+LxiY4017h+6Xi/myhtr6wL21AncHvTrbisMTK5+NodE26gUlzBL+j6NaIjKVOQ4
         jJtKZqxNilhPbaQ4C49wk5CXP3Pejx0GHu4SpltNecUzHPWb1oTWWOl0tCj0FkoAz+Tl
         mNKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792380680; x=1792985480;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nrG60oAIFb6S52FKE/772lcTbr1UCldAoRmJ7HVPI6Q=;
        b=rL50K18J9VyGL9Jn/amhu34bjwR4mjmubN1tkncQWxlRLF222+jYjs0X57vcG9/4Ot
         AJdzLGCXNjveN/JfK88d1KMVB+r5v/v2m7rAComXMg0Qfta8NF98dKdScMJC2feDZ68n
         u2YnD9sLhN6QwqhC0kGoTRhiLiS96lUNdGBZXF4DrNo3onCFnPGC4rrD0jOL2gZcUY0c
         2Kdlh3u05F7wk4wetbdXHPnVaRxoiva4v5/qLI45m6cYSE+Lr2oIKe/7aTAJWo10GtHZ
         5pzajd9jOnJEgvwuLJ+m0G30ocN83++IahArgErddr7hGqM+/E0Fn40k5sgCDKi95Lq3
         PGsQ==
X-Forwarded-Encrypted: i=1; AKwUvBw6bb5HvFtySL/i+GsnDw1Cb3PbiB4R8HUP4DovvbbGmFyANoDwj0oPh3cfpWUytqRI/cBaLYY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJn92nmrqdpIy6WzuoS35GDaCuySpyXdRciWW22A0dutbhIk0+k
	nIHm/rhHR2JgeCLvYvu8hT8jCis/B4QymeLYfDZN+GGBFby3CnE7kj8h
X-Gm-Gg: AYBFou19lPYwpDWyo02WY6uEUJub2YG4SVpFgJuI1C3xCGUUvm8AqomQEKWLQTOtGXI
	hQjpQ8CdFAwRvxa/Ba0aih5T2LHfTgpIf5Bp9fVtRCqLZ2FhWMTQ7QGUcikW+AKxATXg+YWbAe9
	2qyZ4kf0PIFZe1cd/B1G/r2JU77XzoS7IpnzxDiqSktdPfAjOhs5Hn+LbhxB1MOoA/wUE6E+fUJ
	7aJFZ7VCyHSyJDGZXbTuLJV5xizg3yh0PPGe4iDzaTiYcNoo0LvDL3fx4w7uXGiXB3dUlOr8qd0
	j6evbyFp0bJiNOzXYAfJE71vpv4fSiF43AbzCZRC9byL+Yh76LOqPZxXrsR8XFhiJEcemDPYWT9
	VZkXiHf43pL0eoSsrjgPwNnVpKqSYuw2yL7Pnc9YYj3V3Ofv52iFuct+zcC9haP6q0J+S/RLekx
	35V/jO33l1N41gwFK8PbEi7hDl8DsPK1yC/GtIqRpIqQgk4gZq1Ne3zQGTGz6lfc1jbA==
X-Received: by 2002:a05:7022:ea9c:b0:148:bc4a:8356 with SMTP id a92af1059eb24-185134de95bmr9264716c88.28.1792380679628;
        Sun, 18 Oct 2026 20:31:19 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-183190aa7bbsm24066888c88.5.2026.10.18.20.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 20:31:19 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Subject: [PATCH net-next v2 0/3] net: make moving a device to another netns
 cheaper
Date: Mon, 19 Oct 2026 11:31:14 +0800
Message-Id: <20261019-bug-net-netns-move-rcu-barrier-v2-0-b6eb7780c492@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAKP1WoC/42NQQ6DIBREr2L+ur8BrQhd9R6NC0VUkgrmo8TGe
 PdSe4EuZvEymXk7BEPWBLhnO5CJNljvEuSXDPTYuMGg7RJDznLBGRfYrgM6s3zjAk4+GiS9Ytt
 Q+iHslJJaFKqUBYN0MpPp7XYKnvDbbQvUqRltWDy9T3PkZ/+vJHJkeONl1VVKilL2j2Fq7Ouq/
 QT1cRwfm5qPItYAAAA=
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

Patches 1 and 2 draw the IPv4 rt_genid and the IPv6 fib6_sernum bumps
from sequences shared by all netns, so a cached route no longer matches
another netns. This fixes that leak for nexthop objects and leaves
nothing that relies on the barrier. Patch 3 removes it. Patches 1 and 2
fix bugs that exist today and can go to net on their own if preferred.

Creating 400 netns, each with a veth pair whose host end is moved back
to the initial netns, a tap device, addresses and routes, median of 5
runs:

                   before      after
  1 thread        68 /s      385 /s
  4 threads       74 /s      368 /s
  16 threads      76 /s      263 /s

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
V1 -> V2:
- 2/3: keep the initial fib6_sernum of each netns and never hand it out
  from the shared sequence, instead of drawing a value at netns creation
  (Eric Dumazet); 1/3: do the same for rt_genid
- 2/3: note that fib6_sernum is no longer monotonic per netns (Eric
  Dumazet); 1/3: likewise for rt_genid
- Drop Kuniyuki's Reviewed-by from 1/3 and 2/3, which changed
- Rebase onto net-next and remeasure

v1: https://lore.kernel.org/r/20261016-bug-net-netns-move-rcu-barrier-v1-0-4157d798658f@gmail.com

---
Qiliang Yuan (3):
      ipv4: draw rt_genid from a sequence shared by all netns
      ipv6: take fib6_sernum from a sequence shared by all netns
      net: remove rcu_barrier() from __dev_change_net_namespace()

 include/net/net_namespace.h |  5 +----
 net/core/dev.c              |  1 -
 net/ipv4/route.c            | 20 ++++++++++++++++++++
 net/ipv6/ip6_fib.c          | 15 ++++++++++++---
 4 files changed, 33 insertions(+), 8 deletions(-)
---
base-commit: 98c2ad4f5d805dbc1ea436a334ee59311806a48c
change-id: 20261016-bug-net-netns-move-rcu-barrier-d998c6395830

Best regards,
-- 
Qiliang Yuan <odys.yuan@gmail.com>

