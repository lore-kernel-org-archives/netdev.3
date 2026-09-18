Received: from mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B1A31328E
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 07:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789717910; cv=none; b=Lk9yU1t6zCHog5dX8B6j/pKCqsLoCCsJzu6L7QdiQhdmEYRRjfOpBVaskupnd8nf9463kZ0DrPyW/h5EL2PoAXLkoPxLIdC3A4SWmYvXZfJOu0/4IOWK7CO6at59o90eodQ8rAzSfnxCDQ5Bhmo+SwWb2CMFB2gzCscgooRjgK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789717910; c=relaxed/simple;
	bh=vRqJ5yg9W8o95f36YRoXXQIb51GKlM15Je1cIirs4uU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+zURMlLKL1PKwko2NdueAlNLEuxqOSb9fIXRo0NmVoWfO9KtC7UyxC3hDsKE3fNfBJS1u8HGMtv8lRxG0jCM9TPD2xKbg0GHFOyeuTUWlruBRSADO0Zzvktat2Wv0Fd3W6DZ/i4XqQkdhGK/sTZlF6tdz4eOSg+4wS/asR/sJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=djow2UH7; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="djow2UH7"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=vRqJ5yg9W8o95f36YRoXXQIb51GKlM15Je1cIirs4uU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789717905; v=1; x=1790322705;
 b=djow2UH7KwgEGy+w70P4X0O6Ho/4+fXIPYd11GSyF7oR3885NKWYcfoM8QuZ1F0Ouz1Qg11g
 atZdB3fZxob5rqlAsk7kRSRzhSPGeTKdY8BNAeSHJ+cIk0FUDCowHl2HUoCVY283UD6mn/EJ7Dx
 3eno7p6KrOtCxr3RD21NsC64=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 963e1ddd0f01cd40;
	Fri, 18 Sep 2026 07:51:45 +0000
X-Mizu-Trace-ID: 963e1ddd0f01cd40
X-Migadu-Flow: FLOW_OUT
Date: Fri, 18 Sep 2026 15:51:40 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: sashiko-reviews@lists.linux.dev
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next 3/6] netlink: specs: rt-route: add lwtunnel
 encap sub-message support
Message-ID: <aqztjJazXlf-VT-d@fedora>
References: <20260917-ynl_rt_encap-v1-0-fbbe6e680571@kylinos.cn>
 <20260917-ynl_rt_encap-v1-3-fbbe6e680571@kylinos.cn>
 <20260918063656.953941F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260918063656.953941F00898@smtp.kernel.org>

On Fri, Sep 18, 2026 at 06:36:56AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] netlink: missing byte-order: big-endian in rt-route specs

Thanks, I will fix all these byte order issue.

> --
> 
> commit 18041b529d7678ae7bbdd8ee61a7fb4213ae6804
> Author: Hangbin Liu <liuhangbin@kylinos.cn>
> 
> netlink: specs: rt-route: add lwtunnel encap sub-message support
> 
> This commit adds lwtunnel encapsulation sub-message support to the rt-route
> netlink specs, defining various tunnel attribute sets such as mpls, ip, ip6,
> seg6, bpf, etc. It updates the yaml spec for rt-route and adds necessary
> headers to the Makefile dependencies.
> 
> > diff --git a/Documentation/netlink/specs/rt-route.yaml b/Documentation/netlink/specs/rt-route.yaml
> > index 253037ea5176a..0e236da140dc5 100644
> > --- a/Documentation/netlink/specs/rt-route.yaml
> > +++ b/Documentation/netlink/specs/rt-route.yaml
> [ ... ]
> > @@ -277,6 +332,229 @@ attribute-sets:
> >        -
> >          name: fastopen-no-cookie
> >          type: u32
> [ ... ]
> > +  -
> > +    name: lwtunnel-ip
> > +    name-prefix: lwtunnel-ip-
> > +    header: linux/lwtunnel.h
> > +    attributes:
> > +      -
> > +        name: id
> > +        type: u64
> 
> [Severity: High]
> Does this field need a byte-order: big-endian annotation? The kernel
> reads LWTUNNEL_IP_ID as be64 using nla_get_be64(). Without the annotation,
> YNL tools will byte-swap this on little-endian architectures, potentially
> causing silent data corruption.
> 
> > +      -
> > +        name: dst
> > +        type: u32
> > +        byte-order: big-endian
> > +        display-hint: ipv4
> > +      -
> > +        name: src
> > +        type: u32
> > +        byte-order: big-endian
> > +        display-hint: ipv4
> > +      -
> > +        name: ttl
> > +        type: u8
> > +      -
> > +        name: tos
> > +        type: u8
> > +      -
> > +        name: flags
> > +        type: u16
> 
> [Severity: High]
> Does this field also need a byte-order: big-endian annotation? The kernel
> reads LWTUNNEL_IP_FLAGS as be16 using nla_get_be16().
> 
> [ ... ]
> > +  -
> > +    name: lwtunnel-ip6
> > +    name-prefix: lwtunnel-ip6-
> > +    header: linux/lwtunnel.h
> > +    attributes:
> > +      -
> > +        name: id
> > +        type: u64
> 
> [Severity: High]
> Could this also be missing a byte-order: big-endian annotation? The kernel
> reads LWTUNNEL_IP6_ID as be64.
> 
> [ ... ]
> > +      -
> > +        name: hoplimit
> > +        type: u8
> > +      -
> > +        name: tc
> > +        type: u8
> > +      -
> > +        name: flags
> > +        type: u16
> 
> [Severity: High]
> Could this also be missing a byte-order: big-endian annotation? The kernel
> reads LWTUNNEL_IP6_FLAGS as be16.
> 
> [ ... ]
> > +  -
> > +    name: seg6-local
> > +    name-prefix: seg6-local-
> > +    header: linux/seg6_local.h
> > +    attributes:
> [ ... ]
> > +      -
> > +        name: table
> > +        type: u32
> > +      -
> > +        name: nh4
> > +        type: u32
> > +        display-hint: ipv4
> 
> [Severity: High]
> Does this field need a byte-order: big-endian annotation? SEG6_LOCAL_NH4 is
> a raw IPv4 address and handled as a struct in_addr in the kernel, but here
> it is typed as a native u32. This might cause YNL tools to silently
> byte-swap the address on little-endian architectures.
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260917-ynl_rt_encap-v1-0-fbbe6e680571@kylinos.cn?part=3
