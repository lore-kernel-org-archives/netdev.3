Received: from mout-b-210.mailbox.org (mout-b-210.mailbox.org [195.10.208.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94E9499F3F
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 10:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789639820; cv=none; b=nbpQrAMcY2NtSWlBNxK3W8hTPGHzbDujNBnleicsboGnbRJRXqZqXIKKLzdmQVREzvL4+sFRw3KX9gaRrZF6EE8DLdwRKvK3VMwV3d2KbUb4izoJIcOq4Do11xVpgbM+hYibGEPutF77rIJbTlUNC4dqpDvuUr8rWRsLhBLS9jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789639820; c=relaxed/simple;
	bh=HsrnUPcMGJwnU6UoQ5qZ11wuJTi865wdFcZpvgfhnsE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MJjPsmfhmbbd/8zYFqHyNpuDTe30KPG9JPtPQzKEWBgAFJAxQGYFJJgN8SuQ7i8CldbFhCH94FmIVuZgfzJFA7LQTqc2TfruyKquA8QE4/vvnKlqIJ2wvjSPOSOkKE+iaOGV1BRtQbl9f1eNT9QMTUmEbWjR2N2zQfdZxf3CJNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=DkCaSCRT; arc=none smtp.client-ip=195.10.208.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="DkCaSCRT"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-210.mailbox.org (Postfix) with ESMTPS id 4hls270bHWzFqyT;
	Thu, 17 Sep 2026 12:10:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1789639807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tNFXjqJpkpVnxP7pEVRWKOU0iJaRJRiAve6AfXxiGRM=;
	b=DkCaSCRTAYXHHNtYvoWrd/TOXtYJX7VGsYW6VI2+lnl2T5J8ieixyubhgVljppQgdeFrmJ
	ivBWtOxv3JJP8HbWRHMjxSPehxtxAYqC8c6Q0j1yIyuAAH9fK2JQhtuE/0s8dYLt4V0ema
	Ua0WQhjY//nDk4lxqx2LfZ4hTLTiwGo1X5oul1PhbFuDoFgqYZ1IX35mFMXwV/nHU4u/Xc
	2P7+MB4B24+FwiSp2G71NYCdGjAEYOQiEpEHEjwNT90O0JuYNBWomP9bfFUmYulA1OA0Ca
	Nt0Wg94j/ULv12STR5OvCGPcYOTBsSFPYvcI1OuHDuHsW1Qeb+Du8zly3NpRXQ==
From: Ralf Lici <ralf@mandelbit.com>
To: netdev@vger.kernel.org
Cc: Antonio Quartulli <antonio@openvpn.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net 0/1] ovpn: avoid caching stale IPv6 dst after FIB changes
Date: Thu, 17 Sep 2026 12:09:53 +0200
Message-ID: <cover.1789639346.git.ralf@mandelbit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This patch was originally part of a wider ovpn series addressing UDP
route-cache correctness when mutable socket routing properties or peer
endpoint state change while packets are being transmitted [1]. The
ovpn-specific fixes were resubmitted separately after dropping this
patch, which addresses an independent IPv6 FIB race reproduced in ovpn.

During review, Sabrina suggested submitting the patch directly to netdev
rather than through the ovpn pull request because it touches generic
dst_cache code and the underlying late-cookie sampling pattern is not
specific to ovpn. I first sent an RFC describing the race and a possible
kernel-wide solution [2], but it has not received any feedback so far.

After discussing the submission path with Antonio, we decided to post
the concrete ovpn fix directly to netdev. It prevents ovpn from caching
a route if the IPv6 FIB generation changed during lookup, without
attempting the broader network-stack refactoring discussed in the RFC.

[1] https://lore.kernel.org/openvpn-devel/cover.1785308184.git.ralf@mandelbit.com/
[2] https://lore.kernel.org/netdev/20260901122501.482920-1-ralf@mandelbit.com/

Compared with the version previously posted as part of the ovpn series,
this patch has been rebased on current net/main and made independent of
the pending ovpn route-cache and endpoint changes.

Thanks,

Ralf Lici
Mandelbit Srl

---
Ralf Lici (1):
  ovpn: avoid caching stale IPv6 dst after FIB changes

 drivers/net/ovpn/udp.c  | 20 +++++++++++++++++---
 include/net/dst_cache.h | 13 +++++++++++++
 net/core/dst_cache.c    | 19 +++++++++++++++----
 3 files changed, 45 insertions(+), 7 deletions(-)

base-commit: c9151088f1674fd29ff26a20f5fc687acf53a2f0
-- 
2.55.0

