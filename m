Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E103C42189A
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 15:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786375359; cv=pass; b=W3yN3ci+EtdsBG71hTEvJ+W7IEwBbs+Z0bo+eOZH4HxZACzSzp3b8c1KbDyQSTsQbFbnbkxW8sKLT3mFDfBj3Z/HjfmgZRk5h1uGOBAW1zzTmpEj95asBPblfCosgNXfjxxdN0rWiHCvp1PMvKHAXy1fYPNsKJvLTw4iOu4IdJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786375359; c=relaxed/simple;
	bh=ufgYagn9xq7epv1c1Wjzzj664mNfZAL2lYdPRFW7bo0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BH7CsuWtc8nodvfYiDw8MSruQVbV9o3jBVX6HnT83GLmT559++myoSE+No2Iabxo3KasB+6Cup8jFzcS4WDQSRuuwyxr7/o54rhFrQsnJhkKMIz0OcGlo1ABuxI9Y9qyumtzVfshcPDG++jTdN+Ym/CS7mb7GZ9NPWPzSK4RJSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=FM5kCBsT; arc=pass smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="FM5kCBsT"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5c38568d9e1so834989e0c.3
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 08:22:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786375356; cv=none;
        d=google.com; s=arc-20260327;
        b=r3FzgwQG/TpQmStq3b/nGE6iLRyWcs7+yR4XG9rWBQ7lGgYkC6zJsZGBWruhBWFXa+
         wESXl7v5DzY1qLnpfwx0P+lXld2Lv/J0oQOLWHR+xzaOfSDFHdG6GWPsxvzxF+hRMzlv
         jZRqIqTTnIVq5QedQH/Rh/YpuhaMBfEP40GbDHM20sFbxTVHuXe7CnCCA8MzFPej81js
         tCR7PPdwbBjDg5JK2ThkxwdIQrb1/DI0X0MGFGXcAs/WVXK+/fhbd8euiqOzo0ePgseS
         zTzbJ/Ejmnyj3NZW5givn8b4PUROhUObn58m5/1yBdovs8CZQW3VovpaT0hO81UoywP7
         LESA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ug54hOMeqL/iCgt6RCT0uZABGu1D3tpfZ0Dt6hA9TjQ=;
        fh=C5E4A3aBx9ZUO8DefIa1S1Wthib8j0FhIczY0djkCoM=;
        b=O9t3dWguRY5/g4WQz1JAri32gkHh1VtIt5hCyxA5Mc0wjyqm8Jk/MnWiGAuo/XoiKH
         k5bXWYr3ZONQ3ubJ/7SYXxmp27y0kgmImU1zv5et/RJkfx8j/ZUcbNGZtq0zrYRTqo6S
         36p94QB+p86y+CKNJv90/XlB6IFAlp4Y4qwedM+U2qvsnJBc2Uy4KB61Jm+UAGnaCiym
         6+CYCh2/XcAhOlV43t/QjrgN+f5RiDyhu2GheHwa9tlq3tlq9PCkU8ZULetocqH1ArL+
         EHyGX7ZuclMBT8f4OFR3aWGATkOI8O7+Ib72i+tMpZDEKxAUVnI5PAHWDek8jBrWxIxq
         Rk7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1786375356; x=1786980156; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ug54hOMeqL/iCgt6RCT0uZABGu1D3tpfZ0Dt6hA9TjQ=;
        b=FM5kCBsTjfQaLgIXx4vj4OWdV1BCl5GdZ8ugCnG12x/lMDOQCwqi/2FPPttxSjBE7S
         cLWd6XN+Xe2MrDCn/9+6mwBUu7HIOh1hr7EeMKjjVY4epEuGbOFAQ2TZtalwTSnAwKqH
         hAVTp9WF6veZ4MkX0LQy9RxKwPRsxq1lzS/hJMuJ+vdgpQoDwzJJ1ublSPqpw6w9yg7v
         YCmXhjdPiskGoHbWi9uTPXR2tUEOH7LdfanMPaKDFnsYuJ0wPnVznrB5ITbq02WUDpaG
         XjVmE4diWlmXmt7jvAm8Udo3tn++L9LetulgTGoLQIMKqBWkBC3K6eXct4c8la/v6rM2
         z7mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786375356; x=1786980156;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ug54hOMeqL/iCgt6RCT0uZABGu1D3tpfZ0Dt6hA9TjQ=;
        b=kC47MYtY660O4qv3Yfd1hseNcfWzUh457ioXwa/2RmrDI9Q+vx7EvYIn+eCZZbg3Le
         tveSIcqu7H3wRGfhamcQaXOK3C5y49xPcPHhoCSjW/T4Tgfm5ZrNLzMD8K7qdwDXUjcC
         yWK8/G9n45p8XUSNtUUka6RwZ3I0Rkij/zuFRj4SSDRTsMrF8NIqQ3PcHqriZFGx8NUM
         q4DM2MXbaqmii4cu+Na0VdhQ4VUj3rdm2QVywWy5PsmOEFhYCThApEqPjC+a30TbDdSi
         cHW5RypliYn63nN3PnCRhkTWvOno5AGo/p+N1mOABeS+wAMFwjm/P93bJ675ZWiOJ1c6
         /F8A==
X-Forwarded-Encrypted: i=1; AHgh+Rqp21j5G48uQQCFBBjraYyZWPbp0NKszvmwOIc99soPvBAJeKzGb9B9+b2eho0uBsH+DYufKw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxddykfMxgVnkgwLetuA/ME6BLNhAZyAdcBCy8ud+ce36wLGL7c
	kBNFNPM3eysDV/2h9iKjrSVblyJJvCoQkOx9GUJLTB2So/B/y3gOOXmQph1x9NXw2ifUle0E8O7
	7ROzfePqhuSnAiPS6xQ72Ie/CpySocfSNXZcVJj1Taw==
X-Gm-Gg: AR+sD13o7vi5wT8rbYfIETplJ3Sgp9y32okDQvMvAdr4hR4jYWxSvxUf5wjtISXTxq2
	IXMJcUJcfIxoAqFsnF1YyfcBR003O4jQbcwu9PojtluOOvPdU4gGyqtQVnyb+PL8K2vLuPhrcm2
	fcvqRFasVxtYXyLJ/DyPw8/SldI8b7om9OIomBIF99gxoknPDhwkrWw4aq3f0ATSGBb7ZjBxSpP
	AdLBHRKTYHO6L0YUqS9kpZNs+pbfYctHqnaJvCzKJF3+lXDgUu/hRPH1nwE1gabOz/sNsMULnFw
	qApUkakP1vFw/RCSp26gMTBuE+RvHF8WCjnWY+Ps31WMQ+XVjPV6njw0FO/EyyDU7NxOp7tTjxQ
	ST+0=
X-Received: by 2002:a05:6122:4b05:b0:5c2:b001:db5b with SMTP id
 71dfb90a1353d-5c4418a75afmr321184e0c.6.1786375355588; Mon, 10 Aug 2026
 08:22:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731140533.566493-1-david.lee@trailofbits.com> <CAM0EoM=UDkGKLivsdDS5JaVMuefR4jLC2rAWJcOR8XD-4N_EgA@mail.gmail.com>
In-Reply-To: <CAM0EoM=UDkGKLivsdDS5JaVMuefR4jLC2rAWJcOR8XD-4N_EgA@mail.gmail.com>
From: David Lee <david.lee@trailofbits.com>
Date: Tue, 11 Aug 2026 00:22:23 +0900
X-Gm-Features: AUfX_mzJGFicAMXxlql621DUEputFhcMU6V-cwFY5OvU-UeibVe07KsKU95UiMY
Message-ID: <CAC_etQESLytW5rhp0GfZU-mJqJhwk202a5u_nTXZ7W6wJN=AJw@mail.gmail.com>
Subject: Re: [PATCH] net/sched: sch_qfq: prevent aggregate self-replacement
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, Kyle Zeng <kylebot@openai.com>, 
	"Dominik 'Disconnect3d' Czarnota" <dominik.czarnota@trailofbits.com>, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000008198eb0658b2ecf2"

--0000000000008198eb0658b2ecf2
Content-Type: multipart/alternative; boundary="0000000000008198ea0658b2ecf0"

--0000000000008198ea0658b2ecf0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jamal,

Reproducer has been attached to this email.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Reproduction =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

1. Build Linux at 82a47586c0b9266622657009aa30573dddf09f53
   with the configuration options listed above and KASAN enabled.
   Use a system with at least two CPUs. If QFQ is configured as a
   module, make sch_qfq available before running the reproducer.

2. Build the attached poc.c:

~
gcc -static -O2 -pthread -Wall -Wextra -o poc poc.c
~

3. Run the resulting binary:

~
./poc
~

The reproducer creates user and network namespaces, brings up the
loopback device, installs a QFQ qdisc and class, and races class
changes against packet enqueue. Race timing varies between systems.
On the validated KASAN kernel, the expected result is a
slab-use-after-free report in qfq_add_to_agg(), followed by a kernel
panic. The full observed output is attached as splash.txt.

he issue was reproduced on Linux 7.2-rc3 at:

82a47586c0b9266622657009aa30573dddf09f53

It is also present in Linux 7.2-rc5 at:

f5098b6bae761e346ebcd9da7f95622c04733cff

As of July 27, 2026, the vulnerable sequence remains in upstream
master at:

62cc90241548d5570ee68e01aaba6506964e9811
https://github.com/torvalds/linux/commit/62cc90241548d5570ee68e01aaba650696=
4e9811

Required configuration:

* CONFIG_NET_SCHED
* CONFIG_NET_SCH_QFQ

The attached reproducer additionally requires:

* CONFIG_USER_NS
* CONFIG_NET_NS
* CONFIG_INET

KASAN is recommended to observe the first invalid access.

Regarding the format, I can send v2 if the reproducer looks good on your
end.

Thank you.

Best regards,
David

On Fri, Jul 31, 2026 at 12:33=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:

> On Fri, Jul 31, 2026 at 10:05=E2=80=AFAM David Lee <david.lee@trailofbits=
.com>
> wrote:
> >
> > qfq_change_class() snapshots the current aggregate settings while
> > holding the qdisc tree lock, but drops the lock before selecting the
> > destination aggregate. During that gap, qfq_enqueue() can move the
> > class to an aggregate matching the requested settings.
> >
> > When qfq_change_class() resumes, qfq_find_agg() then returns cl->agg.
> > If it is a singleton, qfq_deact_rm_from_agg() frees the aggregate
> > before qfq_add_to_agg() immediately accesses the same pointer, causing
> > a use-after-free.
> >
> > While holding the tree lock, skip the replacement when the destination
> > is already the current aggregate. Any estimator replacement has already
> > completed, so the class change can finish normally.
> >
> > Fixes: 462dbc9101ac ("pkt_sched: QFQ Plus: fair-queueing service at DRR
> cost")
> > Bug found and triaged by OpenAI Security Research and
> > validated by Trail of Bits.
> >
>
> Please always send a reproducer - either as a tdc test case or if it
> is sensitive send it privately to me and Cc the other maintainers.
> As trivial as this looks I will not look at it without a repro.
>
> cheers,
> jamal
>
> > Assisted-by: Codex:gpt-5.6-sol gpt-5.5-cyber
> > Signed-off-by: Kyle Zeng <kylebot@openai.com>
> > ---
> > Trail of Bits has a reproducer for this bug that triggers a
> > KASAN use-after-free and can share if needed.
> >
> >  net/sched/sch_qfq.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
> > index 6f3b7273c..e900890e9 100644
> > --- a/net/sched/sch_qfq.c
> > +++ b/net/sched/sch_qfq.c
> > @@ -517,11 +517,14 @@ static int qfq_change_class(struct Qdisc *sch, u3=
2
> classid, u32 parentid,
> >                 sch_tree_lock(sch);
> >                 qfq_init_agg(q, new_agg, lmax, weight);
> >         }
> > +       if (existing && new_agg =3D=3D cl->agg)
> > +               goto unlock;
> >         if (existing)
> >                 qfq_deact_rm_from_agg(q, cl);
> >         else
> >                 qdisc_class_hash_insert(&q->clhash, &cl->common);
> >         qfq_add_to_agg(q, new_agg, cl);
> > +unlock:
> >         sch_tree_unlock(sch);
> >         qdisc_class_hash_grow(sch, &q->clhash);
> >
> > --
> > 2.53.0
>

--0000000000008198ea0658b2ecf0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Jamal,<br><br>Reproducer has been attached to this emai=
l.<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Reproduction =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D<br><br>1. Build Linux at 82a47586c0b9266622657009aa30573dddf09f53=
<br>=C2=A0 =C2=A0with the configuration options listed above and KASAN enab=
led.<br>=C2=A0 =C2=A0Use a system with at least two CPUs. If QFQ is configu=
red as a<br>=C2=A0 =C2=A0module, make sch_qfq available before running the =
reproducer.<br><br>2. Build the attached poc.c:<br><br>~<br>gcc -static -O2=
 -pthread -Wall -Wextra -o poc poc.c<br>~<br><br>3. Run the resulting binar=
y:<br><br>~<br>./poc<br>~<br><br>The reproducer creates user and network na=
mespaces, brings up the<br>loopback device, installs a QFQ qdisc and class,=
 and races class<br>changes against packet enqueue. Race timing varies betw=
een systems.<br>On the validated KASAN kernel, the expected result is a<br>=
slab-use-after-free report in qfq_add_to_agg(), followed by a kernel<br>pan=
ic. The full observed output is attached as splash.txt.<br><br>he issue was=
 reproduced on Linux 7.2-rc3 at:<br><br>82a47586c0b9266622657009aa30573dddf=
09f53<br><br>It is also present in Linux 7.2-rc5 at:<br><br>f5098b6bae761e3=
46ebcd9da7f95622c04733cff<br><br>As of July 27, 2026, the vulnerable sequen=
ce remains in upstream<br>master at:<br><br>62cc90241548d5570ee68e01aaba650=
6964e9811<br><a href=3D"https://github.com/torvalds/linux/commit/62cc902415=
48d5570ee68e01aaba6506964e9811">https://github.com/torvalds/linux/commit/62=
cc90241548d5570ee68e01aaba6506964e9811</a><br><br>Required configuration:<b=
r><br>* CONFIG_NET_SCHED<br>* CONFIG_NET_SCH_QFQ<br><br>The attached reprod=
ucer additionally requires:<br><br>* CONFIG_USER_NS<br>* CONFIG_NET_NS<br>*=
 CONFIG_INET<br><br>KASAN is recommended to observe the first invalid acces=
s.<br><br>Regarding the format, I can send v2 if the reproducer looks good =
on your end.<br><br>Thank you.<br><br>Best regards,<br>David</div><br><div =
class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail=
_attr">On Fri, Jul 31, 2026 at 12:33=E2=80=AFPM Jamal Hadi Salim &lt;<a hre=
f=3D"mailto:jhs@mojatatu.com">jhs@mojatatu.com</a>&gt; wrote:<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">On Fri, Jul 31, 2026 at 10:05=
=E2=80=AFAM David Lee &lt;<a href=3D"mailto:david.lee@trailofbits.com" targ=
et=3D"_blank">david.lee@trailofbits.com</a>&gt; wrote:<br>
&gt;<br>
&gt; qfq_change_class() snapshots the current aggregate settings while<br>
&gt; holding the qdisc tree lock, but drops the lock before selecting the<b=
r>
&gt; destination aggregate. During that gap, qfq_enqueue() can move the<br>
&gt; class to an aggregate matching the requested settings.<br>
&gt;<br>
&gt; When qfq_change_class() resumes, qfq_find_agg() then returns cl-&gt;ag=
g.<br>
&gt; If it is a singleton, qfq_deact_rm_from_agg() frees the aggregate<br>
&gt; before qfq_add_to_agg() immediately accesses the same pointer, causing=
<br>
&gt; a use-after-free.<br>
&gt;<br>
&gt; While holding the tree lock, skip the replacement when the destination=
<br>
&gt; is already the current aggregate. Any estimator replacement has alread=
y<br>
&gt; completed, so the class change can finish normally.<br>
&gt;<br>
&gt; Fixes: 462dbc9101ac (&quot;pkt_sched: QFQ Plus: fair-queueing service =
at DRR cost&quot;)<br>
&gt; Bug found and triaged by OpenAI Security Research and<br>
&gt; validated by Trail of Bits.<br>
&gt;<br>
<br>
Please always send a reproducer - either as a tdc test case or if it<br>
is sensitive send it privately to me and Cc the other maintainers.<br>
As trivial as this looks I will not look at it without a repro.<br>
<br>
cheers,<br>
jamal<br>
<br>
&gt; Assisted-by: Codex:gpt-5.6-sol gpt-5.5-cyber<br>
&gt; Signed-off-by: Kyle Zeng &lt;<a href=3D"mailto:kylebot@openai.com" tar=
get=3D"_blank">kylebot@openai.com</a>&gt;<br>
&gt; ---<br>
&gt; Trail of Bits has a reproducer for this bug that triggers a<br>
&gt; KASAN use-after-free and can share if needed.<br>
&gt;<br>
&gt;=C2=A0 net/sched/sch_qfq.c | 3 +++<br>
&gt;=C2=A0 1 file changed, 3 insertions(+)<br>
&gt;<br>
&gt; diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c<br>
&gt; index 6f3b7273c..e900890e9 100644<br>
&gt; --- a/net/sched/sch_qfq.c<br>
&gt; +++ b/net/sched/sch_qfq.c<br>
&gt; @@ -517,11 +517,14 @@ static int qfq_change_class(struct Qdisc *sch, u=
32 classid, u32 parentid,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sch_tree_=
lock(sch);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qfq_init_=
agg(q, new_agg, lmax, weight);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (existing &amp;&amp; new_agg =3D=3D cl-=
&gt;agg)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto unlock;<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (existing)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qfq_deact=
_rm_from_agg(q, cl);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qdisc_cla=
ss_hash_insert(&amp;q-&gt;clhash, &amp;cl-&gt;common);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qfq_add_to_agg(q, new_agg, cl);<br>
&gt; +unlock:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sch_tree_unlock(sch);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qdisc_class_hash_grow(sch, &amp;q-&gt=
;clhash);<br>
&gt;<br>
&gt; --<br>
&gt; 2.53.0<br>
</blockquote></div>

--0000000000008198ea0658b2ecf0--
--0000000000008198eb0658b2ecf2
Content-Type: application/octet-stream; name="poc.c"
Content-Disposition: attachment; filename="poc.c"
Content-Transfer-Encoding: base64
Content-ID: <f_msndpx7b0>
X-Attachment-Id: f_msndpx7b0

I2RlZmluZSBfR05VX1NPVVJDRQoKI2luY2x1ZGUgPGFycGEvaW5ldC5oPgojaW5jbHVkZSA8ZXJy
bm8uaD4KI2luY2x1ZGUgPGxpbnV4L2dlbl9zdGF0cy5oPgojaW5jbHVkZSA8bGludXgvbmV0bGlu
ay5oPgojaW5jbHVkZSA8bGludXgvcGt0X3NjaGVkLmg+CiNpbmNsdWRlIDxsaW51eC9ydG5ldGxp
bmsuaD4KI2luY2x1ZGUgPG5ldC9pZi5oPgojaW5jbHVkZSA8cHRocmVhZC5oPgojaW5jbHVkZSA8
c2NoZWQuaD4KI2luY2x1ZGUgPHN0ZGFyZy5oPgojaW5jbHVkZSA8c3RkYXRvbWljLmg+CiNpbmNs
dWRlIDxzdGRib29sLmg+CiNpbmNsdWRlIDxzdGRpbnQuaD4KI2luY2x1ZGUgPHN0ZGlvLmg+CiNp
bmNsdWRlIDxzdGRsaWIuaD4KI2luY2x1ZGUgPHN0cmluZy5oPgojaW5jbHVkZSA8c3lzL2lvY3Rs
Lmg+CiNpbmNsdWRlIDxzeXMvc29ja2V0Lmg+CiNpbmNsdWRlIDxzeXMvdHlwZXMuaD4KI2luY2x1
ZGUgPHVuaXN0ZC5oPgoKI2RlZmluZSBRRElTQ19IQU5ETEUgMHgxMDAwMFUKI2RlZmluZSBDTEFT
U19IQU5ETEUgMHgxMDAwMVUKI2RlZmluZSBUQVJHRVRfTE1BWCAxNTAwVQojZGVmaW5lIFVEUF9Q
QVlMT0FEX0xFTiAxNDU4CiNkZWZpbmUgSVRFUkFUSU9OUyA1MDAwMFUKI2RlZmluZSBNQVhfREVM
QVkgNDA5NlUKCnN0cnVjdCBubF9yZXEgewoJY2hhciBidWZbNDA5Nl07CglzdHJ1Y3Qgbmxtc2do
ZHIgKm5saDsKfTsKCnN0cnVjdCByYWNlX2N0eCB7CglhdG9taWNfdWludCBnbzsKCWF0b21pY191
aW50IGRvbmU7CglpbnQgc2VuZGVyOwoJaW50IHJlY2VpdmVyOwoJY2hhciBwYWNrZXRbVURQX1BB
WUxPQURfTEVOXTsKfTsKCnN0YXRpYyB1aW50MzJfdCBubF9zZXE7CgpzdGF0aWMgdm9pZCBkaWUo
Y29uc3QgY2hhciAqZm10LCAuLi4pCnsKCXZhX2xpc3QgYXA7CgoJdmFfc3RhcnQoYXAsIGZtdCk7
Cgl2ZnByaW50ZihzdGRlcnIsIGZtdCwgYXApOwoJdmFfZW5kKGFwKTsKCWZwcmludGYoc3RkZXJy
LCAiOiAlc1xuIiwgc3RyZXJyb3IoZXJybm8pKTsKCWV4aXQoMSk7Cn0KCnN0YXRpYyB2b2lkIGV4
cGVjdF9vayhpbnQgcmV0LCBjb25zdCBjaGFyICp3aGF0KQp7CglpZiAocmV0IDwgMCkgewoJCWVy
cm5vID0gLXJldDsKCQlkaWUoIiVzIiwgd2hhdCk7Cgl9Cn0KCnN0YXRpYyB2b2lkIGluaXRfcmVx
KHN0cnVjdCBubF9yZXEgKnJlcSwgdWludDE2X3QgdHlwZSwgdWludDE2X3QgZmxhZ3MsCgkJICAg
ICBzaXplX3QgcGF5bG9hZF9sZW4pCnsKCW1lbXNldChyZXEsIDAsIHNpemVvZigqcmVxKSk7Cgly
ZXEtPm5saCA9IChzdHJ1Y3Qgbmxtc2doZHIgKilyZXEtPmJ1ZjsKCXJlcS0+bmxoLT5ubG1zZ19s
ZW4gPSBOTE1TR19MRU5HVEgocGF5bG9hZF9sZW4pOwoJcmVxLT5ubGgtPm5sbXNnX3R5cGUgPSB0
eXBlOwoJcmVxLT5ubGgtPm5sbXNnX2ZsYWdzID0gZmxhZ3M7Cn0KCnN0YXRpYyB2b2lkIGFkZGF0
dHIoc3RydWN0IG5sX3JlcSAqcmVxLCB1aW50MTZfdCB0eXBlLCBjb25zdCB2b2lkICpkYXRhLAoJ
CSAgICBzaXplX3QgbGVuKQp7CglzaXplX3Qgb2Zmc2V0ID0gTkxNU0dfQUxJR04ocmVxLT5ubGgt
Pm5sbXNnX2xlbik7CglzaXplX3QgYXR0cl9sZW4gPSBSVEFfTEVOR1RIKGxlbik7CglzdHJ1Y3Qg
cnRhdHRyICpydGE7CgoJaWYgKG9mZnNldCArIFJUQV9BTElHTihhdHRyX2xlbikgPiBzaXplb2Yo
cmVxLT5idWYpKSB7CgkJZXJybm8gPSBFMkJJRzsKCQlkaWUoIm5ldGxpbmsgYXR0cmlidXRlIG92
ZXJmbG93Iik7Cgl9CgoJcnRhID0gKHN0cnVjdCBydGF0dHIgKikocmVxLT5idWYgKyBvZmZzZXQp
OwoJcnRhLT5ydGFfdHlwZSA9IHR5cGU7CglydGEtPnJ0YV9sZW4gPSBhdHRyX2xlbjsKCW1lbWNw
eShSVEFfREFUQShydGEpLCBkYXRhLCBsZW4pOwoJcmVxLT5ubGgtPm5sbXNnX2xlbiA9IG9mZnNl
dCArIFJUQV9BTElHTihhdHRyX2xlbik7Cn0KCnN0YXRpYyBzdHJ1Y3QgcnRhdHRyICpuZXN0X3N0
YXJ0KHN0cnVjdCBubF9yZXEgKnJlcSwgdWludDE2X3QgdHlwZSkKewoJc2l6ZV90IG9mZnNldCA9
IE5MTVNHX0FMSUdOKHJlcS0+bmxoLT5ubG1zZ19sZW4pOwoJc3RydWN0IHJ0YXR0ciAqcnRhOwoK
CWlmIChvZmZzZXQgKyBSVEFfQUxJR04oUlRBX0xFTkdUSCgwKSkgPiBzaXplb2YocmVxLT5idWYp
KSB7CgkJZXJybm8gPSBFMkJJRzsKCQlkaWUoIm5ldGxpbmsgbmVzdCBvdmVyZmxvdyIpOwoJfQoK
CXJ0YSA9IChzdHJ1Y3QgcnRhdHRyICopKHJlcS0+YnVmICsgb2Zmc2V0KTsKCXJ0YS0+cnRhX3R5
cGUgPSB0eXBlOwoJcnRhLT5ydGFfbGVuID0gUlRBX0xFTkdUSCgwKTsKCXJlcS0+bmxoLT5ubG1z
Z19sZW4gPSBvZmZzZXQgKyBSVEFfQUxJR04ocnRhLT5ydGFfbGVuKTsKCXJldHVybiBydGE7Cn0K
CnN0YXRpYyB2b2lkIG5lc3RfZW5kKHN0cnVjdCBubF9yZXEgKnJlcSwgc3RydWN0IHJ0YXR0ciAq
cnRhKQp7CglydGEtPnJ0YV9sZW4gPSAoY2hhciAqKXJlcS0+YnVmICsgcmVxLT5ubGgtPm5sbXNn
X2xlbiAtIChjaGFyICopcnRhOwp9CgpzdGF0aWMgaW50IG5sX29wZW4odm9pZCkKewoJc3RydWN0
IHNvY2thZGRyX25sIGFkZHIgPSB7CgkJLm5sX2ZhbWlseSA9IEFGX05FVExJTkssCgl9OwoJaW50
IGZkOwoKCWZkID0gc29ja2V0KEFGX05FVExJTkssIFNPQ0tfUkFXLCBORVRMSU5LX1JPVVRFKTsK
CWlmIChmZCA8IDApCgkJZGllKCJzb2NrZXQgTkVUTElOS19ST1VURSIpOwoJaWYgKGJpbmQoZmQs
IChzdHJ1Y3Qgc29ja2FkZHIgKikmYWRkciwgc2l6ZW9mKGFkZHIpKSA8IDApCgkJZGllKCJiaW5k
IE5FVExJTktfUk9VVEUiKTsKCXJldHVybiBmZDsKfQoKc3RhdGljIGludCBubF90YWxrKGludCBm
ZCwgc3RydWN0IG5sX3JlcSAqcmVxKQp7CglzdHJ1Y3Qgc29ja2FkZHJfbmwgbmxhZGRyID0gewoJ
CS5ubF9mYW1pbHkgPSBBRl9ORVRMSU5LLAoJfTsKCWNoYXIgYnVmWzgxOTJdOwoJc3RydWN0IGlv
dmVjIGlvdjsKCXN0cnVjdCBtc2doZHIgbXNnOwoJc3NpemVfdCBuOwoKCXJlcS0+bmxoLT5ubG1z
Z19zZXEgPSArK25sX3NlcTsKCWlvdi5pb3ZfYmFzZSA9IHJlcS0+bmxoOwoJaW92Lmlvdl9sZW4g
PSByZXEtPm5saC0+bmxtc2dfbGVuOwoJbWVtc2V0KCZtc2csIDAsIHNpemVvZihtc2cpKTsKCW1z
Zy5tc2dfbmFtZSA9ICZubGFkZHI7Cgltc2cubXNnX25hbWVsZW4gPSBzaXplb2YobmxhZGRyKTsK
CW1zZy5tc2dfaW92ID0gJmlvdjsKCW1zZy5tc2dfaW92bGVuID0gMTsKCWlmIChzZW5kbXNnKGZk
LCAmbXNnLCAwKSA8IDApCgkJcmV0dXJuIC1lcnJubzsKCglmb3IgKDs7KSB7CgkJc3RydWN0IG5s
bXNnaGRyICpubGg7CgkJaW50IHJlbTsKCgkJbiA9IHJlY3YoZmQsIGJ1Ziwgc2l6ZW9mKGJ1Ziks
IDApOwoJCWlmIChuIDwgMCkKCQkJcmV0dXJuIC1lcnJubzsKCQlmb3IgKG5saCA9IChzdHJ1Y3Qg
bmxtc2doZHIgKilidWYsIHJlbSA9IChpbnQpbjsKCQkgICAgIE5MTVNHX09LKG5saCwgcmVtKTsg
bmxoID0gTkxNU0dfTkVYVChubGgsIHJlbSkpIHsKCQkJc3RydWN0IG5sbXNnZXJyICplcnI7CgoJ
CQlpZiAobmxoLT5ubG1zZ19zZXEgIT0gcmVxLT5ubGgtPm5sbXNnX3NlcSkKCQkJCWNvbnRpbnVl
OwoJCQlpZiAobmxoLT5ubG1zZ190eXBlICE9IE5MTVNHX0VSUk9SKQoJCQkJY29udGludWU7CgkJ
CWVyciA9IChzdHJ1Y3Qgbmxtc2dlcnIgKilOTE1TR19EQVRBKG5saCk7CgkJCXJldHVybiBlcnIt
PmVycm9yOwoJCX0KCX0KfQoKc3RhdGljIGludCBxZGlzY19hZGQoaW50IGZkLCBpbnQgaWZpbmRl
eCkKewoJc3RydWN0IG5sX3JlcSByZXE7CglzdHJ1Y3QgdGNtc2cgKnRjbTsKCWNvbnN0IGNoYXIg
a2luZFtdID0gInFmcSI7CgoJaW5pdF9yZXEoJnJlcSwgUlRNX05FV1FESVNDLAoJCSBOTE1fRl9S
RVFVRVNUIHwgTkxNX0ZfQUNLIHwgTkxNX0ZfQ1JFQVRFIHwgTkxNX0ZfRVhDTCwKCQkgc2l6ZW9m
KCp0Y20pKTsKCXRjbSA9IE5MTVNHX0RBVEEocmVxLm5saCk7Cgl0Y20tPnRjbV9mYW1pbHkgPSBB
Rl9VTlNQRUM7Cgl0Y20tPnRjbV9pZmluZGV4ID0gaWZpbmRleDsKCXRjbS0+dGNtX2hhbmRsZSA9
IFFESVNDX0hBTkRMRTsKCXRjbS0+dGNtX3BhcmVudCA9IFRDX0hfUk9PVDsKCWFkZGF0dHIoJnJl
cSwgVENBX0tJTkQsIGtpbmQsIHNpemVvZihraW5kKSk7CglyZXR1cm4gbmxfdGFsayhmZCwgJnJl
cSk7Cn0KCnN0YXRpYyBpbnQgY2xhc3NfY2hhbmdlKGludCBmZCwgaW50IGlmaW5kZXgsIHVpbnQz
Ml90IGxtYXgsIGJvb2wgY3JlYXRlLAoJCQlib29sIGFkZF9yYXRlKQp7CglzdHJ1Y3QgbmxfcmVx
IHJlcTsKCXN0cnVjdCB0Y21zZyAqdGNtOwoJc3RydWN0IHJ0YXR0ciAqb3B0czsKCXN0cnVjdCBn
bmV0X2VzdGltYXRvciBlc3QgPSB7CgkJLmludGVydmFsID0gLTIsCgkJLmV3bWFfbG9nID0gMSwK
CX07Cgl1aW50MzJfdCB3ZWlnaHQgPSAxOwoJdWludDE2X3QgZmxhZ3MgPSBOTE1fRl9SRVFVRVNU
IHwgTkxNX0ZfQUNLOwoKCWlmIChjcmVhdGUpCgkJZmxhZ3MgfD0gTkxNX0ZfQ1JFQVRFIHwgTkxN
X0ZfRVhDTDsKCWluaXRfcmVxKCZyZXEsIFJUTV9ORVdUQ0xBU1MsIGZsYWdzLCBzaXplb2YoKnRj
bSkpOwoJdGNtID0gTkxNU0dfREFUQShyZXEubmxoKTsKCXRjbS0+dGNtX2ZhbWlseSA9IEFGX1VO
U1BFQzsKCXRjbS0+dGNtX2lmaW5kZXggPSBpZmluZGV4OwoJdGNtLT50Y21faGFuZGxlID0gQ0xB
U1NfSEFORExFOwoJdGNtLT50Y21fcGFyZW50ID0gUURJU0NfSEFORExFOwoJb3B0cyA9IG5lc3Rf
c3RhcnQoJnJlcSwgVENBX09QVElPTlMpOwoJYWRkYXR0cigmcmVxLCBUQ0FfUUZRX1dFSUdIVCwg
JndlaWdodCwgc2l6ZW9mKHdlaWdodCkpOwoJYWRkYXR0cigmcmVxLCBUQ0FfUUZRX0xNQVgsICZs
bWF4LCBzaXplb2YobG1heCkpOwoJbmVzdF9lbmQoJnJlcSwgb3B0cyk7CglpZiAoYWRkX3JhdGUp
CgkJYWRkYXR0cigmcmVxLCBUQ0FfUkFURSwgJmVzdCwgc2l6ZW9mKGVzdCkpOwoJcmV0dXJuIG5s
X3RhbGsoZmQsICZyZXEpOwp9CgpzdGF0aWMgdm9pZCBzZXR1cF9uYW1lc3BhY2Uodm9pZCkKewoJ
aWYgKHVuc2hhcmUoQ0xPTkVfTkVXVVNFUiB8IENMT05FX05FV05FVCkgPCAwKQoJCWRpZSgidW5z
aGFyZSIpOwp9CgpzdGF0aWMgaW50IHNldHVwX2xvb3BiYWNrKHZvaWQpCnsKCXN0cnVjdCBpZnJl
cSBpZnI7CglpbnQgZmQ7CglpbnQgaWZpbmRleDsKCglmZCA9IHNvY2tldChBRl9JTkVULCBTT0NL
X0RHUkFNLCAwKTsKCWlmIChmZCA8IDApCgkJZGllKCJzb2NrZXQgQUZfSU5FVCIpOwoJbWVtc2V0
KCZpZnIsIDAsIHNpemVvZihpZnIpKTsKCXN0cm5jcHkoaWZyLmlmcl9uYW1lLCAibG8iLCBJRk5B
TVNJWiAtIDEpOwoJaWYgKGlvY3RsKGZkLCBTSU9DR0lGRkxBR1MsICZpZnIpIDwgMCkKCQlkaWUo
IlNJT0NHSUZGTEFHUyIpOwoJaWZyLmlmcl9mbGFncyB8PSBJRkZfVVA7CglpZiAoaW9jdGwoZmQs
IFNJT0NTSUZGTEFHUywgJmlmcikgPCAwKQoJCWRpZSgiU0lPQ1NJRkZMQUdTIik7CgljbG9zZShm
ZCk7CgoJaWZpbmRleCA9IGlmX25hbWV0b2luZGV4KCJsbyIpOwoJaWYgKGlmaW5kZXggPT0gMCkK
CQlkaWUoImlmX25hbWV0b2luZGV4Iik7CglyZXR1cm4gaWZpbmRleDsKfQoKc3RhdGljIGludCBz
ZXR1cF91ZHAoaW50ICpyZWNlaXZlcikKewoJc3RydWN0IHNvY2thZGRyX2luIGFkZHIgPSB7CgkJ
LnNpbl9mYW1pbHkgPSBBRl9JTkVULAoJCS5zaW5fYWRkci5zX2FkZHIgPSBodG9ubChJTkFERFJf
TE9PUEJBQ0spLAoJCS5zaW5fcG9ydCA9IDAsCgl9OwoJc29ja2xlbl90IGFkZHJsZW4gPSBzaXpl
b2YoYWRkcik7CglpbnQgc2VuZGVyOwoJaW50IHByaW9yaXR5ID0gQ0xBU1NfSEFORExFOwoKCSpy
ZWNlaXZlciA9IHNvY2tldChBRl9JTkVULCBTT0NLX0RHUkFNLCAwKTsKCWlmICgqcmVjZWl2ZXIg
PCAwKQoJCWRpZSgicmVjZWl2ZXIgc29ja2V0Iik7CglpZiAoYmluZCgqcmVjZWl2ZXIsIChzdHJ1
Y3Qgc29ja2FkZHIgKikmYWRkciwgc2l6ZW9mKGFkZHIpKSA8IDApCgkJZGllKCJyZWNlaXZlciBi
aW5kIik7CglpZiAoZ2V0c29ja25hbWUoKnJlY2VpdmVyLCAoc3RydWN0IHNvY2thZGRyICopJmFk
ZHIsICZhZGRybGVuKSA8IDApCgkJZGllKCJyZWNlaXZlciBnZXRzb2NrbmFtZSIpOwoKCXNlbmRl
ciA9IHNvY2tldChBRl9JTkVULCBTT0NLX0RHUkFNLCAwKTsKCWlmIChzZW5kZXIgPCAwKQoJCWRp
ZSgic2VuZGVyIHNvY2tldCIpOwoJaWYgKHNldHNvY2tvcHQoc2VuZGVyLCBTT0xfU09DS0VULCBT
T19QUklPUklUWSwgJnByaW9yaXR5LAoJCSAgICAgICBzaXplb2YocHJpb3JpdHkpKSA8IDApCgkJ
ZGllKCJTT19QUklPUklUWSIpOwoJaWYgKGNvbm5lY3Qoc2VuZGVyLCAoc3RydWN0IHNvY2thZGRy
ICopJmFkZHIsIHNpemVvZihhZGRyKSkgPCAwKQoJCWRpZSgic2VuZGVyIGNvbm5lY3QiKTsKCXJl
dHVybiBzZW5kZXI7Cn0KCnN0YXRpYyB2b2lkIHBpbl9jcHUoaW50IGNwdSkKewoJY3B1X3NldF90
IHNldDsKCglDUFVfWkVSTygmc2V0KTsKCUNQVV9TRVQoY3B1LCAmc2V0KTsKCWlmIChzY2hlZF9z
ZXRhZmZpbml0eSgwLCBzaXplb2Yoc2V0KSwgJnNldCkgPCAwKQoJCWRpZSgic2NoZWRfc2V0YWZm
aW5pdHkiKTsKfQoKc3RhdGljIHZvaWQgc3Bpbl9kZWxheSh1bnNpZ25lZCBpbnQgY291bnQpCnsK
CXdoaWxlIChjb3VudC0tKQoJCWFzbSB2b2xhdGlsZSgicGF1c2UiIDo6OiAibWVtb3J5Iik7Cn0K
CnN0YXRpYyB2b2lkICpzZW5kZXJfdGhyZWFkKHZvaWQgKmFyZykKewoJc3RydWN0IHJhY2VfY3R4
ICpjdHggPSBhcmc7Cgl1bnNpZ25lZCBpbnQgaTsKCglwaW5fY3B1KDEpOwoJZm9yIChpID0gMTsg
aSA8PSBJVEVSQVRJT05TOyBpKyspIHsKCQljaGFyIGRyYWluWzIwNDhdOwoKCQl3aGlsZSAoYXRv
bWljX2xvYWRfZXhwbGljaXQoJmN0eC0+Z28sIG1lbW9yeV9vcmRlcl9hY3F1aXJlKSAhPSBpKQoJ
CQlhc20gdm9sYXRpbGUoInBhdXNlIiA6OjogIm1lbW9yeSIpOwoJCXNwaW5fZGVsYXkoaSAlIE1B
WF9ERUxBWSk7CgkJaWYgKHNlbmQoY3R4LT5zZW5kZXIsIGN0eC0+cGFja2V0LCBzaXplb2YoY3R4
LT5wYWNrZXQpLCAwKSA8IDApCgkJCWRpZSgic2VuZCIpOwoJCXdoaWxlIChyZWN2KGN0eC0+cmVj
ZWl2ZXIsIGRyYWluLCBzaXplb2YoZHJhaW4pLCBNU0dfRE9OVFdBSVQpID4gMCkKCQkJOwoJCWF0
b21pY19zdG9yZV9leHBsaWNpdCgmY3R4LT5kb25lLCBpLCBtZW1vcnlfb3JkZXJfcmVsZWFzZSk7
Cgl9CglyZXR1cm4gTlVMTDsKfQoKaW50IG1haW4odm9pZCkKewoJc3RydWN0IHJhY2VfY3R4IGN0
eDsKCXB0aHJlYWRfdCB0aHJlYWQ7CglpbnQgbmw7CglpbnQgaWZpbmRleDsKCWludCByZXQ7Cglp
bnQgdGhyZWFkX3JldDsKCXVuc2lnbmVkIGludCBpOwoKCW1lbXNldCgmY3R4LCAwLCBzaXplb2Yo
Y3R4KSk7CgltZW1zZXQoY3R4LnBhY2tldCwgJ0EnLCBzaXplb2YoY3R4LnBhY2tldCkpOwoJc2V0
dXBfbmFtZXNwYWNlKCk7CglpZmluZGV4ID0gc2V0dXBfbG9vcGJhY2soKTsKCW5sID0gbmxfb3Bl
bigpOwoJZXhwZWN0X29rKHFkaXNjX2FkZChubCwgaWZpbmRleCksICJhZGQgcWZxIHFkaXNjIik7
CglleHBlY3Rfb2soY2xhc3NfY2hhbmdlKG5sLCBpZmluZGV4LCA1MTIsIHRydWUsIGZhbHNlKSwK
CQkgICJjcmVhdGUgcWZxIGNsYXNzIik7CgljdHguc2VuZGVyID0gc2V0dXBfdWRwKCZjdHgucmVj
ZWl2ZXIpOwoKCXBpbl9jcHUoMCk7Cgl0aHJlYWRfcmV0ID0gcHRocmVhZF9jcmVhdGUoJnRocmVh
ZCwgTlVMTCwgc2VuZGVyX3RocmVhZCwgJmN0eCk7CglpZiAodGhyZWFkX3JldCAhPSAwKSB7CgkJ
ZXJybm8gPSB0aHJlYWRfcmV0OwoJCWRpZSgicHRocmVhZF9jcmVhdGUiKTsKCX0KCgkvKgoJICog
VGhlIGVzdGltYXRvciBhdHRyaWJ1dGUgbWFrZXMgdGhlIHBvc3Qtc25hcHNob3QgcGFydCBvZgoJ
ICogcWZxX2NoYW5nZV9jbGFzcygpIGxvbmcgZW5vdWdoIGZvciB0aGUgcGFja2V0IGVucXVldWUg
b24gQ1BVIDEgdG8KCSAqIG1pZ3JhdGUgdGhlIGNsYXNzIHRvIHRoZSByZXF1ZXN0ZWQgKHdlaWdo
dD0xLCBsbWF4PTE1MDApIGFnZ3JlZ2F0ZS4KCSAqLwoJZm9yIChpID0gMTsgaSA8PSBJVEVSQVRJ
T05TOyBpKyspIHsKCQlleHBlY3Rfb2soY2xhc3NfY2hhbmdlKG5sLCBpZmluZGV4LCA1MTIsIGZh
bHNlLCBmYWxzZSksCgkJCSAgInJlc2V0IHFmcSBjbGFzcyIpOwoJCWF0b21pY19zdG9yZV9leHBs
aWNpdCgmY3R4LmdvLCBpLCBtZW1vcnlfb3JkZXJfcmVsZWFzZSk7CgkJcmV0ID0gY2xhc3NfY2hh
bmdlKG5sLCBpZmluZGV4LCBUQVJHRVRfTE1BWCwgZmFsc2UsIHRydWUpOwoJCWV4cGVjdF9vayhy
ZXQsICJjaGFuZ2UgcWZxIGNsYXNzIik7CgkJd2hpbGUgKGF0b21pY19sb2FkX2V4cGxpY2l0KCZj
dHguZG9uZSwgbWVtb3J5X29yZGVyX2FjcXVpcmUpICE9IGkpCgkJCWFzbSB2b2xhdGlsZSgicGF1
c2UiIDo6OiAibWVtb3J5Iik7Cgl9CgoJcHRocmVhZF9qb2luKHRocmVhZCwgTlVMTCk7CgljbG9z
ZShjdHguc2VuZGVyKTsKCWNsb3NlKGN0eC5yZWNlaXZlcik7CgljbG9zZShubCk7CglyZXR1cm4g
MDsKfQo=
--0000000000008198eb0658b2ecf2--
