Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B6D47A863
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 13:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787666018; cv=pass; b=kCnbFWnWDEfJaHs+eW5zzI4rILzo3LpBYJN7K31UjQwHmjR+8elWajaFRnDKYV3bkn0Sf8KiUPQF32o/UBAPoqOr2CdQoAGT9F07VUaYIhQIeJKrfw+FLdCxwk7AHDaZMAaP3OZkBBCmSK/3c5/wYNq+A8+tFNOHJWSEiEB/I7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787666018; c=relaxed/simple;
	bh=UUURwoB9+Pevcje/tzHBVZWY/DSyQqR08FkBIcnYADI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l6W5UUmRisg/B1EBsLpUZ1RcCFwibzUvCyCRXWy8W8s/Y0kCb//7T+At9xHPqAO3golxbZJuirOwljOz15UeRx3XcXq1936Kk4YcI52m6FnyoLL7LifxkvG2mHJUk1uL6x9EGnfyKGsbHMAzUZdrRMjrKHShWodVyP88P9ql0dc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZXv5ND3n; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZXv5ND3n"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51c149c5722so6663031cf.0
        for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 06:53:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787666016; cv=none;
        d=google.com; s=arc-20260327;
        b=Ndxfz/zpEYDTm+hnYUTa1CaCnXQgzPx7ypxB2irELrYA80A79DHJY4YcNBFFj9ildY
         zwiJpjI4b8mwzAhj9G2JIUXwnT6yJX/3FxLZnKPQvuH3LTjc8F3tf2Se/k3AU6rGzjBh
         3PGN8j+Ueus5Iy6m+VATHm4UCbFYkAg+Jqvh0eiuQqmKo2kFeWlxJzruj8rFkITqWwss
         ZCuWo0K3pPFMEN+xaOmWUun17WQZ+ewWFD4pZGOuFL7jD3mrk1t5Prg7jAnDAc4dlzS7
         DZOuHDWOY6EjbYCerGVfJ1JZlNr7zHJzV2QYNigCvpIHceZW2uqnRg2y4t6qLgRsK/8k
         ey1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UUURwoB9+Pevcje/tzHBVZWY/DSyQqR08FkBIcnYADI=;
        fh=y+1H8+vrIQK2T5Q6u7BatEO9S871EQqkFMG+VqmGFAw=;
        b=c/7VwhZY+uqLMjGHfnrf2lBMK1r6V3cqfkjokpoyCLlItTsMQaaHkW5Geh5tqzMAxf
         IWPWQtT+ijG2ia4MXUXNYqtIWMIHhtwtzZLDmUMbRohaX23fi3jeyvPpBRMiOqn27faD
         T0j8Lx1VSYwPP/B02R7Q8vhkPUhlQK61jGpeC8OflBT71CaTjYTiW8QeDwtcxbFUwxsF
         P4q9KQcr0qFqeT9y7wl+fVGv2g2Q0KQepZEeXsYd5uI87ZPAesKX/H7KEENylYGvyC6S
         TIxAcf61rGSNOsFtI52z4ryKyly8PuYgY+j8OpZ+4AQwcSwoNfFc61jVY7AftYawsfrk
         Grew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787666016; x=1788270816; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UUURwoB9+Pevcje/tzHBVZWY/DSyQqR08FkBIcnYADI=;
        b=ZXv5ND3nyHaIHYlmIiom8qMBP8LCfFTqHTW4WSukE3mLtZ34t4Br0Osh22Z+bHtpdc
         m/V8vdBUtZbpk/RGF5vxUfgrkVOH6sj2lsq8y24xTGvIfP9diKeGKqI/eYroSutTszYS
         Nrr/RHDm5SwLkWT6GRJB+ZeH3CizG5m+SnCqFPmXGno5TiTgYJ2AVLoeYrGGzaV0eN1h
         3HKGPI6DVPHvCSq0fcl/nLjp204rutakwoPNVPimWBvkC0guW6RSuk1BWt0cEFnHibHb
         1dGJZWKzkll+4WyQ6B4J56BQ38/pGQd2oHeJAnKVvOKudCev/oXGNM/pFhWhqRzAM/1L
         /Qeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787666016; x=1788270816;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UUURwoB9+Pevcje/tzHBVZWY/DSyQqR08FkBIcnYADI=;
        b=a15/jeTIQlC7vZ6LM521UNsqI+AOD7EGR1oiCdOxWWnkzMZl//wkvmSrxejM6HYrq9
         9x5FvQj6O6VslbreJegK41+qSiTgVnxTd4focx6PZ5ybLiq88ypTCs2XOq36SbsW02GM
         F4xzOYXQwNy5ocHQt00AcPAVerEvHUiGejqDfX1kKah1QTkjRt2Bvu1lYJXEpOwe7S0s
         nMZJH1Iw+qZVcKrOLH01byiUe8pSjizi2yksB8o733cJGsAURm7oC210GUKU6v+MNWjK
         N/Z9UnI01tUDs3aP6WVlX3bIye2DjXR90/Ul014L0x/ft3CyR0NLpTrJJQQax5uIZ2Ho
         0Sew==
X-Forwarded-Encrypted: i=1; AHgh+RqXAUfEEQvVyQalqLtAdahAlmIVfqnitAp5rB49CtjZSc/253aJ/vVBLuEARakYRfnXMFI3bOg=@vger.kernel.org
X-Gm-Message-State: AFuF++mYc1/4AVqRa5p7MFVKZhTCzzKfG6hMhhcbKstgHjLLFvE+n7ol
	tAziI/A3XfcFt3B0dOxZGf4tzxf2EbAfAVp6AJmxRAPZ9N5i3ohfVk/DByeKEuT/sSUemupDHqn
	6nxUBN5sa+0UdIdF/lxkyUh6vAgPbOGq3FLM/tEvA
X-Gm-Gg: AR+sD10KcTGi3mcoOZFWrvXyeDDVNRtXF7smByH91WT2jrpivSg0PszpPFHeGwIUktD
	ggfrk2sCdNtslF560pDEgMojEzxlcbyn5BKdwypdor86WOzCihKRPHBl9HbWfuz5BIMgQeTVUy9
	HEnksih4awPmiWzSiUSvMbWvVrk/1aq8RpXdajANQkY4gTdSXmdILWYWw5lbg12VnBmnjCRUesY
	ABghdpZs/0+siugVAwWtfI38U0fjAdfZJLlHCDv21/7yVX6WWwH3JGU9RwA5K+KaiAzbwWsnSh1
	ZKJ9Hb4CmLClccMVsTyejrnE9C8ZvOf3xR2Lv5hd9FHHfMytNMe4aO4dpLcBLleIOtCGjL3RCHg
	BkSUh3Mo+ozeX0tPOd+sYCBBDSZa3g5Kvg2Mv9sUVYqGtJpmIf0Ud+Opq
X-Received: by 2002:a05:622a:2446:b0:51b:ef78:4062 with SMTP id
 d75a77b69052e-52e2ec997a8mr79461571cf.10.1787666015109; Tue, 25 Aug 2026
 06:53:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ao0mwtt8ePAINFni@shinhome> <20260825064507.1499-1-hdanton@sina.com>
 <ao2WptQpM2zSQHDt@shinhome>
In-Reply-To: <ao2WptQpM2zSQHDt@shinhome>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 25 Aug 2026 15:53:23 +0200
X-Gm-Features: AcwNN1UrB308zS0PjRlBna6WG2jbl1iwdt1gEtx06xm9PB63XHUiHc0HHnkviSQ
Message-ID: <CANn89i+-PHiqn+yKUi=PbwN+qCd6Lr8KY1T6tL7pKPRPmi_67g@mail.gmail.com>
Subject: Re: [syzbot] [net?] WARNING: locking bug in tcp_tsq_handler
To: "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
Cc: Hillf Danton <hdanton@sina.com>, 
	syzbot <syzbot+2d770620059281e225a4@syzkaller.appspotmail.com>, 
	Nilay Shroff <nilay@linux.ibm.com>, Keith Busch <kbusch@kernel.org>, boqun@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, peterz@infradead.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 3:26=E2=80=AFPM Shin'ichiro Kawasaki
<shinichiro.kawasaki@wdc.com> wrote:
>
> On Aug 25, 2026 / 14:45, Hillf Danton wrote:
> > On Tue, 25 Aug 2026 14:44:35 +0900 Shin'ichiro Kawasaki wrote:
> > > On Aug 25, 2026 / 03:50, Eric Dumazet wrote:
> > > >
> > > > I think 19bdb70c77d3 should be reverted.
> > >
> > > Just reverting the commit will reintroduce the other lockdep WARN tha=
t the
> > > commit addressed. I hope to have another fix to avoid the WARN.
> > >
> > I do not think you know the root cause of that lockdep warn, so reverti=
ng
> > 19bdb70c77d3 is the right thing to do because of [11, 12].
> >
> > [11] ffa1e7ada456 ("block: Make request_queue lockdep splats show up ea=
rlier")
> > [12] Subject: Re: [PATCH] nbd: don't warn when reclassifying a busy soc=
ket lock
> > https://lore.kernel.org/lkml/20260816014906.1149-1-hdanton@sina.com/
>
> I took a look in the commit [11] and the discussion [12], but couldn't fo=
llow
> why the commit 19bdb70c77d3 should be reverted. Could you elaborate a bit=
 more
> about the reason you suggest the revert?

I think you missed one problem in lib/once.c

Revert commit e8eef69a99f1 (or restore once_disable_jump(once_key,
mod) inside __do_once_sleepable_done())
so static_branch_disable() is never called synchronously under caller locks=
.

Previously, once_disable_jump() deferred static_branch_disable() to a
worker thread via schedule_work().

Commit e8eef69a99f1 made it run synchronously in the caller's context.
Because __inet_hash_connect() is called under lock_sock(sk), calling
static_branch_disable() directly inside DO_ONCE_SLEEPABLE() takes
cpus_read_lock() (cpu_hotplug_lock) while holding lock_sock(sk).

This created the bogus lock dependency sk_lock -> cpu_hotplug_lock.

Every other storage/networking client (sunrpc, nbd, cifs, iscsi_tcp,
rxe, siw) uses static lockdep keys (static struct lock_class_key
...[2]) without issue.

Use my pending TCP patch, which is a no brainer :
https://lore.kernel.org/netdev/20260825023614.1228551-1-edumazet@google.com=
/

Revert 19bdb70c77d3 in drivers/nvme/host/tcp.c : Restore static
lockdep keys nvme_tcp_sk_key[2] and nvme_tcp_slock_key[2].

And we should be good.

If you think each nvme-tcp socket MUST have its own LOCKDEP class,
please elaborate, because I have no idea
why this would be needed.
