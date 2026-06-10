Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839A53264C7
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 06:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781072268; cv=none; b=Z7cdGWLO+TETZq4aVZMopJF0HmOyw/paXw5up5S5Ko6cG5JnYajMWwvXV35EIMZ2BA60uhRrgxho3dpUmWGln1AgegetO7JNkS30T5LRhwkQY0/H29b/pk02XTEv0V4Qwu64X9X/4QT943dPw6I6UCrp+nNTC0F7G0/f/7EoE8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781072268; c=relaxed/simple;
	bh=Wz5BNdIIWc1G0qxF5KmMN2r64fhxrp0kBYPYBf4m/mU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=noAfWDHnKpg0q3wZaHDPnv+1ezGGgZOyqQhfXufjdZKXD8BMvxnMVogZhc9diG89N5/1OHbU1NuBDR1Ncn34UCk1L3b7J81hJa9k5gXagYx4SzEncC2qdvV1kuC65Q+cZh8RC+6U5NBtZNrIM4nPKsCIUUIj06rB2aCbIKvhPyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gO2iSWD7; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gO2iSWD7"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bd04e4fe3dso102520205ad.3
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 23:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781072267; x=1781677067; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lC9cyaVRYDtyUYDrrzd9Hls+3qEatIGQK2ehL5atyi8=;
        b=gO2iSWD7kD/WfiQJOxIwj9FlA5SJcwTBf27OjM+RKINMbjx7HNtx0FUoUBCf/1x+A4
         QP3Lvu/8iApb1dvnsjgYLY1p6gAY6tGsh23Xljf3I0J5YqkNp2WlCZK35VE3oWt1dG8D
         rDFSQ4++vhjcdrpoOcXQ0pgrxo5PohHLVHYVUobLfkBYu84hnVGguHk/7OD1veCtxZbC
         ZGvjq+WcnuvbdRa6NIz1n1svAAA4iyj1KoAjSy+8e1fbfaTgtMSAoEFj6ca/L5GU26pG
         2XVtyyVwJkVtfS+Z+P9+U6Doj1WM9MLRiTlRiXTD4RnWmoErpcKfms51yTz1+wfK56z/
         9EFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781072267; x=1781677067;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lC9cyaVRYDtyUYDrrzd9Hls+3qEatIGQK2ehL5atyi8=;
        b=k+J5TvqzaTkxiIscy6mfu2msqSEWGnUWo4fe7t+7FRKKlqNnWZxVuVml9nc+JRbJqX
         qAPnjHppMmG+VpImvWkCEMCXwGFNlJcHU4KHFkmf4CSr7ZZhOpGtHoGjVuywR+Qf2Oo2
         9WDnSEHsoh1eg2LqYKjf7jEo1W+SSRVVs6L+vx37x1+P2c5Wx5uDLOFdcrao68BXYPJz
         1zYBtkI0lAvom6ISuzA2JQIGQVZ+VLRb8iJixzNdBmYXKzXuvGGajnr0gtTmOmZ9P7bb
         oeDtRX9BpvHEI9ImTRGSqF32/xeliDPfxhX/vQN7HVwyzS5ZaaMCAPFZ5/4CQgy8xDA2
         oVnA==
X-Forwarded-Encrypted: i=1; AFNElJ/XLqRxD0ztHqQuPShGhx0Dytp3NN4KeSS38RMenCeTtL9BGt9gEmpXapI2uxiYAVxpyiziZxg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw4qfWe2KdCMd2H5h0SGfug3bi+LubZVo7LqJm1C/TeMPK7Fmr
	ZmMEJjYeq2awe0jO4kNXRjxINSlgpRUGZ74qjpvM11hnMOv8Hf+ewPg59ZZgZMhZPqK9MfLm2zT
	s1tKsfQ==
X-Received: from plbkr8.prod.google.com ([2002:a17:903:808:b0:2bf:fd0f:2b0d])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:eb8b:b0:2c2:4ce4:c5d4
 with SMTP id d9443c01a7336-2c24ce4cbe3mr167704055ad.17.1781072266408; Tue, 09
 Jun 2026 23:17:46 -0700 (PDT)
Date: Wed, 10 Jun 2026 06:17:17 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <20260610061744.2030996-1-kuniyu@google.com>
Subject: [PATCH v1 net 0/2] net: fib: Fix two use-after-free in drivers during
 RCU dump.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Amit Cohen <amcohen@nvidia.com>, Jiri Pirko <jiri@resnulli.us>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot reported fib_info UAF in netdevsim, and the same bug
exists in rocker and mlxsw.

Patch 1 fixes it, and Patch 2 fixes the same type of bug of
fib_rule.


Kuniyuki Iwashima (2):
  ipv4: fib: Don't dump dying fib_info in fib_leaf_notify().
  net: fib_rules: Don't dump dying fib_rule in fib_rules_dump().

 include/net/fib_rules.h | 5 +++++
 include/net/ip_fib.h    | 5 +++++
 net/core/fib_rules.c    | 6 +++++-
 net/ipv4/fib_trie.c     | 4 ++++
 4 files changed, 19 insertions(+), 1 deletion(-)

-- 
2.54.0.1099.g489fc7bff1-goog

