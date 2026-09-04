Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845E54D2ED0
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 19:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788549540; cv=pass; b=d6gh0nkdwgHDlYwioYFKb/Xdn46mLu6bDAaBFeydo8/Xdudf83CHTUZqaLenYWWMCcBpdCFqo9R9YR1PMW28zj/MdPqp8wCH/DevNWtGlvXF8+uEFiTbWrdfTj3DHcppgAKlC35TraMLcrJYHx2R4HDbFEE1nFsbM8SihMqHP0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788549540; c=relaxed/simple;
	bh=T8oGRVZetWW4BSbiptnI+0JfOFjftBlNlKsV291GxEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PnxD/ps95RSXRdTmjhC0Zt9VifiRyQ8sJxV8vCEXRNej5L4Tlsco0ApWSzFVoM4paa7IvNcw4CCMhm897esWLvWCgOEHQJQ6YFuf9Sk9/aGmRRFJ4kYmd/CTTNlvUJvQoLW+WcaQft3yFQUuejf3Ng8KjYx7lL4K/ugJbnz1eEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=uFz2pet5; arc=pass smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="uFz2pet5"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-862815e2683so546116b3a.2
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 12:18:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788549536; cv=none;
        d=google.com; s=arc-20260327;
        b=mMAL8ucyWsfaawI6reK4OQn+HcyppXyGQH6QwemuYD6zZD8IuDfvc3j/DNkdO4//el
         g199JrAbt5oqDkrBS098DtMQwLTv2YmdKBIM8+ss52f063gVI3z6yVTpSEBaQrYetgQI
         OH8WLdWxyo3hsVBqthrqirBKoXAFCMX78voykI8lnJ4Ijuu8lIMO/rSDDKJb+isnnBhG
         Ud+7mcU4ZWi9jFW+qc5UY3nQLheCEyN/a/DE04doffEv8S+SDTKkNP7aOrdSeQrvK92W
         IZ7b5Q7y4YY29zey/5PE5lxDrnl9HqV/osku8N4Typmbs+UTa7ZKWYpFR7kKVPBlZTDm
         8jaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NjP2g4bpBWdK8v/XQipjZnBq2wtvRo6JQJKPDpSexCo=;
        fh=aH7unqQfjsgTIXSweCBi0reLtRrkOGHxIK9w+YdQl7g=;
        b=dQC2sZK1vXk+b0+J8wSmwlMjna4zwbCtONRpLqbo7/Pp1MgQmLKHKxk38U1mUDu1U3
         ZGe8NCGuTbHZS7MJnh+BU5MY/fy+K3EjWI++26OpNVKuEpAzkMYOjJ3OCoZwnpszjb4Q
         N/2d7DA33S9klOBfi2on807abCFIKJ4q96oG8a1rCUyXUQye7DyXszZHLuGl0XD9sG8p
         +TiRMEoOuq9275C0m8KEgbyjaPW5GhnojZ9py8pMxTWSzRNN1d73Q5GlZBhCaA+GO/R7
         pNfQx0GRKslUHzs6lw//A3Lgzrt/lyDXIWCAhPq17hw/UzETf+BtHjWEg1W8Qau6h7EX
         sBJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1788549536; x=1789154336; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NjP2g4bpBWdK8v/XQipjZnBq2wtvRo6JQJKPDpSexCo=;
        b=uFz2pet5V+1Sq6H5E90V3CifmKP8YRE32/teZ4ILFwzGGDv5Sie7ESXPpqQg5RsT/t
         cY1r8rIIVeTY8LWlOzt1ovKaKohoHEYIC2hcs66dIRT/FXCTQZc0ZUAxDdyxBtQLuZDK
         Rk1LMjceEeZLbHuwV858s9Co8zpxRPff5YskQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788549536; x=1789154336;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NjP2g4bpBWdK8v/XQipjZnBq2wtvRo6JQJKPDpSexCo=;
        b=DnJNl9cLDaQbHN+MnsVx3iSoqVy9cnStAF+9S1JncBPl/9HWyHesOgob3CBJYh5lcE
         Ajbb4Ac+/hVKyG/5p24KfoLjG4SdKNLjQ8Ql+68a2R+6k6ibTHxqHoirqE79qeJGbXLB
         lBlPWxF/fNy+sg967Irvx++NtVSJUC817/uAf4RceEzHbzcL7X/8N07ZKYBc9Qh7Xuhr
         wf9NfoUdZV9kjaPNRlyYYIWCx3RP8DLJlzqB/tn6t/ksZBVjT84/6ZxdOnJSZSTTSKxn
         hqmnN3yZaDnhjQ3tFwflPGO89YWszDVihWmZctsb69x/HkVp9ECtxWJNWlyNCqhUdHG3
         qt/Q==
X-Gm-Message-State: AFuF++nw9LSncFr8FcdauOSVbvnuiBpkf1888BwfmRaYe6U8YHIBPS+G
	uwL/novqpP2j/vfZc43Bv4thMC2lgvW1ORwHJYOK82TWFSx6neBWodgqpTxx+CRfdq4nvBrPbSE
	UWEVaa+PDcgoAUjT31Pad7MPP3ljI5h0cOPvY9sJ7ZTq7XK8viHMaPXRk
X-Gm-Gg: AYBFou1EvzzW8TKZPOda5Eqc+EgfNBaRHzN/tqs0UwOyY2hWP6obDHgnF8o4tp18epu
	knn5oxCOzMymP/Ug5UdSQUsF5+AbR7gDiUwPS8Q9LsgzguQttt6p0sQgBfdKF1bIKIfAlxuVzxS
	mZDqS1Ba5S6qCF/A93k45Cce7BOKleuHDL+GGyEQ8R3U1JNKaRCiDAyuk+Iv3jtDTE5LznnP9S9
	25wdaUn1NBycDgNrPnnvUsvPqc+TOod4FxMiP4OJNK2/f5Vq7MEUHuQj4MAO3YCWC7TliuydCRB
	nUOPkNqIygY+iKLA+qVf6wMZUCRyxmG6U0dDdzELm2Hnnn5kRmVJH0oetKiisCffLhLqzSptlQ9
	xwtkRT5GMZSV+uHEyQ8DNh7M=
X-Received: by 2002:a05:6a00:400e:b0:84e:e741:174f with SMTP id
 d2e1a72fcca58-861669c6df9mr13575676b3a.7.1788549536465; Fri, 04 Sep 2026
 12:18:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-0CFC.v3.20260901204856@mojatatu.com.7> <178851496747.4131868.17944512399699900309@kernel.org>
In-Reply-To: <178851496747.4131868.17944512399699900309@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 4 Sep 2026 15:18:42 -0400
X-Gm-Features: AcwNN1WqxnmG7XJP9xus-rjvXfHWjN_e7YaJplwGyG90ehZAnfEN97msYOXBnTM
Message-ID: <CAM0EoM=NzniseZ=5LDAmoRBWXzwYDF6t6QACxt1t51zAH=86+Q@mail.gmail.com>
Subject: Re: [PATCH net v3 6/9] net/sched: pie: clamp psched_mtu in pie_drop_early
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	victor@mojatatu.com, vega@nebusec.ai, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org, toke@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 5:42=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wrot=
e:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 0
>
> - [Medium] The commit message's "Conditions to recreate the bug" section
>   does not reproduce the described bug.
>
Valid
The clamp fix correctly hardens the mtu=3D0x80000000 case; the
changelog's reproducer and premise need the `ip link set mtu ...` step
instead.
Documentation-only fix.

Note: same wrong-reproducer issue as patch 5 (dualpi2); both
changelogs blame a stab path that psched_mtu() never reads.


cheers,
jamal
>
> net/sched: pie: clamp psched_mtu in pie_drop_early
>
> The patch clamps the value returned by psched_mtu() in pie_drop_early() t=
o
> the range [1, 1<<20], with the stated aim of preventing a very large devi=
ce
> MTU from zeroing the bytemode drop probability. The change itself is a
> one-line clamp_t() in net/sched/sch_pie.c.
>
> >     pie_drop_early() calls psched_mtu() with no clamp. With mtu=3D0x800=
00000
> >     the bytemode divide silently zeroes the drop probability, disabling=
 AQM.
> >     Clamp to [1, 1<<20].
> >
> >     Conditions to recreate the bug:
> >       CONFIG_NET_SCH_PIE=3Dy. Requires CAP_NET_ADMIN (namespace-local v=
ia
> >       unshare -Urn suffices).
> >
> >       tc qdisc add dev dummy0 root pie
> >       tc qdisc change dev dummy0 root pie stab data 32768 size_log 15 c=
ell_log 0
>
> [Severity: Medium]
> Do these two commands actually reproduce the described condition?
>
> The clamped quantity comes only from the netdevice:
>
> include/net/pkt_sched.h:psched_mtu() {
>         return READ_ONCE(dev->mtu) + dev->hard_header_len;
> }
>
> Neither "tc qdisc add ... root pie" nor "tc qdisc change ... stab data 32=
768
> size_log 15 cell_log 0" changes dev->mtu or dev->hard_header_len, so dumm=
y0
> keeps its ether_setup() defaults of 1500 + 14 =3D 1514.  That is already =
inside
> [1, 1<<20], so clamp_t() returns the same value and the reproducer sees n=
o
> difference before or after the patch.  Shouldn't the steps include someth=
ing
> like "ip link set dev dummy0 mtu 2147483634" (which dummy allows, since
> dummy_setup() leaves dev->min_mtu =3D 0 and dev->max_mtu =3D 0)?
>
> Also, does the size table have any bearing here?  A TCA_STAB table only
> affects qdisc_skb_cb(skb)->pkt_len via __qdisc_calculate_pkt_len(), which=
 is
> already capped:
>
> net/sched/sch_api.c:__qdisc_calculate_pkt_len() {
>         ...
>         pkt_len =3D clamp_t(int, pkt_len, 1, QDISC_PKT_LEN_MAX);
>         ...
> }
>
> and pie_qdisc_enqueue() does not use it as packet_size:
>
> net/sched/sch_pie.c:pie_qdisc_enqueue() {
>         ...
>         if (!pie_drop_early(sch, &q->params, &q->vars, sch->qstats.backlo=
g,
>                             skb->len)) {
>         ...
> }
>
> Finally, the divide the message blames is gated on bytemode:
>
> net/sched/sch_pie.c:pie_drop_early() {
>         ...
>         if (params->bytemode && packet_size <=3D mtu)
>                 local_prob =3D (u64)packet_size * div_u64(local_prob, mtu=
);
>         ...
> }
>
> and bytemode is off by default:
>
> include/net/pie.h:pie_params_init() {
>         ...
>         params->bytemode =3D false;
>         ...
> }
>
> Since the listed commands never pass bytemode, is that branch ever reache=
d in
> the reproducer?  Could the "Conditions to recreate the bug" section be up=
dated
> to raise the MTU and enable bytemode, so that the Tested-by tag correspon=
ds to
> a sequence that exercises the clamped value and the divide?
>
> >  {
> >       u64 rnd;
> >       u64 local_prob =3D vars->prob;
> > -     u32 mtu =3D psched_mtu(qdisc_dev(sch));
> > +     u32 mtu =3D clamp_t(u32, psched_mtu(qdisc_dev(sch)), 1, 1 << 20);
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/QDISC-0CFC.v3.20260901204856%40mojatatu.com
