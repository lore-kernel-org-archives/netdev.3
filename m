Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BED4E2F17
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 15:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792164621; cv=none; b=ii2406do1viZplcG6lIpipm78USHHaqmrQm/inE6Qj+DfGogCU4zljb8tGnIQi6KQ5Ztig6TQVRw83TdnJMmrXD1xF5p0niYVRfsWmsU2h+t2wVJkEkZFvQjhBIcCnJpTmu5szU3Qdmz65X+GrUzLT3eRH0Wn3bWS3x61v0poQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792164621; c=relaxed/simple;
	bh=IMgRqh7P9bFjG3FfvNoeXAv6Y2588Kxr8DTOqxdoKgw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=nlpIGCo0sndsCzLawH3ma61/NBIzxPW5MMOAXy13TEAmEVDekAjmU4teT3IBD/paPkYAnukPXTM/7iu9SJRRe4vNs8mz6YlaxYkWhJyJTcspDm0rrt4hVkm24zvtzvusp57W+SmDNpAd+uceV8qKXbsWX0uvmDe1CDH5d195Rh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KHcDDe3T; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHcDDe3T"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-7c3b75caad1so3963378137.0
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 08:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792164619; x=1792769419; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EzgDhar5zkz19hBJENwPklhUs01SGYbuNfu08NDtMCg=;
        b=KHcDDe3TiZHqPdrRSG1PuehEC3fud6vLfAYiRm5TT3GDi3zkDvf6KoV5YT+OK5B20x
         piaQ2+hRNyy7xWEF48DyfIv1AIpiMeGFMF0s8fbLNy8x5kc+FLiYyLOe3BAposIrH/Pg
         GOPIYGO/y/lWgppiHaknIzgJOzLIQDecBgK8eW6Pmr2/DKeQk6P9YYWV0Coxuo3ykfY0
         ycNph4bc11HWb2ddYSS803JPu7nIkMJMFQVCOWdXb6/4isbWfeU5SezjIlLjs+9foQvo
         ePAFFkOAlPLScxddFDbVRWosIXe/vWKuxC8VsI6rU+Y3p8A2er+A+O77EyIs6X7bUOEP
         GYsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792164619; x=1792769419;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EzgDhar5zkz19hBJENwPklhUs01SGYbuNfu08NDtMCg=;
        b=pNBO0NsBLmMfPLZ2E5WVdnvj01cE+ATqLu/3Q0gQ89yJqW63LbgI0QuQlVpITfCwrs
         NU5Zw8smyVspb1j6KLmrLN74PvALpiWQ8PbG56hUySBTeyOJICaachKkI+XPkEqbsxwi
         eoqPWPbv97M+V3qhJBPpkSh7VIkEA9q8QEwBolL6RACe+80FQjhSwT4escMnU7GpqBlo
         ZuCkEk8RFj8G+rX8OcfNoXJE1tLcXeWuYFZ7S4RWTjXG9T0ULuXcWdvjuEkti8XNfZ/M
         ojxH31txZSF+stgib0aCzscubSGLwC3oU/pfgQ2N79sweOkcEx1gg5q8Re3TxjLc0mcE
         kCLQ==
X-Forwarded-Encrypted: i=1; AKwUvByBAbWWE84bBekmBTVrDd7gxdpN+z6fqoUL6DiTSn5lx/2XsSlNt06A/cqeYTlBgXsdDtkLVow=@vger.kernel.org
X-Gm-Message-State: AFq9FYLtfRuC0MT+Zn9gWjUSL7oOQFqoQVvCT1o0BnMokpWiEOAPiBDb
	MqPnhi5zyt38DmQBoJBwPkbvz4Qc0zgDKHME29UkepCW+6day7Ah6cAp
X-Gm-Gg: AYBFou2cuRhHRsksoSSphfstqgIZcyU+4LtpXHVUmgobNRTuq/Mc/sY1oyvx3uAzq91
	5P50b+QyL1Q1Y7goxzioju1jnz2f2n9rzOhG4682GBvACs3saqo2tzcpACcnE8Gk6QjqwUZZoTq
	gEhjnwVDrJ2F+mEhTn5JYKBPQjubBTIpz8DdYGkNFwZM7vC2WW8cVt72/vCXhVrhtcClOsmJOZI
	22fCj17oXvae4l4fTT3C4YmdIBt7ZaAPjQ76BTZlPL5o0JgXfkIhmL7WqgGwL/NOUt17Dgdhmon
	no9wtJ719r61IYCtEqbzk/bStLgcoe6HNPuaDh5rvAbMhDbtdu/Epx6tUyoqUYiFaUmrBrSAhsD
	LCpv9VmH8fJqE8ZaSQjanmMtYDIks6LCLo3BvL1RheWSGTyrLK21X2aJL8L2Xf2OOrj2kKAA0Os
	YZ/Lu7qbS+yu+wMSmjqXTHUZmfFsjsQ08VY1CWBKNqJPKbjGDLLCjSAB+6nIpMn2tm8FgoINMRs
	vpNb6Q4mLN70OU9xQwCaYiTkniXsj8PqcBHF1ygnuWKin/rKDWSlGjeBPZh/SFdLGDJwLNy9XuW
	2+ILSKgTMj/2hdjywQ9j5DeuJX1WQ2e7dYC9Vw==
X-Received: by 2002:a05:6102:94a:b0:7cc:1ace:fd14 with SMTP id ada2fe7eead31-7cc1acf084bmr1323389137.33.1792164618748;
        Fri, 16 Oct 2026 08:30:18 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-990833c2c2dsm1836983241.2.2026.10.16.08.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 08:30:17 -0700 (PDT)
Date: Fri, 16 Oct 2026 11:30:17 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: linux-kernel@vger.kernel.org, 
 Jason Wang <jasowangio@gmail.com>, 
 =?UTF-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, 
 virtualization@lists.linux.dev, 
 Rusty Russell <rusty@rustcorp.com.au>, 
 Max Krasnyansky <maxk@qualcomm.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Simon Horman <horms@kernel.org>, 
 linux-doc@vger.kernel.org
Message-ID: <willemdebruijn.kernel.1d7ce6b64753a@gmail.com>
In-Reply-To: <20261016051827-mutt-send-email-mst@kernel.org>
References: <cover.1792067836.git.mst@redhat.com>
 <ad05a40681719a579691a1da6413f0dd7064f2a0.1792067836.git.mst@redhat.com>
 <willemdebruijn.kernel.3a7d04e1c306e@gmail.com>
 <20261016051827-mutt-send-email-mst@kernel.org>
Subject: Re: [PATCH net-next v2 5/7] net: add a sysctl to opt out of virtio
 net hdr checksum validation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Michael S. Tsirkin wrote:
> On Thu, Oct 15, 2026 at 01:50:54PM -0400, Willem de Bruijn wrote:
> > Michael S. Tsirkin wrote:
> > > The ingress validation as implemented by the previous
> > > patch is stricter than what it replaced: GSO
> > > packets whose checksum metadata matches no transport header are
> > > dropped, and non-GSO ones get their checksum completed in place.
> > > Such packets used to pass with the metadata unvalidated,
> > > and with no overhead.
> > > 
> > > I judge that this should not affect any deployments, but there is still
> > > some risk that it does.  In case a deployment depends on them anyway,
> > > provide a per-netns switch to get the old behavior back:
> > > 
> > > echo 0 > /proc/sys/net/core/virtio_net_hdr_csum_check
> > > 
> > > The default is validating.
> > > 
> > > Assisted-by: LLM
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > ---
> > >  Documentation/admin-guide/sysctl/net.rst | 15 +++++++
> > >  include/linux/virtio_net.h               | 23 ++++++++++
> > >  include/net/netns/core.h                 |  1 +
> > >  net/core/dev.c                           |  6 +++
> > >  net/core/net_namespace.c                 |  1 +
> > >  net/core/sysctl_net_core.c               | 54 ++++++++++++++++++++++++
> > >  6 files changed, 100 insertions(+)
> > > 
> > > diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
> > > index e586e17fc7a5..7f230929c37e 100644
> > > --- a/Documentation/admin-guide/sysctl/net.rst
> > > +++ b/Documentation/admin-guide/sysctl/net.rst
> > > @@ -246,6 +246,21 @@ processes are dropped unless socket option SOF_TIMESTAMPING_OPT_TSONLY is set.
> > >  Default: 1 (on)
> > >  
> > >  
> > > +virtio_net_hdr_csum_check
> > > +-------------------------
> > 
> > Make more generic, virtio_net_hdr_validate?
> > 
> > In case we add more validation in the future (as we have in the past),
> > without having to introduce multiple such knobs.
> 
> But it's uapi, are you sure we'll be able to change the meaning
> of an existing knob, even if we keep the name vague?
> 
> > > +
> > > +When processing packets with a virtio net header (through tun, tap, a
> > > +packet socket or a virtio network device) that request checksum offload
> > > +(VIRTIO_NET_HDR_F_NEEDS_CSUM), validate the packet: complete the checksum
> > > +in software, or drop the packet where the header does not match it.
> > > +
> > > +When disabled, the header is trusted not to corrupt the packet, and the
> > > +checksum is offloaded to hardware (or not verified if it never reaches
> > > +hardware). This is only safe if no protocol is processing the packets.
> > > +
> > > +Default: 1 (on)
> > > +
> > > +
> > >  wmem_default
> > >  ------------
> > >  
> > > diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> > > index 357115ff0ec2..aa2f8ac4657c 100644
> > > --- a/include/linux/virtio_net.h
> > > +++ b/include/linux/virtio_net.h
> > > @@ -5,6 +5,7 @@
> > >  #include <linux/if_vlan.h>
> > >  #include <linux/ip.h>
> > >  #include <linux/ipv6.h>
> > > +#include <linux/jump_label.h>
> > >  #include <linux/netdevice.h>
> > >  #include <linux/udp.h>
> > >  #include <net/gso.h>
> > > @@ -78,6 +79,19 @@ static inline struct iphdr *virtio_net_ip4_parse(struct sk_buff *skb,
> > >  	*thoff = nhoff + iph->ihl * sizeof(u32);
> > >  	return iph;
> > >  }
> > > +/* Defined in net/core/dev.c, enabled while any network namespace
> > > + * has net.core.virtio_net_hdr_csum_check set to 0.
> > > + */
> > 
> > Should this be a global sysctl, rather than per netns?
> 
> 
> For customers I work with, it would be much less useful.

Third option: make it an integer rather than a boolean.

0: no validation
1: current level of validation
2 and beyond: if we have to extend it later

Not pretty, I'll admit. So fine to keep as is too if you prefer.
But I do foresee more changes in this area, if history is a guide.
 
> 
> > Even if per-netns, most likely do not want it writable by netns root
> > with user namespaces.
> >
> > That is the equivalent of ns_capable(CAP_NET_RAW), which is the cause
> > of many crashes due to bad packets ingested by, e.g., a packet socket.
> 
> Hmm, yes i get that. Two knobs? a. verify b. the per netns value ro? Both
> on by default?

A single system wide field is simplest.

Is there a benefit to making this configurable on a per netns basis?

If so, that's fine too. As long as root-in-namespace cannot modify it,
so readonly indeed.

