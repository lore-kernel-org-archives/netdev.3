Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.88.38.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793368277;
	b=5bZWisdSPL5chHJ1l3BP1JTAvA8lT0vKWI5hD86ni+fOb9g0Vir+p9EfpVYxoFA3Cfl+
	 SYou16cbmXGY4G79R+CleIS0+s8bT9ROx1cUzJyOIoAd3bBVEndVXfHLU0RhJDd/iGPDV
	 H6T0YK0T3ycXxq70UDfQDcwnWTYmb/gx9dGnwlRlCYWnArd4Ns/MWTl5g5Vlq8J0Buj+D
	 JxdG83TFNIEPA0cC+UxH51WSgXoPMahWWBkcnrY/69JyoUZo188slLT6wYWmzNK0KtBkI
	 7f5N2AzYAgO50HqS+KcWo49AbiX9FRFoyvLqZZYFVtQekEwI0h6K0jKWAKxnoLaLJiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793368277;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ugFQ0SBkJarxj9YkqGiF/LsnDDkv17Ud8Nwf4UW/tek=;
	b=NLRM9GHJClpDFaBDanhzLNieQb0MCF2dDoF7ncsEA1Lmb/tZCv6rdFgQthinueVyx9O3
	 UO83I7Gc8AwY1Z06PBTc6/a1cuLY2j5wJveG+KIG0oeGy4tG81Iesww3LwB1Z6ndVYHRu
	 LLDWf7sr1ifgcm67F1OMOvdMlfiZpJKA7DjyYL5znuSt65jGCuDL0a1v3poxhZfG+9asn
	 lEpLD9kOUmpTDWKpQQ80DFI6soiJOab2yAyZxLV0s+2ewK6LdqWPeO8Coy1i9mgR8tzpr
	 YcURry28BC+Mfw+8iWyvF7e1D3k7PfM8OvKzAxL8/0jF1CwvwAlqzRc7Zd8CXoOYPtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simonwunderlich.de;
	spf=pass smtp.mailfrom=simonwunderlich.de;
	dkim=pass header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=pZrA1Btw;
	arc=none smtp.remote-ip=23.88.38.48
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 1B13D606A31C
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 13:51:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B13D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=pZrA1Btw
Received: from kero.packetmixer.de (p200300C597124Fd839580C360D3eD6F6.dip0.t-ipconnect.de [IPv6:2003:c5:9712:4fd8:3958:c36:d3e:d6f6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id D45C8FA006;
	Fri, 30 Oct 2026 14:51:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1793368267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ugFQ0SBkJarxj9YkqGiF/LsnDDkv17Ud8Nwf4UW/tek=;
	b=pZrA1BtwQBygFStLVzQ0U+dZ3T8j/LjmwLvJD9uEGUY16JdAWlwbs5C4YrpibX1xUxYph8
	myJQu4dNprM6Ivc+XmNztE+DgKclcb+gr5Ol6kA9BEpfbdnVlPtU7zIHjgqOMl4MvybvTX
	7TK6tgnPrszlnZ9qZZYDZEJmpDODZX1l8IV4gaGcn+I08sdkpTdH8rtdo6M2qTkHttjDN8
	znUK5iLy+djDoRqHFa1rIx3dUsnrFSYkAVUCh+iYy16jcF6vDXyJV7dBqjpHFQSmGvuGRE
	mqTIkq8+OGjd/zKG7cbvIpgcy+idVMrKoR3ijPPeZnuCPVfbX5VZkiNjYbg8TQ==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 00/14] pull request: batman-adv 2026-10-30
Date: Fri, 30 Oct 2026 14:50:51 +0100
Message-ID: <20261030135105.2555887-1-sw@simonwunderlich.de>
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

here is a bugfix pull request of batman-adv to go into net. This
pull request supersedes batadv-net-pullrequest-20261026 [1]. The
following changes were made (I marked the changed patches with v2):

* "Close OGM aggregation": dropped the Assisted-by tag and documented
  the new meaning of num_packets

* "tt: only transmit local ROAM flag together with DEL": clarified the
  commit message and noted that batadv_tt_global_purge_local() is not
  addressed

* "tt: only update flags for TT events": corrected the Fixes tag

* "tt: don't drop local events queued during TVLV update": moved the
  atomic snapshot of the changes into
  batadv_tt_local_commit_changes_nolock() so the TTVN decision covers
  the same events. If the TVLV allocation fails, the last changeset is
  now dropped only when the TTVN was incremented

* "tt: limit local table to single TVLV response size": Fixes now
  points to the original commit, and the patch is marked
  stable+noautosel because it is relevant mostly for the over-allocation
  fix 85fb027f611b

* new (patches were queued for later but Sashiko complained about
  problems which would be solved by them)

  - "tt: clear ROAM flag when re-adding a pending local client"
  - "tt: send ROAM_ADV on each roamed back client"
  - "tt: ignore ROAM flag of received ADD changes"

* new: "mcast: validate tracker padding before forwarding"

Please pull or let me know of any problem!

Thank you,
      Simon

[1] e-mail subject was: [PATCH net 00/10] pull request: batman-adv 2026-10-26
    reference: https://lore.kernel.org/r/20261026085309.1074911-1-sw@simonwunderlich.de

The following changes since commit d1807b20d548171d40c5d21a7cf22830ea8f348e:

  batman-adv: use assign_bit() where applicable (2026-09-27 19:03:34 +0200)

are available in the Git repository at:

  https://git.open-mesh.org/batadv.git tags/batadv-net-pullrequest-20261030

for you to fetch changes up to a137095419b4be0b204a11af4f1cea872ea262e9:

  batman-adv: tt: limit local table to single TVLV response size (2026-10-30 10:11:27 +0100)

----------------------------------------------------------------
Here are a few batman-adv bugfixes:

- avoid WARN_ON for orig_ifinfo allocation failure, by Deepanshu Kartikey

- close OGM aggregation before transmission, by Chengfeng Ye

- mcast: validate tracker padding before forwarding, by Kyle Zeng

The remaining bugfixes are authored by Sven Eckelmann:

- tpmeter: fix u32 truncation of reported bytes

- dat: initialize orig_node of unfilled candidate slots

- fix skb leak when hard_iface is being released

- stop originator purge worker before freeing tt

- tt: fix flag and event handling (6 patches)

- tt: limit local table to single TVLV response size

----------------------------------------------------------------
Chengfeng Ye (1):
      batman-adv: Close OGM aggregation before transmission

Deepanshu Kartikey (1):
      batman-adv: avoid WARN_ON for orig_ifinfo allocation failure

Kyle Zeng (1):
      batman-adv: mcast: validate tracker padding before forwarding

Sven Eckelmann (11):
      batman-adv: tpmeter: fix u32 truncation of reported bytes
      batman-adv: dat: initialize orig_node of unfilled candidate slots
      batman-adv: fix skb leak when hard_iface is being released
      batman-adv: stop originator purge worker before freeing TT
      batman-adv: tt: only transmit local ROAM flag together with DEL
      batman-adv: tt: clear ROAM flag when re-adding a pending local client
      batman-adv: tt: send ROAM_ADV on each roamed back client
      batman-adv: tt: ignore ROAM flag of received ADD changes
      batman-adv: tt: only update flags for TT events
      batman-adv: tt: don't drop local events queued during TVLV update
      batman-adv: tt: limit local table to single TVLV response size

 net/batman-adv/bat_iv_ogm.c            |   7 +-
 net/batman-adv/distributed-arp-table.c |   1 +
 net/batman-adv/main.c                  |  12 +-
 net/batman-adv/multicast_forw.c        |   5 +-
 net/batman-adv/tp_meter.c              |   2 +-
 net/batman-adv/translation-table.c     | 215 ++++++++++++++++++++++-----------
 net/batman-adv/types.h                 |   8 +-
 7 files changed, 174 insertions(+), 76 deletions(-)
