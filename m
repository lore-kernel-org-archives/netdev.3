Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EB04A4EFD;
	Fri, 11 Sep 2026 21:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789162969; cv=none; b=QggM/4vh3KZeZ+suW9IEYB2N2QG7WXeM9YdUZhjyTEE/7Jbspr+vS1w59A8Mh3On0v+jV1uKSvg/OVnIi6BHDicdPWR4f0N5Jz2bVFXxebwsK6m0sw3ueXVMsmQeXxkMEgRCqQXBx9dUSfCNBLq7sERvQ9BGYcPTbDsqt9EQv+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789162969; c=relaxed/simple;
	bh=h0xEH3LUtHxZgnjgyf/N9qBl82/2NYc+ecKOQDO7g88=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KPjVOmwIWbilYJOu79Mur06gK2sGKDx2wfcr42t85s0RQrolpbMmdosF2FuEvIayaHyZwt1018DMs9X6wl6P1Keks60WVIpvh+y02KyL8ocqsRwxQgdbOCN4MLbSIIo59DGnBrp2vfEjr+i1So8/Oa/LOU0KmCPXwWTtTcRhHIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=RiS6y/pk; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="RiS6y/pk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1789162963;
	bh=h0xEH3LUtHxZgnjgyf/N9qBl82/2NYc+ecKOQDO7g88=;
	h=From:To:Cc:Subject:Date:From;
	b=RiS6y/pkKkrZ8FcOCjxHAVdPFaXALhyWx/Ci6EwImv1aIwLR9GMQ8Iwixn7yJVDZi
	 814Gooy/a6U08vwFjcf171/2Mjr2axs9yLPePruc6GGiXe6RwNhS5SnqE8DGj75K2Z
	 EA55pWNK2nG9zSi4TtpyUEx4DPVLYTKHEYZnA20CxI52Lrc7k2ngFjQe2k6ZBMfMzH
	 4tkdteTcokJl+Laa9r6ZqU7aSKNZOfXOqo5OjS8tSm8Kf+MBe8mRs3YFuVDunKGZy6
	 u+ZXg1uXOVzF78l1PSib3wCHBApOExcae2ig699sYLBNzyOJeAvYpDjHukEC8vVEwx
	 Nvuw/l2QaYHyg==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 1D942600FC;
	Fri, 11 Sep 2026 21:42:42 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 8F3F220173F; Fri, 11 Sep 2026 21:41:52 +0000 (UTC)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 00/10] netlink: specs: enum alignment fixes
Date: Fri, 11 Sep 2026 21:41:26 +0000
Message-ID: <20260911214148.1184806-1-ast@fiberby.net>
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

While this is not a direct continuation, the rt-link changes was
previously posted as part of another RFC:
https://lore.kernel.org/netdev/20260910221733.1021864-1-ast@fiberby.net/

Asbjørn Sloth Tønnesen (10):
  netlink: specs: rt-link: re-align IPv4 devconf
  netlink: specs: rt-link: re-align ifla-inet6-stats
  netlink: specs: rt-link: fix ifinfo-flags names
  netlink: specs: rt-link: fix netkit-policy names
  netlink: specs: devlink: fix resource-scope type
  netlink: specs: ethtool: re-align c33-pse-ext-state
  netlink: specs: ethtool: re-align module-fw-flash-status
  netlink: specs: nl80211: fix naming of enum members
  netlink: specs: tc: fix typo in cls-flags
  netlink: specs: fix incorrect name-prefixes

 Documentation/netlink/specs/devlink.yaml |  2 +-
 Documentation/netlink/specs/ethtool.yaml |  4 ++-
 Documentation/netlink/specs/nl80211.yaml |  4 +--
 Documentation/netlink/specs/rt-link.yaml | 37 +++++++++++++-----------
 Documentation/netlink/specs/tc.yaml      |  2 +-
 5 files changed, 27 insertions(+), 22 deletions(-)


base-commit: 17d3afadf539c93def8106bbb83c88274bdc7ab1
-- 
2.55.0

