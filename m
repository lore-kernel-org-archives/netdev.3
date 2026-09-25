Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112823A7593;
	Fri, 25 Sep 2026 21:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790372406; cv=none; b=qITc5uftbo7d4LD4AtAf3xCnwcclgVao60ls9q57ZXhmzBM9Y4YRuYJvFO7+1uGfeQLvEdYAmL32ToekbWsFZVqXdO/ZaErN69XhRaLmpIAtBMrHUzKozRmMidaG98YOIh3SD6LxRNYTAVkgyAxVRhHN+3hpZyhyU+LTMhdEfis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790372406; c=relaxed/simple;
	bh=NiX6OLnRfjUoUlt1PhUW0YyDLITiDqIiUNVm9KX+CBg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lsPu+ickTQUbJGM/hz9eveHcilwXJ5Qlb4UaHOiHDrHuyH7Ku/7Ta+yf6m9KlXW7/UTODrcJrNAhjkDinZNKgegiEM5pJDZcbCnTC29+4cv/GKWeqOwy4+cAblstRZA92SM+vXAULLAVj5+4duFlHMRHwQeTwNlllBhJNfXGIbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=R2ptl+YY; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="R2ptl+YY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1790372395;
	bh=NiX6OLnRfjUoUlt1PhUW0YyDLITiDqIiUNVm9KX+CBg=;
	h=From:To:Cc:Subject:Date:From;
	b=R2ptl+YY1a0+ffQNbXRITflJ9gowJJvX7+f1Jm9bxAxMGvk7KL0E6Z/jZ+ffuUteh
	 fOzEXOKbCiSfQf/MUZIj4YUvxRghObqqSaIqfwNJ5l3dDiWWaRWi3v67QYZHlXOrs7
	 xRdEt7YmsdjoLCFtqmAY4FO04tHWdvOkCBPbLBQMGPGUflpnE0fngTOXvgQ6Uyv31b
	 q0TRNn050Bl2quO691xKKax3KMhH9ySXJqV4nSaaDzmvcu/dgNv6xIsJ/yWdgJEjCB
	 UAxadm45UWdjPnQ/1n4ltq+uPR1TRHjzVDDAEWuZ8TfUorD+QfFlir3tdZHItMAL9O
	 0WGOwqkpVaZoA==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 59A8660112;
	Fri, 25 Sep 2026 21:39:49 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id ECFA4201085; Fri, 25 Sep 2026 21:39:20 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Danielle Ratson <danieller@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Moshe Shemesh <moshe@nvidia.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/9] netlink: specs: enum alignment fixes
Date: Fri, 25 Sep 2026 21:39:03 +0000
Message-ID: <20260925213918.204767-1-ast@fiberby.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series fixes misalignment issues in YNL-defined enums or flags.

Changes:
v2: (got delayed due to conference activities)
 - Add Reviewed-by's (thanks Jakub, Moshe, Kory and Toke)
 - Patch 1: Add "fixes" in prose, as Clashiko guessed wrong.
 - Patch 2: Mention renaming ect{0,1}-pkts in commit message (Clashiko).
 - Drop old patch 4.
 - Patch 4 (was patch 5): Remove redundant enum-as-flags (thanks Moshe).
v1: https://lore.kernel.org/20260911214148.1184806-1-ast@fiberby.net

While this is not a direct continuation, the rt-link changes was
previously posted as part of another RFC:
https://lore.kernel.org/20260910221733.1021864-1-ast@fiberby.net

Asbjørn Sloth Tønnesen (9):
  netlink: specs: rt-link: re-align IPv4 devconf
  netlink: specs: rt-link: re-align ifla-inet6-stats
  netlink: specs: rt-link: fix ifinfo-flags names
  netlink: specs: devlink: fix resource-scope type
  netlink: specs: ethtool: re-align c33-pse-ext-state
  netlink: specs: ethtool: re-align module-fw-flash-status
  netlink: specs: nl80211: fix naming of enum members
  netlink: specs: tc: fix typo in cls-flags
  netlink: specs: fix incorrect name-prefixes

 Documentation/netlink/specs/devlink.yaml |  3 +--
 Documentation/netlink/specs/ethtool.yaml |  4 ++-
 Documentation/netlink/specs/nl80211.yaml |  4 +--
 Documentation/netlink/specs/rt-link.yaml | 33 +++++++++++++-----------
 Documentation/netlink/specs/tc.yaml      |  2 +-
 5 files changed, 25 insertions(+), 21 deletions(-)


base-commit: 42a9fb3382fc2573e92f41d203b095d9a372cfc9
-- 
2.55.0

