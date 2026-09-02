Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008BE24CEEA
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 03:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788319777; cv=none; b=QEtOdiXd26zQ/Y74QMCvVfkgXl+bOE+kOY4NH5Czm4exgSd6K8T4sUxW0N9qwTxxM7gMiAgdXBE76flXhMneE+0yISt/z3lHFA0Dx/0xdg6tlRiYwYlvHricqktx5xCBCvCTv9ANre60lk2mvTm1BJvNoOS2sMXKl6LceppM9dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788319777; c=relaxed/simple;
	bh=RbqcvTwWMrzPx1+kHJg4Is7R+RAuKCLGnVGOtfhq+dQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TqPDBWWE1K/655CM6CQXuGXpEcdnzONrIeixEPPyW5qUMahqIBRh1Fs+kNeL0VCjNbpwJs1PF+bI+wsBA73znEM360MoUCkFGQ4cmZYd4LwMl6e2qkJDD/bOuCNgleHk/mDD5vtOatyVDt47SG/LaPpI+lOJVbP4SqhJIVEmyjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DvLH7Ncd; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DvLH7Ncd"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so548306a91.2
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 20:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788319775; x=1788924575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BpoVdObqkq/zS7Ov+RMRDQgEpXGAbsWdSRwORcEMa8o=;
        b=DvLH7NcdMcrK8X50n9lv/AXv9wsWe+dxpUukVTz90lXs1sGn9naSJVlHv2qX5GZsuV
         MQLOlysb5I2A7r8W/4BWAUVFA8IvSJOc16zF7o2Fnd/V/evUVxdG4qxKPd+glai+obOt
         ysPaSAtWpHYH/KEPSnvW7GY5fxJeSGTq0VfmIWSxkr9TDgtbImnhqmGkmnDX1xh6QHEo
         r+ci7y1pB76MX9aA1pvZ3A1NUKeqT5uExkeUOh7tb3xR7QAloi1wRj1UQn7gNlFmq4zU
         TUS8xFMdg/wkvUSBx/MWKZD+J2yHectQCF8Wklxy/t4MFu4d+8Ln78EH7Rv5QRWv6FyN
         OmSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788319775; x=1788924575;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BpoVdObqkq/zS7Ov+RMRDQgEpXGAbsWdSRwORcEMa8o=;
        b=OdfikKvFooGoNy8EZS4pT5elzQONoTPT30ntAc4tjMG3HUtR2QAoYsDVW1llU3wOI1
         094kIQFAsCcLPllO8ojNL6rLGm97hv9L5xvEikyci6kXO1oQyEEU4T344N+J261JPsYz
         hfIXq6VkyQ7trkBVd8/hMIs8Hggf7RSkdwaLvx2PspniDZDoDla5ZENIuvgLFhHmsdaP
         ZExSQfQS9sJqkvZusaZuoXwMQTz7xS0v/R7VAC0LRXNyybLcdUv38+F6vFzzB2TqFnqw
         n3/kgbwAddYFQu9Ea0IyswfYpE4qd6lVOWBGUG5SOY4byc0SLqNF9ngnGT26IxQKFiXm
         3hOg==
X-Forwarded-Encrypted: i=1; AKwUvBw9GccxNeBPHgabXtf5TBgqIyRB39OaHnPNB3WJBr54mgCAmbBjhkX82W45SLMjng5SNlrmkxM=@vger.kernel.org
X-Gm-Message-State: AFuF++nApjpTHC/Fkg0+dkcRaYdb7bqV8Ddf5UUFtqeyGz0ldQmKX4OO
	TwJkworW3A/+bdswrWN58GDF0b1XbuLjyp7gB7E98vaKW8GCzL0Bpe34
X-Gm-Gg: AYBFou11WNJwvT/EkyNfzrKbAdzItDzC1NuMDYXY6vMwXbfoSWR1KAM6nL1U1JvoWzN
	b8mTGJ8LAIfaY1y82VvnVWDnVuKT+SzQxzyfYdP0AHDOC1c8Dh2Gbyf535Xplyyz5+EZCFv81lx
	BL5ZUxeTZGw8JjmMAPwtf2innfYQFmILUkJnVp+CT5iG7FiIk9SaYza3QBjAgBTZsYh8sMXmuOJ
	UNjyiQ4JS724F4UleNchGOL4iaTw08nL9guDht8nrYZEVjFw+x4gw6Ziia5UD4tOqwOcB+tZmwO
	mpoHJbMfnH6PqKqbnxCpCVztWESCBcyx/rZizyOfiiz1PAYKXYXcUiw2fa6Yj/mVftjBs/qYV98
	b48/JHQ6+5lvjJDvCTxZqlw7XjHOaBrCK3ijBCzGBm2a5vQYH8+9Hdmw4mIYHp5M05mSSMNc4aX
	0lB6ooqDEJCHsDXHzl0cJ2dUJ7iCjRYOhWRjwVgEyI
X-Received: by 2002:a17:90a:ec85:b0:395:5f43:4ec4 with SMTP id 98e67ed59e1d1-39aedc3b980mr2784795a91.0.1788319775344;
        Tue, 01 Sep 2026 20:29:35 -0700 (PDT)
Received: from devobuntu.lan ([2600:6c5c:6b00:316::23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32f07baa594sm3099307eec.22.2026.09.01.20.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 20:29:34 -0700 (PDT)
From: Matt Vollrath <tactii@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matt Vollrath <tactii@gmail.com>
Subject: [PATCH iwl-net 0/3] e1000e: fix Rx bugs
Date: Tue,  1 Sep 2026 23:29:10 -0400
Message-ID: <20260902032913.661570-1-tactii@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix some longstanding bugs in Rx.

The first two patches address DMA mapping failure handling, eliminating
some conditions which would result in DMA_MAPPING_ERROR being sent to
h/w or to dma_unmap_page() or dma_unmap_single(). A teardown leak in the
packet-splitting path is also fixed in the process.

The third patch fixes buffer overruns when RXALL is set.

Matt Vollrath (3):
  e1000e: fix Rx skb DMA map error sentinel
  e1000e: fix ps_pages DMA map error sentinel
  e1000e: fix NETIF_F_RXALL buffer overrun

 drivers/net/ethernet/intel/e1000e/netdev.c | 75 ++++++++++++++--------
 1 file changed, 47 insertions(+), 28 deletions(-)


base-commit: 1d2929d0850fff683b8aff051275945e65f082c8
-- 
2.43.0

