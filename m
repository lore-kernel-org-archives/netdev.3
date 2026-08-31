Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4B6481FA0
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 14:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788184827; cv=none; b=fec/I+bTgNktoZh9Ij6CUiJWp9/MIqvrfs5MiT0WIFWKo0jZjS3I1xddpqlFEL8ZwJrFY7f6eBzDbY1kQ/8//NJjL20pKzZqbA+5XQ1DaXgKwvVhxPrdzjjY/ZRugWQmDRDv3tzZWit4xaq7m0Q1LaqUlIDI/8d9GVj+lkyeNxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788184827; c=relaxed/simple;
	bh=IYBx1Mawu4i67/68N7CIIgUToiX+KlwNH7kBxKWM6I8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HTSf9R2xG4CWA+2D5gJOZO6QnnNmFfBuBQr7/uWkJ4jpYv2h6yEf5pW2nnXunorm019QqVtF6XKxGbRbkuV74QzDn40jHA6Scl4rAM+0Kup799QwP1dNwNlhTyzIyaYzpRjxXQbi2/yG1mi8R8fQuBJrLcCHD+P1JV3Smdf12lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=Ay18lRtu; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="Ay18lRtu"
Received: from kero.packetmixer.de (p200300C5970eEdd85f51F1fAA919d7a5.dip0.t-ipconnect.de [IPv6:2003:c5:970e:edd8:5f51:f1fa:a919:d7a5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 41977FA004;
	Mon, 31 Aug 2026 15:51:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1788184288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=v58nA171/ZUbo3ELGRawLjqoT65WZroxRXQzt4gJV1Q=;
	b=Ay18lRtu+lcmixwdjd/wI5jShXwNI/IkZWqCxEBXiEJ1ewtoBGmZQEbQEVTv23h6zpQf5e
	dTZkfS/JpMCrZ+qXk3YlZN1TB5NYrnkuU3ucfIPF8a9xCK3jS6IPs3PXqVVdMHmqusleLH
	Sf0a/6murdsJyXQ0GElpqFcO98BecwU03KN31rAPBJW5irjak98hPqMr3QpMFutwSvSvYE
	rCsyd3/FBc61bkyu+wOOhvRov5pjHmOIe1VPVPO7+BT9K3Z4sShKJt1k+Gy9g9CtU0QkKG
	khfomIC8Wj3mO6Y8V08AVeNSibCv0EZkHbkjR7fhwukc44PjX8kFiG7FVWP4bA==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 00/15] pull request for net-next: batman-adv 2026-08-31
Date: Mon, 31 Aug 2026 15:51:02 +0200
Message-ID: <20260831135117.574836-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dear net maintainers,

here is cleanup pull request of batman-adv to go into net-next.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit 1b78070aaef63512688aebfbc82365ef9d6660f1:

  Merge tag 'net-7.3-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-08-27 13:53:43 -0700)

are available in the Git repository at:

  https://git.open-mesh.org/batadv.git tags/batadv-next-pullrequest-20260831

for you to fetch changes up to 799152bcf6cbe4393eb03690925a382cefae303c:

  batman-adv: tt: decrement count for committed client on local_remove (2026-08-30 20:05:57 +0200)

----------------------------------------------------------------
This cleanup patchset includes the following patches, all by Sven Eckelmann:

- dat: fix printing of unknown 4addr subtype

- drop direction in _batadv_is_ap_isolated kernel-doc

- bat_v: fix bonding candidate selection

- clarify cut-off in batadv_v_neigh_is_sob kernel-doc

- use more descriptive var names for is_similar_or_better

- ensure u16 aligned mac addresses in structs and arrays (2 patches)

- translation table (tt) fixes/cleanups, 8 patches:

  - remove only the entry which was looked up from the hash
  - extract code handling a roam on add
  - simplify NEW flag transition code
  - drop unnecessary cleanup goto in helpers
  - use protected flag modifications
  - transition NEW local entries only under lock
  - don't uncount never committed clients on pending purge
  - decrement count for committed client on local_remove

----------------------------------------------------------------
Sven Eckelmann (15):
      batman-adv: dat: fix printing of unknown 4addr subtype
      batman-adv: drop direction in _batadv_is_ap_isolated kernel-doc
      batman-adv: bat_v: fix bonding candidate selection
      batman-adv: clarify cut-off in batadv_v_neigh_is_sob kernel-doc
      batman-adv: use more descriptive var names for is_similar_or_better
      batman-adv: ensure u16 aligned mac address arrays on stack
      batman-adv: ensure u16 aligned mac address in structs
      batman-adv: tt: remove only the entry which was looked up from the hash
      batman-adv: tt: extract code handling a roam on add
      batman-adv: tt: simplify NEW flag transition code
      batman-adv: tt: drop unnecessary cleanup goto in helpers
      batman-adv: tt: use protected flag modifications
      batman-adv: tt: transition NEW local entries only under lock
      batman-adv: tt: don't uncount never committed clients on pending purge
      batman-adv: tt: decrement count for committed client on local_remove

 net/batman-adv/bat_iv_ogm.c            |  25 +-
 net/batman-adv/bat_v.c                 |  42 +--
 net/batman-adv/bridge_loop_avoidance.c |   6 +-
 net/batman-adv/distributed-arp-table.c |  10 +-
 net/batman-adv/mesh-interface.c        |  12 +-
 net/batman-adv/multicast.c             |   6 +-
 net/batman-adv/translation-table.c     | 503 ++++++++++++++++++++++-----------
 net/batman-adv/types.h                 |  49 ++--
 8 files changed, 425 insertions(+), 228 deletions(-)
