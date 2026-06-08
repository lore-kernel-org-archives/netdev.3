Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BE9330305
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 15:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780931276; cv=none; b=tZL4QU1bKnXcJ3LtoCeIKUwCjvT14nH229f7gVs+2XnNRtSqcLQ0XnyfbhQKOrz1FMHsIA/oPG7GR3i9LvPRhUzpWAjC/hYoaBIEQhNJESR7tUBTysf3Nfi+VrewBgNSi4dfYtE5CTaGfH7htqHXUdN/sXbFbCgH6SdBskKezrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780931276; c=relaxed/simple;
	bh=gFi40E2sopGCzda5P0KonalMSixfFtduEK2c4qKsWVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VLFoC0KXYNfr8gAQZgksVkezZScFtH1jouJADOXfx+h5xmtGGL+uJ9/pdR7dOHeghlbdSaeKId/ACAzzYSb6iT56PvEHd8/l0terePTnr38TpjwD6KkVFCZb3k1Obb5bJFP11aI2Rxp21gNhSYQ1Ssk7t6sClxhZY40i/C1zcPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=QHkbGeMl; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="QHkbGeMl"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490b2b037d2so39113565e9.3
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 08:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1780931273; x=1781536073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tsvpwngZ7lJt2rJV8xsJrn6CjirJdz1zBb38gyYQoSo=;
        b=QHkbGeMl10mMWTaRVXTqrRpP0+WUNgVmWI5zL9Qd/Bc3rdFIjEq8Q71ivtUxjdh/xd
         P5aCPAcP8179V8ngGTScrwBbUq47yqU8kmIqiIs/s3EVdpLjf+CIm365LMGWoGLxsKz3
         qdFKQwvTy41wlIIa2LXp+TLYGioFtLe1cmeElWgHSDGn81gnsimgaTmVYyenLBMTdmbh
         Mo9wG/UKux+pUVapMWVT3rNzWH4YWgBv6fGAuP802If+joHiJOQQhuq5QyZryLfDWm0H
         gayWKqm7oIou6OhVzBXFI4+/T6VFnVQ5n1GhzAqNhCvmfYDDcVyrz897nEaLebP1oM2n
         OMzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780931273; x=1781536073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tsvpwngZ7lJt2rJV8xsJrn6CjirJdz1zBb38gyYQoSo=;
        b=Okt8WOU4sZ1AF0HBlGdV7+JZKVhlKriMQHxmxJjuaKNYJkKtk1kMFWco5+M02DdhWC
         pI7craGa49CGqqO5rBIssgJy21ZNWKR/AvxYyjf2XBMqHzuj/D5S1Rrm8ElKxZJK33OT
         HulGxtuKCnCRyaBVE5Ya2v8DI+dAjiLH0mVCwkpk2yCTg7awyrZcwwpFloaT+djB4rCA
         +wGcww/AxUFGQ18vKyGqhT4Wymya4Po8GGkh/NolGPP5qjGTuj753hTXSnM5WrzVFZjP
         c2mDsLF8XWkNa+v/a5Bwx6KSw6xockldoJJP2Wl6kfBEmZqTjNkOoGrSLJ++vL/byvT+
         tpPQ==
X-Gm-Message-State: AOJu0YzFIllwuqoO8XuMMgmcKabEp4XQ2zAI05Z0QVq8jSDCC9RsueXc
	YO+lzvsqoOLAawZyK7rlrFnxw+rXAKiWp/CH4d+2hanX9TZ/hNSFLtgPU8PWfsEieKAWRNuJlAu
	9T4MCmiDgzCe4JwX2h0HAt/CN6568gwPUX03SE6sKsXnTCf/IS+5rfi+SOVDoTOK/M/Q=
X-Gm-Gg: Acq92OGEPboQXaavhTVHdwc/UnBbu/LuXUIcwhcsxMc7cmScmpuH1VE5fJXvqggpz6O
	Qf4x2bXOC3cabmShPhbFCDOtgljlbMcywUNggUj2ojHf8/+VateiPwnRAOPrPuw6/ddAnmpS/kO
	g9QtrQwRxb8a6NH+6Y83s+J56VM2puwX7LIYZxnUCpzUHdMdF715kqVob7gh8Pga+qxMzaYK70S
	k3gl7TZ8OR3BWqCnY7KQapuz+RqNA+Xtu7+Rm/URe+D3yumHsvh1J25rMH7CaOzyI9MuK2m+XzI
	dxibw5mk42dG61vCwfzOFpg0EUdd2LBKSaAA4AzowCKL6UxzkdSr+9szwAguqIPg4KPAvFO+XZY
	s+n2wGpuJVlKApx0TRK84qQ5qBArwWNpNUQrM4TM8HyAmu6g8/1IM5vwq8hRqpKuW3/apEsjSZ3
	eZKZNtPLAF4NfyyLUgr3gUHLO/DKmXcfjyVyMNyc9dz/d+ZCQt6IrhH5yB4A==
X-Received: by 2002:a05:600c:e555:20b0:490:d32b:39d6 with SMTP id 5b1f17b1804b1-490d32b3aedmr17929975e9.19.1780931272881;
        Mon, 08 Jun 2026 08:07:52 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:7e36:aaf2:5280:7b3e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc39def5sm390659705e9.5.2026.06.08.08.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 08:07:51 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Antonio Quartulli <antonio@openvpn.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Ralf Lici <ralf@mandelbit.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Subject: [PATCH net 0/6] pull request: fixes for ovpn 2026-06-08
Date: Mon,  8 Jun 2026 17:07:31 +0200
Message-ID: <20260608150741.3320919-1-antonio@openvpn.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all!

Here is a series of small fixes collected in the past weeks.

There are larger ones in our queue which we are still working on,
therefore please ignore any "previous issue" Sashiko may report.

Please pull or let me know of any issue!

Thanks a lot,
	Antonio


The following changes since commit 9772589b57e44aedc240211c5c3f7a684a034d3a:

  netlabel: validate unlabeled address and mask attribute lengths (2026-06-05 19:05:06 -0700)

are available in the Git repository at:

  https://github.com/OpenVPN/ovpn-net-next.git tags/ovpn-net-20260608

for you to fetch changes up to 7a62530eaf4c7db3f14a2db431f54319241f1540:

  ovpn: use monotonic clock for peer keepalive timeouts (2026-06-08 16:54:31 +0200)

----------------------------------------------------------------
Included fixes:
* ensure keepalive timestamps are computed using monotonic source
* avoid UAF in unlock_ovpn() when iterating over release_list
* fix memleak in selftest tool
* ensure reference to peer is acquired before scheduling worker
  (which may drop the not-yet-taken ref)
* fix refcount leak in case of concurrent TX and RX TCP error
* fix potential refcount unbalance in case of sock release in
  P2P mode

----------------------------------------------------------------
Marco Baffo (2):
      ovpn: fix use after free in unlock_ovpn()
      ovpn: use monotonic clock for peer keepalive timeouts

Pavitra Jha (1):
      ovpn: fix peer refcount leak in TCP error paths

Qing Ming (1):
      ovpn: avoid putting unrelated P2P peer on socket release

Shuvam Pandey (1):
      ovpn: hold peer before scheduling keepalive work

longlong yan (1):
      selftests/net: ovpn: fix getaddrinfo memory leak in ovpn_parse_remote()

 drivers/net/ovpn/io.c                       |  4 ++--
 drivers/net/ovpn/peer.c                     | 16 +++++++++-------
 drivers/net/ovpn/tcp.c                      |  6 ++++--
 tools/testing/selftests/net/ovpn/ovpn-cli.c |  4 +++-
 4 files changed, 18 insertions(+), 12 deletions(-)
