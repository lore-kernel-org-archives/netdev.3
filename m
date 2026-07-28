Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EEE3ACF1B
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 13:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785246279; cv=none; b=bo3uJXnZxurj9QOa6rt81Mat7jCkFue4cZ945US6kRSs05zs9nClZSW+QCOHr4CUSG7zdvbfkp3UktU0QznhqN8Fi9UMhR/pUAXjX1blwgAE3Qb0eq0LgQEDPtC/7kLXYPaTUKdIUogPD4dThIIj3MtnRe05l+2JsN17Lv+Mph8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785246279; c=relaxed/simple;
	bh=gosP6giJKz2I6FCp6rSU3RU8k4gdkYvMcu+8kudSUJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JjjncB39/nL0ZEbF5ZngJzr/k7MWqlTQZt/c6P7QDbmdUYbcklXuzy9mqbigwye5538W1LR2chmoIeRxLVKJrVUCoSvVRCR2wCs/FsEjh+8AToAlhQshy2bSp1Wz8SPbnITeJsejydf20YreHbwbcs3Z2rMo/kE2qtiUU0a/fBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=nj5ChFge; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="nj5ChFge"
Received: from kero.packetmixer.de (p200300c59717ead808f168C97E5563A8.dip0.t-ipconnect.de [IPv6:2003:c5:9717:ead8:8f1:68c9:7e55:63a8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 2E678FA006;
	Tue, 28 Jul 2026 15:39:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1785245959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qqEllnaONuEr6tIT/DHGIGAHgfo9X/1/a0Y4WPVoQWw=;
	b=nj5ChFgeo3TeTrBlDF04WUCh3MTpeneBBtLsb14gpsUSabPToEvjLUTkPoLAGaxcLtyEGk
	y1Kw1kJGiM/8PlVuqjy8HIKvvPtgqhKfap0CMsqxRIeoUmjoN76KcW7YwL6it8QUPq5Umd
	/vt5uiuCZaWDs/c5uo7t/OSn6oVNsk0h7vlNDbq5xgNKBtQHYWut4TdELNcU+2iZyMaeZ1
	6RwJumtv2KDTFSZD/hrhh1MyTYvKC2UHQK1xeMwYvh6xcBKUZOUbw45lEVeS4fQxqL+ZQF
	Y9bVCSsN4fVTQG4JWGM03GsfWCA/ns2T8xSIj75+PMzR1UkG+s93sByk84cHvg==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 00/15] pull request for net-next: batman-adv 2026-07-28
Date: Tue, 28 Jul 2026 15:39:03 +0200
Message-ID: <20260728133918.643267-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dear net maintainers,

here is a minor bugfix/cleanup pull request of batman-adv to go into net-next.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit b470fde8f77b56ff273c5527484b99499b894e16:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-07-10 10:20:05 +0200)

are available in the Git repository at:

  https://git.open-mesh.org/batadv.git tags/batadv-next-pullrequest-20260728

for you to fetch changes up to 6af11807a9e1e9117bfe4865cc9b30935c339cf2:

  batman-adv: tt: simplify NEW flag transition code (2026-07-10 22:35:45 +0200)

----------------------------------------------------------------
This minor bugfix/cleanup patchset includes the following patches (all by Sven Eckelmann):

7 minor bugfix patches:

 - bla: fix potential CRC corruptions (2 patches)

 - dat: avoid unaligned fault in IP extraction

 - dat: atomically update mac addresses

 - mcast: ensure linearization, TX prio extraction and unshared skbs
   (3 patches)

8 cleanup patches:

 - dat: drop non-4addr backwards compatibility

 - improve kernel-doc, add comments and warnings (3 patches)

 - coding style: split declarations, reverse x-mas tree (2 patches)

 - tt: atomic flag modifications, simplify NEW flag transition (2 patches)

----------------------------------------------------------------
Sven Eckelmann (15):
      batman-adv: bla: avoid CRC corruption due to parallel claim add
      batman-adv: bla: prevent CRC corruptions after claim flush
      batman-adv: dat: avoid unaligned fault in IP extraction
      batman-adv: dat: atomically update mac addresses
      batman-adv: fix TX priority extraction for BATADV_FORW_MCAST
      batman-adv: mcast: ensure unshared skb for multicast packets
      batman-adv: mcast: linearize skbuff for packet generation
      batman-adv: dat: drop non-4addr backwards compatibility
      batman-adv: add missing kernel-doc comments
      batman-adv: fix kernel-doc for functions holding skb ownership
      batman-adv: annotate functions which may reallocate the skbuff
      batman-adv: split multiple declarations per line
      batman-adv: switch var declarations to reverse x-mas tree order
      batman-adv: tt: use atomic flag modifications
      batman-adv: tt: simplify NEW flag transition code

 include/uapi/linux/batadv_packet.h     |  16 +-
 net/batman-adv/bat_algo.c              |  16 +-
 net/batman-adv/bat_iv_ogm.c            | 303 ++++++++++++----
 net/batman-adv/bat_v.c                 |  87 ++++-
 net/batman-adv/bat_v_elp.c             |  19 +-
 net/batman-adv/bat_v_ogm.c             |  34 +-
 net/batman-adv/bitarray.c              |   9 +-
 net/batman-adv/bridge_loop_avoidance.c | 169 +++++----
 net/batman-adv/distributed-arp-table.c | 305 +++++++++++-----
 net/batman-adv/fragmentation.c         |  34 +-
 net/batman-adv/gateway_client.c        |  41 ++-
 net/batman-adv/gateway_common.c        |   6 +-
 net/batman-adv/hard-interface.c        |  94 ++++-
 net/batman-adv/hash.c                  |   5 +-
 net/batman-adv/hash.h                  |  42 ++-
 net/batman-adv/log.h                   |  16 +-
 net/batman-adv/main.c                  |  59 ++-
 net/batman-adv/mesh-interface.c        | 116 ++++--
 net/batman-adv/multicast.c             |  33 +-
 net/batman-adv/multicast_forw.c        |  33 +-
 net/batman-adv/netlink.c               |  14 +-
 net/batman-adv/originator.c            |  64 ++--
 net/batman-adv/routing.c               | 115 ++++--
 net/batman-adv/send.c                  |   7 +-
 net/batman-adv/tp_meter.c              |  41 ++-
 net/batman-adv/translation-table.c     | 637 +++++++++++++++++++++++----------
 net/batman-adv/tvlv.c                  |  24 +-
 net/batman-adv/types.h                 |   8 +-
 28 files changed, 1692 insertions(+), 655 deletions(-)
