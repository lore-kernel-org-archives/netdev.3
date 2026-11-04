Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793805050;
	b=ytqXn4q2kNTIcDKIC6Zb/cEfS1funDyWbXL1pHpIxqLMNJ+pi8qqvC0hu5h0LY8beiCv
	 l3NqPe++xEtcD5oadA5WKNATO0kn34yF4QW2NuWD/vp3koDnH74mT6d+tP0+1Q0LGmRN9
	 L0GVq9/9eNGNXLNtE1jcJrE25sipeP3kglqgQmzS2qc9EGEK0JAvLvuowiyqmrKaFlPN6
	 IKyCeCnvevLFRnYbqDlv7BD28FXLtIYa+dnYjEUI0M1K8Sh+ELWtUrH+sYIG3YIXArhg4
	 3n23HDMYdtcgd9riLllcVATsu5iALLUF0GzznCQolFVA79it3ZoSlMG9oqkLhiDOraA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793805050;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=E8AFgNTmCXbgxtxj1hng+8rJEOPCc5jIRloVBfbwTLg=;
	b=GrrSIR/yFHSxEfVOvn64gQYEf0tvitCeZjYk1oJaJGIo6Pk+Wk3ka/6+mioilFBmHLMI
	 hs+t8GCj4EaOeSWGCwxoJXRBFPKarw9fMJTvM7zXgYbUUqDD85xupV3qmJawsaqZtmAPc
	 15zMNqQR+hM6U37v8WaqNriWnqwXaQwp7rxQwrpnaq5Jh9+6YBPh03TlS0YIHwYO/j9US
	 oHu9IAa2iKk4ZymYgl+996b3VmZ0IQUdKWxGBpIzp/FVn0cAydNu2hI7o8z1W4JkrfD0j
	 aDtasgHcrhd+hD4pVYeWBy+c+vCFEcl0ZFGTtd4TrqZK0z0Tuuxkq02WRGFK/2nfzWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n8525tEp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7969606A329
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 15:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n8525tEp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 001041F000C1;
	Wed,  4 Nov 2026 15:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793805049;
	bh=E8AFgNTmCXbgxtxj1hng+8rJEOPCc5jIRloVBfbwTLg=;
	h=From:To:Cc:Subject:Date;
	b=n8525tEpLVHIeOb4Ljhhbg/50hG6LEu7WHl8u1D6kPJzUQT2N+vFOmvgFrjhPKms3
	 B3YINPOYIpdOmgMG1OpKRpj8utmK8OQY1SvMqoE1+lhqEE2+n36p72iDStm/6YFO4g
	 grbYtpmiq0A4TDzJ162Nb12O4IC/sf4bfKEVE1UZbMUh/b1icwLdbqRl8bvlHxMFZq
	 yfWCrkb4RdnF38uPfFtHhgQtYc790vBflIPpJ9SxrHhMsstJWIJ9+BmLBah7djYKlU
	 ZCda5N3dg7fVyoxlBjsB9ilMWEek9FR5+JlPdsHiNgRcqp9ne1+/epJ7s3YSPZFcie
	 2CSTWLl6Jp8gA==
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
Subject: [PATCH net v4 0/2] net: gro: fix frag0 and remcsum handling
Date: Wed,  4 Nov 2026 16:10:40 +0100
Message-ID: <20261104151042.1157782-1-edumazet@kernel.org>
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
as grc->offset can no longer be trusted, and no longer builds
fraglist packets with an adjusted inner checksum.

Patch 2 invalidates frag0 before a pull, which commit bd56a29c7a4e
("net: gro: change skb_gro_network_header()") stopped doing.

v4:
- Patch 1: make skb_gro_receive_list() refuse packets with an adjusted
  checksum, instead of restoring it for fraglist members, which was
  wrong for VXLAN packets decapsulated locally (Sashiko).
- Patch 2: do not hold the packet if the pull in
  gro_try_pull_from_frag0() fails (Sashiko).

v3: https://lore.kernel.org/netdev/20261103105752.49542-1-edumazet@kernel.org/
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

 include/net/gro.h       | 18 +++++++++++++++++-
 net/core/gro.c          | 27 +++++++++++++++++++++++----
 net/ipv4/esp4_offload.c |  1 +
 net/ipv4/udp_offload.c  |  1 +
 net/ipv6/esp6_offload.c |  1 +
 5 files changed, 43 insertions(+), 5 deletions(-)

-- 
2.53.0

