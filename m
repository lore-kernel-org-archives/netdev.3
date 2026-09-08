Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864F03B6C14
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 21:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788902063; cv=none; b=HChaT4igf0pBiI6jTmvRey+6hVkPrSQ9mLxy5gs/f75iOugb/wQd6qSP6sxp3kY4sp+flb442JvgWPyhstQ4CpRfIgRiVd/nY1SiGAxApuYdvHaxA/Je6lCsvjjosTChPo+3GXcyU1dg4HHPOIsbZEti/LMvTuyd9g1+sdxdW6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788902063; c=relaxed/simple;
	bh=kRkX1TsdKfCdxIJcvBZwYflDUuM2TlFp1nVBqxRZxcw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pcqPUPXHkwY4s5WBNpINLgwSMa+gaCVtvCO0oLrr7NlZaO4CoGGP9KzZZbPNuw3WAKWToK/3SUMLPw1BI+X3o4j2fbXw9f6SA8xv9baeMPZGBnBz1M6SQ4qQrn0sCt823+cj6/g4kQ3O/hVl22nuVJ4zjbfNvIyRDfBjFc2eSUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H+y6Cm0O; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H+y6Cm0O"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8623e5d4279so5536954b3a.1
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 14:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788902062; x=1789506862; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kj6xvT1oIm0zWKEFlXujuUDX/E9SiW0kKjkVxz1hGT8=;
        b=H+y6Cm0OcUvRKx0B/T/HWHiTmB9nJ8ikKQH0YiuQ5YUbNyckDfmGbyvmuRQIZOIchN
         wtJtPHsVE93BE6sVrAu/hS08JN3g2jIkk/gl0sxHuSrFhBytXjapEyS7vvETOObbl1cx
         ptli5zMi6rIeKmjI8DEi+ShQirUtGQ5OLfXO3Tv1pXsh7sfoyuusF5L6t5sX0fif6r1h
         7H4WBgpiehUgP0MB3GiE43FGTOKT4cd/ULbso83/Tt1XDtWfCcHNSt8NxL7oIfCR/Aig
         dC12+huRf01gugGu5H7JHHoyqaap+BMcpdiiAhegh9NxdyTFvxOLdkkFI7+qVBnGuUgn
         fAug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788902062; x=1789506862;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kj6xvT1oIm0zWKEFlXujuUDX/E9SiW0kKjkVxz1hGT8=;
        b=MBFNBUGjFDdtDmGSu5qljRwxE0BYoqlgAiT9Hy4+yxrByWOrVblHgEq1sLYIfD3urX
         nEnRf1i8RIM9EhyyrIgkjV0xHbL6JR/67daz0zJzi/t0z+QfrCxFlCxi0RLKxvwKOUdX
         9DRhpGyFi/0LOJDQA5rfgi7ZhNJpeOGKkqEZIGtnOGXBEHSfNUTfyp7QEsC6UE4OX+hD
         Z6fhxnM4Itdp1Tp02BTUxMNeTJUSQUwJ0Jn6YLJTgJGtwdqHtqvyy9z77JYBfAoqUi+T
         ElskxIhLPrOLJmRd5CJNRnC+SCjIsuawAPUxdyyaTsKFvb2JDn+if0gH4t0uIDC+NPrb
         8ZDw==
X-Forwarded-Encrypted: i=1; AKwUvBzd2kNL2jogGOf0jHdSDiko2OMmm2uGMrQoXjuXryU255hSSaRPlM21uJNSxGWKCowsRFWsxBM=@vger.kernel.org
X-Gm-Message-State: AFuF++n1pUb3MwOLZxWeKUUyusVxyb+1l9U0caTsbbcxdQ4/0XJHPtIE
	mPITuyPVDT+1Jsq9gg4jf/GbIuMgE7l9sQjsXO/o5e0qjHkqUBpVPpsyIgetLBzp4BcsohpLIDX
	aVIOs2A==
X-Received: from pfx23.prod.google.com ([2002:a05:6a00:a457:b0:85f:41e7:1264])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a228:b0:848:62ab:7b7
 with SMTP id d2e1a72fcca58-86169b6e746mr39616370b3a.16.1788902061435; Tue, 08
 Sep 2026 14:14:21 -0700 (PDT)
Date: Tue,  8 Sep 2026 21:12:44 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260908211419.882954-1-kuniyu@google.com>
Subject: [PATCH v2 net 0/4] neighbour: Small fixes for RTM_{GET,SET}NEIGHTBL.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

While working on the follow-up suggested here,

  https://lore.kernel.org/netdev/20260902143023.GA3966681@shredder/

I found a few bugs in RTM_GETNEIGHTBL and RTM_SETNEIGHTBL,
which this series fixes.

Patch 1, 3, 4 will conflict with net-next in neightbl_dump_info()
due to removal of net_eq() below:

	p = list_next_entry(&tbl->parms, list);
	list_for_each_entry_from_rcu(p, &tbl->parms_list, list) {
		if (!net_eq(neigh_parms_net(p), net))
			continue;

Note also that currently neigh_proc_dointvec_ms_jiffies_positive()
is buggy and does not enforce min/max, and it needs this fix:

  https://lore.kernel.org/linux-fsdevel/20260905233819.1064529-2-kuniyu@google.com/


Changes:
  v2:
    * Patch 1
      * Use list_for_each_entry_rcu() and skip the default parms
    * Patch 2
      * Clarify the attribute is for NTF_MANAGED
      * Update docs, rt-neigh.yaml and ip-sysctl.rst

  v1: https://lore.kernel.org/netdev/20260907215853.3709987-1-kuniyu@google.com/


Kuniyuki Iwashima (4):
  neighbour: Add missing RCU annotation for neightbl_dump_info().
  neighbour: Enforce min/max to NDTPA_INTERVAL_PROBE_TIME_MS.
  neighbour: Don't render blackhole_netdev via RTM_GETNEIGHTBL.
  neighbour: Skip default parms when resumed in neightbl_dump_info().

 Documentation/netlink/specs/rt-neigh.yaml |  2 ++
 Documentation/networking/ip-sysctl.rst    |  2 +-
 net/core/neighbour.c                      | 35 +++++++++++++++++------
 3 files changed, 29 insertions(+), 10 deletions(-)

-- 
2.55.0.979.g7e5102b832-goog

