Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2ECB640
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 00:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791419771; cv=none; b=N7YK1mGMyYlkc9IBKP6spOiB+NaG7wGQuCVGEmhCovLW/qoPAQu3OYNZvvA82YH2vJkAn/Y/XOCNq5HNSBI7qspmh+oW1IvMnna85qU85drO67ItwbtLiYqT5+GRr7IqR8dtb98+VN53X8mdKAMoegbvVM1/zYjT0UycyRl4G58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791419771; c=relaxed/simple;
	bh=qIrdR/Ag8MQ81NDYfzYS8aCyCNFMRqUJm3jjYZREfG0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L0gR7tRdpxbJmFqRfzgUqnFAPaeQqj/zLEq8VbYfqxKOzRfAjx9UldpZspubM/eGV5BnEblpSPawBb9aMPU7b5C3XGX5x73HSWDEPgCDUZiKpJWKGnYNNU6UEMoUxIL/qt3lAJAhPvyq2iWlCNkrKtSNKWN3UmgX65KzNNr2a5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net; spf=pass smtp.mailfrom=blockcast.net; dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b=bfyp9Lrp; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b="bfyp9Lrp"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-3517d4e49ceso47665eec.0
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 17:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1791419769; x=1792024569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OAYPbM9arh//yPx1DUNlCUxplQFAp35wbh227b4ynrU=;
        b=bfyp9LrpSAjZdGPXWZyIvsDx5Jwn0AF7CBbtKvn9ne140O0S18nrcbFkOzgGXNMEQ1
         q2nzg9lWi+6I1Boyx0jHTMN58EgzTqUEoWFJuu1DdTUtXzkgf50Fc4cwFWFrYVIrr2Xz
         JNRX5il/pxSi4vwEAqI6SiYfg14Jt+c9kcWvHXNyX8pXkJgYCeWmtW4C0UWysX9e+Tg1
         LxTaUFZQ74xGvi1Hmt/1WQHC0Ym2PynRw3VkIb429HSKQQukdnIL+xxlFH4R0VCmeCEt
         nMpp4WXKLE1Bzm+vpvGmymfKDMrwKaR+swhoK27MNDpp+9yNj5NdRE06XGjh+Waj4XbT
         4nbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791419769; x=1792024569;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OAYPbM9arh//yPx1DUNlCUxplQFAp35wbh227b4ynrU=;
        b=uhXZdzcRy5E3+kdm70/HyiwpFYxWA8NAoJJD4LQNfG4LvH7wGnMi7AdZ1n3kyGho0z
         jh2mQdZivsJmGDL5t9azKW2mJUmMAfO5/oNFzUK9u4x7E4rqXAfhDZi7JXS3O6N3tirK
         rU9LW5YKfexfM1mp5Mc26OqD+V7Z+4SiVayDShdHSesSNFErvyFSYsj6pHe9rvawnH6u
         gZ338gj3P0QyBMHr6/iZ20Jwt3WTjaeROgGeGx9PKBms/uLT2hKF6HLmTQoyx52Q6rC1
         W21Z0VQB8hVjUzrrT6oBPCPDIA9nWrad942/oLOcx+W1/qkX3BjgHSXO5jGoNXQXQD5r
         +J+w==
X-Gm-Message-State: AFuF++nDS+lN7zEtC+KkmBeGMj/z8yilsJ7zTcndz5qo/a1AXoRpKG3c
	kKQwdO2uFZ6wUknMOKTPe+7Z6zBN+at0LSPFB6e545HTQ2JlbgYnZ15wdwRsNCJGBHA=
X-Gm-Gg: AYBFou38xWPaauErwGOBJu3SLE2AReIOVuL8YVjDGHBUomXTRrjrP0fQnZs6vIN+ZZq
	IZSS1Fwau6FIAx+FJ5TDnU6HMr/qyb58BUQaQ0CPNde59IwP0F+QoAZL6AlUFB9vXpy2DRthaI9
	ZXBZ9VIEKll/8wXHGC3gaULPTIkzOy0iaLGiAKO+pT1l6Gh2TBrF27Ga9Q/wG0OUOyrmAWf99gk
	Zu/0WpXrKDkYG740GMYgXOmAkKb8/sJ3BzK0MHgxaC+CKoal8uNoDojKqyUSOu5V4OzVB9pmlGq
	YLIyPgdZWoD55NQQ0Y/tCzBg7INhkHDRMLeCfNGY1tT4QI4bCCtMG8AM3OZy2cSqmQGkR3efXXN
	t6yCxkEyZRdh/Bc4XVUgJAh1QuBMBFvaDMhEkUXRoY3Vyc/OX8DCyWwUGezNiOhztyP5QP8xFcV
	MEFqR03NdiF/5MOmmiuEIn7hrB9kXsoBUknaHwxgg8Jfkkp/mncgOezR9kDzci7TnTRsIES2yyM
	AM6nuicDODEpUMF+0PCUCSTjDoIBC7DH80YAYX0d+ZN+Ypj7kU=
X-Received: by 2002:a05:7300:f291:b0:351:2f0a:cb2a with SMTP id 5a478bee46e88-35177167717mr959559eec.2.1791419769075;
        Wed, 07 Oct 2026 17:36:09 -0700 (PDT)
Received: from devbox.ts.blockcast.net ([2602:f74d:1::32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-351735e316fsm3496694eec.11.2026.10.07.17.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 17:36:08 -0700 (PDT)
From: Omar Ramadan <omar@blockcast.net>
To: Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net 0/4] amt: fix relay tunnel keying and unauthenticated-Request DoS
Date: Thu,  8 Oct 2026 00:36:01 +0000
Message-ID: <20261008003606.3666617-1-omar@blockcast.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes four related problems in the AMT relay data path in
drivers/net/amt.c. The relay creates and mutates per-tunnel state in
response to AMT Request messages whose source is never validated, so a
spoofed-source flood exhausts the tunnel table and reflects Membership
Queries at arbitrary addresses. The same code keys tunnels on the source
address alone, so two gateways behind one NAT collide, and it drops
several packet classes with no counter.

Reported privately to security@kernel.org first. The security team
determined there is no memory-safety exposure and no embargo is needed,
and asked that the fix be posted here in the open with Taehee Yoo in Cc.

 1 amt: key relay tunnel state on the (address, port) endpoint
 2 amt: send the relay General Query directly instead of via
   dev_queue_xmit
 3 amt: make pre-query report drops visible
 4 amt: do not create tunnel state for unauthenticated Requests

Patches 1, 2 and 4 carry Fixes: cbc21dc1cfe9 and target net. Patch 4 is
the core fix: the relay now answers a Request statelessly (it computes
the response MAC and emits the Query without allocating a tunnel) and
only commits tunnel state once the gateway echoes the nonce+MAC in an
Update. A spoofed source cannot complete that exchange, so it allocates
nothing.

Testing: applied to net (v7.1, 8cd9520d35a6) and booted with
CONFIG_KASAN=y and CONFIG_PROVE_LOCKING=y. tools/testing/selftests/net/
amt.sh was run against the booted kernel: the discovery and IPv4/IPv6
multicast-forwarding tests pass, with no KASAN or lockdep reports across
tunnel setup, the gateway handshake, and data forwarding. (The IPv4
throughput-torture subtest streams ~1 GB of /dev/urandom per family and
is bound by the sanitizer-slowed test VM; it was still making forward
progress at the time limit with no splats.)

A companion change bounds the number of verified tunnels admitted per
source address. It adds a new netlink attribute and so targets net-next
as a separate posting, not part of this series. One note on its default:
a per-source cap closes the non-spoofing exhaustion path (one host, many
real handshakes) that this series does not, but a low fixed default is
wrong behind carrier-grade NAT, where many independent subscribers share
one public address and would be refused past the cap. The net-next
posting sets the default accordingly and documents the CGNAT case; this
series does not depend on that cap and closes the spoofing primitive on
its own.

base: applies to net, commit 8cd9520d35a6 ("Linux 7.1").

Omar Ramadan (4):
  amt: key relay tunnel state on the (address, port) endpoint, not the
    address
  amt: send the relay General Query directly instead of via
    dev_queue_xmit
  amt: make pre-query report drops visible
  amt: do not create tunnel state for unauthenticated Requests

 drivers/net/amt.c | 315 +++++++++++++++++++++++++++++-----------------
 include/net/amt.h |  15 +--
 2 files changed, 206 insertions(+), 124 deletions(-)

--
2.43.0

