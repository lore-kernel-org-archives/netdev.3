Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792608567;
	b=BK28Xbab7pVasdHNp0Oq8ff5C41LGSHjhDUUB5RPAti+bB2sy7i68nbXpqfyB7Sy9hpG
	 /dxWDXm6LwM1Qhnl3vSzSIbvmOOrJrUxkUq4N2A6chLiIR+LgviPytPfvprXIN0R5wM4Q
	 KcOpFCcDY4L9WoLAVDUqHQFPp7v5urOOO6s1zZUXzAAklIAIhJZMMSOQmbSZci2oEohQO
	 HfsU8IYt/jhRzNTIwGk68BaJwa8kpWgrzK63EqNhGTSiKSObeQKmH1rOoHvfbCUouI0pD
	 dAEs58PoscAPENzaj0dIL/hSOJnzN10NI5th4Ri0CqRRVBPSwVI0VTXbXiN6eB3LPpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792608567;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=wq1/fUbSP408+1Q3Fl5D/AoNlkMMVExemigFlptzFc8=;
	b=EIj5wWVbColf/pvwl7K+FEIPaTxsoEN8TODWAZsaFGpeJVFiP/BqDoLIP4FXjSDj47K0
	 a20bVNhikLHd+VVhaRJqgXwqNNZQH3mOPzlxosxTmlIZc/LEvfU9WLKYl0J0x+eSto19y
	 NQ4f2CMdY4k5kJU2QyfkdvEc5rdkQr8toNyQqHvFqK169Z75xFgVNoWyTOOonvE94mFVm
	 r0QaPv3zbEYnWdeLCzljVwq0eiVRkMzweq5LPV0LYrkHMkkE/251ls6Rkm37tTwg5l5LW
	 GlS2/BVQLQkonN2Mfm2VpNWVGwtYUPbj2tIZoe2opaXNYk/Rlc2P2E+0x9+IkjU0AlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=MdBgk1We;
	arc=none smtp.remote-ip=209.85.210.48
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2369B606A31D
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 18:49:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2369B606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=MdBgk1We
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-84d5e56f876so483392a34.3
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 11:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1792608566; x=1793213366; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wq1/fUbSP408+1Q3Fl5D/AoNlkMMVExemigFlptzFc8=;
        b=MdBgk1WeXVW4we2m7Lh9XTyYMe6RmHuEhY5hO1EjgclurjFlE6iypVoahcVivZsBoE
         iaZaWsVH86Plngf8casByA+PbHLI03Tk1oXgxpqfIJRRVXa8YfaBIVpoKjMEVUHNApHL
         kmFnxEMP/FPsXCnu9LaLhwdJc0HyGlnoKRxOinucl/UkNIT/eLvVJBbjteB9puSTeILY
         8O8MZ+Ja/Xdak57jSWmPsqN/QA0oIOVzjRTk2CGABSQZcE2t0UOmuC4MDunah1o9XVrV
         zG4pwnTicZM7eFXOe9ozqpM9CAkTpIy+Wr0lq18lYkcGNnYjylghVZ+OTiY3Ra57LIQq
         /8Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792608566; x=1793213366;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wq1/fUbSP408+1Q3Fl5D/AoNlkMMVExemigFlptzFc8=;
        b=JV/aCKPhcFNkaTg2zi5TD3NiaoraTu5rQGvMg19VdUOD2nUrwFDossvhhsFeqWOK/7
         1xCp/NEeWNesbZy4F1v+V4tZrFinIJjYE/TzfZoxQ9kNsAkprysMG0RCtT64Q/qnU5Fn
         zhNadMFJLQbboal1KONUyeg9iL0NOyryXZ48aEvilxzwBbQJBr6hWzc7+WY7a8fIEJj/
         bdBUSLkAkWTRRyO1NG9vYzyvx6hLcUXtvzYG08tA3/ZGlca6sjnjg8uU8X8flQBXZcVz
         hZCZLeYKubds9tKE+JI4pIPB/oiXateehDEIPrJ4Ub2/uoIrpyG0enhl7hC0LeT9fS9N
         YjvQ==
X-Forwarded-Encrypted: i=1; AKwUvBwLbq0ZxPYD/GC2MQUnSaY8j2X3dBP69Rlx/zap0KMqISXxa+J6mxIQre/AvufcE8BAtobncO0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIjHUE+qMQXAxGrxAqfyY+GeNzcrIfeE+tvBLpzmDtSgWZnVmb7
	hOYTmGXVBCLHSEVHGeSEDTJnhsizEDuYGq04pOjhPjn5kshwR9s/IE2wgJV/8GDemi8=
X-Gm-Gg: AYBFou06iPrMH+7fXVQmyx0RRbEZU82TS47iJgFAbMujlpMJeN8ZlBbvgYv1y71Y8Kv
	HnqePeBXUw0KxOCiPEKZVRrBNm43HMK9U6yxgQhF90DCR5DiEIAj5+S2Zo2Fj3fiTwRv3xnE1aD
	3VZvT/lsRcF4SgDj/cddlAZMQe0tZZez0Z4fA4Ymhjj0hTS2WkHONMNcWktm986gI6m3m+L9YcZ
	SlLYxM7WdqfAT/ibJLq0HNdJzBAVmlO6IwcunKWetDe3N0sGurdGB6KjCpTvyR0fhPW190XB1+A
	ccjpzSdPFC+WRw5tRPQb1fOdY+Y3Kyil2CHTs0xC1ju/jFvY/gy6yeFQD8f5he2uNEkNF/epVrX
	KVAId1gyvhNqjenK8HmVGO+Gxy6Mdz/SjSBYIG5z1iEyPOf05KcNXySDXX7L4kKMN+v8RRKvaTz
	Vue3cIXUAhm686Ludp6n5UGdAat9o2eYYGHMwdqU6N+Vc2z1iyXqx4XA6QGNBFuqLyEO++ViPQV
	ku1vRCJSCr4P9dKLOfVaemC03vJUawrcK6CMvM=
X-Received: by 2002:a05:6808:1903:b0:4b3:3e1:4a25 with SMTP id 5614622812f47-553559a2395mr2044396b6e.11.1792608565668;
        Wed, 21 Oct 2026 11:49:25 -0700 (PDT)
Received: from 20HS2G4 ([2a09:bac6:bf21:15e1::22e:5d])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-552b583fd57sm2528069b6e.8.2026.10.21.11.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 11:49:24 -0700 (PDT)
Date: Wed, 21 Oct 2026 13:49:21 -0500
From: Chris Arges <carges@cloudflare.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Phil Sutter <phil@nwl.cc>, Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Max Krasnyansky <maxk@qualcomm.com>,
	Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH net v4 0/7] more virtio-net csum hardening
Message-ID: <atkJMTj3aGMrXmY8@20HS2G4>
References: <cover.v4.git.mst@redhat.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.v4.git.mst@redhat.com>

On 2026-10-21 03:50:20, Michael S. Tsirkin wrote:
> v4 and I'm pretty tired of this family of issues.
> 
> Willem suggested more cleanups, but I don't think I will
> be able to dedicate much more time to this, there's a pile of
> fixes I queued that need to get tested and go into rc2, and a bunch
> of qemu features that need review.
> 
> Hopefully if any changes are required this can be done by patches on
> top, or if someone wants to take over this, very welcome.
> 

Happy to help if needed.
Again, I was able to test this patchset minus the UM portions and verify
that it fixes my tests.

--chris

> ------
> 
> As reported first by Paulos Yibelo <habte.yibelo@gmail.com> (after which
> others, credited below, found more ways the bug can affect users):
> 
> allowing untrusted hardware to specify csum start/offset for
> CHECKSUM_PARTIAL was not a good idea, because, if it edits the packet
> outside the actual checksum, and depending on the setup, the networking
> stack could be looking at the packet both before and after the edit, and
> seeing different results.
> 
> Previously, commit 6785011f8b16 ("ipv4: validate checksum_start before
> completing checksum") validated all known instances where this
> causes the most grief, but the real fix is to make sure
> that either only actual checksum fields are ever edited,
> or the checksum is completed before the net stack looks at it,
> so it is always consistent.
> 
> 
> This basically goes back to
> what we did before f43798c27684 ("tun: Allow GSO using virtio_net_hdr"),
> except in a narrow list of specified known good cases.
> 
> 
> Summary of the patchset:
> 
> These are probabably net material (and seem to be too big for stable,
> or I would recommend backporting there, too):
> 
>   net: account for ingress-resolved virtio net hdr state
> 	- accounting, not the fix itself, dependency of the fix
>   um: vector: trim skbs before verifying the header
> 	- fixes the um receive path: without it the checksum would be
> 	  completed over the unreceived tail of the buffer
>   virtio_net: parse tunnel csum_start little-endian
> 	- bugfix, a dependency of validating the header
>   net: resolve uncommon partial checksums at ingress
> 	- fix itself
>   net: add a sysctl to opt out of virtio net hdr checksum validation
> 	- reducing risk of the fix by adding a sysctl to disable it
> 
> These are cleanups, can be deferred to net-next, too:
> 
>   net: add ip4_parse()
>   virtio_net: cleanup protocol calculation
> 	- cleanup resulting code duplication
> 	 (kept separate to simplify backporting)
> 
> Fixes: f43798c27684 ("tun: Allow GSO using virtio_net_hdr")
> 
> Changes since v1:
> 	- reorder patches to fix bisectability, addressing
> 	  a comment by Björn Töpel.
> 	- code refactoring, different patch splitup,
> 	  a sysctl knob to disable as suggested by Willem de Bruijn.
> 	- fix a bunch of minor issues spotted by LLMs
> 
> 
> Changes since v2:
> 
> virtio_net: parse tunnel csum_start little-endian
>   - new patch. correctly parsing the header is a dependency
>     of validating it, otherwise i do not know what to validate
> 
> net: account for ingress-resolved virtio net hdr state
>   - make rx_csum_sw counter 64 bit so it won't wrap
>     (spotted by LLM review)
> 
> net: resolve uncommon partial checksums at ingress
>   - tunnel fixes to bugs noticed by Willem de Bruijn and
>     Chris Arges
>   - restore the csum_offset checks as suggested by Willem
> 
> net: add a sysctl to opt out of virtio net hdr checksum validation
>   - the knob is no longer writable by root inside a user
>     namespace: changing it now requires capable(CAP_NET_ADMIN)
>     suggested by Willem de Bruijn
> 
> net: add ip4_parse()
>   - comment converted to kernel-doc format (Willem de Bruijn)
> 
> um: vector: trim skbs before verifying the header
>   - new patch, found by code review
> 
> 
> Changes since v3:
> 
> net: account for ingress-resolved virtio net hdr state
>   - um: vector: honor virtio net hdr conversion failures
>     folded in (Björn Töpel)
>   - count on tap and virtio_net, too (Willem de Bruijn)
> 
> net: resolve uncommon partial checksums at ingress
>   - walk the frame on loopback, too: loopback_xmit() runs
>     eth_type_trans() on it (Willem de Bruijn)
>   - return the mismatch handling directly, GSO is implied in
>     the tunnel path so drop there outright, and fold the helper
>     into its one remaining caller (Willem de Bruijn)
>   - read the IP version through struct iphdr (Willem de Bruijn)
>   - document the ipv6_find_hdr() flags choice
> 
> net: add a sysctl to opt out of virtio net hdr checksum validation
>   - renamed to virtio_net_hdr_validate, in case more validation
>     is gated by the same knob later (Willem de Bruijn)
>   - point .data at the value like the neighboring entries,
>     the per-netns registration rebases it, and the handler reads
>     the value directly - no ctl_table copy (Björn Töpel,
>     Willem de Bruijn)
>   - check the opt-out before parsing: with the knob off, packets
>     the parser cannot handle were still dropped (Willem de Bruijn)
>   - include virtio_net.h in net/core/dev.c so the static key
>     definition sees its declaration (build warning reported by
>     Jakub Kicinski)
> 
> net: add ip4_parse()
>   - add the missing kernel-doc Return: section
>     (Jakub Kicinski)
> 
> Tested: full suite on the final tree, tunnel included.
> um part compiled only.
> 
> 
> Michael S. Tsirkin (7):
>   net: account for ingress-resolved virtio net hdr state
>   um: vector: trim skbs before verifying the header
>   virtio_net: parse tunnel csum_start little-endian
>   net: resolve uncommon partial checksums at ingress
>   net: add a sysctl to opt out of virtio net hdr checksum validation
>   net: add ip4_parse()
>   virtio_net: cleanup protocol calculation
> 
>  Documentation/admin-guide/sysctl/net.rst |  19 +++
>  arch/um/drivers/vector_kern.c            |   6 +-
>  arch/um/drivers/vector_transports.c      |   4 +-
>  drivers/net/ipvlan/ipvtap.c              |  36 ++++
>  drivers/net/macvtap.c                    |  36 ++++
>  drivers/net/tap.c                        |   8 +-
>  drivers/net/tun.c                        |  41 ++++-
>  drivers/net/virtio_net.c                 |  14 +-
>  include/linux/if_tap.h                   |   1 +
>  include/linux/ip.h                       |  30 ++++
>  include/linux/virtio_net.h               | 279 ++++++++++++++++++++++++++++++-
>  include/net/netns/core.h                 |   1 +
>  net/bridge/br_netfilter_hooks.c          |  15 +-
>  net/core/dev.c                           |   7 +
>  net/core/net_namespace.c                 |   1 +
>  net/core/sysctl_net_core.c               |  50 ++++++
>  net/ipv4/ip_input.c                      |  13 +-
>  net/ipv4/netfilter/nf_reject_ipv4.c      |  13 +-
>  net/packet/af_packet.c                   |   4 +-
>  19 files changed, 533 insertions(+), 45 deletions(-)
> 
> -- 
> MST
> 
