Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82A6445AFB
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 09:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791192775; cv=none; b=lQTX76wQpJBZEIIJwvwfRYluXLWaCYB+gw8MNxQPA8JkOqaR4CRyfLJwwuw+skgMHgM9xdoJ0s+z3kR8a/OiViLxy5pK+pFPiyNQqhbVts+8UgM3n76HWJj2LFF1MSqljSZpFIC/P2SjfmSyF8z6+L8Y1BprTzLXgcb7pGfetGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791192775; c=relaxed/simple;
	bh=z93LGO+UPJaJAjNOaTQi26mWJ8c9Z+eSpQPos8SSoxs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D0UiTATLbH/RIn24PN5BCJhMqvmoO3AxGlQBZMl0i1bfm8V4RYSG4TeuR5kQCmz3p5HFcHdi2DvUXwnIAQwbum41wYUvfwEvAQ8rWxATU646yJl9ESLAUgy+R9jvV2js4vFf50TbI2vPxj2a/oA0gSU5kQQ0SCgKNFno0Bi/9Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nbXfv1uy; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbXfv1uy"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-3a4c8262465so1183545a91.2
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 02:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791192767; x=1791797567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=boIFBQ+tpIa9t/mSu2WrDlTP5P2+g8QXC7E1hIEs7a0=;
        b=nbXfv1uyMToMIsHe8FsEQS1/uruGLSpnJ0KmJc3wx8LPpYvYQOMGryFbqSbU5fJwhR
         j80l68ar3jUwoi2wTbA7CRA9V4jPgyjTYmfgWSk1b5MstOAIbwGWE6ehK3IvzCMZpG9a
         lftwpWoXV8YEITqs48p4j4XwSRqQvYnVQjjO/YqLwUxS0WkD1mgKE3Y3i8QJCZm+ZgMQ
         FjqkfssguFvGAeBtidOqyNzT+OoLNG7VlE+0EiBXLrN6w4HHgsXM2dVCD3ow138YX4nY
         wNVB0OW0o3VKW/VCcsfh7PEoUIzCxeU9oFB9266Rhe3W0ns6UxxD4iGgM80OoNGGyksI
         0eiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791192767; x=1791797567;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=boIFBQ+tpIa9t/mSu2WrDlTP5P2+g8QXC7E1hIEs7a0=;
        b=bJZsy/qXoeFBQErSkpT/pxzVEfv0gKRZTqEw5GEu7MAiAE7YC+PAkc5icpAvcikEch
         oa9oShSm50Dck+e+iuBJNPIkzEmgCQkTzAZ3XRgFnyybmZMfToS8f6DiZh3tpoLloozm
         xPc/Rhqjf/YAybzqjv/bksStkCsGCpFKe/RUO6xC6iRcJH5caB00Y25Ln0zqL7531FEM
         oEGwcI+zv7Ohicn+9aqbU05De0F/AAlDydsmOSDylZpgFwafZjnC8/ufmT6hU8RUoBbi
         BrHZthovBiihgnCb+fe6PZ3+RxwaV8jKLRL/T36a5o922/N8hOwT9Awt/2yJGO/mmLFn
         D5OQ==
X-Forwarded-Encrypted: i=1; AKwUvByt14k5H9+crKrRAaRmDms5SHALk6FWm2p29xB5Iq4fFU38gNqbrIeIuPhMAJVyr5vcvDcLFPk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKmWyzRpoxk5r9cdqHAieSY1PiyRiCVA7iq/WP49R9DDskxWgiD
	tsas8zk/CEwJTNs5HnNoY8zsyJMZpfs9MBAbx7GqzbOpHkN2UjMcITDz
X-Gm-Gg: AYBFou0Abqsp0SV6jbNs35fYiNv6ZJbirW3c235g++uTTcYdKk+hlrB6YoFmdzEbBLP
	FnpBilm/spUUIODGXSS2iRYUwOsmMfbbfna31WMiTBWeshEnixxNytn639buXZBGATbSj77mxXk
	MGhxoLiIkRHxpFfgNw31f+dSW0F2umh5q9ulMo7ecYyNX8Cl7AoMwGc1nM5JFVCD5xsN/hJN8zL
	E8OSxgqEgf05oIsv2+7L3WYgyMl8ABbv3OBAjEf3hnRO2IvpW6mZV7jq3M2Gp9uHLbynXXBMC65
	TpXJcEKWsWlwm9dZBldIn5LVkVlO9qzCEQCALYFpMBbHlhQvdrEaVreIPCkZnSIPHrvwnj8dSxa
	mPJcLp4R/HHL4UISaQTYMd9FrB1USwsUf/m9MsR348OnV3IlSog9UVJ0Lw3ODqfhrmCqBC4baVM
	9bh55WmnhGlFALE4PL7rElvDJ0NSX8v9q01NXkJ8yweFvS/tBHbGcCB736PseyjdsPbx2/QArhq
	RSuCafFwlhHVLRMDSw=
X-Received: by 2002:a17:90b:3c4d:b0:3a7:8350:49a5 with SMTP id 98e67ed59e1d1-3a783505109mr6012348a91.32.1791192767402;
        Mon, 05 Oct 2026 02:32:47 -0700 (PDT)
Received: from NV-9MNJ414.tailae2068.ts.net ([72.25.121.34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a7ad87874esm4527886a91.0.2026.10.05.02.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 02:32:46 -0700 (PDT)
From: Yiwei Lin <s921975628@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Yiwei Lin <s921975628@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jon Maloy <jmaloy@redhat.com>,
	netdev@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] rbtree: declare augmented callbacks per field, fix rb_add_augmented_cached() descent
Date: Mon,  5 Oct 2026 17:32:32 +0800
Message-Id: <20261005093236.62702-1-s921975628@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rbtree_test open-codes the insertion of every flavour of rbtree it
exercises, while the generic rb_add*() helpers have been the way most
users insert nodes for years now.  Patches 1 and 4 make the test use the
helpers where the helper does exactly what the test did, so the helpers
themselves get covered.

Patch 2 is Peter's RB_AUG() rework from the v1 thread: each augmented
field is described by its per-node value, its aggregate member and how
two aggregates combine, and the template derives every callback from
that, per field and in a local; RB_DECLARE_CALLBACKS_MULTI() goes
away, RB_DECLARE_CALLBACKS_MAX() becomes a one-line wrapper and its
RBCOMPUTE is renamed RBVALUE.  One change on top of what was posted:
the third argument is a fold(a, b) rather than a "replace?" compare,
which keeps the same register-local recompute, lets sums and counts be
expressed, and replaces RB_MIN/RB_MAX with the existing min()/max().

Converting the cached augmented test exposed the cost of the
"suboptimal" propagate-from-parent path in rb_add_augmented_cached(),
2-12% on the augmented insert+delete benchmark against the documented
update-on-the-way-down pattern.  Patch 3 adds a ->merge() callback to
struct rb_augment_callbacks, derived from the RB_AUG() list, and uses
it during the descent, which gets the helper to parity before the test
starts relying on it.

checkpatch has plenty to say about the RB_FOR_EACH() machinery in
patches 2 and 3 (unused macro arguments, values without parentheses);
all of it is inherent to the token-pasting dispatch, as for __MAP() in
linux/syscalls.h.  The tools/ copy of rbtree_augmented.h is left alone.

v2: https://lore.kernel.org/r/20260929152439.91443-1-s921975628@gmail.com
v1: https://lore.kernel.org/r/20260928122611.336351-1-s921975628@gmail.com

Changes since v2:
- Keep the 'exit' early return of the old RB_DECLARE_CALLBACKS_MAX()
  recompute in the per-field recompute

Changes since v1:
- New patch 2: Peter's per-field RB_AUG() templates, taking a fold
- ->merge() is derived from the RB_AUG() list instead of being a new
  template argument; the propagate-from-parent removal is now patch 3
- Numbers re-measured on the final code, on the Pi and on x86

Peter Zijlstra (Intel) (1):
  rbtree: declare augmented callbacks per field with RB_AUG()

Yiwei Lin (3):
  rbtree_test: use rb_add() and rb_add_cached() for the basic tests
  rbtree: update augmented data on the way down in
    rb_add_augmented_cached()
  rbtree_test: use rb_add_augmented_cached() for the cached augmented
    test

 Documentation/core-api/rbtree.rst |  27 ++++-
 include/linux/rbtree_augmented.h  | 194 +++++++++++++++++++++---------
 kernel/sched/fair.c               |  70 ++---------
 lib/rbtree_test.c                 |  62 ++--------
 net/tipc/name_table.c             |   7 +-
 5 files changed, 181 insertions(+), 179 deletions(-)

-- 
2.34.1

