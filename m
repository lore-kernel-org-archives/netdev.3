Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB23E3BE162
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 09:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777454205; cv=none; b=KddnaLwHPyEpBnDPnJfrS4secH/vmBlWyeqxVtMur+rjn/1wBc1qgFGMgoDdS5wetaMwB7Qt8DKcZKpUqbuN1Z5J+hgp7Zhmh1fRg6CayZ4VgiHvlZ3dqeTt1pvpBbdG3DP9gwy83fHMXkmkYCy9Lq4Uq0d7FoXFGjZe3CNUByI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777454205; c=relaxed/simple;
	bh=zg/Pz/BFqrf72DZoag/0MP2PduVAz8/HE3aKT5CpnvU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KA9z/jyCoxSNNv2COvwrg2mFmdVKMpQAt+zrNx60Zp6k9p+olYSgBRC4DJjPGrSxGfXehlEmflacvttj7n5yDdiTJUn1SBvgS2z1Qnrr9JBFeotANBOJXDzPtqipBk9BrCMjqS4sl2SD++nn9W2LEF4RNUsYxf1ZTJIT8mm/fkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=A3elTUNt; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="A3elTUNt"
Received: from ms-a2 (197.87.13.160.dy.iij4u.or.jp [160.13.87.197])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 63T9GYcI043681
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 29 Apr 2026 18:16:34 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=4BTnd8GaWFqwK6bklZlSRXajgKdYiTs6LR3SRu4Lx3k=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20251215; t=1777454195; v=1;
        b=A3elTUNtVD7FP++cQeuEuPv9KFt2PyeIIKrYzZ3C0coqe2wEDJfM0fXyWXH8eqtP
         0GGlEnFAfnw64bFgwrmsYlTuqM0o2Rg6Gdu673g4s5tJezNt3KLA5wg0ahkeFlDJ
         lcGNP65/SrCRfy6oZIt0H4QPoAm2TcsHSyMhineVZ0TDHMy751daAQ480clutTPJ
         3aNLqMqVqwkZwPSFjI+xiaTGVNTg59dE5/ihoEEMMI6XPcb5UdVRqh+YUGyvPKjg
         eect2DPyvBntv6ji0toYIkeBjIUaZ60rtYEav/Fi13OcAQk4VKLXJdvHi1L6CsVe
         E+C4meT68Rru1flOa1iTPw==
From: Kohei Enju <kohei@enjuk.jp>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Kuniyuki Iwashima <kuniyu@google.com>,
        Willem de Bruijn <willemb@google.com>,
        David Ahern <dsahern@kernel.org>, Neal Cardwell <ncardwell@google.com>,
        Gerhard Engleder <gerhard@engleder-embedded.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Kohei Enju <kohei@enjuk.jp>
Subject: [PATCH net v1 0/3] af_packet/tcp: fix late hardware timestamp handling
Date: Wed, 29 Apr 2026 09:16:16 +0000
Message-ID: <20260429091632.26509-1-kohei@enjuk.jp>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 97dc7cd92ac6 ("ptp: Support late timestamp determination"),
skb_shared_hwtstamps may carry netdev_data instead of a resolved
hwtstamp. AF_PACKET and TCP could still read that storage as a ktime_t
and report bogus hardware timestamps to userspace.

This series factors the late timestamp resolution logic into a common
helper, then switches AF_PACKET and TCP to use it.

Notes on SOF_TIMESTAMPING_BIND_PHC:
The generic socket receive timestamping path honors it, but the
AF_PACKET and TCP receive paths touched here haven't implemented that
behavior.
This series doesn't change that; those paths always resolve timestamps
with cycles == false and preserve their timestamp-domain semantics.

Kohei Enju (3):
  net: introduce helper to resolve hardware timestamps from skb
  af_packet: use skb_get_hwtstamp() for hardware timestamps
  tcp: use skb_get_hwtstamp() for hardware timestamps

 include/linux/skbuff.h | 11 +++++++++++
 include/net/tcp.h      |  2 +-
 net/core/skbuff.c      | 27 +++++++++++++++++++++++++++
 net/ipv4/tcp_input.c   |  3 ++-
 net/ipv4/tcp_ipv4.c    |  6 ++++--
 net/ipv6/tcp_ipv6.c    |  3 ++-
 net/packet/af_packet.c |  2 +-
 net/socket.c           | 27 +++------------------------
 8 files changed, 51 insertions(+), 30 deletions(-)

-- 
2.53.0

