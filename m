Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793196810;
	b=mk1PRxqL5jH3jsYiuDtqAeveiGMFvwQg6uZk90N7xUfnNnsxq72W35N0o4ueliNc/8kH
	 U6MSpzvVtL6luZ6Tx5BpWqZIrvrnIx+8kZE+j8ablaXP2it60EdK9iD1cuvJPSimMxZLn
	 RbBGrHCZCtxPeTx88g09Zpu97N4ZHzAj31d2jxK+mqRBR3IcpeLaGOvvcfqa/eq2QZIap
	 5QtJuXGPkDGhmNH6GzuCoUkaoX8s3rVQ9yge314X/Abgjd/O5fzH+QdUxWTvUwrowBS2o
	 UbCFoplln9Ye9m3o2w1iWdZg5MJig5wloeUtc31ZCRcaOoRqAHWSzvD5OL4Lqq8T4nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793196810;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=/owevBWTqxgFWQjVwB299tXpM2V0eJK3NmUNmAavoRc=;
	b=scUEStWxUar5s1jzlIIANW9pc+yUDSIwqjutu6roMm/M4nRUuAo3eDpe+9Afk4n//HHm
	 lVZVbayIT6u4Vc5lA89llTSmhxOWbkWfsKMrfvHWpsLqsryQ9A2XyG7UQXFJj+TdXnUBS
	 BqNvy+0+2cZZyu1zF3Xh4pgQBuhEFkdCfpn56ZcVdSCtis4hA1hirnnFWjVf9QzHYQUym
	 bLC9hrkRCzkpnml3XzxvX9WyLD9JsRbDC7gGL0NG959Mv0TEwTMcyIMdaDdUMKmnfVvLl
	 rRDv9HWwO8kbq27M2eYR7kyerxPDdIUjM5hQXp+kVPToQ5VnDfVNiEFgRmKsfJ3NK9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OznpZwLE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CCB606A31A
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 14:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OznpZwLE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFC5C1F01825;
	Wed, 28 Oct 2026 14:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793196809;
	bh=/owevBWTqxgFWQjVwB299tXpM2V0eJK3NmUNmAavoRc=;
	h=From:To:Cc:Subject:Date;
	b=OznpZwLEmfc5pMpMJ3a+1Nv7cDDdNjYcTQPWo6Oxo8QmpVGmHFhkk6IInrM18GGFC
	 BrhbGFuSWKCGyHuq2ldRv1mEsV+he2Uup9fJKoBZc4qYsMAOCC81Z5lfOs7ZareEOV
	 /2g9alp/d95qPLwmB1cmljC02HNGZP6tNo6Pu+I1rmsPdkKhGITnKPMRcgTmmmJ96z
	 AT7pq1Os9beKZ9+Wyl0x+OykYfqIoJoDKX1ImqRi2S5p0gmRnMGsmvNZEUcwRQZjUn
	 HdrbCmd3Enai+y4VTLfGC75Qrdd7epiXXW3/RgppfMy8v8cgws3znZjQT2uxB1XYAd
	 eRp55uo/t7QpA==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	AutonomousCodeSecurity@microsoft.com,
	netdev@vger.kernel.org,
	edumazet@kernel.org
Subject: [PATCH net 0/2] net: gro: fix frag0 and remcsum handling
Date: Wed, 28 Oct 2026 15:13:23 +0100
Message-ID: <20261028141325.2103814-1-edumazet@kernel.org>
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
as skb->data was moved past the headers.

Patch 2 invalidates frag0 after a pull, which commit bd56a29c7a4e
("net: gro: change skb_gro_network_header()") stopped doing.


Eric Dumazet (2):
  net: gro: do not undo remote checksum offload on merged packets
  net: gro: invalidate frag0 after a pull

 include/net/gro.h       | 15 ++++++++++++++-
 net/core/gro.c          |  1 +
 net/ipv4/esp4_offload.c |  1 +
 net/ipv4/udp_offload.c  |  1 +
 net/ipv6/esp6_offload.c |  1 +
 5 files changed, 18 insertions(+), 1 deletion(-)

-- 
2.53.0

