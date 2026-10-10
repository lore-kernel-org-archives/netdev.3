Received: from mail-lr2-f1.google.com (mail-lr2-f1.google.com [74.125.230.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594423B27CE
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 08:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791621751; cv=pass; b=hcZeBHU1lUKtZx+C8ivqKppr6AEUC6CMMMfi3rhFMoBvhpjyoInKzLXiECONJqbnvtIio64aAcEi1WxJufYFKA/99dtetB7URIf1AH6V7QEkAj6liQFyguAl8r2dUhGKYy26wLnDEmUKaremzQTHiYfS+KKomh6vesl04rnBO8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791621751; c=relaxed/simple;
	bh=kEAJK6t3AaZ4TJkaGOBguzXov8/MwYCD79SWLuU4BkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CgeRo+XE6EoOQuAKbB6epjgdZsgo8Q2sM5tnBRN/hFiQIunHup7j5J3JkCBVTszXVgppmxBx+CtJL+HHEubyW810Jdo0XEm1Sh/C2N+hIQwNgwRm9JKrH4jqWDmfdXT0byKBsJCXm0U49KvPh/IIFwat0CE7YUxw1AUG+wMF2VY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TIswBr1N; arc=pass smtp.client-ip=74.125.230.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TIswBr1N"
Received: by mail-lr2-f1.google.com with SMTP id 38308e7fff4ca-3a772511049so4207641fa.0
        for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 01:42:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791621744; cv=none;
        d=google.com; s=arc-20260327;
        b=i58EBhwGDMpP86jVJxv/G+T5UBVZ59HKDf2Fz3x1bwMkhRh7VaQC5K1zgGZEhSnylB
         1t7NrTv5mcY5CbBewgHRNmZ85gdqPFnhNQ6xmJR6pw3Wiy/Q4p0hMOVw3w4cOkT/383x
         IVbjcICqvwUpe2J7kLr0iEqA8ZoU9ebPUSXvmxdQmhouCojvzWLVZzqjS5yxs5dcEhrt
         CncMU73oT9UcFXa3ftUuSWrS8g/ZSzRQr3u3H8j6icuDlgwES4U0JwprDJlU3IVEzZFR
         4JHp70ALZirte6YTupMzWXTDL++VZRqczD8DHrG5yyHkBgtxl+BEPZ17gLyyYbKAxKWh
         t4Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hxPdm0/ojZ2eQ+UMru0TboR+11F27mAMb7+ktQmIsP0=;
        fh=e6qssVQBK/8x5CTPwlZ+hHhLS16a99a5GqgSatF2bTg=;
        b=s7KDNOr0eAS5aBVeyHcSpQxZyHjZ1CdZfB8TMEhkWAkVrhheEkVlgu23YFzwiAP3ry
         mDMhHeR/8he8guewAQ5rmyxooomS97sAbZdMu8iKK+/KqOdwz8rJad6pjmKvvvLYUp8E
         Z8gv3UN10OiGbvgRZsnvOSlVt8Iiixgb1U0UfehCNStfaoe3nMJOFwD6k2L8/hpqd9/4
         lY6eok6Mk93oEXHef98+z950Y2q/jFBhcnFfkrA/ryFt+dIJ8+3VsC0UI9lOxJyfpuQs
         DRjJJd2wGVgPb328KotYoyrnRSHbLNHoslxE22bMyDfgKL21QT35Gm1t6CqLfKmEJwKb
         FNBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791621744; x=1792226544; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hxPdm0/ojZ2eQ+UMru0TboR+11F27mAMb7+ktQmIsP0=;
        b=TIswBr1NpfD6xTwQxmkWUE7h0fcIvUpWUHRuAp0JPN0/vOCUfAUOzHq07I3OhF5DE3
         ClKZcBkBf24UvybFmAuUUw1CY7N3vu6eRiS5+jiBvzgOft8Blh4UzFEB2quT46+cjdey
         J9ZMJhVWbCZgBwid9+ynPW9XrTMyLf+j7+6J0mQnHca5nAKmvPj1w3jmYwbqUCJGjhaH
         ijoFOHhWd5pEwxAqC1HvOj33YfYJ/EWGql5lBDzMDCDc4ektk4VkN8IRS9oORBFQPe6s
         9kKIngnYxRhkbnuYdHYfN8kdJ1EHHWdxea6ffkILpYENRMq5jJSAJST9sMjIhgXWm1M7
         ZlCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791621744; x=1792226544;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hxPdm0/ojZ2eQ+UMru0TboR+11F27mAMb7+ktQmIsP0=;
        b=zxvK2usDZvOHaYHx6bGx0oxKkffaHGIDBMEj7m3fseZLPkajSgqbQm9gVHC1KJoXSp
         +C8zM17Ht3QXx/FSxIh9Bp7cM03Rr62lNz19djZdKQnGOeGInqjql+LFM0ndwA4xc+lW
         +vWL7eZCeX/4xhuyPTBEO33yk+6w9HuysHMoEpudgCeG2g8mciCEVjMZr8EinwmRg/BT
         LLjW6GKQWbY/ItOYZgrSngH8ILn2fonGoc6r7qxhG6n28i9IqyTSSI8lcvek1BR2AmwA
         xbvDmPVbgD5gM2RcHQffnIqmyHCe60Q+YYABhbFgMFAfuuUv7HRxoFy+0nwThYYtn78w
         /tDA==
X-Forwarded-Encrypted: i=1; AKwUvBx8W2NIzry9q7CCJgV+pqWq8Y5a0WMeTbLyFHU0PSJE4dubIGdEv4jPS0Aov9hPSOt/29EURYE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLf1VqbYW5E03fYnqU5wrcGyMkPg/NK4thzvQwMvrgpjbWRe3PB
	jWlTYQh+OvFPfvct5Tr5CJ2/En5LdEowcFmWJ1WWCZfRFW6eE0cXyP+YZZnYw/p4GRs5RdrXbjA
	0YZhn3uAqAHd4BmN5mJiMOD30bXciVVo=
X-Gm-Gg: AYBFou0L7XY7iUVmg05rK9UuBf+S2Eg8I5tfKsnmZ53k2o9CfNf0YYXH/DgnY65ttQK
	XNc44KMqGOCYuf+ZQg+xtNpeIu97eKhHoBezO2dqyN/42fDOQublhCHAVnDndbN3cPPJKmC+Z5R
	i8gjq0mzjp/VuKlOzcOU3cJBwdQcSohDS+tJkhQbNQ0Efd/OOV/S937RyV2b2RtPIGeWYPbSbgo
	PokwjggGr0g0pdX7R3EODFZ8HZ6fZaA3affCve0lwjd5H5MRFhZAYRzihsYOGboGHPTtENDj6Jh
	vg/SUn/WKF5W7yGMYv6L5okBNkSxrUbDAqcAfjRvGjZUcDGY8pdwTBfA+bHl8n5I6Zk=
X-Received: by 2002:a05:651c:a38c:20b0:3a9:8546:ee13 with SMTP id
 38308e7fff4ca-3a9c5749725mr7307421fa.19.1791621743887; Sat, 10 Oct 2026
 01:42:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261010072548.2869465-1-bsdhenrymartin@gmail.com> <CAL4WiipgL26xjM+0+wT-NUVx9ppjQEJj+oShdew-mbzrRVU=dA@mail.gmail.com>
In-Reply-To: <CAL4WiipgL26xjM+0+wT-NUVx9ppjQEJj+oShdew-mbzrRVU=dA@mail.gmail.com>
From: henry martin <bsdhenrymartin@gmail.com>
Date: Sat, 10 Oct 2026 16:42:11 +0800
X-Gm-Features: AclHuK9ooXO3z8yNdOXPx3YQHo9QoaSrA5vIKEzFrmIGtggwd6d08SSXnanZZVQ
Message-ID: <CAEnQdOq+kqpBM4kB6HT-pAVt=LDqJuH3e8t95-OSVsJh2b+gRw@mail.gmail.com>
Subject: Re: [PATCH net] netlink: fix out-of-bounds bitmap access clearing
 stale mc groups
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Nicolas Dichtel <nicolas.dichtel@6wind.com>, Kees Cook <kees@kernel.org>, 
	Ilya Maximets <i.maximets@ovn.org>, Breno Leitao <leitao@debian.org>, Jeff Layton <jlayton@kernel.org>, 
	Kexin Sun <kexinsun@smail.nju.edu.cn>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Eric,

Thanks for the careful review, you're right on all points.

This came from static analysis; I don't have a KASAN report.  For
what it's worth, 32-bit x86 cannot provide one either, since
HAVE_ARCH_KASAN there is X86_64-only, and on 64-bit a reproducer
would need an out-of-tree family to push the table past the initial
bitmap.

v2 corrects the Fixes tag to 84659eb529b3, scopes the changelog to
the actual reachability (32-bit kernels with in-tree families, at
module unload) instead of implying generic corruption, and drops
Cc: stable.

Regards,
Henry

Eric Dumazet <edumazet@kernel.org> =E4=BA=8E2026=E5=B9=B410=E6=9C=8810=E6=
=97=A5=E5=91=A8=E5=85=AD 16:26=E5=86=99=E9=81=93=EF=BC=9A
>
> Le sam. 10 oct. 2026 =C3=A0 09:26, Henry Martin <bsdhenrymartin@gmail.com=
> a =C3=A9crit :
> >
> > netlink_realloc_groups() sizes nlk->groups to the number of groups
> > that exist at bind/ADD_MEMBERSHIP time.  When more multicast groups
> > are registered later (e.g. a new genl family), existing sockets keep
> > their smaller bitmap.
> >
> > __netlink_clear_multicast_users() however iterates every group of
> > the departing family and calls netlink_update_socket_mc() for each
> > socket on mc_list, which does test_bit()/__assign_bit() on group - 1
> > with no regard to nlk->ngroups.  A stale socket therefore gets bits
> > read and cleared past its bitmap allocation, corrupting whichever
> > heap object follows it; the corruption repeats on every family
> > unregister.
>
> Do you have a KASAN report, or is this from static analysis only ?
>
> nl_table[NETLINK_GENERIC].groups only grows when group ids no longer
> fit in mc_groups_longs * BITS_PER_LONG.
>
> On 64bit, 59 ids are free in the initial bitmap. I count 58 genl
> multicast groups in the whole tree, 4 of them using reserved ids
> (ctrl, quota, pmcraid, NET_DM), so 54 dynamically allocated ones
> if every family was loaded at the same time.
>
> I do not see how a 64bit kernel with in-tree families can get there.
> 32bit kernels could, and then only from genl_unregister_family(),
> i.e. at module unload.
>
> The check itself looks fine and matches what do_one_broadcast()
> does, but the changelog should describe the real conditions instead
> of suggesting a generic heap corruption.
>
> Unless you have a reproducer, I think this is net-next material,
> without the Cc: stable.
>
> >
> > Skip groups that lie beyond the socket's bitmap: such a socket could
> > never have joined them.
> >
> > This issue was discovered by Tencent CodeBuddy Security.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: b4ff4f0419ae ("[NETLINK]: allocate group bitmaps dynamically")
>
> This commit did not add netlink_update_socket_mc() or
> netlink_clear_multicast_users(). This should be
>
> Fixes: 84659eb529b3 ("[NETLIKN]: Allow removing multicast groups.")
>
> > Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
> > ---
> >  net/netlink/af_netlink.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
> > index 9fdf964224ab4..8cc655aa927f1 100644
> > --- a/net/netlink/af_netlink.c
> > +++ b/net/netlink/af_netlink.c
> > @@ -1657,6 +1657,12 @@ static void netlink_update_socket_mc(struct netl=
ink_sock *nlk,
> >  {
> >         int old, new =3D !!is_new, subscriptions;
> >
> > +       /* A socket whose bitmap predates this group can never be a mem=
ber;
> > +        * don't touch bits beyond its allocation.
> > +        */
> > +       if (group - 1 >=3D nlk->ngroups)
> > +               return;
> > +
> >         old =3D test_bit(group - 1, nlk->groups);
> >         subscriptions =3D nlk->subscriptions - old + new;
> >         __assign_bit(group - 1, nlk->groups, new);
> > --
> > 2.43.7
> >
