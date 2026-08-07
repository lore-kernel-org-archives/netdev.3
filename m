Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E78471CE0
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 12:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786104738; cv=pass; b=iWrr/ySW2IYYabH9QpEsK8LMhsZumSUGvdNRUhGeVmVtfjOF/ov5LoWmhx6EAyqMKFB6taszTMn/5LxVcsQOpLvqtcxTr1qhc87nfqQc5+IJTMABDuAwNPj9yiz8xkRuDUj1ZuZ1DfowSRH6lQiCLdQOizueksXEPAh4SfAEqiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786104738; c=relaxed/simple;
	bh=72MRPq5JOMjlfbZOkJgFyhhVcNCstQ1nOADgKcm3qdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LK4iFngv7TLpskUKbxa6GjP4Exfa+dyuDLMQx/Z7/GcerLD9jTIkNi0/bxjhUmwRRJ0c5g5Ne63b0glTQGlpGsiQA0u1TwTEHi76GcUtK03K1kA3lVOdyadHW+de42iY7d7+sfYgiTF9xlgIl5LbpCpRQZXnK4C+k78dXEp7v/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LXkcMt7W; arc=pass smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXkcMt7W"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-4960a66d36dso828633b6e.1
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 05:12:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786104730; cv=none;
        d=google.com; s=arc-20260327;
        b=fCeOV8PZivUaS6O/hkL1hu6Zq4wipjleaa6NeakvaJCq19BkIipJstpjE7DHnz0QyN
         yWS7kjN/dBVdYZFfVzoBZFH6RQ1shA+I2rPTszV9s0liFMXlVd4X/ufMWKc1SDqNXrWi
         /RUtt08fq+kUkPMlDyhYvNdbLKQyniBPt/3U9L+x2/VP47JVpiLvhi5eojoP/RQPSmq2
         u9RGeI/JWhTQZA9xcJxR5mFsexL2rnsVHFJByGOe6+Qg9aiPM8RQq4FYaOVb7BOzxnMV
         eYB1OkHHLHQc4Ydt3TASBF/2cMoCaRvBxTdrDMwlIh3EW5bmfAFX+VtTSyfVnKnzL7bK
         Os2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GWzjsd65EmeO4ni9bThjB+B7lbxNP8fElNaFa+A/FcY=;
        fh=odDM0uQL+V8vCuNNXJ6DO6mAMPqtA8AVRWx+sjCUS2Y=;
        b=KlQe9XOMYzLthj0zkTCcpi9Sng5HJvbzirUZQSGcLzkCAY5ypY2525zLR9IQgxbt+H
         USXyd0sfNLYnLZ2gNP8uWTzwBd2rGHw0dpqYJSpYCT9vQ7met39xHYwiIiwaiFy5TZek
         FyGfCjx7fgcOdg55oorHUma1UzqhiHPKZtFepSawb1HPNv9PdS0Ow+n1dewTnt6gwrQw
         cuZSqeDTa/kkKB0QkOPB8RpVXAdorY1azVCa73030NF9zHcL3fuF9ZhSgYv2IHEIo9GU
         SCm4cArhcmsytW/YTFcjellu7M9KXhsY49H7GIttDUQ96Cj+Y6MNcEQgnvM9+WJt/oC2
         1XXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786104730; x=1786709530; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GWzjsd65EmeO4ni9bThjB+B7lbxNP8fElNaFa+A/FcY=;
        b=LXkcMt7W0x9gNbgVzr5XNNSIG6Z5dr15orwxHaDUK+SocyEVGGHQM70bqH9XKLR/1f
         SYO/PF+PFen+juDfrznjonUYU9oxOfSLJuV1siM3Zsp1GAiVSLIIyMCjQ+iCSmSsBVf/
         Dob+nrMLaCF7dOtMwIwDatsGt+BBTyNMjQQCqusdejZiZrh7yckfk/8RdNLHkb25Dib+
         Jd2X7il6ntiDgrAewRSjWlL7gLu+SQ5Q8r2M+7T46Qn16A9bHxhzigFU4tj/n8F0K7UC
         MsNWkNuNreu14BcEPrAojgTwGSiLJ6yBlf3Sq52NBRPzG0mtAyluLBkKwAg7joQtDvcX
         r1xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786104730; x=1786709530;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GWzjsd65EmeO4ni9bThjB+B7lbxNP8fElNaFa+A/FcY=;
        b=YSgHg0e9LeHBHZnQFyy2BPsP7pPfxvzULid6UJtyzmAFrNGHYOVmRXG/y0HYWkzgp+
         zOzpMX/KnAuDXPcGdOH+aJ8wPhKS109Pj1ljQ/HOlDOIpTIMf3y7a28gyH68sO3AYw+u
         tYrxIGLtU6dz18WXtEYtoQ6q/bMHVjJyaYwZaIdkjte2uxjcXDyRHHwWyoSkMpIg1j04
         opwA64ScyoZqsYdMQ8sebm9d95iYv75my8Te1l/zdMa7UBhz7Pa8KK/koUNI/TwpBOQz
         MeFaHn2ow7ULG8G1v4tLj88wVesXvywiQJ3xz4gwjRnrK+yPp71hIpAjp9ny4vSLfFmH
         2hXQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr6UyPoAyn4BEUuGjiWeLoxHM6tfp6HIoj7ibuWT+hdXb8nfft7Eqmger4Xir+0z2SPWAivaBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO4M1lOxfUBgLKJh0nFrBOwItmbOSCevqyTGZTWGmzfHO4D+g+
	JDMTf6DEHP1TPGvaYcIgZXdjL2i8x0BWW4VfMZz2pbCjwSfcdhYxV18aTp+anY9VfWCb2SOzIo2
	Pl/A71Jw3oQVJZGfBT/WHH2iZP4SATj8=
X-Gm-Gg: AR+sD12r/iBxYWNl5W4mdvkK9IGZkkmPJgq5dnVbDPuHRcHp8VM2LEBcWccM8mg/MuJ
	s7rGxSJzmNbbDgQebpBIgNNQlXBm6p0CIl4/Mn4Pl4LTerMeuXF1g5am5Ath22hAQZ766kR1bJb
	WnA+mbMYVHQkCqRoaSxkM/ZurLsthv/9lADNyRQS2u7bwwPO0X060LpNEocjseXQe/vX8G3Yw7J
	D8vQYK9pCx+NkH/MnPAiZaaSecRwOalncg63zG97FnUj++wiZ/skKeNLbYnE3KpG2GikFKPl09G
	XbeaDa/aT7BTm+717jyJrsR0gHDXDlsepg4M3uwtpX4KIwVLmZ9zUBZqQE58
X-Received: by 2002:a05:6808:10d2:b0:4a3:f036:f3bf with SMTP id
 5614622812f47-4afadfe934cmr8207401b6e.1.1786104729806; Fri, 07 Aug 2026
 05:12:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805-netcons_ipv6-v1-0-170a35b92da1@gmail.com>
 <20260805-netcons_ipv6-v1-3-170a35b92da1@gmail.com> <anSvBeRT4vqq5uZV@gmail.com>
In-Reply-To: <anSvBeRT4vqq5uZV@gmail.com>
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Fri, 7 Aug 2026 13:11:57 +0100
X-Gm-Features: AUfX_mx2NnWfuB1D7CObmwT7erkiRW2FoJqUcyUWI_Af0jUXto2AkVcTuiUNGq8
Message-ID: <CAGSyskUbYM9tK08AsUw9TQagv4Jj2y9ioXH9OrRtAyRzHSnu7A@mail.gmail.com>
Subject: Re: [PATCH net-next 3/4] netconsole: reject enabling a target with no
 remote IP address
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 4:58=E2=80=AFPM Breno Leitao <leitao@debian.org> wro=
te:
>
> On Wed, Aug 05, 2026 at 10:33:03PM +0100, Gustavo Luiz Duarte wrote:
> > The command-line path already requires a remote address, but if a user
> > creates a dynamic target and enables it without setting a remote
> > address, we currently try sending netconsole traffic to "0.0.0.0".
> >
> > Refuse to enable a target if the remote address is unset.
> >
> > Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
> > ---
> >  drivers/net/netconsole.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> > index 070bae7b4fd7..a41b0a5ce64f 100644
> > --- a/drivers/net/netconsole.c
> > +++ b/drivers/net/netconsole.c
> > @@ -471,6 +471,12 @@ static int netcons_netpoll_setup(struct netconsole=
_target *nt)
> >       int err;
> >
> >       rtnl_lock();
> > +     if (nt->remote_ip.family =3D=3D AF_UNSPEC) {
> > +             np_err(np, "remote IP address not configured, aborting\n"=
);
> > +             err =3D -EDESTADDRREQ;
> > +             goto unlock;
> > +     }
>
> Why not doing it  before the rtnl lock?

Oh, you are right, there is no reason for holding the lock here.
Thanks for pointing it out.
I will fix it in v2.
