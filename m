Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF6E3612E7
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 04:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790916674; cv=none; b=GVyM4bIddT3/B3eiQ4XtfAsX3441nub6Wo30xZAFgmwMeYlkjnEIzQNtXvEPMGS6kBpJW0GiZev8B6SnNb7VeiuyzYfhSLRHFrXwSy0w2yGvVITXXoMprAWEcHICGl6T8f9dB40vfjlj3tKSFaj9l3pxtFnYpvyBc+nOYAOIYq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790916674; c=relaxed/simple;
	bh=nqiEs/yNZYlAeYT+GuoSdhvwQmIIqc/V9r7buHE+D+0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nQZiXIvkEI++Web6EeCgB2elqt6cpynzBadw3wl4ePfdtQP+NyokkHpIxMAGuerUjl7FNRAMxRDfkdwHzr+t8fwpYBo5rK2apxmkzpwe+39H+aNhQ+FM5DDdNWr12fOkWIAkmkAWFHId9lMv/yMrZ/6kkjmxDwbf/0IN3d2R6bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a8jj41OF; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8jj41OF"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccb1a98dso4276995a91.0
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 21:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790916672; x=1791521472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iilXiQzuSFQz+l8QQU4nopfLIRLODykiTqVDi/iuygY=;
        b=a8jj41OFuOK1Qb8HTJSjNOovYdljwQ/rAczgiXN88r7bwm7zvWa2jtNr3VXLpVPprK
         ET8VX2OGvkSigr9muYNL6pmXdCdRT/y/QeZW51a9GpM7Az7AQLIxfiuWQFpo8iWE9ASV
         FzVyaIFYTtjAI5tHYSLg55/3ZsHIQfYsaRA8DmY0pmkFOVKtrQoejod3CAHE/7yzLJZS
         W0hz2qd4MpAyXzlLccXc+pYeEfcr21UYinkOf18MsQaLKdTO4axgcY78bJZ5KBkI+eeI
         osvHYMH10G6suk5kf9JjOKrOJZGJ1Xjbg1NGKuOeujw6cjvJImE4SBtCmXeVD1sSAM5b
         yRqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790916672; x=1791521472;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iilXiQzuSFQz+l8QQU4nopfLIRLODykiTqVDi/iuygY=;
        b=u8F62keGKL08CO70k1Jgy8F56CrT6BT3AZcgLNtE+rneaREnIMs3H6RoqgTO3QdqCO
         AhirY6gPK4ii4D3LBfJ5vARDWWXpRLPh+XPqsLrP+em9MH81rJMig1tN4d2g51q7WLiD
         ZHwY09fpKNlqhqiFmLERrS6dF2DMKPsbNBaFkkN+SDevRkpn8PD3hoOkq1WExIcgVlxR
         /HDRk0fiD9cvPK7RebqqEiz2tir+sqeaL6U0nP+swe4kqoQ5glGO2h5az9fgnWJXMXpF
         v5qyTa+cr+WkXJA7fcSWVgArkq2xUoYlay/6FZFo/0VlI53yl/VtTAmvrK096Q5Hyy0h
         tPKA==
X-Forwarded-Encrypted: i=1; AKwUvByVvu6UTtsxtBPfB10IPKdfLz3amEl6kzU/9Rn8/v1EUbK7mbVXqZH5B57C6wXgLIr5RdjDoV8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKQeTYdaqrUZio/6KFqvD1sGAzkrbJPe7DU1RJ6d6cARZMdKre2
	ZPAHEZy3nYv1WJCE8rdRcJvmSDjb4dm/MX2PUcD+oU6G5Zyd63CTRqS8
X-Gm-Gg: AYBFou1IIMmIKAR55J3dlYIRhoCne/aUu4xcgclFRt7wDU6oWXmzlqxP5Zqo4zWftA6
	Z7xXb7w+msmSJs6QbYJVn9fPZxwPhHNPC6oMr7+XaIso5F5JZ92uKxc+Sihh5+l5XxVhYCHTnJS
	9alm2iPnzO2ImxDh9bWtP46QXKdqYOPJNUP7ssKRrISuh6GMRgxzjZ5/gxoMwSjbwTJCBL8kXwy
	MCacYWL+Y6xAwZs9Xd/VHXMsHJbo0JyWIjtRFNsbVmf93/bzcbps0le5AeUJ4O5O4l4lqwyCEMI
	WkyL65zw84eE+uDRpjoZS/Pti1mfQEsL0TardEp+I2bIhIhFGUnWCpiMSPmCEEx7oJJSEwvhV4z
	TJNx8Jn5pd82nTZV4vcB+X5c/7r32kh4g8PgOqrYTHp6rhTYl4s+7z1E5SL7juCrPY5k6WOOzck
	zI2nw+A08jXE5tV+sLeJgja7nhSoHorfo34cM57mlpooPjHIPsWwIxwKWeKQqPu1Aq4zbV81eHv
	KV9bWbeeLEStbjD6U67vQ==
X-Received: by 2002:a17:90b:2249:b0:3a4:cb38:30b7 with SMTP id 98e67ed59e1d1-3a6ced70b5cmr1491944a91.59.1790916671871;
        Thu, 01 Oct 2026 21:51:11 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a6dd3962f0sm642682a91.3.2026.10.01.21.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 21:51:11 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Vladimir Vdovin <deliran@verdict.gg>,
	Donald Hunter <donald.hunter@gmail.com>,
	Amit Cohen <amcohen@nvidia.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daehyeon Ko <4ncienth@gmail.com>
Subject: [PATCH net v2 0/3] ipv4: handle nexthop group shrink races
Date: Fri,  2 Oct 2026 13:50:57 +0900
Message-ID: <cover.1790915964.git.4ncienth@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fib_info_num_path() and fib_info_nhc() can observe different RCU
generations of a replaceable nexthop group.  An indexed consumer can
therefore accept an index from a larger group and receive NULL after a
concurrent shrink.

Patch 1 is unchanged from v1.  Patch 2 addresses the analogous
fib_dump_info_fnhe() race Ido identified.  Auditing the remaining
accessor pairs found the same issue in the RCU-only hardware-flag
notification path, fixed by patch 3.  Separate patches retain the
correct Fixes tag for each concurrency boundary.

Thanks to Ido for the review and follow-up pointer.

---
v2:
- Carry Ido's Reviewed-by on unchanged patch 1.
- Add separate exception-dump and notification-sizing fixes.

v1: https://lore.kernel.org/netdev/20261001010550.2742297-1-4ncienth@gmail.com/
review: https://lore.kernel.org/netdev/20261001170513.GA1657889@shredder/

Validation:
- Patch 1 retains its deterministic vulnerable/fixed result.
- Patches 2 and 3 are source-audited only.  No new allyesconfig or
  allmodconfig W=1 build or runtime test was run.

Daehyeon Ko (3):
  ipv4: stop PMTU walk when nexthop group shrinks
  ipv4: stop exception dump when nexthop group shrinks
  ipv4: stop route notification sizing when nexthop group shrinks

 net/ipv4/fib_semantics.c | 3 +++
 net/ipv4/route.c         | 5 +++++
 2 files changed, 8 insertions(+)


base-commit: 28bc1ef699610ee09ce3d46a00552f5a0a0144bd
-- 
2.55.0
