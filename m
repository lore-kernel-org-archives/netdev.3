Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C30E18DF80
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 03:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789182536; cv=none; b=X5bvN8Xm1A8MVGRc7uQn2kRYqwUrgXPOj4dGTbkU5EUusaIX/F1EpGUalPFb6hbrjLU9oMM3YKqQsfr4039vkLyreA0NuxoxZBiDyGmtl8lcdWJoRzhlewcjQoOITzz5h3vh+vCUFwjHtKM2Gc4SD5mNEpFXEstHJJnGRvNMrE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789182536; c=relaxed/simple;
	bh=jR8prQ/z+4qG3oHvPOxgSNTJ/8880iAVc9SgaaUwX5U=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=AZEG/NiXEAS3uWniQN4+QtMbrnvqQKustgHLX/EBzDiRBXH1oN1zcUyaYhyWIJfSNXtdo/z/SyspXrmGGs79C8INalCpcjoWES0LLnjHSa+g/tMsFhWFzQP6sCduG89Gr+32yIVtKJIXMYwuMM6jbCU5QUJsCuIijQGHTQ3lig8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i7IivPOJ; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i7IivPOJ"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2d9336581a2so28952905ad.3
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 20:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789182534; x=1789787334; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nSVz7tjFqGbEDanGAlxgCdas/nBBOQrZ4IZ4+hVaVls=;
        b=i7IivPOJwAbHUb/lWFbcdBUIUz4nPzfrfcKY+4DhLitGlZs+q6SpaZlDvBmWOUZjNI
         ptemceA3VT/lbuuYF57XaTadxubBIKk9TooJ42X1BPlDBF9ZEDM0An6xxtenNIJ1Yco/
         NwyxD4WORUZIEm/geU8Jke1s7JRoKbgb+BH2aDBpjpUpRorNkENXTG2tEVPRbBv5IcZY
         r4XKUaFUH+sixY15iTJJc5uSFeGe80m+6gfbEKqX++Nk3W9i1OdGQxcTmhnKiRAECCXI
         /4be3IGJANrOAwmExwQrZZR2mWRgOxAiI93Wa4fIOTW8Tj+EABg6aqfrAG/iVPSY8HeE
         g/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789182534; x=1789787334;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nSVz7tjFqGbEDanGAlxgCdas/nBBOQrZ4IZ4+hVaVls=;
        b=LQAoWNCdo2pebXmO55fxWZhY+Z+R3vg6jMNcWkSDpY9G/fviZE9HmrVVM6nCrQOAsa
         gWpoj1xCuzr/RMM3CNPFU0DWA8UU6c6Qrf68x5RwCRRy0ag7qmSaf6jt3UkHw5N9rqXh
         +BOQVvFdqDmBeQoQT+6/ihrc21HBpUqaXKAjSOPswj1rMw3HLt7hSYPJG85vMkTGe58S
         rjvXxpqtnZfV6GLY3VUX/WdxEt4d4yR/YGJsamb5XSeGXLHPRqzBucIvWZNeC/0z+0qQ
         C6yMnAeD9C72NQWLoY7YgqpxOwqg6vmtL+17JV0k8GS+SceFoB9bhekkxlgGxCJ3DFaq
         PPRQ==
X-Forwarded-Encrypted: i=1; AKwUvBznXbi+7RAPiOrjtijYpMbFk1QAM7N78SyQzbxCaIMAIh/eKVwH/K1wntXlAL1u8gNCSEIrHU8=@vger.kernel.org
X-Gm-Message-State: AFuF++lLYK6ZDI3pb4wor193rSLoiTSuU7L9M1Y3HRP1oqE8RyiWgLKP
	wUCt1T38wXni1DhASieYRz/i0aFJab/gOyjEiI/d2OFU4symoAH2GF3QpT6gcyxuUjq3e6B9oqF
	GIfbFVA==
X-Received: from plim4.prod.google.com ([2002:a17:903:3b44:b0:2db:36ca:f184])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d2d0:b0:2dd:1701:3b6e
 with SMTP id d9443c01a7336-2dd4bd7854bmr18812495ad.16.1789182534338; Fri, 11
 Sep 2026 20:08:54 -0700 (PDT)
Date: Sat, 12 Sep 2026 03:07:50 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
Message-ID: <20260912030852.1467872-1-kuniyu@google.com>
Subject: [PATCH v1 net 0/2] af_unix: Fix inconsistent scc_index.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

James Burton reported that a single SCC could have multiple
scc_index and unix_vertex_dead() fails to detect a dead SCC.

Patch 1 fixes it and Patch 2 adds a test case.


Kuniyuki Iwashima (2):
  af_unix: Unify scc_index when finalising SCC in __unix_walk_scc().
  selftest: af_unix: Add test case with mixed lowpoint in scm_rights.c.

 net/unix/garbage.c                              | 17 ++++++++++-------
 .../testing/selftests/net/af_unix/scm_rights.c  | 17 +++++++++++++++++
 2 files changed, 27 insertions(+), 7 deletions(-)

-- 
2.55.0.1007.g17ff1f9808-goog

