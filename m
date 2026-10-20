Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792527738;
	b=xGB0EmKwt3fB83vIqa32kkdcYBr5cJmjMq2aWD93Vsw94Nfzi65tGNwbrzelzYd4HGma
	 h03anZlJie9hsowMJIKl+3hilIrzKs+mZlmR5WZQo81vDKtdhX8JvzGtJYGtlHpoPttpI
	 aUwb6H6B424TNSQUIQA08wynaBAYMJmaORq5NeJkXkwQskVOz7xeLJt0QfnDzxoS4Oy++
	 ELRvgba6H4hVvs9c1mEqnPJYlzkojJq9gIIVcBq04JR3c48uckA+IXplNvBLcgqQZ4LMN
	 7SASGq11uiJ6ilSxeHjjUcs1FLYV0u4Qnp9+Vb5pmHjWoncoD8LjuCGfseFKOsh4CCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792527738;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=O3Fa0tNjFaT8a2Kp5IrJp2nupauYC9YO/ztvfGUmcCA=;
	b=Vdojq4uUwp8CEHxkK/LbydZ5n6O04vh2jSKODFDr9z+EQwGq4qA2I3pD2GkKUDlXwYX1
	 qwUN1H65wVCUsUzZTgPBzw5FlqXUcr0zyzTyphtLGCHJvZuFseMnpYA0v5d6Bk7dAXSgw
	 YRfIIh1eJkh3a6WNd/ul3QJwatlOvmzM9lxyC/rIiJjvsd17Jg0fthVNeeruKtNkFNYh6
	 5YRKKRxUD15IsIzxq37rm/c8s0X1UvGZZ5+BAPP/FD3D7fai4nKEREHEXFr4/Q0v3bu9R
	 0brSU+YDZvHLhQAgQrQcCOfqx7XluUIp2GzfxxcBCm8faapInQPDUWwIkL35XBmWu+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ugs1THk+;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=jANqynKY;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BE0606A319
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 20:22:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0BE0606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ugs1THk+;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=jANqynKY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792527736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O3Fa0tNjFaT8a2Kp5IrJp2nupauYC9YO/ztvfGUmcCA=;
	b=Ugs1THk+aFEhkNXwghiFoXYZOvvqK2Y/kuQXCmSIuxFc8fjjpzMTjB6MCV5Rvp95wiA+qi
	pObMy2Md2O1jzDnIBsu0JRBRy3tB2SGEFD/9bQYYyus5a0nhhY0xTLVsc2VWeIoEKW5SKX
	oR4I0h9OJ45uNNOm8jNtF97IFgsCKFg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-5QYHIQ_QPlOL58SMJr0mJA-1; Tue, 20 Oct 2026 20:22:15 +0000
X-MC-Unique: 5QYHIQ_QPlOL58SMJr0mJA-1
X-Mimecast-MFC-AGG-ID: 5QYHIQ_QPlOL58SMJr0mJA_1792527734
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a1f03f2e8aso151665e9.1
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 13:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792527734; x=1793132534; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=O3Fa0tNjFaT8a2Kp5IrJp2nupauYC9YO/ztvfGUmcCA=;
        b=jANqynKYI4bjvIyZ+6Op+etbknpKHYweOauGCKUxq9YND33QXH+mzMbX1QYs6jhDfA
         gz79jZ8gVhxGjr+9e0EVQ+riY8AXr/FwfQZ8LRL01FR1rcx92aNPf06Xohr/8Uav30cr
         6Lk8Cy3SQwKfSepCDy3jDJjwPXIVJPtzsGH2BP94SvC5PovVOJPuYiSoaCGZLUSsFjWS
         UQPYx+XYNoaOC507pLbUV7Rd0VEkWwAnY6UqVt34ucKwMaIq6Rmu0JF7CzMsjbre7Rq9
         9S5GATcqdHXGsVQojRVtMqXbR3IC3xB1A2OMBDAbotUBg97A5weBiHgRrMbiVr9AZA6b
         PYqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792527734; x=1793132534;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O3Fa0tNjFaT8a2Kp5IrJp2nupauYC9YO/ztvfGUmcCA=;
        b=G77P77MycgGd1990peLQXIV5oV89wdEkWKtAaYnJVbtPuJbDq+4zl9244k84bEKQxK
         gvKczNFp3Jwe7c5G/nVxoP9Wsji+BpakwFcjvTMo/wQ0CdCLZxS9iuxoQAlxclrq9Aio
         Xd5JD9d+0wbf48FtD+d9BHRB7hcha9sjsPZaxsM6YFy9HPyIk85ejupENOi5zyjkn39e
         p4gyOkriCbnYXFDvQLs32YWHWTdWUQOOBCeM+LtdBH6YhSJ0iTxeZtq2oQKJpaoWWudW
         V4ec5XKjH+433CGeU0VjywhJXO41cFbC8rOhsamPaJhDUpiJF6aG7K353wKUexl0rvhY
         c5Yw==
X-Forwarded-Encrypted: i=1; AKwUvBx2jpXq1weWXJgtq4iF756vtmgHObm5rIEB9IyLLtJB0Dz8hPunVqsP/a78ZM4ncskrALjSpqo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJrpxTHvlBdkW64nnsrsiA79LpeOVwFxifeINwcD8AdrAYGCgco
	jtkdyOwXf+fKF5NEIu0HujKzNnvAbHuE4+xkco44PLzQJ5NWClKCl3yaJITW2TlswGeKfWWmH7T
	InKOGtK7pXz5/0mJKnZbaKFo+XyBalCAuTjm3Cd0+7kir+Lz2dpTVWk+jKg==
X-Gm-Gg: AYBFou12xF06gG4c9rwmtUcGTY5X/zDJbeUFghTj0Wd2OAJKhNg1BJorrk8LtFki67g
	bkNgo4dn1J9l1aSEpZjx/68kNlpBN5EdS9el73h6C3wHsSngyB7478sPdBbbnlrdlJYIbeDANc1
	AZgXv9VHDwjXgBD7oLtqBJ15EhWB7/2hKTwnGAgndnz8ZRb6lQwSEk3qWLF/CMlHJmGeW7ouWLr
	55nVL5qLTnuDr2azxj9sGuBVTje0LWyS0HcF81dExF44t+dzZmWN0TgBYWnz27U/RWb48OTanh/
	LXiLL3Cigl661zhJdW2dgbPBUMEfxiMwlcgeMaWKkzWetWpwO1UQeogsEGVcxY7JEmGuuA==
X-Received: by 2002:a05:600c:888c:b0:4a1:eccb:53eb with SMTP id 5b1f17b1804b1-4a1eccb55d9mr100028525e9.6.1792527734280;
        Tue, 20 Oct 2026 13:22:14 -0700 (PDT)
X-Received: by 2002:a05:600c:888c:b0:4a1:eccb:53eb with SMTP id 5b1f17b1804b1-4a1eccb55d9mr100027865e9.6.1792527733682;
        Tue, 20 Oct 2026 13:22:13 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e2581eedesm625191f8f.14.2026.10.20.13.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 13:22:12 -0700 (PDT)
Date: Tue, 20 Oct 2026 16:22:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: linux-kernel@vger.kernel.org, Chris Arges <carges@cloudflare.com>,
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
	Rusty Russell <rusty@rustcorp.com.au>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Simon Horman <horms@kernel.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH net v3 6/8] net: add a sysctl to opt out of virtio net
 hdr checksum validation
Message-ID: <20261020162048-mutt-send-email-mst@kernel.org>
References: <cover.1792411304.git.mst@redhat.com>
 <6f23c55c6eba3e3ec6b2c7e3a80728a326ed58af.1792411304.git.mst@redhat.com>
 <willemdebruijn.kernel.187d58ff2bce5@gmail.com>
 <20261020155917-mutt-send-email-mst@kernel.org>
 <willemdebruijn.kernel.2c9decc16892@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <willemdebruijn.kernel.2c9decc16892@gmail.com>

On Tue, Oct 20, 2026 at 04:19:41PM -0400, Willem de Bruijn wrote:
> Michael S. Tsirkin wrote:
> > On Tue, Oct 20, 2026 at 03:54:23PM -0400, Willem de Bruijn wrote:
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
> > > >  Documentation/admin-guide/sysctl/net.rst | 19 ++++++++
> > > >  include/linux/virtio_net.h               | 23 +++++++++
> > > >  include/net/netns/core.h                 |  1 +
> > > >  net/core/dev.c                           |  6 +++
> > > >  net/core/net_namespace.c                 |  1 +
> > > >  net/core/sysctl_net_core.c               | 60 ++++++++++++++++++++++++
> > > >  6 files changed, 110 insertions(+)
> > > > 
> > > > diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
> > > > index e586e17fc7a5..b1a1c4714b22 100644
> > > > --- a/Documentation/admin-guide/sysctl/net.rst
> > > > +++ b/Documentation/admin-guide/sysctl/net.rst
> > > > @@ -246,6 +246,25 @@ processes are dropped unless socket option SOF_TIMESTAMPING_OPT_TSONLY is set.
> > > >  Default: 1 (on)
> > > >  
> > > >  
> > > > +virtio_net_hdr_csum_check
> > > > +-------------------------
> > > 
> > > virtio_net_hdr_validate? In case we do have to add more validation
> > > later.
> > 
> > If you insist. My worry would be what if that validation is again
> > user-visible somehow and we need to distinguish users who want
> > to disable that future thing and users who want to disable
> > just this current thing.
> > 
> > Hard to predict the future. But I will go with your intuition.
> 
> Thanks, but definitely feel free to ignore my suggestions.
> 
> My intuition would be to define as
> 
> 0: off
> 1: everything one
> 2+: sadly needed fudge values because we keep having to tighten,
>     but some crazy workloads need to opt-out to avoid breakage.

yes you said i just do not get how it will work for userspace,
maybe u can explain?

and what specifically is needed right now, while we
just have 1.

