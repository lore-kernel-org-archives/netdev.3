Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2FB3C4174
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 22:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791498255; cv=pass; b=TOAqsWbjQIysgaSdkmZeI7fckBPfwhAKdAXwJMq4iJ4Pd7o+W1fnFb5e70PLSpmDebG5SY7KRqBoz/bFkmSJXJNoly/qL16iECsFaqLOgLVL4waC/y1AdZrJwIT8VnJFx49xGOkQEqT/0RKnvvf067wNY4zmFeK8wwyY4jXw9v4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791498255; c=relaxed/simple;
	bh=d1lcpdRucLT+zX+9QkRSMu0LTTvzjFEs561pRythN+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=taWvtivStT7ckhknjmt3BPcxLSCYZ/dHij5hTJH9nEhRU61F7UMtkACWGWWwMNYl5kYrP9k30Zc+E4PckWnng7m15TtNe8ByBOOph0dzuKLkNBqIJwm6iUZ/h6s0clB6WyrcgFYpxfS1qLepivP+2rP1uSOwt0dEfooxuntXbg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nuro.ai; spf=pass smtp.mailfrom=nuro.ai; dkim=pass (2048-bit key) header.d=nuro.ai header.i=@nuro.ai header.b=hJ9Tau22; arc=pass smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nuro.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuro.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuro.ai header.i=@nuro.ai header.b="hJ9Tau22"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-30b6dad2382so8128499eec.0
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 15:24:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791498253; cv=none;
        d=google.com; s=arc-20260327;
        b=oo4PZpXcuyXKZC07X6YJLLWBj6YjllEQaqGvU4WbbdI+EY4AgXIPV/AbDzBUSZQQAs
         1Dty8n/ENGN64Vi5NMRpH0vc86+6/6EdsrPMYuzB4yZrMEhapMAVBe6RMhzJGS5OR1Tm
         2fpjFptOSyFxxSTzMfQL5d9jKPPf/fdrWhv21wchE6Jq6gc6DMAszKlb7v11XSuHJmab
         tlhGQ7V9kysjNHp6LA6m2wyHL9g6hvbTkBqas62hIg69g8tcSGOhfNqVRxlx5skIJB4g
         iiyfLP+UCIMTx6nWI/UQBF2DkL7y67DFHZH1ShP8dzxNJBVRETlwBmFtonw0AgmQsQ0d
         b6qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VgKbj22kPsYva3E1zTdDL7ib6ft6rMcvOdO9YhTwC60=;
        fh=KiSU/CNFRbAD6L+iBRAN2GHSpEALPzpMHITI12cs1lU=;
        b=HGsaMNuRWITk00rPebNIt9WlcQgDIq+TAAEhPWyFXOxBsFRkaJSgi4tBxVf4nnFAm3
         hChKbAIid71RuBnYMpTlTBoW9JNmjWcOdhMoQtsQXOULKYpRHRawoTj1Q8JSxNAaIjpW
         xZFBInucAzfnUz6pDooev6IIYYekNvtEt5lRrlm2mWhEKGP1atI+ziYpR1DzAATi3Q0w
         GF1cFg5n21pfT40fvLoB+HXZvFBPsLf0fUmAw0z7AwAMvEOZoeUad1dVrpvR3vW13MaA
         R3JsjiFo1uDQBsDUsGnRd8K5GYx3f6ew6Xt2E2oXxosrBLwp7WFycJQg/KaLcZHDfDRp
         0DRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nuro.ai; s=google; t=1791498253; x=1792103053; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VgKbj22kPsYva3E1zTdDL7ib6ft6rMcvOdO9YhTwC60=;
        b=hJ9Tau22LIGbTDDwaGvy8yMQmviGWaiZO+NzIlIrsVtEYD9fH5vxo3NwWIUUvdnFH0
         99LN8recAn48UVJiNVBd+swympPOeO0ayyR1bSuh96ZRnoMs2oQzsjfOiNDMwke6P1Lh
         v4xsb0fMSNGTqQ7W/eoidsfECL2rmp5ynELEWYEceZFMWO7DA8RmBsLdVJy78FLbEsQE
         4TLxmOeRxbHrU6xApFLPFXGM3+91WRV5K5lU2LIvyE/h//MGcvL6dhQO1FlAHbsI8zda
         0RTORDbAmdXkdXyQJ/xnTultscoDF2IB0pFPSVHIfK3BUoIc0v2aSnJPw9hf5JuBQolC
         Q7Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791498253; x=1792103053;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VgKbj22kPsYva3E1zTdDL7ib6ft6rMcvOdO9YhTwC60=;
        b=uy7QzVmNr9DRjoejrFsBLQvvuuLFeeTCZIngrAMm/NTp0adE0Fmqz2v9mBgMveZNmB
         9uhfj5aTVm5e2sDMn2bhc1diBV8rBDTr02ANEh7/X71pj16s52tdLTTFakQBKU7nxv55
         10U8fZT2Hiz5RH2uwsb5AQrJk5h1aWenk18kEnfArhsDjhc6QyUPGyscP9wl0qrj65tN
         y0STRAnnBjO6Dg4EozwzLynTSXuZuX6MTOGYNj4RLk2+MQbog7AiXHcUnhx1ZVGl9mdu
         Vo2mbmvTIgyPfSGUseameNAyvkSJ14AYInddctmKVbTujGVg5UujHxXws3JojEp7Dio0
         K4hw==
X-Gm-Message-State: AFq9FYIzxMD5F2sUaOsYFcApX2vxQDiaMaLpJVPufdoamar1Mum4Ycqo
	WOA2S5Wxxo1ED0VIrUzNlsU5YeyEY75ldERahV5WfszVlWXptOOrSSzGFxktAyn5BBYuBXMECG3
	Umkj27C9B0IUdRaR1U43tdU+skLeLKQdeZGEwsg9Mhg==
X-Gm-Gg: AYBFou3rDYRLG2poicYNejWyk1tmmBWI+xS77soDB3jNfnYlNzRwv6kuPiF+l2FHdWk
	wUcdY3Zdee+cOcvmaoLqxEpe5EsxzUxWXkKyzpY4JX1IEeFOTMKv2O3rqiNvd/jq1RXZwt5hyAD
	KYZ3PP4lGx6nCciZZILjHn1oiupKXD/KxJkMTFHbd908DBaJr4yD1/bvtsHaiH422JhnczEHd7d
	3dQW/zULFZsf+sAcEYyHhFiwIV23+SBRLH9PNTztZbQ8NREjOhCEJywRUFMnx++8WgJwHI/YhUi
	Po0bHl4uFEvp5lyC6HJpQWCpu9NCWyHjmb33LVA7kxbsKa0Mq1AHICk=
X-Received: by 2002:a05:7300:cc98:b0:351:5112:ec4b with SMTP id
 5a478bee46e88-3537dedab3bmr317634eec.2.1791498252636; Thu, 08 Oct 2026
 15:24:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008220256.1844072-1-jkain@nuro.ai> <179149781385.2527009.3611488194198236417@kernel.org>
 <CA+Y90PgfrfJa2057FwbW5=9LRBOqh0EwgWW9kPqynWoFhp7-Fg@mail.gmail.com>
In-Reply-To: <CA+Y90PgfrfJa2057FwbW5=9LRBOqh0EwgWW9kPqynWoFhp7-Fg@mail.gmail.com>
From: Joseph Kain <jkain@nuro.ai>
Date: Thu, 8 Oct 2026 15:24:01 -0700
X-Gm-Features: AclHuK-cuP2aiKd6yjMguJrW4Z2QQ8a2uy7mHgXLL-CViqgagADPN7FV_yLG17s
Message-ID: <CA+Y90Piue3DGh5tMSSaCs32q9u8b0bHLruiuz0MpSpbkWTw-3g@mail.gmail.com>
Subject: Re: [PATCH net v2] net: do not let defer_count outlive an empty defer_list
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, edumazet@kernel.org, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, bigeasy@linutronix.de, 
	clrkwllms@kernel.org, rostedt@goodmis.org, linux-rt-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 8, 2026 at 3:23=E2=80=AFPM Joseph Kain <jkain@nuro.ai> wrote:
>
> On Thu, Oct 8, 2026 at 3:16=E2=80=AFPM <netdev-bot+sinfo@kernel.org> wrot=
e:
> >
> > Hi!
> >
> > This is an automated message. This series looks like a fix, but its
> > commit messages seem to be missing some information:
> >
> >  - How the issue was discovered, e.g. hit in production, hit during
> >    development, syzbot report, manual code inspection, LLM or static
> >    analysis tool scan.
>
>   Manual code inspection, LLM-assisted, during a backport -- not hit in
>   production.  I hit the heavy contention on sd->defer_lock in
> production and had Claude Opus


assess backporting.  In the process it found this issue.

>
>
> >
> > Please do not repost the series just to address the above. Instead,
> > reply to this email with the missing information, so that reviewers
> > can take it into account. If the series needs another revision for
> > other reasons, please include the information in the commit messages
> > then.
> >
> > The evaluation is done by an LLM so it may be wrong, if you think
> > that is the case please reply and explain.



--=20
Thanks,
Joseph Kain
