Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2164120459A
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 20:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781382173; cv=pass; b=hO8H+V1mHiznex/j0l/fz2qIQvXmFf7cnX4sGVYy2zsrUqQ3Js5/uewkjrjL1lcXIVGiqnv2LHQ/bcL6E+jBnnh+4TkmxGPNE81hFL/e23XdsQzSh/mZ47SyPIG+lZ8vlotw7xbfGbE45lKtADycnSlc424/6QLKAhYj8lOcT+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781382173; c=relaxed/simple;
	bh=/R7hGtOnhRXV5FoRubKQhyHTrrE06P0Ub2xQDhOXS58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pZsfTutt6/5incL06ceIWa4i8YnRXnWp3Zjbly4tJQ/VTy6Ys+gEhUMzG6CNwB4hGEIVhFw0uOKf8+Ir4bUVghChvlpVU3aAEgT3XhLk3BI2M6qJR7peXTmNLK15lGzNSsFuS7hgPjd+ztgcOuhp2QbYWK6apogL8wGo1oYTVvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m28Pr0Jw; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m28Pr0Jw"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-bf1cdcfd6deso237188366b.3
        for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 13:22:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781382170; cv=none;
        d=google.com; s=arc-20240605;
        b=QpzXyHFVXWqBdVn0t5JF7PvMQGdJkcOgSfR8x640gHD7fSdTvjTDSd7UXIxbEzEQok
         wSSMSmWRg9a69EgBIQj8Mc0FZHJaw8cAmhvu+Tv75RsztFyw1QKVhB/dgUT511bUzlf2
         2IJ/TwLgIFMoHc2SNwqskJsLzqv7zmO8z9zdH7ZE5eVxRnbjJaoOWrddZnC+guYzaPZR
         ZDrgwxuJkHs9+Ms94k/zVberuNzQVlFbiUd2Lc7UP4g0jGYKkvZoAISqmIgjFa1bBP0V
         iRDulT3kjrrmNzov8HakcBCFnytlMcdjVpKDsHp3OOzCoTKDlpvLR60tkciZ9MBgd9Gh
         SakA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/R7hGtOnhRXV5FoRubKQhyHTrrE06P0Ub2xQDhOXS58=;
        fh=2u7/5Q//gQVnDT3RKs6NFLlKQqybqYZmY2AvGLRkY8o=;
        b=QAi2EoTzsabDoyjhnez8u7lUfPrYniliPhfVYknm2U73WtRKzV0qrUrRVAd4mu0iL7
         W/uksy7Z1Mb8uA/s2sto7orgU+JLuFgNPSSic3gNoq1K1W2VOIBYAM3FYZcVZaii5Q+2
         cXZjyQyPfQHeIUhj8CvPd65T2EEAjtie9DdkdCq8oyS2YXh1wk/P2mrdb9cxsFZtzAZY
         rI5zRvn83AFeirBkrzmtQh2SLpj4N5hPJ8yl+a4s2vGA/vooQfnlhU9FSZ+oeJBEOLiw
         GQlhljDCmvOih2w72PUtc1B02S/YyfsAKTi9/9oWlkXzB4oOr82A9LxuDwm3IuyakmTC
         ubXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781382170; x=1781986970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/R7hGtOnhRXV5FoRubKQhyHTrrE06P0Ub2xQDhOXS58=;
        b=m28Pr0Jw/FGERaDjPGA3E6nbb0g2npn6YQEmLiGRiyWaKIPLRPWio+MVsYM4FSALkV
         Z/7V+R7TJd/SG777v/GhPV2mR+SFBT8WlMyWUrDr7AkvxQOoaN3aVTxhgSMFIP4jd8le
         Ae2culJ2RL2yftyylE/k/z0BjZTxGEJzw6ZdYaNS2zs7ca6yBByg62dJQfFzpo8D+DiC
         SZxga/lT9ayJZPslSIs01hLRno1/Fe+rEt3OuGw5059b+OopNp/YeTvoorAVdFePZqqS
         mO9Rxi6+iEDE83Suc9+fJRZEZiUH2iY62M1flCvH+ABwpKr+rx4JYZeeD5HRAtoRHMRb
         jTbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781382170; x=1781986970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/R7hGtOnhRXV5FoRubKQhyHTrrE06P0Ub2xQDhOXS58=;
        b=fyYl68Ex1H30Zz1XRrYBVRUloei43uIcXwHwvVnhqAF5R5YW+PBz/i0c6bMoJMluyo
         2IQr2gaXe4nOAdgji84u7O6XlDJGFCqmkTYxdyEU5SviRht9yXG6iaFAGRBrhabNmAh1
         /2bVHPp80e+465kiA+GCMqQ2LNfdkYN1iYr3U2lkMWOVWzLQPXWPfZplv9PsYOiIlVvA
         DvQEAJX34LDCYz29iosJVWdue7ZZFbyJmEsgaRzt8hfEVSVoZdjT9jJxoiweagMkioRY
         f+G5p1+nin0jjTK1N8jA9SVwjSZg6oLExpn9fEVuE95n/PzuS7x79Wqm9XNXVFW4c6fv
         Xueg==
X-Forwarded-Encrypted: i=1; AFNElJ83qxnfC20yH6YpxkUCDs1JsRAmL4+E8w9n17p9M3KWVCgZ70g34RElmmGFeKUmdmEUsfEtJCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQG9hmbvoNNS0vyegP0A8G+rMaESvsQZdjxHKlheTVR7ZFzEMF
	fSz8fsBAfzN6l9dfQON2uoFAsQrAJ99zqmaztR7tSXn6ACfsQVo7iHYeYaY5cWycX0J4mnr7p0v
	ECc30DbKI0K4674pb7dnU2EgbQxrTAUY=
X-Gm-Gg: Acq92OG7rQHmOVEYhLhE+1ield5YgR1A+reszXVPAOWLdAq8qY7rY0Fe8u928vW/CHm
	BtJNqLuw7OnEBar7xZ+kXmZEpTaA+ptCtP6bL+ZWid2Ow52UTULVf2LGxetWCwjbQsVchKwV9X0
	kjgFOyOO/8oi5u3AvF5sSB6DeUJlwXz1Fzp+rfjDinGKyzrS9YVHugraigirQDI0rWMPHJmMP4P
	m8q9EtJpCuoOivqZDb6J4DcpBNUhhJByLomuJTAHxo73egdPL6WWsxEnD6fjDudWiSj/mo+hYS+
	y94o/nRJIwMdLXc/MhQQ4DfBPYKXJxI5ucWhIyUx
X-Received: by 2002:a17:907:6b07:b0:bf7:a616:cafa with SMTP id
 a640c23a62f3a-bfe2aaf718dmr417697366b.34.1781382170288; Sat, 13 Jun 2026
 13:22:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612-rtl8366rb-improvements-v1-0-9232286fc20c@kernel.org> <20260612-rtl8366rb-improvements-v1-2-9232286fc20c@kernel.org>
In-Reply-To: <20260612-rtl8366rb-improvements-v1-2-9232286fc20c@kernel.org>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sat, 13 Jun 2026 17:22:37 -0300
X-Gm-Features: AVVi8CdL-rwccBN70HrpisBvDySvaVim5dsmcEh9X8JzAi6UyA9NQ5YuDLG0SDI
Message-ID: <CAJq09z4OF5NLXWp1Ph5bMsZUU4h2RXeBFmi-nn8Mk8_CkK4wQw@mail.gmail.com>
Subject: Re: [PATCH net-next 2/4] net: dsa: realtek: rtl8366rb: Use DSA port iterators
To: Linus Walleij <linusw@kernel.org>
Cc: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Em sex., 12 de jun. de 2026 =C3=A0s 11:23, Linus Walleij
<linusw@kernel.org> escreveu:
>
> Instead of custom loops for intializing the ports (including the
> CPU port) use the DSA helpers dsa_switch_for_each_port() and
> dsa_switch_for_each_cpu_port() following the pattern in RTL8365MB by
> accumulatong masks for the upstream and downstream ports.
>
> This gives us similar enough code to the RTL8365MB that we
> can start using more generic rtl83xx helpers.
>
> Signed-off-by: Linus Walleij <linusw@kernel.org>

Reviewed-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
