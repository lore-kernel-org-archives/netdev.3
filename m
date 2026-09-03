Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D69501F59
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 19:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788463920; cv=none; b=Cbfl5UssFwjQ+NVHD5Ez1vY1ikxGvFlh6B6YgyEbE69jXk2KcHUmQfI8wPlFNqQ3sOSfBj49Aeiwg6FdOMMMA4OmWB403Q+ZIzhQ92BNOSTU/QtnhwVorOScjVfvfmJATSz7vu30QAQjsK/I47xaWCZ8crk0ou1TF6evaKRKmuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788463920; c=relaxed/simple;
	bh=C2Xbm9+vzgljPIndJIOSD3k72as3GmPv88a9h7S6LMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b5r5DGxFtRsgwKsxptfJhtIMyhYL6Rs2JOocHQt1O2U+FtX+GQMOMCmpEheAsXah7qmr7YbOU47MibaUTQtebEhcQkOXAE78a22ozH2sUpzATMuz+15+DByEolHDm2Lq2Wcisi7+RzhUEhxcu5hcIMeT1Tp18hu9zeMyqcjNP6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ahpAz3gW; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ahpAz3gW"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso240501a91.2
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 12:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788463907; x=1789068707; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GQSkipTqdF0eZVVJZB/2cKUlfMOe+A+ZO44Cnwhe5No=;
        b=ahpAz3gWj1x2gH2wEpEQn8wPnvenPZmx5felEXQ7mIm9LnkzzmilSlUC2Y8CL+P4g8
         mVCZRKRzrEtogXQgYR/oUP34tegjGjiRAk3wMC9JpXkhTw5IBiEiLWv6f8uYAQkL1SY+
         +ZUHC8/U6Fy9fOOQXb8bB0gZ7TWRdOScASSA5rvrdC13ePXkmMPHWrd0E25OJGs8guDK
         BSUfoXhu1Zmy5YKyOxZ/ya7rBImtqYILO+rr/uBjzWPdGZI1lUYfDAGGlqo0Xx08wvQv
         SUszXg6yD+T4gE6n36iNtAZrqgwFjqVCW7mFb/y63VWSf+gbNPukIig0/F2oZ6pcmocg
         3tKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788463907; x=1789068707;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GQSkipTqdF0eZVVJZB/2cKUlfMOe+A+ZO44Cnwhe5No=;
        b=DBNabLS3E744FHs/IPvJFcwCBCq0G1ilsygyoD6pdOD8fnAu3qfG76IKZlY1ev2zfE
         WiLBElOZh7+H9zyyMGUdSXGtnukuLYGW7+KD9mc6TDKNe6kjYZwOCw6R5tnYgwoZWc83
         2MbDIKina/XmtL1gaNxVM6L0WDitzA13ajNCaykllTyv3Qr6gMAxyi8DMrSSjT5TeKiw
         tjZV41UB6NMmkbrJ/djYSIKTQ801ZDvQgc6qAFp006eq8XsMOU4KwVeYU2sNAG55pmpI
         Q2kyAqU4F4a5UlqUnQOzvJKPOQssJGTv8gTTUqy5yg6hWKdirdxDOx3Ld1MfQvOcOvSt
         0wWw==
X-Forwarded-Encrypted: i=1; AKwUvBx5eiZ7uOgw2iRVSN9LcR3QfCac3Pqwg5Lnla/myGCUPc8/yn+lEVOdvH6vAp8BfRqWi2oMg8s=@vger.kernel.org
X-Gm-Message-State: AFuF++m7V2kZg8zVfil5QVI0j9prKJM3UbafEiX6UzJ38Z6U0WBQlEK3
	BZ+cLMi0VjTqlfaUr8dkfb+OvEn098ALMX4TZLT9FWCLFRweJXtDLiNv
X-Gm-Gg: AYBFou0u1dgxni3PchDySMbTyMciPvcviRHAItpLwDwErYFe/fJuAaz1C2UN3+zvPeN
	8zvSTi8wSOUJcF/dm/gTCAfqTGYyh5Ww2E26c91k5J7OEjEoWMQRqL7SJU0xP3ijRWGFbTmJtID
	IJq7N9TjbWDJeUIvM2n3Flko4dDhXTNhRxSz1D7THHdyB9C4DMU9dT/GZpV+Mksr0LJz9UTbz8H
	v99gO839rGuGKStrvDbbekFxwjUmF0xB2UQb6qn7FEJNN9kDxdpxT9B51M5SpG40Ni9ZtNnWcws
	ObYsSw6nBlP+dc+C8m9tRg9NzCX3d2XVQeC7DK9d40O8Zm0UN8u1vCWVqym6E6Xeb/pZ9S/7edD
	byS+MFSVJAojkWHboP3hLtdw1++h0kH2mdAZkorR3mn4l4wv9eQflCG64hvqo2hO5Qmmm165X92
	PhB2ceaGTrjPwNtfgoJP5wG15aXUmsHIV3frS2T3kgAl6C9Sr9NOUcQ9+GQDkKpvTfOr4IJU9cK
	KSLM99+
X-Received: by 2002:a17:90b:4b90:b0:38e:49c0:75a7 with SMTP id 98e67ed59e1d1-39b2610f2fbmr1013004a91.8.1788463906583;
        Thu, 03 Sep 2026 12:31:46 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b260cd291sm471223a91.6.2026.09.03.12.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 12:31:46 -0700 (PDT)
Date: Fri, 4 Sep 2026 04:31:40 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net,
	ncardwell@google.com, dsahern@kernel.org, idosch@nvidia.com,
	horms@kernel.org, willemb@google.com, andrew+netdev@lunn.ch,
	kees@kernel.org, jiayuan.chen@linux.dev, kerneljasonxing@gmail.com,
	ij@kernel.org, martin.lau@kernel.org, shakeel.butt@linux.dev,
	matttbe@kernel.org, martineau@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	imv4bel@gmail.com
Subject: Re: [PATCH net v2 6/8] tcp: fix use-after-free in the lockless
 listener path
Message-ID: <apnLHKKs8VWnMopj@v4bel>
References: <20260824033331.1084971-1-imv4bel@gmail.com>
 <20260824033331.1084971-7-imv4bel@gmail.com>
 <apaAskNL-IvdcR7h@v4bel>
 <e121d343-9a4a-4f93-86c1-c96dd37f1ae1@redhat.com>
 <20260901085102.5c58a5b0@kernel.org>
 <CANn89i+px52TtJy3S9=uHxGj3s-WueguRo1Z_4FxO=02KLmwmQ@mail.gmail.com>
 <apnHqmYZQ4yzOP4N@v4bel>
 <CAAVpQUAVXFrRuxPCKW_4qqAAdjTpv+arijYODeFMfXshKqajHw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAVpQUAVXFrRuxPCKW_4qqAAdjTpv+arijYODeFMfXshKqajHw@mail.gmail.com>

On Thu, Sep 03, 2026 at 12:28:15PM -0700, Kuniyuki Iwashima wrote:
> On Thu, Sep 3, 2026 at 12:17 PM Hyunwoo Kim <imv4bel@gmail.com> wrote:
> >
> > On Tue, Sep 01, 2026 at 05:57:04PM +0200, Eric Dumazet wrote:
> > > On Tue, Sep 1, 2026 at 5:51 PM Jakub Kicinski <kuba@kernel.org> wrote:
> > > >
> > > > On Tue, 1 Sep 2026 10:03:51 +0200 Paolo Abeni wrote:
> > > > > > Looking at this further, unhashing the listener and then calling
> > > > > > synchronize_net() lets the disconnect path handle it. MPTCP needs a fix
> > > > > > too, though, because it closes and reuses the first subflow directly
> > > > > > without going through tcp_disconnect().
> > > > >
> > > > > This looks like a more palatable approach: this patch in the current
> > > > > format looked way too invasive to me.
> > > >
> > > > I likely lack context on this, but I was wondering whether we should
> > > > potentially disallow the transitions between listening and data sockets
> > > > instead of fixing these endless bugs?
> > >
> > > +2 I think I mentioned this at some point.
> > >
> > > Same for IPV6_ADDRFORM : we should not allow transformed socket to
> > > even use tcp_disconnect().
> >
> > So.. do you have a plan for this work?
> 
> I'll post a patch to disallow the buggy transformation.
> https://lore.kernel.org/netdev/CAAVpQUAWjBuF1Rgze0Vt_XvkUT=Ajw-F+Kh+s2iHk38c8iAapg@mail.gmail.com/

Understood. I hope my Reported-by: will be included in that patch.
