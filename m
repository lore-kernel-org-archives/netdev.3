Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792537980;
	b=IBj4x13JEs4nVKl9JaXmCyl9xV2mrmF3DBwIUlj0OTVdoQ356c+jwhzQACe3Olf14XFa
	 23zXjnOz+DN9PqgSZ/yvlWdhgFzme5VEqPaRoTlLgeC1Rst6u92qQBUGZzuhks8F+6sqX
	 zWZ8ZPFeQ7rA9XvdJtCzed/ld32cqLWtd2dhpScqVkkKcawEbDNWr3p+L7Ftc5dhMKieM
	 a4KitS+AgkH041o5uF/DBZgnmz7o0Sm1iPZg7VwwSqIKTCu5VpWK1ifgYgtQ3jGk13pl0
	 9co2nOaC125qNRLwzhDrYUCvq7JBY4vv6g7+8s1I3krRWZWvNq0zUhGnxSgqys5L0Ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792537980;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=V4dEpVJ6+z1cOz8lzxIgY22zi/dH+CU6Y8aHuWhhhWA=;
	b=Mm6EH/KxB1PAoiDIxPAFKSQ6lMHNODda/2ZIx60Y7yrmW+ivJ4eBDoOnwCr7MJLh9SAg
	 eioJHrMQo0Mnn/aqQfANUIao6AUzRpKgw7ldGfeKzNbhaq8f59I9UtQ3/DapLJ8wfhh8N
	 GHgP281yWiIlze2+z4HNgmBX9oVo4lk5OURIPbA1+d0yYlnPGSpAigkF640t6x27EZHvA
	 abIdloxBZ/bMo5bqoUesMYDNlvtPJBmXBUX8CDzjbpYySBjrsTW0EyZWRGpj6uT4lXTlK
	 4UO5+amJ5DF+TdCLfwJfaZ4eJ9OcMpjvrkjXVotc0athQj6ftiLxdoGo1vZvbG8BaOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="Bff/zOrQ";
	arc=none smtp.remote-ip=209.85.217.51
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558FC606A31A
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 23:12:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 558FC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Bff/zOrQ
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-7cc0e865dd1so54754137.1
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 16:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792537979; x=1793142779; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=V4dEpVJ6+z1cOz8lzxIgY22zi/dH+CU6Y8aHuWhhhWA=;
        b=Bff/zOrQS58D8lWXqbV5dgpvEkhMpH+A+e56BI4NZxfEzq1YHbf1gpbKVbSvCRUk2u
         PZ93UxEymZJRDkSwSxJH8vl4sCT44pwR5XyFRCpa6iUm4G60dyJi2m6wJvoutjeYgApC
         1hMF5ffNK2zBSavYm0J8dFI+9wDpqFWfMhBZLkBePQuHeRC4DlrbNCDvSJnmHSEzV1yz
         F0hDmgJ7I/Fus9OhFHtI9ItSQueyGrEwc9fydxPQKw3A3z5UzFEEKoFo/h2Z0Yf6ISc+
         wOCGVPS7mpH3kXX7QGtqwe8IL+5DyZcEXP1DokQPO5Dzty/rqLxL6HwMtbEFm3mxSpav
         Miww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792537979; x=1793142779;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V4dEpVJ6+z1cOz8lzxIgY22zi/dH+CU6Y8aHuWhhhWA=;
        b=gVSYwW9Z1xBIJM1s6Zjehegncd9/0jfIdrczXpyzy+hVv7tsC5aTcnOGPR7VPa+t80
         i5lQjlXt1FcDl3N9Tyvr9zGaYkd5YAs1EWEyQxajY/3ddYT/2uPpQ5uCfuKcsAYWUbsS
         Bwa5sbzOje7n2sFLV++U3uAsa8zzMYEVfsPAmlk2rDrI3npwbuHj55xZb/3eulp2h/Uq
         bW5QazHsko4rFpkZY6ZJSR/ymLqKFXSO3vffcKWWEJ0Bd1jFId2c8eC4Iqvq7XHt3eN2
         Y1DTc7yT2ehq4KIYzOICCv8f3JYYETKwDyOV6qO5x4T+7N7uA0FsddbYCw3ZUcrDGRSV
         sT5Q==
X-Forwarded-Encrypted: i=1; AKwUvBwAdIV509jDp38s9BUteG71/OOSqeCZCbIBXgEMiyWxhUCbaXvHaxenCMl97/9MFvRNyIau67c=@vger.kernel.org
X-Gm-Message-State: AFq9FYLNpFVXwjUIthipr5aj5g+UXa4uX03e5JYMfiMliKV3Q1aCHccb
	boADUh6Ni9mdGgRNBGxdZeGX6HmkiIv8abNLZjXPV9dsBTeDx7/XXAfo
X-Gm-Gg: AYBFou2o7u0NWm9j9Eh04Oqv4yq2vAG751iMGHQSSYq4h9q749dJcJiQx5PIGWSTbQ0
	E994gkFV5ZUhHgcK72pQFjhqojZXLqbErOicz+bVnz6OWNeqszWNdrMlhug1G6bUUOgwveWui1u
	KuugbClQXttMiihlTQaKBerTExvZ+x4nY+Km10UIJCSizP6xIrIsPKYkdlHhS0U2V+zeSRNGSv2
	au8MIwy6j74zFlJtroDxxpMSchDMygxcRnEKLBIv3s7byIjtxQZ0UagRaWtxXUQC1rTc5AyZHKQ
	NhvMYgFZ7GUF74rMNY0AvhNf3Zqm2f5mF3PDgB54ETE+qTTF7On972lf1GFQY+anwhaftL9usi9
	i/OsiCm2vfS8XfXq67OoTosZh3vEsyB8LDicHd87fKgh+6Yu2PWHhmUGXY+DrqdDeGWXb/KFRv3
	u4QB7iQpk2Y4JvVHq2+JILsR6/CIZKO/z9d8lAnH0KS3a/oJBIhUYZU6HNjAjBkVmhLxjwlJxXX
	iZHunGfG++h0I7FfVx9SN2WcW4IXMdFRNKAX0Kr0oQdYTkZc1JzqllMqp3/gEDo5ULsJpyZq2aU
	tofdPNx/mNwWV0nRgAPbvDyv9Lcbek8ZLUxJUg==
X-Received: by 2002:a05:6102:a145:b0:7cc:95ed:3147 with SMTP id ada2fe7eead31-7cc95edaf07mr37812137.34.1792537978890;
        Tue, 20 Oct 2026 16:12:58 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-990d108ff73sm1235667241.7.2026.10.20.16.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 16:12:58 -0700 (PDT)
Date: Tue, 20 Oct 2026 19:12:57 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: linux-kernel@vger.kernel.org, 
 Chris Arges <carges@cloudflare.com>, 
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
 Phil Sutter <phil@nwl.cc>, 
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
 Max Krasnyansky <maxk@qualcomm.com>, 
 Rusty Russell <rusty@rustcorp.com.au>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Simon Horman <horms@kernel.org>, 
 linux-doc@vger.kernel.org
Message-ID: <willemdebruijn.kernel.2eabbddbe6528@gmail.com>
In-Reply-To: <20261020162048-mutt-send-email-mst@kernel.org>
References: <cover.1792411304.git.mst@redhat.com>
 <6f23c55c6eba3e3ec6b2c7e3a80728a326ed58af.1792411304.git.mst@redhat.com>
 <willemdebruijn.kernel.187d58ff2bce5@gmail.com>
 <20261020155917-mutt-send-email-mst@kernel.org>
 <willemdebruijn.kernel.2c9decc16892@gmail.com>
 <20261020162048-mutt-send-email-mst@kernel.org>
Subject: Re: [PATCH net v3 6/8] net: add a sysctl to opt out of virtio net hdr
 checksum validation
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Michael S. Tsirkin wrote:
> On Tue, Oct 20, 2026 at 04:19:41PM -0400, Willem de Bruijn wrote:
> > Michael S. Tsirkin wrote:
> > > On Tue, Oct 20, 2026 at 03:54:23PM -0400, Willem de Bruijn wrote:
> > > > Michael S. Tsirkin wrote:
> > > > > The ingress validation as implemented by the previous
> > > > > patch is stricter than what it replaced: GSO
> > > > > packets whose checksum metadata matches no transport header are
> > > > > dropped, and non-GSO ones get their checksum completed in place.
> > > > > Such packets used to pass with the metadata unvalidated,
> > > > > and with no overhead.
> > > > > 
> > > > > I judge that this should not affect any deployments, but there is still
> > > > > some risk that it does.  In case a deployment depends on them anyway,
> > > > > provide a per-netns switch to get the old behavior back:
> > > > > 
> > > > > echo 0 > /proc/sys/net/core/virtio_net_hdr_csum_check
> > > > > 
> > > > > The default is validating.
> > > > > 
> > > > > Assisted-by: LLM
> > > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > > > ---
> > > > >  Documentation/admin-guide/sysctl/net.rst | 19 ++++++++
> > > > >  include/linux/virtio_net.h               | 23 +++++++++
> > > > >  include/net/netns/core.h                 |  1 +
> > > > >  net/core/dev.c                           |  6 +++
> > > > >  net/core/net_namespace.c                 |  1 +
> > > > >  net/core/sysctl_net_core.c               | 60 ++++++++++++++++++++++++
> > > > >  6 files changed, 110 insertions(+)
> > > > > 
> > > > > diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
> > > > > index e586e17fc7a5..b1a1c4714b22 100644
> > > > > --- a/Documentation/admin-guide/sysctl/net.rst
> > > > > +++ b/Documentation/admin-guide/sysctl/net.rst
> > > > > @@ -246,6 +246,25 @@ processes are dropped unless socket option SOF_TIMESTAMPING_OPT_TSONLY is set.
> > > > >  Default: 1 (on)
> > > > >  
> > > > >  
> > > > > +virtio_net_hdr_csum_check
> > > > > +-------------------------
> > > > 
> > > > virtio_net_hdr_validate? In case we do have to add more validation
> > > > later.
> > > 
> > > If you insist. My worry would be what if that validation is again
> > > user-visible somehow and we need to distinguish users who want
> > > to disable that future thing and users who want to disable
> > > just this current thing.
> > > 
> > > Hard to predict the future. But I will go with your intuition.
> > 
> > Thanks, but definitely feel free to ignore my suggestions.
> > 
> > My intuition would be to define as
> > 
> > 0: off
> > 1: everything one
> > 2+: sadly needed fudge values because we keep having to tighten,
> >     but some crazy workloads need to opt-out to avoid breakage.
> 
> yes you said i just do not get how it will work for userspace,
> maybe u can explain?
> 
> and what specifically is needed right now, while we
> just have 1.

Right now the sysctl is boolean.

If we define it as a narrow, very precisely defined sysctl, then its
exact behavior is set in stone.

If we then add additional validation later, that can similarly have
unintended breakage of weird users, we need to add another sysctl.

And if that validation is not entirely independent, i.e., builds on
this, you get a weird set of interdependent sysctls.

While in general systems will run with all validation enabled, unless
they do something weird that gets hit by validation.

A single broadly defined sysctl ("validate input at the source") can
be refined over time, including to expand to validation of other
virtio_net_hdr fields or protocol combinations.

Even if defining it more broadly we can still leave it a boolean:
all validation on or off.

Or, optionally, we can also define additional validation levels,
e.g, 0:off, 1:everything-on, 2:validate-csum-only.




