Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792428713;
	b=gMGWJZSjFDdKo+SZQCHPHjXzbsmYz33HlFS0pKqHvEofEMoQjFh6QZlkYbcwcvtv8jp8
	 WWfPGIl1ZerEBV4MMfCTPizOnenC12Ei0p8JxtnzHnpgXj/dyjGENgSP7aRMyZbkFbCDf
	 ILfXWWMb5pvVcEB+wDsKNuEBFz3zN3RKKwbaqGbBYRZKrM4XR7QUACLIM53GOgT7ErbzO
	 OgdfRxxqiFoiJk4p+HqGA1DsVhQhdJEqHy8FMjO8IlfuhFEwWZeVfmpn2kNcH1/gQgKcs
	 JaF8LkIMFm3hDU7stQ491ZmgrqF3a4nla7nvWDNUjM6dLDopp2glFypNa75FR09kueQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792428713;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=GGZr1o3aGctzMnwygsbHm91Fqbk3LTUuMaHfiMRf6n8=;
	b=QYbLXxkJbtl4SjGI0f+/vL4vRsitxdWp2E+RJCHRfTEsNMWne6bQ1lwsDGha1CPahoPO
	 r9ParWozixjXsEb7XEOgZVAkoPLoLbAgo7uunissQifQPAKARHeu8iLZy4A48WDIPWezc
	 9e4ZMmrjHCCmBqun3XzIK3Y2AjRoRXAPhj8bgre6Pa1Xch+iRVSWV+tJT7rah/MQbVwU8
	 hZhopMHoTrbLE6TNlKyfigNRAnHNg0kAK5s3MoNdYF2KC6OUBm6+UCUhUG/hjO0nJeZCa
	 wB+pD97ZYudqg9rgAORuWYG0op3nR2pqJW41lZthwYsSjj+M7pxM1hrNqPSIfMz7nLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=EUsLt7ZY;
	arc=none smtp.remote-ip=209.85.160.53
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E715606A31D
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 16:51:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E715606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=EUsLt7ZY
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-43bf9548df4so2161955fac.0
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 09:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1792428711; x=1793033511; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GGZr1o3aGctzMnwygsbHm91Fqbk3LTUuMaHfiMRf6n8=;
        b=EUsLt7ZYqcow/jOpknGbgQQ0c4KxNjKZ1Nc1GdO7VOBwb2g7S+Pk6l+/v/T2BDKmUE
         cra+UEnGQnuPqaw9rv7n65snT4N3J8c/p7kGVNvT9YcYKTNJn0Kt7HlVVIFQjM07QKRR
         dun7gyYqekqsArEHSMfzpio6eRx90H6l5NKSMpXls/eR7yJKQzwPpFz2aJPtX62sQ4UQ
         qkm5HkmXwWKaI9rCmS3kpsbsWZGCNLNTLw2lmDKf4QLwwDbAKgX3vivV8HiBUpOS6NPm
         n8iV308M1uts+672F8yrAzSx5fKIiMK01whwsfrXGS2Neqw6mfa3eUYNb3aH6H3jFPnf
         hmJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792428711; x=1793033511;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GGZr1o3aGctzMnwygsbHm91Fqbk3LTUuMaHfiMRf6n8=;
        b=QUt+IZcVDjMoO8XrYH3jWR4/vFf4CtRBvsilt+oort/1nkLku9k0yuCyerzc0fkSRB
         TmZDUddfqZz63czEeFLCCVGEBPU/5m58cLYww4Yl2Hktl6+/f6W7i3164gTAfbIWIRtS
         VcAIZX+cKXNmN4zSqbK40FRbRjeZfXyRQhSR3BbfUexplydOODTC9vqslhIY/0UTqBTX
         eSz/Y7d6QV+niPSnDbuVWRnXH0tONlJ9xfF8ZVpifWDzL/UrL3UnrIiUzDUGUDgosbFr
         fuYxq0+kz980hpEQCMotmqMck2wLGYg7NMVwQz3o8RzRNPwrkJkhPRuwRvGclo9kHAyx
         VEVQ==
X-Forwarded-Encrypted: i=1; AKwUvBzTlY0IDNHXcCIgGurKmz5IKHE7AvYbg/NwVBPapkaMlizE+BQkMLJ/jxtA1KnqWbU4h2x3Vec=@vger.kernel.org
X-Gm-Message-State: AFq9FYIzjiFo8d1y6K0adWs/uJ3ezy57Z5Ya4lhNU5JR0gICiztSknnQ
	3ILcswWBeQwzCiaRC+UMqpjK5tRdjHf/NRL8OAgJ3G098mxqR0rGs5Vb3fMxEqIY7kE=
X-Gm-Gg: AYBFou0QhBbVG0jL44uJOgQgcvtmk2xv2VNsq+ZI0nZ05YHJXiyLvdwnO0Mhl1FTt/1
	JI4IDEFPf065Dvgvp/mE6ZZCyEbrAF+S/5twpvl4wDgIrABSi2RzXoMT225YHtdNgZeVPm3UgRP
	/MdQYTkws+rvZ+MEuocNb6tL3Yq4TvkugqbR+50YNNTEdrSE3mec+B5zpbA4L7JKOc4+4D3EBa+
	HDTmYElLYStWIkhJlksXkWraE/AxcVN9CsHPWxoICrrqlIjpcYPe3GcQz8d5eWwSsbyteHVMd2E
	Delpr2/6P9okPBGMi/a8rWBR2iLCuoM2G3tW/odyiKKdoxIpihtGa8gt/0gs3sYwBS7fYLA5HsX
	ArbDFZuenMYKAw9QpblJN9YXlStt7Wc6DjQOAQvIbZ6DoykzyG35RsHsbhy+/44ZNCNeMpwtrSs
	RYB+2G3dJMWVCaKl/t07yNtd1rieFRgl/KtXON7bjMsYh0aax04EyrmdmO5CUNriLHSLM5hqtHr
	P/9vRnnCqLRbB+hFVyG/Y6rtvCOVhJw6u5DBXw=
X-Received: by 2002:a05:6870:3c13:b0:494:b8f4:9a22 with SMTP id 586e51a60fabf-4a757917efemr6305805fac.28.1792428710995;
        Mon, 19 Oct 2026 09:51:50 -0700 (PDT)
Received: from 20HS2G4 ([2a09:bac6:bf21:1c64::2d4:c2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a73b640adesm8785424fac.10.2026.10.19.09.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 09:51:49 -0700 (PDT)
Date: Mon, 19 Oct 2026 11:51:46 -0500
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
Subject: Re: [PATCH net v3 0/8] more virtio-net csum hardening
Message-ID: <atZKogiEAkStdgQ2@20HS2G4>
References: <cover.1792411304.git.mst@redhat.com>
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
In-Reply-To: <cover.1792411304.git.mst@redhat.com>

On 2026-10-19 08:03:00, Michael S. Tsirkin wrote:
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
> These are definitely net material (and seem to be too big for stable,
> or I would recommend backporting there, too):
> 
>   net: account for ingress-resolved virtio net hdr state
> 	- accounting, not the fix itself, dependency of the next one
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
>   - parse csum_start in the tunnel header little-endian like
>     the rest of it (spotted by LLM review)
> 
> net: add a sysctl to opt out of virtio net hdr checksum validation
>   - the knob is no longer writable by root inside a user
>     namespace: changing it now requires capable(CAP_NET_ADMIN)
>     suggested by Willem de Bruijn
> 
> net: add ip4_parse()
>   - comment converted to kernel-doc format (Willem de Bruijn)
> 
> um: vector: honor virtio net hdr conversion failures
>   - commit log tweaks
> 
> New patch:
>   um: vector: trim skbs before verifying the header
> 	found by code review
> 
> Somewhat tested, tunnel also tested now, um part compiled only
>

I was able to run my tests and can confirm no more KASAN errors. I did
not test the um patches.

Tested-by: Chris Arges <carges@cloudflare.com>

> 
> Michael S. Tsirkin (8):
>   net: account for ingress-resolved virtio net hdr state
>   um: vector: honor virtio net hdr conversion failures
>   um: vector: trim skbs before verifying the header
>   virtio_net: parse tunnel csum_start little-endian
>   net: resolve uncommon partial checksums at ingress
>   net: add a sysctl to opt out of virtio net hdr checksum validation
>   net: add ip4_parse()
>   virtio_net: cleanup protocol calculation
> 
>  Documentation/admin-guide/sysctl/net.rst |  19 ++
>  arch/um/drivers/vector_kern.c            |   6 +-
>  arch/um/drivers/vector_transports.c      |   4 +-
>  drivers/net/tap.c                        |   4 +-
>  drivers/net/tun.c                        |  41 +++-
>  drivers/net/virtio_net.c                 |   2 +-
>  include/linux/ip.h                       |  27 +++
>  include/linux/virtio_net.h               | 272 ++++++++++++++++++++++-
>  include/net/netns/core.h                 |   1 +
>  net/bridge/br_netfilter_hooks.c          |  15 +-
>  net/core/dev.c                           |   6 +
>  net/core/net_namespace.c                 |   1 +
>  net/core/sysctl_net_core.c               |  60 +++++
>  net/ipv4/ip_input.c                      |  13 +-
>  net/ipv4/netfilter/nf_reject_ipv4.c      |  13 +-
>  net/packet/af_packet.c                   |   4 +-
>  16 files changed, 445 insertions(+), 43 deletions(-)
> 
> -- 
> MST
> 
