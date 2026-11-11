Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.88.38.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794392860;
	b=4SF9ZjzviJL+MNCZ+aNGpUO0Bi4K5nPFFaQTDXj5Rh1LbHvio3vPcW+qY69LgTumDKvR
	 GMvZMfg/RsWZbeGRD+ysz9T/n8gXQLdYQSrQe7MhQMMaG/w6HiEkcF3ACRws6mL9GLpPd
	 8p4P9d2Z+TPSNn4eNoMAoGuCSfsG0aEd9FPfqTE4w13wtTdZM3ZwmnFfLTmDRWzZu/JOn
	 7A8iB2Vh/243c+nDpV0NGNA8t86lLke0AxLZA8zHnGoq7tc362miwdVtZwc1peNfkYPPK
	 ITxLXPrANrgozVCIJEAV9VvyokQswS8vZyFDAi1YJdg/k4nXaZfmtRCPgiZQpKKq+1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794392860;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=9zDl0MYB7shvzk9kMl26C8GZ3AJOuHtU2CyfGNendrY=;
	b=lLbs8KJOofyJZEvmNs3C83/LplqbDkHEa2ccny+FH4C4Qa4XRky367KQioF81noYH9zw
	 vr1CcuDKBfCBfooz/WjWsQHjnLBul/AkO0jeNQJoq2HGzruMpDOZrDgqpXHngL9FwxGw5
	 V5xnUnG3pxC17KMR9kGp9MOa2e/AeulDb/wVRtWBJayLrthvhwPEohhOTUe5GgKEMfj9J
	 ty8RmvAumH/RGoYG2vnWN2swwUPf03MrCLH+IrW+Lu63O4agHHs4op2ptLf/dA+HVL43q
	 eTAoPE/k7HbyBjx+9KMchlZfogsnnwN1OdMSj/4p6R+SKLtErGrEFqb0IeW+zcv0Ifw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simonwunderlich.de;
	spf=pass smtp.mailfrom=simonwunderlich.de;
	dkim=pass header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=BCqBGyo6;
	arc=none smtp.remote-ip=23.88.38.48
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id B1F29606A321
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 10:27:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1F29606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=BCqBGyo6
Received: from kero.packetmixer.de (p200300C59740ded843Be7e4a980e9C65.dip0.t-ipconnect.de [IPv6:2003:c5:9740:ded8:43be:7e4a:980e:9c65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 0D5CAFA0B2;
	Wed, 11 Nov 2026 11:27:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1794392851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9zDl0MYB7shvzk9kMl26C8GZ3AJOuHtU2CyfGNendrY=;
	b=BCqBGyo69nMId0eBy5Bw+r4uziUIL5lbxHM8MBaJGIxAw4NglIPDOvTb4DuOg21dO7NigJ
	RkYGx8R5wWpqlrBx2YTyUEf04eYBXz9lvOjn4BEeesZo9PraxG2OWTYo3IesEAiVHuFv+w
	HHulqKhdSejJWnonZ14MDeeOqU6tu3oWBsKgKEkUbnw9B3EfLVhR1SuJNg0/tVwMu4sfQ6
	5AWn3PFazdlf0N+bEk922T8IFY+QxguY54gKQ30EXSqfEgEVfTnl/7qCkCfjd2pOH/0qtO
	Qwd/WjK+wU1aLIGaTscgsnbAQjGFwDR3GEcMsNNJy58iu0pwujnrznbiCnA+yQ==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 00/15] pull request for net-next: batman-adv 2026-11-11
Date: Wed, 11 Nov 2026 11:27:14 +0100
Message-ID: <20261111102729.2096241-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Dear net maintainers,

here is a cleanup pull request of batman-adv to go into net-next.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit a137095419b4be0b204a11af4f1cea872ea262e9:

  batman-adv: tt: limit local table to single TVLV response size (2026-10-30 10:11:27 +0100)

are available in the Git repository at:

  https://git.open-mesh.org/batadv.git tags/batadv-next-pullrequest-20261111

for you to fetch changes up to d5c0415dfb58b646696292a7af3d084200933f84:

  batman-adv: mcast: document the value stored in is_routable (2026-10-31 23:04:11 +0100)

----------------------------------------------------------------
This cleanup patchset includes the following patches:

- mcast: explicitly initialize mcast.*_want_all_rtr{4,6),
  by Sven Eckelmann (2 patches)

- uapi: add note/clarification on access of reserved bytes/bits,
  by Linus Lüssing

The remaining patches are authored by Sven Eckelmann:

- avoid torn u64 counter reads on 32-bit systems

- bat_v: initialize last_unicast_tx on neighbor creation

- anotate various timestamps with READ/WRITE_ONCE (6 patches)

- use matching return types for bool and void functions

- mark read-only MAC address parameters as const

- use bool for boolean flags

- mcast: document the value stored in is_routable

----------------------------------------------------------------
Linus Lüssing (1):
      batman-adv: uapi: add note/clarification on access of reserved bytes/bits

Sven Eckelmann (14):
      batman-adv: mcast: explicitly initialize mcast.num_want_all_rtr{4,6)
      batman-adv: mcast: explicitly initialize mcast.want_all_rtr{4,6}_list
      batman-adv: avoid torn u64 counter reads on 32-bit systems
      batman-adv: bat_v: initialize last_unicast_tx on neighbor creation
      batman-adv: dat: annotate last_update with READ/WRITE_ONCE
      batman-adv: bla: avoid negative reported BATADV_ATTR_LAST_SEEN_MSECS
      batman-adv: tt: annotate last_seen with READ/WRITE_ONCE
      batman-adv: annotate originator last_seen with READ/WRITE_ONCE
      batman-adv: annotate neigh_node last_seen with READ/WRITE_ONCE
      batman-adv: annotate hardif_neigh_node last_seen with READ/WRITE_ONCE
      batman-adv: use matching return types for bool and void functions
      batman-adv: mark read-only MAC address parameters as const
      batman-adv: use bool for boolean flags
      batman-adv: mcast: document the value stored in is_routable

 include/uapi/linux/batadv_packet.h     | 28 +++++++++++++++---------
 net/batman-adv/bat_iv_ogm.c            | 34 ++++++++++++++++-------------
 net/batman-adv/bat_v.c                 |  9 ++++++--
 net/batman-adv/bat_v_elp.c             |  8 ++++---
 net/batman-adv/bat_v_ogm.c             |  7 +++---
 net/batman-adv/bridge_loop_avoidance.c | 21 ++++++++++--------
 net/batman-adv/bridge_loop_avoidance.h | 11 +++++-----
 net/batman-adv/distributed-arp-table.c | 19 +++++++++-------
 net/batman-adv/distributed-arp-table.h |  3 +--
 net/batman-adv/hard-interface.c        |  2 +-
 net/batman-adv/hard-interface.h        |  2 +-
 net/batman-adv/main.c                  |  2 ++
 net/batman-adv/main.h                  | 15 +++++++++++--
 net/batman-adv/mesh-interface.c        | 25 +++++++++++++++++----
 net/batman-adv/multicast.c             | 18 +++++++++------
 net/batman-adv/multicast.h             |  3 +--
 net/batman-adv/multicast_forw.c        | 27 +++++++++++++----------
 net/batman-adv/originator.c            | 16 ++++++++------
 net/batman-adv/originator.h            |  2 +-
 net/batman-adv/routing.c               |  4 ++--
 net/batman-adv/translation-table.c     | 40 +++++++++++++++++++---------------
 net/batman-adv/translation-table.h     |  8 +++----
 net/batman-adv/types.h                 | 23 ++++++++++++++-----
 23 files changed, 204 insertions(+), 123 deletions(-)
