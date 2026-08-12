Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F933DF01C
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 20:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786568391; cv=none; b=Ne4jJqFbOm4CUbsnz3Ze6mzaNN9Lub1hOFNHKow0twqB3B35WeiftzZqYCE5CHvoDIcPd8VDu4aGbNH636DgHEQI0i6GvSS8Regu1aCt2/6RYtjmKLnR9m9MtOXb+CVYm94SO8RGp99UujVLmis6sWObSZwFlm5dCNwF+j/qFvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786568391; c=relaxed/simple;
	bh=lxtfdgUp5PovhyJraGzJokizZpdhFjLP1J2mxK6yHXg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=XJj7469Gv83kSchUJ0bRjsHcHOjalZs3prE7mhGgFVcs6wVv4gO77ByCZYpAjmoNPhEM+nJzraU2DJPu+wFxTaCuyVMohwJJrFmPeimLwZNezzSNsDnyH0fVotQwsNDwSUrdfzI7gzI8GnPws+/xVYb0sxTjnA+BrdNRWdN6MtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mIgsom4l; arc=none smtp.client-ip=209.85.222.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mIgsom4l"
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e53b8a302so4202185a.1
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 13:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786568389; x=1787173189; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NDOAxgsJDN/bf6US/YQL19qlPBZqmv+z+N+sVZZyX2o=;
        b=mIgsom4l1/eGaex5YvyE2+90uVQoeQZ6QAW2qDJ3VGDCctHFqcZHg8B6WgSXnRHdmb
         q/I/Vr4AibFHXuXkaweQIyL5rYEXiij9MUawtAJEf+S1Cr9EYPPIyDWMyPWEQU2OCQDR
         Wkqk1y9cP1r9f/yymsccEkEKt4RXVNvZ5HvGbh57vR8bWvUmWJn70c7nldGuYll5Dso8
         cdE9r8LBQJ4ZwmwJzNNqv8EYR9Wwm7MAtckTWwcLqNMNSRxO90IljPojknAdxTTfYe5n
         vrslKoGu36fkRubPaw3qdD9iSC5WnLM+W+7RCTwlJXSVsVqfBgRCKNKbZQYjgtn9bHrf
         W/uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786568389; x=1787173189;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NDOAxgsJDN/bf6US/YQL19qlPBZqmv+z+N+sVZZyX2o=;
        b=rNC62jHZkfY5aQq83Gjftip7j4OmmhpSp9g8hc6ihznUApfYBuxSmFa0owLMLs+MmD
         IuXxS4O+g5v5U94dnkZyehyul6T2kBQMeKnFv8HLfdYYDeVt3sTP78UEsJIKWL2sfxTH
         Rh16tMJ0BcKU3jYdHjlp989RXZ9+88t3eESzxXrvd+CcHnpyTF/8C5cf/n49wKA8ae9s
         B5q3kgOQa1rjoFrh3gi3PuASiXw+M6XSpZGo5MJVnqZbNMQ3LSaabzX6ASRHqKnWJucZ
         a4Lk2gLKiZdyMKSM1Wftn6DtbUo9ch3MdeIPRz5EA2xzHM4qihwyIlwCAm0hNVReSXC5
         FLnw==
X-Forwarded-Encrypted: i=1; AHgh+RrkFz6Ky1MqMVYgcAqNeYrC66vPcccDUwWYCWSozO3jGgBzKIWfas5LPUPNlMIOaGmqRPfUC3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkY7/bDP3W+cvRa/LuLQ6V/bwxeWsSzjHv0+SGm/M019CSVXs9
	cfN476XxZcMA20YHkzdXINYaZbQ9xd7wQEEi9R3S3LDPBJUXfu1G4Zzx1b5UuLyxwXUTYPOctq0
	IMOYvhsEJNp9cDw==
X-Received: from qknry7.prod.google.com ([2002:a05:620a:9147:b0:934:aa76:abc4])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ae9:e919:0:b0:936:9fd4:e2bf with SMTP id af79cd13be357-936bfa9e9e8mr81194685a.37.1786568388785;
 Wed, 12 Aug 2026 13:59:48 -0700 (PDT)
Date: Wed, 12 Aug 2026 20:59:44 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260812205946.356185-1-edumazet@google.com>
Subject: [PATCH net 0/2] inetpeer: harden tree sizing and address side-channel eviction
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	Michael Blunt <michaelbblunt@gmail.com>
Content-Type: text/plain; charset="UTF-8"

This series addresses a vulnerability in the inetpeer subsystem where an
off-path adversary can manipulate garbage collection to bypass IP-keyed
ICMP rate limits, and hardens inetpeer memory usage under pressure.

The inetpeer rate limiting system stores peer entries in an RB-tree keyed
deterministically by remote IP address. Because tree lookups walk the
tree using lexicographical comparison (inetpeer_addr_cmp), an off-path
attacker can predict the tree topology and the exact sequence of nodes
traversed during lookups (the gc_stack candidate list). By combining
predictable traversal with aggressive garbage collection triggered when
the tree size exceeds inet_peer_threshold, an attacker can selectively
force the eviction of targeted inet_peer nodes. When an evicted node is
recreated on the next packet, its rate-limiting token bucket is reset to
full capacity, creating a side-channel to bypass ICMP rate limits and
probe for open UDP ports.

- Patch 1 enforces a hard limit on inet_peer allocations at 2x
  inet_peer_threshold to prevent unbounded slab memory growth if GC
  cannot free entries, and ensures inet_peer_xrlim_allow() fails closed
  (returns false) if peer allocation fails and returns NULL.

- Patch 2 randomizes RB-tree node ordering using SipHash with a secret
  boot-time key (inetpeer_hash_key), making tree layout and GC eviction
  paths unpredictable to off-path attackers.

Reported-by: Michael Blunt <michaelbblunt@gmail.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>

Eric Dumazet (2):
  inetpeer: enforce hard limit on tree size and fix NULL peer rate limit
  inetpeer: randomize RB-tree node comparison using SipHash

 include/net/inetpeer.h |  4 ++++
 net/ipv4/inetpeer.c    | 43 +++++++++++++++++++++++++++++++++++++-----
 2 files changed, 42 insertions(+), 5 deletions(-)

-- 
2.55.0.691.gc56d675ccc-goog

