Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792936234;
	b=33aKCSEUD9Non7HdO+N+Yf0CfGuT5NN+TKlNSh/8ur5/2KcFNdD9Ef2OJ6UGK0TmomGn
	 Gw1NFGeQzPWvSM2OmgsD5Kn0bPCeGagJIq25yi2YahWmb8g3RNZJHdOc1ZepN9b/qrC9D
	 OpVV0s3HH+jLNJ52yTk4p+IFvQFReB7sbSEX03DPwHtnqG02a+cQfnEnsGizx3szlhlaY
	 tDNc3KsowPr+cSgZY2optvfBkIsUIeaDZuejWFvkdvmUI+irnrukZfwOPqf/vcySaE8Az
	 Db9y4DUe5My1ucerRM0FSgkqBZLkAOdLgwkkYwQpERP0AHROkqxNCls8aJQxt3TYhlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792936234;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=ZVC6ZkKoHNQk6TZWCjrTXHjV3/INvwxJlTKOGJKjAvY=;
	b=xTIcrKAzQlmGGQVlAkveGjZOx9i2qoW4WbEJ6/VE8PH0tVBPFQeUaZQvOMWy3gBBAJT4
	 X4ymBW0nJKEjBeDFO1IiOQyXLCqWt/er5FVcKnCJgJjLw0QXfGEHl7kJbXIjd02IgwqaW
	 dXr0ayYJj0FgZTDHCjdJ0xv7bkGIRDsm+AlzMerL1ymD9s6Gxg/O7tG2nwFxwq7719J/J
	 semFOlW1eRYwCCkPv0cZTbJCmZ5gzKKQdAdqUYV0d8Sxu0SQRDp9JxhFm8CaAKPrf1RlW
	 I6AiqawIUC4qKB855MNyjrt/movnQHre/LeIskz1w71pmGm5o7TLrmAFkUUDf8Uvgsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UqIZRyhj;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Kp57jODT;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF87606A31A
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 13:50:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DF87606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UqIZRyhj;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Kp57jODT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792936232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZVC6ZkKoHNQk6TZWCjrTXHjV3/INvwxJlTKOGJKjAvY=;
	b=UqIZRyhjrS8A6v9ujkbxfQXJXVuqVXhuHgP14tLvvyiLZ9EOIa6VZSSGsmLAzgSg8tehoS
	8EtiylRAON2WCY8FqbkJO7IkLyCozipzj4D89TvKJPpiwl2gBLJLhmnU9xl5OcR54EpE3p
	pj65JOk88+Xw8OSK0KCazIYjwAuIvVw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-1I52DtZ7PeOknMsFcfPU1Q-1; Sun, 25 Oct 2026 09:50:30 -0400
X-MC-Unique: 1I52DtZ7PeOknMsFcfPU1Q-1
X-Mimecast-MFC-AGG-ID: 1I52DtZ7PeOknMsFcfPU1Q_1792936230
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48afcecb035so573318f8f.0
        for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 06:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792936230; x=1793541030; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZVC6ZkKoHNQk6TZWCjrTXHjV3/INvwxJlTKOGJKjAvY=;
        b=Kp57jODTLPBWc4pyXw5BxcVsUl9wmb5E7ZLDORx4uIB4UXqVpb/CqlesYNQKqqGJR1
         1VhObqPSdwDXidR6R59BVWToy/ycK+3pgHB8GKQC9xtnRBQRL9gH57wU+4Xz8ttGVRSx
         egjeeH+Re7Mdv2K0PKK5HN3F2lk0838yT6CgqzY540uwzvqMTs/Pb9+8OvIQY4d3wZz+
         plYq1DBYq6I4HPR9rX5d+dP7qlXAdlwx3zFZlDq+VlWPRrOFug3Xf9Nb6mmhpXBmm+uO
         HulFMvHITnEEyxYajnDgwpnDn+MnaIMqLaGiWRB8pCB1NQ7PA/AYbL4OCGtUH+S1lY4v
         qr6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792936230; x=1793541030;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZVC6ZkKoHNQk6TZWCjrTXHjV3/INvwxJlTKOGJKjAvY=;
        b=CYBIL2rRuEs8dBHPDVgYvE0WGfSnD9V4vMH9jH9m1ubrJ72NIEw5vLFlq3ZY49lnHB
         lopnoEelfq0RVmUa1okgtcpZywCyybnhSfEy+KHWaHQZNXtq4YExaaEjtOs/a76EtKsA
         f8TgxGoSlMkf/VLnpXKAsdTWnjxlIUl4kE7zK5KOwMj3qaV/hyZTk/ruTprB1bgfNG/W
         2zBeodO3fTPgicVyyLB442a9mp3w0n8tGQJKOD/oLL0Ek+7UEKtVBR7oOS9jz6F45BfH
         ZLL7CylMDEe9fU46z6rjU4+9qBlXaqTZNAqNAPCvEnyWk4Sw21JU7Mda7s2eVc6w+Ha5
         wSUQ==
X-Forwarded-Encrypted: i=1; AKwUvByNq4Ew5aLypjsM8XaefknI2gqHBMUvNdNYLN3aHerlCODtQKof1pxYV87EEFBFJzKPyZ7SqDI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIbrZLWI6C+RUlnIIf2g15uI3JfAIJIDrRniA0OzZ1lmV++4NGk
	9bQzphQmxKOH0Wxl+CH0jbChW3PHCccn41ISm4aIhi0vtiSn6ZbVn7zqB4PvY4EDMZVeytMASLQ
	qqJARGHJbObRPXWwxJitbueQ0DdEwAh0EeqYLgZjtGfAKJ82o3csioxQL3A==
X-Gm-Gg: AYBFou0FPXHVsaER/PLm3xn52soft/zOtzhZPukHtl+cIErInwvdVo58MZqQzZr52Mv
	WnyUTCmLizf8IxhfoXNwBjwmHcQ/FyGimVFUNkQlNtbIt7+8DwzWwbZVKgeywgWVf61aKuehQ5B
	J4hKqJzx+Sn/7OKmWR00Dd6xSdV2zr1XF3sUmY8+0DRgpJfctCwfFKRMtW1Mm10Xjdf6UFnv4rV
	fYpcPcEzNN4QKrDVHeyNV+/LHKvvv6i8hNmQECTxccZgWlstHQnj/MxFpiuKf+wE/9Yw49DLW/0
	087JkUnBkNAbDA11tnUkAfqcbCXJ/pzcS3dBfnswYOha/NnmK2hkcBXwawMOELbfocA=
X-Received: by 2002:a5d:490c:0:b0:48e:6f:19b2 with SMTP id ffacd0b85a97d-48e3eb90d56mr5779496f8f.25.1792936229528;
        Sun, 25 Oct 2026 06:50:29 -0700 (PDT)
X-Received: by 2002:a5d:490c:0:b0:48e:6f:19b2 with SMTP id ffacd0b85a97d-48e3eb90d56mr5779460f8f.25.1792936228946;
        Sun, 25 Oct 2026 06:50:28 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc3dcbsm10205279f8f.14.2026.10.25.06.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 06:50:28 -0700 (PDT)
Date: Sun, 25 Oct 2026 09:50:24 -0400
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
Message-ID: <20261025094449-mutt-send-email-mst@kernel.org>
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

Ok, I looked at netdev bot review, and there's another issue.

If a tunnel inner packet happens to have a valid header at
inner_nh_offset, it will pass all checks, but the transport header can
in fact overlap e.g. the real TCP header and checksum will overwrite
that.



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

