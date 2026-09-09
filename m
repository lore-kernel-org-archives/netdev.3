Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71CA22576E
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 23:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788996707; cv=none; b=nuehj0Oi6Yf2VIM82k+gJwVil87dtm66SyUqvvmoKRlUOyRlHupwXRjpwWZ+40duCB7t1pebWNbTxM9ew0B/PcW7viVPdZ6MzFkZPoh1If5LQ5WsmSXd4+uaiyYMT73OHbwba9a1bbMJ3juatyO8D6Ix1aq8YKI8sdYcuXC1wFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788996707; c=relaxed/simple;
	bh=NFAhVMHeajT7kTgdzKm0yt/3OlVFVkaKVMRN945IteQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Ba5FWYd8/239KfT6BLC/Ryvz3iWRnlRs4LbjTg8AqStigk9swo7LLDd8/FexBySJimi1dVAzO0O9BFnFL5mTe/geG8I7cC9OAzgdajgBfFsWraUg2CEDgK6rTY2IT+x/6COEhfAQoBsNHiXUgq9wlq4UpkiwAuCmrepRdgfxewA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WTwdENES; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WTwdENES"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2d94a158dc8so106605745ad.2
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 16:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788996705; x=1789601505; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1da1it99wxe/97Ia4E+nWeVlKm00k0889Len1sVHm1g=;
        b=WTwdENESoLMn7eN/KI1SqUDSvqt3I6KhCoHtqrbKq1tDIt7dgl03nHA9/w4c3Y1el/
         1/k5zRBjbmTAjFrwsrLz3cMZw6m6+dAz9OaBhYsCSjU0dSVqednXt1iJuwel0dNizLvG
         OIrzJavklgPhWH0rYgra4ZJmluimj7s74urrqPlSJpoW32WcBSGyxIQx+vwXivipOVyW
         IojHp1LY7YbTJgOWFY6e43gwpcqScLC5yg9/Gh2JGSzH2iQoHPXhC5Dmv7WNUwdKMj8q
         olmmnpm2zIYQuiT6hq/nCqX7niohonXSiFqXBUZnzyHbRC6VDMnDZED7RztAJDlTYlrw
         3ggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788996705; x=1789601505;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1da1it99wxe/97Ia4E+nWeVlKm00k0889Len1sVHm1g=;
        b=fbuI8KyG3K6EG3aTxYuiNmrnMEzsDqeCcK7SoSL2fhnm99RbhwtVi2uMUEXIx/MrFw
         nPuZEjENsP1pzxkJNDzlgQLC028GOvAaPzq8w0qle/cv2z9NFbdAJcfglGkzcspzsXAu
         1cjWconjObRd6c1zXmOdauU18UColOs59jGx+NqcQNjRcBk141ClP6tzc82ea7InBY9Y
         a8Qp64Fo7IV4mAuolEdYkd44ibcF0Qpj2RcG2Uaw330ex8jB6n2VK/v1f04u8uPPNKzi
         6F/faIPhH0qhmGH2hLq17rEaQokCdEFCOpgmsAPM+H0gMatSIXuqpJffeG9JmZjZJpsV
         n+sg==
X-Forwarded-Encrypted: i=1; AKwUvBx94L4glsNAImc53KfmB5hkBJ837ZpITLVO20qTaWBLUddrV9A8xsEd+Wqy1TaBskOk15whaTc=@vger.kernel.org
X-Gm-Message-State: AFuF++noucH4UO/oRTXrKWq9W9XFpZy3E1FK/WGIEtboFDv4/16jVivU
	Da/iytZf/ZRwlEkal2VWth+RVwO/Vca8uwzfDk07cRftAX8BO1BmBS6OJhZhmBkZvMvc85VUMdV
	PE631hg==
X-Received: from plsm24.prod.google.com ([2002:a17:902:bb98:b0:2d5:fb6b:7789])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:17c2:b0:38e:659b:f366
 with SMTP id 98e67ed59e1d1-39b25f1c5bdmr53208090a91.0.1788996704783; Wed, 09
 Sep 2026 16:31:44 -0700 (PDT)
Date: Wed,  9 Sep 2026 23:31:22 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
Message-ID: <20260909233143.2401847-1-kuniyu@google.com>
Subject: [PATCH v3 net 0/4] neighbour: Small fixes for RTM_{GET,SET}NEIGHTBL.
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
  v3:
    * Patch 2
      * Nest min/max inside checks: in rt-neigh.yaml

  v2: https://lore.kernel.org/netdev/20260908211419.882954-1-kuniyu@google.com/
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

 Documentation/netlink/specs/rt-neigh.yaml |  3 ++
 Documentation/networking/ip-sysctl.rst    |  2 +-
 net/core/neighbour.c                      | 35 +++++++++++++++++------
 3 files changed, 30 insertions(+), 10 deletions(-)

-- 
2.55.0.1003.g10538fe699-goog

