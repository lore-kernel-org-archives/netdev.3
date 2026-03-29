Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A6E285CAD
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 18:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774810468; cv=none; b=fTFkVEcEj1V+FAbdYKHGmsmfRIBwO7cLRai5qFVcAp3wnyqM6nfvR4gYBhxUppkshvmlrXjNMqpVZqzCI+lgAB2c/JQFtiz4h2JSxTt5I4o5/hRhnpXjY74BbvMb+dHXaXNP5jFCEF0O80sdjwg+v37mlCyWUXlgIjh0zYj2k7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774810468; c=relaxed/simple;
	bh=66KjTJzNiXmuWoSceuOnIwFQktqQGfH0rkdDPurwLKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n7h9jcIc/EEf/R4joJqSFySQ9m3H8LMJq1RwKzoi2XKoFPkFGx6jfbOD1Z3YM4H6I3tvQ7xJFoW+bTjelWDYZ3l/9f6sM6l6Df/gqVjDa13Iyn7pa5qBB8t7Qo0Tcmzb4X5wPyyUuQiW8YdH0riNdJuzXXUUUKQX3pDLmcxHz4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZMQBIWj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZMQBIWj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB8F5C2BCB2
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 18:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774810467;
	bh=66KjTJzNiXmuWoSceuOnIwFQktqQGfH0rkdDPurwLKk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nZMQBIWjozKv7/RhCABCiXhtchvW4e8zMIU4M4qKfQfUhS3ORr/4AqIPGH/5boAVZ
	 Eyy6o//wGoQfSbc3NR69UCCNJGoS2cTr597ba0t9VDfMiiXQlysciUTH6gRQ7UUWbY
	 bQVSFpIjfQ4kuAAfW9VUoSPGaf2v/hMddiZBEwqf6z5l3z8AJOYM0lcIdesLZkZICu
	 j772m8MnkGz8/kM0KrfZhAz3GV+gg7Txvqk+RhWQgoL/SS5Kb0rl0gRQ0cO15ZDh0F
	 CaE6C/TnKwqnnLP7Pb17oCk5tSI5YsPY9rLbwV1SfFtMneumqVYHblNO0sYl0PpKdj
	 fL+T1bq8oC3zg==
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-65005a8840dso2459944d50.0
        for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 11:54:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWBNERkISSZ8vPbECnKT/8mMAVamZLxb2Og6KZTmkbArf1xzMoI2168p9TIcKq8UTOzut+Fros=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxexqi0m27gpG+YddV2V5/FPmuqAzGprU7NQ294MWIVdEiumZPP
	a1Of/+wN1LANaJY5ApChwZYmDt/SyX72K/ew6wG6WDizvGIEu84iki/JgVjLjUPD1qwrViVMsmJ
	/ESuDcsXeYJ2LeqBJc05kkJ1vmZ2GJ98=
X-Received: by 2002:a05:690c:c18e:b0:79d:67bd:53f2 with SMTP id
 00721157ae682-79d67bd75aemr40153927b3.51.1774810467206; Sun, 29 Mar 2026
 11:54:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <006201dcbf63$84593aa0$8d0bafe0$@nebelreich.de>
In-Reply-To: <006201dcbf63$84593aa0$8d0bafe0$@nebelreich.de>
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 29 Mar 2026 20:54:16 +0200
X-Gmail-Original-Message-ID: <CAD++jLmVPCL6p3jcdg1y_w=Zij6oVdWTvSmQFjWLn4yRJL4g=w@mail.gmail.com>
X-Gm-Features: AQROBzBBA7NHtbwkD4nxw1mFUd50TSaoSDvNC9g2lmV_5g7RV3sq05aU7XGFQy4
Message-ID: <CAD++jLmVPCL6p3jcdg1y_w=Zij6oVdWTvSmQFjWLn4yRJL4g=w@mail.gmail.com>
Subject: Re: [BUG] net: ethernet: cortina: gemini: skb leak in gmac_rx()
 causes kernel lockup under sustained RX load
To: Andreas Haarmann-Thiemann <eitschman@nebelreich.de>
Cc: ulli.kroll@googlemail.com, netdev@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

thanks for digging into this, I have wondered why this happens for a long
time but I'm not the best net developer myself.

On Sun, Mar 29, 2026 at 12:05=E2=80=AFPM Andreas Haarmann-Thiemann
<eitschman@nebelreich.de> wrote:

> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet=
/cortina/gemini.c
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c
>
> @@ -1491,6 +1491,10 @@ static int gmac_rx(struct napi_struct *napi, int b=
udget)
>                               gpage =3D gmac_get_queue_page(geth, port, m=
apping + PAGE_SIZE);
>                               if (!gpage) {
>                                               dev_err(geth->dev, "could n=
ot find mapping\n");
> +                                             if (skb) {
> +                                                            napi_free_fr=
ags(&port->napi);
> +                                                            skb =3D NULL=
;
> +                                             }
>                                               port->stats.rx_dropped++;
>                                               continue;
>                               }

This looks right to me, can you send a proper patch, or provide your
Signed-off-by in this thread so I can create a patch from this inline code?

The kernel process requires a "certificate of origin" i.e. Signed-off-by,
described a bit down in this document:
https://docs.kernel.org/process/submitting-patches.html

Yours,
Linus Walleij
