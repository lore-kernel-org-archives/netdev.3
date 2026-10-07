Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9441B455617
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 19:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791403132; cv=pass; b=PAwynykwOAqmR6TIRpDDX+3ClbEoF0oeOfBtTEpXUdaJc0Siq1bveEkZrD75lCTJ58G5Drge3AS/5yskYYAaGAG4i8WPANVk3KaWxaYOxQ3MmeaUpHlNHAtGTHlcs2RdyduDY0oiyvAtk2NXLXAOLNt8hTvMvsMolt3zpfaDCfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791403132; c=relaxed/simple;
	bh=/Au4bQsPT/L7X3aSl3VXqi/XxxlxAElghQIfekCvvsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pgoCzutB3lmladB8/8xqVyJrY49Tb1affsFkbbNPKkJQtv+ORV+7hcWxD6PbodedIPvp+Z1oREbJbGJadIT5qwZIux0ss8cgIkXO6qUjH3L3jnGsDJxkJIVniIrDGZYQw0HKT0vm+Fc/M6p3Ya8JX/2nco6mVFbn/uZEp9WFNyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sA2D9NZB; arc=pass smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sA2D9NZB"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-3115c4451c8so3695371eec.1
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 12:58:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791403131; cv=none;
        d=google.com; s=arc-20260327;
        b=i0XR4ef5W9FKwN5NrtTvlizdV9rIFsQI0ZBh72R4GSsPQQiLUxzCtjXHjp6vthOQe8
         Ci2ARHJ9520RV0a2tQrLu22u3o/qFPlmNp8Xg1pkaUwds5ISg6vdl2QjvR/kq2wwqZur
         yW6DksY9YlNjFiEZTybs4Lt03fFVU364SzWb5T6CJt0scyzfJdnDlK2QoMTm/jF2nCsL
         w4JW1W/EhQVdGB+FI7mqaklcXObbXOQSOHoJ0361KbvoYKot/DlgocStLrjHnj7XcrFF
         upA5CEYXkeJ+u+naqjZtwweSGIfFcqT4cTiVS6Z3cmzEbbG0pyV5RlmwAcKvIICuzSfW
         g8NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8zpL7DZZ6zBvI322aBJwUTuwFfeAPVheDYwWX2xhYrA=;
        fh=EfhBrFwJnE0Lr5SA1cs72mq3vVnOJK660Fwwx9boh08=;
        b=Bma5MV+XBralgngSD/pqP1Sr8R4ZHiZpxv9czN4S4sVxf0rfMlpEZiiCWvvpfu8Pas
         VR9sMAeS6/VfpinR05C03riLsHqok4XtP1JDu3eIYYtUs6nri0OtDeufUHiw1hynFjL8
         fcK/lxOD0V+RoiSyqCDP25sIW3fcn9L8kadDGFO1cyUr3z8Pee2oXamNVh15RzcUR9xv
         K1sDsyqYi03OaFuImMDZaCYebpoAgn21qx7ZaRy6TatDYBZAMXluzQAKPshpUAHkMTjq
         75DgRbumo06PC2Ckwsm0GRqAOz93AnklHNLkNomZAOw603b3m+qgKIIRynZR4o2ySaEU
         1BcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791403131; x=1792007931; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8zpL7DZZ6zBvI322aBJwUTuwFfeAPVheDYwWX2xhYrA=;
        b=sA2D9NZBo5D/q8ulhPWOWcscOhFecMaYIdrOTyfJ1jHuENyH4GPQdyPfbU2bz53Dzo
         9JTsktZ2iuMY1Gh5A6OxfccfXgVbjl2evvJliWGUSmSJ9waTDO02LQ7ExjVEN/lttiqn
         loKVCcvXObePYT+KSOi1bsNOJQVipBca9O6rtQoXtGLed+s4HAhG/XWYsZyIVPtO4qXq
         tHgobUtRTB1aZEcUZ5zGBw4SCmhzczDdCl0bFyn2e1FBCb/oZ/Pp0k11A6UkbQv/BynK
         Di0+XarU6TdZ4o2sCZJ1BJxvS1UKKl4qDbfpMoZ05UAz6pPFSsXm27c/W2ThJDTCvk1E
         ohuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791403131; x=1792007931;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8zpL7DZZ6zBvI322aBJwUTuwFfeAPVheDYwWX2xhYrA=;
        b=X/ZPJbS4oMybClWFfLwxLImfowafHvTXlpMwcfqiSfVTRE4c6vtOTtKKYk00sUIhwC
         ix+EVp+zMzyWRgJgYnbHd4KzTfYaI5wOnh5uFxA4JP9Li7tNWWHtTNKFQOS304S53SCQ
         AJ8w2xslBNeB01Ut3oYW8SD3Zdj0k8Zpt5cdiWJmIVRy/Xj4EoCOyOiBYCI8U2Egeinp
         a44nBZs6SPnrnQ99gv5oRGTjk/g/D2gQtXdpt4L+tlsVl0frgY6WtOIkchYIkvaAkxXA
         ODUvo/5OCxE4mLy0eoCYFHPP17+NqmnpFqXZdd1blVxpYvqomX4bOtGi52aBJnwi9/k4
         9qKA==
X-Forwarded-Encrypted: i=1; AKwUvBxogar1hyebcY8SS2lAsAQUz4WFX/2yVqP0QhpjeYauaTp6/ddTaiy4Lc6dadlrY/kYcWYdEJY=@vger.kernel.org
X-Gm-Message-State: AFq9FYL2F/zxocsV0qbqbIQwpq6Xy7m8tsR4KojG9PDeasFlfnXFvZ3+
	l8iksh6wmelcB96zPXkfiv12a/K3X6syxTnWZtWcfOf823j6pX7KlFXRQRggbLmObvmPry3KJnr
	z94Rafi/oBOGV9HpJlC0ATd1weqSr5C4=
X-Gm-Gg: AYBFou1b9dwbKI5lmvq8DXEgMoYcDwfgQuNNYC40NMxSwbKgSvUN4jy/RIgOM7RjXQM
	XOwB+ECl1CGPMnFADLp17eh+9kFPwusyv6WT9Dp7XyQHVkLsA/7ZnZAy6e5TNa2vVbswj4Q0Jv9
	2pG+ZPW90pLZUUyA7iF8k5vjipdMMzbVsNBa2QBfW4qAM7DE3GoCkfbAQWkY/i9sWWXK23WlSJy
	lz1oPBu6Ft6yEimoSLh5x6QEqHZ+BihxGHqB1DB+O0mQUN/VXrlzj8qPGdjjL79qJ46d1UPD2Z7
	lfVIEOu+v29IpiCHoFL5hO+Hh/asycbYq4RZs1bYikcCZhSkQZvdj13eaJY1s0TmWVnbtrWvvWW
	VxnBdsKqZfyoNGUpkIc0DSzi072z8XUpBV5ZnBjNnpd2PXgSivGWXUE8=
X-Received: by 2002:a05:693c:2585:b0:34c:5841:3e12 with SMTP id
 5a478bee46e88-351775c0c78mr329543eec.9.1791403129595; Wed, 07 Oct 2026
 12:58:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <179138670045.80227.4002052840715926590@gmail.com>
 <179138703794.2527009.12321622169213831789@kernel.org> <CAOCBhwE_JmVTmbuzJc8SEU1ROVyrat=7K-wqTQE=Er0gUy4fLA@mail.gmail.com>
 <asahA40Bh9chMyqP@chamomile>
In-Reply-To: <asahA40Bh9chMyqP@chamomile>
From: Joas Antonio <joasantonio108@gmail.com>
Date: Wed, 7 Oct 2026 16:58:37 -0300
X-Gm-Features: AclHuK9TxB_kSB_DjJLwXQo1LRpU43iFtSm3048SpV89-JzHZTHwsKrosJWSDo8
Message-ID: <CAOCBhwFrmp1vGys=4i6Yyn2eMmMAQuxehas-fkhz4aNTRr106g@mail.gmail.com>
Subject: Re: [PATCH nf] netfilter: nf_conntrack_sip: only honour Via: port in
 original direction
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netdev-bot+sinfo@kernel.org, Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 07, 2026, Pablo Neira Ayuso wrote:
> Sorry, this cannot be nf material.
> It looks fairly theoretical to me, maybe for correctness patch? Is
> this assuming a rogue server and packet spoofing?

It assumes a rogue (or compromised) SIP peer, but no spoofing: the
peer only uses its own address in the Via: header, so any SIP server
or proxy the client talks to can do it. The effect is limited to that
peer's own flow: it can pick which port >=3D 1024 its datagrams are
delivered to on the NATed host, instead of the mapped port.

So I agree it is not urgent. I will resend it for nf-next as a
correctness fix, with how it was found in the commit message.

Thanks,
Joas


Em qua., 7 de out. de 2026 =C3=A0s 16:44, Pablo Neira Ayuso
<pablo@netfilter.org> escreveu:
>
> On Wed, Oct 07, 2026 at 12:52:19PM -0300, Joas Antonio wrote:
> > Hi,
> >
> > How the issue was discovered: manual code inspection of
> > nf_conntrack_sip.c / nf_nat_sip.c, assisted by an LLM (hence the
> > Assisted-by: tag), while auditing the conntrack helpers for
> > direction-handling issues.
> >
> > I then confirmed it at runtime on 602042bf29f6 (QEMU, arm64) with
> > client -> router -> server network namespaces, the router running
> > nft masquerade and a "sip" ct helper on udp/5060. When the server
> > sends a request with "Via: SIP/2.0/UDP <server-ip>:4444", the client
> > behind the NAT receives that request and a following plain UDP payload
> > on port 4444; with the patch applied both arrive on 5060.
>
> Sorry, this cannot be nf material.
>
> It looks fairly theoretical to me, maybe for correctness patch? Is
> this assuming a rogue server and packet spoofing?
>
> > Thanks,
> > Joas
> >
> >
> > Em qua., 7 de out. de 2026 =C3=A0s 12:30, <netdev-bot+sinfo@kernel.org>=
 escreveu:
> > >
> > > Hi!
> > >
> > > This is an automated message. This series looks like a fix, but its
> > > commit messages seem to be missing some information:
> > >
> > >  - How the issue was discovered, e.g. hit in production, hit during
> > >    development, syzbot report, manual code inspection, LLM or static
> > >    analysis tool scan.
> > >
> > > Please do not repost the series just to address the above. Instead,
> > > reply to this email with the missing information, so that reviewers
> > > can take it into account. If the series needs another revision for
> > > other reasons, please include the information in the commit messages
> > > then.
> > >
> > > The evaluation is done by an LLM so it may be wrong, if you think
> > > that is the case please reply and explain.
> >
> >
> >
> > --
> > Joas Antonio dos Santos
> > Cyber Security Specialist and Ethical Hacker
> > joasantonio108@gmail.com
> > LinkedIn



--=20
Joas Antonio dos Santos
Cyber Security Specialist and Ethical Hacker
joasantonio108@gmail.com
LinkedIn
