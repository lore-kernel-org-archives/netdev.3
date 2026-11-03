Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793703483;
	b=U+FL1dRVRra4C2YwquezV3oEr1/xjdBXjvvFy/O4cMpjzwBoSum2GiS0+3Dbtc9+gTY+
	 KBdJGxqOUg5134KJpCoB0/n1mL9NTrrLqsgdZeQ9Pok3ICslPxJvdDpgBB8o3C6wvXVIp
	 741/NG5TlpZEy9qQjrQO/mh8CJV0gaL7nO0C55mtHR2wNRRWoTW5gET6uG8NGuSrqjDTt
	 8zeWnSPpQ61ashkngibMsQlPfjVwhD+So/vzkEyzMH7DtKBYyznks5zwP5t1GDt/7HNm9
	 3RlrYuDwTaAlrFdL5c1w2rTbzDVAOealYIndiQgIEwosB8RtFo+fqucKBmvy3FpKoCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793703483;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ktfr6TtXjrppBhI0etKRTkR3kgLgwWr61FrkywuETvQ=;
	b=5o8EWf5E4iTk/xdLjoA1idmfCje3MsWvnb69DoPFM1mqUrsLkS6VI/5likz4lF+QEguS
	 5iHVqaEhj5bfUIIKh2M2FMbMq1SiLFoUqsvEbhWtjfiHGTCl2Gi5enofWGlOOurXe7jFi
	 7l4LVVnb7Unskck30nypmb2BFjSTHWt7lr/O/bmIcIyiRRXY99PVmv8kLn2EhmQwQ2jHQ
	 Z/km+oCBPvzKYs8uQbgONKSxJUO3NKoqvi2cGDmCDOaorAw3Sl6trGC/HDEKk5if2Wd3X
	 rmFKudpT72yUHeXzz7uLIgfw26hYX/9JBCN3tUTd6/Yh/GWoWkM+SuG65fqDsQ3qtpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LUZtmLoj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCB6606C5B6
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 10:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LUZtmLoj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 331EE1F00919;
	Tue,  3 Nov 2026 10:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793703482;
	bh=ktfr6TtXjrppBhI0etKRTkR3kgLgwWr61FrkywuETvQ=;
	h=From:To:Cc:Subject:Date;
	b=LUZtmLojHRgppM2Dma6+UABig1CCezxtjGZpzUOHcapJIqWkl/QwAqfQHDY85yRPS
	 lk4g2bSG4q+Wf/3WB0hSluXXuvC6EhPu8XdVBopP8uCxfS7TnC4A+rfphUjXKXZbc2
	 nViqyX8XWBb2da2291uLsKzjWhwfhOJCdzwcmbXGbTkblH3u6biBS3B42eLezYKAoF
	 R3rLHi7O99YYVc2e0iSNhi0i3EdZU75DdcrJLxLC70WxmWjTAyceuR5MZbhUZsC1bR
	 AanGzaBX0LddZe1C13xgmXL2vX1jnkNfvBLpUtH9IJGqgNXEM7MOtsXy+zjVOx1n8L
	 o6HG8b/bRfYPA==
From: Eric Dumazet <edumazet@kernel.org>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	willemb@google.com,
	steffen.klassert@secunet.com,
	tom@herbertland.com,
	cenzhang@linux.microsoft.com,
	AutonomousCodeSecurity@microsoft.com,
	Eric Dumazet <edumazet@kernel.org>
Subject: [PATCH net v3 0/2] net: gro: fix frag0 and remcsum handling
Date: Tue,  3 Nov 2026 11:57:50 +0100
Message-ID: <20261103105752.49542-1-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two GRO fixes for paths using remote checksum offload (VXLAN, GUE)
and for NAPI_GRO_CB(skb)->frag0 after a pull.

Patch 1 skips skb_gro_remcsum_cleanup() once the skb was merged,
as grc->offset can no longer be trusted, except for fraglist members,
whose inner checksum is restored.

Patch 2 invalidates frag0 before a pull, which commit bd56a29c7a4e
("net: gro: change skb_gro_network_header()") stopped doing.

v3:
- Patch 1: restore the inner checksum of fraglist members instead of
  keeping the adjusted value, which was wrong for forwarded packets
  and for GUE. Only restore it when it is part of the headers
  pulled by skb_gro_receive_list(), as start and offset come from the
  packet. Mention FOU_F_REMCSUM_NOPARTIAL (Sashiko).
- Patch 2: only use frag0 in gro_try_pull_from_frag0() while frag0_len
  is not zero, to not corrupt headers after a failed pull (Sashiko).
- Explain how the issues were found (netdev bot).

v2: https://lore.kernel.org/netdev/20261030125955.3107383-1-edumazet@kernel.org/
- Patch 1: reword the comment and changelog: skb->data is not always
  moved (frag/head steal).
- Patch 2: invalidate frag0 before the pull, as __pskb_pull_tail()
  can fail after pskb_expand_head() freed the old head (Sashiko).
- Patch 2: add a Fixes: tag for UDP fraglist GRO, which pulls
  directly since before bd56a29c7a4e (Sashiko).
- CC Tom Herbert and stable.

v1: https://lore.kernel.org/netdev/20261028141325.2103814-1-edumazet@kernel.org/


Eric Dumazet (2):
  net: gro: do not undo remote checksum offload on merged packets
  net: gro: invalidate frag0 after a pull

 include/net/gro.h       | 27 +++++++++++++++++++++++++++
 net/core/gro.c          |  9 ++++++++-
 net/ipv4/esp4_offload.c |  1 +
 net/ipv4/udp_offload.c  |  1 +
 net/ipv6/esp6_offload.c |  1 +
 5 files changed, 38 insertions(+), 1 deletion(-)

-- 
2.53.0

