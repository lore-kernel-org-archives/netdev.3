Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792779057;
	b=ccJDgQVqhMl5pSikxrKV7h39Yvcdf3LNSTCVPKdkrjN0w7ye8zircCiEf3XyZOyUXGbx
	 vg8nQBDfJEyc3YsUGf2O8KLbFZtb7xnlKBueyfhN1x2wlwhQ0XHy4MmcjKz0dfN3JOwmP
	 ecurYZpq/0Q2BbIuiwjOsJUEKAcG+O2Jlvktdr5nTOQPGFfAGir9hr+IoLHeY9i9LPhfW
	 BsQsHGurbbqIt5BlJxEsuNr8uanEa68Kd/I6cXFe1RRBgXlte/tcoWM8tWndUeWzBYlKH
	 E6E/9SvXIRTgyMZH1D2pToT+2kmqC/diefPULuj6yfm8+P4xBPeEhcBsA7UWNAj3NLA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792779057;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=2To+V+OrITwmpsIJPMwp0u1jz/ATT8WX/QhkAuwIUvM=;
	b=ZtsPFdgjdVbLCyZ3wB9napl1itjHwnRnGfOsJuUt6Ta4DhhGD/Ma456zBu/EdgsqviXK
	 JFqNv2e1BbmiTgOPU3yXQ6RXw9Jc9RWgzRmaaz0B7OAnmWpq5c39q8rWdPbshZGMP9rVl
	 da/oU5a2gIVgXY8cvKnIl3hR4xqLDGDOOX6K2sQ5JD8qjJCUcCqgYQmI2jgX7kIVVwAXH
	 RO2Hl0ghIdMOyzKud2DRBSoyqVQetjOmhONe8rWHdwQkELvmguji16lCmd4UVMQlXU9Ac
	 yCB++xQdLD1btkwoCoqcPdrMcA4nru1HEYI/hbWylVVhTTz7oKSmckRAtBxZwAUyW8A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=IJAyo4Dw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF395606A31B
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 18:10:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF395606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=IJAyo4Dw
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc7d154ec4fso499121a12.0
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 11:10:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792779056; cv=none;
        d=google.com; s=arc-20260327;
        b=q+N2FwmOEAviSW0Pcq9WmQMJzOsyzNyLp/F2zz4LBYgAlPh1YeOjN5+iqjYYSItel7
         xv3m06poWKDuKuQDZ0YvyBSnyqZnHubCvBb/gOtlguy5oRl+RUr3CndLjjVqS2DI+u3w
         BfXlx/PDskfmVaB6tU/rs9ikV4ch06OgTIzaXwjEy/lt8FAXSpDjDJmiP2zJR9c5WXZO
         +CbELEg8w/Te1IE17kdJwGSLAGBX4hj0tzP00dlR5+VvG6LeIdo25zywZ9h6Sz05Z4lb
         gKeOHhTFH+GgHVnP89K9zC91+5pMuI2bT18h6mq/5YhzyFyWgkehORt0jIaRg484yx5t
         Y75Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2To+V+OrITwmpsIJPMwp0u1jz/ATT8WX/QhkAuwIUvM=;
        fh=Jkhc4h1+tEPxL8BX4Wmultv22Nqtsri0eHF2LLq0Sq0=;
        b=HcETdYT97qR/eKrgiUMxmaxqhkqQGBLXkOjKCZZuEerIWG3ajwmzbGWYjKwKFB3/m3
         MKk2u/oudtXT1t3v8OnxNSbP4YT6Va2lJ73h0SeFNuct7z6e5JN3ohrbMjda/7J0IDlc
         EN6eLumEu1lbCretHGa9EM5E86qa2PVWu5SmjTsscP6rhXkm9cNiZ0IeIhPUUmAwnyPm
         3b6rb1iAn1ADgOXpXO6swcjMVKBOpLQAfb8CNdZZkyqcQ//sI1zM61bd+E+W/kuwRVSe
         I5kHfc2NejcMcWbJ8e8garLWcvvCmEy4kQqtxIk5bqaXlIcZSWOKx3IzFhyDqhZgQYnw
         cL6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792779056; x=1793383856; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2To+V+OrITwmpsIJPMwp0u1jz/ATT8WX/QhkAuwIUvM=;
        b=IJAyo4DwhUUNRVqNHCueZ8LsIOldUGOYSiuA455VEuYgkSbX5wQR4sITkKOq8qZZb6
         OzExRnJHaVZUeoQ1IrT+oGRTMROrrKGTvj5st9F66zQHNB1Mxnx29bdY/IVShBEa2Egj
         k37SK6g9lb9vFXBa4IJjR6EFg1atW7jvxJNhQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792779056; x=1793383856;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2To+V+OrITwmpsIJPMwp0u1jz/ATT8WX/QhkAuwIUvM=;
        b=GsT8t9c7k/Wb4tgKEJ4cK3KzAnfQ5Ooty7lO19RMqgfX6q5hGdcQQv57UAYsegv8cd
         /Ru8WCyHsV42vS/kEOxXCpyisAJPpIqMXO5gHHx5WWK49UVjumK3lD10t7snbMjBUSI9
         oN/aqfHsAAtqN58MrhVLMuwLJ6bLIrkQlgUsibDthlfTZ/w103xLpXLEqVJ/aHxlRW7+
         tpLZdrEVAhjDkrBR9Hzbj2QaKuXIpAwLULQWGyBHm30Qsx5XLqrAn+gpXxDofbT4VWYG
         oGVM00mpMSI71/neX6ZjvdfluhN3pFZZo4KMbqUPaBbFN+Yn2TMVWijCRsyPHcbjwQm8
         ClAw==
X-Forwarded-Encrypted: i=1; AKwUvBybLHgxJ6SHLN7lG53sNb/EcRPduuXgt8NDtywla8QNHVcD+f0JIVkrLBBctzZ0A6eIvtWZIdw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKTGN+LcjrQfxlL9V2PKTrkezJXvrHZrwDyERh1VlxgVbI0Exm/
	QK5fv8TtIl8FNWGuzTBINpvYULyVk2RsJUBPW5FSUq9fLUYu35M+o+O/LvD+EsKJvD1cfj+vzpZ
	fyH2wH3MfEROEQ8x1gR0prWPZeluvMvVHazQ2ror5
X-Gm-Gg: AYBFou23M12CIs/89Pjw4J4lTXW9izRYp8zJR7Jf3Mb/UY100QR8S836TYAUW8+SY2C
	8097DVEmw/IPPUYk4IAeGbm8G+1SBNAnCYnJA6V1kkTMybO56g3zqd6RqLnag0F1QT6Qe9Gfq1X
	JSeP5vDBJDOzoS5LahEgL4t0kepJOBtSl+NuPJZ8OMMhur0fHWOx3vGK3HjpXuNXR1xBiol7cvT
	wfwPaxKSXzlZvhCciFq+ja9q3p++R+ts7jSdCPzN9OqUNwYfIEXha1EuCkHzhpcjP+3fdNPAi6V
	irE5U18NVxpyF2YRnkrWxW7O/Njp1PZlg5AwxjYlxCNjOBNKygiSqzq23i+CwkZxGZwePB4qLyv
	6TdHWigjNFI+slu6i4deJpt4/IVNYmbpyFB6kBfTqXw6BMcLOa/5A9ObIfxYwbqtnP9ONGMgUsY
	gUly5fmMYN98O456Q=
X-Received: by 2002:a17:90b:58e8:b0:3ac:3e42:60a2 with SMTP id
 98e67ed59e1d1-3adead5ca8emr71919a91.33.1792779056179; Fri, 23 Oct 2026
 11:10:56 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260731140533.566493-1-david.lee@trailofbits.com>
 <CAM0EoM=UDkGKLivsdDS5JaVMuefR4jLC2rAWJcOR8XD-4N_EgA@mail.gmail.com>
 <CAC_etQESLytW5rhp0GfZU-mJqJhwk202a5u_nTXZ7W6wJN=AJw@mail.gmail.com>
 <CAC_etQHv2EBYfAhfkYHKrasnJAyDS+u5+a4os4aD1eSmKrck_A@mail.gmail.com>
 <CAM0EoMm=KbZgcGqLHDFee3mM1GxuNCvAWObP_K4AxsGAoEAedg@mail.gmail.com> <CAC_etQGXyhHe4vowrM4wLmhid56JcdsQZXdM+SFM-ZMnmG9wwg@mail.gmail.com>
In-Reply-To: <CAC_etQGXyhHe4vowrM4wLmhid56JcdsQZXdM+SFM-ZMnmG9wwg@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 23 Oct 2026 14:10:44 -0400
X-Gm-Features: AclHuK-rmW3KxgaFWTvJ_7-SL5p5TCdMGqIzYH2WnxCwtRo3MCTsEGQlUOqyd8U
Message-ID: <CAM0EoMn7EE+zFDis0e_QDkfY2U59QRi52izi4dgNNWnOv9Awtg@mail.gmail.com>
Subject: Re: [PATCH] net/sched: sch_qfq: prevent aggregate self-replacement
To: David Lee <david.lee@trailofbits.com>
Cc: jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, Kyle Zeng <kylebot@openai.com>, 
	"Dominik 'Disconnect3d' Czarnota" <dominik.czarnota@trailofbits.com>, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 11:45=E2=80=AFAM David Lee <david.lee@trailofbits.c=
om> wrote:
>
> Hi Jamal,
>
> I reproduced the issue on upstream Linux at commit
> 734bef548a96e8774d6eef5dfa2026c6edc4e80b using the original PoC,
> confirming that it is still present at that revision.
>
> I've attached the KASAN log, the PoC, reproduction steps, and the bug rep=
ort.
>
> For reference, the original patch thread is:
> https://lore.kernel.org/netdev/20260731140533.566493-1-david.lee@trailofb=
its.com/
>

Thanks for persevering David - i have queued it to look at - so it
wont be lost this time.

cheers,
jamal
> Best regards,
> David
>
>
> On Thu, 22 Oct 2026 05:14:38 -0400, Jamal Hadi Salim <jhs@mojatatu.com> w=
rote:
> > On Wed, Oct 21, 2026 at 10:56=E2=80=AFAM David Lee <david.lee@trailofbi=
ts.com> wrote:
> > >
> > > Hi Jamal,
> > >
> > > Following up on this thread. Please let me know if you had a chance t=
o review the attached reproducer or if you need any additional information.
> > >
> >
> > Please resend to the list - I lost track.
> > And if you follow up after like 2 months(!) you will really have to
> > retest with the new kernel and likely look at the list to see if there
> > are other fixes that cover this issue.
> >
> >
> > cheers,
> > jamal
> >
> > > Best regards,
> > >
> > >
> > >
> > > On Mon, Aug 10, 2026 at 11:22=E2=80=AFAM David Lee <david.lee@trailof=
bits.com> wrote:
> > >>
> > >> Hi Jamal,
> > >>
> > >> Reproducer has been attached to this email.
> > >>
> > >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Reproduction =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > >>
> > >> 1. Build Linux at 82a47586c0b9266622657009aa30573dddf09f53
> > >>    with the configuration options listed above and KASAN enabled.
> > >>    Use a system with at least two CPUs. If QFQ is configured as a
> > >>    module, make sch_qfq available before running the reproducer.
> > >>
> > >> 2. Build the attached poc.c:
> > >>
> > >> ~
> > >> gcc -static -O2 -pthread -Wall -Wextra -o poc poc.c
> > >> ~
> > >>
> > >> 3. Run the resulting binary:
> > >>
> > >> ~
> > >> ./poc
> > >> ~
> > >>
> > >> The reproducer creates user and network namespaces, brings up the
> > >> loopback device, installs a QFQ qdisc and class, and races class
> > >> changes against packet enqueue. Race timing varies between systems.
> > >> On the validated KASAN kernel, the expected result is a
> > >> slab-use-after-free report in qfq_add_to_agg(), followed by a kernel
> > >> panic. The full observed output is attached as splash.txt.
> > >>
> > >> he issue was reproduced on Linux 7.2-rc3 at:
> > >>
> > >> 82a47586c0b9266622657009aa30573dddf09f53
> > >>
> > >> It is also present in Linux 7.2-rc5 at:
> > >>
> > >> f5098b6bae761e346ebcd9da7f95622c04733cff
> > >>
> > >> As of July 27, 2026, the vulnerable sequence remains in upstream
> > >> master at:
> > >>
> > >> 62cc90241548d5570ee68e01aaba6506964e9811
> > >> https://github.com/torvalds/linux/commit/62cc90241548d5570ee68e01aab=
a6506964e9811
> > >>
> > >> Required configuration:
> > >>
> > >> * CONFIG_NET_SCHED
> > >> * CONFIG_NET_SCH_QFQ
> > >>
> > >> The attached reproducer additionally requires:
> > >>
> > >> * CONFIG_USER_NS
> > >> * CONFIG_NET_NS
> > >> * CONFIG_INET
> > >>
> > >> KASAN is recommended to observe the first invalid access.
> > >>
> > >> Regarding the format, I can send v2 if the reproducer looks good on =
your end.
> > >>
> > >> Thank you.
> > >>
> > >> Best regards,
> > >> David
> > >>
> > >> On Fri, Jul 31, 2026 at 12:33=E2=80=AFPM Jamal Hadi Salim <jhs@mojat=
atu.com> wrote:
> > >>>
> > >>> On Fri, Jul 31, 2026 at 10:05=E2=80=AFAM David Lee <david.lee@trail=
ofbits.com> wrote:
> > >>> >
> > >>> > qfq_change_class() snapshots the current aggregate settings while
> > >>> > holding the qdisc tree lock, but drops the lock before selecting =
the
> > >>> > destination aggregate. During that gap, qfq_enqueue() can move th=
e
> > >>> > class to an aggregate matching the requested settings.
> > >>> >
> > >>> > When qfq_change_class() resumes, qfq_find_agg() then returns cl->=
agg.
> > >>> > If it is a singleton, qfq_deact_rm_from_agg() frees the aggregate
> > >>> > before qfq_add_to_agg() immediately accesses the same pointer, ca=
using
> > >>> > a use-after-free.
> > >>> >
> > >>> > While holding the tree lock, skip the replacement when the destin=
ation
> > >>> > is already the current aggregate. Any estimator replacement has a=
lready
> > >>> > completed, so the class change can finish normally.
> > >>> >
> > >>> > Fixes: 462dbc9101ac ("pkt_sched: QFQ Plus: fair-queueing service =
at DRR cost")
> > >>> > Bug found and triaged by OpenAI Security Research and
> > >>> > validated by Trail of Bits.
> > >>> >
> > >>>
> > >>> Please always send a reproducer - either as a tdc test case or if i=
t
> > >>> is sensitive send it privately to me and Cc the other maintainers.
> > >>> As trivial as this looks I will not look at it without a repro.
> > >>>
> > >>> cheers,
> > >>> jamal
> > >>>
> > >>> > Assisted-by: Codex:gpt-5.6-sol gpt-5.5-cyber
> > >>> > Signed-off-by: Kyle Zeng <kylebot@openai.com>
> > >>> > ---
> > >>> > Trail of Bits has a reproducer for this bug that triggers a
> > >>> > KASAN use-after-free and can share if needed.
> > >>> >
> > >>> >  net/sched/sch_qfq.c | 3 +++
> > >>> >  1 file changed, 3 insertions(+)
> > >>> >
> > >>> > diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
> > >>> > index 6f3b7273c..e900890e9 100644
> > >>> > --- a/net/sched/sch_qfq.c
> > >>> > +++ b/net/sched/sch_qfq.c
> > >>> > @@ -517,11 +517,14 @@ static int qfq_change_class(struct Qdisc *s=
ch, u32 classid, u32 parentid,
> > >>> >                 sch_tree_lock(sch);
> > >>> >                 qfq_init_agg(q, new_agg, lmax, weight);
> > >>> >         }
> > >>> > +       if (existing && new_agg =3D=3D cl->agg)
> > >>> > +               goto unlock;
> > >>> >         if (existing)
> > >>> >                 qfq_deact_rm_from_agg(q, cl);
> > >>> >         else
> > >>> >                 qdisc_class_hash_insert(&q->clhash, &cl->common);
> > >>> >         qfq_add_to_agg(q, new_agg, cl);
> > >>> > +unlock:
> > >>> >         sch_tree_unlock(sch);
> > >>> >         qdisc_class_hash_grow(sch, &q->clhash);
> > >>> >
> > >>> > --
> > >>> > 2.53.0
> > >
> > >
> > >
> > > --
> > > David Lee
> > > Security Engineer I, Application Security | Trail of Bits
> > > trailofbits.com
