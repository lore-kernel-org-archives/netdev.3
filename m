Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.27.60.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793828780;
	b=hh/mBAv5AGhSbOSbp5uUb9zExyDpQ1GMsiao4+zjYFO+7U+WK4ZP8jdfBbkkFgEtVVgs
	 JVoe/tsd6nkrtOHfCQb2SAJnfHW5ceI1mx/Gp2lpnuLjehTjluKDNkc/qUZS4Uk03KhnX
	 4E6URhg3wdZr0reAWIbY2XgY/nuuNgTKibMv3+nuceRrMGGKCAJSwPtB2sM6A+VWnAqxK
	 XhOUhKwN/RcfxR/wZWn/0EeUQvrIg/I7lpWdWgN3j9J4T5GcfEwWAFCF819L6I88Atp0m
	 wDEWAUXe4uSbmwU+Xr5VfCRT7Zq2O3QObpf8H/lWtt+8GylVz7yjMokrIhqnyRpY2VA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793828780;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Ec5yxUyaEP25Q/oUGA4H4MV4YE5ouxLMYYhMfOZGe1Q=;
	b=hC+2HEyWzZ2/Dp7Cnz5/D0vronJrWmb8cnAAFfCjZ6VjZk3XbUJbX+VkVajNY2UzY6iD
	 hYheUABzeF/PAa3Fb7VTSZvWOxcf85yQ338sn1SAE7JfQ748yVQxP1G9Nvhuj9+TIJkml
	 ZVchaxjH4Mmnrj9LjPf3CpfVNNva3uXalNWnYneWDR/RTNeVYhBtf4IxNT84Dvry1Bzm1
	 jX/0uA6NxFTf0PN15rrVsG2pOjl/3T92uybiI5fYCo6F+OTSuccy1016yzPMu1qTT3L7G
	 nnZH7I0LrfWHd726QQUEAKpNSz24HBhNuHNV1V+z7w4WrSmevPIemlR0meYldSDMZhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=corp.free.fr;
	spf=pass smtp.mailfrom=corp.free.fr;
	dkim=pass header.d=corp.free.fr header.i=@corp.free.fr header.a=rsa-sha256 header.s=rcs header.b=cDeIPDmu;
	arc=none smtp.remote-ip=212.27.60.169
Received: from rcs.proxad.net (rcs.proxad.net [212.27.60.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E60606F280
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 21:46:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23E60606F280
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corp.free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corp.free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=corp.free.fr header.i=@corp.free.fr header.a=rsa-sha256 header.s=rcs header.b=cDeIPDmu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=corp.free.fr; s=rcs;
	t=1793828777; bh=kHccQU20VE8id2uLCz+zTe/NtLXqRcm03EMpvqiYi9E=;
	h=From:To:Cc:Subject:Date:From;
	b=cDeIPDmuIUr+fbQAj1haI22eC3sWqHM0aVIYrVUORA6hRik/ZjzyvfSBnE0A+QqnP
	 pBsz6x2RKaO5oj8KylaNVkS8puA4AqeH4f+4MjtsDw5rQYpdAotFTZQWL2wgkrcsAe
	 LLujOYi7VnFwLWsveebMjjyIUh1wuO2lSeOBc548v+qgXjJ7TU0igUNjI8hsbzvyxA
	 17mOGuh8TZ4BXQ9yu8Dc+M/SXv+kbh1a/knDohqgQCnf85WexhVybo4S3urFOgq9RN
	 v9CvmpoxPljfuS8UUoTVszcrdkrVLEZ69sUoHlzPa9re9RB/V96JsD75pAluiabV5y
	 /JIB6kw7FrOGA==
Received: from lnxos-dev.home (82-66-150-212.subs.proxad.net [82.66.150.212])
	by rcs.proxad.net (Postfix) with ESMTPSA id 0198344C007C;
	Wed,  4 Nov 2026 22:46:16 +0100 (CET)
From: Alexandre Cassen <acassen@corp.free.fr>
To: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Ido Schimmel <idosch@nvidia.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next v2 0/3] net/sched: let hardware only actions drop per CPU stats
Date: Wed,  4 Nov 2026 22:45:54 +0100
Message-ID: <20261104214607.556269-1-acassen@corp.free.fr>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series lets hardware only actions drop their per CPU stats and
the tunnel_key dst cache:

- skbedit, police, mpls and sample honor TCA_ACT_FLAGS_NO_PERCPU_STATS.
- Action init sees the offload flags of the filter, so a skip_sw filter
  alone now satisfies the skbedit queue_mapping check.
- tunnel_key skips the dst cache for skip_sw actions.

v2:
- Add patch 2 so that a skip_sw filter is enough for patch 3 (Sashiko
  [1], Jakub).
- Give the memory saving in patch 3 (Sashiko [1], Jakub) and patch 1.
- Drop the race note from patch 1. Commit 1800f27a5ef8 ("net/sched:
  act_api: take tcfa_lock for hardware stats updates") fixes this race,
  which Sashiko [1] also flags.
- Add Jamal's Reviewed-by to patches 1 and 3.

v1: https://lore.kernel.org/netdev/20261009051930.3619697-1-acassen@corp.free.fr/
[1] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009051930.3619697-1-acassen%40corp.free.fr

Alexandre Cassen (3):
  net/sched: honor TCA_ACT_FLAGS_NO_PERCPU_STATS in more actions
  net/sched: act_api: pass the filter offload flags to action init
  net/sched: act_tunnel_key: skip dst cache for skip_sw actions

 net/sched/act_api.c        | 17 +++++++----------
 net/sched/act_mpls.c       |  8 ++++----
 net/sched/act_police.c     | 10 +++++-----
 net/sched/act_sample.c     |  6 +++---
 net/sched/act_skbedit.c    |  9 +++++----
 net/sched/act_tunnel_key.c | 10 +++++++---
 6 files changed, 31 insertions(+), 29 deletions(-)

-- 
2.43.0

