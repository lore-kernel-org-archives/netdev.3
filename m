Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3AD495527
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 13:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788357357; cv=pass; b=Qi76Xv0aHAhlKRjxu0+/J3ttzJhYqxaS3DF57/kAbaFUgntgsF+EYrn/w4wq/+N2ptgAtjE9TXluOlhglCy9OR7NZaXNcRFQW73k4ogNKlwtCAhlUSBjGVoPw+PHnIQW4bF/Fuj9mJE6lXk7GipUN+E/XFPVJ4VQQPA6MHhooqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788357357; c=relaxed/simple;
	bh=aWJfXd4wDmWh9dR47FITwc4NC22PXsmRS1CTDYUASYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZlZVUFxveoA3ASclEvHubZ9IwvFgU0ht+SYqfcaa3kbHXw8TvssEbuS0ozZTbbapl8Bsd7HewC0VOasqye68hUgkTAM7e5sb8SHnxaQ4GfpsNOMAXun5S7k9cb3b3w/IqIMmJPuJP6UrWG+fFXtFsUbGaPa2mrJMYYp5sKHoFVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=ErhjzyX8; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="ErhjzyX8"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8525efa7274so893699b3a.2
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 06:55:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788357355; cv=none;
        d=google.com; s=arc-20260327;
        b=OP9FKIod/5uxvKhweEqC/AwtNlIxP8OLrmAKprQwFdY0t+IPejF8T3ccNF9LPZrHDu
         HWSwW8wizPwwj75BMO5qiAQ+fhJyUF4858FOvBYn1F6qnvB7lXRdySRA30K8mDccOEXE
         QYLbWNVCcO9X1pC+uKvNlcobv8AzmNW5pGxzjeO/wQ4oRsv/rLI1q7XZ6afTEz6P/hFe
         /eXpdaJp1X7tNgpA58nastc0y1alIGhxEX8tWiKTpW0pkp7LgaVi8gmur6UfCqpCXNQh
         ciuCaw28WbR56WH0tqoEZ8zuKVdGdwvvmtEIyMS3zbL2n8V++/ELjpvCqwSdEA5Rsta9
         t3SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EJ2mpWf89VqNLx0HXZpgcj2qhq6s6G2t87DZrq2c6vI=;
        fh=m3lNRksJ4Yrn86ew3aCTlU7BBU/3gYiVHWMCIKF/PA8=;
        b=V9DWF+4AX3dNQziLheSYYLHOj4Nj+H886d4hvq4HuG2soy6xLPEW9R7VPKX7Oo43q7
         8flhfj3pqW68GMqeyHxwLXrFZR2sAIz4Oy/D3JeleMzl35PB/dLpagnhuRNXVZkyd0T7
         C+iM5JIqBBStR9nHaKOG+L5I/PoNxXSwsWczH0AcQpR1i/7c7RcNWaTgQ9gjf8EYkehX
         FB5M5kQVhpupPxoHur05Bec5O5xtTRia95l327/bgrkB+t2+QPK3HkkX4vtFNuH1347U
         Qr+/5Si6BNcTBkoH5Xxwhx8TBLKLC3HuUGkZ7kLKPfo3Ju6Pi4vyFUzQLh6H2ywlhSHa
         G8hg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1788357355; x=1788962155; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EJ2mpWf89VqNLx0HXZpgcj2qhq6s6G2t87DZrq2c6vI=;
        b=ErhjzyX81L/6j1UpZFYsLJ5+mfsvPiKizRkjm5V+RcskktSTeuHhdQyVq79nX31VGC
         gQF5vGE8SfaxE1M/TMbmDD2iNGojkCIYatoMA3keEa0OzS0uoXDAae9LHl30NhZ6Q0Y5
         6ryMVGnmle9zo/Y1NQ7P79OZOVY95Ko9vWZ64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788357355; x=1788962155;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EJ2mpWf89VqNLx0HXZpgcj2qhq6s6G2t87DZrq2c6vI=;
        b=Mg2UXeukcSWReyMnbJcdO09fYScsWeb6fIBEOKOLHJsftZooe+TR1sHAEwQra/hITc
         AoCgL6RhNPeRPU+sDlOA1OD+Z9oOZCipvz2QCUhSr41oRo/ZjT3QSRtncKlZViMpb9JK
         Gz10uJwA13Eqcrw6X8fH/7A+Fb9dFPxCCOvKK/Xy8zIHwKdPUydmBFLIpxh/1ADnpUpx
         Q3lX6Rwq3TaeqtMpDQjLXFfNv1Z4DzzKLNLZb9TmWF4AdnK08apsi2eUbBmEKyfde3q+
         mgGYTWAXn4OQYsO3Yvc1c0Qh0KLqCxhpEn1gzlKwZvjXK20gLDT+EPqZ7IxQds5/GwHn
         JQuA==
X-Gm-Message-State: AFuF++lugexYTbdFtgaP/AmHcODJF7kJl/+YNzJdWHdjFJNKXTxvskbF
	w9FuHZ95JKH9EnX92t7SlqCvCsX6+kdZUCU1EQsN2nUpsOQLQZLnmMn7YODnxkVMeKc4eJoQFTQ
	PapP89BRIAw7RZzUQors8SGzFo4cDkqHeh2PoGhDt
X-Gm-Gg: AYBFou3dYaVo3DojjzIpCwLTAh1vgQwnEgLg8RIyFGfIt052i08Pib8VjGTYC+wQDGL
	JOWOgoRUFBUjveX74hT7+EttM1OvGa3fB9wRGdQbzPR0VOZIxAE99zqbmu8r4/YQ/1rzG9CDbZp
	2Ucsff0wR2TEGoZABjHj5gG3SnGT21Ca6pv9QiAkzd3Yly38lE9ES3haSuuup48zh0vkww0BW82
	dOA1/HBt0xESoqTuNj9uLtBBOhvCYzhmOe7TfhaiHdkA0FDjiKSxOXgO5A1ctWBo7G5j+qVX3dH
	/NXJMJCWtP5XmK/hZT6siXJMrq1i84NvBRUMXCIAtnGrKFSMmYlDvINONRFwwwFNSf446CioXBw
	qugd0DscTs7ysDa/10zhtDA1DtXI=
X-Received: by 2002:a05:6a00:a90c:b0:857:727c:a1f3 with SMTP id
 d2e1a72fcca58-85ed4446f43mr8360770b3a.21.1788357354260; Wed, 02 Sep 2026
 06:55:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-0CFC.v3.20260901204856@mojatatu.com> <QDISC-0CFC.v3.20260901204856@mojatatu.com.2>
 <CANn89iJCBTSGwKK02xw0XdZRsP=2VGmJny27cdi0bnpz4aBwHg@mail.gmail.com>
 <CANn89iL+o5mdPOvRUy_vSiHxj3Kc9Wzr3HV_dGf2tsKJJNwniA@mail.gmail.com>
 <CAM0EoMnENJAY7pP9dP6pbbWnW44Ug-Ow3C=sf87pfOTwxjMdaQ@mail.gmail.com> <CANn89iLr_3Z1MTa6U9SuooU7q-Yw8nXgRb=heSvoR=uUSTJgzg@mail.gmail.com>
In-Reply-To: <CANn89iLr_3Z1MTa6U9SuooU7q-Yw8nXgRb=heSvoR=uUSTJgzg@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 2 Sep 2026 09:55:42 -0400
X-Gm-Features: AcwNN1Ws4v9UkYRayz3vT-mPBxZxcfT94vInR1hDg84Grfk8lViPb6ahDTIVL2w
Message-ID: <CAM0EoMmB+W6gkKpWD0JNXgxK8=9U9CiSrP-rEAE52KADvq-TQg@mail.gmail.com>
Subject: Re: [PATCH net v3 1/9] net/sched: fq: clamp quantum and
 initial_quantum in change path
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Victor Nogueira <victor@mojatatu.com>, Vega <vega@nebusec.ai>, 
	stable@vger.kernel.org, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Vijay Subramanian <subramanian.vijay@gmail.com>, Petr Machata <petrm@nvidia.com>, 
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 9:04=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Wed, Sep 2, 2026 at 2:40=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:
> >
> >
> > Trying to understand your concern: Are you arguing for
> > stylistic/readability improvement or robustness?
> > The only place i can see where the multiplies you describe could
> > happen is what the 709f34f7c28d patch closed. i.e this part:
> >
> > -       q->quantum              =3D 2 * psched_mtu(qdisc_dev(sch));
> > -       q->initial_quantum      =3D 10 * psched_mtu(qdisc_dev(sch));
> >
> > IIRC, you are suggesting restoring the original logic (x2 and x10) and
> > i am likely missing why that is a must do? Does it break anything?
>
> It does not break anything; it just causes a cascade of various clamps.
>
> After your patch we will have:
>
>        mtu =3D clamp_t(u32, psched_mtu(qdisc_dev(sch)), 1, 1 << 20);
>        q->quantum              =3D clamp_t(u32, 2 * mtu, 256, 1 << 20);
>        q->initial_quantum      =3D min_t(u32, 10 * mtu, 1 << 20);
>
> So @mtu is no longer the psched mtu anymore.
>
> This is fine.

The u64 variant would read cleaner for sure.  If i didnt misread you
though you are saying the current the mtu-no-longer-psched_mtu
aliasing is fine. So would it be ok to see if any other comments
spring up from says sashiko that are worth reviewing the patch before
I proceed with this? Or do you want a v4 or a followup?

cheers,
jamal
