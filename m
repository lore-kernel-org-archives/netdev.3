Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B538A5476DE
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 15:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788968837; cv=none; b=d7sEaVmDB5sYkPGEj4ZUBdzDJXiFevPXRGco1q+zPfhwCnyPoAaE8GDKmdaHlymPQvGkJPW2XhriM6c0XYGsxLJoZmi8wz9lRNy2FcW8oWE5Cy18SYQDrW6njtB2fTa+pZCc2rf/1Iku44z2wA164mMqY2RWd4DJDvBmApXs/A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788968837; c=relaxed/simple;
	bh=N/WLAPFNniInJzbmPtmGyiWArtEDEu3rvWcZgtBBbjc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=WqIqSEQeFQhI+Qt0sNLDwffIbAxj/mH9eLJwkw2l4i4y0LQUMgU6tphoUi9MK2lBDZ2pNp5E/vRxf+HAATZ6H2IPNUQFfw/QNi30KR8FNASRr7jF+jOkO3qw7hEbE3/imI9yaq75qhhOx26TgZxs1OHqEqnTvhtkL6Aty16i9cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UrR8vaFk; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UrR8vaFk"
Received: by mail-yx2-f12.google.com with SMTP id 00721157ae682-85d4eb63f16so13716367b3.0
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 08:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788968834; x=1789573634; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=s5krVvgDpigTsB10TLunKhlSyS+RtOFpjYDXiSmULjs=;
        b=UrR8vaFkoY51RMsmTTej2TkYStKXUoZjgS74T+2TOCnK1BiJpx086KTgn8SNg8qFk/
         4Poeg3h+n0wUKW0+BjLnodbTrbWzjnxQ+uoOKKOdOCjNZwBKY3mqWrkQc9UT4qf5R5uV
         Vh/O0Nyn79fL1rUOZEn5LxSozk+CHShp+l1meSsArQB9NtQ82SC/1N6KbPW5YyYIMINI
         lgyWYDwXa0+e4yT59k/+lcR49aZVrpRjydDQd3tyyecyLabCvxbGbc8EvhxhJdkSgcK1
         7eE7HmXe7/Eow4zvB3l8niLNiwsJwk3SdZiFKoZBScB7P3rJrDw2RPAlpaFyiT0Ofe/E
         bj0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788968834; x=1789573634;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s5krVvgDpigTsB10TLunKhlSyS+RtOFpjYDXiSmULjs=;
        b=RG3fJnZ+AFlFJSJmZ4ktTVJREJIIcydn6upZzD9EoKdN07tjSJdyMV3ek3ZGuQ2STJ
         PSSijq+WvDamntzUzz+biZzi3N8ctGP763kdMYwGM0Vy2mjYwKUeZf4kKSdrJfSzawiZ
         KgghhYI7AH3TzDLjtfntCJg0DWSSZe04SSZYD8DM62fwpA7MOrJeV2IrPI3018lsGLVD
         8J0KKCYlJgTzGFz7k9PY7URXuIwQR5QZpneGMmSrQv4akyhGkVTWFb7zOM5ttSPH80gx
         ROot3PmE8coO3MTWaxkTOBGpc/+SFgBGJGOO60b7AQRb2KCGW2Z1zyI2XGZJePW4GNJ2
         zKOA==
X-Forwarded-Encrypted: i=1; AKwUvBwwPiJYXEkO2QTymx3DGeAJQ9qcOcvAtHn+sN6P+g7m2cnEarZbKvCgDNnFuOp1FEqcAAMu7FM=@vger.kernel.org
X-Gm-Message-State: AFuF++lPQ7khUUvC/1bPtPXDoNPWe1/yRLAf3rrN4PTqeeYk5K8+IZBt
	l4b0EV/BG40DsxIIrbMDRyxSsyVJ8zncGO3B63WFuMOmbEnUSC52GpGo
X-Gm-Gg: AYBFou1bFVpR2/I72IM9DCthjL0ngsNom2CSyalOUKeawbq2Z3rlinUozp7UF3P/u2c
	11AQo27bqf4UH4ydKDZS7kTZV9EWkHgNKgCIgNVFokc9pwasUTc/cMdqdk6B2HlPfhhOb3FrHqO
	q8n3erH/EDgOwTx1BMVWd6fImMfrefdbXe5dFGxNWvgQnoAwc7RA2qVoBkAFnDBYi7e/TA42GdC
	Oif9QNSeCC+LwVV57WbpqZkAMTnFtOrXn6PM8lQ8X/u+tdBHm9G3IwBJs532eBvQjYgymgMVW1b
	6f2FR5tUopJhmoZSNxBX1AS3MtJS+7QqQnDspht38cQ9sJV9TwzHzX6j51S8kFPH88KspV4rvtS
	yn/jrUZU9xPHQuDOkL/ZTMTa8lv8qTc+1wrdE7CjBAvp3gMFESyI/vJUDg5d/Rg/nyU2Ryl4u/R
	/3y35/stdVH72yVyWstprUN6n2NuhgUpg+6mAaZZ8zJZBcy11/HFaFU+xXiiScNL5Jm+yp4WkEv
	cYyADT43hXk451YPc84H6GNzsgV0b/6ToalZoWjqngEGVzra0oM
X-Received: by 2002:a05:690c:6e87:b0:87c:5161:32c9 with SMTP id 00721157ae682-87c517fb935mr37638777b3.29.1788968834275;
        Wed, 09 Sep 2026 08:47:14 -0700 (PDT)
Received: from gmail.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-87149316347sm114285607b3.15.2026.09.09.08.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 08:47:13 -0700 (PDT)
Date: Wed, 09 Sep 2026 11:47:13 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: edumazet@google.com, 
 netdev@vger.kernel.org, 
 davem@davemloft.net, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 andrew+netdev@lunn.ch, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <willemdebruijn.kernel.123ac363ae937@gmail.com>
In-Reply-To: <20260908163447.68d64e2d@kernel.org>
References: <20260902181747.2483351-1-willemdebruijn.kernel@gmail.com>
 <20260902181747.2483351-2-willemdebruijn.kernel@gmail.com>
 <20260904160106.08acccb5@kernel.org>
 <willemdebruijn.kernel.173115664f973@gmail.com>
 <20260907161258.2b0b421d@kernel.org>
 <willemdebruijn.kernel.19b10eb6885cf@gmail.com>
 <CAF=yD-JSieHiaWVD9OWnFNiDaM2Y9r52S5cn=aFYYXT=DT0wmQ@mail.gmail.com>
 <20260908144819.16313dd9@kernel.org>
 <CAF=yD-J1puTzDQUaMAsTCuCm4dYYgOzYO7S3WV6rA_pWVLKRUQ@mail.gmail.com>
 <20260908163447.68d64e2d@kernel.org>
Subject: Re: [PATCH net-next v8 1/6] net: rtnetlink: add
 pacing_offload_horizon attribute to net_device
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jakub Kicinski wrote:
> On Tue, 8 Sep 2026 18:39:20 -0400 Willem de Bruijn wrote:
> > On Tue, Sep 8, 2026 at 5:48=E2=80=AFPM Jakub Kicinski <kuba@kernel.or=
g> wrote:
> > > It's just a way of avoiding netdev_features_t becoming larger than =
64b.
> > > At the uAPI level we have a bitmap so we can express any number of =
bits.
> > > But in the kernel dev->features is u64 / ull so if we run out of bi=
ts
> > > the refactor will be rather painful.
> > >
> > > Is it really that much worse to add the support for "high feature b=
its"
> > > which don't go thru netdev_features_t to ethtool, than sprinkling e=
xtra
> > > one off booleans into already bloated RTM_SETLINK? Not sure.  =

> > =

> > How would this work with hw_features, wanted_features, vlan_features
> > and other such feature masks?
> > =

> > There is potentially quite a bit of logic that needs to be duplicated=

> > for a secondary set of features. Or, the risk that these features end=

> > up not quite like normal features.
> =

> No different than a loose bit in SETLINK?

At least then there is no expectation of netdev_features_t behavior.
 =

> What I was wondering is - we don't want to implement full handling for
> high feature bits, agreed, it doesn't seem needed today. But is it
> better to add such a bit in ethtool regardless, even tho it doesn't get=

> any infra for propagation to uppers etc. Or is it better to start addin=
g
> one-off bits in rt-link.
> =

> Think about it some more, since the max-horizon attr is already in
> rt-link I guess putting this bit in rt-link does make more sense.

Ok, I'll leave this in rt-link then.

Even then, running out of feature bits will come back to haunt us
soon enough. A good idea to look into it some more now.

The main issue here is not wanting to grow netdev_features_t for
hot cachelines, right? Which besides growing dev->features has a
cascading effect on all the other fields of that type in net_device
too.

Extending struct net_device itself is fine, as long as it happens in
some cold cacheline at the end.

Perhaps something like what Paolo did for virtio features in the
series of 3b17aa13015c ("virtio_net: add supports for extended
offloads"). With non-contiguous bitmap fields. Everything beyond 64
is mapped to a new field at the end of the struct. A thin API to
avoid open-coding that check everywhere. And selective conversion
only of code/drivers that need to access the extended features.

> > > I hate both notifiers everywhere and the idea that we have to be ab=
le
> > > to quietly revoke device features "on firmware rollout". It leads t=
o
> > > unmaintainable code which almost never runs so it's buggy half of t=
he
> > > time. Whatever.  =

> > =

> > I don't like it, but firmware roll-outs that remove features
> > unfortunately are a real thing. Especially roll-backs.
> > =

> > For pacing offload specifically, I considered the risk low enough to
> > rely on the admin to manually revert the FQ settings when such an
> > event happens. But the bots kept complaining. And in fairness a
> > notifier based auto disable is indeed much more robust than a manual
> > correlated roll-out. OTOH, it is rarely exercised code in practice an=
d
> > thus more prone to latent bugs.
> =

> TBH I'm not sure what you have in mind with the notifier.
> What netdev event does the FW reset generate? =

>
> > A simpler approach for pacing offload is to check the dev fields
> > directly in fq. It is likely that that cacheline is warm.
> =

> Right, there's ~30b of unused flag space in the first cache line
> of struct net_device. Should be warm.

I can move dev->pacing_offload there.

max_pacing_offload is in a cold line. Finding a way to squeeze that
somewhere warm can perhaps be left for later.
