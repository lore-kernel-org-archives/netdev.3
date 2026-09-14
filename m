Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8AF3BB134
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 12:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789388101; cv=pass; b=NeHlnoiezl0EAszg9vdLPtLpwE/LURohIHRTxobHp7k7O8IyhI3eNuTFvF155Vi1N5ZlnHQL99xPXh+6YgyDbV3SIav3KX7798FaxzI/szbrgbwqw3oyb1UufMqkaQdda8WSqS0bYUXT45IV/p8aQtAypPJ+FI5B3ngmocMKsV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789388101; c=relaxed/simple;
	bh=Tj/OcaerfEeXuzRhZ/dcmUfnvYJQ7hboLb+TXk+NPB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t0HOUxztf0xA3+L+U85WJaDKo+eqaTtSMkMPA2IsQfrB9kTv370oxfrHAFlaqixkY+YWBDBmGSFc/co0VNLtkTfeu+8f+Ag9872xECkN1n8sx39m6jjwkIl3JxYm4YbMhwbdZqMmmKCbYwnC5kwJEHlCfb5xueJGU54xr6o0SoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NOUXmM5V; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOUXmM5V"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c250848d11cso28426566b.2
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 05:14:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789388097; cv=none;
        d=google.com; s=arc-20260327;
        b=YxVBUSAwRcIwPfZ3ON2xHXst2tauoa8aI5fyHcRJ8e7BPdvZCY3eGrSzoKk3OQfLSI
         NPAWcyKBeZqybKXb1gKrA1lvBZaHWie/llOeZLu200Jt6PDQtI+EIb8of0agJNQUFsjW
         34PQz0lIBowht09oRInwopK/k9tpA/VcNXdWr5XRx0Cto6vXK3vXFmUJSaWpzSbzm2Vi
         xu/GLAo9KCyXUZjN3n0RjGqcK0274shduK++YVOyDXAsPPIloa6RJLB2VOrBO7qnhMko
         CABnKnH8nz6h+zWNOfDJUZPF7od8JaitXyz9979woT4WmWgSvf76BVFf2cXASp2sTR9F
         yMQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cRqeXz92gwCYKaS2Yeyk89aPFrtD4fKd/NGfcQVoquU=;
        fh=vTEOAwqn/2aotG5kpyC25M3m0g9/+l5j1Z5YqzRMbsA=;
        b=JYY2kB7rDZK0BRpVXec6LI6m/+i7pK1oQFR/TBdxPWNqFbTHjggmNr+TguKVDVXCXn
         ilfVh4y6I0JZSaeeP1GG5UbnixtBUuzJpRXRkZ5M8mh0nwcKeQfqNcrlfDGI+5uC+oMT
         tiDehYq5+2/S3RXYsnFiVLsPJxUEp1d/j4W+hva99Iso76f821Kiu+riJCnnbgsqWAQH
         KiRQJV6z2olt8G9QAcAa0bcShTS6dlmpMnc7AnUImOxwp9q27m+fzA4TGipDfwhgHYNE
         XY4wY29WJ1jDEC4xvBC34EaoO6J8Kyg8b4GsB3jwldPxKnPuOnnfLvkbOrTh5yU9kgvY
         DU5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789388097; x=1789992897; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cRqeXz92gwCYKaS2Yeyk89aPFrtD4fKd/NGfcQVoquU=;
        b=NOUXmM5VX3iYj64qvaSehi/4ZLfCXVaihuPyK+dPaqIvtgJBpwu5HVK3m70EUYGW/B
         Wgcoc39nl6SuIUKfRA5ACneTN3L8NlSyUb3wfrphH/H8l/xm00zMDgw5+p5YUR48KiYx
         UD39Q61poCxd6ExTe4xgN3xKYHgWHi3bnYEHb//eq7AjkPlUwuJvdUzgc7iVB1nh1U34
         sYiLDCASTdrk9Adzw39lQ0/HamaWh8vJYW6aZ6iW69hqeBrqQRbUzqFQBTsGKvoZ646S
         n2j+uAQ6Zce0NVDiNYz9i/zB+gV7pEGsEn6rb4o0nOJTjiRJSjSe0+ebZ5xguzeHnhgd
         K8sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789388097; x=1789992897;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cRqeXz92gwCYKaS2Yeyk89aPFrtD4fKd/NGfcQVoquU=;
        b=fwIBj9NzbUNjUYckusW/d8/PMncdxN81SXKaPsRmcor4lrBIM+04F8SKW6l9l2FyUP
         q8bG4prHbcKkq9w30eKQlib4nieTUyA+qHoozPEqpINHkJzd83spFMIl80hl7U0OUw8o
         VDHG4GDll1pveT3/y3clydVtUotX2UUGOXVWUlHLnXcDWhQb4j2/UnsIroUHZpAcwkOM
         bddRjABVR44CZ7YP8BhpJ2ReutRjkeM+D8Mg/dSWxEPc737pW0fvYDYtAvT7qeqItLPp
         Sywgr72G6v1N9CGSqYV+60ZkFaV5YNJzWrNHvfl1IyCoAaslVS24aEzec/7fcdtn4yVo
         t4Og==
X-Forwarded-Encrypted: i=1; AKwUvBygvTxvFk8nFcdJrkeJru1A2inLxotfje1Ccr3p60xBMoC4QWL+9d8ceJH53sog75n8WIm2Mjc=@vger.kernel.org
X-Gm-Message-State: AFuF++l4urmhysY1a7oHFY9kAD1BmMibFZ0llIfK3b8/mWL4hDD4pu4L
	4r6bNXeyNFL3Ff0VQRkn+tyXhU2fC1cV0BSDvZlyFhwoAIRvG9xPU1zEhyvZfTDizH9mflyqvML
	vXtbKa1r50D1PsVs2rhVzCBuhaYi29kc=
X-Gm-Gg: AYBFou1q/QERoAdWCz1lgGE/f5eB7p0Cwrood/8tBZscurKlo7kVMjbkBadxJvA6aNI
	PR37aVtNItrpxtiYcjaisBMZpbm6z7o8eSdd8VecwkMMHV/XMliw0CL7COZXvxKFdq3oJJ2plqA
	XiWTmGUqWsphP4Z2q7SPwSclKwz+fqmU4SsR/IxsM3mVEtuttp5rUNTeBpclSEL/z8CR56KDU/c
	4YjJPe4aFtjIwKv2lTJcA27QYEXTxUgAfTeD14AmJEymBj6js4H7+k9mmYA6d87Qjx6GMKc31Wq
	XggSavWhMp1w20EQfJmumWQ+W6ucOSOBFYqQYoZvkjn8kVZBn4p9rBw9fzmiFPTOmCoEe7bfDFW
	iVt6DywXP
X-Received: by 2002:a17:907:1c0c:b0:c16:1290:11a7 with SMTP id
 a640c23a62f3a-c29b83c2175mr184146566b.1.1789388096828; Mon, 14 Sep 2026
 05:14:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907093020.2228346-3-steffen.klassert@secunet.com>
 <20260908224854.1591115-1-kuba@kernel.org> <aqfZNeR58HLm2x1o@secunet.com>
In-Reply-To: <aqfZNeR58HLm2x1o@secunet.com>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Mon, 14 Sep 2026 20:14:44 +0800
X-Gm-Features: AcwNN1WYYoss98qdhY2nNIsXJhYDz2jEQeYuhHkZ-4YQ5067NA7u6o07r4ahDgU
Message-ID: <CAAo+4rWD9GkQuofDJ6Svm_kNxeUTnqogfF-cgTj2VqJgeYogQw@mail.gmail.com>
Subject: Re: [PATCH 02/12] xfrm: serialize state GC with device state flush
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, herbert@gondor.apana.org.au, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 7:23=E2=80=AFPM Steffen Klassert
<steffen.klassert@secunet.com> wrote:
>
> Ccing Author of the patch.
>
> On Tue, Sep 08, 2026 at 03:48:54PM -0700, Jakub Kicinski wrote:
> > This is an AI-generated review of your patch. The human sending this
> > email has considered the AI review valid, or at least plausible.
> > ---
> > xfrm: serialize state GC with device state flush
> >
> > This adds a global mutex, xfrm_state_gc_mutex, taken by the state GC wo=
rker
> > around xfrm_state_gc_destroy() and by the deferred-device pass of
> > xfrm_dev_state_flush(), so the two paths no longer run xfrm_dev_state_f=
ree()
> > on the same state concurrently.  The KASAN slab-use-after-free reported=
 in
> > xfrm_dev_state_free() from xfrm_dev_state_flush() is addressed by that
> > serialization.
> >
> > > diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> > > index 36a4f6793edef..de097bba803b7 100644
> > > --- a/net/xfrm/xfrm_state.c
> > > +++ b/net/xfrm/xfrm_state.c
> > > @@ -226,6 +226,7 @@ static struct xfrm_state_afinfo __rcu *xfrm_state=
_afinfo[NPROTO];
> > >
> > >  static DEFINE_SPINLOCK(xfrm_state_gc_lock);
> > >  static DEFINE_SPINLOCK(xfrm_state_dev_gc_lock);
> > > +static DEFINE_MUTEX(xfrm_state_gc_mutex);
> > >
> > >  int __xfrm_state_delete(struct xfrm_state *x);
> > >
> > > @@ -632,8 +633,10 @@ static void xfrm_state_gc_task(struct work_struc=
t *work)
> > >
> > >     synchronize_rcu();
> > >
> > > +   mutex_lock(&xfrm_state_gc_mutex);
> > >     hlist_for_each_entry_safe(x, tmp, &gc_list, gclist)
> > >             xfrm_state_gc_destroy(x);
> > > +   mutex_unlock(&xfrm_state_gc_mutex);
> > >  }
> > >
> > >  static enum hrtimer_restart xfrm_timer_handler(struct hrtimer *me)
> > > @@ -1000,6 +1003,7 @@ int xfrm_dev_state_flush(struct net *net, struc=
t net_device *dev, bool task_vali
> > >  out:
> > >     spin_unlock_bh(&net->xfrm.xfrm_state_lock);
> > >
> > > +   mutex_lock(&xfrm_state_gc_mutex);
> > >     spin_lock_bh(&xfrm_state_dev_gc_lock);
> > >  restart_gc:
> > >     hlist_for_each_entry_safe(x, tmp, &xfrm_state_dev_gc_list, dev_gc=
list) {
> >
> > [Severity: High]
> > Is the new mutex enough to cover every xfrm_dev_state_free() caller?  T=
here
> > is a third caller in the acquire path in xfrm_state_find() that takes
> > neither the new mutex nor RTNL:
> >
> > net/xfrm/xfrm_state.c:xfrm_state_find() {
> >       ...
> > #ifdef CONFIG_XFRM_OFFLOAD
> >               struct xfrm_dev_offload *xso =3D &x->xso;
> >
> >               if (xso->type =3D=3D XFRM_DEV_OFFLOAD_PACKET) {
> >                       xfrm_dev_state_delete(x);
> >                       xfrm_dev_state_free(x);
> >               }
> > #endif
> >       ...
> > }
> >
> > That code runs inside the rcu_read_lock() taken earlier in
> > xfrm_state_find() (it uses xfrm_state_hold_rcu() on the found state), s=
o it
> > cannot take a sleeping mutex even if one were added there.
>
> That just pointed me to the xfrm_dev_state_free callback of the bonding d=
river,
> it uses a mutex. But this is a different issue.
>
> >
> > xfrm_dev_state_delete() publishes x on the global, reference-less devic=
e GC
> > list while xso->dev is still set:
> >
> > net/xfrm/xfrm_state.c:xfrm_dev_state_delete() {
> >       if (dev) {
> >               dev->xfrmdev_ops->xdo_dev_state_delete(dev, x);
> >               spin_lock_bh(&xfrm_state_dev_gc_lock);
> >               hlist_add_head(&x->dev_gclist, &xfrm_state_dev_gc_list);
> >               spin_unlock_bh(&xfrm_state_dev_gc_lock);
> >       }
> > }
> >
> > so the deferred pass added here, which matches only on xso->dev =3D=3D =
dev, can
> > pick up the same state and call xfrm_dev_state_free() on it in parallel=
:
> >
> >   CPU 0 (xfrm_state_find(), packet offload, km_query() failed)
> >   xfrm_dev_state_delete(x)            /* x now on xfrm_state_dev_gc_lis=
t */
> >   xfrm_dev_state_free(x)
> >     dev =3D READ_ONCE(xso->dev)         /* non-NULL */
> >
> >   CPU 1 (xfrm_dev_event() -> xfrm_dev_state_flush(), same dev)
> >   mutex_lock(&xfrm_state_gc_mutex)
> >   finds x, xso->dev =3D=3D dev
> >   spin_unlock_bh(&xfrm_state_dev_gc_lock)
> >   xfrm_dev_state_free(x)
> >     dev =3D READ_ONCE(xso->dev)         /* also non-NULL */
> >
> > Can both CPUs then run the driver callback and the device put twice?
> >
> > net/xfrm/xfrm_state.c:xfrm_dev_state_free() {
> >       if (dev && dev->xfrmdev_ops) {
> >               spin_lock_bh(&xfrm_state_dev_gc_lock);
> >               if (!hlist_unhashed(&x->dev_gclist))
> >                       hlist_del(&x->dev_gclist);
> >               spin_unlock_bh(&xfrm_state_dev_gc_lock);
> >
> >               if (dev->xfrmdev_ops->xdo_dev_state_free)
> >                       dev->xfrmdev_ops->xdo_dev_state_free(dev, x);
> >               WRITE_ONCE(xso->dev, NULL);
> >               xso->type =3D XFRM_DEV_OFFLOAD_UNSPECIFIED;
> >               netdev_put(dev, &xso->dev_tracker);
> >       }
> > }
> >
> > The hlist_unhashed() test only guards the list removal, not
> > xdo_dev_state_free() or netdev_put(), and dev is sampled before the
> > spinlock, so a double driver teardown and a net_device refcount underfl=
ow
> > look possible.
> >
> > Also, since hlist_del() is used rather than hlist_del_init(), does the
> > second caller see the poisoned pprev as still hashed and call __hlist_d=
el()
> > again, writing through LIST_POISON2?
> >
> > This is the same failure mode the commit message describes:
> >
> >   "Both paths can invoke the driver callback and drop the device refere=
nce."
> >
> > Would addressing the root cause the commit message names -- "The device=
 GC
> > list does not hold an xfrm_state reference" -- be a better fit, either =
by
> > taking an xfrm_state reference for the device GC list, or by making the
> > release in xfrm_dev_state_free() idempotent (test-and-clear of xso->dev=
 plus
> > hlist_del_init() under xfrm_state_dev_gc_lock)?  That would also cover =
the
> > xfrm_state_find() caller, which cannot participate in a mutex-based sch=
eme.
>
> This approach can indeed not solve the problem completely. I tend to
> revert this one in favor of a fix with the above approach. This is
> the destruction path, so a refcount would probably not harm too
> much.
>
> Chengfeng, can you have a look at this?

No problem at all, I will prepare a replacement patch with refcount
fix to completely fix the issue.

Best regards,
Chengfeng
