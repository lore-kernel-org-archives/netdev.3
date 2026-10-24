Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792856551;
	b=PkUrAqOJhgn9652VG+15dNJ+akwow89jb39jM9+V99nyOkuyohCyyBV2k2lcU3jgisKl
	 xS7K+oXNiRh/1djGhGDrsJEFahWKTVXel4z7Sy6g2UEy9Nc/guOeMh5r9S2lsNbdQb4A1
	 w9vu7un4hwSLLL3UGrcfGKVsfKrS99RFcWhDh6qkdfGCECzGF1AEf7HgXaWyKd4eyqJxZ
	 PpyX0KBU7rsHKunoAd3R+X0EDgEg6mN4SlCBxJvaH0281DlmbfChfLjn81xvplQf8/+H2
	 rX4u/ki7DeXQFzlpnEH5b2d7QDKCBjjiFoIkwzFk1/DCCMLKsfV906XlV+lofRPC5lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792856551;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=ve5RdvSUQWrWJ7y3heJ0LDreEwIkfgbRRQ56HJPkuoI=;
	b=OETngT8mAR5GNwB0nSsm62eOMmrZkEl1B/XC04J9BTaPHq4WyvX69mnciQZ/gWmyP4v2
	 UbFoh6PbgBphNxxjuPDIfzGIXCbOh78bUSunIcOHg5jiLv9JxG9oknOpGJDHpc/PapDBl
	 Ma3iOQ8jT+0liAJn3aCjAX2CAPmhd6g8/geUysI2337eLtfH8BpbuYxiNnVQ30KRlEbMT
	 V16bI12XoAyRFkjaqmCwtJkwNXs13VBFUb2GpJEK0o7YULkB1tRuuPGNJp5sfeBZ0xdZc
	 fPaHBnpCPJvtkd3IX2bDnODDVySY5Uywc0+xXo5SCxjPkFEFY8VFtESK5gjlP3+tKgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XeGYNT9L;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=fyVHr3Yd;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159F1606A31F
	for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 15:42:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 159F1606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XeGYNT9L;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=fyVHr3Yd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792856550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ve5RdvSUQWrWJ7y3heJ0LDreEwIkfgbRRQ56HJPkuoI=;
	b=XeGYNT9LO7nXFkJxXcp+RHu8WDkzAI23aym4YKLWekV9xNO7SaC3gsu/eLLmZ+vvPKJ5V4
	hgSSpDkfPvs2gOJX7C3VvEUsXWP5Dtw3pmPfXDTZneDKjQYmqG45+wouS6/atvSNUA0+rI
	ryAupfe1CiMfOF3izi/Qk3oig5iFAn4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-7XdVbGW8MfeOyeF3Bsxmgg-1; Sat, 24 Oct 2026 11:42:21 -0400
X-MC-Unique: 7XdVbGW8MfeOyeF3Bsxmgg-1
X-Mimecast-MFC-AGG-ID: 7XdVbGW8MfeOyeF3Bsxmgg_1792856540
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a204f135ffso10172395e9.1
        for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 08:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792856540; x=1793461340; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ve5RdvSUQWrWJ7y3heJ0LDreEwIkfgbRRQ56HJPkuoI=;
        b=fyVHr3Yd5U6HTwhektAYa7Z2qxUP6o01ozDcwtjeUU7L2CFQS8DkTbjuIoGji2QpQW
         DDuuiai93ttmjcBfbBqDpr256wEmCrfzR7wHFJUc/6ykcv+blXxav7/y+rmXnS3Zf0Rj
         YXV4xDzJFb9s/EpspEBSpxhWxEql18P9yOfUmBZW0p/+FI7AFrjMDN/DoKR2Xdzh4qeX
         ZWMNR2MB7dOHg6H3EDEs+JlNP9mlMIWzQhnLfbIcQkgEBJKV9KWcP2gqa7g37+AzYDUb
         nitpc43a0w2nvqdYvWh9rDLeUTQuRVb2tEd5An0F0zjdLXw082843kX71kJql36xCBSh
         ZjaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792856540; x=1793461340;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ve5RdvSUQWrWJ7y3heJ0LDreEwIkfgbRRQ56HJPkuoI=;
        b=pg2KwnqIOA0RdYSDPUyCwVntnHj5AodtDra4vYxrf6znu3J9A47hQSEXoR9LGobVFY
         XV6FriM+xOzCRCtGxt+9Lb2CeUOktcntmDV9WH/8ycQN2cPYIPr5DylvDQ9BFvzJYpuH
         scY4ucs6lUbBxnJScMXM6C1EN8y6qZHwbA6Y10jNWoV8SLnkofh0KI29SxuKtxtMNL6Z
         1KyznViT7bC9wJnis7o7xAgOIyTcejQQRRotLOqLkrIl39OkGampKdRaHRzJf48ivAVX
         lttX6ziEGHNZt7usCylEdWan8Vt1HjhXN9kqj28w3YyFtmJAHjWEOss8jf0Jfynb8jSE
         vonw==
X-Forwarded-Encrypted: i=1; AKwUvBzkeSrtl3OUdE9EtzZpnVdOUK1AJaOXoVcl5RjQrPLhjqcxmV6qoHz5mNqGjMOvDWlc/SmAqnw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKhWkZaxi3MVt2Opbcq7pnjIz1bGOy3RbJLuK8WaoZQiWBVP+7X
	GqImpKO84ZuUtkRuqjrEPi4myHffvr7P62+thqSyACFkIvmDbFc+W8pgq0J/Le9BqxCZUui6iHe
	DR3NzOHDyQaRGVbPZ8cz1hwOrzcotIW9rI6km+TgNdLeVqJ+UNsYpp5qw1A==
X-Gm-Gg: AYBFou1M7YMC6UrZ5L/xdJqUQT213aVlltXiedR1a/cjoY2Bo5DKlAIzQjhiDxKTzSB
	yVMG8W6QNKWpBgNL3mZUVsCRoOoHXGdGoh2pv7ZdBDedNKjS6Kq7UNNcWL5rI2by9xmeaBHDbfk
	VFXhB6sJsGpCP5G/19ZVSeyJflNuOrBaGAwdB/emJEo+/Zg32a5b+/zx5i0C6pdKkXN37tIXOe7
	C+pR0FWYLyWRHa3JCUfjx7pzcWaK+sTqqZbbTpLyGwvkMj58df7VCssogseHjYiZvNry3QRGm9w
	eY9BV9iij86tfb7ANnuFvqckSiSkowPzAWpYJ/vVpS6WWieuUcLumGlrz4+MDe+U7nfMUV8=
X-Received: by 2002:a05:600c:46cd:b0:4a3:59c2:b41e with SMTP id 5b1f17b1804b1-4a35ac39396mr36770825e9.4.1792856539674;
        Sat, 24 Oct 2026 08:42:19 -0700 (PDT)
X-Received: by 2002:a05:600c:46cd:b0:4a3:59c2:b41e with SMTP id 5b1f17b1804b1-4a35ac39396mr36770405e9.4.1792856539078;
        Sat, 24 Oct 2026 08:42:19 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73f6:2400:30a8:9e33:7d82:c035])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a00e1b0sm49273505e9.3.2026.10.24.08.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 08:42:18 -0700 (PDT)
Date: Sat, 24 Oct 2026 11:42:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Chris Arges <carges@cloudflare.com>,
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
Subject: Re: [PATCH net v6 0/5] more virtio-net csum hardening
Message-ID: <20261024113809-mutt-send-email-mst@kernel.org>
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

On Fri, Oct 23, 2026 at 11:09:17AM -0400, Michael S. Tsirkin wrote:
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

Ugh. I found another wrinkle( Firewalls that shape the payload.
They are currently seem to simply be hoping most traffic is CHECKSUM_PARTIAL and
only looking at that, and that will break.

I am not sure what to do yet. Extending the sysctl knob to control what
happens if validation fails: pass/drop/complete - is the best I could
come up with. Or ignore the issue. Or just forget the complete at input hack
and drop if we can't figure it out.

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

