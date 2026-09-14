Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2CD4963C3
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 19:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789415467; cv=pass; b=u20Ih0JsqFuQ4gsKYFOjStQ/qEdOjcDfnH6O6mw3zKmQ6X0U5iLp3FJsaW+YFFekUvA4kAj1aiA7VdqzsEOMrY5alQcgedZeImBQO4KiK7rppbCHpt3mvmnQINjr+4ml5eUMQY8fW3KqKoRCpk0ZhNOhV6ld/Hgsepp/syNtgiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789415467; c=relaxed/simple;
	bh=QOnOeRnGa37ViBIa35zC5ovLVAbfRbTmEs8QCinKoCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TAM8j+vQ8eLVK5cBwrJQHp8kczBmMYRoMy73lchjJ5/BAtCDhz9Y7/nWpqJOXSjg6OyLWza/x6a98kAQEAqB9ocBwK0lUT5PBUhTXDYIZvX37wy8sSlbJ6oLVlgohujckOfm7aBxUKAN2paBZRWPAkuznIASORzXDwFf4yd7rls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BtpezNoo; arc=pass smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BtpezNoo"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cebad4adso2105874a12.1
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 12:51:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789415465; cv=none;
        d=google.com; s=arc-20260327;
        b=f+hK2beGN1Y+/jFN/CWhBV0cCyIdbbImVTI5fLtOO5E3TNCTXUCnsqzrubInTup9K+
         +zSvTEOb/evR9mJDXOFiUrk8j5j41hl3L8wLDapGTt4h3MibhOG/59WZfwefbPYptrDk
         SjFoh1u2V45Oy8g4NfcIsHbxr5mCIqgVvNRDJUtWnXd6KfdCwsSXEflh4jSF6N3yCm5x
         3aK5i4PnPjO0sQoP+Df3/m9H7PCC6gso/LGcsEdO+jJcY8+ZlBc5tefWGUMdHy12WalO
         bb0K8V2e/XvGKtNZzt/yXUuQDWxeRqy/Uai1GbHVHccpufdWTL71ptRcdC1vLtdLGswR
         78oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kO+COyVynF86QFCnzCKJO2bXl/nmlPUY5lN3yUs1r+w=;
        fh=AkLC01gFbBvTym1K8Ima7H8SyvroUINP3+OiJWEx9IA=;
        b=iD6TL6W6/kxq3PLRwqrUROmZKtPbCQreFsE5ojtQc6giQX50dqPfvFqibJFmadTEnj
         x8pvCwIykwwDlg+rsxiynnM7WZw/zQHVPgPMXdW7KCFGI9BYhQ8mb56ChVLATcqcAb2c
         leE6EwfatEqTEwPnP+QMSDXT6fXP/hp8ZF8ziJ+d65w6tSmN4VKylxGN8r6zjwfiox/L
         KnjAgWcCOG9aXlB74BnVHdOmTsjSQ215pGPph4jTZmYbYn6KfpkwTCvrcnsfEdasTLZJ
         us8XotyzdhQLpWTSGdT/2MXPtRhX9SvfOpqH9cQzF9FvLSIbGqNuA+UktYa2iLyThqQo
         dTtQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789415465; x=1790020265; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kO+COyVynF86QFCnzCKJO2bXl/nmlPUY5lN3yUs1r+w=;
        b=BtpezNooGKfMY2JzTtDlmN/C/ehRSv0y9C1i+0zqO13ywjNOt5kxtRIaTGn9TcwYMf
         5RE88VI7Y98bVovwWXX1Fsr9Zz68mAYbloAkj7gQp0Qlhb5iNjBeuQ4Z4MIq/6tfkTr/
         xUiY55Ed2QOmiIRIMv8KQVQmQyKpWa+jxAF6llAh9PsTKHTOj1rlcYEB6H2cYpTZoFND
         7hwfhKx2mGh1omP8sivwXg97MpqwzEnsnpRmOYbwejqfX5+4WoXvCssnK1RHUGnTOBA+
         lcAJqYgbJ3xQKIIT/SrDH/i3CGwIJYe+bLtzaGjtn5MPkY2FoBd9t9Pa1i8oHxUf/D+E
         X8EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789415465; x=1790020265;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kO+COyVynF86QFCnzCKJO2bXl/nmlPUY5lN3yUs1r+w=;
        b=ONahRPYpT9j2Uu0BcBBJOWDXYXVguPa273Je6UD8MdPekoom0BbJmRL0TA5sv/x0JQ
         MXhDvSmIZU/krHzFfsNsT4TWLPXpHDu6mPDyg8bFeyAKnl0hB1wyIb4Mg/2vnYnquyJg
         D0vg9hVXM14+MhN1yvFYhhj8zt2nZAea4oUAHoNqTlMqyuu5cK6zOPOMy1XbJUTmBnir
         6JnpBafKNCXFpI05U5N9vZUivZ3pwneRRv/4D6optH0laA/lR0VtfTSUWfCb3xvk3R77
         vK5vH1uKjaKW7ESpo0LBwswGSOHWUPx9R9SPT2lLv27I7FeMn9im51E9PJ8XX+UVTfhJ
         pGNw==
X-Forwarded-Encrypted: i=1; AKwUvBypS1ASQf4ncxI2x0/Wn1XhHa1T/5mgZPJlYsx/BiaWQtYFVcw6oRuWrxc6UoC9NJ7fhUyBSCw=@vger.kernel.org
X-Gm-Message-State: AFuF++n5T59bMUS1z8xaGQMw3n+OMMZ8u5LoystxcMWNyf52BeUIHkU3
	Y0Diaf83PMMuQOTGWMD6Mb/BM8V8q/TGQ7HAJ3NeZekudKldKUbHJXkBYqdkisygWT0ir3xPiIA
	Umb5NoGCV01HIOUfFFemSpy9vCIE+hO2yYnUA6jHg
X-Gm-Gg: AYBFou0zev6EpVqtOVNCBNgX6J0UX1mKmKzb65iyC7ZN3+ud0aVCB8+2+jZhaVk2X4E
	xzgN78JwFOj0ZiGPwvHD86qmdD6nAyhv9p7wt0i4Tb4BIxIwuO4JJ6n25/ihbfFLKSUhWpmJPrV
	tjISmdhrRA2KwZLTpx7V9VvvB0uij4jhWOZdgB9d3CKeun1PGc53VBhTg6JlM3/yKUlMLYSS/FO
	xPY0iSd3+pW8Jd+axPdj+lL9SFeNkrkxHCmcCcWEOpklod6UM4bS6zUkMkhUkUjR2vsnVF3WPpE
	CugMoSNhFOR4+D2C26Rk6mFWnGVXo5x1WKdBFYrvH2HDiRLFX2QXObCKBAkdpkzrUje2rSKrK25
	UA75pYlC92iDKuR3LVi7hozycJx2lCTtqJbKMu+brM7EGxki8Q2pAi5Rig+ribSlKw1oVqbPeMo
	W2y51OF3LbRcGoRE/a2e2QnY97fqOZOts=
X-Received: by 2002:a05:6a20:7288:b0:3d3:af66:9f61 with SMTP id
 adf61e73a8af0-3db4076e3edmr7597487637.27.1789415464132; Mon, 14 Sep 2026
 12:51:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911073758.2714564-1-xiaolinkui@126.com>
In-Reply-To: <20260911073758.2714564-1-xiaolinkui@126.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 14 Sep 2026 12:50:52 -0700
X-Gm-Features: AcwNN1VDum4gOlZSbg0hzDAlTLdEEBy4SOc89xunAgFU8fCHs5BPg2Oc9Kr5JrQ
Message-ID: <CAAVpQUAUAgAVutpQgMu4LjG1KOpm9Du0Kw1kbp2vHtHqQ5USZw@mail.gmail.com>
Subject: Re: [PATCH] ipv4: fib: annotate data-race around nh->nh_saddr
To: Linkui Xiao <xiaolinkui@126.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, idosch@nvidia.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linkui Xiao <xiaolinkui@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 12:38=E2=80=AFAM Linkui Xiao <xiaolinkui@126.com> w=
rote:
>
> From: Linkui Xiao <xiaolinkui@kylinos.cn>
>
> fib_select_multipath() compares nexthop_nh->nh_saddr against the flow
> source address with no lock held, while fib_info_update_nhc_saddr()
> stores a new value from another CPU as soon as the preferred source
> address of the egress device changes.
>
> Commit 195374d89368 ("ipv4: fib: annotate races around nh->nh_saddr_genid
> and nh->nh_saddr") added WRITE_ONCE() on the store side and READ_ONCE()
> in fib_result_prefsrc() after syzbot reported
>
>         BUG: KCSAN: data-race in fib_select_path / fib_select_path
>
> but it only covered that reader. fib_select_multipath(), reached from
> fib_select_path(), is a second lockless reader of nh->nh_saddr and was
> left bare.

32607a332cfe added the reader after 195374d89368.


> Annotate it as well so that the value cannot be torn or
> reloaded while the per-nexthop scores are being computed.
>
> Fixes: 195374d89368 ("ipv4: fib: annotate races around nh->nh_saddr_genid=
 and nh->nh_saddr")
> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
> ---
>  net/ipv4/fib_semantics.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
> index 7a362f2e2c2b..885c6fae5232 100644
> --- a/net/ipv4/fib_semantics.c
> +++ b/net/ipv4/fib_semantics.c
> @@ -2204,7 +2204,7 @@ void fib_select_multipath(struct fib_result *res, i=
nt hash,
>                     (use_neigh && !fib_good_nh(nexthop_nh)))
>                         continue;
>
> -               if (saddr && nexthop_nh->nh_saddr =3D=3D saddr)
> +               if (saddr && READ_ONCE(nexthop_nh->nh_saddr) =3D=3D saddr=
)
>                         nh_score +=3D 2;
>                 if (hash <=3D nh_upper_bound)
>                         nh_score++;
> --
> 2.25.1
>
