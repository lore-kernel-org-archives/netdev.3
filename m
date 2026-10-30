Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793365200;
	b=uZBCn18oIbqdqCey+dg157QhlW1lxLTWuWALYh+5qkJGs/On2kQPKDpHK7hy6te3lQqn
	 7XvKf7NNv/01UuDV822A8iDoGzzX0PabH8tJaIn84ZOMgaqNaehj+5gdTUDm0PlXJ5JC3
	 Fq/t3Ec52UbcK8O5UnZRIAL8NIbwFHZi4Mtd0nHOzElV5s6wZ0as44zP9wbbcMK511tNM
	 aovBnZDDERgw8PgQnLdqV+Vg70lQA+jaPhnMZaSpEHa41BcMhz8zXr6v+cj0OxAbJOpTt
	 X+51rWspJkylg47figgmNfq3qZFwiQlMuUBmsqrx3u0XN6vYhurheuJEa9B38Fw03ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793365200;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=DrBSL3cT87nM+7vHR4EJhPvwogGgO7ZMjQbpZfJyISE=;
	b=baNHKj2QOtcCP89Ul0xLUGbXt3dgLjwZyiojQK+Q9i4c6rH9+5bFxLi1xWcA3fyjUd2X
	 f6brfxRXMQp5lxlLD7KIQhdSnln5dvyYslJRJB5mZSyCgg7idR7BtCoEkmWFaZegAC74m
	 HRATWMdtEU/zmQR6fb0NYUYLdoyNn927CdYcj9Y/A1L22cx9fnVpRSS+M1H/nCsn8IjPm
	 nGqD5qYQTlukK7FBPe6PcjHvmTwbNMuhSq+NuFCPrhbqD+DmizLBGLxfo25ID3uqiqZEE
	 m/Ag8tZRamyadu3WdAzzNNIogcuYvUEkjr1+R/0mzZgHRvPQRjpOYClWk2vXSj9wzSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BhN09Uha;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662B7606A327
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 13:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BhN09Uha
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFDC11F0093A;
	Fri, 30 Oct 2026 12:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793365200;
	bh=DrBSL3cT87nM+7vHR4EJhPvwogGgO7ZMjQbpZfJyISE=;
	h=From:To:Cc:Subject:Date;
	b=BhN09UhalceOozBMbkmw+Tqm9t83M68b/bxAslNnveI8yyVX46RDgldRFXtD/CwTy
	 2PYRX3ADbedkWdqvyCvLAkbHTuoIpg6Bcb8NBP0MQyNN6IWCKNe2F95FgjidQlYV+S
	 eipmMsjPfXoGHV/LBtxurqIgi95RCjvTinG4/oqhDVSB4aCryhlo8hvru6vyDCxKRS
	 W1AGig+A0EG/D9vr9FwsE8SbaUGmHQ6GyYIqyhYHDHucrjNw0VNT2FJ1t6R2mtQGbj
	 WiRrilwofnWM6ZVLTikRu6qK25hm8rNZDBJI4bF+sGyX8d0sQzkh+vP1W8VALeKJfS
	 2vBuTX5VT/nfw==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	edumazet@kernel.org,
	Willem de Bruijn <willemb@google.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Tom Herbert <tom@herbertland.com>,
	Cen Zhang <cenzhang@linux.microsoft.com>,
	AutonomousCodeSecurity@microsoft.com
Subject: [PATCH net v2 0/2] net: gro: fix frag0 and remcsum handling
Date: Fri, 30 Oct 2026 13:59:53 +0100
Message-ID: <20261030125955.3107383-1-edumazet@kernel.org>
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
as grc->offset can no longer be trusted.

Patch 2 invalidates frag0 before a pull, which commit bd56a29c7a4e
("net: gro: change skb_gro_network_header()") stopped doing.

v2:
- Patch 1: reword the comment and changelog: skb->data is not always
  moved (frag/head steal), and fraglist members keep their adjusted
  inner checksum, which is the intended value (Sashiko).
- Patch 2: invalidate frag0 before the pull, as __pskb_pull_tail()
  can fail after pskb_expand_head() freed the old head (Sashiko).
- Patch 2: add a Fixes: tag for UDP fraglist GRO, which pulls
  directly since before bd56a29c7a4e (Sashiko).
- CC Tom Herbert and stable.

v1: https://lore.kernel.org/netdev/20261028141325.2103814-1-edumazet@kernel.org/


Eric Dumazet (2):
  net: gro: do not undo remote checksum offload on merged packets
  net: gro: invalidate frag0 after a pull

 include/net/gro.h       | 18 +++++++++++++++++-
 net/core/gro.c          |  1 +
 net/ipv4/esp4_offload.c |  1 +
 net/ipv4/udp_offload.c  |  1 +
 net/ipv6/esp6_offload.c |  1 +
 5 files changed, 21 insertions(+), 1 deletion(-)

-- 
2.53.0

