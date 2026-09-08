Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61E0353A77
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 20:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788900523; cv=pass; b=nDVgJt9GkF7cfTNcvJLfWFvp4h2Dqjh75oyE7G5Kpf5i2Ym9Cp6JHzjgPdmSNq+FLa4ZgfJq/6j9lb30yLSeWLeoc2ElyzSR1xATFgYeuUD+snazIEnUxsRaT9c0sWWycRYn6aFVS1R0eeAelYbs1yZs3oodhg7ljim5/04WsO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788900523; c=relaxed/simple;
	bh=SfFKrdMxepQhZ8J4hj2MHMb8bJhWHLriKaMIXqVupEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gywRwGO5ZZ5chtxvOOoJ8Zw7KFGbWhM4GphREGMV+CeJJf1vUl5usVGYseJg1cgfB03ZyzeeNUiZcn7PFOxIbWYN7BXqr8is7NNJd4KD8JOvLh6dc5Y0w+i0V1+j3Qa+DeLzF5j2LaBOaS8HGBG+nsJY7jADWdX+RxnPp9OvM8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z2h6cpMJ; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2h6cpMJ"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-81ecf499af9so70072997b3.1
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 13:48:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788900520; cv=none;
        d=google.com; s=arc-20260327;
        b=O/xhzUDXQb1j2609qXIOj/Zjfcehkt44uyKSmc0sJQ0NjGz7ZmiLrNu11EnjM+G+27
         1nDkTgzzLc8nkwr2ZbpVlpcv2h2zoa5FILTtL0olETFYG/PufYgeK5A2nxnir5RldzCZ
         AziOQRuS3zcS/kt6emVJBtpf2lxPyx46rs/dg4Xl9QwsFuUQz3wTENHsp4Z6f2BmoXT1
         l6ep0iS9AuPTo9/z1+Mx68Oq1FGmJ4P5jd/sPRMnFxbIbV+9rTnq8Algv/L3Fm4uekAW
         rYSbGFqlNsoiJUbwFB5mUWp7wv1Ha0UXqQvEJ+GQXeC6/31UaRNNrSWr9KVTs1zarvPP
         AvRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3fW4MWOTjrtWFdL4iMEjGyRMJmpWzLlGZzo1bNEJRRg=;
        fh=/ftGaDgY94QIp1M3tdMX6EWcCDRqrnJRhgQuRymFzQA=;
        b=T8LqHPa9b8xHen9k8ayG8TmxOGayeFI0gBlTJ8wBbq7Nzmgqv0N8U3ifYBno4wsUPP
         rgURLmBUpjYCBQ195yNnArzM8Y1F4yDY3a2etve2XB9qSGtJ0ubXii+VDEgXmEiItscL
         +pZmXqXFv7U2hWS/5xadeGV2qPV3oV5K1LqvOoAECdQ7pABDZp+uGYFnDRpVxlVsf0dq
         63E16Zmz94cUQjd9i01ieb5JiH/2prZsaOIQhtM2OUNSKFjnh7OoulXzV+H05ZLrFbp2
         rrEAGk3BkWbeoeRHGioK7BSNV0Mdx1vb+I3NJPuXSEykpdZxvBzPfbOfN8eC28yY4NqX
         j64g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788900520; x=1789505320; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3fW4MWOTjrtWFdL4iMEjGyRMJmpWzLlGZzo1bNEJRRg=;
        b=Z2h6cpMJG3K9eczmiA4prKL8+R5vTrSDe0Q3LEWGeCV2QkQkgRIOYVmWczz6W4mo8H
         Wh9fpo8PxV83WTv1E7zwl1KrtPXQ1WwZWsk9RCLuEDccRX30Njeg+YhEOAv6GgY0mQvW
         LDyWgwu3og9qq3oWvDJ5I5ae/gWGp2bXpJTGNUeSn2r7X+/evBuHdUJhnBwgS89jk4hg
         /5NZRT3kzJUeD6HCbTKvhqRQEVfNcSFKN27oECAg1FH/gW7LJgSSG1FveQftKJjpQp/m
         kNs0UnKYApgZ92MApPq/lrb0kz6WzC2ZepvpO0pCV7HH+SHzqVHk00pb70DaNHLGjg08
         QC2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788900520; x=1789505320;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3fW4MWOTjrtWFdL4iMEjGyRMJmpWzLlGZzo1bNEJRRg=;
        b=r9MyK3S5oCMy56i8QD2xzE9W9MEOCR5zg7gEyXdnYvaX+tYRA+kWKUwRBfydYaR3sg
         jDsprnW/QwgmcSfuygy+WHj8ABPpNl4sfVInLSZs7kKO/w9Jbd6qiUe7nAgLEjrMZiXM
         NNj22uLzC87EC4uZL6PYMv2zjAxAxUUkXd7rVpBpATNDZe3WpQvoHz7WPsR04szF6bhN
         sWh2atuhT/NG+Kc8FKA4nBS8bhWGKA7PDmWYBWvp9Eewr4+6A2jAXCnh7oJ3HbUSloAz
         vs1+vNieQkpYjQrs3kos9q7QrSc9mTKucuNlpgqaIQPlBCLuMcW+BPU/1NvF6ID3WBTs
         0CzA==
X-Gm-Message-State: AFuF++lomBTmcjORKLkzNOhSk4Hod5wEAKCWXNAZfC3J94ssq229odnB
	yC5Tv4vimBSuvV2XFObkIU6/sTfXoHlOt80Em6CvwkqhVO40PY5orKuY3B6oFyKg7SZJDIZhvA3
	FsfaLPmL4h+sHz/lGvaJKsbyslIbmcGc=
X-Gm-Gg: AYBFou1JIWk2bZIq4SGGzEBOE4cL3kSzQfQ54XULP+BuDBYZso9kqgMvt27uHUmfk/d
	Wa4Vu1bNp/F5+Q4aO6PRipbmq6+49zDLhoJ6ZIz+CZ/wz62KIOUjjyYXnHGhdqef4BmVtTy1X+y
	1uOO6VwBRpFW8KuWFwOinHFw2vpGys1LVmIskdS9A0L6smsRPCIAPwRlMnXa2pFtYdJviQDmysP
	t8rCMdLp18yAc9LfKM6fa4U5V9mZOVIPxCu61ey1eyuwoBiZcX8nwZs+s51W4yrnb+mldCcL+ie
	W/AW6pguRypYDyZ/lID+JJibODX0Q3yeo/nWZe4zxHLS9jmNCpZxyv9W43msB/WKTyNXBe12RN2
	zH4Lfu0yLEBJVHg==
X-Received: by 2002:a53:ea8d:0:b0:66f:a181:5e8e with SMTP id
 956f58d0204a3-66fb5a66ca2mr1065237d50.34.1788900520531; Tue, 08 Sep 2026
 13:48:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902181747.2483351-1-willemdebruijn.kernel@gmail.com>
 <20260902181747.2483351-2-willemdebruijn.kernel@gmail.com>
 <20260904160106.08acccb5@kernel.org> <willemdebruijn.kernel.173115664f973@gmail.com>
 <20260907161258.2b0b421d@kernel.org> <willemdebruijn.kernel.19b10eb6885cf@gmail.com>
In-Reply-To: <willemdebruijn.kernel.19b10eb6885cf@gmail.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Tue, 8 Sep 2026 16:48:03 -0400
X-Gm-Features: AcwNN1X-BfDH0jHf-XCXqauB2fcXTJMPXn3qBna6mLTfaffnBSX6ZSJTHKigRbo
Message-ID: <CAF=yD-JSieHiaWVD9OWnFNiDaM2Y9r52S5cn=aFYYXT=DT0wmQ@mail.gmail.com>
Subject: Re: [PATCH net-next v8 1/6] net: rtnetlink: add pacing_offload_horizon
 attribute to net_device
To: Jakub Kicinski <kuba@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	edumazet@google.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com, 
	horms@kernel.org, andrew+netdev@lunn.ch, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 7, 2026 at 8:50=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jakub Kicinski wrote:
> > On Sat, 05 Sep 2026 22:22:06 -0400 Willem de Bruijn wrote:
> > > > > Perhaps I don't understand how dev->pacing_offload_horizon
> > > > > would function as a boolean.
> > > >
> > > > The only uses of the new value are:
> > > >  - as the qdisc bound, replacing the max_ value
> > > >    -> Leave the qdisc as is, let qdisc config define the active hor=
izon
> > > >  - in the driver
> > >
> > > I see your point now, thanks. A flag NETIF_F_PACING_OFFLOAD?
> >
> > From the name I suspect you mean a feature / ethtool (-k/-K) ?
> > That would do, but presumably not as a real low bit within
> > dev->features ? I guess it is a datapath feature but somehow
> > those bits feel too precious.
>
> Makes sense.
>
> An ethtool -K that does not use dev->features seems like a hack.
>
> Keep the existing ip link attribute and make that settable only to
> zero or max_pacing_offload_horizon?

I've updated to a simple boolean pacing_offload in ip link.
Let me know if you had something else specific in mind.

+++ b/Documentation/netlink/specs/rt-link.yaml
@@ -1089,6 +1089,10 @@ attribute-sets:
+      -
+        name: pacing-offload
+        type: u8
+        doc: Enable EDT pacing offload (0 - disabled, 1 - enabled).

> > > The two configurable offload_horizon fields is definitely redundant.
> > > I do not want to ship idpf with the feature on by default, because of
> > > SO_TXTIME. But a boolean will do.
> > >
> > > Plus, a netdevice_notifier in FQ to clear q->offload_horizon
> > > - when this feature flips to off or
> >
> > Not sure if we should be clearing user config or rejecting
> > the feature change if currently in use.
>
> We cannot reject the feature change, if it's a device reset and on
> re-negotiation the device capability changed. E.g., from a firmware
> rollout.

I added a separate patch that adds a netdevice notifier to FQ.
To reset offload_horizon on device feature change if needed.
Or any qdisc feature that depends on device state in principle.
