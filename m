Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE0F380FCC
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 22:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787436903; cv=pass; b=oCTzKHEstlFPTCsUzDpzHvu3tm9fut/m37Ij+R4F8zUITKAVzIcrR6v4Zo83eFtoJZ6X+z9VW5zDYJQ5PdFLz2I7c1SXMNiZizWMBd3SH87cDHq7uG9oeNNPkATTsmIVy0BFcllyVhnKguO+ZPLDxczjaz1HU3Hiakl9wS3W9eQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787436903; c=relaxed/simple;
	bh=PIQiv4rYFC/YQmUvgpMaekv5c+4Q/IQ4ibbjWN0O0uI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CG1XUN3kPltMJ3qb6O1LLwUr4bsxLr+/iF9BdCCcEtIlUBzdb7Rp4uGPRCwF8+5F4dyQKkOtKOyf9eigNz5KlYcllXR6gfudooSmi54a6hUH3CQKOa9xGVifSxFP+Kmohred0+SyuOfDSO05oBNSLUvH33eE5sSzDaAHhwV6oSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=ekdYeghC; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="ekdYeghC"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-848743155bcso760807b3a.0
        for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 15:15:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787436901; cv=none;
        d=google.com; s=arc-20260327;
        b=ZQV8vwRHgx0aUFIiJTpSRL1hTJJsgZqxxKMNcH52qV7yhf6EZSdNQBjKP0ZeS3w4MM
         0Mp9SalvR8PMWuOZNKrq1SBLEgPS+0zZ8eJC/8RhKk/7UgZwbADCBzRYj63kZaMje2JS
         hAefgKyLmHG0YlcN1eqH8FKHHCEJVNOYqGMPAF/RIyakoRYoCgm3aQqbRnAGbM8YzYhO
         LV59tfQSVYgQDO/oa8WTTSNCikRpNS+hTMuSkm0MI18z4UN4HftjKTuzgl9EUIkI+8u4
         qJJHWYoRVOYbdOcufyrFt5Tmzc+7VHoZwviAJOAUbg6c5I05VldnyJGfh/+aTlZoxTXw
         w5sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9zdfLpdOOImhuOxfbPERCPpDH67KNJb3cbtZdAHIvCQ=;
        fh=4N5FssHd/Gfyz1e29NYp9PS4UyorIoqzPqGhCOG7doY=;
        b=NMrma16vCwqkdULZlf+hGBRFTg67dCnaJz/32Exo7jjMjGz7ATxQoTs92RG6Q7IXT3
         rmHvwG8p+8zYolZQ8vJOloSSnGx63AKlJb1R+WryRhq2IemeQX8jjicUrvx6dqE36/aV
         gcNjFDbXB+rT63IHDQTJB9SqhXNuT4emdS8NgJ10UqXsXR8+pyx4a2hMHdvwBKDC8eKa
         FiHqe+dLJe2q7ariIRutAURS3g7/Tz4b4952qk99ZuceIdaDR0K88O7OZCpOLg9/wPhp
         rh5Vt7AGR/65rVYT4ssDnSe9UsA7ojgl7UjYWBDcvEaOOIxCt8pe3iMh3DdUpYt0NxmX
         vDIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787436901; x=1788041701; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9zdfLpdOOImhuOxfbPERCPpDH67KNJb3cbtZdAHIvCQ=;
        b=ekdYeghCRG60najTT/WFTNvsvOyPhbhYg7SBvrZOZChhs8T4+NmNjp/uO5UVqDSev8
         M9hLFK1suweoo87rB3uqqDpiC22pm3PCTexPtaLVQBTwPbgzq4S8142cFf2lfzXZB6+N
         jQVzGksbN+rd8GaZ06aqjGhpRvnop91ItnXLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787436901; x=1788041701;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9zdfLpdOOImhuOxfbPERCPpDH67KNJb3cbtZdAHIvCQ=;
        b=Eb0K0JOEcMgfeC6WxTjUU2CCSuoSTRwtW0GeGgSIaK2MjNnxITmAgRI4tPL6yCyTT5
         kONJdFa5XG55DP1458lNacXNFFi6dnXA0unQw5oClnBrvdIg8JIxXD071FcpcJPouIJk
         ewTqmq6hJ3dG5H8p8XSty837qLo4jhUgGtuUzvn68gnn9ExDu2i/Vm/RHG917GVr2Av2
         YUBM6WfdyYABndCUU+TR+WGC5WVTGAIEaqVUAmZisMUk0vSc4f5INxrWuqbV1xyW11h7
         001pMhJu3gaKqvA7VvIG0VqnYuskGvnnnqoDb6wLLFkWs27Qv2ooo3fRxp3Aqbc/c96h
         sEmA==
X-Gm-Message-State: AFuF++m0fEUJsPObS4mHrdZd1Kl00oP9F8eGluGL5U6zsqekUO3G49ar
	j0qMEUe7PnUCAHMf9iDeR7++qZ+eMKdv/V2sJSq9TMUN+vwFVNIeUqF+OAcx0vXnKeKERQJf5wm
	zPgOFZqZDYSIia8QhUkpQM2hhxy6yutPeGOBRW2+M
X-Gm-Gg: AR+sD11F8tB/Dpvz8khjismCcsZb7f8HBJ36io7VeeXjtH14FoYIfnyAu0vicp9BcHT
	tiH+i2DUMPAcOPoIDZMTtf3WAALZ84Mwc7joXdpAMEZfsP6uFrjgLzBKhoL4TzV21hAuvclfdww
	n+r54b3Matu0BwHRN8lLx1SENjIYsQf2l8cDGTzNVPIO/7F24ZhxK2KKcnFhlJJQ0f0JY2BdQKq
	++LIiob27dtNwS2+wIDVvVIc0CE2rGfl06F5QAtDYKUL9RWPM9vUsWo9Xj6lDs/sR95Zy/QbqA+
	4uAoH7YWObpVdR2/EpOxh8VU1d/8A8gJHADscdMCF6E=
X-Received: by 2002:a05:6a00:1821:b0:84e:4d6:78fe with SMTP id
 d2e1a72fcca58-851f972a7f7mr26325133b3a.3.1787436900774; Sat, 22 Aug 2026
 15:15:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820095742.68511-1-jhs@mojatatu.com> <20260822134401.6545e4eb@kernel.org>
In-Reply-To: <20260822134401.6545e4eb@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 22 Aug 2026 18:14:49 -0400
X-Gm-Features: AcwNN1UuQdiXBVyJm1U15TKSxMfOSROL1QtdvrNqRuFh2b8BQchTMpRF_8rs8n0
Message-ID: <CAM0EoMnLnc2dtzRyaJs+V6Niq=39OQ=p-XC7M+FMTQ0ctSvmyw@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net/sched: pfifo_fast: cap ring size and account
 to memcg
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, stable@vger.kernel.org, vega@nebusec.ai, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 22, 2026 at 4:44=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 20 Aug 2026 05:57:41 -0400 Jamal Hadi Salim wrote:
> > +     if (qlen > 65535) {
> > +             pr_warn_ratelimited("pfifo_fast: capping ring size %u to =
65535 for dev %s\n",
> > +                                 qlen, qdisc_dev(qdisc)->name);
> > +             qlen =3D 65535;
> > +     }
>
> Why not a hard cap?

sorry, where to put the hard cap and what would it be?
Or maybe you misspoke and intended to say "why put a hardcap"?

Or maybe in this case probably safer to just reject the change if > hard ca=
p?

cheers,
jamal

> We do that all over the place, once in a release we
> pick a value too small and someone quickly sends us a fix up to bump
> the number. No problem.
