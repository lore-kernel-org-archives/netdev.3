Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4869F3ED5CD
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 23:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789168361; cv=pass; b=oTILK7C21lM2DCk315tnzdCp9qJQ6iIikFwXq/6UuOph+N6Ko9Vp1Y0YReOJFYKB/SehRBFvKMOdorZewWmAVx7sxA0+PCR6xSEDquFS7kqR3o06Y1kHSAh3Ndf2hC5LVwpTDMeocaEOpOa6F4/mWdlemUvojktf5JPVFX1K5hI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789168361; c=relaxed/simple;
	bh=U5b2EGQ0h1hGiuvcKNAxlYftbTygKbTmyhHzJL26viU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OFreIbZDgPpNnWoasTdFj3yg+2KUC9QjjplSj3sv0KKklxA6aDOzZlt3qou7IV6hkHPTrGQoNdAuz+O2BaDrdm1SC83Qttshl4Os3PzjqjqENLpZbnnJSI6LtG/QV//xN0Pq/5YqRA05qFAlIfAeb1qf/AkSuhs3qnEzLR03nEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=bDJBQdJM; arc=pass smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="bDJBQdJM"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85469d249c4so499565b3a.2
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 16:12:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789168359; cv=none;
        d=google.com; s=arc-20260327;
        b=ck1jZVHFk5E5/xbviDsP4McELjMmH5KQ2iCo7xGzZjmOkazBLlsxRJFidZwXTV6R0I
         z72ZUrGPr2TACaV+IqJZGAxAZbhSpoGC/3+Yy21D0XN7MosPgzVEYLEIassNsRdGeZXE
         Gtt5XFmh512xCPc4wVuSTtq4SYQUyf73c2WiU1bmsGjpfoWDaaTfZCi8NdxBUpb+76yR
         A1oqvabOdFtPjJsta0P01Pu5y6Dgn73lsKzW3MyV2QByS2Qff3eUt+kLywStlRkFfn38
         oPeckCdhgEbnEgbi1X7qjX8ye9py0VPWef7fyp4hZg6f35mi6jfowXQswUels5/Q7oMw
         kl2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NVHoZLNQTSNiN6B8aYa+VAei/rQkC1SW8nQqoOBjgYM=;
        fh=/qS7pDVx1PdVvAFUzdBqbRDUaeOTJaWGdiQkx73LwTg=;
        b=JbQB+w32oX4PQC6P4ZmN6x9OYFv8Zb8gK4kdgAVFlOCjb/ubm0d+LGBdffp/NPyfPq
         Bk4FJLU9zSYGKRz0k148a2wPtZIzTRcObpnCzxQdXmAED6OQdSwLDire7Wrm+xVVABH6
         dC7gVWQCvUpBYU0IJYPYqM09fF6Dw+YMCtrO8DOcWPPR5gnKBTSrvkKQnNV+8XLtNlpQ
         UVTsre/9p7izqVOzipNrKd+qR5D/6k68OXFm+u5v4351PWclvyCVkt6E2Jwc88EuSLXk
         QyLooa5WBNLGt8a48GiM+dJRADsn1RU+PBTTkivqCinWhXucgeJObb6LL27ShtTbYA7V
         vkeg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1789168359; x=1789773159; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NVHoZLNQTSNiN6B8aYa+VAei/rQkC1SW8nQqoOBjgYM=;
        b=bDJBQdJMUqEJ50EiXOho9fklpxlxedv//KcHhF5I09IZPnWY0ZK77hZhgg63T4gPDR
         rNFqKhEtwDhvXpMUcyZizQbJpwdfhmhhFrfv3bZnaKdYCknLELNhRVakV/Yl8Mz4qFIE
         YsKakeem92K9QzyrTgL0a6/3jxSKN/yyO6RVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789168359; x=1789773159;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NVHoZLNQTSNiN6B8aYa+VAei/rQkC1SW8nQqoOBjgYM=;
        b=FRh/AgOmaMw2ejEufORthcCT+nt+fvG85vDhVjDuSLloAyamuMqY3TE3taAtfkLqki
         HDxRcgmzxmGfh8MwTFQA+Zh6MXeA5XJuFde11YiMrxri7hetHcSXpxiTXi9g6Lr7dYe9
         KqW8wigc3beUfpEAeqMAm8dpcDyvlkuTsTm/asn3gxl/zM/jAWSmI8o01XgxRAEki9aJ
         NDZ/oJRrdgyHQo+LE+hrsBWbmTgMGuGh1dlAImL+Zl7a0akkVILKBnsldgYf5bkcwGD9
         b3CwWOaKOj2uPM/zB9WtVwSRgWOOcObit27GOg0j8CdlnrcS7tWDPRMSSO+ctJNHhdht
         GWNA==
X-Gm-Message-State: AFuF++nEmnJB49ADuLQU42aGaVvy1Zq3UZ5yf++IFbGR27o7QrhhDk+3
	eT5r7UMMZXMa/UKzrjdATuWreTWF6RyhIGUYDFqnL7m31OjFNH70HKm18/r0a4I9kgWYCHwrbw6
	Vpr2Ac/1d7IJA70c7u1nn3O+C6c64blPcOFTB3r/a
X-Gm-Gg: AYBFou0LrnM0CSNBIzcDXgDp19PjzEIjLRfMPKzKg1WFtK1E4FmRyQHECeFJBIDiaGJ
	a8jWVHDXS1ndc7jY1oJsOR5XKzGFhwOEPUrmIsBRMWCK1yhAj5qxg4dFQnDuc+rkFh7Y6RbVMJk
	X+gmBSSg9LQwV4t5FM8XKNT23FhOw1QHTxiEapDBaVBRRsjRk+pO1GUKo6IFxsWdCePbm6rnV3m
	hE/THNRBQ18jwg4+ZZpChnDDXFB/H15nuuMdtaOGRY/ovU1YUJH0IkmAGbLu7drtPvbi4CKpt02
	JSdsHofvbUkeVjKv91xZQ5JjQSJQiLtwv+OEmeHGYhfqcOh+Xe7XqTu/kXwRZaH0I/XHKBBFbrY
	itv/SAwW78K9HSBOuOIWDNhZTteXy9SOJQQ==
X-Received: by 2002:a05:6a00:7541:b0:86c:b39b:66e4 with SMTP id
 d2e1a72fcca58-86cb39b6a6bmr818636b3a.18.1789168359596; Fri, 11 Sep 2026
 16:12:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-1L5H.v1.20260903184552@mojatatu.com> <CANn89iKFVvFaNcZyGOxmyPbpc6ax49ZqwMWDeBAsH5dav-y-SA@mail.gmail.com>
 <CAM0EoMn5M__WHkniZLw8GNtHpTresTC2dQuL6brmAzUXH1YUKw@mail.gmail.com>
In-Reply-To: <CAM0EoMn5M__WHkniZLw8GNtHpTresTC2dQuL6brmAzUXH1YUKw@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 11 Sep 2026 19:12:28 -0400
X-Gm-Features: AcwNN1VxwBhgJyQS3MJEPkDfRRZ_FKlaOla_PtSbjvxx1Fh58EDgtZfXE8iGhas
Message-ID: <CAM0EoMkzo3s7QTLm=w4RkyAbKat3iVZ89dPtPeQoFRvqigs_4Q@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net/sched: codel: bound the dropping loop per
 dequeue call
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, 
	Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Victor Nogueira <victor@mojatatu.com>, Johannes Berg <johannes@sipsolutions.net>, 
	linux-wireless@vger.kernel.org, Vega <vega@nebusec.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 4:31=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com> =
wrote:
>
> On Thu, Sep 3, 2026 at 8:35=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
> >
> > On Thu, Sep 3, 2026 at 10:56=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.=
com> wrote:
> > >
> > > The CoDel control law schedules the next drop one interval/sqrt(count=
)
> > > after the previous drop, using the configured interval
> > > (codel_params.interval). For very small intervals the scheduled step
> > > rounds down to zero, so the dropping loop in codel_dequeue() never
> > > advances and drains the entire backlog under the qdisc lock in one
> > > call - an unprivileged user can trigger a soft lockup this way.
> > >
> >
> > ...
> >
> > >  static bool codel_should_drop(const struct sk_buff *skb,
> > > @@ -156,6 +161,7 @@ static struct sk_buff *codel_dequeue(void *ctx,
> > >         struct sk_buff *skb =3D dequeue_func(vars, ctx);
> > >         codel_time_t now;
> > >         bool drop;
> > > +       unsigned int drops =3D 0;
> >
> > SGTM, note that this line breaks RCT.
> >
>
> Grrr.. it was in my brain to fix it, but my fingers didnt get the command=
 ;->
> If needed, I will send a v2.

Should i resend this? sashiko-nipa never reviewed and other one found no is=
sues.

cheers,
jamal
> > Reviewed-by: Eric Dumazet <edumazet@google.com>
>
> Thanks for the review - struggled a bit with this one and wasnt 100%
> sure it was the right approach.
> cheers,
> jamal
