Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794080859;
	b=vIo62hOiv2QqGnQz2HqlvyaAmY0hDWWuJe3yQMQT8whSlbmShovgtuOmdfUs3nhbRvgA
	 mTr+829fZtP6GN1UPu18Q+dv34okzYX1Ipm7jndQ3XCDxSl8eVbmxh38dz9UVwDXCiqHD
	 MkZkuBeHa+wE0AT/6MOocBVlMm5tcRQWknzOu2E3TUUimge+8bWAKo0djKUWK0byJ0R48
	 KhdMEm+qy0wkNW1w4mgiHdR7xEvYs4JSkivIl8KqtR2AdgdP8hPWf6FEY89NWtJDOM6G5
	 BxrOZduLlKeCcYawoXGXpBhm/CE8EIXDX0WILga/ucmHFWvvQpw79m3SKaljtfeCOvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794080859;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=SYcjJygf+sJY+ufopYfdJKIVnGnyP9gSuN2/MpdkeWI=;
	b=rPimgLHYrvum/dqpRnojdkDi7poWWGLMtjyX/7LEp2Tz/f9UOSFaF9XvpUKUZuISecFW
	 /qIQhv7+mYcJi4hObX8KNk88RD2svpyLyGI+B0+39UcEw2TCOT7hHQBdCiZ75+T08FaGP
	 PLUSa/dV9uJ90aHd2BqQZcPGQhTagCN0hCl64lSw0VpbkgFVlP6vqa2aUehpP8qqbAbiJ
	 lHybLosrmT6uNarZxpWqcpooZImUVNGhxUdoJ7EICbe/WslBnb4P5Q1F7PsQSotPwngtV
	 xioR8Mk46cuiBwBFcYAYlbiYzrLVCrk+SqA4mp60C2mB4mC9JHUTQ1t02Q9mRKnJhBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=HS8K8tB4;
	arc=none smtp.remote-ip=209.85.215.199
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF8B606D815
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 19:47:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DF8B606D815
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=HS8K8tB4
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cd66551e02cso1849772a12.2
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 11:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794080859; x=1794685659; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SYcjJygf+sJY+ufopYfdJKIVnGnyP9gSuN2/MpdkeWI=;
        b=HS8K8tB46rVV3XK02DYLXjAdcKip8k6Hm5Q9t+XfPBuc9VvckozIH+lZvslrE8FuVj
         Dep1/mj0pYrlWDP/10n3ed8sNOjBNC7wPjjbIM+PCfkDBqiUmQPL2uX/lAlXr1StbIKY
         9N3VooBCrOLen7FIS9I+f6Ip7RRSAQhD/hrOFm0G4DE00qRHeQhxbax8DDnQnx9SGqV0
         pSf0qoT/Sk4JP0c2gGn9GTgEfh6+WvNWj0+vI/KyK96fnndT5wjZV42zK0tDw5pMS7yN
         ZBFo7eFZpInQH9veHNrzGX5jBZlO1+eny9aupqZB3KF+PPWT7eSsKCCCQ+xS80GdiecZ
         JlqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794080859; x=1794685659;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SYcjJygf+sJY+ufopYfdJKIVnGnyP9gSuN2/MpdkeWI=;
        b=xB8h1vuTF5L8Axo6iqC0rGbI2hIWx9RVduPyUcBGAgys6/KJ/MWsjeep74ASww24AJ
         fkoNCQe4C6dr45lXFyeu8l2Cl6IdEtQ4xqWKW9JrBygwSTlNIWOur+pFXImZFWkSRDr8
         cNCXg/sLM+BK0LPF9EyiNSJ0UTPFKrB5ADNdE2mQxSBd9dc6TT7wQwNIyklVVuSUv9LO
         uwJN5gj8GTPTbj3glud7rNNjP4krZv2z9k0IkS3chKBEldlP3FGNEDLLT9KJXoqV1deq
         h/S39TSOkeeeg/DCRXcUcNY/VUvbsb/mR6yCmC8OVd08eW4VBycur8FZreoTLLQEKEhn
         EDqw==
X-Forwarded-Encrypted: i=1; AKwUvBzEjNZ79G+KPpVCrHi8uSHBKac/2IcPXEFvmgvpc/KGmOBUqgrILDbW9+EKIrjrc5qzjoxlmYk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9KOXVeuQhy5cNN4FF8SSvSu5HdqKDxXB9/LHY8p5Ox89rFFQeu
	xHHxpG+N68W59QN84/XTIxoePxiz5RnnI3RoPlNgFDJtwjdvTlCuuOeRhFRrPhuq1omiPfNqPcS
	ztom9jQ==
X-Received: from pgaa23-n2.prod.google.com ([2002:a05:6a02:6497:20b0:cdb:1c92:d2df])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:c206:b0:3ed:bdfd:23a8
 with SMTP id adf61e73a8af0-3edbdfd2488mr2314948637.61.1794080858543; Sat, 07
 Nov 2026 11:47:38 -0800 (PST)
Date: Sat, 7 Nov 2026 19:47:38 +0000
In-Reply-To: <au99DNHQEsaaDqpJ@google.com>
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
 <a951af6957fe4890d3eaaf5a661754fc259a4b79@linux.dev> <au99DNHQEsaaDqpJ@google.com>
Message-ID: <au-AQ7OPf6QPyc3Q@google.com>
Subject: Re: [PATCH] neighbour: Move the netdev_put() out of RCU callback
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Zqiang <qiang.zhang@linux.dev>
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Sat, 07 Nov 2026 19:34:07 +0000, Kuniyuki Iwashima wrote:
> On Sat, 07 Nov 2026 11:47:45 +0000, Zqiang wrote:
> > > 
> > > On Fri, Oct 9, 2026 at 2:19 AM Zqiang <qiang.zhang@linux.dev> wrote:
> > > 
> > > > 
> > > > For builts with CONFIG_NET_DEV_REFCNT_TRACKER=y kernels, netdev_put()
> > > >  records the caller's stack trace via ref_tracker_free() for debugging
> > > >  reference leaks. however, the netdev_put() is within pneigh_destroy()
> > > >  RCU callback, this recorded stack is uninformative, it does not reveal
> > > >  which code path initiated the deletion.
> > > > 
> > > Have you seen pneigh double-free ? What motivates this change ?
> > 
> > Firstly, Apologies for delayed reply.
> > 
> > 
> > 
> > Actually, I didn't see any double-free happening,  just wanted it to
> > record a meaningful callstack which on release path.  After all, if double-free
> > really occurs, the callstack of the RCU callback execution path will not be helpful.
> > 
> > 
> > > 
> > > > 
> > > > This commit therefore move netdev_put() from the RCU callback into the
> > > >  caller's process context, and replace call_rcu() with kfree_rcu().
> > > > 
> > > >  Fixes: d539d8fbd8fc ("neighbour: Free pneigh_entry after RCU grace period.")
> > > > 
> > > Please elaborate why your change is safe in the commit message
> > > and remove the tag.
> > 
> > Does it refer to using kfree_rcu instead of call_rcu ensures safely ?
> 
> I mean why dropping netdev refcnt waiting RCU gp is safe.

*without waiting


> 
> 
> > 
> > Thanks
> > Zqiang
> > 
> > > 
> > > > 
> > > > Signed-off-by: Zqiang <qiang.zhang@linux.dev>
> > > > 
> > > nit: full name
> > > 
> > > > 
> > > > ---
> > > >  net/core/neighbour.c | 14 ++++----------
> > > >  1 file changed, 4 insertions(+), 10 deletions(-)
> > > > 
> > > >  diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> > > >  index 6ed8eb075146..4263689fc415 100644
> > > >  --- a/net/core/neighbour.c
> > > >  +++ b/net/core/neighbour.c
> > > >  @@ -818,14 +818,6 @@ int pneigh_create(struct neigh_table *tbl,
> > > >  return err;
> > > >  }
> > > > 
> > > >  -static void pneigh_destroy(struct rcu_head *rcu)
> > > >  -{
> > > >  - struct pneigh_entry *n = container_of(rcu, struct pneigh_entry, rcu);
> > > >  -
> > > >  - netdev_put(n->dev, &n->dev_tracker);
> > > >  - kfree(n);
> > > >  -}
> > > >  -
> > > >  int pneigh_delete(struct neigh_table *tbl, const void *pkey,
> > > >  struct net_device *dev)
> > > >  {
> > > >  @@ -849,7 +841,8 @@ int pneigh_delete(struct neigh_table *tbl, const void *pkey,
> > > >  if (tbl->pdestructor)
> > > >  tbl->pdestructor(n);
> > > > 
> > > >  - call_rcu(&n->rcu, pneigh_destroy);
> > > >  + netdev_put(n->dev, &n->dev_tracker);
> > > >  + kfree_rcu(n, rcu);
> > > >  return 0;
> > > >  }
> > > >  }
> > > >  @@ -891,7 +884,8 @@ static void pneigh_ifdown(struct neigh_table *tbl, struct net_device *dev,
> > > >  if (tbl->pdestructor)
> > > >  tbl->pdestructor(n);
> > > > 
> > > >  - call_rcu(&n->rcu, pneigh_destroy);
> > > >  + netdev_put(n->dev, &n->dev_tracker);
> > > >  + kfree_rcu(n, rcu);
> > > >  }
> > > >  }
> > > > 
> > > >  --
> > > >  2.17.1
> > > >
> > >
