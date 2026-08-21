Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9437470EA7
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 09:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787306305; cv=none; b=h4mL0uxIapDDYWya3fJcJqxJaJfRUYk3JDlFenTR3lzL5zUY+d0fAUKu+28ojzfkZO77/0P1yaYyeKbvIAFLFzNIowJWiNhn92tQZwKU4IHeCL47aqQyL6sMf5XMpRynm2MO3GcB5ZaVZ4NUM4QVctN5WU7Khee8dKCDoPHVuuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787306305; c=relaxed/simple;
	bh=v3G4tz/sSQGdGmRVO5nC9LWufYwic0m90VhB/af1Wao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BTBF9BZK1L/1KLWmZvGr90JeX9khgFCGzmjNN7rQuBTEjdcNjquognaoJnyfPekQPl8/5lHd0mMsGZxHQxdZEGCPGSb1MGX44xNlBjvV+BBFlzglRRUC//H/R+ZrCFDggZJbTecsAoh3q3GjCqkROiReQjq8Y+ERTlYlD/DpS7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=o/3GB6rh; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="o/3GB6rh"
Received: from kero.packetmixer.de (p200300c59714fCD8ec8C87C354003FEd.dip0.t-ipconnect.de [IPv6:2003:c5:9714:fcd8:ec8c:87c3:5400:3fed])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id ACA8EFA006;
	Fri, 21 Aug 2026 11:48:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1787305697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qFhQ49oqhHKVO9Sa5p8UdYVng+tO6C+zzN+tt3FPwQA=;
	b=o/3GB6rhFAJhCHw/3Hn+Bv7vV9jHgy2IztXBWrmcOgCPkjMFB/O4GLuDh9XkcD8ctF5uHo
	Ko4Xvw67GCzHPktF407dLNVASo+uxP5HyFftIlJ9pzebyRSP26dXghFTR0kK9eJlbEJNCM
	7EeprSMnU9Cj17F6OiQuCqWwt7S44l+uV1OrW8yPsy4XDNTJ4UKC6jXR/K0gsIOQh/frYd
	xfK2p0C4Tqq8q/0eGUeCxLb3bayWp48N1q1eO3asRmRzDI7rQ08rrypUHDYQJ3Wc2Lx37C
	rYcKgbPd/RGhbHdU57t7r71wL/HNMRxenV+gUjMG1ZjbDuOEFgQOVxo8GU2Vng==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 0/9] pull request: batman-adv 2026-08-21
Date: Fri, 21 Aug 2026 11:48:04 +0200
Message-ID: <20260821094813.201800-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dear net maintainers,

here are a couple of bugfixes for batman-adv which we would like to have integrated into net.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit 02aee8ebea3a714d92b27da9a9d8791d8c8c9a4f:

  batman-adv: remove negative returns for batadv_send_skb_unicast (2026-08-05 10:00:16 +0200)

are available in the Git repository at:

  https://git.open-mesh.org/batadv.git tags/batadv-net-pullrequest-20260821

for you to fetch changes up to 8d128c932bced74e3b1625ba3d7c78ef122a88a7:

  batman-adv: bla: fix freeing of claims on meshif deletion (2026-08-05 10:23:09 +0200)

----------------------------------------------------------------
Here are a few batman-adv bugfixes:

 - fix stale receive device on merged fragments, by Zhiling Zou

the others are written by Sven Eckelmann:

 - bla: fix potential CRC corruption issues (2 patches)

 - dat: avoid unaligned fault in IP extraction

 - dat: atomically update mac addresses

 - mcast: fix TX priority extraction for BATADV_FORW_MCAST

 - mcast: fix skb sharing and linearization (2 patches)

 - bla: fix freeing of claims on meshif deletion

----------------------------------------------------------------
Sven Eckelmann (8):
      batman-adv: bla: avoid CRC corruption due to parallel claim add
      batman-adv: bla: prevent CRC corruptions after claim flush
      batman-adv: dat: avoid unaligned fault in IP extraction
      batman-adv: dat: atomically update mac addresses
      batman-adv: fix TX priority extraction for BATADV_FORW_MCAST
      batman-adv: mcast: ensure unshared skb for multicast packets
      batman-adv: mcast: linearize skbuff for packet generation
      batman-adv: bla: fix freeing of claims on meshif deletion

Zhiling Zou (1):
      batman-adv: fix stale receive device on merged fragments

 net/batman-adv/bridge_loop_avoidance.c | 78 +++++++++++++++++-----------------
 net/batman-adv/distributed-arp-table.c | 66 +++++++++++++++++++---------
 net/batman-adv/main.c                  |  4 ++
 net/batman-adv/mesh-interface.c        |  7 ++-
 net/batman-adv/multicast_forw.c        |  7 ++-
 net/batman-adv/types.h                 |  2 +-
 6 files changed, 100 insertions(+), 64 deletions(-)
