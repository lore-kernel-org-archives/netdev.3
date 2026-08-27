Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79558342538
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 18:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787856031; cv=pass; b=Cn5c3A1dGdWXlpvD/c22TnEvX4KFRC96giTGEzyjQRdHjXtuAu0+fR+bTGfoj2UDOhkGk6tCu2YB7bGf7r+x63199SonCqe1OCe+WX3sAXdcFZU1Vh9L69CLRffvA00HhGTIDjhuMuszJzngnuJG1V2R++sc8ZoGs36hNh2rZMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787856031; c=relaxed/simple;
	bh=Ij74GLVk8iV1p9HxtVaw9mUYbGaW/88PYSKzY7YOyZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QM3Wh8IADiUQn40ubihL6OveJLq2Ct3PzWO78PoDuq1O1CDygpO5isnI/5/3rf5KKT2KXsLRHLiKiUKoFD6dXSc9CEzKTR8yx0DsxEne8WTaFjh/hcHMLiuhNgAundLgewpe1Sfgt9TmpkcrhPOVgTMEls7M6ODEbwvWvYulDCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=FJjMJI/K; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="FJjMJI/K"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-66c4e9769bdso407725d50.0
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 11:40:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787856029; cv=none;
        d=google.com; s=arc-20260327;
        b=I4MzL0IfpBTqTHP5DL66Ahcs9PIkNCjIpuwxNNpnTawcsPl+wKZfGvSnF+13rN/If3
         skS85DvdX+OctOSzYk8LfUVXX/8zT0s8B4fuG3z5G5OqpoHHsWJ/vJ6cFncHjCrxIrcC
         0Gp0FocRQg72rI4EBQEfVCYkMyy4/bX0zfbbZ9gLYaYzvVVb+mt34YqQQ7zDlo14IUj+
         wnPJ6rfrf408ptB++OmG4yNXeLVSvPQcEnnhndVVyQYvnkOZT69mLu6mv1xkKt5wcBKt
         H/7cg/WcEklskwe/1LWe/ApE7m9Kd161Q+eNkwZW9AVuDQXOSTPn5+ZIDecWY16K5vuz
         fYuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+0/wOwC4Fbtk4CvQd4/xRKB2vl8WVlSHFz+v1IPLVlw=;
        fh=JJWQL90aaaGO0XUb+t6DdVQu7h1yZwx0IGVydSKgf+8=;
        b=NIvPXFvBIO1HpV74rmCsnPv5PQJYvkpR9j7/fPxQspt89QuVn3hhdd1UkCORBMkdkb
         Sc88DGfJ5HmByR/xlLUjPwkJ4wW6kk5TSON7U2xmV+xO2azXIMbm6lkUdxxCZri75cVm
         W+nVNVvC+jdJPuTOKSdC7EUXBo4/R2jdJlKjkBwkViHr7sUjUN5ZW/THzjatqTbQW3nG
         HaibRhlE7AKx45xCIuirGNDIISK+Op5sFulQt9zDBC+Valqwsr9/Bb2DtHNz6qRP6O+J
         9o3D8JOO6t9k0AMkAZR8nfe0H1gVP2M1pDM/f7mvG54BJLNV22hotwW2PsuW1obcm7pN
         o4PQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787856029; x=1788460829; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+0/wOwC4Fbtk4CvQd4/xRKB2vl8WVlSHFz+v1IPLVlw=;
        b=FJjMJI/KPX9yD7hhqTye68VPTwTIwNoLNpCYl6kAI81CsEYop8ffByWRH5anSUwEIJ
         pyoUP4J7aICPifSjfmmAKAvb+HUurwO37RoIn+Bpm/+20z0FsGRlYmjb/V686TmIanqj
         oysXy2U3bZE4AlKK2FNdaBe+HgjjUwXCUGzD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787856029; x=1788460829;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+0/wOwC4Fbtk4CvQd4/xRKB2vl8WVlSHFz+v1IPLVlw=;
        b=AEV2rrE8eNHofT1ENyg7SOMtJFwa29y3F5ExcYClgIWgiVREnW//Zi8iWSwlmfeS/y
         0jK+2J//mlNDCqafJOjqZ7SuouxMTZL2WZ96x5pLFyn6NH/lx0IeIA00XmmtNX2Rzbt4
         PX9OqZNm3/OTXK1fz/3knRN5qIU494bSKbhPoScsguapbmWE1CG+DqlSSTeordPaRhIH
         DS+LARMAyOVly+ZNYXtadDdwPjt+XepesF3qcu5aOEhJ11BTwpw0zjOSVVyfaeoAW9Vm
         ErMbgcQgMJSJD7fuYxgGbbEwh69wcreFIZJX2uVnksrviHmBLiLsh5HvgQvsFQ8MyNq1
         CtLA==
X-Forwarded-Encrypted: i=1; AHgh+Ro9s6ncChbIILyNJRjbmLEmPpdXqWi5eFa9IulfhHoR7RyFoimmYFQWtCAIDBZ5nvYaeVtScJc=@vger.kernel.org
X-Gm-Message-State: AFuF++kRrU8UAxzLfCph/m8dtjqu4ShgGabNNVxTFowpIbmfOpvGIALI
	Va2th0OA2/5neqJJJ9EIYPhFEUhsfqqR6E5wu53fIViz10qBHQwVWLS1HHc/kqagS6W0EzVXz2U
	feonpJ3AyBF7K4kz+gQAn7kD1lfAYmdW2llBSvccwYktsLGC+qsw=
X-Gm-Gg: AR+sD13bnZ9Vz1oef2tFA/J5z8Y80J6VJG4/Of1b1LKA9t6LsNKSrP0Pvk1IEzMWXRq
	/SZ5grEw+ZoAQWauA3GHFQuKEzn+tzSknqZH8K23BIVG8f9Zd4A+NiO/g71RcW9LNtW0AfeKKm0
	DmWOB2CdlngrxMiNDv4Z0I9cJIuy0m22XW3Q8pqroo9uW1tVXQ+9QiVKiKuy6NnCOWf7ULBzH8D
	h35FO65a2xFlMf0m9QVcIj7/jbdH8l2ViwN39aNEvkLpVlr0jEvgZyAuv5lIer3aMR9dwSjbTVK
	sV3472Ogek9ltgYydHapwctzkWFdtzNpE2k1tsMDOzysi1oUsZ7HaLUggIw=
X-Received: by 2002:a05:690e:2590:b0:66d:2e0e:ef59 with SMTP id
 956f58d0204a3-66e4c793efdmr113334d50.25.1787856029297; Thu, 27 Aug 2026
 11:40:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824153903.4143642-1-victor@mojatatu.com> <20260824153903.4143642-5-victor@mojatatu.com>
 <76fed437-dbd6-4d5f-bfbd-2c00fb745013@redhat.com>
In-Reply-To: <76fed437-dbd6-4d5f-bfbd-2c00fb745013@redhat.com>
From: Victor Nogueira <victor@mojatatu.com>
Date: Thu, 27 Aug 2026 15:40:17 -0300
X-Gm-Features: AcwNN1VT9CjSmFrh3iSwKNT4VwAbE3QYLdL1Ej55LgV9oeGMweftQLIyx1YZdxA
Message-ID: <CA+NMeC84PyhDpFJuezfGEHweEw0=BydyTieSXmfGyMzw4u7cnQ@mail.gmail.com>
Subject: Re: [PATCH net 4/4] net/sched: act_mirred: account for
 TCA_MIRRED_BLOCKID in get_fill_size
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	jhs@mojatatu.com, jiri@resnulli.us, horms@kernel.org, pctammela@mojatatu.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 6:24=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 8/24/26 5:39 PM, Victor Nogueira wrote:
> > tcf_mirred_get_fill_size() only budgets TCA_MIRRED_PARMS, but
> > tcf_mirred_dump() also emits TCA_MIRRED_BLOCKID whenever the action was
> > created with a block instead of a device. So tcf_mirred_get_fill_size i=
s
> > missing 8 bytes in its accounting.
> >
> > Fix this issue by accounting for TCA_MIRRED_BLOCKID unconditionally:
> > it costs 8 bytes for device-mirred actions and avoids having to read
> > tcfm_blockid outside tcf_lock, where a concurrent replace could change
> > it between sizing and dumping.
> >
> > Note: Dumping mirred with blocks currently works in most use cases, but
> > would break in some corner cases, for example, if there are 20 blockcas=
t
> > mirred actions in one request, each with a non-ANY hw_stats and a
> > non-zero user flag, with a listener on RTNLGRP_TC (or NLM_F_ECHO):
> >
> > budget 180 B/action -> attr_size =3D 20*180 + 24 =3D 3624
> >                     -> alloc_skb(3776) =3D 3776, tailroom exactly 3776
> > emitted 196 B/action -> 20*196 + 24 =3D 3944 > 3776
> >                      -> tca_get_fill() fails
>
> Sashiko also noted that the above should not be reachable in practice on
> top of the previous patches. If so, would it make sense to divert this
> patch to net-next with a slightly different changelog (and no fixes tag)?

Yes, I think Sashiko has a point there.
I can send this patch as a net-next patch once it reopens.

cheers,
Victor
