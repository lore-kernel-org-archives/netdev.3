Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792778869;
	b=Z0MTS+YvbydkHZSRzrLPbjY61TU77WQ7JuNvNabDe9kunr0JATEMBBFWChVOMsuh8DcQ
	 jPtlc5UTwe2O76wI/YVEtvNY6VkEKfONS2aVg/dZ0I4crbM9mFPht38lVsq0sgvwFNgzQ
	 m2I5GX3nv8qkW1BhyBjWGIRtM35xCpmSF3p7TTj93KLj8HToh1d5wQPUceX6mkm+8HEse
	 cE8w491QaSHqOq04ShQqPMofZLXkwKKhiJOu4BcVX+nGCO8mSWLhwRWnf8yLExQnlr2C3
	 v5SjXmfBPPxQBrHZ9pDT1UkX7t153RzCf4mi1NEwxglpGymilTTiibq8ZjRzgB5l+Dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792778869;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=7sC6xYpF4qIvHkwjX8HFmuHgTEf6DcO7YRZah/Pkcg8=;
	b=EBRdizxwx0k2RtrhsQhH+oEyNV/PRDP03WydRaEdG+w9jxr41boN5Sy2A18/HRUCUfZ/
	 x+dwMTwzPiQZRjgR+FI4lAE2OLUwTMmvdx4KOaW+KYM7AcmAo3vKxUBfeP/rWl57JYEfK
	 9JO/cjaJT07ySqvXxzMXgstjocnpO2xSAkVIJV33w1DZCiUHJ0QOwhE/P0eAUoVz6CjWy
	 4v4vRyLVD+GAALeqBAkJpuWtACuRQIMmuGwNmqCVEE69BjC+K7RQt34M5ot7dDJat9zBQ
	 JZ+d6f7VqF5/RKa6GG3pGO742AEW6D3yGTn22MJXS4ImcQPqcrOc+0bkIHfQV+IiT6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=YbOQgjc4;
	arc=none smtp.remote-ip=209.85.161.49
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D320C606A324
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 18:07:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D320C606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=YbOQgjc4
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-705cb6cedd5so1496118eaf.1
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 11:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1792778868; x=1793383668; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7sC6xYpF4qIvHkwjX8HFmuHgTEf6DcO7YRZah/Pkcg8=;
        b=YbOQgjc4x1mayqmHu/1DIhdmnHsTtqKNzcWPHjcm4G9enyTTzfGwLAKthnLMUfZWdd
         NHOtOKtb5CTDTYjkuQrLy/rAbXq6DBRb6Q8iErR0BU1K4ONaPQCz+FTkDS8tk57FgrAt
         Jdan14iLXv17z2qHtgZL7ANme4ZIMBCX7GLcEwdBZUqXrs7UvJujl63GrxEr1BLlWlnT
         TPQKRAiV7UqBd+9aNPecCXrbYyGCz6aTU361yFb9X5UegCfn5xVLAPbKAFNkHYYIrtw/
         pop0U7wkRKyUr6Yp46khVXq3PxowZwVxxzOaT95z/7NbswY/BM+4te3StMv6v6joncjE
         OBzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792778868; x=1793383668;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7sC6xYpF4qIvHkwjX8HFmuHgTEf6DcO7YRZah/Pkcg8=;
        b=wpBOd8tvTxY0uWikdzC7B4gH4cuYny3gSPiHHbZuu3NUnawFiJrftUD03FOa6nzBq7
         Peb0iMRHQFrNvHCNVILgeWA5K01eh0tDPgytBcQYckZb+mPCHFt1vdxX3taidi4W+2O1
         jx9SeK+N5123rcocFpq7D21wZRDqwaVvas/E5JHGBPTfHq0/xIP8eK7UH7MZMCHXDeVZ
         0FN3NqXlULUvM2h/s7mPdi4DNrtO+tFJgPn5EcB8M9DkLeAQUwzNqoDF0FakPbPT/OzO
         F2CLmiJEha2Ui+8em+2k/1FQoALeaBExZU6isyM8fvZDNQVzoII2awpefVZ/3VuG9jK3
         SGgA==
X-Forwarded-Encrypted: i=1; AKwUvByot3BBYF9bp4cG7UzfNqPsieSfc8YEHUmErE/ncFWpF6H7Pff/qVn06OrZv3swSEfSpWcuBZU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJdi7PQW/22zSp0hUASQeR2SxsPeHUHyKDGhKkHSstUG/R9h7nE
	aTHACtyqSqWfJlXWe4Jo8U/CwtIFqNxlWb36UofTYn1gqAZR/B71xDmYFKvR2EEyoLs=
X-Gm-Gg: AYBFou0zR16dVOoKbvPBXzUv299L0aymbNmIiLvN8C3ZqpcHTSud7ktxz9u1BbizNs/
	OsnRglunqiw8kn1RAb4ME361LOvEnUCLnD9MzO3CZ6Cz4aI3kwZUDHQ1RER5RMygtjj14pAzk9+
	NK+yOsyIykkC6n4flcpXQst5B1LpQK5Pifp5gBxu5zM3igNxqOJEEOasZ4/jtJ7PBu+4naFAk2z
	t7rEQnT3ScCsUgpQCXX+YOYuEK1nOwLWJic/3ZVWeFmz5+cSXeCAqYA0qWaD+pr+5iRlTHWKh4V
	aykn5BPAr6kyiDZjAEpdtW2D7FtE1VThE3gTgwvZvsZKz1UidQDbXyAPhnRtSIDpyz3RmUxx5P8
	LPZpYBnoQxteAC0LEbEunlwS4+CXq4Zp28IbqQtC0gP4/5YykIe5hOpjJd1r/8DSgokDYCWry3G
	ObL7+aYLafqGhpoF8nzlrEQfpOXu3uSlKTkRNlFemOc1DYeKXJWrlRZtMzwq0pYsidAbfKIHpEH
	c3KvAXYkYcsYpKCGczH2AB6v2rWk/EFclIGYRw=
X-Received: by 2002:a05:6820:4619:b0:709:a86c:7c68 with SMTP id 006d021491bc7-70b88a82b37mr1271587eaf.31.1792778867656;
        Fri, 23 Oct 2026 11:07:47 -0700 (PDT)
Received: from 20HS2G4 ([2a09:bac6:bf21:1923::281:7a])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-70b9ae9604asm542486eaf.9.2026.10.23.11.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 11:07:47 -0700 (PDT)
Date: Fri, 23 Oct 2026 13:07:44 -0500
From: Chris Arges <carges@cloudflare.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Phil Sutter <phil@nwl.cc>, Jason Wang <jasowangio@gmail.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	Max Krasnyansky <maxk@qualcomm.com>, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH net v6 0/5] more virtio-net csum hardening
Message-ID: <atuiK4g28D7q22QO@20HS2G4>
References: <cover.1792768096.git.mst@redhat.com>
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
In-Reply-To: <cover.1792768096.git.mst@redhat.com>

On 2026-10-23 11:09:13, Michael S. Tsirkin wrote:
> 
> Okay this seems to be converging.... But sashiko did find some issues I
> thought are best fixed. Specifically I thought of a better way to handle
> short gso in a tunnel - just clear tunnel gso! As a side effect we now
> fix up the checksum for these dodgy packets like we did before, instead
> of a drop. Good. And more false positives that prompted me to write a
> bit more comments. So here goes.
> 
> Apologies for reposting so frequently, I know netdev bot will be unhappy
> with that.  But Paulos's report made a lot of publicity, there is a lot
> of people looking into this, so I feel there's value in defending
> against all this class of issues sooner rather than later.
> 
> The issues were mostly found by code inspection, but all reproduced by
> me in a VM.
> 
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
> 
> Changes since v4:
> 
> net: account for ingress-resolved virtio net hdr state
>   - count on tun only: dropped the tap, macvtap, ipvtap and
>     virtio_net counters (Willem de Bruijn)
>   - the driver side branches are in their final form here now,
>     moved from "net: resolve uncommon partial checksums at
>     ingress" (Willem de Bruijn)
> 
> net: resolve uncommon partial checksums at ingress
>   - no longer touches the drivers (Willem de Bruijn)
>   - a packet too small to be GSO: ignore the tunnel GSO request,
>     same as plain GSO ones, and complete wild metadata in place
>     (sashiko)
>   - document the zero copy interaction (sashiko)
>   - honor a preset skb->protocol on ethernet: the stack uses it,
>     except on loopback which re-parses the frame (sashiko)
> 
> net: add a sysctl to opt out of virtio net hdr checksum validation
>   - document the netns lifetime requirement (sashiko)
> 
> net: add ip4_parse()
>   - pull the whole header, options included, so that the
>     transport header offset is within the linear data
>     (Willem de Bruijn)
> 
> 
> Changes since v5:
> 
> net: resolve uncommon partial checksums at ingress
>   - read both skb->protocol and the frame ethertype: do not
>     validate when they disagree, instead of preferring the
>     preset protocol; same check after the IP version inference
>     where there is no L2 header (Willem de Bruijn)
>   - pull the IPv4 options in the helper as introduced, with the
>     transport header offset computed before the pull
>     (Willem de Bruijn)
>   - fold the trivial protocol calculation cleanup, formerly a
>     separate patch, in (Willem de Bruijn)
> 
> net: add ip4_parse()
>   - the options pull moved to the helper introduction in
>     "net: resolve uncommon partial checksums at ingress"
> 
> Tested: full suite on the final tree, tunnel included.
> um part compiled only.
>

I tested v6 patches, they address my original set of test cases.
I did not test UM.

Tested-by: Chris Arges <carges@cloudflare.com>

 
> 
> Michael S. Tsirkin (5):
>   net: account for ingress-resolved virtio net hdr state
>   um: vector: trim skbs before verifying the header
>   virtio_net: parse tunnel csum_start little-endian
>   net: resolve uncommon partial checksums at ingress
>   net: add a sysctl to opt out of virtio net hdr checksum validation
> 
>  Documentation/admin-guide/sysctl/net.rst |  19 ++
>  arch/um/drivers/vector_kern.c            |   6 +-
>  arch/um/drivers/vector_transports.c      |   4 +-
>  drivers/net/tap.c                        |   4 +-
>  drivers/net/tun.c                        |  41 ++-
>  drivers/net/virtio_net.c                 |   2 +-
>  include/linux/virtio_net.h               | 319 ++++++++++++++++++++++-
>  include/net/netns/core.h                 |   1 +
>  net/core/dev.c                           |   7 +
>  net/core/net_namespace.c                 |   1 +
>  net/core/sysctl_net_core.c               |  50 ++++
>  net/packet/af_packet.c                   |   4 +-
>  12 files changed, 441 insertions(+), 17 deletions(-)
> 
> -- 
> MST
> 
