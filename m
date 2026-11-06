Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793985286;
	b=cvA/J8tdbNBQEgWZHKJho8syDKabciCfuEnUVrmZJPQI3K5HBZKS+/KttyQKvCQgQM9I
	 7bD8AGlh5B3JDp7dzyl3p/NGYIV3Am/L/cQ3JSGne+pGofpRUWa9J/tKvEg3kdGJ5oBFI
	 /RGxzjQhlJMPY5UnlMGETe4DhwPD85mdm7g90YlIumi9Sf/wwi0EyPijYbdDisw5iZRzo
	 0tqj7Fi+/Mh4UZNHMG1OFwepJzGegzY1PrwNBbfZYbXZ2x9y6aQRFZyw8TT2/3OMnPitc
	 VndQeDbModlMUs+EjoSUQ2OZS23nH8ljYqhqqQVtaDlQvzRfs1uSu2h+/x2P38h32iQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793985286;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=gFMNpPgUqxIZwuBYx5VHNDYSqSG4TYjNvTKYc8aY2So=;
	b=zomv2B/gHnsgvJMdQ/YZoqi9DyaDPotvmDZ++Zr1GRf3WIJXCTqfdLyAPuK/wyD7iNwZ
	 Z/DTNyGun9yLEovyYA8rh5yy0SN6LIfE7R/VPmYovqoseVG3P8LTvdEd1NccTiwPQceQC
	 xNN5XPYb7z2/pEn4V/pxo5mQcl+tnR73EqXUr7DsJC4TUGAWEYx0Xzs0C/MbpZcQ692Ls
	 KDVZIg5UOItc729y4X1KiqdzNzjqpijlrWB/SFhuHMLrpni9mIkRcJmOdHCgVqh4TsCnQ
	 w2TyyandgghW35TEjo/9i2U37J5p0gTvQ+qsxKkKa55zGoglYRdr8CMv4D53CUi3piw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C3qjFtiv;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A5A606A326
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 17:14:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27A5A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C3qjFtiv
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a20bde60a0so7848925e9.3
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 09:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793985284; x=1794590084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gFMNpPgUqxIZwuBYx5VHNDYSqSG4TYjNvTKYc8aY2So=;
        b=C3qjFtivHTMqEpliOCOxxhF3ZCmOfyL04GUMc2el0XChisOndRclY0s4aMkvcrDWyI
         kPwgN4eUdVa374BsKE1zgaukiYia5UH7uePCYZjv2O6G8Gsi1epwGY64np2/ZquImhLE
         XVwomB8LtcMWnRbJHU2+L4eVPpIiI8g26WX/E3TgUinuWNK5HyUP4GFXTIJZDDQ9LhLx
         6Q8Q2XaM3PF7Xk/Wj2LrNKzCZrAf8OOQRciKrcnbXyGUV37SkBAHaprRDt4Or6dwPwGA
         28vfQbxjxdhaKLGSDLJKEsi9r9IQrCJ0cRk8kZTLt0vyEUabmVsPBcdGGxWkScwMyDfu
         oG3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793985284; x=1794590084;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gFMNpPgUqxIZwuBYx5VHNDYSqSG4TYjNvTKYc8aY2So=;
        b=UPaLziBuFf1VO4VZ7Z9bG2bk2WVf5/341HZ7kOgAzZx6llyCQmAnJJEUEjSJbDxYjI
         3u/Y0Zc1za6a2RaaLExI414rroNuVYUCQIruo54Nhzw1p0w2mvEzC9iFtYZC2Vml5fNN
         Pe+pQMM1X2ToJtAt144nqLMVY4elJ46RoMUdFAsXs/xk4oKSW4Uq3imP+fip55BW2dPp
         mwC9DihZJ66UGmgg13ayls3nNCJ8pe0ccKcqplpUYt3RZJpNutQBBERGWlYj+u0azBU7
         EgeIj0OBuVrcFYm8LKsTmwmlCs/HUVICofLQuZ7/dRUfvLe4S1J85m1gsLPwoPhjqV1n
         CHRw==
X-Gm-Message-State: APuU4Z9U2X7mLAKXmqXzytbhY46eyi9wt6+m4GEuKmRrUBn5ql6GKBXJ
	Px5oNO6VUOl80/Ufmmzbg8NU6xPqCyUICt9BTnyo+qkjrgcNnjHGDwDRwtauLhva
X-Gm-Gg: AYBFou03DhRqb8+yZMU20cvkmhoIfOoeMJ6l7tnApwzXjGGO1GuBoWFXP9t4ppwRwnx
	T+nm9/lWRCcJDPep7rrFgDBxtLaprIMlKPLyCGF3YKP1kktreLMjKl9vUgR7LnGaNgEBqsqFtpN
	FiW6DhWBfT3S8KJj8AqsVXoqupq1jZX+OR8De/wCBXowts4C443pFuJOZYI+A8gPW/UKXcus8da
	r0OfLnGcm35IQHNOcAhzkz6srMxW8CLQocAM1IuCT0MUQ+TCQyorWnOv6zahsBJKngG4aAut8b0
	86XJWaUxs2Q1UXZTZnmHEaqpK/oLvGEoPm/tinhqDGXSOd0bV9mjHMQWl7SqQKIxkmJDV5sgmjJ
	KvasvWU6RhnugjDNR6s5rCYco+nhhn9BxgEtqnvhiaLQkZaXtkHM/JCeTDTElLtOUPAFcwz8pBp
	rPXHGUOztiQyzEs4roTcT1PkZx3KSxLnSDC0FJHC4T0by5Yt5eR1TnKGtLQ/hMMHZWizKcOkiT2
	YnLeLEN657hVrV5qfwzZNcdYwrmmTi6pNCSj69zzwA0iUJqiD+mzeGDDBrRJ2oBmLRu6X/QvPgL
	j5tD6Qw8vKysy2HPcMxHGWjYPUd8a7qwBgMf8evXYeFSM2hdyL+R6COo2eZwGRI9o3WOd/txiOw
	Gv4vRV0pX74aML3SJYNC0zD/xFZD/FiD/kM7+ppdatzeqJtuUanaBSPAXYsdyIx7uq7ZIKKPx54
	EUJr1GNlpATBEf83KRztFrzd3FsKV99GWs38PvNuWe/QilH7G0l71r9VGRVdQaqA==
X-Received: by 2002:a05:600c:5391:b0:4b1:4da2:ca99 with SMTP id 5b1f17b1804b1-4b6dd82a9aamr53584665e9.10.1793985284502;
        Fri, 06 Nov 2026 09:14:44 -0800 (PST)
Received: from localhost.localdomain ([90.95.39.175])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b571f46489sm148071985e9.3.2026.11.06.09.14.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Nov 2026 09:14:44 -0800 (PST)
From: Florin Badita-Nistor <baditaflorin@gmail.com>
To: netdev@vger.kernel.org
Cc: edumazet@kernel.org,
	ncardwell@google.com,
	kuniyu@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v2 0/2] tcp: fix false exhaustion of odd-sized bind port ranges
Date: Fri,  6 Nov 2026 19:14:40 +0200
Message-ID: <20261106171442.31811-1-baditaflorin@gmail.com>
X-Mailer: git-send-email 2.51.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix false bind() exhaustion when an odd-sized local port range still
contains an eligible free port. The wrap can flip parity in odd-sized
ranges; even-sized scan sequences are unchanged. The namespace-wide
connect() allocator is not changed by this series.

Earlier x86-64 KVM validation of this unchanged allocator/test code:
- Regression test: four failures before, zero after (eight cases).
- Full port-range suite: four failures before, zero after (80 cases);
  two existing SCTP XPASS results unchanged.
- Go net.Listen, 100 attempts per IP version: 100 failures before,
  zero after; explicit free-port controls succeed in both kernels.

Changes in v2:
- Target net-next and drop the stable Cc, as requested by Eric.
- Document parity changes on odd wraps and scope the fix to bind().
- Shorten the cover letter.

v1: https://lore.kernel.org/netdev/CADnh+D0zSzAyYCLo5cXU56o9X-P3RG3N2ix7ARPrP95d8sBXmg@mail.gmail.com/

Florin Badita-Nistor (2):
  tcp: avoid false bind exhaustion with odd-sized port ranges
  selftests/net: cover odd-sized local port ranges with one free port

 net/ipv4/inet_connection_sock.c               |  2 -
 .../selftests/net/ip_local_port_range.c       | 67 ++++++++++++++++++-
 2 files changed, 64 insertions(+), 5 deletions(-)


base-commit: bb67589c87249c9bc2415ab11a754d6e303774e3
-- 
2.51.0

