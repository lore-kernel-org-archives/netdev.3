Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794080049;
	b=w1meyT8bFD6ZSqmkEd7v9mVMk3LuqlXc1pPzETT8nNLgGNy2Bj2uczyftVncg9/HA0om
	 TvD1IwGk/UDPmxST0hJWHEBACl+yQeH5BnvpFP7c9YSqc9//5xPy4F1V9CmnPKDIyzcdQ
	 7pgIe62X8K4yGsTXy9/ZEznAQ5+xwQMeRu6GnoyGqBygcb6eHGjX3SE0YtFZCtsSkrecX
	 gIvX2+UENtAstOXkWCr9gzA+3zvimV2y7kpDSFdajdN6PsONQQEQHx11tfmHvSYGLkkRZ
	 UrPgtCeMnCiC5iuWPZnN+5e1tLe9+wzZRH9eeq6TpLjc+mAGaUG1qi83AIheFTNblSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794080049;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=tTMbY5wDu0Q9kyyP5WALVTT8c1BJMdKWv4LGJnBFjhc=;
	b=iaN8+fX1HFEY2TbJoplWFALISmobLVLTBAcV1C8/sLQNQLwReT3GQuNBjNjaWsiZeIxf
	 T0WaGY5ffuoSiv69c5jEWvAnEJereCAFCUOFnZl5d5NrpfJ0/PWlwcAW1DHRMawLUeXv2
	 KLEMEcLqOAs7Vfy3XWOObk4xER8A0/p9mBIH2C+niLU2+EutbjIoJauVTspIj4TtrXB+d
	 h2KOd0U0cI+eGgfwor9yw3MKlItJN4nZcN50nb/78rPMc3HFW4B+rMQyCrj6aS4v+67B2
	 su5rnhealy0789wFMdfOryrnDZdKL6YwZlysFOs0XCLLPqdtqJbFhOxBtWW5ORiBunQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KLxrqfM7;
	arc=none smtp.remote-ip=209.85.214.197
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B06606A339
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 19:34:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60B06606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KLxrqfM7
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2e987ec84afso16408195ad.3
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 11:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794080049; x=1794684849; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tTMbY5wDu0Q9kyyP5WALVTT8c1BJMdKWv4LGJnBFjhc=;
        b=KLxrqfM7u7uxgIMHAjsKmhtRJzAp+RwNzVoYEu9m3l2q/VEQBRvxR1azMIMowRWtPU
         Ybh3pdXyLOYMy1vxHG0BXAtbMhHhuIxUO3+VoL+GnSeEH3Esy/WeYhTkcPWiy3EpVsh7
         gehZbvSgUJi/5SNvluEmcUyx5I6iEdvs+cbgyuh+WtIoSqrUhQS0kzQ7cr7SHEXbBIV1
         a7Z26cEUJQTt2eiUv3xLTJu6Z8Ya+TUVV4okI/1exFuGUWd+dHdXCxnUg2YIz8ELkThA
         B9ymKTEVZOYuApXh1SHPhckbNuw5P68jP0PYlcLW4PAzcMSss6BUnIm3JSDZmbAWLZVT
         V5/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794080049; x=1794684849;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tTMbY5wDu0Q9kyyP5WALVTT8c1BJMdKWv4LGJnBFjhc=;
        b=NSCZgoEL/Rm+sbmv05NbwZxX6FxXTu5u3Fq6mhg8zwneD26Q8ahfbGYyZ+Lk5ScxIE
         r1Ht8ADM3wtqedaPpnudlF/izC/lyKxHj2JAChVdNZENYsi3u05k7PJ565x9S30/dmG7
         F0U3e533a2hEvkEpSZ/+Gpea0lhyBR16svOTjooLpSfU4bUyv4I00MtaLLifCUzggptD
         3HoXIb6Fi7BADrf4e3NBpV0Fm5+YDyW+xj2azQzTCGsyJIMhocIc3DRUPDJIdpmOKaKn
         AVLBO5ojwVVMnvjMANiCkifoYsyRqsqYe3A/KeJH9xbjMKAs1UYGK1Za0+x0X9aHkhMN
         tXdA==
X-Forwarded-Encrypted: i=1; AL+hErEY7WyAsvQuPyMoAiQoBelvJlQ9seiDrRGYNFyTC90y0mOaM1DpSeiiqzzWlqkmTMiF8iimRhA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+xfPTRx5XeYp06Q/ahbXxwKOOzi9+bAWGvZp1YCTFXrFnbGbqi
	2krmBNenvT7E3ryFxAdej59JtJdtmRkzWxDS2pokXcK0ZaS2QOrttexMBtspfnp1XoqRDFENnbQ
	IqRYfXA==
X-Received: from plon11.prod.google.com ([2002:a17:903:1a8b:b0:2ea:ce88:ff88])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e88e:b0:2e9:9a19:c4f
 with SMTP id d9443c01a7336-2ed40e89b01mr67905115ad.61.1794080048300; Sat, 07
 Nov 2026 11:34:08 -0800 (PST)
Date: Sat, 7 Nov 2026 19:34:07 +0000
In-Reply-To: <a951af6957fe4890d3eaaf5a661754fc259a4b79@linux.dev>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261009091941.5837-1-qiang.zhang@linux.dev> <CAAVpQUAeHP7M07uMweRePtuzPPUo-99dL6jOYUiVf7CSVUxNDQ@mail.gmail.com>
 <a951af6957fe4890d3eaaf5a661754fc259a4b79@linux.dev>
Message-ID: <au99DNHQEsaaDqpJ@google.com>
Subject: Re: [PATCH] neighbour: Move the netdev_put() out of RCU callback
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Zqiang <qiang.zhang@linux.dev>
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Sat, 07 Nov 2026 11:47:45 +0000, Zqiang wrote:
> > 
> > On Fri, Oct 9, 2026 at 2:19 AM Zqiang <qiang.zhang@linux.dev> wrote:
> > 
> > > 
> > > For builts with CONFIG_NET_DEV_REFCNT_TRACKER=y kernels, netdev_put()
> > >  records the caller's stack trace via ref_tracker_free() for debugging
> > >  reference leaks. however, the netdev_put() is within pneigh_destroy()
> > >  RCU callback, this recorded stack is uninformative, it does not reveal
> > >  which code path initiated the deletion.
> > > 
> > Have you seen pneigh double-free ? What motivates this change ?
> 
> Firstly, Apologies for delayed reply.
> 
> 
> 
> Actually, I didn't see any double-free happening,  just wanted it to
> record a meaningful callstack which on release path.  After all, if double-free
> really occurs, the callstack of the RCU callback execution path will not be helpful.
> 
> 
> > 
> > > 
> > > This commit therefore move netdev_put() from the RCU callback into the
> > >  caller's process context, and replace call_rcu() with kfree_rcu().
> > > 
> > >  Fixes: d539d8fbd8fc ("neighbour: Free pneigh_entry after RCU grace period.")
> > > 
> > Please elaborate why your change is safe in the commit message
> > and remove the tag.
> 
> Does it refer to using kfree_rcu instead of call_rcu ensures safely ?

I mean why dropping netdev refcnt waiting RCU gp is safe.


> 
> Thanks
> Zqiang
> 
> > 
> > > 
> > > Signed-off-by: Zqiang <qiang.zhang@linux.dev>
> > > 
> > nit: full name
> > 
> > > 
> > > ---
> > >  net/core/neighbour.c | 14 ++++----------
> > >  1 file changed, 4 insertions(+), 10 deletions(-)
> > > 
> > >  diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> > >  index 6ed8eb075146..4263689fc415 100644
> > >  --- a/net/core/neighbour.c
> > >  +++ b/net/core/neighbour.c
> > >  @@ -818,14 +818,6 @@ int pneigh_create(struct neigh_table *tbl,
> > >  return err;
> > >  }
> > > 
> > >  -static void pneigh_destroy(struct rcu_head *rcu)
> > >  -{
> > >  - struct pneigh_entry *n = container_of(rcu, struct pneigh_entry, rcu);
> > >  -
> > >  - netdev_put(n->dev, &n->dev_tracker);
> > >  - kfree(n);
> > >  -}
> > >  -
> > >  int pneigh_delete(struct neigh_table *tbl, const void *pkey,
> > >  struct net_device *dev)
> > >  {
> > >  @@ -849,7 +841,8 @@ int pneigh_delete(struct neigh_table *tbl, const void *pkey,
> > >  if (tbl->pdestructor)
> > >  tbl->pdestructor(n);
> > > 
> > >  - call_rcu(&n->rcu, pneigh_destroy);
> > >  + netdev_put(n->dev, &n->dev_tracker);
> > >  + kfree_rcu(n, rcu);
> > >  return 0;
> > >  }
> > >  }
> > >  @@ -891,7 +884,8 @@ static void pneigh_ifdown(struct neigh_table *tbl, struct net_device *dev,
> > >  if (tbl->pdestructor)
> > >  tbl->pdestructor(n);
> > > 
> > >  - call_rcu(&n->rcu, pneigh_destroy);
> > >  + netdev_put(n->dev, &n->dev_tracker);
> > >  + kfree_rcu(n, rcu);
> > >  }
> > >  }
> > > 
> > >  --
> > >  2.17.1
> > >
> >
