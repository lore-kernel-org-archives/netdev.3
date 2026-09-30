Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3574F68DF
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 14:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790779238; cv=none; b=is2/iyOATZMZQRsAfaREtTby2lbcp5nS6+w9b3ae0Zn0tkSOyVTY39wi4mW+Smy+fifZ9EGH9J6nwzi56xp2z2m1giOWFyVbjK44K1s3ELkIdRkAeJwiZYMAWF98b0bvN6mqRgeL6OG55a71xavoBWdPCAYc3NXt7rQA8Alfcwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790779238; c=relaxed/simple;
	bh=dJFrdN/76qv9/rK0F1T3luj/lxC3i0sx2hBCNB/i++I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bUuItFhzvsRzIjrdmeNLHPZ+c4RInSuigjNKx6M3yIlOw9PYce+gEz2V5BJ3fmM0zCc7uuFzY617mnWroVf55UBF1EU9M1yxpwDRCecnOFA4nXQBWMiMcELX9T4wrk66PIiJc0WICxee8nFVwATdoS7QVFCoFXvC2uYlyKeqOtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZnQzDfp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZnQzDfp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C20101F000FF;
	Wed, 30 Sep 2026 14:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790779226;
	bh=p0s7c0gBch1wAQ+QrR/OQVGmVX0TYWwQKFO6idT38FE=;
	h=From:To:Cc:Subject:Date;
	b=nZnQzDfpe3sUvtzJBkKhCXKTNKeToxZCA9L/1PZQ3JzzeeVXKC5AMGtBevEVmN3el
	 3t19xPVy3qR0xKTSVSNvEmwHS7jBoyDdsDxU6GhLZ4GNDC06avV7UzQULWomwV+3nD
	 jHSwoqCfSJ/JRGw9yeskvm2MKn3MrtP/YsuP/9fVZ95g6gYYVnJP2mKIkZkCggt6+e
	 PmkMysexnNsPvzNVHg5RgWJ/Uo6ZSFBsQH8PUAKU1yFzP/+33YGFtmPK7tbnSons8K
	 QuRMd/b6wlzr+a5rZJOElgdFvKg8Ah1ycNsF1X1Dudqvmi44k9P1IRsUpNBoGnv1Dc
	 T2j7IdIWu+ffw==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	netdev@vger.kernel.org,
	edumazet@google.com,
	Eric Dumazet <edumazet@kernel.org>
Subject: [PATCH v2 net 0/2] ipv4: fix IP ID reuse for GSO packets
Date: Wed, 30 Sep 2026 14:40:16 +0000
Message-ID: <20260930144018.1174068-1-edumazet@kernel.org>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes two cases where IPv4 GSO packets can reuse the IP IDs
of previous packets:

- Patch 1 fixes ip_select_ident_segs() for non-TCP sockets, which uses
  the first IP ID of the next packet since commit f866fbc842de
  ("ipv4: fix data-races around inet->inet_id"). SCTP GSO is affected.

- Patch 2 makes __ip_make_skb() reserve one IP ID per segment for
  UDP GSO packets, instead of a single one.

Both issues were found by code inspection.

v2: Patch 2: add a sk_is_udp() check (David Ahern)
v1: https://lore.kernel.org/netdev/20260929131247.401104-1-edumazet@kernel.org/

Eric Dumazet (2):
  ipv4: fix IP ID reuse in ip_select_ident_segs()
  ipv4: reserve one IP ID per segment for UDP GSO packets

 include/net/ip.h     |  2 +-
 net/ipv4/ip_output.c | 15 ++++++++++++++-
 2 files changed, 15 insertions(+), 2 deletions(-)

-- 
2.56.0.rc1.315.gc6ed9934b7-goog

