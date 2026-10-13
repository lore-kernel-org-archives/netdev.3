Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48F552D2D6
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 18:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791917507; cv=none; b=A8kympxKtUyxZvYnf3SCwmu4Hqvaf+FN1MaLIpmy0bZ1W0h7bMXCnNLnTu3+Wh0lHZiL0+MaVwWTQ/ithCZ27rfP1R5nAjnTvGkBGEMA+GpN6YUTHZW/G+MwH41TZEoBGIiSQJPyjvBXKKCGWHJym2SfSsWB8DILQvm41YiOeO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791917507; c=relaxed/simple;
	bh=vQQgX5XfftHA7/vosJgmBjICMWrkz0gmawEsGmWcNVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ULeQsxOsDZhfAmKCMbtomFYABlI94Nk08YOcChqEcBoQjxOdH1bCLLa6a054cAbPwLTJeBnJwuz0IFF4rfJd+m/P86Yl115eeNYPoUuFl60jxN602XxAEAR7sZvN21j73trhrSxGEhX3nG5XXvScHKo5ioA9Q3uMafo61jEBVPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=DH/txF7V; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="DH/txF7V"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-48ed0b68895so1970339fac.1
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 11:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1791917503; x=1792522303; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NY6xAXXWFY1zXXulN0UI4uvJ0IhzTvnKlTHvFNUGXLU=;
        b=DH/txF7VSSKRokWYAaaNlKbUbJ+/VOcvq3ui8Zgq2I+l9Z1NdYv1WIlK1RamCd3CNi
         ji02JoFfrzg+lVeabBiZ8HtlxWnsU75kMq4/Bho1gqzduT/O4AE1R54/wJe260COm4/l
         9LZGmxomlQezqsVJEKUc6BnJnNaWv7WDQr0UyZatoQVjRH8XY4LUqXEwTQpAo/jdwJfU
         K+5esvyAx+vKnicekASkz+j3Elv2Zjr5SwrnBhpfsjjW6NPc9YkH3L2roPeo858eLnIO
         Cu+gg5LLDxrJsTzcYKKEdi+szcT1MddlzRxh1IbGF1eL7aHOnXbSWPc1/5tYetTMSVEl
         jOqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791917503; x=1792522303;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NY6xAXXWFY1zXXulN0UI4uvJ0IhzTvnKlTHvFNUGXLU=;
        b=SRPLWW4GfUpdY9sULmuDrH0X7UvQz12xM+hnof4hhmuD6bAYtTpagNIZLSxqowX5yG
         OEad7jxeWG3VHSWx1eXoFFFhRYjDcDbBfwtiEVtQI2ZmSOYX1Qd6dHdtfY4ehu4+vocs
         Le3QncZtKZnYriUtUe6jJUrAZRhAJ/OIe2nTpVUaFdTT0cC5zC3mmOZoI247pMvUp5Rl
         k4Nygjf2ao2eJtZ67iam0po/zis0JWWyDw1Pw+KnlrkVA/bliXrxjvr3DhbBfvBy/sYH
         OI0N0nEYBAiJgHCtczHvqljKjtG0aClqOQC7gMDW3IvxOiuL5lLtL2N/QY3IofMQPput
         zP3g==
X-Forwarded-Encrypted: i=1; AKwUvBzFxcgYqHnzOKnavL6Iv/10vCI2icXyiWDmxip5JOL+WhWGO7hlKKqhgS7Ui+P6idh00bQI6ts=@vger.kernel.org
X-Gm-Message-State: AFq9FYLjvUn65F/fdrtsLFI6iaG7qeHm8QPYhWQQq2z55TGwm/nfM4W6
	Hd2dgHE+vvXTmwhnF/7Dwf15NJnWe+G0qDlJGDf5TN5J7JhkM8A5lKCv5YvhjX19gu0=
X-Gm-Gg: AYBFou0/2gFWD1afcRfN+MmKzWLSdAf01r1ZfK2E1uskFiYrH5FVTXD4MejOHNnLPyj
	xhCZLVyB91+gAzx9L1ZI/4hcFgsRCamb5Pwhb7Wib0EWDvh4vGueBtoKrr/8GvhoSEy1f1yXKzW
	AkPrF4HlY/PfukpaYlMzMLsOg0CtEpInVYDr/ZmH27RRylymT152tnh3wPwfKNhG7lrCJF1+KFx
	5hP1ztkovqKR6+5lRg9spEZASkAyY+eBIC+KBEXDtAupFgpB3RghghwJGc/32RMBQ2q9iRIoiPW
	5bw/dpwUHgFUf/qrY2xV9S6X4CbAhC0gdy5kYpBg6IKxN5BRGSXBxOO6PvCYQLLNY2bYu09dN5L
	DY4YPM1z2LPqf3ewI4tiQR/2HtWcjfbkh6Pj3/lPB3N85c88YlsTIlXEGHoZgB2bixt4at8Qk/W
	tmEU1BdNTrxZEkqu7/kZZ3p1XWjZYnRv1eAb0ApyNC5chNvm87pKD3r0S11ldMF82ejA==
X-Received: by 2002:a05:6870:21e5:b0:485:d1ab:793d with SMTP id 586e51a60fabf-4a2a889fee3mr11368650fac.30.1791917502711;
        Tue, 13 Oct 2026 11:51:42 -0700 (PDT)
Received: from 20HS2G4 ([2a09:bac6:bf21:15d7::22d:151])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a6dfbd6a92sm409039fac.9.2026.10.13.11.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 11:51:41 -0700 (PDT)
Date: Tue, 13 Oct 2026 13:51:39 -0500
From: Chris Arges <carges@cloudflare.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Max Krasnyansky <maxk@qualcomm.com>,
	Paulos Yibelo <habte.yibelo@gmail.com>
Subject: Re: [PATCH net-next 0/4] more virtio-net csum hardening
Message-ID: <as59u_oxCGn4397B@20HS2G4>
References: <cover.1791887415.git.mst@redhat.com>
 <20261013070259-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013070259-mutt-send-email-mst@kernel.org>

On 2026-10-13 07:05:34, Michael S. Tsirkin wrote:
> On Tue, Oct 13, 2026 at 06:58:28AM -0400, Michael S. Tsirkin wrote:
> > Allowing untrusted hardware to specify csum start/offset for
> > CHECKSUM_PARTIAL was not a good idea, because, if it edits the packet
> > outside the actual checksum, and depending on the setup, the networking
> > stack could be looking at the packet both before and after the edit, and
> > seeing different results.
> > 
> > Previously, commit 6785011f8b16 ("ipv4: validate checksum_start before
> > completing checksum") validated all known instances where this
> > causes the most grief, but the real fix is to make sure
> > that either only actual checksum fields are ever edited,
> > or the checksum is completed before the net stack looks at it,
> > so it is always consistent.
> > 
> > This basically does this: checksum at ingress, except in a narrow list
> > of specified known good cases.
> > 
> > Fixes: f43798c27684 ("tun: Allow GSO using virtio_net_hdr")
> 
> 
> I forgot.
> 
> Reported-by: Paulos Yibelo <habte.yibelo@gmail.com>
> Reported-by: Chris Arges <carges@cloudflare.com>
> 
>
I did some testing of this patch-set and it mitigates my cases in VM
testing.

Tested-by: Chris Arges <carges@cloudflare.com>

> > Michael S. Tsirkin (4):
> >   net: add ip4_parse()
> >   net: use ip4_parse() in receive validation
> >   net: resolve uncommon partial checksums at ingress
> >   net: account for ingress-resolved virtio net hdr state
> > 
> >  drivers/net/tap.c                   |   4 +-
> >  drivers/net/tun.c                   |  44 +++++++-
> >  drivers/net/virtio_net.c            |   2 +-
> >  include/linux/ip.h                  |  24 +++++
> >  include/linux/virtio_net.h          | 161 ++++++++++++++++++++++++----
> >  net/bridge/br_netfilter_hooks.c     |  15 +--
> >  net/ipv4/ip_input.c                 |  13 +--
> >  net/ipv4/netfilter/nf_reject_ipv4.c |  13 +--
> >  net/packet/af_packet.c              |   4 +-
> >  9 files changed, 228 insertions(+), 52 deletions(-)
> > 
> > -- 
> > MST
> > 
> 
