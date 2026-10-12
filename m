Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDCD4779BC
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 19:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791834335; cv=none; b=O43nFREuetb687iq9l8BmPQnvcV/cjq4MW+P5yNKQMuZlWaDAKeXbh2nrpRycYwH80cjtO7gLieV71HBDVj1CpgrXx7eJ+zRbfImptn5QqmkjTbnLbibUfI2n8xOJ/DEvAFbbFakcAg/oEbCRdX1rn/qie7N0Y0Aunclk7FbS2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791834335; c=relaxed/simple;
	bh=hfn6SFPQbVERGk6Bx4jLHV8n5V4CkYJpw4jFfr9K8Jo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=anXOGeTNov6KMt5ha789/bq+OJ9XwBELfiiiE4k17pcWa+H0mI3C2EWKuzliDwcZnUHqBDdhDEHpY1l9UjbkSEGF4aOPZL96UF747X0IYhOJmVJeH1Eo7HOMFnbSER6RbCJ2PwZiJSqhQQLO1gQiNvaqsclCKzcLUxOUvmXrbxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lCHLTids; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lCHLTids"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc7e0321ec1so2704607a12.0
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 12:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791834333; x=1792439133; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z3op66gKahLjCs+r/sH01H+bh+mOzxwvi9C7LqoO1vw=;
        b=lCHLTids6LwNhK/2DDT38UKPvJ6zvPOc3+9DeEm/wiFNKNauUlf8cejI7MerrwfDwE
         v9Nt55l7tU6eJkF4ep9kp6yxESK0cwZnA4ukUxchVh4rk3fY8cLG6OFhAIh2G9u89Mq2
         e2vuBnCyClfU30g2er8Qpg4OU/iP9ekXvxxlbvQWiuwpIjpg3UBdIra/KV92zfDMdYoF
         AOf9oFQyHAgLZzV/Nf7sFH5y/QCoalu2joaItUDlMRzDR5QGT6u2WUHU9JtYIUHSJSK1
         Gag4APgtUWd4F9owGsx6q5p7bl3pfCvqrRLhk2LMn6sMaIo4fzf9zx0HAahCtyIK4+C5
         8EBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791834333; x=1792439133;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z3op66gKahLjCs+r/sH01H+bh+mOzxwvi9C7LqoO1vw=;
        b=jH2hRVHl+e6hirISx24WaoYTTzH1NPJ6XJJpSC3lLgs7rRdWvql0aj0oM7+RhINJOd
         mc0C1dCzxLYT/5iMNTmyVMDprL9U6lCPQbTYUEMpP0I428/idyMkq3ywgZVUWnwvZ8/q
         accyG6nNa5olErMOKTl/Q0FZ6GGvrN8TOElg0AVP7KwKF1n0NQzq4YF4z9QnGQmkcBfs
         V4wrUAZDhVRFurkhe+TvUpy4zKJjOSwcwCnOwGPsHsmz9IFKO+lV0zm9y85R4GPInudm
         QBsBZOHGtAb/w4A3JlFCrqn5kDkpdZoaqmZhr/6UuGQndA1eifYWyZ9qj5BJXEJGmTX6
         slVw==
X-Forwarded-Encrypted: i=1; AKwUvBysL66JabybCC8+zPLyO8hS+IPcdrbLa8Mf1eIXuVtKbPXaACrl2xQqpJH7Z8MolzcsEcu3JsI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIpKMSYVjyZKJuTcyPdM0OfzMvoE7p9a1m53iQm9oXD8CErlT4+
	jDEpIxj9RqYGCPCaOlF3WflUZ8gEFVpsFVOiD3ZS6Quvec281DLkv8UrvKoX46teZg7Uahooyny
	0kFhSGg==
X-Received: from pgbcs8.prod.google.com ([2002:a05:6a02:4188:b0:cc7:8563:5398])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:4045:b0:3e1:370e:f249
 with SMTP id adf61e73a8af0-3e19a64c1ffmr3816404637.60.1791834332789; Mon, 12
 Oct 2026 12:45:32 -0700 (PDT)
Date: Mon, 12 Oct 2026 19:44:55 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261012194530.3751034-1-kuniyu@google.com>
Subject: [PATCH v1 net-next 0/4] neighbour: Misc follow-ups on per-netns
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

Patches 3 & 4 are based on a suggestion by Ido Schimmel to make
neigh_managed_work CPU-friendly:

  https://lore.kernel.org/netdev/20260902143023.GA3966681@shredder/

Given it's rc7, I'll defer RTNL removal to the next cycle.


Kuniyuki Iwashima (4):
  Documentation: networking: switchdev: Replace arp_tbl with
    arp_table(net).
  selftests: netfilter: Set gc_thresh[123] for gw netns in
    nft_nat_zones.sh.
  neighbour: Schedule neigh_managed_work only when needed.
  neighbour: Floor INTERVAL_PROBE_TIME_MS at 1000.

 Documentation/netlink/specs/rt-neigh.yaml     |  2 +-
 Documentation/networking/ip-sysctl.rst        |  2 +-
 Documentation/networking/switchdev.rst        | 11 +++---
 net/core/neighbour.c                          | 26 ++++++++++----
 .../selftests/net/netfilter/nft_nat_zones.sh  | 34 +++++--------------
 5 files changed, 35 insertions(+), 40 deletions(-)

-- 
2.56.0.385.gd3acb90ef8-goog

