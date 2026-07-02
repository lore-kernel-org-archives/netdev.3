Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF7730FF27
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 04:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782967480; cv=none; b=GlviSEYdLldKHj2O5y0GpUeDyhxWD6pEobuoRwwGTO5Rav5aIsjVQWA2VDydoJqwm6ihmhXzj4R+KycrBNQ6xl/QZEeSwsiUGYbSqnPtRahZOhrADpy9CLw0smGSj4DQtDn4I31qGDHPH8QTYxPIK2ypfWqX5GcKbZ0UMzN/1HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782967480; c=relaxed/simple;
	bh=mzRk+vGmxupqTsnfd2sC2Q3s2XV0vj1HMIb8vfZ/gU8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PJF9RKihk4svrHVPLbmFf5yZOV7LUHZo2HoWDnFTLohPvP51dkVz7hBrFTOs+68JGrXWAyTiLqnLx1L6a7wtIBBnIUdgWIGSRxKbQkpUPU2oLg8UXQkanzH804xQsSu812ZDgPtnZxVVVaMaDqfLuPyIz0tZFhNGI/5YZPrEkEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AJ7AFyht; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AJ7AFyht"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8478423e020so1948977b3a.0
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 21:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782967479; x=1783572279; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CrSAvOH53RwfVg0o5n15sIG7RlqJ8qPe+x1UadQEMJ8=;
        b=AJ7AFyhtHMti2WeB3H1OW0WCs4tFr238n+waFe4OivwGwzGA2aexvGIoe+7vSKnpuk
         mNlUeqGSdLUlhrrEELKFo/jYvnTzVDvVD6no1HbdYcaqLc5BSbk+/nzfgOpMEutR1xg/
         txZ//q/tJrfZqg8KwGl1CCvUW5HXkND2ntsjvktO1tBKWHm5eXz/kO3bG6CFaAtPgvPX
         LHV++qFoIm1ypTYbbBqLQ1Kcam51+eQw4TCRzIRH2KnoDUjgXxDrhQlBAujQVWDo70DG
         0fgN03QHJxXfhxbYMlrCnaU/j0o5S/g2yGoaw+uE5BovniqrCXKUK27fOkw0U6kd978l
         2Rmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782967479; x=1783572279;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CrSAvOH53RwfVg0o5n15sIG7RlqJ8qPe+x1UadQEMJ8=;
        b=Z1wG6m2R+icTQxDfuNfDnJxJ12DQBGMQTFt58NQ8S/wXtfdIKPqON3IOvgjjs5ca/c
         2KXmg2AqDrgrti+igTquP8Sa2OE/Yj1bBvOA5o1tzl9mMKc2fDqZeRSeZnYH1DKrEADI
         als1510RY8h0IkJi4UaVfwkM+hUPNvHtB+jlPeoupnEi+O/mOA4f8oDuzs/yUJGo1jV8
         078UClPA4clUTYgwR69ol/Zvf3r1NAuEGhvEERTq4mjaQiUgIazVjs1yYrHTDmyPpdFI
         l2mHDNbfdJRDB6XkLiIFvOqiLva5e+YzHaKbFcpq7TLqPzHg+3hSTSrEtf5IrsIjKVPY
         lQRw==
X-Forwarded-Encrypted: i=1; AFNElJ+V3aNR6pdG4xY3nwDLE1ojFWUz7OlgjYi8DgAEiApEXI+dPmEMUddYuRu4zA6cLXgYl3jMgg0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxgWqUsaaPjbu2zZIAa7Deg8YA5eYO+F4BdIyZvVFVpzqIiiVw
	tq3X9XYfi3Ue0ueGDfDWVQZ9z/Y8VnhkXhTgu/pHpRI8kIiETco2LXVJy84LS6QmPdCVC10fwJc
	8Jvh+2g==
X-Received: from pfbly23.prod.google.com ([2002:a05:6a00:7597:b0:847:9472:cf8e])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:9504:b0:847:9745:2f83
 with SMTP id d2e1a72fcca58-847c06dddf0mr4562617b3a.18.1782967478454; Wed, 01
 Jul 2026 21:44:38 -0700 (PDT)
Date: Thu,  2 Jul 2026 04:44:13 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260702044437.591864-1-kuniyu@google.com>
Subject: [PATCH v1 net-next 0/2] net: Misc follow-up on RTNL-less fib_rules series.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Patch 1 moves net->ipv4.fib_table_hash_lock under
CONFIG_IP_MULTIPLE_TABLES.

Patch 2 adds mutex_destroy() for fib_rules_ops.lock.


Kuniyuki Iwashima (2):
  ipv4: fib: Define fib_table_hash_lock under CONFIG_IP_MULTIPLE_TABLES.
  net: fib_rules: Destroy ops->lock in fib_rules_unregister().

 Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst | 1 +
 include/net/netns/ipv4.h                                      | 2 +-
 net/core/fib_rules.c                                          | 1 +
 net/ipv4/fib_frontend.c                                       | 3 +++
 4 files changed, 6 insertions(+), 1 deletion(-)

-- 
2.55.0.rc0.799.gd6f94ed593-goog

