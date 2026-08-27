Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78093515FD
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 20:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787862009; cv=pass; b=boGchOXumcN9HMcr9iM86Wejg9SYhALbDGu5sm/00ht8DyZVmXvYSTfHy+IQ3IGnb85iWNQvr41lWpwtc4dgaAWGu0oVOORmqnswEYpNVZPRnMRNWq5ssG0Smk9zt5MLFrEziS9dpdX+uJGb6nipbvtbjcmC/6BNlYXJrR0OaaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787862009; c=relaxed/simple;
	bh=UFXbwh2YATaGQLwLaYnAEHvXczLZLu/rkc15DcEYUQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BBubJtKwIwb3Ssy/2t7UEuyS9JQ36uyD05x4zonkfzzizHeQJeXjUVKOecIhKXPtximqoYX5M9NOIU5ItUCEO+ivnAz856s6bsVa4hJZIl0I7ZTJbGl8FLE/r3E2itUJBrKLgstYCAzc1FbGjE/EMufBiyNaKfp2HUlmKDmKNJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wcbAbdgK; arc=pass smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wcbAbdgK"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-93905b1dc65so17343185a.1
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 13:20:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787862006; cv=none;
        d=google.com; s=arc-20260327;
        b=e5GKrger/pujukT99m+FhtuQ/FA4ys6EPziUyCw29l3hIZqn6lZ3UobUPE1419ZkV9
         PdJ/r06A+Sh6hWsev8Cy/ls/to5TYDgGbDli7b6cZgiR8R8hB/e0rudFxvOcJ/1xpx/7
         yXPQxl3ej5m0n2XAH47D6d9hJMXzIdK0phlXDzlQVWS7w0YCe5VR5S9VBNy+ZmdF99SY
         WwhAQuCOUT3tfrqm0X/YZoB23iilJGOdt/WWhh/TM48DVPNKxiDXomGtIIXz2acfDKLB
         amJvheK5e3tLrdabQPgnKRK1k30rrndoJVxBCZBbHyYA09RBcI4l5EsibX5D9Ri2mAzk
         vW1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=H9gikPsaHb+VfXTVOgFeI7CInjo15Ppi/dkMhDvN+wA=;
        fh=iTXNXZtogvafzrtG9tIAAU8MHSVruBtkR7sVpOJ4dp4=;
        b=jVjHIVZMX6+gzMQJCWAzzYJoiMRIzM0g4LOIfNffm3nj4cKRQ7WmspGjrptjN5yBQ+
         IQpctD0Tv0ZszqldP92/jSEQWNAwDiW826ns7MrkB4RydY6G4lWyFcRs3sWnihaQ2pHt
         Z5VpioEqOItgCvsji3HVgC88Nex+YY4ViVw32BUYRnSxuj2uoOfJj5vi5Z9W54KcMmYC
         jmTuGg7C+uwPGRqusnwev9tDLcZmjeTKxRMziJHz50Enkd2CMcxc2z5qD4U7WBAX/nRa
         L09gZjymPB6zUX8oqZCAcLAtXXznK/DG4rvHTQOnaywASurM+Dm86UIRTkblCqY4uyfD
         rHxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787862006; x=1788466806; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=H9gikPsaHb+VfXTVOgFeI7CInjo15Ppi/dkMhDvN+wA=;
        b=wcbAbdgKrjawE92vPnmHgoQTRZ5WHAL1TkowTuuVqTbgzhfb7Cuf42IUyEnXaVlhZA
         0w71i90ic+5lwV05GJ3R2fceXMvPb8JadvaSVRI+VeZj75P+XH9ql6tELAOBMGLnRLcU
         eS6L1RYlLLQE9aAiXy5JejZIo5Td+9z7yM5WnLQJ7zyv6PM7qi9YZy0ZIIyI3B6ajdCW
         vmF1ZHA/sDrTQR2yhWa9KPot19YzywOBfEdEW2XVcvBuxYFqltVVUNhzwR42rbJZeKYS
         +maOS6cFvdRG54sxsgLAy70CiozFNdgTDDmMm/mGoT44nx/J2tR8LGXICpwITsTi1pKg
         TGUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787862006; x=1788466806;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H9gikPsaHb+VfXTVOgFeI7CInjo15Ppi/dkMhDvN+wA=;
        b=M8wL50MdMZCxQZLQWZl6X4wWTgmgk36kbCRWLot5t6gDEdCfDi98jet6Sw/9lkiqWI
         JBTwMstf3eMPkFFRVsyvObzgeJi8KUHKy3eVSt5+MDr0rcX/LCzASZHVL1Z6JboPk4WF
         JrZjxnVgh7noUcfpMTlcNjJduILQMw00Mdn/WRYwRvxSt2cucyk7WRJFJkVadym6Ie9N
         EqFGZuvd68IL7+ulwz2G+ODtAEZxgbd8nJAyPJe5kc1DiEE/tGPbqhx+KomBlxcry+B4
         KP/wOej+NntFdfya0j4uX3PYqsxb5wL7Yu/vmFC8NwIvnlhAktbFKrRs+ZXStntoSaFW
         WS6Q==
X-Forwarded-Encrypted: i=1; AHgh+RrJk3uWyn3oiu0ddcGzAM1gSGPW/Rz4Oic+ye9NxUzN49Ao7MMGw1SuibVuU0420qTLjMYSNzk=@vger.kernel.org
X-Gm-Message-State: AFuF++n/8aa/nudA73JernB2xYSMqiGn4EDnXzVTkuZ8C+P3+nnNSUu1
	0DI0qkKfyGSxnWA4z7F8BEs2Ppo6Th3MwEbS7Hfy3KpsN9x0mAX7jQBCAmaHDsIEZwjM/mqzdF/
	5CEFZjI16nz9l2kc9zWlmKNqR0bhOdV6prQwXGNf9
X-Gm-Gg: AR+sD10mIHTVfffrRgXuf70TTpWAe/1sQacYTGfHEC0S3C+pEg9czLgAJ40vHzxziGn
	w4jS3izVVCJHMpjZ1bB5fUb4bNNxACCGuhE6n0T0MUR37PVAFhmr15bLote3gGRz65HH/aZlKR+
	NX7E2eFM3fdye+0CQVR13dEsVdIWGjfJR/4ROP/33pkDlKVKSWGQuEaHDXCIgcK8FxpzgTMlIFP
	VQVYA1uZpJd29qxHyYwLsdyg+lnHdxOt5IPV18iYMqS3RgHV1rTkN2SATecfchUOxiA3hOM+UH9
	m/40EQFEuGxBslw9Ikf5Vv77k9EslEynxSCqm93XP1ZLIsUwDozrt/zfNpz9r993Fl73x+/SgVr
	rmuSvaGkannGa5YT5iiTTThvzcPaku6u+73/bcPc27HvdNtQBih8HQmC7kSQp
X-Received: by 2002:a05:620a:2995:b0:92e:54b3:3f86 with SMTP id
 af79cd13be357-9391392e99amr140062785a.29.1787862005614; Thu, 27 Aug 2026
 13:20:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826103711.3302915-3-edumazet@google.com> <20260827194258.4022962-1-kuba@kernel.org>
In-Reply-To: <20260827194258.4022962-1-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 27 Aug 2026 22:19:54 +0200
X-Gm-Features: AcwNN1UdExY0LqriM6OZfdDSkekHvCpXWDVcScdT4FKllDItQ6nps33ppsRDb7w
Message-ID: <CANn89i++X6UUpACK+Bq9d+qbiu1NQ=Ynz75OQgbWjUHNyu-S8Q@mail.gmail.com>
Subject: Re: [PATCH net 2/5] ipv6: mcast: use copy-on-write RCU updates in ip6_mc_source()
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, horms@kernel.org, 
	idosch@nvidia.com, dsahern@kernel.org, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 9:43=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> ipv6: mcast: use copy-on-write RCU updates in ip6_mc_source()
>
> This converts ip6_mc_source() from in-place mutation of pmc->sflist to
> copy-on-write: a new ip6_sf_socklist is fully populated before being
> published with rcu_assign_pointer(), and the old one is freed with
> kfree_rcu(), matching ip6_mc_msfilter(). The unused IP6_SFBLOCK macro is
> also removed.
>
> > diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
> > index ec7fac511c8d5..40e996f36c373 100644
> > --- a/net/ipv6/mcast.c
> > +++ b/net/ipv6/mcast.c
>
> [ ... ]
>
> > @@ -424,58 +422,75 @@ int ip6_mc_source(int add, int omode, struct sock=
 *sk,
> >                       goto done;
> >               }
> >
> > +             if (psl->sl_count =3D=3D 1) {
> > +                     newpsl =3D NULL;
> > +             } else {
> > +                     newpsl =3D sock_kmalloc(sk, struct_size(newpsl, s=
l_addr,
> > +                                                           psl->sl_cou=
nt - 1),
> > +                                           GFP_KERNEL);
> > +                     if (!newpsl) {
> > +                             err =3D -ENOBUFS;
> > +                             goto done;
> > +                     }
>
> [Severity: Medium]
> Should removing a source from the filter be able to fail with -ENOBUFS
> now?
>
> Before this change the !add path only shifted psl->sl_addr[] down and
> decremented psl->sl_count, so MCAST_LEAVE_SOURCE_GROUP and
> MCAST_UNBLOCK_SOURCE could not fail.  Now a shrinking update needs a
> fresh sock_kmalloc(), and the old buffer's charge is released only after
> that allocation succeeded:

Good point, in V2 I adjusted the sk_omem_alloc accounting to deduct the old
charge before calling sock_kmalloc().

Since the new allocation is strictly smaller than the old one, shrinking a
filter will not hit the optmem_max limit.

>
>         newpsl =3D sock_kmalloc(sk, struct_size(newpsl, sl_addr,
>                                               psl->sl_count - 1), GFP_KER=
NEL);
>         ...
>         atomic_sub(struct_size(psl, sl_addr, psl->sl_max),
>                    &sk->sk_omem_alloc);
>         rcu_assign_pointer(pmc->sflist, newpsl);
>
> so the peak sk_omem_alloc charge for the operation is old + (old - 16).
>
> sock_kmalloc() in net/core/sock.c rejects on the sum:
>
>         if ((unsigned int)size <=3D optmem_max &&
>             atomic_read(&sk->sk_omem_alloc) + size < optmem_max) {
>
> With the default sysctl_mld_max_msf of 64 a full filter is 24 + 16*64 =3D
> 1048 bytes, so roughly 19 fully populated groups reach the default
> optmem_max of 20480 and any further per-source removal returns -ENOBUFS
> instead of releasing memory.
>
> mld_max_msf is also registered with plain proc_dointvec and no extra2
> clamp in net/ipv6/sysctl_net_ipv6.c, so a single filter installed via
> ip6_mc_msfilter() can exceed half of optmem_max, in which case
> per-source removal stays impossible for that filter until userspace
> clears the whole list (MCAST_MSFILTER with gf_numsrc =3D=3D 0 takes the
> newpsl =3D=3D NULL path) or leaves the group.
>
> The IPv4 counterpart ip_mc_source() in net/ipv4/igmp.c still does the
> in-place shift:
>
>         for (j =3D i+1; j < psl->sl_count; j++)
>                 psl->sl_addr[j-1] =3D psl->sl_addr[j];
>         psl->sl_count--;
>         err =3D 0;
>
> Is the resulting difference in error contracts between the two families
> for the same socket option intended?
>
> > +                     newpsl->sl_max =3D psl->sl_count - 1;
> > +                     newpsl->sl_count =3D psl->sl_count - 1;
> > +                     for (j =3D 0; j < i; j++)
> > +                             newpsl->sl_addr[j] =3D psl->sl_addr[j];
> > +                     for (j =3D i + 1; j < psl->sl_count; j++)
> > +                             newpsl->sl_addr[j - 1] =3D psl->sl_addr[j=
];
> > +             }
> > +
> >               /* update the interface filter */
> >               ip6_mc_del_src(idev, group, omode, 1, source, 1);
> >
> > -             for (j =3D i+1; j < psl->sl_count; j++)
> > -                     psl->sl_addr[j-1] =3D psl->sl_addr[j];
> > -             psl->sl_count--;
> > +             atomic_sub(struct_size(psl, sl_addr, psl->sl_max),
> > +                        &sk->sk_omem_alloc);
> > +             rcu_assign_pointer(pmc->sflist, newpsl);
> > +             kfree_rcu(psl, rcu);
> >               err =3D 0;
> >               goto done;
> >       }
> >       /* else, add a new source to the filter */
>
> [ ... ]
>
> > +     newpsl->sl_max =3D i;
> > +     newpsl->sl_count =3D i;
> > +     if (psl) {
> > +             for (j =3D 0; j < psl->sl_count; j++)
> > +                     newpsl->sl_addr[j] =3D psl->sl_addr[j];
> >       }
> > -     for (j =3D psl->sl_count-1; j >=3D i; j--)
> > -             psl->sl_addr[j+1] =3D psl->sl_addr[j];
> > -     psl->sl_addr[i] =3D *source;
> > -     psl->sl_count++;
> > +     newpsl->sl_addr[i - 1] =3D *source;
> > +
> > +     err =3D ip6_mc_add_src(idev, group, omode, 1, source, 1);
> > +     if (err) {
> > +             sock_kfree_s(sk, newpsl, struct_size(newpsl, sl_addr,
> > +                                                  newpsl->sl_max));
> > +             goto done;
> > +     }
>
> [Severity: Medium]
> Is the new error propagation from ip6_mc_add_src() a deliberate part of
> this conversion?
>
> The old code was:
>
>         err =3D 0;
>         /* update the interface list */
>         ip6_mc_add_src(idev, group, omode, 1, source, 1);
>
> so MCAST_BLOCK_SOURCE and MCAST_JOIN_SOURCE_GROUP always returned 0 and
> always installed the socket filter.

To keep this bugfix patch strictly focused on RCU safety and avoid any
subtle changes to the setsockopt() return contract, I reverted this back to
ignoring ip6_mc_add_src() in ip6_mc_source(), matching both the prior behav=
ior
and IPv4 ip_mc_source().


>Two failures are now returned to
> userspace with pmc->sflist left unchanged:


>
> - -ENOBUFS from the interface-level allocation in ip6_mc_add1_src():
>
>         psf =3D kzalloc_obj(*psf);
>         if (!psf)
>                 return -ENOBUFS;
>
> - -ESRCH when ip6_mc_add_src() does not find the group on idev.  That
>   is reachable with gsr_interface =3D=3D 0, since the pmc lookup skips th=
e
>   ifindex comparison:
>
>         if (pgsr->gsr_interface && pmc->ifindex !=3D pgsr->gsr_interface)
>                 continue;
>
>   while ip6_mc_find_idev()/ip6_mc_find_dev() resolves the device from
>   rt6_lookup(), which need not be the device the socket joined on.
>
> The delete branch above still ignores the identical -ESRCH from
> ip6_mc_del_src(), so the two branches disagree.  The commit message
> describes only the RCU publication fix and does not mention this change
> in setsockopt() return values, which matters for the stable backport
> implied by the Fixes: tag.  Would it be worth either splitting this out
> or documenting it in the changelog?
>
> > +
> > +     if (psl)
> > +             atomic_sub(struct_size(psl, sl_addr, psl->sl_max),
> > +                        &sk->sk_omem_alloc);
> > +     rcu_assign_pointer(pmc->sflist, newpsl);
> > +     kfree_rcu(psl, rcu);
> >       err =3D 0;
> > -     /* update the interface list */
> > -     ip6_mc_add_src(idev, group, omode, 1, source, 1);
> >  done:
> >       mutex_unlock(&idev->mc_lock);
> >       in6_dev_put(idev);
>

> [Severity: Medium]
> This isn't a bug introduced by this patch, but the companion field
> pmc->sfmode is still a plain store while the list is now published
> atomically.  inet6_mc_check() consumes both fields together under
> rcu_read_lock() only:
>
>         psl =3D rcu_dereference(mc->sflist);
>         if (!psl) {
>                 rv =3D mc->sfmode =3D=3D MCAST_EXCLUDE;
>         } else {
>                 ...
>                 if (mc->sfmode =3D=3D MCAST_INCLUDE && i >=3D psl->sl_cou=
nt)
>                         rv =3D false;
>                 if (mc->sfmode =3D=3D MCAST_EXCLUDE && i < psl->sl_count)
>                         rv =3D false;
>         }
>
> ip6_mc_msfilter() publishes the list first and updates the mode after:
>
>         rcu_assign_pointer(pmc->sflist, newpsl);
>         kfree_rcu(psl, rcu);
>         pmc->sfmode =3D gsf->gf_fmode;
>
> and ip6_mc_source() does the same kind of plain store with
> pmc->sfmode =3D omode.
>
> Can a softirq receive path then pair the newly published list with the
> stale mode?  For an EXCLUDE{A} to INCLUDE{A} transition a reader that
> sees the new list but the old mode takes i < psl->sl_count and sets
> rv =3D false, dropping a datagram the socket now includes; the opposite
> interleaving accepts one that should be blocked.  Both sides are also
> unannotated, so KCSAN can report the sfmode access as a data race.
>
> Would publishing the mode and the source list as one RCU-protected
> object be a reasonable follow-up?

Yes, bundling sfmode into the RCU-protected sflist struct makes a lot of se=
nse
and avoids the race between filter array and filter mode. I will submit tha=
t as
a follow-up cleanup for net-next once this fix lands in net.

Thanks.
