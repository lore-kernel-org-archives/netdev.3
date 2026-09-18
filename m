Received: from mta0.migadu.com (out-62.mta0.migadu.com [91.218.175.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E697F4A99D2
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 08:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789718564; cv=none; b=ebrkQgiJD+GXRukjMjhPPVOUmNX+0BnrIFr+2Ncqn5bQT6ABX3AF2ICXCgNmVaFiXVQwgfV/uMNF6/alRJq/EAXQk2m4rnShmXsLpQW+dWeCdraG3npxGFj2vvu+wgl5LLEwMbzawjGkLmEt6Ow9PGaHCDFNDLJ3Y3OpIm/vYgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789718564; c=relaxed/simple;
	bh=BD6KeVFjToaPnvzwjk6Z9XMyjhaKLhRQqywzy1BkJSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bzp1MAzEYpCQ63hEfoUZdZNa5Qxwd3pPE89Hh2oxu/OBm5fa2LCqzQ6F1ifNoZRKVDlgACY05NRR5JOXq9nokyhR9uPVT+B4cnDgMJqYJqHAFyFFUXw/Dm55xVgA7ZMBInTKvmNEzI+CTnryXrn+dpBBvP0XXmgx6aOFZX74Hm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wXRjZ3Da; arc=none smtp.client-ip=91.218.175.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wXRjZ3Da"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=BD6KeVFjToaPnvzwjk6Z9XMyjhaKLhRQqywzy1BkJSE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789718559; v=1; x=1790323359;
 b=wXRjZ3DacgssrSt2kzWsNHdwh3hjdXgafT/0sE21TNBJxVXdg2NZKEbsUNquqYuBjO2pxXX0
 6KfkDLqTAZEEiYPkzjV40zziamwR1FbqECKZbkFzZTmXU6wJNhbplGk+cXEEbGmBzP3870PxIwQ
 EhZwvAfpJzTh4rFWnqtw6KbY=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 77279d4c5977da50;
	Fri, 18 Sep 2026 08:02:39 +0000
X-Mizu-Trace-ID: 77279d4c5977da50
X-Migadu-Flow: FLOW_OUT
Date: Fri, 18 Sep 2026 16:02:25 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: sashiko-reviews@lists.linux.dev
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next 4/6] netlink: specs: rt-route: describe lwtunnel
 IP options
Message-ID: <aqzwEXWYBQqSfNUu@fedora>
References: <20260917-ynl_rt_encap-v1-0-fbbe6e680571@kylinos.cn>
 <20260917-ynl_rt_encap-v1-4-fbbe6e680571@kylinos.cn>
 <20260918063658.80E4F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260918063658.80E4F1F000FF@smtp.kernel.org>

On Fri, Sep 18, 2026 at 06:36:58AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] netlink: specs: missing byte-order property for lwtunnel-ip-opt-erspan index
> - [Low] netlink: specs: missing max-len validation for lwtunnel-ip-opt-geneve data

Thanks, I will fix these.

> --
> 
> commit 15d568f88486d1cb50af0dbb912eabab2c37d852
> Author: Hangbin Liu <liuhangbin@kylinos.cn>
> 
> netlink: specs: rt-route: describe lwtunnel IP options
> 
> This commit replaces binary options in lwtunnel-ip and lwtunnel-ip6 with
> a nested lwtunnel-ip-opts set. It also adds attribute sets for geneve, vxlan,
> and erspan IP options to align with the kernel's definitions in lwtunnel.h.
> 
> > diff --git a/Documentation/netlink/specs/rt-route.yaml b/Documentation/netlink/specs/rt-route.yaml
> > index 0e236da140dc5..6030d7cb8d0d1 100644
> > --- a/Documentation/netlink/specs/rt-route.yaml
> > +++ b/Documentation/netlink/specs/rt-route.yaml
> [ ... ]
> > @@ -555,6 +557,59 @@ attribute-sets:
> >        -
> >          name: link
> >          type: u32
> > +  -
> > +    name: lwtunnel-ip-opts
> > +    name-prefix: lwtunnel-ip-opts-
> > +    attributes:
> > +      -
> > +        name: geneve
> > +        type: nest
> > +        nested-attributes: lwtunnel-ip-opt-geneve
> > +      -
> > +        name: vxlan
> > +        type: nest
> > +        nested-attributes: lwtunnel-ip-opt-vxlan
> > +      -
> > +        name: erspan
> > +        type: nest
> > +        nested-attributes: lwtunnel-ip-opt-erspan
> > +  -
> > +    name: lwtunnel-ip-opt-geneve
> > +    name-prefix: lwtunnel-ip-opt-geneve-
> > +    attributes:
> > +      -
> > +        name: class
> > +        type: u16
> > +        byte-order: big-endian
> > +      -
> > +        name: type
> > +        type: u8
> > +      -
> > +        name: data
> > +        type: binary
> 
> [Severity: Low]
> Does this binary attribute need a max-len validation check?
> 
> The kernel explicitly enforces a maximum length of 127 bytes for this
> attribute in its Netlink policy:
> 
> net/ipv4/ip_tunnel_core.c:geneve_opt_policy[] {
>     [LWTUNNEL_IP_OPT_GENEVE_DATA] = { .type = NLA_BINARY, .len = 127 },
> }
> 
> Without a corresponding max-len constraint in the spec, auto-generated
> tools will not catch oversized attributes locally before transmitting
> them to the kernel.
> 
> > +  -
> > +    name: lwtunnel-ip-opt-vxlan
> > +    name-prefix: lwtunnel-ip-opt-vxlan-
> > +    attributes:
> > +      -
> > +        name: gbp
> > +        type: u32
> > +  -
> > +    name: lwtunnel-ip-opt-erspan
> > +    name-prefix: lwtunnel-ip-opt-erspan-
> > +    attributes:
> > +      -
> > +        name: ver
> > +        type: u8
> > +      -
> > +        name: index
> > +        type: u32
> 
> [Severity: Medium]
> Will this result in an incorrect ERSPAN index on little-endian architectures?
> 
> The kernel parses this attribute using nla_get_be32():
> 
> net/ipv4/ip_tunnel_core.c:ip_tun_parse_opts_erspan() {
>     ...
>     attr = tb[LWTUNNEL_IP_OPT_ERSPAN_INDEX];
>     md->u.index = nla_get_be32(attr);
>     ...
> }
> 
> Since the spec defines index as a u32 without the byte-order: big-endian
> property, auto-generated tools will send the value in host byte order.
> When run on a little-endian system, the kernel would then read a
> byte-swapped, incorrect value, which would break the tunnel configuration.
> 
> > +      -
> > +        name: dir
> > +        type: u8
> > +      -
> > +        name: hwid
> > +        type: u8
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260917-ynl_rt_encap-v1-0-fbbe6e680571@kylinos.cn?part=4
