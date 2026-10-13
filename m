Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46357522EE6
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 20:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791925103; cv=none; b=Lyq1nxRyinPAGP+P+YtMmrbdSPjPY5bP2kOkKwpA4I/C7fwSMnTj159dAR9bFPBKadsJsGOPSSqonU5KrD73sJVAQTRsDQWvHfgkMobiSqHnhawIxwGIBQ0TADcCVspRbZEKmw0fgJk0n0sq6QpBbCa+SmUUfMKIY8+ADWQHiCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791925103; c=relaxed/simple;
	bh=petAd7XzmNHM0grZlhV/eVZCQ7bvLvwwwq6TkiVtTYY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hB44wI1MPnD/szMM2JPWI+idZaSCzGKUDAEliEaXWTcJyOyIpRkPUe7C3zW3nOH+VExmxlb3oZz5+fexFUAx1/G8K6yUTmRuEadtIg7psKOG+/rBcwry3ylmrLh+giYcMr6asXcTI9HtpXpYkdZDokgOFy++GqBdWD4DO3snSHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e2kqCtwV; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e2kqCtwV"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2df8d1e91c9so68994285ad.0
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 13:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791925101; x=1792529901; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EZm2/haaPoBuSqzrjPK+EqzAcf5RxBSPc7+1bZSaQdc=;
        b=e2kqCtwVhaNw5J4JZj4eAQvYlCFl+GYG8QVCmq1y8xvP7mIkdoosfsr843vvJziMm8
         UnKDV+kWzSrFeSTOi5EvCJqkFS5wJa5BwJp9lc2P0B0iGrdeCbNYLg8JXMhRWRVIK1lm
         T5M0dA9cOjq6jO5j+FYLVNLpE9H6XwuHZnzvYev39N2IoPC1nqJpFRZYn++/YeYR1bfC
         27ujPQ5KgI5iC0db78VM1RGr8hQe5EShrRUu/5XgCza1XYmgGadyR9fnD+P/nytXyyLA
         ZXkND1siSDKB8zDwMBgJGu7zlda1Y/MjhOetIKgYlMYOPWv/t45zS20TgHv+YmodttOo
         mViw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791925101; x=1792529901;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EZm2/haaPoBuSqzrjPK+EqzAcf5RxBSPc7+1bZSaQdc=;
        b=geOYYGHI4zN0LA0vl1lRNaLuZwhTN0IZf3RwF7sEc4ahELY3K8aXZp9MN/yz5hCePX
         RKPdwllXJde+da6AZC80j2lZZxWXmy36LsSqUVfwmCz9uvxeq6gvMkesgFnAgdH86oEu
         r0iZ28C8qQLEtxPwEBXg0tYYN80248wJgNvJB/CUXcCVlNjfxYJ4SAlG63okawGAIOmN
         JV9zLVGCO9ovOnvRiUm+lFRVxB1+qpXIY23MGJGCR/O2nAzef3lgOWKF+sO7wsfVtJO1
         8a4BfxGfOnq8cwoS7QREXgJRcMdqvX/UkJbDQ7zfcwiCzPwQNTSERjyd4OvB4jM0MzKZ
         Gopw==
X-Forwarded-Encrypted: i=1; AKwUvBxE9yE+7+tqVAT3XqM4lCo6ftl9RGDhruZlqCwaoWJ/+hSmXmlvoRgnSvdtDp10dJ3QduTCgkA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIxOEcZWL9uU3Og12ZzcTCw+76d21LyT4CfoaSsL/TKEnZvpvRT
	7T8qqSaGnLXHUoEc/Yb8ZkdO20OWhuFQ23ZAgkX5DHw95m80l321Zr5r2IJzOvVKQ2rGs1LgtLx
	nvDtNZQ==
X-Received: from plnz6.prod.google.com ([2002:a17:902:8346:b0:2df:8ab5:8354])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:15c8:b0:2e2:dc6c:a6d6
 with SMTP id d9443c01a7336-2e842aa60cbmr111973015ad.16.1791925099862; Tue, 13
 Oct 2026 13:58:19 -0700 (PDT)
Date: Tue, 13 Oct 2026 20:57:27 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261013205816.1642597-1-kuniyu@google.com>
Subject: [PATCH v2 net-next 0/5] neighbour: Misc follow-ups on per-netns
 neigh_table series.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Patch 1 updates the switchdev doc, s/arp_tbl/arp_table(net)/.

Patch 2 updates a selftest for per-netns sysctl knobs, though this
is not an actual issue since the test does not hit gc_thresh by
default.

Patches 3 ~ 5 are based on a suggestion by Ido Schimmel to make
neigh_periodic_work() and neigh_managed_work() CPU-friendly:

  https://lore.kernel.org/netdev/20260902143023.GA3966681@shredder/

Given it's rc7, I'll defer RTNL removal to the next cycle.


Changes:
  v2:
    * Add patch 5 for neigh_periodic_work()
    * Patch 4:
      * Update commit message (rephrase 1st and add last sentence)
      * Add and use NTBL_PARM_MS_MIN

  v1: https://lore.kernel.org/netdev/20261012194530.3751034-1-kuniyu@google.com/


Kuniyuki Iwashima (5):
  Documentation: networking: switchdev: Replace arp_tbl with
    arp_table(net).
  selftests: netfilter: Set gc_thresh[123] for gw netns in
    nft_nat_zones.sh.
  neighbour: Schedule neigh_managed_work only when needed.
  neighbour: Floor INTERVAL_PROBE_TIME_MS at 1000.
  neighbour: Floor neigh_periodic_work() interval at 1s.

 Documentation/netlink/specs/rt-neigh.yaml     |  2 +-
 Documentation/networking/ip-sysctl.rst        |  2 +-
 Documentation/networking/switchdev.rst        | 11 +++---
 net/core/neighbour.c                          | 31 ++++++++++++-----
 .../selftests/net/netfilter/nft_nat_zones.sh  | 34 +++++--------------
 5 files changed, 38 insertions(+), 42 deletions(-)

-- 
2.56.0.385.gd3acb90ef8-goog

