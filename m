Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DF13EA949
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 16:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788540508; cv=pass; b=m4z3wnM1pJJ/QW8U5fXW5Mb6Dn5AULsg1Vm4j6XT9Dw/NZWdYmIclH4a6sq/2JSXE/sTQs4xx701YMGg8b0I/c0cokrMGyT08jyf0wI/cKQ08wecVKEB+tLvANcCuVMFNKAn+awKeY0sZyOP/huj9+8hqbbWrQIvPrk+ZgMJvUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788540508; c=relaxed/simple;
	bh=D6nwsWGdFA1OuaW5ROuErQQ1sqUo/IxOMeGlP5QiK+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ry6YTyXZvZs5UtzyNcXYtTxbdTHFxo1x32AM0i7M1Ro2lQ2RnVzpYaZ/z8/hNo0Zae6/QvPvltgTKvkGD1yqNSN3XeZTS/KJXSybEv7eM/uLuY55zRcZyfMbRx1UEiEcaCAvRxYuA44jv3bOwg7z7mnPfUh1oVzGpCWqIIQqqNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S7wGLqFc; arc=pass smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S7wGLqFc"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6b1b9c3af5cso1084611eaf.2
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 09:48:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788540506; cv=none;
        d=google.com; s=arc-20260327;
        b=sQ+4jwvu0SoOMTNhUJGduvs7++sdIQhMIqua1v/PKXZNqN1/j6QHkCkKTFBcxCUf+N
         tsObPe1gOhd1Iv9xdrgIziw3m22xzklIS2etM9u6k1ECF3zkPm47HURkM1knMppMEsHN
         h1VrOj7CIylBkIwfreTHIzpCVgWepvODxqyCYW0bOvk0AfTzhbWGl0OSRIGOXXEFT3FN
         JuEz+vhfAttY8T8HjmjXHd3AI8MxIr35w8IkaMQPuee8aaIVZCJ4rxna3N++pzz8lCAn
         8g7p+v3UR+AhKERSuaqT70hbKhEPd+1GEjKjSMeqXBHBJWc+I1ypqd4YrdprgWP9NtM/
         xAtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1yO9gNcJdShU19SgDYcoKpCdtQiYT1HITKSi6xtYTTA=;
        fh=882E6rM2dRLgCQZMz03t7OMXMMCU3cbUZFgajII9YdQ=;
        b=TEjZXwU5IKgcAlN5oekTijIY1zHS6sMjHZDEDIh4GruSpPUy8iZtHGDiVhfKxid6cT
         j+dRg8WnrcsSMxOyq6raNwbVt17fJSVD8mNAP1Ukh8/2f/DEkQmmBl0FTQUEpPbWHwZ0
         uz/qyGrBadwJxSKGpoIo4iWRTHtUh59EmlnmInpDQJti/5fACDnSHRoUnXAGjgD+hG8q
         3aHL6QvVnUraQh6T/IPsNxl74JKmMEEK6vPde2abOH3BhcQ044penA/E2/LJv+vemkBe
         PpAO5IX1ypZp6v3sQ92oJn4y+kWcCmy29nTjNNbpgqbQIyS965wmK1wDCEAhDEM5WDWY
         EQYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788540506; x=1789145306; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1yO9gNcJdShU19SgDYcoKpCdtQiYT1HITKSi6xtYTTA=;
        b=S7wGLqFcTbGLBhXTQIsAVc6ObD5V3AnGJeRfgJm5bKHEQo0dbkdDmije9DF548Mu7Z
         JPwrKh+4iUYxtUm7hx51Q3S5U90yaO8ELX/hdS9lTJtMmrWZxds+yjvwEESqmbab8XzA
         aUiFsY1/gMAcvscGP6s5BUGwRyX0HpP27Csk9IY+ZraAtK2s6Zn/TSNgt6AdYuBzifGA
         N3AIkWIGcXM5fDCLxINZJZceVr1noa2ng455e1dDC3x4cT0FfbPyrKMPxWdbb4Z0gvUM
         VnqXHvFXlPpIPr7Vp07uhZnt8tsbx1KhsDHDrmdc21JIt9koDbJfwF8qIGdDZTkmmEPe
         jAPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788540506; x=1789145306;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1yO9gNcJdShU19SgDYcoKpCdtQiYT1HITKSi6xtYTTA=;
        b=LG64mRDE9fyaNp2xBy9MMmbBXE9bD8y/PYjaFAfF1g4EzPp/EIzpeh8DjvJ9z3uzRm
         ZlM8K6hEIZs3btc616g1Nehvf89b49AQkm3ZsOZp9ifJXWzal24hGwkXA1tqVPP1T+UD
         ZDnr9fAKamNDl7P+hzL14DT4TKKlMW+gRBb7uj3PPONqxebhD90aL+QwCdRuKWYz9zIs
         xtlhKD/FLkNfPxCaJM9xfgewxoofpPrLA5PxJq6Kne+O8qR82vjyxhj7TGx19Gf4Bkkv
         Gm68kGQNnhCPUACK/O9BbNjG/1S70ZeZy4m97EqU8m5K98FdeSwf1hxH6+UjujD6v82U
         8Z/Q==
X-Forwarded-Encrypted: i=1; AKwUvBxCbuqDTjTRK+SlDKkhE9s9jedbqmBWGtrcof3DqE5xq4gvr80Fmz7DAK/8r7f1EsJZERZZ+cs=@vger.kernel.org
X-Gm-Message-State: AFuF++kQNO0iAMjk0VnAdsLpVUuuts1Mg9Ezc4aszHxC7nD4wpe/f5eb
	fy0Lo9tjqxlgtvyD+f2FgYmLUDhcrw9IULpqsCa0aVjScZRIh19Jd+7rpezO/rbTafvdKyq+vf4
	+RwIO6DwQLddjHaT3B+k3PuOwtDS4ZZdm2Gyhs0Zi
X-Gm-Gg: AYBFou1/vw4r7gSh60hBJPKUmVW6ppedrXGB7tkYDQNyX/jSg13MFkuTHn7hGsjPWW0
	ozYJo3VzGSRJ+QwusNyPtVFAv0fJncYdVGWbXKRLA2RHNl0FHqLh00vQDvLr2aKAmnR74lAdF8Z
	QtbmJbz5KiCz3W4VsxuAbL3QCN395vxJp0BMnolugWPV7uSAQXf3UbkbghUj3PlhqB8+41YJvX6
	d/nXlGB0PM/m/FAXxhsP6sXKvMCH7mSANvmRikn/v3slMayQsyOMrN8ONutjbtEzZs1Aj7JfrZT
	eLxUWiOD1e3RnWS9+FvgOvaQ2YFahbkF+wNTtLNf7lvgpKeRBoA3yrvEmbgccvePwccRvRFGgnE
	VMQonR/Fp5KY68ZUCIHrJpgMWJKLD5vhuwSnP50CpgUFW1aEnzhKs/9YK1coaAYCEAK74iFbxxf
	ULBSgT77jI87uP
X-Received: by 2002:a05:6820:f034:b0:6b7:46fc:1ce with SMTP id
 006d021491bc7-6b746fc039amr3565703eaf.45.1788540430659; Fri, 04 Sep 2026
 09:47:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902203722.926528-16-kuniyu@google.com> <178849140464.4131868.14135881617308602846@kernel.org>
In-Reply-To: <178849140464.4131868.14135881617308602846@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 4 Sep 2026 09:46:58 -0700
X-Gm-Features: AcwNN1V72lAOUDeARDTYAGuZcQR8eJ_VHhPQCSnzLoJkE05imcEtPoo2ZDP3a_I
Message-ID: <CAAVpQUCcvuRSbieQBX-+NDp+1=g7Ebn0zpUb=gtDOg=r7A=uJQ@mail.gmail.com>
Subject: Re: [PATCH v6 net-next 15/15] selftest: net: Specify netns for ip
 ntable in test_neigh.sh.
To: netdev-bot+sashiko@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, idosch@nvidia.com, 
	horms@kernel.org, kuni1840@gmail.com, netdev@vger.kernel.org, 
	razor@blackwall.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 8:10=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wrot=
e:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 0
>
> - [Medium] The series namespacifies the neighbour tables (commit
>   "neighbour: Namespacify neigh_tables."), and this patch is the=E2=80=A6

I'll follow up on nft_nat_zones.sh, the series already has 15 patches.


>
> --
>
> selftest: net: Specify netns for ip ntable in test_neigh.sh.
>
> Now that the neighbour tables are per netns, this patch converts the
> "ip ntable" invocations in test_neigh.sh to "ip -n $ns1 ntable" so the
> thresholds and base_reachable_time are set in the namespace the test
> actually uses, and drops the comments that described those knobs as
> global resources.
>
> > diff --git a/tools/testing/selftests/net/test_neigh.sh b/tools/testing/=
selftests/net/test_neigh.sh
> > index 447423713266..e70e31edf633 100755
> > --- a/tools/testing/selftests/net/test_neigh.sh
> > +++ b/tools/testing/selftests/net/test_neigh.sh
> > @@ -240,9 +240,6 @@ extern_valid_common()
> >       # Check that an "extern_valid" entry survives a forced garbage
> >       # collection. Add an entry, wait 5 seconds and add more entries t=
han
> >       # "thresh3" so that forced garbage collection will run.
> > -     #
> > -     # Note that the garbage collection thresholds are global resource=
s and
> > -     # that changes in the initial namespace affect all the namespaces=
.
> >       local forced_gc_runs_t0
> >       local forced_gc_runs_t1
> >       local orig_thresh1
> > @@ -250,18 +247,23 @@ extern_valid_common()
> >       local orig_thresh3
> >
> >       run_cmd "ip -n $ns1 neigh flush dev veth0"
> > -     orig_thresh1=3D$(ip -j ntable show name "$tbl_name" | jq '.[] | s=
elect(has("thresh1")) | .["thresh1"]')
> > -     orig_thresh2=3D$(ip -j ntable show name "$tbl_name" | jq '.[] | s=
elect(has("thresh2")) | .["thresh2"]')
> > -     orig_thresh3=3D$(ip -j ntable show name "$tbl_name" | jq '.[] | s=
elect(has("thresh3")) | .["thresh3"]')
> > -     run_cmd "ip ntable change name $tbl_name thresh3 10 thresh2 9 thr=
esh1 8"
> > +     orig_thresh1=3D$(ip -n "$ns1" -j ntable show name "$tbl_name" | \
> > +                     jq '.[] | select(has("thresh1")) | .["thresh1"]')
> > +     orig_thresh2=3D$(ip -n "$ns1" -j ntable show name "$tbl_name" | \
> > +                     jq '.[] | select(has("thresh2")) | .["thresh2"]')
> > +     orig_thresh3=3D$(ip -n "$ns1" -j ntable show name "$tbl_name" | \
> > +                     jq '.[] | select(has("thresh3")) | .["thresh3"]')
> > +     run_cmd "ip -n $ns1 ntable change name $tbl_name thresh3 10 thres=
h2 9 thresh1 8"
>
> [Severity: Medium]
> This hunk moves test_neigh.sh over to the per-netns form, but should
> tools/testing/selftests/net/netfilter/nft_nat_zones.sh get the same
> treatment in this series?  That script tunes the same knobs from the root
> netns:
>
> tools/testing/selftests/net/netfilter/nft_nat_zones.sh {
>         ...
>         setup_ns gw srv
>         ...
>         sysctl -q net.ipv6.neigh.default.gc_thresh1=3D512  2>/dev/null
>         sysctl -q net.ipv6.neigh.default.gc_thresh2=3D1024 2>/dev/null
>         sysctl -q net.ipv6.neigh.default.gc_thresh3=3D4096 2>/dev/null
>         sysctl -q net.ipv4.neigh.default.gc_thresh1=3D512  2>/dev/null
>         sysctl -q net.ipv4.neigh.default.gc_thresh2=3D1024 2>/dev/null
>         sysctl -q net.ipv4.neigh.default.gc_thresh3=3D4096 2>/dev/null
>         ...
> }
>
> With the namespacified tables, neigh_sysctl_register() points those ctl
> entries at the per-netns table and registers them in that netns:
>
> net/core/neighbour.c:neigh_sysctl_register() {
>         ...
>                 t->neigh_vars[NEIGH_VAR_GC_THRESH1].data =3D &tbl->gc_thr=
esh1;
>                 t->neigh_vars[NEIGH_VAR_GC_THRESH2].data =3D &tbl->gc_thr=
esh2;
>                 t->neigh_vars[NEIGH_VAR_GC_THRESH3].data =3D &tbl->gc_thr=
esh3;
>         ...
> }
>
> and the only inheritance from init_net is a one-time snapshot taken when
> the namespace's table is registered:
>
> net/core/neighbour.c:neigh_table_inherit() {
>         ...
>         tbl->gc_thresh1 =3D READ_ONCE(init_tbl->gc_thresh1);
>         tbl->gc_thresh2 =3D READ_ONCE(init_tbl->gc_thresh2);
>         tbl->gc_thresh3 =3D READ_ONCE(init_tbl->gc_thresh3);
>         ...
> }
>
> Since nft_nat_zones.sh runs "setup_ns gw srv" before writing the raised
> values, do the gw and srv namespaces still end up with the compiled-in
> defaults instead of 512/1024/4096?  If so, the raised thresholds are a
> no-op for the gw namespace that actually holds the per-veth neighbour
> entries, and the gate in neigh_periodic_work():
>
> net/core/neighbour.c:neigh_periodic_work() {
>         ...
>         if (neigh_table_entries(tbl) < READ_ONCE(tbl->gc_thresh1))
>                 goto out;
>         ...
> }
>
> applies with the unraised limit, which can make the nft counter checks
> come up short once the entry count grows (the script's own comment
> suggests raising maxclients to 2000).
>
> The cleanup() function in the same script restores only the root-netns
> values, which would likewise no longer affect the namespaces that ran the
> test.
>
> Would moving the sysctl writes above "setup_ns gw srv", or issuing them
> with "ip netns exec \"$gw\" sysctl ...", be the intended conversion here?
>
> [ ... ]
>
> > @@ -284,10 +287,6 @@ extern_valid_common()
> >       # collection. Add an "extern_valid" entry, add more than "thresh1=
"
> >       # regular entries, wait "base_reachable" (longer than "gc_stale")
> >       # seconds and check that the "extern_valid" entry was not deleted=
.
> > -     #
> > -     # Note that the garbage collection thresholds and "base_reachable=
" are
> > -     # global resources and that changes in the initial namespace affe=
ct all
> > -     # the namespaces.
> >       local periodic_gc_runs_t0
> >       local periodic_gc_runs_t1
> >       local orig_base_reachable
>
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20260902203722.926528-1-kuniyu%40google.com
