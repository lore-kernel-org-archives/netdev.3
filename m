Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1417D353A7C
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 08:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788769116; cv=none; b=in/On2yI3kNi1dhTzfqivFEQmw3liND0CKNuBA2pPKwYldgZ3cOg7wk6XnWgN0zCxbDJf5VMniJclzcxs0XTYr+gNhxGattr+QKYjmRubeQyKSkUURCHMoJmP+cxjNzcgyYj0jM6d2ZWI0u3muFExfjl0wARWiqagjN4VhToZT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788769116; c=relaxed/simple;
	bh=hTbzyd/airtpW0GW/SSdtX8Kt184P57rDyyOwmabksw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IZWGZ254vfYQXBibnHm0SsaiuqlPRYqnC0q7oCWHoEWOFcCY7ygdJZ7HqCppO/hA5EWw+rW4MgViP4Ml/euLNpGbPSyRDKuGjYOOfDi42WbRAL6MoOj/7KCqD7zEtPIuMrPFGhNc30uIAd/wsxHg3Y6tIv8yNeYmE7qbXSrYPo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=pC5P4gD1; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="pC5P4gD1"
Received: from kero.packetmixer.de (p200300C59748d0D8c3747188e6dFe6C0.dip0.t-ipconnect.de [IPv6:2003:c5:9748:d0d8:c374:7188:e6df:e6c0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id DFAC3FA006;
	Mon, 07 Sep 2026 10:18:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1788769106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/en6S0pLrmK0uJTojaLbW/qD54v16Ukp5Ukr3J8LW4I=;
	b=pC5P4gD1fT6z1++6CFiLfF6yzWWzbyHcpv3nXQ2kb2S9KhACZKBdJndxcSMVeEayH/UJWh
	DMiEBTKBFGdyAKr++efS+VcmFSo8BHZDAUVpJq/Rcm3t1r+ZiioUiK1HEhYUZuImzLUGXn
	ehPTNH6c/88IDW3KrwKbjJc2uUddXhxbqLPmqm6jD0PNEgglmmB7tThCHyQ4MYLZfOzgaS
	TmxefvLE+M3Upy/MHHIVAfrRnuTpfGPdLxtYeXX9Zno6a6R3KWMm3Dv+j2NY3tV6ZyPKoJ
	gfMpZvdD7tCUETATkI2tuf+a2khED3o2td5dIdgeMv49Jt9R5e68YzkqfmMAPQ==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 00/15] pull request for net-next: batman-adv 2026-09-07
Date: Mon,  7 Sep 2026 10:18:09 +0200
Message-ID: <20260907081824.2474040-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dear net maintainers,

here is another cleanup pull request of batman-adv to go into net-next.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit 799152bcf6cbe4393eb03690925a382cefae303c:

  batman-adv: tt: decrement count for committed client on local_remove (2026-08-30 20:05:57 +0200)

are available in the Git repository at:

  https://git.open-mesh.org/batadv.git tags/batadv-next-pullrequest-20260907

for you to fetch changes up to 6d7f71ae4cdcbb22f541638057299fe26c451e65:

  batman-adv: correct batadv_hash_remove kdoc return type (2026-09-06 20:05:31 +0200)

----------------------------------------------------------------
This cleanup patchset includes the following patches, all by Sven Eckelmann:

 - translation table cleanups (12 patches)

 - kerneldoc fixes noted by sashiko (3 patches)

----------------------------------------------------------------
Sven Eckelmann (15):
      batman-adv: tt: look up wifi state of incoming interface in helper
      batman-adv: tt: extract allocation of new local entries
      batman-adv: tt: replace forward gotos in batadv_tt_local_add()
      batman-adv: tt: extract refresh of existing local entries
      batman-adv: tt: extract update of dynamic client flags
      batman-adv: tt: extract allocation of new global entries
      batman-adv: tt: extract merging of flags into existing global entries
      batman-adv: tt: replace add_orig_entry goto in batadv_tt_global_add()
      batman-adv: tt: extract removal of the superseded local entry
      batman-adv: tt: extract marking of a removed local entry
      batman-adv: tt: extract immediate purge of a local entry
      batman-adv: tt: drop the cleanup label from batadv_tt_local_remove()
      batman-adv: tt: clarify kernel doc for batadv_tt_local_set_pending_event()
      batman-adv: bat_iv: fix ogm_neigh_is_sob parameters references
      batman-adv: correct batadv_hash_remove kdoc return type

 net/batman-adv/bat_iv_ogm.c        |   4 +-
 net/batman-adv/hash.h              |   2 +-
 net/batman-adv/translation-table.c | 655 +++++++++++++++++++++++--------------
 3 files changed, 420 insertions(+), 241 deletions(-)
