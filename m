Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB8C347533
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 21:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788818338; cv=none; b=q5sOxkE5H/U7O+LXq3mqx7ptNONm8wHAUNvST+slkYRb8ru1FMVJ6HNkSSLlrTIh5m26wZI4MZtcdenFtlCYcW9fTuvRFq9kHLnjBYCPKh9+lkIan0w6wdJnCkjJeor0qHIs442DzO4kUHbuC/wlNOspP9f0ceoeyOaTETnQ2gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788818338; c=relaxed/simple;
	bh=xv/RzvCBJXVfBLAu9QM6obaEdYaU2eSYEEJluVolyBA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lptjXurvHfUUzAPXrJXXp7we4uH8u4qOAp9HdWtuJ64TFAIJ5KHdrrg7lV4RxMPeIgi+VNsgrPHCHAekjY66ypf5CuAydV6XRzczaPX181s0zj4m7k9+ZW9CnBIInvRS1Pfsi3SKfrbda470kYcTHaVZHGkrI8lv0Waq82z+Ddk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z6s1C5Uq; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z6s1C5Uq"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc1b6f65dacso4535041a12.1
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 14:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788818336; x=1789423136; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HSa5ClCFyrQx7TeVWrfAEYFbdP31MvYOQf/MsTJvIW0=;
        b=Z6s1C5UqnEFe8IEI3gaxRp5o9BrPwoFRj7syv4vKZc1VfpY0riG+ORBlWgXZMkFR1G
         TwYA/a4CGdmqQSNjbcHxTOaHFVJzEggwZ3UYH3611gmd2jDwvdoLo1Zr6tUXP/7o7q5k
         HMRzhs7rTzY7hU4SbkznD8YiW4yNrQrInh0q4gq9bqbOCYhW8eEXT2itQ4VnmK6V4s/r
         TiI9vk9x90yDio36L24lhck4mkefMMMpSGELrfj4aF0zFuPVXWMykzf0KcmTLXW9zyMJ
         NHvXa1eHLdgDa8Bjv4aBlpTmUrebEufFUDlVWIspa0jCw6uvVYchtAt3R9WjrU1Ev4BW
         23UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788818336; x=1789423136;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HSa5ClCFyrQx7TeVWrfAEYFbdP31MvYOQf/MsTJvIW0=;
        b=jebPOzGKavnaC6fkY53V18MN2c1vV+50H2ij4k1P1TEBR09J65h4dqWtIPCEzovffS
         ur2pIdKYHLUujLmwEsx7TPJc7b1M9Umy0ex3qQ3N9m+dVT5zdpekHxa9unYGEKAzPS7w
         I96lCXGXKWMR+TefDyipqgrjBa/jken0kgpWtIbYWC48sJDVXGh09uXzpkARmd4wjonr
         FGml5LuoAwXIKJSnwmZ4Gh9/ytaY/K8fZrH9MbZHflcuXjITkX//vC9m/RSKcHVgiy+m
         nTCE+MTGKnAiCTJnnicMHKBmXvKo5cOWarmpnvjb6LEpR8h/K6gzEP8h6ORehXcJJngk
         xvVw==
X-Forwarded-Encrypted: i=1; AKwUvByjI7jJR92TfiEgpTUy6fDI8lHT3qVzeJPfBWiaUHOjxGAqFVoKDZ8I3T/Vcx2tPytQQX8gdvA=@vger.kernel.org
X-Gm-Message-State: AFuF++nkiP/jrrYW4+yhFwo+77Q/8NoFeLYOMjZfR6sBMtVLXMO4aLAo
	SzA3yv6Hn2x4bauum9D0YO38erpBGSy2GNPLu2dnqcgRGzWUTIPicqi1v4zEY35iSiipxc10adM
	IePpReQ==
X-Received: from pfnu20.prod.google.com ([2002:aa7:8494:0:b0:84f:a7f0:9315])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:338d:b0:857:73e2:9104
 with SMTP id d2e1a72fcca58-8616be5fd03mr34001684b3a.20.1788818335793; Mon, 07
 Sep 2026 14:58:55 -0700 (PDT)
Date: Mon,  7 Sep 2026 21:57:51 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
Message-ID: <20260907215853.3709987-1-kuniyu@google.com>
Subject: [PATCH v1 net 0/4] neighbour: Small fixes for RTM_{GET,SET}NEIGHTBL.
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


Kuniyuki Iwashima (4):
  neighbour: Add missing RCU annotation for neightbl_dump_info().
  neighbour: Enforce min/max to NDTPA_INTERVAL_PROBE_TIME_MS.
  neighbour: Don't render blackhole_netdev via RTM_GETNEIGHTBL.
  neighbour: Skip default parms when resumed in neightbl_dump_info().

 net/core/neighbour.c | 36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

-- 
2.55.0.1003.g10538fe699-goog

