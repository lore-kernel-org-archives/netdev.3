Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D358430F803
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 00:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788482133; cv=pass; b=olYO9pkWjB8dtpOSKh8/DSV0bclA2+sZEVHdccSE557MHVE4vF94kpiPP7X38AAqBV1D8U8QIfu9lPSyWZniEEHSGB0gzPjH4MFa0Jt+IoYGAda8/MAztEk+bJgityX6+7CLN1pzorqePsIckmnTDoUQWZre/gKvcDUEsaovCYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788482133; c=relaxed/simple;
	bh=6mc+ysZ4PjKe5tpOOyTXrXxi9SHfqCj+f7PO2DH/4mk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A+4H+y65T+FeSYCw4NdoK2UEAuezEhswHPXRvLXR2qu8bHCTpV49Zphjs1rOSCAn3iYwfBxPzC4hyziVFWZCcIvys46d2bqEohmAitY//Ca6IO6USeRY0T2x4aK4GB+pdXoHDqhAwJwDPVYmhIKJ9Lpex0L/NDmgLRPInrT33DY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UlB8TNX8; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UlB8TNX8"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-52eaeddc837so5057961cf.2
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 17:35:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788482130; cv=none;
        d=google.com; s=arc-20260327;
        b=o6nRa1bQmlQ3ATBNjETaE5w3B0qkgaK4rhVQ+ffc8AOsKHWtUGfzbtsA/1Rt0PE+88
         vNgjMWRRBIppxGshltSeFmDNWt+m0EynSiW5lNsFdfLgkSc6tOF6cwd5u3Ap75QrKCJP
         e4VcTuFpPIVxo/UoWm9MvdputJxVUWEi+CGm23KBlmWgVo3lPE5pR2Hq1AfZH/RxN4Ol
         1XnKH0mrKbjghv0oXGpHqyPtF4c8x7QpFdP0YCZYnc754SdISB0320aSSjchpT3jT9Dn
         97RJf94EI5BbEWuT6ghLPzPTfIG2hrfaKo9UsNTyoJetTuv/TMOxwURZw8ZgE4ckNs2o
         9Adg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=frzNhQSteSDys2/ZOWWgAmq0ecP55hQGym3yBI7s6zs=;
        fh=vd+xIx97312WichqlA97VZHZOYfsn6BUFyFZ8QG+nQ4=;
        b=dqNaITeius7UE1zwQW8dcVgqepVwChgXihTErQWOF0ziiuZn+ARtANdi1J9UrwMmaO
         vSTCaoP+U8LaGNViDuwSlr9lrx/WFQUTvTlxG1cWLhcrjkYNG92848ihYFRVYB13LI2y
         4abelqgMsBn2DROApAc9Rb6Vcv1B/yWikcFpL4vc7mB/Ksmkxtyseb74wuFZm/nUgWzf
         67pl/vcTrDc3lJtV76W4V3zLu5TOFsKnA0Rd7oYYsv4YbTJwxluHJD/7heAW6Hvqkxx1
         xXMpUhqwqJFkxSJD1PyGK0YSxiMYb8x69qLyu9oTSyyntDAtjY5UX0xtlK1hBsZyQE64
         SjGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788482130; x=1789086930; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=frzNhQSteSDys2/ZOWWgAmq0ecP55hQGym3yBI7s6zs=;
        b=UlB8TNX8useah/0RCFqkgFZIV1Qir7qAm7MYNuyLColl4lHsLkJsIq9/zfuHS6zJoh
         sswmu+DyF4Bk+w+pxwK1yrGBXvUuj2ZgqamzxYJQWCuKqmp4eyasDG6cjPxB2a/JOfCQ
         OnvDSfeVB+czFqmpCPDXpNJvT5DBC8Dbah5KEdI5ATTMSUAWnWYuPPhZLHK4VV916mbN
         oefWwus63EHI9gIST2KdHqYo7nPyW5TI/AGNKe3n3pgXt9bHE9REVbiDKN4EpgeKnSi4
         HYkn+HFsJWTLGWtkHZPoz2fErSC3eCQVJ0u7+by/odEOzTq+geM9yPf2pzd7o9qbqrPd
         OcBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788482130; x=1789086930;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=frzNhQSteSDys2/ZOWWgAmq0ecP55hQGym3yBI7s6zs=;
        b=r4j2+7UdfS34vNAG+ldkADboTe2g+m/oa54vUFR+tN33b3HDg11pggBwDWoA8Ic9zb
         DSDagUVPpbiai0HLitTIz9eqikQT0egmS2zHV6JIkgJ2EV2JT0bo9MeRua9pBw/Wl78a
         hrbz23ziao8Buju+ba8YPJQ/bBl5PTtUxX48lBfZ3Dl4NFWXII25X+kRUBd5kSiAQ7b7
         5U5d64BW4/l4e7KYLilrtlpULK3dQjwHZCz/QV7MZXy6Us9bZT5JWzvWuAuh2GUCzhPC
         ejauwPrSeSl6bv4wlcLm3SNDe9yDiv0uY41l6T04UdbXDdVm9rB7r7uUcrLNv4SDy2xC
         z7qg==
X-Gm-Message-State: AFuF++k45LN1nrc3+4WOZRUGK0mzeurMVf2+AXqbpEoal6xonptoLqK8
	z/iN6uHCeIPUXwSvUEriQVqS6EFRyBuVwLK0Ebu9LoHOzxxPWZDFtweJKJWl+378Fz5J0/DanWb
	EVTrZ7u6C5Tnr7MlF1Rb4g9Q7hf0AUd/PLir2kyEg
X-Gm-Gg: AYBFou2sq9HLc84i0e73KO0e37rW78eHlvzxt61gplYBuGCxl8qX5vr9NTBjclYJvYg
	prRZSW+yI1YcJRAh3Ik5dZmQdjVSnjgBrD0U8DpzaEzl4L+eyjGZMlIfdI/Z/YbYa9exJaMIWnL
	0H54bnUY42ytMnxbpn1OFGqbKWcD9R5UDcRN7JgthUavBWto41wMf+WDjKl3GPq8MeSVObxTaGm
	j+8QHcy/NGue8T4WlbILkID9QzIxTifLHLIW6jMg7Ki8i+Ytgt1b/GAOnG2DmR1MDBI5/NE5RA+
	HwM3ajW4TbnMd9NjC0IZJyaLrxwtTRdZwqzmPs8H3GQRi0AEyi+mELF+0EIGsOZfmRnDAVgJsAg
	3c0uwKq+OXek1AsYIDcnIbWjiDqLx1kKmrSWWYl3tpghVs/aCh/8KOvbQkFSSSj/4yBYz
X-Received: by 2002:a05:622a:13d1:b0:519:89b6:78b4 with SMTP id
 d75a77b69052e-530549f8dacmr25714951cf.40.1788482128968; Thu, 03 Sep 2026
 17:35:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-1L5H.v1.20260903184552@mojatatu.com>
In-Reply-To: <QDISC-1L5H.v1.20260903184552@mojatatu.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 4 Sep 2026 02:35:17 +0200
X-Gm-Features: AcwNN1WZ6JtfBewsjSnHeZkprjED3AmjHmsOyjvG7B-1OWmURvRIgA8rmFLdJJA
Message-ID: <CANn89iKFVvFaNcZyGOxmyPbpc6ax49ZqwMWDeBAsH5dav-y-SA@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net/sched: codel: bound the dropping loop per
 dequeue call
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, 
	Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Victor Nogueira <victor@mojatatu.com>, Johannes Berg <johannes@sipsolutions.net>, 
	linux-wireless@vger.kernel.org, Vega <vega@nebusec.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 10:56=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> The CoDel control law schedules the next drop one interval/sqrt(count)
> after the previous drop, using the configured interval
> (codel_params.interval). For very small intervals the scheduled step
> rounds down to zero, so the dropping loop in codel_dequeue() never
> advances and drains the entire backlog under the qdisc lock in one
> call - an unprivileged user can trigger a soft lockup this way.
>

...

>  static bool codel_should_drop(const struct sk_buff *skb,
> @@ -156,6 +161,7 @@ static struct sk_buff *codel_dequeue(void *ctx,
>         struct sk_buff *skb =3D dequeue_func(vars, ctx);
>         codel_time_t now;
>         bool drop;
> +       unsigned int drops =3D 0;

SGTM, note that this line breaks RCT.

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks.
