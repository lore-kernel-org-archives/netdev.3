Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF2B59B68A
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 17:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792173348; cv=none; b=HQm+VNABNU97+XZNp+NoLQpBr/6iwuFShf0OX2OpKTxZ/b4/D+mo9z1Qtw+Z1smADrNwt4CQZoG5+YPZAbdbzE+ZGE+U5C5H5RUoZBJkN+qQC0+CWVyYRCjJK4GQh88UaH6U2LkfLyifBxnJeziGc3oJDWt2+H5IBK+zB/KUXk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792173348; c=relaxed/simple;
	bh=5DybD1Tbpk1GikeDoJ8i2R2iG8V80RyWmQDskHZlcnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ojHTB1+hAjLG2isBnpqbvB6X3wMgp9amEwi2EqVDxPI8H9MqlZ3J1OZEtx4SZTaMxGOU1D9hOjcoVo8Mu2SnTGjDhUaVU4pQ3SHxKEwsputbrE7yxbsOV17XWHAjWdgRi+/6LyY4GGfYblPb5ANxw9DIm3XDAayLZQOpywvQDa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MWI9mIVh; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=o44WU3w7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MWI9mIVh";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="o44WU3w7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792173345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lHt5KpPRaIkz6Iofzx7O/ncMQH6iA1GowXt5Lm3sQMQ=;
	b=MWI9mIVhq7GNF6/BB0g+dCmt6YoJ9eKHUfX8MdQaRS6NBeNsU06VHakBdl5azrBBZWmxoO
	WKaKiktjqjr3x+mddgFWYFnVJETuTdv0JC0I80NpJvJ4tVbm//3lHQBPPS5b4pWTH/qaqN
	cQAQDA7FyRnY2yTsIe0T3Q3dQAoMAF8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-g65uO1bXNmOAEyFDwYZ2mA-1; Fri, 16 Oct 2026 17:55:43 +0000
X-MC-Unique: g65uO1bXNmOAEyFDwYZ2mA-1
X-Mimecast-MFC-AGG-ID: g65uO1bXNmOAEyFDwYZ2mA_1792173343
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a1612c4b80so1894575e9.0
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 10:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792173343; x=1792778143; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lHt5KpPRaIkz6Iofzx7O/ncMQH6iA1GowXt5Lm3sQMQ=;
        b=o44WU3w7Fp72QS85NkjqWfoLHJEY61ub2KUz4Fb1NrBM4tYv0vttKEQgNKn+4NEJU6
         CNmOoyoQPMNV/ZxgjT6ES00q//uOWyYSrL1zs0ktkDiR5VvuzcI1iDfmeXzSGyfdUXj0
         Vuup2XsFA3h4vS+yh1ID1LaVK4UVTUSbvV18rY3zRo1OrCSscEK7a1L8l4dF+L3qQRTc
         mXO8Xpge9GleH8Xkv+tMi8fVxp6kQivWhsEawhgKmZjzXrJyrYzXnLZsM9HXoOAaWR2k
         xsZAEF3TmM2qcc3mPOAORd9y0z3zKLkGhyiKYEBhSaVybZbGMLrZsiCYDOKafaDPFewv
         q6/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792173343; x=1792778143;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lHt5KpPRaIkz6Iofzx7O/ncMQH6iA1GowXt5Lm3sQMQ=;
        b=iJWm2SSzfneP6kkZqqZtTiRS8sEEf94XCX0hWZbw6nYob8VfS0Z2qGvIfAb3tYAMOu
         s7PuNqE24sWrW7hNZvXdJCYuud1XLqk/3ovr+FnIzpRpW6flJsVeaeRJfg7CVzuyKn1L
         XooMEhcvnf3Mxa4T9hjgtDjXxDCfWzpCxy2ySvhC3Yi6yVXMfvA9G1EcTopr4SjnLxQI
         fz/PxjHbQyz49Z5qSzqhqQItbzmx1TMGLNW5k5vIR66Mlg03zQEvSBsMHevDuULE+Vy1
         peq+gpKP99KrWcleSYdSEONoVRQwDxvwfoP/ZOai/r7/Qfy5VSe8F/sQddCR8g3cTLqh
         h2ug==
X-Forwarded-Encrypted: i=1; AKwUvByfhYt+qeskYTxYYh+EwsYQhAv4Rvz1m0RMGtwRIRqGOSxl2WC1ki8japAlUZ6rZBR+GigWcmc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLollLBwJjPjvYp2QN8lsUVGBIQP+l/vkGM3EA+MZhAwUp/1c4S
	/9fcewstu5KHUUaSwSvmkJRC+zWdAYqTU+kVP8eT8yuaGAu1m+CHCN8eKMzKSsSBfDQqlxZ8doX
	wg6Q1F6l+wITE8KeL0gYe/oRQNZnZSdijFuSVf4gPFBUgZ2NfhSoO/GhfHA==
X-Gm-Gg: AYBFou3cgxDIrynZUAhGVFq40hXi+WsX7a00zEq0AtBgMC1yHq5vKBZjaNVDCpMyq1y
	pz0FDP9NH1vSZHuLr/6XAB9GQ6I5N8laginJOTtia+c5nVMsA/VXCxN4onqYML/ykBvEUHQGmxS
	cGwgcU8/HQLj5epPfFRxgnipdUmY8d7beADPq+7u6vibw1YEQoA2UUxdBZ+Yp2cUHKdRu8DKS3a
	T4bJ8rjCaoZrBRpRQripyg7fqY5cbofbVt8Zu+u+31ddRnkTz+BCP+vHPKOjg4o2+Gh7mxirdRx
	xpa9pVsJtrCxDNGXjSXOE8M33vF2viNJw43HjduF2CFxZMJKww/FAq8eAgxZPxgweySoaeI=
X-Received: by 2002:a05:600c:19cd:b0:4a1:96cd:2f67 with SMTP id 5b1f17b1804b1-4a1d75ce2damr12964255e9.4.1792173342592;
        Fri, 16 Oct 2026 10:55:42 -0700 (PDT)
X-Received: by 2002:a05:600c:19cd:b0:4a1:96cd:2f67 with SMTP id 5b1f17b1804b1-4a1d75ce2damr12963785e9.4.1792173342046;
        Fri, 16 Oct 2026 10:55:42 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73fb:d100:601d:d7d4:d03f:527b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4ecac3sm7072454f8f.27.2026.10.16.10.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 10:55:41 -0700 (PDT)
Date: Fri, 16 Oct 2026 13:55:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: linux-kernel@vger.kernel.org, Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Rusty Russell <rusty@rustcorp.com.au>,
	Max Krasnyansky <maxk@qualcomm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Simon Horman <horms@kernel.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/7] net: add a sysctl to opt out of virtio
 net hdr checksum validation
Message-ID: <20261016135328-mutt-send-email-mst@kernel.org>
References: <cover.1792067836.git.mst@redhat.com>
 <ad05a40681719a579691a1da6413f0dd7064f2a0.1792067836.git.mst@redhat.com>
 <willemdebruijn.kernel.3a7d04e1c306e@gmail.com>
 <20261016051827-mutt-send-email-mst@kernel.org>
 <willemdebruijn.kernel.1d7ce6b64753a@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <willemdebruijn.kernel.1d7ce6b64753a@gmail.com>

On Fri, Oct 16, 2026 at 11:30:17AM -0400, Willem de Bruijn wrote:
> Michael S. Tsirkin wrote:
> > On Thu, Oct 15, 2026 at 01:50:54PM -0400, Willem de Bruijn wrote:
> > > Michael S. Tsirkin wrote:
> > > > The ingress validation as implemented by the previous
> > > > patch is stricter than what it replaced: GSO
> > > > packets whose checksum metadata matches no transport header are
> > > > dropped, and non-GSO ones get their checksum completed in place.
> > > > Such packets used to pass with the metadata unvalidated,
> > > > and with no overhead.
> > > > 
> > > > I judge that this should not affect any deployments, but there is still
> > > > some risk that it does.  In case a deployment depends on them anyway,
> > > > provide a per-netns switch to get the old behavior back:
> > > > 
> > > > echo 0 > /proc/sys/net/core/virtio_net_hdr_csum_check
> > > > 
> > > > The default is validating.
> > > > 
> > > > Assisted-by: LLM
> > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > > ---
> > > >  Documentation/admin-guide/sysctl/net.rst | 15 +++++++
> > > >  include/linux/virtio_net.h               | 23 ++++++++++
> > > >  include/net/netns/core.h                 |  1 +
> > > >  net/core/dev.c                           |  6 +++
> > > >  net/core/net_namespace.c                 |  1 +
> > > >  net/core/sysctl_net_core.c               | 54 ++++++++++++++++++++++++
> > > >  6 files changed, 100 insertions(+)
> > > > 
> > > > diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
> > > > index e586e17fc7a5..7f230929c37e 100644
> > > > --- a/Documentation/admin-guide/sysctl/net.rst
> > > > +++ b/Documentation/admin-guide/sysctl/net.rst
> > > > @@ -246,6 +246,21 @@ processes are dropped unless socket option SOF_TIMESTAMPING_OPT_TSONLY is set.
> > > >  Default: 1 (on)
> > > >  
> > > >  
> > > > +virtio_net_hdr_csum_check
> > > > +-------------------------
> > > 
> > > Make more generic, virtio_net_hdr_validate?
> > > 
> > > In case we add more validation in the future (as we have in the past),
> > > without having to introduce multiple such knobs.
> > 
> > But it's uapi, are you sure we'll be able to change the meaning
> > of an existing knob, even if we keep the name vague?
> > 
> > > > +
> > > > +When processing packets with a virtio net header (through tun, tap, a
> > > > +packet socket or a virtio network device) that request checksum offload
> > > > +(VIRTIO_NET_HDR_F_NEEDS_CSUM), validate the packet: complete the checksum
> > > > +in software, or drop the packet where the header does not match it.
> > > > +
> > > > +When disabled, the header is trusted not to corrupt the packet, and the
> > > > +checksum is offloaded to hardware (or not verified if it never reaches
> > > > +hardware). This is only safe if no protocol is processing the packets.
> > > > +
> > > > +Default: 1 (on)
> > > > +
> > > > +
> > > >  wmem_default
> > > >  ------------
> > > >  
> > > > diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> > > > index 357115ff0ec2..aa2f8ac4657c 100644
> > > > --- a/include/linux/virtio_net.h
> > > > +++ b/include/linux/virtio_net.h
> > > > @@ -5,6 +5,7 @@
> > > >  #include <linux/if_vlan.h>
> > > >  #include <linux/ip.h>
> > > >  #include <linux/ipv6.h>
> > > > +#include <linux/jump_label.h>
> > > >  #include <linux/netdevice.h>
> > > >  #include <linux/udp.h>
> > > >  #include <net/gso.h>
> > > > @@ -78,6 +79,19 @@ static inline struct iphdr *virtio_net_ip4_parse(struct sk_buff *skb,
> > > >  	*thoff = nhoff + iph->ihl * sizeof(u32);
> > > >  	return iph;
> > > >  }
> > > > +/* Defined in net/core/dev.c, enabled while any network namespace
> > > > + * has net.core.virtio_net_hdr_csum_check set to 0.
> > > > + */
> > > 
> > > Should this be a global sysctl, rather than per netns?
> > 
> > 
> > For customers I work with, it would be much less useful.
> 
> Third option: make it an integer rather than a boolean.
> 
> 0: no validation
> 1: current level of validation
> 2 and beyond: if we have to extend it later


Oh that's an interesting idea. Issue: userspace learns about 1, then
someone sets it to 1 thinking this is the highest level and in fact
disables some security.


> Not pretty, I'll admit. So fine to keep as is too if you prefer.
> But I do foresee more changes in this area, if history is a guide.
>  
> > 
> > > Even if per-netns, most likely do not want it writable by netns root
> > > with user namespaces.
> > >
> > > That is the equivalent of ns_capable(CAP_NET_RAW), which is the cause
> > > of many crashes due to bad packets ingested by, e.g., a packet socket.
> > 
> > Hmm, yes i get that. Two knobs? a. verify b. the per netns value ro? Both
> > on by default?
> 
> A single system wide field is simplest.
> 
> Is there a benefit to making this configurable on a per netns basis?
> 
> If so, that's fine too. As long as root-in-namespace cannot modify it,
> so readonly indeed.

