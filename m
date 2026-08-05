Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130203911D3
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 14:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785940809; cv=none; b=tHcuDUkin4GN7H+YOzjzQYsfn+EhZIqmry+KQ4im/w0iLA6RWw7XvFqV1eKOciLfqLmO/Rg3wS4OrBXsdIbBRBEhMgEkT20+bwfPODKxLSFO3HLIY/9KEpoJfxbnn1fx+1gZkwaFJCBWfsyC8ABzYdIrMqFRPgr3+DozoMUobC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785940809; c=relaxed/simple;
	bh=xWT0z+TEpUWeoSg6kK3/ff/821aREG5NMq9pRVDtkWM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oFuOrhEb/elSpKxwFbn9EfoQMFRWd5jPQbKBXUl+xIyewalsINaFzrD1C7xeKVUV2kn4naWxe9sfLA2MuZKwELdnoH2jZyvStn9+JTDHfJgn2InfXrPc8vfCOC6jcs5R0EPs+dkZFEjBPQE2Vupn7JDs/3bsd89qRdg3TjAFV0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=wQYuQwJy; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="wQYuQwJy"
Received: from kero.packetmixer.de (p200300C5970B56D88eEBAC4310D100aa.dip0.t-ipconnect.de [IPv6:2003:c5:970b:56d8:8eeb:ac43:10d1:aa])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 10559FA1BF;
	Wed, 05 Aug 2026 16:32:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1785940325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9uzEweOhEpBINPGk4fnNm5R3TblxhZJTHxrpnEQqsi4=;
	b=wQYuQwJyCrMKxv6tibmy/71pITO7sBIwwd48/cL+kpQjVDZMamHBHA4gYvdD+m4Ei0iG0a
	/a7mWcqgtLN0lJYWDNfp+cyBJ1pmgCI4onAEDkrFB+QFUJIDW3v/E4+ntEggmJHBQ6jyqU
	Q8KZxfPg+0BX7CNWLoe4twZQqFkGZzjJkdGS+Q7UuleLlRKq3REviBqPGe7cvGKEKhdhAA
	fJk+Vas3B0S+SGV9ahe17dit+wR4TJ1n3OZ9av/mGlSKzP+rdi/2efQx9WU8UERJ7mNe7A
	b2B/a1iH1b+/Ms2LkbhsrzoeYAvnImaCnkwMviC1YYTXYXaCP88K/lV767Cg5g==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 00/10] pull request for net-next: batman-adv 2026-08-05
Date: Wed,  5 Aug 2026 16:27:14 +0200
Message-ID: <20260805143200.722098-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dear net maintainers,

here is a cleanup pull request of batman-adv to go into net-next. It
replaces my previous pull request as of 2026-07-28 [1]. We're including
only cleanups patches of the previous pull request - some of them revised
- plus some new cleanup patches. We've dropped the fix patches from the
previous pull request and will submit those separately, later.

Please pull or let me know of any problem!

Thank you,
      Simon

[1] https://lore.kernel.org/netdev/20260728133918.643267-1-sw@simonwunderlich.de/

The following changes since commit b470fde8f77b56ff273c5527484b99499b894e16:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-07-10 10:20:05 +0200)

are available in the Git repository at:

  https://git.open-mesh.org/batadv.git tags/batadv-next-pullrequest-20260805

for you to fetch changes up to 02aee8ebea3a714d92b27da9a9d8791d8c8c9a4f:

  batman-adv: remove negative returns for batadv_send_skb_unicast (2026-08-05 10:00:16 +0200)

----------------------------------------------------------------
This cleanup patchset includes the following patches:

 - dat: drop non-4addr backwards compatibility, by Sven Eckelmann

 - tvlv: handle negative tvlv processing return codes,
   by Sven Eckelmann

 - improve kernel-doc, add comments and warnings,
   by Sven Eckelmann (3 patches)

 - coding style: split declarations, reverse x-mas tree,
   by Sven Eckelmann (2 patches)

 - handle errors in batadv_init(), by Minhong He

 - correct NET_RX_* NET_XMIT_* confusion, by Sven Eckelmann

 - remove negative returns for batadv_send_skb_unicast,
   by Sven Eckelmann

----------------------------------------------------------------
Minhong He (1):
      batman-adv: handle errors in batadv_init()

Sven Eckelmann (9):
      batman-adv: dat: drop non-4addr backwards compatibility
      batman-adv: tvlv: handle negative tvlv processing return codes
      batman-adv: add missing kernel-doc comments
      batman-adv: fix kernel-doc for functions holding skb ownership
      batman-adv: annotate functions which may reallocate the skbuff
      batman-adv: split multiple declarations per line
      batman-adv: switch var declarations to reverse x-mas tree order
      batman-adv: correct NET_RX_* NET_XMIT_* confusion
      batman-adv: remove negative returns for batadv_send_skb_unicast

 include/uapi/linux/batadv_packet.h     |  16 +-
 net/batman-adv/bat_algo.c              |  16 +-
 net/batman-adv/bat_iv_ogm.c            | 311 ++++++++++++++++++++------
 net/batman-adv/bat_iv_ogm.h            |   1 +
 net/batman-adv/bat_v.c                 |  96 +++++++--
 net/batman-adv/bat_v.h                 |   5 +
 net/batman-adv/bat_v_elp.c             |  19 +-
 net/batman-adv/bat_v_ogm.c             |  34 +--
 net/batman-adv/bitarray.c              |   9 +-
 net/batman-adv/bridge_loop_avoidance.c | 109 ++++++----
 net/batman-adv/distributed-arp-table.c | 239 ++++++++++++++------
 net/batman-adv/fragmentation.c         |  35 +--
 net/batman-adv/gateway_client.c        |  46 ++--
 net/batman-adv/gateway_common.c        |   6 +-
 net/batman-adv/hard-interface.c        |  94 +++++++-
 net/batman-adv/hash.c                  |   5 +-
 net/batman-adv/hash.h                  |  42 ++--
 net/batman-adv/log.h                   |  16 +-
 net/batman-adv/main.c                  | 104 +++++++--
 net/batman-adv/mesh-interface.c        | 109 ++++++++--
 net/batman-adv/multicast.c             |  43 ++--
 net/batman-adv/multicast_forw.c        |  26 ++-
 net/batman-adv/netlink.c               |  20 +-
 net/batman-adv/netlink.h               |   2 +-
 net/batman-adv/originator.c            |  64 +++---
 net/batman-adv/routing.c               | 121 ++++++++---
 net/batman-adv/send.c                  |  13 +-
 net/batman-adv/tp_meter.c              |  41 ++--
 net/batman-adv/translation-table.c     | 383 +++++++++++++++++++++++++--------
 net/batman-adv/tvlv.c                  |  46 ++--
 net/batman-adv/types.h                 |   4 +-
 31 files changed, 1541 insertions(+), 534 deletions(-)
