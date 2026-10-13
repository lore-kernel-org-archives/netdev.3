Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9D150255F
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 20:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791923380; cv=pass; b=t6lNbN81D/3A6PDM7lgGwWRdGSz/w3iR7kNqr5MqxKG7wclxVXChDzTuUhm4ERrdPUNU7VYzKYwgY4PNlCbfzhIR6bhaw9G5V5SfjexUU/aU41uiW1wticG2TteDcDMoDxXOjsjVQou9a4wboZBN4baOG3Bubdij5+xaWYcSPM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791923380; c=relaxed/simple;
	bh=XVqXzQiYPDCE5uK56PXto88RdHXke0d8X0VRHkdGqxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mYi59/rNIj7MqQDIDc0qyjMOElM+T/K/GTio7SUO3AQIo82tRkDDaqIdRGs4PJBSVopB85SbSOemoCnAXMEO5DAosmS67V36ngix1pnRFgL4V2lf31nTU8G6PyDBtt3SHhgxsFJaqxD5Bpmy6dynlgWuPwHPbUcxjd+S9PLWW5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KsThN/B3; arc=pass smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KsThN/B3"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-33fb4680717so633846eec.1
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 13:29:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791923378; cv=none;
        d=google.com; s=arc-20260327;
        b=biQCjPwqpanGnpU6hghS5zwKAKzy0CtUKLcABIzyguc2Q06AdBVnpc+CaNBjhgC4uD
         qdAOa2Dv9UlbdpCdmtoHvacJi04aAlq9JnTyboblgmO/DuOEAlIQT7rAWccuYyXhRMea
         RruejiKT72F5a5ftUXcRgO0ho9eoPGaBjlq3GH1bNq5RTKUWn0DJbaQaLRafLIx4fkrN
         0p/tazTPqNZTSwOHeeB5oEBuXzCOfeZB/8VIUdQu3jlSp0Ri01OdzM5FVD2bvtv1PfrH
         cIUp9/hmXcURDmUicRYBwdNRU+ECQYuBYo8uhTOGWVpERkIaFAMPRHw4xDcv0CZiAj24
         YWKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Sgvp/Kl8qf+uRhljOtZsfJPC+NuKpF++/uzkhUunJik=;
        fh=DDrfRn0oZi8EAan4rZHGukNu9IQmMdr7F7hiGZT2pwo=;
        b=cQya/Az1iv3Nh2Qz6Qm+6T8bW3vS/Pe1Vj94EL8DMi1qNezUzs+Nr9RCseSL+aeZ5G
         N5JeY0V4uBxN/WSpmDXlr8u1C+oLisbH5RtRp/sQiIihOle/Fmmf1IqNEVJEPugv84aF
         DBl1zEzLWWxwzXq1YMEkddnsfeQAO046GewyklsYVf+PwKW4ilS7uMn+FWoewZ2WdqYk
         G+Oc2W7vaZY8xXOUp+D1kk26uAQUzpW9nxcXtXnvM5kB5H1FxUlBtLR68hPSrNqZs3Sx
         zNR/bq4Cok0gSTbTwuqpsHQeigOWxyVDHxoPGxOwnPFE+4fueN4wPKVhipboOTLXroeh
         dhcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791923378; x=1792528178; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Sgvp/Kl8qf+uRhljOtZsfJPC+NuKpF++/uzkhUunJik=;
        b=KsThN/B3fO2YI2WB8a3jv4G4XacsOmLhHBitOLxW9QJhgPOOi3IEXfyvrh13NslYvo
         6SkGp/oVI0oNwgrCy2YxCaGf1dhLej4/NQv0T2Md8AjWuYh1laz82RfR3rdfc5HU4rjS
         bz69lJSA6RZbS9xT1SxWUaL7SnOQIsn17iBT79ql9jr1PAF6l0r1TaAI9o5XPXxrLPjz
         3ukrC6gwPPeHOfxdjbQ2/r378CY7u+8ZbtZ1IJ+E58qCrjydixahTURmJBNKgssYtZLE
         O8mEuq/ctMUgB7Jg5QQaySrDZ70YrmsXE32HEvPEsll9sqTInhY/+1rRsZYrzNuDQNmG
         9u9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791923378; x=1792528178;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Sgvp/Kl8qf+uRhljOtZsfJPC+NuKpF++/uzkhUunJik=;
        b=kIRjUCk7m7DpDl6vtFz9aXkWEsIuYQUQZ4I82W6WrqIlv3MUFmiiGvuLHx2W4eIzN4
         QByT0Pfs+mgIq0TLnzPSsCgoi++w7iS7I+JXr3GERPSOwpvlm68uV+e6Qduw3R4TjWY+
         CWA+PvsZGce1wggAZA3Ws6cqjfCODVwYYK/p1Hm3ZHsPE1z+FU/k191bi80PA4bBPEGj
         3P9vKg2S0MF9RIrsV5kuYW7KU84lxzb4zLCNA4Bb47+cKMYo5YBxnazpgF1YgPms9Oq+
         bxV6UqPvv3+I3OO5gus4Epo82EsMNcWwdOR4hIAsxVmtALnKsmP54+TH8eoD9NRngjbf
         CyBQ==
X-Forwarded-Encrypted: i=1; AKwUvBxPbfArrWPSCsSLxpzcbdrdHtrccrNE7vpj9j9veiZwWtmhtRDEGxYiZz/UANUK2rQhohSso3I=@vger.kernel.org
X-Gm-Message-State: AFq9FYJNKTomsi1ZVU0QJNnEtekaphVf7v5iNBxDuYtavNtDXAj61jkj
	8bVXvO1EYIV+Tj7nHwb8LP4o76bm+W+VQa8yH2G/h2LjAS7Jg/JdHL099A6AFZWyctoQhp63Z3y
	XxVzycZCjMG65Zz/Kj07nHBm6jP1AgVSRgeHKUc1U
X-Gm-Gg: AYBFou2T8cJOr2EsUtgBI7CipL92Ipoj0sdrVEV6jw++sIWt2MCLlrnYPtjX2H9WB8V
	6k8oQAj4V4gJM+ReqR/GOvcPfdJoPPZuJa+PhiO4N5PVOOPY2wrxckCaK2ks2pMtZ0Iw39QRmX4
	PNnpvx+N2me1QV+bEmEt1njgasl7dHw99TGbu8sCKt6ZvF6KLciCgDz5hgX7yIOuka5kkAt4A78
	z9zsEZR33oGss4eAiw7U6JcJuixcgOfnb5MCFHDZnUQTdTsyUv8LtIeLeQzWE3nBjxsiLsd/nbY
	n30zTL+ilWETWVJ637XBfHh7umJTb23D2yx9ma8wajC8xRTWRDeLweGk17H1HE4/2pinCl9aO34
	wG55NyJ08boH4yoMY/YiwIPoM/pcqpKpaTcRKnh6tF93DIB0ean9v23Rtl0pOEwbSMNlza+LRB5
	kS6YGlkcyy9zFS5Miq+hx7NQ==
X-Received: by 2002:a05:701b:21d3:10b0:143:296a:3ee with SMTP id
 a92af1059eb24-16a5ef28797mr18830177c88.25.1791923376738; Tue, 13 Oct 2026
 13:29:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012194530.3751034-5-kuniyu@google.com> <179192161164.434549.2046952979938439215@kernel.org>
In-Reply-To: <179192161164.434549.2046952979938439215@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 13 Oct 2026 13:29:23 -0700
X-Gm-Features: AclHuK_ZXwxf4mSb2cS9u-FEKlBtRT2cmbclWf4kEf9dmXDJmigDsc2NUVs1mAI
Message-ID: <CAAVpQUAB9ndSQqBwz=QFhD69wa+57+m+QVN8GX7vm+1Ko-ncsA@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 4/4] neighbour: Floor INTERVAL_PROBE_TIME_MS
 at 1000.
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, idosch@nvidia.com, horms@kernel.org, 
	kuni1840@gmail.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 1:00=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 (1) =C2=B7 Low: 2
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] The patch narrows the accepted uAPI range for
>   interval_probe_time_ms in every netns, including init_net.
> - [Low] The commit message describes a bug fix: a namespaced user can hog
>   CPU because neigh_table is now per-netns and the interval floor was 1=
=E2=80=A6
> - [Low] The sysctl and netlink paths now accept different minimums for
>   the same parameter on kernels with HZ < 1000.
>
> Pre-existing issues:
> - [Medium] This problem wasn't introduced by this patch, but the patch
>   makes it easier to hit.
>
> --
>
> neighbour: Floor INTERVAL_PROBE_TIME_MS at 1000.
>
> This patch raises the minimum of NDTPA_INTERVAL_PROBE_TIME_MS from 1 ms t=
o
> 1000 ms, both in the netlink range policy and in the sysctl handler. It
> also updates the YAML spec and ip-sysctl.rst to match. The reason given i=
s
> that neigh_table is now per-netns, so a small interval could be used to
> hog the CPU.
>
> Link: https://lore.kernel.org/netdev/20260902143023.GA3966681@shredder/
>
> > neigh_table is now per-netns, and a user could hog CPU by setting
> > INTERVAL_PROBE_TIME_MS to a small value.
> >
> > Let's floor the value at 1 second.
> >
> > Suggested-by: Ido Schimmel <idosch@nvidia.com>
> > Link: https://lore.kernel.org/netdev/20260902143023.GA3966681@shredder/
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
>
> [Severity: Low]
>
> Should this have a Fixes: tag?

No, both the commit and this change targets to net-next of this cycle.


> The message describes a CPU hogging problem
> caused by the per-netns conversion, which looks like this commit:
>
> cda2962b6e2b ("neighbour: Namespacify neigh_tables.")
>
> That commit lets RTM_SETNEIGHTBL set the default table params
> (ifindex =3D=3D 0) per netns.
>
> The message mentions 211da42eaa45 and 6d79b223ec44, but it never names
> cda2962b6e2b, and there is no trailer for tooling to pick up.
>
> cda2962b6e2b seems to be in net-next only, so stable is probably not
> affected.
>
> [ ... ]
>
> > diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> > index 6b0569aa5d643..92e3c83c0fe50 100644
> > --- a/net/core/neighbour.c
> > +++ b/net/core/neighbour.c
> > @@ -2438,7 +2438,7 @@ static const struct nla_policy nl_neightbl_policy=
[NDTA_MAX+1] =3D {
> >  #define NTBL_PARM_MS_MAX     (24 * 60 * 60 * MSEC_PER_SEC)
> >
> >  static const struct netlink_range_validation nl_ntbl_parm_ms_range =3D=
 {
> > -     .min =3D 1,
> > +     .min =3D 1000,
> >       .max =3D NTBL_PARM_MS_MAX,
> >  };
>
> [Severity: Medium]
>
> Is the intent to reject these values rather than clamp them?

Yes.

>
> With .min =3D 1000, the range policy now rejects NDTPA_INTERVAL_PROBE_TIM=
E_MS
> values of 1..999 with -ERANGE. This applies in every netns, including
> init_net.
>
> In the same way, min =3D HZ in neigh_proc_dointvec_ms_jiffies_positive()
> makes proc_int_conv() return -EINVAL for sysctl writes below about one
> second.
>
> So commands like these used to work and now fail:
>
>   ip ntable change ... interval_probe_time_ms 500
>   sysctl -w net.ipv4.neigh.default.interval_probe_time_ms=3D500
>
> This removes the sub-second managed probing that 211da42eaa45 added. It
> does so even for CAP_NET_ADMIN in init_net.
>
> The commit message says "Let's floor the value at 1 second.", which reads
> like clamping. Could the message say that values which used to be accepte=
d
> are now rejected?
>
> Another option would be to restore the rearm-time clamp from ed6cd6a17896=
.
> neigh_managed_work() currently uses the configured value directly:
>
>         if (!list_empty(&tbl->managed_list))
>                 queue_delayed_work(system_power_efficient_wq, &tbl->manag=
ed_work,
>                                    NEIGH_VAR(&tbl->parms, INTERVAL_PROBE_=
TIME_MS));
>
> > @@ -3701,7 +3701,7 @@ static int neigh_proc_dointvec_ms_jiffies_positiv=
e(const struct ctl_table *ctl,
> >       struct ctl_table tmp =3D *ctl;
> >       int ret, min, max;
> >
> > -     min =3D msecs_to_jiffies(1);
> > +     min =3D HZ;
> >       max =3D msecs_to_jiffies(NTBL_PARM_MS_MAX);
>
> [Severity: Low]
>
> On kernels with HZ < 1000, does the sysctl path enforce the same minimum
> as netlink?
>
> The range check runs after msecs_to_jiffies() has already rounded the use=
r
> value up to jiffies:
>
> proc_dointvec_ms_jiffies_minmax()
>   -> do_proc_int_conv_ms_jiffies_minmax()
>     -> proc_int_conv()
>
> kernel/sysctl.c:proc_int_conv() {
>     ...
>                 ret =3D user_to_kern(negp, u_ptr, &tmp_k);
>                 if (ret)
>                         return ret;
>                 if ((tbl->extra1 && *(int *)tbl->extra1 > tmp_k) ||
>     ...
> }
>
> With HZ=3D100, a write of 991 becomes (991 + 9) / 10 =3D 100 jiffies. Tha=
t
> equals HZ, so it is accepted. With HZ=3D250, any value from 997 ms up is
> accepted.
>
> RTM_SETNEIGHTBL rejects those same values with -ERANGE. Both ip-sysctl.rs=
t
> and rt-neigh.yaml now give the minimum as 1000.
>
> Before this patch the two paths agreed: 1 jiffy for sysctl, 1 ms for
> netlink.
>
> Would a shared constant, for example msecs_to_jiffies(NTBL_PARM_MS_MIN),
> keep the two paths consistent?

I'll use msecs_to_jiffies(HZ).


>
> [Severity: Medium]
>
> This is a pre-existing issue and was not introduced by this patch, but th=
e
> new floor makes it easier to hit.
>
> neigh_proc_dointvec_ms_jiffies_positive() calls neigh_proc_update() wheth=
er
> or not the write was accepted:
>
>         ret =3D proc_dointvec_ms_jiffies_minmax(&tmp, write, buffer, lenp=
, ppos);
>         neigh_proc_update(ctl, write);
>         return ret;
>
> neigh_proc_update() then marks the parameter as explicitly set on any
> write attempt:
>
>         if (!write)
>                 return;
>
>         set_bit(index, p->data_state);
>
> For a per-device entry, neigh_copy_dflt_parms() then skips that device:
>
>                 if (dst_p && !test_bit(index, dst_p->data_state))
>                         dst_p->data[index] =3D p->data[index];
>
> So consider a rejected write such as this one:
>
>   echo 500 > /proc/sys/net/ipv4/neigh/eth0/interval_probe_time_ms
>
> It returns -EINVAL, but eth0 also stops following later changes to the
> default. Writes of 1 to 999 ms used to succeed, and now they end up on
> this path.
>
> Would it make sense to skip neigh_proc_update() when the handler returns
> an error? The other neigh_proc_* handlers make the same unconditional
> call.
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261012194530.3751034-1-kuniyu%40google.com
