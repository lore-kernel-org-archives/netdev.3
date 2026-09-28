Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A29387566
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 18:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790620678; cv=none; b=QAhvY1jOjwSsq2y38qt5cWpz/bMuAEgY3Je5iPvfz/ZplvsC+sLx2sf3H+SLVTZnCs/VPvFR6QLhLCwdw2kBYozmsbyiP5+LzIxrH17f6Qb6XszW+nVqou7IBqgEIXGHahfK79sjTsDF3Cyt8e7lJeG4hOE5jdXcQivystt+Noc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790620678; c=relaxed/simple;
	bh=eFn8Nkpe/OjoO7N8eyjAC5jFwo1EIashUqCz9A4ucEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DbXudxPVaq+j7xmDGMi/exT+SYUUII96vpqdLbtv37qNlR5iz6qcXQ8wtnWBSkiIY7bbgs8doXQarj74zrjutjYCfyx/tX9UpSKdLWQ7G0bgIgtBhKZXL7vFM7l4y+TqXa6eEW5t0ueKg1aswujNya6aqhcOApTNTmq1rRaAmco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aYbIi7nq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aYbIi7nq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA8EC1F00893;
	Mon, 28 Sep 2026 18:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790620677;
	bh=f9k3u2alz4DWDriiAqz1HlFiBeD0wQrO5D6ZnArhzu8=;
	h=From:To:Cc:Subject:Date;
	b=aYbIi7nqLkPv2H72lkdPEn8R/ocDQbAcqREKliFYMpMQ/6bJjQXTDKkm7fQmia+iA
	 U/LjTtPuxltoqxAQDeV8J8iW1YsSsV8C/XnyNkpP9BvRzvGmyS0MHyDZee6tK0Ce6v
	 ChEPi9YwJb7gLCB8Wm5V5NbgvmkIH2qZwIXFGsNtx3ahtrqALflYwOGTqAhFN8CXnS
	 Rsjm8+CajGbKzbJcy/Gsp8fE2iUo9cTNs9uKX9fcgW7ViHKRtsZKJTQi/zOLpuSswV
	 SvsJcEDxuHZHhoKpzQuFXI3sbQXdcFq8wAf1JOI6OeINbJgzVsVT6FGIZTO2Pzlne9
	 nQxQxETQN2PXQ==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Alexander Aring <alex.aring@gmail.com>,
	Farhad Alemi <falemi@asu.edu>,
	netdev@vger.kernel.org,
	edumazet@kernel.org
Subject: [PATCH net 0/2] ieee802154: 6lowpan: fix transmit address handling
Date: Mon, 28 Sep 2026 18:37:51 +0000
Message-ID: <20260928183753.3550210-1-edumazet@kernel.org>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SEFCOM lab reported a warning in lowpan_compress_addr_64(),
triggered by an AF_PACKET socket sending on a lowpan device.

lowpan_header_create() stores the 802.15.4 addresses in the skb
headroom, where lowpan_xmit() cannot tell if they are valid.
It also reads the IPv6 header before AF_PACKET SOCK_DGRAM sockets
have copied it.

Patch 1 moves the neighbour short address lookup to lowpan_xmit().

Patch 2 pushes the destination address as an 8 byte pseudo header,
like IPoIB, and lets lowpan_xmit() compute the 802.15.4 addresses.

Eric Dumazet (2):
  ieee802154: 6lowpan: look up the neighbour short address in
    lowpan_xmit()
  6lowpan: fix warning in lowpan_compress_addr_64()

 net/ieee802154/6lowpan/6lowpan_i.h |   5 ++
 net/ieee802154/6lowpan/core.c      |   4 +-
 net/ieee802154/6lowpan/tx.c        | 128 ++++++++++++++---------------
 3 files changed, 70 insertions(+), 67 deletions(-)

-- 
2.56.0.rc1.315.gc6ed9934b7-goog

