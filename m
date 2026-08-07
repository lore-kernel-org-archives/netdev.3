Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6EF285CAA
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 18:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786127067; cv=pass; b=IKVaW52GIgUMo54xMdYE4NqGQ50tkKbQgUo4ssRFLhyBLby/sAX5UDi1WjjHyjDJzzXlgQdMLmKS5Gx1G1bO4mKKlVhRZpPG/LqsIDn2CJQ9MhNsstZ0lhVWsJV+l/lviv+L7mx/DpTiq23lqIQ8MQ9HOm2H7ONQnIkbbjEhaMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786127067; c=relaxed/simple;
	bh=UADlG41M5thctfgmS6ugHJOYzI+CaH8VYjB2Qk3aRNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dOB2Q3JYm1L5HSUvuiwWV6F4nkXyeMDJRfp6VyCl3KPcC62dXAQ6dtsrXL9wObjaw6QhZxT4kf5cRPMKLWqMhYU+b3oyMv4/KbA0b1EkAVRdGz7W4TLOM2pl3DLKQ24E22rF/ljks1Bry1J9anLUn/0jdXtRkX6pBfJB9gYRhWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ioCk6end; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ioCk6end"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-69fdfd98eb8so484710a12.0
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 11:24:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786127064; cv=none;
        d=google.com; s=arc-20260327;
        b=DVole/eX2qGaQ58vjr0Wj3vDxhv0VWZsZ8sqlEQOWkCk4yZr8Y2clmZGukBFoTpF/L
         ZAoKRI1ba/5DRTpxxYXkCBLIupmVlTCRs2s2W70fSrlQ8anqwlLjopfdVP2F0fk6JnAE
         RLg6ttkaQR8W3ZxK6Ih8I9yREg/0jwhEjg5pqdm9Dz/H0OgJcnYGvPOiQQUpCLQ7P+Hd
         k2tkTnq00kuHd+9Eo2AP/2cQG8QfXBW3cdnf3Iun+yZZUqiY7hrshiJxegGTgIAmn+ys
         w5BVccgqiGTHikxdh/2PFe1gN1puixrB/AI05S6ZqF5wc9jA9ljf2YSOaoZk+o667uQy
         m6FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dUwOEzdPWu8zymOmaEkTRLskubFdeih2HqEaKUwkN9U=;
        fh=HVTf/0nozg3QsO1uWkPnOLDUrzRgKCa0AIfwrysg1hg=;
        b=aWCJlfQEmOz0hrgxPIZnxc+/DcTFev7ZgdHXFE4xosBAU8G38IJAZcQ+ZZp6bDotiI
         owlxvOul7yV/rTwJu5Mv24d0WgTlS2tACVWd3kvXD3pVFmb8OFk8GUgGOHCMj+y7JL65
         hHYLOsbFLzRckQ16QAqVTELlIzj8L+1IDUvKsfuy64fUjULqjEdciwQzHY+39DNUOyIC
         WaAXpBxnr6LKjlHRwYrQIl79pmXZnUB0nhXgtg+W8THU1qvOl4UQ2pL7a0Vxs5oEkmG+
         QfcLhunMoLV8MkW22dM/bspK5HEttzRv9+9y2RLKjYv03hJ81sBxFuDoCnO2z/BE+pUM
         7xyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786127064; x=1786731864; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dUwOEzdPWu8zymOmaEkTRLskubFdeih2HqEaKUwkN9U=;
        b=ioCk6end2dn+UqrfP957/XtBBb/DfUq9jKeFNZQR88jZ4m1nk04Jo01MkbVPWNIk14
         YXkw0VcaG4Xd7JSTImEM2wKrJ5O1WitfVP2ZUKydNx/GhaL9NUW1ts+/MepeyvOVsfHf
         zPHPEDZuWiqvq/2C8BOKufVWwbKMHzDmrCZD+pHah+tUnfNbOfUxEoeJkctmwm6n8+MV
         GvASyll0vxpkSB+wqQor/3ETU4eL5oE+JUpRn4Nys2xG+D2P1Qk3+3y6X5xIxbPNBb5Q
         pOQJKPqAIgEGSFJuxnMNC1EWBuVe4TUw4oUX7iD/iEWPiqR6yvDL1y1Kc1X/K+uCPIgJ
         KRLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786127064; x=1786731864;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dUwOEzdPWu8zymOmaEkTRLskubFdeih2HqEaKUwkN9U=;
        b=iU8Ooo4JmEeVyFXZvvBq25wzA7BRXgd8SK2CDPhkYN2ppsU2TdIT3Up8q3F+sCfElM
         V6NfLD98ilwLBbF2lKA74P9su5O/W7mzZPiB4Hv8g7l1dOxwDTcAYi5s0X8G2OIi+QWy
         pqh5rMHrTuiqKncpiJzhAqAsDMtWNRNfK5NznUBrDXJ6rJcHHIQyDfu5ogymytP35fHi
         V/z5lioWh/dhjX9yO4YuJnzD9lwkX8pWFP8G2nPQCEC6HB/qz9QgYvg+BXS1ysjKxuLc
         GmwJw0s2SD0k+GPjge1xRZkSFeYR0LFMHcKSti5Hcb2u4TNO/eWEBut8fxXKwEptTGu7
         0z/A==
X-Forwarded-Encrypted: i=1; AHgh+RpJdy9sX9XTn+4EzQAlG9WGdcls3kM6XxMF4A1r2yz/kTQi2U0qyUro2GLx6HGWUQcNqL3w5rY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLunGYGNngSbmFVjS0y48ggEJS/8+NGNY4Y/Ssk6fzTp+nAYwq
	a7U8A+y3kiPDUXzvuZXLOHo03Rl2DPg2gP31zEFannRZ7wcISSQjUlFQMG4rnOuotAuhjdtnRjI
	/agNop+3O5ZvuYsRabE2zuWaIFiHD1Pg=
X-Gm-Gg: AR+sD10zYFcXIs4yAeRkNjkuEtX6+O/sMfcl8rK4Nlw6VovY8ALLiCR07DH3vnioqYt
	pmUGn2UzS+tX3XDX668MSCW2WWsgyvR9U80Hb2t67U5OsZXwV2ZyTZ1xzYj18Vgtc0zNHSeZe7n
	PABYkqszYHshbCwXB3oQJnBMFPoYBGo7/AK/qt2i6i/DFIwq1HcyPTcuwoAFPCm3AiwUp4oGc+k
	XW1g0FWps8ob70Ly+dwhjVRBecrF/IOBa14QpNggzvmE85LdzkRoNcQOzY+pnA/0DZ4F/uxG1/J
	Y9L9PzJNTRZI61ICPQmMFnwrWAv5Yzzhrelzc70iCC9mBc4KPKiEwJ7UYye0Z36wR6ejP0Djhg=
	=
X-Received: by 2002:a05:6402:3506:b0:6a0:f1f9:e026 with SMTP id
 4fb4d7f45d1cf-6a14f2a66a8mr6336836a12.4.1786127063387; Fri, 07 Aug 2026
 11:24:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806133309.731709-1-nicoyip.dev@gmail.com> <20260806144225.GA1940054@shredder>
In-Reply-To: <20260806144225.GA1940054@shredder>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Sat, 8 Aug 2026 02:24:10 +0800
X-Gm-Features: AUfX_mwI3opsf-KUy5fEjZu1-_oNK5jjwxAyCm7penD7Up_h_DON19HI2hd2OA8
Message-ID: <CAAo+4rUVQkHhKupHOx-x4dq+qxkeeqs+nS=OK0pELZVzgeWTgw@mail.gmail.com>
Subject: Re: [PATCH net v2] ipv4: fix use-after-free in fib_nhc_update_mtu()
To: Ido Schimmel <idosch@nvidia.com>
Cc: David Ahern <dsahern@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Stefano Brivio <sbrivio@redhat.com>, 
	Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Ido,

No problem, the patch looks really good, and I just posted it as v3
with a few minor comment wording changes. Thanks again for your
detailed reply.
https://lore.kernel.org/netdev/20260807181710.1178747-1-nicoyip.dev@gmail.c=
om/T/#u

Best regards,
Chengfeng

On Thu, Aug 6, 2026 at 10:42=E2=80=AFPM Ido Schimmel <idosch@nvidia.com> wr=
ote:
>
> On Thu, Aug 06, 2026 at 09:33:09PM +0800, Chengfeng Ye wrote:
> > fib_nhc_update_mtu() walks the nexthop exception table under RTNL, but
> > RTNL does not serialize this walk with PMTU exception updates. The walk
> > uses rcu_dereference_protected() with a constant true condition without
> > holding fnhe_lock.
> >
> > The following interleaving can therefore occur:
> >
> >   CPU 0                              CPU 1
> >   fib_nhc_update_mtu()               update_or_create_fnhe()
> >     load fnhe                          spin_lock_bh(&fnhe_lock)
> >                                        fnhe_remove_oldest()
> >                                          unlink fnhe
> >                                          kfree_rcu(fnhe, rcu)
> >     <quiescent state>
> >     access fnhe after grace period
>
> [...]
>
> > The same walk updates fnhe_pmtu and fnhe_mtu_locked. These fields form =
a
> > pair and other writers serialize them with fnhe_lock. RCU alone would
> > prevent reclamation, but would still allow concurrent writers to leave =
a
> > mixed pair.
> >
> > Expose fnhe_lock to fib_semantics.c and hold it across the exception-ta=
ble
> > walk. This prevents entries from being unlinked while they are visited =
and
> > serializes the paired PMTU state updates with all other writers.
>
> Looks correct, but can't we use RCU for the traversal and only acquire
> the global lock when updating an entry? Otherwise, whenever a device MTU
> changes, we acquire the global lock (and disable softIRQs) across a scan
> of 2048 buckets and we do that for each nexthop using this device.
>
> How about something like [1] (vibe coded, compile-tested only)?
>
> It also avoids exporting the global lock.
>
> Please wait at least 24h before posting v3.
>
> Thanks
>
> [1]
> diff --git a/include/net/route.h b/include/net/route.h
> index f90106f383c5..45290177a33c 100644
> --- a/include/net/route.h
> +++ b/include/net/route.h
> @@ -276,6 +276,8 @@ int fib_dump_info_fnhe(struct sk_buff *skb, struct ne=
tlink_callback *cb,
>                        u32 table_id, struct fib_info *fi,
>                        int *fa_index, int fa_start, unsigned int flags);
>
> +void fnhe_update_pmtu(struct fib_nh_exception *fnhe, u32 new, u32 orig);
> +
>  static inline void ip_rt_put(struct rtable *rt)
>  {
>         /* dst_release() accepts a NULL parameter.
> diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
> index 4f3c0740dde9..61286948c5d9 100644
> --- a/net/ipv4/fib_semantics.c
> +++ b/net/ipv4/fib_semantics.c
> @@ -1864,42 +1864,30 @@ static int call_fib_nh_notifiers(struct fib_nh *n=
h,
>         return NOTIFY_DONE;
>  }
>
> -/* Update the PMTU of exceptions when:
> - * - the new MTU of the first hop becomes smaller than the PMTU
> - * - the old MTU was the same as the PMTU, and it limited discovery of
> - *   larger MTUs on the path. With that limit raised, we can now
> - *   discover larger MTUs
> - * A special case is locked exceptions, for which the PMTU is smaller
> - * than the minimal accepted PMTU:
> - * - if the new MTU is greater than the PMTU, don't make any change
> - * - otherwise, unlock and set PMTU
> +/* Walk the exceptions of a nexthop after its first hop MTU changed.  Th=
e
> + * chain is only RCU protected here, fnhe_update_pmtu() takes fnhe_lock =
for
> + * the update of each entry.
>   */
>  void fib_nhc_update_mtu(struct fib_nh_common *nhc, u32 new, u32 orig)
>  {
>         struct fnhe_hash_bucket *bucket;
>         int i;
>
> -       bucket =3D rcu_dereference_protected(nhc->nhc_exceptions, 1);
> +       rcu_read_lock();
> +       bucket =3D rcu_dereference(nhc->nhc_exceptions);
>         if (!bucket)
> -               return;
> +               goto out;
>
>         for (i =3D 0; i < FNHE_HASH_SIZE; i++) {
>                 struct fib_nh_exception *fnhe;
>
> -               for (fnhe =3D rcu_dereference_protected(bucket[i].chain, =
1);
> +               for (fnhe =3D rcu_dereference(bucket[i].chain);
>                      fnhe;
> -                    fnhe =3D rcu_dereference_protected(fnhe->fnhe_next, =
1)) {
> -                       if (fnhe->fnhe_mtu_locked) {
> -                               if (new <=3D fnhe->fnhe_pmtu) {
> -                                       fnhe->fnhe_pmtu =3D new;
> -                                       fnhe->fnhe_mtu_locked =3D false;
> -                               }
> -                       } else if (new < fnhe->fnhe_pmtu ||
> -                                  orig =3D=3D fnhe->fnhe_pmtu) {
> -                               fnhe->fnhe_pmtu =3D new;
> -                       }
> -               }
> +                    fnhe =3D rcu_dereference(fnhe->fnhe_next))
> +                       fnhe_update_pmtu(fnhe, new, orig);
>         }
> +out:
> +       rcu_read_unlock();
>  }
>
>  void fib_sync_mtu(struct net_device *dev, u32 orig_mtu)
> diff --git a/net/ipv4/route.c b/net/ipv4/route.c
> index fd688e1f879f..604cc51dfd9b 100644
> --- a/net/ipv4/route.c
> +++ b/net/ipv4/route.c
> @@ -741,6 +741,35 @@ static void update_or_create_fnhe(struct fib_nh_comm=
on *nhc, __be32 daddr,
>         spin_unlock_bh(&fnhe_lock);
>  }
>
> +/* Update the PMTU of an exception when:
> + * - the new MTU of the first hop becomes smaller than the PMTU
> + * - the old MTU was the same as the PMTU, and it limited discovery of
> + *   larger MTUs on the path. With that limit raised, we can now
> + *   discover larger MTUs
> + * A special case is locked exceptions, for which the PMTU is smaller
> + * than the minimal accepted PMTU:
> + * - if the new MTU is greater than the PMTU, don't make any change
> + * - otherwise, unlock and set PMTU
> + *
> + * fnhe_lock keeps fnhe_pmtu and fnhe_mtu_locked consistent against
> + * update_or_create_fnhe(), which sets both under the same lock.
> + */
> +void fnhe_update_pmtu(struct fib_nh_exception *fnhe, u32 new, u32 orig)
> +{
> +       spin_lock_bh(&fnhe_lock);
> +
> +       if (fnhe->fnhe_mtu_locked) {
> +               if (new <=3D fnhe->fnhe_pmtu) {
> +                       fnhe->fnhe_pmtu =3D new;
> +                       fnhe->fnhe_mtu_locked =3D false;
> +               }
> +       } else if (new < fnhe->fnhe_pmtu || orig =3D=3D fnhe->fnhe_pmtu) =
{
> +               fnhe->fnhe_pmtu =3D new;
> +       }
> +
> +       spin_unlock_bh(&fnhe_lock);
> +}
> +
>  static void __ip_do_redirect(struct rtable *rt, struct sk_buff *skb, str=
uct flowi4 *fl4,
>                              bool kill_route)
>  {
