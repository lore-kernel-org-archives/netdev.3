Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE02370AE6
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 18:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787594644; cv=none; b=g+KGxxmr3WzAw3wDNeG5EttDYVCeJSXyTyUGVaCx6bPznvcqBEyKl81DvfwUoxEqGx9KI5H6SGodOLvpUYD7OIBFc1kkkZqtYi4F/Im1A2QGw3bhBRg7apFvQlZyLP34WSRTyxo9xMdu81VndvSSsAOZKp1PgIbKqKrEMm9f198=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787594644; c=relaxed/simple;
	bh=9LZJejzKBHpOK2ZOm5S0AwqoZo7kEX+1yR3Qqkt9wpY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=hFXBtrWXbgbg2wXQ9O3kqjz/1vFvcsdAtkPdzKglAoP9lzNIl2i4Te2/CrNSKY5vcbEjH95xQfsFx/6RZWaVR0o2hvkKu0p8Kc+OZaLtIkQmSXsTfC7yKTeczQuA6j2MVdqIUU/v/4XMGSjvfgp2uJSnRmOYT5oS1Ojlyc5RwC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UnfQxKZv; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UnfQxKZv"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-836cb2fa1bcso57846187b3.1
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 11:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787594642; x=1788199442; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vRYYbXBxytb4xYuwFc+DecfR0k5aa7+qC4KG84YDZXs=;
        b=UnfQxKZv2C2knMkRLNYzI99QeGPBIjFSyARXOVlva2cWYu4M19501wLqLDgh6LD+7R
         kdlikSb8n/X7sCK6EASpTdzDng4Fn3LLcz4XbOJKnuLmxyIVJGjrksRkrHfc9qYuPIPq
         2nlv9Fg3si0uRkRKgei4L0/XbKml3MXDabrWZ08yOk5ZXwEZ+RjZFFjf2u8OzfAY47QE
         Zl4LgCZesWYGv08ONX9XBaouUXHEn9i8NVOMk71cAN6wz3l2mVCt8SfaReeHi1rDXggu
         C+T0ZClL5zkWn+ey2PDBiBOywxt7SY/FKCmqbLeiXut6niQSs1ha5OSqUuMn5O2gbVoi
         P1UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787594642; x=1788199442;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vRYYbXBxytb4xYuwFc+DecfR0k5aa7+qC4KG84YDZXs=;
        b=hIIXhNk+MVlcXRrFrIgQMB3pcKDQYZENh7o4+OFT5R6VCGJ8fK3i5ut7ZsqCWSGwLC
         bHB1nMubxsCLKGlxescTHSRCQluRl2AUXNp4hYAmF6hWKkilnEmaBot4ZhgbFIuTEMsx
         CQaqAtaGNEAfxS13vOGQSxJEkax2wAlpdBRWZVl351v8AhPO5qHLHoPQmVo9jbAy4xvN
         iNNEzVhM7s4PvRy4HOEcGwJZ6hmm1DiyaUacTVb3GupBd3bRHPQNhhaw+42s0qplXJnE
         rQBeGPdzwwV6bUZ18fbhVvimMSeddLGacbd7b6FisfRWwRpDFua9RGYzaqqwpyva2fzo
         wEYw==
X-Forwarded-Encrypted: i=1; AHgh+Rrv2vYZZ9KobeWMokvwd0cIaypWNzRE5JcA3WrY4DVZ0NWEas/gOPaXsaqrd95WZ6QEU6rXal0=@vger.kernel.org
X-Gm-Message-State: AFuF++mYe8p9EjhaPDVotITRZZt8IP3XQ6Ne7rYWzQPgc6sF/dBzgW+O
	zJCLEd2AGQAgNAEuY13zYwCWXvgY+Mpcv62FPYojhAti4BMvrxU4ybxG
X-Gm-Gg: AR+sD10+NAB8duUxLI1KM96jeXO+kwNDmaaVGHAxeJJLvIJOTNocT0DZd9G2RBEtUaE
	m++A0dgKScixcvn0POJfNZJkNrCF9eyUIHe50p30Plmw9e8i8QmvCb9r6kTbDH8EBmt4d4s55sK
	gRlQmEIY0kb6wctxwkHGhW9cRlebtC/TLb9xFRe0ynsnFuyT5dBHjmWKD7x5jyWZIBgEzuGUad1
	TYSFbhHAXN2aytZHBB8mQtGjwR8t7S3K+pwIHLaXwKYoHxA4pRFpzqWot+oJJIYHdyhmBIsHtfO
	BYW8DX4qfq343KyAkVb9C4jFsKTQRed2SdAUybC5mRzMGEDJjtUPh9HUrI0RJSzCBD2i0UMLkYM
	29Rh37ZVcn9b8oIQ5A/SUl2oHHfkjbConq+HUYDCt8S4S0KvzBWPK/RM4TygkM4giZTvJIf64Cs
	7bY8ywWT9DsnxJ2GhTVROqjASU3Zr6jrCZHtsDctNKBdW3tEF5IsDJp8RsRlt0C9Y1eYz6uh4bX
	4kaCE4Ki+TUN2d/dwgY+5DDGg4XmP1ENEZk6fKfHYPNE9yUgvGN
X-Received: by 2002:a05:690c:81:b0:7ff:19d6:74ee with SMTP id 00721157ae682-84c9c1aacefmr80058847b3.33.1787594642149;
        Mon, 24 Aug 2026 11:04:02 -0700 (PDT)
Received: from gmail.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-84ca5188982sm39037347b3.10.2026.08.24.11.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 11:04:01 -0700 (PDT)
Date: Mon, 24 Aug 2026 14:04:01 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: daniel.zahka@gmail.com, 
 edumazet@google.com, 
 cratiu@nvidia.com, 
 borisp@nvidia.com, 
 kuniyu@google.com, 
 netdev@vger.kernel.org
Message-ID: <willemdebruijn.kernel.8f2da3446e56@gmail.com>
In-Reply-To: <20260824081151.4a37c3c6@kernel.org>
References: <20260822225524.2328465-1-kuba@kernel.org>
 <willemdebruijn.kernel.1157fb673940e@gmail.com>
 <20260824081151.4a37c3c6@kernel.org>
Subject: Re: [RFC net-next 0/6] psp: use virt cookie as Rx steering hint
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> On Sun, 23 Aug 2026 13:48:05 -0400 Willem de Bruijn wrote:
> > Jakub Kicinski wrote:
> > > This PoC series uses a field of the PSP header intended for tunnels
> > > to auto-steer Rx traffic. Various attempts have been made at trying
> > > to get Rx traffic to land close to the core where the application runs.
> > > By default RSS picks the Rx queue based on the flow hash.
> > > I'm not going to cover all previous solutions in detail but broadly
> > > - we have RFS in SW which looks on which CPU Tx happens and backlogs
> > > Rx packets there, it is quite efficient. aRFS is built on top
> > > of RFS but tries to program flows into the NIC. Some NICs have
> > > a "cache" and try to automatically remember the flow to queue
> > > association.
> > > 
> > > All those solutions are entirely local to the receiver.
> > > Ideally we would want the solution to look something like
> > > TCP timestamp option - we send an opaque cookie to the peer,
> > > and the peer echoes it back to us. Our NIC can steer based
> > > on that echoed cookie.  
> > 
> > Another option is to reverse RSS entropy. This requires knowledge of
> > the RSS secret.
> > 
> > Especially with PSP, the outer UDP source port is defined as flow
> > hash, so can be used for this.
> > 
> > Have the receiver compute a 4-tuple hash such that it knows the RSS
> > block will select the intended queue. The only free variable here in
> > general is the source port. Then communicate this preferred source
> > port to the sender.
> 
> Yes, we toyed with this a little. Communicating the hash to remote
> is far less trivial. The thing that made me switch to the PSP idea

No need to communicate the hash, just the source port.

> is that modern NICs can RSS on the flow label. Which is nice for
> non-steering capable clients, and it conflicts with pre-computing.
> Maybe the benefit is not big enough to matter.
> 
> Do you have any practical experience deploying reverse RSS?
> Maybe I shied away from it too quickly..

Definitely implemented and it is quite straightforward. Using the
probing approach that Cosmin mentioned. No fancy algebraic solution,
though that would be preferable if has faster convergence.

Not sure whether we ever actually deployed it.
 
> > > This patch set implements exactly that using the optional PSP
> > > Virtualization Cookie field. The PSP standard doesn't have much
> > > to say about this field:
> > > 
> > >  Virtualization Cookie - 64b
> > >  An optional field, present if and only if V is set.
> > >  It may contain a Virtual Network Identifier (VNI) or other data,
> > >  as defined by the implementation.  
> > 
> > If using the PSP option space, no need to (ab)use the VC:
> > 
> > "When the Hdr Ext Len is greater than 1, a Virtualization Cookie
> > and/or other header extension fields may be present.  The presence of
> > a Virtualization Cookie is determined by the state of the V bit.  For
> > example, given Hdr Ext Len of 3, when V bit is set, there is an 8B VC
> > after the IV, and another 8B extension header after the VC.  The
> > format of other header extension fields is determined by the
> > applications and is opaque to the PSP hardware. "
> > 
> > Right now all use besides VC is opaque to the device.
> > 
> > For use-cases that should be interoperable across vendors, we should
> > probably define a standard option space, with well defined options.
> > 
> > In a manner that is cheap to parse at high rate, so no arbitrary order
> > variable length headers.
> 
> TBH I don't see the need for this at all. VC is well defined, and fed
> into TCAMs. IMHO classifying the use of the VC as VNI vs steering tag
> can be left entirely to SW / association state. The non-V options
> should remain completely opaque to the HW IMHO.

The spec should have been more precise than "It may contain a Virtual
Network Identifier (VNI) or other data, as defined by the
implementation.". That second part is a pretty big loophole.

VNI is not clearly defined. A minimal interpretation is that no two
VNIs must have the same value. Yet thay may definitely have the same
queue mapping.

On TCAMs: is the assumption that the VC cookie today already, if
present, is used to steer among VFs? And therefore it can also be
used to select among queues? But this is a different TCAM mask, using
only 16b, and as a direct queue id.
