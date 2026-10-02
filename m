Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E8344CF40
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 08:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790929646; cv=none; b=IaGOs+HI8TVP73EGxaHIvWZZ6nG0mwX02hhxSWXOzSiSodeZLR7HB0UL9OfKMwRnIZlge7xOexcWCkUUXh6OEgXH0jMSL2tVQV1RvWTvK0FpXHUj5NEHsihzwcJUuJuDdI5GWvgYUXOOpqaXRwnymJiq3NRqMEz9ZNTH48KLKAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790929646; c=relaxed/simple;
	bh=i+DJirdxkb//8HQjBqPJxIj3Iu7TxyNaxdgcHZ96P2o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h4GCeca3LHHg/ZRoyfgw8HnoB8tzNGmBp9xFn4UapMsMUuHOeGcij8NUeuBAo7ULpN9JAUGq0VIpJjqwg9wIEu3vS0eFHGA64JjG1EO3gkNnJgLvNSazZhtpqkIzeiv89D05MbjboW5kkgKXT06x+Zb8VYZnpHKNKQnfrdG7vL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ClrGXRP+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ClrGXRP+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6CB51F000FF;
	Fri,  2 Oct 2026 08:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790929636;
	bh=my126JRrtrnaXrVUa5wB9lFEoSLes/Rj50ZkZYX5cww=;
	h=From:To:Cc:Subject:Date;
	b=ClrGXRP+gehV08QmT9Ha27rkuWLSJjI2umLRveY6aGSHCbd1ukLL8GDPH+NivaxBd
	 iCINnQTiEJsDnzlFDAI9QtdwmAElXFIcalSz/I7WOpZjaN8o7JYPKHA4DgqqXOL8nY
	 HbC5b7vnl+I16rnGiif86pLuYNNhCv9gwQaULFAHYmaAWHGG4a9dw58NwGw95Mv6VM
	 zMF75F8q/1RUcZhNiLkchTKGssZ+D/WGth0vFVkseQUOzzjzdmtOUkjetIiXYd6h25
	 o+PcyMeiuaXR1sk0CHXHobdf6b+//6IHYCuF2sEXWp4jdmz3GERKOGJv3c6fuA6HbQ
	 UeCumnefgPArA==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexander Aring <alex.aring@gmail.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	edumazet@google.com,
	Eric Dumazet <edumazet@kernel.org>
Subject: [PATCH v2 net 0/2] ieee802154: 6lowpan: fix transmit address handling
Date: Fri,  2 Oct 2026 08:27:10 +0000
Message-ID: <20261002082712.3535213-1-edumazet@kernel.org>
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

v2: move skb_reset_network_header() from patch 1 to patch 2.
    In patch 1, hard_header_len is still 40, and the reset left a stale
    transport header for AF_PACKET SOCK_RAW packets (Sashiko).
    The code after patch 2 is unchanged.
v1: https://lore.kernel.org/netdev/20260928183753.3550210-1-edumazet@kernel.org/

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

