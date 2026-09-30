Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5658F3E7167
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 09:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790762109; cv=none; b=UCJ1ZThnrec88v3It8fJz34mox6L+PvdgOrZ1zjDVINANGo/UdqLSmw/yqttw7K7K73nmKcPD73MKBdrJqSzs9nUgGJsMQef5UgsZBsdH3eyzhGgL7hECHukekSkUudzETYsV5mL6vsYnMOD4d1iHnHc/FlRs/26xL0G4VIds8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790762109; c=relaxed/simple;
	bh=+h1hFDcAeBP/CqlJEbvs5lSL7Me9PHvFA+efycgeMl8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K3vM+gt+LBCYLF0SmH0exuJ0cgjnHV6Do7PJgL4+MI1vicwtBhMBC9UfnihowUcRaK/lFJD6mIPcEQ4+H6EFjOThnsxHMa80JjpP9ZKIZ3XPZHzfriLMQX4+JDOUNZ32tfR4ONby2f8l9y2Kh1oQBfjUFliogHdbs0bvPSPLXG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=wc8VKd+O; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="wc8VKd+O"
Received: from kero.packetmixer.de (p200300C5970E81D8CF20E45a7328D917.dip0.t-ipconnect.de [IPv6:2003:c5:970e:81d8:cf20:e45a:7328:d917])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 00E14FA006;
	Wed, 30 Sep 2026 11:45:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1790761560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=28i/yfmhWsjrZWGfpgWXRsKrylYWppeaugMbYrlbf98=;
	b=wc8VKd+O7SwI2WaWbd1ezuDl3++HMziO6DuwE2zAVANGyNzadl4+dv7WU4xEPooNmT2o9z
	gGKktFUf+nv6ykoeuyw3Ai5Zuf9kdIxBOdolvBt3va+/0IOd5FUb81kaDYL2kczdpVDmjh
	zc4wH2qRnJdKcB09hwXTEPHCJy6n2+2G4+ktEyla2Kfhcv3kYS/WARrCPhbxFjhpy2MShf
	EO/ZaLWflCqyr6cCa4ZIkyQUkJ6AtLausiis2u4H7tYs17Bper75HDuTJTMygEin+/GFot
	QCCMLJe4Lg+Km+jLee2JxqSe1VM93RPpS/AxDl1MSHKOqt+5AxU+kG0FvXcSHA==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 0/9] pull request for net-next: batman-adv 2026-09-30
Date: Wed, 30 Sep 2026 11:45:49 +0200
Message-ID: <20260930094558.3723766-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dear net maintainers,

here is another feature/cleanup pull request of batman-adv to go into net-next.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit 6d7f71ae4cdcbb22f541638057299fe26c451e65:

  batman-adv: correct batadv_hash_remove kdoc return type (2026-09-06 20:05:31 +0200)

are available in the Git repository at:

  https://git.open-mesh.org/batadv.git tags/batadv-next-pullrequest-20260930

for you to fetch changes up to d1807b20d548171d40c5d21a7cf22830ea8f348e:

  batman-adv: use assign_bit() where applicable (2026-09-27 19:03:34 +0200)

----------------------------------------------------------------
This feature/cleanup patchset includes the following patches:

 - bla: avoid double free after failed backbone_hash alloc,
   by Sven Eckelmann

 - tt: update kerneldoc, by Sven Eckelmann (3 patches)

 - tt: fix local DEL handling, by Sven Eckelmann (3 patches)

 - tt: reject VLAN/TT entries before reaching size limit,
   by Sven Eckelmann

 - use assign_bit() where applicable, by Peng Fan

----------------------------------------------------------------
Peng Fan (1):
      batman-adv: use assign_bit() where applicable

Sven Eckelmann (8):
      batman-adv: bla: avoid double free after failed backbone_hash alloc
      batman-adv: tt: clarify kernel-doc for batadv_tt_global_purge_local
      batman-adv: tt: clarify responsibility for roam flag during removal
      batman-adv: tt: soften kernel-doc for batadv_tt_local_remove_now()
      batman-adv: tt: only queue local del event after successful unlink
      batman-adv: tt: queue local DEL event under bucket lock
      batman-adv: tt: queue local DEL event before marking entry as pending
      batman-adv: tt: reject VLAN/TT entries before reaching size limit

 net/batman-adv/bridge_loop_avoidance.c |   1 +
 net/batman-adv/distributed-arp-table.c |   6 +-
 net/batman-adv/main.c                  |   1 +
 net/batman-adv/mesh-interface.c        |   8 +
 net/batman-adv/translation-table.c     | 359 ++++++++++++++++++++++++---------
 net/batman-adv/translation-table.h     |   3 +
 net/batman-adv/types.h                 |  19 ++
 7 files changed, 299 insertions(+), 98 deletions(-)
